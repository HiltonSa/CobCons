unit cobcons.view.devolucaopagamentos;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, DB, StdCtrls, ExtCtrls,
  Buttons, ComCtrls, ActnList, DateTimePicker, cobcons.controller.interfaces;

type

  { TfrmDevCon }

  TfrmDevCon = class(TForm)
    Agencia: TLabel;
    Al: Tactionlist;
    Cancelar: Taction;
    cboForma: TComboBox;
    cboTpPix: TComboBox;
    Conta: TLabel;
    Dbedit10: Tdbedit;
    Dbedit12: Tdbedit;
    Dbedit13: Tdbedit;
    Dbedit15: Tdbedit;
    Dbedit8: Tdbedit;
    edChavePix: TEdit;
    edPrev: TDateTimePicker;
    edPagto: TEdit;
    edDcSit: TEdit;
    edSaldo: TEdit;
    edProg: TEdit;
    Gravar: Taction;
    Label12: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: Tlabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label5: TLabel;
    Label51: Tlabel;
    Label53: Tlabel;
    Label54: Tlabel;
    Label6: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    pnConta: TPanel;
    pnPix: TPanel;
    pnAcoes: TPanel;
    pnBack: TPanel;
    dsCota: TDataSource;
    Pntitulo: Tpanel;
    Speedbutton1: Tspeedbutton;
    Speedbutton2: Tspeedbutton;
    edAgencia: TEdit;
    edBanco: TEdit;
    edConta: TEdit;
    edObs: TEdit;
    procedure Cancelarexecute(Sender: Tobject);
    procedure cboFormaSelect(Sender: TObject);
    procedure cboTpPixExit(Sender: TObject);
    procedure Formcreate(Sender: Tobject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure GravarExecute(Sender: TObject);

    procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
  private
    FSaldo: Currency;
    FPagamento: iControllerPgRnp;
    Fcliente: Icontrollercota;
    procedure PreencheTela;
    procedure MostraSaldo(pSaldo: Double);
    procedure Setcliente(Avalue: Icontrollercota);
    procedure SetarFormaPagamento(pForma, pTpPix: Integer);
    function ValidarCampos: Boolean;
    { Private declarations }
  public
    { Public declarations }
    property Cliente: iControllerCota read FCliente write SetCliente;
  end;

var
  frmDevCon: TfrmDevCon;

implementation

uses cobcons.model.dm, cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util;

{$R *.lfm}

procedure TfrmDevCon.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_RETURN: SelectNext(ActiveControl,True,True);
       VK_ESCAPE: Cancelar.Execute;
     end;
end;

procedure TfrmDevCon.FormShow(Sender: TObject);
begin
  FSaldo := TControllerFactory.New.TabularEncerrados.DATALIMITE(Date).CalcularSaldoRnpCota(Fcliente.GRUPO, Fcliente.SEQ, Fcliente.COTA, Nil);
  edProg.Text := DateToStr(Date);
  edPrev.Date := Date + 5;
  edPagto.Clear;
  if FPagamento.TemDados
  then begin
    PreencheTela;
    FSaldo := FSaldo - FPagamento.VALOR;
  end
  else MostraSaldo(FSaldo);
  if FSaldo = 0
  then begin
    MostraAviso('Cliente não tem Saldo a receber.');
    Cancelar.Execute;
  end;
end;

procedure TfrmDevCon.GravarExecute(Sender: TObject);
var
  vGravar: Boolean;
begin
  vGravar := ValidarCampos;
  if (vGravar) and (ConfirmaMensagem('Gravar os dados?'))
  then begin
    FPagamento.GRUPO(Fcliente.GRUPO)
              .SEQ(Fcliente.SEQ)
              .COTA(Fcliente.COTA)
              .FRMPG(cboForma.ItemIndex)
              .DTPEDIDO(Date)
              .DTPROG(edPrev.Date)
              .VALOR(FSaldo)
              .TIPOPIX(cboTpPix.ItemIndex)
              .CHAVEPIX(edChavePix.Text)
              .BANCO(edBanco.Text)
              .AGENCIA(edAgencia.Text)
              .CONTA(edConta.Text)
              .OBS(edObs.Text);
    if FPagamento.CODIGO = 0
    then FPagamento.Novo
    else FPagamento.Gravar;
    ModalResult := mrOK;
  end;
end;

procedure TfrmDevCon.Cancelarexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
End;

procedure TfrmDevCon.cboFormaSelect(Sender: TObject);
begin
  Gravar.Enabled := (cboForma.ItemIndex >= 0);
  SetarFormaPagamento(cboForma.ItemIndex, cboTpPix.ItemIndex);
end;

procedure TfrmDevCon.cboTpPixExit(Sender: TObject);
begin
  if Length(Trim(edChavePix.Text)) = 0
  then begin
    case cboTpPix.ItemIndex of
      0,1: edChavePix.Text := Fcliente.CGCCPFMT;
      2: edChavePix.Text := Fcliente.CELULAR;
      3: edChavePix.Text := Fcliente.EMAIL;
    end;
  end;
  pnConta.Enabled := cboTpPix.ItemIndex > 3;
end;

procedure TfrmDevCon.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnBack.Color := vEsquema.CorFundo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  FPagamento := TControllerFactory.New.PagamentosRnp;
  Gravar.Enabled := False;
  if not FPagamento.TabelaExiste
  then FPagamento.CriarTabela;
End;

procedure TfrmDevCon.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X,
  Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure TfrmDevCon.PreencheTela;
begin
  MostraSaldo(FPagamento.VALOR);
  edProg.Text := FormatDateTime('dd/mm/yyyy', FPagamento.DTPEDIDO);
  cboForma.ItemIndex := FPagamento.FRMPG;
  cboTpPix.ItemIndex := FPagamento.TIPOPIX;
  edChavePix.Text := FPagamento.CHAVEPIX;
  edBanco.Text := FPagamento.BANCO;
  edAgencia.Text := FPagamento.AGENCIA;
  edConta.Text := FPagamento.CONTA;
  edPrev.Date := FPagamento.DTPROG;
  edObs.Text := FPagamento.OBS;
  edDcSit.Text := FPagamento.DCSIT;
  if DataEstaVazia(FPagamento.DTPAGTO)
  then begin
    Gravar.Enabled := (FPagamento.STATUS < 2);
    edPagto.Clear;
  end
  else begin
    Gravar.Enabled := False;
    edPagto.Text := DateToStr(FPagamento.DTPAGTO);
  end;
  SetarFormaPagamento(cboForma.ItemIndex, cboTpPix.ItemIndex);
end;

procedure TfrmDevCon.MostraSaldo(pSaldo: Double);
begin
  edSaldo.Text := Format('%10.2n',[pSaldo]);
end;

procedure TfrmDevCon.Setcliente(Avalue: Icontrollercota);
begin
  Fcliente := Avalue;
  dsCota.DataSet := Fcliente.Dataset;
  FPagamento.GRUPO(Fcliente.GRUPO)
            .SEQ(Fcliente.SEQ)
            .COTA(Fcliente.COTA)
            .RetornaPagamentoCota;
end;

procedure TfrmDevCon.SetarFormaPagamento(pForma, pTpPix: Integer);
begin
  pnPix.Enabled := False;
  pnConta.Enabled := False;
  if pForma = 0
  then begin
    pnPix.Enabled := True
    pnConta.Enabled := pTpPix > 4;
  end
  else pnConta.Enabled := True;
end;

function TfrmDevCon.ValidarCampos: Boolean;
var
  vValidarBanco: Boolean;
begin
  Result := True;
  vValidarBanco := False;
  if cboForma.ItemIndex = 0      // validar pix
  then begin
    if cboTpPix.ItemIndex >= 0
    then begin
      if cboTpPix.ItemIndex > 4
      then vValidarBanco := True
      else if Length(Trim(edChavePix.Text)) = 0
      then begin
        Result := False;
        MostraAviso('Chave Pix deve ser informada!');
        edChavePix.SetFocus;
      end;
    end
    else begin
      Result := False;
      MostraAviso('Tipo de Chave Pix deve ser informado!');
      cboTpPix.SetFocus;
    end;
  end
  else vValidarBanco := True;

  if vValidarBanco
  then begin
    if Length(Trim(edBanco.Text)) = 0
    then begin
      Result := False;
      MostraAviso('Banco deve ser informado!');
      edBanco.SetFocus;
    end
    else if Length(Trim(edAgencia.Text)) = 0
    then begin
      Result := False;
      MostraAviso('Agencia deve ser informada!');
      edAgencia.SetFocus;
    end
    else if Length(Trim(edConta.Text)) = 0
    then begin
      Result := False;
      MostraAviso('Conta deve ser informada!');
      edBanco.SetFocus;
    end;
  end;
  if edPrev.Date < Date
  then Result := ConfirmaMensagem('Previsão de Pagamento anterior a Solicitação! Confirma?');
end;

end.
