unit cobcons.controller.bemalienado;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerBemAlienado }

    TControllerBemAlienado = class (TInterfacedObject, iControllerBemAlienado)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelBemAlienado;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerBemAlienado;

      function RetornaBensAlienadosCota(pGrupo, pCota: String): iControllerBemAlienado;
      function RetornaBemAlienado(pGrupo, pCota, pChassis: String): iControllerBemAlienado;
      function DataSet: TDataSet;
      function NR_CHASS: String;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerBemAlienado }

constructor Tcontrollerbemalienado.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.BemAlienado(fQuery);
end;

destructor Tcontrollerbemalienado.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollerbemalienado.New: Icontrollerbemalienado;
begin
  Result := Self.Create;
end;

function Tcontrollerbemalienado.Retornabensalienadoscota(Pgrupo, Pcota: String): Icontrollerbemalienado;
begin
  Result := Self;
  FEntidade.RetornaBensAlienadosCota(Pgrupo, Pcota);
end;

function Tcontrollerbemalienado.Retornabemalienado(Pgrupo, Pcota, Pchassis: String): Icontrollerbemalienado;
begin
  Result := Self;
  FEntidade.RetornaBemAlienado(Pgrupo, Pcota, Pchassis);
end;

function Tcontrollerbemalienado.Dataset: Tdataset;
begin
  Result := FEntidade.Dataset;
end;

function Tcontrollerbemalienado.Nr_chass: String;
begin
  Result := FEntidade.NR_CHASS;
end;

end.
