(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusColorMatrix.h
*
* Abstract:
*
*  GDI+ Color Matrix object, used with Graphics.DrawImage
*
\**************************************************************************)
unit gdipluscolormatrix;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  gdiplus_common,
  gdiplustypes, gdipluscolor;

{$IF GDIPVER >= $0110}
//----------------------------------------------------------------------------
// Color channel look up table (LUT)
//----------------------------------------------------------------------------
type
  TColorChannelLUT = array[0..255] of Byte;
  PColorChannelLUT = ^TColorChannelLUT;

//----------------------------------------------------------------------------
// Per-channel Histogram for 8bpp images.
//----------------------------------------------------------------------------
type
  THistogramFormat = (
    HistogramFormatARGB,
    HistogramFormatPARGB,
    HistogramFormatRGB,
    HistogramFormatGray,
    HistogramFormatB,
    HistogramFormatG,
    HistogramFormatR,
    HistogramFormatA
  );
  PHistogramFormat = ^THistogramFormat;
{$IFEND}

//----------------------------------------------------------------------------
// Color matrix
//----------------------------------------------------------------------------
type
  TColorMatrix = record
    m:  array[0..4,0..4] of REAL;
  end;
  PColorMatrix = ^TColorMatrix;

//----------------------------------------------------------------------------
// Color Matrix flags
//----------------------------------------------------------------------------
type
  TColorMatrixFlags = (
    ColorMatrixFlagsDefault   = 0,
    ColorMatrixFlagsSkipGrays = 1,
    ColorMatrixFlagsAltGray   = 2
  );
  PColorMatrixFlags = ^TColorMatrixFlags;

//----------------------------------------------------------------------------
// Color Adjust Type
//----------------------------------------------------------------------------
type
  TColorAdjustType = (
    ColorAdjustTypeDefault,
    ColorAdjustTypeBitmap,
    ColorAdjustTypeBrush,
    ColorAdjustTypePen,
    ColorAdjustTypeText,
    ColorAdjustTypeCount,
    ColorAdjustTypeAny      // Reserved
  );
  PColorAdjustType = ^TColorAdjustType;

//----------------------------------------------------------------------------
// Color Map
//----------------------------------------------------------------------------
type
  TColorMap = record
    oldColor: TColor;
    newColor: TColor;
  end;
  PColorMap = ^TColorMap; 

implementation

end.
