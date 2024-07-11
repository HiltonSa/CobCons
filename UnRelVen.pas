unit UnRelVen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, DB, DBClient, SimpleDS, QRCtrls;

type
  TfrmRelVen = class(TForm)
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
    sdsVen: TSimpleDataSet;
    sdsVenGRUPO: TStringField;
    sdsVenSEQ: TStringField;
    sdsVenCOTA: TStringField;
    sdsVenNOME: TStringField;
    sdsVenPARCELA: TFMTBCDField;
    sdsVenPC_BEM: TBCDField;
    sdsVenVALOR: TBCDField;
    sdsVenVL_ADI: TBCDField;
    sdsVenValTot: TFloatField;
    QRGroup1: TQRGroup;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    DetailBand1: TQRBand;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRBand1: TQRBand;
    lblListadas: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    lblVal: TQRLabel;
    lblAdi: TQRLabel;
    lblTot: TQRLabel;
    lblGTot: TQRLabel;
    lblGAdi: TQRLabel;
    lblGVAl: TQRLabel;
    sdsVenVEN: TStringField;
    procedure sdsVenCalcFields(DataSet: TDataSet);
    procedure QRBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRGroup1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
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
    Val, Adi, GVal, GAdi : Double;
  end;

var
  frmRelVen: TfrmRelVen;

implementation

uses UnDm;

{$R *.dfm}

procedure TfrmRelVen.sdsVenCalcFields(DataSet: TDataSet);
begin
     sdsVenValTot.Value := sdsVenVALOR.AsFloat + sdsVenVL_ADI.AsFloat;
end;

procedure TfrmRelVen.QRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
     GVal := 0;
     GAdi := 0;
end;

procedure TfrmRelVen.QRGroup1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
     Par := 0;
     Val := 0;
     Adi := 0;
end;

procedure TfrmRelVen.DetailBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
     Par := Par + 1;
     Val := Val + sdsVenVALOR.AsFloat;
     Adi := Adi + sdsVenVL_ADI.AsFloat;
end;

procedure TfrmRelVen.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     lblListadas.Caption := Format('PARC DO VENCTO: %.4d',[Par]);
     lblVal.Caption := Format('%8.2n',[Val]);
     lblAdi.Caption := Format('%8.2n',[Adi]);
     lblTot.Caption := Format('%8.2n',[Val+Adi]);
     GVal := GVal + Val;
     GAdi := GAdi + Adi;
end;

procedure TfrmRelVen.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     lblGVAl.Caption := Format('%8.2n',[GVal]);
     lblGAdi.Caption := Format('%8.2n',[GAdi]);
     lblGTot.Caption := Format('%8.2n',[GVal+GAdi]);
end;

end.
