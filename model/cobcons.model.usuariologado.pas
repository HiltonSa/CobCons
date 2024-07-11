unit cobcons.model.usuariologado;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TModelUsuarioLogado }

   TModelUsuarioLogado = class (TInterfacedObject, iModelUsuarioLogado)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlUsuarioLogado;
       class var FInstancia: TModelUsuarioLogado;

       FCodigo: Integer;
       FUsuario: string;
       FSenha: string;
       FImagem: String;
       FIdAdm: Integer;
       FAtivo: Integer;
       FEsquema: Integer;
       procedure ValorarCampos(aDataSet: TDataSet);

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelUsuarioLogado;

       function ValidarUsuario(pNome, pSenha: string): Boolean;
       function AtualizarDados: iModelUsuarioLogado;
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

uses cobcons.model.sql.factory;


{ TModelUsuarioLogado }

procedure Tmodelusuariologado.Valorarcampos(Adataset: Tdataset);
begin
  FCodigo := aDataSet.FieldByName('CD_USU').AsInteger;
  FUsuario:= aDataSet.FieldByName('NM_USU').AsString;
  FSenha  := aDataSet.FieldByName('CD_SENHA').AsString;
  FImagem := aDataSet.FieldByName('DC_FIG').AsString;
  FIdAdm := aDataSet.FieldByName('ID_ADM').AsInteger;
  FAtivo  := aDataSet.FieldByName('ATIVO').AsInteger;
  FEsquema:= aDataSet.FieldByName('ESQUEMA').AsInteger;
end;

constructor Tmodelusuariologado.Create(Aquery: Iqueryrest);
begin
  FQuery := Aquery;
  FSQL := TModelSQLFactory.New.SqlUsuarioLogado;
end;

destructor Tmodelusuariologado.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelusuariologado.New(Aquery: Iqueryrest): Imodelusuariologado;
begin
  if not Assigned(FInstancia)
  then FInstancia := Self.Create(Aquery);
  Result := FInstancia;
end;

function Tmodelusuariologado.Validarusuario(Pnome, Psenha: String): Boolean;
var
  vDataSet: TDataSet;
begin
  Result := False;
  vDataSet :=FQuery.Open(Format(FSQL.SqlLogin,[ QuotedStr(pNome) ])).Dataset;
  if not vDataSet.EOF
  then begin
    ValorarCampos(vDataSet);
    if FAtivo=1
    then Result := ( FSenha = pSenha);
  end;
end;

function Tmodelusuariologado.Atualizardados: Imodelusuariologado;
begin
  Result := Self;
  ValorarCampos(FQuery.Open(Format(FSQL.SqlAtualizar, [ FCodigo ])).Dataset);
end;

function Tmodelusuariologado.Dataset: Tdataset;
begin
  Result := FQuery.Dataset;
end;

function Tmodelusuariologado.Codigo: Integer;
begin
  Result := FCodigo;
end;

function Tmodelusuariologado.Usuario: String;
begin
  Result := FUsuario;
end;

function Tmodelusuariologado.Senha: String;
begin
  Result := FSenha;
end;

function Tmodelusuariologado.Imagem: String;
begin
  Result := FImagem;
end;

function Tmodelusuariologado.Idadm: Integer;
begin
  Result := FIdAdm;
end;

function Tmodelusuariologado.Ativo: Integer;
begin
  Result := FAtivo;
end;

function Tmodelusuariologado.Esquema: Integer;
begin
  Result := FEsquema;
end;

end.


