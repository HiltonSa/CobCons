unit cobcons.view.fichavenda;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  DateTimePicker, cobcons.view.ficha, cobcons.controller.interfaces,
  cobcons.model.interfaces, HNSCombox;

type

  { TFrmFichaVenda }

  TFrmFichaVenda = class(TFrmFicha)
    cboTpPes: TComboBox;
    dtVenda: TDateTimePicker;
    edCpfCnpj: TEdit;
    edDDD: TEdit;
    edFone: TEdit;
    edNome: TEdit;
    edDcBem: TEdit;
    edCodigo: TEdit;
    cboEmpresa: THNSCombox;
    edContrato: TEdit;
    edGrupo: TEdit;
    edCota: TEdit;
    edDiaVenc: TEdit;
    edCdBem: TEdit;
    edVlrPago: TEdit;
    cboAgente: THNSCombox;
    cboSit: THNSCombox;
    edValor: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure cboSitSelect(Sender: TObject);
    procedure edCdBemExit(Sender: TObject);
    procedure edContratoExit(Sender: TObject);
    procedure edCpfCnpjExit(Sender: TObject);
    procedure edFoneExit(Sender: TObject);
    procedure edValorExit(Sender: TObject);
    procedure edVlrPagoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GravarExecute(Sender: TObject);
  private
    FVenda: iControllerVenda;
    FIncluindoVenda: Boolean;
    FCodigoVenda: Integer;
    procedure SetCodigoVenda(AValue: Integer);
    function Validado: Boolean;
    function ContratoJaInformado: String;
  public
    property CodigoVenda: Integer read FCodigoVenda write SetCodigoVenda;
  end;

var
  FrmFichaVenda: TFrmFichaVenda;

implementation

uses cobcons.controller.factory, cobcons.controller.util;

{$R *.lfm}

{ TFrmFichaVenda }

procedure TFrmFichaVenda.FormCreate(Sender: TObject);
begin
  inherited;
  FVenda           := TControllerFactory.New.Venda;
  cboEmpresa.Lista := TControllerFactory.New.AdmCon.ListaComboBox;
  cboAgente.Lista  := TControllerFactory.New.Agente.ListaComboBox;
  cboSit.Lista     := TControllerFactory.New.SituacaoContrato.ListaComboBox;
end;

procedure TFrmFichaVenda.edCpfCnpjExit(Sender: TObject);
begin
  if cboTpPes.ItemIndex = 0
  then edCpfCnpj.Text := RetornarFormatado(edCpfCnpj.Text, tfCpf)
  else edCpfCnpj.Text := RetornarFormatado(edCpfCnpj.Text, tfCnpj);
end;

procedure TFrmFichaVenda.cboSitSelect(Sender: TObject);
begin
  if FIncluindoVenda and (cboSit.getCodigo > 2)
  then begin
    MostraAviso('Situação não permitida na INCLUSÃO da Venda!');
    cboSit.SetFocus;
  end;
end;

procedure TFrmFichaVenda.edCdBemExit(Sender: TObject);
begin
  if FIncluindoVenda and
     (Length(Trim(edCdBem.Text))>0) and
     (cboEmpresa.getCodigo > 0)
  then begin
    FVenda.RetornaBem(cboEmpresa.getCodigo, edCdBem.Text);
    edDcBem.Text := FVenda.DCBEM;
    edValor.Text := Format('%.2f',[FVenda.VALOR]);
  end;
end;

procedure TFrmFichaVenda.edContratoExit(Sender: TObject);
var
  vMsg: String;
begin
  vMsg := ContratoJaInformado;
  if vMsg <> ''
  then begin
    MostraAviso(vMsg);
    edContrato.SetFocus;
  end;
end;

procedure TFrmFichaVenda.edFoneExit(Sender: TObject);
begin
  edFone.Text := RetornarFormatado(edFone.Text, tfCelular);
end;

procedure TFrmFichaVenda.edValorExit(Sender: TObject);
begin
  edValor.Text := Format('%.2f',[StrToFloatDef(edValor.Text,0.0)] );
end;

procedure TFrmFichaVenda.edVlrPagoExit(Sender: TObject);
begin
  edVlrPago.Text := Format('%.2f',[StrToFloatDef(edVlrPago.Text,0.0)] );
end;

procedure TFrmFichaVenda.GravarExecute(Sender: TObject);
var
  vModo: TpModoManutencao;
  vMsg: String;
  vCancelado: Boolean;
begin
  vCancelado := cboSit.getCodigo = 4;
  if vCancelado
  then vMsg := 'Confirma o CANCELAMENTO da venda?'
  else vMsg := 'Gravar os dados?';

  if FCodigoVenda = 0
  then vModo := tmInclusao
  else vModo := tmAlteracao;
  if Validado and ConfirmaMensagem(vMsg)
  then begin
    if vCancelado
    then FVenda.CancelarVenda(FCodigoVenda, Date, 0.0)
    else FVenda.EMPRESA(cboEmpresa.getCodigo)
          .CONTRATO(edContrato.Text)
          .GRUPO(edGrupo.Text)
          .COTA(StrToIntDef(edCota.Text,0))
          .DTVENDA(dtVenda.Date)
          .DIAVENC(StrToIntDef(edDiaVenc.Text,0))
          .VLRPAGO(StrToFloat(edVlrPago.Text))
          .AGENTE(cboAgente.getCodigo)
          .SITUACAO(cboSit.getCodigo)
          .CDBEM(edCdBem.Text)
          .DCBEM(edDcBem.Text)
          .VALOR(StrToFloat(edValor.Text))
          .NOME(edNome.Text)
          .TPPES(cboTpPes.ItemIndex)
          .CPFCNPJ(edCpfCnpj.Text)
          .DDD(edDDD.Text)
          .FONE(edFone.Text)
          .Executar(vModo);
    ModalResult := mrOK;
  end;
end;

procedure TFrmFichaVenda.SetCodigoVenda(AValue: Integer);
begin
  FCodigoVenda := AValue;
  FIncluindoVenda := FCodigoVenda = 0;
  Gravar.Enabled := True;
  if FIncluindoVenda
  then begin
    pnTitulo.Caption := 'Incluindo Venda';
    dtVenda.Date := Date;
  end
  else begin
    FVenda.ListaPorCodigo(FCodigoVenda);
    pnTitulo.Caption := 'Alterando Venda';
    edCodigo.Text    := Format('%.6d',[ FVenda.CODIGO ]);
    cboEmpresa.PosicionaCodigo(FVenda.EMPRESA);
    cboEmpresa.ReadOnly := True;
    cboEmpresa.TabStop  := False;
    edContrato.Text     := FVenda.CONTRATO;
    edGrupo.Text        := FVenda.GRUPO;
    edCota.Text         := Format('%.5d',[ FVenda.COTA ]);
    dtVenda.Date        := FVenda.DTVENDA;
    edDiaVenc.Text      := Format('%.2d',[ FVenda.DIAVENC ]);
    edVlrPago.Text      := Format('%.2f',[ FVenda.VLRPAGO ]);
    cboAgente.PosicionaCodigo(FVenda.AGENTE);
    cboSit.PosicionaCodigo(FVenda.SITUACAO);
    edCdBem.Text := FVenda.CDBEM;
    edDcBem.Text := FVenda.DCBEM;
    edValor.Text := Format('%.2f',[ FVenda.VALOR ]);
    edNome.Text  := FVenda.NOME;
    cboTpPes.ItemIndex := FVenda.TPPES;
    if FVenda.TPPES = 0
    then edCpfCnpj.Text := RetornarFormatado(FVenda.CPFCNPJ, tfCpf)
    else edCpfCnpj.Text := RetornarFormatado(FVenda.CPFCNPJ, tfCnpj);
    edDDD.Text  := FVenda.DDD;
    edFone.Text := RetornarFormatado(FVenda.FONE, tfFone);
    Gravar.Enabled := FVenda.SITUACAO <> 4; //gravar somente se não cancelado
  end;
end;

function TFrmFichaVenda.Validado: Boolean;
var
  vMsg: String;
  vCod: Integer;
begin
  vMsg := ContratoJaInformado;
  if vMsg = ''
  then begin
    if (Length(Trim(edVlrPago.Text))=0) or (StrToFloatDef(edVlrPago.Text,0.0) <= 0)
    then vMsg := 'VALOR PAGO PELO CLIENTE deve ser informado!'
    else if cboAgente.getCodigo = 0
    then vMsg := 'AGENTE deve ser informado!'
    else if Length(Trim(edCdBem.Text))=0
    then vMsg := 'CODIGO DO BEM deve ser informado!'
    else if Length(Trim(edDcBem.Text))=0
    then vMsg := 'DESCRIÇÃO DO BEM deve ser informado!'
    else if (Length(Trim(edValor.Text))=0) or (StrToFloatDef(edValor.Text,0.0) <= 0)
    then vMsg := 'VALOR DO BEM deve ser informado!'
    else if Length(Trim(edNome.Text))=0
    then vMsg := 'NOME DO CLIENTE deve ser informado!'
    else if Length(Trim(edCpfCnpj.Text))=0
    then vMsg := 'CPF/CNPJ deve ser informado!'
    else if cboTpPes.ItemIndex < 0
    then vMsg := 'PESSOA FÍS/JUR deve ser informado!';
  end;
  if vMsg <> ''
  then MostraAviso(vMsg);
  Result := (vMsg = '');
end;

function TFrmFichaVenda.ContratoJaInformado: String;
var
  vMsg: String;
  vCod: Integer;
begin
  vMsg := '';
  if cboEmpresa.getCodigo = 0
  then vMsg := 'EMPRESA deve ser informada!'
  else if Length(Trim(edContrato.Text))=0
  then vMsg := 'CONTRATO deve ser informado!'
  else begin
    vCod := FVenda.ContratoJaInformado(cboEmpresa.getCodigo, edContrato.Text);
    if FIncluindoVenda and (vCod > 0)
    then vMsg := Format('Contrato já INFORMADO na venda de código %.6d',[ vCod]);
  end;
  Result := vMsg;
end;

end.

