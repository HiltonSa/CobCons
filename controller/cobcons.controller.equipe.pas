unit cobcons.controller.equipe;

{$mode Delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db, ComCtrls, ExtCtrls;

type

    { TControllerEquipe }

    TControllerEquipe = class (TInterfacedObject, iControllerEquipe)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelEquipe;

      function Dataset: TDataset;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerEquipe;

      function ListaPorCodigo(pCodigo: Integer): TDataSet;
      function ListaPorNome(pNome: String): TDataSet;
      function ListaComboBox(pFilial: Integer=0): TStringList;
      function Executar(pModo: TpModoManutencao): iControllerEquipe;
      function CODIGO: Integer; overload;
      function CODIGO(pValor: Integer): iControllerEquipe; overload;
      function DESCRICAO: String; overload;
      function DESCRICAO(pValor: String): iControllerEquipe; overload;
      function FILIAL: Integer; overload;
      function FILIAL(pValor: Integer): iControllerEquipe; overload;
      function SUPERVISOR: Integer; overload;
      function SUPERVISOR(pValor: Integer): iControllerEquipe; overload;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerEquipe }

function TControllerEquipe.Dataset: TDataset;
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

constructor TControllerEquipe.Create;
begin
  FConexao := TControllerFactory.New.Conexao(2);
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Equipe(fQuery);
end;

destructor TControllerEquipe.Destroy;
begin
  inherited Destroy;
end;

class function TControllerEquipe.New: iControllerEquipe;
begin
  Result := Self.Create;
end;

function TControllerEquipe.ListaPorCodigo(pCodigo: Integer): TDataSet;
begin
  FEntidade.ListaPorCodigo(pCodigo);
  Result := Dataset;
end;

function TControllerEquipe.ListaPorNome(pNome: String): TDataSet;
begin
  FEntidade.ListaPorNome(pNome);
  Result := Dataset;
end;

function TControllerEquipe.ListaComboBox(pFilial: Integer): TStringList;
begin
  Result := FEntidade.ListaComboBox(pFilial);
end;

function TControllerEquipe.Executar(pModo: TpModoManutencao): iControllerEquipe;
begin
  Result := Self;
  FEntidade.Executar(pModo);
end;

function TControllerEquipe.CODIGO: Integer;
begin
  Result := FEntidade.CODIGO;
end;

function TControllerEquipe.CODIGO(pValor: Integer): iControllerEquipe;
begin
  Result := Self;
  FEntidade.CODIGO(pValor);
end;

function TControllerEquipe.DESCRICAO: String;
begin
  Result := FEntidade.DESCRICAO;
end;

function TControllerEquipe.DESCRICAO(pValor: String): iControllerEquipe;
begin
  Result := Self;
  FEntidade.DESCRICAO(pValor);
end;

function TControllerEquipe.FILIAL: Integer;
begin
  Result := FEntidade.FILIAL;
end;

function TControllerEquipe.FILIAL(pValor: Integer): iControllerEquipe;
begin
  Result := Self;
  FEntidade.FILIAL(pValor);
end;

function TControllerEquipe.SUPERVISOR: Integer;
begin
  Result := FEntidade.SUPERVISOR;
end;

function TControllerEquipe.SUPERVISOR(pValor: Integer): iControllerEquipe;
begin
  Result := Self;
  FEntidade.SUPERVISOR(pValor);
end;

end.

