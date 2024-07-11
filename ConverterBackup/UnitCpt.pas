unit UnitCpt;

interface
  function dtLiberado(xave, razao:string): TDateTime;
  function gerarChave(strPos, razao: string; dtLib: TDateTime): string;
  function posicaoLetra(letra: string): integer;
  function removeAcento(str:string): string;

implementation

uses
  SysUtils, DateUtils;

var
  Posicao: string = 'ABaCDEbFGHcIJKdLMNOePQRfSghijTlUmVnWoXpYqrstuvxZz';
  L1: array[1..26] of string =
     ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
      'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
  L2: array[1..26] of string =
     ('0123456789', //a
      '1234567890', //b
      '2345678901', //c
      '3456789012', //d
      '4567890123', //e
      '5678901234', //f
      '6789012345', //g
      '7890123456', //h
      '8901234567', //i
      '9012345678', //j
      '0123456789', //k
      '1234567890', //l
      '2345678901', //m
      '3456789012', //n
      '4567890123', //o
      '5678901234', //p
      '6789012345', //q
      '7890123456', //r
      '8901234567', //s
      '9012345678', //t
      '0123456789', //u
      '1234567890',//v
      '2345678901',//w
      '3456789012',//x
      '4567890123',//y
      '5678901234' ); //z


function gerarChave(strPos, razao: string; dtLib: TDateTime): string;
var
  sPos,sNum, sLib: string;
  I, nPos: Integer;
begin
  sPos := '';
  sLib := Format('%.5d',[Trunc(dtLib)]);
  sNum := '';
  nPos := 0;
  for I := 1 to 5 do begin
    nPos := posicaoLetra(strPos[I]);
    while Copy(razao,nPos,1)=' ' do Inc(nPos);
    sPos := sPos + UpperCase(removeAcento(Copy(razao,nPos,1)));
  end;
  for I := 1 to 5 do begin
    nPos := ord(spos[I]) - 64;
    sNum := sNum + Copy(L2[nPos],StrToInt(sLib[I]),1);
  end;
  Result := sNum;
end;

function dtLiberado(xave, razao:string): TDateTime;
var
  sPos,sNum, vNum: string;
  iPos, I: Integer;
  dValido: TDateTime;
begin
  sPos := '';
  sNum := '';
  for I := 1 to Length(xave) do begin
    iPos := posicaoLetra(xave[I]);
    if iPos>0 then begin
      while copy(razao, Ipos, 1)=' ' do Inc(Ipos);
      sPos := sPos + UpperCase(removeAcento(copy(razao, Ipos, 1)));
    end
    else sNum := sNum + xave[I];
  end;
  vNum := '';
  for I := 1 to 5 do begin
    iPos := ord(sPos[I]) - 64;
    vNum := vNum + InttoStr(Pos(sNum[I],L2[Ipos])) ;
  end;
  dValido := StrToFloat(vNum);
  result := dValido;
end;

function posicaoLetra(letra: string): integer;
begin
  Result := Pos(letra, Posicao);
end;

function removeAcento(str:string): string;
const
  ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
var
  nPos: Integer;
begin
  nPos := Pos(Str,ComAcento);
  if nPos <> 0
  then Str := SemAcento[nPos];
  Result := Str;
end;

end.
