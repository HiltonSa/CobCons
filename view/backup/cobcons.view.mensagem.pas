unit cobcons.view.mensagem;

{$mode delphi}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ActnList;

type

  { TFrmMsg }

  TFrmMsg = class(TForm)
    acOk: Taction;
    acCancelar: Taction;
    acSim: Taction;
    acNao: Taction;
    acSimEnter: Taction;
    al: Tactionlist;
    pnMsg: TPanel;
    btSim: TSpeedButton;
    btNao: TSpeedButton;
    procedure Acnaoexecute(Sender: Tobject);
    procedure Acsimexecute(Sender: Tobject);
    procedure Formcreate(Sender: Tobject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    Fbt: Integer;
    procedure Setbt(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }
    property bt: Integer read Fbt write Setbt;
  end;

var
  FrmMsg: TFrmMsg;

implementation

uses cobcons.model.configura;

{$R *.lfm}

procedure TFrmMsg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F2: if acSim.Enabled then acSim.Execute;
    VK_RETURN: begin
      if acOk.Enabled then acOk.Execute;
      if acSimEnter.Enabled then acSimEnter.Execute;
    end;
    VK_ESCAPE: acNao.Execute;
    else MessageBeep(MB_ICONERROR);
  end;
end;

procedure TFrmMsg.Acsimexecute(Sender: Tobject);
begin
  ModalResult := mrOK;
End;

procedure TFrmMsg.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnMsg.Color := vEsquema.CorPainelTitulo;
End;

procedure TFrmMsg.Acnaoexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
End;

procedure TFrmMsg.Setbt(const Value: Integer);
begin
  Fbt := Value;
  acSim.Enabled := False;
  acNao.Enabled := False;
  acCancelar.Enabled := False;
  acOk.Enabled := False;
  acSimEnter.Enabled := False;
  case Fbt of
    0: begin
      acSimEnter.Enabled := True;
      acNao.Enabled := True;
      btSim.Action := acSimEnter;
      btNao.Action := acNao;
    end;
    1: begin
      acSim.Enabled := True;
      acNao.Enabled := True;
      btSim.Action := acSim;
      btNao.Action := acNao;
    end;
    2: begin
      acOk.Enabled := True;
      btSim.Visible := False;
      btNao.Action := acOk;
    end;
  end;
  //btSim.Visible := (Fbt = 1);
end;

procedure TFrmMsg.SetIntervalo(AValue: Integer);
begin
  FIntervalo := AValue;
end;

end.
