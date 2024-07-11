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
       FNmRel   : string;
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
       function NMREL(aValue: string): iModelEmpresa; overload;
       function NMREL: String; overload;
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

procedure TModelEmpresa.AtualizarCampos;
begin
  FCodigo   := FQuery.FieldByName('CD_PRS').AsInteger;
  FFantasia := FQuery.FieldByName('NM_PRS').AsString;
  FNmRel    := FQuery.FieldByName('NM_REL').AsString;
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

function TModelEmpresa.RetornarSQL(pTipo: Integer): string;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  case Ptipo of
    1: vSql := Format(FSQL.SqlGravarFicha,
          [ QuotedStr(FFantasia),
            QuotedStr(FNmRel),
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

constructor TModelEmpresa.Create(aQuery: iQueryRest);
begin
  FQuery := Aquery;
  FSQL := TModelSQLFactory.New.SqlEmpresa;
end;

destructor TModelEmpresa.Destroy;
begin
  inherited Destroy;
  //FImgLogin.Free;
  //FImgTipo.Free;
  //FMemCertificado.Free;
end;

class function TModelEmpresa.New(aQuery: iQueryRest): iModelEmpresa;
begin
  Result := Self.Create(Aquery);
end;

function TModelEmpresa.RecuperarEmpresa: iModelEmpresa;
begin
  Result := Self;
  FQuery.Open(FSQL.SqlRecuperarEmpresa);
  AtualizarCampos;
end;

function TModelEmpresa.GravarFicha: iModelEmpresa;
begin
  FQuery.Executar(RetornarSQL(1));
  Result := Self;
end;

function TModelEmpresa.GravarAutorizacao(aValue: String): iModelEmpresa;
begin
  FQuery.Executar(FSQL.SqlGravarAutorizacao(Avalue));
  Result := Self;
end;

function TModelEmpresa.DataSet: TDataSet;
begin
  Result := FQuery.Dataset;
end;

function TModelEmpresa.CODIGO(aValue: Integer): iModelEmpresa;
begin
  Result := Self;
  FCodigo := Avalue;
end;

function TModelEmpresa.FANTASIA(aValue: string): iModelEmpresa;
begin
  Result := Self;
  FFantasia := Avalue;
end;

function TModelEmpresa.CGC(aValue: string): iModelEmpresa;
begin
  Result := Self;
  FCgc := Avalue;
end;

function TModelEmpresa.PCMULTAS(aValue: Double): iModelEmpresa;
begin
  Result := Self;
  FPcMulta := Avalue;
end;

function TModelEmpresa.PCJUROS(aValue: Double): iModelEmpresa;
begin
  Result := Self;
  FPcJuros := Avalue;
end;

function TModelEmpresa.PCHONORARIOS(aValue: Double): iModelEmpresa;
begin
  Result := Self;
  FPcHonorarios := Avalue;
end;

function TModelEmpresa.ULTSAG(aValue: TDateTime): iModelEmpresa;
begin
  Result := Self;
  FUltSag := Avalue;
end;

function TModelEmpresa.NMCONTATO(aValue: string): iModelEmpresa;
begin
  Result := Self;
  FNmContato := Avalue;
end;

function TModelEmpresa.TELCONTATO(aValue: string): iModelEmpresa;
begin
  Result := Self;
  FTelContato := Avalue;
end;

function TModelEmpresa.MAILCONTATO(aValue: string): iModelEmpresa;
begin
  Result := Self;
  FMailContato := Avalue;
end;

function TModelEmpresa.STGRUENCCT(aValue: string): iModelEmpresa;
begin
  Result := Self;
  FStGruEncCt := Avalue;
end;

function TModelEmpresa.FASEAJUIZ(aValue: string): iModelEmpresa;
begin
  Result := Self;
  FFaseAjuiz := Avalue;
end;

function TModelEmpresa.DTRECSLDRNP(aValue: TDateTime): iModelEmpresa;
begin
  Result := Self;
  FDtRecSldRnp := Avalue;
end;

function TModelEmpresa.DTRCCMPER(aValue: TDateTime): iModelEmpresa;
begin
  Result := Self;
  FDtRcCmPer := Avalue;
end;

function TModelEmpresa.PCREDAPL(aValue: Double): iModelEmpresa;
begin
  Result := Self;
  FPcRedApl := Avalue;
end;

function TModelEmpresa.DTLIMRED(aValue: TDateTime): iModelEmpresa;
begin
  Result := Self;
  FDtLimRed := Avalue;
end;

function TModelEmpresa.VLLIMEXI(aValue: Double): iModelEmpresa;
begin
  Result := Self;
  FVlLimExi := Avalue;
end;

function TModelEmpresa.NMREL(aValue: string): iModelEmpresa;
begin
  Result := Self;
  FNmRel := Avalue;
end;

function TModelEmpresa.NMREL: String;
begin
  Result := FNmRel;
end;

function TModelEmpresa.VLLIMEXI: Double;
begin
  Result := FVlLimExi;
end;

function TModelEmpresa.DTLIMRED: TDateTime;
begin
  Result := FDtLimRed;
end;

function TModelEmpresa.PCREDAPL: Double;
begin
  Result := FPcRedApl;
end;

function TModelEmpresa.DTRCCMPER: TDateTime;
begin
  Result := FDtRcCmPer;
end;

function TModelEmpresa.DTRECSLDRNP: TDateTime;
begin
  Result := FDtRecSldRnp;
end;

function TModelEmpresa.FASEAJUIZ: String;
begin
  Result := FFaseAjuiz;
end;

function TModelEmpresa.STGRUENCCT: String;
begin
  Result := FStGruEncCt;
end;

function TModelEmpresa.CODIGO: Integer;
begin
  Result := FCodigo;
end;

function TModelEmpresa.FANTASIA: String;
begin
  Result := FFantasia;
end;

function TModelEmpresa.CGC: String;
begin
  Result := FCgc;
end;

function TModelEmpresa.PCMULTAS: Double;
begin
  Result := FPcMulta;
end;

function TModelEmpresa.PCJUROS: Double;
begin
  Result := FPcJuros;
end;

function TModelEmpresa.PCHONORARIOS: Double;
begin
  Result := FPcHonorarios;
end;

function TModelEmpresa.ULTSAG: TDateTime;
begin
  Result := FUltSag;
end;

function TModelEmpresa.NMCONTATO: String;
begin
  Result := FNmContato;
end;

function TModelEmpresa.TELCONTATO: String;
begin
  Result := FTelContato;
end;

function TModelEmpresa.MAILCONTATO: String;
begin
  Result := FMailContato;
end;

function TModelEmpresa.STRLIB: String;
begin
  Result := FStrLib;
end;

end.


