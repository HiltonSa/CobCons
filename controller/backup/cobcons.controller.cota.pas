unit cobcons.controller.cota;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerCota }

    TControllerCota = class (TInterfacedObject, iControllerCota)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelCota;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerCota;

      function PesquisarGrupoSeqCota(pGrupo, pSeq, pCota: String): iControllerCota;
      function PesquisarNome(pNome: String): iControllerCota;
      function PesquisarCpfCnpj(pInscricao: String): iControllerCota;
      function RetornarCotasGrupo(pGrupo: String): iControllerCota;
      function AlterarEndereco: iControllerCota;
      function AlterarSitCota: iControllerCota;
      function Retornainadimplentes(Pencct, pFaseAjuiz: String): iControllerCota;
      function RetornaRNP(Pencct: String): iControllerCota;
      function RetornaSaldoRNP(pInicio, pFim: Integer): String;
      function RetornaCotasRNP(pInicio, pFim: Integer): iControllerCota;
      function RetornaRateioFuturo(pGrupo: String): iControllerCota;
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
      function TELEFONE(aValue: String): iControllerCota; overload;
      function ENDERECO(aValue: String): iControllerCota; overload;
      function BAIRRO(aValue: String): iControllerCota; overload;
      function CIDADE(aValue: String): iControllerCota; overload;
      function ESTADO(aValue: String): iControllerCota; overload;
      function CEP(aValue: String): iControllerCota; overload;
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


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerCota }

constructor TControllerCota.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Cota(fQuery);
end;

destructor TControllerCota.Destroy;
begin
  inherited Destroy;
end;

class function TControllerCota.New: iControllerCota;
begin
  Result := Self.Create;
end;

function TControllerCota.PesquisarGrupoSeqCota(pGrupo, pSeq, pCota: String
  ): iControllerCota;
begin
  Result := Self;
  FEntidade.PesquisarGrupoSeqCota(Pgrupo, Pseq, Pcota);
end;

function TControllerCota.PesquisarNome(pNome: String): iControllerCota;
begin
  Result := Self;
  FEntidade.PesquisarNome(Pnome);
end;

function TControllerCota.PesquisarCpfCnpj(pInscricao: String): iControllerCota;
begin
  Result := Self;
  FEntidade.PesquisarCpfCnpj(Pinscricao);
end;

function TControllerCota.RetornarCotasGrupo(pGrupo: String): iControllerCota;
begin
  Result := Self;
  FEntidade.RetornarCotasGrupo(Pgrupo);
end;

function TControllerCota.AlterarEndereco: iControllerCota;
begin
  Result := Self;
  FEntidade.AlterarEndereco;
end;

function TControllerCota.AlterarSitCota: iControllerCota;
begin
  Result := Self;
  FEntidade.AlterarSitCota;
end;

function TControllerCota.Retornainadimplentes(Pencct, pFaseAjuiz: String
  ): iControllerCota;
begin
  Result := Self;
  FEntidade.RetornaInadimplentes(pEncCt, Pfaseajuiz);
end;

function TControllerCota.RetornaRNP(Pencct: String): iControllerCota;
begin
  Result := Self;
  FEntidade.RetornaRNP(pEncCt);
end;

function TControllerCota.RetornaSaldoRNP(pInicio, pFim: Integer): String;
begin
  Result := FEntidade.RetornaSaldoRNP(pInicio, pFim);
end;

function TControllerCota.RetornaCotasRNP(pInicio, pFim: Integer
  ): iControllerCota;
begin
  Result := Self;
  FEntidade.RetornaCotasRNP(pInicio, pFim);
end;

function TControllerCota.RetornaRateioFuturo(pGrupo: String): iControllerCota;
begin
  Result := Self;
  FEntidade.RetornaRateioFuturo(Pgrupo);
end;

function TControllerCota.Dataset: TDataSet;
begin
  Result := FEntidade.Dataset;
end;

function TControllerCota.TemDados: Boolean;
begin
  Result := FEntidade.TemDados;
end;

function TControllerCota.Proximo: Boolean;
begin
  Result := FEntidade.Proximo;
end;

function TControllerCota.GRUPO: String;
begin
  Result := FEntidade.GRUPO;
end;

function TControllerCota.SEQ: String;
begin
  Result := FEntidade.SEQ;
end;

function TControllerCota.COTA: String;
begin
  Result := FEntidade.COTA;
end;

function TControllerCota.GRUPO(aValue: String): iControllerCota;
begin
  Result := Self;
  FEntidade.GRUPO(Avalue);
end;

function TControllerCota.SEQ(aValue: String): iControllerCota;
begin
  Result := Self;
  FEntidade.SEQ(Avalue);
end;

function TControllerCota.COTA(aValue: String): iControllerCota;
begin
  Result := Self;
  FEntidade.COTA(Avalue);
end;

function TControllerCota.CONTRATO: String;
begin
  Result := FEntidade.CONTRATO;
end;

function TControllerCota.NOME: String;
begin
  Result := FEntidade.NOME;
end;

function TControllerCota.PLANO: String;
begin
  Result := FEntidade.PLANO;
end;

function TControllerCota.P_MENSAL: Double;
begin
  Result := FEntidade.P_MENSAL;
end;

function TControllerCota.P_ADMINS: Double;
begin
  Result := FEntidade.P_ADMINS;
end;

function TControllerCota.P_RESERV: Double;
begin
  Result := FEntidade.P_RESERV;
end;

function TControllerCota.TP_SEGUR: String;
begin
  Result := FEntidade.TP_SEGUR;
end;

function TControllerCota.PERSEGVD: Double;
begin
  Result := FEntidade.PERSEGVD;
end;

function TControllerCota.SIT_COBR: String;
begin
  Result := FEntidade.SIT_COBR;
end;

function TControllerCota.PERCPAGO: Double;
begin
  Result := FEntidade.PERCPAGO;
end;

function TControllerCota.PERDEV: Double;
begin
  Result := FEntidade.PERDEV;
end;

function TControllerCota.PERRAT: Double;
begin
  Result := FEntidade.PERRAT;
end;

function TControllerCota.ADMINIST: Double;
begin
  Result := FEntidade.ADMINIST;
end;

function TControllerCota.DT_VENDA: TDateTime;
begin
  Result := FEntidade.DT_VENDA;
end;

function TControllerCota.REPRES: String;
begin
  Result := FEntidade.REPRES;
end;

function TControllerCota.NMREPRES: String;
begin
  Result := FEntidade.NMREPRES;
end;

function TControllerCota.DT_ADES: TDateTime;
begin
  Result := FEntidade.DT_ADES;
end;

function TControllerCota.REU_ADES: String;
begin
  Result := FEntidade.REU_ADES;
end;

function TControllerCota.FIL_ATE: String;
begin
  Result := FEntidade.FIL_ATE;
end;

function TControllerCota.FIL_COM: String;
begin
  Result := FEntidade.FIL_COM;
end;

function TControllerCota.NMFILATE: String;
begin
  Result := FEntidade.NMFILATE;
end;

function TControllerCota.BEM: String;
begin
  Result := FEntidade.BEM;
end;

function TControllerCota.DESCRIC: String;
begin
  Result := FEntidade.DESCRIC;
end;

function TControllerCota.TIPO_BEM: String;
begin
  Result := FEntidade.TIPO_BEM;
end;

function TControllerCota.DCTIPOBEM: String;
begin
  Result := FEntidade.DCTIPOBEM;
end;

function TControllerCota.FABRICAN: String;
begin
  Result := FEntidade.FABRICAN;
end;

function TControllerCota.DCFABBEM: String;
begin
  Result := FEntidade.DCFABBEM;
end;

function TControllerCota.PRE_TABE: Double;
begin
  Result := FEntidade.PRE_TABE;
end;

function TControllerCota.TP_CONTE: String;
begin
  Result := FEntidade.TP_CONTE;
end;

function TControllerCota.DCTPCONTE: String;
begin
  Result := FEntidade.DCTPCONTE;
end;

function TControllerCota.DT_CONTE: TDateTime;
begin
  Result := FEntidade.DT_CONTE;
end;

function TControllerCota.DT_ENTRE: TDateTime;
begin
  Result := FEntidade.DT_ENTRE;
end;

function TControllerCota.VAL_ENTR: Double;
begin
  Result := FEntidade.VAL_ENTR;
end;

function TControllerCota.PESS_F_J: String;
begin
  Result := FEntidade.PESS_F_J;
end;

function TControllerCota.CGC_CPF: String;
begin
  Result := FEntidade.CGC_CPF;
end;

function TControllerCota.DOCUMENT: String;
begin
  Result := FEntidade.DOCUMENT;
end;

function TControllerCota.E_CIVIL: String;
begin
  Result := FEntidade.E_CIVIL;
end;

function TControllerCota.DCECIVIL: string;
begin
  Result := FEntidade.DCECIVIL;
end;

function TControllerCota.DT_NASC: TDateTime;
begin
  Result := FEntidade.DT_NASC;
end;

function TControllerCota.SEXO: String;
begin
  Result := FEntidade.SEXO;
end;

function TControllerCota.PROFISS: String;
begin
  Result := FEntidade.PROFISS;
end;

function TControllerCota.DCPROF: String;
begin
  Result := FEntidade.DCPROF;
end;

function TControllerCota.TELEFONE: String;
begin
  Result := FEntidade.TELEFONE;
end;

function TControllerCota.ENDERECO: String;
begin
  Result := FEntidade.ENDERECO;
end;

function TControllerCota.BAIRRO: String;
begin
  Result := FEntidade.BAIRRO;
end;

function TControllerCota.CIDADE: String;
begin
  Result := FEntidade.CIDADE;
end;

function TControllerCota.ESTADO: String;
begin
  Result := FEntidade.ESTADO;
end;

function TControllerCota.CEP: String;
begin
  Result := FEntidade.CEP;
end;

function TControllerCota.TELEFONE(aValue: String): iControllerCota;
begin
  Result := Self;
  FEntidade.TELEFONE(Avalue);
end;

function TControllerCota.ENDERECO(aValue: String): iControllerCota;
begin
  Result := Self;
  FEntidade.ENDERECO(Avalue);
end;

function TControllerCota.BAIRRO(aValue: String): iControllerCota;
begin
  Result := Self;
  FEntidade.BAIRRO(Avalue);
end;

function TControllerCota.CIDADE(aValue: String): iControllerCota;
begin
  Result := Self;
  FEntidade.CIDADE(Avalue);
end;

function TControllerCota.ESTADO(aValue: String): iControllerCota;
begin
  Result := Self;
  FEntidade.ESTADO(Avalue);
end;

function TControllerCota.CEP(aValue: String): iControllerCota;
begin
  Result := Self;
  FEntidade.CEP(Avalue);
end;

function TControllerCota.SIT_COBR(aValue: String): iControllerCota;
begin
  Result := Self;
  FEntidade.SIT_COBR(Avalue);
end;

function TControllerCota.DCSITCOB: String;
begin
  Result := FEntidade.DCSITCOB;
end;

function TControllerCota.CGCCPFMT: String;
begin
  Result := FEntidade.CGCCPFMT;
end;

function TControllerCota.TP_COTA: String;
begin
  Result := FEntidade.TP_COTA;
end;

function TControllerCota.DCTPCOTA: String;
begin
  Result := FEntidade.DCTPCOTA;
end;

function TControllerCota.AG_COBRA: string;
begin
  Result := FEntidade.AG_COBRA;
end;

function TControllerCota.ULTREU: TDateTime;
begin
  Result := FEntidade.ULTREU;
end;

function TControllerCota.TP_PESS: string;
begin
  Result := FEntidade.TP_PESS;
end;

function TControllerCota.DTAJUIZ: TDateTime;
begin
  Result := FEntidade.DTAJUIZ;
end;

function TControllerCota.DTENCCT: TDateTime;
begin
  Result := FEntidade.DTENCCT;
end;

function TControllerCota.REGAPLIC: string;
begin
  Result := FEntidade.REGAPLIC;
end;

function TControllerCota.TXPER: Double;
begin
  Result := FEntidade.TXPER;
end;

end.


