object frmCli: TfrmCli
  Left = 234
  Top = 160
  ActiveControl = txtGru
  BorderStyle = bsSizeToolWin
  Caption = 'Consulta Clientes'
  ClientHeight = 443
  ClientWidth = 715
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
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object stBar: TStatusBar
    Left = 0
    Top = 424
    Width = 715
    Height = 19
    Panels = <
      item
        Style = psOwnerDraw
        Width = 18
      end
      item
        Width = 580
      end
      item
        Alignment = taCenter
        Width = 55
      end
      item
        Alignment = taCenter
        Width = 50
      end>
    OnDrawPanel = stBarDrawPanel
  end
  object Panel1: TPanel
    Left = 602
    Top = 0
    Width = 113
    Height = 424
    Align = alRight
    BevelInner = bvLowered
    Color = clSilver
    TabOrder = 1
    object btnSair: TSpeedButton
      Left = 6
      Top = 401
      Width = 105
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
    object btnPos: TSpeedButton
      Left = 6
      Top = 375
      Width = 105
      Height = 20
      Action = impPos
      Enabled = False
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FF00FF0000000000BFBF
        BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
        BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF000000000000000000BFBF
        BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
        BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000FFFF
        FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFF
        FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF000000000000000000BFBF
        BF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBF
        BF00FFFFFF00BFBFBF00FFFFFF000000FF00FFFFFF000000000000000000FFFF
        FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF00FFFF
        FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF00BFBFBF0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF0000000000000000000000000000000000FFFF
        FF0000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF000000000000000000FFFFFF00000000000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
        FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF0000000000BFBFBF00FFFFFF0000000000FFFF
        FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000000000000000000000000000000000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    end
    object Panel4: TPanel
      Left = 2
      Top = 2
      Width = 109
      Height = 207
      Align = alTop
      BevelOuter = bvSpace
      Color = clMedGray
      TabOrder = 0
      object btPesq: TSpeedButton
        Left = 4
        Top = 3
        Width = 105
        Height = 41
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
      object btnReu: TSpeedButton
        Left = 3
        Top = 50
        Width = 105
        Height = 20
        Action = Reu
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF0000000000000000000000000000000000FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00000000000000000000000000000000000000
          000000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00000000000000000000000000000000000000
          000000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
          0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF000000000000000000FFFFFF00FFFFFF000000
          0000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000000000000000000000000000000000000000
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      end
      object btnPre: TSpeedButton
        Left = 3
        Top = 76
        Width = 105
        Height = 20
        Action = Pre
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF0000000000000000000000000000000000FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00000000000000000000000000000000000000
          000000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00000000000000000000000000000000000000
          000000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
          0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF000000000000000000FFFFFF00FFFFFF000000
          0000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000000000000000000000000000000000000000
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      end
      object btnJur: TSpeedButton
        Left = 3
        Top = 102
        Width = 105
        Height = 20
        Action = Jur
        Flat = True
      end
      object btnCom: TSpeedButton
        Left = 3
        Top = 128
        Width = 112
        Height = 20
        Action = Com
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF000000
          00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
          0000FFFFFF0000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF000000
          0000FFFFFF0000000000FFFFFF00000000000000000000000000FFFFFF000000
          00007F7F7F0000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF000000
          0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
          00007F7F7F0000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF000000
          0000FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
          0000FFFFFF0000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF0000000000000000000000000000000000FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF0000000000FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF000000
          00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
          FF0000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      end
      object btnDevCon: TSpeedButton
        Left = 3
        Top = 151
        Width = 105
        Height = 20
        Action = DevCon
        Enabled = False
        Flat = True
      end
      object SpeedButton4: TSpeedButton
        Left = 4
        Top = 175
        Width = 105
        Height = 20
        Action = sitCob
        Flat = True
      end
    end
    object cbPen: TCheckBox
      Left = 5
      Top = 345
      Width = 97
      Height = 17
      Hint = 'Marque para imprimir pendencias na posi'#231#227'o'
      Caption = 'Imp. Pendencias'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 1
    end
    object rbPag: TRadioButton
      Left = 4
      Top = 307
      Width = 80
      Height = 17
      Hint = 'Imprimir pagamentos'
      Caption = 'Imp. Pagtos'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
    object rbFin: TRadioButton
      Left = 4
      Top = 325
      Width = 92
      Height = 17
      Hint = 'Imprimir Movimento Financeiro'
      Caption = 'Imp. Mov. Fin.'
      TabOrder = 3
    end
    object rbSemPag: TRadioButton
      Left = 4
      Top = 289
      Width = 93
      Height = 17
      Hint = 'N'#227'o Imprimir pagamentos'
      Caption = 'N'#227'o Imp. Pagtos.'
      TabOrder = 4
    end
  end
  object Panel10: TPanel
    Left = 0
    Top = 0
    Width = 602
    Height = 424
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 2
    object Panel2: TPanel
      Left = 2
      Top = 2
      Width = 598
      Height = 57
      Align = alTop
      BevelInner = bvLowered
      Color = clMoneyGreen
      TabOrder = 0
      object Label1: TLabel
        Left = 255
        Top = 8
        Width = 40
        Height = 13
        Caption = 'Contrato'
        FocusControl = DBEdit1
      end
      object Label2: TLabel
        Left = 319
        Top = 8
        Width = 28
        Height = 13
        Caption = 'Nome'
        FocusControl = DBEdit2
      end
      object SpeedButton1: TSpeedButton
        Left = 152
        Top = 24
        Width = 23
        Height = 21
        Action = LisCota
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
      object spLisGru: TSpeedButton
        Left = 59
        Top = 24
        Width = 23
        Height = 21
        Action = LisGru
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
      object txtGru: TLabeledEdit
        Left = 8
        Top = 24
        Width = 49
        Height = 21
        CharCase = ecUpperCase
        EditLabel.Width = 29
        EditLabel.Height = 13
        EditLabel.Caption = 'Grupo'
        MaxLength = 4
        TabOrder = 0
        OnExit = txtGruExit
      end
      object txtSeq: TLabeledEdit
        Left = 85
        Top = 24
        Width = 25
        Height = 21
        EditLabel.Width = 19
        EditLabel.Height = 13
        EditLabel.Caption = 'Seq'
        MaxLength = 2
        TabOrder = 1
        OnExit = txtSeqExit
      end
      object txtCota: TLabeledEdit
        Left = 116
        Top = 24
        Width = 33
        Height = 21
        EditLabel.Width = 22
        EditLabel.Height = 13
        EditLabel.Caption = 'Cota'
        MaxLength = 3
        TabOrder = 2
        OnExit = txtCotaExit
      end
      object DBEdit1: TDBEdit
        Left = 255
        Top = 24
        Width = 57
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'CONTRATO'
        DataSource = dsCot
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object DBEdit2: TDBEdit
        Left = 319
        Top = 24
        Width = 273
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'NOME'
        DataSource = dsCot
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
      end
    end
    object Panel3: TPanel
      Left = 2
      Top = 59
      Width = 598
      Height = 363
      Align = alClient
      BevelInner = bvLowered
      TabOrder = 1
      object PC: TPageControl
        Left = 2
        Top = 2
        Width = 594
        Height = 359
        ActivePage = tbPag
        Align = alClient
        TabOrder = 0
        object tbCont: TTabSheet
          Caption = 'Co&ntrato'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object grbCont: TGroupBox
            Left = 2
            Top = 225
            Width = 584
            Height = 69
            Caption = 'Dados da Contempla'#231#227'o'
            Color = clBtnFace
            ParentColor = False
            TabOrder = 0
            object Label29: TLabel
              Left = 6
              Top = 16
              Width = 21
              Height = 13
              Caption = 'Tipo'
              FocusControl = DBEdit27
            end
            object Label30: TLabel
              Left = 33
              Top = 16
              Width = 56
              Height = 13
              Caption = 'Dt.Contemp'
              FocusControl = DBEdit28
            end
            object Label31: TLabel
              Left = 128
              Top = 16
              Width = 37
              Height = 13
              Caption = 'Entrega'
              FocusControl = DBEdit29
            end
            object Label32: TLabel
              Left = 232
              Top = 16
              Width = 58
              Height = 13
              Caption = 'Vlr Entregue'
              FocusControl = DBEdit30
            end
            object spCreditos: TSpeedButton
              Left = 322
              Top = 29
              Width = 65
              Height = 25
              Action = Cre
              Flat = True
            end
            object btnAli: TSpeedButton
              Left = 398
              Top = 28
              Width = 65
              Height = 25
              Action = Ali
              Flat = True
            end
            object DBEdit27: TDBEdit
              Left = 6
              Top = 32
              Width = 17
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TP_CONTE'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 0
            end
            object DBEdit28: TDBEdit
              Left = 33
              Top = 32
              Width = 75
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'DT_CONTE'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 1
            end
            object DBEdit29: TDBEdit
              Left = 128
              Top = 32
              Width = 75
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'DT_ENTRE'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 2
            end
            object DBEdit30: TDBEdit
              Left = 232
              Top = 32
              Width = 73
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'VAL_ENTR'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 3
            end
          end
          object grBem: TGroupBox
            Left = 3
            Top = 146
            Width = 583
            Height = 73
            Caption = 'Dados do Bem Objeto'
            Color = clBtnFace
            ParentColor = False
            TabOrder = 1
            object Label3: TLabel
              Left = 9
              Top = 20
              Width = 21
              Height = 13
              Caption = 'Bem'
              FocusControl = DBEdit3
            end
            object Label6: TLabel
              Left = 281
              Top = 20
              Width = 45
              Height = 13
              Caption = 'Tipo Bem'
            end
            object Label7: TLabel
              Left = 361
              Top = 20
              Width = 50
              Height = 13
              Caption = 'Fabricante'
            end
            object Label9: TLabel
              Left = 445
              Top = 20
              Width = 51
              Height = 13
              Caption = 'Valor Atual'
            end
            object DBEdit3: TDBEdit
              Left = 9
              Top = 36
              Width = 41
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'BEM'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 0
            end
            object DBEdit6: TDBEdit
              Left = 57
              Top = 36
              Width = 201
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'DESCRIC'
              DataSource = dsBem
              ReadOnly = True
              TabOrder = 1
            end
            object DBEdit7: TDBEdit
              Left = 281
              Top = 36
              Width = 65
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TIPO_BEM'
              DataSource = dsBem
              ReadOnly = True
              TabOrder = 2
            end
            object DBEdit8: TDBEdit
              Left = 361
              Top = 36
              Width = 65
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'FABRICAN'
              DataSource = dsBem
              ReadOnly = True
              TabOrder = 3
            end
            object DBEdit10: TDBEdit
              Left = 445
              Top = 36
              Width = 108
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'PRE_TABE'
              DataSource = dsPre
              ReadOnly = True
              TabOrder = 4
            end
          end
          object dbedi: TGroupBox
            Left = 3
            Top = 71
            Width = 583
            Height = 69
            Caption = 'Dados da Venda'
            Color = clBtnFace
            ParentColor = False
            TabOrder = 2
            object Label22: TLabel
              Left = 9
              Top = 15
              Width = 23
              Height = 13
              Caption = 'Data'
              FocusControl = DBEdit14
            end
            object Label8: TLabel
              Left = 90
              Top = 16
              Width = 46
              Height = 13
              Caption = 'Vendedor'
              FocusControl = DBEdit9
            end
            object Label26: TLabel
              Left = 271
              Top = 15
              Width = 36
              Height = 13
              Caption = 'Ades'#227'o'
              FocusControl = DBEdit24
            end
            object Label28: TLabel
              Left = 350
              Top = 15
              Width = 59
              Height = 13
              Caption = 'Reu.Ades'#227'o'
              FocusControl = DBEdit26
            end
            object Label23: TLabel
              Left = 424
              Top = 15
              Width = 20
              Height = 13
              Caption = 'Filial'
              FocusControl = DBEdit15
            end
            object DBEdit14: TDBEdit
              Left = 9
              Top = 31
              Width = 75
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'DT_VENDA'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 0
            end
            object DBEdit9: TDBEdit
              Left = 90
              Top = 31
              Width = 168
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'REPRES'
              DataSource = dsCot
              TabOrder = 1
            end
            object DBEdit24: TDBEdit
              Left = 271
              Top = 31
              Width = 75
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'DT_ADES'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 2
            end
            object DBEdit26: TDBEdit
              Left = 350
              Top = 31
              Width = 59
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'REU_ADES'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 3
            end
            object DBEdit15: TDBEdit
              Left = 424
              Top = 32
              Width = 89
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'FIL_ATE'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 4
            end
          end
          object grCont: TGroupBox
            Left = 3
            Top = 3
            Width = 583
            Height = 62
            Caption = 'Dados do Contrato'
            Color = clBtnFace
            ParentColor = False
            TabOrder = 3
            object Label24: TLabel
              Left = 9
              Top = 14
              Width = 27
              Height = 13
              Caption = 'Plano'
              FocusControl = DBEdit22
            end
            object Label25: TLabel
              Left = 58
              Top = 14
              Width = 45
              Height = 13
              Caption = '% Mensal'
              FocusControl = DBEdit23
            end
            object Label17: TLabel
              Left = 125
              Top = 14
              Width = 39
              Height = 13
              Caption = 'Tx.Adm.'
              FocusControl = DBEdit17
            end
            object Label16: TLabel
              Left = 196
              Top = 14
              Width = 37
              Height = 13
              Caption = 'Tx.Res.'
              FocusControl = DBEdit16
            end
            object Label39: TLabel
              Left = 265
              Top = 14
              Width = 34
              Height = 13
              Caption = 'Seguro'
              FocusControl = DBEdit37
            end
            object Label18: TLabel
              Left = 305
              Top = 14
              Width = 37
              Height = 13
              Caption = 'Tx.Seg.'
              FocusControl = DBEdit18
            end
            object Label27: TLabel
              Left = 370
              Top = 14
              Width = 34
              Height = 13
              Caption = 'Sit.Cob'
              FocusControl = DBEdit25
            end
            object Label4: TLabel
              Left = 450
              Top = 14
              Width = 36
              Height = 13
              Caption = '% Pago'
              FocusControl = DBEdit4
            end
            object Label5: TLabel
              Left = 516
              Top = 14
              Width = 52
              Height = 13
              Caption = '% Devedor'
              FocusControl = DBEdit5
            end
            object DBEdit22: TDBEdit
              Left = 9
              Top = 30
              Width = 43
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'PLANO'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 0
            end
            object DBEdit23: TDBEdit
              Left = 58
              Top = 30
              Width = 60
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'P_MENSAL'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 1
            end
            object DBEdit17: TDBEdit
              Left = 125
              Top = 30
              Width = 60
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'P_ADMINS'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 2
            end
            object DBEdit16: TDBEdit
              Left = 196
              Top = 30
              Width = 60
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'P_RESERV'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 3
            end
            object DBEdit37: TDBEdit
              Left = 265
              Top = 30
              Width = 30
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TP_SEGUR'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 4
            end
            object DBEdit18: TDBEdit
              Left = 305
              Top = 30
              Width = 60
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'PERSEGVD'
              DataSource = dsSeg
              ReadOnly = True
              TabOrder = 5
            end
            object DBEdit25: TDBEdit
              Left = 370
              Top = 30
              Width = 74
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'SIT_COBR'
              DataSource = dsCot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 6
            end
            object DBEdit4: TDBEdit
              Left = 450
              Top = 30
              Width = 60
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'PerPago'
              DataSource = dsCot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 7
            end
            object DBEdit5: TDBEdit
              Left = 516
              Top = 30
              Width = 60
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'PerDev'
              DataSource = dsCot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 8
            end
          end
        end
        object tbCli: TTabSheet
          Caption = '&Cliente'
          OnExit = tbCliExit
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Label19: TLabel
            Left = 16
            Top = 5
            Width = 35
            Height = 13
            Caption = 'Pessoa'
            FocusControl = DBEdit19
          end
          object Label20: TLabel
            Left = 98
            Top = 5
            Width = 43
            Height = 13
            Caption = 'Cpf/CGC'
          end
          object Label40: TLabel
            Left = 386
            Top = 5
            Width = 37
            Height = 13
            Caption = 'Est.Civil'
            FocusControl = DBEdit38
          end
          object Label41: TLabel
            Left = 18
            Top = 48
            Width = 42
            Height = 13
            Caption = 'Dt.Nasc.'
            FocusControl = DBEdit39
          end
          object Label42: TLabel
            Left = 99
            Top = 48
            Width = 24
            Height = 13
            Caption = 'Sexo'
            FocusControl = DBEdit40
          end
          object Label43: TLabel
            Left = 219
            Top = 5
            Width = 55
            Height = 13
            Caption = 'Documento'
            FocusControl = DBEdit41
          end
          object Label44: TLabel
            Left = 219
            Top = 48
            Width = 43
            Height = 13
            Caption = 'Profiss'#227'o'
            FocusControl = DBEdit42
          end
          object DBEdit19: TDBEdit
            Left = 16
            Top = 21
            Width = 77
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'PESS_F_J'
            DataSource = dsCot
            ReadOnly = True
            TabOrder = 0
          end
          object DBEdit20: TDBEdit
            Left = 98
            Top = 21
            Width = 115
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'CGC_CPF'
            DataSource = dsCot
            ReadOnly = True
            TabOrder = 1
          end
          object DBEdit38: TDBEdit
            Left = 386
            Top = 21
            Width = 81
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'E_CIVIL'
            DataSource = dsCot
            ReadOnly = True
            TabOrder = 2
          end
          object DBEdit39: TDBEdit
            Left = 18
            Top = 64
            Width = 75
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'DT_NASC'
            DataSource = dsCot
            ReadOnly = True
            TabOrder = 3
          end
          object DBEdit40: TDBEdit
            Left = 99
            Top = 64
            Width = 114
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'SEXO'
            DataSource = dsCot
            ReadOnly = True
            TabOrder = 4
          end
          object DBEdit41: TDBEdit
            Left = 219
            Top = 21
            Width = 161
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'DOCUMENT'
            DataSource = dsCot
            ReadOnly = True
            TabOrder = 5
          end
          object DBEdit42: TDBEdit
            Left = 219
            Top = 64
            Width = 161
            Height = 21
            TabStop = False
            Color = clBtnFace
            DataField = 'PROFISS'
            DataSource = dsCot
            ReadOnly = True
            TabOrder = 6
          end
          object panEnd: TPanel
            Left = 0
            Top = 91
            Width = 586
            Height = 243
            Color = clSkyBlue
            TabOrder = 7
            TabStop = True
            object Label38: TLabel
              Left = 19
              Top = 7
              Width = 42
              Height = 13
              Caption = 'Telefone'
              FocusControl = EdtFone
            end
            object Label33: TLabel
              Left = 19
              Top = 53
              Width = 46
              Height = 13
              Caption = 'Endere'#231'o'
              FocusControl = EdtEnd
            end
            object Label34: TLabel
              Left = 19
              Top = 99
              Width = 27
              Height = 13
              Caption = 'Bairro'
              FocusControl = EdtBai
            end
            object Label35: TLabel
              Left = 19
              Top = 145
              Width = 33
              Height = 13
              Caption = 'Cidade'
              FocusControl = EdtCid
            end
            object Label36: TLabel
              Left = 18
              Top = 191
              Width = 33
              Height = 13
              Caption = 'Estado'
              FocusControl = EdtUf
            end
            object Label37: TLabel
              Left = 66
              Top = 189
              Width = 19
              Height = 13
              Caption = 'Cep'
              FocusControl = EdtCep
            end
            object EdtFone: TDBEdit
              Left = 18
              Top = 26
              Width = 155
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TELEFONE'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 0
            end
            object EdtEnd: TDBEdit
              Left = 18
              Top = 72
              Width = 329
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'ENDERECO'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 1
            end
            object EdtBai: TDBEdit
              Left = 18
              Top = 118
              Width = 329
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'BAIRRO'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 2
            end
            object EdtCid: TDBEdit
              Left = 19
              Top = 164
              Width = 329
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'CIDADE'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 3
            end
            object EdtUf: TDBEdit
              Left = 18
              Top = 208
              Width = 30
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'ESTADO'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 4
            end
            object EdtCep: TDBEdit
              Left = 66
              Top = 208
              Width = 73
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'CEP'
              DataSource = dsCot
              ReadOnly = True
              TabOrder = 5
            end
            object Panel8: TPanel
              Left = 472
              Top = 1
              Width = 113
              Height = 241
              Align = alRight
              Color = clMoneyGreen
              TabOrder = 6
              TabStop = True
              object spGrvEnd: TSpeedButton
                Left = 12
                Top = 98
                Width = 89
                Height = 49
                Action = GrvEnd
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
              object spCanEnd: TSpeedButton
                Left = 12
                Top = 166
                Width = 89
                Height = 49
                Action = CanEnd
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
              object spAltEnd: TSpeedButton
                Left = 12
                Top = 26
                Width = 89
                Height = 49
                Action = AltEnd
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
          end
        end
        object tbPen: TTabSheet
          Caption = '&Pendencias'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Panel7: TPanel
            Left = 0
            Top = 282
            Width = 586
            Height = 49
            Align = alBottom
            Color = clSkyBlue
            TabOrder = 0
            object Label10: TLabel
              Left = 29
              Top = 7
              Width = 44
              Height = 13
              Caption = '% Normal'
            end
            object Label11: TLabel
              Left = 101
              Top = 7
              Width = 42
              Height = 13
              Caption = '% Rateio'
            end
            object Label12: TLabel
              Left = 227
              Top = 7
              Width = 24
              Height = 13
              Caption = 'Valor'
            end
            object Label13: TLabel
              Left = 332
              Top = 7
              Width = 26
              Height = 13
              Caption = 'Multa'
            end
            object Label14: TLabel
              Left = 442
              Top = 7
              Width = 25
              Height = 13
              Caption = 'Juros'
            end
            object Label15: TLabel
              Left = 554
              Top = 7
              Width = 24
              Height = 13
              Caption = 'Total'
            end
            object DBEdit11: TDBEdit
              Left = 16
              Top = 21
              Width = 57
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TtPcNor'
              DataSource = dsCob
              ReadOnly = True
              TabOrder = 0
            end
            object DBEdit12: TDBEdit
              Left = 86
              Top = 21
              Width = 57
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TtPcRat'
              DataSource = dsCob
              ReadOnly = True
              TabOrder = 1
            end
            object DBEdit13: TDBEdit
              Left = 166
              Top = 21
              Width = 85
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TtPend'
              DataSource = dsCob
              ReadOnly = True
              TabOrder = 2
            end
            object DBEdit21: TDBEdit
              Left = 273
              Top = 21
              Width = 85
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TtMul'
              DataSource = dsCob
              ReadOnly = True
              TabOrder = 3
            end
            object DBEdit31: TDBEdit
              Left = 382
              Top = 21
              Width = 85
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TtJur'
              DataSource = dsCob
              ReadOnly = True
              TabOrder = 4
            end
            object DBEdit32: TDBEdit
              Left = 493
              Top = 21
              Width = 85
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TtTot'
              DataSource = dsCob
              ReadOnly = True
              TabOrder = 5
            end
          end
          object grCob: TDBGrid
            Left = 0
            Top = 0
            Width = 586
            Height = 257
            Align = alClient
            DataSource = dsCob
            Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            ReadOnly = True
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
          end
          object Panel5: TPanel
            Left = 0
            Top = 257
            Width = 586
            Height = 25
            Align = alBottom
            BevelInner = bvLowered
            TabOrder = 2
            object btIncPend: TSpeedButton
              Left = 6
              Top = 3
              Width = 110
              Height = 20
              Action = IncPend
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
            object btExcPend: TSpeedButton
              Left = 122
              Top = 3
              Width = 110
              Height = 20
              Action = ExcPend
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
            object SpeedButton2: TSpeedButton
              Left = 238
              Top = 3
              Width = 110
              Height = 20
              Action = AltPend
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
            object nvPen: TDBNavigator
              Left = 358
              Top = 3
              Width = 224
              Height = 20
              DataSource = dsCob
              VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
              Flat = True
              Hints.Strings = (
                'Primeiro'
                'Anterior'
                'Pr'#243'ximo'
                #218'ltimo'
                'Insert record'
                'Delete record'
                'Edit record'
                'Post edit'
                'Cancel edit'
                'Refresh data')
              TabOrder = 0
            end
          end
        end
        object tbPag: TTabSheet
          Caption = 'Pagamentos'
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Panel6: TPanel
            Left = 0
            Top = 282
            Width = 586
            Height = 49
            Align = alBottom
            Color = clSkyBlue
            TabOrder = 0
            object Label21: TLabel
              Left = 18
              Top = 7
              Width = 44
              Height = 13
              Caption = '% Normal'
            end
            object Label45: TLabel
              Left = 90
              Top = 7
              Width = 42
              Height = 13
              Caption = '% Rateio'
            end
            object Label46: TLabel
              Left = 199
              Top = 7
              Width = 24
              Height = 13
              Caption = 'Valor'
            end
            object Label47: TLabel
              Left = 460
              Top = 7
              Width = 26
              Height = 13
              Caption = 'Multa'
            end
            object Label48: TLabel
              Left = 548
              Top = 7
              Width = 32
              Height = 13
              Caption = 'Vlr. R$'
            end
            object Label49: TLabel
              Left = 264
              Top = 7
              Width = 40
              Height = 13
              Caption = 'Reserva'
            end
            object Label50: TLabel
              Left = 355
              Top = 7
              Width = 42
              Height = 13
              Caption = 'Tx. Adm.'
            end
            object DBEdit33: TDBEdit
              Left = 401
              Top = 21
              Width = 85
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TTMul'
              DataSource = dsPag
              ReadOnly = True
              TabOrder = 0
            end
            object DBEdit34: TDBEdit
              Left = 138
              Top = 21
              Width = 85
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TtPag'
              DataSource = dsPag
              ReadOnly = True
              TabOrder = 1
            end
            object DBEdit35: TDBEdit
              Left = 75
              Top = 21
              Width = 57
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TTRat'
              DataSource = dsPag
              ReadOnly = True
              TabOrder = 2
            end
            object DBEdit36: TDBEdit
              Left = 5
              Top = 21
              Width = 57
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TTPer'
              DataSource = dsPag
              ReadOnly = True
              TabOrder = 3
            end
            object DBEdit43: TDBEdit
              Left = 495
              Top = 21
              Width = 85
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TTReal'
              DataSource = dsPag
              ReadOnly = True
              TabOrder = 4
            end
            object DBEdit44: TDBEdit
              Left = 230
              Top = 21
              Width = 74
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TtRes'
              DataSource = dsPag
              ReadOnly = True
              TabOrder = 5
            end
            object DBEdit45: TDBEdit
              Left = 310
              Top = 21
              Width = 85
              Height = 21
              TabStop = False
              Color = clBtnFace
              DataField = 'TTAdm'
              DataSource = dsPag
              ReadOnly = True
              TabOrder = 6
            end
          end
          object DBGrid2: TDBGrid
            Left = 0
            Top = 0
            Width = 586
            Height = 257
            Align = alClient
            DataSource = dsPag
            Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
          end
          object Panel9: TPanel
            Left = 0
            Top = 257
            Width = 586
            Height = 25
            Align = alBottom
            BevelInner = bvLowered
            TabOrder = 2
            object SpeedButton3: TSpeedButton
              Left = 5
              Top = 3
              Width = 110
              Height = 20
              Action = IncPag
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
            object SpeedButton5: TSpeedButton
              Left = 121
              Top = 3
              Width = 110
              Height = 20
              Action = excPag
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
            object DBNavigator1: TDBNavigator
              Left = 362
              Top = 3
              Width = 224
              Height = 20
              DataSource = dsPag
              VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
              Flat = True
              Hints.Strings = (
                'Primeiro'
                'Anterior'
                'Pr'#243'ximo'
                #218'ltimo'
                'Insert record'
                'Delete record'
                'Edit record'
                'Post edit'
                'Cancel edit'
                'Refresh data')
              TabOrder = 0
            end
          end
        end
      end
    end
  end
  object AL: TActionList
    Images = DM.IL
    Left = 672
    Top = 192
    object Pesquisa: TAction
      Category = 'Manutencao'
      Caption = 'Pe&sq Cons (F9)'
      Hint = 'Clique (ou F9) para pesquisar Nome, Cpf ou Cnpj'
      ImageIndex = 10
      OnExecute = PesquisaExecute
    end
    object Reu: TAction
      Category = 'Manutencao'
      Caption = '&Reuni'#245'es'
      Hint = 'Clique (ou Alt+F2) para ver reuni'#245'es do grupo'
      ImageIndex = 11
      OnExecute = ReuExecute
    end
    object Pre: TAction
      Category = 'Manutencao'
      Caption = 'Pre'#231'&os'
      Hint = 'Clique (ou Alt+F3) para consultar os pre'#231'os'
      ImageIndex = 11
      OnExecute = PreExecute
    end
    object Sair: TAction
      Category = 'Manutencao'
      Caption = 'Sair (Esc)'
      Hint = 'Clique para finalizar'
      ImageIndex = 0
      OnExecute = SairExecute
    end
    object Jur: TAction
      Category = 'Manutencao'
      Caption = '&Jur'#237'dico'
      Hint = 'Clique (Alt+F4) para consultar fases jur'#237'dicas'
      OnExecute = JurExecute
    end
    object impPos: TAction
      Category = 'Manutencao'
      Caption = 'Pos&i'#231#227'o (F12)'
      Hint = 'Clique (ou F12) para imprimir a posi'#231#227'o do cliente '
      ImageIndex = 16
      OnExecute = impPosExecute
    end
    object Com: TAction
      Category = 'Manutencao'
      Caption = 'Agendar Comp.'
      Hint = 'Clique (Ctrl+A) para agendar um compromisso '
      ImageIndex = 22
      ShortCut = 16449
      OnExecute = ComExecute
    end
    object Ali: TAction
      Category = 'Manutencao'
      Caption = 'Aliena'#231#245'es'
      Hint = 'Clique ou pressione Alt+F7 para consultar os bens alienados'
      OnExecute = AliExecute
    end
    object LisGru: TAction
      Category = 'Manutencao'
      Hint = 'Lista Grupos'
      ImageIndex = 10
      ShortCut = 113
      OnExecute = LisGruExecute
    end
    object LisCota: TAction
      Category = 'Manutencao'
      Hint = 'Listar Cotas'
      ImageIndex = 10
      ShortCut = 114
      OnExecute = LisCotaExecute
    end
    object AltEnd: TAction
      Category = 'Manutencao'
      Caption = 'Alterar'
      Hint = 'Clique para alterar endere'#231'o'
      ImageIndex = 1
      OnExecute = AltEndExecute
    end
    object GrvEnd: TAction
      Category = 'Manutencao'
      Caption = 'Gravar'
      Hint = 'Gravar Altera'#231#245'es'
      ImageIndex = 3
      OnExecute = GrvEndExecute
    end
    object CanEnd: TAction
      Category = 'Manutencao'
      Caption = 'Cancelar'
      Hint = 'Cancelar altera'#231#245'es'
      ImageIndex = 5
      OnExecute = CanEndExecute
    end
    object Cre: TAction
      Category = 'Manutencao'
      Caption = 'Cr'#233'ditos'
      Hint = 'Clique para consultar os cr'#233'ditos da cota'
      OnExecute = CreExecute
    end
    object DevCon: TAction
      Category = 'Manutencao'
      Caption = 'Dev.Cancelados'
      Hint = 'Demonstrativo de devolu'#231#227'o de cancelamento'
      OnExecute = DevConExecute
    end
    object IncPend: TAction
      Category = 'Pendencia'
      Caption = 'Incluir Pendencia'
      Hint = 'Clique para incluir custas/despesas'
      ImageIndex = 2
      OnExecute = IncPendExecute
    end
    object ExcPend: TAction
      Category = 'Pendencia'
      Caption = 'Excluir Pendencia'
      Hint = 'Clique para excluir custas/despesas'
      ImageIndex = 4
      OnExecute = ExcPendExecute
    end
    object AltPend: TAction
      Category = 'Pendencia'
      Caption = 'Alterar Pendencia'
      Hint = 'Clique para alterar uma pendencia'
      ImageIndex = 1
      OnExecute = AltPendExecute
    end
    object IncPag: TAction
      Category = 'Pendencia'
      Caption = 'Incluir Pagto'
      Hint = 'Clique para incluir pagamento'
      ImageIndex = 2
      OnExecute = IncPagExecute
    end
    object sitCob: TAction
      Category = 'Manutencao'
      Caption = 'St. Cobran'#231'a'
      Hint = 'Alterar Situa'#231#227'o de Cobran'#231'a'
      OnExecute = sitCobExecute
    end
    object excPag: TAction
      Category = 'Pendencia'
      Caption = 'Excluir Pagto'
      Hint = 'Excluir parcela'
      ImageIndex = 4
      OnExecute = excPagExecute
    end
  end
  object dsCot: TDataSource
    AutoEdit = False
    DataSet = DM.cdsCot
    OnStateChange = dsCotStateChange
    Left = 608
    Top = 224
  end
  object dsBem: TDataSource
    AutoEdit = False
    DataSet = DM.sdsBem
    Left = 608
    Top = 192
  end
  object dsPag: TDataSource
    AutoEdit = False
    DataSet = DM.cdsMov
    Left = 640
    Top = 224
  end
  object dsCob: TDataSource
    DataSet = DM.cdsCb1
    Left = 640
    Top = 192
  end
  object dsPre: TDataSource
    DataSet = DM.sdsPre
    Left = 672
    Top = 224
  end
  object dsSeg: TDataSource
    DataSet = DM.cdsSeg
    Left = 608
    Top = 256
  end
end
