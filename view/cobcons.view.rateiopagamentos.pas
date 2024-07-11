unit cobcons.view.rateiopagamentos;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ActnList, ExtCtrls,
  Buttons, DateTimePicker, HNSCombox, DBGrids, Windows, StdCtrls, DBCtrls,
  ComCtrls, DateUtils, DB, cobcons.controller.interfaces;

type

  { TFrmRateioPagamentos }

  TFrmRateioPagamentos = class(TForm)
    AL: TActionList;
    btnPesq1: TSpeedButton;
    btnPesq2: TSpeedButton;
    btnSair: TSpeedButton;
    btnSair1: TSpeedButton;
    pesqisar: TAction;
    cboAgente: THNSCombox;
    cboTipoDoc: THNSCombox;
    ds: TDataSource;
    dtDataBase: TDateTimePicker;
    edHist: TEdit;
    gravar: TAction;
    grPesq: TDBGrid;
    calcular: TAction;
    Label10: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    mmLog: TMemo;
    nvPesq: TDBNavigator;
    Panel2: TPanel;
    Panel4: TPanel;
    Pc: TPageControl;
    pnAcoes: TPanel;
    pnBackGround: TPanel;
    pnTitulo: TPanel;
    Sair: TAction;
    tsDados: TTabSheet;
    tsLog: TTabSheet;
    procedure calcularExecute(Sender: TObject);
    procedure dtDataBaseExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gravarExecute(Sender: TObject);
    procedure pesqisarExecute(Sender: TObject);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SairExecute(Sender: TObject);
  private
    FRateio: iControllerRateioPagamentos;
    FPagamentos: iControllerPagamentos;
    procedure LogMensagem(pMsg: String);
    procedure AbrirFicha;
  public

  end;

var
  FrmRateioPagamentos: TFrmRateioPagamentos;

implementation

uses cobcons.controller.factory, cobcons.controller.util,
 cobcons.model.configura;

{$R *.lfm}

{ TFrmRateioPagamentos }

procedure TFrmRateioPagamentos.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmRateioPagamentos.dtDataBaseExit(Sender: TObject);
begin
  dtDataBase.Date := EndOfTheMonth(dtDataBase.Date);
  pesqisar.Enabled := True;
  edHist.Text := Format('RATEIO REC %s',[FormatDateTime('mmm/yy', dtDataBase.Date)]);
end;

procedure TFrmRateioPagamentos.calcularExecute(Sender: TObject);
begin
  if ConfirmaMensagem('Calcular o Rateio para os grupos?')
  then begin
    Pc.ActivePage := tsLog;
    FRateio.DATABASE(dtDataBase.Date)
           .AGENTE(cboAgente.getAdicional)
           .TIPODOC(cboTipoDoc.getAdicional)
           .HISTORICO(edHist.Text)
           .RateioRecebimentos(ds.DataSet);
    ds.DataSet := FRateio.Dataset;
    DataSetParaPlanilha(ds.DataSet, 'RateioPagamentos.xls');
    gravar.Enabled := True;
  end;
end;

procedure TFrmRateioPagamentos.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnBackGround.Color := vEsquema.CorFundo;
  dtDataBase.Date := StartOfTheMonth(Date) - 1;
  cboAgente.Lista := TControllerFactory.New.Pagamentos.RetornaListaAgentes;
  cboTipoDoc.Lista := TControllerFactory.New.Pagamentos.RetornaListaTipoDocumento;
  edHist.Text := 'RATEIO PAGTOS';
  FPagamentos := TControllerFactory.New.Pagamentos;
  FRateio := TControllerFactory.New.RateioPagamentos;
  FRateio.LOG(LogMensagem);
  gravar.Enabled := False;
end;

procedure TFrmRateioPagamentos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused
               then AbrirFicha
               else SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
end;

procedure TFrmRateioPagamentos.gravarExecute(Sender: TObject);
begin
  if cboAgente.ItemIndex = -1
  then MostraAviso('Precisa informar AGENTE antes de Gravar!')
  else if cboTipoDoc.ItemIndex = -1
  then MostraAviso('Precisa informar TIPO DOCUMENTO antes de Gravar!')
  else if ConfirmaMensagem('Gravar o Rateio calculado?')
  then begin
    Pc.ActivePage := tsLog;
    FRateio.DATABASE(dtDataBase.Date)
           .AGENTE(cboAgente.getAdicional)
           .TIPODOC(cboTipoDoc.getAdicional)
           .HISTORICO(edHist.Text)
           .GravarRateio;
  end;
end;

procedure TFrmRateioPagamentos.pesqisarExecute(Sender: TObject);
begin
  FPagamentos.RetornaPagamentosDataBase(StartOfTheMonth(dtDataBase.Date), EndOfTheMonth(dtDataBase.Date));
  ds.DataSet := FPagamentos.DataSet;
end;

procedure TFrmRateioPagamentos.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmRateioPagamentos.SairExecute(Sender: TObject);
begin
  Close;
end;

procedure TFrmRateioPagamentos.LogMensagem(pMsg: String);
begin
  mmLog.Lines.Add(Pmsg);
end;

procedure TFrmRateioPagamentos.AbrirFicha;
var
  vCota: Boolean;
begin
  vCota := ds.DataSet.FindField('Cota') <> nil;
  if vCota
  then begin
    Self.Visible := False;
    AbrirFichaCota( ds.DataSet.FieldByName('Grupo').AsString,
                    ds.DataSet.FieldByName('Seq').AsString,
                    ds.DataSet.FieldByName('Cota').AsString);
    Self.Visible := True;
  end;
end;

end.

