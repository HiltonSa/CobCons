unit cobcons.model.sql.orareuniao;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSqlOraReuniao }

  TModelSqlOraReuniao = class (TInterfacedObject, iModelSqlReuniao)
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

{ TModelSqlOraReuniao }

const
  SQL_REUNIAO_PAGAMENTO =
    'select NRO_REU, DATA_REU from A2REU '+
    'where GRUPO = %s and DATA_REU >= %s and rownum = 1 ';

  SQL_REUNIAO_GRUPO =
    'select  NRO_REU, DATA_REU from A2REU where GRUPO = %s order by NRO_REU';

constructor TmodelSqlOrareuniao.Create;
begin

end;

destructor TmodelSqlOrareuniao.Destroy;
begin
  inherited Destroy;
end;

class function TmodelSqlOrareuniao.New: Imodelsqlreuniao;
begin
  Result := Self.Create;
end;

function TmodelSqlOrareuniao.Sqlretornareuniaopagamento(Pgrupo: String; Pdtpag: Tdatetime): String;
begin
  Result := Format(SQL_REUNIAO_PAGAMENTO, [ QuotedStr( Pgrupo),
                                            QuotedStr( RetornaDataSql(Pdtpag))]);
end;

function TmodelSqlOrareuniao.Sqlretornareuniaogrupo(Pgrupo: String): String;
begin
  Result := Format(SQL_REUNIAO_GRUPO, [ QuotedStr( Pgrupo) ]);
end;

end.

