unit cobcons.view.rel.inadimplentes;

{$mode objfpc}{$H+}

interface

uses
  Classes, Sysutils, DB, Forms, Controls, Graphics, Dialogs, RLReport;

type

  { TFormRelInadimplentes }

  TFormRelInadimplentes = class(Tform)
    dsPrs: Tdatasource;
    Ds: Tdatasource;
    rl: TRLReport;
    Rlband13: Trlband;
    Rlband14: Trlband;
    Rlband2: Trlband;
    Rlband3: Trlband;
    Rlband4: Trlband;
    Rlband5: Trlband;
    Rldbresult1: Trldbresult;
    Rldbresult2: Trldbresult;
    Rldbresult3: Trldbresult;
    Rldbresult4: Trldbresult;
    Rldbresult5: Trldbresult;
    Rldbresult6: Trldbresult;
    Rldbtext1: Trldbtext;
    Rldbtext2: Trldbtext;
    Rldbtext3: Trldbtext;
    Rldbtext4: Trldbtext;
    Rldbtext5: Trldbtext;
    Rldbtext6: Trldbtext;
    Rldbtext7: Trldbtext;
    Rllabel2: Trllabel;
    Rllabel3: Trllabel;
    Rllabel4: Trllabel;
    Rllabel5: Trllabel;
    Rllabel6: Trllabel;
    Rllabel62: Trllabel;
    Rllabel7: Trllabel;
    Rlsysteminfo3: Trlsysteminfo;
    Rlsysteminfo4: Trlsysteminfo;
    Rlsysteminfo5: Trlsysteminfo;
    Rlsysteminfo6: Trlsysteminfo;
  Private

  Public

  end;

var
  FormRelInadimplentes: TFormRelInadimplentes;

implementation

{$R *.lfm}

end.
