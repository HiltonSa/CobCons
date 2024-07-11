unit cobcons.model.precobem;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TModelPrecoBem }

   TModelPrecoBem = class (TInterfacedObject, iModelPrecoBem)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlPrecoBem;

       //function RetornarSQL(pTipo: Integer): string;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelPrecoBem;

       function RetornaPrecoBemData(pBem, pFilial: String; pData: TDateTime): iModelPrecoBem;
       function RetornaPrecoBem(pBem, pFilial: String): iModelPrecoBem;
       function Dataset: TDataSet;
       function PRE_TABE: Double;
       function PRE_REAL: Double;
   end;


implementation

uses cobcons.controller.util, cobcons.model.sql.factory;

{ TModelPrecoBem }

//function TmodelPrecoBem.Retornarsql(Ptipo: Integer): String;
//var
//  vSql: String;
//begin
  //FormatSettings.DecimalSeparator := '.';
  //case Ptipo of
  //  1: vSql := Format(SQL_GRUPO_COTA,
  //        [ QuotedStr(FFantasia),
  //          QuotedStr(RetornaSemFormatacao(FCgc)),
  //          FPcMulta,
  //          FPcJuros,
  //          FPcHonorarios,
  //          QuotedStr(RetornaDataSql(FUltSag)),
  //          QuotedStr(FNmContato),
  //          QuotedStr(FTelContato),
  //          QuotedStr(FMailContato)]);
  //end;
  //FormatSettings.DecimalSeparator := ',';
//  Result := vSql;
//end;

constructor Tmodelprecobem.Create(Aquery: Iqueryrest);
begin
  FQuery := Aquery;
  FSQL := TModelSQLFactory.New.SqlPrecoBem;
end;

destructor Tmodelprecobem.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelprecobem.New(Aquery: Iqueryrest): Imodelprecobem;
begin
  Result := Self.Create(Aquery);
end;

function Tmodelprecobem.Retornaprecobemdata(Pbem, Pfilial: String; Pdata: Tdatetime): Imodelprecobem;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaPrecoBemData( Pbem, Pfilial, Pdata));
end;

function Tmodelprecobem.Retornaprecobem(Pbem, Pfilial: String): Imodelprecobem;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaPrecoBem( Pbem, Pfilial));
end;

function Tmodelprecobem.Dataset: Tdataset;
const
  NAO_ENCONTRADO = -1;
var
  vLista: TStringList;
  vDataset: TDataSet;
begin
  vDataset :=  FQuery.Dataset;
  vLista := TStringList.Create;
  try
    vDataset.GetFieldNames(vLista);
    if vLista.IndexOf('PRE_TABE') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('PRE_TABE')).DisplayFormat := ',#0.00';
    Result := vDataset;
  finally
    vLista.Free;
  end;
end;

function Tmodelprecobem.Pre_tabe: Double;
begin
  Result := FQuery.FieldByName('PRE_TABE').AsFloat;
end;

function Tmodelprecobem.Pre_real: Double;
begin
  Result := FQuery.FieldByName('PRE_REAL').AsFloat;
end;

end.



