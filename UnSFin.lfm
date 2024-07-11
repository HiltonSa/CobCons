object frmSFin: TfrmSFin
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Movimento Financeiro'
  ClientHeight = 138
  ClientWidth = 286
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 199
    Height = 138
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
    Left = 199
    Top = 0
    Width = 87
    Height = 138
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
    end
    object btnVer: TSpeedButton
      Left = 4
      Top = 17
      Width = 80
      Height = 49
      Action = VerImp
      Flat = True
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
