unit cobcons.view.comparasag;

{$mode delphi}

interface

uses
  Classes, Sysutils, DB, Forms, Controls, Graphics, Dialogs, ActnList, ExtCtrls,
  Buttons, StdCtrls, DBCtrls, DBGrids, cobcons.controller.interfaces, Windows;

type

  { TFrmComparaSAG }

  TFrmComparaSAG = class(Tform)
    lblDataBase: Tlabel;
    lersag: Taction;
    Al: Tactionlist;
    Btnsair: Tspeedbutton;
    Btnsair1: Tspeedbutton;
    Ds: Tdatasource;
    Grcon: Tdbgrid;
    lblNomeArquivo: Tlabel;
    Nvpesq: Tdbnavigator;
    Panel1: Tpanel;
    Panel2: Tpanel;
    Pnacoes: Tpanel;
    Pnback: Tpanel;
    Pntitulo: Tpanel;
    Sair: Taction;
    procedure Formcreate(Sender: Tobject);
    procedure Formkeydown(Sender: Tobject; var Key: Word; Shift: Tshiftstate);
    procedure Grcondblclick(Sender: Tobject);
    procedure Lersagexecute(Sender: Tobject);
    procedure Sairexecute(Sender: Tobject);
  Private
    FRnp: iControllerRnp;

  Public

  end;

var
  FrmComparaSAG: TFrmComparaSAG;

implementation

uses cobcons.model.configura, cobcons.model.dm, cobcons.controller.util,
  cobcons.controller.factory;

{$R *.lfm}

{ TFrmComparaSAG }

procedure Tfrmcomparasag.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnTitulo.Color := vEsquema.CorPainelTitulo;
  pnAcoes.Color := vEsquema.CorPainelAcoes;
  pnBack.Color := vEsquema.CorFundo;
  FRnp := TControllerFactory.New.RNP;
End;

procedure Tfrmcomparasag.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_RETURN:  SelectNext(ActiveControl,True,True);
    VK_ESCAPE: Sair.Execute;
  end;
End;

procedure Tfrmcomparasag.Grcondblclick(Sender: Tobject);
begin
  AbrirFichaCota( Ds.DataSet.FieldByName('Grupo').AsString,
                  Ds.DataSet.FieldByName('Seq').AsString,
                  Ds.DataSet.FieldByName('Cota').AsString );
End;

procedure Tfrmcomparasag.Lersagexecute(Sender: Tobject);
var
  vLin, vInd: Integer;
  vArquivoXML: TStringList;

  function PegarString(pTag, pLin: string): string;
  var
    I, Fim: Integer;
    Cpo: string;
  begin
    Cpo := '';
    Fim := Length(pLin);
    I := Pos(pTag,pLin)+Length(pTag);
    while I < Fim do begin
      if pLin[I]='"' then begin
        Inc(I);
        while pLin[I]<>'"' do begin
          Cpo := Cpo + pLin[I];
          Inc(I);
        end;
        Break;
      end;
      Inc(I);
    end;
    Result := Cpo;

  end;

begin
  if DM.AbreArquivo.Execute
  then begin
    lblNomeArquivo.Caption := DM.AbreArquivo.FileName;
    vArquivoXML := TStringList.Create;
    try
      vArquivoXML.LoadFromFile(lblNomeArquivo.Caption);

      if Pos('xml version',vArquivoXML[0]) = 0
      then begin
        MostraErro('Arquivo Inválido!');
        Exit;
      end;

      if Pos('Doc2080',vArquivoXML[1])>0
      then lblDataBase.Caption := PegarString('dataBase', vArquivoXML[1])
      else begin
        MostraErro('Arquivo não é SAG!');
        Exit;
      end;

      if ConfirmaMensagem('Comparar?')
      then Ds.DataSet := FRnp.CompararSAG(vArquivoXML);

    finally
      vArquivoXML.Free;
    end;
  end;
End;

procedure Tfrmcomparasag.Sairexecute(Sender: Tobject);
begin
  Close;
End;

end.

