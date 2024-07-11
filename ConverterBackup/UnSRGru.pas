unit UnSRGru;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, ActnList, StdCtrls;

type
  TfrmSRGru = class(TForm)
    AL: TActionList;
    VerImp: TAction;
    Sair: TAction;
    Panel1: TPanel;
    btnSair: TSpeedButton;
    btnVer: TSpeedButton;
    Panel2: TPanel;
    txtIni: TLabeledEdit;
    txtFim: TLabeledEdit;
    spLisGru: TSpeedButton;
    spLisGruFim: TSpeedButton;
    cbSitIni: TComboBox;
    cbSitFim: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure spLisGruFimClick(Sender: TObject);
    procedure spLisGruClick(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VerImpExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSRGru: TfrmSRGru;

implementation

uses SimpleDS, DB, UnLista, UnDm;

{$R *.dfm}

procedure TfrmSRGru.SairExecute(Sender: TObject);
begin
     Close;
end;

procedure TfrmSRGru.spLisGruClick(Sender: TObject);
begin
  txtIni.Text := DM.SugerirGrupo;
end;

procedure TfrmSRGru.spLisGruFimClick(Sender: TObject);
begin
  txtFim.Text := DM.SugerirGrupo;
end;

procedure TfrmSRGru.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F2: if btnVer.Enabled then btnVer.Click;
       VK_RETURN: Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE: btnSair.Click;
     end;
end;

procedure TfrmSRGru.VerImpExecute(Sender: TObject);
begin
  if DM.PosicionarFaixaGrupos(txtIni.Text,txtFim.Text, Copy(cbSitIni.Text,1,1), Copy(cbSitFim.Text,1,1))
  then DM.ImprimirRelatorio('','rpCotasGru')
  else Application.MessageBox('Faixa de grupos inválida!','Atenção',
        MB_ICONHAND+MB_OK);

end;

end.
