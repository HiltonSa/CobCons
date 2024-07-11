unit cobcons.controller.total;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerTotal }

    TControllerTotal = class (TInterfacedObject, iControllerTotal)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelTotal;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerTotal;

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


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerTotal }

constructor Tcontrollertotal.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Total(fQuery);
end;

destructor Tcontrollertotal.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollertotal.New: Icontrollertotal;
begin
  Result := Self.Create;
end;

function Tcontrollertotal.Criartabela: Icontrollertotal;
begin
  Result := Self;
  FEntidade.CriarTabela;
end;

function Tcontrollertotal.Tabelaexiste: Boolean;
begin
  Result := FEntidade.TabelaExiste;
end;

function Tcontrollertotal.Novo: Icontrollertotal;
begin
  Result := Self;
  FEntidade.Novo;
end;

function Tcontrollertotal.Apagadados: Icontrollertotal;
begin
  Result := Self;
  FEntidade.ApagaDados;
end;

function Tcontrollertotal.Retornatotal: Icontrollertotal;
begin
  Result := Self;
  FEntidade.RetornaTotal;
end;

function Tcontrollertotal.Acumularinadimplente: Icontrollertotal;
begin
  Result := Self;
  FEntidade.AcumularInadimplente;
end;

function Tcontrollertotal.Acumularrnp: Icontrollertotal;
begin
  Result := Self;
  FEntidade.AcumularRnp;
end;

function Tcontrollertotal.Acumularrateiofuturo: Icontrollertotal;
begin
  Result := Self;
  FEntidade.AcumularRateioFuturo;
end;

procedure Tcontrollertotal.Atualizarrnp;
begin
  FEntidade.AtualizarRnp;
end;

function Tcontrollertotal.Gravar: Icontrollertotal;
begin
  Result := Self;
  FEntidade.Gravar;
end;

function Tcontrollertotal.Dataset: Tdataset;
begin
  Result := FEntidade.Dataset;
end;

function Tcontrollertotal.Dtcalc(Avalue: Tdatetime): Icontrollertotal;
begin
  Result := Self;
  FEntidade.DTCALC(Avalue);
end;

function Tcontrollertotal.Qtdinagru(Avalue: Integer): Icontrollertotal;
begin
  Result := Self;
  FEntidade.QTDINAGRU(Avalue);
end;

function Tcontrollertotal.Qtdinacota(Avalue: Integer): Icontrollertotal;
begin
  Result := Self;
  FEntidade.QTDINACOTA(Avalue);
end;

function Tcontrollertotal.Qtdrnpgru(Avalue: Integer): Icontrollertotal;
begin
  Result := Self;
  FEntidade.QTDRNPGRU(Avalue);
end;

function Tcontrollertotal.Qtdrnpcota(Avalue: Integer): Icontrollertotal;
begin
  Result := Self;
  FEntidade.QTDRNPCOTA(Avalue);
end;

function Tcontrollertotal.Qtdratgru(Avalue: Integer): Icontrollertotal;
begin
  Result := Self;
  FEntidade.QTDRATGRU(Avalue);
end;

function Tcontrollertotal.Bemapreendido(Avalue: Double): Icontrollertotal;
begin
  Result := Self;
  FEntidade.BEMAPREENDIDO(Avalue);
end;

function Tcontrollertotal.Vlrjuridico(Avalue: Double): Icontrollertotal;
begin
  Result := Self;
  FEntidade.VLRJURIDICO(Avalue);
end;

function Tcontrollertotal.Vlrmediacao(Avalue: Double): Icontrollertotal;
begin
  Result := Self;
  FEntidade.VLRMEDIACAO(Avalue);
end;

function Tcontrollertotal.Vlrrnp(Avalue: Double): Icontrollertotal;
begin
  Result := Self;
  FEntidade.VLRRNP(Avalue);
end;

function Tcontrollertotal.Vlrrat(Avalue: Double): Icontrollertotal;
begin
  Result := Self;
  FEntidade.VLRRAT(Avalue);
end;

end.

