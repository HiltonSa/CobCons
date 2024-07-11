unit cobcons.view.grupos;

{$mode delphi}

interface

uses
  Classes, Windows, Sysutils, DB, Forms, Controls, Graphics, Dialogs, ActnList,
  ExtCtrls, Buttons, DBGrids, DBCtrls, cobcons.controller.interfaces;

type

  { TFrmGrupos }

  TFrmGrupos = class(Tform)
    Al: Tactionlist;
    Btnimprimir: Tspeedbutton;
    Btnnova: Tspeedbutton;
    Btnsair: Tspeedbutton;
    Btnver: Tspeedbutton;
    Ds: Tdatasource;
    Grpesq: Tdbgrid;
    Imprimir: Taction;
    Nova: Taction;
    Nvpesq: Tdbnavigator;
    Panel4: Tpanel;
    Pnacoes: Tpanel;
    Pnbackground: Tpanel;
    Pnrodape: Tpanel;
    Pntitulo: Tpanel;
    Sair: Taction;
    Ver: Taction;
    procedure Formclose(Sender: Tobject; var Closeaction: Tcloseaction);
    procedure Formcreate(Sender: Tobject);
    procedure Formkeydown(Sender: Tobject; var Key: Word; Shift: Tshiftstate);
    procedure Grpesqdblclick(Sender: Tobject);

      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
      procedure Sairexecute(Sender: Tobject);
  Private
    FGrupo: iControllerGrupo;
    procedure AbrirFicha;
    procedure MensagemRodape(pMsg: String);
    procedure AtualizarDataset;
  Public

  end;

var
  FrmGrupos: TFrmGrupos;

implementation

uses cobcons.controller.factory, cobcons.model.configura,
  cobcons.view.fichagrupo;

{$R *.lfm}

{ TFrmGrupos }

procedure Tfrmgrupos.Formclose(Sender: Tobject; var Closeaction: Tcloseaction);
begin
  Closeaction := caFree;
  self := nil;
End;

procedure Tfrmgrupos.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnRodape.Color := vEsquema.CorPainelRodape;
  pnBackGround.Color := vEsquema.CorFundo;
  FGrupo := TControllerFactory.New.Grupo;
  AtualizarDataset;
End;

procedure Tfrmgrupos.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused then AbrirFicha else SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
End;

procedure Tfrmgrupos.Grpesqdblclick(Sender: Tobject);
begin
  AbrirFicha;
End;

procedure Tfrmgrupos.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmgrupos.Sairexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
End;

procedure Tfrmgrupos.Abrirficha;
var
  vGrupo: iControllerTotalGrupo;
begin
  vGrupo := TControllerFactory.New.TotalGrupo;
  vGrupo := vGrupo.RetornaGrupo(Ds.DataSet.FieldByName('GRUPO').AsString);
  FrmFichaGrupo := TFrmFichaGrupo.Create(nil);
  try
    FrmFichaGrupo.Grupo := vGrupo;
    if FrmFichaGrupo.ShowModal = mrOK
    then Ds.DataSet := FGrupo.RetornaListaGrupos.Dataset;
  finally
    FrmFichaGrupo.Free;
  end;

end;

procedure Tfrmgrupos.Mensagemrodape(Pmsg: String);
begin
  Pnrodape.Caption := Pmsg;
end;

procedure Tfrmgrupos.Atualizardataset;
begin
  Ds.DataSet := FGrupo.RetornaListaGrupos.DataSet;
  MensagemRodape(Format('%d Grupos Listados', [Ds.DataSet.RecordCount]));
end;

end.

