unit cobcons.view.ficha;

{$mode delphi}

interface

uses
  Classes, Sysutils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, LCLIntf, LCLType,
  ActnList, Buttons, cobcons.controller.interfaces, Messages;

type

  { TFrmFicha }

  TFrmFicha = class(Tform)
    Cancelar: Taction;
    Gravar: Taction;
    AL: Tactionlist;
    pnAcoes: Tpanel;
    pnBack: Tpanel;
    pnTitulo: Tpanel;
    Speedbutton1: Tspeedbutton;
    Speedbutton2: Tspeedbutton;
    procedure Cancelarexecute(Sender: Tobject);
    procedure Formcreate(Sender: Tobject);
    procedure Formkeydown(Sender: Tobject; var Key: Word; Shift: Tshiftstate);
    procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
  private
  Public
  end;

var
  FrmFicha: TFrmFicha;

implementation

uses cobcons.model.configura;

{$R *.lfm}

{ TFrmFicha }

procedure Tfrmficha.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnBack.Color := vEsquema.CorFundo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
End;

procedure Tfrmficha.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_RETURN: SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Cancelar.Execute;
  end;
End;

procedure Tfrmficha.Cancelarexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
End;

procedure Tfrmficha.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

end.

