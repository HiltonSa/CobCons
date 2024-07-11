unit cobcons.view.fichacota;

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
  Dialogs, ActnList, Buttons, ExtCtrls, ComCtrls, StdCtrls, DB,
  DBCtrls,  DBGrids,    cobcons.controller.interfaces;

type

  { TfrmCli }

  TfrmCli = class(TForm)
    btExcSqg: TSpeedButton;
    excSqg: TAction;
    Btexcpend: Tspeedbutton;
    Btincpend: Tspeedbutton;
    Btnsair1: Tspeedbutton;
    Btnsair2: Tspeedbutton;
    dsDev: Tdatasource;
    dsTot: TDataSource;
    Edbairro: Tedit;
    edEmail: TEdit;
    Edcep: Tedit;
    Edcgccpf: Tedit;
    Edcidade: Tedit;
    Eddcecivil: Tedit;
    Eddcprof: Tedit;
    edDcTpConte: TEdit;
    edDcTipoBem: Tedit;
    Eddocument: Tedit;
    edDtAdes: Tedit;
    edDtConte: Tedit;
    edDtEntre: Tedit;
    edContrato: Tedit;
    Eddtnasc: Tedit;
    Edendereco: Tedit;
    Edestado: Tedit;
    Ednmfilate: Tedit;
    edCelular: TEdit;
    edTpGrupo: Tedit;
    edSitGrupo: Tedit;
    edNmRepres: TEdit;
    edDescric: Tedit;
    edPerdev: Tedit;
    Edpessfj: Tedit;
    edPre_Tabe: Tedit;
    edPlano: Tedit;
    edNome: Tedit;
    edGrupo: Tedit;
    edCota: Tedit;
    edPerSegVd: Tedit;
    edPercPago: Tedit;
    edDtVenda: Tedit;
    edbem: Tedit;
    Edsexo: Tedit;
    Edtelefone: Tedit;
    edTipoCota: Tedit;
    edValEntre: Tedit;
    edReuAdes: Tedit;
    edTp_Segur: Tedit;
    edP_Reserv: Tedit;
    edP_Mensal: Tedit;
    edP_Admins: Tedit;
    edSeq: Tedit;
    edDcSitCob: Tedit;
    grCob: Tdbgrid;
    grPag: Tdbgrid;
    grDev: Tdbgrid;
    Label19: Tlabel;
    Label20: Tlabel;
    Label23: Tlabel;
    Label33: Tlabel;
    Label34: Tlabel;
    Label35: Tlabel;
    Label38: Tlabel;
    Label40: Tlabel;
    Label41: Tlabel;
    Label42: Tlabel;
    Label43: Tlabel;
    Label44: Tlabel;
    Label51: Tlabel;
    Label53: Tlabel;
    Label54: Tlabel;
    Label55: Tlabel;
    Label56: Tlabel;
    Label57: Tlabel;
    Label58: Tlabel;
    Label59: Tlabel;
    Label60: Tlabel;
    Label61: TLabel;
    Label62: TLabel;
    nvDev: Tdbnavigator;
    Panel1: Tpanel;
    Panel2: Tpanel;
    Panel4: Tpanel;
    Panel5: Tpanel;
    Panel8: Tpanel;
    Pntitulo: Tpanel;
    pnAcoes: TPanel;
    btnSair: TSpeedButton;
    AL: TActionList;
    Reu: TAction;
    Pre: TAction;
    Sair: TAction;
    dsCot: TDataSource;
    dsBem: TDataSource;
    Jur: TAction;
    btnPos: TSpeedButton;
    impPos: TAction;
    Com: TAction;
    Ali: TAction;
    dsPag: TDataSource;
    dsCob: TDataSource;
    btnReu: TSpeedButton;
    btnPre: TSpeedButton;
    btnJur: TSpeedButton;
    btnCom: TSpeedButton;
    dsPre: TDataSource;
    AltEnd: TAction;
    Cre: TAction;
    dsSeg: TDataSource;
    DevCon: TAction;
    btnDevCon: TSpeedButton;
    IncPend: TAction;
    ExcPend: TAction;
    IncPag: TAction;
    pnBack: TPanel;
    Panel3: TPanel;
    PC: TPageControl;
    Spaltend: Tspeedbutton;
    Speedbutton3: Tspeedbutton;
    Speedbutton5: Tspeedbutton;
    tsDev: Ttabsheet;
    tbCont: TTabSheet;
    grbCont: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    grBem: TGroupBox;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    edDcFabBem: TDBEdit;
    dbedi: TGroupBox;
    Label22: TLabel;
    Label8: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    grCont: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    Label17: TLabel;
    Label16: TLabel;
    Label39: TLabel;
    Label18: TLabel;
    Label27: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    tbCli: TTabSheet;
    tbPen: TTabSheet;
    Panel7: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit21: TDBEdit;
    DBEdit31: TDBEdit;
    DBEdit32: TDBEdit;
    nvPen: TDBNavigator;
    tbPag: TTabSheet;
    Panel6: TPanel;
    Label21: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    DBEdit33: TDBEdit;
    DBEdit34: TDBEdit;
    DBEdit35: TDBEdit;
    DBEdit36: TDBEdit;
    DBEdit43: TDBEdit;
    nvPag: TDBNavigator;
    Label49: TLabel;
    DBEdit44: TDBEdit;
    Label50: TLabel;
    DBEdit45: TDBEdit;
    sitCob: TAction;
    SpeedButton4: TSpeedButton;
    excPag: TAction;
    procedure excPagExecute(Sender: TObject);
    procedure excSqgExecute(Sender: TObject);
    procedure Formactivate(Sender: Tobject);
    procedure Formcreate(Sender: Tobject);
      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
    procedure sitCobExecute(Sender: TObject);
    procedure impPosExecute(Sender: TObject);
    procedure IncPagExecute(Sender: TObject);
    procedure ExcPendExecute(Sender: TObject);
    procedure IncPendExecute(Sender: TObject);
    procedure DevConExecute(Sender: TObject);
    procedure AltEndExecute(Sender: TObject);
    procedure CreExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ReuExecute(Sender: TObject);
    procedure PreExecute(Sender: TObject);
    procedure JurExecute(Sender: TObject);
    procedure ComExecute(Sender: TObject);
    procedure AliExecute(Sender: TObject);
    procedure Tbpagshow(Sender: Tobject);
    procedure Tbpenshow(Sender: Tobject);
    procedure Tsdevshow(Sender: Tobject);
  private
    Fcota: String;
    Fgrupo: String;
    Fseq: String;
    FCliente: iControllerCota;
    FPagamentos: iControllerPagamentos;
    FFichaPagamentos: iControllerFichaPagamentos;
    procedure Setcota(Avalue: String);
    procedure Setgrupo(Avalue: String);
    procedure Setseq(Avalue: String);
    procedure PreencheCampos;
    procedure MontarPendencias;
    { Private declarations }
  public
    { Public declarations }
    property Grupo: String read FGrupo write SetGrupo;
    property Seq: String read FSeq write SetSeq;
    property Cota: String read FCota write SetCota;
  end;

var
  frmCli: TfrmCli;

implementation

uses
{$IFnDEF FPC}
  DBClient, SqlExpr,
{$ELSE}
  sqldb,
{$ENDIF}
  cobcons.model.dm, cobcons.model.configura,  cobcons.view.fasesjuridicas,
  {  UnMov,  }
  cobcons.view.reunioes, cobcons.view.precosbem, cobcons.view.fichaendereco,
  cobcons.view.creditos, cobcons.view.alienacoes, cobcons.view.fichacompromisso,
  cobcons.view.situacaocobranca, cobcons.view.fichacobranca,
  cobcons.view.devolucaopagamentos, cobcons.view.posicaocota,
  cobcons.controller.factory, cobcons.controller.util;

{$R *.lfm}

procedure Tfrmcli.Sairexecute(Sender: Tobject);
begin
  Close;
end;

procedure Tfrmcli.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_F12: if btnPos.Enabled then btnPos.Click;
    VK_RETURN: SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
end;

procedure Tfrmcli.Impposexecute(Sender: Tobject);
begin
  FrmPosicaoCota := TFrmPosicaoCota.Create(nil);
  try
    FrmPosicaoCota.Cliente := FCliente;
    FrmPosicaoCota.ShowModal;
  finally
    FrmPosicaoCota.Free;
  end;
end;

procedure Tfrmcli.Reuexecute(Sender: Tobject);
begin
  frmReu := TfrmReu.Create(nil);
  try
    frmReu.Grupo := Fgrupo;
    frmReu.ShowModal;
  finally
    frmReu.Free;
  end;
end;

procedure Tfrmcli.Preexecute(Sender: Tobject);
begin
  frmPre := TfrmPre.Create(nil);
  try
    frmPre.Filial := FCliente.FIL_COM;
    frmPre.Bem := FCliente.BEM;
    frmPre.ShowModal;
  finally
    frmPre.Free;
  end;
end;

procedure Tfrmcli.Excpagexecute(Sender: Tobject);
//var
//  tpMov: Integer;
begin

  //tpMov := 0;
  //if DM.PosicionarMvt(DM.cdsCotGRUPO.Value, DM.cdsCotSEQ.Value,
  //     DM.cdsCotCOTA.Value,DM.cdsMovAviso.Value)
  //then tpMov := Pos(DM.cdsMvtTIPO_MOV.Value,'01,SR,04,14,15,94');
  //
  //if tpMov>0 then begin
  //
  //  if Application.MessageBox('Confirma a exclusão?','Atenção',
  //    MB_ICONQUESTION+MB_YESNO)=mrYes then begin
  //
  //    case tpMov of
  //     1,4,16: DM.AtualizarPercentualPago(DM.cdsCotGRUPO.Value,DM.cdsCotSEQ.Value,
  //        DM.cdsCotCOTA.Value,0,-DM.cdsMvtP_NORMAL.Value);
  //     7: DM.AtualizarPercentualPago(DM.cdsCotGRUPO.Value,DM.cdsCotSEQ.Value,
  //        DM.cdsCotCOTA.Value,1,-DM.cdsMvtP_RATEIO.Value);
  //    end;
  //
  //    DM.ExecutarSQL(Format(
  //       'delete from ACHIS where GRUPO=%s and CONTRATO=%s and CONTABIL=%s and AVISO=%s',
  //       [QuotedStr(DM.cdsMvtGRUPO.Value),QuotedStr(DM.cdsCotCONTRATO.Value),
  //        QuotedStr(FormatDateTime('mm/dd/yyyy',DM.cdsMvtD_CONTAB.Value)),
  //        QuotedStr(DM.cdsMvtAVISO.Value)]));
  //
  //    if (DM.cdsMvtSEQ.Value='00') and (DM.cdsMvtAV_V_COB.Value='S')then begin
  //      DM.cdsPnd.Open;
  //      DM.cdsPnd.Append;
  //      DM.cdsPndGRUPO.Value := DM.cdsMvtGRUPO.Value;
  //      DM.cdsPndSEQ.Value := DM.cdsMvtSEQ.Value;
  //      DM.cdsPndCOTA.Value := DM.cdsMvtCOTA.Value;
  //      DM.cdsPndAVISO.Value := DM.ObterNovoAviso(DM.cdsMvtGRUPO.Value,
  //                              DM.cdsMvtSEQ.Value,DM.cdsMvtCOTA.Value);
  //      DM.cdsPndTIPO_MOV.Value := DM.cdsMvtTIPO_MOV.Value;
  //      DM.cdsPndD_VENCTO.Value := DM.cdsMvtD_VENCTO.Value;
  //      DM.cdsPndAG_COBRA.Value := DM.cdsMvtAG_FINAN.Value;
  //      DM.cdsPndP_NORMAL.Value := DM.cdsMvtP_NORMAL.Value;
  //      DM.cdsPndP_DIFER.Value := DM.cdsMvtP_DIFER.Value;
  //      DM.cdsPndP_RATEIO.Value := DM.cdsMvtP_RATEIO.Value;
  //      DM.cdsPndP_SUBST.Value := DM.cdsMvtP_SUBST.Value;
  //      DM.cdsPndF_AQUISI.Value := DM.cdsMvtF_AQUISI.Value;
  //      DM.cdsPndADMINIST.Value := DM.cdsMvtADMINIST.Value;
  //      DM.cdsPndF_RESERV.Value := DM.cdsMvtF_RESERV.Value;
  //      DM.cdsPndOUTROS.Value := DM.cdsMvtOUTROS.Value;
  //      DM.cdsPndNR_EXTER.Value := DupeString(' ',20);
  //      DM.cdsPndDT_BASE.Value := DM.cdsMvtDT_BASE.Value;
  //      DM.cdsPndP_ANTEC.Value := DM.cdsMvtP_ANTEC.Value;
  //      DM.cdsPndSEG_OUT.Value := DM.cdsMvtSEG_OUT.Value;
  //      DM.cdsPndUSUARIO.Value := DM.cdsMvtUSUARIO.Value;
  //      DM.cdsPndD_ATUALI.Value := Date;
  //      DM.cdsPndTP_ABONO.Value := '00';
  //      DM.cdsPndMUL_JUR.Value := 0;
  //      DM.cdsPndCOBRADOR.Value := '000000';
  //      DM.cdsPndTAR_BANC.Value := 0;
  //      DM.cdsPndAV_ASSOC.Value := '000000';
  //      DM.cdsPndFILLER.Value := DupeString(' ',20);
  //      DM.cdsPndADM_DESC.Value := 0;
  //      DM.cdsPnd.Post;
  //      DM.cdsPnd.ApplyUpdates(0);
  //    end;
  //
  //    DM.cdsMvt.Delete;
  //    DM.cdsMvt.ApplyUpdates(0);
  //    PosicionaDataset(txtGru.Text,txtSeq.Text,txtCota.Text);
  //
  //  end;
  //
  //end
  //else  Application.MessageBox('Tipo de Pagamento não pode ser excluído!',
  //                                      'Atenção',MB_ICONHAND+MB_OK);
  //

end;

procedure TfrmCli.excSqgExecute(Sender: TObject);
var
  vPendencia: iControllerPendencia;
begin
  if grCob.Focused
  then begin
    if ConfirmaMensagem('Excluir SQG?')
    then begin
      vPendencia := TControllerFactory.New.Pendencia;
      vPendencia.GRUPO(Fgrupo)
                .SEQ(Fseq)
                .COTA(Fcota)
                .ExcluirSQG;
      MontarPendencias;
    end;
  end;
end;

procedure Tfrmcli.Formactivate(Sender: Tobject);
begin
  PreencheCampos;
End;

procedure Tfrmcli.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnBack.Color := vEsquema.CorFundo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  FCliente := TControllerFactory.New.Cota;
  FPagamentos := TControllerFactory.New.Pagamentos;
  FFichaPagamentos := TControllerFactory.New.FichaPagamentos;
  PC.ActivePage := tbCont;
End;

procedure Tfrmcli.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmcli.Excpendexecute(Sender: Tobject);
var
  vPendencia: iControllerPendencia;
begin
  if grCob.Focused
  then begin
    if ConfirmaMensagem('Confirma a exclusão?')
    then begin
      vPendencia := TControllerFactory.New.Pendencia;
      vPendencia.GRUPO(Fgrupo)
                .SEQ(Fseq)
                .COTA(Fcota)
                .AVISO(dsCob.DataSet.FieldByName('AVISO').AsString)
                .Excluir;
      MontarPendencias;
    end;
  end;
end;

procedure Tfrmcli.Jurexecute(Sender: Tobject);
var
  vFasesJuridicas: iControllerFaseJuridica;
begin
  vFasesJuridicas := TControllerFactory.New.FaseJuridica;
  vFasesJuridicas.RetornaFasesCota(FCliente.GRUPO, FCliente.SEQ, FCliente.COTA);
  if not vFasesJuridicas.DataSet.EOF
  then begin
    frmJur := TfrmJur.Create(nil);
    try
      frmJur.FasesJuridicas := vFasesJuridicas;
      frmJur.ShowModal;
    finally
      frmJur.Free;
    end;
  end
  else MostraAviso('Processos jurídicos não foram encontrados!');
end;

procedure Tfrmcli.Incpagexecute(Sender: Tobject);
begin
  //FrmMov := TFrmMov.Create(nil);
  //try
  //  if FrmMov.ShowModal = mrOk
  //  then PosicionaDataset(txtGru.Text,txtSeq.Text,txtCota.Text);
  //finally
  //  FrmMov.Free;
  //end;
end;

procedure Tfrmcli.Incpendexecute(Sender: Tobject);
begin
  frmPen := TfrmPen.Create(nil);
  try
     frmPen.Cliente := FCliente;
     if frmPen.ShowModal = mrOK
     then MontarPendencias;
  finally
    frmPen.Free;
  end;
end;

procedure Tfrmcli.Sitcobexecute(Sender: Tobject);
begin
  frmSitCob := TfrmSitCob.Create(nil);
  try
    frmSitCob.Cliente := FCliente;
     if frmSitCob.ShowModal=mrOk
     then PreencheCampos;
  finally
    frmSitCob.Free;
  end;
end;

procedure Tfrmcli.Altendexecute(Sender: Tobject);
begin
  FrmFichaEndereco := TFrmFichaEndereco.Create(nil);
  try
    FrmFichaEndereco.Cota := FCliente;
    if FrmFichaEndereco.ShowModal = mrOK
    then PreencheCampos;
  finally
    FrmFichaEndereco.Free;
  end;
end;

procedure Tfrmcli.Comexecute(Sender: Tobject);
begin
  frmCom := TfrmCom.Create(nil);
  try
    frmCom.Cliente := FCliente;
    frmCom.ShowModal;
  finally
    frmCom.Free;
  end;
end;

procedure Tfrmcli.Creexecute(Sender: Tobject);
begin
  FrmCre  := TFrmCre.Create(nil);
  try
     FrmCre.Cliente := FCliente;
     FrmCre.ShowModal;
  finally
    FrmCre.Free;
  end;
end;

procedure Tfrmcli.Devconexecute(Sender: Tobject);
begin
  frmDevCon := TfrmDevCon.Create(nil);
  try
    frmDevCon.Cliente := FCliente;
    frmDevCon.ShowModal;
  finally
    frmDevCon.Free;
  end;
  //DM.CriaForm(TfrmDevcon,frmDevCon);
end;

procedure Tfrmcli.Aliexecute(Sender: Tobject);
var
  vBensAlienaddos: iControllerBemAlienado;
begin
  vBensAlienaddos := TControllerFactory.New.BemAlienado;
  vBensAlienaddos.RetornaBensAlienadosCota(FCliente.GRUPO, FCliente.COTA);
  if not vBensAlienaddos.DataSet.EOF
  then begin
    frmAli := TfrmAli.Create(nil);
    try
      frmAli.BensAlienados := vBensAlienaddos;
      frmAli.ShowModal;
    finally
      frmAli.Free;
    end;
  end
  else MostraAviso('Não existem Bens Alienados para a Cota!');

end;

procedure Tfrmcli.Tbpagshow(Sender: Tobject);
begin
  if dsPag.DataSet = nil
  then begin
    dsPag.DataSet := FFichaPagamentos.GRUPO(Fgrupo)
                                     .SEQ(Fseq)
                                     .COTA(Fcota)
                                     .DATALIMITE(Date)
                                     .MontarPagamentos;
    if dsTot.DataSet = nil
    then dsTot.DataSet := FFichaPagamentos.GRUPO(Fgrupo)
                                          .SEQ(Fseq)
                                          .COTA(Fcota)
                                          .RetornarTotaisCota;
  end;
End;

procedure Tfrmcli.Tbpenshow(Sender: Tobject);
begin
  if dsCob.DataSet = nil
  then MontarPendencias;
End;

procedure Tfrmcli.Tsdevshow(Sender: Tobject);
//var
//  vlDev: Currency;
begin
  //vlDev := TControllerFactory.New.TabularEncerrados.DATALIMITE(StrToDate('30/06/2021')).CalcularSaldoRnpCota(Fgrupo, Fseq,Fcota, nil);
  //MostraAviso(Format('Saldo Dev: %.2n',[vlDev]));

  //MostraAviso('Consulte Dev.Pagtos');
  //DevCon.Execute;
  if dsDev.DataSet = nil
  then dsDev.DataSet := FFichaPagamentos.GRUPO(Fgrupo)
                                        .SEQ(Fseq)
                                        .COTA(Fcota)
                                        .DATALIMITE(Date)
                                        .ContaCorrenteDevolucoes;
End;

procedure Tfrmcli.Setcota(Avalue: String);
begin
  if Fcota = Avalue then Exit;
  Fcota := Avalue;
end;

procedure Tfrmcli.Setgrupo(Avalue: String);
begin
  if Fgrupo = Avalue then Exit;
  Fgrupo := Avalue;
end;

procedure Tfrmcli.Setseq(Avalue: String);
begin
  if Fseq = Avalue then Exit;
  Fseq := Avalue;
end;

procedure Tfrmcli.Preenchecampos;
var
  vGrupo: iControllerGrupo;
begin
  vGrupo := TControllerFactory.New.Grupo.RetornaGrupo(Fgrupo);
  FCliente.PesquisarGrupoSeqCota(Fgrupo, Fseq, Fcota);
  edGrupo.Text    := Fgrupo;
  edSeq.Text      := Fseq;
  edCota.Text     := Fcota;
  edNome.Text     := FCliente.NOME;
  edContrato.Text := FCliente.CONTRATO;
  edPlano.Text    := FCliente.PLANO;
  edP_Mensal.Text := Format('%.4f', [FCliente.P_MENSAL]);
  edP_Admins.Text := Format('%.4f', [FCliente.P_ADMINS]);
  edP_Reserv.Text := Format('%.4f', [FCliente.P_RESERV]);
  edTp_Segur.Text := FCliente.TP_SEGUR;
  edPerSegVd.Text := Format('%.4f', [FCliente.PERSEGVD]);
  edDcSitCob.Text := FCliente.DCSITCOB;
  edPercPago.Text := Format('%.4f', [FCliente.PERCPAGO]);
  edPerdev.Text   := Format('%.4f', [FCliente.PERDEV]);
  edDtVenda.Text  := RetornaDataString(FCliente.DT_VENDA);
  edNmRepres.Text := FCliente.NMREPRES;
  edDtAdes.Text   := RetornaDataString(FCliente.DT_ADES);
  edReuAdes.Text  := FCliente.REU_ADES;
  edNmFilAte.Text := FCliente.NMFILATE;
  edbem.Text      := FCliente.BEM;
  edDescric.Text  := FCliente.DESCRIC;
  edDcTipoBem.Text:= FCliente.DCTIPOBEM;
  edDcFabBem.Text := FCliente.DCFABBEM;
  edPre_Tabe.Text := Format('%.2n', [FCliente.PRE_TABE]);
  edDcTpConte.Text:= FCliente.DCTPCONTE;
  edDtConte.Text  := RetornaDataString(FCliente.DT_CONTE);
  edDtEntre.Text  := RetornaDataString(FCliente.DT_ENTRE);
  edValEntre.Text := Format('%.2n', [FCliente.VAL_ENTR]);
  edPessFj.Text   := FCliente.PESS_F_J;
  edCgcCpf.Text   := FCliente.CGCCPFMT;
  edDocument.Text := FCliente.DOCUMENT;
  edDcECivil.Text := FCliente.DCECIVIL;
  edDtNasc.Text   := RetornaDataString(FCliente.DT_NASC);
  edSexo.Text     := FCliente.SEXO;
  edDcProf.Text   := FCliente.DCPROF;
  edTelefone.Text := FCliente.TELEFONE;
  edCelular.Text  := FCliente.CELULAR;
  edEndereco.Text := FCliente.ENDERECO;
  edBairro.Text   := FCliente.BAIRRO;
  edCidade.Text   := FCliente.CIDADE;
  edEstado.Text   := FCliente.ESTADO;
  edCep.Text      := RetornarFormatado(FCliente.CEP, tfCEP);
  edEmail.Text    := FCliente.EMAIL;
  edTipoCota.Text := FCliente.DCTPCOTA;
  edTpGrupo.Text  := vGrupo.DCTPGRUPO;
  edSitGrupo.Text := vGrupo.DCSITGRUPO;

  Jur.Enabled := FCliente.SIT_COBR = 'J';
  Jur.Visible := Jur.Enabled;
  Cre.Enabled := FCliente.TP_CONTE <> '';
  Cre.Visible := Cre.Enabled;
  Ali.Enabled := Cre.Enabled;
  Ali.Visible := Ali.Enabled;

  //dsPag.DataSet := DM.MontarPagamentos(Fgrupo, Fseq, Fcota);
  //dsCob.DataSet := DM.MontarPendencias(Fgrupo, Fseq, Fcota);
  //dsTot.DataSet := DM.TotalizarPagamentosPendencias;

  //DM.AtualizarVlrAtualPendencia(txtGru.Text, txtSeq.Text, txtCota.Text);
  //
  //spCreditos.Enabled := not DM.cdsCre.Eof;
  //btnAli.Enabled := not DM.cdsAli.Eof;
  //btnJur.Enabled := not DM.sdsJur.Eof;
  //btnDevCon.Enabled := (StrToInt(DM.cdsCotSEQ.Value) > 0) and
  //      (StrToInt(DM.cdsCotSEQ.Value) < 50);
  //DM.MontarPagamentos;
  //DM.MontarPendencias;
  //pcpag := DM.cdsMovTTPer.Value;
  //if (DM.cdsCotPerPago.Value <> pcpag) then begin
  //  DecimalSeparator := '.';
  //  stSql := Format(
  //   'update accli set p_no_pag=%f where grupo=%s and seq=%s and cota=%s',[
  //   (pcpag-DM.cdsCotP_AN_PAG.Value), QuotedStr(DM.cdsCotGRUPO.Value),
  //   QuotedStr(DM.cdsCotSEQ.Value), QuotedStr(DM.cdsCotCOTA.Value)]);
  //   DecimalSeparator := ',';
  //   DM.ExecutarSQL(stSql);
  //   DM.cdsCot.Refresh;
  //end;
  //ExcPend.Enabled := not DM.cdsCb1.Eof;
  //AltPend.Enabled := ExcPend.Enabled;
end;

procedure Tfrmcli.Montarpendencias;
begin
  dsCob.DataSet := FFichaPagamentos.GRUPO(Fgrupo).SEQ(Fseq).COTA(Fcota).MontarPendencias;
  if dsTot.DataSet = nil
  then dsTot.DataSet := FFichaPagamentos.GRUPO(Fgrupo).SEQ(Fseq).COTA(Fcota).RetornarTotaisCota;
  ExcPend.Enabled := not dsCob.DataSet.EOF;
end;

end.
