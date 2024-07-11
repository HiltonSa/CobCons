unit cobcons.model.sql.oraprecobem;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlOraPrecoBem }

  TModelSQlOraPrecoBem = class (TInterfacedObject, iModelSqlPrecoBem)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlPrecoBem;

      function SqlRetornaPrecoBemData(pBem, pFilial: String; pData: TDateTime): string;
      function SqlRetornaPrecoBem(pBem, pFilial: String): string;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlOraPrecoBem }

const
  SQL_PRECO_DATA =
    'select P.DT_BASE, T.SIMBOLO, P.PRE_TABE, T.FATOR, '+
           '(P.PRE_TABE / T.FATOR) PRE_REAL from ACPRE P '+
    'left outer join ACTMO T on T.DTINI <= P.DT_BASE and T.DTFIM >= P.DT_BASE '+
    'where P.TP_PRECO = ''R'' and P.BEM = %s and P.FILIAL = %s and P.DT_BASE <= %s '+
           'and rownum = 1 '+
    'order by P.DT_BASE desc';
  SQL_PRECOS_BEM =
    'select P.DT_BASE, T.SIMBOLO, P.PRE_TABE, T.FATOR, '+
           '(P.PRE_TABE / T.FATOR) PRE_REAL from ACPRE P '+
    'left outer join ACTMO T on T.DTINI <= P.DT_BASE and T.DTFIM >= P.DT_BASE '+
    'where P.TP_PRECO = ''R'' and P.BEM = %s and P.FILIAL = %s '+
    'order by P.DT_BASE desc';

constructor TmodelsqlOraprecobem.Create;
begin

end;

destructor TmodelsqlOraprecobem.Destroy;
begin
  inherited Destroy;
end;

class function TmodelsqlOraprecobem.New: Imodelsqlprecobem;
begin
  Result := Self.Create;
end;

function TmodelsqlOraprecobem.Sqlretornaprecobemdata(Pbem, Pfilial: String; Pdata: Tdatetime): String;
begin
  Result := Format(SQL_PRECO_DATA, [ QuotedStr( Pbem),
                                     QuotedStr( Pfilial ),
                                     QuotedStr( RetornaDataSql(Pdata))]);
end;

function TmodelsqlOraprecobem.Sqlretornaprecobem(Pbem, Pfilial: String): String;
begin
  Result := Format(SQL_PRECOS_BEM, [ QuotedStr( Pbem),
                                     QuotedStr(Pfilial)]);
end;

end.

