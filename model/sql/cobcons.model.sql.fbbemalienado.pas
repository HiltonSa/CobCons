unit cobcons.model.sql.fbbemalienado;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlFbBemAlienado }

  TModelSQlFbBemAlienado = class (TInterfacedObject, iModelSqlBemAlienado)
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

{ TModelSQlFbBemAlienado }

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
    'from ACCAL A '+
    'left outer join ACTAB FAB on FAB.TABELA = ''002'' and FAB.CODIGO = A.FABRICAN ';

  SQL_TODOS_COTA = SQL_BENS_ALIENADOS +
    'where A.GRUPO = %s and A.COTA = %s order by A.SIT_ALIE';

  SQL_UM_BEM_ALIENADO = SQL_BENS_ALIENADOS +
   'where A.GRUPO = %s and A.COTA = %s and A.NR_CHASS = %s';

constructor Tmodelsqlfbbemalienado.Create;
begin

end;

destructor Tmodelsqlfbbemalienado.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqlfbbemalienado.New: Imodelsqlbemalienado;
begin
  Result := Self.Create;
end;

function Tmodelsqlfbbemalienado.SqlRetornabensalienadoscota(Pgrupo, Pcota: String): string;
begin
  Result := Format(SQL_TODOS_COTA, [ QuotedStr( Pgrupo), QuotedStr( Pcota ) ]);
end;

function Tmodelsqlfbbemalienado.SqlRetornabemalienado(Pgrupo, Pcota, Pchassis: String): string;
begin
  Result := Format(SQL_UM_BEM_ALIENADO, [ QuotedStr( Pgrupo),
                                          QuotedStr( Pcota ),
                                          QuotedStr( Pchassis ) ]);
end;

end.


