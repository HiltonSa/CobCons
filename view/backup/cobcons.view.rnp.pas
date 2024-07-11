unit cobcons.view.rnp;

{$mode delphi}

interface

uses
  Classes, Sysutils, DB, Forms, Controls, Graphics, Dialogs, ActnList, ExtCtrls,
  Buttons, StdCtrls, DBGrids, DBCtrls, cobcons.controller.interfaces, Windows;

type

  { TFrmRnp }

  TFrmRnp = class(Tform)
    btnPesq4: TSpeedButton;
    impDtBase: TAction;
    Btnpesq3: Tspeedbutton;
    check: Taction;
    Btnpesq2: Tspeedbutton;
    plan: Taction;
    Btnpesq1: Tspeedbutton;
    comparaSAG: Taction;
    Al: Tactionlist;
    Btnpesq: Tspeedbutton;
    Btnsair: Tspeedbutton;
    Cbocampo: Tcombobox;
    Dbedit1: Tdbedit;
    Dbedit2: Tdbedit;
    Dbedit3: Tdbedit;
    Dbedit6: Tdbedit;
    Dbedit7: Tdbedit;
    Dbedit8: Tdbedit;
    Ds: Tdatasource;
    Dstt: Tdatasource;
    Grpesq: Tdbgrid;
    Imprimir: Taction;
    Label1: Tlabel;
    Label10: Tlabel;
    Label3: Tlabel;
    Label4: Tlabel;
    Label5: Tlabel;
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
    procedure Checkexecute(Sender: Tobject);
    procedure Comparasagexecute(Sender: Tobject);
    procedure Formclose(Sender: Tobject; var Closeaction: Tcloseaction);
    procedure Formcreate(Sender: Tobject);
    procedure Formkeydown(Sender: Tobject; var Key: Word; Shift: Tshiftstate);
    procedure Grpesqdblclick(Sender: Tobject);
    procedure impDtBaseExecute(Sender: TObject);
    procedure Imprimirexecute(Sender: Tobject);
    procedure Planexecute(Sender: Tobject);
      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
      procedure Sairexecute(Sender: Tobject);
      procedure Tabencexecute(Sender: Tobject);
  Private

    FExisteTotal: Boolean;
    FEmpresa: iControllerEmpresa;
    FTotal: iControllerTotal;
    FTotalGrupos : iControllerTotalGrupo;
    FRnp : iControllerRnp;
    procedure AbrirFicha;
    procedure MensagemRodape(pMsg: String);
    procedure AbrirDadosTabulados;
    procedure PosicionarDataset(pInd: Integer);
  Public

  end;

var
  FrmRnp: TFrmRnp;

implementation

uses cobcons.model.configura, cobcons.model.dm, cobcons.model.planilha,
  cobcons.controller.util, cobcons.controller.factory,
  cobcons.view.rel.cotasrnp, cobcons.view.rel.gruposrnp,
  cobcons.view.comparasag, cobcons.view.checkrnp,
  cobcons.view.imprimernpdatabase;

{$R *.lfm}

{ TFrmRnp }

procedure Tfrmrnp.Formclose(Sender: Tobject; var Closeaction: Tcloseaction);
begin
  Closeaction := caFree;
  self := nil;
End;

procedure Tfrmrnp.Cbocamposelect(Sender: Tobject);
begin
  //Grpesq.FixedCols := 3;
  PosicionarDataset(Cbocampo.ItemIndex);
End;

procedure Tfrmrnp.Checkexecute(Sender: Tobject);
begin
  FrmCheckRnp := TFrmCheckRnp.Create(nil);
  try
    FrmCheckRnp.ShowModal;
  finally
    FrmCheckRnp.Free;
  end;
End;

procedure Tfrmrnp.Comparasagexecute(Sender: Tobject);
begin
  FrmComparaSAG := TFrmComparaSAG.Create(nil);
  try
    FrmComparaSAG.ShowModal;
  finally
    FrmComparaSAG.Free;
  end;
End;

procedure Tfrmrnp.Formcreate(Sender: Tobject);
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
  FRnp := TControllerFactory.New.RNP;
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

procedure Tfrmrnp.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_RETURN: if Grpesq.Focused then AbrirFicha;
    VK_ESCAPE: Sair.Execute;
  end;
End;

procedure Tfrmrnp.Grpesqdblclick(Sender: Tobject);
begin
  AbrirFicha;
End;

procedure TFrmRnp.impDtBaseExecute(Sender: TObject);
begin
  FrmImpRNPDataBase := TFrmImpRNPDataBase.Create(nil);
  try
    FrmImpRNPDataBase.ShowModal;
  finally
    FrmRelGruposRnp.Free;
  end;
end;

procedure Tfrmrnp.Imprimirexecute(Sender: Tobject);
begin
  if Cbocampo.ItemIndex < 3
  then begin
    TPlanilha.New.GerarPlanilha(Ds.DataSet, Format('Grupo%s.xls',[Ds.DataSet.FieldByName('GRUPO').AsString]));
    FrmRelCotasRnp := TFrmRelCotasRnp.Create(nil);
    try
      FrmRelCotasRnp.Dsprs.DataSet := FEmpresa.DataSet;
      FrmRelCotasRnp.Dsttgru.DataSet := FTotal.DataSet;
      FrmRelCotasRnp.rlRatFut.Visible := Cbocampo.ItemIndex <> 1;
      FrmRelCotasRnp.rlPcRateio.Visible := Cbocampo.ItemIndex <> 1;
      FrmRelCotasRnp.Ds.DataSet := Ds.DataSet;
      FrmRelCotasRnp.Rl.Title := Pntitulo.Caption;
      FrmRelCotasRnp.Rl.PreviewModal;
    finally
      FrmRelCotasRnp.Free;
    end;
  end
  else begin
    FrmRelGruposRnp := TFrmRelGruposRnp.Create(nil);
    try
      FrmRelGruposRnp.Dsprs.DataSet := FEmpresa.DataSet;
      FrmRelGruposRnp.Ds.DataSet := FTotalGrupos.DataSet;
      FrmRelGruposRnp.Rl.PreviewModal;
    finally
      FrmRelGruposRnp.Free;
    end;
  end;
End;

procedure Tfrmrnp.Planexecute(Sender: Tobject);
var
  vPlanilha: iModelPlanilha;
  vRnp: iControllerRnp;
  vCota: Boolean;
begin
  vPlanilha := TPlanilha.New;
  vCota := ds.DataSet.FindField('Cota') <> nil;
  if vCota
  then begin
    vPlanilha.GerarplanilhPagarRnp(Ds.DataSet, 'PagarRnpGrupo%sDataBase30Nov2021.xlsx', StrToDate('30/11/2021') );
  end
  else begin
    vRnp := TControllerFactory.New.RNP;
    PosicionarDataset(1);
    vPlanilha.GerarPlanilhaCcDev(Ds.DataSet, 'RecomposicaoRnpGrupo%s.xlsx', StrToDate('30/06/2021'), vRnp);
  end;
End;

procedure Tfrmrnp.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmrnp.Sairexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
End;

procedure Tfrmrnp.Tabencexecute(Sender: Tobject);
begin
  if TabularEncerrados
  then AbrirDadosTabulados;
End;

procedure Tfrmrnp.Abrirficha;
var
  vCota: Boolean;
begin
  vCota := ds.DataSet.FindField('Cota') <> nil;
  if vCota
  then begin
    Self.Visible := False;
    AbrirFichaCota( ds.DataSet.FieldByName('Grupo').AsString,
                    ds.DataSet.FieldByName('Seq').AsString,
                    ds.DataSet.FieldByName('Cota').AsString);
    Self.Visible := True;
  end
  else PosicionarDataset(4);
end;

procedure Tfrmrnp.Mensagemrodape(Pmsg: String);
begin
  Pnrodape.Caption := Pmsg;
end;

procedure Tfrmrnp.Abrirdadostabulados;
begin
  FTotal.RetornaTotal;
  FTotalGrupos.ListaTodos;
  Cbocampo.Enabled := True;
  imprimir.Enabled := True;
  PosicionarDataset(3);
  //Grpesq.FixedCols := 3;
end;

procedure Tfrmrnp.Posicionardataset(Pind: Integer);
begin
  Dstt.DataSet := FTotal.DataSet;
  case Pind of
    0: begin
      ds.DataSet := FRnp.RetornaRnp.DataSet;
      Pntitulo.Caption := 'Recursos Não Procurados - Todos';
    end;
    1: begin
      ds.DataSet := FRnp.RetornaSomenteRnp.DataSet;
      Pntitulo.Caption := 'Recursos Não Procurados - Data Base: 30/06/2021';
    end;
    2: begin
      ds.DataSet := FRnp.RetornaRnpRateiosFuturos.DataSet;
      Pntitulo.Caption := 'RNP Rateio Futuro';
    end;
    3: begin
      ds.DataSet := FTotalGrupos.DataSet;
      Pntitulo.Caption := 'Recursos Não Procurados - Grupos';
      //Grpesq.FixedCols := 1;
    end;
    4: begin
      ds.DataSet := FRnp.RetornaRnpGrupo(Ds.DataSet.FieldByName('GRUPO').AsString).DataSet;
      Pntitulo.Caption := 'Recursos Não Procurados - Grupo: '+Ds.DataSet.FieldByName('GRUPO').AsString;
      //Grpesq.FixedCols := 1;
    end;
  end;
  MensagemRodape(Format('%d registro(s) encontrado(s)!', [ds.DataSet.RecordCount]));
end;

end.

