unit cobcons.view.equipes;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Buttons, DBCtrls, DBGrids, cobcons.controller.interfaces,
  cobcons.model.interfaces;

type

  { TFrmEquipes }

  TFrmEquipes = class(TForm)
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
    FEquipe : iControllerEquipe;
    procedure AbrirFicha(pCodigo:Integer);
    procedure MensagemRodape(pMsg: String);
    procedure RefreshDataset;
  public

  end;

var
  FrmEquipes: TFrmEquipes;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.fichafilial, cobcons.view.fichaequipe;

{$R *.lfm}

{ TFrmEquipes }

procedure TFrmEquipes.SairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmEquipes.apagarExecute(Sender: TObject);
begin
  if not ds.DataSet.EOF and ConfirmaMensagem('Excluir Equipe?')
  then begin
    FEquipe.CODIGO(ds.DataSet.FieldByName('CODIGO').AsInteger).Executar(tmExclusao);
    RefreshDataset;
  end;
end;

procedure TFrmEquipes.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmEquipes.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnRodape.Color := vEsquema.CorPainelRodape;
  pnBackGround.Color := vEsquema.CorFundo;
  FEquipe := TControllerFactory.New.Equipe;
  RefreshDataset;
end;

procedure TFrmEquipes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused and not ds.DataSet.EOF
               then AbrirFicha(ds.DataSet.FieldByName('CODIGO').AsInteger)
               else SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
end;

procedure TFrmEquipes.grPesqDblClick(Sender: TObject);
begin
  if not ds.DataSet.EOF
  then AbrirFicha(ds.DataSet.FieldByName('CODIGO').AsInteger);
end;

procedure TFrmEquipes.novaExecute(Sender: TObject);
begin
  AbrirFicha(0);
end;

procedure TFrmEquipes.pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmEquipes.verExecute(Sender: TObject);
begin
  if not ds.DataSet.EOF
  then AbrirFicha(ds.DataSet.FieldByName('CODIGO').AsInteger);
end;

procedure TFrmEquipes.AbrirFicha(pCodigo: Integer);
begin
  FrmFichaEquipe := TFrmFichaEquipe.Create(nil);
  try
    FrmFichaEquipe.CodigoEquipe := pCodigo;
    if FrmFichaEquipe.ShowModal = mrOK
    then RefreshDataset;
  finally
    FrmFichaEquipe.Free;
  end;
end;

procedure TFrmEquipes.MensagemRodape(pMsg: String);
begin
  pnRodape.Caption := pMsg;
end;

procedure TFrmEquipes.RefreshDataset;
begin
  ds.DataSet := FEquipe.ListaPorNome('');
  if ds.DataSet.EOF
  then MensagemRodape('Nenhuma equipe encontrada!')
  else MensagemRodape(Format('Encontradas %d equipes',[ds.DataSet.RecordCount]));
end;

end.

