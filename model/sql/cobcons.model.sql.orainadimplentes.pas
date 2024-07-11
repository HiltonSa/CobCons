unit cobcons.model.sql.orainadimplentes;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlOraInadimplentes }

  TModelSQlOraInadimplentes = class (TInterfacedObject, iModelSqlInadimplentes)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlInadimplentes;

      function SqlCriarTabela: string;
      function SqlTabelaExiste: string;
      function SqlNovo: String;
      function SqlAlterar: String;
      function SqlRetornaInadimplentes: String;
      function SqlRetornaInadimplentesGrupo(pGrupo: string): String;
      function SqlApagarDados: string;
      function SqlInadimplentesSag: String;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlOraInadimplentes }

const
  SQL_TABELA_EXISTE =
    'select count(*) QTDE from USER_TABLES '+
    'where TABLE_NAME = ''INADI'' ';
  SQL_APAGAR_DADOS = 'delete from INADI';
  SQL_CRIAR =
    'create table INADI ( '+
       'GRUPO varchar(5) not null, '+
       'SEQ varchar(2) not null, '+
       'COTA varchar(3) not null, '+
       'DTAJUIZ date, '+
       'PERCAMORT float default on null 0, '+
       'VLRRECEBER float default on null 0, '+
       'VLRBEM float default on null 0, '+
       'BEMAPREENDIDO float default on null 0, '+
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
           'end as CGCCPFMT, C.PESS_F_J, '+
           'G.DTENCCT, I.VLRRECEBER, I.BEMAPREENDIDO from INADI I '+
    'inner join A2CLI C on C.GRUPO = I.GRUPO and C.SEQ = I.SEQ and C.COTA = I.COTA '+
    'inner join TTGRU G on G.GRUPO = I.GRUPO ';
  SQL_LISTA =
    'select I.GRUPO, I.SEQ, I.COTA, C.NOME, C.SIT_COBR, I.DTAJUIZ, I.PERCAMORT, I.VLRBEM, '+
           'I.VLRRECEBER, I.BEMAPREENDIDO from INADI I '+
    'inner join A2CLI C on C.GRUPO = I.GRUPO and C.SEQ = I.SEQ and C.COTA = I.COTA ';
  SQL_RETORNA_INADIMPLENTES = SQL_LISTA + 'order by I.GRUPO, I.SEQ, I.COTA';
  SQL_RETORNA_INADIMPLENTES_SAG = SQL_LISTA_SAG + 'order by I.GRUPO, I.SEQ, I.COTA';
  SQL_RETORNA_INADIMPLENTES_GRUPO = SQL_LISTA +
    'where I.GRUPO = %s order by I.GRUPO, I.SEQ, I.COTA';

constructor Tmodelsqlorainadimplentes.Create;
begin

end;

destructor Tmodelsqlorainadimplentes.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqlorainadimplentes.New: Imodelsqlinadimplentes;
begin
  Result := Self.Create;
end;

function Tmodelsqlorainadimplentes.Sqlcriartabela: String;
begin
  Result := SQL_CRIAR;
end;

function Tmodelsqlorainadimplentes.Sqltabelaexiste: String;
begin
  Result := SQL_TABELA_EXISTE;
end;

function Tmodelsqlorainadimplentes.Sqlnovo: String;
begin
  Result := SQL_NOVO;
end;

function Tmodelsqlorainadimplentes.Sqlalterar: String;
begin
  Result := SQL_ALTERAR;
end;

function Tmodelsqlorainadimplentes.Sqlretornainadimplentes: String;
begin
  Result := SQL_RETORNA_INADIMPLENTES;
end;

function Tmodelsqlorainadimplentes.Sqlretornainadimplentesgrupo(Pgrupo: String): String;
begin
  Result := Format(SQL_RETORNA_INADIMPLENTES_GRUPO, [QuotedStr(Pgrupo)]);
end;

function Tmodelsqlorainadimplentes.Sqlapagardados: String;
begin
  Result := SQL_APAGAR_DADOS;
end;

function Tmodelsqlorainadimplentes.Sqlinadimplentessag: String;
begin
  Result := SQL_RETORNA_INADIMPLENTES_SAG;
end;

end.

