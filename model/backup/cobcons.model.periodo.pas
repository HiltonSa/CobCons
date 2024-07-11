unit cobcons.model.periodo;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, cobcons.model.interfaces;

type

  { TModelPeriodo }

  TModelPeriodo = class(TInterfacedObject, iModelPeriodo)
    private
      FQuery: iQueryRest;
      FLista: TStringList;

      FCodigo: Integer;
      FDescricao: String;
      FDtIni: TDateTime;
      FDtFim: TDateTime;
      FDtCal: TDateTime;

      procedure AtualizarCampos;

    public
      constructor Create(aQuery: iQueryRest);
      destructor Destroy; override;
      class function New(aQuery: iQueryRest): iModelPeriodo;

      function ListaPorCodigo(pCodigo: Integer): TDataSet;
      function ListaPorNome(pNome: String): TDataSet;
      function ListaComboBox: TStringList;
      function ListaComboBoxCalculo: TStringList;
      function CalcularComissoes: iModelPeriodo;
      function Executar(pModo: TpModoManutencao): iModelPeriodo;
      function RetornaPeriodoAtual: iModelPeriodo;
      function CODIGO: Integer; overload;
      function CODIGO(aValue: Integer): iModelPeriodo; overload;
      function DESCRICAO: String;
      function DTINI: TDateTime;
      function DTFIM: TDateTime;
      function DTCAL: TDateTime; overload;
      function DTCAL(pValor: TDateTime): iModelPeriodo; overload;

  end;

implementation

uses cobcons.controller.util, cobcons.model.storedprocedure;

{ TModelPeriodo }

procedure TModelPeriodo.AtualizarCampos;
begin
  if not FQuery.Dataset.EOF
  then begin
    FCodigo    := FQuery.FieldByName('codigo').AsInteger;
    FDescricao := FQuery.FieldByName('descricao').AsString;
    FDtIni     := FQuery.FieldByName('dtini').AsDateTime;
    FDtFim     := FQuery.FieldByName('dtfim').AsDateTime;
    FDtCal     := FQuery.FieldByName('dtcal').AsDateTime;
  end;
end;

constructor TModelPeriodo.Create(aQuery: iQueryRest);
begin
  FQuery := aQuery;
  FLista := TStringList.Create;
end;

destructor TModelPeriodo.Destroy;
begin
  FLista.Free;
  inherited Destroy;
end;

class function TModelPeriodo.New(aQuery: iQueryRest): iModelPeriodo;
begin
  Result := Self.Create(aQuery);
end;

function TModelPeriodo.ListaPorCodigo(pCodigo: Integer): TDataSet;
const
  vSql = 'SELECT * FROM periodo WHERE codigo = %d';
begin
  FQuery.Open(Format(vSql,[ pCodigo]));
  AtualizarCampos;
  Result := FQuery.Dataset;
end;

function TModelPeriodo.ListaPorNome(pNome: String): TDataSet;
const
  vSql = 'SELECT * FROM periodo WHERE descricao LIKE %s ORDER BY DTINI desc';
begin
  FQuery.Open(Format(vSql,[ QuotedStr(pNome+'%') ]));
  Result := FQuery.Dataset;
end;

function TModelPeriodo.ListaComboBox: TStringList;
const
  SQL_COMBO_BOX = 'SELECT descricao, codigo FROM periodo ORDER BY DTINI desc';
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

function TModelPeriodo.ListaComboBoxCalculo: TStringList;
const
  SQL_COMBO_BOX =
       'SELECT descricao, codigo FROM periodo '+
        'WHERE (CURRENT_DATE - DTCAL) BETWEEN 0 AND 35 '+
        'ORDER BY descricao';
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

function TModelPeriodo.CalcularComissoes: iModelPeriodo;
//const
//  SQL = 'CALL calcular_comissao( %d )';
var
  //vSql: String;
  vSp: iModelStoredProcedure;
begin
  vSp := TModelStoredProcedure.New;
  vSp.NOME('CALCULAR_COMISSAO');
  vSp.PARAMETRO('CDPER')
     .VALOR(FCodigo)
     .AtribuirValor;
  vSp.Executar;
  //vSql := Format(SQL,[ FCodigo ]);
  //FQuery.Executar(vSql);
  Result := Self;
end;

function TModelPeriodo.Executar(pModo: TpModoManutencao): iModelPeriodo;
//const
//  SQL = 'CALL manter_periodo( %d, %d, %s, %s, %s, %s )';
var
  //vSql: String;
  vSp: iModelStoredProcedure;
begin
  vSp := TModelStoredProcedure.New;
  vSp.NOME('MANTER_PERIODO');
  vSp.PARAMETRO('pMODO'     ).VALOR(Ord(pModo)).AtribuirValor;
  vSp.PARAMETRO('pCODIGO'   ).VALOR(FCodigo   ).AtribuirValor;
  vSp.PARAMETRO('pDESCRICAO').VALOR(FDescricao).AtribuirValor;
  vSp.PARAMETRO('PINICIO'   ).VALOR(FDtIni    ).AtribuirValor;
  vSp.PARAMETRO('PFIM'      ).VALOR(FDtFim    ).AtribuirValor;
  vSp.PARAMETRO('PCALCULO'  ).VALOR(FDtCal    ).AtribuirValor;
  vSp.Executar;
  //FormatSettings.DecimalSeparator := '.';
  //vSql := Format(SQL,[ Ord(pModo),
  //                     FCodigo,
  //                     QuotedStr(FDescricao),
  //                     QuotedStr(RetornaDataSql(FDtIni)),
  //                     QuotedStr(RetornaDataSql(FDtFim)),
  //                     QuotedStr(RetornaDataSql(FDtCal)) ]);
  //FormatSettings.DecimalSeparator := ',';
  //FQuery.Executar(vSql);
  Result := Self;
end;

function TModelPeriodo.RetornaPeriodoAtual: iModelPeriodo;
const
  vSqlAtual = 'select * from PERIODO '+
              'where DTINI <= %s and DTFIM >= %s';
var
  vHoje: String;
  vSp: iModelStoredProcedure;
begin
  vSp := TModelStoredProcedure.New;
  vSp.NOME('PERIODO_ATUAL');
  vSp.Executar;
  vHoje := QuotedStr(RetornaDataSql(Date));
  FQuery.Open(Format(vSqlAtual,[vHoje, vHoje]));
  AtualizarCampos;
  Result := Self;
end;

function TModelPeriodo.CODIGO: Integer;
begin
  Result := FCodigo;
end;

function TModelPeriodo.CODIGO(aValue: Integer): iModelPeriodo;
begin
  Result := Self;
  FCodigo := aValue;
end;

function TModelPeriodo.DESCRICAO: String;
begin
  Result := FDescricao;
end;

function TModelPeriodo.DTINI: TDateTime;
begin
  Result := FDtIni;
end;

function TModelPeriodo.DTFIM: TDateTime;
begin
  Result := FDtFim;
end;

function TModelPeriodo.DTCAL: TDateTime;
begin
  Result := FDtCal;
end;

function TModelPeriodo.DTCAL(pValor: TDateTime): iModelPeriodo;
begin
  Result := Self;
  FDtCal := pValor;
end;

end.

