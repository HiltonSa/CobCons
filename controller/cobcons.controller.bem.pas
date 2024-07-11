unit cobcons.controller.bem;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerBem }

    TControllerBem = class (TInterfacedObject, iControllerBem)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelBem;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerBem;

      function RetornaBem(pBem: string): iControllerBem;
      function Dataset: TDataSet;
      function DESCRIC: string;
      function DCTIPOBEM: string;
      function DCFABBEM: string;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerBem }

constructor Tcontrollerbem.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Bem(fQuery);
end;

destructor Tcontrollerbem.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollerbem.New: Icontrollerbem;
begin
  Result := Self.Create;
end;

function Tcontrollerbem.Retornabem(Pbem: String): Icontrollerbem;
begin
  FEntidade.RetornaBem(Pbem);
end;

function Tcontrollerbem.Dataset: Tdataset;
begin
  Result := FEntidade.Dataset;
end;

function Tcontrollerbem.Descric: String;
begin
  Result := FEntidade.DESCRIC;
end;

function Tcontrollerbem.Dctipobem: String;
begin
  Result := FEntidade.DCTIPOBEM;
end;

function Tcontrollerbem.Dcfabbem: String;
begin
  Result := FEntidade.DCFABBEM;
end;

end.

