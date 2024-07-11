inherited frmUsu: TfrmUsu
  Caption = 'Manuten'#231#227'o de Usu'#225'rios'
  ClientHeight = 279
  ClientWidth = 495
  OldCreateOrder = True
  OnClose = FormClose
  ExplicitWidth = 501
  ExplicitHeight = 303
  PixelsPerInch = 96
  TextHeight = 13
  inherited stBar: TStatusBar
    Top = 260
    Width = 495
    ExplicitTop = 260
    ExplicitWidth = 495
  end
  inherited Panel1: TPanel
    Left = 408
    Height = 260
    ExplicitLeft = 408
    ExplicitHeight = 260
    inherited btnGravar: TSpeedButton
      Top = 143
      ExplicitTop = 143
    end
    inherited btnCancelar: TSpeedButton
      Top = 189
      ExplicitTop = 189
    end
    inherited btnSair: TSpeedButton
      Top = 235
      ExplicitTop = 235
    end
    inherited btnExcluir: TSpeedButton
      Top = 98
      ExplicitTop = 98
    end
    inherited btnAlterar: TSpeedButton
      Top = 52
      ExplicitTop = 52
    end
    inherited btnIncluir: TSpeedButton
      Top = 7
      ExplicitTop = 7
    end
  end
  inherited PC: TPageControl
    Width = 408
    Height = 260
    ExplicitWidth = 408
    ExplicitHeight = 260
    inherited tbCon: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 400
      ExplicitHeight = 232
      inherited grCon: TDBGrid
        Width = 400
        Height = 183
        OnDblClick = grConDblClick
      end
      inherited Panel2: TPanel
        Width = 400
        ExplicitWidth = 400
        inherited btnPesq: TSpeedButton
          Top = 14
          ExplicitTop = 14
        end
        inherited Label1: TLabel
          Top = 6
          ExplicitTop = 6
        end
        inherited Label2: TLabel
          Left = 88
          Top = 6
          ExplicitLeft = 88
          ExplicitTop = 6
        end
        inherited cboCampo: TComboBox
          Top = 22
          Width = 73
          ItemIndex = 0
          Text = 'Nome'
          Items.Strings = (
            'Nome'
            'C'#243'digo')
          ExplicitTop = 22
          ExplicitWidth = 73
        end
        inherited cboRel: TComboBox
          Left = 88
          Top = 22
          ExplicitLeft = 88
          ExplicitTop = 22
        end
        inherited txtPesq: TEdit
          Left = 176
          Top = 22
          ExplicitLeft = 176
          ExplicitTop = 22
        end
      end
    end
    inherited tbFic: TTabSheet
      OnShow = tbFicShow
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 400
      ExplicitHeight = 232
      object Label3: TLabel
        Left = 8
        Top = 24
        Width = 19
        Height = 13
        Caption = 'C'#243'd'
        FocusControl = DBEdit1
      end
      object Label4: TLabel
        Left = 64
        Top = 24
        Width = 28
        Height = 13
        Caption = 'Nome'
        FocusControl = DBEdit2
      end
      object Label6: TLabel
        Left = 64
        Top = 72
        Width = 27
        Height = 13
        Caption = 'Adm?'
      end
      object Label7: TLabel
        Left = 184
        Top = 72
        Width = 31
        Height = 13
        Caption = 'Senha'
        FocusControl = DBEdit5
      end
      object btSen: TSpeedButton
        Left = 153
        Top = 87
        Width = 23
        Height = 22
        Hint = 'Mostra senha'
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          5000555555555555577755555555555550B0555555555555F7F7555555555550
          00B05555555555577757555555555550B3B05555555555F7F557555555555000
          3B0555555555577755755555555500B3B0555555555577555755555555550B3B
          055555FFFF5F7F5575555700050003B05555577775777557555570BBB00B3B05
          555577555775557555550BBBBBB3B05555557F555555575555550BBBBBBB0555
          55557F55FF557F5555550BB003BB075555557F577F5575F5555577B003BBB055
          555575F7755557F5555550BB33BBB0555555575F555557F555555507BBBB0755
          55555575FFFF7755555555570000755555555557777775555555}
        NumGlyphs = 2
        OnClick = btSenClick
      end
      object DBEdit1: TDBEdit
        Left = 8
        Top = 40
        Width = 49
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'CD_USU'
        DataSource = DS
        ReadOnly = True
        TabOrder = 3
      end
      object DBEdit2: TDBEdit
        Left = 64
        Top = 40
        Width = 199
        Height = 21
        DataField = 'NM_USU'
        DataSource = DS
        TabOrder = 0
      end
      object DBEdit5: TDBEdit
        Left = 184
        Top = 88
        Width = 81
        Height = 21
        DataField = 'CD_SENHA'
        DataSource = DS
        PasswordChar = '*'
        TabOrder = 2
      end
      object cboAdm: TComboBox
        Left = 65
        Top = 87
        Width = 57
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Items.Strings = (
          'N'#227'o'
          'Sim')
      end
    end
  end
  inherited AL: TActionList
    inherited Pesquisa: TAction
      OnExecute = PesquisaExecute
    end
    inherited Novo: TAction
      OnExecute = NovoExecute
    end
    inherited Altera: TAction
      OnExecute = AlteraExecute
    end
    inherited Grava: TAction
      OnExecute = GravaExecute
    end
    inherited Cancela: TAction
      OnExecute = CancelaExecute
    end
  end
  inherited DS: TDataSource
    DataSet = DM.cdsUsu
  end
  inherited dsPesq: TDataSource
    DataSet = DM.cdsPesq
  end
end
