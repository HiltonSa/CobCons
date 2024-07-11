unit cobcons.model.sql.orapgrnp;

{$mode Delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlOraPgRnp }

  TModelSQlOraPgRnp = class (TInterfacedObject, iModelSqlPgRnp)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlPgRnp;

      function SqlCriarTabela: string;
      function SqlTabelaExiste: string;
      function SqlMaiorCodigo: String;
      function SqlNovo: String;
      function SqlAlterar: String;
      function SqlAlterarPagto: String;
      function SqlAlterarValor: String;
      function SqlAlterarStatus: String;
      function SqlRetornaPendentesPagamento: String;
      function SqlRetornaPagasPeriodo: String;
      function SqlRetornaPagtoCota: String;
      function SqlRetornaStatus: String;
      function SqlExcluir: String;
      function SqlAsvr: String;

  end;

implementation

uses cobcons.controller.util;

{ TModelSQlOraPgRnp }

const
  SQL_MAIOR_CODIGO =
    'select MAX(CODIGO) MCOD from PGRNP';
  SQL_TABELA_EXISTE =
    'select count(*) QTDE from USER_TABLES '+
    'where TABLE_NAME = ''PGRNP'' ';
  SQL_CRIAR =
    'create table PGRNP ( '+
       'CODIGO integer not null, '+
       'GRUPO varchar(5) not null, '+
       'SEQ varchar(2) not null, '+
       'COTA varchar(3) not null, '+
       'STATUS integer default on null 0, '+
       'VALOR float default on null 0, '+
       'DTPEDIDO date, '+
       'DTPROG date, '+
       'DTPAGTO date,  '+
       'FRMPG integer, '+
       'TIPOPIX integer, '+
       'CHAVEPIX varchar(60), '+
       'BANCO varchar(30), '+
       'AGENCIA varchar(5), '+
       'CONTA varchar(15), '+
       'OBS varchar(50), '+
       'primary key (GRUPO, SEQ, COTA) ) ';
  SQL_NOVO =
    'insert into PGRNP (CODIGO, GRUPO, SEQ, COTA, VALOR, DTPEDIDO, DTPROG, FRMPG, '+
                        'TIPOPIX, CHAVEPIX, BANCO, AGENCIA, CONTA, OBS ) '+
               'values ( %d, %s, %s, %s, %f, %s, %s, %d, %d, %s, %s, %s, %s, %s )';
  SQL_ALTERAR_STATUS =
    'update PGRNP set STATUS = %d where CODIGO = %d ';
  SQL_ALTERAR_PAGTO =
    'update PGRNP set DTPAGTO = %s, STATUS = %d where CODIGO = %d ';
  SQL_ALTERAR =
    'update PGRNP set DTPROG = %s, FRMPG = %d, TIPOPIX = %d, CHAVEPIX = %s, '+
                     'BANCO = %s, AGENCIA = %s, CONTA = %s, OBS = %s '+
    'where CODIGO = %d';
  SQL_ALTERAR_VALOR =
    'update PGRNP set VALOR = %f where CODIGO = %d';
  SQL_EXCLUIR =
    'delete from PGRNP where CODIGO = %d';
  SQL_ASVR =
    'select FRMPG + 91 FRMPG, '+
           'case FRMPG '+
             'when 0 then ''Pix'' '+
             'when 1 then ''TED'' '+
             'when 2 then ''DOC'' '+
             'when 3 then ''Ordem Pagto'' '+
             'when 4 then ''Cheque'' '+
             'when 5 then ''Caixa Convencional'' '+
             'when 6 then ''Crédito Conta'' '+
             'when 7 then ''Outros'' '+
           'end as DCFRMPG, '+
           'PESS_F_J, QTD, VLR from '+
    '(select P.FRMPG, C.PESS_F_J, count(P.CODIGO) QTD, sum(P.VALOR) VLR '+
    'from PGRNP P '+
    'inner join A2CLI C on C.GRUPO = P.GRUPO and C.SEQ = P.SEQ and C.COTA = P.COTA '+
    'where P.DTPROG between %s and %s and P.STATUS > 1 '+
    'group by P.FRMPG, C.PESS_F_J '+
    'order by P.FRMPG, C.PESS_F_J )';
  SQL_LISTA =
    'select P.CODIGO, P.GRUPO, P.SEQ, P.COTA, C.NOME, C.PESS_F_J, P.VALOR, '+
           'P.FRMPG, P.DTPEDIDO, P.TIPOPIX, P.CHAVEPIX, P.BANCO, P.AGENCIA, '+
           'P.CONTA, P.OBS, P.DTPAGTO, P.STATUS, P.DTPROG,'+
           'case P.FRMPG '+
             'when 0 then ''Pix'' '+
             'when 1 then ''TED'' '+
             'when 2 then ''DOC'' '+
             'when 3 then ''Ordem Pagto'' '+
             'when 4 then ''Cheque'' '+
             'when 5 then ''Caixa Convencional'' '+
             'when 6 then ''Crédito Conta'' '+
             'when 7 then ''Outros'' '+
           'end as DCFRMPG, '+
           'case P.TIPOPIX '+
             'when 0 then ''CPF'' '+
             'when 1 then ''CNPJ'' '+
             'when 2 then ''Celular'' '+
             'when 3 then ''Email'' '+
             'when 4 then ''Aleatória'' '+
             'when 5 then ''Conta Corrente'' '+
             'when 6 then ''Conta Poupança'' '+
             'else '' '' '+
           'end as DCTPPIX, '+
           'case P.STATUS '+
             'when 0 then ''Solicitado'' '+
             'when 1 then ''Pagando'' '+
             'when 2 then ''Pago'' '+
             'when 3 then ''Exportado'' '+
           'end as DCSIT, '+
           'case C.PESS_F_J '+
             'when ''F'' then substr(C.CGC_CPF, 2, 3) ||''.''|| '+
                             'substr(C.CGC_CPF, 5, 3) ||''.''|| '+
                             'substr(C.CGC_CPF,  8, 3) ||''-''|| '+
                             'substr(C.CGC_CPF,  15,  2) '+
             'when ''J'' then substr(C.CGC_CPF,  3,  2) ||''.''|| '+
                             'substr(C.CGC_CPF,  5,  3) ||''.''|| '+
                             'substr(C.CGC_CPF,  8,  3) ||''/''|| '+
                             'substr(C.CGC_CPF,  11,  4) ||''-''|| '+
                             'substr(C.CGC_CPF,  15,  2) '+
           'end as CGCCPFMT, '+
           'C.TELEFONE, substr(C.INF_ADIC,60,20) CELULAR '+
    'from PGRNP P '+
    'inner join A2CLI C on C.GRUPO = P.GRUPO and C.SEQ = P.SEQ and C.COTA = P.COTA ';
  SQL_LISTA_UM = SQL_LISTA + 'Where P.DTPAGTO is null and P.GRUPO = %s and P.SEQ = %s and P.COTA = %s order by CODIGO desc';
  SQL_LISTA_A_PAGAR = SQL_LISTA +'where P.DTPAGTO is null order by P.DTPROG, P.GRUPO, P.SEQ, P.COTA';
  SQL_LISTA_STATUS = SQL_LISTA +
                'where P.STATUS = %d and P.DTPROG <= %s ' +
                'order by P.DTPROG, P.GRUPO, P.SEQ, P.COTA';
  SQL_LISTA_PAGAS_PERIODO = SQL_LISTA +'where P.DTPAGTO between %s and %s order by P.DTPAGTO, P.GRUPO, P.SEQ, P.COTA';

constructor TModelSQlOraPgRnp.Create;
begin

end;

destructor TModelSQlOraPgRnp.Destroy;
begin
  inherited Destroy;
end;

class function TModelSQlOraPgRnp.New: iModelSqlPgRnp;
begin
  Result := Self.Create;
end;

function TModelSQlOraPgRnp.SqlCriarTabela: string;
begin
  Result := SQL_CRIAR;
end;

function TModelSQlOraPgRnp.SqlTabelaExiste: string;
begin
  Result := SQL_TABELA_EXISTE;
end;

function TModelSQlOraPgRnp.SqlMaiorCodigo: String;
begin
  Result := SQL_MAIOR_CODIGO;
end;

function TModelSQlOraPgRnp.SqlNovo: String;
begin
  Result := SQL_NOVO;
end;

function TModelSQlOraPgRnp.SqlAlterar: String;
begin
  Result := SQL_ALTERAR;
end;

function TModelSQlOraPgRnp.SqlAlterarPagto: String;
begin
  Result := SQL_ALTERAR_PAGTO;
end;

function TModelSQlOraPgRnp.SqlAlterarValor: String;
begin
  Result := SQL_ALTERAR_VALOR;
end;

function TModelSQlOraPgRnp.SqlAlterarStatus: String;
begin
  Result := SQL_ALTERAR_STATUS;
end;

function TModelSQlOraPgRnp.SqlRetornaPendentesPagamento: String;
begin
  Result := SQL_LISTA_A_PAGAR;
end;

function TModelSQlOraPgRnp.SqlRetornaPagasPeriodo: String;
begin
  Result := SQL_LISTA_PAGAS_PERIODO;
end;

function TModelSQlOraPgRnp.SqlRetornaPagtoCota: String;
begin
  Result := SQL_LISTA_UM;
end;

function TModelSQlOraPgRnp.SqlRetornaStatus: String;
begin
  Result := SQL_LISTA_STATUS;
end;

function TModelSQlOraPgRnp.SqlExcluir: String;
begin
  Result := SQL_EXCLUIR;
end;

function TModelSQlOraPgRnp.SqlAsvr: String;
begin
  Result := SQL_ASVR;
end;


end.

