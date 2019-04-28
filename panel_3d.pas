unit panel_3d;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, GLScene,
  GLCadencer, GLBehaviours, GLMaterial, GLSkydome, GLShadowVolume, GLExtrusion,
  GLWaterPlane, GLViewer, GLObjects, GLPolyhedron, Types, GLBaseClasses,
  GLGeomObjects;

type

  { Tformulario_3d }

  Tformulario_3d = class(TForm)
    cadencer: TGLCadencer;
    camara: TGLCamera;
    edificio1: TGLCube;
    edicio1_container: TGLDummyCube;
    edificio2_container: TGLDummyCube;
    edificio2: TGLCube;
    escalon1: TGLCube;
    escalon2: TGLCube;
    escalon3: TGLCube;
    escalon4: TGLCube;
    escalon5: TGLCube;
    escalon6: TGLCube;
    escalon7: TGLCube;
    escalon8: TGLCube;
    agua: TGLPlane;
    GLWaterPlane1: TGLWaterPlane;
    molino: TGLTorus;
    molino_agua: TGLDummyCube;
    edificio2_techo: TGLFrustrum;
    techo_edificio1: TGLFrustrum;
    luz: TGLLightSource;
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
    procedure mostradorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mostradorMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure mostradorMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure relojTimer(Sender: TObject);
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

procedure Tformulario_3d.relojTimer(Sender: TObject);
begin
     //reloj.Interval:=2000;
     //molino_agua.RollAngle:=360;
end;

procedure Tformulario_3d.mostradorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // asignación de las variables para la rotacion
  rotacionX := X;
  rotacionY := Y;
end;

procedure Tformulario_3d.cadencerProgress(Sender: TObject; const deltaTime,
  newTime: Double);
begin
     molino_agua.RollAngle:=molino_agua.RollAngle+0.1;
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

