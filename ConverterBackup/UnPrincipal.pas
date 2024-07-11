unit UnPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Menus, ImgList, ActnList, AppEvnts, jpeg,
  ExtCtrls, JvComponentBase, JvBaseDlg, JvJVCLAboutForm, JvFormTransparent,
  JvGradientCaption;

type
  TfrmPrincipal = class(TForm)
    stBar: TStatusBar;
    BG: TImage;
    AE: TApplicationEvents;
    PM: TPopupMenu;
    PanodeFundo2: TMenuItem;
    rocarSenha2: TMenuItem;
    N4: TMenuItem;
    Sair2: TMenuItem;
    AL: TActionList;
    Sair: TAction;
    TabUsu: TAction;
    ApoBak: TAction;
    ApoSen: TAction;
    ApoPrs: TAction;
    IL: TImageList;
    MM: TMainMenu;
    abelas1: TMenuItem;
    Usurios1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    Movimentao1: TMenuItem;
    Relatrios1: TMenuItem;
    Apoio1: TMenuItem;
    PanodeFundo1: TMenuItem;
    rocarSenha1: TMenuItem;
    NovoLogin2: TMenuItem;
    N5: TMenuItem;
    Personalizao1: TMenuItem;
    TB: TToolBar;
    ToolButton4: TToolButton;
    ToolButton1: TToolButton;
    ApoLog: TAction;
    rocarUsurio1: TMenuItem;
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
    procedure relFinExecute(Sender: TObject);
    procedure RecPerExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AEHint(Sender: TObject);
    procedure ApoBakExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure ApoLogExecute(Sender: TObject);
    procedure ApoSenExecute(Sender: TObject);
    procedure TabUsuExecute(Sender: TObject);
    procedure ImpGruExecute(Sender: TObject);
    procedure CliExecute(Sender: TObject);
    procedure ApoPrsExecute(Sender: TObject);
    procedure CotasdoGrupo1Click(Sender: TObject);
    procedure VencimentosnoPerodo1Click(Sender: TObject);
    procedure RecebimentonoPerodo1Click(Sender: TObject);
    procedure AgeExecute(Sender: TObject);
    procedure MalaDireta1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses UnDm, UnLogin, UnAltSenha, UnUsu,  UnCli, UnPrs, UnSRGru, 
  UnSVen, UnSRec, UnAge, UnMld, UnSFin;

{$R *.dfm}

procedure TfrmPrincipal.SairExecute(Sender: TObject);
begin
     Close;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     if Application.MessageBox('Deseja encerrar o programa?','Atenção',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Action := caNone;
     DM.cdsPRS.Active := False;
     DM.Con.Connected := False;
end;

procedure TfrmPrincipal.AEHint(Sender: TObject);
begin
     stBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmPrincipal.ApoBakExecute(Sender: TObject);
begin
  if DM.AbreFig.Execute then begin
    DM.UsuFig := DM.AbreFig.FileName;
    BG.Picture.LoadFromFile(DM.UsuFig);
    with DM.cdsUsu do begin
      Close;
      Params[0].Value := DM.UsuNom;
      Open;
      Edit;
      DM.cdsUsuDC_FIG.Value := DM.UsuFig;
      Post;
      ApplyUpdates(0);
      Close;
    end;
  end;
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F2: Cli.Execute;
       VK_F3: Age.Execute;
//       VK_F3: if btnAlterar.Enabled then btnAlterar.Click;
//       VK_F4: if btnExcluir.Enabled then btnExcluir.Click;
//       VK_F5: if btnGravar.Enabled then btnGravar.Click;
//       VK_F6: if btnCancelar.Enabled then btnCancelar.Click;
//       VK_F9: if btnPesq.Enabled then btnPesq.Click;
       VK_RETURN:  Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE: Sair.Execute;
     end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
const
   DiaSemana : array[1..7] of string = ('Domingo','Segunda-feira','Terça-feira',
                'Quarta-feira','Quinta-feira','Sexta-feira','Sábado');
   MesExt : array[1..12] of string = ('Janeiro','Fevereiro','Março','Abril',
     'Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro');
var
   dia,mes,ano : Word;
begin

     ApoLog.Execute;

     DecodeDate(Date,ano,mes,dia);

     stBar.Panels[2].Text := DiaSemana[DayofWeek(Date)]+', '+IntToStr(dia)+
                          ' de '+MesExt[mes]+' de '+IntToStr(ano);
     TabUsu.Enabled := (DM.UsuAdm = 1);
     ImpGru.Enabled := (DM.UsuAdm = 1);
     ApoPrs.Enabled := (DM.UsuAdm = 1);
     Caption := DM.cdsPRSNM_PRS.Value;
end;

procedure TfrmPrincipal.ApoLogExecute(Sender: TObject);
begin
     DM.CriaForm(TfrmLogin,frmLogin);

     if FileExists(DM.UsuFig)
     then BG.Picture.LoadFromFile(DM.UsuFig);
     stBar.Panels[1].Text := DM.UsuNom;
end;

procedure TfrmPrincipal.ApoSenExecute(Sender: TObject);
begin
     DM.CriaForm(TfrmAltSenha,frmAltSenha);
end;

procedure TfrmPrincipal.TabUsuExecute(Sender: TObject);
begin
     DM.CriaForm(TfrmUsu,frmUsu);
end;

procedure TfrmPrincipal.ImpGruExecute(Sender: TObject);
begin
//     DM.CriaForm(TfrmImpGru,frmImpGru);
end;

procedure TfrmPrincipal.CliExecute(Sender: TObject);
begin
     DM.CriaForm(TfrmCli,frmCli);
end;

procedure TfrmPrincipal.ApoPrsExecute(Sender: TObject);
begin
     DM.CriaForm(TfrmPrs,frmPrs);
end;

procedure TfrmPrincipal.CotasdoGrupo1Click(Sender: TObject);
begin
     DM.CriaForm(TfrmSRGru,frmSRGru);
end;

procedure TfrmPrincipal.VencimentosnoPerodo1Click(Sender: TObject);
begin
     DM.CriaForm(TfrmSVen,frmSVen);
end;

procedure TfrmPrincipal.RecebimentonoPerodo1Click(Sender: TObject);
begin
     DM.CriaForm(TfrmSRec,frmSRec);
end;

procedure TfrmPrincipal.RecPerExecute(Sender: TObject);
begin
  DM.CriaForm(TfrmSRec,frmSRec);
end;

procedure TfrmPrincipal.relFinExecute(Sender: TObject);
begin
  DM.CriaForm(TfrmSFin, frmSFin);
end;

procedure TfrmPrincipal.AgeExecute(Sender: TObject);
begin
     DM.CriaForm(TfrmAge,frmAge);
end;

procedure TfrmPrincipal.MalaDireta1Click(Sender: TObject);
begin
     DM.CriaForm(TfrmMld,frmMld);
end;

end.
