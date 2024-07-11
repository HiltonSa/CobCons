unit cobcons.view.rel.cota;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, DB;

type

  { TfrmRelCli }

  TfrmRelCli = class(TForm)
    dsTCot: TDataSource;
    dsAli: Tdatasource;
    dsTot: Tdatasource;
    Alienacoes: Trlsubdetail;
    lblDcSitCob: Trllabel;
    lblDcTpConte: Trllabel;
    lblDtNasc: Trllabel;
    lblDtEntrega: Trllabel;
    lblDtConte: Trllabel;
    lblDtNFis: Trllabel;
    lblSubst: Trllabel;
    lblDtDesali: Trllabel;
    Rlband12: Trlband;
    Rlband13: Trlband;
    Rlband14: Trlband;
    Rlband15: Trlband;
    Rlband16: Trlband;
    bndResumoFinanceiro: Trlband;
    bndContrato: Trlband;
    Rlband17: Trlband;
    Rlband18: Trlband;
    Rldbresult16: Trldbresult;
    Rldbresult17: Trldbresult;
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
    Rldbtext110: Trldbtext;
    Rldbtext111: Trldbtext;
    Rldbtext112: Trldbtext;
    Rldbtext114: Trldbtext;
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
    Rldbtext7: Trldbtext;
    Rldbtext70: Trldbtext;
    Rldbtext79: Trldbtext;
    Rldbtext8: Trldbtext;
    Rldbtext80: Trldbtext;
    Rldbtext81: Trldbtext;
    Rldbtext82: Trldbtext;
    Rldbtext83: Trldbtext;
    Rldbtext84: Trldbtext;
    Rldbtext85: Trldbtext;
    Rldbtext86: Trldbtext;
    Rldbtext87: Trldbtext;
    Rldbtext88: Trldbtext;
    Rldbtext89: Trldbtext;
    Rldbtext90: Trldbtext;
    Rldbtext91: Trldbtext;
    Rldbtext92: Trldbtext;
    Rldbtext93: Trldbtext;
    Rldbtext94: Trldbtext;
    Rldbtext95: Trldbtext;
    Rldbtext96: Trldbtext;
    Rldbtext97: Trldbtext;
    Rldbtext98: Trldbtext;
    Rldbtext99: Trldbtext;
    Rllabel10: Trllabel;
    Rllabel100: Trllabel;
    Rllabel101: Trllabel;
    Rllabel102: Trllabel;
    Rllabel103: Trllabel;
    lblDtAlienacao: Trllabel;
    Rllabel104: Trllabel;
    Rllabel105: Trllabel;
    Rllabel106: Trllabel;
    Rllabel107: Trllabel;
    Rllabel108: Trllabel;
    Rllabel109: Trllabel;
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
    Rllabel120: Trllabel;
    Rllabel121: Trllabel;
    Rllabel122: Trllabel;
    Rllabel123: Trllabel;
    Rllabel124: Trllabel;
    Rllabel125: Trllabel;
    Rllabel18: Trllabel;
    Rllabel2: Trllabel;
    Rllabel3: Trllabel;
    Rllabel38: Trllabel;
    Rllabel39: Trllabel;
    Rllabel4: Trllabel;
    Rllabel40: Trllabel;
    Rllabel41: Trllabel;
    Rllabel42: Trllabel;
    Rllabel43: Trllabel;
    Rllabel44: Trllabel;
    Rllabel45: Trllabel;
    Rllabel46: Trllabel;
    Rllabel47: Trllabel;
    Rllabel5: Trllabel;
    Rllabel6: Trllabel;
    Rllabel62: Trllabel;
    Rllabel63: Trllabel;
    Rllabel64: Trllabel;
    Rllabel65: Trllabel;
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
    Rllabel80: Trllabel;
    Rllabel81: Trllabel;
    Rllabel82: Trllabel;
    Rllabel83: Trllabel;
    Rllabel84: Trllabel;
    Rllabel85: Trllabel;
    Rllabel86: Trllabel;
    Rllabel87: Trllabel;
    Rllabel88: Trllabel;
    Rllabel89: Trllabel;
    Rllabel90: Trllabel;
    Rllabel91: Trllabel;
    Rllabel92: Trllabel;
    Rllabel93: Trllabel;
    Rllabel94: Trllabel;
    Rllabel95: Trllabel;
    Rllabel96: Trllabel;
    Rllabel97: Trllabel;
    Rllabel98: Trllabel;
    Rllabel99: Trllabel;
    Rlsysteminfo4: Trlsysteminfo;
    Rlsysteminfo5: Trlsysteminfo;
    Rlsysteminfo6: Trlsysteminfo;
    Rp: TRLReport;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    dsPrs: TDataSource;
    RLSystemInfo1: TRLSystemInfo;
    dsCot: TDataSource;
    RLBand2: TRLBand;
    RLLabel8: TRLLabel;
    RLDBText10: TRLDBText;
    RLLabel9: TRLLabel;
    RLDBText11: TRLDBText;
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
    Creditos: TRLSubDetail;
    dsCre: TDataSource;
    RLBand4: TRLBand;
    RLDBText39: TRLDBText;
    RLDBText40: TRLDBText;
    RLDBText41: TRLDBText;
    RLDBText42: TRLDBText;
    RLDBText43: TRLDBText;
    RLDBText44: TRLDBText;
    RLDBText45: TRLDBText;
    RLDBText47: TRLDBText;
    RLDBText48: TRLDBText;
    RLDBText49: TRLDBText;
    RLDBText50: TRLDBText;
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
    procedure Bndcontratobeforeprint(Sender: Tobject; var Printit: Boolean);
    procedure Rlband12beforeprint(Sender: Tobject; var Printit: Boolean);
    procedure Rlband16beforeprint(Sender: Tobject; var Printit: Boolean);
    procedure Rlband2beforeprint(Sender: Tobject; var Printit: Boolean);
    procedure Rlband4beforeprint(Sender: Tobject; var Printit: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCli: TfrmRelCli;

implementation

uses cobcons.controller.util;


{$R *.lfm}

{ TfrmRelCli }

procedure Tfrmrelcli.Rlband12beforeprint(Sender: Tobject; var Printit: Boolean);
begin
  Printit := Length(Trim(dsMov.DataSet.FieldByName('HIST').AsString)) > 0;
End;

procedure Tfrmrelcli.Bndcontratobeforeprint(Sender: Tobject;
  var Printit: Boolean);
begin
  lblDtEntrega.Caption := RetornaDataString(dsCot.DataSet.FieldByName('DT_ENTRE').AsDateTime);
  lblDtConte.Caption := RetornaDataString(dsCot.DataSet.FieldByName('DT_CONTE').AsDateTime);
End;

procedure Tfrmrelcli.Rlband16beforeprint(Sender: Tobject; var Printit: Boolean);
begin
  lblDtAlienacao.Caption := RetornaDataString(dsAli.DataSet.FieldByName('DT_ALIE').AsDateTime);
  lblSubst.Caption := RetornaDataString(dsAli.DataSet.FieldByName('DT_SUBST').AsDateTime);
  lblDtDesali.Caption := RetornaDataString(dsAli.DataSet.FieldByName('DT_DESAL').AsDateTime);
End;

procedure Tfrmrelcli.Rlband2beforeprint(Sender: Tobject; var Printit: Boolean);
begin
  lblDtNasc.Caption := RetornaDataString(dsCot.DataSet.FieldByName('DT_NASC').AsDateTime);
End;

procedure Tfrmrelcli.Rlband4beforeprint(Sender: Tobject; var Printit: Boolean);
begin
  lblDtNFis.Caption := RetornaDataString(dsCre.DataSet.FieldByName('DT_N_FIS').AsDateTime);
End;

end.
