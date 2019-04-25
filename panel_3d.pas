unit panel_3d;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, GLScene,
  GLCadencer, GLBehaviours, GLMaterial, GLSkydome, GLShadowVolume, GLExtrusion,
  GLViewer, GLObjects, GLPolyhedron, Types, GLBaseClasses;

type

  { Tformulario_3d }

  Tformulario_3d = class(TForm)
    cadencer: TGLCadencer;
    camara: TGLCamera;
    cubo1: TGLCube;
    luz: TGLLightSource;
    icosaedro3: TGLIcosahedron;
    icosaedro2: TGLIcosahedron;
    icosaedro: TGLIcosahedron;
    guia: TGLDummyCube;
    domo: TGLEarthSkyDome;
    material: TGLMaterialLibrary;
    plano: TGLPlane;
    escena: TGLScene;
    mostrador: TGLSceneViewer;
    sombra: TGLShadowVolume;
    reloj: TTimer;
    procedure cadencerProgress(Sender: TObject; const deltaTime, newTime: Double
      );
    procedure FormCreate(Sender: TObject);
    procedure icosaedro2Progress(Sender: TObject; const deltaTime,
      newTime: Double);
    procedure mostradorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mostradorMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure mostradorMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private

  public

  end;

var
  formulario_3d: Tformulario_3d;

  rotacionX, rotacionY :  integer; // variables para el control de rotación del panel

implementation

{$R *.frm}

{ Tformulario_3d }

procedure Tformulario_3d.mostradorMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
     camara.FocalLength:=camara.FocalLength+WheelDelta / 25;
end;

procedure Tformulario_3d.mostradorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // asignación de las variables para la rotacion
  rotacionX := X;
  rotacionY := Y;
end;

procedure Tformulario_3d.FormCreate(Sender: TObject);
begin
	 //icosaedro.Move(0.2);
end;

procedure Tformulario_3d.icosaedro2Progress(Sender: TObject; const deltaTime,
  newTime: Double);
begin
     icosaedro.Move(0.0002);
end;

procedure Tformulario_3d.cadencerProgress(Sender: TObject; const deltaTime,
  newTime: Double);
begin
     cubo1.TurnAngle:=newTime*5;

     icosaedro2.Position.X:= 0.5;
     icosaedro2.Position.Y:= 0.00000000001;
end;

procedure Tformulario_3d.mostradorMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
	 if shift=[ssLeft] then begin
     	camara.MoveAroundTarget(rotacionY-Y, rotacionX-X);
     end;

     rotacionX := X;
     rotacionY := Y;
end;

end.

