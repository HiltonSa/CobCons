unit cobcons.model.sql.orapendencia;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlOraPendecia }

  TModelSQlOraPendecia = class (TInterfacedObject, iModelSqlPendencia)
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

{ TModelSQlOraPendecia }

const
  SQL_CAMPOS =
       'select C.AVISO, C.TIPO_MOV, T.SIGLA1 DCTIPOMOV, C.D_VENCTO, T.MUL_JUR, '+
              'CLI.FIL_COM, CLI.BEM, nvl(C.P_NORMAL , 0) + nvl(C.P_DIFER , 0) + '+
              'nvl(C.P_SUBST , 0) PCNOR, nvl(C.P_RATEIO , 0) P_RATEIO, '+
              '(nvl(C.F_AQUISI , 0) + nvl(C.F_RESERV , 0) + '+
              'nvl(C.OUTROS , 0) + nvl(C.ADMINIST , 0)) VALOR, '+
              'nvl(C.OUTROS , 0) OUTROS, nvl(C.F_AQUISI , 0) F_AQUISI, '+
              'nvl(C.F_RESERV , 0) F_RESERV, nvl(C.ADMINIST , 0) ADMINIST '+
       'from A2COB C '+
       'inner join ACTMV T on T.COD_MOV = C.TIPO_MOV '+
       'inner join A2CLI CLI on CLI.GRUPO = C.GRUPO and CLI.SEQ = C.SEQ and CLI.COTA = C.COTA ';
  SQL_PENDENCIA_COTA = SQL_CAMPOS +
       'where C.GRUPO = %s and C.SEQ = %s and C.COTA = %s '+
       'order by C.D_VENCTO DESC ';
  SQL_AVISO =
       'where C.GRUPO = %s and C.SEQ = %s and C.COTA = %s and C.AVISO = %s';

  SQL_INSERIR =
       'insert into A2COB ( GRUPO, SEQ, COTA, AVISO, TIPO_MOV, D_VENCTO, AG_COBRA, '+
                           'P_NORMAL, P_RATEIO, P_SUBST, P_DIFER, F_AQUISI, ADMINIST, '+
                           'F_RESERV, OUTROS, DT_BASE, P_ANTEC, SEG_OUT,  USUARIO, '+
                           'D_ATUALI, TP_ABONO, MUL_JUR,   COBRADOR, TAR_BANC, AV_ASSOC, '+
                           'FILLER, ADM_DESC) '+
                  'values ( %s, %s, %s, %s, %s, %s, %s, %f, %f, 0.0, 0.0, %f, %f, %f, %f, '+
                           '%s, 0.0, ''O'', ''0000'', %s, ''00'', 0.0, ''000000'', 0.0, '+
                           '''000000'',  '' '', 0.0)';
  SQL_EXCLUIR =
       'delete from A2COB where GRUPO = %s and SEQ = %s and COTA = %s and AVISO = %s';
  SQL_EXCLUIR_SQG =
       'delete from A2COB where GRUPO = %s and SEQ = %s and COTA = %s and TIPO_MOV in (''19'',''47'')';
  SQL_PROXIMO =
       'select max(to_number(AVISO)) + 1 as MCOD from A2COB '+
       'where GRUPO = %s and SEQ = %S and COTA = %s';

constructor TModelSQlOraPendecia.Create;
begin

end;

destructor TModelSQlOraPendecia.Destroy;
begin
  inherited Destroy;
end;

class function TModelSQlOraPendecia.New: iModelSqlPendencia;
begin
  Result := Self.Create;
end;

function TModelSQlOraPendecia.SqlRetornaPendenciaCota(pGrupo, pSeq,
  pCota: String): String;
begin
  Result := Format(SQL_PENDENCIA_COTA, [ QuotedStr(Pgrupo),
                                         QuotedStr(Pseq),
                                         QuotedStr(Pcota)]);
end;

function TModelSQlOraPendecia.SqlRetornaAviso(pGrupo, pSeq, pCota,
  pAviso: String): String;
begin
  Result :=  Format(SQL_AVISO, [ QuotedStr(Pgrupo),
                                 QuotedStr(Pseq),
                                 QuotedStr(Pcota),
                                 QuotedStr(Paviso)]);
end;

function TModelSQlOraPendecia.SqlNovo: String;
begin
  Result := SQL_INSERIR;
end;

function TModelSQlOraPendecia.SqlExcluir: String;
begin
  Result := SQL_EXCLUIR;
end;

function TModelSQlOraPendecia.SqlExcluirSQG: String;
begin
  Result := SQL_EXCLUIR_SQG;
end;

function TModelSQlOraPendecia.SqlProximoAviso: String;
begin
  Result := SQL_PROXIMO;
end;

end.

