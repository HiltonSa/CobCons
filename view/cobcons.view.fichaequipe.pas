unit cobcons.view.fichaequipe;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  cobcons.view.ficha, cobcons.controller.interfaces,
  cobcons.model.interfaces, HNSCombox;

type

  { TFrmFichaEquipe }

  TFrmFichaEquipe = class(TFrmFicha)
    cboFilial: THNSCombox;
    cboSupervisor: THNSCombox;
    edCodigo: TEdit;
    edEquipe: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure GravarExecute(Sender: TObject);
  private
    FCodigoEquipe: Integer;
    FEquipe: iControllerEquipe;
    procedure SetCodigoEquipe(AValue: Integer);
    function Validado: Boolean;
  public
    property CodigoEquipe: Integer read FCodigoEquipe write SetCodigoEquipe;
  end;

var
  FrmFichaEquipe: TFrmFichaEquipe;

implementation

uses cobcons.controller.factory, cobcons.controller.util;

{$R *.lfm}

{ TFrmFichaEquipe }

procedure TFrmFichaEquipe.FormCreate(Sender: TObject);
begin
  inherited;
  FEquipe := TControllerFactory.New.Equipe;
  cboFilial.Lista := TControllerFactory.New.Filial.ListaComboBox;
  cboSupervisor.Lista := TControllerFactory.New.Agente
                             .ListaSupervisoresAtivosComboBox(2);
end;

procedure TFrmFichaEquipe.GravarExecute(Sender: TObject);
var
  vModo: TpModoManutencao;
begin
  if FCodigoEquipe = 0
  then vModo := tmInclusao
  else vModo := tmAlteracao;
  if Validado and ConfirmaMensagem('Gravar os dados?')
  then begin
    FEquipe.CODIGO(StrToInt(edCodigo.Text))
           .DESCRICAO(edEquipe.Text)
           .FILIAL(cboFilial.getCodigo)
           .SUPERVISOR(cboSupervisor.getCodigo)
           .Executar(vModo);
    ModalResult := mrOK;
  end;
end;

procedure TFrmFichaEquipe.SetCodigoEquipe(AValue: Integer);
begin
  FCodigoEquipe := AValue;
  if FCodigoEquipe > 0
  then begin
    FEquipe.ListaPorCodigo(FCodigoEquipe);
    pnTitulo.Caption := 'Alterar Equipe';
    edCodigo.Text := Format('%.3d', [FEquipe.CODIGO]);
    edEquipe.Text := FEquipe.DESCRICAO;
    cboFilial.PosicionaCodigo(FEquipe.FILIAL);
    cboSupervisor.PosicionaCodigo(FEquipe.SUPERVISOR);
  end
  else pnTitulo.Caption := 'Nova Equipe';
end;

function TFrmFichaEquipe.Validado: Boolean;
var
  vMsg: String;
begin
  vMsg := '';

  if Length(Trim(edEquipe.Text))=0
  then vMsg := 'Nome Equipe deve ser preenchido!';

  if vMsg <> ''
  then MostraAviso(vMsg);
  Result := (vMsg = '');
end;

end.

