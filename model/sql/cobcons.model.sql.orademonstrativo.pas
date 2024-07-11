unit cobcons.model.sql.orademonstrativo;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlOraDemonstrativo }

  TModelSQlOraDemonstrativo = class (TInterfacedObject, iModelSqlDemonstrativo)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlDemonstrativo;

      function SqlCriarTabela: string;
      function SqlTabelaExiste: string;
      function SqlNovo: string;
      function SqlRetornaDemonstrativo: string;
      function SqlRetornaDemonstrativoDataBase: string;
      function SqlAlterarValorConta: String;
      function SqlListaCosifDemonstrativo: String;
      function SqlNovaDatabase: String;
      function SqlTabelaCosifExiste: string;
      function SqlCriarTabelaCosif: String;
      function SqlImportar4110Siacon: String;
      function SqlImportar4350Siacon: String;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlOraDemonstrativo }

const
  SQL_INSERIR_BASE =
    'insert into CMBDC (GRUPO, DEMONSTRATIVO, DATABASE, CONTACOSIF, SALDOCONTA, '+
                       'VLRPERIODO, VLRACUMULADO) ';
  SQL_NOVO =  SQL_INSERIR_BASE + 'values ( %s, %s, %s, %s, %f, %f, %f)';
  SQL_IMPORTAR_4110_SIACON_DATABASE= SQL_INSERIR_BASE +
    'select COD_GRUPO, ''4110'', DT_BASE, COD_C_COSIF, SALDO, 0, 0  from CT4110 '+
    'where COD_GRUPO = %s and DT_BASE = %s';
  SQL_IMPORTAR_4350_SIACON_DATABASE= SQL_INSERIR_BASE +
    'select COD_GRUPO, ''4350'', DT_BASE, COD_C_COSIF, 0, SALDO_PERIOD, SALDO_ACUMUL '+
    'from CT4350 where COD_GRUPO = %s and DT_BASE = %s';
  SQL_INSERIR_NOVA_DATABASE=
    'insert into CMBDC (GRUPO, DEMONSTRATIVO, DATABASE, CONTACOSIF, SALDOCONTA, '+
                       'VLRPERIODO, VLRACUMULADO) '+
    'select %s, DOC, %s, CODCONTA, 0, 0, 0  from COSIF';
  SQL_LISTA_COSIF_DEMONSTRATIVO =
    'select CODCONTA, CONTAFMT, DESCRICAO from COSIF where DOC = %s' ;
  SQL_BASE =
    'select C.GRUPO, C.DEMONSTRATIVO, C.DATABASE, C.CONTACOSIF, F.CONTAFMT, '+
           'F.DESCRICAO DCCONTA, C.SALDOCONTA, C.VLRPERIODO, C.VLRACUMULADO '+
    'from CMBDC C '+
    'inner join COSIF F on F.DOC = C.DEMONSTRATIVO and F.CODCONTA = C.CONTACOSIF ';
  SQL_LISTAR_DEMONSTRATIVO_GRUPO = SQL_BASE +
       'where C.GRUPO = %s and C.DEMONSTRATIVO = %s and C.DATABASE = %s ';
  SQL_LISTAR_DEMONSTRATIVO_DATABASE = SQL_BASE +
       'where C.DATABASE = %s order by C.GRUPO, C.DEMONSTRATIVO, C.CONTACOSIF';
  SQL_TABELA_EXISTE =
       'select count(*) QTDE from USER_TABLES '+
       'where TABLE_NAME = ''CMBDC'' ';
  SQL_TABELA_COSIF_EXISTE =
       'select count(*) QTDE from USER_TABLES '+
       'where TABLE_NAME = ''COSIF'' ';
  SQL_APAGAR_DADOS = 'delete from CMBDC';
  SQL_CRIAR =
    'create table CMBDC ( '+
       'GRUPO varchar(5) not null, '+
       'DEMONSTRATIVO varchar(4) not null, '+
       'DATABASE date not null, '+
       'CONTACOSIF varchar(8) not null, '+
       'SALDOCONTA float default 0, '+
       'VLRPERIODO float default 0, '+
       'VLRACUMULADO float default 0, '+
       'primary key(GRUPO, DEMONSTRATIVO, DATABASE, CONTACOSIF)) ';
  SQL_CRIAR_COSIF =
     'create table COSIF ( '+
       'DOC	varchar(4) not null, ' +
       'CODCONTA varchar(8) not null, '+
       'CONTAFMT varchar(15), '+
       'DESCRICAO varchar(80), '+
       'primary key(DOC, CODCONTA))';
  SQL_ALTERAR_CONTA =
    'update CMBDC set SALDOCONTA = %f, VLRPERIODO = %f, VLRACUMULADO = %f '+
    'where GRUPO = %s and DEMONSTRATIVO = %s and DATABASE = %s and CONTACOSIF = %s';

constructor Tmodelsqlorademonstrativo.Create;
begin

end;

destructor Tmodelsqlorademonstrativo.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqlorademonstrativo.New: Imodelsqldemonstrativo;
begin
  Result := Self.Create;
end;

function Tmodelsqlorademonstrativo.Sqlcriartabela: String;
begin
  Result := SQL_CRIAR;
end;

function Tmodelsqlorademonstrativo.Sqltabelaexiste: String;
begin
  Result := SQL_TABELA_EXISTE;
end;

function Tmodelsqlorademonstrativo.Sqlnovo: String;
begin
  Result := SQL_NOVO;
end;

function Tmodelsqlorademonstrativo.Sqlretornademonstrativo: String;
begin
  Result := SQL_LISTAR_DEMONSTRATIVO_GRUPO;
end;

function Tmodelsqlorademonstrativo.Sqlretornademonstrativodatabase: String;
begin
  Result := SQL_LISTAR_DEMONSTRATIVO_DATABASE;
end;

function Tmodelsqlorademonstrativo.Sqlalterarvalorconta: String;
begin
  Result := SQL_ALTERAR_CONTA;
end;

function Tmodelsqlorademonstrativo.Sqllistacosifdemonstrativo: String;
begin
  Result := SQL_LISTA_COSIF_DEMONSTRATIVO;
end;

function Tmodelsqlorademonstrativo.Sqlnovadatabase: String;
begin
  Result := SQL_INSERIR_NOVA_DATABASE;
end;

function Tmodelsqlorademonstrativo.Sqltabelacosifexiste: String;
begin
  Result := SQL_TABELA_COSIF_EXISTE;
end;

function Tmodelsqlorademonstrativo.Sqlcriartabelacosif: String;
begin
  Result := SQL_CRIAR_COSIF;
end;

function Tmodelsqlorademonstrativo.Sqlimportar4110siacon: String;
begin
  Result := SQL_IMPORTAR_4110_SIACON_DATABASE;
end;

function Tmodelsqlorademonstrativo.Sqlimportar4350siacon: String;
begin
  Result := SQL_IMPORTAR_4350_SIACON_DATABASE;
end;

end.

