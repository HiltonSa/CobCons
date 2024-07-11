unit UnPcl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, DB, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls,
  ComCtrls, JvExMask, JvToolEdit, JvBaseEdits, JvDBControls;

type
  TfrmPcl = class(TForm)
    stBar: TStatusBar;
    Panel1: TPanel;
    btnGravar: TSpeedButton;
    btnSair: TSpeedButton;
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit1: TDBEdit;
    DS: TDataSource;
    AL: TActionList;
    Grava: TAction;
    Sair: TAction;
    JvDBCalcEdit1: TJvDBCalcEdit;
    procedure SairExecute(Sender: TObject);
    procedure DSStateChange(Sender: TObject);
    procedure stBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure GravaExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPcl: TfrmPcl;
  StFig : Integer;

implementation

uses UnDm;

{$R *.dfm}

procedure TfrmPcl.SairExecute(Sender: TObject);
begin
//     if DS.State = dsEdit
//     then DM.cdsPen.Cancel;
     Close;
end;

procedure TfrmPcl.DSStateChange(Sender: TObject);
const
     Estados : array [TDataSetState] of string =
   ('Fechado','Consultando','Alterando','Inserindo','','','','','','','','','');
begin
//     btnGravar.Enabled := DS.State in [dsInsert,dsEdit];
     if btnGravar.Enabled
     then StFig := 9
     else StFig := 6;
     stBar.Repaint;
     stBar.Panels[1].Text := Estados[DS.State];
end;

procedure TfrmPcl.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left+1,Rect.Top,StFig);
end;

procedure TfrmPcl.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F5: if btnGravar.Enabled then btnGravar.Click;
       VK_RETURN:  Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE: Sair.Execute;
     end;
end;

procedure TfrmPcl.FormCreate(Sender: TObject);
begin
     StFig := 7;
//     DM.cdsPen.Edit;
end;

procedure TfrmPcl.GravaExecute(Sender: TObject);
begin
     if Application.MessageBox('Confirma a alteração?','Confirmação',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;

//     DM.cdsPen.Post;
//     DM.cdsPen.ApplyUpdates(0);
//     DM.AtualizaPendencia(DM.cdsCotDATREF.AsDateTime,DM.cdsCotCD_COTA.AsInteger);
     Sair.Execute;
end;

end.
