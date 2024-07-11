unit cobcons.model.total;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TModelTotal }

   TModelTotal = class (TInterfacedObject, iModelTotal)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlTotal;
       FDtCalc: TDateTime;
       FQtdInaGru: Integer;
       FQtdInaCota: Integer;
       FQtdRnpGru: Integer;
       FQtdRatGru: Integer;
       FQtdRnpCota: Integer;
       FBemApreendido: Double;
       FVlrJuridico: Double;
       FVlrMediacao: Double;
       FVlrRnp: Double;
       FVlrRat: Double;

       function RetornarSQL(pTipo: Integer): string;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelTotal;

       function CriarTabela: iModelTotal;
       function TabelaExiste: Boolean;
       function Novo: iModelTotal;
       function ApagaDados: iModelTotal;
       function RetornaTotal: iModelTotal;
       function AcumularInadimplente: iModelTotal;
       function AcumularRnp: iModelTotal;
       function AcumularRateioFuturo: iModelTotal;
       function Gravar: iModelTotal;
       procedure AtualizarRnp;
       function DataSet: TDataSet;
       function DTCALC(aValue: TDateTime): iModelTotal;
       function QTDINAGRU(aValue: Integer): iModelTotal;
       function QTDINACOTA(aValue: Integer): iModelTotal;
       function QTDRNPGRU(aValue: Integer): iModelTotal;
       function QTDRATGRU(aValue: Integer): iModelTotal;
       function QTDRNPCOTA(aValue: Integer): iModelTotal;
       function BEMAPREENDIDO(aValue: Double): iModelTotal;
       function VLRJURIDICO(aValue: Double): iModelTotal;
       function VLRMEDIACAO(aValue: Double): iModelTotal;
       function VLRRNP(aValue: Double): iModelTotal;
       function VLRRAT(aValue: Double): iModelTotal;
   end;


implementation

uses cobcons.controller.util, cobcons.model.sql.factory;


{ TModelTotal }

function Tmodeltotal.Retornarsql(Ptipo: Integer): String;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  case Ptipo of
    1: vSql := Format(FSQL.SqlAlterar,
          [ QuotedStr(RetornaDataSql(FDtCalc))]);
    2: vSql := Format(FSQL.SqlAcumularInadimplente,
          [ FQtdInaGru,
            FBemApreendido,
            FVlrJuridico,
            FVlrMediacao]);
    3: vSql := Format(FSQL.SqlAcumularRnp,
          [ FQtdRnpGru,
            FVlrRnp]);
    4: vSql := Format(FSQL.SqlAcumularRateioFuturo,
          [ FQtdRatGru,
            FVlrRat]);
  end;
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

constructor Tmodeltotal.Create(Aquery: Iqueryrest);
begin
  FSQL := TModelSQLFactory.New.SqlTotal;
  FQuery := Aquery;
end;

destructor Tmodeltotal.Destroy;
begin
  inherited Destroy;
end;

class function Tmodeltotal.New(Aquery: Iqueryrest): Imodeltotal;
begin
  Result := Self.Create(Aquery);
end;

function Tmodeltotal.Criartabela: Imodeltotal;
begin
  Result := Self;
  FQuery.Executar(FSQL.SqlCriarTabela);
end;

function Tmodeltotal.Tabelaexiste: Boolean;
begin
  Result := FQuery.Open(FSQL.SqlTabelaExiste).FieldByName('QTDE').AsInteger > 0;
end;

function Tmodeltotal.Novo: Imodeltotal;
begin
  Result := Self;
  FQuery.Executar(FSQL.SqlNovo);
end;

function Tmodeltotal.Apagadados: Imodeltotal;
begin
  Result := Self;
  FQuery.Executar(FSQL.SqlApagaDados);
end;

function Tmodeltotal.Retornatotal: Imodeltotal;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaTotal);
end;

function Tmodeltotal.Acumularinadimplente: Imodeltotal;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(2));
end;

function Tmodeltotal.Acumularrnp: Imodeltotal;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(3));
end;

function Tmodeltotal.Acumularrateiofuturo: Imodeltotal;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(4));
end;

function Tmodeltotal.Gravar: Imodeltotal;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(1));
end;

procedure Tmodeltotal.Atualizarrnp;
begin
  FQuery.Executar(FSQL.SqlAtualizarRnp);
end;

function Tmodeltotal.Dataset: Tdataset;
var
  vDataset: TDataSet;
begin
  vDataset :=  FQuery.Dataset;
  FormataCampoData(vDataset.FieldByName('DTCALC'), 'Cálculo', 8, taCenter);
  FormataCampoNumerico(vDataset.FieldByName('VLRINA'),'Inadimp.',6, taRightJustify,',#0.00');
  FormataCampoNumerico(vDataset.FieldByName('VLRRNP'),'Vlr.RNP',6, taRightJustify,',#0.00');
  FormataCampoNumerico(vDataset.FieldByName('VLRRAT'),'Rat.Fut.',6, taRightJustify,',#0.00');
  FormataCampoNumerico(vDataset.FieldByName('BEMAPREENDIDO'),'Bem Apr',6, taRightJustify);
  FormataCampoNumerico(vDataset.FieldByName('VLRJURIDICO'),'Juridico',6, taRightJustify,',#0.00');
  FormataCampoNumerico(vDataset.FieldByName('VLRMEDIACAO'),'Mediação',6, taRightJustify,',#0.00');
  FormataCampoNumerico(vDataset.FieldByName('QTDRNPGRU'),'Grupos',5, taCenter,'0000');
  FormataCampoNumerico(vDataset.FieldByName('QTDINAGRU'),'Grupos',5, taCenter,'0000');
  FormataCampoNumerico(vDataset.FieldByName('QTDRATGRU'),'Grupos',5, taCenter,'0000');
  FormataCampoNumerico(vDataset.FieldByName('QTDINACOTA'),'Cotas',5, taCenter,'0000');
  FormataCampoNumerico(vDataset.FieldByName('QTDRNPCOTA'),'Cotas',5, taCenter,'0000');
  FormataCampoNumerico(vDataset.FieldByName('QTDRATCOTA'),'Cotas',5, taCenter,'0000');
  Result := vDataset;
end;

function Tmodeltotal.Dtcalc(Avalue: Tdatetime): Imodeltotal;
begin
  Result := Self;
  FDtCalc := Avalue;
end;

function Tmodeltotal.Qtdinagru(Avalue: Integer): Imodeltotal;
begin
  Result := Self;
  FQtdInaGru := Avalue;
end;

function Tmodeltotal.Qtdinacota(Avalue: Integer): Imodeltotal;
begin
  Result := Self;
  FQtdInaCota := Avalue;
end;

function Tmodeltotal.Qtdrnpgru(Avalue: Integer): Imodeltotal;
begin
  Result := Self;
  FQtdRnpGru := Avalue;
end;

function Tmodeltotal.Qtdratgru(Avalue: Integer): Imodeltotal;
begin
  Result := Self;
  FQtdRatGru := Avalue;
end;

function Tmodeltotal.Qtdrnpcota(Avalue: Integer): Imodeltotal;
begin
  Result := Self;
  FQtdRnpCota := Avalue;
end;

function Tmodeltotal.Bemapreendido(Avalue: Double): Imodeltotal;
begin
  Result := Self;
  FBemApreendido := Avalue;
end;

function Tmodeltotal.Vlrjuridico(Avalue: Double): Imodeltotal;
begin
  Result := Self;
  FVlrJuridico := Avalue;
end;

function Tmodeltotal.Vlrmediacao(Avalue: Double): Imodeltotal;
begin
  Result := Self;
  FVlrMediacao := Avalue;
end;

function Tmodeltotal.Vlrrnp(Avalue: Double): Imodeltotal;
begin
  Result := Self;
  FVlrRnp := Avalue;
end;

function Tmodeltotal.Vlrrat(Avalue: Double): Imodeltotal;
begin
  Result := Self;
  FVlrRat:= Avalue;
end;

end.



