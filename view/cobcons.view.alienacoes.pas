unit cobcons.view.alienacoes;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, DBGrids, cobcons.controller.interfaces,
  DB;

type

  { TfrmAli }

  TfrmAli = class(TForm)
    dsAli: TDataSource;
    grAli: Tdbgrid;
    nvAli: Tdbnavigator;
    pnBack: TPanel;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    Label10: TLabel;
    DBEdit10: TDBEdit;
    Label11: TLabel;
    DBEdit11: TDBEdit;
    Label12: TLabel;
    DBEdit12: TDBEdit;
    Label13: TLabel;
    DBEdit13: TDBEdit;
    Label14: TLabel;
    DBEdit14: TDBEdit;
    Label15: TLabel;
    DBEdit15: TDBEdit;
    Label16: TLabel;
    DBEdit16: TDBEdit;
    pnTitulo: TPanel;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    edDtAlienacao: TDBEdit;
    edSubstituicao: TDBEdit;
    edDtDesalienacao: TDBEdit;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    procedure Dsalidatachange(Sender: Tobject; Field: Tfield);
    procedure Formcreate(Sender: Tobject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
  private
    FBensAlienados: iControllerBemAlienado;
    procedure Setbensalienados(Avalue: Icontrollerbemalienado);
    { Private declarations }
  public
    { Public declarations }
    property BensAlienados: iControllerBemAlienado read FBensAlienados write SetBensAlienados;
  end;

var
  frmAli: TfrmAli;

implementation

uses cobcons.model.configura, cobcons.controller.util;

{$R *.lfm}

procedure Tfrmali.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_ESCAPE: Close;
  end;
end;

procedure Tfrmali.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmali.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnBack.Color := vEsquema.CorFundo;
  pnTitulo.Color := vEsquema.CorPainelAcoes;
End;

procedure Tfrmali.Dsalidatachange(Sender: Tobject; Field: Tfield);
begin
  edDtAlienacao.Text := RetornaDataString(dsAli.DataSet.FieldByName('DT_ALIE').AsDateTime);
  edSubstituicao.Text := RetornaDataString(dsAli.DataSet.FieldByName('DT_SUBST').AsDateTime);
  edDtDesalienacao.Text := RetornaDataString(dsAli.DataSet.FieldByName('DT_DESAL').AsDateTime);
  //if dsAli.DataSet.FieldByName('DT_ALIE').AsDateTime <= StrToDate('01/01/1801')
  //then edDtAlienacao.Text := '';
  //if dsAli.DataSet.FieldByName('DT_SUBST').AsDateTime <= StrToDate('01/01/1801')
  //then edSubstituicao.Text := '';
  //if dsAli.DataSet.FieldByName('DT_DESAL').AsDateTime <= StrToDate('01/01/1801')
  //then edDtDesalienacao.Text := '';
End;

procedure Tfrmali.Setbensalienados(Avalue: Icontrollerbemalienado);
begin
  if Fbensalienados = Avalue then Exit;
  Fbensalienados := Avalue;
  dsAli.DataSet := FBensAlienados.DataSet;
end;

end.
