unit cobcons.controller.cotacaomoeda;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db, CheckLst;

type

    { TControllerCotacaoMoeda }

    TControllerCotacaoMoeda = class (TInterfacedObject, iControllerCotacaoMoeda)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelCotacaoMoeda;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerCotacaoMoeda;

      procedure GravarCotacoes;
      function GerarDatasetCotacoes: TDataSet;
      function AlternarStatusCotacao(pCotacao: integer): iControllerCotacaoMoeda;
      function CalcularCotacoes: iControllerCotacaoMoeda;
      function GerarListaCotacoes(Pinicio, Pfim: Tdatetime; Pconsiderasabado, Pconsideradomingo: Boolean): iControllerCotacaoMoeda;
      procedure AtualizarListBox(var pListBox: TCheckListBox);
      function Dataset: TDataSet;
      function ListarComboBox: TStringList;
      function Cotacaomoeda(Pmoeda: String; Pdata: Tdatetime): Double;
      function UltimaCotacaoMoeda(pMoeda: string): iControllerCotacaoMoeda;
      function ListarCotacoesMoeda(pMoeda: string; pData: TDateTime): iControllerCotacaoMoeda;
      function NovaCotacaoMoeda(pMoeda: string; pData: TDateTime; pCotacao: Double): iControllerCotacaoMoeda;
      function MOEDA: String; overload;
      function MOEDA(avalue: String): iControllerCotacaoMoeda; overload;
      function INDICE(aValue: Double): iControllerCotacaoMoeda;
      function DATA: TDateTime;
      function COTACAO: Double;
      function DIAS: Integer;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerCotacaoMoeda }

constructor Tcontrollercotacaomoeda.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.CotacaoMoeda(fQuery);
end;

destructor Tcontrollercotacaomoeda.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollercotacaomoeda.New: Icontrollercotacaomoeda;
begin
  Result := Self.Create;
end;

procedure Tcontrollercotacaomoeda.Gravarcotacoes;
begin
  FEntidade.GravarCotacoes;
end;

function Tcontrollercotacaomoeda.Gerardatasetcotacoes: Tdataset;
begin
  Result := FEntidade.GerarDatasetCotacoes;
end;

function Tcontrollercotacaomoeda.Alternarstatuscotacao(Pcotacao: Integer): Icontrollercotacaomoeda;
begin
  Result := Self;
  FEntidade.AlternarStatusCotacao(Pcotacao);
end;

function Tcontrollercotacaomoeda.Calcularcotacoes: Icontrollercotacaomoeda;
begin
  Result := Self;
  FEntidade.CalcularCotacoes;
end;

function Tcontrollercotacaomoeda.Gerarlistacotacoes(Pinicio, Pfim: Tdatetime; Pconsiderasabado, Pconsideradomingo: Boolean): Icontrollercotacaomoeda;
begin
  Result := Self;
  FEntidade.Gerarlistacotacoes(Pinicio, Pfim, Pconsiderasabado, Pconsideradomingo);
end;

procedure Tcontrollercotacaomoeda.Atualizarlistbox(var Plistbox: Tchecklistbox);
begin
  FEntidade.AtualizarListBox(Plistbox);
end;

function Tcontrollercotacaomoeda.Dataset: Tdataset;
begin
  Result := FEntidade.Dataset;
end;

function Tcontrollercotacaomoeda.Listarcombobox: Tstringlist;
begin
  Result := FEntidade.ListarComboBox;
end;

function Tcontrollercotacaomoeda.Cotacaomoeda(Pmoeda: String; Pdata: Tdatetime): Double;
begin
  Result := FEntidade.CotacaoMoeda(Pmoeda, Pdata);
end;

function Tcontrollercotacaomoeda.Ultimacotacaomoeda(Pmoeda: String): Icontrollercotacaomoeda;
begin
  Result := Self;
  FEntidade.UltimaCotacaoMoeda(Pmoeda);
end;

function Tcontrollercotacaomoeda.Listarcotacoesmoeda(Pmoeda: String; Pdata: Tdatetime): Icontrollercotacaomoeda;
begin
  Result := Self;
  FEntidade.ListarCotacoesMoeda(Pmoeda, Pdata);
end;

function Tcontrollercotacaomoeda.Novacotacaomoeda(Pmoeda: String; Pdata: Tdatetime; Pcotacao: Double): Icontrollercotacaomoeda;
begin
  Result := Self;
  FEntidade.NovaCotacaoMoeda(Pmoeda, Pdata, Pcotacao);
end;

function Tcontrollercotacaomoeda.Moeda: String;
begin
  Result := FEntidade.MOEDA;
end;

function Tcontrollercotacaomoeda.Moeda(Avalue: String): Icontrollercotacaomoeda;
begin
  Result := Self;
  FEntidade.MOEDA(Avalue);
end;

function Tcontrollercotacaomoeda.Indice(Avalue: Double): Icontrollercotacaomoeda;
begin
  Result := Self;
  FEntidade.INDICE(Avalue);
end;

function Tcontrollercotacaomoeda.Data: Tdatetime;
begin
  Result := FEntidade.DATA;
end;

function Tcontrollercotacaomoeda.Cotacao: Double;
begin
  Result := FEntidade.COTACAO;
end;

function Tcontrollercotacaomoeda.Dias: Integer;
begin
  Result := FEntidade.DIAS;
end;

end.

