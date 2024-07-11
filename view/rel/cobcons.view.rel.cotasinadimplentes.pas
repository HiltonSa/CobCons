unit cobcons.view.rel.cotasinadimplentes;

{$mode delphi}

interface

uses
  Classes, Sysutils, DB, Forms, Controls, Graphics, Dialogs, RLReport;

type

  { TFrmRelCotasInadimplentes }

  TFrmRelCotasInadimplentes = class(Tform)
    dsttgru: Tdatasource;
    Ds: Tdatasource;
    Dsprs: Tdatasource;
    Rl: Trlreport;
    bndSumRep: Trlband;
    bndRodape: Trlband;
    dtGrupo: Trlband;
    bndCabGrupo: Trlband;
    bndSum: Trlband;
    bndHeader: Trlband;
    bndSumGrupo: Trlband;
    Rldbresult1: Trldbresult;
    Rldbresult3: Trldbresult;
    Rldbresult7: Trldbresult;
    Rldbresult8: Trldbresult;
    Rldbresult9: Trldbresult;
    Rldbtext1: Trldbtext;
    Rldbtext10: Trldbtext;
    Rldbtext11: Trldbtext;
    Rldbtext12: Trldbtext;
    Rldbtext2: Trldbtext;
    Rldbtext3: Trldbtext;
    Rldbtext4: Trldbtext;
    Rldbtext5: Trldbtext;
    Rldbtext6: Trldbtext;
    Rldbtext7: Trldbtext;
    Rldbtext8: Trldbtext;
    Rldbtext9: Trldbtext;
    grGrupo: Trlgroup;
    Rllabel2: Trllabel;
    Rllabel3: Trllabel;
    Rllabel4: Trllabel;
    Rllabel5: Trllabel;
    Rllabel6: Trllabel;
    Rllabel62: Trllabel;
    Rllabel7: Trllabel;
    Rllabel8: Trllabel;
    Rllabel9: Trllabel;
    Rlsysteminfo3: Trlsysteminfo;
    Rlsysteminfo4: Trlsysteminfo;
    Rlsysteminfo5: Trlsysteminfo;
    Rlsysteminfo6: Trlsysteminfo;
  Private

  Public

  end;

var
  FrmRelCotasInadimplentes: TFrmRelCotasInadimplentes;

implementation


{$R *.lfm}

end.

