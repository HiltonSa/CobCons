object frmRelCli: TfrmRelCli
  Left = 0
  Top = 0
  Caption = 'frmRelCli'
  ClientHeight = 475
  ClientWidth = 808
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Rp: TRLReport
    Left = 8
    Top = 0
    Width = 794
    Height = 1123
    Margins.LeftMargin = 5.000000000000000000
    Margins.TopMargin = 5.000000000000000000
    Margins.RightMargin = 5.000000000000000000
    Margins.BottomMargin = 5.000000000000000000
    DataSource = dsCot
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ExpressionParser = DM.Exp
    object RLBand1: TRLBand
      Left = 19
      Top = 19
      Width = 756
      Height = 32
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      object RLDBText1: TRLDBText
        Left = 0
        Top = 0
        Width = 46
        Height = 14
        Align = faLeftTop
        DataField = 'nm_prs'
        DataSource = dsPrs
      end
      object RLLabel1: TRLLabel
        Left = 299
        Top = 0
        Width = 158
        Height = 14
        Align = faCenterTop
        Alignment = taCenter
        Caption = 'POSI'#199#195'O DE CONSORCIADOS'
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 721
        Top = 0
        Width = 35
        Height = 14
        Align = faRightTop
        Alignment = taRightJustify
      end
      object RLDBText2: TRLDBText
        Left = 48
        Top = 17
        Width = 34
        Height = 14
        AutoSize = False
        DataField = 'grupo'
        DataSource = dsCot
      end
      object RLLabel2: TRLLabel
        Left = 0
        Top = 17
        Width = 46
        Height = 14
        Align = faLeftBottom
        Caption = 'GRUPO: '
      end
      object RLLabel3: TRLLabel
        Left = 84
        Top = 17
        Width = 40
        Height = 14
        Caption = 'COTA: '
      end
      object RLDBText3: TRLDBText
        Left = 119
        Top = 17
        Width = 14
        Height = 14
        AutoSize = False
        DataField = 'SEQ'
        DataSource = dsCot
      end
      object RLDBText4: TRLDBText
        Left = 136
        Top = 17
        Width = 41
        Height = 14
        DataField = 'COTA'
        DataSource = dsCot
        Text = '- '
      end
      object RLLabel4: TRLLabel
        Left = 178
        Top = 17
        Width = 40
        Height = 14
        Caption = 'NOME: '
      end
      object RLDBText5: TRLDBText
        Left = 218
        Top = 17
        Width = 34
        Height = 14
        DataField = 'NOME'
        DataSource = dsCot
      end
      object RLLabel5: TRLLabel
        Left = 425
        Top = 17
        Width = 69
        Height = 14
        Caption = 'CONTRATO: '
      end
      object RLDBText6: TRLDBText
        Left = 489
        Top = 17
        Width = 63
        Height = 14
        DataField = 'CONTRATO'
        DataSource = dsCot
      end
      object RLLabel6: TRLLabel
        Left = 555
        Top = 17
        Width = 58
        Height = 14
        Caption = 'CPF/CNPJ:'
      end
      object RLDBText7: TRLDBText
        Left = 614
        Top = 17
        Width = 70
        Height = 14
        AutoSize = False
        DataField = 'CGC_CPF'
        DataSource = dsCot
      end
      object RLLabel7: TRLLabel
        Left = 680
        Top = 17
        Width = 26
        Height = 14
        Caption = 'SIT: '
      end
      object RLDBText8: TRLDBText
        Left = 701
        Top = 17
        Width = 54
        Height = 14
        AutoSize = False
        DataField = 'Sit_cobr'
        DataSource = dsCot
      end
    end
    object RLBand2: TRLBand
      Left = 19
      Top = 51
      Width = 756
      Height = 82
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      Borders.FixedBottom = True
      object RLLabel8: TRLLabel
        Left = 0
        Top = 2
        Width = 53
        Height = 14
        Caption = 'DT.NASC:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText9: TRLDBText
        Left = 56
        Top = 2
        Width = 58
        Height = 14
        AutoSize = False
        DataField = 'DT_NASC'
        DataSource = dsCot
      end
      object RLDBText10: TRLDBText
        Left = 172
        Top = 2
        Width = 68
        Height = 14
        AutoSize = False
        DataField = 'E_CIVIL'
        DataSource = dsCot
      end
      object RLLabel9: TRLLabel
        Left = 115
        Top = 2
        Width = 58
        Height = 14
        Caption = 'EST.CIVIL:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText11: TRLDBText
        Left = 284
        Top = 2
        Width = 147
        Height = 14
        AutoSize = False
        DataField = 'PROFISS'
        DataSource = dsCot
      end
      object RLLabel10: TRLLabel
        Left = 243
        Top = 2
        Width = 37
        Height = 14
        Caption = 'PROF.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText12: TRLDBText
        Left = 475
        Top = 2
        Width = 113
        Height = 14
        AutoSize = False
        DataField = 'DOCUMENT'
        DataSource = dsCot
      end
      object RLLabel11: TRLLabel
        Left = 437
        Top = 2
        Width = 35
        Height = 14
        Caption = 'DOC.: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel12: TRLLabel
        Left = 593
        Top = 2
        Width = 62
        Height = 14
        Caption = 'TELEFONE: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText13: TRLDBText
        Left = 655
        Top = 2
        Width = 94
        Height = 14
        AutoSize = False
        DataField = 'TELEFONE'
        DataSource = dsCot
      end
      object RLLabel13: TRLLabel
        Left = 0
        Top = 15
        Width = 64
        Height = 14
        Caption = 'ENDERE'#199'O: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText14: TRLDBText
        Left = 62
        Top = 15
        Width = 175
        Height = 14
        AutoSize = False
        DataField = 'ENDERECO'
        DataSource = dsCot
      end
      object RLLabel14: TRLLabel
        Left = 243
        Top = 15
        Width = 46
        Height = 14
        Caption = 'BAIRRO:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText15: TRLDBText
        Left = 289
        Top = 15
        Width = 177
        Height = 14
        AutoSize = False
        DataField = 'BAIRRO'
        DataSource = dsCot
      end
      object RLLabel15: TRLLabel
        Left = 472
        Top = 15
        Width = 45
        Height = 14
        Caption = 'CIDADE:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText16: TRLDBText
        Left = 518
        Top = 15
        Width = 112
        Height = 14
        AutoSize = False
        DataField = 'CIDADE'
        DataSource = dsCot
      end
      object RLDBText17: TRLDBText
        Left = 655
        Top = 15
        Width = 15
        Height = 14
        AutoSize = False
        DataField = 'ESTADO'
        DataSource = dsCot
      end
      object RLLabel16: TRLLabel
        Left = 636
        Top = 15
        Width = 19
        Height = 14
        Caption = 'UF:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel17: TRLLabel
        Left = 673
        Top = 15
        Width = 27
        Height = 14
        Caption = 'CEP:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText18: TRLDBText
        Left = 699
        Top = 15
        Width = 54
        Height = 14
        AutoSize = False
        DataField = 'CEP'
        DataSource = dsCot
      end
      object RLLabel18: TRLLabel
        Left = 0
        Top = 29
        Width = 42
        Height = 14
        Caption = 'VENDA:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText19: TRLDBText
        Left = 43
        Top = 29
        Width = 58
        Height = 14
        AutoSize = False
        DataField = 'DT_VENDA'
        DataSource = dsCot
      end
      object RLDBText20: TRLDBText
        Left = 156
        Top = 29
        Width = 18
        Height = 14
        AutoSize = False
        DataField = 'REU_ADES'
        DataSource = dsCot
      end
      object RLLabel19: TRLLabel
        Left = 104
        Top = 29
        Width = 50
        Height = 14
        Caption = 'ADES'#195'O:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText21: TRLDBText
        Left = 176
        Top = 29
        Width = 61
        Height = 14
        AutoSize = False
        DataField = 'DT_ADES'
        DataSource = dsCot
        Text = '-'
      end
      object RLLabel20: TRLLabel
        Left = 243
        Top = 29
        Width = 43
        Height = 14
        Caption = 'FIL.AT.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText22: TRLDBText
        Left = 289
        Top = 29
        Width = 80
        Height = 14
        AutoSize = False
        DataField = 'FIL_ATE'
        DataSource = dsCot
      end
      object RLLabel21: TRLLabel
        Left = 480
        Top = 29
        Width = 37
        Height = 14
        Caption = 'VEND.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText23: TRLDBText
        Left = 518
        Top = 29
        Width = 112
        Height = 14
        AutoSize = False
        DataField = 'REPRES'
        DataSource = dsCot
      end
      object RLLabel22: TRLLabel
        Left = 0
        Top = 42
        Width = 54
        Height = 14
        Caption = 'FIL.COM.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText24: TRLDBText
        Left = 53
        Top = 42
        Width = 94
        Height = 14
        AutoSize = False
        DataField = 'FIL_COM'
        DataSource = dsCot
      end
      object RLLabel23: TRLLabel
        Left = 156
        Top = 42
        Width = 29
        Height = 14
        Caption = 'BEM:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText25: TRLDBText
        Left = 190
        Top = 42
        Width = 260
        Height = 14
        AutoSize = False
        DataField = 'DESCRIC'
        DataSource = dsBem
      end
      object RLDBText26: TRLDBText
        Left = 518
        Top = 42
        Width = 83
        Height = 14
        AutoSize = False
        DataField = 'DT_BASE'
        DataSource = dsPre
      end
      object RLLabel24: TRLLabel
        Left = 481
        Top = 42
        Width = 36
        Height = 14
        Caption = 'DATA:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel25: TRLLabel
        Left = 611
        Top = 42
        Width = 44
        Height = 14
        Caption = 'VALOR:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText27: TRLDBText
        Left = 656
        Top = 42
        Width = 83
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'PRE_TABE'
        DataSource = dsPre
      end
      object RLLabel26: TRLLabel
        Left = 0
        Top = 54
        Width = 43
        Height = 14
        Caption = 'PLANO:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText28: TRLDBText
        Left = 43
        Top = 54
        Width = 29
        Height = 14
        AutoSize = False
        DataField = 'PLANO'
        DataSource = dsCot
      end
      object RLLabel27: TRLLabel
        Left = 73
        Top = 54
        Width = 114
        Height = 14
        Caption = 'meses    % MENSAL:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText29: TRLDBText
        Left = 190
        Top = 54
        Width = 46
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'P_MENSAL'
        DataSource = dsCot
      end
      object RLLabel28: TRLLabel
        Left = 243
        Top = 54
        Width = 43
        Height = 14
        Caption = '% ADM:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText30: TRLDBText
        Left = 289
        Top = 54
        Width = 46
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'P_ADMINS'
        DataSource = dsCot
      end
      object RLDBText31: TRLDBText
        Left = 377
        Top = 54
        Width = 46
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'P_RESERV'
        DataSource = dsCot
      end
      object RLLabel29: TRLLabel
        Left = 336
        Top = 54
        Width = 38
        Height = 14
        Caption = '% RES:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText32: TRLDBText
        Left = 456
        Top = 54
        Width = 15
        Height = 14
        AutoSize = False
        DataField = 'TP_SEGUR'
        DataSource = dsCot
      end
      object RLLabel30: TRLLabel
        Left = 428
        Top = 54
        Width = 27
        Height = 14
        Caption = 'SEG:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText33: TRLDBText
        Left = 473
        Top = 54
        Width = 87
        Height = 14
        AutoSize = False
        DataField = 'NOME_FANT'
        DataSource = dsSeg
        Text = '-'
      end
      object RLLabel31: TRLLabel
        Left = 616
        Top = 54
        Width = 39
        Height = 14
        Caption = '% SEG:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText34: TRLDBText
        Left = 656
        Top = 54
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'PERSEGVD'
        DataSource = dsSeg
      end
      object RLDBText35: TRLDBText
        Left = 58
        Top = 66
        Width = 14
        Height = 14
        AutoSize = False
        DataField = 'TP_CONTE'
        DataSource = dsCot
      end
      object RLLabel32: TRLLabel
        Left = 0
        Top = 66
        Width = 56
        Height = 14
        Caption = 'TP.CONT.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel33: TRLLabel
        Left = 75
        Top = 66
        Width = 36
        Height = 14
        Caption = 'DATA:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText36: TRLDBText
        Left = 112
        Top = 66
        Width = 58
        Height = 14
        AutoSize = False
        DataField = 'DT_CONTE'
        DataSource = dsCot
      end
      object RLDBText37: TRLDBText
        Left = 456
        Top = 66
        Width = 74
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'VAL_ENTR'
        DataSource = dsCot
      end
      object RLLabel34: TRLLabel
        Left = 354
        Top = 66
        Width = 101
        Height = 14
        Caption = 'VALOR ENTREGUE:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText38: TRLDBText
        Left = 656
        Top = 66
        Width = 58
        Height = 14
        AutoSize = False
        DataField = 'DT_ENTRE'
        DataSource = dsCot
      end
      object RLLabel35: TRLLabel
        Left = 567
        Top = 66
        Width = 88
        Height = 14
        Caption = 'DATA ENTREGA:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw1: TRLDraw
        Left = 0
        Top = 27
        Width = 756
        Height = 3
        DrawKind = dkLine
      end
    end
    object Creditos: TRLSubDetail
      Left = 19
      Top = 133
      Width = 756
      Height = 52
      DataSource = dsCre
      object RLBand3: TRLBand
        Left = 0
        Top = 0
        Width = 756
        Height = 16
        BandType = btHeader
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        object RLLabel36: TRLLabel
          Left = 0
          Top = 0
          Width = 27
          Height = 14
          Caption = 'NUM'
          Holder = RLDBText39
        end
        object RLLabel37: TRLLabel
          Left = 32
          Top = 0
          Width = 28
          Height = 14
          Caption = 'TIPO'
          Holder = RLDBText40
        end
        object RLLabel38: TRLLabel
          Left = 75
          Top = 0
          Width = 49
          Height = 14
          Caption = 'IN.CORR.'
          Holder = RLDBText41
        end
        object RLLabel39: TRLLabel
          Left = 136
          Top = 0
          Width = 59
          Height = 14
          Caption = 'LIM.CORR.'
          Holder = RLDBText42
        end
        object RLLabel40: TRLLabel
          Left = 199
          Top = 0
          Width = 59
          Height = 14
          Caption = 'VLR.CRED.'
          Holder = RLDBText43
        end
        object RLLabel41: TRLLabel
          Left = 263
          Top = 0
          Width = 61
          Height = 14
          Caption = 'VLR.CORR.'
          Holder = RLDBText44
        end
        object RLLabel45: TRLLabel
          Left = 326
          Top = 0
          Width = 73
          Height = 14
          Caption = 'FORNECEDOR'
          Holder = RLDBText45
        end
        object RLLabel42: TRLLabel
          Left = 452
          Top = 0
          Width = 49
          Height = 14
          Caption = 'DT.N.FIS.'
          Holder = RLDBText46
        end
        object RLLabel43: TRLLabel
          Left = 512
          Top = 0
          Width = 27
          Height = 14
          Caption = 'NUM'
          Holder = RLDBText47
        end
        object RLLabel44: TRLLabel
          Left = 543
          Top = 0
          Width = 61
          Height = 14
          Caption = 'DT.PAGTO.'
          Holder = RLDBText48
        end
        object RLLabel46: TRLLabel
          Left = 607
          Top = 0
          Width = 58
          Height = 14
          Caption = 'VLR.ENTR.'
          Holder = RLDBText49
        end
        object RLLabel47: TRLLabel
          Left = 671
          Top = 0
          Width = 59
          Height = 14
          Caption = 'CORR.ENT.'
          Holder = RLDBText50
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 16
        Width = 756
        Height = 16
        object RLDBText39: TRLDBText
          Left = 0
          Top = 0
          Width = 27
          Height = 14
          AutoSize = False
          DataField = 'CREDITO'
          DataSource = dsCre
        end
        object RLDBText40: TRLDBText
          Left = 32
          Top = 0
          Width = 40
          Height = 15
          AutoSize = False
          DataField = 'TP_CRED'
          DataSource = dsCre
        end
        object RLDBText41: TRLDBText
          Left = 75
          Top = 0
          Width = 58
          Height = 15
          AutoSize = False
          DataField = 'DT_I_COR'
          DataSource = dsCre
        end
        object RLDBText42: TRLDBText
          Left = 136
          Top = 0
          Width = 58
          Height = 15
          AutoSize = False
          DataField = 'LIM_CORR'
          DataSource = dsCre
        end
        object RLDBText43: TRLDBText
          Left = 199
          Top = 0
          Width = 58
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VAL_CRED'
          DataSource = dsCre
        end
        object RLDBText44: TRLDBText
          Left = 263
          Top = 0
          Width = 58
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VAL_CORR'
          DataSource = dsCre
        end
        object RLDBText45: TRLDBText
          Left = 326
          Top = 0
          Width = 123
          Height = 15
          AutoSize = False
          DataField = 'FORNEC'
          DataSource = dsCre
        end
        object RLDBText46: TRLDBText
          Left = 452
          Top = 0
          Width = 58
          Height = 15
          AutoSize = False
          DataField = 'DT_N_FIS'
          DataSource = dsCre
        end
        object RLDBText47: TRLDBText
          Left = 512
          Top = 0
          Width = 28
          Height = 15
          AutoSize = False
          DataField = 'NR_N_FIS'
          DataSource = dsCre
        end
        object RLDBText48: TRLDBText
          Left = 543
          Top = 0
          Width = 58
          Height = 15
          AutoSize = False
          DataField = 'DT_PAGTO'
          DataSource = dsCre
        end
        object RLDBText49: TRLDBText
          Left = 607
          Top = 0
          Width = 58
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VAL_ENTR'
          DataSource = dsCre
        end
        object RLDBText50: TRLDBText
          Left = 671
          Top = 0
          Width = 58
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'COR_ENTR'
          DataSource = dsCre
        end
      end
      object RLBand5: TRLBand
        Left = 0
        Top = 32
        Width = 756
        Height = 16
        BandType = btFooter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        object RLDBResult1: TRLDBResult
          Left = 671
          Top = 1
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Borders.FixedTop = True
          DataField = 'cor_entr'
          DataSource = dsCre
          Holder = RLDBText50
          Info = riSum
        end
        object RLDBResult2: TRLDBResult
          Left = 607
          Top = 1
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Borders.FixedTop = True
          DataField = 'val_entr'
          DataSource = dsCre
          Holder = RLDBText49
          Info = riSum
        end
      end
    end
    object Pendencia: TRLSubDetail
      Left = 19
      Top = 185
      Width = 756
      Height = 88
      DataSource = dsCob
      object RLBand6: TRLBand
        Left = 0
        Top = 0
        Width = 756
        Height = 36
        BandType = btHeader
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        object RLLabel48: TRLLabel
          Left = 0
          Top = 2
          Width = 756
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Caption = 'PENDENCIAS'
        end
        object RLLabel49: TRLLabel
          Left = 1
          Top = 19
          Width = 27
          Height = 14
          Caption = 'NUM'
          Holder = RLDBText51
        end
        object RLLabel50: TRLLabel
          Left = 32
          Top = 19
          Width = 57
          Height = 14
          Caption = 'TIPO MOV'
          Holder = RLDBText52
        end
        object RLLabel51: TRLLabel
          Left = 120
          Top = 19
          Width = 47
          Height = 14
          Caption = 'VENCTO'
          Holder = RLDBText53
        end
        object RLLabel52: TRLLabel
          Left = 207
          Top = 19
          Width = 51
          Height = 14
          Caption = 'VLR BEM'
          Holder = RLDBText54
        end
        object RLLabel53: TRLLabel
          Left = 294
          Top = 19
          Width = 62
          Height = 14
          Caption = '% NORMAL'
          Holder = RLDBText55
        end
        object RLLabel54: TRLLabel
          Left = 381
          Top = 19
          Width = 37
          Height = 14
          Caption = '% RAT'
          Holder = RLDBText56
        end
        object RLLabel55: TRLLabel
          Left = 468
          Top = 19
          Width = 41
          Height = 14
          Caption = 'VALOR'
          Holder = RLDBText57
        end
        object RLLabel56: TRLLabel
          Left = 554
          Top = 19
          Width = 65
          Height = 14
          Caption = 'MUL/JUROS'
          Holder = RLDBText58
        end
        object RLLabel57: TRLLabel
          Left = 640
          Top = 19
          Width = 40
          Height = 14
          Caption = 'TOTAL'
          Holder = RLDBText59
        end
      end
      object RLBand7: TRLBand
        Left = 0
        Top = 36
        Width = 756
        Height = 16
        object RLDBText51: TRLDBText
          Left = 1
          Top = 1
          Width = 26
          Height = 14
          AutoSize = False
          DataField = 'REU'
          DataSource = dsCob
        end
        object RLDBText52: TRLDBText
          Left = 32
          Top = 1
          Width = 81
          Height = 14
          AutoSize = False
          DataField = 'TPPEN'
          DataSource = dsCob
        end
        object RLDBText53: TRLDBText
          Left = 120
          Top = 1
          Width = 81
          Height = 14
          AutoSize = False
          DataField = 'VENCTO'
          DataSource = dsCob
        end
        object RLDBText54: TRLDBText
          Left = 207
          Top = 1
          Width = 81
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VLBEM'
          DataSource = dsCob
          DisplayMask = ',#0.00'
        end
        object RLDBText55: TRLDBText
          Left = 294
          Top = 1
          Width = 81
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'PCNORMAL'
          DataSource = dsCob
          DisplayMask = ',#0.0000'
        end
        object RLDBText56: TRLDBText
          Left = 381
          Top = 1
          Width = 81
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'PCRAT'
          DataSource = dsCob
          DisplayMask = ',#0.0000'
        end
        object RLDBText57: TRLDBText
          Left = 468
          Top = 1
          Width = 81
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VPEND'
          DataSource = dsCob
          DisplayMask = ',#0.00'
        end
        object RLDBText58: TRLDBText
          Left = 554
          Top = 1
          Width = 81
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VLMULJUR'
          DataSource = dsCob
          DisplayMask = ',#0.00'
        end
        object RLDBText59: TRLDBText
          Left = 640
          Top = 1
          Width = 81
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VLTOT'
          DataSource = dsCob
          DisplayMask = ',#0.00'
        end
      end
      object RLBand8: TRLBand
        Left = 0
        Top = 52
        Width = 756
        Height = 16
        BandType = btSummary
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        object RLSystemInfo2: TRLSystemInfo
          Left = 1
          Top = 0
          Width = 146
          Height = 16
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Info = itDetailCount
          Text = 'PENDENCIAS: '
        end
        object RLDBResult3: TRLDBResult
          Left = 554
          Top = 1
          Width = 81
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          DataField = 'VLMULJUR'
          DataSource = dsCob
          DisplayMask = ',#0.00'
          Holder = RLDBText58
          Info = riSum
        end
        object RLDBResult4: TRLDBResult
          Left = 294
          Top = 1
          Width = 81
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          DataField = 'PCNORMAL'
          DataSource = dsCob
          DisplayMask = ',#0.0000'
          Holder = RLDBText55
          Info = riSum
        end
        object RLDBResult5: TRLDBResult
          Left = 381
          Top = 1
          Width = 81
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          DataField = 'PCRAT'
          DataSource = dsCob
          DisplayMask = ',#0.0000'
          Holder = RLDBText56
          Info = riSum
        end
        object RLDBResult6: TRLDBResult
          Left = 468
          Top = 1
          Width = 81
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          DataField = 'VPEND'
          DataSource = dsCob
          DisplayMask = ',#0.00'
          Holder = RLDBText57
          Info = riSum
        end
        object RLDBResult7: TRLDBResult
          Left = 640
          Top = 1
          Width = 81
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          DataField = 'VLTOT'
          DataSource = dsCob
          DisplayMask = ',#0.00'
          Holder = RLDBText59
          Info = riSum
        end
      end
    end
    object MovFin: TRLSubDetail
      Left = 19
      Top = 273
      Width = 756
      Height = 88
      DataSource = dsMov
      object RLBand9: TRLBand
        Left = 0
        Top = 0
        Width = 756
        Height = 32
        BandType = btHeader
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        object RLLabel58: TRLLabel
          Left = 0
          Top = 2
          Width = 756
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Caption = 'MOVIMENTO FINANCEIRO'
        end
        object RLLabel59: TRLLabel
          Left = 1
          Top = 18
          Width = 27
          Height = 14
          Caption = 'NUM'
          Holder = RLDBText64
        end
        object RLLabel60: TRLLabel
          Left = 32
          Top = 18
          Width = 57
          Height = 14
          Caption = 'TIPO MOV'
          Holder = RLDBText65
        end
        object RLLabel61: TRLLabel
          Left = 119
          Top = 18
          Width = 47
          Height = 14
          Caption = 'VENCTO'
          Holder = RLDBText66
        end
      end
      object RLBand10: TRLBand
        Left = 0
        Top = 32
        Width = 756
        Height = 33
        object RLDBText64: TRLDBText
          Left = 1
          Top = 1
          Width = 24
          Height = 14
          AutoSize = False
          DataField = 'REU'
          DataSource = dsMov
        end
        object RLDBText65: TRLDBText
          Left = 32
          Top = 1
          Width = 81
          Height = 14
          AutoSize = False
          DataField = 'TIPO'
          DataSource = dsMov
        end
        object RLDBText66: TRLDBText
          Left = 119
          Top = 1
          Width = 81
          Height = 14
          AutoSize = False
          DataField = 'VENCTO'
          DataSource = dsMov
        end
        object RLDBText67: TRLDBText
          Left = 207
          Top = 1
          Width = 81
          Height = 14
          AutoSize = False
          DataField = 'PAGTO'
          DataSource = dsMov
        end
        object RLDBText68: TRLDBText
          Left = 294
          Top = 1
          Width = 81
          Height = 14
          AutoSize = False
          DataField = 'DTREU'
          DataSource = dsMov
        end
        object RLDBText69: TRLDBText
          Left = 381
          Top = 1
          Width = 81
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VLBEM'
          DataSource = dsMov
          DisplayMask = ',#0.00'
        end
        object RLDBText70: TRLDBText
          Left = 468
          Top = 1
          Width = 285
          Height = 14
          AutoSize = False
          DataField = 'HIST'
          DataSource = dsMov
        end
        object RLDBText71: TRLDBText
          Left = 141
          Top = 18
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'PER'
          DataSource = dsMov
          DisplayMask = ',#0.0000'
        end
        object RLDBText72: TRLDBText
          Left = 220
          Top = 18
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'RAT'
          DataSource = dsMov
          DisplayMask = ',#0.0000'
        end
        object RLDBText73: TRLDBText
          Left = 299
          Top = 18
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VLPAG'
          DataSource = dsMov
          DisplayMask = ',#0.00'
        end
        object RLDBText74: TRLDBText
          Left = 378
          Top = 18
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'FDRES'
          DataSource = dsMov
          DisplayMask = ',#0.00'
        end
        object RLDBText75: TRLDBText
          Left = 457
          Top = 18
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'TXADM'
          DataSource = dsMov
          DisplayMask = ',#0.00'
        end
        object RLDBText76: TRLDBText
          Left = 536
          Top = 18
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'OUTROS'
          DataSource = dsMov
          DisplayMask = ',#0.00'
        end
        object RLDBText77: TRLDBText
          Left = 615
          Top = 18
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'MULJU'
          DataSource = dsMov
          DisplayMask = ',#0.00'
        end
        object RLDBText78: TRLDBText
          Left = 695
          Top = 18
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VLREAL'
          DataSource = dsMov
          DisplayMask = ',#0.00'
        end
      end
      object RLBand11: TRLBand
        Left = 0
        Top = 65
        Width = 756
        Height = 24
        BandType = btSummary
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        object RLSystemInfo3: TRLSystemInfo
          Left = 1
          Top = 0
          Width = 154
          Height = 16
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Info = itDetailCount
          Text = 'MOVIMENTOS: '
        end
        object RLDBResult8: TRLDBResult
          Left = 141
          Top = 1
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          DataField = 'PER'
          DataSource = dsMov
          DisplayMask = ',#0.0000'
          Holder = RLDBText71
          Info = riSum
        end
        object RLDBResult9: TRLDBResult
          Left = 220
          Top = 1
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          DataField = 'RAT'
          DataSource = dsMov
          DisplayMask = ',#0.0000'
          Holder = RLDBText72
          Info = riSum
        end
        object RLDBResult10: TRLDBResult
          Left = 299
          Top = 1
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          DataField = 'VLPAG'
          DataSource = dsMov
          DisplayMask = ',#0.00'
          Holder = RLDBText73
          Info = riSum
        end
        object RLDBResult11: TRLDBResult
          Left = 378
          Top = 1
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          DataField = 'FDRES'
          DataSource = dsMov
          DisplayMask = ',#0.00'
          Holder = RLDBText74
          Info = riSum
        end
        object RLDBResult12: TRLDBResult
          Left = 457
          Top = 1
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          DataField = 'TXADM'
          DataSource = dsMov
          DisplayMask = ',#0.00'
          Holder = RLDBText75
          Info = riSum
        end
        object RLDBResult13: TRLDBResult
          Left = 536
          Top = 1
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          DataField = 'OUTROS'
          DataSource = dsMov
          DisplayMask = ',#0.00'
          Holder = RLDBText76
          Info = riSum
        end
        object RLDBResult14: TRLDBResult
          Left = 615
          Top = 1
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          DataField = 'MULJU'
          DataSource = dsMov
          DisplayMask = ',#0.00'
          Holder = RLDBText77
          Info = riSum
        end
        object RLDBResult15: TRLDBResult
          Left = 695
          Top = 1
          Width = 58
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = False
          DataField = 'VLREAL'
          DataSource = dsMov
          DisplayMask = ',#0.00'
          Holder = RLDBText78
          Info = riSum
        end
      end
    end
  end
  object dsPrs: TDataSource
    DataSet = DM.cdsPRS
    Top = 80
  end
  object dsCot: TDataSource
    DataSet = DM.cdsCot
    Top = 48
  end
  object dsBem: TDataSource
    DataSet = DM.sdsBem
    Top = 112
  end
  object dsPre: TDataSource
    DataSet = DM.sdsPre
    Top = 144
  end
  object dsSeg: TDataSource
    DataSet = DM.cdsSeg
    Top = 176
  end
  object dsCre: TDataSource
    DataSet = DM.cdsCre
    Top = 208
  end
  object dsCob: TDataSource
    DataSet = DM.cdsCb1
    Top = 240
  end
  object dsMov: TDataSource
    DataSet = DM.cdsMov
    Top = 16
  end
end
