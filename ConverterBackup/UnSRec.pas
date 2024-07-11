unit UnSRec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Buttons, ComCtrls, StdCtrls, ExtCtrls, DateUtils;

type
  TfrmSRec = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dtI: TDateTimePicker;
    dtF: TDateTimePicker;
    Panel1: TPanel;
    btnSair: TSpeedButton;
    btnVer: TSpeedButton;
    AL: TActionList;
    VerImp: TAction;
    Sair: TAction;
    procedure dtIExit(Sender: TObject);
    procedure VerImpExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSRec: TfrmSRec;

implementation

uses UnDm;

{$R *.dfm}

procedure TfrmSRec.SairExecute(Sender: TObject);
begin
     Close;
end;

procedure TfrmSRec.VerImpExecute(Sender: TObject);
begin
  if DM.PosicionarRelMov(dtI.Date, dtF.Date)
  then DM.ImprimirRelatorio('MOVIMENTOS ENTRE '+DateToStr(dtI.Date)+' E '+
        DateToStr(dtF.Date),'rpRelMov')
  else ShowMessage('Movimentos não encontrados no período!');
end;

procedure TfrmSRec.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F2: if btnVer.Enabled then btnVer.Click;
       VK_RETURN: Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE: btnSair.Click;
     end;
end;

procedure TfrmSRec.dtIExit(Sender: TObject);
begin
  dtF.Date := EndOfTheMonth(dtI.Date);
end;

procedure TfrmSRec.FormCreate(Sender: TObject);
begin
     dtI.Date := StartOfTheMonth(Date);
     dtF.Date := EndOfTheMonth(Date);
end;

end.
