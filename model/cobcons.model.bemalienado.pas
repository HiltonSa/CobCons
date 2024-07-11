unit cobcons.model.bemalienado;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TModelBemAlienado }

   TModelBemAlienado = class (TInterfacedObject, iModelBemAlienado)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlBemAlienado;

       //function RetornarSQL(pTipo: Integer): string;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelBemAlienado;

       function RetornaBensAlienadosCota(pGrupo, pCota: String): iModelBemAlienado;
       function RetornaBemAlienado(pGrupo, pCota, pChassis: String): iModelBemAlienado;
       function DataSet: TDataSet;
       function NR_CHASS: String;
   end;


implementation

uses cobcons.controller.util, cobcons.model.sql.factory;

{ TModelBemAlienado }

//function TmodelBemAlienado.Retornarsql(Ptipo: Integer): String;
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

constructor Tmodelbemalienado.Create(Aquery: Iqueryrest);
begin
  FQuery := Aquery;
  FSQL := TModelSQLFactory.New.SqlBemAlienado;
end;

destructor Tmodelbemalienado.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelbemalienado.New(Aquery: Iqueryrest): Imodelbemalienado;
begin
  Result := Self.Create(Aquery);
end;

function Tmodelbemalienado.Retornabensalienadoscota(Pgrupo, Pcota: String): Imodelbemalienado;
begin
  Result := Self;
  FQuery.Open( FSQL.SqlRetornaBensAlienadosCota(Pgrupo, Pcota ) );
end;

function Tmodelbemalienado.Retornabemalienado(Pgrupo, Pcota, Pchassis: String): Imodelbemalienado;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaBemAlienado(Pgrupo, Pcota, Pchassis ) );
end;

function Tmodelbemalienado.Dataset: Tdataset;
begin
  Result := FQuery.Dataset;
end;

function Tmodelbemalienado.Nr_chass: String;
begin
  Result := FQuery.FieldByName('NR_CHASS').AsString;
end;

end.



