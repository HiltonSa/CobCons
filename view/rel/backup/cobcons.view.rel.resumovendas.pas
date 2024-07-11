unit cobcons.view.rel.resumovendas;

{$mode Delphi}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, RLReport;

type

  { TFrmRelResumoPeriodo }

  TFrmRelResumoPeriodo = class(TForm)
    BndRod: TRLBand;
    BndSum2: TRLBand;
    CabRel: TRLBand;
    det1: TRLBand;
    ds: TDataSource;
    dsPrs: TDataSource;
    grCab2: TRLBand;
    grEqp: TRLGroup;
    grFil: TRLGroup;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLBand4: TRLBand;
    RLBand5: TRLBand;
    RLBand6: TRLBand;
    RLDBResult12: TRLDBResult;
    RLDBResult13: TRLDBResult;
    RLDBResult14: TRLDBResult;
    RLDBResult15: TRLDBResult;
    RLDBResult16: TRLDBResult;
    RLDBResult17: TRLDBResult;
    RLDBResult18: TRLDBResult;
    RLDBResult19: TRLDBResult;
    RLDBResult20: TRLDBResult;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText16: TRLDBText;
    RLDBText19: TRLDBText;
    RLDBText20: TRLDBText;
    RLDBText21: TRLDBText;
    RLDBText23: TRLDBText;
    RLDBText7: TRLDBText;
    RLLabel16: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel23: TRLLabel;
    RLSystemInfo4: TRLSystemInfo;
    RLSystemInfo5: TRLSystemInfo;
    RLSystemInfo6: TRLSystemInfo;
    RLSystemInfo7: TRLSystemInfo;
    RLSystemInfo8: TRLSystemInfo;
    RP: TRLReport;
    procedure RLDBText23BeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmRelResumoPeriodo: TFrmRelResumoPeriodo;

implementation

{$R *.lfm}

{ TFrmRelResumoPeriodo }

procedure TFrmRelResumoPeriodo.RLDBText23BeforePrint(Sender: TObject;
  var AText: string; var PrintIt: Boolean);
begin
  if ds.DataSet.FieldByName('stage').AsInteger = 0
  then AText := 'Inativo'
  else AText := 'Ativo';
end;

end.

