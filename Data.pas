unit Data;

interface

uses
  SysUtils, Classes, Dialogs, DBXpress, FMTBcd, DB, SqlExpr, Forms;

type
  TDM = class(TDataModule)
    AbrirArq: TOpenDialog;
    Con: TSQLConnection;
    SQLCom: TSQLQuery;
    SQLTabela: TSQLTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function AbrirTabela(Tab: string): Boolean;
    procedure ExecutarSql(stSql: string);
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

{ TDM }

{ TDM }

function TDM.AbrirTabela(Tab: string): Boolean;
begin
  with SQLTabela do begin
    Close;
    TableName := Tab;
    try
      Open;
      Result := True;
    except
      Result := False;
    end;
  end;
end;

procedure TDM.ConBeforeConnect(Sender: TObject);
var
  NomeArq : string;
begin
  NomeArq := ExtractFilePath(Application.ExeName)+'CobCons.ini';
  if FileExists(NomeArq) then
    Con.LoadParamsFromIniFile(NomeArq);
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  Con.Connected := True;
end;

procedure TDM.ExecutarSql(stSql: string);
begin
  with SQLCom do begin
    Close;
    SQL.Clear;
    SQL.Add(stSql);
    ExecSQL;
  end;
end;

end.
