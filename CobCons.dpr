program CobCons;

{$MODE Delphi}

uses
  Forms, Interfaces, cobcons.view.principal, cobcons.view.login,
  cobcons.model.dm, Controls;

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Controle de Contratos';

  FrmLogin := TFrmLogin.Create(nil);
  try
     if FrmLogin.ShowModal=mrOk then begin
       Application.CreateForm(TDM, DM);
       Application.CreateForm(TFrmPrincipal, FrmPrincipal);
       Application.Run;
    end
    else begin
      Application.Terminate;
    end;
  finally
    FrmLogin.Free;
  end;

end.

