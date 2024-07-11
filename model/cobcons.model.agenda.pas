unit cobcons.model.agenda;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, cobcons.model.interfaces,
  cobcons.model.sql.interfaces, db;

type

   { TModelAgenda }

   TModelAgenda = class (TInterfacedObject, iModelAgenda)
     private
       FQuery: iQueryRest;
       FSQL: iModelSqlAgenda;

       FCodigo: Integer;
       FDtAge: TDateTime;
       FPrioridade: Integer;
       FContrato: String;
       FStatus: Integer;
       FObs: TMemoryStream;
       FUsuario: Integer;
       FGrupo: string;
       FSeq: String;
       FCota: string;

       function RetornarSQL(pTipo: Integer): string;

     public
       constructor Create(aQuery: iQueryRest);
       destructor Destroy; override;
       class function New(aQuery: iQueryRest): iModelAgenda;

       function RetornaAgendaUsuarioPeriodo(pUsuario: Integer; pInicio, pFim: TDateTime): iModelAgenda;
       function AlterarPrioridade(pCodigo, pPrioridade: Integer): iModelAgenda;
       function AlterarStatus(pCodigo, pStatus: Integer): iModelAgenda;
       function Novo: iModelAgenda;
       function Alterar: iModelAgenda;
       function Excluir: iModelAgenda;
       function ProximoCodigo: Integer;
       function DataSet: TDataSet;
       function CODIGO(aValue: Integer): iModelAgenda; overload;
       function CODIGO: Integer; overload;
       function DTAGE(aValue: TDateTime): iModelAgenda; overload;
       function DTAGE: TDateTime; overload;
       function PRIORIDADE(aValue: Integer): iModelAgenda; overload;
       function PRIORIDADE: Integer; overload;
       function CONTRATO(aValue: String): iModelAgenda; overload;
       function CONTRATO: String; overload;
       function USUARIO(aValue: Integer): iModelAgenda; overload;
       function USUARIO: Integer; overload;
       function STATUS(aValue: Integer): iModelAgenda; overload;
       function STATUS: Integer; overload;
       function GRUPO(aValue: String): iModelAgenda; overload;
       function GRUPO: String; overload;
       function SEQ(aValue: String): iModelAgenda; overload;
       function SEQ: String; overload;
       function COTA(aValue: String): iModelAgenda; overload;
       function COTA: String; overload;
       function OBS(aValue: TMemoryStream): iModelAgenda; overload;
       function OBS: TMemoryStream; overload;
       function DCPRIORIDADE: String; overload;
       function NMUSUARIO: String; overload;
       function NMCOTA: String; overload;
       function DCSTATUS: String; overload;
   end;


implementation

uses cobcons.controller.util, cobcons.model.sql.factory;


{ TModelAgenda }

function Tmodelagenda.Retornarsql(Ptipo: Integer): String;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  case Ptipo of
    0: vSql := Format( FSQL.SQLNovo, [ FCodigo,
                                      QuotedStr(RetornaDataSql(FDtAge)),
                                      FPrioridade,
                                      QuotedStr(FContrato),
                                      FStatus,
                                      FUsuario,
                                      QuotedStr(FGrupo),
                                      QuotedStr(FSeq),
                                      QuotedStr(FCota)]);
    1: vSql := Format(FSQL.SQLAlterar,[ QuotedStr(RetornaDataSql(FDtAge)),
                                      FPrioridade,
                                      FUsuario,
                                      FCodigo]);
    2: vSql := FSQL.SQLProximoCodigo;
    3: vSql := Format(FSQL.SQLExcluir,[ FCodigo]);
  end;
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

constructor Tmodelagenda.Create(Aquery: Iqueryrest);
begin
  FObs := TMemoryStream.Create;
  FSQL := TModelSQLFactory.New.SqlAgenda;
  FQuery := Aquery;
end;

destructor Tmodelagenda.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelagenda.New(Aquery: Iqueryrest): Imodelagenda;
begin
  Result := Self.Create(Aquery);
end;

function Tmodelagenda.Retornaagendausuarioperiodo(Pusuario: Integer; Pinicio, Pfim: Tdatetime): Imodelagenda;
begin
  Result := Self;
  FQuery.Open( FSQL.SQLRetornaAgendaUsuarioPeriodo( Pusuario, Pinicio, Pfim) );
end;

function Tmodelagenda.Alterarprioridade(Pcodigo, Pprioridade: Integer): Imodelagenda;
begin
  Result := Self;
  FQuery.Executar(FSQL.SQLAlterarPrioridade(Pcodigo, Pprioridade));
end;

function Tmodelagenda.Alterarstatus(Pcodigo, Pstatus: Integer): Imodelagenda;
begin
  Result := Self;
  FQuery.Executar(FSQL.SQLAlterarStatus(Pcodigo, Pstatus));
end;

function Tmodelagenda.Novo: Imodelagenda;
begin
  FQuery.Executar(RetornarSQL(0));
  FQuery.AtualizarBlob('CJCBAGE', 'OBS', 'CD_AGE', FObs, FCodigo);
  Result := Self;
end;

function Tmodelagenda.Alterar: Imodelagenda;
begin
  FQuery.Executar(RetornarSQL(1));
  FQuery.AtualizarBlob('CJCBAGE', 'OBS', 'CD_AGE', FObs, FCodigo);
  Result := Self;
end;

function Tmodelagenda.Excluir: Imodelagenda;
begin
  FQuery.Executar(RetornarSQL(3));
  Result := Self;
end;

function Tmodelagenda.Proximocodigo: Integer;
begin
  Result := 1;
  Result := FQuery.Open(RetornarSQL(2)).Dataset.FieldByName('MCOD').AsInteger + 1;
end;

function Tmodelagenda.Dataset: Tdataset;
begin
  Result := FQuery.Dataset;
end;

function Tmodelagenda.Codigo(Avalue: Integer): Imodelagenda;
begin
  Result := Self;
  FCodigo := Avalue;
end;

function Tmodelagenda.Codigo: Integer;
begin
  Result := FQuery.FieldByName('CD_AGE').AsInteger;
end;

function Tmodelagenda.Dtage(Avalue: Tdatetime): Imodelagenda;
begin
  Result := Self;
  FDtAge := Avalue;
end;

function Tmodelagenda.Dtage: Tdatetime;
begin
  Result := FQuery.FieldByName('DT_AGE').AsDateTime;
end;

function Tmodelagenda.Prioridade(Avalue: Integer): Imodelagenda;
begin
  Result := Self;
  FPrioridade := Avalue;
end;

function Tmodelagenda.Prioridade: Integer;
begin
  Result := FQuery.FieldByName('PRIORIDADE').AsInteger;
end;

function Tmodelagenda.Contrato(Avalue: String): Imodelagenda;
begin
  Result := Self;
  FContrato := Avalue;
end;

function Tmodelagenda.Contrato: String;
begin
  Result := FQuery.FieldByName('CD_CTRATO').AsString;
end;

function Tmodelagenda.Usuario(Avalue: Integer): Imodelagenda;
begin
  Result := Self;
  FUsuario := Avalue;
end;

function Tmodelagenda.Usuario: Integer;
begin
  Result := FQuery.FieldByName('CD_USU').AsInteger;
end;

function Tmodelagenda.Status(Avalue: Integer): Imodelagenda;
begin
  Result := Self;
  FStatus := Avalue;
end;

function Tmodelagenda.Status: Integer;
begin
  Result := FQuery.FieldByName('STATUS').AsInteger;
end;

function Tmodelagenda.Grupo(Avalue: String): Imodelagenda;
begin
  Result := Self;
  FGrupo := Avalue;
end;

function Tmodelagenda.Grupo: String;
begin
  Result := FQuery.FieldByName('GRUPO').AsString;
end;

function Tmodelagenda.Seq(Avalue: String): Imodelagenda;
begin
  Result := Self;
  FSeq := Avalue;
end;

function Tmodelagenda.Seq: String;
begin
  Result := FQuery.FieldByName('SEQ').AsString;
end;

function Tmodelagenda.Cota(Avalue: String): Imodelagenda;
begin
  Result := Self;
  FCota := Avalue;
end;

function Tmodelagenda.Cota: String;
begin
  Result := FQuery.FieldByName('COTA').AsString;
end;

function Tmodelagenda.Obs(Avalue: Tmemorystream): Imodelagenda;
begin
  Result := Self;
  FObs := Avalue;
end;

function Tmodelagenda.Obs: Tmemorystream;
begin
  FObs.Clear;
  TBlobField( FQuery.FieldByName('OBS')).SaveToStream(FObs);
  FObs.Position := 0;
  Result := FObs;
end;

function Tmodelagenda.Dcprioridade: String;
begin
  Result := FQuery.FieldByName('DCPRIORIDADE').AsString;
end;

function Tmodelagenda.Nmusuario: String;
begin
  Result := FQuery.FieldByName('NMUSUARIO').AsString;
end;

function Tmodelagenda.Nmcota: String;
begin
  Result := FQuery.FieldByName('NMCOTA').AsString;
end;

function Tmodelagenda.Dcstatus: String;
begin
  Result := FQuery.FieldByName('DCSTATUS').AsString;
end;


end.


