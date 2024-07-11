unit cobcons.model.configura;

{$mode delphi}

interface

uses
  Classes, Sysutils, Graphics;
type

  TEsquemaCores = record
    Nome: String;
    CorPainelTitulo: Tcolor;
    CorPainelRodape: Tcolor;
    CorPainelAcoes: Tcolor;
    CorFormulario: Tcolor;
    CorFundo: Tcolor;
  end;

  { iConfigura }

  iConfigura = interface
    ['{5E0E20F2-4A9A-4BD5-9997-955145DF7858}']
    function RetornaEsquema(pInd: Integer): TEsquemaCores;
    function RetornaEsquemaUsuario: TEsquemaCores;
  end;

  { TConfigura }

  TConfigura = class (TInterfacedObject, iConfigura)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iConfigura;

      function RetornaEsquema(pInd: Integer): TEsquemaCores;
      function RetornaEsquemaUsuario: TEsquemaCores;
  end;

implementation

uses cobcons.controller.util;

const
  ESQUEMAS: array[0..3] of TEsquemaCores = (
      (Nome: 'Azul';
       CorPainelTitulo: TColor($61302E);
       CorPainelRodape: TColor($61302E);
       CorPainelAcoes: TColor($AD5651);
       CorFormulario: TColor($614C4B);
       CorFundo: TColor($E6B3B1);),
      (Nome: 'Verde';
       CorPainelTitulo: TColor($8C6503);
       CorPainelRodape: TColor($8C6503);
       CorPainelAcoes: TColor($8C832E);
       CorFormulario: TColor($B23F44);
       CorFundo: TColor($D2FFE2);),
      (Nome: 'Amarelo';
       CorPainelTitulo: TColor($114A8C);
       CorPainelRodape: TColor($114A8C);
       CorPainelAcoes: TColor($2489BF);
       CorFormulario: TColor($021959);
       CorFundo: TColor($6A9ED9);),
      (Nome: 'Vermelho';
       CorPainelTitulo: TColor($3E1F73);
       CorPainelRodape: TColor($3E1F73);
       CorPainelAcoes: TColor($6844A6);
       CorFormulario: TColor($180940);
       CorFundo: TColor($C1D3D9);)
    );

{ TConfigura }

constructor Tconfigura.Create;
begin
end;

destructor Tconfigura.Destroy;
begin
  inherited Destroy;
end;

class function Tconfigura.New: Iconfigura;
begin
  Result := Self.Create;
end;

function Tconfigura.Retornaesquema(Pind: Integer): Tesquemacores;
begin
  Result := ESQUEMAS[Pind];
end;

function Tconfigura.Retornaesquemausuario: Tesquemacores;
begin
  Result := ESQUEMAS[RetornaUsuarioLogado.ESQUEMA];
end;


end.

