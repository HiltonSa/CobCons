unit UnAltSenha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, ActnList, DB, ComCtrls, StdCtrls;

type
  TfrmAltSenha = class(TForm)
    stBar: TStatusBar;
    DS: TDataSource;
    AL: TActionList;
    Novo: TAction;
    Grava: TAction;
    Cancela: TAction;
    Sair: TAction;
    Panel2: TPanel;
    btnSair: TSpeedButton;
    btnFechar: TSpeedButton;
    Panel1: TPanel;
    txtSenha: TLabeledEdit;
    txtNova: TLabeledEdit;
    txtConf: TLabeledEdit;
    procedure FormActivate(Sender: TObject);
    procedure DSStateChange(Sender: TObject);
    procedure stBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SairExecute(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAltSenha: TfrmAltSenha;
  StFig : Integer;

implementation

uses UnDM, DBClient, SimpleDS;

{$R *.dfm}

procedure TfrmAltSenha.FormActivate(Sender: TObject);
begin
     StFig := 7;
end;

procedure TfrmAltSenha.DSStateChange(Sender: TObject);
const
     Estados : array [TDataSetState] of string =
   ('Fechado','Consultando','Alterando','Inserindo','','','','','','','','','');
begin
     btnFechar.Enabled := DS.State in [dsBrowse,dsInactive];
     if not btnFechar.Enabled
     then StFig := 9
     else StFig := 6;
     stBar.Repaint;
     stBar.Panels[1].Text := Estados[DS.State];
end;

procedure TfrmAltSenha.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left,Rect.Top,StFig);
end;

procedure TfrmAltSenha.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F2: if btnFechar.Enabled then btnFechar.Click;
       VK_RETURN:  Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE:  btnSair.Click;
     end;
end;

procedure TfrmAltSenha.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     DM.cdsUsu.Close;
end;

procedure TfrmAltSenha.SairExecute(Sender: TObject);
begin
     Close;
end;

procedure TfrmAltSenha.NovoExecute(Sender: TObject);
begin
     if txtSenha.Text = '' then Abort;
     if txtNova.Text = '' then Abort;
     if txtConf.Text = '' then Abort;

     if txtConf.Text <> txtNova.Text
     then
         begin
              Application.MessageBox('Nova senha não confere!','Atenção',
              MB_ICONHAND+MB_OK);
              txtNova.SelectAll;
              txtNova.SetFocus;
              Abort;
         end;

     with DM.cdsUsu do
     begin
          Close;
          Params[0].Value := DM.UsuNom;
          Open;
     end;

     if Trim(DM.cdsUsuCD_SENHA.Value) <> txtSenha.Text
     then
         begin
              Application.MessageBox('Senha atual não confere!','Atenção',
              MB_ICONHAND+MB_OK);
              txtSenha.SelectAll;
              txtSenha.SetFocus;
              Abort;
         end;

     if Application.MessageBox('Confirma a alteração?','Confirmação',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;

     DM.cdsUsu.Edit;
     DM.cdsUsuCD_SENHA.Value := txtNova.Text;
     DM.cdsUsu.Post;
     DM.cdsUsu.ApplyUpdates(0);
     Close;
end;

end.
