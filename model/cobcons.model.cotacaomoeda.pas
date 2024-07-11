unit cobcons.model.cotacaomoeda;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,  CheckLst, BufDataset,
  cobcons.model.sql.interfaces, db, DateUtils;

type

   { TCotacaoDiaria }

   TCotacaoDiaria = record
     Dia: TDateTime;
     Ativo: Boolean;
     Cotacao: Double;
     function RetornaString: String;
   end;


   { TModelCotacaoMoeda }

   TModelCotacaoMoeda = class (TInterfacedObject, iModelCotacaoMoeda)
     private
       FLista: TStringList;
       FQuery: iQueryRest;
       FSQL: iModelSqlCotacaoMoeda;

       FListaCotacoes : array of TCotacaoDiaria;
       FDias: Integer;
       FTempDataset: TBufDataset;
       FMoeda: String;
       FIndice: Double;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelCotacaoMoeda;

       procedure GravarCotacoes;
       function GerarDatasetCotacoes: TDataSet;
       function AlternarStatusCotacao(pCotacao: integer): iModelCotacaoMoeda;
       function CalcularCotacoes: iModelCotacaoMoeda;
       function GerarListaCotacoes(Pinicio, Pfim: Tdatetime; Pconsiderasabado, Pconsideradomingo: Boolean): iModelCotacaoMoeda;
       procedure AtualizarListBox(var pListBox: TCheckListBox);

       function Dataset: TDataSet;
       function ListarComboBox: TStringList;
       function CotacaoMoeda(pMoeda: string; pData: TDateTime): Double;
       function UltimaCotacaoMoeda(pMoeda: string): iModelCotacaoMoeda;
       function ListarCotacoesMoeda(pMoeda: string; pData: TDateTime): iModelCotacaoMoeda;
       function NovaCotacaoMoeda(pMoeda: string; pData: TDateTime; pCotacao: Double): iModelCotacaoMoeda;
       function MOEDA: String; overload;
       function MOEDA(avalue: String): iModelCotacaoMoeda; overload;
       function INDICE(aValue: Double): iModelCotacaoMoeda;
       function DATA: TDateTime;
       function COTACAO: Double;
       function DIAS: Integer;
   end;


implementation

uses cobcons.controller.util, cobcons.model.sql.factory;

{ TCotacaoDiaria }

function Tcotacaodiaria.Retornastring: String;
begin
  Result := Format('%s: %.9f',[FormatDateTime('dd/mm/yy ddd', Dia), Cotacao]);
end;


{ TModelCotacaoMoeda }

constructor Tmodelcotacaomoeda.Create(Aquery: Iqueryrest);
begin
  FSQL := TModelSQLFactory.New.SqlCotacaoMoeda;
  FLista := TStringList.Create;
  FQuery := Aquery;
  FTempDataset := TBufDataset.Create(nil);
  FTempDataset.FieldDefs.Add('DATA', ftString, 20);
  FTempDataset.FieldDefs.Add('COTACAO', ftFloat);
  FTempDataset.CreateDataset;
end;

destructor Tmodelcotacaomoeda.Destroy;
begin
  FLista.Free;
  FTempDataset.Free;
  inherited Destroy;
end;

class function Tmodelcotacaomoeda.New(Aquery: Iqueryrest): Imodelcotacaomoeda;
begin
  Result := Self.Create(Aquery);
end;

procedure Tmodelcotacaomoeda.Gravarcotacoes;
var
  vInd: Integer;
begin
  for vInd := 0 to Pred(Length(FListaCotacoes)) do
  begin
    if FListaCotacoes[vInd].Ativo
    then NovaCotacaoMoeda( FMoeda,
                           FListaCotacoes[vInd].Dia,
                           FListaCotacoes[vInd].Cotacao );
  end;
end;

function Tmodelcotacaomoeda.Gerardatasetcotacoes: Tdataset;
var
  vInd: Integer;
begin
  if FTempDataset.Active
  then FTempDataset.Close;
  FTempDataset.Open;
  for vInd := 0 to Pred(Length(FListaCotacoes)) do
  begin
    FTempDataset.Append;
    FTempDataset.FieldByName('DATA').AsString := FormatDateTime('dd/mm/yy ddd', FListaCotacoes[vInd].Dia);
    FTempDataset.FieldByName('COTACAO').AsFloat := FListaCotacoes[vInd].Cotacao;
    FTempDataset.Post;
  end;
  FTempDataset.First;
  Result := FTempDataset;
end;

function Tmodelcotacaomoeda.Alternarstatuscotacao(Pcotacao: Integer): Imodelcotacaomoeda;
begin
  Result := Self;
  FListaCotacoes[Pcotacao].Ativo := not FListaCotacoes[Pcotacao].Ativo;
  if FListaCotacoes[Pcotacao].Ativo
  then FDias := FDias + 1
  else FDias := FDias - 1;
end;

function Tmodelcotacaomoeda.Calcularcotacoes: Imodelcotacaomoeda;
var
  vCotacao: Double;
  vInd: Integer;
begin
  vCotacao := COTACAO;
  for vInd := 0 to Pred(Length(FListaCotacoes)) do
  begin
    FListaCotacoes[vInd].Cotacao := 0;
    if FListaCotacoes[vInd].Ativo
    then begin
      vCotacao := vCotacao + (vCotacao * ( FIndice / FDias ) / 100);
      FListaCotacoes[vInd].Cotacao := vCotacao;
    end;
  end;
  Result := Self;
end;

function Tmodelcotacaomoeda.Gerarlistacotacoes(Pinicio, Pfim: Tdatetime; Pconsiderasabado, Pconsideradomingo: Boolean): Imodelcotacaomoeda;
var
  vDataInicio: TDateTime;
begin
  FDias := 0;
  vDataInicio := pInicio;

  SetLength(FListaCotacoes,0);

  while True do
  begin
    while True do
    begin
      vDataInicio := IncDay(vDataInicio);
      case  DayOfTheWeek(vDataInicio) of
        DaySaturday: if pConsideraSabado then Break;
        DaySunday: if pConsideraDomingo then Break;
        else Break;
      end;
    end;
    if CompareDate(vDataInicio, pFim) <= 0
    then begin
      SetLength(FListaCotacoes, FDias + 1);
      FListaCotacoes[FDias].Dia := vDataInicio;
      FListaCotacoes[FDias].Ativo := True;
      FListaCotacoes[FDias].Cotacao := 0;
      inc(FDias);
    end
    else Break;
  end;
  Result := Self;
end;

procedure Tmodelcotacaomoeda.Atualizarlistbox(var Plistbox: Tchecklistbox);
var
  vInd,
  vTam: Integer;
begin
  vTam := Length(FListaCotacoes);
  Plistbox.Clear;
  for vInd := 0 to Pred(vTam) do
  begin
    Plistbox.Items.Add(FListaCotacoes[vInd].RetornaString);
    Plistbox.Checked[vInd] := FListaCotacoes[vInd].Ativo;
  end;
end;

function Tmodelcotacaomoeda.Dataset: Tdataset;
var
  vDataset: TDataSet;
begin
  vDataset :=  FQuery.Dataset;
  FormataCampoTexto(vDataset.FieldByName('MOEDA'), 'Moeda', 6, taCenter);
  FormataCampoData(vDataset.FieldByName('DATA'),'Data',8, taCenter);
  FormataCampoNumerico(vDataset.FieldByName('COTACAO'),'Cotação',10, taRightJustify, ',#0.00000000');
  Result := vDataset;
end;

function Tmodelcotacaomoeda.Listarcombobox: Tstringlist;
var
  vDataset: TDataSet;
begin
  FLista.Clear;
  vDataset := FQuery.Open(FSQL.SqlListarCombobox).Dataset;
  while not vDataset.EOF do
  begin
    FLista.Add(Format('%s|%d|%s',[ vDataset.FieldByName('DESCRIC').AsString, 0,
                                   vDataset.FieldByName('CODIGO').AsString]));
    vDataset.Next;
  end;
  Result := FLista;
end;

function Tmodelcotacaomoeda.Cotacaomoeda(Pmoeda: String; Pdata: Tdatetime): Double;
begin
  Result := FQuery.Open( FSQL.SqlCotacao( Pmoeda, Pdata)).Dataset.FieldByName('COTACAO').AsFloat;
end;

function Tmodelcotacaomoeda.Ultimacotacaomoeda(Pmoeda: String): Imodelcotacaomoeda;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlUltimaCotacao(Pmoeda));
end;

function Tmodelcotacaomoeda.Listarcotacoesmoeda(Pmoeda: String; Pdata: Tdatetime): Imodelcotacaomoeda;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlListar(Pmoeda, Pdata));
end;

function Tmodelcotacaomoeda.Novacotacaomoeda(Pmoeda: String; Pdata: Tdatetime; Pcotacao: Double): Imodelcotacaomoeda;
begin
  Result := Self;
  FQuery.Executar(FSQL.SqlNovaCotacao(Pmoeda, Pdata, Pcotacao));
end;

function Tmodelcotacaomoeda.Moeda: String;
begin
  Result := FQuery.FieldByName('MOEDA').AsString;
end;

function Tmodelcotacaomoeda.Moeda(Avalue: String): Imodelcotacaomoeda;
begin
  Result := Self;
  FMoeda := Avalue;
end;

function Tmodelcotacaomoeda.Indice(Avalue: Double): Imodelcotacaomoeda;
begin
  Result := Self;
  FIndice := Avalue;
end;

function Tmodelcotacaomoeda.Data: Tdatetime;
begin
  Result := FQuery.FieldByName('DATA').AsDateTime;
end;

function Tmodelcotacaomoeda.Cotacao: Double;
begin
  Result := FQuery.FieldByName('COTACAO').AsFloat;
end;

function Tmodelcotacaomoeda.Dias: Integer;
begin
  Result := FDias;
end;


end.


