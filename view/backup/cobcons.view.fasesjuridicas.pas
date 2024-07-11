unit cobcons.view.fasesjuridicas;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, DBCtrls, ExtCtrls, DBGrids,
  cobcons.controller.interfaces;

type

  { TfrmJur }

  TfrmJur = class(TForm)
    Dbedit1: Tdbedit;
    Dbedit2: Tdbedit;
    Dbedit3: Tdbedit;
    Dbedit4: Tdbedit;
    Dbedit5: Tdbedit;
    Dbedit6: Tdbedit;
    Dbedit7: Tdbedit;
    Dbedit8: Tdbedit;
    Dbedit9: Tdbedit;
    dsJur: TDataSource;
    grJur: Tdbgrid;
    Label1: Tlabel;
    Label2: Tlabel;
    Label3: Tlabel;
    Label55: Tlabel;
    Label56: Tlabel;
    Label57: Tlabel;
    Label58: Tlabel;
    Label59: Tlabel;
    nvJur: Tdbnavigator;
    pnBack: TPanel;
    Pntitulo: Tpanel;
    procedure Formcreate(Sender: Tobject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
  private
    { Private declarations }
    Ffasesjuridicas: Icontrollerfasejuridica;
    procedure Setfasesjuridicas(Avalue: Icontrollerfasejuridica);
  public
    { Public declarations }
    property FasesJuridicas: iControllerFaseJuridica read FFasesJuridicas write SetFasesJuridicas;
  end;

var
  frmJur: TfrmJur;

implementation

uses cobcons.model.configura, cobcons.controller.util;

{$R *.lfm}

procedure Tfrmjur.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_ESCAPE: Close;
  end;
end;

procedure Tfrmjur.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmjur.Setfasesjuridicas(Avalue: Icontrollerfasejuridica);
begin
  if Ffasesjuridicas = Avalue then Exit;
  Ffasesjuridicas := Avalue;
  dsJur.DataSet := Ffasesjuridicas.DataSet;
end;

procedure Tfrmjur.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnBack.Color := vEsquema.CorFundo;
  Pntitulo.Color := vEsquema.CorPainelTitulo;
End;

end.
