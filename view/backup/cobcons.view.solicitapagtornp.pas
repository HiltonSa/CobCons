unit cobcons.view.solicitapagtornp;

{$mode Delphi}

interface

uses
  Classes, Windows, SysUtils, DB, process, Forms, Controls, Graphics, Dialogs,
  ActnList, ExtCtrls, StdCtrls, Buttons, cobcons.controller.interfaces, Math;

type

  { TFrmSolicitaPagtoRnp }

  TFrmSolicitaPagtoRnp = class(TForm)
    AL: TActionList;
    Cancelar: TAction;
    cbCon: TCheckBox;
    cbRes: TCheckBox;
    cbImprimeCCDev: TCheckBox;
    edArq: TEdit;
    edDespesa: TEdit;
    edFonte: TEdit;
    edQtd: TEdit;
    edTotal: TEdit;
    gravar: TAction;
    Label4: TLabel;
    Label5: TLabel;
    Label51: TLabel;
    Label54: TLabel;
    Label8: TLabel;
    pnAcoes: TPanel;
    pnBack: TPanel;
    pnTitulo: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure CancelarExecute(Sender: TObject);
    procedure cbImprimeCCDevClick(Sender: TObject);
    procedure edArqClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure gravarExecute(Sender: TObject);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    FDatasetSolicita: TDataSet;
    procedure GerarCCDev;
    procedure SetDatasetSolicita(AValue: TDataSet);
    procedure AlterarStatus(pStatus: Integer);
    procedure CriarPDFSolicita(pRelatorio: Boolean = False);
    procedure CriarPDFCCDevolucoes(pGrupo, pSeq, pCota, pNomeArquivo: String);
    procedure JuntarPDFS;
    procedure ApagarArquivos;
    procedure AtualizarValores;
  public
    property DatasetSolicita: TDataSet read FDatasetSolicita write SetDatasetSolicita;
  end;

var
  FrmSolicitaPagtoRnp: TFrmSolicitaPagtoRnp;

implementation

uses cobcons.controller.util, cobcons.controller.factory,
  cobcons.model.configura, cobcons.model.dm, cobcons.view.rel.solicitarpgrnp,
  cobcons.view.rel.ccdevolucao;

{$R *.lfm}

{ TFrmSolicitaPagtoRnp }

procedure TFrmSolicitaPagtoRnp.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmSolicitaPagtoRnp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Cancelar.Execute;
  end;
end;

procedure TFrmSolicitaPagtoRnp.FormShow(Sender: TObject);
begin
  AtualizarValores;
end;

procedure TFrmSolicitaPagtoRnp.gravarExecute(Sender: TObject);
begin
  CriarPDFSolicita(True);
  if Length(Trim(edArq.Text)) = 0
  then begin
    MostraAviso('Precisa informar arquivo de destino!');
    edArq.SetFocus;
  end
  else if ConfirmaMensagem('Confirma a solicitação?')
  then begin

    CriarPDFSolicita;

    GerarCCDev;

    JuntarPDFS;

    AlterarStatus(1);

    ModalResult := mrOK;
  end;
end;

procedure TFrmSolicitaPagtoRnp.CancelarExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmSolicitaPagtoRnp.cbImprimeCCDevClick(Sender: TObject);
begin
  cbRes.Enabled := cbImprimeCCDev.Checked;
  cbCon.Enabled := cbRes.Enabled;
end;

procedure TFrmSolicitaPagtoRnp.edArqClick(Sender: TObject);
begin
  if DM.SalvarArquivo.Execute
  then edArq.Text := DM.SalvarArquivo.FileName;
end;

procedure TFrmSolicitaPagtoRnp.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnBack.Color := vEsquema.CorFundo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
end;

procedure TFrmSolicitaPagtoRnp.SetDatasetSolicita(AValue: TDataSet);
begin
  FDatasetSolicita := AValue;
end;

procedure TFrmSolicitaPagtoRnp.GerarCCDev;
var
  vCota: String;
  vSeq: String;
  vGrupo: String;
  vNomeArquivo: String;
begin
  FDatasetSolicita.First;
  while not FDatasetSolicita.EOF do
  begin

    vGrupo := FDatasetSolicita.FieldByName('GRUPO').AsString;
    vSeq := FDatasetSolicita.FieldByName('SEQ').AsString;
    vCota := FDatasetSolicita.FieldByName('COTA').AsString;
    vNomeArquivo := Format('tmp\PGRNPCCDev%s%s%s.pdf', [vGrupo, vSeq, vCota]);
    CriarPDFCCDevolucoes(vGrupo, vSeq, vCota, vNomeArquivo);

    FDatasetSolicita.Next;
  end;
end;

procedure TFrmSolicitaPagtoRnp.AlterarStatus(pStatus: Integer);
var
  vPgRnp: iControllerPgRnp;
begin
  vPgRnp := TControllerFactory.New.PagamentosRnp;
  FDatasetSolicita.First;
  while not FDatasetSolicita.EOF do
  begin
    vPgRnp.STATUS(pStatus)
          .CODIGO(FDatasetSolicita.FieldByName('CODIGO').AsInteger)
          .GravarStatus;
    FDatasetSolicita.Next;
  end;
  FDatasetSolicita.First;
end;

procedure TFrmSolicitaPagtoRnp.CriarPDFSolicita(pRelatorio: Boolean = False);
begin
  FrmRelSolicitarPgRnp := TFrmRelSolicitarPgRnp.Create(nil);
  try
     FrmRelSolicitarPgRnp.ds.DataSet := FDatasetSolicita;
     FrmRelSolicitarPgRnp.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
     FrmRelSolicitarPgRnp.lblDespesa.Caption := 'DESPESA: '+edDespesa.Text;
     FrmRelSolicitarPgRnp.lblFonte.Caption := 'FONTE: '+edFonte.Text;
     if pRelatorio
     then FrmRelSolicitarPgRnp.rl.PreviewModal
     else begin
       FrmRelSolicitarPgRnp.rl.SaveToFile('tmp\PGRNPSolicita.pdf');
       FrmRelSolicitarPgRnp.rl.Prepare;
       dm.Pdf.FilterPages(FrmRelSolicitarPgRnp.rl.Pages);
     end;
  finally
    FrmRelSolicitarPgRnp.Free;
  end;
end;

procedure TFrmSolicitaPagtoRnp.CriarPDFCCDevolucoes(pGrupo, pSeq, pCota, pNomeArquivo: String
  );
var
  vCliente: Icontrollercota;
  vFicha: iControllerFichaPagamentos;
begin
  vCliente := TControllerFactory.New.Cota.PesquisarGrupoSeqCota(pGrupo,pSeq,pCota);
  vFicha := TControllerFactory.New.FichaPagamentos;

  FrmCCDev := TFrmCCDev.Create(nil);
  try
    FrmCCDev.lblDcSitCob.Caption := vCliente.DCSITCOB;
    FrmCCDev.lblDcTpConte.Caption := vCliente.DCTPCONTE;
    FrmCCDev.dsTot.DataSet := TControllerFactory.New.FichaPagamentos.GRUPO(pGrupo).SEQ(pSeq).COTA(pCota).CalcularSaldoDevedorCota;
    FrmCCDev.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
    FrmCCDev.dsMov.DataSet := vFicha.GRUPO(pGrupo).SEQ(pSeq).COTA(pCota).DATALIMITE(Date).ContaCorrenteDevolucoes;
    FrmCCDev.bndResumoFinanceiro.Visible := cbRes.Checked;
    FrmCCDev.bndContrato.Visible := cbCon.Checked;
    FrmCCDev.dsCot.DataSet := vCliente.Dataset;

    FrmCCDev.Rp.SaveToFile(pNomeArquivo);
    FrmCCDev.Rp.Prepare;
    dm.Pdf.FilterPages(FrmCCDev.Rp.Pages);

  finally
    FrmCCDev.Free;
  end;

end;

procedure TFrmSolicitaPagtoRnp.JuntarPDFS;
var
  vProcesso: TProcess;
  vComando: String;
begin
  try
    vComando := 'bin\pdftk ';
    vComando := vComando +'tmp\PGRNPSolicita.pdf tmp\PGRNPCCDev*.pdf ';
    vComando := vComando +'cat output '+edArq.Text;
    vProcesso := TProcess.Create(nil);
    vProcesso.CommandLine :=  vComando;
    vProcesso.Options := vProcesso.Options + [poWaitOnExit];
    vProcesso.Execute;
    ApagarArquivos;
  finally
         vProcesso.Free;
  end;
end;

procedure TFrmSolicitaPagtoRnp.ApagarArquivos;
var
  SR: TSearchRec;
  I: integer;
begin
  I := FindFirst('tmp\PGRNP*.pdf', faAnyFile, SR);
  while I = 0 do begin
    if (SR.Attr and faDirectory) <> faDirectory
    then DeleteFile('tmp\' + SR.Name);
    I := FindNext(SR);
  end;
end;

procedure TFrmSolicitaPagtoRnp.AtualizarValores;
var
  vCalcular: iControllerTabularEncerrados;
  vPgRnp: iControllerPgRnp;
  vCota,
  vSeq,
  vGrupo: String;
  vCod,
  vAtualizado: Integer;
  vSaldo,
  vTotal,
  vValor: Double;
begin
  vCalcular := TControllerFactory.New.TabularEncerrados;
  vPgRnp := TControllerFactory.New.PagamentosRnp;
  vAtualizado := 0;
  vTotal := 0;

  FDatasetSolicita.First;
  while not FDatasetSolicita.EOF do
  begin

    vGrupo := FDatasetSolicita.FieldByName('GRUPO').AsString;
    vSeq := FDatasetSolicita.FieldByName('SEQ').AsString;
    vCota := FDatasetSolicita.FieldByName('COTA').AsString;
    vCod := FDatasetSolicita.FieldByName('CODIGO').AsInteger;
    vValor := FDatasetSolicita.FieldByName('VALOR').AsFloat;

    vSaldo := vCalcular.DATALIMITE(Date).CalcularSaldoRnpCota(vGrupo, vSeq, vCota, nil);

    if CompareValue(vValor, vSaldo, 0.001) = 0
    then begin
      vPgRnp.CODIGO(vCod).VALOR(vSaldo).AtualizarValorPagar;
      Inc(vAtualizado);
    end;
    vTotal := vTotal + vSaldo;

    FDatasetSolicita.Next;
  end;
  FDatasetSolicita.First;

  if vAtualizado > 0
  then MostraAviso(Format('%d valores foram atualizados!',[vAtualizado]));

  edQtd.Text := Format('%.4d',[FDatasetSolicita.RecordCount]);
  edTotal.Text := Format('%n',[vTotal]);

end;

end.

