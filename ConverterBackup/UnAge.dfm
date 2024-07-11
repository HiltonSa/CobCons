object frmAge: TfrmAge
  Left = 294
  Top = 133
  BorderStyle = bsToolWindow
  Caption = 'Compromissos no Dia'
  ClientHeight = 364
  ClientWidth = 467
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
  object grCon: TDBGrid
    Left = 0
    Top = 40
    Width = 380
    Height = 193
    DataSource = DS
    Options = [dgTitles, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = grConDrawColumnCell
    OnTitleClick = grConTitleClick
    Columns = <
      item
        Expanded = False
        Width = 10
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DT_AGE'
        Width = 60
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
        Width = 25
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COTA'
        Width = 25
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS'
        Width = 50
        Visible = True
      end>
  end
  object stBar: TStatusBar
    Left = 0
    Top = 345
    Width = 467
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
    Left = 380
    Top = 0
    Width = 87
    Height = 345
    Align = alRight
    BevelInner = bvLowered
    Color = clSilver
    TabOrder = 2
    object btnSair: TSpeedButton
      Left = 4
      Top = 290
      Width = 80
      Height = 45
      Action = Sair
      Flat = True
      Layout = blGlyphTop
    end
    object btnExcluir: TSpeedButton
      Left = 4
      Top = 120
      Width = 80
      Height = 45
      Action = Exclui
      Flat = True
      Layout = blGlyphTop
    end
    object btnAlterar: TSpeedButton
      Left = 4
      Top = 63
      Width = 80
      Height = 45
      Action = Contatar
      Flat = True
      Layout = blGlyphTop
    end
    object btnIncluir: TSpeedButton
      Left = 4
      Top = 6
      Width = 80
      Height = 45
      Action = Pesquisa
      Flat = True
      Layout = blGlyphTop
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 380
    Height = 41
    BevelInner = bvLowered
    Color = clMoneyGreen
    TabOrder = 3
    object Label2: TLabel
      Left = 114
      Top = 17
      Width = 17
      Height = 13
      Caption = 'De:'
    end
    object Label3: TLabel
      Left = 242
      Top = 17
      Width = 16
      Height = 13
      Caption = 'At'#233
    end
    object dt1: TDateTimePicker
      Left = 136
      Top = 13
      Width = 89
      Height = 21
      Date = 38726.454289039350000000
      Time = 38726.454289039350000000
      TabOrder = 0
    end
    object dt2: TDateTimePicker
      Left = 264
      Top = 13
      Width = 89
      Height = 21
      Date = 38726.454289039350000000
      Time = 38726.454289039350000000
      TabOrder = 1
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 232
    Width = 380
    Height = 113
    BevelInner = bvLowered
    Color = clSkyBlue
    TabOrder = 4
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 63
      Height = 13
      Caption = 'Observa'#231#245'es'
    end
    object DBMemo1: TDBMemo
      Left = 80
      Top = 16
      Width = 281
      Height = 89
      DataField = 'OBS'
      DataSource = DS
      TabOrder = 0
    end
  end
  object DS: TDataSource
    AutoEdit = False
    DataSet = DM.cdsAge
    OnStateChange = DSStateChange
    Left = 40
    Top = 1
  end
  object AL: TActionList
    Images = DM.IL
    Left = 8
    object Pesquisa: TAction
      Category = 'Manutencao'
      Caption = '&Consultar (F9)'
      Hint = 'Clique (ou F9) para consultar os compromissos do dia'
      ImageIndex = 10
      OnExecute = PesquisaExecute
    end
    object Contatar: TAction
      Category = 'Manutencao'
      Caption = 'C&liente (F3)'
      Hint = 'Clique (ou F3) para consultar os dados do cliente'
      ImageIndex = 11
      OnExecute = ContatarExecute
    end
    object Exclui: TAction
      Category = 'Manutencao'
      Caption = '&Realizado (F4)'
      Hint = 'Clique (ou F4) para marcar o compromisso como realizado.'
      ImageIndex = 1
      OnExecute = ExcluiExecute
    end
    object Sair: TAction
      Category = 'Manutencao'
      Caption = '&Sair'
      Hint = 'Clique para finalizar'
      ImageIndex = 0
      OnExecute = SairExecute
    end
    object Importar: TAction
      Category = 'Manutencao'
      Caption = '&Importar (F5)'
      Hint = 'Clique ou F5 para reimportar as pendencias da cota'
      ImageIndex = 14
    end
  end
end
