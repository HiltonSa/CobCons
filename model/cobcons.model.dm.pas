unit cobcons.model.dm;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses

  sqldb,
  SysUtils, Classes, DB, BufDataset, FMTBcd,  ZDataset,
  Dialogs, ExtDlgs, Forms, ImgList, Controls, cobcons.controller.interfaces,
  RLParser, RLDraftFilter, RLPDFFilter, RLPreviewForm, RLXLSFilter;

type

  { TDM }

  TDM = class(TDataModule)
    ccDev: TBufDataset;
    Ccdevdtctb: Tdatetimefield;
    Ccdevsaldo: Tfloatfield;
    Ccdevtipo: Tstringfield;
    Ccdevvalor: Tfloatfield;
    Cdsmovtpmov: Tstringfield;
    Comperdata: Tdatetimefield;
    AbreArquivo: Topendialog;
    SalvarArquivo: Tsavedialog;
    XLSFltr: Trlxlsfilter;
    rnp: TBufDataset;
    comper: Tbufdataset;
    rnpCota: Tstringfield;
    comperCota: Tstringfield;
    rnpDtEnc: Tstringfield;
    rnpGrupo: TStringField;
    comperGrupo: Tstringfield;
    Rnpmulresadm: Tfloatfield;
    Rnpmulresgrupo: Tfloatfield;
    rnpNome: Tstringfield;
    comperNome: Tstringfield;
    rnpPercAmort: TFloatField;
    Rnppercrateio: Tfloatfield;
    comperAtual: Tfloatfield;
    rnpPfPj: Tstringfield;
    Rnpratfuturos: Tfloatfield;
    comperComissao: Tfloatfield;
    Rnpregaplic: Tstringfield;
    rnpSeq: Tstringfield;
    comperSeq: Tstringfield;
    Rnpstconsorciado: Tstringfield;
    rnpTpRec: Tstringfield;
    Rnptxman: Tfloatfield;
    Rnpultass: Tstringfield;
    rnpVlrBem: TFloatField;
    rnpVlrRnp: TFloatField;
    comperSaldo: Tfloatfield;
    ttGru: TBufDataset;
    Floatfield1: Tfloatfield;
    gru: Tbufdataset;
    Grubemapreendido: Tfloatfield;
    Grugrupo: Tstringfield;
    Gruqtdina: Tlongintfield;
    Gruqtdrnp: Tlongintfield;
    Gruvlrina: Tfloatfield;
    Gruvlrjuridico: Tfloatfield;
    Gruvlrmediacao: Tfloatfield;
    Gruvlrrnp: Tfloatfield;
    ina: TBufDataset;
    Inabemapreendido: Tfloatfield;
    Inacota: Tstringfield;
    Inadtajuiz: Tstringfield;
    Inadtenc: Tstringfield;
    Inagrupo: Tstringfield;
    Inanome: Tstringfield;
    Inapercamort: Tfloatfield;
    Inapfpj: Tstringfield;
    Inaseq: Tstringfield;
    Inatprec: Tstringfield;
    Inavlrbem: Tfloatfield;
    Inavlrreceber: Tfloatfield;
    ttCota: Tbufdataset;
    cdsCb1: TBufDataset;
    cdsCb1Aviso: Tstringfield;
    cdsCb1PcNormal: TFloatField;
    cdsCb1PcRat: TFloatField;
    cdsCb1Reu: Tstringfield;
    cdsCb1TpPen: Tstringfield;
    cdsCb1Vencto: Tstringfield;
    cdsCb1VlBem: TFloatField;
    cdsCb1VlJur: TFloatField;
    cdsCb1VlMul: TFloatField;
    cdsCb1VlMulJUr: TFloatField;
    cdsCb1VlTot: TFloatField;
    cdsCb1VPend: TFloatField;
    cdsMov: TBufDataset;
    cdsMovAviso: Tstringfield;
    cdsMovDcBem: Tstringfield;
    cdsMovDtCtb: Tstringfield;
    cdsMovDtReu: Tstringfield;
    cdsMovFdRes: TFloatField;
    cdsMovHist: Tstringfield;
    cdsMovMulju: TFloatField;
    cdsMovOutros: TFloatField;
    cdsMovPagto: Tstringfield;
    cdsMovPer: TFloatField;
    cdsMovRat: TFloatField;
    cdsMovReu: Tstringfield;
    cdsMovSimb: Tstringfield;
    cdsMovTipo: Tstringfield;
    cdsMovTxAdm: TFloatField;
    cdsMovVencto: Tstringfield;
    cdsMovVlBem: TFloatField;
    cdsMovVlPag: TFloatField;
    cdsMovVlReal: TFloatField;
    cdsMovVlTot: TFloatField;
    Con: TSQLConnection;
    Il18: Timagelist;
    qryImp: TSQLQuery;
    dstCot: TZQuery;
    cdsCot: TZQuery;
    dstUsu: TZQuery;
    cdsUsu: TZQuery;
    sqlCom: TSQLQuery;
    AbreFig: TOpenPictureDialog;
    dstCons: TZQuery;
    cdsCons: TZQuery;
    dstPesq: TZQuery;
    cdsPesq: TZQuery;
    dstPRS: TZQuery;
    cdsPRS: TZQuery;
    cdsPRSNM_PRS: TStringField;
    cdsPRSCD_CGC: TStringField;
    qryPag: TSQLQuery;
    cdsPag: TZQuery;
    cdsPagAVISO: TStringField;
    cdsPagSIGLA1: TStringField;
    qryImpCot: TSQLQuery;
    qryImpCotGRUPO: TStringField;
    qryImpCotSEQ: TStringField;
    qryImpCotCOTA: TStringField;
    qryImpCotNOME: TStringField;
    qryImpCotCGC_CPF: TStringField;
    qryImpCotPESS_F_J: TStringField;
    qryImpCotENDERECO: TStringField;
    qryImpCotFIL_COM: TStringField;
    qryImpCotCOMPLEMEN: TStringField;
    qryImpCotBAIRRO: TStringField;
    qryImpCotCIDADE: TStringField;
    qryImpCotESTADO: TStringField;
    qryImpCotCEP: TStringField;
    qryImpCotTELEFONE: TStringField;
    qryImpCotBEM: TStringField;
    qryImpCotPCPAGO: TFMTBCDField;
    qryImpCotP_NO_AQU: TBCDField;
    qryImpCotP_ADMINS: TBCDField;
    qryImpCotP_RESERV: TBCDField;
    qryImpCotAVISO: TStringField;
    qryImpCotTIPO_MOV: TStringField;
    qryImpCotP_NORMAL: TBCDField;
    qryImpCotP_DIFER: TBCDField;
    qryImpCotF_AQUISI: TFMTBCDField;
    qryImpCotADMINIST: TFMTBCDField;
    qryImpCotF_RESERV: TFMTBCDField;
    qryImpCotOUTROS: TFMTBCDField;
    qryImpCotSEG_OUT: TStringField;
    qryImpCotTP_SEGUR: TStringField;
    qryImpCotPERSEGVD: TFMTBCDField;
    qryImpGRUPO: TStringField;
    qryImpSEQ: TStringField;
    qryImpCOTA: TStringField;
    qryImpNOME: TStringField;
    qryImpCGC_CPF: TStringField;
    qryImpPESS_F_J: TStringField;
    qryImpENDERECO: TStringField;
    qryImpFIL_COM: TStringField;
    qryImpCOMPLEMEN: TStringField;
    qryImpBAIRRO: TStringField;
    qryImpCIDADE: TStringField;
    qryImpESTADO: TStringField;
    qryImpCEP: TStringField;
    qryImpTELEFONE: TStringField;
    qryImpBEM: TStringField;
    qryImpPCPAGO: TFMTBCDField;
    qryImpP_NO_AQU: TFMTBCDField;
    qryImpP_ADMINS: TFMTBCDField;
    qryImpP_RESERV: TFMTBCDField;
    qryImpAVISO: TStringField;
    qryImpTIPO_MOV: TStringField;
    qryImpP_NORMAL: TFMTBCDField;
    qryImpP_DIFER: TFMTBCDField;
    qryImpF_AQUISI: TFMTBCDField;
    qryImpADMINIST: TFMTBCDField;
    qryImpF_RESERV: TFMTBCDField;
    qryImpOUTROS: TFMTBCDField;
    qryImpSEG_OUT: TStringField;
    qryImpTP_SEGUR: TStringField;
    qryImpPERSEGVD: TFMTBCDField;
    dstAge: TZQuery;
    cdsAge: TZQuery;
    SelFon: TFontDialog;
    cdsCar: TZQuery;
    cdsCarCarta: TMemoField;
    cdsTex: TZQuery;
    cdsTexCodigo: TIntegerField;
    cdsTexObs: TStringField;
    cdsTexTexto: TMemoField;
    qryAli: TSQLQuery;
    cdsAli: TZQuery;
    cdsAliSIT_ALIE: TStringField;
    cdsAliFABRICAN: TStringField;
    cdsAliLIN_MOD: TStringField;
    cdsAliDESCRIC: TStringField;
    cdsAliANO_FABR: TStringField;
    cdsAliNR_CHASS: TStringField;
    cdsAliNR_RENAV: TStringField;
    cdsAliPLACA: TStringField;
    cdsAliOBSERVAC: TStringField;
    cdsAliCOR: TStringField;
    dstUsuCD_USU: TIntegerField;
    dstUsuNM_USU: TStringField;
    dstUsuDC_FIG: TStringField;
    dstUsuID_ADM: TIntegerField;
    dstUsuCD_SENHA: TStringField;
    cdsUsuCD_USU: TIntegerField;
    cdsUsuNM_USU: TStringField;
    cdsUsuDC_FIG: TStringField;
    cdsUsuID_ADM: TIntegerField;
    cdsUsuCD_SENHA: TStringField;
    dstPRSCD_PRS: TIntegerField;
    dstPRSNM_PRS: TStringField;
    dstPRSCD_CGC: TStringField;
    dstPRSPC_MUL: TFloatField;
    dstPRSPC_JUR: TFloatField;
    dstPRSPC_HONOR: TFloatField;
    cdsPRSCD_PRS: TIntegerField;
    cdsPRSPC_MUL: TFloatField;
    cdsPRSPC_JUR: TFloatField;
    cdsPRSPC_HONOR: TFloatField;
    dstCotGRUPO: TStringField;
    dstCotSEQ: TStringField;
    dstCotCOTA: TStringField;
    dstCotCONTRATO: TStringField;
    dstCotNOME: TStringField;
    dstCotENDERECO: TStringField;
    dstCotBAIRRO: TStringField;
    dstCotCIDADE: TStringField;
    dstCotESTADO: TStringField;
    dstCotCEP: TStringField;
    dstCotTELEFONE: TStringField;
    dstCotBANCO: TStringField;
    dstCotAGENCIA: TStringField;
    dstCotCONTA: TStringField;
    dstCotCGC_CPF: TStringField;
    dstCotE_CIVIL: TStringField;
    dstCotDT_NASC: TDateField;
    dstCotSEXO: TStringField;
    dstCotPROFISS: TStringField;
    dstCotDT_VENDA: TDateField;
    dstCotFIL_FISC: TStringField;
    dstCotBEM: TStringField;
    dstCotDOCUMENT: TStringField;
    dstCotTP_COTA: TStringField;
    dstCotPESS_F_J: TStringField;
    dstCotFIL_ATE: TStringField;
    dstCotFIL_COM: TStringField;
    dstCotPLANO: TStringField;
    dstCotP_MENSAL: TFloatField;
    dstCotDT_ADES: TDateField;
    dstCotP_ADMINS: TFloatField;
    dstCotP_RESERV: TFloatField;
    dstCotREU_EMI: TStringField;
    dstCotTP_SEGUR: TStringField;
    dstCotSIT_COBR: TStringField;
    dstCotREU_SORT: TStringField;
    dstCotTP_CONTE: TStringField;
    dstCotDT_CONTE: TDateField;
    dstCotDT_CONGE: TDateField;
    dstCotFORNEC: TStringField;
    dstCotDT_DESCL: TDateField;
    dstCotREPRES: TStringField;
    dstCotREU_ADES: TStringField;
    dstCotDT_ENTRE: TDateField;
    dstCotVAL_ENTR: TFloatField;
    dstCotPERM_NOM: TStringField;
    dstCotP_AN_AQU: TFloatField;
    dstCotP_NO_AQU: TFloatField;
    dstCotP_SU_AQU: TFloatField;
    dstCotP_RA_AQU: TFloatField;
    dstCotP_NO_PAG: TFloatField;
    dstCotP_SU_PAG: TFloatField;
    dstCotP_RA_PAG: TFloatField;
    dstCotP_AN_PAG: TFloatField;
    dstCotP_RATEAD: TFloatField;
    dstCotF_AQUISI: TFloatField;
    dstCotADMINIST: TFloatField;
    dstCotF_RESERV: TFloatField;
    dstCotOUTROS: TFloatField;
    dstCotP_IDEAL: TFloatField;
    dstCotCONSTRUC: TStringField;
    dstCotAG_COBRA: TStringField;
    dstCotD_CONGEL: TDateField;
    dstCotD_LIM_RJ: TDateField;
    dstCotD_ALT_RE: TDateField;
    dstCotME_DT_AP: TDateField;
    dstCotDT_SITUA: TDateField;
    dstCotREU_MOED: TStringField;
    dstCotMOEDA_CO: TStringField;
    dstCotQT_MOEDA: TFloatField;
    dstCotDT_TROCA: TDateField;
    dstCotISEN_TAR: TStringField;
    dstCotUSUARIO: TStringField;
    dstCotD_ATUALI: TDateField;
    dstCotCARAC_CT: TStringField;
    dstCotREPRE_GR: TStringField;
    dstCotTP_VENDA: TStringField;
    dstCotP_I_SUBS: TFloatField;
    dstCotP_MX_SUB: TFloatField;
    dstCotINF_ADIC: TStringField;
    dstCotINF_ADIC_2: TStringField;
    dstCotINF_ADIC_3: TStringField;
    dstCotINF_ADIC_4: TStringField;
    cdsCotGRUPO: TStringField;
    cdsCotSEQ: TStringField;
    cdsCotCOTA: TStringField;
    cdsCotCONTRATO: TStringField;
    cdsCotNOME: TStringField;
    cdsCotENDERECO: TStringField;
    cdsCotBAIRRO: TStringField;
    cdsCotCIDADE: TStringField;
    cdsCotESTADO: TStringField;
    cdsCotCEP: TStringField;
    cdsCotTELEFONE: TStringField;
    cdsCotBANCO: TStringField;
    cdsCotAGENCIA: TStringField;
    cdsCotCONTA: TStringField;
    cdsCotCGC_CPF: TStringField;
    cdsCotE_CIVIL: TStringField;
    cdsCotDT_NASC: TDateField;
    cdsCotSEXO: TStringField;
    cdsCotPROFISS: TStringField;
    cdsCotDT_VENDA: TDateField;
    cdsCotFIL_FISC: TStringField;
    cdsCotBEM: TStringField;
    cdsCotDOCUMENT: TStringField;
    cdsCotTP_COTA: TStringField;
    cdsCotPESS_F_J: TStringField;
    cdsCotFIL_ATE: TStringField;
    cdsCotFIL_COM: TStringField;
    cdsCotPLANO: TStringField;
    cdsCotP_MENSAL: TFloatField;
    cdsCotDT_ADES: TDateField;
    cdsCotP_ADMINS: TFloatField;
    cdsCotP_RESERV: TFloatField;
    cdsCotREU_EMI: TStringField;
    cdsCotTP_SEGUR: TStringField;
    cdsCotSIT_COBR: TStringField;
    cdsCotREU_SORT: TStringField;
    cdsCotTP_CONTE: TStringField;
    cdsCotDT_CONTE: TDateField;
    cdsCotDT_CONGE: TDateField;
    cdsCotFORNEC: TStringField;
    cdsCotDT_DESCL: TDateField;
    cdsCotREPRES: TStringField;
    cdsCotREU_ADES: TStringField;
    cdsCotDT_ENTRE: TDateField;
    cdsCotVAL_ENTR: TFloatField;
    cdsCotPERM_NOM: TStringField;
    cdsCotP_AN_AQU: TFloatField;
    cdsCotP_NO_AQU: TFloatField;
    cdsCotP_SU_AQU: TFloatField;
    cdsCotP_RA_AQU: TFloatField;
    cdsCotP_NO_PAG: TFloatField;
    cdsCotP_SU_PAG: TFloatField;
    cdsCotP_RA_PAG: TFloatField;
    cdsCotP_AN_PAG: TFloatField;
    cdsCotP_RATEAD: TFloatField;
    cdsCotF_AQUISI: TFloatField;
    cdsCotADMINIST: TFloatField;
    cdsCotF_RESERV: TFloatField;
    cdsCotOUTROS: TFloatField;
    cdsCotP_IDEAL: TFloatField;
    cdsCotCONSTRUC: TStringField;
    cdsCotAG_COBRA: TStringField;
    cdsCotD_CONGEL: TDateField;
    cdsCotD_LIM_RJ: TDateField;
    cdsCotD_ALT_RE: TDateField;
    cdsCotME_DT_AP: TDateField;
    cdsCotDT_SITUA: TDateField;
    cdsCotREU_MOED: TStringField;
    cdsCotMOEDA_CO: TStringField;
    cdsCotQT_MOEDA: TFloatField;
    cdsCotDT_TROCA: TDateField;
    cdsCotISEN_TAR: TStringField;
    cdsCotUSUARIO: TStringField;
    cdsCotD_ATUALI: TDateField;
    cdsCotCARAC_CT: TStringField;
    cdsCotREPRE_GR: TStringField;
    cdsCotTP_VENDA: TStringField;
    cdsCotP_I_SUBS: TFloatField;
    cdsCotP_MX_SUB: TFloatField;
    cdsCotINF_ADIC: TStringField;
    cdsCotINF_ADIC_2: TStringField;
    cdsCotINF_ADIC_3: TStringField;
    cdsCotINF_ADIC_4: TStringField;
    cdsAgeCD_AGE: TIntegerField;
    cdsAgeDT_AGE: TDateField;
    cdsAgePRIORIDADE: TIntegerField;
    cdsAgeCD_CTRATO: TStringField;
    cdsAgeSTATUS: TIntegerField;
    cdsAgeOBS: TMemoField;
    cdsAgeCD_USU: TIntegerField;
    cdsAgeNOME: TStringField;
    cdsPagD_VENCTO: TDateField;
    cdsPagDT_PAGTO: TDateField;
    cdsPagP_NORMAL: TFloatField;
    cdsPagP_DIFER: TFloatField;
    cdsPagP_ANTEC: TFloatField;
    cdsPagVALOR: TFloatField;
    cdsPagMUL_JUR: TFloatField;
    cdsAliDT_SUBST: TDateField;
    cdsAliDT_DESAL: TDateField;
    cdsAliDT_ALIE: TDateField;
    dstBem: TZQuery;
    sdsBem: TZQuery;
    sdsBemDESCRIC: TStringField;
    sdsBemFABRICAN: TStringField;
    sdsBemTIPO_BEM: TStringField;
    dstPre: TZQuery;
    sdsPre: TZQuery;
    sdsPreDT_BASE: TDateField;
    sdsPrePRE_TABE: TFloatField;
    dstReu: TZQuery;
    sdsReu: TZQuery;
    sdsReuNRO_REU: TStringField;
    sdsReuDATA_REU: TDateField;
    qryTab: TSQLQuery;
    qryTabDESCRIC: TStringField;
    dstCob: TZQuery;
    cdsCob: TZQuery;
    cdsCobAVISO: TStringField;
    cdsCobSIGLA1: TStringField;
    cdsCobD_VENCTO: TDateField;
    cdsCobVALOR: TFloatField;
    dstJur: TZQuery;
    sdsJur: TZQuery;
    sdsJurGRUPO: TStringField;
    sdsJurSEQ: TStringField;
    sdsJurCOTA: TStringField;
    sdsJurDESCRIC: TStringField;
    sdsJurD_INICIO: TDateField;
    sdsJurNOME: TStringField;
    sdsJurCUST_MOE: TFloatField;
    sdsJurOBSERV: TStringField;
    dstAgeCD_AGE: TIntegerField;
    dstAgeDT_AGE: TDateField;
    dstAgePRIORIDADE: TIntegerField;
    dstAgeCD_CTRATO: TStringField;
    dstAgeSTATUS: TIntegerField;
    dstAgeOBS: TMemoField;
    dstAgeCD_USU: TIntegerField;
    dstAgeNOME: TStringField;
    dstAgeGRUPO: TStringField;
    dstAgeSEQ: TStringField;
    dstAgeCOTA: TStringField;
    cdsAgeGRUPO: TStringField;
    cdsAgeSEQ: TStringField;
    cdsAgeCOTA: TStringField;
    cdsCotPerPago: TFloatField;
    cdsCotPerDev: TFloatField;
    dsCot: TDataSource;
    dstGru: TZQuery;
    cdsGru: TZQuery;
    cdsGruGRUPO: TStringField;
    cdsGruPLA_PADR: TStringField;
    dsGru: TDataSource;
    dstCre: TZQuery;
    cdsCre: TZQuery;
    cdsCreGRUPO: TStringField;
    cdsCreCOTA: TStringField;
    cdsCreCREDITO: TStringField;
    cdsCreVAL_CRED: TFloatField;
    cdsCreVAL_REAJ: TFloatField;
    cdsCreVAL_CORR: TFloatField;
    cdsCreLIM_CORR: TDateField;
    cdsCreTP_CRED: TStringField;
    cdsCreBEM_OPC: TStringField;
    cdsCreBEM: TStringField;
    cdsCreCOMPLEM: TStringField;
    cdsCreFORNEC: TStringField;
    cdsCreVAL_PEDI: TFloatField;
    cdsCreOBSERV: TStringField;
    cdsCreCOMPRAD: TStringField;
    cdsCreD_BEM_OP: TStringField;
    cdsCreDT_PEDID: TDateField;
    cdsCreALIENADO: TStringField;
    cdsCreDT_PAGTO: TDateField;
    cdsCreF_L_COMP: TStringField;
    cdsCreDT_L_PAG: TDateField;
    cdsCreVAL_LIBE: TFloatField;
    cdsCreCOR_LIBE: TFloatField;
    cdsCreVAL_OPC: TFloatField;
    cdsCreVAL_ENTR: TFloatField;
    cdsCreCOR_ENTR: TFloatField;
    cdsCreUSUARIO: TStringField;
    cdsCreD_ATUALI: TDateField;
    cdsCreDT_N_FIS: TDateField;
    cdsCreNR_N_FIS: TStringField;
    cdsCreDT_I_COR: TDateField;
    cdsCreADIANTAM: TStringField;
    cdsCreNUMEROAP: TStringField;
    cdsCreAGENTE: TStringField;
    cdsCreD_CONTAB: TDateField;
    cdsCreNUMAVISO: TStringField;
    cdsCreDCTPCRE: TStringField;
    dstSeg: TZQuery;
    cdsSeg: TZQuery;
    cdsSegNOME_FANT: TStringField;
    cdsSegPERSEGVD: TFloatField;
    sqlRGru: TZQuery;
    cdsRGru: TZQuery;
    cdsRGruGRUPO: TStringField;
    cdsRGruPLA_PADR: TStringField;
    cdsRGruLIM_COTA: TStringField;
    cdsRGruPRIM_REU: TDateField;
    cdsRGruSIT_GRU: TStringField;
    cdsRGruSEQ: TStringField;
    cdsRGruCOTA: TStringField;
    cdsRGruNOME: TStringField;
    cdsRGruLIN_MOD: TStringField;
    cdsRGruSIT_COBR: TStringField;
    cdsRGruPERPAGO: TFloatField;
    cdsRGruDT_ADES: TDateField;
    cdsRGruTP_CONTE: TStringField;
    cdsRGruDT_CONTE: TDateField;
    cdsRGruDT_ENTRE: TDateField;
    cdsRGruPerDev: TFloatField;
    sqlPen: TZQuery;
    cdsPen: TZQuery;
    cdsPenGRUPO: TStringField;
    cdsPenCOTA: TStringField;
    cdsCobPCNOR: TFloatField;
    cdsCobP_RATEIO: TFloatField;
    cdsPenNOME: TStringField;
    cdsPenCIDADE: TStringField;
    cdsPenESTADO: TStringField;
    cdsPenTELEFONE: TStringField;
    cdsPenPCPAG: TFloatField;
    cdsPenPCDEV: TFloatField;
    cdsPenSIT_COBR: TStringField;
    cdsPenTP_CONTE: TStringField;
    cdsPenDT_CONTE: TDateField;
    cdsPenDT_ENTRE: TDateField;
    cdsPenLIN_MOD: TStringField;
    cdsPenTAXAS: TFloatField;
    cdsPenSIGLA1: TStringField;
    cdsPenD_VENCTO: TDateField;
    cdsPenPCNOR: TFloatField;
    cdsPenP_RATEIO: TFloatField;
    cdsPenFIL_COM: TStringField;
    cdsPenBEM: TStringField;
    cdsRelPend: TZQuery;
    cdsRelPendGrupo: TStringField;
    cdsRelPendCota: TStringField;
    cdsRelPendNome: TStringField;
    cdsRelPendCidade: TStringField;
    cdsRelPendFone: TStringField;
    cdsRelPendPcPago: TFloatField;
    cdsRelPendPcDev: TFloatField;
    cdsRelPendSitCob: TStringField;
    cdsRelPendBem: TStringField;
    cdsRelPendTpCont: TStringField;
    cdsRelPendDtCont: TStringField;
    cdsRelPendDtEntr: TStringField;
    cdsRelPendTpPen: TStringField;
    cdsRelPendVencto: TStringField;
    cdsRelPendVlBem: TFloatField;
    cdsRelPendPcNormal: TFloatField;
    cdsRelPendPcRat: TFloatField;
    cdsRelPendVlPend: TFloatField;
    cdsRelPendVlMul: TFloatField;
    cdsRelPendVlJur: TFloatField;
    cdsRelPendVlTot: TFloatField;
    cdsRelPendReu: TStringField;
    cdsPenVALOR: TFloatField;
    cdsPagP_RATEIO: TFloatField;
    QryMoeda: TSQLQuery;
    QryMoedaCODIGO: TIntegerField;
    QryMoedaDCINTSING: TStringField;
    QryMoedaDCINTPLURAL: TStringField;
    QryMoedaDCDECSING: TStringField;
    QryMoedaDCDECPLURAL: TStringField;
    QryMoedaDTINI: TDateField;
    QryMoedaDTFIM: TDateField;
    QryMoedaFATOR: TFloatField;
    QryMoedaSIMBOLO: TStringField;
    qryURV: TSQLQuery;
    qryURVMOEDA: TStringField;
    qryURVDATA: TDateField;
    qryURVCOTACAO: TFloatField;
    cdsRelPendVlMulJur: TFloatField;
    cdsCotPreRat: TFloatField;
    cdsDevCon: TZQuery;
    cdsDevConPcLiq: TFloatField;
    cdsDevConVlCorr: TFloatField;
    cdsDevConVlRed: TFloatField;
    cdsDevConTxDev: TFloatField;
    cdsDevConTxRec: TFloatField;
    cdsDevConTxRecolher: TFloatField;
    cdsDevConTx50: TFloatField;
    cdsDevConVlRes: TFloatField;
    dstPnd: TZQuery;
    dstPndGRUPO: TStringField;
    dstPndSEQ: TStringField;
    dstPndCOTA: TStringField;
    dstPndAVISO: TStringField;
    dstPndTIPO_MOV: TStringField;
    dstPndD_VENCTO: TDateField;
    dstPndAG_COBRA: TStringField;
    dstPndP_NORMAL: TFloatField;
    dstPndP_DIFER: TFloatField;
    dstPndP_RATEIO: TFloatField;
    dstPndP_SUBST: TFloatField;
    dstPndF_AQUISI: TFloatField;
    dstPndADMINIST: TFloatField;
    dstPndF_RESERV: TFloatField;
    dstPndOUTROS: TFloatField;
    dstPndNR_EXTER: TStringField;
    dstPndDT_BASE: TDateField;
    dstPndP_ANTEC: TFloatField;
    dstPndSEG_OUT: TStringField;
    dstPndDATA_EMI: TDateField;
    dstPndUSUARIO: TStringField;
    dstPndD_ATUALI: TDateField;
    dstPndTP_ABONO: TStringField;
    dstPndMUL_JUR: TFloatField;
    dstPndCOBRADOR: TStringField;
    dstPndTAR_BANC: TFloatField;
    dstPndAV_ASSOC: TStringField;
    dstPndFILLER: TStringField;
    dstPndADM_DESC: TFloatField;
    cdsPnd: TZQuery;
    cdsPndGRUPO: TStringField;
    cdsPndSEQ: TStringField;
    cdsPndCOTA: TStringField;
    cdsPndAVISO: TStringField;
    cdsPndTIPO_MOV: TStringField;
    cdsPndD_VENCTO: TDateField;
    cdsPndAG_COBRA: TStringField;
    cdsPndP_NORMAL: TFloatField;
    cdsPndP_DIFER: TFloatField;
    cdsPndP_RATEIO: TFloatField;
    cdsPndP_SUBST: TFloatField;
    cdsPndF_AQUISI: TFloatField;
    cdsPndADMINIST: TFloatField;
    cdsPndF_RESERV: TFloatField;
    cdsPndOUTROS: TFloatField;
    cdsPndNR_EXTER: TStringField;
    cdsPndDT_BASE: TDateField;
    cdsPndP_ANTEC: TFloatField;
    cdsPndSEG_OUT: TStringField;
    cdsPndDATA_EMI: TDateField;
    cdsPndUSUARIO: TStringField;
    cdsPndD_ATUALI: TDateField;
    cdsPndTP_ABONO: TStringField;
    cdsPndMUL_JUR: TFloatField;
    cdsPndCOBRADOR: TStringField;
    cdsPndTAR_BANC: TFloatField;
    cdsPndAV_ASSOC: TStringField;
    cdsPndFILLER: TStringField;
    cdsPndADM_DESC: TFloatField;
    QryTmv: TSQLQuery;
    QryTmvCOD_MOV: TStringField;
    QryTmvDESCRIC: TStringField;
    QryTmvPEDE_CT: TStringField;
    QryTmvSAL_GRU: TStringField;
    QryTmvSAL_CT: TStringField;
    QryTmvTEM_SUB: TStringField;
    QryTmvTEM_ANT: TStringField;
    QryTmvTEM_NOR: TStringField;
    QryTmvTEM_DIF: TStringField;
    QryTmvTEM_RAT: TStringField;
    QryTmvF_AQUISI: TStringField;
    QryTmvADMINIST: TStringField;
    QryTmvF_RESERV: TStringField;
    QryTmvOUTROS: TStringField;
    QryTmvMUL_JUR: TStringField;
    QryTmvCOD_BACE: TStringField;
    QryTmvACU_BACE: TStringField;
    QryTmvVAL_ENTR: TStringField;
    QryTmvDT_ENTR: TStringField;
    QryTmvENT_COBR: TStringField;
    QryTmvCATEGOR: TStringField;
    QryTmvSEG_OUT: TStringField;
    QryTmvSIGLA1: TStringField;
    QryTmvSIGLA2: TStringField;
    QryTmvCOM_VEND: TStringField;
    QryTmvCOM_COMP: TStringField;
    QryTmvLISTA_CC: TStringField;
    QryTmvSTATUS: TStringField;
    QryTmvDT_APRO: TStringField;
    QryTmvTRAT_IDE: TStringField;
    QryTmvTP_MV_OR: TStringField;
    QryTmvPEDE_VEN: TStringField;
    QryTmvCOM_COBR: TStringField;
    QryTmvADIANTAM: TStringField;
    QryTmvREC_ADM: TStringField;
    QryTmvSERVICO: TStringField;
    cdsCobTIPO_MOV: TStringField;
    cdsPenMUL_JUR: TStringField;
    dstMvt: TZQuery;
    dstMvtGRUPO: TStringField;
    dstMvtSEQ: TStringField;
    dstMvtCOTA: TStringField;
    dstMvtAVISO: TStringField;
    dstMvtTIPO_MOV: TStringField;
    dstMvtD_VENCTO: TDateField;
    dstMvtDT_PAGTO: TDateField;
    dstMvtD_CONTAB: TDateField;
    dstMvtDT_APROP: TDateField;
    dstMvtAG_FINAN: TStringField;
    dstMvtNR_DOCUM: TStringField;
    dstMvtP_NORMAL: TFloatField;
    dstMvtP_DIFER: TFloatField;
    dstMvtP_RATEIO: TFloatField;
    dstMvtP_SUBST: TFloatField;
    dstMvtP_ANTEC: TFloatField;
    dstMvtF_AQUISI: TFloatField;
    dstMvtADMINIST: TFloatField;
    dstMvtF_RESERV: TFloatField;
    dstMvtOUTROS: TFloatField;
    dstMvtMUL_JUR: TFloatField;
    dstMvtRECIBO: TStringField;
    dstMvtSAL_GRU: TStringField;
    dstMvtSAL_CT: TStringField;
    dstMvtTP_PERC: TStringField;
    dstMvtDT_BASE: TDateField;
    dstMvtSEG_OUT: TStringField;
    dstMvtAV_V_COB: TStringField;
    dstMvtCONTABIL: TStringField;
    dstMvtBEM: TStringField;
    dstMvtP_IDEAL: TFloatField;
    dstMvtTP_SEGUR: TStringField;
    dstMvtSTATUS: TStringField;
    dstMvtUSUARIO: TStringField;
    dstMvtD_ATUALI: TDateField;
    dstMvtDT_ASSOC: TDateField;
    cdsMvt: TZQuery;
    cdsMvtGRUPO: TStringField;
    cdsMvtSEQ: TStringField;
    cdsMvtCOTA: TStringField;
    cdsMvtAVISO: TStringField;
    cdsMvtTIPO_MOV: TStringField;
    cdsMvtD_VENCTO: TDateField;
    cdsMvtDT_PAGTO: TDateField;
    cdsMvtD_CONTAB: TDateField;
    cdsMvtDT_APROP: TDateField;
    cdsMvtAG_FINAN: TStringField;
    cdsMvtNR_DOCUM: TStringField;
    cdsMvtP_NORMAL: TFloatField;
    cdsMvtP_DIFER: TFloatField;
    cdsMvtP_RATEIO: TFloatField;
    cdsMvtP_SUBST: TFloatField;
    cdsMvtP_ANTEC: TFloatField;
    cdsMvtF_AQUISI: TFloatField;
    cdsMvtADMINIST: TFloatField;
    cdsMvtF_RESERV: TFloatField;
    cdsMvtOUTROS: TFloatField;
    cdsMvtMUL_JUR: TFloatField;
    cdsMvtRECIBO: TStringField;
    cdsMvtSAL_GRU: TStringField;
    cdsMvtSAL_CT: TStringField;
    cdsMvtTP_PERC: TStringField;
    cdsMvtDT_BASE: TDateField;
    cdsMvtSEG_OUT: TStringField;
    cdsMvtAV_V_COB: TStringField;
    cdsMvtCONTABIL: TStringField;
    cdsMvtBEM: TStringField;
    cdsMvtP_IDEAL: TFloatField;
    cdsMvtTP_SEGUR: TStringField;
    cdsMvtSTATUS: TStringField;
    cdsMvtUSUARIO: TStringField;
    cdsMvtD_ATUALI: TDateField;
    cdsMvtDT_ASSOC: TDateField;
    QryRelMov: TSQLQuery;
    CdsRelMov: TZQuery;
    CdsRelMovGRUPO: TStringField;
    CdsRelMovSEQ: TStringField;
    CdsRelMovCOTA: TStringField;
    CdsRelMovNOME: TStringField;
    CdsRelMovTIPO_MOV: TStringField;
    CdsRelMovDESCRIC: TStringField;
    CdsRelMovD_VENCTO: TDateField;
    CdsRelMovDT_PAGTO: TDateField;
    CdsRelMovD_CONTAB: TDateField;
    CdsRelMovP_NORMAL: TFloatField;
    CdsRelMovP_RATEIO: TFloatField;
    CdsRelMovVALOR: TFloatField;
    dstPRSULTSAG: TDateField;
    dstPRSNMCONTATO: TStringField;
    dstPRSTELCONTATO: TStringField;
    dstPRSMAILCONTATO: TStringField;
    cdsPRSULTSAG: TDateField;
    cdsPRSNMCONTATO: TStringField;
    cdsPRSTELCONTATO: TStringField;
    cdsPRSMAILCONTATO: TStringField;
    qryPre: TSQLQuery;
    qryPreDT_BASE: TDateField;
    qryPrePRE_TABE: TFloatField;
    cdsPagBEM: TStringField;
    Drft: TRLDraftFilter;
    Pdf: TRLPDFFilter;
    Prvw: TRLPreviewSetup;
    Exp: TRLExpressionParser;
    qryFin: TSQLQuery;
    cdsFin: TZQuery;
    cdsFinGRUPO: TStringField;
    cdsFinSEQ: TStringField;
    cdsFinCOTA: TStringField;
    cdsFinTIPO_MOV: TStringField;
    cdsFinDESCRIC: TStringField;
    cdsFinD_VENCTO: TDateField;
    cdsFinDT_PAGTO: TDateField;
    cdsFinD_CONTAB: TDateField;
    cdsFinF_AQUISI: TFloatField;
    cdsFinADMINIST: TFloatField;
    cdsFinF_RESERV: TFloatField;
    cdsFinOUTROS: TFloatField;
    cdsFinMUL_JUR: TFloatField;
    cdsFinVALOR: TFloatField;
    cdsPagF_AQUISI: TFloatField;
    cdsPagADMINIST: TFloatField;
    cdsPagF_RESERV: TFloatField;
    cdsPagOUTROS: TFloatField;
    cdsPagSIMBOLO: TStringField;
    cdsPagHISTORIC: TStringField;
    cdsPagTIPO_MOV: TStringField;
    cdsCobOUTROS: TFloatField;
    cdsConsGRUPO: TStringField;
    cdsConsSEQ: TStringField;
    cdsConsCOTA: TStringField;
    cdsConsCGC_CPF: TStringField;
    cdsConsPESS_F_J: TStringField;
    cdsConsNOME: TStringField;
    cdsConsSIT_COBR: TStringField;
    cdsPagD_CONTAB: TDateField;
    cdsCobF_AQUISI: TFloatField;
    cdsCobF_RESERV: TFloatField;
    cdsCobADMINIST: TFloatField;
    dstPRSSTRLIB: TStringField;
    cdsPRSSTRLIB: TStringField;
    Ttcotafcadm: Tfloatfield;
    Ttcotafcaqui: Tfloatfield;
    Ttcotafcdev: Tfloatfield;
    Ttcotafdres: Tfloatfield;
    Ttcotaraadm: Tfloatfield;
    Ttcotaraaqui: Tfloatfield;
    Ttcotaradev: Tfloatfield;
    Ttcotaslddev: Tfloatfield;
    Ttcotattadm: Tfloatfield;
    Ttcotattjur: Tfloatfield;
    Ttcotattmul: Tfloatfield;
    Ttcotattmulpg: Tfloatfield;
    Ttcotattpag: Tfloatfield;
    Ttcotattpcnor: Tfloatfield;
    Ttcotattpcrat: Tfloatfield;
    Ttcotattpend: Tfloatfield;
    Ttcotattper: Tfloatfield;
    Ttcotattrat: Tfloatfield;
    Ttcotattreal: Tfloatfield;
    Ttcotattres: Tfloatfield;
    Ttcotatttot: Tfloatfield;
    Ttgrubemapreendido: Tfloatfield;
    Ttgruqtdinacota: Tlongintfield;
    Ttgruqtdinagru: Tlongintfield;
    Ttgruqtdrnpcota: Tlongintfield;
    Ttgruqtdrnpgru: Tfloatfield;
    Ttgruvlrina: Tfloatfield;
    Ttgruvlrjuridico: Tfloatfield;
    Ttgruvlrmediacao: Tfloatfield;
    Ttgruvlrrnp: Tfloatfield;
    Zquery1: Tzquery;
    procedure cdsConsCGC_CPFGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsCotCGC_CPFGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsRelPendCalcFields(DataSet: TDataSet);
    procedure cdsRGruCalcFields(DataSet: TDataSet);
    procedure cdsCreFORNECGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsCotCalcFields(DataSet: TDataSet);
    procedure cdsCotSEXOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsCotFIL_FISCGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsCotSIT_COBRGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsCotREPRESGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsCotPESS_F_JGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsCotPROFISSGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsCotE_CIVILGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsCotAfterScroll(DataSet: TDataSet);
    procedure cdsAgePRIORIDADEGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure cdsAgeSTATUSGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure Datamodulecreate(Sender: Tobject);
  private
    { Private declarations }
    FEmpresa: iControllerEmpresa;
    const
      SQLUMACOTA : string =
            'select * from ACCLI where grupo=%s and seq=%s and cota=%s' ;
      SQLFAIXAGRUPOS: string =
    'select * from ACCLI where grupo between %s and %s order by grupo,seq,cota';
  public
    { Public declarations }
    UsuCod : Integer;
    UsuNom : String;
    UsuFig : String;
    UsuAdm : Integer;
    function GeraCod(Cam,Tab:String):Integer;
    function CalcJur(Dtv,Dth:TDate;Vlr:Double):Double;
    function NumeroParaExtenso(parmNumero: Real): string;
    function ConversaoRecursiva(N: LongWord): string;
    function PesqTab(Tab, Cod: string): string;
    function PesqFil(Fil:string):string;
    function PosGru(Gru:string):boolean;
    function PosCot(Gru, Seq, Cot: string): Boolean;
    procedure ImprimirRelatorio(Tit, Rel: string);
    function SugerirGrupo:string;
    function PosicionarFaixaGrupos(GrIni, GrFim, si, sf: string): Boolean;
    function PosicionarPendencia(GrIni, GrFim, si, sf: string): Boolean;
    function PosicionarReuniao(DtReu: TDateTime): boolean;
    function ObterValorBemNaData(DtPreco: TDateTime): Double; overload;
    function ObterValorBemNaData(Fil, Bem: string; DtPreco: TDateTime): Double; overload;
    function CalcularJuros(DtVenc: TDateTime; VlPrin: Double; DtAtual: TDateTime): Double;
    function CalcularMulta(DtVenc: TDateTime; VlPrin: Double; DtAtual: TDateTime): Double;
    function ConverterReal(DtMoeda: TDate; Vlr: Double): Double;
    procedure PosicionarMoeda(DtMoeda: TDate);
    function AcharCotacaoURV(DtMoeda: TDate): Double;
    function PosicionarPnd(Grupo,Cota,Aviso: string): Boolean;
    function ObterNovoAviso(Grupo, Seq, Cota: string): string;
    procedure PosiconarTmv(Cod: string);
    procedure AtualizarPercentualPago(Gru, Seq, Cota: string; Cpo: Integer; Pc: Double);
    function AvisoExisteEmAcmov(Gru, Seq, Cota, Aviso: string): Boolean;
    function PosicionarRelMov(Dt1, Dt2: TDateTime): Boolean;
    function PosicionarCdsFin(Dt1, Dt2: TDateTime): Boolean;
    procedure AbrirQryPre(Bem, Fil: string;DtBase:TDateTime);
    function ObterDescricaoBem(Bem: string): string;
    procedure ExecutarSQL(strSQL: string);
    function PosicionarMvt(Gru, Seq, Cot, Avi: string):Boolean;
    procedure AtualizarVlrAtualPendencia(Gru, Seq, Cot: string);
    function DeprecatedMontarPagamentos(pGrupo, pSeq, pCota: String): TDataSet;
    function DeprecatedMontarPendencias(pGrupo, pSeq, pCota: String): TDataSet;
    function DeprecatedTotalizarPagamentosPendencias: TDataSet;
    function DeprecatedCalcularSaldoDevedor(pCliente: iControllerCota): TDataSet;
    function DeprecatedMontarinadimplentesgruposencerrados: Tdataset;
    function DeprecatedMontarRnp: Tdataset;
    function DeprecatedMontarcontacorrentedevolucao(Pgrupo, Pseq, Pcota: String; Pdatalimite: Tdatetime): Tdataset;
    procedure DeprecatedIncluirComissaoPermanencia(var pInicio: Boolean; pGrupo, pSeq, pCota, pNome: String; pData: TDateTime; pSaldo, pValor: Double);
  end;

var
  DM: TDM;

const
  MASK_DATA_ANO2 = 'dd/mm/yy';
  MASK_DATA_ANO4 = 'dd/mm/yyyy';

implementation

uses DateUtils, Math,  cobcons.controller.factory,
  cobcons.controller.util, cobcons.view.lista;

{$R *.lfm}


function Tdm.Geracod(Cam, Tab: String): Integer;
begin
     ExecutarSQL('select max('+Cam+') from '+Tab);
     if sqlCom.IsEmpty
     then Result := 1
     else Result := sqlCom.Fields[0].AsInteger + 1;
end;


procedure Tdm.Imprimirrelatorio(Tit, Rel: String);
begin
  //RvPrj.ProjectFile := ExtractFilePath(Application.ExeName)+'Cons.rav';
  //RvPrj.Open;
  //RvPrj.SetParam('Titulo',Tit);
  //RvPrj.ExecuteReport(Rel);
  //RvPrj.Close;
end;


procedure Tdm.Cdsconscgc_cpfgettext(Sender: Tfield;
  var Text: String; Displaytext: Boolean);
begin
  if cdsConsPESS_F_J.Value = 'F'
  then Text := copy(cdsConsCGC_CPF.Value,2,3)+'.'+
          copy(cdsConsCGC_CPF.Value,5,3)+'.'+copy(cdsConsCGC_CPF.Value,8,3)+'-'+
          copy(cdsConsCGC_CPF.Value,15,2)
  else Text := copy(cdsConsCGC_CPF.Value,3,2)+'.'+
          copy(cdsConsCGC_CPF.Value,5,3)+'.'+copy(cdsConsCGC_CPF.Value,8,3)+'/'+
          copy(cdsConsCGC_CPF.Value,11,4)+'-'+copy(cdsConsCGC_CPF.Value,15,2);

end;

procedure Tdm.Cdscotafterscroll(Dataset: Tdataset);
begin
     if cdsCotPESS_F_J.Value = 'F'
     then cdsCotCGC_CPF.EditMask := '999\.999\.999\-99;0;_'
     else cdsCotCGC_CPF.EditMask := '99\.999\.999\/9999\-99;0;_';
end;

procedure Tdm.Cdscotcalcfields(Dataset: Tdataset);
begin
   cdsCotPerPago.Value := cdsCotP_NO_PAG.Value + cdsCotP_AN_PAG.Value +
                          cdsCotP_SU_PAG.Value;
   cdsCotPerDev.Value := 100 - cdsCotPerPago.Value;
   cdsCotPreRat.Value := cdsCotP_RATEAD.Value - cdsCotP_RA_PAG.Value;
end;

procedure Tdm.Cdscotcgc_cpfgettext(Sender: Tfield;
  var Text: String; Displaytext: Boolean);
begin
  if cdsCotPESS_F_J.Value = 'F'
  then Text := copy(cdsCotCGC_CPF.Value,2,3)+'.'+
          copy(cdsCotCGC_CPF.Value,5,3)+'.'+copy(cdsCotCGC_CPF.Value,8,3)+'-'+
          copy(cdsCotCGC_CPF.Value,15,2)
  else Text := copy(cdsCotCGC_CPF.Value,3,2)+'.'+
          copy(cdsCotCGC_CPF.Value,5,3)+'.'+copy(cdsCotCGC_CPF.Value,8,3)+'/'+
          copy(cdsCotCGC_CPF.Value,11,4)+'-'+copy(cdsCotCGC_CPF.Value,15,2);

end;

procedure Tdm.Cdscote_civilgettext(Sender: Tfield;
  var Text: String; Displaytext: Boolean);
begin
  Text := PesqTab('005',cdsCotE_CIVIL.Value);
end;

procedure Tdm.Cdscotfil_fiscgettext(Sender: Tfield;
  var Text: String; Displaytext: Boolean);
begin
  Text := PesqFil((Sender as TStringField).AsString);
end;

procedure Tdm.Abrirqrypre(Bem, Fil: String; Dtbase: Tdatetime);
begin
  with qryPre do begin
    Close;
    Params[0].Value := Bem;
    Params[1].Value := Fil;
    Params[2].Value := DtBase;
    Open;
  end;
end;

function Tdm.Acharcotacaourv(Dtmoeda: Tdate): Double;
begin
  with qryURV do begin
    Close;
    Params[0].Value := DtMoeda;
    Open;
    Result := qryURVCOTACAO.Value;
  end;
end;

procedure Tdm.Atualizarpercentualpago(Gru, Seq, Cota: String; Cpo: Integer; Pc: Double);
var
  Campo, strSQL: string;
  SeparadorDecimal: char;
begin
  SeparadorDecimal := DecimalSeparator;
  DecimalSeparator := '.';
  if cpo = 0
  then Campo := 'p_no_pag'
  else Campo := 'p_ra_pag';
  strSQL := Format(
      'update ACCLI set %s=%s+%f where grupo=%s and seq=%s and cota=%s',
      [Campo,Campo,Pc,QuotedStr(Gru),QuotedStr(Seq),QuotedStr(Cota)]);
  ExecutarSQL(strSQL);
  DecimalSeparator := SeparadorDecimal;
end;

procedure Tdm.Atualizarvlratualpendencia(Gru, Seq, Cot: String);
var
  tmv: integer;
  fator, valbem: Double;
begin
  DM.sdsPre.First;
  valbem := DM.sdsPrePRE_TABE.Value;
  while not cdsCob.Eof do begin
    if PosicionarPnd(Gru, Cot, cdsCobAviso.VALUE) then begin
      cdsPnd.Edit;
      if cdsCobTIPO_MOV.Value='01' then begin
        cdsPndF_AQUISI.Value := cdsCobPCNOR.Value * valbem / 100;
        cdsPndADMINIST.Value := cdsPndF_AQUISI.Value * cdsCotP_ADMINS.Value / 100;
        cdsPndF_RESERV.Value := cdsPndF_AQUISI.Value * cdsCotP_RESERV.Value / 100;
      end
      else if cdsCobTIPO_MOV.Value='SR'
      then cdsPndF_AQUISI.Value := cdsPndP_NORMAL.Value * valbem / 100
      else if cdsCobTIPO_MOV.Value='04' then begin
        cdsPndF_AQUISI.Value := cdsCobP_RATEIO.Value * valbem / 100;
        cdsPndADMINIST.Value := cdsPndF_AQUISI.Value * cdsCotP_ADMINS.Value / 100;
      end;
      cdsPnd.Post;
      //cdsPnd.ApplyUpdates(0);
    end;
    cdsCob.Next;
  end;
  cdsCot.Refresh;
end;

function Tdm.Deprecatedmontarpagamentos(Pgrupo, Pseq, Pcota: String): Tdataset;
const
  TIPOS_TRATADOS = '21|C1|73|H3|83|I3|71|H1|82|I2';
var
  tMov: Integer;
  vReu : TDataset;
  vPagamentos: iControllerPagamentos;
  vReuniao: iControllerReuniao;
  vPreco: iControllerPrecoBem;
begin

  vReuniao := TControllerFactory.New.Reuniao;
  vPagamentos := TControllerFactory.New.Pagamentos;
  vPreco := TControllerFactory.New.PrecoBem;

  vPagamentos.RetornaPagamentosCota(Pgrupo, Pseq, Pcota);

  cdsMov.Close;
  cdsMov.CreateDataset;

  while vPagamentos.TemDados do begin
    cdsMov.Append;

    vReu := vReuniao
               .RetornaReuniaoPagamento(Pgrupo, vPagamentos.DT_PAGTO)
               .Dataset;

    if not vReu.EOF then begin
      cdsMovReu.Value := vReu.FieldByName('NRO_REU').AsString;
      cdsMovDtReu.Value := RetornaDataString(vReu.FieldByName('DATA_REU').AsDateTime, MASK_DATA_ANO2);
      cdsMovVlBem.Value := vPreco.RetornaPrecoBemData( vPagamentos.BEM,
                                                       vPagamentos.FIL_COM,
                                                       vReu.FieldByName('DATA_REU').AsDateTime)
                                                       .PRE_REAL;
    end
    else begin
      cdsMovReu.Value := '999';
      cdsMovDtReu.Value := '';
      cdsMovVlBem.Value := vPreco.RetornaPrecoBemData( vPagamentos.BEM,
                                                       vPagamentos.FIL_COM,
                                                       vPagamentos.DT_PAGTO).PRE_REAL;
    end;

    cdsMovAviso.Value := vPagamentos.AVISO;
    cdsMovTipo.Value := vPagamentos.DCTIPOMOV;
    Cdsmovtpmov.AsString := vPagamentos.TIPO_MOV;
    cdsMovSimb.Value := vPagamentos.SIMBOLO;

    cdsMovDtCtb.Value := FormatDateTime(MASK_DATA_ANO2, vPagamentos.D_CONTAB);
    cdsMovPagto.Value := FormatDateTime(MASK_DATA_ANO2, vPagamentos.DT_PAGTO);

    tMov := Pos(vPagamentos.TIPO_MOV, TIPOS_TRATADOS);

    case tMov of
      // ------------------------------------------------- 21|C1 apreensão e estorno
      1, 4: cdsMovHist.Value := Format('VLR %8.2n %s',
                 [ vPagamentos.VALOR, vPagamentos.HISTORIC ]);
      // --------------------------------------- 73|H3 credito e estorno crédito de perc
      7, 10: begin
        cdsMovVencto.Value := FormatDateTime(MASK_DATA_ANO2, vPagamentos.D_VENCTO);
        cdsMovPer.Value := vPagamentos.P_NORMAL +
                           vPagamentos.P_DIFER +
                           vPagamentos.P_ANTEC;
        cdsMovRat.Value := vPagamentos.P_RATEIO;
        cdsMovHist.Value := vPagamentos.HISTORIC;
      end;
      // ----------------------- 83|I3 credito e estorno debito de perc
      13, 16: begin
        cdsMovVencto.Value := FormatDateTime(MASK_DATA_ANO2, vPagamentos.D_VENCTO);
        cdsMovPer.Value := vPagamentos.P_NORMAL +
                           vPagamentos.P_DIFER +
                           vPagamentos.P_ANTEC;
        cdsMovRat.Value := vPagamentos.P_RATEIO;
        cdsMovHist.Value := vPagamentos.HISTORIC;
      end;
      // ------------------------  71|H1 credito e estorno credito troca bem
      19, 22: begin
        cdsMovVencto.Value := FormatDateTime(MASK_DATA_ANO2, vPagamentos.D_VENCTO);
        cdsMovPer.Value := vPagamentos.P_NORMAL +
                           vPagamentos.P_DIFER +
                           vPagamentos.P_ANTEC;
        cdsMovRat.Value := vPagamentos.P_RATEIO;
        cdsMovHist.Value := 'TROCA DE BEM '+ vPagamentos.HISTORIC;
      end;
      // -------------------- credito e estorno credito troca bem
      23, 28: begin
        cdsMovVencto.Value := FormatDateTime(MASK_DATA_ANO2, vPagamentos.D_VENCTO);
        cdsMovPer.Value := vPagamentos.P_NORMAL +
                           vPagamentos.P_DIFER +
                           vPagamentos.P_ANTEC;
        cdsMovRat.Value := vPagamentos.P_RATEIO;
        cdsMovHist.Value := 'TROCA DE BEM '+ vPagamentos.HISTORIC;
      end;
      else begin
        cdsMovVencto.Value := FormatDateTime(MASK_DATA_ANO2, vPagamentos.D_VENCTO);
        cdsMovPer.Value := vPagamentos.P_NORMAL +
                           vPagamentos.P_DIFER +
                           vPagamentos.P_ANTEC;
        cdsMovRat.Value := vPagamentos.P_RATEIO;
        cdsMovVlPag.Value := vPagamentos.F_AQUISI;
        cdsMovMulJu.Value := vPagamentos.MUL_JUR;
        cdsMovVlTot.Value := vPagamentos.VALOR +
                             vPagamentos.MUL_JUR;
        cdsMovVlReal.Value := vPagamentos.VALOR;
        cdsMovDcBem.Value :=  vPagamentos.DCBEM;
        cdsMovTxAdm.Value := vPagamentos.ADMINIST;
        cdsMovFdRes.Value := vPagamentos.F_RESERV;
        cdsMovOutros.Value := vPagamentos.OUTROS;
        cdsMovHist.Value := vPagamentos.HISTORIC;
      end;
    end;
    cdsMov.Post;
    vPagamentos.Proximo;
  end;
  cdsMov.First;
  Result := cdsMov;
end;

function Tdm.Deprecatedmontarpendencias(Pgrupo, Pseq, Pcota: String): Tdataset;
var
  vCob,
  vReu: TDataset;
  vReuniao: iControllerReuniao;
  vPreco: iControllerPrecoBem;
begin
  vReuniao := TControllerFactory.New.Reuniao;
  vPreco := TControllerFactory.New.PrecoBem;
  vCob := TControllerFactory.New.Pendencia
               .RetornaPendenciaCota(Pgrupo, Pseq, Pcota)
               .DataSet;

  cdsCb1.Close;
  cdsCb1.CreateDataset;

  vCob.First;

  while not vCob.Eof do begin
    cdsCb1.Append;

    vReu := vReuniao
               .RetornaReuniaoPagamento(Pgrupo, vCob.FieldByName('D_VENCTO').AsDateTime)
               .Dataset;


    if not vReu.EOF
    then cdsCb1Reu.Value := vReu.FieldByName('NRO_REU').AsString
    else cdsCb1Reu.Value := '999';

    cdsCb1Aviso.Value := vCob.FieldByName('AVISO').AsString;
    cdsCb1Vencto.Value := RetornaDataString(vCob.FieldByName('D_VENCTO').AsDateTime, MASK_DATA_ANO2);
    cdsCb1TpPen.Value := vCob.FieldByName('DCTIPOMOV').AsString;
    cdsCb1VlBem.Value := vPreco.RetornaPrecoBemData(
                                       vCob.FieldByName('BEM').AsString,
                                       vCob.FieldByName('FIL_COM').AsString,
                                       Date).PRE_REAL; // valor atual do bem
    cdsCb1PcNormal.Value := vCob.FieldByName('PCNOR').AsFloat;
    cdsCb1PcRat.Value := vCob.FieldByName('P_RATEIO').AsFloat;
    cdsCb1VPend.Value := vCob.FieldByName('VALOR').AsFloat;
//    if (cdsCb1PcNormal.Value + cdsCb1PcRat.Value) > 0 then begin
//      if QryTmvCOD_MOV.Value='SR'
//      then cdsCb1VPend.Value := cdscob cdsCb1VlBem.Value * (cdsCb1PcNormal.Value + cdsCb1PcRat.Value) / 100
//      else begin
//        cdsCb1VPend.Value := cdsCb1VlBem.Value * (cdsCb1PcNormal.Value + cdsCb1PcRat.Value) / 100;
//        cdsCb1VPend.Value :=  cdsCb1VPend.Value * (1 + ((cdsCotP_ADMINS.Value + cdsCotP_RESERV.Value)/100));
//        cdsCb1VPend.Value := cdsCb1VPend.Value + cdsCobOUTROS.Value;
//      end;
//    end
//    else
//    if (QryTmvCOD_MOV.Value<>'SR') and (QryTmvMUL_JUR.Value <> 'N') then begin

    cdsCb1VlMul.Value := 0;
    cdsCb1VlJur.Value := 0;
    if (vCob.FieldByName('MUL_JUR').AsString <> 'N') then begin
      cdsCb1VlMul.Value := CalcularMulta( vCob.FieldByName('D_VENCTO').AsDateTime,
                                          cdsCb1VPend.Value, Date);
      cdsCb1VlJur.Value := CalcularJuros( vCob.FieldByName('D_VENCTO').AsDateTime,
                                          cdsCb1VPend.Value, Date);
    end;
    cdsCb1VlTot.Value := cdsCb1VPend.Value + cdsCb1VlMul.Value + cdsCb1VlJur.Value;
    cdsCb1VlMulJur.Value := cdsCb1VlMul.Value + cdsCb1VlJur.Value;
    cdsCb1.Post;
    vCob.Next;
  end;
  cdsCb1.First;
  Result := cdsCb1;
end;

function Tdm.Deprecatedtotalizarpagamentospendencias: Tdataset;
const
  MOV_ENTREGA_BEM = '41|42|E1|E2';
var
  ttPcNor, ttPcRat, ttPend,
  ttMul, ttJur, ttTot,
  ttPer, ttRat, ttPag,
  ttRes, ttAdm, ttMulpg,
  ttReal: Double;
begin

  ttPcNor := 0;
  ttPcRat := 0;
  ttPend := 0;
  ttMul := 0;
  ttJur := 0;
  ttTot := 0;
  ttPer := 0;
  ttRat := 0;
  ttPag := 0;
  ttRes := 0;
  ttAdm := 0;
  ttMulpg := 0;
  ttReal := 0;

  if cdsMov.Active
  then  begin
    cdsMov.First;
    while not cdsMov.EOF do
    begin
      if Pos(Cdsmovtpmov.AsString, MOV_ENTREGA_BEM) = 0
      then begin
        ttPer := ttPer + cdsMovPer.AsFloat;
        ttRat := ttRat + cdsMovRat.AsFloat;
        ttPag := ttPag + cdsMovVlPag.AsFloat;
        ttRes := ttRes + cdsMovFdRes.AsFloat;
        ttAdm := ttAdm + cdsMovTxAdm.AsFloat;
        ttMulpg := ttMulpg + cdsMovMulju.AsFloat;
        ttReal := ttReal + cdsMovVlReal.AsFloat;
      end;
      cdsMov.Next;
    end;
    cdsMov.First;
  end;

  if cdsCb1.Active
  then begin
    cdsCb1.First;
    while not cdsCb1.EOF do
    begin
      ttPcNor := ttPcNor + cdsCb1PcNormal.AsFloat;
      ttPcRat := ttPcRat + cdsCb1PcRat.AsFloat;
      ttPend := ttPend + cdsCb1VPend.AsFloat;
      ttMul := ttMul + cdsCb1VlMul.AsFloat;
      ttJur := ttJur + cdsCb1VlJur.AsFloat;
      ttTot := ttTot + cdsCb1VlTot.AsFloat;
      cdsCb1.Next;
    end;
    cdsCb1.First;
  end;

  ttCota.Close;
  ttCota.CreateDataset;

  ttCota.Append;
  Ttcotattpcnor.AsFloat := ttPcNor;
  Ttcotattpcrat.AsFloat := ttPcRat;
  Ttcotattpend.AsFloat := ttPend;
  Ttcotattmul.AsFloat := ttMul;
  Ttcotattjur.AsFloat := ttJur;
  Ttcotatttot.AsFloat := ttTot;
  Ttcotattper.AsFloat := ttPer;
  Ttcotattrat.AsFloat := ttRat;
  Ttcotattpag.AsFloat := ttPag;
  Ttcotattres.AsFloat := ttRes;
  Ttcotattadm.AsFloat := ttAdm;
  Ttcotattmulpg.AsFloat := ttMulpg;
  Ttcotattreal.AsFloat := ttReal;
  ttCota.Post;
  Result := ttCota;
end;

function Tdm.Deprecatedcalcularsaldodevedor(Pcliente: Icontrollercota): Tdataset;
var
  vFcAqui, vFcAdm, vFdRes,
  vRaAqui, vRaAdm, vFcDev, vRaDev: Double;
begin
  vFcAqui := Pcliente.PERDEV * Pcliente.PRE_TABE / 100;
  vFcAdm := vFcAqui * Pcliente.P_ADMINS / 100;
  vFdRes := vFcAqui * Pcliente.P_RESERV / 100;
  vRaAqui := Pcliente.PERRAT * Pcliente.PRE_TABE / 100;
  vRaAdm := vRaAqui * Pcliente.P_ADMINS / 100;
  vFcDev := vFcAqui + vFcAdm + vFdRes;
  vRaDev := vRaAqui + vRaAdm;
  if not ttCota.Active
  then begin
    ttCota.CreateDataset;
    ttCota.Append;
  end
  else ttCota.Edit;
  Ttcotafcaqui.AsFloat := vFcAqui;
  Ttcotafcadm.AsFloat := vFcAdm;
  Ttcotafdres.AsFloat := vFdRes;
  Ttcotaraaqui.AsFloat := vRaAqui;
  Ttcotaraadm.AsFloat := vRaAdm;
  Ttcotafcdev.AsFloat := vFcDev;
  Ttcotaradev.AsFloat := vRaDev;
  Ttcotaslddev.AsFloat := vFcDev + vRaDev;
  ttCota.Post;
  Result := ttCota;
end;

function Tdm.Deprecatedmontarinadimplentesgruposencerrados: Tdataset;
var
  vVlBem,
  vVlApr,
  vVlDev: Double;
  vCotasInadimplentes: iControllerCota;
  vPagamentos: iControllerPagamentos;
  vPreco: iControllerPrecoBem;
  vInadimplentes: iControllerInadimplente;
begin
  ttGru.Close;
  ttGru.CreateDataset;
  ttGru.Append;
  Ttgruqtdinagru.AsInteger := 0;
  Ttgruqtdinacota.AsInteger := 0;
  Ttgruvlrjuridico.AsFloat := 0.0;
  Ttgruvlrina.AsFloat := 0.0;
  Ttgruvlrmediacao.AsFloat := 0.0;
  Ttgrubemapreendido.AsFloat := 0.0;
  ttGru.Post;
  gru.Close;
  gru.CreateDataset;
  ina.Close;
  ina.CreateDataset;
  vPagamentos := TControllerFactory.New.Pagamentos;
  vPreco := TControllerFactory.New.PrecoBem;
  vInadimplentes := TControllerFactory.New.Inadimplente;
  vCotasInadimplentes := TControllerFactory.New.Cota.RetornaInadimplentes(FEmpresa.STGRUENCCT, FEmpresa.FASEAJUIZ);
  while vCotasInadimplentes.TemDados do
  begin
    vVlApr := vPagamentos
                  .RetornaVlrBemApreendidoCota( vCotasInadimplentes.GRUPO,
                                                vCotasInadimplentes.SEQ,
                                                vCotasInadimplentes.COTA);
    vVlBem := vPreco.RetornaPrecoBemData( vCotasInadimplentes.BEM,
                                          vCotasInadimplentes.FIL_COM,
                                          vCotasInadimplentes.ULTREU).PRE_REAL;
    vVlDev := (vVlBem * vCotasInadimplentes.PERDEV   / 100) +    // devedor fdo comum
              (vVlBem * vCotasInadimplentes.P_RESERV / 100);    // devedor fdo reserva
              //(vVlBem * vCotasInadimplentes.PERRAT / 100);       // devedor de rateio
    if vVlDev > 100
    then begin
      ina.Append;
      Inagrupo.AsString := vCotasInadimplentes.GRUPO;
      Inacota.AsString := vCotasInadimplentes.COTA;
      Inaseq.AsString := vCotasInadimplentes.SEQ;
      Inatprec.AsString := vCotasInadimplentes.TP_PESS;
      Inapfpj.AsString := vCotasInadimplentes.CGCCPFMT;
      Inanome.AsString := vCotasInadimplentes.NOME;
      Inadtenc.AsString := RetornaDataString(vCotasInadimplentes.ULTREU + 120, 'yyyy-mm-dd');
      Inavlrreceber.AsFloat := vVlDev;
      Inapercamort.AsFloat := vCotasInadimplentes.PERCPAGO;
      Inavlrbem.AsFloat := vVlBem;
      Inabemapreendido.AsFloat := vVlApr;
      Inadtajuiz.AsString := RetornaDataString(vCotasInadimplentes.DTAJUIZ, 'yyyy-mm-dd');
      ina.Post;
      ttGru.Edit;
      if gru.Locate('grupo', vCotasInadimplentes.GRUPO,[])
      then gru.Edit
      else begin
        gru.Append;
        Grugrupo.AsString := vCotasInadimplentes.GRUPO;
        Gruqtdina.AsInteger := 0;
        Gruvlrina.AsFloat := 0.0;
        Gruvlrjuridico.AsFloat := 0.0;
        Gruvlrmediacao.AsFloat := 0.0;
        Grubemapreendido.AsFloat := 0.0;
        Ttgruqtdinagru.AsInteger := Ttgruqtdinagru.AsInteger + 1;
      end;
      Gruqtdina.AsInteger := Gruqtdina.AsInteger + 1;
      Ttgruqtdinacota.AsInteger := Ttgruqtdinacota.AsInteger + 1;
      Gruvlrina.AsFloat := Gruvlrina.AsFloat + vVlDev;
      Ttgruvlrina.AsFloat := Ttgruvlrina.AsFloat + vVlDev;
      if vCotasInadimplentes.SIT_COBR = 'J'
      then begin
        Gruvlrjuridico.AsFloat := Gruvlrjuridico.AsFloat + vVlDev;
        Ttgruvlrjuridico.AsFloat := Ttgruvlrjuridico.AsFloat + vVlDev;
      end
      else begin
        Gruvlrmediacao.AsFloat := Gruvlrmediacao.AsFloat + vVlDev;
        Ttgruvlrmediacao.AsFloat := Ttgruvlrmediacao.AsFloat + vVlDev;
      end;
      Grubemapreendido.AsFloat := Grubemapreendido.AsFloat + vVlApr;
      Ttgrubemapreendido.AsFloat := Ttgrubemapreendido.AsFloat + vVlApr;
      gru.Post;
      ttgru.Post;
    end;
    vCotasInadimplentes.Proximo;
  end;
  Result := ina;

end;

function Tdm.Deprecatedmontarrnp: Tdataset;
var
  vVlBem,
  vVlRnp: Double;
  vDtRecRnp,
  vLimite: TDateTime;
  vPag : iControllerPagamentos;
  vPreco: iControllerPrecoBem;
  vRNP: iControllerCota;
  vCotacao: iControllerCotacaoMoeda;
  vInicio: TDateTime;
  function CalculaSaldoRnp: Double;
  var
    vSaldo,
    vCtAnt,
    vCtDep: Double;
  begin
    vSaldo := 0;
    vCtAnt := 1;
    vCtDep := 1;
    while vPag.TemDados do
    begin
      vSaldo := vSaldo * (vCtDep / vCtAnt);
      vSaldo := vSaldo + vPag.OUTROS;
      vCtAnt := vCotacao.CotacaoMoeda('SELIC', vPag.DT_PAGTO);
      if not vPag.Proximo
      then begin
        vCtDep := vCotacao.CotacaoMoeda('SELIC', vLimite);
        vSaldo := vSaldo * (vCtDep / vCtAnt);
      end
      else vCtDep := vCotacao.CotacaoMoeda('SELIC', vPag.DT_PAGTO);
    end;
    Result := vSaldo;
  end;

begin
  vInicio := Now;
  vLimite := StartOfTheMonth(Date) - 1; // ultimo dia do mês passado
  ttGru.Close;
  ttGru.CreateDataset;
  ttGru.Append;
  Ttgruqtdrnpgru.AsInteger := 0;
  Ttgruqtdrnpcota.AsInteger := 0;
  Ttgruvlrrnp.AsFloat := 0.0;
  ttGru.Post;
  gru.Close;
  gru.CreateDataset;
  rnp.Close;
  rnp.CreateDataset;
  vPreco := TControllerFactory.New.PrecoBem;
  vPag := TControllerFactory.New.Pagamentos;
  vCotacao := TControllerFactory.New.CotacaoMoeda;
  vDtRecRnp := TControllerFactory.New.Empresa.RecuperarEmpresa.DTRECSLDRNP;

  vRNP := TControllerFactory.New.Cota.RetornaRNP(FEmpresa.STGRUENCCT);

  while vRNP.TemDados do
  begin
    vVlBem := vPreco.RetornaPrecoBemData( vRNP.BEM,
                                          vRNP.FIL_COM,
                                          vRNP.ULTREU).PRE_REAL;

    vPag.RetornaPagamentosDevolucaoCota( vRNP.GRUPO,
                                         vRNP.SEQ,
                                         vRNP.COTA,
                                         vDtRecRnp,
                                         vLimite);
    vVlRnp := CalculaSaldoRnp;

    if vVlRnp > 0
    then begin
      rnp.Append;
      rnpGrupo.AsString := vRNP.GRUPO;
      rnpCota.AsString := vRNP.COTA;
      rnpSeq.AsString := vRNP.SEQ;
      rnpTpRec.AsString := vRNP.TP_PESS;
      rnpPfPj.AsString := vRNP.CGCCPFMT;
      rnpNome.AsString := vRNP.NOME;
      rnpDtEnc.AsString := RetornaDataString(vRNP.DTENCCT, 'yyyy-mm-dd');
      rnpPercAmort.AsFloat := vRNP.PERCPAGO;
      rnpVlrBem.AsFloat := vVlBem;
      Rnpregaplic.AsString := vRNP.REGAPLIC;
      rnpVlrRnp.AsFloat := vVlRnp;
      Rnpultass.AsString := RetornaDataString(vRNP.ULTREU, 'yyyy-mm-dd');
      if vRNP.SEQ = '00'
      then Rnpstconsorciado.AsString := '1'
      else Rnpstconsorciado.AsString := '2';

      rnp.Post;
      ttGru.Edit;
      if gru.Locate('grupo', vRNP.GRUPO,[])
      then gru.Edit
      else begin
        gru.Append;
        Grugrupo.AsString := vRNP.GRUPO;
        Gruqtdrnp.AsInteger := 0;
        Gruvlrrnp.AsFloat := 0.0;
        Ttgruqtdrnpgru.AsInteger := Ttgruqtdrnpgru.AsInteger + 1;
      end;
      Gruqtdrnp.AsInteger := Gruqtdrnp.AsInteger + 1;
      Ttgruqtdrnpcota.AsInteger := Ttgruqtdrnpcota.AsInteger + 1;
      Gruvlrrnp.AsFloat := Gruvlrrnp.AsFloat + vVlRnp;
      Ttgruvlrrnp.AsFloat := Ttgruvlrrnp.AsFloat + vVlRnp;
      gru.Post;
      ttgru.Post;
    end;
    vRNP.Proximo;
  end;
  TempoDecorrido('MontarRNp', vInicio);
  Result := rnp;

end;

function Tdm.Deprecatedmontarcontacorrentedevolucao(Pgrupo, Pseq, Pcota: String; Pdatalimite: Tdatetime): Tdataset;
var
  vMov,
  vSaldo,
  vCtAnt,
  vCorrecao,
  vCtDep: Double;
  vPago: Boolean;
  vPagamentos: iControllerPagamentos;
  vCotacao: iControllerCotacaoMoeda;
  vDtRecRnp,
  vDataCorrecao: TDateTime;
begin
  ccDev.Close;
  ccDev.CreateDataset;
  vSaldo := 0;
  vCtAnt := 1;
  vCtDep := 1;
  vPago := False;
  vPagamentos := TControllerFactory.New.Pagamentos;
  vCotacao := TControllerFactory.New.CotacaoMoeda;
  vDtRecRnp := TControllerFactory.New.Empresa.RecuperarEmpresa.DTRECSLDRNP;

  vPagamentos.RetornaPagamentosDevolucaoCota(Pgrupo, Pseq, Pcota, vDtRecRnp, pDataLimite);

  vDataCorrecao := vPagamentos.DT_PAGTO;

  while vPagamentos.TemDados do
  begin
    vSaldo := vSaldo * (vCtDep / vCtAnt);

    // para provisao de pagamentos vmov deve ser zero
    vMov := vPagamentos.F_AQUISI + vPagamentos.ADMINIST + vPagamentos.F_RESERV +
            vPagamentos.OUTROS + vPagamentos.MUL_JUR;

    vSaldo := vSaldo + vPagamentos.OUTROS;

    ccDev.Append;
    Ccdevdtctb.AsDateTime := vPagamentos.DT_PAGTO;
    Ccdevtipo.AsString := vPagamentos.DCTIPOMOV;
    Ccdevvalor.AsFloat := vPagamentos.OUTROS;
    Ccdevsaldo.AsFloat := vSaldo;
    ccDev.Post;

    if Pos(vPagamentos.TIPO_MOV, '92.9D.93') <> 0     // provisao
    then vPago := (vMov <> 0)                      // provisao com pagamento
    else if Pos(vPagamentos.TIPO_MOV, 'J2.JD.J3') <> 0    // estorno da provisao
    then vPago := False
    else if Pos(vPagamentos.TIPO_MOV, '86.8D') <> 0    // pagamento
    then vPago := True
    else if Pos(vPagamentos.TIPO_MOV, 'I6.ID') <> 0    // estorno pagamento
    then vPago := False;

    vCtAnt := vCotacao.CotacaoMoeda('SELIC', vPagamentos.DT_PAGTO);

    if not vPagamentos.Proximo
    then begin  // não tem mais movimentos
      while CompareDate(EndOfTheMonth(vDataCorrecao), pDataLimite) <= 0 do
      begin
        vDataCorrecao := EndOfTheMonth(vDataCorrecao);
        vCtDep := vCotacao.CotacaoMoeda('SELIC', vDataCorrecao);
        vCorrecao := (vSaldo * (vCtDep / vCtAnt)) - vSaldo;
        vSaldo := vSaldo * (vCtDep / vCtAnt);
        ccDev.Append;
        Ccdevdtctb.AsDateTime := vDataCorrecao;
        Ccdevtipo.AsString := Format('CORREÇÃO %.6f',[vCtDep / vCtAnt]);
        Ccdevvalor.AsFloat := vCorrecao;
        Ccdevsaldo.AsFloat := vSaldo;
        ccDev.Post;
        vDataCorrecao := vDataCorrecao + 1;
        vCtAnt := vCtDep;
      end;
      //vCtDep := vCotacao.CotacaoMoeda('SELIC', pDataLimite);
      //vSaldo := vSaldo * (vCtDep / vCtAnt);
    end
    else begin
      while CompareDate(EndOfTheMonth(vDataCorrecao), vPagamentos.DT_PAGTO) <= 0  do
      begin
        vDataCorrecao := EndOfTheMonth(vDataCorrecao);
        vCtDep := vCotacao.CotacaoMoeda('SELIC', vDataCorrecao);
        vCorrecao := (vSaldo * (vCtDep / vCtAnt)) - vSaldo;
        vSaldo := vSaldo * (vCtDep / vCtAnt);
        ccDev.Append;
        Ccdevdtctb.AsDateTime := vDataCorrecao;
        Ccdevtipo.AsString := Format('CORREÇÃO %.6f',[ vCtAnt ]);
        Ccdevvalor.AsFloat := vCorrecao;
        Ccdevsaldo.AsFloat := vSaldo;
        ccDev.Post;
        vDataCorrecao := vDataCorrecao + 1;
        vCtAnt := vCtDep;
      end;
    end;


  end;
  ccDev.First;
  Result := ccDev;

end;

procedure Tdm.Deprecatedincluircomissaopermanencia(
  var Pinicio: Boolean; Pgrupo, Pseq, Pcota, Pnome: String; Pdata: Tdatetime; Psaldo, Pvalor: Double);
begin
  if Pinicio
  then begin
    comper.Close;
    comper.CreateDataset;
    Pinicio := False;
  end;
  comper.Append;
  comperGrupo.AsString := Pgrupo;
  comperSeq.AsString := Pseq;
  comperCota.AsString := Pcota;
  comperNome.AsString := Pnome;
  Comperdata.AsDateTime := Pdata;
  comperSaldo.AsFloat := Psaldo;
  comperComissao.AsFloat := Pvalor;
  comperAtual.AsFloat := Psaldo - Pvalor;
  comper.Post;
end;

function Tdm.Avisoexisteemacmov(Gru, Seq, Cota, Aviso: String): Boolean;
begin
  with cdsPesq do begin
    Close;
    //CommandText := Format(
    //  'select * from ACMOV where grupo=%s and seq=%s and cota=%s and aviso=%s',
    //  [QuotedStr(Gru), QuotedStr(Seq),QuotedStr(Cota),QuotedStr(Aviso)]);
    Open;
    Result := not Eof;
  end;
end;

function Tdm.Calcjur(Dtv, Dth: Tdate; Vlr: Double): Double;
var
   Dias: Integer;
   Multa, Juros : Double;
begin
     if not cdsPRS.Active then cdsPRS.Open;

     Dias := Round(DaySpan(Dth,Dtv));
     Multa := 0;
     Juros := 0;

     if Dtv < Dth
     then
         begin
              Multa := RoundTo((Vlr * cdsPRSPC_MUL.AsFloat / 100),-2);
              Juros := RoundTo((Vlr * (cdsPRSPC_JUR.AsFloat/30) / 100),-2);
              Juros := Juros * Dias;
         end;
     Result := Multa + Juros;
end;

procedure Tdm.Cdscotpess_f_jgettext(Sender: Tfield;
  var Text: String; Displaytext: Boolean);
begin
  if cdsCotPESS_F_J.Value = 'F'
  then Text := 'Física'
  else Text := 'Jurídica';
end;

procedure Tdm.Cdscotprofissgettext(Sender: Tfield;
  var Text: String; Displaytext: Boolean);
begin
  Text := PesqTab('008',cdsCotPROFISS.Value);
end;

procedure Tdm.Cdscotrepresgettext(Sender: Tfield;
  var Text: String; Displaytext: Boolean);
begin
  with cdsPesq do begin
    Close;
    //CommandText := 'select nome from ACREP where repres='+
    //  QuotedStr(cdsCotREPRES.Value);
    Open;
    if Eof
    then Text := ''
    else Text := cdsPesq.Fields[0].AsString;
  end;
end;

procedure Tdm.Cdscotsexogettext(Sender: Tfield;
  var Text: String; Displaytext: Boolean);
begin
  if cdsCotSEXO.Value = 'M' then
    Text := 'Masculino'
  else if cdsCotSEXO.Value = 'F' then
    Text := 'Feminino'
  else
    Text := cdsCotSEXO.Value;
end;

procedure Tdm.Cdscotsit_cobrgettext(Sender: Tfield;
  var Text: String; Displaytext: Boolean);
begin
  if (sender as TStringField).Value = 'N' then
    Text := 'Normal'
  else if (sender as TStringField).Value = 'J' then
    Text := 'Jurídico'
  else if (sender as TStringField).Value = 'M' then
    Text := 'Mediação'
  else if (sender as TStringField).Value = 'Q' then
    Text := 'Quitado'
  else if (sender as TStringField).Value = 'C' then
    Text := 'Cancelado'
  else if (sender as TStringField).Value = 'D' then
    Text := 'Desistente'
  else if (sender as TStringField).Value = 'T' then
    Text := 'Transfer'
  else
    Text := (sender as TStringField).Value;

end;

procedure Tdm.Cdscrefornecgettext(Sender: Tfield;
  var Text: String; Displaytext: Boolean);
begin
  with cdsPesq do begin
    Close;
    //CommandText := 'select nome from ACFOR where fornec='+
    //  QuotedStr(cdsCreFORNEC.Value);
    Open;
    if Eof
    then Text := ''
    else Text := cdsPesq.Fields[0].AsString;
  end;

end;

procedure Tdm.Cdsrelpendcalcfields(Dataset: Tdataset);
begin
  cdsRelPendVlMulJur.Value := cdsRelPendVlMul.Value + cdsRelPendVlJur.Value;
end;

procedure Tdm.Cdsrgrucalcfields(Dataset: Tdataset);
begin
  cdsRGruPerDev.Value := 100 - cdsRGruPERPAGO.Value;
end;

function Tdm.Conversaorecursiva(N: Longword): String;
const
     Unidades: array[1..19] of String = ('um', 'dois', 'tres', 'quatro',
          'cinco', 'seis', 'sete', 'oito', 'nove', 'dez', 'onze', 'doze',
          'treze', 'quatorze', 'quinze', 'dezesseis', 'dezessete', 'dezoito',
          'dezenove');
     Dezenas: array[1..9] of String = ('dez', 'vinte', 'trinta', 'quarenta',
          'cinquenta', 'sessenta', 'setenta', 'oitenta', 'noventa');
     Centenas: array[1..9] of String = ('cem', 'duzentos', 'trezentos',
          'quatrocentos', 'quinhentos', 'seiscentos', 'setecentos',
          'oitocentos','novecentos');
begin
     case N of

       1..19: Result := Unidades[N];

       20, 30, 40, 50, 60, 70, 80, 90:
           Result := Dezenas[N div 10] + ' ';

       21..29, 31..39, 41..49, 51..59, 61..69, 71..79, 81..89, 91..99:
           Result := Dezenas[N div 10] + ' e ' + ConversaoRecursiva(N mod 10);

       100, 200, 300, 400, 500, 600, 700, 800, 900:
            Result := Centenas[N div 100] + ' ';

       101..199: Result := ' cento e ' + ConversaoRecursiva(N mod 100);

       201..299, 301..399, 401..499, 501..599,
       601..699, 701..799, 801..899, 901..999: Result := Centenas[N div 100] +
                                     ' e ' + ConversaoRecursiva(N mod 100);

       1000..999999: Result := ConversaoRecursiva(N div 1000) + ' mil ' +
                               ConversaoRecursiva(N mod 1000);

       1000000..1999999: Result := ConversaoRecursiva(N div 1000000) +
                         ' milhao '+ ConversaoRecursiva(N mod 1000000);

       2000000..999999999: Result := ConversaoRecursiva(N div 1000000) +
                           ' milhoes '+ ConversaoRecursiva(N mod 1000000);

       1000000000..1999999999: Result := ConversaoRecursiva(N div 1000000000) +
                            ' bilhao ' + ConversaoRecursiva(N mod 1000000000);

       2000000000..4294967295: Result := ConversaoRecursiva(N div 1000000000) +
                           ' bilhoes ' + ConversaoRecursiva(N mod 1000000000);

     end;

end;

function Tdm.Converterreal(Dtmoeda: Tdate; Vlr: Double): Double;
begin
  Result := Vlr;
  if DtMoeda < StrToDate('01/07/1994')
  then begin
    if DtMoeda >= strtoDate('01/08/1993') then
      Result := Result / AcharCotacaoURV(DtMoeda)
    else begin
      PosicionarMoeda(DtMoeda);
      while not QryMoeda.Eof do begin
        Result := Result / QryMoedaFATOR.Value;
        QryMoeda.Next;
      end;
    end;
  end;
end;

function Tdm.Numeroparaextenso(Parmnumero: Real): String;
const
     ErrorString = 'Valor fora da faixa';
     Min = 0.01;
     Max = 4294967295.99;
     Moeda = ' real ';
     Moedas = ' reais ';
     Centesimo = ' centavo ';
     Centesimos = ' centavos ';
begin
  if (parmNumero >= Min) and (parmNumero <= Max) then begin
              {Tratar reais}

    Result := ConversaoRecursiva(Round(Int(parmNumero)));

    if Round(Int(parmNumero)) = 1
    then Result := Result + Moeda
    else if Round(Int(parmNumero)) <> 0
        then Result := Result + Moedas;

              {Tratar centavos}

    if not(Frac(parmNumero) = 0.00) then begin
      if Round(Int(parmNumero)) <> 0
      then Result := Result + ' e ';

      Result := Result + ConversaoRecursiva(Round(Frac(parmNumero) * 100));

      if (Round(Frac(parmNumero) * 100) = 1)
      then Result := Result + centesimo
      else Result := Result + centesimos;
    end;
  end

  else Result := ErrorString;

end;

function Tdm.Obterdescricaobem(Bem: String): String;
begin
  with cdsPesq do begin
    Close;
    //CommandText := 'select DESCRIC from ACBEM where BEM='+QuotedStr(Bem);
    Open;
    if Eof
    then Result := ''
    else Result := cdsPesq.FieldByName('DESCRIC').AsString;
  end;
end;

procedure Tdm.Executarsql(Strsql: String);
begin
  with sqlCom do
  begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
  end;
end;

function Tdm.Obternovoaviso(Grupo, Seq, Cota: String): String;
var
  Aviso: string;
begin
  with cdsPesq do begin
    Close;
    //if not cdsCob.IsEmpty
    //then CommandText := Format(
    //      'select max(aviso) from ACCOB where grupo=%s and seq=%s and cota=%s',
    //      [QuotedStr(Grupo),QuotedStr(Seq),QuotedStr(Cota)])
    //else CommandText := Format(
    //      'select max(aviso) from ACMOV where grupo=%s and seq=%s and cota=%s',
    //      [QuotedStr(Grupo),QuotedStr(Seq),QuotedStr(Cota)]);
    Open;
    Aviso := Format('%.6d',[StrToIntDef(cdsPesq.Fields[0].Value,0)+1]);
  end;
  while AvisoExisteEmAcmov(Grupo,Seq,Cota,Aviso) do
    Aviso := Format('%.6d',[StrToIntDef(Aviso,0)+1]);
  Result := Aviso;
end;

function Tdm.Obtervalorbemnadata(Fil, Bem: String; Dtpreco: Tdatetime): Double;
begin
  AbrirQryPre(Bem, Fil,DtPreco);
  if not qryPre.Eof
  then Result := qryPrePRE_TABE.Value
  else Result := 0;
end;

function Tdm.Obtervalorbemnadata(Dtpreco: Tdatetime): Double;
begin
  AbrirQryPre(cdsPagBEM.Value, cdsCotFIL_COM.Value,cdsPagDT_PAGTO.Value);
  if not qryPre.Eof
  then Result := qryPrePRE_TABE.Value
  else Result := 0;
//  sdsPre.First;
//  while not sdsPre.Eof do begin
//    if sdsPreDT_BASE.Value <= DtPreco
//    then Break;
//    sdsPre.Next;
//  end;
//  if sdsPre.Eof
//  then sdsPre.Last;
//  Result := sdsPrePRE_TABE.Value;
end;

function Tdm.Pesqfil(Fil: String): String;
begin
  with cdsPesq do begin
    close;
    //CommandText := 'select cidade from ACFIL where filial='+QuotedStr(Fil);
    Open;
    if Eof
    then Result := ''
    else Result := cdsPesq.Fields[0].AsString;
  end;
end;

function Tdm.Pesqtab(Tab, Cod: String): String;
begin
  with qryTab do begin
    Close;
    Params[0].Value := Tab;
    Params[1].Value := Cod;
    Open;
    if not Eof
    then Result := qryTabDESCRIC.Value
    else Result := ' ';
  end;
end;

function Tdm.Poscot(Gru, Seq, Cot: String): Boolean;
begin
  with cdsCot do begin
    Close;
    Params[0].Value := Gru;
    Params[1].Value := Cot;
    Params[2].Value := Seq;
    Open;
    Result := (not Eof);
  end;
end;

function Tdm.Posgru(Gru: String): Boolean;
begin
  with cdsGru do begin
    Close;
    Params[0].Value := Gru;
    Open;
    Result := (not Eof);
  end;
end;

function Tdm.Posicionarcdsfin(Dt1, Dt2: Tdatetime): Boolean;
begin
  Screen.Cursor := crHourGlass;
  with cdsFin do begin
    Close;
    Params[0].Value := Dt1;
    Params[1].Value := Dt2;
    Open;
    Result := not Eof;
  end;
  Screen.Cursor := crDefault;
end;

function Tdm.Posicionarfaixagrupos(Grini, Grfim, Si, Sf: String): Boolean;
begin
  Screen.Cursor := crHourGlass;
  with cdsRGru do begin
    Close;
    Params[0].Value := GrIni;
    Params[1].Value := GrFim;
    Params[2].Value := si;
    Params[3].Value := sf;
    Open;
    Result := not Eof;
  end;
  Screen.Cursor := crDefault;
end;

procedure Tdm.Posicionarmoeda(Dtmoeda: Tdate);
begin
  with QryMoeda do begin
    Close;
    Params[0].Value := DtMoeda;
    Open;
  end;
end;

function Tdm.Posicionarmvt(Gru, Seq, Cot, Avi: String): Boolean;
begin
  with cdsMvt do begin
    Close;
    Params[0].Value := Gru;
    Params[1].Value := Seq;
    Params[2].Value := Cot;
    Params[3].Value := Avi;
    Open;
    Result := not Eof;
  end;
end;

function Tdm.Posicionarpendencia(Grini, Grfim, Si, Sf: String): Boolean;
begin
  Screen.Cursor := crHourGlass;
  with cdsPen do begin
    Close;
    Params[0].Value := GrIni;
    Params[1].Value := GrFim;
    Params[2].Value := si;
    Params[3].Value := sf;
    Open;
    Result := not Eof;
  end;
  Screen.Cursor := crDefault;
end;

function Tdm.Posicionarpnd(Grupo, Cota, Aviso: String): Boolean;
begin
  with cdsPnd do begin
    Close;
    Params[0].Value := Grupo;
    Params[1].Value := Cota;
    Params[2].Value := Aviso;
    Open;
    Result := not Eof;
  end;
end;

function Tdm.Posicionarrelmov(Dt1, Dt2: Tdatetime): Boolean;
begin
  Screen.Cursor := crHourGlass;
  with CdsRelMov do begin
    Close;
    Params[0].Value := Dt1;
    Params[1].Value := Dt2;
    Open;
    Result := not Eof;
  end;
  Screen.Cursor := crDefault;
end;

function Tdm.Posicionarreuniao(Dtreu: Tdatetime): Boolean;
begin
  sdsReu.First;
  while not sdsReu.Eof do
  begin
    if sdsReuDATA_REU.Value >= DtReu
    then Break;
    sdsReu.Next;
  end;
  Result := not (sdsReu.Eof);
end;

procedure Tdm.Posiconartmv(Cod: String);
begin
  with QryTmv do begin
    Close;
    Params[0].Value := Cod;
    Open;
  end;
end;

function Tdm.Sugerirgrupo: String;
begin
  frmLista := TFrmLista.Create(nil);
  try
    //FrmLista.Tipo := lsGrupo;
    FrmLista.Gru := '';
    if frmLista.ShowModal = mrOk
    then Result := cdsPesq.Fields[0].AsString
    else Result := '';
  finally
    frmLista.Free;
  end;

end;

function Tdm.Calcularjuros(Dtvenc: Tdatetime; Vlprin: Double; Dtatual: Tdatetime): Double;
var
  Dias: Integer;
begin
  Result := 0;
  if DtAtual > DtVenc then begin
    Dias := DaysBetween(DtAtual,DtVenc);
    Result := (VlPrin * (FEmpresa.PCJUROS /30)/100) * Dias;
  end;
end;

function Tdm.Calcularmulta(Dtvenc: Tdatetime; Vlprin: Double; Dtatual: Tdatetime): Double;
begin
  Result := 0;
  if Dtvenc < Dtatual
  then Result := Vlprin * FEmpresa.PCMULTAS / 100;
end;

procedure Tdm.Cdsageprioridadegettext(Sender: Tfield;
  var Text: String; Displaytext: Boolean);
begin
     case cdsAgePRIORIDADE.AsInteger of
       0: Text := 'Alta ';
       1: Text := 'Média';
       2: Text := 'Baixa';
     end;
end;

procedure Tdm.Cdsagestatusgettext(Sender: Tfield;
  var Text: String; Displaytext: Boolean);
begin
     if cdsAgeSTATUS.AsInteger = 0
     then Text := 'Aberto'
     else Text := 'Realizado';
end;

procedure Tdm.Datamodulecreate(Sender: Tobject);
begin
  FEmpresa := TControllerFactory.New.Empresa.RecuperarEmpresa;
End;

end.
