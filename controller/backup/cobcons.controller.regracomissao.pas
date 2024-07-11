unit cobcons.controller.regracomissao;

{$mode Delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db, ComCtrls, ExtCtrls;

type

    { TControllerRegraComissao }

    TControllerRegraComissao = class (TInterfacedObject, iControllerRegraComissao)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelRegraComissao;

      function Dataset: TDataset;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerRegraComissao;

      function ListaParcelasFaixa(pEmpresa, pFaixa: Integer): TDataSet;
      function ListaParcela(pEmpresa, pFaixa, pParcela: Integer): TDataSet;
      function Executar(pModo: TpModoManutencao): iControllerRegraComissao;
      function EMPRESA: Integer; overload;
      function EMPRESA(pValor: Integer): iControllerRegraComissao; overload;
      function PARCELA: Integer; overload;
      function PARCELA(pValor: Integer): iControllerRegraComissao; overload;
      function FAIXA: Integer; overload;
      function FAIXA(pValor: Integer): iControllerRegraComissao; overload;
      function PCLIB: Integer; overload;
      function PCLIB(pValor: Integer): iControllerRegraComissao; overload;
      function PERCENTUAL: Double; overload;
      function PERCENTUAL(pValor: Double): iControllerRegraComissao; overload;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerRegraComissao }

function TControllerRegraComissao.Dataset: TDataset;
var
  vLista: TStringList;
begin
  vLista := TStringList.Create;
  try
    FQuery.Dataset.GetFieldNames(vLista);
    if vLista.IndexOf('CODIGO') > -1
    then TIntegerField(FQuery.FieldByName('CODIGO')).DisplayFormat := '000';
    if vLista.IndexOf('MINIMO') > -1
    then TFloatField(FQuery.FieldByName('MINIMO')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('MAXIMO') > -1
    then TFloatField(FQuery.FieldByName('MAXIMO')).DisplayFormat := ',#0.00';
    Result := FQuery.Dataset;
  finally
    vLista.Free;
  end;
end;

constructor TControllerRegraComissao.Create;
begin
  FConexao := TControllerFactory.New.Conexao(2);
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.RegraComissao(fQuery);
end;

destructor TControllerRegraComissao.Destroy;
begin
  inherited Destroy;
end;

class function TControllerRegraComissao.New: iControllerRegraComissao;
begin
  Result := Self.Create;
end;

function TControllerRegraComissao.ListaParcelasFaixa(pEmpresa, pFaixa: Integer
  ): TDataSet;
begin
  FEntidade.ListaParcelasFaixa(pEmpresa, pFaixa);
  Result := Dataset;
end;

function TControllerRegraComissao.ListaParcela(pEmpresa, pFaixa,
  pParcela: Integer): TDataSet;
begin
  FEntidade.ListaParcela(pEmpresa, pFaixa, pParcela);
  Result := Dataset;
end;

function TControllerRegraComissao.Executar(pModo: TpModoManutencao): iControllerRegraComissao;
begin
  Result := Self;
  FEntidade.Executar(pModo);
end;

function TControllerRegraComissao.PARCELA: Integer;
begin
  Result := FEntidade.PARCELA;
end;

function TControllerRegraComissao.PARCELA(pValor: Integer): iControllerRegraComissao;
begin
  Result := Self;
  FEntidade.PARCELA(pValor);
end;

function TControllerRegraComissao.EMPRESA: Integer;
begin
  Result := FEntidade.EMPRESA;
end;

function TControllerRegraComissao.EMPRESA(pValor: Integer
  ): iControllerRegraComissao;
begin
  Result := Self;
  FEntidade.EMPRESA(pValor);
end;

function TControllerRegraComissao.FAIXA: Integer;
begin
  Result := FEntidade.FAIXA;
end;

function TControllerRegraComissao.FAIXA(pValor: Integer
  ): iControllerRegraComissao;
begin
  Result := Self;
  FEntidade.FAIXA(pValor);
end;

function TControllerRegraComissao.PCLIB: Integer;
begin
  Result := FEntidade.PCLIB;
end;

function TControllerRegraComissao.PCLIB(pValor: Integer
  ): iControllerRegraComissao;
begin
  Result := Self;
  FEntidade.PCLIB(pValor);
end;

function TControllerRegraComissao.PERCENTUAL: Double;
begin
  Result := FEntidade.PERCENTUAL;
end;

function TControllerRegraComissao.PERCENTUAL(pValor: Double
  ): iControllerRegraComissao;
begin
  Result := Self;
  FEntidade.PERCENTUAL(pValor);
end;

end.

