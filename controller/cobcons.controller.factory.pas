unit cobcons.controller.factory;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.controller.interfaces, cobcons.model.factory,
  cobcons.model.interfaces;
type

  { TControllerFactory }

  TControllerFactory = class (TInterfacedObject, iControllerFactory)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iControllerFactory;
      function Conexao(pBanco: Integer = 0): iModelConexao;
      function ClienteWS: iClienteWebService;
      function Query(aConexao: iModelConexao): iQueryRest;
      function Usuario: iControllerUsuario;
      function UsuarioLogado: iControllerUsuarioLogado;
      function Empresa: iControllerEmpresa;
      function Cota: iControllerCota;
      function Pagamentos: iControllerPagamentos;
      function PrecoBem: iControllerPrecoBem;
      function Grupo: iControllerGrupo;
      function Reuniao: iControllerReuniao;
      function Bem: iControllerBem;
      function Pendencia: iControllerPendencia;
      function FaseJuridica: iControllerFaseJuridica;
      function Credito: iControllerCredito;
      function BemAlienado: iControllerBemAlienado;
      function Agenda: iControllerAgenda;
      function CotacaoMoeda: iControllerCotacaoMoeda;
      function Total: iControllerTotal;
      function TotalGrupo: iControllerTotalGrupo;
      function Inadimplente: iControllerInadimplente;
      function RNP: iControllerRnp;
      function TabularEncerrados: iControllerTabularEncerrados;
      function ComissaoPermanencia: iControllerComissaoPermanencia;
      function ItemComissaoPermanencia: iControllerItemComissaoPermanencia;
      function FichaPagamentos: iControllerFichaPagamentos;
      function Sag: iControllerSag;
      function Demonstrativo: iControllerDemonstrativo;
      function SaldoRnpDataBase: iControllerSaldoRnpDataBase;
      function RateioPagamentos: iControllerRateioPagamentos;
      function PagamentosRnp: iControllerPgRnp;
      function Relatorios(pBanco: Integer = 0): iControllerRelatorio;
      function AdmCon: iControllerAdmcon;
      function FaixaComissao: iControllerFaixaComissao;
      function RegraComissao: iControllerRegraComissao;
      function Filial: iControllerFilial;
      function Equipe: iControllerEquipe;
      function Agente: iControllerAgente;
      function NivelSupervisao: iControllerNivelSupervisao;
      function SituacaoContrato: iControllerSituacaoContrato;
      function Periodo: iControllerPeriodo;
      function Venda: iControllerVenda;
      function ParcelaComissao: iControllerParcelaComissao;
  end;

implementation

uses cobcons.controller.usuario, cobcons.controller.usuariologado,
  cobcons.controller.empresa, cobcons.controller.cota,
  cobcons.controller.pagamentos, cobcons.controller.precobem,
  cobcons.controller.grupo, cobcons.controller.bem, cobcons.controller.reuniao,
  cobcons.controller.pendencia, cobcons.controller.fasejuridica,
  cobcons.controller.credito, cobcons.controller.bemalienado,
  cobcons.controller.agenda, cobcons.controller.cotacaomoeda,
  cobcons.controller.total, cobcons.controller.totalgrupo,
  cobcons.controller.inadimplente, cobcons.controller.rnp,
  cobcons.controller.tabularencerrados, cobcons.controller.comissaopermanencia,
  cobcons.controller.itemcomissaopermanencia,
  cobcons.controller.fichapagamentos, cobcons.controller.sag,
  cobcons.controller.demonstrativo, cobcons.controller.saldornpdatabase,
  cobcons.controller.rateiopagamentos, cobcons.controller.pagamentosrnp,
  cobcons.controller.relatorio, cobcons.controller.admcon,
  cobcons.controller.faixacomissao, cobcons.controller.regracomissao,
  cobcons.controller.filial, cobcons.controller.equipe,
  cobcons.controller.agente, cobcons.controller.nivelsupervisao,
  cobcons.controller.periodo, cobcons.controller.venda,
  cobcons.controller.situacaocontrato, cobcons.controller.parcelacomissao;

constructor TControllerFactory.Create;
begin

end;

destructor TControllerFactory.Destroy;
begin
  inherited Destroy;
end;

class function TControllerFactory.New: iControllerFactory;
begin
  Result := Self.Create;
end;

function TControllerFactory.Conexao(pBanco: Integer): iModelConexao;
begin
  Result := TModelFactory.New.Conexao(pBanco);
end;

function TControllerFactory.ClienteWS: iClienteWebService;
begin
  Result := TModelFactory.New.ClienteWS;
end;

function TControllerFactory.Query(aConexao: iModelConexao): iQueryRest;
begin
  Result := TModelFactory.New.QueryRest(Aconexao);
end;

function TControllerFactory.Usuario: iControllerUsuario;
begin
  Result := TControllerUsuario.New;
end;

function TControllerFactory.UsuarioLogado: iControllerUsuarioLogado;
begin
  Result := TControllerUsuarioLogado.New;
end;

function TControllerFactory.Empresa: iControllerEmpresa;
begin
  Result := TControllerEmpresa.New;
end;

function TControllerFactory.Cota: iControllerCota;
begin
  Result := TControllerCota.New;
end;

function TControllerFactory.Pagamentos: iControllerPagamentos;
begin
  Result := TControllerPagamentos.New;
end;

function TControllerFactory.PrecoBem: iControllerPrecoBem;
begin
  Result := TControllerPrecoBem.New;
end;

function TControllerFactory.Grupo: iControllerGrupo;
begin
  Result := TControllerGrupo.New;
end;

function TControllerFactory.Reuniao: iControllerReuniao;
begin
  Result := TControllerReuniao.New;
end;

function TControllerFactory.Bem: iControllerBem;
begin
  Result := TControllerBem.New;
end;

function TControllerFactory.Pendencia: iControllerPendencia;
begin
  Result := TControllerPendencia.New;
end;

function TControllerFactory.FaseJuridica: iControllerFaseJuridica;
begin
  Result := TControllerFaseJuridica.New;
end;

function TControllerFactory.Credito: iControllerCredito;
begin
  Result := TControllerCredito.New;
end;

function TControllerFactory.BemAlienado: iControllerBemAlienado;
begin
  Result := TControllerBemAlienado.New;
end;

function TControllerFactory.Agenda: iControllerAgenda;
begin
  Result := TControllerAgenda.New;
end;

function TControllerFactory.CotacaoMoeda: iControllerCotacaoMoeda;
begin
  Result := TControllerCotacaoMoeda.New;
end;

function TControllerFactory.Total: iControllerTotal;
begin
  Result := TControllerTotal.New;
end;

function TControllerFactory.TotalGrupo: iControllerTotalGrupo;
begin
  Result := TControllerTotalGrupo.New;
end;

function TControllerFactory.Inadimplente: iControllerInadimplente;
begin
  Result := TControllerInadimplente.New;
end;

function TControllerFactory.RNP: iControllerRnp;
begin
  Result := TControllerRnp.New;
end;

function TControllerFactory.TabularEncerrados: iControllerTabularEncerrados;
begin
  Result := TControllerTabularEncerrados.New;
end;

function TControllerFactory.ComissaoPermanencia: iControllerComissaoPermanencia;
begin
  Result := TControllerComissaoPermanencia.New;
end;

function TControllerFactory.ItemComissaoPermanencia: iControllerItemComissaoPermanencia;
begin
  Result := TControllerItemComissaoPermanencia.New;
end;

function TControllerFactory.FichaPagamentos: iControllerFichaPagamentos;
begin
  Result := TControllerFichaPagamentos.New;
end;

function TControllerFactory.Sag: iControllerSag;
begin
  Result := TControllerSag.New;
end;

function TControllerFactory.Demonstrativo: iControllerDemonstrativo;
begin
  Result := TControllerDemonstrativo.New;
end;

function TControllerFactory.SaldoRnpDataBase: iControllerSaldoRnpDataBase;
begin
  Result := TControllerSaldoRnpDataBase.New;
end;

function TControllerFactory.RateioPagamentos: iControllerRateioPagamentos;
begin
  Result := TControllerRateioPagamentos.New;
end;

function TControllerFactory.PagamentosRnp: iControllerPgRnp;
begin
  Result := TControllerPagamentosRnp.New;
end;

function TControllerFactory.Relatorios(pBanco: Integer): iControllerRelatorio;
begin
  Result := TControllerRelatorio.New(pBanco);
end;

function TControllerFactory.AdmCon: iControllerAdmcon;
begin
  Result := TControllerAdmCon.New;
end;

function TControllerFactory.FaixaComissao: iControllerFaixaComissao;
begin
  Result := TControllerFaixaComissao.New;
end;

function TControllerFactory.RegraComissao: iControllerRegraComissao;
begin
  Result := TControllerRegraComissao.New;
end;

function TControllerFactory.Filial: iControllerFilial;
begin
  Result := TControllerFilial.New;
end;

function TControllerFactory.Equipe: iControllerEquipe;
begin
  Result := TControllerEquipe.New;
end;

function TControllerFactory.Agente: iControllerAgente;
begin
  Result := TControllerAgente.New;
end;

function TControllerFactory.NivelSupervisao: iControllerNivelSupervisao;
begin
  Result := TControllerNivelSupervisao.New;
end;

function TControllerFactory.SituacaoContrato: iControllerSituacaoContrato;
begin
  Result := TControllerSituacaoContrato.New;
end;

function TControllerFactory.Periodo: iControllerPeriodo;
begin
  Result := TControllerPeriodo.New;
end;

function TControllerFactory.Venda: iControllerVenda;
begin
  Result := TControllerVenda.New;
end;

function TControllerFactory.ParcelaComissao: iControllerParcelaComissao;
begin
  Result := TControllerParcelaComissao.New;
end;

end.

