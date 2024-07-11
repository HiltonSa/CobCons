object frmPrs: TfrmPrs
  Left = 297
  Top = 172
  BorderStyle = bsToolWindow
  Caption = 'Par'#226'metros'
  ClientHeight = 208
  ClientWidth = 509
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
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object stBar: TStatusBar
    Left = 0
    Top = 189
    Width = 509
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
    Left = 422
    Top = 0
    Width = 87
    Height = 189
    Align = alRight
    BevelInner = bvLowered
    Color = clSilver
    TabOrder = 1
    object btnGravar: TSpeedButton
      Left = 4
      Top = 63
      Width = 80
      Height = 20
      Action = Grava
      Enabled = False
      Flat = True
    end
    object btnCancelar: TSpeedButton
      Left = 4
      Top = 105
      Width = 80
      Height = 20
      Action = Cancela
      Enabled = False
      Flat = True
    end
    object btnSair: TSpeedButton
      Left = 4
      Top = 147
      Width = 80
      Height = 20
      Action = Sair
      Flat = True
    end
    object btnAlterar: TSpeedButton
      Left = 4
      Top = 21
      Width = 80
      Height = 20
      Action = Altera
      Enabled = False
      Flat = True
    end
  end
  object pc: TPageControl
    Left = 0
    Top = 0
    Width = 422
    Height = 189
    ActivePage = tsGeral
    Align = alClient
    TabOrder = 2
    object tsGeral: TTabSheet
      Caption = 'Geral'
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 414
        Height = 161
        Align = alClient
        BevelInner = bvLowered
        Color = clMoneyGreen
        TabOrder = 0
        object Label1: TLabel
          Left = 37
          Top = 16
          Width = 19
          Height = 13
          Caption = 'C'#243'd'
          FocusControl = DBEdit1
        end
        object Label2: TLabel
          Left = 77
          Top = 16
          Width = 28
          Height = 13
          Caption = 'Nome'
          FocusControl = DBEdit2
        end
        object Label3: TLabel
          Left = 77
          Top = 56
          Width = 22
          Height = 13
          Caption = 'CGC'
          FocusControl = DBEdit3
        end
        object Label4: TLabel
          Left = 76
          Top = 96
          Width = 42
          Height = 13
          Caption = '% Multas'
          FocusControl = DBEdit4
        end
        object Label5: TLabel
          Left = 156
          Top = 96
          Width = 36
          Height = 13
          Caption = '% Juros'
          FocusControl = DBEdit5
        end
        object Label6: TLabel
          Left = 244
          Top = 96
          Width = 62
          Height = 13
          Caption = '% Honor'#225'rios'
          FocusControl = DBEdit6
        end
        object lblLib: TLabel
          Left = 77
          Top = 139
          Width = 57
          Height = 13
          Caption = 'Libera'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DBEdit1: TDBEdit
          Left = 37
          Top = 32
          Width = 33
          Height = 21
          TabStop = False
          Color = clBtnFace
          DataField = 'CD_PRS'
          DataSource = DS
          ReadOnly = True
          TabOrder = 0
        end
        object DBEdit2: TDBEdit
          Left = 77
          Top = 32
          Width = 300
          Height = 21
          CharCase = ecUpperCase
          DataField = 'NM_PRS'
          DataSource = DS
          TabOrder = 1
        end
        object DBEdit3: TDBEdit
          Left = 77
          Top = 72
          Width = 144
          Height = 21
          CharCase = ecUpperCase
          DataField = 'CD_CGC'
          DataSource = DS
          MaxLength = 18
          TabOrder = 2
        end
        object DBEdit4: TDBEdit
          Left = 76
          Top = 112
          Width = 50
          Height = 21
          DataField = 'PC_MUL'
          DataSource = DS
          TabOrder = 3
        end
        object DBEdit5: TDBEdit
          Left = 156
          Top = 112
          Width = 50
          Height = 21
          DataField = 'PC_JUR'
          DataSource = DS
          TabOrder = 4
        end
        object DBEdit6: TDBEdit
          Left = 252
          Top = 112
          Width = 50
          Height = 21
          DataField = 'PC_HONOR'
          DataSource = DS
          TabOrder = 5
        end
      end
    end
    object tsSAG: TTabSheet
      Caption = 'SAG'
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 414
        Height = 161
        Align = alClient
        BevelInner = bvLowered
        Color = clMoneyGreen
        TabOrder = 0
        object Label8: TLabel
          Left = 19
          Top = 34
          Width = 37
          Height = 13
          Caption = 'Contato'
          FocusControl = DBEdit8
        end
        object Label9: TLabel
          Left = 19
          Top = 77
          Width = 42
          Height = 13
          Caption = 'Telefone'
          FocusControl = DBEdit9
        end
        object Label11: TLabel
          Left = 108
          Top = 77
          Width = 25
          Height = 13
          Caption = 'Email'
          FocusControl = DBEdit11
        end
        object Label7: TLabel
          Left = 331
          Top = 34
          Width = 35
          Height = 13
          Caption = 'Ult.Sag'
          FocusControl = DBEdit7
        end
        object DBEdit8: TDBEdit
          Left = 19
          Top = 50
          Width = 300
          Height = 21
          CharCase = ecUpperCase
          DataField = 'NMCONTATO'
          DataSource = DS
          TabOrder = 0
        end
        object DBEdit9: TDBEdit
          Left = 19
          Top = 93
          Width = 83
          Height = 21
          CharCase = ecUpperCase
          DataField = 'TELCONTATO'
          DataSource = DS
          MaxLength = 18
          TabOrder = 1
        end
        object DBEdit11: TDBEdit
          Left = 108
          Top = 93
          Width = 287
          Height = 21
          DataField = 'MAILCONTATO'
          DataSource = DS
          TabOrder = 2
        end
        object DBEdit7: TDBEdit
          Left = 331
          Top = 50
          Width = 64
          Height = 21
          TabStop = False
          Color = clBtnFace
          DataField = 'ULTSAG'
          DataSource = DS
          ReadOnly = True
          TabOrder = 3
        end
      end
    end
  end
  object DS: TDataSource
    AutoEdit = False
    DataSet = DM.cdsPRS
    OnStateChange = DSStateChange
    Left = 184
    Top = 33
  end
  object AL: TActionList
    Images = DM.IL
    Left = 152
    Top = 32
    object Altera: TAction
      Category = 'Manutencao'
      Caption = '&Alterar (F3)'
      Hint = 'Clique (ou F3) para alterar os dados'
      ImageIndex = 1
      OnExecute = AlteraExecute
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
  end
end
