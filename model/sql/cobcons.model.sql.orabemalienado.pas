unit cobcons.model.sql.orabemalienado;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlOraBemAlienado }

  TModelSQlOraBemAlienado = class (TInterfacedObject, iModelSqlBemAlienado)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlBemAlienado;

      function SqlRetornaBensAlienadosCota(pGrupo, pCota: String): string;
      function SqlRetornaBemAlienado(pGrupo, pCota, pChassis: String): string;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlOraBemAlienado }

const
  SQL_BENS_ALIENADOS =
    'select A.SIT_ALIE, A.DT_ALIE, A.DT_SUBST, A.DT_DESAL, A.FABRICAN, A.LIN_MOD, '+
           'A.DESCRIC, A.ANO_FABR, A.NR_CHASS, A.NR_RENAV, A.PLACA, A.OBSERVAC, '+
           'A.COR, FAB.DESCRIC DCFABBEM, '+
           'case A.SIT_ALIE '+
             'when ''A'' then ''Alienado'' '+
             'when ''D'' then ''Desalienado'' '+
             'when ''S'' then ''Substituido'' '+
           'end as DCSITALI '+
    'from A2CAL A '+
    'left outer join ACTAB FAB on FAB.TABELA = ''002'' and FAB.CODIGO = A.FABRICAN ';

  SQL_TODOS_COTA = SQL_BENS_ALIENADOS +
    'where A.GRUPO = %s and A.COTA = %s order by A.SIT_ALIE';

  SQL_UM_BEM_ALIENADO = SQL_BENS_ALIENADOS +
   'where A.GRUPO = %s and A.COTA = %s and A.NR_CHASS = %s';

constructor TmodelsqlOrabemalienado.Create;
begin

end;

destructor TmodelsqlOrabemalienado.Destroy;
begin
  inherited Destroy;
end;

class function TmodelsqlOrabemalienado.New: Imodelsqlbemalienado;
begin
  Result := Self.Create;
end;

function TmodelsqlOrabemalienado.SqlRetornabensalienadoscota(Pgrupo, Pcota: String): string;
begin
  Result := Format(SQL_TODOS_COTA, [ QuotedStr( Pgrupo), QuotedStr( Pcota ) ]);
end;

function TmodelsqlOrabemalienado.SqlRetornabemalienado(Pgrupo, Pcota, Pchassis: String): String;
begin
  Result := Format(SQL_UM_BEM_ALIENADO, [ QuotedStr( Pgrupo),
                                          QuotedStr( Pcota ),
                                          QuotedStr( Pchassis ) ]);
end;

end.


