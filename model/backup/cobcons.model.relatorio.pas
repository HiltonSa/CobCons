unit cobcons.model.relatorio;

{$mode Delphi}

interface

uses
  Classes, Sysutils,  Controls, cobcons.model.interfaces, cobcons.model.sql.interfaces, db;

type

   { TModelRelatorio }

   TModelRelatorio = class (TInterfacedObject, iModelRelatorio)
     private

       FQuery: iQueryRest;
     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelRelatorio;

       function MovimentosNoPeriodo(pInicio, pFim: TDateTime): TDataSet;
       function MovimentosPeriodoDetalhe(pAgente, pDocum: String; pContab: TDateTime): TDataSet;
       function RelatorioComissoes(pPeriodo:Integer; pFil: Integer = 0): TDataset;
       function ProducaoVendas(pInicio, pFim: TDateTime; pAgente, pEquipe, pFilial: Integer): TDataSet;
       function CancelamentosNoPeriodo(pInicio, pFim: TDateTime): TDataSet;
       function VendasAgente(pAgente: Integer): TDataSet;
       function ResumoVendas(pPeriodo: Integer): TDataSet;
       function PagamentosRnpPeriodo(pInicio, pFim: TDateTime): TDataSet;
   end;


implementation

uses cobcons.controller.util, cobcons.model.sql.factory;


{ TModelRelatorio }


constructor TModelRelatorio.Create(aQuery: iQueryRest);
begin
  FQuery := Aquery;
end;

destructor TModelRelatorio.Destroy;
begin
  inherited Destroy;
end;

class function TModelRelatorio.New(aQuery: iQueryRest): iModelRelatorio;
begin
  Result := Self.Create(Aquery);
end;

function TModelRelatorio.MovimentosNoPeriodo(pInicio, pFim: TDateTime
  ): TDataSet;
var
  vSql: String;
  vDataset: TDataSet;
begin
  vSql := TModelSQLFactory.New.SqlPagamentos.SqlRetornaPagamentosPeriodo(pInicio, pFim);
  FQuery.Open(vSql);
  vDataset := FQuery.Dataset;
  FormataCampoTexto(vDataset.FindField('AG_FINAN'), 'Agente', 6, taCenter);
  FormataCampoTexto(vDataset.FindField('NR_DOCUM'), 'Doc.', 6, taCenter);
  FormataCampoTexto(vDataset.FindField('HISTORIC'), 'Historico', 25, taLeftJustify);
  FormataCampoNumerico(vDataset.FindField('F_AQUISI'),'Aquis.',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('ADMINIST'),'Adm.',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('F_RESERV'),'Res.',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('OUTROS'),'Seg/Out',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('VLTOT'),'Total',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('QTDLAN'),'Qtd.',5, taRightJustify,'#0000.');
  FormataCampoData(vDataset.FindField('DT_PAGTO'),'Pagto',8,taCenter);
  FormataCampoData(vDataset.FindField('D_CONTAB'),'Contb',8,taCenter);
  FormataCampoData(vDataset.FindField('D_VENCTO'),'Vencto',8,taCenter);
  Result := vDataset;
end;

function TModelRelatorio.MovimentosPeriodoDetalhe(pAgente, pDocum: String;
  pContab: TDateTime): TDataSet;
var
  vSql: String;
  vDataset: TDataSet;
begin
  vSql := TModelSQLFactory.New.SqlPagamentos.SqlRetornaPagamentosDetalhe(pAgente, pDocum, pContab);
  FQuery.Open(vSql);
  vDataset := FQuery.Dataset;
  FormataCampoTexto(vDataset.FindField('GRUPO'), 'Grupo', 4, taCenter);
  FormataCampoTexto(vDataset.FindField('SEQ'), 'Sq', 2, taCenter);
  FormataCampoTexto(vDataset.FindField('COTA'), 'Cota', 3, taCenter);
  FormataCampoTexto(vDataset.FindField('NOME'), 'Nome', 25, taLeftJustify);
  FormataCampoTexto(vDataset.FindField('AG_FINAN'), 'Agente', 6, taCenter);
  FormataCampoTexto(vDataset.FindField('NR_DOCUM'), 'Doc.', 6, taCenter);
  FormataCampoTexto(vDataset.FindField('DCTIPOMOV'), 'Tp.Mov.', 15, taLeftJustify);
  FormataCampoNumerico(vDataset.FindField('F_AQUISI'),'Aquis.',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('ADMINIST'),'Adm.',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('F_RESERV'),'Res.',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('OUTROS'),'Seg/Out',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('VLTOT'),'Total',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('QTDLAN'),'Qtd.',5, taRightJustify,'#0000.');
  FormataCampoData(vDataset.FindField('DT_PAGTO'),'Pagto',8,taCenter);
  FormataCampoData(vDataset.FindField('D_CONTAB'),'Contb',8,taCenter);
  FormataCampoData(vDataset.FindField('D_VENCTO'),'Vencto',8,taCenter);
  Result := vDataset;
end;

function TModelRelatorio.RelatorioComissoes(pPeriodo: Integer; pFil: Integer
  ): TDataset;
const
  SQL = 'select  * from '+
       '(select X.CODIGO CDPER, X.DESCRICAO DCPER, X.DTINI, X.DTFIM,E.FILIAL, '+
               'E.CODIGO CDEQP, E.DESCRICAO DCEQP, A.CODIGO CDVEN, A.NOME NMVEN,'+
               'A.CDEXTERNO EXVEN, V.CODIGO CDVDA, V.GRUPO, V.COTA, V.NOME NMCLI,'+
               'V.DCBEM, V.DTVENDA, V.VALOR, P.PARCELA, P.PAGAR, V.CONTRATO, '+
               'M.NOMEFANTASIA DCEMP '+
       'from PERIODO X '+
       'inner join PARCELAS P on P.PERIODO=X.CODIGO '+
       'inner join VENDAS V on V.CODIGO=P.VENDA '+
       'inner join EMPRESA M on M.CODIGO=V.EMPRESA '+
       'inner join AGENTES A on A.CODIGO=V.AGENTE '+
       'inner join EQUIPES E on E.CODIGO=A.EQUIPE '+
       'where ((P.RECEBIDO > 0 and P.PAGAR > 0) or P.PARCELA=99) and X.CODIGO=%d '+
       'order by E.FILIAL,E.CODIGO,A.CODIGO, P.PARCELA, V.DTVENDA) ';

var
  vSql: String;
  vDataset: TDataSet;
begin
  vSql := Format(SQL,[ pPeriodo ]);
  if pFil > 0
  then vSql := Format('%s where FILIAL = %d',[ vSql, pFil ]);
  FQuery.Open(vSql);
  vDataset := FQuery.Dataset;
  FormataCampoNumerico(vDataset.FindField('filial'),'Fil',3, taCenter,'00');
  FormataCampoNumerico(vDataset.FindField('parcela'),'Pcl',3, taCenter,'00');
  FormataCampoNumerico(vDataset.FindField('valor'),'Valor',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('pagar'),'Comissao',8, taRightJustify);
  Result := vDataset;
end;

function TModelRelatorio.ProducaoVendas(pInicio, pFim: TDateTime; pAgente,
  pEquipe, pFilial: Integer): TDataSet;
const
  SQL1 =
       'select * from (SELECT F.CODIGO CDEMP, F.DESCRICAO DCFIL, E.CODIGO CDEQP, E.DESCRICAO DCEQP, A.CODIGO CDAGE,'+
                           'A.NOME NMAGE, A.ATIVO STAGE, V.CODIGO CDVEN, V.CONTRATO, M.NOMEFANTASIA NMEMP, V.DTVENDA,'+
                           'V.CDBEM, V.DCBEM, V.VALOR, S.CODIGO CDSIT, S.DESCRICAO DCSIT, V.GRUPO, V.COTA,V.NOME NMCLI, sum(P.RECEBER) VLRCB,'+
                           'sum(P.RECEBIDO) VLREC, sum(P.PAGAR) VLPAG, sum(P.PAGO) VLPGO '+
                    'FROM VENDAS V '+
                    'inner join SITCON S on S.CODIGO=V.SITUACAO '+
                    'inner join EMPRESA M on M.CODIGO=V.EMPRESA '+
                    'inner join AGENTES A on A.CODIGO=V.AGENTE '+
                    'inner join EQUIPES E on E.CODIGO=A.EQUIPE '+
                    'inner join FILIAIS F on F.CODIGO=E.FILIAL '+
                    'left outer join PARCELAS P on P.VENDA=V.CODIGO '+
                    'group by F.CODIGO, F.DESCRICAO, E.CODIGO, E.DESCRICAO, A.CODIGO, A.NOME, A.ATIVO, V.CODIGO, V.CONTRATO, '+
                             'M.NOMEFANTASIA, V.DTVENDA, V.CDBEM, V.DCBEM, V.VALOR, S.CODIGO, S.DESCRICAO, V.GRUPO, V.COTA, V.NOME '+
                    'order by F.CODIGO, E.CODIGO, A.CODIGO, V.DTVENDA ) '+
     'where DTVENDA between TO_DATE(%s, ''DD/MM/YYYY'') and TO_DATE(%s, ''DD/MM/YYYY'')';
  SQL2 = 'select * from VENDAS_COMPLETAS '+
     'where DTVENDA between TO_DATE(%s, ''DD/MM/YYYY'') and TO_DATE(%s, ''DD/MM/YYYY'')';
var
  vSql: String;
  vDataset: TDataSet;
begin
  vSql := Format( SQL2,
                   [ QuotedStr(DateToStr(pInicio)),
                     QuotedStr(DateToStr(pFim))]);
  if pAgente > 0
  then vSql := Format('%s and CDAGE = %d',[ vSql, pAgente ])
  else begin
    if pEquipe > 0
    then vSql := Format('%s and CDEQP = %d',[ vSql, pEquipe ])
    else if pFilial > 0
    then vSql := Format('%s and CDEMP = %d',[ vSql, pFilial ]);
  end;

  FQuery.Open(vSql);

  vDataset := FQuery.Dataset;
  //FormataCampoNumerico(vDataset.FindField('cdemp'),'Fil',3, taCenter,'00');
  //FormataCampoNumerico(vDataset.FindField('cdeqp'),'Eqp',3, taCenter,'00');
  //FormataCampoNumerico(vDataset.FindField('valor'),'Valor',8, taRightJustify);
  //FormataCampoNumerico(vDataset.FindField('vlrcb'),'Receber',8, taRightJustify);
  //FormataCampoNumerico(vDataset.FindField('vlrec'),'Recebido',8, taRightJustify);
  //FormataCampoNumerico(vDataset.FindField('vlpag'),'Pagar',8, taRightJustify);
  //FormataCampoNumerico(vDataset.FindField('vlpgo'),'Pago',8, taRightJustify);
  Result := vDataset;
end;

function TModelRelatorio.CancelamentosNoPeriodo(pInicio, pFim: TDateTime
  ): TDataSet;
var
  vSql: String;
  vDataset: TDataSet;
begin
  vSql := Format( 'select v.*, (p.recebido*-1) estornado, p.dtrec dtcan, p.periodo,'+
                  '      (v.vlrcb + (p.recebido*-1)) ttrcb '+
                  'from vendas_completas v '+
                  'inner join parcelas p on p.venda=cdven and p.parcela = 99 '+
                  'where p.dtrec between %s and %s '+
                  'order by v.cdemp, v.cdeqp, v.cdage, p.dtrec',
                   [ QuotedStr(RetornaDataSql(pInicio)),
                     QuotedStr(RetornaDataSql(pFim))]);

  FQuery.Open(vSql);

  vDataset := FQuery.Dataset;
  FormataCampoNumerico(vDataset.FindField('cdemp'),'Fil',3, taCenter,'00');
  FormataCampoNumerico(vDataset.FindField('cdeqp'),'Eqp',3, taCenter,'00');
  FormataCampoNumerico(vDataset.FindField('valor'),'Valor',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('vlrcb'),'Receber',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('vlrec'),'Recebido',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('vlpag'),'Pagar',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('vlpgo'),'Pago',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('vlpgo'),'Pago',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('estornado'),'Estorno',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('ttrcb'),'Recebido',8, taRightJustify);
  Result := vDataset;
end;

function TModelRelatorio.VendasAgente(pAgente: Integer): TDataSet;
var
  vSql: String;
  vDataset: TDataSet;
begin
  vSql := Format( 'select V.*, P.CODIGO CDPER, P.DESCRICAO DCPER, P.DTINI, P.DTFIM from vendas_completas v '+
                  'inner join PERIODO P on V.DTVENDA >= P.DTINI and V.DTVENDA <= P.DTFIM '+
                  'where v.cdage = %d order by p.codigo', [ pAgente ]);

  FQuery.Open(vSql);

  vDataset := FQuery.Dataset;
  FormataCampoNumerico(vDataset.FindField('cdemp'),'Fil',3, taCenter,'00');
  FormataCampoNumerico(vDataset.FindField('cdeqp'),'Eqp',3, taCenter,'00');
  FormataCampoNumerico(vDataset.FindField('valor'),'Valor',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('vlrcb'),'Receber',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('vlrec'),'Recebido',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('vlpag'),'Pagar',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('vlpgo'),'Pago',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('vlpgo'),'Pago',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('estornado'),'Estorno',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('ttrcb'),'Recebido',8, taRightJustify);
  Result := vDataset;
end;

function TModelRelatorio.ResumoVendas(pPeriodo: Integer): TDataSet;
var
  vSql: String;
  vDataset: TDataSet;
begin
  vSql := Format( 'select * from RESUMO_VENDAS where CDPER = %d', [ pPeriodo ]);

  FQuery.Open(vSql);

  vDataset := FQuery.Dataset;
  FormataCampoNumerico(vDataset.FindField('cdfil'),'Fil',3, taCenter,'00');
  FormataCampoNumerico(vDataset.FindField('cdPer'),'Per',3, taCenter,'000');
  FormataCampoNumerico(vDataset.FindField('cdeqp'),'Eqp',3, taCenter,'00');
  FormataCampoNumerico(vDataset.FindField('cdage'),'Age',8, taCenter,'000000');
  FormataCampoNumerico(vDataset.FindField('qtven'),'Ven',4, taCenter,'0000');
  FormataCampoNumerico(vDataset.FindField('qtcan'),'Can',4, taCenter,'0000');
  FormataCampoNumerico(vDataset.FindField('ttven'),'Tt.Ven',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('ttrcb'),'Receber',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('ttcan'),'Cancel.',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('ttpag'),'Pagar',8, taRightJustify);
  Result := vDataset;
end;

function TModelRelatorio.PagamentosRnpPeriodo(pInicio, pFim: TDateTime
  ): TDataSet;
var
  vSql: String;
  vDataset: TDataSet;
begin
  vSql := TModelSQLFactory.New.SqlPagamentos.SqlRetornaPagamentosRnpPeriodo(pInicio, pFim);
  FQuery.Open(vSql);
  vDataset := FQuery.Dataset;
  FormataCampoTexto(vDataset.FindField('AG_FINAN'), 'Agente', 6, taCenter);
  FormataCampoTexto(vDataset.FindField('NR_DOCUM'), 'Doc.', 6, taCenter);
  FormataCampoTexto(vDataset.FindField('AVISO'), 'Aviso', 6, taCenter);
  FormataCampoTexto(vDataset.FindField('GRUPO'), 'Grupo', 4, taCenter);
  FormataCampoTexto(vDataset.FindField('SEQ'), 'Sq.', 2, taCenter);
  FormataCampoTexto(vDataset.FindField('COTA'), 'Cota', 4, taCenter);
  FormataCampoTexto(vDataset.FindField('NOME'), 'Nome', 25, taLeftJustify);
  FormataCampoTexto(vDataset.FindField('DCTIPOMOV'), 'Tipo', 10, taLeftJustify);
  FormataCampoNumerico(vDataset.FindField('PGRNP'),'Valor',8, taRightJustify);
  FormataCampoData(vDataset.FindField('DT_PAGTO'),'Pagto',8,taCenter);
  FormataCampoData(vDataset.FindField('D_CONTAB'),'Contb',8,taCenter);
  FormataCampoData(vDataset.FindField('D_VENCTO'),'Vencto',8,taCenter);
  Result := vDataset;
end;

end.



