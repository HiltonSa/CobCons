unit UnReu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ExtCtrls, Grids, DBGrids, StdCtrls, Mask, DBCtrls;

type
  TfrmReu = class(TForm)
    Panel1: TPanel;
    dsReu: TDataSource;
    DBGrid1: TDBGrid;
    dsCot: TDataSource;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReu: TfrmReu;

implementation

uses UnDm;

{$R *.dfm}

procedure TfrmReu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if Key = VK_ESCAPE then frmReu.Close;
end;

end.
