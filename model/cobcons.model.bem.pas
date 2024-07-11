unit cobcons.model.bem;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TModelBem }

   TModelBem = class (TInterfacedObject, iModelBem)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlBem;

       //function RetornarSQL(pTipo: Integer): string;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelBem;

       function RetornaBem(pBem: string): iModelBem;
       function Dataset: TDataSet;
       function DESCRIC: string;
       function DCTIPOBEM: string;
       function DCFABBEM: string;
   end;


implementation

uses cobcons.controller.util, cobcons.model.sql.factory;


{ TModelBem }

//function TmodelBem.Retornarsql(Ptipo: Integer): String;
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

constructor Tmodelbem.Create(Aquery: Iqueryrest);
begin
  FSQL := TModelSQLFactory.New.SqlBem;
  FQuery := Aquery;
end;

destructor Tmodelbem.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelbem.New(Aquery: Iqueryrest): Imodelbem;
begin
  Result := Self.Create(Aquery);
end;

function Tmodelbem.Retornabem(Pbem: String): Imodelbem;
begin
  Result := Self;
  FQuery.Open(FSQL.SQLRetornaBem(Pbem));
end;


function Tmodelbem.Dataset: Tdataset;
begin
  Result := FQuery.Dataset;
end;

function Tmodelbem.Descric: String;
begin
  Result := FQuery.FieldByName('DESCRIC').AsString;
end;

function Tmodelbem.Dctipobem: String;
begin
  Result := FQuery.FieldByName('DCTIPOBEM').AsString;
end;

function Tmodelbem.Dcfabbem: String;
begin
  Result := FQuery.FieldByName('DCFABBEM').AsString;
end;

end.



