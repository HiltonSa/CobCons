unit cobcons.view.vendasagente;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, db, FileUtil, DateTimePicker, Forms, Controls,
  Graphics, Dialogs, ActnList, ExtCtrls, Buttons, StdCtrls, DbCtrls, LCLType,
  HNSCombox, cobcons.controller.interfaces;

type

  { TFrmVendasAgente }

  TFrmVendasAgente = class(TForm)
    AL: TActionList;
    cboVen: THNSCombox;
    ds: TDataSource;
    edDcFil: TEdit;
    edDcEqp: TEdit;
    edDcAtivo: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    pnAcoes: TPanel;
    pnBackGround: TPanel;
    pnTitulo: TPanel;
    sair: TAction;
    imp: TAction;
    SpeedButton5: TSpeedButton;
    SpeedButton8: TSpeedButton;
    procedure cboVenSelect(Sender: TObject);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure impExecute(Sender: TObject);
  private
    { private declarations }
    FAgente: iControllerAgente;
  public
    { public declarations }
  end;

var
  FrmVendasAgente: TFrmVendasAgente;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.rel.vendasagente;

{$R *.lfm}

{ TFrmVendasAgente }

procedure TFrmVendasAgente.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnBackGround.Color := vEsquema.CorFundo;
  FAgente := TControllerFactory.New.Agente;
  cboVen.Lista := FAgente.ListaComboBox;
end;

procedure TFrmVendasAgente.sairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmVendasAgente.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmVendasAgente.cboVenSelect(Sender: TObject);
begin
  FAgente.ListaPorCodigo(cboVen.getCodigo);
  edDcFil.Text   := FAgente.DCFIL;
  edDcEqp.Text   := FAgente.DCEQP;
  edDcAtivo.Text := FAgente.DCATIVO;
end;

procedure TFrmVendasAgente.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmVendasAgente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: SelectNext(ActiveControl,True,True);
    VK_ESCAPE: sair.Execute;
  end;
end;

procedure TFrmVendasAgente.impExecute(Sender: TObject);
var
  vDataset : TDataSet;
begin
  vDataset := TControllerFactory.New.Relatorios(2).VendasAgente( FAgente.CODIGO );
  if not vDataset.EOF
  then begin
    FrmRelVendasAgente := TFrmRelVendasAgente.Create(nil);
    try
      FrmRelVendasAgente.ds.DataSet := vDataset;
      FrmRelVendasAgente.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
      FrmRelVendasAgente.RP.PreviewModal;
    finally
      FrmRelVendasAgente.Free;
    end;
  end
  else MostraAviso('Vendas não encontradas no período!');
end;

end.

