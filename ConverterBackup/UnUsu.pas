unit UnUsu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UnModelo, DB, ActnList, StdCtrls, Grids, DBGrids, ComCtrls,
  Buttons, ExtCtrls, Mask, DBCtrls;

type
  TfrmUsu = class(TfrmMod)
    Label3: TLabel;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    DBEdit5: TDBEdit;
    btSen: TSpeedButton;
    cboAdm: TComboBox;
    procedure btSenClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NovoExecute(Sender: TObject);
    procedure GravaExecute(Sender: TObject);
    procedure CancelaExecute(Sender: TObject);
    procedure AlteraExecute(Sender: TObject);
    procedure ExcluiExecute(Sender: TObject);
    procedure tbFicShow(Sender: TObject);
    procedure PesquisaExecute(Sender: TObject);
    procedure PosicionaDataset(Fic:Boolean);
    procedure grConDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsu: TfrmUsu;

implementation

uses UnDm;

{$R *.dfm}

procedure TfrmUsu.btSenClick(Sender: TObject);
begin
     if DBEdit5.PasswordChar = #0
     then DBEdit5.PasswordChar := '*'
     else DBEdit5.PasswordChar := #0;
end;

procedure TfrmUsu.FormActivate(Sender: TObject);
begin
  inherited;
     btSen.Enabled := (DM.UsuAdm = 1);
end;

procedure TfrmUsu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
     if DS.State in [dsInsert, dsEdit]
     then DM.cdsUsu.Cancel;
     DM.cdsUsu.Close;
end;

procedure TfrmUsu.NovoExecute(Sender: TObject);
begin
     if not DM.cdsUsu.Active
     then DM.cdsUsu.Open;
     DM.cdsUsu.Insert;
     DM.cdsUsuCD_USU.AsInteger := DM.GeraCod('CD_USU','CJCBUSU');
     PC.ActivePage := tbFic;
     DBEdit2.SetFocus;
end;

procedure TfrmUsu.GravaExecute(Sender: TObject);
begin
     if DBEdit2.Text = ''
     then
         begin
              Application.MessageBox('Necessário informar Nome.','Atenção',
                                                 MB_ICONHAND+MB_OK);
              DBEdit2.SetFocus;
              Abort;
         end;
     if Application.MessageBox('Confirma a gravação dos dados?','Confirmação',
        MB_ICONQUESTION+MB_YESNO)=id_no
     then Abort;
     if DS.State = dsInsert
     then DM.cdsUsuDC_FIG.Value := '';
     DM.cdsUsuID_ADM.AsInteger := cboAdm.ItemIndex;
     DM.cdsUsu.Post;
     DM.cdsUsu.ApplyUpdates(0);
     if DM.cdsPesq.Active then DM.cdsPesq.Refresh;
     PC.ActivePage := tbCon;
end;

procedure TfrmUsu.CancelaExecute(Sender: TObject);
begin
     DM.cdsUsu.Cancel;
end;

procedure TfrmUsu.AlteraExecute(Sender: TObject);
begin
     PosicionaDataset(True);
     DM.cdsUsu.Edit;
     DBEdit2.SetFocus;
end;

procedure TfrmUsu.ExcluiExecute(Sender: TObject);
begin
  inherited;
     PosicionaDataset(True);
     if DM.cdsUsuCD_USU.AsInteger = DM.UsuCod
     then Application.MessageBox('Não pode excluir a si mesmo!','Atenção',
                                          MB_ICONWARNING+MB_OK)
     else
         begin
              DM.cdsUsu.Delete;
              DM.cdsUsu.ApplyUpdates(0);
         end;
     DSStateChange(Self);
     DM.cdsPesq.Refresh;
     PC.ActivePage := tbCon;
end;

procedure TfrmUsu.tbFicShow(Sender: TObject);
begin
     if DS.State <> dsInsert
     then PosicionaDataset(False);
end;

procedure TfrmUsu.PesquisaExecute(Sender: TObject);
var
   SqlStr, Campo, Relacao : String;
begin
     SqlStr := 'select CD_USU as Codigo, NM_USU as Nome from CJCBUSU where ';
     if cboCampo.ItemIndex = 0
     then Campo := 'NM_USU'
     else Campo := 'CD_USU';
     case cboRel.ItemIndex of
       0: Relacao := ' like '+QuotedStr('%'+txtPesq.Text+'%');
       1: Relacao := ' like '+QuotedStr(txtPesq.Text+'%');
       2: Relacao := ' = ';
       3: Relacao := ' > ';
       4: Relacao := ' >= ';
       5: Relacao := ' < ';
       6: Relacao := ' <= ';
     end;

     if cboRel.ItemIndex > 1
     then
         begin
              if  cboCampo.ItemIndex = 0
              then SqlStr := SqlStr + Campo + Relacao + QuotedStr(txtPesq.Text)
              else SqlStr := SqlStr + Campo + Relacao + txtPesq.Text;
         end
     else SqlStr := SqlStr + Campo + Relacao;

     with DM.cdsPesq do
     begin
          Close;
          CommandText := SqlStr;
          Open;
     end;
end;

procedure TfrmUsu.PosicionaDataset(Fic:Boolean);
begin
     with DM.cdsUsu do
     begin
          Close;
          Params[0].Value := DM.cdsPesq.Fields[1].Value;
          Open;
     end;
     cboAdm.ItemIndex := DM.cdsUsuID_ADM.AsInteger;
     if Fic
     then PC.ActivePage := tbFic;
end;

procedure TfrmUsu.grConDblClick(Sender: TObject);
begin
     PosicionaDataset(True);
end;

end.
