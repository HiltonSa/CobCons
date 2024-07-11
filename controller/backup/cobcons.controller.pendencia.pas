unit cobcons.controller.pendencia;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerPendencia }

    TControllerPendencia= class (TInterfacedObject, iControllerPendencia)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelPendencia;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerPendencia;

      function RetornaPendenciaCota(pGrupo, pSeq, pCota: String): iControllerPendencia;
      function RetornaAviso(pGrupo, pSeq, pCota, pAviso: String): iControllerPendencia;
      function Novo: iControllerPendencia;
      function Excluir: iControllerPendencia;
      function ExcluirSQG: iModelPendencia;
      function ProximoAviso: String;
      function DataSet: TDataSet;
      function GRUPO(aValue: String): iControllerPendencia;
      function SEQ(aValue: String): iControllerPendencia;
      function COTA(aValue: String): iControllerPendencia;
      function AVISO(aValue: String): iControllerPendencia; overload;
      function TIPO_MOV(aValue: String): iControllerPendencia; overload;
      function AG_COBRA(aValue: String): iControllerPendencia;
      function D_VENCTO(aValue: TDateTime): iControllerPendencia; overload;
      function PCNOR(aValue: Double): iControllerPendencia; overload;
      function P_RATEIO(aValue: Double): iControllerPendencia; overload;
      function F_AQUISI(aValue: Double): iControllerPendencia; overload;
      function ADMINIST(aValue: Double): iControllerPendencia; overload;
      function F_RESERV(aValue: Double): iControllerPendencia; overload;
      function OUTROS(aValue: Double): iControllerPendencia; overload;
      function AVISO: String; overload;
      function TIPO_MOV: String; overload;
      function D_VENCTO: TDateTime; overload;
      function PCNOR: Double; overload;
      function OUTROS: Double; overload;
      function F_AQUISI: Double; overload;
      function ADMINIST: Double; overload;
      function F_RESERV: Double; overload;
      function P_RATEIO: Double; overload;
      function VALOR: Double;
      function DCTIPOMOV: String;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerPendencia }

constructor TControllerPendencia.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Pendencia(fQuery);
end;

destructor TControllerPendencia.Destroy;
begin
  inherited Destroy;
end;

class function TControllerPendencia.New: iControllerPendencia;
begin
  Result := Self.Create;
end;

function TControllerPendencia.RetornaPendenciaCota(pGrupo, pSeq, pCota: String
  ): iControllerPendencia;
begin
  Result := Self;
  FEntidade.RetornaPendenciaCota(Pgrupo, Pseq, Pcota);
end;

function TControllerPendencia.RetornaAviso(pGrupo, pSeq, pCota, pAviso: String
  ): iControllerPendencia;
begin
  Result := Self;
  FEntidade.RetornaAviso(Pgrupo, Pseq, Pcota, Paviso);
end;

function TControllerPendencia.Novo: iControllerPendencia;
begin
  Result := Self;
  FEntidade.Novo;
end;

function TControllerPendencia.Excluir: iControllerPendencia;
begin
  Result := Self;
  FEntidade.Excluir;
end;

function TControllerPendencia.ExcluirSQG: iModelPendencia;
begin
  Result := Self;
  FEntidade.ExcluirSQG;
end;

function TControllerPendencia.ProximoAviso: String;
begin
  Result := FEntidade.ProximoAviso;
end;

function TControllerPendencia.DataSet: TDataSet;
begin
  Result := FEntidade.DataSet;
end;

function TControllerPendencia.GRUPO(aValue: String): iControllerPendencia;
begin
  Result := Self;
  FEntidade.GRUPO(Avalue);
end;

function TControllerPendencia.SEQ(aValue: String): iControllerPendencia;
begin
  Result := Self;
  FEntidade.SEQ(Avalue);
end;

function TControllerPendencia.COTA(aValue: String): iControllerPendencia;
begin
  Result := Self;
  FEntidade.COTA(Avalue);
end;

function TControllerPendencia.AVISO(aValue: String): iControllerPendencia;
begin
  Result := Self;
  FEntidade.AVISO(Avalue);
end;

function TControllerPendencia.TIPO_MOV(aValue: String): iControllerPendencia;
begin
  Result := Self;
  FEntidade.TIPO_MOV(Avalue);
end;

function TControllerPendencia.AG_COBRA(aValue: String): iControllerPendencia;
begin
  Result := Self;
  FEntidade.AG_COBRA(Avalue);
end;

function TControllerPendencia.D_VENCTO(aValue: TDateTime): iControllerPendencia;
begin
  Result := Self;
  FEntidade.D_VENCTO(Avalue);
end;

function TControllerPendencia.PCNOR(aValue: Double): iControllerPendencia;
begin
  Result := Self;
  FEntidade.PCNOR(Avalue);
end;

function TControllerPendencia.P_RATEIO(aValue: Double): iControllerPendencia;
begin
  Result := Self;
  FEntidade.P_RATEIO(Avalue);
end;

function TControllerPendencia.F_AQUISI(aValue: Double): iControllerPendencia;
begin
  Result := Self;
  FEntidade.F_AQUISI(Avalue);
end;

function TControllerPendencia.ADMINIST(aValue: Double): iControllerPendencia;
begin
  Result := Self;
  FEntidade.ADMINIST(Avalue);
end;

function TControllerPendencia.F_RESERV(aValue: Double): iControllerPendencia;
begin
  Result := Self;
  FEntidade.F_RESERV(Avalue);
end;

function TControllerPendencia.OUTROS(aValue: Double): iControllerPendencia;
begin
  Result := Self;
  FEntidade.OUTROS(Avalue);
end;

function TControllerPendencia.AVISO: String;
begin
  Result := FEntidade.AVISO;
end;

function TControllerPendencia.TIPO_MOV: String;
begin
  Result := FEntidade.TIPO_MOV;
end;

function TControllerPendencia.DCTIPOMOV: String;
begin
  Result := FEntidade.DCTIPOMOV;
end;

function TControllerPendencia.D_VENCTO: TDateTime;
begin
  Result := FEntidade.D_VENCTO;
end;

function TControllerPendencia.PCNOR: Double;
begin
  Result := FEntidade.PCNOR;
end;

function TControllerPendencia.P_RATEIO: Double;
begin
  Result := FEntidade.P_RATEIO;
end;

function TControllerPendencia.VALOR: Double;
begin
  Result := FEntidade.VALOR;
end;

function TControllerPendencia.F_AQUISI: Double;
begin
  Result := FEntidade.F_AQUISI;
end;

function TControllerPendencia.ADMINIST: Double;
begin
  Result := FEntidade.ADMINIST;
end;

function TControllerPendencia.F_RESERV: Double;
begin
  Result := FEntidade.F_RESERV;
end;

function TControllerPendencia.OUTROS: Double;
begin
  Result := FEntidade.OUTROS;
end;

end.


