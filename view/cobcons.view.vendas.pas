unit cobcons.view.vendas;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Buttons, DBCtrls, DBGrids, StdCtrls, cobcons.controller.interfaces,
  cobcons.model.interfaces, cobcons.model.bufferdataset;

type

  { TFrmVendas }

  TFrmVendas = class(TForm)
    edPeriodo: TEdit;
    grPesq: TDBGrid;
    Label3: TLabel;
    nvPesq: TDBNavigator;
    parcela: TAction;
    AL: TActionList;
    Alterar: TAction;
    btPesq: TSpeedButton;
    cboCampo: TComboBox;
    dsPesq: TDataSource;
    edtPesq: TEdit;
    Excluir: TAction;
    Sair: TAction;
    Incluir: TAction;
    Label1: TLabel;
    Label2: TLabel;
    pnAcoes: TPanel;
    pnBackGround: TPanel;
    Panel3: TPanel;
    Pesq: TAction;
    pnRodape: TPanel;
    pnTitulo: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    procedure AlterarExecute(Sender: TObject);
    procedure dsPesqStateChange(Sender: TObject);
    procedure ExcluirExecute(Sender: TObject);
    procedure grPesqDblClick(Sender: TObject);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grPesqTitleClick(Column: TColumn);
    procedure IncluirExecute(Sender: TObject);
    procedure parcelaExecute(Sender: TObject);
    procedure PesqExecute(Sender: TObject);
  private
    { private declarations }
    FVendas: iControllerVenda;
    FBufDataset: iModelBufferDataset;
    function AbrirFicha(pCodigo: Integer): TModalResult;
    procedure MensagemRodape(pMsg: String);
  public
    { public declarations }
  end;

var
  FrmVendas: TFrmVendas;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.fichavenda,
  cobcons.view.parcelascomissao;

{$R *.lfm}

{ TFrmVendas }

procedure TFrmVendas.AlterarExecute(Sender: TObject);
begin
  if (not dsPesq.DataSet.Eof)
     and (AbrirFicha(dsPesq.DataSet.FieldByName('codigo').AsInteger) = mrOK)
  then Pesq.Execute;
end;

procedure TFrmVendas.dsPesqStateChange(Sender: TObject);
begin
  Alterar.Enabled := (dsPesq.State = dsBrowse);
  Excluir.Enabled := Alterar.Enabled;
  parcela.Enabled:=Alterar.Enabled;
end;

procedure TFrmVendas.ExcluirExecute(Sender: TObject);
var
  vCod: Integer;
begin
  vCod := dsPesq.DataSet.FieldByName('codigo').AsInteger;
  if ConfirmaMensagem(Format('Confirma a exclusão da venda %d?',[vCod])) then begin
    FVendas.ListaPorCodigo(vCod)
           .Executar(tmExclusao);
    Pesq.Execute;
  end;
end;

procedure TFrmVendas.grPesqDblClick(Sender: TObject);
begin
  if not dsPesq.DataSet.EOF
  then AbrirFicha(dsPesq.DataSet.FieldByName('codigo').AsInteger);
end;

procedure TFrmVendas.pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;


procedure TFrmVendas.SairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmVendas.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmVendas.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
  vPeriodo: iControllerPeriodo;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  vPeriodo := TControllerFactory.New.Periodo;
  vPeriodo.RetornaPeriodoAtual;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnRodape.Color := vEsquema.CorPainelRodape;
  pnBackGround.Color := vEsquema.CorFundo;
  grPesq.AlternateColor := vEsquema.CorFundo;
  FVendas := TControllerFactory.New.Venda;
  FBufDataset := TModelBufferDataset.New;
  edPeriodo.Text := vPeriodo.DESCRICAO;
end;

procedure TFrmVendas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused and not dsPesq.DataSet.EOF
               then AbrirFicha(dsPesq.DataSet.FieldByName('codigo').AsInteger)
               else if edtPesq.Focused
               then Pesq.Execute
               else SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
end;

procedure TFrmVendas.grPesqTitleClick(Column: TColumn);
begin
  FBufDataset.OrdenarPorCampos(Column.FieldName);
end;

procedure TFrmVendas.IncluirExecute(Sender: TObject);
begin
  if AbrirFicha(0) = mrOk
  then Pesq.Execute;
end;

procedure TFrmVendas.parcelaExecute(Sender: TObject);
begin
  FrmParcelasComissao := TFrmParcelasComissao.Create(nil);
  try
    FrmParcelasComissao.CodigoVenda := dsPesq.DataSet.FieldByName('codigo').AsInteger;
    FrmParcelasComissao.ShowModal;
  finally
    FrmParcelasComissao.Free;
  end;
end;

procedure TFrmVendas.PesqExecute(Sender: TObject);
begin
  FBufDataset := FVendas.RetornarVendas(cboCampo.ItemIndex,edtPesq.Text);
  if FBufDataset.TemDados
  then begin
    MensagemRodape(Format('Encontradas %d ocorrencias para %s...',
         [FBufDataset.QtdeRegistros,edtPesq.Text]));
    dsPesq.DataSet := FBufDataset.DataSet;
  end
  else  MensagemRodape(Format('%s não encontrado!',[edtPesq.Text]));
end;

function TFrmVendas.AbrirFicha(pCodigo: Integer): TModalResult;
begin
  FrmFichaVenda := TFrmFichaVenda.Create(Nil);
  try
    FrmFichaVenda.CodigoVenda := pCodigo;
    Result:=FrmFichaVenda.ShowModal;
  finally
    FrmFichaVenda.Free;
  end;
end;

procedure TFrmVendas.MensagemRodape(pMsg: String);
begin
  pnRodape.Caption := pMsg;
end;

end.

