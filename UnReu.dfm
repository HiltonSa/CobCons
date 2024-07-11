object frmReu: TfrmReu
  Left = 642
  Top = 124
  BorderStyle = bsSizeToolWin
  Caption = 'Reuni'#245'es do Grupo'
  ClientHeight = 524
  ClientWidth = 218
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
    Width = 218
    Height = 49
    Align = alTop
    BevelInner = bvLowered
    Color = clMoneyGreen
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 6
      Width = 29
      Height = 13
      Caption = 'Grupo'
    end
    object Label2: TLabel
      Left = 79
      Top = 8
      Width = 41
      Height = 13
      Caption = 'Dura'#231#227'o'
    end
    object DBEdit1: TDBEdit
      Left = 16
      Top = 22
      Width = 57
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'GRUPO'
      DataSource = dsCot
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 79
      Top = 22
      Width = 41
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'PLANO'
      DataSource = dsCot
      ReadOnly = True
      TabOrder = 1
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 49
    Width = 218
    Height = 475
    Align = alClient
    DataSource = dsReu
    Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NRO_REU'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_REU'
        Width = 73
        Visible = True
      end>
  end
  object dsReu: TDataSource
    AutoEdit = False
    DataSet = DM.sdsReu
    Top = 96
  end
  object dsCot: TDataSource
    AutoEdit = False
    DataSet = DM.cdsCot
    Left = 32
    Top = 96
  end
end
