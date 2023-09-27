(**************************************************************************
*
* Copyright (c) 2001 Microsoft Corporation
*
* Module Name:
*
*   Gdiplus effect objects.
*
* Created:
*
*   05/29/2001 asecchia
*      Created it.
*
**************************************************************************)
unit gdipluseffects;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  gdiplus_common, gdiplustypes, gdipluscolormatrix;

{$IF GDIPVER >= $0110}

//-----------------------------------------------------------------------------
// GDI+ effect GUIDs
//----------------------------------------------------------------------------- 
const
  // {633C80A4-1843-482b-9EF2-BE2834C5FDD4}
  BlurEffectGuid: TGUID = '{633C80A4-1843-482b-9EF2-BE2834C5FDD4}';

  // {63CBF3EE-C526-402c-8F71-62C540BF5142}
  SharpenEffectGuid: TGUID = '{63CBF3EE-C526-402c-8F71-62C540BF5142}';

  // {718F2615-7933-40e3-A511-5F68FE14DD74}
  ColorMatrixEffectGuid: TGUID = '{718F2615-7933-40e3-A511-5F68FE14DD74}';

  // {A7CE72A9-0F7F-40d7-B3CC-D0C02D5C3212}
  ColorLUTEffectGuid: TGUID = '{A7CE72A9-0F7F-40d7-B3CC-D0C02D5C3212}';

  // {D3A1DBE1-8EC4-4c17-9F4C-EA97AD1C343D}
  BrightnessContrastEffectGuid: TGUID = '{D3A1DBE1-8EC4-4c17-9F4C-EA97AD1C343D}';

  // {8B2DD6C3-EB07-4d87-A5F0-7108E26A9C5F}
  HueSaturationLightnessEffectGuid: TGUID = '{8B2DD6C3-EB07-4d87-A5F0-7108E26A9C5F}';

  // {99C354EC-2A31-4f3a-8C34-17A803B33A25}
  LevelsEffectGuid: TGUID = '{99C354EC-2A31-4f3a-8C34-17A803B33A25}';

  // {1077AF00-2848-4441-9489-44AD4C2D7A2C}
  TintEffectGuid: TGUID = '{1077AF00-2848-4441-9489-44AD4C2D7A2C}';

  // {537E597D-251E-48da-9664-29CA496B70F8}
  ColorBalanceEffectGuid: TGUID = '{537E597D-251E-48da-9664-29CA496B70F8}';

  // {74D29D05-69A4-4266-9549-3CC52836B632}
  RedEyeCorrectionEffectGuid: TGUID = '{74D29D05-69A4-4266-9549-3CC52836B632}';

  // {DD6A0022-58E4-4a67-9D9B-D48EB881A53D}
  ColorCurveEffectGuid: TGUID = '{DD6A0022-58E4-4a67-9D9B-D48EB881A53D}';

//-----------------------------------------------------------------------------
type
  TSharpenParams = record
    radius: float;
    anount: float;
  end;
  PSharpenParams = ^TSharpenParams;

  TBlurParams = record
    radius:     float;
    expandEdge: BOOL;
  end;
  PBlurParams = ^TBlurParams;

  TBrightnessContrastParams = record
    brightnessLevel:  INT;
    contrastLevel:    INT;
  end;
  PBrightnessContrastParams = ^TBrightnessContrastParams;

  TRedEyeCorrectionParams = record
    numberOfAreas:  UINT;
    areas:          Windows.PRECT;
  end;
  PRedEyeCorrectionParams = ^TRedEyeCorrectionParams;

  THueSaturationLightnessParams = record
    hueLevel:         INT;
    saturationLevel:  INT;
    lightnessLevel:   INT;
  end;
  PHueSaturationLightnessParams = ^THueSaturationLightnessParams;

  TTintParams = record
    hue:    INT;
    amount: INT;
  end;
  PTintParams = ^TTintParams;

  TLevelsParams = record
    highlight:  INT;
    midtone:    INT;
    shadow:     INT;
  end;
  PLevelsParams = ^TLevelsParams;

  TColorBalanceParams = record
    cyanRed:      INT;
    magentaGreen: INT;
    yellowBlue:   INT;
  end;
  PColorBalanceParams = ^TColorBalanceParams;

  TColorLUTParams = record
    // look up tables for each color channel.
    lutB: TColorChannelLUT;
    lutG: TColorChannelLUT;
    lutR: TColorChannelLUT;
    lutA: TColorChannelLUT;
  end;
  PColorLUTParams = ^TColorLUTParams;

type
  TCurveAdjustments = (
    AdjustExposure,
    AdjustDensity,
    AdjustContrast,
    AdjustHighlight,
    AdjustShadow,
    AdjustMidtone,
    AdjustWhiteSaturation,
    AdjustBlackSaturation
  );
  PCurveAdjustments = ^TCurveAdjustments;

  TCurveChannel = (
    CurveChannelAll,
    CurveChannelRed,
    CurveChannelGreen,
    CurveChannelBlue
  );
  PCurveChannel = ^TCurveChannel;

type
  TColorCurveParams = record
    adjustment:   TCurveAdjustments;
    channel:      TCurveChannel;
    adjustValue:  INT;
  end;
  PColorCurveParams = ^TColorCurveParams;

type
  //!! zero-size placeholder type
  TCGpEffect  = record end;
  PCGpEffect  = ^TCGpEffect;
  PPCGpEffect = ^PCGpEffect;

Function GdipCreateEffect(guid: TGUID; effect: PPCGpEffect): TStatus; stdcall; external GDIPLIB;

Function GdipDeleteEffect(effect: PCGpEffect): TStatus; stdcall; external GDIPLIB;

Function GdipGetEffectParameterSize(effect: PCGpEffect; size: PUINT): TStatus; stdcall; external GDIPLIB;

Function GdipSetEffectParameters(effect: PCGpEffect; params: Pointer; size: UINT): TStatus; stdcall; external GDIPLIB;

Function GdipGetEffectParameters(effect: PCGpEffect; size: PUINT; params: Pointer): TStatus; stdcall; external GDIPLIB;

{!!=============================================================================
    TEffect - class declaration
===============================================================================}
type
  TEffect = class(TObject)
  protected
    // protected data members.
    fNativeEffect:  PCGpEffect;
    fAuxDataSize:   INT;
    fAuxData:       Pointer;
    fUseAuxData:    BOOL;     //!! conflict with a method of the same name
    Function SetParameters(Params: Pointer; Size: UINT): TStatus; virtual;
    Function GetParameters(Size: PUINT; Params: Pointer): TStatus; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    Function GetAuxDataSize: INT; virtual;
    Function GetAuxData: Pointer; virtual;
    procedure UseAuxData(UseAuxDataFlag: BOOL); virtual;
    Function GetParameterSize(Size: PUINT): TStatus; virtual;
  end;

{!!=============================================================================
    TBlur - class declaration
===============================================================================}
// Blur
type
  TBlur = class(TEffect)
  public
    constructor Create;
    Function SetParameters(Parameters: PBlurParams): TStatus; reintroduce;
    Function GetParameters(Size: PUINT; Parameters: PBlurParams): TStatus; reintroduce;
  end;

{!!=============================================================================
    TSharpen - class declaration
===============================================================================}
// Sharpen
type
  TSharpen = class(TEffect)
  public
    constructor Create;
    Function SetParameters(Parameters: PSharpenParams): TStatus; reintroduce;
    Function GetParameters(Size: PUINT; Parameters: PSharpenParams): TStatus; reintroduce;
  end;

{!!=============================================================================
    TRedEyeCorrection - class declaration
===============================================================================}
// RedEye Correction
type
  TRedEyeCorrection = class(TEffect)
  public
    constructor Create;
    Function SetParameters(Parameters: PRedEyeCorrectionParams): TStatus; reintroduce;
    Function GetParameters(Size: PUINT; Parameters: PRedEyeCorrectionParams): TStatus; reintroduce;
  end;

{!!=============================================================================
    TBrightnessContrast - class declaration
===============================================================================}
// Brightness/Contrast
type
  TBrightnessContrast = class(TEffect)
  public
    constructor Create;
    Function SetParameters(Parameters: PBrightnessContrastParams): TStatus; reintroduce;
    Function GetParameters(Size: PUINT; Parameters: PBrightnessContrastParams): TStatus; reintroduce;
  end;

{!!=============================================================================
    THueSaturationLightness - class declaration
===============================================================================}
// Hue/Saturation/Lightness
type
  THueSaturationLightness = class(TEffect)
  public
    constructor Create;
    Function SetParameters(Parameters: PHueSaturationLightnessParams): TStatus; reintroduce;
    Function GetParameters(Size: PUINT; Parameters: PHueSaturationLightnessParams): TStatus; reintroduce;
  end;

{!!=============================================================================
    TLevels - class declaration
===============================================================================}
// Highlight/Midtone/Shadow curves
type
  TLevels = class(TEffect)
  public
    constructor Create;
    Function SetParameters(Parameters: PLevelsParams): TStatus; reintroduce;
    Function GetParameters(Size: PUINT; Parameters: PLevelsParams): TStatus; reintroduce;
  end;

{!!=============================================================================
    TTint - class declaration
===============================================================================}
// Tint
type
  TTint = class(TEffect)
  public
    constructor Create;
    Function SetParameters(Parameters: PTintParams): TStatus; reintroduce;
    Function GetParameters(Size: PUINT; Parameters: PTintParams): TStatus; reintroduce;
  end;

{!!=============================================================================
    TColorBalance - class declaration
===============================================================================}
// ColorBalance
type
  TColorBalance = class(TEffect)
  public
    constructor Create;
    Function SetParameters(Parameters: PColorBalanceParams): TStatus; reintroduce;
    Function GetParameters(Size: PUINT; Parameters: PColorBalanceParams): TStatus; reintroduce;
  end;

{!!=============================================================================
    TColorMatrixEffect - class declaration
===============================================================================}
// ColorMatrix
type
  TColorMatrixEffect = class(TEffect)
  public
    constructor Create;
    Function SetParameters(Matrix: PColorMatrix): TStatus; reintroduce;
    Function GetParameters(Size: PUINT; Matrix: PColorMatrix): TStatus; reintroduce;
  end;

{!!=============================================================================
    TColorLUT - class declaration
===============================================================================}
// ColorLUT
type
  TColorLUT = class(TEffect)
  public
    constructor Create;
    Function SetParameters(LUT: PColorLUTParams): TStatus; reintroduce;
    Function GetParameters(Size: PUINT; LUT: PColorLUTParams): TStatus; reintroduce;
  end;

{!!=============================================================================
    TColorCurve - class declaration
===============================================================================}
// Color Curve
type
  TColorCurve = class(TEffect)
  public
    constructor Create;
    Function SetParameters(Parameters: PColorCurveParams): TStatus; reintroduce;
    Function GetParameters(Size: PUINT; Parameters: PColorCurveParams): TStatus; reintroduce;
  end;

{$IFEND}

implementation

{$IF GDIPVER >= $0110}

uses
  gdiplusmem;

{!!=============================================================================
    TEffect - class implmentation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TEffect - protected methods
-------------------------------------------------------------------------------}

Function TEffect.SetParameters(Params: Pointer; Size: UINT): TStatus;
begin
Result := GdipSetEffectParameters(fNativeEffect,Params,Size);
end;

//!!----------------------------------------------------------------------------

Function TEffect.GetParameters(Size: PUINT; Params: Pointer): TStatus;
begin
Result := GdipGetEffectParameters(fNativeEffect,Size,Params);
end;

{!!-----------------------------------------------------------------------------
    TEffect - public methods
-------------------------------------------------------------------------------}

constructor TEffect.Create;
begin
inherited Create;
fAuxDataSize := 0;
fAuxData := nil;
fNativeEffect := nil;
fUseAuxData := False
end;

//!!----------------------------------------------------------------------------

destructor TEffect.Destroy;
begin
// pvData is allocated by ApplyEffect. Return the pointer so that
// it can be freed by the appropriate memory manager.
GdipFree(fAuxData);
// Release the native Effect.
GdipDeleteEffect(fNativeEffect);
inherited;
end;

//!!----------------------------------------------------------------------------

Function TEffect.GetAuxDataSize: INT;
begin
Result := fAuxDataSize;
end;

//!!----------------------------------------------------------------------------

Function TEffect.GetAuxData: Pointer;
begin
Result := fAuxData;
end;

//!!----------------------------------------------------------------------------

procedure TEffect.UseAuxData(UseAuxDataFlag: BOOL);
begin
fUseAuxData := UseAuxDataFlag;
end;

//!!----------------------------------------------------------------------------

Function TEffect.GetParameterSize(Size: PUINT): TStatus;
begin
Result := GdipGetEffectParameterSize(fNativeEffect,Size);
end;


{!!=============================================================================
    TBlur - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TBlur - public methods
-------------------------------------------------------------------------------}

constructor TBlur.Create;
begin
inherited Create;
// constructors cannot return an error code.
GdipCreateEffect(BlurEffectGuid,@fNativeEffect);
end;

//!!----------------------------------------------------------------------------

Function TBlur.SetParameters(Parameters: PBlurParams): TStatus;
begin
Result := inherited SetParameters(Parameters,UINT(SizeOf(TBlurParams)));
end;

//!!----------------------------------------------------------------------------

Function TBlur.GetParameters(Size: PUINT; Parameters: PBlurParams): TStatus;
begin
Result := inherited GetParameters(Size,Parameters);
end;


{!!=============================================================================
    TSharpen - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TSharpen - public methods
-------------------------------------------------------------------------------}

constructor TSharpen.Create;
begin
inherited Create;
GdipCreateEffect(SharpenEffectGuid,@fNativeEffect);
end;

//!!----------------------------------------------------------------------------

Function TSharpen.SetParameters(Parameters: PSharpenParams): TStatus;
begin
Result := inherited SetParameters(Parameters,UINT(SizeOf(TSharpenParams)));
end;

//!!----------------------------------------------------------------------------

Function TSharpen.GetParameters(Size: PUINT; Parameters: PSharpenParams): TStatus;
begin
Result := inherited GetParameters(Size,Parameters);
end;


{!!=============================================================================
    TRedEyeCorrection - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TRedEyeCorrection - public methods
-------------------------------------------------------------------------------}

constructor TRedEyeCorrection.Create;
begin
inherited Create;
// constructors cannot return an error code.
GdipCreateEffect(RedEyeCorrectionEffectGuid,@fNativeEffect);
end;

//!!----------------------------------------------------------------------------

Function TRedEyeCorrection.SetParameters(Parameters: PRedEyeCorrectionParams): TStatus;
begin
Result := InvalidParameter;
If Assigned(Parameters) then
  Result := inherited SetParameters(Parameters,UINT(SizeOf(TRedEyeCorrectionParams) + (Parameters^.numberOfAreas * SizeOf(Windows.TRECT))));
end;

//!!----------------------------------------------------------------------------

Function TRedEyeCorrection.GetParameters(Size: PUINT; Parameters: PRedEyeCorrectionParams): TStatus;
begin
Result := inherited GetParameters(Size,Parameters);
end;


{!!=============================================================================
    TBrightnessContrast - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TBrightnessContrast - public methods
-------------------------------------------------------------------------------}

constructor TBrightnessContrast.Create;
begin
inherited Create;
GdipCreateEffect(BrightnessContrastEffectGuid,@fNativeEffect);
end;

//!!----------------------------------------------------------------------------

Function TBrightnessContrast.SetParameters(Parameters: PBrightnessContrastParams): TStatus;
begin
Result := inherited SetParameters(Parameters,UINT(SizeOf(TBrightnessContrastParams)));
end;

//!!----------------------------------------------------------------------------

Function TBrightnessContrast.GetParameters(Size: PUINT; Parameters: PBrightnessContrastParams): TStatus;
begin
Result := inherited GetParameters(Size,Parameters);
end;


{!!=============================================================================
    THueSaturationLightness - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    THueSaturationLightness - public methods
-------------------------------------------------------------------------------}

constructor THueSaturationLightness.Create;
begin
inherited Create;
GdipCreateEffect(HueSaturationLightnessEffectGuid,@fNativeEffect);
end;

//!!----------------------------------------------------------------------------

Function THueSaturationLightness.SetParameters(Parameters: PHueSaturationLightnessParams): TStatus;
begin
Result := inherited SetParameters(Parameters,UINT(SizeOf(THueSaturationLightnessParams)));
end;

//!!----------------------------------------------------------------------------

Function THueSaturationLightness.GetParameters(Size: PUINT; Parameters: PHueSaturationLightnessParams): TStatus;
begin
Result := inherited GetParameters(Size,Parameters);
end;


{!!=============================================================================
    TLevels - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TLevels - public methods
-------------------------------------------------------------------------------}

constructor TLevels.Create;
begin
inherited Create;
GdipCreateEffect(LevelsEffectGuid,@fNativeEffect);
end;

//!!----------------------------------------------------------------------------

Function TLevels.SetParameters(Parameters: PLevelsParams): TStatus;
begin
Result := inherited SetParameters(Parameters,UINT(SizeOf(TLevelsParams)));
end;

//!!----------------------------------------------------------------------------

Function TLevels.GetParameters(Size: PUINT; Parameters: PLevelsParams): TStatus;
begin
Result := inherited GetParameters(Size,Parameters);
end;


{!!=============================================================================
    TTint - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TTint - public methods
-------------------------------------------------------------------------------}

constructor TTint.Create;
begin
inherited Create;
GdipCreateEffect(TintEffectGuid,@fNativeEffect);
end;

//!!----------------------------------------------------------------------------

Function TTint.SetParameters(Parameters: PTintParams): TStatus;
begin
Result := inherited SetParameters(Parameters,UINT(SizeOf(TTintParams)));
end;

//!!----------------------------------------------------------------------------

Function TTint.GetParameters(Size: PUINT; Parameters: PTintParams): TStatus;
begin
Result := inherited GetParameters(Size,Parameters);
end;


{!!=============================================================================
    TColorBalance - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TColorBalance - public methods
-------------------------------------------------------------------------------}

constructor TColorBalance.Create;
begin
inherited Create;
GdipCreateEffect(ColorBalanceEffectGuid,@fNativeEffect);
end;

//!!----------------------------------------------------------------------------

Function TColorBalance.SetParameters(Parameters: PColorBalanceParams): TStatus;
begin
Result := inherited SetParameters(Parameters,UINT(SizeOf(TColorBalanceParams)));
end;

//!!----------------------------------------------------------------------------

Function TColorBalance.GetParameters(Size: PUINT; Parameters: PColorBalanceParams): TStatus;
begin
Result := inherited GetParameters(Size,Parameters);
end;


{!!=============================================================================
    TColorMatrixEffect - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TColorMatrixEffect - public methods
-------------------------------------------------------------------------------}

constructor TColorMatrixEffect.Create;
begin
inherited Create;
GdipCreateEffect(ColorMatrixEffectGuid,@fNativeEffect);
end;

//!!----------------------------------------------------------------------------

Function TColorMatrixEffect.SetParameters(Matrix: PColorMatrix): TStatus;
begin
Result := inherited SetParameters(matrix,UINT(SizeOf(TColorMatrix)));
end;

//!!----------------------------------------------------------------------------

Function TColorMatrixEffect.GetParameters(Size: PUINT; Matrix: PColorMatrix): TStatus;
begin
Result := inherited GetParameters(Size,matrix);
end;


{!!=============================================================================
    TColorLUT - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TColorLUT - public methods
-------------------------------------------------------------------------------}

constructor TColorLUT.Create;
begin
inherited Create;
GdipCreateEffect(ColorLUTEffectGuid,@fNativeEffect);
end;

//!!----------------------------------------------------------------------------

Function TColorLUT.SetParameters(LUT: PColorLUTParams): TStatus;
begin
Result := inherited SetParameters(LUT,UINT(SizeOf(TColorLUTParams)));
end;

//!!----------------------------------------------------------------------------

Function TColorLUT.GetParameters(Size: PUINT; LUT: PColorLUTParams): TStatus;
begin
Result := inherited GetParameters(Size,LUT);
end;


{!!=============================================================================
    TColorCurve - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TColorCurve - public methods
-------------------------------------------------------------------------------}

constructor TColorCurve.Create;
begin
inherited Create;
GdipCreateEffect(ColorCurveEffectGuid,@fNativeEffect);
end;

//!!----------------------------------------------------------------------------

Function TColorCurve.SetParameters(Parameters: PColorCurveParams): TStatus;
begin
Result := inherited SetParameters(Parameters,UINT(SizeOf(TColorCurveParams)));
end;

//!!----------------------------------------------------------------------------

Function TColorCurve.GetParameters(Size: PUINT; Parameters: PColorCurveParams): TStatus;
begin
Result := inherited GetParameters(Size,Parameters);
end;

{$IFEND}

end.
