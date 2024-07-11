unit UnLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, jpeg;

type
  TfrmLogin = class(TForm)
    Image1: TImage;
    pnLogin: TPanel;
    txtNome: TLabeledEdit;
    txtSenha: TLabeledEdit;
    btnOk: TBitBtn;
    btnSair: TBitBtn;
    lblEmpresa: TLabel;
    lblVer: TLabel;
    Label1: TLabel;
    pnXave: TPanel;
    edChave: TLabeledEdit;
    btAut: TBitBtn;
    BitBtn2: TBitBtn;
    procedure btAutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnOkClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;
  Ok : Boolean;
  DtLib: TDateTime;
  diasUtilizar: Integer;

implementation

uses UnDM, DB, SqlExpr, SimpleDS, DBClient, UnitCpt;

{$R *.dfm}

procedure TfrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
//       VK_F2: if btnIncluir.Enabled then btnIncluir.Click;
//       VK_F3: if btnAlterar.Enabled then btnAlterar.Click;
//     VK_F4: if btnExcluir.Enabled then btnExcluir.Click;
//       VK_F5: if btnGravar.Enabled then btnGravar.Click;
//       VK_F6: if (btnCancelar.Kind <> bkCancel) and (btnCancelar.Enabled)
//              then btnCancelar.Click;
//       VK_F9: if btnSugere.Visible then btnSugere.Click;
       VK_RETURN:  Perform(WM_NEXTDLGCTL, 0, 0);
     end;
end;

procedure TfrmLogin.btAutClick(Sender: TObject);
var
  chaveOk: Boolean;
begin
  chaveOk := (Length(edChave.Text) = 10);
  if chaveOk then begin
    DtLib := dtLiberado(edChave.Text,DM.cdsPRSNM_PRS.Value);
    diasUtilizar := Round(DtLib-Date);
    chaveOk := (diasUtilizar>=0);
  end;
  if chaveOk then begin
    lblVer.Caption := Format('Vrs. 1.0 - Liberado até %s (%d dias)',
        [FormatDateTime('dd/mmm/yyyy',DtLib),diasUtilizar]);
    DM.GravarAutorizacao(edChave.Text);
    pnXave.Enabled := False;
    pnXave.Visible := False;
    pnLogin.Enabled := True;
    pnLogin.Visible := True;
    txtNome.SetFocus;
  end
  else begin
    Application.MessageBox('Chave Inválida!','Atenção',MB_ICONEXCLAMATION+MB_OK);
    edChave.Clear;
    edChave.SetFocus;
  end;

end;

procedure TfrmLogin.btnOkClick(Sender: TObject);
begin
     if (txtNome.Text='') or (txtSenha.Text = '')
     then Abort;

     Ok := False;
     with DM.cdsUsu do begin
       Close;
       Params[0].Value := txtNome.Text;
       Open;
     end;
     if not (DM.cdsUsu.Eof) then begin
       if Trim(DM.cdsUsuCD_SENHA.Value) = txtSenha.Text then begin
         DM.UsuCod := DM.cdsUsuCD_USU.AsInteger;
         DM.UsuNom := DM.cdsUsuNM_USU.Value;
         DM.UsuFig := DM.cdsUsuDC_FIG.Value;
         DM.UsuAdm := DM.cdsUsuID_ADM.AsInteger;
         Ok := True;
         Close;
       end
       else Application.MessageBox('Senha Inválida!','Atenção',
                   MB_ICONEXCLAMATION+MB_OK);
     end
     else Application.MessageBox('Usuário Inválido!','Atenção',
          MB_ICONEXCLAMATION+MB_OK);
end;

procedure TfrmLogin.btnSairClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     DM.cdsUsu.Close;
//     if DM.cdsPRS.Active
//     then DM.cdsPRS.Close;
     if not Ok then begin
       DM.Con.Close;
       Application.Terminate;
     end;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  lblEmpresa.Caption := DM.cdsPRSNM_PRS.Value;
  if (DM.cdsPRSSTRLIB.Value ='') or (DM.cdsPRSSTRLIB.isnull)
  then begin
     diasUtilizar := 0;
     dtlib := date - 1;
  end
  else begin
    DtLib := dtLiberado(DM.cdsPRSSTRLIB.Value,DM.cdsPRSNM_PRS.Value);
    diasUtilizar := Round(DtLib-Date);
  end;
  lblVer.Caption := Format('Vrs. 1.0 - Liberado até %s (%d dias)',
        [FormatDateTime('dd/mmm/yyyy',DtLib),diasUtilizar]);
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  Ok := False;
  pnLogin.Enabled := False;
  pnLogin.Visible := False;
  pnXave.Visible := False;
  pnXave.Enabled := False;
  if diasUtilizar<=0 then begin
    pnXave.Visible := True;
    pnXave.Enabled := True;
    edChave.SetFocus;
    Application.MessageBox('Programa Bloqueado! Informe a chave para acesso!','Atenção',MB_ICONEXCLAMATION+MB_OK);
  end
  else begin
    pnLogin.Enabled := True;
    pnLogin.Visible := True;
    txtNome.SetFocus;
  end;
end;

end.
