unit UnEstorno;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Mask,
{$ELSE}
  MaskEdit,
{$ENDIF}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Buttons, StdCtrls, DBCtrls, ExtCtrls, ActnList,
  DB;

type
  TfrmEstorno = class(TForm)
    DS: TDataSource;
    AL: TActionList;
    Grava: TAction;
    Sair: TAction;
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit1: TDBEdit;
    Panel1: TPanel;
    btnGravar: TSpeedButton;
    btnSair: TSpeedButton;
    stBar: TStatusBar;
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
  frmEstorno: TfrmEstorno;
  StFig : Integer;

implementation

uses UnDm;

{$R *.dfm}

procedure TfrmEstorno.SairExecute(Sender: TObject);
begin
     Close;
end;

procedure TfrmEstorno.DSStateChange(Sender: TObject);
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

procedure TfrmEstorno.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left+1,Rect.Top,StFig);
end;

procedure TfrmEstorno.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F5: if btnGravar.Enabled then btnGravar.Click;
       VK_RETURN:  SelectNext(ActiveControl,True,True);
       VK_ESCAPE: Sair.Execute;
     end;
end;

procedure TfrmEstorno.FormCreate(Sender: TObject);
begin
     StFig := 7;
end;

procedure TfrmEstorno.GravaExecute(Sender: TObject);
begin
     if Application.MessageBox('Confirma o estorno?','Confirmação',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;

//     DM.cdsPcl.Edit;
//     DM.cdsPclVALPG.Value := 0;
//     DM.cdsPclPAGTO.Clear;
//     DM.cdsPclMULTA.Value := 0.00;
//     DM.cdsPclRECIBO.AsInteger := 0;
//     DM.cdsPcl.Post;
//     DM.cdsPcl.ApplyUpdates(0);
//     DM.cdsCot.Edit;
//     DM.cdsCotPC_PAGO.Value := DM.cdsCotPC_PAGO.Value - DM.cdsPclPC_BEM.Value;
//     DM.cdsCotPC_DEV.Value := 100 - DM.cdsCotPC_PAGO.Value;
//     DM.cdsCot.Post;
//     DM.cdsCot.ApplyUpdates(0);
     Sair.Execute;
end;

end.
