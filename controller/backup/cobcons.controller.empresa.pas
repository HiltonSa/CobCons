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

constructor Tcontrollerempresa.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Empresa(fQuery);
end;

destructor Tcontrollerempresa.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollerempresa.New: Icontrollerempresa;
begin
  Result := Self.Create;
end;

function Tcontrollerempresa.Recuperarempresa: Icontrollerempresa;
begin
  Result := Self;
  FEntidade.RecuperarEmpresa;
end;

function Tcontrollerempresa.Gravarficha: Icontrollerempresa;
begin
  Result := Self;
  FEntidade.GravarFicha;
end;

function Tcontrollerempresa.Gravarautorizacao(Avalue: String): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.GravarAutorizacao(Avalue);
end;

function Tcontrollerempresa.Dataset: Tdataset;
begin
  Result := FEntidade.DataSet;
end;

function Tcontrollerempresa.Codigo(Avalue: Integer): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.CODIGO(Avalue);
end;

function Tcontrollerempresa.Fantasia(Avalue: String): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.FANTASIA(Avalue);
end;

function Tcontrollerempresa.Cgc(Avalue: String): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.CGC(Avalue);
end;

function Tcontrollerempresa.Pcmultas(Avalue: Double): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.PCMULTAS(Avalue);
end;

function Tcontrollerempresa.Pcjuros(Avalue: Double): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.PCJUROS(Avalue);
end;

function Tcontrollerempresa.Pchonorarios(Avalue: Double): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.PCHONORARIOS(Avalue);
end;

function Tcontrollerempresa.Ultsag(Avalue: Tdatetime): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.ULTSAG(Avalue);
end;

function Tcontrollerempresa.Nmcontato(Avalue: String): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.NMCONTATO(Avalue);
end;

function Tcontrollerempresa.Telcontato(Avalue: String): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.TELCONTATO(Avalue);
end;

function Tcontrollerempresa.Mailcontato(Avalue: String): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.MAILCONTATO(Avalue);
end;

function Tcontrollerempresa.Stgruencct(Avalue: String): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.STGRUENCCT(Avalue);
end;

function Tcontrollerempresa.Faseajuiz(Avalue: String): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.FASEAJUIZ(Avalue);
end;

function Tcontrollerempresa.Dtrecsldrnp(Avalue: Tdatetime): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.DTRECSLDRNP(Avalue);
end;

function Tcontrollerempresa.Dtrccmper(Avalue: Tdatetime): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.DTRCCMPER(Avalue);
end;

function Tcontrollerempresa.Pcredapl(Avalue: Double): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.PCREDAPL(Avalue);
end;

function Tcontrollerempresa.Dtlimred(Avalue: Tdatetime): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.DTLIMRED(Avalue);
end;

function Tcontrollerempresa.Vllimexi(Avalue: Double): Icontrollerempresa;
begin
  Result := Self;
  FEntidade.VLLIMEXI(Avalue);
end;

function Tcontrollerempresa.Vllimexi: Double;
begin
  Result := FEntidade.VLLIMEXI;
end;

function Tcontrollerempresa.Dtlimred: Tdatetime;
begin
  Result := FEntidade.DTLIMRED;
end;

function Tcontrollerempresa.Pcredapl: Double;
begin
  Result := FEntidade.PCREDAPL;
end;

function Tcontrollerempresa.Dtrccmper: Tdatetime;
begin
  Result := FEntidade.DTRCCMPER;
end;

function Tcontrollerempresa.Dtrecsldrnp: Tdatetime;
begin
  Result := FEntidade.DTRECSLDRNP;
end;

function Tcontrollerempresa.Faseajuiz: String;
begin
  Result := FEntidade.FASEAJUIZ;
end;

function Tcontrollerempresa.Stgruencct: String;
begin
  Result := FEntidade.STGRUENCCT;
end;

function Tcontrollerempresa.Codigo: Integer;
begin
  Result := FEntidade.CODIGO;
end;

function Tcontrollerempresa.Fantasia: String;
begin
  Result := FEntidade.FANTASIA;
end;

function Tcontrollerempresa.Cgc: String;
begin
  Result := FEntidade.CGC;
end;

function Tcontrollerempresa.Pcmultas: Double;
begin
  Result := FEntidade.PCMULTAS;
end;

function Tcontrollerempresa.Pcjuros: Double;
begin
  Result := FEntidade.PCJUROS;
end;

function Tcontrollerempresa.Pchonorarios: Double;
begin
  Result := FEntidade.PCHONORARIOS;
end;

function Tcontrollerempresa.Ultsag: Tdatetime;
begin
  Result := FEntidade.ULTSAG;
end;

function Tcontrollerempresa.Nmcontato: String;
begin
  Result := FEntidade.NMCONTATO;
end;

function Tcontrollerempresa.Telcontato: String;
begin
  Result := FEntidade.TELCONTATO;
end;

function Tcontrollerempresa.Mailcontato: String;
begin
  Result := FEntidade.MAILCONTATO;
end;

function Tcontrollerempresa.Strlib: String;
begin
  Result := FEntidade.STRLIB;
end;

end.


