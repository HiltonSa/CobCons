unit cobcons.model.pgrnp;

{$mode Delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.bufferdataset, DateUtils, StrUtils,
  cobcons.controller.interfaces, cobcons.model.sql.interfaces, db;

type

   { TModelPgRnp }

   TModelPgRnp = class (TInterfacedObject, iModelPgRnp)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlPgRnp;

       FCodigo: Integer;
       FGrupo: String;
       FSeq: String;
       FCota: String;
       FValor: Double;
       FDtPedido: TDateTime;
       FDtProg: TDateTime;
       FDtPagto: TDateTime;
       FFrmPg: Integer;
       FTipoPix: Integer;
       FChavePix: String;
       FBanco: String;
       FAgencia: String;
       FConta: String;
       FObs: String;
       FDcSit: String;
       FStatus: Integer;

       procedure AtualizarCampos;
       function ProximoCodigo: Integer;
       function RetornarSQL(pTipo: Integer): string;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelPgRnp;

       function TabelaExiste: Boolean;
       function CriarTabela: iModelPgRnp;
       function Novo: iModelPgRnp;
       function Gravar: iModelPgRnp;
       function GravarPagamento: iModelPgRnp;
       function GravarStatus: iModelPgRnp;
       function DataSet: TDataSet;
       function TemDados: Boolean;
       function Proximo: Boolean;
       function RetornaPagamentoCota: iModelPgRnp;
       function RetornaStatus: iModelPgRnp;
       function BaixarPagamentosDataset(pAgente, pTipoDoc, pHistorico: String; pContab: TDateTime; pTotal: Double; pDataSet: TDataSet): iModelPgRnp;
       function GerarExportacao(pEmp, pFilial, pPartida, pContra1, pContra2: String; pContab: TDateTime; pPagtos: TDataSet; var pArquivo: TStringList; pMarcar: Boolean): iModelPgRnp;
       function PesquisarAsvr(pDtBase: TDateTime): TDataset;
       function GerarAsvr(pTipo, pCnpj: String; pDtBase: TDateTime;
         pArquivo: TStringList; pDataset: TDataset): iModelPgRnp;
       function Excluir: iModelPgRnp;
       function AtualizarValorPagar: iModelPgRnp;

       function CODIGO(aValue: Integer): iModelPgRnp; overload;
       function CODIGO: Integer; overload;
       function GRUPO(aValue: String): iModelPgRnp; overload;
       function SEQ(aValue: String): iModelPgRnp; overload;
       function COTA(aValue: String): iModelPgRnp; overload;
       function GRUPO: String; overload;
       function SEQ: String; overload;
       function COTA: String; overload;
       function STATUS(aValue: Integer): iModelPgRnp; overload;
       function STATUS: Integer; overload;
       function VALOR(aValue: Double): iModelPgRnp; overload;
       function VALOR: Double; overload;
       function DTPEDIDO(aValue: TDateTime): iModelPgRnp; overload;
       function DTPEDIDO: TDateTime; overload;
       function DTPROG(aValue: TDateTime): iModelPgRnp; overload;
       function DTPROG: TDateTime; overload;
       function DTPAGTO(aValue: TDateTime): iModelPgRnp; overload;
       function DTPAGTO: TDateTime; overload;
       function FRMPG(aValue: Integer): iModelPgRnp; overload;
       function FRMPG: Integer; overload;
       function TIPOPIX(aValue: Integer): iModelPgRnp; overload;
       function TIPOPIX: Integer; overload;
       function CHAVEPIX(aValue: String): iModelPgRnp; overload;
       function CHAVEPIX: String; overload;
       function BANCO(aValue: String): iModelPgRnp; overload;
       function BANCO: String; overload;
       function AGENCIA(aValue: String): iModelPgRnp; overload;
       function AGENCIA: String; overload;
       function CONTA(aValue: String): iModelPgRnp; overload;
       function CONTA: String; overload;
       function OBS(aValue: String): iModelPgRnp; overload;
       function OBS: String; overload;
       function DCSIT: String;
   end;


implementation

uses cobcons.controller.util, cobcons.controller.factory,
  cobcons.model.sql.factory;

{ TModelPgRnp }

procedure TModelPgRnp.AtualizarCampos;
begin
  FCodigo := FQuery.FieldByName('CODIGO').AsInteger;
  FGrupo:= FQuery.FieldByName('GRUPO').AsString;
  FSeq := FQuery.FieldByName('SEQ').AsString;
  FCota := FQuery.FieldByName('COTA').AsString;
  FStatus := FQuery.FieldByName('STATUS').AsInteger;
  FValor := FQuery.FieldByName('VALOR').AsFloat;
  FDtPedido := FQuery.FieldByName('DTPEDIDO').AsDateTime;
  FDtProg := FQuery.FieldByName('DTPROG').AsDateTime;
  FDtPagto := FQuery.FieldByName('DTPAGTO').AsDateTime;
  FFrmPg := FQuery.FieldByName('FRMPG').AsInteger;
  FTipoPix := FQuery.FieldByName('TIPOPIX').AsInteger;
  FChavePix := FQuery.FieldByName('CHAVEPIX').AsString;
  FBanco := FQuery.FieldByName('BANCO').AsString;
  FAgencia := FQuery.FieldByName('AGENCIA').AsString;
  FConta := FQuery.FieldByName('CONTA').AsString;
  FObs := FQuery.FieldByName('OBS').AsString;
  FDcSit := FQuery.FieldByName('DCSIT').AsString;
end;

function TModelPgRnp.ProximoCodigo: Integer;
begin
  Result := (FQuery.Open(FSQL.SqlMaiorCodigo).FieldByName('MCOD').AsInteger) + 1;
end;

function TModelPgRnp.RetornarSQL(pTipo: Integer): string;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  case Ptipo of
    0: vSql := Format(FSQL.SqlNovo,
                  [ FCodigo,
                    QuotedStr(FGrupo),
                    QuotedStr(FSeq),
                    QuotedStr(FCota),
                    FValor,
                    QuotedStr(RetornaDataSql(FDtPedido)),
                    QuotedStr(RetornaDataSql(FDtProg)),
                    FFrmPg,
                    FTipoPix,
                    QuotedStr(FChavePix),
                    QuotedStr(FBanco),
                    QuotedStr(FAgencia),
                    QuotedStr(FConta),
                    QuotedStr(FObs)]);
    1: vSql := Format(FSQL.SqlAlterar,
                         [ QuotedStr(RetornaDataSql(FDtProg)),
                           FFrmPg,
                           FTipoPix,
                           QuotedStr(FChavePix),
                           QuotedStr(FBanco),
                           QuotedStr(FAgencia),
                           QuotedStr(FConta),
                           QuotedStr(FObs),
                           FCodigo]);
    2: vSql := Format(FSQL.SqlAlterarPagto,
                                 [ QuotedStr(RetornaDataSql(FDtPagto)),
                                   FStatus,
                                   FCodigo]);
    3: vSql := Format(FSQL.SqlRetornaPagtoCota,
                                 [ QuotedStr(FGrupo),
                                   QuotedStr(FSeq),
                                   QuotedStr(FCota)]);
    4: vSql := Format(FSQL.SqlAlterarStatus,
                                 [ FStatus,
                                   FCodigo]);
    5: vSql := Format(FSQL.SqlRetornaStatus,[ FStatus,
                                              QuotedStr(RetornaDataSql(FDtProg))]);
    6: vSql := Format(FSQL.SqlExcluir, [FCodigo]);
    7: vSql := Format(FSQL.SqlAlterarValor, [FValor, FCodigo]);
  end;
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

constructor TModelPgRnp.Create(aQuery: iQueryRest);
begin
  FQuery := Aquery;
  FSQL:= TModelSQLFactory.New.SqlPgRnp;
end;

destructor TModelPgRnp.Destroy;
begin
  inherited Destroy;
end;

class function TModelPgRnp.New(aQuery: iQueryRest): iModelPgRnp;
begin
  Result := Self.Create(Aquery);
end;

function TModelPgRnp.TabelaExiste: Boolean;
begin
  Result := FQuery.Open(FSQL.SqlTabelaExiste).FieldByName('QTDE').AsInteger > 0;
end;

function TModelPgRnp.CriarTabela: iModelPgRnp;
begin
  Result := Self;
  FQuery.Executar(FSQL.SqlCriarTabela);
end;

function TModelPgRnp.Novo: iModelPgRnp;
begin
  Result := Self;
  FCodigo := ProximoCodigo;
  FQuery.Executar(RetornarSQL(0));
end;

function TModelPgRnp.Gravar: iModelPgRnp;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(1));
end;

function TModelPgRnp.GravarPagamento: iModelPgRnp;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(2));
end;

function TModelPgRnp.GravarStatus: iModelPgRnp;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(4));
end;

function TModelPgRnp.DataSet: TDataSet;
var
  vDataset: TDataSet;
begin
  vDataset :=  FQuery.Dataset;
  FormataCampoNumerico(vDataset.FindField('CODIGO'),'Cod',3, taCenter);
  FormataCampoTexto(vDataset.FindField('GRUPO'), 'Grupo', 4, taCenter);
  FormataCampoTexto(vDataset.FindField('SEQ'), 'Seq', 2, taCenter);
  FormataCampoTexto(vDataset.FindField('COTA'), 'Cota', 3, taCenter);
  FormataCampoTexto(vDataset.FindField('NOME'), 'Nome', 30, taLeftJustify);
  FormataCampoTexto(vDataset.FindField('DCSIT'), 'Sit.', 10, taCenter);
  FormataCampoNumerico(vDataset.FindField('VALOR'),'Vlr RNP',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('VLR'),'Vlr Pago',8, taRightJustify);
  FormataCampoData(vDataset.FindField('DTPEDIDO'),'Pedido',8,taCenter);
  FormataCampoData(vDataset.FindField('DTPROG'),'Pagar em',8,taCenter);
  FormataCampoData(vDataset.FindField('DTPAGTO'),'Pagto',8,taCenter);
  Result := vDataset;
end;

function TModelPgRnp.TemDados: Boolean;
begin
  Result := False;
  if not FQuery.Dataset.EOF
  then begin
    AtualizarCampos;
    Result := True;
  end;
end;

function TModelPgRnp.Proximo: Boolean;
begin
  FQuery.Dataset.Next;
  Result := Self.TemDados;
end;

function TModelPgRnp.RetornaPagamentoCota: iModelPgRnp;
begin
  Result := Self;
  FQuery.Open(RetornarSQL(3));
end;

function TModelPgRnp.RetornaStatus: iModelPgRnp;
begin
  Result := Self;
  FQuery.Open(RetornarSQL(5));
end;

function TModelPgRnp.BaixarPagamentosDataset(pAgente, pTipoDoc,
  pHistorico: String; pContab: TDateTime; pTotal: Double; pDataSet: TDataSet
  ): iModelPgRnp;
var
  vPagamentos : iControllerPagamentos;
  vValor: Currency;
  vDoc, vTipo, vGrupo, vSeq, vCota: String;
  vDtProg: TDateTime;
begin
  Result := Self;

  vPagamentos := TControllerFactory.New.Pagamentos;

  vDoc := vPagamentos.RetornaNovoDocumentoAgente( pAgente,
                                                  pTipoDoc,
                                                  pHistorico,
                                                  pContab,
                                                  pTotal);

  pDataSet.First;
  while not pDataSet.EOF do
  begin
    vDtProg := pDataSet.FieldByName('DTPROG').AsDateTime;
    if vDtProg <= pContab
    then begin

      FDtPagto := pContab;
      FStatus := 2;
      FCodigo := pDataSet.FieldByName('CODIGO').AsInteger;

      vGrupo := pDataSet.FieldByName('GRUPO').AsString;
      vSeq := pDataSet.FieldByName('SEQ').AsString;
      vCota := pDataSet.FieldByName('COTA').AsString;
      vValor := pDataSet.FieldByName('VALOR').AsCurrency;

      if vSeq = '00'
      then vTipo := '99'
      else vTipo := '8D';

      vPagamentos.IncluirPagamentoRnp( pAgente, vDoc,
                                       vGrupo, vSeq, vCota,
                                       vTipo, pContab, vDtProg,
                                       (vValor * -1) );

      GravarPagamento;

    end;
    pDataSet.Next;
  end;
end;

function TModelPgRnp.GerarExportacao(pEmp, pFilial, pPartida, pContra1,
  pContra2: String; pContab: TDateTime; pPagtos: TDataSet;
  var pArquivo: TStringList; pMarcar: Boolean): iModelPgRnp;

var
  vLan, vSeq: Integer;
  vValor: Currency;
  vLin, vHist, vContraPartida: String;
  vInicio, vData: TDateTime;
begin
  vInicio := StartOfTheMonth(pContab);
  pArquivo.Clear;
  vLan := 1;
  pPagtos.First;
  while not pPagtos.EOF do
  begin
    vData := pPagtos.FieldByName('DTPROG').AsDateTime;
    if (vData >= vInicio) and (vData <= pContab)
    then begin
      FStatus := 3;
      FCodigo := pPagtos.FieldByName('CODIGO').AsInteger;
      vValor := pPagtos.FieldByName('VALOR').AsCurrency;
      vHist :=  Format('PAGTO RNP %s/%s-%s %s',
                     [ pPagtos.FieldByName('GRUPO').AsString,
                       pPagtos.FieldByName('SEQ').AsString,
                       pPagtos.FieldByName('COTA').AsString,
                       pPagtos.FieldByName('NOME').AsString]);
      vHist := Copy(vHist, 1,35);

      if RetornaGrupoAntes(pPagtos.FieldByName('GRUPO').AsString)
      then vContraPartida := pContra1
      else vContraPartida := pContra2;

      DefaultFormatSettings.DecimalSeparator := '.';
      // Sequencia 1
      vLin := Format('%.3d%6s%.4d001C%-16s%-20s%.3d          %-20s%.3d          %-35s%-40s000',
                    [ StrToInt(pEmp),
                      RetornaDataSiacon(vData),
                      vLan,
                      FormatFloat('0000000000000.00',vValor),
                      pPartida,
                      StrToInt(pFilial),
                      vContraPartida,
                      StrToInt(pFilial),
                      vHist,
                      DupeString(' ',40) ]);
      pArquivo.Add(vLin);
      // sequencia 2
      vLin := Format('%.3d%6s%.4d002D%-16s%-20s%.3d          %-20s%.3d          %-35s%-40s000',
                    [ StrToInt(pEmp),
                      RetornaDataSiacon(vData),
                      vLan,
                      FormatFloat('0000000000000.00',vValor),
                      vContraPartida,
                      StrToInt(pFilial),
                      ' ',
                      StrToInt(pFilial),
                      vHist,
                      DupeString(' ',40) ]);
      pArquivo.Add(vLin);
      DefaultFormatSettings.DecimalSeparator := ',';

      if pMarcar
      then GravarStatus;

      Inc(vLan);
    end;
    pPagtos.Next;
  end;
  Result := Self;
end;

function TModelPgRnp.PesquisarAsvr(pDtBase: TDateTime): TDataset;
var
  vInicio,
  vFim: TDateTime;
begin
  vInicio := StartOfTheMonth(pDtBase);
  vFim    := EndOfTheMonth(pDtBase);
  FQuery.Open( Format( FSQL.SqlAsvr,
                      [ QuotedStr(RetornaDataSql(vInicio)),
                        QuotedStr(RetornaDataSql(vFim)   ) ]));
  Result := Dataset;
end;

function TModelPgRnp.GerarAsvr(pTipo, pCnpj: String;pDtBase: TDateTime; pArquivo: TStringList; pDataset: TDataset
  ): iModelPgRnp;
begin
  pArquivo.Clear;
  pArquivo.Add('<?xml version="1.0" encoding="UTF-8"?>');
  pArquivo.Add('<asvr9805>');
  pArquivo.Add('<codDoc>9805</codDoc>');
  pArquivo.Add(Format('<tipoEnvio>%s</tipoEnvio>',[pTipo]));
  pArquivo.Add(Format('<dataBase>%.4d%.2d</dataBase>',
                    [YearOf(pDtBase), MonthOf(pDtBase)]));
  pArquivo.Add(Format('<cnpjIf>%s</cnpjIf>',[pCnpj]));
  while not pDataset.EOF do
  begin
    DefaultFormatSettings.DecimalSeparator := '.';
    pArquivo.Add('<valor>');
    pArquivo.Add('<origem>100</origem>');
    pArquivo.Add( Format('<modalidadePagamento>%d</modalidadePagamento>',
                         [pDataset.FieldByName('FRMPG').AsInteger]));
    pArquivo.Add( Format('<valorDevolvido>%f</valorDevolvido>',
                         [pDataset.FieldByName('VLR').AsFloat]));
    if (FQuery.FieldByName('PESS_F_J').AsString = 'F')
    then pArquivo.Add( Format('<qtdCpfsBeneficiados>%d</qtdCpfsBeneficiados>',
                              [pDataset.FieldByName('QTD').AsInteger]))
    else pArquivo.Add( Format('<qtdCnpjsBeneficiados>%d</qtdCnpjsBeneficiados>',
                              [pDataset.FieldByName('QTD').AsInteger]));
    pArquivo.Add('</valor>');
    DefaultFormatSettings.DecimalSeparator := ',';

    pDataset.Next;
  end;
  pArquivo.Add('</asvr9805>');
  Result := Self;
end;

function TModelPgRnp.Excluir: iModelPgRnp;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(6));
end;

function TModelPgRnp.AtualizarValorPagar: iModelPgRnp;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(7));
end;

function TModelPgRnp.CODIGO(aValue: Integer): iModelPgRnp;
begin
  Result := Self;
  FCodigo := Avalue;
end;

function TModelPgRnp.CODIGO: Integer;
begin
  Result := FCodigo;
end;

function TModelPgRnp.GRUPO(aValue: String): iModelPgRnp;
begin
  Result := Self;
  FGrupo := Avalue;
end;

function TModelPgRnp.SEQ(aValue: String): iModelPgRnp;
begin
  Result := Self;
  FSeq := Avalue;
end;

function TModelPgRnp.COTA(aValue: String): iModelPgRnp;
begin
  Result := Self;
  FCota := Avalue;
end;

function TModelPgRnp.GRUPO: String;
begin
  Result := FGrupo;
end;

function TModelPgRnp.SEQ: String;
begin
  Result := FSeq;
end;

function TModelPgRnp.COTA: String;
begin
  Result := FCota;
end;

function TModelPgRnp.STATUS(aValue: Integer): iModelPgRnp;
begin
  Result := Self;
  FStatus := Avalue;
end;

function TModelPgRnp.STATUS: Integer;
begin
  Result := FStatus;
end;

function TModelPgRnp.VALOR(aValue: Double): iModelPgRnp;
begin
  Result := Self;
  FValor := Avalue;
end;

function TModelPgRnp.VALOR: Double;
begin
  Result := FValor;
end;

function TModelPgRnp.DTPEDIDO(aValue: TDateTime): iModelPgRnp;
begin
  Result := Self;
  FDtPedido := Avalue;
end;

function TModelPgRnp.DTPEDIDO: TDateTime;
begin
  Result := FDtPedido;
end;

function TModelPgRnp.DTPROG(aValue: TDateTime): iModelPgRnp;
begin
  Result := Self;
  FDtProg := Avalue;
end;

function TModelPgRnp.DTPROG: TDateTime;
begin
  Result := FDtProg;
end;

function TModelPgRnp.DTPAGTO(aValue: TDateTime): iModelPgRnp;
begin
  Result := Self;
  FDtPagto := Avalue;
end;

function TModelPgRnp.DTPAGTO: TDateTime;
begin
  Result := FDtPagto;
end;

function TModelPgRnp.FRMPG(aValue: Integer): iModelPgRnp;
begin
  Result := Self;
  FFrmPg := Avalue;
end;

function TModelPgRnp.FRMPG: Integer;
begin
  Result := FFrmPg;
end;

function TModelPgRnp.TIPOPIX(aValue: Integer): iModelPgRnp;
begin
  Result := Self;
  FTipoPix := Avalue;
end;

function TModelPgRnp.TIPOPIX: Integer;
begin
  Result := FTipoPix;
end;

function TModelPgRnp.CHAVEPIX(aValue: String): iModelPgRnp;
begin
  Result := Self;
  FChavePix := Avalue;
end;

function TModelPgRnp.CHAVEPIX: String;
begin
  Result := FChavePix;
end;

function TModelPgRnp.BANCO(aValue: String): iModelPgRnp;
begin
  Result := Self;
  FBanco := Avalue;
end;

function TModelPgRnp.BANCO: String;
begin
  Result := FBanco;
end;

function TModelPgRnp.AGENCIA(aValue: String): iModelPgRnp;
begin
  Result := Self;
  FAgencia := Avalue;
end;

function TModelPgRnp.AGENCIA: String;
begin
  Result := FAgencia;
end;

function TModelPgRnp.CONTA(aValue: String): iModelPgRnp;
begin
  Result := Self;
  FConta := Avalue;
end;

function TModelPgRnp.CONTA: String;
begin
  Result := FConta;
end;

function TModelPgRnp.OBS(aValue: String): iModelPgRnp;
begin
  Result := Self;
  FObs := Avalue;
end;

function TModelPgRnp.OBS: String;
begin
  Result := FObs;
end;

function TModelPgRnp.DCSIT: String;
begin
  Result := FDcSit;
end;

end.



