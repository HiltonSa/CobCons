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

constructor Tqueryzeos.Create(Aconexao: Imodelconexao);
begin
  Fconexao := aConexao;
  FQuery := TZQuery.Create(nil);
  FQuery.Connection := TZConnection(Fconexao.Conectar);
  //FQuery.FetchRow := 13;
end;

destructor Tqueryzeos.Destroy;
begin
  FreeAndNil(FQuery);
  inherited Destroy;
end;

class function Tqueryzeos.New(Aconexao: Imodelconexao): Iqueryrest;
begin
  Result := Self.Create(aConexao);
end;

function Tqueryzeos.Open(Asql: String): Iqueryrest;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(Asql);
  FQuery.Open;
  Result := Self;
end;

function Tqueryzeos.Vazio: Boolean;
begin
  Result := FQuery.EOF;
end;

function Tqueryzeos.Executar(Asql: String): Iqueryrest;
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(Asql);
  FQuery.ExecSQL();
  FQuery.ApplyUpdates();
  Result := Self;
end;


function Tqueryzeos.Datasource(var Adatasource: Tdatasource): Iqueryrest;
begin
  Result := Self;
  Adatasource.DataSet := FQuery;
end;

function Tqueryzeos.Fieldbyname(const Fieldname: String): Tfield;
begin
  Result := FQuery.FieldByName( Fieldname);
end;

function Tqueryzeos.Atualizarbd: Iqueryrest;
begin
  Result := Self;
  FQuery.ApplyUpdates;
end;

function Tqueryzeos.Dataset: Tdataset;
begin
  Result := FQuery;
end;

function Tqueryzeos.Atualizarblob(Atabela, Acampo, Aarquivoconteudo: String; Acodigo: Integer): Iqueryrest;
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

function Tqueryzeos.Atualizarblob(Atabela, Acampo: String; Aconteudo: Tmemorystream; Acodigo: Integer): Iqueryrest;
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

function Tqueryzeos.Atualizarblob(Atabela, Acampo, Acampocodigo: String; Aconteudo: Tmemorystream; Acodigo: Integer): Iqueryrest;
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

function Tqueryzeos.Proximocodigo(Atabela: String): Integer;
begin
  Result := 1;
  Result := Self.Open('select max(CODIGO) MCOD from '+Atabela).Dataset.FieldByName('MCOD').AsInteger + 1;
end;

end.


