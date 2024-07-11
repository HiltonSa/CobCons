object FrmMov: TFrmMov
  Left = 0
  Top = 0
  ActiveControl = cboAviso
  BorderStyle = bsToolWindow
  Caption = 'Pagamentos'
  ClientHeight = 397
  ClientWidth = 420
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 420
    Height = 356
    Align = alClient
    BevelInner = bvLowered
    Color = clSkyBlue
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 10
      Width = 29
      Height = 13
      Caption = 'Grupo'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 119
      Top = 10
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object Label3: TLabel
      Left = 56
      Top = 10
      Width = 18
      Height = 13
      Caption = 'Seq'
      FocusControl = DBEdit1
    end
    object Label4: TLabel
      Left = 79
      Top = 10
      Width = 23
      Height = 13
      Caption = 'Cota'
      FocusControl = DBEdit1
    end
    object Label5: TLabel
      Left = 83
      Top = 51
      Width = 90
      Height = 13
      Caption = 'Tipo de Movimento'
    end
    object Label6: TLabel
      Left = 234
      Top = 51
      Width = 55
      Height = 13
      Caption = 'Vencimento'
    end
    object Label8: TLabel
      Left = 8
      Top = 51
      Width = 26
      Height = 13
      Caption = 'Aviso'
      FocusControl = DBEdit1
    end
    object Label9: TLabel
      Left = 324
      Top = 51
      Width = 69
      Height = 13
      Caption = 'Contabiliza'#231#227'o'
    end
    object Label10: TLabel
      Left = 8
      Top = 94
      Width = 54
      Height = 13
      Caption = 'Pagamento'
    end
    object Label15: TLabel
      Left = 99
      Top = 94
      Width = 39
      Height = 13
      Caption = 'Vlr. Bem'
      FocusControl = DBEdit1
    end
    object Label16: TLabel
      Left = 10
      Top = 137
      Width = 41
      Height = 13
      Caption = 'Hist'#243'rico'
      FocusControl = DBEdit1
    end
    object Label17: TLabel
      Left = 288
      Top = 94
      Width = 51
      Height = 13
      Caption = 'Valor Pago'
      FocusControl = DBEdit1
    end
    object Label11: TLabel
      Left = 8
      Top = 184
      Width = 145
      Height = 21
      AutoSize = False
      Caption = 'Aquisi'#231#227'o'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label12: TLabel
      Left = 8
      Top = 212
      Width = 145
      Height = 21
      AutoSize = False
      Caption = 'Reserva'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label13: TLabel
      Left = 8
      Top = 239
      Width = 145
      Height = 21
      AutoSize = False
      Caption = 'Tx. Administra'#231#227'o'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label14: TLabel
      Left = 8
      Top = 266
      Width = 145
      Height = 21
      AutoSize = False
      Caption = 'Outros'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label7: TLabel
      Left = 8
      Top = 293
      Width = 145
      Height = 21
      AutoSize = False
      Caption = 'Multas / Juros'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label18: TLabel
      Left = 8
      Top = 320
      Width = 145
      Height = 21
      AutoSize = False
      Caption = 'Total'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label19: TLabel
      Left = 203
      Top = 94
      Width = 38
      Height = 13
      Caption = '% Pago'
      FocusControl = DBEdit1
    end
    object DBEdit1: TDBEdit
      Left = 79
      Top = 26
      Width = 34
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'COTA'
      DataSource = dsCot
      ReadOnly = True
      TabOrder = 14
    end
    object DBEdit2: TDBEdit
      Left = 119
      Top = 26
      Width = 290
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'NOME'
      DataSource = dsCot
      ReadOnly = True
      TabOrder = 15
    end
    object DBEdit3: TDBEdit
      Left = 8
      Top = 26
      Width = 41
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'GRUPO'
      DataSource = dsCot
      ReadOnly = True
      TabOrder = 16
    end
    object DBEdit4: TDBEdit
      Left = 56
      Top = 26
      Width = 17
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'SEQ'
      DataSource = dsCot
      ReadOnly = True
      TabOrder = 17
    end
    object cboTmv: TComboBox
      Left = 83
      Top = 67
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnSelect = cboTmvSelect
      Items.Strings = (
        '01 PAGTO PARCELA'
        'SR PAGTO SLD REMANESCENTE'
        '04 PAGTO RATEIO'
        '14 PAGTO CUSTAS'
        '15 PAGTO DESPESAS'
        '94 DEVOL PAGTOS')
    end
    object dtVenc: TJvDBDatePickerEdit
      Left = 234
      Top = 67
      Width = 85
      Height = 21
      AllowNoDate = True
      DataField = 'D_VENCTO'
      DataSource = dsMvt
      TabOrder = 2
    end
    object dtContab: TJvDBDatePickerEdit
      Left = 324
      Top = 67
      Width = 85
      Height = 21
      AllowNoDate = True
      DataField = 'D_CONTAB'
      DataSource = dsMvt
      TabOrder = 3
    end
    object dtPagto: TJvDBDatePickerEdit
      Left = 8
      Top = 111
      Width = 85
      Height = 21
      AllowNoDate = True
      DataField = 'DT_PAGTO'
      DataSource = dsMvt
      TabOrder = 4
      OnExit = dtPagtoExit
    end
    object DBEdit6: TDBEdit
      Left = 99
      Top = 111
      Width = 96
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'PRE_TABE'
      DataSource = dsPre
      ReadOnly = True
      TabOrder = 18
    end
    object edHis: TEdit
      Left = 8
      Top = 154
      Width = 401
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 30
      TabOrder = 7
    end
    object edtValor: TJvCalcEdit
      Left = 288
      Top = 111
      Width = 121
      Height = 21
      DisplayFormat = ',#0.00'
      TabOrder = 6
      DecimalPlacesAlwaysShown = False
      OnExit = edtValorExit
    end
    object DBEdit9: TDBEdit
      Left = 288
      Top = 181
      Width = 121
      Height = 21
      Color = clBtnFace
      DataField = 'F_AQUISI'
      DataSource = dsMvt
      TabOrder = 9
      OnExit = DBEdit9Exit
    end
    object DBEdit10: TDBEdit
      Left = 203
      Top = 181
      Width = 73
      Height = 21
      Color = clBtnFace
      DataField = 'P_NORMAL'
      DataSource = dsMvt
      TabOrder = 8
      OnExit = DBEdit10Exit
    end
    object DBEdit11: TDBEdit
      Left = 288
      Top = 209
      Width = 121
      Height = 21
      Color = clBtnFace
      DataField = 'F_RESERV'
      DataSource = dsMvt
      TabOrder = 10
      OnExit = DBEdit9Exit
    end
    object DBEdit12: TDBEdit
      Left = 288
      Top = 236
      Width = 121
      Height = 21
      Color = clBtnFace
      DataField = 'ADMINIST'
      DataSource = dsMvt
      TabOrder = 11
      OnExit = DBEdit9Exit
    end
    object DBEdit13: TDBEdit
      Left = 288
      Top = 263
      Width = 121
      Height = 21
      Color = clBtnFace
      DataField = 'OUTROS'
      DataSource = dsMvt
      TabOrder = 12
      OnExit = DBEdit9Exit
    end
    object DBEdit7: TDBEdit
      Left = 288
      Top = 290
      Width = 121
      Height = 21
      Color = clBtnFace
      DataField = 'MUL_JUR'
      DataSource = dsMvt
      TabOrder = 13
      OnExit = DBEdit9Exit
    end
    object cboAviso: TComboBox
      Left = 8
      Top = 67
      Width = 70
      Height = 21
      Style = csDropDownList
      ItemHeight = 0
      TabOrder = 0
      OnSelect = cboAvisoSelect
    end
    object edTot: TJvCalcEdit
      Left = 288
      Top = 320
      Width = 121
      Height = 21
      TabStop = False
      Color = clBtnFace
      DirectInput = False
      DisplayFormat = ',#0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      ShowButton = False
      TabOrder = 19
      DisabledColor = clWhite
      DecimalPlacesAlwaysShown = False
      OnExit = edtValorExit
    end
    object edtPc: TJvCalcEdit
      Left = 203
      Top = 111
      Width = 73
      Height = 21
      DisplayFormat = ',#0.0000'
      Enabled = False
      TabOrder = 5
      DecimalPlacesAlwaysShown = False
      OnExit = edtPcExit
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 356
    Width = 420
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    Color = clMoneyGreen
    TabOrder = 1
    object btExcPend: TSpeedButton
      Left = 288
      Top = 11
      Width = 121
      Height = 20
      Action = Cancelar
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF000000000000000000000000000000000000000000000000000000
        00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF007F7F7F007F7F7F007F7F7F007F7F7F007F7F
        7F007F7F7F0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF0000000000BFBFBF0000000000BFBFBF000000
        00007F7F7F0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF0000000000BFBFBF00000000007F7F7F000000
        00007F7F7F0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF0000000000BFBFBF0000000000BFBFBF000000
        00007F7F7F0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF0000000000BFBFBF00000000007F7F7F000000
        00007F7F7F0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF0000000000BFBFBF0000000000BFBFBF000000
        00007F7F7F0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        0000FF00FF0000000000FFFFFF0000000000BFBFBF00000000007F7F7F000000
        00007F7F7F0000000000FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00
        FF000000000000000000FFFFFF0000000000BFBFBF0000000000BFBFBF000000
        00007F7F7F000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF0000000000BFBFBF00000000007F7F7F000000
        00007F7F7F0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000007F7F7F00000000007F7F7F00000000007F7F7F000000
        00007F7F7F0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000FFFFFF00BFBFBF00BFBFBF00BFBFBF007F7F7F007F7F7F007F7F
        7F007F7F7F007F7F7F0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000007F7F7F007F7F7F007F7F7F000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    end
    object btIncPend: TSpeedButton
      Left = 8
      Top = 11
      Width = 145
      Height = 20
      Action = Gravar
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
        0000FF00FF000000000000000000000000000000000000000000FFFFFF00FFFF
        FF0000000000FFFFFF000000000000000000FFFFFF0000000000FFFF00000000
        00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF0000000000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF00000000
        000000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000000000000000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFF00000000
        0000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
        0000FFFFFF000000000000000000FFFFFF00FFFFFF0000000000FFFF00000000
        000000FFFF00FFFFFF0000FFFF00FFFFFF000000000000000000000000000000
        00000000000000FFFF0000000000FFFFFF00FFFFFF0000000000FFFF00000000
        0000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
        FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFF00000000
        000000FFFF00FFFFFF0000000000000000000000000000000000000000000000
        000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
        00000000000000FFFF00FFFFFF0000FFFF00000000000000000000FFFF000000
        0000FFFFFF00FFFFFF000000000000000000FFFFFF0000000000FF00FF00FF00
        FF00FF00FF000000000000000000000000000000000000FFFF0000000000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000000000FFFF0000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF000000000000FFFF0000000000FFFFFF00FFFFFF000000
        000000000000FFFFFF0000000000FFFFFF00FFFFFF0000000000FF00FF00FF00
        FF00FF00FF000000000000FFFF000000000000000000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0000000000FFFFFF0000000000FF00FF00FF00FF00FF00
        FF00000000000000FF0000000000FF00FF0000000000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FF00FF00FF00FF000000000000000000000000000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00}
    end
  end
  object dsCot: TDataSource
    AutoEdit = False
    DataSet = DM.cdsCot
    Left = 344
  end
  object dsMvt: TDataSource
    AutoEdit = False
    DataSet = DM.cdsMvt
    Left = 312
  end
  object AL: TActionList
    Left = 248
    object Gravar: TAction
      Caption = 'Gravar'
      Hint = 'Clique para salvar as informa'#231#245'es'
      OnExecute = GravarExecute
    end
    object Cancelar: TAction
      Caption = 'Cancelar'
      Hint = 'Clique para cancelar as altera'#231#245'es'
      OnExecute = CancelarExecute
    end
  end
  object dsPre: TDataSource
    DataSet = DM.sdsPre
    Left = 208
  end
end
