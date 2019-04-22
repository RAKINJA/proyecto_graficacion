unit propiedad_figura;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  { Tpanel_propiedades }

  Tpanel_propiedades = class(TForm)
    boton_ok: TButton;
    boton_cancel: TButton;
    color_figura: TColorButton;
    nombre_figura: TEdit;
    texto_tipo: TLabel;
    texto_color: TLabel;
    tipo_figura: TLabel;
    texto_nombre: TLabel;
    procedure color_figuraColorChanged(Sender: TObject);
    procedure nombre_figuraChange(Sender: TObject);
  private

  public
  // procedimientos
  procedure actualizar_opciones( nombre: String; tipo : integer; color_fig : TColor );
  end;

var
  panel_propiedades: Tpanel_propiedades;
  cambio_nombre,cambio_color : boolean;
  nuevo_nombre : String;
  nuevo_color  : TColor;




implementation

{$R *.frm}

procedure Tpanel_propiedades.nombre_figuraChange(Sender: TObject);
begin
	 nuevo_nombre := nombre_figura.Text;
     cambio_nombre := true;
end;

procedure Tpanel_propiedades.color_figuraColorChanged(Sender: TObject);
begin
	 nuevo_color := color_figura.ButtonColor;
     cambio_color := true;
end;

procedure Tpanel_propiedades.actualizar_opciones(nombre: String; tipo : integer; color_fig : TColor );
begin
     cambio_nombre := false;
     cambio_color  := true;

     nombre_figura.Text       := nombre;
     tipo_figura.Caption      := inttostr(tipo);
     color_figura.ButtonColor := color_fig;
end;

end.

