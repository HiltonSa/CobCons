unit cobcons.controller.grupo;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerGrupo }

    TControllerGrupo = class (TInterfacedObject, iControllerGrupo)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelGrupo;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerGrupo;

      function RetornaGrupo(pGrupo: string): iControllerGrupo;
      function RetornaListaGrupos: iControllerGrupo;
      function Dataset: TDataSet;
      function GRUPO: string;
      function PLA_PADR: string;
      function LIM_COTA: string;
      function PRIM_REU: TDateTime;
      function TP_GRUPO: string;
      function DCTPGRUPO: string;
      function SIT_GRUPO: string;
      function DCSITGRUPO: string;
      function DT_SITUA: TDateTime;
      function ULT_REUNIAO: TDateTime;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerGrupo }

constructor Tcontrollergrupo.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Grupo(fQuery);
end;

destructor Tcontrollergrupo.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollergrupo.New: Icontrollergrupo;
begin
  Result := Self.Create;
end;

function Tcontrollergrupo.Retornagrupo(Pgrupo: String): Icontrollergrupo;
begin
  Result := Self;
  FEntidade.RetornaGrupo(Pgrupo);
end;

function Tcontrollergrupo.Retornalistagrupos: Icontrollergrupo;
begin
  Result := Self;
  FEntidade.RetornaListaGrupos;
end;

function Tcontrollergrupo.Dataset: Tdataset;
begin
  Result := FEntidade.Dataset;
end;

function Tcontrollergrupo.Grupo: String;
begin
  Result := FEntidade.GRUPO;
end;

function Tcontrollergrupo.Pla_padr: String;
begin
  Result := FEntidade.PLA_PADR;
end;

function Tcontrollergrupo.Lim_cota: String;
begin
  Result := FEntidade.LIM_COTA;
end;

function Tcontrollergrupo.Prim_reu: Tdatetime;
begin
  Result := FEntidade.PRIM_REU;
end;

function Tcontrollergrupo.Tp_grupo: String;
begin
  Result := FEntidade.TP_GRUPO;
end;

function Tcontrollergrupo.Dctpgrupo: String;
begin
  Result := FEntidade.DCTPGRUPO;
end;

function Tcontrollergrupo.Sit_grupo: String;
begin
  Result := FEntidade.SIT_GRUPO;
end;

function Tcontrollergrupo.Dcsitgrupo: String;
begin
  Result := FEntidade.DCSITGRUPO;
end;

function Tcontrollergrupo.Dt_situa: Tdatetime;
begin
  Result := FEntidade.DT_SITUA;
end;

function Tcontrollergrupo.Ult_reuniao: Tdatetime;
begin
  Result := FEntidade.ULT_REUNIAO;
end;

end.


