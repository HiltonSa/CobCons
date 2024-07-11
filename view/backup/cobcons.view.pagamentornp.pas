unit cobcons.view.pagamentornp;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ActnList, ExtCtrls,
  Buttons, cobcons.controller.interfaces, StdCtrls, DBCtrls, DBGrids,
  DateTimePicker, Windows, DateUtils;

type

  { TFrmPagamentoRnp }

  TFrmPagamentoRnp = class(TForm)
    btnPesq1: TSpeedButton;
    imprel: TAction;
    AL: TActionList;
    btnPesq: TSpeedButton;
    btnPesq2: TSpeedButton;
    btnPesq3: TSpeedButton;
    btnSair: TSpeedButton;
    cboCampo: TComboBox;
    baixa: TAction;
    ds: TDataSource;
    edPrev: TDateTimePicker;
    edQtd: TEdit;
    edTotal: TEdit;
    grPesq: TDBGrid;
    Label4: TLabel;
    Label8: TLabel;
    solicitar: TAction;
    Label1: TLabel;
    Label2: TLabel;
    nvPesq: TDBNavigator;
    Panel2: TPanel;
    Panel4: TPanel;
    exportar: TAction;
    pnAcoes: TPanel;
    pnBackGround: TPanel;
    pnTitulo: TPanel;
    Sair: TAction;
    procedure baixaExecute(Sender: TObject);
    procedure cboCampoSelect(Sender: TObject);
    procedure edPrevChange(Sender: TObject);
    procedure exportarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure grPesqDblClick(Sender: TObject);
    procedure grPesqKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imprelExecute(Sender: TObject);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SairExecute(Sender: TObject);
    procedure solicitarExecute(Sender: TObject);
  private
    FPagamentos: iControllerPgRnp;
    procedure AbrirFicha(pGrupo, pSeq, pCota: String);
    procedure PosicionarDataset(pStatus: Integer);
  public

  end;

var
  FrmPagamentoRnp: TFrmPagamentoRnp;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.devolucaopagamentos,
  cobcons.view.solicitapagtornp, cobcons.view.baixapagamentornp,
  cobcons.view.exportarpagrnp, cobcons.view.rel.pagamentornp;

{$R *.lfm}

{ TFrmPagamentoRnp }

procedure TFrmPagamentoRnp.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmPagamentoRnp.cboCampoSelect(Sender: TObject);
begin
  PosicionarDataset(cboCampo.ItemIndex);
end;

procedure TFrmPagamentoRnp.baixaExecute(Sender: TObject);
begin
  FrmBaixaPagamentoRNP := TFrmBaixaPagamentoRNP.Create(nil);
  try
     FrmBaixaPagamentoRNP.DatasetPagamentos := ds.DataSet;
     if FrmBaixaPagamentoRNP.ShowModal = mrOK
     then PosicionarDataset(1);
  finally
    FrmBaixaPagamentoRNP.Free;
  end;
end;

procedure TFrmPagamentoRnp.edPrevChange(Sender: TObject);
begin
  PosicionarDataset(cboCampo.ItemIndex);
end;

procedure TFrmPagamentoRnp.exportarExecute(Sender: TObject);
begin
  FrmExportarPgRnp := TFrmExportarPgRnp.Create(nil);
  try
     FrmExportarPgRnp.DatasetPagamentos := ds.DataSet;
     if FrmExportarPgRnp.ShowModal = mrOK
     then begin
       PosicionarDataset(3);
       MostraAviso('Fim da exportação!');
     end;
  finally
    FrmExportarPgRnp.Free;
  end;
end;

procedure TFrmPagamentoRnp.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnBackGround.Color := vEsquema.CorFundo;
  FPagamentos := TControllerFactory.New.PagamentosRnp;
  edPrev.Date := Date + 10;
end;

procedure TFrmPagamentoRnp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused
               then AbrirFicha( ds.DataSet.FieldByName('Grupo').AsString,
                                ds.DataSet.FieldByName('Seq').AsString,
                                ds.DataSet.FieldByName('Cota').AsString);
    VK_ESCAPE: Sair.Execute;
  end;
end;

procedure TFrmPagamentoRnp.FormShow(Sender: TObject);
begin
  PosicionarDataset(0);
end;

procedure TFrmPagamentoRnp.grPesqDblClick(Sender: TObject);
begin
  AbrirFicha( ds.DataSet.FieldByName('Grupo').AsString,
              ds.DataSet.FieldByName('Seq').AsString,
              ds.DataSet.FieldByName('Cota').AsString);
end;

procedure TFrmPagamentoRnp.grPesqKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  vCod: Integer;
  vPgRnp: iControllerPgRnp;
begin
  if (Key = VK_DELETE) and (cboCampo.ItemIndex = 0)
  then begin
    vCod := ds.DataSet.FieldByName('CODIGO').AsInteger;
    if ConfirmaMensagem(Format('Excluir o pagamento %.3d?',[vCod]))
    then begin
      vPgRnp := TControllerFactory.New.PagamentosRnp;
      vPgRnp.CODIGO(vCod).Excluir;
      PosicionarDataset(0);
    end;
  end;
end;

procedure TFrmPagamentoRnp.imprelExecute(Sender: TObject);
begin
  FrmRelPagamentoRnp := TFrmRelPagamentoRnp.Create(nil);
  try
    FrmRelPagamentoRnp.ds.DataSet := ds.DataSet;
    FrmRelPagamentoRnp.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
    FrmRelPagamentoRnp.rl.PreviewModal;
  finally
    FrmRelPagamentoRnp.Free;
  end;
end;

procedure TFrmPagamentoRnp.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmPagamentoRnp.SairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmPagamentoRnp.solicitarExecute(Sender: TObject);
begin
  FrmSolicitaPagtoRnp := TFrmSolicitaPagtoRnp.Create(nil);
  try
    FrmSolicitaPagtoRnp.DatasetSolicita := ds.DataSet;
    if FrmSolicitaPagtoRnp.ShowModal = mrOK
    then PosicionarDataset(0);
  finally
    FrmSolicitaPagtoRnp.Free;
  end;
end;

procedure TFrmPagamentoRnp.AbrirFicha(pGrupo, pSeq, pCota: String);
var
  vCota : iControllerCota;
begin
  vCota := TControllerFactory.New.Cota.PesquisarGrupoSeqCota(pGrupo, pSeq, pCota);
  frmDevCon := TfrmDevCon.Create(nil);
  try
    frmDevCon.Cliente := vCota;
    if frmDevCon.ShowModal = mrOK
    then PosicionarDataset(cboCampo.ItemIndex);
  finally
    frmDevCon.Free;
  end;

end;

procedure TFrmPagamentoRnp.PosicionarDataset(pStatus: Integer);
var
  vTotal: Double;
  vDataset: TDataSet;
begin
  FPagamentos.STATUS(pStatus).DTPROG(edPrev.Date).RetornaStatus;
  vDataSet := FPagamentos.DataSet;
  vTotal := 0;
  while not vDataSet.EOF do
  begin
    vTotal := vTotal + vDataset.FieldByName('VALOR').AsFloat;
    vDataSet.Next;
  end;
  ds.DataSet := vDataset;
  ds.DataSet.First;
  edQtd.Text := Format('%.4d',[vDataset.RecordCount]);
  edTotal.Text := Format('%n',[vTotal]);
  imprel.Enabled := vTotal > 0;
  solicitar.Enabled := (pStatus = 0) and (vTotal > 0);
  baixa.Enabled := (pStatus = 1) and (vTotal > 0);
  exportar.Enabled := (pStatus >= 2) and (vTotal > 0);

end;

end.

