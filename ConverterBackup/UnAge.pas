unit UnAge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, DB, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids,
  StdCtrls, DBCtrls;

type
  TfrmAge = class(TForm)
    grCon: TDBGrid;
    stBar: TStatusBar;
    Panel1: TPanel;
    btnSair: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnIncluir: TSpeedButton;
    Panel2: TPanel;
    DS: TDataSource;
    AL: TActionList;
    Pesquisa: TAction;
    Contatar: TAction;
    Exclui: TAction;
    Sair: TAction;
    Importar: TAction;
    dt1: TDateTimePicker;
    Panel3: TPanel;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    dt2: TDateTimePicker;
    Label3: TLabel;
    procedure SairExecute(Sender: TObject);
    procedure DSStateChange(Sender: TObject);
    procedure stBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure grConTitleClick(Column: TColumn);
    procedure PesquisaData(Dt, Dt2: TDate);
    procedure PesquisaExecute(Sender: TObject);
    procedure grConDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ContatarExecute(Sender: TObject);
    procedure ExcluiExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAge: TfrmAge;
  StFig : Integer;

implementation

uses UnDm, DBClient, UnCli;

{$R *.dfm}

procedure TfrmAge.SairExecute(Sender: TObject);
begin
     if DS.State in [dsInsert, dsBrowse]
     then DM.cdsAge.Cancel;
     DM.cdsAge.Close;
     Close;
end;

procedure TfrmAge.DSStateChange(Sender: TObject);
const
     Estados : array [TDataSetState] of string =
   ('Fechado','Consultando','Alterando','Inserindo','','','','','','','','','');
begin
     if DM.cdsAge.IsEmpty
     then StFig := 7
     else StFig := 6;
     stBar.Repaint;
     stBar.Panels[1].Text := Estados[DS.State];
end;

procedure TfrmAge.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left+1,Rect.Top,StFig);
end;

procedure TfrmAge.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F9: if btnIncluir.Enabled then btnIncluir.Click;
       VK_F3: if btnAlterar.Enabled then btnAlterar.Click;
       VK_F4: if btnExcluir.Enabled then btnExcluir.Click;
//       VK_F5: if btImp.Enabled then btImp.Click;
       VK_RETURN:  Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE: btnSair.Click;
     end;
end;

procedure TfrmAge.FormCreate(Sender: TObject);
begin
     StFig := 7;
     dt1.Date := (Date-3);
     dt2.Date := (Date+5);
     PesquisaData(dt1.Date, dt2.Date);
end;

procedure TfrmAge.grConTitleClick(Column: TColumn);
begin
     if Column.Index = 0
     then DM.cdsAge.IndexFieldNames := 'PRIORIDADE'
     else if Column.Field.FieldKind = fkData
          then DM.cdsAge.IndexFieldNames := Column.FieldName;
end;

procedure TfrmAge.PesquisaData(Dt, Dt2: TDate);
begin
     with DM.cdsAge do
     begin
          Close;
          Params[0].Value := DM.UsuCod;
          Params[1].Value := DateToStr(Dt);
          Params[2].Value := DateToStr(Dt2);
          Open;
     end;
end;

procedure TfrmAge.PesquisaExecute(Sender: TObject);
begin
     PesquisaData(dt1.Date, dt2.Date);
end;

procedure TfrmAge.grConDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
     if Column.Index = 0
     then
         begin
              case DM.cdsAgePRIORIDADE.AsInteger of
                0: grCon.Canvas.Brush.Color := clRed;
                1: grCon.Canvas.Brush.Color := clYellow;
                2: grCon.Canvas.Brush.Color := clGreen;
              end;
              grCon.Canvas.FillRect(Rect);
        end;
end;

procedure TfrmAge.ContatarExecute(Sender: TObject);
begin
     if DM.cdsAgeCD_CTRATO.Value = '' then Abort;
     DM.CriaForm(TfrmCli,frmCli);
end;

procedure TfrmAge.ExcluiExecute(Sender: TObject);
begin
     if DM.cdsAgeSTATUS.AsInteger = 1 then Abort;
     if Application.MessageBox('Confirma a Realização do compromisso?',
        'Confirmação',MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;
     DM.cdsAge.Edit;
     DM.cdsAgeSTATUS.AsInteger := 1;
     DM.cdsAge.Post;
     DM.cdsAge.ApplyUpdates(0);
end;

end.
