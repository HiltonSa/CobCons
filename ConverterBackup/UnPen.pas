unit UnPen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Mask, DBCtrls, ExtCtrls, Grids, DBGrids, ComCtrls,
  Menus, ActnList, JvBaseEdits, JvDBControls, JvExMask, JvToolEdit, JvMaskEdit,
  JvCheckedMaskEdit, JvDatePickerEdit, JvDBDatePickerEdit, Buttons;

type
  TpAcao = (taIncluir, taAlterar);
  TfrmPen = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    dsPen: TDataSource;
    dsCot: TDataSource;
    PM: TPopupMenu;
    BaixarParcela1: TMenuItem;
    AnularBaixa1: TMenuItem;
    AL: TActionList;
    AlterarParcela1: TMenuItem;
    N1: TMenuItem;
    ExcluirParcela1: TMenuItem;
    Gravar: TAction;
    Cancelar: TAction;
    cboTmv: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    dtVenc: TJvDBDatePickerEdit;
    DBEdit5: TDBEdit;
    Label8: TLabel;
    DBEdit6: TDBEdit;
    Label15: TLabel;
    DBEdit7: TDBEdit;
    Label9: TLabel;
    DBEdit8: TDBEdit;
    Label10: TLabel;
    dsPre: TDataSource;
    Label11: TLabel;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    Label12: TLabel;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    Label13: TLabel;
    DBEdit13: TDBEdit;
    Label14: TLabel;
    edtValor: TJvCalcEdit;
    Panel2: TPanel;
    btIncPend: TSpeedButton;
    btExcPend: TSpeedButton;
    procedure edtValorExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure GravarExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FAcao: TpAcao;
    procedure SetAcao(const Value: TpAcao);
    { Private declarations }
  public
    { Public declarations }
    property Acao : TpAcao read FAcao write SetAcao;
    procedure DesmembrarValor;
  end;

var
  frmPen: TfrmPen;

implementation

uses UnDm;


{$R *.dfm}

procedure TfrmPen.CancelarExecute(Sender: TObject);
begin
  DM.cdsPnd.Cancel;
  ModalResult := mrCancel;
end;

procedure TfrmPen.DesmembrarValor;
var
  fator : Double;
begin
  if edtValor.Value>0 then begin
    DM.cdsPndP_NORMAL.Value := 0;
    DM.cdsPndP_RATEIO.Value := 0;
    DM.cdsPndF_AQUISI.Value := 0;
    DM.cdsPndADMINIST.Value := 0;
    DM.cdsPndF_RESERV.Value := 0;
    DM.cdsPndOUTROS.Value := 0;
    DM.cdsPndMUL_JUR.Value := 0;
    case cboTmv.ItemIndex of
     0: begin
       fator := 1 + ((DM.cdsCotP_ADMINS.Value + DM.cdsCotP_RESERV.Value)/100);
       DM.cdsPndF_AQUISI.Value := edtValor.Value / fator;
       DM.cdsPndADMINIST.Value := DM.cdsPndF_AQUISI.Value * DM.cdsCotP_ADMINS.Value / 100;
       DM.cdsPndP_NORMAL.Value := DM.cdsPndF_AQUISI.Value / DM.sdsPrePRE_TABE.Value * 100;
       DM.cdsPndF_RESERV.Value := DM.cdsPndF_AQUISI.Value * DM.cdsCotP_RESERV.Value / 100;
     end;
     1: begin
       DM.cdsPndF_AQUISI.Value := edtValor.Value;
       DM.cdsPndP_NORMAL.Value := DM.cdsPndF_AQUISI.Value / DM.sdsPrePRE_TABE.Value * 100;
     end;
     2: begin
       fator := 1 + (DM.cdsCotP_ADMINS.Value /100);
       DM.cdsPndF_AQUISI.Value := edtValor.Value / fator;
       DM.cdsPndADMINIST.Value := DM.cdsPndF_AQUISI.Value * DM.cdsCotP_ADMINS.Value / 100;
       DM.cdsPndP_RATEIO.Value := DM.cdsPndF_AQUISI.Value / DM.sdsPrePRE_TABE.Value * 100;
     end;
     3,4: DM.cdsPndOUTROS.Value := edtValor.Value;
    end;

  end;

end;

procedure TfrmPen.edtValorExit(Sender: TObject);
begin
  DesmembrarValor;
end;

procedure TfrmPen.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Cancelar.Execute;
    VK_RETURN: Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmPen.FormShow(Sender: TObject);
var
  I: Integer;
begin
  if FAcao = taIncluir then begin
    Caption := 'Incluir Pendencia';
    if not DM.cdsPnd.Active then
      DM.cdsPnd.Open;
    DM.cdsPnd.Append;
    DM.cdsPndGRUPO.Value := DM.cdsCotGRUPO.Value;
    DM.cdsPndSEQ.Value := DM.cdsCotSEQ.Value;
    DM.cdsPndCOTA.Value := DM.cdsCotCOTA.Value;
    DM.cdsPndAVISO.Value := DM.ObterNovoAviso(DM.cdsCotGRUPO.Value,
          DM.cdsCotSEQ.Value,DM.cdsCotCOTA.Value);
    DM.cdsPndAG_COBRA.Value := DM.cdsCotAG_COBRA.Value;
    DM.cdsPndP_NORMAL.Value := 0;
    DM.cdsPndD_VENCTO.Value := Date;
    DM.cdsPndP_DIFER.Value := 0;
    DM.cdsPndP_RATEIO.Value := 0;
    DM.cdsPndP_SUBST.Value := 0;
    DM.cdsPndF_AQUISI.Value := 0;
    DM.cdsPndADMINIST.Value := 0;
    DM.cdsPndF_RESERV.Value := 0;
    DM.cdsPndOUTROS.Value := 0;
    DM.cdsPndNR_EXTER.Value := '';
    DM.cdsPndDT_BASE.Value := Date;
    DM.cdsPndP_ANTEC.Value := 0;
    DM.cdsPndSEG_OUT.Value := 'O';
    DM.cdsPndUSUARIO.Value := '0000';
    DM.cdsPndD_ATUALI.Value := Date;
    DM.cdsPndTP_ABONO.Value := '00';
    DM.cdsPndMUL_JUR.Value := 0;
    DM.cdsPndCOBRADOR.Value := '000000';
    DM.cdsPndTAR_BANC.Value := 0;
    DM.cdsPndAV_ASSOC.Value := '000000';
    DM.cdsPndFILLER.Value := '';
    DM.cdsPndADM_DESC.Value := 0;
    edtValor.Value := 0;
  end;

  if FAcao = taAlterar then begin
    DM.PosicionarPnd(DM.cdsCotGRUPO.Value,DM.cdsCotCOTA.Value,DM.cdsCb1Aviso.Value);
    Caption := 'Alterar Pendencia';
    edtValor.Value := DM.cdsPndF_AQUISI.Value + DM.cdsPndF_RESERV.Value +
                      DM.cdsPndADMINIST.Value + DM.cdsPndOUTROS.Value;
    for I := 0 to cboTmv.Items.Count - 1 do begin
      if DM.cdsPndTIPO_MOV.Value=Copy(cboTmv.Items[I],1,2)
      then Break;
    end;
    cboTmv.ItemIndex := I;
    DM.cdsPnd.Edit;
  end;


end;

procedure TfrmPen.GravarExecute(Sender: TObject);
begin
  if edtValor.Value = 0 then begin
    Application.MessageBox('Valor não pode ser zero!','Atenção',MB_ICONHAND+MB_OK);
    edtValor.SetFocus;
  end
  else begin
    if Application.MessageBox('Confirma a gravação?', 'Atenção',
      MB_ICONQUESTION+MB_YESNO)=mrYes then begin
      DM.cdsPndTIPO_MOV.Value := Copy(cboTmv.Text,1,2);
      DM.cdsPnd.Post;
      DM.cdsPnd.ApplyUpdates(0);
      frmPen.ModalResult := mrOk;
    end;
  end;

end;

procedure TfrmPen.SetAcao(const Value: TpAcao);
begin
  FAcao := Value;
end;

end.
