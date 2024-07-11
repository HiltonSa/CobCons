unit cobcons.controller.agente;

{$mode Delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db, ComCtrls, ExtCtrls;

type

    { TControllerAgente }

    TControllerAgente = class (TInterfacedObject, iControllerAgente)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelAgente;

      function Dataset: TDataset;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerAgente;

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
      function CELULAR(pValor: sTRING): iControllerAgente; overload;
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


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerAgente }

function TControllerAgente.Dataset: TDataset;
var
  vLista: TStringList;
begin
  vLista := TStringList.Create;
  try
    FQuery.Dataset.GetFieldNames(vLista);
    if vLista.IndexOf('CODIGO') > -1
    then TIntegerField(FQuery.FieldByName('CODIGO')).DisplayFormat := '000000';
    //if vLista.IndexOf('PCENTREGA') > -1
    //then TFloatField(FQuery.FieldByName('PCENTREGA')).DisplayFormat := ',#0.00';
    //if vLista.IndexOf('PCPER') > -1
    //then TFloatField(FQuery.FieldByName('PCPER')).DisplayFormat := ',#0.00';
    //if vLista.IndexOf('CELULAR') > -1
    //then TDateTimeField(FQuery.FieldByName('CELULAR')).DisplayFormat := 'dd/mm/yyyy';
    Result := FQuery.Dataset;
  finally
    vLista.Free;
  end;
end;

constructor TControllerAgente.Create;
begin
  FConexao := TControllerFactory.New.Conexao(2);
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Agente(fQuery);
end;

destructor TControllerAgente.Destroy;
begin
  inherited Destroy;
end;

class function TControllerAgente.New: iControllerAgente;
begin
  Result := Self.Create;
end;

function TControllerAgente.ListaPorCodigo(pCodigo: Integer): TDataSet;
begin
  FEntidade.ListaPorCodigo(pCodigo);
  Result := Dataset;
end;

function TControllerAgente.ListaPorNome(pNome: String): TDataSet;
begin
  FEntidade.ListaPorNome(pNome);
  Result := Dataset;
end;

function TControllerAgente.ListaComboBox(pEquipe: Integer): TStringList;
begin
  Result := FEntidade.ListaComboBox(pEquipe);
end;

function TControllerAgente.ListaSupervisoresAtivosComboBox(pNivel: Integer
  ): TStringList;
begin
  Result := FEntidade.ListaSupervisoresAtivosComboBox(pNivel);
end;

function TControllerAgente.Executar(pModo: TpModoManutencao): iControllerAgente;
begin
  Result := Self;
  FEntidade.Executar(pModo);
end;

function TControllerAgente.CODIGO: Integer;
begin
  Result := FEntidade.CODIGO;
end;

function TControllerAgente.CODIGO(pValor: Integer): iControllerAgente;
begin
  Result := Self;
  FEntidade.CODIGO(pValor);
end;

function TControllerAgente.NOME: String;
begin
  Result := FEntidade.NOME;
end;

function TControllerAgente.NOME(pValor: String): iControllerAgente;
begin
  Result := Self;
  FEntidade.NOME(pValor);
end;

function TControllerAgente.DDD: String;
begin
  Result := FEntidade.DDD;
end;

function TControllerAgente.DDD(pValor: String): iControllerAgente;
begin
  Result := Self;
  FEntidade.DDD(pValor);
end;

function TControllerAgente.CPF: String;
begin
  Result := FEntidade.CPF;
end;

function TControllerAgente.CPF(pValor: String): iControllerAgente;
begin
  Result := Self;
  FEntidade.CPF(pValor);
end;

function TControllerAgente.CELULAR: String;
begin
  Result := FEntidade.CELULAR;
end;

function TControllerAgente.CELULAR(pValor: sTRING): iControllerAgente;
begin
  Result := Self;
  FEntidade.CELULAR(pValor);
end;

function TControllerAgente.EQUIPE: Integer;
begin
  Result := FEntidade.EQUIPE;
end;

function TControllerAgente.EQUIPE(pValor: Integer): iControllerAgente;
begin
  Result := Self;
  FEntidade.EQUIPE(pValor);
end;

function TControllerAgente.SUPERVISAO: Integer;
begin
  Result := FEntidade.SUPERVISAO;
end;

function TControllerAgente.SUPERVISAO(pValor: Integer): iControllerAgente;
begin
  Result := Self;
  FEntidade.SUPERVISAO(pValor);
end;

function TControllerAgente.ATIVO: Integer;
begin
  Result := FEntidade.ATIVO;
end;

function TControllerAgente.ATIVO(pValor: Integer): iControllerAgente;
begin
  Result := Self;
  FEntidade.ATIVO(pValor);
end;

function TControllerAgente.CDEXTERNO: String;
begin
  Result := FEntidade.CDEXTERNO;
end;

function TControllerAgente.CDEXTERNO(pValor: String): iControllerAgente;
begin
  Result := Self;
  FEntidade.CDEXTERNO(pValor);
end;

function TControllerAgente.DCATIVO: String;
begin
  Result := FEntidade.DCATIVO;
end;

function TControllerAgente.DCFIL: String;
begin
  Result := FEntidade.DCFIL;
end;

function TControllerAgente.DCEQP: String;
begin
  Result := FEntidade.DCEQP;
end;

end.

