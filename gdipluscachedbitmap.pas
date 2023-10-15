(**************************************************************************
*
* Copyright (c) 2000 Microsoft Corporation
*
* Module Name:
*
*   CachedBitmap class definition
*
* Abstract:
*
*   GDI+ CachedBitmap is a representation of an accelerated drawing
*   that has restrictions on what operations are allowed in order
*   to accelerate the drawing to the destination.
*
*   Look for class definition in GdiplusHeaders.h
*
**************************************************************************)
unit gdipluscachedbitmap;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  gdiplusheaders, gdiplusgraphics, gdiplustypes;

{!!=============================================================================
    TCachedBitmap - class declaration
===============================================================================}
type
  TCachedBitmap = class(gdiplusheaders.TCachedBitmap)
  public
    constructor Create(Bitmap: TBitmap; Graphics: TGraphics);
    destructor Destroy; override;
    Function GetLastStatus: TStatus;
  end;

implementation

uses
  gdiplusflat;

{!!=============================================================================
    TCachedBitmap - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TCachedBitmap - public methods
-------------------------------------------------------------------------------}

constructor TCachedBitmap.Create(Bitmap: TBitmap; Graphics: TGraphics);
begin
inherited Create;
fNativeCachedBitmap := nil;
fLastResult := GdipCreateCachedBitmap(Bitmap.NativeObject,Graphics.NativeObject,@fNativeCachedBitmap);
end;

//!!----------------------------------------------------------------------------

destructor TCachedBitmap.Destroy;
begin
GdipDeleteCachedBitmap(fNativeCachedBitmap);
inherited;
end;

//!!----------------------------------------------------------------------------

Function TCachedBitmap.GetLastStatus: TStatus;
begin
Result := fLastResult;
fLastResult := Ok;
end;

end.
