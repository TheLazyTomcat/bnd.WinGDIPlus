(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusColor.h
*
* Abstract:
*
*   GDI+ Color Object
*
\**************************************************************************)
unit gdipluscolor;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  gdipluspixelformats;

//----------------------------------------------------------------------------
// Color mode
//----------------------------------------------------------------------------
type
  TColorMode = (
    ColorModeARGB32 = 0,
    ColorModeARGB64 = 1
  );
  PColorMode = ^TColorMode;

//----------------------------------------------------------------------------
// Color Channel flags
//----------------------------------------------------------------------------
type
  TColorChannelFlags = (
    ColorChannelFlagsC = 0,
    ColorChannelFlagsM,
    ColorChannelFlagsY,
    ColorChannelFlagsK,
    ColorChannelFlagsLast
  );
  PColorChannelFlags = ^TColorChannelFlags;

//----------------------------------------------------------------------------
// Color
//----------------------------------------------------------------------------
const
  // Common color constants
  AliceBlue            = $FFF0F8FF;
  AntiqueWhite         = $FFFAEBD7;
  Aqua                 = $FF00FFFF;
  Aquamarine           = $FF7FFFD4;
  Azure                = $FFF0FFFF;
  Beige                = $FFF5F5DC;
  Bisque               = $FFFFE4C4;
  Black                = $FF000000;
  BlanchedAlmond       = $FFFFEBCD;
  Blue                 = $FF0000FF;
  BlueViolet           = $FF8A2BE2;
  Brown                = $FFA52A2A;
  BurlyWood            = $FFDEB887;
  CadetBlue            = $FF5F9EA0;
  Chartreuse           = $FF7FFF00;
  Chocolate            = $FFD2691E;
  Coral                = $FFFF7F50;
  CornflowerBlue       = $FF6495ED;
  Cornsilk             = $FFFFF8DC;
  Crimson              = $FFDC143C;
  Cyan                 = $FF00FFFF;
  DarkBlue             = $FF00008B;
  DarkCyan             = $FF008B8B;
  DarkGoldenrod        = $FFB8860B;
  DarkGray             = $FFA9A9A9;
  DarkGreen            = $FF006400;
  DarkKhaki            = $FFBDB76B;
  DarkMagenta          = $FF8B008B;
  DarkOliveGreen       = $FF556B2F;
  DarkOrange           = $FFFF8C00;
  DarkOrchid           = $FF9932CC;
  DarkRed              = $FF8B0000;
  DarkSalmon           = $FFE9967A;
  DarkSeaGreen         = $FF8FBC8B;
  DarkSlateBlue        = $FF483D8B;
  DarkSlateGray        = $FF2F4F4F;
  DarkTurquoise        = $FF00CED1;
  DarkViolet           = $FF9400D3;
  DeepPink             = $FFFF1493;
  DeepSkyBlue          = $FF00BFFF;
  DimGray              = $FF696969;
  DodgerBlue           = $FF1E90FF;
  Firebrick            = $FFB22222;
  FloralWhite          = $FFFFFAF0;
  ForestGreen          = $FF228B22;
  Fuchsia              = $FFFF00FF;
  Gainsboro            = $FFDCDCDC;
  GhostWhite           = $FFF8F8FF;
  Gold                 = $FFFFD700;
  Goldenrod            = $FFDAA520;
  Gray                 = $FF808080;
  Green                = $FF008000;
  GreenYellow          = $FFADFF2F;
  Honeydew             = $FFF0FFF0;
  HotPink              = $FFFF69B4;
  IndianRed            = $FFCD5C5C;
  Indigo               = $FF4B0082;
  Ivory                = $FFFFFFF0;
  Khaki                = $FFF0E68C;
  Lavender             = $FFE6E6FA;
  LavenderBlush        = $FFFFF0F5;
  LawnGreen            = $FF7CFC00;
  LemonChiffon         = $FFFFFACD;
  LightBlue            = $FFADD8E6;
  LightCoral           = $FFF08080;
  LightCyan            = $FFE0FFFF;
  LightGoldenrodYellow = $FFFAFAD2;
  LightGray            = $FFD3D3D3;
  LightGreen           = $FF90EE90;
  LightPink            = $FFFFB6C1;
  LightSalmon          = $FFFFA07A;
  LightSeaGreen        = $FF20B2AA;
  LightSkyBlue         = $FF87CEFA;
  LightSlateGray       = $FF778899;
  LightSteelBlue       = $FFB0C4DE;
  LightYellow          = $FFFFFFE0;
  Lime                 = $FF00FF00;
  LimeGreen            = $FF32CD32;
  Linen                = $FFFAF0E6;
  Magenta              = $FFFF00FF;
  Maroon               = $FF800000;
  MediumAquamarine     = $FF66CDAA;
  MediumBlue           = $FF0000CD;
  MediumOrchid         = $FFBA55D3;
  MediumPurple         = $FF9370DB;
  MediumSeaGreen       = $FF3CB371;
  MediumSlateBlue      = $FF7B68EE;
  MediumSpringGreen    = $FF00FA9A;
  MediumTurquoise      = $FF48D1CC;
  MediumVioletRed      = $FFC71585;
  MidnightBlue         = $FF191970;
  MintCream            = $FFF5FFFA;
  MistyRose            = $FFFFE4E1;
  Moccasin             = $FFFFE4B5;
  NavajoWhite          = $FFFFDEAD;
  Navy                 = $FF000080;
  OldLace              = $FFFDF5E6;
  Olive                = $FF808000;
  OliveDrab            = $FF6B8E23;
  Orange               = $FFFFA500;
  OrangeRed            = $FFFF4500;
  Orchid               = $FFDA70D6;
  PaleGoldenrod        = $FFEEE8AA;
  PaleGreen            = $FF98FB98;
  PaleTurquoise        = $FFAFEEEE;
  PaleVioletRed        = $FFDB7093;
  PapayaWhip           = $FFFFEFD5;
  PeachPuff            = $FFFFDAB9;
  Peru                 = $FFCD853F;
  Pink                 = $FFFFC0CB;
  Plum                 = $FFDDA0DD;
  PowderBlue           = $FFB0E0E6;
  Purple               = $FF800080;
  Red                  = $FFFF0000;
  RosyBrown            = $FFBC8F8F;
  RoyalBlue            = $FF4169E1;
  SaddleBrown          = $FF8B4513;
  Salmon               = $FFFA8072;
  SandyBrown           = $FFF4A460;
  SeaGreen             = $FF2E8B57;
  SeaShell             = $FFFFF5EE;
  Sienna               = $FFA0522D;
  Silver               = $FFC0C0C0;
  SkyBlue              = $FF87CEEB;
  SlateBlue            = $FF6A5ACD;
  SlateGray            = $FF708090;
  Snow                 = $FFFFFAFA;
  SpringGreen          = $FF00FF7F;
  SteelBlue            = $FF4682B4;
  Tan                  = $FFD2B48C;
  Teal                 = $FF008080;
  Thistle              = $FFD8BFD8;
  Tomato               = $FFFF6347;
  Transparent          = $00FFFFFF;
  Turquoise            = $FF40E0D0;
  Violet               = $FFEE82EE;
  Wheat                = $FFF5DEB3;
  White                = $FFFFFFFF;
  WhiteSmoke           = $FFF5F5F5;
  Yellow               = $FFFFFF00;
  YellowGreen          = $FF9ACD32;

  // Shift count and bit mask for A, R, G, B components
  AlphaShift = 24;
  RedShift   = 16;
  GreenShift = 8;
  BlueShift  = 0;

  AlphaMask = $ff000000;
  RedMask   = $00ff0000;
  GreenMask = $0000ff00;
  BlueMask  = $000000ff;

{!!=============================================================================
    TColor - class declaration
===============================================================================}
type
  TColor = record
    Argb:  TARGB;
  end;
  PColor = ^TColor;

// Assemble A, R, G, B values into a 32-bit integer
Function MakeARGB(a,r,g,b: Byte): TARGB;

Function Color: TColor; overload;
// Construct an opaque Color object with
// the specified Red, Green, Blue values.
//
// Color values are not premultiplied.
Function Color(r,g,b: Byte): TColor; overload;
Function Color(a,r,g,b: Byte): TColor; overload;
Function Color(argb: TARGB): TColor; overload;

Function GetAlpha(Color: TColor): Byte;
Function GetA(Color: TColor): Byte;
Function GetRed(Color: TColor): Byte;
Function GetR(Color: TColor): Byte;
Function GetGreen(Color: TColor): Byte;
Function GetG(Color: TColor): Byte;
Function GetBlue(Color: TColor): Byte;
Function GetB(Color: TColor): Byte;

Function GetValue(Color: TColor): TARGB; overload;
procedure SetValue(var Color: TColor; argb: TARGB); overload;
procedure SetFromCOLORREF(var Color: TColor; rgb: TCOLORREF);
Function ToCOLORREF(Color: TColor): TCOLORREF;

implementation

{!!-----------------------------------------------------------------------------
    TColor - implementation
-------------------------------------------------------------------------------}

Function MakeARGB(a,r,g,b: Byte): TARGB;
begin
Result := (TARGB(b) shl BlueShift) or
          (TARGB(g) shl GreenShift) or
          (TARGB(r) shl RedShift) or
          (TARGB(a) shl AlphaShift);
end;

//!!----------------------------------------------------------------------------

Function Color: TColor;
begin
Result.Argb := TARGB(Black);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Color(r,g,b: Byte): TColor;
begin
Result.Argb := MakeARGB(255,r,g,b);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Color(a,r,g,b: Byte): TColor;
begin
Result.Argb := MakeARGB(a,r,g,b);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Color(argb: TARGB): TColor;
begin
Result.Argb := argb;
end;

//!!----------------------------------------------------------------------------

Function GetAlpha(Color: TColor): Byte;
begin
Result := Byte(Color.Argb shr AlphaShift);
end;

//!!----------------------------------------------------------------------------

Function GetA(Color: TColor): Byte;
begin
Result := GetAlpha(Color);
end;

//!!----------------------------------------------------------------------------

Function GetRed(Color: TColor): Byte;
begin
Result := Byte(Color.Argb shr RedShift);
end;

//!!----------------------------------------------------------------------------

Function GetR(Color: TColor): Byte;
begin
Result := GetRed(Color);
end;

//!!----------------------------------------------------------------------------

Function GetGreen(Color: TColor): Byte;
begin
Result := Byte(Color.Argb shr GreenShift);
end;

//!!----------------------------------------------------------------------------

Function GetG(Color: TColor): Byte;
begin
Result := GetGreen(Color);
end;

//!!---------------------------------------------------------------------------

Function GetBlue(Color: TColor): Byte;
begin
Result := Byte(Color.Argb shr BlueShift);
end;

//!!----------------------------------------------------------------------------

Function GetB(Color: TColor): Byte;
begin
Result := GetBlue(Color);
end;

//!!----------------------------------------------------------------------------

Function GetValue(Color: TColor): TARGB;
begin
Result := Color.Argb;
end;

//!!----------------------------------------------------------------------------

procedure SetValue(var Color: TColor; argb: TARGB);
begin
Color.Argb := argb;
end;

//!!----------------------------------------------------------------------------

procedure SetFromCOLORREF(var Color: TColor; rgb: TCOLORREF);
begin
Color.Argb := MakeARGB(255,GetRValue(rgb),GetGValue(rgb),GetBValue(rgb));
end;

//!!----------------------------------------------------------------------------

Function ToCOLORREF(Color: TColor): TCOLORREF;
begin
Result := RGB(GetRed(Color),GetGreen(Color),GetBlue(Color));
end;

end.
