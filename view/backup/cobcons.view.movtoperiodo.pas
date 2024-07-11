unit cobcons.view.movtoperiodo;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ActnList,
  ExtCtrls, Buttons, DBCtrls, ComCtrls, StdCtrls, DBGrids,
  cobcons.controller.interfaces, DateTimePicker;

type

  { TFrmMovtoPeriodo }

  TFrmMovtoPeriodo = class(TForm)
    btnPesq2: TSpeedButton;
    cbPgRnp: TCheckBox;
    excluir: TAction;
    AL: TActionList;
    btnPesq: TSpeedButton;
    btnPesq1: TSpeedButton;
    btnSair: TSpeedButton;
    dtInicio: TDateTimePicker;
    ds: TDataSource;
    dtFim: TDateTimePicker;
    grPesq: TDBGrid;
    imprimir: TAction;
    Label1: TLabel;
    Label2: TLabel;
    nvPesq: TDBNavigator;
    Panel2: TPanel;
    Panel4: TPanel;
    pnAcoes: TPanel;
    pnBackGround: TPanel;
    pnRodape: TPanel;
    pnTitulo: TPanel;
    Sair: TAction;
    pesquisar: TAction;
    procedure excluirExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grPesqDblClick(Sender: TObject);
    procedure imprimirExecute(Sender: TObject);
    procedure pesquisarExecute(Sender: TObject);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SairExecute(Sender: TObject);
  private
    FRelatorio: iControllerRelatorio;
    procedure AbrirFicha;
    procedure MensagemRodape(pMsg: String);
  public

  end;

var
  FrmMovtoPeriodo: TFrmMovtoPeriodo;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, DateUtils, cobcons.view.rel.movtoperiodo,
  cobcons.view.rel.movperiododetalhe, cobcons.view.rel.pagtornpperiodo;

{$R *.lfm}

{ TFrmMovtoPeriodo }

procedure TFrmMovtoPeriodo.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmMovtoPeriodo.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmMovtoPeriodo.excluirExecute(Sender: TObject);
begin
  if not ds.DataSet.EOF
  then begin
    if ConfirmaMensagem('Excluir o movimento?')
    then begin
      TControllerFactory.New.Pagamentos.ExcluirComissaoPermanencia(
            ds.DataSet.FieldByName('AG_FINAN').AsString,
            ds.DataSet.FieldByName('NR_DOCUM').AsString);
      pesquisar.Execute;
    end;
  end;
end;

procedure TFrmMovtoPeriodo.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnRodape.Color := vEsquema.CorPainelRodape;
  pnBackGround.Color := vEsquema.CorFundo;
  dtInicio.Date := StartOfTheMonth(StartOfTheMonth(Date)-1);
  dtFim.Date := EndOfTheMonth(dtInicio.Date);
  FRelatorio := TControllerFactory.New.Relatorios;
end;

procedure TFrmMovtoPeriodo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused then AbrirFicha;
    VK_ESCAPE: Sair.Execute;
  end;
end;

procedure TFrmMovtoPeriodo.grPesqDblClick(Sender: TObject);
begin
  AbrirFicha;
end;

procedure TFrmMovtoPeriodo.imprimirExecute(Sender: TObject);
begin
  if cbPgRnp.Checked
  then begin
    FrmRelPgtoRnpPeriodo := TFrmRelPgtoRnpPeriodo.Create(NIL);
    try
      FrmRelPgtoRnpPeriodo.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
      FrmRelPgtoRnpPeriodo.ds.DataSet := ds.DataSet;
      FrmRelPgtoRnpPeriodo.rl.Title := Format('PAGAMENTOS RNP ENTRE %s E %s',[DateToStr(dtInicio.Date), DateToStr(dtFim.Date)]);
      FrmRelPgtoRnpPeriodo.rl.PreviewModal;
    finally
      FrmRelPgtoRnpPeriodo.Free;
    end;
  end
  else begin
    FrmRelMovtoPeriodo := TFrmRelMovtoPeriodo.Create(nil);
    try
      FrmRelMovtoPeriodo.lbTit.Caption := Format('MOVIMENTO NO PERIODO %s E %s',[DateToStr(dtInicio.Date), DateToStr(dtFim.Date)]);
      FrmRelMovtoPeriodo.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
      FrmRelMovtoPeriodo.Ds.DataSet := ds.DataSet;
      FrmRelMovtoPeriodo.rl.PreviewModal;
    finally
      FrmRelMovtoPeriodo.Free;
    end;
  end;
end;

procedure TFrmMovtoPeriodo.pesquisarExecute(Sender: TObject);
begin
  if cbPgRnp.Checked
  then ds.DataSet := FRelatorio.PagamentosRnpPeriodo(dtInicio.Date, dtFim.Date)
  else ds.DataSet := FRelatorio.MovimentosNoPeriodo(dtInicio.Date, dtFim.Date);
end;

procedure TFrmMovtoPeriodo.SairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmMovtoPeriodo.AbrirFicha;
var
  vRelatorio : iControllerRelatorio;
begin

  if (not ds.DataSet.EOF)
  then begin
    if cbPgRnp.Checked
    then begin
      Self.Visible := False;
      AbrirFichaCota( ds.DataSet.FieldByName('Grupo').AsString,
                      ds.DataSet.FieldByName('Seq').AsString,
                      ds.DataSet.FieldByName('Cota').AsString);
      Self.Visible := True;
    end
    else begin
        vRelatorio := TControllerFactory.New.Relatorios;
        FrmRelMovPeriodoDetalhe := TFrmRelMovPeriodoDetalhe.Create(NIL);
        try
          FrmRelMovPeriodoDetalhe.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
          FrmRelMovPeriodoDetalhe.dsMaster.DataSet := ds.DataSet;
          FrmRelMovPeriodoDetalhe.ds.DataSet := vRelatorio.MovimentosPeriodoDetalhe(
                      ds.DataSet.FieldByName('AG_FINAN').AsString,
                      ds.DataSet.FieldByName('NR_DOCUM').AsString,
                      ds.DataSet.FieldByName('D_CONTAB').AsDateTime);
          FrmRelMovPeriodoDetalhe.rl.PreviewModal;
        finally
          FrmRelMovPeriodoDetalhe.Free;
        end;
    end;
  end;
end;

procedure TFrmMovtoPeriodo.MensagemRodape(pMsg: String);
begin
  Pnrodape.Caption := Pmsg;
end;

end.

