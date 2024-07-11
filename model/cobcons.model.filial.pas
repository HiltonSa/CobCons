unit cobcons.model.filial;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, cobcons.model.interfaces;

type

  { TModelFilial }

  TModelFilial = class(TInterfacedObject, iModelFilial)
    private
      FQuery: iQueryRest;
      FLista: TStringList;

      FCodigo: Integer;
      FDescricao: String;
      FResponsavel: Integer;
      FCodExterno: String;

      procedure AtualizarCampos;

    public
      constructor Create(aQuery: iQueryRest);
      destructor Destroy; override;
      class function New(aQuery: iQueryRest): iModelFilial;

      function ListaPorCodigo(pCodigo: Integer): TDataSet;
      function ListaPorNome(pNome: String): TDataSet;
      function ListaComboBox: TStringList;
      function Executar(pModo: TpModoManutencao): iModelFilial;
      function CODIGO: Integer; overload;
      function CODIGO(pValor: Integer): iModelFilial; overload;
      function DESCRICAO: String; overload;
      function DESCRICAO(pValor: String): iModelFilial; overload;
      function RESPONSAVEL: Integer; overload;
      function RESPONSAVEL(pValor: Integer): iModelFilial; overload;
      function CODEXT: String; overload;
      function CODEXT(pValor: String): iModelFilial; overload;

  end;

implementation

uses cobcons.controller.util, cobcons.model.storedprocedure;

{ TModelFilial }

procedure TModelFilial.AtualizarCampos;
begin
  if not FQuery.Dataset.EOF
  then begin
    FCodigo     := FQuery.FieldByName('codigo').AsInteger;
    FDescricao  := FQuery.FieldByName('descricao').AsString;
    FResponsavel:= FQuery.FieldByName('responsavel').AsInteger;
    FCodExterno := FQuery.FieldByName('codexterno').AsString;
  end;
end;

constructor TModelFilial.Create(aQuery: iQueryRest);
begin
  FQuery := aQuery;
  FLista := TStringList.Create;
end;

destructor TModelFilial.Destroy;
begin
  FLista.Free;
  inherited Destroy;
end;

class function TModelFilial.New(aQuery: iQueryRest): iModelFilial;
begin
  Result := Self.Create(aQuery);
end;

function TModelFilial.ListaPorCodigo(pCodigo: Integer): TDataSet;
const
  vSql = 'SELECT * FROM filiais WHERE codigo = %d';
begin
  FQuery.Open(Format(vSql,[ pCodigo]));
  AtualizarCampos;
  Result := FQuery.Dataset;
end;

function TModelFilial.ListaPorNome(pNome: String): TDataSet;
const
  vSql = 'SELECT * FROM filiais WHERE descricao LIKE %s ORDER BY descricao';
begin
  FQuery.Open(Format(vSql,[ QuotedStr(pNome+'%') ]));
  Result := FQuery.Dataset;
end;

function TModelFilial.ListaComboBox: TStringList;
const
  SQL_COMBO_BOX = 'SELECT descricao, codigo FROM filiais ORDER BY descricao';
var
  pDataset: TDataSet;
begin
  FLista.Clear;
  pDataset := FQuery.Open(SQL_COMBO_BOX).Dataset;
  while not pDataset.EOF do
  begin
    FLista.Add(Format('%s|%d',[ pDataset.FieldByName('descricao').AsString,
                                pDataset.FieldByName('codigo').AsInteger]));
    pDataset.Next;
  end;
  Result := FLista;
end;

function TModelFilial.Executar(pModo: TpModoManutencao): iModelFilial;
//const
//  SQL = 'CALL manter_filiais( %d, %s, %d, %s, %d )';
var
  //vSql: String;
  vSp: iModelStoredProcedure;
begin
  vSp := TModelStoredProcedure.New;
  vSp.NOME('MANTER_FILIAIS');
  vSp.PARAMETRO('pMODO'     ).VALOR(Ord(pModo)  ).AtribuirValor;
  vSp.PARAMETRO('pDESCRICAO').VALOR(FDescricao  ).AtribuirValor;
  vSp.PARAMETRO('PRESP'     ).VALOR(FResponsavel).AtribuirValor;
  vSp.PARAMETRO('PEXT'      ).VALOR(FCodExterno ).AtribuirValor;
  vSp.PARAMETRO('PCOD'      ).VALOR(FCodigo     ).AtribuirValor;
  vSp.Executar;
  //FormatSettings.DecimalSeparator := '.';
  //vSql := Format(SQL,[ Ord(pModo),
  //                     QuotedStr(FDescricao),
  //                     FResponsavel,
  //                     QuotedStr(FCodExterno),
  //                     FCodigo ]);
  //FormatSettings.DecimalSeparator := ',';
  //FQuery.Executar(vSql);
  Result := Self;
end;

function TModelFilial.CODIGO: Integer;
begin
  Result := FCodigo;
end;

function TModelFilial.CODIGO(pValor: Integer): iModelFilial;
begin
  Result := Self;
  FCodigo := pValor;
end;

function TModelFilial.DESCRICAO: String;
begin
  Result := FDescricao;
end;

function TModelFilial.DESCRICAO(pValor: String): iModelFilial;
begin
  Result := Self;
  FDescricao := pValor;
end;

function TModelFilial.RESPONSAVEL: Integer;
begin
  Result := FResponsavel;
end;

function TModelFilial.RESPONSAVEL(pValor: Integer): iModelFilial;
begin
  Result := Self;
  FResponsavel := pValor;
end;

function TModelFilial.CODEXT: String;
begin
  Result := FCodExterno;
end;

function TModelFilial.CODEXT(pValor: String): iModelFilial;
begin
  Result := Self;
  FCodExterno := pValor;
end;

end.

