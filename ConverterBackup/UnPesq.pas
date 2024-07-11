unit UnPesq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ComCtrls, DB, ExtCtrls,
  ActnList;

type
  TfrmPesq = class(TForm)
    Panel1: TPanel;
    DS: TDataSource;
    stBar: TStatusBar;
    txtPesq: TEdit;
    DBGrid1: TDBGrid;
    AL: TActionList;
    Pesq: TAction;
    procedure txtPesqEnter(Sender: TObject);
    procedure DBGrid1Enter(Sender: TObject);
    procedure txtPesqChange(Sender: TObject);
    procedure PesqExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PesquisaConsorciado(Nome: string);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesq: TfrmPesq;

implementation

uses UnDM, DBClient, SimpleDS;

{$R *.dfm}

procedure TfrmPesq.DBGrid1DblClick(Sender: TObject);
begin
     ModalResult := mrOk;
end;

procedure TfrmPesq.DBGrid1Enter(Sender: TObject);
begin
  stBar.SimpleText := 'Use as SETAS para escolher ENTER para selecionar ou ESC para cancelar.';
end;

procedure TfrmPesq.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then DBGrid1DblClick(nil);
  if Key = VK_ESCAPE then ModalResult := mrCancel;
end;

procedure TfrmPesq.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then DBGrid1.SetFocus;
  if Key = VK_ESCAPE then ModalResult := mrCancel;
end;

procedure TfrmPesq.PesqExecute(Sender: TObject);
begin
  PesquisaConsorciado(txtPesq.Text);
  if not DM.cdsCons.Eof then DBGrid1.SetFocus;
end;

procedure TfrmPesq.PesquisaConsorciado(Nome: string);
var
 eNome: Boolean;
 stSql: string;
begin
  if Nome = '' then begin
    txtPesq.SetFocus;
    Exit;
  end;
  eNome := (StrToIntDef(Copy(Nome,1,3),0)=0) and (Copy(Nome,1,3)<>'000');
  if eNome
  then stSql := 'select GRUPO, SEQ, COTA, NOME, CGC_CPF, PESS_F_J,sit_cobr '+
                           ' from ACCLI where NOME like '+QuotedStr(Nome+'%')+
                           ' order by nome'
  else stSql := 'select GRUPO, SEQ, COTA, NOME, CGC_CPF, PESS_F_J,sit_cobr '+
                           ' from ACCLI where CGC_CPF like '+QuotedStr('%'+Nome+'%')+
                           ' order by CGC_CPF';
  with DM.cdsCons do begin
    Close;
    CommandText := stSql;
    Open;
  end;
end;

procedure TfrmPesq.txtPesqChange(Sender: TObject);
begin
  PesquisaConsorciado(txtPesq.Text);
end;

procedure TfrmPesq.txtPesqEnter(Sender: TObject);
begin
  stBar.SimpleText := 'Digite o NOME ou o CPF/CNPJ para pesquisar, ENTER para selecionar';
end;

end.
