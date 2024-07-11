unit cobcons.model.sql.fbreuniao;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlFbReuniao }

  TModelSQlFbReuniao = class (TInterfacedObject, iModelSqlReuniao)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlReuniao;

      function SqlRetornaReuniaoPagamento(pGrupo: String; pDtPag: TDateTime): string;
      function SqlRetornaReuniaoGrupo(pGrupo: String): string;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlFbReuniao }

const
  SQL_REUNIAO_PAGAMENTO =
    'select first 1 NRO_REU, DATA_REU from ACREU '+
    'where GRUPO = %s and DATA_REU >= %s ';

  SQL_REUNIAO_GRUPO =
    'select  NRO_REU, DATA_REU from ACREU where GRUPO = %s order by NRO_REU';

constructor TmodelsqlFbreuniao.Create;
begin

end;

destructor TmodelsqlFbreuniao.Destroy;
begin
  inherited Destroy;
end;

class function TmodelsqlFbreuniao.New: Imodelsqlreuniao;
begin
  Result := Self.Create;
end;

function TmodelsqlFbreuniao.Sqlretornareuniaopagamento(Pgrupo: String; Pdtpag: Tdatetime): String;
begin
  Result := Format(SQL_REUNIAO_PAGAMENTO, [ QuotedStr( Pgrupo),
                                            QuotedStr( RetornaDataSql(Pdtpag))]);
end;

function TmodelsqlFbreuniao.Sqlretornareuniaogrupo(Pgrupo: String): String;
begin
  Result := Format(SQL_REUNIAO_GRUPO, [ QuotedStr( Pgrupo) ]);
end;

end.

