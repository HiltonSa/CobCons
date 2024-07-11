unit cobcons.model.sag;

{$mode delphi}

interface

uses
  Classes, Sysutils, Math, cobcons.model.interfaces,
  cobcons.controller.interfaces, db, DateUtils;
type

  { TModelSag }

  TModelSag = class(TInterfacedObject, iModelSag)
    private
      FArq : TStringList;
      FCnpjAdm: String;
      FDataBase: TDateTime;
      FRemessa: String;
      FTelContato: String;
      FNomeContato: String;
      FMailContato: String;
      FNomeArquivo: String;
      FLog : TAndamento;

      procedure GravarLinha(pLinha: String);
      procedure AberturaArquivo;
      procedure ConsolidadoBensImoveis;
      procedure ConsolidadoBensMoveis;
      procedure Individualizado;
      procedure RecursosNaoIdentificados;
      procedure RecursosGruposEncerrados;
      procedure InadimplentesGruposEncerrados;
      procedure GravarArquivo;
      procedure Msg(pMsg: String);
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSag;
      function CNPJADM(aValue: String): iModelSag;
      function DATABASE(aValue: TDateTime): iModelSag;
      function REMESSA(aValue: String): iModelSag;
      function TELCONTATO(aValue: String): iModelSag;
      function NOMECONTATO(aValue: String): iModelSag;
      function MAILCONTATO(aValue: String): iModelSag;
      function NOMEARQUIVO(aValue: String): iModelSag;
      function LOG(aValue: TAndamento): iModelSag;
      function GERARSAG: iModelSag;

  end;

implementation

uses cobcons.controller.util, cobcons.controller.factory;

{ TModelSag }

procedure Tmodelsag.Gravarlinha(Plinha: String);
begin
  FArq.Add(Plinha);
end;

procedure Tmodelsag.Aberturaarquivo;
begin
  Msg('Abertura Arquivo.');
  GravarLinha('<?xml version="1.0" encoding="ISO-8859-1" ?>');
  GravarLinha(Format('<Doc2080 cnpjAdm="%s" dataBase="%s" indRemessa="%s" nmContato="%s" telContato="%s" mailContato="%s">',
                  [FCnpjAdm, FormatDateTime('YYYY-MM',FDataBase), FRemessa, FNomeContato, FTelContato, FMailContato]));
  GravarLinha('<consolidado>');
end;

procedure Tmodelsag.Consolidadobensimoveis;
begin
  Msg('Gravando Bens Imóveis.');
   GravarLinha('<bensImoveis>');
   GravarLinha('<codSeg>1</codSeg>');
   GravarLinha('<qtdGrupos>0</qtdGrupos>');
   GravarLinha('<qtdGrpForm>0</qtdGrpForm>');
   GravarLinha('<qtdGrpEnc>0</qtdGrpEnc>');
   GravarLinha('<qtdCotasSubsc>0</qtdCotasSubsc>');
   GravarLinha('<qtdCotasSubscSubst>0</qtdCotasSubscSubst>');
   GravarLinha('<qtdCotasSubscContempAcum>0</qtdCotasSubscContempAcum>');
   GravarLinha('<qtdCotasSubscNaoContemp>0</qtdCotasSubscNaoContemp>');
   GravarLinha('</bensImoveis>');
end;

procedure Tmodelsag.Consolidadobensmoveis;
var
  I: Integer;
begin
  Msg('Gravando Bens móveis.');
  for I := 2 to 6 do
  begin
    GravarLinha('<bensMoveis>');
    GravarLinha(Format('<codSeg>%d</codSeg>',[I]));
    GravarLinha('<tipBem>1</tipBem>');
    GravarLinha('<qtdGrupos>0</qtdGrupos>');
    GravarLinha('<qtdGrpForm>0</qtdGrpForm>');
    GravarLinha('<qtdGrpEnc>0</qtdGrpEnc>');
    GravarLinha('<qtdCotasSubsc>0</qtdCotasSubsc>');
    GravarLinha('<qtdCotasSubscSubst>0</qtdCotasSubscSubst>');
    GravarLinha('<qtdCotasSubscContemp>0</qtdCotasSubscContemp>');
    GravarLinha('<qtdCotasSubscContempAcum>0</qtdCotasSubscContempAcum>');
    GravarLinha('<qtdCotasSubscNaoContemp>0</qtdCotasSubscNaoContemp>');
    GravarLinha('<txAdm>0.00000</txAdm>');
    GravarLinha('<qtdPartAtivosDia>0</qtdPartAtivosDia>');
    GravarLinha('<qtdPartAtivInadContemp>0</qtdPartAtivInadContemp>');
    GravarLinha('<qtdPartAtivInadNaoContemp>0</qtdPartAtivInadNaoContemp>');
    GravarLinha('<qtdPartInativExcl>0</qtdPartInativExcl>');
    GravarLinha('<qtdPartInativQuit>0</qtdPartInativQuit>');
    GravarLinha('<qtdBensPendAquisAdm>0</qtdBensPendAquisAdm>');
    GravarLinha('<qtdBensPendAquisCli>0</qtdBensPendAquisCli>');
    GravarLinha('</bensMoveis>');
  end;
  GravarLinha('</consolidado>');
end;

procedure Tmodelsag.Individualizado;
begin
  Msg('Gravando Individualizado.');
  GravarLinha('<individualizado>');
  RecursosNaoIdentificados;
  RecursosGruposEncerrados;
  InadimplentesGruposEncerrados;
end;

procedure Tmodelsag.Recursosnaoidentificados;
var
  vDataset: TDataSet;
  vDemonstrativo: iControllerDemonstrativo;
begin
  vDemonstrativo := TControllerFactory.New.Demonstrativo;
  vDataset := vDemonstrativo.DATABASE(FDataBase).RetornaDemonstrativoDataBase.DataSet;
  if not vDataset.EOF
  then begin
    GravarLinha('<recNaoIdent>');
    vDataset := vDemonstrativo.GRUPO('0001').DATABASE(FDataBase).DEMONSTRATIVO('4110').RetornaDemonstrativo.DataSet;
    GravarLinha('<B4110>');
    FormatSettings.DecimalSeparator := '.';
    while not vDataset.EOF do
    begin
      GravarLinha(Format('<conta contaCosif="%s" saldoConta="%.2f"/>',
                  [ vDataset.FieldByName('CONTACOSIF').AsString,
                    vDataset.FieldByName('SALDOCONTA').AsFloat]));
      vDataset.Next;
    end;
    GravarLinha('</B4110>');
    FormatSettings.DecimalSeparator := ',';
    vDataset := vDemonstrativo.GRUPO('0001').DATABASE(FDataBase).DEMONSTRATIVO('4350').RetornaDemonstrativo.DataSet;
    GravarLinha('<B4350>');
    FormatSettings.DecimalSeparator := '.';
    while not vDataset.EOF do
    begin
      GravarLinha(Format('<conta contaCosif="%s" vlrPeriodo="%.2f" vlrAcumulado="%.2f"/>',
                  [ vDataset.FieldByName('CONTACOSIF').AsString,
                    vDataset.FieldByName('VLRPERIODO').AsFloat,
                    vDataset.FieldByName('VLRACUMULADO').AsFloat]));
      vDataset.Next;
    end;
    GravarLinha('</B4350>');
    GravarLinha('</recNaoIdent>');
    FormatSettings.DecimalSeparator := ',';
  end;
end;

procedure Tmodelsag.Recursosgruposencerrados;
var
  vRecGruposEnc: iControllerRnp;
  vDataset: TDataSet;
  vSaldo: Currency;
  vGrupo,
  vSeq,
  vCota: String;
begin

  vDataset := vSaldoDataBase.Dataset;

  vRecGruposEnc := TControllerFactory.New.RNP;
  vDataset := vRecGruposEnc.RnpSag;
  vDataset.First;
  while not vDataset.Eof do begin

    vGrupo := vDataset.FieldByName('GRUPO').AsString;
    vSeq := vDataset.FieldByName('SEQ').AsString;
    vCota := vDataset.FieldByName('COTA').AsString;
    vSaldo := vDataset.FieldByName('VLRRNP').AsFloat;
    Msg(Format('Gravando RecGruposEnc: Grupo %s/%s-%s.', [ vGrupo, vCota, vSeq ]));

    //if vGrupo = '0101'
    //then
    //vSaldo := vRecGruposEnc.SaldoDataBase(vGrupo, vSeq, vCota, FDataBase);
    //vSaldo := vDataset.FieldByName('VLRRNP').AsFloat;

    if (vSaldo > 0) or (vDataset.FieldByName('RATFUT').AsFloat>0)
    then begin
      FormatSettings.DecimalSeparator := '.';
      GravarLinha('<recGruposEnc>');
      GravarLinha(Format('<codGrupo>%s</codGrupo>',[vGrupo]));
      GravarLinha(Format('<codCota>%s</codCota>',[vCota]));
      GravarLinha(Format('<seqCota>%s</seqCota>',[vSeq]));
      if vDataset.FieldByName('PESS_F_J').AsString = 'J'
      then GravarLinha(Format('<cotPJ cnpjCotista="%s">1</cotPJ>',
                       [vDataset.FieldByName('CGCCPFMT').AsString]))
      else if vDataset.FieldByName('PESS_F_J').AsString = 'F'
      then GravarLinha(Format('<cotPF cpfCotista="%s">2</cotPF>',
                       [vDataset.FieldByName('CGCCPFMT').AsString]))
      else GravarLinha('<cotInex>3</cotInex>');
      GravarLinha(Format('<nmConsorciado>%s</nmConsorciado>',[ TirarAcento(vDataset.FieldByName('NOME').AsString)]));
      if vSeq = '00'
      then GravarLinha('<stConsorciado>1</stConsorciado>')
      else GravarLinha('<stConsorciado>2</stConsorciado>');
      GravarLinha(Format('<dtEncContabil>%s</dtEncContabil>',[FormatDateTime('YYYY-MM-DD', vDataset.FieldByName('DTENCCT').AsDateTime)]));

      GravarLinha(Format('<regAplic>%s</regAplic>',[vDataset.FieldByName('REGAPLIC').AsString]));
      GravarLinha(Format('<percAmort>%.5f</percAmort>',[vDataset.FieldByName('PERCAMORT').AsFloat]));
      GravarLinha(Format('<vlrBemObjeto>%.2f</vlrBemObjeto>',[vDataset.FieldByName('VLRBEM').AsFloat]));
      GravarLinha(Format('<recNaoProcurado>%.2f</recNaoProcurado>',[vSaldo]));
      GravarLinha(Format('<vlrDevConRatFuturos>%.2f</vlrDevConRatFuturos>',[vDataset.FieldByName('RATFUT').AsFloat]));
      if vDataset.FieldByName('RATFUT').AsFloat > 0
      then GravarLinha(Format('<percRateio>%.5f</percRateio>',[vDataset.FieldByName('PCRATEIO').AsFloat]));
      GravarLinha(Format('<percMultRescGrupo>%.5f</percMultRescGrupo>',[vDataset.FieldByName('MULRESGRU').AsFloat]));
      GravarLinha(Format('<percMultRescAdm>%.5f</percMultRescAdm>',[vDataset.FieldByName('MULRESADM').AsFloat]));
      GravarLinha(Format('<txManut>%.5f</txManut>',[vDataset.FieldByName('TXPER').AsFloat]));
      GravarLinha(Format('<dtUltAssemb>%s</dtUltAssemb>',[FormatDateTime('YYYY-MM-DD', vDataset.FieldByName('DTULTASS').AsDateTime)]));
      GravarLinha('</recGruposEnc>');
      FormatSettings.DecimalSeparator := ',';
    end;
    vDataset.Next;
  end;
end;

procedure Tmodelsag.Inadimplentesgruposencerrados;
var
  vInad: iControllerInadimplente;
  vDataset : TDataSet;
begin
  FormatSettings.DecimalSeparator := '.';
  vInad := TControllerFactory.New.Inadimplente;
  vDataset := vInad.InadimplentesSag;
  vDataset.First;
  while not vDataset.Eof do begin
    Msg(Format('Gravando InadGruposEnc: Grupo %s/%s-%s.',
         [ vDataset.FieldByName('GRUPO').AsString,
           vDataset.FieldByName('COTA').AsString,
           vDataset.FieldByName('SEQ').AsString]));
    GravarLinha('<inadGruposEnc>');
    GravarLinha(Format('<codGrupo>%s</codGrupo>',[vDataset.FieldByName('GRUPO').AsString]));
    GravarLinha(Format('<codCota>%s</codCota>',[vDataset.FieldByName('COTA').AsString]));
    GravarLinha(Format('<seqCota>%s</seqCota>',[vDataset.FieldByName('SEQ').AsString]));
    if vDataset.FieldByName('PESS_F_J').AsString = 'J'
    then GravarLinha(Format('<cotPJ cnpjCotista="%s">1</cotPJ>',
                     [vDataset.FieldByName('CGCCPFMT').AsString]))
    else if vDataset.FieldByName('PESS_F_J').AsString = 'F'
    then GravarLinha(Format('<cotPF cpfCotista="%s">2</cotPF>',
                     [vDataset.FieldByName('CGCCPFMT').AsString]))
    else GravarLinha('<cotInex>3</cotInex>');
    GravarLinha(Format('<nmConsorciado>%s</nmConsorciado>',[ TirarAcento(vDataset.FieldByName('NOME').AsString)]));
    GravarLinha(Format('<dtEncContabil>%s</dtEncContabil>',[FormatDateTime('YYYY-MM-DD', vDataset.FieldByName('DTENCCT').AsDateTime)]));
    GravarLinha(Format('<vlrReceber>%.2f</vlrReceber>',[vDataset.FieldByName('VLRRECEBER').AsFloat]));
    GravarLinha(Format('<percAmort>%.5f</percAmort>',[vDataset.FieldByName('PERCAMORT').AsFloat]));
    GravarLinha(Format('<vlrBemObjeto>%.2f</vlrBemObjeto>',[vDataset.FieldByName('VLRBEM').AsFloat]));
    if not DataEstaVazia(vDataset.FieldByName('DTAJUIZ').AsDateTime)
    then GravarLinha(Format('<dtAjuizAcao>%s</dtAjuizAcao>',[FormatDateTime('YYYY-MM-DD', vDataset.FieldByName('DTAJUIZ').AsDateTime)]));
    GravarLinha('</inadGruposEnc>');
    vDataset.Next;
  end;
  GravarLinha('</individualizado>');
  FormatSettings.DecimalSeparator := ',';
end;

procedure Tmodelsag.Gravararquivo;
begin
  Msg('Gravando arquivo.');
  GravarLinha('</Doc2080>');
  FArq.SaveToFile(FNomeArquivo);
end;

procedure Tmodelsag.Msg(Pmsg: String);
begin
  if Assigned(FLog)
  then FLog(Format('%s: %s',[FormatDateTime('dd/mm/yyyy hh:mm:ss', Now) , Pmsg]));
end;

constructor Tmodelsag.Create;
begin
  FArq := TStringList.Create;
end;

destructor Tmodelsag.Destroy;
begin
  FreeAndNil(FArq);
  inherited Destroy;
end;

class function Tmodelsag.New: Imodelsag;
begin
  Result := Self.Create;
end;

function Tmodelsag.Cnpjadm(Avalue: String): Imodelsag;
begin
  Result := Self;
  FCnpjAdm := Avalue;
end;

function Tmodelsag.Database(Avalue: Tdatetime): Imodelsag;
begin
  Result := Self;
  FDataBase := Avalue;
end;

function Tmodelsag.Remessa(Avalue: String): Imodelsag;
begin
  Result := Self;
  FRemessa := Avalue;
end;

function Tmodelsag.Telcontato(Avalue: String): Imodelsag;
begin
  Result := Self;
  FTelContato := Avalue;
end;

function Tmodelsag.Nomecontato(Avalue: String): Imodelsag;
begin
  Result := Self;
  FNomeContato := Avalue;
end;

function Tmodelsag.Mailcontato(Avalue: String): Imodelsag;
begin
  Result := Self;
  FMailContato := Avalue;
end;

function Tmodelsag.Nomearquivo(Avalue: String): Imodelsag;
begin
  Result := Self;
  FNomeArquivo := Avalue;
end;

function Tmodelsag.Log(Avalue: Tandamento): Imodelsag;
begin
  FLog := Avalue;
  Result := Self;
end;

function Tmodelsag.Gerarsag: Imodelsag;
begin
  Result := Self;
  AberturaArquivo;
  ConsolidadoBensImoveis;
  ConsolidadoBensMoveis;
  if (MonthOf(FDataBase) mod 3) = 0
  then Individualizado;
  GravarArquivo;
end;

end.

