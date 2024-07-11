unit cobcons.view.fichaagente;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  cobcons.view.ficha, cobcons.controller.interfaces,
  cobcons.model.interfaces, HNSCombox;

type

  { TFrmFichaAgente }

  TFrmFichaAgente = class(TFrmFicha)
    cboNivel: THNSCombox;
    cboEquipe: THNSCombox;
    cboSit: TComboBox;
    edCodExterno: TEdit;
    edCodigo: TEdit;
    edDDD: TEdit;
    edCelular: TEdit;
    edNome: TEdit;
    edCpf: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure edCelularExit(Sender: TObject);
    procedure edCpfExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GravarExecute(Sender: TObject);
  private
    FAgente: iControllerAgente;
    FCodigoAgente: Integer;
    procedure SetCodigoAgente(AValue: Integer);
    function Validado: Boolean;
  public
    property CodigoAgente: Integer read FCodigoAgente write SetCodigoAgente;
  end;

var
  FrmFichaAgente: TFrmFichaAgente;

implementation

uses cobcons.controller.factory, cobcons.controller.util;

{$R *.lfm}

{ TFrmFichaAgente }

procedure TFrmFichaAgente.FormCreate(Sender: TObject);
begin
  inherited;
  FAgente := TControllerFactory.New.Agente;
  cboEquipe.Lista := TControllerFactory.New.Equipe.ListaComboBox;
  cboNivel.Lista := TControllerFactory.New.NivelSupervisao.ListaComboBox;
end;

procedure TFrmFichaAgente.edCpfExit(Sender: TObject);
begin
  edCpf.Text := RetornarFormatado(edCpf.Text, tfCpf);
end;

procedure TFrmFichaAgente.edCelularExit(Sender: TObject);
begin
  edCelular.Text := RetornarFormatado(edCelular.Text, tfCelular);
end;

procedure TFrmFichaAgente.GravarExecute(Sender: TObject);
var
  vModo: TpModoManutencao;
begin
  if FCodigoAgente = 0
  then vModo := tmInclusao
  else vModo := tmAlteracao;
  if Validado and ConfirmaMensagem('Gravar os dados?')
  then begin
    FAgente.CODIGO(StrToInt(edCodigo.Text))
           .NOME(edNome.Text)
           .CPF(RetornaSemFormatacao(edCpf.Text))
           .DDD(edDDD.Text)
           .CELULAR(RetornaSemFormatacao(edCelular.Text))
           .CDEXTERNO(edCodExterno.Text)
           .SUPERVISAO(cboNivel.getCodigo)
           .EQUIPE(cboEquipe.getCodigo)
           .ATIVO(cboSit.ItemIndex)
           .Executar(vModo);
    ModalResult := mrOK;
  end;

end;

procedure TFrmFichaAgente.SetCodigoAgente(AValue: Integer);
begin
  FCodigoAgente := AValue;
  if FCodigoAgente > 0
  then begin
    FAgente.ListaPorCodigo(FCodigoAgente);
    pnTitulo.Caption := FAgente.NOME;
    edCodigo.Text := Format('%.3d', [FAgente.CODIGO]);
    edNome.Text := FAgente.NOME;
    edCpf.Text := RetornarFormatado(FAgente.CPF, tfCpf);
    edDDD.Text := FAgente.DDD;
    edCelular.Text := RetornarFormatado(FAgente.CELULAR, tfCelular);
    edCodExterno.Text := FAgente.CDEXTERNO;
    cboNivel.PosicionaCodigo(FAgente.SUPERVISAO);
    cboEquipe.PosicionaCodigo(FAgente.EQUIPE);
    cboSit.ItemIndex := FAgente.ATIVO;
  end
  else pnTitulo.Caption := 'Novo Agente';
end;

function TFrmFichaAgente.Validado: Boolean;
var
  vMsg: String;
begin
  vMsg := '';

  if Length(Trim(edNome.Text))=0
  then vMsg := 'O Nome deve ser preenchido!'
  else if cboNivel.getCodigo = 0
  then vMsg := 'O Nível de Supervisão deve ser informado!'
  else if cboEquipe.getCodigo = 0
  then vMsg := 'A Equipe deve ser informada!';

  if vMsg <> ''
  then MostraAviso(vMsg);
  Result := (vMsg = '');
end;

end.

