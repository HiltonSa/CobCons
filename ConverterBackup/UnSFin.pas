unit UnSFin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ComCtrls, StdCtrls, ExtCtrls, ActnList;

type
  TfrmSFin = class(TForm)
    AL: TActionList;
    VerImp: TAction;
    Sair: TAction;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dtI: TDateTimePicker;
    dtF: TDateTimePicker;
    Panel1: TPanel;
    btnSair: TSpeedButton;
    btnVer: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure dtIExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure VerImpExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSFin: TfrmSFin;

implementation

uses UnDm, DateUtils;

{$R *.dfm}

procedure TfrmSFin.dtIExit(Sender: TObject);
begin
  dtF.Date := EndOfTheMonth(dtI.Date);
end;

procedure TfrmSFin.FormCreate(Sender: TObject);
begin
     dtI.Date := StartOfTheMonth(Date);
     dtF.Date := EndOfTheMonth(Date);
end;

procedure TfrmSFin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F2: if btnVer.Enabled then btnVer.Click;
       VK_RETURN: Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE: btnSair.Click;
     end;
end;

procedure TfrmSFin.SairExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmSFin.VerImpExecute(Sender: TObject);
begin
  if DM.PosicionarCdsFin(dtI.Date, dtF.Date)
  then DM.ImprimirRelatorio('MOVIMENTOS ENTRE '+DateToStr(dtI.Date)+' E '+
        DateToStr(dtF.Date),'rpRelFin')
  else ShowMessage('Movimentos não encontrados no período!');
end;

end.
