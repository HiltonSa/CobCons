unit cobcons.view.imprimernpdatabase;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ActnList,
  StdCtrls, ComCtrls, DBGrids, Buttons, DBCtrls, cobcons.controller.interfaces,
  HNSCombox, DateTimePicker, DateUtils, DB, Windows;

type

  { TFrmImpRNPDataBase }

  TFrmImpRNPDataBase = class(TForm)
    gravar: TAction;
    btnPesq1: TSpeedButton;
    btnSair1: TSpeedButton;
    calculo: TAction;
    AL: TActionList;
    btnPesq: TSpeedButton;
    btnSair: TSpeedButton;
    cboAgente: THNSCombox;
    cboOrdem: TComboBox;
    cboTipoDoc: THNSCombox;
    ds: TDataSource;
    dtDataBase: TDateTimePicker;
    dtSeparar: TDateTimePicker;
    edHist: TEdit;
    edDif: TEdit;
    edSldContabil: TEdit;
    edSaldo: TEdit;
    edQtdCota: TEdit;
    grPesq: TDBGrid;
    imprimir: TAction;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    mmLog: TMemo;
    nvPesq: TDBNavigator;
    Pc: TPageControl;
    Panel2: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    pnAcoes: TPanel;
    pnBackGround: TPanel;
    pnTitulo: TPanel;
    Sair: TAction;
    tsLog: TTabSheet;
    tsDados: TTabSheet;
    procedure calculoExecute(Sender: TObject);
    procedure dtDataBaseExit(Sender: TObject);
    procedure edSldContabilExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gravarExecute(Sender: TObject);
    procedure grPesqDblClick(Sender: TObject);
    procedure imprimirExecute(Sender: TObject);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SairExecute(Sender: TObject);
  private
    FCalcularSaldo: iControllerSaldoRnpDataBase;
    FSaldoContabil,
    FSaldoRnp: Double;
    FInicio: TDateTime;
    procedure AbrirFicha;
    procedure LogMensagem(pMsg: String);
    procedure FimTarefas;
    function Critica: Boolean;
  public

  end;

var
  FrmImpRNPDataBase: TFrmImpRNPDataBase;

implementation

uses cobcons.controller.factory, cobcons.controller.util,
  cobcons.model.configura;

{$R *.lfm}

{ TFrmImpRNPDataBase }

procedure TFrmImpRNPDataBase.dtDataBaseExit(Sender: TObject);
begin
  dtDataBase.Date := EndOfTheMonth(dtDataBase.Date);
  calculo.Enabled := True;
  edHist.Text := Format('APLIC. RNP REF %s',[FormatDateTime('mmm/yyyy', dtDataBase.Date)]);
end;

procedure TFrmImpRNPDataBase.edSldContabilExit(Sender: TObject);
begin
  FSaldoContabil := StrToFloatDef(edSldContabil.Text,0);
  edSldContabil.Text := Format('%.2n',[FSaldoContabil]);
end;

procedure TFrmImpRNPDataBase.calculoExecute(Sender: TObject);
begin
  if (ConfirmaMensagem('Confirma a execução?'))
  then begin
    pc.ActivePage := tsLog;
    imprimir.Enabled := False;
    calculo.Enabled := False;
    mmLog.Clear;
    FInicio := Now;
    //ds.DataSet := FTabular.DATALIMITE(dtDataBase.Date)
    //                      .DATASEP(dtSeparar.Date)
    //                      .DATAREF(cboOrdem.ItemIndex)
    //                      .LOG(LogMensagem)
    //                      .ANDAMENTO(LogMensagem)
    //                      .CalcularSaldoRnpDataBase(FSaldoContabil);
    FCalcularSaldo.DATABASE(dtDataBase.Date)
                  .DATASEP(dtSeparar.Date)
                  .DATAREF(cboOrdem.ItemIndex)
                  .LOG(LogMensagem)
                  .CalcularSaldoRnpDataBase(FSaldoContabil);
  end;
end;

procedure TFrmImpRNPDataBase.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmImpRNPDataBase.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnBackGround.Color := vEsquema.CorFundo;
  dtDataBase.Date := StartOfTheMonth(Date) - 1;
  cboAgente.Lista := TControllerFactory.New.Pagamentos.RetornaListaAgentes;
  cboTipoDoc.Lista := TControllerFactory.New.Pagamentos.RetornaListaTipoDocumento;
  edHist.Text := 'COMISSAO PERMANENCIA';
  //FTabular := TControllerFactory.New.TabularEncerrados;
  FCalcularSaldo := TControllerFactory.New.SaldoRnpDataBase;
  FSaldoContabil := 0;
  FSaldoRnp := 0;
end;

procedure TFrmImpRNPDataBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused
               then AbrirFicha
               else SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
end;

procedure TFrmImpRNPDataBase.gravarExecute(Sender: TObject);
var
  vInicio: TDateTime;

begin

  if (Critica) and (ConfirmaMensagem('Confirma a Gravação da Aplicação RNP ?'))
  then begin
    vInicio := Now;
    Pc.ActivePage := tsLog;
    FCalcularSaldo.GravarAplicacaoRnp( cboAgente.getAdicional,
                                 cboTipoDoc.getAdicional,
                                 edHist.Text,
                                 dtDataBase.Date,
                                 (FSaldoContabil - FSaldoRnp));
    gravar.Enabled := False;
    TempoDecorrido('Fim da Gravação. Duração: ', vInicio);
    //ModalResult := mrOK;
  end;
end;

procedure TFrmImpRNPDataBase.grPesqDblClick(Sender: TObject);
begin
  AbrirFicha;
end;

procedure TFrmImpRNPDataBase.imprimirExecute(Sender: TObject);
begin
    if ConfirmaMensagem('Confirma a execução?')
    then begin
    end;
end;

procedure TFrmImpRNPDataBase.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmImpRNPDataBase.SairExecute(Sender: TObject);
begin
  Close;
end;

procedure TFrmImpRNPDataBase.AbrirFicha;
var
  vCota: Boolean;
begin
  vCota := ds.DataSet.FindField('Cota') <> nil;
  if vCota
  then begin
    Self.Visible := False;
    AbrirFichaCota( ds.DataSet.FieldByName('Grupo').AsString,
                    ds.DataSet.FieldByName('Seq').AsString,
                    ds.DataSet.FieldByName('Cota').AsString);
    Self.Visible := True;
  end;
end;

procedure TFrmImpRNPDataBase.LogMensagem(pMsg: String);
begin
  mmLog.Lines.Add(Pmsg);
  if Pos('Fim',pMsg) > 0
  then FimTarefas;
end;

procedure TFrmImpRNPDataBase.FimTarefas;
var
  vDistribuir: Double;
begin
  //MostraAviso('Receber dataset!');
  ds.DataSet := FCalcularSaldo.Dataset;
  //FSaldoRnp := FTabular.RetornarSaldoDataBase;
  FSaldoRnp := FCalcularSaldo.RetornarSaldoDataBase;
  //TempoDecorrido('Fim do Cálculo. Duração: ', FInicio);
  mmLog.Lines.SaveToFile('LogTabulacao.txt');
  imprimir.Enabled := True;
  DataSetParaPlanilha(ds.DataSet, Format('SaldoRnp%s.xls',[FormatDateTime('ddMMMyy', dtDataBase.Date)]));
  pc.ActivePage := tsDados;
  edSaldo.Text := Format('%13.2n', [FSaldoRnp]);
  vDistribuir := (FSaldoContabil - FSaldoRnp);
  edDif.Text := Format('%13.2n', [vDistribuir]);
  edQtdCota.Text := format('%.8d',[ds.DataSet.RecordCount]);
  gravar.Enabled := vDistribuir > 0;
end;

function TFrmImpRNPDataBase.Critica: Boolean;
var
  vNumDoc: String;
  vExecutar: Boolean;
  vPagamentos: iControllerPagamentos;
begin
  vExecutar := False;
  if FSaldoContabil = 0
  then  MostraErro('Precisa informar Saldo Contábil!')
  else  if cboAgente.ItemIndex = -1
  then MostraAviso('Precisa informar AGENTE!')
  else if cboTipoDoc.ItemIndex = -1
  then MostraAviso('Precisa informar TIPO DOCUMENTO!')
  else begin
    vExecutar := True;
    vPagamentos := TControllerFactory.New.Pagamentos;
     vNumDoc := vPagamentos.RetornaDocumentoAgente(cboAgente.getAdicional,cboTipoDoc.getAdicional,'',dtDataBase.Date);
     LogMensagem( Format('Pesquisa por Agente: %s Tipo: %s Contab: %s Resultou: %s.',
                         [ cboAgente.getAdicional,
                           cboTipoDoc.getAdicional,
                           RetornaDataSql(dtDataBase.Date),
                           vNumDoc]));
     if (vNumDoc<>'')
     then begin
        if ConfirmaMensagem('Atenção, movimentos de aplicação encontrados. Excluir?')
        then vPagamentos.ExcluirComissaoPermanencia(cboAgente.getAdicional, vNumDoc)
        else vExecutar := False;
     end;
  end;
  Result := vExecutar;
end;

end.

