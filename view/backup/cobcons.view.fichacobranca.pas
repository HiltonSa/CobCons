unit cobcons.view.fichacobranca;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, DBCtrls, ExtCtrls, Grids, DBGrids, ComCtrls,
  Menus, ActnList, DBDateTimePicker, DateTimePicker, EditBtn,
  Buttons, cobcons.controller.interfaces;

type

  { TfrmPen }

  TfrmPen = class(TForm)
    Al: Tactionlist;
    Cancelar: Taction;
    Cbotmv: Tcombobox;
    Dbedit6: Tdbedit;
    Dbedit7: Tdbedit;
    Dbedit14: Tdbedit;
    Dbedit15: Tdbedit;
    Dbedit16: Tdbedit;
    Dbedit17: Tdbedit;
    Dbedit8: Tdbedit;
    Dtvenc: Tdatetimepicker;
    Edadminist: Tedit;
    Edaquisicao: Tedit;
    Edoutros: Tedit;
    Edpnormal: Tedit;
    edAviso: Tedit;
    Edreserva: Tedit;
    Edtvalor: Tcalcedit;
    Gravar: Taction;
    Label11: Tlabel;
    Label12: Tlabel;
    Label13: Tlabel;
    Label14: Tlabel;
    Label15: Tlabel;
    Label5: Tlabel;
    Label51: Tlabel;
    Label53: Tlabel;
    Label54: Tlabel;
    Label6: Tlabel;
    Label7: Tlabel;
    Label8: Tlabel;
    dsCot: TDataSource;
    pnAcoes: TPanel;
    btIncPend: TSpeedButton;
    btExcPend: TSpeedButton;
    Pnback: Tpanel;
    Pntitulo: Tpanel;
    procedure edtValorExit(Sender: TObject);
    procedure Formcreate(Sender: Tobject);
    procedure CancelarExecute(Sender: TObject);
    procedure GravarExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
  private
    FAquisi: Double;
    FAdminist: Double;
    FReserva: Double;
    FOutros: Double;
    FPcNormal: Double;
    FPcRateio: Double;
    Fcliente: Icontrollercota;
    FPendencia: iControllerPendencia;
    procedure DesmembrarValor;
    procedure Setcliente(Avalue: Icontrollercota);
    { Private declarations }
  public
    { Public declarations }
    property Cliente: iControllerCota read FCliente write SetCliente;
  end;

var
  frmPen: TfrmPen;

implementation

uses cobcons.model.dm, cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util;


{$R *.lfm}

procedure Tfrmpen.Cancelarexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
end;

procedure Tfrmpen.Desmembrarvalor;
var
  fator : Double;
begin
  if edtValor.AsFloat>0 then begin
    FAquisi := 0;
    FAdminist := 0;
    FReserva := 0;
    FOutros := 0;
    FPcNormal := 0;
    FPcRateio := 0;
    case cboTmv.ItemIndex of
     0: begin
       fator := 1 + ((Fcliente.P_ADMINS + Fcliente.P_RESERV)/100);
       FAquisi := edtValor.AsFloat / fator;
       FAdminist := FAquisi * Fcliente.P_ADMINS / 100;
       FPcNormal := FAquisi / Fcliente.PRE_TABE * 100;
       FReserva := FAquisi * Fcliente.P_RESERV / 100;
     end;
     1: begin
       FAquisi := edtValor.AsFloat;
       FPcNormal := FAquisi / Fcliente.PRE_TABE * 100;
     end;
     2: begin
       fator := 1 + (Fcliente.P_ADMINS /100);
       FAquisi := edtValor.AsFloat / fator;
       FAdminist := FAquisi * Fcliente.P_ADMINS / 100;
       FPcRateio := FAquisi / Fcliente.PRE_TABE * 100;
     end;
     3,4: FOutros := edtValor.AsFloat;
    end;
    Edadminist.Text := Format('%.2n',[FAdminist]);
    Edaquisicao.Text := Format('%.2n',[FAquisi]);
    Edreserva.Text := Format('%.2n',[FReserva]);
    Edoutros.Text := Format('%.2n',[FOutros]);
    Edadminist.Text := Format('%.2n',[FAdminist]);
    Edpnormal.Text := Format('%.4n',[FPcNormal]);
    if FPcRateio > 0
    then Edpnormal.Text := Format('%.4n',[FPcRateio]);
  end;

end;

procedure Tfrmpen.Edtvalorexit(Sender: Tobject);
begin
  DesmembrarValor;
end;

procedure Tfrmpen.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  Pnback.Color := vEsquema.CorFundo;
  FPendencia:= TControllerFactory.New.Pendencia;
End;

procedure Tfrmpen.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_ESCAPE: Cancelar.Execute;
    VK_RETURN: SelectNext(ActiveControl,True,True);
  end;
end;

procedure Tfrmpen.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmpen.Gravarexecute(Sender: Tobject);
begin
  if edtValor.AsFloat = 0 then begin
    MostraAviso('Valor não pode ser zero!');
    edtValor.SetFocus;
  end
  else begin
    if ConfirmaMensagem('Confirma a gravação?') then begin
      FPendencia.GRUPO(Fcliente.GRUPO)
                .SEQ(Fcliente.SEQ)
                .COTA(Fcliente.COTA)
                .AVISO(edAviso.Text)
                .TIPO_MOV(Copy(cboTmv.Text,1,2))
                .D_VENCTO(Dtvenc.Date)
                .AG_COBRA(Fcliente.AG_COBRA)
                .PCNOR(FPcNormal)
                .P_RATEIO(FPcRateio)
                .F_AQUISI(FAquisi)
                .F_RESERV(FReserva)
                .ADMINIST(FAdminist)
                .OUTROS(FOutros)
                .Novo;
      ModalResult := mrOk;
    end;
  end;

end;

procedure Tfrmpen.Setcliente(Avalue: Icontrollercota);
begin
  if Fcliente = Avalue then Exit;
  Fcliente := Avalue;
  dsCot.DataSet := Fcliente.Dataset;
  edAviso.Text := FPendencia
                     .GRUPO(Fcliente.GRUPO)
                     .SEQ(Fcliente.SEQ)
                     .COTA(Fcliente.COTA)
                     .ProximoAviso;
  edtValor.AsFloat := 0;
  Dtvenc.Date := Date;
end;

end.
