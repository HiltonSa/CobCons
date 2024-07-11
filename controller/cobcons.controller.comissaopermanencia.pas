unit cobcons.controller.comissaopermanencia;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db, ComCtrls, ExtCtrls;

type

    { TControllerComissaoPermanencia }

    TControllerComissaoPermanencia = class (TInterfacedObject, iControllerComissaoPermanencia)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelComissaoPermanencia;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerComissaoPermanencia;

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
      function Datacalculo(Avalue: Tdatetime): Icontrollercomissaopermanencia;
      function SALDOINICIAL: Double;
      function COMISSAO: Double;
      function SALDOFINAL: Double;
      function Calcular: TDataSet;
      procedure Gravar;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerComissaoPermanencia }

constructor Tcontrollercomissaopermanencia.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.ComissaoPermanencia(fQuery);
end;

destructor Tcontrollercomissaopermanencia.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollercomissaopermanencia.New: Icontrollercomissaopermanencia;
begin
  Result := Self.Create;
end;

function Tcontrollercomissaopermanencia.Criartabela: Icontrollercomissaopermanencia;
begin
  Result := Self;
  FEntidade.CriarTabela;
end;

function Tcontrollercomissaopermanencia.Tabelaexiste: Boolean;
begin
  Result := FEntidade.TabelaExiste;
end;

function Tcontrollercomissaopermanencia.Listarcomissoes: Icontrollercomissaopermanencia;
begin
  Result := Self;
  FEntidade.ListarComissoes;
end;

function Tcontrollercomissaopermanencia.Listarporcodigo(Pcodigo: Integer): Icontrollercomissaopermanencia;
begin
  Result := Self;
  FEntidade.ListarPorCodigo(Pcodigo);
end;

function Tcontrollercomissaopermanencia.Excluircomissaopermanencia(Pcodigo: Integer): Icontrollercomissaopermanencia;
begin
  Result := Self;
  FEntidade.ExcluirComissaoPermanencia(Pcodigo);
end;

function Tcontrollercomissaopermanencia.Dataset: Tdataset;
begin
  Result := FEntidade.DataSet;
end;

function Tcontrollercomissaopermanencia.Log(Avalue: Tandamento): Icontrollercomissaopermanencia;
begin
  Result := Self;
  FEntidade.LOG(Avalue);
end;

function Tcontrollercomissaopermanencia.Agente(Avalue: String): Icontrollercomissaopermanencia;
begin
  Result := Self;
  FEntidade.AGENTE(Avalue);
end;

function Tcontrollercomissaopermanencia.Tpdoc(Avalue: String): Icontrollercomissaopermanencia;
begin
  Result := Self;
  FEntidade.TPDOC(Avalue);
end;

function Tcontrollercomissaopermanencia.Documento(Avalue: String): Icontrollercomissaopermanencia;
begin
  Result := Self;
  FEntidade.DOCUMENTO(Avalue);
end;

function Tcontrollercomissaopermanencia.Historico(Avalue: String): Icontrollercomissaopermanencia;
begin
  Result := Self;
  FEntidade.HISTORICO(Avalue);
end;

function Tcontrollercomissaopermanencia.Datacalculo(Avalue: Tdatetime): Icontrollercomissaopermanencia;
begin
  Result := Self;
  FEntidade.DATACALCULO(Avalue);
end;

function Tcontrollercomissaopermanencia.Saldoinicial: Double;
begin
  Result := FEntidade.SALDOINICIAL;
end;

function Tcontrollercomissaopermanencia.Comissao: Double;
begin
  Result := FEntidade.COMISSAO;
end;

function Tcontrollercomissaopermanencia.Saldofinal: Double;
begin
  Result := FEntidade.SALDOFINAL;
end;

function Tcontrollercomissaopermanencia.Calcular: Tdataset;
begin
  Result := FEntidade.Calcular;
end;

procedure Tcontrollercomissaopermanencia.Gravar;
begin
  FEntidade.Gravar;
end;

end.

