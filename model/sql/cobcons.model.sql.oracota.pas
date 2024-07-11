unit cobcons.model.sql.oracota;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQLOraCota }

  TModelSQLOraCota = class (TInterfacedObject, iModelSqlCota)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlCota;

      function RetornaSqlPesquisarGrupoSeqCota(pGrupo, pSeq, pCota: String): String;
      function RetornaSqlCotasGrupo(pGrupo: string): string;
      function RetornaSqlPesquisaNome(pNome: string): string;
      function RetornaSqlPesquisarCpfCnpj(pInscricao: String): String;
      function RetornaSqlRetornarCotasGrupo(pGrupo: String): String;
      function RetornaSqlRetornainadimplentes(Pencct, pFaseAjuiz: String): String;
      function RetornaSqlRNP(Pencct: String): String;
      function RetornaSqlSaldoRNP(pInicio, pFim: Integer): String;
      function RetornaSqlRNPUltimaReuniao(Pencct: String): String;
      function RetornaSqlRNPEncerramentoContabil(Pencct: String): String;
      function RetornaSqlAlterarEndereco: String;
      function RetornaSqlAlterarSitCota: String;
      function RetornaSqlRateioFuturo(Pgrupo: String): String;
  end;

implementation

{ TModelSQLOraCota }

const
  SQL_COTAS_GRUPO =
       'select C.GRUPO, C.COTA, C.SEQ, C.NOME from A2CLI C '+
       'where C.GRUPO = %s and C.SEQ between ''00'' and ''49'' '+
       'order BY C.GRUPO, C.COTA, C.SEQ';

  SQL_GRUPO_COTA =
       'select * from (select C.GRUPO, C.SEQ, C.COTA, C.CONTRATO, C.NOME, C.PLANO, '+
              'C.P_MENSAL, C.P_ADMINS, C.P_RESERV, C.TP_SEGUR, nvl(TS.PERSEGVD,0) +'+
              'nvl(TS.PERC_ESP1,0) PERSEGVD, C.SIT_COBR, nvl(C.P_NO_PAG,0) + '+
              'nvl(C.P_AN_PAG,0) + nvl(C.P_SU_PAG,0) PERCPAGO, (100.00000 - '+
              '(nvl(C.P_NO_PAG,0) + nvl(C.P_AN_PAG,0) + nvl(C.P_SU_PAG,0))) PERDEV, '+
              'C.DT_VENDA, C.REPRES, R.NOME NMREPRES, C.DT_ADES, C.REU_ADES, '+
              'nvl(C.P_RATEAD,0) P_RATEAD, nvl(C.P_RA_PAG,0) P_RA_PAG, '+
              'nvl(C.P_RATEAD,0) - nvl(C.P_RA_PAG,0) PERRAT, '+
              'C.FIL_ATE, FA.NOME NMFILATE, C.BEM, B.DESCRIC, B.TIPO_BEM, '+
              'TB.DESCRIC DCTIPOBEM, B.FABRICAN, FAB.DESCRIC DCFABBEM, '+
              'nvl(P.PRE_TABE,0) PRE_TABE, C.TP_CONTE, C.DT_CONTE, '+
              'C.DT_ENTRE, nvl(C.VAL_ENTR,0) VAL_ENTR, C.PESS_F_J, '+
              'C.CGC_CPF, C.DOCUMENT, C.E_CIVIL, EC.DESCRIC DCECIVIL, '+
              'C.DT_NASC, C.SEXO, C.PROFISS, PR.DESCRIC DCPROF, C.TELEFONE, '+
              'C.TIPOENDER||'' ''||C.ENDERECO||'' ''||C.NUMENDER||'' ''||C.COMPLEMEN '+
              'ENDERECO, C.BAIRRO, C.CIDADE, C.ESTADO, C.CEP, C.FIL_COM, C.TP_COTA, '+
              'TC.DESCRIC DCTPCOTA, C.AG_COBRA, nvl(C.ADMINIST,0) ADMINIST, '+
              'nvl(C.F_AQUISI,0) F_AQUISI, nvl(C.F_RESERV,0) F_RESERV, '+
              'nvl(C.OUTROS,0) OUTROS, P.DT_BASE, TS.NOME_FANT, '+
              'nvl(C.ADMINIST,0) + nvl(C.F_AQUISI,0) + '+
              'nvl(C.F_RESERV,0) + nvl(C.OUTROS,0) TOTPAGO, C.INF_ADIC_2,'+
              //'substr(C.INF_ADIC_2,60,20) CELULAR, substr(C.INF_ADIC_2,1,50) EMAIL, '+
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
                'end as CGCCPFMT ' +
       'from A2CLI C '+
       'left outer join ACBEM B   on B.BEM      = C.BEM '+
       'left outer join ACTAB TB  on TB.TABELA  = ''001'' and TB.CODIGO  = B.TIPO_BEM '+
       'left outer join ACTAB FAB on FAB.TABELA = ''002'' and FAB.CODIGO = B.FABRICAN '+
       'left outer join ACTAB EC  on EC.TABELA  = ''005'' and EC.CODIGO  = C.E_CIVIL '+
       'left outer join ACTAB PR  on PR.TABELA  = ''008'' and PR.CODIGO  = C.PROFISS '+
       'left outer join ACTAB TC  on TC.TABELA  = ''021'' and TC.CODIGO  = C.TP_COTA '+
       'left outer join ACPRE P   on P.TP_PRECO = ''R''   and P.FILIAL   = C.FIL_COM and P.BEM=C.BEM '+
       'left outer join ACTSG TS  on TS.TP_SEG  = C.TP_SEGUR '+
       'left outer join ACREP R   on R.REPRES   = C.REPRES '+
       'left outer join ACFIL FA  on FA.FILIAL  = C.FIL_ATE '+
       'where C.GRUPO=%s and C.SEQ=%s and C.COTA=%s  '+
       'order by P.DT_BASE desc) where rownum = 1';

  SQL_CONSULTA =
     'select C.GRUPO, C.SEQ, C.COTA, C.NOME, C.CGC_CPF, C.PESS_F_J, C.SIT_COBR, B.DESCRIC,'+
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
       'end as CGCCPFMT ' +
     'from A2CLI C '+
     'left outer join ACBEM B on B.BEM = C.BEM ';
  SQL_CONSULTA_NOME = SQL_CONSULTA + 'where C.NOME like %s order by C.NOME';

  SQL_CONSULTA_CGCCPF = SQL_CONSULTA + 'where C.CGC_CPF like %s order by C.CGC_CPF';

  SQL_INADIMPLENTES =
   'select C.GRUPO, C.SEQ, C.COTA, C.NOME, C.PLANO, C.SIT_COBR, '+
          'nvl(C.P_RESERV , 0) P_RESERV, '+
          'nvl(C.P_NO_PAG , 0) + nvl(C.P_AN_PAG , 0) + '+
          'nvl(C.P_SU_PAG , 0) PERCPAGO, (100.00000 - (nvl(C.P_NO_PAG , 0) + '+
          'nvl(C.P_AN_PAG , 0) + nvl(C.P_SU_PAG , 0))) PERDEV, '+
          'nvl(C.P_RATEAD , 0) - nvl(C.P_RA_PAG , 0) PERRAT, G.PRIM_REU, '+
          'C.FIL_COM, C.BEM, J.D_INICIO DTAJUIZ, R.DATA_REU ULTREU, G.DT_SITUA DTENCCT, '+
          'T.ADM_PERM, '+
          'case C.PESS_F_J '+
            'when ''F'' then ''2'' '+
            'when ''J'' then ''1'' '+
          'end as TP_PESS, ' +
          'case C.PESS_F_J '+
            'when ''F'' then substr(C.CGC_CPF , 2 , 9) || '+
                            'substr(C.CGC_CPF , 15 , 2) '+
            'when ''J'' then substr(C.CGC_CPF , 3 , 14) '+
          'end as CGCCPFMT, ' +
          'case '+
            'when G.PRIM_REU <= ''29/06/1992'' then ''0190'' '+
            'when G.PRIM_REU <= ''02/08/1997'' then ''2196'' '+
            'when G.PRIM_REU <= ''05/02/2009'' then ''2766'' '+
            'when G.PRIM_REU >  ''05/02/2009'' then ''3432'' '+
          'end as REGAPLIC '+
   'from A2CLI C '+
   'inner join A2GRU G on G.GRUPO = C.GRUPO '+
   'left outer join A2JUD J on J.GRUPO = C.GRUPO and J.COTA = C.COTA and J.F_JURID = %s ' +
   'left outer join A2REU R on R.GRUPO = C.GRUPO and R.NRO_REU = G.PLA_PADR '+
   'left outer join ACTCP T on T.GRUPO = C.GRUPO '+
   'where C.SEQ = ''00'' and C.SIT_COBR in (''M'',''J'') and G.SIT_GRU = %s '+
   'order by C.GRUPO, C.SEQ, C.COTA';

  SQL_RATEIO_FUTURO =
     'select C.GRUPO, C.SEQ, C.COTA, C.NOME, C.PLANO, C.SIT_COBR, '+
            'nvl(C.P_RESERV , 0) P_RESERV, '+
            'nvl(C.P_NO_PAG , 0) + nvl(C.P_AN_PAG , 0) + '+
            'nvl(C.P_SU_PAG , 0) PERCPAGO, (100.00000 - (nvl(C.P_NO_PAG , 0) + '+
            'nvl(C.P_AN_PAG , 0) + nvl(C.P_SU_PAG , 0))) PERDEV, '+
            'nvl(C.P_RATEAD , 0) - nvl(C.P_RA_PAG , 0) PERRAT, G.PRIM_REU, '+
            'C.FIL_COM, C.BEM, R.DATA_REU ULTREU '+
     'from A2CLI C '+
     'inner join A2GRU G on G.GRUPO = C.GRUPO '+
     'left outer join A2REU R on R.GRUPO = C.GRUPO and R.NRO_REU = G.PLA_PADR '+
     'where C.GRUPO = %s and C.SEQ = ''00'' and not C.SIT_COBR in (''M'',''J'') '+
     'order by C.GRUPO, C.SEQ, C.COTA';
  SQL_RNP =
     'select C.GRUPO, C.SEQ, C.COTA, C.NOME, C.PLANO, C.SIT_COBR, '+
            'nvl(C.P_RESERV , 0) P_RESERV, '+
            'nvl(C.P_NO_PAG , 0) + nvl(C.P_AN_PAG , 0) + '+
            'nvl(C.P_SU_PAG , 0) PERCPAGO, (100.00000 - (nvl(C.P_NO_PAG , 0) + '+
            'nvl(C.P_AN_PAG , 0) + nvl(C.P_SU_PAG , 0))) PERDEV, '+
            'nvl(C.P_RATEAD , 0) - nvl(C.P_RA_PAG , 0) PERRAT, G.PRIM_REU, '+
            'C.FIL_COM, C.BEM, R.DATA_REU ULTREU, G.DT_SITUA DTENCCT, T.ADM_PERM,'+
            'Case C.PESS_F_J '+
              'When ''F'' then ''2'' '+
              'When ''J'' then ''1'' '+
            'end as TP_PESS, '+
            'Case C.PESS_F_J '+
              'When ''F'' then substr(C.CGC_CPF , 2 , 9) || '+
                              'substr(C.CGC_CPF , 15 , 2) '+
              'When ''J'' then substr(C.CGC_CPF , 3 , 14) '+
           'end as CGCCPFMT, '+
           'Case '+
              'When G.PRIM_REU <= ''29/06/1992'' then ''0190'' '+
              'When G.PRIM_REU <= ''02/08/1997'' then ''2196'' '+
              'When G.PRIM_REU <= ''05/02/2009'' then ''2766'' else ''3432'' '+
           'end as REGAPLIC, T.VAL_MINIMO '+
     'from ACMOV2 M '+
     'inner join A2CLI C on C.GRUPO = M.GRUPO and C.SEQ = M.SEQ and M.COTA = C.COTA '+
     'inner join A2GRU G on G.GRUPO = M.GRUPO '+
     'left outer join ACTCP T on T.GRUPO = M.GRUPO '+
     'left outer join A2REU R on R.GRUPO = M.GRUPO and R.NRO_REU = G.PLA_PADR '+
     'Where M.D_CONTAB = ''31/12/2021'' and M.TIPO_MOV = ''3B'' '+
           'and G.SIT_GRU = %s '+
           'order by M.GRUPO, M.COTA, M.SEQ';
  SQL_SALDO_RNP =
     'select * from ('+
      'select M.GRUPO, M.SEQ, M.COTA, C.NOME, C.PLANO, C.SIT_COBR, G.PRIM_REU, '+
             'R.DATA_REU ULTREU, G.DT_SITUA DTENCCT, T.ADM_PERM, T.VAL_MINIMO, '+
             'rownum linha '+
      'from ACMOV2 M '+
      'inner join A2CLI C on C.GRUPO = M.GRUPO and C.SEQ = M.SEQ and M.COTA = C.COTA '+
      'inner join A2GRU G on G.GRUPO = M.GRUPO '+
      'left outer join A2REU R on R.GRUPO = M.GRUPO and R.NRO_REU = G.PLA_PADR '+
      'left outer join ACTCP T on T.GRUPO = C.GRUPO '+
      'Where M.D_CONTAB = ''31/12/2021'' and M.TIPO_MOV = ''3B'' '+
            //'and M.SEQ between ''00'' and ''49'' '+           /
            //'and C.GRUPO = ''0331'' '+
            //'and not (C.SIT_COBR in (''M'',''J'')) '+
      'order by M.GRUPO, M.COTA, M.SEQ '+
     ') where linha between %d and %d ';
  SQL_ORDER_GRUPO_SEQ_COTA =
     'order by C.GRUPO, C.SEQ, C.COTA';
  SQL_ORDER_ULTIMA_REUNIAO =
     'order by R.DATA_REU, C.GRUPO, C.SEQ, C.COTA';
  SQL_ORDER_ENCERRAMENTO_CONTABIL =
     'order by G.DT_SITUA, C.GRUPO, C.SEQ, C.COTA';
  SQL_RNP_ULTIMA_REUNIAO = SQL_RNP + SQL_ORDER_ULTIMA_REUNIAO;
  SQL_RNP_ENCERRAMENTO_CONTABIL = SQL_RNP + SQL_ORDER_ENCERRAMENTO_CONTABIL;

  SQL_ALTERA_ENDERECO =
     'update A2CLI set TELEFONE = %s, ENDERECO = %s, BAIRRO = %s, '+
                      'CIDADE = %s, ESTADO = %s, CEP = %s, INF_ADIC_2 = %s '+
     'where GRUPO = %s and SEQ = %s and COTA = %s ';

  SQL_ALTERA_SITCOB =
     'update A2CLI set SIT_COBR = %s, D_ATUALI = %s '+
     'where GRUPO = %s and SEQ = %s and COTA = %s ';

constructor TModelSQLOraCota.Create;
begin

end;

destructor TModelSQLOraCota.Destroy;
begin
  inherited Destroy;
end;

class function TModelSQLOraCota.New: iModelSqlCota;
begin
  Result := Self.Create;
end;

function TModelSQLOraCota.RetornaSqlPesquisarGrupoSeqCota(pGrupo, pSeq,
  pCota: String): String;
begin
  Result := Format(SQL_GRUPO_COTA, [ QuotedStr(Pgrupo),
                                     QuotedStr(Pseq),
                                     QuotedStr(Pcota)]);
end;

function TModelSQLOraCota.RetornaSqlCotasGrupo(pGrupo: string): string;
begin
  Result := Format(SQL_COTAS_GRUPO, [ QuotedStr(Pgrupo) ]);
end;

function TModelSQLOraCota.RetornaSqlPesquisaNome(pNome: string): string;
begin
  Result := Format(SQL_CONSULTA_NOME, [ QuotedStr(Pnome + '%') ]);
end;

function TModelSQLOraCota.RetornaSqlPesquisarCpfCnpj(pInscricao: String
  ): String;
begin
  Result := Format(SQL_CONSULTA_CGCCPF, [ QuotedStr('%' + Pinscricao + '%') ]);
end;

function TModelSQLOraCota.RetornaSqlRetornarCotasGrupo(pGrupo: String): String;
begin
  Result := Format(SQL_COTAS_GRUPO, [ QuotedStr(Pgrupo) ]);
end;

function TModelSQLOraCota.RetornaSqlRetornainadimplentes(Pencct,
  pFaseAjuiz: String): String;
begin
  Result :=  Format( SQL_INADIMPLENTES, [ QuotedStr(Pfaseajuiz),
                                          QuotedStr(pEncCt) ] ) ;
end;

function TModelSQLOraCota.RetornaSqlRNPUltimaReuniao(Pencct: String): String;
begin
  Result :=  Format( SQL_RNP_ULTIMA_REUNIAO, [ QuotedStr(pEncCt) ] ) ;
end;

function TModelSQLOraCota.RetornaSqlRNPEncerramentoContabil(Pencct: String
  ): String;
begin
  Result :=  Format( SQL_RNP_ENCERRAMENTO_CONTABIL, [ QuotedStr(pEncCt) ] ) ;
end;

function TModelSQLOraCota.RetornaSqlRNP(Pencct: String): String;
begin
  Result :=  Format( SQL_RNP, [ QuotedStr(pEncCt) ] ) ;
end;

function TModelSQLOraCota.RetornaSqlSaldoRNP(pInicio, pFim: Integer): String;
begin
  Result := Format(SQL_SALDO_RNP, [pInicio, pFim]);
end;

function TModelSQLOraCota.RetornaSqlAlterarEndereco: String;
begin
  Result := SQL_ALTERA_ENDERECO;
end;

function TModelSQLOraCota.RetornaSqlAlterarSitCota: String;
begin
  Result := SQL_ALTERA_SITCOB;
end;

function TModelSQLOraCota.RetornaSqlRateioFuturo(Pgrupo: String): String;
begin
  Result := Format( SQL_RATEIO_FUTURO, [ QuotedStr(Pgrupo) ] ) ;
end;

end.

