unit cobcons.view.rel.pagarcomissao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, RLReport,
  RLParser;

type

  { TFrmRelPagarComissao }

  TFrmRelPagarComissao = class(TForm)
    BndRod: TRLBand;
    BndSum2: TRLBand;
    CabRel: TRLBand;
    det1: TRLBand;
    ds: TDataSource;
    dsPrs: TDataSource;
    grCab1: TRLBand;
    grCab2: TRLBand;
    grCab3: TRLBand;
    grPar1: TRLGroup;
    grRod1: TRLBand;
    grRod2: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDBResult10: TRLDBResult;
    RLDBResult11: TRLDBResult;
    RLDBResult12: TRLDBResult;
    RLDBResult7: TRLDBResult;
    RLDBResult8: TRLDBResult;
    RLDBResult9: TRLDBResult;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText13: TRLDBText;
    RLDBText14: TRLDBText;
    grVen: TRLGroup;
    RLDBText15: TRLDBText;
    RLDBText16: TRLDBText;
    RLDBText17: TRLDBText;
    RLDBText18: TRLDBText;
    RLDBText19: TRLDBText;
    RLDBText20: TRLDBText;
    RLDBText21: TRLDBText;
    RLDBText22: TRLDBText;
    RLDBText23: TRLDBText;
    exp: TRLExpressionParser;
    RLDBText24: TRLDBText;
    RLDBText7: TRLDBText;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLSystemInfo4: TRLSystemInfo;
    RLSystemInfo5: TRLSystemInfo;
    RLSystemInfo6: TRLSystemInfo;
    RLSystemInfo7: TRLSystemInfo;
    RLSystemInfo8: TRLSystemInfo;
    RP: TRLReport;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmRelPagarComissao: TFrmRelPagarComissao;

implementation


{$R *.lfm}

end.

