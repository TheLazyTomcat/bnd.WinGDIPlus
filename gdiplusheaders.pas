(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusHeaders.h
*
* Abstract:
*
*   GDI+ Region, Font, Image, CustomLineCap class definitions.
*
*
* Class definition and inline class implementation are separated into
* different files to avoid circular dependencies.
*
\**************************************************************************)
unit gdiplusheaders;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  gdiplusbase, gdiplustypes, gdiplusgpstubs;

{!!
  dgiplusheaders.h contains only declaration of classes which are implemented
  later.
  Here, the declarations are put to the units implementing them.
}
type
  TRegion = class(TGdiPlusBase)
  protected
    fNativeRegion:  PGpRegion;
    fLastResult:    TStatus;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
  end;
  PRegion = ^TRegion;

  TRegionArray = array[0..Pred(MaxInt div SizeOf(TRegion))] of TRegion;
  PRegionArray = ^TRegionArray;

//--------------------------------------------------------------------------
// FontFamily
//--------------------------------------------------------------------------

  TFontFamily = class(TGdiPlusBase)
  protected
    fNativeFamily:  PGpFontFamily;
    fLastResult:    TStatus;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
  end;
  PFontFamily = ^TFontFamily;

  TFontFamilyArray = array[0..Pred(MaxInt div SizeOf(TFontFamily))] of TFontFamily;
  PFontFamilyArray = ^TFontFamilyArray;

//--------------------------------------------------------------------------
// Font
//--------------------------------------------------------------------------

  TFont = class(TGdiPlusBase)
  protected
    fNativeFont:  PGpFont;
    fLastResult:  TStatus;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
  end;

//--------------------------------------------------------------------------
// Font Collection
//--------------------------------------------------------------------------

  TFontCollection = class(TGdiPlusBase)
  protected
    fNativeFontCollection:  PGpFontCollection;
    fLastResult:            TStatus;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
  end;

  TInstalledFontCollection = class(TFontCollection);

  TPrivateFontCollection = class(TFontCollection);

//--------------------------------------------------------------------------
// Abstract base class for Image and Metafile
//--------------------------------------------------------------------------

  TImage = class(TGdiPlusBase)
  protected
    fNativeImage: PGpImage;
    fLastResult:  TStatus;
    fLoadStatus:  TStatus;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
    procedure SetNativeImage(NewNativeImage: PGpImage);
    Function SetStatus(Status: TStatus): TStatus;
    constructor Create(NativeImage: PGpImage; Status: TStatus); overload; virtual;
  end;

  TBitmap = class(TImage);

  TCustomLineCap = class(TGdiPlusBase)
  protected
    fNativeCap:   PGpCustomLineCap;
    fLastResult:  TStatus;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
  end;

  TCachedBitmap = class(TGdiPlusBase)
  protected
    fNativeCachedBitmap:  PGpCachedBitmap;
    fLastResult:          TStatus;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
  end;

  TMetaFile = class(TImage);

//!!----------------------------------------------------------------------------

  TGraphics = class(TGdiPlusBase)
  protected
    fNativeGraphics:  PGpGraphics;
    fLastResult:      TStatus;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
  end;

implementation

Function TFontCollection.GetNativeObject: Pointer;
begin
Result := fNativeFontCollection;
end;
Function TFontCollection.GetNativeObjectAddr: Pointer;
begin
Result := Addr(fNativeFontCollection);
end;

procedure TImage.SetNativeImage(NewNativeImage: PGpImage);
begin
fNativeImage := NewNativeImage;
end;

Function TImage.SetStatus(Status: TStatus): TStatus;
begin
If Status <> Ok then   
  fLastResult := Status;
Result := Status;
end;

Function TImage.GetNativeObject: Pointer;
begin
Result := fNativeImage;
end;

Function TImage.GetNativeObjectAddr: Pointer;
begin
Result := Addr(fNativeImage);
end;

constructor TImage.Create(NativeImage: PGpImage; Status: TStatus);
begin
inherited Create;
SetNativeImage(NativeImage);
fLastResult := Status;
end;

Function TCustomLineCap.GetNativeObject: Pointer;
begin
Result := fNativeCap;
end;

Function TCustomLineCap.GetNativeObjectAddr: Pointer;
begin
Result := Addr(fNativeCap);
end;

Function TFontFamily.GetNativeObject: Pointer;
begin
Result := fNativeFamily;
end;

Function TFontFamily.GetNativeObjectAddr: Pointer;
begin
Result := Addr(fNativeFamily);
end;

Function TFont.GetNativeObject: Pointer;
begin
Result := fNativeFont;
end;

Function TFont.GetNativeObjectAddr: Pointer;
begin
Result := Addr(fNativeFont);
end;

Function TGraphics.GetNativeObject: Pointer;
begin
Result := fNativeGraphics;
end;

Function TGraphics.GetNativeObjectAddr: Pointer;
begin
Result := Addr(fNativeGraphics);
end;

Function TRegion.GetNativeObject: Pointer;
begin
Result := fNativeRegion;
end;

Function TRegion.GetNativeObjectAddr: Pointer;
begin
Result := Addr(fNativeRegion);
end;

Function TCachedBitmap.GetNativeObject: Pointer;
begin
Result := fNativeCachedBitmap;
end;

Function TCachedBitmap.GetNativeObjectAddr: Pointer;
begin
Result := Addr(fNativeCachedBitmap);
end;

end.
