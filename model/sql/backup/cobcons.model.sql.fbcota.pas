unit cobcons.model.sql.fbcota;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlFbCota }

  TModelSQlFbCota = class (TInterfacedObject, iModelSqlCota)
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
      function RetornaSqlRNPUltimaReuniao(Pencct: String): String;
      function RetornaSqlRNPEncerramentoContabil(Pencct: String): String;
      function RetornaSqlAlterarEndereco: String;
      function RetornaSqlAlterarSitCota: String;
      function RetornaSqlRateioFuturo(Pgrupo: String): String;
  end;

implementation

{ TModelSQlFbCota }

const
  SQL_COTAS_GRUPO =
       'select C.GRUPO, C.COTA, C.SEQ, C.NOME from ACCLI C '+
       'where C.GRUPO = %s order BY C.GRUPO, C.COTA, C.SEQ';

  SQL_BASE =
  'select FIRST 1 C.GRUPO, C.SEQ, C.COTA, C.CONTRATO, C.NOME, C.PLANO, '+
         'cast(C.P_MENSAL as float) P_MENSAL, cast(C.P_ADMINS as float) P_ADMINS, '+
         'cast(C.P_RESERV as float) P_RESERV, C.TP_SEGUR, '+
         'cast(TS.PERSEGVD as float) + cast(TS.PERC_ESP1 as float) PERSEGVD, '+
         'C.SIT_COBR, cast(C.P_NO_PAG as float) + cast(C.P_AN_PAG as float) + '+
         'cast(C.P_SU_PAG as float) PERCPAGO, (100.00000 - (cast(C.P_NO_PAG as float) + '+
         'cast(C.P_AN_PAG as float) + cast(C.P_SU_PAG as float))) PERDEV, '+
         'C.DT_VENDA, C.REPRES, R.NOME NMREPRES, C.DT_ADES, C.REU_ADES, '+
         'cast(C.P_RATEAD as float) P_RATEAD, cast(C.P_RA_PAG as float) P_RA_PAG, '+
         'cast(C.P_RATEAD as float) - cast(C.P_RA_PAG as float) PERRAT, '+
         'C.FIL_ATE, FA.NOME NMFILATE, C.BEM, B.DESCRIC, B.TIPO_BEM, '+
         'TB.DESCRIC DCTIPOBEM, B.FABRICAN, FAB.DESCRIC DCFABBEM, '+
         'cast(P.PRE_TABE as float) PRE_TABE, C.TP_CONTE, C.DT_CONTE, '+
         'C.DT_ENTRE, cast(C.VAL_ENTR as float) VAL_ENTR, C.PESS_F_J, '+
         'C.CGC_CPF, C.DOCUMENT, C.E_CIVIL, EC.DESCRIC DCECIVIL, '+
         'C.DT_NASC, C.SEXO, C.PROFISS, PR.DESCRIC DCPROF, C.TELEFONE, '+
         'C.TIPOENDER||'' ''||C.ENDERECO||'' ''||C.NUMENDER||'' ''||C.COMPLEMEN '+
         'ENDERECO, C.BAIRRO, C.CIDADE, C.ESTADO, C.CEP, C.FIL_COM, C.TP_COTA, '+
         'TC.DESCRIC DCTPCOTA, C.AG_COBRA, cast(C.ADMINIST as float) ADMINIST, '+
         'cast(C.F_AQUISI as float) F_AQUISI, cast(C.F_RESERV as float) F_RESERV, '+
         'cast(C.OUTROS as float) OUTROS, P.DT_BASE, TS.NOME_FANT, '+
         'cast(C.ADMINIST as float) + cast(C.F_AQUISI as float) + '+
         'cast(C.F_RESERV as float) + cast(C.OUTROS as float) TOTPAGO,'+
  'case C.PESS_F_J '+
    'when ''F'' then substring(C.CGC_CPF from 2 for 3) ||''.''|| '+
                    'substring(C.CGC_CPF from 5 for 3) ||''.''|| '+
                    'substring(C.CGC_CPF from 8 for 3) ||''-''|| '+
                    'substring(C.CGC_CPF from 15 for 2) '+
    'when ''J'' then substring(C.CGC_CPF from 3 for 2) ||''.''|| '+
                    'substring(C.CGC_CPF from 5 for 3) ||''.''|| '+
                    'substring(C.CGC_CPF from 8 for 3) ||''/''|| '+
                    'substring(C.CGC_CPF from 11 for 4) ||''-''|| '+
                    'substring(C.CGC_CPF from 15 for 2) '+
    'end as CGCCPFMT ' +
  'from ACCLI C '+
  'left outer join ACBEM B   on B.BEM      = C.BEM '+
  'left outer join ACTAB TB  on TB.TABELA  = ''001'' and TB.CODIGO  = B.TIPO_BEM '+
  'left outer join ACTAB FAB on FAB.TABELA = ''002'' and FAB.CODIGO = B.FABRICAN '+
  'left outer join ACTAB EC  on EC.TABELA  = ''005'' and EC.CODIGO  = C.E_CIVIL '+
  'left outer join ACTAB PR  on PR.TABELA  = ''008'' and PR.CODIGO  = C.PROFISS '+
  'left outer join ACTAB TC  on TC.TABELA  = ''021'' and TC.CODIGO  = C.TP_COTA '+
  'left outer join ACPRE P   on P.TP_PRECO = ''R''   and P.FILIAL   = C.FIL_COM and P.BEM=C.BEM '+
  'left outer join ACTSG TS  on TS.TP_SEG  = C.TP_SEGUR '+
  'left outer join ACREP R   on R.REPRES   = C.REPRES '+
  'left outer join ACFIL FA  on FA.FILIAL  = C.FIL_ATE ';

  SQL_GRUPO_COTA = SQL_BASE +
     'where C.GRUPO=%s and C.SEQ=%s and C.COTA=%s '+
     'order by P.DT_BASE desc';

  SQL_CONSULTA =
     'select C.GRUPO, C.SEQ, C.COTA, C.NOME, C.CGC_CPF, C.PESS_F_J, C.SIT_COBR, B.DESCRIC,'+
     'case C.PESS_F_J '+
     'when ''F'' then substring(C.CGC_CPF from 2 for 3) ||''.''|| '+
                     'substring(C.CGC_CPF from 5 for 3) ||''.''|| '+
                     'substring(C.CGC_CPF from 8 for 3) ||''-''|| '+
                     'substring(C.CGC_CPF from 15 for 2) '+
     'when ''J'' then substring(C.CGC_CPF from 3 for 2) ||''.''|| '+
                     'substring(C.CGC_CPF from 5 for 3) ||''.''|| '+
                     'substring(C.CGC_CPF from 8 for 3) ||''/''|| '+
                     'substring(C.CGC_CPF from 11 for 4) ||''-''|| '+
                     'substring(C.CGC_CPF from 15 for 2) '+
       'end as CGCCPFMT ' +
     'from ACCLI C '+
     'left outer join ACBEM B on B.BEM = C.BEM ';
  SQL_CONSULTA_NOME = SQL_CONSULTA + 'where C.NOME like %s order by C.NOME';

  SQL_CONSULTA_CGCCPF = SQL_CONSULTA + 'where C.CGC_CPF like %s order by C.CGC_CPF';

  SQL_INADIMPLENTES =
     'select C.GRUPO, C.SEQ, C.COTA, C.NOME, C.PLANO, C.SIT_COBR, '+
            'cast(C.P_RESERV as float) P_RESERV, '+
            'cast(C.P_NO_PAG as float) + cast(C.P_AN_PAG as float) + '+
            'cast(C.P_SU_PAG as float) PERCPAGO, (100.00000 - (cast(C.P_NO_PAG as float) + '+
            'cast(C.P_AN_PAG as float) + cast(C.P_SU_PAG as float))) PERDEV, '+
            'cast(C.P_RATEAD as float) - cast(C.P_RA_PAG as float) PERRAT, G.PRIM_REU, '+
            'C.FIL_COM, C.BEM, J.D_INICIO DTAJUIZ, R.DATA_REU ULTREU, G.DT_SITUA DTENCCT, '+
            'T.ADM_PERM, '+
            'case C.PESS_F_J '+
              'when ''F'' then ''2'' '+
              'when ''J'' then ''1'' '+
            'end as TP_PESS, ' +
            'case C.PESS_F_J '+
              'when ''F'' then substring(C.CGC_CPF from 2 for 9) || '+
                              'substring(C.CGC_CPF from 15 for 2) '+
              'when ''J'' then substring(C.CGC_CPF from 3 for 14) '+
            'end as CGCCPFMT, ' +
            'Case '+
              'When G.PRIM_REU <= ''29-JUN-1992'' then ''0190'' '+
              'When G.PRIM_REU <= ''02-AUG-1997'' then ''2196'' '+
              'When G.PRIM_REU <= ''05-FEB-2009'' then ''2766'' else ''3432'' '+
            'end as REGAPLIC '+
     'from ACCLI C '+
     'inner join ACGRU G on G.GRUPO = C.GRUPO '+
     'left outer join ACJUD J on J.GRUPO = C.GRUPO and J.COTA = C.COTA and J.F_JURID = %s ' +
     'left outer join ACREU R on R.GRUPO = C.GRUPO and R.NRO_REU = G.PLA_PADR '+
     'left outer join ACTCP T on T.GRUPO = C.GRUPO '+
     'where C.SEQ = ''00'' and C.SIT_COBR in (''M'',''J'') and G.SIT_GRU = %s '+
     'order by C.GRUPO, C.SEQ, C.COTA';
  SQL_RATEIO_FUTURO =
     'select C.GRUPO, C.SEQ, C.COTA, C.NOME, C.PLANO, C.SIT_COBR, '+
            'cast(C.P_RESERV as float) P_RESERV, '+
            'cast(C.P_NO_PAG as float) + cast(C.P_AN_PAG as float) + '+
            'cast(C.P_SU_PAG as float) PERCPAGO, (100.00000 - (cast(C.P_NO_PAG as float) + '+
            'cast(C.P_AN_PAG as float) + cast(C.P_SU_PAG as float))) PERDEV, '+
            'cast(C.P_RATEAD as float) - cast(C.P_RA_PAG as float) PERRAT, G.PRIM_REU, '+
            'C.FIL_COM, C.BEM, R.DATA_REU ULTREU '+
     'from ACCLI C '+
     'inner join ACGRU G on G.GRUPO = C.GRUPO '+
     'left outer join ACREU R on R.GRUPO = C.GRUPO and R.NRO_REU = G.PLA_PADR '+
     'where C.GRUPO = %s and C.SEQ = ''00'' and not C.SIT_COBR in (''M'',''J'') '+
     'order by C.GRUPO, C.SEQ, C.COTA';
  SQL_RNP =
     'select C.GRUPO, C.SEQ, C.COTA, C.NOME, C.PLANO, C.SIT_COBR, '+
            'Cast(C.P_RESERV as float) P_RESERV, '+
            'Cast(C.P_NO_PAG as float) + cast(C.P_AN_PAG as float) + '+
            'Cast(C.P_SU_PAG as float) PERCPAGO, (100.00000 - (cast(C.P_NO_PAG as float) + '+
            'Cast(C.P_AN_PAG as float) + cast(C.P_SU_PAG as float))) PERDEV, '+
            'Cast(C.P_RATEAD as float) - cast(C.P_RA_PAG as float) PERRAT, G.PRIM_REU, '+
            'C.FIL_COM, C.BEM, R.DATA_REU ULTREU, G.DT_SITUA DTENCCT, T.ADM_PERM,'+
            'Case C.PESS_F_J '+
              'When ''F'' then ''2'' '+
              'When ''J'' then ''1'' '+
            'end as TP_PESS, '+
            'Case C.PESS_F_J '+
              'When ''F'' then substring(C.CGC_CPF from 2 for 9) || '+
                              'substring(C.CGC_CPF from 15 for 2) '+
              'When ''J'' then substring(C.CGC_CPF from 3 for 14) '+
           'end as CGCCPFMT, '+
           'Case '+
              'When G.PRIM_REU <= ''29-JUN-1992'' then ''0190'' '+
              'When G.PRIM_REU <= ''02-AUG-1997'' then ''2196'' '+
              'When G.PRIM_REU <= ''05-FEB-2009'' then ''2766'' else ''3432'' '+
           'end as REGAPLIC '+
     'from ACCLI C '+
     'inner join ACGRU G on G.GRUPO = C.GRUPO '+
     'left outer join ACTCP T on T.GRUPO = C.GRUPO '+
     'left outer join ACREU R on R.GRUPO = C.GRUPO and R.NRO_REU = G.PLA_PADR '+
     'Where C.SEQ between ''00'' and ''49'' and '+
           'not (C.SIT_COBR in (''M'',''J'')) and '+
           'G.SIT_GRU = %s '+
     'G.SIT_GRU = %s ';
  SQL_ORDER_GRUPO_SEQ_COTA =
     'order by C.GRUPO, C.SEQ, C.COTA';
  SQL_ORDER_ULTIMA_REUNIAO =
     'order by R.DATA_REU, C.GRUPO, C.SEQ, C.COTA';
  SQL_ORDER_ENCERRAMENTO_CONTABIL =
     'order by G.DT_SITUA, C.GRUPO, C.SEQ, C.COTA';
  SQL_RNP_ULTIMA_REUNIAO = SQL_RNP + SQL_ORDER_ULTIMA_REUNIAO;
  SQL_RNP_ENCERRAMENTO_CONTABIL = SQL_RNP + SQL_ORDER_ENCERRAMENTO_CONTABIL;

  SQL_ALTERA_ENDERECO =
     'update ACCLI set TELEFONE = %s, ENDERECO = %s, BAIRRO = %s, '+
                      'CIDADE = %s, ESTADO = %s, CEP = %s '+
     'where GRUPO = %s and SEQ = %s and COTA = %s ';

  SQL_ALTERA_SITCOB =
     'update ACCLI set SIT_COBR = %s, D_ATUALI = %s '+
     'where GRUPO = %s and SEQ = %s and COTA = %s ';



constructor TModelSQlFbCota.Create;
begin

end;

destructor TModelSQlFbCota.Destroy;
begin
  inherited Destroy;
end;

class function TModelSQlFbCota.New: iModelSqlCota;
begin
  Result := Self.Create;
end;

function TModelSQlFbCota.RetornaSqlPesquisarGrupoSeqCota(pGrupo, pSeq,
  pCota: String): String;
begin
  Result := Format(SQL_GRUPO_COTA, [ QuotedStr(Pgrupo),
                                     QuotedStr(Pseq),
                                     QuotedStr(Pcota)]);
end;

function TModelSQlFbCota.RetornaSqlCotasGrupo(pGrupo: string): string;
begin
  Result := Format(SQL_COTAS_GRUPO, [ QuotedStr(Pgrupo) ]);
end;

function TModelSQlFbCota.RetornaSqlPesquisaNome(pNome: string): string;
begin
  Result := Format(SQL_CONSULTA_NOME, [ QuotedStr(Pnome + '%') ]);
end;

function TModelSQlFbCota.RetornaSqlPesquisarCpfCnpj(pInscricao: String): String;
begin
  Result := Format(SQL_CONSULTA_CGCCPF, [ QuotedStr('%' + Pinscricao + '%') ]);
end;

function TModelSQlFbCota.RetornaSqlRetornarCotasGrupo(pGrupo: String): String;
begin
  Result := Format(SQL_COTAS_GRUPO, [ QuotedStr(Pgrupo) ]);
end;

function TModelSQlFbCota.RetornaSqlRetornainadimplentes(Pencct,
  pFaseAjuiz: String): String;
begin
  Result :=  Format( SQL_INADIMPLENTES, [ QuotedStr(Pfaseajuiz),
                                          QuotedStr(pEncCt) ] ) ;
end;

function TModelSQlFbCota.RetornaSqlRNP(Pencct: String): String;
begin
  Result :=  Format( SQL_RNP + SQL_ORDER_GRUPO_SEQ_COTA, [ QuotedStr(pEncCt) ] ) ;
end;

function TModelSQlFbCota.RetornaSqlRNPUltimaReuniao(Pencct: String): String;
begin
  Result :=  Format( SQL_RNP_ULTIMA_REUNIAO, [ QuotedStr(pEncCt) ] ) ;
end;

function TModelSQlFbCota.RetornaSqlRNPEncerramentoContabil(Pencct: String
  ): String;
begin
  Result :=  Format( SQL_RNP_ENCERRAMENTO_CONTABIL, [ QuotedStr(pEncCt) ] ) ;
end;

function TModelSQlFbCota.RetornaSqlAlterarEndereco: String;
begin
  Result := SQL_ALTERA_ENDERECO;
end;

function TModelSQlFbCota.RetornaSqlAlterarSitCota: String;
begin
  Result := SQL_ALTERA_SITCOB;
end;

function TModelSQlFbCota.RetornaSqlRateioFuturo(Pgrupo: String): String;
begin
  Result := Format( SQL_RATEIO_FUTURO, [ QuotedStr(Pgrupo) ] ) ;
end;

end.

