unit UnMld;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, DB, ActnList,
  ComCtrls, Grids, DBGrids, Menus, DateUtils;

type
  TfrmMld = class(TForm)
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
    grCar: TDBGrid;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    Label5: TLabel;
    Mala: TDBRichEdit;
    PP: TPopupMenu;
    Fontes1: TMenuItem;
    InserirCampos1: TMenuItem;
    Nome1: TMenuItem;
    Endereco1: TMenuItem;
    Bairro1: TMenuItem;
    Cidade1: TMenuItem;
    UF1: TMenuItem;
    CEP1: TMenuItem;
    Data1: TMenuItem;
    Fon: TAction;
    btnImp: TSpeedButton;
    ImpCar: TAction;
    RE: TRichEdit;
    Grupo1: TMenuItem;
    Sequencia1: TMenuItem;
    Cota1: TMenuItem;
    Complemento1: TMenuItem;
    dsM: TDataSource;
    tbCli: TTabSheet;
    Panel2: TPanel;
    grCon: TDBGrid;
    cbSelTodos: TCheckBox;
    procedure DSStateChange(Sender: TObject);
    procedure stBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SairExecute(Sender: TObject);
    procedure ExcluiExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NovoExecute(Sender: TObject);
    procedure GravaExecute(Sender: TObject);
    procedure CancelaExecute(Sender: TObject);
    procedure AlteraExecute(Sender: TObject);
    procedure FonExecute(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure ImpCarExecute(Sender: TObject);
    procedure grCarDblClick(Sender: TObject);
    procedure dsMStateChange(Sender: TObject);
    procedure grConDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grConCellClick(Column: TColumn);
    procedure grConTitleClick(Column: TColumn);
    procedure cbSelTodosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure TrocaCampo(Busca,Troca:String);
  end;

var
  frmMld: TfrmMld;
  StFig : Integer;

implementation

uses UnDM,  SqlExpr, DBClient;

{$R *.dfm}

procedure TfrmMld.DSStateChange(Sender: TObject);
const
     Estados : array [TDataSetState] of string =
   ('Fechado','Consultando','Alterando','Inserindo','','','','','','','','','');
begin
     btnIncluir.Enabled := DS.State in [dsBrowse,dsInactive];
     btnGravar.Enabled := DS.State in [dsInsert,dsEdit];
     btnCancelar.Enabled := DS.State in [dsInsert,dsEdit];
     btnExcluir.Enabled := DS.State in [dsBrowse];
     btnAlterar.Enabled := DS.State in [dsBrowse];
     btnImp.Enabled := not (DM.cdsTex.IsEmpty);
     if btnGravar.Enabled
     then StFig := 9
     else StFig := 6;
     stBar.Repaint;
     stBar.Panels[1].Text := Estados[DS.State];
end;

procedure TfrmMld.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left+1,Rect.Top,StFig);
end;

procedure TfrmMld.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F2: if btnIncluir.Enabled then btnIncluir.Click;
       VK_F3: if btnAlterar.Enabled then btnAlterar.Click;
       VK_F4: if btnExcluir.Enabled then btnExcluir.Click;
       VK_F5: if btnGravar.Enabled then btnGravar.Click;
       VK_F6: if btnCancelar.Enabled then btnCancelar.Click;
       VK_F7: if btnImp.Enabled then btnImp.Click;
       VK_RETURN: if not (Mala.Focused)
                  then Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE: btnSair.Click;
     end;
end;

procedure TfrmMld.SairExecute(Sender: TObject);
begin
     Close;
end;

procedure TfrmMld.ExcluiExecute(Sender: TObject);
begin
     StFig := 8;
     stBar.Panels[1].Text := 'Excluindo';
     stBar.Repaint;
     if Application.MessageBox('Confirma a exclusão?','Atenção',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;
     DM.cdsTex.Delete;
     DSStateChange(Self);
     PC.ActivePage := tbCon;
end;

procedure TfrmMld.FormCreate(Sender: TObject);
begin
     StFig := 7;
     PC.ActivePage := tbCon;
     if FileExists(DM.cdsTex.FileName)
     then DM.cdsTex.LoadFromFile;
//     DM.cdsMala.Open;
end;

procedure TfrmMld.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if DS.State in [dsInsert,dsEdit]
     then DM.cdsTex.Cancel;
//     DM.cdsMala.Close;
     DM.cdsTex.Close;
     DM.cdsTex.SaveToFile;
end;

procedure TfrmMld.NovoExecute(Sender: TObject);
begin
     if not DM.cdsTex.Active
     then DM.cdsTex.Open;
     DM.cdsTex.Insert;
     PC.ActivePage := tbFic;
     DBEdit1.SetFocus;
end;

procedure TfrmMld.GravaExecute(Sender: TObject);
begin
     if DBEdit2.Text = ''
     then
         begin
              Application.MessageBox('Necessário informar DESCRIÇÃO.','Atenção',
                                                 MB_ICONHAND+MB_OK);
              DBEdit2.SetFocus;
              Abort;
         end;
     if Application.MessageBox('Confirma a gravação dos dados?','Confirmação',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;
     DM.cdsTex.Post;
     PC.ActivePage := tbCon;
end;

procedure TfrmMld.CancelaExecute(Sender: TObject);
begin
     DM.cdsTex.Cancel;
end;

procedure TfrmMld.AlteraExecute(Sender: TObject);
begin
     DM.cdsTex.Edit;
     PC.ActivePage := tbFic;
     DBEdit2.SetFocus;
end;

procedure TfrmMld.FonExecute(Sender: TObject);
begin
     if DM.SelFon.Execute
     then
         begin
              Mala.SelAttributes.Color := DM.SelFon.Font.Color;
              Mala.SelAttributes.Size := DM.SelFon.Font.Size;
              Mala.SelAttributes.Style := DM.SelFon.Font.Style;
              Mala.SelAttributes.Name := DM.SelFon.Font.Name;
         end;
end;

procedure TfrmMld.MenuClick(Sender: TObject);
var
  Campo:String;
begin
     with Sender as TmenuItem do
          Campo := '<%'+Caption+'%>';
     Mala.SelText := Campo;
end;


procedure TfrmMld.ImpCarExecute(Sender: TObject);
const
     Campo1: array[1..11] of string = ('<%&Grupo%>','<%&Sequencia%>','<%&Cota%>',
             '<%&Nome%>','<%&Endereco%>','<%C&omplemento%>','<%&Bairro%>',
             '<%C&idade%>','<%&UF%>','<%CE&P%>','<%&Data%>');
     MesExt : array[1..12] of string = ('Janeiro','Fevereiro','Março','Abril',
     'Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro');
var
   I : Integer;
   Campo2 : array[1..11] of string;
   TextoInicial, TextoFormatado : TMemoryStream;
begin
     Campo2[1] := 'grupo';
     Campo2[2] := 'seq';
     Campo2[3] := 'cota';
     Campo2[4] := 'nome';
     Campo2[5] := 'endereco';
     Campo2[6] := 'complem';
     Campo2[7] := 'bairro';
     Campo2[8] := 'cidade';
     Campo2[9] := 'estado';
     Campo2[10] := 'cep';
     Campo2[11] := IntToStr(DayOf(Date))+' de '+MesExt[MonthOf(Date)]+
                   ' de '+IntToStr(YearOf(Date));
     TextoInicial := TMemoryStream.Create;
     TextoFormatado := TMemoryStream.Create;

     DM.cdsTexTexto.SaveToStream(TextoInicial);
     if not DM.cdsCar.Active
     then DM.cdsCar.Open;
     DM.cdsCar.EmptyDataSet;

     dsM.DataSet.DisableControls;
     dsM.DataSet.First;
     while not dsM.DataSet.Eof do
     begin
          if grCon.SelectedRows.CurrentRowSelected
          then
              begin
                   RE.Clear;
                   TextoInicial.Position := 0;
                   RE.Lines.LoadFromStream(TextoInicial);
                   for I := 1 to 11 do
//                   if I = 11
//                   then TrocaCampo(Campo1[I],Campo2[I])
//                   else TrocaCampo(Campo1[I],
//                        DM.cdsMala.FieldByName(Campo2[I]).AsString);
                   TextoFormatado.Clear;
                   RE.Lines.SaveToStream(TextoFormatado);
                   DM.cdsCar.Insert;
                   DM.cdsCarCarta.LoadFromStream(TextoFormatado);
                   DM.cdsCar.Post;
              end;
          dsM.DataSet.Next;
     end;

//     frmMala := TfrmMala.Create(Application);
//     try
//        frmMala.QR.Preview;
//     finally
//            frmMala.Free;
//     end;
//     DM.cdsCar.Close;
//
//     if Application.MessageBox('Atualiza os marcados para Carta Enviada?',
//        'Confirmação',MB_ICONQUESTION+MB_YESNO)=id_yes
//     then
//         begin
//              dsM.DataSet.First;
//              DM.cdsCnt.Open;
//              while not dsM.DataSet.Eof do
//              begin
//                   if grCon.SelectedRows.CurrentRowSelected
//                   then
//                       begin
//                            with DM.sqlCom do
//                            begin
//                             Close;
//                             SQL.Clear;
//                             SQL.Add('update CJCBCAM set status=1 where grupo='+
//                                             DM.cdsMalaGRUPO.Value+' and seq='+
//                                             DM.cdsMalaSEQ.Value+' and cota='+
//                                             DM.cdsMalaCOTA.Value);
//                             ExecSQL;
//                            end;
//
//                            with DM.cdsCot do
//                            begin
//                                 Close;
//                                 Params[0].Value := DM.cdsMalaGRUPO.Value;
//                                 Params[1].Value := DM.cdsMalaCOTA.Value;
//                                 Params[2].Value := DM.cdsMalaSEQ.Value;
//                                 Open;
//                            end;
//
//                            with DM.cdsCnt do
//                            begin
//                                 Insert;
//                                 DM.cdsCntCD_CTATO.AsInteger := DM.GeraCod('CD_CTATO','CJCBCNT');
//                                 DM.cdsCntCD_COTA.Value := DM.cdsCotCD_COTA.Value;
//                                 DM.cdsCntTP_CTATO.AsInteger := 2;
//                                 DM.cdsCntASSUNTO.Value := DM.cdsTexObs.Value;
//                                 DM.cdsCntDT_CTATO.AsDateTime := Date;
//                                 DM.cdsCntINICIO.Value := FormatDateTime('hhnn',Time);
//                                 DM.cdsCntTERMINO.Value := FormatDateTime('hhnn',Time);
//                                 Post;
//                                 ApplyUpdates(0);
//                            end;
//
//                       end;
//                   dsM.DataSet.Next;
//              end;
//              DM.cdsCnt.Close;
//         end;
//     DM.cdsMala.Refresh;
     cbSelTodos.Checked := False;
     cbSelTodosClick(Self);
     dsMStateChange(Self);
     dsM.DataSet.First;
     dsM.DataSet.EnableControls;

end;


procedure TfrmMld.TrocaCampo(Busca, Troca: String);
Var
   SelPos:Integer;
Begin
     SelPos := Pos(Busca,RE.Lines.Text);
     While Selpos > 0 do
     Begin
          RE.SelStart := SelPos - 1;
          RE.SelLength := Length(Busca);
          RE.SelText := Troca;
          SelPos := Pos(Busca,RE.Lines.Text);
     End;
End;


procedure TfrmMld.grCarDblClick(Sender: TObject);
begin
     PC.ActivePage := tbFic;
end;

procedure TfrmMld.dsMStateChange(Sender: TObject);
begin
//     btnImp.Enabled := not  DM.cdsMala.IsEmpty;
end;

procedure TfrmMld.grConDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
     if Column.Index = 0
     then
         begin
              if grCon.SelectedRows.CurrentRowSelected
              then DM.IL.Draw(grCon.Canvas,Rect.Left+3,Rect.Top + 1,20)
              else DM.IL.Draw(grCon.Canvas,Rect.Left+3,Rect.Top + 1,21);
         end;
end;

procedure TfrmMld.grConCellClick(Column: TColumn);
begin
     if Column.Index = 0
     then grCon.SelectedRows.CurrentRowSelected := not
                                  (grCon.SelectedRows.CurrentRowSelected);
     btnImp.Enabled := (grCon.SelectedRows.Count > 0);
end;

procedure TfrmMld.grConTitleClick(Column: TColumn);
begin
     if Column.Index = 0
     then
         begin
              cbSelTodos.Checked := not cbSelTodos.Checked;
              cbSelTodosClick(Self);
         end
     else
         if Column.Field.FieldKind = fkData
         then
             Begin
                  cbSelTodos.Checked := False;
                  cbSelTodosClick(Self);
//                  DM.cdsCCo.IndexFieldNames := Column.FieldName;
             end;
end;

procedure TfrmMld.cbSelTodosClick(Sender: TObject);
begin
     dsM.DataSet.DisableControls;
     dsM.DataSet.First;
     while not dsM.DataSet.Eof do
     begin
          grCon.SelectedRows.CurrentRowSelected := cbSelTodos.Checked;
          dsM.DataSet.Next;
     end;
     dsM.DataSet.First;
     dsM.DataSet.EnableControls;
end;

end.
