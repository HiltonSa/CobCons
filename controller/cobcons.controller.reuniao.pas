unit cobcons.controller.reuniao;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerReuniao }

    TControllerReuniao = class (TInterfacedObject, iControllerReuniao)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelReuniao;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerReuniao;

      function RetornaReuniaoPagamento(pGrupo: String; pDtPag: TDateTime): iControllerReuniao;
      function RetornaReuniaoGrupo(pGrupo: String): iControllerReuniao;
      function Dataset: TDataSet;
      function DATA_REU: TDateTime;
      function NRO_REU: string;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerReuniao }

constructor Tcontrollerreuniao.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Reuniao(fQuery);
end;

destructor Tcontrollerreuniao.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollerreuniao.New: Icontrollerreuniao;
begin
  Result := Self.Create;
end;

function Tcontrollerreuniao.Retornareuniaopagamento(Pgrupo: String; Pdtpag: Tdatetime): Icontrollerreuniao;
begin
  Result := Self;
  FEntidade.RetornaReuniaoPagamento(Pgrupo, Pdtpag);
end;

function Tcontrollerreuniao.Retornareuniaogrupo(Pgrupo: String): Icontrollerreuniao;
begin
  Result := Self;
  FEntidade.RetornaReuniaoGrupo(Pgrupo);
end;

function Tcontrollerreuniao.Dataset: Tdataset;
begin
  Result := FEntidade.Dataset;
end;

function Tcontrollerreuniao.Data_reu: Tdatetime;
begin
  Result := FEntidade.DATA_REU;
end;

function Tcontrollerreuniao.Nro_reu: String;
begin
  Result := FEntidade.NRO_REU;
end;

end.


