unit UnMov;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  JvDBDatePickerEdit, JvDatePickerEdit, JvCheckedMaskEdit, JvMaskEdit, JvToolEdit, JvExMask, JvDBControls, JvBaseEdits, Mask,
{$ELSE}
  MaskEdit,
{$ENDIF}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Menus, DB,
  StdCtrls,
  DBCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFrmMov = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    cboTmv: TComboBox;
    dtVenc: TJvDBDatePickerEdit;
    dsCot: TDataSource;
    dsMvt: TDataSource;
    AL: TActionList;
    Gravar: TAction;
    Cancelar: TAction;
    dtContab: TJvDBDatePickerEdit;
    Label9: TLabel;
    dtPagto: TJvDBDatePickerEdit;
    Label10: TLabel;
    dsPre: TDataSource;
    DBEdit6: TDBEdit;
    Label15: TLabel;
    edHis: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    edtValor: TJvCalcEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    cboAviso: TComboBox;
    Panel2: TPanel;
    btExcPend: TSpeedButton;
    btIncPend: TSpeedButton;
    Label18: TLabel;
    edTot: TJvCalcEdit;
    edtPc: TJvCalcEdit;
    Label19: TLabel;
    procedure edtPcExit(Sender: TObject);
    procedure DBEdit10Exit(Sender: TObject);
    procedure DBEdit9Exit(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
    procedure dtPagtoExit(Sender: TObject);
    procedure cboAvisoSelect(Sender: TObject);
    procedure GravarExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cboTmvSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DesmembraValor;
    procedure CalcularTotais;
  end;

var
  FrmMov: TFrmMov;

implementation

uses UnDm;

{$R *.dfm}

procedure TFrmMov.CalcularTotais;
begin
  edTot.Value := DM.cdsMvtF_AQUISI.Value + DM.cdsMvtF_RESERV.Value +
                 DM.cdsMvtADMINIST.Value + DM.cdsMvtOUTROS.Value +
                 DM.cdsMvtMUL_JUR.Value;
end;

procedure TFrmMov.CancelarExecute(Sender: TObject);
begin
  DM.cdsMvt.Cancel;
  FrmMov.ModalResult := mrCancel;
end;

procedure TFrmMov.cboAvisoSelect(Sender: TObject);
var
  I: Integer;
begin
  if cboAviso.Text<>'Novo' then begin
    if DM.cdsCb1.Locate('aviso',cboAviso.Text,[]) then begin
      DM.cdsCob.Locate('aviso',cboAviso.Text,[]);
      DM.cdsMvtAVISO.Value := DM.cdsCobAviso.Value;
      DM.cdsMvtTIPO_MOV.Value := DM.cdsCobTIPO_MOV.Value;
      DM.cdsMvtD_VENCTO.Value := DM.cdsCobD_VENCTO.Value;
      edtValor.Value := DM.cdsCb1VlTot.Value;
      DM.cdsMvtP_NORMAL.Value := DM.cdsCb1PcNormal.Value;
      DM.cdsMvtP_RATEIO.Value := DM.cdsCb1PcRat.Value;
      DM.cdsMvtF_AQUISI.Value := DM.cdsCobF_AQUISI.Value;
      DM.cdsMvtADMINIST.Value := DM.cdsCobADMINIST.Value;
      DM.cdsMvtF_RESERV.Value := DM.cdsCobF_RESERV.Value;
      DM.cdsMvtOUTROS.Value := DM.cdsCobOUTROS.Value;
      DM.cdsMvtMUL_JUR.Value := DM.cdsCb1VlMulJur.Value;
      DM.cdsMvtAV_V_COB.Value := 'S';
      cboTmv.Enabled := False;
      dtVenc.Enabled := False;
      for I := 0 to cboTmv.Items.Count - 1 do
        if Pos(DM.cdsCobTIPO_MOV.Value,cboTmv.Items[I])>0
        then Break;
      cboTmv.ItemIndex := I;
      if cboTmv.ItemIndex=1 then edtPc.Enabled := True;
    end;
  end
  else begin
    DM.cdsMvtAVISO.Value := DM.ObterNovoAviso(DM.cdsCotGRUPO.Value,
      DM.cdsCotSEQ.Value ,DM.cdsCotCOTA.Value);
    DM.cdsMvtD_VENCTO.Value := Date;
    cboTmv.Enabled := True;
    dtVenc.Enabled := True;
  end;
  CalcularTotais;
end;

procedure TFrmMov.cboTmvSelect(Sender: TObject);
begin
  DM.cdsMvtTIPO_MOV.Value := Copy(cboTmv.Text,1,2);
  if cboTmv.ItemIndex=1 then edtPc.Enabled := True;

end;

procedure TFrmMov.DBEdit10Exit(Sender: TObject);
begin
  if DM.cdsMvtP_NORMAL.Value > 0
  then DM.cdsMvtF_AQUISI.Value := DM.sdsPrePRE_TABE.Value * DM.cdsMvtP_NORMAL.Value / 100;

end;

procedure TFrmMov.DBEdit9Exit(Sender: TObject);
begin
  DM.cdsMvtP_NORMAL.Value := DM.cdsMvtF_AQUISI.Value / DM.sdsPrePRE_TABE.Value * 100;
  CalcularTotais;  
end;

procedure TFrmMov.DesmembraValor;
var
  fator, vlLiq : Double;
begin
  if (edtValor.Value>0) then begin
    vlLiq := edtValor.Value - (DM.cdsMvtOUTROS.Value + DM.cdsMvtMUL_JUR.Value);
    DM.cdsMvtP_NORMAL.Value := 0;
    DM.cdsMvtP_RATEIO.Value := 0;
    DM.cdsMvtF_AQUISI.Value := 0;
    DM.cdsMvtADMINIST.Value := 0;
    DM.cdsMvtF_RESERV.Value := 0;
    case cboTmv.ItemIndex of
     0: begin     // Pagamento Normal
       fator := 1 + ((DM.cdsCotP_ADMINS.Value + DM.cdsCotP_RESERV.Value)/100);
       DM.cdsMvtF_AQUISI.Value := vlLiq / fator;
       DM.cdsMvtADMINIST.Value := DM.cdsMvtF_AQUISI.Value * DM.cdsCotP_ADMINS.Value / 100;
       DM.cdsMvtP_NORMAL.Value := DM.cdsMvtF_AQUISI.Value / DM.sdsPrePRE_TABE.Value * 100;
       DM.cdsMvtF_RESERV.Value := DM.cdsMvtF_AQUISI.Value * DM.cdsCotP_RESERV.Value / 100;
     end;
     1: begin      // Saldo remanescente
       DM.cdsMvtF_AQUISI.Value := edtValor.Value;
       DM.cdsMvtP_NORMAL.Value := DM.cdsMvtF_AQUISI.Value / DM.sdsPrePRE_TABE.Value * 100;
     end;
     2: begin       // Rateio
       fator := 1 + (DM.cdsCotP_ADMINS.Value /100);
       DM.cdsMvtF_AQUISI.Value := edtValor.Value / fator;
       DM.cdsMvtADMINIST.Value := DM.cdsMvtF_AQUISI.Value * DM.cdsCotP_ADMINS.Value / 100;
       DM.cdsMvtF_RESERV.Value := DM.cdsMvtF_AQUISI.Value / DM.sdsPrePRE_TABE.Value * 100;
     end;
     3,4: DM.cdsMvtOUTROS.Value := edtValor.Value;
     5: begin
       DM.cdsMvtF_AQUISI.Value := -(edtValor.Value);
       DM.cdsMvtP_NORMAL.Value := -(edtValor.Value / DM.sdsPrePRE_TABE.Value * 100);
     end;
    end;

  end;
  CalcularTotais;
end;

procedure TFrmMov.dtPagtoExit(Sender: TObject);
var
  vlPrin, vlMul, vlJur: Double;
begin
  vlPrin := (DM.cdsMvtF_AQUISI.Value + DM.cdsMvtF_RESERV.Value +
             DM.cdsMvtADMINIST.Value + DM.cdsMvtOUTROS.Value);
  if (cboTmv.ItemIndex<>1) and (dtPagto.Date > dtVenc.Date) then begin
    vlMul := vlPrin * DM.cdsPRSPC_MUL.Value / 100;
    vlJur := DM.CalcularJuros(dtVenc.Date, vlPrin, dtPagto.Date);
    DM.cdsMvtMUL_JUR.Value := vlMul + vlJur;
    edtValor.Value := vlPrin + vlMul + vlJur;
  end
  else begin
    edtValor.Value := vlPrin;
    DM.cdsMvtMUL_JUR.Value := 0;
  end;
  CalcularTotais;
end;

procedure TFrmMov.edtPcExit(Sender: TObject);
begin
  if edtPc.Value > 0
  then edtValor.Value := edtPc.Value * DM.sdsPrePRE_TABE.Value / 100;
end;

procedure TFrmMov.edtValorExit(Sender: TObject);
begin
  DesmembraValor;
end;

procedure TFrmMov.FormCreate(Sender: TObject);
begin
  //--------------------MOntar combo de avisos pendentes
  cboAviso.Clear;
  cboAviso.Items.Add('Novo');
  DM.cdsCb1.DisableControls;
  DM.cdsCb1.First;
  while not DM.cdsCb1.Eof do begin
    cboAviso.Items.Add(Format('%.6s',[DM.cdsCb1Aviso.Value]));
    DM.cdsCb1.Next;
  end;
  DM.cdsCb1.First;
  DM.cdsCb1.EnableControls;
  cboAviso.ItemIndex := -1;

  DM.sdsPre.First;
  if not DM.cdsMvt.Active then DM.cdsMvt.Open;
  DM.cdsMvt.Append;
  DM.cdsMvtGRUPO.Value := DM.cdsCotGRUPO.Value;
  DM.cdsMvtSEQ.Value := DM.cdsCotSEQ.Value;
  DM.cdsMvtCOTA.Value := DM.cdsCotCOTA.Value;
  DM.cdsMvtD_CONTAB.Value := Date;
//  DM.cdsMvtAVISO.Value := DM.ObterNovoAviso(DM.cdsCotGRUPO.Value,
//      DM.cdsCotSEQ.Value ,DM.cdsCotCOTA.Value);
//  DM.cdsMvtD_VENCTO.Value := Date;
  DM.cdsMvtDT_PAGTO.Value := Date;
  DM.cdsMvtDT_APROP.Value := Date;
  DM.cdsMvtAG_FINAN.Value := DM.cdsCotAG_COBRA.Value;
  DM.cdsMvtNR_DOCUM.Value := '000002';
  DM.cdsMvtP_NORMAL.Value := 0;
  DM.cdsMvtP_DIFER.Value := 0;
  DM.cdsMvtP_SUBST.Value := 0;
  DM.cdsMvtP_ANTEC.Value := 0;
  DM.cdsMvtF_AQUISI.Value := 0;
  DM.cdsMvtADMINIST.Value := 0;
  DM.cdsMvtF_RESERV.Value := 0;
  DM.cdsMvtOUTROS.Value := 0;
  DM.cdsMvtMUL_JUR.Value := 0;
  DM.cdsMvtRECIBO.Value := '000000';
  DM.cdsMvtSAL_GRU.Value := 'N';
  DM.cdsMvtSAL_CT.Value := 'S';
  DM.cdsMvtTP_PERC.Value := '*';
  DM.cdsMvtDT_BASE.Value := Date;
  DM.cdsMvtSEG_OUT.Value := 'O';
  DM.cdsMvtAV_V_COB.Value := 'N';
  DM.cdsMvtCONTABIL.Value := 'N';
  DM.cdsMvtBEM.Value := DM.cdsCotBEM.Value;
  DM.cdsMvtP_IDEAL.Value := 0;
  DM.cdsMvtTP_SEGUR.Value := DM.cdsCotTP_SEGUR.Value;
  DM.cdsMvtSTATUS.Value := 'N';
  DM.cdsMvtUSUARIO.Value := '0000';
  DM.cdsMvtD_ATUALI.Value := Date;

end;

procedure TFrmMov.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Cancelar.Execute;
    VK_RETURN: SelectNext(ActiveControl,True,True);
  end;
end;

procedure TFrmMov.GravarExecute(Sender: TObject);
begin
  if not (edtValor.Value>=0) then Application.MessageBox('Valor não pode ser zero!',
      'Atenção',MB_ICONHAND+MB_OK)
  else if edtValor.Value <> edTot.Value then Application.MessageBox('Soma dos Valores diferente do Valor Pago!',
      'Atenção',MB_ICONHAND+MB_OK)
  else if Application.MessageBox('Confirma a gravação?', 'Atenção',
    MB_ICONQUESTION+MB_YESNO)=mrYes then begin

    if DM.cdsMvtAV_V_COB.Value = 'S'
    then DM.ExecutarSQL(Format(
       'delete from ACCOB where GRUPO=%s and SEQ=%s and COTA=%s and AVISO=%s',
       [QuotedStr(DM.cdsCotGRUPO.Value),QuotedStr(DM.cdsCotSEQ.Value),
        QuotedStr(DM.cdsCotCOTA.Value),QuotedStr(DM.cdsMvtAVISO.Value)]));

    case cboTmv.ItemIndex of
      0,1,5: DM.AtualizarPercentualPago(DM.cdsCotGRUPO.Value,DM.cdsCotSEQ.Value,
          DM.cdsCotCOTA.Value,0,DM.cdsMvtP_NORMAL.Value);
      2: DM.AtualizarPercentualPago(DM.cdsCotGRUPO.Value,DM.cdsCotSEQ.Value,
          DM.cdsCotCOTA.Value,1,DM.cdsMvtP_RATEIO.Value);
    end;
    DM.cdsMvt.Post;
    DM.cdsMvt.ApplyUpdates(0);
    if edHis.Text<>'' then begin
      DM.ExecutarSQL(Format(
      'insert into ACHIS (GRUPO, CONTRATO, CONTABIL, AVISO, HISTORIC) values '+
      '(%s, %s, %s, %s, %s)',[QuotedStr(DM.cdsMvtGRUPO.Value),QuotedStr(DM.cdsCotCONTRATO.Value),
      QuotedStr(FormatDateTime('mm/dd/yyyy',DM.cdsMvtD_CONTAB.Value)),QuotedStr(DM.cdsMvtAVISO.Value),
      QuotedStr(edHis.Text)]));
    end;

    FrmMov.ModalResult := mrOk;
  end;

end;

end.
