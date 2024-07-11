unit cobcons.view.vercomissaopermanencia;

{$mode delphi}

interface

uses
  Classes, Sysutils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ActnList, DBGrids, DBCtrls, StdCtrls, ComCtrls, Windows,
  cobcons.controller.interfaces, DateTimePicker;

type

  { TFrmVerComissaoPermanencia }

  TFrmVerComissaoPermanencia = class(Tform)
    Al: Tactionlist;
    Btnpesq: Tspeedbutton;
    Btnsair: Tspeedbutton;
    Dbedit2: Tdbedit;
    Dbedit3: Tdbedit;
    Dbedit4: Tdbedit;
    Dbedit5: Tdbedit;
    Dbedit6: Tdbedit;
    Dbedit7: Tdbedit;
    Dbedit8: Tdbedit;
    Dbedit9: Tdbedit;
    dsCp: Tdatasource;
    Ds: Tdatasource;
    Grpesq: Tdbgrid;
    Imprimir: Taction;
    Label1: Tlabel;
    Label2: Tlabel;
    Label3: Tlabel;
    Label4: Tlabel;
    Label5: Tlabel;
    Label6: Tlabel;
    Label7: Tlabel;
    Label8: Tlabel;
    Nvpesq: Tdbnavigator;
    Panel2: Tpanel;
    Panel4: Tpanel;
    Pnacoes: Tpanel;
    Pnbackground: Tpanel;
    Pntitulo: Tpanel;
    Sair: Taction;
    procedure Formclose(Sender: Tobject; var Closeaction: Tcloseaction);
    procedure Formcreate(Sender: Tobject);
    procedure Formkeydown(Sender: Tobject; var Key: Word; Shift: Tshiftstate);
    procedure Grpesqdblclick(Sender: Tobject);
    procedure Imprimirexecute(Sender: Tobject);

      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
      procedure Sairexecute(Sender: Tobject);
  Private
    Fcmper: Integer;
    FComissao: iControllerComissaoPermanencia;
    FItens: iControllerItemComissaoPermanencia;
    procedure Setcmper(Avalue: Integer);
    procedure AbrirFicha;

  Public
    property CmPer: Integer read FCmPer write SetCmPer;

  end;

var
  FrmVerComissaoPermanencia: TFrmVerComissaoPermanencia;

implementation

uses cobcons.controller.factory, cobcons.controller.util,
  cobcons.model.configura;

{$R *.lfm}

{ TFrmVerComissaoPermanencia }

procedure Tfrmvercomissaopermanencia.Formclose(Sender: Tobject;
  var Closeaction: Tcloseaction);
begin
  Closeaction := caFree;
  self := nil;
End;

procedure Tfrmvercomissaopermanencia.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnBackGround.Color := vEsquema.CorFundo;
  FComissao := TControllerFactory.New.ComissaoPermanencia;
  FItens := TControllerFactory.New.ItemComissaoPermanencia;
End;

procedure Tfrmvercomissaopermanencia.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused then AbrirFicha else SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
End;

procedure Tfrmvercomissaopermanencia.Grpesqdblclick(Sender: Tobject);
begin
  AbrirFicha;
End;

procedure Tfrmvercomissaopermanencia.Imprimirexecute(Sender: Tobject);
begin
  ImprimirComissaoPermanencia(Fcmper);
End;

procedure Tfrmvercomissaopermanencia.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmvercomissaopermanencia.Sairexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
End;

procedure Tfrmvercomissaopermanencia.Setcmper(Avalue: Integer);
begin
  if Fcmper = Avalue then Exit;
  Fcmper := Avalue;
  FComissao.ListarPorCodigo(Fcmper);
  FItens.ListarItensComissao(Fcmper);
  dsCp.DataSet := FComissao.DataSet;
  Ds.DataSet := FItens.DataSet;
end;

procedure Tfrmvercomissaopermanencia.Abrirficha;
begin
  if not ds.DataSet.EOF
  then begin
    Self.Visible := False;
    AbrirFichaCota( ds.DataSet.FieldByName('Grupo').AsString,
                    ds.DataSet.FieldByName('Seq').AsString,
                    ds.DataSet.FieldByName('Cota').AsString);
    Self.Visible := True;
  end;
end;

end.

