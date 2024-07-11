object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 456
  Width = 675
  object Con: TSQLConnection
    ConnectionName = 'BdCon'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxint30.dll'
    LoadParamsOnConnect = True
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=localhost:D:\sistemas\cobcons\morumbi\bdcon.fdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'gds32.dll'
    AfterConnect = ConAfterConnect
    BeforeConnect = ConBeforeConnect
    BeforeDisconnect = ConBeforeDisconnect
    Left = 8
    Top = 16
  end
  object qryImp: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'g'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'g'
        ParamType = ptInput
      end>
    SQL.Strings = (
      '(select cli.grupo, cli.seq, cli.cota, cli.nome, '
      '        cli.cgc_cpf, cli.pess_f_j, cli.endereco, cli.fil_com,'
      '        cli.complemen, cli.bairro, cli.cidade, cli.estado, '
      '        cli.cep, cli.telefone, cli.bem, nvl(cli.p_no_pag,0)+ '
      
        '        nvl(cli.p_an_pag,0) pcpago, cli.p_no_aqu, cli.p_admins, ' +
        'cli.p_reserv,'
      '        cob.aviso, cob.tipo_mov, cob.d_vencto, cob.p_normal, '
      '        cob.p_difer, cob.f_aquisi, cob.administ, cob.f_reserv, '
      '        cob.outros, cob.seg_out, cli.tp_segur, seg.persegvd'
      '  from a2cli cli, a2cob cob, actsg seg'
      ' where nvl(cli.p_no_pag, 0) + nvl(cli.p_an_pag, 0) < 98.9 and'
      '       cob.grupo(+) = cli.grupo and cob.seq(+) = cli.seq and'
      
        '       cob.cota(+) = cli.cota and  cli.seq = '#39'00'#39' and cli.sit_co' +
        'br <> '#39'Q'#39' and'
      '       cli.grupo = :g and seg.tp_seg(+)=cli.tp_segur'
      ''
      'union'
      ' select cli.grupo, cli.seq, cli.cota, cli.nome, '
      '        cli.cgc_cpf, cli.pess_f_j, cli.endereco, cli.fil_com,'
      '        cli.complemen, cli.bairro, cli.cidade, cli.estado, '
      '        cli.cep, cli.telefone, cli.bem, nvl(cli.p_no_pag,0)+ '
      
        '        nvl(cli.p_an_pag,0) pcpago, cli.p_no_aqu, cli.p_admins, ' +
        'cli.p_reserv,'
      '        cob.aviso, cob.tipo_mov, cob.d_vencto, cob.p_normal, '
      '        cob.p_difer, cob.f_aquisi, cob.administ, cob.f_reserv, '
      '        cob.outros, cob.seg_out, cli.tp_segur, seg.persegvd'
      '  from accli cli, accob cob, actsg seg'
      ' where nvl(cli.p_no_pag, 0) + nvl(cli.p_an_pag, 0) < 98.9 and'
      '       cob.grupo(+) = cli.grupo and cob.seq(+) = cli.seq and'
      
        '       cob.cota(+) = cli.cota and  cli.seq = '#39'00'#39' and cli.sit_co' +
        'br <> '#39'Q'#39' and'
      '       cli.grupo = :g and seg.tp_seg(+)=cli.tp_segur )'
      ''
      'order by 1,3,5')
    SQLConnection = Con
    Left = 448
    Top = 64
    object qryImpGRUPO: TStringField
      FieldName = 'GRUPO'
      Size = 4
    end
    object qryImpSEQ: TStringField
      FieldName = 'SEQ'
      Size = 2
    end
    object qryImpCOTA: TStringField
      FieldName = 'COTA'
      Size = 3
    end
    object qryImpNOME: TStringField
      FieldName = 'NOME'
      Size = 35
    end
    object qryImpCGC_CPF: TStringField
      FieldName = 'CGC_CPF'
      Size = 16
    end
    object qryImpPESS_F_J: TStringField
      FieldName = 'PESS_F_J'
      Size = 1
    end
    object qryImpENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 60
    end
    object qryImpFIL_COM: TStringField
      FieldName = 'FIL_COM'
      Size = 3
    end
    object qryImpCOMPLEMEN: TStringField
      FieldName = 'COMPLEMEN'
    end
    object qryImpBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 60
    end
    object qryImpCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 30
    end
    object qryImpESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 2
    end
    object qryImpCEP: TStringField
      FieldName = 'CEP'
      Size = 8
    end
    object qryImpTELEFONE: TStringField
      FieldName = 'TELEFONE'
    end
    object qryImpBEM: TStringField
      FieldName = 'BEM'
      Size = 4
    end
    object qryImpPCPAGO: TFMTBCDField
      FieldName = 'PCPAGO'
      Precision = 32
    end
    object qryImpP_NO_AQU: TFMTBCDField
      FieldName = 'P_NO_AQU'
      Precision = 32
    end
    object qryImpP_ADMINS: TFMTBCDField
      FieldName = 'P_ADMINS'
      Precision = 32
    end
    object qryImpP_RESERV: TFMTBCDField
      FieldName = 'P_RESERV'
      Precision = 32
    end
    object qryImpAVISO: TStringField
      FieldName = 'AVISO'
      Size = 6
    end
    object qryImpTIPO_MOV: TStringField
      FieldName = 'TIPO_MOV'
      Size = 2
    end
    object qryImpD_VENCTO: TSQLTimeStampField
      FieldName = 'D_VENCTO'
    end
    object qryImpP_NORMAL: TFMTBCDField
      FieldName = 'P_NORMAL'
      Precision = 32
    end
    object qryImpP_DIFER: TFMTBCDField
      FieldName = 'P_DIFER'
      Precision = 32
    end
    object qryImpF_AQUISI: TFMTBCDField
      FieldName = 'F_AQUISI'
      Precision = 32
    end
    object qryImpADMINIST: TFMTBCDField
      FieldName = 'ADMINIST'
      Precision = 32
    end
    object qryImpF_RESERV: TFMTBCDField
      FieldName = 'F_RESERV'
      Precision = 32
    end
    object qryImpOUTROS: TFMTBCDField
      FieldName = 'OUTROS'
      Precision = 32
    end
    object qryImpSEG_OUT: TStringField
      FieldName = 'SEG_OUT'
      Size = 1
    end
    object qryImpTP_SEGUR: TStringField
      FieldName = 'TP_SEGUR'
      Size = 2
    end
    object qryImpPERSEGVD: TFMTBCDField
      FieldName = 'PERSEGVD'
      Precision = 32
    end
  end
  object dstCot: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 'select * from ACCLI where grupo=:gr and cota=:ct and seq=:sq'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'gr'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ct'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sq'
        ParamType = ptInput
      end>
    SQLConnection = Con
    Left = 56
    Top = 16
    object dstCotGRUPO: TStringField
      FieldName = 'GRUPO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 4
    end
    object dstCotSEQ: TStringField
      FieldName = 'SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 2
    end
    object dstCotCOTA: TStringField
      FieldName = 'COTA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 3
    end
    object dstCotCONTRATO: TStringField
      FieldName = 'CONTRATO'
      ProviderFlags = [pfInUpdate]
      Size = 6
    end
    object dstCotNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 35
    end
    object dstCotENDERECO: TStringField
      FieldName = 'ENDERECO'
      ProviderFlags = [pfInUpdate]
      Size = 35
    end
    object dstCotBAIRRO: TStringField
      FieldName = 'BAIRRO'
      ProviderFlags = [pfInUpdate]
      Size = 25
    end
    object dstCotCIDADE: TStringField
      FieldName = 'CIDADE'
      ProviderFlags = [pfInUpdate]
      Size = 25
    end
    object dstCotESTADO: TStringField
      FieldName = 'ESTADO'
      ProviderFlags = [pfInUpdate]
      Size = 2
    end
    object dstCotCEP: TStringField
      FieldName = 'CEP'
      ProviderFlags = [pfInUpdate]
      Size = 8
    end
    object dstCotTELEFONE: TStringField
      FieldName = 'TELEFONE'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotBANCO: TStringField
      FieldName = 'BANCO'
      ProviderFlags = [pfInUpdate]
      Size = 4
    end
    object dstCotAGENCIA: TStringField
      FieldName = 'AGENCIA'
      ProviderFlags = [pfInUpdate]
      Size = 4
    end
    object dstCotCONTA: TStringField
      FieldName = 'CONTA'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object dstCotCGC_CPF: TStringField
      FieldName = 'CGC_CPF'
      ProviderFlags = [pfInUpdate]
      Size = 16
    end
    object dstCotE_CIVIL: TStringField
      FieldName = 'E_CIVIL'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstCotDT_NASC: TDateField
      FieldName = 'DT_NASC'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotSEXO: TStringField
      FieldName = 'SEXO'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstCotPROFISS: TStringField
      FieldName = 'PROFISS'
      ProviderFlags = [pfInUpdate]
      Size = 5
    end
    object dstCotDT_VENDA: TDateField
      FieldName = 'DT_VENDA'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotFIL_FISC: TStringField
      FieldName = 'FIL_FISC'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
    object dstCotBEM: TStringField
      FieldName = 'BEM'
      ProviderFlags = [pfInUpdate]
      Size = 4
    end
    object dstCotDOCUMENT: TStringField
      FieldName = 'DOCUMENT'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotTP_COTA: TStringField
      FieldName = 'TP_COTA'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstCotPESS_F_J: TStringField
      FieldName = 'PESS_F_J'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstCotFIL_ATE: TStringField
      FieldName = 'FIL_ATE'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
    object dstCotFIL_COM: TStringField
      FieldName = 'FIL_COM'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
    object dstCotPLANO: TStringField
      FieldName = 'PLANO'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
    object dstCotP_MENSAL: TFloatField
      FieldName = 'P_MENSAL'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotDT_ADES: TDateField
      FieldName = 'DT_ADES'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotP_ADMINS: TFloatField
      FieldName = 'P_ADMINS'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotP_RESERV: TFloatField
      FieldName = 'P_RESERV'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotREU_EMI: TStringField
      FieldName = 'REU_EMI'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
    object dstCotTP_SEGUR: TStringField
      FieldName = 'TP_SEGUR'
      ProviderFlags = [pfInUpdate]
      Size = 2
    end
    object dstCotSIT_COBR: TStringField
      FieldName = 'SIT_COBR'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstCotREU_SORT: TStringField
      FieldName = 'REU_SORT'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
    object dstCotTP_CONTE: TStringField
      FieldName = 'TP_CONTE'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstCotDT_CONTE: TDateField
      FieldName = 'DT_CONTE'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotDT_CONGE: TDateField
      FieldName = 'DT_CONGE'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotFORNEC: TStringField
      FieldName = 'FORNEC'
      ProviderFlags = [pfInUpdate]
      Size = 6
    end
    object dstCotDT_DESCL: TDateField
      FieldName = 'DT_DESCL'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotREPRES: TStringField
      FieldName = 'REPRES'
      ProviderFlags = [pfInUpdate]
      Size = 6
    end
    object dstCotREU_ADES: TStringField
      FieldName = 'REU_ADES'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
    object dstCotDT_ENTRE: TDateField
      FieldName = 'DT_ENTRE'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotVAL_ENTR: TFloatField
      FieldName = 'VAL_ENTR'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotPERM_NOM: TStringField
      FieldName = 'PERM_NOM'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstCotP_AN_AQU: TFloatField
      FieldName = 'P_AN_AQU'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotP_NO_AQU: TFloatField
      FieldName = 'P_NO_AQU'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotP_SU_AQU: TFloatField
      FieldName = 'P_SU_AQU'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotP_RA_AQU: TFloatField
      FieldName = 'P_RA_AQU'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotP_NO_PAG: TFloatField
      FieldName = 'P_NO_PAG'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotP_SU_PAG: TFloatField
      FieldName = 'P_SU_PAG'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotP_RA_PAG: TFloatField
      FieldName = 'P_RA_PAG'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotP_AN_PAG: TFloatField
      FieldName = 'P_AN_PAG'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotP_RATEAD: TFloatField
      FieldName = 'P_RATEAD'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotF_AQUISI: TFloatField
      FieldName = 'F_AQUISI'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotADMINIST: TFloatField
      FieldName = 'ADMINIST'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotF_RESERV: TFloatField
      FieldName = 'F_RESERV'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotOUTROS: TFloatField
      FieldName = 'OUTROS'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotP_IDEAL: TFloatField
      FieldName = 'P_IDEAL'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotCONSTRUC: TStringField
      FieldName = 'CONSTRUC'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstCotAG_COBRA: TStringField
      FieldName = 'AG_COBRA'
      ProviderFlags = [pfInUpdate]
      Size = 6
    end
    object dstCotD_CONGEL: TDateField
      FieldName = 'D_CONGEL'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotD_LIM_RJ: TDateField
      FieldName = 'D_LIM_RJ'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotD_ALT_RE: TDateField
      FieldName = 'D_ALT_RE'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotME_DT_AP: TDateField
      FieldName = 'ME_DT_AP'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotDT_SITUA: TDateField
      FieldName = 'DT_SITUA'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotREU_MOED: TStringField
      FieldName = 'REU_MOED'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
    object dstCotMOEDA_CO: TStringField
      FieldName = 'MOEDA_CO'
      ProviderFlags = [pfInUpdate]
      Size = 5
    end
    object dstCotQT_MOEDA: TFloatField
      FieldName = 'QT_MOEDA'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotDT_TROCA: TDateField
      FieldName = 'DT_TROCA'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotISEN_TAR: TStringField
      FieldName = 'ISEN_TAR'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstCotUSUARIO: TStringField
      FieldName = 'USUARIO'
      ProviderFlags = [pfInUpdate]
      Size = 4
    end
    object dstCotD_ATUALI: TDateField
      FieldName = 'D_ATUALI'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotCARAC_CT: TStringField
      FieldName = 'CARAC_CT'
      ProviderFlags = [pfInUpdate]
      Size = 5
    end
    object dstCotREPRE_GR: TStringField
      FieldName = 'REPRE_GR'
      ProviderFlags = [pfInUpdate]
      Size = 2
    end
    object dstCotTP_VENDA: TStringField
      FieldName = 'TP_VENDA'
      ProviderFlags = [pfInUpdate]
      Size = 2
    end
    object dstCotP_I_SUBS: TFloatField
      FieldName = 'P_I_SUBS'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotP_MX_SUB: TFloatField
      FieldName = 'P_MX_SUB'
      ProviderFlags = [pfInUpdate]
    end
    object dstCotINF_ADIC: TStringField
      FieldName = 'INF_ADIC'
      ProviderFlags = [pfInUpdate]
      Size = 60
    end
    object dstCotINF_ADIC_2: TStringField
      FieldName = 'INF_ADIC_2'
      ProviderFlags = [pfInUpdate]
      Size = 80
    end
    object dstCotINF_ADIC_3: TStringField
      FieldName = 'INF_ADIC_3'
      ProviderFlags = [pfInUpdate]
      Size = 80
    end
    object dstCotINF_ADIC_4: TStringField
      FieldName = 'INF_ADIC_4'
      ProviderFlags = [pfInUpdate]
      Size = 80
    end
  end
  object dspCot: TDataSetProvider
    DataSet = dstCot
    Options = [poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 96
    Top = 16
  end
  object cdsCot: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'gr'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ct'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sq'
        ParamType = ptInput
      end>
    ProviderName = 'dspCot'
    AfterScroll = cdsCotAfterScroll
    OnCalcFields = cdsCotCalcFields
    Left = 136
    Top = 16
    object cdsCotGRUPO: TStringField
      FieldName = 'GRUPO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 4
    end
    object cdsCotSEQ: TStringField
      FieldName = 'SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 2
    end
    object cdsCotCOTA: TStringField
      FieldName = 'COTA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 3
    end
    object cdsCotCONTRATO: TStringField
      FieldName = 'CONTRATO'
      ProviderFlags = [pfInUpdate]
      Size = 6
    end
    object cdsCotNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 35
    end
    object cdsCotENDERECO: TStringField
      FieldName = 'ENDERECO'
      ProviderFlags = [pfInUpdate]
      Size = 35
    end
    object cdsCotBAIRRO: TStringField
      FieldName = 'BAIRRO'
      ProviderFlags = [pfInUpdate]
      Size = 25
    end
    object cdsCotCIDADE: TStringField
      FieldName = 'CIDADE'
      ProviderFlags = [pfInUpdate]
      Size = 25
    end
    object cdsCotESTADO: TStringField
      FieldName = 'ESTADO'
      ProviderFlags = [pfInUpdate]
      Size = 2
    end
    object cdsCotCEP: TStringField
      FieldName = 'CEP'
      ProviderFlags = [pfInUpdate]
      Size = 8
    end
    object cdsCotTELEFONE: TStringField
      FieldName = 'TELEFONE'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotBANCO: TStringField
      FieldName = 'BANCO'
      ProviderFlags = [pfInUpdate]
      Size = 4
    end
    object cdsCotAGENCIA: TStringField
      FieldName = 'AGENCIA'
      ProviderFlags = [pfInUpdate]
      Size = 4
    end
    object cdsCotCONTA: TStringField
      FieldName = 'CONTA'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object cdsCotCGC_CPF: TStringField
      FieldName = 'CGC_CPF'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsCotCGC_CPFGetText
      Size = 16
    end
    object cdsCotE_CIVIL: TStringField
      DisplayLabel = 'Est.Civil'
      FieldName = 'E_CIVIL'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsCotE_CIVILGetText
      Size = 1
    end
    object cdsCotDT_NASC: TDateField
      DisplayLabel = 'Dt.Nasc.'
      FieldName = 'DT_NASC'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsPagD_VENCTOGetText
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsCotSEXO: TStringField
      DisplayLabel = 'Sexo'
      FieldName = 'SEXO'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsCotSEXOGetText
      Size = 1
    end
    object cdsCotPROFISS: TStringField
      DisplayLabel = 'Profiss'#227'o'
      FieldName = 'PROFISS'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsCotPROFISSGetText
      Size = 5
    end
    object cdsCotDT_VENDA: TDateField
      FieldName = 'DT_VENDA'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsPagD_VENCTOGetText
    end
    object cdsCotFIL_FISC: TStringField
      FieldName = 'FIL_FISC'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsCotFIL_FISCGetText
      Size = 3
    end
    object cdsCotBEM: TStringField
      FieldName = 'BEM'
      ProviderFlags = [pfInUpdate]
      Size = 4
    end
    object cdsCotDOCUMENT: TStringField
      DisplayLabel = 'Documento'
      FieldName = 'DOCUMENT'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotTP_COTA: TStringField
      FieldName = 'TP_COTA'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object cdsCotPESS_F_J: TStringField
      FieldName = 'PESS_F_J'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsCotPESS_F_JGetText
      Size = 1
    end
    object cdsCotFIL_ATE: TStringField
      DisplayLabel = 'Filial'
      FieldName = 'FIL_ATE'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsCotFIL_FISCGetText
      Size = 3
    end
    object cdsCotFIL_COM: TStringField
      FieldName = 'FIL_COM'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsCotFIL_FISCGetText
      Size = 3
    end
    object cdsCotPLANO: TStringField
      DisplayLabel = 'Plano'
      FieldName = 'PLANO'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
    object cdsCotP_MENSAL: TFloatField
      DisplayLabel = '% Mensal'
      FieldName = 'P_MENSAL'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = ',#0.0000'
    end
    object cdsCotDT_ADES: TDateField
      DisplayLabel = 'Ades'#227'o'
      FieldName = 'DT_ADES'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsPagD_VENCTOGetText
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsCotP_ADMINS: TFloatField
      FieldName = 'P_ADMINS'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = ',#0.000'
    end
    object cdsCotP_RESERV: TFloatField
      FieldName = 'P_RESERV'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = ',#0.000'
    end
    object cdsCotREU_EMI: TStringField
      FieldName = 'REU_EMI'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
    object cdsCotTP_SEGUR: TStringField
      DisplayLabel = 'Seguro'
      FieldName = 'TP_SEGUR'
      ProviderFlags = [pfInUpdate]
      Size = 2
    end
    object cdsCotSIT_COBR: TStringField
      DisplayLabel = 'Sit.Cob'
      FieldName = 'SIT_COBR'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsCotSIT_COBRGetText
      Size = 1
    end
    object cdsCotREU_SORT: TStringField
      FieldName = 'REU_SORT'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
    object cdsCotTP_CONTE: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TP_CONTE'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object cdsCotDT_CONTE: TDateField
      DisplayLabel = 'Dt.Contemp'
      FieldName = 'DT_CONTE'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsPagD_VENCTOGetText
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsCotDT_CONGE: TDateField
      FieldName = 'DT_CONGE'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsPagD_VENCTOGetText
    end
    object cdsCotFORNEC: TStringField
      FieldName = 'FORNEC'
      ProviderFlags = [pfInUpdate]
      Size = 6
    end
    object cdsCotDT_DESCL: TDateField
      FieldName = 'DT_DESCL'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsPagD_VENCTOGetText
    end
    object cdsCotREPRES: TStringField
      DisplayLabel = 'Vendedor'
      FieldName = 'REPRES'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsCotREPRESGetText
      Size = 6
    end
    object cdsCotREU_ADES: TStringField
      DisplayLabel = 'Reu.Ades'#227'o'
      FieldName = 'REU_ADES'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
    object cdsCotDT_ENTRE: TDateField
      DisplayLabel = 'Entrega'
      FieldName = 'DT_ENTRE'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsPagD_VENCTOGetText
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsCotVAL_ENTR: TFloatField
      DisplayLabel = 'Vlr Entregue'
      FieldName = 'VAL_ENTR'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = ',#0.00'
    end
    object cdsCotPERM_NOM: TStringField
      FieldName = 'PERM_NOM'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object cdsCotP_AN_AQU: TFloatField
      FieldName = 'P_AN_AQU'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotP_NO_AQU: TFloatField
      FieldName = 'P_NO_AQU'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotP_SU_AQU: TFloatField
      FieldName = 'P_SU_AQU'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotP_RA_AQU: TFloatField
      FieldName = 'P_RA_AQU'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotP_NO_PAG: TFloatField
      FieldName = 'P_NO_PAG'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotP_SU_PAG: TFloatField
      FieldName = 'P_SU_PAG'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotP_RA_PAG: TFloatField
      FieldName = 'P_RA_PAG'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotP_AN_PAG: TFloatField
      FieldName = 'P_AN_PAG'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotP_RATEAD: TFloatField
      FieldName = 'P_RATEAD'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotF_AQUISI: TFloatField
      FieldName = 'F_AQUISI'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotADMINIST: TFloatField
      FieldName = 'ADMINIST'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = ',#0.00'
    end
    object cdsCotF_RESERV: TFloatField
      FieldName = 'F_RESERV'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = ',#0.00'
    end
    object cdsCotOUTROS: TFloatField
      FieldName = 'OUTROS'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotP_IDEAL: TFloatField
      FieldName = 'P_IDEAL'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotCONSTRUC: TStringField
      FieldName = 'CONSTRUC'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object cdsCotAG_COBRA: TStringField
      FieldName = 'AG_COBRA'
      ProviderFlags = [pfInUpdate]
      Size = 6
    end
    object cdsCotD_CONGEL: TDateField
      FieldName = 'D_CONGEL'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsPagD_VENCTOGetText
    end
    object cdsCotD_LIM_RJ: TDateField
      FieldName = 'D_LIM_RJ'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsPagD_VENCTOGetText
    end
    object cdsCotD_ALT_RE: TDateField
      FieldName = 'D_ALT_RE'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsPagD_VENCTOGetText
    end
    object cdsCotME_DT_AP: TDateField
      FieldName = 'ME_DT_AP'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotDT_SITUA: TDateField
      FieldName = 'DT_SITUA'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsPagD_VENCTOGetText
    end
    object cdsCotREU_MOED: TStringField
      FieldName = 'REU_MOED'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
    object cdsCotMOEDA_CO: TStringField
      FieldName = 'MOEDA_CO'
      ProviderFlags = [pfInUpdate]
      Size = 5
    end
    object cdsCotQT_MOEDA: TFloatField
      FieldName = 'QT_MOEDA'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotDT_TROCA: TDateField
      FieldName = 'DT_TROCA'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsPagD_VENCTOGetText
    end
    object cdsCotISEN_TAR: TStringField
      FieldName = 'ISEN_TAR'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object cdsCotUSUARIO: TStringField
      FieldName = 'USUARIO'
      ProviderFlags = [pfInUpdate]
      Size = 4
    end
    object cdsCotD_ATUALI: TDateField
      FieldName = 'D_ATUALI'
      ProviderFlags = [pfInUpdate]
      OnGetText = cdsPagD_VENCTOGetText
    end
    object cdsCotCARAC_CT: TStringField
      FieldName = 'CARAC_CT'
      ProviderFlags = [pfInUpdate]
      Size = 5
    end
    object cdsCotREPRE_GR: TStringField
      FieldName = 'REPRE_GR'
      ProviderFlags = [pfInUpdate]
      Size = 2
    end
    object cdsCotTP_VENDA: TStringField
      FieldName = 'TP_VENDA'
      ProviderFlags = [pfInUpdate]
      Size = 2
    end
    object cdsCotP_I_SUBS: TFloatField
      FieldName = 'P_I_SUBS'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotP_MX_SUB: TFloatField
      FieldName = 'P_MX_SUB'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCotINF_ADIC: TStringField
      FieldName = 'INF_ADIC'
      ProviderFlags = [pfInUpdate]
      Size = 60
    end
    object cdsCotINF_ADIC_2: TStringField
      FieldName = 'INF_ADIC_2'
      ProviderFlags = [pfInUpdate]
      Size = 80
    end
    object cdsCotINF_ADIC_3: TStringField
      FieldName = 'INF_ADIC_3'
      ProviderFlags = [pfInUpdate]
      Size = 80
    end
    object cdsCotINF_ADIC_4: TStringField
      FieldName = 'INF_ADIC_4'
      ProviderFlags = [pfInUpdate]
      Size = 80
    end
    object cdsCotPerPago: TFloatField
      DisplayLabel = '% Pago'
      FieldKind = fkCalculated
      FieldName = 'PerPago'
      DisplayFormat = ',#0.0000'
      Calculated = True
    end
    object cdsCotPerDev: TFloatField
      DisplayLabel = '% Devedor'
      FieldKind = fkCalculated
      FieldName = 'PerDev'
      DisplayFormat = ',#0.0000'
      Calculated = True
    end
    object cdsCotdstBem: TDataSetField
      FieldName = 'dstBem'
    end
    object cdsCotdstPre: TDataSetField
      FieldName = 'dstPre'
    end
    object cdsCotdstJur: TDataSetField
      FieldName = 'dstJur'
    end
    object cdsCotqryAli: TDataSetField
      FieldName = 'qryAli'
    end
    object cdsCotdstCre: TDataSetField
      FieldName = 'dstCre'
    end
    object cdsCotdstSeg: TDataSetField
      FieldName = 'dstSeg'
    end
    object cdsCotPreRat: TFloatField
      DisplayLabel = '% Rateio'
      FieldKind = fkCalculated
      FieldName = 'PreRat'
      DisplayFormat = ',#0.0000'
      Calculated = True
    end
    object cdsCotqryPag: TDataSetField
      FieldName = 'qryPag'
    end
    object cdsCotdstCob: TDataSetField
      FieldName = 'dstCob'
    end
  end
  object dstUsu: TSQLDataSet
    CommandText = 'select * from CJCBUSU where nm_usu=:n'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'n'
        ParamType = ptInput
      end>
    SQLConnection = Con
    Left = 248
    Top = 160
    object dstUsuCD_USU: TIntegerField
      FieldName = 'CD_USU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dstUsuNM_USU: TStringField
      FieldName = 'NM_USU'
      ProviderFlags = [pfInUpdate]
      Size = 15
    end
    object dstUsuDC_FIG: TStringField
      FieldName = 'DC_FIG'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object dstUsuID_ADM: TIntegerField
      FieldName = 'ID_ADM'
      ProviderFlags = [pfInUpdate]
    end
    object dstUsuCD_SENHA: TStringField
      FieldName = 'CD_SENHA'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 10
    end
  end
  object dspUsu: TDataSetProvider
    DataSet = dstUsu
    UpdateMode = upWhereKeyOnly
    Left = 288
    Top = 160
  end
  object cdsUsu: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'n'
        ParamType = ptInput
      end>
    ProviderName = 'dspUsu'
    Left = 328
    Top = 160
    object cdsUsuCD_USU: TIntegerField
      DisplayLabel = 'Cod'
      FieldName = 'CD_USU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      DisplayFormat = '0000'
    end
    object cdsUsuNM_USU: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NM_USU'
      ProviderFlags = [pfInUpdate]
      Size = 15
    end
    object cdsUsuDC_FIG: TStringField
      FieldName = 'DC_FIG'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsUsuID_ADM: TIntegerField
      FieldName = 'ID_ADM'
      ProviderFlags = [pfInUpdate]
    end
    object cdsUsuCD_SENHA: TStringField
      FieldName = 'CD_SENHA'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 10
    end
  end
  object sqlCom: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Con
    Left = 8
    Top = 216
  end
  object AbreFig: TOpenPictureDialog
    Filter = 
      'All (*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wmf)|*.jpg;*.jpeg;*.bmp;*.' +
      'ico;*.emf;*.wmf|JPEG Image File (*.jpg)|*.jpg|JPEG Image File (*' +
      '.jpeg)|*.jpeg|Bitmaps (*.bmp)|*.bmp|Icons (*.ico)|*.ico|Enhanced' +
      ' Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf'
    Left = 8
    Top = 264
  end
  object IL: TImageList
    Left = 8
    Top = 312
    Bitmap = {
      494C01011B001D00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000008000000001002000000000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      000000000000000000000000000000000000000000007F7F7F00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007F7F7F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000FFFFFF007F7F7F007F7F
      7F00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF007F7F7F007F7F7F00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF007F7F7F007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF00000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF007F7F7F000000000000000000FFFFFF000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000000000000000FFFFFF007F7F7F000000
      00007F7F7F00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000000000000000000000007F7F7F00FFFF
      0000FFFF0000FFFF000000000000FFFFFF000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000000000000000007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000000000000000000000007F7F7F00FFFF
      0000FFFF0000FFFF000000000000FFFFFF000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000000000000000000000007F7F7F000000
      00007F7F7F00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF00000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      00007F7F7F000000000000000000FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000FFFFFF00FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000008000000080000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000008000000080000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000080
      0000008000000080000000800000008000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000008000000080
      0000008000000080000000800000008000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000008000000080
      0000000000000000000000800000008000000080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF00000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000007F7F7F0000800000000000000000
      0000000000000000000000000000008000000080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00000000000000000000000000FFFFFF00000000007F7F7F000000
      0000FFFFFF00000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000008000000080000000800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000007F7F7F000000
      0000FFFFFF00000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000080000000800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF000000
      0000FFFFFF00000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000800000008000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF000000000080000000800000007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F0080000000800000000000000000000000000000000000
      00000000FF000000800000008000000080000000800000008000000080000000
      80000000800000000000000000000000000000000000BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00000000007F7F7F0080000000800000008000
      00007F7F7F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F008000000080000000800000007F7F7F000000000000008000000080000000
      00000000FF00BFBFBF0000000000BFBFBF0000000000BFBFBF0000000000BFBF
      BF00000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      000080000000800000007F7F7F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F7F7F00800000008000
      0000800000008000000080000000000000000000800000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000800000000000000000000000000000000000FFFFFF00BFBFBF00FFFF
      FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFF
      FF00BFBFBF00FFFFFF00BFBFBF00000000000000000000000000800000008000
      0000800000008000000080000000800000007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F7F7F008000000080000000800000008000
      0000800000008000000000000000000000000000800000000000000000000000
      0000000000000000FF00BFBFBF0000000000BFBFBF0000000000BFBFBF000000
      FF000000000000000000000000000000000000000000BFBFBF00FFFFFF00BFBF
      BF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBF
      BF00FFFFFF000000FF00FFFFFF000000000000000000000000007F7F7F008000
      00008000000080000000800000008000000080000000800000007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F0080000000800000008000000080000000800000008000
      0000800000007F7F7F0000000000000000000000800000000000000000000000
      000000008000000000000000FF000000FF000000FF000000FF000000FF000000
      00000000800000000000000000000000000000000000FFFFFF00BFBFBF00FFFF
      FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFF
      FF00BFBFBF00FFFFFF00BFBFBF00000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000800000008000
      00007F7F7F000000000000000000000000000000000000000000000000007F7F
      7F00800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000007F7F7F0000000000000080000000
      8000000080000000000000000000000000000000000000000000000000000000
      0000000080000000800000008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000800000008000000080000000800000008000
      000080000000800000007F7F7F0000000000000000007F7F7F00800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000008000000080000000800000008000000080000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF00FFFFFF0000000000FFFFFF00000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000000
      00007F7F7F007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000000
      00007F7F7F007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BFBFBF000000
      0000BFBFBF00BFBFBF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BFBFBF000000
      0000BFBFBF00BFBFBF0000000000000000000000000000000000000000000000
      00007F7F7F3F7F7F7F007F7F7F3F7F7F7F007F7F7F3F7F7F7F007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BFBFBF00BFBF
      BF00BFBFBF00BFBFBF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BFBFBF00BFBF
      BF00BFBFBF00BFBFBF0000000000000000000000000000000000000000000000
      00000000000000000000BFBFBFBFBFBFBF00BFBFBF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000BFFFFFFF00FFFFFFBFFFFF
      FF00FFFFFFBFFFFFFF00FFFFFFBFFFFFFF00FFFFFFBFFFFFFF00FFFFFF000000
      FF00FFFFFFBFFFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000000000FF
      FF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FF
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000BFFFFFFF007F7F7FBFBFBF
      BF00BFBFBFBFBFBFBF00BFBFBFBFBFBFBF00BFBFBFBFBFBFBF00BFBFBFBFBFBF
      BF007F7F7FBFFFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF000000
      000000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBF
      BF0000FFFF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000BFFFFFFF007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BFBFBFBFFFFFFF00000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000BFBFBF0000000000FF000000FF000000FF00
      00000000FF00FF000000FF00000000000000000000000000000000FFFF00FFFF
      FF000000000000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FF
      FF00BFBFBF0000FFFF00000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000BFBFBF0000000000FF000000FF000000FF00
      0000FF000000FF000000FF00000000000000000000BFFFFFFF007F7F7F000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000BFBFBFBFFFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000000000000000FF00000000BFFFFFFF007F7F7F000000
      000000FF00BFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF0000FF00000000
      0000BFBFBFBFFFFFFF00000000000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF0000000000FFFFFF00000000000000FF000000
      FF000000FF000000FF000000FF0000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      FF000000000000000000000000000000FF00000000BFFFFFFF007F7F7F000000
      000000FF00000000FF000000FF0000FF00000000FF000000FF0000FF00000000
      0000BFBFBFBFFFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000
      FF0000000000000000007F7F7F000000FF00000000BFFFFFFF007F7F7F000000
      000000FF00000000FF000000FF0000FF00000000FF000000FF0000FF00000000
      0000BFBFBFBFFFFFFF00000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF00000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF00000000BFFFFFFF007F7F7F000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000BFBFBFBFFFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      FF000000FF000000FF00000000000000000000000000000000000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF00000000BFFFFFFF007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BFBFBFBFFFFFFF00000000000000000000000000FFFFFF0000000000BFBF
      BF00FFFFFF0000000000FFFFFF000000000000000000000000007F7F7F000000
      FF000000FF000000FF00000000000000000000000000000000007F7F7F000000
      00000000000000000000000000007F7F7F000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000BFBF
      BF00FFFFFF0000000000FFFFFF0000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF0000000000000000BFFFFFFF007F7F7F3F7F7F
      7F007F7F7F3F7F7F7F007F7F7F3F7F7F7F007F7F7F3F7F7F7F007F7F7F3F7F7F
      7F007F7F7FBFFFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000000000000000FF000000
      FF0000000000000000000000000000000000000000BFFFFFFF00FFFFFFBFFFFF
      FF00FFFFFFBFFFFFFF00FFFFFFBFFFFFFF00FFFFFFBFFFFFFF00FFFFFFBFFFFF
      FF00FFFFFFBFFFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BFBFBF00BFBFBF007F7F7F007F7F7F007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BFBFBF00BFBFBF007F7F7F007F7F7F007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000BFBF
      BF00BFBFBF007F7F7F000000000000000000000000007F7F7F007F7F7F007F7F
      7F0000000000000000000000000000000000000000000000000000000000BFBF
      BF00BFBFBF007F7F7F000000000000000000000000007F7F7F007F7F7F007F7F
      7F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000BFBFBF00BFBF
      BF0000000000FFFFFF000000FF00FFFFFF000000FF00FFFFFF00000000007F7F
      7F007F7F7F000000000000000000000000000000000000000000BFBFBF00BFBF
      BF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000007F7F
      7F007F7F7F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000BFBFBF000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00007F7F7F000000000000000000000000000000000000000000BFBFBF000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00007F7F7F000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000808080000000000000FFFF00808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF000000000000000000000000000000000000000000BFBFBF007F7F7F00FFFF
      FF0000000000000000000000FF0000008000000080000000000000000000FFFF
      FF007F7F7F007F7F7F00000000000000000000000000BFBFBF007F7F7F00FFFF
      FF00000000000000000000FFFF0000808000008080000000000000000000FFFF
      FF007F7F7F007F7F7F0000000000000000000000000000000000000000008080
      800080808000808080008080800080808000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000BFBFBF00000000000000
      FF00000000000000FF00000080000000FF000000800000008000000000000000
      FF00000000007F7F7F00000000000000000000000000BFBFBF000000000000FF
      FF000000000000FFFF000080800000FFFF0000808000008080000000000000FF
      FF00000000007F7F7F000000000000000000000000000000000080808000FFFF
      FF00C0C0C000FFFFFF00C0C0C000FFFFFF008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF00000000000000FF000000FF000000FF000000FF000000800000000000FFFF
      FF00000000007F7F7F00000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000FFFF0000FFFF0000FFFF0000FFFF000080800000000000FFFF
      FF00000000007F7F7F0000000000000000008080800080808000FFFFFF00C0C0
      C000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF0080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00000000000000
      FF0000000000FFFFFF000000FF000000FF00000080000000FF00000000000000
      FF0000000000BFBFBF00000000000000000000000000FFFFFF000000000000FF
      FF0000000000FFFFFF0000FFFF0000FFFF000080800000FFFF000000000000FF
      FF0000000000BFBFBF0000000000000000000000000080808000C0C0C000FFFF
      FF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C00080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF007F7F7F00FFFF
      FF000000000000000000FFFFFF00FFFFFF000000FF000000000000000000FFFF
      FF007F7F7F00BFBFBF00000000000000000000000000FFFFFF007F7F7F00FFFF
      FF000000000000000000FFFFFF00FFFFFF0000FFFF000000000000000000FFFF
      FF007F7F7F00BFBFBF0000000000000000000000000080808000FFFFFF00C0C0
      C000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF0080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000BFBFBF000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000BFBFBF000000000000000000000000000000000000000000BFBFBF000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000BFBFBF000000000000000000000000000000000080808000C0C0C000FFFF
      FF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C00080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF00FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00BFBF
      BF0000000000FFFFFF000000FF00FFFFFF000000FF00FFFFFF0000000000BFBF
      BF00BFBFBF000000000000000000000000000000000000000000FFFFFF00BFBF
      BF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000BFBF
      BF00BFBFBF000000000000000000000000008080800080808000FFFFFF00C0C0
      C000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF0080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00BFBFBF007F7F7F000000000000000000000000007F7F7F00BFBFBF00BFBF
      BF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00BFBFBF007F7F7F000000000000000000000000007F7F7F00BFBFBF00BFBF
      BF0000000000000000000000000000000000000000000000000080808000FFFF
      FF00C0C0C000FFFFFF00C0C0C000FFFFFF008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00BFBFBF00BFBFBF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00BFBFBF00BFBFBF00000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF0000000000BFBFBF00000000007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000BFBFBF00BFBFBF007F7F7F007F7F7F007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F000000000000000000FFFFFF00FFFFFF00FFFFFF007F7F7F007F7F
      7F0000000000FFFFFF0000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF00000000007F7F7F00000000007F7F7F000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF00000000000000000000000000000000000000000000000000BFBF
      BF00BFBFBF007F7F7F000000000000000000000000007F7F7F007F7F7F007F7F
      7F000000000000000000000000000000000000000000000000007F7F7F000000
      000000000000FFFFFF007F7F7F007F7F7F007F7F7F00FFFFFF00FFFFFF00FFFF
      FF007F7F7F0000000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF0000000000BFBFBF00000000007F7F7F000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000BFBFBF00BFBF
      BF0000000000FFFFFF0000FF0000FFFFFF0000FF0000FFFFFF00000000007F7F
      7F007F7F7F00000000000000000000000000000000007F7F7F00FFFFFF000000
      00007F7F7F007F7F7F000000000000000000000000007F7F7F007F7F7F00FFFF
      FF00FFFFFF007F7F7F00FFFFFF00000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF00000000007F7F7F00000000007F7F7F000000
      000000000000000000000000000000000000000000000000FF00000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000BFBFBF000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00007F7F7F00000000000000000000000000000000007F7F7F00000000007F7F
      7F0000000000000000007F7F7F007F7F7F007F7F7F0000000000000000007F7F
      7F00FFFFFF007F7F7F0000000000FFFFFF000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF0000000000BFBFBF00000000007F7F7F000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF000000000000000000BFBFBF007F7F7F00FFFF
      FF00000000000000000000FF000000800000008000000000000000000000FFFF
      FF007F7F7F007F7F7F0000000000000000007F7F7F00FFFFFF00000000007F7F
      7F00000000007F7F7F000000000000000000000000007F7F7F00000000007F7F
      7F00FFFFFF00FFFFFF007F7F7F00FFFFFF000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF00000000007F7F7F00000000007F7F7F000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000FF000000FF000000000000000000BFBFBF000000000000FF
      00000000000000FF00000080000000FF000000800000008000000000000000FF
      0000000000007F7F7F0000000000000000007F7F7F00FFFFFF007F7F7F000000
      00007F7F7F00FFFFFF00000000000000000000000000000000007F7F7F000000
      00007F7F7F00FFFFFF007F7F7F00FFFFFF000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF0000000000BFBFBF00000000007F7F7F000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000FF000000FF000000000000000000FFFFFF0000000000FFFF
      FF000000000000FF000000FF000000FF000000FF00000080000000000000FFFF
      FF00000000007F7F7F0000000000000000007F7F7F00FFFFFF007F7F7F000000
      00007F7F7F00FFFFFF00000000000000000000000000000000007F7F7F000000
      00007F7F7F00FFFFFF007F7F7F00FFFFFF000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF00000000007F7F7F00000000007F7F7F000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000FF000000FF000000000000000000FFFFFF000000000000FF
      000000000000FFFFFF0000FF000000FF00000080000000FF00000000000000FF
      000000000000BFBFBF0000000000000000007F7F7F00FFFFFF007F7F7F000000
      00007F7F7F00FFFFFF00FFFFFF000000000000000000000000007F7F7F000000
      00007F7F7F00000000007F7F7F00FFFFFF000000000000000000000000000000
      00007F7F7F00000000007F7F7F00000000007F7F7F00000000007F7F7F000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000000000000000FF000000FF000000000000000000FFFFFF007F7F7F00FFFF
      FF000000000000000000FFFFFF00FFFFFF0000FF00000000000000000000FFFF
      FF007F7F7F00BFBFBF0000000000000000007F7F7F0000000000FFFFFF007F7F
      7F00000000007F7F7F00FFFFFF00FFFFFF00FFFFFF007F7F7F00000000007F7F
      7F00FFFFFF00000000007F7F7F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000FF0000000000000000000000000000000000BFBFBF000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000BFBFBF00000000000000000000000000000000007F7F7F00FFFFFF007F7F
      7F0000000000000000007F7F7F007F7F7F007F7F7F0000000000000000007F7F
      7F00000000007F7F7F00FFFFFF0000000000000000000000000000000000FFFF
      FF00BFBFBF00BFBFBF00BFBFBF007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F0000000000000000000000000000000000000000000000FF000000FF000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000FFFFFF00BFBF
      BF0000000000FFFFFF0000FF0000FFFFFF0000FF0000FFFFFF0000000000BFBF
      BF00BFBFBF00000000000000000000000000000000007F7F7F0000000000FFFF
      FF007F7F7F007F7F7F000000000000000000000000007F7F7F007F7F7F000000
      0000000000007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000FF00000000000000000000000000000000000000000000000000FFFF
      FF00BFBFBF007F7F7F000000000000000000000000007F7F7F00BFBFBF00BFBF
      BF000000000000000000000000000000000000000000000000007F7F7F000000
      0000FFFFFF00FFFFFF007F7F7F007F7F7F007F7F7F000000000000000000FFFF
      FF007F7F7F000000000000000000000000000000000000000000000000000000
      000000000000000000007F7F7F007F7F7F007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00BFBFBF00BFBFBF00000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF007F7F7F007F7F
      7F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000FFFF000000
      00007F7F7F007F7F7F007F7F7F0000FFFF0000FFFF007F7F7F007F7F7F007F7F
      7F007F7F7F0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F00000000000000000000000000000000000000000000000000000000000000
      80000000800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF000000000000000000FFFFFF0000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000007F7F7F00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      8000000080000000800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000FFFF0000000000000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000000000
      0000000000007F7F7F00BFBFBF000000000000000000BFBFBF00BFBFBF00BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000FFFF00000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000000000
      0000000000007F7F7F00BFBFBF000000000000000000BFBFBF00BFBFBF00BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000FFFF000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFFFF000000
      000000000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000000000
      0000000000007F7F7F00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000FFFF00000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF00000000000000000000000000000000000000000000FF
      FF0000000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000FFFF000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000FFFF00000000000000FFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000000000000000FF
      FF00FFFFFF0000FFFF00000000000000000000FFFF0000000000FFFFFF00FFFF
      FF000000000000000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      8000000080000000800000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000FF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000FFFFFF00FFFFFF000000000000000000FFFF
      FF0000000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      8000FFFF0000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000000000
      8000FFFF0000FFFF00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF0000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000800000000100010000000000000400000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000F81FF81F80000000F00FF00F00000000
      C003C00300000000C003C0030000000080018001000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      00000000C000000080018001F0000000C003C003FC000000C003C003FC010000
      F00FF00FFC030000F81FF81FFC070000FFFFFFFF8003F81F800180018003F00F
      800180018003C00390F99FF98003C00390F99FF98003800180799FF980030000
      80799FF98003000084399FF9800300001E399FF9800300009E199FF980030000
      9F199FF9800300009F899FF9800380019FC19FF98003C003800180018007C003
      80018001800FF00FFFFFFFFF801FF81F8001FFFFFFFFE00300001FFFFFF8E003
      000007FFFFE08003000081FFFF8160030000C07FFE0370070000C01FF8030000
      0000E007E00700000000F001800F8000E00700000000C001E007F003C00FE003
      E007E00FF007FFFFE007E03FFC07FFFFE00FC0FFFF03FFFFE01F83FFFFC1FFFF
      E03F8FFFFFF1FFFFE07F3FFFFFFCFFFFFF00FFFFFF00C007FF00FFFFFF00E00F
      FF00FFFFFF00F83FFF00FFFFFF0000010000C00F000000010000800700000001
      0000800300000001000080010000000100238001003E00010001800F002E0001
      0000800F000C00010023801F000000010063C0FF0000000100C3C0FF00810001
      0107FFFF01CF000103FFFFFF03EF0001FFFFFFFFFFFDFFFFF83FF83FFFF8E007
      E00FE00FFFF1E007C007C007FFE3E00780038003FFC7E00780038003E08FE007
      00010001C01FE00700010001803FE00700010001001FE00700010001001FE007
      00010001001FE00780038003001FE00F80038003001FE01FC007C007803FE03F
      E00FE00FC07FFFFFF83FF83FE0FFFFFFE00FFFFFFFFFFC1FE00FF83FF83FF027
      E00FE00FE00FE60BE00FCFC7C007D805E00F87E380039381E00FA3F38003AC62
      E00F31F900012BA0A00B38F9000113D0C0073C79000113D0E00F3E39000111D4
      E00F3F1900014825C0079F8B80038C69C0078FC38003A39BC007C7E7C007D067
      F83FE00FE00FE40FF83FF83FF83FF83FC007FC00FF7EFFFFC007FC0090018003
      C0072000C0030001C0070000E0030001C0070000E0030001C0070000E0030001
      C0070000E0030001C007000000010001C007000080000001C0070000E0070001
      C007E000E00F0001C007F800E00F0001C007F000E0270001C007E001C0730001
      C007C4039E790001C007EC077EFE800300000000000000000000000000000000
      000000000000}
  end
  object dstCons: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select grupo, seq, cota, nome, cgc_cpf, pess_f_j,sit_cobr  from ' +
      'accli'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Con
    Left = 248
    Top = 16
  end
  object dspCons: TDataSetProvider
    DataSet = dstCons
    Options = [poAllowCommandText]
    Left = 288
    Top = 16
  end
  object cdsCons: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCons'
    Left = 328
    Top = 16
    object cdsConsGRUPO: TStringField
      DisplayLabel = 'Grupo'
      FieldName = 'GRUPO'
      Size = 4
    end
    object cdsConsSEQ: TStringField
      DisplayLabel = 'Seq'
      FieldName = 'SEQ'
      Required = True
      Size = 2
    end
    object cdsConsCOTA: TStringField
      DisplayLabel = 'Cota'
      FieldName = 'COTA'
      Size = 3
    end
    object cdsConsNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 35
    end
    object cdsConsCGC_CPF: TStringField
      DisplayLabel = 'Cpf/Cnpj'
      FieldName = 'CGC_CPF'
      OnGetText = cdsConsCGC_CPFGetText
      Size = 16
    end
    object cdsConsPESS_F_J: TStringField
      FieldName = 'PESS_F_J'
      Visible = False
      Size = 1
    end
    object cdsConsSIT_COBR: TStringField
      DisplayLabel = 'Sit'
      FieldName = 'SIT_COBR'
      Size = 1
    end
  end
  object dstPesq: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Con
    Left = 248
    Top = 64
  end
  object dspPesq: TDataSetProvider
    DataSet = dstPesq
    Options = [poAllowCommandText]
    Left = 288
    Top = 64
  end
  object cdsPesq: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPesq'
    Left = 328
    Top = 64
  end
  object dstPRS: TSQLDataSet
    CommandText = 'select * from CJCBPRS where cd_prs=0'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Con
    Left = 248
    Top = 112
    object dstPRSCD_PRS: TIntegerField
      FieldName = 'CD_PRS'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dstPRSNM_PRS: TStringField
      FieldName = 'NM_PRS'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object dstPRSCD_CGC: TStringField
      FieldName = 'CD_CGC'
      ProviderFlags = [pfInUpdate]
      Size = 14
    end
    object dstPRSPC_MUL: TFloatField
      FieldName = 'PC_MUL'
      ProviderFlags = [pfInUpdate]
    end
    object dstPRSPC_JUR: TFloatField
      FieldName = 'PC_JUR'
      ProviderFlags = [pfInUpdate]
    end
    object dstPRSPC_HONOR: TFloatField
      FieldName = 'PC_HONOR'
      ProviderFlags = [pfInUpdate]
    end
    object dstPRSULTSAG: TDateField
      DisplayLabel = #218'lt.SAG'
      FieldName = 'ULTSAG'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = 'yyyy-mm'
    end
    object dstPRSNMCONTATO: TStringField
      DisplayLabel = 'Contato '
      FieldName = 'NMCONTATO'
      ProviderFlags = [pfInUpdate]
      Size = 80
    end
    object dstPRSTELCONTATO: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'TELCONTATO'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object dstPRSMAILCONTATO: TStringField
      DisplayLabel = 'Email'
      FieldName = 'MAILCONTATO'
      ProviderFlags = [pfInUpdate]
      Size = 60
    end
    object dstPRSSTRLIB: TStringField
      FieldName = 'STRLIB'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
  end
  object dspPRS: TDataSetProvider
    DataSet = dstPRS
    UpdateMode = upWhereKeyOnly
    Left = 288
    Top = 112
  end
  object cdsPRS: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPRS'
    Left = 328
    Top = 112
    object cdsPRSCD_PRS: TIntegerField
      DisplayLabel = 'C'#243'd'
      FieldName = 'CD_PRS'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      DisplayFormat = '000'
    end
    object cdsPRSNM_PRS: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NM_PRS'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object cdsPRSCD_CGC: TStringField
      DisplayLabel = 'CGC'
      FieldName = 'CD_CGC'
      ProviderFlags = [pfInUpdate]
      EditMask = '99\.999\.999\/9999\-99;0;_'
      Size = 14
    end
    object cdsPRSPC_MUL: TFloatField
      DisplayLabel = 'Multa'
      FieldName = 'PC_MUL'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = ',#0.000'
      EditFormat = ',#0.000'
    end
    object cdsPRSPC_JUR: TFloatField
      DisplayLabel = 'Juros'
      FieldName = 'PC_JUR'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = ',#0.000'
      EditFormat = ',#0.000'
    end
    object cdsPRSPC_HONOR: TFloatField
      DisplayLabel = 'Honor'#225'rios'
      FieldName = 'PC_HONOR'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = ',#0.000'
      EditFormat = ',#0.000'
    end
    object cdsPRSULTSAG: TDateField
      DisplayLabel = #218'lt. Doc.'
      FieldName = 'ULTSAG'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = 'yyyy-mm'
    end
    object cdsPRSNMCONTATO: TStringField
      DisplayLabel = 'Contato'
      FieldName = 'NMCONTATO'
      ProviderFlags = [pfInUpdate]
      Size = 80
    end
    object cdsPRSTELCONTATO: TStringField
      DisplayLabel = 'Fone'
      FieldName = 'TELCONTATO'
      ProviderFlags = [pfInUpdate]
      EditMask = '!\(99\)0000-0000;0;_'
      Size = 10
    end
    object cdsPRSMAILCONTATO: TStringField
      DisplayLabel = 'Email'
      FieldName = 'MAILCONTATO'
      ProviderFlags = [pfInUpdate]
      Size = 60
    end
    object cdsPRSSTRLIB: TStringField
      FieldName = 'STRLIB'
      Visible = False
      Size = 10
    end
  end
  object qryPag: TSQLQuery
    DataSource = dsCot
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'GRUPO'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SEQ'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'COTA'
        ParamType = ptInput
      end>
    SQL.Strings = (
      
        'SELECT M.AVISO, M.TIPO_MOV, T.SIGLA1, M.D_VENCTO, M.DT_PAGTO, M.' +
        'P_NORMAL, M.P_DIFER, M.P_ANTEC, M.P_RATEIO, M.F_AQUISI +M.ADMINI' +
        'ST +'
      
        '       M.F_RESERV+ M.OUTROS as Valor, M.MUL_JUR, M.BEM, M.F_AQUI' +
        'SI, M.ADMINIST, M.F_RESERV,  M.OUTROS , D.SIMBOLO, H.HISTORIC, m' +
        '.d_contab'
      'FROM ACMOV M'
      'INNER JOIN  ACTMV T ON T.COD_MOV=M.TIPO_MOV'
      
        'INNER JOIN ACCLI C ON C.GRUPO=M.GRUPO AND C.SEQ=M.SEQ AND C.COTA' +
        '=M.COTA'
      'INNER JOIN ACTMO D ON M.DT_PAGTO BETWEEN D.DTINI AND D.DTFIM'
      
        'LEFT OUTER JOIN ACHIS H ON H.GRUPO=M.GRUPO AND H.AVISO=M.AVISO A' +
        'ND H.CONTRATO=C.CONTRATO AND H.CONTABIL=M.D_CONTAB'
      'WHERE M.GRUPO=:GRUPO AND M.SEQ=:SEQ AND M.COTA=:COTA'
      'AND T.SAL_CT='#39'S'#39
      'ORDER BY M.DT_PAGTO')
    SQLConnection = Con
    Left = 56
    Top = 112
  end
  object cdsPag: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    DataSetField = cdsCotqryPag
    FieldDefs = <
      item
        Name = 'AVISO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 6
      end
      item
        Name = 'TIPO_MOV'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'SIGLA1'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'D_VENCTO'
        DataType = ftDate
      end
      item
        Name = 'DT_PAGTO'
        DataType = ftDate
      end
      item
        Name = 'P_NORMAL'
        DataType = ftFloat
      end
      item
        Name = 'P_DIFER'
        DataType = ftFloat
      end
      item
        Name = 'P_ANTEC'
        DataType = ftFloat
      end
      item
        Name = 'P_RATEIO'
        DataType = ftFloat
      end
      item
        Name = 'VALOR'
        DataType = ftFloat
      end
      item
        Name = 'MUL_JUR'
        DataType = ftFloat
      end
      item
        Name = 'BEM'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'F_AQUISI'
        DataType = ftFloat
      end
      item
        Name = 'ADMINIST'
        DataType = ftFloat
      end
      item
        Name = 'F_RESERV'
        DataType = ftFloat
      end
      item
        Name = 'OUTROS'
        DataType = ftFloat
      end
      item
        Name = 'SIMBOLO'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'HISTORIC'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'D_CONTAB'
        Attributes = [faRequired]
        DataType = ftDate
      end>
    IndexDefs = <>
    Params = <
      item
        DataType = ftString
        Name = 'g'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 's'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'c'
        ParamType = ptInput
      end>
    StoreDefs = True
    Left = 56
    Top = 160
    object cdsPagAVISO: TStringField
      DisplayLabel = 'Aviso'
      FieldName = 'AVISO'
      Required = True
      Size = 6
    end
    object cdsPagSIGLA1: TStringField
      DisplayLabel = 'Tp Mov'
      FieldName = 'SIGLA1'
      Size = 10
    end
    object cdsPagD_VENCTO: TDateField
      DisplayLabel = 'Vencto.'
      FieldName = 'D_VENCTO'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsPagDT_PAGTO: TDateField
      DisplayLabel = 'Pagto'
      FieldName = 'DT_PAGTO'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsPagP_NORMAL: TFloatField
      DisplayLabel = '% Normal'
      FieldName = 'P_NORMAL'
      DisplayFormat = ',#0.0000'
    end
    object cdsPagP_DIFER: TFloatField
      DisplayLabel = '% Dif.'
      FieldName = 'P_DIFER'
      DisplayFormat = ',#0.0000'
    end
    object cdsPagP_ANTEC: TFloatField
      DisplayLabel = '% Ant.'
      FieldName = 'P_ANTEC'
      DisplayFormat = ',#0.0000'
    end
    object cdsPagVALOR: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      DisplayFormat = ',#0.00'
    end
    object cdsPagMUL_JUR: TFloatField
      DisplayLabel = 'Mul/Jur'
      FieldName = 'MUL_JUR'
      DisplayFormat = ',#0.00'
    end
    object cdsPagP_RATEIO: TFloatField
      FieldName = 'P_RATEIO'
    end
    object cdsPagBEM: TStringField
      FieldName = 'BEM'
      Size = 4
    end
    object cdsPagF_AQUISI: TFloatField
      FieldName = 'F_AQUISI'
      DisplayFormat = ',#0.00'
    end
    object cdsPagADMINIST: TFloatField
      FieldName = 'ADMINIST'
      DisplayFormat = ',#0.00'
    end
    object cdsPagF_RESERV: TFloatField
      FieldName = 'F_RESERV'
      DisplayFormat = ',#0.00'
    end
    object cdsPagOUTROS: TFloatField
      FieldName = 'OUTROS'
      DisplayFormat = ',#0.00'
    end
    object cdsPagSIMBOLO: TStringField
      FieldName = 'SIMBOLO'
      Size = 5
    end
    object cdsPagHISTORIC: TStringField
      FieldName = 'HISTORIC'
      Size = 30
    end
    object cdsPagTIPO_MOV: TStringField
      FieldName = 'TIPO_MOV'
      Size = 2
    end
    object cdsPagD_CONTAB: TDateField
      FieldName = 'D_CONTAB'
      Required = True
    end
  end
  object qryImpCot: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'g'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 's'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'c'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select cob.grupo, cob.seq, cob.cota, cli.nome, '
      'cli.cgc_cpf, cli.pess_f_j, cli.endereco, cli.fil_com,'
      'cli.complemen, cli.bairro, cli.cidade, cli.estado, '
      'cli.cep, cli.telefone, cli.bem, nvl(cli.p_no_pag,0)+ '
      
        'nvl(cli.p_an_pag,0) pcpago, cli.p_no_aqu, cli.p_admins, cli.p_re' +
        'serv,'
      'cob.aviso, cob.tipo_mov, cob.d_vencto, cob.p_normal, '
      'cob.p_difer, cob.f_aquisi, cob.administ, cob.f_reserv, '
      'cob.outros, cob.seg_out, cli.tp_segur, seg.persegvd'
      'from a2cob cob, a2cli cli, actsg seg'
      'where cli.grupo=cob.grupo '
      'and cli.seq=cob.seq '
      'and cli.cota=cob.cota and seg.tp_seg(+)=cli.tp_segur'
      'and cob.grupo=:g and cob.seq=:s and cob.cota=:c')
    SQLConnection = Con
    Left = 448
    Top = 112
    object qryImpCotGRUPO: TStringField
      FieldName = 'GRUPO'
      Required = True
      Size = 4
    end
    object qryImpCotSEQ: TStringField
      FieldName = 'SEQ'
      Required = True
      Size = 2
    end
    object qryImpCotCOTA: TStringField
      FieldName = 'COTA'
      Required = True
      Size = 3
    end
    object qryImpCotNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 35
    end
    object qryImpCotCGC_CPF: TStringField
      FieldName = 'CGC_CPF'
      Required = True
      Size = 16
    end
    object qryImpCotPESS_F_J: TStringField
      FieldName = 'PESS_F_J'
      Required = True
      Size = 1
    end
    object qryImpCotENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 60
    end
    object qryImpCotFIL_COM: TStringField
      FieldName = 'FIL_COM'
      Size = 3
    end
    object qryImpCotCOMPLEMEN: TStringField
      FieldName = 'COMPLEMEN'
    end
    object qryImpCotBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 60
    end
    object qryImpCotCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 30
    end
    object qryImpCotESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 2
    end
    object qryImpCotCEP: TStringField
      FieldName = 'CEP'
      Size = 8
    end
    object qryImpCotTELEFONE: TStringField
      FieldName = 'TELEFONE'
    end
    object qryImpCotBEM: TStringField
      FieldName = 'BEM'
      Size = 4
    end
    object qryImpCotPCPAGO: TFMTBCDField
      FieldName = 'PCPAGO'
      Precision = 32
    end
    object qryImpCotP_NO_AQU: TBCDField
      FieldName = 'P_NO_AQU'
      Precision = 8
    end
    object qryImpCotP_ADMINS: TBCDField
      FieldName = 'P_ADMINS'
      Precision = 7
    end
    object qryImpCotP_RESERV: TBCDField
      FieldName = 'P_RESERV'
      Precision = 7
    end
    object qryImpCotAVISO: TStringField
      FieldName = 'AVISO'
      Required = True
      Size = 6
    end
    object qryImpCotTIPO_MOV: TStringField
      FieldName = 'TIPO_MOV'
      Size = 2
    end
    object qryImpCotD_VENCTO: TSQLTimeStampField
      FieldName = 'D_VENCTO'
      Required = True
    end
    object qryImpCotP_NORMAL: TBCDField
      FieldName = 'P_NORMAL'
      Precision = 8
    end
    object qryImpCotP_DIFER: TBCDField
      FieldName = 'P_DIFER'
      Precision = 8
    end
    object qryImpCotF_AQUISI: TFMTBCDField
      FieldName = 'F_AQUISI'
      Precision = 16
      Size = 2
    end
    object qryImpCotADMINIST: TFMTBCDField
      FieldName = 'ADMINIST'
      Precision = 16
      Size = 2
    end
    object qryImpCotF_RESERV: TFMTBCDField
      FieldName = 'F_RESERV'
      Precision = 16
      Size = 2
    end
    object qryImpCotOUTROS: TFMTBCDField
      FieldName = 'OUTROS'
      Precision = 16
      Size = 2
    end
    object qryImpCotSEG_OUT: TStringField
      FieldName = 'SEG_OUT'
      Size = 1
    end
    object qryImpCotTP_SEGUR: TStringField
      FieldName = 'TP_SEGUR'
      Size = 2
    end
    object qryImpCotPERSEGVD: TFMTBCDField
      FieldName = 'PERSEGVD'
      Precision = 10
      Size = 6
    end
  end
  object dstAge: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select A.*,  C.NOME'#13#10' from CJCBAGE A'#13#10'left outer join ACCLI C on' +
      ' C.GRUPO=A.GRUPO and C.SEQ=A.SEQ and C.COTA=A.COTA'#13#10'where A.CD_U' +
      'SU=:U and A.DT_AGE between :D1 and :D2'#13#10'order by A.PRIORIDADE'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'U'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'D1'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'D2'
        ParamType = ptInput
      end>
    SQLConnection = Con
    Left = 248
    Top = 208
    object dstAgeCD_AGE: TIntegerField
      FieldName = 'CD_AGE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dstAgeDT_AGE: TDateField
      FieldName = 'DT_AGE'
      ProviderFlags = [pfInUpdate]
    end
    object dstAgePRIORIDADE: TIntegerField
      FieldName = 'PRIORIDADE'
      ProviderFlags = [pfInUpdate]
    end
    object dstAgeCD_CTRATO: TStringField
      FieldName = 'CD_CTRATO'
      ProviderFlags = [pfInUpdate]
      Size = 6
    end
    object dstAgeSTATUS: TIntegerField
      FieldName = 'STATUS'
      ProviderFlags = [pfInUpdate]
    end
    object dstAgeOBS: TMemoField
      FieldName = 'OBS'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
      Size = 1
    end
    object dstAgeCD_USU: TIntegerField
      FieldName = 'CD_USU'
      ProviderFlags = [pfInUpdate]
    end
    object dstAgeGRUPO: TStringField
      FieldName = 'GRUPO'
      ProviderFlags = [pfInUpdate]
      Size = 4
    end
    object dstAgeSEQ: TStringField
      FieldName = 'SEQ'
      ProviderFlags = [pfInUpdate]
      Size = 2
    end
    object dstAgeCOTA: TStringField
      FieldName = 'COTA'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
    object dstAgeNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = []
      Size = 35
    end
  end
  object dspAge: TDataSetProvider
    DataSet = dstAge
    UpdateMode = upWhereKeyOnly
    Left = 288
    Top = 208
  end
  object cdsAge: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'U'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'D1'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'D2'
        ParamType = ptInput
      end>
    ProviderName = 'dspAge'
    Left = 328
    Top = 208
    object cdsAgeCD_AGE: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CD_AGE'
      Required = True
      DisplayFormat = '000000'
    end
    object cdsAgeDT_AGE: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DT_AGE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0099;1;_'
    end
    object cdsAgePRIORIDADE: TIntegerField
      DisplayLabel = 'Prioridade'
      FieldName = 'PRIORIDADE'
    end
    object cdsAgeCD_CTRATO: TStringField
      DisplayLabel = 'Contrato'
      FieldName = 'CD_CTRATO'
      Size = 6
    end
    object cdsAgeSTATUS: TIntegerField
      DisplayLabel = 'Status'
      FieldName = 'STATUS'
      OnGetText = cdsAgeSTATUSGetText
    end
    object cdsAgeOBS: TMemoField
      DisplayLabel = 'Obs'
      FieldName = 'OBS'
      BlobType = ftMemo
      Size = 1
    end
    object cdsAgeCD_USU: TIntegerField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'CD_USU'
      DisplayFormat = '000'
    end
    object cdsAgeGRUPO: TStringField
      DisplayLabel = 'Grupo'
      FieldName = 'GRUPO'
      Size = 4
    end
    object cdsAgeSEQ: TStringField
      DisplayLabel = 'Seq'
      FieldName = 'SEQ'
      Size = 2
    end
    object cdsAgeCOTA: TStringField
      DisplayLabel = 'Cota'
      FieldName = 'COTA'
      Size = 3
    end
    object cdsAgeNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      ProviderFlags = []
      Size = 35
    end
  end
  object SelFon: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 8
    Top = 360
  end
  object cdsCar: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 488
    Top = 16
    Data = {
      3B0000009619E0BD0100000018000000010000000000030000003B0005436172
      746104004B0000000100075355425459504502004900050054657874000000}
    object cdsCarCarta: TMemoField
      FieldName = 'Carta'
      BlobType = ftMemo
    end
  end
  object cdsTex: TClientDataSet
    Active = True
    Aggregates = <>
    FileName = 'CARTAS.XML'
    Params = <>
    Left = 488
    Top = 64
    Data = {
      5D1A00009619E0BD010000001800000003000800000003000000D50006436F64
      69676F0400010010000000034F62730100490010000100055749445448020002
      00320005546578746F04004B0010000100075355425459504502004900050054
      6578740001000A4348414E47455F4C4F47040082001800000001000000000000
      0004000000020000000100000008000000030000000200000008000000040000
      0003000000080000000500000004000000080000000600000005000000080000
      0007000000060000000800000008000000070000000800000005000100000005
      5445535445B20000007B5C727466315C616E73695C64656666307B5C666F6E74
      74626C7B5C66305C666E696C204D532053616E732053657269663B7D7D0D0A5C
      766965776B696E64345C7563315C706172645C6C616E67313034365C66305C66
      733136203C2526477275706F253E0D0A5C706172203C252653657175656E6369
      61253E0D0A5C706172203C2526436F7461253E0D0A5C706172200D0A5C706172
      200D0A5C706172203C252644617461253E0D0A5C706172207D0D0A0D00010000
      00055445535445020300007B5C727466315C616E73695C64656666307B5C666F
      6E7474626C7B5C66305C666E696C5C66636861727365743020417269616C3B7D
      7D0D0A5C766965776B696E64345C7563315C706172645C6C616E67313034365C
      6673323420476F695C2765326E69612C203C252644617461253E0D0A5C706172
      200D0A5C70617220506172613A0D0A5C706172205C7461625C625C69203C2526
      4E6F6D65253E5C62305C6930200D0A5C706172205C746162203C2526456E6465
      7265636F253E0D0A5C706172205C746162203C2543266F6D706C656D656E746F
      253E0D0A5C706172205C746162203C252642616972726F253E0D0A5C70617220
      5C746162203C2543266964616465253E2D3C25265546253E2D3C254345265025
      3E0D0A5C706172200D0A5C706172205265663A20477275706F3A203C25264772
      75706F253E20436F74613A203C252653657175656E636961253E2D3C2526436F
      7461253E0D0A5C706172200D0A5C706172200D0A5C706172205072657A61646F
      2053656E686F723A0D0A5C706172200D0A5C70617220536F6C69636974616D6F
      732073657520636F6E7461746F2061747261765C2765397320646F732074656C
      65666F6E6573205C622036322D343030352D323534375C6230202028476F695C
      2765326E6961292C205C622036312D323130312D303038335C62302020284272
      61735C2765646C696129206F75205C622033312D323132322D313932325C6230
      20202842656C6F20486F72697A6F6E7465292C206F752073657520636F6D7061
      726563696D656E746F20656D206E6F73736F73206573637269745C2766337269
      6F732E0D0A5C706172200D0A5C706172204F62733A20436F6E7374616D207065
      6E64656E636961732064652070617263656C617320656D206E6F73736F732072
      656C61745C27663372696F732E0D0A5C706172200D0A5C706172200D0A5C7061
      72204174656E63696F73616D656E74650D0A5C706172200D0A5C706172200D0A
      5C706172200D0A5C70617220436F6272616E5C276537612F4A75725C27656464
      69636F0D0A5C706172207D0D0A0D0001000000055445535445460300007B5C72
      7466315C616E73695C616E7369637067313235325C64656666307B5C666F6E74
      74626C7B5C66305C666E696C5C66636861727365743020417269616C3B7D7D0D
      0A5C766965776B696E64345C7563315C706172645C6C616E67313034365C6673
      323420476F695C2765326E69612C203C252644617461253E0D0A5C706172200D
      0A5C706172200D0A5C706172200D0A5C70617220506172613A0D0A5C70617220
      5C7461625C625C69203C25264E6F6D65253E5C62305C6930200D0A5C70617220
      5C746162203C2526456E64657265636F253E0D0A5C706172205C746162203C25
      43266F6D706C656D656E746F253E0D0A5C706172205C746162203C2526426169
      72726F253E0D0A5C706172205C746162203C2543266964616465253E2D3C2526
      5546253E2D3C2543452650253E0D0A5C706172200D0A5C706172200D0A5C7061
      72200D0A5C706172205265663A20477275706F3A203C2526477275706F253E20
      436F74613A203C252653657175656E636961253E2D3C2526436F7461253E0D0A
      5C706172200D0A5C706172200D0A5C706172200D0A5C706172205072657A6164
      6F2053656E686F723A0D0A5C706172200D0A5C706172200D0A5C70617220536F
      6C69636974616D6F732073657520636F6E7461746F2061747261765C27653973
      20646F732074656C65666F6E6573205C622036322D343030352D323534375C62
      30202028476F695C2765326E6961292C205C622036312D323130312D30303833
      5C6230202028427261735C2765646C696129206F75205C622033312D32313232
      2D313932325C623020202842656C6F20486F72697A6F6E7465292C206F752073
      657520636F6D7061726563696D656E746F20656D206E6F73736F732065736372
      69745C27663372696F732E0D0A5C706172200D0A5C706172204F62733A20436F
      6E7374616D2070656E64656E636961732064652070617263656C617320656D20
      6E6F73736F732072656C61745C27663372696F732E0D0A5C706172200D0A5C70
      6172200D0A5C706172200D0A5C706172204174656E63696F73616D656E74650D
      0A5C706172200D0A5C706172200D0A5C706172200D0A5C706172200D0A5C7061
      7220436F6272616E5C276537612F4A75725C2765646469636F0D0A5C70617220
      7D0D0A0D00010000000554455354456E0300007B5C727466315C616E73695C61
      6E7369637067313235325C64656666307B5C666F6E7474626C7B5C66305C666E
      696C5C66636861727365743020417269616C3B7D7D0D0A5C766965776B696E64
      345C7563315C706172645C6C616E67313034365C6673323420476F695C276532
      6E69612C203C252644617461253E0D0A5C706172200D0A5C706172200D0A5C70
      6172200D0A5C706172205C7461625C74616220496C6D6F2861292E2053722861
      292E3A0D0A5C706172205C7461625C7461625C625C69203C25264E6F6D65253E
      5C62305C6930200D0A5C706172205C7461625C746162203C2526456E64657265
      636F253E0D0A5C706172205C7461625C746162203C2543266F6D706C656D656E
      746F253E0D0A5C706172205C7461625C746162203C252642616972726F253E0D
      0A5C706172205C7461625C746162203C2543266964616465253E2D3C25265546
      253E2D3C2543452650253E0D0A5C706172200D0A5C706172200D0A5C70617220
      0D0A5C706172205265663A20477275706F3A203C2526477275706F253E20436F
      74613A203C252653657175656E636961253E2D3C2526436F7461253E0D0A5C70
      6172200D0A5C706172200D0A5C706172200D0A5C706172205072657A61646F20
      53656E686F723A0D0A5C706172200D0A5C706172200D0A5C70617220536F6C69
      636974616D6F732073657520636F6E7461746F2061747261765C276539732064
      6F732074656C65666F6E6573205C622036322D343030352D323534375C623020
      2028476F695C2765326E6961292C205C622036312D323130312D303038335C62
      30202028427261735C2765646C696129206F75205C622033312D323132322D31
      3932325C623020202842656C6F20486F72697A6F6E7465292C206F7520736575
      20636F6D7061726563696D656E746F20656D206E6F73736F7320657363726974
      5C27663372696F732E0D0A5C706172200D0A5C706172204F62733A20436F6E73
      74616D2070656E64656E636961732064652070617263656C617320656D206E6F
      73736F732072656C61745C27663372696F732E0D0A5C706172200D0A5C706172
      200D0A5C706172200D0A5C706172204174656E63696F73616D656E74650D0A5C
      706172200D0A5C706172200D0A5C706172200D0A5C706172200D0A5C70617220
      436F6272616E5C276537612F4A75725C2765646469636F0D0A5C706172207D0D
      0A0D0001000000055445535445A50300007B5C727466315C616E73695C616E73
      69637067313235325C64656666307B5C666F6E7474626C7B5C66305C666E696C
      5C66636861727365743020417269616C3B7D7D0D0A5C766965776B696E64345C
      7563315C706172645C6C616E67313034365C6673323420476F695C2765326E69
      612C203C252644617461253E0D0A5C706172200D0A5C706172200D0A5C706172
      200D0A5C706172205C7461625C74616220496C6D6F2861292E2053722861292E
      3A0D0A5C706172205C7461625C7461625C625C69203C25264E6F6D65253E5C62
      305C6930200D0A5C706172205C7461625C746162203C2526456E64657265636F
      253E0D0A5C706172205C7461625C746162203C2543266F6D706C656D656E746F
      253E0D0A5C706172205C7461625C746162203C252642616972726F253E0D0A5C
      706172205C7461625C746162203C2543266964616465253E2D3C25265546253E
      2D3C2543452650253E0D0A5C706172200D0A5C706172200D0A5C706172200D0A
      5C706172205265663A20477275706F3A203C2526477275706F253E20436F7461
      3A203C252653657175656E636961253E2D3C2526436F7461253E0D0A5C706172
      200D0A5C706172200D0A5C706172200D0A5C706172205072657A61646F205365
      6E686F723A0D0A5C706172200D0A5C706172200D0A5C70617220536F6C696369
      74616D6F732073657520636F6E7461746F2061747261765C2765397320646F73
      2074656C65666F6E65733A0D0A5C706172200D0A5C706172205C625C74616220
      36322D343030352D323534375C6230202028476F695C2765326E6961292C200D
      0A5C706172205C7461625C622036312D323130312D303038335C623020202842
      7261735C2765646C6961292C206F75200D0A5C706172205C7461625C62203331
      2D323132322D313932325C623020202842656C6F20486F72697A6F6E7465292C
      200D0A5C706172200D0A5C706172206F752073657520636F6D7061726563696D
      656E746F20656D206E6F73736F73206573637269745C27663372696F732E0D0A
      5C706172200D0A5C706172204F62733A20436F6E7374616D2070656E64656E63
      6961732064652070617263656C617320656D206E6F73736F732072656C61745C
      27663372696F732E0D0A5C706172200D0A5C706172200D0A5C706172200D0A5C
      706172204174656E63696F73616D656E74650D0A5C706172200D0A5C70617220
      0D0A5C706172200D0A5C706172200D0A5C70617220436F6272616E5C27653761
      2F4A75725C2765646469636F0D0A5C706172207D0D0A0D000100000005544553
      5445B10300007B5C727466315C616E73695C616E7369637067313235325C6465
      6666307B5C666F6E7474626C7B5C66305C666E696C5C66636861727365743020
      417269616C3B7D7D0D0A5C766965776B696E64345C7563315C706172645C6C61
      6E67313034365C6673323420476F695C2765326E69612C203C25264461746125
      3E0D0A5C706172200D0A5C706172200D0A5C706172200D0A5C706172205C7461
      625C74616220496C6D6F2861292E2053722861292E3A0D0A5C706172205C7461
      625C7461625C625C69203C25264E6F6D65253E5C62305C6930200D0A5C706172
      205C7461625C746162203C2526456E64657265636F253E0D0A5C706172205C74
      61625C746162203C2543266F6D706C656D656E746F253E0D0A5C706172205C74
      61625C746162203C252642616972726F253E0D0A5C706172205C7461625C7461
      62203C2543266964616465253E2D3C25265546253E2D3C2543452650253E0D0A
      5C706172200D0A5C706172200D0A5C706172200D0A5C706172205265663A205C
      756C20477275706F3A203C2526477275706F253E20436F74613A203C25265365
      7175656E636961253E2D3C2526436F7461253E0D0A5C706172205C756C6E6F6E
      65200D0A5C706172200D0A5C706172200D0A5C706172205072657A61646F2053
      656E686F723A0D0A5C706172200D0A5C706172200D0A5C70617220536F6C6963
      6974616D6F732073657520636F6E7461746F2061747261765C2765397320646F
      732074656C65666F6E65733A0D0A5C706172200D0A5C706172205C625C746162
      2036322D343030352D323534375C6230202028476F695C2765326E6961292C20
      0D0A5C706172205C7461625C622036312D323130312D303038335C6230202028
      427261735C2765646C6961292C206F75200D0A5C706172205C7461625C622033
      312D323132322D313932325C623020202842656C6F20486F72697A6F6E746529
      2C200D0A5C706172200D0A5C706172206F752073657520636F6D706172656369
      6D656E746F20656D206E6F73736F73206573637269745C27663372696F732E0D
      0A5C706172200D0A5C706172204F62733A20436F6E7374616D2070656E64656E
      636961732064652070617263656C617320656D206E6F73736F732072656C6174
      5C27663372696F732E0D0A5C706172200D0A5C706172200D0A5C706172200D0A
      5C706172204174656E63696F73616D656E74650D0A5C706172200D0A5C706172
      200D0A5C706172200D0A5C706172200D0A5C70617220436F6272616E5C276537
      612F4A75725C2765646469636F0D0A5C706172207D0D0A0D0001000000055445
      5354459D0300007B5C727466315C616E73695C616E7369637067313235325C64
      656666307B5C666F6E7474626C7B5C66305C666E696C5C666368617273657430
      20417269616C3B7D7D0D0A5C766965776B696E64345C7563315C706172645C6C
      616E67313034365C6673323420476F695C2765326E69612C203C252644617461
      253E0D0A5C706172200D0A5C706172200D0A5C706172200D0A5C706172205C74
      61625C74616220496C6D6F2861292E2053722861292E3A0D0A5C706172205C74
      61625C7461625C62203C25264E6F6D65253E5C6230200D0A5C706172205C7461
      625C746162203C2526456E64657265636F253E203C2543266F6D706C656D656E
      746F253E0D0A5C706172205C7461625C746162203C252642616972726F253E0D
      0A5C706172205C7461625C746162203C2543266964616465253E2D3C25265546
      253E2D3C2543452650253E0D0A5C706172200D0A5C706172200D0A5C70617220
      0D0A5C706172205265663A205C756C20477275706F3A203C2526477275706F25
      3E20436F74613A203C252653657175656E636961253E2D3C2526436F7461253E
      0D0A5C706172205C756C6E6F6E65200D0A5C706172200D0A5C706172200D0A5C
      706172205072657A61646F2053656E686F723A0D0A5C706172200D0A5C706172
      200D0A5C70617220536F6C69636974616D6F732073657520636F6E7461746F20
      61747261765C2765397320646F732074656C65666F6E65733A0D0A5C70617220
      0D0A5C706172205C625C7461622036322D343030352D323534375C6230202028
      476F695C2765326E6961292C200D0A5C706172205C7461625C622036312D3231
      30312D303038335C6230202028427261735C2765646C6961292C206F75200D0A
      5C706172205C7461625C622033312D323132322D313932325C62302020284265
      6C6F20486F72697A6F6E7465292C200D0A5C706172200D0A5C706172206F7520
      73657520636F6D7061726563696D656E746F20656D206E6F73736F7320657363
      7269745C27663372696F732E0D0A5C706172200D0A5C706172204F62733A2043
      6F6E7374616D2070656E64656E636961732064652070617263656C617320656D
      206E6F73736F732072656C61745C27663372696F732E0D0A5C706172200D0A5C
      706172200D0A5C706172200D0A5C706172204174656E63696F73616D656E7465
      0D0A5C706172200D0A5C706172200D0A5C706172200D0A5C706172200D0A5C70
      617220436F6272616E5C276537612F4A75725C2765646469636F0D0A5C706172
      207D0D0A0C0001000000055445535445AD0300007B5C727466315C616E73695C
      616E7369637067313235325C64656666307B5C666F6E7474626C7B5C66305C66
      6E696C5C66636861727365743020417269616C3B7D7D0D0A5C766965776B696E
      64345C7563315C706172645C6C616E67313034365C6673323420476F695C2765
      326E69612C203C252644617461253E0D0A5C706172200D0A5C706172200D0A5C
      706172200D0A5C706172205C7461625C74616220496C6D6F2861292E20537228
      61292E3A0D0A5C706172205C7461625C7461625C62203C25264E6F6D65253E5C
      6230200D0A5C706172205C7461625C746162203C2526456E64657265636F253E
      200D0A5C706172205C7461625C746162203C2543266F6D706C656D656E746F25
      3E0D0A5C706172205C7461625C746162203C252642616972726F253E0D0A5C70
      6172205C7461625C746162203C2543266964616465253E2D3C25265546253E2D
      3C2543452650253E0D0A5C706172200D0A5C706172200D0A5C706172200D0A5C
      706172205265663A205C756C20477275706F3A203C2526477275706F253E2043
      6F74613A203C252653657175656E636961253E2D3C2526436F7461253E0D0A5C
      706172205C756C6E6F6E65200D0A5C706172200D0A5C706172200D0A5C706172
      205072657A61646F2053656E686F723A0D0A5C706172200D0A5C706172200D0A
      5C70617220536F6C69636974616D6F732073657520636F6E7461746F20617472
      61765C2765397320646F732074656C65666F6E65733A0D0A5C706172200D0A5C
      706172205C625C7461622036322D343030352D323534375C6230202028476F69
      5C2765326E6961292C200D0A5C706172205C7461625C622036312D323130312D
      303038335C6230202028427261735C2765646C6961292C206F75200D0A5C7061
      72205C7461625C622033312D323132322D313932325C623020202842656C6F20
      486F72697A6F6E7465292C200D0A5C706172200D0A5C706172206F7520736575
      20636F6D7061726563696D656E746F20656D206E6F73736F7320657363726974
      5C27663372696F732E0D0A5C706172200D0A5C706172204F62733A20436F6E73
      74616D2070656E64656E636961732064652070617263656C617320656D206E6F
      73736F732072656C61745C27663372696F732E0D0A5C706172200D0A5C706172
      200D0A5C706172200D0A5C706172204174656E63696F73616D656E74650D0A5C
      706172200D0A5C706172200D0A5C706172200D0A5C706172200D0A5C70617220
      436F6272616E5C276537612F4A75725C2765646469636F0D0A5C706172207D0D
      0A}
    object cdsTexCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object cdsTexObs: TStringField
      FieldName = 'Obs'
      Size = 50
    end
    object cdsTexTexto: TMemoField
      FieldName = 'Texto'
      BlobType = ftMemo
    end
  end
  object qryAli: TSQLQuery
    DataSource = dsCot
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'GRUPO'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'COTA'
        ParamType = ptInput
      end>
    SQL.Strings = (
      
        'select a.sit_alie, a.dt_alie, a.dt_subst, a.dt_desal, a.fabrican' +
        ', a.lin_mod, a.descric,'
      'a.ano_fabr, a.nr_chass, a.nr_renav, a.placa, a.observac, a.cor'
      'from ACCAL a '
      'where a.grupo=:GRUPO and a.cota=:COTA')
    SQLConnection = Con
    Left = 96
    Top = 208
  end
  object cdsAli: TClientDataSet
    Aggregates = <>
    DataSetField = cdsCotqryAli
    Params = <
      item
        DataType = ftString
        Name = 'g'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'c'
        ParamType = ptInput
      end>
    Left = 96
    Top = 256
    object cdsAliSIT_ALIE: TStringField
      DisplayLabel = 'Sit.'
      FieldName = 'SIT_ALIE'
      Required = True
      Size = 1
    end
    object cdsAliDT_ALIE: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DT_ALIE'
      OnGetText = cdsPagD_VENCTOGetText
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsAliFABRICAN: TStringField
      DisplayLabel = 'Fabricante'
      FieldName = 'FABRICAN'
      Size = 5
    end
    object cdsAliDT_SUBST: TDateField
      DisplayLabel = 'Dt. Subst.'
      FieldName = 'DT_SUBST'
      OnGetText = cdsPagD_VENCTOGetText
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsAliDT_DESAL: TDateField
      DisplayLabel = 'Dt. Desaliena'#231#227'o'
      FieldName = 'DT_DESAL'
      OnGetText = cdsPagD_VENCTOGetText
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsAliLIN_MOD: TStringField
      DisplayLabel = 'Modelo'
      FieldName = 'LIN_MOD'
      Size = 15
    end
    object cdsAliDESCRIC: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRIC'
      Size = 30
    end
    object cdsAliANO_FABR: TStringField
      DisplayLabel = 'Ano Fabr.'
      FieldName = 'ANO_FABR'
      Size = 4
    end
    object cdsAliNR_CHASS: TStringField
      DisplayLabel = 'Chassis'
      FieldName = 'NR_CHASS'
      Required = True
      Size = 25
    end
    object cdsAliNR_RENAV: TStringField
      DisplayLabel = 'Renavam'
      FieldName = 'NR_RENAV'
      Size = 15
    end
    object cdsAliPLACA: TStringField
      DisplayLabel = 'Placa'
      FieldName = 'PLACA'
      Size = 10
    end
    object cdsAliOBSERVAC: TStringField
      DisplayLabel = 'Observa'#231#245'es'
      FieldName = 'OBSERVAC'
      Size = 30
    end
    object cdsAliCOR: TStringField
      DisplayLabel = 'Cor'
      FieldName = 'COR'
      Size = 15
    end
  end
  object dstBem: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 'select DESCRIC, FABRICAN, TIPO_BEM'#13#10' from ACBEM'#13#10'where BEM=:BEM'
    DataSource = dsCot
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'BEM'
        ParamType = ptInput
      end>
    SQLConnection = Con
    Left = 97
    Top = 112
  end
  object sdsBem: TClientDataSet
    Aggregates = <>
    DataSetField = cdsCotdstBem
    Params = <
      item
        DataType = ftString
        Name = 'b'
        ParamType = ptInput
      end>
    Left = 97
    Top = 160
    object sdsBemDESCRIC: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRIC'
      Size = 30
    end
    object sdsBemFABRICAN: TStringField
      DisplayLabel = 'Fabricante'
      FieldName = 'FABRICAN'
      Size = 5
    end
    object sdsBemTIPO_BEM: TStringField
      DisplayLabel = 'Tipo Bem'
      FieldName = 'TIPO_BEM'
      Size = 5
    end
  end
  object dstPre: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select DT_BASE, PRE_TABE from ACPRE'#13#10'where TP_PRECO='#39'R'#39' and FILI' +
      'AL=:FIL_COM and BEM=:BEM'#13#10'order by DT_BASE desc'
    DataSource = dsCot
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'FIL_COM'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'BEM'
        ParamType = ptInput
      end>
    SQLConnection = Con
    Left = 137
    Top = 114
  end
  object sdsPre: TClientDataSet
    Aggregates = <>
    DataSetField = cdsCotdstPre
    Params = <
      item
        DataType = ftString
        Name = 'f'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'b'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'd'
        ParamType = ptInput
      end>
    Left = 137
    Top = 160
    object sdsPreDT_BASE: TDateField
      DisplayLabel = 'Data Base'
      FieldName = 'DT_BASE'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object sdsPrePRE_TABE: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'PRE_TABE'
      DisplayFormat = ',#0.00'
    end
  end
  object dstReu: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select  NRO_REU, DATA_REU from ACREU'#13#10'where GRUPO=:GRUPO'#13#10'order ' +
      'by NRO_REU'
    DataSource = dsGru
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'GRUPO'
        ParamType = ptInput
      end>
    SQLConnection = Con
    Left = 288
    Top = 304
  end
  object sdsReu: TClientDataSet
    Aggregates = <>
    DataSetField = cdsGrudstReu
    Params = <
      item
        DataType = ftString
        Name = 'g'
        ParamType = ptInput
      end>
    Left = 328
    Top = 304
    object sdsReuNRO_REU: TStringField
      DisplayLabel = 'Reuni'#227'o'
      FieldName = 'NRO_REU'
      Required = True
      Size = 3
    end
    object sdsReuDATA_REU: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATA_REU'
      DisplayFormat = 'dd/mm/yyyy'
    end
  end
  object qryTab: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 't'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'c'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select descric from ACTAB'
      'where tabela=:t and codigo=:c')
    SQLConnection = Con
    Left = 448
    Top = 16
    object qryTabDESCRIC: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRIC'
      Size = 30
    end
  end
  object dstCob: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select C.AVISO, C.TIPO_MOV, T.SIGLA1, C.D_VENCTO, C.P_NORMAL+C.P' +
      '_DIFER+C.P_SUBST PCNOR, C.P_RATEIO,'#13#10'(C.F_AQUISI+C.F_RESERV+C.OU' +
      'TROS+C.ADMINIST) VALOR, C.OUTROS, C.F_AQUISI,C.F_RESERV,C.ADMINI' +
      'ST'#13#10'from ACCOB C'#13#10'inner join ACTMV T on T.COD_MOV=C.TIPO_MOV'#13#10'wh' +
      'ere C.GRUPO=:GRUPO and C.SEQ=:SEQ and C.COTA=:COTA'#13#10'order by C.D' +
      '_VENCTO DESC'
    DataSource = dsCot
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'GRUPO'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SEQ'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'COTA'
        ParamType = ptInput
      end>
    SQLConnection = Con
    Left = 96
    Top = 64
  end
  object cdsCob: TClientDataSet
    Aggregates = <>
    DataSetField = cdsCotdstCob
    Params = <
      item
        DataType = ftString
        Name = 'G'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'S'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'C'
        ParamType = ptInput
      end>
    Left = 136
    Top = 64
    object cdsCobAVISO: TStringField
      DisplayLabel = 'Aviso'
      FieldName = 'AVISO'
      Required = True
      Size = 6
    end
    object cdsCobSIGLA1: TStringField
      DisplayLabel = 'Tipo Movto'
      FieldName = 'SIGLA1'
      Size = 10
    end
    object cdsCobD_VENCTO: TDateField
      DisplayLabel = 'Vencto'
      FieldName = 'D_VENCTO'
      OnGetText = cdsPagD_VENCTOGetText
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsCobPCNOR: TFloatField
      DisplayLabel = '% Normal'
      FieldName = 'PCNOR'
      DisplayFormat = ',#0.0000'
    end
    object cdsCobP_RATEIO: TFloatField
      DisplayLabel = '% Rateio'
      FieldName = 'P_RATEIO'
      DisplayFormat = ',#0.0000'
    end
    object cdsCobVALOR: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      DisplayFormat = ',#0.00'
    end
    object cdsCobTIPO_MOV: TStringField
      FieldName = 'TIPO_MOV'
      Size = 2
    end
    object cdsCobOUTROS: TFloatField
      FieldName = 'OUTROS'
    end
    object cdsCobF_AQUISI: TFloatField
      FieldName = 'F_AQUISI'
    end
    object cdsCobF_RESERV: TFloatField
      FieldName = 'F_RESERV'
    end
    object cdsCobADMINIST: TFloatField
      FieldName = 'ADMINIST'
    end
  end
  object dstJur: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select j.grupo, j.seq, j.cota, t.descric, j.d_inicio, r.nome, j.' +
      'cust_moe, j.observ'#13#10'from ACJUD j'#13#10'left outer join ACREP r on r.r' +
      'epres=j.repres'#13#10'inner join ACTAB t on t.tabela='#39'012'#39' and j.f_jur' +
      'id=t.codigo'#13#10'where j.grupo=:GRUPO and j.seq=:SEQ and j.cota=:COT' +
      'A'#13#10'order by j.grupo,j.seq,j.cota'
    DataSource = dsCot
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'GRUPO'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SEQ'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'COTA'
        ParamType = ptInput
      end>
    SQLConnection = Con
    Left = 56
    Top = 210
  end
  object sdsJur: TClientDataSet
    Aggregates = <>
    DataSetField = cdsCotdstJur
    Params = <
      item
        DataType = ftString
        Name = 'g'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 's'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'c'
        ParamType = ptInput
      end>
    Left = 56
    Top = 258
    object sdsJurGRUPO: TStringField
      DisplayLabel = 'Grupo'
      FieldName = 'GRUPO'
      Required = True
      Size = 4
    end
    object sdsJurSEQ: TStringField
      DisplayLabel = 'Seq'
      FieldName = 'SEQ'
      Required = True
      Size = 2
    end
    object sdsJurCOTA: TStringField
      DisplayLabel = 'Cota'
      FieldName = 'COTA'
      Required = True
      Size = 3
    end
    object sdsJurDESCRIC: TStringField
      DisplayLabel = 'Fase'
      FieldName = 'DESCRIC'
      Size = 30
    end
    object sdsJurD_INICIO: TDateField
      DisplayLabel = 'In'#237'cio'
      FieldName = 'D_INICIO'
      OnGetText = cdsPagD_VENCTOGetText
      DisplayFormat = 'dd/mm/yyyy'
    end
    object sdsJurNOME: TStringField
      DisplayLabel = 'Advogado'
      FieldName = 'NOME'
      Size = 35
    end
    object sdsJurCUST_MOE: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'CUST_MOE'
      DisplayFormat = ',#0.00'
    end
    object sdsJurOBSERV: TStringField
      DisplayLabel = 'Observa'#231#227'o'
      FieldName = 'OBSERV'
      Size = 35
    end
  end
  object dsCot: TDataSource
    DataSet = dstCot
    Left = 56
    Top = 64
  end
  object dstGru: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 'select * from ACGRU g where g.grupo=:g'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'g'
        ParamType = ptInput
      end>
    SQLConnection = Con
    Left = 248
    Top = 256
  end
  object dspGru: TDataSetProvider
    DataSet = dstGru
    Left = 288
    Top = 256
  end
  object cdsGru: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'g'
        ParamType = ptInput
      end>
    ProviderName = 'dspGru'
    Left = 328
    Top = 256
    object cdsGruGRUPO: TStringField
      DisplayLabel = 'Grupo'
      FieldName = 'GRUPO'
      Required = True
      Size = 4
    end
    object cdsGruPLA_PADR: TStringField
      DisplayLabel = 'Plano'
      FieldName = 'PLA_PADR'
      Size = 3
    end
    object cdsGrudstReu: TDataSetField
      FieldName = 'dstReu'
    end
  end
  object dsGru: TDataSource
    DataSet = dstGru
    Left = 248
    Top = 304
  end
  object dstCre: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select C.*, T.DESCRIC DCTPCRE from ACCEN C'#13#10'inner join ACTAB T o' +
      'n T.TABELA='#39'031'#39' and T.CODIGO=C.TP_CRED'#13#10' where C.GRUPO=:GRUPO a' +
      'nd C.COTA=:COTA'
    DataSource = dsCot
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'GRUPO'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'COTA'
        ParamType = ptInput
      end>
    SQLConnection = Con
    Left = 136
    Top = 208
  end
  object cdsCre: TClientDataSet
    Aggregates = <>
    DataSetField = cdsCotdstCre
    Params = <>
    Left = 136
    Top = 256
    object cdsCreGRUPO: TStringField
      FieldName = 'GRUPO'
      Required = True
      Size = 4
    end
    object cdsCreCOTA: TStringField
      FieldName = 'COTA'
      Required = True
      Size = 3
    end
    object cdsCreCREDITO: TStringField
      DisplayLabel = 'Cr'#233'dito'
      FieldName = 'CREDITO'
      Required = True
      Size = 4
    end
    object cdsCreVAL_CRED: TFloatField
      DisplayLabel = 'Vlr. Cr'#233'dito'
      FieldName = 'VAL_CRED'
      DisplayFormat = ',#0.00'
    end
    object cdsCreVAL_REAJ: TFloatField
      DisplayLabel = 'Vlr. Reaj.'
      FieldName = 'VAL_REAJ'
      DisplayFormat = ',#0.00'
    end
    object cdsCreVAL_CORR: TFloatField
      DisplayLabel = 'Vlr. Corr.'
      FieldName = 'VAL_CORR'
      DisplayFormat = ',#0.00'
    end
    object cdsCreLIM_CORR: TDateField
      DisplayLabel = 'Lim. Corre'#231#227'o'
      FieldName = 'LIM_CORR'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsCreTP_CRED: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 10
      FieldName = 'TP_CRED'
      Size = 2
    end
    object cdsCreBEM_OPC: TStringField
      FieldName = 'BEM_OPC'
      Size = 4
    end
    object cdsCreBEM: TStringField
      FieldName = 'BEM'
      Size = 4
    end
    object cdsCreCOMPLEM: TStringField
      FieldName = 'COMPLEM'
      Size = 35
    end
    object cdsCreFORNEC: TStringField
      FieldName = 'FORNEC'
      OnGetText = cdsCreFORNECGetText
      Size = 6
    end
    object cdsCreVAL_PEDI: TFloatField
      FieldName = 'VAL_PEDI'
    end
    object cdsCreOBSERV: TStringField
      FieldName = 'OBSERV'
      Size = 35
    end
    object cdsCreCOMPRAD: TStringField
      FieldName = 'COMPRAD'
      Size = 6
    end
    object cdsCreD_BEM_OP: TStringField
      FieldName = 'D_BEM_OP'
      Size = 30
    end
    object cdsCreDT_PEDID: TDateField
      FieldName = 'DT_PEDID'
      OnGetText = cdsPagD_VENCTOGetText
    end
    object cdsCreALIENADO: TStringField
      FieldName = 'ALIENADO'
      Size = 1
    end
    object cdsCreDT_PAGTO: TDateField
      DisplayLabel = 'Pagto'
      FieldName = 'DT_PAGTO'
      OnGetText = cdsPagD_VENCTOGetText
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsCreF_L_COMP: TStringField
      FieldName = 'F_L_COMP'
      Size = 5
    end
    object cdsCreDT_L_PAG: TDateField
      FieldName = 'DT_L_PAG'
      OnGetText = cdsPagD_VENCTOGetText
    end
    object cdsCreVAL_LIBE: TFloatField
      FieldName = 'VAL_LIBE'
    end
    object cdsCreCOR_LIBE: TFloatField
      FieldName = 'COR_LIBE'
    end
    object cdsCreVAL_OPC: TFloatField
      FieldName = 'VAL_OPC'
    end
    object cdsCreVAL_ENTR: TFloatField
      DisplayLabel = 'Vlr. Entregue'
      FieldName = 'VAL_ENTR'
      DisplayFormat = ',#0.00'
    end
    object cdsCreCOR_ENTR: TFloatField
      DisplayLabel = 'Corr. Entregue'
      FieldName = 'COR_ENTR'
      DisplayFormat = ',#0.00'
    end
    object cdsCreUSUARIO: TStringField
      FieldName = 'USUARIO'
      Size = 4
    end
    object cdsCreD_ATUALI: TDateField
      FieldName = 'D_ATUALI'
      OnGetText = cdsPagD_VENCTOGetText
    end
    object cdsCreDT_N_FIS: TDateField
      DisplayLabel = 'Dt. Nota Fiscal'
      FieldName = 'DT_N_FIS'
      OnGetText = cdsPagD_VENCTOGetText
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsCreNR_N_FIS: TStringField
      DisplayLabel = 'Nota Fiscal'
      FieldName = 'NR_N_FIS'
      Size = 15
    end
    object cdsCreDT_I_COR: TDateField
      FieldName = 'DT_I_COR'
      OnGetText = cdsPagD_VENCTOGetText
    end
    object cdsCreADIANTAM: TStringField
      FieldName = 'ADIANTAM'
      Size = 1
    end
    object cdsCreNUMEROAP: TStringField
      FieldName = 'NUMEROAP'
      Size = 6
    end
    object cdsCreAGENTE: TStringField
      FieldName = 'AGENTE'
      Size = 6
    end
    object cdsCreD_CONTAB: TDateField
      FieldName = 'D_CONTAB'
      OnGetText = cdsPagD_VENCTOGetText
    end
    object cdsCreNUMAVISO: TStringField
      FieldName = 'NUMAVISO'
      Size = 6
    end
    object cdsCreDCTPCRE: TStringField
      FieldName = 'DCTPCRE'
      Size = 30
    end
  end
  object dstSeg: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 'select nome_fant, persegvd from ACTSG where tp_seg=:TP_SEGUR'
    DataSource = dsCot
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'TP_SEGUR'
        ParamType = ptInput
      end>
    SQLConnection = Con
    Left = 54
    Top = 304
  end
  object cdsSeg: TClientDataSet
    Aggregates = <>
    DataSetField = cdsCotdstSeg
    Params = <>
    Left = 96
    Top = 304
    object cdsSegNOME_FANT: TStringField
      DisplayLabel = 'Tipo Seguro'
      FieldName = 'NOME_FANT'
      Size = 15
    end
    object cdsSegPERSEGVD: TFloatField
      DisplayLabel = '% Seg Vida'
      FieldName = 'PERSEGVD'
      DisplayFormat = ',#0.000000'
    end
  end
  object RvPrj: TRvProject
    Engine = RvSys
    ProjectFile = 
      'C:\Documents and Settings\user\Meus documentos\Borland Studio Pr' +
      'ojects\cca\Cons.rav'
    Left = 8
    Top = 64
  end
  object RvSys: TRvSystem
    TitleSetup = 'Op'#231#245'es de Sa'#237'da'
    TitleStatus = 'Posi'#231#227'o do Relat'#243'rio'
    TitlePreview = 'Posi'#231#227'o de Consorciado'
    SystemOptions = [soShowStatus, soAllowPrintFromPreview, soAllowSaveFromPreview]
    SystemFiler.StatusFormat = 'Gerando P'#225'g %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Imprimindo P'#225'g %p'
    SystemPrinter.Title = 'Relat'#243'rio'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 8
    Top = 112
  end
  object RndPDF: TRvRenderPDF
    DisplayName = 'Adobe Acrobat (PDF)'
    FileExtension = '*.pdf'
    EmbedFonts = False
    ImageQuality = 90
    MetafileDPI = 300
    FontEncoding = feWinAnsiEncoding
    DocInfo.Creator = 'Rave Reports (http://www.nevrona.com/rave)'
    DocInfo.Producer = 'Nevrona Designs'
    BufferDocument = True
    DisableHyperlinks = False
    Left = 184
    Top = 304
  end
  object RvDSCot: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = cdsCot
    Left = 184
    Top = 16
  end
  object RvDSGru: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = cdsGru
    Left = 376
    Top = 256
  end
  object RvDSCob: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = cdsCb1
    Left = 184
    Top = 64
  end
  object RvDSBem: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = sdsBem
    Left = 184
    Top = 112
  end
  object RvDSJur: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = sdsJur
    Left = 184
    Top = 208
  end
  object RvDSAli: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = cdsAli
    Left = 184
    Top = 256
  end
  object RvDSPrs: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = cdsPRS
    Left = 376
    Top = 112
  end
  object RvDSUsu: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = cdsUsu
    Left = 376
    Top = 160
  end
  object SQLMon: TSQLMonitor
    FileName = 
      'C:\Documents and Settings\user\Meus documentos\Borland Studio Pr' +
      'ojects\cca\sql.log'
    SQLConnection = Con
    Left = 376
    Top = 16
  end
  object RvDSPre: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = sdsPre
    Left = 136
    Top = 304
  end
  object RvDSCre: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = cdsCre
    Left = 376
    Top = 304
  end
  object RvDSSeg: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = cdsSeg
    Left = 456
    Top = 256
  end
  object RvDSMov: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = cdsMov
    Left = 504
    Top = 304
  end
  object sqlRGru: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select c.grupo, g.pla_padr, g.lim_cota, g.prim_reu, g.sit_gru, c' +
      '.seq, c.cota, c.nome, b.lin_mod,'#13#10'c.sit_cobr, c.p_no_pag+c.p_an_' +
      'pag+c.p_su_pag perpago, c.dt_ades, c.tp_conte, c.dt_conte, c.dt_' +
      'entre  from ACCLI C'#13#10'inner join ACGRU G on G.GRUPO=C.GRUPO'#13#10'inne' +
      'r join ACBEM B on B.BEM=C.BEM'#13#10'where c.grupo between :gri and :g' +
      'rf and c.sit_cobr between :si and :sf'#13#10'order by c.grupo,c.seq,c.' +
      'cota'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'gri'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'grf'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'si'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sf'
        ParamType = ptInput
      end>
    SQLConnection = Con
    Left = 544
    Top = 16
  end
  object dspRGru: TDataSetProvider
    DataSet = sqlRGru
    Left = 544
    Top = 64
  end
  object cdsRGru: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'gri'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'grf'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'si'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sf'
        ParamType = ptInput
      end>
    ProviderName = 'dspRGru'
    OnCalcFields = cdsRGruCalcFields
    Left = 544
    Top = 112
    object cdsRGruGRUPO: TStringField
      FieldName = 'GRUPO'
      Required = True
      Size = 4
    end
    object cdsRGruPLA_PADR: TStringField
      FieldName = 'PLA_PADR'
      Size = 3
    end
    object cdsRGruLIM_COTA: TStringField
      FieldName = 'LIM_COTA'
      Size = 3
    end
    object cdsRGruPRIM_REU: TDateField
      FieldName = 'PRIM_REU'
      OnGetText = cdsPagD_VENCTOGetText
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsRGruSIT_GRU: TStringField
      FieldName = 'SIT_GRU'
      Size = 5
    end
    object cdsRGruSEQ: TStringField
      FieldName = 'SEQ'
      Required = True
      Size = 2
    end
    object cdsRGruCOTA: TStringField
      FieldName = 'COTA'
      Required = True
      Size = 3
    end
    object cdsRGruNOME: TStringField
      FieldName = 'NOME'
      Size = 35
    end
    object cdsRGruLIN_MOD: TStringField
      FieldName = 'LIN_MOD'
      Size = 15
    end
    object cdsRGruSIT_COBR: TStringField
      FieldName = 'SIT_COBR'
      OnGetText = cdsCotSIT_COBRGetText
      Size = 1
    end
    object cdsRGruPERPAGO: TFloatField
      FieldName = 'PERPAGO'
      DisplayFormat = ',#0.0000'
    end
    object cdsRGruDT_ADES: TDateField
      FieldName = 'DT_ADES'
      OnGetText = cdsPagD_VENCTOGetText
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsRGruTP_CONTE: TStringField
      FieldName = 'TP_CONTE'
      Size = 1
    end
    object cdsRGruDT_CONTE: TDateField
      FieldName = 'DT_CONTE'
      OnGetText = cdsPagD_VENCTOGetText
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsRGruDT_ENTRE: TDateField
      FieldName = 'DT_ENTRE'
      OnGetText = cdsPagD_VENCTOGetText
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsRGruPerDev: TFloatField
      FieldKind = fkCalculated
      FieldName = 'PerDev'
      DisplayFormat = ',#0.0000'
      Calculated = True
    end
  end
  object rvRGru: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = cdsRGru
    Left = 544
    Top = 160
  end
  object sqlPen: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select c.grupo,c.cota, l.nome, l.cidade, l.estado, l.telefone, l' +
      '.p_an_pag+l.p_no_pag+p_su_pag pcpag, l.fil_com, l.bem,'#13#10'100-(l.p' +
      '_an_pag+l.p_no_pag+p_su_pag) pcdev, l.sit_cobr, l.tp_conte, l.dt' +
      '_conte, l.dt_entre, b.lin_mod,'#13#10'1+((l.p_admins+l.p_reserv)/100) ' +
      'taxas,t.mul_jur, T.SIGLA1, C.D_VENCTO, c.p_normal+c.p_difer+c.p_' +
      'subst pcnor, c.p_rateio,'#13#10'(c.administ+c.f_reserv+c.f_aquisi+c.ou' +
      'tros) valor'#13#10'  from ACCOB C'#13#10'inner join ACCLI L on L.GRUPO=C.GRU' +
      'PO and L.SEQ='#39'00'#39' and L.COTA=C.COTA'#13#10'inner join ACBEM B on B.BEM' +
      '=L.BEM'#13#10'inner join ACTMV T on T.COD_MOV=C.TIPO_MOV'#13#10'where c.grup' +
      'o between :g1 and :g2 and l.sit_cobr between :s1 and :s2'#13#10'order ' +
      'by c.grupo,c.cota'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'g1'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'g2'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 's1'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 's2'
        ParamType = ptInput
      end>
    SQLConnection = Con
    Left = 592
    Top = 16
  end
  object dspPend: TDataSetProvider
    DataSet = sqlPen
    Left = 592
    Top = 64
  end
  object cdsPen: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'g1'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'g2'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 's1'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 's2'
        ParamType = ptInput
      end>
    ProviderName = 'dspPend'
    Left = 592
    Top = 112
    object cdsPenGRUPO: TStringField
      FieldName = 'GRUPO'
      Required = True
      Size = 4
    end
    object cdsPenCOTA: TStringField
      FieldName = 'COTA'
      Required = True
      Size = 3
    end
    object cdsPenNOME: TStringField
      FieldName = 'NOME'
      Size = 35
    end
    object cdsPenCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 25
    end
    object cdsPenESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 2
    end
    object cdsPenTELEFONE: TStringField
      FieldName = 'TELEFONE'
    end
    object cdsPenPCPAG: TFloatField
      FieldName = 'PCPAG'
    end
    object cdsPenPCDEV: TFloatField
      FieldName = 'PCDEV'
    end
    object cdsPenSIT_COBR: TStringField
      FieldName = 'SIT_COBR'
      Size = 1
    end
    object cdsPenTP_CONTE: TStringField
      FieldName = 'TP_CONTE'
      Size = 1
    end
    object cdsPenDT_CONTE: TDateField
      FieldName = 'DT_CONTE'
    end
    object cdsPenDT_ENTRE: TDateField
      FieldName = 'DT_ENTRE'
    end
    object cdsPenLIN_MOD: TStringField
      FieldName = 'LIN_MOD'
      Size = 15
    end
    object cdsPenTAXAS: TFloatField
      FieldName = 'TAXAS'
    end
    object cdsPenSIGLA1: TStringField
      FieldName = 'SIGLA1'
      Size = 10
    end
    object cdsPenD_VENCTO: TDateField
      FieldName = 'D_VENCTO'
    end
    object cdsPenPCNOR: TFloatField
      FieldName = 'PCNOR'
    end
    object cdsPenP_RATEIO: TFloatField
      FieldName = 'P_RATEIO'
    end
    object cdsPenFIL_COM: TStringField
      FieldName = 'FIL_COM'
      Size = 3
    end
    object cdsPenBEM: TStringField
      FieldName = 'BEM'
      Size = 4
    end
    object cdsPenVALOR: TFloatField
      FieldName = 'VALOR'
    end
    object cdsPenMUL_JUR: TStringField
      FieldName = 'MUL_JUR'
      Size = 1
    end
  end
  object rvDSPen: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = cdsRelPend
    Left = 592
    Top = 208
  end
  object cdsRelPend: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    OnCalcFields = cdsRelPendCalcFields
    Left = 592
    Top = 160
    Data = {
      EE0100009619E0BD010000001800000016000000000003000000EE0105477275
      706F010049000000010005574944544802000200040004436F74610100490000
      000100055749445448020002000300044E6F6D65010049000000010005574944
      5448020002002300064369646164650100490000000100055749445448020002
      001E0004466F6E65010049000000010005574944544802000200140006506350
      61676F0800040000000000055063446576080004000000000006536974436F62
      01004900000001000557494454480200020001000342656D0100490000000100
      055749445448020002000F00065470436F6E7401004900000001000557494454
      48020002000100064474436F6E74010049000000010005574944544802000200
      0A00064474456E74720100490000000100055749445448020002000A00035265
      75010049000000010005574944544802000200030005547050656E0100490000
      000100055749445448020002000A000656656E63746F01004900000001000557
      49445448020002000A0005566C42656D08000400000000000850634E6F726D61
      6C0800040000000000055063526174080004000000000006566C50656E640800
      04000000000005566C4D756C080004000000000005566C4A7572080004000000
      000005566C546F7408000400000000000000}
    object cdsRelPendGrupo: TStringField
      FieldName = 'Grupo'
      Size = 4
    end
    object cdsRelPendCota: TStringField
      FieldName = 'Cota'
      Size = 3
    end
    object cdsRelPendNome: TStringField
      FieldName = 'Nome'
      Size = 35
    end
    object cdsRelPendCidade: TStringField
      FieldName = 'Cidade'
      Size = 30
    end
    object cdsRelPendFone: TStringField
      FieldName = 'Fone'
    end
    object cdsRelPendPcPago: TFloatField
      FieldName = 'PcPago'
      DisplayFormat = ',#0.0000'
    end
    object cdsRelPendPcDev: TFloatField
      FieldName = 'PcDev'
      DisplayFormat = ',#0.0000'
    end
    object cdsRelPendSitCob: TStringField
      FieldName = 'SitCob'
      Size = 1
    end
    object cdsRelPendBem: TStringField
      FieldName = 'Bem'
      Size = 15
    end
    object cdsRelPendTpCont: TStringField
      FieldName = 'TpCont'
      Size = 1
    end
    object cdsRelPendDtCont: TStringField
      FieldName = 'DtCont'
      Size = 10
    end
    object cdsRelPendDtEntr: TStringField
      FieldName = 'DtEntr'
      Size = 10
    end
    object cdsRelPendReu: TStringField
      FieldName = 'Reu'
      Size = 3
    end
    object cdsRelPendTpPen: TStringField
      FieldName = 'TpPen'
      Size = 10
    end
    object cdsRelPendVencto: TStringField
      FieldName = 'Vencto'
      Size = 10
    end
    object cdsRelPendVlBem: TFloatField
      FieldName = 'VlBem'
      DisplayFormat = ',#0.00'
    end
    object cdsRelPendPcNormal: TFloatField
      FieldName = 'PcNormal'
      DisplayFormat = ',#0.0000'
    end
    object cdsRelPendPcRat: TFloatField
      FieldName = 'PcRat'
      DisplayFormat = ',#0.0000'
    end
    object cdsRelPendVlPend: TFloatField
      FieldName = 'VlPend'
      DisplayFormat = ',#0.00'
    end
    object cdsRelPendVlMul: TFloatField
      FieldName = 'VlMul'
      DisplayFormat = ',#0.00'
    end
    object cdsRelPendVlJur: TFloatField
      FieldName = 'VlJur'
      DisplayFormat = ',#0.00'
    end
    object cdsRelPendVlTot: TFloatField
      FieldName = 'VlTot'
      DisplayFormat = ',#0.00'
    end
    object cdsRelPendVlMulJur: TFloatField
      FieldKind = fkCalculated
      FieldName = 'VlMulJur'
      DisplayFormat = ',#0.00'
      Calculated = True
    end
  end
  object QryMoeda: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftDate
        Name = 'd'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select * from actmo'
      'where dtfim >= :d')
    SQLConnection = Con
    Left = 448
    Top = 160
    object QryMoedaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object QryMoedaDCINTSING: TStringField
      FieldName = 'DCINTSING'
    end
    object QryMoedaDCINTPLURAL: TStringField
      FieldName = 'DCINTPLURAL'
    end
    object QryMoedaDCDECSING: TStringField
      FieldName = 'DCDECSING'
    end
    object QryMoedaDCDECPLURAL: TStringField
      FieldName = 'DCDECPLURAL'
    end
    object QryMoedaDTINI: TDateField
      FieldName = 'DTINI'
    end
    object QryMoedaDTFIM: TDateField
      FieldName = 'DTFIM'
    end
    object QryMoedaFATOR: TFloatField
      FieldName = 'FATOR'
    end
    object QryMoedaSIMBOLO: TStringField
      FieldName = 'SIMBOLO'
      Size = 5
    end
  end
  object qryURV: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftDate
        Name = 'D'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT * FROM ACCMO WHERE MOEDA='#39'URV'#39' AND DATA=:D')
    SQLConnection = Con
    Left = 592
    Top = 304
    object qryURVMOEDA: TStringField
      FieldName = 'MOEDA'
      Required = True
      Size = 5
    end
    object qryURVDATA: TDateField
      FieldName = 'DATA'
      Required = True
    end
    object qryURVCOTACAO: TFloatField
      FieldName = 'COTACAO'
    end
  end
  object cdsDevCon: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 552
    Top = 248
    Data = {
      8F0000009619E0BD0100000018000000080000000000030000008F000550634C
      6971080004000000000006566C436F7272080004000000000005566C52656408
      0004000000000005547844657608000400000000000554785265630800040000
      0000000A54785265636F6C686572080004000000000004547835300800040000
      00000005566C52657308000400000000000000}
    object cdsDevConPcLiq: TFloatField
      FieldName = 'PcLiq'
      DisplayFormat = ',#0.0000'
    end
    object cdsDevConVlCorr: TFloatField
      FieldName = 'VlCorr'
      DisplayFormat = ',#0.00'
    end
    object cdsDevConVlRed: TFloatField
      FieldName = 'VlRed'
      DisplayFormat = ',#0.00'
    end
    object cdsDevConTxDev: TFloatField
      FieldName = 'TxDev'
      DisplayFormat = ',#0.00'
    end
    object cdsDevConTxRec: TFloatField
      FieldName = 'TxRec'
      DisplayFormat = ',#0.00'
    end
    object cdsDevConTxRecolher: TFloatField
      FieldName = 'TxRecolher'
      DisplayFormat = ',#0.00'
    end
    object cdsDevConTx50: TFloatField
      FieldName = 'Tx50'
      DisplayFormat = ',#0.00'
    end
    object cdsDevConVlRes: TFloatField
      FieldName = 'VlRes'
      DisplayFormat = ',#0.00'
    end
  end
  object rvDevCon: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = cdsDevCon
    Left = 592
    Top = 256
  end
  object dstPnd: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 'select * from ACCOB '#13#10'where grupo=:g and cota=:c and aviso=:a'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'g'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'c'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'a'
        ParamType = ptInput
      end>
    SQLConnection = Con
    Left = 56
    Top = 352
    object dstPndGRUPO: TStringField
      FieldName = 'GRUPO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 4
    end
    object dstPndSEQ: TStringField
      FieldName = 'SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 2
    end
    object dstPndCOTA: TStringField
      FieldName = 'COTA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 3
    end
    object dstPndAVISO: TStringField
      FieldName = 'AVISO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 6
    end
    object dstPndTIPO_MOV: TStringField
      FieldName = 'TIPO_MOV'
      ProviderFlags = [pfInUpdate]
      Size = 2
    end
    object dstPndD_VENCTO: TDateField
      FieldName = 'D_VENCTO'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndAG_COBRA: TStringField
      FieldName = 'AG_COBRA'
      ProviderFlags = [pfInUpdate]
      Size = 6
    end
    object dstPndP_NORMAL: TFloatField
      FieldName = 'P_NORMAL'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndP_DIFER: TFloatField
      FieldName = 'P_DIFER'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndP_RATEIO: TFloatField
      FieldName = 'P_RATEIO'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndP_SUBST: TFloatField
      FieldName = 'P_SUBST'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndF_AQUISI: TFloatField
      FieldName = 'F_AQUISI'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndADMINIST: TFloatField
      FieldName = 'ADMINIST'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndF_RESERV: TFloatField
      FieldName = 'F_RESERV'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndOUTROS: TFloatField
      FieldName = 'OUTROS'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndNR_EXTER: TStringField
      FieldName = 'NR_EXTER'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndDT_BASE: TDateField
      FieldName = 'DT_BASE'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndP_ANTEC: TFloatField
      FieldName = 'P_ANTEC'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndSEG_OUT: TStringField
      FieldName = 'SEG_OUT'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstPndDATA_EMI: TDateField
      FieldName = 'DATA_EMI'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndUSUARIO: TStringField
      FieldName = 'USUARIO'
      ProviderFlags = [pfInUpdate]
      Size = 4
    end
    object dstPndD_ATUALI: TDateField
      FieldName = 'D_ATUALI'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndTP_ABONO: TStringField
      FieldName = 'TP_ABONO'
      ProviderFlags = [pfInUpdate]
      Size = 2
    end
    object dstPndMUL_JUR: TFloatField
      FieldName = 'MUL_JUR'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndCOBRADOR: TStringField
      FieldName = 'COBRADOR'
      ProviderFlags = [pfInUpdate]
      Size = 6
    end
    object dstPndTAR_BANC: TFloatField
      FieldName = 'TAR_BANC'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndAV_ASSOC: TStringField
      FieldName = 'AV_ASSOC'
      ProviderFlags = [pfInUpdate]
      Size = 6
    end
    object dstPndFILLER: TStringField
      FieldName = 'FILLER'
      ProviderFlags = [pfInUpdate]
    end
    object dstPndADM_DESC: TFloatField
      FieldName = 'ADM_DESC'
      ProviderFlags = [pfInUpdate]
    end
  end
  object dspPnd: TDataSetProvider
    DataSet = dstPnd
    UpdateMode = upWhereKeyOnly
    Left = 96
    Top = 352
  end
  object cdsPnd: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'g'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'c'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'a'
        ParamType = ptInput
      end>
    ProviderName = 'dspPnd'
    Left = 136
    Top = 352
    object cdsPndGRUPO: TStringField
      FieldName = 'GRUPO'
      Required = True
      Size = 4
    end
    object cdsPndSEQ: TStringField
      FieldName = 'SEQ'
      Required = True
      Size = 2
    end
    object cdsPndCOTA: TStringField
      FieldName = 'COTA'
      Required = True
      Size = 3
    end
    object cdsPndAVISO: TStringField
      FieldName = 'AVISO'
      Required = True
      Size = 6
    end
    object cdsPndTIPO_MOV: TStringField
      FieldName = 'TIPO_MOV'
      Size = 2
    end
    object cdsPndD_VENCTO: TDateField
      FieldName = 'D_VENCTO'
    end
    object cdsPndAG_COBRA: TStringField
      FieldName = 'AG_COBRA'
      Size = 6
    end
    object cdsPndP_NORMAL: TFloatField
      FieldName = 'P_NORMAL'
      DisplayFormat = ',#0.0000'
      EditFormat = ',#0.0000'
    end
    object cdsPndP_DIFER: TFloatField
      FieldName = 'P_DIFER'
      DisplayFormat = ',#0.0000'
      EditFormat = ',#0.0000'
    end
    object cdsPndP_RATEIO: TFloatField
      FieldName = 'P_RATEIO'
      DisplayFormat = ',#0.0000'
      EditFormat = ',#0.0000'
    end
    object cdsPndP_SUBST: TFloatField
      FieldName = 'P_SUBST'
      DisplayFormat = ',#0.0000'
      EditFormat = ',#0.0000'
    end
    object cdsPndF_AQUISI: TFloatField
      FieldName = 'F_AQUISI'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object cdsPndADMINIST: TFloatField
      FieldName = 'ADMINIST'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object cdsPndF_RESERV: TFloatField
      FieldName = 'F_RESERV'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object cdsPndOUTROS: TFloatField
      FieldName = 'OUTROS'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object cdsPndNR_EXTER: TStringField
      FieldName = 'NR_EXTER'
    end
    object cdsPndDT_BASE: TDateField
      FieldName = 'DT_BASE'
    end
    object cdsPndP_ANTEC: TFloatField
      FieldName = 'P_ANTEC'
    end
    object cdsPndSEG_OUT: TStringField
      FieldName = 'SEG_OUT'
      Size = 1
    end
    object cdsPndDATA_EMI: TDateField
      FieldName = 'DATA_EMI'
    end
    object cdsPndUSUARIO: TStringField
      FieldName = 'USUARIO'
      Size = 4
    end
    object cdsPndD_ATUALI: TDateField
      FieldName = 'D_ATUALI'
    end
    object cdsPndTP_ABONO: TStringField
      FieldName = 'TP_ABONO'
      Size = 2
    end
    object cdsPndMUL_JUR: TFloatField
      FieldName = 'MUL_JUR'
    end
    object cdsPndCOBRADOR: TStringField
      FieldName = 'COBRADOR'
      Size = 6
    end
    object cdsPndTAR_BANC: TFloatField
      FieldName = 'TAR_BANC'
    end
    object cdsPndAV_ASSOC: TStringField
      FieldName = 'AV_ASSOC'
      Size = 6
    end
    object cdsPndFILLER: TStringField
      FieldName = 'FILLER'
    end
    object cdsPndADM_DESC: TFloatField
      FieldName = 'ADM_DESC'
    end
  end
  object cdsCb1: TClientDataSet
    Active = True
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <
      item
        Name = 'Aviso'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'Reu'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'TpPen'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Vencto'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'VlBem'
        DataType = ftFloat
      end
      item
        Name = 'PcNormal'
        DataType = ftFloat
      end
      item
        Name = 'PcRat'
        DataType = ftFloat
      end
      item
        Name = 'VPend'
        DataType = ftFloat
      end
      item
        Name = 'VlMul'
        DataType = ftFloat
      end
      item
        Name = 'VlJur'
        DataType = ftFloat
      end
      item
        Name = 'VlTot'
        DataType = ftFloat
      end
      item
        Name = 'VlMulJur'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 184
    Top = 160
    Data = {
      F70000009619E0BD01000000180000000C000000000003000000F70005417669
      736F010049000000010005574944544802000200060003526575010049000000
      010005574944544802000200030005547050656E010049000000010005574944
      5448020002000A000656656E63746F0100490000000100055749445448020002
      000A0005566C42656D08000400000000000850634E6F726D616C080004000000
      00000550635261740800040000000000055650656E6408000400000000000556
      6C4D756C080004000000000005566C4A7572080004000000000005566C546F74
      080004000000000008566C4D756C4A757208000400000000000000}
    object cdsCb1Aviso: TStringField
      FieldName = 'Aviso'
      Visible = False
      Size = 6
    end
    object cdsCb1Reu: TStringField
      FieldName = 'Reu'
      Size = 3
    end
    object cdsCb1TpPen: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TpPen'
      Size = 10
    end
    object cdsCb1Vencto: TStringField
      FieldName = 'Vencto'
      Size = 10
    end
    object cdsCb1VlBem: TFloatField
      DisplayLabel = 'Vlr. Bem'
      FieldName = 'VlBem'
      DisplayFormat = ',#0.00'
    end
    object cdsCb1PcNormal: TFloatField
      DisplayLabel = '% Nor'
      DisplayWidth = 7
      FieldName = 'PcNormal'
      DisplayFormat = ',#0.0000'
    end
    object cdsCb1PcRat: TFloatField
      DisplayLabel = '% Rat'
      DisplayWidth = 7
      FieldName = 'PcRat'
      DisplayFormat = ',#0.0000'
    end
    object cdsCb1VPend: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'VPend'
      DisplayFormat = ',#0.00'
    end
    object cdsCb1VlMul: TFloatField
      DisplayLabel = 'Multa'
      DisplayWidth = 6
      FieldName = 'VlMul'
      DisplayFormat = ',#0.00'
    end
    object cdsCb1VlJur: TFloatField
      DisplayLabel = 'Juros'
      FieldName = 'VlJur'
      DisplayFormat = ',#0.00'
    end
    object cdsCb1VlTot: TFloatField
      DisplayLabel = 'Total'
      FieldName = 'VlTot'
      DisplayFormat = ',#0.00'
    end
    object cdsCb1VlMulJur: TFloatField
      FieldName = 'VlMulJur'
      Visible = False
      DisplayFormat = ',#0.00'
    end
    object cdsCb1TtPcNor: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TtPcNor'
      Active = True
      DisplayFormat = ',#0.0000'
      Expression = 'sum(pcnormal)'
    end
    object cdsCb1ttPcRat: TAggregateField
      Alignment = taRightJustify
      FieldName = 'ttPcRat'
      Active = True
      DisplayFormat = ',#0.0000'
      Expression = 'sum(pcrat)'
    end
    object cdsCb1TtPend: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TtPend'
      Active = True
      DisplayFormat = ',#0.00'
      Expression = 'sum(vpend)'
    end
    object cdsCb1TtMul: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TtMul'
      Active = True
      DisplayFormat = ',#0.00'
      Expression = 'sum(vlmul)'
    end
    object cdsCb1TtJur: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TtJur'
      Active = True
      DisplayFormat = ',#0.00'
      Expression = 'sum(vljur)'
    end
    object cdsCb1TtTot: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TtTot'
      Active = True
      DisplayFormat = ',#0.00'
      Expression = 'sum(vltot)'
    end
  end
  object QryTmv: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'c'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select * from ACTMV where cod_mov=:c')
    SQLConnection = Con
    Left = 496
    Top = 160
    object QryTmvCOD_MOV: TStringField
      FieldName = 'COD_MOV'
      Required = True
      Size = 2
    end
    object QryTmvDESCRIC: TStringField
      FieldName = 'DESCRIC'
    end
    object QryTmvPEDE_CT: TStringField
      FieldName = 'PEDE_CT'
      Size = 1
    end
    object QryTmvSAL_GRU: TStringField
      FieldName = 'SAL_GRU'
      Size = 1
    end
    object QryTmvSAL_CT: TStringField
      FieldName = 'SAL_CT'
      Size = 1
    end
    object QryTmvTEM_SUB: TStringField
      FieldName = 'TEM_SUB'
      Size = 1
    end
    object QryTmvTEM_ANT: TStringField
      FieldName = 'TEM_ANT'
      Size = 1
    end
    object QryTmvTEM_NOR: TStringField
      FieldName = 'TEM_NOR'
      Size = 1
    end
    object QryTmvTEM_DIF: TStringField
      FieldName = 'TEM_DIF'
      Size = 1
    end
    object QryTmvTEM_RAT: TStringField
      FieldName = 'TEM_RAT'
      Size = 1
    end
    object QryTmvF_AQUISI: TStringField
      FieldName = 'F_AQUISI'
      Size = 1
    end
    object QryTmvADMINIST: TStringField
      FieldName = 'ADMINIST'
      Size = 1
    end
    object QryTmvF_RESERV: TStringField
      FieldName = 'F_RESERV'
      Size = 1
    end
    object QryTmvOUTROS: TStringField
      FieldName = 'OUTROS'
      Size = 1
    end
    object QryTmvMUL_JUR: TStringField
      FieldName = 'MUL_JUR'
      Size = 1
    end
    object QryTmvCOD_BACE: TStringField
      FieldName = 'COD_BACE'
      Size = 2
    end
    object QryTmvACU_BACE: TStringField
      FieldName = 'ACU_BACE'
      Size = 2
    end
    object QryTmvVAL_ENTR: TStringField
      FieldName = 'VAL_ENTR'
      Size = 1
    end
    object QryTmvDT_ENTR: TStringField
      FieldName = 'DT_ENTR'
      Size = 1
    end
    object QryTmvENT_COBR: TStringField
      FieldName = 'ENT_COBR'
      Size = 1
    end
    object QryTmvCATEGOR: TStringField
      FieldName = 'CATEGOR'
      Size = 2
    end
    object QryTmvSEG_OUT: TStringField
      FieldName = 'SEG_OUT'
      Size = 1
    end
    object QryTmvSIGLA1: TStringField
      FieldName = 'SIGLA1'
      Size = 10
    end
    object QryTmvSIGLA2: TStringField
      FieldName = 'SIGLA2'
      Size = 5
    end
    object QryTmvCOM_VEND: TStringField
      FieldName = 'COM_VEND'
      Size = 1
    end
    object QryTmvCOM_COMP: TStringField
      FieldName = 'COM_COMP'
      Size = 1
    end
    object QryTmvLISTA_CC: TStringField
      FieldName = 'LISTA_CC'
      Size = 1
    end
    object QryTmvSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 1
    end
    object QryTmvDT_APRO: TStringField
      FieldName = 'DT_APRO'
      Size = 1
    end
    object QryTmvTRAT_IDE: TStringField
      FieldName = 'TRAT_IDE'
      Size = 1
    end
    object QryTmvTP_MV_OR: TStringField
      FieldName = 'TP_MV_OR'
      Size = 2
    end
    object QryTmvPEDE_VEN: TStringField
      FieldName = 'PEDE_VEN'
      Size = 1
    end
    object QryTmvCOM_COBR: TStringField
      FieldName = 'COM_COBR'
      Size = 1
    end
    object QryTmvADIANTAM: TStringField
      FieldName = 'ADIANTAM'
      Size = 1
    end
    object QryTmvREC_ADM: TStringField
      FieldName = 'REC_ADM'
      Size = 1
    end
    object QryTmvSERVICO: TStringField
      FieldName = 'SERVICO'
      Size = 1
    end
  end
  object dstMvt: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select * from ACMOV'#13#10'where grupo=:g and seq=:s and cota=:c and a' +
      'viso=:a'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'g'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 's'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'c'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'a'
        ParamType = ptInput
      end>
    SQLConnection = Con
    Left = 56
    Top = 400
    object dstMvtGRUPO: TStringField
      FieldName = 'GRUPO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 4
    end
    object dstMvtSEQ: TStringField
      FieldName = 'SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 2
    end
    object dstMvtCOTA: TStringField
      FieldName = 'COTA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 3
    end
    object dstMvtAVISO: TStringField
      FieldName = 'AVISO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 6
    end
    object dstMvtTIPO_MOV: TStringField
      FieldName = 'TIPO_MOV'
      ProviderFlags = [pfInUpdate]
      Size = 2
    end
    object dstMvtD_VENCTO: TDateField
      FieldName = 'D_VENCTO'
      ProviderFlags = [pfInUpdate]
    end
    object dstMvtDT_PAGTO: TDateField
      FieldName = 'DT_PAGTO'
      ProviderFlags = [pfInUpdate]
    end
    object dstMvtD_CONTAB: TDateField
      FieldName = 'D_CONTAB'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dstMvtDT_APROP: TDateField
      FieldName = 'DT_APROP'
      ProviderFlags = [pfInUpdate]
    end
    object dstMvtAG_FINAN: TStringField
      FieldName = 'AG_FINAN'
      ProviderFlags = [pfInUpdate]
      Size = 6
    end
    object dstMvtNR_DOCUM: TStringField
      FieldName = 'NR_DOCUM'
      ProviderFlags = [pfInUpdate]
      Size = 6
    end
    object dstMvtP_NORMAL: TFloatField
      FieldName = 'P_NORMAL'
      ProviderFlags = [pfInUpdate]
    end
    object dstMvtP_DIFER: TFloatField
      FieldName = 'P_DIFER'
      ProviderFlags = [pfInUpdate]
    end
    object dstMvtP_RATEIO: TFloatField
      FieldName = 'P_RATEIO'
      ProviderFlags = [pfInUpdate]
    end
    object dstMvtP_SUBST: TFloatField
      FieldName = 'P_SUBST'
      ProviderFlags = [pfInUpdate]
    end
    object dstMvtP_ANTEC: TFloatField
      FieldName = 'P_ANTEC'
      ProviderFlags = [pfInUpdate]
    end
    object dstMvtF_AQUISI: TFloatField
      FieldName = 'F_AQUISI'
      ProviderFlags = [pfInUpdate]
    end
    object dstMvtADMINIST: TFloatField
      FieldName = 'ADMINIST'
      ProviderFlags = [pfInUpdate]
    end
    object dstMvtF_RESERV: TFloatField
      FieldName = 'F_RESERV'
      ProviderFlags = [pfInUpdate]
    end
    object dstMvtOUTROS: TFloatField
      FieldName = 'OUTROS'
      ProviderFlags = [pfInUpdate]
    end
    object dstMvtMUL_JUR: TFloatField
      FieldName = 'MUL_JUR'
      ProviderFlags = [pfInUpdate]
    end
    object dstMvtRECIBO: TStringField
      FieldName = 'RECIBO'
      ProviderFlags = [pfInUpdate]
      Size = 6
    end
    object dstMvtSAL_GRU: TStringField
      FieldName = 'SAL_GRU'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstMvtSAL_CT: TStringField
      FieldName = 'SAL_CT'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstMvtTP_PERC: TStringField
      FieldName = 'TP_PERC'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstMvtDT_BASE: TDateField
      FieldName = 'DT_BASE'
      ProviderFlags = [pfInUpdate]
    end
    object dstMvtSEG_OUT: TStringField
      FieldName = 'SEG_OUT'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstMvtAV_V_COB: TStringField
      FieldName = 'AV_V_COB'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstMvtCONTABIL: TStringField
      FieldName = 'CONTABIL'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstMvtBEM: TStringField
      FieldName = 'BEM'
      ProviderFlags = [pfInUpdate]
      Size = 4
    end
    object dstMvtP_IDEAL: TFloatField
      FieldName = 'P_IDEAL'
      ProviderFlags = [pfInUpdate]
    end
    object dstMvtTP_SEGUR: TStringField
      FieldName = 'TP_SEGUR'
      ProviderFlags = [pfInUpdate]
      Size = 2
    end
    object dstMvtSTATUS: TStringField
      FieldName = 'STATUS'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object dstMvtUSUARIO: TStringField
      FieldName = 'USUARIO'
      ProviderFlags = [pfInUpdate]
      Size = 4
    end
    object dstMvtD_ATUALI: TDateField
      FieldName = 'D_ATUALI'
      ProviderFlags = [pfInUpdate]
    end
    object dstMvtDT_ASSOC: TDateField
      FieldName = 'DT_ASSOC'
      ProviderFlags = [pfInUpdate]
    end
  end
  object dspMvt: TDataSetProvider
    DataSet = dstMvt
    UpdateMode = upWhereKeyOnly
    Left = 96
    Top = 400
  end
  object cdsMvt: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'g'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 's'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'c'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'a'
        ParamType = ptInput
      end>
    ProviderName = 'dspMvt'
    Left = 136
    Top = 400
    object cdsMvtGRUPO: TStringField
      FieldName = 'GRUPO'
      Required = True
      Size = 4
    end
    object cdsMvtSEQ: TStringField
      FieldName = 'SEQ'
      Required = True
      Size = 2
    end
    object cdsMvtCOTA: TStringField
      FieldName = 'COTA'
      Required = True
      Size = 3
    end
    object cdsMvtAVISO: TStringField
      FieldName = 'AVISO'
      Required = True
      Size = 6
    end
    object cdsMvtTIPO_MOV: TStringField
      FieldName = 'TIPO_MOV'
      Size = 2
    end
    object cdsMvtD_VENCTO: TDateField
      FieldName = 'D_VENCTO'
    end
    object cdsMvtDT_PAGTO: TDateField
      FieldName = 'DT_PAGTO'
    end
    object cdsMvtD_CONTAB: TDateField
      FieldName = 'D_CONTAB'
      Required = True
    end
    object cdsMvtDT_APROP: TDateField
      FieldName = 'DT_APROP'
    end
    object cdsMvtAG_FINAN: TStringField
      FieldName = 'AG_FINAN'
      Size = 6
    end
    object cdsMvtNR_DOCUM: TStringField
      FieldName = 'NR_DOCUM'
      Size = 6
    end
    object cdsMvtP_NORMAL: TFloatField
      FieldName = 'P_NORMAL'
      DisplayFormat = ',#0.0000'
    end
    object cdsMvtP_DIFER: TFloatField
      FieldName = 'P_DIFER'
    end
    object cdsMvtP_RATEIO: TFloatField
      FieldName = 'P_RATEIO'
    end
    object cdsMvtP_SUBST: TFloatField
      FieldName = 'P_SUBST'
    end
    object cdsMvtP_ANTEC: TFloatField
      FieldName = 'P_ANTEC'
    end
    object cdsMvtF_AQUISI: TFloatField
      FieldName = 'F_AQUISI'
      DisplayFormat = ',#0.00'
    end
    object cdsMvtADMINIST: TFloatField
      FieldName = 'ADMINIST'
      DisplayFormat = ',#0.00'
    end
    object cdsMvtF_RESERV: TFloatField
      FieldName = 'F_RESERV'
      DisplayFormat = ',#0.00'
    end
    object cdsMvtOUTROS: TFloatField
      FieldName = 'OUTROS'
      DisplayFormat = ',#0.00'
    end
    object cdsMvtMUL_JUR: TFloatField
      FieldName = 'MUL_JUR'
      DisplayFormat = ',#0.00'
    end
    object cdsMvtRECIBO: TStringField
      FieldName = 'RECIBO'
      Size = 6
    end
    object cdsMvtSAL_GRU: TStringField
      FieldName = 'SAL_GRU'
      Size = 1
    end
    object cdsMvtSAL_CT: TStringField
      FieldName = 'SAL_CT'
      Size = 1
    end
    object cdsMvtTP_PERC: TStringField
      FieldName = 'TP_PERC'
      Size = 1
    end
    object cdsMvtDT_BASE: TDateField
      FieldName = 'DT_BASE'
    end
    object cdsMvtSEG_OUT: TStringField
      FieldName = 'SEG_OUT'
      Size = 1
    end
    object cdsMvtAV_V_COB: TStringField
      FieldName = 'AV_V_COB'
      Size = 1
    end
    object cdsMvtCONTABIL: TStringField
      FieldName = 'CONTABIL'
      Size = 1
    end
    object cdsMvtBEM: TStringField
      FieldName = 'BEM'
      Size = 4
    end
    object cdsMvtP_IDEAL: TFloatField
      FieldName = 'P_IDEAL'
    end
    object cdsMvtTP_SEGUR: TStringField
      FieldName = 'TP_SEGUR'
      Size = 2
    end
    object cdsMvtSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 1
    end
    object cdsMvtUSUARIO: TStringField
      FieldName = 'USUARIO'
      Size = 4
    end
    object cdsMvtD_ATUALI: TDateField
      FieldName = 'D_ATUALI'
    end
    object cdsMvtDT_ASSOC: TDateField
      FieldName = 'DT_ASSOC'
    end
  end
  object QryRelMov: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftDate
        Name = 'dt1'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'dt2'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select M.GRUPO,M.SEQ,M.COTA, C.NOME, M.TIPO_MOV,T.DESCRIC,'
      ' M.D_VENCTO, M.DT_PAGTO, M.D_CONTAB,'
      'M.P_NORMAL, M.P_RATEIO,( M.F_AQUISI +M.ADMINIST +'
      'M.F_RESERV+ M.OUTROS+M.MUL_JUR) as Valor'
      'from ACMOV M'
      'inner join ACTMV T on T.COD_MOV=M.TIPO_MOV'
      
        'inner join ACCLI C on C.GRUPO=M.GRUPO and C.SEQ=M.SEQ and C.COTA' +
        '=M.COTA'
      'where M.D_CONTAB between :dt1 and :dt2'
      'order by M.D_CONTAB, M.GRUPO, M.SEQ, M.COTA')
    SQLConnection = Con
    Left = 248
    Top = 352
  end
  object dspRelMov: TDataSetProvider
    DataSet = QryRelMov
    Left = 288
    Top = 352
  end
  object CdsRelMov: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftDate
        Name = 'dt1'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'dt2'
        ParamType = ptInput
      end>
    ProviderName = 'dspRelMov'
    Left = 328
    Top = 352
    object CdsRelMovGRUPO: TStringField
      FieldName = 'GRUPO'
      Required = True
      Size = 4
    end
    object CdsRelMovSEQ: TStringField
      FieldName = 'SEQ'
      Required = True
      Size = 2
    end
    object CdsRelMovCOTA: TStringField
      FieldName = 'COTA'
      Required = True
      Size = 3
    end
    object CdsRelMovNOME: TStringField
      FieldName = 'NOME'
      Size = 35
    end
    object CdsRelMovTIPO_MOV: TStringField
      FieldName = 'TIPO_MOV'
      Size = 2
    end
    object CdsRelMovDESCRIC: TStringField
      FieldName = 'DESCRIC'
    end
    object CdsRelMovD_VENCTO: TDateField
      FieldName = 'D_VENCTO'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object CdsRelMovDT_PAGTO: TDateField
      FieldName = 'DT_PAGTO'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object CdsRelMovD_CONTAB: TDateField
      FieldName = 'D_CONTAB'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object CdsRelMovP_NORMAL: TFloatField
      FieldName = 'P_NORMAL'
      DisplayFormat = ',#0.0000'
    end
    object CdsRelMovP_RATEIO: TFloatField
      FieldName = 'P_RATEIO'
      DisplayFormat = ',#0.0000'
    end
    object CdsRelMovVALOR: TFloatField
      FieldName = 'VALOR'
      DisplayFormat = ',#0.00'
    end
  end
  object RvDSRelMov: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = CdsRelMov
    Left = 376
    Top = 352
  end
  object qryPre: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'b'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'f'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'd'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select dt_base,pre_tabe from acpre'
      'where tp_preco='#39'R'#39
      '      and bem=:b'
      '      and filial=:f'
      '      and dt_base <= :d'
      'order by dt_base desc')
    SQLConnection = Con
    Left = 456
    Top = 352
    object qryPreDT_BASE: TDateField
      FieldName = 'DT_BASE'
      Required = True
    end
    object qryPrePRE_TABE: TFloatField
      FieldName = 'PRE_TABE'
    end
  end
  object Drft: TRLDraftFilter
    Left = 640
    Top = 16
  end
  object Pdf: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport(Open Source) v3.23 \251 Copyright '#169' 1999-2006 Forte' +
      's Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    Left = 640
    Top = 64
  end
  object Prvw: TRLPreviewSetup
    WindowState = wsNormal
    FormStyle = fsMDIForm
    Caption = 'Visualizar Relat'#243'rio'
    Left = 640
    Top = 112
  end
  object Exp: TRLExpressionParser
    Left = 640
    Top = 160
  end
  object qryFin: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftDate
        Name = 'dt1'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'dt2'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select M.GRUPO,M.SEQ,M.COTA, M.TIPO_MOV,T.DESCRIC,'
      ' M.D_VENCTO, M.DT_PAGTO, M.D_CONTAB, M.F_AQUISI, M.ADMINIST,'
      'M.F_RESERV, M.OUTROS, M.MUL_JUR,'
      '(M.F_AQUISI +M.ADMINIST +'
      'M.F_RESERV+ M.OUTROS+M.MUL_JUR) as Valor'
      'from ACMOV M'
      'inner join ACTMV T on T.COD_MOV=M.TIPO_MOV'
      'where M.D_CONTAB between :dt1 and :dt2'
      'order by M.D_CONTAB, M.GRUPO, M.SEQ, M.COTA')
    SQLConnection = Con
    Left = 248
    Top = 400
  end
  object dspFin: TDataSetProvider
    DataSet = qryFin
    Left = 288
    Top = 400
  end
  object cdsFin: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftDate
        Name = 'dt1'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'dt2'
        ParamType = ptInput
      end>
    ProviderName = 'dspFin'
    Left = 328
    Top = 400
    object cdsFinGRUPO: TStringField
      FieldName = 'GRUPO'
      Required = True
      Size = 4
    end
    object cdsFinSEQ: TStringField
      FieldName = 'SEQ'
      Required = True
      Size = 2
    end
    object cdsFinCOTA: TStringField
      FieldName = 'COTA'
      Required = True
      Size = 3
    end
    object cdsFinTIPO_MOV: TStringField
      FieldName = 'TIPO_MOV'
      Size = 2
    end
    object cdsFinDESCRIC: TStringField
      FieldName = 'DESCRIC'
    end
    object cdsFinD_VENCTO: TDateField
      FieldName = 'D_VENCTO'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsFinDT_PAGTO: TDateField
      FieldName = 'DT_PAGTO'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsFinD_CONTAB: TDateField
      FieldName = 'D_CONTAB'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsFinF_AQUISI: TFloatField
      FieldName = 'F_AQUISI'
      DisplayFormat = ',#0.00'
    end
    object cdsFinADMINIST: TFloatField
      FieldName = 'ADMINIST'
      DisplayFormat = ',#0.00'
    end
    object cdsFinF_RESERV: TFloatField
      FieldName = 'F_RESERV'
      DisplayFormat = ',#0.00'
    end
    object cdsFinOUTROS: TFloatField
      FieldName = 'OUTROS'
      DisplayFormat = ',#0.00'
    end
    object cdsFinMUL_JUR: TFloatField
      FieldName = 'MUL_JUR'
      DisplayFormat = ',#0.00'
    end
    object cdsFinVALOR: TFloatField
      FieldName = 'VALOR'
      DisplayFormat = ',#0.00'
    end
  end
  object rvFin: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = cdsFin
    Left = 376
    Top = 404
  end
  object rvCtFin: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = cdsPag
    Left = 8
    Top = 160
  end
  object cdsMov: TClientDataSet
    Active = True
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 456
    Top = 304
    Data = {
      A40100009619E0BD010000001800000014000000000003000000A40103526575
      0100490000000100055749445448020002000300045469706F01004900000001
      00055749445448020002000A000656656E63746F010049000000010005574944
      5448020002000A0005506167746F010049000000010005574944544802000200
      0A000544745265750100490000000100055749445448020002000A000453696D
      62010049000000010005574944544802000200050005566C42656D0800040000
      00000003506572080004000000000003526174080004000000000005566C546F
      740800040000000000054D756C6A750800040000000000054474437462010049
      0000000100055749445448020002000A0006566C5265616C0800040000000000
      05566C5061670800040000000000054664526573080004000000000005547841
      646D0800040000000000064F7574726F73080004000000000005446342656D01
      00490000000100055749445448020002001E0004486973740100490000000100
      055749445448020002003C0005417669736F0100490000000100055749445448
      0200020006000000}
    object cdsMovReu: TStringField
      DisplayLabel = 'Par'
      FieldName = 'Reu'
      Size = 3
    end
    object cdsMovTipo: TStringField
      FieldName = 'Tipo'
      Size = 10
    end
    object cdsMovVencto: TStringField
      DisplayWidth = 10
      FieldName = 'Vencto'
      Size = 10
    end
    object cdsMovPagto: TStringField
      DisplayWidth = 10
      FieldName = 'Pagto'
      Size = 10
    end
    object cdsMovDtReu: TStringField
      DisplayLabel = 'Reuni'#227'o'
      DisplayWidth = 10
      FieldName = 'DtReu'
      Size = 10
    end
    object cdsMovSimb: TStringField
      DisplayLabel = 'Moe'
      FieldName = 'Simb'
      Size = 5
    end
    object cdsMovVlBem: TFloatField
      DisplayLabel = 'Vlr. Bem'
      FieldName = 'VlBem'
      DisplayFormat = ',#0.00'
    end
    object cdsMovPer: TFloatField
      DisplayLabel = '% Pago'
      DisplayWidth = 7
      FieldName = 'Per'
      DisplayFormat = ',#0.0000'
    end
    object cdsMovRat: TFloatField
      DisplayLabel = '% Rat'
      DisplayWidth = 7
      FieldName = 'Rat'
      DisplayFormat = ',#0.0000'
    end
    object cdsMovVlTot: TFloatField
      DisplayLabel = 'Vl.Pago'
      FieldName = 'VlTot'
      DisplayFormat = ',#0.00'
    end
    object cdsMovMulju: TFloatField
      DisplayLabel = 'Mul/Jur'
      FieldName = 'Mulju'
      DisplayFormat = ',#0.00'
    end
    object cdsMovDtCtb: TStringField
      DisplayLabel = 'Dt.Cont.'
      FieldName = 'DtCtb'
      Size = 10
    end
    object cdsMovVlReal: TFloatField
      DisplayLabel = 'Vlr. R$'
      FieldName = 'VlReal'
      DisplayFormat = ',#0.00'
    end
    object cdsMovVlPag: TFloatField
      DisplayLabel = 'Aquisi'#231#227'o'
      FieldName = 'VlPag'
      Visible = False
      DisplayFormat = ',#0.00'
    end
    object cdsMovFdRes: TFloatField
      DisplayLabel = 'Reserva'
      FieldName = 'FdRes'
      DisplayFormat = ',#0.00'
    end
    object cdsMovTxAdm: TFloatField
      DisplayLabel = 'Tx. Adm.'
      FieldName = 'TxAdm'
      DisplayFormat = ',#0.00'
    end
    object cdsMovOutros: TFloatField
      DisplayLabel = 'Seg/Outros'
      FieldName = 'Outros'
      DisplayFormat = ',#0.00'
    end
    object cdsMovDcBem: TStringField
      FieldName = 'DcBem'
      Size = 30
    end
    object cdsMovHist: TStringField
      DisplayLabel = 'Hist.'
      FieldName = 'Hist'
      Size = 60
    end
    object cdsMovAviso: TStringField
      FieldName = 'Aviso'
      Size = 6
    end
    object cdsMovTTRat: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TTRat'
      Active = True
      DisplayFormat = ',#0.0000'
      Expression = 'sum(Rat)'
    end
    object cdsMovTTPag: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TTPag'
      Active = True
      DisplayFormat = ',#0.00'
      Expression = 'sum(VlPag)'
    end
    object cdsMovTTMul: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TTMul'
      Active = True
      DisplayFormat = ',#0.00'
      Expression = 'sum(Mulju)'
    end
    object cdsMovTTReal: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TTReal'
      Active = True
      DisplayFormat = ',#0.00'
      Expression = 'sum(VlReal)'
    end
    object cdsMovTTRes: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TTRes'
      Active = True
      DisplayFormat = ',#0.00'
      Expression = 'sum(FdRes)'
    end
    object cdsMovTTAdm: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TTAdm'
      Active = True
      DisplayFormat = ',#0.00'
      Expression = 'sum(TxAdm)'
    end
    object cdsMovTTOut: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TTOut'
      Active = True
      DisplayFormat = ',#0.00'
      Expression = 'sum(Outros)'
    end
    object cdsMovTTPer: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TTPer'
      Active = True
      DisplayFormat = ',#0.0000'
      Expression = 'sum(Per)'
    end
  end
end
