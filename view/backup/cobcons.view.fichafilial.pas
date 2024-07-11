unit cobcons.view.fichafilial;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  cobcons.view.ficha, cobcons.controller.interfaces,
  cobcons.model.interfaces, HNSCombox;

type

  { TFrmFichaFilial }

  TFrmFichaFilial = class(TFrmFicha)
    cboResponsavel: THNSCombox;
    edCodigo: TEdit;
    edFilial: TEdit;
    edCodExterno: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure GravarExecute(Sender: TObject);
  private
    FCodigoFilial: Integer;
    FFilial: iControllerFilial;
    procedure SetCodigoFilial(AValue: Integer);
    function Validado: Boolean;
  public
    property CodigoFilial: Integer read FCodigoFilial write SetCodigoFilial;
  end;

var
  FrmFichaFilial: TFrmFichaFilial;

implementation

uses cobcons.controller.factory, cobcons.controller.util;

{$R *.lfm}

{ TFrmFichaFilial }

procedure TFrmFichaFilial.FormCreate(Sender: TObject);
begin
  inherited;
  FFilial := TControllerFactory.New.Filial;
  cboResponsavel.Lista := TControllerFactory.New.Agente
                               .ListaSupervisoresAtivosComboBox(3);
end;

procedure TFrmFichaFilial.GravarExecute(Sender: TObject);
var
  vModo: TpModoManutencao;
begin
  if FCodigoFilial = 0
  then vModo := tmInclusao
  else vModo := tmAlteracao;
  if Validado and ConfirmaMensagem('Gravar os dados?')
  then begin
    FFilial.CODIGO(StrToInt(edCodigo.Text))
           .DESCRICAO(edFilial.Text)
           .RESPONSAVEL(cboResponsavel.getCodigo)
           .CODEXT(edCodExterno.Text)
           .Executar(vModo);
    ModalResult := mrOK;
  end;
end;

procedure TFrmFichaFilial.SetCodigoFilial(AValue: Integer);
begin
  FCodigoFilial := AValue;
  if FCodigoFilial > 0
  then begin
    FFilial.ListaPorCodigo(FCodigoFilial);
    pnTitulo.Caption := 'Alterar Filial';
    edCodigo.Text := Format('%.3d', [FFilial.CODIGO]);
    edFilial.Text := FFilial.DESCRICAO;
    cboResponsavel.PosicionaCodigo(FFilial.RESPONSAVEL);
    edCodExterno.Text := FFilial.CODEXT;
  end
  else pnTitulo.Caption := 'Nova Filial';
end;

function TFrmFichaFilial.Validado: Boolean;
var
  vMsg: String;
begin
  vMsg := '';

  if Length(Trim(edFilial.Text))=0
  then vMsg := 'Nome Filial deve ser preenchido!';

  if vMsg <> ''
  then MostraAviso(vMsg);
  Result := (vMsg = '');
end;

end.

