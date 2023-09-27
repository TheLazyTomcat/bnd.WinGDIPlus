(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusGpStubs.h
*
* Abstract:
*
*   Private GDI+ header file.
*
\**************************************************************************)
unit gdiplusgpstubs;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  gdiplusenums, gdiplustypes;

//---------------------------------------------------------------------------
// GDI+ classes for forward reference
//---------------------------------------------------------------------------
{!!
  Forward declarations removed.

  Original text:

class Graphics;
class Pen;
class Brush;
class Matrix;
class Bitmap;
class Metafile;
class GraphicsPath;
class PathIterator;
class Region;
class Image;
class TextureBrush;
class HatchBrush;
class SolidBrush;
class LinearGradientBrush;
class PathGradientBrush;
class Font;
class FontFamily;
class FontCollection;
class InstalledFontCollection;
class PrivateFontCollection;
class ImageAttributes;
class CachedBitmap;
}

//---------------------------------------------------------------------------
// Private GDI+ classes for internal type checking
//---------------------------------------------------------------------------
type
  TGpGraphics = record end;   PGpGraphics = ^TGpGraphics;   PPGpGraphics = ^PGpGraphics;

  TGpBrush        = record end;       PGpBrush        = ^TGpBrush;          PPGpBrush        = ^PGpBrush;
  TGpTexture      = type TGpBrush;    PGpTexture      = ^TGpTexture;        PPGpTexture      = ^PGpTexture;
  TGpSolidFill    = type TGpBrush;    PGpSolidFill    = ^TGpSolidFill;      PPGpSolidFill    = ^PGpSolidFill;
  TGpLineGradient = type TGpBrush;    PGpLineGradient = ^TGpLineGradient;   PPGpLineGradient = ^PGpLineGradient;
  TGpPathGradient = type TGpBrush;    PGpPathGradient = ^TGpPathGradient;   PPGpPathGradient = ^PGpPathGradient;
  TGpHatch        = type TGpBrush;    PGpHatch        = ^TGpHatch;          PPGpHatch        = ^PGpHatch;

  TGpPen                = record end;               PGpPen                = ^TGpPen;                  PPGpPen                = ^PGpPen;
  TGpCustomLineCap      = record end;               PGpCustomLineCap      = ^TGpCustomLineCap;        PPGpCustomLineCap      = ^PGpCustomLineCap;
  TGpAdjustableArrowCap = type TGpCustomLineCap;    PGpAdjustableArrowCap = ^TGpAdjustableArrowCap;   PPGpAdjustableArrowCap = ^PGpAdjustableArrowCap;

  TGpImage           = record end;      PGpImage           = ^TGpImage;             PPGpImage           = ^PGpImage;
  TGpBitmap          = type TGpImage;   PGpBitmap          = ^TGpBitmap;            PPGpBitmap          = ^PGpBitmap;
  TGpMetafile        = type TGpImage;   PGpMetafile        = ^TGpMetafile;          PPGpMetafile        = ^PGpMetafile;
  TGpImageAttributes = record end;      PGpImageAttributes = ^TGpImageAttributes;   PPGpImageAttributes = ^PGpImageAttributes;

  TGpPath         = record end;   PGpPath         = ^TGpPath;           PPGpPath         = ^PGpPath;
  TGpRegion       = record end;   PGpRegion       = ^TGpRegion;         PPGpRegion       = ^PGpRegion;
  TGpPathIterator = record end;   PGpPathIterator = ^TGpPathIterator;   PPGpPathIterator = ^PGpPathIterator;

  TGpFontFamily              = record end;                PGpFontFamily              = ^TGpFontFamily;                PPGpFontFamily     = ^PGpFontFamily;
  TGpFont                    = record end;                PGpFont                    = ^TGpFont;                      PPGpFont           = ^PGpFont;
  TGpStringFormat            = record end;                PGpStringFormat            = ^TGpStringFormat;              PPGpStringFormat   = ^PGpStringFormat;
  TGpFontCollection          = record end;                PGpFontCollection          = ^TGpFontCollection;            PPGpFontCollection = ^PGpFontCollection;
  TGpInstalledFontCollection = type TGpFontCollection;    PGpInstalledFontCollection = ^TGpInstalledFontCollection;
  TGpPrivateFontCollection   = type TGpFontCollection;    PGpPrivateFontCollection   = ^TGpPrivateFontCollection;

  TGpCachedBitmap = record end;   PGpCachedBitmap = ^TGpCachedBitmap;   PPGpCachedBitmap = ^PGpCachedBitmap;

type
  TGpStatus          = TStatus;             PGpStatus          = ^TGpStatus;
  TGpFillMode        = TFillMode;           PGpFillMode        = ^TGpFillMode;
  TGpWrapMode        = TWrapMode;           PGpWrapMode        = ^TGpWrapMode;
  TGpUnit            = TUnit;               PGpUnit            = ^TGpUnit;
  TGpCoordinateSpace = TCoordinateSpace;    PGpCoordinateSpace = ^TGpCoordinateSpace;
  TGpPointF          = TPointF;             PGpPointF          = ^TGpPointF;
  TGpPoint           = TPoint;              PGpPoint           = ^TGpPoint;
  TGpRectF           = TRectF;              PGpRectF           = ^TGpRectF;
  TGpRect            = TRect;               PGpRect            = ^TGpRect;
  TGpSizeF           = TSizeF;              PGpSizeF           = ^TGpSizeF;
  TGpHatchStyle      = THatchStyle;         PGpHatchStyle      = ^TGpHatchStyle;
  TGpDashStyle       = TDashStyle;          PGpDashStyle       = ^TGpDashStyle;
  TGpLineCap         = TLineCap;            PGpLineCap         = ^TGpLineCap;
  TGpDashCap         = TDashCap;            PGpDashCap         = ^TGpDashCap;

  TGpPenAlignment = TPenAlignment;    PGpPenAlignment = ^TGpPenAlignment;

  TGpLineJoin = TLineJoin;    PGpLineJoin = ^TGpLineJoin;
  TGpPenType  = TPenType;     PGpPenType  = ^TGpPenType;

  TGpMatrix         = record end;         PGpMatrix         = ^TGpMatrix;           PPGpMatrix = ^PGpMatrix;
  TGpBrushType      = TBrushType;         PGpBrushType      = ^TGpBrushType;
  TGpMatrixOrder    = TMatrixOrder;       PGpMatrixOrder    = ^TGpMatrixOrder;
  TGpFlushIntention = TFlushIntention;    PGpFlushIntention = ^TGpFlushIntention;
  TGpPathData       = TPathData;          PGpPathData       = ^TGpPathData;

implementation

end.
