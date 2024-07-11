unit cobcons.model.credito;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TModelCredito }

   TModelCredito = class (TInterfacedObject, iModelCredito)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlCredito;

       //function RetornarSQL(pTipo: Integer): string;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelCredito;

       function RetornaCreditosCota(pGrupo, pCota: String): iModelCredito;
       function RetornaUmCreditoCota(pGrupo, pCota, pCredito: String): iModelCredito;
       function DataSet: TDataSet;
       function CREDITO: string;
       function TP_CRED: string;
       function DCTPCRED: string;
       function DT_I_COR: TDateTime;
       function LIM_CORR: TDateTime;
       function VAL_CRED: Double;
       function VAL_CORR: Double;
       function FORNEC: string;
       function NMFORNEC: string;
       function DT_N_FIS: TDateTime;
       function NR_N_FIS: string;
       function DT_PAGTO: TDateTime;
       function VAL_ENTR: Double;
       function COR_ENTR: Double;
       function OBSERV: string;
   end;


implementation

uses cobcons.controller.util, cobcons.model.sql.factory;


{ TModelCredito }

//function TmodelCredito.Retornarsql(Ptipo: Integer): String;
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

constructor Tmodelcredito.Create(Aquery: Iqueryrest);
begin
  FQuery := Aquery;
  FSQL := TModelSQLFactory.New.SqlCredito;
end;

destructor Tmodelcredito.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelcredito.New(Aquery: Iqueryrest): Imodelcredito;
begin
  Result := Self.Create(Aquery);
end;

function Tmodelcredito.Retornacreditoscota(Pgrupo, Pcota: String): Imodelcredito;
begin
  Result := Self;
  FQuery.Open( FSQL.SqlRetornaCreditosCota(Pgrupo, Pcota ));
end;

function Tmodelcredito.Retornaumcreditocota(Pgrupo, Pcota, Pcredito: String): Imodelcredito;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaUmCreditoCota(Pgrupo, Pcota, Pcredito ));
end;

function Tmodelcredito.Dataset: Tdataset;
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
    if vLista.IndexOf('VAL_CRED') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('VAL_CRED')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('VAL_CORR') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('VAL_CORR')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('VAL_ENTR') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('VAL_ENTR')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('COR_ENTR') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('COR_ENTR')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('VLTOT') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('VLTOT')).DisplayFormat := ',#0.00';
    if vLista.IndexOf('VLPAGO') > NAO_ENCONTRADO
    then TFloatField(vDataset.FieldByName('VLPAGO')).DisplayFormat := ',#0.00';
    Result := vDataset;
  finally
    vLista.Free;
  end;
end;

function Tmodelcredito.Credito: String;
begin
  Result := FQuery.FieldByName('CREDITO').AsString;
end;

function Tmodelcredito.Tp_cred: String;
begin
  Result := FQuery.FieldByName('TP_CRED').AsString;
end;

function Tmodelcredito.Dctpcred: String;
begin
  Result := FQuery.FieldByName('DCTPCRE').AsString;
end;

function Tmodelcredito.Dt_i_cor: Tdatetime;
begin
  Result := FQuery.FieldByName('DT_I_COR').AsDateTime;
end;

function Tmodelcredito.Lim_corr: Tdatetime;
begin
  Result := FQuery.FieldByName('LIM_CORR').AsDateTime;
end;

function Tmodelcredito.Val_cred: Double;
begin
  Result := FQuery.FieldByName('VAL_CRED').AsFloat;
end;

function Tmodelcredito.Val_corr: Double;
begin
  Result := FQuery.FieldByName('VAL_CORR').AsFloat;
end;

function Tmodelcredito.Fornec: String;
begin
  Result := FQuery.FieldByName('FORNEC').AsString;
end;

function Tmodelcredito.Nmfornec: String;
begin
  Result := FQuery.FieldByName('NMFORNEC').AsString;
end;

function Tmodelcredito.Dt_n_fis: Tdatetime;
begin
  Result := FQuery.FieldByName('DT_N_FIS').AsDateTime;
end;

function Tmodelcredito.Nr_n_fis: String;
begin
  Result := FQuery.FieldByName('NR_N_FIS').AsString;
end;

function Tmodelcredito.Dt_pagto: Tdatetime;
begin
  Result := FQuery.FieldByName('DT_PAGTO').AsDateTime;
end;

function Tmodelcredito.Val_entr: Double;
begin
  Result := FQuery.FieldByName('VAL_ENTR').AsFloat;
end;

function Tmodelcredito.Cor_entr: Double;
begin
  Result := FQuery.FieldByName('COR_ENTR').AsFloat;
end;

function Tmodelcredito.Observ: String;
begin
  Result := FQuery.FieldByName('OBSERV').AsString;
end;

end.



