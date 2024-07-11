unit cobcons.view.tabularencerrados;

{$mode delphi}

interface

uses
  Classes, Sysutils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ActnList, Buttons, ComCtrls, Spin, DateTimePicker, DateUtils, Windows, DB,
  cobcons.controller.interfaces;

type

  { TFrmTabularEncerrados }

  TFrmTabularEncerrados = class(Tform)
    btnRes: Tspeedbutton;
    resumo: Taction;
    rnp: Taction;
    Al: Tactionlist;
    Btnincluir: Tspeedbutton;
    btnRel: Tspeedbutton;
    Btnsair: Tspeedbutton;
    dtLimite: Tdatetimepicker;
    edSldRnp: Tedit;
    Executar: Taction;
    edLimiteMinimo: Tfloatspinedit;
    Label1: Tlabel;
    Label2: Tlabel;
    Label3: Tlabel;
    mmLog: Tmemo;
    Pnacoes: Tpanel;
    Pnrodape: Tpanel;
    pnBack: Tpanel;
    Pntitulo: Tpanel;
    pb: Tprogressbar;
    Sair: Taction;
    procedure Executarexecute(Sender: Tobject);
    procedure Formclose(Sender: Tobject; var Closeaction: Tcloseaction);
    procedure Formcreate(Sender: Tobject);
    procedure Formkeydown(Sender: Tobject; var Key: Word; Shift: Tshiftstate);
    procedure Resumoexecute(Sender: Tobject);
    procedure Rnpexecute(Sender: Tobject);
    procedure Sairexecute(Sender: Tobject);
    procedure Mensagemrodape(Pmsg: String);
    procedure LogMensagem(pMsg: String);
    procedure PbInicio(pMax: Integer);
    procedure PbPosicao(pPos: Integer);
  Private
    FMsg: String;
    FEmpresa : iControllerEmpresa;
    FTabular : iControllerTabularEncerrados;

  Public

  end;

var
  FrmTabularEncerrados: TFrmTabularEncerrados;

implementation

uses cobcons.model.configura, cobcons.model.planilha, cobcons.controller.util,
  cobcons.controller.factory;

{$R *.lfm}

{ TFrmTabularEncerrados }

procedure Tfrmtabularencerrados.Sairexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
End;

procedure Tfrmtabularencerrados.Mensagemrodape(Pmsg: String);
begin
  FMsg := Pmsg;
  Pnrodape.Caption := Pmsg;
end;

procedure Tfrmtabularencerrados.Logmensagem(Pmsg: String);
begin
  mmLog.Lines.Add(Pmsg);
end;

procedure Tfrmtabularencerrados.Pbinicio(Pmax: Integer);
begin
  pb.Position := 0;
  pb.Max := Pmax;
end;

procedure Tfrmtabularencerrados.Pbposicao(Ppos: Integer);
begin
  pb.Position := Ppos;
  Pnrodape.Caption := Format('%s (%d de %d)',[FMsg, Ppos, pb.Max]);
  Application.ProcessMessages;
end;

procedure Tfrmtabularencerrados.Executarexecute(Sender: Tobject);
var
  vInicio: TDateTime;
begin
  if FEmpresa.STGRUENCCT = ''
  then MostraAviso('Necessário definir parâmetro Situação Encerramento Contábil do Grupo!')
  else if FEmpresa.FASEAJUIZ = ''
  then MostraAviso('Necessário definir parâmetro Fase de Ajuizamento da Cota!')
  else begin
    if ConfirmaMensagem('Confirma a execução?')
    then begin
      vInicio := Now;
      FTabular.DATALIMITE(dtLimite.Date)
              .LIMITEMINIMO(edLimiteMinimo.Value)
              .ANDAMENTO(Mensagemrodape)
              .LOG(LogMensagem)
              .PBINICIO(PbInicio)
              .PBPOSICAO(PbPosicao)
              .Tabular;
      TempoDecorrido('Fim da Tabulação. Duração: ', vInicio);
      mmLog.Lines.SaveToFile('LogTabulacao.txt');
      ModalResult := mrOK;
    end;
  end;
End;

procedure Tfrmtabularencerrados.Formclose(Sender: Tobject;
  var Closeaction: Tcloseaction);
begin
  Closeaction := caFree;
  self := nil;
End;

procedure Tfrmtabularencerrados.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnRodape.Color := vEsquema.CorPainelRodape;
  pnBack.Color := vEsquema.CorFundo;
  FEmpresa := TControllerFactory.New.Empresa.RecuperarEmpresa;
  FTabular := TControllerFactory.New.TabularEncerrados;
  dtLimite.Date := StartOfTheMonth(Date) - 1; // ultimo dia do mês passado
  edSldRnp.Caption := FormatDateTime('dd/mm/yyyy',FEmpresa.DTRECSLDRNP);
End;

procedure Tfrmtabularencerrados.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_RETURN: SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
End;

procedure Tfrmtabularencerrados.Resumoexecute(Sender: Tobject);
var
  vInicio: TDateTime;
  vDataset: TDataSet;
  vPlanilha: iModelPlanilha;
begin
  if FEmpresa.STGRUENCCT = ''
  then MostraAviso('Necessário definir parâmetro Situação Encerramento Contábil do Grupo!')
  else if FEmpresa.FASEAJUIZ = ''
  then MostraAviso('Necessário definir parâmetro Fase de Ajuizamento da Cota!')
  else begin
    if ConfirmaMensagem('Confirma a execução?')
    then begin
      vPlanilha := TPlanilha.New;
      vInicio := Now;
      vDataset := FTabular.DATALIMITE(dtLimite.Date)
                          .LIMITEMINIMO(edLimiteMinimo.Value)
                          .ANDAMENTO(Mensagemrodape)
                          .LOG(LogMensagem)
                          .PBINICIO(PbInicio)
                          .PBPOSICAO(PbPosicao)
                          .ResumoCalculo;
      vPlanilha.GerarPlanilha(vDataset, 'ResCal.xls');
      TempoDecorrido('Fim do Resumo Calculo. Duração: ', vInicio);
      mmLog.Lines.SaveToFile('LogResCalculo.txt');

      ModalResult := mrOK;
    end;
  end;
End;

procedure Tfrmtabularencerrados.Rnpexecute(Sender: Tobject);
var
  vInicio: TDateTime;
begin
  if FEmpresa.STGRUENCCT = ''
  then MostraAviso('Necessário definir parâmetro Situação Encerramento Contábil do Grupo!')
  else if FEmpresa.FASEAJUIZ = ''
  then MostraAviso('Necessário definir parâmetro Fase de Ajuizamento da Cota!')
  else begin
    if ConfirmaMensagem('Confirma a execução?')
    then begin
      vInicio := Now;
      FTabular.DATALIMITE(dtLimite.Date)
              .LIMITEMINIMO(edLimiteMinimo.Value)
              .ANDAMENTO(Mensagemrodape)
              .LOG(LogMensagem)
              .PBINICIO(PbInicio)
              .PBPOSICAO(PbPosicao)
              .Tabular;
      TempoDecorrido('Fim da Tabulação. Duração: ', vInicio);
      mmLog.Lines.SaveToFile('LogTabulacao.txt');
      ModalResult := mrOK;
    end;
  end;
End;

end.

