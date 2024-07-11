unit cobcons.controller.util;

{$mode delphi}

interface

uses
    Classes, SysUtils, maskutils, Dialogs, Controls, Forms, dateutils, strutils,
    windows, Math, variants, db, StdCtrls, IniFiles, ActnList, ExtDlgs,
    Graphics, ExtCtrls, cobcons.controller.interfaces, cobcons.model.planilha;

type

  { TFormataCampoData }

  iFormataCampoData = interface
    ['{4FCFA687-AC15-4B49-98A2-9EBF78ACE4CB}']
    procedure Formatar(pCampo: TDateTimeField; pTitulo, pMascara: String; pLargura: Integer; pAlinhamento: TAlignment; pVisivel: Boolean);
  end;
  TFormataCampoData = class (TInterfacedObject, iFormataCampoData)
    private
      procedure OnGetTextData(Sender: TField; var aText: String; DisplayText: Boolean);
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iFormataCampoData;
      procedure Formatar(pCampo: TDateTimeField; pTitulo, pMascara: String; pLargura: Integer; pAlinhamento: TAlignment; pVisivel: Boolean);
  end;

  TFormatacao = (tfCpf, tfCnpj, tfFone, tfCelular, tfCEP, tfInt2, tfInt3, tfInt4, tfInt6,
                 tfVal10Dec2);

  procedure DataSetParaPlanilha(pDataset: TDataSet; pNomeArquivo: String);
  function RetornarFormatado(str:String; tipo: TFormatacao): String;
  procedure MostraAviso(msg: String);
  procedure MostraErro(msg: String);
  function ConfirmaMensagem(msg: String): Boolean;
  function MostraMensagem(Msg: string; bt: Integer): Boolean;
  function TirarAcento(pString: String): String;
  function RetornaDataSql(aData: TDateTime): String;
  function RetornaTimeStampSql(aData: TDateTime): String;
  function RetornarNomeComputador: String;
  function RetornaSemFormatacao(aValue: String): string;
  function dtLiberado(xave, razao:string): TDateTime;
  function gerarChave(strPos, razao: string; dtLib: TDateTime): string;
  function posicaoLetra(letra: string): integer;
  function removeAcento(str:string): string;
  function RetornarDataExtenso(aData: TDatetime): string;
  function RetornarMesExtenso(pMes: Integer): string;
  function CriaForm(frmClass: TFormClass; out Obj): TModalResult; overload;
  procedure CriaForm(aParent: TPanel; frmClass: TFormClass; out Obj); overload;
  procedure AbrirFichaCota(pGrupo, pSeq, pCota: string);
  function DataEstaVazia(pData: TDateTime): Boolean;
  function RetornaDataString(pData: TDateTime; aMascara: string = 'dd/mm/yyyy'): String; overload;
  function RetornarPrecoData(pFil, pBem: String; pData: TDatetime): Double;
  function RetornarReuniaoAnterior(pGrupo: String; pData: TDatetime): TDateTime;
  procedure ImprimirPosicaoCota(pCliente: iControllerCota);
  function RetornarBD: String;
  function RetornaUsuarioLogado: iControllerUsuarioLogado;
  procedure TempoDecorrido(pMsg: String;pInicio: TDateTime);
  function TabularEncerrados: Boolean;
  procedure FormataCampoNumerico(pCampo: TField; pLabel: String; pLargura: Integer; pAlinhamento: TAlignment; pMascara: String = ',#0.00'; pVisible: Boolean = True);
  procedure FormataCampoTexto(pCampo: TField; pLabel: String; pLargura: Integer; pAlinhamento: TAlignment; pVisible: Boolean = True);
  procedure FormataCampoData(pCampo: TField; pTitulo: String; pLargura: Integer; pAlinhamento: TAlignment; pMascara: String = 'dd/mm/yyyy'; pVisible: Boolean = True);
  procedure ImprimirComissaoPermanencia(pComissao: Integer);
  function CalcularJuros(DtVenc: TDateTime; VlPrin: Double; DtAtual: TDateTime): Double;
  function CalcularMulta(DtVenc: TDateTime; VlPrin: Double; DtAtual: TDateTime): Double;
  function RetornaValor(pValor: String):Double;
  procedure GetCoordenadas(pForm: TForm);
  function RetornaDataSiacon(data: TDate): String;
  function RetornaGrupoAntes(pGrupo: String): Boolean;

implementation

uses cobcons.view.mensagem, cobcons.view.fichacota, cobcons.view.posicaocota,
  cobcons.view.tabularencerrados, cobcons.view.rel.itenscomissaopermanencia,
  cobcons.controller.factory;

var
  Posicao: string = 'ABaCDEbFGHcIJKdLMNOePQRfSghijTlUmVnWoXpYqrstuvxZz';
  L1: array[1..26] of string =
     ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
      'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
  L2: array[1..26] of string =
     ('0123456789', //a
      '1234567890', //b
      '2345678901', //c
      '3456789012', //d
      '4567890123', //e
      '5678901234', //f
      '6789012345', //g
      '7890123456', //h
      '8901234567', //i
      '9012345678', //j
      '0123456789', //k
      '1234567890', //l
      '2345678901', //m
      '3456789012', //n
      '4567890123', //o
      '5678901234', //p
      '6789012345', //q
      '7890123456', //r
      '8901234567', //s
      '9012345678', //t
      '0123456789', //u
      '1234567890',//v
      '2345678901',//w
      '3456789012',//x
      '4567890123',//y
      '5678901234' ); //z


function gerarChave(strPos, razao: string; dtLib: TDateTime): string;
var
  sPos,sNum, sLib: string;
  I, nPos: Integer;
begin
  sPos := '';
  sLib := Format('%.5d',[Trunc(dtLib)]);
  sNum := '';
  nPos := 0;
  for I := 1 to 5 do begin
    nPos := posicaoLetra(strPos[I]);
    while Copy(razao,nPos,1)=' ' do Inc(nPos);
    sPos := sPos + UpperCase(removeAcento(Copy(razao,nPos,1)));
  end;
  for I := 1 to 5 do begin
    nPos := ord(spos[I]) - 64;
    sNum := sNum + Copy(L2[nPos],StrToInt(sLib[I]),1);
  end;
  Result := sNum;
end;

function dtLiberado(xave, razao: string): TDateTime;
var
  sPos,sNum, vNum: string;
  iPos, I: Integer;
  dValido: TDateTime;
begin
  sPos := '';
  sNum := '';
  for I := 1 to Length(xave) do begin
    iPos := posicaoLetra(xave[I]);
    if iPos>0 then begin
      while copy(razao, Ipos, 1)=' ' do Inc(Ipos);
      sPos := sPos + UpperCase(removeAcento(copy(razao, Ipos, 1)));
    end
    else sNum := sNum + xave[I];
  end;
  vNum := '';
  for I := 1 to 5 do begin
    iPos := ord(sPos[I]) - 64;
    vNum := vNum + InttoStr(Pos(sNum[I],L2[Ipos])) ;
  end;
  dValido := StrToFloat(vNum);
  result := dValido;
end;

function posicaoLetra(letra: string): integer;
begin
  Result := Pos(letra, Posicao);
end;

function removeAcento(str: string): string;
const
  ComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
var
  nPos: Integer;
begin
  nPos := Pos(Str,ComAcento);
  if nPos <> 0
  then Str := SemAcento[nPos];
  Result := Str;
end;

function RetornarDataExtenso(aData: TDatetime): string;
const
   DiaSemana : array[1..7] of string = ('Domingo','Segunda-feira','Terça-feira',
                'Quarta-feira','Quinta-feira','Sexta-feira','Sábado');
var
   dia,mes,ano : Word;
begin
  DecodeDate(Adata,ano,mes,dia);
  Result := DiaSemana[DayofWeek(Adata)]+', '+IntToStr(dia)+
                          ' de '+RetornarMesExtenso(mes)+' de '+IntToStr(ano);;
End;

function RetornarMesExtenso(pMes: Integer): string;
const
   MesExt : array[1..12] of string = ('Janeiro','Fevereiro','Março','Abril',
     'Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro');
begin
  Result := '';
  if (pMes >= 1) or (pMes <= 12)
  then Result := MesExt[pMes];
end;

function CriaForm(frmClass: TFormClass; out Obj): TModalResult;
begin
  try
     TForm(Obj) := frmClass.Create(nil);
     //VerificarRotinas(TForm(Obj));
     //AplicarRestricoes(TForm(Obj));
     //TForm(Obj).Position := poDefault;
     TForm(Obj).SetBounds(150,92, TForm(Obj).Width, TForm(Obj).Height);
     Result := TForm(Obj).ShowModal;
  finally
         FreeAndNil(Obj);
  end;
End;


procedure CriaForm(aParent: TPanel; frmClass: TFormClass; out Obj);
begin
  if not Assigned(TForm(Obj))
  then begin
    TForm(Obj) := frmClass.Create(Application);
    //VerificarRotinas(TForm(Obj));
    //AplicarRestricoes(TForm(Obj));
    TForm(Obj).WindowState := wsMaximized;
    TForm(Obj).Parent := Aparent;
  end;
  TForm(Obj).ShowOnTop;
End;

procedure AbrirFichaCota(pGrupo, pSeq, pCota: string);
begin
  frmCli := TfrmCli.Create(nil);
  try
    frmCli.Grupo := Pgrupo;
    frmCli.Seq := Pseq;
    frmCli.Cota := Pcota;
    frmCli.ShowModal;
  finally
    frmCli.Free;
  end;
End;

function DataEstaVazia(pData: TDateTime): Boolean;
const
  DATA_VAZIA = '30/12/1899';
var
   vValida: Boolean;
begin
  Result := (Pdata <= StrToDate(DATA_VAZIA));
End;

function RetornaDataString(pData: TDateTime; aMascara: string): String;
const
  DATA_VAZIA = '30/12/1899';
begin
  Result := '';
  if Pdata > StrToDate(DATA_VAZIA)
  then Result := FormatDateTime(Amascara, Pdata);
End;

function RetornarPrecoData(pFil, pBem: String; pData: TDatetime): Double;
var
   vPre: iControllerPrecoBem;
begin
  vPre := TControllerFactory.New.PrecoBem;
  vPre.RetornaPrecoBemData(Pbem, Pfil, Pdata);
  Result := vPre.PRE_REAL;
End;

function RetornarReuniaoAnterior(pGrupo: String; pData: TDatetime): TDateTime;
var
   vReu: iControllerReuniao;
   vDataset: TDataSet;
begin
  vReu := TControllerFactory.New.Reuniao;
  vDataset := vReu.RetornaReuniaoPagamento(Pgrupo, Pdata).Dataset;
  if vDataset.EOF
  then Result := Pdata
  else Result := vDataset.FieldByName('DATA_REU').AsDateTime;
End;

procedure ImprimirPosicaoCota(pCliente: iControllerCota);
begin
  FrmPosicaoCota := TFrmPosicaoCota.Create(nil);
  try
    FrmPosicaoCota.Cliente := Pcliente;
    FrmPosicaoCota.ShowModal;
  finally
    FrmPosicaoCota.Free;
  end;
End;

function RetornarBD: String;
var
  arqIni: TIniFile;
  arqNome: string;
begin
  Result := '';
  arqNome := ExtractFilePath(Application.ExeName)+'CobCons.ini';
  if FileExists(arqNome) then begin
    arqIni := TIniFile.Create(arqNome);
    try
       Result := arqIni.ReadString('IBX','Protocolo','');
    finally
      arqIni.Free;
    end;
  end;
End;

function RetornaUsuarioLogado: iControllerUsuarioLogado;
begin
  Result := TControllerFactory.New.UsuarioLogado;
End;

procedure TempoDecorrido(pMsg: String; pInicio: TDateTime);
begin
  MostraAviso(Format('%s durou %s!',[pMsg, FormatDateTime('hh:mm:ss',(Now - Pinicio))]));
End;

function TabularEncerrados: Boolean;
begin
  FrmTabularEncerrados := TFrmTabularEncerrados.Create(nil);
  try
    Result := (FrmTabularEncerrados.ShowModal = mrOK);
  finally
    FrmTabularEncerrados.Free;
  end;
End;

procedure FormataCampoNumerico(pCampo: TField; pLabel: String;
  pLargura: Integer; pAlinhamento: TAlignment; pMascara: String;
  pVisible: Boolean);
begin
  if Pcampo <> nil
  then begin
    TNumericField(pCampo).DisplayFormat := pMascara;
    pCampo.Alignment := Palinhamento;
    pCampo.DisplayWidth := Plargura;
    pCampo.DisplayLabel := Plabel;
    Pcampo.Visible := Pvisible;
  end;
End;

procedure FormataCampoTexto(pCampo: TField; pLabel: String; pLargura: Integer;
  pAlinhamento: TAlignment; pVisible: Boolean);
begin
  if Pcampo <> nil
  then begin
    pCampo.Alignment := Palinhamento;
    pCampo.DisplayWidth := Plargura;
    pCampo.DisplayLabel := Plabel;
    Pcampo.Visible := Pvisible;
  end;
End;

procedure FormataCampoData(pCampo: TField; pTitulo: String; pLargura: Integer;
  pAlinhamento: TAlignment; pMascara: String; pVisible: Boolean);
begin
  if Pcampo <> nil
  then TFormataCampoData.New.Formatar(TDateTimeField( Pcampo ), Ptitulo, Pmascara, Plargura, Palinhamento, Pvisible);
End;

procedure ImprimirComissaoPermanencia(pComissao: Integer);
begin
  FrmRelItensComissaoPermanencia := TFrmRelItensComissaoPermanencia.Create(nil);
  try
     FrmRelItensComissaoPermanencia.Ds.DataSet := TControllerFactory.New.ItemComissaoPermanencia.ListarItensComissao(Pcomissao).DataSet;
     FrmRelItensComissaoPermanencia.Dsprs.DataSet := TControllerFactory.New.Empresa.RecuperarEmpresa.DataSet;
     FrmRelItensComissaoPermanencia.dscp.DataSet := TControllerFactory.New.ComissaoPermanencia.ListarPorCodigo(Pcomissao).DataSet;
     FrmRelItensComissaoPermanencia.Rl.PreviewModal;
  finally
    FrmRelItensComissaoPermanencia.Free;
  end;
End;

function CalcularJuros(DtVenc: TDateTime; VlPrin: Double; DtAtual: TDateTime
  ): Double;
var
  Dias: Integer;
  vEmpresa: iControllerEmpresa;
begin
  Result := 0;
  if DtAtual > DtVenc then begin
    vEmpresa := TControllerFactory.New.Empresa.RecuperarEmpresa;
    Dias := DaysBetween(DtAtual,DtVenc);
    Result := (VlPrin * (vEmpresa.PCJUROS /30)/100) * Dias;
  end;
End;

function CalcularMulta(DtVenc: TDateTime; VlPrin: Double; DtAtual: TDateTime
  ): Double;
var
  vEmpresa : iControllerEmpresa;
begin
  Result := 0;
  if Dtvenc < Dtatual
  then begin
    vEmpresa := TControllerFactory.New.Empresa.RecuperarEmpresa;
    Result := Vlprin * vEmpresa.PCMULTAS / 100;
  end;
End;

function RetornaValor(pValor: String): Double;
const
  VALIDO = '-0123456789,';
var
   vChr,vNum: String;
   I: integer;
begin
  Result := 0.0;
  if Length(Trim(pValor)) > 0
  then begin
    vNum := '';
    for I := 0 to Length(Pvalor) do
    begin
      vChr:= Pvalor[I];
      if pOS(vChr,VALIDO) > 0
      then vNum := vNum + vChr;
    end;
    Result := StrToFloatDef(vNum, 0);
  end;
End;

procedure GetCoordenadas(pForm: TForm);
var
  Tasklist : HWnd;
  Bordered : TRect;
  vAlt, vLar: Integer;
begin
  vAlt := Screen.Height;
  vLar := Screen.Width;
  Tasklist := FindWindow('Shell_TrayWnd', nil);
  GetWindowRect(Tasklist, Bordered);
  if vAlt = (Bordered.Bottom - Bordered.Top)    // barra vertical
  then begin
    Pform.Top := 0;
    Pform.Height := vAlt;
    if Bordered.Left = 0                       // esquerda
    then begin
      Pform.Left := Bordered.Right;
      Pform.Width := vLar - Bordered.Right;
    end
    else begin                                 // direita
      Pform.Left := 0;
      Pform.Width := Bordered.Left;
    end;
  end
  else begin                                   // barra horizontal
    Pform.Left := 0;
    Pform.Width := vLar;
    if Bordered.Top = 0
    then begin                                 // superior
      Pform.Top := Bordered.Bottom;
      Pform.Height := vAlt - Bordered.Bottom;
    end
    else begin                                 // inferior
      Pform.Top := 0;
      Pform.Height := Bordered.Top;
    end;
  end;
End;

function RetornaDataSiacon(data: TDate): String;
var
  ano, dif, dec: Integer;
  strAno: String;
  letras: String;
begin
  ano := YearOf(data);
  letras:='ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  if ano < 2000
  then strAno:=Format('%2d',[ano-1900])
  else begin
    dif:=ano-2000;
    dec:=trunc(dif/10);
    strAno:=Format('%s%d',[letras[dec+1],(dif-(dec*10))]);
  end;
  Result:=Format('%s%s',[strAno, FormatDateTime('mmdd',data)]);
end;

function RetornaGrupoAntes(pGrupo: String): Boolean;
const
  DATA_COMPARAR = '05/02/2009';
begin
  Result := TControllerFactory.New.Grupo.RetornaGrupo(pGrupo).PRIM_REU <= StrToDate(DATA_COMPARAR);
end;

procedure DataSetParaPlanilha(pDataset: TDataSet; pNomeArquivo: String);
begin
  TPlanilha.New.GerarPlanilha(pDataset, pNomeArquivo);
end;

function RetornarFormatado(str: String; tipo: TFormatacao): String;
var
  tamStr: Integer;
begin
  tamStr:=Length(Trim(str));
  Result := str;
  if tamStr > 0
  then begin
    case tipo of
      tfCpf:
        if tamStr = 11
        then Result:= FormatMaskText('000\.000\.000\-00;0;_',str);
      tfCnpj:
        if tamStr = 14
        then Result:= FormatMaskText('00\.000\.000\/0000\-00;0;_',str);
      tfFone: begin
        case tamStr of
          10: Result := FormatMaskText('\(99\)9999\-9999;0;_',str );
           8: Result:=FormatMaskText('9999\-9999;0;_',str )
        end;
      end;
      tfCelular: begin
        case tamStr of
          11: Result := FormatMaskText('\(99\)99999\-9999;0;_',str ) ;
          10: Result := FormatMaskText('\(99\)9999\-9999;0;_',str );
           9: Result := FormatMaskText('99999\-9999;0;_',str );
           8: Result := FormatMaskText('9999\-9999;0;_',str );
        end;
      end;
      tfCEP: if tamStr = 8
             then Result:= FormatMaskText('00\.000\-000;0;_',str);
      tfInt2: Result:= Format('%.2d',[StrToIntDef(Str,0)]);
      tfInt3: Result:= Format('%.3d',[StrToIntDef(Str,0)]);
      tfInt4: Result:= Format('%.4d',[StrToIntDef(Str,0)]);
      tfInt6: Result:= Format('%.6d',[StrToIntDef(Str,0)]);
      tfVal10Dec2: Result:= Format('%10.2n',[StrToFloatDef(Str,0)]);
    end;
  end;
End;

procedure MostraAviso(msg: String);
begin
  MostraMensagem(Msg,2);
End;

procedure MostraErro(msg: String);
begin
  MostraMensagem(Msg,2);
End;

function ConfirmaMensagem(msg: String): Boolean;
begin
  Result := MostraMensagem(Msg, 0);
End;

function MostraMensagem(Msg: string; bt: Integer): Boolean;
begin
  FrmMsg := TFrmMsg.Create(nil);
  try
     FrmMsg.bt := bt;
     FrmMsg.pnMsg.Caption := Msg;
     Result := (FrmMsg.ShowModal = mrOk);
  finally
    FrmMsg.Free;
  end;
End;

function TirarAcento(pString: String): String;
type
 USAscii20127 = type AnsiString(20127);
begin
  Result := string(USAscii20127(Pstring));
End;

function RetornaDataSql(aData: TDateTime): String;
const
  Meses : array[1..12] of string = ('jan', 'feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec');
begin
  //Result := Format('%d-%s-%d',[DayOf(Adata), Meses[MonthOf(Adata)],YearOf(Adata)]);
  Result := RetornaDataString(aData);
End;

function RetornaTimeStampSql(aData: TDateTime): String;
begin
  Result := Retornadatasql(Adata) + ' '+FormatDateTime('hh:mm:ss', Adata);
End;

function RetornarNomeComputador: String;
var
  ipbuffer : string;
  nsize : dword;
begin
  nsize:=255;
  SetLength(ipbuffer,nsize);
  if GetComputerName(PChar(ipbuffer),nsize)
  then Result := Trim(PChar(ipbuffer))
  else Result :='Não Determinado!';
End;

function RetornaSemFormatacao(aValue: String): string;
const EXCECAO = '.-/()\';
var I: Integer;
    vStr: String;
begin
  Result := '';
  vStr := Trim(Avalue);
  for I := 1 to Length(Avalue) do
    if Pos(Avalue[I],EXCECAO) = 0
    then Result := Result + Avalue[I];
End;

{ TFormataCampoData }

procedure Tformatacampodata.Ongettextdata(Sender: Tfield;
  var Atext: String; Displaytext: Boolean);
const
     DATA_VAZIA = '30/12/1899';
begin
  if (Sender).AsDateTime <= StrToDate(DATA_VAZIA)
  then Atext := ''
  else Atext := FormatDateTime((Sender as TDateTimeField).DisplayFormat, (Sender).AsDateTime );
End;

constructor Tformatacampodata.Create;
begin

end;

destructor Tformatacampodata.Destroy;
begin
  inherited Destroy;
end;

class function Tformatacampodata.New: Iformatacampodata;
begin
  Result := Self.Create;
end;

procedure Tformatacampodata.Formatar(Pcampo: Tdatetimefield; Ptitulo, Pmascara: String; Plargura: Integer; Palinhamento: Talignment; Pvisivel: Boolean);
begin
  TDateTimeField(pCampo).OnGetText := OnGetTextData;
  TDateTimeField(pCampo).DisplayFormat := Pmascara;
  pCampo.Alignment := Palinhamento;
  pCampo.DisplayWidth := Plargura;
  pCampo.DisplayLabel := Ptitulo;
  Pcampo.Visible := Pvisivel;
end;

end.

