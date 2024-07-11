unit cobcons.model.fichapagamentos;

{$mode delphi}

interface

uses
  Classes, Sysutils, Math, Controls, cobcons.model.interfaces,
  cobcons.model.bufferdataset, DateUtils, cobcons.controller.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TModelFichaPagamentos }

   TModelFichaPagamentos = class (TInterfacedObject, iModelFichaPagamentos)
     private
       FQuery: iQueryRest;
       FCCDev: iModelBufferDataset;
       FCdsMov: iModelBufferDataset;
       FCdsCob: iModelBufferDataset;
       FTotCot: iModelBufferDataset;
       FSldDev: iModelBufferDataset;
       FEmpresa: iControllerEmpresa;

       FGrupo: String;
       FSeq: String;
       FCota: String;
       FDataLimite: TDateTime;
       FDtRecompoeRnp: TDateTime;
       FSldInicialRnp: Double;
       //function RetornarSQL(pTipo: Integer): string;

       procedure CriarDatasetCCDev;
       procedure CriarDatasetCdsMov;
       procedure CriarDatasetCdsCob;
       procedure CriarDatasetTtCota;
       procedure CriarDatasetSldDev;
       function CalcularJuros(DtVenc: TDateTime; VlPrin: Double; DtAtual: TDateTime): Double;
       function CalcularMulta(DtVenc: TDateTime; VlPrin: Double; DtAtual: TDateTime): Double;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelFichaPagamentos;

       function GRUPO(aValue: String): iModelFichaPagamentos;
       function SEQ(aValue: String): iModelFichaPagamentos;
       function COTA(aValue: String): iModelFichaPagamentos;
       function DATALIMITE(aValue: TDateTime): iModelFichaPagamentos;
       function DTRECOMPOESALDORNP(aValue: TDateTime): iModelFichaPagamentos;
       function SaldoInicialRnp: Double;
       function CalcularSaldoDevedorCota: TDataSet;
       function MontarPagamentos: TDataSet;
       function MontarPendencias: TDataSet;
       function RetornarTotaisCota: TDataSet;
       function ContaCorrenteDevolucoes: TDataSet;
   end;

const
  MASK_DATA_ANO2 = 'dd/mm/yy';
  MASK_DATA_ANO4 = 'dd/mm/yyyy';
  DATA_INICIAL = '01/01/1970';
  ZERO = 0.0099999;

implementation

uses cobcons.controller.util, cobcons.controller.factory,
  cobcons.model.sql.factory;

{ TModelFichaPagamentos }

procedure Tmodelfichapagamentos.Criardatasetccdev;
begin
  FCCDev := TModelBufferDataset.New;
  FCCDev.NovoCampo.NOME('DtCtb').TIPO(ftDateTime).AdicionarCampo;
  FCCDev.NovoCampo.NOME('Tipo').TIPO(ftString).TAMANHO(25).AdicionarCampo;
  FCCDev.NovoCampo.NOME('Valor').TIPO(ftFloat).AdicionarCampo;
  FCCDev.NovoCampo.NOME('Saldo').TIPO(ftFloat).AdicionarCampo;
  FCCDev.CriarDataset;
  FCCDev.Formatacampo('DtCtb','Data',8, taCenter,'dd/mm/yyyy');
  FCCDev.Formatacampo('Tipo', 'Tipo', 20, taLeftJustify);
  FCCDev.Formatacampo('Valor', 'Valor', 8, taRightJustify, '#,0.00');
  FCCDev.Formatacampo('Saldo', 'Saldo', 8, taRightJustify, '#,0.00');
end;

procedure Tmodelfichapagamentos.Criardatasetcdsmov;
begin
  FCdsMov := TModelBufferDataset.New;
  FCdsMov.NovoCampo.NOME('Reu').TIPO(ftString).TAMANHO(3).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('Tipo').TIPO(ftString).TAMANHO(10).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('Vencto').TIPO(ftString).TAMANHO(8).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('Pagto').TIPO(ftString).TAMANHO(8).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('DtReu').TIPO(ftString).TAMANHO(8).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('Simb').TIPO(ftString).TAMANHO(5).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('VlBem').TIPO(ftFloat).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('Per').TIPO(ftFloat).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('Rat').TIPO(ftFloat).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('VlTot').TIPO(ftFloat).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('Mulju').TIPO(ftFloat).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('DtCtb').TIPO(ftString).TAMANHO(8).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('VlReal').TIPO(ftFloat).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('VlPag').TIPO(ftFloat).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('FdRes').TIPO(ftFloat).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('TxAdm').TIPO(ftFloat).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('Outros').TIPO(ftFloat).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('DcBem').TIPO(ftString).TAMANHO(30).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('Hist').TIPO(ftString).TAMANHO(60).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('Aviso').TIPO(ftString).TAMANHO(6).AdicionarCampo;
  FCdsMov.NovoCampo.NOME('TpMov').TIPO(ftString).TAMANHO(2).AdicionarCampo;
  FCdsMov.CriarDataset;
  FCdsMov.Formatacampo('Reu','Par',3, taCenter);
  FCdsMov.Formatacampo('Tipo', 'Tipo', 8, taLeftJustify);
  FCdsMov.Formatacampo('Vencto', 'Vencto', 5, taCenter);
  FCdsMov.Formatacampo('Pagto', 'Pagto', 6, taCenter);
  FCdsMov.Formatacampo('DtReu', 'Reunião', 5, taCenter);
  FCdsMov.Formatacampo('Simb', '$', 2, taCenter);
  FCdsMov.Formatacampo('VlBem', 'Vlr.Bem', 5, taRightJustify, '#,0.00');
  FCdsMov.Formatacampo('Per', '% Pago', 4, taRightJustify, '#,0.0000');
  FCdsMov.Formatacampo('Rat', '% Rat', 4, taRightJustify, '#,0.0000');
  FCdsMov.Formatacampo('VlTot', 'Vlr. Pago', 3, taRightJustify, '#,0.00');
  FCdsMov.Formatacampo('Mulju', 'Mul/Jur', 10, taRightJustify, '#,0.00', False);
  FCdsMov.Formatacampo('DtCtb', 'Dt.Cont.', 10, taCenter, '', False);
  FCdsMov.Formatacampo('VlReal', 'Vlr. R$', 10, taRightJustify, '#,0.00', False);
  FCdsMov.Formatacampo('VlPag', 'Aquisicao', 10, taRightJustify, '#,0.00', False);
  FCdsMov.Formatacampo('FdRes', 'Reserva', 10, taRightJustify, '#,0.00', False);
  FCdsMov.Formatacampo('TxAdm', 'Tx.Adm.', 10, taRightJustify, '#,0.00', False);
  FCdsMov.Formatacampo('Outros', 'Seg/Outros', 10, taRightJustify, '#,0.00', False);
  FCdsMov.Formatacampo('DcBem', 'Bem', 20, taLeftJustify, '', False);
  FCdsMov.Formatacampo('Hist', 'Historico', 60, taLeftJustify, '', False);
  FCdsMov.Formatacampo('Aviso', 'Aviso', 6, taCenter, '', False);
  FCdsMov.Formatacampo('TpMov', 'Tp', 6, taCenter, '', False);
end;

procedure Tmodelfichapagamentos.Criardatasetcdscob;
begin
  FCdsCob := TModelBufferDataset.New;
  FCdsCob.NovoCampo.NOME('Aviso').TIPO(ftString).TAMANHO(6).AdicionarCampo;
  FCdsCob.NovoCampo.NOME('Reu').TIPO(ftString).TAMANHO(3).AdicionarCampo;
  FCdsCob.NovoCampo.NOME('TpPen').TIPO(ftString).TAMANHO(10).AdicionarCampo;
  FCdsCob.NovoCampo.NOME('Vencto').TIPO(ftString).TAMANHO(10).AdicionarCampo;
  FCdsCob.NovoCampo.NOME('VlBem').TIPO(ftFloat).AdicionarCampo;
  FCdsCob.NovoCampo.NOME('PcNormal').TIPO(ftFloat).AdicionarCampo;
  FCdsCob.NovoCampo.NOME('PcRat').TIPO(ftFloat).AdicionarCampo;
  FCdsCob.NovoCampo.NOME('VPend').TIPO(ftFloat).AdicionarCampo;
  FCdsCob.NovoCampo.NOME('VlMul').TIPO(ftFloat).AdicionarCampo;
  FCdsCob.NovoCampo.NOME('VlJur').TIPO(ftFloat).AdicionarCampo;
  FCdsCob.NovoCampo.NOME('VlMulJur').TIPO(ftFloat).AdicionarCampo;
  FCdsCob.NovoCampo.NOME('VlTot').TIPO(ftFloat).AdicionarCampo;
  FCdsCob.CriarDataset;
  FCdsCob.Formatacampo('Aviso', 'Aviso', 4, taCenter, '', False);
  FCdsCob.Formatacampo('Reu','Reu',3, taCenter);
  FCdsCob.Formatacampo('TpPen', 'Tipo', 8, taLeftJustify);
  FCdsCob.Formatacampo('Vencto', 'Vencto', 5, taCenter);
  FCdsCob.Formatacampo('VlBem', 'Vlr.Bem', 5, taRightJustify, '#,0.00');
  FCdsCob.Formatacampo('PcNormal', '% Nor', 5, taCenter, '#,0.0000');
  FCdsCob.Formatacampo('PcRat', '% Rat', 5, taCenter, '#,0.0000');
  FCdsCob.Formatacampo('VPend', 'Valor', 5, taRightJustify, '#,0.00');
  FCdsCob.Formatacampo('VlMul', 'Multa', 5, taRightJustify, '#,0.00', False);
  FCdsCob.Formatacampo('VlJur', 'Juros', 5, taRightJustify, '#,0.00', False);
  FCdsCob.Formatacampo('VlMulJur', 'Mul/Jur', 5, taRightJustify, '#,0.00');
  FCdsCob.Formatacampo('VlTot', 'Total', 5, taRightJustify, '#,0.00');
end;

procedure Tmodelfichapagamentos.Criardatasetttcota;
begin
  FTotCot := TModelBufferDataset.New;
  FTotCot.NovoCampo.NOME('TtPcNor').TIPO(ftFloat).AdicionarCampo;
  FTotCot.NovoCampo.NOME('TtPcRat').TIPO(ftFloat).AdicionarCampo;
  FTotCot.NovoCampo.NOME('TtPend').TIPO(ftFloat).AdicionarCampo;
  FTotCot.NovoCampo.NOME('TtTot').TIPO(ftFloat).AdicionarCampo;
  FTotCot.NovoCampo.NOME('TtMul').TIPO(ftFloat).AdicionarCampo;
  FTotCot.NovoCampo.NOME('TtJur').TIPO(ftFloat).AdicionarCampo;
  FTotCot.NovoCampo.NOME('TTPer').TIPO(ftFloat).AdicionarCampo;
  FTotCot.NovoCampo.NOME('TTRat').TIPO(ftFloat).AdicionarCampo;
  FTotCot.NovoCampo.NOME('TtPag').TIPO(ftFloat).AdicionarCampo;
  FTotCot.NovoCampo.NOME('TtRes').TIPO(ftFloat).AdicionarCampo;
  FTotCot.NovoCampo.NOME('TTAdm').TIPO(ftFloat).AdicionarCampo;
  FTotCot.NovoCampo.NOME('TTMulPG').TIPO(ftFloat).AdicionarCampo;
  FTotCot.NovoCampo.NOME('TTReal').TIPO(ftFloat).AdicionarCampo;
  FTotCot.CriarDataset;
  FTotCot.Formatacampo('TtPcNor', '% Nor', 5, taRightJustify, '#,0.0000');
  FTotCot.Formatacampo('TtPcRat', '% Rat', 5, taRightJustify, '#,0.0000');
  FTotCot.Formatacampo('TtPend', 'Vlr Pen', 4, taRightJustify, '#,0.00');
  FTotCot.Formatacampo('TtTot', 'Vlr. Pago', 3, taRightJustify, '#,0.00');
  FTotCot.Formatacampo('TtMul', 'Multas', 10, taRightJustify, '#,0.00');
  FTotCot.Formatacampo('TtJur', 'Juros', 10, taRightJustify, '#,0.00');
  FTotCot.Formatacampo('TTPer', '% Aqu', 10, taRightJustify, '#,0.0000');
  FTotCot.Formatacampo('TTRat', '% Rat', 10, taRightJustify, '#,0.0000');
  FTotCot.Formatacampo('TtPag', 'TtPag', 10, taRightJustify, '#,0.00');
  FTotCot.Formatacampo('TTAdm', 'TTAdm', 10, taRightJustify, '#,0.00');
  FTotCot.Formatacampo('TtRes', 'TtRes', 10, taRightJustify, '#,0.00');
  FTotCot.Formatacampo('TTMulPG', 'TTMulPG', 10, taRightJustify, '#,0.00');
  FTotCot.Formatacampo('TTReal', 'TTReal', 10, taRightJustify, '#,0.00');
end;

procedure Tmodelfichapagamentos.Criardatasetslddev;
begin
  FSldDev := TModelBufferDataset.New;
  FSldDev.NovoCampo.NOME('FCAqui').TIPO(ftFloat).AdicionarCampo;
  FSldDev.NovoCampo.NOME('RaAqui').TIPO(ftFloat).AdicionarCampo;
  FSldDev.NovoCampo.NOME('FCAdm').TIPO(ftFloat).AdicionarCampo;
  FSldDev.NovoCampo.NOME('RaAdm').TIPO(ftFloat).AdicionarCampo;
  FSldDev.NovoCampo.NOME('FdRes').TIPO(ftFloat).AdicionarCampo;
  FSldDev.NovoCampo.NOME('FCDev').TIPO(ftFloat).AdicionarCampo;
  FSldDev.NovoCampo.NOME('RaDev').TIPO(ftFloat).AdicionarCampo;
  FSldDev.NovoCampo.NOME('SldDev').TIPO(ftFloat).AdicionarCampo;
  FSldDev.NovoCampo.NOME('TTAdm').TIPO(ftFloat).AdicionarCampo;
  FSldDev.CriarDataset;
  FSldDev.Formatacampo('FCAqui', 'FCAqui', 10, taRightJustify, '#,0.00');
  FSldDev.Formatacampo('RaAqui', 'RaAqui', 10, taRightJustify, '#,0.00');
  FSldDev.Formatacampo('FCAdm', 'FCAdm', 10, taRightJustify, '#,0.00');
  FSldDev.Formatacampo('RaAdm', 'RaAdm', 10, taRightJustify, '#,0.00');
  FSldDev.Formatacampo('FdRes', 'FdRes', 10, taRightJustify, '#,0.00');
  FSldDev.Formatacampo('FCDev', 'FCDev', 10, taRightJustify, '#,0.00');
  FSldDev.Formatacampo('RaDev', 'RaDev', 10, taRightJustify, '#,0.00');
  FSldDev.Formatacampo('SldDev', 'SldDev', 10, taRightJustify, '#,0.00');
  FSldDev.Formatacampo('TTAdm', 'TTAdm', 10, taRightJustify, '#,0.00');
end;

function Tmodelfichapagamentos.Calcularjuros(Dtvenc: Tdatetime; Vlprin: Double; Dtatual: Tdatetime): Double;
var
  Dias: Integer;
begin
  Result := 0;
  if DtAtual > DtVenc then begin
    Dias := DaysBetween(DtAtual,DtVenc);
    Result := (VlPrin * (FEmpresa.PCJUROS /30)/100) * Dias;
  end;
end;

function Tmodelfichapagamentos.Calcularmulta(Dtvenc: Tdatetime; Vlprin: Double; Dtatual: Tdatetime): Double;
begin
  Result := 0;
  if Dtvenc < Dtatual
  then Result := Vlprin * FEmpresa.PCMULTAS / 100;
end;

constructor Tmodelfichapagamentos.Create(Aquery: Iqueryrest);
begin
  FQuery := Aquery;
  FEmpresa := TControllerFactory.New.Empresa.RecuperarEmpresa;
  FSldInicialRnp := 0;
  FDtRecompoeRnp := FEmpresa.DTRECSLDRNP;
  if FEmpresa.DTRECSLDRNP < StrToDate(DATA_INICIAL)
  then FDtRecompoeRnp := StrToDate(DATA_INICIAL)
end;

destructor Tmodelfichapagamentos.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelfichapagamentos.New(Aquery: Iqueryrest): Imodelfichapagamentos;
begin
  Result := Self.Create(Aquery);
end;

function Tmodelfichapagamentos.Grupo(Avalue: String): Imodelfichapagamentos;
begin
  Result := Self;
  FGrupo := Avalue;
end;

function Tmodelfichapagamentos.Seq(Avalue: String): Imodelfichapagamentos;
begin
  Result := Self;
  FSeq := Avalue;
end;

function Tmodelfichapagamentos.Cota(Avalue: String): Imodelfichapagamentos;
begin
  Result := Self;
  FCota := Avalue;
end;

function Tmodelfichapagamentos.Datalimite(Avalue: Tdatetime): Imodelfichapagamentos;
begin
  Result := Self;
  FDataLimite := Avalue;
end;

function Tmodelfichapagamentos.Dtrecompoesaldornp(Avalue: Tdatetime): Imodelfichapagamentos;
begin
  Result := Self;
  FDtRecompoeRnp := Avalue;
end;

function Tmodelfichapagamentos.Saldoinicialrnp: Double;
begin
 Result := FSldInicialRnp;
end;

function Tmodelfichapagamentos.Calcularsaldodevedorcota: Tdataset;
var
  vFcAqui, vFcAdm, vFdRes,
  vRaAqui, vRaAdm, vFcDev, vRaDev: Double;
  vCliente: iControllerCota;
begin
  vCliente := TControllerFactory.New.Cota;
  vCliente.PesquisarGrupoSeqCota(FGrupo, FSeq, FCota);

  vFcAqui := vCliente.PERDEV * vCliente.PRE_TABE / 100;
  vFcAdm := vFcAqui * vCliente.P_ADMINS / 100;
  vFdRes := vFcAqui * vCliente.P_RESERV / 100;
  vRaAqui := vCliente.PERRAT * vCliente.PRE_TABE / 100;
  vRaAdm := vRaAqui * vCliente.P_ADMINS / 100;
  vFcDev := vFcAqui + vFcAdm + vFdRes;
  vRaDev := vRaAqui + vRaAdm;

  CriarDatasetSldDev;

  FSldDev.NovoRegistro;
  FSldDev.CAMPO('FCAqui').VALOR(vFcAqui).AtribuirValor;
  FSldDev.CAMPO('FCAdm').VALOR(vFcAdm).AtribuirValor;
  FSldDev.CAMPO('FdRes').VALOR(vFdRes).AtribuirValor;
  FSldDev.CAMPO('RaAqui').VALOR(vRaAqui).AtribuirValor;
  FSldDev.CAMPO('RaAdm').VALOR(vRaAdm).AtribuirValor;
  FSldDev.CAMPO('FCDev').VALOR(vFcDev).AtribuirValor;
  FSldDev.CAMPO('RaDev').VALOR(vRaDev).AtribuirValor;
  FSldDev.CAMPO('SldDev').VALOR(vFcDev + vRaDev).AtribuirValor;
  FSldDev.CAMPO('TTAdm').VALOR(vFcAdm + vRaAdm).AtribuirValor;
  FSldDev.GravarRegistro;

  Result := FSldDev.DataSet;
end;

function Tmodelfichapagamentos.Montarpagamentos: Tdataset;
const
  TIPOS_TRATADOS = '21|C1|73|H3|83|I3|71|H1|82|I2';
var
  tMov: Integer;
  vReu : TDataset;
  vPagamentos: iControllerPagamentos;
  vReuniao: iControllerReuniao;
  vPreco: iControllerPrecoBem;
begin

  vReuniao := TControllerFactory.New.Reuniao;
  vPagamentos := TControllerFactory.New.Pagamentos;
  vPreco := TControllerFactory.New.PrecoBem;

  vPagamentos.RetornaPagamentosCota(FGrupo, FSeq, FCota);

  CriarDatasetCdsMov;

  while vPagamentos.TemDados do begin
    FCdsMov.NovoRegistro;

    vReu := vReuniao
               .RetornaReuniaoPagamento(FGrupo, vPagamentos.DT_PAGTO)
               .Dataset;

    if not vReu.EOF then begin
      FCdsMov.CAMPO('Reu').VALOR(vReu.FieldByName('NRO_REU').AsString).AtribuirValor;
      FCdsMov.CAMPO('DtReu').VALOR(RetornaDataString(vReu.FieldByName('DATA_REU').AsDateTime, MASK_DATA_ANO2)).AtribuirValor;
      FCdsMov.CAMPO('VlBem').VALOR( vPreco.RetornaPrecoBemData( vPagamentos.BEM,
                                                                vPagamentos.FIL_COM,
                                                                vReu.FieldByName('DATA_REU').AsDateTime)
                                                                .PRE_REAL)
                            .AtribuirValor;
    end
    else begin
      FCdsMov.CAMPO('Reu').VALOR('999').AtribuirValor;
      FCdsMov.CAMPO('DtReu').VALOR('').AtribuirValor;
      FCdsMov.CAMPO('VlBem').VALOR(vPreco.RetornaPrecoBemData( vPagamentos.BEM,
                                                               vPagamentos.FIL_COM,
                                                               vPagamentos.DT_PAGTO).PRE_REAL).AtribuirValor;
    end;

    FCdsMov.CAMPO('Aviso').VALOR(vPagamentos.AVISO).AtribuirValor;
    FCdsMov.CAMPO('Tipo').VALOR(vPagamentos.DCTIPOMOV).AtribuirValor;
    FCdsMov.CAMPO('TpMov').VALOR(vPagamentos.TIPO_MOV).AtribuirValor;
    FCdsMov.CAMPO('Simb').VALOR(vPagamentos.SIMBOLO).AtribuirValor;

    FCdsMov.CAMPO('DtCtb').VALOR(FormatDateTime(MASK_DATA_ANO2, vPagamentos.D_CONTAB)).AtribuirValor;
    FCdsMov.CAMPO('Pagto').VALOR(FormatDateTime(MASK_DATA_ANO2, vPagamentos.DT_PAGTO)).AtribuirValor;

    tMov := Pos(vPagamentos.TIPO_MOV, TIPOS_TRATADOS);

    case tMov of
      // ------------------------------------------------- 21|C1 apreensão e estorno
      1, 4: FCdsMov.CAMPO('Hist').VALOR(Format('VLR %8.2n %s',
                 [ vPagamentos.VALOR, vPagamentos.HISTORIC ])).AtribuirValor;
      // --------------------------------------- 73|H3 credito e estorno crédito de perc
      7, 10: begin
        FCdsMov.CAMPO('Vencto').VALOR(FormatDateTime(MASK_DATA_ANO2, vPagamentos.D_VENCTO)).AtribuirValor;
        FCdsMov.CAMPO('Per').VALOR( vPagamentos.P_NORMAL +
                                    vPagamentos.P_DIFER +
                                    vPagamentos.P_ANTEC).AtribuirValor;
        FCdsMov.CAMPO('Rat').VALOR(vPagamentos.P_RATEIO).AtribuirValor;
        FCdsMov.CAMPO('Hist').VALOR(vPagamentos.HISTORIC).AtribuirValor;
      end;
      // ----------------------- 83|I3 credito e estorno debito de perc
      13, 16: begin
        FCdsMov.CAMPO('Vencto').VALOR(FormatDateTime(MASK_DATA_ANO2, vPagamentos.D_VENCTO)).AtribuirValor;
        FCdsMov.CAMPO('Per').VALOR( vPagamentos.P_NORMAL +
                                    vPagamentos.P_DIFER +
                                    vPagamentos.P_ANTEC).AtribuirValor;
        FCdsMov.CAMPO('Rat').VALOR(vPagamentos.P_RATEIO).AtribuirValor;
        FCdsMov.CAMPO('Hist').VALOR(vPagamentos.HISTORIC).AtribuirValor;
      end;
      // ------------------------  71|H1 credito e estorno credito troca bem
      19, 22: begin
        FCdsMov.CAMPO('Vencto').VALOR(FormatDateTime(MASK_DATA_ANO2, vPagamentos.D_VENCTO)).AtribuirValor;
        FCdsMov.CAMPO('Per').VALOR( vPagamentos.P_NORMAL +
                                    vPagamentos.P_DIFER +
                                    vPagamentos.P_ANTEC).AtribuirValor;
        FCdsMov.CAMPO('Rat').VALOR(vPagamentos.P_RATEIO).AtribuirValor;
        FCdsMov.CAMPO('Hist').VALOR('TROCA DE BEM '+ vPagamentos.HISTORIC).AtribuirValor;
      end;
      // -------------------- credito e estorno DEBITO troca bem
      25, 28: begin
        FCdsMov.CAMPO('Vencto').VALOR(FormatDateTime(MASK_DATA_ANO2, vPagamentos.D_VENCTO)).AtribuirValor;
        FCdsMov.CAMPO('Per').VALOR( vPagamentos.P_NORMAL +
                                    vPagamentos.P_DIFER +
                                    vPagamentos.P_ANTEC).AtribuirValor;
        FCdsMov.CAMPO('Rat').VALOR(vPagamentos.P_RATEIO).AtribuirValor;
        FCdsMov.CAMPO('Hist').VALOR('TROCA DE BEM '+ vPagamentos.HISTORIC).AtribuirValor;
      end;
      else begin
        FCdsMov.CAMPO('Vencto').VALOR(FormatDateTime(MASK_DATA_ANO2, vPagamentos.D_VENCTO)).AtribuirValor;
        FCdsMov.CAMPO('Per').VALOR( vPagamentos.P_NORMAL +
                                    vPagamentos.P_DIFER +
                                    vPagamentos.P_ANTEC).AtribuirValor;
        FCdsMov.CAMPO('Rat').VALOR(vPagamentos.P_RATEIO).AtribuirValor;
        FCdsMov.CAMPO('Hist').VALOR(vPagamentos.HISTORIC).AtribuirValor;
        FCdsMov.CAMPO('VlPag').VALOR(vPagamentos.F_AQUISI).AtribuirValor;
        FCdsMov.CAMPO('MulJu').VALOR(vPagamentos.MUL_JUR).AtribuirValor;
        FCdsMov.CAMPO('VlTot').VALOR( vPagamentos.VALOR +
                                      vPagamentos.MUL_JUR).AtribuirValor;
        FCdsMov.CAMPO('VlReal').VALOR(vPagamentos.VALOR).AtribuirValor;
        FCdsMov.CAMPO('DcBem').VALOR(vPagamentos.DCBEM).AtribuirValor;
        FCdsMov.CAMPO('TxAdm').VALOR(vPagamentos.ADMINIST).AtribuirValor;
        FCdsMov.CAMPO('FdRes').VALOR(vPagamentos.F_RESERV).AtribuirValor;
        FCdsMov.CAMPO('Outros').VALOR(vPagamentos.OUTROS).AtribuirValor;
      end;
    end;
    FCdsMov.GravarRegistro;
    vPagamentos.Proximo;
  end;
  FCdsMov.PrimeiroRegistro;
  Result := FCdsMov.DataSet;
end;

function Tmodelfichapagamentos.Montarpendencias: Tdataset;
var
  vCob,
  vReu: TDataset;
  vReuniao: iControllerReuniao;
  vPreco: iControllerPrecoBem;
  vPend,
  vMul,
  vJur: Double;
begin
  vReuniao := TControllerFactory.New.Reuniao;
  vPreco := TControllerFactory.New.PrecoBem;
  vCob := TControllerFactory.New.Pendencia
               .RetornaPendenciaCota(FGrupo, FSeq, FCota)
               .DataSet;

  CriarDatasetCdsCob;

  vCob.First;

  while not vCob.Eof do begin
    FCdsCob.NovoRegistro;

    vReu := vReuniao
               .RetornaReuniaoPagamento(FGrupo, vCob.FieldByName('D_VENCTO').AsDateTime)
               .Dataset;


    vPend := vCob.FieldByName('VALOR').AsFloat;
    if not vReu.EOF
    then FCdsCob.CAMPO('Reu').VALOR(vReu.FieldByName('NRO_REU').AsString).AtribuirValor
    else FCdsCob.CAMPO('Reu').VALOR('999').AtribuirValor;

    FCdsCob.CAMPO('Aviso').VALOR(vCob.FieldByName('AVISO').AsString).AtribuirValor;
    FCdsCob.CAMPO('Vencto').VALOR(RetornaDataString(vCob.FieldByName('D_VENCTO').AsDateTime, MASK_DATA_ANO2)).AtribuirValor;
    FCdsCob.CAMPO('TpPen').VALOR(vCob.FieldByName('DCTIPOMOV').AsString).AtribuirValor;
    FCdsCob.CAMPO('VlBem').VALOR(vPreco.RetornaPrecoBemData(
                                       vCob.FieldByName('BEM').AsString,
                                       vCob.FieldByName('FIL_COM').AsString,
                                       Date).PRE_REAL).AtribuirValor;      // valor atual do bem
    FCdsCob.CAMPO('PcNormal').VALOR(vCob.FieldByName('PCNOR').AsFloat).AtribuirValor;
    FCdsCob.CAMPO('PcRat').VALOR(vCob.FieldByName('P_RATEIO').AsFloat).AtribuirValor;
    FCdsCob.CAMPO('VPend').VALOR(vPend).AtribuirValor;

    vMul := 0;
    vJur := 0;

    if (vCob.FieldByName('MUL_JUR').AsString <> 'N') then begin
      vMul := CalcularMulta( vCob.FieldByName('D_VENCTO').AsDateTime, vPend, Date);
      vJur := CalcularJuros( vCob.FieldByName('D_VENCTO').AsDateTime, vPend, Date);
    end;

    FCdsCob.CAMPO('VlMul').VALOR(vMul).AtribuirValor;
    FCdsCob.CAMPO('VlJur').VALOR(vJur).AtribuirValor;
    FCdsCob.CAMPO('VlTot').VALOR( vPend + vMul + vJur ).AtribuirValor;
    FCdsCob.CAMPO('VlMulJur').VALOR( vMul + vJur ).AtribuirValor;
    FCdsCob.GravarRegistro;
    vCob.Next;
  end;
  FCdsCob.PrimeiroRegistro;
  Result := FCdsCob.DataSet;
end;

function Tmodelfichapagamentos.Retornartotaiscota: Tdataset;
const
  MOV_ENTREGA_BEM = '41|42|E1|E2';
var
  ttPcNor, ttPcRat, ttPend,
  ttMul, ttJur, ttTot,
  ttPer, ttRat, ttPag,
  ttRes, ttAdm, ttMulpg,
  ttReal, vPend, vMul,
  vJur: Double;
  vPagamentos: iControllerPagamentos;
  vCob: TDataSet;
begin

  vPagamentos := TControllerFactory.New.Pagamentos;
  vPagamentos.RetornaPagamentosCota(FGrupo, FSeq, FCota);

  ttPcNor := 0;
  ttPcRat := 0;
  ttPend := 0;
  ttMul := 0;
  ttJur := 0;
  ttTot := 0;
  ttPer := 0;
  ttRat := 0;
  ttPag := 0;
  ttRes := 0;
  ttAdm := 0;
  ttMulpg := 0;
  ttReal := 0;

  while vPagamentos.TemDados do
  begin
    if Pos(vPagamentos.TIPO_MOV, MOV_ENTREGA_BEM) = 0
    then begin
      ttPer := ttPer + vPagamentos.P_NORMAL +
                       vPagamentos.P_DIFER +
                       vPagamentos.P_ANTEC;
      ttRat := ttRat + vPagamentos.P_RATEIO;
      ttPag := ttPag + vPagamentos.F_AQUISI;
      ttRes := ttRes + vPagamentos.F_RESERV;
      ttAdm := ttAdm + vPagamentos.ADMINIST;
      ttMulpg := ttMulpg + vPagamentos.MUL_JUR;
      ttReal := ttReal + vPagamentos.VALOR;
    end;
    vPagamentos.Proximo;
  end;

  vCob := TControllerFactory.New.Pendencia
               .RetornaPendenciaCota(FGrupo, FSeq, FCota)
               .DataSet;
  vCob.First;

  while not vCob.Eof do begin
    ttPcNor := ttPcNor + vCob.FieldByName('PCNOR').AsFloat;
    ttPcRat := ttPcRat + vCob.FieldByName('P_RATEIO').AsFloat;
    vPend := vCob.FieldByName('VALOR').AsFloat;
    vMul := 0;
    vJur := 0;

    if (vCob.FieldByName('MUL_JUR').AsString <> 'N') then begin
      vMul := CalcularMulta( vCob.FieldByName('D_VENCTO').AsDateTime, vPend, Date);
      vJur := CalcularJuros( vCob.FieldByName('D_VENCTO').AsDateTime, vPend, Date);
    end;
    ttMul := ttMul + vMul;
    ttJur := ttJur + vJur;
    ttPend := ttPend + VPend;
    ttTot := ttTot + (vPend + vMul + vJur);

    vCob.Next;

  end;

  CriarDatasetTtCota;

  FTotCot.NovoRegistro;
  FTotCot.CAMPO('TtPcNor').VALOR(ttPcNor).AtribuirValor;
  FTotCot.CAMPO('TtPcRat').VALOR(ttPcRat).AtribuirValor;
  FTotCot.CAMPO('TtPend').VALOR(ttPend).AtribuirValor;
  FTotCot.CAMPO('TtMul').VALOR(ttMul).AtribuirValor;
  FTotCot.CAMPO('TtJur').VALOR(ttJur).AtribuirValor;
  FTotCot.CAMPO('TtTot').VALOR(ttTot).AtribuirValor;
  FTotCot.CAMPO('TTPer').VALOR(ttPer).AtribuirValor;
  FTotCot.CAMPO('TTRat').VALOR(ttRat).AtribuirValor;
  FTotCot.CAMPO('TtPag').VALOR(ttPag).AtribuirValor;
  FTotCot.CAMPO('TtRes').VALOR(ttRes).AtribuirValor;
  FTotCot.CAMPO('TTAdm').VALOR(ttAdm).AtribuirValor;
  FTotCot.CAMPO('TTMulPG').VALOR(ttMulpg).AtribuirValor;
  FTotCot.CAMPO('TTReal').VALOR(ttReal).AtribuirValor;
  FTotCot.GravarRegistro;
  Result := FTotCot.DataSet;
end;

function Tmodelfichapagamentos.Contacorrentedevolucoes: Tdataset;
var
  vSaldo: Currency;

begin
  CriarDatasetCCDev;
  vSaldo := TControllerFactory.New.TabularEncerrados
                .DATALIMITE(FDataLimite)
                .CalcularSaldoRnpCota(FGrupo, FSeq, FCota, FCCDev);
  FCCDev.PrimeiroRegistro;
  Result := FCCDev.DataSet;
end;

end.



