unit UnSVen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ActnList, Buttons, ExtCtrls;

type
  TfrmSVen = class(TForm)
    Panel1: TPanel;
    btnSair: TSpeedButton;
    btnVer: TSpeedButton;
    Panel2: TPanel;
    AL: TActionList;
    VerImp: TAction;
    Sair: TAction;
    spLisGruFim: TSpeedButton;
    txtFim: TLabeledEdit;
    spLisGru: TSpeedButton;
    txtIni: TLabeledEdit;
    pb: TProgressBar;
    cbSitIni: TComboBox;
    cbSitFim: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure spLisGruFimClick(Sender: TObject);
    procedure spLisGruClick(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VerImpExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSVen: TfrmSVen;

implementation

uses UnDm, DB;

{$R *.dfm}

procedure TfrmSVen.SairExecute(Sender: TObject);
begin
     Close;
end;

procedure TfrmSVen.spLisGruClick(Sender: TObject);
begin
  txtIni.Text := DM.SugerirGrupo;
end;

procedure TfrmSVen.spLisGruFimClick(Sender: TObject);
begin
  txtFim.Text := DM.SugerirGrupo;
end;

procedure TfrmSVen.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F2: if btnVer.Enabled then btnVer.Click;
       VK_RETURN: Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE: btnSair.Click;
     end;
end;

procedure TfrmSVen.VerImpExecute(Sender: TObject);
begin
  if DM.PosicionarPendencia(txtIni.Text,txtFim.Text, Copy(cbSitIni.Text,1,1), Copy(cbSitFim.Text,1,1))
  then begin

    pb.Max := DM.cdsPen.RecordCount;
    DM.PosGru(DM.cdsPenGRUPO.Value);
    if not DM.cdsRelPend.Active
    then DM.cdsRelPend.Open;

    DM.cdsRelPend.EmptyDataSet;
    DM.cdsPen.First;

    while not DM.cdsPen.Eof do
    begin
      DM.cdsRelPend.Append;
      DM.cdsRelPendGrupo.Value := DM.cdsPenGRUPO.Value;
      DM.cdsRelPendCota.Value := DM.cdsPenCOTA.Value;
      DM.cdsRelPendNome.Value := DM.cdsPenNOME.Value;
      DM.cdsRelPendCidade.Value := Format('%s (%s)',[Trim(DM.cdsPenCIDADE.Value),
           DM.cdsPenESTADO.Value]);
      DM.cdsRelPendFone.Value := DM.cdsPenTELEFONE.Value;
      DM.cdsRelPendBem.Value := DM.cdsPenLIN_MOD.Value;
      DM.cdsRelPendPcDev.Value := DM.cdsPenPCDEV.Value;
      DM.cdsRelPendPcPago.Value := DM.cdsPenPCPAG.Value;
      DM.cdsRelPendSitCob.Value := DM.cdsPenSIT_COBR.Value;
      DM.cdsRelPendTpCont.Value := DM.cdsPenTP_CONTE.Value;
      if DM.cdsPenDT_CONTE.AsString = '01/01/1801'
      then DM.cdsRelPendDtCont.Value := ''
      else DM.cdsRelPendDtCont.Value := DM.cdsPenDT_CONTE.AsString;
      if DM.cdsPenDT_ENTRE.AsString = '01/01/1801'
      then DM.cdsRelPendDtEntr.Value := ''
      else DM.cdsRelPendDtEntr.Value := DM.cdsPenDT_ENTRE.AsString;
      if DM.PosicionarReuniao(DM.cdsPenD_VENCTO.Value)
      then DM.cdsRelPendReu.Value := DM.sdsReuNRO_REU.Value
      else DM.cdsRelPendReu.Value := '999';
      DM.cdsRelPendTpPen.Value := DM.cdsPenSIGLA1.Value;
      if DM.cdsPenD_VENCTO.AsString = '01/01/1801'
      then DM.cdsRelPendVencto.Value := ''
      else DM.cdsRelPendVencto.Value := DM.cdsPenD_VENCTO.AsString;
      DM.cdsRelPendVlBem.Value := DM.ObterValorBemNaData(DM.cdsPenFIL_COM.Value,DM.cdspenBem.value, Date);
      DM.cdsRelPendPcNormal.Value := DM.cdsPenPCNOR.Value;
      DM.cdsRelPendPcRat.Value := DM.cdsPenP_RATEIO.Value;
      if (DM.cdsRelPendPcNormal.Value + DM.cdsRelPendPcRat.Value) > 0 then begin
        DM.cdsRelPendVlPend.Value := DM.cdsRelPendVlBem.Value * (DM.cdsRelPendPcNormal.Value
          + DM.cdsRelPendPcRat.Value) / 100;
        DM.cdsRelPendVlPend.Value := (DM.cdsRelPendVlPend.Value * DM.cdsPenTAXAS.Value);
      end
      else DM.cdsRelPendVlPend.Value := DM.cdsPenVALOR.Value;
      if DM.cdsPenMUL_JUR.Value <> 'N' then begin
        if DM.cdsPenD_VENCTO.Value < Date
        then DM.cdsRelPendVlMul.Value := DM.cdsRelPendVlPend.Value *
                                          DM.cdsPRSPC_MUL.Value / 100
        else DM.cdsRelPendVlMul.Value := 0;
        DM.cdsRelPendVlJur.Value := DM.CalcularJuros(DM.cdsPenD_VENCTO.Value,
                    DM.cdsRelPendVlPend.Value, Date);
      end
      else begin
        DM.cdsRelPendVlMul.Value := 0;
        DM.cdsRelPendVlJur.Value := 0;
      end;
      DM.cdsRelPendVlTot.Value := DM.cdsRelPendVlPend.Value + DM.cdsRelPendVlMul.Value + DM.cdsRelPendVlJur.Value;
      DM.cdsRelPend.Post;
      DM.cdsPen.Next;
      Application.ProcessMessages;
      pb.Position := DM.cdsPen.RecNo;
    end;
    DM.ImprimirRelatorio('','rpPend');
    txtFim.Text := '';
    txtIni.Text := '';
    pb.Position := 0;
    txtIni.SetFocus;
  end
  else Application.MessageBox('Faixa de grupos inválida!','Atenção',
        MB_ICONHAND+MB_OK);
//     frmRelVen := TfrmRelVen.Create(Self);
//     try
//        with frmRelVen.sdsVen do
//        begin
//             Close;
//             DataSet.Params[0].Value := DateToStr(dtI.Date);
//             DataSet.Params[1].Value := DateToStr(dtF.Date);
//             Open;
//        end;
//        frmRelVen.QR.ReportTitle := 'VENCTO INICIAL: '+DateToStr(dtI.Date)+
//                                    ' FINAL: '+DateToStr(dtF.Date);
//        frmRelVen.QR.PreviewModal;
//     finally
//            frmRelVen.Free;
//     end;
end;

end.
