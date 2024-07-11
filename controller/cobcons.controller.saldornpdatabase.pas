unit cobcons.controller.saldornpdatabase;

{$mode Delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerSaldoRnpDataBase }

    TControllerSaldoRnpDataBase = class (TInterfacedObject, iControllerSaldoRnpDataBase)
    private
      //FConexao: iModelConexao;
      //fQuery : iQueryRest;
      FEntidade: iModelSaldoRnpDataBase;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerSaldoRnpDataBase;

      function DATABASE(aValue: TDateTime): iControllerSaldoRnpDataBase;
      function DATAREF(aValue: Integer): iControllerSaldoRnpDataBase;
      function DATASEP(aValue: TDateTime): iControllerSaldoRnpDataBase;
      function LOG(aValue: TAndamento): iControllerSaldoRnpDataBase;
      function GravarAplicacaoRnp(pAgente, pTipoDoc, pHistorico: String; pDataBase: TDateTime; pValor: Double ): iControllerSaldoRnpDataBase;
      function RetornarSaldoDataBase: Currency;
      function CalcularSaldoRnpDataBase(pSaldoContabil: Double): iControllerSaldoRnpDataBase;
      function Dataset: TDataSet;

  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerSaldoRnpDataBase }

constructor TControllerSaldoRnpDataBase.Create;
begin
  //FConexao := TControllerFactory.New.Conexao;
  //fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.SaldoRnpDatabase;
end;

destructor TControllerSaldoRnpDataBase.Destroy;
begin
  inherited Destroy;
end;

class function TControllerSaldoRnpDataBase.New: iControllerSaldoRnpDataBase;
begin
  Result := Self.Create;
end;

function TControllerSaldoRnpDataBase.DATABASE(aValue: TDateTime
  ): iControllerSaldoRnpDataBase;
begin
  Result := Self;
  FEntidade.DATABASE(aValue);
end;

function TControllerSaldoRnpDataBase.DATAREF(aValue: Integer
  ): iControllerSaldoRnpDataBase;
begin
  Result := Self;
  FEntidade.DATAREF(aValue);
end;

function TControllerSaldoRnpDataBase.DATASEP(aValue: TDateTime
  ): iControllerSaldoRnpDataBase;
begin
  Result := Self;
  FEntidade.DATASEP(aValue);
end;

function TControllerSaldoRnpDataBase.LOG(aValue: TAndamento
  ): iControllerSaldoRnpDataBase;
begin
  Result := Self;
  FEntidade.LOG(aValue);
end;

function TControllerSaldoRnpDataBase.GravarAplicacaoRnp(pAgente, pTipoDoc,
  pHistorico: String; pDataBase: TDateTime; pValor: Double
  ): iControllerSaldoRnpDataBase;
begin
  Result := Self;
  FEntidade.GravarAplicacaoRnp(pAgente, pTipoDoc, pHistorico, pDataBase, pValor);
end;

function TControllerSaldoRnpDataBase.RetornarSaldoDataBase: Currency;
begin
  Result := FEntidade.RetornarSaldoDataBase;
end;

function TControllerSaldoRnpDataBase.CalcularSaldoRnpDataBase(
  pSaldoContabil: Double): iControllerSaldoRnpDataBase;
begin
  Result := Self;
  FEntidade.CalcularSaldoRnpDataBase(pSaldoContabil);
end;

function TControllerSaldoRnpDataBase.Dataset: TDataSet;
begin
  Result := FEntidade.Dataset;
end;

end.


