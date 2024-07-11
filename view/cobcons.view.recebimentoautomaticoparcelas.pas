unit cobcons.view.recebimentoautomaticoparcelas;

{$mode objfpc}{$H+}

interface

uses
  Classes, Windows, SysUtils, db, BufDataset, FileUtil, Forms, Controls,
  Graphics, Dialogs, ActnList, ExtCtrls, Buttons, StdCtrls, DBGrids, DbCtrls,
  LCLType, cobcons.controller.interfaces, cobcons.model.interfaces, HNSCombox,
  fpspreadsheet, fpstypes, fpsallformats ;

type

  { TFrmRecAutomatico }

  TFrmRecAutomatico = class(TForm)
    abrir: TAction;
    edArq: TEdit;
    grPesq: TDBGrid;
    cboEmp: THNSCombox;
    imp: TAction;
    AL: TActionList;
    Label2: TLabel;
    lin: TBufDataset;
    ds: TDataSource;
    linVenda: TLongintField;
    nvPesq: TDBNavigator;
    pnRodape: TPanel;
    sair: TAction;
    Label1: TLabel;
    linBem: TStringField;
    linComissao: TFloatField;
    linContrato: TStringField;
    linCota: TLongintField;
    linDtPag: TDateField;
    linGrupo: TStringField;
    linNome: TStringField;
    linobs: TStringField;
    linPcl: TLongintField;
    linValor: TFloatField;
    pnAcoes: TPanel;
    pnBackground: TPanel;
    Panel3: TPanel;
    pnTitulo: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    procedure abrirExecute(Sender: TObject);
    procedure cboEmpEnter(Sender: TObject);
    procedure cboEmpSelect(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure grPesqDblClick(Sender: TObject);
    procedure pnTituloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sairExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure impExecute(Sender: TObject);
  private
    { private declarations }
    FParcela: iControllerParcelaComissao;
    procedure importarPlanilha(pPlanilha: TsWorkbook);
    procedure baixarComissoes;
    procedure MensagemRodape(pMsg: String);
  public
    { public declarations }
  end;

var
  FrmRecAutomatico: TFrmRecAutomatico;
  empresa: Integer;

implementation

uses cobcons.model.configura, cobcons.model.dm, cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.rel.baixacomissao,
  cobcons.view.parcelascomissao;

{$R *.lfm}

{ TFrmRecAutomatico }

procedure TFrmRecAutomatico.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnRodape.Color := vEsquema.CorPainelRodape;
  pnBackGround.Color := vEsquema.CorFundo;
  grPesq.AlternateColor := vEsquema.CorFundo;
  cboEmp.Lista := TControllerFactory.New.AdmCon.ListaComboBox;
  FParcela := TControllerFactory.New.ParcelaComissao;
end;

procedure TFrmRecAutomatico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
   //VK_RETURN: if edtPesq.Focused then Pesq.Execute;
   VK_ESCAPE: sair.Execute;
  end;
end;

procedure TFrmRecAutomatico.impExecute(Sender: TObject);
begin
  lin.IndexFieldNames:='PCL';

  FrmRelBaixaComissao := TFrmRelBaixaComissao.Create(nil);
  try
     FrmRelBaixaComissao.ds.DataSet := lin;
     FrmRelBaixaComissao.dsPrs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
     FrmRelBaixaComissao.RP.Title := Format('Baixa Automática Empresa: %s Arquivo: %s',[Trim(cboEmp.Text),Trim(ExtractFileName(edArq.Text))]);
     FrmRelBaixaComissao.RP.PreviewModal;
  finally
    FrmRelBaixaComissao.Free;
  end;
end;

procedure TFrmRecAutomatico.importarPlanilha(pPlanilha: TsWorkbook);
var
  dtpag: TDate;
  linha: Cardinal;
  ttlin,
  pcl,
  vCodVenda,
  vCodEmp: Integer;
  grc: String;
  vTab : TsWorksheet;
  vVenda: iControllerVenda;

begin
  vVenda  := TControllerFactory.New.Venda;
  vCodEmp := cboEmp.getCodigo;
  vTab    := pPlanilha.GetWorksheetByIndex(0);
  ttlin   := vTab.GetLastRowIndex;
  linha   := 3;

  if lin.Active
  then lin.Close;
  lin.IndexFieldNames:='';
  imp.Enabled:=False;
  lin.CreateDataset;

  while linha < ttlin do begin

    lin.Append;
    case vCodEmp of
      3: begin    // gmac
        linPcl.Value:= StrToInt(vTab.ReadAsText(linha,11));
        linDtPag.AsDateTime:=StrToDate(vTab.ReadAsText(linha,0));
        linBem.Value:=vTab.ReadAsText(linha,7);
        linContrato.Value:=vTab.ReadAsText(linha,8);
        //linNome.Value:=vTab.ReadAsText(linha,6);
        grc := vTab.ReadAsText(linha,9);
        linValor.Value:= RetornaValor(vTab.ReadAsText(linha, 23));
        linComissao.Value:=RetornaValor(vTab.ReadAsText(linha, 44));
      end;
      4: begin  // renault
        linPcl.Value:= StrToInt(Copy(vTab.ReadAsText(linha,10),1,1));
        linDtPag.AsDateTime:=StrToDate(vTab.ReadAsText(linha,0));
        linBem.Value:=vTab.ReadAsText(linha,6);
        linContrato.Value:=vTab.ReadAsText(linha,7);
        //linNome.Value:=vTab.ReadAsText(linha,6);
        grc := vTab.ReadAsText(linha,8);
        linValor.Value:= RetornaValor(vTab.ReadAsText(linha, 21));
        linComissao.Value:=RetornaValor(vTab.ReadAsText(linha, 51));
      end;
    end;

    vCodVenda := vVenda.ContratoJaInformado(vCodEmp, linContrato.AsString);
    if vCodVenda <= 0
    then linobs.Value := 'Venda nao encontrada!';
    linVenda.AsInteger := vCodVenda;
    linGrupo.Value:=Copy(grc,0,6);
    linCota.Value:=StrToInt(Copy(grc,8,4));
    lin.Post;
    MensagemRodape(Format('Importando Linha %d',[linha]));
    linha:=linha+1;

  end;
  lin.First;
  MensagemRodape(Format('%d linhas importadas do arquivo %s',[ (linha - 4), ExtractFileName(edArq.Text) ]));
  imp.Enabled:=True;
end;

procedure TFrmRecAutomatico.baixarComissoes;
var
  msg: String;
  par: Integer;
  vVenda: iControllerVenda;
begin
  vVenda := TControllerFactory.New.Venda;
  lin.First;
  while not lin.EOF do begin
    if linVenda.AsInteger > 0
    then begin
      vVenda.ListaPorCodigo(linVenda.AsInteger);

      msg := '';
      par := linPcl.AsInteger;

      if linComissao.Value < 0
      then begin
        par := 99;
        msg := 'Venda Cancelada';
        //FParcela.VENDA(linVenda.AsInteger)
        //        .PARCELA(par)
        //        .PERIODO(0)
        //        .DTVENC(linDtPag.AsDateTime)
        //        .RECEBER(linComissao.AsFloat)
        //        .RECEBIDO(linComissao.AsFloat)
        //        .PAGAR(0.0)
        //        .PAGO(0.0)
        //        .DTREC(linDtPag.AsDateTime)
        //        .Executar(tmInclusao);
        if vVenda.SITUACAO <> 4
        then vVenda.CancelarVenda( linVenda.AsInteger,
                                   linDtPag.AsDateTime,
                                   linComissao.AsFloat);
      end
      else begin
        if (linGrupo.Value <> vVenda.GRUPO) or
           (linCota.Value <> vVenda.COTA)
        then begin
          vVenda.GRUPO(linGrupo.AsString)
                .COTA(linCota.AsInteger)
                .Executar(tmAlteracao);
          msg := 'Grupo/Cota Atualizado!';
        end;

        if  FParcela.ExisteParcela(cboEmp.getCodigo, linContrato.Value, linPcl.Value)
        then FParcela.PARCELA(par)
                     .RECEBIDO(linComissao.AsFloat)
                     .DTREC(linDtPag.AsDateTime)
                     .Executar(tmAlteracao)
        else begin
          FParcela.VENDA(linVenda.AsInteger)
                     .PARCELA(par)
                     .PERIODO(0)
                     .DTVENC(linDtPag.AsDateTime)
                     .RECEBER(linComissao.AsFloat)
                     .RECEBIDO(linComissao.AsFloat)
                     .PAGAR(0.0)
                     .PAGO(0.0)
                     .DTREC(linDtPag.AsDateTime)
                     .Executar(tmInclusao);
          msg := Trim(Format('%s Parcela incluída!',[ msg ]));
        end;

      end;

      if (msg<>'') or (par=99)
      then begin
        lin.Edit;
        linobs.Value:=msg;
        linPcl.Value:=par;
        lin.Post;
      end;

    end;

    lin.Next;

  end;

  imp.Enabled:=True;
  lin.IndexFieldNames:='PCL';
  MostraAviso('Fim de atualização!');

end;

procedure TFrmRecAutomatico.MensagemRodape(pMsg: String);
begin
  pnRodape.Caption := pMsg;
end;

procedure TFrmRecAutomatico.sairExecute(Sender: TObject);
begin
  if lin.Active
  then lin.Close;
  ModalResult := mrCancel;
end;

procedure TFrmRecAutomatico.cboEmpEnter(Sender: TObject);
begin
  edArq.Clear;
end;

procedure TFrmRecAutomatico.cboEmpSelect(Sender: TObject);
begin
  empresa:=cboEmp.getCodigo;
end;

procedure TFrmRecAutomatico.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Closeaction := caFree;
  self := nil;
end;

procedure TFrmRecAutomatico.grPesqDblClick(Sender: TObject);
var
  vCod: Integer;
begin
  vCod := ds.DataSet.FieldByName('VENDA').AsInteger;
  if vCod > 0
  then begin
    FrmParcelasComissao := TFrmParcelasComissao.Create(nil);
    try
      FrmParcelasComissao.CodigoVenda := vCod;
      FrmParcelasComissao.ShowModal;
    finally
      FrmParcelasComissao.Free;
    end;
  end;
end;

procedure TFrmRecAutomatico.pnTituloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmRecAutomatico.abrirExecute(Sender: TObject);
var
  planilha: TsWorkbook;
begin
  if cboEmp.getCodigo > 0 then begin

    if DM.AbreArquivo.Execute then begin

      edArq.Text:=DM.AbreArquivo.FileName;

      planilha := TsWorkbook.Create;
      try
         try
            planilha.ReadFromFile(DM.AbreArquivo.FileName);
            importarPlanilha(planilha);
         except
               on E: Exception do
               MostraErro('Erro lendo a planilha! Abra com OpenOffice, salve como ods ou xls e tente novamente');
         end;


         if lin.EOF
         then MensagemRodape('Não houve importação!')
         else if ConfirmaMensagem('Planilha importada. Confirma a baixa de comissões?')
         then baixarComissoes;

      finally
             planilha.Free;
      end;
    end;
  end
  else begin
    MostraAviso('Escolha a empresa que vai receber a importação');
    cboEmp.SetFocus;
  end;

end;

end.

