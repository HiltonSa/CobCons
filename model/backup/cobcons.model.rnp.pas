unit cobcons.model.rnp;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, Dialogs, cobcons.model.interfaces,
  cobcons.model.bufferdataset, cobcons.controller.interfaces,
  cobcons.model.sql.interfaces, db, Variants;

type

   { TModelRnp }

   TModelRnp = class (TInterfacedObject, iModelRnp)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlRnp;
       FCMP: iModelBufferDataset;

       FGrupo: string;
       FSeq: string;
       FCota: string;
       FPercAmort: Double;
       FVlrBem: Double;
       FVlrRnp: Double;
       FRatFut: Double;
       FPcRateio: Double;

       function RetornarSQL(pTipo: Integer): string;
       procedure PopularSaldoRnp(pDtRecRnp: TDateTime);
       procedure CriarFCMP;
       procedure IncluirFCMP(pGrupo, pCota, pSeq, pNome: String; pVlSag, pVlRnp: Double);

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelRnp;

       function CriarTabela: iModelRnp;
       function CriarTabelaSaldo(Pdtrecrnp: Tdatetime): iModelRnp;
       function CriarTabelaCheck: iModelRnp;
       function TabelaExiste: Boolean;
       function TabelaSaldoExiste: Boolean;
       function TabelaCheckExiste: Boolean;
       function Novo: iModelRnp;
       function NovoCheck(pGrupo, pSeq, pCota: String; pRel, pPla: Integer;pRecRel, pRecPla, pComRel, pComPla: Double): Imodelrnp;
       function GravarCheck(pGrupo, pSeq, pCota: String; pRel, pPla: Integer;pRecRel, pRecPla, pComRel, pComPla: Double): Imodelrnp;
       function ApagarDados: iModelRnp;
       function ApagarCheck: iModelRnp;
       function RetornaRnp: iModelRnp;
       function RetornaCheck: iModelRnp;
       function RetornaSaldoInicialRnp: Double;
       function RetornaSaldoInicialSiacon: Double;
       function RetornaSomenteRnp: iModelRnp;
       function RetornaComissaoPermanencia(pDataCalculo: TDateTime): iModelRnp;
       function RetornaRnpRateiosFuturos: iModelRnp;
       function RetornaUmRnp(pGrupo, pSeq, pCota: String): iModelRnp;
       function RetornaUmCheck(pGrupo, pSeq, pCota: String): iModelRnp;
       function RetornaRnpGrupo(pGrupo: String): iModelRnp;
       function RetornaRecomposicaoSaldosGrupo(pGrupo: String): iModelRnp;
       function RetornaRecomposicaoSaldosTodos: iModelRnp;
       function TotalizaRecomposicaoRnp: iModelRnp;
       function SaldoDataBase(pGRupo, pSeq, pCota: String; pDataLimite: TDateTime): Currency;
       function SaldoRnp31Dez21(pGRupo, pSeq, pCota: String): Currency;
       function Gravar: iModelRnp;
       function GravarRateioFuturo: iModelRnp;
       function GravarSaldoRnp: iModelRnp;
       function GravarSaldoSiaconRnp(pGrupo, pSeq, pCota: String; pSiacon: Double): iModelRnp;
       function CompararSAG: TDataSet; overload;
       function CompararSAG(pArquivoSag: TStringList): TDataSet; overload;
       function RnpSag: TDataSet;
       function DataSet: TDataSet;
       function TemDados: Boolean;
       function Proximo: Boolean;
       function GRUPO(aValue: String): iModelRnp; overload;
       function SEQ(aValue: String): iModelRnp; overload;
       function COTA(aValue: String): iModelRnp; overload;
       function PERCAMORT(aValue: Double): iModelRnp;
       function VLRRNP(aValue: Double): iModelRnp; overload;
       function VLRRNP: Double; overload;
       function VLRBEM(aValue: Double): iModelRnp;
       function RATFUT(aValue: Double): iModelRnp;
       function PCRATEIO(aValue: Double): iModelRnp;
       function GRUPO: String; overload;
       function SEQ: String; overload;
       function COTA: String; overload;
       function FATOR: double;
       function TXPER: double;
       function VLMIN: double;
       function NOME: String;
   end;


implementation

uses cobcons.controller.util, cobcons.controller.factory,
  cobcons.model.sql.factory, cobcons.model.factory;


{ TModelRnp }

function TModelRnp.RetornarSQL(pTipo: Integer): string;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  case Ptipo of
    0: vSql := Format(FSQL.SqlNovo,
          [ QuotedStr(FGrupo),
            QuotedStr(FSeq),
            QuotedStr(FCota),
            FPercAmort,
            FVlrRnp,
            FVlrBem,
            FRatFut,
            FPcRateio]);

    1: vSql := Format(FSQL.SqlAlterar,
          [ FPercAmort,
            FVlrRnp,
            FVlrBem,
            FRatFut,
            FPcRateio,
            QuotedStr(FGrupo),
            QuotedStr(FSeq),
            QuotedStr(FCota)]);
    2: vSql := Format(FSQL.SqlGravaRateioFuturo,
          [ FRatFut,
            FPcRateio,
            QuotedStr(FGrupo),
            QuotedStr(FSeq),
            QuotedStr(FCota)]);
    3: vSql := Format(FSQL.SqlGravaSaldoRnp,
          [ FVlrRnp,
            QuotedStr(FGrupo),
            QuotedStr(FSeq),
            QuotedStr(FCota)]);
    4: vSql := Format(FSQL.SqlRetornaSaldoInicialRnp,
          [ QuotedStr(FGrupo),
            QuotedStr(FSeq),
            QuotedStr(FCota)]);
  end;
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

procedure TModelRnp.PopularSaldoRnp(pDtRecRnp: TDateTime);
const
  SQL_SALDO_DATA =
    'select R.CODGRUPO, R.SEQCOTA, R.CODCOTA, R.RECNAOPROCURADO from RECGRUPOSENC R '+
    'inner join SAG S on S.CODSAG = R.CODSAG and S.DTBASE = %s '+
    'where R.RECNAOPROCURADO > 0 '+
    'order by R.CODGRUPO, R.SEQCOTA, R.CODCOTA';
var
  vSql: String;
  qryBdSag: iQueryRest;
begin
  vSql := Format(SQL_SALDO_DATA, [QuotedStr(FormatDateTime('yyyy-mm', Pdtrecrnp))]);
  Qrybdsag.Open(vSql);
  while not Qrybdsag.Dataset.EOF do
  begin
    FormatSettings.DecimalSeparator := '.';
    vSql := Format(FSQL.SqlNovoSaldo,
              [ QuotedStr(Qrybdsag.FieldByName('CODGRUPO').AsString),
                QuotedStr(Qrybdsag.FieldByName('SEQCOTA').AsString),
                QuotedStr(Qrybdsag.FieldByName('CODCOTA').AsString),
                Qrybdsag.FieldByName('RECNAOPROCURADO').AsFloat, 0.0]);
    FormatSettings.DecimalSeparator := ',';
    FQuery.Executar(vSql);
    Qrybdsag.Dataset.Next;
  end;

end;

procedure TModelRnp.CriarFCMP;
begin
  FCMP := TModelBufferDataset.New;
  FCMP.NovoCampo.NOME('Grupo').TIPO(ftString).TAMANHO(5).AdicionarCampo;
  FCMP.NovoCampo.NOME('Cota').TIPO(ftString).TAMANHO(3).AdicionarCampo;
  FCMP.NovoCampo.NOME('Seq').TIPO(ftString).TAMANHO(2).AdicionarCampo;
  FCMP.NovoCampo.NOME('Nome').TIPO(ftString).TAMANHO(60).AdicionarCampo;
  FCMP.NovoCampo.NOME('VlSag').TIPO(ftFloat).AdicionarCampo;
  FCMP.NovoCampo.NOME('VlRnp').TIPO(ftFloat).AdicionarCampo;
  FCMP.NovoCampo.NOME('VlDif').TIPO(ftFloat).AdicionarCampo;
  FCMP.CriarDataset;
  FCMP.Formatacampo('Grupo','Grupo',5, taCenter);
  FCMP.Formatacampo('Cota', 'Cota', 3, taCenter);
  FCMP.Formatacampo('Seq', 'Sq', 2, taCenter);
  FCMP.Formatacampo('Nome', 'Consorciado', 30, taLeftJustify);
  FCMP.Formatacampo('VlSag', 'SAG', 8, taRightJustify, '#,0.00');
  FCMP.Formatacampo('VlRnp', 'RNP', 8, taRightJustify, '#,0.00');
  FCMP.Formatacampo('VlDif', 'Dif', 8, taRightJustify, '#,0.00');
  FCMP.OrdenarPorCampos('Grupo;Cota;Seq');
end;

procedure TModelRnp.IncluirFCMP(pGrupo, pCota, pSeq, pNome: String; pVlSag,
  pVlRnp: Double);
begin
  FCMP.NovoRegistro;
  FCMP.CAMPO('Grupo').VALOR(pGrupo).AtribuirValor;
  FCMP.CAMPO('Cota').VALOR(pCota).AtribuirValor;
  FCMP.CAMPO('Seq').VALOR(pSeq).AtribuirValor;
  FCMP.CAMPO('Nome').VALOR(pNome).AtribuirValor;
  FCMP.CAMPO('VlSag').VALOR(pVlSag).AtribuirValor;
  FCMP.CAMPO('VlRnp').VALOR(pVlRnp).AtribuirValor;
  FCMP.CAMPO('VlDif').VALOR(pVlSag - pVlRnp).AtribuirValor;
  FCMP.GravarRegistro;
end;

constructor TModelRnp.Create(aQuery: iQueryRest);
begin
  FSQL := TModelSQLFactory.New.SqlRNP;
  FQuery := Aquery;
end;

destructor TModelRnp.Destroy;
begin
  inherited Destroy;
end;

class function TModelRnp.New(aQuery: iQueryRest): iModelRnp;
begin
  Result := Self.Create(Aquery);
end;

function TModelRnp.CriarTabela: iModelRnp;
begin
  Result := Self;
  FQuery.Executar(FSQL.SqlCriarTabela);
end;

function TModelRnp.CriarTabelaSaldo(Pdtrecrnp: Tdatetime
  ): iModelRnp;
var
  Qrybdsag: Iqueryrest;
begin
  Result := Self;
  FQuery.Executar(FSQL.SqlCriarTabelaSaldo);
  PopularSaldoRnp(Pdtrecrnp);
end;

function TModelRnp.CriarTabelaCheck: iModelRnp;
begin
  Result := Self;
  FQuery.Executar(FSQL.SqlCriarTabelaCheck);
end;

function TModelRnp.TabelaExiste: Boolean;
begin
  Result := FQuery.Open(FSQL.SqlTabelaExiste).FieldByName('QTDE').AsInteger > 0;
end;

function TModelRnp.TabelaSaldoExiste: Boolean;
begin
  Result := FQuery.Open(FSQL.SqlTabelaSaldoExiste).FieldByName('QTDE').AsInteger > 0;
end;

function TModelRnp.TabelaCheckExiste: Boolean;
begin
  Result := FQuery.Open(FSQL.SqlTabelaCheckExiste).FieldByName('QTDE').AsInteger > 0;
end;

function TModelRnp.Novo: iModelRnp;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(0));
end;

function TModelRnp.NovoCheck(pGrupo, pSeq, pCota: String; pRel, pPla: Integer;
  pRecRel, pRecPla, pComRel, pComPla: Double): Imodelrnp;
var
  vSql: String;
begin
  Result := Self;
  FormatSettings.DecimalSeparator := '.';
  vSql := Format(FSQL.SqlNovoCheck,
          [ QuotedStr(pGrupo),
            QuotedStr(pSeq),
            QuotedStr(pCota),
            Prel, Ppla,
            Precrel,
            Precpla,
            Pcomrel,
            Pcompla]);
  FormatSettings.DecimalSeparator := ',';
  FQuery.Executar(vSql);
end;

function TModelRnp.GravarCheck(pGrupo, pSeq, pCota: String; pRel,
  pPla: Integer; pRecRel, pRecPla, pComRel, pComPla: Double): Imodelrnp;
var
  vSql: String;
begin
  Result := Self;
  FormatSettings.DecimalSeparator := '.';
  if pRel = 1
  then vSql := Format(FSQL.SqlGravaCheckRel,
          [ Prel,
            Precrel,
            Pcomrel,
            QuotedStr(pGrupo),
            QuotedStr(pSeq),
            QuotedStr(pCota)
            ])
  else if pPla = 1
  then vSql := Format(FSQL.SqlGravaCheckPla,
          [ Ppla,
            Precpla,
            Pcompla,
            QuotedStr(pGrupo),
            QuotedStr(pSeq),
            QuotedStr(pCota)
            ]);
  FormatSettings.DecimalSeparator := ',';
  FQuery.Executar(vSql);
end;

function TModelRnp.ApagarDados: iModelRnp;
begin
  Result := Self;
  FQuery.Executar(FSQL.SqlApagarDados);
end;

function TModelRnp.ApagarCheck: iModelRnp;
begin
  Result := Self;
  FQuery.Executar(FSQL.SqlApagarCheck);
end;

function TModelRnp.RetornaRnp: iModelRnp;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaRnp);
end;

function TModelRnp.RetornaCheck: iModelRnp;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaCheck);
end;

function TModelRnp.RetornaSaldoInicialRnp: Double;
begin
 FQuery.Open(RetornarSQL(4));
 Result := FQuery.FieldByName('VLRRNP').AsFloat;
end;

function TModelRnp.RetornaSaldoInicialSiacon: Double;
begin
  FQuery.Open(RetornarSQL(4));
  Result := FQuery.FieldByName('VLSIACON').AsFloat;
end;

function TModelRnp.RetornaSomenteRnp: iModelRnp;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaSomenteRnp);
end;

function TModelRnp.RetornaComissaoPermanencia(pDataCalculo: TDateTime
  ): iModelRnp;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaComissaoPermanencia(Pdatacalculo));
end;

function TModelRnp.RetornaRnpRateiosFuturos: iModelRnp;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaRnpRateioFuturos);
end;

function TModelRnp.RetornaUmRnp(pGrupo, pSeq, pCota: String): iModelRnp;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaUmRnp(Pgrupo, Pseq, Pcota));
end;

function TModelRnp.RetornaUmCheck(pGrupo, pSeq, pCota: String): iModelRnp;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaUmCheck(Pgrupo, Pseq, Pcota));
end;

function TModelRnp.RetornaRnpGrupo(pGrupo: String): iModelRnp;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaRnpGrupo(Pgrupo));
end;

function TModelRnp.RetornaRecomposicaoSaldosGrupo(pGrupo: String): iModelRnp;
begin
  Result := Self;
  FQuery.Open(Format(FSQL.SqlRetornaRecomposicaoSaldosGrupo,[QuotedStr(Pgrupo)]));
end;

function TModelRnp.RetornaRecomposicaoSaldosTodos: iModelRnp;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaRecomposicaoSaldosTodos);
end;

function TModelRnp.TotalizaRecomposicaoRnp: iModelRnp;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaTotalRecomposicao);
end;

function TModelRnp.SaldoDataBase(pGRupo, pSeq, pCota: String;
  pDataLimite: TDateTime): Currency;
begin
  Result := TControllerFactory.New.TabularEncerrados.DATALIMITE(Pdatalimite).CalcularSaldoRnpCota(Pgrupo, Pseq, Pcota, nil);
end;

function TModelRnp.SaldoRnp31Dez21(pGRupo, pSeq, pCota: String): Currency;
var
  vSaldo: Currency;
begin
  vSaldo := FQuery.Open( Format(FSQL.SqlRetornaSaldoRnp31Dez21,
                                    [ QuotedStr(pGRupo),
                                      QuotedStr(pSeq),
                                      QuotedStr(pCota)]))
                  .FieldByName('OUTROS').AsCurrency;
  Result := vSaldo;
end;

function TModelRnp.Gravar: iModelRnp;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(1));
end;

function TModelRnp.GravarRateioFuturo: iModelRnp;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(2));
end;

function TModelRnp.GravarSaldoRnp: iModelRnp;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(3));
end;

function TModelRnp.GravarSaldoSiaconRnp(pGrupo, pSeq, pCota: String;
  pSiacon: Double): iModelRnp;
var
  vSql: String;
begin
  Result := Self;
  FormatSettings.DecimalSeparator := '.';
  vSql := Format(FSQL.SqlRetornaSaldoInicialRnp, [ QuotedStr(Pgrupo),
                                             QuotedStr(Pseq),
                                             QuotedStr(Pcota)]);
  if FQuery.Open(vSql).Vazio
  then vSql := Format( FSQL.SqlNovoSaldo,  [ QuotedStr(Pgrupo),
                                             QuotedStr(Pseq),
                                             QuotedStr(Pcota), 0.0,
                                             Psiacon])
  else vSql := Format( FSQL.SqlAtualizarSaldoSiacon, [ Psiacon,
                                                  QuotedStr(Pgrupo),
                                                  QuotedStr(Pseq),
                                                  QuotedStr(Pcota)]);
  FormatSettings.DecimalSeparator := ',';
  FQuery.Executar(vSql);
end;

function TModelRnp.CompararSAG: TDataSet;
const
  SQL_SAG =
    'select R.CODSAG, S.DTBASE, R.CODGRUPO, R.CODCOTA, R.SEQCOTA, R.NMCONSORCIADO, '+
           'R.RECNAOPROCURADO '+
    'from RECGRUPOSENC R '+
    'inner join SAG S on S.CODSAG = R.CODSAG '+
    'where R.codsag = (select max(CODSAG) from SAG) and R.RECNAOPROCURADO > 0 '+
    'order by R.CODGRUPO, R.CODCOTA, R.SEQCOTA';
var
  pQuerySAG: iQueryRest;
begin
  CriarFCMP;

  Pquerysag.Open(SQL_SAG);

  while not Pquerysag.Dataset.EOF do
  begin
    IncluirFCMP( Pquerysag.FieldByName('CODGRUPO').AsString,
                 Pquerysag.FieldByName('CODCOTA').AsString,
                 Pquerysag.FieldByName('SEQCOTA').AsString,
                 Pquerysag.FieldByName('NMCONSORCIADO').AsString,
                 Pquerysag.FieldByName('RECNAOPROCURADO').AsFloat, 0.0);
    Pquerysag.Dataset.Next;
  end;

  FQuery.Open(FSQL.SqlRetornaSomenteRnp);

  while not FQuery.Dataset.EOF do
  begin
    if FCMP.Pesquisa('Grupo;Cota;Seq', VarArrayOf([ FQuery.FieldByName('GRUPO').AsString,
                                                    FQuery.FieldByName('COTA').AsString,
                                                    FQuery.FieldByName('SEQ').AsString ]))
    then begin
      FCMP.AlteraRegistro;
      FCMP.CAMPO('VlRnp').VALOR(FQuery.FieldByName('VLRRNP').AsFloat).AtribuirValor;
      FCMP.CAMPO('VlDif').VALOR(FCMP.DataSet.FieldByName('VlSag').AsFloat - FQuery.FieldByName('VLRRNP').AsFloat).AtribuirValor;
      FCMP.GravarRegistro;
    end
    else IncluirFCMP( FQuery.FieldByName('GRUPO').AsString,
                      FQuery.FieldByName('COTA').AsString,
                      FQuery.FieldByName('SEQ').AsString,
                      FQuery.FieldByName('NOME').AsString, 0.00,
                      FQuery.FieldByName('VLRRNP').AsFloat );
    FQuery.Dataset.Next;
  end;
  FCMP.PrimeiroRegistro;
  Result := FCMP.DataSet;
end;

function TModelRnp.CompararSAG(pArquivoSag: TStringList): TDataSet;
var
  vLin: Integer;
  vVlRnp: Double;
  vGrupo, vSeq, vCota, vNome, vTag, vLinha: String;

  function PegarString(pTag, pLin: string): string;
  var
    I, Fim: Integer;
    Cpo: string;
  begin
    Cpo := '';
    Fim := Length(pLin);
    I := Pos(pTag,pLin)+Length(pTag);
    while I < Fim do begin
      if pLin[I]='"' then begin
        Inc(I);
        while pLin[I]<>'"' do begin
          Cpo := Cpo + pLin[I];
          Inc(I);
        end;
        Break;
      end;
      Inc(I);
    end;
    Result := Cpo;

  end;
  function PegarTag(pLin: String): string;
var
   Tag: string;
   I: Integer;
begin
  Tag := '';
  I := Pos('<',pLin)+1;
  while not (pLin[I]='>') do begin
    Tag := Tag + pLin[I];
    Inc(I);
  end;
  Result := Tag;
end;
  function PegarVlrTag(pTag, pLin: string): string;
  var
    I, Fim: Integer;
    Cpo: string;
  begin
    I := Pos(pTag,pLin)+Length(pTag);
    Fim := Length(pLin);
    Cpo := '';
    while I < Fim do begin
      if pLin[I]='>' then begin
         Inc(I);
         while not (pLin[I]='<') do begin
             Cpo := Cpo + pLin[I];
             Inc(I);
         end;
         Break;
      end;
      Inc(I);
    end;
    Result := Cpo;
  end;

begin

  CriarFCMP;

  FormatSettings.DecimalSeparator := '.';

  vLin := 2;

  while Pos('</Doc2080>',Parquivosag[vLin]) = 0 do
  begin

    if Pos('<recGruposEnc>', Parquivosag[vLin]) = 1 then
    begin

      Inc(vLin);


      while Pos('</recGruposEnc>',Parquivosag[vLin]) = 0 do
      begin
        vTag := PegarTag(Parquivosag[vLin]);
        if vTag = 'codGrupo'
        then vGrupo := PegarVlrTag(vTag, Parquivosag[vLin])
        else if vTag = 'codCota'
        then vCota := PegarVlrTag(vTag, Parquivosag[vLin])
        else if vTag = 'seqCota'
        then vSeq := PegarVlrTag(vTag, Parquivosag[vLin])
        else if vTag = 'nmConsorciado'
        then vNome := PegarVlrTag(vTag, Parquivosag[vLin])
        else if vTag = 'recNaoProcurado'
        then vVlRnp := StrToFloatDef(PegarVlrTag(vTag, Parquivosag[vLin]),0);
        Inc(vLin);
      end;

      if vVlRnp > 0
      then  IncluirFCMP( vGrupo,
                         vCota,
                         vSeq,
                         vNome,
                         vVlRnp, 0.0);
    end;
    Inc(vLin);
  end;

  FormatSettings.DecimalSeparator := ',';

  vLin := FCMP.DataSet.RecordCount;

  FQuery.Open(FSQL.SqlRetornaSomenteRnp);

  while not FQuery.Dataset.EOF do
  begin
    if FCMP.Pesquisa('Grupo;Cota;Seq', VarArrayOf([ FQuery.FieldByName('GRUPO').AsString,
                                                    FQuery.FieldByName('COTA').AsString,
                                                    FQuery.FieldByName('SEQ').AsString ]))
    then begin
      FCMP.AlteraRegistro;
      FCMP.CAMPO('VlRnp').VALOR(FQuery.FieldByName('VLRRNP').AsFloat).AtribuirValor;
      FCMP.CAMPO('VlDif').VALOR(FCMP.DataSet.FieldByName('VlSag').AsFloat - FQuery.FieldByName('VLRRNP').AsFloat).AtribuirValor;
      FCMP.GravarRegistro;
    end
    else IncluirFCMP( FQuery.FieldByName('GRUPO').AsString,
                      FQuery.FieldByName('COTA').AsString,
                      FQuery.FieldByName('SEQ').AsString,
                      FQuery.FieldByName('NOME').AsString, 0.00,
                      FQuery.FieldByName('VLRRNP').AsFloat );
    FQuery.Dataset.Next;
  end;
  FCMP.PrimeiroRegistro;
  Result := FCMP.DataSet;
end;

function TModelRnp.RnpSag: TDataSet;
var
  vDataset: TDataSet;
begin
  vDataset :=  FQuery.Open(FSQL.SqlRnpSag).Dataset;
  FormataCampoData(vDataset.FindField('DTENCCT'),'EncGru',8,taCenter);
  FormataCampoData(vDataset.FindField('DTULTASS'),'Ult.Ass',8,taCenter);
  Result := vDataset;
end;

function TModelRnp.DataSet: TDataSet;
var
  vDataset: TDataSet;
begin
  vDataset :=  FQuery.Dataset;
  FormataCampoTexto(vDataset.FindField('GRUPO'), 'Grupo', 4, taCenter);
  FormataCampoTexto(vDataset.FindField('SEQ'), 'Seq', 2, taCenter);
  FormataCampoTexto(vDataset.FindField('COTA'), 'Cota', 3, taCenter);
  FormataCampoTexto(vDataset.FindField('NOME'), 'Nome', 30, taLeftJustify);
  FormataCampoTexto(vDataset.FindField('SIT_COBR'), 'Sit', 2, taCenter);
  FormataCampoNumerico(vDataset.FindField('PERCAMORT'),'% Pago',6, taCenter,',#0.0000');
  FormataCampoNumerico(vDataset.FindField('VLRRNP'),'Vlr RNP',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('VLRBEM'),'Vlr Bem',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('RATFUT'),'Rateio Fut.',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('PCRATEIO'),'% Rateio',8, taCenter, ',#0.000000');
  FormataCampoNumerico(vDataset.FindField('VLSIACON'),'Vlr.Siacon',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('DIFSAL'),'Difer.',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('QTDCOT'),'Cotas',5, taRightJustify,'0000');
  FormataCampoNumerico(vDataset.FindField('RECGRU'),'Recomp.',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('SIAGRU'),'Siacon',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('DIFER'),'Difer.',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('Sld23Abr13Rel'),'Rec Rel',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('Sld23Abr13Pla'),'Rec Pla',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('Sld26Set16Rel'),'Com Rel',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('Sld26Set16Pla'),'Com Pla',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('REL'),'Rel',2, taCenter,'0');
  FormataCampoNumerico(vDataset.FindField('PLA'),'Pla',2, taCenter,'0');
  FormataCampoData(vDataset.FindField('PRIM_REU'),'Prim.Reu',8,taCenter);
  Result := vDataset;
end;

function TModelRnp.TemDados: Boolean;
begin
  Result := not FQuery.Dataset.EOF;
end;

function TModelRnp.Proximo: Boolean;
begin
  FQuery.Dataset.Next;
  Result := Self.TemDados;
end;

function TModelRnp.GRUPO(aValue: String): iModelRnp;
begin
  Result := Self;
  FGrupo := Avalue;
end;

function TModelRnp.SEQ(aValue: String): iModelRnp;
begin
  Result := Self;
  FSeq := Avalue;
end;

function TModelRnp.COTA(aValue: String): iModelRnp;
begin
  Result := Self;
  FCota := Avalue;
end;

function TModelRnp.PERCAMORT(aValue: Double): iModelRnp;
begin
  Result := Self;
  FPercAmort := Avalue;
end;

function TModelRnp.VLRRNP(aValue: Double): iModelRnp;
begin
  Result := Self;
  FVlrRnp := Avalue;
end;

function TModelRnp.VLRRNP: Double;
begin
  Result := FQuery.FieldByName('VLRRNP').AsFloat;
end;

function TModelRnp.VLRBEM(aValue: Double): iModelRnp;
begin
  Result := Self;
  FVlrBem := Avalue;
end;

function TModelRnp.RATFUT(aValue: Double): iModelRnp;
begin
  Result := Self;
  FRatFut := Avalue;
end;

function TModelRnp.PCRATEIO(aValue: Double): iModelRnp;
begin
  Result := Self;
  FPcRateio := Avalue;
end;

function TModelRnp.GRUPO: String;
begin
  Result := FQuery.FieldByName('GRUPO').AsString;
end;

function TModelRnp.SEQ: String;
begin
  Result := FQuery.FieldByName('SEQ').AsString;
end;

function TModelRnp.COTA: String;
begin
  Result := FQuery.FieldByName('COTA').AsString;
end;

function TModelRnp.FATOR: double;
begin
  Result := FQuery.FieldByName('VLRBEM').AsFloat *
            FQuery.FieldByName('PERCAMORT').AsFloat;
end;

function TModelRnp.TXPER: double;
begin
  Result := FQuery.FieldByName('ADM_PERM').AsFloat;
end;

function TModelRnp.VLMIN: double;
begin
  Result := FQuery.FieldByName('VAL_MINIMO').AsFloat;
end;

function TModelRnp.NOME: String;
begin
  Result := FQuery.FieldByName('NOME').AsString;
end;

end.



