unit UnEnd;

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
  Dialogs, ActnList, Buttons, ExtCtrls, ComCtrls, DB, StdCtrls,
  DBCtrls;

type
  TfrmEnd = class(TForm)
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
    dsCot: TDataSource;
    Panel2: TPanel;
    Label1: TLabel;
    txtEnd: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    txtCid: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    txtCep: TDBEdit;
    cboTipo: TComboBox;
    Label7: TLabel;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEnd: TfrmEnd;
  StFig : Integer;

implementation

uses UnDm;

{$R *.dfm}

procedure TfrmEnd.DSStateChange(Sender: TObject);
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

procedure TfrmEnd.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left+1,Rect.Top,StFig);
end;

procedure TfrmEnd.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F2: if btnIncluir.Enabled then btnIncluir.Click;
       VK_F3: if btnAlterar.Enabled then btnAlterar.Click;
       VK_F4: if btnExcluir.Enabled then btnExcluir.Click;
       VK_F5: if btnGravar.Enabled then btnGravar.Click;
       VK_F6: if btnCancelar.Enabled then btnCancelar.Click;
//       VK_F9: if btnPesq.Enabled then btnPesq.Click;
       VK_RETURN:  SelectNext(ActiveControl,True,True);
       VK_ESCAPE: frmEnd.Close;
     end;
end;

procedure TfrmEnd.FormCreate(Sender: TObject);
begin
     StFig := 7;
end;

procedure TfrmEnd.FormShow(Sender: TObject);
begin
//     cboTipo.ItemIndex := DM.cdsEndTP_END.AsInteger;
//     if DM.cdsEnd.IsEmpty
//     then StFig := 7
//     else StFig := 6;
//     btnAlterar.Enabled := not DM.cdsEnd.IsEmpty;
     btnExcluir.Enabled := btnAlterar.Enabled;
end;

procedure TfrmEnd.NovoExecute(Sender: TObject);
begin
//     DM.cdsEnd.Insert;
//     DM.cdsEndCD_COTA.Value := DM.cdsCotCD_COTA.Value;
//     DM.cdsEndCD_END.AsInteger := DM.GeraCod('CD_END','CJCBEND');
//     cboTipo.SetFocus;
end;

procedure TfrmEnd.GravaExecute(Sender: TObject);
begin
     if (txtEnd.Text = '') or (txtCid.Text = '') or (txtCep.Text = '')
     then
         begin
              ShowMessage('Precisa informar ENDEREÇO, CIDADE E CEP!');
              Abort;
         end;
//     DM.cdsEndTP_END.AsInteger := cboTipo.ItemIndex;
//     DM.cdsEnd.Post;
//     DM.cdsEnd.ApplyUpdates(0);
end;

procedure TfrmEnd.SairExecute(Sender: TObject);
begin
//     if DS.State in [dsInsert,dsEdit]
//     then DM.cdsEnd.Cancel;
     Close;
end;

procedure TfrmEnd.AlteraExecute(Sender: TObject);
begin
//     DM.cdsEnd.Edit;
     cboTipo.SetFocus;
end;

procedure TfrmEnd.ExcluiExecute(Sender: TObject);
begin
     StFig := 8;
     stBar.Panels[1].Text := 'Excluindo';
     stBar.Repaint;
     if Application.MessageBox('Confirma a exclusão?','Confirmação',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;
//     DM.cdsEnd.Delete;
//     DM.cdsEnd.ApplyUpdates(0);
end;

procedure TfrmEnd.CancelaExecute(Sender: TObject);
begin
//     DM.cdsEnd.Cancel;
end;

end.
