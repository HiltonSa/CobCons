unit cobcons.view.rel.pagamentornp;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, RLReport;

type

  { TFrmRelPagamentoRnp }

  TFrmRelPagamentoRnp = class(TForm)
    bndChavePix: TRLBand;
    bndConta: TRLBand;
    bndObs: TRLBand;
    bndPixConta: TRLBand;
    ds: TDataSource;
    dsPrs: TDataSource;
    rl: TRLReport;
    RLBand13: TRLBand;
    RLBand14: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLBand4: TRLBand;
    RLBand5: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDBText1: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText13: TRLDBText;
    RLDBText14: TRLDBText;
    RLDBText15: TRLDBText;
    RLDBText16: TRLDBText;
    RLDBText17: TRLDBText;
    RLDBText18: TRLDBText;
    RLDBText19: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText20: TRLDBText;
    RLDBText21: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLLabel1: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel62: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLSystemInfo3: TRLSystemInfo;
    RLSystemInfo4: TRLSystemInfo;
    RLSystemInfo5: TRLSystemInfo;
    RLSystemInfo6: TRLSystemInfo;
    procedure bndChavePixBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure bndContaBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure bndObsBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure bndPixContaBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private

  public

  end;

var
  FrmRelPagamentoRnp: TFrmRelPagamentoRnp;

implementation

{$R *.lfm}

{ TFrmRelPagamentoRnp }

procedure TFrmRelPagamentoRnp.bndChavePixBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PrintIt := (ds.DataSet.FieldByName('FRMPG').AsInteger = 0) and
             (ds.DataSet.FieldByName('TIPOPIX').AsInteger < 5);
end;

procedure TFrmRelPagamentoRnp.bndContaBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PrintIt := ds.DataSet.FieldByName('FRMPG').AsInteger > 0;
end;

procedure TFrmRelPagamentoRnp.bndObsBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PrintIt := Length(Trim(ds.DataSet.FieldByName('OBS').AsString)) > 0;
end;

procedure TFrmRelPagamentoRnp.bndPixContaBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PrintIt := (ds.DataSet.FieldByName('FRMPG').AsInteger = 0) and
             (ds.DataSet.FieldByName('TIPOPIX').AsInteger > 4);
end;

end.

