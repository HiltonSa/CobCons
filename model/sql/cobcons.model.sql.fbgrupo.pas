unit cobcons.model.sql.fbgrupo;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlFbGrupo }

  TModelSQlFbGrupo = class (TInterfacedObject, iModelSqlGrupo)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlGrupo;

      function SqlRetornaGrupo(pGrupo: string): String;
      function SqlRetornaListaGrupos: String;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlFbGrupo }

const
  SQL_CAMPOS =
     'select G.GRUPO, G.PLA_PADR, G.LIM_COTA, G.PRIM_REU, G.TP_GRUPO, '+
            'TP.DESCRIC DCTPGRUPO, G.SIT_GRU, ST.DESCRIC DCSITGRUPO, '+
            'G.DT_SITUA, R.DATA_REU ULT_REUNIAO, P.ADM_PERM, P.VAL_MINIMO, '+
            'P.DT_INI_COB ' +
     'from ACGRU G '+
     'left outer join ACTAB TP on TP.TABELA = ''034'' and TP.CODIGO = G.TP_GRUPO '+
     'left outer join ACTAB ST on ST.TABELA = ''024'' and ST.CODIGO = G.SIT_GRU '+
     'left outer join ACREU R on R.GRUPO = G.GRUPO and R.NRO_REU = G.PLA_PADR ' +
     'left outer join ACTCP P on P.GRUPO = G.GRUPO ';
  SQL_GRUPO = SQL_CAMPOS + 'where G.GRUPO = %s';
  SQL_LISTA = SQL_CAMPOS + 'order by G.GRUPO';

constructor Tmodelsqlfbgrupo.Create;
begin

end;

destructor Tmodelsqlfbgrupo.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqlfbgrupo.New: Imodelsqlgrupo;
begin
  Result := Self.Create;
end;

function Tmodelsqlfbgrupo.Sqlretornagrupo(Pgrupo: String): String;
begin
  Result := Format(SQL_GRUPO, [QuotedStr(Pgrupo)]);
end;

function Tmodelsqlfbgrupo.Sqlretornalistagrupos: String;
begin
  Result := SQL_LISTA;
end;

end.



