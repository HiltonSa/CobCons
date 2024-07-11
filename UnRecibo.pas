unit UnRecibo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, jpeg;

type
  TfrmRecibo = class(TForm)
    QR: TQuickRep;
    PageHeaderBand1: TQRBand;
    QRImage1: TQRImage;
    lblTit: TQRLabel;
    DetailBand1: TQRBand;
    QRLabel7: TQRLabel;
    lblLocData: TQRLabel;
    lblTexto: TQRLabel;
    PageFooterBand1: TQRBand;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRecibo: TfrmRecibo;

implementation

uses UnDm;

{$R *.dfm}

end.
