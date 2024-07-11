unit cobcons.view.rel.recomposicaosaldosrnpsint;

{$mode delphi}

interface

uses
  Classes, Sysutils, DB, Forms, Controls, Graphics, Dialogs, RLReport;

type

  { TFrmRecSldSint }

  TFrmRecSldSint = class(Tform)
    Bndcabgrupo: Trlband;
    Bndheader: Trlband;
    Bndrodape: Trlband;
    Bndsum: Trlband;
    Bndsumrep: Trlband;
    Ds: Tdatasource;
    Dsprs: Tdatasource;
    Dtgrupo: Trlband;
    Rl: Trlreport;
    Rldbresult1: Trldbresult;
    Rldbresult2: Trldbresult;
    Rldbresult3: Trldbresult;
    Rldbtext1: Trldbtext;
    Rldbtext3: Trldbtext;
    Rldbtext5: Trldbtext;
    Rldbtext6: Trldbtext;
    Rldbtext7: Trldbtext;
    Rllabel2: Trllabel;
    Rllabel5: Trllabel;
    Rllabel6: Trllabel;
    Rllabel9: Trllabel;
    Rlsysteminfo1: Trlsysteminfo;
    Rlsysteminfo2: Trlsysteminfo;
    Rlsysteminfo3: Trlsysteminfo;
    Rlsysteminfo4: Trlsysteminfo;
    Rlsysteminfo5: Trlsysteminfo;
    Rlsysteminfo6: Trlsysteminfo;
  Private

  Public

  end;

var
  FrmRecSldSint: TFrmRecSldSint;

implementation

{$R *.lfm}

end.

