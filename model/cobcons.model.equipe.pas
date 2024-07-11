unit cobcons.model.equipe;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, cobcons.model.interfaces;
type

  { TModelEquipe }

  TModelEquipe = class(TInterfacedObject, iModelEquipe)
    private
      FQuery: iQueryRest;
      FLista: TStringList;

      FCodigo: Integer;
      FDescricao: String;
      FFilial: Integer;
      FSupervisor: Integer;

      procedure AtualizarCampos;

    public
      constructor Create(aQuery: iQueryRest);
      destructor Destroy; override;
      class function New(aQuery: iQueryRest): iModelEquipe;

      function ListaPorCodigo(pCodigo: Integer): TDataSet;
      function ListaPorNome(pNome: String): TDataSet;
      function ListaComboBox(pFilial: Integer=0): TStringList;
      function Executar(pModo: TpModoManutencao): iModelEquipe;
      function CODIGO: Integer; overload;
      function CODIGO(pValor: Integer): iModelEquipe; overload;
      function DESCRICAO: String; overload;
      function DESCRICAO(pValor: String): iModelEquipe; overload;
      function FILIAL: Integer; overload;
      function FILIAL(pValor: Integer): iModelEquipe; overload;
      function SUPERVISOR: Integer; overload;
      function SUPERVISOR(pValor: Integer): iModelEquipe; overload;

  end;

implementation

uses cobcons.controller.util, cobcons.model.storedprocedure;

{ TModelEquipe }

procedure TModelEquipe.AtualizarCampos;
begin
  if not FQuery.Dataset.EOF
  then begin
    FCodigo     := FQuery.FieldByName('codigo').AsInteger;
    FDescricao  := FQuery.FieldByName('descricao').AsString;
    FFilial     := FQuery.FieldByName('filial').AsInteger;
    FSupervisor := FQuery.FieldByName('supervisor').AsInteger;
  end;
end;

constructor TModelEquipe.Create(aQuery: iQueryRest);
begin
  FQuery := aQuery;
  FLista := TStringList.Create;
end;

destructor TModelEquipe.Destroy;
begin
  FLista.Free;
  inherited Destroy;
end;

class function TModelEquipe.New(aQuery: iQueryRest): iModelEquipe;
begin
  Result := Self.Create(aQuery);
end;

function TModelEquipe.ListaPorCodigo(pCodigo: Integer): TDataSet;
const
  vSql = 'SELECT * FROM equipes WHERE codigo = %d';
begin
  FQuery.Open(Format(vSql,[ pCodigo]));
  AtualizarCampos;
  Result := FQuery.Dataset;
end;

function TModelEquipe.ListaPorNome(pNome: String): TDataSet;
const
  vSql = 'SELECT * FROM equipes WHERE descricao LIKE %s ORDER BY descricao';
begin
  FQuery.Open(Format(vSql,[ QuotedStr(pNome+'%') ]));
  Result := FQuery.Dataset;
end;

function TModelEquipe.ListaComboBox(pFilial: Integer): TStringList;
var
  pDataset: TDataSet;
  vSql: String;
begin
  vSql := 'SELECT descricao, codigo FROM equipes '; ;
  if pFilial > 0
  then vSql := Format('%s WHERE filial = %d ',[ vSql, pFilial]);
  vSql := Format('%s ORDER BY descricao',[vSql]);
  FLista.Clear;
  pDataset := FQuery.Open(vSql).Dataset;
  while not pDataset.EOF do
  begin
    FLista.Add(Format('%s|%d',[ pDataset.FieldByName('descricao').AsString,
                                pDataset.FieldByName('codigo').AsInteger]));
    pDataset.Next;
  end;
  Result := FLista;
end;

function TModelEquipe.Executar(pModo: TpModoManutencao): iModelEquipe;
//const
//  SQL = 'CALL manter_equipes ( %s, %d, %d, %d, %d )';
var
  //vSql: String;
  vSp: iModelStoredProcedure;
begin
  vSp := TModelStoredProcedure.New;
  vSp.NOME('MANTER_EQUIPES');
  vSp.PARAMETRO('pDESCRICAO').VALOR(FDescricao ).AtribuirValor;
  vSp.PARAMETRO('pFIL'      ).VALOR(FFilial    ).AtribuirValor;
  vSp.PARAMETRO('pSUPER'    ).VALOR(FSupervisor).AtribuirValor;
  vSp.PARAMETRO('pCOD'      ).VALOR(FCodigo    ).AtribuirValor;
  vSp.PARAMETRO('pMODO'     ).VALOR(Ord(pModo) ).AtribuirValor;
  vSp.Executar;
  //FormatSettings.DecimalSeparator := '.';
  //vSql := Format(SQL,[ QuotedStr(FDescricao),
  //                     FFilial,
  //                     FSupervisor,
  //                     FCodigo,
  //                     Ord(pModo) ]);
  //FormatSettings.DecimalSeparator := ',';
  //FQuery.Executar(vSql);
  Result := Self;
end;

function TModelEquipe.CODIGO: Integer;
begin
  Result := FCodigo;
end;

function TModelEquipe.CODIGO(pValor: Integer): iModelEquipe;
begin
  Result := Self;
  FCodigo := pValor;
end;

function TModelEquipe.DESCRICAO: String;
begin
  Result := FDescricao;
end;

function TModelEquipe.DESCRICAO(pValor: String): iModelEquipe;
begin
  Result := Self;
  FDescricao := pValor;
end;

function TModelEquipe.FILIAL: Integer;
begin
  Result := FFilial;
end;

function TModelEquipe.FILIAL(pValor: Integer): iModelEquipe;
begin
  Result := Self;
  FFilial := pValor;
end;

function TModelEquipe.SUPERVISOR: Integer;
begin
  Result := FSupervisor;
end;

function TModelEquipe.SUPERVISOR(pValor: Integer): iModelEquipe;
begin
  Result := Self;
  FSupervisor := pValor;
end;

end.

