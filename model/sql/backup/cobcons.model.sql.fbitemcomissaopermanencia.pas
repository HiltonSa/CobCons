unit cobcons.model.sql.fbitemcomissaopermanencia;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlFbItemComissaoPermanencia }

  TModelSQlFbItemComissaoPermanencia = class (TInterfacedObject, iModelSqlItemComissaoPermanencia)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlItemComissaoPermanencia;

      function SqlCriarTabela: string;
      function SqlTabelaExiste: string;
      function SqlNovoCodigo: String;
      function SqlListarItensComissao: String;
      function SqlListarItensComissaoGrupo: String;
      function SqlAlteraCmPer: String;
      function SqlNovo: String;
      function SqlApagaCalculo: String;
      function SqlSinteticoGrupo: String;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlFbItemComissaoPermanencia }

const
  SQL_LISTAR =
    'select I.CODIGO, I.GRUPO, I.SEQ, I.COTA, C.NOME, I.SDINICIAL, I.COMISSAO, I.SDFINAL '+
    'from ITPEM I '+
    'inner join A2CLI C on C.GRUPO = I.GRUPO and C.SEQ = I.SEQ and C.COTA = I.COTA ';
  SQL_LISTAR_ITENS = SQL_LISTAR +
    'where I.CMPEM = %d order by I.GRUPO, I.COTA, I.SEQ';
  SQL_LISTAR_GRUPO = SQL_LISTAR +
    'where I.CMPEM = %d and I.GRUPO = %s order by I.GRUPO, I.COTA, I.SEQ';
  SQL_TABELA_EXISTE =
    'select count(*) QTDE from RDB$RELATIONS '+
    'where RDB$FLAGS = 1 and  RDB$RELATION_NAME = ''ITPEM'' ';
  SQL_APAGAR_DADOS = 'delete from ITPEM';
  SQL_CRIAR =
    'create table ITPEM ( '+
       'CODIGO integer not null primary key, '+
       'CMPEM integer, '+
       'GRUPO varchar(5), '+
       'SEQ varchar(2), '+
       'COTA varchar(3), '+
       'SDINICIAL float default 0, '+
       'COMISSAO float default 0, '+
       'SDFINAL float default 0 ) ';
  SQL_NOVO =
    'insert into ITPEM (CODIGO, CMPEM, GRUPO, SEQ, COTA, SDINICIAL, COMISSAO, SDFINAL) '+
               'values ( %d, %d, %s, %s, %s, %f, %f, %f)';
  SQL_NOVO_CODIGO =
       'select max( CODIGO ) MAXCOD from ITPEM ';
  SQL_ALTERA_CMPER =
       'update ITPEM set CMPEM = %d where CMPEM = 0';
  SQL_APAGA_CALCULO =
       'delete from ITPEM where CMPEM = %d';
  SQL_SINTETICO_GRUPO =
       'select GRUPO, sum(SDINICIAL) SDINI, sum(COMISSAO) VLCOM, sum(SDFINAL) SDFIM '+
       'from ITPEM '+
       'where CMPER = %d '+
       'group by GRUPO order by GRUPO';

constructor Tmodelsqlfbitemcomissaopermanencia.Create;
begin

end;

destructor Tmodelsqlfbitemcomissaopermanencia.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqlfbitemcomissaopermanencia.New: Imodelsqlitemcomissaopermanencia;
begin
  Result := Self.Create;
end;

function Tmodelsqlfbitemcomissaopermanencia.Sqlcriartabela: String;
begin
  Result := SQL_CRIAR;
end;

function Tmodelsqlfbitemcomissaopermanencia.Sqltabelaexiste: String;
begin
  Result := SQL_TABELA_EXISTE;
end;

function Tmodelsqlfbitemcomissaopermanencia.Sqlnovocodigo: String;
begin
  Result := SQL_NOVO_CODIGO;
end;

function Tmodelsqlfbitemcomissaopermanencia.Sqllistaritenscomissao: String;
begin
  Result := SQL_LISTAR_ITENS;
end;

function Tmodelsqlfbitemcomissaopermanencia.Sqllistaritenscomissaogrupo: String;
begin
  Result := SQL_LISTAR_GRUPO;
end;

function Tmodelsqlfbitemcomissaopermanencia.Sqlalteracmper: String;
begin
  Result := SQL_ALTERA_CMPER;
end;

function Tmodelsqlfbitemcomissaopermanencia.Sqlnovo: String;
begin
  Result := SQL_NOVO;
end;

function Tmodelsqlfbitemcomissaopermanencia.Sqlapagacalculo: String;
begin
  Result := SQL_APAGA_CALCULO;
end;

function Tmodelsqlfbitemcomissaopermanencia.Sqlsinteticogrupo: String;
begin
  Result := SQL_SINTETICO_GRUPO;
end;

end.

