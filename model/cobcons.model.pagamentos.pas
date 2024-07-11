unit cobcons.model.pagamentos;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.bufferdataset, DateUtils, cobcons.controller.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TModelPagamentos }

   TModelPagamentos = class (TInterfacedObject, iModelPagamentos)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlPagamentos;
       FListaAgentes: TStringList;
       FListaTipoDocumento: TStringList;
       FListaAvisos: TStringList;
       FCCDev: iModelBufferDataset;
       FGrupo: String;

       function RetornarAviso(pGrupo: String): String;
       procedure PreencherListaAvisos(pGrupo: String);

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelPagamentos;

       function RetornaListaAgentes: TStringList;
       function RetornaListaTipoDocumento: TStringList;
       function RetornaDocumentoAgente(pAgente, pTipo, pHistorico: String; pContab: TDateTime): String;
       function RetornaNovoDocumentoAgente(pAgente, pTipo, pHistorico: String; pContab: TDateTime; pValor: Double): String;
       function RetornaNovoAviso(pGrupo: String): Integer;
       function RetornaPagamentosCota(pGrupo, pSeq, pCota: String): iModelPagamentos;
       function RetornaPagamentosDataBase(pIni, pFim: TDateTime): iModelPagamentos;
       function RetornaVlrBemApreendidoCota(pGrupo, pSeq, pCota: String): Double;
       function RetornaPagamentosDevolucaoCota(pGrupo, pSeq, pCota: String; pInicio, pLimite: TDateTime): iModelPagamentos;
       function IncluirComissaoPermanencia(pAgente, pNrDoc, pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pValor: Double): iModelPagamentos;
       function IncluirPagamentoRnp(pAgente, pNrDoc, pGrupo, pSeq, pCota, pTipo: String; pContab, pOcorrencia: TDateTime; pValor: Double): iModelPagamentos;
       function IncluirRendimentoRnp(pAgente, pNrDoc, pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pValor: Double): iModelPagamentos;
       function IncluirSaldoRecomposicaoRnp(pAgente, pNrDoc, pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pSaldo: Double): iModelPagamentos;
       function IncluirRateioRecebimento(pAgente, pNrDoc, pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pSaldo: Double): iModelPagamentos;
       function ExcluirComissaoPermanencia(pAgente, pNrDoc: string): iModelPagamentos;
       function CotaTemCorrecoes(pGrupo, pSeq, pCota: String): Boolean;
       function DataSet: TDataSet;
       function TemDados: Boolean;
       function Proximo: Boolean;
       function AVISO: String;
       function TIPO_MOV: String;
       function DCTIPOMOV: String;
       function D_VENCTO: TDateTime;
       function DT_PAGTO: TDateTime;
       function P_NORMAL: Double;
       function P_DIFER: Double;
       function P_ANTEC: Double;
       function P_RATEIO: Double;
       function VALOR: Double;
       function MUL_JUR: Double;
       function BEM: String;
       function F_AQUISI: Double;
       function ADMINIST: Double;
       function F_RESERV: Double;
       function OUTROS: Double;
       function SIMBOLO: String;
       function HISTORIC: String;
       function D_CONTAB: TDateTime;
       function FIL_COM: String;
       function DCBEM: String;
       function ESTORNADO: Boolean;
   end;


implementation

uses cobcons.controller.util, cobcons.controller.factory,
  cobcons.model.sql.factory;

{ TModelPagamentos }

//function TmodelPagamentos.Retornarsql(Ptipo: Integer): String;
//var
//  vSql: String;
//begin
  //FormatSettings.DecimalSeparator := '.';
  //case Ptipo of
  //  1: vSql := Format(SQL_GRUPO_COTA,
  //        [ QuotedStr(FFantasia),
  //          QuotedStr(RetornaSemFormatacao(FCgc)),
  //          FPcMulta,
  //          FPcJuros,
  //          FPcHonorarios,
  //          QuotedStr(RetornaDataSql(FUltSag)),
  //          QuotedStr(FNmContato),
  //          QuotedStr(FTelContato),
  //          QuotedStr(FMailContato)]);
  //end;
  //FormatSettings.DecimalSeparator := ',';
//  Result := vSql;
//end;

function TModelPagamentos.RetornarAviso(pGrupo: String): String;
begin
  if (FListaAvisos.Count = 0) or (pGrupo <> FGrupo)
  then PreencherListaAvisos(pGrupo);
  Result := FListaAvisos[0];
  FListaAvisos.Delete(0);
end;

procedure TModelPagamentos.PreencherListaAvisos(pGrupo: String);
const
  FALHAS = 1500;
var
  vDataset: TDataSet;
  vSeq: Integer;
begin
  FGrupo := pGrupo;
  vDataset := FQuery.Open(FSQL.SqlRetornaMaxAviso(pGrupo)).Dataset;
  FListaAvisos.Clear;
  vSeq := 0;
  while not vDataset.EOF do
  begin
    Inc(vSeq);
    if vSeq = StrToInt(vDataSet.FieldByName('AVISO').AsString)
    then vDataSet.Next
    else FListaAvisos.Add(Format('%.6d',[vSeq]));
    if FListaAvisos.Count >= FALHAS
    then Break;
  end;
end;

constructor TModelPagamentos.Create(aQuery: iQueryRest);
begin
  FQuery := Aquery;
  FListaAgentes := TStringList.Create;
  FListaAvisos := TStringList.Create;
  FListaTipoDocumento := TStringList.Create;
  FSQL:= TModelSQLFactory.New.SqlPagamentos;
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
  FGrupo := '';
end;

destructor TModelPagamentos.Destroy;
begin
  FListaAgentes.Free;
  FListaTipoDocumento.Free;
  FListaAvisos.Free;
  inherited Destroy;
end;

class function TModelPagamentos.New(aQuery: iQueryRest): iModelPagamentos;
begin
  Result := Self.Create(Aquery);
end;

function TModelPagamentos.RetornaListaAgentes: TStringList;
var
  vDataset: TDataSet;
  vDesc: String;
begin
  FListaAgentes.Clear;
  vDataset := FQuery.Open(FSQL.SqlListaAgentes).Dataset;
  while not vDataset.EOF do
  begin
    vDesc := Format('%s-%s',[ vDataset.FieldByName('AG_FINAN').AsString,
                              vDataset.FieldByName('NOME').AsString]);
    FListaAgentes.Add(Format('%s|%d|%s',[ vDesc, 0,
                                          vDataset.FieldByName('AG_FINAN').AsString]));
    vDataset.Next;
  end;
  Result := FListaAgentes;
end;

function TModelPagamentos.RetornaListaTipoDocumento: TStringList;
var
  vDataset: TDataSet;
  vDesc: String;
begin
  FListaTipoDocumento.Clear;
  vDataset := FQuery.Open(FSQL.SqlListaTipoDocumento).Dataset;
  while not vDataset.EOF do
  begin
    vDesc := Format('%s-%s',[ vDataset.FieldByName('TP_DOCUM').AsString,
                              vDataset.FieldByName('DESCRIC').AsString]);
    FListaTipoDocumento.Add(Format('%s|%d|%s',[ vDesc, 0,
                                                vDataset.FieldByName('TP_DOCUM').AsString]));
    vDataset.Next;
  end;
  Result := FListaTipoDocumento;
end;

function TModelPagamentos.RetornaDocumentoAgente(pAgente, pTipo,
  pHistorico: String; pContab: TDateTime): String;
var
  vSql,
  vNumDoc : String;
begin
  vSql := Format(FSQL.SqlRetornaNumeroDocumento,[QuotedStr(pAgente), QuotedStr(RetornaDataSql(pContab)), QuotedStr(pTipo)]);
  vNumDoc := FQuery.Open(vSql).Dataset.FieldByName('NR_DOCUM').AsString;

  //
  // se não encontrou o documento e o historico foi informado
  // cria um novo documento e retorna o novo numero, senão
  // retorna string vazia
  //
  if (StrToIntDef(vNumDoc,0) = 0) and (Length(Trim(pHistorico))>0)
  then vNumDoc := RetornaNovoDocumentoAgente(pAgente, pTipo, pHistorico, pContab, 0);

  Result := vNumDoc;
end;

function TModelPagamentos.RetornaNovoDocumentoAgente(pAgente, pTipo,
  pHistorico: String; pContab: TDateTime; pValor: Double): String;
var
  vNumDoc,
  vNumBco,
  vSql: String;
begin
  vSql := Format(FSQL.SqlRetornaNovoNumDocumento, [QuotedStr(pAgente)]);
  vNumDoc := Format('%.6d', [ FQuery.Open(vSql).Dataset.FieldByName('MAXNR').AsInteger ]);;
  vNumBco := Format('%.15d', [ FQuery.Open(vSql).Dataset.FieldByName('MAXNR').AsInteger ]);;
  FormatSettings.DecimalSeparator := '.';
  vSql := Format( FSQL.SqlNovoDocumento, [ QuotedStr( Pagente ),
                                           QuotedStr( RetornaDataSql( Pcontab ) ),
                                           QuotedStr( vNumDoc ),
                                           QuotedStr( Ptipo ),
                                           Pvalor,
                                           QuotedStr( Phistorico ),
                                           QuotedStr( RetornaDataSql( Pcontab ) ),
                                           Pvalor,
                                           QuotedStr( RetornaDataSql( Pcontab ) ),
                                           QuotedStr( RetornaDataSql( Date ) ),
                                           QuotedStr( vNumBco )]);
  FormatSettings.DecimalSeparator := ',';
  FQuery.Executar(vSql);
  Result := vNumDoc;
end;

function TModelPagamentos.RetornaNovoAviso(pGrupo: String): Integer;
var
  vSQl: String;
begin
  //vSQl := FSQL.SqlRetornaMaxAviso(Pgrupo);
  //Result := FQuery.Open(vSQl).FieldByName('INICIO').AsInteger;
  Result := 99999999999;
end;

function TModelPagamentos.RetornaPagamentosCota(pGrupo, pSeq, pCota: String
  ): iModelPagamentos;
begin
  Result := Self;
  FQuery.Open( FSQL.SqlRetornaPagamentosCota(Pgrupo, Pseq, Pcota) );
end;

function TModelPagamentos.RetornaPagamentosDataBase(pIni, pFim: TDateTime
  ): iModelPagamentos;
begin
  Result := Self;
  FQuery.Open(Format(FSQL.SqlRetornaPagamentosDataBase,
                       [ QuotedStr(RetornaDataSql(pIni)),
                         QuotedStr(RetornaDataSql(pFim))]));
end;

function TModelPagamentos.RetornaVlrBemApreendidoCota(pGrupo, pSeq,
  pCota: String): Double;
begin
  Result := FQuery.Open( FSQL.SqlRetornaVlrApreensaoBem(Pgrupo, Pseq, Pcota) ).Dataset.FieldByName('VLAPR').AsFloat;
end;

function TModelPagamentos.RetornaPagamentosDevolucaoCota(pGrupo, pSeq,
  pCota: String; pInicio, pLimite: TDateTime): iModelPagamentos;
begin
  Result := Self;
  FQuery.Open( FSQL.SqlRetornaPagamentosDevolucaoCota(Pgrupo, Pseq, Pcota, Pinicio, Plimite) );
end;

function TModelPagamentos.IncluirComissaoPermanencia(pAgente, pNrDoc, pGrupo,
  pSeq, pCota: String; pDataCalculo: TDateTime; pValor: Double
  ): iModelPagamentos;
var
  vAviso: String;
begin
  vAviso := RetornarAviso(pGrupo);
  FQuery.Executar(FSQL.SqlIncluirComissaoPermanencia(Pgrupo, Pseq, Pcota, vAviso, Pagente, Pnrdoc, Pdatacalculo, Pvalor));
  Result := Self;
end;

function TModelPagamentos.IncluirPagamentoRnp(pAgente, pNrDoc, pGrupo, pSeq,
  pCota, pTipo: String; pContab, pOcorrencia: TDateTime; pValor: Double
  ): iModelPagamentos;
var
  vAviso: String;
begin
  vAviso := RetornarAviso(pGrupo);
  FQuery.Executar( FSQL.SqlIncluirPagamentoRnp( Pgrupo, Pseq, Pcota,
                                                vAviso, Pagente, Pnrdoc,
                                                pTipo, pContab, pOcorrencia,
                                                Pvalor));
  Result := Self;
end;

function TModelPagamentos.IncluirRendimentoRnp(pAgente, pNrDoc, pGrupo, pSeq,
  pCota: String; pDataCalculo: TDateTime; pValor: Double): iModelPagamentos;
var
  vAviso: String;
begin
  vAviso := RetornarAviso(pGrupo);
  FQuery.Executar(FSQL.SqlIncluirRendimentoRnp(Pgrupo, Pseq, Pcota, vAviso, Pagente, Pnrdoc, Pdatacalculo, Pvalor));
  Result := Self;
end;

function TModelPagamentos.IncluirSaldoRecomposicaoRnp(pAgente, pNrDoc, pGrupo,
  pSeq, pCota: String; pDataCalculo: TDateTime; pSaldo: Double
  ): iModelPagamentos;
var
  vAviso: String;
begin
  vAviso := RetornarAviso(pGrupo);
  FQuery.Executar(FSQL.SqlIncluirRecomposicaoRnp(Pgrupo, Pseq, Pcota, vAviso, Pagente, Pnrdoc, Pdatacalculo, pSaldo));
  Result := Self;
end;

function TModelPagamentos.IncluirRateioRecebimento(pAgente, pNrDoc, pGrupo,
  pSeq, pCota: String; pDataCalculo: TDateTime; pSaldo: Double
  ): iModelPagamentos;
var
  vAviso: String;
begin
  vAviso := RetornarAviso(pGrupo);
  FQuery.Executar(FSQL.SqlIncluirRateioRecebimento(Pgrupo, Pseq, Pcota, vAviso, Pagente, Pnrdoc, Pdatacalculo, pSaldo));
  Result := Self;
end;

function TModelPagamentos.ExcluirComissaoPermanencia(pAgente, pNrDoc: string
  ): iModelPagamentos;
begin
  Result := Self;
  FQuery.Executar(Format(FSQL.SqlExcluirMovimento,[QuotedStr(Pagente), QuotedStr(Pnrdoc)]));
  FQuery.Executar(Format(FSQL.SqlExcluirDocumento,[QuotedStr(Pagente), QuotedStr(Pnrdoc)]));
end;

function TModelPagamentos.CotaTemCorrecoes(pGrupo, pSeq, pCota: String
  ): Boolean;
begin
  Result := FQuery.Open(FSQL.SqlRetornaNumeroCorrecoes(pGrupo, pSeq, pCota))
                  .Dataset
                  .FieldByName('NUM').AsInteger > 0;
end;

function TModelPagamentos.DataSet: TDataSet;
var
  vDataset: TDataSet;
begin
  vDataset :=  FQuery.Dataset;
  FormataCampoTexto(vDataset.FindField('GRUPO'), 'Grupo', 5, taCenter);
  FormataCampoTexto(vDataset.FindField('TIPO_MOV'), 'Tp', 2, taCenter);
  FormataCampoTexto(vDataset.FindField('DCTIPOMOV'), 'Desc', 15, taLeftJustify);
  FormataCampoNumerico(vDataset.FindField('F_AQUISI'),'Aquis.',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('ADMINIST'),'Adm.',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('F_RESERV'),'Res.',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('OUTROS'),'Seg/Out',8, taRightJustify);
  FormataCampoData(vDataset.FindField('DT_PAGTO'),'Pagto',8,taCenter);
  FormataCampoData(vDataset.FindField('D_CONTAB'),'Contb',8,taCenter);
  FormataCampoData(vDataset.FindField('D_VENCTO'),'Vencto',8,taCenter);
  Result := vDataset;
end;

function TModelPagamentos.TemDados: Boolean;
begin
  Result := not FQuery.Dataset.EOF;
end;

function TModelPagamentos.Proximo: Boolean;
begin
  FQuery.Dataset.Next;
  Result := TemDados;
end;

function TModelPagamentos.AVISO: String;
begin
  Result := FQuery.FieldByName('AVISO').AsString;
end;

function TModelPagamentos.TIPO_MOV: String;
begin
  Result := FQuery.FieldByName('TIPO_MOV').AsString;
end;

function TModelPagamentos.DCTIPOMOV: String;
begin
  Result := FQuery.FieldByName('DCTIPOMOV').AsString;
end;

function TModelPagamentos.D_VENCTO: TDateTime;
begin
  Result := FQuery.FieldByName('D_VENCTO').AsDateTime;
end;

function TModelPagamentos.DT_PAGTO: TDateTime;
begin
  Result := FQuery.FieldByName('DT_PAGTO').AsDateTime;
end;

function TModelPagamentos.P_NORMAL: Double;
begin
  Result := FQuery.FieldByName('P_NORMAL').AsFloat;
end;

function TModelPagamentos.P_DIFER: Double;
begin
  Result := FQuery.FieldByName('P_DIFER').AsFloat;
end;

function TModelPagamentos.P_ANTEC: Double;
begin
  Result := FQuery.FieldByName('P_ANTEC').AsFloat;
end;

function TModelPagamentos.P_RATEIO: Double;
begin
  Result := FQuery.FieldByName('P_RATEIO').AsFloat;
end;

function TModelPagamentos.VALOR: Double;
begin
  Result := FQuery.FieldByName('VALOR').AsFloat;
end;

function TModelPagamentos.MUL_JUR: Double;
begin
  Result := FQuery.FieldByName('MUL_JUR').AsFloat;
end;

function TModelPagamentos.BEM: String;
begin
  Result := FQuery.FieldByName('BEM').AsString;
end;

function TModelPagamentos.F_AQUISI: Double;
begin
  Result := FQuery.FieldByName('F_AQUISI').AsFloat;
end;

function TModelPagamentos.ADMINIST: Double;
begin
  Result := FQuery.FieldByName('ADMINIST').AsFloat;
end;

function TModelPagamentos.F_RESERV: Double;
begin
  Result := FQuery.FieldByName('F_RESERV').AsFloat;
end;

function TModelPagamentos.OUTROS: Double;
begin
  Result := FQuery.FieldByName('OUTROS').AsFloat;
end;

function TModelPagamentos.SIMBOLO: String;
begin
  Result := FQuery.FieldByName('SIMBOLO').AsString;
end;

function TModelPagamentos.HISTORIC: String;
begin
  Result := FQuery.FieldByName('HISTORIC').AsString;
end;

function TModelPagamentos.D_CONTAB: TDateTime;
begin
  Result := FQuery.FieldByName('D_CONTAB').AsDateTime;
end;

function TModelPagamentos.FIL_COM: String;
begin
  Result := FQuery.FieldByName('FIL_COM').AsString;
end;

function TModelPagamentos.DCBEM: String;
begin
  Result := FQuery.FieldByName('DESCRIC').AsString;
end;

function TModelPagamentos.ESTORNADO: Boolean;
begin
  Result := StrToIntDef(FQuery.Dataset.FindField('AV_ASSOC').AsString,0) > 0;
end;

end.



