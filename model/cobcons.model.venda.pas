unit cobcons.model.venda;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, cobcons.model.interfaces, cobcons.model.bufferdataset;
type

  { TModelVenda }

  TModelVenda = class(TInterfacedObject, iModelVenda)
    private
      FQuery: iQueryRest;
      FLista: TStringList;
      FBufDataset: iModelBufferDataset;

      FCodigo: Integer;
      FEmpresa: Integer;
      FContrato: String;
      FAgente: Integer;
      FDtVenda: TDateTime;
      FPeriodo: Integer;
      FCdBem: String;
      FDcBem: String;
      FValor: Double;
      FSituacao: Integer;
      FDtCon: TDateTime;
      FNome: String;
      FDdd: String;
      FFone: String;
      FTpPes: Integer;
      FCpfCnpj: String;
      FGrupo: String;
      FCota: Integer;
      FDiaVenc: Integer;
      FVlrPago: Double;
      FNmEmp: String;
      FNmAge: String;
      FDcSit: String;

      procedure AtualizarCampos;
      procedure CriarBufdataset;
      procedure PopularBufDataset(pDataset: TDataset);

    public
      constructor Create(aQuery: iQueryRest);
      destructor Destroy; override;
      class function New(aQuery: iQueryRest): iModelVenda;

      function ListaPorCodigo(pCodigo: Integer): iModelVenda;
      function ContratoJaInformado(pEmpresa: Integer; pContrato: String): Integer;
      function RetornaBem(pEmpresa: Integer; pCdBem: String): iModelVenda;
      function RetornarVendas(itPsq: Integer; stPesq: String): iModelBufferDataset;
      function Executar(pModo: TpModoManutencao): iModelVenda;
      function CancelarVenda(pCodigo: Integer; pData: TDateTime; pValor: Double): iModelVenda;
      function Dataset: TDataset;
      function CODIGO: Integer;
      function EMPRESA: Integer; overload;
      function EMPRESA(pValor: Integer): iModelVenda; overload;
      function CONTRATO: String; overload;
      function CONTRATO(pValor: String): iModelVenda; overload;
      function AGENTE: Integer; overload;
      function AGENTE(pValor: Integer): iModelVenda; overload;
      function DTVENDA: TDateTime; overload;
      function DTVENDA(pValor: TDateTime): iModelVenda; overload;
      function PERIODO: Integer; overload;
      function PERIODO(pValor: Integer): iModelVenda; overload;
      function CDBEM: String; overload;
      function CDBEM(pValor: String): iModelVenda; overload;
      function DCBEM: String; overload;
      function DCBEM(pValor: String): iModelVenda; overload;
      function VALOR: Double; overload;
      function VALOR(pValor: Double): iModelVenda; overload;
      function SITUACAO: Integer; overload;
      function SITUACAO(pValor: Integer): iModelVenda; overload;
      function DTCON: TDateTime; overload;
      function DTCON(pValor: TDateTime): iModelVenda; overload;
      function NOME: String; overload;
      function NOME(pValor: String): iModelVenda; overload;
      function DDD: String; overload;
      function DDD(pValor: String): iModelVenda; overload;
      function FONE: String; overload;
      function FONE(pValor: String): iModelVenda; overload;
      function TPPES: Integer; overload;
      function TPPES(pValor: Integer): iModelVenda; overload;
      function CPFCNPJ: String; overload;
      function CPFCNPJ(pValor: String): iModelVenda; overload;
      function GRUPO: String; overload;
      function GRUPO(pValor: String): iModelVenda; overload;
      function COTA: Integer; overload;
      function COTA(pValor: Integer): iModelVenda; overload;
      function DIAVENC: Integer; overload;
      function DIAVENC(pValor: Integer): iModelVenda; overload;
      function VLRPAGO: Double; overload;
      function VLRPAGO(pValor: Double): iModelVenda; overload;
      function NMEMP: String;
      function NMAGE: String;
      function DCSIT: String;
  end;

implementation

uses cobcons.controller.util, cobcons.model.storedprocedure;

{ TModelVenda }

procedure TModelVenda.AtualizarCampos;
begin
  if not FQuery.Dataset.EOF
  then begin
    FCodigo   := FQuery.FieldByName('CODIGO').AsInteger;
    FEmpresa  := FQuery.FieldByName('EMPRESA').AsInteger;
    FContrato := FQuery.FieldByName('CONTRATO').AsString;
    FAgente   := FQuery.FieldByName('AGENTE').AsInteger;
    FDtVenda  := FQuery.FieldByName('DTVENDA').AsDateTime;
    FPeriodo  := FQuery.FieldByName('PERIODO').AsInteger;
    FCdBem    := FQuery.FieldByName('CDBEM').AsString;
    FDcBem    := FQuery.FieldByName('DCBEM').AsString;
    FValor    := FQuery.FieldByName('VALOR').AsFloat;
    FSituacao := FQuery.FieldByName('SITUACAO').AsInteger;
    FDtCon    := FQuery.FieldByName('DTCON').AsDateTime;
    FNome     := FQuery.FieldByName('NOME').AsString;
    FDdd      := FQuery.FieldByName('DDD').AsString;
    FFone     := FQuery.FieldByName('FONE').AsString;
    FTpPes    := FQuery.FieldByName('TPPES').AsInteger;
    FCpfCnpj  := FQuery.FieldByName('CPFCNPJ').AsString;
    FGrupo    := FQuery.FieldByName('GRUPO').AsString;
    FCota     := FQuery.FieldByName('COTA').AsInteger;
    FDiaVenc  := FQuery.FieldByName('DIAVENC').AsInteger;
    FVlrPago  := FQuery.FieldByName('VLRPAGO').AsFloat;
    FNmEmp    := FQuery.FieldByName('NMEMP').AsString;
    FNmAge    := FQuery.FieldByName('NMAGE').AsString;
    FDcSit    := FQuery.FieldByName('DCSIT').AsString;
  end;
end;

procedure TModelVenda.CriarBufdataset;
begin
  with FBufDataset do
  begin
    ApagarBufDataset;
    NovoCampo.NOME('Codigo').TIPO(ftInteger).TAMANHO(0).AdicionarCampo;
    NovoCampo.NOME('Contrato').TIPO(ftString).TAMANHO(15).AdicionarCampo;
    NovoCampo.NOME('DtVenda').TIPO(ftDateTime).AdicionarCampo;
    NovoCampo.NOME('DcBem').TIPO(ftString).TAMANHO(20).AdicionarCampo;
    NovoCampo.NOME('Valor').TIPO(ftFloat).AdicionarCampo;
    NovoCampo.NOME('Nome').TIPO(ftString).TAMANHO(60).AdicionarCampo;
    NovoCampo.NOME('NmEmp').TIPO(ftString).TAMANHO(50).AdicionarCampo;
    NovoCampo.NOME('NmAge').TIPO(ftString).TAMANHO(50).AdicionarCampo;
    NovoCampo.NOME('DcSit').TIPO(ftString).TAMANHO(20).AdicionarCampo;
    CriarDataset;
    Formatacampo('Codigo'  ,'Cód'     , 6,taCenter,'000000');
    Formatacampo('Contrato','Contrato', 8,taCenter);
    Formatacampo('DtVenda' ,'Venda'   , 8,taCenter,'dd/mm/yyyy');
    Formatacampo('DcBem'   ,'Bem'     ,15,taLeftJustify);
    Formatacampo('Valor'   ,'Valor'   , 8,taRightJustify,',#0.00');
    Formatacampo('Nome'    ,'Nome'    ,25,taLeftJustify);
    Formatacampo('NmEmp'   ,'Empresa' ,15,taLeftJustify);
    Formatacampo('NmAge'   ,'Agente'  ,25,taLeftJustify);
    Formatacampo('DcSit'   ,'Situação',15,taLeftJustify);
  end;
end;

procedure TModelVenda.PopularBufDataset(pDataset: TDataset);
begin
  CriarBufdataset;
  pDataset.First;
  while not pDataset.EOF do
  begin
    with FBufDataset do
    begin
      NovoRegistro;
      CAMPO('Codigo'  ).VALOR(pDataset.FieldByName('Codigo'  ).Value).AtribuirValor;
      CAMPO('Contrato').VALOR(pDataset.FieldByName('Contrato').Value).AtribuirValor;
      CAMPO('DtVenda' ).VALOR(pDataset.FieldByName('DtVenda' ).Value).AtribuirValor;
      CAMPO('DcBem'   ).VALOR(pDataset.FieldByName('DcBem'   ).Value).AtribuirValor;
      CAMPO('Valor'   ).VALOR(pDataset.FieldByName('Valor'   ).Value).AtribuirValor;
      CAMPO('Nome'    ).VALOR(pDataset.FieldByName('Nome'    ).Value).AtribuirValor;
      CAMPO('NmEmp'   ).VALOR(pDataset.FieldByName('NmEmp'   ).Value).AtribuirValor;
      CAMPO('NmAge'   ).VALOR(pDataset.FieldByName('NmAge'   ).Value).AtribuirValor;
      CAMPO('DcSit'   ).VALOR(pDataset.FieldByName('DcSit'   ).Value).AtribuirValor;
      GravarRegistro;
    end;
    pDataset.Next;
  end;
  FBufDataset.PrimeiroRegistro;
end;

constructor TModelVenda.Create(aQuery: iQueryRest);
begin
  FQuery := aQuery;
  FLista := TStringList.Create;
  FBufDataset := TModelBufferDataset.New;
end;

destructor TModelVenda.Destroy;
begin
  FLista.Free;
  inherited Destroy;
end;

class function TModelVenda.New(aQuery: iQueryRest): iModelVenda;
begin
  Result := Self.Create(aQuery);
end;

function TModelVenda.ListaPorCodigo(pCodigo: Integer): iModelVenda;
const
  vSql =  'select V.*, E.NOMEFANTASIA NMEMP, A.NOME NMAGE, S.DESCRICAO DCSIT '+
          'from VENDAS V '+
          'inner join EMPRESA E on E.CODIGO=V.EMPRESA '+
          'inner join AGENTES A on A.CODIGO=V.AGENTE '+
          'inner join SITCON S on S.CODIGO=V.SITUACAO WHERE v.codigo = %d';
begin
  FQuery.Open(Format(vSql,[ pCodigo]));
  AtualizarCampos;
  Result := Self;
end;

function TModelVenda.ContratoJaInformado(pEmpresa: Integer; pContrato: String
  ): Integer;
const
  SQL = 'select CODIGO from VENDAS where EMPRESA = %d and CONTRATO = %s';
var
  vSql: String;
begin
  vSql := Format(SQL, [ pEmpresa, QuotedStr(pContrato) ]);
  Result := FQuery.Open( vSql ).Dataset.FieldByName('codigo').AsInteger;
end;

function TModelVenda.RetornaBem(pEmpresa: Integer; pCdBem: String): iModelVenda;
const
  SQL = 'select DCBEM, VALOR from BENS where EMPRESA = %d and CDBEM = %s';
var
  vSql: String;
begin
  FDcBem := '';
  FValor := 0;
  vSql   := Format(SQL, [ pEmpresa, QuotedStr(pCdBem) ]);
  if not FQuery.Open( vSql ).Dataset.EOF
  then begin
    FDcBem := FQuery.FieldByName('DCBEM').AsString;
    FValor := FQuery.FieldByName('VALOR').AsFloat;
  end;
  Result := Self;
end;

function TModelVenda.RetornarVendas(itPsq: Integer; stPesq: String
  ): iModelBufferDataset;
var
  vSql : string;
begin
  vSql := 'select V.codigo, v.contrato, v.dtvenda, v.dcbem, v.valor, v.nome,'+
                 'E.NOMEFANTASIA NMEMP, A.NOME NMAGE, S.DESCRICAO DCSIT '+
          'from VENDAS V '+
          'inner join EMPRESA E on E.CODIGO=V.EMPRESA '+
          'inner join AGENTES A on A.CODIGO=V.AGENTE '+
          'inner join SITCON S on S.CODIGO=V.SITUACAO ';
  //if DMPrincipal.Filial > 0
  //then vSql:=Format('%s inner join EQUIPES Q on Q.CODIGO=A.EQUIPE and Q.FILIAL=%d ',
  //                        [vSql,DMPrincipal.Filial]);
  case itPsq of
    0: vSql := Format('%s  where V.CODIGO=%d',
              [vSql, StrToIntDef(stPesq,0)]);
    1: vSql := Format('%s where V.NOME like %s order by V.NOME',
       [vSql,QuotedStr('%'+stPesq+'%')]);
    2: vSql := Format('%s where A.NOME like %s order by A.NOME',
       [vSql,QuotedStr('%'+stPesq+'%')]);
    3: vSql := Format('%s where V.CONTRATO like %s order by V.CONTRATO',
       [vSql,QuotedStr('%'+stPesq+'%')]);
    4: vSql := Format('%s where E.NOMEFANTASIA like %s order by E.NOMEFANTASIA',
       [vSql,QuotedStr('%'+stPesq+'%')]);
  end;
  PopularBufDataset(FQuery.Open(vSql).Dataset);
  Result := FBufDataset;
end;

function TModelVenda.Executar(pModo: TpModoManutencao): iModelVenda;
const
  SQL = 'CALL manter_vendas( %d, %d, %d, %s, %d, %s, %d, %s, %s, %f, %d, %s, %s, %s, %s, %d, %s, %s, %d, %d, %f )';
  FORMATAR_DATA = 'dd/MM/yy';
var
  vSql,
  vDtCon,
  vDtVenda: String;
  vSp: iModelStoredProcedure;

begin
  vSp := TModelStoredProcedure.New;
  vSp.NOME('MANTER_VENDAS');
  if DataEstaVazia(FDtVenda)
  then vDtVenda := 'null'
  else vDtVenda := QuotedStr(FormatDateTime(FORMATAR_DATA, FDtVenda));
  if DataEstaVazia(FDtCon)
  then vDtCon := 'null'
  else vDtCon := QuotedStr(FormatDateTime(FORMATAR_DATA, FDtCon));
  FormatSettings.DecimalSeparator := '.';
  vSp.PARAMETRO('PMODO').VALOR(Ord(pModo)).AtribuirValor;
  vSp.PARAMETRO('PCOD').VALOR(FCodigo).AtribuirValor;
  vSp.PARAMETRO('PEMPRESA').VALOR(FEmpresa).AtribuirValor;
  vSp.PARAMETRO('PCONTRATO').VALOR(FContrato).AtribuirValor;
  vSp.PARAMETRO('PAGENTE').VALOR(FAgente).AtribuirValor;
  vSp.PARAMETRO('PDTVENDA').VALOR(FDtVenda).AtribuirValor;
  vSp.PARAMETRO('PPERIODO').VALOR(FPeriodo).AtribuirValor;
  vSp.PARAMETRO('PCDBEM').VALOR(FCdBem).AtribuirValor;
  vSp.PARAMETRO('PDCBEM').VALOR(FDcBem).AtribuirValor;
  vSp.PARAMETRO('PVALOR').VALOR(FValor).AtribuirValor;
  vSp.PARAMETRO('PSIT').VALOR(FSituacao).AtribuirValor;
  //vSp.PARAMETRO('PDTCON').VALOR(FDtCon).AtribuirValor;
  vSp.PARAMETRO('PNOME').VALOR(FNome).AtribuirValor;
  vSp.PARAMETRO('PDDD').VALOR(FDdd).AtribuirValor;
  vSp.PARAMETRO('PFONE').VALOR(RetornaSemFormatacao(FFone)).AtribuirValor;
  vSp.PARAMETRO('PTPPES').VALOR(FTpPes).AtribuirValor;
  vSp.PARAMETRO('PCPFCNPJ').VALOR(RetornaSemFormatacao(FCpfCnpj)).AtribuirValor;
  vSp.PARAMETRO('PGRUPO').VALOR(FGrupo).AtribuirValor;
  vSp.PARAMETRO('PCOTA').VALOR(FCota).AtribuirValor;
  vSp.PARAMETRO('PDIAVENC').VALOR(FDiaVenc).AtribuirValor;
  vSp.PARAMETRO('PVLRPAGO').VALOR(FVlrPago).AtribuirValor;
  //vSql := Format(SQL,[ Ord(pModo),
  //                     FCodigo,
  //                     FEmpresa,
  //                     QuotedStr(FContrato),
  //                     FAgente,
  //                     vDtVenda,
  //                     FPeriodo,
  //                     QuotedStr(FCdBem),
  //                     QuotedStr(FDcBem),
  //                     FValor,
  //                     FSituacao,
  //                     vDtCon,
  //                     QuotedStr(FNome),
  //                     QuotedStr(FDdd),
  //                     QuotedStr(RetornaSemFormatacao(FFone)),
  //                     FTpPes,
  //                     QuotedStr(RetornaSemFormatacao(FCpfCnpj)),
  //                     QuotedStr(FGrupo),
  //                     FCota,
  //                     FDiaVenc,
  //                     FVlrPago ]);
  FormatSettings.DecimalSeparator := ',';
  //FQuery.Executar(vSql);
  vSp.Executar;
  Result := Self;
end;

function TModelVenda.CancelarVenda(pCodigo: Integer; pData: TDateTime;
  pValor: Double): iModelVenda;
var
  vSql: String;
  vSp: iModelStoredProcedure;
begin
  // cancelar a venda
  vSql := Format('update VENDAS set SITUACAO = 4 where CODIGO=%d', [ pCodigo ]);
  FQuery.Executar(vSql);
  // excluir parcelas a receber
  vSql := Format('delete from PARCELAS where VENDA = %d and (RECEBIDO+PAGO) <= 0 and PARCELA < 99 ',
               [ pCodigo ]);
  FQuery.Executar(vSql);
  // incluir parcela 99
  vSp := TModelStoredProcedure.New;
  vSp.NOME('MANTER_PARCELAS');
  vSp.PARAMETRO('PMODO'     ).VALOR(0      ).AtribuirValor;
  vSp.PARAMETRO('PVENDA'    ).VALOR(pCodigo).AtribuirValor;
  vSp.PARAMETRO('PPARCELA'  ).VALOR(99     ).AtribuirValor;
  vSp.PARAMETRO('PDTVENC'   ).VALOR(pData  ).AtribuirValor;
  vSp.PARAMETRO('PPERIODO'  ).VALOR(0      ).AtribuirValor;
  vSp.PARAMETRO('PRECEBER'  ).VALOR(pValor ).AtribuirValor;
  vSp.PARAMETRO('PRECEBIDO' ).VALOR(pValor ).AtribuirValor;
  vSp.PARAMETRO('PPAGAR'    ).VALOR(0.0    ).AtribuirValor;
  vSp.PARAMETRO('PPAGO'     ).VALOR(0.0    ).AtribuirValor;
  vSp.PARAMETRO('PDTREC'    ).VALOR(pData  ).AtribuirValor;
  vSp.Executar;
  //FormatSettings.DecimalSeparator := '.';
  //vSql := Format('EXECUTE PROCEDURE manter_parcelas( %d, %d, %d, %s, %d, %f, %f, %f, %f, %s )',
  //             [ 0,
  //               pCodigo,
  //               99,
  //               QuotedStr(RetornaDataSql(pData)),
  //               0,
  //               pValor,
  //               pValor,
  //               0.0,
  //               0.0,
  //               QuotedStr(RetornaDataSql(pData)) ]);
  //FormatSettings.DecimalSeparator := ',';
  //FQuery.Executar(vSql);
  Result := Self;
end;

function TModelVenda.Dataset: TDataset;
begin
  Result := FQuery.Dataset;
end;

function TModelVenda.CODIGO: Integer;
begin
  Result := FCodigo;
end;

function TModelVenda.EMPRESA: Integer;
begin
  Result := FEmpresa;
end;

function TModelVenda.EMPRESA(pValor: Integer): iModelVenda;
begin
  Result := Self;
  FEmpresa := pValor;
end;

function TModelVenda.CONTRATO: String;
begin
  Result := FContrato;
end;

function TModelVenda.CONTRATO(pValor: String): iModelVenda;
begin
  Result := Self;
  FContrato := pValor;
end;

function TModelVenda.AGENTE: Integer;
begin
  Result := FAgente;
end;

function TModelVenda.AGENTE(pValor: Integer): iModelVenda;
begin
  Result := Self;
  FAgente := pValor;
end;

function TModelVenda.DTVENDA: TDateTime;
begin
  Result := FDtVenda;
end;

function TModelVenda.DTVENDA(pValor: TDateTime): iModelVenda;
begin
  Result := Self;
  FDtVenda := pValor;
end;

function TModelVenda.PERIODO: Integer;
begin
  Result := FPeriodo;
end;

function TModelVenda.PERIODO(pValor: Integer): iModelVenda;
begin
  Result := Self;
  FPeriodo := pValor;
end;

function TModelVenda.CDBEM: String;
begin
  Result := FCdBem;
end;

function TModelVenda.CDBEM(pValor: String): iModelVenda;
begin
  Result := Self;
  FCdBem := pValor;
end;

function TModelVenda.DCBEM: String;
begin
  Result := FDcBem;
end;

function TModelVenda.DCBEM(pValor: String): iModelVenda;
begin
  Result := Self;
  FDcBem := pValor;
end;

function TModelVenda.VALOR: Double;
begin
  Result := FValor;
end;

function TModelVenda.VALOR(pValor: Double): iModelVenda;
begin
  Result := Self;
  FValor := pValor;
end;

function TModelVenda.SITUACAO: Integer;
begin
  Result := FSituacao;
end;

function TModelVenda.SITUACAO(pValor: Integer): iModelVenda;
begin
  Result := Self;
  FSituacao := pValor;
end;

function TModelVenda.DTCON: TDateTime;
begin
  Result := FDtCon;
end;

function TModelVenda.DTCON(pValor: TDateTime): iModelVenda;
begin
  Result := Self;
  FDtCon := pValor;
end;

function TModelVenda.NOME: String;
begin
  Result := FNome;
end;

function TModelVenda.NOME(pValor: String): iModelVenda;
begin
  Result := Self;
  FNome := pValor;
end;

function TModelVenda.DDD: String;
begin
  Result := FDdd;
end;

function TModelVenda.DDD(pValor: String): iModelVenda;
begin
  Result := Self;
  FDdd := pValor;
end;

function TModelVenda.FONE: String;
begin
  Result := FFone;
end;

function TModelVenda.FONE(pValor: String): iModelVenda;
begin
  Result := Self;
  FFone := pValor;
end;

function TModelVenda.TPPES: Integer;
begin
  Result := FTpPes;
end;

function TModelVenda.TPPES(pValor: Integer): iModelVenda;
begin
  Result := Self;
  FTpPes := pValor;
end;

function TModelVenda.CPFCNPJ: String;
begin
  Result := FCpfCnpj;
end;

function TModelVenda.CPFCNPJ(pValor: String): iModelVenda;
begin
  Result := Self;
  FCpfCnpj := pValor;
end;

function TModelVenda.GRUPO: String;
begin
  Result := FGrupo;
end;

function TModelVenda.GRUPO(pValor: String): iModelVenda;
begin
  Result := Self;
  FGrupo := pValor;
end;

function TModelVenda.COTA: Integer;
begin
  Result := FCota;
end;

function TModelVenda.COTA(pValor: Integer): iModelVenda;
begin
  Result := Self;
  FCota := pValor;
end;

function TModelVenda.DIAVENC: Integer;
begin
  Result := FDiaVenc;
end;

function TModelVenda.DIAVENC(pValor: Integer): iModelVenda;
begin
  Result := Self;
  FDiaVenc := pValor;
end;

function TModelVenda.VLRPAGO: Double;
begin
  Result := FVlrPago;
end;

function TModelVenda.VLRPAGO(pValor: Double): iModelVenda;
begin
  Result := Self;
  FVlrPago := pValor;
end;

function TModelVenda.NMEMP: String;
begin
  Result := FNmEmp;
end;

function TModelVenda.NMAGE: String;
begin
  Result := FNmAge;
end;

function TModelVenda.DCSIT: String;
begin
  Result := FDcSit;
end;

end.

