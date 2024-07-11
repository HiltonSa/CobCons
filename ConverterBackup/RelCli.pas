unit RelCli;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, DB;

type
  TfrmRelCli = class(TForm)
    Rp: TRLReport;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    dsPrs: TDataSource;
    RLLabel1: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLDBText2: TRLDBText;
    dsCot: TDataSource;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLLabel4: TRLLabel;
    RLDBText5: TRLDBText;
    RLLabel5: TRLLabel;
    RLDBText6: TRLDBText;
    RLLabel6: TRLLabel;
    RLDBText7: TRLDBText;
    RLLabel7: TRLLabel;
    RLDBText8: TRLDBText;
    RLBand2: TRLBand;
    RLLabel8: TRLLabel;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLLabel9: TRLLabel;
    RLDBText11: TRLDBText;
    RLLabel10: TRLLabel;
    RLDBText12: TRLDBText;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLDBText13: TRLDBText;
    RLLabel13: TRLLabel;
    RLDBText14: TRLDBText;
    RLLabel14: TRLLabel;
    RLDBText15: TRLDBText;
    RLLabel15: TRLLabel;
    RLDBText16: TRLDBText;
    RLDBText17: TRLDBText;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLDBText18: TRLDBText;
    RLLabel18: TRLLabel;
    RLDBText19: TRLDBText;
    RLDBText20: TRLDBText;
    RLLabel19: TRLLabel;
    RLDBText21: TRLDBText;
    RLLabel20: TRLLabel;
    RLDBText22: TRLDBText;
    RLLabel21: TRLLabel;
    RLDBText23: TRLDBText;
    RLLabel22: TRLLabel;
    RLDBText24: TRLDBText;
    RLLabel23: TRLLabel;
    RLDBText25: TRLDBText;
    dsBem: TDataSource;
    dsPre: TDataSource;
    RLDBText26: TRLDBText;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLDBText27: TRLDBText;
    RLLabel26: TRLLabel;
    RLDBText28: TRLDBText;
    RLLabel27: TRLLabel;
    RLDBText29: TRLDBText;
    RLLabel28: TRLLabel;
    RLDBText30: TRLDBText;
    RLDBText31: TRLDBText;
    RLLabel29: TRLLabel;
    RLDBText32: TRLDBText;
    RLLabel30: TRLLabel;
    RLDBText33: TRLDBText;
    dsSeg: TDataSource;
    RLLabel31: TRLLabel;
    RLDBText34: TRLDBText;
    RLDBText35: TRLDBText;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLDBText36: TRLDBText;
    RLDBText37: TRLDBText;
    RLLabel34: TRLLabel;
    RLDBText38: TRLDBText;
    RLLabel35: TRLLabel;
    RLDraw1: TRLDraw;
    Creditos: TRLSubDetail;
    dsCre: TDataSource;
    RLBand3: TRLBand;
    RLBand4: TRLBand;
    RLLabel36: TRLLabel;
    RLDBText39: TRLDBText;
    RLDBText40: TRLDBText;
    RLLabel37: TRLLabel;
    RLDBText41: TRLDBText;
    RLLabel38: TRLLabel;
    RLDBText42: TRLDBText;
    RLLabel39: TRLLabel;
    RLDBText43: TRLDBText;
    RLLabel40: TRLLabel;
    RLDBText44: TRLDBText;
    RLLabel41: TRLLabel;
    RLDBText45: TRLDBText;
    RLLabel45: TRLLabel;
    RLDBText46: TRLDBText;
    RLLabel42: TRLLabel;
    RLDBText47: TRLDBText;
    RLLabel43: TRLLabel;
    RLDBText48: TRLDBText;
    RLLabel44: TRLLabel;
    RLDBText49: TRLDBText;
    RLDBText50: TRLDBText;
    RLLabel46: TRLLabel;
    RLLabel47: TRLLabel;
    RLBand5: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    Pendencia: TRLSubDetail;
    dsCob: TDataSource;
    RLBand6: TRLBand;
    RLBand7: TRLBand;
    RLBand8: TRLBand;
    RLLabel48: TRLLabel;
    RLDBText51: TRLDBText;
    RLLabel49: TRLLabel;
    RLDBText52: TRLDBText;
    RLLabel50: TRLLabel;
    RLDBText53: TRLDBText;
    RLLabel51: TRLLabel;
    RLDBText54: TRLDBText;
    RLLabel52: TRLLabel;
    RLDBText55: TRLDBText;
    RLDBText56: TRLDBText;
    RLDBText57: TRLDBText;
    RLDBText58: TRLDBText;
    RLDBText59: TRLDBText;
    RLLabel53: TRLLabel;
    RLLabel54: TRLLabel;
    RLLabel55: TRLLabel;
    RLLabel56: TRLLabel;
    RLLabel57: TRLLabel;
    RLSystemInfo2: TRLSystemInfo;
    RLDBResult3: TRLDBResult;
    MovFin: TRLSubDetail;
    RLBand9: TRLBand;
    RLBand10: TRLBand;
    RLBand11: TRLBand;
    dsMov: TDataSource;
    RLLabel58: TRLLabel;
    RLDBText64: TRLDBText;
    RLLabel59: TRLLabel;
    RLDBText65: TRLDBText;
    RLLabel60: TRLLabel;
    RLDBText66: TRLDBText;
    RLDBText67: TRLDBText;
    RLDBText68: TRLDBText;
    RLDBText69: TRLDBText;
    RLDBText70: TRLDBText;
    RLDBText71: TRLDBText;
    RLDBText72: TRLDBText;
    RLDBText73: TRLDBText;
    RLDBText74: TRLDBText;
    RLDBText75: TRLDBText;
    RLDBText76: TRLDBText;
    RLDBText77: TRLDBText;
    RLDBText78: TRLDBText;
    RLLabel61: TRLLabel;
    RLSystemInfo3: TRLSystemInfo;
    RLDBResult4: TRLDBResult;
    RLDBResult5: TRLDBResult;
    RLDBResult6: TRLDBResult;
    RLDBResult7: TRLDBResult;
    RLDBResult8: TRLDBResult;
    RLDBResult9: TRLDBResult;
    RLDBResult10: TRLDBResult;
    RLDBResult11: TRLDBResult;
    RLDBResult12: TRLDBResult;
    RLDBResult13: TRLDBResult;
    RLDBResult14: TRLDBResult;
    RLDBResult15: TRLDBResult;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCli: TfrmRelCli;

implementation

uses UnDm;

{$R *.dfm}

end.
