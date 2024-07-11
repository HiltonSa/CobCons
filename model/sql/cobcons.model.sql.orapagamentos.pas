unit cobcons.model.sql.orapagamentos;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlFbPagamentos }

  { TModelSQlOraPagamentos }

  TModelSQlOraPagamentos = class (TInterfacedObject, iModelSqlPagamentos)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlPagamentos;

      function SqlListaAgentes: string;
      function SqlRetornaNovoNumDocumento: String;
      function SqlRetornaNumeroDocumento: String;
      function SqlListaTipoDocumento: string;
      function SqlNovoDocumento: String;
      function SqlExcluirDocumento: String;
      function SqlExcluirMovimento: String;
      function SqlRetornaMaxAviso(pGrupo: String): String;
      function SqlRetornaPagamentosCota(pGrupo, pSeq, pCota: String): String;
      function SqlRetornaVlrApreensaoBem(pGrupo, pSeq, pCota: String): String;
      function SqlIncluirComissaoPermanencia(pGrupo, pSeq, pCota, pAviso, pAgente, pNumero: String; pData: TDatetime; pValor: Double): String;
      function SqlIncluirRendimentoRnp(pGrupo, pSeq, pCota, pAviso, pAgente, pNumero: String; pData: TDatetime; pValor: Double): String;
      function SqlIncluirPagamentoRnp(pGrupo, pSeq, pCota, pAviso, pAgente, pNumero, pTipo: String; pContab, pOcorrencia: TDatetime; pValor: Double): String;
      function SqlIncluirRecomposicaoRnp(pGrupo, pSeq, pCota, pAviso, pAgente, pNumero: String; pData: TDatetime; pValor: Double): String;
      function SqlIncluirRateioRecebimento(pGrupo, pSeq, pCota, pAviso, pAgente, pNumero: String; pData: TDatetime; pValor: Double): String;
      function SqlRetornaPagamentosDevolucaoCota(pGrupo, pSeq, pCota: String; pInicio, pLimite: TDateTime): String;
      function SqlRetornaNumeroCorrecoes(pGrupo, pSeq, pCota: String): String;
      function SqlRetornaPagamentosDataBase: String;
      function SqlRetornaPagamentosPeriodo(pInicio, pFim: TDatetime): String;
      function SqlRetornaPagamentosDetalhe(pAgente, pDocum: String; pContab: TDatetime): String;
      function SqlRetornaPagamentosRnpPeriodo(pInicio, pFim: TDatetime): String;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlOraPagamentos }

const
  SQL_LISTA_TPDOC =
       'select TP_DOCUM, DESCRIC from ACDOC order by DESCRIC';
  SQL_NOVO_NRDOCUM =
       'select max( cast(NR_DOCUM as float) ) + 1 MAXNR from ACCCA where AG_FINAN = %s' ;
  SQL_RETORNA_NRDOCUM =
       'select NR_DOCUM from ACCCA where AG_FINAN = %s and D_CONTAB = %s and TP_DOCUM = %s';
  SQL_NOVO_DOCUMENTO =
       'insert into ACCCA (AG_FINAN, D_CONTAB, NR_DOCUM, TP_DOCUM, VAL_DOC, HISTORIC, '+
                          'DT_COMP, VAL_LANC, DT_LIBER, AG_ORIG, COBRADOR, DOC_ORIG, '+
                          'TP_SALDO, PERM_DIS, CONTABIL, USUARIO, D_ATUALI, NR_DOCUM_BCO, '+
                          'DOC_REQ_VALID, H_VALID, CONT_ORI, D_VALID) '+
                 'values (%s, %s, %s, %s, %.2f, %s, %s, %.2f, %s, ''000000'', ''000000'', '+
                         ' ''000000'', ''V'', ''S'', ''S'', ''0001'', %s, %s, ''N'', '+
                         ' ''0000'', ''01-JAN-1801'', ''01-JAN-1801'' )';
  SQL_EXCLUIR_DOCUMENTO =
       'delete from ACCCA where AG_FINAN = %s and NR_DOCUM = %s';
  SQL_LISTA_AGENTE =
       'select AG_FINAN, NOME from ACAGE order by NOME';
  SQL_NOVO_AVISO =
       'select g.aviso, count(g.aviso) qtd from acmov2 g '+
       'where g.grupo=%s '+
       'group by g.aviso '+
       'order by g.aviso';
  SQL_INCLUIR_COMISSAO_PERMANENCIA =
       'insert into ACMOV2 (GRUPO, SEQ, COTA, AVISO, TIPO_MOV, D_VENCTO, DT_PAGTO, D_CONTAB, '+
                          'AG_FINAN, NR_DOCUM, OUTROS, SAL_GRU, SAL_CT, SEG_OUT, AV_V_COB) '+
                  'values (%s, %s, %s, %s, ''88'', %s, %s, %s, %s, %s, %.2f, ''S'',''N'',''O'',''N'')';
  SQL_INCLUIR_PAGAMENTO_RNP =
       'insert into ACMOV2 (GRUPO, SEQ, COTA, AVISO, TIPO_MOV, D_VENCTO, DT_PAGTO, D_CONTAB, '+
                          'AG_FINAN, NR_DOCUM, OUTROS, DT_BASE, D_ATUALI, SAL_GRU, SAL_CT, '+
                          'SEG_OUT, AV_V_COB, RECIBO, CONTABIL, STATUS, USUARIO, AV_ASSOC) '+
                  'values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %.2f, %s, %s,''S'',''S'','+
                          '''O'',''N'',''000000'', ''N'', ''N'', ''0001'',''000000'')';
  SQL_INCLUIR_RENDIMENTO_RNP =
       'insert into ACMOV2 (GRUPO, SEQ, COTA, AVISO, TIPO_MOV, D_VENCTO, DT_PAGTO, D_CONTAB, '+
                          'AG_FINAN, NR_DOCUM, OUTROS, SAL_GRU, SAL_CT, SEG_OUT, AV_V_COB) '+
                  'values (%s, %s, %s, %s, ''3A'', %s, %s, %s, %s, %s, %.2f, ''S'',''N'',''O'',''N'')';
  SQL_INCLUIR_RECOMPOSICAO_RNP =
       'insert into ACMOV2 (GRUPO, SEQ, COTA, AVISO, TIPO_MOV, D_VENCTO, DT_PAGTO, D_CONTAB, '+
                          'AG_FINAN, NR_DOCUM, OUTROS, SAL_GRU, SAL_CT, SEG_OUT, AV_V_COB) '+
                  'values (%s, %s, %s, %s, ''3B'', %s, %s, %s, %s, %s, %.2f, ''S'',''N'',''O'',''N'')';
  SQL_INCLUIR_RATEIO_RECEBIMENTOS =
       'insert into ACMOV2 (GRUPO, SEQ, COTA, AVISO, TIPO_MOV, D_VENCTO, DT_PAGTO, D_CONTAB, '+
                          'AG_FINAN, NR_DOCUM, OUTROS, F_RESERV, SAL_GRU, SAL_CT, SEG_OUT, AV_V_COB) '+
                  'values (%s, %s, %s, %s, ''93'', %s, %s, %s, %s, %s, %.2f, %.2f,''S'',''N'',''O'',''N'')';
  SQL_EXCLUIR_MOV =
       'delete from ACMOV2 where AG_FINAN = %s and NR_DOCUM = %s';
  SQL_PAGAMENTOS_COTA =
       'select M.AVISO, M.TIPO_MOV, T.SIGLA1 DCTIPOMOV, M.D_VENCTO, M.DT_PAGTO, '+
              'nvl(M.P_NORMAL , 0) P_NORMAL, nvl(M.P_DIFER , 0) P_DIFER, '+
              'nvl(M.P_ANTEC , 0) P_ANTEC, nvl(M.P_RATEIO , 0) P_RATEIO, '+
              'nvl(M.F_AQUISI , 0) + nvl(M.ADMINIST , 0) + '+
              'nvl(M.F_RESERV , 0)+ nvl(M.OUTROS , 0)+ nvl(M.MUL_JUR , 0) as Valor, '+
              'nvl(M.MUL_JUR , 0) MUL_JUR, M.BEM, nvl(M.F_AQUISI , 0) F_AQUISI, '+
              'nvl(M.ADMINIST , 0) ADMINIST, nvl(M.F_RESERV , 0) F_RESERV,  '+
              'nvl(M.OUTROS , 0) OUTROS , D.SIMBOLO, H.HISTORIC, M.D_CONTAB, '+
              'B.DESCRIC, C.FIL_COM, M.AV_ASSOC '+
       'from ACMOV2 M '+
       'inner join ACTMV T on T.COD_MOV = M.TIPO_MOV '+
       'inner join A2CLI C on C.GRUPO = M.GRUPO and C.SEQ = M.SEQ and C.COTA = M.COTA '+
       'inner join ACTMO D on M.DT_PAGTO between D.DTINI and D.DTFIM '+
       'left outer join ACBEM B on B.BEM = M.BEM '+
       'left outer join ACHIS H on H.GRUPO = M.GRUPO and H.AVISO = M.AVISO and H.CONTRATO = C.CONTRATO and H.CONTABIL = M.D_CONTAB '+
       'where M.GRUPO = %s and M.SEQ = %s and M.COTA = %s and not M.TIPO_MOV in '+
                      '(''8D'',''ID'',''86'',''I6'',''88'',''I8'',''92'', ''41'',''42'','+
                       '''J2'',''93'',''J3'',''96'',''J6'',''97'',''J7'', ''E1'',''E2'','+
                       '''9D'',''JD'',''99'',''J9'',''3A'', ''3B'') '+ //and T.SAL_CT = ''S'' ' +
       'order by M.DT_PAGTO desc';

  SQL_VLR_BEM_APREENDIDO =
       'select sum(nvl(F_AQUISI,0)) VLAPR from ACMOV2 '+
       'where GRUPO = %s and SEQ = %s and COTA = %s and TIPO_MOV in (''21'',''C1'')';
  SQL_PAGAMENTOS_DEVOLUCAO_COTA =
       'select M.TIPO_MOV, T.SIGLA1 DCTIPOMOV, M.DT_PAGTO, M.D_CONTAB, M.D_VENCTO,'+
              'nvl(M.F_AQUISI , 0) F_AQUISI, nvl(M.ADMINIST , 0) ADMINIST, '+
              'nvl(M.F_RESERV , 0) F_RESERV, nvl(M.OUTROS , 0) OUTROS, '+
              'nvl(M.MUL_JUR , 0) MUL_JUR, M.AV_ASSOC '+
       'from ACMOV2 M '+
       'inner join ACTMV T on T.COD_MOV = M.TIPO_MOV '+
       'where M.TIPO_MOV in (''8D'',''ID'',''86'',''I6'',''88'',''I8'',''92'', '+
                            '''J2'',''93'',''J3'',''96'',''J6'',''97'',''J7'', '+
                            '''9D'',''JD'',''99'',''J9'',''3A'', ''3B'') and '+
             'M.GRUPO = %s and M.SEQ = %s and M.COTA = %s and '+
             'M.D_CONTAB between %s and %s '+
       'order by M.DT_PAGTO, M.D_CONTAB, M.TIPO_MOV';
  SQL_CONTA_3A =
       'select count(*) NUM from ACMOV2 '+
       'where GRUPO = %s and SEQ = %s and COTA = %s and TIPO_MOV = ''3A'' ';
  SQL_PAGAMENTOS_DATABASE =
       'select GRUPO, sum(nvl(F_AQUISI,0)) F_AQUISI from ACMOV2 '+
       'where D_CONTAB between %s and %s '+
         'and TIPO_MOV in (''01'',''09'',''07'',''A1'',''A9'',''A7'') '+
       'group by GRUPO order by GRUPO';
  SQL_PAGAMENTOS_DEVOLUCOES =
       'select M.GRUPO, M.SEQ, M.COTA, M.AVISO, M.TIPO_MOV, T.SIGLA1 DCTIPOMOV, '+
              'nvl(M.F_AQUISI , 0) + nvl(M.ADMINIST , 0) + '+
              'nvl(M.F_RESERV , 0)+ nvl(M.OUTROS , 0) as Valor, '+
              'case C.PESS_F_J '+
                'when ''F'' then ''2'' '+
                'when ''J'' then ''1'' '+
              'end as TP_PESS, ' +
              'case C.PESS_F_J '+
                'when ''F'' then substr(C.CGC_CPF , 2 , 9) || '+
                                'substr(C.CGC_CPF , 15 , 2) '+
                'when ''J'' then substr(C.CGC_CPF , 3 , 14) '+
              'end as CGCCPFMT, ' +
              'M.D_VENCTO, M.DT_PAGTO, M.AV_ASSOC from ACMOV2 M '+
       'inner join A2CLI C on C.GRUPO = M.GRUPO and C.SEQ = M.SEQ and C.COTA = M.COTA '+
       'where M.TIPO_MOV in (''8D'',''99'') '+
       'and M.D_CONTAB between %s and %s '+
       'order by M.GRUPO, M.SEQ, M.COTA';
  SQL_PAGAMENTOS_PERIODO_DETALHE =
       'select M.AG_FINAN, M.NR_DOCUM, M.AVISO, M.GRUPO, M.SEQ, M.COTA, C.NOME,  '+
              'M.TIPO_MOV, T.SIGLA1 DCTIPOMOV, nvl(M.F_AQUISI , 0) F_AQUISI, '+
              'nvl(M.ADMINIST , 0) ADMINIST, nvl(M.F_RESERV , 0) F_RESERV,  '+
              'nvl(M.OUTROS , 0) OUTROS, M.D_VENCTO, M.DT_PAGTO, M.D_CONTAB '+
       'from ACMOV2 M '+
       'inner join ACTMV T on T.COD_MOV = M.TIPO_MOV '+
       'left outer join A2CLI C on C.GRUPO = M.GRUPO and C.SEQ = M.SEQ and C.COTA = M.COTA '+
       'where M.AG_FINAN = %s and M.NR_DOCUM = %s and M.D_CONTAB = %s'+
       'order by M.GRUPO, M.SEQ, M.COTA, M.AVISO';
  SQL_PAGAMENTOS_PERIODO_ACUMULADO =
       'select M.AG_FINAN, M.NR_DOCUM, A.D_CONTAB, A.HISTORIC,  '+
              'count(M.AVISO) QTDLAN, sum(nvl(M.F_AQUISI , 0)) F_AQUISI, '+
              'sum(nvl(M.ADMINIST , 0)) ADMINIST, '+
              'sum(nvl(M.F_RESERV , 0)) F_RESERV,  '+
              'sum(nvl(M.OUTROS , 0)) OUTROS, sum(nvl(M.F_AQUISI , 0)) + '+
              'sum(nvl(M.ADMINIST , 0)) + sum(nvl(M.F_RESERV , 0)) + '+
              'sum(nvl(M.OUTROS , 0)) VLTOT '+
       'from ACMOV2 M '+
       'inner join ACCCA A on A.AG_FINAN = M.AG_FINAN and A.NR_DOCUM = M.NR_DOCUM and A.D_CONTAB = M.D_CONTAB '+
       'where M.D_CONTAB between %s and %s '+
       'group by M.AG_FINAN, M.NR_DOCUM, A.D_CONTAB, A.HISTORIC '+
       'order by A.D_CONTAB, M.AG_FINAN, M.NR_DOCUM';
  SQL_PAGAMENTOS_RNP_PERIODO =
       'select M.AG_FINAN, M.NR_DOCUM, M.AVISO, M.GRUPO, M.SEQ, M.COTA, C.NOME,  '+
              'T.SIGLA1 DCTIPOMOV, CASE WHEN M.OUTROS < 0 THEN (M.OUTROS*-1 )  '+
              'ELSE M.OUTROS END AS PGRNP, M.D_VENCTO, '+
              'M.DT_PAGTO, M.D_CONTAB '+
       'from ACMOV2 M '+
       'inner join ACTMV T on T.COD_MOV = M.TIPO_MOV '+
       'left outer join A2CLI C on C.GRUPO = M.GRUPO and C.SEQ = M.SEQ and C.COTA = M.COTA '+
       'where M.D_CONTAB between %s and %s '+
       '  and M.TIPO_MOV in (''8D'',''99'') '+
       'order by M.D_CONTAB, M.GRUPO, M.COTA, M.SEQ';


constructor TModelSQlOraPagamentos.Create;
begin

end;

destructor TModelSQlOraPagamentos.Destroy;
begin
  inherited Destroy;
end;

class function TModelSQlOraPagamentos.New: iModelSqlPagamentos;
begin
  Result := Self.Create;
end;

function TModelSQlOraPagamentos.SqlListaAgentes: string;
begin
  Result := SQL_LISTA_AGENTE;
end;

function TModelSQlOraPagamentos.SqlRetornaNovoNumDocumento: String;
begin
  Result := SQL_NOVO_NRDOCUM;
end;

function TModelSQlOraPagamentos.SqlRetornaNumeroDocumento: String;
begin
  Result := SQL_RETORNA_NRDOCUM;
end;

function TModelSQlOraPagamentos.SqlListaTipoDocumento: string;
begin
  Result := SQL_LISTA_TPDOC;
end;

function TModelSQlOraPagamentos.SqlNovoDocumento: String;
begin
  Result := SQL_NOVO_DOCUMENTO;
end;

function TModelSQlOraPagamentos.SqlExcluirDocumento: String;
begin
  Result := SQL_EXCLUIR_DOCUMENTO;
end;

function TModelSQlOraPagamentos.SqlExcluirMovimento: String;
begin
  Result := SQL_EXCLUIR_MOV;
end;

function TModelSQlOraPagamentos.SqlRetornaMaxAviso(pGrupo: String): String;
begin
  Result := Format(SQL_NOVO_AVISO, [ QuotedStr(Pgrupo) ]);
end;

function TModelSQlOraPagamentos.SqlRetornaPagamentosCota(pGrupo, pSeq,
  pCota: String): String;
begin
  Result := Format(SQL_PAGAMENTOS_COTA, [ QuotedStr(Pgrupo),
                                          QuotedStr(Pseq),
                                          QuotedStr(Pcota)]);
end;

function TModelSQlOraPagamentos.SqlRetornaVlrApreensaoBem(pGrupo, pSeq,
  pCota: String): String;
begin
  Result := Format(SQL_VLR_BEM_APREENDIDO, [ QuotedStr(Pgrupo),
                                             QuotedStr(Pseq),
                                             QuotedStr(Pcota)]);
end;

function TModelSQlOraPagamentos.SqlIncluirComissaoPermanencia(pGrupo, pSeq,
  pCota, pAviso, pAgente, pNumero: String; pData: TDatetime; pValor: Double
  ): String;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  vSql := Format(SQL_INCLUIR_COMISSAO_PERMANENCIA, [ QuotedStr(Pgrupo),
                                                     QuotedStr(Pseq),
                                                     QuotedStr(Pcota),
                                                     QuotedStr(Paviso),
                                                     QuotedStr(RetornaDataSql(Pdata)),
                                                     QuotedStr(RetornaDataSql(Pdata)),
                                                     QuotedStr(RetornaDataSql(Pdata)),
                                                     QuotedStr(Pagente),
                                                     QuotedStr(Pnumero),
                                                     Pvalor]);
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

function TModelSQlOraPagamentos.SqlIncluirRendimentoRnp(pGrupo, pSeq, pCota,
  pAviso, pAgente, pNumero: String; pData: TDatetime; pValor: Double): String;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  vSql := Format(SQL_INCLUIR_RENDIMENTO_RNP, [ QuotedStr(Pgrupo),
                                               QuotedStr(Pseq),
                                               QuotedStr(Pcota),
                                               QuotedStr(Paviso),
                                               QuotedStr(RetornaDataSql(Pdata)),
                                               QuotedStr(RetornaDataSql(Pdata)),
                                               QuotedStr(RetornaDataSql(Pdata)),
                                               QuotedStr(Pagente),
                                               QuotedStr(Pnumero),
                                               Pvalor]);
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

function TModelSQlOraPagamentos.SqlIncluirPagamentoRnp(pGrupo, pSeq, pCota,
  pAviso, pAgente, pNumero, pTipo: String; pContab, pOcorrencia: TDatetime;
  pValor: Double): String;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  vSql := Format(SQL_INCLUIR_PAGAMENTO_RNP, [ QuotedStr(Pgrupo),
                                               QuotedStr(Pseq),
                                               QuotedStr(Pcota),
                                               QuotedStr(Paviso),
                                               QuotedStr(pTipo),
                                               QuotedStr(RetornaDataSql(pOcorrencia)),
                                               QuotedStr(RetornaDataSql(pOcorrencia)),
                                               QuotedStr(RetornaDataSql(pContab)),
                                               QuotedStr(Pagente),
                                               QuotedStr(Pnumero),
                                               Pvalor,
                                               QuotedStr(RetornaDataSql(pOcorrencia)),
                                               QuotedStr(RetornaDataSql(pOcorrencia))
                                               ]);
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

function TModelSQlOraPagamentos.SqlIncluirRecomposicaoRnp(pGrupo, pSeq, pCota,
  pAviso, pAgente, pNumero: String; pData: TDatetime; pValor: Double): String;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  vSql := Format(SQL_INCLUIR_RECOMPOSICAO_RNP, [ QuotedStr(Pgrupo),
                                               QuotedStr(Pseq),
                                               QuotedStr(Pcota),
                                               QuotedStr(Paviso),
                                               QuotedStr(RetornaDataSql(Pdata)),
                                               QuotedStr(RetornaDataSql(Pdata)),
                                               QuotedStr(RetornaDataSql(Pdata)),
                                               QuotedStr(Pagente),
                                               QuotedStr(Pnumero),
                                               Pvalor]);
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

function TModelSQlOraPagamentos.SqlIncluirRateioRecebimento(pGrupo, pSeq,
  pCota, pAviso, pAgente, pNumero: String; pData: TDatetime; pValor: Double
  ): String;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  vSql := Format(SQL_INCLUIR_RATEIO_RECEBIMENTOS, [ QuotedStr(Pgrupo),
                                               QuotedStr(Pseq),
                                               QuotedStr(Pcota),
                                               QuotedStr(Paviso),
                                               QuotedStr(RetornaDataSql(Pdata)),
                                               QuotedStr(RetornaDataSql(Pdata)),
                                               QuotedStr(RetornaDataSql(Pdata)),
                                               QuotedStr(Pagente),
                                               QuotedStr(Pnumero),
                                               Pvalor,
                                               -(pValor)]);
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

function TModelSQlOraPagamentos.SqlRetornaPagamentosDevolucaoCota(pGrupo, pSeq,
  pCota: String; pInicio, pLimite: TDateTime): String;
begin
  Result := Format(SQL_PAGAMENTOS_DEVOLUCAO_COTA, [ QuotedStr(Pgrupo),
                                                    QuotedStr(Pseq),
                                                    QuotedStr(Pcota),
                                                    QuotedStr(RetornaDataSql(Pinicio)),
                                                    QuotedStr(RetornaDataSql(Plimite))]);
end;

function TModelSQlOraPagamentos.SqlRetornaNumeroCorrecoes(pGrupo, pSeq,
  pCota: String): String;
begin
  Result := Format(SQL_CONTA_3A, [ QuotedStr(Pgrupo),
                                   QuotedStr(Pseq),
                                   QuotedStr(Pcota)]);
end;

function TModelSQlOraPagamentos.SqlRetornaPagamentosDataBase: String;
begin
  Result := SQL_PAGAMENTOS_DATABASE;
end;

function TModelSQlOraPagamentos.SqlRetornaPagamentosPeriodo(pInicio,
  pFim: TDatetime): String;
begin
  Result := Format( SQL_PAGAMENTOS_PERIODO_ACUMULADO,
                  [ QuotedStr(RetornaDataSql(pInicio)),
                    QuotedStr(RetornaDataSql(pFim))]);
end;

function TModelSQlOraPagamentos.SqlRetornaPagamentosDetalhe(pAgente,
  pDocum: String; pContab: TDatetime): String;
begin
  Result := Format( SQL_PAGAMENTOS_PERIODO_DETALHE,
                  [ QuotedStr(pAgente),
                    QuotedStr(pDocum),
                    QuotedStr(RetornaDataSql(pContab))]);
end;

function TModelSQlOraPagamentos.SqlRetornaPagamentosRnpPeriodo(pInicio,
  pFim: TDatetime): String;
begin
  Result := Format( SQL_PAGAMENTOS_RNP_PERIODO,
                  [ QuotedStr(RetornaDataSql(pInicio)),
                    QuotedStr(RetornaDataSql(pFim))]);
end;

end.

