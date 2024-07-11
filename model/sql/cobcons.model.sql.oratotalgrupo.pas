unit cobcons.model.sql.oratotalgrupo;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlOraTotalGrupo }

  TModelSQlOraTotalGrupo = class (TInterfacedObject, iModelSqlTotalGrupos)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlTotalGrupos;

      function SqlCriarTabela: string;
      function SqlTabelaExiste: string;
      function SqlNovo: String;
      function SqlRecuperaGrupo(pGrupo: String): String;
      function SqlAlterar: String;
      function SqlApagarDados: String;
      function SqlAcumularInadimplentes: String;
      function SqlAcumularRnp: String;
      function SqlAcumularRateioFuturo: String;
      function SqlAcumularTotalFator: String;
      function SqlRecuperaTodos: String;
      function SqlAtualizarRnp: String;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlOraTotalGrupo }

const
  SQL_TABELA_EXISTE =
    'select count(*) QTDE from USER_TABLES '+
    'where TABLE_NAME = ''TTGRU'' ';
  SQL_APAGAR_DADOS = 'delete from TTGRU';
  SQL_CRIAR =
    'create table TTGRU ( '+
       'GRUPO varchar(5) not null, '+
       'REGAPLIC varchar(4), '+
       'DTCALC date, '+
       'DTULTASS date, '+
       'DTENCCT date, '+
       'TXPER float default on null 0, '+
       'DTCMPER date, '+
       'MULRESGRU float default on null 0, '+
       'MULRESADM float default on null 0, '+
       'QTDINA integer default on null 0, '+
       'QTDRNP integer default on null 0, '+
       'QTDRF integer default on null 0, '+
       'BEMAPREENDIDO float default on null 0, '+
       'VLRJURIDICO float default on null 0, '+
       'VLRMEDIACAO float default on null 0, '+
       'VLRINA float generated always as ( VLRJURIDICO + VLRMEDIACAO ), '+
       'VLRRNP float default on null 0, '+
       'VLRRF float default on null 0, '+
       'TOTALFATOR float default on null 0, '+
       'primary key (GRUPO) ) ';
  SQL_RECUPERA_GRUPO =
    'select * from TTGRU where GRUPO = %s';
  SQL_RECUPERA_TODOS =
    'select * from TTGRU order by GRUPO';
  SQL_NOVO =
    'insert into TTGRU (GRUPO, REGAPLIC, DTCALC, DTULTASS, DTENCCT, TXPER, DTCMPER, MULRESGRU, '+
                       'MULRESADM, QTDINA, QTDRNP, BEMAPREENDIDO, VLRJURIDICO, '+
                       'VLRMEDIACAO, VLRRNP, TOTALFATOR) '+
               'values ( %s, %s, %s, %s, %s, %.3f, %s, %f, %f, 0, 0, 0, 0, 0, 0, 0)';
  SQL_ALTERAR =
    'update TTGRU set REGAPLIC = %s, DTCALC = %s, DTULTASS = %s, DTENCCT = %s, TXPER = %f, '+
                      'MULRESGRU = %f, MULRESADM = %f, DTCMPER = %s '+
    'where GRUPO = %s';
  SQL_ACUMULAR_INADIMPLENTES =
    'update TTGRU set QTDINA = QTDINA + 1, BEMAPREENDIDO = BEMAPREENDIDO + %f, '+
                     'VLRJURIDICO = VLRJURIDICO + %f, VLRMEDIACAO = VLRMEDIACAO + %f, '+
                     'TOTALFATOR = TOTALFATOR + %f '+
    'where GRUPO = %s';
  SQL_ACUMULAR_RNP =
    'update TTGRU set QTDRNP = QTDRNP + 1, VLRRNP = VLRRNP + %f '+
    'where GRUPO = %s';
  SQL_ACUMULAR_RATEIO_FUTURO =
    'update TTGRU set QTDRF = QTDRF + 1, VLRRF = VLRRF + %f '+
    'where GRUPO = %s';
  SQL_ACUMULAR_TOTALFATOR =
    'update TTGRU set TOTALFATOR = TOTALFATOR + %f '+
    'where GRUPO = %s';
  SQL_ATUALIZAR_RNP =
    'update TTGRU T set '+
       'T.QTDRNP = (select count(*) from RECNP R where R.GRUPO = T.GRUPO and R.VLRRNP > 0), '+
       'T.VLRRNP = (select sum(R.VLRRNP) from RECNP R where R.GRUPO = T.GRUPO)';

constructor Tmodelsqloratotalgrupo.Create;
begin

end;

destructor Tmodelsqloratotalgrupo.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqloratotalgrupo.New: Imodelsqltotalgrupos;
begin
  Result := Self.Create;
end;

function Tmodelsqloratotalgrupo.Sqlcriartabela: String;
begin
  Result := SQL_CRIAR;
end;

function Tmodelsqloratotalgrupo.Sqltabelaexiste: String;
begin
  Result := SQL_TABELA_EXISTE;
end;

function Tmodelsqloratotalgrupo.Sqlnovo: String;
begin
  Result := SQL_NOVO;
end;

function Tmodelsqloratotalgrupo.Sqlrecuperagrupo(Pgrupo: String): String;
begin
  Result := Format(SQL_RECUPERA_GRUPO, [QuotedStr(Pgrupo)]);
end;

function Tmodelsqloratotalgrupo.Sqlalterar: String;
begin
  Result := SQL_ALTERAR;
end;

function Tmodelsqloratotalgrupo.Sqlapagardados: String;
begin
  Result := SQL_APAGAR_DADOS;
end;

function Tmodelsqloratotalgrupo.Sqlacumularinadimplentes: String;
begin
  Result := SQL_ACUMULAR_INADIMPLENTES;
end;

function Tmodelsqloratotalgrupo.Sqlacumularrnp: String;
begin
  Result := SQL_ACUMULAR_RNP;
end;

function Tmodelsqloratotalgrupo.Sqlacumularrateiofuturo: String;
begin
  Result := SQL_ACUMULAR_RATEIO_FUTURO;
end;

function Tmodelsqloratotalgrupo.Sqlacumulartotalfator: String;
begin
  Result := SQL_ACUMULAR_TOTALFATOR;
end;

function Tmodelsqloratotalgrupo.Sqlrecuperatodos: String;
begin
  Result := SQL_RECUPERA_TODOS;
end;

function Tmodelsqloratotalgrupo.Sqlatualizarrnp: String;
begin
  Result := SQL_ATUALIZAR_RNP;
end;

end.

