unit cobcons.controller.tabularencerrados;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.bufferdataset, cobcons.model.interfaces, db, ComCtrls, ExtCtrls;

type

    { TControllerTabularEncerrados }

    TControllerTabularEncerrados = class (TInterfacedObject, iControllerTabularEncerrados)
    private
      FEntidade: iModelTabularEncerrados;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerTabularEncerrados;

      function LIMITEMINIMO(aValue: Double): iControllerTabularEncerrados;
      function DATALIMITE(aValue: Tdatetime): Icontrollertabularencerrados;
      function DATAREF(aValue: Integer): Icontrollertabularencerrados;
      function DATASEP(aValue: TDateTime): Icontrollertabularencerrados;
      function ANDAMENTO(aValue: TAndamento): iControllerTabularEncerrados;
      function LOG(aValue: TAndamento): iControllerTabularEncerrados;
      function PBINICIO(aValue: TPBMaximo): iControllerTabularEncerrados;
      function PBPOSICAO(aValue: TPBPosicao): iControllerTabularEncerrados;
      function RetornarSaldoDataBase: Currency;
      function CalcularSaldoRnpCota(pGrupo, pSeq, pCota: String; pCCDev: iModelBufferDataset): Double;
      function GravarAplicacaoRnp(pAgente, pTipoDoc, pHistorico: String; pDataBase: TDateTime; pValor: Double ): iControllerTabularEncerrados;
      function CalcularSaldoRnpDataBase(pSaldoContabil: Double): TDataSet;
      function ResumoCalculo: TDataSet;
      procedure AtualizarSaldoRnp;
      procedure Tabular;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerTabularEncerrados }

constructor TControllerTabularEncerrados.Create;
begin
  FEntidade := TModelFactory.New.TabularEncerrados;
end;

destructor TControllerTabularEncerrados.Destroy;
begin
  inherited Destroy;
end;

class function TControllerTabularEncerrados.New: iControllerTabularEncerrados;
begin
  Result := Self.Create;
end;

function TControllerTabularEncerrados.LIMITEMINIMO(aValue: Double
  ): iControllerTabularEncerrados;
begin
  Result := Self;
  FEntidade.LIMITEMINIMO(Avalue);
end;

function TControllerTabularEncerrados.DATALIMITE(aValue: Tdatetime
  ): Icontrollertabularencerrados;
begin
  Result := Self;
  FEntidade.DATALIMITE(Avalue);
end;

function TControllerTabularEncerrados.DATAREF(aValue: Integer
  ): Icontrollertabularencerrados;
begin
  Result := Self;
  FEntidade.DATAREF(Avalue);
end;

function TControllerTabularEncerrados.DATASEP(aValue: TDateTime
  ): Icontrollertabularencerrados;
begin
  Result := Self;
  FEntidade.DATASEP(Avalue);
end;

function TControllerTabularEncerrados.ANDAMENTO(aValue: TAndamento
  ): iControllerTabularEncerrados;
begin
  Result := Self;
  FEntidade.ANDAMENTO(Avalue);
end;

function TControllerTabularEncerrados.LOG(aValue: TAndamento
  ): iControllerTabularEncerrados;
begin
  Result := Self;
  FEntidade.LOG(Avalue);
end;

function TControllerTabularEncerrados.PBINICIO(aValue: TPBMaximo
  ): iControllerTabularEncerrados;
begin
  Result := Self;
  FEntidade.PBINICIO(Avalue);
end;

function TControllerTabularEncerrados.PBPOSICAO(aValue: TPBPosicao
  ): iControllerTabularEncerrados;
begin
  Result := Self;
  FEntidade.PBPOSICAO(Avalue);
end;

function TControllerTabularEncerrados.RetornarSaldoDataBase: Currency;
begin
  Result := FEntidade.RetornarSaldoDataBase;
end;

function TControllerTabularEncerrados.CalcularSaldoRnpCota(pGrupo, pSeq,
  pCota: String; pCCDev: iModelBufferDataset): Double;
begin
  Result := FEntidade.CalcularSaldoRnpCota(Pgrupo, Pseq, Pcota, Pccdev);
end;

function TControllerTabularEncerrados.GravarAplicacaoRnp(pAgente, pTipoDoc,
  pHistorico: String; pDataBase: TDateTime; pValor: Double
  ): iControllerTabularEncerrados;
begin
  Result := Self;
  FEntidade.GravarAplicacaoRnp(pAgente, pTipoDoc, pHistorico, pDataBase, pValor);
end;

function TControllerTabularEncerrados.CalcularSaldoRnpDataBase(
  pSaldoContabil: Double): TDataSet;
begin
  Result := FEntidade.CalcularSaldoRnpDataBase(pSaldoContabil);
end;

function TControllerTabularEncerrados.ResumoCalculo: TDataSet;
begin
  Result := FEntidade.ResumoCalculo;
end;

procedure TControllerTabularEncerrados.AtualizarSaldoRnp;
begin
  FEntidade.AtualizarSaldoRnp;
end;

procedure TControllerTabularEncerrados.Tabular;
begin
  FEntidade.Tabular;
end;

end.

