object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'Conversor da Base de Dados'
  ClientHeight = 404
  ClientWidth = 690
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 160
    Width = 67
    Height = 13
    Caption = 'Comando SQL'
  end
  object lblArqEnt: TLabel
    Left = 16
    Top = 11
    Width = 127
    Height = 13
    Caption = 'Arquivo Texto a converter'
  end
  object Label2: TLabel
    Left = 16
    Top = 49
    Width = 45
    Height = 13
    Caption = 'Estrutura'
  end
  object lblDiretorio: TLabel
    Left = 415
    Top = 111
    Width = 108
    Height = 13
    Caption = 'C:\Windows\system32'
  end
  object mmComandoSQL: TMemo
    Left = 16
    Top = 176
    Width = 393
    Height = 89
    Lines.Strings = (
      'mmComandoSQL')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object EditNomeTab: TEdit
    Left = 288
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object mmEstrutura: TMemo
    Left = 16
    Top = 65
    Width = 393
    Height = 89
    Lines.Strings = (
      'mmEstrutura')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object btnImportar: TButton
    Left = 415
    Top = 343
    Width = 75
    Height = 25
    Caption = 'Importar'
    TabOrder = 3
    OnClick = btnImportarClick
  end
  object stBar: TStatusBar
    Left = 0
    Top = 385
    Width = 690
    Height = 19
    Panels = <>
  end
  object mmLinha: TMemo
    Left = 16
    Top = 279
    Width = 393
    Height = 89
    Lines.Strings = (
      'mmLinha')
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object dlb: TDirectoryListBox
    Left = 415
    Top = 8
    Width = 265
    Height = 97
    DirLabel = lblDiretorio
    FileList = flb
    ItemHeight = 16
    TabOrder = 6
  end
  object flb: TFileListBox
    Left = 415
    Top = 130
    Width = 265
    Height = 121
    ItemHeight = 13
    Mask = '*.txt'
    MultiSelect = True
    TabOrder = 7
  end
  object cbSelecionaTudo: TCheckBox
    Left = 417
    Top = 257
    Width = 265
    Height = 17
    Caption = 'Selecionar Todos os Arquivos'
    TabOrder = 8
    OnClick = cbSelecionaTudoClick
  end
  object Button1: TButton
    Left = 496
    Top = 343
    Width = 75
    Height = 25
    Caption = 'Criar TMO'
    TabOrder = 9
    OnClick = Button1Click
  end
  object cboModo: TComboBox
    Left = 415
    Top = 280
    Width = 267
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 10
    Text = 'Importar todas as tabelas'
    Items.Strings = (
      'Importar todas as tabelas'
      'Importar todas exceto movimentos'
      'Importar somente movimentos')
  end
end
