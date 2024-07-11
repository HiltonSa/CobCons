unit cobcons.view.inadimplentes;

{$mode delphi}

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Buttons, ExtCtrls, DB, ActnList, ComCtrls,
  DBGrids, cobcons.controller.interfaces;

type

  { TFrmInadimplentes }

  TFrmInadimplentes = class(Tform)
    Dbedit7: Tdbedit;
    imprimir: Taction;
    Al: Tactionlist;
    Btnpesq: Tspeedbutton;
    Btnsair: Tspeedbutton;
    Cbocampo: Tcombobox;
    Dbedit1: Tdbedit;
    Dbedit2: Tdbedit;
    Dbedit3: Tdbedit;
    Dbedit4: Tdbedit;
    Dbedit5: Tdbedit;
    Dbedit6: Tdbedit;
    dsTt: Tdatasource;
    ds: Tdatasource;
    Grpesq: Tdbgrid;
    Label1: Tlabel;
    Label3: Tlabel;
    Label4: Tlabel;
    Label5: Tlabel;
    Label6: Tlabel;
    Label7: Tlabel;
    Label8: Tlabel;
    Label9: Tlabel;
    Nvpesq: Tdbnavigator;
    Panel2: Tpanel;
    Panel4: Tpanel;
    Panel5: Tpanel;
    tabenc: Taction;
    Pnacoes: Tpanel;
    Pnbackground: Tpanel;
    Pnrodape: Tpanel;
    Pntitulo: Tpanel;
    Sair: Taction;

      procedure Cbocamposelect(Sender: Tobject);
      procedure Formclose(Sender: Tobject; var Closeaction: Tcloseaction);
      procedure Formcreate(Sender: Tobject);
      procedure Formkeydown(Sender: Tobject; var Key: Word; Shift: Tshiftstate);
      procedure Grpesqdblclick(Sender: Tobject);
      procedure Imprimirexecute(Sender: Tobject);
      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
      procedure Sairexecute(Sender: Tobject);
      procedure Tabencexecute(Sender: Tobject);
  Private
    FExisteTotal: Boolean;
    FEmpresa: iControllerEmpresa;
    FTotal: iControllerTotal;
    FTotalGrupos : iControllerTotalGrupo;
    FInadimplentes : iControllerInadimplente;
    procedure AbrirFicha;
    procedure MensagemRodape(pMsg: String);
    procedure AbrirDadosTabulados;
  Public

  end;

var
  FrmInadimplentes: TFrmInadimplentes;

implementation

uses cobcons.model.configura, cobcons.model.dm, cobcons.controller.util,
  cobcons.controller.factory, cobcons.view.rel.inadimplentes,
  cobcons.view.rel.cotasinadimplentes;

{$R *.lfm}

{ TFrmInadimplentes }

procedure Tfrminadimplentes.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrminadimplentes.Sairexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
End;

procedure Tfrminadimplentes.Tabencexecute(Sender: Tobject);
begin
  if TabularEncerrados
  then AbrirDadosTabulados;
End;

procedure Tfrminadimplentes.Abrirficha;
begin
  if (Cbocampo.ItemIndex = 0) and (not ds.DataSet.EOF)
  then begin
    Self.Visible := False;
    AbrirFichaCota( ds.DataSet.FieldByName('Grupo').AsString,
                    ds.DataSet.FieldByName('Seq').AsString,
                    ds.DataSet.FieldByName('Cota').AsString);
    Self.Visible := True;
  end;
end;

procedure Tfrminadimplentes.Mensagemrodape(Pmsg: String);
begin
  Pnrodape.Caption := Pmsg;
end;

procedure Tfrminadimplentes.Abrirdadostabulados;
begin
  FInadimplentes.RetornaInadimplentes;
  FTotal.RetornaTotal;
  FTotalGrupos.ListaTodos;
  ds.DataSet := FInadimplentes.DataSet;
  dsTt.DataSet := FTotal.DataSet;
  Cbocampo.Enabled := True;
  imprimir.Enabled := True;
  MensagemRodape(Format('%d Consorciados Inadimplentes!', [ds.DataSet.RecordCount]));
end;

procedure Tfrminadimplentes.Formclose(Sender: Tobject;
  var Closeaction: Tcloseaction);
begin
  Closeaction := caFree;
  self := nil;
End;

procedure Tfrminadimplentes.Cbocamposelect(Sender: Tobject);
begin
  if Cbocampo.ItemIndex = 0
  then ds.DataSet := FInadimplentes.DataSet
  else ds.DataSet := FTotalGrupos.DataSet;
End;

procedure Tfrminadimplentes.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnRodape.Color := vEsquema.CorPainelRodape;
  pnBackGround.Color := vEsquema.CorFundo;
  FEmpresa:= TControllerFactory.New.Empresa.RecuperarEmpresa;
  FTotal := TControllerFactory.New.Total;
  FTotalGrupos := TControllerFactory.New.TotalGrupo;
  FInadimplentes := TControllerFactory.New.Inadimplente;
  FExisteTotal := FTotal.TabelaExiste;
  if not FExisteTotal
  then begin
    if ConfirmaMensagem('Precisa Tabular Encerrados')
    then FExisteTotal := TabularEncerrados
    else FExisteTotal := False;
  end;
  Cbocampo.Enabled := FExisteTotal;
  imprimir.Enabled := FExisteTotal;
  if FExisteTotal
  then AbrirDadosTabulados
  else MensagemRodape('Necessário Tabular Encerrados!');
End;

procedure Tfrminadimplentes.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused then AbrirFicha;
    VK_ESCAPE: Sair.Execute;
  end;
End;

procedure Tfrminadimplentes.Grpesqdblclick(Sender: Tobject);
begin
  AbrirFicha;
End;

procedure Tfrminadimplentes.Imprimirexecute(Sender: Tobject);
begin
  if Cbocampo.ItemIndex = 1
  then begin
    FormRelInadimplentes := TFormRelInadimplentes.Create(nil);
    try
      FormRelInadimplentes.dsPrs.DataSet := FEmpresa.DataSet;
      FormRelInadimplentes.Ds.DataSet := FTotalGrupos.DataSet;
      FormRelInadimplentes.rl.PreviewModal;
    finally
      FormRelInadimplentes.Free;
    end;
  end
  else begin
    FrmRelCotasInadimplentes := TFrmRelCotasInadimplentes.Create(nil);
    try
      FrmRelCotasInadimplentes.Dsprs.DataSet := FEmpresa.DataSet;
      FrmRelCotasInadimplentes.Ds.DataSet := FInadimplentes.DataSet;
      FrmRelCotasInadimplentes.dsttgru.DataSet := FTotal.DataSet;
      FrmRelCotasInadimplentes.Rl.PreviewModal;
    finally
      FrmRelCotasInadimplentes.Free;
    end;
  end;
End;

end.

