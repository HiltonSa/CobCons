unit UnQui;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, DB, Buttons, ExtCtrls, ComCtrls, QuickRpt;

type
  TfrmQui = class(TForm)
    QR: TQuickRep;
    procedure SairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQui: TfrmQui;

implementation

uses UnDm;

{$R *.dfm}

procedure TfrmQui.SairExecute(Sender: TObject);
begin
     Close;
end;

end.
