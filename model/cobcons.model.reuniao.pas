unit cobcons.model.reuniao;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TModelReuniao }

   TModelReuniao = class (TInterfacedObject, iModelReuniao)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlReuniao;

       //function RetornarSQL(pTipo: Integer): string;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelReuniao;

       function RetornaReuniaoPagamento(pGrupo: String; pDtPag: TDateTime): iModelReuniao;
       function RetornaReuniaoGrupo(pGrupo: String): iModelReuniao;
       function Dataset: TDataSet;
       function DATA_REU: TDateTime;
       function NRO_REU: string;
   end;


implementation

uses cobcons.controller.util, cobcons.model.sql.factory;

const
  SQL_REUNIAO_PAGAMENTO =
    'select first 1 NRO_REU, DATA_REU from ACREU '+
    'where GRUPO = %s and DATA_REU >= %s ';

  SQL_REUNIAO_GRUPO =
    'select  NRO_REU, DATA_REU from ACREU where GRUPO = %s order by NRO_REU';
{ TModelReuniao }

//function TmodelReuniao.Retornarsql(Ptipo: Integer): String;
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

constructor Tmodelreuniao.Create(Aquery: Iqueryrest);
begin
  FQuery := Aquery;
  FSQL := TModelSQLFactory.New.SqlReuniao;
end;

destructor Tmodelreuniao.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelreuniao.New(Aquery: Iqueryrest): Imodelreuniao;
begin
  Result := Self.Create(Aquery);
end;

function Tmodelreuniao.Retornareuniaopagamento(Pgrupo: String; Pdtpag: Tdatetime): Imodelreuniao;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaReuniaoPagamento(Pgrupo, Pdtpag));
end;

function Tmodelreuniao.Retornareuniaogrupo(Pgrupo: String): Imodelreuniao;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaReuniaoGrupo(Pgrupo) );
end;

function Tmodelreuniao.Dataset: Tdataset;
begin
  Result := FQuery.Dataset;
end;

function Tmodelreuniao.Data_reu: Tdatetime;
begin
  Result := FQuery.FieldByName('DATA_REU').AsDateTime;
end;

function Tmodelreuniao.Nro_reu: String;
begin
  Result := FQuery.FieldByName('NRO_REU').AsString;
end;

end.



