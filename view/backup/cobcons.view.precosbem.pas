unit cobcons.view.precosbem;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ExtCtrls, Grids, DBGrids, StdCtrls, DBCtrls,
  cobcons.controller.interfaces;

type

  { TfrmPre }

  TfrmPre = class(TForm)
    edDcTpBem: Tedit;
    edBem: Tedit;
    edDcFabBem: Tedit;
    Grreu: Tdbgrid;
    Label51: Tlabel;
    Label53: Tlabel;
    Label54: Tlabel;
    Nvreu: Tdbnavigator;
    pnBack: TPanel;
    dsPre: TDataSource;
    Pntitulo: Tpanel;
    procedure Formactivate(Sender: Tobject);
    procedure Formcreate(Sender: Tobject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
  private
    FPrecos: iControllerPrecoBem;
    Fbem: String;
    Ffilial: String;
    procedure Setbem(Avalue: String);
    procedure Setfilial(Avalue: String);
    { Private declarations }
  public
    { Public declarations }
    property Bem: string read FBem write SetBem;
    property Filial: string read FFilial write SetFilial;
  end;

var
  frmPre: TfrmPre;

implementation

uses cobcons.model.configura, cobcons.controller.factory;

{$R *.lfm}

procedure Tfrmpre.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
     if Key = VK_ESCAPE then frmPre.Close;
end;

procedure Tfrmpre.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmpre.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnBack.Color := vEsquema.CorFundo;
  FPrecos := TControllerFactory.New.PrecoBem;
End;

procedure Tfrmpre.Formactivate(Sender: Tobject);
var
  vBem: iControllerBem;
begin
  vBem := TControllerFactory.New.Bem;
  vBem.RetornaBem(Fbem);
  edDcTpBem.Text := vBem.DCTIPOBEM;
  edDcFabBem.Text := vBem.DCFABBEM;
  edBem.Text := vBem.DESCRIC;
  FPrecos.RetornaPrecoBem(Fbem, Ffilial);
  dsPre.DataSet := FPrecos.Dataset;
End;

procedure Tfrmpre.Setbem(Avalue: String);
begin
  Fbem := Avalue;
end;

procedure Tfrmpre.Setfilial(Avalue: String);
begin
  Ffilial := Avalue;
end;

end.
