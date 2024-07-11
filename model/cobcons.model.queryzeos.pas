unit cobcons.model.queryzeos;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.interfaces, cobcons.model.conexaozeos, ZConnection,
  ZDataset, db;

type

  { TQueryZeos }

  TQueryZeos = class(TInterfacedObject, iQueryRest)
    private
      Fconexao: iModelConexao;
      FQuery : TZQuery;
    public
      constructor Create(aConexao: iModelConexao);
      destructor Destroy; override;
      class function New(aConexao: iModelConexao): iQueryRest;
      function Open(aSql: String): iQueryRest;
      function Vazio: Boolean;
      function PrimeiroRegistro: Boolean;
      function ProximoRegistro: Boolean;
      function NumeroRegistros: Integer;
      function Executar(aSql: String): iQueryRest;
      function Datasource(var aDatasource: TDatasource): iQueryRest;
      function FieldByName( const FieldName: string) : TField;
      function AtualizarBD: iQueryRest;
      function Dataset: TDataSet;
      function AtualizarBlob(aTabela, aCampo, aArquivoConteudo: string; aCodigo: Integer): iQueryRest; overload;
      function AtualizarBlob(aTabela, aCampo: string; aConteudo: TMemoryStream; aCodigo: Integer): iQueryRest; overload;
      function AtualizarBlob(aTabela, aCampo, aCampoCodigo: string; aConteudo: TMemoryStream; aCodigo: Integer): iQueryRest; overload;
      function ProximoCodigo(aTabela: string): Integer;
  end;

implementation

uses cobcons.controller.util;

{ TQueryZeos }

constructor TQueryZeos.Create(aConexao: iModelConexao);
begin
  Fconexao := aConexao;
  FQuery := TZQuery.Create(nil);
  FQuery.Connection := TZConnection(Fconexao.Conectar);
  //FQuery.FetchRow := 13;
end;

destructor TQueryZeos.Destroy;
begin
  FreeAndNil(FQuery);
  inherited Destroy;
end;

class function TQueryZeos.New(aConexao: iModelConexao): iQueryRest;
begin
  Result := Self.Create(aConexao);
end;

function TQueryZeos.Open(aSql: String): iQueryRest;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(Asql);
  FQuery.Open;
  Result := Self;
end;

function TQueryZeos.Vazio: Boolean;
begin
  Result := FQuery.EOF;
end;

function TQueryZeos.PrimeiroRegistro: Boolean;
begin
  FQuery.First;
  Result := Vazio;
end;

function TQueryZeos.ProximoRegistro: Boolean;
begin
  FQuery.Next;
  Result := Vazio;
end;

function TQueryZeos.NumeroRegistros: Integer;
begin
  Result := FQuery.RecordCount;
end;

function TQueryZeos.Executar(aSql: String): iQueryRest;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(Asql);
  FQuery.ExecSQL();
  FQuery.ApplyUpdates();
  Result := Self;
end;


function TQueryZeos.Datasource(var aDatasource: TDatasource): iQueryRest;
begin
  Result := Self;
  Adatasource.DataSet := FQuery;
end;

function TQueryZeos.FieldByName(const FieldName: string): TField;
begin
  Result := FQuery.FieldByName( Fieldname);
end;

function TQueryZeos.AtualizarBD: iQueryRest;
begin
  Result := Self;
  FQuery.ApplyUpdates;
end;

function TQueryZeos.Dataset: TDataSet;
begin
  Result := FQuery;
end;

function TQueryZeos.AtualizarBlob(aTabela, aCampo, aArquivoConteudo: string;
  aCodigo: Integer): iQueryRest;
const
   SQL_ATUALIZA_BLOB = 'update %s set %s = :CONTEUDO where CODIGO = %d';
var
  vArq: TMemoryStream;
begin
  vArq := TMemoryStream.Create;
  try
    vArq.LoadFromFile(Aarquivoconteudo);
    AtualizarBlob(Atabela, Acampo, vArq, Acodigo);
  finally
    FreeAndNil(vArq);
  end;
  Result := Self;
end;

function TQueryZeos.AtualizarBlob(aTabela, aCampo: string;
  aConteudo: TMemoryStream; aCodigo: Integer): iQueryRest;
const
   SQL_ATUALIZA_BLOB = 'update %s set %s = :CONTEUDO where CODIGO = %d';
begin
  if Aconteudo.Size > 0
  then begin
    Aconteudo.Position := 0;
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add(Format(SQL_ATUALIZA_BLOB, [ Atabela, Acampo, Acodigo]));
    FQuery.ParamByName('CONTEUDO').LoadFromStream(Aconteudo, ftBlob);
    FQuery.ExecSQL;
    FQuery.ApplyUpdates();
  end;
  Result := Self;
end;

function TQueryZeos.AtualizarBlob(aTabela, aCampo, aCampoCodigo: string;
  aConteudo: TMemoryStream; aCodigo: Integer): iQueryRest;
const
   SQL_ATUALIZA_BLOB = 'update %s set %s = :CONTEUDO where %s = %d';
begin
  if Aconteudo.Size > 0
  then begin
    Aconteudo.Position := 0;
    FQuery.Close;
    FQuery.SQL.Clear;
    FQuery.SQL.Add(Format(SQL_ATUALIZA_BLOB, [ Atabela, Acampo, Acampocodigo, Acodigo]));
    FQuery.ParamByName('CONTEUDO').LoadFromStream(Aconteudo, ftBlob);
    FQuery.ExecSQL;
    FQuery.ApplyUpdates();
  end;
  Result := Self;
end;

function TQueryZeos.ProximoCodigo(aTabela: string): Integer;
begin
  Result := 1;
  Result := Self.Open('select max(CODIGO) MCOD from '+Atabela).Dataset.FieldByName('MCOD').AsInteger + 1;
end;

end.


