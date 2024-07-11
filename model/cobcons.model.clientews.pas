unit cobcons.model.clientews;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.interfaces, uDWConstsData,
  uDWResponseTranslator, IdSSLOpenSSL, uDWConstsCharset;

type

  { TClienteWS }

  TClienteWS = class (TInterfacedObject, iClienteWebService)
    private
      FConexao: TDWClientREST;
      FResultado: TStringStream;
      FUrl: string;
    public
      constructor create;
      destructor Destroy; override;
      class function New: iClienteWebService;

      function UsarSSL(aValue: Boolean): iClienteWebService;
      function Url(aValue: String): iClienteWebService;
      function Acessar: TStringStream;
  end;

implementation

{ TClienteWS }

constructor Tclientews.Create;
begin
  FResultado := TStringStream.Create('');
  FConexao := TDWClientREST.Create(nil);
  FConexao.UseSSL := True;
  FConexao.SSLVersions := [sslvTLSv1_2];
  FConexao.UserAgent := 'Mozilla/3.0 (compatible; Indy Library)';
  FConexao.Accept := 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
  FConexao.ContentEncoding := 'multipart/form-data';
  FConexao.MaxAuthRetries := 0;
  FConexao.ContentType := 'application/json';
  FConexao.RequestCharset := esUtf8;
  FConexao.ProxyOptions.BasicAuthentication := False;
  FConexao.ProxyOptions.ProxyPort := 0;
  FConexao.RequestTimeOut := 1000;
  FConexao.AllowCookies := False;
  FConexao.HandleRedirects := False;
  FConexao.RedirectMaximum := 1;
  FConexao.VerifyCert := False;
  //FConexao.AuthOptions.HasAuthentication := False;
  FConexao.AccessControlAllowOrigin := '*';
end;

destructor Tclientews.Destroy;
begin
  //FConexao.Free;
  //FResultado.Free;
  inherited Destroy;
end;

class function Tclientews.New: Iclientewebservice;
begin
  Result := Self.create;
end;

function Tclientews.Usarssl(Avalue: Boolean): Iclientewebservice;
begin
  FConexao.UseSSL := Avalue;
  Result := Self;
end;

function Tclientews.Url(Avalue: String): Iclientewebservice;
begin
  FUrl := Avalue;
  Result := Self;
end;

function Tclientews.Acessar: Tstringstream;
begin
  FConexao.Get(FUrl, nil, FResultado, True);
  Result := FResultado;
end;

end.


