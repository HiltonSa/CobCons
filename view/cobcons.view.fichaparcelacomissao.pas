unit cobcons.view.fichaparcelacomissao;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DateTimePicker, cobcons.view.ficha, cobcons.controller.interfaces,
  cobcons.model.interfaces, HNSCombox;

type

  { TFrmFichaParcelaComissao }

  TFrmFichaParcelaComissao = class(TFrmFicha)
    dtVenc: TDateTimePicker;
    dtRec: TDateTimePicker;
    edParcela: TEdit;
    cboPeriodo: THNSCombox;
    edValorReceber: TEdit;
    edValorRecebido: TEdit;
    edValorPagar: TEdit;
    edValorPago: TEdit;
    Label1: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure GravarExecute(Sender: TObject);
  private
    FCodigoParcela: Integer;
    FCodigoVenda: Integer;
    FParcela: iControllerParcelaComissao;
    procedure SetCodigoParcela(AValue: Integer);
    procedure SetCodigoVenda(AValue: Integer);

  public
    property CodigoVenda: Integer read FCodigoVenda write SetCodigoVenda;
    property CodigoParcela: Integer read FCodigoParcela write SetCodigoParcela;
  end;

var
  FrmFichaParcelaComissao: TFrmFichaParcelaComissao;

implementation

uses cobcons.controller.factory, cobcons.controller.util;

{$R *.lfm}

{ TFrmFichaParcelaComissao }

procedure TFrmFichaParcelaComissao.FormCreate(Sender: TObject);
begin
  inherited;
  FParcela := TControllerFactory.New.ParcelaComissao;
  cboPeriodo.Lista := TControllerFactory.New.Periodo.ListaComboBox;
end;

procedure TFrmFichaParcelaComissao.GravarExecute(Sender: TObject);
begin
  if ConfirmaMensagem('Gravar os dados?')
  then begin
    FParcela.VENDA(FCodigoVenda)
            .PARCELA(FCodigoParcela)
            .DTVENC(dtVenc.Date)
            .PERIODO(cboPeriodo.getCodigo)
            .DTREC(dtRec.Date)
            .RECEBER(StrToFloat(edValorReceber.Text))
            .RECEBIDO(StrToFloat(edValorRecebido.Text))
            .PAGAR(StrToFloat(edValorPagar.Text))
            .PAGO(StrToFloat(edValorPago.Text))
            .Executar(tmAlteracao);
    ModalResult := mrOK;
  end;
end;

procedure TFrmFichaParcelaComissao.SetCodigoParcela(AValue: Integer);
begin
  FCodigoParcela := AValue;
  if FCodigoVenda > 0
  then begin
    FParcela.ListaPorCodigo(FCodigoVenda, FCodigoParcela);
    edParcela.Text       := Format('%.3d',[ FParcela.PARCELA ]);
    dtVenc.Date          := FParcela.DTVENC;
    dtRec.Date           := FParcela.DTREC;
    edValorReceber.Text  := Format('%.2n',[ FParcela.RECEBER ]);
    edValorRecebido.Text := Format('%.2n',[ FParcela.RECEBIDO ]);
    edValorPagar.Text    := Format('%.2n',[ FParcela.PAGAR ]);
    edValorPago.Text     := Format('%.2n',[ FParcela.PAGO ]);
    if FParcela.PERIODO > 0
    then cboPeriodo.PosicionaCodigo(FParcela.PERIODO);
  end;
end;

procedure TFrmFichaParcelaComissao.SetCodigoVenda(AValue: Integer);
begin
  FCodigoVenda := AValue;
end;

end.

