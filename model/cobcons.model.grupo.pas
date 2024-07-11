unit cobcons.model.grupo;

{$mode delphi}

interface

uses
  Classes, Sysutils,  Controls, cobcons.model.interfaces, cobcons.model.sql.interfaces, db;

type

   { TModelGrupo }

   TModelGrupo = class (TInterfacedObject, iModelGrupo)
     private

       FQuery: iQueryRest;
       FSQL: iModelSqlGrupo;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelGrupo;

       function RetornaGrupo(pGrupo: string): iModelGrupo;
       function RetornaListaGrupos: iModelGrupo;
       function Dataset: TDataSet;
       function GRUPO: string;
       function PLA_PADR: string;
       function LIM_COTA: string;
       function PRIM_REU: TDateTime;
       function TP_GRUPO: string;
       function DCTPGRUPO: string;
       function SIT_GRUPO: string;
       function DCSITGRUPO: string;
       function DT_SITUA: TDateTime;
       function ULT_REUNIAO: TDateTime;
   end;


implementation

uses cobcons.controller.util, cobcons.model.sql.factory;


{ TModelGrupo }


constructor Tmodelgrupo.Create(Aquery: Iqueryrest);
begin
  FQuery := Aquery;
  FSQL := TModelSQLFactory.New.SqlGrupo;
end;

destructor Tmodelgrupo.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelgrupo.New(Aquery: Iqueryrest): Imodelgrupo;
begin
  Result := Self.Create(Aquery);
end;

function Tmodelgrupo.Retornagrupo(Pgrupo: String): Imodelgrupo;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRetornaGrupo(Pgrupo));
end;

function Tmodelgrupo.Retornalistagrupos: Imodelgrupo;
begin
Result := Self;
FQuery.Open(FSQL.SqlRetornaListaGrupos);
end;


function Tmodelgrupo.Dataset: Tdataset;
begin
  Result := FQuery.Dataset;
end;

function Tmodelgrupo.Grupo: String;
begin
  Result := FQuery.FieldByName('GRUPO').AsString;
end;

function Tmodelgrupo.Pla_padr: String;
begin
  Result := FQuery.FieldByName('PLA_PADR').AsString;
end;

function Tmodelgrupo.Lim_cota: String;
begin
Result := FQuery.FieldByName('LIM_COTA').AsString;
end;

function Tmodelgrupo.Prim_reu: Tdatetime;
begin
Result := FQuery.FieldByName('PRIM_REU').AsDateTime;
end;

function Tmodelgrupo.Tp_grupo: String;
begin
Result := FQuery.FieldByName('TP_GRUPO').AsString;
end;

function Tmodelgrupo.Dctpgrupo: String;
begin
Result := FQuery.FieldByName('DCTPGRUPO').AsString;
end;

function Tmodelgrupo.Sit_grupo: String;
begin
Result := FQuery.FieldByName('SIT_GRU').AsString;
end;

function Tmodelgrupo.Dcsitgrupo: String;
begin
Result := FQuery.FieldByName('DCSITGRUPO').AsString;
end;

function Tmodelgrupo.Dt_situa: Tdatetime;
begin
Result := FQuery.FieldByName('DT_SITUA').AsDateTime;
end;

function Tmodelgrupo.Ult_reuniao: Tdatetime;
begin
Result := FQuery.FieldByName('ULT_REUNIAO').AsDateTime;
end;

end.



