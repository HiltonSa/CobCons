object frmAli: TfrmAli
  Left = 393
  Top = 132
  BorderStyle = bsToolWindow
  Caption = 'Aliena'#231#245'es'
  ClientHeight = 446
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefaultPosOnly
  ShowHint = True
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object DBCtrlGrid1: TDBCtrlGrid
    Left = 0
    Top = 0
    Width = 433
    Height = 446
    Align = alClient
    DataSource = dsAli
    PanelHeight = 223
    PanelWidth = 416
    TabOrder = 0
    RowCount = 2
    object Label9: TLabel
      Left = 15
      Top = 57
      Width = 50
      Height = 13
      Caption = 'Fabricante'
      FocusControl = DBEdit9
    end
    object Label10: TLabel
      Left = 95
      Top = 57
      Width = 35
      Height = 13
      Caption = 'Modelo'
      FocusControl = DBEdit10
    end
    object Label11: TLabel
      Left = 311
      Top = 57
      Width = 16
      Height = 13
      Caption = 'Cor'
      FocusControl = DBEdit11
    end
    object Label12: TLabel
      Left = 15
      Top = 97
      Width = 48
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBEdit12
    end
    object Label13: TLabel
      Left = 311
      Top = 97
      Width = 46
      Height = 13
      Caption = 'Ano Fabr.'
      FocusControl = DBEdit13
    end
    object Label14: TLabel
      Left = 15
      Top = 137
      Width = 36
      Height = 13
      Caption = 'Chassis'
      FocusControl = DBEdit14
    end
    object Label15: TLabel
      Left = 175
      Top = 137
      Width = 46
      Height = 13
      Caption = 'Renavam'
      FocusControl = DBEdit15
    end
    object Label16: TLabel
      Left = 311
      Top = 137
      Width = 27
      Height = 13
      Caption = 'Placa'
      FocusControl = DBEdit16
    end
    object Label1: TLabel
      Left = 15
      Top = 177
      Width = 63
      Height = 13
      Caption = 'Observa'#231#245'es'
      FocusControl = DBEdit1
    end
    object DBEdit9: TDBEdit
      Left = 15
      Top = 73
      Width = 69
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'FABRICAN'
      DataSource = dsAli
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit10: TDBEdit
      Left = 95
      Top = 73
      Width = 209
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'LIN_MOD'
      DataSource = dsAli
      ReadOnly = True
      TabOrder = 1
    end
    object DBEdit11: TDBEdit
      Left = 311
      Top = 73
      Width = 89
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'COR'
      DataSource = dsAli
      ReadOnly = True
      TabOrder = 2
    end
    object DBEdit12: TDBEdit
      Left = 15
      Top = 113
      Width = 289
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'DESCRIC'
      DataSource = dsAli
      ReadOnly = True
      TabOrder = 3
    end
    object DBEdit13: TDBEdit
      Left = 311
      Top = 113
      Width = 56
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'ANO_FABR'
      DataSource = dsAli
      ReadOnly = True
      TabOrder = 4
    end
    object DBEdit14: TDBEdit
      Left = 15
      Top = 153
      Width = 145
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'NR_CHASS'
      DataSource = dsAli
      ReadOnly = True
      TabOrder = 5
    end
    object DBEdit15: TDBEdit
      Left = 175
      Top = 153
      Width = 129
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'NR_RENAV'
      DataSource = dsAli
      ReadOnly = True
      TabOrder = 6
    end
    object DBEdit16: TDBEdit
      Left = 311
      Top = 153
      Width = 57
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'PLACA'
      DataSource = dsAli
      ReadOnly = True
      TabOrder = 7
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 416
      Height = 57
      Align = alTop
      BevelInner = bvLowered
      Color = clMoneyGreen
      TabOrder = 8
      object Label8: TLabel
        Left = 275
        Top = 8
        Width = 79
        Height = 13
        Caption = 'Dt.Desaliena'#231#227'o'
        FocusControl = DBEdit8
      end
      object Label7: TLabel
        Left = 187
        Top = 8
        Width = 72
        Height = 13
        Caption = 'Dt.Substitui'#231#227'o'
        FocusControl = DBEdit7
      end
      object Label6: TLabel
        Left = 99
        Top = 8
        Width = 61
        Height = 13
        Caption = 'Dt.Aliena'#231#227'o'
        FocusControl = DBEdit6
      end
      object Label5: TLabel
        Left = 59
        Top = 8
        Width = 15
        Height = 13
        Caption = 'Sit.'
        FocusControl = DBEdit5
      end
      object DBEdit5: TDBEdit
        Left = 59
        Top = 28
        Width = 17
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'SIT_ALIE'
        DataSource = dsAli
        ReadOnly = True
        TabOrder = 0
      end
      object DBEdit6: TDBEdit
        Left = 99
        Top = 28
        Width = 70
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'DT_ALIE'
        DataSource = dsAli
        ReadOnly = True
        TabOrder = 1
      end
      object DBEdit7: TDBEdit
        Left = 187
        Top = 28
        Width = 70
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'DT_SUBST'
        DataSource = dsAli
        ReadOnly = True
        TabOrder = 2
      end
      object DBEdit8: TDBEdit
        Left = 275
        Top = 28
        Width = 81
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'DT_DESAL'
        DataSource = dsAli
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
    end
    object DBEdit1: TDBEdit
      Left = 15
      Top = 193
      Width = 385
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'OBSERVAC'
      DataSource = dsAli
      ReadOnly = True
      TabOrder = 9
    end
  end
  object dsAli: TDataSource
    AutoEdit = False
    DataSet = DM.cdsAli
    Left = 368
    Top = 8
  end
end
