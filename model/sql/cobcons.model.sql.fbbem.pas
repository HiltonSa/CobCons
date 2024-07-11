unit cobcons.model.sql.fbbem;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlFbBem }

  TModelSQlFbBem = class (TInterfacedObject, iModelSqlBem)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlBem;

      function SQLRetornaBem(pBem: string): String;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlFbBem }

const
SQL_BEM =
  'select B.*, TB.DESCRIC DCTIPOBEM, FAB.DESCRIC DCFABBEM from ACBEM B '+
  'left outer join ACTAB TB  on TB.TABELA  = ''001'' and TB.CODIGO  = B.TIPO_BEM '+
  'left outer join ACTAB FAB on FAB.TABELA = ''002'' and FAB.CODIGO = B.FABRICAN '+
  'where B.BEM = %s';


constructor TmodelsqlFbbem.Create;
begin

end;

destructor TmodelsqlFbbem.Destroy;
begin
  inherited Destroy;
end;

class function TmodelsqlFbbem.New: Imodelsqlbem;
begin
  Result := Self.Create;
end;

function TmodelsqlFbbem.Sqlretornabem(Pbem: String): String;
begin
  Result := Format(SQL_BEM, [QuotedStr(Pbem)]);
end;

end.
