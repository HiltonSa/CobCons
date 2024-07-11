unit cobcons.view.cancelamentosperiodo;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, FileUtil, DateTimePicker, Forms, Controls,
  Graphics, Dialogs, ActnList, ExtCtrls, Buttons, StdCtrls, dateutils, DB,
  LCLType, cobcons.controller.interfaces;

type

  { TFrmCancelamentosPeriodo }

  TFrmCancelamentosPeriodo = class(TForm)
    AL: TActionList;
    edFim: TDateTimePicker;
    edIni: TDateTimePicker;
    pnTitulo: TPanel;
    sair: TAction;
    imp: TAction;
    Label2: TLabel;
    Label3: TLabel;
    pnAcoes: TPanel;
    pnBackground: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton7: TSpeedButton;
    procedure edFimExit(Sender: TObject);
    procedure edIniExit(Sender: TObject);
    procedure sairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure impExecute(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmCancelamentosPeriodo: TFrmCancelamentosPeriodo;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.rel.cancelamentosperiodo;

{$R *.lfm}

{ TFrmCancelamentosPeriodo }

procedure TFrmCancelamentosPeriodo.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnBackGround.Color := vEsquema.CorFundo;
  edIni.Date:=StartOfTheMonth(Date);
  edFim.Date:=EndOfTheMonth(Date);
end;

procedure TFrmCancelamentosPeriodo.edIniExit(Sender: TObject);
begin
  edFim.Date:=EndOfTheMonth(edIni.Date);
end;

procedure TFrmCancelamentosPeriodo.edFimExit(Sender: TObject);
begin
  if edIni.Date > edFim.Date then begin
    MostraAviso('Data FINAL deve ser maior que a data INICIAL!');
    edFim.Date:=EndOfTheMonth(edIni.Date);
    edFim.SetFocus;
  end;
end;

procedure TFrmCancelamentosPeriodo.sairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmCancelamentosPeriodo.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmCancelamentosPeriodo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: SelectNext(ActiveControl,True,True);
    VK_ESCAPE: sair.Execute;
  end;
end;

procedure TFrmCancelamentosPeriodo.impExecute(Sender: TObject);
var
  vDataset : TDataSet;
begin
  vDataset := TControllerFactory.New.Relatorios(2).CancelamentosNoPeriodo(edIni.Date, edFim.Date);
  if not vDataset.EOF
  then begin
    FrmRelCancelamentos := TFrmRelCancelamentos.Create(nil);
    try
       FrmRelCancelamentos.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
       FrmRelCancelamentos.ds.DataSet    := vDataset;
       FrmRelCancelamentos.RP.Title:=Format('CANCELAMENTOS ENTRE %s E %s',
             [DateToStr(edIni.Date), DateToStr(edFim.Date)]);
       FrmRelCancelamentos.RP.PreviewModal;
    finally
      FrmRelCancelamentos.Free;
    end;
  end
  else MostraAviso('Cancelamentos não encontrados!');
end;

end.

