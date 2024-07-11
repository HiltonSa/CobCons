unit cobcons.controller.sag;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.bufferdataset, cobcons.model.interfaces, db, ComCtrls, ExtCtrls;

type

    { TControllerSag }

    TControllerSag = class (TInterfacedObject, iControllerSag)
    private
      FEntidade: iModelSag;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerSag;

      function CNPJADM(aValue: String): iControllerSag;
      function DATABASE(aValue: TDateTime): iControllerSag;
      function REMESSA(aValue: String): iControllerSag;
      function TELCONTATO(aValue: String): iControllerSag;
      function NOMECONTATO(aValue: String): iControllerSag;
      function MAILCONTATO(aValue: String): iControllerSag;
      function NOMEARQUIVO(aValue: String): iControllerSag;
      function LOG(aValue: TAndamento): iControllerSag;
      function GERARSAG: iControllerSag;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerSag }

constructor Tcontrollersag.Create;
begin
  FEntidade := TModelFactory.New.Sag;
end;

destructor Tcontrollersag.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollersag.New: Icontrollersag;
begin
  Result := Self.Create;
end;

function Tcontrollersag.Cnpjadm(Avalue: String): Icontrollersag;
begin
  Result := Self;
  FEntidade.CNPJADM(Avalue);
end;

function Tcontrollersag.Database(Avalue: Tdatetime): Icontrollersag;
begin
  Result := Self;
  FEntidade.DATABASE(Avalue);
end;

function Tcontrollersag.Remessa(Avalue: String): Icontrollersag;
begin
  Result := Self;
  FEntidade.REMESSA(Avalue);
end;

function Tcontrollersag.Telcontato(Avalue: String): Icontrollersag;
begin
  Result := Self;
  FEntidade.TELCONTATO(Avalue);
end;

function Tcontrollersag.Nomecontato(Avalue: String): Icontrollersag;
begin
  Result := Self;
  FEntidade.NOMECONTATO(Avalue);
end;

function Tcontrollersag.Mailcontato(Avalue: String): Icontrollersag;
begin
  Result := Self;
  FEntidade.MAILCONTATO(Avalue);
end;

function Tcontrollersag.Nomearquivo(Avalue: String): Icontrollersag;
begin
  Result := Self;
  FEntidade.NOMEARQUIVO(Avalue);
end;

function Tcontrollersag.Log(Avalue: Tandamento): Icontrollersag;
begin
  Result := Self;
  FEntidade.LOG(Avalue);
end;

function Tcontrollersag.Gerarsag: Icontrollersag;
begin
  Result := Self;
  FEntidade.GERARSAG;
end;

end.

