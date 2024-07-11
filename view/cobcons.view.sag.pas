unit cobcons.view.sag;

{$mode delphi}

interface

uses
  Classes, Sysutils, DateUtils, DB, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, ActnList, Buttons, StdCtrls,  ComCtrls,  Windows,
  cobcons.controller.interfaces, DateTimePicker;

type

  { TFrmSag }

  TFrmSag = class(Tform)
    Al: Tactionlist;
    Btnincluir: Tspeedbutton;
    Btnsair: Tspeedbutton;
    Cboremessa: Tcombobox;
    Dtbase: Tdatetimepicker;
    Edarq: Tedit;
    Edcnpj: Tedit;
    Edemail: Tedit;
    Edfone: Tedit;
    Edresponsavel: Tedit;
    Executar: Taction;
    Label1: Tlabel;
    Label2: Tlabel;
    Label3: Tlabel;
    Label4: Tlabel;
    Label5: Tlabel;
    Label6: Tlabel;
    Label7: Tlabel;
    lblTipo: TLabel;
    Mmlog: Tmemo;
    Pnacoes: Tpanel;
    Pnback: Tpanel;
    Pnrodape: Tpanel;
    Pntitulo: Tpanel;
    Sair: Taction;
    procedure dtBaseExit(Sender: Tobject);
    procedure Edarqclick(Sender: Tobject);
    procedure Executarexecute(Sender: Tobject);
    procedure Formclose(Sender: Tobject; var Closeaction: Tcloseaction);
    procedure Formcreate(Sender: Tobject);
    procedure Formkeydown(Sender: Tobject; var Key: Word; Shift: Tshiftstate);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Sairexecute(Sender: Tobject);
  Private
    FDemonstrativoZerado: Boolean;
    procedure SetarTipo;
    procedure LogMensagem(pMsg: String);
    procedure VerificaDemonstrativo;
    function DemonstrativoExiste(pData: TDateTime): boolean;
  Public

  end;

var
  FrmSag: TFrmSag;

implementation

uses cobcons.model.dm, cobcons.model.configura, cobcons.controller.util,
  cobcons.controller.factory;

{$R *.lfm}

{ TFrmSag }

procedure TFrmSag.dtBaseExit(Sender: Tobject);
begin
  dtBase.Date := EndOfTheMonth(dtBase.Date);

  SetarTipo;

  if not FDemonstrativoZerado
  then begin
    if not DemonstrativoExiste(Dtbase.Date) then begin
      MostraErro('Demonstrativos não encontrados para essa Data Base');
      if ConfirmaMensagem('Tenta importar do Siacon?')
      then begin
        TControllerFactory.New.Demonstrativo
              .GRUPO('0001')
              .DATABASE(Dtbase.Date)
              .ImportarDemonstrativosSiacon;
        if DemonstrativoExiste(Dtbase.Date)
        then MostraAviso('Importação bem sucedida!')
        else MostraErro('Importação NÃO realizada!');
      end;
    end;
  end;

End;

procedure TFrmSag.Edarqclick(Sender: Tobject);
var
  vNome: String;
begin
  vNome := Format('Sag%.2d%s%.4d.xml',
                      [ DayOf(Dtbase.Date),
                        Copy(RetornarMesExtenso(MonthOf(Dtbase.Date)),1,3),
                        YearOf(Dtbase.Date) ]);
  DM.SalvarArquivo.InitialDir := 'E:\Aqua\Acwin\BACEN';
  DM.SalvarArquivo.FileName := vNome;
  if DM.SalvarArquivo.Execute
  then edArq.Text := DM.SalvarArquivo.FileName;
End;

procedure TFrmSag.Executarexecute(Sender: Tobject);
var
  vSag: iControllerSag;
begin
  if Length(Trim(edArq.Text)) = 0
  then begin
    MostraAviso('Precisa informar onde vai gravar o SAG');
    edArq.SetFocus;
  end
  else begin
    vSag := TControllerFactory.New.Sag;
    vSag.DATABASE(dtBase.Date)
        .CNPJADM(edCnpj.Text)
        .LOG(LogMensagem)
        .MAILCONTATO(edEmail.Text)
        .NOMECONTATO(edResponsavel.Text)
        .NOMEARQUIVO(edArq.Text)
        .TELCONTATO(edFone.Text)
        .REMESSA(Copy(cboRemessa.Text,1,1))
        .GERARSAG;
    MostraAviso('Arquivo Gerado.');
    Mmlog.Lines.SaveToFile('LogSAG.txt');
    ModalResult := mrOK;
  end;
End;

procedure TFrmSag.Formclose(Sender: Tobject; var Closeaction: Tcloseaction);
begin
  Closeaction := caFree;
  self := nil;
End;

procedure TFrmSag.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
  vEmpresa: iControllerEmpresa;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnRodape.Color := vEsquema.CorPainelRodape;
  pnBack.Color := vEsquema.CorFundo;
  vEmpresa := TControllerFactory.New.Empresa.RecuperarEmpresa;
  dtBase.Date := vEmpresa.ULTSAG;
  edResponsavel.Text := vEmpresa.NMCONTATO;
  edFone.Text := vEmpresa.TELCONTATO;
  edEmail.Text := vEmpresa.MAILCONTATO;
  edCnpj.Text := Copy(vEmpresa.CGC, 1, 8);
  SetarTipo;
  VerificaDemonstrativo;
End;

procedure TFrmSag.Formkeydown(Sender: Tobject; var Key: Word; Shift: Tshiftstate
  );
begin
  case Key of
    VK_RETURN: SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
End;

procedure TFrmSag.pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmSag.Sairexecute(Sender: Tobject);
begin
  ModalResult := mrCancel;
End;

procedure TFrmSag.SetarTipo;
var
  vMes: Integer;
begin
  vMes := MonthOf(Dtbase.Date);
  FDemonstrativoZerado := not ((vMes = MonthMarch) or (vMes = MonthJune) or
                               (vMes = MonthSeptember) or (vMes = MonthDecember));
  lblTipo.Visible := FDemonstrativoZerado;
end;

procedure TFrmSag.LogMensagem(pMsg: String);
begin
  mmLog.Lines.Add(Pmsg);
end;

procedure TFrmSag.VerificaDemonstrativo;
var
  vDemonstrativo: iControllerDemonstrativo;
begin
  vDemonstrativo := TControllerFactory.New.Demonstrativo;
  if not vDemonstrativo.TabelaExiste
  then vDemonstrativo.CriarTabela;
end;

function TFrmSag.DemonstrativoExiste(pData: TDateTime): boolean;
var
  vDataset: TDataSet;
  vDemonstrativo: iControllerDemonstrativo;
begin
  vDemonstrativo := TControllerFactory.New.Demonstrativo;
  vDataset:= vDemonstrativo
                    .DATABASE(Pdata)
                    .RetornaDemonstrativoDataBase
                    .DataSet;
  Result := not vDataset.EOF;
end;

end.

