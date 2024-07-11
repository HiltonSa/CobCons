unit cobcons.view.gerarasvr;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, Forms, Controls, Graphics, Dialogs, ActnList,
  ExtCtrls, StdCtrls, DateTimePicker, Buttons, DBGrids,
  cobcons.controller.interfaces, DB, DateUtils;
type

  { TFrmGerarAsvr }

  TFrmGerarAsvr = class(TForm)
    pesquisar: TAction;
    AL: TActionList;
    Cancelar: TAction;
    cboRemessa: TComboBox;
    ds: TDataSource;
    dtBase: TDateTimePicker;
    edArq: TEdit;
    gravar: TAction;
    grPesq: TDBGrid;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    pnAcoes: TPanel;
    pnBack: TPanel;
    pnTitulo: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure CancelarExecute(Sender: TObject);
    procedure edArqClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gravarExecute(Sender: TObject);
    procedure pesquisarExecute(Sender: TObject);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    FPgRnp: iControllerPgRnp;
    function ValidarEntrada: Boolean;
  public

  end;

var
  FrmGerarAsvr: TFrmGerarAsvr;

implementation

{$R *.lfm}

uses cobcons.controller.util, cobcons.controller.factory,
  cobcons.model.configura, cobcons.model.dm;

{ TFrmGerarAsvr }

procedure TFrmGerarAsvr.gravarExecute(Sender: TObject);
var
  vArquivo: TStringList;
begin
  if (ValidarEntrada) and (ConfirmaMensagem('Gerar o Arquivo ?'))
  then begin
    vArquivo := TStringList.Create;
    try
      FPgRnp.GerarAsvr( copy(cboRemessa.Text,1,1),
                        '37137767',
                        dtBase.Date,
                        vArquivo,
                        ds.DataSet);
      vArquivo.SaveToFile(edArq.Text);
    finally
      vArquivo.Free;
    end;
    ModalResult := mrOK;
  end;
end;

procedure TFrmGerarAsvr.pesquisarExecute(Sender: TObject);
begin
  ds.DataSet := FPgRnp.PesquisarAsvr(dtBase.Date);
  gravar.Enabled := not ds.DataSet.IsEmpty;
end;

procedure TFrmGerarAsvr.pnTituloMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

function TFrmGerarAsvr.ValidarEntrada: Boolean;
var
  vErro : String;
begin
  vErro := '';
  if Length(Trim(edArq.Text)) = 0
  then vErro := 'Precisa informar Arquivo!'
  else if (ds.DataSet.IsEmpty) or (ds.DataSet = nil)
  then vErro := 'Sem dados para gerar o Documento 9805';
  if vErro <> ''
  then begin
    MostraErro(vErro);
    dtBase.SetFocus;
  end;
  Result := (vErro = '');
end;

procedure TFrmGerarAsvr.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Cancelar.Execute;
  end;
end;

procedure TFrmGerarAsvr.CancelarExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmGerarAsvr.edArqClick(Sender: TObject);
var
  vNome: String;
begin
  vNome := Format('asvr9805-%.4d%.2d.xml',
                      [ YearOf(Dtbase.Date),
                        MonthOf(Dtbase.Date)]);
  DM.SalvarArquivo.InitialDir := '\Aqua\Acwin\BACEN\9805';
  DM.SalvarArquivo.FileName := vNome;
  if DM.SalvarArquivo.Execute
  then edArq.Text := DM.SalvarArquivo.FileName;
end;

procedure TFrmGerarAsvr.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnBack.Color := vEsquema.CorFundo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  dtBase.Date := StartOfTheMonth(Date)-1;
  FPgRnp := TControllerFactory.New.PagamentosRnp;
end;


end.

