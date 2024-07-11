unit cobcons.view.rel.baixacomissao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, Forms, Controls, Graphics, Dialogs, RLReport;

type

  { TFrmRelBaixaComissao }

  TFrmRelBaixaComissao = class(TForm)
    BndRod: TRLBand;
    BndSum2: TRLBand;
    CabRel: TRLBand;
    ds: TDataSource;
    dsPrs: TDataSource;
    grPar: TRLGroup;
    grCab: TRLBand;
    det: TRLBand;
    grRod: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    RLDBResult4: TRLDBResult;
    RLDBText1: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLSystemInfo4: TRLSystemInfo;
    RLSystemInfo5: TRLSystemInfo;
    RLSystemInfo7: TRLSystemInfo;
    RLSystemInfo8: TRLSystemInfo;
    RLSystemInfo9: TRLSystemInfo;
    tot: TRLBand;
    RP: TRLReport;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmRelBaixaComissao: TFrmRelBaixaComissao;

implementation


{$R *.lfm}

end.

