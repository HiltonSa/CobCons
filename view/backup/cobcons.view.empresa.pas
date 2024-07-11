unit cobcons.view.empresa;

{$mode delphi}

interface

uses
  Classes, Sysutils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ActnList, ComCtrls, StdCtrls, DateTimePicker, Cobcons.View.Ficha, LCLType,
  cobcons.controller.interfaces;

type

  { TFrmEmpresa }

  TFrmEmpresa = class(Tfrmficha)
    dtLimRed: TDateTimePicker;
    edRedApl: Tedit;
    edRecSaldo: TDateTimePicker;
    dtRcCmPer: TDateTimePicker;
    edLimExi: Tedit;
    Label13: Tlabel;
    Label14: Tlabel;
    Label15: Tlabel;
    Label16: Tlabel;
    Label17: Tlabel;
    tabenc: Taction;
    edStGrEncCt: Tedit;
    edFaseAjuiz: Tedit;
    edSTRLIB: Tedit;
    edULTSAG: Tdatetimepicker;
    edNM_CONTATO: Tedit;
    edMAILCONTATO: Tedit;
    edTELCONTATO: Tedit;
    edPC_MUL: Tedit;
    edNM_PRS: Tedit;
    edCD_CGC: TEdit;
    edPC_JUR: Tedit;
    edPC_HONOR: Tedit;
    Label1: Tlabel;
    Label10: Tlabel;
    Label11: Tlabel;
    Label12: Tlabel;
    Label2: Tlabel;
    Label3: Tlabel;
    Label4: Tlabel;
    Label5: Tlabel;
    Label6: Tlabel;
    Label7: Tlabel;
    Label8: Tlabel;
    Label9: Tlabel;
    PC: Tpagecontrol;
    Speedbutton3: Tspeedbutton;
    tsGeral: Ttabsheet;
    tsSag: Ttabsheet;
    procedure Edcd_cgcexit(Sender: Tobject);
    procedure Edpc_mulexit(Sender: Tobject);
    procedure edTELCONTATOExit(Sender: Tobject);
    procedure Formcreate(Sender: Tobject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Gravarexecute(Sender: Tobject);
    procedure Tabencexecute(Sender: Tobject);
  Private
    FEmpresa: iControllerEmpresa;
    procedure PreencherEdits;
    procedure AbrirQG;
  Public

  end;

var
  FrmEmpresa: TFrmEmpresa;

implementation

uses cobcons.controller.factory, cobcons.controller.util, cobcons.view.qg;

{$R *.lfm}

{ TFrmEmpresa }

procedure TFrmEmpresa.Formcreate(Sender: Tobject);
var
   DtLib : TDateTime;
   diasUtilizar: Integer;
begin
  inherited;
  FEmpresa := TControllerFactory.New.Empresa.RecuperarEmpresa;
  pc.ActivePage := tsGeral;
  //DtLib := dtLiberado(FEmpresa.STRLIB,FEmpresa.FANTASIA);
  DtLib := Date + 1;
  diasUtilizar := Round(DtLib-Date);
  edSTRLIB.Text := format('Liberado até %s (%d dias restantes)',
      [FormatDateTime('dd/mmm/yyyy',DtLib),diasUtilizar]);
  PreencherEdits;
End;

procedure TFrmEmpresa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F9 then AbrirQG;
end;

procedure TFrmEmpresa.Gravarexecute(Sender: Tobject);
begin
  if edNM_PRS.Text = ''
  then begin
    MostraAviso('Necessário informar NOME!');
    edNM_PRS.SetFocus;
  end
  else if ConfirmaMensagem('Gravar as informações?')
  then begin
    FEmpresa.FANTASIA(edNM_PRS.Text)
               .CGC(RetornaSemFormatacao(edCD_CGC.Text))
               .PCMULTAS(StrToFloatDef(edPC_MUL.Text,0))
               .PCJUROS(StrToFloatDef(edPC_JUR.Text,0))
               .PCHONORARIOS(StrToFloatDef(edPC_HONOR.Text,0))
               .ULTSAG(edULTSAG.Date)
               .NMCONTATO(edNM_CONTATO.Text)
               .TELCONTATO(RetornaSemFormatacao(edTELCONTATO.Text))
               .MAILCONTATO(edMAILCONTATO.Text)
               .STGRUENCCT(edStGrEncCt.Text)
               .FASEAJUIZ(edFaseAjuiz.Text)
               .DTRECSLDRNP(edRecSaldo.Date)
               .DTRCCMPER(dtRcCmPer.Date)
               .PCREDAPL(StrToFloatDef(edRedApl.Text, 0))
               .DTLIMRED(dtLimRed.Date)
               .VLLIMEXI(StrToFloatDef(edLimExi.Text,0))
               .GravarFicha;
    ModalResult := mrOK;
  end;

End;

procedure TFrmEmpresa.Tabencexecute(Sender: Tobject);
begin
  TabularEncerrados;
End;

procedure TFrmEmpresa.PreencherEdits;
begin
  edNM_PRS.Text := FEmpresa.FANTASIA;
  edCD_CGC.Text := RetornarFormatado(FEmpresa.CGC, tfCnpj);
  edPC_MUL.Text := Format('%.2f',[FEmpresa.PCMULTAS]);
  edPC_JUR.Text := Format('%.2f',[FEmpresa.PCJUROS]);
  edPC_HONOR.Text := Format('%.2f',[FEmpresa.PCHONORARIOS]);
  edRedApl.Text := Format('%.2f',[FEmpresa.PCREDAPL]);
  edNM_CONTATO.Text := FEmpresa.NMCONTATO;
  edTELCONTATO.Text := RetornarFormatado(FEmpresa.TELCONTATO, tfFone);
  edMAILCONTATO.Text := FEmpresa.MAILCONTATO;
  edULTSAG.Date := FEmpresa.ULTSAG;
  edStGrEncCt.Text := FEmpresa.STGRUENCCT;
  edFaseAjuiz.Text := FEmpresa.FASEAJUIZ;
  edRecSaldo.Date := FEmpresa.DTRECSLDRNP;
  if DataEstaVazia(FEmpresa.DTRCCMPER)
  then dtRcCmPer.Date := StrToDate('30/06/2021') - (360 * 5)
  else dtRcCmPer.Date := FEmpresa.DTRCCMPER;
  dtLimRed.Date := FEmpresa.DTLIMRED;
  edLimExi.Text := Format('%.2f',[FEmpresa.VLLIMEXI]);
end;

procedure TFrmEmpresa.AbrirQG;
begin
  FrmQG := TFrmQG.Create(nil);
  try
     FrmQG.ShowModal;
  finally
    FrmQG.Free;
  end;
end;

procedure TFrmEmpresa.Edcd_cgcexit(Sender: Tobject);
begin
  edCD_CGC.Text := RetornarFormatado(edCD_CGC.Text, tfCnpj);
End;

procedure TFrmEmpresa.Edpc_mulexit(Sender: Tobject);
begin
  (Sender as TEdit).Text := Trim(RetornarFormatado((Sender as TEdit).Text, tfVal10Dec2));;
  //edPC_MUL.Text := Trim(RetornarFormatado(edPC_MUL.Text, tfVal10Dec2));
End;

procedure TFrmEmpresa.edTELCONTATOExit(Sender: Tobject);
begin
  edTELCONTATO.Text := RetornarFormatado(edTELCONTATO.Text, tfFone);
End;

end.

