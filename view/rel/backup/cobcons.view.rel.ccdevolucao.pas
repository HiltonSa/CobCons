unit cobcons.view.rel.ccdevolucao;

{$mode delphi}

interface

uses
  Classes, Sysutils, DB, Forms, Controls, Graphics, Dialogs, RLReport,
  RLPDFFilter;

type

  { TFrmCCDev }

  TFrmCCDev = class(Tform)
    Bndcontrato: Trlband;
    Bndresumofinanceiro: Trlband;
    Cabdados: Trlband;
    Detdados: Trlband;
    Dscot: Tdatasource;
    Dsmov: Tdatasource;
    Dsprs: Tdatasource;
    Dstot: Tdatasource;
    Lbldcsitcob: Trllabel;
    Lbldctpconte: Trllabel;
    Lbldtconte: Trllabel;
    Lbldtentrega: Trllabel;
    Lbldtnasc: Trllabel;
    Movfin: Trlsubdetail;
    Relcab: Trlband;
    Relfim: Trlband;
    Rlband10: Trlband;
    Rlband11: Trlband;
    Rlband9: Trlband;
    Rldbtext1: Trldbtext;
    Rldbtext10: Trldbtext;
    Rldbtext100: Trldbtext;
    Rldbtext101: Trldbtext;
    Rldbtext102: Trldbtext;
    Rldbtext103: Trldbtext;
    Rldbtext104: Trldbtext;
    Rldbtext105: Trldbtext;
    Rldbtext106: Trldbtext;
    Rldbtext107: Trldbtext;
    Rldbtext108: Trldbtext;
    Rldbtext109: Trldbtext;
    Rldbtext11: Trldbtext;
    Rldbtext110: Trldbtext;
    Rldbtext111: Trldbtext;
    Rldbtext112: Trldbtext;
    Rldbtext114: Trldbtext;
    Rldbtext12: Trldbtext;
    Rldbtext13: Trldbtext;
    Rldbtext14: Trldbtext;
    Rldbtext15: Trldbtext;
    Rldbtext16: Trldbtext;
    Rldbtext17: Trldbtext;
    Rldbtext18: Trldbtext;
    Rldbtext19: Trldbtext;
    Rldbtext21: Trldbtext;
    Rldbtext22: Trldbtext;
    Rldbtext23: Trldbtext;
    Rldbtext24: Trldbtext;
    Rldbtext35: Trldbtext;
    Rldbtext60: Trldbtext;
    Rldbtext61: Trldbtext;
    Rldbtext62: Trldbtext;
    Rldbtext63: Trldbtext;
    Rldbtext65: Trldbtext;
    Rldbtext66: Trldbtext;
    Rldbtext7: Trldbtext;
    Rldbtext70: Trldbtext;
    Rldbtext73: Trldbtext;
    Rldbtext78: Trldbtext;
    Rldbtext79: Trldbtext;
    Rldbtext80: Trldbtext;
    Rldbtext81: Trldbtext;
    Rldbtext82: Trldbtext;
    Rldbtext83: Trldbtext;
    Rldbtext84: Trldbtext;
    Rldbtext85: Trldbtext;
    Rldbtext86: Trldbtext;
    Rldbtext88: Trldbtext;
    Rldbtext89: Trldbtext;
    Rldbtext90: Trldbtext;
    Rldbtext91: Trldbtext;
    Rldbtext92: Trldbtext;
    Rllabel10: Trllabel;
    Rllabel105: Trllabel;
    Rllabel106: Trllabel;
    Rllabel107: Trllabel;
    Rllabel108: Trllabel;
    Rllabel109: Trllabel;
    Rllabel11: Trllabel;
    Rllabel110: Trllabel;
    Rllabel111: Trllabel;
    Rllabel112: Trllabel;
    Rllabel113: Trllabel;
    Rllabel114: Trllabel;
    Rllabel115: Trllabel;
    Rllabel116: Trllabel;
    Rllabel117: Trllabel;
    Rllabel118: Trllabel;
    Rllabel119: Trllabel;
    Rllabel12: Trllabel;
    Rllabel120: Trllabel;
    Rllabel121: Trllabel;
    Rllabel122: Trllabel;
    Rllabel123: Trllabel;
    Rllabel124: Trllabel;
    Rllabel125: Trllabel;
    Rllabel13: Trllabel;
    Rllabel14: Trllabel;
    Rllabel15: Trllabel;
    Rllabel16: Trllabel;
    Rllabel17: Trllabel;
    Rllabel18: Trllabel;
    Rllabel58: Trllabel;
    Rllabel6: Trllabel;
    Rllabel60: Trllabel;
    Rllabel61: Trllabel;
    Rllabel62: Trllabel;
    Rllabel63: Trllabel;
    Rllabel64: Trllabel;
    Rllabel66: Trllabel;
    Rllabel67: Trllabel;
    Rllabel68: Trllabel;
    Rllabel69: Trllabel;
    Rllabel70: Trllabel;
    Rllabel71: Trllabel;
    Rllabel72: Trllabel;
    Rllabel73: Trllabel;
    Rllabel74: Trllabel;
    Rllabel75: Trllabel;
    Rllabel76: Trllabel;
    Rllabel77: Trllabel;
    Rllabel78: Trllabel;
    Rllabel79: Trllabel;
    Rllabel8: Trllabel;
    Rllabel80: Trllabel;
    Rllabel81: Trllabel;
    Rllabel82: Trllabel;
    Rllabel9: Trllabel;
    Rllabel91: Trllabel;
    Rllabel96: Trllabel;
    Rlsysteminfo1: Trlsysteminfo;
    Rlsysteminfo3: Trlsysteminfo;
    Rlsysteminfo4: Trlsysteminfo;
    Rlsysteminfo5: Trlsysteminfo;
    Rlsysteminfo6: Trlsysteminfo;
    Rodape: Trlband;
    Rp: Trlreport;
    procedure Bndcontratobeforeprint(Sender: Tobject; var Printit: Boolean);
    procedure Detdadosbeforeprint(Sender: Tobject; var Printit: Boolean);
  Private

  Public

  end;

var
  FrmCCDev: TFrmCCDev;

implementation

uses cobcons.controller.util;

{$R *.lfm}

{ TFrmCCDev }

procedure Tfrmccdev.Bndcontratobeforeprint(Sender: Tobject;
  var Printit: Boolean);
begin
  lblDtEntrega.Caption := RetornaDataString(dsCot.DataSet.FieldByName('DT_ENTRE').AsDateTime);
  lblDtConte.Caption := RetornaDataString(dsCot.DataSet.FieldByName('DT_CONTE').AsDateTime);
End;

procedure Tfrmccdev.Detdadosbeforeprint(Sender: Tobject; var Printit: Boolean);
begin
  lblDtNasc.Caption := RetornaDataString(dsCot.DataSet.FieldByName('DT_NASC').AsDateTime);
End;

end.

