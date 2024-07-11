object frmJur: TfrmJur
  Left = 625
  Top = 122
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsToolWindow
  Caption = 'Fases Jur'#237'dicas'
  ClientHeight = 446
  ClientWidth = 325
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefaultPosOnly
  ShowHint = True
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object DBCtrlGrid1: TDBCtrlGrid
    Left = 0
    Top = 0
    Width = 325
    Height = 446
    Align = alClient
    Color = clBtnFace
    DataSource = dsJur
    PanelHeight = 148
    PanelWidth = 308
    ParentColor = False
    TabOrder = 0
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 308
      Height = 49
      Align = alTop
      BevelInner = bvLowered
      Color = clMoneyGreen
      TabOrder = 0
      object Label2: TLabel
        Left = 222
        Top = 6
        Width = 27
        Height = 13
        Caption = 'In'#237'cio'
        FocusControl = DBEdit2
      end
      object Label1: TLabel
        Left = 6
        Top = 6
        Width = 23
        Height = 13
        Caption = 'Fase'
        FocusControl = DBEdit1
      end
      object DBEdit1: TDBEdit
        Left = 6
        Top = 21
        Width = 209
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'DESCRIC'
        DataSource = dsJur
        ReadOnly = True
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 222
        Top = 21
        Width = 81
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'D_INICIO'
        DataSource = dsJur
        ReadOnly = True
        TabOrder = 1
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 49
      Width = 308
      Height = 99
      Align = alClient
      BevelInner = bvLowered
      TabOrder = 1
      object Label5: TLabel
        Left = 6
        Top = 52
        Width = 58
        Height = 13
        Caption = 'Observa'#231#227'o'
        FocusControl = DBEdit5
      end
      object Label3: TLabel
        Left = 6
        Top = 10
        Width = 49
        Height = 13
        Caption = 'Advogado'
        FocusControl = DBEdit3
      end
      object Label4: TLabel
        Left = 222
        Top = 10
        Width = 24
        Height = 13
        Caption = 'Valor'
        FocusControl = DBEdit4
      end
      object DBEdit5: TDBEdit
        Left = 6
        Top = 68
        Width = 297
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'OBSERV'
        DataSource = dsJur
        ReadOnly = True
        TabOrder = 0
      end
      object DBEdit3: TDBEdit
        Left = 6
        Top = 26
        Width = 209
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'NOME'
        DataSource = dsJur
        ReadOnly = True
        TabOrder = 1
      end
      object DBEdit4: TDBEdit
        Left = 222
        Top = 26
        Width = 81
        Height = 21
        TabStop = False
        Color = clBtnFace
        DataField = 'CUST_MOE'
        DataSource = dsJur
        ReadOnly = True
        TabOrder = 2
      end
    end
  end
  object dsJur: TDataSource
    AutoEdit = False
    DataSet = DM.sdsJur
    Left = 80
  end
end
