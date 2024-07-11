unit cobcons.view.fichaendereco;

{$mode delphi}

interface

uses
  Classes, Sysutils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ActnList, StdCtrls, Cobcons.View.Ficha, cobcons.controller.interfaces;

type

  { TFrmFichaEndereco }

  TFrmFichaEndereco = class(Tfrmficha)
    Edbairro: Tedit;
    Edcep: Tedit;
    Edcidade: Tedit;
    Edendereco: Tedit;
    Edestado: Tedit;
    Edtelefone: Tedit;
    Label38: Tlabel;
    Label55: Tlabel;
    Label56: Tlabel;
    Label57: Tlabel;
    Label58: Tlabel;
    Label59: Tlabel;
    procedure Edcepexit(Sender: Tobject);
    procedure Gravarexecute(Sender: Tobject);
  Private
    Fcota: Icontrollercota;
    procedure Setcota(Avalue: Icontrollercota);

  Public
     property Cota: iControllerCota read FCota write SetCota;
  end;

var
  FrmFichaEndereco: TFrmFichaEndereco;

implementation

uses cobcons.controller.util;

{$R *.lfm}

{ TFrmFichaEndereco }

procedure TFrmFichaEndereco.Edcepexit(Sender: Tobject);
begin
  Edcep.Text := RetornarFormatado(Edcep.Text, tfCEP);
End;

procedure TFrmFichaEndereco.Gravarexecute(Sender: Tobject);
begin
  if ConfirmaMensagem('Confirma a Gravação?')
  then begin
    Fcota.TELEFONE(Edtelefone.Text)
            .ENDERECO(Edendereco.Text)
            .BAIRRO(Edbairro.Text)
            .CIDADE(Edcidade.Text)
            .ESTADO(Edestado.Text)
            .CEP(RetornaSemFormatacao(Edcep.Text))
            .AlterarEndereco;
    ModalResult := mrOK;
  end;
End;

procedure TFrmFichaEndereco.Setcota(Avalue: Icontrollercota);
begin
  Fcota := Avalue;
  Edtelefone.Text := Fcota.TELEFONE;
  Edendereco.Text := Fcota.ENDERECO;
  Edbairro.Text := Fcota.BAIRRO;
  Edcidade.Text := Fcota.CIDADE;
  Edestado.Text := Fcota.ESTADO;
  Edcep.Text := RetornarFormatado(Fcota.CEP, tfCEP);
end;

end.

