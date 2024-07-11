unit cobcons.model.sql.fbrnp;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlFbRnp }

  TModelSQlFbRnp = class (TInterfacedObject, iModelSqlRnp)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlRnp;

      function SqlCriarTabelaCheck: string;
      function SqlTabelaCheckExiste: string;
      function SqlCriarTabela: string;
      function SqlCriarTabelaSaldo: string;
      function SqlTabelaExiste: string;
      function SqlTabelaSaldoExiste: string;
      function SqlNovo: String;
      function SqlNovoSaldo: String;
      function SqlNovoCheck: String;
      function SqlAtualizarSaldoSiacon: String;
      function SqlAlterar: String;
      function SqlRetornaRnp: String;
      function SqlRetornaSaldoInicialRnp: String;
      function SqlRetornaSaldoRnp31Dez21: String;
      function SqlRetornaRecomposicaoSaldosTodos: String;
      function SqlRetornaRecomposicaoSaldosGrupo: String;
      function SqlRetornaTotalRecomposicao: String;
      function SqlRetornaSomenteRnp: String;
      function SqlRetornaComissaoPermanencia(pDataCalculo: TDateTime): String;
      function SqlRetornaRnpRateioFuturos: String;
      function SqlRetornaUmRnp(pGrupo, pSeq, pCota: String): String;
      function SqlRetornaUmCheck(pGrupo, pSeq, pCota: String): String;
      function SqlRetornaCheck: String;
      function SqlRetornaRnpGrupo(pGrupo: string): String;
      function SqlApagarDados: string;
      function SqlApagarCheck: string;
      function SqlGravaRateioFuturo: string;
      function SqlGravaSaldoRnp: string;
      function SqlGravaCheckRel: string;
      function SqlGravaCheckPla: string;
      function SqlRnpSag: String;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlFbRnp }

const
  SQL_TABELA_EXISTE =
    'select count(*) QTDE from RDB$RELATIONS '+
    'where RDB$FLAGS = 1 and  RDB$RELATION_NAME = ''RECNP'' ';
  SQL_TABELA_SALDO_EXISTE =
    'select count(*) QTDE from RDB$RELATIONS '+
    'where RDB$FLAGS = 1 and  RDB$RELATION_NAME = ''RECNPSLD'' ';
  SQL_TABELA_CHECK_EXISTE =
    'select count(*) QTDE from USER_TABLES '+
    'where RDB$FLAGS = 1 and  RDB$RELATION_NAME = ''CHECKRNP'' ';
  SQL_APAGAR_DADOS = 'delete from RECNP';
  SQL_APAGAR_CHECK = 'delete from CHECKRNP';
  SQL_CRIAR =
    'create table RECNP ( '+
       'GRUPO varchar(5) not null, '+
       'SEQ varchar(2) not null, '+
       'COTA varchar(3) not null, '+
       'PERCAMORT float default 0, '+
       'VLRRNP float default 0, '+
       'VLRBEM float default 0, '+
       'RATFUT float default 0, '+
       'PCRATEIO float default 0, '+
       'primary key (GRUPO, SEQ, COTA) ) ';
  SQL_CRIAR_SALDO =
    'create table RECNPSLD ( '+
       'GRUPO varchar(5) not null, '+
       'SEQ varchar(2) not null, '+
       'COTA varchar(3) not null, '+
       'VLRRNP float default 0, '+
       'VLSIACON float, '+
       'primary key (GRUPO, SEQ, COTA) ) ';
  SQL_CRIAR_CHECK =
    'create table CHECKRNP ( '+
       'GRUPO varchar(5) not null, '+
       'SEQ varchar(2) not null, '+
       'COTA varchar(3) not null, '+
       'REL integer default 0, '+
       'PLA integer default 0, '+
       'Sld23Abr13Rel float default  0, '+
       'Sld23Abr13Pla float default  0,  '+
       'Sld26Set16Rel float default  0, '+
       'Sld26Set16Pla float default  0, '+
       'primary key (GRUPO, SEQ, COTA) ) ';
  SQL_NOVO_SALDO =
    'insert into RECNPSLD (GRUPO, SEQ, COTA, VLRRNP) values ( %s, %s, %s, %f )';
  SQL_SALDO_INICIAL_RNP =
    'select VLRRNP from RECNPSLD where GRUPO = %s and SEQ = %s and COTA = %s';
  SQL_ATUALIZAR_SALDO_SIACON =
    'update RECNPSLD set VLSIACON = %f where GRUPO = %s and SEQ = %s and COTA = %s';
  SQL_SALDOS_RNP_BASE =
    'select S.GRUPO, S.SEQ, S.COTA, C.NOME, nvl(S.VLRRNP,0) VLRRNP, nvl(S.VLSIACON,0) VLSIACON , '+
           'nvl(S.VLRRNP,0)-nvl(S.VLSIACON,0) DIFSAL from RECNPSLD S '+
    'inner join A2CLI C on C.GRUPO = S.GRUPO and C.SEQ = S.SEQ and C.COTA = S.COTA ';
  SQL_SALDOS_RNP_TODOS = SQL_SALDOS_RNP_BASE + 'order by S.GRUPO, S.SEQ, S.COTA';
  SQL_SALDOS_RNP_GRUPO = SQL_SALDOS_RNP_BASE +
       'where S.GRUPO = %s order by S.GRUPO, S.SEQ, S.COTA';
  SQL_GRUPOS_RECOMPOSICAO =
       'select GRUPO, count(*) QTDCOT, sum(VLRRNP) RECGRU, sum(VLSIACON) SIAGRU, '+
              'sum(nvl(VLRRNP,0) - nvl(VLSIACON,0)) DIFER from RECNPSLD '+
       'group by GRUPO order by GRUPO';
  SQL_NOVO =
    'insert into RECNP (GRUPO, SEQ, COTA, PERCAMORT, VLRRNP, VLRBEM, RATFUT, PCRATEIO) '+
               'values ( %s, %s, %s, %.5f, %f, %f, %f, %.6f )';
  SQL_NOVO_CHECK =
  'insert into CHECKRNP (GRUPO, SEQ, COTA, REL, PLA, Sld23Abr13Rel, Sld23Abr13Pla, Sld26Set16Rel, Sld26Set16Pla) '+
  'values ( %s, %s, %s, %d, %d, %f, %f %f, %f )';
  SQL_ALTERAR =
    'update RECNP set PERCAMORT = %.5f, VLRRNP = %f, VLRBEM = %f, RATFUT = %f, PCRATEIO = %.6f '+
    'where GRUPO = %s and SEQ = %s and COTA = %s';
  SQL_ALTERAR_CHECK_REL =
    'update CHECKRNP set REL = %d, Sld23Abr13Rel = %f, Sld26Set16Rel = %f '+
    'where GRUPO = %s and SEQ = %s and COTA = %s';
  SQL_ALTERAR_CHECK_PLA =
    'update CHECKRNP set PLA = %d, Sld23Abr13Pla = %f, Sld26Set16Pla = %f '+
    'where GRUPO = %s and SEQ = %s and COTA = %s';
  SQL_LISTA_CHECK =
    'select R.GRUPO, R.SEQ, R.COTA, C.NOME, R.PLA, R.REL, '+
           'R.Sld23Abr13Rel, R.Sld23Abr13Pla, R.Sld26Set16Rel, r,Sld26Set16Pla from CHECKRNP R '+
    'inner join A2CLI C on C.GRUPO = R.GRUPO and C.SEQ = R.SEQ and C.COTA = R.COTA ';
  SQL_LISTA_SAG =
    'select R.GRUPO, R.SEQ, R.COTA, C.NOME, C.PESS_F_J, '+
           'case C.PESS_F_J '+
             'when ''F'' then substr(C.CGC_CPF, 2, 9) ||'+
                             'substr(C.CGC_CPF,  15,  2) '+
             'when ''J'' then substr(C.CGC_CPF,  3,  14) '+
           'end as CGCCPFMT, '+
           'G.DTENCCT, G.REGAPLIC, R.PERCAMORT, R.VLRBEM, '+
           'R.VLRRNP, R.RATFUT, R.PCRATEIO, G.MULRESGRU, '+
           'G.MULRESADM, G.TXPER, G.DTULTASS '+
    'from RECNP R '+
    'inner join A2CLI C on C.GRUPO = R.GRUPO and C.SEQ = R.SEQ and C.COTA = R.COTA '+
    'inner join TTGRU G on G.GRUPO = R.GRUPO ';
  SQL_LISTA =
    'select R.GRUPO, R.SEQ, R.COTA, C.NOME, C.SIT_COBR, R.PERCAMORT, R.VLRBEM, '+
           'R.VLRRNP, R.RATFUT, R.PCRATEIO, G.PRIM_REU, C.TELEFONE,'+
           'Case C.PESS_F_J '+
           'When ''F'' then substr(C.CGC_CPF , 2 , 9) || '+
                           'substr(C.CGC_CPF , 15 , 2) '+
           'When ''J'' then substr(C.CGC_CPF , 3 , 14) '+
           'end as CGCCPFMT, substr(C.INF_ADIC,60,20) CELULAR,'+
           'Case '+
             'When G.PRIM_REU <= ''29-JUN-1992'' then ''0190'' '+
             'When G.PRIM_REU <= ''02-AUG-1997'' then ''2196'' '+
             'When G.PRIM_REU <= ''05-FEB-2009'' then ''2766'' else ''3432'' '+
             'end as REGAPLIC '+
    'from RECNP R '+
    'inner join ACCLI C on C.GRUPO = R.GRUPO and C.SEQ = R.SEQ and C.COTA = R.COTA '+
    'inner join ACGRU G on G.GRUPO = R.GRUPO ';
  SQL_RETORNA_RNP = SQL_LISTA + 'order by R.GRUPO, R.SEQ, R.COTA';
  SQL_LISTA_COTAS_RNP = SQL_LISTA +'where R.VLRRNP > 0 order by R.GRUPO, R.SEQ, R.COTA';
  SQL_LISTA_COTAS_RNP_SAG = SQL_LISTA_SAG +'where R.VLRRNP > 0 order by R.GRUPO, R.SEQ, R.COTA';
  SQL_LISTA_COTAS_RATEIOFUTURO = SQL_LISTA +'where R.RATFUT > 0 order by R.GRUPO, R.SEQ, R.COTA';
  SQL_RETORNA_RNP_GRUPO = SQL_LISTA +
    'where R.GRUPO = %s order by R.GRUPO, R.SEQ, R.COTA';
  SQL_RETORNA_UM_RNP = SQL_LISTA +
    'where R.GRUPO = %s and R.SEQ = %s and R.COTA = %s';
  SQL_RETORNA_UM_CHECK = SQL_LISTA_CHECK +
    'where R.GRUPO = %s and R.SEQ = %s and R.COTA = %s';
  SQL_RETORNA_CHECK = SQL_LISTA_CHECK +'order by R.GRUPO, R.COTA, R.SEQ ';
  SQL_GRAVA_RATEIO_FUTURO =
    'update RECNP set RATFUT = %f, PCRATEIO = %.6f '+
    'where GRUPO = %s and SEQ = %s and COTA = %s';
  SQL_GRAVA_SALDO_RNP =
    'update RECNP set VLRRNP = %f '+
    'where GRUPO = %s and SEQ = %s and COTA = %s';
  SQL_COMISSAO_PERMANENCIA =
    'select R.GRUPO, R.SEQ, R.COTA, C.NOME, T.ADM_PERM, T.VAL_MIN from RECNP R '+
    'inner join ACCLI C on C.GRUPO = R.GRUPO and C.SEQ = R.SEQ and C.COTA = R.COTA '+
    'inner join ACTCP T on T.GRUPO = R.GRUPO '+
    'where R.VLRRNP > 0 and T.ADM_PERM > 0 and T.DT_ULT_COB < %s '+
    'order by R.GRUPO, R.SEQ, R.COTA ';
  SQL_SALDO_RNP31DEC21 =
    'select OUTROS from ACMOV2 '+
    'where TIPO_MOV = ''3B'' and D_CONTAB = ''31-dec-2021''  '+
      'and GRUPO = %s and SEQ = %s and COTA = %s ';

constructor TModelSQlFbRnp.Create;
begin

end;

destructor TModelSQlFbRnp.Destroy;
begin
  inherited Destroy;
end;

class function TModelSQlFbRnp.New: iModelSqlRnp;
begin
  Result := Self.Create;
end;

function TModelSQlFbRnp.SqlCriarTabelaCheck: string;
begin
  Result := SQL_CRIAR_CHECK;
end;

function TModelSQlFbRnp.SqlTabelaCheckExiste: string;
begin
  Result := SQL_TABELA_CHECK_EXISTE;
end;

function TModelSQlFbRnp.SqlCriarTabela: string;
begin
  Result := SQL_CRIAR;
end;

function TModelSQlFbRnp.SqlCriarTabelaSaldo: string;
begin
  Result := SQL_CRIAR_SALDO;
end;

function TModelSQlFbRnp.SqlTabelaExiste: string;
begin
  Result := SQL_TABELA_EXISTE;
end;

function TModelSQlFbRnp.SqlTabelaSaldoExiste: string;
begin
  Result := SQL_TABELA_SALDO_EXISTE;
end;

function TModelSQlFbRnp.SqlNovo: String;
begin
  Result := SQL_NOVO;
end;

function TModelSQlFbRnp.SqlNovoSaldo: String;
begin
  Result := SQL_NOVO_SALDO;
end;

function TModelSQlFbRnp.SqlNovoCheck: String;
begin
  Result := SQL_NOVO_CHECK;
end;

function TModelSQlFbRnp.SqlAtualizarSaldoSiacon: String;
begin
  Result := SQL_ATUALIZAR_SALDO_SIACON;
end;

function TModelSQlFbRnp.SqlAlterar: String;
begin
  Result := SQL_ALTERAR;
end;

function TModelSQlFbRnp.SqlRetornaRnp: String;
begin
  Result := SQL_RETORNA_RNP;
end;

function TModelSQlFbRnp.SqlRetornaSaldoInicialRnp: String;
begin
  Result := SQL_SALDO_INICIAL_RNP;
end;

function TModelSQlFbRnp.SqlRetornaSaldoRnp31Dez21: String;
begin
  Result := SQL_SALDO_RNP31DEC21;
end;

function TModelSQlFbRnp.SqlRetornaRecomposicaoSaldosTodos: String;
begin
  Result := SQL_SALDOS_RNP_TODOS;
end;

function TModelSQlFbRnp.SqlRetornaRecomposicaoSaldosGrupo: String;
begin
  Result := SQL_SALDOS_RNP_GRUPO;
end;

function TModelSQlFbRnp.SqlRetornaTotalRecomposicao: String;
begin
  Result := SQL_GRUPOS_RECOMPOSICAO;
end;

function TModelSQlFbRnp.SqlRetornaSomenteRnp: String;
begin
  Result := SQL_LISTA_COTAS_RNP;
end;

function TModelSQlFbRnp.SqlRetornaComissaoPermanencia(pDataCalculo: TDateTime
  ): String;
begin
  Result := Format(SQL_COMISSAO_PERMANENCIA, [QuotedStr(RetornaDataSql(Pdatacalculo))]);
end;

function TModelSQlFbRnp.SqlRetornaRnpRateioFuturos: String;
begin
  Result := SQL_LISTA_COTAS_RATEIOFUTURO;
end;

function TModelSQlFbRnp.SqlRetornaUmRnp(pGrupo, pSeq, pCota: String): String;
begin
  Result := Format(SQL_RETORNA_UM_RNP, [ QuotedStr(Pgrupo),
                                         QuotedStr(Pseq),
                                         QuotedStr(Pcota)]);
end;

function TModelSQlFbRnp.SqlRetornaUmCheck(pGrupo, pSeq, pCota: String): String;
begin
  Result := Format(SQL_RETORNA_UM_CHECK, [ QuotedStr(Pgrupo),
                                         QuotedStr(Pseq),
                                         QuotedStr(Pcota)]);
end;

function TModelSQlFbRnp.SqlRetornaCheck: String;
begin
  Result := SQL_RETORNA_CHECK;
end;

function TModelSQlFbRnp.SqlRetornaRnpGrupo(pGrupo: string): String;
begin
  Result := Format(SQL_RETORNA_RNP_GRUPO, [QuotedStr(Pgrupo)]);
end;

function TModelSQlFbRnp.SqlApagarDados: string;
begin
  Result := SQL_APAGAR_DADOS;
end;

function TModelSQlFbRnp.SqlApagarCheck: string;
begin
  Result := SQL_APAGAR_CHECK;
end;

function TModelSQlFbRnp.SqlGravaRateioFuturo: string;
begin
  Result := SQL_GRAVA_RATEIO_FUTURO;
end;

function TModelSQlFbRnp.SqlGravaSaldoRnp: string;
begin
  Result := SQL_GRAVA_SALDO_RNP;
end;

function TModelSQlFbRnp.SqlGravaCheckRel: string;
begin
  Result := SQL_ALTERAR_CHECK_REL;
end;

function TModelSQlFbRnp.SqlGravaCheckPla: string;
begin
  Result := SQL_ALTERAR_CHECK_PLA;
end;

function TModelSQlFbRnp.SqlRnpSag: String;
begin
  Result := SQL_LISTA_COTAS_RNP_SAG;
end;

end.

