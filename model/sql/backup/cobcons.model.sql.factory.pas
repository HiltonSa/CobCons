unit cobcons.model.sql.factory;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces,
  cobcons.model.sql.fbbemalienado, cobcons.model.sql.orabemalienado;
type

  { TModelSQLFactory }

  TModelSQLFactory = class (TInterfacedObject, iModelSqlFactory)
    private
      FBancoDados: String;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlFactory;

      function SqlCota: iModelSqlCota;
      function SqlAgenda: iModelSqlAgenda;
      function SqlBem: iModelSqlBem;
      function SqlBemAlienado: iModelSqlBemAlienado;
      function SqlCredito: iModelSqlCredito;
      function SqlEmpresa: iModelSqlEmpresa;
      function SqlFaseJuridica: iModelSqlFaseJuridica;
      function SqlGrupo: iModelSqlGrupo;
      function SqlPagamentos: iModelSqlPagamentos;
      function SqlPendencia: iModelSqlPendencia;
      function SqlPrecoBem: iModelSqlPrecoBem;
      function SqlReuniao: iModelSqlReuniao;
      function SqlUsuario: iModelSqlUsuario;
      function SqlUsuarioLogado: iModelSqlUsuarioLogado;
      function SqlCotacaoMoeda: iModelSqlCotacaoMoeda;
      function SqlTotal: iModelSqlTotal;
      function SqlTotalGrupo: iModelSqlTotalGrupos;
      function SqlInadimplentes: iModelSqlInadimplentes;
      function SqlRNP: iModelSqlRnp;
      function SqlComissaoPermanencia: iModelSqlComissaoPermanencia;
      function SqlItemComissaoPermanencia: iModelSqlItemComissaoPermanencia;
      function SqlDemonstrativo: iModelSqlDemonstrativo;
  end;

implementation

uses cobcons.controller.util, cobcons.model.sql.fbcota,
  cobcons.model.sql.oracota, cobcons.model.sql.oraagenda,
  cobcons.model.sql.fbagenda, cobcons.model.sql.fbbem, cobcons.model.sql.orabem,
  cobcons.model.sql.fbcredito, cobcons.model.sql.oracredito,
  cobcons.model.sql.fbempresa, cobcons.model.sql.oraempresa,
  cobcons.model.sql.fbfasejuridica, cobcons.model.sql.orafasejuridica,
  cobcons.model.sql.fbgrupo, cobcons.model.sql.oragrupo,
  cobcons.model.sql.fbpagamentos, cobcons.model.sql.orapagamentos,
  cobcons.model.sql.fbpendencia, cobcons.model.sql.orapendencia,
  cobcons.model.sql.fbprecobem, cobcons.model.sql.oraprecobem,
  cobcons.model.sql.fbreuniao, cobcons.model.sql.orareuniao,
  cobcons.model.sql.fbusuario, cobcons.model.sql.orausuario,
  cobcons.model.sql.fbusuariologado, cobcons.model.sql.orausuariologado,
  cobcons.model.sql.fbcotacaomoeda, cobcons.model.sql.oracotacaomoeda,
  cobcons.model.sql.fbtotal, cobcons.model.sql.oratotal,
  cobcons.model.sql.fbtotalgrupo, cobcons.model.sql.oratotalgrupo,
  cobcons.model.sql.fbinadimplentes, cobcons.model.sql.orainadimplentes,
  cobcons.model.sql.fbrnp, cobcons.model.sql.orarnp,
  cobcons.model.sql.fbcomissaopermanencia,
  cobcons.model.sql.oracomissaopermanencia,
  cobcons.model.sql.fbitemcomissaopermanencia,
  cobcons.model.sql.oraitemcomissaopermanencia,
  cobcons.model.sql.orademonstrativo, cobcons.model.sql.fbdemonstrativo;

{ TModelSQLFactory }

constructor Tmodelsqlfactory.Create;
begin
  FBancoDados := RetornarBD;
end;

destructor Tmodelsqlfactory.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqlfactory.New: Imodelsqlfactory;
begin
  Result := Self.Create;
end;

function Tmodelsqlfactory.Sqlcota: Imodelsqlcota;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQLOraCota.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbCota.New;
end;

function Tmodelsqlfactory.Sqlagenda: Imodelsqlagenda;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraAgenda.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbAgenda.New;
end;

function Tmodelsqlfactory.Sqlbem: Imodelsqlbem;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraBem.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbBem.New;
end;

function Tmodelsqlfactory.Sqlbemalienado: Imodelsqlbemalienado;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraBemAlienado.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbBemAlienado.New;
end;

function Tmodelsqlfactory.Sqlcredito: Imodelsqlcredito;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraCredito.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbCredito.New;
end;

function Tmodelsqlfactory.Sqlempresa: Imodelsqlempresa;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSqlOraEmpresa.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbEmpresa.New;
end;

function Tmodelsqlfactory.Sqlfasejuridica: Imodelsqlfasejuridica;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraFaseJuridica.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbFaseJuridica.New;
end;

function Tmodelsqlfactory.Sqlgrupo: Imodelsqlgrupo;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraGrupo.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbGrupo.New;
end;

function Tmodelsqlfactory.Sqlpagamentos: Imodelsqlpagamentos;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraPagamentos.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbPagamentos.New;
end;

function Tmodelsqlfactory.Sqlpendencia: Imodelsqlpendencia;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraPendecia.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbPendecia.New;
end;

function Tmodelsqlfactory.Sqlprecobem: Imodelsqlprecobem;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraPrecoBem.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbPrecoBem.New;
end;

function Tmodelsqlfactory.Sqlreuniao: Imodelsqlreuniao;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSqlOraReuniao.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbReuniao.New;
end;

function Tmodelsqlfactory.Sqlusuario: Imodelsqlusuario;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraUsuario.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbUsuario.New;
end;

function Tmodelsqlfactory.Sqlusuariologado: Imodelsqlusuariologado;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraUsuarioLogado.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbUsuarioLogado.New;
end;

function Tmodelsqlfactory.Sqlcotacaomoeda: Imodelsqlcotacaomoeda;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraCotacaoMoeda.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbCotacaoMoeda.New;
end;

function Tmodelsqlfactory.Sqltotal: Imodelsqltotal;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraTotal.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbTotal.New;
end;

function Tmodelsqlfactory.Sqltotalgrupo: Imodelsqltotalgrupos;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraTotalGrupo.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbTotalGrupo.New;
end;

function Tmodelsqlfactory.Sqlinadimplentes: Imodelsqlinadimplentes;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraInadimplentes.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbInadimplentes.New;
end;

function Tmodelsqlfactory.Sqlrnp: Imodelsqlrnp;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraRnp.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbRnp.New;
end;

function Tmodelsqlfactory.Sqlcomissaopermanencia: Imodelsqlcomissaopermanencia;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraComissaoPermanencia.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbComissaoPermanencia.New;
end;

function Tmodelsqlfactory.Sqlitemcomissaopermanencia: Imodelsqlitemcomissaopermanencia;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraItemComissaoPermanencia.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbItemComissaoPermanencia.New;
end;

function Tmodelsqlfactory.Sqldemonstrativo: Imodelsqldemonstrativo;
begin
  if FBancoDados = 'oracle'
  then Result := TModelSQlOraDemonstrativo.New
  else if Pos('firebird', FBancoDados) > 0
  then Result := TModelSQlFbDemonstrativo.New;
end;

end.

