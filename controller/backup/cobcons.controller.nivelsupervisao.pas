unit cobcons.controller.nivelsupervisao;

{$mode Delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db, ComCtrls, ExtCtrls;

type

    { TControllerNivelSupervisao }

    TControllerNivelSupervisao = class (TInterfacedObject, iControllerNivelSupervisao)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelNivelSupervisao;

    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerNivelSupervisao;

      function ListaPorCodigo(pCodigo: Integer): TDataSet;
      function ListaPorNome(pNome: String): TDataSet;
      function ListaComboBox: TStringList;
      function CODIGO: Integer;
      function DESCRICAO: String;
      function VDPROPRIA: Integer;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerNivelSupervisao }

constructor TControllerNivelSupervisao.Create;
begin
  FConexao := TControllerFactory.New.Conexao(2);
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.NivelSupervisao(fQuery);
end;

destructor TControllerNivelSupervisao.Destroy;
begin
  inherited Destroy;
end;

class function TControllerNivelSupervisao.New: iControllerNivelSupervisao;
begin
  Result := Self.Create;
end;

function TControllerNivelSupervisao.ListaPorCodigo(pCodigo: Integer): TDataSet;
begin
  Result := FEntidade.ListaPorCodigo(pCodigo);
end;

function TControllerNivelSupervisao.ListaPorNome(pNome: String): TDataSet;
begin
  Result := FEntidade.ListaPorNome(pNome);
end;

function TControllerNivelSupervisao.ListaComboBox: TStringList;
begin
  Result := FEntidade.ListaComboBox;
end;

function TControllerNivelSupervisao.CODIGO: Integer;
begin
  Result := FEntidade.CODIGO;
end;

function TControllerNivelSupervisao.DESCRICAO: String;
begin
  Result := FEntidade.DESCRICAO;
end;

function TControllerNivelSupervisao.VDPROPRIA: Integer;
begin
  Result := FEntidade.VDPROPRIA;
end;

end.

