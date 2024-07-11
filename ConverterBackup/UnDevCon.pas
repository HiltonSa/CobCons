unit UnDevCon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, DBCtrls, DB, DBClient, SimpleDS, StdCtrls, ExtCtrls,
  Buttons, DBXpress, SqlExpr, ComCtrls, RpBase, RpSystem, RpDefine, RpRave;

type
  TfrmDevCon = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    dsCota: TDataSource;
    btnSair: TBitBtn;
    dsReu: TDataSource;
    dsPre: TDataSource;
    Panel3: TPanel;
    chAdm: TCheckBox;
    txtRed: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label15: TLabel;
    btnImp: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label10: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    DBEdit11: TDBEdit;
    dbPre: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit9: TDBEdit;
    dbAss: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit1: TDBEdit;
    GroupBox1: TGroupBox;
    Label16: TLabel;
    lblVlrCorrigido: TLabel;
    lblVlrReducao: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    lblTotal: TLabel;
    lblAdmDevido: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    lblAdmRec: TLabel;
    lblAdmARecolher: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    lblAdm50: TLabel;
    lblRestituir: TLabel;
    Label23: TLabel;
    txtBanco: TEdit;
    Label24: TLabel;
    Agencia: TLabel;
    txtAgencia: TEdit;
    txtConta: TEdit;
    Conta: TLabel;
    Label25: TLabel;
    txtObs: TEdit;
    Label26: TLabel;
    DBEdit8: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit12: TDBEdit;
    dsBem: TDataSource;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    Label27: TLabel;
    procedure btnImpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure txtRedExit(Sender: TObject);
    procedure chAdmClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Calcular;
  end;

var
  frmDevCon: TfrmDevCon;

implementation

uses UnDm;

{$R *.dfm}

procedure TfrmDevCon.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       VK_F2: if btnImp.Enabled then btnImp.Click;
       VK_RETURN: Perform(WM_NEXTDLGCTL, 0, 0);
       VK_ESCAPE: btnSair.Click;
     end;
end;

procedure TfrmDevCon.FormShow(Sender: TObject);
begin
  Calcular;
end;

procedure TfrmDevCon.btnImpClick(Sender: TObject);
begin
  DM.ImprimirRelatorio('','rpDevCon');
end;

procedure TfrmDevCon.btnSairClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmDevCon.Calcular;
var
   VlrCorr, VlrRed, Tot, AdmDev, AdmRec, Adm50 : Double;

begin
  DM.sdsPre.First;
  DM.cdsDevCon.EmptyDataSet;
  DM.cdsDevCon.Insert;
  VlrCorr := DM.sdsPrePRE_TABE.AsFloat * (DM.cdsCotPerPago.Value - DM.cdsCotPreRat.Value) / 100;
  VlrRed := VlrCorr * StrToFloat(txtRed.Text) / 100;
  Tot := VlrCorr - VlrRed;
  if chAdm.Checked then begin
    AdmDev := DM.sdsPrePRE_TABE.AsFloat * DM.cdsCotP_ADMINS.AsFloat / 100;
    AdmRec := AdmDev - DM.cdsCotADMINIST.AsFloat;
    Adm50 := AdmRec / 2;
  end
  else begin
    AdmDev := 0;
    AdmRec := 0;
    Adm50 := 0;
  end;
  lblVlrCorrigido.Caption := Format('%10.2n',[VlrCorr]);
  lblVlrReducao.Caption := Format('%10.2n',[VlrRed]);
  lblTotal.Caption := Format('%10.2n',[Tot]);
  lblAdmDevido.Caption := Format('%10.2n',[AdmDev]);
  lblAdmRec.Caption := Format('%10.2n',[DM.cdsCotADMINIST.AsFloat]);
  lblAdmARecolher.Caption := Format('%10.2n',[AdmRec]);
  lblAdm50.Caption := Format('%10.2n',[Adm50]);
  lblRestituir.Caption := Format('%10.2n',[Tot-Adm50]);
  DM.cdsDevConPcLiq.Value := DM.cdsCotPerPago.Value - DM.cdsCotPreRat.Value;
  DM.cdsDevConVlCorr.Value := VlrCorr;
  DM.cdsDevConVlRed.Value := VlrRed;
  DM.cdsDevConTxDev.Value := AdmDev;
  DM.cdsDevConTxRec.Value := DM.cdsCotADMINIST.Value;
  DM.cdsDevConTxRecolher.Value := AdmRec;
  DM.cdsDevConTx50.Value := AdmRec;
  DM.cdsDevConVlRes.Value := Tot - AdmRec;
  DM.cdsDevCon.Post;
end;

procedure TfrmDevCon.txtRedExit(Sender: TObject);
begin
     Calcular;
end;

procedure TfrmDevCon.chAdmClick(Sender: TObject);
begin
     Calcular;
end;

end.
