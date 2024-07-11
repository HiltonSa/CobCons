unit cobcons.view.fichacompromisso;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  JvDBDatePickerEdit, JvDatePickerEdit, JvCheckedMaskEdit, JvMaskEdit, JvToolEdit, JvExMask, JvExStdCtrls, JvDBCombobox, Mask,
{$ELSE}
  MaskEdit,
{$ENDIF}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, DBDateTimePicker, DateTimePicker,
  DB, ActnList, Buttons, ExtCtrls, ComCtrls, cobcons.controller.interfaces;

type

  { TfrmCom }

  TfrmCom = class(TForm)
    cboPrioridade: Tcombobox;
    dtAge: Tdatetimepicker;
    edGrupo: Tedit;
    edSeq: Tedit;
    edCota: Tedit;
    edNome: Tedit;
    mmObs: Tmemo;
    pnAcoes: TPanel;
    btnGravar: TSpeedButton;
    btnCancelar: TSpeedButton;
    AL: TActionList;
    Grava: TAction;
    Cancela: TAction;
    pnBack: TPanel;
    DS: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    pnTitulo: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure GravaExecute(Sender: TObject);
    procedure CancelaExecute(Sender: TObject);

      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
  private
    FIncluir: Boolean;
    Fcliente: Icontrollercota;
    Fcompromisso: Icontrolleragenda;
    procedure Setcliente(Avalue: Icontrollercota);
    procedure Setcompromisso(Avalue: Icontrolleragenda);
    { Private declarations }
  public
    { Public declarations }
    property Cliente: iControllerCota read FCliente write SetCliente;
    property Compromisso: iControllerAgenda read FCompromisso write SetCompromisso;
  end;

var
  frmCom: TfrmCom;

implementation

uses cobcons.model.dm, cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util;

{$R *.lfm}

procedure Tfrmcom.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
     case Key of
       VK_F5: if btnGravar.Enabled then btnGravar.Click;
       VK_F6: if btnCancelar.Enabled then btnCancelar.Click;
       VK_RETURN: if not mmObs.Focused then SelectNext(ActiveControl,True,True);
       VK_ESCAPE: Cancela.Execute;
     end;
end;

procedure Tfrmcom.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnBack.Color := vEsquema.CorFundo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
end;

procedure Tfrmcom.Gravaexecute(Sender: Tobject);
var
  vAgenda: iControllerAgenda;
  vUsuario: iControllerUsuarioLogado;
  vMemo: TMemoryStream;
  vCod: integer;
begin
  if dtAge.Date < Date
  then begin
    MostraAviso('Informe uma data atual ou futura!');
    dtAge.SetFocus;
  end
  else if ConfirmaMensagem('Gravar as informações?')
  then begin
    vUsuario := TControllerFactory.New.UsuarioLogado;
    vAgenda := TControllerFactory.New.Agenda;
    vCod := vAgenda.ProximoCodigo;
    vMemo := TMemoryStream.Create;
    try
      mmObs.Lines.SaveToStream(vMemo);
      vMemo.Position := 0;
      if FIncluir
      then vAgenda.CODIGO(vCod)
                  .DTAGE(dtAge.Date)
                  .PRIORIDADE(cboPrioridade.ItemIndex)
                  .CONTRATO(Fcliente.CONTRATO)
                  .STATUS(0)
                  .OBS(vMemo)
                  .GRUPO(Fcliente.GRUPO)
                  .SEQ(Fcliente.SEQ)
                  .COTA(Fcliente.COTA)
                  .USUARIO(vUsuario.CODIGO)
                  .Novo
      else vAgenda.CODIGO(Fcompromisso.CODIGO)
                  .DTAGE(dtAge.Date)
                  .OBS(vMemo)
                  .PRIORIDADE(cboPrioridade.ItemIndex)
                  .USUARIO(vUsuario.CODIGO)
                  .Alterar;
    finally
      vMemo.Clear;
    end;
    ModalResult := mrOK;
  end;
end;

procedure Tfrmcom.Cancelaexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
end;

procedure Tfrmcom.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmcom.Setcliente(Avalue: Icontrollercota);
begin
  //
  //  incluindo novo compromisso a partir da consulta de clientes
  //
  FIncluir := True;
  if Fcliente = Avalue then Exit;
  Fcliente := Avalue;
  edGrupo.Text := Fcliente.GRUPO;
  edSeq.Text := Fcliente.SEQ;
  edCota.Text := Fcliente.COTA;
  edNome.Text := Fcliente.NOME;
  dtAge.Date := Date;
  cboPrioridade.ItemIndex := 0;
end;

procedure Tfrmcom.Setcompromisso(Avalue: Icontrolleragenda);
begin
  //
  // alterando um compromisso existente
  //
  FIncluir := False;
  if Fcompromisso = Avalue then Exit;
  Fcompromisso := Avalue;
  edGrupo.Text := Fcompromisso.GRUPO;
  edSeq.Text := Fcompromisso.SEQ;
  edCota.Text := Fcompromisso.COTA;
  edNome.Text := Fcompromisso.NMCOTA;
  dtAge.Date := Fcompromisso.DTAGE;
  cboPrioridade.ItemIndex := Fcompromisso.PRIORIDADE;
  mmObs.Lines.LoadFromStream(Fcompromisso.OBS);
end;

end.
