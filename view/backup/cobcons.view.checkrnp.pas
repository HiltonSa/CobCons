unit cobcons.view.checkrnp;

{$mode delphi}

interface

uses
  Classes, Windows, Sysutils, DB, Forms, Controls, Graphics, Dialogs, ActnList,
  ExtCtrls, Buttons, StdCtrls, DBGrids, cobcons.model.planilha,
  cobcons.model.bufferdataset, cobcons.controller.interfaces, DBCtrls;

type

  { TFrmCheckRnp }

  TFrmCheckRnp = class(Tform)
    Btnsair3: Tspeedbutton;
    comparar: Taction;
    Btnsair2: Tspeedbutton;
    lblMsg: Tlabel;
    planilha: Taction;
    Al: Tactionlist;
    Btnsair: Tspeedbutton;
    Btnsair1: Tspeedbutton;
    Ds: Tdatasource;
    Grcon: Tdbgrid;
    lblRelatorioSiacon: Tlabel;
    lblPlanilha: Tlabel;
    relatorio: Taction;
    Nvpesq: Tdbnavigator;
    Panel1: Tpanel;
    Panel2: Tpanel;
    Pnacoes: Tpanel;
    Pnback: Tpanel;
    Pntitulo: Tpanel;
    Sair: Taction;
    procedure Compararexecute(Sender: Tobject);
    procedure Formcreate(Sender: Tobject);
    procedure Formkeydown(Sender: Tobject; var Key: Word; Shift: Tshiftstate);
    procedure Grcondblclick(Sender: Tobject);
    procedure Planilhaexecute(Sender: Tobject);
    procedure Relatorioexecute(Sender: Tobject);
    procedure Sairexecute(Sender: Tobject);
  Private
    FPlanilha: iModelPlanilha;
    FCheck: iModelBufferDataset;
    FRnp: iControllerRnp;
    procedure CriarFCheck;
    procedure IncluirFCheck(pGrupo, pSeq, pCota: String; pRel, pPla: Integer; pRecRel, pRecPla, pComRel, pComPla: Double);
    procedure LerRelatorio(var pArquivo: TStringList);
    procedure Mensagem(pMsg: String);
  Public

  end;

var
  FrmCheckRnp: TFrmCheckRnp;

const
  SLDREC = '23/04/13';
  SLDCOM = '26/09/16';

implementation

uses cobcons.model.configura, cobcons.model.dm,
  cobcons.controller.util, cobcons.controller.factory;


{$R *.lfm}

{ TFrmCheckRnp }

procedure Tfrmcheckrnp.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnBack.Color := vEsquema.CorFundo;
  FRnp := TControllerFactory.New.RNP;
  if not FRnp.TabelaCheckExiste
  then FRnp.CriarTabelaCheck;
  FPlanilha:= TPlanilha.New;
End;

procedure Tfrmcheckrnp.Compararexecute(Sender: Tobject);
begin

  //if (vArquivo.Count > 0) and (FPlanilha.NumeroColunas > 0)
  //then begin
  //  CriarFCheck;
  //  LerRelatorio;
  //  Ds.DataSet := FCheck.DataSet;
  //end;

End;

procedure Tfrmcheckrnp.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_RETURN:  SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
End;

procedure Tfrmcheckrnp.Grcondblclick(Sender: Tobject);
begin
  if not Ds.DataSet.IsEmpty
  then AbrirFichaCota( Ds.DataSet.FieldByName('Grupo').AsString,
                  Ds.DataSet.FieldByName('Seq').AsString,
                  Ds.DataSet.FieldByName('Cota').AsString );
End;

procedure Tfrmcheckrnp.Planilhaexecute(Sender: Tobject);
begin
  if DM.AbreArquivo.Execute
  then begin
    lblPlanilha.Caption := DM.AbreArquivo.FileName;
    if not FPlanilha.ArquivoValido(lblPlanilha.Caption)
    then MostraErro('Formato de Planilha desconhecido!')
    else FPlanilha.Arquivo(lblPlanilha.Caption).Abrir;
  end;
End;

procedure Tfrmcheckrnp.Relatorioexecute(Sender: Tobject);
var
 vArquivo: TStringList;

begin
  if DM.AbreArquivo.Execute
  then begin
    lblRelatorioSiacon.Caption := DM.AbreArquivo.FileName;
    vArquivo := TStringList.Create;
    try
      vArquivo.LoadFromFile(lblRelatorioSiacon.Caption);
      if Pos('CONTA CORRENTE DE DEVOLU', vArquivo[1]) = 0
      then begin
        MostraErro('Arquivo Inválido');
        vArquivo.Clear;
      end
      else begin
        LerRelatorio(vArquivo);
        Ds.DataSet := FRnp.RetornaCheck.DataSet;
        if not Ds.DataSet.EOF
        then TPlanilha.New.GerarPlanilha(Ds.DataSet,'CheckRnp.xls');
      end;
    finally
      vArquivo.Free;
    end;
  end;
End;

procedure Tfrmcheckrnp.Sairexecute(Sender: Tobject);
begin
  Close;
End;

procedure Tfrmcheckrnp.Criarfcheck;
begin
  FCheck := TModelBufferDataset.New;
  FCheck.NovoCampo.NOME('Grupo').TIPO(ftString).TAMANHO(4).AdicionarCampo;
  FCheck.NovoCampo.NOME('Seq').TIPO(ftString).TAMANHO(2).AdicionarCampo;
  FCheck.NovoCampo.NOME('Cota').TIPO(ftString).TAMANHO(3).AdicionarCampo;
  FCheck.NovoCampo.NOME('Relatorio').TIPO(ftInteger).AdicionarCampo;
  FCheck.NovoCampo.NOME('Planilha').TIPO(ftInteger).AdicionarCampo;
  FCheck.NovoCampo.NOME('Sld23Abr13Rel').TIPO(ftFloat).AdicionarCampo;
  FCheck.NovoCampo.NOME('Sld23Abr13Pla').TIPO(ftFloat).AdicionarCampo;
  FCheck.NovoCampo.NOME('Sld26Set16Rel').TIPO(ftFloat).AdicionarCampo;
  FCheck.NovoCampo.NOME('Sld26Set16Pla').TIPO(ftFloat).AdicionarCampo;
  FCheck.CriarDataset;
  FCheck.Formatacampo('Grupo','Grupo',4, taCenter);
  FCheck.Formatacampo('Seq','Seq',2, taCenter);
  FCheck.Formatacampo('Cota','Cota',3, taCenter);
  FCheck.Formatacampo('Relatorio','Rel',2, taCenter);
  FCheck.Formatacampo('Planilha','Pla',2, taCenter);
  FCheck.Formatacampo('Sld23Abr13Rel', 'Rec Rel', 8, taRightJustify, '#,0.00');
  FCheck.Formatacampo('Sld23Abr13Pla', 'Rec Pla', 8, taRightJustify, '#,0.00');
  FCheck.Formatacampo('Sld26Set16Rel', 'Com Rel', 8, taRightJustify, '#,0.00');
  FCheck.Formatacampo('Sld26Set16Pla', 'Com Pla', 8, taRightJustify, '#,0.00');
end;

procedure Tfrmcheckrnp.Incluirfcheck(Pgrupo, Pseq, Pcota: String; Prel, Ppla: Integer; Precrel, Precpla, Pcomrel, Pcompla: Double);
begin
  Mensagem(Format('Gravando Cota: %s %s%s',[Pgrupo, Pseq, Pcota]));
  if FRnp.RetornaUmCheck(Pgrupo, Pseq, Pcota).DataSet.EOF
  then FRnp.NovoCheck(Pgrupo, Pseq, Pcota, Prel, Ppla,Precrel, Precpla, Pcomrel, Pcompla)
  else FRnp.GravarCheck(Pgrupo, Pseq, Pcota, Prel, Ppla,Precrel, Precpla, Pcomrel, Pcompla);
  //FCheck.NovoRegistro;
  //FCheck.CAMPO('Grupo').VALOR(pGrupo).AtribuirValor;
  //FCheck.CAMPO('Seq').VALOR(pSeq).AtribuirValor;
  //FCheck.CAMPO('Cota').VALOR(pCota).AtribuirValor;
  //FCheck.CAMPO('Relatorio').VALOR(pRel).AtribuirValor;
  //FCheck.CAMPO('Planilha').VALOR(Ppla).AtribuirValor;
  //FCheck.CAMPO('Sld23Abr13Rel').VALOR(pRecRel).AtribuirValor;
  //FCheck.CAMPO('Sld23Abr13Pla').VALOR(pRecPla).AtribuirValor;
  //FCheck.CAMPO('Sld26Set16Rel').VALOR(pComRel).AtribuirValor;
  //FCheck.CAMPO('Sld26Set16Pla').VALOR(pComPla).AtribuirValor;
  //FCheck.GravarRegistro;
end;

procedure Tfrmcheckrnp.Lerrelatorio(var Parquivo: Tstringlist);
var
  vGrupo, vSeq, vCota, vLinha, vGrupoCota: String;
  vSldRec, vSldCom: Double;
  vLin: Integer;
begin

  //Criarfcheck;
  vGrupoCota := '';
  vGrupo := '';
  vSeq := '';
  vCota := '';
  vSldCom := 0;
  vSldRec := 0;

  for vLin := 0 to Pred(pArquivo.Count) do
  begin
    vLinha := pArquivo[vLin];
    if StrToIntDef(Copy(vLinha,0,4), 0) > 100
    then begin
      if vGrupoCota <> Copy(vLinha, 0, 12)
      then begin
        if Length(Trim(vGrupoCota)) > 0
        then IncluirFCheck( vGrupo,
                            vSeq,
                            vCota, 1, 0,
                            vSldRec, 0,
                            vSldCom, 0);
        vGrupoCota := Copy(vLinha, 0, 12);
        vGrupo := Copy(vLinha,0,4);
        vSeq := Copy(vLinha,7,2);
        vCota := Copy(vLinha,9,3);
        vSldCom := 0;
        vSldRec := 0;
      end;
    end
    else begin
      if Copy(vLinha,126,8) = SLDREC
      then vSldRec := RetornaValor(Copy(vLinha, 146, 13));
      if Copy(vLinha,126,8) = SLDCOM
      then vSldCom := RetornaValor(Copy(vLinha, 146, 13));
    end;
  end;
  Mensagem('Fim da leitura do relatório...');
end;

procedure Tfrmcheckrnp.Mensagem(Pmsg: String);
begin
  lblMsg.Caption := Pmsg;
end;

end.

