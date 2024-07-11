unit cobcons.view.login;

//{$define debug}

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Windows,  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ActnList, crt,
  cobcons.controller.interfaces;

type

  { TfrmLogin }

  TfrmLogin = class(TForm)
    itmr: TIdleTimer;
    pnfig: Tpanel;
    sair: Taction;
    logar: Taction;
    autorizar: Taction;
    AL: Tactionlist;
    Image1: TImage;
    pnLogin: TPanel;
    Speedbutton1: Tspeedbutton;
    Speedbutton2: Tspeedbutton;
    txtNome: TLabeledEdit;
    txtSenha: TLabeledEdit;
    lblEmpresa: TLabel;
    lblVer: TLabel;
    Label1: TLabel;
    pnXave: TPanel;
    edChave: TLabeledEdit;
    procedure Autorizarexecute(Sender: Tobject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure itmrTimer(Sender: TObject);
    procedure Logarexecute(Sender: Tobject);
    procedure Sairexecute(Sender: Tobject);
  private
    { Private declarations }
    FUsuario: iControllerUsuarioLogado;
    FEmpresa: iControllerEmpresa;
    FDtLib: TDateTime;
    FDiasUtilizar: Integer;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  cobcons.model.dm, cobcons.model.configura, cobcons.controller.util,
  cobcons.controller.factory;

{$R *.lfm}

procedure TfrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if  Key = VK_RETURN
  then begin
    if edChave.Focused
    then autorizar.Execute
    else if txtSenha.Focused
    then logar.Execute
    else SelectNext(ActiveControl,True,True);
  end;
end;

procedure Tfrmlogin.Autorizarexecute(Sender: Tobject);
var
  chaveOk: Boolean;
begin
  chaveOk := (Length(edChave.Text) = 10);
  if chaveOk then begin
    FDtLib := dtLiberado(edChave.Text,FEmpresa.FANTASIA);
    FDiasUtilizar := Round(FDtLib-Date);
    chaveOk := (FDiasUtilizar>=0);
  end;
  if chaveOk then begin
    FEmpresa.GravarAutorizacao(edChave.Text);
    lblVer.Caption := Format('Vrs. 1.0 - Liberado até %s (%d dias)',
        [FormatDateTime('dd/mmm/yyyy',FDtLib),FDiasUtilizar]);
    pnXave.Enabled := False;
    pnXave.Visible := False;
    pnLogin.Enabled := True;
    pnLogin.Visible := True;
    txtNome.SetFocus;
  end
  else begin
    MostraErro('Chave Inválida!');
    edChave.Clear;
    edChave.SetFocus;
  end;

End;

procedure TfrmLogin.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  FEmpresa := TControllerFactory.New.Empresa.RecuperarEmpresa;
  FUsuario := TControllerFactory.New.UsuarioLogado;
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnLogin.Color := vEsquema.CorPainelAcoes;
  txtNome.EditLabel.Color := vEsquema.CorPainelAcoes;
  txtSenha.EditLabel.Color := vEsquema.CorPainelAcoes;
  lblEmpresa.Caption := fEmpresa.FANTASIA;
{$ifndef debug}
  if (FEmpresa.STRLIB ='')
  then begin
     FDiasUtilizar := 0;
     FDtLib := date - 1;
  end
  else begin
      //FDtLib := dtLiberado(FEmpresa.STRLIB, FEmpresa.FANTASIA);
      //FDiasUtilizar := Round(FDtLib-Date);
      FDtLib := Date+1;
      FDiasUtilizar := Round(FDtLib-Date);
  end;
  lblVer.Caption := Format('Vrs. 1.0 - Liberado até %s (%d dias)',
        [FormatDateTime('dd/mmm/yyyy',FDtLib),FDiasUtilizar]);
{$else}
  lblVer.Caption := 'Versão de Testes - Não para uso normal';
{$endif}
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  pnLogin.Enabled := False;
  pnLogin.Visible := False;
  pnXave.Visible := False;
  pnXave.Enabled := False;
{$ifndef debug}
  if FDiasUtilizar<=0 then begin
    pnXave.Visible := True;
    pnXave.Enabled := True;
    edChave.SetFocus;
    MostraAviso('Programa Bloqueado! Informe a chave para acesso!');
  end
  else begin
    pnLogin.Enabled := True;
    pnLogin.Visible := True;
    txtNome.SetFocus;
  end;
{$else}
  logar.Execute;
{$endif}
end;

procedure TfrmLogin.itmrTimer(Sender: TObject);
begin
  sair.Execute;
end;

procedure Tfrmlogin.Logarexecute(Sender: Tobject);
begin
{$ifndef debug}
  if FUsuario.ValidarUsuario(txtNome.Text, txtSenha.Text)
{$else}
  delay(3000);
  if  FUsuario.ValidarUsuario('MORUMBI','SECRETA')
{$endif}
  then ModalResult := mrOK
  else begin
    MostraErro('Usuário ou Senha Inválidos!');
    txtNome.Clear;
    txtSenha.Clear;
    txtNome.SetFocus;
  end;
End;

procedure Tfrmlogin.Sairexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
End;

end.
