(**************************************************************************\
* 
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusMatrix.h
*
* Abstract:
*
*   GDI+ Matrix class
*
\**************************************************************************)
unit gdiplusmatrix;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  gdiplus_common, gdiplusbase, gdiplusgpstubs, gdiplustypes, gdiplusenums;

{!!=============================================================================
    TMatrix - class declaration
===============================================================================}
type
  TMatrix = class(TGdiPlusBase)
  protected
    fNativeMatrix:  PGpMatrix;
    fLastResult:    TStatus;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
    constructor Create(NativeMatrixArg: PGpMatrix); overload;
    procedure SetNativeMatrix(NativeMatrixArg: PGpMatrix); 
    Function SetStatus(Status: TStatus): TStatus; 
  public
    // Default constructor is set to identity matrix.
    constructor Create; overload;
    constructor Create(M11,M12,M21,M22,DX,DY: REAL); overload;
    constructor Create(const Rect: TRectF; const DstPlg: TPointF); overload;
    constructor Create(const Rect: TRect; const DstPlg: TPoint); overload;
    destructor Destroy; override;
    Function Clone: TMatrix;
    Function GetElements(M: PREAL): TStatus; 
    Function SetElements(M11,M12,M21,M22,DX,DY: REAL): TStatus;
    Function OffsetX: REAL; 
    Function OffsetY: REAL;
    Function Reset: TStatus; 
    Function Multiply(Matrix: TMatrix; Order: TMatrixOrder = MatrixOrderPrepend): TStatus; 
    Function Translate(OffsetX,OffsetY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus; 
    Function Scale(ScaleX,ScaleY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus; 
    Function Rotate(Angle: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus; 
    Function RotateAt(Angle: REAL; const Center: TPointF; Order: TMatrixOrder = MatrixOrderPrepend): TStatus; 
    Function Shear(ShearX,ShearY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus; 
    Function Invert: TStatus;
    // float version
    Function TransformPoints(Pts: PPointF; Count: INT = 1): TStatus; overload; 
    Function TransformPoints(Pts: PPoint; Count: INT = 1): TStatus; overload; 
    Function TransformVectors(Pts: PPointF; Count: INT = 1): TStatus; overload; 
    Function TransformVectors(Pts: PPoint; Count: INT = 1): TStatus; overload;
    Function IsInvertible: BOOL; 
    Function IsIdentity: BOOL;
    Function Equals(Matrix: TMatrix): BOOL; 
    Function GetLastStatus: TStatus; 
  end;

implementation

uses
  gdiplusflat;

{!!=============================================================================
    TMatrix - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TMatrix - protected methods
-------------------------------------------------------------------------------}

Function TMatrix.GetNativeObject: Pointer;
begin
Result := fNativeMatrix;
end;

//!!----------------------------------------------------------------------------

Function TMatrix.GetNativeObjectAddr: Pointer;
begin
Result := Addr(fNativeMatrix);
end;

//!!----------------------------------------------------------------------------

constructor TMatrix.Create(NativeMatrixArg: PGpMatrix);
begin
inherited Create;
fLastResult := Ok;
SetNativeMatrix(NativeMatrixArg);
end;

//!!----------------------------------------------------------------------------

procedure TMatrix.SetNativeMatrix(NativeMatrixArg: PGpMatrix);
begin
fNativeMatrix := NativeMatrixArg;
end;

//!!----------------------------------------------------------------------------

Function TMatrix.SetStatus(Status: TStatus): TStatus;
begin
If Status <> Ok then
  fLastResult := Status;
Result := Status;
end;

{!!-----------------------------------------------------------------------------
    TMatrix - public methods
-------------------------------------------------------------------------------}

constructor TMatrix.Create;
var
  Matrix: PGpMatrix;
begin
inherited Create;
Matrix := nil;
fLastResult := GdipCreateMatrix(@Matrix);
SetNativeMatrix(Matrix);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMatrix.Create(M11,M12,M21,M22,DX,DY: REAL);
var
  Matrix: PGpMatrix;
begin
inherited Create;
Matrix := nil;
fLastResult := GdipCreateMatrix2(M11,M12,M21,M22,DX,DY,@Matrix);
SetNativeMatrix(Matrix);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMatrix.Create(const Rect: TRectF; const DstPlg: TPointF);
var
  Matrix: PGpMatrix;
begin
inherited Create;
Matrix := nil;
fLastResult := GdipCreateMatrix3(@Rect,@DstPlg,@Matrix);
SetNativeMatrix(Matrix);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMatrix.Create(const Rect: TRect; const DstPlg: TPoint);
var
  Matrix: PGpMatrix;
begin
inherited Create;
Matrix := nil;
fLastResult := GdipCreateMatrix3I(@Rect,@DstPlg,@Matrix);
SetNativeMatrix(Matrix);
end;

//!!----------------------------------------------------------------------------

destructor TMatrix.Destroy;
begin
GdipDeleteMatrix(fNativeMatrix);
inherited;
end;

//!!----------------------------------------------------------------------------

Function TMatrix.Clone: TMatrix;
var
  CloneMatrix:  PGpMatrix;
begin
SetStatus(GdipCloneMatrix(fNativeMatrix,@CloneMatrix));
If fLastResult = Ok then
  Result := TMatrix.Create(CloneMatrix)
else
  Result := nil;
end;

//!!----------------------------------------------------------------------------

Function TMatrix.GetElements(M: PREAL): TStatus;
begin
Result := SetStatus(GdipGetMatrixElements(fNativeMatrix,M));
end;

//!!----------------------------------------------------------------------------

Function TMatrix.SetElements(M11,M12,M21,M22,DX,DY: REAL): TStatus;
begin
Result := SetStatus(GdipSetMatrixElements(fNativeMatrix,M11,M12,M21,M22,DX,DY));
end;

//!!----------------------------------------------------------------------------

Function TMatrix.OffsetX: REAL;
var
  Elements: array[0..5] of REAL;
begin
If GetElements(Addr(Elements[0])) = Ok then
  Result := Elements[4]
else
  Result := 0.0;
end;

//!!----------------------------------------------------------------------------

Function TMatrix.OffsetY: REAL;
var
  Elements: array[0..5] of REAL;
begin
If GetElements(Addr(Elements[0])) = Ok then
  Result := Elements[5]
else
  Result := 0.0;
end;

//!!----------------------------------------------------------------------------

Function TMatrix.Reset: TStatus;
begin
// set identity matrix elements
Result := SetStatus(GdipSetMatrixElements(fNativeMatrix,1.0,0.0,0.0,1.0,0.0,0.0));
end;

//!!----------------------------------------------------------------------------

Function TMatrix.Multiply(Matrix: TMatrix; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipMultiplyMatrix(fNativeMatrix,Matrix.NativeObject,Order));
end;

//!!----------------------------------------------------------------------------

Function TMatrix.Translate(OffsetX,OffsetY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipTranslateMatrix(fNativeMatrix,OffsetX,OffsetY,Order));
end;

//!!----------------------------------------------------------------------------

Function TMatrix.Scale(ScaleX,ScaleY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipScaleMatrix(fNativeMatrix,ScaleX,ScaleY,Order));
end;

//!!----------------------------------------------------------------------------

Function TMatrix.Rotate(Angle: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipRotateMatrix(fNativeMatrix,Angle,Order));
end;

//!!----------------------------------------------------------------------------

Function TMatrix.RotateAt(Angle: REAL; const Center: TPointF; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
If Order = MatrixOrderPrepend then
  begin
    SetStatus(GdipTranslateMatrix(fNativeMatrix,Center.X,Center.Y,Order));
    SetStatus(GdipRotateMatrix(fNativeMatrix,Angle,Order));
    Result := SetStatus(GdipTranslateMatrix(fNativeMatrix,-Center.X,-Center.Y,Order));
  end
else
  begin
    SetStatus(GdipTranslateMatrix(fNativeMatrix,-Center.X,-Center.Y,Order));
    SetStatus(GdipRotateMatrix(fNativeMatrix,Angle,Order));
    Result := SetStatus(GdipTranslateMatrix(fNativeMatrix,Center.X,Center.Y,Order));
  end;
end;

//!!----------------------------------------------------------------------------

Function TMatrix.Shear(ShearX,ShearY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipShearMatrix(fNativeMatrix,ShearX,ShearY,Order));
end;

//!!----------------------------------------------------------------------------

Function TMatrix.Invert: TStatus;
begin
Result := SetStatus(GdipInvertMatrix(fNativeMatrix));
end;

//!!----------------------------------------------------------------------------

Function TMatrix.TransformPoints(Pts: PPointF; Count: INT = 1): TStatus;
begin
Result := SetStatus(GdipTransformMatrixPoints(fNativeMatrix,PGpPointF(Pts),Count));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TMatrix.TransformPoints(Pts: PPoint; Count: INT = 1): TStatus;
begin
Result := SetStatus(GdipTransformMatrixPointsI(fNativeMatrix,PGpPoint(Pts),Count));
end;

//!!----------------------------------------------------------------------------

Function TMatrix.TransformVectors(Pts: PPointF; Count: INT = 1): TStatus;
begin
Result := SetStatus(GdipVectorTransformMatrixPoints(fNativeMatrix,PGpPointF(Pts),Count));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TMatrix.TransformVectors(Pts: PPoint; Count: INT = 1): TStatus;
begin
Result := SetStatus(GdipVectorTransformMatrixPointsI(fNativeMatrix,PGpPoint(Pts),Count));
end;

//!!----------------------------------------------------------------------------

Function TMatrix.IsInvertible: BOOL;
begin
Result := False;
SetStatus(GdipIsMatrixInvertible(fNativeMatrix,@Result));
end;

//!!----------------------------------------------------------------------------

Function TMatrix.IsIdentity: BOOL;
begin
Result := False;
SetStatus(GdipIsMatrixIdentity(fNativeMatrix,@Result));
end;

//!!----------------------------------------------------------------------------

Function TMatrix.Equals(Matrix: TMatrix): BOOL;
begin
Result := False;
SetStatus(GdipIsMatrixEqual(fNativeMatrix,Matrix.NativeObject,@Result));
end;

//!!----------------------------------------------------------------------------

Function TMatrix.GetLastStatus: TStatus;
begin
Result := fLastResult;
fLastResult := Ok;
end;

end.
