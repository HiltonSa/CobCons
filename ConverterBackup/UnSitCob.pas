unit UnSitCob;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Buttons, ExtCtrls, StdCtrls, Mask, DBCtrls, DB;

type
  TfrmSitCob = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    al: TActionList;
    gravar: TAction;
    cancela: TAction;
    SpeedButton2: TSpeedButton;
    Panel2: TPanel;
    DS: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit25: TDBEdit;
    Label27: TLabel;
    cboSit: TComboBox;
    Label3: TLabel;
    procedure cancelaExecute(Sender: TObject);
    procedure gravarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSitCob: TfrmSitCob;

implementation

uses UnDm;

{$R *.dfm}

procedure TfrmSitCob.cancelaExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmSitCob.gravarExecute(Sender: TObject);
var
  stSql: string;
begin
  if Application.MessageBox('Confirma a alteração?','Atenção',
     MB_ICONQUESTION+MB_YESNO)=mrYes then begin
    stSql := Format(
     'update accli set sit_cobr=%s, d_atuali=%s where grupo=%s and seq=%s and cota=%s',
       [QuotedStr(Copy(cboSit.Text,1,1)),QuotedStr(FormatDateTime('dd.mm.yyyy',Date)),
        QuotedStr(DM.cdsCotGRUPO.Value), QuotedStr(DM.cdsCotSEQ.Value),
        QuotedStr(DM.cdsCotCOTA.Value)]);
    DM.ExecutarSQL(stSql);
    ModalResult := mrOk;
  end;
end;

end.
