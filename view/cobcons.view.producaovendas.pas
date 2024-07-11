unit cobcons.view.producaovendas;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, FileUtil, DateTimePicker, Forms, Controls,
  Graphics, LCLType, Dialogs, ActnList, ExtCtrls, Buttons, StdCtrls, DbCtrls,
  HNSCombox, dateutils, DB, DBGrids;

type

  { TFrmProducaoVendas }

  TFrmProducaoVendas = class(TForm)
    AL: TActionList;
    cboFil: THNSCombox;
    cboEqp: THNSCombox;
    cboVen: THNSCombox;
    edIni: TDateTimePicker;
    edFim: TDateTimePicker;
    sair: TAction;
    imp: TAction;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    pnBackground: TPanel;
    pnAcoes: TPanel;
    pnTitulo: TPanel;
    SpeedButton5: TSpeedButton;
    SpeedButton8: TSpeedButton;
    procedure cboEqpSelect(Sender: TObject);
    procedure cboFilSelect(Sender: TObject);
    procedure edFimExit(Sender: TObject);
    procedure edIniExit(Sender: TObject);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure impExecute(Sender: TObject);
  private
    { private declarations }
    FCodFil: Integer;
  public
    { public declarations }
  end;

var
  FrmProducaoVendas: TFrmProducaoVendas;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.rel.producaovendas;

{$R *.lfm}

{ TFrmProducaoVendas }

procedure TFrmProducaoVendas.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnBackGround.Color := vEsquema.CorFundo;
  FCodFil:=0;
  edIni.Date:=StartOfTheMonth(Date);
  edFim.Date:=EndOfTheMonth(Date);
  cboFil.Lista := TControllerFactory.New.Filial.ListaComboBox;
end;

procedure TFrmProducaoVendas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: SelectNext(ActiveControl,True,True);
    VK_ESCAPE: sair.Execute;
  end;
end;

procedure TFrmProducaoVendas.impExecute(Sender: TObject);
var
  vDataset : TDataSet;
begin
  vDataset := TControllerFactory.New.Relatorios
                       .ProducaoVendas( edIni.Date,
                                        edFim.Date,
                                        cboVen.getCodigo,
                                        cboEqp.getCodigo,
                                        cboFil.getCodigo);
  if not vDataset.EOF
  then begin
    FrmRelProducao := TFrmRelProducao.Create(nil);
    try
       FrmRelProducao.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
       FrmRelProducao.ds.DataSet    := vDataset;
       FrmRelProducao.RP.Title      := Format('PRODUCAO ENTRE %s E %s',
                      [DateToStr(edIni.Date),DateToStr(edFim.Date)]);
      FrmRelProducao.RP.PreviewModal;
    finally
      FrmRelProducao.Free;
    end;
  end
  else MostraAviso('Vendas não encontradas no período!');

end;

procedure TFrmProducaoVendas.edIniExit(Sender: TObject);
begin
  edFim.Date:=EndOfTheMonth(edIni.Date);
end;

procedure TFrmProducaoVendas.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmProducaoVendas.sairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmProducaoVendas.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmProducaoVendas.edFimExit(Sender: TObject);
begin
  if edIni.Date > edFim.Date then begin
    MostraAviso('Data FINAL deve ser maior que a data INICIAL!');
    edFim.Date:=EndOfTheMonth(edIni.Date);
    edFim.SetFocus;
  end;
end;

procedure TFrmProducaoVendas.cboFilSelect(Sender: TObject);
begin
  FCodFil := cboFil.getCodigo;
  cboEqp.Lista := TControllerFactory.New.Equipe.ListaComboBox(FCodFil);
  cboEqp.Enabled:=True;
  cboVen.Enabled:=True;
end;

procedure TFrmProducaoVendas.cboEqpSelect(Sender: TObject);
begin
  cboVen.Enabled:=True;
  cboVen.Lista := TControllerFactory.New.Agente.ListaComboBox(cboEqp.getCodigo);
end;


{ TFrmProducaoVendas }


end.

