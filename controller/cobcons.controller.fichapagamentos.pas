unit cobcons.controller.fichapagamentos;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerFichaPagamentos }

    TControllerFichaPagamentos = class (TInterfacedObject, iControllerFichaPagamentos)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelFichaPagamentos;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerFichaPagamentos;

      function GRUPO(aValue: String): iControllerFichaPagamentos;
      function SEQ(aValue: String): iControllerFichaPagamentos;
      function COTA(aValue: String): iControllerFichaPagamentos;
      function DATALIMITE(aValue: TDateTime): iControllerFichaPagamentos;
      function DTRECOMPOESALDORNP(aValue: TDateTime): iControllerFichaPagamentos;
      function SaldoInicialRnp: Double;
      function CalcularSaldoDevedorCota: TDataSet;
      function MontarPagamentos: TDataSet;
      function MontarPendencias: TDataSet;
      function RetornarTotaisCota: TDataSet;
      function ContaCorrenteDevolucoes: TDataSet;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerFichaPagamentos }

constructor Tcontrollerfichapagamentos.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.FichaPagamentos(fQuery);
end;

destructor Tcontrollerfichapagamentos.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollerfichapagamentos.New: Icontrollerfichapagamentos;
begin
  Result := Self.Create;
end;

function Tcontrollerfichapagamentos.Grupo(Avalue: String): Icontrollerfichapagamentos;
begin
  Result := Self;
  FEntidade.GRUPO(Avalue);
end;

function Tcontrollerfichapagamentos.Seq(Avalue: String): Icontrollerfichapagamentos;
begin
  Result := Self;
  FEntidade.SEQ(Avalue);
end;

function Tcontrollerfichapagamentos.Cota(Avalue: String): Icontrollerfichapagamentos;
begin
  Result := Self;
  FEntidade.COTA(Avalue);
end;

function Tcontrollerfichapagamentos.Datalimite(Avalue: Tdatetime): Icontrollerfichapagamentos;
begin
  Result := Self;
  FEntidade.DATALIMITE(Avalue);
end;

function Tcontrollerfichapagamentos.Dtrecompoesaldornp(Avalue: Tdatetime): Icontrollerfichapagamentos;
begin
  Result := Self;
  FEntidade.DTRECOMPOESALDORNP(Avalue);
end;

function Tcontrollerfichapagamentos.Saldoinicialrnp: Double;
begin
  Result := FEntidade.SaldoInicialRnp;
end;

function Tcontrollerfichapagamentos.Calcularsaldodevedorcota: Tdataset;
begin
  Result := FEntidade.CalcularSaldoDevedorCota;
end;

function Tcontrollerfichapagamentos.Montarpagamentos: Tdataset;
begin
  Result := FEntidade.MontarPagamentos;
end;

function Tcontrollerfichapagamentos.Montarpendencias: Tdataset;
begin
  Result := FEntidade.MontarPendencias;
end;

function Tcontrollerfichapagamentos.Retornartotaiscota: Tdataset;
begin
  Result := FEntidade.RetornarTotaisCota;
end;

function Tcontrollerfichapagamentos.Contacorrentedevolucoes: Tdataset;
begin
  Result := FEntidade.ContaCorrenteDevolucoes;
end;

end.


