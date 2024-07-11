unit cobcons.view.fichareceberparcela;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DateTimePicker, cobcons.view.ficha, cobcons.controller.interfaces,
  cobcons.model.interfaces, HNSCombox;

type

  { TFrmFichaReceberParcela }

  TFrmFichaReceberParcela = class(TFrmFicha)
    dtRec: TDateTimePicker;
    dtVenc: TDateTimePicker;
    edParcela: TEdit;
    edValorReceber: TEdit;
    edValorRecebido: TEdit;
    Label1: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
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
  FrmFichaReceberParcela: TFrmFichaReceberParcela;

implementation

uses cobcons.controller.factory, cobcons.controller.util;

{$R *.lfm}

{ TFrmFichaReceberParcela }

procedure TFrmFichaReceberParcela.FormCreate(Sender: TObject);
begin
  inherited;
  FParcela := TControllerFactory.New.ParcelaComissao;
end;

procedure TFrmFichaReceberParcela.GravarExecute(Sender: TObject);
begin
  if (StrToFloatDef(edValorRecebido.Text,0.0) > 0) and
     ConfirmaMensagem('Gravar os dados?')
  then begin
    FParcela.ListaPorCodigo(FCodigoVenda, FCodigoParcela);
    FParcela.DTREC(dtRec.Date)
            .RECEBIDO(StrToFloat(edValorRecebido.Text))
            .Executar(tmAlteracao);
    ModalResult := mrOK;
  end;
end;

procedure TFrmFichaReceberParcela.SetCodigoParcela(AValue: Integer);
begin
  FCodigoParcela := AValue;
  if FCodigoVenda > 0
  then begin
    FParcela.ListaPorCodigo(FCodigoVenda, FCodigoParcela);
    edParcela.Text       := Format('%.3d',[ FParcela.PARCELA ]);
    dtVenc.Date          := FParcela.DTVENC;
    dtRec.Date           := Date;
    edValorReceber.Text  := Format('%.2n',[ FParcela.RECEBER ]);
    edValorRecebido.Text := Format('%.2n',[ FParcela.RECEBIDO ]);
  end;
end;

procedure TFrmFichaReceberParcela.SetCodigoVenda(AValue: Integer);
begin
  FCodigoVenda := AValue;
end;

end.

