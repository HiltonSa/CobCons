unit cobcons.view.comissaopermanencia;

{$mode delphi}

interface

uses
  Classes, Sysutils, DB, Forms, Controls, Graphics, Dialogs, ActnList, ExtCtrls,
  Buttons, StdCtrls, DBGrids, DBCtrls, ComCtrls, DateTimePicker, DateUtils,
  cobcons.controller.interfaces, HNSCombox, Windows;

type

  { TFrmComissaoPermanencia }

  TFrmComissaoPermanencia = class(Tform)
    apagar: Taction;
    imprimir: TAction;
    btnImprimir: Tspeedbutton;
    btnVer: Tspeedbutton;
    ver: Taction;
    btnNova: Tspeedbutton;
    btnSair: Tspeedbutton;
    Al: Tactionlist;
    Ds: Tdatasource;
    Grpesq: Tdbgrid;
    Nvpesq: Tdbnavigator;
    Panel4: Tpanel;
    Pnacoes: Tpanel;
    Pnbackground: Tpanel;
    Pnrodape: Tpanel;
    Pntitulo: Tpanel;
    Sair: Taction;
    nova: Taction;
    procedure Apagarexecute(Sender: Tobject);
    procedure Imprimirexecute(Sender: Tobject);
    procedure novaExecute(Sender: Tobject);
    procedure Formclose(Sender: Tobject; var Closeaction: Tcloseaction);
    procedure Formcreate(Sender: Tobject);
    procedure Formkeydown(Sender: Tobject; var Key: Word; Shift: Tshiftstate);
    procedure Grpesqdblclick(Sender: Tobject);

    procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
    procedure Sairexecute(Sender: Tobject);
    procedure Verexecute(Sender: Tobject);
  Private
    FComissaoPermanencia : iControllerComissaoPermanencia;
    procedure AbrirFicha;
    procedure MensagemRodape(pMsg: String);
    procedure AtualizarDataset;
  Public

  end;

var
  FrmComissaoPermanencia: TFrmComissaoPermanencia;

implementation

uses cobcons.model.configura, cobcons.controller.util,
  cobcons.controller.factory, cobcons.view.novacomissaopermanencia,
  cobcons.view.vercomissaopermanencia;

{$R *.lfm}

{ TFrmComissaoPermanencia }

procedure Tfrmcomissaopermanencia.Formclose(Sender: Tobject;
  var Closeaction: Tcloseaction);
begin
  Closeaction := caFree;
  self := nil;
End;

procedure Tfrmcomissaopermanencia.Novaexecute(Sender: Tobject);
begin
  FrmNovaComPerm := TFrmNovaComPerm.Create(nil);
  try
    if FrmNovaComPerm.ShowModal = mrOK
    then AtualizarDataset;
  finally
    FrmNovaComPerm.Free;
  end;
End;

procedure Tfrmcomissaopermanencia.Imprimirexecute(Sender: Tobject);
begin
  if not Ds.DataSet.EOF
  then ImprimirComissaoPermanencia(Ds.DataSet.FieldByName('CODIGO').AsInteger);
End;

procedure Tfrmcomissaopermanencia.Apagarexecute(Sender: Tobject);
begin
  if not Ds.DataSet.EOF
  then begin
    Ds.DataSet.First;
    if ConfirmaMensagem('Exclui o Cálculo de '+Ds.DataSet.FieldByName('DTEXE').AsString)
    then begin
      FComissaoPermanencia
           .AGENTE(Ds.DataSet.FieldByName('AGENTE').AsString)
           .DOCUMENTO(Ds.DataSet.FieldByName('DOCUMENTO').AsString)
           .ExcluirComissaoPermanencia(Ds.DataSet.FieldByName('CODIGO').AsInteger);
      AtualizarDataset;
    end;
  end;
End;

procedure Tfrmcomissaopermanencia.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnRodape.Color := vEsquema.CorPainelRodape;
  pnBackGround.Color := vEsquema.CorFundo;
  FComissaoPermanencia := TControllerFactory.New.ComissaoPermanencia;
  if not FComissaoPermanencia.TabelaExiste
  then FComissaoPermanencia.CriarTabela;
  AtualizarDataset;
End;

procedure Tfrmcomissaopermanencia.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused then AbrirFicha else SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
End;

procedure Tfrmcomissaopermanencia.Grpesqdblclick(Sender: Tobject);
begin
  AbrirFicha;
End;

procedure Tfrmcomissaopermanencia.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmcomissaopermanencia.Sairexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
End;

procedure Tfrmcomissaopermanencia.Verexecute(Sender: Tobject);
begin
  AbrirFicha;
End;

procedure Tfrmcomissaopermanencia.Abrirficha;
begin
  if not ds.DataSet.EOF
  then begin
    FrmVerComissaoPermanencia := TFrmVerComissaoPermanencia.Create(nil);
    try
      FrmVerComissaoPermanencia.CmPer := Ds.DataSet.FieldByName('CODIGO').AsInteger;
      FrmVerComissaoPermanencia.ShowModal;
    finally
      FrmVerComissaoPermanencia.Free;
    end;
  end;
end;

procedure Tfrmcomissaopermanencia.Mensagemrodape(Pmsg: String);
begin
  Pnrodape.Caption := Pmsg;
end;

procedure Tfrmcomissaopermanencia.Atualizardataset;
begin
  Ds.DataSet := FComissaoPermanencia.ListarComissoes.DataSet;
  MensagemRodape(Format('%d Cálculos Listados', [Ds.DataSet.RecordCount]));
end;

end.

