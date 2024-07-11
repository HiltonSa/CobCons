unit cobcons.model.sql.oracredito;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlOraCredito }

  TModelSQlOraCredito = class (TInterfacedObject, iModelSqlCredito)
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

{ TModelSQlOraCredito }

const
  SQL_CREDITO =
    'select C.CREDITO, C.TP_CRED, T.DESCRIC DCTPCRE, C.DT_I_COR, C.LIM_CORR, '+
           'nvl(C.VAL_CRED , 0) VAL_CRED, nvl(C.VAL_CORR , 0) VAL_CORR, '+
           'nvl(C.VAL_CRED , 0) + nvl(C.VAL_CORR , 0) VLTOT, '+
           'C.FORNEC, F.NOME NMFORNEC, C.DT_N_FIS, C.NR_N_FIS, C.DT_PAGTO, '+
           'nvl(C.VAL_ENTR , 0) VAL_ENTR, nvl(C.COR_ENTR , 0) COR_ENTR, '+
           'nvl(C.VAL_ENTR , 0) + nvl(C.COR_ENTR , 0) VLPAGO, '+
           'C.OBSERV '+
   'from A2CEN C '+
   'inner join ACTAB T on T.TABELA = ''031'' and T.CODIGO = C.TP_CRED '+
   'left outer join ACFOR F on F.FORNEC = C.FORNEC ';

  SQL_CREDITOS_COTA = SQL_CREDITO +
   'where C.GRUPO = %s and C.COTA = %s order by C.CREDITO';

  SQL_UM_CREDITO = SQL_CREDITO +
   'where C.GRUPO = %s and C.COTA = %s and C.CREDITO = %s';

constructor TmodelsqlOracredito.Create;
begin

end;

destructor TmodelsqlOracredito.Destroy;
begin
  inherited Destroy;
end;

class function TmodelsqlOracredito.New: Imodelsqlcredito;
begin
  Result := Self.Create;
end;

function TmodelsqlOracredito.Sqlretornacreditoscota(Pgrupo, Pcota: String): String;
begin
  Result := Format(SQL_CREDITOS_COTA, [ QuotedStr( Pgrupo), QuotedStr( Pcota ) ]);
end;

function TmodelsqlOracredito.Sqlretornaumcreditocota(Pgrupo, Pcota, Pcredito: String): String;
begin
  Result := Format(SQL_UM_CREDITO, [ QuotedStr( Pgrupo),
                                     QuotedStr( Pcota ),
                                     QuotedStr( Pcredito ) ]);
end;

end.



