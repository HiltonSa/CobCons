unit cobcons.model.factory;

{$mode delphi}
interface

uses
  Classes, Sysutils, cobcons.model.interfaces;
type

  { TFactoryQuery }

  { TModelFactory }

  TModelFactory = class (TInterfacedObject, iModelFactory)
    private
      FModoLocal: Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelFactory;
      function Conexao(pBanco: Integer = 0): iModelConexao;
      function ClienteWS: iClienteWebService;
      function QueryRest(aConexao: iModelConexao): iQueryRest;
      function Usuario(aQuery: iQueryRest): iModelUsuario;
      function UsuarioLogado(aQuery: iQueryRest): iModelUsuarioLogado;
      function Empresa(aQuery: iQueryRest): iModelEmpresa;
      function Cota(aQuery: iQueryRest): iModelCota;
      function Pagamentos(aQuery: iQueryRest): iModelPagamentos;
      function Reuniao(aQuery: iQueryRest): iModelReuniao;
      function PrecoBem(aQuery: iQueryRest): iModelPrecoBem;
      function Grupo(aQuery: iQueryRest): iModelGrupo;
      function Bem(aQuery: iQueryRest): iModelBem;
      function Pendencia(aQuery: iQueryRest): iModelPendencia;
      function FaseJuridica(aQuery: iQueryRest): iModelFaseJuridica;
      function Credito(aQuery: iQueryRest): iModelCredito;
      function BemAlienado(aQuery: iQueryRest): iModelBemAlienado;
      function Agenda(aQuery: iQueryRest): iModelAgenda;
      function CotacaoMoeda(aQuery: iQueryRest): iModelCotacaoMoeda;
      function Total(aQuery: iQueryRest): iModelTotal;
      function TotalGrupo(aQuery: iQueryRest): iModelTotalGrupo;
      function Inadimplente(aQuery: iQueryRest): iModelInadimplente;
      function RNP(aQuery: iQueryRest): iModelRnp;
      function TabularEncerrados: iModelTabularEncerrados;
      function ComissaoPermanencia(aQuery: iQueryRest): iModelComissaoPermanencia;
      function ItemComissaoPermanencia(aQuery: iQueryRest): iModelItemComissaoPermanencia;
      function FichaPagamentos(aQuery: iQueryRest): iModelFichaPagamentos;
      function Sag: iModelSag;
      function Demonstrativo(aQuery: iQueryRest): iModelDemonstrativo;
      function SaldoRnpDatabase: iModelSaldoRnpDataBase;
      function RateioPagamentos: iModelRateioPagamentos;
      function PgRnp(aQuery: iQueryRest): iModelPgRnp;
      function Relatorio(aQuery: iQueryRest): iModelRelatorio;
      function AdmCon(aQuery: iQueryRest): iModelAdmcon;
      function FaixaComissao(aQuery: iQueryRest): iModelFaixaComissao;
      function RegraComissao(aQuery: iQueryRest): iModelRegraComissao;
      function Filial(aQuery: iQueryRest): iModelFilial;
      function Equipe(aQuery: iQueryRest): iModelEquipe;
      function Agente(aQuery: iQueryRest): iModelAgente;
      function NivelSupervisao(aQuery: iQueryRest): iModelNivelSupervisao;
      function SituacaoContrato(aQuery: iQueryRest): iModelSituacaoContrato;
      function Periodo(aQuery: iQueryRest): iModelPeriodo;
      function Venda(aQuery: iQueryRest): iModelVenda;
      function ParcelaComissao(aQuery: iQueryRest): iModelParcelaComissao;
    end;

implementation

uses cobcons.model.usuario, cobcons.model.usuariologado, cobcons.model.empresa,
  cobcons.model.conexaozeos, cobcons.model.queryzeos, cobcons.model.clientews,
  cobcons.model.cota, cobcons.model.pagamentos, cobcons.model.reuniao,
  cobcons.model.precobem, cobcons.model.grupo, cobcons.model.bem,
  cobcons.model.pendencia, cobcons.model.fasejuridica, cobcons.model.credito,
  cobcons.model.bemalienado, cobcons.model.agenda, cobcons.model.cotacaomoeda,
  cobcons.model.total, cobcons.model.totalgrupo, cobcons.model.inadimplentes,
  cobcons.model.rnp, cobcons.model.tabularencerrados,
  cobcons.model.comissaopermanencia, cobcons.model.itemcomissaopermanencia,
  cobcons.model.fichapagamentos, cobcons.model.sag, cobcons.model.demonstrativo,
  cobcons.model.saldodatabase, cobcons.model.rateiopagamentos,
  cobcons.model.pgrnp, cobcons.model.relatorio, cobcons.model.admcon,
  cobcons.model.faixacomissao, cobcons.model.regracomissao,
  cobcons.model.filial, cobcons.model.equipe, cobcons.model.agente,
  cobcons.model.nivelsupervisao, cobcons.model.situacaocontrato,
  cobcons.model.periodo, cobcons.model.venda, cobcons.model.parcelacomissao;

constructor TModelFactory.Create;
begin
  // Se a filial logado for matriz (1) acessa via zeos
  // senão utiliza servidor rest via restdataware
  //FModoLocal := (RetornarFilialLog = 1);
end;

destructor TModelFactory.Destroy;
begin
  inherited Destroy;
end;

class function TModelFactory.New: iModelFactory;
begin
  Result := Self.Create;
end;

function TModelFactory.Conexao(pBanco: Integer): iModelConexao;
begin
  Result := TConexaoZeos.New(pBanco) ;
  //if FModoLocal
  //then Result := TConexaoZeos.New
  //else Result := TConexaoRest.New;
end;

function TModelFactory.ClienteWS: iClienteWebService;
begin
  Result := TClienteWS.New;
end;

function TModelFactory.QueryRest(aConexao: iModelConexao): iQueryRest;
begin
  Result := TQueryZeos.New(aConexao);
  //if FModoLocal
  //then Result := TQueryZeos.New(aConexao)
  //else Result := TQueryRest.New(Aconexao);
end;

function TModelFactory.Usuario(aQuery: iQueryRest): iModelUsuario;
begin
  Result := TModelUsuario.New(Aquery);
end;

function TModelFactory.UsuarioLogado(aQuery: iQueryRest): iModelUsuarioLogado;
begin
  Result := TModelUsuarioLogado.New(Aquery);
end;

function TModelFactory.Empresa(aQuery: iQueryRest): iModelEmpresa;
begin
  Result := TModelEmpresa.New(Aquery);
end;

function TModelFactory.Cota(aQuery: iQueryRest): iModelCota;
begin
  Result := TModelCota.New(Aquery);
end;

function TModelFactory.Pagamentos(aQuery: iQueryRest): iModelPagamentos;
begin
  Result := TModelPagamentos.New(Aquery);
end;

function TModelFactory.Reuniao(aQuery: iQueryRest): iModelReuniao;
begin
  Result := TModelReuniao.New(Aquery);
end;

function TModelFactory.PrecoBem(aQuery: iQueryRest): iModelPrecoBem;
begin
  Result := TModelPrecoBem.New(Aquery);
end;

function TModelFactory.Grupo(aQuery: iQueryRest): iModelGrupo;
begin
  Result := TModelGrupo.New(Aquery);
end;

function TModelFactory.Bem(aQuery: iQueryRest): iModelBem;
begin
  Result := TModelBem.New(Aquery);
end;

function TModelFactory.Pendencia(aQuery: iQueryRest): iModelPendencia;
begin
  Result := TModelPendencia.New(Aquery);
end;

function TModelFactory.FaseJuridica(aQuery: iQueryRest): iModelFaseJuridica;
begin
  Result := TModelFaseJuridica.New(Aquery);
end;

function TModelFactory.Credito(aQuery: iQueryRest): iModelCredito;
begin
  Result := TModelCredito.New(Aquery);
end;

function TModelFactory.BemAlienado(aQuery: iQueryRest): iModelBemAlienado;
begin
  Result := TModelBemAlienado.New(Aquery);
end;

function TModelFactory.Agenda(aQuery: iQueryRest): iModelAgenda;
begin
  Result := TModelAgenda.New(Aquery);
end;

function TModelFactory.CotacaoMoeda(aQuery: iQueryRest): iModelCotacaoMoeda;
begin
  Result := TModelCotacaoMoeda.New(Aquery);
end;

function TModelFactory.Total(aQuery: iQueryRest): iModelTotal;
begin
  Result := TModelTotal.New(Aquery);
end;

function TModelFactory.TotalGrupo(aQuery: iQueryRest): iModelTotalGrupo;
begin
  Result := TModelTotalGrupo.New(Aquery);
end;

function TModelFactory.Inadimplente(aQuery: iQueryRest): iModelInadimplente;
begin
  Result := TModelInadimplentes.New(Aquery);
end;

function TModelFactory.RNP(aQuery: iQueryRest): iModelRnp;
begin
  Result := TModelRnp.New(Aquery);
end;

function TModelFactory.TabularEncerrados: iModelTabularEncerrados;
begin
  Result := TModelTabularEncerrados.New;
end;

function TModelFactory.ComissaoPermanencia(aQuery: iQueryRest
  ): iModelComissaoPermanencia;
begin
  Result := TModelComissaoPermanencia.New(aQuery);
end;

function TModelFactory.ItemComissaoPermanencia(aQuery: iQueryRest
  ): iModelItemComissaoPermanencia;
begin
  Result := TModelItemComissaoPermanencia.New(Aquery);
end;

function TModelFactory.FichaPagamentos(aQuery: iQueryRest
  ): iModelFichaPagamentos;
begin
  Result := TModelFichaPagamentos.New(Aquery);
end;

function TModelFactory.Sag: iModelSag;
begin
  Result := TModelSag.New;
end;

function TModelFactory.Demonstrativo(aQuery: iQueryRest): iModelDemonstrativo;
begin
  Result := TModelDemonstrativo.New(Aquery);
end;

function TModelFactory.SaldoRnpDatabase: iModelSaldoRnpDataBase;
begin
  Result := TModelCalcularSaldoRnpDataBase.New;
end;

function TModelFactory.RateioPagamentos: iModelRateioPagamentos;
begin
  Result := TModelRateioPagamentos.New;
end;

function TModelFactory.PgRnp(aQuery: iQueryRest): iModelPgRnp;
begin
  Result := TModelPgRnp.New(aQuery);
end;

function TModelFactory.Relatorio(aQuery: iQueryRest): iModelRelatorio;
begin
  Result := TModelRelatorio.New(aQuery);
end;

function TModelFactory.AdmCon(aQuery: iQueryRest): iModelAdmcon;
begin
  Result := TModelAdmcon.New(aQuery);
end;

function TModelFactory.FaixaComissao(aQuery: iQueryRest): iModelFaixaComissao;
begin
  Result := TModelFaixaComissao.New(aQuery);
end;

function TModelFactory.RegraComissao(aQuery: iQueryRest): iModelRegraComissao;
begin
  Result := TModelRegraComissao.New(aQuery);
end;

function TModelFactory.Filial(aQuery: iQueryRest): iModelFilial;
begin
  Result := TModelFilial.New(aQuery);
end;

function TModelFactory.Equipe(aQuery: iQueryRest): iModelEquipe;
begin
  Result := TModelEquipe.New(aQuery);
end;

function TModelFactory.Agente(aQuery: iQueryRest): iModelAgente;
begin
  Result := TModelAgente.New(aQuery);
end;

function TModelFactory.NivelSupervisao(aQuery: iQueryRest
  ): iModelNivelSupervisao;
begin
  Result := TModelNivelSupervisao.New(aQuery);
end;

function TModelFactory.SituacaoContrato(aQuery: iQueryRest
  ): iModelSituacaoContrato;
begin
  Result := TModelSituacaoContrato.New(aQuery);
end;

function TModelFactory.Periodo(aQuery: iQueryRest): iModelPeriodo;
begin
  Result := TModelPeriodo.New(aQuery);
end;

function TModelFactory.Venda(aQuery: iQueryRest): iModelVenda;
begin
  Result := TModelVenda.New(aQuery);
end;

function TModelFactory.ParcelaComissao(aQuery: iQueryRest
  ): iModelParcelaComissao;
begin
  Result := TModelParcelaComissao.New(aQuery);
end;

end.

