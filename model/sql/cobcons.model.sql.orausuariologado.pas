unit cobcons.model.sql.orausuariologado;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlOraUsuarioLogado }

  TModelSQlOraUsuarioLogado = class (TInterfacedObject, iModelSqlUsuarioLogado)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlUsuarioLogado;

      function SqlLogin: string;
      function SqlAtualizar: string;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlOraUsuarioLogado }
const
  SQL_LOGIN = 'select U.* from CJCBUSU U '+
              'where U.NM_USU = %s';
  SQL_ATUALIZAR = 'select U.* from CJCBUSU U '+
                  'where U.CD_USU = %d';

constructor Tmodelsqlorausuariologado.Create;
begin

end;

destructor Tmodelsqlorausuariologado.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqlorausuariologado.New: Imodelsqlusuariologado;
begin
  Result := Self.Create;
end;

function Tmodelsqlorausuariologado.Sqllogin: String;
begin
  Result := SQL_LOGIN;
end;

function Tmodelsqlorausuariologado.Sqlatualizar: String;
begin
  Result := SQL_ATUALIZAR;
end;

end.

