unit cobcons.controller.interfaces;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.interfaces, cobcons.model.bufferdataset, db, ExtCtrls, ComCtrls, CheckLst;
type

  iControllerEntidade = interface
    ['{74C72ED2-140F-46FD-BB4F-20BE014C5215}']
    function Novo: iControllerEntidade;
    function Alterar: iControllerEntidade;
    function Excluir: iControllerEntidade;
    function ListarPorDescricao(aDescricao: String): iControllerEntidade;
    function ListarPorCodigo(aCodigo: Integer): iControllerEntidade;
    function DataSet: TDataSet;
    function ProximoCodigo: Integer;
  end;


  iControllerUsuario = interface(iControllerEntidade)
    ['{50A314CF-88F8-49DA-B4DA-42D058607B4C}']
    function ListarComboBox: TStringList;
    function GravarImagem: iControllerUsuario;
    function GravarSenha: iControllerUsuario;
    function CODIGO(aValue: Integer): iControllerUsuario; overload;
    function USUARIO(aValue: String): iControllerUsuario; overload;
    function SENHA(aValue: String): iControllerUsuario; overload;
    function IMAGEM(aValue: String): iControllerUsuario; overload;
    function IDADM(aValue: Integer): iControllerUsuario; overload;
    function ATIVO(aValue: Integer): iControllerUsuario; overload;
    function ESQUEMA(aValue: Integer): iControllerUsuario; overload;
    function ESQUEMA: Integer; overload;
    function CODIGO: Integer; overload;
    function USUARIO: String; overload;
    function SENHA: String; overload;
    function IMAGEM: String; overload;
    function IDADM: Integer; overload;
    function ATIVO: Integer; overload;
    function DCATI: string;
  end;

  iControllerUsuarioLogado = interface
    ['{1FE77371-3CA5-4146-906D-4B2A484077A6}']
    function ValidarUsuario(pNome, pSenha: string): Boolean;
    function AtualizarDados: iControllerUsuarioLogado;
    function Dataset: TDataSet;
    function CODIGO: Integer;
    function USUARIO: String;
    function SENHA: String;
    function IMAGEM: String;
    function IDADM: Integer;
    function ATIVO: Integer;
    function ESQUEMA: Integer;
  end;

  iControllerEmpresa = interface
    ['{9B23890A-B0DA-4E12-B217-215AA893FFFE}']
    function RecuperarEmpresa: iControllerEmpresa;
    function GravarFicha: iControllerEmpresa;
    function GravarAutorizacao(aValue: String): iControllerEmpresa;
    function DataSet: TDataSet;
    function CODIGO(aValue: Integer): iControllerEmpresa; overload;
    function FANTASIA(aValue: string): iControllerEmpresa; overload;
    function CGC(aValue: string): iControllerEmpresa; overload;
    function PCMULTAS(aValue: Double): iControllerEmpresa; overload;
    function PCJUROS(aValue: Double): iControllerEmpresa; overload;
    function PCHONORARIOS(aValue: Double): iControllerEmpresa; overload;
    function ULTSAG(aValue: TDateTime): iControllerEmpresa; overload;
    function NMCONTATO(aValue: string): iControllerEmpresa; overload;
    function TELCONTATO(aValue: string): iControllerEmpresa; overload;
    function MAILCONTATO(aValue: string): iControllerEmpresa; overload;
    function STGRUENCCT(aValue: string): iControllerEmpresa; overload;
    function FASEAJUIZ(aValue: string): iControllerEmpresa; overload;
    function DTRECSLDRNP(aValue: TDateTime): iControllerEmpresa; overload;
    function DTRCCMPER(aValue: TDateTime): iControllerEmpresa; overload;
    function PCREDAPL(aValue: Double): iControllerEmpresa; overload;
    function DTLIMRED(aValue: TDateTime): iControllerEmpresa; overload;
    function VLLIMEXI(aValue: Double): iControllerEmpresa; overload;
    function NMREL(aValue: string): iControllerEmpresa; overload;
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

  iControllerCota = interface
    ['{FC8A360F-992F-430D-A7EF-AB3342564B18}']
    function PesquisarGrupoSeqCota(pGrupo, pSeq, pCota: String): iControllerCota;
    function PesquisarNome(pNome: String): iControllerCota;
    function PesquisarCpfCnpj(pInscricao: String): iControllerCota;
    function RetornarCotasGrupo(pGrupo: String): iControllerCota;
    function Retornainadimplentes(Pencct, pFaseAjuiz: String): iControllerCota;
    function RetornaRNP(Pencct: String): iControllerCota;
    function RetornaSaldoRNP(pInicio, pFim: Integer): String;
    function RetornaCotasRNP(pInicio, pFim: Integer): iControllerCota;
    function RetornaRateioFuturo(pGrupo: String): iControllerCota;
    function AlterarEndereco: iControllerCota;
    function AlterarSitCota: iControllerCota;
    function Dataset: TDataSet;
    function TemDados: Boolean;
    function Proximo: Boolean;
    function GRUPO: String; overload;
    function SEQ: String; overload;
    function COTA: String; overload;
    function GRUPO(aValue: String): iControllerCota; overload;
    function SEQ(aValue: String): iControllerCota; overload;
    function COTA(aValue: String): iControllerCota; overload;
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
    function TELEFONE(aValue: String): iControllerCota; overload;
    function ENDERECO(aValue: String): iControllerCota; overload;
    function BAIRRO(aValue: String): iControllerCota; overload;
    function CIDADE(aValue: String): iControllerCota; overload;
    function ESTADO(aValue: String): iControllerCota; overload;
    function CEP(aValue: String): iControllerCota; overload;
    function CELULAR(aValue: String): iControllerCota; overload;
    function EMAIL(aValue: String): iControllerCota; overload;
    function SIT_COBR(aValue: String): iControllerCota; overload;
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

  iControllerPagamentos = interface
    ['{2EA0B2A0-58A1-4A1B-87F0-34C5275DBBA6}']
    function RetornaListaAgentes: TStringList;
    function RetornaListaTipoDocumento: TStringList;
    function RetornaNovoDocumentoAgente(pAgente, pTipo, pHistorico: String; pContab: TDateTime; pValor: Double): String;
    function RetornaDocumentoAgente(pAgente, pTipo, pHistorico: String; pContab: TDateTime): String;
    function RetornaNovoAviso(pGrupo: String): Integer;
    function RetornaPagamentosCota(pGrupo, pSeq, pCota: String): iControllerPagamentos;
    function RetornaPagamentosDataBase(pIni, pFim: TDateTime): iControllerPagamentos;
    function RetornaVlrBemApreendidoCota(pGrupo, pSeq, pCota: String): Double;
    function RetornaPagamentosDevolucaoCota(pGrupo, pSeq, pCota: String; pInicio, pLimite: TDateTime): iControllerPagamentos;
    function IncluirComissaoPermanencia(pAgente, pNrDoc, pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pValor: Double): iControllerPagamentos;
    function IncluirRendimentoRnp(pAgente, pNrDoc, pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pValor: Double): iControllerPagamentos;
    function IncluirPagamentoRnp(pAgente, pNrDoc, pGrupo, pSeq, pCota, pTipo: String; pContab, pOcorrencia: TDateTime; pValor: Double): iControllerPagamentos;
    function IncluirSaldoRecomposicaoRnp(pAgente, pNrDoc, pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pSaldo: Double): iControllerPagamentos;
    function IncluirRateioRecebimento(pAgente, pNrDoc, pGrupo, pSeq, pCota: String; pDataCalculo: TDateTime; pSaldo: Double): iControllerPagamentos;
    function ExcluirComissaoPermanencia(pAgente, pNrDoc: string): iControllerPagamentos;
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

  iControllerReuniao = interface
    ['{FB1883EC-3FA0-4898-94D8-0DF7EECBA08D}']
    function RetornaReuniaoPagamento(pGrupo: String; pDtPag: TDateTime): iControllerReuniao;
    function RetornaReuniaoGrupo(pGrupo: String): iControllerReuniao;
    function Dataset: TDataSet;
    function DATA_REU: TDateTime;
    function NRO_REU: string;
  end;

  iControllerPrecoBem = interface
    ['{370185D2-5BD4-4AA4-AFEA-937986015FB5}']
    function RetornaPrecoBemData(pBem, pFilial: String; pData: TDateTime): iControllerPrecoBem;
    function RetornaPrecoBem(pBem, pFilial: String): iControllerPrecoBem;
    function Dataset: TDataSet;
    function PRE_TABE: Double;
    function PRE_REAL: Double;
  end;

  iControllerGrupo = interface
    ['{C505478D-4701-49B0-A72D-7B106EDC8C01}']
    function RetornaGrupo(pGrupo: string): iControllerGrupo;
    function RetornaListaGrupos: iControllerGrupo;
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

  iControllerBem = interface
    ['{5F435D8E-928A-410A-BC4C-D1E9BE7A0F4D}']
    function RetornaBem(pBem: string): iControllerBem;
    function Dataset: TDataSet;
    function DESCRIC: string;
    function DCTIPOBEM: string;
    function DCFABBEM: string;
  end;

  iControllerPendencia = interface
    ['{06A87528-32A1-41C9-890F-D03203FF1B96}']
    function RetornaPendenciaCota(pGrupo, pSeq, pCota: String): iControllerPendencia;
    function RetornaAviso(pGrupo, pSeq, pCota, pAviso: String): iControllerPendencia;
    function Novo: iControllerPendencia;
    function Excluir: iControllerPendencia;
    function ExcluirSQG: iControllerPendencia;
    function ProximoAviso: String;
    function DataSet: TDataSet;
    function GRUPO(aValue: String): iControllerPendencia;
    function SEQ(aValue: String): iControllerPendencia;
    function COTA(aValue: String): iControllerPendencia;
    function AVISO(aValue: String): iControllerPendencia; overload;
    function TIPO_MOV(aValue: String): iControllerPendencia; overload;
    function AG_COBRA(aValue: String): iControllerPendencia;
    function D_VENCTO(aValue: TDateTime): iControllerPendencia; overload;
    function PCNOR(aValue: Double): iControllerPendencia; overload;
    function P_RATEIO(aValue: Double): iControllerPendencia; overload;
    function F_AQUISI(aValue: Double): iControllerPendencia; overload;
    function ADMINIST(aValue: Double): iControllerPendencia; overload;
    function F_RESERV(aValue: Double): iControllerPendencia; overload;
    function OUTROS(aValue: Double): iControllerPendencia; overload;
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

  iControllerFaseJuridica = interface
    ['{5E80C171-3005-474F-B3DF-0E9B84570553}']
    function RetornaFasesCota(pGrupo, pSeq, pCota: String): iControllerFaseJuridica;
    function RetornaUmaFaseCota(pGrupo, pSeq, pCota, pFase: String): iControllerFaseJuridica;
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

  iControllerCredito = interface
    ['{A0D4B75A-4D84-4E71-BBE0-B3923E990081}']
    function RetornaCreditosCota(pGrupo, pCota: String): iControllerCredito;
    function RetornaUmCreditoCota(pGrupo, pCota, pCredito: String): iControllerCredito;
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

  iControllerBemAlienado = interface
    ['{949F9F90-1756-4816-9FD0-CE548E821D9F}']
    function RetornaBensAlienadosCota(pGrupo, pCota: String): iControllerBemAlienado;
    function RetornaBemAlienado(pGrupo, pCota, pChassis: String): iControllerBemAlienado;
    function DataSet: TDataSet;
    function NR_CHASS: String;
  end;

  iControllerAgenda = interface
    ['{3DC392B7-5816-47C0-A497-E53EC2BF3B0E}']
    function RetornaAgendaUsuarioPeriodo(pUsuario: Integer; pInicio, pFim: TDateTime): iControllerAgenda;
    function AlterarPrioridade(pCodigo, pPrioridade: Integer): iControllerAgenda;
    function AlterarStatus(pCodigo, pStatus: Integer): iControllerAgenda;
    function Novo: iControllerAgenda;
    function Alterar: iControllerAgenda;
    function Excluir: iControllerAgenda;
    function ProximoCodigo: Integer;
    function DataSet: TDataSet;
    function CODIGO(aValue: Integer): iControllerAgenda; overload;
    function CODIGO: Integer; overload;
    function DTAGE(aValue: TDateTime): iControllerAgenda; overload;
    function DTAGE: TDateTime; overload;
    function PRIORIDADE(aValue: Integer): iControllerAgenda; overload;
    function PRIORIDADE: Integer; overload;
    function CONTRATO(aValue: String): iControllerAgenda; overload;
    function CONTRATO: String; overload;
    function USUARIO(aValue: Integer): iControllerAgenda; overload;
    function USUARIO: Integer; overload;
    function STATUS(aValue: Integer): iControllerAgenda; overload;
    function STATUS: Integer; overload;
    function GRUPO(aValue: String): iControllerAgenda; overload;
    function GRUPO: String; overload;
    function SEQ(aValue: String): iControllerAgenda; overload;
    function SEQ: String; overload;
    function COTA(aValue: String): iControllerAgenda; overload;
    function COTA: String; overload;
    function OBS(aValue: TMemoryStream): iControllerAgenda; overload;
    function OBS: TMemoryStream; overload;
    function DCPRIORIDADE: String; overload;
    function NMUSUARIO: String; overload;
    function NMCOTA: String; overload;
    function DCSTATUS: String; overload;
  end;

  { iControllerCotacaoMoeda }

  iControllerCotacaoMoeda = interface
    ['{E392DA0F-823D-47C3-9D4E-D6795085628E}']
    procedure GravarCotacoes;
    function GerarDatasetCotacoes: TDataSet;
    function AlternarStatusCotacao(pCotacao: integer): iControllerCotacaoMoeda;
    function CalcularCotacoes: iControllerCotacaoMoeda;
    function GerarListaCotacoes(Pinicio, Pfim: Tdatetime; Pconsiderasabado, Pconsideradomingo: Boolean): iControllerCotacaoMoeda;
    procedure AtualizarListBox(var pListBox: TCheckListBox);
    function Dataset: TDataSet;
    function ListarComboBox: TStringList;
    function Cotacaomoeda(Pmoeda: String; Pdata: Tdatetime): Double;
    function UltimaCotacaoMoeda(pMoeda: string): iControllerCotacaoMoeda;
    function ListarCotacoesMoeda(pMoeda: string; pData: TDateTime): iControllerCotacaoMoeda;
    function NovaCotacaoMoeda(pMoeda: string; pData: TDateTime; pCotacao: Double): iControllerCotacaoMoeda;
    function MOEDA: String; overload;
    function MOEDA(avalue: String): iControllerCotacaoMoeda; overload;
    function INDICE(aValue: Double): iControllerCotacaoMoeda;
    function DATA: TDateTime;
    function COTACAO: Double;
    function DIAS: Integer;
  end;

  iControllerTotal = interface
    ['{373C8009-2D1B-45B2-BB87-7F2EC82413F7}']
    function CriarTabela: iControllerTotal;
    function TabelaExiste: Boolean;
    function Novo: iControllerTotal;
    function ApagaDados: iControllerTotal;
    function RetornaTotal: iControllerTotal;
    function AcumularInadimplente: iControllerTotal;
    function AcumularRnp: iControllerTotal;
    function Acumularrateiofuturo: Icontrollertotal;
    procedure AtualizarRnp;
    function Gravar: iControllerTotal;
    function DataSet: TDataSet;
    function DTCALC(aValue: TDateTime): iControllerTotal;
    function QTDINAGRU(aValue: Integer): iControllerTotal;
    function QTDINACOTA(aValue: Integer): iControllerTotal;
    function QTDRNPGRU(aValue: Integer): iControllerTotal;
    function QTDRNPCOTA(aValue: Integer): iControllerTotal;
    function QTDRATGRU(aValue: Integer): iControllerTotal;
    function BEMAPREENDIDO(aValue: Double): iControllerTotal;
    function VLRJURIDICO(aValue: Double): iControllerTotal;
    function VLRMEDIACAO(aValue: Double): iControllerTotal;
    function VLRRNP(aValue: Double): iControllerTotal;
    function VLRRAT(aValue: Double): iControllerTotal;
  end;

  iControllerTotalGrupo = interface
    ['{2474FEE6-6883-40C7-BD68-7B0C6A8E2536}']
    function CriarTabela: iControllerTotalGrupo;
    function TabelaExiste: Boolean;
    function Novo: iControllerTotalGrupo;
    function ApagarDados: iControllerTotalGrupo;
    function ListaTodos: iControllerTotalGrupo;
    function RetornaGrupo(pGrupo: String): iControllerTotalGrupo;
    function Gravar: iControllerTotalGrupo;
    function AcumularInadimplentes: iControllerTotalGrupo;
    function AcumularRnp: iControllerTotalGrupo;
    function AcumularTotalFator: iControllerTotalGrupo;
    function AcumularRateioFuturo: iControllerTotalGrupo;
    procedure AtualizarRnp;
    function TemDados: Boolean;
    function Proximo: Boolean;
    function DataSet: TDataSet;
    function GRUPO(aValue: string): iControllerTotalGrupo; overload;
    function REGAPLIC(aValue: string): iControllerTotalGrupo; overload;
    function DTCALC(aValue: TDateTime): iControllerTotalGrupo;
    function DTULTASS(aValue: TDateTime): iControllerTotalGrupo; overload;
    function DTENCCT(aValue: TDateTime): iControllerTotalGrupo; overload;
    function DTCMPER(aValue: TDateTime): iControllerTotalGrupo; overload;
    function TXPER(aValue: Double): iControllerTotalGrupo; overload;
    function REGAPLIC: String; overload;
    function DTULTASS: TDateTime; overload;
    function DTENCCT: TDateTime; overload;
    function DTCMPER: TDateTime; overload;
    function TXPER: Double; overload;
    function MULRESGRU(aValue: Double): iControllerTotalGrupo;
    function MULRESADM(aValue: Double): iControllerTotalGrupo;
    function QTDINA(aValue: Integer): iControllerTotalGrupo;
    function QTDRNP(aValue: Integer): iControllerTotalGrupo;
    function BEMAPREENDIDO(aValue: Double): iControllerTotalGrupo;
    function VLRJURIDICO(aValue: Double): iControllerTotalGrupo;
    function VLRMEDIACAO(aValue: Double): iControllerTotalGrupo;
    function VLRRNP(aValue: Double): iControllerTotalGrupo;
    function TOTALFATOR(aValue: Double): iControllerTotalGrupo; overload;
    function VLRRF(aValue: Double): iControllerTotalGrupo;
    function GRUPO: String; overload;
    function VLINA: double;
    function TOTALFATOR: double; overload;
  end;

  iControllerInadimplente = interface
    ['{498DA312-4DD0-41AA-A55C-37C795FE245C}']
    function CriarTabela: iControllerInadimplente;
    function TabelaExiste: Boolean;
    function Novo: iControllerInadimplente;
    function ApagarDados: iControllerInadimplente;
    function RetornaInadimplentes: iControllerInadimplente;
    function RetornaInadimplentesGrupo(pGrupo: String): iControllerInadimplente;
    function Gravar: iControllerInadimplente;
    function InadimplentesSag: TDataSet;
    function DataSet: TDataSet;
    function GRUPO(aValue: String): iControllerInadimplente;
    function SEQ(aValue: String): iControllerInadimplente;
    function COTA(aValue: String): iControllerInadimplente;
    function DTAJUIZ(aValue: TDateTime): iControllerInadimplente;
    function PERCAMORT(aValue: Double): iControllerInadimplente;
    function VLRRECEBER(aValue: Double): iControllerInadimplente;
    function VLRBEM(aValue: Double): iControllerInadimplente;
    function BEMAPREENDIDO(aValue: Double): iControllerInadimplente;
  end;

  iControllerRnp = interface
    ['{B599AF38-DB47-43BD-BF54-D5B19213A640}']
    function CriarTabela: iControllerRnp;
    function CriarTabelaSaldo(pDtRecSld: TDateTime): iControllerRnp;
    function CriarTabelaCheck: iControllerRnp;
    function TabelaExiste: Boolean;
    function TabelaSaldoExiste: Boolean;
    function TabelaCheckExiste: Boolean;
    function Novo: iControllerRnp;
    function NovoCheck(pGrupo, pSeq, pCota: String; pRel, pPla: Integer;pRecRel, pRecPla, pComRel, pComPla: Double): iControllerRnp;
    function GravarCheck(pGrupo, pSeq, pCota: String; pRel, pPla: Integer;pRecRel, pRecPla, pComRel, pComPla: Double): iControllerRnp;
    function ApagarDados: iControllerRnp;
    function ApagarCheck: iControllerRnp;
    function RetornaRnp: iControllerRnp;
    function RetornaCheck: iControllerRnp;
    function RetornaSaldoInicialRnp: Double;
    function RetornaSaldoInicialSiacon: Double;
    function RetornaComissaoPermanencia(pDataCalculo: TDateTime): iControllerRnp;
    function RetornaSomenteRnp: iControllerRnp;
    function RetornaRnpRateiosFuturos: iControllerRnp;
    function RetornaUmRnp(pGrupo, pSeq, pCota: String): iControllerRnp;
    function RetornaUmCheck(pGrupo, pSeq, pCota: String): iControllerRnp;
    function RetornaRnpGrupo(pGrupo: String): iControllerRnp;
    function RetornaRecomposicaoSaldosGrupo(pGrupo: String): iControllerRnp;
    function RetornaRecomposicaoSaldosTodos: Icontrollerrnp;
    function TotalizaRecomposicaoRnp: Icontrollerrnp;
    function Gravar: iControllerRnp;
    function GravarRateioFuturo: iControllerRnp;
    function GravarSaldoRnp: iControllerRnp;
    function GravarSaldoSiaconRnp(pGrupo, pSeq, pCota: String; pSiacon: Double): iControllerRnp;
    function SaldoDataBase(pGRupo, pSeq, pCota: String; pDataLimite: TDateTime): Currency;
    function SaldoRnp31Dez21(pGRupo, pSeq, pCota: String): Currency;
    function CompararSAG: TDataSet; overload;
    function CompararSAG(pArquivoSag: TStringList): TDataSet; overload;
    function RnpSag: TDataSet;
    function DataSet: TDataSet;
    function TemDados: Boolean;
    function Proximo: Boolean;
    function GRUPO(aValue: String): iControllerRnp; overload;
    function SEQ(aValue: String): iControllerRnp; overload;
    function COTA(aValue: String): iControllerRnp; overload;
    function PERCAMORT(aValue: Double): iControllerRnp;
    function VLRRNP(aValue: Double): iControllerRnp; overload;
    function VLRRNP: Double; overload;
    function VLRBEM(aValue: Double): iControllerRnp;
    function RATFUT(aValue: Double): iControllerRnp;
    function PCRATEIO(aValue: Double): iControllerRnp;
    function GRUPO: String; overload;
    function SEQ: String; overload;
    function COTA: String; overload;
    function FATOR: double;
    function TXPER: double;
    function VLMIN: double;
    function NOME: String;
  end;

  iControllerTabularEncerrados = interface
    ['{B3B84DFF-47A6-4C4F-B31E-B79AEB4CF076}']
    function LIMITEMINIMO(aValue: Double): iControllerTabularEncerrados;
    function DATALIMITE(aVaue: TDateTime): iControllerTabularEncerrados;
    function DATAREF(aValue: Integer): Icontrollertabularencerrados;
    function DATASEP(aValue: TDateTime): Icontrollertabularencerrados;
    function ANDAMENTO(aValue: TAndamento): iControllerTabularEncerrados;
    function LOG(aValue: TAndamento): iControllerTabularEncerrados;
    function PBINICIO(aValue: TPBMaximo): iControllerTabularEncerrados;
    function PBPOSICAO(aValue: TPBPosicao): iControllerTabularEncerrados;
    function RetornarSaldoDataBase: Currency;
    function CalcularSaldoRnpCota(pGrupo, pSeq, pCota: String; pCCDev: iModelBufferDataset): Double;
    function GravarAplicacaoRnp(pAgente, pTipoDoc, pHistorico: String; pDataBase: TDateTime; pValor: Double ): iControllerTabularEncerrados;
    function CalcularSaldoRnpDataBase(pSaldoContabil: Double ): TDataSet;
    function ResumoCalculo: TDataSet;
    procedure AtualizarSaldoRnp;
    procedure Tabular;
  end;

  iControllerComissaoPermanencia = interface
    ['{F9488D19-7929-4B7A-88E7-95EB3E185859}']
    function CriarTabela: iControllerComissaoPermanencia;
    function TabelaExiste: Boolean;
    function ListarComissoes: iControllerComissaoPermanencia;
    function ListarPorCodigo(pCodigo: Integer): iControllerComissaoPermanencia;
    function ExcluirComissaoPermanencia(pCodigo: Integer): iControllerComissaoPermanencia;
    function DataSet: TDataSet;
    function LOG(aValue: TAndamento): iControllerComissaoPermanencia;
    function AGENTE(aValue: String): iControllerComissaoPermanencia;
    function TPDOC(aValue: String): iControllerComissaoPermanencia;
    function DOCUMENTO(aValue: String): iControllerComissaoPermanencia;
    function HISTORICO(aValue: String): iControllerComissaoPermanencia;
    function DATACALCULO(aValue: TDateTime): iControllerComissaoPermanencia;
    function SALDOINICIAL: Double;
    function COMISSAO: Double;
    function SALDOFINAL: Double;
    function Calcular: TDataSet;
    procedure Gravar;
  end;

  iControllerItemComissaoPermanencia = interface
    ['{7F4AF43E-63C8-495F-B6C8-6865EA616E77}']
    function CriarTabela: iControllerItemComissaoPermanencia;
    function TabelaExiste: Boolean;
    procedure NovoItem;
    function ListarItensComissao(pCmPer: Integer): iControllerItemComissaoPermanencia;
    function ListarItensComissaoGrupo(pCmPer: Integer; pGrupo: String): iControllerItemComissaoPermanencia;
    function ListarItensComissaoSinteticoGrupo(pCmPer: Integer): iControllerItemComissaoPermanencia;
    function ExisteCalculoCota(pGrupo, pSeq, pCota: String): iControllerItemComissaoPermanencia;
    function DataSet: TDataSet;
    function TemDados: Boolean;
    function Proximo: Boolean;
    function NovoCodigo: Integer;
    procedure AlteraCmPer(pCmPer: Integer);
    procedure ApagaCalculo;
    procedure ApagaItens(pCalculo: Integer);
    function CODIGO(aValue: Integer): iControllerItemComissaoPermanencia;
    function CMPER(aValue: Integer): iControllerItemComissaoPermanencia;
    function GRUPO(aValue: String): iControllerItemComissaoPermanencia; overload;
    function SEQ(aValue: String): iControllerItemComissaoPermanencia; overload;
    function COTA(aValue: String): iControllerItemComissaoPermanencia; overload;
    function SDINICIAL(aValue: Double): iControllerItemComissaoPermanencia; overload;
    function COMISSAO(aValue: Double): iControllerItemComissaoPermanencia; overload;
    function SDFINAL(aValue: Double): iControllerItemComissaoPermanencia; overload;
    function SDFINAL: Double; overload;
    function SDINICIAL: Double; overload;
    function GRUPO: String; overload;
    function SEQ: String; overload;
    function COTA: String; overload;
    function COMISSAO: Double; overload;
  end;

  iControllerFichaPagamentos = interface
    ['{8CEE34F3-1A9F-41D0-8473-26F328C8A492}']
    function GRUPO(aValue: String): iControllerFichaPagamentos;
    function SEQ(aValue: String): iControllerFichaPagamentos;
    function COTA(aValue: String): iControllerFichaPagamentos;
    function DATALIMITE(aValue: TDateTime): iControllerFichaPagamentos;
    function DTRECOMPOESALDORNP(aValue: TDateTime): iControllerFichaPagamentos;
    function SaldoInicialRnp: Double;
    function CalcularSaldoDevedorCota: TDataSet;
    function MontarPagamentos: TDataSet;
    function MontarPendencias: TDataSet;
    function RetornarTotaisCota: TDataSet;
    function ContaCorrenteDevolucoes: TDataSet;
  end;

  iControllerSag = interface
    ['{33234C0D-E957-4389-A02A-BB2B21B5182B}']
    function CNPJADM(aValue: String): iControllerSag;
    function DATABASE(aValue: TDateTime): iControllerSag;
    function REMESSA(aValue: String): iControllerSag;
    function TELCONTATO(aValue: String): iControllerSag;
    function NOMECONTATO(aValue: String): iControllerSag;
    function MAILCONTATO(aValue: String): iControllerSag;
    function NOMEARQUIVO(aValue: String): iControllerSag;
    function LOG(aValue: TAndamento): iControllerSag;
    function GERARSAG: iControllerSag;
  end;

  iControllerDemonstrativo = interface
    ['{179D2103-FEC1-4F9E-A809-C590934FA29E}']
    function CriarTabela: iControllerDemonstrativo;
    function TabelaExiste: Boolean;
    function Novo: iControllerDemonstrativo;
    function RetornaDemonstrativo: iControllerDemonstrativo;
    function RetornaDemonstrativoDataBase: iControllerDemonstrativo;
    function ImportarDemonstrativosSiacon: iControllerDemonstrativo;
    function GravarValorConta: iControllerDemonstrativo;
    function DataSet: TDataSet;
    function GRUPO(aValue: String): iControllerDemonstrativo;
    function DEMONSTRATIVO(aValue: String): iControllerDemonstrativo;
    function DATABASE(aValue: TDateTime): iControllerDemonstrativo;
    function CONTACOSIF(aValue: String): iControllerDemonstrativo;
    function SALDOCONTA(aValue: Double): iControllerDemonstrativo;
    function VLRPERIODO(aValue: Double): iControllerDemonstrativo;
    function VLRACUMULADO(aValue: Double): iControllerDemonstrativo;
  end;

  { iControllerSaldoRnpDataBase }

  iControllerSaldoRnpDataBase =  interface
    ['{7A5ED1E8-ADD7-44E1-955B-51D03B81E9ED}']
    function DATABASE(aValue: TDateTime): iControllerSaldoRnpDataBase;
    function DATAREF(aValue: Integer): iControllerSaldoRnpDataBase;
    function DATASEP(aValue: TDateTime): iControllerSaldoRnpDataBase;
    function LOG(aValue: TAndamento): iControllerSaldoRnpDataBase;
    function RetornarSaldoDataBase: Currency;
    function GravarAplicacaoRnp(pAgente, pTipoDoc, pHistorico: String; pDataBase: TDateTime; pValor: Double ): iControllerSaldoRnpDataBase;
    function CalcularSaldoRnpDataBase(pSaldoContabil: Double): iControllerSaldoRnpDataBase;
    function Dataset: TDataSet;
  end;

  iControllerRateioPagamentos = interface
    ['{38E20008-A346-448F-A2E3-7BE22F77719B}']
    function LOG(aValue: TAndamento): iControllerRateioPagamentos;
    function DATABASE(aValue: TDateTime): iControllerRateioPagamentos;
    function AGENTE(aValue: String): iControllerRateioPagamentos;
    function TIPODOC(aValue: String): iControllerRateioPagamentos;
    function HISTORICO(aValue: String): iControllerRateioPagamentos;
    function RateioRecebimentos(pDataset: TDataSet): iControllerRateioPagamentos;
    function Dataset: TDataset;
    procedure GravarRateio;
  end;

  iControllerPgRnp = interface
    ['{C4E8D581-3071-417C-987C-E96C00F33B7D}']
    function TabelaExiste: Boolean;
    function CriarTabela: iControllerPgRnp;
    function Novo: iControllerPgRnp;
    function Gravar: iControllerPgRnp;
    function GravarPagamento: iControllerPgRnp;
    function GravarStatus: iControllerPgRnp;
    function DataSet: TDataSet;
    function TemDados: Boolean;
    function Proximo: Boolean;
    function RetornaPagamentoCota: iControllerPgRnp;
    function RetornaStatus: iControllerPgRnp;
    function BaixarPagamentosDataset(pAgente, pTipoDoc, pHistorico: String; pContab: TDateTime; pTotal: Double; pDataSet: TDataSet): iControllerPgRnp;
    function GerarExportacao(pEmp, pFilial, pPartida, pContra1, pContra2: String; pContab: TDateTime; pPagtos: TDataSet; var pArquivo: TStringList; pMarcar: Boolean): iControllerPgRnp;
    function PesquisarAsvr(pDtBase: TDateTime): TDataset;
    function GerarAsvr(pTipo, pCnpj: String; pDtBase: TDateTime;
      pArquivo: TStringList; pDataset: TDataset): iControllerPgRnp;
    function Excluir: iControllerPgRnp;
    function AtualizarValorPagar: iControllerPgRnp;

    function CODIGO(aValue: Integer): iControllerPgRnp; overload;
    function CODIGO: Integer; overload;
    function GRUPO(aValue: String): iControllerPgRnp; overload;
    function SEQ(aValue: String): iControllerPgRnp; overload;
    function COTA(aValue: String): iControllerPgRnp; overload;
    function GRUPO: String; overload;
    function SEQ: String; overload;
    function COTA: String; overload;
    function STATUS(aValue: Integer): iControllerPgRnp; overload;
    function STATUS: Integer; overload;
    function VALOR(aValue: Double): iControllerPgRnp; overload;
    function VALOR: Double; overload;
    function DTPEDIDO(aValue: TDateTime): iControllerPgRnp; overload;
    function DTPEDIDO: TDateTime; overload;
    function DTPROG(aValue: TDateTime): iControllerPgRnp; overload;
    function DTPROG: TDateTime; overload;
    function DTPAGTO(aValue: TDateTime): iControllerPgRnp; overload;
    function DTPAGTO: TDateTime; overload;
    function FRMPG(aValue: Integer): iControllerPgRnp; overload;
    function FRMPG: Integer; overload;
    function TIPOPIX(aValue: Integer): iControllerPgRnp; overload;
    function TIPOPIX: Integer; overload;
    function CHAVEPIX(aValue: String): iControllerPgRnp; overload;
    function CHAVEPIX: String; overload;
    function BANCO(aValue: String): iControllerPgRnp; overload;
    function BANCO: String; overload;
    function AGENCIA(aValue: String): iControllerPgRnp; overload;
    function AGENCIA: String; overload;
    function CONTA(aValue: String): iControllerPgRnp; overload;
    function CONTA: String; overload;
    function OBS(aValue: String): iControllerPgRnp; overload;
    function OBS: String; overload;
    function DCSIT: String;
  end;

  iControllerRelatorio = interface
    ['{006295FD-0E04-40D2-A278-E6BC00DE1775}']
    function MovimentosNoPeriodo(pInicio, pFim: TDateTime): TDataSet;
    function MovimentosPeriodoDetalhe(pAgente, pDocum: String; pContab: TDateTime): TDataSet;
    function RelatorioComissoes(pPeriodo:Integer; pFil: Integer = 0): TDataset;
    function ProducaoVendas(pInicio, pFim: TDateTime; pAgente, pEquipe, pFilial: Integer): TDataSet;
    function CancelamentosNoPeriodo(pInicio, pFim: TDateTime): TDataSet;
    function VendasAgente(pAgente: Integer): TDataSet;
    function ResumoVendas(pPeriodo: Integer): TDataSet;
    function PagamentosRnpPeriodo(pInicio, pFim: TDateTime): TDataSet;
  end;

    iControllerAdmcon = interface
    ['{604B1CD9-E779-4E87-BA71-940030994B27}']
    function ListaPorCodigo(pCodigo: Integer): TDataSet;
    function ListaPorNome(pNome: String): TDataSet;
    function ListaComboBox: TStringList;
    function Executar(pModo: TpModoManutencao): iControllerAdmcon;
    function CODIGO: Integer; overload;
    function CODIGO(pValor: Integer): iControllerAdmcon; overload;
    function NOMEFANTASIA: String; overload;
    function NOMEFANTASIA(pValor: String): iControllerAdmcon; overload;
    function RAZAOSOCIAL: String; overload;
    function RAZAOSOCIAL(pValor: String): iControllerAdmcon; overload;
    function CNPJ: String; overload;
    function CNPJ(pValor: String): iControllerAdmcon; overload;
    function VIGENCIA: TDateTime; overload;
    function VIGENCIA(pValor: TDateTime): iControllerAdmcon; overload;
    function UNIDADE: Integer; overload;
    function UNIDADE(pValor: Integer): iControllerAdmcon; overload;
    function PCENTREGA: Double; overload;
    function PCENTREGA(pValor: Double): iControllerAdmcon; overload;
    function MESPER: Integer; overload;
    function MESPER(pValor: Integer): iControllerAdmcon; overload;
    function PCPER: Double; overload;
    function PCPER(pValor: Double): iControllerAdmcon; overload;
    function ACERTO: Integer; overload;
    function ACERTO(pValor: Integer): iControllerAdmcon; overload;
    function ULTFAIXA: Integer; overload;
    function ULTFAIXA(pValor: Integer): iControllerAdmcon; overload;
  end;

    iControllerFaixaComissao = interface
      ['{371F85C7-DB50-4657-A6CC-15B586134C4F}']
      function ListaPorCodigo(pCodigo: Integer): TDataSet;
      function ListaPorEmpresa(pEmpresa: Integer): TDataSet;
      function ListaComboBox(pEmpresa:Integer): TStringList;
      function Executar(pModo: TpModoManutencao): iControllerFaixaComissao;
      function CODIGO: Integer; overload;
      function CODIGO(pValor: Integer): iControllerFaixaComissao; overload;
      function EMPRESA: Integer; overload;
      function EMPRESA(pValor: Integer): iControllerFaixaComissao; overload;
      function DESCRICAO: String; overload;
      function DESCRICAO(pValor: String): iControllerFaixaComissao; overload;
      function MINIMO: Double; overload;
      function MINIMO(pValor: Double): iControllerFaixaComissao; overload;
      function MAXIMO: Double; overload;
      function MAXIMO(pValor: Double): iControllerFaixaComissao; overload;
    end;

    iControllerRegraComissao = interface
      ['{A25AF9E1-FDAF-4D65-9E1C-DB89C35B65C8}']
      function ListaParcelasFaixa(pEmpresa, pFaixa: Integer): TDataSet;
      function ListaParcela(pEmpresa, pFaixa, pParcela: Integer): TDataSet;
      function Executar(pModo: TpModoManutencao): iControllerRegraComissao;
      function EMPRESA: Integer; overload;
      function EMPRESA(pValor: Integer): iControllerRegraComissao; overload;
      function PARCELA: Integer; overload;
      function PARCELA(pValor: Integer): iControllerRegraComissao; overload;
      function FAIXA: Integer; overload;
      function FAIXA(pValor: Integer): iControllerRegraComissao; overload;
      function PCLIB: Integer; overload;
      function PCLIB(pValor: Integer): iControllerRegraComissao; overload;
      function PERCENTUAL: Double; overload;
      function PERCENTUAL(pValor: Double): iControllerRegraComissao; overload;
    end;

    iControllerFilial = interface
    ['{6CD213A5-7BAF-496F-A9D6-3CE7B143D88D}']
    function ListaPorCodigo(pCodigo: Integer): TDataSet;
    function ListaPorNome(pNome: String): TDataSet;
    function ListaComboBox: TStringList;
    function Executar(pModo: TpModoManutencao): iControllerFilial;
    function CODIGO: Integer; overload;
    function CODIGO(pValor: Integer): iControllerFilial; overload;
    function DESCRICAO: String; overload;
    function DESCRICAO(pValor: String): iControllerFilial; overload;
    function RESPONSAVEL: Integer; overload;
    function RESPONSAVEL(pValor: Integer): iControllerFilial; overload;
    function CODEXT: String; overload;
    function CODEXT(pValor: String): iControllerFilial; overload;
  end;

  iControllerEquipe = interface
    ['{1B54167A-B543-486D-88ED-F6E4FBC13CF6}']
    function ListaPorCodigo(pCodigo: Integer): TDataSet;
    function ListaPorNome(pNome: String): TDataSet;
    function ListaComboBox(pFilial: Integer=0): TStringList;
    function Executar(pModo: TpModoManutencao): iControllerEquipe;
    function CODIGO: Integer; overload;
    function CODIGO(pValor: Integer): iControllerEquipe; overload;
    function DESCRICAO: String; overload;
    function DESCRICAO(pValor: String): iControllerEquipe; overload;
    function FILIAL: Integer; overload;
    function FILIAL(pValor: Integer): iControllerEquipe; overload;
    function SUPERVISOR: Integer; overload;
    function SUPERVISOR(pValor: Integer): iControllerEquipe; overload;
  end;


  iControllerAgente = interface
    ['{DFA7179E-67CC-4215-A583-57587940CCF3}']
    function ListaPorCodigo(pCodigo: Integer): TDataSet;
    function ListaPorNome(pNome: String): TDataSet;
    function ListaComboBox(pEquipe: Integer = 0): TStringList;
    function ListaSupervisoresAtivosComboBox(pNivel: Integer): TStringList;
    function Executar(pModo: TpModoManutencao): iControllerAgente;
    function CODIGO: Integer; overload;
    function CODIGO(pValor: Integer): iControllerAgente; overload;
    function NOME: String; overload;
    function NOME(pValor: String): iControllerAgente; overload;
    function CPF: String; overload;
    function CPF(pValor: String): iControllerAgente; overload;
    function DDD: String; overload;
    function DDD(pValor: String): iControllerAgente; overload;
    function CELULAR: String; overload;
    function CELULAR(pValor: String): iControllerAgente; overload;
    function EQUIPE: Integer; overload;
    function EQUIPE(pValor: Integer): iControllerAgente; overload;
    function SUPERVISAO: Integer; overload;
    function SUPERVISAO(pValor: Integer): iControllerAgente; overload;
    function ATIVO: Integer; overload;
    function ATIVO(pValor: Integer): iControllerAgente; overload;
    function CDEXTERNO: String; overload;
    function CDEXTERNO(pValor: String): iControllerAgente; overload;
    function DCATIVO: String;
    function DCFIL: String;
    function DCEQP: String;
  end;

  iControllerNivelSupervisao = interface
    ['{BDA526FF-8A4D-4E6B-ABAA-7F7D55E496B6}']
    function ListaPorCodigo(pCodigo: Integer): TDataSet;
    function ListaPorNome(pNome: String): TDataSet;
    function ListaComboBox: TStringList;
    function CODIGO: Integer;
    function DESCRICAO: String;
  end;

  iControllerSituacaoContrato = interface
    ['{50866776-DAE9-4E52-92C5-0C2A07306711}']
    function ListaPorCodigo(pCodigo: Integer): TDataSet;
    function ListaPorNome(pNome: String): TDataSet;
    function ListaComboBox: TStringList;
    function CODIGO: Integer;
    function DESCRICAO: String;
  end;

  iControllerPeriodo = interface
    ['{AD4F80E2-54FE-4270-917A-4AF3E27E613B}']
    function ListaPorCodigo(pCodigo: Integer): TDataSet;
    function ListaPorNome(pNome: String): TDataSet;
    function ListaComboBox: TStringList;
    function ListaComboBoxCalculo: TStringList;
    function CalcularComissoes: iControllerPeriodo;
    function Executar(pModo: TpModoManutencao): iControllerPeriodo;
    function RetornaPeriodoAtual: iControllerPeriodo;
    function CODIGO: Integer; overload;
    function CODIGO(aValue: Integer): iControllerPeriodo; overload;
    function DESCRICAO: String;
    function DTINI: TDateTime;
    function DTFIM: TDateTime;
    function DTCAL: TDateTime; overload;
    function DTCAL(pValor: TDateTime): iControllerPeriodo; overload;
  end;

  iControllerVenda = interface
    ['{FE781201-38DB-44D8-BB70-BD4F494D917C}']
    function ListaPorCodigo(pCodigo: Integer): iControllerVenda;
    function ContratoJaInformado(pEmpresa: Integer; pContrato: String): Integer;
    function RetornaBem(pEmpresa: Integer; pCdBem: String): iControllerVenda;
    function RetornarVendas(itPsq: Integer; stPesq: String): iModelBufferDataset;
    function Executar(pModo: TpModoManutencao): iControllerVenda;
    function CancelarVenda(pCodigo: Integer; pData: TDateTime; pValor: Double): iControllerVenda;
    function Dataset: TDataset;
    function CODIGO: Integer;
    function EMPRESA: Integer; overload;
    function EMPRESA(pValor: Integer): iControllerVenda; overload;
    function CONTRATO: String; overload;
    function CONTRATO(pValor: String): iControllerVenda; overload;
    function AGENTE: Integer; overload;
    function AGENTE(pValor: Integer): iControllerVenda; overload;
    function DTVENDA: TDateTime; overload;
    function DTVENDA(pValor: TDateTime): iControllerVenda; overload;
    function PERIODO: Integer; overload;
    function PERIODO(pValor: Integer): iControllerVenda; overload;
    function CDBEM: String; overload;
    function CDBEM(pValor: String): iControllerVenda; overload;
    function DCBEM: String; overload;
    function DCBEM(pValor: String): iControllerVenda; overload;
    function VALOR: Double; overload;
    function VALOR(pValor: Double): iControllerVenda; overload;
    function SITUACAO: Integer; overload;
    function SITUACAO(pValor: Integer): iControllerVenda; overload;
    function DTCON: TDateTime; overload;
    function DTCON(pValor: TDateTime): iControllerVenda; overload;
    function NOME: String; overload;
    function NOME(pValor: String): iControllerVenda; overload;
    function DDD: String; overload;
    function DDD(pValor: String): iControllerVenda; overload;
    function FONE: String; overload;
    function FONE(pValor: String): iControllerVenda; overload;
    function TPPES: Integer; overload;
    function TPPES(pValor: Integer): iControllerVenda; overload;
    function CPFCNPJ: String; overload;
    function CPFCNPJ(pValor: String): iControllerVenda; overload;
    function GRUPO: String; overload;
    function GRUPO(pValor: String): iControllerVenda; overload;
    function COTA: Integer; overload;
    function COTA(pValor: Integer): iControllerVenda; overload;
    function DIAVENC: Integer; overload;
    function DIAVENC(pValor: Integer): iControllerVenda; overload;
    function VLRPAGO: Double; overload;
    function VLRPAGO(pValor: Double): iControllerVenda; overload;
    function NMEMP: String;
    function NMAGE: String;
    function DCSIT: String;
  end;

  iControllerParcelaComissao = interface
    ['{47A123C2-4693-4818-A430-B8AA2984CA5A}']
    function ListaPorCodigo(pVenda, pParcela: Integer): iControllerParcelaComissao;
    function ListaPorVenda(pVenda: Integer): TDataSet;
    function ExisteParcela(pEmpresa: Integer; pContrato: String; pParcela: Integer): Boolean;
    function RetornarParcelasPendentes(itPsq: Integer; stPesq: String): iModelBufferDataset;
    function Executar(pModo: TpModoManutencao): iControllerParcelaComissao;
    function VENDA: Integer; overload;
    function VENDA(pValor: Integer): iControllerParcelaComissao; overload;
    function PARCELA: Integer; overload;
    function PARCELA(pValor: Integer): iControllerParcelaComissao; overload;
    function DTVENC: TDateTime; overload;
    function DTVENC(pValor: TDateTime): iControllerParcelaComissao; overload;
    function PERIODO: Integer; overload;
    function PERIODO(pValor: Integer): iControllerParcelaComissao; overload;
    function RECEBER: Double; overload;
    function RECEBER(pValor: Double): iControllerParcelaComissao; overload;
    function RECEBIDO: Double; overload;
    function RECEBIDO(pValor: Double): iControllerParcelaComissao; overload;
    function PAGAR: Double; overload;
    function PAGAR(pValor: Double): iControllerParcelaComissao; overload;
    function PAGO: Double; overload;
    function PAGO(pValor: Double): iControllerParcelaComissao; overload;
    function DTREC: TDateTime; overload;
    function DTREC(pValor: TDateTime): iControllerParcelaComissao; overload;
  end;


  iControllerFactory = interface
    ['{7B3E5EA2-9523-4942-9AB0-CC63C6C166C1}']
    function Conexao(pBanco: Integer = 0): iModelConexao;
    function ClienteWS: iClienteWebService;
    function Query(aConexao: iModelConexao): iQueryRest;
    function Usuario: iControllerUsuario;
    function UsuarioLogado: iControllerUsuarioLogado;
    function Empresa: iControllerEmpresa;
    function Cota: iControllerCota;
    function Pagamentos: iControllerPagamentos;
    function Reuniao: iControllerReuniao;
    function PrecoBem: iControllerPrecoBem;
    function Grupo: iControllerGrupo;
    function Bem: iControllerBem;
    function Pendencia: iControllerPendencia;
    function FaseJuridica: iControllerFaseJuridica;
    function Credito: iControllerCredito;
    function BemAlienado: iControllerBemAlienado;
    function Agenda: iControllerAgenda;
    function CotacaoMoeda: iControllerCotacaoMoeda;
    function Total: iControllerTotal;
    function TotalGrupo: iControllerTotalGrupo;
    function Inadimplente: iControllerInadimplente;
    function RNP: iControllerRnp;
    function TabularEncerrados: iControllerTabularEncerrados;
    function ComissaoPermanencia: iControllerComissaoPermanencia;
    function ItemComissaoPermanencia: iControllerItemComissaoPermanencia;
    function FichaPagamentos: iControllerFichaPagamentos;
    function Sag: iControllerSag;
    function Demonstrativo: iControllerDemonstrativo;
    function SaldoRnpDataBase: iControllerSaldoRnpDataBase;
    function RateioPagamentos: iControllerRateioPagamentos;
    function PagamentosRnp: iControllerPgRnp;
    function Relatorios(pBanco: Integer = 0): iControllerRelatorio;
    function AdmCon: iControllerAdmcon;
    function FaixaComissao: iControllerFaixaComissao;
    function RegraComissao: iControllerRegraComissao;
    function Filial: iControllerFilial;
    function Equipe: iControllerEquipe;
    function Agente: iControllerAgente;
    function NivelSupervisao: iControllerNivelSupervisao;
    function SituacaoContrato: iControllerSituacaoContrato;
    function Periodo: iControllerPeriodo;
    function Venda: iControllerVenda;
    function ParcelaComissao: iControllerParcelaComissao;
 end;

implementation

end.

