unit cobcons.controller.inadimplente;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerInadimplente }

    TControllerInadimplente = class (TInterfacedObject, iControllerInadimplente)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelInadimplente;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerInadimplente;

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


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerInadimplente }

constructor Tcontrollerinadimplente.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Inadimplente(fQuery);
end;

destructor Tcontrollerinadimplente.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollerinadimplente.New: Icontrollerinadimplente;
begin
  Result := Self.Create;
end;

function Tcontrollerinadimplente.Criartabela: Icontrollerinadimplente;
begin
  Result := Self;
  FEntidade.CriarTabela;
end;

function Tcontrollerinadimplente.Tabelaexiste: Boolean;
begin
  Result := FEntidade.TabelaExiste;
end;

function Tcontrollerinadimplente.Novo: Icontrollerinadimplente;
begin
  Result := Self;
  FEntidade.Novo;
end;

function Tcontrollerinadimplente.Apagardados: Icontrollerinadimplente;
begin
  Result := Self;
  FEntidade.ApagarDados;
end;

function Tcontrollerinadimplente.Retornainadimplentes: Icontrollerinadimplente;
begin
  Result := Self;
  FEntidade.RetornaInadimplentes;
end;

function Tcontrollerinadimplente.Retornainadimplentesgrupo(Pgrupo: String): Icontrollerinadimplente;
begin
  Result := Self;
  FEntidade.RetornaInadimplentesGrupo(Pgrupo);
end;

function Tcontrollerinadimplente.Gravar: Icontrollerinadimplente;
begin
  Result := Self;
  FEntidade.Gravar;
end;

function Tcontrollerinadimplente.Inadimplentessag: Tdataset;
begin
  Result := FEntidade.InadimplentesSag;
end;

function Tcontrollerinadimplente.Dataset: Tdataset;
begin
  Result := FEntidade.Dataset;
end;

function Tcontrollerinadimplente.Grupo(Avalue: String): Icontrollerinadimplente;
begin
  Result := Self;
  FEntidade.GRUPO(Avalue);
end;

function Tcontrollerinadimplente.Seq(Avalue: String): Icontrollerinadimplente;
begin
  Result := Self;
  FEntidade.SEQ(Avalue);
end;

function Tcontrollerinadimplente.Cota(Avalue: String): Icontrollerinadimplente;
begin
  Result := Self;
  FEntidade.COTA(Avalue);
end;

function Tcontrollerinadimplente.Dtajuiz(Avalue: Tdatetime): Icontrollerinadimplente;
begin
  Result := Self;
  FEntidade.DTAJUIZ(Avalue);
end;

function Tcontrollerinadimplente.Percamort(Avalue: Double): Icontrollerinadimplente;
begin
  Result := Self;
  FEntidade.PERCAMORT(Avalue);
end;

function Tcontrollerinadimplente.Vlrreceber(Avalue: Double): Icontrollerinadimplente;
begin
  Result := Self;
  FEntidade.VLRRECEBER(Avalue);
end;

function Tcontrollerinadimplente.Vlrbem(Avalue: Double): Icontrollerinadimplente;
begin
  Result := Self;
  FEntidade.VLRBEM(Avalue);
end;

function Tcontrollerinadimplente.Bemapreendido(Avalue: Double): Icontrollerinadimplente;
begin
  Result := Self;
  FEntidade.BEMAPREENDIDO(Avalue);
end;


end.

