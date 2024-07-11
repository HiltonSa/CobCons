program GerarChave;

uses
  Forms,
  FormGeraChave in 'FormGeraChave.pas' {frmGerarChave},
  UnitCpt in 'UnitCpt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmGerarChave, frmGerarChave);
  Application.Run;
end.
