unit cobcons.model.parcelacomissao;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, cobcons.model.interfaces, cobcons.model.bufferdataset;
type

  { TModelParcelaComissao }

  TModelParcelaComissao = class(TInterfacedObject, iModelParcelaComissao)
    private
      FQuery: iQueryRest;
      FBufDataset: iModelBufferDataset;

      FVenda: Integer;
      FParcela: Integer;
      FDtVenc: TDateTime;
      FPeriodo: Integer;
      FReceber: Double;
      FRecebido: Double;
      FPagar: Double;
      FPago: Double;
      FDtRec: TDateTime;

      procedure AtualizarCampos;
      procedure CriarBufdataset;
      procedure PopularBufDataset(pDataset: TDataset);

    public
      constructor Create(aQuery: iQueryRest);
      destructor Destroy; override;
      class function New(aQuery: iQueryRest): iModelParcelaComissao;

      function ListaPorCodigo(pVenda, pParcela: Integer): iModelParcelaComissao;
      function ListaPorVenda(pVenda: Integer): TDataSet;
      function ExisteParcela(pEmpresa: Integer; pContrato: String; pParcela: Integer): Boolean;
      function RetornarParcelasPendentes(itPsq: Integer; stPesq: String): iModelBufferDataset;
      function Executar(pModo: TpModoManutencao): iModelParcelaComissao;
      function VENDA: Integer; overload;
      function VENDA(pValor: Integer): iModelParcelaComissao; overload;
      function PARCELA: Integer; overload;
      function PARCELA(pValor: Integer): iModelParcelaComissao; overload;
      function DTVENC: TDateTime; overload;
      function DTVENC(pValor: TDateTime): iModelParcelaComissao; overload;
      function PERIODO: Integer; overload;
      function PERIODO(pValor: Integer): iModelParcelaComissao; overload;
      function RECEBER: Double; overload;
      function RECEBER(pValor: Double): iModelParcelaComissao; overload;
      function RECEBIDO: Double; overload;
      function RECEBIDO(pValor: Double): iModelParcelaComissao; overload;
      function PAGAR: Double; overload;
      function PAGAR(pValor: Double): iModelParcelaComissao; overload;
      function PAGO: Double; overload;
      function PAGO(pValor: Double): iModelParcelaComissao; overload;
      function DTREC: TDateTime; overload;
      function DTREC(pValor: TDateTime): iModelParcelaComissao; overload;

  end;

implementation

uses cobcons.controller.util;

{ TModelParcelaComissao }

procedure TModelParcelaComissao.AtualizarCampos;
begin
  if not FQuery.Dataset.EOF
  then begin
    FVenda    := FQuery.FieldByName('VENDA').AsInteger;
    FParcela  := FQuery.FieldByName('PARCELA').AsInteger;
    FDtVenc   := FQuery.FieldByName('DTVENC').AsDateTime;
    FPeriodo  := FQuery.FieldByName('PERIODO').AsInteger;
    FReceber  := FQuery.FieldByName('RECEBER').AsFloat;
    FRecebido := FQuery.FieldByName('RECEBIDO').AsFloat;
    FPagar    := FQuery.FieldByName('PAGAR').AsFloat;
    FPago     := FQuery.FieldByName('PAGO').AsFloat;
    FDtRec    := FQuery.FieldByName('DTREC').AsDateTime;
  end;
end;

procedure TModelParcelaComissao.CriarBufdataset;
begin
  with FBufDataset do
  begin
    ApagarBufDataset;
    NovoCampo.NOME('CdVen'   ).TIPO(ftInteger).TAMANHO(0).AdicionarCampo;
    NovoCampo.NOME('NmEmp'   ).TIPO(ftString).TAMANHO(50).AdicionarCampo;
    NovoCampo.NOME('Contrato').TIPO(ftString).TAMANHO(15).AdicionarCampo;
    NovoCampo.NOME('Grupo'   ).TIPO(ftString).TAMANHO(10).AdicionarCampo;
    NovoCampo.NOME('Cota'    ).TIPO(ftInteger).AdicionarCampo;
    NovoCampo.NOME('NmCli'   ).TIPO(ftString).TAMANHO(60).AdicionarCampo;
    NovoCampo.NOME('DtVenda' ).TIPO(ftDateTime).AdicionarCampo;
    NovoCampo.NOME('DcBem'   ).TIPO(ftString).TAMANHO(20).AdicionarCampo;
    NovoCampo.NOME('Valor'   ).TIPO(ftFloat).AdicionarCampo;
    NovoCampo.NOME('Parcela' ).TIPO(ftInteger).AdicionarCampo;
    NovoCampo.NOME('DtVenc'  ).TIPO(ftDateTime).AdicionarCampo;
    NovoCampo.NOME('Receber' ).TIPO(ftFloat).AdicionarCampo;
    CriarDataset;
    Formatacampo('CdVen'   ,'Cód'     , 6,taCenter,'000000');
    Formatacampo('NmEmp'   ,'Empresa' ,10,taLeftJustify);
    Formatacampo('Contrato','Contrato', 8,taCenter);
    Formatacampo('Grupo'   ,'Grupo'   , 8,taCenter);
    Formatacampo('Cota'    ,'Cota'    , 6,taCenter,'00000');
    Formatacampo('NmCli'   ,'Cliente' ,25,taLeftJustify);
    Formatacampo('DtVenda' ,'Venda'   , 8,taCenter,'dd/mm/yyyy');
    Formatacampo('DcBem'   ,'Bem'     ,15,taLeftJustify);
    Formatacampo('Valor'   ,'Valor'   , 8,taRightJustify,',#0.00');
    Formatacampo('Parcela' ,'Pcl'     , 3,taCenter,'00');
    Formatacampo('DtVenc'  ,'Vencto'  , 8,taCenter,'dd/mm/yyyy');
    Formatacampo('Receber' ,'Receber' , 8,taRightJustify,',#0.00');
  end;
end;

procedure TModelParcelaComissao.PopularBufDataset(pDataset: TDataset);
begin
  CriarBufdataset;
  pDataset.First;
  while not pDataset.EOF do
  begin
    with FBufDataset do
    begin
      NovoRegistro;
      CAMPO('CdVen'   ).VALOR(pDataset.FieldByName('CdVen'   ).Value).AtribuirValor;
      CAMPO('NmEmp'   ).VALOR(pDataset.FieldByName('NmEmp'   ).Value).AtribuirValor;
      CAMPO('Contrato').VALOR(pDataset.FieldByName('Contrato').Value).AtribuirValor;
      CAMPO('Grupo'   ).VALOR(pDataset.FieldByName('Grupo'   ).Value).AtribuirValor;
      CAMPO('Cota'    ).VALOR(pDataset.FieldByName('Cota'    ).Value).AtribuirValor;
      CAMPO('NmCli'   ).VALOR(pDataset.FieldByName('NmCli'   ).Value).AtribuirValor;
      CAMPO('DtVenda' ).VALOR(pDataset.FieldByName('DtVenda' ).Value).AtribuirValor;
      CAMPO('DcBem'   ).VALOR(pDataset.FieldByName('DcBem'   ).Value).AtribuirValor;
      CAMPO('Valor'   ).VALOR(pDataset.FieldByName('Valor'   ).Value).AtribuirValor;
      CAMPO('Parcela' ).VALOR(pDataset.FieldByName('Parcela' ).Value).AtribuirValor;
      CAMPO('DtVenc'  ).VALOR(pDataset.FieldByName('DtVenc'  ).Value).AtribuirValor;
      CAMPO('Receber' ).VALOR(pDataset.FieldByName('Receber' ).Value).AtribuirValor;
      GravarRegistro;
    end;
    pDataset.Next;
  end;
  FBufDataset.PrimeiroRegistro;
end;

constructor TModelParcelaComissao.Create(aQuery: iQueryRest);
begin
  FQuery := aQuery;
  FBufDataset := TModelBufferDataset.New;
end;

destructor TModelParcelaComissao.Destroy;
begin
  inherited Destroy;
end;

class function TModelParcelaComissao.New(aQuery: iQueryRest): iModelParcelaComissao;
begin
  Result := Self.Create(aQuery);
end;

function TModelParcelaComissao.ListaPorCodigo(pVenda, pParcela: Integer
  ): iModelParcelaComissao;
const
  vSql = 'SELECT * FROM parcelas WHERE venda = %d AND parcela = %d ';
begin
  FQuery.Open(Format(vSql,[ pVenda, pParcela ]));
  AtualizarCampos;
  Result := Self;
end;

function TModelParcelaComissao.ListaPorVenda(pVenda: Integer): TDataSet;
const
  SQL = 'SELECT * FROM parcelas WHERE venda = %d ORDER BY parcela';
var
  vSql: String;
begin
  vSql := Format(SQL,[ pVenda ]);
  Result := FQuery.Open(vSql).Dataset;
end;

function TModelParcelaComissao.ExisteParcela(pEmpresa: Integer;
  pContrato: String; pParcela: Integer): Boolean;
const
  vSql =
    'select P.* from PARCELAS P '+
    'inner join VENDAS V on V.CODIGO=P.VENDA '+
    'where V.EMPRESA = %d and V.CONTRATO = %s and P.PARCELA = %d';
begin
  FQuery.Open(Format(vSql,[ pEmpresa, QuotedStr(pContrato), pParcela ]));
  AtualizarCampos;
  Result := not FQuery.Dataset.EOF;
end;

function TModelParcelaComissao.RetornarParcelasPendentes(itPsq: Integer;
  stPesq: String): iModelBufferDataset;
var
  vSql : string;
begin
  vSql := 'select V.CDVEN, V.NMEMP, V.CONTRATO, V.GRUPO, V.COTA, V.NMCLI,'+
                 'V.DTVENDA, V.DCBEM, V.VALOR, P.* from PARCELAS P '+
          'inner join VENDAS_COMPLETAS V on V.CDVEN = P.VENDA '+
          'where (P.RECEBIDO=0 and p.dtrec is null or p.dtrec = ''30-dec-1899'') '+
                 'and P.DTVENC <= current_date ';

  if stPesq<>'' then begin
    case itPsq of
      0: vSql := Format('%s and V.CDVEN=%d',    // CODIGO
              [vSql, StrToIntDef(stPesq,0)]);
      1: vSql := Format('%s and V.NMCLI like %s ',    // NOME CLIENTE
         [vSql,QuotedStr('%'+stPesq+'%')]);
      2: vSql := Format('%s and V.CONTRATO like %s ',
         [vSql,QuotedStr('%'+stPesq+'%')]);
      3: vSql := Format('%s and V.NMEMP like %s ',
         [vSql,QuotedStr('%'+stPesq+'%')]);
    end;
  end;

  vSql:=Format('%s order by V.NMEMP, V.CDVEN, P.DTVENC, P.PARCELA',[vSql]);
  PopularBufDataset(FQuery.Open(vSql).Dataset);
  Result := FBufDataset;
end;

function TModelParcelaComissao.Executar(pModo: TpModoManutencao): iModelParcelaComissao;
const
  SQL = 'CALL manter_parcelas( %d, %d, %d, %s, %d, %f, %f, %f, %f, %s )';
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  vSql := Format(SQL,[ Ord(pModo),
                       FVenda,
                       FParcela,
                       QuotedStr(RetornaDataSql(FDtVenc)),
                       FPeriodo,
                       FReceber,
                       FRecebido,
                       FPagar,
                       FPago ,
                       QuotedStr(RetornaDataSql(FDtRec))
                       ]);
  FormatSettings.DecimalSeparator := ',';
  FQuery.Executar(vSql);
  Result := Self;
end;

function TModelParcelaComissao.VENDA: Integer;
begin
  Result := FVenda;
end;

function TModelParcelaComissao.VENDA(pValor: Integer): iModelParcelaComissao;
begin
  Result := Self;
  FVenda := pValor;
end;

function TModelParcelaComissao.PARCELA: Integer;
begin
  Result := FParcela;
end;

function TModelParcelaComissao.PARCELA(pValor: Integer): iModelParcelaComissao;
begin
  Result := Self;
  FParcela := pValor;
end;

function TModelParcelaComissao.DTVENC: TDateTime;
begin
  Result := FDtVenc;
end;

function TModelParcelaComissao.DTVENC(pValor: TDateTime): iModelParcelaComissao;
begin
  Result := Self;
  FDtVenc := pValor;
end;

function TModelParcelaComissao.PERIODO: Integer;
begin
  Result := FPeriodo;
end;

function TModelParcelaComissao.PERIODO(pValor: Integer): iModelParcelaComissao;
begin
  Result := Self;
  FPeriodo := pValor;
end;

function TModelParcelaComissao.RECEBER: Double;
begin
  Result := FReceber;
end;

function TModelParcelaComissao.RECEBER(pValor: Double): iModelParcelaComissao;
begin
  Result := Self;
  FReceber := pValor;
end;

function TModelParcelaComissao.RECEBIDO: Double;
begin
  Result := FRecebido;
end;

function TModelParcelaComissao.RECEBIDO(pValor: Double): iModelParcelaComissao;
begin
  Result := Self;
  FRecebido := pValor;
end;

function TModelParcelaComissao.PAGAR: Double;
begin
  Result := FPagar;
end;

function TModelParcelaComissao.PAGAR(pValor: Double): iModelParcelaComissao;
begin
  Result := Self;
  FPagar := pValor;
end;

function TModelParcelaComissao.PAGO: Double;
begin
  Result := FPago;
end;

function TModelParcelaComissao.PAGO(pValor: Double): iModelParcelaComissao;
begin
  Result := Self;
  FPago := pValor;
end;

function TModelParcelaComissao.DTREC: TDateTime;
begin
  Result := FDtRec;
end;

function TModelParcelaComissao.DTREC(pValor: TDateTime): iModelParcelaComissao;
begin
  Result := Self;
  FDtRec := pValor;
end;

end.

