unit cobcons.view.lista;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, SQLDB, Grids, DBGrids, ExtCtrls, DBCtrls,
  cobcons.controller.interfaces;

type
  { TFrmLista }

  TFrmLista = class(TForm)
    dsLista: TDataSource;
    grLista: Tdbgrid;
    nvLista: Tdbnavigator;
    Pnback: Tpanel;
    Pntitulo: Tpanel;
    procedure Formcreate(Sender: Tobject);
    procedure Formshow(Sender: Tobject);
    procedure grListaDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
  private
    FListaGrupo: Boolean;
    FGru: string;
    FGrupo: iControllerGrupo;
    FCota: iControllerCota;
    FSeq: String;
    FCot: String;
    procedure SetGru(const Value: string);
    procedure FecharForm(pEscolheu: Boolean);
    { Private declarations }
  public
    { Public declarations }
    property Gru: string read FGru write SetGru;
    property Seq: string read FSeq;
    property Cota: string read FCot;
  end;

var
  FrmLista: TFrmLista;

implementation

uses

  cobcons.model.dm, cobcons.model.configura, cobcons.controller.factory,
  cobcons.controller.util;

{$R *.lfm}

procedure Tfrmlista.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_RETURN: if grLista.Focused then FecharForm(True);
    VK_ESCAPE: FecharForm(False);
  end;
end;

procedure Tfrmlista.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmlista.Grlistadblclick(Sender: Tobject);
begin
  FecharForm(True);
end;

procedure Tfrmlista.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  Pntitulo.Color := vEsquema.CorPainelTitulo;
  Pnback.Color := vEsquema.CorFundo;
  FGrupo := TControllerFactory.New.Grupo;
  FCota := TControllerFactory.New.Cota;
End;

procedure Tfrmlista.Formshow(Sender: Tobject);
begin
  grLista.Columns[1].Visible := not FListaGrupo;
  grLista.Columns[2].Visible := not FListaGrupo;
  grLista.Columns[3].Visible := not FListaGrupo;
End;

procedure Tfrmlista.Setgru(const Value: String);
begin
  FGru := Value;
  if FGru = ''
  then begin
    FListaGrupo := True;
    fGrupo.RetornaListaGrupos;
    dsLista.DataSet := fGrupo.Dataset;
    Pntitulo.Caption := 'Grupos';
    Self.Width := 150;
  end
  else begin
    FListaGrupo := False;
    FCota.RetornarCotasGrupo(FGru);
    dsLista.DataSet := FCota.Dataset;
    Pntitulo.Caption := 'Cotas do Grupo: '+FGru;
    Self.Width := 460;
    if dsLista.DataSet.EOF
    then begin
      MostraAviso(Format('Cotas para %s não encontradas!',[FGru]));
      FecharForm(False);
    end;
  end;

end;

procedure Tfrmlista.Fecharform(Pescolheu: Boolean);
begin
  if Pescolheu
  then begin
    FGru := dsLista.DataSet.FieldByName('GRUPO').AsString;
    FSeq := '';
    FCot := '';
    if not FListaGrupo
    then begin
      FSeq := dsLista.DataSet.FieldByName('SEQ').AsString;
      FCot := dsLista.DataSet.FieldByName('COTA').AsString;
    end;
    ModalResult := mrOK;
  end
  else ModalResult := mrCancel;
end;


end.
