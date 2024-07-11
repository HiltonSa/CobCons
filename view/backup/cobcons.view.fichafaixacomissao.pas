unit cobcons.view.fichafaixacomissao;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  cobcons.view.ficha, cobcons.controller.interfaces;

type

  { TFrmFichaFaixaComissao }

  TFrmFichaFaixaComissao = class(TFrmFicha)
    edCodigo: TEdit;
    edDescricao: TEdit;
    edMinimo: TEdit;
    edMaximo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    FCodigoFaixa: Integer;
    FFaixa: iControllerFaixaComissao;
    procedure SetCodigoFaixa(AValue: Integer);

  public
    property CodigoFaixa: Integer read FCodigoFaixa write SetCodigoFaixa;
  end;

var
  FrmFichaFaixaComissao: TFrmFichaFaixaComissao;

implementation

uses cobcons.controller.factory;

{$R *.lfm}

{ TFrmFichaFaixaComissao }

procedure TFrmFichaFaixaComissao.FormCreate(Sender: TObject);
begin
  inherited;
  FFaixa := TControllerFactory.New.FaixaComissao;
end;

procedure TFrmFichaFaixaComissao.SetCodigoFaixa(AValue: Integer);
begin
  FCodigoFaixa := AValue;
  if FCodigoFaixa > 0
  then begin
    pnTitulo.Caption := 'Alterando Faixa de Comissão';
    FFaixa.ListaPorCodigo(FCodigoFaixa);
    edCodigo.Text := Format('%.2d',[FFaixa.CODIGO]);
    edDescricao.Text := FFaixa.DESCRICAO;
    edMinimo.Text := Format('%.2f',[FFaixa.MINIMO]);
    edMaximo.Text := Format('%.2f',[FFaixa.MAXIMO]);
  end
  else pnTitulo.Caption := 'Incluir Faixa de Comissão';
end;

end.

