unit cobcons.model.rateiopagamentos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces, ComCtrls, ExtCtrls, Forms,
  cobcons.controller.interfaces, cobcons.model.bufferdataset,  db, DateUtils;

type

   { TModelRateioPagamentos }

   TModelRateioPagamentos = class (TInterfacedObject, iModelRateioPagamentos)
     private
       FDataBase: TDateTime;
       FAgente: String;
       FTipoDoc: String;
       FHistorico: String;
       FRateio: iModelBufferDataset;
       FValor: Double;
       FLog: TAndamento;

       procedure CriarDatasetRateio;
       procedure CalcularRateioRecebimento( pGrupo: String; pValor: Double);
       procedure Log(pMsg: String);
     public
       constructor Create;
       destructor Destroy; override;
       class function New: iModelRateioPagamentos;

       function LOG(aValue: TAndamento): iModelRateioPagamentos;
       function DATABASE(aValue: TDateTime): iModelRateioPagamentos;
       function AGENTE(aValue: String): iModelRateioPagamentos;
       function TIPODOC(aValue: String): iModelRateioPagamentos;
       function HISTORICO(aValue: String): iModelRateioPagamentos;
       function RateioRecebimentos(pDataset: TDataSet): iModelRateioPagamentos;
       function Dataset: TDataset;
       procedure GravarRateio;
   end;


implementation

uses cobcons.controller.util, cobcons.controller.factory;

{ TModelRateioPagamentos }

procedure TModelRateioPagamentos.CriarDatasetRateio;
begin
  FRateio := TModelBufferDataset.New;
  with FRateio do
  begin
    NovoCampo.NOME('Grupo').TIPO(ftString).TAMANHO(4).AdicionarCampo;
    NovoCampo.NOME('Seq').TIPO(ftString).TAMANHO(2).AdicionarCampo;
    NovoCampo.NOME('Cota').TIPO(ftString).TAMANHO(3).AdicionarCampo;
    NovoCampo.NOME('Saldo').TIPO(ftFloat).AdicionarCampo;
    NovoCampo.NOME('Part').TIPO(ftFloat).AdicionarCampo;
    NovoCampo.NOME('Valor').TIPO(ftFloat).AdicionarCampo;
    CriarDataset;
    Formatacampo('Grupo','Grupo',4, taCenter);
    Formatacampo('Seq', 'Seq', 2, taCenter);
    Formatacampo('Cota', 'Cota', 3, taCenter);
    Formatacampo('Saldo', 'Saldo', 8, taRightJustify, '#,0.00');
    Formatacampo('Part', 'Part', 11, taRightJustify, '#,0.00000000');
    Formatacampo('Valor', 'Valor', 8, taRightJustify, '#,0.00');
  end;
end;

constructor TModelRateioPagamentos.Create;
begin
  FValor := 0;
end;

destructor TModelRateioPagamentos.Destroy;
begin
  inherited Destroy;
end;

class function TModelRateioPagamentos.New: iModelRateioPagamentos;
begin
  Result := Self.Create;
end;

function TModelRateioPagamentos.LOG(aValue: TAndamento
  ): iModelRateioPagamentos;
begin
  FLog := Avalue;
  Result := Self;
end;

function TModelRateioPagamentos.DATABASE(aValue: TDateTime
  ): iModelRateioPagamentos;
begin
  Result := Self;
  FDataBase := aValue;
end;

function TModelRateioPagamentos.AGENTE(aValue: String): iModelRateioPagamentos;
begin
  Result := Self;
  FAgente := aValue;
end;

function TModelRateioPagamentos.TIPODOC(aValue: String): iModelRateioPagamentos;
begin
  Result := Self;
  FTipoDoc := aValue;
end;

function TModelRateioPagamentos.HISTORICO(aValue: String
  ): iModelRateioPagamentos;
begin
  Result := Self;
  FHistorico := aValue;
end;

function TModelRateioPagamentos.RateioRecebimentos(pDataset: TDataSet
  ): iModelRateioPagamentos;
var
  vGrupo: String;
  vSaldo: Double;
begin
  FValor := 0;
  pDataset.First;
  while not pDataset.EOF do
  begin
    vGrupo := pDataset.FieldByName('GRUPO').AsString;
    vSaldo := pDataset.FieldByName('F_AQUISI').AsFloat;
    LOG(Format('Rateando Recebimentos Grupo %s...',[vGrupo]));
    CalcularRateioRecebimento(vGrupo, vSaldo);
    FValor := FValor + vSaldo;
    pDataset.Next;
  end;
  Result := Self;
end;

function TModelRateioPagamentos.Dataset: TDataset;
begin
  Result := FRateio.DataSet;
end;

procedure TModelRateioPagamentos.GravarRateio;
var
   vDoc, vGrupo, vSeq, vCota: String;
   vRateio: Currency;
   vPagamentos: iControllerPagamentos;
begin
  Log('Gravando Rateio Recebimentos...');
  vPagamentos := TControllerFactory.New.Pagamentos;
  vDoc := vPagamentos.RetornaNovoDocumentoAgente(FAgente, FTipoDoc, FHistorico, FDataBase, FValor);
  FRateio.PrimeiroRegistro;
  while FRateio.TemDados do
  begin

    vGrupo := FRateio.DataSet.FieldByName('Grupo').AsString;
    vSeq   := FRateio.DataSet.FieldByName('Seq').AsString;
    vCota  := FRateio.DataSet.FieldByName('Cota').AsString;
    vRateio := FRateio.DataSet.FieldByName('Valor').AsCurrency;

    Log(Format('Gravando Cota: %s %s %s Valor: %f',[vGrupo,vSeq,vCota,vRateio]));

    vPagamentos.IncluirRateioRecebimento( FAgente, vDoc,
                                          vGrupo, vSeq,vCota,
                                          FDataBase, vRateio );

    FRateio.Proximo;
  end;
  Log('Rateio Rendimentos RNP gravada.');
end;

procedure TModelRateioPagamentos.CalcularRateioRecebimento(pGrupo: String;
  pValor: Double);
var
  vDataset: TDataset;
  vGrupo, vSeq, vCota: String;
  vVlBem, vCategoria, vPcPago, vTotCat, vlPart, vlRateio: Double;
begin
  CriarDatasetRateio;
  vDataset := TControllerFactory.New.Cota.RetornaRateioFuturo(pGrupo).Dataset;
  vTotCat := 0;
  while not vDataset.EOF do
  begin
    vGrupo := vDataset.FieldByName('GRUPO').AsString;
    vSeq := vDataset.FieldByName('SEQ').AsString;
    vCota := vDataset.FieldByName('COTA').AsString;
    vVlBem := TControllerFactory.New.PrecoBem.RetornaPrecoBemData(
                        vDataset.FieldByName('BEM').AsString,
                        vDataset.FieldByName('FIL_COM').AsString,
                        vDataset.FieldByName('ULTREU').AsDateTime).PRE_TABE;
    vPcPago := vDataset.FieldByName('PERCPAGO').AsFloat;
    if vPcPago > 100.0000
    then vPcPago := 100.0000;
    vCategoria := vVlBem * vPcPago;
    vTotCat := vTotCat + vCategoria;
    with FRateio do
    begin
      NovoRegistro;
      CAMPO('Grupo').VALOR(vGrupo).AtribuirValor;
      CAMPO('Seq').VALOR(vSeq).AtribuirValor;
      CAMPO('Cota').VALOR(vCota).AtribuirValor;
      CAMPO('Saldo').VALOR(vCategoria).AtribuirValor;
      CAMPO('Part').VALOR(0).AtribuirValor;
      CAMPO('Valor').VALOR(0).AtribuirValor;
      GravarRegistro;
    end;
    Log(Format('Selecionando Cotas: %s %s %s',[vGrupo, vSeq, vCota]));
    vDataset.Next;
  end;

  FRateio.PrimeiroRegistro;
  while FRateio.TemDados do
  begin
    vlPart := FRateio.DataSet.FieldByName('Saldo').AsFloat / vTotCat * 100;
    vlRateio := vlPart * pValor / 100;
    Log(Format('Calculando Rateio: Cota: %s %s %s Perc: %n Valor: %n',[
                        FRateio.DataSet.FieldByName('Grupo').AsString,
                        FRateio.DataSet.FieldByName('Seq').AsString,
                        FRateio.DataSet.FieldByName('Cota').AsString,
                        vlPart, vlRateio]));
    FRateio.AlteraRegistro;
    FRateio.CAMPO('Part').VALOR(vlPart).AtribuirValor;
    FRateio.CAMPO('Valor').VALOR(vlRateio).AtribuirValor;
    FRateio.GravarRegistro;
    FRateio.Proximo;
  end;

end;

procedure TModelRateioPagamentos.Log(pMsg: String);
begin
  if Assigned(FLog)
  then FLog(Format('%s: %s',[FormatDateTime('dd/mm/yyyy hh:mm:ss', Now) , Pmsg]));
end;

end.

