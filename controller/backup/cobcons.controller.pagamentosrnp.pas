unit cobcons.controller.pagamentosrnp;

{$mode Delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.bufferdataset, DateUtils, cobcons.controller.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TMControllerPagamentosRnp }

   { TControllerPagamentosRnp }

   TControllerPagamentosRnp = class (TInterfacedObject, iControllerPgRnp)
     private
       FConexao: iModelConexao;
       fQuery : iQueryRest;
       FEntidade: iModelPgRnp;

     public
       constructor Create;
       destructor Destroy; override;
       class function New: iControllerPgRnp;

       function TabelaExiste: Boolean;
       function CriarTabela: iControllerPgRnp;
       function Novo: iControllerPgRnp;
       function Gravar: iControllerPgRnp;
       function GravarPagamento: iControllerPgRnp;
       function GravarStatus: iControllerPgRnp;
       function DataSet: TDataSet;
       function TemDados: Boolean;
       function Proximo: Boolean;
       function RetornaPagamentoCota: iControllerPgRnp;
       function RetornaStatus: iControllerPgRnp;
       function BaixarPagamentosDataset(pAgente, pTipoDoc, pHistorico: String; pContab: TDateTime; pTotal: Double; pDataSet: TDataSet): iControllerPgRnp;
       function GerarExportacao(pEmp, pFilial, pPartida, pContra1, pContra2: String; pContab: TDateTime; pPagtos: TDataSet; var pArquivo: TStringList; pMarcar: Boolean): iControllerPgRnp;
       function GerarAsvr(pTipo, pCnpj: String; pInicio, pFim: TDateTime;
         pArquivo: TStringList): iControllerPgRnp;
       function Excluir: iControllerPgRnp;
       function AtualizarValorPagar: iControllerPgRnp;

       function CODIGO(aValue: Integer): iControllerPgRnp; overload;
       function CODIGO: Integer; overload;
       function GRUPO(aValue: String): iControllerPgRnp; overload;
       function SEQ(aValue: String): iControllerPgRnp; overload;
       function COTA(aValue: String): iControllerPgRnp; overload;
       function GRUPO: String; overload;
       function SEQ: String; overload;
       function COTA: String; overload;
       function STATUS(aValue: Integer): iControllerPgRnp; overload;
       function STATUS: Integer; overload;
       function VALOR(aValue: Double): iControllerPgRnp; overload;
       function VALOR: Double; overload;
       function DTPEDIDO(aValue: TDateTime): iControllerPgRnp; overload;
       function DTPEDIDO: TDateTime; overload;
       function DTPROG(aValue: TDateTime): iControllerPgRnp; overload;
       function DTPROG: TDateTime; overload;
       function DTPAGTO(aValue: TDateTime): iControllerPgRnp; overload;
       function DTPAGTO: TDateTime; overload;
       function FRMPG(aValue: Integer): iControllerPgRnp; overload;
       function FRMPG: Integer; overload;
       function TIPOPIX(aValue: Integer): iControllerPgRnp; overload;
       function TIPOPIX: Integer; overload;
       function CHAVEPIX(aValue: String): iControllerPgRnp; overload;
       function CHAVEPIX: String; overload;
       function BANCO(aValue: String): iControllerPgRnp; overload;
       function BANCO: String; overload;
       function AGENCIA(aValue: String): iControllerPgRnp; overload;
       function AGENCIA: String; overload;
       function CONTA(aValue: String): iControllerPgRnp; overload;
       function CONTA: String; overload;
       function OBS(aValue: String): iControllerPgRnp; overload;
       function OBS: String; overload;
       function DCSIT: String;
   end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;


{ TControllerPagamentosRnp }

constructor TControllerPagamentosRnp.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.PgRnp(fQuery);
end;

destructor TControllerPagamentosRnp.Destroy;
begin
  inherited Destroy;
end;

class function TControllerPagamentosRnp.New: iControllerPgRnp;
begin
  Result := Self.Create;
end;

function TControllerPagamentosRnp.TabelaExiste: Boolean;
begin
  Result := FEntidade.TabelaExiste;
end;

function TControllerPagamentosRnp.CriarTabela: iControllerPgRnp;
begin
  Result := Self;
  FEntidade.CriarTabela;
end;

function TControllerPagamentosRnp.Novo: iControllerPgRnp;
begin
  Result := Self;
  FEntidade.Novo;
end;

function TControllerPagamentosRnp.Gravar: iControllerPgRnp;
begin
  Result := Self;
  FEntidade.Gravar;
end;

function TControllerPagamentosRnp.GravarPagamento: iControllerPgRnp;
begin
  Result := Self;
  FEntidade.GravarPagamento;
end;

function TControllerPagamentosRnp.GravarStatus: iControllerPgRnp;
begin
  Result := Self;
  FEntidade.GravarStatus;
end;

function TControllerPagamentosRnp.DataSet: TDataSet;
begin
  Result := FEntidade.DataSet;
end;

function TControllerPagamentosRnp.TemDados: Boolean;
begin
  Result := FEntidade.TemDados;
end;

function TControllerPagamentosRnp.Proximo: Boolean;
begin
  Result := FEntidade.Proximo;
end;

function TControllerPagamentosRnp.RetornaPagamentoCota: iControllerPgRnp;
begin
  Result := Self;
  FEntidade.RetornaPagamentoCota;
end;

function TControllerPagamentosRnp.RetornaStatus: iControllerPgRnp;
begin
  Result := Self;
  FEntidade.RetornaStatus;
end;

function TControllerPagamentosRnp.BaixarPagamentosDataset(pAgente, pTipoDoc,
  pHistorico: String; pContab: TDateTime; pTotal: Double; pDataSet: TDataSet
  ): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.BaixarPagamentosDataset( pAgente,
                                     pTipoDoc,
                                     pHistorico,
                                     pContab,
                                     pTotal,
                                     pDataSet);
end;

function TControllerPagamentosRnp.GerarExportacao(pEmp, pFilial, pPartida,
  pContra1, pContra2: String; pContab: TDateTime; pPagtos: TDataSet;
  var pArquivo: TStringList; pMarcar: Boolean): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.GerarExportacao(pEmp, pFilial, pPartida, pContra1, pContra2, pContab, pPagtos, pArquivo, pMarcar);
end;

function TControllerPagamentosRnp.GerarAsvr(pTipo, pCnpj: String; pInicio,
  pFim: TDateTime; pArquivo: TStringList): iControllerPgRnp;
begin
  FEntidade.GerarAsvr(pTipo, pCnpj, pInicio, pFim, pArquivo);
  Result := Self;
end;

function TControllerPagamentosRnp.Excluir: iControllerPgRnp;
begin
  Result := Self;
  FEntidade.Excluir;
end;

function TControllerPagamentosRnp.AtualizarValorPagar: iControllerPgRnp;
begin
  Result := Self;
  FEntidade.AtualizarValorPagar;
end;

function TControllerPagamentosRnp.CODIGO(aValue: Integer): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.CODIGO(aValue);
end;

function TControllerPagamentosRnp.CODIGO: Integer;
begin
  Result := FEntidade.CODIGO;
end;

function TControllerPagamentosRnp.GRUPO(aValue: String): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.GRUPO(aValue);
end;

function TControllerPagamentosRnp.SEQ(aValue: String): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.SEQ(aValue);
end;

function TControllerPagamentosRnp.COTA(aValue: String): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.COTA(aValue);
end;

function TControllerPagamentosRnp.GRUPO: String;
begin
  Result := FEntidade.GRUPO;
end;

function TControllerPagamentosRnp.SEQ: String;
begin
  Result := FEntidade.SEQ;
end;

function TControllerPagamentosRnp.COTA: String;
begin
  Result := FEntidade.COTA;
end;

function TControllerPagamentosRnp.STATUS(aValue: Integer): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.STATUS(aValue);
end;

function TControllerPagamentosRnp.STATUS: Integer;
begin
  Result := FEntidade.STATUS;
end;

function TControllerPagamentosRnp.VALOR(aValue: Double): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.VALOR(aValue);
end;

function TControllerPagamentosRnp.VALOR: Double;
begin
  Result := FEntidade.VALOR;
end;

function TControllerPagamentosRnp.DTPEDIDO(aValue: TDateTime): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.DTPEDIDO(aValue);
end;

function TControllerPagamentosRnp.DTPEDIDO: TDateTime;
begin
  Result := FEntidade.DTPEDIDO;
end;

function TControllerPagamentosRnp.DTPROG(aValue: TDateTime): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.DTPROG(aValue);
end;

function TControllerPagamentosRnp.DTPROG: TDateTime;
begin
  Result := FEntidade.DTPROG;
end;

function TControllerPagamentosRnp.DTPAGTO(aValue: TDateTime): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.DTPAGTO(aValue);
end;

function TControllerPagamentosRnp.DTPAGTO: TDateTime;
begin
  Result := FEntidade.DTPAGTO;
end;

function TControllerPagamentosRnp.FRMPG(aValue: Integer): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.FRMPG(aValue);
end;

function TControllerPagamentosRnp.FRMPG: Integer;
begin
  Result := FEntidade.FRMPG;
end;

function TControllerPagamentosRnp.TIPOPIX(aValue: Integer): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.TIPOPIX(aValue);
end;

function TControllerPagamentosRnp.TIPOPIX: Integer;
begin
  Result := FEntidade.TIPOPIX;
end;

function TControllerPagamentosRnp.CHAVEPIX(aValue: String): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.CHAVEPIX(aValue);
end;

function TControllerPagamentosRnp.CHAVEPIX: String;
begin
  Result := FEntidade.CHAVEPIX;
end;

function TControllerPagamentosRnp.BANCO(aValue: String): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.BANCO(aValue);
end;

function TControllerPagamentosRnp.BANCO: String;
begin
  Result := FEntidade.BANCO;
end;

function TControllerPagamentosRnp.AGENCIA(aValue: String): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.AGENCIA(aValue);
end;

function TControllerPagamentosRnp.AGENCIA: String;
begin
  Result := FEntidade.AGENCIA;
end;

function TControllerPagamentosRnp.CONTA(aValue: String): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.CONTA(aValue);
end;

function TControllerPagamentosRnp.CONTA: String;
begin
  Result := FEntidade.CONTA;
end;

function TControllerPagamentosRnp.OBS(aValue: String): iControllerPgRnp;
begin
  Result := Self;
  FEntidade.OBS(aValue);
end;

function TControllerPagamentosRnp.OBS: String;
begin
  Result := FEntidade.OBS;
end;

function TControllerPagamentosRnp.DCSIT: String;
begin
  Result := FEntidade.DCSIT;
end;

end.



