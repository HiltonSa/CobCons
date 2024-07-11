unit UnCom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, JvExStdCtrls, JvDBCombobox, Mask, JvExMask,
  JvToolEdit, JvMaskEdit, JvCheckedMaskEdit, JvDatePickerEdit,
  JvDBDatePickerEdit, DB, ActnList, Buttons, ExtCtrls, ComCtrls;

type
  TfrmCom = class(TForm)
    stBar: TStatusBar;
    Panel1: TPanel;
    btnGravar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnSair: TSpeedButton;
    AL: TActionList;
    Grava: TAction;
    Cancela: TAction;
    Sair: TAction;
    Panel2: TPanel;
    DS: TDataSource;
    dtAge: TJvDBDatePickerEdit;
    JvDBComboBox1: TJvDBComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBMemo1: TDBMemo;
    Panel3: TPanel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure DSStateChange(Sender: TObject);
    procedure stBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure GravaExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure CancelaExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCom: TfrmCom;
  StFig : Integer;

implementation

uses UnDm;

{$R *.dfm}

procedure TfrmCom.DSStateChange(Sender: TObject);
const
     Estados : array [TDataSetState] of string =
   ('Fechado','Consultando','Alterando','Inserindo','','','','','','','','','');
begin
     btnGravar.Enabled := DS.State in [dsInsert,dsEdit];
     btnCancelar.Enabled := btnGravar.Enabled;
     if btnGravar.Enabled
     then StFig := 9
     else StFig := 6;
     stBar.Repaint;
     stBar.Panels[1].Text := Estados[DS.State];
end;

procedure TfrmCom.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left+1,Rect.Top,StFig);
end;

procedure TfrmCom.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F5: if btnGravar.Enabled then btnGravar.Click;
       VK_F6: if btnCancelar.Enabled then btnCancelar.Click;
       VK_RETURN: if not DBMemo1.Focused then Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE: Sair.Execute;
     end;
end;

procedure TfrmCom.FormCreate(Sender: TObject);
begin
     if not DM.cdsAge.Active
     then DM.cdsAge.Open;
     DM.cdsAge.Insert;
     DM.cdsAgeCD_AGE.AsInteger := DM.GeraCod('CD_AGE','CJCBAGE');
     DM.cdsAgePRIORIDADE.AsInteger := 0;
     DM.cdsAgeSTATUS.AsInteger := 0;
     DM.cdsAgeCD_USU.AsInteger := DM.UsuCod;
     if DM.cdsCot.Active
     then
         begin
              DM.cdsAgeGRUPO.Value := DM.cdsCotGRUPO.Value;
              DM.cdsAgeSEQ.Value := DM.cdsCotSEQ.Value;
              DM.cdsAgeCOTA.Value := DM.cdsCotCOTA.Value;
              DM.cdsAgeNOME.Value := DM.cdsCotNOME.Value;
              DM.cdsAgeCD_CTRATO.Value := DM.cdsCotCONTRATO.Value;
         end
     else
         begin
              DM.cdsAgeGRUPO.Value := ' ';
              DM.cdsAgeSEQ.Value := ' ';
              DM.cdsAgeCOTA.Value := ' ';
              DM.cdsAgeNOME.Value := ' ';
              DM.cdsAgeCD_CTRATO.Value := ' ';
         end;
end;

procedure TfrmCom.GravaExecute(Sender: TObject);
begin
     if (dtAge.IsEmpty)
     then
         begin
              Application.MessageBox('Precisa informar DATA!','Atenção',
                  MB_ICONHAND+MB_OK);
              Exit;
         end;
     DM.cdsAge.Post;
     DM.cdsAge.ApplyUpdates(0);
     Sair.Execute;
end;

procedure TfrmCom.SairExecute(Sender: TObject);
begin
     if DS.State in [dsInsert,dsEdit]
     then DM.cdsAge.Cancel;
     Close;
end;

procedure TfrmCom.CancelaExecute(Sender: TObject);
begin
     Sair.Execute;     
end;

end.
