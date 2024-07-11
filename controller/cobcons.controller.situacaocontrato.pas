unit cobcons.controller.situacaocontrato;

{$mode Delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db, ComCtrls, ExtCtrls;

type

    { TControllerSituacaoContrato }

    TControllerSituacaoContrato = class (TInterfacedObject, iControllerSituacaoContrato)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelSituacaoContrato;

    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerSituacaoContrato;

      function ListaPorCodigo(pCodigo: Integer): TDataSet;
      function ListaPorNome(pNome: String): TDataSet;
      function ListaComboBox: TStringList;
      function CODIGO: Integer;
      function DESCRICAO: String;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerSituacaoContrato }

constructor TControllerSituacaoContrato.Create;
begin
  FConexao := TControllerFactory.New.Conexao(2);
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.SituacaoContrato(fQuery);
end;

destructor TControllerSituacaoContrato.Destroy;
begin
  inherited Destroy;
end;

class function TControllerSituacaoContrato.New: iControllerSituacaoContrato;
begin
  Result := Self.Create;
end;

function TControllerSituacaoContrato.ListaPorCodigo(pCodigo: Integer): TDataSet;
begin
  Result := FEntidade.ListaPorCodigo(pCodigo);
end;

function TControllerSituacaoContrato.ListaPorNome(pNome: String): TDataSet;
begin
  Result := FEntidade.ListaPorNome(pNome);
end;

function TControllerSituacaoContrato.ListaComboBox: TStringList;
begin
  Result := FEntidade.ListaComboBox;
end;

function TControllerSituacaoContrato.CODIGO: Integer;
begin
  Result := FEntidade.CODIGO;
end;

function TControllerSituacaoContrato.DESCRICAO: String;
begin
  Result := FEntidade.DESCRICAO;
end;

end.

