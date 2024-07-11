unit cobcons.view.novacomissaopermanencia;

{$mode delphi}

interface

uses
  Classes, Sysutils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ActnList, ComCtrls, StdCtrls, DBGrids, DBCtrls, HNSCombox, DateUtils, Windows,
  cobcons.controller.interfaces, DateTimePicker;

type

  { TFrmNovaComPerm }

  TFrmNovaComPerm = class(Tform)
    Cboagente: Thnscombox;
    Cbotipodoc: Thnscombox;
    cboGrupo: Tcombobox;
    Ds: Tdatasource;
    Edcalculo: Tdatetimepicker;
    Edcomissao: Tedit;
    edHist: Tedit;
    Edsaldofinal: Tedit;
    Edsaldoinicial: Tedit;
    gravar: Taction;
    Grpesq: Tdbgrid;
    imprimir: Taction;
    Al: Tactionlist;
    Btnpesq: Tspeedbutton;
    Btnpesq1: Tspeedbutton;
    Btnsair: Tspeedbutton;
    Btnsair1: Tspeedbutton;
    calcular: Taction;
    Label1: Tlabel;
    Label2: Tlabel;
    Label3: Tlabel;
    Label4: Tlabel;
    Label5: Tlabel;
    Label6: Tlabel;
    Label7: Tlabel;
    Label8: Tlabel;
    Mmlog: Tmemo;
    Nvpesq: Tdbnavigator;
    Panel1: Tpanel;
    Panel2: Tpanel;
    Panel4: Tpanel;
    Pc: Tpagecontrol;
    Pnacoes: Tpanel;
    Pnbackground: Tpanel;
    Pntitulo: Tpanel;
    Sair: Taction;
    Tscalculo: Ttabsheet;
    Tsresultado: Ttabsheet;
    procedure Calcularexecute(Sender: Tobject);
    procedure Cbogruposelect(Sender: Tobject);
    procedure Edcalculoexit(Sender: Tobject);
    procedure Formclose(Sender: Tobject; var Closeaction: Tcloseaction);
    procedure Formcreate(Sender: Tobject);
    procedure Formkeydown(Sender: Tobject; var Key: Word; Shift: Tshiftstate);
    procedure Gravarexecute(Sender: Tobject);
    procedure Grpesqdblclick(Sender: Tobject);

      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
      procedure Sairexecute(Sender: Tobject);
  Private
    FComissaoPermanencia : iControllerComissaoPermanencia;
    FItens : iControllerItemComissaoPermanencia;
    procedure AbrirFicha;
    procedure LogMensagem(pMsg: String);
    procedure MontarComboBoxGrupo;
    procedure PosicionarDataset(pGRupo: String);
  Public

  end;

var
  FrmNovaComPerm: TFrmNovaComPerm;

implementation

uses cobcons.model.configura, cobcons.model.planilha, cobcons.controller.util,
  cobcons.controller.factory;

const
  TODOS_GRUPOS = 'Todos';

{$R *.lfm}

{ TFrmNovaComPerm }

procedure Tfrmnovacomperm.Formclose(Sender: Tobject;
  var Closeaction: Tcloseaction);
begin
  Closeaction := caFree;
  self := nil;
End;

procedure Tfrmnovacomperm.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnBackGround.Color := vEsquema.CorFundo;
  edCalculo.Date := EndOfTheMonth( StartOfTheMonth( Date ) - 1);
  FComissaoPermanencia := TControllerFactory.New.ComissaoPermanencia;
  FItens := TControllerFactory.New.ItemComissaoPermanencia;
  cboAgente.Lista := TControllerFactory.New.Pagamentos.RetornaListaAgentes;
  cboTipoDoc.Lista := TControllerFactory.New.Pagamentos.RetornaListaTipoDocumento;
  edHist.Text := 'COMISSAO PERMANENCIA';
  Imprimir.Enabled := False;
  gravar.Enabled := False;
End;

procedure Tfrmnovacomperm.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused then AbrirFicha else SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
End;

procedure Tfrmnovacomperm.Gravarexecute(Sender: Tobject);
begin
  if cboAgente.ItemIndex = -1
  then MostraAviso('Precisa informar AGENTE antes de Gravar!')
  else if cboTipoDoc.ItemIndex = -1
  then MostraAviso('Precisa informar TIPO DOCUMENTO antes de Gravar!')
  else if ConfirmaMensagem('Confirma a Gravação da Comissão de Permanência?')
  then begin
    Pc.ActivePage := Tscalculo;
    FComissaoPermanencia.AGENTE(cboAgente.getAdicional)
                        .TPDOC(cboTipoDoc.getAdicional)
                        .DATACALCULO(Edcalculo.Date)
                        .HISTORICO(edHist.Text)
                        .LOG(LogMensagem)
                        .Gravar;
    ModalResult := mrOK;
  end;
End;

procedure Tfrmnovacomperm.Grpesqdblclick(Sender: Tobject);
begin
  AbrirFicha;
End;

procedure Tfrmnovacomperm.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmnovacomperm.Sairexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
End;

procedure Tfrmnovacomperm.Calcularexecute(Sender: Tobject);
begin
  Pc.ActivePage := Tscalculo;
  Imprimir.Enabled := False;
  gravar.Enabled := False;
  Ds.DataSet := FComissaoPermanencia.LOG(LogMensagem).DATACALCULO(edCalculo.Date).Calcular;
  if not Ds.DataSet.EOF
  then begin
    Imprimir.Enabled := True;
    gravar.Enabled := True;
    edSaldoInicial.Text := Format('%.2n',[FComissaoPermanencia.SALDOINICIAL]);
    edComissao.Text := Format('%.2n',[FComissaoPermanencia.COMISSAO]);
    edSaldoFinal.Text := Format('%.2n',[FComissaoPermanencia.SALDOFINAL]);
    TPlanilha.New.GerarPlanilha(FItens.ListarItensComissao(0).DataSet,'ComissaoPermanencia.xls');
    MontarComboBoxGrupo;
    Pc.ActivePage := Tsresultado;
  end;
End;

procedure Tfrmnovacomperm.Cbogruposelect(Sender: Tobject);
begin
  PosicionarDataset(cboGrupo.Text);
End;

procedure Tfrmnovacomperm.Edcalculoexit(Sender: Tobject);
begin
  edHist.Text := Format('COM. PERMANENCIA REF %s',[FormatDateTime('mmm/yyyy', Edcalculo.Date)]);
End;

procedure Tfrmnovacomperm.Abrirficha;
begin
  if not ds.DataSet.EOF
  then begin
    if ds.DataSet.FindField('Cota') <> nil
    then begin
      Self.Visible := False;
      AbrirFichaCota( ds.DataSet.FieldByName('Grupo').AsString,
                      ds.DataSet.FieldByName('Seq').AsString,
                      ds.DataSet.FieldByName('Cota').AsString);
      Self.Visible := True;
    end
    else PosicionarDataset(ds.DataSet.FieldByName('Grupo').AsString);
  end;
end;

procedure Tfrmnovacomperm.Logmensagem(Pmsg: String);
begin
  mmLog.Lines.Add(Pmsg);
end;

procedure Tfrmnovacomperm.Montarcomboboxgrupo;
begin
  cboGrupo.Clear;
  cboGrupo.Items.Add(TODOS_GRUPOS);
  while not ds.DataSet.EOF do
  begin
    cboGrupo.Items.Add(Ds.DataSet.FieldByName('GRUPO').AsString);
    Ds.DataSet.Next;
  end;
  Ds.DataSet.First;
  cboGrupo.ItemIndex := 0;
end;

procedure Tfrmnovacomperm.Posicionardataset(Pgrupo: String);
begin
  if Pgrupo = TODOS_GRUPOS
  then Ds.DataSet := FItens.ListarItensComissaoSinteticoGrupo(0).DataSet
  else Ds.DataSet := FItens.ListarItensComissaoGrupo(0, Pgrupo).DataSet;
  Ds.DataSet.First;
end;

end.

