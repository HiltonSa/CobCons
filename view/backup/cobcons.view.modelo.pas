unit cobcons.view.modelo;

{$MODE Delphi}

interface

uses

  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Buttons, ExtCtrls, DB, ActnList, ComCtrls,
  DBGrids;

type

  { TfrmMod }

  TfrmMod = class(TForm)
    AL: TActionList;
    btnPesq: Tspeedbutton;
    cboCampo: Tcombobox;
    nvPesq: Tdbnavigator;
    Label2: Tlabel;
    lblTitulo: Tlabel;
    pnBackGround: Tpanel;
    pnRodape: Tpanel;
    pnTitulo: Tpanel;
    Pesquisa: TAction;
    Novo: TAction;
    Altera: TAction;
    Exclui: TAction;
    Sair: TAction;
    dsPesq: TDataSource;
    pnAcoes: TPanel;
    btnSair: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnIncluir: TSpeedButton;
    grPesq: TDBGrid;
    Panel2: TPanel;
    Label1: TLabel;
    txtPesq: TEdit;
    procedure Formclose(Sender: Tobject; var Closeaction: Tcloseaction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Grpesqcellclick(Column: Tcolumn);
    procedure SairExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AtivarAcoes(pAtivar: Boolean);
  end;

var
  frmMod: TfrmMod;

implementation

uses cobcons.model.configura, cobcons.controller.util;

{$R *.lfm}

procedure Tfrmmod.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_RETURN: if txtPesq.Focused then Pesquisa.Execute;
    VK_ESCAPE: Sair.Execute;
  end;
end;

procedure Tfrmmod.Grpesqcellclick(Column: Tcolumn);
begin
  AtivarAcoes(not dsPesq.DataSet.EOF);
End;

procedure Tfrmmod.Formclose(Sender: Tobject; var Closeaction: Tcloseaction);
begin
  Closeaction := caFree;
  self := nil;
End;

procedure Tfrmmod.Sairexecute(Sender: Tobject);
begin
  Close;
end;

procedure Tfrmmod.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnRodape.Color := vEsquema.CorPainelRodape;
  pnBackGround.Color := vEsquema.CorFundo;
  AtivarAcoes(False);
end;

procedure Tfrmmod.Ativaracoes(Pativar: Boolean);
begin
  Altera.Enabled := Pativar;
  Exclui.Enabled := Pativar;
end;

end.
