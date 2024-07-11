program ConversorDados;

uses
  Forms,
  UnitDados in 'UnitDados.pas' {FormPrincipal},
  Data in 'Data.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
