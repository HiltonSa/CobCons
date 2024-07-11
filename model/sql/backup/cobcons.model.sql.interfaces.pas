unit cobcons.model.sql.interfaces;

{$mode delphi}

interface

uses
  Classes, Sysutils;

type

  iModelSqlCota = interface
    ['{C87F7648-6740-44D1-ACE9-B77E73669E80}']
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
    function RetornaSqlRateioFuturo(Pgrupo: String): String;
    function RetornaSqlAlterarEndereco: String;
    function RetornaSqlAlterarSitCota: String;
  end;

  iModelSqlAgenda = interface
    ['{1ABFC87D-2727-43ED-AF80-8B386DF1674C}']
    function SQLRetornaAgendaUsuarioPeriodo(pUsuario: Integer; pInicio, pFim: TDateTime): String;
    function SQLAlterarPrioridade(pCodigo, pPrioridade: Integer): String;
    function SQLAlterarStatus(pCodigo, pStatus: Integer): String;
    function SQLNovo: String;
    function SQLAlterar: String;
    function SQLExcluir: String;
    function SQLProximoCodigo: String;
  end;

  iModelSqlBem = interface
    ['{BFDD393A-8E9F-45BA-82DF-23C1D23774AD}']
    function SQLRetornaBem(pBem: string): String;
  end;

  iModelSqlBemAlienado = interface
    ['{44EB7F34-26E0-4480-B6D7-4AAA64AFB2A0}']
    function SqlRetornaBensAlienadosCota(pGrupo, pCota: String): string;
    function SqlRetornaBemAlienado(pGrupo, pCota, pChassis: String): string;
  end;

  iModelSqlCredito = interface
    ['{980EBAF2-BEC0-4874-B738-CF03AB9C6BE1}']
    function SqlRetornaCreditosCota(pGrupo, pCota: String): string;
    function SqlRetornaUmCreditoCota(pGrupo, pCota, pCredito: String): string;
  end;

  iModelSqlEmpresa = interface
    ['{340E77E6-234B-41A3-A2AF-A3E6AE43F55F}']
    function SqlRecuperarEmpresa: String;
    function SqlGravarFicha: String;
    function SqlGravarAutorizacao(aValue: String): String;
  end;

  iModelSqlFaseJuridica = interface
    ['{A686E0E1-F6D7-4DCC-B460-56E5751008E4}']
    function SqlRetornaFasesCota(pGrupo, pSeq, pCota: String): String;
    function SqlRetornaUmaFaseCota(pGrupo, pSeq, pCota, pFase: String): String;
  end;

  iModelSqlGrupo = interface
    ['{4945351E-2A71-4B8C-9726-AF9A8E608188}']
    function SqlRetornaGrupo(pGrupo: string): String;
    function SqlRetornaListaGrupos: String;
  end;

  { iModelSqlPagamentos }

  iModelSqlPagamentos = interface
    ['{6A72562E-122B-4CC3-84EC-4CEFC26868DB}']
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

  iModelSqlPendencia = interface
    ['{01BD6B7E-1584-4911-A7BF-AB227A53FC44}']
    function SqlRetornaPendenciaCota(pGrupo, pSeq, pCota: String): String;
    function SqlRetornaAviso(pGrupo, pSeq, pCota, pAviso: String): String;
    function SqlNovo: String;
    function SqlExcluir: String;
    function SqlProximoAviso: String;
  end;

  iModelSqlPrecoBem = interface
    ['{B8830E8A-C86F-4474-B477-CDCA2CAD02A2}']
    function SqlRetornaPrecoBemData(pBem, pFilial: String; pData: TDateTime): string;
    function SqlRetornaPrecoBem(pBem, pFilial: String): string;
  end;

  iModelSqlReuniao = interface
    ['{81FD0AD4-5549-43D1-8614-27B6FF7F1BE7}']
    function SqlRetornaReuniaoPagamento(pGrupo: String; pDtPag: TDateTime): string;
    function SqlRetornaReuniaoGrupo(pGrupo: String): string;
  end;

  iModelSqlUsuario = interface
    ['{BBFD79EE-3B3B-455D-9BB1-83AE569857A0}']
    function SqlNovo: String;
    function SqlAlterar: String;
    function SqlExcluir: String;
    function SqlProximoCodigo: String;
    function SqlListarPorDescricao(aDescricao: String): String;
    function SqlListarPorCodigo(aCodigo: Integer): String;
    function SqlGravarImagem: String;
    function SqlGravarSenha: String;
    function SqlListarcombobox: string;
  end;

  iModelSqlUsuarioLogado = interface
    ['{DAF2B06F-9063-4100-ABF4-387673BDF4AD}']
    function SqlLogin: string;
    function SqlAtualizar: string;
  end;

  iModelSqlCotacaoMoeda = interface
    ['{ED6BD663-6A71-4B23-B5C3-3F429A232ACF}']
    function SqlCotacao(pMoeda: string; pData: TDateTime): string;
    function SqlUltimaCotacao(pMoeda: string): String;
    function SqlListar(pMoeda: string; pData: TDateTime): string;
    function SqlNovaCotacao(pMoeda: string; pData: TDateTime; pCotacao: Double): string;
    function SqlListarCombobox: string;
  end;

  iModelSqlTotal = interface
    ['{46420FA2-CA8D-499E-8617-66DCB1B08292}']
    function SqlCriarTabela: string;
    function SqlTabelaExiste: string;
    function SqlNovo: String;
    function SqlRetornaTotal: String;
    function SqlAlterar: String;
    function SqlApagaDados: String;
    function SqlAcumularInadimplente: String;
    function SqlAcumularRnp: String;
    function SqlAcumularRateioFuturo: String;
    function SqlAtualizarRnp: String;
  end;

  iModelSqlTotalGrupos = interface
    ['{18379050-18D2-4EA9-8417-57F4ADE85A55}']
    function SqlCriarTabela: string;
    function SqlTabelaExiste: string;
    function SqlNovo: String;
    function SqlRecuperaGrupo(pGrupo: String): String;
    function SqlAlterar: String;
    function SqlApagarDados: String;
    function SqlAcumularInadimplentes: String;
    function SqlAcumularRateioFuturo: String;
    function SqlAcumularTotalFator: String;
    function SqlAcumularRnp: String;
    function SqlRecuperaTodos: String;
    function SqlAtualizarRnp: String;
  end;

  iModelSqlInadimplentes = interface
    ['{8A158770-0997-4271-AB45-A59074195BE2}']
    function SqlCriarTabela: string;
    function SqlTabelaExiste: string;
    function SqlNovo: String;
    function SqlAlterar: String;
    function SqlApagarDados: string;
    function SqlRetornaInadimplentes: String;
    function SqlRetornaInadimplentesGrupo(pGrupo: string): String;
    function SqlInadimplentesSag: String;
  end;

  iModelSqlRnp = interface
    ['{76B6A05D-1448-483D-8437-62D17C44C5E8}']
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
    function SqlRetornaSaldoInicialRnp: String;
    function SqlRetornaSaldoRnp31Dez21: String;
    function SqlRetornaRecomposicaoSaldosTodos: String;
    function SqlRetornaRecomposicaoSaldosGrupo: String;
    function SqlRetornaRnp: String;
    function SqlRetornaComissaoPermanencia(pDataCalculo: TDateTime): String;
    function SqlRetornaTotalRecomposicao: String;
    function SqlRetornaSomenteRnp: String;
    function SqlRetornaRnpRateioFuturos: String;
    function SqlRetornaUmRnp(pGrupo, pSeq, pCota: String): String;
    function SqlRetornaUmCheck(pGrupo, pSeq, pCota: String): String;
    function SqlRetornaCheck: String;
    function SqlRetornaRnpGrupo(pGrupo: string): String;
    function SqlGravaRateioFuturo: string;
    function SqlGravaSaldoRnp: string;
    function SqlApagarDados: string;
    function SqlApagarCheck: string;
    function SqlGravaCheckRel: string;
    function SqlGravaCheckPla: string;
    function SqlRnpSag: String;
  end;

  iModelSqlComissaoPermanencia = interface
    ['{81FC722E-7DEC-455A-A71F-BA91E2DF7E09}']
    function SqlCriarTabela: string;
    function SqlTabelaExiste: string;
    function SqlNovoCodigo: String;
    function SqlListarCodigo: String;
    function SqlListarComissoes: String;
    function SqlNovo: String;
    function SqlExcluir: String;
  end;

  iModelSqlItemComissaoPermanencia = interface
    ['{F262ED8A-EC1B-487E-B648-370BBE8FD68B}']
    function SqlCriarTabela: string;
    function SqlTabelaExiste: string;
    function SqlNovoCodigo: String;
    function SqlListarItensComissao: String;
    function SqlListarItensComissaoGrupo: String;
    function SqlAlteraCmPer: String;
    function SqlApagaCalculo: String;
    function SqlSinteticoGrupo: String;
    function SqlNovo: String;
    function SqlExisteCalculo: String;
  end;

  iModelSqlDemonstrativo = interface
    ['{369A1D91-7368-4DCA-B212-0F9EF5800BA1}']
    function SqlCriarTabela: string;
    function SqlTabelaExiste: string;
    function SqlNovo: string;
    function SqlRetornaDemonstrativo: string;
    function SqlRetornaDemonstrativoDataBase: string;
    function SqlAlterarValorConta: String;
    function SqlListaCosifDemonstrativo: String;
    function SqlNovaDatabase: String;
    function SqlTabelaCosifExiste: string;
    function SqlCriarTabelaCosif: String;
    function SqlImportar4110Siacon: String;
    function SqlImportar4350Siacon: String;
  end;

  iModelSqlPgRnp = interface
    ['{360A61C4-C1BA-4A56-B7E6-71C918BE790C}']
    function SqlCriarTabela: string;
    function SqlTabelaExiste: string;
    function SqlMaiorCodigo: String;
    function SqlNovo: String;
    function SqlAlterar: String;
    function SqlAlterarPagto: String;
    function SqlAlterarValor: String;
    function SqlAlterarStatus: String;
    function SqlRetornaPendentesPagamento: String;
    function SqlRetornaPagasPeriodo: String;
    function SqlRetornaPagtoCota: String;
    function SqlRetornaStatus: String;
    function SqlExcluir: String;
    function SqlAsvr: String;
  end;

  iModelSqlFactory = interface
    ['{43101721-C30E-4DFC-9688-27E5BA92D7AF}']
    function SqlCota: iModelSqlCota;
    function SqlAgenda: iModelSqlAgenda;
    function SqlBem: iModelSqlBem;
    function SqlBemAlienado: iModelSqlBemAlienado;
    function SqlCredito: iModelSqlCredito;
    function SqlEmpresa: iModelSqlEmpresa;
    function SqlFaseJuridica: iModelSqlFaseJuridica;
    function SqlGrupo: iModelSqlGrupo;
    function SqlPagamentos: iModelSqlPagamentos;
    function SqlPendencia: iModelSqlPendencia;
    function SqlPrecoBem: iModelSqlPrecoBem;
    function SqlReuniao: iModelSqlReuniao;
    function SqlUsuario: iModelSqlUsuario;
    function SqlUsuarioLogado: iModelSqlUsuarioLogado;
    function SqlCotacaoMoeda: iModelSqlCotacaoMoeda;
    function SqlTotal: iModelSqlTotal;
    function SqlTotalGrupo: iModelSqlTotalGrupos;
    function SqlInadimplentes: iModelSqlInadimplentes;
    function SqlRNP: iModelSqlRnp;
    function SqlComissaoPermanencia: iModelSqlComissaoPermanencia;
    function SqlItemComissaoPermanencia: iModelSqlItemComissaoPermanencia;
    function SqlDemonstrativo: iModelSqlDemonstrativo;
    function SqlPgRnp: iModelSqlPgRnp;
  end;

implementation

uses cobcons.model.sql.fbpagamentos;

end.

