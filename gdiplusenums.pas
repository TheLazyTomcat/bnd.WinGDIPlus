(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusEnums.h
*
* Abstract:
*
*   GDI+ Enumeration Types
*
\**************************************************************************)
unit gdiplusenums;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  gdiplus_common;

//--------------------------------------------------------------------------
// Default bezier flattening tolerance in device pixels.
//--------------------------------------------------------------------------
const
  FlatnessDefault:  Single = 1.0/4.0;

//--------------------------------------------------------------------------
// Graphics and Container State cookies
//--------------------------------------------------------------------------
type
  TGraphicsState     = UINT;    PGraphicsState     = ^TGraphicsState;
  TGraphicsContainer = UINT;    PGraphicsContainer = ^TGraphicsContainer;

//--------------------------------------------------------------------------
// Fill mode constants
//--------------------------------------------------------------------------
type
  TFillMode = (
    FillModeAlternate,  // 0
    FillModeWinding     // 1
  );
  PFillMode = ^TFillMode;

//--------------------------------------------------------------------------
// Quality mode constants
//--------------------------------------------------------------------------
type
  TQualityMode = (
    QualityModeInvalid = -1,
    QualityModeDefault = 0,
    QualityModeLow     = 1, // Best performance
    QualityModeHigh    = 2  // Best rendering quality
  );
  PQualityMode = ^TQualityMode;

//--------------------------------------------------------------------------
// Alpha Compositing mode constants
//--------------------------------------------------------------------------
type
  TCompositingMode = (
    CompositingModeSourceOver,  // 0
    CompositingModeSourceCopy   // 1
  );
  PCompositingMode = ^TCompositingMode;

//--------------------------------------------------------------------------
// Alpha Compositing quality constants
//--------------------------------------------------------------------------
type
  TCompositingQuality = (
    CompositingQualityInvalid          = Ord(QualityModeInvalid),
    CompositingQualityDefault          = Ord(QualityModeDefault),
    CompositingQualityHighSpeed        = Ord(QualityModeLow),
    CompositingQualityHighQuality      = Ord(QualityModeHigh),
    CompositingQualityGammaCorrected,
    CompositingQualityAssumeLinear
  );
  PCompositingQuality = ^TCompositingQuality;

//--------------------------------------------------------------------------
// Unit constants
//--------------------------------------------------------------------------
type
  TUnit = (
    UnitWorld,      // 0 -- World coordinate (non-physical unit)
    UnitDisplay,    // 1 -- Variable -- for PageTransform only
    UnitPixel,      // 2 -- Each unit is one device pixel.
    UnitPoint,      // 3 -- Each unit is a printer's point, or 1/72 inch.
    UnitInch,       // 4 -- Each unit is 1 inch.
    UnitDocument,   // 5 -- Each unit is 1/300 inch.
    UnitMillimeter  // 6 -- Each unit is 1 millimeter.
  );
  PUnit = ^TUnit;

//--------------------------------------------------------------------------
// MetafileFrameUnit
//
// The frameRect for creating a metafile can be specified in any of these
// units.  There is an extra frame unit value (MetafileFrameUnitGdi) so
// that units can be supplied in the same units that GDI expects for
// frame rects -- these units are in .01 (1/100ths) millimeter units
// as defined by GDI.
//--------------------------------------------------------------------------
type
  TMetafileFrameUnit =(
    MetafileFrameUnitPixel      = Ord(UnitPixel),
    MetafileFrameUnitPoint      = Ord(UnitPoint),
    MetafileFrameUnitInch       = Ord(UnitInch),
    MetafileFrameUnitDocument   = Ord(UnitDocument),
    MetafileFrameUnitMillimeter = Ord(UnitMillimeter),
    MetafileFrameUnitGdi                        // GDI compatible .01 MM units
  );
  PMetafileFrameUnit = ^TMetafileFrameUnit;

//--------------------------------------------------------------------------
// Coordinate space identifiers
//--------------------------------------------------------------------------
type
  TCoordinateSpace = (
    CoordinateSpaceWorld,   // 0
    CoordinateSpacePage,    // 1
    CoordinateSpaceDevice   // 2
  );
  PCoordinateSpace = ^TCoordinateSpace;

//--------------------------------------------------------------------------
// Various wrap modes for brushes
//--------------------------------------------------------------------------
type
  TWrapMode = (
    WrapModeTile,        // 0
    WrapModeTileFlipX,   // 1
    WrapModeTileFlipY,   // 2
    WrapModeTileFlipXY,  // 3
    WrapModeClamp        // 4
  );
  PWrapMode = ^TWrapMode;

//--------------------------------------------------------------------------
// Various hatch styles
//--------------------------------------------------------------------------
type
  THatchStyle = (
    HatchStyleHorizontal,                   // 0
    HatchStyleVertical,                     // 1
    HatchStyleForwardDiagonal,              // 2
    HatchStyleBackwardDiagonal,             // 3
    HatchStyleCross,                        // 4
    HatchStyleDiagonalCross,                // 5
    HatchStyle05Percent,                    // 6
    HatchStyle10Percent,                    // 7
    HatchStyle20Percent,                    // 8
    HatchStyle25Percent,                    // 9
    HatchStyle30Percent,                    // 10
    HatchStyle40Percent,                    // 11
    HatchStyle50Percent,                    // 12
    HatchStyle60Percent,                    // 13
    HatchStyle70Percent,                    // 14
    HatchStyle75Percent,                    // 15
    HatchStyle80Percent,                    // 16
    HatchStyle90Percent,                    // 17
    HatchStyleLightDownwardDiagonal,        // 18
    HatchStyleLightUpwardDiagonal,          // 19
    HatchStyleDarkDownwardDiagonal,         // 20
    HatchStyleDarkUpwardDiagonal,           // 21
    HatchStyleWideDownwardDiagonal,         // 22
    HatchStyleWideUpwardDiagonal,           // 23
    HatchStyleLightVertical,                // 24
    HatchStyleLightHorizontal,              // 25
    HatchStyleNarrowVertical,               // 26
    HatchStyleNarrowHorizontal,             // 27
    HatchStyleDarkVertical,                 // 28
    HatchStyleDarkHorizontal,               // 29
    HatchStyleDashedDownwardDiagonal,       // 30
    HatchStyleDashedUpwardDiagonal,         // 31
    HatchStyleDashedHorizontal,             // 32
    HatchStyleDashedVertical,               // 33
    HatchStyleSmallConfetti,                // 34
    HatchStyleLargeConfetti,                // 35
    HatchStyleZigZag,                       // 36
    HatchStyleWave,                         // 37
    HatchStyleDiagonalBrick,                // 38
    HatchStyleHorizontalBrick,              // 39
    HatchStyleWeave,                        // 40
    HatchStylePlaid,                        // 41
    HatchStyleDivot,                        // 42
    HatchStyleDottedGrid,                   // 43
    HatchStyleDottedDiamond,                // 44
    HatchStyleShingle,                      // 45
    HatchStyleTrellis,                      // 46
    HatchStyleSphere,                       // 47
    HatchStyleSmallGrid,                    // 48
    HatchStyleSmallCheckerBoard,            // 49
    HatchStyleLargeCheckerBoard,            // 50
    HatchStyleOutlinedDiamond,              // 51
    HatchStyleSolidDiamond,                 // 52

    HatchStyleTotal,   
    HatchStyleLargeGrid = HatchStyleCross,  // 4

    HatchStyleMin       = HatchStyleHorizontal,
    HatchStyleMax       = HatchStyleTotal - 1
  );
  PHatchStyle = ^THatchStyle;

//--------------------------------------------------------------------------
// Dash style constants
//--------------------------------------------------------------------------
type
  TDashStyle = (
    DashStyleSolid,       // 0
    DashStyleDash,        // 1
    DashStyleDot,         // 2
    DashStyleDashDot,     // 3
    DashStyleDashDotDot,  // 4
    DashStyleCustom       // 5
  );
  PDashStyle = ^TDashStyle;

//--------------------------------------------------------------------------
// Dash cap constants
//--------------------------------------------------------------------------
type
  TDashCap = (
    DashCapFlat     = 0,
    DashCapRound    = 2,
    DashCapTriangle = 3
  );
  PDashCap = ^TDashCap;

//--------------------------------------------------------------------------
// Line cap constants (only the lowest 8 bits are used).
//--------------------------------------------------------------------------
type
  TLineCap = (
    LineCapFlat          = 0,
    LineCapSquare        = 1,
    LineCapRound         = 2,
    LineCapTriangle      = 3,

    LineCapNoAnchor      = $10,   // corresponds to flat cap
    LineCapSquareAnchor  = $11,   // corresponds to square cap
    LineCapRoundAnchor   = $12,   // corresponds to round cap
    LineCapDiamondAnchor = $13,   // corresponds to triangle cap
    LineCapArrowAnchor   = $14,   // no correspondence

    LineCapCustom        = $ff,   // custom cap

    LineCapAnchorMask    = $f0    // mask to check for anchor or not.
  );
  PLineCap = ^TLineCap;

//--------------------------------------------------------------------------
// Custom Line cap type constants
//--------------------------------------------------------------------------
type
  TCustomLineCapType =(
    CustomLineCapTypeDefault         = 0,
    CustomLineCapTypeAdjustableArrow = 1
  );
  PCustomLineCapType = ^TCustomLineCapType;

//--------------------------------------------------------------------------
// Line join constants
//--------------------------------------------------------------------------
type
  TLineJoin = (
    LineJoinMiter        = 0,
    LineJoinBevel        = 1,
    LineJoinRound        = 2,
    LineJoinMiterClipped = 3
  );
  PLineJoin = ^TLineJoin;

//--------------------------------------------------------------------------
// Path point types (only the lowest 8 bits are used.)
//  The lowest 3 bits are interpreted as point type
//  The higher 5 bits are reserved for flags.
//--------------------------------------------------------------------------
type
  TPathPointType = (
    PathPointTypeStart        = 0,    // move
    PathPointTypeLine         = 1,    // line
    PathPointTypeBezier       = 3,    // default Bezier (= cubic Bezier)
    PathPointTypePathTypeMask = $07,  // type mask (lowest 3 bits).
    PathPointTypeDashMode     = $10,  // currently in dash mode.
    PathPointTypePathMarker   = $20,  // a marker for the path.
    PathPointTypeCloseSubpath = $80,  // closed flag

    // Path types used for advanced path.

    PathPointTypeBezier3      = 3     // cubic Bezier
  );
  PPathPointType = ^TPathPointType;

//--------------------------------------------------------------------------
// WarpMode constants
//--------------------------------------------------------------------------
type
  TWarpMode = (
    WarpModePerspective,    // 0
    WarpModeBilinear        // 1
  );
  PWarpMode = ^TWarpMode;

//--------------------------------------------------------------------------
// LineGradient Mode
//--------------------------------------------------------------------------
type
  TLinearGradientMode = (
    LinearGradientModeHorizontal,         // 0
    LinearGradientModeVertical,           // 1
    LinearGradientModeForwardDiagonal,    // 2
    LinearGradientModeBackwardDiagonal    // 3
  );
  PLinearGradientMode = ^TLinearGradientMode;

//--------------------------------------------------------------------------
// Region Comine Modes
//--------------------------------------------------------------------------
type
  TCombineMode = (
    CombineModeReplace,     // 0
    CombineModeIntersect,   // 1
    CombineModeUnion,       // 2
    CombineModeXor,         // 3
    CombineModeExclude,     // 4
    CombineModeComplement   // 5 (Exclude From)
  );
  PCombineMode = ^TCombineMode;

//--------------------------------------------------------------------------
// Image types
//--------------------------------------------------------------------------
type
  TImageType = (
    ImageTypeUnknown,   // 0
    ImageTypeBitmap,    // 1
    ImageTypeMetafile   // 2
  );
  PImageType = ^TImageType;

//--------------------------------------------------------------------------
// Interpolation modes
//--------------------------------------------------------------------------
type
  TInterpolationMode = (
    InterpolationModeInvalid          = Ord(QualityModeInvalid),
    InterpolationModeDefault          = Ord(QualityModeDefault),
    InterpolationModeLowQuality       = Ord(QualityModeLow),
    InterpolationModeHighQuality      = Ord(QualityModeHigh),
    InterpolationModeBilinear,
    InterpolationModeBicubic,
    InterpolationModeNearestNeighbor,
    InterpolationModeHighQualityBilinear,
    InterpolationModeHighQualityBicubic
  );
  PInterpolationMode = ^TInterpolationMode;

//--------------------------------------------------------------------------
// Pen types
//--------------------------------------------------------------------------
type
  TPenAlignment = (
    PenAlignmentCenter = 0,
    PenAlignmentInset  = 1
  );
  PPenAlignment = ^TPenAlignment;

//--------------------------------------------------------------------------
// Brush types
//--------------------------------------------------------------------------
type
  TBrushType = (
   BrushTypeSolidColor     = 0,
   BrushTypeHatchFill      = 1,
   BrushTypeTextureFill    = 2,
   BrushTypePathGradient   = 3,
   BrushTypeLinearGradient = 4
  );
  PBrushType = ^TBrushType;

//--------------------------------------------------------------------------
// Pen's Fill types
//--------------------------------------------------------------------------
type
  TPenType = (
   PenTypeSolidColor     = Ord(BrushTypeSolidColor),
   PenTypeHatchFill      = Ord(BrushTypeHatchFill),
   PenTypeTextureFill    = Ord(BrushTypeTextureFill),
   PenTypePathGradient   = Ord(BrushTypePathGradient),
   PenTypeLinearGradient = Ord(BrushTypeLinearGradient),
   PenTypeUnknown        = -1
  );
  PPenType = ^TPenType;

//--------------------------------------------------------------------------
// Matrix Order
//--------------------------------------------------------------------------
type
  TMatrixOrder = (
    MatrixOrderPrepend = 0,
    MatrixOrderAppend  = 1
  );
  PMatrixOrder = ^TMatrixOrder;

//--------------------------------------------------------------------------
// Generic font families
//--------------------------------------------------------------------------
type
  TGenericFontFamily = (
    GenericFontFamilySerif,
    GenericFontFamilySansSerif,
    GenericFontFamilyMonospace
  );
  PGenericFontFamily = ^TGenericFontFamily;

//--------------------------------------------------------------------------
// FontStyle: face types and common styles
//--------------------------------------------------------------------------
type
  TFontStyle = INT;     PFontStyle = ^TFontStyle;
const
  FontStyleRegular    = 0;
  FontStyleBold       = 1;
  FontStyleItalic     = 2;
  FontStyleBoldItalic = 3;
  FontStyleUnderline  = 4;
  FontStyleStrikeout  = 8;

//---------------------------------------------------------------------------
// Smoothing Mode
//---------------------------------------------------------------------------
type
  TSmoothingMode = (
    SmoothingModeInvalid      = Ord(QualityModeInvalid),
    SmoothingModeDefault      = Ord(QualityModeDefault),
    SmoothingModeHighSpeed    = Ord(QualityModeLow),
    SmoothingModeHighQuality  = Ord(QualityModeHigh),
    SmoothingModeNone,
    SmoothingModeAntiAlias
  {$IF GDIPVER >= $0110},
    SmoothingModeAntiAlias8x4 = Ord(SmoothingModeAntiAlias),
    SmoothingModeAntiAlias8x8
  {$IFEND}
  );
  PSmoothingMode = ^TSmoothingMode;

//---------------------------------------------------------------------------
// Pixel Format Mode
//---------------------------------------------------------------------------
type
  TPixelOffsetMode = (
    PixelOffsetModeInvalid     = Ord(QualityModeInvalid),
    PixelOffsetModeDefault     = Ord(QualityModeDefault),
    PixelOffsetModeHighSpeed   = Ord(QualityModeLow),
    PixelOffsetModeHighQuality = Ord(QualityModeHigh),
    PixelOffsetModeNone,    // No pixel offset
    PixelOffsetModeHalf     // Offset by -0.5, -0.5 for fast anti-alias perf
  );
  PPixelOffsetMode = ^TPixelOffsetMode;

//---------------------------------------------------------------------------
// Text Rendering Hint
//---------------------------------------------------------------------------
type
  TTextRenderingHint = (
    TextRenderingHintSystemDefault = 0,         // Glyph with system default rendering hint
    TextRenderingHintSingleBitPerPixelGridFit,  // Glyph bitmap with hinting
    TextRenderingHintSingleBitPerPixel,         // Glyph bitmap without hinting
    TextRenderingHintAntiAliasGridFit,          // Glyph anti-alias bitmap with hinting
    TextRenderingHintAntiAlias,                 // Glyph anti-alias bitmap without hinting
    TextRenderingHintClearTypeGridFit           // Glyph CT bitmap with hinting
  );
  PTextRenderingHint = ^TTextRenderingHint;

//---------------------------------------------------------------------------
// Metafile Types
//---------------------------------------------------------------------------
type
  TMetafileType = (
    MetafileTypeInvalid,        // Invalid metafile
    MetafileTypeWmf,            // Standard WMF
    MetafileTypeWmfPlaceable,   // Placeable WMF
    MetafileTypeEmf,            // EMF (not EMF+)
    MetafileTypeEmfPlusOnly,    // EMF+ without dual, down-level records
    MetafileTypeEmfPlusDual     // EMF+ with dual, down-level records
  );
  PMetafileType = ^TMetafileType;

//---------------------------------------------------------------------------
// Specifies the type of EMF to record
//---------------------------------------------------------------------------
type
  TEmfType = (
    EmfTypeEmfOnly     = Ord(MetafileTypeEmf),          // no EMF+, only EMF
    EmfTypeEmfPlusOnly = Ord(MetafileTypeEmfPlusOnly),  // no EMF, only EMF+
    EmfTypeEmfPlusDual = Ord(MetafileTypeEmfPlusDual)   // both EMF+ and EMF
  );
  PEmfType = ^TEmfType;

//---------------------------------------------------------------------------
// EMF+ Persistent object types
//---------------------------------------------------------------------------
type
  TObjectType = (
    ObjectTypeInvalid,
    ObjectTypeBrush,
    ObjectTypePen,
    ObjectTypePath,
    ObjectTypeRegion,
    ObjectTypeImage,
    ObjectTypeFont,
    ObjectTypeStringFormat,
    ObjectTypeImageAttributes,
    ObjectTypeCustomLineCap,
  {$IF GDIPVER >= $0110} 
    ObjectTypeGraphics,

    ObjectTypeMax = ObjectTypeGraphics,
  {$ELSE}
    ObjectTypeMax = ObjectTypeCustomLineCap,
  {$IFEND}
    ObjectTypeMin = ObjectTypeBrush
  );
  PObjectType = ^TObjectType;

Function ObjectTypeIsValid(type_: TObjectType): BOOL;{$IFDEF CanInline} inline;{$ENDIF}

//---------------------------------------------------------------------------
// EMF+ Records
//---------------------------------------------------------------------------

// We have to change the WMF record numbers so that they don't conflict with
// the EMF and EMF+ record numbers.
const
  GDIP_EMFPLUS_RECORD_BASE = $00004000;
  GDIP_WMF_RECORD_BASE     = $00010000;

type
  TEmfPlusRecordType = (
   // Since we have to enumerate GDI records right along with GDI+ records,
   // We list all the GDI records here so that they can be part of the
   // same enumeration type which is used in the enumeration callback.

    WmfRecordTypeSetBkColor            = (META_SETBKCOLOR or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetBkMode             = (META_SETBKMODE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetMapMode            = (META_SETMAPMODE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetROP2               = (META_SETROP2 or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetRelAbs             = (META_SETRELABS or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetPolyFillMode       = (META_SETPOLYFILLMODE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetStretchBltMode     = (META_SETSTRETCHBLTMODE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetTextCharExtra      = (META_SETTEXTCHAREXTRA or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetTextColor          = (META_SETTEXTCOLOR or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetTextJustification  = (META_SETTEXTJUSTIFICATION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetWindowOrg          = (META_SETWINDOWORG or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetWindowExt          = (META_SETWINDOWEXT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetViewportOrg        = (META_SETVIEWPORTORG or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetViewportExt        = (META_SETVIEWPORTEXT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeOffsetWindowOrg       = (META_OFFSETWINDOWORG or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeScaleWindowExt        = (META_SCALEWINDOWEXT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeOffsetViewportOrg     = (META_OFFSETVIEWPORTORG or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeScaleViewportExt      = (META_SCALEVIEWPORTEXT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeLineTo                = (META_LINETO or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeMoveTo                = (META_MOVETO or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeExcludeClipRect       = (META_EXCLUDECLIPRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeIntersectClipRect     = (META_INTERSECTCLIPRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeArc                   = (META_ARC or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeEllipse               = (META_ELLIPSE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeFloodFill             = (META_FLOODFILL or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePie                   = (META_PIE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeRectangle             = (META_RECTANGLE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeRoundRect             = (META_ROUNDRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePatBlt                = (META_PATBLT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSaveDC                = (META_SAVEDC or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetPixel              = (META_SETPIXEL or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeOffsetClipRgn         = (META_OFFSETCLIPRGN or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeTextOut               = (META_TEXTOUT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeBitBlt                = (META_BITBLT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeStretchBlt            = (META_STRETCHBLT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePolygon               = (META_POLYGON or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePolyline              = (META_POLYLINE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeEscape                = (META_ESCAPE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeRestoreDC             = (META_RESTOREDC or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeFillRegion            = (META_FILLREGION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeFrameRegion           = (META_FRAMEREGION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeInvertRegion          = (META_INVERTREGION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePaintRegion           = (META_PAINTREGION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSelectClipRegion      = (META_SELECTCLIPREGION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSelectObject          = (META_SELECTOBJECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetTextAlign          = (META_SETTEXTALIGN or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeDrawText              = ($062F or GDIP_WMF_RECORD_BASE),  // META_DRAWTEXT
    WmfRecordTypeChord                 = (META_CHORD or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetMapperFlags        = (META_SETMAPPERFLAGS or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeExtTextOut            = (META_EXTTEXTOUT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetDIBToDev           = (META_SETDIBTODEV or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSelectPalette         = (META_SELECTPALETTE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeRealizePalette        = (META_REALIZEPALETTE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeAnimatePalette        = (META_ANIMATEPALETTE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetPalEntries         = (META_SETPALENTRIES or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePolyPolygon           = (META_POLYPOLYGON or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeResizePalette         = (META_RESIZEPALETTE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeDIBBitBlt             = (META_DIBBITBLT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeDIBStretchBlt         = (META_DIBSTRETCHBLT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeDIBCreatePatternBrush = (META_DIBCREATEPATTERNBRUSH or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeStretchDIB            = (META_STRETCHDIB or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeExtFloodFill          = (META_EXTFLOODFILL or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetLayout             = ($0149 or GDIP_WMF_RECORD_BASE),  // META_SETLAYOUT
    WmfRecordTypeResetDC               = ($014C or GDIP_WMF_RECORD_BASE),  // META_RESETDC
    WmfRecordTypeStartDoc              = ($014D or GDIP_WMF_RECORD_BASE),  // META_STARTDOC
    WmfRecordTypeStartPage             = ($004F or GDIP_WMF_RECORD_BASE),  // META_STARTPAGE
    WmfRecordTypeEndPage               = ($0050 or GDIP_WMF_RECORD_BASE),  // META_ENDPAGE
    WmfRecordTypeAbortDoc              = ($0052 or GDIP_WMF_RECORD_BASE),  // META_ABORTDOC
    WmfRecordTypeEndDoc                = ($005E or GDIP_WMF_RECORD_BASE),  // META_ENDDOC
    WmfRecordTypeDeleteObject          = (META_DELETEOBJECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreatePalette         = (META_CREATEPALETTE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreateBrush           = ($00F8 or GDIP_WMF_RECORD_BASE),  // META_CREATEBRUSH
    WmfRecordTypeCreatePatternBrush    = (META_CREATEPATTERNBRUSH or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreatePenIndirect     = (META_CREATEPENINDIRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreateFontIndirect    = (META_CREATEFONTINDIRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreateBrushIndirect   = (META_CREATEBRUSHINDIRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreateBitmapIndirect  = ($02FD or GDIP_WMF_RECORD_BASE),  // META_CREATEBITMAPINDIRECT
    WmfRecordTypeCreateBitmap          = ($06FE or GDIP_WMF_RECORD_BASE),  // META_CREATEBITMAP
    WmfRecordTypeCreateRegion          = (META_CREATEREGION or GDIP_WMF_RECORD_BASE),

    EmfRecordTypeHeader                  = EMR_HEADER,
    EmfRecordTypePolyBezier              = EMR_POLYBEZIER,
    EmfRecordTypePolygon                 = EMR_POLYGON,
    EmfRecordTypePolyline                = EMR_POLYLINE,
    EmfRecordTypePolyBezierTo            = EMR_POLYBEZIERTO,
    EmfRecordTypePolyLineTo              = EMR_POLYLINETO,
    EmfRecordTypePolyPolyline            = EMR_POLYPOLYLINE,
    EmfRecordTypePolyPolygon             = EMR_POLYPOLYGON,
    EmfRecordTypeSetWindowExtEx          = EMR_SETWINDOWEXTEX,
    EmfRecordTypeSetWindowOrgEx          = EMR_SETWINDOWORGEX,
    EmfRecordTypeSetViewportExtEx        = EMR_SETVIEWPORTEXTEX,
    EmfRecordTypeSetViewportOrgEx        = EMR_SETVIEWPORTORGEX,
    EmfRecordTypeSetBrushOrgEx           = EMR_SETBRUSHORGEX,
    EmfRecordTypeEOF                     = EMR_EOF,
    EmfRecordTypeSetPixelV               = EMR_SETPIXELV,
    EmfRecordTypeSetMapperFlags          = EMR_SETMAPPERFLAGS,
    EmfRecordTypeSetMapMode              = EMR_SETMAPMODE,
    EmfRecordTypeSetBkMode               = EMR_SETBKMODE,
    EmfRecordTypeSetPolyFillMode         = EMR_SETPOLYFILLMODE,
    EmfRecordTypeSetROP2                 = EMR_SETROP2,
    EmfRecordTypeSetStretchBltMode       = EMR_SETSTRETCHBLTMODE,
    EmfRecordTypeSetTextAlign            = EMR_SETTEXTALIGN,
    EmfRecordTypeSetColorAdjustment      = EMR_SETCOLORADJUSTMENT,
    EmfRecordTypeSetTextColor            = EMR_SETTEXTCOLOR,
    EmfRecordTypeSetBkColor              = EMR_SETBKCOLOR,
    EmfRecordTypeOffsetClipRgn           = EMR_OFFSETCLIPRGN,
    EmfRecordTypeMoveToEx                = EMR_MOVETOEX,
    EmfRecordTypeSetMetaRgn              = EMR_SETMETARGN,
    EmfRecordTypeExcludeClipRect         = EMR_EXCLUDECLIPRECT,
    EmfRecordTypeIntersectClipRect       = EMR_INTERSECTCLIPRECT,
    EmfRecordTypeScaleViewportExtEx      = EMR_SCALEVIEWPORTEXTEX,
    EmfRecordTypeScaleWindowExtEx        = EMR_SCALEWINDOWEXTEX,
    EmfRecordTypeSaveDC                  = EMR_SAVEDC,
    EmfRecordTypeRestoreDC               = EMR_RESTOREDC,
    EmfRecordTypeSetWorldTransform       = EMR_SETWORLDTRANSFORM,
    EmfRecordTypeModifyWorldTransform    = EMR_MODIFYWORLDTRANSFORM,
    EmfRecordTypeSelectObject            = EMR_SELECTOBJECT,
    EmfRecordTypeCreatePen               = EMR_CREATEPEN,
    EmfRecordTypeCreateBrushIndirect     = EMR_CREATEBRUSHINDIRECT,
    EmfRecordTypeDeleteObject            = EMR_DELETEOBJECT,
    EmfRecordTypeAngleArc                = EMR_ANGLEARC,
    EmfRecordTypeEllipse                 = EMR_ELLIPSE,
    EmfRecordTypeRectangle               = EMR_RECTANGLE,
    EmfRecordTypeRoundRect               = EMR_ROUNDRECT,
    EmfRecordTypeArc                     = EMR_ARC,
    EmfRecordTypeChord                   = EMR_CHORD,
    EmfRecordTypePie                     = EMR_PIE,
    EmfRecordTypeSelectPalette           = EMR_SELECTPALETTE,
    EmfRecordTypeCreatePalette           = EMR_CREATEPALETTE,
    EmfRecordTypeSetPaletteEntries       = EMR_SETPALETTEENTRIES,
    EmfRecordTypeResizePalette           = EMR_RESIZEPALETTE,
    EmfRecordTypeRealizePalette          = EMR_REALIZEPALETTE,
    EmfRecordTypeExtFloodFill            = EMR_EXTFLOODFILL,
    EmfRecordTypeLineTo                  = EMR_LINETO,
    EmfRecordTypeArcTo                   = EMR_ARCTO,
    EmfRecordTypePolyDraw                = EMR_POLYDRAW,
    EmfRecordTypeSetArcDirection         = EMR_SETARCDIRECTION,
    EmfRecordTypeSetMiterLimit           = EMR_SETMITERLIMIT,
    EmfRecordTypeBeginPath               = EMR_BEGINPATH,
    EmfRecordTypeEndPath                 = EMR_ENDPATH,
    EmfRecordTypeCloseFigure             = EMR_CLOSEFIGURE,
    EmfRecordTypeFillPath                = EMR_FILLPATH,
    EmfRecordTypeStrokeAndFillPath       = EMR_STROKEANDFILLPATH,
    EmfRecordTypeStrokePath              = EMR_STROKEPATH,
    EmfRecordTypeFlattenPath             = EMR_FLATTENPATH,
    EmfRecordTypeWidenPath               = EMR_WIDENPATH,
    EmfRecordTypeSelectClipPath          = EMR_SELECTCLIPPATH,
    EmfRecordTypeAbortPath               = EMR_ABORTPATH,
    EmfRecordTypeReserved_069            = 69,  // Not Used
    EmfRecordTypeGdiComment              = EMR_GDICOMMENT,
    EmfRecordTypeFillRgn                 = EMR_FILLRGN,
    EmfRecordTypeFrameRgn                = EMR_FRAMERGN,
    EmfRecordTypeInvertRgn               = EMR_INVERTRGN,
    EmfRecordTypePaintRgn                = EMR_PAINTRGN,
    EmfRecordTypeExtSelectClipRgn        = EMR_EXTSELECTCLIPRGN,
    EmfRecordTypeBitBlt                  = EMR_BITBLT,
    EmfRecordTypeStretchBlt              = EMR_STRETCHBLT,
    EmfRecordTypeMaskBlt                 = EMR_MASKBLT,
    EmfRecordTypePlgBlt                  = EMR_PLGBLT,
    EmfRecordTypeSetDIBitsToDevice       = EMR_SETDIBITSTODEVICE,
    EmfRecordTypeStretchDIBits           = EMR_STRETCHDIBITS,
    EmfRecordTypeExtCreateFontIndirect   = EMR_EXTCREATEFONTINDIRECTW,
    EmfRecordTypeExtTextOutA             = EMR_EXTTEXTOUTA,
    EmfRecordTypeExtTextOutW             = EMR_EXTTEXTOUTW,
    EmfRecordTypePolyBezier16            = EMR_POLYBEZIER16,
    EmfRecordTypePolygon16               = EMR_POLYGON16,
    EmfRecordTypePolyline16              = EMR_POLYLINE16,
    EmfRecordTypePolyBezierTo16          = EMR_POLYBEZIERTO16,
    EmfRecordTypePolylineTo16            = EMR_POLYLINETO16,
    EmfRecordTypePolyPolyline16          = EMR_POLYPOLYLINE16,
    EmfRecordTypePolyPolygon16           = EMR_POLYPOLYGON16,
    EmfRecordTypePolyDraw16              = EMR_POLYDRAW16,
    EmfRecordTypeCreateMonoBrush         = EMR_CREATEMONOBRUSH,
    EmfRecordTypeCreateDIBPatternBrushPt = EMR_CREATEDIBPATTERNBRUSHPT,
    EmfRecordTypeExtCreatePen            = EMR_EXTCREATEPEN,
    EmfRecordTypePolyTextOutA            = EMR_POLYTEXTOUTA,
    EmfRecordTypePolyTextOutW            = EMR_POLYTEXTOUTW,
    EmfRecordTypeSetICMMode              = 98,  // EMR_SETICMMODE,
    EmfRecordTypeCreateColorSpace        = 99,  // EMR_CREATECOLORSPACE,
    EmfRecordTypeSetColorSpace           = 100, // EMR_SETCOLORSPACE,
    EmfRecordTypeDeleteColorSpace        = 101, // EMR_DELETECOLORSPACE,
    EmfRecordTypeGLSRecord               = 102, // EMR_GLSRECORD,
    EmfRecordTypeGLSBoundedRecord        = 103, // EMR_GLSBOUNDEDRECORD,
    EmfRecordTypePixelFormat             = 104, // EMR_PIXELFORMAT,
    EmfRecordTypeDrawEscape              = 105, // EMR_RESERVED_105,
    EmfRecordTypeExtEscape               = 106, // EMR_RESERVED_106,
    EmfRecordTypeStartDoc                = 107, // EMR_RESERVED_107,
    EmfRecordTypeSmallTextOut            = 108, // EMR_RESERVED_108,
    EmfRecordTypeForceUFIMapping         = 109, // EMR_RESERVED_109,
    EmfRecordTypeNamedEscape             = 110, // EMR_RESERVED_110,
    EmfRecordTypeColorCorrectPalette     = 111, // EMR_COLORCORRECTPALETTE,
    EmfRecordTypeSetICMProfileA          = 112, // EMR_SETICMPROFILEA,
    EmfRecordTypeSetICMProfileW          = 113, // EMR_SETICMPROFILEW,
    EmfRecordTypeAlphaBlend              = 114, // EMR_ALPHABLEND,
    EmfRecordTypeSetLayout               = 115, // EMR_SETLAYOUT,
    EmfRecordTypeTransparentBlt          = 116, // EMR_TRANSPARENTBLT,
    EmfRecordTypeReserved_117            = 117, // Not Used
    EmfRecordTypeGradientFill            = 118, // EMR_GRADIENTFILL,
    EmfRecordTypeSetLinkedUFIs           = 119, // EMR_RESERVED_119,
    EmfRecordTypeSetTextJustification    = 120, // EMR_RESERVED_120,
    EmfRecordTypeColorMatchToTargetW     = 121, // EMR_COLORMATCHTOTARGETW,
    EmfRecordTypeCreateColorSpaceW       = 122, // EMR_CREATECOLORSPACEW,
    EmfRecordTypeMax                     = 122,
    EmfRecordTypeMin                     = 1,

    // That is the END of the GDI EMF records.

    // Now we start the list of EMF+ records.  We leave quite
    // a bit of room here for the addition of any new GDI
    // records that may be added later.

    EmfPlusRecordTypeInvalid = GDIP_EMFPLUS_RECORD_BASE,
    EmfPlusRecordTypeHeader,
    EmfPlusRecordTypeEndOfFile,

    EmfPlusRecordTypeComment,

    EmfPlusRecordTypeGetDC,

    EmfPlusRecordTypeMultiFormatStart,
    EmfPlusRecordTypeMultiFormatSection,
    EmfPlusRecordTypeMultiFormatEnd,

    // For all persistent objects

    EmfPlusRecordTypeObject,

    // Drawing Records

    EmfPlusRecordTypeClear,
    EmfPlusRecordTypeFillRects,
    EmfPlusRecordTypeDrawRects,
    EmfPlusRecordTypeFillPolygon,
    EmfPlusRecordTypeDrawLines,
    EmfPlusRecordTypeFillEllipse,
    EmfPlusRecordTypeDrawEllipse,
    EmfPlusRecordTypeFillPie,
    EmfPlusRecordTypeDrawPie,
    EmfPlusRecordTypeDrawArc,
    EmfPlusRecordTypeFillRegion,
    EmfPlusRecordTypeFillPath,
    EmfPlusRecordTypeDrawPath,
    EmfPlusRecordTypeFillClosedCurve,
    EmfPlusRecordTypeDrawClosedCurve,
    EmfPlusRecordTypeDrawCurve,
    EmfPlusRecordTypeDrawBeziers,
    EmfPlusRecordTypeDrawImage,
    EmfPlusRecordTypeDrawImagePoints,
    EmfPlusRecordTypeDrawString,

    // Graphics State Records

    EmfPlusRecordTypeSetRenderingOrigin,
    EmfPlusRecordTypeSetAntiAliasMode,
    EmfPlusRecordTypeSetTextRenderingHint,
    EmfPlusRecordTypeSetTextContrast,
    EmfPlusRecordTypeSetInterpolationMode,
    EmfPlusRecordTypeSetPixelOffsetMode,
    EmfPlusRecordTypeSetCompositingMode,
    EmfPlusRecordTypeSetCompositingQuality,
    EmfPlusRecordTypeSave,
    EmfPlusRecordTypeRestore,
    EmfPlusRecordTypeBeginContainer,
    EmfPlusRecordTypeBeginContainerNoParams,
    EmfPlusRecordTypeEndContainer,
    EmfPlusRecordTypeSetWorldTransform,
    EmfPlusRecordTypeResetWorldTransform,
    EmfPlusRecordTypeMultiplyWorldTransform,
    EmfPlusRecordTypeTranslateWorldTransform,
    EmfPlusRecordTypeScaleWorldTransform,
    EmfPlusRecordTypeRotateWorldTransform,
    EmfPlusRecordTypeSetPageTransform,
    EmfPlusRecordTypeResetClip,
    EmfPlusRecordTypeSetClipRect,
    EmfPlusRecordTypeSetClipPath,
    EmfPlusRecordTypeSetClipRegion,
    EmfPlusRecordTypeOffsetClip,

    EmfPlusRecordTypeDrawDriverString,
  {$IF GDIPVER >= $0110}
    EmfPlusRecordTypeStrokeFillPath,
    EmfPlusRecordTypeSerializableObject,

    EmfPlusRecordTypeSetTSGraphics,
    EmfPlusRecordTypeSetTSClip,
  {$IFEND}
    // NOTE: New records *must* be added immediately before this line.

    EmfPlusRecordTotal,

    EmfPlusRecordTypeMax = EmfPlusRecordTotal-1,
    EmfPlusRecordTypeMin = EmfPlusRecordTypeHeader
  );
  PEmfPlusRecordType = ^TEmfPlusRecordType;

Function GDIP_WMF_RECORD_TO_EMFPLUS(Value: TEmfPlusRecordType): TEmfPlusRecordType;
Function GDIP_EMFPLUS_RECORD_TO_WMF(Value: TEmfPlusRecordType): TEmfPlusRecordType;
Function GDIP_IS_WMF_RECORDTYPE(Value: TEmfPlusRecordType): Boolean;

//---------------------------------------------------------------------------
// StringFormatFlags
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
// String format flags
//
//  DirectionRightToLeft          - For horizontal text, the reading order is
//                                  right to left. This value is called
//                                  the base embedding level by the Unicode
//                                  bidirectional engine.
//                                  For vertical text, columns are read from
//                                  right to left.
//                                  By default, horizontal or vertical text is
//                                  read from left to right.
//
//  DirectionVertical             - Individual lines of text are vertical. In
//                                  each line, characters progress from top to
//                                  bottom.
//                                  By default, lines of text are horizontal,
//                                  each new line below the previous line.
//
//  NoFitBlackBox                 - Allows parts of glyphs to overhang the
//                                  bounding rectangle.
//                                  By default glyphs are first aligned
//                                  inside the margines, then any glyphs which
//                                  still overhang the bounding box are
//                                  repositioned to avoid any overhang.
//                                  For example when an italic
//                                  lower case letter f in a font such as
//                                  Garamond is aligned at the far left of a
//                                  rectangle, the lower part of the f will
//                                  reach slightly further left than the left
//                                  edge of the rectangle. Setting this flag
//                                  will ensure the character aligns visually
//                                  with the lines above and below, but may
//                                  cause some pixels outside the formatting
//                                  rectangle to be clipped or painted.
//
//  DisplayFormatControl          - Causes control characters such as the
//                                  left-to-right mark to be shown in the
//                                  output with a representative glyph.
//
//  NoFontFallback                - Disables fallback to alternate fonts for
//                                  characters not supported in the requested
//                                  font. Any missing characters will be
//                                  be displayed with the fonts missing glyph,
//                                  usually an open square.
//
//  NoWrap                        - Disables wrapping of text between lines
//                                  when formatting within a rectangle.
//                                  NoWrap is implied when a point is passed
//                                  instead of a rectangle, or when the
//                                  specified rectangle has a zero line length.
//
//  NoClip                        - By default text is clipped to the
//                                  formatting rectangle. Setting NoClip
//                                  allows overhanging pixels to affect the
//                                  device outside the formatting rectangle.
//                                  Pixels at the end of the line may be
//                                  affected if the glyphs overhang their
//                                  cells, and either the NoFitBlackBox flag
//                                  has been set, or the glyph extends to far
//                                  to be fitted.
//                                  Pixels above/before the first line or
//                                  below/after the last line may be affected
//                                  if the glyphs extend beyond their cell
//                                  ascent / descent. This can occur rarely
//                                  with unusual diacritic mark combinations.

//---------------------------------------------------------------------------
type
  TStringFormatFlags = INT;     PStringFormatFlags = ^TStringFormatFlags;
const
  StringFormatFlagsDirectionRightToLeft  = $00000001;
  StringFormatFlagsDirectionVertical     = $00000002;
  StringFormatFlagsNoFitBlackBox         = $00000004;
  StringFormatFlagsDisplayFormatControl  = $00000020;
  StringFormatFlagsNoFontFallback        = $00000400;
  StringFormatFlagsMeasureTrailingSpaces = $00000800;
  StringFormatFlagsNoWrap                = $00001000;
  StringFormatFlagsLineLimit             = $00002000;

  StringFormatFlagsNoClip                = $00004000;
  StringFormatFlagsBypassGDI             = $80000000;

//---------------------------------------------------------------------------
// StringTrimming
//---------------------------------------------------------------------------
type
  TStringTrimming = (
    StringTrimmingNone              = 0,
    StringTrimmingCharacter         = 1,
    StringTrimmingWord              = 2,
    StringTrimmingEllipsisCharacter = 3,
    StringTrimmingEllipsisWord      = 4,
    StringTrimmingEllipsisPath      = 5
  );
  PStringTrimming = ^TStringTrimming;

//---------------------------------------------------------------------------
// National language digit substitution
//---------------------------------------------------------------------------
type
  TStringDigitSubstitute = (
    StringDigitSubstituteUser        = 0,  // As NLS setting
    StringDigitSubstituteNone        = 1,
    StringDigitSubstituteNational    = 2,
    StringDigitSubstituteTraditional = 3
  );
  PStringDigitSubstitute = ^TStringDigitSubstitute;

//---------------------------------------------------------------------------
// Hotkey prefix interpretation
//---------------------------------------------------------------------------
type
  THotkeyPrefix = (
    HotkeyPrefixNone = 0,
    HotkeyPrefixShow = 1,
    HotkeyPrefixHide = 2
  );
  PHotkeyPrefix = ^THotkeyPrefix;

//---------------------------------------------------------------------------
// String alignment flags
//---------------------------------------------------------------------------
type
  TStringAlignment = (
    // Left edge for left-to-right text,
    // right for right-to-left text,
    // and top for vertical
    StringAlignmentNear   = 0,
    StringAlignmentCenter = 1,
    StringAlignmentFar    = 2
  );
  PStringAlignment = ^TStringAlignment;

//---------------------------------------------------------------------------
// DriverStringOptions
//---------------------------------------------------------------------------
type
  TDriverStringOptions = INT;     PDriverStringOptions = ^TDriverStringOptions;
const
  DriverStringOptionsCmapLookup      = 1;
  DriverStringOptionsVertical        = 2;
  DriverStringOptionsRealizedAdvance = 4;
  DriverStringOptionsLimitSubpixel   = 8;

//---------------------------------------------------------------------------
// Flush Intention flags
//---------------------------------------------------------------------------
type
  TFlushIntention = (
    FlushIntentionFlush = 0,  // Flush all batched rendering operations
    FlushIntentionSync  = 1   // Flush all batched rendering operations
                              // and wait for them to complete
  );
  PFlushIntention = ^TFlushIntention;

//---------------------------------------------------------------------------
// Image encoder parameter related types
//---------------------------------------------------------------------------
type
  TEncoderParameterValueType = (
    EncoderParameterValueTypeByte           = 1,  // 8-bit unsigned int
    EncoderParameterValueTypeASCII          = 2,  // 8-bit byte containing one 7-bit ASCII
                                                  // code. NULL terminated.
    EncoderParameterValueTypeShort          = 3,  // 16-bit unsigned int
    EncoderParameterValueTypeLong           = 4,  // 32-bit unsigned int
    EncoderParameterValueTypeRational       = 5,  // Two Longs. The first Long is the
                                                  // numerator, the second Long expresses the
                                                  // denomintor.
    EncoderParameterValueTypeLongRange      = 6,  // Two longs which specify a range of
                                                  // integer values. The first Long specifies
                                                  // the lower end and the second one
                                                  // specifies the higher end. All values
                                                  // are inclusive at both ends
    EncoderParameterValueTypeUndefined      = 7,  // 8-bit byte that can take any value
                                                  // depending on field definition
    EncoderParameterValueTypeRationalRange  = 8   // Two Rationals. The first Rational
                                                  // specifies the lower end and the second
                                                  // specifies the higher end. All values
                                                  // are inclusive at both ends
  {$IF GDIPVER >= $0110},
    EncoderParameterValueTypePointer        = 9   // a pointer to a parameter defined data.
  {$IFEND}
  );
  PEncoderParameterValueType = ^TEncoderParameterValueType;

//---------------------------------------------------------------------------
// Image encoder value types
//---------------------------------------------------------------------------
type
  TEncoderValue = (
    EncoderValueColorTypeCMYK,
    EncoderValueColorTypeYCCK,
    EncoderValueCompressionLZW,
    EncoderValueCompressionCCITT3,
    EncoderValueCompressionCCITT4,
    EncoderValueCompressionRle,
    EncoderValueCompressionNone,
    EncoderValueScanMethodInterlaced,
    EncoderValueScanMethodNonInterlaced,
    EncoderValueVersionGif87,
    EncoderValueVersionGif89,
    EncoderValueRenderProgressive,
    EncoderValueRenderNonProgressive,
    EncoderValueTransformRotate90,
    EncoderValueTransformRotate180,
    EncoderValueTransformRotate270,
    EncoderValueTransformFlipHorizontal,
    EncoderValueTransformFlipVertical,
    EncoderValueMultiFrame,
    EncoderValueLastFrame,
    EncoderValueFlush,
    EncoderValueFrameDimensionTime,
    EncoderValueFrameDimensionResolution,
    EncoderValueFrameDimensionPage
  {$IF GDIPVER >= $0110},
    EncoderValueColorTypeGray,
    EncoderValueColorTypeRGB
  {$IFEND}
  );
  PEncoderValue = ^TEncoderValue;

//---------------------------------------------------------------------------
// Conversion of Emf To WMF Bits flags
//---------------------------------------------------------------------------
type
  TEmfToWmfBitsFlags = (
    EmfToWmfBitsFlagsDefault          = $00000000,
    EmfToWmfBitsFlagsEmbedEmf         = $00000001,
    EmfToWmfBitsFlagsIncludePlaceable = $00000002,
    EmfToWmfBitsFlagsNoXORClip        = $00000004
  );
  PEmfToWmfBitsFlags = ^TEmfToWmfBitsFlags;

{$IF GDIPVER >= $0110}
//---------------------------------------------------------------------------
// Conversion of Emf To Emf+ Bits flags
//---------------------------------------------------------------------------
type
  TConvertToEmfPlusFlags = (
    ConvertToEmfPlusFlagsDefault       = $00000000,
    ConvertToEmfPlusFlagsRopUsed       = $00000001,
    ConvertToEmfPlusFlagsText          = $00000002,
    ConvertToEmfPlusFlagsInvalidRecord = $00000004
  );
  PConvertToEmfPlusFlags = ^TConvertToEmfPlusFlags;
{$IFEND}

//---------------------------------------------------------------------------
// Test Control flags
//---------------------------------------------------------------------------
type
  TGpTestControlEnum = (
    TestControlForceBilinear  = 0,
    TestControlNoICM          = 1,
    TestControlGetBuildNumber = 2
  );
  PGpTestControlEnum = ^TGpTestControlEnum;

implementation

Function ObjectTypeIsValid(type_: TObjectType): BOOL;
begin
Result := (type_ >= ObjectTypeMin) and (type_ <= ObjectTypeMax)
end;

//!!----------------------------------------------------------------------------

Function GDIP_WMF_RECORD_TO_EMFPLUS(Value: TEmfPlusRecordType): TEmfPlusRecordType;
begin
Result := TEmfPlusRecordType(Ord(Value) or GDIP_WMF_RECORD_BASE);
end;

//!!----------------------------------------------------------------------------

Function GDIP_EMFPLUS_RECORD_TO_WMF(Value: TEmfPlusRecordType): TEmfPlusRecordType;
begin
Result := TEmfPlusRecordType(Ord(Value) and not GDIP_WMF_RECORD_BASE);
end;

//!!----------------------------------------------------------------------------

Function GDIP_IS_WMF_RECORDTYPE(Value: TEmfPlusRecordType): Boolean;
begin
Result := (Ord(Value) and GDIP_WMF_RECORD_BASE) <> 0;
end;

end.
