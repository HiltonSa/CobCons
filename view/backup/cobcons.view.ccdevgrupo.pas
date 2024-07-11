unit cobcons.view.ccdevgrupo;

{$mode delphi}

interface

uses
  Classes, Windows, Sysutils, DB, DateUtils, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, ActnList, Buttons, StdCtrls, DBGrids, DBCtrls, fpspreadsheet,
  fpsallformats, fpsTypes, DateTimePicker, cobcons.controller.interfaces,
  cobcons.view.rel.recomposicaosaldosrnp;

type

  { TFrmCcDevGrupo }

  TFrmCcDevGrupo = class(Tform)
    Btnpesq1: Tspeedbutton;
    InfoLabel2: Tlabel;
    plan: Taction;
    Al: Tactionlist;
    Btnpesq: Tspeedbutton;
    Btnsair: Tspeedbutton;
    cboGrupo: Tcombobox;
    dtBase: Tdatetimepicker;
    Imprimir: Taction;
    Label1: Tlabel;
    Label2: Tlabel;
    Pnacoes: Tpanel;
    Pnbackground: Tpanel;
    Pntitulo: Tpanel;
    Sair: Taction;
    procedure Cbogrupoexit(Sender: Tobject);
    procedure Formclose(Sender: Tobject; var Closeaction: Tcloseaction);
    procedure Formcreate(Sender: Tobject);
    procedure Formkeydown(Sender: Tobject; var Key: Word; Shift: Tshiftstate);
    procedure Imprimirexecute(Sender: Tobject);
    procedure Planexecute(Sender: Tobject);

      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
      procedure Sairexecute(Sender: Tobject);
  Private
    FCotas: iControllerRnp;
    FHeaderTemplateCell: PCell;
    FDateTemplateCell: PCell;
    FDSCotas,
    FDSMovtos: TDataSet;
    FFicha: iControllerFichaPagamentos;
    procedure CarregarCboGrupo;
    procedure WriteCellDataHandler(Sender: TsWorksheet; ARow, ACol: Cardinal;
      var AValue: variant; var AStyleCell: PCell);
    procedure WriteCellDataHandler2(Sender: TsWorksheet; ARow, ACol: Cardinal;
      var AValue: variant; var AStyleCell: PCell);
  Public

  end;

var
  FrmCcDevGrupo: TFrmCcDevGrupo;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.rel.recomposicaosaldosrnpcotas;

{$R *.lfm}

{ TFrmCcDevGrupo }

procedure Tfrmccdevgrupo.Formclose(Sender: Tobject;
  var Closeaction: Tcloseaction);
begin
  Closeaction := caFree;
  self := nil;
End;

procedure Tfrmccdevgrupo.Cbogrupoexit(Sender: Tobject);
begin
  FCotas.RetornaRnpGrupo(cboGrupo.Text);
End;

procedure Tfrmccdevgrupo.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnBackGround.Color := vEsquema.CorFundo;
  CarregarCboGrupo;
  dtBase.Date := EndOfTheMonth(StartOfTheMonth(Date)-1);
  FCotas := TControllerFactory.New.RNP;
  FFicha := TControllerFactory.New.FichaPagamentos;
End;

procedure Tfrmccdevgrupo.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_RETURN: SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
End;

procedure Tfrmccdevgrupo.Imprimirexecute(Sender: Tobject);
begin
  FrmRelRecomposicaoRnpCotas := TFrmRelRecomposicaoRnpCotas.Create(Nil);
  try
    FrmRelRecomposicaoRnpCotas.DataLimite := dtBase.Date;
    FrmRelRecomposicaoRnpCotas.Ds.DataSet := FCotas.Dataset;
    FrmRelRecomposicaoRnpCotas.Dsprs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
    FrmRelRecomposicaoRnpCotas.Rl.Title := 'RECOMPOSIÇÃO DE SALDOS RNP DATA BASE '+DateToStr(dtBase.Date);
    FrmRelRecomposicaoRnpCotas.Rl.PreviewModal;
  finally
    FrmRelRecomposicaoRnpCotas.Free;
  end;
End;

procedure Tfrmccdevgrupo.Planexecute(Sender: Tobject);
const
  COLUNAS = 3;
var
  vWorkBook: TsWorkbook;
  vWSCotas: TsWorksheet;
  vLin, vCol, vIni, vFim :Integer;
begin
  FDSCotas := FCotas.Dataset;

  vWorkBook := TsWorkbook.Create;
  try
    //vWorkBook.FormatSettings.ThousandSeparator := '.';
    //vWorkBook.FormatSettings.DecimalSeparator := ',';
    vWSCotas := vWorkBook.AddWorksheet('Cotas');
    //vWsMovtos := vWorkBook.AddWorksheet('ContaCorrente');
    vLin := 0;

    while not FDSCotas.EOF do
    begin

      if FDSCotas.FieldByName('VLRRNP').AsFloat > 0
      then begin
        vWSCotas.WriteFontStyle(vLin, 0, [fssBold]);
        vWSCotas.WriteFontStyle(vLin, 1, [fssBold]);
        vWSCotas.WriteText(vLin, 0, Format('COTA: %s/%s.%s',[ FDSCotas.FieldByName('GRUPO').AsString,
                                                              FDSCotas.FieldByName('SEQ').AsString,
                                                              FDSCotas.FieldByName('COTA').AsString]));
        vWSCotas.WriteText(vLin, 1, 'NOME: '+FDSCotas.FieldByName('NOME').AsString);
        Inc(vLin);

        FDSMovtos := FFicha.GRUPO(FDSCotas.FieldByName('GRUPO').AsString)
                           .SEQ(FDSCotas.FieldByName('SEQ').AsString)
                           .COTA(FDSCotas.FieldByName('COTA').AsString)
                           .DATALIMITE(dtBase.Date)
                           .ContaCorrenteDevolucoes;

        if not FDSMovtos.EOF
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
          vFim := Trunc( FDSMovtos.RecordCount / COLUNAS ) + vLin + 1;
          vIni := vLin;
          vCol := 0;
          while not FDSMovtos.EOF do
          begin
            vWSCotas.WriteDateTime(vLin, vCol, FDSMovtos.FieldByName('DtCtb').AsDateTime, 'dd/mm/yyyy');
            vWSCotas.WriteText(vLin, vCol+1, FDSMovtos.FieldByName('Tipo').AsString);
            vWSCotas.WriteNumber(vLin, vCol+2, FDSMovtos.FieldByName('Valor').AsFloat, nfCustom, '##,##0.00');
            vWSCotas.WriteNumber(vLin, vCol+3, FDSMovtos.FieldByName('Saldo').AsFloat, nfCustom, '##,##0.00');
            Inc(vLin);
            if vLin >= vFim
            then begin
              vLin := vIni;
              Inc(vCol,5);
            end;

            if vLin mod 100 = 0 then
            begin
              InfoLabel2.Caption := Format('Gerando Planilha... escrevendo linha %d...', [vLin]);
              Application.ProcessMessages;
            end;

            FDSMovtos.Next;

          end;
          vLin := vFim + 1;
        end;
        Inc(vLin);
      end;
      FDSCotas.Next;
    end;

    //FHeaderTemplateCell := vWSCotas.GetCell(0, 0);
    //vWSCotas.WriteFontStyle(FHeaderTemplateCell, [fssBold]);
    //vWSCotas.WriteBackgroundColor(FHeaderTemplateCell, scGray);
    //vWSCotas.WriteFontColor(FHeaderTemplateCell, scWhite);  // Does not look nice in the limited Excel2 format
    //
    //vWsMovtos.WriteFontStyle(FHeaderTemplateCell, [fssBold]);
    //vWsMovtos.WriteBackgroundColor(FHeaderTemplateCell, scGray);
    //vWsMovtos.WriteFontColor(FHeaderTemplateCell, scWhite);  // Does not look nice in the limited Excel2 format
    //// Use cell B1 as format template of date column
    //FDateTemplateCell := vWSCotas.GetCell(0, 1);
    //vWSCotas.WriteDateTimeFormat(FDateTemplateCell, nfShortDate);
    //vWsMovtos.WriteDateTimeFormat(FDateTemplateCell, nfShortDate);
    //
    //vWorkBook.Options := vWorkBook.Options + [boVirtualMode];
    //vWSCotas.OnWriteCellData := WriteCellDataHandler;
    //vWsMovtos.OnWriteCellData := WriteCellDataHandler2;
    //
    //vWSCotas.VirtualRowCount := FDSCotas.RecordCount + 1;  // +1 for the header line
    //vWSCotas.VirtualColCount := FDSCotas.FieldCount;
    //
    //vWsMovtos.VirtualRowCount := FDSMovtos.RecordCount + 1;  // +1 for the header line
    //vWsMovtos.VirtualColCount := FDSMovtos.FieldCount;

    vWorkBook.WriteToFile(Format('Grupo%s.xlsx',[cboGrupo.Text]), sfOOXML, true);
    MostraAviso('Arquivo Gerado.');
  finally
    vWorkBook.Free;
  end;

End;

procedure Tfrmccdevgrupo.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmccdevgrupo.Sairexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
End;

procedure Tfrmccdevgrupo.Carregarcbogrupo;
var
  vGrupo: TDataSet;
begin
  cboGrupo.Clear;
  vGrupo := TControllerFactory.New.Grupo.RetornaListaGrupos.Dataset;
  while not vGrupo.EOF do
  begin
    cboGrupo.Items.Add(vGrupo.FieldByName('GRUPO').AsString);
    vGrupo.Next;
  end;
  cboGrupo.ItemIndex := 0;
end;

procedure Tfrmccdevgrupo.Writecelldatahandler(Sender: Tsworksheet; Arow, Acol: Cardinal;
  var Avalue: Variant; var Astylecell: Pcell);
var
  vDataSet: TDataSet;
begin
  // Header line: we want to show the field names here.
  vDataSet := FDSCotas;

  if ARow = 0 then
  begin
    AValue := vDataSet.Fields[ACol].FieldName;
    AStyleCell := FHeaderTemplateCell;
    vDataSet.First;
  end
  else
  // After the header line we write the record data. Note that we are
  // responsible for advancing the dataset cursor whenever a row is complete.
  begin
    AValue := vDataSet.Fields[ACol].Value;
    if vDataSet.Fields[ACol].DataType = ftDateTime then
      AStyleCell := FDateTemplateCell;
    if ACol = Sender.VirtualColCount-1 then
    begin
      // Move to next record after last field has been written
      vDataSet.Next;
      // Progress display
      if (ARow-1) mod 1000 = 0 then
      begin
        InfoLabel2.Caption := Format('Writing record %d to spreadsheet...', [ARow-1]);
        Application.ProcessMessages;
      end;
    end;
  end;
end;

procedure Tfrmccdevgrupo.Writecelldatahandler2(Sender: Tsworksheet; Arow, Acol: Cardinal;
  var Avalue: Variant; var Astylecell: Pcell);
var
  vDataSet: TDataSet;
begin
  // Header line: we want to show the field names here.
  vDataSet := FDSMovtos;

  if ARow = 0 then
  begin
    AValue := vDataSet.Fields[ACol].FieldName;
    AStyleCell := FHeaderTemplateCell;
    vDataSet.First;
  end
  else
  // After the header line we write the record data. Note that we are
  // responsible for advancing the dataset cursor whenever a row is complete.
  begin
    AValue := vDataSet.Fields[ACol].Value;
    if vDataSet.Fields[ACol].DataType = ftDateTime then
      AStyleCell := FDateTemplateCell;
    if ACol = Sender.VirtualColCount-1 then
    begin
      // Move to next record after last field has been written
      vDataSet.Next;
      // Progress display
      if (ARow-1) mod 1000 = 0 then
      begin
        InfoLabel2.Caption := Format('Writing record %d to spreadsheet...', [ARow-1]);
        Application.ProcessMessages;
      end;
    end;
  end;
end;

end.

