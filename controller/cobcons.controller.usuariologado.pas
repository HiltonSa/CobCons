unit cobcons.controller.usuariologado;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.controller.factory,
  cobcons.model.factory, cobcons.model.interfaces, db;

type

    { TControllerUsuarioLogado }

    TControllerUsuarioLogado = class (TInterfacedObject, iControllerUsuarioLogado)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelUsuarioLogado;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerUsuarioLogado;

      function ValidarUsuario(pNome, pSenha: string): Boolean;
      function AtualizarDados: iControllerUsuarioLogado;
      function DataSet: TDataSet;
      function CODIGO: Integer;
      function USUARIO: String;
      function SENHA: String;
      function IMAGEM: String;
      function IDADM: Integer;
      function ATIVO: Integer;
      function ESQUEMA: Integer;

  end;


implementation

{ TControllerUsuarioLogado }

constructor Tcontrollerusuariologado.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.UsuarioLogado(fQuery);
end;

destructor Tcontrollerusuariologado.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollerusuariologado.New: Icontrollerusuariologado;
begin
  Result := Self.Create;
end;

function Tcontrollerusuariologado.Validarusuario(Pnome, Psenha: String): Boolean;
begin
  Result := FEntidade.ValidarUsuario(Pnome,Psenha);
end;

function Tcontrollerusuariologado.Atualizardados: Icontrollerusuariologado;
begin
  Result := Self;
  FEntidade.AtualizarDados;
end;

function Tcontrollerusuariologado.Dataset: Tdataset;
begin
  Result := FEntidade.Dataset;
end;

function Tcontrollerusuariologado.Codigo: Integer;
begin
  Result := FEntidade.CODIGO;
end;

function Tcontrollerusuariologado.Usuario: String;
begin
  Result := FEntidade.USUARIO;
end;

function Tcontrollerusuariologado.Senha: String;
begin
  Result := FEntidade.SENHA;
end;

function Tcontrollerusuariologado.Imagem: String;
begin
  Result := FEntidade.IMAGEM;
end;

function Tcontrollerusuariologado.Idadm: Integer;
begin
  Result := FEntidade.IDADM;
end;

function Tcontrollerusuariologado.Ativo: Integer;
begin
  Result := FEntidade.ATIVO;
end;

function Tcontrollerusuariologado.Esquema: Integer;
begin
  Result := FEntidade.ESQUEMA;
end;

end.


