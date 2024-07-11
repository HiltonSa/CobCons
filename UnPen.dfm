object frmPen: TfrmPen
  Left = 356
  Top = 142
  ActiveControl = cboTmv
  BorderStyle = bsToolWindow
  Caption = 'Pendencias'
  ClientHeight = 309
  ClientWidth = 418
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 418
    Height = 268
    Align = alClient
    BevelInner = bvLowered
    Color = clSkyBlue
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 10
      Width = 29
      Height = 13
      Caption = 'Grupo'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 135
      Top = 10
      Width = 28
      Height = 13
      Caption = 'Nome'
    end
    object Label3: TLabel
      Left = 56
      Top = 10
      Width = 19
      Height = 13
      Caption = 'Seq'
      FocusControl = DBEdit1
    end
    object Label4: TLabel
      Left = 88
      Top = 10
      Width = 22
      Height = 13
      Caption = 'Cota'
      FocusControl = DBEdit1
    end
    object Label5: TLabel
      Left = 8
      Top = 96
      Width = 91
      Height = 13
      Caption = 'Tipo de Movimento'
    end
    object Label6: TLabel
      Left = 176
      Top = 96
      Width = 56
      Height = 13
      Caption = 'Vencimento'
    end
    object Label7: TLabel
      Left = 288
      Top = 96
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object Label8: TLabel
      Left = 8
      Top = 53
      Width = 26
      Height = 13
      Caption = 'Aviso'
      FocusControl = DBEdit1
    end
    object Label15: TLabel
      Left = 176
      Top = 53
      Width = 39
      Height = 13
      Caption = 'Vlr. Bem'
      FocusControl = DBEdit1
    end
    object Label9: TLabel
      Left = 288
      Top = 53
      Width = 29
      Height = 13
      Caption = '%Adm'
      FocusControl = DBEdit7
    end
    object Label10: TLabel
      Left = 351
      Top = 53
      Width = 27
      Height = 13
      Caption = '%Res'
      FocusControl = DBEdit8
    end
    object Label11: TLabel
      Left = 8
      Top = 152
      Width = 145
      Height = 21
      AutoSize = False
      Caption = 'Aquisi'#231#227'o'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object Label12: TLabel
      Left = 8
      Top = 180
      Width = 145
      Height = 21
      AutoSize = False
      Caption = 'Reserva'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object Label13: TLabel
      Left = 8
      Top = 207
      Width = 145
      Height = 21
      AutoSize = False
      Caption = 'Tx. Administra'#231#227'o'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object Label14: TLabel
      Left = 8
      Top = 234
      Width = 145
      Height = 21
      AutoSize = False
      Caption = 'Outros'
      Color = clBtnFace
      ParentColor = False
      Layout = tlCenter
    end
    object DBEdit1: TDBEdit
      Left = 88
      Top = 26
      Width = 41
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'COTA'
      DataSource = dsCot
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 135
      Top = 26
      Width = 274
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'NOME'
      DataSource = dsCot
      ReadOnly = True
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 8
      Top = 26
      Width = 41
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'GRUPO'
      DataSource = dsCot
      ReadOnly = True
      TabOrder = 2
    end
    object DBEdit4: TDBEdit
      Left = 56
      Top = 26
      Width = 25
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'SEQ'
      DataSource = dsCot
      ReadOnly = True
      TabOrder = 3
    end
    object cboTmv: TComboBox
      Left = 8
      Top = 113
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 4
      Text = '01 PAGTO PARCELA'
      Items.Strings = (
        '01 PAGTO PARCELA'
        'SR PAGTO SLD REMANESCENTE'
        '04 PAGTO RATEIO'
        '14 PAGTO CUSTAS'
        '15 PAGTO DESPESAS')
    end
    object dtVenc: TJvDBDatePickerEdit
      Left = 176
      Top = 113
      Width = 100
      Height = 21
      AllowNoDate = True
      DataField = 'D_VENCTO'
      DataSource = dsPen
      TabOrder = 5
    end
    object DBEdit5: TDBEdit
      Left = 8
      Top = 69
      Width = 65
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'AVISO'
      DataSource = dsPen
      ReadOnly = True
      TabOrder = 6
    end
    object DBEdit6: TDBEdit
      Left = 176
      Top = 69
      Width = 100
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'PRE_TABE'
      DataSource = dsPre
      ReadOnly = True
      TabOrder = 7
    end
    object DBEdit7: TDBEdit
      Left = 288
      Top = 69
      Width = 57
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'P_ADMINS'
      DataSource = dsCot
      ReadOnly = True
      TabOrder = 8
    end
    object DBEdit8: TDBEdit
      Left = 351
      Top = 69
      Width = 58
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'P_RESERV'
      DataSource = dsCot
      ReadOnly = True
      TabOrder = 9
    end
    object DBEdit9: TDBEdit
      Left = 288
      Top = 149
      Width = 121
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'F_AQUISI'
      DataSource = dsPen
      ReadOnly = True
      TabOrder = 10
    end
    object DBEdit10: TDBEdit
      Left = 219
      Top = 149
      Width = 57
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'P_NORMAL'
      DataSource = dsPen
      ReadOnly = True
      TabOrder = 11
    end
    object DBEdit11: TDBEdit
      Left = 288
      Top = 177
      Width = 121
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'F_RESERV'
      DataSource = dsPen
      ReadOnly = True
      TabOrder = 12
    end
    object DBEdit12: TDBEdit
      Left = 288
      Top = 204
      Width = 121
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'ADMINIST'
      DataSource = dsPen
      ReadOnly = True
      TabOrder = 13
    end
    object DBEdit13: TDBEdit
      Left = 288
      Top = 231
      Width = 121
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'OUTROS'
      DataSource = dsPen
      ReadOnly = True
      TabOrder = 14
    end
    object edtValor: TJvCalcEdit
      Left = 288
      Top = 113
      Width = 121
      Height = 21
      DisplayFormat = ',#0.00'
      TabOrder = 15
      DecimalPlacesAlwaysShown = False
      OnExit = edtValorExit
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 268
    Width = 418
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    Color = clMoneyGreen
    TabOrder = 1
    object btIncPend: TSpeedButton
      Left = 8
      Top = 11
      Width = 127
      Height = 20
      Action = Gravar
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
    object btExcPend: TSpeedButton
      Left = 282
      Top = 11
      Width = 127
      Height = 20
      Action = Cancelar
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
  end
  object dsPen: TDataSource
    AutoEdit = False
    DataSet = DM.cdsPnd
    Left = 312
  end
  object dsCot: TDataSource
    AutoEdit = False
    DataSet = DM.cdsCot
    Left = 344
  end
  object PM: TPopupMenu
    Left = 280
    object BaixarParcela1: TMenuItem
      Caption = '&Baixar Parcela'
      Hint = 'Clique para baixar a parcela da pendencia'
    end
    object AnularBaixa1: TMenuItem
      Caption = '&Anular Baixa'
      Hint = 'Clique para anular a baixa da parcela'
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object AlterarParcela1: TMenuItem
      Caption = 'Alterar Parcela'
      Hint = 'Alterar os dados da parcela'
    end
    object ExcluirParcela1: TMenuItem
      Caption = '&Excluir Parcela'
      Hint = 'Clique para excluir a parcela'
    end
  end
  object AL: TActionList
    Left = 248
    object Gravar: TAction
      Caption = 'Gravar'
      Hint = 'Clique para salvar as informa'#231#245'es'
      OnExecute = GravarExecute
    end
    object Cancelar: TAction
      Caption = 'Cancelar'
      Hint = 'Clique para cancelar as altera'#231#245'es'
      OnExecute = CancelarExecute
    end
  end
  object dsPre: TDataSource
    DataSet = DM.sdsPre
    Left = 208
  end
end
