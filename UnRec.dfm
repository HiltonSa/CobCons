object frmRec: TfrmRec
  Left = 394
  Top = 234
  BorderStyle = bsToolWindow
  Caption = 'Recebimento'
  ClientHeight = 133
  ClientWidth = 358
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
    Top = 114
    Width = 358
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
    Left = 271
    Top = 0
    Width = 87
    Height = 114
    Align = alRight
    BevelInner = bvLowered
    Color = clSilver
    TabOrder = 1
    object btnGravar: TSpeedButton
      Left = 4
      Top = 25
      Width = 80
      Height = 40
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
      Layout = blGlyphTop
    end
    object btnSair: TSpeedButton
      Left = 4
      Top = 68
      Width = 80
      Height = 40
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
      Layout = blGlyphTop
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 271
    Height = 114
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 2
    object Label4: TLabel
      Left = 13
      Top = 54
      Width = 42
      Height = 13
      Caption = 'Dt.Pagto'
      FocusControl = DBEdit4
    end
    object Label5: TLabel
      Left = 101
      Top = 54
      Width = 36
      Height = 13
      Caption = 'Mul/Jur'
      FocusControl = DBEdit5
    end
    object Label6: TLabel
      Left = 181
      Top = 54
      Width = 37
      Height = 13
      Caption = 'Vl.Pago'
      FocusControl = DBEdit6
    end
    object DBEdit4: TDBEdit
      Left = 13
      Top = 70
      Width = 81
      Height = 21
      DataField = 'PAGTO'
      DataSource = DS
      TabOrder = 0
    end
    object DBEdit5: TDBEdit
      Left = 101
      Top = 70
      Width = 73
      Height = 21
      DataField = 'MULTA'
      DataSource = DS
      TabOrder = 1
    end
    object DBEdit6: TDBEdit
      Left = 181
      Top = 70
      Width = 81
      Height = 21
      DataField = 'VALPG'
      DataSource = DS
      TabOrder = 2
    end
    object Panel3: TPanel
      Left = 2
      Top = 2
      Width = 267
      Height = 47
      Align = alTop
      BevelInner = bvLowered
      Color = clMoneyGreen
      TabOrder = 3
      object Label1: TLabel
        Left = 13
        Top = 6
        Width = 15
        Height = 13
        Caption = 'Pcl'
        FocusControl = DBEdit1
      end
      object Label2: TLabel
        Left = 77
        Top = 6
        Width = 51
        Height = 13
        Caption = 'Dt. Vencto'
        FocusControl = DBEdit2
      end
      object Label3: TLabel
        Left = 181
        Top = 6
        Width = 63
        Height = 13
        Caption = 'Valor Parcela'
        FocusControl = DBEdit3
      end
      object DBEdit3: TDBEdit
        Left = 181
        Top = 18
        Width = 73
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'Total'
        DataSource = DS
        ReadOnly = True
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 77
        Top = 18
        Width = 81
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'VENCTO'
        DataSource = DS
        ReadOnly = True
        TabOrder = 1
      end
      object DBEdit1: TDBEdit
        Left = 13
        Top = 18
        Width = 33
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'PARCELA'
        DataSource = DS
        ReadOnly = True
        TabOrder = 2
      end
    end
  end
  object DS: TDataSource
    AutoEdit = False
    OnDataChange = DSDataChange
    Left = 216
    Top = 1
  end
  object AL: TActionList
    Images = DM.IL
    Left = 184
    object Grava: TAction
      Category = 'Manutencao'
      Caption = '&Grava (F5)'
      Hint = 'Clique (ou F5) para gravar os dados'
      ImageIndex = 3
      OnExecute = GravaExecute
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
