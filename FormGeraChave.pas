unit FormGeraChave;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Mask, DBCtrls, DB, Grids, DBGrids, DBClient,
  ComCtrls;

type
  TfrmGerarChave = class(TForm)
    cdsEmp: TClientDataSet;
    cdsEmpRazaoSocial: TStringField;
    cdsEmpUltLib: TStringField;
    cdsEmpDtLib: TDateField;
    grEmp: TDBGrid;
    dsEmp: TDataSource;
    edRazaoSocial: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    edDtLib: TDBEdit;
    btGerarChave: TSpeedButton;
    btSalva: TSpeedButton;
    btCancelar: TSpeedButton;
    btNovo: TSpeedButton;
    edUltLib: TDBEdit;
    Label3: TLabel;
    btSair: TSpeedButton;
    dtLib: TDateTimePicker;
    edPos: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    edNovaLib: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    edVer: TEdit;
    btVerificar: TSpeedButton;
    procedure edPosKeyPress(Sender: TObject; var Key: Char);
    procedure btVerificarClick(Sender: TObject);
    procedure btGerarChaveClick(Sender: TObject);
    procedure dsEmpStateChange(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btSairClick(Sender: TObject);
    procedure btSalvaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure salvaEmpresas;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGerarChave: TfrmGerarChave;
  NOME_ARQ : String = 'emp.xml';

implementation

uses UnitCpt;

{$R *.dfm}

procedure TfrmGerarChave.btCancelarClick(Sender: TObject);
begin
  cdsEmp.Cancel;
end;

procedure TfrmGerarChave.btGerarChaveClick(Sender: TObject);
begin
  if edPos.Text='' then Abort;
  if dtLib.Date <= cdsEmpDtLib.Value then Abort;
  edNovaLib.Text := edPos.Text+gerarChave(edPos.Text,cdsEmpRazaoSocial.Value,
                         dtLib.DateTime);
  btVerificar.Enabled := true;
end;

procedure TfrmGerarChave.btNovoClick(Sender: TObject);
begin
  cdsEmp.Append;
  edRazaoSocial.SetFocus;
end;

procedure TfrmGerarChave.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmGerarChave.btSalvaClick(Sender: TObject);
begin
  cdsEmp.Post;
  salvaEmpresas;
end;

procedure TfrmGerarChave.btVerificarClick(Sender: TObject);
var
  dLib: TDateTime;
begin
  dLib := dtLiberado(edNovaLib.Text,cdsEmpRazaoSocial.Value);
  edVer.Text := FormatDateTime('dd/mm/yyyy',dLib);
  if Trunc(dLib) = Trunc(dtLib.DateTime) then begin
    if Application.MessageBox('Gravar Liberação?','Atenção',
                     MB_ICONQUESTION+MB_YESNO)=mrYes then begin
      cdsEmp.Edit;
      cdsEmpUltLib.Value := edNovaLib.Text;
      cdsEmpDtLib.Value := dLib;
      cdsEmp.Post;
      salvaEmpresas;
    end;
  end;
  btVerificar.Enabled := false;

end;

procedure TfrmGerarChave.dsEmpStateChange(Sender: TObject);
begin
  btNovo.Enabled := (dsEmp.State=dsBrowse);
  btSalva.Enabled := not btNovo.Enabled;
  btCancelar.Enabled := btSalva.Enabled;
  btGerarChave.Enabled := (dsEmp.State=dsBrowse) or (not cdsEmp.IsEmpty);
end;

procedure TfrmGerarChave.edPosKeyPress(Sender: TObject; var Key: Char);
begin
  if posicaoLetra(key) > length(cdsEmpRazaoSocial.Value) then begin
    Application.MessageBox('Posição inválida!','Atenção',MB_ICONHAND+MB_OK);
    key := #0;
  end;
end;

procedure TfrmGerarChave.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if dsEmp.State in [dsINSERT,DSeDIT]
  then cdsEmp.Cancel;
  salvaEmpresas;
end;

procedure TfrmGerarChave.FormCreate(Sender: TObject);
begin
  if FileExists(ExtractFilePath(Application.ExeName)+NOME_ARQ)
  then cdsEmp.LoadFromFile(ExtractFilePath(Application.ExeName)+NOME_ARQ);
end;

procedure TfrmGerarChave.salvaEmpresas;
begin
  cdsEmp.SaveToFile(ExtractFilePath(Application.ExeName)+NOME_ARQ,dfXMLUTF8);
end;

end.
