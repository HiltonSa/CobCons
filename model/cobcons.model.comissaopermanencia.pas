unit cobcons.model.comissaopermanencia;

{$mode delphi}

interface

uses
  Classes, Sysutils, Math, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, ComCtrls, ExtCtrls, Forms,
  cobcons.controller.interfaces, db;

type

   { TModelComissaoPermanencia }

   TModelComissaoPermanencia = class (TInterfacedObject, iModelComissaoPermanencia)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlComissaoPermanencia;

       FCotacao: iControllerCotacaoMoeda;
       FRnp: iControllerRnp;
       FCotas: iControllerCota;
       FPagamentos: iControllerPagamentos;
       FItens: iControllerItemComissaoPermanencia;
       FTabEnc: iControllerTabularEncerrados;

       FDataCalculo: TDateTime;
       FLog: TAndamento;
       FAgente: String;
       FTpDoc: String;
       FDoc: String;
       FHistorico: String;
       FSaldoInicial: Double;
       FComissao: Double;

       procedure Log(pMsg: String);
       function CalculaSaldoRnp(pGrupo, pSeq, pCota: String; pDataLimite: TDateTime): Double;
     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelComissaoPermanencia;

       function CriarTabela: iModelComissaoPermanencia;
       function TabelaExiste: Boolean;
       function NovaComissaoPermanencia: Integer;
       function ExcluirComissaoPermanencia(pCodigo: Integer): iModelComissaoPermanencia;
       function ListarComissoes: iModelComissaoPermanencia;
       function ListarPorCodigo(pCodigo: Integer): iModelComissaoPermanencia;
       function DataSet: TDataSet;
       function LOG(aValue: TAndamento): iModelComissaoPermanencia;
       function Datacalculo(Avalue: Tdatetime): Imodelcomissaopermanencia;
       function AGENTE(aValue: String): iModelComissaoPermanencia;
       function TPDOC(aValue: String): iModelComissaoPermanencia;
       function DOCUMENTO(aValue: String): iModelComissaoPermanencia;
       function HISTORICO(aValue: String): iModelComissaoPermanencia;
       function SALDOINICIAL: Double;
       function COMISSAO: Double;
       function SALDOFINAL: Double;
       function Calcular: TDataSet;
       procedure Gravar;
   end;


implementation

uses cobcons.controller.util, cobcons.controller.factory, cobcons.model.dm,
  cobcons.model.sql.factory;


{ TModelComissaoPermanencia }

function Tmodelcomissaopermanencia.Calculasaldornp(Pgrupo, Pseq, Pcota: String; Pdatalimite: Tdatetime): Double;
var
  vSaldo: Currency;
begin
  vSaldo := FTabEnc
                .DATALIMITE(pDataLimite)
                .CalcularSaldoRnpCota(pGrupo, pSeq, pCota, nil);
  Result := vSaldo;
end;

constructor Tmodelcomissaopermanencia.Create(Aquery: Iqueryrest);
begin
  FQuery := Aquery;
  FSQL := TModelSQLFactory.New.SqlComissaoPermanencia;
  FRnp := TControllerFactory.New.RNP;
  FCotas := TControllerFactory.New.Cota;
  FPagamentos := TControllerFactory.New.Pagamentos;
  FCotacao := TControllerFactory.New.CotacaoMoeda;
  FItens := TControllerFactory.New.ItemComissaoPermanencia;
  FTabEnc := TControllerFactory.New.TabularEncerrados;
  FSaldoInicial := 0;
  FComissao := 0;
end;

destructor Tmodelcomissaopermanencia.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelcomissaopermanencia.New(Aquery: Iqueryrest): Imodelcomissaopermanencia;
begin
  Result := Self.Create(Aquery);
end;

function Tmodelcomissaopermanencia.Criartabela: Imodelcomissaopermanencia;
begin
  Result := Self;
  FQuery.Executar(FSQL.SqlCriarTabela);
end;

function Tmodelcomissaopermanencia.Tabelaexiste: Boolean;
begin
  Result := FQuery.Open(FSQL.SqlTabelaExiste).FieldByName('QTDE').AsInteger > 0;
end;

function Tmodelcomissaopermanencia.Novacomissaopermanencia: Integer;
var
  vCod: Integer;
  vSql: String;
begin
  vCod := FQuery.Open(FSQL.SqlNovoCodigo).FieldByName('MAXCOD').AsInteger;
  if vCod = 0
  then vCod := 1;
  FormatSettings.DecimalSeparator := '.';
  vSql := Format(FSQL.SqlNovo,
          [ vCod,
            QuotedStr( RetornaDataSql(Date) ),
            FSaldoInicial,
            FComissao,
            (FSaldoInicial - FComissao),
            QuotedStr( RetornaDataSql(FDataCalculo) ),
            QuotedStr( FAgente ),
            QuotedStr( FDoc )]);
  FormatSettings.DecimalSeparator := ',';
  FQuery.Executar(vSql);
  Result := vCod;
end;

function Tmodelcomissaopermanencia.Excluircomissaopermanencia(Pcodigo: Integer): Imodelcomissaopermanencia;
begin
  Result := Self;
  FPagamentos.ExcluirComissaoPermanencia(FAgente, FDoc);
  FItens.ApagaItens(Pcodigo);
  FQuery.Executar(Format(FSQL.SqlExcluir, [Pcodigo]));
end;

function Tmodelcomissaopermanencia.Listarcomissoes: Imodelcomissaopermanencia;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlListarComissoes);
end;

function Tmodelcomissaopermanencia.Listarporcodigo(Pcodigo: Integer): Imodelcomissaopermanencia;
begin
  Result := Self;
  FQuery.Open(Format(FSQL.SqlListarCodigo,[Pcodigo]));
end;

function Tmodelcomissaopermanencia.Dataset: Tdataset;
var
  vDataset: TDataSet;
begin
  vDataset :=  FQuery.Dataset;
  FormataCampoTexto(vDataset.FindField('AGENTE'), 'Agente', 5, taCenter);
  FormataCampoTexto(vDataset.FindField('DOCUMENTO'), 'Docto', 5, taCenter);
  FormataCampoTexto(vDataset.FindField('NMAGE'), 'Agente', 10, taLeftJustify);
  FormataCampoData(vDataset.FindField('DTEXE'), 'Data', 8, taCenter);
  FormataCampoData(vDataset.FindField('DTCONTAB'), 'Contab', 8, taCenter);
  FormataCampoNumerico(vDataset.FindField('CODIGO'),'Cod',5, taCenter,'0000');
  FormataCampoNumerico(vDataset.FindField('SDINICIAL'),'Sld Inicial',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('COMISSAO'),'Comissão',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('SDFINAL'),'Sld Final',8, taRightJustify);
  Result := vDataset;
end;

function Tmodelcomissaopermanencia.Log(Avalue: Tandamento): Imodelcomissaopermanencia;
begin
  FLog := Avalue;
  Result := Self;
end;

function Tmodelcomissaopermanencia.Datacalculo(Avalue: Tdatetime): Imodelcomissaopermanencia;
begin
  FDataCalculo := Avalue;
  Result := Self;
end;

function Tmodelcomissaopermanencia.Agente(Avalue: String): Imodelcomissaopermanencia;
begin
  FAgente := Avalue;
  Result := Self;
end;

function Tmodelcomissaopermanencia.Tpdoc(Avalue: String): Imodelcomissaopermanencia;
begin
  FTpDoc := Avalue;
  Result := Self;
end;

function Tmodelcomissaopermanencia.Documento(Avalue: String): Imodelcomissaopermanencia;
begin
  Result := Self;
  FDoc := Avalue;
end;

function Tmodelcomissaopermanencia.Historico(Avalue: String): Imodelcomissaopermanencia;
begin
  Result := Self;
  FHistorico := Avalue;
end;

function Tmodelcomissaopermanencia.Saldoinicial: Double;
begin
  Result := FSaldoInicial;
end;

function Tmodelcomissaopermanencia.Comissao: Double;
begin
  Result := FComissao;
end;

function Tmodelcomissaopermanencia.Saldofinal: Double;
begin
  Result := FSaldoInicial - FComissao;
end;

function Tmodelcomissaopermanencia.Calcular: Tdataset;
var
  vRoundMode: TFPURoundingMode;
  vVlSaldo,
  vComissao: Currency;
  vCod: Integer;
  vGrEnc: String;
begin
  vGrEnc := TControllerFactory.New.Empresa.RecuperarEmpresa.STGRUENCCT;
  //if not FItens.TabelaExiste
  //then FItens.CriarTabela
  //else FItens.ApagaCalculo;
  vCod := FItens.NovoCodigo;
  Log('Início Cálculo');
  FSaldoInicial := 0;
  FComissao := 0;
  vRoundMode := GetRoundMode;
  //vInicio := True;
  FCotas.RetornaCotasRNP(0,10000);
  //FRnp.RetornaComissaoPermanencia(FDataCalculo);
  while FCotas.TemDados do
  begin
    FItens.ExisteCalculoCota(FCotas.GRUPO, FCotas.SEQ, FCotas.COTA);

    if FItens.TemDados
    then begin
      FSaldoInicial := FSaldoInicial + FItens.SDINICIAL;
      FComissao     := FComissao + FItens.COMISSAO;
      Log(Format('Lendo Cota: %s %s %s Saldo: %f Comissão: %f',[FCotas.GRUPO,FCotas.SEQ,FCotas.COTA, FItens.SDINICIAL, FItens.COMISSAO]));
    end
    else begin
      vComissao := 0;

      vVlSaldo := CalculaSaldoRnp(FCotas.GRUPO,FCotas.SEQ,FCotas.COTA, FDataCalculo);

      if vVlSaldo > 0
      then begin

        FSaldoInicial := FSaldoInicial + vVlSaldo;

        SetRoundMode(rmDown);
        if vVlSaldo > FCotas.Dataset.FieldByName('VAL_MINIMO').AsFloat
        then vComissao := RoundTo(vVlSaldo * FCotas.TXPER / 100, -2)
        else vComissao := vVlSaldo;
        SetRoundMode(vRoundMode);

        FItens.CODIGO(vCod)
                .CMPER(0)
                .GRUPO(FCotas.GRUPO)
                .SEQ(FCotas.SEQ)
                .COTA(FCotas.COTA)
                .COMISSAO(vComissao)
                .SDINICIAL(vVlSaldo)
                .SDFINAL(vVlSaldo - vComissao)
                .NovoItem;
        Inc(vCod);
        FComissao := FComissao + vComissao;

      end;
      Log(Format('Calculando Cota: %s %s %s Saldo: %f Comissão: %f',[FCotas.GRUPO,FCotas.SEQ,FCotas.COTA, vVlSaldo, vComissao]));
    end;
    FCotas.Proximo;
  end;
  SetRoundMode(vRoundMode);
  Log('Fim Cálculo');
  Result := FItens.ListarItensComissaoSinteticoGrupo(0).DataSet;
end;

procedure Tmodelcomissaopermanencia.Gravar;
var
  vCmPer: Integer;
begin
  Log('Inicio Gravação');

  FDoc := FPagamentos.RetornaNovoDocumentoAgente(FAgente, FTpDoc, FHistorico, FDataCalculo, FComissao);
  FItens.ListarItensComissao(0);

  while FItens.TemDados do
  begin
    Log(Format('Gravando Cota: %s %s %s Valor: %f',[ FItens.GRUPO,
                                                     FItens.SEQ,
                                                     FItens.COTA,
                                                     FItens.COMISSAO]));
    FPagamentos.IncluirComissaoPermanencia( FAgente,
                                            FDoc,
                                            FItens.GRUPO,
                                            FItens.SEQ,
                                            FItens.COTA,
                                            FDataCalculo,
                                            (FItens.COMISSAO * -1) );

    FRnp.GRUPO(FItens.GRUPO)
        .SEQ(FItens.SEQ)
        .COTA(FItens.COTA)
        .VLRRNP(FItens.SDFINAL)
        .GravarSaldoRnp;

    FItens.Proximo;

  end;
  Log('Totalizando Grupos');
  TControllerFactory.New.TotalGrupo.AtualizarRnp;
  TControllerFactory.New.Total.AtualizarRnp;
  vCmPer := NovaComissaoPermanencia;
  FItens.AlteraCmPer(vCmPer);
  Log('Fim Gravação');
end;

procedure Tmodelcomissaopermanencia.Log(Pmsg: String);
begin
  FLog(Format('%s: %s',[FormatDateTime('dd/mm/yyyy hh:mm:ss', Now) , Pmsg]));
end;

end.

