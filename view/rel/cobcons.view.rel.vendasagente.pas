unit cobcons.view.rel.vendasagente;

{$mode Delphi}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, RLReport;

type

  { TFrmRelVendasAgente }

  TFrmRelVendasAgente = class(TForm)
    BndRod1: TRLBand;
    BndSum2: TRLBand;
    CabRel: TRLBand;
    det1: TRLBand;
    ds: TDataSource;
    dsPrs: TDataSource;
    grCab1: TRLBand;
    grCab2: TRLBand;
    grRod2: TRLBand;
    grVen: TRLGroup;
    RLBand2: TRLBand;
    RLBand6: TRLBand;
    RLDBResult10: TRLDBResult;
    RLDBResult11: TRLDBResult;
    RLDBResult12: TRLDBResult;
    RLDBResult13: TRLDBResult;
    RLDBResult14: TRLDBResult;
    RLDBResult15: TRLDBResult;
    RLDBResult16: TRLDBResult;
    RLDBResult17: TRLDBResult;
    RLDBResult18: TRLDBResult;
    RLDBResult19: TRLDBResult;
    RLDBResult20: TRLDBResult;
    RLDBResult21: TRLDBResult;
    RLDBText12: TRLDBText;
    RLDBText13: TRLDBText;
    RLDBText14: TRLDBText;
    RLDBText15: TRLDBText;
    RLDBText16: TRLDBText;
    RLDBText17: TRLDBText;
    RLDBText18: TRLDBText;
    RLDBText19: TRLDBText;
    RLDBText20: TRLDBText;
    RLDBText21: TRLDBText;
    RLDBText22: TRLDBText;
    RLDBText23: TRLDBText;
    RLDBText24: TRLDBText;
    RLDBText25: TRLDBText;
    RLDBText26: TRLDBText;
    RLDBText27: TRLDBText;
    RLDBText28: TRLDBText;
    RLDBText29: TRLDBText;
    RLDBText30: TRLDBText;
    RLDBText31: TRLDBText;
    RLLabel16: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLSystemInfo10: TRLSystemInfo;
    RLSystemInfo11: TRLSystemInfo;
    RLSystemInfo4: TRLSystemInfo;
    RLSystemInfo5: TRLSystemInfo;
    RLSystemInfo7: TRLSystemInfo;
    RP: TRLReport;
    procedure RLDBText26BeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmRelVendasAgente: TFrmRelVendasAgente;

implementation

{$R *.lfm}

{ TFrmRelVendasAgente }

procedure TFrmRelVendasAgente.RLDBText26BeforePrint(Sender: TObject;
  var AText: string; var PrintIt: Boolean);
begin
  if ds.DataSet.FieldByName('stage').AsInteger = 0
  then AText := ' (Inativo)'
  else AText := ' (Ativo)';
end;

end.

