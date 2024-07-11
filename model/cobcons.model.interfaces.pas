unit cobcons.model.interfaces;

{$mode delphi}

interface

uses
  Classes, Sysutils, db, ExtCtrls, ComCtrls, CheckLst, cobcons.model.bufferdataset;

type
  TAndamento = procedure (pMsg: String) of object;
  TPBPosicao  = procedure (pPos: Integer) of object;
  TPBMaximo  = procedure (pMax: Integer) of object;
  TpModoManutencao = (tmInclusao, tmAlteracao, tmExclusao);

  iModelConexao = interface
     ['{9FF6A56D-B064-4050-A1B1-8087737AB96A}']
      //function Conectar: Trestdwdatabase;
      function Conectar: TObject;
   end;

  iQueryRest = interface
    ['{B181026E-00BC-4606-AB57-DC40CB3E7D00}']
    function Open(aSql: String): iQueryRest;
    function Executar(aSql: String): iQueryRest;
    function Vazio: Boolean;
    function PrimeiroRegistro: Boolean;
    function ProximoRegistro: Boolean;
    function NumeroRegistros: Integer;
    function AtualizarBD: iQueryRest;
    function Datasource(var aDatasource: TDataSource): iQueryRest;
    function Dataset: TDataSet;
    function FieldByName( const FieldName: string) : TField;
    function AtualizarBlob(aTabela, aCampo, aArquivoConteudo: string; aCodigo: Integer): iQueryRest; overload;
    function AtualizarBlob(aTabela, aCampo: string; aConteudo: TMemoryStream; aCodigo: Integer): iQueryRest; overload;
    function AtualizarBlob(aTabela, aCampo, aCampoCodigo: string; aConteudo: TMemoryStream; aCodigo: Integer): iQueryRest; overload;
    function ProximoCodigo(aTabela: string): Integer;
  end;

  iClienteWebService = interface
    ['{6EC3ACF1-6B3D-4D00-8467-365389A967AE}']
    function UsarSSL(aValue: Boolean): iClienteWebService;
    function Url(aValue: String): iClienteWebService;
    function Acessar: TStringStream;
  end;

  iModelEntidade = interface
    ['{74C72ED2-140F-46FD-BB4F-20BE014C5215}']
    function Novo: iModelEntidade;
    function Alterar: iModelEntidade;
    function Excluir: iModelEntidade;
    function ListarPorDescricao(aDescricao: String): iModelEntidade;
    function ListarPorCodigo(aCodigo: Integer): iModelEntidade;
    function DataSet: TDataSet;
    function ProximoCodigo: Integer;
  end;


  iModelUsuario = interface(iModelEntidade)
    ['{50A314CF-88F8-49DA-B4DA-42D058607B4C}']
    function ListarComboBox: TStringList;
    function GravarImagem: iModelUsuario;
    function GravarSenha: iModelUsuario;
    function CODIGO(aValue: Integer): iModelUsuario; overload;
    function USUARIO(aValue: String): iModelUsuario; overload;
    function SENHA(aValue: String): iModelUsuario; overload;
    function IMAGEM(aValue: String): iModelUsuario; overload;
    function IDADM(aValue: Integer): iModelUsuario; overload;
    function ATIVO(aValue: Integer): iModelUsuario; overload;
    function ESQUEMA(aValue: Integer): iModelUsuario; overload;
    function ESQUEMA: Integer; overload;
    function CODIGO: Integer; overload;
    function USUARIO: String; overload;
    function SENHA: String; overload;
    function IMAGEM: String; overload;
    function IDADM: Integer; overload;
    function ATIVO: Integer; overload;
    function DCATI: string;
  end;

  iModelUsuarioLogado = interface
    ['{1FE77371-3CA5-4146-906D-4B2A484077A6}']
    function ValidarUsuario(pNome, pSenha: string): Boolean;
    function AtualizarDados: iModelUsuarioLogado;
    function Dataset: TDataSet;
    function CODIGO: Integer;
    function USUARIO: String;
    function SENHA: String;
    function IMAGEM: String;
    function IDADM: Integer;
    function ATIVO: Integer;
    function ESQUEMA: Integer;
  end;

  iModelEmpresa = interface
    ['{D50ED84B-289C-44E7-AE26-F5D94BCD643C}']
    function RecuperarEmpresa: iModelEmpresa;
    function GravarFicha: iModelEmpresa;
    function GravarAutorizacao(aValue: String): iModelEmpresa;
    function DataSet: TDataSet;
    function CODIGO(aValue: Integer): iModelEmpresa; overload;
    function FANTASIA(aValue: string): iModelEmpresa; overload;
    function CGC(aValue: string): iModelEmpresa; overload;
    function PCMULTAS(aValue: Double): iModelEmpresa; overload;
    function PCJUROS(aValue: Double): iModelEmpresa; overload;
    function PCHONORARIOS(aValue: Double): iModelEmpresa; overload;
    function ULTSAG(aValue: TDateTime): iModelEmpresa; overload;
    function NMCONTATO(aValue: string): iModelEmpresa; overload;
    function TELCONTATO(aValue: string): iModelEmpresa; overload;
    function MAILCONTATO(aValue: string): iModelEmpresa; overload;
    function STGRUENCCT(aValue: string): iModelEmpresa; overload;
    function FASEAJUIZ(aValue: string): iModelEmpresa; overload;
    function DTRECSLDRNP(aValue: TDateTime): iModelEmpresa; overload;
    function DTRCCMPER(aValue: TDateTime): iModelEmpresa; overload;
    function PCREDAPL(aValue: Double): iModelEmpresa; overload;
    function DTLIMRED(aValue: TDateTime): iModelEmpresa; overload;
    function VLLIMEXI(aValue: Double): iModelEmpresa; overload;
    function NMREL(aValue: string): iModelEmpresa; overload;
    function NMREL: String; overload;
    function VLLIMEXI: Double; overload;
    function DTLIMRED: TDateTime; overload;
    function PCREDAPL: Double; overload;
    function DTRCCMPER: TDateTime; overload;
    function DTRECSLDRNP: TDateTime; overload;
    function FASEAJUIZ: String; overload;
    function STGRUENCCT: String; overload;
    function CODIGO: Integer; overload;
    function FANTASIA: String; overload;
    function CGC: String; overload;
    function PCMULTAS: Double; overload;
    function PCJUROS: Double; overload;
    function PCHONORARIOS: Double; overload;
    function ULTSAG: TDateTime; overload;
    function NMCONTATO: String; overload;
    function TELCONTATO: String; overload;
    function MAILCONTATO: String; overload;
    function STRLIB: String; overload;
  end;

  iModelCota = interface
    ['{FEADACB7-301C-4BDD-B518-2C43048A3077}']
    function PesquisarGrupoSeqCota(pGrupo, pSeq, pCota: String): iModelCota;
    function PesquisarNome(pNome: String): iModelCota;
    function PesquisarCpfCnpj(pInscricao: String): iModelCota;
    function RetornarCotasGrupo(pGrupo: String): iModelCota;
    function Retornainadimplentes(Pencct, pFaseAjuiz: String): Imodelcota;
    function RetornaRNP(Pencct: String): Imodelcota;
    function RetornaSaldoRNP(pInicio, pFim: Integer): String;
    function RetornaCotasRNP(pInicio, pFim: Integer): Imodelcota;
    function RetornaRateioFuturo(pGrupo: String): Imodelcota;
    function AlterarEndereco: iModelCota;
    function AlterarSitCota: iModelCota;
    function Dataset: TDataSet;
    function TemDados: Boolean;
    function Proximo: Boolean;
    function GRUPO: String; overload;
    function SEQ: String; overload;
    function COTA: String; overload;
    function GRUPO(aValue: String): iModelCota; overload;
    function SEQ(aValue: String): iModelCota; overload;
    function COTA(aValue: String): iModelCota; overload;
    function CONTRATO: String;
    function NOME: String;
    function PLANO: String;
    function P_MENSAL: Double;
    function P_ADMINS: Double;
    function P_RESERV: Double;
    function TP_SEGUR: String;
    function PERSEGVD: Double;
    function SIT_COBR: String; overload;
    function PERCPAGO: Double;
    function PERDEV: Double;
    function PERRAT: Double;
    function ADMINIST: Double;
    function DT_VENDA: TDateTime;
    function REPRES: String;
    function NMREPRES: String;
    function DT_ADES: TDateTime;
    function REU_ADES: String;
    function FIL_ATE: String;
    function FIL_COM: String;
    function NMFILATE: String;
    function BEM: String;
    function DESCRIC: String;
    function TIPO_BEM: String;
    function DCTIPOBEM: String;
    function FABRICAN: String;
    function DCFABBEM: String;
    function PRE_TABE: Double;
    function TP_CONTE: String;
    function DCTPCONTE: String;
    function DT_CONTE: TDateTime;
    function DT_ENTRE: TDateTime;
    function VAL_ENTR: Double;
    function PESS_F_J: String;
    function CGC_CPF: String;
    function DOCUMENT: String;
    function E_CIVIL: String;
    function DCECIVIL: string;
    function DT_NASC: TDateTime;
    function SEXO: String;
    function PROFISS: String;
    function DCPROF: String;
    function TELEFONE: String; overload;
    function ENDERECO: String; overload;
    function BAIRRO: String; overload;
    function CIDADE: String; overload;
    function ESTADO: String; overload;
    function CEP: String; overload;
    function CELULAR: String; overload;
    function EMAIL: String; overload;
    function TELEFONE(aValue: String): iModelCota; overload;
    function ENDERECO(aValue: String): iModelCota; overload;
    function BAIRRO(aValue: String): iModelCota; overload;
    function CIDADE(aValue: String): iModelCota; overload;
    function ESTADO(aValue: String): iModelCota; overload;
    function CEP(aValue: String): iModelCota; overload;
    function CELULAR(aValue: String): iModelCota; overload;
    function EMAIL(aValue: String): iModelCota; overload;
    function SIT_COBR(aValue: String): iModelCota; overload;
    function DCSITCOB: String;
    function CGCCPFMT: String;
    function TP_COTA: String;
    function DCTPCOTA: String;
    function AG_COBRA: string;
    function ULTREU: TDateTime;
    function TP_PESS: string;
    function DTAJUIZ: TDateTime;
    function DTENCCT: TDateTime;
    function REGAPLIC: string;
    function TXPER: Double;
  end;

  iModelPagamentos = interface
    ['{91958391-6EAB-4858-B6ED-8ACDFB53B6CC}']
    function RetornaListaAgentes: TStringList;
    function RetornaListaTipoDocumento: TStringList;
    function RetornaNovoDocumentoAgente(pAgente, pTipo, pHistorico: String; pContab: TDateTime; pValor: Double): String;
    function RetornaDocumentoAgente(pAgente, pTipo, pHistorico: String; pContab: TDateTime): String;
    function RetornaNovoAviso(pGrupo: String): Integer;
    function RetornaPagamentosCota(pGrupo, pSeq, pCota: String): iModelPagamentos;
    function RetornaPagamentosDataBase(pIni, pFim: TDateTime): iModelPagamentos;
    function RetornaVlrBemApreendidoCota(pGrupo, pSeq, pCota: String): Double;
    function RetornaPagamentosDevolucaoCota(pGrupo, pSeq, pCota: String; pInicio, pLimite: TDateTime): iModelPagamentos;
    function IncluirComissaoPermanencia(pAgente, pNrDoc, pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pValor: Double): iModelPagamentos;
    function IncluirSaldoRecomposicaoRnp(pAgente, pNrDoc, pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pSaldo: Double): iModelPagamentos;
    function IncluirRendimentoRnp(pAgente, pNrDoc, pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pValor: Double): iModelPagamentos;
    function IncluirPagamentoRnp(pAgente, pNrDoc, pGrupo, pSeq, pCota, pTipo: String; pContab, pOcorrencia: TDateTime; pValor: Double): iModelPagamentos;
    function IncluirRateioRecebimento(pAgente, pNrDoc, pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pSaldo: Double): iModelPagamentos;
    function ExcluirComissaoPermanencia(pAgente, pNrDoc: string): iModelPagamentos;
    function CotaTemCorrecoes(pGrupo, pSeq, pCota: String): Boolean;
    function DataSet: TDataSet;
    function TemDados: Boolean;
    function Proximo: Boolean;
    function AVISO: String;
    function TIPO_MOV: String;
    function DCTIPOMOV: String;
    function D_VENCTO: TDateTime;
    function DT_PAGTO: TDateTime;
    function P_NORMAL: Double;
    function P_DIFER: Double;
    function P_ANTEC: Double;
    function P_RATEIO: Double;
    function VALOR: Double;
    function MUL_JUR: Double;
    function BEM: String;
    function F_AQUISI: Double;
    function ADMINIST: Double;
    function F_RESERV: Double;
    function OUTROS: Double;
    function SIMBOLO: String;
    function HISTORIC: String;
    function D_CONTAB: TDateTime;
    function FIL_COM: String;
    function DCBEM: String;
    function ESTORNADO: Boolean;
  end;

  iModelReuniao = interface
    ['{F2573D3C-D5E4-4ACD-A896-4BF252394F85}']
    function RetornaReuniaoPagamento(pGrupo: String; pDtPag: TDateTime): iModelReuniao;
    function RetornaReuniaoGrupo(pGrupo: String): iModelReuniao;
    function Dataset: TDataSet;
    function DATA_REU: TDateTime;
    function NRO_REU: string;
  end;

  iModelPrecoBem = interface
    ['{370185D2-5BD4-4AA4-AFEA-937986015FB5}']
    function RetornaPrecoBemData(pBem, pFilial: String; pData: TDateTime): iModelPrecoBem;
    function RetornaPrecoBem(pBem, pFilial: String): iModelPrecoBem;
    function Dataset: TDataSet;
    function PRE_TABE: Double;
    function PRE_REAL: Double;
  end;

  iModelGrupo = interface
    ['{279876F8-8760-4184-AFF8-EB7E614812E2}']
    function RetornaGrupo(pGrupo: string): iModelGrupo;
    function RetornaListaGrupos: iModelGrupo;
    function Dataset: TDataSet;
    function GRUPO: string;
    function PLA_PADR: string;
    function LIM_COTA: string;
    function PRIM_REU: TDateTime;
    function TP_GRUPO: string;
    function DCTPGRUPO: string;
    function SIT_GRUPO: string;
    function DCSITGRUPO: string;
    function DT_SITUA: TDateTime;
    function ULT_REUNIAO: TDateTime;
  end;

  iModelBem = interface
    ['{15999FE3-5BB4-4898-BC05-08A4AF5AAE5B}']
    function RetornaBem(pBem: string): iModelBem;
    function Dataset: TDataSet;
    function DESCRIC: string;
    function DCTIPOBEM: string;
    function DCFABBEM: string;
  end;

  iModelPendencia = interface
    ['{91958391-6EAB-4858-B6ED-8ACDFB53B6CC}']
    function RetornaPendenciaCota(pGrupo, pSeq, pCota: String): iModelPendencia;
    function RetornaAviso(pGrupo, pSeq, pCota, pAviso: String): iModelPendencia;
    function Novo: iModelPendencia;
    function Excluir: iModelPendencia;
    function ExcluirSQG: iModelPendencia;
    function ProximoAviso: String;
    function DataSet: TDataSet;
    function GRUPO(aValue: String): iModelPendencia;
    function SEQ(aValue: String): iModelPendencia;
    function COTA(aValue: String): iModelPendencia;
    function AVISO(aValue: String): iModelPendencia; overload;
    function TIPO_MOV(aValue: String): iModelPendencia; overload;
    function AG_COBRA(aValue: String): iModelPendencia;
    function D_VENCTO(aValue: TDateTime): iModelPendencia; overload;
    function PCNOR(aValue: Double): iModelPendencia; overload;
    function P_RATEIO(aValue: Double): iModelPendencia; overload;
    function F_AQUISI(aValue: Double): iModelPendencia; overload;
    function ADMINIST(aValue: Double): iModelPendencia; overload;
    function F_RESERV(aValue: Double): iModelPendencia; overload;
    function OUTROS(aValue: Double): iModelPendencia; overload;
    function AVISO: String; overload;
    function TIPO_MOV: String; overload;
    function D_VENCTO: TDateTime; overload;
    function PCNOR: Double; overload;
    function OUTROS: Double; overload;
    function F_AQUISI: Double; overload;
    function ADMINIST: Double; overload;
    function F_RESERV: Double; overload;
    function P_RATEIO: Double; overload;
    function VALOR: Double;
    function DCTIPOMOV: String;
  end;

  iModelFaseJuridica = interface
    ['{12CC6874-4F54-4218-BCA9-11E108393874}']
    function RetornaFasesCota(pGrupo, pSeq, pCota: String): iModelFaseJuridica;
    function RetornaUmaFaseCota(pGrupo, pSeq, pCota, pFase: String): iModelFaseJuridica;
    function DataSet: TDataSet;
    function GRUPO: string;
    function SEQ: string;
    function COTA: string;
    function F_JURID: string;
    function NOME: string;
    function DCFASE: string;
    function D_INICIO: TDateTime;
    function NMREPRES: string;
    function CUST_MOE: double;
    function OBSERV: String;
  end;

  iModelCredito = interface
    ['{575B6092-C7C0-476F-8D37-642DF3214941}']
    function RetornaCreditosCota(pGrupo, pCota: String): iModelCredito;
    function RetornaUmCreditoCota(pGrupo, pCota, pCredito: String): iModelCredito;
    function DataSet: TDataSet;
    function CREDITO: string;
    function TP_CRED: string;
    function DCTPCRED: string;
    function DT_I_COR: TDateTime;
    function LIM_CORR: TDateTime;
    function VAL_CRED: Double;
    function VAL_CORR: Double;
    function FORNEC: string;
    function NMFORNEC: string;
    function DT_N_FIS: TDateTime;
    function NR_N_FIS: string;
    function DT_PAGTO: TDateTime;
    function VAL_ENTR: Double;
    function COR_ENTR: Double;
    function OBSERV: string;
  end;

  iModelBemAlienado = interface
    ['{8B3DF2C8-0B04-4B24-8DDF-78A5C44CBE73}']
    function RetornaBensAlienadosCota(pGrupo, pCota: String): iModelBemAlienado;
    function RetornaBemAlienado(pGrupo, pCota, pChassis: String): iModelBemAlienado;
    function DataSet: TDataSet;
    function NR_CHASS: String;
  end;

  iModelAgenda = interface
    ['{3C30DEBA-E46D-4FE1-B35D-43DDEB4640EA}']
    function RetornaAgendaUsuarioPeriodo(pUsuario: Integer; pInicio, pFim: TDateTime): iModelAgenda;
    function AlterarPrioridade(pCodigo, pPrioridade: Integer): iModelAgenda;
    function AlterarStatus(pCodigo, pStatus: Integer): iModelAgenda;
    function Novo: iModelAgenda;
    function Alterar: iModelAgenda;
    function Excluir: iModelAgenda;
    function ProximoCodigo: Integer;
    function DataSet: TDataSet;
    function CODIGO(aValue: Integer): iModelAgenda; overload;
    function CODIGO: Integer; overload;
    function DTAGE(aValue: TDateTime): iModelAgenda; overload;
    function DTAGE: TDateTime; overload;
    function PRIORIDADE(aValue: Integer): iModelAgenda; overload;
    function PRIORIDADE: Integer; overload;
    function CONTRATO(aValue: String): iModelAgenda; overload;
    function CONTRATO: String; overload;
    function USUARIO(aValue: Integer): iModelAgenda; overload;
    function USUARIO: Integer; overload;
    function STATUS(aValue: Integer): iModelAgenda; overload;
    function STATUS: Integer; overload;
    function GRUPO(aValue: String): iModelAgenda; overload;
    function GRUPO: String; overload;
    function SEQ(aValue: String): iModelAgenda; overload;
    function SEQ: String; overload;
    function COTA(aValue: String): iModelAgenda; overload;
    function COTA: String; overload;
    function OBS(aValue: TMemoryStream): iModelAgenda; overload;
    function OBS: TMemoryStream; overload;
    function DCPRIORIDADE: String; overload;
    function NMUSUARIO: String; overload;
    function NMCOTA: String; overload;
    function DCSTATUS: String; overload;
  end;

  iModelCotacaoMoeda = interface
    ['{A2DC6FCE-F5F4-4E26-A733-7FA2907273DC}']
    procedure GravarCotacoes;
    function GerarDatasetCotacoes: TDataSet;
    function AlternarStatusCotacao(pCotacao: integer): iModelCotacaoMoeda;
    function CalcularCotacoes: iModelCotacaoMoeda;
    function GerarListaCotacoes(Pinicio, Pfim: Tdatetime; Pconsiderasabado, Pconsideradomingo: Boolean): iModelCotacaoMoeda;
    procedure AtualizarListBox(var pListBox: TCheckListBox);
    function Dataset: TDataSet;
    function ListarComboBox: TStringList;
    function CotacaoMoeda(pMoeda: string; pData: TDateTime): Double;
    function UltimaCotacaoMoeda(pMoeda: string): iModelCotacaoMoeda;
    function ListarCotacoesMoeda(pMoeda: string; pData: TDateTime): iModelCotacaoMoeda;
    function NovaCotacaoMoeda(pMoeda: string; pData: TDateTime; pCotacao: Double): iModelCotacaoMoeda;
    function MOEDA: String; overload;
    function MOEDA(avalue: String): iModelCotacaoMoeda; overload;
    function INDICE(aValue: Double): iModelCotacaoMoeda;
    function DATA: TDateTime;
    function COTACAO: Double;
    function DIAS: Integer;
  end;

  iModelTotal = interface
    ['{AA1157B6-E063-495A-81AF-78247404ECE7}']
    function CriarTabela: iModelTotal;
    function TabelaExiste: Boolean;
    function Novo: iModelTotal;
    function ApagaDados: iModelTotal;
    function RetornaTotal: iModelTotal;
    function AcumularInadimplente: iModelTotal;
    function AcumularRnp: iModelTotal;
    function AcumularRateioFuturo: iModelTotal;
    procedure AtualizarRnp;
    function Gravar: iModelTotal;
    function DataSet: TDataSet;
    function DTCALC(aValue: TDateTime): iModelTotal;
    function QTDINAGRU(aValue: Integer): iModelTotal;
    function QTDINACOTA(aValue: Integer): iModelTotal;
    function QTDRNPGRU(aValue: Integer): iModelTotal;
    function QTDRNPCOTA(aValue: Integer): iModelTotal;
    function QTDRATGRU(aValue: Integer): iModelTotal;
    function BEMAPREENDIDO(aValue: Double): iModelTotal;
    function VLRJURIDICO(aValue: Double): iModelTotal;
    function VLRMEDIACAO(aValue: Double): iModelTotal;
    function VLRRNP(aValue: Double): iModelTotal;
    function VLRRAT(aValue: Double): iModelTotal;
  end;

  iModelTotalGrupo = interface
    ['{4AEC1009-8E76-4515-86E3-FA3DAF4B7860}']
    function CriarTabela: iModelTotalGrupo;
    function TabelaExiste: Boolean;
    function Novo: iModelTotalGrupo;
    function ApagarDados: iModelTotalGrupo;
    function ListaTodos: iModelTotalGrupo;
    function RetornaGrupo(pGrupo: String): iModelTotalGrupo;
    function Gravar: iModelTotalGrupo;
    function AcumularInadimplentes: iModelTotalGrupo;
    function AcumularRnp: iModelTotalGrupo;
    function AcumularTotalFator: iModelTotalGrupo;
    function AcumularRateioFuturo: iModelTotalGrupo;
    procedure AtualizarRnp;
    function TemDados: Boolean;
    function Proximo: Boolean;
    function DataSet: TDataSet;
    function GRUPO(aValue: string): iModelTotalGrupo; overload;
    function REGAPLIC(aValue: string): iModelTotalGrupo; overload;
    function DTCALC(aValue: TDateTime): iModelTotalGrupo;
    function DTULTASS(aValue: TDateTime): iModelTotalGrupo; overload;
    function DTENCCT(aValue: TDateTime): iModelTotalGrupo; overload;
    function DTCMPER(aValue: TDateTime): iModelTotalGrupo; overload;
    function TXPER(aValue: Double): iModelTotalGrupo; overload;
    function REGAPLIC: String; overload;
    function DTULTASS: TDateTime; overload;
    function DTENCCT: TDateTime; overload;
    function DTCMPER: TDateTime; overload;
    function TXPER: Double; overload;
    function MULRESGRU(aValue: Double): iModelTotalGrupo;
    function MULRESADM(aValue: Double): iModelTotalGrupo;
    function QTDINA(aValue: Integer): iModelTotalGrupo;
    function QTDRNP(aValue: Integer): iModelTotalGrupo;
    function BEMAPREENDIDO(aValue: Double): iModelTotalGrupo;
    function VLRJURIDICO(aValue: Double): iModelTotalGrupo;
    function VLRMEDIACAO(aValue: Double): iModelTotalGrupo;
    function VLRRNP(aValue: Double): iModelTotalGrupo;
    function TOTALFATOR(aValue: Double): iModelTotalGrupo; overload;
    function VLRRF(aValue: Double): iModelTotalGrupo; overload;
    function GRUPO: String; overload;
    function VLINA: double;
    function TOTALFATOR: double; overload;
  end;

  iModelInadimplente = interface
    ['{498DA312-4DD0-41AA-A55C-37C795FE245C}']
    function CriarTabela: iModelInadimplente;
    function TabelaExiste: Boolean;
    function Novo: iModelInadimplente;
    function ApagarDados: iModelInadimplente;
    function RetornaInadimplentes: iModelInadimplente;
    function RetornaInadimplentesGrupo(pGrupo: String): iModelInadimplente;
    function Gravar: iModelInadimplente;
    function InadimplentesSag: TDataSet;
    function DataSet: TDataSet;
    function GRUPO(aValue: String): iModelInadimplente;
    function SEQ(aValue: String): iModelInadimplente;
    function COTA(aValue: String): iModelInadimplente;
    function DTAJUIZ(aValue: TDateTime): iModelInadimplente;
    function PERCAMORT(aValue: Double): iModelInadimplente;
    function VLRRECEBER(aValue: Double): iModelInadimplente;
    function VLRBEM(aValue: Double): iModelInadimplente;
    function BEMAPREENDIDO(aValue: Double): iModelInadimplente;
  end;

  iModelRnp = interface
    ['{F357B39B-7E98-4A27-AB6A-02CC1E7D6BCD}']
    function CriarTabela: iModelRnp;
    function CriarTabelaSaldo(Pdtrecrnp: Tdatetime): iModelRnp;
    function CriarTabelaCheck: iModelRnp;
    function TabelaExiste: Boolean;
    function TabelaSaldoExiste: Boolean;
    function TabelaCheckExiste: Boolean;
    function SaldoDataBase(pGRupo, pSeq, pCota: String; pDataLimite: TDateTime): Currency;
    function SaldoRnp31Dez21(pGRupo, pSeq, pCota: String): Currency;
    function Novo: iModelRnp;
    function NovoCheck(pGrupo, pSeq, pCota: String; pRel, pPla: Integer;pRecRel, pRecPla, pComRel, pComPla: Double): Imodelrnp;
    function GravarCheck(pGrupo, pSeq, pCota: String; pRel, pPla: Integer;pRecRel, pRecPla, pComRel, pComPla: Double): Imodelrnp;
    function ApagarDados: iModelRnp;
    function ApagarCheck: iModelRnp;
    function RetornaRnp: iModelRnp;
    function RetornaCheck: iModelRnp;
    function RetornaSaldoInicialRnp: Double;
    function RetornaSaldoInicialSiacon: Double;
    function RetornaSomenteRnp: iModelRnp;
    function RetornaComissaoPermanencia(pDataCalculo: TDateTime): iModelRnp;
    function RetornaRnpRateiosFuturos: iModelRnp;
    function RetornaUmRnp(pGrupo, pSeq, pCota: String): iModelRnp;
    function RetornaUmCheck(pGrupo, pSeq, pCota: String): iModelRnp;
    function RetornaRnpGrupo(pGrupo: String): iModelRnp;
    function RetornaRecomposicaoSaldosGrupo(pGrupo: String): iModelRnp;
    function RetornaRecomposicaoSaldosTodos: iModelRnp;
    function TotalizaRecomposicaoRnp: iModelRnp;
    function Gravar: iModelRnp;
    function GravarRateioFuturo: iModelRnp;
    function GravarSaldoRnp: iModelRnp;
    function GravarSaldoSiaconRnp(pGrupo, pSeq, pCota: String; pSiacon: Double): iModelRnp;
    function CompararSAG: TDataSet; overload;
    function CompararSAG(pArquivoSag: TStringList): TDataSet; overload;
    function RnpSag: TDataSet;
    function DataSet: TDataSet;
    function TemDados: Boolean;
    function Proximo: Boolean;
    function GRUPO(aValue: String): iModelRnp; overload;
    function SEQ(aValue: String): iModelRnp; overload;
    function COTA(aValue: String): iModelRnp; overload;
    function PERCAMORT(aValue: Double): iModelRnp;
    function VLRRNP(aValue: Double): iModelRnp; overload;
    function VLRRNP: Double; overload;
    function VLRBEM(aValue: Double): iModelRnp;
    function RATFUT(aValue: Double): iModelRnp;
    function PCRATEIO(aValue: Double): iModelRnp;
    function GRUPO: String; overload;
    function SEQ: String; overload;
    function COTA: String; overload;
    function FATOR: double;
    function TXPER: double;
    function VLMIN: double;
    function NOME: String;
  end;

  iModelTabularEncerrados = interface
    ['{9823C3C9-3A5D-466A-90C7-6E66F4C8888F}']
    function LIMITEMINIMO(aValue: Double): iModelTabularEncerrados;
    function DATALIMITE(aVaue: TDateTime): iModelTabularEncerrados;
    function DATAREF(aValue: Integer): iModelTabularEncerrados;
    function DATASEP(aValue: TDateTime): iModelTabularEncerrados;
    function ANDAMENTO(aValue: TAndamento): iModelTabularEncerrados;
    function LOG(aValue: TAndamento): iModelTabularEncerrados;
    function PBINICIO(aValue: TPBMaximo): iModelTabularEncerrados;
    function PBPOSICAO(aValue: TPBPosicao): iModelTabularEncerrados;
    function RetornarSaldoDataBase: Currency;
    function CalcularSaldoRnpCota(pGrupo, pSeq, pCota: String; pCCDev: iModelBufferDataset): Double;
    function CalcularSaldoRnpDataBase(pSaldoContabil: Double): TDataSet;
    function GravarAplicacaoRnp(pAgente, pTipoDoc, pHistorico: String; pDataBase: TDateTime; pValor: Double ): iModelTabularEncerrados;
    function ResumoCalculo: TDataSet;
    procedure AtualizarSaldoRnp;
    procedure Tabular;
  end;

  iModelComissaoPermanencia = interface
    ['{F07DA303-66B9-4DDC-8E7D-C3FAF42644E6}']
    function CriarTabela: iModelComissaoPermanencia;
    function TabelaExiste: Boolean;
    function ExcluirComissaoPermanencia(pCodigo: Integer): iModelComissaoPermanencia;
    function ListarComissoes: iModelComissaoPermanencia;
    function ListarPorCodigo(pCodigo: Integer): iModelComissaoPermanencia;
    function DataSet: TDataSet;
    function LOG(aValue: TAndamento): iModelComissaoPermanencia;
    function AGENTE(aValue: String): iModelComissaoPermanencia;
    function TPDOC(aValue: String): iModelComissaoPermanencia;
    function DOCUMENTO(aValue: String): iModelComissaoPermanencia;
    function HISTORICO(aValue: String): iModelComissaoPermanencia;
    function DATACALCULO(aValue: TDateTime): iModelComissaoPermanencia;
    function SALDOINICIAL: Double;
    function COMISSAO: Double;
    function SALDOFINAL: Double;
    function Calcular: TDataSet;
    procedure Gravar;
  end;

  { iModelItemComissaoPermanencia }

  iModelItemComissaoPermanencia = interface
    ['{B5A14490-8DEF-4E4A-A426-7945A9318F3B}']
    function CriarTabela: iModelItemComissaoPermanencia;
    function TabelaExiste: Boolean;
    procedure NovoItem;
    function ListarItensComissao(pCmPer: Integer): iModelItemComissaoPermanencia;
    function ListarItensComissaoGrupo(pCmPer: Integer; pGrupo: String): iModelItemComissaoPermanencia;
    function ListarItensComissaoSinteticoGrupo(pCmPer: Integer): iModelItemComissaoPermanencia;
    function ExisteCalculoCota(pGrupo, pSeq, pCota: String): iModelItemComissaoPermanencia;
    function DataSet: TDataSet;
    function TemDados: Boolean;
    function Proximo: Boolean;
    function NovoCodigo: Integer;
    procedure AlteraCmPer(pCmPer: Integer);
    procedure ApagaCalculo;
    procedure ApagaItens(pCalculo: Integer);
    function CODIGO(aValue: Integer): iModelItemComissaoPermanencia;
    function CMPER(aValue: Integer): iModelItemComissaoPermanencia;
    function GRUPO(aValue: String): iModelItemComissaoPermanencia; overload;
    function SEQ(aValue: String): iModelItemComissaoPermanencia; overload;
    function COTA(aValue: String): iModelItemComissaoPermanencia; overload;
    function SDINICIAL(aValue: Double): iModelItemComissaoPermanencia; overload;
    function COMISSAO(aValue: Double): iModelItemComissaoPermanencia; overload;
    function SDFINAL(aValue: Double): iModelItemComissaoPermanencia; overload;
    function SDFINAL: Double; overload;
    function SDINICIAL: Double; overload;
    function GRUPO: String; overload;
    function SEQ: String; overload;
    function COTA: String; overload;
    function COMISSAO: Double; overload;
  end;

  iModelFichaPagamentos = interface
    ['{E254AE86-2CAC-4458-A90D-9EDA68E3DCBA}']
    function GRUPO(aValue: String): iModelFichaPagamentos;
    function SEQ(aValue: String): iModelFichaPagamentos;
    function COTA(aValue: String): iModelFichaPagamentos;
    function DATALIMITE(aValue: TDateTime): iModelFichaPagamentos;
    function DTRECOMPOESALDORNP(aValue: TDateTime): iModelFichaPagamentos;
    function SaldoInicialRnp: Double;
    function CalcularSaldoDevedorCota: TDataSet;
    function MontarPagamentos: TDataSet;
    function MontarPendencias: TDataSet;
    function RetornarTotaisCota: TDataSet;
    function ContaCorrenteDevolucoes: TDataSet;
  end;

  iModelSag = interface
    ['{E5C3F4D4-8293-4961-AFD9-1032FB43BB6F}']
    function CNPJADM(aValue: String): iModelSag;
    function DATABASE(aValue: TDateTime): iModelSag;
    function REMESSA(aValue: String): iModelSag;
    function TELCONTATO(aValue: String): iModelSag;
    function NOMECONTATO(aValue: String): iModelSag;
    function MAILCONTATO(aValue: String): iModelSag;
    function NOMEARQUIVO(aValue: String): iModelSag;
    function LOG(aValue: TAndamento): iModelSag;
    function GERARSAG: iModelSag;
  end;

  iModelDemonstrativo = interface
    ['{4F4EA607-B34D-4E92-B7B5-C2B3B93854B5}']
    function CriarTabela: iModelDemonstrativo;
    function TabelaExiste: Boolean;
    function Novo: iModelDemonstrativo;
    function RetornaDemonstrativo: iModelDemonstrativo;
    function RetornaDemonstrativoDataBase: iModelDemonstrativo;
    function ImportarDemonstrativosSiacon: iModelDemonstrativo;
    function GravarValorConta: iModelDemonstrativo;
    function DataSet: TDataSet;
    function GRUPO(aValue: String): iModelDemonstrativo;
    function DEMONSTRATIVO(aValue: String): iModelDemonstrativo;
    function DATABASE(aValue: TDateTime): iModelDemonstrativo;
    function CONTACOSIF(aValue: String): iModelDemonstrativo;
    function SALDOCONTA(aValue: Double): iModelDemonstrativo;
    function VLRPERIODO(aValue: Double): iModelDemonstrativo;
    function VLRACUMULADO(aValue: Double): iModelDemonstrativo;
  end;

  iModelSaldoRnpDataBase =  interface
    ['{57462589-54A4-4BA0-BB9B-FA146D6FCEDC}']
    function DATABASE(aValue: TDateTime): iModelSaldoRnpDataBase;
    function DATAREF(aValue: Integer): iModelSaldoRnpDataBase;
    function DATASEP(aValue: TDateTime): iModelSaldoRnpDataBase;
    function LOG(aValue: TAndamento): iModelSaldoRnpDataBase;
    function GravarAplicacaoRnp(pAgente, pTipoDoc, pHistorico: String; pDataBase: TDateTime; pValor: Double ): iModelSaldoRnpDataBase;
    function RetornarSaldoDataBase: Currency;
    function CalcularSaldoRnpDataBase(pSaldoContabil: Double): iModelSaldoRnpDataBase;
    function Dataset: TDataSet;
  end;

  iModelRateioPagamentos = interface
    ['{B2350F6A-1121-4B97-A291-23E432636312}']
    function LOG(aValue: TAndamento): iModelRateioPagamentos;
    function DATABASE(aValue: TDateTime): iModelRateioPagamentos;
    function AGENTE(aValue: String): iModelRateioPagamentos;
    function TIPODOC(aValue: String): iModelRateioPagamentos;
    function HISTORICO(aValue: String): iModelRateioPagamentos;
    function RateioRecebimentos(pDataset: TDataSet): iModelRateioPagamentos;
    function Dataset: TDataset;
    procedure GravarRateio;
  end;

  iModelPgRnp = interface
    ['{6E7A07DA-2D56-475C-B30B-8E66AFA4E7F0}']
    function TabelaExiste: Boolean;
    function CriarTabela: iModelPgRnp;
    function Novo: iModelPgRnp;
    function Gravar: iModelPgRnp;
    function GravarPagamento: iModelPgRnp;
    function GravarStatus: iModelPgRnp;
    function DataSet: TDataSet;
    function TemDados: Boolean;
    function Proximo: Boolean;
    function RetornaPagamentoCota: iModelPgRnp;
    function RetornaStatus: iModelPgRnp;
    function BaixarPagamentosDataset(pAgente, pTipoDoc, pHistorico: String; pContab: TDateTime; pTotal: Double; pDataSet: TDataSet): iModelPgRnp;
    function GerarExportacao(pEmp, pFilial, pPartida, pContra1, pContra2: String; pContab: TDateTime; pPagtos: TDataSet; var pArquivo: TStringList; pMarcar: Boolean): iModelPgRnp;
    function PesquisarAsvr(pDtBase: TDateTime): TDataset;
    function GerarAsvr(pTipo, pCnpj: String; pDtBase: TDateTime;
      pArquivo: TStringList; pDataset: TDataset): iModelPgRnp;
    function Excluir: iModelPgRnp;
    function AtualizarValorPagar: iModelPgRnp;

    function CODIGO(aValue: Integer): iModelPgRnp; overload;
    function CODIGO: Integer; overload;
    function GRUPO(aValue: String): iModelPgRnp; overload;
    function SEQ(aValue: String): iModelPgRnp; overload;
    function COTA(aValue: String): iModelPgRnp; overload;
    function GRUPO: String; overload;
    function SEQ: String; overload;
    function COTA: String; overload;
    function STATUS(aValue: Integer): iModelPgRnp; overload;
    function STATUS: Integer; overload;
    function VALOR(aValue: Double): iModelPgRnp; overload;
    function VALOR: Double; overload;
    function DTPEDIDO(aValue: TDateTime): iModelPgRnp; overload;
    function DTPEDIDO: TDateTime; overload;
    function DTPROG(aValue: TDateTime): iModelPgRnp; overload;
    function DTPROG: TDateTime; overload;
    function DTPAGTO(aValue: TDateTime): iModelPgRnp; overload;
    function DTPAGTO: TDateTime; overload;
    function FRMPG(aValue: Integer): iModelPgRnp; overload;
    function FRMPG: Integer; overload;
    function TIPOPIX(aValue: Integer): iModelPgRnp; overload;
    function TIPOPIX: Integer; overload;
    function CHAVEPIX(aValue: String): iModelPgRnp; overload;
    function CHAVEPIX: String; overload;
    function BANCO(aValue: String): iModelPgRnp; overload;
    function BANCO: String; overload;
    function AGENCIA(aValue: String): iModelPgRnp; overload;
    function AGENCIA: String; overload;
    function CONTA(aValue: String): iModelPgRnp; overload;
    function CONTA: String; overload;
    function OBS(aValue: String): iModelPgRnp; overload;
    function OBS: String; overload;
    function DCSIT: String;
  end;

  iModelRelatorio = interface
    ['{E66F1167-D3BF-4C51-BD87-63561F7F0B1E}']
    function MovimentosNoPeriodo(pInicio, pFim: TDateTime): TDataSet;
    function MovimentosPeriodoDetalhe(pAgente, pDocum: String; pContab: TDateTime): TDataSet;
    function RelatorioComissoes(pPeriodo:Integer; pFil: Integer = 0): TDataset;
    function ProducaoVendas(pInicio, pFim: TDateTime; pAgente, pEquipe, pFilial: Integer): TDataSet;
    function CancelamentosNoPeriodo(pInicio, pFim: TDateTime): TDataSet;
    function VendasAgente(pAgente: Integer): TDataSet;
    function ResumoVendas(pPeriodo: Integer): TDataSet;
    function PagamentosRnpPeriodo(pInicio, pFim: TDateTime): TDataSet;
  end;

  iModelAdmcon = interface
    ['{1B52C8C1-E2C8-4A84-A3E7-B22BD7A9979D}']
    function ListaPorCodigo(pCodigo: Integer): TDataSet;
    function ListaPorNome(pNome: String): TDataSet;
    function ListaComboBox: TStringList;
    function Executar(pModo: TpModoManutencao): iModelAdmcon;
    function CODIGO: Integer; overload;
    function CODIGO(pValor: Integer): iModelAdmcon; overload;
    function NOMEFANTASIA: String; overload;
    function NOMEFANTASIA(pValor: String): iModelAdmcon; overload;
    function RAZAOSOCIAL: String; overload;
    function RAZAOSOCIAL(pValor: String): iModelAdmcon; overload;
    function CNPJ: String; overload;
    function CNPJ(pValor: String): iModelAdmcon; overload;
    function VIGENCIA: TDateTime; overload;
    function VIGENCIA(pValor: TDateTime): iModelAdmcon; overload;
    function UNIDADE: Integer; overload;
    function UNIDADE(pValor: Integer): iModelAdmcon; overload;
    function PCENTREGA: Double; overload;
    function PCENTREGA(pValor: Double): iModelAdmcon; overload;
    function MESPER: Integer; overload;
    function MESPER(pValor: Integer): iModelAdmcon; overload;
    function PCPER: Double; overload;
    function PCPER(pValor: Double): iModelAdmcon; overload;
    function ACERTO: Integer; overload;
    function ACERTO(pValor: Integer): iModelAdmcon; overload;
    function ULTFAIXA: Integer; overload;
    function ULTFAIXA(pValor: Integer): iModelAdmcon; overload;
  end;

  iModelFaixaComissao = interface
    ['{87684437-4375-4327-874C-C5E241655BEB}']
    function ListaPorCodigo(pCodigo: Integer): TDataSet;
    function ListaPorEmpresa(pEmpresa: Integer): TDataSet;
    function ListaComboBox(pEmpresa:Integer): TStringList;
    function Executar(pModo: TpModoManutencao): iModelFaixaComissao;
    function CODIGO: Integer; overload;
    function CODIGO(pValor: Integer): iModelFaixaComissao; overload;
    function EMPRESA: Integer; overload;
    function EMPRESA(pValor: Integer): iModelFaixaComissao; overload;
    function DESCRICAO: String; overload;
    function DESCRICAO(pValor: String): iModelFaixaComissao; overload;
    function MINIMO: Double; overload;
    function MINIMO(pValor: Double): iModelFaixaComissao; overload;
    function MAXIMO: Double; overload;
    function MAXIMO(pValor: Double): iModelFaixaComissao; overload;
  end;

  iModelRegraComissao = interface
    ['{BF931711-B702-4C0E-B132-CDB9C18F9D5F}']
    function ListaParcelasFaixa(pEmpresa, pFaixa: Integer): TDataSet;
    function ListaParcela(pEmpresa, pFaixa, pParcela: Integer): TDataSet;
    function Executar(pModo: TpModoManutencao): iModelRegraComissao;
    function EMPRESA: Integer; overload;
    function EMPRESA(pValor: Integer): iModelRegraComissao; overload;
    function PARCELA: Integer; overload;
    function PARCELA(pValor: Integer): iModelRegraComissao; overload;
    function FAIXA: Integer; overload;
    function FAIXA(pValor: Integer): iModelRegraComissao; overload;
    function PCLIB: Integer; overload;
    function PCLIB(pValor: Integer): iModelRegraComissao; overload;
    function PERCENTUAL: Double; overload;
    function PERCENTUAL(pValor: Double): iModelRegraComissao; overload;
  end;

  iModelFilial = interface
    ['{6CD213A5-7BAF-496F-A9D6-3CE7B143D88D}']
    function ListaPorCodigo(pCodigo: Integer): TDataSet;
    function ListaPorNome(pNome: String): TDataSet;
    function ListaComboBox: TStringList;
    function Executar(pModo: TpModoManutencao): iModelFilial;
    function CODIGO: Integer; overload;
    function CODIGO(pValor: Integer): iModelFilial; overload;
    function DESCRICAO: String; overload;
    function DESCRICAO(pValor: String): iModelFilial; overload;
    function RESPONSAVEL: Integer; overload;
    function RESPONSAVEL(pValor: Integer): iModelFilial; overload;
    function CODEXT: String; overload;
    function CODEXT(pValor: String): iModelFilial; overload;
  end;

  iModelEquipe = interface
    ['{7C19E68C-C839-4A05-A907-F2B856A4FEA4}']
    function ListaPorCodigo(pCodigo: Integer): TDataSet;
    function ListaPorNome(pNome: String): TDataSet;
    function ListaComboBox(pFilial: Integer=0): TStringList;
    function Executar(pModo: TpModoManutencao): iModelEquipe;
    function CODIGO: Integer; overload;
    function CODIGO(pValor: Integer): iModelEquipe; overload;
    function DESCRICAO: String; overload;
    function DESCRICAO(pValor: String): iModelEquipe; overload;
    function FILIAL: Integer; overload;
    function FILIAL(pValor: Integer): iModelEquipe; overload;
    function SUPERVISOR: Integer; overload;
    function SUPERVISOR(pValor: Integer): iModelEquipe; overload;
  end;

  iModelAgente = interface
    ['{7D7385FA-DC89-4B34-AC79-2BAD77F32678}']
    function ListaPorCodigo(pCodigo: Integer): TDataSet;
    function ListaPorNome(pNome: String): TDataSet;
    function ListaComboBox(pEquipe: Integer = 0): TStringList;
    function ListaSupervisoresAtivosComboBox(pNivel: Integer): TStringList;
    function Executar(pModo: TpModoManutencao): iModelAgente;
    function CODIGO: Integer; overload;
    function CODIGO(pValor: Integer): iModelAgente; overload;
    function NOME: String; overload;
    function NOME(pValor: String): iModelAgente; overload;
    function CPF: String; overload;
    function CPF(pValor: String): iModelAgente; overload;
    function DDD: String; overload;
    function DDD(pValor: String): iModelAgente; overload;
    function CELULAR: String; overload;
    function CELULAR(pValor: String): iModelAgente; overload;
    function EQUIPE: Integer; overload;
    function EQUIPE(pValor: Integer): iModelAgente; overload;
    function SUPERVISAO: Integer; overload;
    function SUPERVISAO(pValor: Integer): iModelAgente; overload;
    function ATIVO: Integer; overload;
    function ATIVO(pValor: Integer): iModelAgente; overload;
    function CDEXTERNO: String; overload;
    function CDEXTERNO(pValor: String): iModelAgente; overload;
    function DCATIVO: String;
    function DCFIL: String;
    function DCEQP: String;
  end;

  iModelNivelSupervisao = interface
    ['{272E128C-A50E-4816-88A7-1122054C4299}']
    function ListaPorCodigo(pCodigo: Integer): TDataSet;
    function ListaPorNome(pNome: String): TDataSet;
    function ListaComboBox: TStringList;
    function CODIGO: Integer;
    function DESCRICAO: String;
    function VDPROPRIA: Integer;
  end;

  iModelSituacaoContrato = interface
    ['{79DBFD9E-36FE-45EC-AF48-E038A5163934}']
    function ListaPorCodigo(pCodigo: Integer): TDataSet;
    function ListaPorNome(pNome: String): TDataSet;
    function ListaComboBox: TStringList;
    function CODIGO: Integer;
    function DESCRICAO: String;
  end;


  iModelPeriodo = interface
    ['{06765DC1-1FDB-4876-87AB-91ED7FB6C4F3}']
    function ListaPorCodigo(pCodigo: Integer): TDataSet;
    function ListaPorNome(pNome: String): TDataSet;
    function ListaComboBox: TStringList;
    function ListaComboBoxCalculo: TStringList;
    function CalcularComissoes: iModelPeriodo;
    function Executar(pModo: TpModoManutencao): iModelPeriodo;
    function RetornaPeriodoAtual: iModelPeriodo;
    function CODIGO: Integer; overload;
    function CODIGO(aValue: Integer): iModelPeriodo; overload;
    function DESCRICAO: String;
    function DTINI: TDateTime;
    function DTFIM: TDateTime;
    function DTCAL: TDateTime; overload;
    function DTCAL(pValor: TDateTime): iModelPeriodo; overload;
  end;

  iModelVenda = interface
    ['{90D34820-31B2-4F4D-94FF-880049DB3988}']
    function ListaPorCodigo(pCodigo: Integer): iModelVenda;
    function ContratoJaInformado(pEmpresa: Integer; pContrato: String): Integer;
    function RetornaBem(pEmpresa: Integer; pCdBem: String): iModelVenda;
    function RetornarVendas(itPsq: Integer; stPesq: String): iModelBufferDataset;
    function Executar(pModo: TpModoManutencao): iModelVenda;
    function CancelarVenda(pCodigo: Integer; pData: TDateTime; pValor: Double): iModelVenda;
    function Dataset: TDataset;
    function CODIGO: Integer;
    function EMPRESA: Integer; overload;
    function EMPRESA(pValor: Integer): iModelVenda; overload;
    function CONTRATO: String; overload;
    function CONTRATO(pValor: String): iModelVenda; overload;
    function AGENTE: Integer; overload;
    function AGENTE(pValor: Integer): iModelVenda; overload;
    function DTVENDA: TDateTime; overload;
    function DTVENDA(pValor: TDateTime): iModelVenda; overload;
    function PERIODO: Integer; overload;
    function PERIODO(pValor: Integer): iModelVenda; overload;
    function CDBEM: String; overload;
    function CDBEM(pValor: String): iModelVenda; overload;
    function DCBEM: String; overload;
    function DCBEM(pValor: String): iModelVenda; overload;
    function VALOR: Double; overload;
    function VALOR(pValor: Double): iModelVenda; overload;
    function SITUACAO: Integer; overload;
    function SITUACAO(pValor: Integer): iModelVenda; overload;
    function DTCON: TDateTime; overload;
    function DTCON(pValor: TDateTime): iModelVenda; overload;
    function NOME: String; overload;
    function NOME(pValor: String): iModelVenda; overload;
    function DDD: String; overload;
    function DDD(pValor: String): iModelVenda; overload;
    function FONE: String; overload;
    function FONE(pValor: String): iModelVenda; overload;
    function TPPES: Integer; overload;
    function TPPES(pValor: Integer): iModelVenda; overload;
    function CPFCNPJ: String; overload;
    function CPFCNPJ(pValor: String): iModelVenda; overload;
    function GRUPO: String; overload;
    function GRUPO(pValor: String): iModelVenda; overload;
    function COTA: Integer; overload;
    function COTA(pValor: Integer): iModelVenda; overload;
    function DIAVENC: Integer; overload;
    function DIAVENC(pValor: Integer): iModelVenda; overload;
    function VLRPAGO: Double; overload;
    function VLRPAGO(pValor: Double): iModelVenda; overload;
    function NMEMP: String;
    function NMAGE: String;
    function DCSIT: String;
  end;

  iModelParcelaComissao = interface
    ['{F5542546-3751-4829-8D26-1652D0CF6F91}']
    function ListaPorCodigo(pVenda, pParcela: Integer): iModelParcelaComissao;
    function ListaPorVenda(pVenda: Integer): TDataSet;
    function ExisteParcela(pEmpresa: Integer; pContrato: String; pParcela: Integer): Boolean;
    function RetornarParcelasPendentes(itPsq: Integer; stPesq: String): iModelBufferDataset;
    function Executar(pModo: TpModoManutencao): iModelParcelaComissao;
    function VENDA: Integer; overload;
    function VENDA(pValor: Integer): iModelParcelaComissao; overload;
    function PARCELA: Integer; overload;
    function PARCELA(pValor: Integer): iModelParcelaComissao; overload;
    function DTVENC: TDateTime; overload;
    function DTVENC(pValor: TDateTime): iModelParcelaComissao; overload;
    function PERIODO: Integer; overload;
    function PERIODO(pValor: Integer): iModelParcelaComissao; overload;
    function RECEBER: Double; overload;
    function RECEBER(pValor: Double): iModelParcelaComissao; overload;
    function RECEBIDO: Double; overload;
    function RECEBIDO(pValor: Double): iModelParcelaComissao; overload;
    function PAGAR: Double; overload;
    function PAGAR(pValor: Double): iModelParcelaComissao; overload;
    function PAGO: Double; overload;
    function PAGO(pValor: Double): iModelParcelaComissao; overload;
    function DTREC: TDateTime; overload;
    function DTREC(pValor: TDateTime): iModelParcelaComissao; overload;
  end;

  { iModelFactory }

  iModelFactory = interface
    ['{6474C821-ED9D-47CF-82BA-09F0D815C7E8}']
    function Conexao(pBanco: Integer = 0) : iModelConexao;
    function ClienteWS: iClienteWebService;
    function QueryRest(aConexao: iModelConexao): iQueryRest;
    function Usuario(aQuery: iQueryRest): iModelUsuario;
    function UsuarioLogado(aQuery: iQueryRest): iModelUsuarioLogado;
    function Empresa(aQuery: iQueryRest): iModelEmpresa;
    function Cota(aQuery: iQueryRest): iModelCota;
    function Pagamentos(aQuery: iQueryRest): iModelPagamentos;
    function Reuniao(aQuery: iQueryRest): iModelReuniao;
    function PrecoBem(aQuery: iQueryRest): iModelPrecoBem;
    function Grupo(aQuery: iQueryRest): iModelGrupo;
    function Bem(aQuery: iQueryRest): iModelBem;
    function Pendencia(aQuery: iQueryRest): iModelPendencia;
    function FaseJuridica(aQuery: iQueryRest): iModelFaseJuridica;
    function Credito(aQuery: iQueryRest): iModelCredito;
    function BemAlienado(aQuery: iQueryRest): iModelBemAlienado;
    function Agenda(aQuery: iQueryRest): iModelAgenda;
    function CotacaoMoeda(aQuery: iQueryRest): iModelCotacaoMoeda;
    function Total(aQuery: iQueryRest): iModelTotal;
    function TotalGrupo(aQuery: iQueryRest): iModelTotalGrupo;
    function Inadimplente(aQuery: iQueryRest): iModelInadimplente;
    function RNP(aQuery: iQueryRest): iModelRnp;
    function TabularEncerrados: iModelTabularEncerrados;
    function ComissaoPermanencia(aQuery: iQueryRest): iModelComissaoPermanencia;
    function ItemComissaoPermanencia(aQuery: iQueryRest): iModelItemComissaoPermanencia;
    function FichaPagamentos(aQuery: iQueryRest): iModelFichaPagamentos;
    function Sag: iModelSag;
    function Demonstrativo(aQuery: iQueryRest): iModelDemonstrativo;
    function SaldoRnpDatabase: iModelSaldoRnpDataBase;
    function RateioPagamentos: iModelRateioPagamentos;
    function PgRnp(aQuery: iQueryRest): iModelPgRnp;
    function Relatorio(aQuery: iQueryRest): iModelRelatorio;
    function AdmCon(aQuery: iQueryRest): iModelAdmcon;
    function FaixaComissao(aQuery: iQueryRest): iModelFaixaComissao;
    function RegraComissao(aQuery: iQueryRest): iModelRegraComissao;
    function Filial(aQuery: iQueryRest): iModelFilial;
    function Equipe(aQuery: iQueryRest): iModelEquipe;
    function Agente(aQuery: iQueryRest): iModelAgente;
    function NivelSupervisao(aQuery: iQueryRest): iModelNivelSupervisao;
    function SituacaoContrato(aQuery: iQueryRest): iModelSituacaoContrato;
    function Periodo(aQuery: iQueryRest): iModelPeriodo;
    function Venda(aQuery: iQueryRest): iModelVenda;
    function ParcelaComissao(aQuery: iQueryRest): iModelParcelaComissao;
  end;



implementation


end.

