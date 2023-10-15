(**************************************************************************\
* 
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusPen.h
*
* Abstract:
*
*   GDI+ Pen class
*
\**************************************************************************)
unit gdipluspen;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  gdiplus_common,
  gdiplusbase, gdiplustypes, gdiplusgpstubs, gdipluscolor, gdiplusbrush,
  gdiplusenums, gdiplusheaders, gdiplusmatrix;

//--------------------------------------------------------------------------
// Pen class
//--------------------------------------------------------------------------
{!!=============================================================================
    TPen - class declaration
===============================================================================}
type
  TPen = class(TGdiPlusBase)
  protected
    fNativePen:   PGpPen;
    fLastResult:  TStatus;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
    constructor Create(NativePenArg: PGpPen; Status: TStatus); overload;
    procedure SetNativePen(NativePenArg: PGpPen); 
    Function SetStatus(Status: TStatus): TStatus; 
  public
    constructor Create(const Color: TColor; Width: REAL = 1.0); overload;
    constructor Create(Brush: TBrush; Width: REAL = 1.0); overload;
    destructor Destroy; override;
    Function Clone: TPen;
    Function SetWidth(Width: REAL): TStatus; 
    Function GetWidht: REAL;
    // Set/get line caps: start, end, and dash
    // Line cap and join APIs by using LineCap and LineJoin enums.
    Function SetLineCap(StartCap,EndCap: TLineCap; DashCap: TDashCap): TStatus; 
    Function SetStartCap(StartCap: TLineCap): TStatus; 
    Function SetEndCap(EndCap: TLineCap): TStatus; 
    Function SetDashCap(DashCap: TDashCap): TStatus; 
    Function GetStartCap: TLineCap; 
    Function GetEndCap: TLineCap; 
    Function GetDashCap: TDashCap;
    Function SetLineJoin(LineJoin: TLineJoin): TStatus; 
    Function GetLineJoin: TLineJoin;
    Function SetCustomStartCap(CustomCap: TCustomLineCap): TStatus; 
    Function GetCustomStartCap(CustomCap: TCustomLineCap): TStatus;
    Function SetCustomEndCap(CustomCap: TCustomLineCap): TStatus; 
    Function GetCustomEndCap(CustomCap: TCustomLineCap): TStatus;
    Function SetMiterLimit(MiterLimit: REAL): TStatus; 
    Function GetMiterLimit: REAL;
    Function SetAlignment(PenAlignment: TPenAlignment): TStatus; 
    Function GetAlignment: TPenAlignment;
    Function SetTransform(Matrix: TMatrix): TStatus; 
    Function GetTransform(Matrix: TMatrix): TStatus; 
    Function ResetTransform: TStatus;
    Function MultiplyTransform(Matrix: TMatrix; Order: TMatrixOrder = MatrixOrderPrepend): TStatus; 
    Function TranslateTransform(DX,DY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus; 
    Function ScaleTransform(SX,SY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus; 
    Function RotateTransform(Angle: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
    Function GetPenType: TPenType; 
    Function SetColor(const Color: TColor): TStatus; 
    Function SetBrush(Brush: TBrush): TStatus; 
    Function GetColor(Color: PColor): TStatus; 
    Function GetBrush: TBrush;
    Function GetDashStyle: TDashStyle; 
    Function SetDashStyle(DashStyle: TDashStyle): TStatus;
    Function GetDashOffset: REAL; 
    Function SetDashOffset(DashOffset: REAL): TStatus;
    Function SetDashPattern(DashArray: PREAL; Count: INT): TStatus; 
    Function GetDashPatternCount: INT; 
    Function GetDashPattern(DashArray: PREAL; Count: INT): TStatus;
    Function SetCompoundArray(CompoundArray: PREAL; Count: INT): TStatus; 
    Function GetCompoundArrayCount: INT; 
    Function GetCompoundArray(CompoundArray: PREAL; Count: INT): TStatus;  
    Function GetLastStatus: TStatus; 
  end;

implementation

uses
  gdiplusflat, gdipluspixelformats;

{!!=============================================================================
    TPen - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TPen - protected methods
-------------------------------------------------------------------------------}

Function TPen.GetNativeObject: Pointer;
begin
Result := fNativePen;
end;

//!!----------------------------------------------------------------------------

Function TPen.GetNativeObjectAddr: Pointer;
begin
Result := Addr(fNativePen);
end;

//!!----------------------------------------------------------------------------

constructor TPen.Create(NativePenArg: PGpPen; Status: TStatus);
begin
inherited Create;
fLastResult := Status;
SetNativePen(NativePenArg);
end;

//!!----------------------------------------------------------------------------

procedure TPen.SetNativePen(NativePenArg: PGpPen);
begin
fNativePen := NativePenArg;
end;

//!!----------------------------------------------------------------------------

Function TPen.SetStatus(Status: TStatus): TStatus;
begin
If Status <> Ok then
  fLastResult := Status;
Result := Status;
end;

{!!-----------------------------------------------------------------------------
    TPen - public methods
-------------------------------------------------------------------------------}

constructor TPen.Create(const Color: TColor; Width: REAL = 1.0);
var
  aUnit:  TUnit;
begin
inherited Create;
aUnit := UnitWorld;
fNativePen := nil;
fLastResult := GdipCreatePen1(GetValue(Color),Width,aUnit,@fNativePen);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TPen.Create(Brush: TBrush; Width: REAL = 1.0);
var
  aUnit:  TUnit;
begin
inherited Create;
aUnit := UnitWorld;
fNativePen := nil;
fLastResult := GdipCreatePen2(Brush.NativeObject,Width,aUnit,@fNativePen);
end;

//!!----------------------------------------------------------------------------

destructor TPen.Destroy;
begin
GdipDeletePen(fNativePen);
inherited;
end;

//!!----------------------------------------------------------------------------

Function TPen.Clone: TPen;
var
  ClonePen: PGpPen;
begin
ClonePen := nil;
fLastResult := GdipClonePen(fNativePen,@ClonePen);
Result := TPen.Create(ClonePen,fLastResult);
end;

//!!----------------------------------------------------------------------------

Function TPen.SetWidth(Width: REAL): TStatus;
begin
Result := SetStatus(GdipSetPenWidth(fNativePen,Width));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetWidht: REAL;
begin
SetStatus(GdipGetPenWidth(fNativePen,@Result));
end;

//!!----------------------------------------------------------------------------

Function TPen.SetLineCap(StartCap,EndCap: TLineCap; DashCap: TDashCap): TStatus;
begin
Result := SetStatus(GdipSetPenLineCap197819(fNativePen,StartCap,EndCap,DashCap));
end;

//!!----------------------------------------------------------------------------

Function TPen.SetStartCap(StartCap: TLineCap): TStatus;
begin
Result := SetStatus(GdipSetPenStartCap(fNativePen,StartCap));
end;

//!!----------------------------------------------------------------------------

Function TPen.SetEndCap(EndCap: TLineCap): TStatus;
begin
Result := SetStatus(GdipSetPenEndCap(fNativePen,EndCap));
end;

//!!----------------------------------------------------------------------------

Function TPen.SetDashCap(DashCap: TDashCap): TStatus;
begin
Result := SetStatus(GdipSetPenDashCap197819(fNativePen,DashCap));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetStartCap: TLineCap;
begin
SetStatus(GdipGetPenStartCap(fNativePen,@Result));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetEndCap: TLineCap;
begin
SetStatus(GdipGetPenEndCap(fNativePen,@Result));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetDashCap: TDashCap;
begin
SetStatus(GdipGetPenDashCap197819(fNativePen,@Result));
end;

//!!----------------------------------------------------------------------------

Function TPen.SetLineJoin(LineJoin: TLineJoin): TStatus;
begin
Result := SetStatus(GdipSetPenLineJoin(fNativePen,LineJoin));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetLineJoin: TLineJoin;
begin
SetStatus(GdipGetPenLineJoin(fNativePen,@Result));
end;

//!!----------------------------------------------------------------------------

Function TPen.SetCustomStartCap(CustomCap: TCustomLineCap): TStatus;
begin
Result := SetStatus(GdipSetPenCustomStartCap(fNativePen,CustomCap.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetCustomStartCap(CustomCap: TCustomLineCap): TStatus;
begin
If Assigned(CustomCap) then
  Result := SetStatus(GdipGetPenCustomStartCap(fNativePen,CustomCap.NativeObjectAddr))
else
  Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TPen.SetCustomEndCap(CustomCap: TCustomLineCap): TStatus;
begin
Result := SetStatus(GdipSetPenCustomEndCap(fNativePen,CustomCap.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetCustomEndCap(CustomCap: TCustomLineCap): TStatus;
begin
If Assigned(CustomCap) then
  Result := SetStatus(GdipGetPenCustomEndCap(fNativePen,CustomCap.NativeObjectAddr))
else
  Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TPen.SetMiterLimit(MiterLimit: REAL): TStatus;
begin
Result := SetStatus(GdipSetPenMiterLimit(fNativePen,MiterLimit));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetMiterLimit: REAL;
begin
SetStatus(GdipGetPenMiterLimit(fNativePen,@Result));
end;

//!!----------------------------------------------------------------------------

Function TPen.SetAlignment(PenAlignment: TPenAlignment): TStatus;
begin
Result := SetStatus(GdipSetPenMode(fNativePen,PenAlignment));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetAlignment: TPenAlignment;
begin
SetStatus(GdipGetPenMode(fNativePen,@Result));
end;

//!!----------------------------------------------------------------------------

Function TPen.SetTransform(Matrix: TMatrix): TStatus;
begin
Result := SetStatus(GdipSetPenTransform(fNativePen,Matrix.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetTransform(Matrix: TMatrix): TStatus;
begin
Result := SetStatus(GdipGetPenTransform(fNativePen,Matrix.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TPen.ResetTransform: TStatus;
begin
Result := SetStatus(GdipResetPenTransform(fNativePen));
end;

//!!----------------------------------------------------------------------------

Function TPen.MultiplyTransform(Matrix: TMatrix; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipMultiplyPenTransform(fNativePen,Matrix.NativeObject,Order));
end;

//!!----------------------------------------------------------------------------

Function TPen.TranslateTransform(DX,DY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipTranslatePenTransform(fNativePen,DX,DY,Order));
end;

//!!----------------------------------------------------------------------------

Function TPen.ScaleTransform(SX,SY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipScalePenTransform(fNativePen,SX,SY,Order));
end;

//!!----------------------------------------------------------------------------

Function TPen.RotateTransform(Angle: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipRotatePenTransform(fNativePen,Angle,Order));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetPenType: TPenType;
begin
SetStatus(GdipGetPenFillType(fNativePen,@Result));
end;

//!!----------------------------------------------------------------------------

Function TPen.SetColor(const Color: TColor): TStatus;
begin
Result := SetStatus(GdipSetPenColor(fNativePen,GetValue(Color)));
end;

//!!----------------------------------------------------------------------------

Function TPen.SetBrush(Brush: TBrush): TStatus;
begin
Result := SetStatus(GdipSetPenBrushFill(fNativePen,Brush.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetColor(Color: PColor): TStatus;
var
  Argb: TARGB;
begin
If Assigned(Color) then
  begin
    If GetPenType = PenTypeSolidColor then
      begin
        SetStatus(GdipGetPenColor(fNativePen,@Argb));
        If fLastResult = Ok then
          Color^ := gdipluscolor.Color(Argb);
        Result := fLastResult;
      end
    else Result := WrongState;
  end
else Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

type
  //!! following is here only to expose protected method SetNativeBrush
  TBrush_ = class(TBrush);  {$message 'remove when joining'} 

Function TPen.GetBrush: TBrush;
var
  NativeBrush:  PGpBrush;
begin
Result := nil;
case GetPenType of
  PenTypeSolidColor:      Result := TSolidBrush.Create;
  PenTypeHatchFill:       Result := THatchBrush.Create;
  PenTypeTextureFill:     Result := TTextureBrush.Create;
  PenTypePathGradient:    Result := TBrush.Create;
  PenTypeLinearGradient:  Result := TLinearGradientBrush.Create;
end;
If Assigned(Result) then
  begin
    SetStatus(GdipGetPenBrushFill(fNativePen,@NativeBrush));
    TBrush_(Result).SetNativeBrush(NativeBrush);
  end;
end;

//!!----------------------------------------------------------------------------

Function TPen.GetDashStyle: TDashStyle;
begin
SetStatus(GdipGetPenDashStyle(fNativePen,@Result));
end;

//!!----------------------------------------------------------------------------

Function TPen.SetDashStyle(DashStyle: TDashStyle): TStatus;
begin
Result := SetStatus(GdipSetPenDashStyle(fNativePen,DashStyle));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetDashOffset: REAL;
begin
SetStatus(GdipGetPenDashOffset(fNativePen,@Result));
end;

//!!----------------------------------------------------------------------------

Function TPen.SetDashOffset(DashOffset: REAL): TStatus;
begin
Result := SetStatus(GdipSetPenDashOffset(fNativePen,DashOffset));
end;

//!!----------------------------------------------------------------------------

Function TPen.SetDashPattern(DashArray: PREAL; Count: INT): TStatus;
begin
Result := SetStatus(GdipSetPenDashArray(fNativePen,DashArray,Count));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetDashPatternCount: INT;
begin
Result := 0;
SetStatus(GdipGetPenDashCount(fNativePen,@Result));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetDashPattern(DashArray: PREAL; Count: INT): TStatus;
begin
If Assigned(DashArray) and (Count > 0) then
  Result := SetStatus(GdipGetPenDashArray(fNativePen,DashArray,Count))
else
  Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TPen.SetCompoundArray(CompoundArray: PREAL; Count: INT): TStatus;
begin
Result := SetStatus(GdipSetPenCompoundArray(fNativePen,CompoundArray,Count));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetCompoundArrayCount: INT;
begin
SetStatus(GdipGetPenCompoundCount(fNativePen,@Result));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetCompoundArray(CompoundArray: PREAL; Count: INT): TStatus;
begin
If Assigned(CompoundArray) and (Count > 0) then
  Result := SetStatus(GdipGetPenCompoundArray(fNativePen,CompoundArray,Count))
else
  Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TPen.GetLastStatus: TStatus;
begin
Result := fLastResult;
fLastResult := Ok;
end;

end.
