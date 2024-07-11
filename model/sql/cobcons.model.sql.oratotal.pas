unit cobcons.model.sql.oratotal;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlOraTotal }

  TModelSQlOraTotal = class (TInterfacedObject, iModelSqlTotal)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlTotal;

      function SqlCriarTabela: string;
      function SqlTabelaExiste: string;
      function SqlNovo: String;
      function SqlRetornaTotal: String;
      function SqlAlterar: String;
      function SqlApagaDados: String;
      function SqlAcumularInadimplente: String;
      function SqlAcumularRnp: String;
      function SqlAcumularRateioFuturo: String;
      function SqlAtualizarRnp: String;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlOraTotal }

const
  SQL_TABELA_EXISTE =
    'select count(*) QTDE from USER_TABLES '+
    'where TABLE_NAME = ''TTGER'' ';
  SQL_APAGA_DADOS = 'delete from TTGER';
  SQL_CRIAR =
    'create table TTGER ( '+
       'ID integer not null primary key, '+
       'DTCALC date, '+
       'QTDINAGRU integer default 0, '+
       'QTDINACOTA integer default 0, '+
       'QTDRNPGRU integer default 0, '+
       'QTDRNPCOTA integer default 0, '+
       'QTDRATGRU integer default 0, '+
       'QTDRATCOTA integer default 0, '+
       'VLRRAT float default 0, '+
       'BEMAPREENDIDO float default 0, '+
       'VLRJURIDICO float default 0, '+
       'VLRMEDIACAO float default 0, '+
       'VLRINA float generated always as ( VLRJURIDICO + VLRMEDIACAO ), '+
       'VLRRNP float default 0 ) ';
  SQL_CONSULTA =
    'select * from TTGER where ID = 1';
  SQL_NOVO =
    'insert into TTGER (ID, DTCALC) values ( 1, %s)';
  SQL_ALTERAR =
    'update TTGER set DTCALC = %s, QTDINAGRU = 0, QTDINACOTA = 0, QTDRNPGRU = 0, '+
                     'QTDRNPCOTA = 0, QTDRATGRU = 0, QTDRATCOTA = 0, VLRRAT = 0, '+
                     'BEMAPREENDIDO = 0, VLRJURIDICO = 0, VLRMEDIACAO = 0, VLRRNP = 0 '+
    'where ID = 1';
  SQL_ACUMULAR_INADIMPLENTE =
    'update TTGER set QTDINAGRU = QTDINAGRU + %d, QTDINACOTA = QTDINACOTA + 1, '+
                     'BEMAPREENDIDO = BEMAPREENDIDO + %f, VLRJURIDICO = VLRJURIDICO + %f, '+
                     'VLRMEDIACAO = VLRMEDIACAO + %f '+
    'where ID = 1';
  SQL_ACUMULAR_RNP =
    'update TTGER set QTDRNPGRU = QTDRNPGRU + %d, QTDRNPCOTA = QTDRNPCOTA + 1, '+
                     'VLRRNP = VLRRNP + %f '+
    'where ID = 1';
  SQL_ACUMULAR_RATEIO_FUTURO =
    'update TTGER set QTDRATGRU = QTDRATGRU + %d, QTDRATCOTA = QTDRATCOTA + 1, '+
                     'VLRRAT = VLRRAT + %f '+
    'where ID = 1';
  SQL_ATUALIZAR_RNP =
    'update TTGER T set '+
            'T.QTDRNPGRU = (select count(*) from TTGRU G where G.QTDRNP > 0), '+
            'T.QTDRNPCOTA = (select sum(G.QTDRNP) from TTGRU G where G.QTDRNP > 0), '+
            'T.VLRRNP = (select sum(G.VLRRNP) from TTGRU G where G.VLRRNP > 0)';

constructor Tmodelsqloratotal.Create;
begin

end;

destructor Tmodelsqloratotal.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqloratotal.New: Imodelsqltotal;
begin
  Result := Self.Create;
end;

function Tmodelsqloratotal.Sqlcriartabela: String;
begin
  Result := SQL_CRIAR;
end;

function Tmodelsqloratotal.Sqltabelaexiste: String;
begin
  Result := SQL_TABELA_EXISTE;
end;

function Tmodelsqloratotal.Sqlnovo: String;
begin
  Result := Format(SQL_NOVO, [QuotedStr(RetornaDataSql(Date))]);
end;

function Tmodelsqloratotal.Sqlretornatotal: String;
begin
  Result := SQL_CONSULTA;
end;

function Tmodelsqloratotal.Sqlalterar: String;
begin
  Result := SQL_ALTERAR;
end;

function Tmodelsqloratotal.Sqlapagadados: String;
begin
  Result := SQL_APAGA_DADOS;
end;

function Tmodelsqloratotal.Sqlacumularinadimplente: String;
begin
  Result := SQL_ACUMULAR_INADIMPLENTE;
end;

function Tmodelsqloratotal.Sqlacumularrnp: String;
begin
  Result := SQL_ACUMULAR_RNP;
end;

function Tmodelsqloratotal.Sqlacumularrateiofuturo: String;
begin
  Result := SQL_ACUMULAR_RATEIO_FUTURO;
end;

function Tmodelsqloratotal.Sqlatualizarrnp: String;
begin
  Result := SQL_ATUALIZAR_RNP;
end;

end.

