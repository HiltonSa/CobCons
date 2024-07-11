unit UnRec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, DB, Buttons, ExtCtrls, ComCtrls, StdCtrls, Mask,
  DBCtrls;

type
  TfrmRec = class(TForm)
    stBar: TStatusBar;
    Panel1: TPanel;
    btnGravar: TSpeedButton;
    btnSair: TSpeedButton;
    DS: TDataSource;
    AL: TActionList;
    Grava: TAction;
    Sair: TAction;
    Panel2: TPanel;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Panel3: TPanel;
    DBEdit3: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure SairExecute(Sender: TObject);
    procedure GravaExecute(Sender: TObject);
    procedure DSDataChange(Sender: TObject; Field: TField);
    procedure stBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRec: TfrmRec;
  StFig : Integer;

implementation

uses UnDm;

{$R *.dfm}

procedure TfrmRec.SairExecute(Sender: TObject);
begin
//     if DS.DataSet.State = dsEdit
//     then DM.cdsPcl.Cancel;
     Close;
end;

procedure TfrmRec.GravaExecute(Sender: TObject);
const
   MesExt : array[1..12] of string = ('Janeiro','Fevereiro','Março','Abril',
     'Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro');
var
   dia,mes,ano : Word;
begin
//     if DM.cdsPclVALPG.Value < DM.cdsPclTotal.Value
//     then
//         begin
//              ShowMessage('Valor pago menor que o devido!');
//              DBEdit6.SelectAll;
//              DBEdit6.SetFocus;
//              Abort;
//         end;
//
     if Application.MessageBox('Confirma o Recebimento?','Atenção',
        MB_ICONQUESTION+MB_YESNO)<>id_yes
     then Abort;

//     DM.cdsPclRECIBO.AsInteger := DM.GeraCod('RECIBO','CJCBPCL');
//     DM.cdsPcl.Post;
//     DM.cdsPcl.ApplyUpdates(0);
//     DM.cdsCot.Edit;
//     DM.cdsCotPC_PAGO.Value := DM.cdsCotPC_PAGO.AsFloat + DM.cdsPclPC_BEM.AsFloat;
//     DM.cdsCotPC_DEV.Value := 100 - DM.cdsCotPC_PAGO.AsFloat;
//     DM.cdsCot.Post;
//     DM.cdsCot.ApplyUpdates(0);
//     frmRecibo := TfrmRecibo.Create(Self);
//     try
//        frmRecibo.lblTit.Caption := Format('RECIBO %.4d',[DM.cdsPclRECIBO.AsInteger]);
//        frmRecibo.lblTexto.Caption := Format('Recebemos do Sr(a). %s a '+
//          'importância de R$ %10.2n (%s), referente a quitação da parcela %.3d, '+
//          'com vencimento em %s.' ,[DM.cdsCotNOME.Value,DM.cdsPclVALPG.AsFloat,
//          DM.NumeroParaExtenso(DM.cdsPclVALPG.AsFloat),
//          DM.cdsPclPARCELA.AsInteger,DM.cdsPclVENCTO.AsString]);
////        frmRecibo.lblExtenso.Caption := Format('(%s),'[DM.NumeroParaExtenso(DM.cdsPclVALPG.AsFloat)]);
//        DecodeDate(DM.cdsPclPAGTO.AsDateTime,ano,mes,dia);
//        frmRecibo.lblLocData.Caption := Format('Goiânia, %.2d de %s de %.4d.',[dia,MesExt[mes],ano]);
//        frmRecibo.QR.PreviewModal;
//     finally
//            frmRecibo.Free;
//     end;
     Sair.Execute;
end;

procedure TfrmRec.DSDataChange(Sender: TObject; Field: TField);
const
     Estados : array [TDataSetState] of string =
   ('Fechado','Consultando','Alterando','Inserindo','','','','','','','','','');
begin
     btnGravar.Enabled := DS.State in [dsInsert,dsEdit];
     if btnGravar.Enabled
     then StFig := 9
     else StFig := 6;
     stBar.Repaint;
     stBar.Panels[1].Text := Estados[DS.State];
end;


procedure TfrmRec.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left+1,Rect.Top,StFig);
end;

procedure TfrmRec.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F5: if btnGravar.Enabled then btnGravar.Click;
       VK_RETURN:  Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE: Sair.Execute;
     end;
end;

procedure TfrmRec.FormCreate(Sender: TObject);
begin
     StFig := 7;
//     DM.cdsPcl.Edit;
//     DM.cdsPclPAGTO.AsDateTime := Date;
//     DM.cdsPclMULTA.AsFloat := DM.CalcJur(DM.cdsPclVENCTO.AsDateTime,
//                               Date,DM.cdsPclTotal.Value);
//     DM.cdsPclVALPG.AsFloat := DM.cdsPclTotal.Value + DM.cdsPclMULTA.AsFloat;
end;

end.
