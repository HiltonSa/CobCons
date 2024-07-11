unit UnCnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ActnList, Buttons, ExtCtrls, ComCtrls, StdCtrls, DBCtrls,
  Mask;

type
  TfrmCnt = class(TForm)
    stBar: TStatusBar;
    Panel1: TPanel;
    btnGravar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnSair: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnIncluir: TSpeedButton;
    AL: TActionList;
    Pesquisa: TAction;
    Novo: TAction;
    Altera: TAction;
    Exclui: TAction;
    Grava: TAction;
    Cancela: TAction;
    Sair: TAction;
    DS: TDataSource;
    Panel2: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    txtAssunto: TDBEdit;
    Label7: TLabel;
    cboTipo: TComboBox;
    Label8: TLabel;
    DBMemo1: TDBMemo;
    Acordo: TAction;
    btnAco: TSpeedButton;
    procedure DSStateChange(Sender: TObject);
    procedure stBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure GravaExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure AlteraExecute(Sender: TObject);
    procedure ExcluiExecute(Sender: TObject);
    procedure CancelaExecute(Sender: TObject);
    procedure AcordoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCnt: TfrmCnt;
  StFig : Integer;

implementation

uses UnDm, UnAco;

{$R *.dfm}

procedure TfrmCnt.DSStateChange(Sender: TObject);
const
     Estados : array [TDataSetState] of string =
   ('Fechado','Consultando','Alterando','Inserindo','','','','','','','','','');
begin
     btnIncluir.Enabled := DS.State in [dsBrowse,dsInactive];
     btnGravar.Enabled := DS.State in [dsInsert,dsEdit];
     btnCancelar.Enabled := DS.State in [dsInsert,dsEdit];
     btnExcluir.Enabled := DS.State in [dsBrowse];
     btnAlterar.Enabled := DS.State in [dsBrowse];
     btnAco.Enabled := btnAlterar.Enabled;
     if btnGravar.Enabled
     then StFig := 9
     else StFig := 6;
     stBar.Repaint;
     stBar.Panels[1].Text := Estados[DS.State];
end;

procedure TfrmCnt.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left+1,Rect.Top,StFig);
end;

procedure TfrmCnt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F2: if btnIncluir.Enabled then btnIncluir.Click;
       VK_F3: if btnAlterar.Enabled then btnAlterar.Click;
       VK_F4: if btnExcluir.Enabled then btnExcluir.Click;
       VK_F5: if btnGravar.Enabled then btnGravar.Click;
       VK_F6: if btnCancelar.Enabled then btnCancelar.Click;
       VK_F7: if btnAco.Enabled then btnAco.Click;
//       VK_F9: if btnPesq.Enabled then btnPesq.Click;
       VK_RETURN: if not DBMemo1.Focused then Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE: frmCnt.Close;
     end;
end;

procedure TfrmCnt.FormCreate(Sender: TObject);
begin
     StFig := 7;
end;

procedure TfrmCnt.FormShow(Sender: TObject);
begin
     cboTipo.ItemIndex := DM.cdsCntTP_CTATO.AsInteger;
     if DM.cdsCnt.IsEmpty
     then StFig := 7
     else StFig := 6;
     btnAlterar.Enabled := not DM.cdsCnt.IsEmpty;
     btnExcluir.Enabled := btnAlterar.Enabled;
     btnAco.Enabled := btnAlterar.Enabled;
end;

procedure TfrmCnt.NovoExecute(Sender: TObject);
begin
     DM.cdsCnt.Insert;
     DM.cdsCntCD_COTA.Value := DM.cdsCotCD_COTA.Value;
     DM.cdsCntCD_CTATO.AsInteger := DM.GeraCod('CD_CTATO','CJCBCNT');
     DM.cdsCntDT_CTATO.AsDateTime := Date;
     DM.cdsCntINICIO.Value := FormatDateTime('hhnn',Time);
     cboTipo.SetFocus;
end;

procedure TfrmCnt.GravaExecute(Sender: TObject);
begin
     if txtAssunto.Text = ''
     then
         begin
              ShowMessage('Precisa informar ASSUNTO!');
              Abort;
         end;
     if DS.State = dsInsert
     then DM.cdsCntTERMINO.Value := FormatDateTime('hhnn',Time);
     DM.cdsCntTP_CTATO.AsInteger := cboTipo.ItemIndex;
     if DS.State = dsInsert
     then
         begin
              if not DM.cdsCam.IsEmpty
              then
                  begin
                       DM.cdsCam.Edit;
                       DM.cdsCamCONTATO.Value := DM.cdsCntCD_CTATO.Value;
                       DM.cdsCamSTATUS.AsInteger := 2;
                       DM.cdsCam.Post;
                       DM.cdsCam.ApplyUpdates(0);
                       DM.cdsCam.Refresh;
                  end;
         end;
     DM.cdsCnt.Post;
     DM.cdsCnt.ApplyUpdates(0);
end;

procedure TfrmCnt.SairExecute(Sender: TObject);
begin
     if DS.State in [dsInsert,dsEdit]
     then DM.cdsCnt.Cancel;
     Close;
end;

procedure TfrmCnt.AlteraExecute(Sender: TObject);
begin
     DM.cdsCnt.Edit;
     cboTipo.SetFocus;
end;

procedure TfrmCnt.ExcluiExecute(Sender: TObject);
begin
     StFig := 8;
     stBar.Panels[1].Text := 'Excluindo';
     stBar.Repaint;
     if Application.MessageBox('Confirma a exclusão?','Confirmação',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;
     DM.cdsCnt.Delete;
     DM.cdsCnt.ApplyUpdates(0);
end;

procedure TfrmCnt.CancelaExecute(Sender: TObject);
begin
     DM.cdsCnt.Cancel;
end;

procedure TfrmCnt.AcordoExecute(Sender: TObject);
begin
     DM.CriaForm(TfrmAco,frmAco);
end;

end.
