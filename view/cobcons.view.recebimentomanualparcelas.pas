unit cobcons.view.recebimentomanualparcelas;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Buttons, DBCtrls, DBGrids, StdCtrls, cobcons.controller.interfaces,
  cobcons.model.interfaces, cobcons.model.bufferdataset;

type

  { TFrmRecebimentoManual }

  TFrmRecebimentoManual = class(TForm)
    AL: TActionList;
    grPesq: TDBGrid;
    nvPesq: TDBNavigator;
    pnRodape: TPanel;
    pnTitulo: TPanel;
    receber: TAction;
    btPesq: TSpeedButton;
    cboCampo: TComboBox;
    ds: TDataSource;
    edtPesq: TEdit;
    imprimir: TAction;
    sair: TAction;
    altPar: TAction;
    Label1: TLabel;
    Label2: TLabel;
    pnAcoes: TPanel;
    pnBackground: TPanel;
    Panel3: TPanel;
    Pesq: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure altParExecute(Sender: TObject);
    procedure dsStateChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grPesqDblClick(Sender: TObject);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grPesqTitleClick(Column: TColumn);
    procedure imprimirExecute(Sender: TObject);
    procedure PesqExecute(Sender: TObject);
    procedure receberExecute(Sender: TObject);
  private
    { private declarations }
    FParcela: iControllerParcelaComissao;
    FBufDataset: iModelBufferDataset;
    function abrirVenda: TModalResult;
    procedure MensagemRodape(pMsg: String);
  public
    { public declarations }
  end;

var
  FrmRecebimentoManual: TFrmRecebimentoManual;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.parcelascomissao,
  cobcons.view.fichareceberparcela, cobcons.view.rel.parcelaspendentes;

{$R *.lfm}

{ TFrmRecebimentoManual }

procedure TFrmRecebimentoManual.sairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmRecebimentoManual.dsStateChange(Sender: TObject);
begin
  altPar.Enabled:=(ds.State = dsBrowse);
  receber.Enabled:=altPar.Enabled;
  imprimir.Enabled:=altPar.Enabled;
end;

procedure TFrmRecebimentoManual.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnRodape.Color := vEsquema.CorPainelRodape;
  pnBackGround.Color := vEsquema.CorFundo;
  grPesq.AlternateColor := vEsquema.CorFundo;
  FParcela := TControllerFactory.New.ParcelaComissao;
end;

procedure TFrmRecebimentoManual.grPesqDblClick(Sender: TObject);
begin
    if not ds.DataSet.EOF
    then abrirVenda;
end;

procedure TFrmRecebimentoManual.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmRecebimentoManual.altParExecute(Sender: TObject);
begin
  if abrirVenda = mrOK
  then ds.DataSet.Refresh;
end;

procedure TFrmRecebimentoManual.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmRecebimentoManual.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
   VK_RETURN: if Grpesq.Focused and not ds.DataSet.EOF
              then abrirVenda
              else if edtPesq.Focused
              then Pesq.Execute
              else SelectNext(ActiveControl,True,True);
   VK_ESCAPE: Sair.Execute;
  end;
end;

procedure TFrmRecebimentoManual.grPesqTitleClick(Column: TColumn);
begin
  FBufDataset.OrdenarPorCampos(Column.FieldName);
end;

procedure TFrmRecebimentoManual.imprimirExecute(Sender: TObject);
begin
  FrmRelParPend := TFrmRelParPend.Create(nil);
  try
    FrmRelParPend.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
    FrmRelParPend.ds.DataSet := ds.DataSet;
     FrmRelParPend.RP.Title:='PARCELAS A RECEBER ATE: '+FormatDateTime('dd/mm/yyyy',Date);
     FrmRelParPend.RP.PreviewModal;
  finally
    FrmRelParPend.Free;
  end;
end;

procedure TFrmRecebimentoManual.PesqExecute(Sender: TObject);
begin
  FBufDataset := FParcela.RetornarParcelasPendentes(cboCampo.ItemIndex,edtPesq.Text);
  if FBufDataset.TemDados
  then begin
    MensagemRodape(Format('Encontradas %d ocorrencias para %s...',
         [FBufDataset.QtdeRegistros,edtPesq.Text]));
    ds.DataSet := FBufDataset.DataSet;
  end
  else  MensagemRodape(Format('%s não encontrado!',[edtPesq.Text]));
end;

procedure TFrmRecebimentoManual.receberExecute(Sender: TObject);
begin
  if not ds.DataSet.EOF
  then begin
    FrmFichaReceberParcela := TFrmFichaReceberParcela.Create(nil);
    try
      FrmFichaReceberParcela.CodigoVenda   := ds.DataSet.FieldByName('CdVen').AsInteger;
      FrmFichaReceberParcela.CodigoParcela := ds.DataSet.FieldByName('Parcela').AsInteger;
      if FrmFichaReceberParcela.ShowModal=mrOK
      then ds.DataSet.Refresh;
    finally
      FrmFichaReceberParcela.Free;
    end;
  end;
    //if DMVendas.pndRECEBIDO.Value = 0 then begin
    //end
    //else if ConfirmaMensagem('Parcela já RECEBIDA! Deseja anular o recebimento?') then begin
    //  DMVendas.manterParcelas(1, DMVendas.pndVENDA.Value,
    //                             DMVendas.pndPARCELA.Value,
    //                             DMVendas.pndPERIODO.Value,
    //                             DMVendas.pndDTVENC.Value,
    //                             0,
    //                             DMVendas.pndRECEBER.Value,
    //                             0.0,
    //                             DMVendas.pndPAGAR.Value,
    //                             DMVendas.pndPAGO.Value);
    //  ds.DataSet.Refresh;
    //end;
end;

function TFrmRecebimentoManual.abrirVenda: TModalResult;
begin
  if not ds.DataSet.EOF
  then begin
    FrmParcelasComissao := TFrmParcelasComissao.Create(nil);
    try
      FrmParcelasComissao.CodigoVenda:=ds.DataSet.FieldByName('CdVen').AsInteger;
      Result := FrmParcelasComissao.ShowModal;
    finally
      FrmParcelasComissao.Free;
    end;
  end;
end;

procedure TFrmRecebimentoManual.MensagemRodape(pMsg: String);
begin
  pnRodape.Caption := pMsg;
end;

end.

