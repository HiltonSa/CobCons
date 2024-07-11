unit UnRelGru;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, ExtCtrls, DB, DBClient, SimpleDS, QRCtrls;

type
  TfrmRelGru = class(TForm)
    QR: TQuickRep;
    PageHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel2: TQRLabel;
    QRSysData3: TQRSysData;
    sdsRelGru: TSimpleDataSet;
    sdsRelGruCD_COTA: TFMTBCDField;
    sdsRelGruGRUPO: TStringField;
    sdsRelGruSEQ: TStringField;
    sdsRelGruCOTA: TStringField;
    sdsRelGruNOME: TStringField;
    sdsRelGruBEM: TStringField;
    sdsRelGruPC_PAGO: TBCDField;
    sdsRelGruPC_DEV: TBCDField;
    sdsRelGruPESSOA: TFMTBCDField;
    sdsRelGruCPFCGC: TStringField;
    sdsRelGruFILIAL: TStringField;
    sdsRelGruTXADM: TBCDField;
    sdsRelGruTXRES: TBCDField;
    sdsRelGruTXSEG: TBCDField;
    sdsRelGruDATREF: TSQLTimeStampField;
    sdsRelGruHONOR: TBCDField;
    QRGroup1: TQRGroup;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRBand1: TQRBand;
    QRSysData4: TQRSysData;
    lblListadas: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    procedure QRGroup1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure DetailBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelGru: TfrmRelGru;
  Lis: Integer;

implementation

uses UnDm;

{$R *.dfm}

procedure TfrmRelGru.QRGroup1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
     Lis := 0;
end;

procedure TfrmRelGru.DetailBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
     Lis := Lis + 1;
end;

procedure TfrmRelGru.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     lblListadas.Caption := Format('COTAS DO GRUPO: %.4d',[Lis]);
     Lis := 0;
end;

end.
