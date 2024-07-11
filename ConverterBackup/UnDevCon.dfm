object frmDevCon: TfrmDevCon
  Left = 312
  Top = 133
  BorderStyle = bsDialog
  Caption = 'Devolu'#231#227'o a Consorciados'
  ClientHeight = 390
  ClientWidth = 408
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 349
    Width = 408
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    Color = clMoneyGreen
    TabOrder = 0
    object btnSair: TBitBtn
      Left = 312
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Sair'
      TabOrder = 0
      TabStop = False
      OnClick = btnSairClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
        0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
        0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
        0333337F777FFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
    end
    object btnImp: TBitBtn
      Left = 224
      Top = 8
      Width = 75
      Height = 25
      Hint = 'Clique ou F2 para imprimir'
      Caption = '&Imprimir'
      TabOrder = 1
      OnClick = btnImpClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        0003377777777777777308888888888888807F33333333333337088888888888
        88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
        8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
        8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 408
    Height = 349
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 1
    object Panel3: TPanel
      Left = 4
      Top = 5
      Width = 385
      Height = 49
      BevelInner = bvLowered
      Color = clSkyBlue
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 6
        Width = 29
        Height = 13
        Caption = 'Grupo'
      end
      object Label2: TLabel
        Left = 64
        Top = 6
        Width = 19
        Height = 13
        Caption = 'Seq'
      end
      object Label3: TLabel
        Left = 96
        Top = 6
        Width = 22
        Height = 13
        Caption = 'Cota'
      end
      object Label15: TLabel
        Left = 144
        Top = 6
        Width = 34
        Height = 13
        Caption = '% Red.'
      end
      object chAdm: TCheckBox
        Left = 208
        Top = 24
        Width = 161
        Height = 17
        Caption = 'Calcular Adm n'#227'o recebida'
        TabOrder = 1
        OnClick = chAdmClick
      end
      object txtRed: TEdit
        Left = 144
        Top = 22
        Width = 40
        Height = 21
        Hint = 'Informe o % de redu'#231#227'o'
        TabOrder = 0
        Text = '20'
        OnExit = txtRedExit
      end
      object DBEdit10: TDBEdit
        Left = 64
        Top = 22
        Width = 26
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'SEQ'
        DataSource = dsCota
        ReadOnly = True
        TabOrder = 2
      end
      object DBEdit12: TDBEdit
        Left = 96
        Top = 22
        Width = 42
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'COTA'
        DataSource = dsCota
        ReadOnly = True
        TabOrder = 3
      end
    end
    object PageControl1: TPageControl
      Left = 8
      Top = 60
      Width = 393
      Height = 281
      ActivePage = TabSheet2
      TabOrder = 1
      object TabSheet1: TTabSheet
        Caption = 'Dados da Cota'
        object GroupBox2: TGroupBox
          Left = 0
          Top = 0
          Width = 385
          Height = 253
          Align = alClient
          Color = clBtnFace
          ParentColor = False
          TabOrder = 0
          object Label6: TLabel
            Left = 8
            Top = 88
            Width = 21
            Height = 13
            Caption = 'Bem'
            FocusControl = DBEdit3
          end
          object Label13: TLabel
            Left = 212
            Top = 88
            Width = 50
            Height = 13
            Caption = 'Data Base'
            FocusControl = dbPre
          end
          object Label14: TLabel
            Left = 296
            Top = 88
            Width = 28
            Height = 13
            Caption = 'Pre'#231'o'
            FocusControl = DBEdit11
          end
          object Label7: TLabel
            Left = 8
            Top = 129
            Width = 32
            Height = 13
            Caption = '% Adm'
            FocusControl = DBEdit4
          end
          object Label8: TLabel
            Left = 110
            Top = 129
            Width = 33
            Height = 13
            Caption = '% Res.'
            FocusControl = DBEdit5
          end
          object Label9: TLabel
            Left = 213
            Top = 129
            Width = 36
            Height = 13
            Caption = '% Pago'
            FocusControl = DBEdit6
          end
          object Label11: TLabel
            Left = 240
            Top = 48
            Width = 39
            Height = 13
            Caption = #218'lt. Ass.'
            FocusControl = dbAss
          end
          object Label12: TLabel
            Left = 296
            Top = 48
            Width = 23
            Height = 13
            Caption = 'Data'
            FocusControl = DBEdit9
          end
          object Label10: TLabel
            Left = 334
            Top = 8
            Width = 27
            Height = 13
            Caption = 'Plano'
            FocusControl = DBEdit7
          end
          object Label5: TLabel
            Left = 64
            Top = 8
            Width = 28
            Height = 13
            Caption = 'Nome'
            FocusControl = DBEdit2
          end
          object Label4: TLabel
            Left = 8
            Top = 8
            Width = 40
            Height = 13
            Caption = 'Contrato'
            FocusControl = DBEdit1
          end
          object Label24: TLabel
            Left = 8
            Top = 168
            Width = 31
            Height = 13
            Caption = 'Banco'
          end
          object Agencia: TLabel
            Left = 144
            Top = 168
            Width = 39
            Height = 13
            Caption = 'Agencia'
          end
          object Conta: TLabel
            Left = 208
            Top = 168
            Width = 28
            Height = 13
            Caption = 'Conta'
          end
          object Label25: TLabel
            Left = 8
            Top = 208
            Width = 63
            Height = 13
            Caption = 'Observa'#231#245'es'
          end
          object Label26: TLabel
            Left = 8
            Top = 49
            Width = 47
            Height = 13
            Caption = 'CGC/CPF'
          end
          object Label27: TLabel
            Left = 312
            Top = 129
            Width = 42
            Height = 13
            Caption = '% Rateio'
            FocusControl = DBEdit14
          end
          object DBEdit11: TDBEdit
            Left = 297
            Top = 104
            Width = 80
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'PRE_TABE'
            DataSource = dsPre
            ReadOnly = True
            TabOrder = 4
          end
          object dbPre: TDBEdit
            Left = 212
            Top = 104
            Width = 80
            Height = 21
            Hint = 'Duplo clique pesquisa pre'#231'os'
            TabStop = False
            Color = clBtnFace
            DataField = 'DT_BASE'
            DataSource = dsPre
            ReadOnly = True
            TabOrder = 5
          end
          object DBEdit3: TDBEdit
            Left = 8
            Top = 104
            Width = 199
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'DESCRIC'
            DataSource = dsBem
            ReadOnly = True
            TabOrder = 6
          end
          object DBEdit9: TDBEdit
            Left = 297
            Top = 64
            Width = 80
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'DATA_REU'
            DataSource = dsReu
            ReadOnly = True
            TabOrder = 7
          end
          object dbAss: TDBEdit
            Left = 240
            Top = 64
            Width = 43
            Height = 21
            Hint = 'Duplo clique pesquisa reuni'#245'es'
            TabStop = False
            Color = clBtnFace
            DataField = 'NRO_REU'
            DataSource = dsReu
            ReadOnly = True
            TabOrder = 8
          end
          object DBEdit6: TDBEdit
            Left = 213
            Top = 145
            Width = 65
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'PerPago'
            DataSource = dsCota
            ReadOnly = True
            TabOrder = 9
          end
          object DBEdit5: TDBEdit
            Left = 110
            Top = 145
            Width = 65
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'P_RESERV'
            DataSource = dsCota
            ReadOnly = True
            TabOrder = 10
          end
          object DBEdit4: TDBEdit
            Left = 8
            Top = 145
            Width = 65
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'P_ADMINS'
            DataSource = dsCota
            ReadOnly = True
            TabOrder = 11
          end
          object DBEdit7: TDBEdit
            Left = 334
            Top = 24
            Width = 43
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'PLANO'
            DataSource = dsCota
            ReadOnly = True
            TabOrder = 12
          end
          object DBEdit2: TDBEdit
            Left = 64
            Top = 24
            Width = 250
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'NOME'
            DataSource = dsCota
            ReadOnly = True
            TabOrder = 13
          end
          object DBEdit1: TDBEdit
            Left = 8
            Top = 24
            Width = 45
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'CONTRATO'
            DataSource = dsCota
            ReadOnly = True
            TabOrder = 14
          end
          object txtBanco: TEdit
            Left = 8
            Top = 184
            Width = 129
            Height = 21
            TabOrder = 0
          end
          object txtAgencia: TEdit
            Left = 144
            Top = 184
            Width = 57
            Height = 21
            TabOrder = 1
          end
          object txtConta: TEdit
            Left = 208
            Top = 184
            Width = 169
            Height = 21
            TabOrder = 2
          end
          object txtObs: TEdit
            Left = 8
            Top = 224
            Width = 369
            Height = 21
            TabOrder = 3
          end
          object DBEdit13: TDBEdit
            Left = 8
            Top = 64
            Width = 130
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'CGC_CPF'
            DataSource = dsCota
            ReadOnly = True
            TabOrder = 15
          end
          object DBEdit14: TDBEdit
            Left = 312
            Top = 145
            Width = 65
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'PreRat'
            DataSource = dsCota
            ReadOnly = True
            TabOrder = 16
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Demonstrativo'
        ImageIndex = 1
        object GroupBox1: TGroupBox
          Left = 0
          Top = 0
          Width = 385
          Height = 253
          Align = alClient
          TabOrder = 0
          object Label16: TLabel
            Left = 20
            Top = 24
            Width = 137
            Height = 21
            AutoSize = False
            Caption = 'Valor Corrigido (R$)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblVlrCorrigido: TLabel
            Left = 268
            Top = 24
            Width = 97
            Height = 21
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblVlrReducao: TLabel
            Left = 268
            Top = 48
            Width = 97
            Height = 21
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label17: TLabel
            Left = 20
            Top = 48
            Width = 137
            Height = 21
            AutoSize = False
            Caption = 'Valor Redu'#231#227'o (R$)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label18: TLabel
            Left = 20
            Top = 72
            Width = 137
            Height = 21
            AutoSize = False
            Caption = 'Total (R$)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTotal: TLabel
            Left = 268
            Top = 72
            Width = 97
            Height = 21
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblAdmDevido: TLabel
            Left = 268
            Top = 108
            Width = 97
            Height = 21
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label19: TLabel
            Left = 20
            Top = 108
            Width = 137
            Height = 21
            AutoSize = False
            Caption = 'Taxa Adm Devido (R$)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label20: TLabel
            Left = 20
            Top = 132
            Width = 145
            Height = 21
            AutoSize = False
            Caption = 'Taxa Adm Recebida (R$)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblAdmRec: TLabel
            Left = 268
            Top = 132
            Width = 97
            Height = 21
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblAdmARecolher: TLabel
            Left = 268
            Top = 156
            Width = 97
            Height = 21
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label21: TLabel
            Left = 20
            Top = 156
            Width = 145
            Height = 21
            AutoSize = False
            Caption = 'Taxa Adm a Recolher (R$)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label22: TLabel
            Left = 20
            Top = 180
            Width = 145
            Height = 21
            AutoSize = False
            Caption = '50 % Taxa Adm (R$)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblAdm50: TLabel
            Left = 268
            Top = 180
            Width = 97
            Height = 21
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblRestituir: TLabel
            Left = 268
            Top = 212
            Width = 97
            Height = 21
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label23: TLabel
            Left = 20
            Top = 212
            Width = 145
            Height = 21
            AutoSize = False
            Caption = 'A Restituir (R$)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
    end
  end
  object DBEdit8: TDBEdit
    Left = 12
    Top = 27
    Width = 50
    Height = 21
    TabStop = False
    Color = clBtnFace
    DataField = 'GRUPO'
    DataSource = dsCota
    ReadOnly = True
    TabOrder = 2
  end
  object dsCota: TDataSource
    AutoEdit = False
    DataSet = DM.cdsCot
    Left = 40
    Top = 344
  end
  object dsReu: TDataSource
    AutoEdit = False
    DataSet = DM.sdsReu
    Left = 104
    Top = 344
  end
  object dsPre: TDataSource
    AutoEdit = False
    DataSet = DM.sdsPre
    Left = 168
    Top = 344
  end
  object dsBem: TDataSource
    AutoEdit = False
    DataSet = DM.sdsBem
    Left = 136
    Top = 344
  end
end
