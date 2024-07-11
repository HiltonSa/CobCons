unit cobcons.view.posicaocota;

{$mode delphi}

interface

uses
  Classes, Sysutils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,  LCLIntf, LCLType,
  ActnList, StdCtrls, cobcons.controller.interfaces, Messages;

type

  { TFrmPosicaoCota }

  TFrmPosicaoCota = class(Tform)
    Al: Tactionlist;
    Cancelar: Taction;
    cbCon: Tcheckbox;
    cbRes: Tcheckbox;
    cbPag: Tcheckbox;
    cbCre: Tcheckbox;
    cbAli: Tcheckbox;
    cbPen: Tcheckbox;
    cbTodos: Tcheckbox;
    cboTipo: Tcombobox;
    Edcota: Tedit;
    Edgrupo: Tedit;
    Ednome: Tedit;
    Edseq: Tedit;
    Imprimir: Taction;
    Label51: Tlabel;
    Label53: Tlabel;
    Label54: Tlabel;
    Label55: Tlabel;
    Pnacoes: Tpanel;
    Pnback: Tpanel;
    Pntitulo: Tpanel;
    Speedbutton1: Tspeedbutton;
    Speedbutton2: Tspeedbutton;

      procedure Cancelarexecute(Sender: Tobject);
      procedure Cbotiposelect(Sender: Tobject);
      procedure Cbtodoschange(Sender: Tobject);
      procedure Formcreate(Sender: Tobject);
      procedure Formkeydown(Sender: Tobject; var Key: Word; Shift: Tshiftstate);
      procedure Imprimirexecute(Sender: Tobject);
      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
  Private
    Fcliente: Icontrollercota;
    procedure Setcliente(Avalue: Icontrollercota);

  Public
    property Cliente: iControllerCota read FCliente write SetCliente;
  end;

var
  FrmPosicaoCota: TFrmPosicaoCota;

implementation

uses cobcons.model.configura, cobcons.model.dm, cobcons.controller.factory,
  cobcons.view.rel.cota, cobcons.view.rel.ccdevolucao;

{$R *.lfm}

{ TFrmPosicaoCota }

procedure TFrmPosicaoCota.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure TFrmPosicaoCota.Setcliente(Avalue: Icontrollercota);
begin
  if Fcliente = Avalue then Exit;
  Fcliente := Avalue;
  Edgrupo.Text := Fcliente.GRUPO;
  Edseq.Text := Fcliente.SEQ;
  Edcota.Text := Fcliente.COTA;
  Ednome.Text := Fcliente.NOME;
end;

procedure TFrmPosicaoCota.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_RETURN: SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Cancelar.Execute;
  end;
End;

procedure TFrmPosicaoCota.Imprimirexecute(Sender: Tobject);
var
  vFicha: iControllerFichaPagamentos;
begin
  vFicha := TControllerFactory.New.FichaPagamentos;
  if cboTipo.ItemIndex = 0
  then begin
    frmRelCli := TfrmRelCli.Create(nil);
    try
      frmRelCli.lblDcSitCob.Caption := FCliente.DCSITCOB;
      frmRelCli.lblDcTpConte.Caption := FCliente.DCTPCONTE;
      frmRelCli.dsTot.DataSet := vFicha.GRUPO(Fcliente.GRUPO).SEQ(Fcliente.SEQ).COTA(Fcliente.COTA).CalcularSaldoDevedorCota;
      frmRelCli.dsTCot.DataSet := vFicha.GRUPO(Fcliente.GRUPO).SEQ(Fcliente.SEQ).COTA(Fcliente.COTA).RetornarTotaisCota;
      frmRelCli.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
      frmRelCli.Creditos.Visible := False;
      frmRelCli.Pendencia.Visible := False;
      frmRelCli.MovFin.Visible := False;
      if (cbCre.Checked) and (Fcliente.SEQ = '00')
      then begin
        frmRelCli.dsCre.DataSet := TControllerFactory.New.Credito.RetornaCreditosCota(Fcliente.GRUPO, Fcliente.COTA).DataSet;
        frmRelCli.Creditos.Visible := not frmRelCli.dsCre.DataSet.EOF;
      end;
      if cbPen.Checked
      then begin
        frmRelCli.dsCob.DataSet := vFicha.GRUPO(Fcliente.GRUPO).SEQ(Fcliente.SEQ).COTA(Fcliente.COTA).MontarPendencias;
        frmRelCli.Pendencia.Visible := not frmRelCli.dsCob.DataSet.EOF;
      end;
      if cbPag.Checked
      then begin
        frmRelCli.dsMov.DataSet := vFicha.GRUPO(Fcliente.GRUPO).SEQ(Fcliente.SEQ).COTA(Fcliente.COTA).MontarPagamentos;
        frmRelCli.MovFin.Visible := not frmRelCli.dsMov.DataSet.EOF;
      end;
      if cbAli.Checked and (Fcliente.SEQ = '00')
      then begin
        frmRelCli.dsAli.DataSet := TControllerFactory.New.BemAlienado.RetornaBensAlienadosCota(Fcliente.GRUPO, Fcliente.COTA).DataSet;
        frmRelCli.Alienacoes.Visible := not frmRelCli.dsAli.DataSet.EOF;
      end;
      frmRelCli.bndResumoFinanceiro.Visible := cbRes.Checked;
      frmRelCli.bndContrato.Visible := cbCon.Checked;
      frmRelCli.dsCot.DataSet := FCliente.Dataset;
      frmRelCli.Rp.PreviewModal;
    finally
      frmRelCli.Free;
    end;
  end
  else begin
    FrmCCDev := TFrmCCDev.Create(nil);
    try
      FrmCCDev.lblDcSitCob.Caption := FCliente.DCSITCOB;
      FrmCCDev.lblDcTpConte.Caption := FCliente.DCTPCONTE;
      FrmCCDev.dsTot.DataSet := TControllerFactory.New.FichaPagamentos.GRUPO(Fcliente.GRUPO).SEQ(Fcliente.SEQ).COTA(Fcliente.COTA).CalcularSaldoDevedorCota;
      FrmCCDev.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
      FrmCCDev.dsMov.DataSet := vFicha.GRUPO(Fcliente.GRUPO).SEQ(Fcliente.SEQ).COTA(Fcliente.COTA).DATALIMITE(Date).ContaCorrenteDevolucoes;
      FrmCCDev.bndResumoFinanceiro.Visible := cbRes.Checked;
      FrmCCDev.bndContrato.Visible := cbCon.Checked;
      FrmCCDev.dsCot.DataSet := FCliente.Dataset;
      FrmCCDev.Rp.PreviewModal;
    finally
      FrmCCDev.Free;
    end;
  end;
  ModalResult := mrOK;
End;

procedure TFrmPosicaoCota.Cancelarexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
End;

procedure Tfrmposicaocota.Cbotiposelect(Sender: Tobject);
begin
  cbAli.Enabled := (cboTipo.ItemIndex = 0);
  cbCre.Enabled := (cboTipo.ItemIndex = 0);
  cbPen.Enabled := (cboTipo.ItemIndex = 0);
  cbPag.Enabled := (cboTipo.ItemIndex = 0);
End;

procedure Tfrmposicaocota.Cbtodoschange(Sender: Tobject);
begin
  cbAli.Checked := cbTodos.Checked;
  cbCre.Checked := cbTodos.Checked;
  cbPag.Checked := cbTodos.Checked;
  cbPen.Checked := cbTodos.Checked;
  cbRes.Checked := cbTodos.Checked;
  cbCon.Checked := cbTodos.Checked;
End;

procedure TFrmPosicaoCota.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnBack.Color := vEsquema.CorFundo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
End;

end.

