unit cobcons.model.sql.orafasejuridica;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlOraFaseJuridica }

  TModelSQlOraFaseJuridica = class (TInterfacedObject, iModelSqlFaseJuridica)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlFaseJuridica;

      function SqlRetornaFasesCota(pGrupo, pSeq, pCota: String): String;
      function SqlRetornaUmaFaseCota(pGrupo, pSeq, pCota, pFase: String): String;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlOraFaseJuridica }

const
  SQL_FASES_COTA =
    'select J.GRUPO, J.SEQ, J.COTA, C.NOME, J.F_JURID, T.DESCRIC DCFASE, J.D_INICIO, '+
            'R.NOME NMREPRES, J.CUST_MOE, J.OBSERV '+
    'from A2JUD j '+
    'left outer join ACREP R on R.REPRES = J.REPRES '+
    'left outer join ACTAB T on T.TABELA = ''012'' and T.CODIGO = J.F_JURID '+
    'inner join A2CLI C on C.GRUPO = J.GRUPO and C.SEQ = J.SEQ and C.COTA = J.COTA '+
    'where J.GRUPO = %s and J.SEQ = %s and J.COTA = %s '+
    'order by J.D_INICIO ';

  SQL_UMA_FASE_COTA =
    'select J.GRUPO, J.SEQ, J.COTA, C.NOME, J.F_JURID, T.DESCRIC DCFASE, J.D_INICIO, '+
            'R.NOME NMREPRES, J.CUST_MOE, J.OBSERV '+
    'from ACJUD j '+
    'left outer join ACREP R on R.REPRES = J.REPRES '+
    'left outer join ACTAB T on T.TABELA = ''012'' and T.CODIGO = J.F_JURID '+
    'inner join A2CLI C on C.GRUPO = J.GRUPO and C.SEQ = J.SEQ and C.COTA = J.COTA '+
    'where J.GRUPO = %s and J.SEQ = %s and J.COTA = %s and J.F_JURID = %s';

constructor TmodelsqlOrafasejuridica.Create;
begin

end;

destructor TmodelsqlOrafasejuridica.Destroy;
begin
  inherited Destroy;
end;

class function TmodelsqlOrafasejuridica.New: Imodelsqlfasejuridica;
begin
  Result := Self.Create;
end;

function TmodelsqlOrafasejuridica.SqlRetornafasescota(Pgrupo, Pseq, Pcota: String): String;
begin
  Result := Format(SQL_FASES_COTA, [ QuotedStr(Pgrupo),
                                       QuotedStr(Pseq),
                                       QuotedStr(Pcota)]);
end;

function TmodelsqlOrafasejuridica.SqlRetornaumafasecota(Pgrupo, Pseq, Pcota, Pfase: String): String;
begin
  Result := Format(SQL_UMA_FASE_COTA, [ QuotedStr(Pgrupo),
                                          QuotedStr(Pseq),
                                          QuotedStr(Pcota),
                                          QuotedStr(Pfase)]);
end;


end.

