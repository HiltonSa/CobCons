unit cobcons.view.parcelaspendentes;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Buttons, DBCtrls, DBGrids, StdCtrls, cobcons.controller.interfaces,
  cobcons.model.bufferdataset;

type

  { TFrmParcelasPendentes }

  TFrmParcelasPendentes = class(TForm)
    AL: TActionList;
    cboCampo: TComboBox;
    edtPesq: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    sair: TAction;
    imp: TAction;
    pnAcoes: TPanel;
    pnBackground: TPanel;
    pnTitulo: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton7: TSpeedButton;
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
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
  FrmParcelasPendentes: TFrmParcelasPendentes;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.rel.parcelaspendentes;

{$R *.lfm}

{ TFrmParcelasPendentes }

procedure TFrmParcelasPendentes.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnBackGround.Color := vEsquema.CorFundo;
end;

procedure TFrmParcelasPendentes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
   VK_RETURN: SelectNext(ActiveControl,True,True);
   VK_ESCAPE: Sair.Execute;
  end;
end;

procedure TFrmParcelasPendentes.impExecute(Sender: TObject);
var
  vBuf: iModelBufferDataset;
begin
  vBuf := TControllerFactory.New.ParcelaComissao.RetornarParcelasPendentes(cboCampo.ItemIndex,edtPesq.Text);
  if vBuf.TemDados
  then begin
    FrmRelParPend := TFrmRelParPend.Create(nil);
    try
      FrmRelParPend.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
      FrmRelParPend.ds.DataSet := vBuf.DataSet;
      FrmRelParPend.RP.Title:='PARCELAS A RECEBER ATE: '+FormatDateTime('dd/mm/yyyy',Date);
      FrmRelParPend.RP.PreviewModal;
    finally
      FrmRelParPend.Free;
    end;
  end
  else  MostraAviso(Format('%s não encontrado!',[edtPesq.Text]));
end;

procedure TFrmParcelasPendentes.sairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmParcelasPendentes.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmParcelasPendentes.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

end.

