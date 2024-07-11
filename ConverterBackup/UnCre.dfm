object FrmCre: TFrmCre
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Cr'#233'ditos da Cota'
  ClientHeight = 531
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object DBCtrlGrid1: TDBCtrlGrid
    Left = 0
    Top = 0
    Width = 428
    Height = 531
    Align = alClient
    AllowDelete = False
    AllowInsert = False
    Color = clSilver
    DataSource = dsCre
    PanelHeight = 265
    PanelWidth = 411
    ParentColor = False
    TabOrder = 0
    RowCount = 2
    SelectedColor = clSkyBlue
    ExplicitHeight = 472
    object Label9: TLabel
      Left = 15
      Top = 9
      Width = 35
      Height = 13
      Caption = 'Cr'#233'dito'
      FocusControl = DBEdit9
    end
    object Label10: TLabel
      Left = 74
      Top = 9
      Width = 73
      Height = 13
      Caption = 'Tipo de Cr'#233'dito'
      FocusControl = DBEdit10
    end
    object Label11: TLabel
      Left = 201
      Top = 9
      Width = 72
      Height = 13
      Caption = 'In'#237'cio Corre'#231#227'o'
      FocusControl = DBEdit11
    end
    object Label12: TLabel
      Left = 74
      Top = 51
      Width = 62
      Height = 13
      Caption = 'Valor Cr'#233'dito'
      FocusControl = DBEdit12
    end
    object Label13: TLabel
      Left = 201
      Top = 51
      Width = 71
      Height = 13
      Caption = 'Valor Corre'#231#227'o'
      FocusControl = DBEdit13
    end
    object Label14: TLabel
      Left = 298
      Top = 9
      Width = 66
      Height = 13
      Caption = 'Lim. Corre'#231#227'o'
      FocusControl = DBEdit14
    end
    object Label15: TLabel
      Left = 74
      Top = 134
      Width = 70
      Height = 13
      Caption = 'Dt. Nota Fiscal'
      FocusControl = DBEdit15
    end
    object Label16: TLabel
      Left = 174
      Top = 134
      Width = 52
      Height = 13
      Caption = 'Nota Fiscal'
      FocusControl = DBEdit16
    end
    object Label1: TLabel
      Left = 74
      Top = 91
      Width = 55
      Height = 13
      Caption = 'Fornecedor'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 279
      Top = 174
      Width = 72
      Height = 13
      Caption = 'Corr. Entregue'
      FocusControl = DBEdit3
    end
    object Label3: TLabel
      Left = 74
      Top = 174
      Width = 71
      Height = 13
      Caption = 'Valor Entregue'
      FocusControl = DBEdit2
    end
    object Label4: TLabel
      Left = 297
      Top = 134
      Width = 54
      Height = 13
      Caption = 'Data Pagto'
      FocusControl = DBEdit4
    end
    object Label5: TLabel
      Left = 74
      Top = 211
      Width = 64
      Height = 13
      Caption = 'Bem Opcional'
      FocusControl = DBEdit5
    end
    object DBEdit9: TDBEdit
      Left = 15
      Top = 25
      Width = 51
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'CREDITO'
      DataSource = dsCre
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit10: TDBEdit
      Left = 72
      Top = 25
      Width = 105
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'DCTPCRE'
      DataSource = dsCre
      ReadOnly = True
      TabOrder = 1
    end
    object DBEdit11: TDBEdit
      Left = 201
      Top = 25
      Width = 72
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'DT_I_COR'
      DataSource = dsCre
      ReadOnly = True
      TabOrder = 2
    end
    object DBEdit12: TDBEdit
      Left = 74
      Top = 67
      Width = 98
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'VAL_CRED'
      DataSource = dsCre
      ReadOnly = True
      TabOrder = 3
    end
    object DBEdit13: TDBEdit
      Left = 201
      Top = 67
      Width = 93
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'VAL_CORR'
      DataSource = dsCre
      ReadOnly = True
      TabOrder = 4
    end
    object DBEdit14: TDBEdit
      Left = 298
      Top = 25
      Width = 74
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'LIM_CORR'
      DataSource = dsCre
      ReadOnly = True
      TabOrder = 5
    end
    object DBEdit15: TDBEdit
      Left = 74
      Top = 150
      Width = 74
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'DT_N_FIS'
      DataSource = dsCre
      ReadOnly = True
      TabOrder = 6
    end
    object DBEdit16: TDBEdit
      Left = 174
      Top = 150
      Width = 98
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'NR_N_FIS'
      DataSource = dsCre
      ReadOnly = True
      TabOrder = 7
    end
    object DBEdit1: TDBEdit
      Left = 74
      Top = 107
      Width = 298
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'FORNEC'
      DataSource = dsCre
      ReadOnly = True
      TabOrder = 8
    end
    object DBEdit2: TDBEdit
      Left = 74
      Top = 190
      Width = 98
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'VAL_ENTR'
      DataSource = dsCre
      ReadOnly = True
      TabOrder = 9
    end
    object DBEdit3: TDBEdit
      Left = 279
      Top = 190
      Width = 93
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'COR_ENTR'
      DataSource = dsCre
      ReadOnly = True
      TabOrder = 10
    end
    object DBEdit4: TDBEdit
      Left = 297
      Top = 150
      Width = 75
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'DT_PAGTO'
      DataSource = dsCre
      ReadOnly = True
      TabOrder = 11
    end
    object DBEdit5: TDBEdit
      Left = 74
      Top = 227
      Width = 298
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'D_BEM_OP'
      DataSource = dsCre
      ReadOnly = True
      TabOrder = 12
    end
  end
  object dsCre: TDataSource
    AutoEdit = False
    DataSet = DM.cdsCre
    Left = 368
    Top = 8
  end
end
