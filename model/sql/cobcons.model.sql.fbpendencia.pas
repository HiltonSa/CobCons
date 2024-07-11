unit cobcons.model.sql.fbpendencia;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlFbPendecia }

  TModelSQlFbPendecia = class (TInterfacedObject, iModelSqlPendencia)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlPendencia;

      function SqlRetornaPendenciaCota(pGrupo, pSeq, pCota: String): String;
      function SqlRetornaAviso(pGrupo, pSeq, pCota, pAviso: String): String;
      function SqlNovo: String;
      function SqlExcluir: String;
      function SqlExcluirSQG: String;
      function SqlProximoAviso: String;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlFbPendecia }

const
  SQL_CAMPOS =
       'select C.AVISO, C.TIPO_MOV, T.SIGLA1 DCTIPOMOV, C.D_VENCTO, T.MUL_JUR, '+
              'CLI.FIL_COM, CLI.BEM, cast(C.P_NORMAL as float) + cast(C.P_DIFER as float) + '+
              'cast(C.P_SUBST as float) PCNOR, cast(C.P_RATEIO as float) P_RATEIO, '+
              '(cast(C.F_AQUISI as float) + cast(C.F_RESERV as float) + '+
              'cast(C.OUTROS as float) + cast(C.ADMINIST as float)) VALOR, '+
              'cast(C.OUTROS as float) OUTROS, cast(C.F_AQUISI as float) F_AQUISI, '+
              'cast(C.F_RESERV as float) F_RESERV, cast(C.ADMINIST as float) ADMINIST '+
       'from ACCOB C '+
       'inner join ACTMV T on T.COD_MOV = C.TIPO_MOV '+
       'inner join ACCLI CLI on CLI.GRUPO = C.GRUPO and CLI.SEQ = C.SEQ and CLI.COTA = C.COTA ';
  SQL_PENDENCIA_COTA = SQL_CAMPOS +
       'where C.GRUPO = %s and C.SEQ = %s and C.COTA = %s '+
       'order by C.D_VENCTO DESC ';
  SQL_AVISO =
       'where C.GRUPO = %s and C.SEQ = %s and C.COTA = %s and C.AVISO = %s';

  SQL_INSERIR =
       'insert into ACCOB ( GRUPO, SEQ, COTA, AVISO, TIPO_MOV, D_VENCTO, AG_COBRA, '+
                           'P_NORMAL, P_RATEIO, P_SUBST, P_DIFER, F_AQUISI, ADMINIST, '+
                           'F_RESERV, OUTROS, DT_BASE, P_ANTEC, SEG_OUT,  USUARIO, '+
                           'D_ATUALI, TP_ABONO, MUL_JUR,   COBRADOR, TAR_BANC, AV_ASSOC, '+
                           'FILLER, ADM_DESC) '+
                  'values ( %s, %s, %s, %s, %s, %s, %s, %f, %f, 0.0, 0.0, %f, %f, %f, %f, '+
                           '%s, 0.0, ''O'', ''0000'', %s, ''00'', 0.0, ''000000'', 0.0, '+
                           '''000000'',  '' '', 0.0)';
  SQL_EXCLUIR =
       'delete from ACCOB where GRUPO = %s and SEQ = %s and COTA = %s and AVISO = %s';
  SQL_EXCLUIR_SQG =
       'delete from A2COB where GRUPO = %s and SEQ = %s and COTA = %s and TIPO_MOV in (''19'',''47'')';
  SQL_PROXIMO =
       'select max(cast(AVISO as integer)) + 1 as MCOD from ACCOB '+
       'where GRUPO = %s and SEQ = %S and COTA = %s';

constructor TModelSQlFbPendecia.Create;
begin

end;

destructor TModelSQlFbPendecia.Destroy;
begin
  inherited Destroy;
end;

class function TModelSQlFbPendecia.New: iModelSqlPendencia;
begin
  Result := Self.Create;
end;

function TModelSQlFbPendecia.SqlRetornaPendenciaCota(pGrupo, pSeq, pCota: String
  ): String;
begin
  Result := Format(SQL_PENDENCIA_COTA, [ QuotedStr(Pgrupo),
                                         QuotedStr(Pseq),
                                         QuotedStr(Pcota)]);
end;

function TModelSQlFbPendecia.SqlRetornaAviso(pGrupo, pSeq, pCota, pAviso: String
  ): String;
begin
  Result :=  Format(SQL_AVISO, [ QuotedStr(Pgrupo),
                                 QuotedStr(Pseq),
                                 QuotedStr(Pcota),
                                 QuotedStr(Paviso)]);
end;

function TModelSQlFbPendecia.SqlNovo: String;
begin
  Result := SQL_INSERIR;
end;

function TModelSQlFbPendecia.SqlExcluir: String;
begin
  Result := SQL_EXCLUIR;
end;

function TModelSQlFbPendecia.SqlExcluirSQG: String;
begin
  Result := SQL_EXCLUIR_SQG;
end;

function TModelSQlFbPendecia.SqlProximoAviso: String;
begin
  Result := SQL_PROXIMO;
end;

end.

