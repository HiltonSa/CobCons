unit cobcons.view.alterarsenha;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, ActnList, DB, ComCtrls, StdCtrls,
  cobcons.controller.interfaces;

type

  { TfrmAltSenha }

  TfrmAltSenha = class(TForm)
    AL: TActionList;
    Grava: TAction;
    Label1: Tlabel;
    pnTitulo: Tpanel;
    Sair: TAction;
    pnAcoes: TPanel;
    btnSair: TSpeedButton;
    btnFechar: TSpeedButton;
    pnBack: TPanel;
    txtSenha: TLabeledEdit;
    txtNova: TLabeledEdit;
    txtConf: TLabeledEdit;
    procedure Formcreate(Sender: Tobject);
    procedure Gravaexecute(Sender: Tobject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
    procedure SairExecute(Sender: TObject);
  private
    { Private declarations }
    FUsuario : iControllerUsuarioLogado;
  public
    { Public declarations }
  end;

var
  frmAltSenha: TfrmAltSenha;

implementation

uses cobcons.controller.util, cobcons.controller.factory,
  cobcons.model.configura;


{$R *.lfm}

procedure Tfrmaltsenha.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  FUsuario := TControllerFactory.New.UsuarioLogado;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  Self.Color := vEsquema.CorFormulario;
  pnBack.Color := vEsquema.CorFundo;
End;

procedure Tfrmaltsenha.Gravaexecute(Sender: Tobject);
begin
  if (txtSenha.Text <> FUsuario.SENHA)
  then MostraAviso('Senha inválida!')
  else begin
    if (txtNova.Text <> '') and (txtConf.Text <> '')
    then begin
       if (txtNova.Text = txtConf.Text)
       then begin
         if ConfirmaMensagem('Confirma alteração da senha?')
         then begin
            TControllerFactory.New.Usuario
                 .CODIGO(FUsuario.CODIGO)
                 .SENHA(txtNova.Text)
                 .GravarSenha;
            close;
         end;
       end
       else MostraAviso('Nova Senha não confere!');
    end;
  end;
  txtSenha.Clear;
  txtNova.Clear;
  txtConf.Clear;
  txtSenha.SetFocus;
End;

procedure TfrmAltSenha.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F2: Grava.Execute;
    VK_RETURN:  SelectNext(ActiveControl,True,True);
    VK_ESCAPE:  Sair.Execute;
  end;
end;

procedure Tfrmaltsenha.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure TfrmAltSenha.SairExecute(Sender: TObject);
begin
  Close;
end;

end.
