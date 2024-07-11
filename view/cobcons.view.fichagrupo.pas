unit cobcons.view.fichagrupo;

{$mode delphi}

interface

uses
  Classes, Sysutils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ActnList, StdCtrls, EditBtn, DateTimePicker, Cobcons.View.Ficha,
  cobcons.controller.interfaces;

type

  { TFrmFichaGrupo }

  TFrmFichaGrupo = class(Tfrmficha)
    edTxPer: Tcalcedit;
    dtIniCob: Tdatetimepicker;
    edRegApl: Tedit;
    edUltAss: Tedit;
    edEncCont: Tedit;
    Label1: Tlabel;
    Label2: Tlabel;
    Label3: Tlabel;
    Label4: Tlabel;
    Label5: Tlabel;
    procedure Gravarexecute(Sender: Tobject);
  Private
    Fgrupo: Icontrollertotalgrupo;
    procedure Setgrupo(Avalue: Icontrollertotalgrupo);
    procedure PreencherEdits;
  Public
     property Grupo: iControllerTotalGrupo read FGrupo write SetGrupo;
  end;

var
  FrmFichaGrupo: TFrmFichaGrupo;

implementation

uses cobcons.controller.util;

{$R *.lfm}

{ TFrmFichaGrupo }

procedure Tfrmfichagrupo.Gravarexecute(Sender: Tobject);
begin
  if ConfirmaMensagem('Gravar as Informações?')
  then begin
    Fgrupo.REGAPLIC(edRegApl.Text)
          .TXPER(edTxPer.AsFloat)
          .DTCMPER(dtIniCob.Date)
          .Gravar;
    ModalResult := mrOK;
  end;
End;

procedure Tfrmfichagrupo.Setgrupo(Avalue: Icontrollertotalgrupo);
begin
  Fgrupo := Avalue;
  pnTitulo.Caption := 'Grupo: '+Fgrupo.GRUPO;
  PreencherEdits;
end;

procedure Tfrmfichagrupo.Preencheredits;
begin
  edRegApl.Text := Fgrupo.REGAPLIC;
  edUltAss.Text := FormatDateTime('dd/mm/yyyy', Fgrupo.DTULTASS);
  edEncCont.Text := FormatDateTime('dd/mm/yyyy', Fgrupo.DTENCCT);
  edTxPer.AsFloat := Fgrupo.TXPER;
  dtIniCob.Date := Fgrupo.DTCMPER;
end;

end.

