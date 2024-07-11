unit UnDm;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr, FMTBcd, DBClient, Provider,
  Dialogs, ExtDlgs, Forms, ImgList, Controls, SimpleDS, RpCon, RpConDS,
  RpRender, RpRenderPDF, RpBase, RpSystem, RpDefine, RpRave, MidasLib,
  RLPreviewForm, RLFilters, RLPDFFilter, RLDraftFilter, RLParser, IniFiles;

type
  TDM = class(TDataModule)
    Con: TSQLConnection;
    qryImp: TSQLQuery;
    dstCot: TSQLDataSet;
    dspCot: TDataSetProvider;
    cdsCot: TClientDataSet;
    dstUsu: TSQLDataSet;
    dspUsu: TDataSetProvider;
    cdsUsu: TClientDataSet;
    sqlCom: TSQLQuery;
    AbreFig: TOpenPictureDialog;
    IL: TImageList;
    dstCons: TSQLDataSet;
    dspCons: TDataSetProvider;
    cdsCons: TClientDataSet;
    dstPesq: TSQLDataSet;
    dspPesq: TDataSetProvider;
    cdsPesq: TClientDataSet;
    dstPRS: TSQLDataSet;
    dspPRS: TDataSetProvider;
    cdsPRS: TClientDataSet;
    cdsPRSNM_PRS: TStringField;
    cdsPRSCD_CGC: TStringField;
    qryPag: TSQLQuery;
    cdsPag: TClientDataSet;
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
    qryImpCotD_VENCTO: TSQLTimeStampField;
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
    qryImpD_VENCTO: TSQLTimeStampField;
    qryImpP_NORMAL: TFMTBCDField;
    qryImpP_DIFER: TFMTBCDField;
    qryImpF_AQUISI: TFMTBCDField;
    qryImpADMINIST: TFMTBCDField;
    qryImpF_RESERV: TFMTBCDField;
    qryImpOUTROS: TFMTBCDField;
    qryImpSEG_OUT: TStringField;
    qryImpTP_SEGUR: TStringField;
    qryImpPERSEGVD: TFMTBCDField;
    dstAge: TSQLDataSet;
    dspAge: TDataSetProvider;
    cdsAge: TClientDataSet;
    SelFon: TFontDialog;
    cdsCar: TClientDataSet;
    cdsCarCarta: TMemoField;
    cdsTex: TClientDataSet;
    cdsTexCodigo: TIntegerField;
    cdsTexObs: TStringField;
    cdsTexTexto: TMemoField;
    qryAli: TSQLQuery;
    cdsAli: TClientDataSet;
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
    dstBem: TSQLDataSet;
    sdsBem: TClientDataSet;
    sdsBemDESCRIC: TStringField;
    sdsBemFABRICAN: TStringField;
    sdsBemTIPO_BEM: TStringField;
    dstPre: TSQLDataSet;
    sdsPre: TClientDataSet;
    sdsPreDT_BASE: TDateField;
    sdsPrePRE_TABE: TFloatField;
    dstReu: TSQLDataSet;
    sdsReu: TClientDataSet;
    sdsReuNRO_REU: TStringField;
    sdsReuDATA_REU: TDateField;
    qryTab: TSQLQuery;
    qryTabDESCRIC: TStringField;
    dstCob: TSQLDataSet;
    cdsCob: TClientDataSet;
    cdsCobAVISO: TStringField;
    cdsCobSIGLA1: TStringField;
    cdsCobD_VENCTO: TDateField;
    cdsCobVALOR: TFloatField;
    dstJur: TSQLDataSet;
    sdsJur: TClientDataSet;
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
    cdsCotdstBem: TDataSetField;
    cdsCotdstPre: TDataSetField;
    cdsCotdstJur: TDataSetField;
    cdsCotqryAli: TDataSetField;
    dstGru: TSQLDataSet;
    dspGru: TDataSetProvider;
    cdsGru: TClientDataSet;
    cdsGruGRUPO: TStringField;
    cdsGruPLA_PADR: TStringField;
    dsGru: TDataSource;
    cdsGrudstReu: TDataSetField;
    dstCre: TSQLDataSet;
    cdsCre: TClientDataSet;
    cdsCotdstCre: TDataSetField;
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
    dstSeg: TSQLDataSet;
    cdsSeg: TClientDataSet;
    cdsCotdstSeg: TDataSetField;
    cdsSegNOME_FANT: TStringField;
    cdsSegPERSEGVD: TFloatField;
    RvPrj: TRvProject;
    RvSys: TRvSystem;
    RndPDF: TRvRenderPDF;
    RvDSCot: TRvDataSetConnection;
    RvDSGru: TRvDataSetConnection;
    RvDSCob: TRvDataSetConnection;
    RvDSBem: TRvDataSetConnection;
    RvDSJur: TRvDataSetConnection;
    RvDSAli: TRvDataSetConnection;
    RvDSPrs: TRvDataSetConnection;
    RvDSUsu: TRvDataSetConnection;
    SQLMon: TSQLMonitor;
    RvDSPre: TRvDataSetConnection;
    RvDSCre: TRvDataSetConnection;
    RvDSSeg: TRvDataSetConnection;
    RvDSMov: TRvDataSetConnection;
    sqlRGru: TSQLDataSet;
    dspRGru: TDataSetProvider;
    cdsRGru: TClientDataSet;
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
    rvRGru: TRvDataSetConnection;
    sqlPen: TSQLDataSet;
    dspPend: TDataSetProvider;
    cdsPen: TClientDataSet;
    rvDSPen: TRvDataSetConnection;
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
    cdsRelPend: TClientDataSet;
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
    cdsDevCon: TClientDataSet;
    cdsDevConPcLiq: TFloatField;
    cdsDevConVlCorr: TFloatField;
    cdsDevConVlRed: TFloatField;
    cdsDevConTxDev: TFloatField;
    cdsDevConTxRec: TFloatField;
    cdsDevConTxRecolher: TFloatField;
    cdsDevConTx50: TFloatField;
    cdsDevConVlRes: TFloatField;
    rvDevCon: TRvDataSetConnection;
    dstPnd: TSQLDataSet;
    dspPnd: TDataSetProvider;
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
    cdsPnd: TClientDataSet;
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
    cdsCb1: TClientDataSet;
    cdsCb1Aviso: TStringField;
    cdsCb1Reu: TStringField;
    cdsCb1TpPen: TStringField;
    cdsCb1Vencto: TStringField;
    cdsCb1VlBem: TFloatField;
    cdsCb1PcNormal: TFloatField;
    cdsCb1PcRat: TFloatField;
    cdsCb1VPend: TFloatField;
    cdsCb1VlMul: TFloatField;
    cdsCb1VlJur: TFloatField;
    cdsCb1VlTot: TFloatField;
    cdsCb1VlMulJur: TFloatField;
    cdsCb1TtPcNor: TAggregateField;
    cdsCb1ttPcRat: TAggregateField;
    cdsCb1TtPend: TAggregateField;
    cdsCb1TtMul: TAggregateField;
    cdsCb1TtJur: TAggregateField;
    cdsCb1TtTot: TAggregateField;
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
    dstMvt: TSQLDataSet;
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
    dspMvt: TDataSetProvider;
    cdsMvt: TClientDataSet;
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
    dspRelMov: TDataSetProvider;
    CdsRelMov: TClientDataSet;
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
    RvDSRelMov: TRvDataSetConnection;
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
    dspFin: TDataSetProvider;
    cdsFin: TClientDataSet;
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
    rvFin: TRvDataSetConnection;
    cdsPagF_AQUISI: TFloatField;
    cdsPagADMINIST: TFloatField;
    cdsPagF_RESERV: TFloatField;
    cdsPagOUTROS: TFloatField;
    rvCtFin: TRvDataSetConnection;
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
    cdsCotqryPag: TDataSetField;
    cdsPagD_CONTAB: TDateField;
    cdsMov: TClientDataSet;
    cdsMovAviso: TStringField;
    cdsMovReu: TStringField;
    cdsMovTipo: TStringField;
    cdsMovVencto: TStringField;
    cdsMovPagto: TStringField;
    cdsMovDtReu: TStringField;
    cdsMovSimb: TStringField;
    cdsMovVlBem: TFloatField;
    cdsMovPer: TFloatField;
    cdsMovRat: TFloatField;
    cdsMovVlTot: TFloatField;
    cdsMovMulju: TFloatField;
    cdsMovDtCtb: TStringField;
    cdsMovVlReal: TFloatField;
    cdsMovVlPag: TFloatField;
    cdsMovFdRes: TFloatField;
    cdsMovTxAdm: TFloatField;
    cdsMovOutros: TFloatField;
    cdsMovDcBem: TStringField;
    cdsMovHist: TStringField;
    cdsMovTTRat: TAggregateField;
    cdsMovTTPag: TAggregateField;
    cdsMovTTMul: TAggregateField;
    cdsMovTTReal: TAggregateField;
    cdsMovTTRes: TAggregateField;
    cdsMovTTAdm: TAggregateField;
    cdsMovTTOut: TAggregateField;
    cdsMovTTPer: TAggregateField;
    cdsCotdstCob: TDataSetField;
    cdsCobF_AQUISI: TFloatField;
    cdsCobF_RESERV: TFloatField;
    cdsCobADMINIST: TFloatField;
    dstPRSSTRLIB: TStringField;
    cdsPRSSTRLIB: TStringField;
    procedure cdsConsCGC_CPFGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure ConBeforeDisconnect(Sender: TObject);
    procedure ConBeforeConnect(Sender: TObject);
    procedure ConAfterConnect(Sender: TObject);
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
    procedure cdsPagD_VENCTOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsCotAfterScroll(DataSet: TDataSet);
    procedure cdsAgePRIORIDADEGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure cdsAgeSTATUSGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
  private
    { Private declarations }
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
    procedure CriaForm(frmClass: TFormClass; out Obj);
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
    procedure MontarPagamentos;
    procedure MontarPendencias;
    function CalcularJuros(DtVenc: TDateTime; VlPrin: Double; DtAtual: TDateTime): Double;
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
    procedure GravarAutorizacao(strAut: string);
  end;

var
  DM: TDM;

implementation

uses DateUtils, Math, UnLista;

{$R *.dfm}

procedure TDM.CriaForm(frmClass: TFormClass; out Obj);
begin
     try
        TForm(Obj) := frmClass.Create(Self);
        TForm(Obj).ShowModal;
     finally
            FreeAndNil(Obj);
     end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  Con.Connected := True;
end;

function TDM.GeraCod(Cam, Tab: String): Integer;
begin
     ExecutarSQL('select max('+Cam+') from '+Tab);
     if sqlCom.IsEmpty
     then Result := 1
     else Result := sqlCom.Fields[0].AsInteger + 1;
end;

procedure TDM.GravarAutorizacao(strAut: string);
begin
  with cdsPRS do begin
    Open;
    Edit;
    cdsPRSSTRLIB.Value := strAut;
    Post;
    ApplyUpdates(0);
    Refresh;
  end;
end;

procedure TDM.ImprimirRelatorio(Tit, Rel: string);
begin
  RvPrj.ProjectFile := ExtractFilePath(Application.ExeName)+'Cons.rav';
  RvPrj.Open;
  RvPrj.SetParam('Titulo',Tit);
  RvPrj.ExecuteReport(Rel);
  RvPrj.Close;
end;

procedure TDM.MontarPagamentos;
var
  tMov: Integer;
begin
  if not cdsMov.Active
  then cdsMov.Open;
  cdsMov.EmptyDataSet;
  cdsPag.First;
  while not cdsPag.Eof do begin
    cdsMov.Append;

    PosicionarMoeda(cdsPagDT_PAGTO.Value);

    if PosicionarReuniao(cdsPagDT_PAGTO.Value) then begin
      cdsMovReu.Value := sdsReuNRO_REU.Value;
      if sdsReuDATA_REU.AsString = '01/01/1801'
      then cdsMovDtReu.Value := ''
      else cdsMovDtReu.Value := sdsReuDATA_REU.AsString;
      cdsMovVlBem.Value := ObterValorBemNaData(sdsReuDATA_REU.Value);
    end
    else begin
      cdsMovReu.Value := '999';
      cdsMovDtReu.Value := '';
      cdsMovVlBem.Value := ObterValorBemNaData(cdsPagDT_PAGTO.Value);
    end;

    cdsMovAviso.Value := cdsPagAVISO.Value;
    cdsMovTipo.Value := cdsPagSIGLA1.Value;
    cdsMovSimb.Value := cdsPagSIMBOLO.Value;
    if cdsPagD_CONTAB.AsString = '01/01/1801'
    then cdsMovDtCtb.Value := ''
    else cdsMovDtCtb.Value := cdsPagD_CONTAB.AsString;

    tMov := Pos(cdsPagTIPO_MOV.Value,'21|C1|73|H3|83|I3|71|H1|82|I2');
    if (tMov > 0) and (tmov < 5) then begin   // apreensão e estorno
      if cdsPagDT_PAGTO.AsString = '01/01/1801'
      then cdsMovPagto.Value := ''
      else cdsMovPagto.Value := cdsPagDT_PAGTO.AsString;
      if tMov>1
      then cdsMovHist.Value := Format('VLR %8.2n '+cdsPagHISTORIC.Value,[cdsPagVALOR.Value])
      else cdsMovHist.Value := Format('VLR %8.2n '+cdsPagHISTORIC.Value,[cdsPagVALOR.Value]);
    end
    else if (tmov>6) and (tmov < 12) then begin  // credito e estorno crédito de perc
      if cdsPagD_VENCTO.AsString = '01/01/1801'
      then cdsMovVencto.Value := ''
      else cdsMovVencto.Value := cdsPagD_VENCTO.AsString;
      if cdsPagDT_PAGTO.AsString = '01/01/1801'
      then cdsMovPagto.Value := ''
      else cdsMovPagto.Value := cdsPagDT_PAGTO.AsString;
      cdsMovPer.Value := cdsPagP_NORMAL.Value + cdsPagP_DIFER.Value + cdsPagP_ANTEC.Value;
      cdsMovRat.Value := cdsPagP_RATEIO.Value;
      cdsMovHist.Value := cdsPagHISTORIC.Value;
    end
    else if (tmov>11) and (tmov < 19) then begin  // credito e estorno debito de perc
      if cdsPagD_VENCTO.AsString = '01/01/1801'
      then cdsMovVencto.Value := ''
      else cdsMovVencto.Value := cdsPagD_VENCTO.AsString;
      if cdsPagDT_PAGTO.AsString = '01/01/1801'
      then cdsMovPagto.Value := ''
      else cdsMovPagto.Value := cdsPagDT_PAGTO.AsString;
      cdsMovPer.Value := cdsPagP_NORMAL.Value + cdsPagP_DIFER.Value + cdsPagP_ANTEC.Value;
      cdsMovRat.Value := cdsPagP_RATEIO.Value;
      cdsMovHist.Value := cdsPagHISTORIC.Value;
    end
    else if (tmov>18) and (tmov < 25) then begin  // credito e estorno credito troca bem
      if cdsPagD_VENCTO.AsString = '01/01/1801'
      then cdsMovVencto.Value := ''
      else cdsMovVencto.Value := cdsPagD_VENCTO.AsString;
      if cdsPagDT_PAGTO.AsString = '01/01/1801'
      then cdsMovPagto.Value := ''
      else cdsMovPagto.Value := cdsPagDT_PAGTO.AsString;
      cdsMovPer.Value := cdsPagP_NORMAL.Value + cdsPagP_DIFER.Value + cdsPagP_ANTEC.Value;
      cdsMovRat.Value := cdsPagP_RATEIO.Value;
      cdsMovHist.Value := 'TROCA DE BEM '+cdsPagHISTORIC.Value;
    end
    else if (tmov>24) and (tmov < 30) then begin  // credito e estorno credito troca bem
      if cdsPagD_VENCTO.AsString = '01/01/1801'
      then cdsMovVencto.Value := ''
      else cdsMovVencto.Value := cdsPagD_VENCTO.AsString;
      if cdsPagDT_PAGTO.AsString = '01/01/1801'
      then cdsMovPagto.Value := ''
      else cdsMovPagto.Value := cdsPagDT_PAGTO.AsString;
      cdsMovPer.Value := cdsPagP_NORMAL.Value + cdsPagP_DIFER.Value + cdsPagP_ANTEC.Value;
      cdsMovRat.Value := cdsPagP_RATEIO.Value;
      cdsMovHist.Value := 'TROCA DE BEM '+cdsPagHISTORIC.Value;
    end
    else begin
      if cdsPagD_VENCTO.AsString = '01/01/1801'
      then cdsMovVencto.Value := ''
      else cdsMovVencto.Value := cdsPagD_VENCTO.AsString;
      if cdsPagDT_PAGTO.AsString = '01/01/1801'
      then cdsMovPagto.Value := ''
      else cdsMovPagto.Value := cdsPagDT_PAGTO.AsString;
      cdsMovPer.Value := cdsPagP_NORMAL.Value + cdsPagP_DIFER.Value + cdsPagP_ANTEC.Value;
      cdsMovRat.Value := cdsPagP_RATEIO.Value;
      cdsMovVlPag.Value := cdsPagF_AQUISI.Value;
      cdsMovMulJu.Value := cdsPagMUL_JUR.Value;
      cdsMovVlTot.Value := cdsPagVALOR.Value + cdsPagMUL_JUR.Value;
      cdsMovVlReal.Value := cdsPagVALOR.Value;
      cdsMovDcBem.Value :=  ObterDescricaoBem(cdsPagBEM.Value);
      cdsMovTxAdm.Value := cdsPagADMINIST.Value;
      cdsMovFdRes.Value := cdsPagF_RESERV.Value;
      cdsMovOutros.Value := cdsPagOUTROS.Value;
      cdsMovHist.Value := cdsPagHISTORIC.Value;
    end;
    cdsMov.Post;
    cdsPag.Next;
  end;
  cdsMov.First;

end;

procedure TDM.MontarPendencias;
begin
  if not cdsCb1.Active
  then cdsCb1.Open;
  sdsPre.First;
  cdsCb1.EmptyDataSet;
  cdsCob.First;
  while not cdsCob.Eof do begin
    cdsCb1.Append;
    PosiconarTmv(cdsCobTIPO_MOV.Value);
    if PosicionarReuniao(cdsCobD_VENCTO.Value)
    then cdsCb1Reu.Value := sdsReuNRO_REU.Value
    else cdsCb1Reu.Value := '999';
    cdsCb1Aviso.Value := cdsCobAVISO.Value;
    if cdsCobD_VENCTO.AsString = '01/01/1801'
    then cdsCb1Vencto.Value := ''
    else cdsCb1Vencto.Value := cdsCobD_VENCTO.AsString;
    cdsCb1TpPen.Value := cdsCobSIGLA1.Value;
//    cdsCb1VlBem.Value := ObterValorBemNaData(Date); // valor atual do bem
    cdsCb1VlBem.Value := sdsPrePRE_TABE.Value; // valor atual do bem
    cdsCb1PcNormal.Value := cdsCobPCNOR.Value;
    cdsCb1PcRat.Value := cdsCobP_RATEIO.Value;
    cdsCb1VPend.Value := cdsCobVALOR.Value;
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
    if (QryTmvMUL_JUR.Value <> 'N') then begin
      if DM.cdsCobD_VENCTO.Value < Date
      then cdsCb1VlMul.Value := cdsCb1VPend.Value * cdsPRSPC_MUL.Value / 100
      else cdsCb1VlMul.Value := 0;
      cdsCb1VlJur.Value := CalcularJuros(cdsCobD_VENCTO.Value,cdsCb1VPend.Value, Date);
    end
    else begin
      cdsCb1VlMul.Value := 0;
      cdsCb1VlJur.Value := 0;
    end;
    cdsCb1VlTot.Value := cdsCb1VPend.Value + cdsCb1VlMul.Value + cdsCb1VlJur.Value;
    cdsCb1VlMulJur.Value := cdsCb1VlMul.Value + cdsCb1VlJur.Value;
    cdsCb1.Post;
    cdsCob.Next;
  end;
  cdsCb1.First;
end;

procedure TDM.cdsConsCGC_CPFGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if cdsConsPESS_F_J.Value = 'F'
  then Text := copy(cdsConsCGC_CPF.Value,2,3)+'.'+
          copy(cdsConsCGC_CPF.Value,5,3)+'.'+copy(cdsConsCGC_CPF.Value,8,3)+'-'+
          copy(cdsConsCGC_CPF.Value,15,2)
  else Text := copy(cdsConsCGC_CPF.Value,3,2)+'.'+
          copy(cdsConsCGC_CPF.Value,5,3)+'.'+copy(cdsConsCGC_CPF.Value,8,3)+'/'+
          copy(cdsConsCGC_CPF.Value,11,4)+'-'+copy(cdsConsCGC_CPF.Value,15,2);

end;

procedure TDM.cdsCotAfterScroll(DataSet: TDataSet);
begin
     if cdsCotPESS_F_J.Value = 'F'
     then cdsCotCGC_CPF.EditMask := '999\.999\.999\-99;0;_'
     else cdsCotCGC_CPF.EditMask := '99\.999\.999\/9999\-99;0;_';
end;

procedure TDM.cdsCotCalcFields(DataSet: TDataSet);
begin
   cdsCotPerPago.Value := cdsCotP_NO_PAG.Value + cdsCotP_AN_PAG.Value +
                          cdsCotP_SU_PAG.Value;
   cdsCotPerDev.Value := 100 - cdsCotPerPago.Value;
   cdsCotPreRat.Value := cdsCotP_RATEAD.Value - cdsCotP_RA_PAG.Value;
end;

procedure TDM.cdsCotCGC_CPFGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if cdsCotPESS_F_J.Value = 'F'
  then Text := copy(cdsCotCGC_CPF.Value,2,3)+'.'+
          copy(cdsCotCGC_CPF.Value,5,3)+'.'+copy(cdsCotCGC_CPF.Value,8,3)+'-'+
          copy(cdsCotCGC_CPF.Value,15,2)
  else Text := copy(cdsCotCGC_CPF.Value,3,2)+'.'+
          copy(cdsCotCGC_CPF.Value,5,3)+'.'+copy(cdsCotCGC_CPF.Value,8,3)+'/'+
          copy(cdsCotCGC_CPF.Value,11,4)+'-'+copy(cdsCotCGC_CPF.Value,15,2);

end;

procedure TDM.cdsCotE_CIVILGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  Text := PesqTab('005',cdsCotE_CIVIL.Value);
end;

procedure TDM.cdsCotFIL_FISCGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  Text := PesqFil((Sender as TStringField).AsString);
end;

procedure TDM.AbrirQryPre(Bem, Fil: string; DtBase: TDateTime);
begin
  with qryPre do begin
    Close;
    Params[0].Value := Bem;
    Params[1].Value := Fil;
    Params[2].Value := DtBase;
    Open;
  end;
end;

function TDM.AcharCotacaoURV(DtMoeda: TDate): Double;
begin
  with qryURV do begin
    Close;
    Params[0].Value := DtMoeda;
    Open;
    Result := qryURVCOTACAO.Value;
  end;
end;

procedure TDM.AtualizarPercentualPago(Gru, Seq, Cota: string; Cpo: Integer;
  Pc: Double);
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

procedure TDM.AtualizarVlrAtualPendencia(Gru, Seq, Cot: string);
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
      cdsPnd.ApplyUpdates(0);
    end;
    cdsCob.Next;
  end;
  cdsCot.Refresh;
end;

function TDM.AvisoExisteEmAcmov(Gru, Seq, Cota, Aviso: string): Boolean;
begin
  with cdsPesq do begin
    Close;
    CommandText := Format(
      'select * from ACMOV where grupo=%s and seq=%s and cota=%s and aviso=%s',
      [QuotedStr(Gru), QuotedStr(Seq),QuotedStr(Cota),QuotedStr(Aviso)]);
    Open;
    Result := not Eof;
  end;
end;

function TDM.CalcJur(Dtv,Dth: TDate; Vlr: Double): Double;
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

procedure TDM.cdsCotPESS_F_JGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if cdsCotPESS_F_J.Value = 'F'
  then Text := 'Física'
  else Text := 'Jurídica';
end;

procedure TDM.cdsCotPROFISSGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  Text := PesqTab('008',cdsCotPROFISS.Value);
end;

procedure TDM.cdsCotREPRESGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  with cdsPesq do begin
    Close;
    CommandText := 'select nome from ACREP where repres='+
      QuotedStr(cdsCotREPRES.Value);
    Open;
    if Eof
    then Text := ''
    else Text := cdsPesq.Fields[0].AsString;
  end;
end;

procedure TDM.cdsCotSEXOGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if cdsCotSEXO.Value = 'M' then
    Text := 'Masculino'
  else if cdsCotSEXO.Value = 'F' then
    Text := 'Feminino'
  else
    Text := cdsCotSEXO.Value;
end;

procedure TDM.cdsCotSIT_COBRGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
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

procedure TDM.cdsCreFORNECGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  with cdsPesq do begin
    Close;
    CommandText := 'select nome from ACFOR where fornec='+
      QuotedStr(cdsCreFORNEC.Value);
    Open;
    if Eof
    then Text := ''
    else Text := cdsPesq.Fields[0].AsString;
  end;

end;

procedure TDM.cdsPagD_VENCTOGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if (Sender as TDateField).AsString = '01/01/1801'
  then Text := ''
  else Text := (Sender as TDateField).AsString;
end;

procedure TDM.cdsRelPendCalcFields(DataSet: TDataSet);
begin
  cdsRelPendVlMulJur.Value := cdsRelPendVlMul.Value + cdsRelPendVlJur.Value;
end;

procedure TDM.cdsRGruCalcFields(DataSet: TDataSet);
begin
  cdsRGruPerDev.Value := 100 - cdsRGruPERPAGO.Value;
end;

procedure TDM.ConAfterConnect(Sender: TObject);
begin
  cdsPRS.Open;
end;

procedure TDM.ConBeforeConnect(Sender: TObject);
var
  NomeArq : string;
begin
  NomeArq := ExtractFilePath(Application.ExeName)+'CobCons.ini';
  if FileExists(NomeArq) then
    Con.LoadParamsFromIniFile(NomeArq);
end;

procedure TDM.ConBeforeDisconnect(Sender: TObject);
begin
  cdsPRS.Close;
end;

function TDM.ConversaoRecursiva(N: LongWord): string;
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

function TDM.ConverterReal(DtMoeda: TDate; Vlr: Double): Double;
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

function TDM.NumeroParaExtenso(parmNumero: Real): string;
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

function TDM.ObterDescricaoBem(Bem: string): string;
begin
  with cdsPesq do begin
    Close;
    CommandText := 'select DESCRIC from ACBEM where BEM='+QuotedStr(Bem);
    Open;
    if Eof
    then Result := ''
    else Result := cdsPesq.FieldByName('DESCRIC').AsString;
  end;
end;

procedure TDM.ExecutarSQL(strSQL: string);
begin
  with sqlCom do
  begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
  end;
end;

function TDM.ObterNovoAviso(Grupo, Seq, Cota: string): string;
var
  Aviso: string;
begin
  with cdsPesq do begin
    Close;
    if not cdsCob.IsEmpty
    then CommandText := Format(
          'select max(aviso) from ACCOB where grupo=%s and seq=%s and cota=%s',
          [QuotedStr(Grupo),QuotedStr(Seq),QuotedStr(Cota)])
    else CommandText := Format(
          'select max(aviso) from ACMOV where grupo=%s and seq=%s and cota=%s',
          [QuotedStr(Grupo),QuotedStr(Seq),QuotedStr(Cota)]);
    Open;
    Aviso := Format('%.6d',[StrToIntDef(cdsPesq.Fields[0].Value,0)+1]);
  end;
  while AvisoExisteEmAcmov(Grupo,Seq,Cota,Aviso) do
    Aviso := Format('%.6d',[StrToIntDef(Aviso,0)+1]);
  Result := Aviso;
end;

function TDM.ObterValorBemNaData(Fil, Bem: string; DtPreco: TDateTime): Double;
begin
  AbrirQryPre(Bem, Fil,DtPreco);
  if not qryPre.Eof
  then Result := qryPrePRE_TABE.Value
  else Result := 0;
end;

function TDM.ObterValorBemNaData(DtPreco: TDateTime): Double;
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

function TDM.PesqFil(Fil: string): string;
begin
  with cdsPesq do begin
    close;
    CommandText := 'select cidade from ACFIL where filial='+QuotedStr(Fil);
    Open;
    if Eof
    then Result := ''
    else Result := cdsPesq.Fields[0].AsString;
  end;
end;

function TDM.PesqTab(Tab, Cod: string): string;
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

function TDM.PosCot(Gru, Seq, Cot: string): Boolean;
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

function TDM.PosGru(Gru: string): boolean;
begin
  with cdsGru do begin
    Close;
    Params[0].Value := Gru;
    Open;
    Result := (not Eof);
  end;
end;

function TDM.PosicionarCdsFin(Dt1, Dt2: TDateTime): Boolean;
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

function TDM.PosicionarFaixaGrupos(GrIni, GrFim, si, sf: string): Boolean;
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

procedure TDM.PosicionarMoeda(DtMoeda: TDate);
begin
  with QryMoeda do begin
    Close;
    Params[0].Value := DtMoeda;
    Open;
  end;
end;

function TDM.PosicionarMvt(Gru, Seq, Cot, Avi: string): Boolean;
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

function TDM.PosicionarPendencia(GrIni, GrFim, si, sf: string): Boolean;
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

function TDM.PosicionarPnd(Grupo, Cota, Aviso: string): Boolean;
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

function TDM.PosicionarRelMov(Dt1, Dt2: TDateTime): Boolean;
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

function TDM.PosicionarReuniao(DtReu: TDateTime): Boolean;
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

procedure TDM.PosiconarTmv(Cod: string);
begin
  with QryTmv do begin
    Close;
    Params[0].Value := Cod;
    Open;
  end;
end;

function TDM.SugerirGrupo: string;
begin
  frmLista := TFrmLista.Create(nil);
  try
    FrmLista.Tipo := lsGrupo;
    FrmLista.Gru := '';
    if frmLista.ShowModal = mrOk
    then Result := cdsPesq.Fields[0].AsString
    else Result := '';
  finally
    frmLista.Free;
  end;

end;

function TDM.CalcularJuros(DtVenc: TDateTime; VlPrin: Double; DtAtual: TDateTime): Double;
var
  Dias: Integer;
begin
  if DtAtual > DtVenc then begin
    Dias := DaysBetween(DtAtual,DtVenc);
    Result := (VlPrin * (cdsPRSPC_JUR.Value /30)/100) * Dias;
  end
  else Result := 0;
end;

procedure TDM.cdsAgePRIORIDADEGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
     case cdsAgePRIORIDADE.AsInteger of
       0: Text := 'Alta ';
       1: Text := 'Média';
       2: Text := 'Baixa';
     end;
end;

procedure TDM.cdsAgeSTATUSGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
     if cdsAgeSTATUS.AsInteger = 0
     then Text := 'Aberto'
     else Text := 'Realizado';
end;

end.
