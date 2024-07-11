unit cobcons.model.demonstrativo;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.interfaces, cobcons.model.sql.interfaces, db;

type

  { TModelDemonstrativo }

  TModelDemonstrativo = class(TInterfacedObject, iModelDemonstrativo)
    private
      FQuery: iQueryRest;
      FSQL: iModelSqlDemonstrativo;

      FGrupo: String;
      FDemonstrativo: String;
      FDataBase: TDateTime;
      FContaCosif: String;
      FSaldoConta: Double;
      FVlrAcumulado: Double;
      FVlrPeriodo: Double;
      function RetornarSQL(pTipo: Integer): string;
      procedure IniciarCosif;
      function CosifExiste: Boolean;
    public
      constructor Create(aQuery: iQueryRest);
      destructor Destroy; override;
      class function New(aQuery: iQueryRest): iModelDemonstrativo;

      function CriarTabela: iModelDemonstrativo;
      function TabelaExiste: Boolean;
      function Novo: iModelDemonstrativo;
      function RetornaDemonstrativo: iModelDemonstrativo;
      function RetornaDemonstrativoDataBase: iModelDemonstrativo;
      function ImportarDemonstrativosSiacon: iModelDemonstrativo;
      function GravarValorConta: iModelDemonstrativo;
      function DataSet: TDataSet;
      function GRUPO(aValue: String): iModelDemonstrativo;
      function DEMONSTRATIVO(aValue: String): iModelDemonstrativo;
      function DATABASE(aValue: TDateTime): iModelDemonstrativo;
      function CONTACOSIF(aValue: String): iModelDemonstrativo;
      function SALDOCONTA(aValue: Double): iModelDemonstrativo;
      function VLRPERIODO(aValue: Double): iModelDemonstrativo;
      function VLRACUMULADO(aValue: Double): iModelDemonstrativo;

  end;
var
  Dem4110: array[0..74] of string = ( '10000007', '11000006', '11100009', '11190002',
               '11200002', '11292003', '12000005', '12900002', '12990005', '12990122',
               '12990256', '12990359', '12990555', '18000009', '18700000', '18780006',
               '18782004', '18788008', '18788101', '18789007', '18793000', '18793055',
               '18793158', '18793206', '18798005', '30000001', '30700002', '30775006',
               '30778003', '30778106', '30782006', '30799006', '39999993', '40000008',
               '49000009', '49800003', '49882007', '49882052', '49882076', '49882100',
               '49886003', '49886106', '49886151', '49886209', '49886223', '49886254',
               '49886302', '49886357', '49886955', '49891005', '49892004', '49894002',
               '49894105', '49894150', '49894208', '49898008', '49898156', '49898163',
               '49898170', '49898187', '49898204', '49898307', '49898352', '49898400',
               '49898455', '49898503', '49898606', '49898905', '90000003', '90700004',
               '90775008', '90778005', '90782008', '90799008', '99999995');

  Dem4350: array[0..30] of string = ( '00600008', '00610005' ,'00620002', '00640006',
               '00650003', '00660000', '00700001', '00710008', '00720005', '00730002',
               '00740009', '00750006', '00760003', '00770000', '00780007', '00790004',
               '00800004', '00810001', '00820008', '00830005', '00840002', '00850009',
               '00860006', '00870003', '00890007', '00900007', '00910004', '00920001',
               '00940005', '00950002', '00960009');

  DadosCosif:  array[0..105] of string = (
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''10000007'', ''1.0.0.00.00-7'', ''ATIVO CIRCULANTE'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''11000006'', ''1.1.0.00.00-6'', ''DISPONIBILIDADES'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''11100009'', ''1.1.1.00.00-9'', ''Caixa'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''11190002'', ''1.1.1.90.00-2'', ''CAIXA'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''11200002'', ''1.1.2.00.00-2'', ''Depósitos Bancários'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''11292003'', ''1.1.2.92.00-3'', ''DEPÓSITOS BANCÁRIOS'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''18793055'', ''1.8.7.93.05-5'', ''Normais'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''12000005'', ''1.2.0.00.00-5'', ''APLICAÇÕES INTERNINANCEIRAS DE LIQUIDEZ'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''12900002'', ''1.2.9.00.00-2'', ''Outras'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''12990005'', ''1.2.9.90.00-5'', ''APLICAÇÕES FINANCEIRAS'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''12990122'', ''1.2.9.90.12-2'', ''Disponibilidades do Grupo'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''12990256'', ''1.2.9.90.25-6'', ''Vinculadas a Contemplações - Selic'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''12990359'', ''1.2.9.90.35-9'', ''Vinculadas a Contemplações - Demais Aplicações'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''12990555'', ''1.2.9.90.55.5'', ''Recursos de Grupos em Formação'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''18000009'', ''1.8.0.00.00-9'', ''OUTROS CRÉDITOS'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''18700000'', ''1.8.7.00.00-0'', ''Valroes Específicos'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''18780006'', ''1.8.7.80.00-6'', ''ADIANTAMENTOS DE RECURSOS A TERCEIROS'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''18782004'', ''1.8.7.82.00-4'', ''VALORES A RECEBER - REAJUSTE DE SALDO DE CAIXA'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''18788008'', ''1.8.7.88.00-8'', ''BENS RETOMADOS OU DEVOLVIDOS'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''18788101'', ''1.8.7.88.10-1'', ''Valor Contábil dos Bens'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''18789007'', ''1.8.7.89.00-7'', ''DIREITOS POR CRÉDITOS EM PROCESSO DE HABILITAÇÃO'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''18793000'', ''1.8.7.93.00-0'', ''DIREITOS JUNTOS A CONSORCIADOS CONTEMPLADOS'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''18793158'', ''1.8.7.93.15-8'', ''Em Atraso'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''18793206'', ''1.8.7.93.20-6'', ''Em Cobrança Judicial - Grupos em Andamento'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''18798005'', ''1.8.7.98.00-5'', ''CHEQUES E OUTROS VALORES A RECEBER'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''30000001'', ''3.0.0.00.00-1'', ''COMPENSAÇÃO'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''30700002'', ''3.0.7.00.00-2'', ''Consórcio'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''30775006'', ''3.0.7.75.00-6'', ''PREVISÃO MENSAL DE RECURSOS A RECEBER DE CONSORCIADOS'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''30778003'', ''3.0.7.78.00-3'', ''CONTRIBUIÇÕES DEVIDAS AO GRUPO'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''30778106'', ''3.0.7.78.10-6'', ''Contribuições Devidas'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''30782006'', ''3.0.7.82.00-6'', ''VALOR DOS BENS OU SERVIÇOS A CONTEMPLAR'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''30799006'', ''3.0.7.99.00-6'', ''DIVERSAS CONTAS DE COMPENSAÇÃO ATIVAS'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''39999993'', ''3.9.9.99.99-3'', ''TOTAL GERAL DO ATIVO'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''40000008'', ''4.0.0.00.00-8'', ''PASSIVO CIRCULANTE'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49000009'', ''4.9.0.00.00-9'', ''OUTRAS OBRIGAÇÕES'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49800003'', ''4.9.8.00.00-3'', ''Obrigações Diversas'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49882007'', ''4.9.8.82.00-7'', ''OBRIGAÇÕES COM CONSORCIADOS'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49882052'', ''4.9.8.82.05-2'', ''Grupos em Formação'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49882076'', ''4.9.8.82.07-6'', ''Recebimentos não Identificados'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49882100'', ''4.9.8.82.10-0'', ''Contribuições de Consorciados não Contemplados'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49886003'', ''4.9.8.86.00-3'', ''VALORES A REPASSAR'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49886106'', ''4.9.8.86.10-6'', ''Taxa de Administração'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49886151'', ''4.9.8.86.15-1'', ''Prêmios de Seguros'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49886209'', ''4.9.8.86.20-9'', ''Multas e Juros Moratórios'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49886223'', ''4.9.8.86.22-3'', ''Multa Rescisória'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49886254'', ''4.9.8.86.25-4'', ''Custas Judiciais'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49886302'', ''4.9.8.86.30-2'', ''Despesas de Registros de Contratos de Garantia'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49886357'', ''4.9.8.86.35-7'', ''Outros Recursos'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49891005'', ''4.9.8.91.00-5'', ''OBRIGAÇÕES POR CONTEMPLAÇÕES A ENTREGAR'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49892004'', ''4.9.8.92.00-4'', ''OBRIGAÇÕES COM A ADMINISTRADORA'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49894002'', ''4.9.8.94.00-2'', ''RECURSOS A DEVOLVER A CONSORCIADOS'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49894105'', ''4.9.8.94.10-5'', ''Ativos - em Andamento'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49894150'', ''4.9.8.94.15-0'', ''Ativos - pelo Rateio'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49894208'', ''4.9.8.94.20-8'', ''Desistentes ou Excluídos'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49898008'', ''4.9.8.98.00-8'', ''RECURSOS DO GRUPO'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49898156'', ''4.9.8.98.15-6'', ''Fundo de Reserva'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49898163'', ''4.9.8.98.16-3'', ''Fundo de Reserva Transformado em Fundo Comum'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49898170'', ''4.9.8.98.17-0'', ''Fundo de Reserva a Receber de Consorciados Contemplados'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49898187'', ''4.9.8.98.18-7'', ''Recursos Utilizados do Fundo de Reserva ( - )'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49898204'', ''4.9.8.98.20-4'', ''Rendimentos de Aplicações Financeiras'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49898307'', ''4.9.8.98.30-7'', ''Multas e Juros Moratórios Retidos'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49898352'', ''4.9.8.98.35-2'', ''Multa Rescisória Retida'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49898400'', ''4.9.8.98.40-0'', ''Recursos em Processo de Habilitação'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49898455'', ''4.9.8.98.45-5'', ''Reajuste de Saldo de Caixa'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49898503'', ''4.9.8.98.50-3'', ''Atualização de Direitos'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49898606'', ''4.9.8.98.60-6'', ''Atualização de Obrigações ( - )'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49898905'', ''4.9.8.98.90-5'', ''Valores Irrecuperáveis ( - )'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''90000003'', ''9.0.0.00.00-3'', ''COMPENSAÇÃO'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''90700004'', ''9.0.7.00.00-4'', ''Consórcio'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''90775008'', ''9.0.7.75.00-8'', ''RECURSOS MENSAIS A RECEBER DE CONSORCIADOS'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''90778005'', ''9.0.7.78.00-5'', ''OBRIGAÇÕES DO GRUPO POR CONTRIBUIÇÕES'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''90782008'', ''9.0.7.82.00-8'', ''BENS OU SERVIÇOS A CONTEMPLAR - VALOR'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''90799008'', ''9.0.7.99.00-8'', ''DIVERSAS CONTAS DE COMPENSAÇÃO PASSIVAS'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''99999995'', ''9.9.9.99.99-5'', ''TOTAL GERAL DO PASSIVO'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00600008'', ''06.0.0.0.0-8'', ''DISPONIBILIDADES EM'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00610005'', ''06.1.0.0.0-5'', ''Caixa'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00620002'', ''06.2.0.0.0-2'', ''Depósitos Bancários'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00640006'', ''06.4.0.0.0-6'', ''Cheques em Cobrança'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00650003'', ''06.5.0.0.0-3'', ''Aplicações Financeiras do Grupo'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00660000'', ''06.6.0.0.0-0'', ''Aplicações Financeiras Vinculadas a Contemplações'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00700001'', ''07.0.0.0.0-1'', ''( + ) RECURSOS COLETADOS'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00710008'', ''07.1.0.0.0-8'', ''Contribuições para Aquisição de Bens'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00720005'', ''07.2.0.0.0-5'', ''Taxa de Administração'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00730002'', ''07.3.0.0.0-2'', ''Contribuições ao Fundo de Reserva'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00740009'', ''07.4.0.0.0-9'', ''Rendimentos de Aplicações Financeiras'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00750006'', ''07.5.0.0.0-6'', ''Multas e Juros Moratórios'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00760003'', ''07.6.0.0.0-3'', ''Prêmios de Seguros'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00770000'', ''07.7.0.0.0-0'', ''Custas Judiciais'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00780007'', ''07.8.0.0.0-7'', ''Reembolso de Despesas de Registro'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00790004'', ''07.9.0.0.0-4'', ''Outros'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00800004'', ''08.0.0.0.0-4'', ''( - ) RECURSOS UTILIZADOS'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00810001'', ''08.1.0.0.0-1'', ''Aquisição de Bens'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00820008'', ''08.2.0.0.0-8'', ''Taxa de Administração'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00830005'', ''08.3.0.0.0-5'', ''Multas e Juros Moratórios'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00840002'', ''08.4.0.0.0-2'', ''Prêmios de Seguros'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00850009'', ''08.5.0.0.0-9'', ''Custas Judiciais'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00860006'', ''08.6.0.0.0-6'', ''Devolução a Consorciados Desligados'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00870003'', ''08.7.0.0.0-3'', ''Despesas de Registro de Contrato'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00900007'', ''09.0.0.0.0-7'', ''DISPONIBILIDADES EM'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00910004'', ''09.1.0.0.0-4'', ''Caixa'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00920001'', ''09.2.0.0.0-1'', ''Depósitos Bancários'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00940005'', ''09.4.0.0.0-5'', ''Cheques em Cobrança'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00950002'', ''09.5.0.0.0-2'', ''Aplicações Financeiras do Grupo'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00960009'', ''09.6.0.0.0-9'', ''Aplicações Vinculadas a Contemplações'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4350'', ''00890007'', ''08.9.0.0.0-7'', ''Outros'')',
'INSERT INTO COSIF (DOC, CODCONTA, CONTAFMT, DESCRICAO) VALUES (''4110'', ''49886955'', ''4.9.8.86.95-5'',	''Valores a Repassar - Encerramento'')');

implementation

uses cobcons.model.sql.factory, cobcons.controller.util;

{ TModelDemonstrativo }

function Tmodeldemonstrativo.Retornarsql(Ptipo: Integer): String;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  case Ptipo of
    1: vSql := Format(FSQL.SqlRetornaDemonstrativo, [ QuotedStr(FGrupo),
                                                      QuotedStr(FDemonstrativo),
                                                      QuotedStr(RetornaDataSql(FDataBase))]);
    2: vSql := Format(FSQL.SqlAlterarValorConta,[ FSaldoConta,
                                                  FVlrPeriodo,
                                                  FVlrAcumulado,
                                                  QuotedStr(FGrupo),
                                                  QuotedStr(FDemonstrativo),
                                                  QuotedStr(RetornaDataSql(FDataBase)),
                                                  QuotedStr(FContaCosif)]);
    3: vSql := Format(FSQL.SqlRetornaDemonstrativoDataBase, [ QuotedStr(RetornaDataSql(FDataBase))]);
    4: vSql := Format(FSQL.SqlImportar4110Siacon, [ QuotedStr(FGrupo),
                                                    QuotedStr(RetornaDataSql(FDataBase))]);
    5: vSql := Format(FSQL.SqlImportar4350Siacon, [ QuotedStr(FGrupo),
                                                    QuotedStr(RetornaDataSql(FDataBase))]);
  end;
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

procedure Tmodeldemonstrativo.Iniciarcosif;
var
  I: Integer;
begin
  FQuery.Executar(FSQL.SqlCriarTabelaCosif);
  for I := 0 to Pred(Length(DadosCosif)) do
      FQuery.Executar(DadosCosif[I]);
end;

function Tmodeldemonstrativo.Cosifexiste: Boolean;
begin
  Result := FQuery.Open(FSQL.SqlTabelaCosifExiste).FieldByName('QTDE').AsInteger > 0;
end;

constructor Tmodeldemonstrativo.Create(Aquery: Iqueryrest);
begin
  FSQL := TModelSQLFactory.New.SqlDemonstrativo;
  FQuery := Aquery;
  FSaldoConta := 0;
  FVlrAcumulado := 0;
  FVlrPeriodo := 0;
end;

destructor Tmodeldemonstrativo.Destroy;
begin
  inherited Destroy;
end;

class function Tmodeldemonstrativo.New(Aquery: Iqueryrest): Imodeldemonstrativo;
begin
  Result := Self.Create(Aquery);
end;

function Tmodeldemonstrativo.Criartabela: Imodeldemonstrativo;
begin
  Result := Self;
  if not CosifExiste
  then IniciarCosif;
  FQuery.Executar(FSQL.SqlCriarTabela);
end;

function Tmodeldemonstrativo.Tabelaexiste: Boolean;
begin
  Result := FQuery.Open(FSQL.SqlTabelaExiste).FieldByName('QTDE').AsInteger > 0;
end;

function Tmodeldemonstrativo.Novo: Imodeldemonstrativo;
var
  vDataBase: String;
  I: Integer;
begin
  Result := Self;
  vDataBase := RetornaDataSql(FDataBase);
  FQuery.Executar(Format(FSQL.SqlNovaDatabase,[QuotedStr(FGrupo), QuotedStr(vDataBase)]));
  //for I := 0 to Pred(Length(Dem4110)) do
  //   FQuery.Executar(Format(FSQL.SqlNovo,[ QuotedStr(FGrupo),
  //                                         QuotedStr('4110'),
  //                                         QuotedStr(vDataBase),
  //                                         QuotedStr(Dem4110[I])]));
  //for I := 0 to Pred(Length(Dem4350)) do
  //   FQuery.Executar(Format(FSQL.SqlNovo,[ QuotedStr(FGrupo),
  //                                         QuotedStr('4350'),
  //                                         QuotedStr(vDataBase),
  //                                         QuotedStr(Dem4350[I])]));
end;

function Tmodeldemonstrativo.Retornademonstrativo: Imodeldemonstrativo;
begin
  Result := Self;
  FQuery.Open(RetornarSQL(1));
end;

function Tmodeldemonstrativo.Retornademonstrativodatabase: Imodeldemonstrativo;
begin
  Result := Self;
  FQuery.Open(RetornarSQL(3));
end;

function Tmodeldemonstrativo.Importardemonstrativossiacon: Imodeldemonstrativo;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(4));
  FQuery.Executar(RetornarSQL(5));
end;

function Tmodeldemonstrativo.Gravarvalorconta: Imodeldemonstrativo;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(2));
end;

function Tmodeldemonstrativo.Dataset: Tdataset;
begin
  Result := FQuery.Dataset;
end;

function Tmodeldemonstrativo.Grupo(Avalue: String): Imodeldemonstrativo;
begin
  Result := Self;
  FGrupo := Avalue;
end;

function Tmodeldemonstrativo.Demonstrativo(Avalue: String): Imodeldemonstrativo;
begin
  Result := Self;
  FDemonstrativo := Avalue;
end;

function Tmodeldemonstrativo.Database(Avalue: Tdatetime): Imodeldemonstrativo;
begin
  Result := Self;
  FDataBase := Avalue;
end;

function Tmodeldemonstrativo.Contacosif(Avalue: String): Imodeldemonstrativo;
begin
  Result := Self;
  FContaCosif := Avalue;
end;

function Tmodeldemonstrativo.Saldoconta(Avalue: Double): Imodeldemonstrativo;
begin
  Result := Self;
  FSaldoConta := Avalue;
end;

function Tmodeldemonstrativo.Vlrperiodo(Avalue: Double): Imodeldemonstrativo;
begin
  Result := Self;
  FVlrPeriodo := Avalue;
end;

function Tmodeldemonstrativo.Vlracumulado(Avalue: Double): Imodeldemonstrativo;
begin
  Result := Self;
  FVlrAcumulado := Avalue;
end;

end.

