unit cobcons.model.regracomissao;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, cobcons.model.interfaces;
type

  { TModelRegraComissao }

  TModelRegraComissao = class(TInterfacedObject, iModelRegraComissao)
    private
      FQuery: iQueryRest;

      FParcela: Integer;
      FEmpresa: Integer;
      FFaixa: Integer;
      FPcLib: Integer;
      FPercentual: Double;

      procedure AtualizarCampos;

    public
      constructor Create(aQuery: iQueryRest);
      destructor Destroy; override;
      class function New(aQuery: iQueryRest): iModelRegraComissao;

      function ListaParcelasFaixa(pEmpresa, pFaixa: Integer): TDataSet;
      function ListaParcela(pEmpresa, pFaixa, pParcela: Integer): TDataSet;
      function Executar(pModo: TpModoManutencao): iModelRegraComissao;
      function EMPRESA: Integer; overload;
      function EMPRESA(pValor: Integer): iModelRegraComissao; overload;
      function PARCELA: Integer; overload;
      function PARCELA(pValor: Integer): iModelRegraComissao; overload;
      function FAIXA: Integer; overload;
      function FAIXA(pValor: Integer): iModelRegraComissao; overload;
      function PCLIB: Integer; overload;
      function PCLIB(pValor: Integer): iModelRegraComissao; overload;
      function PERCENTUAL: Double; overload;
      function PERCENTUAL(pValor: Double): iModelRegraComissao; overload;

  end;

implementation

uses cobcons.controller.util, cobcons.model.storedprocedure;

{ TModelRegraComissao }

procedure TModelRegraComissao.AtualizarCampos;
begin
  if not FQuery.Dataset.EOF
  then begin
    FParcela    := FQuery.FieldByName('PARCELA').AsInteger;
    FEmpresa    := FQuery.FieldByName('EMPRESA').AsInteger;
    FFaixa      := FQuery.FieldByName('FAIXA').AsInteger;
    FPcLib      := FQuery.FieldByName('PCLIB').AsInteger;
    FPercentual := FQuery.FieldByName('PERCENTUAL').AsFloat;
  end;
end;

constructor TModelRegraComissao.Create(aQuery: iQueryRest);
begin
  FQuery := aQuery;
end;

destructor TModelRegraComissao.Destroy;
begin
  inherited Destroy;
end;

class function TModelRegraComissao.New(aQuery: iQueryRest): iModelRegraComissao;
begin
  Result := Self.Create(aQuery);
end;

function TModelRegraComissao.ListaParcelasFaixa(pEmpresa, pFaixa: Integer
  ): TDataSet;
const
  SQL = 'SELECT * FROM regras WHERE empresa = %d and faixa = %d ORDER BY parcela';
var
  vSql: String;
begin
  vSql := Format(SQL,[ pEmpresa, pFaixa]);
  Result := FQuery.Open(vSql).Dataset;
end;

function TModelRegraComissao.ListaParcela(pEmpresa, pFaixa, pParcela: Integer
  ): TDataSet;
const
  vSql = 'SELECT * FROM regras WHERE empresa = %d and faixa = %d and parcela = %d';
begin
  FQuery.Open(Format(vSql,[ pEmpresa, pFaixa, pParcela]));
  AtualizarCampos;
  Result := FQuery.Dataset;
end;

function TModelRegraComissao.Executar(pModo: TpModoManutencao): iModelRegraComissao;
//const
//  SQL = 'CALL manter_regras( %d, %d, %d, %d, %d, %f )';
var
  //vSql: String;
  vSp: iModelStoredProcedure;
begin
  vSp := TModelStoredProcedure.New;
  vSp.NOME('MANTER_PERIODO');
  vSp.PARAMETRO('pMODO').VALOR(Ord(pModo) ).AtribuirValor;
  vSp.PARAMETRO('PEMP' ).VALOR(FEmpresa   ).AtribuirValor;
  vSp.PARAMETRO('PPCL' ).VALOR(FParcela   ).AtribuirValor;
  vSp.PARAMETRO('PFAI' ).VALOR(FFaixa     ).AtribuirValor;
  vSp.PARAMETRO('PLIB' ).VALOR(FPcLib     ).AtribuirValor;
  vSp.PARAMETRO('PPERC').VALOR(FPercentual).AtribuirValor;
  vSp.Executar;
  //FormatSettings.DecimalSeparator := '.';
  //vSql := Format(SQL,[ Ord(pModo),
  //                     FEmpresa,
  //                     FParcela,
  //                     FFaixa,
  //                     FPcLib,
  //                     FPercentual ]);
  //FormatSettings.DecimalSeparator := ',';
  //FQuery.Executar(vSql);
  Result := Self;
end;

function TModelRegraComissao.PARCELA: Integer;
begin
  Result := FParcela;
end;

function TModelRegraComissao.PARCELA(pValor: Integer): iModelRegraComissao;
begin
  Result := Self;
  FParcela := pValor;
end;

function TModelRegraComissao.FAIXA: Integer;
begin
  Result := FFaixa;
end;

function TModelRegraComissao.FAIXA(pValor: Integer): iModelRegraComissao;
begin
  Result := Self;
  FFaixa := pValor;
end;

function TModelRegraComissao.PCLIB: Integer;
begin
  Result := FPcLib;
end;

function TModelRegraComissao.PCLIB(pValor: Integer): iModelRegraComissao;
begin
  Result := Self;
  FPcLib := pValor;
end;

function TModelRegraComissao.EMPRESA: Integer;
begin
  Result := FEmpresa;
end;

function TModelRegraComissao.EMPRESA(pValor: Integer): iModelRegraComissao;
begin
  Result := Self;
  FEmpresa := pValor;
end;

function TModelRegraComissao.PERCENTUAL: Double;
begin
  Result := FPercentual;
end;

function TModelRegraComissao.PERCENTUAL(pValor: Double): iModelRegraComissao;
begin
  Result := Self;
  FPercentual := pValor;
end;

end.

