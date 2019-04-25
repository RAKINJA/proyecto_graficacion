unit opcion_colores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls;

type
  {TopColores}
  TopColores = class(TForm)
    boton_ok: TBitBtn;
    boton_cancelar: TBitBtn;

    color_a: TColorButton;
    color_i: TColorButton;
    color_e: TColorButton;
    color_o: TColorButton;
    color_u: TColorButton;

    a_: TLabel;
    e_: TLabel;
    i_: TLabel;
    o_: TLabel;
    u_: TLabel;

    //procedure color_aClick(Sender: TObject);
    procedure color_aColorChanged(Sender: TObject);
    procedure color_eColorChanged(Sender: TObject);
    procedure color_iColorChanged(Sender: TObject);
    procedure color_oColorChanged(Sender: TObject);
    procedure color_uColorChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private

  public
        colorA , colorE, colorI, colorO, colorU : TColor;
        colora_cambio, colore_cambio, colori_cambio, coloro_cambio, coloru_cambio : boolean;
  end;

var
  opColores: TopColores;
  colorA , colorE, colorI, colorO, colorU : TColor;

implementation

{$R *.frm}

{ TopColores }
procedure TopColores.color_aColorChanged(Sender: TObject);
begin
     colorA := color_a.ButtonColor;
     colora_cambio := true;
end;

procedure TopColores.color_eColorChanged(Sender: TObject);
begin
     colorE := color_e.ButtonColor;
     colore_cambio := true;
end;

procedure TopColores.color_iColorChanged(Sender: TObject);
begin
     colorI :=color_i.ButtonColor;
     colori_cambio := true;
end;

procedure TopColores.color_oColorChanged(Sender: TObject);
begin
     colorO := color_o.ButtonColor;
     coloro_cambio := true;
end;

procedure TopColores.color_uColorChanged(Sender: TObject);
begin
     colorU := color_u.ButtonColor;
     coloru_cambio := true;
end;

procedure TopColores.FormCreate(Sender: TObject);
begin
     TColorButton.Create(color_a);

     colora_cambio := false;
     colore_cambio := false;
     colori_cambio := false;
     coloro_cambio := false;
     coloru_cambio := false;
end;

end.

