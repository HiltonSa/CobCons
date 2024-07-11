unit cobcons.model.sql.fbpagamentos;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlFbPagamentos }

  TModelSQlFbPagamentos = class (TInterfacedObject, iModelSqlPagamentos)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlPagamentos;

      function SqlListaAgentes: string;
      function SqlListaTipoDocumento: string;
      function SqlRetornaNovoNumDocumento: String;
      function SqlRetornaNumeroDocumento: String;
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

{ TModelSQlFbPagamentos }

const
  SQL_LISTA_TPDOC =
       'select TP_DOCUM, DESCRIC from ACDOC order by DESCRIC';
  SQL_NOVO_NRDOCUM =
       'select max( cast(NR_DOCUM as float) ) + 1 MAXNR from ACCCA where AG_FINAN = %s' ;
  SQL_RETORNA_NRDOCUM =
       'select NR_DOCUM from ACCCA where AG_FINAN = %s and D_CONTAB = %s and TP_DOCUM = %s';
  SQL_NOVO_DOCUMENTO =
       'insert into ACCCA (AG_FINAN, D_CONTAB, NR_DOCUM, TP_DOCUM, VAL_DOC, HISTORIC, '+
                          'DT_COMP, VAL_LANC, DT_LIBER) '+
                   'values (%s, %s, %s, %s, %.2f, %s, %s, %.2f, %s)';
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
       'insert into ACMOV (GRUPO, SEQ, COTA, AVISO, TIPO_MOV, D_VENCTO, DT_PAGTO, D_CONTAB, '+
                          'AG_FINAN, NR_DOCUM, OUTROS, SAL_GRU, SAL_CT, SEG_OUT, AV_V_COB) '+
                  'values (%s, %s, %s, %s, ''88'', %s, %s, %s, %s, %s, %.2f, ''S'',''N'',''O'',''N'')';
  SQL_INCLUIR_RENDIMENTO_RNP =
       'insert into ACMOV2 (GRUPO, SEQ, COTA, AVISO, TIPO_MOV, D_VENCTO, DT_PAGTO, D_CONTAB, '+
                          'AG_FINAN, NR_DOCUM, OUTROS, SAL_GRU, SAL_CT, SEG_OUT, AV_V_COB) '+
                  'values (%s, %s, %s, %s, ''3A'', %s, %s, %s, %s, %s, %.2f, ''S'',''N'',''O'',''N'')';
  SQL_INCLUIR_PAGAMENTO_RNP =
       'insert into ACMOV2 (GRUPO, SEQ, COTA, AVISO, TIPO_MOV, D_VENCTO, DT_PAGTO, D_CONTAB, '+
                          'AG_FINAN, NR_DOCUM, OUTROS, SAL_GRU, SAL_CT, SEG_OUT, AV_V_COB) '+
                  'values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %.2f, ''S'',''N'',''O'',''N'')';
  SQL_INCLUIR_RECOMPOSICAO_RNP =
       'insert into ACMOV2 (GRUPO, SEQ, COTA, AVISO, TIPO_MOV, D_VENCTO, DT_PAGTO, D_CONTAB, '+
                          'AG_FINAN, NR_DOCUM, OUTROS, SAL_GRU, SAL_CT, SEG_OUT, AV_V_COB) '+
                  'values (%s, %s, %s, %s, ''3B'', %s, %s, %s, %s, %s, %.2f, ''S'',''N'',''O'',''N'')';
  SQL_INCLUIR_RATEIO_RECEBIMENTOS =
       'insert into ACMOV2 (GRUPO, SEQ, COTA, AVISO, TIPO_MOV, D_VENCTO, DT_PAGTO, D_CONTAB, '+
                          'AG_FINAN, NR_DOCUM, OUTROS, SAL_GRU, SAL_CT, SEG_OUT, AV_V_COB) '+
                  'values (%s, %s, %s, %s, ''93'', %s, %s, %s, %s, %s, %.2f, ''S'',''N'',''O'',''N'')';
  SQL_EXCLUIR_MOV =
       'delete from ACMOV2 where AG_FINAN = %s and NR_DOCUM = %s';
  SQL_PAGAMENTOS_COTA =
       'select M.AVISO, M.TIPO_MOV, T.SIGLA1 DCTIPOMOV, M.D_VENCTO, M.DT_PAGTO, '+
              'cast(M.P_NORMAL as float) P_NORMAL, cast(M.P_DIFER as float) P_DIFER, '+
              'cast(M.P_ANTEC as float) P_ANTEC, cast(M.P_RATEIO as float) P_RATEIO, '+
              'cast(M.F_AQUISI as float) + cast(M.ADMINIST as float) + '+
              'cast(M.F_RESERV as float)+ cast(M.OUTROS as float) as Valor, '+
              'cast(M.MUL_JUR as float) MUL_JUR, M.BEM, cast(M.F_AQUISI as float) F_AQUISI, '+
              'cast(M.ADMINIST as float) ADMINIST, cast(M.F_RESERV as float) F_RESERV,  '+
              'cast(M.OUTROS as float) OUTROS , D.SIMBOLO, H.HISTORIC, M.D_CONTAB, '+
              'B.DESCRIC, C.FIL_COM '+
       'from ACMOV M '+
       'inner join ACTMV T on T.COD_MOV = M.TIPO_MOV '+
       'inner join ACCLI C on C.GRUPO = M.GRUPO and C.SEQ = M.SEQ and C.COTA = M.COTA '+
       'inner join ACTMO D on M.DT_PAGTO between D.DTINI and D.DTFIM '+
       'left outer join ACBEM B on B.BEM = M.BEM '+
       'left outer join ACHIS H on H.GRUPO = M.GRUPO and H.AVISO = M.AVISO and H.CONTRATO = C.CONTRATO and H.CONTABIL = M.D_CONTAB '+
       'where M.GRUPO = %s and M.SEQ = %s and M.COTA = %s and not M.TIPO_MOV in (''88'',''I8'') '+ //and T.SAL_CT = ''S'' ' +
       'order by M.DT_PAGTO desc';
  SQL_VLR_BEM_APREENDIDO =
       'select sum(cast(F_AQUISI as float)) VLAPR from ACMOV '+
       'where GRUPO = %s and SEQ = %s and COTA = %s and TIPO_MOV in (''21'',''C1'')';
  SQL_PAGAMENTOS_DEVOLUCAO_COTA =
       'select M.TIPO_MOV, T.SIGLA1 DCTIPOMOV, M.DT_PAGTO, M.D_CONTAB, M.D_VENCTO,'+
              'cast(M.F_AQUISI as float) F_AQUISI, cast(M.ADMINIST as float) ADMINIST, '+
              'cast(M.F_RESERV as float) F_RESERV, cast(M.OUTROS as float) OUTROS, '+
              'cast(M.MUL_JUR as float) MUL_JUR '+
       'from ACMOV M '+
       'inner join ACTMV T on T.COD_MOV = M.TIPO_MOV '+
       'where M.TIPO_MOV in (''8D'',''ID'',''86'',''I6'',''88'',''I8'',''92'', '+
                            '''J2'',''93'',''J3'',''96'',''J6'',''97'',''J7'', '+
                            '''9D'',''JD'') and '+
             'M.GRUPO = %s and M.SEQ = %s and M.COTA = %s and '+
             'M.D_CONTAB between %s and %s '+
       'order by M.DT_PAGTO';
  SQL_CONTA_3A =
       'select count(*) NUM from ACMOV2 '+
       'where GRUPO = %s and SEQ = %s and COTA = %s and TIPO_MOV = ''3A'' ';
  SQL_PAGAMENTOS_DATABASE =
       'select GRUPO, sum(cast(F_AQUISI as float)) F_AQUISI from ACMOV2 '+
       'where D_CONTAB between %s and %s '+
         'and TIPO_MOV in (''01'',''09'',''07'',''A1'',''A9'',''A7'') '+
       'group by GRUPO order by GRUPO';
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
              'sum(nvl(M.OUTROS , 0)) OUTROS '+
       'from ACMOV2 M '+
       'inner join ACCCA A on A.AG_FINAN = M.AG_FINAN and A.NR_DOCUM = M.NR_DOCUM '+
       'where M.D_CONTAB between %s and %s '+
       'group by M.AG_FINAN, M.NR_DOCUM, A.D_CONTAB, A.HISTORIC '+
       'order by M.AG_FINAN, M.NR_DOCUM';
  SQL_PAGAMENTOS_RNP_PERIODO =
       'select M.AG_FINAN, M.NR_DOCUM, M.AVISO, M.GRUPO, M.SEQ, M.COTA, C.NOME,  '+
       'select M.AG_FINAN, M.NR_DOCUM, M.AVISO, M.GRUPO, M.SEQ, M.COTA, C.NOME,  '+
              'T.SIGLA1 DCTIPOMOV, nvl(M.OUTROS * -1, 0) PGRNP, M.D_VENCTO, '+
              'M.DT_PAGTO, M.D_CONTAB '+
       'from ACMOV2 M '+
       'inner join ACTMV T on T.COD_MOV = M.TIPO_MOV '+
       'left outer join A2CLI C on C.GRUPO = M.GRUPO and C.SEQ = M.SEQ and C.COTA = M.COTA '+
       'where M.D_CONTAB between %s and %s '+
       '  and M.TIPO_MOV in (''8D'',''99'') '+
       'order by M.D_CONTAB, M.GRUPO, M.COTA, M.SEQ';

constructor TModelSQlFbPagamentos.Create;
begin

end;

destructor TModelSQlFbPagamentos.Destroy;
begin
  inherited Destroy;
end;

class function TModelSQlFbPagamentos.New: iModelSqlPagamentos;
begin
  Result := Self.Create;
end;

function TModelSQlFbPagamentos.SqlListaAgentes: string;
begin
  Result := SQL_LISTA_AGENTE;
end;

function TModelSQlFbPagamentos.SqlListaTipoDocumento: string;
begin
  Result := SQL_LISTA_TPDOC;
end;

function TModelSQlFbPagamentos.SqlRetornaNovoNumDocumento: String;
begin
  Result := SQL_NOVO_NRDOCUM;
end;

function TModelSQlFbPagamentos.SqlRetornaNumeroDocumento: String;
begin
  Result := SQL_RETORNA_NRDOCUM;
end;

function TModelSQlFbPagamentos.SqlNovoDocumento: String;
begin
  Result := SQL_NOVO_DOCUMENTO;
end;

function TModelSQlFbPagamentos.SqlExcluirDocumento: String;
begin
  Result := SQL_EXCLUIR_DOCUMENTO;
end;

function TModelSQlFbPagamentos.SqlExcluirMovimento: String;
begin
  Result := SQL_EXCLUIR_MOV;
end;

function TModelSQlFbPagamentos.SqlRetornaMaxAviso(pGrupo: String): String;
begin
  Result := Format(SQL_NOVO_AVISO, [ QuotedStr(Pgrupo)]);
end;

function TModelSQlFbPagamentos.SqlRetornaPagamentosCota(pGrupo, pSeq,
  pCota: String): String;
begin
  Result := Format(SQL_PAGAMENTOS_COTA, [ QuotedStr(Pgrupo),
                                          QuotedStr(Pseq),
                                          QuotedStr(Pcota)]);
end;

function TModelSQlFbPagamentos.SqlRetornaVlrApreensaoBem(pGrupo, pSeq,
  pCota: String): String;
begin
  Result := Format(SQL_VLR_BEM_APREENDIDO, [ QuotedStr(Pgrupo),
                                             QuotedStr(Pseq),
                                             QuotedStr(Pcota)]);
end;

function TModelSQlFbPagamentos.SqlIncluirComissaoPermanencia(pGrupo, pSeq,
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
  FormatSettings.DecimalSeparator := '.';
  Result := vSql;
end;

function TModelSQlFbPagamentos.SqlIncluirRendimentoRnp(pGrupo, pSeq, pCota,
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
  FormatSettings.DecimalSeparator := '.';
  Result := vSql;
end;

function TModelSQlFbPagamentos.SqlIncluirPagamentoRnp(pGrupo, pSeq, pCota,
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
                                               Pvalor]);
  FormatSettings.DecimalSeparator := '.';
  Result := vSql;
end;

function TModelSQlFbPagamentos.SqlIncluirRecomposicaoRnp(pGrupo, pSeq, pCota,
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
  FormatSettings.DecimalSeparator := '.';
  Result := vSql;
end;

function TModelSQlFbPagamentos.SqlIncluirRateioRecebimento(pGrupo, pSeq, pCota,
  pAviso, pAgente, pNumero: String; pData: TDatetime; pValor: Double): String;
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
                                               Pvalor]);
  FormatSettings.DecimalSeparator := '.';
  Result := vSql;
end;

function TModelSQlFbPagamentos.SqlRetornaPagamentosDevolucaoCota(pGrupo, pSeq,
  pCota: String; pInicio, pLimite: TDateTime): String;
begin
  Result := Format(SQL_PAGAMENTOS_DEVOLUCAO_COTA, [ QuotedStr(Pgrupo),
                                                    QuotedStr(Pseq),
                                                    QuotedStr(Pcota),
                                                    QuotedStr(RetornaDataSql(Pinicio)),
                                                    QuotedStr(RetornaDataSql(Plimite))]);
end;

function TModelSQlFbPagamentos.SqlRetornaNumeroCorrecoes(pGrupo, pSeq,
  pCota: String): String;
begin
  Result := Format(SQL_CONTA_3A, [ QuotedStr(Pgrupo),
                                   QuotedStr(Pseq),
                                   QuotedStr(Pcota)]);
end;

function TModelSQlFbPagamentos.SqlRetornaPagamentosDataBase: String;
begin
  Result := SQL_PAGAMENTOS_DATABASE;
end;

function TModelSQlFbPagamentos.SqlRetornaPagamentosPeriodo(pInicio,
  pFim: TDatetime): String;
begin
  Result := Format( SQL_PAGAMENTOS_PERIODO_ACUMULADO,
                  [ QuotedStr(RetornaDataSql(pInicio)),
                    QuotedStr(RetornaDataSql(pFim))]);
end;

function TModelSQlFbPagamentos.SqlRetornaPagamentosDetalhe(pAgente,
  pDocum: String; pContab: TDatetime): String;
begin
  Result := Format( SQL_PAGAMENTOS_PERIODO_DETALHE,
                  [ QuotedStr(pAgente),
                    QuotedStr(pDocum),
                    QuotedStr(RetornaDataSql(pContab))]);
end;

function TModelSQlFbPagamentos.SqlRetornaPagamentosRnpPeriodo(pInicio,
  pFim: TDatetime): String;
begin
  Result := Format( SQL_PAGAMENTOS_RNP_PERIODO,
                  [ QuotedStr(RetornaDataSql(pInicio)),
                    QuotedStr(RetornaDataSql(pFim))]);
end;



end.

