unit UnLista;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids;

type
  Lista = (lsGrupo, lsCota);

  TFrmLista = class(TForm)
    grLista: TDBGrid;
    dsLista: TDataSource;
    procedure grListaDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grListaEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FTipo: Lista;
    FGru: string;
    procedure SetGru(const Value: string);
    procedure SetTipo(const Value: Lista);
    { Private declarations }
  public
    { Public declarations }
    property Tipo: Lista read FTipo write SetTipo;
    property Gru: string read FGru write SetGru;
  end;

var
  FrmLista: TFrmLista;

implementation

uses UnDm, DBClient;

{$R *.dfm}

procedure TFrmLista.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: ModalResult := mrOk;
    VK_ESCAPE: ModalResult := mrNone;
  end;
end;

procedure TFrmLista.FormShow(Sender: TObject);
var
  strSQL : string;
begin

  if Tipo = lsGrupo
  then strSQL := 'select grupo from ACGRU order by grupo'
  else strSQL := 'select grupo,seq,cota,nome from ACCLI where grupo='+
    QuotedStr(Gru)+' order by grupo,seq,cota';

  with DM.cdsPesq do begin
    Close;
    CommandText := strSQL;
    Open;
  end;

  if Tipo = lsGrupo
  then FrmLista.Width := 95
  else FrmLista.Width := 350;

end;

procedure TFrmLista.grListaDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmLista.grListaEnter(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmLista.SetGru(const Value: string);
begin
  FGru := Value;
end;

procedure TFrmLista.SetTipo(const Value: Lista);
begin
  FTipo := Value;
end;

end.
