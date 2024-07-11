program CobCons;

{%ToDo 'CobCons.todo'}

uses
  Forms,
  UnPrincipal in 'UnPrincipal.pas' {frmPrincipal},
  UnDm in 'UnDm.pas' {DM: TDataModule},
  UnLogin in 'UnLogin.pas' {frmLogin},
  UnAltSenha in 'UnAltSenha.pas' {frmAltSenha},
  UnModelo in 'UnModelo.pas' {frmMod},
  UnUsu in 'UnUsu.pas' {frmUsu},
  UnPesq in 'UnPesq.pas' {frmPesq},
  UnCli in 'UnCli.pas' {frmCli},
  UnEnd in 'UnEnd.pas' {frmEnd},
  UnFon in 'UnFon.pas' {frmFone},
  UnPrs in 'UnPrs.pas' {frmPrs},
  UnReu in 'UnReu.pas' {frmReu},
  UnPre in 'UnPre.pas' {frmPre},
  UnJur in 'UnJur.pas' {frmJur},
  UnPag in 'UnPag.pas' {frmPag},
  UnPen in 'UnPen.pas' {frmPen},
  UnSRGru in 'UnSRGru.pas' {frmSRGru},
  UnSVen in 'UnSVen.pas' {frmSVen},
  UnSRec in 'UnSRec.pas' {frmSRec},
  UnEstorno in 'UnEstorno.pas' {frmEstorno},
  UnPcl in 'UnPcl.pas' {frmPcl},
  UnAge in 'UnAge.pas' {frmAge},
  UnCom in 'UnCom.pas' {frmCom},
  UnMld in 'UnMld.pas' {frmMld},
  UnAli in 'UnAli.pas' {frmAli},
  UnLista in 'UnLista.pas' {FrmLista},
  UnCre in 'UnCre.pas' {FrmCre},
  UnAco in 'UnAco.pas' {frmAco},
  UnDevCon in 'UnDevCon.pas' {frmDevCon},
  UnMov in 'UnMov.pas' {FrmMov},
  RelCli in 'RelCli.pas' {frmRelCli},
  UnSFin in 'UnSFin.pas' {frmSFin},
  UnSitCob in 'UnSitCob.pas' {frmSitCob},
  UnitCpt in 'UnitCpt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Gestão de Contratos';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
