object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 165
  object AbrirArq: TOpenDialog
    DefaultExt = '*.txt'
    InitialDir = 'c:\cca'
    Left = 24
    Top = 16
  end
  object Con: TSQLConnection
    ConnectionName = 'BdCon'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxint30.dll'
    LoadParamsOnConnect = True
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=localhost:c:\sistemas\cca\bdcon.fdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'gds32.dll'
    BeforeConnect = ConBeforeConnect
    Left = 88
    Top = 16
  end
  object SQLCom: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Con
    Left = 24
    Top = 72
  end
  object SQLTabela: TSQLTable
    MaxBlobSize = -1
    SQLConnection = Con
    Left = 88
    Top = 72
  end
end
