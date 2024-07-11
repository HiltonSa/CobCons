unit cobcons.controller.relatorio;

{$mode Delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerRelatorio }

    TControllerRelatorio = class (TInterfacedObject, iControllerRelatorio)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelRelatorio;
    public
      constructor Create(pBanco: Integer = 0);
      destructor Destroy; override;
      class function New(pBanco: Integer = 0): iControllerRelatorio;

      function MovimentosNoPeriodo(pInicio, pFim: TDateTime): TDataSet;
      function MovimentosPeriodoDetalhe(pAgente, pDocum: String; pContab: TDateTime): TDataSet;
      function RelatorioComissoes(pPeriodo:Integer; pFil: Integer = 0): TDataset;
      function ProducaoVendas(pInicio, pFim: TDateTime; pAgente, pEquipe, pFilial: Integer): TDataSet;
      function CancelamentosNoPeriodo(pInicio, pFim: TDateTime): TDataSet;
      function VendasAgente(pAgente: Integer): TDataSet;
      function ResumoVendas(pPeriodo: Integer): TDataSet;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerRelatorio }

constructor TControllerRelatorio.Create(pBanco: Integer);
begin
  FConexao := TControllerFactory.New.Conexao(pBanco);
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Relatorio(fQuery);
end;

destructor TControllerRelatorio.Destroy;
begin
  inherited Destroy;
end;

class function TControllerRelatorio.New(pBanco: Integer): iControllerRelatorio;
begin
  Result := Self.Create(pBanco);
end;

function TControllerRelatorio.MovimentosNoPeriodo(pInicio, pFim: TDateTime
  ): TDataSet;
begin
  Result := FEntidade.MovimentosNoPeriodo(pInicio, pFim);
end;

function TControllerRelatorio.MovimentosPeriodoDetalhe(pAgente, pDocum: String;
  pContab: TDateTime): TDataSet;
begin
  Result := FEntidade.MovimentosPeriodoDetalhe(pAgente, pDocum, pContab);
end;

function TControllerRelatorio.RelatorioComissoes(pPeriodo: Integer;
  pFil: Integer): TDataset;
begin
  Result := FEntidade.RelatorioComissoes( pPeriodo, pFil );
end;

function TControllerRelatorio.ProducaoVendas(pInicio, pFim: TDateTime; pAgente,
  pEquipe, pFilial: Integer): TDataSet;
begin
  Result := FEntidade.ProducaoVendas(pInicio, pFim, pAgente, pEquipe, pFilial);
end;

function TControllerRelatorio.CancelamentosNoPeriodo(pInicio, pFim: TDateTime
  ): TDataSet;
begin
  Result := FEntidade.CancelamentosNoPeriodo(pInicio, pFim);
end;

function TControllerRelatorio.VendasAgente(pAgente: Integer): TDataSet;
begin
  Result := FEntidade.VendasAgente(pAgente);
end;

function TControllerRelatorio.ResumoVendas(pPeriodo: Integer): TDataSet;
begin
  Result := FEntidade.ResumoVendas(pPeriodo);
end;


end.

