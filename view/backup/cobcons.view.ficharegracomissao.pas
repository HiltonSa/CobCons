unit cobcons.view.ficharegracomissao;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  cobcons.view.ficha, cobcons.controller.interfaces, cobcons.model.interfaces,
  HNSCombox;

type

  { TFrmFichaRegraComissao }

  TFrmFichaRegraComissao = class(TFrmFicha)
    cboEmp: THNSCombox;
    cboFaixa: THNSCombox;
    edPercentual: TEdit;
    edParcela: TEdit;
    edPcLib: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure GravarExecute(Sender: TObject);
  private
    FRegra: iControllerRegraComissao;
    FCodigoEmpresa: Integer;
    FCodigoFaixa: Integer;
    FParcela: Integer;
    procedure SetCodigoEmpresa(AValue: Integer);
    procedure SetCodigoFaixa(AValue: Integer);
    procedure SetParcela(AValue: Integer);

  public
    property CodigoEmpresa: Integer read FCodigoEmpresa write SetCodigoEmpresa;
    property CodigoFaixa: Integer read FCodigoFaixa write SetCodigoFaixa;
    property Parcela: Integer read FParcela write SetParcela;
  end;

var
  FrmFichaRegraComissao: TFrmFichaRegraComissao;

implementation

uses cobcons.controller.factory, cobcons.controller.util;

{$R *.lfm}

{ TFrmFichaRegraComissao }

procedure TFrmFichaRegraComissao.FormCreate(Sender: TObject);
begin
  inherited;
  FRegra := TControllerFactory.New.RegraComissao;
end;

procedure TFrmFichaRegraComissao.GravarExecute(Sender: TObject);
var
  vModo: TpModoManutencao;
begin
  if FParcela = 0
  then vModo := tmInclusao
  else vModo := tmAlteracao;
  if ConfirmaMensagem('Gravar as informações?')
  then begin
    FRegra.EMPRESA(FCodigoEmpresa)
          .FAIXA(FCodigoFaixa)
          .PARCELA(StrToInt(edParcela.Text))
          .PCLIB(StrToInt(edPcLib.Text))
          .PERCENTUAL(StrToFloat(edPercentual.Text))
          .Executar(vModo);
    ModalResult := mrOK;
  end;
end;

procedure TFrmFichaRegraComissao.SetCodigoEmpresa(AValue: Integer);
begin
  FCodigoEmpresa := AValue;
  cboEmp.Lista := TControllerFactory.New.AdmCon.ListaComboBox;
end;

procedure TFrmFichaRegraComissao.SetCodigoFaixa(AValue: Integer);
begin
  FCodigoFaixa := AValue;
  cboFaixa.Lista := TControllerFactory.New.FaixaComissao.ListaComboBox(FCodigoEmpresa);
end;

procedure TFrmFichaRegraComissao.SetParcela(AValue: Integer);
begin
  FParcela := AValue;
  cboEmp.PosicionaCodigo(FCodigoEmpresa);
  cboFaixa.PosicionaCodigo(FCodigoFaixa);
  edParcela.Text := IntToStr(FParcela);
  if FParcela > 0
  then begin
    pnTitulo.Caption := 'Alterando Regra de Comissão';
    FRegra.ListaParcela(FCodigoEmpresa, FCodigoFaixa, FParcela);
    edParcela.ReadOnly := True;
    edPcLib.Text := Format('%.3d',[FRegra.PCLIB]);
    edPercentual.Text := Format('%.3f',[FRegra.PERCENTUAL]);
  end
  else pnTitulo.Caption := 'Incluindo Regra de Comissão';
end;

end.

