object frmMld: TfrmMld
  Left = 276
  Top = 162
  BorderStyle = bsToolWindow
  Caption = 'Mala Direta'
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
  OnClose = FormClose
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
      Left = 3
      Top = 163
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
      Left = 3
      Top = 215
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
      Left = 3
      Top = 321
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
      Left = 3
      Top = 110
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
      Left = 3
      Top = 57
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
      Left = 3
      Top = 5
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
    object btnImp: TSpeedButton
      Left = 4
      Top = 268
      Width = 80
      Height = 20
      Action = ImpCar
      Enabled = False
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000007F7F7F3F7F7F7F007F7F7F3F7F7F7F007F7F7F3F7F7F
        7F007F7F7F0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0000000000BFBFBFBFBFBFBF00BFBFBF000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FF00FF00000000BFFFFF
        FF00FFFFFFBFFFFFFF00FFFFFFBFFFFFFF00FFFFFFBFFFFFFF00FFFFFFBFFFFF
        FF00FFFFFF000000FF00FFFFFFBFFFFFFF0000000000FF00FF00000000BFFFFF
        FF007F7F7FBFBFBFBF00BFBFBFBFBFBFBF00BFBFBFBFBFBFBF00BFBFBFBFBFBF
        BF00BFBFBFBFBFBFBF007F7F7FBFFFFFFF0000000000FF00FF00000000BFFFFF
        FF007F7F7F000000000000000000000000000000000000000000000000000000
        00000000000000000000BFBFBFBFFFFFFF0000000000FF00FF00000000BFFFFF
        FF007F7F7F000000000000FF000000FF000000FF000000FF000000FF000000FF
        000000FF000000000000BFBFBFBFFFFFFF0000000000FF00FF00000000BFFFFF
        FF007F7F7F000000000000FF00BFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00
        FF0000FF000000000000BFBFBFBFFFFFFF0000000000FF00FF00000000BFFFFF
        FF007F7F7F000000000000FF00000000FF000000FF0000FF00000000FF000000
        FF0000FF000000000000BFBFBFBFFFFFFF0000000000FF00FF00000000BFFFFF
        FF007F7F7F000000000000FF00000000FF000000FF0000FF00000000FF000000
        FF0000FF000000000000BFBFBFBFFFFFFF0000000000FF00FF00000000BFFFFF
        FF007F7F7F000000000000FF000000FF000000FF000000FF000000FF000000FF
        000000FF000000000000BFBFBFBFFFFFFF0000000000FF00FF00000000BFFFFF
        FF007F7F7F000000000000000000000000000000000000000000000000000000
        00000000000000000000BFBFBFBFFFFFFF0000000000FF00FF00000000BFFFFF
        FF007F7F7F3F7F7F7F007F7F7F3F7F7F7F007F7F7F3F7F7F7F007F7F7F3F7F7F
        7F007F7F7F3F7F7F7F007F7F7FBFFFFFFF0000000000FF00FF00000000BFFFFF
        FF00FFFFFFBFFFFFFF00FFFFFFBFFFFFFF00FFFFFFBFFFFFFF00FFFFFFBFFFFF
        FF00FFFFFFBFFFFFFF00FFFFFFBFFFFFFF0000000000FF00FF00000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FF00FF00}
    end
  end
  object PC: TPageControl
    Left = 0
    Top = 0
    Width = 505
    Height = 347
    ActivePage = tbCli
    Align = alClient
    TabOrder = 2
    object tbCon: TTabSheet
      Caption = 'Con&sulta'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grCar: TDBGrid
        Left = 0
        Top = 0
        Width = 497
        Height = 319
        Align = alClient
        DataSource = DS
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = grCarDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'Codigo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Obs'
            Visible = True
          end>
      end
    end
    object tbFic: TTabSheet
      Caption = '&Ficha'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label3: TLabel
        Left = 20
        Top = 11
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
        FocusControl = DBEdit1
      end
      object Label4: TLabel
        Left = 76
        Top = 11
        Width = 48
        Height = 13
        Caption = 'Descri'#231#227'o'
        FocusControl = DBEdit2
      end
      object Label5: TLabel
        Left = 20
        Top = 51
        Width = 89
        Height = 13
        Caption = 'Conte'#250'do da Carta'
      end
      object DBEdit1: TDBEdit
        Left = 20
        Top = 27
        Width = 49
        Height = 21
        Color = clWhite
        DataField = 'Codigo'
        DataSource = DS
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 76
        Top = 27
        Width = 400
        Height = 21
        DataField = 'Obs'
        DataSource = DS
        TabOrder = 1
      end
      object Mala: TDBRichEdit
        Left = 20
        Top = 67
        Width = 457
        Height = 241
        DataField = 'Texto'
        DataSource = DS
        PopupMenu = PP
        ScrollBars = ssBoth
        TabOrder = 2
        WantTabs = True
      end
      object RE: TRichEdit
        Left = 8
        Top = 224
        Width = 489
        Height = 89
        Lines.Strings = (
          'RE')
        TabOrder = 3
        Visible = False
      end
    end
    object tbCli: TTabSheet
      Caption = 'C&lientes'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 497
        Height = 41
        Align = alTop
        BevelInner = bvLowered
        Color = clSkyBlue
        TabOrder = 0
        object cbSelTodos: TCheckBox
          Left = 16
          Top = 12
          Width = 105
          Height = 17
          Caption = '&Seleciona Todos'
          TabOrder = 0
          OnClick = cbSelTodosClick
        end
      end
      object grCon: TDBGrid
        Left = 0
        Top = 41
        Width = 497
        Height = 278
        Align = alClient
        DataSource = dsM
        Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnCellClick = grConCellClick
        OnDrawColumnCell = grConDrawColumnCell
        OnDblClick = grCarDblClick
        OnTitleClick = grConTitleClick
        Columns = <
          item
            Expanded = False
            Width = 20
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'GRUPO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SEQ'
            Width = 27
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COTA'
            Width = 31
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Width = 323
            Visible = True
          end>
      end
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
      OnExecute = NovoExecute
    end
    object Altera: TAction
      Category = 'Manutencao'
      Caption = '&Alterar (F3)'
      Hint = 'Clique (ou F3) para alterar os dados'
      ImageIndex = 1
      OnExecute = AlteraExecute
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
      OnExecute = GravaExecute
    end
    object Cancela: TAction
      Category = 'Manutencao'
      Caption = '&Canc (F6)'
      Hint = 'Clique (ou F6) para cancelar as altera'#231#245'es'
      ImageIndex = 5
      OnExecute = CancelaExecute
    end
    object Sair: TAction
      Category = 'Manutencao'
      Caption = '&Sair'
      Hint = 'Clique para finalizar'
      ImageIndex = 0
      OnExecute = SairExecute
    end
    object Fon: TAction
      Category = 'Manutencao'
      Caption = 'Alterar Fonte'
      Hint = 'Clique para alterar a fonte do texto'
      ImageIndex = 1
      ShortCut = 16454
      OnExecute = FonExecute
    end
    object ImpCar: TAction
      Category = 'Manutencao'
      Caption = '&Imprimir (F7)'
      Hint = 'Clique ou (F7) para imprimir a mala direta'
      ImageIndex = 15
      OnExecute = ImpCarExecute
    end
  end
  object DS: TDataSource
    AutoEdit = False
    DataSet = DM.cdsTex
    OnStateChange = DSStateChange
    Left = 216
    Top = 1
  end
  object PP: TPopupMenu
    Left = 280
    object Fontes1: TMenuItem
      Action = Fon
    end
    object InserirCampos1: TMenuItem
      Caption = '&Inserir Campos'
      object Grupo1: TMenuItem
        Caption = 'Grupo'
        OnClick = MenuClick
      end
      object Sequencia1: TMenuItem
        Caption = 'Sequencia'
        OnClick = MenuClick
      end
      object Cota1: TMenuItem
        Caption = 'Cota'
        OnClick = MenuClick
      end
      object Nome1: TMenuItem
        Caption = 'Nome'
        OnClick = MenuClick
      end
      object Endereco1: TMenuItem
        Caption = 'Endereco'
        OnClick = MenuClick
      end
      object Complemento1: TMenuItem
        Caption = 'Complemento'
        OnClick = MenuClick
      end
      object Bairro1: TMenuItem
        Caption = 'Bairro'
        OnClick = MenuClick
      end
      object Cidade1: TMenuItem
        Caption = 'Cidade'
        OnClick = MenuClick
      end
      object UF1: TMenuItem
        Caption = 'UF'
        OnClick = MenuClick
      end
      object CEP1: TMenuItem
        Caption = 'CEP'
        OnClick = MenuClick
      end
      object Data1: TMenuItem
        Caption = 'Data'
        OnClick = MenuClick
      end
    end
  end
  object dsM: TDataSource
    OnStateChange = dsMStateChange
    Left = 248
  end
end