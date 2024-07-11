unit cobcons.model.pendencia;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TModelPendencia }

   TModelPendencia = class (TInterfacedObject, iModelPendencia)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlPendencia;
       FGrupo: String;
       FSeq: String;
       FCota: String;
       FAviso: String;
       FTipoMov: String;
       FAgCobra: String;
       FVencto: TDateTime;
       FPcNor: Double;
       FPRateio: Double;
       FAquisi: Double;
       FAdminist: Double;
       FReserva: Double;
       FOutros: Double;

       function RetornarSQL(pTipo: Integer): string;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelPendencia;

       function RetornaPendenciaCota(pGrupo, pSeq, pCota: String): iModelPendencia;
       function RetornaAviso(pGrupo, pSeq, pCota, pAviso: String): iModelPendencia;
       function Novo: iModelPendencia;
       function Excluir: iModelPendencia;
       function ExcluirSQG: iModelPendencia;
       function ProximoAviso: String;
       function DataSet: TDataSet;
       function GRUPO(aValue: String): iModelPendencia;
       function SEQ(aValue: String): iModelPendencia;
       function COTA(aValue: String): iModelPendencia;
       function AVISO(aValue: String): iModelPendencia; overload;
       function TIPO_MOV(aValue: String): iModelPendencia; overload;
       function AG_COBRA(aValue: String): iModelPendencia;
       function D_VENCTO(aValue: TDateTime): iModelPendencia; overload;
       function PCNOR(aValue: Double): iModelPendencia; overload;
       function P_RATEIO(aValue: Double): iModelPendencia; overload;
       function F_AQUISI(aValue: Double): iModelPendencia; overload;
       function ADMINIST(aValue: Double): iModelPendencia; overload;
       function F_RESERV(aValue: Double): iModelPendencia; overload;
       function OUTROS(aValue: Double): iModelPendencia; overload;
       function AVISO: String; overload;
       function TIPO_MOV: String; overload;
       function D_VENCTO: TDateTime; overload;
       function PCNOR: Double; overload;
       function OUTROS: Double; overload;
       function F_AQUISI: Double; overload;
       function ADMINIST: Double; overload;
       function F_RESERV: Double; overload;
       function P_RATEIO: Double; overload;
       function VALOR: Double;
       function DCTIPOMOV: String;
   end;


implementation

uses cobcons.controller.util, cobcons.model.sql.factory;

const
  SQL_CAMPOS =
       'select C.AVISO, C.TIPO_MOV, T.SIGLA1 DCTIPOMOV, C.D_VENCTO, T.MUL_JUR, '+
              'CLI.FIL_COM, CLI.BEM, cast(C.P_NORMAL as float) + cast(C.P_DIFER as float) + '+
              'cast(C.P_SUBST as float) PCNOR, cast(C.P_RATEIO as float) P_RATEIO, '+
              '(cast(C.F_AQUISI as float) + cast(C.F_RESERV as float) + '+
              'cast(C.OUTROS as float) + cast(C.ADMINIST as float)) VALOR, '+
              'cast(C.OUTROS as float) OUTROS, cast(C.F_AQUISI as float) F_AQUISI, '+
              'cast(C.F_RESERV as float) F_RESERV, cast(C.ADMINIST as float) ADMINIST '+
       'from ACCOB C '+
       'inner join ACTMV T on T.COD_MOV = C.TIPO_MOV '+
       'inner join ACCLI CLI on CLI.GRUPO = C.GRUPO and CLI.SEQ = C.SEQ and CLI.COTA = C.COTA ';
  SQL_PENDENCIA_COTA = SQL_CAMPOS +
       'where C.GRUPO = %s and C.SEQ = %s and C.COTA = %s '+
       'order by C.D_VENCTO DESC ';
  SQL_AVISO =
       'where C.GRUPO = %s and C.SEQ = %s and C.COTA = %s and C.AVISO = %s';

  SQL_INSERIR =
       'insert into ACCOB ( GRUPO, SEQ, COTA, AVISO, TIPO_MOV, D_VENCTO, AG_COBRA, '+
                           'P_NORMAL, P_RATEIO, P_SUBST, P_DIFER, F_AQUISI, ADMINIST, '+
                           'F_RESERV, OUTROS, DT_BASE, P_ANTEC, SEG_OUT,  USUARIO, '+
                           'D_ATUALI, TP_ABONO, MUL_JUR,   COBRADOR, TAR_BANC, AV_ASSOC, '+
                           'FILLER, ADM_DESC) '+
                  'values ( %s, %s, %s, %s, %s, %s, %s, %f, %f, 0.0, 0.0, %f, %f, %f, %f, '+
                           '%s, 0.0, ''O'', ''0000'', %s, ''00'', 0.0, ''000000'', 0.0, '+
                           '''000000'',  '' '', 0.0)';
  SQL_EXCLUIR =
       'delete from ACCOB where GRUPO = %s and SEQ = %s and COTA = %s and AVISO = %s';
  SQL_PROXIMO =
       'select max(cast(AVISO as integer)) + 1 as MCOD from ACCOB '+
       'where GRUPO = %s and SEQ = %S and COTA = %s';

{ TModelPendencia }

function TModelPendencia.RetornarSQL(pTipo: Integer): string;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  case Ptipo of
    0: vSql := Format( FSQL.SqlNovo, [
                       QuotedStr(FGrupo),
                       QuotedStr(FSeq),
                       QuotedStr(FCota),
                       QuotedStr(FAviso),
                       QuotedStr(FTipoMov),
                       QuotedStr(RetornaDataSql(FVencto)),
                       QuotedStr(FAgCobra),
                       FPcNor,
                       FPRateio,
                       FAquisi,
                       FAdminist,
                       FReserva,
                       FOutros,
                       QuotedStr(RetornaDataSql(Date)),
                       QuotedStr(RetornaDataSql(Date))
                       ]);
    2: vSql := Format( FSQL.SqlProximoAviso, [
                       QuotedStr(FGrupo),
                       QuotedStr(FSeq),
                       QuotedStr(FCota)]);
    3: vSql := Format( FSQL.SqlExcluir, [
                       QuotedStr(FGrupo),
                       QuotedStr(FSeq),
                       QuotedStr(FCota),
                       QuotedStr(FAviso)]);
    4: vSql := Format( FSQL.SqlExcluir, [
                       QuotedStr(FGrupo),
                       QuotedStr(FSeq),
                       QuotedStr(FCota)]);
  end;
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

constructor TModelPendencia.Create(aQuery: iQueryRest);
begin
  FQuery := Aquery;
  FSQL := TModelSQLFactory.New.SqlPendencia;
end;

destructor TModelPendencia.Destroy;
begin
  inherited Destroy;
end;

class function TModelPendencia.New(aQuery: iQueryRest): iModelPendencia;
begin
  Result := Self.Create(Aquery);
end;

function TModelPendencia.RetornaPendenciaCota(pGrupo, pSeq, pCota: String
  ): iModelPendencia;
begin
  Result := Self;
  FQuery.Open( FSQL.SqlRetornaPendenciaCota( Pgrupo, Pseq, Pcota));
end;

function TModelPendencia.RetornaAviso(pGrupo, pSeq, pCota, pAviso: String
  ): iModelPendencia;
begin
  Result := Self;
  FQuery.Open( FSQL.SqlRetornaAviso(Pgrupo, Pseq, Pcota, Paviso));
end;

function TModelPendencia.Novo: iModelPendencia;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(0));
end;

function TModelPendencia.Excluir: iModelPendencia;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(3));
end;

function TModelPendencia.ExcluirSQG: iModelPendencia;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(4));
end;

function TModelPendencia.ProximoAviso: String;
begin
  FQuery.Open(RetornarSQL(2));
  if FQuery.FieldByName('MCOD').AsInteger <= 0
  then Result := '000001'
  else Result := Format('%.6d',[ FQuery.FieldByName('MCOD').AsInteger]);
end;

function TModelPendencia.DataSet: TDataSet;
begin
  Result := FQuery.Dataset;
end;

function TModelPendencia.GRUPO(aValue: String): iModelPendencia;
begin
  Result := Self;
  FGrupo := aValue;
end;

function TModelPendencia.SEQ(aValue: String): iModelPendencia;
begin
  Result := Self;
  FSeq := aValue;
end;

function TModelPendencia.COTA(aValue: String): iModelPendencia;
begin
  Result := Self;
  FCota := aValue;
end;

function TModelPendencia.AVISO(aValue: String): iModelPendencia;
begin
  Result := Self;
  FAviso := aValue;
end;

function TModelPendencia.TIPO_MOV(aValue: String): iModelPendencia;
begin
  Result := Self;
  FTipoMov := aValue;
end;

function TModelPendencia.AG_COBRA(aValue: String): iModelPendencia;
begin
  Result := Self;
  FAgCobra := aValue;
end;

function TModelPendencia.D_VENCTO(aValue: TDateTime): iModelPendencia;
begin
  Result := Self;
  FVencto := aValue;
end;

function TModelPendencia.PCNOR(aValue: Double): iModelPendencia;
begin
  Result := Self;
  FPcNor := aValue;
end;

function TModelPendencia.P_RATEIO(aValue: Double): iModelPendencia;
begin
  Result := Self;
  FPRateio := aValue;
end;

function TModelPendencia.F_AQUISI(aValue: Double): iModelPendencia;
begin
  Result := Self;
  FAquisi := aValue;
end;

function TModelPendencia.ADMINIST(aValue: Double): iModelPendencia;
begin
  Result := Self;
  FAdminist := aValue;
end;

function TModelPendencia.F_RESERV(aValue: Double): iModelPendencia;
begin
  Result := Self;
  FReserva := aValue;
end;

function TModelPendencia.OUTROS(aValue: Double): iModelPendencia;
begin
  Result := Self;
  FOutros := aValue;
end;

function TModelPendencia.AVISO: String;
begin
  Result := FQuery.FieldByName('AVISO').AsString;
end;

function TModelPendencia.TIPO_MOV: String;
begin
  Result := FQuery.FieldByName('TIPO_MOV').AsString;
end;

function TModelPendencia.DCTIPOMOV: String;
begin
  Result := FQuery.FieldByName('DCTIPOMOV').AsString;
end;

function TModelPendencia.D_VENCTO: TDateTime;
begin
  Result := FQuery.FieldByName('D_VENCTO').AsDateTime;
end;

function TModelPendencia.PCNOR: Double;
begin
  Result := FQuery.FieldByName('PCNOR').AsFloat;
end;

function TModelPendencia.P_RATEIO: Double;
begin
  Result := FQuery.FieldByName('P_RATEIO').AsFloat;
end;

function TModelPendencia.VALOR: Double;
begin
  Result := FQuery.FieldByName('VALOR').AsFloat;
end;

function TModelPendencia.OUTROS: Double;
begin
  Result := FQuery.FieldByName('OUTROS').AsFloat;
end;


function TModelPendencia.F_AQUISI: Double;
begin
  Result := FQuery.FieldByName('F_AQUISI').AsFloat;
end;

function TModelPendencia.ADMINIST: Double;
begin
  Result := FQuery.FieldByName('ADMINIST').AsFloat;
end;

function TModelPendencia.F_RESERV: Double;
begin
  Result := FQuery.FieldByName('F_RESERV').AsFloat;
end;

end.



