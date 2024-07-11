unit cobcons.controller.agenda;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerAgenda }

    TControllerAgenda = class (TInterfacedObject, iControllerAgenda)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelAgenda;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerAgenda;

      function RetornaAgendaUsuarioPeriodo(pUsuario: Integer; pInicio, pFim: TDateTime): iControllerAgenda;
      function AlterarPrioridade(pCodigo, pPrioridade: Integer): iControllerAgenda;
      function AlterarStatus(pCodigo, pStatus: Integer): iControllerAgenda;
      function Novo: iControllerAgenda;
      function Alterar: iControllerAgenda;
      function Excluir: iControllerAgenda;
      function ProximoCodigo: Integer;
      function DataSet: TDataSet;
      function CODIGO(aValue: Integer): iControllerAgenda; overload;
      function CODIGO: Integer; overload;
      function DTAGE(aValue: TDateTime): iControllerAgenda; overload;
      function DTAGE: TDateTime; overload;
      function PRIORIDADE(aValue: Integer): iControllerAgenda; overload;
      function PRIORIDADE: Integer; overload;
      function CONTRATO(aValue: String): iControllerAgenda; overload;
      function CONTRATO: String; overload;
      function USUARIO(aValue: Integer): iControllerAgenda; overload;
      function USUARIO: Integer; overload;
      function STATUS(aValue: Integer): iControllerAgenda; overload;
      function STATUS: Integer; overload;
      function GRUPO(aValue: String): iControllerAgenda; overload;
      function GRUPO: String; overload;
      function SEQ(aValue: String): iControllerAgenda; overload;
      function SEQ: String; overload;
      function COTA(aValue: String): iControllerAgenda; overload;
      function COTA: String; overload;
      function OBS(aValue: TMemoryStream): iControllerAgenda; overload;
      function OBS: TMemoryStream; overload;
      function DCPRIORIDADE: String; overload;
      function NMUSUARIO: String; overload;
      function NMCOTA: String; overload;
      function DCSTATUS: String; overload;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerAgenda }

constructor Tcontrolleragenda.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Agenda(fQuery);
end;

destructor Tcontrolleragenda.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrolleragenda.New: Icontrolleragenda;
begin
  Result := Self.Create;
end;

function Tcontrolleragenda.Retornaagendausuarioperiodo(Pusuario: Integer; Pinicio, Pfim: Tdatetime): Icontrolleragenda;
begin
  Result := Self;
  FEntidade.RetornaAgendaUsuarioPeriodo(Pusuario, Pinicio, Pfim);
end;

function Tcontrolleragenda.Alterarprioridade(Pcodigo, Pprioridade: Integer): Icontrolleragenda;
begin
  Result := Self;
  FEntidade.AlterarPrioridade(Pcodigo, Pprioridade);
end;

function Tcontrolleragenda.Alterarstatus(Pcodigo, Pstatus: Integer): Icontrolleragenda;
begin
  Result := Self;
  FEntidade.AlterarStatus(Pcodigo, Pstatus);
end;

function Tcontrolleragenda.Novo: Icontrolleragenda;
begin
  Result := Self;
  FEntidade.Novo;
end;

function Tcontrolleragenda.Alterar: Icontrolleragenda;
begin
  Result := Self;
  FEntidade.Alterar;
end;

function Tcontrolleragenda.Excluir: Icontrolleragenda;
begin
  Result := Self;
  FEntidade.Excluir;
end;

function Tcontrolleragenda.Proximocodigo: Integer;
begin
  Result := FEntidade.ProximoCodigo;
end;


function Tcontrolleragenda.Dataset: Tdataset;
begin
  Result := FEntidade.Dataset;
end;

function Tcontrolleragenda.Codigo(Avalue: Integer): Icontrolleragenda;
begin
  Result := Self;
  FEntidade.CODIGO(Avalue);
end;

function Tcontrolleragenda.Codigo: Integer;
begin
  Result := FEntidade.CODIGO;
end;

function Tcontrolleragenda.Dtage(Avalue: Tdatetime): Icontrolleragenda;
begin
  Result := Self;
  FEntidade.DTAGE(Avalue);
end;

function Tcontrolleragenda.Dtage: Tdatetime;
begin
  Result := FEntidade.DTAGE;
end;

function Tcontrolleragenda.Prioridade(Avalue: Integer): Icontrolleragenda;
begin
  Result := Self;
  FEntidade.PRIORIDADE(Avalue);
end;

function Tcontrolleragenda.Prioridade: Integer;
begin
  Result := FEntidade.PRIORIDADE;
end;

function Tcontrolleragenda.Contrato(Avalue: String): Icontrolleragenda;
begin
  Result := Self;
  FEntidade.CONTRATO(Avalue);
end;

function Tcontrolleragenda.Contrato: String;
begin
  Result := FEntidade.CONTRATO;
end;

function Tcontrolleragenda.Usuario(Avalue: Integer): Icontrolleragenda;
begin
  Result := Self;
  FEntidade.USUARIO(Avalue);
end;

function Tcontrolleragenda.Usuario: Integer;
begin
  Result := FEntidade.USUARIO;
end;

function Tcontrolleragenda.Status(Avalue: Integer): Icontrolleragenda;
begin
  Result := Self;
  FEntidade.STATUS(Avalue);
end;

function Tcontrolleragenda.Status: Integer;
begin
  Result := FEntidade.STATUS;
end;

function Tcontrolleragenda.Grupo(Avalue: String): Icontrolleragenda;
begin
  Result := Self;
  FEntidade.GRUPO(Avalue);
end;

function Tcontrolleragenda.Grupo: String;
begin
  Result := FEntidade.GRUPO;
end;

function Tcontrolleragenda.Seq(Avalue: String): Icontrolleragenda;
begin
  Result := Self;
  FEntidade.SEQ(Avalue);
end;

function Tcontrolleragenda.Seq: String;
begin
  Result := FEntidade.SEQ;
end;

function Tcontrolleragenda.Cota(Avalue: String): Icontrolleragenda;
begin
  Result := Self;
  FEntidade.COTA(Avalue);
end;

function Tcontrolleragenda.Cota: String;
begin
  Result := FEntidade.COTA;
end;

function Tcontrolleragenda.Obs(Avalue: Tmemorystream): Icontrolleragenda;
begin
  Result := Self;
  FEntidade.OBS(Avalue);
end;

function Tcontrolleragenda.Obs: Tmemorystream;
begin
  Result := FEntidade.OBS;
end;

function Tcontrolleragenda.Dcprioridade: String;
begin
  Result := FEntidade.DCPRIORIDADE;
end;

function Tcontrolleragenda.Nmusuario: String;
begin
  Result := FEntidade.NMUSUARIO;
end;

function Tcontrolleragenda.Nmcota: String;
begin
  Result := FEntidade.NMCOTA;
end;

function Tcontrolleragenda.Dcstatus: String;
begin
  Result := FEntidade.DCSTATUS;
end;

end.

