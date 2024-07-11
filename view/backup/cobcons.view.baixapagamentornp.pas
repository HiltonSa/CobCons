unit cobcons.view.baixapagamentornp;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ActnList,
  ExtCtrls, StdCtrls, cobcons.controller.interfaces, Buttons, HNSCombox,
  DateTimePicker;

type

  { TFrmBaixaPagamentoRNP }

  TFrmBaixaPagamentoRNP = class(TForm)
    AL: TActionList;
    Cancelar: TAction;
    cboAgente: THNSCombox;
    cboTipoDoc: THNSCombox;
    edContab: TDateTimePicker;
    edHist: TEdit;
    edQtd: TEdit;
    edDtCtb: TEdit;
    edTotal: TEdit;
    gravar: TAction;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    pnAcoes: TPanel;
    pnBack: TPanel;
    pnTitulo: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure CancelarExecute(Sender: TObject);
    procedure edContabChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure gravarExecute(Sender: TObject);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    FDatasetPagamentos: TDataset;
    FTotal: Double;
    FQtd: Integer;
    FDtCtb: TDateTime;
    procedure SetDatasetPagamentos(AValue: TDataset);
    procedure CalcularTotais(pContab: TDatetime);
    procedure MostrarTotais;
  public
    property DatasetPagamentos: TDataset read FDatasetPagamentos write SetDatasetPagamentos;
  end;

var
  FrmBaixaPagamentoRNP: TFrmBaixaPagamentoRNP;

implementation

uses cobcons.controller.util, cobcons.controller.factory,
  cobcons.model.configura;

{$R *.lfm}

{ TFrmBaixaPagamentoRNP }

procedure TFrmBaixaPagamentoRNP.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmBaixaPagamentoRNP.SetDatasetPagamentos(AValue: TDataset);
begin
  FDtCtb := Date-15;
  FDatasetPagamentos := AValue;
  FDatasetPagamentos.First;
  while not FDatasetPagamentos.EOF do
  begin
    if FDtCtb < FDatasetPagamentos.FieldByName('DTPROG').AsDateTime
    then FDtCtb := FDatasetPagamentos.FieldByName('DTPROG').AsDateTime;
    FDatasetPagamentos.Next;
  end;
  FDatasetPagamentos.First;
  edQtd.Text := Format('%.3d', [FDatasetPagamentos.RecordCount]);
end;

procedure TFrmBaixaPagamentoRNP.CalcularTotais(pContab: TDatetime);
var
  vDtProg: TDateTime;
begin
  FQtd := 0;
  FTotal := 0;
  FDatasetPagamentos.First;
  while not FDatasetPagamentos.EOF do
  begin
    vDtProg := FDatasetPagamentos.FieldByName('DTPROG').AsDateTime;
    if vDtProg <= pContab
    then begin
      FQtd := FQtd + 1;
      FTotal := FTotal + FDatasetPagamentos.FieldByName('VALOR').AsFloat;
    end;
    FDatasetPagamentos.Next;
  end;
  FDatasetPagamentos.First;
  MostrarTotais;
end;

procedure TFrmBaixaPagamentoRNP.MostrarTotais;
begin
  edDtCtb.Text := FormatDateTime('dd/mm/yyyy',FDtCtb);
  edQtd.Text := Format('%.3d',[FQtd]);
  edTotal.Text := Format('%n',[FTotal]);
  gravar.Enabled := FQtd > 0;
end;

procedure TFrmBaixaPagamentoRNP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Cancelar.Execute;
  end;
end;

procedure TFrmBaixaPagamentoRNP.FormShow(Sender: TObject);
begin
  CalcularTotais(edContab.Date);
end;

procedure TFrmBaixaPagamentoRNP.CancelarExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmBaixaPagamentoRNP.edContabChange(Sender: TObject);
begin
  if edContab.Date > Date
  then begin
    MostraErro('Contabilização não pode ser maior que a data atual!');
    edContab.Date := Date;
  end;
  CalcularTotais(edContab.Date);
end;

procedure TFrmBaixaPagamentoRNP.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnBack.Color := vEsquema.CorFundo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  cboAgente.Lista := TControllerFactory.New.Pagamentos.RetornaListaAgentes;
  cboTipoDoc.Lista := TControllerFactory.New.Pagamentos.RetornaListaTipoDocumento;
  edHist.Text := 'PAGTOS RNP';
  edContab.Date := Date;
end;

procedure TFrmBaixaPagamentoRNP.gravarExecute(Sender: TObject);
var
  vPagamentosRnp: iControllerPgRnp;
begin
  if cboAgente.ItemIndex = -1
  then MostraAviso('Precisa informar AGENTE antes de Gravar!')
  else if cboTipoDoc.ItemIndex = -1
  then MostraAviso('Precisa informar TIPO DOCUMENTO antes de Gravar!')
  else if ConfirmaMensagem('Confirma a Gravação?')
  then begin
    vPagamentosRnp := TControllerFactory.New.PagamentosRnp;
    vPagamentosRnp.BaixarPagamentosDataset( cboAgente.getAdicional,
                                            cboTipoDoc.getAdicional,
                                            edHist.Text,
                                            edContab.Date,
                                            FTotal,
                                            FDatasetPagamentos);
    ModalResult := mrOK;
  end;
end;

end.

