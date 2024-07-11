unit cobcons.model.empresa;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TEmpresa }

   { TModelEmpresa }

   TModelEmpresa = class (TInterfacedObject, iModelEmpresa)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlEmpresa;

       FCodigo: Integer;
       FFantasia: string;
       FCgc: string;
       FPcMulta: Double;
       FPcJuros: Double;
       FPcHonorarios: Double;
       FUltSag: TDatetime;
       FNmContato: string;
       FTelContato: string;
       FMailContato: string;
       FStrLib: string;
       FStGruEncCt: string;
       FFaseAjuiz: string;
       FDtRecSldRnp: TDateTime;
       FDtRcCmPer: TDateTime;
       FDtLimRed: TDateTime;
       FPcRedApl: Double;
       FVlLimExi: Double;

       procedure AtualizarCampos;
       function RetornarSQL(pTipo: Integer): string;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelEmpresa;

       function RecuperarEmpresa: iModelEmpresa;
       function GravarFicha: iModelEmpresa;
       function GravarAutorizacao(aValue: String): iModelEmpresa;
       function DataSet: TDataSet;
       function CODIGO(aValue: Integer): iModelEmpresa; overload;
       function FANTASIA(aValue: string): iModelEmpresa; overload;
       function CGC(aValue: string): iModelEmpresa; overload;
       function PCMULTAS(aValue: Double): iModelEmpresa; overload;
       function PCJUROS(aValue: Double): iModelEmpresa; overload;
       function PCHONORARIOS(aValue: Double): iModelEmpresa; overload;
       function ULTSAG(aValue: TDateTime): iModelEmpresa; overload;
       function NMCONTATO(aValue: string): iModelEmpresa; overload;
       function TELCONTATO(aValue: string): iModelEmpresa; overload;
       function MAILCONTATO(aValue: string): iModelEmpresa; overload;
       function STGRUENCCT(aValue: string): iModelEmpresa; overload;
       function FASEAJUIZ(aValue: string): iModelEmpresa; overload;
       function DTRECSLDRNP(aValue: TDateTime): iModelEmpresa; overload;
       function DTRCCMPER(aValue: TDateTime): iModelEmpresa; overload;
       function PCREDAPL(aValue: Double): iModelEmpresa; overload;
       function DTLIMRED(aValue: TDateTime): iModelEmpresa; overload;
       function VLLIMEXI(aValue: Double): iModelEmpresa; overload;
       function VLLIMEXI: Double; overload;
       function DTLIMRED: TDateTime; overload;
       function PCREDAPL: Double; overload;
       function DTRCCMPER: TDateTime; overload;
       function DTRECSLDRNP: TDateTime; overload;
       function FASEAJUIZ: String; overload;
       function STGRUENCCT: String; overload;
       function CODIGO: Integer; overload;
       function FANTASIA: String; overload;
       function CGC: String; overload;
       function PCMULTAS: Double; overload;
       function PCJUROS: Double; overload;
       function PCHONORARIOS: Double; overload;
       function ULTSAG: TDateTime; overload;
       function NMCONTATO: String; overload;
       function TELCONTATO: String; overload;
       function MAILCONTATO: String; overload;
       function STRLIB: String; overload;
   end;


implementation

uses cobcons.controller.util, cobcons.model.sql.factory;


{ TModelEmpresa }

procedure Tmodelempresa.Atualizarcampos;
begin
  FCodigo   := FQuery.FieldByName('CD_PRS').AsInteger;
  FFantasia := FQuery.FieldByName('NM_PRS').AsString;
  FCgc      := FQuery.FieldByName('CD_CGC').AsString;
  FPcMulta  := FQuery.FieldByName('PC_MUL').AsFloat;
  FPcJuros  := FQuery.FieldByName('PC_JUR').AsFloat;
  FPcHonorarios := FQuery.FieldByName('PC_HONOR').AsFloat;
  FPcRedApl  := FQuery.FieldByName('PCREDAPL').AsFloat;
  FUltSag       := FQuery.FieldByName('ULTSAG').AsDateTime;
  FNmContato    := FQuery.FieldByName('NMCONTATO').AsString;
  FTelContato   := FQuery.FieldByName('TELCONTATO').AsString;
  FMailContato  := FQuery.FieldByName('MAILCONTATO').AsString;
  FStrLib  := FQuery.FieldByName('STRLIB').AsString;
  FStGruEncCt := FQuery.FieldByName('STGRENCCT').AsString;
  FFaseAjuiz := FQuery.FieldByName('FASEAJUIZ').AsString;
  FDtRecSldRnp :=  FQuery.FieldByName('DTRECSLDRNP').AsDateTime;
  FDtRcCmPer :=  FQuery.FieldByName('DTRCCMPER').AsDateTime;
  FDtLimRed :=  FQuery.FieldByName('DTLIMRED').AsDateTime;
  FVlLimExi :=  FQuery.FieldByName('VLLIMEXI').AsFloat;
end;

function Tmodelempresa.Retornarsql(Ptipo: Integer): String;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  case Ptipo of
    1: vSql := Format(FSQL.SqlGravarFicha,
          [ QuotedStr(FFantasia),
            QuotedStr(RetornaSemFormatacao(FCgc)),
            FPcMulta,
            FPcJuros,
            FPcHonorarios,
            QuotedStr(RetornaDataSql(FUltSag)),
            QuotedStr(FNmContato),
            QuotedStr(FTelContato),
            QuotedStr(FMailContato),
            QuotedStr(FStGruEncCt),
            QuotedStr(FFaseAjuiz),
            QuotedStr(RetornaDataSql(FDtRecSldRnp)),
            QuotedStr(RetornaDataSql(FDtRcCmPer)),
            FPcRedApl,
            QuotedStr(RetornaDataSql(FDtLimRed)),
            FVlLimExi]);
  end;
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

constructor Tmodelempresa.Create(Aquery: Iqueryrest);
begin
  FQuery := Aquery;
  FSQL := TModelSQLFactory.New.SqlEmpresa;
end;

destructor Tmodelempresa.Destroy;
begin
  inherited Destroy;
  //FImgLogin.Free;
  //FImgTipo.Free;
  //FMemCertificado.Free;
end;

class function Tmodelempresa.New(Aquery: Iqueryrest): Imodelempresa;
begin
  Result := Self.Create(Aquery);
end;

function Tmodelempresa.Recuperarempresa: Imodelempresa;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRecuperarEmpresa);
  AtualizarCampos;
end;

function Tmodelempresa.Gravarficha: Imodelempresa;
begin
  FQuery.Executar(RetornarSQL(1));
  Result := Self;
end;

function Tmodelempresa.Gravarautorizacao(Avalue: String): Imodelempresa;
begin
  FQuery.Executar(FSQL.SqlGravarAutorizacao(Avalue));
  Result := Self;
end;

function Tmodelempresa.Dataset: Tdataset;
begin
  Result := FQuery.Dataset;
end;

function Tmodelempresa.Codigo(Avalue: Integer): Imodelempresa;
begin
  Result := Self;
  FCodigo := Avalue;
end;

function Tmodelempresa.Fantasia(Avalue: String): Imodelempresa;
begin
  Result := Self;
  FFantasia := Avalue;
end;

function Tmodelempresa.Cgc(Avalue: String): Imodelempresa;
begin
  Result := Self;
  FCgc := Avalue;
end;

function Tmodelempresa.Pcmultas(Avalue: Double): Imodelempresa;
begin
  Result := Self;
  FPcMulta := Avalue;
end;

function Tmodelempresa.Pcjuros(Avalue: Double): Imodelempresa;
begin
  Result := Self;
  FPcJuros := Avalue;
end;

function Tmodelempresa.Pchonorarios(Avalue: Double): Imodelempresa;
begin
  Result := Self;
  FPcHonorarios := Avalue;
end;

function Tmodelempresa.Ultsag(Avalue: Tdatetime): Imodelempresa;
begin
  Result := Self;
  FUltSag := Avalue;
end;

function Tmodelempresa.Nmcontato(Avalue: String): Imodelempresa;
begin
  Result := Self;
  FNmContato := Avalue;
end;

function Tmodelempresa.Telcontato(Avalue: String): Imodelempresa;
begin
  Result := Self;
  FTelContato := Avalue;
end;

function Tmodelempresa.Mailcontato(Avalue: String): Imodelempresa;
begin
  Result := Self;
  FMailContato := Avalue;
end;

function Tmodelempresa.Stgruencct(Avalue: String): Imodelempresa;
begin
  Result := Self;
  FStGruEncCt := Avalue;
end;

function Tmodelempresa.Faseajuiz(Avalue: String): Imodelempresa;
begin
  Result := Self;
  FFaseAjuiz := Avalue;
end;

function Tmodelempresa.Dtrecsldrnp(Avalue: Tdatetime): Imodelempresa;
begin
  Result := Self;
  FDtRecSldRnp := Avalue;
end;

function Tmodelempresa.Dtrccmper(Avalue: Tdatetime): Imodelempresa;
begin
  Result := Self;
  FDtRcCmPer := Avalue;
end;

function Tmodelempresa.Pcredapl(Avalue: Double): Imodelempresa;
begin
  Result := Self;
  FPcRedApl := Avalue;
end;

function Tmodelempresa.Dtlimred(Avalue: Tdatetime): Imodelempresa;
begin
  Result := Self;
  FDtLimRed := Avalue;
end;

function Tmodelempresa.Vllimexi(Avalue: Double): Imodelempresa;
begin
  Result := Self;
  FVlLimExi := Avalue;
end;

function Tmodelempresa.Vllimexi: Double;
begin
  Result := FVlLimExi;
end;

function Tmodelempresa.Dtlimred: Tdatetime;
begin
  Result := FDtLimRed;
end;

function Tmodelempresa.Pcredapl: Double;
begin
  Result := FPcRedApl;
end;

function Tmodelempresa.Dtrccmper: Tdatetime;
begin
  Result := FDtRcCmPer;
end;

function Tmodelempresa.Dtrecsldrnp: Tdatetime;
begin
  Result := FDtRecSldRnp;
end;

function Tmodelempresa.Faseajuiz: String;
begin
  Result := FFaseAjuiz;
end;

function Tmodelempresa.Stgruencct: String;
begin
  Result := FStGruEncCt;
end;

function Tmodelempresa.Codigo: Integer;
begin
  Result := FCodigo;
end;

function Tmodelempresa.Fantasia: String;
begin
  Result := FFantasia;
end;

function Tmodelempresa.Cgc: String;
begin
  Result := FCgc;
end;

function Tmodelempresa.Pcmultas: Double;
begin
  Result := FPcMulta;
end;

function Tmodelempresa.Pcjuros: Double;
begin
  Result := FPcJuros;
end;

function Tmodelempresa.Pchonorarios: Double;
begin
  Result := FPcHonorarios;
end;

function Tmodelempresa.Ultsag: Tdatetime;
begin
  Result := FUltSag;
end;

function Tmodelempresa.Nmcontato: String;
begin
  Result := FNmContato;
end;

function Tmodelempresa.Telcontato: String;
begin
  Result := FTelContato;
end;

function Tmodelempresa.Mailcontato: String;
begin
  Result := FMailContato;
end;

function Tmodelempresa.Strlib: String;
begin
  Result := FStrLib;
end;

end.


