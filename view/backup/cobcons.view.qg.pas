unit cobcons.view.qg;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, ActnList,
  StdCtrls, ComCtrls, DBCtrls, DBGrids, cobcons.controller.interfaces, Buttons,
  cobcons.model.interfaces, cobcons.model.bufferdataset;

type

  { TFrmQG }

  TFrmQG = class(TForm)
    AL: TActionList;
    Cancelar: TAction;
    Grid: TDBGrid;
    nv: TDBNavigator;
    ds: TDataSource;
    processar: TAction;
    mm: TMemo;
    PC: TPageControl;
    pnAcoes: TPanel;
    pnBack: TPanel;
    pnTitulo: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    gravar: TAction;
    tsDados: TTabSheet;
    tsObs: TTabSheet;
    procedure CancelarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gravarExecute(Sender: TObject);
    procedure processarExecute(Sender: TObject);
  private
    FDsBuf: iModelBufferDataset;
    FConexao: iModelConexao;
    FQuery: iQueryRest;
    procedure Conectar;
    procedure Alterar(pValor: Double; pAgente, pNrDocum, pAviso: String;
      pAlterar: Boolean);
    procedure PercorrerPagamentos;
    procedure CriarDsBuf;
    procedure IncluirDsBuf(pGrupo, pSeq, pCota, pAgente, pDoc, pAviso,
      pTpMov: String; pContab, pInaug: TDateTime; pValor, pVlMov: Double);
  public

  end;

const
  SQL_PAGT_RNP =
      'select G.PRIM_REU, M.grupo, M.seq, M.cota, M.tipo_mov, M.d_vencto, '+
             'M.dt_pagto, M.ag_finan, M.nr_docum, M.aviso, M.d_contab, '+
             'M.f_aquisi, M.f_reserv, M.outros '+
      'from ACMOV2 M '+
      'inner join A2GRU G on G.GRUPO = M.GRUPO '+
      'where m.D_CONTAB between ''01-apr-2022'' and ''30-apr-2022'' '+
                        'and m.tipo_mov in (''86'',''8D'',''96'',''99'') '+
                        'and m.av_assoc = ''000000'' '+
      'order by m.grupo, m.seq, m.cota';


var
  FrmQG: TFrmQG;

implementation

uses cobcons.model.configura, cobcons.model.planilha,
  cobcons.controller.factory, cobcons.controller.util;

{$R *.lfm}

{ TFrmQG }

procedure TFrmQG.FormCreate(Sender: TObject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnBack.Color := vEsquema.CorFundo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
end;

procedure TFrmQG.gravarExecute(Sender: TObject);
const
  PGMAIOR = '96';
var
  vAgente,
  vTpMov,
  vNrDoc,
  vAviso: String;
  vValor: Double;
begin
  if ConfirmaMensagem('Gravar as informações?')
  then begin
    FDsBuf.PrimeiroRegistro;
    while FDsBuf.TemDados do
    begin
      vTpMov := FDsBuf.DataSet.FieldByName('TpMov').AsString;
      vAgente := FDsBuf.DataSet.FieldByName('Agente').AsString;
      vNrDoc := FDsBuf.DataSet.FieldByName('Doc').AsString;
      vAviso := FDsBuf.DataSet.FieldByName('Aviso').AsString;
      vValor := FDsBuf.DataSet.FieldByName('Valor').AsFloat;
      Alterar(vValor, vAgente, vNrDoc, vAviso, (vTpMov <> PGMAIOR));
      FDsBuf.Proximo;
    end;
    TPlanilha.New.GerarPlanilha(FDsBuf,'PagtoRnpAbril2022.xls');
  end;
end;

procedure TFrmQG.CancelarExecute(Sender: TObject);
begin
  Close;
end;

procedure TFrmQG.processarExecute(Sender: TObject);
begin
  Conectar;
  FQuery.Open(SQL_PAGT_RNP);
  ds.DataSet := FQuery.Dataset;
  PercorrerPagamentos;
end;

procedure TFrmQG.Conectar;
begin
  FConexao := TControllerFactory.New.Conexao();
  FQuery := TControllerFactory.New.Query(FConexao);
end;

procedure TFrmQG.Alterar(pValor: Double; pAgente, pNrDocum, pAviso: String; pAlterar: Boolean);
const
  SQL_ALTERAR_MOV =
      'update ACMOV2 set f_aquisi = null, f_reserv = null, outros = %f '+
      'where  ag_finan = %s and nr_docum = %s and aviso = %s ';
  SQL_DELETAR_MOV =
      'delete from ACMOV2 where ag_finan = %s and nr_docum = %s and aviso = %s ';
var
  vQuery: iQueryRest;
  vSql: String;
begin
  vQuery := TControllerFactory.New.Query(FConexao);
  if pAlterar
  then begin
    FormatSettings.DecimalSeparator := '.';
    vSql := Format(SQL_ALTERAR_MOV, [ pValor,
                                      QuotedStr(pAgente),
                                      QuotedStr(pNrDocum),
                                      QuotedStr(pAviso)]);
    FormatSettings.DecimalSeparator := ',';
  end
  else vSql := Format(SQL_DELETAR_MOV, [ QuotedStr(pAgente),
                                         QuotedStr(pNrDocum),
                                         QuotedStr(pAviso)]);
  vQuery.Executar(vSql);
end;

procedure TFrmQG.PercorrerPagamentos;
var
  vGrupo, vCota, vSeq: String;
  vSaldo, vMov: Double;
  vLimite, vContab: TDateTime;
  vCalcular: iControllerTabularEncerrados;
begin
  vCalcular := TControllerFactory.New.TabularEncerrados;
  CriarDsBuf;
  FQuery.PrimeiroRegistro;
  while not FQuery.Vazio do
  begin
    vGrupo := FQuery.FieldByName('GRUPO').AsString;
    vSeq := FQuery.FieldByName('SEQ').AsString;
    vCota := FQuery.FieldByName('COTA').AsString;
    vContab := FQuery.FieldByName('d_contab').AsDateTime;
    vLimite := FQuery.FieldByName('dt_pagto').AsDateTime;
    if vLimite > vContab
    then vLimite := vContab;
    vMov := FQuery.FieldByName('f_aquisi').AsFloat +
            FQuery.FieldByName('f_reserv').AsFloat +
            FQuery.FieldByName('outros').AsFloat;
    vSaldo := vCalcular.DATALIMITE(vLimite-1).CalcularSaldoRnpCota(vGrupo, vSeq, vCota, nil);
    IncluirDsBuf( vGrupo, vSeq, vCota,
                  FQuery.FieldByName('ag_finan').AsString,
                  FQuery.FieldByName('NR_DOCUM').AsString,
                  FQuery.FieldByName('AVISO').AsString,
                  FQuery.FieldByName('tipo_mov').AsString,
                  vLimite,
                  FQuery.FieldByName('PRIM_REU').AsDateTime,
                  vSaldo, vMov );
    FQuery.ProximoRegistro;
  end;
  ds.DataSet := FDsBuf.DataSet;
end;

procedure TFrmQG.CriarDsBuf;
begin
  FDsBuf := TModelBufferDataset.New;
  FDsBuf.NovoCampo.NOME('Grupo').TIPO(ftString).TAMANHO(4).AdicionarCampo;
  FDsBuf.NovoCampo.NOME('Seq').TIPO(ftString).TAMANHO(2).AdicionarCampo;
  FDsBuf.NovoCampo.NOME('Cota').TIPO(ftString).TAMANHO(3).AdicionarCampo;
  FDsBuf.NovoCampo.NOME('Contab').TIPO(ftDateTime).AdicionarCampo;
  FDsBuf.NovoCampo.NOME('Inaug').TIPO(ftDateTime).AdicionarCampo;
  FDsBuf.NovoCampo.NOME('Agente').TIPO(ftString).TAMANHO(6).AdicionarCampo;
  FDsBuf.NovoCampo.NOME('Doc').TIPO(ftString).TAMANHO(6).AdicionarCampo;
  FDsBuf.NovoCampo.NOME('Aviso').TIPO(ftString).TAMANHO(6).AdicionarCampo;
  FDsBuf.NovoCampo.NOME('TpMov').TIPO(ftString).TAMANHO(2).AdicionarCampo;
  FDsBuf.NovoCampo.NOME('Valor').TIPO(ftFloat).AdicionarCampo;
  FDsBuf.NovoCampo.NOME('VlMov').TIPO(ftFloat).AdicionarCampo;
  FDsBuf.CriarDataset;
  FDsBuf.Formatacampo('Grupo', 'Grupo', 4, taCenter);
  FDsBuf.Formatacampo('Seq', 'Seq', 2, taCenter);
  FDsBuf.Formatacampo('Cota', 'Cota', 3, taCenter);
  FDsBuf.Formatacampo('Contab','Data',8, taCenter,'dd/mm/yyyy');
  FDsBuf.Formatacampo('Inaug','Pr.Reu.',8, taCenter,'dd/mm/yyyy');
  FDsBuf.Formatacampo('Agente', 'Agente', 6, taCenter);
  FDsBuf.Formatacampo('Doc', 'Doc', 6, taCenter);
  FDsBuf.Formatacampo('Aviso', 'Aviso', 6, taCenter);
  FDsBuf.Formatacampo('TpMov', 'Tipo', 2, taCenter);
  FDsBuf.Formatacampo('Valor', 'Valor', 8, taRightJustify, '#,0.00');
  FDsBuf.Formatacampo('VlMov', 'Vlr Mov', 8, taRightJustify, '#,0.00');
end;

procedure TFrmQG.IncluirDsBuf(pGrupo, pSeq, pCota, pAgente, pDoc,
  pAviso, pTpMov: String; pContab, pInaug: TDateTime; pValor, pVlMov: Double);
begin
  FDsBuf.NovoRegistro;
  FDsBuf.CAMPO('Grupo').VALOR(pGrupo).AtribuirValor;
  FDsBuf.CAMPO('Seq').VALOR(pSeq).AtribuirValor;
  FDsBuf.CAMPO('Cota').VALOR(pCota).AtribuirValor;
  FDsBuf.CAMPO('Contab').VALOR(pContab).AtribuirValor;
  FDsBuf.CAMPO('Inaug').VALOR(pInaug).AtribuirValor;
  FDsBuf.CAMPO('Agente').VALOR(pAgente).AtribuirValor;
  FDsBuf.CAMPO('Doc').VALOR(pDoc).AtribuirValor;
  FDsBuf.CAMPO('Aviso').VALOR(pAviso).AtribuirValor;
  FDsBuf.CAMPO('TpMov').VALOR(pTpMov).AtribuirValor;
  FDsBuf.CAMPO('Valor').VALOR(pValor).AtribuirValor;
  FDsBuf.CAMPO('VlMov').VALOR(pVlMov).AtribuirValor;
  FDsBuf.GravarRegistro;
end;

end.

