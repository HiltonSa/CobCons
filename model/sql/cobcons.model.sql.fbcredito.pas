unit cobcons.model.sql.fbcredito;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlFbCredito }

  TModelSQlFbCredito = class (TInterfacedObject, iModelSqlCredito)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlCredito;

      function SqlRetornaCreditosCota(pGrupo, pCota: String): string;
      function SqlRetornaUmCreditoCota(pGrupo, pCota, pCredito: String): string;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlFbCredito }

const
  SQL_CREDITO =
    'select C.CREDITO, C.TP_CRED, T.DESCRIC DCTPCRE, C.DT_I_COR, C.LIM_CORR, '+
           'cast(C.VAL_CRED as float) VAL_CRED, cast(C.VAL_CORR as float) VAL_CORR, '+
           'cast(C.VAL_CRED as float) + cast(C.VAL_CORR as float) VLTOT, '+
           'C.FORNEC, F.NOME NMFORNEC, C.DT_N_FIS, C.NR_N_FIS, C.DT_PAGTO, '+
           'cast(C.VAL_ENTR as float) VAL_ENTR, cast(C.COR_ENTR as float) COR_ENTR, '+
           'cast(C.VAL_ENTR as float) + cast(C.COR_ENTR as float) VLPAGO, '+
           'C.OBSERV '+
   'from ACCEN C '+
   'inner join ACTAB T on T.TABELA = ''031'' and T.CODIGO = C.TP_CRED '+
   'left outer join ACFOR F on F.FORNEC = C.FORNEC ';

  SQL_CREDITOS_COTA = SQL_CREDITO +
   'where C.GRUPO = %s and C.COTA = %s order by C.CREDITO';

  SQL_UM_CREDITO = SQL_CREDITO +
   'where C.GRUPO = %s and C.COTA = %s and C.CREDITO = %s';

constructor Tmodelsqlfbcredito.Create;
begin

end;

destructor Tmodelsqlfbcredito.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqlfbcredito.New: Imodelsqlcredito;
begin
  Result := Self.Create;
end;

function Tmodelsqlfbcredito.Sqlretornacreditoscota(Pgrupo, Pcota: String): String;
begin
  Result := Format(SQL_CREDITOS_COTA, [ QuotedStr( Pgrupo), QuotedStr( Pcota ) ]);
end;

function Tmodelsqlfbcredito.Sqlretornaumcreditocota(Pgrupo, Pcota, Pcredito: String): String;
begin
  Result := Format(SQL_UM_CREDITO, [ QuotedStr( Pgrupo),
                                     QuotedStr( Pcota ),
                                     QuotedStr( Pcredito ) ]);
end;

end.



