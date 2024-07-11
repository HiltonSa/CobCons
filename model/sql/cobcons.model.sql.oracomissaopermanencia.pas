unit cobcons.model.sql.oracomissaopermanencia;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlOraComissaoPermanencia }

  TModelSQlOraComissaoPermanencia = class (TInterfacedObject, iModelSqlComissaoPermanencia)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlComissaoPermanencia;

      function SqlCriarTabela: string;
      function SqlTabelaExiste: string;
      function SqlNovoCodigo: String;
      function SqlListarComissoes: String;
      function SqlListarCodigo: String;
      function SqlNovo: String;
      function SqlExcluir: String;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlOraComissaoPermanencia }

const
  SQL_BASE =
       'select C.CODIGO, C.DTEXE, C.DTCONTAB, C.AGENTE, A.NOME NMAGE, C.DOCUMENTO, '+
              'C.SDINICIAL, C.SDFINAL, C.COMISSAO '+
       'from CMPEM C '+
       'inner join ACAGE A on A.AG_FINAN = C.AGENTE ';
  SQL_LISTAR = SQL_BASE +
       'order by C.DTEXE desc';
  SQL_LISTAR_CODIGO = SQL_BASE +
       'where C.CODIGO = %d ';
  SQL_TABELA_EXISTE =
       'select count(*) QTDE from USER_TABLES '+
       'where TABLE_NAME = ''CMPEM'' ';
  SQL_APAGAR_DADOS = 'delete from CMPEM';
  SQL_CRIAR =
    'create table CMPEM ( '+
       'CODIGO integer not null primary key, '+
       'DTEXE date, '+
       'SDINICIAL float default 0, '+
       'COMISSAO float default 0, '+
       'SDFINAL float default 0, '+
       'DTCONTAB date, '+
       'AGENTE varchar(6), '+
       'DOCUMENTO varchar(6) ) ';
  SQL_NOVO =
    'insert into CMPEM (CODIGO, DTEXE, SDINICIAL, COMISSAO, SDFINAL, '+
                       'DTCONTAB, AGENTE, DOCUMENTO) '+
               'values ( %d, %s, %f, %f, %f, %s, %s, %s )';
  SQL_EXCLUIR =
    'delete from CMPEM where CODIGO = %d';
  SQL_NOVO_CODIGO =
       'select max( CODIGO ) + 1  MAXCOD from CMPEM ';

constructor Tmodelsqloracomissaopermanencia.Create;
begin

end;

destructor Tmodelsqloracomissaopermanencia.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqloracomissaopermanencia.New: Imodelsqlcomissaopermanencia;
begin
  Result := Self.Create;
end;

function Tmodelsqloracomissaopermanencia.Sqlcriartabela: String;
begin
  Result := SQL_CRIAR;
end;

function Tmodelsqloracomissaopermanencia.Sqltabelaexiste: String;
begin
  Result := SQL_TABELA_EXISTE;
end;

function Tmodelsqloracomissaopermanencia.Sqlnovocodigo: String;
begin
  Result := SQL_NOVO_CODIGO;
end;

function Tmodelsqloracomissaopermanencia.Sqllistarcomissoes: String;
begin
  Result := SQL_LISTAR;
end;

function Tmodelsqloracomissaopermanencia.Sqllistarcodigo: String;
begin
  Result := SQL_LISTAR_CODIGO;
end;

function Tmodelsqloracomissaopermanencia.Sqlnovo: String;
begin
  Result := SQL_NOVO;
end;

function Tmodelsqloracomissaopermanencia.Sqlexcluir: String;
begin
  Result := SQL_EXCLUIR;
end;

end.

