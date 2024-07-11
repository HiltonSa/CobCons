unit UnCam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, DB, StdCtrls, Grids, DBGrids, ComCtrls, Buttons,
  ExtCtrls, DBCtrls, Mask;

type
  TfrmCam = class(TForm)
    stBar: TStatusBar;
    Panel1: TPanel;
    btnSair: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnIncluir: TSpeedButton;
    DS: TDataSource;
    AL: TActionList;
    Pesquisa: TAction;
    Contatar: TAction;
    Exclui: TAction;
    Sair: TAction;
    Panel2: TPanel;
    Label1: TLabel;
    cboSit: TComboBox;
    cbSelTodos: TCheckBox;
    grCon: TDBGrid;
    Importar: TAction;
    btImp: TSpeedButton;
    Carta: TAction;
    btnCarta: TSpeedButton;
    RestCam: TAction;
    procedure cboSitChange(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure DSStateChange(Sender: TObject);
    procedure stBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ExcluiExecute(Sender: TObject);
    procedure PCChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure grConTitleClick(Column: TColumn);
    procedure grConDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grConCellClick(Column: TColumn);
    procedure cbSelTodosClick(Sender: TObject);
    procedure ContatarExecute(Sender: TObject);
    procedure PesquisaExecute(Sender: TObject);
    procedure grConDblClick(Sender: TObject);
    procedure ImpCota(Grupo,Seq,Cota:String);
    procedure AltStatus(Sta:Integer);
    procedure CartaExecute(Sender: TObject);
    procedure RestCamExecute(Sender: TObject);
    procedure ImportarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCam: TfrmCam;
  StFig : Integer;

implementation

uses UnDm, DBClient, SqlExpr, UnCli;

{$R *.dfm}

procedure TfrmCam.cboSitChange(Sender: TObject);
begin
//     with DM.cdsCCo do
//     begin
//          Close;
//          Params[0].AsBCD := cboSit.ItemIndex;
//          Open;
//     end;

end;

procedure TfrmCam.SairExecute(Sender: TObject);
begin
//     if DS.State in [dsInsert, dsBrowse]
//     then DM.cdsCCo.Cancel;
//     DM.cdsCCo.Close;
     Close;
end;

procedure TfrmCam.DSStateChange(Sender: TObject);
const
     Estados : array [TDataSetState] of string =
   ('Fechado','Consultando','Alterando','Inserindo','','','','','','','','','');
begin
//     if DM.cdsCCo.IsEmpty
//     then StFig := 21
//     else StFig := 20;
     stBar.Repaint;
     stBar.Panels[1].Text := Estados[DS.State];
//     btnIncluir.Enabled := not DM.cdsCCo.IsEmpty;
end;

procedure TfrmCam.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left+1,Rect.Top,StFig);
end;

procedure TfrmCam.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F9: if btnIncluir.Enabled then btnIncluir.Click;
       VK_F3: if btnAlterar.Enabled then btnAlterar.Click;
       VK_F4: if btnExcluir.Enabled then btnExcluir.Click;
       VK_F5: if btImp.Enabled then btImp.Click;
       VK_F6: if btnCarta.Enabled then Carta.Execute;
       VK_RETURN:  Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE: btnSair.Click;
     end;
end;

procedure TfrmCam.ExcluiExecute(Sender: TObject);
begin
     StFig := 8;
     stBar.Panels[1].Text := 'Excluindo';
     stBar.Repaint;

     if Application.MessageBox('Confirma a exclusão dos marcados?','Atenção',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;

//     DS.DataSet.DisableControls;
//     DS.DataSet.First;
//     while not DS.DataSet.Eof do
//     begin
//          if grCon.SelectedRows.CurrentRowSelected
//          then
//              begin
//                   with DM.cdsCot do
//                   begin
//                        Close;
//                        Params[0].Value := DM.cdsCCoGRUPO.Value;
//                        Params[1].Value := DM.cdsCCoCOTA.Value;
//                        Params[2].Value := DM.cdsCCoSEQ.Value;
//                        Open;
//                   end;
//
//                   with dm.cdsCnt do
//                   begin
//                        Close;
//                        Params[0].AsFMTBCD := dm.cdsCotCD_COTA.Value;
//                        Open;
//                   end;
//
//                   if DM.cdsCnt.IsEmpty
//                   then
//                       begin
//                            with DM.sqlCom do
//                            begin
//                                 Close;
//                                 SQL.Clear;
//                                 SQL.Add('delete from CJCBEND where CD_COTA='+
//                                       IntToStr(DM.cdsCotCD_COTA.AsInteger));
//                                 ExecSQL;
//                                 SQL.Clear;
//                                 SQL.Add('delete from CJCBFON where CD_COTA='+
//                                       IntToStr(DM.cdsCotCD_COTA.AsInteger));
//                                 ExecSQL;
//                                 SQL.Clear;
//                                 SQL.Add('delete from CJCBPEN where CD_COTA='+
//                                       IntToStr(DM.cdsCotCD_COTA.AsInteger));
//                                 ExecSQL;
//                                 SQL.Clear;
//                                 SQL.Add('delete from CJCBCNT where CD_COTA='+
//                                       IntToStr(DM.cdsCotCD_COTA.AsInteger));
//                                 ExecSQL;
//                            end;
//                            DM.cdsCot.Delete;
//                            DM.cdsCCo.Delete;
//                       end;
//                   grCon.SelectedRows.CurrentRowSelected := False;
//              end
//          else DS.DataSet.Next;
//     end;
//     DM.cdsCot.ApplyUpdates(0);
//     DM.cdsCCo.ApplyUpdates(0);
//     DM.cdsCCo.Refresh;
//     cbSelTodos.Checked := False;
//     cbSelTodosClick(Self);
//     DS.DataSet.First;
     DSStateChange(Self);
     DS.DataSet.EnableControls;
end;

procedure TfrmCam.PCChanging(Sender: TObject; var AllowChange: Boolean);
begin
     AllowChange := not (DS.DataSet.IsEmpty);
end;

procedure TfrmCam.FormCreate(Sender: TObject);
begin
     StFig := 21;
     RestCam.Enabled := (DM.UsuAdm = 1);
end;

procedure TfrmCam.grConTitleClick(Column: TColumn);
begin
     if Column.Index = 0
     then
         begin
              cbSelTodos.Checked := not cbSelTodos.Checked;
              cbSelTodosClick(Self);
//              AtualizaMarcados;
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

procedure TfrmCam.grConDrawColumnCell(Sender: TObject; const Rect: TRect;
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

procedure TfrmCam.grConCellClick(Column: TColumn);
begin
     if Column.Index = 0
     then grCon.SelectedRows.CurrentRowSelected := not
                                  (grCon.SelectedRows.CurrentRowSelected);
     btnExcluir.Enabled := (grCon.SelectedRows.Count > 0);
     btnAlterar.Enabled := btnExcluir.Enabled;
     btnCarta.Enabled := btnExcluir.Enabled;
     btImp.Enabled := (grCon.SelectedRows.Count = 1);
end;

procedure TfrmCam.cbSelTodosClick(Sender: TObject);
begin
     DS.DataSet.DisableControls;
     DS.DataSet.First;
     while not DS.DataSet.Eof do
     begin
          grCon.SelectedRows.CurrentRowSelected := cbSelTodos.Checked;
          DS.DataSet.Next;
     end;
     DS.DataSet.First;
     DS.DataSet.EnableControls;
end;

procedure TfrmCam.ContatarExecute(Sender: TObject);
begin
     AltStatus(1);
end;

procedure TfrmCam.PesquisaExecute(Sender: TObject);
begin
     DM.CriaForm(TfrmCli,frmCli);
end;

procedure TfrmCam.grConDblClick(Sender: TObject);
begin
     btnIncluir.Click;
end;

procedure TfrmCam.ImpCota(Grupo, Seq, Cota: String);
var
   DtVen : TDateTime;
   PcDev : Double;
begin
     with DM.qryImpCot do
     begin
          Close;
          SQL.Strings[8] := 'from a2cob cob, a2cli cli, actsg seg';
          Params[0].Value := Grupo;
          Params[1].Value := Seq;
          Params[2].Value := Cota;
          Open;
          if IsEmpty
          then
              begin
                   Close;
                   SQL.Strings[8] := 'from accob cob, accli cli, actsg seg';
                   Params[0].Value := Grupo;
                   Params[1].Value := Seq;
                   Params[2].Value := Cota;
                   Open;
              end;
     end;


     if DM.qryImpCot.IsEmpty
     then Abort;

     with DM.sqlCom do
     begin
          Close;
          SQL.Clear;
          SQL.Add('select max(d_vencto) from acreu where grupo='+
                         QuotedStr(DM.qryImpCotGRUPO.Value));
          Open;
          if IsEmpty
          then
              begin
                   Close;
                   SQL.Clear;
                   SQL.Add('select max(d_vencto) from a2reu where grupo='+
                               QuotedStr(DM.qryImpCotGRUPO.Value));
                   Open;
              end;
     end;
     DtVen := DM.sqlCom.Fields[0].AsDateTime;

     with DM.cdsCot do
     begin
          Close;
          Params[0].Value := DM.qryImpCotGRUPO.Value;
          Params[1].Value := DM.qryImpCotCOTA.Value;
          Params[2].Value := DM.qryImpCotSEQ.Value;
          Open;
     end;

     with DM.sqlCom do
     begin
          Close;
          SQL.Clear;
          SQL.Add('delete from CJCBPEN where CD_COTA='+
              QuotedStr(DM.cdsCotCONTRATO.Value));
          ExecSQL;
     end;

     while not DM.qryImpCot.Eof do
     begin
          with DM.cdsCons do
          begin
               Close;
               CommandText := 'select * from CJCBPEN where cd_cota='+
                          QuotedStr(DM.cdsCotCOTA.AsString)+' and aviso='+
                           DM.qryImpCotAVISO.Value;
               Open;
          end;
//          if DM.cdsCons.IsEmpty
//          then
//              begin
//                   if not DM.cdsPen.Active then DM.cdsPen.Open;
//                   DM.cdsPen.Insert;
//                   DM.cdsPenCD_COB.AsInteger := DM.GeraCod('CD_COB','CJCBPEN');
//                   DM.cdsPenCD_COTA.Value := DM.cdsCotCD_COTA.Value;
//              end
//          else DM.cdsPen.Edit;
//          DM.cdsPenAVISO.Value := DM.qryImpCotAVISO.Value;
//          DM.cdsPenTP_MOV.Value := DM.qryImpCotTIPO_MOV.Value;
//          if DM.qryImpCotD_VENCTO.AsDateTime =  StrToDate('31/12/2049')
//          then DM.cdsPenDT_VENC.AsDateTime := DtVen
//          else DM.cdsPenDT_VENC.AsDateTime := DM.qryImpCotD_VENCTO.AsDateTime;
//          DM.cdsPenPC_NOR.Value := DM.qryImpCotP_NORMAL.Value;
//          DM.cdsPenPC_DIF.Value := DM.qryImpCotP_DIFER.Value;
//          DM.cdsPenVL_AQU.Value := DM.qryImpCotF_AQUISI.AsCurrency;
//          DM.cdsPenVL_ADM.Value := DM.qryImpCotADMINIST.AsCurrency;
//          DM.cdsPenVL_RES.Value := DM.qryImpCotF_RESERV.AsCurrency;
//          DM.cdsPenVL_OUT.Value := DM.qryImpCotOUTROS.AsCurrency;
//          DM.cdsPenSEGOUT.Value := DM.qryImpCotSEG_OUT.Value;
//          DM.cdsPenVL_MULJU.AsFloat := DM.CalcJur(DM.cdsPenDT_VENC.AsDateTime,Date,
//                                             (DM.qryImpCotF_AQUISI.AsFloat+
//                                             DM.qryImpCotADMINIST.AsFloat +
//                                             DM.qryImpCotF_RESERV.AsFloat +
//                                             DM.qryImpCotOUTROS.AsFloat));
//          DM.cdsPen.Post;
//          DM.cdsPen.ApplyUpdates(0);
          DM.qryImpCot.Next;
     end;

//     DM.AtualizaPendencia(DM.cdsCotDATREF.AsDateTime,DM.cdsCotCD_COTA.AsInteger);

//     with DM.sdsTotPen do
//     begin
//          Close;
//          DataSet.Params[0].AsFMTBCD := dm.cdsCotCD_COTA.Value;
//          Open;
//     end;
end;

procedure TfrmCam.AltStatus(Sta: Integer);
begin
     StFig := 9;
     stBar.Panels[1].Text := 'Alterando';
     stBar.Repaint;

     if Application.MessageBox('Confirma a alteração dos marcados?','Atenção',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;

//     DS.DataSet.DisableControls;
//     DS.DataSet.First;
//     while not DS.DataSet.Eof do
//     begin
//          if grCon.SelectedRows.CurrentRowSelected
//          then
//              begin
//                   DM.cdsCCo.Edit;
//                   DM.cdsCCoSTATUS.AsInteger := Sta;
//                   DM.cdsCCo.Post;
//              end;
//          DS.DataSet.Next;
//     end;
//     DM.cdsCCo.ApplyUpdates(0);
//     DM.cdsCCo.Refresh;
//     cbSelTodos.Checked := False;
//     cbSelTodosClick(Self);
//     DSStateChange(Self);
//     DS.DataSet.First;
//     DS.DataSet.EnableControls;
end;

procedure TfrmCam.CartaExecute(Sender: TObject);
begin
     AltStatus(5);
end;

procedure TfrmCam.RestCamExecute(Sender: TObject);
begin
     if Application.MessageBox('Confirma a Restauração de CJCBCAM?','Atenção',
        MB_ICONEXCLAMATION+MB_YESNO)=id_no
     then Abort;

//     with DM.sqlCom do
//     begin
//          Close;
//          SQL.Clear;
//          SQL.Add('select GRUPO,SEQ,COTA from CJCBCOT order by GRUPO,SEQ,COTA');
//          Open;
//     end;
//     while not DM.sqlCom.Eof do
//     begin
//          with DM.cdsCons do
//          begin
//               Close;
//               CommandText := 'select * from CJCBCAM where grupo='+
//                           DM.sqlCom.Fields[0].AsString+' and seq='+
//                           DM.sqlCom.Fields[1].AsString+' and cota='+
//                           DM.sqlCom.Fields[2].AsString;
//               Open;
//               if DM.cdsCons.IsEmpty
//               then
//                   begin
//                        if not DM.cdsCCo.Active then DM.cdsCCo.Open;
//                        DM.cdsCCo.Insert;
//                        DM.cdsCCoGRUPO.Value := DM.sqlCom.Fields[0].AsString;
//                        DM.cdsCCoSEQ.Value := DM.sqlCom.Fields[1].AsString;
//                        DM.cdsCCoCOTA.Value := DM.sqlCom.Fields[2].AsString;
//                        DM.cdsCCoCONTATO.AsInteger := 0;
//                        DM.cdsCCoSTATUS.AsInteger := 0;
//                        DM.cdsCCo.Post;
//                        DM.cdsCCo.ApplyUpdates(0);
//                   end;
//          end;
//
//          DM.sqlCom.Next;
//     end;
//     DM.cdsCCo.Close;
//     DM.cdsCCo.Open;
end;

procedure TfrmCam.ImportarExecute(Sender: TObject);
begin
     if Application.MessageBox('Confirma a importação das pendencias?','Confirmação',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;

//     DS.DataSet.DisableControls;
//     DS.DataSet.First;
//     while not DS.DataSet.Eof do
//     begin
//          if grCon.SelectedRows.CurrentRowSelected
//          then ImpCota(DM.cdsCCoGRUPO.Value,DM.cdsCCoSEQ.Value,DM.cdsCCoCOTA.Value);
//          DS.DataSet.Next;
//     end;
//     DM.cdsCCo.ApplyUpdates(0);
//     DM.cdsCCo.Refresh;
//     cbSelTodos.Checked := False;
//     cbSelTodosClick(Self);
//     DSStateChange(Self);
//     DS.DataSet.First;
//     DS.DataSet.EnableControls;
//     Application.MessageBox('Fim de importação!','Atenção',MB_ICONHAND+MB_OK);
end;

end.
