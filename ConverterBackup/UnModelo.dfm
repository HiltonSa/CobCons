object frmMod: TfrmMod
  Left = 276
  Top = 162
  BorderStyle = bsToolWindow
  ClientHeight = 366
  ClientWidth = 592
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
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object stBar: TStatusBar
    Left = 0
    Top = 347
    Width = 592
    Height = 19
    Panels = <
      item
        Style = psOwnerDraw
        Width = 18
      end
      item
        Width = 50
      end>
    OnDrawPanel = stBarDrawPanel
  end
  object Panel1: TPanel
    Left = 505
    Top = 0
    Width = 87
    Height = 347
    Align = alRight
    BevelInner = bvLowered
    Color = clSilver
    TabOrder = 1
    object btnGravar: TSpeedButton
      Left = 4
      Top = 89
      Width = 80
      Height = 20
      Action = Grava
      Enabled = False
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        00000000000000000000000000007F7F7F007F7F7F007F7F7F007F7F7F007F7F
        7F007F7F7F007F7F7F000000000000000000FF00FF00FF00FF00000000000000
        00000000000000000000000000007F7F7F00BFBFBF00BFBFBF00BFBFBF00BFBF
        BF00BFBFBF00BFBFBF00000000000000000000000000FF00FF00000000000000
        00000000000000000000000000007F7F7F00BFBFBF000000000000000000BFBF
        BF00BFBFBF00BFBFBF00000000000000000000000000FF00FF00000000000000
        00000000000000000000000000007F7F7F00BFBFBF000000000000000000BFBF
        BF00BFBFBF00BFBFBF00000000000000000000000000FF00FF00000000000000
        00000000000000000000000000007F7F7F00BFBFBF00BFBFBF00BFBFBF00BFBF
        BF00BFBFBF00BFBFBF00000000000000000000000000FF00FF00000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FF00FF00000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FF00FF00000000000000
        000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00000000000000000000000000FF00FF00000000000000
        000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00000000000000000000000000FF00FF00000000000000
        000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00000000000000000000000000FF00FF00000000000000
        000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00000000000000000000000000FF00FF00000000000000
        000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00000000000000000000000000FF00FF00000000000000
        000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00000000007F7F7F0000000000FF00FF00000000000000
        000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00000000000000000000000000FF00FF00FF00FF000000
        0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
        FF000000FF000000FF000000000000000000FF00FF00FF00FF00}
    end
    object btnCancelar: TSpeedButton
      Left = 4
      Top = 110
      Width = 80
      Height = 20
      Action = Cancela
      Enabled = False
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF000000
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000FF000000FF000000FF000000FF000000FF000000FF000000
        FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF000000
        FF00FF00FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000FF000000FF00FF00FF00FF00FF000000FF000000
        FF00FF00FF00FF00FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF000000FF00FF00FF000000FF000000
        FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF000000FF00FF00FF000000FF000000
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF000000FF00FF00FF000000FF000000
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
        FF00FF00FF00FF00FF00FF00FF000000FF000000FF00FF00FF000000FF000000
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000
        FF000000FF00FF00FF00FF00FF000000FF000000FF00FF00FF00FF00FF000000
        FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        FF000000FF000000FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF000000
        FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000FF000000FF000000FF000000FF000000FF000000FF000000
        FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF000000
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    end
    object btnSair: TSpeedButton
      Left = 4
      Top = 132
      Width = 80
      Height = 20
      Action = Sair
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
        FF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000000080000000800000FFFF0000FFFF0000FFFF0000FFFF0000FF
        FF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000000000008000000080000000800000FFFF0000FFFF0000FFFF0000FF
        FF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000800000008000000080000000000000FFFF0000FFFF0000FF
        FF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000800000008000000080000000000000FFFF0000FFFF0000FF
        FF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000800000008000000080000000000000FFFF0000FFFF0000FF
        FF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000800000008000000080000000000000FFFF0000FFFF0000FF
        FF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000800000008000000080000000000000FFFF0000FFFF0000FF
        FF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000800000008000000080000000000000FFFF0000FFFF0000FF
        FF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000000000008000000080000000800000FFFF000000000000FFFF0000FF
        FF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000800000008000000080000000000000FFFF0000FFFF0000FF
        FF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000800000008000000080000000000000FFFF0000FFFF0000FF
        FF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000000000008000FFFF0000000080000000000000FFFF0000FFFF0000FF
        FF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000000000008000FFFF0000FFFF00000000000000FFFF0000FFFF0000FF
        FF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00}
    end
    object btnExcluir: TSpeedButton
      Left = 4
      Top = 67
      Width = 80
      Height = 20
      Action = Exclui
      Enabled = False
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
    object btnAlterar: TSpeedButton
      Left = 4
      Top = 46
      Width = 80
      Height = 20
      Action = Altera
      Enabled = False
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
    object btnIncluir: TSpeedButton
      Left = 4
      Top = 24
      Width = 80
      Height = 20
      Action = Novo
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000FFFF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000FFFF00FF00FF0000FF
        FF0000FFFF00FF00FF007F7F7F007F7F7F007F7F7F0000FFFF0000FFFF007F7F
        7F007F7F7F007F7F7F007F7F7F0000FFFF0000FFFF00FF00FF00FF00FF00FF00
        FF0000FFFF000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000FFFF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00000000007F7F7F00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00000000007F7F7F00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00000000007F7F7F00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00000000007F7F7F00FF00FF00FF00FF0000FFFF0000FF
        FF0000FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000000000000FFFF0000FFFF00FF00FF00FF00FF0000FF
        FF0000FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000000000000FFFF0000FFFF0000FFFF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
        FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
        FF000000000000FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
        0000FF00FF0000FFFF0000FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000FFFF00000000000000000000000000000000000000000000000000FF00
        FF00FF00FF00FF00FF0000FFFF0000FFFF00FF00FF00FF00FF00FF00FF0000FF
        FF0000FFFF00FF00FF00FF00FF00FF00FF00FF00FF0000FFFF0000FFFF00FF00
        FF00FF00FF00FF00FF00FF00FF0000FFFF0000FFFF00FF00FF0000FFFF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000FFFF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000FFFF00}
    end
  end
  object PC: TPageControl
    Left = 0
    Top = 0
    Width = 505
    Height = 347
    ActivePage = tbCon
    Align = alClient
    TabOrder = 2
    OnChanging = PCChanging
    object tbCon: TTabSheet
      Caption = 'Con&sulta'
      object grCon: TDBGrid
        Left = 0
        Top = 49
        Width = 497
        Height = 270
        Align = alClient
        DataSource = dsPesq
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnTitleClick = grConTitleClick
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 497
        Height = 49
        Align = alTop
        BevelInner = bvLowered
        TabOrder = 1
        object btnPesq: TSpeedButton
          Left = 316
          Top = 11
          Width = 80
          Height = 20
          Action = Pesquisa
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF008080800000000000000000000000000080808000FF00FF0000FF
            FF008080800000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00000000008080800080808000808080008080800080808000000000000000
            000000FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
            000080808000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00808080000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00808080008080
            8000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF008080
            800080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000008080
            8000C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C0008080
            800000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000008080
            8000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF008080
            800000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000008080
            8000C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C0008080
            800000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00808080008080
            8000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF008080
            800080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
            000080808000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00808080000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF0000000000808080008080800080808000808080008080800000000000FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF008080800000000000000000000000000080808000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        end
        object Label1: TLabel
          Left = 8
          Top = 8
          Width = 46
          Height = 13
          Caption = 'Pesquisar'
        end
        object Label2: TLabel
          Left = 104
          Top = 8
          Width = 40
          Height = 13
          Caption = 'Rela'#231#227'o'
        end
        object cboCampo: TComboBox
          Left = 8
          Top = 24
          Width = 89
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
        end
        object cboRel: TComboBox
          Left = 104
          Top = 24
          Width = 81
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 1
          Text = 'cont'#233'm'
          Items.Strings = (
            'cont'#233'm'
            'come'#231'a com'
            'igual a'
            'maior que'
            'maior ou igual a'
            'menor que'
            'menor ou igual a')
        end
        object txtPesq: TEdit
          Left = 192
          Top = 24
          Width = 121
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 2
        end
      end
    end
    object tbFic: TTabSheet
      Caption = '&Ficha'
      ImageIndex = 1
    end
  end
  object AL: TActionList
    Images = DM.IL
    Left = 184
    object Pesquisa: TAction
      Category = 'Manutencao'
      Caption = '&Pesq (F9)'
      Hint = 'Clique (ou F9) para pesquisar'
      ImageIndex = 10
    end
    object Novo: TAction
      Category = 'Manutencao'
      Caption = '&Novo (F2)'
      Hint = 'Clique (ou F2) para incluir'
      ImageIndex = 2
    end
    object Altera: TAction
      Category = 'Manutencao'
      Caption = '&Alterar (F3)'
      Hint = 'Clique (ou F3) para alterar os dados'
      ImageIndex = 1
    end
    object Exclui: TAction
      Category = 'Manutencao'
      Caption = '&Excluir (F4)'
      Hint = 'Clique (ou F4) para excluir os dados'
      ImageIndex = 4
      OnExecute = ExcluiExecute
    end
    object Grava: TAction
      Category = 'Manutencao'
      Caption = '&Grava (F5)'
      Hint = 'Clique (ou F5) para gravar os dados'
      ImageIndex = 3
    end
    object Cancela: TAction
      Category = 'Manutencao'
      Caption = '&Canc (F6)'
      Hint = 'Clique (ou F6) para cancelar as altera'#231#245'es'
      ImageIndex = 5
    end
    object Sair: TAction
      Category = 'Manutencao'
      Caption = '&Sair'
      Hint = 'Clique para finalizar'
      ImageIndex = 0
      OnExecute = SairExecute
    end
  end
  object DS: TDataSource
    AutoEdit = False
    OnStateChange = DSStateChange
    Left = 216
    Top = 1
  end
  object dsPesq: TDataSource
    AutoEdit = False
    Left = 248
  end
end