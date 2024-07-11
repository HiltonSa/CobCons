unit cobcons.model.nivelsupervisao;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, cobcons.model.interfaces;
type

  { TModelNivelSupervisao }

  TModelNivelSupervisao = class(TInterfacedObject, iModelNivelSupervisao)
    private
      FQuery: iQueryRest;
      FLista: TStringList;

      FCodigo: Integer;
      FDescricao: String;
      FVendaPropria: Integer;

      procedure AtualizarCampos;

    public
      constructor Create(aQuery: iQueryRest);
      destructor Destroy; override;
      class function New(aQuery: iQueryRest): iModelNivelSupervisao;

      function ListaPorCodigo(pCodigo: Integer): TDataSet;
      function ListaPorNome(pNome: String): TDataSet;
      function ListaComboBox: TStringList;
      function CODIGO: Integer;
      function DESCRICAO: String;
      function VDPROPRIA: Integer;

  end;

implementation

uses cobcons.controller.util;

{ TModelNivelSupervisao }

procedure TModelNivelSupervisao.AtualizarCampos;
begin
  if not FQuery.Dataset.EOF
  then begin
    FCodigo      := FQuery.FieldByName('CODIGO').AsInteger;
    FDescricao   := FQuery.FieldByName('DESCRICAO').AsString;
    FVendaPropria:= FQuery.FieldByName('VDPROPRIA').AsInteger;
  end;
end;

constructor TModelNivelSupervisao.Create(aQuery: iQueryRest);
begin
  FQuery := aQuery;
  FLista := TStringList.Create;
end;

destructor TModelNivelSupervisao.Destroy;
begin
  FLista.Free;
  inherited Destroy;
end;

class function TModelNivelSupervisao.New(aQuery: iQueryRest): iModelNivelSupervisao;
begin
  Result := Self.Create(aQuery);
end;

function TModelNivelSupervisao.ListaPorCodigo(pCodigo: Integer): TDataSet;
const
  vSql = 'SELECT * FROM supervisao WHERE codigo = %d';
begin
  FQuery.Open(Format(vSql,[ pCodigo]));
  AtualizarCampos;
  Result := FQuery.Dataset;
end;

function TModelNivelSupervisao.ListaPorNome(pNome: String): TDataSet;
const
  SQL = 'SELECT * FROM supervisao WHERE descricao LIKE %s ORDER BY descricao';
var
  vSql: String;
begin
  vSql := Format(SQL,[ QuotedStr(pNome+'%')]);
  Result := FQuery.Open(vSql).Dataset;
end;

function TModelNivelSupervisao.ListaComboBox: TStringList;
const
  SQL_COMBO_BOX = 'SELECT descricao, codigo FROM supervisao ORDER BY descricao';
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

function TModelNivelSupervisao.CODIGO: Integer;
begin
  Result := FCodigo;
end;

function TModelNivelSupervisao.DESCRICAO: String;
begin
  Result := FDescricao;
end;

function TModelNivelSupervisao.VDPROPRIA: Integer;
begin
  Result := FVendaPropria;
end;

end.

