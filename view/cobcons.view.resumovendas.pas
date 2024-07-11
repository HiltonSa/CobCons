unit cobcons.view.resumovendas;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Buttons, DBCtrls, DBGrids, StdCtrls, cobcons.controller.interfaces,
  HNSCombox;

type

  { TFrmResumoVendas }

  TFrmResumoVendas = class(TForm)
    AL: TActionList;
    cboPer: THNSCombox;
    edDtCal: TEdit;
    edDtFim: TEdit;
    edDtIni: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    pnAcoes: TPanel;
    pnBackground: TPanel;
    sair: TAction;
    imp: TAction;
    pnTitulo: TPanel;
    SpeedButton5: TSpeedButton;
    SpeedButton8: TSpeedButton;
    procedure cboPerSelect(Sender: TObject);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure impExecute(Sender: TObject);
  private
    { private declarations }
    FPeriodo: iControllerPeriodo;
  public
    { public declarations }
  end;

var
  FrmResumoVendas: TFrmResumoVendas;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.rel.resumovendas;

{$R *.lfm}

{ TFrmResumoVendas }

procedure TFrmResumoVendas.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmResumoVendas.sairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmResumoVendas.cboPerSelect(Sender: TObject);
begin
  FPeriodo.ListaPorCodigo(cboPer.getCodigo);
  edDtIni.Text := FormatDateTime('dd/mm/yyyy', FPeriodo.DTINI);
  edDtFim.Text := FormatDateTime('dd/mm/yyyy', FPeriodo.DTFIM);
  edDtCal.Text := FormatDateTime('dd/mm/yyyy', FPeriodo.DTCAL);
  imp.Enabled:=True;
end;

procedure TFrmResumoVendas.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmResumoVendas.FormCreate(Sender: TObject);
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
end;

procedure TFrmResumoVendas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    case Key of
    VK_RETURN: SelectNext(ActiveControl,True,True);
    VK_ESCAPE: sair.Execute;
  end;
end;

procedure TFrmResumoVendas.impExecute(Sender: TObject);
var
  vDataset : TDataSet;
begin
  vDataset := TControllerFactory.New.Relatorios(2).ResumoVendas(FPeriodo.CODIGO);
  if not vDataset.EOF
  then begin
    FrmRelResumoPeriodo := TFrmRelResumoPeriodo.Create(nil);
    try
       FrmRelResumoPeriodo.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
       FrmRelResumoPeriodo.ds.DataSet := vDataset;
       FrmRelResumoPeriodo.RP.Title := Format('RESUMO DO PERIODO %s - %s a %s',
                           [Trim(FPeriodo.DESCRICAO), DateToStr(FPeriodo.DTINI),
                            DateToStr(FPeriodo.DTINI)]);
       FrmRelResumoPeriodo.RP.PreviewModal;
    finally
      FrmRelResumoPeriodo.Free;
    end;
  end
  //else MostraAviso(Format('Sem comissões para %s em %s!', [cboFil.Text, cboPer.Text]));
  //if DMVendas.abrirResumoPeriodo(perCod.Value) then begin
  //   FrmRelResumoPeriodo := TFrmRelResumoPeriodo.Create(nil);
  //   try
  //      FrmRelResumoPeriodo.RP.Title:=Format('RESUMO DO PERIODO %s - %s a %s',
  //                    [Trim(perDes.Value), DateToStr(perIni.Value),
  //                     DateToStr(perFim.Value)]);
  //      FrmRelResumoPeriodo.RP.PreviewModal;
  //   finally
  //     FrmRelResumoPeriodo.Free;
  //   end;
  //end
  else MostraAviso('Vendas não encontradas!');
end;

end.

