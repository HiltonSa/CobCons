unit cobcons.view.calcularcomissao;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Buttons, DBCtrls, DBGrids, StdCtrls, cobcons.controller.interfaces,
  cobcons.model.interfaces, cobcons.model.bufferdataset, HNSCombox;

type

  { TFrmCalcularComissao }

  TFrmCalcularComissao = class(TForm)
    calcular: TAction;
    AL: TActionList;
    cboPer: THNSCombox;
    edDtCal: TEdit;
    edDtIni: TEdit;
    edDtFim: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    pnAcoes: TPanel;
    sair: TAction;
    imp: TAction;
    Label1: TLabel;
    pnBackground: TPanel;
    pnTitulo: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    procedure calcularExecute(Sender: TObject);
    procedure cboPerSelect(Sender: TObject);
    procedure sairExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure impExecute(Sender: TObject);
  private
    { private declarations }
    FPeriodo: iControllerPeriodo;
  public
    { public declarations }
  end;

var
  FrmCalcularComissao: TFrmCalcularComissao;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.rel.pagarcomissao;

{$R *.lfm}

{ TFrmCalcularComissao }

procedure TFrmCalcularComissao.sairExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmCalcularComissao.cboPerSelect(Sender: TObject);
begin
  FPeriodo.ListaPorCodigo(cboPer.getCodigo);
  edDtIni.Text := FormatDateTime('dd/mm/yyyy', FPeriodo.DTINI);
  edDtFim.Text := FormatDateTime('dd/mm/yyyy', FPeriodo.DTFIM);
  edDtCal.Text := FormatDateTime('dd/mm/yyyy', FPeriodo.DTCAL);
  calcular.Enabled:=True;
end;

procedure TFrmCalcularComissao.calcularExecute(Sender: TObject);
var
  vCod: INteger;
begin
  vCod := cboPer.getCodigo;
  if ConfirmaMensagem('Confirma o cálculo das comissões para o período?')
  then begin
    FPeriodo.CODIGO(vCod).CalcularComissoes;
    MostraAviso('Calculo concluído!');
  end;
end;

procedure TFrmCalcularComissao.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnBackGround.Color := vEsquema.CorFundo;
  FPeriodo := TControllerFactory.New.Periodo;
  cboPer.Lista := FPeriodo.ListaComboBoxCalculo;
end;

procedure TFrmCalcularComissao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
   //VK_RETURN: if edtPesq.Focused then Pesq.Execute;
   VK_ESCAPE: sair.Execute;
  end;
end;

procedure TFrmCalcularComissao.impExecute(Sender: TObject);
var
  vDataset : TDataSet;
begin
  vDataset := TControllerFactory.New.Relatorios(2).RelatorioComissoes(FPeriodo.CODIGO);
  if not vDataset.EOF
  then begin
    FrmRelPagarComissao := TFrmRelPagarComissao.Create(nil);
    try
       FrmRelPagarComissao.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
       FrmRelPagarComissao.ds.DataSet := vDataset;
       FrmRelPagarComissao.RP.PreviewModal;
    finally
      FrmRelPagarComissao.Free;
    end;
  end
  else MostraAviso('Sem comissões para esse período!');
end;

end.

