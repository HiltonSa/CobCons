unit cobcons.view.recomposicaosaldosrnp;

{$mode delphi}

interface

uses
  Classes, Sysutils, DB, Forms, Controls, Graphics, Dialogs, ActnList, ExtCtrls, Windows,
  Buttons, StdCtrls, DBGrids, DBCtrls, cobcons.controller.interfaces;

type

  { TFrmRecomposicaoSaldos }

  TFrmRecomposicaoSaldos = class(Tform)
    Al: Tactionlist;
    Btnpesq: Tspeedbutton;
    Btnsair: Tspeedbutton;
    Cbocampo: Tcombobox;
    Ds: Tdatasource;
    edDtRec: Tedit;
    edVlrRec: Tedit;
    edQtdGrupos: Tedit;
    edQtdCotas: Tedit;
    edVlrSia: Tedit;
    edVlrDif: Tedit;
    Grpesq: Tdbgrid;
    Imprimir: Taction;
    Label1: Tlabel;
    Label3: Tlabel;
    Label5: Tlabel;
    Label6: Tlabel;
    Label7: Tlabel;
    Label8: Tlabel;
    Label9: Tlabel;
    Nvpesq: Tdbnavigator;
    Panel2: Tpanel;
    Panel4: Tpanel;
    Panel5: Tpanel;
    Pnacoes: Tpanel;
    Pnbackground: Tpanel;
    Pnrodape: Tpanel;
    Pntitulo: Tpanel;
    Sair: Taction;
    Tabenc: Taction;
    procedure Cbocamposelect(Sender: Tobject);
    procedure Formclose(Sender: Tobject; var Closeaction: Tcloseaction);
    procedure Formcreate(Sender: Tobject);
    procedure Formkeydown(Sender: Tobject; var Key: Word; Shift: Tshiftstate);
    procedure Grpesqdblclick(Sender: Tobject);
    procedure Imprimirexecute(Sender: Tobject);

      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
    procedure Sairexecute(Sender: Tobject);
  Private

    FRnp : iControllerRnp;
    FTotalQtdGrupo,
    FTotalQtd: Integer;
    FTotalSag,
    FTotalSiacon: Double;

    procedure MensagemRodape(pMsg: String);
    procedure AbrirFicha;
    procedure PopularCboCampo;
    procedure PosicionarGrupo(pGrupo: String);
    procedure MostraTotais(pQtCotas: Integer; pVlrRec, pVlrSia: Double);

  Public

  end;

var
  FrmRecomposicaoSaldos: TFrmRecomposicaoSaldos;

const
  TODOS_GRUPOS = 'Todos Grupos';
  TODAS_COTAS = 'Todas Cotas';

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.rel.recomposicaosaldosrnp,
  cobcons.view.rel.recomposicaosaldosrnpsint,
  cobcons.view.rel.recomposicaosaldosrnpcotas;

{$R *.lfm}

{ TFrmRecomposicaoSaldos }

procedure Tfrmrecomposicaosaldos.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
  vEmpresa: iControllerEmpresa;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnRodape.Color := vEsquema.CorPainelRodape;
  pnBackGround.Color := vEsquema.CorFundo;
  vEmpresa:= TControllerFactory.New.Empresa.RecuperarEmpresa;
  FRnp := TControllerFactory.New.RNP;
  edDtRec.Text := FormatDateTime('dd/mm/yyyy', vEmpresa.DTRECSLDRNP);
  PopularCboCampo;
  PosicionarGrupo(TODOS_GRUPOS);
End;

procedure Tfrmrecomposicaosaldos.Formclose(Sender: Tobject;
  var Closeaction: Tcloseaction);
begin
  Closeaction := caFree;
  self := nil;
End;

procedure Tfrmrecomposicaosaldos.Cbocamposelect(Sender: Tobject);
begin
  PosicionarGrupo(Cbocampo.Text);
End;

procedure Tfrmrecomposicaosaldos.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused then AbrirFicha;
    VK_ESCAPE: Sair.Execute;
  end;
End;

procedure Tfrmrecomposicaosaldos.Grpesqdblclick(Sender: Tobject);
begin
  AbrirFicha;
End;

procedure Tfrmrecomposicaosaldos.Imprimirexecute(Sender: Tobject);
var
  vTipoRel: Integer;
begin
  vTipoRel := Cbocampo.ItemIndex;
  case vTipoRel of
    // sintetico
    0: begin
        FrmRecSldSint := TFrmRecSldSint.Create(Nil);
        try
          FrmRecSldSint.Ds.DataSet := Ds.DataSet;
          FrmRecSldSint.Dsprs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
          FrmRecSldSint.Rl.Title := 'RECOMPOSIÇÃO DE SALDOS RNP DATA BASE '+edDtRec.Text;
          FrmRecSldSint.Rl.PreviewModal;
        finally
          FrmRecSldSint.Free;
        end;
    end;
    // analitico todas as cotas
    1: begin
      FrmRelRecomposicaoRnpCotas := TFrmRelRecomposicaoRnpCotas.Create(Nil);
      try
        FrmRelRecomposicaoRnpCotas.Ds.DataSet := Ds.DataSet;
        //FrmRelRecomposicaoRnpCotas.Ds.DataSet := FRnp.RetornaRecomposicaoSaldosGrupo('0226').DataSet;
        FrmRelRecomposicaoRnpCotas.Dsprs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
        //FrmRelRecomposicaoRnpCotas.lbTotalGeral.Caption := Format('%.2n',[FTotalSag]);
        FrmRelRecomposicaoRnpCotas.Rl.Title := 'RECOMPOSIÇÃO DE SALDOS RNP DATA BASE '+edDtRec.Text;
        FrmRelRecomposicaoRnpCotas.Rl.PreviewModal;
      finally
        FrmRelRecomposicaoRnpCotas.Free;
      end;
    end;
    // analitico por grupo
    else begin
      FrmRelRecomposicaoRnp := TFrmRelRecomposicaoRnp.Create(Nil);
      try
        FrmRelRecomposicaoRnp.Ds.DataSet := Ds.DataSet;
        FrmRelRecomposicaoRnp.Dsprs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
        FrmRelRecomposicaoRnp.Rl.Title := 'RECOMPOSIÇÃO DE SALDOS RNP DATA BASE '+edDtRec.Text;
        FrmRelRecomposicaoRnp.Rl.PreviewModal;
      finally
        FrmRelRecomposicaoRnp.Free;
      end;
    end;
  end;
End;

procedure Tfrmrecomposicaosaldos.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmrecomposicaosaldos.Sairexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
End;

procedure Tfrmrecomposicaosaldos.Mensagemrodape(Pmsg: String);
begin
  Pnrodape.Caption := Pmsg;
end;

procedure Tfrmrecomposicaosaldos.Abrirficha;
begin
  if (Cbocampo.ItemIndex > 0)
  then begin
    if not ds.DataSet.EOF
    then begin
      Self.Visible := False;
      AbrirFichaCota( ds.DataSet.FieldByName('Grupo').AsString,
                      ds.DataSet.FieldByName('Seq').AsString,
                      ds.DataSet.FieldByName('Cota').AsString);
      Self.Visible := True;
    end;
  end
  else begin
      Cbocampo.Text := ds.DataSet.FieldByName('Grupo').AsString;
      PosicionarGrupo(ds.DataSet.FieldByName('Grupo').AsString);
  end;
end;

procedure Tfrmrecomposicaosaldos.Popularcbocampo;
var
  vDsTot: TDataSet;
begin
  FTotalSag := 0;
  FTotalSiacon := 0;
  FTotalQtd := 0;
  Cbocampo.Clear;
  Cbocampo.Items.Add(TODOS_GRUPOS);
  Cbocampo.Items.Add(TODAS_COTAS);
  vDsTot := TControllerFactory.New.RNP.TotalizaRecomposicaoRnp.DataSet;
  while not vDsTot.EOF do
  begin
    FTotalSiacon := FTotalSiacon + vDsTot.FieldByName('SIAGRU').AsFloat;
    FTotalSag := FTotalSag + vDsTot.FieldByName('RECGRU').AsFloat;
    FTotalQtd := FTotalQtd + vDsTot.FieldByName('QTDCOT').AsInteger;
    Inc(FTotalQtdGrupo);
    Cbocampo.Items.Add(vDsTot.FieldByName('GRUPO').AsString);
    vDsTot.Next;
  end;
  Cbocampo.ItemIndex := 0;
end;

procedure Tfrmrecomposicaosaldos.Posicionargrupo(Pgrupo: String);
var
  vDsTot: TDataSet;
begin
  if Pgrupo = TODOS_GRUPOS
  then begin
    MostraTotais(FTotalQtd, FTotalSag, FTotalSiacon);
    ds.DataSet := FRnp.TotalizaRecomposicaoRnp.DataSet;
  end
  else if Pgrupo = TODAS_COTAS
  then begin
    MostraTotais(FTotalQtd, FTotalSag, FTotalSiacon);
    ds.DataSet := FRnp.RetornaRecomposicaoSaldosTodos.DataSet;
  end
  else begin
    vDsTot := TControllerFactory.New.RNP.TotalizaRecomposicaoRnp.DataSet;
    ds.DataSet := FRnp.RetornaRecomposicaoSaldosGrupo(Pgrupo).DataSet;
    vDsTot.First;
    if vDsTot.Locate('GRUPO',Pgrupo,[])
    then MostraTotais( vDsTot.FieldByName('QTDCOT').AsInteger,
                       vDsTot.FieldByName('RECGRU').AsFloat,
                       vDsTot.FieldByName('SIAGRU').AsFloat)
    else MostraErro(Pgrupo+' não encontrado em totais ');
  end;

  MensagemRodape(Format('%d registro(s) encontrado(s)!', [ds.DataSet.RecordCount]));
end;

procedure Tfrmrecomposicaosaldos.Mostratotais(Pqtcotas: Integer; Pvlrrec, Pvlrsia: Double);
begin
  edQtdGrupos.Text := Format('%.4d',[FTotalQtdGrupo]);
  edQtdCotas.Text := Format('%.4d',[Pqtcotas]);
  edVlrRec.Text := Format('%.2n',[Pvlrrec]);
  edVlrSia.Text := Format('%.2n',[Pvlrsia]);
  edVlrDif.Text := Format('%.2n',[Pvlrrec - Pvlrsia]);
end;

end.

