object frmAco: TfrmAco
  Left = 411
  Top = 160
  BorderStyle = bsToolWindow
  Caption = 'Acordos'
  ClientHeight = 252
  ClientWidth = 452
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object stBar: TStatusBar
    Left = 0
    Top = 233
    Width = 452
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
    Left = 365
    Top = 0
    Width = 87
    Height = 233
    Align = alRight
    BevelInner = bvLowered
    Color = clSilver
    TabOrder = 1
    object btnGravar: TSpeedButton
      Left = 3
      Top = 86
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
      Top = 125
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
      Top = 204
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
      Top = 47
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
    object btnIncluir: TSpeedButton
      Left = 3
      Top = 8
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
    object btnPar: TSpeedButton
      Left = 4
      Top = 164
      Width = 80
      Height = 20
      Action = Par
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
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 365
    Height = 233
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 2
    object Label1: TLabel
      Left = 10
      Top = 60
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 154
      Top = 60
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object Label3: TLabel
      Left = 234
      Top = 60
      Width = 41
      Height = 13
      Caption = 'Parcelas'
      FocusControl = txtPcl
    end
    object Label4: TLabel
      Left = 282
      Top = 60
      Width = 63
      Height = 13
      Caption = 'Prim. Vencto.'
      FocusControl = txtVenc
    end
    object Label5: TLabel
      Left = 10
      Top = 100
      Width = 41
      Height = 13
      Caption = 'Parcelas'
    end
    object Label6: TLabel
      Left = 66
      Top = 60
      Width = 23
      Height = 13
      Caption = 'Data'
      FocusControl = txtVenc
    end
    object DBEdit1: TDBEdit
      Left = 10
      Top = 76
      Width = 49
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'CD_ACORDO'
      DataSource = DS
      ReadOnly = True
      TabOrder = 4
    end
    object txtPcl: TDBEdit
      Left = 234
      Top = 76
      Width = 39
      Height = 21
      DataField = 'PARCELAS'
      DataSource = DS
      TabOrder = 2
    end
    object txtVenc: TDBEdit
      Left = 282
      Top = 76
      Width = 73
      Height = 21
      DataField = 'P_VENCTO'
      DataSource = DS
      TabOrder = 3
    end
    object DBGrid1: TDBGrid
      Left = 2
      Top = 115
      Width = 361
      Height = 119
      TabStop = False
      DataSource = dsPcl
      ReadOnly = True
      TabOrder = 5
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'PARCELA'
          Width = 27
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VENCTO'
          Width = 68
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR'
          Width = 62
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PC_BEM'
          Width = 43
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VL_ADI'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Total'
          Visible = True
        end>
    end
    object Panel3: TPanel
      Left = 2
      Top = 2
      Width = 361
      Height = 55
      Align = alTop
      BevelInner = bvLowered
      Color = clMoneyGreen
      TabOrder = 6
      object Label10: TLabel
        Left = 10
        Top = 8
        Width = 41
        Height = 13
        Caption = 'Parcelas'
        FocusControl = DBEdit11
      end
      object Label12: TLabel
        Left = 105
        Top = 8
        Width = 47
        Height = 13
        Caption = 'Mul/Juros'
        FocusControl = DBEdit13
      end
      object Label21: TLabel
        Left = 196
        Top = 8
        Width = 51
        Height = 13
        Caption = 'Honor'#225'rios'
        FocusControl = DBEdit21
      end
      object Label14: TLabel
        Left = 288
        Top = 8
        Width = 24
        Height = 13
        Caption = 'Total'
      end
      object DBEdit11: TDBEdit
        Left = 10
        Top = 24
        Width = 65
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'VAL'
        DataSource = dsTot
        ReadOnly = True
        TabOrder = 0
      end
      object DBEdit13: TDBEdit
        Left = 104
        Top = 24
        Width = 65
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'MUL'
        DataSource = dsTot
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object DBEdit21: TDBEdit
        Left = 196
        Top = 24
        Width = 65
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'HONOR'
        DataSource = dsCot
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object txtTot: TMaskEdit
        Left = 289
        Top = 24
        Width = 65
        Height = 21
        TabStop = False
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
    end
    object JvDBCalcEdit1: TJvDBCalcEdit
      Left = 152
      Top = 76
      Width = 73
      Height = 21
      ButtonHint = 'Clique para ativar a calculadora'
      DisplayFormat = '0.00'
      TabOrder = 1
      DecimalPlacesAlwaysShown = True
      DataField = 'VALOR'
      DataSource = DS
    end
    object dbEdit2: TJvDBDatePickerEdit
      Left = 64
      Top = 76
      Width = 81
      Height = 21
      AllowNoDate = True
      ButtonHint = 'Clique para exibir o calend'#225'rio'
      DataField = 'DT_ACO'
      DataSource = DS
      DateFormat = 'dd/MM/yyyy'
      DateSeparator = '/'
      StoreDateFormat = True
      TabOrder = 0
    end
  end
  object AL: TActionList
    Images = DM.IL
    Left = 8
    Top = 8
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
    object Par: TAction
      Category = 'Manutencao'
      Caption = '&Parcela (F7)'
      Hint = 'Clique ou (F7) para alterar parcelas'
      OnExecute = ParExecute
    end
  end
  object DS: TDataSource
    AutoEdit = False
    OnDataChange = DSDataChange
    Left = 104
    Top = 8
  end
  object dsPcl: TDataSource
    AutoEdit = False
    Left = 72
    Top = 8
  end
  object dsTot: TDataSource
    AutoEdit = False
    Left = 136
    Top = 8
  end
  object dsCot: TDataSource
    AutoEdit = False
    DataSet = DM.cdsCot
    Left = 40
    Top = 8
  end
end
