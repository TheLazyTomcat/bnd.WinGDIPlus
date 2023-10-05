(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   Image Attributes
*
* Abstract:
*
*   GDI+ Image Attributes used with Graphics.DrawImage
*
* There are 5 possible sets of color adjustments:
*          ColorAdjustDefault,
*          ColorAdjustBitmap,
*          ColorAdjustBrush,
*          ColorAdjustPen,
*          ColorAdjustText,
*
* Bitmaps, Brushes, Pens, and Text will all use any color adjustments
* that have been set into the default ImageAttributes until their own
* color adjustments have been set.  So as soon as any "Set" method is
* called for Bitmaps, Brushes, Pens, or Text, then they start from
* scratch with only the color adjustments that have been set for them.
* Calling Reset removes any individual color adjustments for a type
* and makes it revert back to using all the default color adjustments
* (if any).  The SetToIdentity method is a way to force a type to
* have no color adjustments at all, regardless of what previous adjustments
* have been set for the defaults or for that type.
*
\********************************************************************F******)
unit gdiplusimageattributes;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  gdiplusbase, gdiplusgpstubs, gdiplustypes, gdipluscolormatrix, gdipluscolor,
  gdiplusenums, gdipluspixelformats;

{!!=============================================================================
    TImageAttributes - class declaration
===============================================================================}
type
  TImageAttributes = class(TGdiPlusBase)
  protected
    fNativeImageAttr: PGpImageAttributes;
    fLastResult:      TStatus;
    constructor Create(ImageAttr: PGpImageAttributes; Status: TStatus); overload;
    procedure SetNativeImageAttr(NativeImageAttrArg: PGpImageAttributes); 
    Function SetStatus(Status: TStatus): TStatus; 
  public
    constructor Create; overload;
    destructor Destroy; override;
    Function Clone: TImageAttributes; 
    
    Function SetToIdentity(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 
    Function Reset(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 

    Function SetColorMatrix(ColorMatrix: PColorMatrix; Mode: TColorMatrixFlags = ColorMatrixFlagsDefault;
      TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 
    Function ClearColorMatrix(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 

    Function SetColorMatrices(ColorMatrix,GrayMatrix: PColorMatrix; Mode: TColorMatrixFlags = ColorMatrixFlagsDefault;
      TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 
    Function ClearColorMatrices(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 

    Function SetThreshold(Threshold: REAL; TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 
    Function ClearThreshold(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 

    Function SetGamma(Gamma: REAL; TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 
    Function ClearGamma(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 

    Function SetNoOp(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 
    Function ClearNoOp(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 

    Function SetColorKey(const ColorLow,ColorHigh: TColor; TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 
    Function ClearColorKey(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 

    Function SetOutputChannel(ChannelFlags: TColorChannelFlags; TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 
    Function ClearOutputChannel(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 

    Function SetOutputChannelColorProfile(ColorProfileFilename: PWideChar;
      TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; overload; 
    Function SetOutputChannelColorProfile(const ColorProfileFilename: String;
      TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; overload; 
    Function ClearOutputChannelColorProfile(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 

    Function SetRemapTable(MapSize: UINT; Map: PColorMap; TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 
    Function ClearRemapTable(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus; 

    Function SetBrushRemapTable(MapSize: UINT; Map: PColorMap): TStatus; 
    Function ClearBrushRemapTable: TStatus; 

    Function SetWrapMode(Wrap: TWrapMode; const Color: TColor; Clamp: BOOL = False): TStatus; overload; 
    //!! since record parameters (Color) cannot have default value...
    Function SetWrapMode(Wrap: TWrapMode): TStatus; overload; 

    // The flags of the palette are ignored.
    Function GetAdjustedPalette(ColorPalette: PColorPalette; ColorAdjustType: TColorAdjustType): TStatus; 
    
    Function GetLastStatus: TStatus; 
  end;

implementation

uses
  StrRect,
  gdiplusflat;

{!!=============================================================================
    TImageAttributes - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TImageAttributes - protected methods
-------------------------------------------------------------------------------}

constructor TImageAttributes.Create(ImageAttr: PGpImageAttributes; Status: TStatus);
begin
inherited Create;
SetNativeImageAttr(ImageAttr);
fLastResult := Status;
end;

//!!----------------------------------------------------------------------------

procedure TImageAttributes.SetNativeImageAttr(NativeImageAttrArg: PGpImageAttributes);
begin
fNativeImageAttr := NativeImageAttrArg;
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.SetStatus(Status: TStatus): TStatus;
begin
If Status <> Ok then
  fLastResult := Status;
Result := Status;
end;

{!!-----------------------------------------------------------------------------
    TImageAttributes - public methods
-------------------------------------------------------------------------------}

constructor TImageAttributes.Create;
begin
inherited Create;
fNativeImageAttr := nil;
fLastResult := GdipCreateImageAttributes(@fNativeImageAttr);
end;

//!!----------------------------------------------------------------------------

destructor TImageAttributes.Destroy;
begin
GdipDisposeImageAttributes(fNativeImageAttr);
inherited;
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.Clone: TImageAttributes;
var
  CloneAttr:  PGpImageAttributes;
begin
SetStatus(GdipCloneImageAttributes(fNativeImageAttr,@CloneAttr));
Result := TImageAttributes.Create(CloneAttr,fLastResult);
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.SetToIdentity(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesToIdentity(fNativeImageAttr,TypeAdjusted));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.Reset(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipResetImageAttributes(fNativeImageAttr,TypeAdjusted));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.SetColorMatrix(ColorMatrix: PColorMatrix; Mode: TColorMatrixFlags = ColorMatrixFlagsDefault;
  TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesColorMatrix(fNativeImageAttr,TypeAdjusted,True,ColorMatrix,nil,Mode));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.ClearColorMatrix(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesColorMatrix(fNativeImageAttr,TypeAdjusted,False,nil,nil,ColorMatrixFlagsDefault));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.SetColorMatrices(ColorMatrix,GrayMatrix: PColorMatrix; Mode: TColorMatrixFlags = ColorMatrixFlagsDefault;
  TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesColorMatrix(fNativeImageAttr,TypeAdjusted,True,ColorMatrix,GrayMatrix,Mode));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.ClearColorMatrices(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesColorMatrix(fNativeImageAttr,TypeAdjusted,False,nil,nil,ColorMatrixFlagsDefault));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.SetThreshold(Threshold: REAL; TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesThreshold(fNativeImageAttr,TypeAdjusted,True,Threshold));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.ClearThreshold(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesThreshold(fNativeImageAttr,TypeAdjusted,False,0.0));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.SetGamma(Gamma: REAL; TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesGamma(fNativeImageAttr,TypeAdjusted,True,Gamma));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.ClearGamma(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesGamma(fNativeImageAttr,TypeAdjusted,False,0.0));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.SetNoOp(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesNoOp(fNativeImageAttr,TypeAdjusted,True));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.ClearNoOp(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesNoOp(fNativeImageAttr,TypeAdjusted,False));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.SetColorKey(const ColorLow,ColorHigh: TColor; TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesColorKeys(fNativeImageAttr,TypeAdjusted,True,GetValue(ColorLow),GetValue(ColorHigh)));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.ClearColorKey(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesColorKeys(fNativeImageAttr,TypeAdjusted,False,0,0));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.SetOutputChannel(ChannelFlags: TColorChannelFlags; TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesOutputChannel(fNativeImageAttr,TypeAdjusted,True,ChannelFlags));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.ClearOutputChannel(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesOutputChannel(fNativeImageAttr,TypeAdjusted,False,ColorChannelFlagsLast));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.SetOutputChannelColorProfile(ColorProfileFilename: PWideChar;
  TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesOutputChannelColorProfile(fNativeImageAttr,TypeAdjusted,True,ColorProfileFilename));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TImageAttributes.SetOutputChannelColorProfile(const ColorProfileFilename: String;
  TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetOutputChannelColorProfile(PWideChar(StrToWide(ColorProfileFilename)),TypeAdjusted)
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.ClearOutputChannelColorProfile(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesOutputChannelColorProfile(fNativeImageAttr,TypeAdjusted,False,nil));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.SetRemapTable(MapSize: UINT; Map: PColorMap; TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesRemapTable(fNativeImageAttr,TypeAdjusted,True,MapSize,Map));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.ClearRemapTable(TypeAdjusted: TColorAdjustType = ColorAdjustTypeDefault): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesRemapTable(fNativeImageAttr,TypeAdjusted,False,0,nil));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.SetBrushRemapTable(MapSize: UINT; Map: PColorMap): TStatus;
begin
Result := SetRemapTable(MapSize,Map,ColorAdjustTypeBrush);
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.ClearBrushRemapTable: TStatus;
begin
Result := ClearRemapTable(ColorAdjustTypeBrush);
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.SetWrapMode(Wrap: TWrapMode; const Color: TColor; Clamp: BOOL = False): TStatus;
begin
Result := SetStatus(GdipSetImageAttributesWrapMode(fNativeImageAttr,Wrap,GetValue(Color),Clamp));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TImageAttributes.SetWrapMode(Wrap: TWrapMode): TStatus;
begin
Result := SetWrapMode(Wrap,Color(),False);
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.GetAdjustedPalette(ColorPalette: PColorPalette; ColorAdjustType: TColorAdjustType): TStatus;
begin
Result := SetStatus(GdipGetImageAttributesAdjustedPalette(fNativeImageAttr,ColorPalette,ColorAdjustType));
end;

//!!----------------------------------------------------------------------------

Function TImageAttributes.GetLastStatus: TStatus;
begin
Result := fLastResult;
fLastResult := Ok;
end;

end.
