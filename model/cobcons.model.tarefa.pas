unit cobcons.model.tarefa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, cobcons.model.conexaozeos, cobcons.model.queryzeos, LCLIntf, LCLType,
  cobcons.model.interfaces, cobcons.controller.interfaces;
type

  TShowStatusEvent = procedure(pFim, pGrupo, pSeq, pCota, pNome: String; pEncct, pUltReu, pInaug: TDateTime; pValor: Currency) of Object;

  { TTarefaSaldoRnp }

  TTarefaSaldoRnp = class(TThread)
    private
      FDataLimite: TDatetime;
      FOnShowStatus: TShowStatusEvent;
      FSQL: String;
      FId: String;
      FLinhas: TStringList;
      procedure SetDataLimite(AValue: TDatetime);
      procedure SetSQL(AValue: String);
      procedure ShowStatus;
      procedure Log(pMsg: String);
    protected
      procedure Execute; override;
    public
      constructor Create(pId: String);
      destructor Destroy; override;
      property SQL: String read FSQL write SetSQL;
      property OnShowStatus: TShowStatusEvent read FOnShowStatus write FOnShowStatus;
      property DataLimite: TDatetime read FDataLimite write SetDataLimite;
  end;

implementation

uses cobcons.controller.factory;


{ TTarefaSaldoRnp }


procedure TTarefaSaldoRnp.SetSQL(AValue: String);
begin
  if FSQL = AValue then Exit;
  FSQL := AValue;
end;

procedure TTarefaSaldoRnp.ShowStatus;
begin
  //FOnShowStatus(FMsg,FGrupo, FSeq, FCota, FEncCon, FUltAss, FValor);
end;

procedure TTarefaSaldoRnp.Log(pMsg: String);
begin
  FLinhas.Add(Format('%s: %s',[FormatDateTime('hh:mm:ss', Now), pMsg]));
end;

procedure TTarefaSaldoRnp.SetDataLimite(AValue: TDatetime);
begin
  FDataLimite := AValue;
end;

procedure TTarefaSaldoRnp.Execute;
var
  vInicio: TDateTime;
  vConexao: iModelConexao;
  vQuery: iQueryRest;
  vGrupo, vSeq, vCota, vMsg, vNome: String;
  vValor: Currency;
  vEncCon, vUltAss, vInaug: TDateTime;
  vTabular: iControllerTabularEncerrados;
  //vCriticalSection: TCriticalSection;
begin
  //InitializeCriticalSection(vCriticalSection);
  vConexao := TControllerFactory.New.Conexao;
  vQuery := TControllerFactory.New.Query(vConexao);

  vTabular := TControllerFactory.New.TabularEncerrados;
  vTabular.DATALIMITE(FDataLimite);

  vInicio := Now;
  FLinhas.Clear;
  Log('Abrindo Sql');
  vQuery.Open(FSQL);
  Log(Format('Sql Aberto com %d Registros',[vQuery.NumeroRegistros]));
  vQuery.PrimeiroRegistro;
  repeat
    //EnterCriticalSection(vCriticalSection);
    try
      vGrupo  := vQuery.FieldByName('GRUPO').AsString;
      vSeq    := vQuery.FieldByName('SEQ').AsString;
      vCota   := vQuery.FieldByName('COTA').AsString;
      vNome   := vQuery.FieldByName('NOME').AsString;
      vEncCon := vQuery.FieldByName('DTENCCT').AsDateTime;
      vUltAss := vQuery.FieldByName('ULTREU').AsDateTime;
      vInaug  := vQuery.FieldByName('PRIM_REU').AsDateTime;
      vValor  := vTabular.CalcularSaldoRnpCota(vGrupo, vSeq, vCota, nil);
      vMsg    := Format('%s: Lendo %s %s-%s: %n',[FId, vGrupo, vSeq, vCota, vValor]);
      Log(vMsg);
    Except
      raise Exception.Create('Deu ruim Tarefa '+FId);
    //finally
    //  LeaveCriticalSection(vCriticalSection);
    end;
    if vValor > 0
    then begin
      FOnShowStatus(vMsg,vGrupo, vSeq, vCota, vNome, vEncCon, vUltAss, vInaug, vValor);
    //  //ShowStatus;
    end;
  until  vQuery.ProximoRegistro;

  Log(Format('Fim da Tarefa %s: durou %s!',
              [FId, FormatDateTime('hh:mm:ss',(Now - vInicio))]));
  FOnShowStatus('Fim','', '','', '', vEncCon, vUltAss, vInaug, 0);
  //DeleteCriticalSection(vCriticalSection);
  //FMsg := 'Fim';
  //ShowStatus;
end;

constructor TTarefaSaldoRnp.Create(pId: String);
begin
  inherited Create(True);
  FLinhas := TStringList.Create;
  FreeOnTerminate := True;
  FId := pId;
end;

destructor TTarefaSaldoRnp.Destroy;
begin
  FLinhas.SaveToFile(Format('LogTarefa%s.txt',[FId]));
  FLinhas.Free;
  inherited Destroy;
end;

end.


