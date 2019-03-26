unit codigoGraf;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  Menus, StdCtrls, ExtDlgs;

type
    Tcoordenada = record // Elemento coordenada para cada figura
      X,Y : integer;
    end;

    figura = record // Crea la estructura para cada figura
      tipo        : Integer;
      numero      : integer;
      cantPuntos  : integer;
      Coordenadas : array of Tcoordenada;

      color: Tcolor;

      estado : boolean;
    end;

  { Tproyecto_graf }

    Tproyecto_graf = class(TForm)
    cuadrocolor: TColorDialog;
    grafico: TImage;
    Label1: TLabel;
    lista_iconos: TImageList;
    barra1: TToolBar;
    boton_linea: TToolButton;
    boton_cuadrado: TToolButton;
    boton_circulo: TToolButton;
    boton_elipse: TToolButton;
    boton_polilinea: TToolButton;
    boton_reflejo: TToolButton;
    boton_color: TToolButton;
    lista_elementos: TListBox;
    menu_primario: TMainMenu;
    menu_alg: TMenuItem;
    opcion_editable: TMenuItem;
    menu_linea: TMenuItem;
    opcionDDA: TMenuItem;
    opcionBRE: TMenuItem;
    menu1: TMenuItem;
    menu_abrir: TMenuItem;
    opcion_importar: TMenuItem;
    opcion_guardar: TMenuItem;
    opcion_nuevo: TMenuItem;
    dialogo_imagen: TOpenPictureDialog;
    ScrollBox1: TScrollBox;

    // Procedimientos Sistema

    procedure boton_circuloClick(Sender: TObject);
    procedure boton_cuadradoClick(Sender: TObject);
    procedure boton_lineaClick(Sender: TObject);
    procedure boton_elipseClick(Sender: TObject);
    procedure boton_polilineaClick(Sender: TObject);
    procedure boton_reflejoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure graficoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure boton_colorClick(Sender: TObject);
    procedure graficoPaint(Sender: TObject);
    procedure lista_elementosClick(Sender: TObject);
    procedure opcionDDAClick(Sender: TObject);
    procedure opcionBREClick(Sender: TObject);
    procedure opcion_importarClick(Sender: TObject);

  private

  public

    {
        Funciones para Estructuras
    }
    function crearFigura( tipo, cantPuntos : integer ): figura;

    {
        Procedimientos para Estructuras
    }
    procedure graficarFigura(  cantPuntos : integer; figura : figura  );
    procedure agregarFiguraLista( figuraNueva : figura);

    // Procedimientos para Figuras
    procedure graficarLineaDDA (x1,y1,x2,y2 : integer);       // Linea DDA
    procedure graficarLineaBresenham (x1,y1,x2,y2 : integer); // Linea Bresenham

    procedure graficarRectangulo (x1,y1,x2,y2 : integer);     // Rectangulo / Cuadrado

    procedure graficarCirculo(x1,y1,x2,y2 : integer);                // Circulo
    procedure graficarOctantes(xk, yk, centroX, centroY : integer ); // Octantes Circulo

    procedure graficarElipse(x1,y1,x2,y2,xc,yc : integer);  // Graficar Elipse
  end;

var
  proyecto_graf: Tproyecto_graf; // Se crea el proyecto

  figurasCreadas  : array of figura; // Arreglo General de figuras creadas

  coordenadasAux : array of TCoordenada; // Arreglo auxiliar de coordenadas para su reconocimiento
  contadorFiguras : integer;
  cantidadCoorFigura : integer; // Especifica la cantidad de Pares de Coordenadas X,Y de cada figura


  valorOpcion: integer; // Variable para saber que boton_reflejo presiono y posteriormente saber cuantos puntos esperar
  contadorClicks: Integer; // contador de clicks para verificar los puntos

  cX,cY : Integer; {Coordenadas X,Y del mouse}
  pluma : TPen;

  activoDDA : boolean; // True : DDA Algorithm ; False : Bresenham Algorithm (Para linea)

  imagen_actual : TPicture;

implementation

{$R *.frm}

{
    INICIALIZACION DEL FORMULARIO
}
{ Tproyecto_graf }
procedure Tproyecto_graf.FormCreate(Sender: TObject);
begin
     // inicilizar variables
     contadorFiguras := 0;
     valorOpcion     := 1;
     activoDDA       := true;
     contadorFiguras := 0;
     imagen_actual := grafico.Picture.Create;


     // Ancho y alto predefinido del Formulario
     proyecto_graf.Height := 470;
     proyecto_graf.Width  := 650;
     proyecto_graf.Caption:='PROYECTO - Graficación 2D';

     // posicionar el canvas
     grafico.Left := 10;
     grafico.Top  := 10;

     // Ancho y alto predefinido del canvas
     grafico.Width  := 300;
     grafico.Height := 300;

     pluma := grafico.Canvas.Pen.Create;

     grafico.Canvas.Rectangle(0,0,grafico.Width,grafico.Height);

end;

{
    Recepción del Click sobre el Canvas
}
procedure Tproyecto_graf.graficoMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
var
    coordenadaAux : TCoordenada;
    figuraAux : figura;

begin
     if contadorClicks < cantidadCoorFigura then begin // Guardar la cantidad de Coordenadas Correspondiente a la figura
        coordenadaAux.X := X;
        coordenadaAux.Y := Y;

        Setlength(coordenadasAux, contadorClicks+1);

        coordenadasAux[contadorClicks] := coordenadaAux;

        if contadorClicks = cantidadCoorFigura-1 then begin
           // Reseteo de variables
           contadorClicks := -1;

           contadorFiguras := contadorFiguras + 1;
           figuraAux := crearFigura( valorOpcion, cantidadCoorFigura ); // Creado de la figura
           agregarFiguraLista( figuraAux );
           graficarFigura( cantidadCoorFigura, figuraAux  );

        end;

     end;

     contadorClicks := contadorClicks+1;
end;

{
   Inicia el procedimiento de cambio de color de la pluma para pintar en el Canvas
}
procedure Tproyecto_graf.boton_colorClick(Sender: TObject);
begin
     if(cuadrocolor.Execute) then
     begin
         pluma.Color:=cuadrocolor.Color;
     end;
end;

{
    Pinta el grafico escalado
}
procedure Tproyecto_graf.graficoPaint(Sender: TObject);
begin

     //grafico.Width:= proyecto_graf.Width-130;
     //grafico.Height:= proyecto_graf.Height-70;
end;

procedure Tproyecto_graf.lista_elementosClick(Sender: TObject);
var
    i : integer;
begin

     // limpiar el canvas
     grafico.canvas.Pen.Color:=Clblack;
     grafico.Canvas.Rectangle(0,0,grafico.Width,grafico.Height);

     {if imagen_actual. <> '' then begin
        imagen_actual.LoadFromFile(imagen_actual.GetNamePath);
     end;}

     // Recorrer los elementos y repintar
     for i:= 0 to contadorFiguras-1 do begin
         if i=lista_elementos.ItemIndex then begin
            grafico.Canvas.Pen.color := Clred;

         end;
     end;
end;

procedure Tproyecto_graf.opcionDDAClick(Sender: TObject);
begin
     activoDDA := true;
end;

procedure Tproyecto_graf.opcionBREClick(Sender: TObject);
begin
     activoDDA := false;
end;

procedure Tproyecto_graf.opcion_importarClick(Sender: TObject);
begin
     if dialogo_imagen.Execute then begin
        imagen_actual.LoadFromFile(dialogo_imagen.FileName);

        if dialogo_imagen.Width > grafico.Width then begin
           grafico.width := imagen_actual.Width;
        end;

        if dialogo_imagen.Height > grafico.Height then begin
           grafico.Height := imagen_actual.Height;
        end;
     end;
end;

 {  ---------- FUNCIONES DE CAMBIO DE VALOR SEGUN BOTON PULSADO --------- }

procedure Tproyecto_graf.boton_lineaClick(Sender: TObject);
begin
     valorOpcion := 1;

     contadorClicks     := 0;
     cantidadCoorFigura := 2;
end;

procedure Tproyecto_graf.boton_cuadradoClick(Sender: TObject);
begin
     valorOpcion := 2;

     contadorClicks     := 0;
     cantidadCoorFigura := 2;
end;

procedure Tproyecto_graf.boton_circuloClick(Sender: TObject);
begin
     valorOpcion := 3;

     contadorClicks     := 0;
     cantidadCoorFigura := 2;
end;

procedure Tproyecto_graf.boton_elipseClick(Sender: TObject);
begin
     valorOpcion := 4;

     contadorClicks     := 0;
     cantidadCoorFigura := 3;
end;

procedure Tproyecto_graf.boton_polilineaClick(Sender: TObject);
begin
     valorOpcion    := 5;
     contadorClicks := 0;
end;

procedure Tproyecto_graf.boton_reflejoClick(Sender: TObject);
begin
     valorOpcion    := 6;
     contadorClicks := 0;
end;
{  ---------- FUNCIONES PARA EL GRAFICADO DE LINEAS Y POLIGONOS --------- }

{
   Funcion que grafica una linea con el Algoritmo de DDA
}
procedure Tproyecto_graf.graficarLineaDDA(x1,y1,x2,y2 : integer);
var
   dx, dy, pasos, x, y, k: integer;
   xinc, yinc, xaux, yaux :real;
begin
     x    := x1;
     y    := y1;
     xaux := x1;
     yaux := y1;
     dx   := x2-x1;
     dy   := y2-y1;

     if Abs(dx) > Abs(dy) then begin
          pasos := Abs(dx);
     end else begin
          pasos := Abs(dy);
     end;

     xinc := dx/pasos;
     yinc := dy/pasos;

     for k:=1 to pasos+1 do begin
          grafico.Canvas.Pixels[x,y]:=pluma.Color;

          xaux := xaux + xinc;
          yaux := yaux + yinc;

          x := Round(xaux);
          y := Round(yaux);
     end;
end;   // FUNCION DDA

{
 	   Funcion que grafica una linea con el Algoritmo de Bresenham
}
procedure Tproyecto_graf.graficarLineaBresenham (x1,y1,x2,y2 : integer);
var
   aux_dx, aux_dy, dx, dy, pk, next_pk, x, y, next_y, next_x : integer;

   incx, incy : integer;
   m : real;
begin
     aux_dx := x2 - x1;
     aux_dy := y2 - y1;
     dx     := abs(aux_dx);
     dy     := abs(aux_dy);

     incx    := 0;
     incy    := 0;
     pk      := 0;
     next_pk := 0;
     m       := 0;

        if dx = 0 then begin // si no hay desplazamiento horizontal
           incx := 0;
           m    := 1;
           dx   := 1;
        end else begin       // si hay desplazamiento horizontal
        	 if aux_dx < 0 then begin // si la direccion de la recta va hacia la izq
                incx := -1;
                m    := dy / dx;
             end else begin           // si la direccion de la recta va hacia la derecha
                incx := 1;
                m    := dy / dx;
             end;
     	end;

        if dy = 0 then begin // si no hay desplazamiento vertical
           incy := 0;
           m    := 1;
        end else begin
        	 if aux_dy < 0 then begin // si la direccion de la recta va hacia abajo
                incy := -1;
                m    := dy / dx;
             end else begin           // si la direccion de la recta va hacia arriba
                incy := 1;
                m    := dy / dx;
             end;
        end;

     x:=x1;
     y:=y1;


       if m <= 1 then begin; // si la pendiente es menor / igual a 1
          pk := (2*dy) - dx;

          while x <> x2 do begin

               grafico.Canvas.Pixels[x,y] := pluma.Color;
               if pk >= 0 then begin // si el punto de decision es mayor o igual que 0
                  next_x := x+incx;
                  next_y := y+incy;
                  next_pk := pk + (2*dy) -(2*dx);
               end else begin        // si el punto de decision es menor que 0
                  next_x := x+incx;
        		  next_y := y;
                  next_pk := pk + (2*dy);
               end;

               x  := next_x;  // actualiza los valores
               y  := next_y;
               pk := next_pk;
          end;
     end else begin          // si la pendiente es mayor a 1
          pk := (2*dx) - dy;

          while y <> y2 do begin

               grafico.Canvas.Pixels[x,y] := pluma.Color;
               if pk >= 0 then begin
                  next_x  := x+incx;
                  next_y  := y+incy;
                  next_pk := pk + (2*dx) - (2*dy);
               end else begin
                  next_y  := y+incy;
                  next_x  := x;
                  next_pk := pk + (2*dx);
               end;

               x  := next_x;
               y  := next_y;
               pk := next_pk;
          end;
     end;
end;  // FUNCION BRESENHAM

{
 	Funcion para graficar el rectangulo
}
procedure Tproyecto_graf.graficarRectangulo(x1, y1, x2, y2: integer);
begin
     graficarLineaDDA(x1,y1,x2,y1);
     graficarLineaDDA(x1,y1,x1,y2);

     graficarLineaDDA(x2,y1,x2,y2);
     graficarLineaDDA(x1,y2,x2,y2);
end; // FUNCION RECTANGULO

{
 	 Funcion que grafica un Circulo
}
procedure Tproyecto_graf.graficarCirculo(x1,y1,x2,y2 : integer);
var
   DP, dx, dy: real;
   radio, x, y : integer;
begin

     dx := abs(x2-x1);
     dy := abs(y2-y1);

     // Encontra el Radio
     radio := round(sqrt( (dx*dx) + (dy*dy) ));

     // Calcular punto de desicion
     DP := 1.25-radio;

     x :=0;
     y :=radio;

     grafico.Canvas.Pixels[x,y] := pluma.Color;
     while y >= x   do begin

           // Se llamará a un procedimiento para graficar el punto en los diferentes octantes del circulo, en ese nuevo centro dado por el usuario
           graficarOctantes(x,y,x1,y1);

     	   if DP < 0 then begin
           	  x := x +1;
              y := y;
              DP := DP + (2*x) + 3;
           end else begin
              x := x+1;
              y := y-1;
              DP := DP + 2*(x-y) +5;
           end;
  	 end;
end;  // FUNCION CIRCULO

{
 	  Funcion que calcula los puntos en los octantes
}
procedure Tproyecto_graf.graficarOctantes(xk, yk, centroX, centroY : integer );
var
        posX, posY, negX, negY : integer;
begin


     posX := xk;
     posY := yk;
     negX := -xk;
     negY := -yk;

     grafico.Canvas.Pixels[posX +centroX,posY+centroY] := pluma.Color;
     grafico.Canvas.Pixels[posY +centroX,posX+centroY] := pluma.Color;
     grafico.Canvas.Pixels[posY +centroX,negX+centroY] := pluma.Color;
     grafico.Canvas.Pixels[posX +centroX,negY+centroY] := pluma.Color;

     grafico.Canvas.Pixels[negX +centroX,negY+centroY] := pluma.Color;
     grafico.Canvas.Pixels[negY +centroX,negX+centroY] := pluma.Color;
     grafico.Canvas.Pixels[negY +centroX,posX+centroY] := pluma.Color;
     grafico.Canvas.Pixels[negX +centroX,posY+centroY] := pluma.Color;

end; // FIN GRAFICAR OCTANTES

{
 	 Funcion para graficar una elipse
}
procedure Tproyecto_graf.graficarElipse(x1,y1,x2,y2,xc,yc : integer);
begin

end; // FUN GRAFICAR ELIPSE

{  ---------- PROCEDIMIENTOS PARA EL MANEJO DE ESTRUCTURAS --------- }



{ ##### ARREGLO DE FIGURAS CREADAS GLOBALES #####}

{
     Crea la Figura y la almacena en el arreglo de figuras creadas
}
function Tproyecto_graf.crearFigura( tipo, cantPuntos : integer ): figura;
var
   figuraAux : figura;
   coorAux : TCoordenada;
   i : integer;
begin

     figuraAux.tipo   := tipo;
     figuraAux.cantPuntos := cantPuntos;
     figuraAux.numero := contadorFiguras;
     figuraAux.color  := pluma.Color;
     figuraAux.estado := true;

     // Copiar Coordenadas
     for i:=0 to cantPuntos-1 do begin
         coorAux.X := coordenadasAux[i].X;
         coorAux.Y := coordenadasAux[i].Y;

         Setlength(figuraAux.Coordenadas, i+1 );
         figuraAux.Coordenadas[i] := coorAux;
     end;
     crearFigura := figuraAux;

end;


{
    Procedimiento para Graficar las figuras
}
procedure Tproyecto_graf.graficarFigura(  cantPuntos : integer; figura : figura  );
var
   i : integer;
   x1,y1,x2,y2 : integer;
begin
     // Se realizan las asignaciones para manejo claro de las 2 primeras figuras ( linea / cuadrado )
     x1 := figura.Coordenadas[0].X;
     y1 := figura.Coordenadas[0].Y;
     x2 := figura.Coordenadas[1].X;
     y2 := figura.Coordenadas[1].Y;

     if (x1 = x2) and ( y1 = y2) then begin // Si ambos puntos son iguales se graficara un punto
         grafico.Canvas.Pixels[x1,y1]:= pluma.Color;
     end else begin                         // Si los puntos no son iguales, se grafica el poligono segun su identificador
         case figura.tipo of
              1: begin // GRAFICACION DE LA LINEA
                  if activoDDA then begin // Si es verdad, se realiza la linea con el algoritmo DDA
                     graficarLineaDDA( x1, y1, x2, y2 );
                  end else begin          // Caso Contrario (false) , Se grafica la linea con el algoritmo de Bresenham
                     graficarLineaBresenham (x1, y1, x2, y2);
                  end; {-- fin linea --}

              end;

              2: begin // GRAFICACION DEL RECTANGULO
                  if ( x1 = x2 ) or ( y1 = y2 ) then begin // Si algun punto en horizontal o vertical es lo mismo, se dibuja una linea
                     graficarLineaDDA( x1, y1, x2, y2 );
                  end else begin                           // Si no se grafica un rectangulo normal
                     graficarRectangulo(x1, y1, x2, y2 );
                  end; {-- fin rectangulo --}
              end;

              3: begin // GRAFICACION DL CIRCULO
              	 if ( x1 = x2 ) or ( y1 = y2 ) then begin // Si algun punto en horizontal o vertical es lo mismo, se dibuja una linea
                     graficarLineaDDA( x1, y1, x2, y2 );
                  end else begin                           // Si no se grafica un circulo normal
                     graficarCirculo(x1, y1, x2, y2 );
                  end; {-- fin circulo --}
              end;
         end;
     end;
end;

{
    Procedimiento para agregar una figura al elemento ListBox
}
procedure Tproyecto_graf.agregarFiguraLista( figuraNueva : figura);
var
   nombre:String;
begin
     case figuraNueva.tipo of
          1: nombre := 'linea';
          2: nombre := 'rectangulo';
          3: nombre := 'circulo';
          4: nombre := 'elipse';
          5: nombre := 'polilinea';
     end;
     lista_elementos.Items.Add(nombre+'_'+inttostr(figuraNueva.numero) );
end;

end.


