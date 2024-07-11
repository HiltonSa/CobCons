unit cobcons.model.sql.fbcotacaomoeda;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlFbCotacaoMoeda }

  TModelSQlFbCotacaoMoeda = class (TInterfacedObject, iModelSqlCotacaoMoeda)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iModelSqlCotacaoMoeda;

      function SqlCotacao(pMoeda: string; pData: TDateTime): string;
      function SqlUltimaCotacao(pMoeda: string): String;
      function SqlListar(pMoeda: string; pData: TDateTime): string;
      function SqlNovaCotacao(pMoeda: string; pData: TDateTime; pCotacao: Double): string;
      function SqlListarCombobox: string;
  end;

implementation

uses cobcons.controller.util;

{ TModelSQlFbCotacaoMoeda }
const
  SQL_LISTAR_COMBOBOX =
    'select DESCRIC, CODIGO from ACTAB where TABELA = ''018'' order by DESCRIC';
  SQL_ULTIMA_COTACAO =
    'select first 1 MOEDA, DATA, COTACAO from ACCMO where MOEDA = %s order by DATA desc';
  SQL_INCLUIR_COTACAO =
    'insert into ACCMO (MOEDA, DATA, COTACAO) values (%s, %s, %.14f)';
  SQL_LISTAR =
    'select MOEDA, DATA, COTACAO from ACCMO where MOEDA = %s and DATA >= %s order by DATA';
  SQL_COTACAO =
    'select first 1 COTACAO from ACCMO '+
    'where MOEDA = %s and DATA <= %s '+
    'order by DATA desc';

constructor Tmodelsqlfbcotacaomoeda.Create;
begin

end;

destructor Tmodelsqlfbcotacaomoeda.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqlfbcotacaomoeda.New: Imodelsqlcotacaomoeda;
begin
  Result := Self.Create;
end;

function Tmodelsqlfbcotacaomoeda.Sqlcotacao(Pmoeda: String; Pdata: Tdatetime): String;
begin
  Result := Format( SQL_COTACAO, [ QuotedStr(Pmoeda), QuotedStr(RetornaDataSql(Pdata))]);
end;

function Tmodelsqlfbcotacaomoeda.Sqlultimacotacao(Pmoeda: String): String;
begin
  Result := Format( SQL_ULTIMA_COTACAO, [ QuotedStr(Pmoeda) ]);
end;

function Tmodelsqlfbcotacaomoeda.Sqllistar(Pmoeda: String; Pdata: Tdatetime): String;
begin
  Result := Format( SQL_LISTAR, [ QuotedStr(Pmoeda), QuotedStr(RetornaDataSql(Pdata))]);
end;

function Tmodelsqlfbcotacaomoeda.Sqlnovacotacao(Pmoeda: String; Pdata: Tdatetime; Pcotacao: Double): String;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  vSql := Format( SQL_INCLUIR_COTACAO, [ QuotedStr(Pmoeda), QuotedStr(RetornaDataSql(Pdata)), Pcotacao]);
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

function Tmodelsqlfbcotacaomoeda.Sqllistarcombobox: String;
begin
  Result := SQL_LISTAR_COMBOBOX;
end;

end.

