unit cobcons.view.rel.cotasrnp;

{$mode delphi}

interface

uses
  Classes, Sysutils, DB, Forms, Controls, Graphics, Dialogs, RLReport;

type

  { TFrmRelCotasRnp }

  TFrmRelCotasRnp = class(Tform)
    Bndcabgrupo: Trlband;
    Bndheader: Trlband;
    Bndrodape: Trlband;
    Bndsum: Trlband;
    Bndsumgrupo: Trlband;
    Bndsumrep: Trlband;
    Ds: Tdatasource;
    Dsprs: Tdatasource;
    Dsttgru: Tdatasource;
    Dtgrupo: Trlband;
    Grgrupo: Trlgroup;
    Rl: Trlreport;
    Rldbresult1: Trldbresult;
    Rldbresult10: Trldbresult;
    Rldbresult3: Trldbresult;
    Rldbresult7: Trldbresult;
    Rldbresult8: Trldbresult;
    Rldbresult9: Trldbresult;
    Rldbtext1: Trldbtext;
    Rldbtext10: Trldbtext;
    Rldbtext11: Trldbtext;
    Rldbtext15: Trldbtext;
    lbTotGru: TRLLabel;
    rlPcRateio: TRLDBText;
    Rldbtext14: Trldbtext;
    Rldbtext2: Trldbtext;
    Rldbtext3: Trldbtext;
    Rldbtext4: Trldbtext;
    rlRatFut: TRLDBText;
    rlRnp: TRLDBText;
    Rldbtext7: Trldbtext;
    Rldbtext8: Trldbtext;
    Rldbtext9: Trldbtext;
    Rllabel10: Trllabel;
    Rllabel2: Trllabel;
    Rllabel3: Trllabel;
    Rllabel4: Trllabel;
    Rllabel5: Trllabel;
    Rllabel6: Trllabel;
    Rllabel7: Trllabel;
    Rllabel8: Trllabel;
    Rllabel9: Trllabel;
    Rlsysteminfo1: Trlsysteminfo;
    Rlsysteminfo3: Trlsysteminfo;
    Rlsysteminfo4: Trlsysteminfo;
    Rlsysteminfo5: Trlsysteminfo;
    Rlsysteminfo6: Trlsysteminfo;
    procedure Bndsumbeforeprint(Sender: Tobject; var Printit: Boolean);
    procedure Dtgrupoafterprint(Sender: Tobject);
    procedure Grgrupoafterprint(Sender: Tobject);
    procedure Rlbeforeprint(Sender: Tobject; var Printit: Boolean);
  Private
    FQtdGru: Integer;
    FQtdCota: Integer;
  Public

  end;

var
  FrmRelCotasRnp: TFrmRelCotasRnp;

implementation

{$R *.lfm}

{ TFrmRelCotasRnp }

procedure Tfrmrelcotasrnp.Rlbeforeprint(Sender: Tobject; var Printit: Boolean);
begin
  Rldbresult9.Visible := rlRatFut.Visible;
  Rldbresult10.Visible := rlRatFut.Visible;
  Rldbresult3.Visible := rlRatFut.Visible;
  Rllabel10.Visible := rlRatFut.Visible;
  Rllabel9.Visible := rlRatFut.Visible;
  FQtdGru := 0;
  FQtdCota := 0;
End;

procedure Tfrmrelcotasrnp.Grgrupoafterprint(Sender: Tobject);
begin
  Inc(FQtdGru);
End;

procedure Tfrmrelcotasrnp.Bndsumbeforeprint(Sender: Tobject;
  var Printit: Boolean);
begin
  lbTotGru.Caption := Format('TOTAL GRUPOS: %d TOTAL COTAS: %d',[FQtdGru, FQtdCota]);
End;

procedure Tfrmrelcotasrnp.Dtgrupoafterprint(Sender: Tobject);
begin
  Inc(FQtdCota);
End;

end.

