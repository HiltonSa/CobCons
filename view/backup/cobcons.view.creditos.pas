unit cobcons.view.creditos;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  DBCGrids, Mask,
{$ELSE}
  MaskEdit,
{$ENDIF}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, DBCtrls, ExtCtrls, DBGrids,
  cobcons.controller.interfaces;

type

  { TFrmCre }

  TFrmCre = class(TForm)
    edIniCorr: Tedit;
    edObser: Tedit;
    edValCorr: Tedit;
    edValCred: Tedit;
    edLimCorr: Tedit;
    edTpCred: Tedit;
    Eddctpconte: Tedit;
    edCredito: Tedit;
    Eddtconte: Tedit;
    Eddtentre: Tedit;
    edNmForn: Tedit;
    edDtNota: Tedit;
    edNota: Tedit;
    edDtPagto: Tedit;
    edValEntr: Tedit;
    edCorrEntr: Tedit;
    Edvalentre: Tedit;
    edValContemp: Tedit;
    grCre: Tdbgrid;
    Label29: Tlabel;
    Label30: Tlabel;
    Label31: Tlabel;
    Label32: Tlabel;
    Label33: Tlabel;
    nvCre: Tdbnavigator;
    pnBack: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label1: TLabel;
    dsCre: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Pntitulo: Tpanel;
    procedure Dscredatachange(Sender: Tobject; Field: Tfield);
    procedure Formcreate(Sender: Tobject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Grcrecellclick(Column: Tcolumn);

      procedure Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
  private
    Fcliente: Icontrollercota;
    FCreditos: iControllerCredito;
    procedure Setcliente(Avalue: Icontrollercota);
    procedure PreencheEdits;
    { Private declarations }
  public
    { Public declarations }
    property Cliente: iControllerCota read FCliente write SetCliente;
  end;

var
  FrmCre: TFrmCre;

implementation

uses cobcons.controller.factory, cobcons.controller.util,
  cobcons.model.configura, cobcons.model.dm;


{$R *.lfm}

procedure Tfrmcre.Formkeydown(Sender: Tobject;
  var Key: Word; Shift: Tshiftstate);
begin
  case Key of
    VK_ESCAPE: Close;
    VK_RETURN: if grCre.Focused then PreencheEdits;
  end;
end;

procedure Tfrmcre.Grcrecellclick(Column: Tcolumn);
begin
  //PreencheEdits;
End;

procedure Tfrmcre.Pntitulomousemove(Sender: Tobject; Shift: Tshiftstate; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
End;

procedure Tfrmcre.Formcreate(Sender: Tobject);
var
  vEsquema: TEsquemaCores;
begin
  vEsquema := TConfigura.New.RetornaEsquemaUsuario;
  Self.Color := vEsquema.CorFormulario;
  pnBack.Color := vEsquema.CorFundo;
  Pntitulo.Color := vEsquema.CorPainelTitulo;
  FCreditos := TControllerFactory.New.Credito;
End;

procedure Tfrmcre.Dscredatachange(Sender: Tobject; Field: Tfield);
begin
  PreencheEdits;
End;

procedure Tfrmcre.Setcliente(Avalue: Icontrollercota);
begin
  if Fcliente = Avalue then Exit;
  Fcliente := Avalue;
  Eddctpconte.Text := Fcliente.DCTPCONTE;
  Eddtconte.Text := FormatDateTime('dd/mm/yyyy', Fcliente.DT_CONTE);
  Eddtentre.Text := FormatDateTime('dd/mm/yyyy', Fcliente.DT_ENTRE);
  Edvalentre.Text := Format('%.2n',[Fcliente.VAL_ENTR]);
  edValContemp.Text := Format('%.2n',[ RetornarPrecoData( Fcliente.FIL_COM,
                                                          Fcliente.BEM,
                                                          Fcliente.DT_CONTE)]);
  FCreditos.RetornaCreditosCota(Fcliente.GRUPO, Fcliente.COTA);
  dsCre.DataSet := FCreditos.DataSet;
  PreencheEdits;
end;

procedure Tfrmcre.Preencheedits;
var
  vCred : iControllerCredito;
begin
  vCred := TControllerFactory.New.Credito;
  vCred.RetornaUmCreditoCota(Fcliente.GRUPO, Fcliente.COTA, dsCre.DataSet.FieldByName('CREDITO').AsString);
  edCredito.Text := vCred.CREDITO;
  edTpCred.Text := vCred.DCTPCRED;
  edIniCorr.Text := FormatDateTime('dd/mm/yyyy', vCred.DT_I_COR);
  edLimCorr.Text := FormatDateTime('dd/mm/yyyy', vCred.LIM_CORR);
  edValCred.Text := Format('%.2n',[vCred.VAL_CRED]);
  edValCorr.Text := Format('%.2n',[vCred.VAL_CORR]);
  edNmForn.Text := vCred.NMFORNEC;
  edDtNota.Text := FormatDateTime('dd/mm/yyyy', vCred.DT_N_FIS);
  edNota.Text := vCred.NR_N_FIS;
  edDtPagto.Text := FormatDateTime('dd/mm/yyyy', vCred.DT_PAGTO);
  edValEntr.Text := Format('%.2n',[vCred.VAL_ENTR]);
  edCorrEntr.Text := Format('%.2n',[vCred.COR_ENTR]);
  edObser.Text := vCred.OBSERV;
end;

end.
