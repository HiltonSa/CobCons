unit cobcons.view.agentes;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Buttons, DBCtrls, DBGrids, StdCtrls, cobcons.controller.interfaces,
  cobcons.model.interfaces;

type

  { TFrmAgentes }

  TFrmAgentes = class(TForm)
    AL: TActionList;
    apagar: TAction;
    btnImprimir: TSpeedButton;
    btnNova: TSpeedButton;
    btnSair: TSpeedButton;
    btnVer: TSpeedButton;
    ds: TDataSource;
    edPesq: TEdit;
    grPesq: TDBGrid;
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
    procedure edPesqExit(Sender: TObject);
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
    FAgente : iControllerAgente;
    procedure AbrirFicha(pCodigo:Integer);
    procedure MensagemRodape(pMsg: String);
    procedure RefreshDataset;
  public

  end;

var
  FrmAgentes: TFrmAgentes;



implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util;

{$R *.lfm}

{ TFrmAgentes }

procedure TFrmAgentes.SairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmAgentes.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnRodape.Color := vEsquema.CorPainelRodape;
  pnBackGround.Color := vEsquema.CorFundo;
  FAgente := TControllerFactory.New.Agente;
  RefreshDataset;
end;

procedure TFrmAgentes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused and not ds.DataSet.EOF
               then AbrirFicha(ds.DataSet.FieldByName('CODIGO').AsInteger)
               else SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
end;

procedure TFrmAgentes.grPesqDblClick(Sender: TObject);
begin
  if not ds.DataSet.EOF
  then AbrirFicha(ds.DataSet.FieldByName('CODIGO').AsInteger);
end;

procedure TFrmAgentes.novaExecute(Sender: TObject);
begin
  AbrirFicha(0);
end;

procedure TFrmAgentes.pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmAgentes.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmAgentes.apagarExecute(Sender: TObject);
begin
  if not ds.DataSet.EOF and ConfirmaMensagem('Excluir Adm?')
  then begin
    FAgente.CODIGO(ds.DataSet.FieldByName('CODIGO').AsInteger).Executar(tmExclusao);
    RefreshDataset;
  end;
end;

procedure TFrmAgentes.edPesqExit(Sender: TObject);
begin
  RefreshDataset;
end;

procedure TFrmAgentes.verExecute(Sender: TObject);
begin
  if not ds.DataSet.EOF
  then AbrirFicha(ds.DataSet.FieldByName('CODIGO').AsInteger);
end;

procedure TFrmAgentes.AbrirFicha(pCodigo: Integer);
begin
  //FrmFichaAdmCon := TFrmFichaAdmCon.Create(nil);
  //try
  //  FrmFichaAdmCon.CodigoEmpresa := pCodigo;
  //  if FrmFichaAdmCon.ShowModal = mrOK
  //  then RefreshDataset;
  //finally
  //  FrmFichaAdmCon.Free;
  //end;
end;

procedure TFrmAgentes.MensagemRodape(pMsg: String);
begin
  pnRodape.Caption := pMsg;
end;

procedure TFrmAgentes.RefreshDataset;
begin
  ds.DataSet := FAgente.ListaPorNome(edPesq.Text);
  if ds.DataSet.EOF
  then MensagemRodape('Nenhum Agente encontrado!')
  else MensagemRodape(Format('Encontradas %d Agentes',[ds.DataSet.RecordCount]));
end;

end.

