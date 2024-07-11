unit cobcons.controller.totalgrupo;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerTotalGrupo }

    TControllerTotalGrupo = class (TInterfacedObject, iControllerTotalGrupo)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelTotalGrupo;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerTotalGrupo;

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


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerTotalGrupo }

constructor Tcontrollertotalgrupo.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.TotalGrupo(fQuery);
end;

destructor Tcontrollertotalgrupo.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollertotalgrupo.New: Icontrollertotalgrupo;
begin
  Result := Self.Create;
end;

function Tcontrollertotalgrupo.Criartabela: Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.CriarTabela;
end;

function Tcontrollertotalgrupo.Tabelaexiste: Boolean;
begin
  Result := FEntidade.TabelaExiste;
end;

function Tcontrollertotalgrupo.Novo: Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.Novo;
end;

function Tcontrollertotalgrupo.Retornagrupo(Pgrupo: String): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.RetornaGrupo(Pgrupo);
end;

function Tcontrollertotalgrupo.Listatodos: Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.ListaTodos;
end;

function Tcontrollertotalgrupo.Gravar: Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.Gravar;
end;

function Tcontrollertotalgrupo.Acumularinadimplentes: Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.AcumularInadimplentes;
end;

function Tcontrollertotalgrupo.Acumularrnp: Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.AcumularRnp;
end;

function Tcontrollertotalgrupo.Acumulartotalfator: Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.AcumularTotalFator;
end;

function Tcontrollertotalgrupo.Acumularrateiofuturo: Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.AcumularRateioFuturo;
end;

procedure Tcontrollertotalgrupo.Atualizarrnp;
begin
  FEntidade.AtualizarRnp;
end;

function Tcontrollertotalgrupo.Apagardados: Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.ApagarDados;
end;

function Tcontrollertotalgrupo.Temdados: Boolean;
begin
  Result := FEntidade.TemDados;
end;

function Tcontrollertotalgrupo.Proximo: Boolean;
begin
  Result := FEntidade.Proximo;
end;

function Tcontrollertotalgrupo.Dataset: Tdataset;
begin
  Result := FEntidade.Dataset;
end;

function Tcontrollertotalgrupo.Grupo(Avalue: String): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.GRUPO(Avalue);
end;

function Tcontrollertotalgrupo.Regaplic(Avalue: String): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.REGAPLIC(Avalue);
end;

function Tcontrollertotalgrupo.Dtcalc(Avalue: Tdatetime): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.DTCALC(Avalue);
end;

function Tcontrollertotalgrupo.Dtultass(Avalue: Tdatetime): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.DTULTASS(Avalue);
end;

function Tcontrollertotalgrupo.Dtencct(Avalue: Tdatetime): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.DTENCCT(Avalue);
end;

function Tcontrollertotalgrupo.Dtcmper(Avalue: Tdatetime): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.DTCMPER(Avalue);
end;

function Tcontrollertotalgrupo.Txper(Avalue: Double): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.TXPER(Avalue);
end;

function Tcontrollertotalgrupo.Regaplic: String;
begin
  Result := FEntidade.REGAPLIC;
end;

function Tcontrollertotalgrupo.Dtultass: Tdatetime;
begin
  Result := FEntidade.DTULTASS;
end;

function Tcontrollertotalgrupo.Dtencct: Tdatetime;
begin
  Result := FEntidade.DTENCCT;
end;

function Tcontrollertotalgrupo.Dtcmper: Tdatetime;
begin
  Result := FEntidade.DTCMPER;
end;

function Tcontrollertotalgrupo.Txper: Double;
begin
  Result := FEntidade.TXPER;
end;

function Tcontrollertotalgrupo.Mulresgru(Avalue: Double): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.MULRESGRU(Avalue);
end;

function Tcontrollertotalgrupo.Mulresadm(Avalue: Double): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.MULRESADM(Avalue);
end;

function Tcontrollertotalgrupo.Qtdina(Avalue: Integer): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.QTDINA(Avalue);
end;

function Tcontrollertotalgrupo.Qtdrnp(Avalue: Integer): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.QTDRNP(Avalue);
end;

function Tcontrollertotalgrupo.Bemapreendido(Avalue: Double): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.BEMAPREENDIDO(Avalue);
end;

function Tcontrollertotalgrupo.Vlrjuridico(Avalue: Double): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.VLRJURIDICO(Avalue);
end;

function Tcontrollertotalgrupo.Vlrmediacao(Avalue: Double): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.VLRMEDIACAO(Avalue);
end;

function Tcontrollertotalgrupo.Vlrrnp(Avalue: Double): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.VLRRNP(Avalue);
end;

function Tcontrollertotalgrupo.Totalfator(Avalue: Double): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.TOTALFATOR(Avalue);
end;

function Tcontrollertotalgrupo.Vlrrf(Avalue: Double): Icontrollertotalgrupo;
begin
  Result := Self;
  FEntidade.VLRRF(Avalue);
end;

function Tcontrollertotalgrupo.Grupo: String;
begin
  Result := FEntidade.GRUPO;
end;

function Tcontrollertotalgrupo.Vlina: Double;
begin
  Result := FEntidade.VLINA;
end;

function Tcontrollertotalgrupo.Totalfator: Double;
begin
  Result := FEntidade.TOTALFATOR;
end;

end.

