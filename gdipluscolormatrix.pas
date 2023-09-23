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
{$IFEND}

//----------------------------------------------------------------------------
// Color matrix
//----------------------------------------------------------------------------
type
  TColorMatrix = record
    m:  array[0..4,0..4] of REAL;
  end;

//----------------------------------------------------------------------------
// Color Matrix flags
//----------------------------------------------------------------------------
type
  TColorMatrixFlags = (
    ColorMatrixFlagsDefault   = 0,
    ColorMatrixFlagsSkipGrays = 1,
    ColorMatrixFlagsAltGray   = 2
  );

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

//----------------------------------------------------------------------------
// Color Map
//----------------------------------------------------------------------------
type
  TColorMap = record
    oldColor: TColor;
    newColor: TColor;
  end;

implementation

end.
