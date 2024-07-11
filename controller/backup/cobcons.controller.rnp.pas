unit cobcons.controller.rnp;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerRnp }

    TControllerRnp = class (TInterfacedObject, iControllerRnp)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelRnp;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerRnp;

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
      function RetornaSomenteRnp: iControllerRnp;
      function RetornaComissaoPermanencia(pDataCalculo: TDateTime): iControllerRnp;
      function RetornaRnpRateiosFuturos: iControllerRnp;
      function RetornaUmRnp(pGrupo, pSeq, pCota: String): iControllerRnp;
      function RetornaUmCheck(pGrupo, pSeq, pCota: String): iControllerRnp;
      function RetornaRnpGrupo(pGrupo: String): iControllerRnp;
      function RetornaRecomposicaoSaldosGrupo(pGrupo: String): iControllerRnp;
      function Retornarecomposicaosaldostodos: Icontrollerrnp;
      function TotalizaRecomposicaoRnp: Icontrollerrnp;
      function Gravar: iControllerRnp;
      function GravarRateioFuturo: iControllerRnp;
      function GravarSaldoRnp: iControllerRnp;
      function GravarSaldoSiaconRnp(pGrupo, pSeq, pCota: String; pSiacon: Double): iControllerRnp;
      function CompararSAG: TDataSet; overload;
      function CompararSAG(pArquivoSag: TStringList): TDataSet; overload;
      function SaldoDataBase(pGRupo, pSeq, pCota: String; pDataLimite: TDateTime): Currency;
      function SaldoRnp31Dez21(pGRupo, pSeq, pCota: String): Currency;
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


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerRnp }

constructor TControllerRnp.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.RNP(fQuery);
end;

destructor TControllerRnp.Destroy;
begin
  inherited Destroy;
end;

class function TControllerRnp.New: iControllerRnp;
begin
  Result := Self.Create;
end;

function TControllerRnp.CriarTabela: iControllerRnp;
begin
  Result := Self;
  FEntidade.CriarTabela;
end;

function TControllerRnp.CriarTabelaSaldo(pDtRecSld: TDateTime): iControllerRnp;
begin
  Result := Self;
  FEntidade.CriarTabelaSaldo(Pdtrecsld);
end;

function TControllerRnp.CriarTabelaCheck: iControllerRnp;
begin
  Result := Self;
  FEntidade.CriarTabelaCheck;
end;

function TControllerRnp.TabelaExiste: Boolean;
begin
  Result := FEntidade.TabelaExiste;
end;

function TControllerRnp.TabelaSaldoExiste: Boolean;
begin
  Result := FEntidade.TabelaSaldoExiste;
end;

function TControllerRnp.TabelaCheckExiste: Boolean;
begin
  Result := FEntidade.TabelaCheckExiste;
end;

function TControllerRnp.Novo: iControllerRnp;
begin
  Result := Self;
  FEntidade.Novo;
end;

function TControllerRnp.NovoCheck(pGrupo, pSeq, pCota: String; pRel,
  pPla: Integer; pRecRel, pRecPla, pComRel, pComPla: Double): iControllerRnp;
begin
  Result := Self;
  FEntidade.NovoCheck(Pgrupo, Pseq, Pcota, Prel, Ppla,Precrel, Precpla, Pcomrel, Pcompla);
end;

function TControllerRnp.GravarCheck(pGrupo, pSeq, pCota: String; pRel,
  pPla: Integer; pRecRel, pRecPla, pComRel, pComPla: Double): iControllerRnp;
begin
  Result := Self;
  FEntidade.GravarCheck(Pgrupo, Pseq, Pcota, Prel, Ppla,Precrel, Precpla, Pcomrel, Pcompla);
end;

function TControllerRnp.RetornaRnp: iControllerRnp;
begin
  Result := Self;
  FEntidade.RetornaRnp;
end;

function TControllerRnp.RetornaCheck: iControllerRnp;
begin
  Result := Self;
  FEntidade.RetornaCheck;
end;

function TControllerRnp.RetornaSaldoInicialRnp: Double;
begin
  Result := FEntidade.RetornaSaldoInicialRnp;
end;

function TControllerRnp.RetornaSaldoInicialSiacon: Double;
begin
  Result := FEntidade.RetornaSaldoInicialSiacon;
end;

function TControllerRnp.RetornaSomenteRnp: iControllerRnp;
begin
  Result := Self;
  FEntidade.RetornaSomenteRnp;
end;

function TControllerRnp.RetornaComissaoPermanencia(pDataCalculo: TDateTime
  ): iControllerRnp;
begin
  Result := Self;
  FEntidade.RetornaComissaoPermanencia(Pdatacalculo);
end;

function TControllerRnp.RetornaRnpRateiosFuturos: iControllerRnp;
begin
  Result := Self;
  FEntidade.RetornaRnpRateiosFuturos;
end;

function TControllerRnp.ApagarDados: iControllerRnp;
begin
  Result := Self;
  FEntidade.ApagarDados;
end;

function TControllerRnp.ApagarCheck: iControllerRnp;
begin
  Result := Self;
  FEntidade.ApagarCheck;
end;

function TControllerRnp.RetornaUmRnp(pGrupo, pSeq, pCota: String
  ): iControllerRnp;
begin
  Result := Self;
  FEntidade.RetornaUmRnp(Pgrupo, Pseq, Pcota);
end;

function TControllerRnp.RetornaUmCheck(pGrupo, pSeq, pCota: String
  ): iControllerRnp;
begin
  Result := Self;
  FEntidade.RetornaUmCheck(Pgrupo, Pseq, Pcota);
end;

function TControllerRnp.RetornaRnpGrupo(pGrupo: String): iControllerRnp;
begin
  Result := Self;
  FEntidade.RetornaRnpGrupo(Pgrupo);
end;

function TControllerRnp.RetornaRecomposicaoSaldosGrupo(pGrupo: String
  ): iControllerRnp;
begin
  Result := Self;
  FEntidade.RetornaRecomposicaoSaldosGrupo(Pgrupo);
end;

function TControllerRnp.Retornarecomposicaosaldostodos: Icontrollerrnp;
begin
  Result := Self;
  FEntidade.RetornaRecomposicaoSaldosTodos;
end;

function TControllerRnp.TotalizaRecomposicaoRnp: Icontrollerrnp;
begin
  Result := Self;
  FEntidade.TotalizaRecomposicaoRnp;
end;

function TControllerRnp.Gravar: iControllerRnp;
begin
  Result := Self;
  FEntidade.Gravar;
end;

function TControllerRnp.GravarRateioFuturo: iControllerRnp;
begin
  Result := Self;
  FEntidade.GravarRateioFuturo;
end;

function TControllerRnp.GravarSaldoRnp: iControllerRnp;
begin
  Result := Self;
  FEntidade.GravarSaldoRnp;
end;

function TControllerRnp.GravarSaldoSiaconRnp(pGrupo, pSeq, pCota: String;
  pSiacon: Double): iControllerRnp;
begin
  Result := Self;
  FEntidade.GravarSaldoSiaconRnp(Pgrupo, Pseq, Pcota,Psiacon);
end;

function TControllerRnp.CompararSAG: TDataSet;
begin
  Result := FEntidade.CompararSAG(FQuerySag);
end;

function TControllerRnp.CompararSAG(pArquivoSag: TStringList): TDataSet;
begin
  Result := FEntidade.CompararSAG(Parquivosag);
end;

function TControllerRnp.SaldoDataBase(pGRupo, pSeq, pCota: String;
  pDataLimite: TDateTime): Currency;
begin
  Result := FEntidade.SaldoDataBase(Pgrupo, Pseq, Pcota, Pdatalimite);
end;

function TControllerRnp.SaldoRnp31Dez21(pGRupo, pSeq, pCota: String): Currency;
begin
  Result := FEntidade.SaldoRnp31Dez21(pGRupo, pSeq, pCota);
end;

function TControllerRnp.RnpSag: TDataSet;
begin
  Result := FEntidade.RnpSag;
end;

function TControllerRnp.DataSet: TDataSet;
begin
  Result := FEntidade.Dataset;
end;

function TControllerRnp.TemDados: Boolean;
begin
  Result := FEntidade.TemDados;
end;

function TControllerRnp.Proximo: Boolean;
begin
  Result := FEntidade.Proximo;
end;

function TControllerRnp.GRUPO(aValue: String): iControllerRnp;
begin
  Result := Self;
  FEntidade.GRUPO(Avalue);
end;

function TControllerRnp.SEQ(aValue: String): iControllerRnp;
begin
  Result := Self;
  FEntidade.SEQ(Avalue);
end;

function TControllerRnp.COTA(aValue: String): iControllerRnp;
begin
  Result := Self;
  FEntidade.COTA(Avalue);
end;

function TControllerRnp.PERCAMORT(aValue: Double): iControllerRnp;
begin
  Result := Self;
  FEntidade.PERCAMORT(Avalue);
end;

function TControllerRnp.VLRRNP(aValue: Double): iControllerRnp;
begin
  Result := Self;
  FEntidade.VLRRNP(Avalue);
end;

function TControllerRnp.VLRRNP: Double;
begin
  Result := FEntidade.VLRRNP;
end;

function TControllerRnp.VLRBEM(aValue: Double): iControllerRnp;
begin
  Result := Self;
  FEntidade.VLRBEM(Avalue);
end;

function TControllerRnp.RATFUT(aValue: Double): iControllerRnp;
begin
  Result := Self;
  FEntidade.RATFUT(Avalue);
end;

function TControllerRnp.PCRATEIO(aValue: Double): iControllerRnp;
begin
  Result := Self;
  FEntidade.PCRATEIO(Avalue);
end;

function TControllerRnp.GRUPO: String;
begin
  Result := FEntidade.GRUPO;
end;

function TControllerRnp.SEQ: String;
begin
  Result := FEntidade.SEQ;
end;

function TControllerRnp.COTA: String;
begin
  Result := FEntidade.COTA;
end;

function TControllerRnp.FATOR: double;
begin
  Result := FEntidade.FATOR;
end;

function TControllerRnp.TXPER: double;
begin
  Result := FEntidade.TXPER;
end;

function TControllerRnp.VLMIN: double;
begin
  Result := FEntidade.VLMIN;
end;

function TControllerRnp.NOME: String;
begin
  Result := FEntidade.NOME;
end;

end.

