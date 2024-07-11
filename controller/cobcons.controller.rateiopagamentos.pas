unit cobcons.controller.rateiopagamentos;

{$mode Delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.bufferdataset, cobcons.model.interfaces, db, ComCtrls, ExtCtrls;

type

    { TControllerRateioPagamentos }

    TControllerRateioPagamentos = class (TInterfacedObject, iControllerRateioPagamentos)
    private
      FEntidade: iModelRateioPagamentos;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerRateioPagamentos;

      function LOG(aValue: TAndamento): iControllerRateioPagamentos;
      function DATABASE(aValue: TDateTime): iControllerRateioPagamentos;
      function AGENTE(aValue: String): iControllerRateioPagamentos;
      function TIPODOC(aValue: String): iControllerRateioPagamentos;
      function HISTORICO(aValue: String): iControllerRateioPagamentos;
      function RateioRecebimentos(pDataset: TDataSet): iControllerRateioPagamentos;
      function Dataset: TDataset;
      procedure GravarRateio;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerRateioPagamentos }

constructor TControllerRateioPagamentos.Create;
begin
  FEntidade := TModelFactory.New.RateioPagamentos;
end;

destructor TControllerRateioPagamentos.Destroy;
begin
  inherited Destroy;
end;

class function TControllerRateioPagamentos.New: iControllerRateioPagamentos;
begin
  Result := Self.Create;
end;

function TControllerRateioPagamentos.LOG(aValue: TAndamento
  ): iControllerRateioPagamentos;
begin
  Result := Self;
  FEntidade.LOG(Avalue);
end;

function TControllerRateioPagamentos.DATABASE(aValue: TDateTime
  ): iControllerRateioPagamentos;
begin
  Result := Self;
  FEntidade.DATABASE(aValue);
end;

function TControllerRateioPagamentos.AGENTE(aValue: String
  ): iControllerRateioPagamentos;
begin
  Result := Self;
  FEntidade.AGENTE(aValue);
end;

function TControllerRateioPagamentos.TIPODOC(aValue: String
  ): iControllerRateioPagamentos;
begin
  Result := Self;
  FEntidade.TIPODOC(aValue);
end;

function TControllerRateioPagamentos.HISTORICO(aValue: String
  ): iControllerRateioPagamentos;
begin
  Result := Self;
  FEntidade.HISTORICO(aValue);
end;

function TControllerRateioPagamentos.RateioRecebimentos(pDataset: TDataSet
  ): iControllerRateioPagamentos;
begin
  Result := Self;
  FEntidade.RateioRecebimentos(pDataset);
end;

function TControllerRateioPagamentos.Dataset: TDataset;
begin
  FEntidade.Dataset;
end;

procedure TControllerRateioPagamentos.GravarRateio;
begin
  FEntidade.GravarRateio;
end;

end.

