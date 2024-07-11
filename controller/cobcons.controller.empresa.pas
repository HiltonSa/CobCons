unit cobcons.controller.empresa;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerEmpresa }

    TControllerEmpresa = class (TInterfacedObject, iControllerEmpresa)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelEmpresa;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerEmpresa;

      function RecuperarEmpresa: iControllerEmpresa;
      function GravarFicha: iControllerEmpresa;
      function GravarAutorizacao(aValue: String): iControllerEmpresa;
      function DataSet: TDataSet;
      function CODIGO(aValue: Integer): iControllerEmpresa; overload;
      function FANTASIA(aValue: string): iControllerEmpresa; overload;
      function CGC(aValue: string): iControllerEmpresa; overload;
      function PCMULTAS(aValue: Double): iControllerEmpresa; overload;
      function PCJUROS(aValue: Double): iControllerEmpresa; overload;
      function PCHONORARIOS(aValue: Double): iControllerEmpresa; overload;
      function ULTSAG(aValue: TDateTime): iControllerEmpresa; overload;
      function NMCONTATO(aValue: string): iControllerEmpresa; overload;
      function TELCONTATO(aValue: string): iControllerEmpresa; overload;
      function MAILCONTATO(aValue: string): iControllerEmpresa; overload;
      function STGRUENCCT(aValue: string): iControllerEmpresa; overload;
      function FASEAJUIZ(aValue: string): iControllerEmpresa; overload;
      function DTRECSLDRNP(aValue: TDateTime): iControllerEmpresa; overload;
      function DTRCCMPER(aValue: TDateTime): iControllerEmpresa; overload;
      function PCREDAPL(aValue: Double): iControllerEmpresa; overload;
      function DTLIMRED(aValue: TDateTime): iControllerEmpresa; overload;
      function VLLIMEXI(aValue: Double): iControllerEmpresa; overload;
      function NMREL(aValue: string): iControllerEmpresa; overload;
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

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerEmpresa }

constructor TControllerEmpresa.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Empresa(fQuery);
end;

destructor TControllerEmpresa.Destroy;
begin
  inherited Destroy;
end;

class function TControllerEmpresa.New: iControllerEmpresa;
begin
  Result := Self.Create;
end;

function TControllerEmpresa.RecuperarEmpresa: iControllerEmpresa;
begin
  Result := Self;
  FEntidade.RecuperarEmpresa;
end;

function TControllerEmpresa.GravarFicha: iControllerEmpresa;
begin
  Result := Self;
  FEntidade.GravarFicha;
end;

function TControllerEmpresa.GravarAutorizacao(aValue: String
  ): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.GravarAutorizacao(Avalue);
end;

function TControllerEmpresa.DataSet: TDataSet;
begin
  Result := FEntidade.DataSet;
end;

function TControllerEmpresa.CODIGO(aValue: Integer): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.CODIGO(Avalue);
end;

function TControllerEmpresa.FANTASIA(aValue: string): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.FANTASIA(Avalue);
end;

function TControllerEmpresa.CGC(aValue: string): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.CGC(Avalue);
end;

function TControllerEmpresa.PCMULTAS(aValue: Double): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.PCMULTAS(Avalue);
end;

function TControllerEmpresa.PCJUROS(aValue: Double): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.PCJUROS(Avalue);
end;

function TControllerEmpresa.PCHONORARIOS(aValue: Double): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.PCHONORARIOS(Avalue);
end;

function TControllerEmpresa.ULTSAG(aValue: TDateTime): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.ULTSAG(Avalue);
end;

function TControllerEmpresa.NMCONTATO(aValue: string): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.NMCONTATO(Avalue);
end;

function TControllerEmpresa.TELCONTATO(aValue: string): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.TELCONTATO(Avalue);
end;

function TControllerEmpresa.MAILCONTATO(aValue: string): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.MAILCONTATO(Avalue);
end;

function TControllerEmpresa.STGRUENCCT(aValue: string): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.STGRUENCCT(Avalue);
end;

function TControllerEmpresa.FASEAJUIZ(aValue: string): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.FASEAJUIZ(Avalue);
end;

function TControllerEmpresa.DTRECSLDRNP(aValue: TDateTime): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.DTRECSLDRNP(Avalue);
end;

function TControllerEmpresa.DTRCCMPER(aValue: TDateTime): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.DTRCCMPER(Avalue);
end;

function TControllerEmpresa.PCREDAPL(aValue: Double): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.PCREDAPL(Avalue);
end;

function TControllerEmpresa.DTLIMRED(aValue: TDateTime): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.DTLIMRED(Avalue);
end;

function TControllerEmpresa.VLLIMEXI(aValue: Double): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.VLLIMEXI(Avalue);
end;

function TControllerEmpresa.NMREL(aValue: string): iControllerEmpresa;
begin
  Result := Self;
  FEntidade.NMREL(Avalue);
end;

function TControllerEmpresa.NMREL: String;
begin
  Result := FEntidade.NMREL;
end;

function TControllerEmpresa.VLLIMEXI: Double;
begin
  Result := FEntidade.VLLIMEXI;
end;

function TControllerEmpresa.DTLIMRED: TDateTime;
begin
  Result := FEntidade.DTLIMRED;
end;

function TControllerEmpresa.PCREDAPL: Double;
begin
  Result := FEntidade.PCREDAPL;
end;

function TControllerEmpresa.DTRCCMPER: TDateTime;
begin
  Result := FEntidade.DTRCCMPER;
end;

function TControllerEmpresa.DTRECSLDRNP: TDateTime;
begin
  Result := FEntidade.DTRECSLDRNP;
end;

function TControllerEmpresa.FASEAJUIZ: String;
begin
  Result := FEntidade.FASEAJUIZ;
end;

function TControllerEmpresa.STGRUENCCT: String;
begin
  Result := FEntidade.STGRUENCCT;
end;

function TControllerEmpresa.CODIGO: Integer;
begin
  Result := FEntidade.CODIGO;
end;

function TControllerEmpresa.FANTASIA: String;
begin
  Result := FEntidade.FANTASIA;
end;

function TControllerEmpresa.CGC: String;
begin
  Result := FEntidade.CGC;
end;

function TControllerEmpresa.PCMULTAS: Double;
begin
  Result := FEntidade.PCMULTAS;
end;

function TControllerEmpresa.PCJUROS: Double;
begin
  Result := FEntidade.PCJUROS;
end;

function TControllerEmpresa.PCHONORARIOS: Double;
begin
  Result := FEntidade.PCHONORARIOS;
end;

function TControllerEmpresa.ULTSAG: TDateTime;
begin
  Result := FEntidade.ULTSAG;
end;

function TControllerEmpresa.NMCONTATO: String;
begin
  Result := FEntidade.NMCONTATO;
end;

function TControllerEmpresa.TELCONTATO: String;
begin
  Result := FEntidade.TELCONTATO;
end;

function TControllerEmpresa.MAILCONTATO: String;
begin
  Result := FEntidade.MAILCONTATO;
end;

function TControllerEmpresa.STRLIB: String;
begin
  Result := FEntidade.STRLIB;
end;

end.


