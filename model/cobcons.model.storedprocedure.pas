unit cobcons.model.storedprocedure;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZStoredProcedure, cobcons.model.interfaces, ZConnection;
type
  iModelStoredProcedure = interface
    ['{C5C1D09C-2D21-4938-B8B0-6AF68FCEC876}']
    function NOME(aValue: String): iModelStoredProcedure;
    function PARAMETRO(aValue: String): iModelStoredProcedure;
    function VALOR(aValue: Variant): iModelStoredProcedure;
    function AtribuirValor: iModelStoredProcedure;
    procedure Executar;
  end;

  { TModelStoredProcedure }

  TModelStoredProcedure = class(TInterfacedObject, iModelStoredProcedure)
    private
      FConexao: iModelConexao;
      FStProc : TZStoredProc;
      FNomeParametro: String;
      FValorParametro: Variant;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelStoredProcedure;

      function NOME(aValue: String): iModelStoredProcedure;
      function PARAMETRO(aValue: String): iModelStoredProcedure;
      function VALOR(aValue: Variant): iModelStoredProcedure;
      function AtribuirValor: iModelStoredProcedure;
      procedure Executar;
  end;

implementation

uses cobcons.model.conexaozeos;

{ TModelStoredProcedure }

constructor TModelStoredProcedure.Create;
begin
  FConexao := TConexaoZeos.New(2);
  FStProc := TZStoredProc.Create(nil);
  FStProc.Connection := TZConnection(FConexao.Conectar);
end;

destructor TModelStoredProcedure.Destroy;
begin
  FreeAndNil(FStProc);
  inherited Destroy;
end;

class function TModelStoredProcedure.New: iModelStoredProcedure;
begin
  Result := Self.Create;
end;

function TModelStoredProcedure.NOME(aValue: String): iModelStoredProcedure;
begin
  Result := Self;
  FStProc.StoredProcName := aValue;
end;

function TModelStoredProcedure.PARAMETRO(aValue: String): iModelStoredProcedure;
begin
  Result := Self;
  FNomeParametro := aValue;
end;

function TModelStoredProcedure.VALOR(aValue: Variant): iModelStoredProcedure;
begin
  Result := Self;
  FValorParametro := aValue;
end;

function TModelStoredProcedure.AtribuirValor: iModelStoredProcedure;
begin
  FStProc.ParamByName(FNomeParametro).Value := FValorParametro;
end;

procedure TModelStoredProcedure.Executar;
begin
  FStProc.ExecProc;
end;

end.

