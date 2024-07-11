unit cobcons.model.bufferdataset;

{$mode delphi}

interface

uses
  Classes, Sysutils, Controls, DateUtils,
  BufDataset, cobcons.model.sql.interfaces, db;

type

   iModelBufferDataset = interface;

   iModelBufferDatasetCampo = interface
     ['{B385A815-251D-4299-8B34-0ECF0C051B72}']
     function NOME(aValue: String): iModelBufferDatasetCampo;
     function TIPO(aValue: TFieldType): iModelBufferDatasetCampo;
     function TAMANHO(aValue: Integer): iModelBufferDatasetCampo;
     function AdicionarCampo: iModelBufferDataset;
   end;

   { iModelBufferDataset }

   iModelBufferDataset = interface
     ['{C05CA6DE-8575-4DA7-8E49-262553864F40}']
     function NovoCampo: iModelBufferDatasetCampo;
     function CriarDataset: iModelBufferDataset;
     function NovoRegistro: iModelBufferDataset;
     function AlteraRegistro: iModelBufferDataset;
     function GravarRegistro: iModelBufferDataset;
     function Pesquisa(pCampos: String; pValores: Variant): Boolean;
     function Formatacampo(Pnome, Ptitulo: String; Ptamanho: Integer; Palinhamento: Talignment; Pmascara: String =
       ''; pVisivel: Boolean = True): Imodelbufferdataset;
     function OrdenarPorCampos(pCampos: String): iModelBufferDataset;
     function CAMPO(aValue: String): iModelBufferDataset;
     function VALOR(aValue: Variant): iModelBufferDataset;
     function AtribuirValor: iModelBufferDataset;
     function ApagarDados: iModelBufferDataset;
     function DataSet: TDataSet;
     function TemDados: Boolean;
     function Proximo: Boolean;
     function PrimeiroRegistro: Boolean;
     function QtdeRegistros: Integer;
     function ApagarBufDataset: iModelBufferDataset;
   end;

   { TModelBufferDataset }

   TModelBufferDataset = class (TInterfacedObject, iModelBufferDataset, iModelBufferDatasetCampo)
     private
       FNomeCampo: String;
       FTamanhoCampo: Integer;
       FTipoCampo: TFieldType;
       FTempDataset: TBufDataset;
       FValorCampo: variant;

       //function RetornarSQL(pTipo: Integer): string;

     public
       constructor Create;
       destructor Destroy; override;
       class function New: iModelBufferDataset;

       function NovoCampo: iModelBufferDatasetCampo;
       function NOME(aValue: String): iModelBufferDatasetCampo;
       function TIPO(aValue: TFieldType): iModelBufferDatasetCampo;
       function TAMANHO(aValue: Integer): iModelBufferDatasetCampo;
       function AdicionarCampo: iModelBufferDataset;
       function CriarDataset: iModelBufferDataset;
       function NovoRegistro: iModelBufferDataset;
       function AlteraRegistro: iModelBufferDataset;
       function GravarRegistro: iModelBufferDataset;
       function Pesquisa(pCampos: String; pValores: Variant): Boolean;
       function Formatacampo(Pnome, Ptitulo: String; Ptamanho: Integer; Palinhamento: Talignment; Pmascara: String =
         ''; pVisivel: Boolean = True): Imodelbufferdataset;
       function OrdenarPorCampos(pCampos: String): iModelBufferDataset;
       function CAMPO(aValue: String): iModelBufferDataset;
       function VALOR(aValue: Variant): iModelBufferDataset;
       function AtribuirValor: iModelBufferDataset;
       function ApagarDados: iModelBufferDataset;
       function DataSet: TDataSet;
       function TemDados: Boolean;
       function Proximo: Boolean;
       function PrimeiroRegistro: Boolean;
       function QtdeRegistros: Integer;
       function ApagarBufDataset: iModelBufferDataset;
   end;


implementation

uses cobcons.controller.util, cobcons.controller.factory,
  cobcons.model.sql.factory;

{ TModelBufferDataset }

//function TmodelBufferDataset.Retornarsql(Ptipo: Integer): String;
//var
//  vSql: String;
//begin
  //FormatSettings.DecimalSeparator := '.';
  //case Ptipo of
  //  1: vSql := Format(SQL_GRUPO_COTA,
  //        [ QuotedStr(FFantasia),
  //          QuotedStr(RetornaSemFormatacao(FCgc)),
  //          FPcMulta,
  //          FPcJuros,
  //          FPcHonorarios,
  //          QuotedStr(RetornaDataSql(FUltSag)),
  //          QuotedStr(FNmContato),
  //          QuotedStr(FTelContato),
  //          QuotedStr(FMailContato)]);
  //end;
  //FormatSettings.DecimalSeparator := ',';
//  Result := vSql;
//end;

constructor TModelBufferDataset.Create;
begin
  FTempDataset := TBufDataset.Create(nil);
end;

destructor TModelBufferDataset.Destroy;
begin
  FTempDataset.Free;
  inherited Destroy;
end;

class function TModelBufferDataset.New: iModelBufferDataset;
begin
  Result := Self.Create;
end;

function TModelBufferDataset.NovoCampo: iModelBufferDatasetCampo;
begin
  Result := Self;
end;

function TModelBufferDataset.NOME(aValue: String): iModelBufferDatasetCampo;
begin
  FNomeCampo := Avalue;
  Result := Self;
end;

function TModelBufferDataset.TIPO(aValue: TFieldType): iModelBufferDatasetCampo;
begin
  FTipoCampo := Avalue;
  Result := Self;
end;

function TModelBufferDataset.TAMANHO(aValue: Integer): iModelBufferDatasetCampo;
begin
  FTamanhoCampo := Avalue;
  Result := Self;
end;

function TModelBufferDataset.AdicionarCampo: iModelBufferDataset;
begin
  case FTipoCampo of
    ftString: FTempDataset.FieldDefs.Add(FNomeCampo, FTipoCampo, FTamanhoCampo);
    else FTempDataset.FieldDefs.Add(FNomeCampo, FTipoCampo);
  end;

  Result := Self;
end;

function TModelBufferDataset.CriarDataset: iModelBufferDataset;
begin
  Result := Self;
  FTempDataset.CreateDataset;
end;

function TModelBufferDataset.NovoRegistro: iModelBufferDataset;
begin
  Result := Self;
  FTempDataset.Append;
end;

function TModelBufferDataset.AlteraRegistro: iModelBufferDataset;
begin
  Result := Self;
  FTempDataset.Edit;
end;

function TModelBufferDataset.GravarRegistro: iModelBufferDataset;
begin
  Result := Self;
  FTempDataset.Post;
end;

function TModelBufferDataset.Pesquisa(pCampos: String; pValores: Variant
  ): Boolean;
begin
  Result := FTempDataset.Locate(Pcampos, Pvalores, [loCaseInsensitive]);
end;

function TModelBufferDataset.Formatacampo(Pnome, Ptitulo: String;
  Ptamanho: Integer; Palinhamento: Talignment; Pmascara: String;
  pVisivel: Boolean): Imodelbufferdataset;
var
  vCampo: TField;
begin
  vCampo := FTempDataset.FindField(Pnome);
  if vCampo <> nil
  then begin
    case vCampo.DataType of
      ftDateTime: FormataCampoData(vCampo, Ptitulo, Ptamanho, Palinhamento, pMascara, Pvisivel);
      ftInteger, ftFloat: FormataCampoNumerico(vCampo, Ptitulo, Ptamanho, Palinhamento, pMascara, Pvisivel);
      ftString: FormataCampoTexto(vCampo, Ptitulo, Ptamanho, Palinhamento, Pvisivel);
    end;
  end;
  Result := Self;
end;

function TModelBufferDataset.OrdenarPorCampos(pCampos: String
  ): iModelBufferDataset;
begin
  Result := self;
  if FTempDataset.IndexFieldNames = pCampos
  then FTempDataset.IndexFieldNames := pCampos + ' DESC'
  else FTempDataset.IndexFieldNames := pCampos;
  FTempDataset.First;
end;

function TModelBufferDataset.CAMPO(aValue: String): iModelBufferDataset;
begin
  FNomeCampo := Avalue;
  Result := Self;
end;

function TModelBufferDataset.VALOR(aValue: Variant): iModelBufferDataset;
begin
  FValorCampo := Avalue;
  Result := Self;
end;

function TModelBufferDataset.AtribuirValor: iModelBufferDataset;
begin
  FTempDataset.FieldByName(FNomeCampo).Value := FValorCampo;
  Result := Self;
end;

function TModelBufferDataset.ApagarDados: iModelBufferDataset;
begin
  Result := Self;
  if FTempDataset.RecordCount > 0
  then begin
    FTempDataset.First;
    while not FTempDataset.EOF
    do FTempDataset.Delete;
  end;
end;

function TModelBufferDataset.DataSet: TDataSet;
begin
  Result := FTempDataset;
end;

function TModelBufferDataset.TemDados: Boolean;
begin
  Result := not FTempDataset.EOF;
end;

function TModelBufferDataset.Proximo: Boolean;
begin
  FTempDataset.Next;
  Result := not FTempDataset.EOF;
end;

function TModelBufferDataset.PrimeiroRegistro: Boolean;
begin
  FTempDataset.First;
  Result := not FTempDataset.EOF;
end;

function TModelBufferDataset.QtdeRegistros: Integer;
begin
  Result := FTempDataset.RecordCount;
end;

function TModelBufferDataset.ApagarBufDataset: iModelBufferDataset;
begin
  FTempDataset.Clear;
  Result := Self;
end;

end.



