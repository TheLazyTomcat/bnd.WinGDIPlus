unit gdipluspixelformats;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  gdiplus_common;

type
  TARGB   = DWORD;
  TARGB64 = DWORDLONG;

const
  ALPHA_SHIFT = 24;
  RED_SHIFT   = 16;
  GREEN_SHIFT = 8;
  BLUE_SHIFT  = 0;
  ALPHA_MASK  = TARGB($FF) shl ALPHA_SHIFT;

// In-memory pixel data formats:
// bits 0-7 = format index
// bits 8-15 = pixel size (in bits)
// bits 16-23 = flags
// bits 24-31 = reserved
type
  TPixelFormat = INT;

const
  PixelFormatIndexed   = $00010000; // Indexes into a palette
  PixelFormatGDI       = $00020000; // Is a GDI-supported format
  PixelFormatAlpha     = $00040000; // Has an alpha component
  PixelFormatPAlpha    = $00080000; // Pre-multiplied alpha
  PixelFormatExtended  = $00100000; // Extended color 16 bits/channel
  PixelFormatCanonical = $00200000;

  PixelFormatUndefined = 0;
  PixelFormatDontCare  = 0;

  PixelFormat1bppIndexed    = (1 or (1 shl 8) or PixelFormatIndexed or PixelFormatGDI);
  PixelFormat4bppIndexed    = (2 or (4 shl 8) or PixelFormatIndexed or PixelFormatGDI);
  PixelFormat8bppIndexed    = (3 or (8 shl 8) or PixelFormatIndexed or PixelFormatGDI);
  PixelFormat16bppGrayScale = (4 or (16 shl 8) or PixelFormatExtended);
  PixelFormat16bppRGB555    = (5 or (16 shl 8) or PixelFormatGDI);
  PixelFormat16bppRGB565    = (6 or (16 shl 8) or PixelFormatGDI);
  PixelFormat16bppARGB1555  = (7 or (16 shl 8) or PixelFormatAlpha or PixelFormatGDI);
  PixelFormat24bppRGB       = (8 or (24 shl 8) or PixelFormatGDI);
  PixelFormat32bppRGB       = (9 or (32 shl 8) or PixelFormatGDI);
  PixelFormat32bppARGB      = (10 or (32 shl 8) or PixelFormatAlpha or PixelFormatGDI or PixelFormatCanonical);
  PixelFormat32bppPARGB     = (11 or (32 shl 8) or PixelFormatAlpha or PixelFormatPAlpha or PixelFormatGDI);
  PixelFormat48bppRGB       = (12 or (48 shl 8) or PixelFormatExtended);
  PixelFormat64bppARGB      = (13 or (64 shl 8) or PixelFormatAlpha or PixelFormatCanonical or PixelFormatExtended);
  PixelFormat64bppPARGB     = (14 or (64 shl 8) or PixelFormatAlpha or PixelFormatPAlpha or PixelFormatExtended);
  PixelFormat32bppCMYK      = (15 or (32 shl 8));
  PixelFormatMax            = 16;

Function GetPixelFormatSize(pixfmt: TPixelFormat): UINT;{$IFDEF CanInline} inline;{$ENDIF}

Function IsIndexedPixelFormat(pixfmt: TPixelFormat): BOOL;{$IFDEF CanInline} inline;{$ENDIF}

Function IsAlphaPixelFormat(pixfmt: TPixelFormat): BOOL;{$IFDEF CanInline} inline;{$ENDIF}

Function IsExtendedPixelFormat(pixfmt: TPixelFormat): BOOL;{$IFDEF CanInline} inline;{$ENDIF}

//--------------------------------------------------------------------------
// Determine if the Pixel Format is Canonical format:
//   PixelFormat32bppARGB
//   PixelFormat32bppPARGB
//   PixelFormat64bppARGB
//   PixelFormat64bppPARGB
//--------------------------------------------------------------------------

Function IsCanonicalPixelFormat(pixfmt: TPixelFormat): BOOL;{$IFDEF CanInline} inline;{$ENDIF}

{$IF GDIPVER >= $0110}
//----------------------------------------------------------------------------
// Color format conversion parameters
//----------------------------------------------------------------------------
type
  TPaletteType = (
    // Arbitrary custom palette provided by caller.
    
    PaletteTypeCustom           = 0,
    
    // Optimal palette generated using a median-cut algorithm.
    
    PaletteTypeOptimal          = 1,
    
    // Black and white palette.
    
    PaletteTypeFixedBW          = 2,
    
    // Symmetric halftone palettes.
    // Each of these halftone palettes will be a superset of the system palette.
    // E.g. Halftone8 will have it's 8-color on-off primaries and the 16 system
    // colors added. With duplicates removed, that leaves 16 colors.
    
    PaletteTypeFixedHalftone8   = 3, // 8-color, on-off primaries
    PaletteTypeFixedHalftone27  = 4, // 3 intensity levels of each color
    PaletteTypeFixedHalftone64  = 5, // 4 intensity levels of each color
    PaletteTypeFixedHalftone125 = 6, // 5 intensity levels of each color
    PaletteTypeFixedHalftone216 = 7, // 6 intensity levels of each color

    // Assymetric halftone palettes.
    // These are somewhat less useful than the symmetric ones, but are 
    // included for completeness. These do not include all of the system
    // colors.
    
    PaletteTypeFixedHalftone252 = 8, // 6-red, 7-green, 6-blue intensities
    PaletteTypeFixedHalftone256 = 9  // 8-red, 8-green, 4-blue intensities
  );

  TDitherType = (
    DitherTypeNone           = 0,
    
    // Solid color - picks the nearest matching color with no attempt to 
    // halftone or dither. May be used on an arbitrary palette.
    
    DitherTypeSolid          = 1,
    
    // Ordered dithers and spiral dithers must be used with a fixed palette.
    
    // NOTE: DitherOrdered4x4 is unique in that it may apply to 16bpp 
    // conversions also.
    
    DitherTypeOrdered4x4     = 2,
    
    DitherTypeOrdered8x8     = 3,
    DitherTypeOrdered16x16   = 4,
    DitherTypeSpiral4x4      = 5,
    DitherTypeSpiral8x8      = 6,
    DitherTypeDualSpiral4x4  = 7,
    DitherTypeDualSpiral8x8  = 8,
    
    // Error diffusion. May be used with any palette.
    
    DitherTypeErrorDiffusion = 9,

    DitherTypeMax            = 10
  );
{$IFEND}

type
  TPaletteFlags = UINT;
const
  PaletteFlagsHasAlpha  = $0001;
  PaletteFlagsGrayScale = $0002;
  PaletteFlagsHalftone  = $0004;

type
  TColorPalette = record
    Flags:    UINT;                 // Palette flags
    Count:    UINT;                 // Number of color entries
    Entries:  array[0..0] of TARGB; // Palette color entries
  end;

implementation

Function GetPixelFormatSize(pixfmt: TPixelFormat): UINT;
begin
Result := (pixfmt shr 8) and $FF;
end;

//------------------------------------------------------------------------------

Function IsIndexedPixelFormat(pixfmt: TPixelFormat): BOOL;
begin
Result := (pixfmt and PixelFormatIndexed) <> 0;
end;

//------------------------------------------------------------------------------

Function IsAlphaPixelFormat(pixfmt: TPixelFormat): BOOL;
begin
Result := (pixfmt and PixelFormatAlpha) <> 0;
end;

//------------------------------------------------------------------------------

Function IsExtendedPixelFormat(pixfmt: TPixelFormat): BOOL;
begin
Result := (pixfmt and PixelFormatExtended) <> 0;
end;

//------------------------------------------------------------------------------

Function IsCanonicalPixelFormat(pixfmt: TPixelFormat): BOOL;
begin
Result := (pixfmt and PixelFormatCanonical) <> 0;
end;


end.
