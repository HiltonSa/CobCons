unit cobcons.model.sql.fbusuariologado;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlFbUsuarioLogado }

  TModelSQlFbUsuarioLogado = class (TInterfacedObject, iModelSqlUsuarioLogado)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: Imodelsqlusuariologado;

      function SqlLogin: string;
      function SqlAtualizar: string;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlFbUsuarioLogado }
const
  SQL_LOGIN = 'select U.* from CJCBUSU U '+
              'where U.NM_USU = %s';
  SQL_ATUALIZAR = 'select U.* from CJCBUSU U '+
                  'where U.CD_USU = %d';

constructor Tmodelsqlfbusuariologado.Create;
begin

end;

destructor Tmodelsqlfbusuariologado.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqlfbusuariologado.New: iModelSqlUsuarioLogado;
begin
  Result := Self.Create;
end;

function Tmodelsqlfbusuariologado.Sqllogin: String;
begin
  Result := SQL_LOGIN;
end;

function Tmodelsqlfbusuariologado.Sqlatualizar: String;
begin
  Result := SQL_ATUALIZAR;
end;

end.

