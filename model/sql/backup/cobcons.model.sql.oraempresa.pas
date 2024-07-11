unit cobcons.model.sql.oraempresa;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSqlOraEmpresa }

  TModelSqlOraEmpresa = class (TInterfacedObject, iModelSqlEmpresa)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlEmpresa;

      function SqlRecuperarEmpresa: String;
      function SqlGravarFicha: String;
      function SqlGravarAutorizacao(aValue: String): String;
  end;

implementation

uses cobcons.controller.util;

{ TModelSqlOraEmpresa }

const
  SQL_RECUPERAR = 'select CD_PRS, NM_PRS, CD_CGC, PC_MUL, PC_JUR, PC_HONOR, '+
                         'ULTSAG, NMCONTATO, TELCONTATO, MAILCONTATO, STRLIB, '+
                         'STGRENCCT, FASEAJUIZ, DTRECSLDRNP, DTRCCMPER, PCREDAPL, '+
                         'DTLIMRED, VLLIMEXI '+
                  'from CJCBPRS where CD_PRS = 1 ';
  SQL_ATUALIZAR = 'update CJCBPRS set NM_PRS = %s, CD_CGC = %s, PC_MUL = %f, PC_JUR = %f, '+
                         'PC_HONOR = %f, ULTSAG = %s, NMCONTATO = %s, TELCONTATO = %s, '+
                         'MAILCONTATO = %s, STGRENCCT = %s, FASEAJUIZ = %s, DTRECSLDRNP = %s, '+
                         'DTRCCMPER = %s, PCREDAPL = %f, DTLIMRED = %s, VLLIMEXI = %f '+
                  'where CD_PRS = 1';
  SQL_STRLIB = 'update CJCBPRS set STRLIB = %s where CD_PRS = 1';

constructor TmodelsqlOraempresa.Create;
begin

end;

destructor TmodelsqlOraempresa.Destroy;
begin
  inherited Destroy;
end;

class function TmodelsqlOraempresa.New: Imodelsqlempresa;
begin
  Result := Self.Create;
end;

function TmodelsqlOraempresa.Sqlrecuperarempresa: String;
begin
  Result := SQL_RECUPERAR;
end;

function TmodelsqlOraempresa.Sqlgravarficha: String;
begin
  Result := SQL_ATUALIZAR;
end;

function TmodelsqlOraempresa.Sqlgravarautorizacao(Avalue: String): String;
begin
  Result := Format(SQL_STRLIB, [ Avalue ]);
end;

end.

