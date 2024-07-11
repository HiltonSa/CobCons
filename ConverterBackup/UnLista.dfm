object FrmLista: TFrmLista
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  ClientHeight = 224
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grLista: TDBGrid
    Left = 0
    Top = 0
    Width = 426
    Height = 224
    Align = alClient
    DataSource = dsLista
    Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = grListaDblClick
    OnEnter = grListaEnter
  end
  object dsLista: TDataSource
    AutoEdit = False
    DataSet = DM.cdsPesq
    Left = 200
    Top = 112
  end
end
