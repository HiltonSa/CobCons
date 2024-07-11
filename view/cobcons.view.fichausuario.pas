unit cobcons.view.fichausuario;

{$mode delphi}

interface

uses
  Classes, Sysutils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, ActnList, Cobcons.View.Ficha, cobcons.controller.interfaces;

type

  { TFrmFichaUsuario }

  TFrmFichaUsuario = class(Tfrmficha)
    cboEsquema: Tcombobox;
    Label6: Tlabel;
    Speedbutton3: Tspeedbutton;
    VerSenha: Taction;
    cboAdm: Tcombobox;
    cboAtivo: Tcombobox;
    edCodigo: Tedit;
    edNmUsu: Tedit;
    edSenha: Tedit;
    Label1: Tlabel;
    Label2: Tlabel;
    Label3: Tlabel;
    Label4: Tlabel;
    Label5: Tlabel;
    procedure Formcreate(Sender: Tobject);
    procedure Gravarexecute(Sender: Tobject);
    procedure Versenhaexecute(Sender: Tobject);
  Private
    FUsuario: iControllerUsuario;
    Fcodigo: Integer;
    procedure PreencherEdits;
    procedure LimparEdits;
    procedure Setcodigo(Avalue: Integer);
  Public
    property Codigo: Integer read FCodigo write SetCodigo;
  end;

var
  FrmFichaUsuario: TFrmFichaUsuario;

implementation

uses cobcons.controller.util, cobcons.controller.factory;

{$R *.lfm}

{ TFrmFichaUsuario }

procedure Tfrmfichausuario.Gravarexecute(Sender: Tobject);
begin
  if edNmUsu.Text = ''
  then begin
    MostraAviso('Precisa informa USUÁRIO!');
    edNmUsu.SetFocus;
  end else if ConfirmaMensagem('Gravar as Informações?')
  then begin
    FUsuario.CODIGO(StrToInt(edCodigo.Text))
            .USUARIO(edNmUsu.Text)
            .IDADM(cboAdm.ItemIndex)
            .SENHA(edSenha.Text)
            .ATIVO(cboAtivo.ItemIndex)
            .ESQUEMA(cboEsquema.ItemIndex);

    if Fcodigo = 0
    then FUsuario.Novo
    else FUsuario.Alterar;
    ModalResult := mrOK;
  end;
End;

procedure Tfrmfichausuario.Formcreate(Sender: Tobject);
begin
  inherited;
  FUsuario := TControllerFactory.New.Usuario;
end;

procedure Tfrmfichausuario.Versenhaexecute(Sender: Tobject);
begin
  if edSenha.PasswordChar = '*'
  then edSenha.PasswordChar := #0
  else edSenha.PasswordChar := '*';
End;

procedure Tfrmfichausuario.Preencheredits;
begin
  FUsuario.ListarPorCodigo(Fcodigo);
  edCodigo.Text := RetornarFormatado(FUsuario.CODIGO.ToString, tfInt2);
  edNmUsu.Text := FUsuario.USUARIO;
  edSenha.Text := FUsuario.SENHA;
  cboAtivo.ItemIndex := FUsuario.ATIVO;
  cboAdm.ItemIndex := FUsuario.IDADM;
  cboEsquema.ItemIndex := FUsuario.ESQUEMA;
end;

procedure Tfrmfichausuario.Limparedits;
begin
  edCodigo.Clear;
  edNmUsu.Clear;
  cboAdm.ItemIndex := 0;
  cboAtivo.ItemIndex := 1;
  edSenha.Clear;
end;

procedure Tfrmfichausuario.Setcodigo(Avalue: Integer);
begin
  Fcodigo := Avalue;
  if Fcodigo > 0
  then begin
    PreencherEdits;
    pnTitulo.Caption := 'Alterando Usuário';
  end
  else begin
    LimparEdits;
    pnTitulo.Caption := 'Incluir Usuário';
    edCodigo.Text := RetornarFormatado(IntToStr(FUsuario.ProximoCodigo), tfInt2);
  end;
end;

end.

