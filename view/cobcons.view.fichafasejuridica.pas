unit cobcons.view.fichafasejuridica;

{$mode delphi}

interface

uses
  Classes, Sysutils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ActnList, StdCtrls, Cobcons.View.Ficha, cobcons.controller.interfaces;

type

  { TFrmFichaFaseJuridica }

  TFrmFichaFaseJuridica = class(Tfrmficha)
    edDInicio: Tedit;
    edCusto: Tedit;
    edObservacao: Tedit;
    edRepresentante: Tedit;
    edGrupo: Tedit;
    edCota: Tedit;
    edFase: Tedit;
    edNome: Tedit;
    edSeq: Tedit;
    Label51: Tlabel;
    Label52: Tlabel;
    Label53: Tlabel;
    Label54: Tlabel;
    Label55: Tlabel;
    Label56: Tlabel;
    Label57: Tlabel;
    Label58: Tlabel;
    Label59: Tlabel;
    procedure Formshow(Sender: Tobject);
  Private
    Ffasejuridica: Icontrollerfasejuridica;
    procedure Setfasejuridica(Avalue: Icontrollerfasejuridica);

  Public
    property FaseJuridica: iControllerFaseJuridica read FFaseJuridica write SetFaseJuridica;
  end;

var
  FrmFichaFaseJuridica: TFrmFichaFaseJuridica;

implementation

uses cobcons.controller.factory;

{$R *.lfm}

{ TFrmFichaFaseJuridica }

procedure Tfrmfichafasejuridica.Formshow(Sender: Tobject);
begin
  edGrupo.Text := Ffasejuridica.GRUPO;
  edSeq.Text := Ffasejuridica.SEQ;
  edCota.Text := Ffasejuridica.COTA;
  edNome.Text := FFaseJuridica.NOME;
  edDInicio.Text := FormatDateTime('dd/mm/yyyy',FFaseJuridica.D_INICIO);
  edFase.Text := FFaseJuridica.DCFASE;
  edRepresentante.Text := FFaseJuridica.NMREPRES;
  edCusto.Text := Format('%.2n',[FFaseJuridica.CUST_MOE]);
  edObservacao.Text := FFaseJuridica.OBSERV;
End;

procedure Tfrmfichafasejuridica.Setfasejuridica(Avalue: Icontrollerfasejuridica);
begin
  if Ffasejuridica = Avalue then Exit;
  Ffasejuridica := Avalue;
end;

end.

