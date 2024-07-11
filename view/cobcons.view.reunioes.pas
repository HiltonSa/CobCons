unit cobcons.view.reunioes;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ExtCtrls, Grids, DBGrids, StdCtrls, DBCtrls,
  cobcons.controller.interfaces;

type

  { TfrmReu }

  TfrmReu = class(TForm)
    Edgrupo: Tedit;
    edDuracao: Tedit;
    grReu: TDBGrid;
    Label51: Tlabel;
    Label53: Tlabel;
    nvReu: Tdbnavigator;
    dsReu: TDataSource;
    pnBack: Tpanel;
    Pntitulo: Tpanel;
    procedure Formactivate(Sender: Tobject);
    procedure Formcreate(Sender: Tobject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
  private
    FReuniao: iControllerReuniao;
    Fgrupo: String;
    procedure Setgrupo(Avalue: String);
    { Private declarations }
  public
    { Public declarations }
    property Grupo: string read FGrupo write SetGrupo;
  end;

var
  frmReu: TfrmReu;

implementation

uses cobcons.model.dm, cobcons.model.configura, cobcons.controller.factory;

{$R *.lfm}

procedure Tfrmreu.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
     if Key = VK_ESCAPE then frmReu.Close;
end;

procedure Tfrmreu.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmreu.Formactivate(Sender: Tobject);
var
  vGrupo: iControllerGrupo;
begin
  vGrupo := TControllerFactory.New.Grupo.RetornaGrupo(Fgrupo);
  Edgrupo.Text := vGrupo.GRUPO;
  edDuracao.Text := vGrupo.PLA_PADR;
  FReuniao.RetornaReuniaoGrupo(Fgrupo);
  dsReu.DataSet := FReuniao.Dataset;
End;

procedure Tfrmreu.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnBack.Color := vEsquema.CorFundo;
  FReuniao := TControllerFactory.New.Reuniao;
End;

procedure Tfrmreu.Setgrupo(Avalue: String);
begin
  Fgrupo := Avalue;
end;

end.
