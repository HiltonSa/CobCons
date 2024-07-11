unit cobcons.model.inadimplentes;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TModelInadimplentes }

   TModelInadimplentes = class (TInterfacedObject, iModelInadimplente)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlInadimplentes;

       FGrupo: string;
       FSeq: string;
       FCota: string;
       FDtAjuiz: TDateTime;
       FPercAmort: Double;
       FVlrBem: Double;
       FVlrReceber: Double;
       FBemApreendido: Double;

       function RetornarSQL(pTipo: Integer): string;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelInadimplente;

       function CriarTabela: iModelInadimplente;
       function TabelaExiste: Boolean;
       function Novo: iModelInadimplente;
       function ApagarDados: iModelInadimplente;
       function RetornaInadimplentes: iModelInadimplente;
       function RetornaInadimplentesGrupo(pGrupo: String): iModelInadimplente;
       function Gravar: iModelInadimplente;
       function InadimplentesSag: TDataSet;
       function DataSet: TDataSet;
       function GRUPO(aValue: String): iModelInadimplente;
       function SEQ(aValue: String): iModelInadimplente;
       function COTA(aValue: String): iModelInadimplente;
       function DTAJUIZ(aValue: TDateTime): iModelInadimplente;
       function PERCAMORT(aValue: Double): iModelInadimplente;
       function VLRRECEBER(aValue: Double): iModelInadimplente;
       function VLRBEM(aValue: Double): iModelInadimplente;
       function BEMAPREENDIDO(aValue: Double): iModelInadimplente;
   end;


implementation

uses cobcons.controller.util, cobcons.model.sql.factory;


{ TModelInadimplentes }

function Tmodelinadimplentes.Retornarsql(Ptipo: Integer): String;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  case Ptipo of
    0: vSql := Format(FSQL.SqlNovo,
          [ QuotedStr(FGrupo),
            QuotedStr(FSeq),
            QuotedStr(FCota),
            QuotedStr(RetornaDataSql(FDtAjuiz)),
            FPercAmort,
            FVlrReceber,
            FVlrBem,
            FBemApreendido]);

    1: vSql := Format(FSQL.SqlAlterar,
          [ QuotedStr(RetornaDataSql(FDtAjuiz)),
            FPercAmort,
            FVlrReceber,
            FVlrBem,
            FBemApreendido,
            QuotedStr(FGrupo),
            QuotedStr(FSeq),
            QuotedStr(FCota)]);
  end;
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

constructor Tmodelinadimplentes.Create(Aquery: Iqueryrest);
begin
  FSQL := TModelSQLFactory.New.SqlInadimplentes;
  FQuery := Aquery;
end;

destructor Tmodelinadimplentes.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelinadimplentes.New(Aquery: Iqueryrest): Imodelinadimplente;
begin
  Result := Self.Create(Aquery);
end;

function Tmodelinadimplentes.Criartabela: Imodelinadimplente;
begin
  Result := Self;
  FQuery.Executar(FSQL.SqlCriarTabela);
end;

function Tmodelinadimplentes.Tabelaexiste: Boolean;
begin
  Result := FQuery.Open(FSQL.SqlTabelaExiste).FieldByName('QTDE').AsInteger > 0;
end;

function Tmodelinadimplentes.Novo: Imodelinadimplente;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(0));
end;

function Tmodelinadimplentes.Apagardados: Imodelinadimplente;
begin
  Result := Self;
  FQuery.Executar(FSQL.SqlApagarDados);
end;

function Tmodelinadimplentes.Retornainadimplentes: Imodelinadimplente;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaInadimplentes);
end;

function Tmodelinadimplentes.Retornainadimplentesgrupo(Pgrupo: String): Imodelinadimplente;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaInadimplentesGrupo(Pgrupo));
end;

function Tmodelinadimplentes.Gravar: Imodelinadimplente;
begin
  Result := Self;
  FQuery.Executar(RetornarSQL(1));
end;

function Tmodelinadimplentes.Inadimplentessag: Tdataset;
var
  vDataset: TDataSet;
begin
  vDataset := FQuery.Open(FSQL.SqlInadimplentesSag).Dataset;
  FormataCampoData(vDataset.FieldByName('DTAJUIZ'), 'Ajuiz.', 8, taCenter, 'dd/mm/yy');
  Result := vDataset;
end;

function Tmodelinadimplentes.Dataset: Tdataset;
var
  vDataset: TDataSet;
begin
  vDataset :=  FQuery.Dataset;
  FormataCampoData(vDataset.FieldByName('DTAJUIZ'), 'Ajuiz.', 8, taCenter, 'dd/mm/yy');
  FormataCampoTexto(vDataset.FieldByName('GRUPO'), 'Grupo', 4, taCenter);
  FormataCampoTexto(vDataset.FieldByName('SEQ'), 'Seq', 2, taCenter);
  FormataCampoTexto(vDataset.FieldByName('COTA'), 'Cota', 3, taCenter);
  FormataCampoTexto(vDataset.FieldByName('NOME'), 'Nome', 30, taLeftJustify);
  FormataCampoTexto(vDataset.FieldByName('SIT_COBR'), 'Sit', 2, taCenter);
  FormataCampoNumerico(vDataset.FieldByName('VLRRECEBER'),'Vlr.Rec.',6, taRightJustify,',#0.00');
  FormataCampoNumerico(vDataset.FieldByName('PERCAMORT'),'% Pago',6, taCenter,',#0.0000');
  FormataCampoNumerico(vDataset.FieldByName('BEMAPREENDIDO'),'Bem Apr',8, taRightJustify);
  FormataCampoNumerico(vDataset.FieldByName('VLRBEM'),'Vlr Bem',8, taRightJustify);
  Result := vDataset;
end;

function Tmodelinadimplentes.Grupo(Avalue: String): Imodelinadimplente;
begin
  Result := Self;
  FGrupo := Avalue;
end;

function Tmodelinadimplentes.Seq(Avalue: String): Imodelinadimplente;
begin
  Result := Self;
  FSeq := Avalue;
end;

function Tmodelinadimplentes.Cota(Avalue: String): Imodelinadimplente;
begin
  Result := Self;
  FCota := Avalue;
end;

function Tmodelinadimplentes.Dtajuiz(Avalue: Tdatetime): Imodelinadimplente;
begin
  Result := Self;
  FDtAjuiz := Avalue;
end;

function Tmodelinadimplentes.Percamort(Avalue: Double): Imodelinadimplente;
begin
  Result := Self;
  FPercAmort := Avalue;
end;

function Tmodelinadimplentes.Vlrreceber(Avalue: Double): Imodelinadimplente;
begin
  Result := Self;
  FVlrReceber := Avalue;
end;

function Tmodelinadimplentes.Vlrbem(Avalue: Double): Imodelinadimplente;
begin
  Result := Self;
  FVlrBem := Avalue;
end;

function Tmodelinadimplentes.Bemapreendido(Avalue: Double): Imodelinadimplente;
begin
  Result := Self;
  FBemApreendido := Avalue;
end;

end.



