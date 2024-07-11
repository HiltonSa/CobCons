unit cobcons.model.saldodatabase;

{$mode Delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces, ComCtrls, ExtCtrls, Forms, LCLType,LCLIntf, LCLProc,
  cobcons.controller.interfaces, cobcons.model.bufferdataset, cobcons.model.tarefa, db, DateUtils;

type

   { TModelCalcularSaldoRnpDataBase }

   TModelCalcularSaldoRnpDataBase = class (TInterfacedObject, iModelSaldoRnpDataBase)
     private
       FCotas: iControllerCota;
       //FCotacao: iControllerCotacaoMoeda;
       //FEmpresa : iControllerEmpresa;
       //FTotal: iControllerTotal;
       //FTotalGrupo: iControllerTotalGrupo;
       //FRnp: iControllerRnp;
       //FInadimplentes: iControllerInadimplente;
       //FPagamentos: iControllerPagamentos;
       //FPreco: iControllerPrecoBem;
       FRnpBase: iModelBufferDataset;
       FSaldoDataBase,
       FSaldoContabil: Currency;
       FNumTarefas: Integer;
       FDataRef: Integer;
       FDataSep: TDateTime;
       FDataBase: TDateTime;
       FLog: TAndamento;

       FTarefa: TTarefaSaldoRnp;



       //FLimiteMinimo: Double;
       //FDataLimite: TDateTime;
       //FAndamento : TAndamento;
       //FInicio: TPBMaximo;
       //FPosicao: TPBPosicao;
       //FDtRecSldRnp: TDate;
       //FTxPer: Currency;

       procedure CriarDatasetRnpBase;
       procedure Log(pMsg: String);
       procedure CalcularParticipacoes(pDistribuir: Double);
       procedure IncluirDataset(pFim, pGrupo, pSeq, pCota, pNome: String; pEncct, pUltReu, pInaug: TDateTime; pValor: Currency);
       procedure FinalizandoTarefas;
     public
       constructor Create;
       destructor Destroy; override;
       class function New: iModelSaldoRnpDataBase;

       function DATABASE(aValue: TDateTime): iModelSaldoRnpDataBase;
       function DATAREF(aValue: Integer): iModelSaldoRnpDataBase;
       function DATASEP(aValue: TDateTime): iModelSaldoRnpDataBase;
       function LOG(aValue: TAndamento): iModelSaldoRnpDataBase;
       function RetornarSaldoDataBase: Currency;
       function GravarAplicacaoRnp(pAgente, pTipoDoc, pHistorico: String; pDataBase: TDateTime; pValor: Double ): iModelSaldoRnpDataBase;
       function CalcularSaldoRnpDataBase(pSaldoContabil: Double): iModelSaldoRnpDataBase;
       function Dataset: TDataSet;
   end;


implementation

uses cobcons.controller.util, cobcons.controller.factory;

{ TModelCalcularSaldoRnpDataBase }

procedure TModelCalcularSaldoRnpDataBase.CriarDatasetRnpBase;
begin
  FRnpBase := TModelBufferDataset.New;
  with FRnpBase do
  begin
    NovoCampo.NOME('Grupo').TIPO(ftString).TAMANHO(4).AdicionarCampo;
    NovoCampo.NOME('Seq').TIPO(ftString).TAMANHO(2).AdicionarCampo;
    NovoCampo.NOME('Cota').TIPO(ftString).TAMANHO(3).AdicionarCampo;
    NovoCampo.NOME('Nome').TIPO(ftString).TAMANHO(35).AdicionarCampo;
    NovoCampo.NOME('Inauguracao').TIPO(ftDateTime).AdicionarCampo;
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
    Formatacampo('Nome', 'Nome', 20, taLeftJustify);
    Formatacampo('Inauguracao','Inaug.',8, taCenter,'dd/mm/yyyy');
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

constructor TModelCalcularSaldoRnpDataBase.Create;
begin
  FCotas := TControllerFactory.New.Cota;
  FSaldoContabil := 0;
end;

destructor TModelCalcularSaldoRnpDataBase.Destroy;
begin
  inherited Destroy;
end;

class function TModelCalcularSaldoRnpDataBase.New: iModelSaldoRnpDataBase;
begin
  Result := Self.Create;
end;

function TModelCalcularSaldoRnpDataBase.DATABASE(aValue: TDateTime
  ): iModelSaldoRnpDataBase;
begin
  Result := Self;
  FDataBase := Avalue;
end;

function TModelCalcularSaldoRnpDataBase.DATAREF(aValue: Integer
  ): iModelSaldoRnpDataBase;
begin
  Result := Self;
  FDataRef := Avalue;
end;

function TModelCalcularSaldoRnpDataBase.DATASEP(aValue: TDateTime
  ): iModelSaldoRnpDataBase;
begin
  Result := Self;
  FDataSep := Avalue;
end;

function TModelCalcularSaldoRnpDataBase.LOG(aValue: TAndamento
  ): iModelSaldoRnpDataBase;
begin
  FLog := Avalue;
  Result := Self;
end;

function TModelCalcularSaldoRnpDataBase.RetornarSaldoDataBase: Currency;
begin
  Result := FSaldoDataBase;
end;

function TModelCalcularSaldoRnpDataBase.GravarAplicacaoRnp(pAgente, pTipoDoc,
  pHistorico: String; pDataBase: TDateTime; pValor: Double
  ): iModelSaldoRnpDataBase;
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

function TModelCalcularSaldoRnpDataBase.CalcularSaldoRnpDataBase(
  pSaldoContabil: Double): iModelSaldoRnpDataBase;
const
  INTERVALO = 7000;  //4250
  QTD_TAREFAS = 2;
var
  vTarefas: array[1..QTD_TAREFAS] of TTarefaSaldoRnp;
  i, vSalto: Integer;
begin
  Result := Self;
  FSaldoContabil := pSaldoContabil;

  CriarDatasetRnpBase;

  Log(Format('Calculando RNP Data Base... Saldo Contábil: %n',[pSaldoContabil]));

  FNumTarefas := Length(vTarefas);

  vSalto := 0;
  for i := Low(vTarefas) to High(vTarefas) do
  begin
    vTarefas[i] := TTarefaSaldoRnp.Create(Format('T%d',[i]));
    if Assigned(vTarefas[i].FatalException)
    then raise vTarefas[i].FatalException;
    vTarefas[i].DataLimite := FDataBase;
    vTarefas[i].OnShowStatus := IncluirDataset;
    vSalto := INTERVALO * i;
    vTarefas[i].SQL := FCotas.RetornaSaldoRNP((vSalto - INTERVALO)+1,vSalto); ;
    vTarefas[i].Start;
  end;
  //FTarefa := TTarefaSaldoRnp.Create('T0');
  //if Assigned(FTarefa.FatalException)
  //then raise FTarefa.FatalException;
  //FTarefa.SQL := FCotas.RetornaSaldoRNP(1,5000);
  //FTarefa.DataLimite := FDataBase;
  //FTarefa.OnShowStatus := IncluirDataset;
  //
  //FTarefa1 := TTarefaSaldoRnp.Create('T1');
  //if Assigned(FTarefa1.FatalException)
  //then raise FTarefa1.FatalException;
  //FTarefa1.SQL := FCotas.RetornaSaldoRNP(501,1500);
  //FTarefa1.DataLimite := FDataBase;
  //FTarefa1.OnShowStatus := IncluirDataset;

  //FTarefa2 := TTarefaSaldoRnp.Create('T2');
  //FTarefa2.SQL := FCotas.RetornaSaldoRNP(601,35000);
  //FTarefa2.DataLimite := FDataBase;
  //FTarefa2.OnShowStatus := IncluirDataset;

  //FTarefa.Start;
  //FTarefa1.Start;
  //FTarefa2.Start;

end;

function TModelCalcularSaldoRnpDataBase.Dataset: TDataSet;
begin
  FRnpBase.PrimeiroRegistro;
  Result := FRnpBase.DataSet;
end;

procedure TModelCalcularSaldoRnpDataBase.Log(pMsg: String);
begin
  if Assigned(FLog)
  then FLog(Format('%s: %s',[FormatDateTime('dd/mm/yyyy hh:mm:ss', Now) , Pmsg]));
end;

procedure TModelCalcularSaldoRnpDataBase.CalcularParticipacoes(pDistribuir: Double);
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

procedure TModelCalcularSaldoRnpDataBase.IncluirDataset(pFim, pGrupo, pSeq,
  pCota, pNome: String; pEncct, pUltReu, pInaug: TDateTime; pValor: Currency);
var
  vDtRef: TDateTime;
begin
  if pFim = 'Fim'
  then begin
    FNumTarefas := FNumTarefas - 1;
    if FNumTarefas = 0
    then FinalizandoTarefas;
  end
  else begin
    case FDataRef of
      0: vDtRef := pUltReu;
      1: vDtRef := pEncct;
      2: vDtRef := pInaug;
    end;
    if FDataRef = 0
    then
    else
    with FRnpBase do
    begin
      NovoRegistro;
      CAMPO('Grupo').VALOR(pGrupo).AtribuirValor;
      CAMPO('Seq').VALOR(pSEQ).AtribuirValor;
      CAMPO('Cota').VALOR(pCOTA).AtribuirValor;
      CAMPO('Nome').VALOR(pNome).AtribuirValor;
      CAMPO('Inauguracao').VALOR(pInaug).AtribuirValor;
      CAMPO('UltAss').VALOR(pULTREU).AtribuirValor;
      CAMPO('EncCon').VALOR(pENCCT).AtribuirValor;
      CAMPO('DtBase').VALOR(FDataBase).AtribuirValor;
      CAMPO('SaldoRnp').VALOR(pValor).AtribuirValor;
      CAMPO('Part').VALOR(0).AtribuirValor;
      CAMPO('Valor').VALOR(0).AtribuirValor;
      if vDtRef <= FDataSep
      then begin
        CAMPO('SaldoAte').VALOR(pValor).AtribuirValor;
        CAMPO('SaldoDepois').VALOR(0).AtribuirValor;
      end
      else begin
        CAMPO('SaldoAte').VALOR(0).AtribuirValor;
        CAMPO('SaldoDepois').VALOR(pValor).AtribuirValor;
      end;
      GravarRegistro;
      FSaldoDataBase := FSaldoDataBase + pValor;
      Log(Format('RNP: Cota: %s %s %s VlRnp: %f SaldoDtBase: %f',
                 [pGRUPO, pSEQ, pCOTA, pValor, FSaldoDataBase]));
    end;
  end;
end;

procedure TModelCalcularSaldoRnpDataBase.FinalizandoTarefas;
begin
  Log('Termino Selecionando Rnp: '+FRnpBase.DataSet.RecordCount.ToString);

  FRnpBase.OrdenarPorCampos('Grupo;Cota;Seq');

  CalcularParticipacoes(FSaldoContabil - FSaldoDataBase);

  Log('Fim');

  //FTarefa.Free;
  //FTarefa1.Free;
  //FTarefa2.Free;
end;

end.

