unit UnImpGru;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, ActnList, ComCtrls, StdCtrls, Mask;

type
  TfrmImpGru = class(TForm)
    stBar: TStatusBar;
    AL: TActionList;
    Importar: TAction;
    Sair: TAction;
    Panel1: TPanel;
    btnSair: TSpeedButton;
    btnImp: TSpeedButton;
    Panel2: TPanel;
    txtGru: TMaskEdit;
    Label1: TLabel;
    procedure SairExecute(Sender: TObject);
    procedure ImportarExecute(Sender: TObject);
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
  frmImpGru: TfrmImpGru;
  StFig : Integer;

implementation

uses UnDm, DB, DBClient, SqlExpr, Math;

{$R *.dfm}

procedure TfrmImpGru.SairExecute(Sender: TObject);
begin
     DM.qryImp.Close;
     DM.cdsCot.Close;
     DM.cdsEnd.Close;
     DM.cdsFon.Close;
     DM.cdsPen.Close;
     DM.cdsCam.Close;
     Close;
end;

procedure TfrmImpGru.ImportarExecute(Sender: TObject);
var
   DtVen : TDateTime;
   PcDev : Double;
begin
     if StrToIntDef(txtGru.Text,0) = 0 then Abort;

     with DM.qryImp do
     begin
          Close;
          Params[0].Value := Format('%.4d',[StrToInt(txtGru.Text)]);
          Params[1].Value := Format('%.4d',[StrToInt(txtGru.Text)]);
          Open;
     end;

     if DM.qryImp.IsEmpty
     then
         begin
              stBar.Panels[1].Text := 'Dados não encontrados!';
              StFig := 9;
         end
     else
         begin
              stBar.Panels[1].Text := 'Dados encontrados!';
              StFig := 6;
         end;
     stBar.Repaint;
     if DM.qryImp.IsEmpty then Abort;

     if Application.MessageBox('Confirma a importação?','Confirmação',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;

     with DM.sqlCom do
     begin
          Close;
          SQL.Clear;
          SQL.Add('select max(d_vencto) from acreu where grupo='+
                         QuotedStr(DM.qryImpGRUPO.Value)+
                         ' union select max(d_vencto) from a2reu where grupo='+
                               QuotedStr(DM.qryImpGRUPO.Value));
          Open;
     end;
     DtVen := DM.sqlCom.Fields[0].AsDateTime;

     StFig := 8;
     stBar.Repaint;

     while not DM.qryImp.Eof do
     begin
          Application.ProcessMessages;
          stBar.Panels[1].Text := 'Importando Grupo: '+DM.qryImpGRUPO.Value +
               ' Seq: '+DM.qryImpSEQ.Value+' Cota: '+DM.qryImpCOTA.Value+' '+
               DM.qryImpNOME.Value;

          with DM.cdsCot do
          begin
               Close;
               Params[0].Value := DM.qryImpGRUPO.Value;
               Params[1].Value := DM.qryImpCOTA.Value;
               Params[2].Value := DM.qryImpSEQ.Value;
               Open;
          end;
          if DM.cdsCot.IsEmpty
          then
              begin
                   DM.cdsCot.Insert;
                   DM.cdsCotCD_COTA.AsInteger := DM.GeraCod('CD_COTA','CJCBCOT');
                   DM.cdsCotGRUPO.Value := DM.qryImpGRUPO.Value;
                   DM.cdsCotSEQ.Value := DM.qryImpSEQ.Value;
                   DM.cdsCotCOTA.Value := DM.qryImpCOTA.Value;
                   DM.cdsCotNOME.Value := DM.qryImpNOME.Value;
                   DM.cdsCotBEM.Value := DM.qryImpBEM.Value;
                   DM.cdsCotPC_PAGO.AsFloat := DM.qryImpPCPAGO.AsFloat;
                   DM.cdsCotPC_DEV.AsFloat := 100 - DM.cdsCotPC_PAGO.AsFloat;
                   if DM.qryImpPESS_F_J.Value = 'F'
                   then
                       begin
                            DM.cdsCotPESSOA.AsInteger := 0;
                            DM.cdsCotCPFCGC.Value := copy(DM.qryImpCGC_CPF.Value,2,9)
                                          +copy(DM.qryImpCGC_CPF.Value,15,2);
                       end
                   else
                       begin
                            DM.cdsCotPESSOA.AsInteger := 1;
                            DM.cdsCotCPFCGC.Value := copy(DM.qryImpCGC_CPF.Value,3,14);
                       end;
                   DM.cdsCotFILIAL.Value := DM.qryImpFIL_COM.Value;
                   DM.cdsCotTXADM.Value := DM.qryImpP_ADMINS.AsCurrency;
                   DM.cdsCotTXRES.Value := DM.qryImpP_RESERV.AsFloat;
                   DM.cdsCotTXSEG.Value := DM.qryImpPERSEGVD.AsFloat;
                   DM.cdsCotDATREF.AsDateTime := Date;
                   DM.cdsCot.Post;
                   DM.cdsCot.ApplyUpdates(0);
              end;

          with DM.cdsEnd do
          begin
               Close;
               Params[0].AsFMTBCD := DM.cdsCotCD_COTA.Value;
               Open;
          end;
          if DM.cdsEnd.IsEmpty
          then
              begin
                   DM.cdsEnd.Insert;
                   DM.cdsEndCD_END.AsInteger := DM.GeraCod('CD_END','CJCBEND');
                   DM.cdsEndCD_COTA.Value := DM.cdsCotCD_COTA.Value;
                   DM.cdsEndTP_END.AsInteger := 0;
                   DM.cdsEndENDERECO.Value := DM.qryImpENDERECO.Value;
                   DM.cdsEndCOMPLEM.Value := DM.qryImpCOMPLEMEN.Value;
                   DM.cdsEndBAIRRO.Value := DM.qryImpBAIRRO.Value;
                   DM.cdsEndCIDADE.Value := DM.qryImpCIDADE.Value;
                   DM.cdsEndESTADO.Value := DM.qryImpESTADO.Value;
                   DM.cdsEndCEP.Value := DM.qryImpCEP.Value;
                   DM.cdsEnd.Post;
                   DM.cdsEnd.ApplyUpdates(0);
              end;

          with DM.cdsFon do
          begin
               Close;
               Params[0].AsFMTBCD := DM.cdsCotCD_COTA.Value;
               Open;
          end;
          if (DM.cdsFon.IsEmpty) and (Length(DM.qryImpTELEFONE.Value) > 0)
          then
              begin
                   DM.cdsFon.Insert;
                   DM.cdsFonCD_FON.AsInteger := DM.GeraCod('CD_FON','CJCBFON');
                   DM.cdsFonCD_COTA.Value := DM.cdsCotCD_COTA.Value;
                   DM.cdsFonTP_FON.AsInteger := 0;
                   DM.cdsFonCD_END.AsInteger := 0;
                   DM.cdsFonDDD.Value := '  ';
                   DM.cdsFonFONE.Value := DM.qryImpTELEFONE.Value;
                   DM.cdsFon.Post;
                   DM.cdsFon.ApplyUpdates(0);
              end;

          with DM.cdsCons do
          begin
               Close;
               if DM.qryImpAVISO.IsNull
               then CommandText := 'select * from CJCBPEN where cd_cota='+
                           DM.cdsCotCD_COTA.AsString+' and aviso='+
                           QuotedStr('000000')
               else CommandText := 'select * from CJCBPEN where cd_cota='+
                           DM.cdsCotCD_COTA.AsString+' and aviso='+
                           QuotedStr(DM.qryImpAVISO.Value);
               Open;
          end;
          if DM.cdsCons.IsEmpty then
          begin
            if not DM.cdsPen.Active then DM.cdsPen.Open;
            DM.cdsPen.Insert;
            DM.cdsPenCD_COB.AsInteger := DM.GeraCod('CD_COB','CJCBPEN');
            DM.cdsPenCD_COTA.Value := DM.cdsCotCD_COTA.Value;
            if DM.qryImpAVISO.IsNull then
            begin
              DM.cdsPenAVISO.Value := '000000';
              DM.cdsPenTP_MOV.Value := '07';
              DM.cdsPenDT_VENC.AsDateTime := DtVen;
              DM.cdsPenPC_NOR.Value := DM.cdsCotPC_DEV.Value;
            end
            else
              begin
                DM.cdsPenAVISO.Value := DM.qryImpAVISO.Value;
                DM.cdsPenTP_MOV.Value := DM.qryImpTIPO_MOV.Value;
                if DM.qryImpD_VENCTO.AsDateTime =  StrToDate('31/12/2049')
                then DM.cdsPenDT_VENC.AsDateTime := DtVen
                else DM.cdsPenDT_VENC.AsDateTime := DM.qryImpD_VENCTO.AsDateTime;
                DM.cdsPenPC_NOR.Value := DM.qryImpP_NORMAL.AsCurrency;
                DM.cdsPenPC_DIF.Value := DM.qryImpP_DIFER.AsCurrency;
                DM.cdsPenVL_AQU.Value := DM.qryImpF_AQUISI.AsCurrency;
                DM.cdsPenVL_ADM.Value := DM.qryImpADMINIST.AsCurrency;
                DM.cdsPenVL_RES.Value := DM.qryImpF_RESERV.AsCurrency;
                DM.cdsPenVL_OUT.Value := DM.qryImpOUTROS.AsCurrency;
                DM.cdsPenSEGOUT.Value := DM.qryImpSEG_OUT.Value;
              end;
            DM.cdsPen.Post;
            DM.cdsPen.ApplyUpdates(0);
          end;
          DM.AtualizaPendencia(DM.cdsCotDATREF.AsDateTime,DM.cdsCotCD_COTA.AsInteger);

          with DM.cdsCons do
          begin
               Close;
               CommandText := 'select * from CJCBCAM where grupo='+
                           DM.qryImpGRUPO.Value+' and seq='+DM.qryImpSEQ.Value+
                           ' and cota='+DM.qryImpCOTA.Value;
               Open;
          end;
          if DM.cdsCons.IsEmpty
          then
              begin
                   with DM.sdsTotPen do
                   begin
                        Close;
                        DataSet.Params[0].AsFMTBCD := dm.cdsCotCD_COTA.Value;
                        Open;
                   end;
                   PcDev := RoundTo(DM.cdsCotPC_DEV.AsFloat - (DM.sdsTotPenPCNOR.AsFloat
                                        + DM.sdsTotPenPCDIF.AsFloat),-4);
                   if not DM.cdsCam.Active then DM.cdsCam.Open;
                   DM.cdsCam.Insert;
                   DM.cdsCamGRUPO.Value := DM.qryImpGRUPO.Value;
                   DM.cdsCamSEQ.Value := DM.qryImpSEQ.Value;
                   DM.cdsCamCOTA.Value := DM.qryImpCOTA.Value;
                   DM.cdsCamCONTATO.AsInteger := 0;
                   if PcDev = 0
                   then DM.cdsCamSTATUS.AsInteger := 0
                   else DM.cdsCamSTATUS.AsInteger := 3;
                   DM.cdsCam.Post;
                   DM.cdsCam.ApplyUpdates(0);
              end;

          DM.qryImp.Next;
     end;

     StFig := 7;
     stBar.Panels[1].Text := '';
     stBar.Repaint;
     Application.MessageBox('Fim de importação!','Atenção',MB_ICONHAND+MB_OK);

end;

procedure TfrmImpGru.stBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     if Panel.Index = 0
     then DM.IL.Draw(stBar.Canvas,Rect.Left+1,Rect.Top,StFig);
end;

procedure TfrmImpGru.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F2: btnImp.Click;
       VK_RETURN:  Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE: btnSair.Click;
     end;
end;

procedure TfrmImpGru.FormCreate(Sender: TObject);
begin
     StFig := 7;
end;

end.
