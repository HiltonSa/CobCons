unit cobcons.model.sql.fbinadimplentes;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlFbInadimplentes }

  TModelSQlFbInadimplentes = class (TInterfacedObject, iModelSqlInadimplentes)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlInadimplentes;

      function SqlCriarTabela: string;
      function SqlNovo: String;
      function SqlTabelaExiste: string;
      function SqlAlterar: String;
      function SqlRetornaInadimplentes: String;
      function SqlRetornaInadimplentesGrupo(pGrupo: string): String;
      function SqlApagarDados: string;
      function SqlInadimplentesSag: String;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlFbInadimplentes }

const
  SQL_TABELA_EXISTE =
    'select count(*) QTDE from RDB$RELATIONS '+
    'where RDB$FLAGS = 1 and  RDB$RELATION_NAME = ''INADI'' ';
  SQL_APAGAR_DADOS = 'delete from INADI';
  SQL_CRIAR =
    'create table INADI ( '+
       'GRUPO varchar(5) not null, '+
       'SEQ varchar(2) not null, '+
       'COTA varchar(3) not null, '+
       'DTAJUIZ date, '+
       'PERCAMORT float default 0, '+
       'VLRRECEBER float default 0, '+
       'VLRBEM float default 0, '+
       'BEMAPREENDIDO float default 0, '+
       'primary key (GRUPO, SEQ, COTA) ) ';
  SQL_NOVO =
    'insert into INADI (GRUPO, SEQ, COTA, DTAJUIZ, PERCAMORT, VLRRECEBER, '+
                       'VLRBEM, BEMAPREENDIDO) '+
               'values ( %s, %s, %s, %s, %.5f, %f, %f, %f )';
  SQL_ALTERAR =
    'update INADI set DTAJUIZ = %s, PERCAMORT = %.5f, VLRRECEBER = %f, '+
                      'VLRBEM = %f, BEMAPREENDIDO = %f '+
    'where GRUPO = %s and SEQ = %s and COTA = %s';
  SQL_LISTA_SAG =
    'select I.GRUPO, I.SEQ, I.COTA, C.NOME, C.SIT_COBR, I.DTAJUIZ, I.PERCAMORT, I.VLRBEM, '+
           'case C.PESS_F_J '+
           'when ''F'' then substr(C.CGC_CPF, 2, 9) ||'+
                      'substr(C.CGC_CPF,  15,  2) '+
           'when ''J'' then substr(C.CGC_CPF,  3,  14) '+
           'end as CGCCPFMT, '+
           'G.DTENCCT, I.VLRRECEBER, I.BEMAPREENDIDO from INADI I '+
    'inner join A2CLI C on C.GRUPO = I.GRUPO and C.SEQ = I.SEQ and C.COTA = I.COTA '+
    'inner join TTGRU G on G.GRUPO = R.GRUPO ';
  SQL_LISTA =
    'select I.GRUPO, I.SEQ, I.COTA, C.NOME, C.SIT_COBR, I.DTAJUIZ, I.VLRBEM, I.PERCAMORT, '+
           'I.VLRRECEBER, I.BEMAPREENDIDO from INADI I '+
    'inner join ACCLI C on C.GRUPO = I.GRUPO and C.SEQ = I.SEQ and C.COTA = I.COTA ';
  SQL_RETORNA_INADIMPLENTES = SQL_LISTA + 'order by I.GRUPO, I.SEQ, I.COTA';
  SQL_RETORNA_INADIMPLENTES_SAG = SQL_LISTA_SAG + 'order by I.GRUPO, I.SEQ, I.COTA';
  SQL_RETORNA_INADIMPLENTES_GRUPO = SQL_LISTA +
    'where I.GRUPO = %s order by I.GRUPO, I.SEQ, I.COTA';
constructor Tmodelsqlfbinadimplentes.Create;
begin

end;

destructor Tmodelsqlfbinadimplentes.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqlfbinadimplentes.New: Imodelsqlinadimplentes;
begin
  Result := Self.Create;
end;

function Tmodelsqlfbinadimplentes.Sqlcriartabela: String;
begin
  Result := SQL_CRIAR;
end;

function Tmodelsqlfbinadimplentes.Sqlnovo: String;
begin
  Result := SQL_NOVO;
end;

function Tmodelsqlfbinadimplentes.Sqltabelaexiste: String;
begin
  Result := SQL_TABELA_EXISTE;
end;

function Tmodelsqlfbinadimplentes.Sqlalterar: String;
begin
  Result := SQL_ALTERAR;
end;

function Tmodelsqlfbinadimplentes.Sqlretornainadimplentes: String;
begin
  Result := SQL_RETORNA_INADIMPLENTES;
end;

function Tmodelsqlfbinadimplentes.Sqlretornainadimplentesgrupo(Pgrupo: String): String;
begin
  Result := Format(SQL_RETORNA_INADIMPLENTES_GRUPO, [QuotedStr(Pgrupo)]);
end;

function Tmodelsqlfbinadimplentes.Sqlapagardados: String;
begin
  Result := SQL_APAGAR_DADOS;
end;

function Tmodelsqlfbinadimplentes.Sqlinadimplentessag: String;
begin
  Result := SQL_RETORNA_INADIMPLENTES_SAG;
end;

end.

