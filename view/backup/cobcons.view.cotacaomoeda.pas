unit cobcons.view.cotacaomoeda;

{$mode delphi}

interface

uses
  Classes, Sysutils, DB, Forms, Controls, Graphics, Dialogs, ActnList, ExtCtrls,
  Windows, StdCtrls, Buttons, DBGrids, DBCtrls, EditBtn, CheckLst, DateUtils,
  DateTimePicker, HNSCombox, cobcons.controller.interfaces;

type

  { TFrmCotacaoMoeda }

  TFrmCotacaoMoeda = class(Tform)
    imprimir: Taction;
    Al: Tactionlist;
    Btnexcluir: Tspeedbutton;
    btnImprimir: Tspeedbutton;
    Btnsair: Tspeedbutton;
    cbSabado: Tcheckbox;
    cbDomingo: Tcheckbox;
    edDias: Tedit;
    edVarDia: Tedit;
    Label6: Tlabel;
    Label7: Tlabel;
    lb: Tchecklistbox;
    edIndice: Tcalcedit;
    edData: Tdatetimepicker;
    Dbedit1: Tdbedit;
    Dbedit2: Tdbedit;
    ds: Tdatasource;
    gravar: Taction;
    cboMoeda: Thnscombox;
    Label1: Tlabel;
    Label2: Tlabel;
    Label3: Tlabel;
    Label4: Tlabel;
    Label5: Tlabel;
    Panel2: Tpanel;
    Pnacoes: Tpanel;
    Pnbackground: Tpanel;
    Pntitulo: Tpanel;
    Sair: Taction;
    procedure Cbdomingoclick(Sender: Tobject);
    procedure Cbomoedaselect(Sender: Tobject);
    procedure Cbsabadoclick(Sender: Tobject);
    procedure Eddataexit(Sender: Tobject);
    procedure Edindiceexit(Sender: Tobject);
    procedure Formclose(Sender: Tobject; var Closeaction: Tcloseaction);
    procedure Formcreate(Sender: Tobject);
    procedure Formkeydown(Sender: Tobject; var Key: Word; Shift: Tshiftstate);
    procedure Gravarexecute(Sender: Tobject);
    procedure Imprimirexecute(Sender: Tobject);
    procedure Lbclickcheck(Sender: Tobject);
    procedure Sairexecute(Sender: Tobject);
  Private
    FCotacao: iControllerCotacaoMoeda;
    procedure AtualizarTela;
    procedure AtualizarListBox;
    procedure MostrarDias;
    procedure Calcular;
  Public

  end;

var
  FrmCotacaoMoeda: TFrmCotacaoMoeda;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.rel.cotacoesmoeda;

{$R *.lfm}

{ TFrmCotacaoMoeda }

procedure Tfrmcotacaomoeda.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_RETURN: SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
End;

procedure Tfrmcotacaomoeda.Gravarexecute(Sender: Tobject);
var
  vTabular: iControllerTabularEncerrados;
begin
  if ConfirmaMensagem('Gravar as Cotações?')
  then begin
    vTabular := TControllerFactory.New.TabularEncerrados;
    FCotacao.MOEDA(cboMoeda.getAdicional).GravarCotacoes;
    vTabular.DATALIMITE(edData.Date).AtualizarSaldoRnp;
    ModalResult := mrOK;
  end;
End;

procedure Tfrmcotacaomoeda.Imprimirexecute(Sender: Tobject);
var
  vConsideraSabado,
  vConsideraDomingo: String;
begin
  FrmRelCotacoesMoeda := TFrmRelCotacoesMoeda.Create(nil);
  try
    FrmRelCotacoesMoeda.Dsprs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
    FrmRelCotacoesMoeda.Ds.DataSet := FCotacao.GerarDatasetCotacoes;
    FrmRelCotacoesMoeda.lblVariacaoPeriodo.Caption := Format('VARIAÇÃO PERIODO: %.9f %%',[edIndice.AsFloat]);
    FrmRelCotacoesMoeda.lblVariacaoDiaria.Caption := Format('VARIAÇÃO DIA: %s %%',[edVarDia.Text]);
    FrmRelCotacoesMoeda.Rl.Title := Format('COTAÇÃO MOEDA %s',[cboMoeda.Text]);
    vConsideraSabado := 'NÃO Considera Sábados';
    if cbSabado.Checked
    then vConsideraSabado := 'Considera Sábados';
    vConsideraDomingo := 'NÃO Considera Domingos';
    if cbDomingo.Checked
    then vConsideraDomingo := 'Considera Domingos';
    FrmRelCotacoesMoeda.lblConsideracoes.Caption := Format('%s, %s.', [vConsideraSabado, vConsideraDomingo]);
    FrmRelCotacoesMoeda.Rl.PreviewModal;
  finally
    FrmRelCotacoesMoeda.Free;
  end;
End;

procedure Tfrmcotacaomoeda.Lbclickcheck(Sender: Tobject);
begin
  FCotacao.AlternarStatusCotacao(lb.ItemIndex);
  MostrarDias;
  Calcular;
End;

procedure Tfrmcotacaomoeda.Sairexecute(Sender: Tobject);
begin
  Close;
End;

procedure Tfrmcotacaomoeda.Atualizartela;
begin
  FCotacao.GerarListaCotacoes(FCotacao.DATA, edData.Date, cbSabado.Checked, cbDomingo.Checked);
  lb.Clear;
  MostrarDias;
  if edIndice.AsFloat > 0
  then Calcular;
end;

procedure Tfrmcotacaomoeda.Atualizarlistbox;
begin
  FCotacao.AtualizarListBox(lb);
  gravar.Enabled := (lb.Items.Count > 0);
end;

procedure Tfrmcotacaomoeda.Mostrardias;
begin
  edDias.Text := Format('%.3d', [FCotacao.DIAS]);
  edVarDia.Text := Format('%.9f',[ (edIndice.AsFloat / FCotacao.DIAS)]);
end;

procedure Tfrmcotacaomoeda.Calcular;
begin
  FCotacao.INDICE(edIndice.AsFloat).CalcularCotacoes;
  AtualizarListBox;
end;

procedure Tfrmcotacaomoeda.Formclose(Sender: Tobject;
  var Closeaction: Tcloseaction);
begin
  Closeaction := caFree;
  self := nil;
End;

procedure Tfrmcotacaomoeda.Cbomoedaselect(Sender: Tobject);
begin
  ds.DataSet := FCotacao.UltimaCotacaoMoeda(cboMoeda.getAdicional).Dataset;
  edData.Date := IncDay(FCotacao.DATA);
  lb.Clear;
  edIndice.AsFloat := 0;
  edVarDia.Clear;
  edDias.Clear;
  gravar.Enabled := False;
End;

procedure Tfrmcotacaomoeda.Cbsabadoclick(Sender: Tobject);
begin
  AtualizarTela;
End;

procedure Tfrmcotacaomoeda.Eddataexit(Sender: Tobject);
begin
  AtualizarTela;
End;

procedure Tfrmcotacaomoeda.Edindiceexit(Sender: Tobject);
begin
  AtualizarTela;
End;

procedure Tfrmcotacaomoeda.Cbdomingoclick(Sender: Tobject);
begin
  AtualizarTela;
End;

procedure Tfrmcotacaomoeda.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnBackGround.Color := vEsquema.CorFundo;
  FCotacao := TControllerFactory.New.CotacaoMoeda;
  cboMoeda.Lista := TControllerFactory.New.CotacaoMoeda.ListarComboBox;
  edData.Date := NullDate;
End;

end.

