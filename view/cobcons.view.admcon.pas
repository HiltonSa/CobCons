unit cobcons.view.admcon;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Buttons, DBCtrls, DBGrids, cobcons.controller.interfaces,
  cobcons.model.interfaces;

type

  { TFrmAdmCon }

  TFrmAdmCon = class(TForm)
    AL: TActionList;
    apagar: TAction;
    btnImprimir: TSpeedButton;
    btnNova: TSpeedButton;
    btnSair: TSpeedButton;
    btnVer: TSpeedButton;
    ds: TDataSource;
    grPesq: TDBGrid;
    imprimir: TAction;
    nova: TAction;
    nvPesq: TDBNavigator;
    Panel4: TPanel;
    pnAcoes: TPanel;
    pnBackGround: TPanel;
    pnRodape: TPanel;
    pnTitulo: TPanel;
    Sair: TAction;
    ver: TAction;
    procedure apagarExecute(Sender: TObject);
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
    FAdmCon : iControllerAdmcon;
    procedure AbrirFicha(pCodigo:Integer);
    procedure MensagemRodape(pMsg: String);
    procedure RefreshDataset;
  public

  end;

var
  FrmAdmCon: TFrmAdmCon;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.fichaadmcon;

{$R *.lfm}

{ TFrmAdmCon }

procedure TFrmAdmCon.SairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmAdmCon.verExecute(Sender: TObject);
begin
  if not ds.DataSet.EOF
  then AbrirFicha(ds.DataSet.FieldByName('CODIGO').AsInteger);
end;

procedure TFrmAdmCon.AbrirFicha(pCodigo: Integer);
begin
  FrmFichaAdmCon := TFrmFichaAdmCon.Create(nil);
  try
    FrmFichaAdmCon.CodigoEmpresa := pCodigo;
    if FrmFichaAdmCon.ShowModal = mrOK
    then RefreshDataset;
  finally
    FrmFichaAdmCon.Free;
  end;
end;

procedure TFrmAdmCon.MensagemRodape(pMsg: String);
begin
  pnRodape.Caption := pMsg;
end;

procedure TFrmAdmCon.RefreshDataset;
begin
  ds.DataSet := FAdmCon.ListaPorNome('');
  if ds.DataSet.EOF
  then MensagemRodape('Nenhuma Adm Consorcio encontrada!')
  else MensagemRodape(Format('Encontradas %d Adm Consorcios',[ds.DataSet.RecordCount]));
end;

procedure TFrmAdmCon.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnRodape.Color := vEsquema.CorPainelRodape;
  pnBackGround.Color := vEsquema.CorFundo;
  FAdmCon := TControllerFactory.New.AdmCon;
  RefreshDataset;
end;

procedure TFrmAdmCon.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmAdmCon.apagarExecute(Sender: TObject);
begin
  if not ds.DataSet.EOF and ConfirmaMensagem('Excluir Adm?')
  then begin
    FAdmCon.CODIGO(ds.DataSet.FieldByName('CODIGO').AsInteger).Executar(tmExclusao);
    RefreshDataset;
  end;
end;

procedure TFrmAdmCon.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused and not ds.DataSet.EOF
               then AbrirFicha(ds.DataSet.FieldByName('CODIGO').AsInteger)
               else SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
end;

procedure TFrmAdmCon.grPesqDblClick(Sender: TObject);
begin
  if not ds.DataSet.EOF
  then AbrirFicha(ds.DataSet.FieldByName('CODIGO').AsInteger);
end;

procedure TFrmAdmCon.novaExecute(Sender: TObject);
begin
  AbrirFicha(0);
end;

procedure TFrmAdmCon.pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

end.

