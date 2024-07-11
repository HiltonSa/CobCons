unit cobcons.model.totalgrupo;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TModelTotalGrupo }

   TModelTotalGrupo = class (TInterfacedObject, iModelTotalGrupo)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlTotalGrupos;
       FGrupo: string;
       FRegAplic: string;
       FDtCalc: TDateTime;
       FDtUltAss: TDateTime;
       FDtEncCt: TDateTime;
       FDtCmPer: TDateTime;
       FTxPer: Double;
       FMulResGru: Double;
       FMulResAdm: Double;
       FQtdIna: Integer;
       FQtdRnp: Integer;
       FBemApreendido: Double;
       FVlrJuridico: Double;
       FVlrMediacao: Double;
       FVlrRnp: Double;
       FVlrRf: Double;
       FTotalFator: Double;

       function RetornarSQL(pTipo: Integer): string;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelTotalGrupo;

       function CriarTabela: iModelTotalGrupo;
       function TabelaExiste: Boolean;
       function Novo: iModelTotalGrupo;
       function ApagarDados: iModelTotalGrupo;
       function ListaTodos: iModelTotalGrupo;
       function RetornaGrupo(pGrupo: String): iModelTotalGrupo;
       function Gravar: iModelTotalGrupo;
       function AcumularInadimplentes: iModelTotalGrupo;
       function AcumularRnp: iModelTotalGrupo;
       function AcumularTotalFator: iModelTotalGrupo;
       function AcumularRateioFuturo: iModelTotalGrupo;
       procedure AtualizarRnp;
       function TemDados: Boolean;
       function Proximo: Boolean;
       function DataSet: TDataSet;
       function GRUPO(aValue: string): iModelTotalGrupo; overload;
       function REGAPLIC(aValue: string): iModelTotalGrupo; overload;
       function DTCALC(aValue: TDateTime): iModelTotalGrupo;
       function DTULTASS(aValue: TDateTime): iModelTotalGrupo; overload;
       function DTENCCT(aValue: TDateTime): iModelTotalGrupo; overload;
       function DTCMPER(aValue: TDateTime): iModelTotalGrupo; overload;
       function TXPER(aValue: Double): iModelTotalGrupo; overload;
       function REGAPLIC: String; overload;
       function DTULTASS: TDateTime; overload;
       function DTENCCT: TDateTime; overload;
       function DTCMPER: TDateTime; overload;
       function TXPER: Double; overload;
       function MULRESGRU(aValue: Double): iModelTotalGrupo;
       function MULRESADM(aValue: Double): iModelTotalGrupo;
       function QTDINA(aValue: Integer): iModelTotalGrupo;
       function QTDRNP(aValue: Integer): iModelTotalGrupo;
       function BEMAPREENDIDO(aValue: Double): iModelTotalGrupo;
       function VLRJURIDICO(aValue: Double): iModelTotalGrupo;
       function VLRMEDIACAO(aValue: Double): iModelTotalGrupo;
       function VLRRNP(aValue: Double): iModelTotalGrupo;
       function TOTALFATOR(aValue: Double): iModelTotalGrupo; overload;
       function VLRRF(aValue: Double): iModelTotalGrupo;
       function GRUPO: String; overload;
       function VLINA: double;
       function TOTALFATOR: double; overload;
   end;


implementation

uses cobcons.controller.util, cobcons.model.sql.factory;


{ TModelTotalGrupo }

function Tmodeltotalgrupo.Retornarsql(Ptipo: Integer): String;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  case Ptipo of
    0: vSql := Format(FSQL.SqlNovo,
                      [ QuotedStr(FGrupo),
                        QuotedStr(FRegAplic),
                        QuotedStr(RetornaDataSql(FDtCalc)),
                        QuotedStr(RetornaDataSql(FDtUltAss)),
                        QuotedStr(RetornaDataSql(FDtEncCt)),
                        FTxPer,
                        QuotedStr(RetornaDataSql(FDtCmPer)),
                        FMulResGru,
                        FMulResAdm ]);
    1: vSql := Format(FSQL.SqlAlterar,
                    [ QuotedStr(FRegAplic),
                      QuotedStr(RetornaDataSql(FDtCalc)),
                      QuotedStr(RetornaDataSql(FDtUltAss)),
                      QuotedStr(RetornaDataSql(FDtEncCt)),
                      FTxPer,
                      FMulResGru,
                      FMulResAdm,
                      QuotedStr(RetornaDataSql(FDtCmPer)),
                      QuotedStr(FGrupo)]);
    2: vSql := Format(FSQL.SqlAcumularInadimplentes,
                     [ FBemApreendido,
                       FVlrJuridico,
                       FVlrMediacao,
                       FTotalFator,
                       QuotedStr(FGrupo)]);
    3: vSql := Format(FSQL.SqlAcumularRnp,
                     [ FVlrRnp,
                       QuotedStr(FGrupo)]);
    4: vSql := Format(FSQL.SqlAcumularTotalFator,
                     [ FTotalFator,
                       QuotedStr(FGrupo)]);
    5: vSql := Format(FSQL.SqlAcumularRateioFuturo,
                     [ FVlrRf,
                       QuotedStr(FGrupo)]);
  end;
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

constructor Tmodeltotalgrupo.Create(Aquery: Iqueryrest);
begin
  FSQL := TModelSQLFactory.New.SqlTotalGrupo;
  FQuery := Aquery;
end;

destructor Tmodeltotalgrupo.Destroy;
begin
  inherited Destroy;
end;

class function Tmodeltotalgrupo.New(Aquery: Iqueryrest): Imodeltotalgrupo;
begin
  Result := Self.Create(Aquery);
end;

function Tmodeltotalgrupo.Criartabela: Imodeltotalgrupo;
begin
  Result := Self;
  FQuery.Executar(FSQL.SqlCriarTabela);
end;

function Tmodeltotalgrupo.Tabelaexiste: Boolean;
begin
  Result := FQuery.Open(FSQL.SqlTabelaExiste).FieldByName('QTDE').AsInteger > 0;
end;

function Tmodeltotalgrupo.Novo: Imodeltotalgrupo;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(0));
end;

function Tmodeltotalgrupo.Apagardados: Imodeltotalgrupo;
begin
  Result := Self;
  FQuery.Executar(FSQL.SqlApagarDados);
end;

function Tmodeltotalgrupo.Listatodos: Imodeltotalgrupo;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRecuperaTodos);
end;

function Tmodeltotalgrupo.Retornagrupo(Pgrupo: String): Imodeltotalgrupo;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRecuperaGrupo(Pgrupo));
end;

function Tmodeltotalgrupo.Gravar: Imodeltotalgrupo;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(1));
end;

function Tmodeltotalgrupo.Acumularinadimplentes: Imodeltotalgrupo;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(2));
end;

function Tmodeltotalgrupo.Acumularrnp: Imodeltotalgrupo;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(3));
end;

function Tmodeltotalgrupo.Acumulartotalfator: Imodeltotalgrupo;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(4));
end;

function Tmodeltotalgrupo.Acumularrateiofuturo: Imodeltotalgrupo;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(5));
end;

procedure Tmodeltotalgrupo.Atualizarrnp;
begin
  FQuery.Executar(FSQL.SqlAtualizarRnp);
end;

function Tmodeltotalgrupo.Temdados: Boolean;
begin
  Result := not FQuery.Dataset.EOF;
end;

function Tmodeltotalgrupo.Proximo: Boolean;
begin
  FQuery.Dataset.Next;
  Result := Self.TemDados;
end;

function Tmodeltotalgrupo.Dataset: Tdataset;
var
  vDataset: TDataSet;
begin
  vDataset :=  FQuery.Dataset;
  FormataCampoTexto(vDataset.FieldByName('GRUPO'), 'Grupo', 4, taCenter);
  FormataCampoTexto(vDataset.FieldByName('REGAPLIC'), 'Reg.', 4, taCenter);
  FormataCampoData(vDataset.FieldByName('DTCALC'), 'Cálculo', 8, taCenter);
  FormataCampoData(vDataset.FieldByName('DTULTASS'), 'Últ.Ass.', 8, taCenter);
  FormataCampoData(vDataset.FieldByName('DTENCCT'), 'Enc.Ctb.', 8, taCenter);
  FormataCampoData(vDataset.FieldByName('DTCMPER'), 'In.Cob.', 8, taCenter);
  FormataCampoNumerico(vDataset.FieldByName('TXPER'),'Tx.Perm.',6, taCenter,',#0.0000');
  FormataCampoNumerico(vDataset.FieldByName('MULRESGRU'),'Mul.Grupo',6, taCenter,',#0.0000');
  FormataCampoNumerico(vDataset.FieldByName('MULRESADM'),'Mul.Adm.',6, taCenter,',#0.0000');
  FormataCampoNumerico(vDataset.FieldByName('VLRINA'),'Inadimp.',6, taRightJustify,',#0.00');
  FormataCampoNumerico(vDataset.FieldByName('VLRRNP'),'Vlr.RNP',6, taRightJustify,',#0.00');
  FormataCampoNumerico(vDataset.FieldByName('BEMAPREENDIDO'),'Bem Apr',6, taRightJustify);
  FormataCampoNumerico(vDataset.FieldByName('VLRJURIDICO'),'Juridico',6, taRightJustify,',#0.00');
  FormataCampoNumerico(vDataset.FieldByName('VLRMEDIACAO'),'Mediação',6, taRightJustify,',#0.00');
  FormataCampoNumerico(vDataset.FieldByName('VLRRF'),'Rat.Fut.',6, taRightJustify,',#0.00');
  FormataCampoNumerico(vDataset.FieldByName('TOTALFATOR'),'Fator',8, taRightJustify);
  FormataCampoNumerico(vDataset.FieldByName('QTDRNP'),'Qt.Rnp',5, taCenter,'0000');
  FormataCampoNumerico(vDataset.FieldByName('QTDINA'),'Qt.Ina',5, taCenter,'0000');
  FormataCampoNumerico(vDataset.FieldByName('QTDRF'),'Qt.R.F.',5, taCenter,'0000');
  Result := vDataset;
end;

function Tmodeltotalgrupo.Grupo(Avalue: String): Imodeltotalgrupo;
begin
  Result := Self;
  FGrupo := Avalue;
end;

function Tmodeltotalgrupo.Regaplic(Avalue: String): Imodeltotalgrupo;
begin
  Result := Self;
  FRegAplic := Avalue;
end;

function Tmodeltotalgrupo.Dtcalc(Avalue: Tdatetime): Imodeltotalgrupo;
begin
  Result := Self;
  FDtCalc := Avalue;
end;

function Tmodeltotalgrupo.Dtultass(Avalue: Tdatetime): Imodeltotalgrupo;
begin
  Result := Self;
  FDtUltAss := Avalue;
end;

function Tmodeltotalgrupo.Dtencct(Avalue: Tdatetime): Imodeltotalgrupo;
begin
  Result := Self;
  FDtEncCt := Avalue;
end;

function Tmodeltotalgrupo.Dtcmper(Avalue: Tdatetime): Imodeltotalgrupo;
begin
  Result := Self;
  FDtCmPer := Avalue;
end;

function Tmodeltotalgrupo.Txper(Avalue: Double): Imodeltotalgrupo;
begin
  Result := Self;
  FTxPer := Avalue;
end;

function Tmodeltotalgrupo.Regaplic: String;
begin
  Result := FQuery.FieldByName('REGAPLIC').AsString;
end;

function Tmodeltotalgrupo.Dtultass: Tdatetime;
begin
  Result := FQuery.FieldByName('DTULTASS').AsDateTime;
end;

function Tmodeltotalgrupo.Dtencct: Tdatetime;
begin
  Result := FQuery.FieldByName('DTENCCT').AsDateTime;
end;

function Tmodeltotalgrupo.Dtcmper: Tdatetime;
begin
  Result := FQuery.FieldByName('DTCMPER').AsDateTime;
end;

function Tmodeltotalgrupo.Txper: Double;
begin
  Result := FQuery.FieldByName('TXPER').AsFloat;
end;

function Tmodeltotalgrupo.Mulresgru(Avalue: Double): Imodeltotalgrupo;
begin
  Result := Self;
  FMulResGru := Avalue;
end;

function Tmodeltotalgrupo.Mulresadm(Avalue: Double): Imodeltotalgrupo;
begin
  Result := Self;
  FMulResAdm := Avalue;
end;

function Tmodeltotalgrupo.Qtdina(Avalue: Integer): Imodeltotalgrupo;
begin
  Result := Self;
  FQtdIna := Avalue;
end;

function Tmodeltotalgrupo.Qtdrnp(Avalue: Integer): Imodeltotalgrupo;
begin
  Result := Self;
  FQtdRnp := Avalue;
end;

function Tmodeltotalgrupo.Bemapreendido(Avalue: Double): Imodeltotalgrupo;
begin
  Result := Self;
  FBemApreendido := Avalue;
end;

function Tmodeltotalgrupo.Vlrjuridico(Avalue: Double): Imodeltotalgrupo;
begin
  Result := Self;
  FVlrJuridico := Avalue;
end;

function Tmodeltotalgrupo.Vlrmediacao(Avalue: Double): Imodeltotalgrupo;
begin
  Result := Self;
  FVlrMediacao := Avalue;
end;

function Tmodeltotalgrupo.Vlrrnp(Avalue: Double): Imodeltotalgrupo;
begin
  Result := Self;
  FVlrRnp := Avalue;
end;

function Tmodeltotalgrupo.Totalfator(Avalue: Double): Imodeltotalgrupo;
begin
  Result := Self;
  FTotalFator := Avalue;
end;

function Tmodeltotalgrupo.Vlrrf(Avalue: Double): Imodeltotalgrupo;
begin
  Result := Self;
  FVlrRf := Avalue;
end;

function Tmodeltotalgrupo.Grupo: String;
begin
  Result := FQuery.FieldByName('GRUPO').AsString;
end;

function Tmodeltotalgrupo.Vlina: Double;
begin
  Result := FQuery.FieldByName('VLRINA').AsFloat;
end;

function Tmodeltotalgrupo.Totalfator: Double;
begin
  Result := FQuery.FieldByName('TOTALFATOR').AsFloat;
end;

end.



