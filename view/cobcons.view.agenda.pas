unit cobcons.view.agenda;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, DB, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids,
  StdCtrls, DBCtrls, cobcons.controller.interfaces, DateTimePicker;

type

  { TfrmAge }

  TfrmAge = class(TForm)
    alterar: Taction;
    Btnsair1: Tspeedbutton;
    grCon: Tdbgrid;
    Nvpesq: Tdbnavigator;
    Panel1: Tpanel;
    pnBack: Tpanel;
    Pntitulo: Tpanel;
    pnAcoes: TPanel;
    btnSair: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnIncluir: TSpeedButton;
    Panel2: TPanel;
    DS: TDataSource;
    AL: TActionList;
    Pesquisa: TAction;
    Contatar: TAction;
    Exclui: TAction;
    Sair: TAction;
    Importar: TAction;
    dt1: TDateTimePicker;
    Panel3: TPanel;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    dt2: TDateTimePicker;
    Label3: TLabel;
    procedure Alterarexecute(Sender: Tobject);
    procedure Formshow(Sender: Tobject);
    procedure SairExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure PesquisaExecute(Sender: TObject);
    procedure grConDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ContatarExecute(Sender: TObject);
    procedure ExcluiExecute(Sender: TObject);
  private
    { Private declarations }
    FAgenda: iControllerAgenda;
    FUsuario: iControllerUsuarioLogado;
  public
    { Public declarations }
  end;

var
  frmAge: TfrmAge;

implementation

uses
    cobcons.model.configura, cobcons.model.dm, cobcons.controller.util,
    cobcons.controller.factory, cobcons.view.fichacompromisso;

{$R *.lfm}

procedure TfrmAge.SairExecute(Sender: TObject);
begin
  Close;
end;

procedure Tfrmage.Formshow(Sender: Tobject);
begin
  Pesquisa.Execute;
End;

procedure Tfrmage.Alterarexecute(Sender: Tobject);
begin
  if FAgenda.STATUS = 0
  then begin
    frmCom := TfrmCom.Create(nil);
    try
      frmCom.Compromisso := FAgenda;
      if frmCom.ShowModal = mrOK
      then Pesquisa.Execute;
    finally
      frmCom.Free;
    end;
  end;
End;

procedure TfrmAge.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F9: if btnIncluir.Enabled then btnIncluir.Click;
       VK_F3: if btnAlterar.Enabled then btnAlterar.Click;
       VK_F4: if btnExcluir.Enabled then btnExcluir.Click;
//       VK_F5: if btImp.Enabled then btImp.Click;
       VK_RETURN:  SelectNext(ActiveControl,True,True);
       VK_ESCAPE: Sair.Execute;
     end;
end;

procedure TfrmAge.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnBack.Color := vEsquema.CorFundo;
  FUsuario := TControllerFactory.New.UsuarioLogado;
  FAgenda := TControllerFactory.New.Agenda;
  dt1.Date := (Date-3);
  dt2.Date := (Date+5);
end;

procedure TfrmAge.PesquisaExecute(Sender: TObject);
begin
  FAgenda.RetornaAgendaUsuarioPeriodo(FUsuario.CODIGO, dt1.Date, dt2.Date);
  Contatar.Enabled := not FAgenda.DataSet.EOF;
  Exclui.Enabled := Contatar.Enabled;
  alterar.Enabled := Contatar.Enabled;
  if FAgenda.DataSet.EOF
  then begin
    MostraAviso('Sem compromissos no período!');
    DS.DataSet := nil;
  end
  else begin
    DS.DataSet := FAgenda.DataSet;
    grCon.SetFocus;
  end;

end;

procedure TfrmAge.grConDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if FAgenda.STATUS = 1
  then grCon.Canvas.Font.Color := clGray
  else begin
    case FAgenda.PRIORIDADE of
      0: grCon.Canvas.Font.Color := clRed;
      1: grCon.Canvas.Font.Color := clOlive;
      2: grCon.Canvas.font.Color := clGreen;
    end;
  end;
  if gdSelected in State
  then grCon.Canvas.Font.Color := clWhite;
  grCon.Canvas.FillRect(Rect);
  grCon.DefaultDrawColumnCell(Rect, DataCol,Column, State);
end;

procedure TfrmAge.ContatarExecute(Sender: TObject);
begin
  AbrirFichaCota( FAgenda.GRUPO, FAgenda.SEQ, FAgenda.COTA );
end;

procedure TfrmAge.ExcluiExecute(Sender: TObject);
var
  vMsg: String;
  vStatus: Integer;
begin
  case FAgenda.STATUS of
    // ---------------------- 1: REALIZADO
    1: begin
        vMsg := 'Confirma a Abertura do compromisso?';
        vStatus := 0;
    end;
    // ---------------------- 0: ABERTO
    0: begin
        vMsg := 'Confirma a Realização do compromisso?';
        vStatus := 1;
    end;
  end;
  if ConfirmaMensagem(vMsg)
  then begin
    FAgenda.AlterarStatus(FAgenda.CODIGO, vStatus);
    Pesquisa.Execute;
  end;
end;

end.
