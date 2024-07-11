unit UnCli;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Buttons, ExtCtrls, ComCtrls, StdCtrls, DB, Mask,
  DBCtrls, Grids, DBGrids, StrUtils;

type
  TfrmCli = class(TForm)
    stBar: TStatusBar;
    Panel1: TPanel;
    btnSair: TSpeedButton;
    AL: TActionList;
    Pesquisa: TAction;
    Reu: TAction;
    Pre: TAction;
    Sair: TAction;
    dsCot: TDataSource;
    dsBem: TDataSource;
    Jur: TAction;
    btnPos: TSpeedButton;
    impPos: TAction;
    Panel4: TPanel;
    btPesq: TSpeedButton;
    Com: TAction;
    Ali: TAction;
    dsPag: TDataSource;
    dsCob: TDataSource;
    btnReu: TSpeedButton;
    btnPre: TSpeedButton;
    btnJur: TSpeedButton;
    btnCom: TSpeedButton;
    LisGru: TAction;
    LisCota: TAction;
    dsPre: TDataSource;
    AltEnd: TAction;
    GrvEnd: TAction;
    CanEnd: TAction;
    Cre: TAction;
    dsSeg: TDataSource;
    DevCon: TAction;
    btnDevCon: TSpeedButton;
    IncPend: TAction;
    ExcPend: TAction;
    AltPend: TAction;
    cbPen: TCheckBox;
    IncPag: TAction;
    Panel10: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    spLisGru: TSpeedButton;
    txtGru: TLabeledEdit;
    txtSeq: TLabeledEdit;
    txtCota: TLabeledEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Panel3: TPanel;
    PC: TPageControl;
    tbCont: TTabSheet;
    grbCont: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    spCreditos: TSpeedButton;
    btnAli: TSpeedButton;
    DBEdit27: TDBEdit;
    DBEdit28: TDBEdit;
    DBEdit29: TDBEdit;
    DBEdit30: TDBEdit;
    grBem: TGroupBox;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    DBEdit3: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit10: TDBEdit;
    dbedi: TGroupBox;
    Label22: TLabel;
    Label8: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    Label23: TLabel;
    DBEdit14: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit26: TDBEdit;
    DBEdit15: TDBEdit;
    grCont: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    Label17: TLabel;
    Label16: TLabel;
    Label39: TLabel;
    Label18: TLabel;
    Label27: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit22: TDBEdit;
    DBEdit23: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit37: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit25: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    tbCli: TTabSheet;
    Label19: TLabel;
    Label20: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit38: TDBEdit;
    DBEdit39: TDBEdit;
    DBEdit40: TDBEdit;
    DBEdit41: TDBEdit;
    DBEdit42: TDBEdit;
    panEnd: TPanel;
    Label38: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    EdtFone: TDBEdit;
    EdtEnd: TDBEdit;
    EdtBai: TDBEdit;
    EdtCid: TDBEdit;
    EdtUf: TDBEdit;
    EdtCep: TDBEdit;
    Panel8: TPanel;
    spGrvEnd: TSpeedButton;
    spCanEnd: TSpeedButton;
    spAltEnd: TSpeedButton;
    tbPen: TTabSheet;
    Panel7: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit21: TDBEdit;
    DBEdit31: TDBEdit;
    DBEdit32: TDBEdit;
    grCob: TDBGrid;
    Panel5: TPanel;
    btIncPend: TSpeedButton;
    btExcPend: TSpeedButton;
    SpeedButton2: TSpeedButton;
    nvPen: TDBNavigator;
    tbPag: TTabSheet;
    Panel6: TPanel;
    Label21: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    DBEdit33: TDBEdit;
    DBEdit34: TDBEdit;
    DBEdit35: TDBEdit;
    DBEdit36: TDBEdit;
    DBEdit43: TDBEdit;
    DBGrid2: TDBGrid;
    Panel9: TPanel;
    SpeedButton3: TSpeedButton;
    DBNavigator1: TDBNavigator;
    rbPag: TRadioButton;
    rbFin: TRadioButton;
    rbSemPag: TRadioButton;
    Label49: TLabel;
    DBEdit44: TDBEdit;
    Label50: TLabel;
    DBEdit45: TDBEdit;
    sitCob: TAction;
    SpeedButton4: TSpeedButton;
    excPag: TAction;
    SpeedButton5: TSpeedButton;
    procedure excPagExecute(Sender: TObject);
    procedure sitCobExecute(Sender: TObject);
    procedure impPosExecute(Sender: TObject);
    procedure IncPagExecute(Sender: TObject);
    procedure ExcPendExecute(Sender: TObject);
    procedure AltPendExecute(Sender: TObject);
    procedure IncPendExecute(Sender: TObject);
    procedure DevConExecute(Sender: TObject);
    procedure tbCliExit(Sender: TObject);
    procedure CanEndExecute(Sender: TObject);
    procedure GrvEndExecute(Sender: TObject);
    procedure AltEndExecute(Sender: TObject);
    procedure CreExecute(Sender: TObject);
    procedure txtGruExit(Sender: TObject);
    procedure LisCotaExecute(Sender: TObject);
    procedure LisGruExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtCotaExit(Sender: TObject);
    procedure PesquisaExecute(Sender: TObject);
    procedure ReuExecute(Sender: TObject);
    procedure PreExecute(Sender: TObject);
    procedure dsCotStateChange(Sender: TObject);
    procedure JurExecute(Sender: TObject);
    procedure txtSeqExit(Sender: TObject);
    procedure FechaTabs;
    procedure FormShow(Sender: TObject);
    procedure stBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure ComExecute(Sender: TObject);
    procedure AliExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PosicionaDataset(Gru,Seq,Cot:String);
  end;

var
  frmCli: TfrmCli;

implementation

uses UnDm, DBClient,  UnPesq,  UnReu, UnPre, UnJur, SqlExpr,  UnCom,
  UnAli, UnLista, UnCre, UnDevCon, UnPen, UnMov, RelCli, UnSitCob;

{$R *.dfm}

procedure TfrmCli.SairExecute(Sender: TObject);
begin
     FechaTabs;
     Close;
end;

procedure TfrmCli.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//     if Shift = [ssAlt]
//     then
//         case Key of
//           VK_F2: if btnReu.Enabled then btnReu.Click;
//           VK_F3: if btnPre.Enabled then btnPre.Click;
//           VK_F4: if btnJur.Enabled then btnJur.Click;
//           VK_F7: if btnAli.Enabled then btnAli.Click;
//         end
//     else
         case Key of
          VK_F9: btPesq.Click;
           VK_F12: if btnPos.Enabled then btnPos.Click;
           VK_RETURN: Perform(WM_NEXTDLGCTL, 0, 0);
           VK_ESCAPE: Sair.Execute;
         end;
end;

procedure TfrmCli.impPosExecute(Sender: TObject);
var
  ImpPen, ImpMov, ImpFin: string;
begin

  if rbPag.Checked
  then ImpMov := 'S'
  else ImpMov := 'N';

  if rbFin.Checked
  then ImpFin := 'S'
  else ImpFin := 'N';

  if cbPen.Checked
  then ImpPen := 'S'
  else ImpPen := 'N';
//  DM.ImprimirRelatorio('','rpPos');
//  frmRelCli := TfrmRelCli.Create(nil);
//  try
//    frmRelCli.Rp.PreviewModal;
//  finally
//    frmRelCli.Free;
//  end;
  DM.RvPrj.ProjectFile := ExtractFilePath(Application.ExeName)+'Cons.rav';
  DM.RvPrj.Open;
  DM.RvPrj.SetParam('ImpPen',ImpPen);
  DM.RvPrj.SetParam('ImpFin',ImpFin);
  DM.RvPrj.SetParam('ImpMov',ImpMov);
  DM.RvPrj.ExecuteReport('rpPos');
  DM.RvPrj.Close;
end;

procedure TfrmCli.PosicionaDataset(Gru, Seq, Cot: String);
var
  stSql: string;
  pcpag: Double;
begin
     FechaTabs;

     if not (DM.PosGru(Gru)) then
     begin
       Application.MessageBox('Grupo não encontrado!','Atenção',MB_ICONWARNING+MB_OK);
       txtGru.SetFocus;
       Exit;
     end;

     if not (DM.PosCot(Gru,Format('%.2d',[StrToIntDef(Seq,0)]),
          Format('%.3d',[StrToIntDef(Cot,0)]))) then begin
        Application.MessageBox('Cota não encontrada!','Atenção',
                      MB_ICONWARNING+MB_OK);
        FechaTabs;
        txtCota.SetFocus;
        Exit;
     end;
//     if DM.cdsCotPESS_F_J.Value = 'F'
//     then DM.cdsCotCGC_CPF.EditMask := '999\.999\.999\-99;0;_'
//     else DM.cdsCotCGC_CPF.EditMask := '99\.999\.999\/9999\-99;0;_';

     txtGru.Text := Gru;
     txtCota.Text  := Format('%.3d',[StrToIntDef(Cot,0)]);
     txtSeq.Text := Format('%.2d',[StrToIntDef(Seq,0)]);
     DM.AtualizarVlrAtualPendencia(txtGru.Text, txtSeq.Text, txtCota.Text);
     spCreditos.Enabled := not DM.cdsCre.Eof;
     btnAli.Enabled := not DM.cdsAli.Eof;
     btnJur.Enabled := not DM.sdsJur.Eof;
     btnDevCon.Enabled := (StrToInt(DM.cdsCotSEQ.Value) > 0) and
           (StrToInt(DM.cdsCotSEQ.Value) < 50);
     DM.MontarPagamentos;
     DM.MontarPendencias;
     pcpag := DM.cdsMovTTPer.Value;
     if (DM.cdsCotPerPago.Value <> pcpag) then begin
       DecimalSeparator := '.';
       stSql := Format(
        'update accli set p_no_pag=%f where grupo=%s and seq=%s and cota=%s',[
        (pcpag-DM.cdsCotP_AN_PAG.Value), QuotedStr(DM.cdsCotGRUPO.Value),
        QuotedStr(DM.cdsCotSEQ.Value), QuotedStr(DM.cdsCotCOTA.Value)]);
        DecimalSeparator := ',';
        DM.ExecutarSQL(stSql);
        DM.cdsCot.Refresh;
     end;
     ExcPend.Enabled := not DM.cdsCb1.Eof;
     AltPend.Enabled := ExcPend.Enabled;
     DM.sdsPre.First;
end;

procedure TfrmCli.tbCliExit(Sender: TObject);
begin
  if dsCot.State = dsEdit then CanEnd.Execute;

end;

procedure TfrmCli.txtCotaExit(Sender: TObject);
begin
     if (txtGru.Text = '') or (txtSeq.Text='') or (txtCota.Text='') then Exit;
     PosicionaDataset(txtGru.Text,txtSeq.Text,txtCota.Text);
end;

procedure TfrmCli.txtGruExit(Sender: TObject);
var
   gru : string;
begin

  if txtGru.Text = '' then Exit;
  gru := txtGru.Text;
  if StrToIntDef(gru,0)>0
  then gru := Format('%.4d',[StrToInt(txtGru.Text)]);
  txtGru.Text := gru;
  if not (DM.PosGru(txtGru.Text)) then begin
    Application.MessageBox('Grupo não encontrado!','Atenção',MB_ICONHAND+MB_OK);
    txtGru.SelectAll;
    txtGru.SetFocus;
  end;

end;

procedure TfrmCli.PesquisaExecute(Sender: TObject);
begin
     frmPesq := TfrmPesq.Create(Application);
     try
        if frmPesq.ShowModal = mrOk
        then if not DM.cdsCons.IsEmpty
             then PosicionaDataset(DM.cdsCons.Fields[0].Value,
                         DM.cdsCons.Fields[1].Value,DM.cdsCons.Fields[2].Value)
             else FechaTabs;

     finally
        DM.cdsCons.Close;
        frmPesq.Free;
     end;
end;


procedure TfrmCli.ReuExecute(Sender: TObject);
begin
     if DM.sdsReu.IsEmpty
     then ShowMessage('Reuniões não encontradas!')
     else DM.CriaForm(TfrmReu,frmReu);
end;

procedure TfrmCli.PreExecute(Sender: TObject);
begin
     DM.CriaForm(TfrmPre,frmPre);
end;

procedure TfrmCli.dsCotStateChange(Sender: TObject);
begin
     btnReu.Enabled := not DM.cdsCot.IsEmpty;
     btnPre.Enabled := btnReu.Enabled;
     btnJur.Enabled := btnReu.Enabled;
     btnPos.Enabled := btnReu.Enabled;
     btnAli.Enabled := btnReu.Enabled;
     spAltEnd.Enabled := (dsCot.State = dsBrowse);
     spGrvEnd.Enabled := (dsCot.State = dsEdit);
     spCanEnd.Enabled := spGrvEnd.Enabled;
     rbPag.Enabled := btnPos.Enabled;
     rbFin.Enabled := rbPag.Enabled;
     rbSemPag.Enabled := rbPag.Enabled;
     cbPen.Enabled := btnPos.Enabled;
end;

procedure TfrmCli.excPagExecute(Sender: TObject);
var
  tpMov: Integer;
begin

  tpMov := 0;
  if DM.PosicionarMvt(DM.cdsCotGRUPO.Value, DM.cdsCotSEQ.Value,
       DM.cdsCotCOTA.Value,DM.cdsMovAviso.Value)
  then tpMov := Pos(DM.cdsMvtTIPO_MOV.Value,'01,SR,04,14,15,94');

  if tpMov>0 then begin

    if Application.MessageBox('Confirma a exclusão?','Atenção',
      MB_ICONQUESTION+MB_YESNO)=mrYes then begin

      case tpMov of
       1,4,16: DM.AtualizarPercentualPago(DM.cdsCotGRUPO.Value,DM.cdsCotSEQ.Value,
          DM.cdsCotCOTA.Value,0,-DM.cdsMvtP_NORMAL.Value);
       7: DM.AtualizarPercentualPago(DM.cdsCotGRUPO.Value,DM.cdsCotSEQ.Value,
          DM.cdsCotCOTA.Value,1,-DM.cdsMvtP_RATEIO.Value);
      end;

      DM.ExecutarSQL(Format(
         'delete from ACHIS where GRUPO=%s and CONTRATO=%s and CONTABIL=%s and AVISO=%s',
         [QuotedStr(DM.cdsMvtGRUPO.Value),QuotedStr(DM.cdsCotCONTRATO.Value),
          QuotedStr(FormatDateTime('mm/dd/yyyy',DM.cdsMvtD_CONTAB.Value)),
          QuotedStr(DM.cdsMvtAVISO.Value)]));

      if (DM.cdsMvtSEQ.Value='00') and (DM.cdsMvtAV_V_COB.Value='S')then begin
        DM.cdsPnd.Open;
        DM.cdsPnd.Append;
        DM.cdsPndGRUPO.Value := DM.cdsMvtGRUPO.Value;
        DM.cdsPndSEQ.Value := DM.cdsMvtSEQ.Value;
        DM.cdsPndCOTA.Value := DM.cdsMvtCOTA.Value;
        DM.cdsPndAVISO.Value := DM.ObterNovoAviso(DM.cdsMvtGRUPO.Value,
                                DM.cdsMvtSEQ.Value,DM.cdsMvtCOTA.Value);
        DM.cdsPndTIPO_MOV.Value := DM.cdsMvtTIPO_MOV.Value;
        DM.cdsPndD_VENCTO.Value := DM.cdsMvtD_VENCTO.Value;
        DM.cdsPndAG_COBRA.Value := DM.cdsMvtAG_FINAN.Value;
        DM.cdsPndP_NORMAL.Value := DM.cdsMvtP_NORMAL.Value;
        DM.cdsPndP_DIFER.Value := DM.cdsMvtP_DIFER.Value;
        DM.cdsPndP_RATEIO.Value := DM.cdsMvtP_RATEIO.Value;
        DM.cdsPndP_SUBST.Value := DM.cdsMvtP_SUBST.Value;
        DM.cdsPndF_AQUISI.Value := DM.cdsMvtF_AQUISI.Value;
        DM.cdsPndADMINIST.Value := DM.cdsMvtADMINIST.Value;
        DM.cdsPndF_RESERV.Value := DM.cdsMvtF_RESERV.Value;
        DM.cdsPndOUTROS.Value := DM.cdsMvtOUTROS.Value;
        DM.cdsPndNR_EXTER.Value := DupeString(' ',20);
        DM.cdsPndDT_BASE.Value := DM.cdsMvtDT_BASE.Value;
        DM.cdsPndP_ANTEC.Value := DM.cdsMvtP_ANTEC.Value;
        DM.cdsPndSEG_OUT.Value := DM.cdsMvtSEG_OUT.Value;
        DM.cdsPndUSUARIO.Value := DM.cdsMvtUSUARIO.Value;
        DM.cdsPndD_ATUALI.Value := Date;
        DM.cdsPndTP_ABONO.Value := '00';
        DM.cdsPndMUL_JUR.Value := 0;
        DM.cdsPndCOBRADOR.Value := '000000';
        DM.cdsPndTAR_BANC.Value := 0;
        DM.cdsPndAV_ASSOC.Value := '000000';
        DM.cdsPndFILLER.Value := DupeString(' ',20);
        DM.cdsPndADM_DESC.Value := 0;
        DM.cdsPnd.Post;
        DM.cdsPnd.ApplyUpdates(0);
      end;

      DM.cdsMvt.Delete;
      DM.cdsMvt.ApplyUpdates(0);
      PosicionaDataset(txtGru.Text,txtSeq.Text,txtCota.Text);

    end;

  end
  else  Application.MessageBox('Tipo de Pagamento não pode ser excluído!',
                                        'Atenção',MB_ICONHAND+MB_OK);


end;

procedure TfrmCli.ExcPendExecute(Sender: TObject);
begin
  if DM.PosicionarPnd(DM.cdsCotGRUPO.Value, DM.cdsCotCOTA.Value,
     DM.cdsCb1Aviso.Value) then begin
      if Application.MessageBox('Confirma a exclusão?','Atenção',
          MB_ICONQUESTION+MB_YESNO)=mrYes then begin
          DM.cdsPnd.Delete;
          DM.cdsPnd.ApplyUpdates(0);
          PosicionaDataset(txtGru.Text,txtSeq.Text,txtCota.Text);
      end;
  end;
end;

procedure TfrmCli.JurExecute(Sender: TObject);
begin
     if DM.sdsJur.IsEmpty
     then ShowMessage('Fases jurídicas não encontradas!')
     else DM.CriaForm(TfrmJur,frmJur);
     DM.sdsJur.Close;
end;

procedure TfrmCli.LisCotaExecute(Sender: TObject);
begin
  frmLista := TFrmLista.Create(nil);
  try
    FrmLista.Tipo := lsCota;
    FrmLista.Gru := txtGru.Text;
    if frmLista.ShowModal = mrOk then begin
      txtSeq.Text := DM.cdsPesq.Fields[1].AsString;
      txtCota.Text := DM.cdsPesq.Fields[2].AsString;
      PosicionaDataset(txtGru.Text,txtSeq.Text,txtCota.Text);
    end
    else txtSeq.SetFocus;
  finally
    frmLista.Free;
  end;
end;

procedure TfrmCli.LisGruExecute(Sender: TObject);
begin
  frmLista := TFrmLista.Create(nil);
  try
    FrmLista.Tipo := lsGrupo;
    FrmLista.Gru := '';
    if frmLista.ShowModal = mrOk then begin
      txtGru.Text := DM.cdsPesq.Fields[0].AsString;
    end;
  finally
    frmLista.Free;
  end;
end;

procedure TfrmCli.txtSeqExit(Sender: TObject);
begin
     if txtSeq.Text = '' then txtSeq.Text := '00';
end;

procedure TfrmCli.FechaTabs;
begin
     DM.cdsCot.Close;
     DM.sdsBem.Close;
     DM.sdsPre.Close;
     DM.cdsCb1.Close;
     DM.cdsMov.Close;
end;

procedure TfrmCli.FormShow(Sender: TObject);
begin
  PC.ActivePage := tbCont;
  if (DM.cdsAge.Active) and (not DM.cdsAge.IsEmpty)
  then PosicionaDataset(DM.cdsAgeGRUPO.Value,DM.cdsAgeSEQ.Value,DM.cdsAgeCOTA.Value);
end;

procedure TfrmCli.GrvEndExecute(Sender: TObject);
begin
  if Application.MessageBox('Confirma a Gravação?','Atenção',
    MB_ICONQUESTION+MB_YESNO)=ID_YES then begin
    DM.cdsCot.Post;
    DM.cdsCot.ApplyUpdates(0);
    CanEnd.Execute;
  end;
end;

procedure TfrmCli.IncPagExecute(Sender: TObject);
begin
  FrmMov := TFrmMov.Create(nil);
  try
    if FrmMov.ShowModal = mrOk
    then PosicionaDataset(txtGru.Text,txtSeq.Text,txtCota.Text);
  finally
    FrmMov.Free;
  end;
end;

procedure TfrmCli.IncPendExecute(Sender: TObject);
begin
  frmPen := TfrmPen.Create(nil);
  try
    frmPen.Acao := taIncluir;
    if frmPen.ShowModal=mrOk
    then PosicionaDataset(txtGru.Text,txtSeq.Text,txtCota.Text);
  finally
    frmPen.Free;
  end;
end;

procedure TfrmCli.sitCobExecute(Sender: TObject);
begin
  frmSitCob := TfrmSitCob.Create(nil);
  try
     if frmSitCob.ShowModal=mrOk
     then DM.cdsCot.Refresh;
  finally
    frmSitCob.Free;
  end;
end;

procedure TfrmCli.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left+1,Rect.Top,StFig);
end;

procedure TfrmCli.AltEndExecute(Sender: TObject);
begin
  DM.cdsCot.Edit;
  EdtFone.Color := clWhite;
  EdtEnd.Color := clWhite;
  EdtBai.Color := clWhite;
  EdtCid.Color := clWhite;
  EdtUf.Color := clWhite;
  EdtCep.Color := clWhite;
  EdtFone.ReadOnly := False;
  EdtEnd.ReadOnly := False;
  EdtBai.ReadOnly := False;
  EdtCid.ReadOnly := False;
  EdtUf.ReadOnly := False;
  EdtCep.ReadOnly := False;
  EdtFone.TabStop := True;
  EdtEnd.TabStop := True;
  EdtBai.TabStop := True;
  EdtCid.TabStop := True;
  EdtUf.TabStop := True;
  EdtCep.TabStop := True;
  panEnd.SetFocus;
  EdtFone.SetFocus;
end;

procedure TfrmCli.AltPendExecute(Sender: TObject);
begin
  if DM.PosicionarPnd(DM.cdsCotGRUPO.Value, DM.cdsCotCOTA.Value,
     DM.cdsCb1Aviso.Value) then begin
      frmPen := TfrmPen.Create(nil);
      try
        frmPen.Acao := taAlterar;
        if frmPen.ShowModal=mrOk
        then PosicionaDataset(txtGru.Text,txtSeq.Text,txtCota.Text);
      finally
        frmPen.Free;
      end;
  end;

end;

procedure TfrmCli.CanEndExecute(Sender: TObject);
begin
  if dsCot.State = dsEdit then
    DM.cdsCot.Cancel;
  EdtFone.Color := clBtnFace;
  EdtEnd.Color := clBtnFace;
  EdtBai.Color := clBtnFace;
  EdtCid.Color := clBtnFace;
  EdtUf.Color := clBtnFace;
  EdtCep.Color := clBtnFace;
  EdtFone.ReadOnly := True;
  EdtEnd.ReadOnly := True;
  EdtBai.ReadOnly := True;
  EdtCid.ReadOnly := True;
  EdtUf.ReadOnly := True;
  EdtCep.ReadOnly := True;
  EdtFone.TabStop := False;
  EdtEnd.TabStop := False;
  EdtBai.TabStop := False;
  EdtCid.TabStop := False;
  EdtUf.TabStop := False;
  EdtCep.TabStop := False;
end;

procedure TfrmCli.ComExecute(Sender: TObject);
begin
     DM.CriaForm(TfrmCom,frmCom);
end;

procedure TfrmCli.CreExecute(Sender: TObject);
begin
  if DM.cdsCre.IsEmpty
  then Application.MessageBox('Não foram encontrados créditos para a cota!',
          'Atenção',MB_ICONWARNING+MB_OK)
  else DM.CriaForm(TFrmCre,FrmCre);
end;

procedure TfrmCli.DevConExecute(Sender: TObject);
begin
  DM.CriaForm(TfrmDevcon,frmDevCon);
end;

procedure TfrmCli.AliExecute(Sender: TObject);
begin
     if DM.cdsAli.IsEmpty
     then Application.MessageBox('Não foram encontradas alienações para a cota!',
          'Atenção',MB_ICONWARNING+MB_OK)
     else DM.CriaForm(TfrmAli,frmAli);
end;

end.
