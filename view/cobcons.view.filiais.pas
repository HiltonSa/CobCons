unit cobcons.view.filiais;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Buttons, DBCtrls, DBGrids, cobcons.controller.interfaces,
  cobcons.model.interfaces;

type

  { TFrmFiliais }

  TFrmFiliais = class(TForm)
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
    FFilial : iControllerFilial;
    procedure AbrirFicha(pCodigo:Integer);
    procedure MensagemRodape(pMsg: String);
    procedure RefreshDataset;
  public

  end;

var
  FrmFiliais: TFrmFiliais;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.fichafilial;

{$R *.lfm}

{ TFrmFiliais }

procedure TFrmFiliais.SairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmFiliais.verExecute(Sender: TObject);
begin
  if not ds.DataSet.EOF
  then AbrirFicha(ds.DataSet.FieldByName('CODIGO').AsInteger);
end;

procedure TFrmFiliais.apagarExecute(Sender: TObject);
begin
  if not ds.DataSet.EOF and ConfirmaMensagem('Excluir Filial?')
  then begin
    FFilial.CODIGO(ds.DataSet.FieldByName('CODIGO').AsInteger).Executar(tmExclusao);
    RefreshDataset;
  end;
end;

procedure TFrmFiliais.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmFiliais.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnRodape.Color := vEsquema.CorPainelRodape;
  pnBackGround.Color := vEsquema.CorFundo;
  FFilial := TControllerFactory.New.Filial;
  RefreshDataset;
end;

procedure TFrmFiliais.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused and not ds.DataSet.EOF
               then AbrirFicha(ds.DataSet.FieldByName('CODIGO').AsInteger)
               else SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
end;

procedure TFrmFiliais.grPesqDblClick(Sender: TObject);
begin
  if not ds.DataSet.EOF
  then AbrirFicha(ds.DataSet.FieldByName('CODIGO').AsInteger);
end;

procedure TFrmFiliais.novaExecute(Sender: TObject);
begin
  AbrirFicha(0);
end;

procedure TFrmFiliais.pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmFiliais.AbrirFicha(pCodigo: Integer);
begin
  FrmFichaFilial := TFrmFichaFilial.Create(nil);
  try
    FrmFichaFilial.CodigoFilial := pCodigo;
    if FrmFichaFilial.ShowModal = mrOK
    then RefreshDataset;
  finally
    FrmFichaFilial.Free;
  end;
end;

procedure TFrmFiliais.MensagemRodape(pMsg: String);
begin
  pnRodape.Caption := pMsg;
end;

procedure TFrmFiliais.RefreshDataset;
begin
  ds.DataSet := FFilial.ListaPorNome('');
  if ds.DataSet.EOF
  then MensagemRodape('Nenhuma filial encontrada!')
  else MensagemRodape(Format('Encontradas %d filiais',[ds.DataSet.RecordCount]));
end;

end.

