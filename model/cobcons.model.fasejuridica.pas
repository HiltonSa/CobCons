unit cobcons.model.fasejuridica;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TModelFaseJuridica }

   TModelFaseJuridica = class (TInterfacedObject, iModelFaseJuridica)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlFaseJuridica;

       //function RetornarSQL(pTipo: Integer): string;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelFaseJuridica;

       function RetornaFasesCota(pGrupo, pSeq, pCota: String): iModelFaseJuridica;
       function RetornaUmaFaseCota(pGrupo, pSeq, pCota, pFase: String): iModelFaseJuridica;
       function DataSet: TDataSet;
       function GRUPO: string;
       function SEQ: string;
       function COTA: string;
       function F_JURID: string;
       function NOME: string;
       function DCFASE: string;
       function D_INICIO: TDateTime;
       function NMREPRES: string;
       function CUST_MOE: double;
       function OBSERV: String;
   end;


implementation

uses cobcons.controller.util, cobcons.model.sql.factory;

{ TModelFaseJuridica }

//function TmodelFaseJuridica.Retornarsql(Ptipo: Integer): String;
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

constructor Tmodelfasejuridica.Create(Aquery: Iqueryrest);
begin
  FQuery := Aquery;
  FSQL := TModelSQLFactory.New.SqlFaseJuridica;
end;

destructor Tmodelfasejuridica.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelfasejuridica.New(Aquery: Iqueryrest): Imodelfasejuridica;
begin
  Result := Self.Create(Aquery);
end;

function Tmodelfasejuridica.Retornafasescota(Pgrupo, Pseq, Pcota: String): Imodelfasejuridica;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaFasesCota(Pgrupo, Pseq, Pcota));
end;

function Tmodelfasejuridica.Retornaumafasecota(Pgrupo, Pseq, Pcota, Pfase: String): Imodelfasejuridica;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaUmaFaseCota(Pgrupo, Pseq, Pcota, Pfase));
end;

function Tmodelfasejuridica.Dataset: Tdataset;
begin
  Result := FQuery.Dataset;
end;

function Tmodelfasejuridica.Grupo: String;
begin
  Result := FQuery.FieldByName('GRUPO').AsString;
end;

function Tmodelfasejuridica.Seq: String;
begin
  Result := FQuery.FieldByName('SEQ').AsString;
end;

function Tmodelfasejuridica.Cota: String;
begin
  Result := FQuery.FieldByName('COTA').AsString;
end;

function Tmodelfasejuridica.F_jurid: String;
begin
  Result := FQuery.FieldByName('F_JURID').AsString;
end;

function Tmodelfasejuridica.Nome: String;
begin
  Result := FQuery.FieldByName('NOME').AsString;
end;

function Tmodelfasejuridica.Dcfase: String;
begin
  Result := FQuery.FieldByName('DCFASE').AsString;
end;

function Tmodelfasejuridica.D_inicio: Tdatetime;
begin
  Result := FQuery.FieldByName('D_INICIO').AsDateTime;
end;

function Tmodelfasejuridica.Nmrepres: String;
begin
  Result := FQuery.FieldByName('NMREPRES').AsString;
end;

function Tmodelfasejuridica.Cust_moe: Double;
begin
  Result := FQuery.FieldByName('CUST_MOE').AsFloat;
end;

function Tmodelfasejuridica.Observ: String;
begin
  Result := FQuery.FieldByName('OBSERV').AsString;
end;


end.



