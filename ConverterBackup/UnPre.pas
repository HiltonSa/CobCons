unit UnPre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ExtCtrls, Grids, DBGrids, StdCtrls, Mask, DBCtrls;

type
  TfrmPre = class(TForm)
    Panel1: TPanel;
    dsBem: TDataSource;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Panel2: TPanel;
    dsPre: TDataSource;
    DBGrid1: TDBGrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPre: TfrmPre;

implementation

uses UnDm;

{$R *.dfm}

procedure TfrmPre.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if Key = VK_ESCAPE then frmPre.Close;
end;

end.
