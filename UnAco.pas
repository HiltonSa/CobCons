unit UnAco;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  JvDBDatePickerEdit, JvDatePickerEdit, JvCheckedMaskEdit, JvMaskEdit, JvDBControls, JvBaseEdits, JvToolEdit, JvExMask, Mask,
{$ELSE}
  MaskEdit,
{$ENDIF}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Buttons, ExtCtrls, ComCtrls, DB, StdCtrls,
  DBCtrls, Grids, DBGrids;

type
  TfrmAco = class(TForm)
    stBar: TStatusBar;
    Panel1: TPanel;
    btnGravar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnSair: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnIncluir: TSpeedButton;
    AL: TActionList;
    Pesquisa: TAction;
    Novo: TAction;
    Exclui: TAction;
    Grava: TAction;
    Cancela: TAction;
    Sair: TAction;
    Panel2: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DS: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    txtPcl: TDBEdit;
    Label4: TLabel;
    txtVenc: TDBEdit;
    DBGrid1: TDBGrid;
    dsPcl: TDataSource;
    Label5: TLabel;
    Par: TAction;
    btnPar: TSpeedButton;
    Label6: TLabel;
    Panel3: TPanel;
    DBEdit11: TDBEdit;
    Label10: TLabel;
    DBEdit13: TDBEdit;
    Label12: TLabel;
    DBEdit21: TDBEdit;
    Label21: TLabel;
    txtTot: TMaskEdit;
    Label14: TLabel;
    dsTot: TDataSource;
    dsCot: TDataSource;
    JvDBCalcEdit1: TJvDBCalcEdit;
    dbEdit2: TJvDBDatePickerEdit;
    procedure DSDataChange(Sender: TObject; Field: TField);
    procedure stBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure GravaExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure ExcluiExecute(Sender: TObject);
    procedure CancelaExecute(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure ParExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAco: TfrmAco;
  StFig : Integer;

implementation

uses
{$IFnDEF FPC}
  SqlExpr,
{$ELSE}
  sqldb,
{$ENDIF}
  UnDm, UnPar;

{$R *.dfm}

procedure TfrmAco.DSDataChange(Sender: TObject; Field: TField);
const
     Estados : array [TDataSetState] of string =
   ('Fechado','Consultando','Alterando','Inserindo','','','','','','','','','');
begin
     btnIncluir.Enabled := DS.State in [dsBrowse,dsInactive];
     btnGravar.Enabled := DS.State in [dsInsert,dsEdit];
     btnCancelar.Enabled := DS.State in [dsInsert,dsEdit];
     btnExcluir.Enabled := DS.State in [dsBrowse];
//     btnPar.Enabled := (btnExcluir.Enabled) and (not DM.cdsPcl.IsEmpty);
     if btnGravar.Enabled
     then StFig := 9
     else StFig := 6;
     stBar.Repaint;
     stBar.Panels[1].Text := Estados[DS.State];
end;


procedure TfrmAco.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left+1,Rect.Top,StFig);
end;

procedure TfrmAco.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F2: if btnIncluir.Enabled then btnIncluir.Click;
//       VK_F3: if btnAlterar.Enabled then btnAlterar.Click;
       VK_F4: if btnExcluir.Enabled then btnExcluir.Click;
       VK_F5: if btnGravar.Enabled then btnGravar.Click;
       VK_F6: if btnCancelar.Enabled then btnCancelar.Click;
       VK_F7: if btnPar.Enabled then btnPar.Click;
       VK_RETURN: SelectNext(ActiveControl,True,True);
       VK_ESCAPE: frmAco.Close;
     end;
end;

procedure TfrmAco.FormShow(Sender: TObject);
begin
//     if DM.cdsAco.IsEmpty
//     then StFig := 7
//     else StFig := 6;
//     txtTot.Text := Format('%10.2n',[DM.sdsTotPenTOT.AsFloat+DM.cdsCotHONOR.AsFloat]);
end;

procedure TfrmAco.NovoExecute(Sender: TObject);
begin
//     DM.cdsAco.Insert;
//     DM.cdsAcoCD_COTA.Value := DM.cdsCotCD_COTA.Value;
//     DM.cdsAcoCD_ACORDO.AsInteger := DM.GeraCod('CD_ACORDO','CJCBACO');
//     DM.cdsAcoDT_ACO.AsDateTime := Date;
//     DM.cdsAcoP_VENCTO.Value := DM.cdsAcoDT_ACO.Value;
//     DM.cdsAcoVALOR.AsFloat := DM.sdsTotPenVAL.AsFloat + DM.sdsTotPenMUL.AsFloat +
//                             DM.cdsCotHONOR.AsFloat;
//     DBEdit2.SetFocus;
end;

procedure TfrmAco.GravaExecute(Sender: TObject);
var
   IncPar : Boolean;
   Menor : Double;
   I : Integer;
begin
//     if (DM.cdsAcoVALOR.Value=0) or (DM.cdsAcoPARCELAS.AsInteger=0) or (DM.cdsAcoP_VENCTO.IsNull)
//     then
//         begin
//              ShowMessage('Precisa informar VALOR, PARCELAS E VENCTO!');
//              Abort;
//         end;
//
//     Menor := DM.cdsAcoVALOR.AsFloat - DM.sdsTotPenVAL.AsFloat;
//     if Menor < 0
//     then ShowMessage('Valor do ACORDO é menor que o valor das PARCELAS');
//
//     IncPar := (DS.State = dsInsert);
//     DM.cdsAco.Post;
//     DM.cdsAco.ApplyUpdates(0);
//
//     if IncPar
//     then
//         begin
//              for I := 1 to DM.cdsAcoPARCELAS.AsInteger do
//              begin
//                   with DM.cdsPcl do
//                   begin
//                        Insert;
//                        DM.cdsPclCD_ACORDO.Value := DM.cdsAcoCD_ACORDO.Value;
//                        DM.cdsPclPARCELA.AsInteger := I;
//                        DM.cdsPclVENCTO.AsDateTime := IncMonth(DM.cdsAcoP_VENCTO.AsDateTime,(I-1));
//                        if Menor < 0
//                        then DM.cdsPclVALOR.Value := DM.cdsAcoVALOR.AsFloat /
//                                                  DM.cdsAcoPARCELAS.AsInteger
//                        else DM.cdsPclVALOR.Value := DM.sdsTotPenVAL.AsFloat /
//                                                  DM.cdsAcoPARCELAS.AsInteger;
//                        DM.cdsPclPC_BEM.Value := DM.cdsCotPC_DEV.AsFloat /
//                                                 DM.cdsAcoPARCELAS.AsInteger;
//                        if Menor <= 0
//                        then DM.cdsPclVL_ADI.Value := 0
//                        else DM.cdsPclVL_ADI.Value := Menor / DM.cdsAcoPARCELAS.AsInteger;
//                        DM.cdsPcl.Post;
//                        DM.cdsPcl.ApplyUpdates(0);
//                   end;
//              end;
//         end;
//     DM.cdsAco.Refresh;
end;

procedure TfrmAco.SairExecute(Sender: TObject);
begin
//     if DS.State in [dsInsert,dsEdit]
//     then DM.cdsAco.Cancel;
     Close;
end;

procedure TfrmAco.ExcluiExecute(Sender: TObject);
begin
     StFig := 8;
     stBar.Panels[1].Text := 'Excluindo';
     stBar.Repaint;

//     with DM.sqlCom do
//     begin
//          Close;
//          SQL.Clear;
//          SQL.Add('select * from CJCBPCL where RECIBO > 0 and CD_ACORDO='+
//                          DM.cdsAcoCD_ACORDO.AsString);
//          Open;
//          if not IsEmpty
//          then
//              begin
//                   ShowMessage('Existem parcelas pagas no acordo!');
//                   Abort;
//              end;
//     end;

     if Application.MessageBox('Confirma a exclusão?','Confirmação',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;

//     with DM.sqlCom do
//     begin
//          Close;
//          SQL.Clear;
//          SQL.Add('delete from CJCBPCL where CD_ACORDO='+DM.cdsAcoCD_ACORDO.AsString);
//          ExecSQL;
//     end;
//
//     DM.cdsAco.Delete;
//     DM.cdsAco.ApplyUpdates(0);
//     DM.cdsAco.Refresh;
end;

procedure TfrmAco.CancelaExecute(Sender: TObject);
begin
//     DM.cdsAco.Cancel;
end;

procedure TfrmAco.DBGrid1DblClick(Sender: TObject);
begin
     Par.Execute;
end;

procedure TfrmAco.ParExecute(Sender: TObject);
begin
//     if DM.cdsPclRECIBO.AsInteger = 0
//     then DM.CriaForm(TfrmPar,frmPar);
end;

end.
