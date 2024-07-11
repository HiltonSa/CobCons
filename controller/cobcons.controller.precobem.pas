unit cobcons.controller.precobem;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerPrecoBem }

    TControllerPrecoBem = class (TInterfacedObject, iControllerPrecoBem)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelPrecoBem;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerPrecoBem;

      function RetornaPrecoBemData(pBem, pFilial: String; pData: TDateTime): iControllerPrecoBem;
      function RetornaPrecoBem(pBem, pFilial: String): iControllerPrecoBem;
      function Dataset: TDataSet;
      function PRE_TABE: Double;
      function PRE_REAL: Double;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerPrecoBem }

constructor Tcontrollerprecobem.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.PrecoBem(fQuery);
end;

destructor Tcontrollerprecobem.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollerprecobem.New: Icontrollerprecobem;
begin
  Result := Self.Create;
end;

function Tcontrollerprecobem.Retornaprecobemdata(Pbem, Pfilial: String; Pdata: Tdatetime): Icontrollerprecobem;
begin
  Result := Self;
  FEntidade.RetornaPrecoBemData(Pbem, Pfilial, Pdata);
end;

function Tcontrollerprecobem.Retornaprecobem(Pbem, Pfilial: String): Icontrollerprecobem;
begin
  Result := Self;
  FEntidade.RetornaPrecoBem(Pbem, Pfilial);
end;

function Tcontrollerprecobem.Dataset: Tdataset;
begin
  Result := FEntidade.Dataset;
end;

function Tcontrollerprecobem.Pre_tabe: Double;
begin
  Result := FEntidade.PRE_TABE;
end;

function Tcontrollerprecobem.Pre_real: Double;
begin
  Result := FEntidade.PRE_REAL;
end;

end.


