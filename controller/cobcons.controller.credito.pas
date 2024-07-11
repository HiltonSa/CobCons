unit cobcons.controller.credito;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerCredito }

    TControllerCredito = class (TInterfacedObject, iControllerCredito)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelCredito;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerCredito;

      function RetornaCreditosCota(pGrupo, pCota: String): iControllerCredito;
      function RetornaUmCreditoCota(pGrupo, pCota, pCredito: String): iControllerCredito;
      function DataSet: TDataSet;
      function CREDITO: string;
      function TP_CRED: string;
      function DCTPCRED: string;
      function DT_I_COR: TDateTime;
      function LIM_CORR: TDateTime;
      function VAL_CRED: Double;
      function VAL_CORR: Double;
      function FORNEC: string;
      function NMFORNEC: string;
      function DT_N_FIS: TDateTime;
      function NR_N_FIS: string;
      function DT_PAGTO: TDateTime;
      function VAL_ENTR: Double;
      function COR_ENTR: Double;
      function OBSERV: string;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerCredito }

constructor Tcontrollercredito.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.Credito(fQuery);
end;

destructor Tcontrollercredito.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollercredito.New: Icontrollercredito;
begin
  Result := Self.Create;
end;

function Tcontrollercredito.Retornacreditoscota(Pgrupo, Pcota: String): Icontrollercredito;
begin
  Result := Self;
  FEntidade.RetornaCreditosCota(Pgrupo, Pcota);
end;

function Tcontrollercredito.Retornaumcreditocota(Pgrupo, Pcota, Pcredito: String): Icontrollercredito;
begin
  Result := Self;
  FEntidade.RetornaUmCreditoCota(Pgrupo, Pcota, Pcredito);
end;

function Tcontrollercredito.Dataset: Tdataset;
begin
  Result := FEntidade.Dataset;
end;

function Tcontrollercredito.Credito: String;
begin
  Result := FEntidade.CREDITO;
end;

function Tcontrollercredito.Tp_cred: String;
begin
  Result := FEntidade.TP_CRED;
end;

function Tcontrollercredito.Dctpcred: String;
begin
  Result := FEntidade.DCTPCRED;
end;

function Tcontrollercredito.Dt_i_cor: Tdatetime;
begin
  Result := FEntidade.DT_I_COR;
end;

function Tcontrollercredito.Lim_corr: Tdatetime;
begin
  Result := FEntidade.LIM_CORR;
end;

function Tcontrollercredito.Val_cred: Double;
begin
  Result := FEntidade.VAL_CRED;
end;

function Tcontrollercredito.Val_corr: Double;
begin
  Result := FEntidade.VAL_CORR;
end;

function Tcontrollercredito.Fornec: String;
begin
  Result := FEntidade.FORNEC;
end;

function Tcontrollercredito.Nmfornec: String;
begin
  Result := FEntidade.NMFORNEC;
end;

function Tcontrollercredito.Dt_n_fis: Tdatetime;
begin
  Result := FEntidade.DT_N_FIS;
end;

function Tcontrollercredito.Nr_n_fis: String;
begin
  Result := FEntidade.NR_N_FIS;
end;

function Tcontrollercredito.Dt_pagto: Tdatetime;
begin
  Result := FEntidade.DT_PAGTO;
end;

function Tcontrollercredito.Val_entr: Double;
begin
  Result := FEntidade.VAL_ENTR;
end;

function Tcontrollercredito.Cor_entr: Double;
begin
  Result := FEntidade.COR_ENTR;
end;

function Tcontrollercredito.Observ: String;
begin
  Result := FEntidade.OBSERV;
end;

end.


