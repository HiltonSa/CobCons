unit UnitDados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils, ComCtrls, FileCtrl;

type

  TCampo = record
    Nome : String;
    Tipo : string;
    Tam : string;
  end;

  TFormPrincipal = class(TForm)
    mmComandoSQL: TMemo;
    Label1: TLabel;
    lblArqEnt: TLabel;
    EditNomeTab: TEdit;
    mmEstrutura: TMemo;
    Label2: TLabel;
    btnImportar: TButton;
    stBar: TStatusBar;
    mmLinha: TMemo;
    lblDiretorio: TLabel;
    dlb: TDirectoryListBox;
    flb: TFileListBox;
    cbSelecionaTudo: TCheckBox;
    Button1: TButton;
    cboModo: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbSelecionaTudoClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);

  private
    procedure CriarTabela;
    procedure MontarSQL(var sqlCom: string; Linha: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Campos : array[1..150] of TCampo;
  ArqEnt : TextFile;
  NumCampos: Integer;
  ParaTudo: Boolean;
  FormPrincipal: TFormPrincipal;

implementation

uses Data, DB, SqlExpr;

{$R *.dfm}

procedure TFormPrincipal.btnImportarClick(Sender: TObject);
var
  Linha, LinhaSai, sqlCom: string;
  I, J, Reg, Erros,  TReg, Lidos: Integer;
  ArqSai: TextFile;

procedure ExecutarSQLTratado;
begin
  DM.SQLCom.Close;
  DM.SQLCom.SQL.Clear;
  DM.SQLCom.SQL.Add(sqlCom);
  try
     DM.SQLCom.ExecSQL;
     Reg := Reg + 1;
  except                    // captura e salva erros
        Erros := Erros + 1;
        Writeln(ArqSai, Format('Err: %.6d Tab: %s Arq: %s Lin:%s Com: %s',
              [Lidos,EditNomeTab.Text,ExtractFileName(lblArqEnt.Caption),Linha, sqlCom]));
  end;
end;

begin

  if flb.SelCount = 0 then begin
    Application.MessageBox('Selecione os arquivos para importação...','Atenção',
      MB_ICONHAND+MB_OK);
    Exit;
  end;

  ParaTudo := False;
  AssignFile(ArqSai,'convdados.log');
  Rewrite(ArqSai);

  for I := 0 to flb.Count - 1 do begin

    if Pos('acmv',flb.Items[I])>0    // nomw da tabela
    then EditNomeTab.Text := 'ACMOV'
    else EditNomeTab.Text := UpperCase(Copy(flb.Items[I],1,Pos('.',
                ExtractFileName(flb.Items[I]))-1));

    lblArqEnt.Caption := lblDiretorio.Caption+'\'+flb.Items[I];

    AssignFile(ArqEnt,lblArqEnt.Caption);
    Reset(ArqEnt);

    if FileSize(ArqEnt)=0 then Continue;

    Erros := 0;

    case cboModo.ItemIndex of
     1: if EditNomeTab.Text = 'ACMOV' then begin
        Writeln(ArqSai, Format('AVISO: Não importar movimentos! Passando: %s',
              [ExtractFileName(lblArqEnt.Caption)]));
        Continue;
      end;
     2: if EditNomeTab.Text <> 'ACMOV' then begin
        Writeln(ArqSai, Format('AVISO: Importar somente movimentos! Passando: %s',
              [ExtractFileName(lblArqEnt.Caption)]));
        Continue;
      end;
    end;

    CriarTabela; // cria a tabela do arquivo e inicializa estrutura

    TReg := 0;
    for J := 1 to 150 do
        TReg := TReg + StrToIntDef(Campos[J].Tam,0);

    stBar.SimpleText := '';
    Writeln(ArqSai,Format('Tab: %s Arq: %s Ini: %s',
        [EditNomeTab.Text,ExtractFileName(lblArqEnt.Caption),TimeToStr(Time)]));

    Readln(ArqEnt,Linha);
    Lidos := 0;

    if TReg <> Length(Linha) then begin
        Erros := Erros + 1;
        Writeln(ArqSai, Format('Err: %.6d Tab: %s Arq: %s Erro de LayOut Tam Lin AC.DIC: %d Lido: %d',
              [Erros,EditNomeTab.Text,ExtractFileName(lblArqEnt.Caption),TReg, Length(Linha)]));
        Continue;
    end;

    Reg := 0;

    while not Eof(ArqEnt) do begin

      Inc(Lidos);
      mmLinha.Clear;
      mmLinha.Lines.Add(Linha);

      MontarSQL(sqlCom, Linha);

      mmComandoSQL.Clear;               // mostra o comando
      mmComandoSQL.Lines.Add(sqlCom);

      if ParaTudo then begin
        CloseFile(ArqEnt);
        CloseFile(ArqSai);
        DM.Con.Connected := False;
        Application.Terminate;
      end;

//      ExecutarSQLTratado;

      Readln(ArqEnt,Linha);
      Application.ProcessMessages;
      stBar.SimpleText := Format('%s: Lidos: %.6d Importados %.6d registros %.6D erros',
                      [EditNomeTab.Text, Lidos, Reg, Erros]);
    end;

    if Length(Linha)=TReg then begin    // sobrou uma linha...
      MontarSQL(sqlCom, Linha);
      ExecutarSQLTratado;
    end;

    CloseFile(ArqEnt);
    Writeln(ArqSai,Format('Arquivo: %s Tabela: %s Registros: Lidos: %.6d Importados: %.6d Erros: %.6d Fim: %s',
      [ExtractFileName(lblArqEnt.Caption),EditNomeTab.Text, Lidos, Reg, Erros, TimeToStr(Time)]));

  end;

  CloseFile(ArqSai);

end;

procedure TFormPrincipal.Button1Click(Sender: TObject);
var
   sqlCom: string;

begin
  if Application.MessageBox('Confirma Criação da Tabela?','Atenção',
     MB_ICONQUESTION+MB_YESNO)=mrYes then begin
    sqlCom := 'CREATE TABLE  ACTMO ('+
              'CODIGO 	 INTEGER NOT NULL primary key, ' +
              'DCINTSING 	 VARCHAR(20), '+
              'DCINTPLURAL 	 VARCHAR(20), '+
              'DCDECSING 	 VARCHAR(20), '+
              'DCDECPLURAL 	 VARCHAR(20), '+
              'DTINI 	 DATE, '+
              'DTFIM 	 DATE, '+
              'FATOR 	 FLOAT, ' +
              'SIMBOLO 	 VARCHAR(5))';
  mmComandoSQL.Lines.Clear;
  mmComandoSQL.Lines.Add(sqlCom);
  
  if not DM.AbrirTabela('ACTMO')  // se a tabela não existe, cria ou zera dados
  then begin
    DM.ExecutarSql(sqlCom);
    DM.ExecutarSql('INSERT INTO  ACTMO VALUES (1,''cruzeiro'',''cruzeiros'',''centavo'',''centavos'',''05/15/1970'',''02/27/1986'',1,''Cr$'')');
    DM.ExecutarSql('INSERT INTO  ACTMO VALUES (2,''cruzado'',''cruzados'',''centavo'',''centavos'',''02/28/1986'',''01/15/1989'',1000,''Cz$'')');
    DM.ExecutarSql('INSERT INTO  ACTMO VALUES (3,''cruzado novo'',''cruzados novos'',''centavo'',''centavos'',''01/16/1989'',''03/15/1990'',1000,''NCz$'')');
    DM.ExecutarSql('INSERT INTO  ACTMO VALUES (4,''cruzeiro'',''cruzeiros'',''centavo'',''centavos'',''03/16/1990'',''07/31/1993'',1,''Cr$'')');
    DM.ExecutarSql('INSERT INTO  ACTMO VALUES (5,''cruzeiro real'',''cruzeiros reais'',''centavo'',''centavos'',''08/01/1993'',''06/30/1994'',1,''CR$'')');
    DM.ExecutarSql('INSERT INTO  ACTMO VALUES (6,''real'',''reais'',''centavo'',''centavos'',''07/01/1994'',''12/31/2049'',2750,''R$'')');
  end;

  end;
end;

procedure TFormPrincipal.cbSelecionaTudoClick(Sender: TObject);
begin
  if cbSelecionaTudo.Checked then
    flb.SelectAll
    else flb.ClearSelection;
end;

procedure TFormPrincipal.CriarTabela;
var
  ArqDic: TextFile;
  Linha, sqlCom, stLin: string;
  LinIndice: string;
  Ind: Integer;
  Tp: string;
  Clausula: string;
  I: Integer;

begin

  NumCampos := 0;
  mmEstrutura.Clear;
  sqlCom :='create table ' + EditNomeTab.Text + ' (';

  for I := 1 to 150 do
    with Campos[I] do
    begin
      Nome := '';
      Tipo := '';
      Tam := '';
    end;

  AssignFile(ArqDic, ExtractFilePath(Application.ExeName)+ 'ac.dic');
  Reset(ArqDic);

  repeat

    Readln(ArqDic, Linha);

    if Pos(EditNomeTab.Text, Linha) > 0 then begin // procura estr tabela em ac.dic

      repeat

        mmEstrutura.Lines.Add(Linha);

        if Pos('Indice 01', Linha) > 0
        then LinIndice := Copy(Linha, 14, Length(Linha) - 14);

        if Pos('Campo', Linha) = 3 then begin
          Ind := StrToInt(copy(Linha, 9, 3));
          with Campos[Ind] do begin
            Nome := Trim(Copy(Linha, 14, 25));
            stLin := Copy(Linha, 41,30);
            Tp := Copy(stLin, Pos(',',stLin)-1,1);
            Tam := RightStr(Linha, 2);
            if pos(Tp, 'XTU9C') > 0 then
              Tipo := 'varchar(' + Tam + ')'
            else if Tp = 'D' then
              Tipo := 'date'
            else
              Tipo := 'float';
          end;
        end;

        Readln(ArqDic, Linha);

      until Pos('+', Linha) = 1;

      NumCampos := Ind;
      Break;

    end;

  until Eof(ArqDic);

  CloseFile(ArqDic);

  if Ind > 0 then begin       // monta chave primaria (indice 01)
    for I := 1 to ind do begin
      Clausula := '';
      if Pos(Format('%.3d', [I]), LinIndice) > 0 then
        Clausula := 'not null';
      sqlCom := sqlCom + Format('%s %s %s,',
                [Campos[I].Nome, Campos[I].Tipo, Clausula]);
    end;
    I := 1;
    Linha := 'primary key (';
    while Ind > 0 do  begin
      Ind := StrToIntDef(Copy(LinIndice, I, 3), 0);
      if Ind > 0 then
        Linha := Linha + Campos[Ind].Nome + ','
      else
        Linha := LeftStr(Linha, Length(Linha) - 1) + '))';
      I := I + 4;
    end;
    sqlCom := sqlCom + Linha;
  end;

  mmComandoSQL.Lines.Clear;
  mmComandoSQL.Lines.Add(sqlCom);

//  if not DM.AbrirTabela(EditNomeTab.Text)  // se a tabela não existe, cria ou zera dados
//  then DM.ExecutarSql(sqlCom)
//  else if EditNomeTab.Text <> 'ACMOV'
//       then DM.ExecutarSql(Format('delete from %s',[EditNomeTab.Text]));

end;

procedure TFormPrincipal.MontarSQL(var sqlCom: string; Linha: string);
var
  Dt: TDateTime;
  stData: string;
  intAno: Integer;
  Pst, J, TSql: Integer;
  Ano: string;
begin
  TSql := 0;
  sqlCom := 'insert into ' + EditNomeTab.Text + ' values (';
  Pst := 1;
  J := 1;
  repeat
    // monta o insert campo a campo - cada campo uma iteração
    if Campos[J].Tipo = 'date' then  begin
      stData := Copy(Linha, Pst, 6);
      if Length(Trim(stData)) <> 6
      then stData := '000000';
      if Pos(' ', stData) > 0
      then stData := '000000';
      if stData <> '000000' then  begin
        // se a data for valida
        intAno := Pos(Copy(stData, 1, 1), 'ABCDEFGHI');
        if intAno > 0
        then Ano := IntToStr(2000 + ((intAno - 1) * 10) + StrToInt(Copy(stData, 2, 1)))
        else Ano := IntToStr(1900 + StrToInt(Copy(stData, 1, 2)));
        if TryEncodeDate(StrToInt(Ano), StrToInt(copy(Linha, Pst + 2, 2)),
           StrToInt(copy(Linha, Pst + 4, 2)), Dt)
        then sqlCom := sqlCom + quotedstr(copy(Linha, Pst + 2, 2) + '/' +
                                copy(Linha, Pst + 4, 2) + '/' + Ano)
        else sqlCom := sqlCom + quotedstr('01/01/1801');
      end
      else sqlCom := sqlCom + quotedstr('01/01/1801');
    end
    else if Pos('varchar', Campos[J].Tipo) > 0
    then sqlCom := sqlCom + QuotedStr(Trim(copy(Linha, Pst, StrToInt(Campos[J].Tam))))
    else if Length(Trim(copy(Linha, Pst, StrToInt(Campos[J].Tam)))) = 0
    then sqlCom := sqlCom + '0' // se for numerico e estiver em branco, zero
    else sqlCom := sqlCom + copy(Linha, Pst, StrToInt(Campos[J].Tam));
    Pst := Pst + StrToIntDef(Campos[J].Tam, 0);
    sqlCom := sqlCom + ',';
    Inc(J);
  until (J > NumCampos);
  TSql := Length(sqlCom) - 1;
  sqlCom := Copy(sqlCom, 1, TSql) + ')';
end;

procedure TFormPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F12 then ParaTudo := (Application.MessageBox('Interromper ?',
       'Atenção',MB_ICONQUESTION+MB_YESNO)=IDYES);
end;

end.
