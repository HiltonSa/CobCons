object frmGerarChave: TfrmGerarChave
  Left = 0
  Top = 0
  Caption = 'Gerar Chave'
  ClientHeight = 333
  ClientWidth = 407
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 60
    Height = 13
    Caption = 'Raz'#227'o Social'
  end
  object Label2: TLabel
    Left = 8
    Top = 49
    Width = 67
    Height = 13
    Caption = 'Data Liberado'
  end
  object btGerarChave: TSpeedButton
    Left = 320
    Top = 65
    Width = 65
    Height = 22
    Caption = 'Gerar'
    Flat = True
    OnClick = btGerarChaveClick
  end
  object btSalva: TSpeedButton
    Left = 87
    Top = 142
    Width = 65
    Height = 22
    Caption = 'Salvar'
    Flat = True
    OnClick = btSalvaClick
  end
  object btCancelar: TSpeedButton
    Left = 158
    Top = 142
    Width = 65
    Height = 22
    Caption = 'Cancelar'
    Flat = True
    OnClick = btCancelarClick
  end
  object btNovo: TSpeedButton
    Left = 8
    Top = 142
    Width = 65
    Height = 22
    Caption = 'Novo'
    Flat = True
    OnClick = btNovoClick
  end
  object Label3: TLabel
    Left = 8
    Top = 89
    Width = 60
    Height = 13
    Caption = 'Ultima String'
  end
  object btSair: TSpeedButton
    Left = 320
    Top = 142
    Width = 65
    Height = 22
    Caption = 'Sair'
    Flat = True
    OnClick = btSairClick
  end
  object Label4: TLabel
    Left = 119
    Top = 49
    Width = 52
    Height = 13
    Caption = 'Liberar at'#233
  end
  object Label5: TLabel
    Left = 119
    Top = 89
    Width = 36
    Height = 13
    Caption = 'Posi'#231#227'o'
  end
  object Label6: TLabel
    Left = 214
    Top = 49
    Width = 74
    Height = 13
    Caption = 'Nova Libera'#231#227'o'
  end
  object Label7: TLabel
    Left = 214
    Top = 89
    Width = 52
    Height = 13
    Caption = 'Verifica'#231#227'o'
  end
  object btVerificar: TSpeedButton
    Left = 320
    Top = 105
    Width = 65
    Height = 22
    Caption = 'Verificar'
    Enabled = False
    Flat = True
    OnClick = btVerificarClick
  end
  object grEmp: TDBGrid
    Left = 8
    Top = 196
    Width = 377
    Height = 129
    TabStop = False
    DataSource = dsEmp
    Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object edRazaoSocial: TDBEdit
    Left = 8
    Top = 24
    Width = 337
    Height = 21
    DataField = 'RazaoSocial'
    DataSource = dsEmp
    TabOrder = 1
  end
  object edDtLib: TDBEdit
    Left = 8
    Top = 65
    Width = 105
    Height = 21
    DataField = 'DtLib'
    DataSource = dsEmp
    MaxLength = 10
    TabOrder = 2
  end
  object edUltLib: TDBEdit
    Left = 8
    Top = 105
    Width = 105
    Height = 21
    DataField = 'UltLib'
    DataSource = dsEmp
    TabOrder = 3
  end
  object dtLib: TDateTimePicker
    Left = 119
    Top = 65
    Width = 89
    Height = 21
    Date = 41779.667780879630000000
    Time = 41779.667780879630000000
    TabOrder = 4
  end
  object edPos: TEdit
    Left = 119
    Top = 105
    Width = 89
    Height = 21
    MaxLength = 5
    TabOrder = 5
    OnKeyPress = edPosKeyPress
  end
  object edNovaLib: TEdit
    Left = 214
    Top = 65
    Width = 89
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 6
  end
  object edVer: TEdit
    Left = 214
    Top = 105
    Width = 89
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 7
  end
  object cdsEmp: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 16
    Top = 168
    Data = {
      630000009619E0BD01000000180000000300000000000300000063000B52617A
      616F536F6369616C010049000000010005574944544802000200320006556C74
      4C69620100490000000100055749445448020002000A000544744C6962040006
      00000000000000}
    object cdsEmpRazaoSocial: TStringField
      DisplayLabel = 'Razao Social'
      DisplayWidth = 28
      FieldName = 'RazaoSocial'
      Size = 50
    end
    object cdsEmpUltLib: TStringField
      DisplayLabel = 'Ult. String'
      DisplayWidth = 12
      FieldName = 'UltLib'
      Size = 10
    end
    object cdsEmpDtLib: TDateField
      DisplayWidth = 12
      FieldName = 'DtLib'
      EditMask = '!99/99/0000;1; '
    end
  end
  object dsEmp: TDataSource
    AutoEdit = False
    DataSet = cdsEmp
    OnStateChange = dsEmpStateChange
    Left = 48
    Top = 168
  end
end
