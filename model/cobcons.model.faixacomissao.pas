unit cobcons.model.faixacomissao;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, cobcons.model.interfaces;
type

  { TModelFaixaComissao }

  TModelFaixaComissao = class(TInterfacedObject, iModelFaixaComissao)
    private
      FQuery: iQueryRest;
      FLista: TStringList;

      FCodigo: Integer;
      FEmpresa: Integer;
      FDescricao: String;
      FMinimo: Double;
      FMaximo: Double;

      procedure AtualizarCampos;

    public
      constructor Create(aQuery: iQueryRest);
      destructor Destroy; override;
      class function New(aQuery: iQueryRest): iModelFaixaComissao;

      function ListaPorCodigo(pCodigo: Integer): TDataSet;
      function ListaPorEmpresa(pEmpresa: Integer): TDataSet;
      function ListaComboBox(pEmpresa:Integer): TStringList;
      function Executar(pModo: TpModoManutencao): iModelFaixaComissao;
      function CODIGO: Integer; overload;
      function CODIGO(pValor: Integer): iModelFaixaComissao; overload;
      function EMPRESA: Integer; overload;
      function EMPRESA(pValor: Integer): iModelFaixaComissao; overload;
      function DESCRICAO: String; overload;
      function DESCRICAO(pValor: String): iModelFaixaComissao; overload;
      function MINIMO: Double; overload;
      function MINIMO(pValor: Double): iModelFaixaComissao; overload;
      function MAXIMO: Double; overload;
      function MAXIMO(pValor: Double): iModelFaixaComissao; overload;

  end;

implementation

uses cobcons.controller.util, cobcons.model.storedprocedure;

{ TModelFaixaComissao }

procedure TModelFaixaComissao.AtualizarCampos;
begin
  if not FQuery.Dataset.EOF
  then begin
    FCodigo   := FQuery.FieldByName('CODIGO').AsInteger;
    FEmpresa  := FQuery.FieldByName('EMPRESA').AsInteger;
    FDescricao:= FQuery.FieldByName('DESCRICAO').AsString;
    FMinimo   := FQuery.FieldByName('MINIMO').AsFloat;
    FMaximo   := FQuery.FieldByName('MAXIMO').AsFloat;
  end;
end;

constructor TModelFaixaComissao.Create(aQuery: iQueryRest);
begin
  FQuery := aQuery;
  FLista := TStringList.Create;
end;

destructor TModelFaixaComissao.Destroy;
begin
  FLista.Free;
  inherited Destroy;
end;

class function TModelFaixaComissao.New(aQuery: iQueryRest): iModelFaixaComissao;
begin
  Result := Self.Create(aQuery);
end;

function TModelFaixaComissao.ListaPorCodigo(pCodigo: Integer): TDataSet;
const
  vSql = 'SELECT * FROM faixas WHERE codigo = %d';
begin
  FQuery.Open(Format(vSql,[ pCodigo]));
  AtualizarCampos;
  Result := FQuery.Dataset;
end;

function TModelFaixaComissao.ListaPorEmpresa(pEmpresa: Integer): TDataSet;
const
  vSql = 'SELECT * FROM faixas WHERE empresa = %d';
begin
  FQuery.Open(Format(vSql,[ pEmpresa]));
  AtualizarCampos;
  Result := FQuery.Dataset;
end;

function TModelFaixaComissao.ListaComboBox(pEmpresa:Integer): TStringList;
const
  SQL_COMBO_BOX =
    'SELECT descricao, codigo FROM faixas WHERE empresa = %d ORDER BY descricao';
var
  pDataset: TDataSet;
begin
  FLista.Clear;
  pDataset := FQuery.Open(Format(SQL_COMBO_BOX,[pEmpresa])).Dataset;
  while not pDataset.EOF do
  begin
    FLista.Add(Format('%s|%d',[ pDataset.FieldByName('DESCRICAO').AsString,
                                pDataset.FieldByName('CODIGO').AsInteger]));
    pDataset.Next;
  end;
  Result := FLista;
end;

function TModelFaixaComissao.Executar(pModo: TpModoManutencao): iModelFaixaComissao;
//const
//  SQL = 'CALL manter_faixas( %d, %d, %d, %s, %f, %f )';
var
  //vSql: String;
  vSp: iModelStoredProcedure;
begin
  vSp := TModelStoredProcedure.New;
  vSp.NOME('MANTER_FAIXAS');
  vSp.PARAMETRO('pMODO'     ).VALOR(Ord(pModo)).AtribuirValor;
  vSp.PARAMETRO('pEMPRESA'  ).VALOR(FEmpresa  ).AtribuirValor;
  vSp.PARAMETRO('pCODIGO'   ).VALOR(FCodigo   ).AtribuirValor;
  vSp.PARAMETRO('pDESCRICAO').VALOR(FDescricao).AtribuirValor;
  vSp.PARAMETRO('pMINIMO'   ).VALOR(FMinimo   ).AtribuirValor;
  vSp.PARAMETRO('pMAXIMO'   ).VALOR(FMaximo   ).AtribuirValor;
  vSp.Executar;
  //FormatSettings.DecimalSeparator := '.';
  //vSql := Format(SQL,[ Ord(pModo),
  //                     FEmpresa,
  //                     FCodigo,
  //                     QuotedStr(FDescricao),
  //                     FMinimo,
  //                     FMaximo ]);
  //FormatSettings.DecimalSeparator := ',';
  //FQuery.Executar(vSql);
  Result := Self;
end;

function TModelFaixaComissao.CODIGO: Integer;
begin
  Result := FCodigo;
end;

function TModelFaixaComissao.CODIGO(pValor: Integer): iModelFaixaComissao;
begin
  Result := Self;
  FCodigo := pValor;
end;

function TModelFaixaComissao.EMPRESA: Integer;
begin
  Result := FEmpresa;
end;

function TModelFaixaComissao.EMPRESA(pValor: Integer): iModelFaixaComissao;
begin
  Result := Self;
  FEmpresa := pValor;
end;

function TModelFaixaComissao.DESCRICAO: String;
begin
  Result := FDescricao;
end;

function TModelFaixaComissao.DESCRICAO(pValor: String): iModelFaixaComissao;
begin
  Result := Self;
  FDescricao := pValor;
end;

function TModelFaixaComissao.MINIMO: Double;
begin
  Result := FMinimo;
end;

function TModelFaixaComissao.MINIMO(pValor: Double): iModelFaixaComissao;
begin
  Result := Self;
  FMinimo := pValor;
end;

function TModelFaixaComissao.MAXIMO: Double;
begin
  Result := FMaximo;
end;

function TModelFaixaComissao.MAXIMO(pValor: Double): iModelFaixaComissao;
begin
  Result := Self;
  FMaximo := pValor;
end;


end.

