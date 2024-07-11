unit cobcons.controller.usuario;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.controller.factory,
  cobcons.model.factory, cobcons.model.interfaces, db;

type

    { TControllerUsuario }

    TControllerUsuario = class (TInterfacedObject, iControllerEntidade, iControllerUsuario)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelUsuario;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerUsuario;

      function Novo: iControllerEntidade;
      function Alterar: iControllerEntidade;
      function Excluir: iControllerEntidade;
      function ListarPorDescricao(aDescricao: String): iControllerEntidade;
      function ListarPorCodigo(aCodigo: Integer): iControllerEntidade;
      function DataSet: TDataSet;
      function ProximoCodigo: Integer;

      function ListarComboBox: TStringList;
      function GravarImagem: iControllerUsuario;
      function GravarSenha: iControllerUsuario;
      function CODIGO(aValue: Integer): iControllerUsuario; overload;
      function USUARIO(aValue: String): iControllerUsuario; overload;
      function SENHA(aValue: String): iControllerUsuario; overload;
      function IMAGEM(aValue: String): iControllerUsuario; overload;
      function IDADM(aValue: Integer): iControllerUsuario; overload;
      function ATIVO(aValue: Integer): iControllerUsuario; overload;
      function ESQUEMA(aValue: Integer): iControllerUsuario; overload;
      function ESQUEMA: Integer; overload;
      function CODIGO: Integer; overload;
      function USUARIO: String; overload;
      function SENHA: String; overload;
      function IMAGEM: String; overload;
      function IDADM: Integer; overload;
      function ATIVO: Integer; overload;
      function DCATI: string;

  end;


implementation

{ TControllerUsuario }

constructor Tcontrollerusuario.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Usuario(fQuery);
end;

destructor Tcontrollerusuario.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollerusuario.New: Icontrollerusuario;
begin
  Result := Self.Create;
end;

function Tcontrollerusuario.Novo: Icontrollerentidade;
begin
  Result := Self;
  FEntidade.Novo;
end;

function Tcontrollerusuario.Alterar: Icontrollerentidade;
begin
  Result := Self;
  FEntidade.Alterar;
end;

function Tcontrollerusuario.Excluir: Icontrollerentidade;
begin
  Result := Self;
  FEntidade.Excluir;
end;

function Tcontrollerusuario.Listarpordescricao(Adescricao: String): Icontrollerentidade;
begin
  Result := Self;
  FEntidade.ListarPorDescricao(Adescricao);
end;

function Tcontrollerusuario.Listarporcodigo(Acodigo: Integer): Icontrollerentidade;
begin
  Result := Self;
  FEntidade.ListarPorCodigo(Acodigo);
end;

function Tcontrollerusuario.Dataset: Tdataset;
begin
  Result := FEntidade.DataSet;
end;

function Tcontrollerusuario.Proximocodigo: Integer;
begin
  Result := FEntidade.ProximoCodigo;
end;

function Tcontrollerusuario.Listarcombobox: Tstringlist;
begin
  Result := FEntidade.ListarComboBox;
end;

function Tcontrollerusuario.Gravarimagem: Icontrollerusuario;
begin
  Result := Self;
  FEntidade.GravarImagem;
end;

function Tcontrollerusuario.Gravarsenha: Icontrollerusuario;
begin
  Result := Self;
  FEntidade.GravarSenha;
end;

function Tcontrollerusuario.Codigo(Avalue: Integer): Icontrollerusuario;
begin
  Result := Self;
  FEntidade.CODIGO(Avalue);
end;

function Tcontrollerusuario.Usuario(Avalue: String): Icontrollerusuario;
begin
  Result := Self;
  FEntidade.USUARIO(Avalue);
end;

function Tcontrollerusuario.Senha(Avalue: String): Icontrollerusuario;
begin
  Result := Self;
  FEntidade.SENHA(Avalue);
end;

function Tcontrollerusuario.Imagem(Avalue: String): Icontrollerusuario;
begin
  Result := Self;
  FEntidade.IMAGEM(Avalue);
end;

function Tcontrollerusuario.Idadm(Avalue: Integer): Icontrollerusuario;
begin
  Result := Self;
  FEntidade.IDADM(Avalue);
end;

function Tcontrollerusuario.Ativo(Avalue: Integer): Icontrollerusuario;
begin
  Result := Self;
  FEntidade.ATIVO(Avalue);
end;

function Tcontrollerusuario.Esquema(Avalue: Integer): Icontrollerusuario;
begin
  Result := Self;
  FEntidade.ESQUEMA(Avalue);
end;

function Tcontrollerusuario.Esquema: Integer;
begin
  Result := FEntidade.ESQUEMA;
end;

function Tcontrollerusuario.Codigo: Integer;
begin
  Result := FEntidade.CODIGO;
end;

function Tcontrollerusuario.Usuario: String;
begin
  Result := FEntidade.USUARIO;
end;

function Tcontrollerusuario.Senha: String;
begin
  Result := FEntidade.SENHA;
end;

function Tcontrollerusuario.Imagem: String;
begin
  Result := FEntidade.IMAGEM;
end;

function Tcontrollerusuario.Idadm: Integer;
begin
  Result := FEntidade.IDADM;
end;

function Tcontrollerusuario.Ativo: Integer;
begin
  Result := FEntidade.ATIVO;
end;

function Tcontrollerusuario.Dcati: String;
begin
  Result := FEntidade.DCATI;
end;

end.


