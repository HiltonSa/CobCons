unit cobcons.controller.venda;

{$mode Delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces,
  cobcons.model.bufferdataset, db, ComCtrls, ExtCtrls;

type

    { TControllerVenda }

    TControllerVenda = class (TInterfacedObject, iControllerVenda)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelVenda;

    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerVenda;

      function ListaPorCodigo(pCodigo: Integer): iControllerVenda;
      function ContratoJaInformado(pEmpresa: Integer; pContrato: String): Integer;
      function RetornaBem(pEmpresa: Integer; pCdBem: String): iControllerVenda;
      function RetornarVendas(itPsq: Integer; stPesq: String): iModelBufferDataset;
      function Executar(pModo: TpModoManutencao): iControllerVenda;
      function CancelarVenda(pCodigo: Integer): iControllerVenda;
      function Dataset: TDataset;
      function CODIGO: Integer;
      function EMPRESA: Integer; overload;
      function EMPRESA(pValor: Integer): iControllerVenda; overload;
      function CONTRATO: String; overload;
      function CONTRATO(pValor: String): iControllerVenda; overload;
      function AGENTE: Integer; overload;
      function AGENTE(pValor: Integer): iControllerVenda; overload;
      function DTVENDA: TDateTime; overload;
      function DTVENDA(pValor: TDateTime): iControllerVenda; overload;
      function PERIODO: Integer; overload;
      function PERIODO(pValor: Integer): iControllerVenda; overload;
      function CDBEM: String; overload;
      function CDBEM(pValor: String): iControllerVenda; overload;
      function DCBEM: String; overload;
      function DCBEM(pValor: String): iControllerVenda; overload;
      function VALOR: Double; overload;
      function VALOR(pValor: Double): iControllerVenda; overload;
      function SITUACAO: Integer; overload;
      function SITUACAO(pValor: Integer): iControllerVenda; overload;
      function DTCON: TDateTime; overload;
      function DTCON(pValor: TDateTime): iControllerVenda; overload;
      function NOME: String; overload;
      function NOME(pValor: String): iControllerVenda; overload;
      function DDD: String; overload;
      function DDD(pValor: String): iControllerVenda; overload;
      function FONE: String; overload;
      function FONE(pValor: String): iControllerVenda; overload;
      function TPPES: Integer; overload;
      function TPPES(pValor: Integer): iControllerVenda; overload;
      function CPFCNPJ: String; overload;
      function CPFCNPJ(pValor: String): iControllerVenda; overload;
      function GRUPO: String; overload;
      function GRUPO(pValor: String): iControllerVenda; overload;
      function COTA: Integer; overload;
      function COTA(pValor: Integer): iControllerVenda; overload;
      function DIAVENC: Integer; overload;
      function DIAVENC(pValor: Integer): iControllerVenda; overload;
      function VLRPAGO: Double; overload;
      function VLRPAGO(pValor: Double): iControllerVenda; overload;
      function NMEMP: String;
      function NMAGE: String;
      function DCSIT: String;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerVenda }

constructor TControllerVenda.Create;
begin
  FConexao := TControllerFactory.New.Conexao(2);
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Venda(fQuery);
end;

destructor TControllerVenda.Destroy;
begin
  inherited Destroy;
end;

class function TControllerVenda.New: iControllerVenda;
begin
  Result := Self.Create;
end;

function TControllerVenda.ListaPorCodigo(pCodigo: Integer): iControllerVenda;
begin
  Result := Self;
  FEntidade.ListaPorCodigo(pCodigo);
end;

function TControllerVenda.ContratoJaInformado(pEmpresa: Integer;
  pContrato: String): Integer;
begin
  Result := FEntidade.ContratoJaInformado(pEmpresa, pContrato);
end;

function TControllerVenda.RetornaBem(pEmpresa: Integer; pCdBem: String
  ): iControllerVenda;
begin
  Result := Self;
  FEntidade.RetornaBem(pEmpresa, pCdBem);
end;

function TControllerVenda.RetornarVendas(itPsq: Integer; stPesq: String
  ): iModelBufferDataset;
begin
  Result := FEntidade.RetornarVendas(itPsq, stPesq);
end;

function TControllerVenda.Executar(pModo: TpModoManutencao): iControllerVenda;
begin
  Result := Self;
  FEntidade.Executar(pModo);
end;

function TControllerVenda.CancelarVenda(pCodigo: Integer): iControllerVenda;
begin
  Result := Self;
  FEntidade.CancelarVenda(pCodigo);
end;

function TControllerVenda.Dataset: TDataset;
begin
  Result := FEntidade.Dataset;
end;

function TControllerVenda.CODIGO: Integer;
begin
  Result := FEntidade.CODIGO;
end;

function TControllerVenda.EMPRESA: Integer;
begin
  Result := FEntidade.EMPRESA;
end;

function TControllerVenda.EMPRESA(pValor: Integer): iControllerVenda;
begin
  Result := Self;
  FEntidade.EMPRESA(pValor);
end;

function TControllerVenda.CONTRATO: String;
begin
  Result := FEntidade.CONTRATO;
end;

function TControllerVenda.CONTRATO(pValor: String): iControllerVenda;
begin
  Result := Self;
  FEntidade.CONTRATO(pValor);
end;

function TControllerVenda.AGENTE: Integer;
begin
  Result := FEntidade.AGENTE;
end;

function TControllerVenda.AGENTE(pValor: Integer): iControllerVenda;
begin
  Result := Self;
  FEntidade.AGENTE(pValor);
end;

function TControllerVenda.DTVENDA: TDateTime;
begin
  Result := FEntidade.DTVENDA;
end;

function TControllerVenda.DTVENDA(pValor: TDateTime): iControllerVenda;
begin
  Result := Self;
  FEntidade.DTVENDA(pValor);
end;

function TControllerVenda.PERIODO: Integer;
begin
  Result := FEntidade.PERIODO;
end;

function TControllerVenda.PERIODO(pValor: Integer): iControllerVenda;
begin
  Result := Self;
  FEntidade.PERIODO(pValor);
end;

function TControllerVenda.CDBEM: String;
begin
  Result := FEntidade.CDBEM;
end;

function TControllerVenda.CDBEM(pValor: String): iControllerVenda;
begin
  Result := Self;
  FEntidade.CDBEM(pValor);
end;

function TControllerVenda.DCBEM: String;
begin
  Result := FEntidade.DCBEM;
end;

function TControllerVenda.DCBEM(pValor: String): iControllerVenda;
begin
  Result := Self;
  FEntidade.DCBEM(pValor);
end;

function TControllerVenda.VALOR: Double;
begin
  Result := FEntidade.VALOR;
end;

function TControllerVenda.VALOR(pValor: Double): iControllerVenda;
begin
  Result := Self;
  FEntidade.VALOR(pValor);
end;

function TControllerVenda.SITUACAO: Integer;
begin
  Result := FEntidade.SITUACAO;
end;

function TControllerVenda.SITUACAO(pValor: Integer): iControllerVenda;
begin
  Result := Self;
  FEntidade.SITUACAO(pValor);
end;

function TControllerVenda.DTCON: TDateTime;
begin
  Result := FEntidade.DTCON;
end;

function TControllerVenda.DTCON(pValor: TDateTime): iControllerVenda;
begin
  Result := Self;
  FEntidade.DTCON(pValor);
end;

function TControllerVenda.NOME: String;
begin
  Result := FEntidade.NOME;
end;

function TControllerVenda.NOME(pValor: String): iControllerVenda;
begin
  Result := Self;
  FEntidade.NOME(pValor);
end;

function TControllerVenda.DDD: String;
begin
  Result := FEntidade.DDD;
end;

function TControllerVenda.DDD(pValor: String): iControllerVenda;
begin
  Result := Self;
  FEntidade.DDD(pValor);
end;

function TControllerVenda.FONE: String;
begin
  Result := FEntidade.FONE;
end;

function TControllerVenda.FONE(pValor: String): iControllerVenda;
begin
  Result := Self;
  FEntidade.FONE(pValor);
end;

function TControllerVenda.TPPES: Integer;
begin
  Result := FEntidade.TPPES;
end;

function TControllerVenda.TPPES(pValor: Integer): iControllerVenda;
begin
  Result := Self;
  FEntidade.TPPES(pValor);
end;

function TControllerVenda.CPFCNPJ: String;
begin
  Result := FEntidade.CPFCNPJ;
end;

function TControllerVenda.CPFCNPJ(pValor: String): iControllerVenda;
begin
  Result := Self;
  FEntidade.CPFCNPJ(pValor);
end;

function TControllerVenda.GRUPO: String;
begin
  Result := FEntidade.GRUPO;
end;

function TControllerVenda.GRUPO(pValor: String): iControllerVenda;
begin
  Result := Self;
  FEntidade.GRUPO(pValor);
end;

function TControllerVenda.COTA: Integer;
begin
  Result := FEntidade.COTA;
end;

function TControllerVenda.COTA(pValor: Integer): iControllerVenda;
begin
  Result := Self;
  FEntidade.COTA(pValor);
end;

function TControllerVenda.DIAVENC: Integer;
begin
  Result := FEntidade.DIAVENC;
end;

function TControllerVenda.DIAVENC(pValor: Integer): iControllerVenda;
begin
  Result := Self;
  FEntidade.DIAVENC(pValor);
end;

function TControllerVenda.VLRPAGO: Double;
begin
  Result := FEntidade.VLRPAGO;
end;

function TControllerVenda.VLRPAGO(pValor: Double): iControllerVenda;
begin
  Result := Self;
  FEntidade.VLRPAGO(pValor);
end;

function TControllerVenda.NMEMP: String;
begin
  Result := FEntidade.NMEMP;
end;

function TControllerVenda.NMAGE: String;
begin
  Result := FEntidade.NMAGE;
end;

function TControllerVenda.DCSIT: String;
begin
  Result := FEntidade.DCSIT;
end;

end.

