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
    edEmail: TEdit;
    Edestado: Tedit;
    Edtelefone: Tedit;
    edCelular: TEdit;
    Label38: Tlabel;
    Label39: TLabel;
    Label55: Tlabel;
    Label56: Tlabel;
    Label57: Tlabel;
    Label58: Tlabel;
    Label59: Tlabel;
    Label60: TLabel;
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
            .CELULAR(edCelular.Text)
            .CEP(RetornaSemFormatacao(Edcep.Text))
            .EMAIL(edEmail.Text)
            .AlterarEndereco;
    ModalResult := mrOK;
  end;
End;

procedure TFrmFichaEndereco.Setcota(Avalue: Icontrollercota);
begin
  Fcota := Avalue;
  Edtelefone.Text := Fcota.TELEFONE;
  edCelular.Text := Fcota.CELULAR;
  Edendereco.Text := Fcota.ENDERECO;
  Edbairro.Text := Fcota.BAIRRO;
  Edcidade.Text := Fcota.CIDADE;
  Edestado.Text := Fcota.ESTADO;
  Edcep.Text := RetornarFormatado(Fcota.CEP, tfCEP);
  edEmail.Text := Fcota.EMAIL;
end;

end.

