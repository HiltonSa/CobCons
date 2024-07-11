unit cobcons.model.itemcomissaopermanencia;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, ComCtrls, ExtCtrls, Forms,
  cobcons.controller.interfaces, db;

type

   { TModelItemComissaoPermanencia }

   TModelItemComissaoPermanencia = class (TInterfacedObject, iModelItemComissaoPermanencia)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlItemComissaoPermanencia;

       FCodigo: Integer;
       FCmPer: Integer;
       FGrupo: String;
       FSeq: String;
       FCota: String;
       FSaldoInicial: Double;
       FComissao: Double;
       FSaldoFinal: Double;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelItemComissaoPermanencia;

       function CriarTabela: iModelItemComissaoPermanencia;
       function TabelaExiste: Boolean;
       procedure NovoItem;
       function ListarItensComissao(pCmPer: Integer): iModelItemComissaoPermanencia;
       function ListarItensComissaoGrupo(pCmPer: Integer; pGrupo: String): iModelItemComissaoPermanencia;
       function ListarItensComissaoSinteticoGrupo(pCmPer: Integer): iModelItemComissaoPermanencia;
       function ExisteCalculoCota(pGrupo, pSeq, pCota: String): iModelItemComissaoPermanencia;
       function DataSet: TDataSet;
       function TemDados: Boolean;
       function Proximo: Boolean;
       function NovoCodigo: Integer;
       procedure AlteraCmPer(pCmPer: Integer);
       procedure ApagaCalculo;
       procedure ApagaItens(pCalculo: Integer);
       function CODIGO(aValue: Integer): iModelItemComissaoPermanencia;
       function CMPER(aValue: Integer): iModelItemComissaoPermanencia;
       function GRUPO(aValue: String): iModelItemComissaoPermanencia; overload;
       function SEQ(aValue: String): iModelItemComissaoPermanencia; overload;
       function COTA(aValue: String): iModelItemComissaoPermanencia; overload;
       function SDINICIAL(aValue: Double): iModelItemComissaoPermanencia; overload;
       function COMISSAO(aValue: Double): iModelItemComissaoPermanencia; overload;
       function SDFINAL(aValue: Double): iModelItemComissaoPermanencia; overload;
       function SDFINAL: Double; overload;
       function SDINICIAL: Double; overload;
       function GRUPO: String; overload;
       function SEQ: String; overload;
       function COTA: String; overload;
       function COMISSAO: Double; overload;
   end;


implementation

uses cobcons.controller.util, cobcons.controller.factory, cobcons.model.dm,
  cobcons.model.sql.factory;


{ TModelItemComissaoPermanencia }

constructor TModelItemComissaoPermanencia.Create(aQuery: iQueryRest);
begin
  FQuery := Aquery;
  FSQL := TModelSQLFactory.New.SqlItemComissaoPermanencia;
end;

destructor TModelItemComissaoPermanencia.Destroy;
begin
  inherited Destroy;
end;

class function TModelItemComissaoPermanencia.New(aQuery: iQueryRest
  ): iModelItemComissaoPermanencia;
begin
  Result := Self.Create(Aquery);
end;

function TModelItemComissaoPermanencia.CriarTabela: iModelItemComissaoPermanencia;
begin
  Result := Self;
  FQuery.Executar(FSQL.SqlCriarTabela);
end;

function TModelItemComissaoPermanencia.TabelaExiste: Boolean;
begin
  Result := FQuery.Open(FSQL.SqlTabelaExiste).FieldByName('QTDE').AsInteger > 0;
end;

procedure TModelItemComissaoPermanencia.NovoItem;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  vSql := Format(FSQL.SqlNovo,
          [ FCodigo,
            FCmPer,
            QuotedStr( FGrupo ),
            QuotedStr( FSeq ),
            QuotedStr( FCota ),
            FSaldoInicial,
            FComissao,
            FSaldoFinal]);
  FormatSettings.DecimalSeparator := ',';
  FQuery.Executar(vSql);
end;

function TModelItemComissaoPermanencia.ListarItensComissao(pCmPer: Integer
  ): iModelItemComissaoPermanencia;
begin
  FQuery.Open(Format(FSQL.SqlListarItensComissao, [ pCmPer ]));
  Result := Self;
end;

function TModelItemComissaoPermanencia.ListarItensComissaoGrupo(
  pCmPer: Integer; pGrupo: String): iModelItemComissaoPermanencia;
begin
  FQuery.Open(Format(FSQL.SqlListarItensComissaoGrupo, [ pCmPer, QuotedStr(Pgrupo) ]));
  Result := Self;
end;

function TModelItemComissaoPermanencia.ListarItensComissaoSinteticoGrupo(
  pCmPer: Integer): iModelItemComissaoPermanencia;
begin
  FQuery.Open(Format(FSQL.SqlSinteticoGrupo, [ pCmPer ]));
  Result := Self;
end;

function TModelItemComissaoPermanencia.ExisteCalculoCota(pGrupo, pSeq,
  pCota: String): iModelItemComissaoPermanencia;
begin
  FQuery.Open(Format(FSQL.SqlExisteCalculo, [ QuotedStr(pGrupo), QuotedStr(pSeq), QuotedStr(pCota) ]));
  Result := Self;
end;

function TModelItemComissaoPermanencia.DataSet: TDataSet;
var
  vDataset: TDataSet;
begin
  vDataset :=  FQuery.Dataset;
  FormataCampoNumerico(vDataset.FindField('CODIGO'),'Cod',5, taCenter,'000');
  FormataCampoTexto(vDataset.FindField('GRUPO'), 'Grupo', 4, taCenter);
  FormataCampoTexto(vDataset.FindField('SEQ'), 'Seq', 2, taCenter);
  FormataCampoTexto(vDataset.FindField('COTA'), 'Data', 3, taCenter);
  FormataCampoTexto(vDataset.FindField('NOME'), 'Nome', 30, taLeftJustify);
  FormataCampoNumerico(vDataset.FindField('SDINICIAL'),'Sld Inicial',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('COMISSAO'),'Comissão',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('SDFINAL'),'Sld Final',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('SDINI'),'Sld Inicial',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('VLCOM'),'Comissão',8, taRightJustify);
  FormataCampoNumerico(vDataset.FindField('SDFIM'),'Sld Final',8, taRightJustify);
  Result := vDataset;
end;

function TModelItemComissaoPermanencia.TemDados: Boolean;
begin
  Result := not FQuery.Dataset.EOF;
end;

function TModelItemComissaoPermanencia.Proximo: Boolean;
begin
  FQuery.Dataset.Next;
  Result := TemDados;
end;

function TModelItemComissaoPermanencia.NovoCodigo: Integer;
begin
  Result := FQuery.Open(FSQL.SqlNovoCodigo).FieldByName('MAXCOD').AsInteger + 1;
end;

procedure TModelItemComissaoPermanencia.AlteraCmPer(pCmPer: Integer);
begin
  FQuery.Executar(Format(FSQL.SqlAlteraCmPer, [Pcmper]));
end;

procedure TModelItemComissaoPermanencia.ApagaCalculo;
begin
  FQuery.Executar(Format(FSQL.SqlApagaCalculo,[0]));
end;

procedure TModelItemComissaoPermanencia.ApagaItens(pCalculo: Integer);
begin
  FQuery.Executar(Format(FSQL.SqlApagaCalculo,[Pcalculo]));
end;

function TModelItemComissaoPermanencia.CODIGO(aValue: Integer
  ): iModelItemComissaoPermanencia;
begin
  FCodigo := Avalue;
  Result := Self;
end;

function TModelItemComissaoPermanencia.CMPER(aValue: Integer
  ): iModelItemComissaoPermanencia;
begin
  FCmPer := Avalue;
  Result := Self;
end;

function TModelItemComissaoPermanencia.GRUPO(aValue: String
  ): iModelItemComissaoPermanencia;
begin
  FGrupo := Avalue;
  Result := Self;
end;

function TModelItemComissaoPermanencia.SEQ(aValue: String
  ): iModelItemComissaoPermanencia;
begin
  FSeq := Avalue;
  Result := Self;
end;

function TModelItemComissaoPermanencia.COTA(aValue: String
  ): iModelItemComissaoPermanencia;
begin
  FCota := Avalue;
  Result := Self;
end;

function TModelItemComissaoPermanencia.SDINICIAL(aValue: Double
  ): iModelItemComissaoPermanencia;
begin
  FSaldoInicial := Avalue;
  Result := Self;
end;

function TModelItemComissaoPermanencia.COMISSAO(aValue: Double
  ): iModelItemComissaoPermanencia;
begin
  FComissao := Avalue;
  Result := Self;
end;

function TModelItemComissaoPermanencia.SDFINAL(aValue: Double
  ): iModelItemComissaoPermanencia;
begin
  FSaldoFinal := Avalue;
  Result := Self;
end;

function TModelItemComissaoPermanencia.SDFINAL: Double;
begin
  Result := FQuery.FieldByName('SDFINAL').AsFloat;
end;

function TModelItemComissaoPermanencia.SDINICIAL: Double;
begin
  Result := FQuery.FieldByName('SDINICIAL').AsFloat;
end;

function TModelItemComissaoPermanencia.GRUPO: String;
begin
  Result := FQuery.FieldByName('GRUPO').AsString;
end;

function TModelItemComissaoPermanencia.SEQ: String;
begin
  Result := FQuery.FieldByName('SEQ').AsString;
end;

function TModelItemComissaoPermanencia.COTA: String;
begin
  Result := FQuery.FieldByName('COTA').AsString;
end;

function TModelItemComissaoPermanencia.COMISSAO: Double;
begin
  Result := FQuery.FieldByName('COMISSAO').AsFloat;
end;

end.

