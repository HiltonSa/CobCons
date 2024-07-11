unit cobcons.view.regrascomissao;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Buttons, DBGrids, DBCtrls, StdCtrls, HNSCombox,
  cobcons.controller.interfaces, cobcons.model.interfaces;

type

  { TFrmRegrasComissao }

  TFrmRegrasComissao = class(TForm)
    AL: TActionList;
    apagar: TAction;
    btnImprimir: TSpeedButton;
    btnNova: TSpeedButton;
    btnSair: TSpeedButton;
    btnVer: TSpeedButton;
    cboAdm: THNSCombox;
    cboFaixa: THNSCombox;
    ds: TDataSource;
    grPesq: TDBGrid;
    imprimir: TAction;
    Label1: TLabel;
    Label2: TLabel;
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
    procedure cboFaixaSelect(Sender: TObject);
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
    FRegras: iControllerRegraComissao;
    procedure AbrirFicha(pAlterar:Boolean);
    procedure MensagemRodape(pMsg: String);
    procedure RefreshDataset;
  public

  end;

var
  FrmRegrasComissao: TFrmRegrasComissao;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.ficharegracomissao;

{$R *.lfm}

{ TFrmRegrasComissao }

procedure TFrmRegrasComissao.SairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmRegrasComissao.verExecute(Sender: TObject);
begin
  if not ds.DataSet.EOF
  then AbrirFicha(False);
end;

procedure TFrmRegrasComissao.AbrirFicha(pAlterar: Boolean);
begin
  FrmFichaRegraComissao := TFrmFichaRegraComissao.Create(nil);
  try
    FrmFichaRegraComissao.CodigoFaixa := cboFaixa.getCodigo;
    FrmFichaRegraComissao.CodigoEmpresa := cboAdm.getCodigo;
    if pAlterar
    then FrmFichaRegraComissao.Parcela := ds.DataSet.FieldByName('parcela').AsInteger
    else FrmFichaRegraComissao.Parcela := 0;
    if FrmFichaRegraComissao.ShowModal = mrOK
    then RefreshDataset;
  finally
    FrmFichaRegraComissao.Free;
  end;
end;

procedure TFrmRegrasComissao.MensagemRodape(pMsg: String);
begin
  pnRodape.Caption := pMsg;
end;

procedure TFrmRegrasComissao.RefreshDataset;
var
  vMsg: String;
begin
  vMsg := '';
  if (cboAdm.getCodigo > 0) and (cboFaixa.getCodigo >0)
  then begin
    ds.DataSet := FRegras.ListaParcelasFaixa(cboAdm.getCodigo, cboFaixa.getCodigo);
    if ds.DataSet.EOF
    then vMsg := Format('Regras não encontradas (Empresa: %.3d Faixa: %.3d)!',[cboAdm.getCodigo, cboFaixa.getCodigo])
    else vMsg := Format('Encontradas %d Regras!',[ds.DataSet.RecordCount]);
  end;
  MensagemRodape(vMsg);
end;

procedure TFrmRegrasComissao.FormCreate(Sender: TObject);
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
  FRegras := TControllerFactory.New.RegraComissao;
end;

procedure TFrmRegrasComissao.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmRegrasComissao.cboAdmSelect(Sender: TObject);
begin
  cboFaixa.Lista := TControllerFactory.New.FaixaComissao.ListaComboBox(cboAdm.getCodigo);
end;

procedure TFrmRegrasComissao.cboFaixaSelect(Sender: TObject);
begin
  RefreshDataset;
end;

procedure TFrmRegrasComissao.apagarExecute(Sender: TObject);
begin
  if not ds.DataSet.EOF and ConfirmaMensagem('Excluir Faixa?')
  then begin
    //FRegras.CODIGO(ds.DataSet.FieldByName('CODIGO').AsInteger).Executar(tmExclusao);
    RefreshDataset;
  end;
end;

procedure TFrmRegrasComissao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused and not ds.DataSet.EOF
               then AbrirFicha(True)
               else SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
end;

procedure TFrmRegrasComissao.grPesqDblClick(Sender: TObject);
begin
  if not ds.DataSet.EOF
  then AbrirFicha(True);
end;

procedure TFrmRegrasComissao.novaExecute(Sender: TObject);
begin
  if cboAdm.getCodigo > 0
  then AbrirFicha(False);
end;

procedure TFrmRegrasComissao.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;



end.

