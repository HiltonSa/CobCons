unit UnModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, DB, ActnList,
  ComCtrls, Grids, DBGrids;

type
  TfrmMod = class(TForm)
    stBar: TStatusBar;
    AL: TActionList;
    Pesquisa: TAction;
    Novo: TAction;
    Altera: TAction;
    Exclui: TAction;
    Grava: TAction;
    Cancela: TAction;
    Sair: TAction;
    DS: TDataSource;
    Panel1: TPanel;
    btnGravar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnSair: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnIncluir: TSpeedButton;
    PC: TPageControl;
    tbCon: TTabSheet;
    tbFic: TTabSheet;
    grCon: TDBGrid;
    dsPesq: TDataSource;
    Panel2: TPanel;
    btnPesq: TSpeedButton;
    cboCampo: TComboBox;
    Label1: TLabel;
    cboRel: TComboBox;
    Label2: TLabel;
    txtPesq: TEdit;
    procedure DSStateChange(Sender: TObject);
    procedure stBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SairExecute(Sender: TObject);
    procedure ExcluiExecute(Sender: TObject);
    procedure PCChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure grConTitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMod: TfrmMod;
  StFig : Integer;

implementation

uses UnDM, UnPesq;

{$R *.dfm}

procedure TfrmMod.DSStateChange(Sender: TObject);
const
     Estados : array [TDataSetState] of string =
   ('Fechado','Consultando','Alterando','Inserindo','','','','','','','','','');
begin
     btnIncluir.Enabled := DS.State in [dsBrowse,dsInactive];
     btnGravar.Enabled := DS.State in [dsInsert,dsEdit];
     btnCancelar.Enabled := DS.State in [dsInsert,dsEdit];
     btnExcluir.Enabled := DS.State in [dsBrowse];
     btnAlterar.Enabled := DS.State in [dsBrowse];
     btnPesq.Enabled := btnIncluir.Enabled;
     if btnGravar.Enabled
     then StFig := 9
     else StFig := 6;
     stBar.Repaint;
     stBar.Panels[1].Text := Estados[DS.State];
end;

procedure TfrmMod.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left+1,Rect.Top,StFig);
end;

procedure TfrmMod.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F2: if btnIncluir.Enabled then btnIncluir.Click;
       VK_F3: if btnAlterar.Enabled then btnAlterar.Click;
       VK_F4: if btnExcluir.Enabled then btnExcluir.Click;
       VK_F5: if btnGravar.Enabled then btnGravar.Click;
       VK_F6: if btnCancelar.Enabled then btnCancelar.Click;
       VK_F9: if btnPesq.Enabled then btnPesq.Click;
       VK_RETURN: {if not ((Sender as TDBRichEdit).Focused)
                  then }Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE: btnSair.Click;
     end;
end;

procedure TfrmMod.SairExecute(Sender: TObject);
begin
     dsPesq.DataSet.Close;
     DM.cdsPesq.IndexFieldNames := '';
     Close;
end;

procedure TfrmMod.ExcluiExecute(Sender: TObject);
begin
     StFig := 8;
     stBar.Panels[1].Text := 'Excluindo';
     stBar.Repaint;
     if Application.MessageBox('Confirma a exclusão?','Atenção',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;
end;

procedure TfrmMod.PCChanging(Sender: TObject; var AllowChange: Boolean);
begin
     AllowChange := not (dsPesq.DataSet.IsEmpty);
end;

procedure TfrmMod.FormCreate(Sender: TObject);
begin
     StFig := 7;
     PC.ActivePage := tbCon;
end;

procedure TfrmMod.grConTitleClick(Column: TColumn);
begin
     if Column.Field.FieldKind = fkData
     then DM.cdsPesq.IndexFieldNames := Column.FieldName;
end;

end.
