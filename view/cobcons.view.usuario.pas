unit cobcons.view.usuario;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses

  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cobcons.view.modelo, cobcons.controller.interfaces, DB, ActnList,
  StdCtrls, ComCtrls, Buttons, ExtCtrls, DBCtrls, DBGrids;

type

  { TfrmUsu }

  TfrmUsu = class(TfrmMod)
    procedure Formcreate(Sender: Tobject);
    procedure NovoExecute(Sender: TObject);
    procedure AlteraExecute(Sender: TObject);
    procedure ExcluiExecute(Sender: TObject);
    procedure PesquisaExecute(Sender: TObject);
  private
    { Private declarations }
    FUsuario: iControllerUsuario;
    function AbrirFicha(pCodigo: Integer): Boolean;
  public
    { Public declarations }
  end;

var
  frmUsu: TfrmUsu;

implementation

uses cobcons.model.dm, cobcons.controller.factory, cobcons.controller.util,
  cobcons.view.fichausuario;

{$R *.lfm}

procedure Tfrmusu.Formcreate(Sender: Tobject);
begin
  inherited;
  FUsuario := TControllerFactory.New.Usuario;
end;

procedure Tfrmusu.Novoexecute(Sender: Tobject);
begin
  if AbrirFicha(0)
  then Pesquisa.Execute;
end;

procedure Tfrmusu.Alteraexecute(Sender: Tobject);
begin
  if AbrirFicha(dsPesq.DataSet.FieldByName('CD_USU').AsInteger)
  then Pesquisa.Execute;
end;

procedure Tfrmusu.Excluiexecute(Sender: Tobject);
var
  vUsuarioLogado: iControllerUsuarioLogado;
  vCodigo: Integer;
begin
  vCodigo := dsPesq.DataSet.FieldByName('CD_USU').AsInteger;
  vUsuarioLogado:= TControllerFactory.New.UsuarioLogado;
  if (vUsuarioLogado.CODIGO <> vCodigo) and (ConfirmaMensagem('Confirma exclusão?'))
  then begin
    FUsuario.CODIGO(vCodigo).Excluir;
    Pesquisa.Execute;
  end;
end;

procedure Tfrmusu.Pesquisaexecute(Sender: Tobject);
var
  vDataSet : TDataSet;
begin
  if cboCampo.ItemIndex = 0
  then vDataSet := FUsuario.ListarPorCodigo(StrToIntDef(txtPesq.Text,0)).DataSet
  else vDataSet := FUsuario.ListarPorDescricao(txtPesq.Text+'%').DataSet;
  dsPesq.DataSet := vDataSet;
  if not vDataSet.EOF
  then pnRodape.Caption := Format('Encontradas %d ocorrencias para %s...',
         [vDataSet.RecordCount,txtPesq.Text])
  else  pnRodape.Caption := Format('%s não encontrado!',[txtPesq.Text]);
end;

function Tfrmusu.Abrirficha(Pcodigo: Integer): Boolean;
begin
  FrmFichaUsuario := TFrmFichaUsuario.Create(nil);
  try
     FrmFichaUsuario.Codigo := Pcodigo;
     Result := (FrmFichaUsuario.ShowModal = mrOK);
  finally
    FrmFichaUsuario.Free;
  end;
end;


end.
