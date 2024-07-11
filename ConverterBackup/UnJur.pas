unit UnJur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dbcgrids, DB, StdCtrls, Mask, DBCtrls, ExtCtrls;

type
  TfrmJur = class(TForm)
    dsJur: TDataSource;
    DBCtrlGrid1: TDBCtrlGrid;
    Panel1: TPanel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    Label1: TLabel;
    Panel2: TPanel;
    DBEdit5: TDBEdit;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    Label3: TLabel;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmJur: TfrmJur;

implementation

uses UnDm;

{$R *.dfm}

procedure TfrmJur.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if Key = VK_ESCAPE then frmJur.Close;
end;

end.
