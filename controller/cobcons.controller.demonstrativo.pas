unit cobcons.controller.demonstrativo;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerDemonstrativo }

    TControllerDemonstrativo = class (TInterfacedObject, iControllerDemonstrativo)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelDemonstrativo;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerDemonstrativo;

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


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerDemonstrativo }

constructor Tcontrollerdemonstrativo.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Demonstrativo(fQuery);
end;

destructor Tcontrollerdemonstrativo.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollerdemonstrativo.New: Icontrollerdemonstrativo;
begin
  Result := Self.Create;
end;

function Tcontrollerdemonstrativo.Criartabela: Icontrollerdemonstrativo;
begin
  Result := Self;
  FEntidade.CriarTabela;
end;

function Tcontrollerdemonstrativo.Tabelaexiste: Boolean;
begin
  Result := FEntidade.TabelaExiste;
end;

function Tcontrollerdemonstrativo.Novo: Icontrollerdemonstrativo;
begin
  Result := Self;
  FEntidade.Novo;
end;

function Tcontrollerdemonstrativo.Retornademonstrativo: Icontrollerdemonstrativo;
begin
  Result := Self;
  FEntidade.RetornaDemonstrativo;
end;

function Tcontrollerdemonstrativo.Retornademonstrativodatabase: Icontrollerdemonstrativo;
begin
  Result := Self;
  FEntidade.RetornaDemonstrativoDataBase;
end;

function Tcontrollerdemonstrativo.Importardemonstrativossiacon: Icontrollerdemonstrativo;
begin
  Result := Self;
  FEntidade.ImportarDemonstrativosSiacon;
end;

function Tcontrollerdemonstrativo.Gravarvalorconta: Icontrollerdemonstrativo;
begin
  Result := Self;
  FEntidade.GravarValorConta;
end;

function Tcontrollerdemonstrativo.Dataset: Tdataset;
begin
  Result := FEntidade.Dataset;
end;

function Tcontrollerdemonstrativo.Grupo(Avalue: String): Icontrollerdemonstrativo;
begin
  Result := Self;
  FEntidade.GRUPO(Avalue);
end;

function Tcontrollerdemonstrativo.Demonstrativo(Avalue: String): Icontrollerdemonstrativo;
begin
  Result := Self;
  FEntidade.DEMONSTRATIVO(Avalue);
end;

function Tcontrollerdemonstrativo.Database(Avalue: Tdatetime): Icontrollerdemonstrativo;
begin
  Result := Self;
  FEntidade.DATABASE(Avalue);
end;

function Tcontrollerdemonstrativo.Contacosif(Avalue: String): Icontrollerdemonstrativo;
begin
  Result := Self;
  FEntidade.CONTACOSIF(Avalue);
end;

function Tcontrollerdemonstrativo.Saldoconta(Avalue: Double): Icontrollerdemonstrativo;
begin
  Result := Self;
  FEntidade.SALDOCONTA(Avalue);
end;

function Tcontrollerdemonstrativo.Vlrperiodo(Avalue: Double): Icontrollerdemonstrativo;
begin
  Result := Self;
  FEntidade.VLRPERIODO(Avalue);
end;

function Tcontrollerdemonstrativo.Vlracumulado(Avalue: Double): Icontrollerdemonstrativo;
begin
  Result := Self;
  FEntidade.VLRACUMULADO(Avalue);
end;

end.

