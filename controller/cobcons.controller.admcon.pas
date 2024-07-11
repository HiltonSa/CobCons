unit cobcons.controller.admcon;

{$mode Delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db, ComCtrls, ExtCtrls;

type

    { TControllerAdmCon }

    TControllerAdmCon = class (TInterfacedObject, iControllerAdmcon)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelAdmcon;

      function Dataset: TDataset;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerAdmcon;

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


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerAdmCon }

function TControllerAdmCon.Dataset: TDataset;
var
  vLista: TStringList;
begin
  vLista := TStringList.Create;
  try
    FQuery.Dataset.GetFieldNames(vLista);
    if vLista.IndexOf('CODIGO') > -1
    then TIntegerField(FQuery.FieldByName('CODIGO')).DisplayFormat := '000';
    if vLista.IndexOf('PCENTREGA') > -1
    then TFloatField(FQuery.FieldByName('PCENTREGA')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('PCPER') > -1
    then TFloatField(FQuery.FieldByName('PCPER')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('VIGENCIA') > -1
    then TDateTimeField(FQuery.FieldByName('VIGENCIA')).DisplayFormat := 'dd/mm/yyyy';
    Result := FQuery.Dataset;
  finally
    vLista.Free;
  end;
end;

constructor TControllerAdmCon.Create;
begin
  FConexao := TControllerFactory.New.Conexao(2);
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.AdmCon(fQuery);
end;

destructor TControllerAdmCon.Destroy;
begin
  inherited Destroy;
end;

class function TControllerAdmCon.New: iControllerAdmcon;
begin
  Result := Self.Create;
end;

function TControllerAdmCon.ListaPorCodigo(pCodigo: Integer): TDataSet;
begin
  FEntidade.ListaPorCodigo(pCodigo);
  Result := Dataset;
end;

function TControllerAdmCon.ListaPorNome(pNome: String): TDataSet;
begin
  FEntidade.ListaPorNome(pNome);
  Result := Dataset;
end;

function TControllerAdmCon.ListaComboBox: TStringList;
begin
  Result := FEntidade.ListaComboBox;
end;

function TControllerAdmCon.Executar(pModo: TpModoManutencao): iControllerAdmcon;
begin
  Result := Self;
  FEntidade.Executar(pModo);
end;

function TControllerAdmCon.CODIGO: Integer;
begin
  Result := FEntidade.CODIGO;
end;

function TControllerAdmCon.CODIGO(pValor: Integer): iControllerAdmcon;
begin
  Result := Self;
  FEntidade.CODIGO(pValor);
end;

function TControllerAdmCon.NOMEFANTASIA: String;
begin
  Result := FEntidade.NOMEFANTASIA;
end;

function TControllerAdmCon.NOMEFANTASIA(pValor: String): iControllerAdmcon;
begin
  Result := Self;
  FEntidade.NOMEFANTASIA(pValor);
end;

function TControllerAdmCon.RAZAOSOCIAL: String;
begin
  Result := FEntidade.RAZAOSOCIAL;
end;

function TControllerAdmCon.RAZAOSOCIAL(pValor: String): iControllerAdmcon;
begin
  Result := Self;
  FEntidade.RAZAOSOCIAL(pValor);
end;

function TControllerAdmCon.CNPJ: String;
begin
  Result := FEntidade.CNPJ;
end;

function TControllerAdmCon.CNPJ(pValor: String): iControllerAdmcon;
begin
  Result := Self;
  FEntidade.CNPJ(pValor);
end;

function TControllerAdmCon.VIGENCIA: TDateTime;
begin
  Result := FEntidade.VIGENCIA;
end;

function TControllerAdmCon.VIGENCIA(pValor: TDateTime): iControllerAdmcon;
begin
  Result := Self;
  FEntidade.VIGENCIA(pValor);
end;

function TControllerAdmCon.UNIDADE: Integer;
begin
  Result := FEntidade.UNIDADE;
end;

function TControllerAdmCon.UNIDADE(pValor: Integer): iControllerAdmcon;
begin
  Result := Self;
  FEntidade.UNIDADE(pValor);
end;

function TControllerAdmCon.PCENTREGA: Double;
begin
  Result := FEntidade.PCENTREGA;
end;

function TControllerAdmCon.PCENTREGA(pValor: Double): iControllerAdmcon;
begin
  Result := Self;
  FEntidade.PCENTREGA(pValor);
end;

function TControllerAdmCon.MESPER: Integer;
begin
  Result := FEntidade.MESPER;
end;

function TControllerAdmCon.MESPER(pValor: Integer): iControllerAdmcon;
begin
  Result := Self;
  FEntidade.MESPER(pValor);
end;

function TControllerAdmCon.PCPER: Double;
begin
  Result := FEntidade.PCPER;
end;

function TControllerAdmCon.PCPER(pValor: Double): iControllerAdmcon;
begin
  Result := Self;
  FEntidade.PCPER(pValor);
end;

function TControllerAdmCon.ACERTO: Integer;
begin
  Result := FEntidade.ACERTO;
end;

function TControllerAdmCon.ACERTO(pValor: Integer): iControllerAdmcon;
begin
  Result := Self;
  FEntidade.ACERTO(pValor);
end;

function TControllerAdmCon.ULTFAIXA: Integer;
begin
  Result := FEntidade.ULTFAIXA;
end;

function TControllerAdmCon.ULTFAIXA(pValor: Integer): iControllerAdmcon;
begin
  Result := Self;
  FEntidade.ULTFAIXA(pValor);
end;


end.

