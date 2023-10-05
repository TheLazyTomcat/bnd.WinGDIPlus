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
    constructor Create(NativeImage: PGpImage; Status: TStatus); virtual;
  end;

  TCustomLineCap = class(TGdiPlusBase)
  protected
    fNativeCap: PGpCustomLineCap;
  end;

  TFontFamily = class(TGdiPlusBase)
  protected
    fNativeFamily:  PGpFontFamily;
  end;

  TGraphics = class(TGdiPlusBase)
  protected
    fNativeGraphics:  PGpGraphics;
  end;

implementation

constructor TImage.Create(NativeImage: PGpImage; Status: TStatus); 
begin
inherited Create;
end;

end.