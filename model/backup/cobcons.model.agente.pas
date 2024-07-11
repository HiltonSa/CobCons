unit cobcons.model.agente;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, cobcons.model.interfaces;
type

  { TModelAgente }

  TModelAgente = class(TInterfacedObject, iModelAgente)
    private
      FQuery: iQueryRest;
      FLista: TStringList;

      FCodigo    : Integer;
      FNome      : String;
      FCpf       : String;
      FDDD       : String;
      FCelular   : String;
      FEquipe    : Integer;
      FSupervisao: Integer;
      FAtivo     : Integer;
      FCdExterno : String;
      FDcAtivo   : String;
      FDcFil     : String;
      FDcEqp     : String;

      procedure AtualizarCampos;
      function MontarLista(pDataset: TDataSet): TStringList;

    public
      constructor Create(aQuery: iQueryRest);
      destructor Destroy; override;
      class function New(aQuery: iQueryRest): iModelAgente;

      function ListaPorCodigo(pCodigo: Integer): TDataSet;
      function ListaPorNome(pNome: String): TDataSet;
      function ListaComboBox(pEquipe: Integer = 0): TStringList;
      function ListaSupervisoresAtivosComboBox(pNivel: Integer): TStringList;
      function Executar(pModo: TpModoManutencao): iModelAgente;
      function CODIGO: Integer; overload;
      function CODIGO(pValor: Integer): iModelAgente; overload;
      function NOME: String; overload;
      function NOME(pValor: String): iModelAgente; overload;
      function CPF: String; overload;
      function CPF(pValor: String): iModelAgente; overload;
      function DDD: String; overload;
      function DDD(pValor: String): iModelAgente; overload;
      function CELULAR: String; overload;
      function CELULAR(pValor: String): iModelAgente; overload;
      function EQUIPE: Integer; overload;
      function EQUIPE(pValor: Integer): iModelAgente; overload;
      function SUPERVISAO: Integer; overload;
      function SUPERVISAO(pValor: Integer): iModelAgente; overload;
      function ATIVO: Integer; overload;
      function ATIVO(pValor: Integer): iModelAgente; overload;
      function CDEXTERNO: String; overload;
      function CDEXTERNO(pValor: String): iModelAgente; overload;
      function DCATIVO: String;
      function DCFIL: String;
      function DCEQP: String;

  end;

implementation

uses cobcons.controller.util;

{ TModelAgente }
const
  SQL_CAMPOS =
    'select A.CODIGO, A.NOME, A.CPF, A.DDD, A.CELULAR '+
    '      ,A.EQUIPE, E.DESCRICAO DCEQP, A.SUPERVISAO '+
    '      ,A.ATIVO, A.CDEXTERNO, F.DESCRICAO DCFIL   '+
    '      ,case A.ATIVO                              '+
    '        when 0 then ''Inativo''                  '+
    '        when 1 then ''Ativo''                    '+
    '      end as DCATIVO                             '+
    'from AGENTES A                                   '+
    'inner join EQUIPES E on E.CODIGO = A.EQUIPE      '+
    'inner join FILIAIS F on F.CODIGO = E.FILIAL      ';


procedure TModelAgente.AtualizarCampos;
begin
  if not FQuery.Dataset.EOF
  then begin
    FCodigo    := FQuery.FieldByName('CODIGO'    ).AsInteger;
    FNome      := FQuery.FieldByName('NOME'      ).AsString;
    FCpf       := FQuery.FieldByName('CPF'       ).AsString;
    FDDD       := FQuery.FieldByName('DDD'       ).AsString;
    FCelular   := FQuery.FieldByName('CELULAR'   ).AsString;
    FEquipe    := FQuery.FieldByName('EQUIPE'    ).AsInteger;
    FSupervisao:= FQuery.FieldByName('SUPERVISAO').AsInteger;
    FAtivo     := FQuery.FieldByName('ATIVO'     ).AsInteger;
    FCdExterno := FQuery.FieldByName('CDEXTERNO' ).AsString;
    FDcAtivo   := FQuery.FieldByName('DCATIVO'   ).AsString;
    FDcFil     := FQuery.FieldByName('DCFIL'     ).AsString;
    FDcEqp     := FQuery.FieldByName('DCEQP'     ).AsString;
  end;
end;

function TModelAgente.MontarLista(pDataset: TDataSet): TStringList;
begin
  FLista.Clear;
  pDataset.First;
  while not pDataset.EOF do
  begin
    FLista.Add(Format('%s|%d',[ pDataset.FieldByName('NOME').AsString,
                                pDataset.FieldByName('CODIGO').AsInteger]));
    pDataset.Next;
  end;
  Result := FLista;
end;

constructor TModelAgente.Create(aQuery: iQueryRest);
begin
  FQuery := aQuery;
  FLista := TStringList.Create;
end;

destructor TModelAgente.Destroy;
begin
  FLista.Free;
  inherited Destroy;
end;

class function TModelAgente.New(aQuery: iQueryRest): iModelAgente;
begin
  Result := Self.Create(aQuery);
end;

function TModelAgente.ListaPorCodigo(pCodigo: Integer): TDataSet;
const
  vSql = SQL_CAMPOS +' WHERE A.codigo = %d';
begin
  FQuery.Open(Format(vSql,[ pCodigo]));
  AtualizarCampos;
  Result := FQuery.Dataset;
end;

function TModelAgente.ListaPorNome(pNome: String): TDataSet;
const
  SQL = SQL_CAMPOS + ' WHERE A.nome LIKE %s ORDER BY A.nome';
var
  vSql: String;
begin
  vSql := Format(SQL,[ QuotedStr(pNome+'%')]);
  Result := FQuery.Open(vSql).Dataset;
end;

function TModelAgente.ListaComboBox(pEquipe: Integer): TStringList;
const
  SQL_COMBO_BOX = 'SELECT nome, codigo FROM agentes ORDER BY nome';
var
  vSql: String;
begin
  vSql := 'SELECT nome, codigo FROM agentes';
  if pEquipe > 0
  then vSql := Format('%s WHERE equipe = %d',[vSql, pEquipe]);
  vSql := Format('%s ORDER BY nome',[vSql]);
  Result := MontarLista(FQuery.Open(vSql).Dataset);
end;

function TModelAgente.ListaSupervisoresAtivosComboBox(pNivel: Integer
  ): TStringList;
const
  SQL_COMBO_BOX =
    'SELECT nome, codigo FROM agentes WHERE supervisao = %d AND ativo = 1 ORDER BY nome';
begin
  Result := MontarLista(FQuery.Open(Format(SQL_COMBO_BOX, [ pNivel ])).Dataset);
end;

function TModelAgente.Executar(pModo: TpModoManutencao): iModelAgente;
const
  SQL = 'CALL manter_agentes( %s, %s, %s, %s, %d, %d, %s, %d, %d, %d )';
var
  vSql: String;
begin
  FormatSettings.DecimalSeparator := '.';
  vSql := Format(SQL,[ QuotedStr(FNome),
                       QuotedStr(FCpf),
                       QuotedStr(FDDD),
                       QuotedStr(FCelular),
                       FEquipe,
                       FSupervisao,
                       QuotedStr(FCdExterno),
                       FCodigo,
                       FAtivo,
                       Ord(pModo) ]);
  FormatSettings.DecimalSeparator := ',';
  FQuery.Executar(vSql);
  Result := Self;
end;

function TModelAgente.CODIGO: Integer;
begin
  Result := FCodigo;
end;

function TModelAgente.CODIGO(pValor: Integer): iModelAgente;
begin
  Result := Self;
  FCodigo := pValor;
end;

function TModelAgente.NOME: String;
begin
  Result := FNome;
end;

function TModelAgente.NOME(pValor: String): iModelAgente;
begin
  Result := Self;
  FNome := pValor;
end;

function TModelAgente.CPF: String;
begin
  Result := FCpf;
end;

function TModelAgente.CPF(pValor: String): iModelAgente;
begin
  Result := Self;
  FCpf := pValor;
end;

function TModelAgente.DDD: String;
begin
  Result := FDDD;
end;

function TModelAgente.DDD(pValor: String): iModelAgente;
begin
  Result := Self;
  FDDD := pValor;
end;

function TModelAgente.CELULAR: String;
begin
  Result := FCelular;
end;

function TModelAgente.CELULAR(pValor: String): iModelAgente;
begin
  Result := Self;
  FCelular := pValor;
end;

function TModelAgente.EQUIPE: Integer;
begin
  Result := FEquipe;
end;

function TModelAgente.EQUIPE(pValor: Integer): iModelAgente;
begin
  Result := Self;
  FEquipe := pValor;
end;

function TModelAgente.SUPERVISAO: Integer;
begin
  Result := FSupervisao;
end;

function TModelAgente.SUPERVISAO(pValor: Integer): iModelAgente;
begin
  Result := Self;
  FSupervisao := pValor;
end;

function TModelAgente.ATIVO: Integer;
begin
  Result := FAtivo;
end;

function TModelAgente.ATIVO(pValor: Integer): iModelAgente;
begin
  Result := Self;
  FAtivo := pValor;
end;

function TModelAgente.CDEXTERNO: String;
begin
  Result := FCdExterno;
end;

function TModelAgente.CDEXTERNO(pValor: String): iModelAgente;
begin
  Result := Self;
  FCdExterno := pValor;
end;

function TModelAgente.DCATIVO: String;
begin
  Result := FDcAtivo;
end;

function TModelAgente.DCFIL: String;
begin
  Result := FDcFil;
end;

function TModelAgente.DCEQP: String;
begin
  Result := FDcEqp;
end;

end.

