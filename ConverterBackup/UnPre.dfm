object frmPre: TfrmPre
  Left = 693
  Top = 113
  BorderStyle = bsToolWindow
  Caption = 'Evolu'#231#227'o de Pre'#231'os'
  ClientHeight = 446
  ClientWidth = 240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ShowHint = True
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 240
    Height = 97
    Align = alTop
    BevelInner = bvLowered
    Color = clMoneyGreen
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 21
      Height = 13
      Caption = 'Bem'
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 45
      Height = 13
      Caption = 'Tipo Bem'
    end
    object Label3: TLabel
      Left = 160
      Top = 48
      Width = 50
      Height = 13
      Caption = 'Fabricante'
    end
    object DBEdit1: TDBEdit
      Left = 16
      Top = 24
      Width = 209
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'DESCRIC'
      DataSource = dsBem
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 160
      Top = 64
      Width = 65
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'FABRICAN'
      DataSource = dsBem
      ReadOnly = True
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 16
      Top = 64
      Width = 65
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'TIPO_BEM'
      DataSource = dsBem
      ReadOnly = True
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 97
    Width = 240
    Height = 349
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 2
      Width = 236
      Height = 345
      Align = alClient
      DataSource = dsPre
      Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DT_BASE'
          Width = 93
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRE_TABE'
          Visible = True
        end>
    end
  end
  object dsBem: TDataSource
    DataSet = DM.sdsBem
    Left = 120
  end
  object dsPre: TDataSource
    AutoEdit = False
    DataSet = DM.sdsPre
    Left = 152
  end
end
