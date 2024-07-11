unit cobcons.model.sql.orarnp;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlOraRnp }

  TModelSQlOraRnp = class (TInterfacedObject, iModelSqlRnp)
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
      function SqlAlterar: String;
      function SqlAtualizarSaldoSiacon: String;
      function SqlRetornaRnp: String;
      function SqlRetornaSaldoInicialRnp: String;
      function SqlRetornaSaldoRnp31Dez21: String;
      function SqlRetornaRecomposicaoSaldosTodos: String;
      function SqlRetornaRecomposicaoSaldosGrupo: String;
      function SqlRetornaTotalRecomposicao: String;
      function SqlRetornaComissaoPermanencia(pDataCalculo: TDateTime): String;
      function SqlRetornaSomenteRnp: String;
      function SqlRetornaRnpRateioFuturos: String;
      function SqlRetornaUmRnp(pGrupo, pSeq, pCota: String): String;
      function SqlRetornaUmCheck(pGrupo, pSeq, pCota: String): String;
      function SqlRetornaCheck: String;
      function SqlRetornaRnpGrupo(pGrupo: string): String;
      function SqlGravaRateioFuturo: string;
      function SqlApagarDados: string;
      function SqlApagarCheck: string;
      function SqlGravaSaldoRnp: string;
      function SqlGravaCheckRel: string;
      function SqlGravaCheckPla: string;
      function SqlRnpSag: String;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlOraRnp }

const
  SQL_TABELA_EXISTE =
    'select count(*) QTDE from USER_TABLES '+
    'where TABLE_NAME = ''RECNP'' ';
  SQL_TABELA_SALDO_EXISTE =
    'select count(*) QTDE from USER_TABLES '+
    'where TABLE_NAME = ''RECNPSLD'' ';
  SQL_TABELA_CHECK_EXISTE =
    'select count(*) QTDE from USER_TABLES '+
    'where TABLE_NAME = ''CHECKRNP'' ';
  SQL_APAGAR_DADOS = 'delete from RECNP';
  SQL_APAGAR_CHECK = 'delete from CHECKRNP';
  SQL_CRIAR =
    'create table RECNP ( '+
       'GRUPO varchar(5) not null, '+
       'SEQ varchar(2) not null, '+
       'COTA varchar(3) not null, '+
       'PERCAMORT float default on null 0, '+
       'VLRRNP float default on null 0, '+
       'VLRBEM float default on null 0, '+
       'RATFUT float default on null 0,  '+
       'PCRATEIO float default on null 0, '+
       'primary key (GRUPO, SEQ, COTA) ) ';
  SQL_CRIAR_SALDO =
    'create table RECNPSLD ( '+
       'GRUPO varchar(5) not null, '+
       'SEQ varchar(2) not null, '+
       'COTA varchar(3) not null, '+
       'VLRRNP float default on null 0, '+
       'VLSIACON float, '+
       'primary key (GRUPO, SEQ, COTA) ) ';
  SQL_CRIAR_CHECK =
    'create table CHECKRNP ( '+
       'GRUPO varchar(5) not null, '+
       'SEQ varchar(2) not null, '+
       'COTA varchar(3) not null, '+
       'REL integer default on null 0, '+
       'PLA integer default on null 0, '+
       'Sld23Abr13Rel float default on null 0, '+
       'Sld23Abr13Pla float default on null 0,  '+
       'Sld26Set16Rel float default on null 0, '+
       'Sld26Set16Pla float default on null 0, '+
       'primary key (GRUPO, SEQ, COTA) ) ';
  SQL_NOVO_SALDO =
  'insert into RECNPSLD (GRUPO, SEQ, COTA, VLRRNP, VLSIACON) values ( %s, %s, %s, %f, %f )';
  SQL_NOVO_CHECK =
  'insert into CHECKRNP (GRUPO, SEQ, COTA, REL, PLA, Sld23Abr13Rel, Sld23Abr13Pla, Sld26Set16Rel, Sld26Set16Pla) '+
  'values ( %s, %s, %s, %d, %d, %f, %f, %f, %f )';
  SQL_SALDO_INICIAL_RNP =
    'select VLRRNP, VLSIACON from RECNPSLD where GRUPO = %s and SEQ = %s and COTA = %s';
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
    'select R.GRUPO, R.SEQ, R.COTA, C.NOME, R.PLA, R.REL, R.Sld23Abr13Rel,  '+
           'R.Sld23Abr13Pla, R.Sld26Set16Rel, R.Sld26Set16Pla from CHECKRNP R '+
    'inner join A2CLI C on C.GRUPO = R.GRUPO and C.SEQ = R.SEQ and C.COTA = R.COTA ';
  SQL_LISTA_SAG =
    //'select M.GRUPO, M.SEQ, M.COTA, C.NOME, C.PESS_F_J, '+
    //       'R.DATA_REU DTULTASS, G.DT_SITUA DTENCCT, T.ADM_PERM TXPER, '+
    //       'nvl(C.P_NO_PAG , 0) + nvl(C.P_AN_PAG , 0) + '+
    //       'nvl(C.P_SU_PAG , 0) PERCAMORT, C.FIL_COM, C.BEM, '
    //       'case C.PESS_F_J '+
    //         'when ''F'' then substr(C.CGC_CPF, 2, 9) ||'+
    //                         'substr(C.CGC_CPF,  15,  2) '+
    //         'when ''J'' then substr(C.CGC_CPF,  3,  14) '+
    //       'end as CGCCPFMT, '+
    //       'Case '+
    //         'When G.PRIM_REU <= ''29-JUN-1992'' then ''0190'' '+
    //         'When G.PRIM_REU <= ''02-AUG-1997'' then ''2196'' '+
    //         'When G.PRIM_REU <= ''05-FEB-2009'' then ''2766'' else ''3432'' '+
    //       'end as REGAPLIC, T.VAL_MINIMO '+
    //'from ACMOV2 M '+
    //'inner join A2CLI C on C.GRUPO = M.GRUPO and C.SEQ = M.SEQ and M.COTA = C.COTA '+
    //'inner join A2GRU G on G.GRUPO = M.GRUPO '+
    //'left outer join A2REU R on R.GRUPO = M.GRUPO and R.NRO_REU = G.PLA_PADR '+
    //'left outer join ACTCP T on T.GRUPO = C.GRUPO '+
    //'Where M.D_CONTAB = ''31-dec-2021'' and M.TIPO_MOV = ''3B'' '+
    //'order by M.GRUPO, M.COTA, M.SEQ ';

    'select C.GRUPO, C.SEQ, C.COTA, C.NOME, C.PESS_F_J, '+
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
    'select R.GRUPO, R.SEQ, R.COTA, C.NOME, C.SIT_COBR, C.PESS_F_J, '+
           'case C.PESS_F_J '+
             'when ''F'' then substr(C.CGC_CPF, 2, 3) ||''.''|| '+
                             'substr(C.CGC_CPF, 5, 3) ||''.''|| '+
                             'substr(C.CGC_CPF,  8, 3) ||''-''|| '+
                             'substr(C.CGC_CPF,  15,  2) '+
             'when ''J'' then substr(C.CGC_CPF,  3,  2) ||''.''|| '+
                             'substr(C.CGC_CPF,  5,  3) ||''.''|| '+
                             'substr(C.CGC_CPF,  8,  3) ||''/''|| '+
                             'substr(C.CGC_CPF,  11,  4) ||''-''|| '+
                             'substr(C.CGC_CPF,  15,  2) '+
           'end as CGCCPFMT, '+
           'C.TELEFONE, substr(C.INF_ADIC,60,20) CELULAR, '+
           'substr(C.INF_ADIC_2,1,50) EMAIL, ' +
           'R.PERCAMORT, R.VLRBEM, R.VLRRNP, R.RATFUT, R.PCRATEIO, G.PRIM_REU, '+
           'Case '+
             'When G.PRIM_REU <= ''29-JUN-1992'' then ''0190'' '+
             'When G.PRIM_REU <= ''02-AUG-1997'' then ''2196'' '+
             'When G.PRIM_REU <= ''05-FEB-2009'' then ''2766'' else ''3432'' '+
             'end as REGAPLIC '+
    'from RECNP R '+
    'inner join A2CLI C on C.GRUPO = R.GRUPO and C.SEQ = R.SEQ and C.COTA = R.COTA '+
    'inner join A2GRU G on G.GRUPO = R.GRUPO ';
  SQL_RETORNA_RNP = SQL_LISTA + 'order by R.GRUPO, R.SEQ, R.COTA';
  SQL_LISTA_COTAS_RNP = SQL_LISTA +'where R.VLRRNP > 0 order by R.GRUPO, R.SEQ, R.COTA';
  SQL_LISTA_COTAS_RNP_SAG = SQL_LISTA_SAG +'order by R.GRUPO, R.SEQ, R.COTA';
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
    'select R.GRUPO, R.SEQ, R.COTA, C.NOME, T.ADM_PERM, T.VAL_MINIMO from RECNP R '+
    'inner join A2CLI C on C.GRUPO = R.GRUPO and C.SEQ = R.SEQ and C.COTA = R.COTA '+
    'inner join ACTCP T on T.GRUPO = R.GRUPO '+
    'where R.VLRRNP > 0 and T.ADM_PERM > 0 and T.DT_INI_COB < %s '+
    'order by R.GRUPO, R.SEQ, R.COTA ';
  SQL_SALDO_RNP31DEC21 =
    'select OUTROS from ACMOV2 '+
    'where TIPO_MOV = ''3B'' and D_CONTAB = ''31-dec-2021''  '+
      'and GRUPO = %s and SEQ = %s and COTA = %s ';

constructor TModelSQlOraRnp.Create;
begin

end;

destructor TModelSQlOraRnp.Destroy;
begin
  inherited Destroy;
end;

class function TModelSQlOraRnp.New: iModelSqlRnp;
begin
  Result := Self.Create;
end;

function TModelSQlOraRnp.SqlCriarTabelaCheck: string;
begin
  Result := SQL_CRIAR_CHECK;
end;

function TModelSQlOraRnp.SqlTabelaCheckExiste: string;
begin
  Result := SQL_TABELA_CHECK_EXISTE;
end;

function TModelSQlOraRnp.SqlCriarTabela: string;
begin
  Result := SQL_CRIAR;
end;

function TModelSQlOraRnp.SqlCriarTabelaSaldo: string;
begin
  Result := SQL_CRIAR_SALDO;
end;

function TModelSQlOraRnp.SqlTabelaExiste: string;
begin
  Result := SQL_TABELA_EXISTE;
end;

function TModelSQlOraRnp.SqlTabelaSaldoExiste: string;
begin
  Result := SQL_TABELA_SALDO_EXISTE;
end;

function TModelSQlOraRnp.SqlNovo: String;
begin
  Result := SQL_NOVO;
end;

function TModelSQlOraRnp.SqlNovoSaldo: String;
begin
  Result := SQL_NOVO_SALDO;
end;

function TModelSQlOraRnp.SqlNovoCheck: String;
begin
  Result := SQL_NOVO_CHECK;
end;

function TModelSQlOraRnp.SqlAlterar: String;
begin
  Result := SQL_ALTERAR;
end;

function TModelSQlOraRnp.SqlAtualizarSaldoSiacon: String;
begin
  Result := SQL_ATUALIZAR_SALDO_SIACON;
end;

function TModelSQlOraRnp.SqlRetornaRnp: String;
begin
  Result := SQL_RETORNA_RNP;
end;

function TModelSQlOraRnp.SqlRetornaSaldoInicialRnp: String;
begin
  Result := SQL_SALDO_INICIAL_RNP;
end;

function TModelSQlOraRnp.SqlRetornaSaldoRnp31Dez21: String;
begin
  Result := SQL_SALDO_RNP31DEC21;
end;

function TModelSQlOraRnp.SqlRetornaRecomposicaoSaldosTodos: String;
begin
  Result := SQL_SALDOS_RNP_TODOS;
end;

function TModelSQlOraRnp.SqlRetornaRecomposicaoSaldosGrupo: String;
begin
  Result := SQL_SALDOS_RNP_GRUPO;
end;

function TModelSQlOraRnp.SqlRetornaTotalRecomposicao: String;
begin
  Result := SQL_GRUPOS_RECOMPOSICAO;
end;

function TModelSQlOraRnp.SqlRetornaComissaoPermanencia(pDataCalculo: TDateTime
  ): String;
begin
  Result := Format(SQL_COMISSAO_PERMANENCIA, [QuotedStr(RetornaDataSql(Pdatacalculo))]);
end;

function TModelSQlOraRnp.SqlRetornaSomenteRnp: String;
begin
  Result := SQL_LISTA_COTAS_RNP;
end;

function TModelSQlOraRnp.SqlRetornaRnpRateioFuturos: String;
begin
  Result := SQL_LISTA_COTAS_RATEIOFUTURO;
end;

function TModelSQlOraRnp.SqlRetornaUmRnp(pGrupo, pSeq, pCota: String): String;
begin
  Result := Format(SQL_RETORNA_UM_RNP, [ QuotedStr(Pgrupo),
                                         QuotedStr(Pseq),
                                         QuotedStr(Pcota)]);
end;

function TModelSQlOraRnp.SqlRetornaUmCheck(pGrupo, pSeq, pCota: String): String;
begin
  Result := Format(SQL_RETORNA_UM_CHECK, [ QuotedStr(Pgrupo),
                                         QuotedStr(Pseq),
                                         QuotedStr(Pcota)]);
end;

function TModelSQlOraRnp.SqlRetornaCheck: String;
begin
  Result := SQL_RETORNA_CHECK;
end;

function TModelSQlOraRnp.SqlRetornaRnpGrupo(pGrupo: string): String;
begin
  Result := Format(SQL_RETORNA_RNP_GRUPO, [QuotedStr(Pgrupo)]);
end;

function TModelSQlOraRnp.SqlGravaRateioFuturo: string;
begin
  Result := SQL_GRAVA_RATEIO_FUTURO;
end;

function TModelSQlOraRnp.SqlApagarDados: string;
begin
  Result := SQL_APAGAR_DADOS;
end;

function TModelSQlOraRnp.SqlApagarCheck: string;
begin
  Result := SQL_APAGAR_CHECK;
end;

function TModelSQlOraRnp.SqlGravaSaldoRnp: string;
begin
  Result := SQL_GRAVA_SALDO_RNP;
end;

function TModelSQlOraRnp.SqlGravaCheckRel: string;
begin
  Result := SQL_ALTERAR_CHECK_REL;
end;

function TModelSQlOraRnp.SqlGravaCheckPla: string;
begin
  Result := SQL_ALTERAR_CHECK_PLA;
end;

function TModelSQlOraRnp.SqlRnpSag: String;
begin
  Result := SQL_LISTA_COTAS_RNP_SAG;
end;

end.

