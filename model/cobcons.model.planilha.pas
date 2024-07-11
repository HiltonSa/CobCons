unit cobcons.model.planilha;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, DB, DateUtils, fpsTypes,
  fpsallformats, fpspreadsheet, xlsxooxml, fpsexport;

type

  { iModelPlanilha }

  iModelPlanilha = interface
    ['{609C664B-BDCE-48E1-A234-97A5708A5DC2}']
    function Arquivo(avalue: string): iModelPlanilha;
    function Abrir: iModelPlanilha;
    function ArquivoValido(aValue: String): Boolean;
    function ListaPlanilhas: TStringList;
    function AbrirPlanilha(avalue: string): iModelPlanilha;
    function ListaColuna(avalue: Integer): TStringList;
    function RetornarColuna(pColuna: Integer; var pLista: TStringList): iModelPlanilha;
    function RetornarLinha(pLinha: Integer; var pLista: TStringList): iModelPlanilha;
    function GerarPlanilha(pDataset: TDataset; pNomePlanilha: String): iModelPlanilha;
    function GerarplanilhPagarRnp(Pdataset: Tdataset; Pnomeplanilha: String; Pdtbase: Tdatetime): Imodelplanilha;
    function Gerarplanilhaccdev(Pdataset: Tdataset; Pnomeplanilha: String; Pdtbase: Tdatetime; Pcheck: Icontrollerrnp): Imodelplanilha;
    function NumeroColunas: Integer;
    function NumeroLinhas: Integer;
  end;

   { TPlanilha }

   TPlanilha = class (TInterfacedObject, iModelPlanilha)
     private
      Farquivo: string;
      FWorkBook: TsWorkbook;
      FLista: TStringList;
      FWorkSheet: TsWorksheet;
      FExport: TFPSExport;
     public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelPlanilha;
       function Arquivo(avalue: string): iModelPlanilha;
     function Abrir: iModelPlanilha;
     function ArquivoValido(aValue: String): Boolean;
     function ListaPlanilhas: TStringList;
     function AbrirPlanilha(avalue: string): iModelPlanilha;
     function GerarPlanilha(pDataset: TDataset; pNomePlanilha: String): iModelPlanilha;
     function Gerarplanilhaccdev(Pdataset: Tdataset; Pnomeplanilha: String; Pdtbase: Tdatetime; Pcheck: Icontrollerrnp): Imodelplanilha;
     function GerarplanilhPagarRnp(Pdataset: Tdataset; Pnomeplanilha: String; Pdtbase: Tdatetime): Imodelplanilha;
     function ListaColuna(avalue: Integer): TStringList;
     function RetornarColuna(pColuna: Integer; var pLista: TStringList): iModelPlanilha;
     function RetornarLinha(pLinha: Integer; var pLista: TStringList): iModelPlanilha;
     function NumeroColunas: Integer;
     function NumeroLinhas: Integer;

   end;

implementation

uses cobcons.controller.factory;

{ TPlanilha }

constructor Tplanilha.Create;
begin
  FWorkBook := TsWorkbook.Create;
  FLista := TStringList.Create;
end;

destructor Tplanilha.Destroy;
begin
  FWorkBook.Free;
  FLista.Free;
  inherited Destroy;
end;

class function Tplanilha.New: Imodelplanilha;
begin
  Result := Self.Create;
end;

function Tplanilha.Arquivo(Avalue: String): Imodelplanilha;
begin
  Farquivo := Avalue;
  Result := Self;
end;

function Tplanilha.Abrir: Imodelplanilha;
begin
  FWorkBook.Options := FWorkBook.Options + [boReadFormulas];
  FWorkBook.ReadFromFile(Farquivo);
  Result := Self;
end;

function Tplanilha.Arquivovalido(Avalue: String): Boolean;
begin
  Farquivo := Avalue;
  FWorkBook.ReadFromFile(Farquivo);
  Result := Length(Trim(FWorkBook.ErrorMsg)) = 0;
end;

function Tplanilha.Listaplanilhas: Tstringlist;
var
  I: Integer;
begin
  FLista.Clear;
  for I := 0 to Pred(FWorkBook.GetWorksheetCount) do
  begin
    FLista.Add(FWorkBook.GetWorksheetByIndex(I).Name);
  end;
  Result := FLista;
end;

function Tplanilha.Abrirplanilha(Avalue: String): Imodelplanilha;
begin
  Result := Self;
  FWorkSheet := FWorkBook.GetWorksheetByName(Avalue);
end;

function Tplanilha.Gerarplanilha(Pdataset: Tdataset; Pnomeplanilha: String): Imodelplanilha;
var
 vExport: TFPSExport;
begin
  Result := Self;
  Pdataset.First;
  vExport := TFPSExport.Create(nil);
  try
    with vExport do
    begin
      FileName := pNomePlanilha;
      Dataset := pDataset;
      //ExportFields := <>;
      FormatSettings.IntegerFormat := '%d';
      FormatSettings.DecimalSeparator := ',';
      FormatSettings.CurrencySymbol := 'R$';
      FormatSettings.CurrencyDigits := 0;
      FormatSettings.BooleanTrue := 'True';
      FormatSettings.BooleanFalse := 'False';
      FormatSettings.DateFormat := 'dd/MM/yyyy';
      FormatSettings.TimeFormat := 'hh:nn';
      FormatSettings.DateTimeFormat := 'dd/MM/yyyy hh:nn';
      FormatSettings.ExportFormat := efXLS;
      FormatSettings.HeaderRow := True;
      FormatSettings.SheetName := 'Plan';
      Execute;
      pDataSet.First;
    end;
  finally
    vExport.Free;
  end;
end;

function Tplanilha.Gerarplanilhaccdev(Pdataset: Tdataset; Pnomeplanilha: String; Pdtbase: Tdatetime; Pcheck: Icontrollerrnp): Imodelplanilha;
const
  SLDREC = '23/04/2013';
  SLDCOM = '26/09/2016';
  COLUNAS = 3;
  GRUPO130 = '0130';
var
 vDsMovtos: TDataSet;
 vFicha: iControllerFichaPagamentos;
  vWSCotas: TsWorksheet;
  vLin, vCol, vIni, vFim :Integer;
  vGrupo, vSeq, vCota: String;
  vRecPla, vComPla: Double;
begin
  vFicha := TControllerFactory.New.FichaPagamentos;

  while not Pdataset.EOF do
  begin

    FWorkBook.Clear;

    vWSCotas := FWorkBook.AddWorksheet('Cotas');

    vLin := 0;
    vGrupo := Pdataset.FieldByName('GRUPO').AsString;

    while (vGrupo<>GRUPO130) and (not Pdataset.EOF) do
    begin
      Pdataset.Next;
      vGrupo := Pdataset.FieldByName('GRUPO').AsString;
    end;

    while (vGrupo = Pdataset.FieldByName('GRUPO').AsString) and (not Pdataset.EOF) do
    begin

      if Pdataset.FieldByName('VLRRNP').AsFloat > 0
      then begin

        vSeq := Pdataset.FieldByName('SEQ').AsString;
        vCota := Pdataset.FieldByName('COTA').AsString;
        vWSCotas.WriteFontStyle(vLin, 0, [fssBold]);
        vWSCotas.WriteFontStyle(vLin, 1, [fssBold]);
        vWSCotas.WriteText(vLin, 0, Format('COTA: %s/%s.%s',[ vGrupo, vSeq, vCota ]));
        vWSCotas.WriteText(vLin, 1, 'NOME: '+Pdataset.FieldByName('NOME').AsString);
        Inc(vLin);

        vDsMovtos := vFicha.GRUPO(vGrupo)
                           .SEQ(vSeq)
                           .COTA(vCota)
                           .DATALIMITE(pDtBase)
                           .ContaCorrenteDevolucoes;

        vRecPla := 0;
        vComPla := 0;

        if not vDsMovtos.EOF
        then begin
          vCol := 0;
          while vCol <= 10 do
          begin
            vWSCotas.WriteFontStyle(vLin, vCol, [fssBold]);
            vWSCotas.WriteFontStyle(vLin, vCol+1, [fssBold]);
            vWSCotas.WriteFontStyle(vLin, vCol+2, [fssBold]);
            vWSCotas.WriteFontStyle(vLin, vCol+3, [fssBold]);
            vWSCotas.WriteText(vLin, vCol, 'DATA');
            vWSCotas.WriteText(vLin, vCol+1, 'DESCRIÇÃO');
            vWSCotas.WriteText(vLin, vCol+2, 'VALOR');
            vWSCotas.WriteText(vLin, vCol+3, 'SALDO');
            Inc(vCol, 5);
          end;
          Inc(vLin);
          vFim := Trunc( vDsMovtos.RecordCount / COLUNAS ) + vLin + 1;
          vIni := vLin;
          vCol := 0;
          while not vDsMovtos.EOF do
          begin
            vWSCotas.WriteDateTime(vLin, vCol, vDsMovtos.FieldByName('DtCtb').AsDateTime, 'dd/mm/yyyy');
            vWSCotas.WriteText(vLin, vCol+1, vDsMovtos.FieldByName('Tipo').AsString);
            vWSCotas.WriteNumber(vLin, vCol+2, vDsMovtos.FieldByName('Valor').AsFloat, nfCustom, '##,##0.00');
            vWSCotas.WriteNumber(vLin, vCol+3, vDsMovtos.FieldByName('Saldo').AsFloat, nfCustom, '##,##0.00');
            Inc(vLin);
            if vLin >= vFim
            then begin
              vLin := vIni;
              Inc(vCol,5);
            end;
            if StartOfTheDay(vDsMovtos.FieldByName('DtCtb').AsDateTime) = StartOfTheDay(StrToDate(SLDREC))
            then if vDsMovtos.FieldByName('Tipo').AsString = 'CORREÇÃO'
            then vRecPla := vDsMovtos.FieldByName('Saldo').AsFloat;
            if StartOfTheDay(vDsMovtos.FieldByName('DtCtb').AsDateTime) = StartOfTheDay(StrToDate(SLDCOM))
            then if vDsMovtos.FieldByName('Tipo').AsString = 'CORREÇÃO'
            then vComPla := vDsMovtos.FieldByName('Saldo').AsFloat;

            vDsMovtos.Next;

          end;

          if pCheck.RetornaUmCheck(vGrupo, vSeq, vCota).DataSet.EOF
          then pCheck.NovoCheck(vGrupo, vSeq, vCota, 0, 1, 0, vRecPla, 0, vComPla)
          else pCheck.GravarCheck(vGrupo, vSeq, vCota, 0, 1, 0, vRecPla, 0, vComPla);

          vLin := vFim + 1;
        end;
        Inc(vLin);

      end;
      Pdataset.Next;

    end;

    if vGrupo = GRUPO130
    then begin
      FWorkBook.WriteToFile(Format(Pnomeplanilha,[vGrupo]), sfOOXML, true);
      Pdataset.Last;
    end;


  end;

  Result := Self;

end;

function Tplanilha.Gerarplanilhpagarrnp(Pdataset: Tdataset; Pnomeplanilha: String; Pdtbase: Tdatetime): Imodelplanilha;
var
 vTab: iControllerTabularEncerrados;
  vWSCotas: TsWorksheet;
  vLin:Integer;
  vGrupo, vSeq, vCota: String;
  vRnp: Currency;
begin
  vTab := TControllerFactory.New.TabularEncerrados;
  vTab.DATALIMITE(Pdtbase);

  FWorkBook.Clear;

  vWSCotas := FWorkBook.AddWorksheet('Cotas');
  vWSCotas.WriteFontStyle(0, 0, [fssBold]);
  vWSCotas.WriteFontStyle(0, 1, [fssBold]);
  vWSCotas.WriteFontStyle(0, 2, [fssBold]);
  vWSCotas.WriteFontStyle(0, 3, [fssBold]);
  vWSCotas.WriteFontStyle(0, 4, [fssBold]);
  vWSCotas.WriteFontStyle(0, 5, [fssBold]);

  vWSCotas.WriteText(0, 0, 'GRUPO');
  vWSCotas.WriteText(0, 1, 'SEQ');
  vWSCotas.WriteText(0, 2, 'COTA');
  vWSCotas.WriteText(0, 3, 'NOME');
  vWSCotas.WriteText(0, 4, 'PESSOA');
  vWSCotas.WriteText(0, 5, 'CPF/CNPJ');
  vWSCotas.WriteText(0, 6, 'VALOR');

  vLin := 1;

  while (not Pdataset.EOF) do
  begin
    vGrupo := Pdataset.FieldByName('GRUPO').AsString;
    vSeq := Pdataset.FieldByName('SEQ').AsString;
    vCota := Pdataset.FieldByName('COTA').AsString;

    vRnp := vTab.CalcularSaldoRnpCota(vGrupo,vSeq, vCota, nil);

    if (vRnp > 0) and (Length(Trim(Pdataset.FieldByName('EMAIL').AsString))=0)
    then begin

      vWSCotas.WriteText(vLin, 0, vGrupo);
      vWSCotas.WriteText(vLin, 1, vSeq);
      vWSCotas.WriteText(vLin, 2, vCota);
      vWSCotas.WriteText(vLin, 3, Pdataset.FieldByName('NOME').AsString);
      vWSCotas.WriteText(vLin, 4, Pdataset.FieldByName('PESS_F_J').AsString);
      vWSCotas.WriteText(vLin, 5, Pdataset.FieldByName('CGCCPFMT').AsString);
      vWSCotas.WriteNumber(vLin, 6, vRnp, nfCustom, '##,##0.00');

      Inc(vLin);

    end;

    Pdataset.Next;

  end;

  FWorkBook.WriteToFile(Format(Pnomeplanilha,[vGrupo]), sfOOXML, true);

  Result := Self;

end;

function Tplanilha.Listacoluna(Avalue: Integer): Tstringlist;
var
  cel : PCell;
begin
  FLista.Clear;
  for cel in FWorkSheet.Cells do
  if (cel^.Col = Avalue)
  then FLista.Add(FWorkSheet.ReadAsText(cel));
  Result := FLista;
end;

function Tplanilha.Retornarcoluna(Pcoluna: Integer;
  var Plista: Tstringlist): Imodelplanilha;
var
  cel : PCell;
begin
  pLista.Clear;
  for cel in FWorkSheet.Cells do
  if (cel^.Col = pColuna)
  then pLista.Add(FWorkSheet.ReadAsText(cel));
  Result := Self;
end;

function Tplanilha.Retornarlinha(Plinha: Integer;
  var Plista: Tstringlist): Imodelplanilha;
var
  cel : PCell;
begin
  pLista.Clear;
  for cel in FWorkSheet.Cells do
  if (cel^.Row = Plinha)
  then pLista.Add(FWorkSheet.ReadAsText(cel));
  Result := Self;
end;

function Tplanilha.Numerocolunas: Integer;
begin
  Result := FWorkSheet.Cols.Count;
end;

function Tplanilha.Numerolinhas: Integer;
begin
  Result := FWorkSheet.Rows.Count;
end;

end.

