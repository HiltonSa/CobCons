unit cobcons.view.comissaoperiodo;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Buttons, DBCtrls, DBGrids, StdCtrls, cobcons.controller.interfaces,
  HNSCombox;

type

  { TFrmComissaoPeriodo }

  TFrmComissaoPeriodo = class(TForm)
    AL: TActionList;
    cboPer: THNSCombox;
    cboFil: THNSCombox;
    edDtCal: TEdit;
    edDtFim: TEdit;
    edDtIni: TEdit;
    sair: TAction;
    imp: TAction;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    pnAcoes: TPanel;
    pnBackground: TPanel;
    pnTitulo: TPanel;
    SpeedButton5: TSpeedButton;
    SpeedButton8: TSpeedButton;
    procedure cboFilExit(Sender: TObject);
    procedure cboFilSelect(Sender: TObject);
    procedure cboPerSelect(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sairExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure impExecute(Sender: TObject);
  private
    { private declarations }
    FPeriodo: iControllerPeriodo;
    FFil: Integer;
  public
    { public declarations }
  end;

var
  FrmComissaoPeriodo: TFrmComissaoPeriodo;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.rel.pagarcomissao;

{$R *.lfm}

{ TFrmComissaoPeriodo }

procedure TFrmComissaoPeriodo.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnBackGround.Color := vEsquema.CorFundo;
  FPeriodo := TControllerFactory.New.Periodo;
  cboPer.Lista := FPeriodo.ListaComboBox;
  cboFil.Lista := TControllerFactory.New.Filial.ListaComboBox;
  FFil := 0;
end;

procedure TFrmComissaoPeriodo.sairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmComissaoPeriodo.cboPerSelect(Sender: TObject);
begin
  FPeriodo.ListaPorCodigo(cboPer.getCodigo);
  edDtIni.Text := FormatDateTime('dd/mm/yyyy', FPeriodo.DTINI);
  edDtFim.Text := FormatDateTime('dd/mm/yyyy', FPeriodo.DTFIM);
  edDtCal.Text := FormatDateTime('dd/mm/yyyy', FPeriodo.DTCAL);
  imp.Enabled:=True;
end;

procedure TFrmComissaoPeriodo.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmComissaoPeriodo.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmComissaoPeriodo.cboFilSelect(Sender: TObject);
begin
  FFil := cboFil.getCodigo;
end;

procedure TFrmComissaoPeriodo.cboFilExit(Sender: TObject);
begin
  if cboFil.Text=''
  then FFil := 0;
end;

procedure TFrmComissaoPeriodo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
   VK_RETURN: SelectNext(ActiveControl,True,True);
   VK_ESCAPE: sair.Execute;
  end;
end;

procedure TFrmComissaoPeriodo.impExecute(Sender: TObject);
var
  vDataset : TDataSet;
begin
  vDataset := TControllerFactory.New.Relatorios.RelatorioComissoes(FPeriodo.CODIGO, FFil);
  if not vDataset.EOF
  then begin
    FrmRelPagarComissao := TFrmRelPagarComissao.Create(nil);
    try
       FrmRelPagarComissao.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
       FrmRelPagarComissao.ds.DataSet := vDataset;
       FrmRelPagarComissao.RP.PreviewModal;
    finally
      FrmRelPagarComissao.Free;
    end;
  end
  else MostraAviso(Format('Sem comissões para %s em %s!', [cboFil.Text, cboPer.Text]));
end;

end.

