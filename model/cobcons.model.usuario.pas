unit cobcons.model.usuario;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TModelUsuario }

   TModelUsuario = class (TInterfacedObject, iModelEntidade, iModelUsuario)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlUsuario;

       FCodigo: Integer;
       FUsuario: string;
       FSenha: string;
       FImagem: String;
       FIdAdm: Integer;
       FAtivo: Integer;
       FEsquema: Integer;

       FLista : TStringList;

       function RetornarSQL(pTipo: Integer): string;
     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelUsuario;

       function Novo: iModelEntidade;
       function Alterar: iModelEntidade;
       function Excluir: iModelEntidade;
       function ListarPorDescricao(aDescricao: String): iModelEntidade;
       function ListarPorCodigo(aCodigo: Integer): iModelEntidade;
       function DataSet: TDataSet;
       function ProximoCodigo: Integer;

       function GravarImagem: iModelUsuario;
       function GravarSenha: iModelUsuario;
       function Listarcombobox: TStringList;
       function CODIGO(aValue: Integer): iModelUsuario; overload;
       function USUARIO(aValue: String): iModelUsuario; overload;
       function SENHA(aValue: String): iModelUsuario; overload;
       function IMAGEM(aValue: String): iModelUsuario; overload;
       function IDADM(aValue: Integer): iModelUsuario; overload;
       function ATIVO(aValue: Integer): iModelUsuario; overload;
       function ESQUEMA(aValue: Integer): iModelUsuario; overload;
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

uses cobcons.model.sql.factory;

  { TModelUsuario }

function Tmodelusuario.Retornarsql(Ptipo: Integer): String;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  case Ptipo of
    0: vSql := Format(FSQL.SqlNovo,[ FCodigo,
                                   QuotedStr(FUsuario),
                                   QuotedStr(FImagem),
                                   FIdAdm,
                                   QuotedStr(FSenha),
                                   FAtivo,
                                   FEsquema]);
    1: vSql := Format(FSQL.SqlAlterar,[ QuotedStr(FUsuario),
                                   FIdAdm,
                                   QuotedStr(FSenha),
                                   FAtivo,
                                   FEsquema,
                                   FCodigo]);
    2: vSql := FSQL.SqlProximoCodigo;
    3: vSql := Format(FSQL.SqlExcluir,[ FCodigo]);
    4: vSql := Format(FSQL.SqlGravarImagem, [QuotedStr(FImagem), FCodigo]);
    5: vSql := Format(FSQL.SqlGravarSenha, [QuotedStr(FSenha), FCodigo]);
  end;
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

constructor Tmodelusuario.Create(Aquery: Iqueryrest);
begin
  FQuery := Aquery;
  FLista := TStringList.Create;
  FSQL := TModelSQLFactory.New.SqlUsuario;
end;

destructor Tmodelusuario.Destroy;
begin
  FLista.Free;
  inherited Destroy;
end;

class function Tmodelusuario.New(Aquery: Iqueryrest): Imodelusuario;
begin
  Result := Self.Create(Aquery);
end;

function Tmodelusuario.Novo: Imodelentidade;
begin
  FQuery.Executar(RetornarSQL(0));
  Result := Self;
end;

function Tmodelusuario.Alterar: Imodelentidade;
begin
  FQuery.Executar(RetornarSQL(1));
  Result := Self;
end;

function Tmodelusuario.Excluir: Imodelentidade;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(3));
end;

function Tmodelusuario.Listarpordescricao(Adescricao: String): Imodelentidade;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlListarPorDescricao(Adescricao));
end;

function Tmodelusuario.Listarporcodigo(Acodigo: Integer): Imodelentidade;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlListarPorCodigo(Acodigo));
end;

function Tmodelusuario.Dataset: Tdataset;
begin
  Result := FQuery.Dataset;
end;

function Tmodelusuario.Proximocodigo: Integer;
begin
  Result := 1;
  Result := FQuery.Open(RetornarSQL(2)).Dataset.FieldByName('MCOD').AsInteger + 1;
end;

function Tmodelusuario.Gravarimagem: Imodelusuario;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(4));
end;

function Tmodelusuario.Gravarsenha: Imodelusuario;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(5));
end;

function Tmodelusuario.Listarcombobox: Tstringlist;
var
  vDataSet: TDataSet;
begin
    vDataSet := FQuery.Open(FSQL.SqlListarcombobox).Dataset;
    FLista.Clear;
    while not vDataSet.EOF do
    begin
      FLista.Add(Format('%s|%d',[ vDataSet.FieldByName('NM_USU').AsString,
                                  vDataSet.FieldByName('CD_USU').AsInteger]));
      vDataSet.Next;
    end;
    Result := FLista;
end;

function Tmodelusuario.Codigo(Avalue: Integer): Imodelusuario;
begin
  FCodigo := Avalue;
  Result := Self;
end;

function Tmodelusuario.Usuario(Avalue: String): Imodelusuario;
begin
  FUsuario := Avalue;
  Result := Self;
end;

function Tmodelusuario.Senha(Avalue: String): Imodelusuario;
begin
  FSenha := Avalue;
  Result := Self;
end;

function Tmodelusuario.Imagem(Avalue: String): Imodelusuario;
begin
  FImagem := Avalue;
  Result := Self;
end;

function Tmodelusuario.Idadm(Avalue: Integer): Imodelusuario;
begin
  FIdAdm := Avalue;
  Result := Self;
end;

function Tmodelusuario.Ativo(Avalue: Integer): Imodelusuario;
begin
  FAtivo := Avalue;
  Result := Self;
end;

function Tmodelusuario.Esquema(Avalue: Integer): Imodelusuario;
begin
  FEsquema := Avalue;
  Result := Self;
end;

function Tmodelusuario.Esquema: Integer;
begin
  Result := FQuery.FieldByName('ESQUEMA').AsInteger;
end;

function Tmodelusuario.Codigo: Integer;
begin
  Result := FQuery.FieldByName('CD_USU').AsInteger;
end;

function Tmodelusuario.Usuario: String;
begin
  Result := FQuery.FieldByName('NM_USU').AsString;
end;

function Tmodelusuario.Senha: String;
begin
  Result := FQuery.FieldByName('CD_SENHA').AsString;
end;

function Tmodelusuario.Imagem: String;
begin
  Result := FQuery.FieldByName('DC_FIG').AsString;
end;

function Tmodelusuario.Idadm: Integer;
begin
  Result := FQuery.FieldByName('ID_ADM').AsInteger;
end;

function Tmodelusuario.Ativo: Integer;
begin
  Result := FQuery.FieldByName('ATIVO').AsInteger;
end;

function Tmodelusuario.Dcati: String;
begin
  Result := FQuery.FieldByName('DCATI').AsString;
end;

end.



