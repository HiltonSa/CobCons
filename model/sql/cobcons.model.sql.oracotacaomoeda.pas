unit cobcons.model.sql.oracotacaomoeda;

{$mode delphi}

interface

uses
  Classes, Sysutils, cobcons.model.sql.interfaces;
type

  { TModelSQlOraCotacaoMoeda }

  TModelSQlOraCotacaoMoeda = class (TInterfacedObject, iModelSqlCotacaoMoeda)
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

{ TModelSQlOraCotacaoMoeda }
const
  SQL_LISTAR_COMBOBOX =
    'select DESCRIC, CODIGO from ACTAB where TABELA = ''018'' order by DESCRIC';
  SQL_ULTIMA_COTACAO =
    'select MOEDA, DATA, COTACAO from ACCMO where MOEDA = %s and rownum = 1 order by DATA desc';
  SQL_INCLUIR_COTACAO =
    'insert into ACCMO (MOEDA, DATA, COTACAO) values (%s, %s, %f)';
  SQL_LISTAR =
    'select MOEDA, DATA, COTACAO from ACCMO where MOEDA = %s and DATA >= %s order by DATA';
  SQL_COTACAO =
    'select COTACAO from ACCMO '+
    'where MOEDA = %s and DATA <= %s and rownum = 1 '+
    'order by DATA desc';

constructor Tmodelsqloracotacaomoeda.Create;
begin

end;

destructor Tmodelsqloracotacaomoeda.Destroy;
begin
  inherited Destroy;
end;

class function Tmodelsqloracotacaomoeda.New: Imodelsqlcotacaomoeda;
begin
  Result := Self.Create;
end;

function Tmodelsqloracotacaomoeda.Sqlcotacao(Pmoeda: String; Pdata: Tdatetime): String;
begin
  Result := Format( SQL_COTACAO, [ QuotedStr(Pmoeda), QuotedStr(RetornaDataSql(Pdata))]);
end;

function Tmodelsqloracotacaomoeda.Sqlultimacotacao(Pmoeda: String): String;
begin
  Result := Format( SQL_ULTIMA_COTACAO, [ QuotedStr(Pmoeda) ]);
end;

function Tmodelsqloracotacaomoeda.Sqllistar(Pmoeda: String; Pdata: Tdatetime): String;
begin
  Result := Format( SQL_LISTAR, [ QuotedStr(Pmoeda), QuotedStr(RetornaDataSql(Pdata))]);
end;

function Tmodelsqloracotacaomoeda.Sqlnovacotacao(Pmoeda: String; Pdata: Tdatetime; Pcotacao: Double): String;
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  vSql := Format( SQL_INCLUIR_COTACAO, [ QuotedStr(Pmoeda), QuotedStr(RetornaDataSql(Pdata)), Pcotacao]);
  FormatSettings.DecimalSeparator := ',';
  Result := vSql;
end;

function Tmodelsqloracotacaomoeda.Sqllistarcombobox: String;
begin
  Result := SQL_LISTAR_COMBOBOX;
end;

end.

