unit UnPrs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, ActnList, DB,
  ComCtrls;

type
  TfrmPrs = class(TForm)
    stBar: TStatusBar;
    DS: TDataSource;
    AL: TActionList;
    Altera: TAction;
    Grava: TAction;
    Cancela: TAction;
    Sair: TAction;
    Panel1: TPanel;
    btnGravar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnSair: TSpeedButton;
    btnAlterar: TSpeedButton;
    pc: TPageControl;
    tsGeral: TTabSheet;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    tsSAG: TTabSheet;
    Panel3: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit11: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    lblLib: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DSStateChange(Sender: TObject);
    procedure stBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GravaExecute(Sender: TObject);
    procedure CancelaExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure AlteraExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrs: TfrmPrs;
  StFig : Integer;

implementation

uses UnDM, DBClient, UnitCpt;

{$R *.dfm}

procedure TfrmPrs.FormActivate(Sender: TObject);
begin
     DM.cdsPRS.Open;
     StFig := 7;
end;

procedure TfrmPrs.DSStateChange(Sender: TObject);
const
     Estados : array [TDataSetState] of string =
   ('Fechado','Consultando','Alterando','Inserindo','','','','','','','','','');
begin
     btnGravar.Enabled := DS.State in [dsInsert,dsEdit];
     btnCancelar.Enabled := DS.State in [dsInsert,dsEdit];
     btnAlterar.Enabled := DS.State in [dsBrowse];
     if btnGravar.Enabled
     then StFig := 9
     else StFig := 6;
     stBar.Repaint;
     stBar.Panels[1].Text := Estados[DS.State];
end;

procedure TfrmPrs.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left+2,Rect.Top,StFig);
end;

procedure TfrmPrs.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
//       VK_F2: if btnIncluir.Enabled then btnIncluir.Click;
       VK_F3: if btnAlterar.Enabled then btnAlterar.Click;
//       VK_F4: if btnExcluir.Enabled then btnExcluir.Click;
       VK_F5: if btnGravar.Enabled then btnGravar.Click;
       VK_F6: if btnCancelar.Enabled then btnCancelar.Click;
//       VK_F9: if btnPesq.Enabled then btnPesq.Click;
       VK_RETURN:  Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE:  btnSair.Click;
     end;
end;

procedure TfrmPrs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if DS.State in [dsInsert, dsEdit]
     then DM.cdsPrs.Cancel;
end;

procedure TfrmPrs.FormCreate(Sender: TObject);
var
   DtLib : TDateTime;
   diasUtilizar: Integer;
begin
  pc.ActivePage := tsGeral;
  DtLib := dtLiberado(DM.cdsPRSSTRLIB.Value,DM.cdsPRSNM_PRS.Value);
  diasUtilizar := Round(DtLib-Date);
  lblLib.Caption := format('Liberado até %s (%d dias restantes)',
      [FormatDateTime('dd/mmm/yyyy',DtLib),diasUtilizar]);
end;

procedure TfrmPrs.GravaExecute(Sender: TObject);
begin
     if DBEdit2.Text = ''
     then
         begin
              Application.MessageBox('Necessário informar nome.','Atenção',
                                                 MB_ICONHAND+MB_OK);
              DBEdit2.SetFocus;
              Abort;
         end;
     if Application.MessageBox('Confirma a gravação dos dados?','Confirmação',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;
     DM.cdsPrs.Post;
     DM.cdsPrs.ApplyUpdates(0);
end;

procedure TfrmPrs.CancelaExecute(Sender: TObject);
begin
     DM.cdsPrs.Cancel;
end;

procedure TfrmPrs.SairExecute(Sender: TObject);
begin
     DM.cdsPRS.Close;
     Close;
end;

procedure TfrmPrs.AlteraExecute(Sender: TObject);
begin
     DM.cdsPrs.Edit;
     if pc.ActivePage=tsGeral
     then DBEdit2.SetFocus
     else DBEdit8.SetFocus;
end;

end.
