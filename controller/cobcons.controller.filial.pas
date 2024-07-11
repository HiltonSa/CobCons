unit cobcons.controller.filial;

{$mode Delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db, ComCtrls, ExtCtrls;

type

    { TControllerFilial }

    TControllerFilial = class (TInterfacedObject, iControllerFilial)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelFilial;

      function Dataset: TDataset;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerFilial;

      function ListaPorCodigo(pCodigo: Integer): TDataSet;
      function ListaPorNome(pNome: String): TDataSet;
      function ListaComboBox: TStringList;
      function Executar(pModo: TpModoManutencao): iControllerFilial;
      function CODIGO: Integer; overload;
      function CODIGO(pValor: Integer): iControllerFilial; overload;
      function DESCRICAO: String; overload;
      function DESCRICAO(pValor: String): iControllerFilial; overload;
      function RESPONSAVEL: Integer; overload;
      function RESPONSAVEL(pValor: Integer): iControllerFilial; overload;
      function CODEXT: String; overload;
      function CODEXT(pValor: String): iControllerFilial; overload;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerFilial }

function TControllerFilial.Dataset: TDataset;
var
  vLista: TStringList;
begin
  vLista := TStringList.Create;
  try
    FQuery.Dataset.GetFieldNames(vLista);
    if vLista.IndexOf('CODIGO') > -1
    then TIntegerField(FQuery.FieldByName('CODIGO')).DisplayFormat := '000';
    //if vLista.IndexOf('PCENTREGA') > -1
    //then TFloatField(FQuery.FieldByName('PCENTREGA')).DisplayFormat := ',#0.00';
    //if vLista.IndexOf('PCPER') > -1
    //then TFloatField(FQuery.FieldByName('PCPER')).DisplayFormat := ',#0.00';
    //if vLista.IndexOf('VIGENCIA') > -1
    //then TDateTimeField(FQuery.FieldByName('VIGENCIA')).DisplayFormat := 'dd/mm/yyyy';
    Result := FQuery.Dataset;
  finally
    vLista.Free;
  end;
end;

constructor TControllerFilial.Create;
begin
  FConexao := TControllerFactory.New.Conexao(2);
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Filial(fQuery);
end;

destructor TControllerFilial.Destroy;
begin
  inherited Destroy;
end;

class function TControllerFilial.New: iControllerFilial;
begin
  Result := Self.Create;
end;

function TControllerFilial.ListaPorCodigo(pCodigo: Integer): TDataSet;
begin
  FEntidade.ListaPorCodigo(pCodigo);
  Result := Dataset;
end;

function TControllerFilial.ListaPorNome(pNome: String): TDataSet;
begin
  FEntidade.ListaPorNome(pNome);
  Result := Dataset;
end;

function TControllerFilial.ListaComboBox: TStringList;
begin
  Result := FEntidade.ListaComboBox;
end;

function TControllerFilial.Executar(pModo: TpModoManutencao): iControllerFilial;
begin
  Result := Self;
  FEntidade.Executar(pModo);
end;

function TControllerFilial.CODIGO: Integer;
begin
  Result := FEntidade.CODIGO;
end;

function TControllerFilial.CODIGO(pValor: Integer): iControllerFilial;
begin
  Result := Self;
  FEntidade.CODIGO(pValor);
end;

function TControllerFilial.DESCRICAO: String;
begin
  Result := FEntidade.DESCRICAO;
end;

function TControllerFilial.DESCRICAO(pValor: String): iControllerFilial;
begin
  Result := Self;
  FEntidade.DESCRICAO(pValor);
end;

function TControllerFilial.RESPONSAVEL: Integer;
begin
  Result := FEntidade.RESPONSAVEL;
end;

function TControllerFilial.RESPONSAVEL(pValor: Integer): iControllerFilial;
begin
  Result := Self;
  FEntidade.RESPONSAVEL(pValor);
end;

function TControllerFilial.CODEXT: String;
begin
  Result := FEntidade.CODEXT;
end;

function TControllerFilial.CODEXT(pValor: String): iControllerFilial;
begin
  Result := Self;
  FEntidade.CODEXT(pValor);
end;

end.

