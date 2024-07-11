unit cobcons.view.pesquisacota;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBGrids, ComCtrls, DB, ExtCtrls,
  ActnList, DBCtrls, cobcons.controller.interfaces;

type

  { TfrmPesq }

  TfrmPesq = class(TForm)
    Btnpesq1: Tspeedbutton;
    posicao: Taction;
    Btnpesq: Tspeedbutton;
    Btnsair: Tspeedbutton;
    edGrupo: Tedit;
    edCota: Tedit;
    edCpf: Tedit;
    edNome: Tedit;
    edSeq: Tedit;
    Label1: Tlabel;
    Label2: Tlabel;
    Label3: Tlabel;
    PC: Tpagecontrol;
    Pnacoes: Tpanel;
    sair: Taction;
    Dspesq: Tdatasource;
    Grpesq: Tdbgrid;
    Lbltitulo: Tlabel;
    Nvpesq: Tdbnavigator;
    Panel2: Tpanel;
    Pnbackground: Tpanel;
    Pnrodape: Tpanel;
    Pntitulo: Tpanel;
    AL: TActionList;
    Pesq: TAction;
    tsGSC: TTabSheet;
    tsNome: TTabSheet;
    tsCpf: TTabSheet;
    procedure Edcotaexit(Sender: Tobject);
    procedure Edgrupoexit(Sender: Tobject);
    procedure Edseqexit(Sender: Tobject);
    procedure Formcreate(Sender: Tobject);
    procedure Grpesqdblclick(Sender: Tobject);
    procedure Pcchange(Sender: Tobject);
    procedure PesqExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
      procedure Posicaoexecute(Sender: Tobject);
    procedure Sairexecute(Sender: Tobject);
  private
    { Private declarations }
    FCota: iControllerCota;
    FDataset: TDataSet;
    procedure PesquisaNome;
    procedure PesquisaCpf;
    procedure PesquisaGRC;
    procedure MensagemRodape(pMsg: String);
    procedure AbrirFicha(Pgrupo, Pseq, Pcota: String);
    procedure AbrirLista;
    procedure LimparTab;
  public
    { Public declarations }
  end;

var
  frmPesq: TfrmPesq;

implementation

uses cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.lista, cobcons.view.posicaocota;


{$R *.lfm}

procedure Tfrmpesq.Sairexecute(Sender: Tobject);
begin
  Close;
End;

procedure Tfrmpesq.Pesquisanome;
begin
  if Length(Trim(edNome.Text)) > 0
  then begin
    FDataset := FCota.PesquisarNome(edNome.Text).Dataset;
    if FDataset.EOF
    then begin
      MensagemRodape(Format('%s não encontrado!',[edNome.Text]));
      LimparTab;
    end
    else begin
      MensagemRodape(Format('Encontrados %d para %s...',[FDataset.RecordCount, edNome.Text]));
      Dspesq.DataSet := FDataset;
      Grpesq.SetFocus;
    end;
  end;
end;

procedure Tfrmpesq.Pesquisacpf;
begin
  if Length(Trim(edCpf.Text)) > 0
  then begin
    FDataset := FCota.PesquisarCpfCnpj(edCpf.Text).Dataset;
    if FDataset.EOF
    then begin
      MensagemRodape(Format('%s não encontrado!',[edCpf.Text]));
      LimparTab;
    end
    else begin
      MensagemRodape(Format('Encontrados %d para %s...',[FDataset.RecordCount, edCpf.Text]));
      Dspesq.DataSet := FDataset;
      Grpesq.SetFocus;
    end;
  end;
end;

procedure Tfrmpesq.Pesquisagrc;
begin
  if (Length(Trim(edGrupo.Text)) > 0 ) and
     (Length(Trim(edCota.Text)) > 0) and
     (StrToIntDef(edCota.Text,0) > 0)
  then begin
    edSeq.Text := RetornarFormatado(edSeq.Text, tfInt2);
    edCota.Text := RetornarFormatado(edCota.Text, tfInt3);
    FDataset := FCota.PesquisarGrupoSeqCota(edGrupo.Text, edSeq.Text, edCota.Text).Dataset;
    if FDataset.EOF
    then begin
      MensagemRodape('Grupo/Seq/Cota não encontrado!');
      LimparTab;
    end
    else AbrirFicha(edGrupo.Text, edSeq.Text, edCota.Text);
  end;
end;

procedure Tfrmpesq.Mensagemrodape(Pmsg: String);
begin
  Pnrodape.Caption := Pmsg;
end;

procedure Tfrmpesq.Abrirficha(Pgrupo, Pseq, Pcota: String);
begin
  Self.Visible := False;
  AbrirFichaCota(Pgrupo, pSeq, pCota);
  Self.Visible := True;
end;

procedure Tfrmpesq.Abrirlista;
begin
  FrmLista := TFrmLista.Create(nil);
  try
    FrmLista.Gru := edGrupo.Text;
    if FrmLista.ShowModal = mrOK
    then begin
      edGrupo.Text := FrmLista.Gru;
      edSeq.Text := FrmLista.Seq;
      edCota.Text := FrmLista.Cota;
    end;
  finally
    FrmLista.Free;
  end;
end;

procedure Tfrmpesq.Limpartab;
begin
  MensagemRodape('');
  case PC.ActivePageIndex of
    0: begin                // grupo/cota
        edGrupo.Clear;
        edSeq.Clear;
        edCota.Clear;
        edGrupo.SetFocus;
    end;
    1: begin                // nome
        edNome.Clear;
        edNome.SetFocus;
    end;
    3: begin                // cpf
        edCpf.Clear;
        edCpf.SetFocus;
    end;
  end;
end;

procedure Tfrmpesq.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_F2: if (edGrupo.Focused) or (edCota.Focused) then AbrirLista;
    VK_RETURN: if (edCota.Focused) or (edCpf.Focused) or (edNome.Focused)
               then Pesq.Execute
               else if Grpesq.Focused
               then Grpesqdblclick(Grpesq)
               else SelectNext(ActiveControl,True,True);
    VK_ESCAPE: sair.Execute;
  end;
end;

procedure Tfrmpesq.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmpesq.Posicaoexecute(Sender: Tobject);
begin
  if not Dspesq.DataSet.EOF
  then ImprimirPosicaoCota( TControllerFactory.New.Cota.PesquisarGrupoSeqCota(
                            Dspesq.DataSet.FieldByName('GRUPO').AsString,
                            Dspesq.DataSet.FieldByName('SEQ').AsString,
                            Dspesq.DataSet.FieldByName('COTA').AsString));
End;

procedure Tfrmpesq.Pesqexecute(Sender: Tobject);
begin
  case pc.ActivePageIndex of
    0: PesquisaGRC;
    1: PesquisaNome;
    2: PesquisaCPF;
  end;
end;

procedure Tfrmpesq.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  FCota := TControllerFactory.New.Cota;
  Pntitulo.Color := vEsquema.CorPainelTitulo;
  Pnrodape.Color := vEsquema.CorPainelRodape;
  Pnbackground.Color := vEsquema.CorFundo;
  Pnacoes.Color := vEsquema.CorPainelAcoes;
  Self.Color := vEsquema.CorFormulario;
End;

procedure Tfrmpesq.Edgrupoexit(Sender: Tobject);
begin
  edGrupo.Text := Format('%.4d',[StrToIntDef(edGrupo.Text,0)]);
End;

procedure Tfrmpesq.Edcotaexit(Sender: Tobject);
begin
  edCota.Text := Format('%.3d',[StrToIntDef(edCota.Text,0)]);
End;

procedure Tfrmpesq.Edseqexit(Sender: Tobject);
begin
  edSeq.Text := Format('%.2d',[StrToIntDef(edSeq.Text,0)]);
End;

procedure Tfrmpesq.Grpesqdblclick(Sender: Tobject);
begin
  if not Dspesq.DataSet.EOF
  then AbrirFicha( Dspesq.DataSet.FieldByName('GRUPO').AsString,
                   Dspesq.DataSet.FieldByName('SEQ').AsString,
                   Dspesq.DataSet.FieldByName('COTA').AsString);
End;

procedure Tfrmpesq.Pcchange(Sender: Tobject);
begin
  LimparTab;
  if Assigned(Dspesq.DataSet)
  then Dspesq.DataSet.Close;
End;

end.
