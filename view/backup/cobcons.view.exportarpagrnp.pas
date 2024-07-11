unit cobcons.view.exportarpagrnp;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, Forms, Controls, Graphics, Dialogs, ActnList,
  ExtCtrls, StdCtrls, DateTimePicker, Buttons, cobcons.controller.interfaces,
  DB, DateUtils;

type

  { TFrmExportarPgRnp }

  TFrmExportarPgRnp = class(TForm)
    AL: TActionList;
    Cancelar: TAction;
    cbExp: TCheckBox;
    dtBase: TDateTimePicker;
    edArq: TEdit;
    edCPart2: TEdit;
    edFil: TEdit;
    edEmp: TEdit;
    edPart: TEdit;
    edCPart1: TEdit;
    edQtd: TEdit;
    edTotal: TEdit;
    gravar: TAction;
    Label1: TLabel;
    Label10: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lbFil: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    lbFil1: TLabel;
    pnAcoes: TPanel;
    pnBack: TPanel;
    pnTitulo: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure CancelarExecute(Sender: TObject);
    procedure dtBaseChange(Sender: TObject);
    procedure edArqClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gravarExecute(Sender: TObject);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    FTotal: Double;
    FQtd: Integer;
    FDatasetPagamentos: TDataset;
    procedure SetDatasetPagamentos(AValue: TDataset);
    procedure CalcularTotais;
    function ValidarEntrada: Boolean;
  public
    property DatasetPagamentos: TDataset read FDatasetPagamentos write SetDatasetPagamentos;
  end;

var
  FrmExportarPgRnp: TFrmExportarPgRnp;

implementation

{$R *.lfm}

uses cobcons.controller.util, cobcons.controller.factory,
  cobcons.model.configura, cobcons.model.dm;

{ TFrmExportarPgRnp }

procedure TFrmExportarPgRnp.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmExportarPgRnp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Cancelar.Execute;
  end;
end;

procedure TFrmExportarPgRnp.gravarExecute(Sender: TObject);
var
  vPagRnp: iControllerPgRnp;
  vArquivo: TStringList;
begin
  if (ValidarEntrada) and (ConfirmaMensagem('Gerar o Arquivo ?'))
  then begin
    vPagRnp := TControllerFactory.New.PagamentosRnp;
    vArquivo := TStringList.Create;
    try
      vPagRnp.GerarExportacao( edEmp.Text,
                               edFil.Text,
                               edPart.Text,
                               edCPart1.Text,
                               edCPart2.Text,
                               dtBase.Date,
                               FDatasetPagamentos,
                               vArquivo,
                               cbExp.Checked);
      vArquivo.SaveToFile(edArq.Text);
    finally
      vArquivo.Free;
    end;
    ModalResult := mrOK;
  end;
end;

procedure TFrmExportarPgRnp.CancelarExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmExportarPgRnp.dtBaseChange(Sender: TObject);
begin
  dtBase.Date := EndOfTheMonth(dtBase.Date);
end;

procedure TFrmExportarPgRnp.edArqClick(Sender: TObject);
begin
  if DM.SalvarArquivo.Execute
  then edArq.Text := DM.SalvarArquivo.FileName;
end;

procedure TFrmExportarPgRnp.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnBack.Color := vEsquema.CorFundo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  dtBase.Date := StartOfTheMonth(Date)-1;
end;

procedure TFrmExportarPgRnp.SetDatasetPagamentos(AValue: TDataset);
begin
  if FDatasetPagamentos = AValue then Exit;
  FDatasetPagamentos := AValue;
  CalcularTotais;
end;

procedure TFrmExportarPgRnp.CalcularTotais;
begin
  FQtd := 0;
  FTotal := 0;
  FDatasetPagamentos.First;
  while not FDatasetPagamentos.EOF do
  begin
    if FDatasetPagamentos.FieldByName('DTPAGTO').AsDateTime <= dtBase.Date
    then begin
      FQtd := FQtd + 1;
      FTotal := FTotal + FDatasetPagamentos.FieldByName('VALOR').AsFloat;
    end;
    FDatasetPagamentos.Next;
  end;
  FDatasetPagamentos.First;
  edQtd.Text := Format('%.3d',[FQtd]);
  edTotal.Text := Format('%n',[FTotal]);
  gravar.Enabled := FQtd > 0;
end;

function TFrmExportarPgRnp.ValidarEntrada: Boolean;
var
  vErro : String;
begin
  vErro := '';
  if StrToIntDef(Trim(edEmp.Text), 0) = 0
  then vErro := 'Precisa informar Empresa!'
  else if StrToIntDef(Trim(edFil.Text), 0) = 0
  then vErro := 'Precisa informar Filial!'
  else if StrToIntDef(Trim(edPart.Text), 0) = 0
  then vErro := 'Precisa informar Conta Partida!'
  else if StrToInt64Def(Trim(edCPart1.Text), 0) = 0
  then vErro := 'Precisa informar Contra Partida 1!'
  else if StrToInt64Def(Trim(edCPart2.Text), 0) = 0
  then vErro := 'Precisa informar Contra Partida 2!'
  else if Length(Trim(edArq.Text)) = 0
  then vErro := 'Precisa informar Arquivo!';
  if vErro <> ''
  then begin
    MostraErro(vErro);
    dtBase.SetFocus;
  end;
  Result := (vErro = '');
end;

end.

