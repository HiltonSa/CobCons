unit cobcons.view.situacaocobranca;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Mask,
{$ELSE}
  MaskEdit,
{$ENDIF}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Buttons, ExtCtrls, StdCtrls, DBCtrls,
  cobcons.controller.interfaces, DB;

type

  { TfrmSitCob }

  TfrmSitCob = class(TForm)
    Dbedit3: Tdbedit;
    Dbedit4: Tdbedit;
    Dbedit5: Tdbedit;
    Dbedit6: Tdbedit;
    Eddcsitcob: Tedit;
    Label51: Tlabel;
    Label53: Tlabel;
    Label54: Tlabel;
    pnAcoes: TPanel;
    Pntitulo: Tpanel;
    SpeedButton1: TSpeedButton;
    al: TActionList;
    gravar: TAction;
    cancela: TAction;
    SpeedButton2: TSpeedButton;
    pnBack: TPanel;
    DS: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label27: TLabel;
    cboSit: TComboBox;
    Label3: TLabel;
    procedure cancelaExecute(Sender: TObject);
    procedure Formcreate(Sender: Tobject);
    procedure gravarExecute(Sender: TObject);
  private
    Fcliente: Icontrollercota;
    procedure Setcliente(Avalue: Icontrollercota);
    { Private declarations }
  public
    { Public declarations }
    property Cliente: iControllerCota read FCliente write SetCliente;
  end;

var
  frmSitCob: TfrmSitCob;

implementation

uses cobcons.model.dm, cobcons.model.configura, cobcons.controller.util;

{$R *.lfm}

procedure Tfrmsitcob.Cancelaexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
end;

procedure Tfrmsitcob.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnBack.Color := vEsquema.CorFundo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
End;

procedure Tfrmsitcob.Gravarexecute(Sender: Tobject);
const
  SITCOB = 'NMJQCDT';
var
  vSit: string;
begin
  if ConfirmaMensagem('Confirma a alteração?') then begin
    vSit := Copy(SITCOB, cboSit.ItemIndex + 1, 1);
    Fcliente.SIT_COBR(vSit).AlterarSitCota;
    ModalResult := mrOk;
  end;
end;

procedure Tfrmsitcob.Setcliente(Avalue: Icontrollercota);
begin
  if Fcliente = Avalue then Exit;
  Fcliente := Avalue;
  Eddcsitcob.Text := Fcliente.DCSITCOB;
  DS.DataSet := Fcliente.Dataset;
end;

end.
