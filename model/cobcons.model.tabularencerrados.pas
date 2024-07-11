unit cobcons.model.tabularencerrados;

//{$mode delphi}
{$mode ObjFPC}{$H+}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces, ComCtrls, ExtCtrls, Forms,
  cobcons.controller.interfaces, cobcons.model.bufferdataset,  db, DateUtils;

type

   { TModelTabularEncerrados }

   TModelTabularEncerrados = class (TInterfacedObject, iModelTabularEncerrados)
     private
       FCotacao: iControllerCotacaoMoeda;
       FEmpresa : iControllerEmpresa;
       FCotas: iControllerCota;
       FTotal: iControllerTotal;
       FTotalGrupo: iControllerTotalGrupo;
       FRnp: iControllerRnp;
       FInadimplentes: iControllerInadimplente;
       FPagamentos: iControllerPagamentos;
       FPreco: iControllerPrecoBem;
       FLimiteMinimo: Double;
       FDataLimite: TDateTime;
       FDataRef: Integer;
       FDataSep: TDateTime;
       FAndamento : TAndamento;
       FInicio: TPBMaximo;
       FPosicao: TPBPosicao;
       FLog: TAndamento;
       FDtRecSldRnp: TDate;
       FCCDev: iModelBufferDataset;
       FRsCal: iModelBufferDataset;
       FRnpBase: iModelBufferDataset;
       FTxPer: Currency;
       FSaldoDataBase: Currency;

       procedure TotalizarInadimplentes(pValor, pApreendido: Double);
       function Incluircotasrateiofuturo(Pgrupo: String): Double;
       procedure TotalizarRnp(pValor: Double);
       procedure TotalizarRateioFuturo(pValor: Double);
       function Calculasaldornp(Pgrupo, Pseq, Pcota: String; Pccdev: Imodelbufferdataset): Double;
       function Calculasaldornp31Dez21(Pgrupo, Pseq, Pcota: String): Double;
       procedure CriarDatasetCCDev;
       procedure CriarDatasetRsCal;
       procedure CriarDatasetRnpBase;
       procedure ZerarTotalizadores;
       procedure SelecionarInadimplentes;
       procedure SelecionarRnp;
       procedure CalcularRateioFuturo;
       procedure Log(pMsg: String);
       procedure CalcularParticipacoes(pDistribuir: Double);
       function RetornarVlrBemApreendido(pGrupo, pSeq, pCota: string): Double;     public
       constructor Create;
       destructor Destroy; override;
       class function New: iModelTabularEncerrados;

       function LIMITEMINIMO(aValue: Double): iModelTabularEncerrados;
       function DATALIMITE(aValue: TDateTime): iModelTabularEncerrados;
       function DATAREF(aValue: Integer): iModelTabularEncerrados;
       function DATASEP(aValue: TDateTime): iModelTabularEncerrados;
       function ANDAMENTO(aValue: TAndamento): iModelTabularEncerrados;
       function LOG(aValue: TAndamento): iModelTabularEncerrados;
       function PBINICIO(aValue: TPBMaximo): iModelTabularEncerrados;
       function PBPOSICAO(aValue: TPBPosicao): iModelTabularEncerrados;
       function RetornarSaldoDataBase: Currency;
       function CalcularSaldoRnpCota(pGrupo, pSeq, pCota: String; pCCDev: iModelBufferDataset): Double;
       function GravarAplicacaoRnp(pAgente, pTipoDoc, pHistorico: String; pDataBase: TDateTime; pValor: Double ): iModelTabularEncerrados;
       function CalcularSaldoRnpDataBase(pSaldoContabil: Double): TDataSet;
       function ResumoCalculo: TDataSet;
       procedure AtualizarSaldoRnp;
       procedure Tabular;
   end;


implementation

uses cobcons.controller.util, cobcons.controller.factory, cobcons.model.tarefa;

const
  DATA_INICIAL = '01/01/1970';



{ TModelTabularEncerrados }

procedure TModelTabularEncerrados.TotalizarInadimplentes(pValor,
  pApreendido: Double);
var
  vGrupo: Integer;
  vJuridico,
  vTotalFator,
  vMediacao: Double;
begin
  vJuridico := 0;
  vMediacao := 0;
  vTotalFator := 0;
  vGrupo := 0;
  if FCotas.SIT_COBR = 'J'
  then vJuridico := Pvalor
  else vMediacao := Pvalor;
  FTotalGrupo.RetornaGrupo(FCotas.GRUPO);
  if FTotalGrupo.DataSet.EOF
  then begin
    FTotalGrupo.GRUPO(FCotas.GRUPO)
               .REGAPLIC(FCotas.REGAPLIC)
               .DTCALC(Date)
               .DTULTASS(FCotas.ULTREU)
               .DTENCCT(FCotas.DTENCCT)
               .TXPER(FCotas.TXPER)
               .MULRESADM(0)
               .MULRESGRU(0)
               .Novo;
    vTotalFator := Incluircotasrateiofuturo(FCotas.GRUPO);
    vGrupo := 1;
  end;

  FTotalGrupo.GRUPO(FCotas.GRUPO)
             .VLRJURIDICO(vJuridico)
             .VLRMEDIACAO(vMediacao)
             .BEMAPREENDIDO(Papreendido)
             .TOTALFATOR(vTotalFator)
             .AcumularInadimplentes;

  FTotal.QTDINAGRU(vGrupo)
        .VLRJURIDICO(vJuridico)
        .VLRMEDIACAO(vMediacao)
        .BEMAPREENDIDO(Papreendido)
        .AcumularInadimplente;
end;

function TModelTabularEncerrados.Incluircotasrateiofuturo(Pgrupo: String
  ): Double;
var
  vVlrBem,
  vTotalFator: Double;
  vCotas: iControllerCota;
begin
  vTotalFator := 0;
  Log('Inadimplentes: Inicio Inclusão Rateio Futuro Grupo: '+Pgrupo);
  vCotas := TControllerFactory.New.Cota;
  vCotas.RetornaRateioFuturo(Pgrupo);
  while vCotas.TemDados do
  begin
    vVlrBem := FPreco.RetornaPrecoBemData( vCotas.BEM,
                                           vCotas.FIL_COM,
                                           vCotas.ULTREU).PRE_TABE;
    FRnp.RetornaUmRnp(vCotas.GRUPO, vCotas.SEQ, vCotas.COTA);
    if FRnp.DataSet.EOF
    then begin
      FRnp.GRUPO(vCotas.GRUPO)
          .SEQ(vCotas.SEQ)
          .COTA(vCotas.COTA)
          .PERCAMORT(vCotas.PERCPAGO)
          .VLRRNP(0)
          .VLRBEM(vVlrBem)
          .Novo;
    end;
    vTotalFator := vTotalFator + (vCotas.PERCPAGO * vVlrBem / 100);
    vCotas.Proximo;
  end;
  Log('Inadimplentes: Término Inclusão Rateio Futuro Grupo: '+Pgrupo);
  Result := vTotalFator;
end;

procedure TModelTabularEncerrados.TotalizarRnp(pValor: Double);
var
  vGrupo: Integer;
begin
  vGrupo := 0;
  FTotalGrupo.RetornaGrupo(FCotas.GRUPO);
  if FTotalGrupo.DataSet.EOF
  then begin
    FTotalGrupo.GRUPO(FCotas.GRUPO)
               .REGAPLIC(FCotas.REGAPLIC)
               .DTCALC(Date)
               .DTULTASS(FCotas.ULTREU)
               .DTENCCT(FCotas.DTENCCT)
               .TXPER(FCotas.TXPER)
               .MULRESADM(0)
               .MULRESGRU(0)
               .Novo;
    vGrupo := 1;
  end;

  FTotalGrupo.GRUPO(FCotas.GRUPO)
             .VLRRNP(Pvalor)
             .AcumularRnp;

  FTotal.QTDRNPGRU(vGrupo)
        .VLRRNP(Pvalor)
        .AcumularRnp;
end;

procedure TModelTabularEncerrados.TotalizarRateioFuturo(pValor: Double);
var
  vGrupo: Integer;
  vTotalGrupo: iControllerTotalGrupo;
begin
  vGrupo := 0;
  vTotalGrupo := TControllerFactory.New.TotalGrupo;
  vTotalGrupo.RetornaGrupo(FRnp.GRUPO);
  if vTotalGrupo.DataSet.EOF
  then begin
    vTotalGrupo.GRUPO(FRnp.GRUPO)
               .Novo;
    vGrupo := 1;
  end;

  vTotalGrupo.GRUPO(FRnp.GRUPO)
             .VLRRF(Pvalor)
             .AcumularRateioFuturo;

  FTotal.QTDRATGRU(vGrupo)
        .VLRRAT(Pvalor)
        .Acumularrateiofuturo;
end;

function TModelTabularEncerrados.Calculasaldornp(Pgrupo, Pseq, Pcota: String;
  Pccdev: Imodelbufferdataset): Double;
const
  TIPO_CORRECAO = 'CORREÇÃO';
  AGENTE = '002399';
  TIPO_DOC = 'RENDI';
  TIPO_DOC1 = 'OUTRO';
  HISTORICO = 'APLICACAO FINANCEIRA';
  HISTORICO1 = 'RECOMPOSICAO SALDOS RNP';
  ZERO = 0.009;
var
  vMov,
  vPagto,
  vCorrecao,
  vLimExi,
  vSaldo, vEstorno: Currency;
  vSaldoRecomposicao,
  vSaldo31Dez21,
  vCtAnt,
  vPcRed,
  vCtDep: Double;
  vPago,
  vPagoPorProvisao,
  vCotaNaoTemCorrecao: Boolean;
  vDataCorrecao,
  vUltimaData,
  vLimRed,
  vDtBase,
  vExpiracao: TDate;
  vEmpresa: iControllerEmpresa;
  vRendimento: iControllerPagamentos;

  procedure GravarCorrecao(pContab: TDateTime; pValor: Double);
  var
    vNumDoc: String;
  begin
    if pValor > 0
    then begin
      vNumDoc := vRendimento.RetornaDocumentoAgente(AGENTE, TIPO_DOC, HISTORICO, pContab);
      vRendimento.IncluirRendimentoRnp(AGENTE, vNumDoc, pGrupo, pSeq, pCota, pContab, pValor);
    end;
  end;

  procedure GravarRecomposicao(pValor: Double);
  var
    vNumDoc: String;
  begin
    if pValor > 0
    then begin
      vNumDoc := vRendimento.RetornaDocumentoAgente(AGENTE, TIPO_DOC1, HISTORICO1, FDtRecSldRnp);
      vRendimento.IncluirSaldoRecomposicaoRnp(AGENTE, vNumDoc, pGrupo, pSeq, pCota, FDtRecSldRnp, pValor);
    end;
  end;

  procedure IncluirDataset(pDtCtb: TDate; pTipo: String; pValor, pSaldo: Double);
  var
    vIncluiCCDev: Boolean;
  Begin
    //Log(Format('%s %s %f %f',[DateToStr(pDtCtb), pTipo, pValor, pSaldo]));
    //if (pTipo = TIPO_CORRECAO)
    //then if vCotaNaoTemCorrecao
    //then GravarCorrecao(pDtCtb, pValor);
    if Pccdev <> nil
    then begin
      vIncluiCCDev := vPagoPorProvisao;
      if not vIncluiCCDev
      then vIncluiCCDev := (vSaldoRecomposicao = 0);
      if not vIncluiCCDev
      then vIncluiCCDev := (EndOfTheDay(pDtCtb) >= EndOfTheDay(FDtRecSldRnp));
      if vIncluiCCDev
      then vIncluiCCDev := not ((EndOfTheDay(pDtCtb) = EndOfTheDay(FDtRecSldRnp) )
                           and ((pTipo = TIPO_CORRECAO) or (pTipo = 'REND RNP') ));
      if vIncluiCCDev
      then vIncluiCCDev := not ( (EndOfTheDay(pDtCtb) = EndOfTheDay(StrToDate('31/12/2021')) )
                                 and (pTipo = 'REC SLDO') );
      if vIncluiCCDev
      then begin
        if pTipo = 'REND RNP'
        then pTipo := TIPO_CORRECAO
        else if pTipo = 'REC SLDO'
        then pTipo := 'Saldo Recomposição';
        Pccdev.NovoRegistro;
        Pccdev.CAMPO('DtCtb').VALOR(pDtCtb).AtribuirValor;
        Pccdev.CAMPO('Tipo').VALOR(pTipo).AtribuirValor;
        Pccdev.CAMPO('Valor').VALOR(pValor).AtribuirValor;
        Pccdev.CAMPO('Saldo').VALOR(pSaldo).AtribuirValor;
        Pccdev.GravarRegistro;
      end;
    end;
  end;

  procedure TestarData(pDtInicio, pDtFim: TDateTime);
  begin
    if vCotaNaoTemCorrecao
    then begin
      if (FDtRecSldRnp > pDtInicio) and
         (FDtRecSldRnp <= pDtFim)
      then begin
        //vCtAnt := FCotacao.CotacaoMoeda('SELIC', pDtFim);
        //IncluirDataset(FDtRecSldRnp, 'Saldo Recomposição', vSaldoRecomposicao, vSaldoRecomposicao);
        IncluirDataset(FDtRecSldRnp, 'Saldo Recomposição', vSaldo, vSaldo);
        GravarRecomposicao(vSaldo);
        //TControllerFactory.New.RNP.GravarSaldoSiaconRnp(Pgrupo, Pseq, Pcota, vSaldo);
        //vSaldo := vSaldoRecomposicao;
        //vSaldoRecomposicao := 0;
      end;
    end;
  end;

begin

  vRendimento := TControllerFactory.New.Pagamentos;
  //vCotaNaoTemCorrecao := not vRendimento.CotaTemCorrecoes(pGrupo, pSeq, pCota);
  vEmpresa := TControllerFactory.New.Empresa.RecuperarEmpresa;
  vSaldoRecomposicao := TControllerFactory.New.RNP.GRUPO(Pgrupo).SEQ(Pseq).COTA(Pcota).RetornaSaldoInicialSiacon;
  vSaldo31Dez21 := TControllerFactory.New.RNP.SaldoRnp31Dez21(Pgrupo, Pseq, Pcota);
  vExpiracao := vEmpresa.DTRCCMPER;
  vLimExi := vEmpresa.VLLIMEXI;
  vLimRed := EndOfTheMonth(vEmpresa.DTLIMRED);
  vPcRed := (100.00 - vEmpresa.PCREDAPL) / 100;
  vSaldo := 0;
  vCtAnt := 1;
  FTxPer := 0;
  vCtDep := 1;
  vPago := False;
  vEstorno := 0;
  vPagoPorProvisao := False;

  FPagamentos.RetornaPagamentosDevolucaoCota( Pgrupo,
                                              Pseq,
                                              Pcota,
                                              StrToDate(DATA_INICIAL),
                                              FDataLimite );

  vDtBase := FPagamentos.D_VENCTO;

  vDataCorrecao := FPagamentos.DT_PAGTO;

  while FPagamentos.TemDados do
  begin
    vUltimaData := FPagamentos.DT_PAGTO;

    // para provisao de pagamentos vmov deve ser zero
    vMov := FPagamentos.F_AQUISI + FPagamentos.ADMINIST +
            FPagamentos.F_RESERV + FPagamentos.OUTROS +
            FPagamentos.MUL_JUR;

    vPagto := FPagamentos.OUTROS;

    if Pos(FPagamentos.TIPO_MOV, '92.9D.93.97') <> 0     // provisao
    then begin
      vPago := (vMov <> 0);
      vPagoPorProvisao := vPago;                         // provisao com pagamento
    end
    else if Pos(FPagamentos.TIPO_MOV, 'J2.JD.J3.J7') <> 0    // estorno da provisao
    then vPago := False
    else if Pos(FPagamentos.TIPO_MOV, '86.8D.96.99') <> 0    // pagamento
    then vPago := True
    else if Pos(FPagamentos.TIPO_MOV, 'I6.ID.J9.J6') <> 0    // estorno pagamento
    then begin
      vPagto := vEstorno;
      vPago := False;
    end
    else if FPagamentos.TIPO_MOV = '3B'  // recomposicao de saldo
    then begin
      if FPagamentos.DT_PAGTO = StrToDate('31/12/2021')
      then begin
        FPagamentos.Proximo;
        Continue;
      end;
      vSaldo := FPagamentos.OUTROS;      //  vsaldo = outros
      vPagto := 0;                       // necessario zerar vpagto
    end
    else if FPagamentos.TIPO_MOV = '88'   // pagamento comissao permanencia
    then begin
      if vSaldo <= vLimExi
      then begin
        vPagto := vSaldo * -1;
        vPago := True;
      end
      else begin
        if FPagamentos.DT_PAGTO >= FDtRecSldRnp  // recalcula com 2 %
        then vPagto := Abs(vSaldo * 2 / 100) * -1;
        if FPagamentos.DT_PAGTO >= vExpiracao        // recalcula a comis perman (5%) se
        then vPagto := Abs(vSaldo * 5 / 100) * -1;   // foi cobrada no prazo de carencia
      end;
      if FPagamentos.DT_PAGTO >= vExpiracao  // Acumula a comis perman
      then FTxPer := FTxPer + Abs(vPagto);   // cobrada no prazo de carencia
    end;

    if vSaldo >= 0
    then begin
      if vPago                 // pagamento realizado
      then begin
        vEstorno := vSaldo;
        if vPagoPorProvisao    // pagamento realizado com provisao
        then begin             // lança o saldo e baixa o pagamento
          //IncluirDataset( FPagamentos.DT_PAGTO, FPagamentos.DCTIPOMOV, Abs(vMov), Abs(vMov));
          //IncluirDataset( FPagamentos.DT_PAGTO,'PAGAMENTO',vMov,0.00);
          vSaldo := 0;
        end
        // pagamento realizado normalmente zera o saldo
        else IncluirDataset( FPagamentos.DT_PAGTO, FPagamentos.DCTIPOMOV, -vSaldo, 0.00);
        vSaldo := 0;
      end
      else begin
        if FPagamentos.DT_PAGTO = StrToDate('31/12/2021')
        then vSaldo :=  vSaldo31Dez21
        else vSaldo := vSaldo + vPagto;
        // se saldo negativo zera o saldo, encerra o calculo
        if vSaldo < 0
        then begin
          IncluirDataset( FPagamentos.DT_PAGTO, FPagamentos.DCTIPOMOV, -(vSaldo - vPagto),0.00);
          //vPago := True;
        end
        else IncluirDataset( FPagamentos.DT_PAGTO, FPagamentos.DCTIPOMOV, vPagto, vSaldo);
      end;

    end;


    //if vPago then Break;

    //if vCotaNaoTemCorrecao
    //then vCtAnt := FCotacao.CotacaoMoeda('SELIC', FPagamentos.DT_PAGTO); // comentar

    if not FPagamentos.Proximo
    then begin  // não tem mais movimentos
      //
      // NÃO CALCULA MAIS CORREÇÕES
      //
      //if vSaldo > ZERO
      //then begin
      //  vCtAnt := FCotacao.CotacaoMoeda('SELIC', FPagamentos.DT_PAGTO);
      //  while CompareDate(EndOfTheMonth(vDataCorrecao), FDataLimite) <= 0 do
      //  begin
      //    vDataCorrecao := EndOfTheMonth(vDataCorrecao);
      //    vCtDep := FCotacao.CotacaoMoeda('SELIC', vDataCorrecao);
      //    vCorrecao := (vSaldo * (vCtDep / vCtAnt )) - vSaldo;
      //    if  vDataCorrecao <= vLimRed
      //    then vCorrecao := vCorrecao * vPcRed;
      //    vSaldo := vSaldo + vCorrecao;
      //    if vCorrecao > 0
      //    then IncluirDataset( vDataCorrecao,
      //                      TIPO_CORRECAO,
      //                      //Format('CORREÇÃO %.6f',[(vCtDep / vCtAnt) * vPcRed]),
      //                      vCorrecao,
      //                      vSaldo);
      //    TestarData(vUltimaData, vDataCorrecao);
      //    vUltimaData := vDataCorrecao;
      //    vDataCorrecao := vDataCorrecao + 1;
      //    vCtAnt := vCtDep;
      //  end;
      //end
      ////vCtDep := vCotacao.CotacaoMoeda('SELIC', FDataLimite);
      ////vSaldo := vSaldo * (vCtDep / vCtAnt);
    end
    else begin
      //if vCotaNaoTemCorrecao
      //then begin
      //  while CompareDate(EndOfTheMonth(vDataCorrecao), FPagamentos.DT_PAGTO) <= 0  do
      //  begin
      //    vDataCorrecao := EndOfTheMonth(vDataCorrecao);
      //    vCtDep := FCotacao.CotacaoMoeda('SELIC', vDataCorrecao);
      //    vCorrecao := (vSaldo * (vCtDep / vCtAnt )) - vSaldo;
      //    if  vDataCorrecao <= vLimRed
      //    then vCorrecao := vCorrecao * vPcRed;
      //    if vSaldo > ZERO
      //    then begin
      //      vSaldo := vSaldo + vCorrecao;
      //      IncluirDataset( vDataCorrecao,
      //                      TIPO_CORRECAO,
      //                      //Format('CORREÇÃO %.6f',[(vCtDep / vCtAnt) * vPcRed]),
      //                      vCorrecao,
      //                      vSaldo);
      //    end;
      //    TestarData(vUltimaData, vDataCorrecao);
      //    vUltimaData := vDataCorrecao;
      //    vDataCorrecao := vDataCorrecao + 1;
      //    vCtAnt := vCtDep;
      //  end;
      //end;
      //vDataCorrecao := FPagamentos.DT_PAGTO;     // PRECISA ATUALIZAR DATA CORRECAO
      //if vCotaNaoTemCorrecao
      //then begin
      //  vCtDep := FCotacao.CotacaoMoeda('SELIC', vDataCorrecao);
      //  vCorrecao := (vSaldo * (vCtDep / vCtAnt )) - vSaldo;
      //  if  vDataCorrecao <= vLimRed
      //  then vCorrecao := vCorrecao * vPcRed;
      //  if vSaldo > ZERO
      //  then begin
      //    vSaldo := vSaldo + vCorrecao;
      //    IncluirDataset( vDataCorrecao,
      //                    TIPO_CORRECAO,
      //                    //Format('CORREÇÃO %.6f',[(vCtDep / vCtAnt) * vPcRed]),
      //                    vCorrecao,
      //                    vSaldo);
      //  end;
      //end;
      //TestarData(vUltimaData, FPagamentos.DT_PAGTO);   // PRECISA TESTARDATA
    end;

  end;
  if (vPago) or (vSaldo <= 0)
  then Result := 0
  else Result := vSaldo;
end;

function TModelTabularEncerrados.Calculasaldornp31Dez21(Pgrupo, Pseq,
  Pcota: String): Double;
var
  vSaldoInicial: Currency;
  vMov,
  vPagto,
  vLimExi,
  vSaldo, vEstorno: Currency;
  vPago: Boolean;
  vExpiracao: TDate;
  vEmpresa: iControllerEmpresa;
begin

  vEmpresa := TControllerFactory.New.Empresa.RecuperarEmpresa;
  vSaldoInicial := TControllerFactory.New.RNP.SaldoRnp31Dez21(Pgrupo, Pseq, Pcota);
  vExpiracao := vEmpresa.DTRCCMPER;
  vLimExi := vEmpresa.VLLIMEXI;
  vSaldo := vSaldoInicial;
  vEstorno := 0;
  vPago := False;

  FPagamentos.RetornaPagamentosDevolucaoCota( Pgrupo,
                                              Pseq,
                                              Pcota,
                                              StrToDate('01/01/2022'),
                                              FDataLimite );

  while FPagamentos.TemDados do
  begin

    // para provisao de pagamentos vmov deve ser zero
    vMov := FPagamentos.F_AQUISI + FPagamentos.ADMINIST +
            FPagamentos.F_RESERV + FPagamentos.OUTROS +
            FPagamentos.MUL_JUR;

    vPagto := FPagamentos.OUTROS;

    if Pos(FPagamentos.TIPO_MOV, '92.9D.93.97') <> 0     // provisao
    then vPago := (vMov <> 0)
    else if Pos(FPagamentos.TIPO_MOV, 'J2.JD.J3.J7') <> 0    // estorno da provisao
    then vPago := False
    else if Pos(FPagamentos.TIPO_MOV, '86.8D.96.99') <> 0    // pagamento
    then vPago := True
    else if Pos(FPagamentos.TIPO_MOV, 'I6.ID.J9.J6') <> 0    // estorno pagamento
    then begin
      vPagto := vEstorno;
      vPago := False;
    end
    else if FPagamentos.TIPO_MOV = '88'   // pagamento comissao permanencia
    then begin
      if vSaldo <= vLimExi
      then begin
        vPagto := vSaldo * -1;
        vPago := True;
      end
      else begin
        if FPagamentos.DT_PAGTO >= FDtRecSldRnp  // recalcula com 2 %
        then vPagto := Abs(vSaldo * 2 / 100) * -1;
        if FPagamentos.DT_PAGTO >= vExpiracao        // recalcula a comis perman (5%) se
        then vPagto := Abs(vSaldo * 5 / 100) * -1;   // foi cobrada no prazo de carencia
      end;
    end;

    if vSaldo >= 0
    then begin
      if vPago                 // pagamento realizado
      then begin
        vEstorno := vSaldo;
        vSaldo := 0;
      end
      else vSaldo := vSaldo + vPagto;
    end;

    //if vPago then Break;

    FPagamentos.Proximo;

  end;
  if (vPago) or (vSaldo <= 0)
  then Result := 0
  else Result := vSaldo;
end;

procedure TModelTabularEncerrados.CriarDatasetCCDev;
begin
  FCCDev := TModelBufferDataset.New;
  FCCDev.NovoCampo.NOME('DtCtb').TIPO(ftDateTime).AdicionarCampo;
  FCCDev.NovoCampo.NOME('Tipo').TIPO(ftString).TAMANHO(25).AdicionarCampo;
  FCCDev.NovoCampo.NOME('Valor').TIPO(ftFloat).AdicionarCampo;
  FCCDev.NovoCampo.NOME('Saldo').TIPO(ftFloat).AdicionarCampo;
  FCCDev.CriarDataset;
  FCCDev.Formatacampo('DtCtb','Data',8, taCenter,'dd/mm/yyyy');
  FCCDev.Formatacampo('Tipo', 'Tipo', 20, taLeftJustify);
  FCCDev.Formatacampo('Valor', 'Valor', 8, taRightJustify, '#,0.00');
  FCCDev.Formatacampo('Saldo', 'Saldo', 8, taRightJustify, '#,0.00');
end;

procedure TModelTabularEncerrados.CriarDatasetRsCal;
begin
  FRsCal := TModelBufferDataset.New;
  FRsCal.NovoCampo.NOME('Grupo').TIPO(ftString).TAMANHO(4).AdicionarCampo;
  FRsCal.NovoCampo.NOME('Cota').TIPO(ftString).TAMANHO(5).AdicionarCampo;
  FRsCal.NovoCampo.NOME('Reg').TIPO(ftString).TAMANHO(4).AdicionarCampo;
  FRsCal.NovoCampo.NOME('TxPer').TIPO(ftFloat).AdicionarCampo;
  FRsCal.NovoCampo.NOME('Sal2013').TIPO(ftFloat).AdicionarCampo;
  FRsCal.NovoCampo.NOME('Saldo').TIPO(ftFloat).AdicionarCampo;
  FRsCal.CriarDataset;
  FRsCal.Formatacampo('Grupo','Grupo',4, taCenter);
  FRsCal.Formatacampo('Cota', 'Cota', 5, taCenter);
  FRsCal.Formatacampo('Reg','Regulamento',4, taCenter);
  FRsCal.Formatacampo('TxPer', 'Tx Per', 8, taRightJustify, '#,0.00');
  FRsCal.Formatacampo('Sal2013', 'Sld. 03/2013', 8, taRightJustify, '#,0.00');
  FRsCal.Formatacampo('Saldo', 'Sld. 06/2021', 8, taRightJustify, '#,0.00');
end;

procedure TModelTabularEncerrados.CriarDatasetRnpBase;
begin
  FRnpBase := TModelBufferDataset.New;
  with FRnpBase do
  begin
    NovoCampo.NOME('Grupo').TIPO(ftString).TAMANHO(4).AdicionarCampo;
    NovoCampo.NOME('Seq').TIPO(ftString).TAMANHO(2).AdicionarCampo;
    NovoCampo.NOME('Cota').TIPO(ftString).TAMANHO(3).AdicionarCampo;
    NovoCampo.NOME('UltAss').TIPO(ftDateTime).AdicionarCampo;
    NovoCampo.NOME('EncCon').TIPO(ftDateTime).AdicionarCampo;
    NovoCampo.NOME('DtBase').TIPO(ftDateTime).AdicionarCampo;
    NovoCampo.NOME('SaldoAte').TIPO(ftFloat).AdicionarCampo;
    NovoCampo.NOME('SaldoDepois').TIPO(ftFloat).AdicionarCampo;
    NovoCampo.NOME('SaldoRnp').TIPO(ftFloat).AdicionarCampo;
    NovoCampo.NOME('Part').TIPO(ftFloat).AdicionarCampo;
    NovoCampo.NOME('Valor').TIPO(ftFloat).AdicionarCampo;
    CriarDataset;
    Formatacampo('Grupo','Grupo',4, taCenter);
    Formatacampo('Seq', 'Seq', 2, taCenter);
    Formatacampo('Cota', 'Cota', 3, taCenter);
    Formatacampo('UltAss','Ult.Ass.',8, taCenter,'dd/mm/yyyy');
    Formatacampo('EncCon','Enc.Con.',8, taCenter,'dd/mm/yyyy');
    Formatacampo('DtBase','Dt.Base',8, taCenter,'dd/mm/yyyy');
    Formatacampo('SaldoAte', 'SaldoAte', 8, taRightJustify, '#,0.00');
    Formatacampo('SaldoDepois', 'SaldoDepois', 8, taRightJustify, '#,0.00');
    Formatacampo('SaldoRnp', 'SaldoRnp', 8, taRightJustify, '#,0.00');
    Formatacampo('Part', 'Part', 11, taRightJustify, '#,0.00000000');
    Formatacampo('Valor', 'Valor', 8, taRightJustify, '#,0.00');
  end;
end;

constructor TModelTabularEncerrados.Create;
begin
  FEmpresa := TControllerFactory.New.Empresa.RecuperarEmpresa;
  FCotas := TControllerFactory.New.Cota;
  FTotal := TControllerFactory.New.Total;
  FTotalGrupo := TControllerFactory.New.TotalGrupo;
  FRnp := TControllerFactory.New.RNP;
  FInadimplentes := TControllerFactory.New.Inadimplente;
  FPagamentos := TControllerFactory.New.Pagamentos;
  FPreco := TControllerFactory.New.PrecoBem;
  FCotacao := TControllerFactory.New.CotacaoMoeda;
  FDtRecSldRnp := EndOfTheDay(FEmpresa.DTRECSLDRNP);
end;

destructor TModelTabularEncerrados.Destroy;
begin
  inherited Destroy;
end;

class function TModelTabularEncerrados.New: iModelTabularEncerrados;
begin
  Result := Self.Create;
end;

function TModelTabularEncerrados.LIMITEMINIMO(aValue: Double
  ): iModelTabularEncerrados;
begin
  Result := Self;
  FLimiteMinimo := Avalue;
end;

function TModelTabularEncerrados.DATALIMITE(aValue: TDateTime
  ): iModelTabularEncerrados;
var
    vUltimaCotacao: TDateTime;
begin
  Result := Self;
  //vUltimaCotacao := TControllerFactory.New.CotacaoMoeda.UltimaCotacaoMoeda('SELIC').DATA;
  //if aValue > vUltimaCotacao
  //then FDataLimite := vUltimaCotacao
  //else
    FDataLimite := aValue;
end;

function TModelTabularEncerrados.DATAREF(aValue: Integer
  ): iModelTabularEncerrados;
begin
  Result := Self;
  FDataRef := Avalue;
end;

function TModelTabularEncerrados.DATASEP(aValue: TDateTime
  ): iModelTabularEncerrados;
begin
  Result := Self;
  FDataSep := Avalue;
end;

function TModelTabularEncerrados.ANDAMENTO(aValue: TAndamento
  ): iModelTabularEncerrados;
begin
  FAndamento := Avalue;
  Result := Self;
end;

function TModelTabularEncerrados.LOG(aValue: TAndamento
  ): iModelTabularEncerrados;
begin
  FLog := Avalue;
  Result := Self;
end;

function TModelTabularEncerrados.PBINICIO(aValue: TPBMaximo
  ): iModelTabularEncerrados;
begin
  FInicio := Avalue;
  Result := Self;
end;

function TModelTabularEncerrados.PBPOSICAO(aValue: TPBPosicao
  ): iModelTabularEncerrados;
begin
  FPosicao := Avalue;
  Result := Self;
end;

function TModelTabularEncerrados.RetornarSaldoDataBase: Currency;
begin
  Result := FSaldoDataBase;
end;

function TModelTabularEncerrados.CalcularSaldoRnpCota(pGrupo, pSeq,
  pCota: String; pCCDev: iModelBufferDataset): Double;
begin
  if pCCDev = nil
  then Result := Calculasaldornp31Dez21(pGrupo, pSeq, pCota)
  else Result := Calculasaldornp(Pgrupo, Pseq, Pcota, Pccdev);
end;

function TModelTabularEncerrados.GravarAplicacaoRnp(pAgente, pTipoDoc,
  pHistorico: String; pDataBase: TDateTime; pValor: Double
  ): iModelTabularEncerrados;
var
   vDoc, vGrupo, vSeq, vCota: String;
   vAplicacao: Currency;
   vPagamentos: iControllerPagamentos;
begin
  Log('Gravando Aplicação RNP...');
  vPagamentos := TControllerFactory.New.Pagamentos;
  vDoc := vPagamentos.RetornaNovoDocumentoAgente(pAgente, pTipoDoc, pHistorico, pDataBase, pValor);
  FRnpBase.PrimeiroRegistro;
  while FRnpBase.TemDados do
  begin

    vGrupo := FRnpBase.DataSet.FieldByName('Grupo').AsString;
    vSeq   := FRnpBase.DataSet.FieldByName('Seq').AsString;
    vCota  := FRnpBase.DataSet.FieldByName('Cota').AsString;
    vAplicacao := FRnpBase.DataSet.FieldByName('Valor').AsCurrency;

    Log(Format('Gravando Aplicação Cota: %s %s %s Valor: %f',[
                   vGrupo,
                   vSeq,
                   vCota,
                   vAplicacao]));

    vPagamentos.IncluirRendimentoRnp( pAgente,
                                      vDoc,
                                      vGrupo,
                                      vSeq,
                                      vCota,
                                      pDataBase,
                                      vAplicacao );

    FRnpBase.Proximo;
  end;
  Log('Aplicação RNP gravada.');
  Result := Self;
end;

function TModelTabularEncerrados.CalcularSaldoRnpDataBase(pSaldoContabil: Double
  ): TDataSet;
var
  vVlRnp: Double;
  vDtRef: TDateTime;
  vTarefa1,
  vTarefa: TTarefaSaldoRnp;
  vNumTarefas: Integer;

  procedure IncluirDataset(pFim, pGrupo, pSeq, pCota: String; pEncct, pUltReu: TDateTime; pValor: Currency);
  begin
    if pFim = ''
    then vNumTarefas := vNumTarefas - 1
    else begin
      if FDataRef = 0
      then vDtRef := pUltReu
      else vDtRef := pEncct;
      with FRnpBase do
      begin
        NovoRegistro;
        CAMPO('Grupo').VALOR(pGrupo).AtribuirValor;
        CAMPO('Seq').VALOR(pSEQ).AtribuirValor;
        CAMPO('Cota').VALOR(pCOTA).AtribuirValor;
        CAMPO('UltAss').VALOR(pULTREU).AtribuirValor;
        CAMPO('EncCon').VALOR(pENCCT).AtribuirValor;
        CAMPO('DtBase').VALOR(FDataLimite).AtribuirValor;
        CAMPO('SaldoRnp').VALOR(pValor).AtribuirValor;
        CAMPO('Part').VALOR(0).AtribuirValor;
        CAMPO('Valor').VALOR(0).AtribuirValor;
        if vDtRef <= FDataSep
        then begin
          CAMPO('SaldoAte').VALOR(vVlRnp).AtribuirValor;
          CAMPO('SaldoDepois').VALOR(0).AtribuirValor;
        end
        else begin
          CAMPO('SaldoAte').VALOR(0).AtribuirValor;
          CAMPO('SaldoDepois').VALOR(vVlRnp).AtribuirValor;
        end;
        GravarRegistro;
        Log(Format('RNP: Cota: %s %s %s VlRnp: %f',[pGRUPO, pSEQ, pCOTA, pValor]));
        FSaldoDataBase := FSaldoDataBase + pValor;
      end;
    end;
  end;

begin

  CriarDatasetRnpBase;

  Log(Format('Calculando RNP Data Base... Saldo Contábil: %n',[pSaldoContabil]));

  vNumTarefas := 2;

  vTarefa := TTarefaSaldoRnp.Create('T0');
  vTarefa.SQL := FCotas.RetornaSaldoRNP(1,17000);
  vTarefa.DataLimite := FDataLimite;
  //vTarefa.OnShowStatus := IncluirDataset;

  vTarefa1 := TTarefaSaldoRnp.Create('T1');
  vTarefa1.SQL := FCotas.RetornaSaldoRNP(17001,170000);
  vTarefa1.DataLimite := FDataLimite;
  //vTarefa1.OnShowStatus := @IncluirDataset;

  vTarefa.Start;
  vTarefa1.Start;

  while vNumTarefas > 0 do
  begin
    // Não faz nada só está
    // aguardando as treads finalizarem
  end;

  Log('Fim Selecionando Rnp: '+FRnpBase.DataSet.RecordCount.ToString);

  CalcularParticipacoes(pSaldoContabil - FSaldoDataBase);

  FRnpBase.PrimeiroRegistro;
  Result := FRnpBase.DataSet;
end;

function TModelTabularEncerrados.ResumoCalculo: TDataSet;
var
  vSaldo31Mar2013,
  vVlRnp: Currency;
begin
  CriarDatasetRsCal;
  FAndamento('Gerando Resumo do Cálculo...');

  FCotas.RetornaRNP(FEmpresa.STGRUENCCT);
  FInicio(FCotas.Dataset.RecordCount);

  while FCotas.TemDados do
  begin

    FDataLimite := StrToDate('31/03/2013');
    vSaldo31Mar2013 := CalculaSaldoRnp( FCotas.GRUPO,
                               FCotas.SEQ,
                               FCotas.COTA, nil );

    FDataLimite := StrToDate('30/06/2021');
    vVlRnp := CalculaSaldoRnp( FCotas.GRUPO,
                               FCotas.SEQ,
                               FCotas.COTA, nil );

    Log(Format('RNP: Cota: %s %s %s VlRnp: %f',[FCotas.GRUPO, FCotas.SEQ, FCotas.COTA, vVlRnp]));

    if (vVlRnp+vSaldo31Mar2013) > 0
    then begin
      FRsCal.NovoRegistro;
      FRsCal.CAMPO('Grupo').VALOR(FCotas.GRUPO).AtribuirValor;
      FRsCal.CAMPO('Cota').VALOR(FCotas.SEQ+FCotas.COTA).AtribuirValor;
      FRsCal.CAMPO('Reg').VALOR(FCotas.REGAPLIC).AtribuirValor;
      FRsCal.CAMPO('TxPer').VALOR(FTxPer).AtribuirValor;
      FRsCal.CAMPO('Sal2013').VALOR(vSaldo31Mar2013).AtribuirValor;
      FRsCal.CAMPO('Saldo').VALOR(vVlRnp).AtribuirValor;
      FRsCal.GravarRegistro;
    end;
    FCotas.Proximo;
    FPosicao(FCotas.Dataset.RecNo);
  end;
  Log('Fim Resumo Calculo Rnp');
  Result := FRsCal.DataSet;
end;

procedure TModelTabularEncerrados.AtualizarSaldoRnp;
var
  vSaldo: Double;
  vRnp: iControllerRnp;
begin
  vRnp := TControllerFactory.New.RNP;
  FRnp.RetornaSomenteRnp;
  while FRnp.TemDados do
  begin
    vSaldo := CalculaSaldoRnp(FRnp.GRUPO, FRnp.SEQ, FRnp.COTA, nil);
    vRnp.GRUPO(FRnp.GRUPO)
        .SEQ(FRnp.SEQ)
        .COTA(FRnp.COTA)
        .VLRRNP(vSaldo)
        .GravarSaldoRnp;
    FRnp.Proximo;
  end;
  FTotalGrupo.AtualizarRnp;
  FTotal.AtualizarRnp;
end;

procedure TModelTabularEncerrados.Tabular;
begin
  Log('Inicio Zerando Totalizadores');
  ZerarTotalizadores;
  Log('Inicio Selecionando Inadimplentes');
  SelecionarInadimplentes;
  Log('Inicio Selecionando Rnp');
  SelecionarRnp;
  Log('Inicio Calculo Rateio Futuro');
  CalcularRateioFuturo;
  Log('Fim da Tabulacao');
end;

procedure TModelTabularEncerrados.ZerarTotalizadores;
begin
  FAndamento('Zerando Totalizadores...');
  if FTotal.TabelaExiste
  then FTotal.ApagaDados
  else FTotal.CriarTabela;
  FTotal.Novo;
  if FTotalGrupo.TabelaExiste
  then FTotalGrupo.ApagarDados
  else FTotalGrupo.CriarTabela;
  if FInadimplentes.TabelaExiste
  then FInadimplentes.ApagarDados
  else FInadimplentes.CriarTabela;
  if FRnp.TabelaExiste
  then FRnp.ApagarDados
  else FRnp.CriarTabela;
  if not FRnp.TabelaSaldoExiste
  then begin
    FAndamento('Criando Tabela Saldos Rnp...');
    FRnp.CriarTabelaSaldo(FDtRecSldRnp);
  end;
end;

procedure TModelTabularEncerrados.SelecionarInadimplentes;
var
  vVlBem,
  vVlApr,
  vVlFCDev,
  vVlFRDev,
  vVlBemRetomado,
  vVlDev: Double;
begin

  FAndamento('Selecionando Inadimplentes...');

  FCotas.RetornaInadimplentes(FEmpresa.STGRUENCCT, FEmpresa.FASEAJUIZ);
  FInicio(FCotas.Dataset.RecordCount);

  while FCotas.TemDados do
  begin

    vVlBem := FPreco.RetornaPrecoBemData( FCotas.BEM,
                                          FCotas.FIL_COM,
                                          FCotas.ULTREU).PRE_REAL;

    vVlFCDev := (vVlBem * FCotas.PERDEV / 100);    // devedor fdo comum
    vVlFRDev := (vVlFCDev * FCotas.P_RESERV / 100);    // devedor fdo reserva
    vVlBemRetomado := RetornarVlrBemApreendido( FCotas.GRUPO,
                                                FCotas.SEQ,
                                                FCotas.COTA);

    vVlDev := vVlFCDev + vVlFRDev + vVlBemRetomado;

    Log(Format('Inadimplentes: Cota: %s %s %s VlDev: %f',[FCotas.GRUPO, FCotas.SEQ, FCotas.COTA, vVlDev]));

    if vVlDev > FLimiteMinimo
    then begin
      //vVlApr := FPagamentos
      //              .RetornaVlrBemApreendidoCota( FCotas.GRUPO,
      //                                            FCotas.SEQ,
      //                                            FCotas.COTA);
      FInadimplentes.GRUPO(FCotas.GRUPO)
                    .SEQ(FCotas.SEQ)
                    .COTA(FCotas.COTA)
                    .DTAJUIZ(FCotas.DTAJUIZ)
                    .PERCAMORT(FCotas.PERCPAGO)
                    .VLRRECEBER(vVlDev)
                    .VLRBEM(vVlBem)
                    .BEMAPREENDIDO(vVlBemRetomado)
                    .Novo;
      TotalizarInadimplentes(vVlDev, vVlBemRetomado);
    end;
    FCotas.Proximo;
    FPosicao(FCotas.Dataset.RecNo);
  end;
  Log('Fim Selecionando Inadimplentes');
end;

procedure TModelTabularEncerrados.SelecionarRnp;
var
  vVlBem,
  vVlRnp: Double;
begin

  FAndamento('Selecionando RNP...');

  FCotas.RetornaRNP(FEmpresa.STGRUENCCT);
  FInicio(FCotas.Dataset.RecordCount);

  while FCotas.TemDados do
  begin

  //  if Pos(Fcotas.GRUPO,'0116.0130.0346.0227') = 0
    //if (Fcotas.GRUPO <> '0130')
    //then begin
    //  FCotas.Proximo;
    //  Continue;
    //end;

    vVlRnp := CalculaSaldoRnp( FCotas.GRUPO,
                               FCotas.SEQ,
                               FCotas.COTA, nil );

    Log(Format('RNP: Cota: %s %s %s VlRnp: %f',[FCotas.GRUPO, FCotas.SEQ, FCotas.COTA, vVlRnp]));

    if vVlRnp > 0
    then begin
      vVlBem := FPreco.RetornaPrecoBemData( FCotas.BEM,
                                            FCotas.FIL_COM,
                                            FCotas.ULTREU).PRE_REAL;

      if FRnp.RetornaUmRnp(FCotas.GRUPO, FCotas.SEQ, FCotas.COTA).TemDados
      then FRnp.GRUPO(FCotas.GRUPO)
               .SEQ(FCotas.SEQ)
               .COTA(FCotas.COTA)
               .PERCAMORT(FCotas.PERCPAGO)
               .VLRRNP(vVlRnp)
               .VLRBEM(vVlBem)
               .Gravar
      else FRnp.GRUPO(FCotas.GRUPO)
               .SEQ(FCotas.SEQ)
               .COTA(FCotas.COTA)
               .PERCAMORT(FCotas.PERCPAGO)
               .VLRRNP(vVlRnp)
               .VLRBEM(vVlBem)
               .Novo;
      TotalizarRnp(vVlRnp);
    end;
    FCotas.Proximo;
    FPosicao(FCotas.Dataset.RecNo);
  end;
  Log('Fim Selecionando Rnp');
end;

procedure TModelTabularEncerrados.CalcularRateioFuturo;
var
  vPcRateio,
  vRatFut: Double;
  vRnp: iControllerRnp;
begin
  FAndamento('Calculando Rateio Futuro...');
  vRnp := TControllerFactory.New.RNP;
  FTotalGrupo.ListaTodos;
  FInicio(FTotalGrupo.Dataset.RecordCount);

  while FTotalGrupo.TemDados do
  begin
    // --------------------------- Somente grupos com valor a distribuir
    if FTotalGrupo.VLINA > 0
    then begin
      Log('Rateio Futuro: Grupo: '+FTotalGrupo.GRUPO);
      FRnp.RetornaRnpGrupo(FTotalGrupo.GRUPO);
      while FRnp.TemDados do
      begin
        vPcRateio := FRnp.FATOR / FTotalGrupo.TOTALFATOR;
        vRatFut := FTotalGrupo.VLINA * vPcRateio / 100;
        vRnp.GRUPO(FRnp.GRUPO).SEQ(FRnp.SEQ).COTA(FRnp.COTA)
            .PCRATEIO(vPcRateio).RATFUT(vRatFut)
            .GravarRateioFuturo;
        TotalizarRateioFuturo(vRatFut);
        FRnp.Proximo;
      end;
    end;
    FTotalGrupo.Proximo;
    FPosicao(FTotalGrupo.Dataset.RecNo);
  end;
  Log('Fim Rateio Futuro');
end;

procedure TModelTabularEncerrados.Log(pMsg: String);
begin
  if Assigned(FLog)
  then FLog(Format('%s: %s',[FormatDateTime('dd/mm/yyyy hh:mm:ss', Now) , Pmsg]));
end;

procedure TModelTabularEncerrados.CalcularParticipacoes(pDistribuir: Double);
var
  vPart,
  vValor: Double;
begin
  Log(Format('Calculando Participações... Distribuir: %n',[pDistribuir]));
  FRnpBase.PrimeiroRegistro;
  while FRnpBase.TemDados do
  begin
    vPart := FRnpBase.DataSet.FieldByName('SaldoRnp').AsCurrency /
             FSaldoDataBase * 100;
    vValor := pDistribuir * vPart / 100;
    Log(Format('Calculando Participação: Cota: %s %s %s VPart: %n Valor: %N',[
                        FRnpBase.DataSet.FieldByName('Grupo').AsString,
                        FRnpBase.DataSet.FieldByName('Seq').AsString,
                        FRnpBase.DataSet.FieldByName('Cota').AsString,
                        vPart, vValor]));
    FRnpBase.AlteraRegistro;
    FRnpBase.CAMPO('Part').VALOR(vPart).AtribuirValor;
    FRnpBase.CAMPO('Valor').VALOR(vValor).AtribuirValor;
    FRnpBase.GravarRegistro;
    FRnpBase.Proximo;
  end;
  Log('Participações calculadas.');
end;

function TModelTabularEncerrados.RetornarVlrBemApreendido(pGrupo, pSeq,
  pCota: string): Double;
begin
  //if (pGrupo='0134') and (pCota='099') and (pSeq='00')
  //then Result := 400.00
  //else if (pGrupo='0160') and (pCota='017') and (pSeq='00')
  //then Result := 2500.00
  //else if (pGrupo='0212') and (pCota='102') and (pSeq='00')
  //then Result := 4000.00
  //else if (pGrupo='0215') and (pCota='001') and (pSeq='00')
  //then Result := 5000.00
  //else if (pGrupo='0216') and (pCota='062') and (pSeq='00')
  //then Result := 3800.00
  //else if (pGrupo='0304') and (pCota='007') and (pSeq='00')
  //then Result := 3000.00
  //else if (pGrupo='0334') and (pCota='097') and (pSeq='00')
  //then Result := 2000.00
  //else if (pGrupo='0344') and (pCota='040') and (pSeq='00')
  //then Result := 3114.00
  //else
    Result:=0;
end;

end.

