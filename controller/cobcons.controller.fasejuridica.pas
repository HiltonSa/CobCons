unit cobcons.controller.fasejuridica;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.controller.interfaces, cobcons.model.interfaces, db;

type

    { TControllerFaseJuridica }

    TControllerFaseJuridica= class (TInterfacedObject, iControllerFaseJuridica)
    private
      FConexao: iModelConexao;
      fQuery : iQueryRest;
      FEntidade: iModelFaseJuridica;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerFaseJuridica;

      function RetornaFasesCota(pGrupo, pSeq, pCota: String): iControllerFaseJuridica;
      function RetornaUmaFaseCota(pGrupo, pSeq, pCota, pFase: String): iControllerFaseJuridica;
      function DataSet: TDataSet;
      function GRUPO: string;
      function SEQ: string;
      function COTA: string;
      function F_JURID: string;
      function NOME: string;
      function DCFASE: string;
      function D_INICIO: TDateTime;
      function NMREPRES: string;
      function CUST_MOE: double;
      function OBSERV: String;
  end;


implementation

uses cobcons.controller.factory, cobcons.model.factory;

{ TControllerFaseJuridica }

constructor Tcontrollerfasejuridica.Create;
begin
  FConexao := TControllerFactory.New.Conexao;
  fQuery := TControllerFactory.New.Query(FConexao);
  FEntidade := TModelFactory.New.FaseJuridica(fQuery);
end;

destructor Tcontrollerfasejuridica.Destroy;
begin
  inherited Destroy;
end;

class function Tcontrollerfasejuridica.New: Icontrollerfasejuridica;
begin
  Result := Self.Create;
end;

function Tcontrollerfasejuridica.Retornafasescota(Pgrupo, Pseq, Pcota: String): Icontrollerfasejuridica;
begin
  Result := Self;
  FEntidade.RetornaFasesCota(Pgrupo, Pseq, Pcota);
end;

function Tcontrollerfasejuridica.Retornaumafasecota(Pgrupo, Pseq, Pcota, Pfase: String): Icontrollerfasejuridica;
begin
  Result := Self;
  FEntidade.RetornaUmaFaseCota(Pgrupo, Pseq, Pcota, Pfase);
end;

function Tcontrollerfasejuridica.Dataset: Tdataset;
begin
  Result := FEntidade.DataSet;
end;

function Tcontrollerfasejuridica.Grupo: String;
begin
  Result := FEntidade.GRUPO;
end;

function Tcontrollerfasejuridica.Seq: String;
begin
  Result := FEntidade.SEQ;
end;

function Tcontrollerfasejuridica.Cota: String;
begin
  Result := FEntidade.COTA;
end;

function Tcontrollerfasejuridica.F_jurid: String;
begin
  Result := FEntidade.F_JURID;
end;

function Tcontrollerfasejuridica.Nome: String;
begin
  Result := FEntidade.NOME;
end;

function Tcontrollerfasejuridica.Dcfase: String;
begin
  Result := FEntidade.DCFASE;
end;

function Tcontrollerfasejuridica.D_inicio: Tdatetime;
begin
  Result := FEntidade.D_INICIO;
end;

function Tcontrollerfasejuridica.Nmrepres: String;
begin
  Result := FEntidade.NMREPRES;
end;

function Tcontrollerfasejuridica.Cust_moe: Double;
begin
  Result := FEntidade.CUST_MOE;
end;

function Tcontrollerfasejuridica.Observ: String;
begin
  Result := FEntidade.OBSERV;
end;

end.


