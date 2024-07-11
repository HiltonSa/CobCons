unit cobcons.view.parcelascomissao;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Buttons, DBCtrls, DBGrids, StdCtrls, cobcons.controller.interfaces,
  cobcons.model.interfaces;

type

  { TFrmParcelasComissao }

  TFrmParcelasComissao = class(TForm)
    ds: TDataSource;
    edNmCli: TEdit;
    edEmp: TEdit;
    edContrato: TEdit;
    edCod: TEdit;
    edDtVen: TEdit;
    edDcBem: TEdit;
    edVlBem: TEdit;
    edNmVen: TEdit;
    grPesq: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    pnAcoes: TPanel;
    pnBackGround: TPanel;
    Panel3: TPanel;
    pnTitulo: TPanel;
    sair: TAction;
    alterar: TAction;
    AL: TActionList;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure alterarExecute(Sender: TObject);
    procedure grPesqDblClick(Sender: TObject);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sairExecute(Sender: TObject);
  private
    { private declarations }
    FCodigoVenda: Integer;
    FVendas: iControllerVenda;
    FParcelas: iControllerParcelaComissao;
    procedure SetCodigoVenda(AValue: Integer);
    function AbrirFicha(pParcela: Integer): TModalResult;
  public
    { public declarations }
    property CodigoVenda: Integer read FCodigoVenda write SetCodigoVenda;
  end;

var
  FrmParcelasComissao: TFrmParcelasComissao;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.fichaparcelacomissao;

{$R *.lfm}

{ TFrmParcelasComissao }

procedure TFrmParcelasComissao.sairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmParcelasComissao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused and not ds.DataSet.EOF
               then AbrirFicha(ds.DataSet.FieldByName('parcela').AsInteger)
               else SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
end;

procedure TFrmParcelasComissao.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema           := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color         := vEsquema.CorFormulario;
  pnTitulo.Color     := vEsquema.CorPainelTitulo;
  pnAcoes.Color      := vEsquema.CorPainelAcoes;
  pnBackGround.Color := vEsquema.CorFundo;
  grPesq.AlternateColor := vEsquema.CorFundo;
  FVendas   := TControllerFactory.New.Venda;
  FParcelas := TControllerFactory.New.ParcelaComissao;
end;

procedure TFrmParcelasComissao.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmParcelasComissao.alterarExecute(Sender: TObject);
begin
  if AbrirFicha(ds.DataSet.FieldByName('parcela').AsInteger) = mrOK
  then ds.DataSet.Refresh;
  //if DMVendas.psqParRECEBIDO.Value = 0
  //then MostraAviso('Parcela já RECEBIDA!');
  //if AbrirFicha(true) = mrOK
  //then ds.DataSet.Refresh;
  //end
  //else if ConfirmaMensagem('Parcela já RECEBIDA! Deseja anular o recebimento?') then begin
  //  DMVendas.manterParcelas(1, DMVendas.psqParVENDA.Value,
  //                             DMVendas.psqParPARCELA.Value,
  //                             DMVendas.psqParPERIODO.Value,
  //                             DMVendas.psqParDTVENC.Value,
  //                             0,
  //                             DMVendas.psqParRECEBER.Value,
  //                             0.0,
  //                             DMVendas.psqParPAGAR.Value,
  //                             DMVendas.psqParPAGO.Value);
  //  ds.DataSet.Refresh;
  //end;
end;

procedure TFrmParcelasComissao.grPesqDblClick(Sender: TObject);
begin
  if not ds.DataSet.EOF
  then AbrirFicha(ds.DataSet.FieldByName('parcela').AsInteger);
end;

procedure TFrmParcelasComissao.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmParcelasComissao.SetCodigoVenda(AValue: Integer);
begin
  FCodigoVenda := AValue;
  FVendas.ListaPorCodigo(FCodigoVenda);
  edEmp.Text      := FVendas.NMEMP;
  edContrato.Text := FVendas.CONTRATO;
  edCod.Text      := Format('%.6d',[FVendas.CODIGO]);
  edDtVen.Text    := FormatDateTime('dd/mm/yyyy', FVendas.DTVENDA);
  edNmVen.Text    := FVendas.NMAGE;
  edDcBem.Text    := FVendas.DCBEM;
  edVlBem.Text    := Format('%.2f', [ FVendas.VALOR ]);
  edNmCli.Text    := FVendas.NOME;
  ds.DataSet      := FParcelas.ListaPorVenda( FVendas.CODIGO );
end;

function TFrmParcelasComissao.AbrirFicha(pParcela: Integer): TModalResult;
begin
  FrmFichaParcelaComissao := TFrmFichaParcelaComissao.Create(nil);
  try
    FrmFichaParcelaComissao.CodigoVenda := FCodigoVenda;
    FrmFichaParcelaComissao.CodigoParcela := pParcela;
    Result:=FrmFichaParcelaComissao.ShowModal;
  finally
    FrmFichaParcelaComissao.Free;
  end;
end;

{ TFrmParcelasComissao }


end.

