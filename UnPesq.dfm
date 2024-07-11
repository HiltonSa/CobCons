object frmPesq: TfrmPesq
  Left = 503
  Top = 180
  BorderStyle = bsToolWindow
  Caption = 'Pesquisa Consorciado por NOME, CPF ou CNPJ'
  ClientHeight = 272
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 446
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    Color = clSkyBlue
    TabOrder = 0
    object txtPesq: TEdit
      Left = 6
      Top = 10
      Width = 315
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      OnChange = txtPesqChange
      OnEnter = txtPesqEnter
    end
  end
  object stBar: TStatusBar
    Left = 0
    Top = 253
    Width = 446
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 446
    Height = 212
    Align = alClient
    DataSource = DS
    Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnEnter = DBGrid1Enter
    OnKeyDown = DBGrid1KeyDown
  end
  object DS: TDataSource
    AutoEdit = False
    DataSet = DM.cdsCons
    Left = 40
  end
  object AL: TActionList
    Images = DM.IL
    Left = 112
    Top = 72
    object Pesq: TAction
      Caption = '&Pesquisar'
      Hint = 'Clique para pesquisar'
      ImageIndex = 10
      ShortCut = 120
      OnExecute = PesqExecute
    end
  end
end
