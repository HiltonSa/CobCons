unit cobcons.model.cota;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TModelCota }

   TModelCota = class (TInterfacedObject, iModelCota)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlCota;

       FGrupo: string;
       FSeq: String;
       FCota: String;
       FTelefone: String;
       FEndereco: String;
       FBairro: String;
       FCidade: String;
       FUf: string;
       FCep: String;
       FSitCob: String;

       function RetornarSQL(pTipo: Integer): string;
       procedure IniciarVariaveis;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelCota;

       function PesquisarGrupoSeqCota(pGrupo, pSeq, pCota: String): iModelCota;
       function PesquisarNome(pNome: String): iModelCota;
       function PesquisarCpfCnpj(pInscricao: String): iModelCota;
       function RetornarCotasGrupo(pGrupo: String): iModelCota;
       function Retornainadimplentes(Pencct, pFaseAjuiz: String): Imodelcota;
       function RetornaRNP(Pencct: String): Imodelcota;
       function RetornaSaldoRNP(pInicio, pFim: Integer): String;
       function RetornaCotasRNP(pInicio, pFim: Integer): Imodelcota;
       function RetornaRateioFuturo(pGrupo: String): Imodelcota;
       function AlterarEndereco: iModelCota;
       function AlterarSitCota: iModelCota;
       function Dataset: TDataSet;
       function TemDados: Boolean;
       function Proximo: Boolean;
       function GRUPO: String; overload;
       function SEQ: String; overload;
       function COTA: String; overload;
       function GRUPO(aValue: String): iModelCota; overload;
       function SEQ(aValue: String): iModelCota; overload;
       function COTA(aValue: String): iModelCota; overload;
       function CONTRATO: String;
       function NOME: String;
       function PLANO: String;
       function P_MENSAL: Double;
       function P_ADMINS: Double;
       function P_RESERV: Double;
       function TP_SEGUR: String;
       function PERSEGVD: Double;
       function SIT_COBR: String; overload;
       function PERCPAGO: Double;
       function PERDEV: Double;
       function PERRAT: Double;
       function ADMINIST: Double;
       function DT_VENDA: TDateTime;
       function REPRES: String;
       function NMREPRES: String;
       function DT_ADES: TDateTime;
       function REU_ADES: String;
       function FIL_ATE: String;
       function FIL_COM: String;
       function NMFILATE: String;
       function BEM: String;
       function DESCRIC: String;
       function TIPO_BEM: String;
       function DCTIPOBEM: String;
       function FABRICAN: String;
       function DCFABBEM: String;
       function PRE_TABE: Double;
       function TP_CONTE: String;
       function DCTPCONTE: String;
       function DT_CONTE: TDateTime;
       function DT_ENTRE: TDateTime;
       function VAL_ENTR: Double;
       function PESS_F_J: String;
       function CGC_CPF: String;
       function DOCUMENT: String;
       function E_CIVIL: String;
       function DCECIVIL: string;
       function DT_NASC: TDateTime;
       function SEXO: String;
       function PROFISS: String;
       function DCPROF: String;
       function TELEFONE: String; overload;
       function ENDERECO: String; overload;
       function BAIRRO: String; overload;
       function CIDADE: String; overload;
       function ESTADO: String; overload;
       function CEP: String; overload;
       function TELEFONE(aValue: String): iModelCota; overload;
       function ENDERECO(aValue: String): iModelCota; overload;
       function BAIRRO(aValue: String): iModelCota; overload;
       function CIDADE(aValue: String): iModelCota; overload;
       function ESTADO(aValue: String): iModelCota; overload;
       function CEP(aValue: String): iModelCota; overload;
       function SIT_COBR(aValue: String): iModelCota; overload;
       function DCSITCOB: String;
       function CGCCPFMT: String;
       function TP_COTA: String;
       function DCTPCOTA: String;
       function AG_COBRA: string;
       function ULTREU: TDateTime;
       function TP_PESS: string;
       function DTAJUIZ: TDateTime;
       function DTENCCT: TDateTime;
       function REGAPLIC: string;
       function TXPER: Double;
   end;


implementation

uses cobcons.controller.util, cobcons.model.sql.factory;

{ TModelCota }

function TModelCota.RetornarSQL(pTipo: Integer): string;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  case Ptipo of
    1: vSql := Format( FSQL.RetornaSqlAlterarEndereco,
                     [ QuotedStr(FTelefone),
                       QuotedStr(FEndereco),
                       QuotedStr(FBairro),
                       QuotedStr(FCidade),
                       QuotedStr(FUf),
                       QuotedStr(RetornaSemFormatacao(FCep)),
                       QuotedStr(FGrupo),
                       QuotedStr(FSeq),
                       QuotedStr(FCota)]);
    2: vSql := Format( FSQL.RetornaSqlAlterarSitCota,
                     [ QuotedStr(FSitCob),
                       QuotedStr(RetornaDataSql(Date)),
                       QuotedStr(FGrupo),
                       QuotedStr(FSeq),
                       QuotedStr(FCota)]);

  end;
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

procedure TModelCota.IniciarVariaveis;
begin
  FGrupo := FQuery.FieldByName('GRUPO').AsString;
  FSeq := FQuery.FieldByName('SEQ').AsString;
  FCota := FQuery.FieldByName('COTA').AsString;
end;

constructor TModelCota.Create(aQuery: iQueryRest);
begin
  FQuery := Aquery;
  FSQL := TModelSQLFactory.New.SqlCota;
end;

destructor TModelCota.Destroy;
begin
  inherited Destroy;
end;

class function TModelCota.New(aQuery: iQueryRest): iModelCota;
begin
  Result := Self.Create(Aquery);
end;

function TModelCota.PesquisarGrupoSeqCota(pGrupo, pSeq, pCota: String
  ): iModelCota;
begin
  Result := Self;
  FQuery.Open( FSQL.RetornaSqlPesquisarGrupoSeqCota(Pgrupo, Pseq, Pcota) );
  IniciarVariaveis;
end;

function TModelCota.PesquisarNome(pNome: String): iModelCota;
begin
  Result := Self;
  FQuery.Open( FSQL.RetornaSqlPesquisaNome(Pnome) );
end;

function TModelCota.PesquisarCpfCnpj(pInscricao: String): iModelCota;
begin
  Result := Self;
  FQuery.Open( FSQL.RetornaSqlPesquisarCpfCnpj(Pinscricao) );
end;

function TModelCota.RetornarCotasGrupo(pGrupo: String): iModelCota;
begin
  Result := Self;
  FQuery.Open( FSQL.RetornaSqlCotasGrupo(Pgrupo) );
end;

function TModelCota.Retornainadimplentes(Pencct, pFaseAjuiz: String
  ): Imodelcota;
begin
  Result := Self;
  FQuery.Open( FSQL.RetornaSqlRetornainadimplentes( Pencct, Pfaseajuiz) );
end;

function TModelCota.RetornaRNP(Pencct: String): Imodelcota;
begin
  Result := Self;
  FQuery.Open( FSQL.RetornaSqlRNP( Pencct ) );
end;

function TModelCota.RetornaSaldoRNP(pInicio, pFim: Integer): String;
begin
  Result := FSQL.RetornaSqlSaldoRNP(pInicio, pFim);
end;

function TModelCota.RetornaCotasRNP(pInicio, pFim: Integer): Imodelcota;
begin
  Result := Self;
  FQuery.Open( FSQL.RetornaSqlSaldoRNP(pInicio, pFim));
end;

function TModelCota.RetornaRateioFuturo(pGrupo: String): Imodelcota;
begin
  Result := Self;
  FQuery.Open( FSQL.RetornaSqlRateioFuturo( Pgrupo ) );
end;

function TModelCota.AlterarEndereco: iModelCota;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(1));
end;

function TModelCota.AlterarSitCota: iModelCota;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(2));
end;

function TModelCota.Dataset: TDataSet;
const
  NAO_ENCONTRADO = -1;
var
  vLista: TStringList;
  vDataset: TDataSet;
begin
  vDataset :=  FQuery.Dataset;
  vLista := TStringList.Create;
  try
    vDataset.GetFieldNames(vLista);
    //if vLista.IndexOf('CODIGO') > NAO_ENCONTRADO
    //then TIntegerField(vDataset.FieldByName('CODIGO')).DisplayFormat := '000000';
    //if vLista.IndexOf('CONTRATO') > NAO_ENCONTRADO
    //then TIntegerField(vDataset.FieldByName('CONTRATO')).DisplayFormat := '000000';
    //if vLista.IndexOf('PCL') > NAO_ENCONTRADO
    //then TIntegerField(vDataset.FieldByName('PCL')).DisplayFormat := '000';
    //if vLista.IndexOf('DATA') > NAO_ENCONTRADO
    //then TDateTimeField(vDataset.FieldByName('DATA')).DisplayFormat := 'dd/mm/yyyy';
    //if vLista.IndexOf('DTVENC') > NAO_ENCONTRADO
    //then TDateTimeField(vDataset.FieldByName('DATA')).DisplayFormat := 'dd/mm/yyyy';
    //if vLista.IndexOf('BAIXA') > NAO_ENCONTRADO
    //then TDateTimeField(vDataset.FieldByName('BAIXA')).DisplayFormat := 'dd/mm/yyyy hh:mm';
    //if vLista.IndexOf('DTPAGTO') > NAO_ENCONTRADO
    //then TDateTimeField(vDataset.FieldByName('DTPAGTO')).DisplayFormat := 'dd/mm/yyyy';
    //if vLista.IndexOf('CEP') > NAO_ENCONTRADO
    //then TDateTimeField(vDataset.FieldByName('CEP')).DisplayFormat := 'mm/yy';
    if vLista.IndexOf('PRE_TABE') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('PRE_TABE')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('F_AQUISI') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('F_AQUISI')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('ADMINIST') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('ADMINIST')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('F_RESERV') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('F_RESERV')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('OUTROS') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('OUTROS')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('TOTPAGO') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('TOTPAGO')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('VAL_ENTR') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('VAL_ENTR')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('P_ADMINS') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('P_ADMINS')).DisplayFormat := ',#0.0000';
    if vLista.IndexOf('P_RESERV') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('P_RESERV')).DisplayFormat := ',#0.0000';
    if vLista.IndexOf('PERCPAGO') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('PERCPAGO')).DisplayFormat := ',#0.0000';
    if vLista.IndexOf('PERDEV') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('PERDEV')).DisplayFormat := ',#0.0000';
    if vLista.IndexOf('PERRAT') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('PERRAT')).DisplayFormat := ',#0.0000';
    if vLista.IndexOf('P_RATEAD') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('P_RATEAD')).DisplayFormat := ',#0.0000';
    if vLista.IndexOf('P_RA_PAG') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('P_RA_PAG')).DisplayFormat := ',#0.0000';
    if vLista.IndexOf('P_MENSAL') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('P_MENSAL')).DisplayFormat := ',#0.0000';
    if vLista.IndexOf('PERSEGVD') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('PERSEGVD')).DisplayFormat := ',#0.000000';
    Result := vDataset;
  finally
    vLista.Free;
  end;
end;

function TModelCota.TemDados: Boolean;
begin
  Result := not FQuery.Dataset.EOF;
end;

function TModelCota.Proximo: Boolean;
begin
  FQuery.Dataset.Next;
  Result := TemDados;
end;

function TModelCota.GRUPO: String;
begin
  Result := FQuery.FieldByName('GRUPO').AsString;
end;

function TModelCota.SEQ: String;
begin
  Result := FQuery.FieldByName('SEQ').AsString;
end;

function TModelCota.COTA: String;
begin
  Result := FQuery.FieldByName('COTA').AsString;
end;

function TModelCota.GRUPO(aValue: String): iModelCota;
begin
  Result := Self;
  FGrupo := Avalue;
end;

function TModelCota.SEQ(aValue: String): iModelCota;
begin
  Result := Self;
  FSeq := Avalue;
end;

function TModelCota.COTA(aValue: String): iModelCota;
begin
  Result := Self;
  FCota := Avalue;
end;

function TModelCota.CONTRATO: String;
begin
  Result := FQuery.FieldByName('CONTRATO').AsString;
end;

function TModelCota.NOME: String;
begin
  Result := FQuery.FieldByName('NOME').AsString;
end;

function TModelCota.PLANO: String;
begin
  Result := FQuery.FieldByName('PLANO').AsString;
end;

function TModelCota.P_MENSAL: Double;
begin
  Result := FQuery.FieldByName('P_MENSAL').AsFloat;
end;

function TModelCota.P_ADMINS: Double;
begin
  Result := FQuery.FieldByName('P_ADMINS').AsFloat;
end;

function TModelCota.P_RESERV: Double;
begin
  Result := FQuery.FieldByName('P_RESERV').AsFloat;
end;

function TModelCota.TP_SEGUR: String;
begin
  Result := FQuery.FieldByName('TP_SEGUR').AsString;
end;

function TModelCota.PERSEGVD: Double;
begin
  Result := FQuery.FieldByName('PERSEGVD').AsFloat;
end;

function TModelCota.SIT_COBR: String;
begin
  Result := FQuery.FieldByName('SIT_COBR').AsString;
end;

function TModelCota.PERCPAGO: Double;
begin
  Result := FQuery.FieldByName('PERCPAGO').AsFloat;
end;

function TModelCota.PERDEV: Double;
begin
  Result := FQuery.FieldByName('PERDEV').AsFloat;
end;

function TModelCota.PERRAT: Double;
begin
  Result := FQuery.FieldByName('PERRAT').AsFloat;
end;

function TModelCota.ADMINIST: Double;
begin
  Result := FQuery.FieldByName('ADMINIST').AsFloat;
end;

function TModelCota.DT_VENDA: TDateTime;
begin
  Result := FQuery.FieldByName('DT_VENDA').AsDateTime;
end;

function TModelCota.REPRES: String;
begin
  Result := FQuery.FieldByName('REPRES').AsString;
end;

function TModelCota.NMREPRES: String;
begin
  Result := FQuery.FieldByName('NMREPRES').AsString;
end;

function TModelCota.DT_ADES: TDateTime;
begin
  Result := FQuery.FieldByName('DT_ADES').AsDateTime;
end;

function TModelCota.REU_ADES: String;
begin
  Result := FQuery.FieldByName('REU_ADES').AsString;
end;

function TModelCota.FIL_ATE: String;
begin
  Result := FQuery.FieldByName('FIL_ATE').AsString;
end;

function TModelCota.FIL_COM: String;
begin
  Result := FQuery.FieldByName('FIL_COM').AsString;
end;

function TModelCota.NMFILATE: String;
begin
  Result := FQuery.FieldByName('NMFILATE').AsString;
end;

function TModelCota.BEM: String;
begin
  Result := FQuery.FieldByName('BEM').AsString;
end;

function TModelCota.DESCRIC: String;
begin
  Result := FQuery.FieldByName('DESCRIC').AsString;
end;

function TModelCota.TIPO_BEM: String;
begin
  Result := FQuery.FieldByName('TIPO_BEM').AsString;
end;

function TModelCota.DCTIPOBEM: String;
begin
  Result := FQuery.FieldByName('DCTIPOBEM').AsString;
end;

function TModelCota.FABRICAN: String;
begin
  Result := FQuery.FieldByName('FABRICAN').AsString;
end;

function TModelCota.DCFABBEM: String;
begin
  Result := FQuery.FieldByName('DCFABBEM').AsString;
end;

function TModelCota.PRE_TABE: Double;
begin
  Result := FQuery.FieldByName('PRE_TABE').AsFloat;
end;

function TModelCota.TP_CONTE: String;
begin
  Result := FQuery.FieldByName('TP_CONTE').AsString;
end;

function TModelCota.DCTPCONTE: String;
const
  TPCON = 'ALS';
begin
  case Pos(FQuery.FieldByName('TP_CONTE').AsString, TPCON) of
    1: Result := 'Automático';
    2: Result := 'Lance';
    3: Result := 'Sorteio';
    else Result := 'Não Contemplado';
  end;
end;

function TModelCota.DT_CONTE: TDateTime;
begin
  Result := FQuery.FieldByName('DT_CONTE').AsDateTime;
end;

function TModelCota.DT_ENTRE: TDateTime;
begin
  Result := FQuery.FieldByName('DT_ENTRE').AsDateTime;
end;

function TModelCota.VAL_ENTR: Double;
begin
  Result := FQuery.FieldByName('VAL_ENTR').AsFloat;
end;

function TModelCota.PESS_F_J: String;
begin
  Result := FQuery.FieldByName('PESS_F_J').AsString;
end;

function TModelCota.CGC_CPF: String;
begin
  Result := FQuery.FieldByName('CGC_CPF').AsString;
end;

function TModelCota.DOCUMENT: String;
begin
  Result := FQuery.FieldByName('DOCUMENT').AsString;
end;

function TModelCota.E_CIVIL: String;
begin
  Result := FQuery.FieldByName('E_CIVIL').AsString;
end;

function TModelCota.DCECIVIL: string;
begin
  Result := FQuery.FieldByName('DCECIVIL').AsString;
end;

function TModelCota.DT_NASC: TDateTime;
begin
  Result := FQuery.FieldByName('DT_NASC').AsDateTime;
end;

function TModelCota.SEXO: String;
begin
  Result := FQuery.FieldByName('SEXO').AsString;
end;

function TModelCota.PROFISS: String;
begin
  Result := FQuery.FieldByName('PROFISS').AsString;
end;

function TModelCota.DCPROF: String;
begin
  Result := FQuery.FieldByName('DCPROF').AsString;
end;

function TModelCota.TELEFONE: String;
begin
  Result := FQuery.FieldByName('TELEFONE').AsString;
end;

function TModelCota.ENDERECO: String;
begin
  Result := Trim(FQuery.FieldByName('ENDERECO').AsString);
end;

function TModelCota.BAIRRO: String;
begin
  Result := FQuery.FieldByName('BAIRRO').AsString;
end;

function TModelCota.CIDADE: String;
begin
  Result := FQuery.FieldByName('CIDADE').AsString;
end;

function TModelCota.ESTADO: String;
begin
  Result := FQuery.FieldByName('ESTADO').AsString;
end;

function TModelCota.CEP: String;
begin
  Result := FQuery.FieldByName('CEP').AsString;
end;

function TModelCota.TELEFONE(aValue: String): iModelCota;
begin
  Result := Self;
  FTelefone := Avalue;
end;

function TModelCota.ENDERECO(aValue: String): iModelCota;
begin
  Result := Self;
  FEndereco := Avalue;
end;

function TModelCota.BAIRRO(aValue: String): iModelCota;
begin
  Result := Self;
  FBairro := Avalue;
end;

function TModelCota.CIDADE(aValue: String): iModelCota;
begin
  Result := Self;
  FCidade := Avalue;
end;

function TModelCota.ESTADO(aValue: String): iModelCota;
begin
  Result := Self;
  FUf := Avalue;
end;

function TModelCota.CEP(aValue: String): iModelCota;
begin
  Result := Self;
  FCep := Avalue;
end;

function TModelCota.SIT_COBR(aValue: String): iModelCota;
begin
  Result := Self;
  FSitCob := Avalue;
end;

function TModelCota.DCSITCOB: String;
const
  SITCOB = 'NMJQCDT';
begin
  case Pos(FQuery.FieldByName('SIT_COBR').AsString, SITCOB) of
    0: Result :=  Format('(%s) Indefinido',[ FQuery.FieldByName('SIT_COBR').AsString ]);
    1: Result := 'Normal';
    2: Result := 'Mediação';
    3: Result := 'Jurídico';
    4: Result := 'Quitado';
    5: Result := 'Cancelado';
    6: Result := 'Desistente';
    7: Result := 'Transferido';
  end;
end;

function TModelCota.CGCCPFMT: String;
begin
  Result := FQuery.FieldByName('CGCCPFMT').AsString;
end;

function TModelCota.TP_COTA: String;
begin
  Result := FQuery.FieldByName('TP_COTA').AsString;
end;

function TModelCota.DCTPCOTA: String;
begin
  Result := FQuery.FieldByName('DCTPCOTA').AsString;
end;

function TModelCota.AG_COBRA: string;
begin
  Result := FQuery.FieldByName('AG_COBRA').AsString;
end;

function TModelCota.ULTREU: TDateTime;
begin
  Result := FQuery.FieldByName('ULTREU').AsDateTime;
end;

function TModelCota.TP_PESS: string;
begin
  Result := FQuery.FieldByName('TP_PESS').AsString;
end;

function TModelCota.DTAJUIZ: TDateTime;
begin
  Result := FQuery.FieldByName('DTAJUIZ').AsDateTime;
end;

function TModelCota.DTENCCT: TDateTime;
begin
  Result := FQuery.FieldByName('DTENCCT').AsDateTime;
end;

function TModelCota.REGAPLIC: string;
begin
  Result := FQuery.FieldByName('REGAPLIC').AsString;
end;

function TModelCota.TXPER: Double;
begin
  Result := FQuery.FieldByName('ADM_PERM').AsFloat;
end;

end.



