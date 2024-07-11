unit cobcons.model.situacaocontrato;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, cobcons.model.interfaces;
type

  { TModelSituacaoContrato }

  TModelSituacaoContrato = class(TInterfacedObject, iModelSituacaoContrato)
    private
      FQuery: iQueryRest;
      FLista: TStringList;

      FCodigo: Integer;
      FDescricao: String;

      procedure AtualizarCampos;

    public
      constructor Create(aQuery: iQueryRest);
      destructor Destroy; override;
      class function New(aQuery: iQueryRest): iModelSituacaoContrato;

      function ListaPorCodigo(pCodigo: Integer): TDataSet;
      function ListaPorNome(pNome: String): TDataSet;
      function ListaComboBox: TStringList;
      function CODIGO: Integer;
      function DESCRICAO: String;

  end;

implementation

uses cobcons.controller.util;

{ TModelSituacaoContrato }

procedure TModelSituacaoContrato.AtualizarCampos;
begin
  if not FQuery.Dataset.EOF
  then begin
    FCodigo      := FQuery.FieldByName('CODIGO').AsInteger;
    FDescricao   := FQuery.FieldByName('DESCRICAO').AsString;
  end;
end;

constructor TModelSituacaoContrato.Create(aQuery: iQueryRest);
begin
  FQuery := aQuery;
  FLista := TStringList.Create;
end;

destructor TModelSituacaoContrato.Destroy;
begin
  FLista.Free;
  inherited Destroy;
end;

class function TModelSituacaoContrato.New(aQuery: iQueryRest): iModelSituacaoContrato;
begin
  Result := Self.Create(aQuery);
end;

function TModelSituacaoContrato.ListaPorCodigo(pCodigo: Integer): TDataSet;
const
  vSql = 'SELECT * FROM sitcon WHERE codigo = %d';
begin
  FQuery.Open(Format(vSql,[ pCodigo]));
  AtualizarCampos;
  Result := FQuery.Dataset;
end;

function TModelSituacaoContrato.ListaPorNome(pNome: String): TDataSet;
const
  SQL = 'SELECT * FROM sitcon WHERE descricao LIKE %s ORDER BY descricao';
var
  vSql: String;
begin
  vSql := Format(SQL,[ QuotedStr(pNome+'%')]);
  Result := FQuery.Open(vSql).Dataset;
end;

function TModelSituacaoContrato.ListaComboBox: TStringList;
const
  SQL_COMBO_BOX = 'SELECT descricao, codigo FROM sitcon ORDER BY descricao';
var
  pDataset: TDataSet;
begin
  FLista.Clear;
  pDataset := FQuery.Open(SQL_COMBO_BOX).Dataset;
  while not pDataset.EOF do
  begin
    FLista.Add(Format('%s|%d',[ pDataset.FieldByName('descricao').AsString,
                                pDataset.FieldByName('CODIGO').AsInteger]));
    pDataset.Next;
  end;
  Result := FLista;
end;

function TModelSituacaoContrato.CODIGO: Integer;
begin
  Result := FCodigo;
end;

function TModelSituacaoContrato.DESCRICAO: String;
begin
  Result := FDescricao;
end;

end.

