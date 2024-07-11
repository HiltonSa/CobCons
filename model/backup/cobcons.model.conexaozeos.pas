unit cobcons.model.conexaozeos;

{$mode delphi}

interface

uses
  Classes, Sysutils, IniFiles, ZConnection,ZDbcIntfs, ZCompatibility,
  Forms, cobcons.model.interfaces{, ZAbstractConnection};

type

  { TConexaoZeos }

  TConexaoZeos = class (TInterfacedObject, iModelConexao)
    private
      FConexao: TZConnection;
    public
      constructor Create(pBanco: Integer);
      destructor Destroy; override;
      class function New(pBanco: Integer = 0): iModelConexao;
      function Conectar: TObject;
  end;


implementation

uses cobcons.controller.util;


{ TConexaoZeos }

constructor TConexaoZeos.Create(pBanco: Integer);
var
  arqIni: TIniFile;
  arqNome: string;
begin
  arqNome := ExtractFilePath(Application.ExeName)+'CobCons.ini';
  FConexao := TZConnection.Create(nil);
  if FileExists(arqNome) then begin

    FConexao.Connected := False;
    FConexao.AutoEncodeStrings := True;
    FConexao.ControlsCodePage := cCP_UTF8;
    FConexao.TransactIsolationLevel := tiReadCommitted;
    arqIni := TIniFile.Create(arqNome);
    try
       case pBanco of
         0: begin
               //FConexao.HostName := arqIni.ReadString('IBX','Servidor','localhost');
               FConexao.Database := arqIni.ReadString('IBX','BD','');
               FConexao.Port := arqIni.ReadInteger('IBX','Porta', 3050);
               FConexao.Protocol:=arqIni.ReadString('IBX','Protocolo','firebird-2.5');
               FConexao.User:=arqIni.ReadString('IBX','Resu','SYSDBA');
               FConexao.Password:=arqIni.ReadString('IBX','Ssap','masterkey');
         end;
         1: begin
               //FConexao.HostName := arqIni.ReadString('SAG','Servidor','localhost');
               FConexao.Database := arqIni.ReadString('SAG','BD','');
               FConexao.Port := arqIni.ReadInteger('SAG','Porta', 3050);
               FConexao.Protocol:=arqIni.ReadString('SAG','Protocolo','firebird-2.5');
               FConexao.User:=arqIni.ReadString('SAG','Resu','SYSDBA');
               FConexao.Password:=arqIni.ReadString('SAG','Ssap','masterkey');
         end ;
         2: begin
               FConexao.HostName := arqIni.ReadString('VDCON','Servidor','localhost');
               FConexao.Database := arqIni.ReadString('VDCON','BD','');
               FConexao.Port := arqIni.ReadInteger('VDCON','Porta', 3050);
               FConexao.Protocol:=arqIni.ReadString('VDCON','Protocolo','firebird-2.5');
               FConexao.User:=arqIni.ReadString('VDCON','Resu','SYSDBA');
               FConexao.Password:=arqIni.ReadString('VDCON','Ssap','masterkey');
         end;
       end;

    finally
      arqIni.Free;
    end;

    try
       FConexao.Connect;
    except
         raise Exception.Create(Format('Sem conexão com o banco de dados (%s)!',[FConexao.Database]));
         Application.Terminate;
    end;
  end
  else begin
      raise Exception.Create('Configurador não encontrado!');
      Application.Terminate;
  end;

end;

destructor TConexaoZeos.Destroy;
begin
  FreeAndNil(FConexao);
  inherited Destroy;
end;

class function TConexaoZeos.New(pBanco: Integer): iModelConexao;
begin
  Result := Self.Create(pBanco);
end;

function TConexaoZeos.Conectar: TObject;
begin
  Result := FConexao;
end;

end.


