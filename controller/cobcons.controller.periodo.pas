unit cobcons.controller.periodo;

{$mode Delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db, ComCtrls, ExtCtrls;

type

    { TControllerPeriodo }

    TControllerPeriodo = class (TInterfacedObject, iControllerPeriodo)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelPeriodo;

      function Dataset: TDataset;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerPeriodo;

      function ListaPorCodigo(pCodigo: Integer): TDataSet;
      function ListaPorNome(pNome: String): TDataSet;
      function ListaComboBox: TStringList;
      function ListaComboBoxCalculo: TStringList;
      function CalcularComissoes: iControllerPeriodo;
      function Executar(pModo: TpModoManutencao): iControllerPeriodo;
      function RetornaPeriodoAtual: iControllerPeriodo;
      function CODIGO: Integer; overload;
      function CODIGO(aValue: Integer): iControllerPeriodo; overload;
      function DESCRICAO: String;
      function DTINI: TDateTime;
      function DTFIM: TDateTime;
      function DTCAL: TDateTime; overload;
      function DTCAL(pValor: TDateTime): iControllerPeriodo; overload;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerPeriodo }

function TControllerPeriodo.Dataset: TDataset;
var
  vLista: TStringList;
begin
  vLista := TStringList.Create;
  try
    FQuery.Dataset.GetFieldNames(vLista);
    if vLista.IndexOf('CODIGO') > -1
    then TIntegerField(FQuery.FieldByName('CODIGO')).DisplayFormat := '0000';
    if vLista.IndexOf('DTINI') > -1
    then TDateTimeField(FQuery.FieldByName('DTINI')).DisplayFormat := 'dd/mm/yyyy';
    if vLista.IndexOf('DTFIM') > -1
    then TDateTimeField(FQuery.FieldByName('DTFIM')).DisplayFormat := 'dd/mm/yyyy';
    if vLista.IndexOf('DTCAL') > -1
    then TDateTimeField(FQuery.FieldByName('DTCAL')).DisplayFormat := 'dd/mm/yyyy';
    //if vLista.IndexOf('PCENTREGA') > -1
    //then TFloatField(FQuery.FieldByName('PCENTREGA')).DisplayFormat := ',#0.00';
    //if vLista.IndexOf('PCPER') > -1
    //then TFloatField(FQuery.FieldByName('PCPER')).DisplayFormat := ',#0.00';
    Result := FQuery.Dataset;
  finally
    vLista.Free;
  end;
end;

constructor TControllerPeriodo.Create;
begin
  FConexao := TControllerFactory.New.Conexao(2);
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Periodo(fQuery);
end;

destructor TControllerPeriodo.Destroy;
begin
  inherited Destroy;
end;

class function TControllerPeriodo.New: iControllerPeriodo;
begin
  Result := Self.Create;
end;

function TControllerPeriodo.ListaPorCodigo(pCodigo: Integer): TDataSet;
begin
  FEntidade.ListaPorCodigo(pCodigo);
  Result := Dataset;
end;

function TControllerPeriodo.ListaPorNome(pNome: String): TDataSet;
begin
  FEntidade.ListaPorNome(pNome);
  Result := Dataset;
end;

function TControllerPeriodo.ListaComboBox: TStringList;
begin
  Result := FEntidade.ListaComboBox;
end;

function TControllerPeriodo.ListaComboBoxCalculo: TStringList;
begin
  Result := FEntidade.ListaComboBoxCalculo;
end;

function TControllerPeriodo.CalcularComissoes: iControllerPeriodo;
begin
  Result := Self;
  FEntidade.CalcularComissoes;
end;

function TControllerPeriodo.Executar(pModo: TpModoManutencao
  ): iControllerPeriodo;
begin
  Result := Self;
  FEntidade.Executar(pModo);
end;

function TControllerPeriodo.RetornaPeriodoAtual: iControllerPeriodo;
begin
  Result := Self;
  FEntidade.RetornaPeriodoAtual;
end;

function TControllerPeriodo.CODIGO: Integer;
begin
  Result := FEntidade.CODIGO;
end;

function TControllerPeriodo.CODIGO(aValue: Integer): iControllerPeriodo;
begin
  Result := Self;
  FEntidade.CODIGO(aValue);
end;

function TControllerPeriodo.DESCRICAO: String;
begin
  Result := FEntidade.DESCRICAO;
end;

function TControllerPeriodo.DTINI: TDateTime;
begin
  Result := FEntidade.DTINI;
end;

function TControllerPeriodo.DTFIM: TDateTime;
begin
  Result := FEntidade.DTFIM;
end;

function TControllerPeriodo.DTCAL: TDateTime;
begin
  Result := FEntidade.DTCAL;
end;

function TControllerPeriodo.DTCAL(pValor: TDateTime): iControllerPeriodo;
begin
  Result := Self;
  FEntidade.DTCAL(pValor);
end;

end.

