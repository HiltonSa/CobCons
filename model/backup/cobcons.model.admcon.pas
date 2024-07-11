unit cobcons.model.admcon;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, cobcons.model.interfaces;
type

  { TModelAdmcon }

  TModelAdmcon = class(TInterfacedObject, iModelAdmcon)
    private
      FQuery: iQueryRest;
      FLista: TStringList;

      FCodigo: Integer;
      FNomeFantasia: String;
      FRazaoSocial: String;
      FCnpj: String;
      FVigencia: TDateTime;
      FUnidade: Integer;
      FPcEntrega: Double;
      FMesPer: Integer;
      FPcPer: Double;
      FAcerto: Integer;
      FUltFaixa: Integer;

      procedure AtualizarCampos;

    public
      constructor Create(aQuery: iQueryRest);
      destructor Destroy; override;
      class function New(aQuery: iQueryRest): iModelAdmcon;

      function ListaPorCodigo(pCodigo: Integer): TDataSet;
      function ListaPorNome(pNome: String): TDataSet;
      function ListaComboBox: TStringList;
      function Executar(pModo: TpModoManutencao): iModelAdmcon;
      function CODIGO: Integer; overload;
      function CODIGO(pValor: Integer): iModelAdmcon; overload;
      function NOMEFANTASIA: String; overload;
      function NOMEFANTASIA(pValor: String): iModelAdmcon; overload;
      function RAZAOSOCIAL: String; overload;
      function RAZAOSOCIAL(pValor: String): iModelAdmcon; overload;
      function CNPJ: String; overload;
      function CNPJ(pValor: String): iModelAdmcon; overload;
      function VIGENCIA: TDateTime; overload;
      function VIGENCIA(pValor: TDateTime): iModelAdmcon; overload;
      function UNIDADE: Integer; overload;
      function UNIDADE(pValor: Integer): iModelAdmcon; overload;
      function PCENTREGA: Double; overload;
      function PCENTREGA(pValor: Double): iModelAdmcon; overload;
      function MESPER: Integer; overload;
      function MESPER(pValor: Integer): iModelAdmcon; overload;
      function PCPER: Double; overload;
      function PCPER(pValor: Double): iModelAdmcon; overload;
      function ACERTO: Integer; overload;
      function ACERTO(pValor: Integer): iModelAdmcon; overload;
      function ULTFAIXA: Integer; overload;
      function ULTFAIXA(pValor: Integer): iModelAdmcon; overload;

  end;

implementation

uses cobcons.controller.util;

{ TModelAdmcon }

procedure TModelAdmcon.AtualizarCampos;
begin
  if not FQuery.Dataset.EOF
  then begin
    FCodigo      := FQuery.FieldByName('CODIGO').AsInteger;
    FNomeFantasia:= FQuery.FieldByName('NOMEFANTASIA').AsString;
    FRazaoSocial := FQuery.FieldByName('RAZAOSOCIAL').AsString;
    FCnpj        := FQuery.FieldByName('CNPJ').AsString;
    FVigencia    := FQuery.FieldByName('VIGENCIA').AsDateTime;
    FUnidade     := FQuery.FieldByName('UNIDADE').AsInteger;
    FPcEntrega   := FQuery.FieldByName('PCENTREGA').AsFloat;
    FMesPer      := FQuery.FieldByName('MESPER').AsInteger;
    FPcPer       := FQuery.FieldByName('PCPER').AsFloat;
    FAcerto      := FQuery.FieldByName('ACERTO').AsInteger;
    FUltFaixa    := FQuery.FieldByName('ULTFAIXA').AsInteger;
  end;
end;

constructor TModelAdmcon.Create(aQuery: iQueryRest);
begin
  FQuery := aQuery;
  FLista := TStringList.Create;
end;

destructor TModelAdmcon.Destroy;
begin
  FLista.Free;
  inherited Destroy;
end;

class function TModelAdmcon.New(aQuery: iQueryRest): iModelAdmcon;
begin
  Result := Self.Create(aQuery);
end;

function TModelAdmcon.ListaPorCodigo(pCodigo: Integer): TDataSet;
const
  vSql = 'SELECT * FROM empresa WHERE codigo = %d';
begin
  FQuery.Open(Format(vSql,[ pCodigo]));
  AtualizarCampos;
  Result := FQuery.Dataset;
end;

function TModelAdmcon.ListaPorNome(pNome: String): TDataSet;
const
  SQL = 'SELECT * FROM empresa WHERE nomefantasia LIKE %s ORDER BY nomefantasia';
var
  vSql: String;
begin
  vSql := Format(SQL,[ QuotedStr(pNome+'%')]);
  Result := FQuery.Open(vSql).Dataset;
end;

function TModelAdmcon.ListaComboBox: TStringList;
const
  SQL_COMBO_BOX = 'SELECT nomefantasia, codigo FROM empresa ORDER BY nomefantasia';
var
  pDataset: TDataSet;
begin
  FLista.Clear;
  pDataset := FQuery.Open(SQL_COMBO_BOX).Dataset;
  while not pDataset.EOF do
  begin
    FLista.Add(Format('%s|%d',[ pDataset.FieldByName('NOMEFANTASIA').AsString,
                                pDataset.FieldByName('CODIGO').AsInteger]));
    pDataset.Next;
  end;
  Result := FLista;
end;

function TModelAdmcon.Executar(pModo: TpModoManutencao): iModelAdmcon;
const
  SQL = 'CALL manter_empresa( %d, %s, %s, %s, %s, %d, %d, %f, %d, %f, %d, %d )';
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  vSql := Format(SQL,[ Ord(pModo),
                       QuotedStr(FNomeFantasia),
                       QuotedStr(FRazaoSocial),
                       QuotedStr(FCnpj),
                       QuotedStr(RetornaDataSql(FVigencia)),
                       FUnidade,
                       FCodigo,
                       FPcEntrega,
                       FMesPer,
                       FPcPer,
                       FAcerto,
                       FUltFaixa ]);
  FormatSettings.DecimalSeparator := ',';
  FQuery.Executar(vSql);
  Result := Self;
end;

function TModelAdmcon.CODIGO: Integer;
begin
  Result := FCodigo;
end;

function TModelAdmcon.CODIGO(pValor: Integer): iModelAdmcon;
begin
  Result := Self;
  FCodigo := pValor;
end;

function TModelAdmcon.NOMEFANTASIA: String;
begin
  Result := FNomeFantasia;
end;

function TModelAdmcon.NOMEFANTASIA(pValor: String): iModelAdmcon;
begin
  Result := Self;
  FNomeFantasia := pValor;
end;

function TModelAdmcon.RAZAOSOCIAL: String;
begin
  Result := FRazaoSocial;
end;

function TModelAdmcon.RAZAOSOCIAL(pValor: String): iModelAdmcon;
begin
  Result := Self;
  FRazaoSocial := pValor;
end;

function TModelAdmcon.CNPJ: String;
begin
  Result := FCnpj;
end;

function TModelAdmcon.CNPJ(pValor: String): iModelAdmcon;
begin
  Result := Self;
  FCnpj := pValor;
end;

function TModelAdmcon.VIGENCIA: TDateTime;
begin
  Result := FVigencia;
end;

function TModelAdmcon.VIGENCIA(pValor: TDateTime): iModelAdmcon;
begin
  Result := Self;
  FVigencia := pValor;
end;

function TModelAdmcon.UNIDADE: Integer;
begin
  Result := FUnidade;
end;

function TModelAdmcon.UNIDADE(pValor: Integer): iModelAdmcon;
begin
  Result := Self;
  FUnidade := pValor;
end;

function TModelAdmcon.PCENTREGA: Double;
begin
  Result := FPcEntrega;
end;

function TModelAdmcon.PCENTREGA(pValor: Double): iModelAdmcon;
begin
  Result := Self;
  FPcEntrega := pValor;
end;

function TModelAdmcon.MESPER: Integer;
begin
  Result := FMesPer;
end;

function TModelAdmcon.MESPER(pValor: Integer): iModelAdmcon;
begin
  Result := Self;
  FMesPer := pValor;
end;

function TModelAdmcon.PCPER: Double;
begin
  Result := FPcPer;
end;

function TModelAdmcon.PCPER(pValor: Double): iModelAdmcon;
begin
  Result := Self;
  FPcPer := pValor;
end;

function TModelAdmcon.ACERTO: Integer;
begin
  Result := FAcerto;
end;

function TModelAdmcon.ACERTO(pValor: Integer): iModelAdmcon;
begin
  Result := Self;
  FAcerto := pValor;
end;

function TModelAdmcon.ULTFAIXA: Integer;
begin
  Result := FUltFaixa;
end;

function TModelAdmcon.ULTFAIXA(pValor: Integer): iModelAdmcon;
begin
  Result := Self;
  FUltFaixa := pValor;
end;

end.

