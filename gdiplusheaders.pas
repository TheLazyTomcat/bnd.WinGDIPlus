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
  TImage = class(TGdiPlusBase)
  protected
    fNativeImage: PGpImage;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
  public
    constructor Create(NativeImage: PGpImage; Status: TStatus); virtual;
  end;

  TMetaFile = class(TImage);

  TCustomLineCap = class(TGdiPlusBase)
  protected
    fNativeCap: PGpCustomLineCap;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
  end;

  TFontFamily = class(TGdiPlusBase)
  protected
    fNativeFamily:  PGpFontFamily;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
  end;

  TFont = class(TGdiPlusBase)
  protected
    fNativeFont:  PGpFont;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
  end;

  TGraphics = class(TGdiPlusBase)
  protected
    fNativeGraphics:  PGpGraphics;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
  end;

  TRegion = class(TGdiPlusBase)
  protected
    fNativeRegion:  PGpRegion;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
  end;
  PRegion = ^TRegion;

  TRegionArray = array[0..Pred(MaxInt div SizeOf(TRegion))] of TRegion;
  PRegionArray = ^TRegionArray;

  TCachedBitmap = class(TGdiPlusBase)
  protected
    fNativeCachedBitmap:  PGpCachedBitmap;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
  end;

implementation

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
