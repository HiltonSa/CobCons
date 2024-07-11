unit cobcons.controller.pagamentos;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerPagamentos }

    TControllerPagamentos = class (TInterfacedObject, iControllerPagamentos)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelPagamentos;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerPagamentos;

      function RetornaListaAgentes: TStringList;
      function RetornaListaTipoDocumento: TStringList;
      function RetornaNovoDocumentoAgente(pAgente, pTipo, pHistorico: String; pContab: TDateTime; pValor: Double): String;
      function RetornaDocumentoAgente(pAgente, pTipo, pHistorico: String; pContab: TDateTime): String;
      function RetornaNovoAviso(pGrupo: String): Integer;
      function RetornaPagamentosCota(pGrupo, pSeq, pCota: String): iControllerPagamentos;
      function RetornaPagamentosDataBase(pIni, pFim: TDateTime): iControllerPagamentos;
      function RetornaVlrBemApreendidoCota(pGrupo, pSeq, pCota: String): Double;
      function RetornaPagamentosDevolucaoCota(pGrupo, pSeq, pCota: String; pInicio, pLimite: TDateTime): iControllerPagamentos;
      function IncluirComissaoPermanencia(pAgente, pNrDoc, pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pValor: Double): iControllerPagamentos;
      function IncluirRendimentoRnp(pAgente, pNrDoc, pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pValor: Double): iControllerPagamentos;
      function IncluirPagamentoRnp(pAgente, pNrDoc, pGrupo, pSeq, pCota, pTipo: String; pContab, pOcorrencia: TDateTime; pValor: Double): iControllerPagamentos;
      function IncluirSaldoRecomposicaoRnp(pAgente, pNrDoc, pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pSaldo: Double): iControllerPagamentos;
      function IncluirRateioRecebimento(pAgente, pNrDoc, pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pSaldo: Double): iControllerPagamentos;
      function ExcluirComissaoPermanencia(pAgente, pNrDoc: string): iControllerPagamentos;
      function CotaTemCorrecoes(pGrupo, pSeq, pCota: String): Boolean;
      function DataSet: TDataSet;
      function TemDados: Boolean;
      function Proximo: Boolean;
      function AVISO: String;
      function TIPO_MOV: String;
      function DCTIPOMOV: String;
      function D_VENCTO: TDateTime;
      function DT_PAGTO: TDateTime;
      function P_NORMAL: Double;
      function P_DIFER: Double;
      function P_ANTEC: Double;
      function P_RATEIO: Double;
      function VALOR: Double;
      function MUL_JUR: Double;
      function BEM: String;
      function F_AQUISI: Double;
      function ADMINIST: Double;
      function F_RESERV: Double;
      function OUTROS: Double;
      function SIMBOLO: String;
      function HISTORIC: String;
      function D_CONTAB: TDateTime;
      function FIL_COM: String;
      function DCBEM: String;
      function ESTORNADO: Boolean;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerPagamentos }

constructor TControllerPagamentos.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Pagamentos(fQuery);
end;

destructor TControllerPagamentos.Destroy;
begin
  inherited Destroy;
end;

class function TControllerPagamentos.New: iControllerPagamentos;
begin
  Result := Self.Create;
end;

function TControllerPagamentos.RetornaListaAgentes: TStringList;
begin
  Result := FEntidade.RetornaListaAgentes;
end;

function TControllerPagamentos.RetornaListaTipoDocumento: TStringList;
begin
  Result := FEntidade.RetornaListaTipoDocumento;
end;

function TControllerPagamentos.RetornaNovoDocumentoAgente(pAgente, pTipo,
  pHistorico: String; pContab: TDateTime; pValor: Double): String;
begin
  Result := FEntidade.RetornaNovoDocumentoAgente(Pagente, Ptipo, Phistorico, Pcontab, Pvalor);
end;

function TControllerPagamentos.RetornaDocumentoAgente(pAgente, pTipo,
  pHistorico: String; pContab: TDateTime): String;
begin
  Result := FEntidade.RetornaDocumentoAgente(Pagente, Ptipo, Phistorico, Pcontab);
end;

function TControllerPagamentos.RetornaNovoAviso(pGrupo: String): Integer;
begin
  Result := FEntidade.RetornaNovoAviso(Pgrupo);
end;

function TControllerPagamentos.RetornaPagamentosCota(pGrupo, pSeq, pCota: String
  ): iControllerPagamentos;
begin
  Result := Self;
  FEntidade.RetornaPagamentosCota(Pgrupo, Pseq, Pcota);
end;

function TControllerPagamentos.RetornaPagamentosDataBase(pIni, pFim: TDateTime
  ): iControllerPagamentos;
begin
  Result := Self;
  FEntidade.RetornaPagamentosDataBase(pIni, pFim);
end;

function TControllerPagamentos.RetornaVlrBemApreendidoCota(pGrupo, pSeq,
  pCota: String): Double;
begin
  Result := FEntidade.RetornaVlrBemApreendidoCota(Pgrupo, Pseq, Pcota);
end;

function TControllerPagamentos.RetornaPagamentosDevolucaoCota(pGrupo, pSeq,
  pCota: String; pInicio, pLimite: TDateTime): iControllerPagamentos;
begin
  Result := Self;
  FEntidade.RetornaPagamentosDevolucaoCota(Pgrupo, Pseq, Pcota, pInicio, Plimite);
end;

function TControllerPagamentos.IncluirComissaoPermanencia(pAgente, pNrDoc,
  pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pValor: Double
  ): iControllerPagamentos;
begin
  Result := Self;
  FEntidade.IncluirComissaoPermanencia(Pagente, Pnrdoc, Pgrupo, Pseq, Pcota, Pdatacalculo, Pvalor);
end;

function TControllerPagamentos.IncluirRendimentoRnp(pAgente, pNrDoc, pGrupo,
  pSeq, pCota: String; pDataCalculo: TDateTime; pValor: Double
  ): iControllerPagamentos;
begin
  Result := Self;
  FEntidade.IncluirRendimentoRnp(Pagente, Pnrdoc, Pgrupo, Pseq, Pcota, Pdatacalculo, Pvalor);
end;

function TControllerPagamentos.IncluirPagamentoRnp(pAgente, pNrDoc, pGrupo,
  pSeq, pCota, pTipo: String; pContab, pOcorrencia: TDateTime; pValor: Double
  ): iControllerPagamentos;
begin
  Result := Self;
  FEntidade.IncluirPagamentoRnp(Pagente, Pnrdoc, Pgrupo, Pseq, Pcota, pTipo, pContab, pOcorrencia, pValor);
end;

function TControllerPagamentos.IncluirSaldoRecomposicaoRnp(pAgente, pNrDoc,
  pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pSaldo: Double
  ): iControllerPagamentos;
begin
  Result := Self;
  FEntidade.IncluirSaldoRecomposicaoRnp(Pagente, Pnrdoc, Pgrupo, Pseq, Pcota, Pdatacalculo, pSaldo);
end;

function TControllerPagamentos.IncluirRateioRecebimento(pAgente, pNrDoc,
  pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pSaldo: Double
  ): iControllerPagamentos;
begin
  Result := Self;
  FEntidade.IncluirRateioRecebimento(Pagente, Pnrdoc, Pgrupo, Pseq, Pcota, Pdatacalculo, pSaldo);
end;

function TControllerPagamentos.ExcluirComissaoPermanencia(pAgente,
  pNrDoc: string): iControllerPagamentos;
begin
  Result := Self;
  FEntidade.ExcluirComissaoPermanencia(Pagente, Pnrdoc);
end;

function TControllerPagamentos.CotaTemCorrecoes(pGrupo, pSeq, pCota: String
  ): Boolean;
begin
  Result := FEntidade.CotaTemCorrecoes(pGrupo, pSeq, pCota);
end;

function TControllerPagamentos.DataSet: TDataSet;
begin
  Result := FEntidade.DataSet;
end;

function TControllerPagamentos.TemDados: Boolean;
begin
  Result := FEntidade.TemDados;
end;

function TControllerPagamentos.Proximo: Boolean;
begin
  Result:= FEntidade.Proximo;
end;

function TControllerPagamentos.AVISO: String;
begin
  Result := FEntidade.AVISO;
end;

function TControllerPagamentos.TIPO_MOV: String;
begin
  Result := FEntidade.TIPO_MOV;
end;

function TControllerPagamentos.DCTIPOMOV: String;
begin
  Result := FEntidade.DCTIPOMOV;
end;

function TControllerPagamentos.D_VENCTO: TDateTime;
begin
  Result := FEntidade.D_VENCTO;
end;

function TControllerPagamentos.DT_PAGTO: TDateTime;
begin
  Result := FEntidade.DT_PAGTO;
end;

function TControllerPagamentos.P_NORMAL: Double;
begin
  Result := FEntidade.P_NORMAL;
end;

function TControllerPagamentos.P_DIFER: Double;
begin
  Result := FEntidade.P_DIFER;
end;

function TControllerPagamentos.P_ANTEC: Double;
begin
  Result := FEntidade.P_ANTEC;
end;

function TControllerPagamentos.P_RATEIO: Double;
begin
  Result := FEntidade.P_RATEIO;
end;

function TControllerPagamentos.VALOR: Double;
begin
  Result := FEntidade.VALOR;
end;

function TControllerPagamentos.MUL_JUR: Double;
begin
  Result := FEntidade.MUL_JUR;
end;

function TControllerPagamentos.BEM: String;
begin
  Result := FEntidade.BEM;
end;

function TControllerPagamentos.F_AQUISI: Double;
begin
  Result := FEntidade.F_AQUISI;
end;

function TControllerPagamentos.ADMINIST: Double;
begin
  Result := FEntidade.ADMINIST;
end;

function TControllerPagamentos.F_RESERV: Double;
begin
  Result := FEntidade.F_RESERV;
end;

function TControllerPagamentos.OUTROS: Double;
begin
  Result := FEntidade.OUTROS;
end;

function TControllerPagamentos.SIMBOLO: String;
begin
  Result := FEntidade.SIMBOLO;
end;

function TControllerPagamentos.HISTORIC: String;
begin
  Result := FEntidade.HISTORIC;
end;

function TControllerPagamentos.D_CONTAB: TDateTime;
begin
  Result := FEntidade.D_CONTAB;
end;

function TControllerPagamentos.FIL_COM: String;
begin
  Result := FEntidade.FIL_COM;
end;

function TControllerPagamentos.DCBEM: String;
begin
  Result := FEntidade.DCBEM;
end;

function TControllerPagamentos.ESTORNADO: Boolean;
begin
  Result := FEntidade.ESTORNADO;
end;

end.


