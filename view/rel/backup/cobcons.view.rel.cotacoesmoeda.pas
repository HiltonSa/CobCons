unit cobcons.view.rel.cotacoesmoeda;

{$mode delphi}

interface

uses
  Classes, Sysutils, DB, Forms, Controls, Graphics, Dialogs, RLReport;

type

  { TFrmRelCotacoesMoeda }

  TFrmRelCotacoesMoeda = class(Tform)
    Ds: Tdatasource;
    Dsprs: Tdatasource;
    lblVariacaoDiaria: TRLLabel;
    lblConsideracoes: TRLLabel;
    Rl: Trlreport;
    BndSum2: TRLBand;
    BndRod: TRLBand;
    CabDet: TRLBand;
    bndDet: TRLBand;
    BndSum1: TRLBand;
    CabRel: TRLBand;
    CabMoeda: TRLBand;
    Rldbresult2: Trldbresult;
    Rldbtext11: Trldbtext;
    Rldbtext3: Trldbtext;
    Rldbtext7: Trldbtext;
    lblVariacaoPeriodo: TRLLabel;
    Rllabel11: Trllabel;
    Rllabel4: Trllabel;
    Rlsysteminfo1: Trlsysteminfo;
    Rlsysteminfo3: Trlsysteminfo;
    Rlsysteminfo4: Trlsysteminfo;
    Rlsysteminfo5: Trlsysteminfo;
    Rlsysteminfo6: Trlsysteminfo;
  Private

  Public

  end;

var
  FrmRelCotacoesMoeda: TFrmRelCotacoesMoeda;

implementation

{$R *.lfm}

end.

