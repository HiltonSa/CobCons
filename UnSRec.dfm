object frmSRec: TfrmSRec
  Left = 340
  Top = 170
  BorderStyle = bsToolWindow
  Caption = 'Movimento no Per'#237'odo'
  ClientHeight = 135
  ClientWidth = 271
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
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 184
    Height = 135
    Align = alClient
    BevelOuter = bvLowered
    Color = clSkyBlue
    TabOrder = 0
    object Label1: TLabel
      Left = 48
      Top = 24
      Width = 53
      Height = 13
      Caption = 'Data Inicial'
    end
    object Label2: TLabel
      Left = 48
      Top = 64
      Width = 48
      Height = 13
      Caption = 'Data Final'
    end
    object dtI: TDateTimePicker
      Left = 48
      Top = 40
      Width = 97
      Height = 21
      Date = 38706.661952349540000000
      Time = 38706.661952349540000000
      TabOrder = 0
      OnExit = dtIExit
    end
    object dtF: TDateTimePicker
      Left = 48
      Top = 80
      Width = 97
      Height = 21
      Date = 38706.661952349540000000
      Time = 38706.661952349540000000
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 184
    Top = 0
    Width = 87
    Height = 135
    Align = alRight
    BevelInner = bvLowered
    Color = clSilver
    TabOrder = 1
    object btnSair: TSpeedButton
      Left = 4
      Top = 109
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
    object btnVer: TSpeedButton
      Left = 4
      Top = 17
      Width = 80
      Height = 49
      Action = VerImp
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
      Layout = blGlyphTop
    end
  end
  object AL: TActionList
    Images = DM.IL
    Left = 152
    object VerImp: TAction
      Category = 'Manutencao'
      Caption = '&Ver (F2)'
      Hint = 'Clique (ou F2) para Ver/Imprimir'
      ImageIndex = 15
      OnExecute = VerImpExecute
    end
    object Sair: TAction
      Category = 'Manutencao'
      Caption = '&Sair'
      Hint = 'Clique para finalizar'
      ImageIndex = 0
      OnExecute = SairExecute
    end
  end
end
