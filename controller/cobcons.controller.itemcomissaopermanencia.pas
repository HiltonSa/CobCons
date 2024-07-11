unit cobcons.controller.itemcomissaopermanencia;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db, ComCtrls, ExtCtrls;

type

    { TControllerItemComissaoPermanencia }

    TControllerItemComissaoPermanencia = class (TInterfacedObject, iControllerItemComissaoPermanencia)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelItemComissaoPermanencia;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerItemComissaoPermanencia;

      function CriarTabela: iControllerItemComissaoPermanencia;
      function TabelaExiste: Boolean;
      procedure NovoItem;
      function ListarItensComissao(pCmPer: Integer): iControllerItemComissaoPermanencia;
      function ListarItensComissaoGrupo(pCmPer: Integer; pGrupo: String): iControllerItemComissaoPermanencia;
      function ListarItensComissaoSinteticoGrupo(pCmPer: Integer): iControllerItemComissaoPermanencia;
      function ExisteCalculoCota(pGrupo, pSeq, pCota: String): iControllerItemComissaoPermanencia;
      function DataSet: TDataSet;
      function TemDados: Boolean;
      function Proximo: Boolean;
      function NovoCodigo: Integer;
      procedure AlteraCmPer(pCmPer: Integer);
      procedure ApagaCalculo;
      procedure ApagaItens(pCalculo: Integer);
      function CODIGO(aValue: Integer): iControllerItemComissaoPermanencia;
      function CMPER(aValue: Integer): iControllerItemComissaoPermanencia;
      function GRUPO(aValue: String): iControllerItemComissaoPermanencia; overload;
      function SEQ(aValue: String): iControllerItemComissaoPermanencia; overload;
      function COTA(aValue: String): iControllerItemComissaoPermanencia; overload;
      function SDINICIAL(aValue: Double): iControllerItemComissaoPermanencia; overload;
      function COMISSAO(aValue: Double): iControllerItemComissaoPermanencia; overload;
      function SDFINAL(aValue: Double): iControllerItemComissaoPermanencia; overload;
      function SDFINAL: Double; overload;
      function SDINICIAL: Double; overload;
      function GRUPO: String; overload;
      function SEQ: String; overload;
      function COTA: String; overload;
      function COMISSAO: Double; overload;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerItemComissaoPermanencia }

constructor TControllerItemComissaoPermanencia.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.ItemComissaoPermanencia(fQuery);
end;

destructor TControllerItemComissaoPermanencia.Destroy;
begin
  inherited Destroy;
end;

class function TControllerItemComissaoPermanencia.New: iControllerItemComissaoPermanencia;
begin
  Result := Self.Create;
end;

function TControllerItemComissaoPermanencia.CriarTabela: iControllerItemComissaoPermanencia;
begin
  Result := Self;
  FEntidade.CriarTabela;
end;

function TControllerItemComissaoPermanencia.TabelaExiste: Boolean;
begin
  Result := FEntidade.TabelaExiste;
end;

procedure TControllerItemComissaoPermanencia.NovoItem;
begin
  FEntidade.NovoItem;
end;

function TControllerItemComissaoPermanencia.ListarItensComissao(pCmPer: Integer
  ): iControllerItemComissaoPermanencia;
begin
  FEntidade.ListarItensComissao(Pcmper);
  Result := Self;
end;

function TControllerItemComissaoPermanencia.ListarItensComissaoGrupo(
  pCmPer: Integer; pGrupo: String): iControllerItemComissaoPermanencia;
begin
  FEntidade.ListarItensComissaoGrupo(Pcmper, Pgrupo);
  Result := Self;
end;

function TControllerItemComissaoPermanencia.ListarItensComissaoSinteticoGrupo(
  pCmPer: Integer): iControllerItemComissaoPermanencia;
begin
  FEntidade.ListarItensComissaoSinteticoGrupo(Pcmper);
  Result := Self;
end;

function TControllerItemComissaoPermanencia.ExisteCalculoCota(pGrupo, pSeq,
  pCota: String): iControllerItemComissaoPermanencia;
begin
  FEntidade.ExisteCalculoCota(pGrupo, pSeq, pCota);
  Result := Self;
end;

function TControllerItemComissaoPermanencia.DataSet: TDataSet;
begin
  Result := FEntidade.DataSet;
end;

function TControllerItemComissaoPermanencia.TemDados: Boolean;
begin
  Result := FEntidade.TemDados;
end;

function TControllerItemComissaoPermanencia.Proximo: Boolean;
begin
  Result := FEntidade.Proximo;
end;

procedure TControllerItemComissaoPermanencia.AlteraCmPer(pCmPer: Integer);
begin
  FEntidade.AlteraCmPer(Pcmper);
end;

procedure TControllerItemComissaoPermanencia.ApagaCalculo;
begin
  FEntidade.ApagaCalculo;
end;

procedure TControllerItemComissaoPermanencia.ApagaItens(pCalculo: Integer);
begin
  FEntidade.ApagaItens(Pcalculo);
end;

function TControllerItemComissaoPermanencia.NovoCodigo: Integer;
begin
  Result := FEntidade.NovoCodigo;
end;

function TControllerItemComissaoPermanencia.CODIGO(aValue: Integer
  ): iControllerItemComissaoPermanencia;
begin
  Result := Self;
  FEntidade.CODIGO(Avalue);
end;

function TControllerItemComissaoPermanencia.CMPER(aValue: Integer
  ): iControllerItemComissaoPermanencia;
begin
  Result := Self;
  FEntidade.CMPER(Avalue);
end;

function TControllerItemComissaoPermanencia.GRUPO(aValue: String
  ): iControllerItemComissaoPermanencia;
begin
  Result := Self;
  FEntidade.GRUPO(Avalue);
end;

function TControllerItemComissaoPermanencia.SEQ(aValue: String
  ): iControllerItemComissaoPermanencia;
begin
  Result := Self;
  FEntidade.SEQ(Avalue);
end;

function TControllerItemComissaoPermanencia.COTA(aValue: String
  ): iControllerItemComissaoPermanencia;
begin
  Result := Self;
  FEntidade.COTA(Avalue);
end;

function TControllerItemComissaoPermanencia.SDINICIAL(aValue: Double
  ): iControllerItemComissaoPermanencia;
begin
  Result := Self;
  FEntidade.SDINICIAL(Avalue);
end;

function TControllerItemComissaoPermanencia.COMISSAO(aValue: Double
  ): iControllerItemComissaoPermanencia;
begin
  Result := Self;
  FEntidade.COMISSAO(Avalue);
end;

function TControllerItemComissaoPermanencia.SDFINAL(aValue: Double
  ): iControllerItemComissaoPermanencia;
begin
  Result := Self;
  FEntidade.SDFINAL(Avalue);
end;

function TControllerItemComissaoPermanencia.SDFINAL: Double;
begin
  Result := FEntidade.SDFINAL;
end;

function TControllerItemComissaoPermanencia.SDINICIAL: Double;
begin
  Result := FEntidade.SDINICIAL;
end;

function TControllerItemComissaoPermanencia.GRUPO: String;
begin
  Result := FEntidade.GRUPO;
end;

function TControllerItemComissaoPermanencia.SEQ: String;
begin
  Result := FEntidade.SEQ;
end;

function TControllerItemComissaoPermanencia.COTA: String;
begin
  Result := FEntidade.COTA;
end;

function TControllerItemComissaoPermanencia.COMISSAO: Double;
begin
  Result := FEntidade.COMISSAO;
end;

end.

