unit cobcons.view.fichaadmcon;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DateTimePicker, cobcons.view.ficha, cobcons.controller.interfaces,
  cobcons.model.interfaces, HNSCombox;

type

  { TFrmFichaAdmCon }

  TFrmFichaAdmCon = class(TFrmFicha)
    cboUnidade: TComboBox;
    dtVigencia: TDateTimePicker;
    edCodigo: TEdit;
    edPcEntrega: TEdit;
    edNomeFantasia: TEdit;
    edCnpj: TEdit;
    edMesPer: TEdit;
    edPcPer: TEdit;
    edRazaoSocial: TEdit;
    GroupBox1: TGroupBox;
    cboUltimaFaixa: THNSCombox;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure GravarExecute(Sender: TObject);
  private
    FCodigoEmpresa: Integer;
    FAdmCon: iControllerAdmcon;
    procedure SetCodigoEmpresa(AValue: Integer);
    function Validado: Boolean;
  public
    property CodigoEmpresa: Integer read FCodigoEmpresa write SetCodigoEmpresa;
  end;

var
  FrmFichaAdmCon: TFrmFichaAdmCon;

implementation

uses cobcons.controller.factory, cobcons.controller.util;

{$R *.lfm}

{ TFrmFichaAdmCon }

procedure TFrmFichaAdmCon.FormCreate(Sender: TObject);
begin
  inherited;
  FAdmCon := TControllerFactory.New.AdmCon;
end;

procedure TFrmFichaAdmCon.GravarExecute(Sender: TObject);
var
  vModo: TpModoManutencao;
begin
  if FCodigoEmpresa = 0
  then vModo := tmInclusao
  else vModo := tmAlteracao;
  if Validado and ConfirmaMensagem('Gravar os dados?')
  then begin
    FAdmCon.CODIGO(StrToInt(edCodigo.Text))
           .NOMEFANTASIA(edNomeFantasia.Text)
           .RAZAOSOCIAL(edRazaoSocial.Text)
           .CNPJ(RetornaSemFormatacao(edCnpj.Text))
           .VIGENCIA(dtVigencia.Date)
           .UNIDADE(cboUnidade.ItemIndex)
           .PCENTREGA(StrToFloat(edPcEntrega.Text))
           .MESPER(StrToIntDef(edMesPer.Text,0))
           .PCPER(StrToFloat(edPcPer.Text))
           .ULTFAIXA(cboUltimaFaixa.getCodigo)
           .Executar(vModo);
    ModalResult := mrOK;
  end;

end;

procedure TFrmFichaAdmCon.SetCodigoEmpresa(AValue: Integer);
begin
  FCodigoEmpresa := AValue;
  cboUltimaFaixa.Lista := TControllerFactory.New.FaixaComissao.ListaComboBox(FCodigoEmpresa);
  if FCodigoEmpresa > 0
  then begin
    FAdmCon.ListaPorCodigo(FCodigoEmpresa);
    pnTitulo.Caption := FAdmCon.NOMEFANTASIA;
    edCodigo.Text := Format('%.3d', [FAdmCon.CODIGO]);
    edNomeFantasia.Text := FAdmCon.NOMEFANTASIA;
    edRazaoSocial.Text := FAdmCon.RAZAOSOCIAL;
    edCnpj.Text := RetornarFormatado(FAdmCon.CNPJ, tfCnpj);
    dtVigencia.Date := FAdmCon.VIGENCIA;
    cboUnidade.ItemIndex := FAdmCon.UNIDADE;
    edPcEntrega.Text := Format('%.2f', [FAdmCon.PCENTREGA]);
    edPcPer.Text := Format('%.2f', [FAdmCon.PCPER]);
    edMesPer.Text := Format('%.3d', [FAdmCon.MESPER]);
    cboUltimaFaixa.PosicionaCodigo(FAdmCon.ULTFAIXA);
  end
  else pnTitulo.Caption := 'Nova Adm Consórcio';
end;

function TFrmFichaAdmCon.Validado: Boolean;
var
  vMsg: String;
begin
  vMsg := '';

  if Length(Trim(edNomeFantasia.Text))=0
  then vMsg := 'Nome Fantasia deve ser preenchido!'
  else if Length(Trim(edRazaoSocial.Text))=0
  then vMsg := 'Razão Social deve ser preenchido!';

  if vMsg <> ''
  then MostraAviso(vMsg);
  Result := (vMsg = '');
end;

end.

