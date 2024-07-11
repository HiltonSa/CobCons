unit cobcons.view.rel.recomposicaosaldosrnpcotas;

{$mode delphi}

interface

uses
  Classes, Sysutils, DB, Forms, Controls, Graphics, Dialogs,
  cobcons.controller.interfaces, RLReport;

type

  { TFrmRelRecomposicaoRnpCotas }

  TFrmRelRecomposicaoRnpCotas = class(Tform)
    Bndheader: Trlband;
    Bndrodape: Trlband;
    Bndsumrep: Trlband;
    Ds: Tdatasource;
    dsMov: Tdatasource;
    Dsprs: Tdatasource;
    bndDet: TRLBand;
    Movfin: Trlsubdetail;
    Rl: Trlreport;
    Rlband9: Trlband;
    Rldbtext1: Trldbtext;
    Rldbtext10: Trldbtext;
    Rldbtext11: Trldbtext;
    Rldbtext13: Trldbtext;
    Rldbtext14: Trldbtext;
    Rldbtext2: Trldbtext;
    Rldbtext3: Trldbtext;
    Rldbtext4: Trldbtext;
    Rldbtext65: Trldbtext;
    Rldbtext66: Trldbtext;
    Rldbtext7: Trldbtext;
    Rldbtext73: Trldbtext;
    Rldbtext78: Trldbtext;
    Rldbtext8: Trldbtext;
    Rldbtext9: Trldbtext;
    Rldetailgrid1: Trldetailgrid;
    Rllabel6: Trllabel;
    Rllabel60: Trllabel;
    Rllabel61: Trllabel;
    Rllabel62: Trllabel;
    Rllabel63: Trllabel;
    Rllabel64: Trllabel;
    Rllabel65: Trllabel;
    Rllabel7: Trllabel;
    Rllabel8: Trllabel;
    Rllabel9: Trllabel;
    Rllabel91: Trllabel;
    Rllabel92: Trllabel;
    Rllabel93: Trllabel;
    Rllabel96: Trllabel;
    Rllabel97: Trllabel;
    Rllabel98: Trllabel;
    Rlsysteminfo1: Trlsysteminfo;
    Rlsysteminfo3: Trlsysteminfo;
    Rlsysteminfo4: Trlsysteminfo;
    Rlsysteminfo6: Trlsysteminfo;
    procedure Bnddetbeforeprint(Sender: Tobject; var Printit: Boolean);
    procedure Formcreate(Sender: Tobject);
  Private
    Fdatalimite: Tdatetime;
    FFicha: iControllerFichaPagamentos;
    FDataset: TDataSet;
    procedure Setdatalimite(Avalue: Tdatetime);
  Public
    property DataLimite: TDateTime read FDataLimite write SetDataLimite;
  end;

var
  FrmRelRecomposicaoRnpCotas: TFrmRelRecomposicaoRnpCotas;

implementation

uses cobcons.controller.factory;

{$R *.lfm}

{ TFrmRelRecomposicaoRnpCotas }

procedure Tfrmrelrecomposicaornpcotas.Formcreate(Sender: Tobject);
begin
  FFicha := TControllerFactory.New.FichaPagamentos;
  Fdatalimite := StrToDate('30/06/2021');
End;

procedure Tfrmrelrecomposicaornpcotas.Setdatalimite(Avalue: Tdatetime);
begin
  Fdatalimite := Avalue;
end;

procedure Tfrmrelrecomposicaornpcotas.Bnddetbeforeprint(Sender: Tobject;
  var Printit: Boolean);
begin
   FDataset := FFicha.GRUPO(ds.DataSet.FieldByName('GRUPO').AsString)
                     .SEQ(ds.DataSet.FieldByName('SEQ').AsString)
                     .COTA(ds.DataSet.FieldByName('COTA').AsString)
                     .DATALIMITE(Fdatalimite)
                     .ContaCorrenteDevolucoes;
   dsMov.DataSet := FDataset;
   Printit := not FDataset.EOF;
End;

end.

