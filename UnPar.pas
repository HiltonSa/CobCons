unit UnPar;

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
  TfrmPar = class(TForm)
    stBar: TStatusBar;
    Panel1: TPanel;
    btnGravar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnSair: TSpeedButton;
    AL: TActionList;
    Pesquisa: TAction;
    Grava: TAction;
    Cancela: TAction;
    Sair: TAction;
    Panel2: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DS: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    DBEdit5: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    txtTot: TEdit;
    procedure DSStateChange(Sender: TObject);
    procedure stBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure GravaExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure CancelaExecute(Sender: TObject);
    procedure txtTotKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPar: TfrmPar;
  StFig : Integer;

implementation

uses UnDm, Math;

{$R *.dfm}

procedure TfrmPar.DSStateChange(Sender: TObject);
const
     Estados : array [TDataSetState] of string =
   ('Fechado','Consultando','Alterando','Inserindo','','','','','','','','','');
begin
     btnGravar.Enabled := DS.State in [dsInsert,dsEdit];
     btnCancelar.Enabled := DS.State in [dsInsert,dsEdit];
     if btnGravar.Enabled
     then StFig := 9
     else StFig := 6;
     stBar.Repaint;
     stBar.Panels[1].Text := Estados[DS.State];
end;

procedure TfrmPar.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left+1,Rect.Top,StFig);
end;

procedure TfrmPar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
//       VK_F2: if btnIncluir.Enabled then btnIncluir.Click;
//       VK_F3: if btnAlterar.Enabled then btnAlterar.Click;
//       VK_F4: if btnExcluir.Enabled then btnExcluir.Click;
       VK_F5: if btnGravar.Enabled then btnGravar.Click;
       VK_F6: if btnCancelar.Enabled then btnCancelar.Click;
//       VK_F9: if btnPesq.Enabled then btnPesq.Click;
       VK_RETURN: SelectNext(ActiveControl,True,True);
       VK_ESCAPE: frmPar.Close;
     end;
end;

procedure TfrmPar.FormShow(Sender: TObject);
begin
//     DM.cdsPcl.Edit;
//     txtTot.Text := Format('%8.2n',[DM.cdsPclVALOR.AsFloat+DM.cdsPclVL_ADI.Value]);
end;

procedure TfrmPar.GravaExecute(Sender: TObject);
var
   NVal, Dif, PcDif, PcAdi : Double;
   Pcl : Integer;
   Ven : TDate;
begin
     NVal := StrToFloat(txtTot.Text);
//     if (NVal=0) or (DM.cdsPclVENCTO.IsNull)
//     then
//         begin
//              ShowMessage('Precisa informar VALOR E VENCTO!');
//              Abort;
//         end;
//     Pcl := DM.cdsPclPARCELA.AsInteger;
//     Dif := DM.cdsPclTotal.Value - NVal;
//     Ven := DM.cdsPclVENCTO.AsDateTime;
//     PcAdi := RoundTo(DM.cdsPclVL_ADI.AsFloat / DM.cdsPclTotal.AsFloat * 100,-4);
//     PcDif := 0;
//     if Dif > 0
//     then    // Valor informado eh menor que o devido
//         begin
//              PcDif := RoundTo(Dif * DM.cdsPclPC_BEM.AsFloat / DM.cdsPclTotal.AsFloat,-4);
//              DM.cdsPclVL_ADI.AsFloat := NVal * PcAdi / 100;
//              DM.cdsPclVALOR.AsFloat := NVal - DM.cdsPclVL_ADI.AsFloat;
//              DM.cdsPclPC_BEM.AsFloat := DM.cdsPclPC_BEM.AsFloat - PcDif;
//         end
//     else
//         begin
//              if Dif < 0
//              then
//                  begin
//                       ShowMessage('Valor deve ser menor ou igual ao anterior!');
//                       Abort;
//                  end;
//         end;

     if Application.MessageBox('Confirma a gravação?','Confirmação',
        MB_ICONQUESTION+MB_YESNO)=id_yes
     then
         begin
//              DM.cdsPcl.Post;
//              DM.cdsPcl.ApplyUpdates(0);
//              if Dif > 0
//              then
//                  begin
//                       DM.cdsPcl.Next;  // Ajustes na proxima parcela
//                       if DM.cdsPcl.Eof
//                       then              // proxima parcela nao existe: cria nova com dif
//                           begin
//                                DM.cdsPcl.Insert;
//                                DM.cdsPclCD_ACORDO.Value := DM.cdsAcoCD_ACORDO.Value;
//                                DM.cdsPclPARCELA.AsInteger := Pcl + 1;
//                                DM.cdsPclVENCTO.AsDateTime := IncMonth(Ven,1);
//                                DM.cdsPclVL_ADI.AsFloat := Dif * PcAdi / 100;
//                                DM.cdsPclVALOR.AsFloat := Dif - DM.cdsPclVL_ADI.AsFloat;
//                                DM.cdsPclPC_BEM.AsFloat := PcDif;
//                           end
//                       else
//                           begin
//                                DM.cdsPcl.Edit;
//                                DM.cdsPclVL_ADI.AsFloat := DM.cdsPclVL_ADI.AsFloat
//                                                        + (Dif * PcAdi / 100);
//                                DM.cdsPclVALOR.AsFloat := DM.cdsPclVALOR.AsFloat
//                                             + (Dif * (100 - PcAdi) /100);
//                                DM.cdsPclPC_BEM.AsFloat := DM.cdsPclPC_BEM.AsFloat
//                                                        + PcDif;
//                           end;
//                       DM.cdsPcl.Post;
//                       DM.cdsPcl.ApplyUpdates(0);
//                  end;
         end
//     else DM.cdsPcl.Cancel;
end;

procedure TfrmPar.SairExecute(Sender: TObject);
begin
//     if DS.State in [dsInsert,dsEdit]
//     then DM.cdsPcl.Cancel;
     Close;
end;

procedure TfrmPar.CancelaExecute(Sender: TObject);
begin
//     DM.cdsPcl.Cancel;
end;

procedure TfrmPar.txtTotKeyPress(Sender: TObject; var Key: Char);
begin
     if not (Key in ['0'..'9',#8,#13,'.'])
     then Key := #0
end;

end.
