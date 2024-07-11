unit UnFon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ActnList, Buttons, ExtCtrls, ComCtrls, StdCtrls, Mask,
  DBCtrls;

type
  TfrmFone = class(TForm)
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
    cboTipo: TComboBox;
    Label7: TLabel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    txtFone: TDBEdit;
    cboEnd: TComboBox;
    Label3: TLabel;
    procedure DSStateChange(Sender: TObject);
    procedure stBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure AlteraExecute(Sender: TObject);
    procedure ExcluiExecute(Sender: TObject);
    procedure GravaExecute(Sender: TObject);
    procedure CancelaExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFone: TfrmFone;
  StFig,PosEnd : Integer;

implementation

uses UnDm, StrUtils;

{$R *.dfm}

procedure TfrmFone.DSStateChange(Sender: TObject);
const
     Estados : array [TDataSetState] of string =
   ('Fechado','Consultando','Alterando','Inserindo','','','','','','','','','');
begin
     btnIncluir.Enabled := DS.State in [dsBrowse,dsInactive];
     btnGravar.Enabled := DS.State in [dsInsert,dsEdit];
     btnCancelar.Enabled := DS.State in [dsInsert,dsEdit];
     btnExcluir.Enabled := DS.State in [dsBrowse];
     btnAlterar.Enabled := DS.State in [dsBrowse];
     if btnGravar.Enabled
     then StFig := 9
     else StFig := 6;
     stBar.Repaint;
     stBar.Panels[1].Text := Estados[DS.State];
end;

procedure TfrmFone.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left+1,Rect.Top,StFig);
end;

procedure TfrmFone.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F2: if btnIncluir.Enabled then btnIncluir.Click;
       VK_F3: if btnAlterar.Enabled then btnAlterar.Click;
       VK_F4: if btnExcluir.Enabled then btnExcluir.Click;
       VK_F5: if btnGravar.Enabled then btnGravar.Click;
       VK_F6: if btnCancelar.Enabled then btnCancelar.Click;
//       VK_F9: if btnPesq.Enabled then btnPesq.Click;
       VK_RETURN:  Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE: frmFone.Close;
     end;
end;

procedure TfrmFone.FormCreate(Sender: TObject);
begin
     StFig := 7;
     PosEnd := 0;
     cboEnd.Clear;
//     DM.cdsEnd.First;
//     while not DM.cdsEnd.Eof do
//     begin
//          cboEnd.Items.Add(Format('%.4d %20s',
//                      [DM.cdsEndCD_END.AsInteger,DM.cdsEndENDERECO.Value]));
//          if DM.cdsEndCD_END.AsInteger = DM.cdsFonCD_END.AsInteger
//          then PosEnd := cboEnd.Items.Count;
//          DM.cdsEnd.Next;
//     end;
end;

procedure TfrmFone.FormShow(Sender: TObject);
begin
//     cboTipo.ItemIndex := DM.cdsFonTP_FON.AsInteger;
//     cboEnd.ItemIndex := PosEnd - 1;
//     if DM.cdsEnd.IsEmpty
//     then StFig := 7
//     else StFig := 6;
//     btnAlterar.Enabled := not DM.cdsEnd.IsEmpty;
     btnExcluir.Enabled := btnAlterar.Enabled;
end;

procedure TfrmFone.NovoExecute(Sender: TObject);
begin
//     DM.cdsFon.Insert;
//     DM.cdsFonCD_COTA.Value := DM.cdsCotCD_COTA.Value;
//     DM.cdsFonCD_FON.AsInteger := DM.GeraCod('CD_FON','CJCBFON');
//     DM.cdsFonCD_END.AsInteger := 0;
//     cboTipo.SetFocus;
end;

procedure TfrmFone.AlteraExecute(Sender: TObject);
begin
//     DM.cdsFon.Edit;
//     cboTipo.SetFocus;
end;

procedure TfrmFone.ExcluiExecute(Sender: TObject);
begin
     StFig := 8;
     stBar.Panels[1].Text := 'Excluindo';
     stBar.Repaint;
     if Application.MessageBox('Confirma a exclusão?','Confirmação',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;
//     DM.cdsFon.Delete;
//     DM.cdsFon.ApplyUpdates(0);
     Sair.Execute;
end;

procedure TfrmFone.GravaExecute(Sender: TObject);
begin
     if txtFone.Text = ''
     then
         begin
              ShowMessage('Precisa informar TELEFONE!');
              Abort;
         end;
//     DM.cdsFonTP_FON.AsInteger := cboTipo.ItemIndex;
//     if cboEnd.ItemIndex >= 0
//     then DM.cdsFonCD_END.AsInteger := StrToInt(copy(cboEnd.Text,1,4));
//     DM.cdsFonENDERECO.Value := RightStr(cboEnd.Text,5);
//     DM.cdsFon.Post;
//     DM.cdsFon.ApplyUpdates(0);
end;

procedure TfrmFone.CancelaExecute(Sender: TObject);
begin
//     DM.cdsFon.Cancel;
end;

procedure TfrmFone.SairExecute(Sender: TObject);
begin
//     if DS.State in [dsInsert,dsEdit]
//     then DM.cdsEnd.Cancel;
//     DM.cdsFon.Refresh;
     Close;
end;

end.
