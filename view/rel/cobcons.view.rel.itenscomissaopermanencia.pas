unit cobcons.view.rel.itenscomissaopermanencia;

{$mode delphi}

interface

uses
  Classes, Sysutils, DB, Forms, Controls, Graphics, Dialogs, RLReport;

type

  { TFrmRelItensComissaoPermanencia }

  TFrmRelItensComissaoPermanencia = class(Tform)
    Bndcabgrupo: Trlband;
    Bndheader: Trlband;
    Bndrodape: Trlband;
    Bndsum: Trlband;
    Bndsumgrupo: Trlband;
    Bndsumrep: Trlband;
    dscp: Tdatasource;
    Ds: Tdatasource;
    Dsprs: Tdatasource;
    Dtgrupo: Trlband;
    Grgrupo: Trlgroup;
    Rl: Trlreport;
    CabPai: TRLBand;
    Rldbresult1: Trldbresult;
    Rldbresult10: Trldbresult;
    Rldbresult2: Trldbresult;
    Rldbresult3: Trldbresult;
    Rldbresult7: Trldbresult;
    Rldbresult8: Trldbresult;
    Rldbresult9: Trldbresult;
    Rldbtext1: Trldbtext;
    Rldbtext10: Trldbtext;
    Rldbtext11: Trldbtext;
    Rldbtext12: Trldbtext;
    Rldbtext13: Trldbtext;
    Rldbtext14: Trldbtext;
    Rldbtext15: Trldbtext;
    Rldbtext2: Trldbtext;
    Rldbtext3: Trldbtext;
    Rldbtext4: Trldbtext;
    Rldbtext5: Trldbtext;
    Rldbtext6: Trldbtext;
    Rldbtext7: Trldbtext;
    Rldbtext8: Trldbtext;
    Rldbtext9: Trldbtext;
    Rllabel2: Trllabel;
    Rllabel3: Trllabel;
    Rllabel4: Trllabel;
    Rllabel5: Trllabel;
    Rllabel6: Trllabel;
    Rllabel9: Trllabel;
    Rlsysteminfo1: Trlsysteminfo;
    Rlsysteminfo3: Trlsysteminfo;
    Rlsysteminfo4: Trlsysteminfo;
    Rlsysteminfo5: Trlsysteminfo;
    Rlsysteminfo6: Trlsysteminfo;
  Private

  Public

  end;

var
  FrmRelItensComissaoPermanencia: TFrmRelItensComissaoPermanencia;

implementation

{$R *.lfm}

end.

