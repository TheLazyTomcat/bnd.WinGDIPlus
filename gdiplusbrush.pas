(**************************************************************************\
* 
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusBrush.h
*
* Abstract:
*
*   GDI+ Brush class
*
\**************************************************************************)
unit gdiplusbrush;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  gdiplus_common, gdiplusbase, gdiplusenums, gdiplustypes, gdiplusgpstubs,
  gdipluscolor, gdiplusmatrix, gdiplusheaders, gdiplusimageattributes;

{!!=============================================================================
    TBrush - class declaration
===============================================================================}
//--------------------------------------------------------------------------
// Abstract base class for various brush types
//--------------------------------------------------------------------------
type
  TBrush = class(TGdiPlusBase)
  protected
    fNativeBrush: PGpBrush;
    fLastResult:  TStatus;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
    constructor Create; overload;
    constructor Create(NativeBrushArg: PGpBrush; Status: TStatus); overload;
    procedure SetNativeBrush(NativeBrushArg: PGpBrush); 
    Function SetStatus(Status: TStatus): TStatus; 
  public
    destructor Destroy; override;
    Function Clone: TBrush;
    Function GetType: TBrushType;
    Function GetLastStatus: TStatus; 
  end;

{!!=============================================================================
    TSolidBrush - class declaration
===============================================================================}
//--------------------------------------------------------------------------
// Solid Fill Brush Object
//--------------------------------------------------------------------------
type
  TSolidBrush = class(TBrush)
  public
    constructor Create(const Color: TColor); overload;
    Function GetColor(Color: PColor): TStatus; 
    Function SetColor(const Color: TColor): TStatus; 
  end;

{!!=============================================================================
    TTextureBrush - class declaration
===============================================================================}
//--------------------------------------------------------------------------
// Texture Brush Fill Object
//--------------------------------------------------------------------------
type
  TTextureBrush = class(TBrush)
  public
    constructor Create(Image: TImage; WrapMode: TWrapMode = WrapModeTile); overload;
    // When creating a texture brush from a metafile image, the dstRect
    // is used to specify the size that the metafile image should be
    // rendered at in the device units of the destination graphics.
    // It is NOT used to crop the metafile image, so only the width
    // and height values matter for metafiles.
    constructor Create(Image: TImage; WrapMode: TWrapMode; const DstRect: TRectF); overload;
    constructor Create(Image: TImage; const DstRect: TRectF; ImageAttributes: TImageAttributes = nil); overload;
    constructor Create(Image: TImage; const DstRect: TRect; ImageAttributes: TImageAttributes = nil); overload;
    constructor Create(Image: TImage; WrapMode: TWrapMode; const DstRect: TRect); overload;
    constructor Create(Image: TImage; WrapMode: TWrapMode; DstX,DstY,DstWidth,DstHeight: REAL); overload;
    constructor Create(Image: TImage; WrapMode: TWrapMode; DstX,DstY,DstWidth,DstHeight: INT); overload;
    Function SetTransform(Matrix: TMatrix): TStatus;
    Function GetTransform(Matrix: TMatrix): TStatus;
    Function ResetTransform: TStatus;
    Function MultiplyTransform(Matrix: TMatrix; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
    Function TranslateTransform(DX,DY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
    Function ScaleTransform(SX,SY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus; 
    Function RotateTransform(Angle: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
    Function SetWrapMode(WrapMode: TWrapMode): TStatus; 
    Function GetWrapMode: TWrapMode;
    Function GetImage: TImage;
  end;

{!!=============================================================================
    TLinearGradientBrush - class declaration
===============================================================================}
//--------------------------------------------------------------------------
// Linear Gradient Brush Object
//--------------------------------------------------------------------------
type
  TLinearGradientBrush = class(TBrush)
  public
    constructor Create(const Point1,Point2: TPointF; const Color1,Color2: TColor); overload;
    constructor Create(const Point1,Point2: TPoint; const Color1,Color2: TColor); overload;
    constructor Create(const Rect: TRectF; const Color1,Color2: TColor; Mode: TLinearGradientMode); overload;
    constructor Create(const Rect: TRect; const Color1,Color2: TColor; Mode: TLinearGradientMode); overload;
    constructor Create(const Rect: TRectF; const Color1,Color2: TColor; Angle: REAL; IsAngleScalable: BOOL = False); overload;
    constructor Create(const Rect: TRect; const Color1,Color2: TColor; Angle: REAL; IsAngleScalable: BOOL = False); overload;
    Function SetLinearColors(const Color1,Color2: TColor): TStatus; 
    Function GetLinearColors(Colors: PColor): TStatus;
    Function GetRectangle(Rect: PRectF): TStatus; overload; 
    Function GetRectangle(Rect: PRect): TStatus; overload;
    Function SetGammaCorrection(UseGammaCorrection: BOOL): TStatus; 
    Function GetGammaCorrection: BOOL;
    Function GetBlendCount: INT; 
    Function SetBlend(BlendFactors,BlendPositions: PREAL; Count: INT): TStatus; 
    Function GetBlend(BlendFactors,BlendPositions: PREAL; Count: INT): TStatus;
    Function GetInterpolationColorCount: INT; 
    Function SetInterpolationColors(PresetColors: PColor; BlendPositions: PREAL; Count: INT): TStatus; 
    Function GetInterpolationColors(PresetColors: PColor; BlendPositions: PREAL; Count: INT): TStatus;
    Function SetBlendBellShape(Focus: REAL; Scale: REAL = 1.0): TStatus; 
    Function SetBlendTriangularShape(Focus: REAL; Scale: REAL = 1.0): TStatus;
    Function SetTransform(Matrix: TMatrix): TStatus;
    Function GetTransform(Matrix: TMatrix): TStatus;
    Function ResetTransform: TStatus;
    Function MultiplyTransform(Matrix: TMatrix; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
    Function TranslateTransform(DX,DY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus; 
    Function ScaleTransform(SX,SY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus; 
    Function RotateTransform(Angle: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
    Function SetWrapMode(WrapMode: TWrapMode): TStatus; 
    Function GetWrapMode: TWrapMode; 
  end;

//--------------------------------------------------------------------------
// PathGradientBrush object is defined
// in gdipluspath.h.
//--------------------------------------------------------------------------

{!!=============================================================================
    THatchBrush - class declaration
===============================================================================}
//--------------------------------------------------------------------------
// Hatch Brush Object
//--------------------------------------------------------------------------
type
  THatchBrush = class(TBrush)
  public
    constructor Create(HatchStyle: THatchStyle; const ForeColor,BackColor: TColor); overload;
    constructor Create(HatchStyle: THatchStyle; const ForeColor: TColor); overload;  
    Function GetHatchStyle: THatchStyle; 
    Function GetForegroundColor(Color: PColor): TStatus; 
    Function GetBackgroundColor(Color: PColor): TStatus; 
  end;

implementation

uses
  gdiplusflat, gdipluspixelformats;

{!!=============================================================================
    TBrush - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TBrush - protected methods
-------------------------------------------------------------------------------}

Function TBrush.GetNativeObject: Pointer;
begin
Result := fNativeBrush;
end;

//!!----------------------------------------------------------------------------

Function TBrush.GetNativeObjectAddr: Pointer;
begin
Result := Addr(fNativeBrush);
end;

//!!----------------------------------------------------------------------------

constructor TBrush.Create;
begin
inherited Create;
SetStatus(NotImplemented);
end;

//!!----------------------------------------------------------------------------

constructor TBrush.Create(NativeBrushArg: PGpBrush; Status: TStatus);
begin
inherited Create;
fLastResult := Status;
SetNativeBrush(NativeBrushArg);
end;

//!!----------------------------------------------------------------------------

procedure TBrush.SetNativeBrush(NativeBrushArg: PGpBrush);
begin
fNativeBrush := NativeBrushArg;
end;

//!!----------------------------------------------------------------------------

Function TBrush.SetStatus(Status: TStatus): TStatus;
begin
If Status <> Ok then
  fLastResult := Status;
Result := Status;
end;

{!!-----------------------------------------------------------------------------
    TBrush - public methods
-------------------------------------------------------------------------------}

destructor TBrush.Destroy;
begin
GdipDeleteBrush(fNativeBrush);
inherited;
end;

//!!----------------------------------------------------------------------------

Function TBrush.Clone: TBrush;
var
  Brush:  PGpBrush;
begin
Brush := nil;
SetStatus(GdipCloneBrush(fNativeBrush,@Brush));
Result := TBrush.Create(Brush,fLastResult);
If not Assigned(Result) then
  GdipDeleteBrush(Brush);
end;

//!!----------------------------------------------------------------------------

Function TBrush.GetType: TBrushType;
begin
Result := TBrushType(-1);
SetStatus(GdipGetBrushType(fNativeBrush,@Result));
end;

//!!----------------------------------------------------------------------------

Function TBrush.GetLastStatus: TStatus;
begin
Result := fLastResult;
fLastResult := Ok;
end;


{!!=============================================================================
    TSolidBrush - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TSolidBrush - public methods
-------------------------------------------------------------------------------}

constructor TSolidBrush.Create(const Color: TColor);
var
  Brush:  PGpSolidFill;
begin
inherited Create;
Brush := nil;
fLastResult := GdipCreateSolidFill(GetValue(Color),@Brush);
SetNativeBrush(PGpBrush(Brush));
end;

//!!----------------------------------------------------------------------------

Function TSolidBrush.GetColor(Color: PColor): TStatus;
var
  Argb: TARGB;
begin
If Assigned(Color) then
  begin
    SetStatus(GdipGetSolidFillColor(PGpSolidFill(fNativeBrush),@Argb));
    Color^ := gdipluscolor.Color(Argb);
    Result := fLastResult;
  end
else Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TSolidBrush.SetColor(const Color: TColor): TStatus;
begin
Result := SetStatus(GdipSetSolidFillColor(PGpSolidFill(fNativeBrush),GetValue(Color)));
end;


{!!=============================================================================
    TTextureBrush - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TTextureBrush - public methods
-------------------------------------------------------------------------------}

constructor TTextureBrush.Create(Image: TImage; WrapMode: TWrapMode = WrapModeTile);
var
  Texture: PGpTexture;
begin
inherited Create;
Texture := nil;
fLastResult := GdipCreateTexture(Image.NativeObject,WrapMode,@Texture);
SetNativeBrush(PGpBrush(Texture));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TTextureBrush.Create(Image: TImage; WrapMode: TWrapMode; const DstRect: TRectF);
var
  Texture: PGpTexture;
begin
inherited Create;
Texture := nil;
fLastResult := GdipCreateTexture2(Image.NativeObject,WrapMode,DstRect.X,DstRect.Y,DstRect.Width,DstRect.Height,@Texture);
SetNativeBrush(PGpBrush(Texture));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TTextureBrush.Create(Image: TImage; const DstRect: TRectF; ImageAttributes: TImageAttributes = nil);
var
  Texture: PGpTexture;
begin
inherited Create;
Texture := nil;
fLastResult := GdipCreateTextureIA(Image.NativeObject,ImageAttributes.NativeObject,DstRect.X,DstRect.Y,DstRect.Width,DstRect.Height,@Texture);
SetNativeBrush(PGpBrush(Texture));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TTextureBrush.Create(Image: TImage; const DstRect: TRect; ImageAttributes: TImageAttributes = nil);
var
  Texture: PGpTexture;
begin
inherited Create;
Texture := nil;
fLastResult := GdipCreateTextureIAI(Image.NativeObject,ImageAttributes.NativeObject,DstRect.X,DstRect.Y,DstRect.Width,DstRect.Height,@Texture);
SetNativeBrush(PGpBrush(Texture));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TTextureBrush.Create(Image: TImage; WrapMode: TWrapMode; const DstRect: TRect);
var
  Texture: PGpTexture;
begin
inherited Create;
Texture := nil;
fLastResult := GdipCreateTexture2I(Image.NativeObject,WrapMode,DstRect.X,DstRect.Y,DstRect.Width,DstRect.Height,@Texture);
SetNativeBrush(PGpBrush(Texture));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TTextureBrush.Create(Image: TImage; WrapMode: TWrapMode; DstX,DstY,DstWidth,DstHeight: REAL);
var
  Texture: PGpTexture;
begin
inherited Create;
Texture := nil;
fLastResult := GdipCreateTexture2(Image.NativeObject,WrapMode,DstX,DstY,DstWidth,DstHeight,@Texture);
SetNativeBrush(PGpBrush(Texture));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TTextureBrush.Create(Image: TImage; WrapMode: TWrapMode; DstX,DstY,DstWidth,DstHeight: INT);
var
  Texture: PGpTexture;
begin
inherited Create;
Texture := nil;
fLastResult := GdipCreateTexture2I(Image.NativeObject,WrapMode,DstX,DstY,DstWidth,DstHeight,@Texture);
SetNativeBrush(PGpBrush(Texture));
end;

//!!----------------------------------------------------------------------------

Function TTextureBrush.SetTransform(Matrix: TMatrix): TStatus;
begin
Result := SetStatus(GdipSetTextureTransform(PGpTexture(fNativeBrush),Matrix.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TTextureBrush.GetTransform(Matrix: TMatrix): TStatus;
begin
Result := SetStatus(GdipGetTextureTransform(PGpTexture(fNativeBrush),Matrix.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TTextureBrush.ResetTransform: TStatus;
begin
Result := SetStatus(GdipResetTextureTransform(PGpTexture(fNativeBrush)));
end;

//!!----------------------------------------------------------------------------

Function TTextureBrush.MultiplyTransform(Matrix: TMatrix; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipMultiplyTextureTransform(PGpTexture(fNativeBrush),Matrix.NativeObject,Order));
end;

//!!----------------------------------------------------------------------------

Function TTextureBrush.TranslateTransform(DX,DY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipTranslateTextureTransform(PGpTexture(fNativeBrush),DX,DY,Order));
end;

//!!----------------------------------------------------------------------------

Function TTextureBrush.ScaleTransform(SX,SY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipScaleTextureTransform(PGpTexture(fNativeBrush),SX,SY,Order));
end;

//!!----------------------------------------------------------------------------

Function TTextureBrush.RotateTransform(Angle: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipRotateTextureTransform(PGpTexture(fNativeBrush),Angle,Order));
end;

//!!----------------------------------------------------------------------------

Function TTextureBrush.SetWrapMode(WrapMode: TWrapMode): TStatus;
begin
Result := SetStatus(GdipSetTextureWrapMode(PGpTexture(fNativeBrush),WrapMode));
end;

//!!----------------------------------------------------------------------------

Function TTextureBrush.GetWrapMode: TWrapMode;
begin
SetStatus(GdipGetTextureWrapMode(PGpTexture(fNativeBrush),@Result));
end;

//!!----------------------------------------------------------------------------

type
  TImage_ = class(TImage);  {$message 'remove when joining'} 

Function TTextureBrush.GetImage: TImage;
var
  Image:  PGpImage;
begin
SetStatus(GdipGetTextureImage(PGpTexture(fNativeBrush),@Image));
Result := TImage_.Create(Image,fLastResult);
If not Assigned(Result) then
  GdipDisposeImage(Image);
end;


{!!=============================================================================
    TLinearGradientBrush - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TLinearGradientBrush - public methods
-------------------------------------------------------------------------------}

constructor TLinearGradientBrush.Create(const Point1,Point2: TPointF; const Color1,Color2: TColor);
var
  Brush: PGpLineGradient;
begin
inherited Create;
Brush := nil;
fLastResult := GdipCreateLineBrush(@Point1,@Point2,GetValue(Color1),GetValue(Color2),WrapModeTile,@Brush);
SetNativeBrush(PGpBrush(Brush));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TLinearGradientBrush.Create(const Point1,Point2: TPoint; const Color1,Color2: TColor);
var
  Brush: PGpLineGradient;
begin
inherited Create;
Brush := nil;
fLastResult := GdipCreateLineBrushI(@Point1,@Point2,GetValue(Color1),GetValue(Color2),WrapModeTile,@Brush);
SetNativeBrush(PGpBrush(Brush));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TLinearGradientBrush.Create(const Rect: TRectF; const Color1,Color2: TColor; Mode: TLinearGradientMode);
var
  Brush: PGpLineGradient;
begin
inherited Create;
Brush := nil;
fLastResult := GdipCreateLineBrushFromRect(@Rect,GetValue(Color1),GetValue(Color2),Mode,WrapModeTile,@Brush);
SetNativeBrush(PGpBrush(Brush));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TLinearGradientBrush.Create(const Rect: TRect; const Color1,Color2: TColor; Mode: TLinearGradientMode);
var
  Brush: PGpLineGradient;
begin
inherited Create;
Brush := nil;
fLastResult := GdipCreateLineBrushFromRectI(@Rect,GetValue(Color1),GetValue(Color2),Mode,WrapModeTile,@Brush);
SetNativeBrush(PGpBrush(Brush));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TLinearGradientBrush.Create(const Rect: TRectF; const Color1,Color2: TColor; Angle: REAL; IsAngleScalable: BOOL = False);
var
  Brush: PGpLineGradient;
begin
inherited Create;
Brush := nil;
fLastResult := GdipCreateLineBrushFromRectWithAngle(@Rect,GetValue(Color1),GetValue(Color2),Angle,IsAngleScalable,WrapModeTile,@Brush);
SetNativeBrush(PGpBrush(Brush));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TLinearGradientBrush.Create(const Rect: TRect; const Color1,Color2: TColor; Angle: REAL; IsAngleScalable: BOOL = False);
var
  Brush: PGpLineGradient;
begin
inherited Create;
Brush := nil;
fLastResult := GdipCreateLineBrushFromRectWithAngleI(@Rect,GetValue(Color1),GetValue(Color2),Angle,IsAngleScalable,WrapModeTile,@Brush);
SetNativeBrush(PGpBrush(Brush));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.SetLinearColors(const Color1,Color2: TColor): TStatus;
begin
Result := SetStatus(GdipSetLineColors(PGpLineGradient(fNativeBrush),GetValue(Color1),GetValue(Color2)));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.GetLinearColors(Colors: PColor): TStatus;
var
  Argbs:  array[0..1] of TARGB;
begin
If Assigned(Colors) then
  begin
    Result := SetStatus(GdipGetLineColors(PGpLineGradient(fNativeBrush),@Argbs));
    If Result = Ok then
      begin
        // use bitwise copy operator for Color copy
        PColorArray(Colors)^[0] := Color(Argbs[0]);
        PColorArray(Colors)^[1] := Color(Argbs[1]);
      end;
  end
else Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------
 
Function TLinearGradientBrush.GetRectangle(Rect: PRectF): TStatus;
begin
Result := SetStatus(GdipGetLineRect(PGpLineGradient(fNativeBrush),PGpRectF(Rect)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TLinearGradientBrush.GetRectangle(Rect: PRect): TStatus;
begin
Result := SetStatus(GdipGetLineRectI(PGpLineGradient(fNativeBrush),PGpRect(Rect)));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.SetGammaCorrection(UseGammaCorrection: BOOL): TStatus;
begin
Result := SetStatus(GdipSetLineGammaCorrection(PGpLineGradient(fNativeBrush),UseGammaCorrection));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.GetGammaCorrection: BOOL;
begin
SetStatus(GdipGetLineGammaCorrection(PGpLineGradient(fNativeBrush),@Result));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.GetBlendCount: INT;
begin
Result := 0;
SetStatus(GdipGetLineBlendCount(PGpLineGradient(fNativeBrush),@Result));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.SetBlend(BlendFactors,BlendPositions: PREAL; Count: INT): TStatus;
begin
Result := SetStatus(GdipSetLineBlend(PGpLineGradient(fNativeBrush),BlendFactors,BlendPositions,Count));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.GetBlend(BlendFactors,BlendPositions: PREAL; Count: INT): TStatus;
begin
Result := SetStatus(GdipGetLineBlend(PGpLineGradient(fNativeBrush),BlendFactors,BlendPositions,Count));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.GetInterpolationColorCount: INT;
begin
Result := 0;
SetStatus(GdipGetLinePresetBlendCount(PGpLineGradient(fNativeBrush),@Result));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.SetInterpolationColors(PresetColors: PColor; BlendPositions: PREAL; Count: INT): TStatus;
var
  Argbs:  array of TARGB;
  i:      Integer;
begin
If (Count > 0) and Assigned(PresetColors) then
  begin
    SetLength(Argbs,Count);
    If Length(Argbs) > 0 then
      begin
        For i := 0 to Pred(Count) do
          Argbs[i] := GetValue(PColorArray(PresetColors)^[i]);
        Result := SetStatus(GdipSetLinePresetBlend(PGpLineGradient(fNativeBrush),Pointer(Argbs),BlendPositions,Count));
        SetLength(Argbs,0);
      end
    else Result := SetStatus(OutOfMemory);
  end
else Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.GetInterpolationColors(PresetColors: PColor; BlendPositions: PREAL; Count: INT): TStatus;
var
  Argbs:  array of TARGB;
  i:      Integer;
begin
If (Count > 0) and Assigned(PresetColors) then
  begin
    SetLength(Argbs,Count);
    If Length(Argbs) > 0 then
      begin
        Result := SetStatus(GdipGetLinePresetBlend(PGpLineGradient(fNativeBrush),Pointer(Argbs),BlendPositions,Count));
        If Result = Ok then
          For i := 0 to Pred(Count) do
            PColorArray(PresetColors)^[i] := Color(Argbs[i]);
        SetLength(Argbs,0);
      end
    else Result := SetStatus(OutOfMemory);      
  end
else Result := SetStatus(InvalidParameter);  
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.SetBlendBellShape(Focus: REAL; Scale: REAL = 1.0): TStatus;
begin
Result := SetStatus(GdipSetLineSigmaBlend(PGpLineGradient(fNativeBrush),Focus,Scale));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.SetBlendTriangularShape(Focus: REAL; Scale: REAL = 1.0): TStatus;
begin
Result := SetStatus(GdipSetLineLinearBlend(PGpLineGradient(fNativeBrush),Focus,Scale));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.SetTransform(Matrix: TMatrix): TStatus;
begin
Result := SetStatus(GdipSetLineTransform(PGpLineGradient(fNativeBrush),Matrix.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.GetTransform(Matrix: TMatrix): TStatus;
begin
Result := SetStatus(GdipGetLineTransform(PGpLineGradient(fNativeBrush),Matrix.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.ResetTransform: TStatus;
begin
Result := SetStatus(GdipResetLineTransform(PGpLineGradient(fNativeBrush)));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.MultiplyTransform(Matrix: TMatrix; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipMultiplyLineTransform(PGpLineGradient(fNativeBrush),Matrix.NativeObject,Order));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.TranslateTransform(DX,DY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipTranslateLineTransform(PGpLineGradient(fNativeBrush),DX,DY,Order));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.ScaleTransform(SX,SY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipScaleLineTransform(PGpLineGradient(fNativeBrush),SX,SY,Order));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.RotateTransform(Angle: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipRotateLineTransform(PGpLineGradient(fNativeBrush),Angle,Order));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.SetWrapMode(WrapMode: TWrapMode): TStatus;
begin
Result := SetStatus(GdipSetLineWrapMode(PGpLineGradient(fNativeBrush),WrapMode));
end;

//!!----------------------------------------------------------------------------

Function TLinearGradientBrush.GetWrapMode: TWrapMode;
begin
SetStatus(GdipGetLineWrapMode(PGpLineGradient(fNativeBrush),@Result));
end;


{!!=============================================================================
    THatchBrush - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    THatchBrush - public methods
-------------------------------------------------------------------------------}

constructor THatchBrush.Create(HatchStyle: THatchStyle; const ForeColor,BackColor: TColor);
var
  Brush: PGpHatch;
begin
inherited Create;
Brush := nil;
fLastResult := GdipCreateHatchBrush(HatchStyle,GetValue(ForeColor),GetValue(BackColor),@Brush);
SetNativeBrush(PGpBrush(Brush));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor THatchBrush.Create(HatchStyle: THatchStyle; const ForeColor: TColor);
begin
Create(HatchStyle,ForeColor,Color());
end;

//!!----------------------------------------------------------------------------

Function THatchBrush.GetHatchStyle: THatchStyle;
begin
SetStatus(GdipGetHatchStyle(PGpHatch(fNativeBrush),@Result));
end;

//!!----------------------------------------------------------------------------

Function THatchBrush.GetForegroundColor(Color: PColor): TStatus;
var
  Argb: TARGB;
begin
If Assigned(Color) then
  begin
    Result := SetStatus(GdipGetHatchForegroundColor(PGpHatch(fNativeBrush),@Argb));
    SetValue(Color^,Argb);
  end
else Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function THatchBrush.GetBackgroundColor(Color: PColor): TStatus;
var
  Argb: TARGB;
begin
If Assigned(Color) then
  begin
    Result := SetStatus(GdipGetHatchBackgroundColor(PGpHatch(fNativeBrush),@Argb));
    SetValue(Color^,Argb);
  end
else Result := SetStatus(InvalidParameter);
end;

end.
