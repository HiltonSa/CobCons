unit cobcons.model.sql.fbcomissaopermanencia;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlFbComissaoPermanencia }

  TModelSQlFbComissaoPermanencia = class (TInterfacedObject, iModelSqlComissaoPermanencia)
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

{ TModelSQlFbComissaoPermanencia }

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
    'select count(*) QTDE from RDB$RELATIONS '+
    'where RDB$FLAGS = 1 and  RDB$RELATION_NAME = ''CMPEM'' ';
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

constructor Tmodelsqlfbcomissaopermanencia.Create;
begin

end;

destructor Tmodelsqlfbcomissaopermanencia.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqlfbcomissaopermanencia.New: Imodelsqlcomissaopermanencia;
begin
  Result := Self.Create;
end;

function Tmodelsqlfbcomissaopermanencia.Sqlcriartabela: String;
begin
  Result := SQL_CRIAR;
end;

function Tmodelsqlfbcomissaopermanencia.Sqltabelaexiste: String;
begin
  Result := SQL_TABELA_EXISTE;
end;

function Tmodelsqlfbcomissaopermanencia.Sqlnovocodigo: String;
begin
  Result := SQL_NOVO_CODIGO;
end;

function Tmodelsqlfbcomissaopermanencia.Sqllistarcomissoes: String;
begin
  Result := SQL_LISTAR;
end;

function Tmodelsqlfbcomissaopermanencia.Sqllistarcodigo: String;
begin
  Result := SQL_LISTAR_CODIGO;
end;

function Tmodelsqlfbcomissaopermanencia.Sqlnovo: String;
begin
  Result := SQL_NOVO;
end;

function Tmodelsqlfbcomissaopermanencia.Sqlexcluir: String;
begin
  Result := SQL_EXCLUIR;
end;

end.

