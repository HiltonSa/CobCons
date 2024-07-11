unit cobcons.controller.faixacomissao;

{$mode Delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db, ComCtrls, ExtCtrls;

type

    { TControllerFaixaComissao }

    TControllerFaixaComissao = class (TInterfacedObject, iControllerFaixaComissao)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelFaixaComissao;

      function Dataset: TDataset;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerFaixaComissao;

      function ListaPorCodigo(pCodigo: Integer): TDataSet;
      function ListaPorEmpresa(pEmpresa: Integer): TDataSet;
      function ListaComboBox(pEmpresa:Integer): TStringList;
      function Executar(pModo: TpModoManutencao): iControllerFaixaComissao;
      function CODIGO: Integer; overload;
      function CODIGO(pValor: Integer): iControllerFaixaComissao; overload;
      function EMPRESA: Integer; overload;
      function EMPRESA(pValor: Integer): iControllerFaixaComissao; overload;
      function DESCRICAO: String; overload;
      function DESCRICAO(pValor: String): iControllerFaixaComissao; overload;
      function MINIMO: Double; overload;
      function MINIMO(pValor: Double): iControllerFaixaComissao; overload;
      function MAXIMO: Double; overload;
      function MAXIMO(pValor: Double): iControllerFaixaComissao; overload;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerFaixaComissao }

function TControllerFaixaComissao.Dataset: TDataset;
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

constructor TControllerFaixaComissao.Create;
begin
  FConexao := TControllerFactory.New.Conexao(2);
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.FaixaComissao(fQuery);
end;

destructor TControllerFaixaComissao.Destroy;
begin
  inherited Destroy;
end;

class function TControllerFaixaComissao.New: iControllerFaixaComissao;
begin
  Result := Self.Create;
end;

function TControllerFaixaComissao.ListaPorCodigo(pCodigo: Integer): TDataSet;
begin
  FEntidade.ListaPorCodigo(pCodigo);
  Result := Dataset;
end;

function TControllerFaixaComissao.ListaPorEmpresa(pEmpresa: Integer): TDataSet;
begin
  FEntidade.ListaPorEmpresa(pEmpresa);
  Result := Dataset;
end;

function TControllerFaixaComissao.ListaComboBox(pEmpresa: Integer): TStringList;
begin
  Result := FEntidade.ListaComboBox(pEmpresa);
end;

function TControllerFaixaComissao.Executar(pModo: TpModoManutencao): iControllerFaixaComissao;
begin
  Result := Self;
  FEntidade.Executar(pModo);
end;

function TControllerFaixaComissao.CODIGO: Integer;
begin
  Result := FEntidade.CODIGO;
end;

function TControllerFaixaComissao.CODIGO(pValor: Integer): iControllerFaixaComissao;
begin
  Result := Self;
  FEntidade.CODIGO(pValor);
end;

function TControllerFaixaComissao.EMPRESA: Integer;
begin
  Result := FEntidade.EMPRESA;
end;

function TControllerFaixaComissao.EMPRESA(pValor: Integer
  ): iControllerFaixaComissao;
begin
  Result := Self;
  FEntidade.EMPRESA(pValor);
end;

function TControllerFaixaComissao.DESCRICAO: String;
begin
  Result := FEntidade.DESCRICAO;
end;

function TControllerFaixaComissao.DESCRICAO(pValor: String
  ): iControllerFaixaComissao;
begin
  Result := Self;
  FEntidade.DESCRICAO(pValor);
end;

function TControllerFaixaComissao.MINIMO: Double;
begin
  Result := FEntidade.MINIMO;
end;

function TControllerFaixaComissao.MINIMO(pValor: Double
  ): iControllerFaixaComissao;
begin
  Result := Self;
  FEntidade.MINIMO(pValor);
end;

function TControllerFaixaComissao.MAXIMO: Double;
begin
  Result := FEntidade.MAXIMO;
end;

function TControllerFaixaComissao.MAXIMO(pValor: Double
  ): iControllerFaixaComissao;
begin
  Result := Self;
  FEntidade.MAXIMO(pValor);
end;


end.

