unit cobcons.view.fichafaixacomissao;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  cobcons.view.ficha, cobcons.controller.interfaces, cobcons.model.interfaces;

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
    procedure GravarExecute(Sender: TObject);
  private
    FCodigoEmpresa: Integer;
    FCodigoFaixa: Integer;
    FFaixa: iControllerFaixaComissao;
    procedure SetCodigoEmpresa(AValue: Integer);
    procedure SetCodigoFaixa(AValue: Integer);

  public
    property CodigoFaixa: Integer read FCodigoFaixa write SetCodigoFaixa;
    property CodigoEmpresa: Integer read FCodigoEmpresa write SetCodigoEmpresa;
  end;

var
  FrmFichaFaixaComissao: TFrmFichaFaixaComissao;

implementation

uses cobcons.controller.factory, cobcons.controller.util;

{$R *.lfm}

{ TFrmFichaFaixaComissao }

procedure TFrmFichaFaixaComissao.FormCreate(Sender: TObject);
begin
  inherited;
  FFaixa := TControllerFactory.New.FaixaComissao;
end;

procedure TFrmFichaFaixaComissao.GravarExecute(Sender: TObject);
var
  vModo: TpModoManutencao;
begin
  if FCodigoFaixa = 0
  then vModo := tmInclusao
  else vModo := tmAlteracao;
  if ConfirmaMensagem('Gravar as informações?')
  then begin
    FFaixa.CODIGO(FCodigoFaixa)
          .EMPRESA(FCodigoEmpresa)
          .DESCRICAO(edDescricao.Text)
          .MINIMO(StrToFloat(edMinimo.Text))
          .MAXIMO(StrToFloat(edMaximo.Text))
          .Executar(vModo);
    ModalResult := mrOK;
  end;
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

procedure TFrmFichaFaixaComissao.SetCodigoEmpresa(AValue: Integer);
begin
  FCodigoEmpresa := AValue;
end;

end.

