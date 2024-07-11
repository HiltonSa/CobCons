unit cobcons.view.faixascomissao;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Buttons, DBGrids, DBCtrls, StdCtrls, HNSCombox,
  cobcons.controller.interfaces, cobcons.model.interfaces;

type

  { TFrmFaixasComissao }

  TFrmFaixasComissao = class(TForm)
    AL: TActionList;
    apagar: TAction;
    btnImprimir: TSpeedButton;
    btnNova: TSpeedButton;
    btnSair: TSpeedButton;
    btnVer: TSpeedButton;
    ds: TDataSource;
    grPesq: TDBGrid;
    cboAdm: THNSCombox;
    imprimir: TAction;
    Label1: TLabel;
    nova: TAction;
    nvPesq: TDBNavigator;
    Panel1: TPanel;
    Panel4: TPanel;
    pnAcoes: TPanel;
    pnBackGround: TPanel;
    pnRodape: TPanel;
    pnTitulo: TPanel;
    Sair: TAction;
    ver: TAction;
    procedure apagarExecute(Sender: TObject);
    procedure cboAdmSelect(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grPesqDblClick(Sender: TObject);
    procedure novaExecute(Sender: TObject);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SairExecute(Sender: TObject);
    procedure verExecute(Sender: TObject);
  private
    FFaixasEmpresa: iControllerFaixaComissao;
    procedure AbrirFicha(pCodigo:Integer);
    procedure MensagemRodape(pMsg: String);
    procedure RefreshDataset;
  public

  end;

var
  FrmFaixasComissao: TFrmFaixasComissao;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.fichafaixacomissao;

{$R *.lfm}

{ TFrmFaixasComissao }

procedure TFrmFaixasComissao.SairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmFaixasComissao.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnRodape.Color := vEsquema.CorPainelRodape;
  pnBackGround.Color := vEsquema.CorFundo;
  cboAdm.Lista := TControllerFactory.New.AdmCon.ListaComboBox;
  FFaixasEmpresa := TControllerFactory.New.FaixaComissao;
end;

procedure TFrmFaixasComissao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused and not ds.DataSet.EOF
               then AbrirFicha(ds.DataSet.FieldByName('CODIGO').AsInteger)
               else SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
end;

procedure TFrmFaixasComissao.grPesqDblClick(Sender: TObject);
begin
  if not ds.DataSet.EOF
  then AbrirFicha(ds.DataSet.FieldByName('CODIGO').AsInteger);
end;

procedure TFrmFaixasComissao.novaExecute(Sender: TObject);
begin
  if cboAdm.getCodigo > 0
  then AbrirFicha(0);
end;

procedure TFrmFaixasComissao.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmFaixasComissao.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmFaixasComissao.cboAdmSelect(Sender: TObject);
begin
  RefreshDataset;
end;

procedure TFrmFaixasComissao.apagarExecute(Sender: TObject);
begin
  if not ds.DataSet.EOF and ConfirmaMensagem('Excluir Faixa?')
  then begin
    FFaixasEmpresa.CODIGO(ds.DataSet.FieldByName('CODIGO').AsInteger).Executar(tmExclusao);
    RefreshDataset;
  end;
end;

procedure TFrmFaixasComissao.verExecute(Sender: TObject);
begin
  if not ds.DataSet.EOF
  then AbrirFicha(ds.DataSet.FieldByName('CODIGO').AsInteger);
end;

procedure TFrmFaixasComissao.AbrirFicha(pCodigo: Integer);
begin
  FrmFichaFaixaComissao := TFrmFichaFaixaComissao.Create(nil);
  try
    FrmFichaFaixaComissao.CodigoFaixa := pCodigo;
    FrmFichaFaixaComissao.CodigoEmpresa := cboAdm.getCodigo;
    if FrmFichaFaixaComissao.ShowModal = mrOK
    then RefreshDataset;
  finally
    FrmFichaFaixaComissao.Free;
  end;
end;

procedure TFrmFaixasComissao.MensagemRodape(pMsg: String);
begin
  pnRodape.Caption := pMsg;
end;

procedure TFrmFaixasComissao.RefreshDataset;
begin
  ds.DataSet := FFaixasEmpresa.ListaPorEmpresa(cboAdm.getCodigo);
end;

end.

