unit cobcons.model.sql.orausuario;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlOraUsuario }

  TModelSQlOraUsuario = class (TInterfacedObject, iModelSqlUsuario)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlUsuario;

      function SqlNovo: String;
      function SqlAlterar: String;
      function SqlExcluir: String;
      function SqlProximoCodigo: String;
      function SqlListarPorDescricao(aDescricao: String): String;
      function SqlListarPorCodigo(aCodigo: Integer): String;
      function SqlGravarImagem: String;
      function SqlGravarSenha: String;
      function SqlListarcombobox: string;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlOraUsuario }

const
  SQL_EXCLUIR = 'delete from CJCBUSU where CD_USU = %d';
  SQL_PROXIMO = 'select max(CD_USU) MCOD from CJCBUSU';
  SQL_INSERT = 'insert into CJCBUSU ( CD_USU, NM_USU, DC_FIG, ID_ADM, CD_SENHA, ATIVO, ESQUEMA) '+
                             'values ( %d, %s, %s, %d, %s, %d, %d)';
  SQL_UPDATE = 'update CJCBUSU set NM_USU = %s, ID_ADM = %d, CD_SENHA = %s, '+
                                   'ATIVO = %d, ESQUEMA = %d '+
               'where CD_USU = %d';
  SQL_UPDATE_IMAGEM = 'update CJCBUSU set DC_FIG = %s where CD_USU = %d';
  SQL_UPDATE_SENHA = 'update CJCBUSU set CD_SENHA = %s where CD_USU = %d';
  SQL_LISTA_DESCRICAO = 'select U.*, case U.ATIVO when 0 then ''Inativo'' when 1 then ''Ativo'' end DCATI from CJCBUSU U '+
                        'Where U.NM_USU like %s order by U.NM_USU';
  SQL_LISTA_CODIGO = 'select U.*, case U.ATIVO when 0 then ''Inativo'' when 1 then ''Ativo'' end DCATI from CJCBUSU U '+
                     'where U.CD_USU=%d';
  SQL_COMBO_BOX = 'select U.CD_USU, U.NM_USU from CJCBUSU U where U.ATIVO=1 order by U.NM_USU';

constructor TmodelsqlOrausuario.Create;
begin

end;

destructor TmodelsqlOrausuario.Destroy;
begin
  inherited Destroy;
end;

class function TmodelsqlOrausuario.New: Imodelsqlusuario;
begin
  Result := Self.Create;
end;

function TmodelsqlOrausuario.Sqlnovo: String;
begin
  Result := SQL_INSERT;
end;

function TmodelsqlOrausuario.Sqlalterar: String;
begin
  Result := SQL_UPDATE;
end;

function TmodelsqlOrausuario.Sqlexcluir: String;
begin
  Result := SQL_EXCLUIR;
end;

function TmodelsqlOrausuario.Sqlproximocodigo: String;
begin
  Result := SQL_PROXIMO;
end;

function TmodelsqlOrausuario.Sqllistarpordescricao(Adescricao: String): String;
begin
  Result := Format(SQL_LISTA_DESCRICAO,[QuotedStr(Adescricao)]);
end;

function TmodelsqlOrausuario.Sqllistarporcodigo(Acodigo: Integer): String;
begin
  Result := Format(SQL_LISTA_CODIGO,[Acodigo]);
end;

function TmodelsqlOrausuario.Sqlgravarimagem: String;
begin
  Result := SQL_UPDATE_IMAGEM;
end;

function TmodelsqlOrausuario.Sqlgravarsenha: String;
begin
  Result := SQL_UPDATE_SENHA;
end;

function TmodelsqlOrausuario.Sqllistarcombobox: String;
begin
  Result := SQL_COMBO_BOX;
end;

end.



