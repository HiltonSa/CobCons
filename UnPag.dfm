object frmPag: TfrmPag
  Left = 386
  Top = 167
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsToolWindow
  Caption = 'Conta Corrente'
  ClientHeight = 446
  ClientWidth = 570
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
    Width = 570
    Height = 57
    Align = alTop
    BevelInner = bvLowered
    Color = clMoneyGreen
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 29
      Height = 13
      Caption = 'Grupo'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 144
      Top = 8
      Width = 28
      Height = 13
      Caption = 'Nome'
    end
    object Label3: TLabel
      Left = 64
      Top = 8
      Width = 19
      Height = 13
      Caption = 'Seq'
      FocusControl = DBEdit1
    end
    object Label4: TLabel
      Left = 96
      Top = 8
      Width = 22
      Height = 13
      Caption = 'Cota'
      FocusControl = DBEdit1
    end
    object DBEdit1: TDBEdit
      Left = 96
      Top = 24
      Width = 41
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'COTA'
      DataSource = dsCot
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 144
      Top = 24
      Width = 273
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'NOME'
      DataSource = dsCot
      ReadOnly = True
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 16
      Top = 24
      Width = 41
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'GRUPO'
      DataSource = dsCot
      ReadOnly = True
      TabOrder = 2
    end
    object DBEdit4: TDBEdit
      Left = 64
      Top = 24
      Width = 25
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'SEQ'
      DataSource = dsCot
      ReadOnly = True
      TabOrder = 3
    end
    object DBEdit6: TDBEdit
      Left = 432
      Top = 24
      Width = 57
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'PcPago'
      DataSource = dsPag
      ReadOnly = True
      TabOrder = 4
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 57
    Width = 570
    Height = 389
    Align = alClient
    DataSource = dsPag
    Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'AVISO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGLA1'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'D_VENCTO'
        Width = 61
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DT_PAGTO'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'P_NORMAL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'P_DIFER'
        Width = 52
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'P_ANTEC'
        Width = 49
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MUL_JUR'
        Width = 63
        Visible = True
      end>
  end
  object dsCot: TDataSource
    AutoEdit = False
    DataSet = DM.cdsCot
    Left = 488
  end
  object dsPag: TDataSource
    AutoEdit = False
    DataSet = DM.cdsPag
    Left = 520
  end
end
