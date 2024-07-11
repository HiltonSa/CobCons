unit cobcons.controller.parcelacomissao;

{$mode Delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces,
  cobcons.model.bufferdataset, db, ComCtrls, ExtCtrls;

type

    { TControllerParcelaComissao }

    TControllerParcelaComissao = class (TInterfacedObject, iControllerParcelaComissao)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelParcelaComissao;

      function Dataset: TDataset;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerParcelaComissao;

      function ListaPorCodigo(pVenda, pParcela: Integer): iControllerParcelaComissao;
      function ListaPorVenda(pVenda: Integer): TDataSet;
      function ExisteParcela(pEmpresa: Integer; pContrato: String; pParcela: Integer): Boolean;
      function RetornarParcelasPendentes(itPsq: Integer; stPesq: String): iModelBufferDataset;
      function Executar(pModo: TpModoManutencao): iControllerParcelaComissao;
      function VENDA: Integer; overload;
      function VENDA(pValor: Integer): iControllerParcelaComissao; overload;
      function PARCELA: Integer; overload;
      function PARCELA(pValor: Integer): iControllerParcelaComissao; overload;
      function DTVENC: TDateTime; overload;
      function DTVENC(pValor: TDateTime): iControllerParcelaComissao; overload;
      function PERIODO: Integer; overload;
      function PERIODO(pValor: Integer): iControllerParcelaComissao; overload;
      function RECEBER: Double; overload;
      function RECEBER(pValor: Double): iControllerParcelaComissao; overload;
      function RECEBIDO: Double; overload;
      function RECEBIDO(pValor: Double): iControllerParcelaComissao; overload;
      function PAGAR: Double; overload;
      function PAGAR(pValor: Double): iControllerParcelaComissao; overload;
      function PAGO: Double; overload;
      function PAGO(pValor: Double): iControllerParcelaComissao; overload;
      function DTREC: TDateTime; overload;
      function DTREC(pValor: TDateTime): iControllerParcelaComissao; overload;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerParcelaComissao }

function TControllerParcelaComissao.Dataset: TDataset;
var
  vLista: TStringList;
begin
  vLista := TStringList.Create;
  try
    FQuery.Dataset.GetFieldNames(vLista);
    if vLista.IndexOf('VENDA') > -1
    then TIntegerField(FQuery.FieldByName('VENDA')).DisplayFormat := '000000';
    if vLista.IndexOf('PARCELA') > -1
    then TIntegerField(FQuery.FieldByName('PARCELA')).DisplayFormat := '00';
    if vLista.IndexOf('DTVENC') > -1
    then TDateTimeField(FQuery.FieldByName('DTVENC')).DisplayFormat := 'dd/mm/yyyy';
    if vLista.IndexOf('DTREC') > -1
    then TDateTimeField(FQuery.FieldByName('DTREC')).DisplayFormat := 'dd/mm/yyyy';
    if vLista.IndexOf('RECEBER') > -1
    then TFloatField(FQuery.FieldByName('RECEBER')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('RECEBIDO') > -1
    then TFloatField(FQuery.FieldByName('RECEBIDO')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('PAGAR') > -1
    then TFloatField(FQuery.FieldByName('PAGAR')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('PAGO') > -1
    then TFloatField(FQuery.FieldByName('PAGO')).DisplayFormat := ',#0.00';
    Result := FQuery.Dataset;
  finally
    vLista.Free;
  end;
end;

constructor TControllerParcelaComissao.Create;
begin
  FConexao := TControllerFactory.New.Conexao(2);
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.ParcelaComissao(fQuery);
end;

destructor TControllerParcelaComissao.Destroy;
begin
  inherited Destroy;
end;

class function TControllerParcelaComissao.New: iControllerParcelaComissao;
begin
  Result := Self.Create;
end;

function TControllerParcelaComissao.ListaPorCodigo(pVenda, pParcela: Integer
  ): iControllerParcelaComissao;
begin
  FEntidade.ListaPorCodigo(pVenda, pParcela);
  Result := Self;
end;

function TControllerParcelaComissao.ListaPorVenda(pVenda: Integer): TDataSet;
begin
  FEntidade.ListaPorVenda(pVenda);
  Result := Dataset;
end;

function TControllerParcelaComissao.ExisteParcela(pEmpresa: Integer;
  pContrato: String; pParcela: Integer): Boolean;
begin
  Result := FEntidade.ExisteParcela(pEmpresa, pContrato, pParcela);
end;

function TControllerParcelaComissao.RetornarParcelasPendentes(itPsq: Integer;
  stPesq: String): iModelBufferDataset;
begin
  Result := FEntidade.RetornarParcelasPendentes(itPsq, stPesq);
end;

function TControllerParcelaComissao.Executar(pModo: TpModoManutencao): iControllerParcelaComissao;
begin
  Result := Self;
  FEntidade.Executar(pModo);
end;

function TControllerParcelaComissao.VENDA: Integer;
begin
  Result := FEntidade.VENDA;
end;

function TControllerParcelaComissao.VENDA(pValor: Integer
  ): iControllerParcelaComissao;
begin
  Result := Self;
  FEntidade.VENDA(pValor);
end;

function TControllerParcelaComissao.PARCELA: Integer;
begin
  Result := FEntidade.PARCELA;
end;

function TControllerParcelaComissao.PARCELA(pValor: Integer
  ): iControllerParcelaComissao;
begin
  Result := Self;
  FEntidade.PARCELA(pValor);
end;

function TControllerParcelaComissao.DTVENC: TDateTime;
begin
  Result := FEntidade.DTVENC;
end;

function TControllerParcelaComissao.DTVENC(pValor: TDateTime
  ): iControllerParcelaComissao;
begin
  Result := Self;
  FEntidade.DTVENC(pValor);
end;

function TControllerParcelaComissao.PERIODO: Integer;
begin
  Result := FEntidade.PERIODO;
end;

function TControllerParcelaComissao.PERIODO(pValor: Integer
  ): iControllerParcelaComissao;
begin
  Result := Self;
  FEntidade.PERIODO(pValor);
end;

function TControllerParcelaComissao.RECEBER: Double;
begin
  Result := FEntidade.RECEBER;
end;

function TControllerParcelaComissao.RECEBER(pValor: Double
  ): iControllerParcelaComissao;
begin
  Result := Self;
  FEntidade.RECEBER(pValor);
end;

function TControllerParcelaComissao.RECEBIDO: Double;
begin
  Result := FEntidade.RECEBIDO;
end;

function TControllerParcelaComissao.RECEBIDO(pValor: Double
  ): iControllerParcelaComissao;
begin
  Result := Self;
  FEntidade.RECEBIDO(pValor);
end;

function TControllerParcelaComissao.PAGAR: Double;
begin
  Result := FEntidade.PAGAR;
end;

function TControllerParcelaComissao.PAGAR(pValor: Double
  ): iControllerParcelaComissao;
begin
  Result := Self;
  FEntidade.PAGAR(pValor);
end;

function TControllerParcelaComissao.PAGO: Double;
begin
  Result := FEntidade.PAGO;
end;

function TControllerParcelaComissao.PAGO(pValor: Double
  ): iControllerParcelaComissao;
begin
  Result := Self;
  FEntidade.PAGO(pValor);
end;

function TControllerParcelaComissao.DTREC: TDateTime;
begin
  Result := FEntidade.DTREC;
end;

function TControllerParcelaComissao.DTREC(pValor: TDateTime
  ): iControllerParcelaComissao;
begin
  Result := Self;
  FEntidade.DTREC(pValor);
end;

end.

