unit UnRelRec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, DBClient, SimpleDS;

type
  TfrmRelRec = class(TForm)
    sdsRec: TSimpleDataSet;
    sdsRecGRUPO: TStringField;
    sdsRecSEQ: TStringField;
    sdsRecCOTA: TStringField;
    sdsRecNOME: TStringField;
    sdsRecPARCELA: TFMTBCDField;
    sdsRecPC_BEM: TBCDField;
    sdsRecVENCTO: TSQLTimeStampField;
    sdsRecVALOR: TBCDField;
    sdsRecVL_ADI: TBCDField;
    QR: TQuickRep;
    PageHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel2: TQRLabel;
    QRSysData3: TQRSysData;
    PageFooterBand1: TQRBand;
    SummaryBand1: TQRBand;
    QRSysData4: TQRSysData;
    lblGMul: TQRLabel;
    lblGAdi: TQRLabel;
    lblGVAl: TQRLabel;
    QRGroup1: TQRGroup;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    DetailBand1: TQRBand;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRBand1: TQRBand;
    lblListadas: TQRLabel;
    lblVal: TQRLabel;
    lblAdi: TQRLabel;
    lblMul: TQRLabel;
    sdsRecVALPG: TBCDField;
    sdsRecMULTA: TBCDField;
    QRDBText7: TQRDBText;
    QRLabel9: TQRLabel;
    lblPag: TQRLabel;
    lblGPag: TQRLabel;
    sdsRecPAG: TStringField;
    procedure QRBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Par : Integer;
    Val, Adi, GVal, GAdi, Mul, Pag, GMul, GPag : Double;
  end;

var
  frmRelRec: TfrmRelRec;

implementation

uses UnDm;

{$R *.dfm}

procedure TfrmRelRec.QRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
     GVal := 0;
     GAdi := 0;
     GMul := 0;
     GPag := 0;
end;

procedure TfrmRelRec.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     Par := 0;
     Val := 0;
     Adi := 0;
     Pag := 0;
     Mul := 0;
end;

procedure TfrmRelRec.DetailBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
     Par := Par + 1;
     Val := Val + sdsRecVALOR.AsFloat;
     Adi := Adi + sdsRecVL_ADI.AsFloat;
     Mul := Mul + sdsRecMULTA.AsFloat;
     Pag := Pag + sdsRecVALPG.AsFloat;
end;

procedure TfrmRelRec.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     lblListadas.Caption := Format('PARCELAS: %.4d',[Par]);
     lblVal.Caption := Format('%8.2n',[Val]);
     lblAdi.Caption := Format('%8.2n',[Adi]);
     lblMul.Caption := Format('%8.2n',[Mul]);
     lblPag.Caption := Format('%8.2n',[Pag]);
     GVal := GVal + Val;
     GAdi := GAdi + Adi;
     GMul := GMul + Mul;
     GPag := GPag + Pag;
end;

procedure TfrmRelRec.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     lblGVAl.Caption := Format('%8.2n',[GVal]);
     lblGAdi.Caption := Format('%8.2n',[GAdi]);
     lblGMul.Caption := Format('%8.2n',[GMul]);
     lblGPag.Caption := Format('%8.2n',[GPag]);
end;

end.
