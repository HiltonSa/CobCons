unit cobcons.model.sql.fbagenda;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlFbAgenda }

  TModelSQlFbAgenda = class (TInterfacedObject, iModelSqlAgenda)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlAgenda;

      function SQLRetornaAgendaUsuarioPeriodo(pUsuario: Integer; pInicio, pFim: TDateTime): String;
      function SQLAlterarPrioridade(pCodigo, pPrioridade: Integer): String;
      function SQLAlterarStatus(pCodigo, pStatus: Integer): String;
      function SQLNovo: String;
      function SQLAlterar: String;
      function SQLExcluir: String;
      function SQLProximoCodigo: String;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlFbAgenda }

const
SQL_CAMPOS =
  'select A.CD_AGE, A.DT_AGE, A.PRIORIDADE, A.CD_CTRATO, A.STATUS, A.CD_USU, A.OBS, '+
         'A.GRUPO, A.SEQ, A.COTA, U.NM_USU NMUSUARIO, C.NOME NMCOTA, '+
         'case A.PRIORIDADE '+
           'when 0 then ''Alta'' '+
           'when 1 then ''Media'' '+
           'when 2 then ''Baixa'' '+
         'end as DCPRIORIDADE, '+
         'case A.STATUS '+
           'when 0 then ''Aberto'' '+
           'when 1 then ''Realizado'' '+
         'end as DCSTATUS '+
  'from CJCBAGE A '+
  'inner join CJCBUSU U on U.CD_USU = A.CD_USU '+
  'left outer join ACCLI C on C.GRUPO = A.GRUPO and C.SEQ = A.SEQ and C.COTA = A.COTA ';
SQL_USUARIO_PERIODO = SQL_CAMPOS +
  'where A.CD_USU = %d and A.DT_AGE between %s and %s '+
  'order by A.PRIORIDADE';
SQL_ATUALIZAR =
  'update CJCBAGE set DT_AGE = %s, PRIORIDADE = %d,  CD_USU = %d'+
  'where CD_AGE = %d';
SQL_INCLUIR =
  'insert into CJCBAGE '+
    '( CD_AGE, DT_AGE, PRIORIDADE, CD_CTRATO, STATUS, CD_USU, GRUPO, SEQ, COTA ) '+
    'values ( %d, %s, %d, %s, %d, %d, %s, %s, %s)';
SQL_PROXIMO = 'select max(CD_AGE) MCOD from CJCBAGE';
SQL_EXCLUIR = 'delete from CJCBAGE where CD_AGE = %d';
SQL_ALTERAR_PRIORIDADE =
  'update CJCBAGE set PRIORIDADE = %d where CD_AGE = %d';
SQL_ALTERAR_STATUS =
  'update CJCBAGE set STATUS = %d where CD_AGE = %d';


constructor Tmodelsqlfbagenda.Create;
begin

end;

destructor Tmodelsqlfbagenda.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqlfbagenda.New: Imodelsqlagenda;
begin
  Result := Self.Create;
end;

function Tmodelsqlfbagenda.Sqlretornaagendausuarioperiodo(Pusuario: Integer; Pinicio, Pfim: Tdatetime): String;
begin
  Result := Format( SQL_USUARIO_PERIODO, [ Pusuario,
                                           QuotedStr(RetornaDataSql(Pinicio)),
                                           QuotedStr(RetornaDataSql(Pfim))]);
end;

function Tmodelsqlfbagenda.Sqlalterarprioridade(Pcodigo, Pprioridade: Integer): String;
begin
  Result := Format(SQL_ALTERAR_PRIORIDADE, [Pprioridade, Pcodigo]);
end;

function Tmodelsqlfbagenda.Sqlalterarstatus(Pcodigo, Pstatus: Integer): String;
begin
  Result := Format(SQL_ALTERAR_STATUS, [Pstatus, Pcodigo]);
end;

function Tmodelsqlfbagenda.Sqlnovo: String;
begin
  Result := SQL_INCLUIR;
end;

function Tmodelsqlfbagenda.Sqlalterar: String;
begin
  Result := SQL_ATUALIZAR;
end;

function Tmodelsqlfbagenda.Sqlexcluir: String;
begin
  Result := SQL_EXCLUIR;
end;

function Tmodelsqlfbagenda.Sqlproximocodigo: String;
begin
  Result := SQL_PROXIMO;
end;


end.

