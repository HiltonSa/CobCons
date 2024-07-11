unit UnMala;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls;

type
  TfrmMala = class(TForm)
    QR: TQuickRep;
    DetailBand1: TQRBand;
    QRDBRichText1: TQRDBRichText;
    PageHeaderBand1: TQRBand;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMala: TfrmMala;

implementation

uses UnDm;

{$R *.dfm}

{ TfrmMala }


end.
