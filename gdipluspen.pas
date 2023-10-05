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
type
  TBrush_ = class(gdiplusbrush.TBrush);
  TCustomLineCap_ = class(gdiplusheaders.TCustomLineCap);
  TMatrix_ = class(gdiplusmatrix.TMatrix);

  TPen = class(TGdiPlusBase)
  protected
    fNativePen:   PGpPen;
    fLastResult:  TStatus;
    constructor Create(NativePenArg: PGpPen; Status: TStatus); overload;
    procedure SetNativePen(NativePenArg: PGpPen); 
    Function SetStatus(Status: TStatus): TStatus; 
  public
    constructor Create(const Color: TColor; Width: REAL = 1.0); overload;
    constructor Create(Brush: TBrush_; Width: REAL = 1.0); overload;
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

    Function SetCustomStartCap(CustomCap: TCustomLineCap_): TStatus; 
    Function GetCustomStartCap(CustomCap: TCustomLineCap_): TStatus; 

    Function SetCustomEndCap(CustomCap: TCustomLineCap_): TStatus; 
    Function GetCustomEndCap(CustomCap: TCustomLineCap_): TStatus; 

    Function SetMiterLimit(MiterLimit: REAL): TStatus; 
    Function GetMiterLimit: REAL; 

    Function SetAlignment(PenAlignment: TPenAlignment): TStatus; 
    Function GetAlignment: TPenAlignment; 

    Function SetTransform(Matrix: TMatrix_): TStatus; 
    Function GetTransform(Matrix: TMatrix_): TStatus; 
    Function ResetTransform: TStatus; 

    Function MultiplyTransform(Matrix: TMatrix_; Order: TMatrixOrder = MatrixOrderPrepend): TStatus; 
    Function TranslateTransform(DX,DY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus; 
    Function ScaleTransform(SX,SY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus; 
    Function RotateTransform(Angle: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus; 

    Function GetPenType: TPenType; 
    Function SetColor(const Color: TColor): TStatus; 
    Function SetBrush(Brush: TBrush_): TStatus; 
    Function GetColor(Color: PColor): TStatus; 
    Function GetBrush: TBrush_; 

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

constructor TPen.Create(Brush: TBrush_; Width: REAL = 1.0);
var
  aUnit:  TUnit;
begin
inherited Create;
aUnit := UnitWorld;
fNativePen := nil;
fLastResult := GdipCreatePen2(Brush.fNativeBrush,Width,aUnit,@fNativePen);
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

Function TPen.SetCustomStartCap(CustomCap: TCustomLineCap_): TStatus;
var
  NativeCap:  PGpCustomLineCap;
begin
If Assigned(CustomCap) then
  NativeCap := CustomCap.fNativeCap
else
  NativeCap := nil;
Result := SetStatus(GdipSetPenCustomStartCap(fNativePen,NativeCap));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetCustomStartCap(CustomCap: TCustomLineCap_): TStatus;
begin
If Assigned(CustomCap) then
  Result := SetStatus(GdipGetPenCustomStartCap(fNativePen,Addr(CustomCap.fNativeCap)))
else
  Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TPen.SetCustomEndCap(CustomCap: TCustomLineCap_): TStatus;
var
  NativeCap:  PGpCustomLineCap;
begin
If Assigned(CustomCap) then
  NativeCap := CustomCap.fNativeCap
else
  NativeCap := nil;
Result := SetStatus(GdipSetPenCustomEndCap(fNativePen,NativeCap));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetCustomEndCap(CustomCap: TCustomLineCap_): TStatus;
begin
If Assigned(CustomCap) then
  Result := SetStatus(GdipGetPenCustomEndCap(fNativePen,Addr(CustomCap.fNativeCap)))
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

Function TPen.SetTransform(Matrix: TMatrix_): TStatus;
begin
Result := SetStatus(GdipSetPenTransform(fNativePen,Matrix.fNativeMatrix));
end;

//!!----------------------------------------------------------------------------

Function TPen.GetTransform(Matrix: TMatrix_): TStatus;
begin
Result := SetStatus(GdipGetPenTransform(fNativePen,Matrix.fNativeMatrix));
end;

//!!----------------------------------------------------------------------------

Function TPen.ResetTransform: TStatus;
begin
Result := SetStatus(GdipResetPenTransform(fNativePen));
end;

//!!----------------------------------------------------------------------------

Function TPen.MultiplyTransform(Matrix: TMatrix_; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipMultiplyPenTransform(fNativePen,Matrix.fNativeMatrix,Order));
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

Function TPen.SetBrush(Brush: TBrush_): TStatus;
begin
Result := SetStatus(GdipSetPenBrushFill(fNativePen,Brush.fNativeBrush));
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

Function TPen.GetBrush: TBrush_;
var
  NativeBrush:  PGpBrush;
begin
Result := nil;
case GetPenType of
  {$message 'remove typecasting when joining'}
  PenTypeSolidColor:      Result := TBrush_(TSolidBrush.Create);
  PenTypeHatchFill:       Result := TBrush_(THatchBrush.Create);
  PenTypeTextureFill:     Result := TBrush_(TTextureBrush.Create);
  PenTypePathGradient:    Result := TBrush_(TBrush.Create);
  PenTypeLinearGradient:  Result := TBrush_(TLinearGradientBrush.Create);
end;
If Assigned(Result) then
  begin
    SetStatus(GdipGetPenBrushFill(fNativePen,@NativeBrush));
    Result.SetNativeBrush(NativeBrush);
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
