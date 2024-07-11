unit cobcons.view.principal;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  jpeg, AppEvnts, JvComponentBase, JvBaseDlg, JvJVCLAboutForm, JvFormTransparent, JvGradientCaption,
{$ELSE}
{$ENDIF}
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Menus, ImgList, ActnList, ExtCtrls, StdCtrls,
  cobcons.controller.interfaces, cobcons.view.pagamentornp, LCLType;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    resven: TAction;
    venagente: TAction;
    cancper: TAction;
    prodven: TAction;
    relcom: TAction;
    parcpend: TAction;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    Separator2: TMenuItem;
    Separator3: TMenuItem;
    vendas: TAction;
    recaut: TAction;
    recmanual: TAction;
    comissao: TAction;
    agentes: TAction;
    equipes: TAction;
    filiais: TAction;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    regras: TAction;
    faixas: TAction;
    admcon: TAction;
    movper: TAction;
    IdlTmr: TIdleTimer;
    pagrnp: TAction;
    ratrec: TAction;
    Menuitem6: Tmenuitem;
    relSag: Taction;
    ccdev: Taction;
    grupos: Taction;
    Menuitem3: Tmenuitem;
    Menuitem4: Tmenuitem;
    Menuitem5: Tmenuitem;
    recrnp: Taction;
    cotacao: Taction;
    lblEmpresa: Tlabel;
    lblPrograma: Tlabel;
    lblUsuario: Tlabel;
    lblDataHora: Tlabel;
    devolucao: Tmenuitem;
    Menuitem1: Tmenuitem;
    Menuitem2: Tmenuitem;
    recebimentos: Tmenuitem;
    pnRodape: Tpanel;
    pnTitulo: Tpanel;
    BG: TImage;
    AE: TApplicationProperties;
    PM: TPopupMenu;
    PanodeFundo2: TMenuItem;
    rocarSenha2: TMenuItem;
    N4: TMenuItem;
    Sair2: TMenuItem;
    AL: TActionList;
    Sair: TAction;
    Separator1: TMenuItem;
    TabUsu: TAction;
    ApoBak: TAction;
    ApoSen: TAction;
    ApoPrs: TAction;
    MM: TMainMenu;
    abelas1: TMenuItem;
    Toolbutton10: Ttoolbutton;
    Toolbutton11: Ttoolbutton;
    Toolbutton12: Ttoolbutton;
    Toolbutton5: Ttoolbutton;
    Toolbutton9: Ttoolbutton;
    Usurios1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    Movimentao1: TMenuItem;
    Relatrios1: TMenuItem;
    Apoio1: TMenuItem;
    PanodeFundo1: TMenuItem;
    rocarSenha1: TMenuItem;
    N5: TMenuItem;
    Personalizao1: TMenuItem;
    TB: TToolBar;
    ToolButton4: TToolButton;
    ToolButton1: TToolButton;
    ImpGru: TAction;
    Cli: TAction;
    ToolButton2: TToolButton;
    Clientes1: TMenuItem;
    CotasdoGrupo1: TMenuItem;
    MovCam: TAction;
    VencimentosnoPerodo1: TMenuItem;
    Age: TAction;
    ToolButton3: TToolButton;
    AgendaF31: TMenuItem;
    AgendaF32: TMenuItem;
    N3: TMenuItem;
    RecPer: TAction;
    RecebimentosnoPerodo1: TMenuItem;
    ratApl: TAction;
    comPer: TAction;
    relIna: TAction;
    relRNP: TAction;
    AplicaoFinanceira1: TMenuItem;
    ComissodePermanencia1: TMenuItem;
    Inadimplentes1: TMenuItem;
    RecursosnoProcurados1: TMenuItem;
    relFin: TAction;
    MovimentoFinanceiro1: TMenuItem;



      procedure admconExecute(Sender: TObject);
      procedure AEException(Sender: TObject; E: Exception);
      procedure agentesExecute(Sender: TObject);
      procedure cancperExecute(Sender: TObject);
      procedure Ccdevexecute(Sender: Tobject);
      procedure comissaoExecute(Sender: TObject);
      procedure Comperexecute(Sender: Tobject);
      procedure Cotacaoexecute(Sender: Tobject);
      procedure equipesExecute(Sender: TObject);
      procedure faixasExecute(Sender: TObject);
      procedure filiaisExecute(Sender: TObject);
      procedure Formpaint(Sender: Tobject);
      procedure Gruposexecute(Sender: Tobject);
      procedure IdlTmrTimer(Sender: TObject);
        procedure Mmdrawitem(Sender: Tobject; Acanvas: Tcanvas; Arect: Trect; Astate: Townerdrawstate);
      procedure Mmmeasureitem(Sender: Tobject; Acanvas: Tcanvas;
        var Awidth, Aheight: Integer);
      procedure movperExecute(Sender: TObject);
      procedure pagrnpExecute(Sender: TObject);
      procedure parcpendExecute(Sender: TObject);
      procedure Pntitulodblclick(Sender: Tobject);
      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
      procedure prodvenExecute(Sender: TObject);
      procedure ratrecExecute(Sender: TObject);
      procedure recautExecute(Sender: TObject);
      procedure recmanualExecute(Sender: TObject);
      procedure Recrnpexecute(Sender: Tobject);
      procedure regrasExecute(Sender: TObject);
      procedure relcomExecute(Sender: TObject);
    procedure relFinExecute(Sender: TObject);
    procedure RecPerExecute(Sender: TObject);
    procedure Relinaexecute(Sender: Tobject);
    procedure Relrnpexecute(Sender: Tobject);
    procedure Relsagexecute(Sender: Tobject);
    procedure resvenExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AEHint(Sender: TObject);
    procedure ApoBakExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure ApoSenExecute(Sender: TObject);
    procedure TabUsuExecute(Sender: TObject);
    procedure ImpGruExecute(Sender: TObject);
    procedure CliExecute(Sender: TObject);
    procedure ApoPrsExecute(Sender: TObject);
    procedure CotasdoGrupo1Click(Sender: TObject);
    procedure venagenteExecute(Sender: TObject);

    procedure VencimentosnoPerodo1Click(Sender: TObject);
    procedure RecebimentonoPerodo1Click(Sender: TObject);
    procedure AgeExecute(Sender: TObject);
    procedure MalaDireta1Click(Sender: TObject);
    procedure vendasExecute(Sender: TObject);
  private
    { Private declarations }
    FUsuario: iControllerUsuarioLogado;
    FEmpresa: iControllerEmpresa;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation


uses cobcons.model.dm, cobcons.model.configura, cobcons.view.alterarsenha,
  cobcons.view.usuario, cobcons.view.empresa, cobcons.view.pesquisacota,
  cobcons.view.agenda, cobcons.view.inadimplentes, cobcons.view.rnp,
  cobcons.view.comissaopermanencia, cobcons.view.cotacaomoeda,
  cobcons.view.recomposicaosaldosrnp, cobcons.view.grupos,
  cobcons.view.ccdevgrupo, cobcons.view.sag, cobcons.view.rateiopagamentos,
  cobcons.view.movtoperiodo, cobcons.view.admcon, cobcons.view.faixascomissao,
  cobcons.view.regrascomissao, cobcons.view.filiais, cobcons.view.equipes,
  cobcons.view.agentes, cobcons.view.vendas,
  cobcons.view.recebimentomanualparcelas,
  cobcons.view.recebimentoautomaticoparcelas, cobcons.view.calcularcomissao,
  cobcons.view.parcelaspendentes, cobcons.view.comissaoperiodo,
  cobcons.view.producaovendas, cobcons.view.cancelamentosperiodo,
  cobcons.view.vendasagente, cobcons.view.resumovendas,
  {UnSRGru, UnSVen, UnSRec,  UnMld,  UnSFin,}
  cobcons.controller.util, cobcons.controller.factory;

{$R *.lfm}

procedure Tfrmprincipal.Sairexecute(Sender: Tobject);
begin
     Close;
end;

procedure Tfrmprincipal.Formclose(Sender: Tobject; var Action: Tcloseaction);
begin
  if not ConfirmaMensagem('Deseja encerrar o programa?')
  then Action := caNone;
end;

procedure Tfrmprincipal.Aehint(Sender: Tobject);
begin
  pnRodape.Caption := Application.Hint;
end;

procedure Tfrmprincipal.Apobakexecute(Sender: Tobject);
begin
  if DM.AbreFig.Execute then begin
    TControllerFactory.New.Usuario
       .CODIGO(FUsuario.CODIGO)
       .IMAGEM(DM.AbreFig.FileName)
       .GravarImagem;
    BG.Picture.LoadFromFile(DM.AbreFig.FileName);
  end;
end;

procedure Tfrmprincipal.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
     case Key of
       VK_F2: Cli.Execute;
       VK_F3: Age.Execute;
//       VK_F3: if btnAlterar.Enabled then btnAlterar.Click;
//       VK_F4: if btnExcluir.Enabled then btnExcluir.Click;
//       VK_F5: if btnGravar.Enabled then btnGravar.Click;
//       VK_F6: if btnCancelar.Enabled then btnCancelar.Click;
//       VK_F9: if btnPesq.Enabled then btnPesq.Click;
       VK_RETURN:  SelectNext(ActiveControl,True,True);
       VK_ESCAPE: Sair.Execute;
     end;
end;

procedure Tfrmprincipal.Formcreate(Sender: Tobject);
var
   vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnRodape.Color := vEsquema.CorPainelRodape;
  Self.Color := vEsquema.CorFormulario;
  tb.Color := vEsquema.CorPainelAcoes;
  FUsuario := TControllerFactory.New.UsuarioLogado;
  FEmpresa := TControllerFactory.New.Empresa.RecuperarEmpresa;
  Caption := FEmpresa.FANTASIA;
  lblEmpresa.Caption := FEmpresa.FANTASIA;
  lblUsuario.Caption := FUsuario.USUARIO;
  lblDataHora.Caption := RetornarDataExtenso(Date);
  TabUsu.Enabled := (FUsuario.IDADM = 1);
  ImpGru.Enabled := TabUsu.Enabled;
  ApoPrs.Enabled := TabUsu.Enabled;
  if FileExists(FUsuario.IMAGEM)
  then BG.Picture.LoadFromFile(FUsuario.IMAGEM)
  else bg.Picture.Jpeg.LoadFromResourceName(HINSTANCE,'ONIXPLUS');
end;

procedure Tfrmprincipal.Aposenexecute(Sender: Tobject);
begin
  CriaForm(TfrmAltSenha,frmAltSenha);
end;

procedure Tfrmprincipal.Tabusuexecute(Sender: Tobject);
begin
  CriaForm(TfrmUsu,frmUsu);
end;

procedure Tfrmprincipal.Impgruexecute(Sender: Tobject);
begin
//     DM.CriaForm(TfrmImpGru,frmImpGru);
end;

procedure Tfrmprincipal.Cliexecute(Sender: Tobject);
begin
  CriaForm(TfrmPesq,frmPesq);
end;

procedure Tfrmprincipal.Apoprsexecute(Sender: Tobject);
begin
  IdlTmr.AutoEnabled := False;
  IdlTmr.Enabled := False;
  CriaForm(TFrmEmpresa,FrmEmpresa);
  IdlTmr.AutoEnabled := True;
  IdlTmr.Enabled := True;
end;

procedure Tfrmprincipal.Cotasdogrupo1click(Sender: Tobject);
begin
  //CriaForm(TfrmSRGru,frmSRGru);
end;

procedure TfrmPrincipal.venagenteExecute(Sender: TObject);
begin
  CriaForm(TFrmVendasAgente, FrmVendasAgente);
end;

procedure Tfrmprincipal.Vencimentosnoperodo1click(Sender: Tobject);
begin
  //CriaForm(TfrmSVen,frmSVen);
end;

procedure Tfrmprincipal.Recebimentonoperodo1click(Sender: Tobject);
begin
  //CriaForm(TfrmSRec,frmSRec);
end;

procedure Tfrmprincipal.Recperexecute(Sender: Tobject);
begin
  //CriaForm(TfrmSRec,frmSRec);
end;

procedure Tfrmprincipal.Relinaexecute(Sender: Tobject);
begin
  FrmInadimplentes := TFrmInadimplentes.Create(nil);
  try
    FrmInadimplentes.ShowModal;
  finally
    FrmInadimplentes.Free;
  end;
End;

procedure Tfrmprincipal.Relrnpexecute(Sender: Tobject);
begin
  FrmRnp := TFrmRnp.Create(nil);
  try
    FrmRnp.ShowModal;
  finally
    FrmRnp.Free;
  end;
End;

procedure Tfrmprincipal.Relsagexecute(Sender: Tobject);
begin
  FrmSag := TFrmSag.Create(nil);
  try
    FrmSag.ShowModal;
  finally
    FrmSag.Free;
  end;
End;

procedure TfrmPrincipal.resvenExecute(Sender: TObject);
begin
  CriaForm(TFrmResumoVendas, FrmResumoVendas);
end;

procedure Tfrmprincipal.Relfinexecute(Sender: Tobject);
begin
  //CriaForm(TfrmSFin, frmSFin);
end;

procedure Tfrmprincipal.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure TfrmPrincipal.prodvenExecute(Sender: TObject);
begin
  CriaForm(TFrmProducaoVendas, FrmProducaoVendas);
end;

procedure TfrmPrincipal.ratrecExecute(Sender: TObject);
begin
  CriaForm(TFrmRateioPagamentos, FrmRateioPagamentos);
end;

procedure TfrmPrincipal.recautExecute(Sender: TObject);
begin
  CriaForm(TFrmRecAutomatico, FrmRecAutomatico);
end;

procedure TfrmPrincipal.recmanualExecute(Sender: TObject);
begin
  CriaForm(TFrmRecebimentoManual, FrmRecebimentoManual);
end;

procedure Tfrmprincipal.Recrnpexecute(Sender: Tobject);
begin
  CriaForm(TFrmRecomposicaoSaldos, FrmRecomposicaoSaldos);
End;

procedure TfrmPrincipal.regrasExecute(Sender: TObject);
begin
  CriaForm(TFrmRegrasComissao, FrmRegrasComissao);
end;

procedure TfrmPrincipal.relcomExecute(Sender: TObject);
begin
  CriaForm(TFrmComissaoPeriodo, FrmComissaoPeriodo);
end;

procedure Tfrmprincipal.Pntitulodblclick(Sender: Tobject);
begin
  Application.Minimize;
End;

procedure Tfrmprincipal.Comperexecute(Sender: Tobject);
begin
  CriaForm(TFrmComissaoPermanencia, FrmComissaoPermanencia);
End;

procedure Tfrmprincipal.Ccdevexecute(Sender: Tobject);
begin
  CriaForm(TFrmCcDevGrupo, FrmCcDevGrupo);
End;

procedure TfrmPrincipal.comissaoExecute(Sender: TObject);
begin
  CriaForm(TFrmCalcularComissao, FrmCalcularComissao);
end;

procedure TfrmPrincipal.AEException(Sender: TObject; E: Exception);
var
    NomeDoLog, nomeComputador: string;
    Arquivo: TextFile;
begin
// if (E is EDatabaseError) then begin
    NomeDoLog := 'ConsorcioInativo.err';
    AssignFile(Arquivo, NomeDoLog);
    nomeComputador := 'Teste';

    if FileExists(NomeDoLog) { *Converted from FileExists* }
    then Append(arquivo) { se existir, apenas adiciona linhas }
    else ReWrite(arquivo); { cria um novo se não existir }

    try
      WriteLn(arquivo, Format('%s: Usuario: %s Computador: %s ',[DateTimeToStr(Now), TControllerFactory.New.UsuarioLogado.USUARIO, nomeComputador]));
      WriteLn(arquivo, 'Erro:' + E.Message);
      WriteLn(arquivo,'----------------------------------------------------------------------');
    finally
      CloseFile(arquivo)
    end;
// end;
 Application.ShowException(E);
end;

procedure TfrmPrincipal.agentesExecute(Sender: TObject);
begin
  CriaForm(TFrmAgentes, FrmAgentes);
end;

procedure TfrmPrincipal.cancperExecute(Sender: TObject);
begin
  CriaForm(TFrmCancelamentosPeriodo, FrmCancelamentosPeriodo);
end;

procedure TfrmPrincipal.admconExecute(Sender: TObject);
begin
  CriaForm(TFrmAdmCon, FrmAdmCon);
end;

procedure Tfrmprincipal.Cotacaoexecute(Sender: Tobject);
begin
  CriaForm(TFrmCotacaoMoeda, FrmCotacaoMoeda);
End;

procedure TfrmPrincipal.equipesExecute(Sender: TObject);
begin
  CriaForm(TFrmEquipes, FrmEquipes);
end;

procedure TfrmPrincipal.faixasExecute(Sender: TObject);
begin
  CriaForm(TFrmFaixasComissao, FrmFaixasComissao);
end;

procedure TfrmPrincipal.filiaisExecute(Sender: TObject);
begin
  CriaForm(TFrmFiliais, FrmFiliais);
end;

procedure Tfrmprincipal.Formpaint(Sender: Tobject);
begin
  GetCoordenadas(frmPrincipal);
End;

procedure Tfrmprincipal.Gruposexecute(Sender: Tobject);
begin
  CriaForm(TFrmGrupos, FrmGrupos);
End;

procedure TfrmPrincipal.IdlTmrTimer(Sender: TObject);
begin
  IdlTmr.Enabled := False;
  //Application.Terminate;
end;

procedure Tfrmprincipal.Mmdrawitem(Sender: Tobject; Acanvas: Tcanvas; Arect: Trect; Astate: Townerdrawstate);
var
  vCaption: String;
begin

  vCaption := StripHotkey((Sender as TMenuItem).Caption);
  if (odSelected in Astate)
  then Acanvas.Brush.Color := tb.Color
  else Acanvas.Brush.Color := Color;
  Acanvas.Pen.Color := Acanvas.Brush.Color;
  Acanvas.Font.Name := Self.Font.Name;
  Acanvas.Font.Color := Self.Font.Color;
  Acanvas.Font.Size := Self.Font.Size;
  Acanvas.FillRect(Arect);
  DM.IL18.Draw(Acanvas,Arect.Left+2, Arect.Top+2, (Sender as TMenuItem).ImageIndex);
  if vCaption = '-'
  then begin
    Acanvas.Pen.Color := clWhite;
    Acanvas.Line(Arect.Left, Arect.Top+2, Arect.Right, Arect.Top+2)
  end
  else Acanvas.TextOut(Arect.Left+25, Arect.Top, vCaption);
End;

procedure Tfrmprincipal.Mmmeasureitem(Sender: Tobject; Acanvas: Tcanvas;
  var Awidth, Aheight: Integer);
begin
  AWidth  := ACanvas.TextWidth((Sender as TMenuItem).Caption ) + 75;
  if (Sender as TMenuItem).Caption = '-'
  then Aheight := 5
  else AHeight := 25;
End;

procedure TfrmPrincipal.movperExecute(Sender: TObject);
begin
  CriaForm(TFrmMovtoPeriodo, FrmMovtoPeriodo);
end;

procedure TfrmPrincipal.pagrnpExecute(Sender: TObject);
begin
  CriaForm(TFrmPagamentoRnp, FrmPagamentoRnp);
end;

procedure TfrmPrincipal.parcpendExecute(Sender: TObject);
begin
  CriaForm(TFrmParcelasPendentes, FrmParcelasPendentes);
end;

procedure Tfrmprincipal.Ageexecute(Sender: Tobject);
begin
  CriaForm(TfrmAge,frmAge);
end;

procedure Tfrmprincipal.Maladireta1click(Sender: Tobject);
begin
  //CriaForm(TfrmMld,frmMld);
end;

procedure TfrmPrincipal.vendasExecute(Sender: TObject);
begin
  CriaForm(TFrmVendas, FrmVendas);
end;


end.
