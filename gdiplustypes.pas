(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusTypes.h
*
* Abstract:
*
*   GDI+ Types
*
\**************************************************************************)
unit gdiplustypes;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows, Math,
  gdiplus_common,
  gdiplusenums;

// Support NOMINMAX by defining local min max macros
Function GDIPLUS_MIN(a,b: Integer): Integer; overload;
Function GDIPLUS_MIN(a,b: Single): Single; overload;

Function GDIPLUS_MAX(a,b: Integer): Integer; overload;
Function GDIPLUS_MAX(a,b: Single): Single; overload;

//--------------------------------------------------------------------------
// Callback functions
//--------------------------------------------------------------------------
type
  TImageAbort = Function(Param: Pointer): BOOL; stdcall;
  TDrawImageAbort = TImageAbort;
  TGetThumbnailImageAbort = TImageAbort;

  TEnumerateMetafileProc = Function(RecordType: TEmfPlusRecordType; flags,dataSize: UINT; data: PByte; callbackData: Pointer): BOOL; stdcall;

{$IF GDIPVER >= $0110}{$IFDEF ShowHints}{$MESSAGE 'rewisit'}{$ENDIF}
// This is the main GDI+ Abort interface
type
  TGdiplusAbort = record end;
  PGdiplusAbort = ^TGdiplusAbort;
{$IFEND}

//--------------------------------------------------------------------------
// Primitive data types
//
// NOTE:
//  Types already defined in standard header files:
//      INT8
//      UINT8
//      INT16
//      UINT16
//      INT32
//      UINT32
//      INT64
//      UINT64
//
//  Avoid using the following types:
//      LONG - use INT
//      ULONG - use UINT
//      DWORD - use UINT32
//--------------------------------------------------------------------------
type
  REAL = Single;  PREAL = ^REAL;

const
  REAL_MAX       = MaxSingle;
  REAL_MIN       = Minsingle;
  REAL_TOLERANCE = Minsingle * 100;
  REAL_EPSILON   = 1.192092896e-07; (* FLT_EPSILON *)

//--------------------------------------------------------------------------
// Forward declarations of common classes
//--------------------------------------------------------------------------
{!!
  Forward declarations removed - they are not needed here.

  Original text:

class Size;
class SizeF;
class Point;
class PointF;
class Rect;
class RectF;
class CharacterRange;
}

//--------------------------------------------------------------------------
// Status return values from GDI+ methods
//--------------------------------------------------------------------------
type
  TStatus = (
    Ok                        = 0,
    GenericError              = 1,
    InvalidParameter          = 2,
    OutOfMemory               = 3,
    ObjectBusy                = 4,
    InsufficientBuffer        = 5,
    NotImplemented            = 6,
    Win32Error                = 7,
    WrongState                = 8,
    Aborted                   = 9,
    FileNotFound              = 10,
    ValueOverflow             = 11,
    AccessDenied              = 12,
    UnknownImageFormat        = 13,
    FontFamilyNotFound        = 14,
    FontStyleNotFound         = 15,
    NotTrueTypeFont           = 16,
    UnsupportedGdiplusVersion = 17,
    GdiplusNotInitialized     = 18,
    PropertyNotFound          = 19,
    PropertyNotSupported      = 20
  {$IF GDIPVER >= $0110},
    ProfileNotFound           = 21
  {$IFEND}
  );
  PStatus = ^TStatus;

//--------------------------------------------------------------------------
// Represents a dimension in a 2D coordinate system (floating-point coordinates)
//--------------------------------------------------------------------------
type
  TSizeF = record
    Width:  REAL;
    Height: REAL;
  end;
  PSizeF = ^TSizeF;

Function SizeF: TSizeF; overload;
Function SizeF(const sz: TSizeF): TSizeF; overload;
Function SizeF(width,height: REAL): TSizeF; overload;

Function Add(const sza,szb: TSizeF): TSizeF; overload;
Function Subtract(const sza,szb: TSizeF): TSizeF; overload;

Function Equals(const sza,szb: TSizeF): BOOL; overload;
Function Empty(const sz: TSizeF): BOOL; overload;

//--------------------------------------------------------------------------
// Represents a dimension in a 2D coordinate system (integer coordinates)
//--------------------------------------------------------------------------
type
  TSize = record
    Width:  INT;
    Height: INT;
  end;
  PSize = ^TSize;

Function Size: TSize; overload;
Function Size(const sz: TSize): TSize; overload;
Function Size(width,height: INT): TSize; overload;

Function Add(const sza,szb: TSize): TSize; overload;
Function Subtract(const sza,szb: TSize): TSize; overload;

Function Equals(const sza,szb: TSize): BOOL; overload;
Function Empty(const sz: TSize): BOOL; overload;

//--------------------------------------------------------------------------
// Represents a location in a 2D coordinate system (floating-point coordinates)
//--------------------------------------------------------------------------
type
  TPointF = record
    X:  REAL;
    Y:  REAL;
  end;
  PPointF = ^TPointF;

Function PointF: TPointF; overload;
Function PointF(const pt: TPointF): TPointF; overload;
Function PointF(const sz: TSizeF): TPointF; overload;
Function PointF(x,y: REAL): TPointF; overload;

Function Add(const pta,ptb: TPointF): TPointF; overload;
Function Subtract(const pta,ptb: TPointF): TPointF; overload;

Function Equals(const pta,ptb: TPointF): BOOL; overload;

//--------------------------------------------------------------------------
// Represents a location in a 2D coordinate system (integer coordinates)
//--------------------------------------------------------------------------
type
  TPoint = record
    X:  INT;
    Y:  INT;
  end;
  PPoint = ^TPoint;

Function Point: TPoint; overload;
Function Point(const pt: TPoint): TPoint; overload;
Function Point(const sz: TSize): TPoint; overload;
Function Point(x,y: INT): TPoint; overload;

Function Add(const pta,ptb: TPoint): TPoint; overload;
Function Subtract(const pta,ptb: TPoint): TPoint; overload;

Function Equals(const pta,ptb: TPoint): BOOL; overload;

//--------------------------------------------------------------------------
// Represents a rectangle in a 2D coordinate system (floating-point coordinates)
//--------------------------------------------------------------------------
type
  TRectF = record
    X:      REAL;
    Y:      REAL;
    Width:  REAL;
    Height: REAL;
  end;
  PRectF = ^TRectF;

Function RectF: TRectF; overload;
Function RectF(x,y,width,height: REAL): TRectF; overload;
Function RectF(const location: TPointF; const sz: TSizeF): TRectF; overload;

Function Clone(const rc: TRectF): TRectF; overload;

Function GetLocation(const rc: TRectF): TPointF; overload;
Function GetSize(const rc: TRectF): TSizeF; overload;
Function GetBounds(const rc: TRectF): TRectF; overload;
Function GetLeft(const rc: TRectF): REAL; overload;
Function GetTop(const rc: TRectF): REAL; overload;
Function GetRight(const rc: TRectF): REAL; overload;
Function GetBottom(const rc: TRectF): REAL; overload;

Function IsEmptyArea(const rc: TRectF): BOOL; overload;
Function Equals(const rca,rcb: TRectF): BOOL; overload;
Function Contains(const rc: TRectF; x,y: REAL): BOOL; overload;
Function Contains(const rc: TRectF; const pt: TPointF): BOOL; overload;
Function Contains(const rca,rcb: TRectF): BOOL; overload;

Function Inflate(const rc: TRectF; dx,dy: REAL): TRectF; overload;
Function Inflate(const rc: TRectF; const pt: TPointF): TRectF; overload;
Function Intersect(const rca,rcb: TRectF): TRectF; overload;
Function Intersect(out rcc: TRectF; const rca,rcb: TRectF): BOOL; overload;
Function IntersectsWith(const rca,rcb: TRectF): BOOL; overload;
Function Union(const rca,rcb: TRectF): TRectF; overload;
Function Union(out rcc: TRectF; const rca,rcb: TRectF): BOOL; overload;
Function Offset(const rc: TRectF; const pt: TPointF): TRectF; overload;
Function Offset(const rc: TRectF; dx,dy: REAL): TRectF; overload;

//--------------------------------------------------------------------------
// Represents a rectangle in a 2D coordinate system (integer coordinates)
//--------------------------------------------------------------------------
type
  TRect = record
    X:      INT;
    Y:      INT;
    Width:  INT;
    Height: INT;
  end;
  PRect = ^TRect;

Function Rect: TRect; overload;
Function Rect(x,y,width,height: INT): TRect; overload;
Function Rect(const location: TPoint; const sz: TSize): TRect; overload;

Function Clone(const rc: TRect): TRect; overload;

Function GetLocation(const rc: TRect): TPoint; overload;
Function GetSize(const rc: TRect): TSize; overload;
Function GetBounds(const rc: TRect): TRect; overload;
Function GetLeft(const rc: TRect): INT; overload;
Function GetTop(const rc: TRect): INT; overload;
Function GetRight(const rc: TRect): INT; overload;
Function GetBottom(const rc: TRect): INT; overload;

Function IsEmptyArea(const rc: TRect): BOOL; overload;
Function Equals(const rca,rcb: TRect): BOOL; overload;
Function Contains(const rc: TRect; x,y: INT): BOOL; overload;
Function Contains(const rc: TRect; const pt: TPoint): BOOL; overload;
Function Contains(const rca,rcb: TRect): BOOL; overload;

Function Inflate(const rc: TRect; dx,dy: INT): TRect; overload;
Function Inflate(const rc: TRect; const pt: TPoint): TRect; overload;
Function Intersect(const rca,rcb: TRect): TRect; overload;
Function Intersect(out rcc: TRect; const rca,rcb: TRect): BOOL; overload;
Function IntersectsWith(const rca,rcb: TRect): BOOL; overload;
Function Union(const rca,rcb: TRect): TRect; overload;
Function Union(out rcc: TRect; const rca,rcb: TRect): BOOL; overload;
Function Offset(const rc: TRect; const pt: TPoint): TRect; overload;
Function Offset(const rc: TRect; dx,dy: INT): TRect; overload;

{!!-----------------------------------------------------------------------------
    TPathData - declaration
-------------------------------------------------------------------------------}
type
  TPathData = record
    Count:  INT;
    Points: PPointF;  //!! pointer to an array of TPointF data
    Types:  PByte;
  end;
  PPathData = ^TPathData;

procedure PathDataInit(out PathData: TPathData);
procedure PathDataAlloc(var PathData: TPathData; Count: Integer);
procedure PathDataFree(var PathData: TPathData);

Function PathDataPointGet(const PathData: TPathData; Index: Integer): TPointF;
procedure PathDataPointSet(const PathData: TPathData; Index: Integer; Value: TPointF);

Function PathDataTypeGet(const PathData: TPathData; Index: Integer): Byte;
procedure PathDataTypeSet(const PathData: TPathData; Index: Integer; Value: Byte);

{!!-----------------------------------------------------------------------------
    TCharacterRange - declaration
-------------------------------------------------------------------------------}
type
  TCharacterRange = record
    First:  INT;
    Length: INT;
  end;
  PCharacterRange = ^TCharacterRange;

Function CharacterRange: TCharacterRange; overload;
Function CharacterRange(first,length: INT): TCharacterRange; overload;

procedure Assign(var range: TCharacterRange; const rhs: TCharacterRange); overload;


implementation

uses
  SysUtils,
  AuxTypes;

Function GDIPLUS_MIN(a,b: Integer): Integer;
begin
If a < b then
  Result := a
else
  Result := b;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function GDIPLUS_MIN(a,b: Single): Single;
begin
If a < b then
  Result := a
else
  Result := b;
end;

//!!----------------------------------------------------------------------------

Function GDIPLUS_MAX(a,b: Integer): Integer;
begin
If a > b then
  Result := a
else
  Result := b;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function GDIPLUS_MAX(a,b: Single): Single;
begin
If a > b then
  Result := a
else
  Result := b;
end;


{!!-----------------------------------------------------------------------------
    TSizeF - implementation
-------------------------------------------------------------------------------}

Function SizeF: TSizeF;
begin
Result.Width := 0.0;
Result.Height := 0.0;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function SizeF(const sz: TSizeF): TSizeF;
begin
Result.Width := sz.Width;
Result.Height := sz.Height;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function SizeF(width,height: REAL): TSizeF;
begin
Result.Width := width;
Result.Height := height;
end;

//!!----------------------------------------------------------------------------

Function Add(const sza,szb: TSizeF): TSizeF;
begin
Result.Width := sza.Width + szb.Width;
Result.Height := sza.Height + szb.Height;
end;

//!!----------------------------------------------------------------------------

Function Subtract(const sza,szb: TSizeF): TSizeF;
begin
Result.Width := sza.Width - szb.Width;
Result.Height := sza.Height - szb.Height;
end;

//!!----------------------------------------------------------------------------

Function Equals(const sza,szb: TSizeF): BOOL;
begin
Result := (sza.Width = szb.Width) and (sza.Height = szb.Height);
end;

//!!----------------------------------------------------------------------------

Function Empty(const sz: TSizeF): BOOL;
begin
Result := (sz.Width = 0.0) and (sz.Height = 0.0);
end;


{!!-----------------------------------------------------------------------------
    TSize - implementation
-------------------------------------------------------------------------------}

Function Size: TSize;
begin
Result.Width := 0;
Result.Height := 0;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Size(const sz: TSize): TSize;
begin
Result.Width := sz.Width;
Result.Height := sz.Height;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Size(width,height: INT): TSize;
begin
Result.Width := width;
Result.Height := height;
end;

//!!----------------------------------------------------------------------------

Function Add(const sza,szb: TSize): TSize;
begin
Result.Width := sza.Width + szb.Width;
Result.Height := sza.Height + szb.Height;
end;

//!!----------------------------------------------------------------------------

Function Subtract(const sza,szb: TSize): TSize;
begin
Result.Width := sza.Width - szb.Width;
Result.Height := sza.Height - szb.Height;
end;

//!!----------------------------------------------------------------------------

Function Equals(const sza,szb: TSize): BOOL;
begin
Result := (sza.Width = szb.Width) and (sza.Height = szb.Height);
end;

//!!----------------------------------------------------------------------------

Function Empty(const sz: TSize): BOOL;
begin
Result := (sz.Width = 0) and (sz.Height = 0);
end;


{!!-----------------------------------------------------------------------------
    TPointF - implementation
-------------------------------------------------------------------------------}

Function PointF: TPointF;
begin
Result.X := 0.0;
Result.Y := 0.0;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function PointF(const pt: TPointF): TPointF;
begin
Result.X := pt.X;
Result.Y := pt.Y;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function PointF(const sz: TSizeF): TPointF;
begin
Result.X := sz.Width;
Result.Y := sz.Height;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function PointF(x,y: REAL): TPointF;
begin
Result.X := x;
Result.Y := y;
end;

//!!----------------------------------------------------------------------------

Function Add(const pta,ptb: TPointF): TPointF;
begin
Result.X := pta.X + ptb.X;
Result.Y := pta.Y + ptb.Y;
end;

//!!----------------------------------------------------------------------------

Function Subtract(const pta,ptb: TPointF): TPointF;
begin
Result.X := pta.X - ptb.X;
Result.Y := pta.Y - ptb.Y;
end;

//!!----------------------------------------------------------------------------

Function Equals(const pta,ptb: TPointF): BOOL;
begin
Result := (pta.X = ptb.X) and (pta.Y = ptb.Y);
end;


{!!-----------------------------------------------------------------------------
    TPoint - implementation
-------------------------------------------------------------------------------}

Function Point: TPoint;
begin
Result.X := 0;
Result.Y := 0;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Point(const pt: TPoint): TPoint;
begin
Result.X := pt.X;
Result.Y := pt.Y;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Point(const sz: TSize): TPoint;
begin
Result.X := sz.Width;
Result.Y := sz.Height;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Point(x,y: INT): TPoint;
begin
Result.X := x;
Result.Y := y;
end;

//!!----------------------------------------------------------------------------

Function Add(const pta,ptb: TPoint): TPoint;
begin
Result.X := pta.X + ptb.X;
Result.Y := pta.Y + ptb.Y;
end;

//!!----------------------------------------------------------------------------

Function Subtract(const pta,ptb: TPoint): TPoint;
begin
Result.X := pta.X - ptb.X;
Result.Y := pta.Y - ptb.Y;
end;

//!!----------------------------------------------------------------------------

Function Equals(const pta,ptb: TPoint): BOOL;
begin
Result := (pta.X = ptb.X) and (pta.Y = ptb.Y);
end;


{!!-----------------------------------------------------------------------------
    TRectF - implementation
-------------------------------------------------------------------------------}

Function RectF: TRectF;
begin
Result.X := 0.0;
Result.Y := 0.0;
Result.Width := 0.0;
Result.Height := 0.0;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function RectF(x,y,width,height: REAL): TRectF;
begin
Result.X := x;
Result.Y := y;
Result.Width := width;
Result.Height := height;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function RectF(const location: TPointF; const sz: TSizeF): TRectF;
begin
Result.X := location.X;
Result.Y := location.Y;
Result.Width := sz.Width;
Result.Height := sz.Height;
end;

//!!----------------------------------------------------------------------------

Function Clone(const rc: TRectF): TRectF;
begin
Result := RectF(rc.X,rc.Y,rc.Width,rc.Height);
end;

//!!----------------------------------------------------------------------------

Function GetLocation(const rc: TRectF): TPointF;
begin
Result.X := rc.X;
Result.Y := rc.Y;
end;

//!!----------------------------------------------------------------------------

Function GetSize(const rc: TRectF): TSizeF;
begin
Result.Width := rc.Width;
Result.Height := rc.Height;
end;

//!!----------------------------------------------------------------------------

Function GetBounds(const rc: TRectF): TRectF;
begin
Result.X := rc.X;
Result.Y := rc.Y;
Result.Width := rc.Width;
Result.Height := rc.Height;
end;

//!!----------------------------------------------------------------------------

Function GetLeft(const rc: TRectF): REAL;
begin
Result := rc.X;
end;

//!!----------------------------------------------------------------------------

Function GetTop(const rc: TRectF): REAL;
begin
Result := rc.Y;
end;

//!!----------------------------------------------------------------------------

Function GetRight(const rc: TRectF): REAL;
begin
Result := rc.X + rc.Width;
end;

//!!----------------------------------------------------------------------------

Function GetBottom(const rc: TRectF): REAL;
begin
Result := rc.Y + rc.Height;
end;

//!!----------------------------------------------------------------------------

Function IsEmptyArea(const rc: TRectF): BOOL;
begin
Result := (rc.Width <= REAL_EPSILON) or (rc.Height <= REAL_EPSILON);
end;

//!!----------------------------------------------------------------------------

Function Equals(const rca,rcb: TRectF): BOOL;
begin
Result := (rca.X = rcb.X) and (rca.Y = rcb.Y) and (rca.Width = rcb.Width) and (rca.Height = rcb.Height);
end;

//!!----------------------------------------------------------------------------

Function Contains(const rc: TRectF; x,y: REAL): BOOL;
begin
Result := ((x >= rc.X) and (x < (rc.X + rc.Width))) and
          ((y >= rc.Y) and (y < (rc.Y + rc.Height)))
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Contains(const rc: TRectF; const pt: TPointF): BOOL;
begin
Result := Contains(rc,pt.X,pt.Y);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Contains(const rca,rcb: TRectF): BOOL;
begin
Result := ((rca.X <= rcb.X) and (GetRight(rcb) <= GetRight(rca))) and
          ((rca.Y <= rcb.Y) and (GetBottom(rcb) <= GetBottom(rca)));
end;

//!!----------------------------------------------------------------------------

Function Inflate(const rc: TRectF; dx,dy: REAL): TRectF;
begin
Result.X := rc.X - dx;
Result.Y := rc.Y - dy;
Result.Width := rc.Width + (2 * dx);
Result.Height := rc.Height + (2 * dy);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Inflate(const rc: TRectF; const pt: TPointF): TRectF;
begin
Result := Inflate(rc,pt.X,pt.Y);
end;

//!!----------------------------------------------------------------------------

Function Intersect(const rca,rcb: TRectF): TRectF;
begin
Intersect(Result,rca,rcb);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Intersect(out rcc: TRectF; const rca,rcb: TRectF): BOOL;
var
  right,bottom,left,top:  REAL;
begin
right := GDIPLUS_MIN(GetRight(rca),GetRight(rcb));
bottom := GDIPLUS_MIN(GetBottom(rca),GetBottom(rcb));
left := GDIPLUS_MAX(GetLeft(rca),GetLeft(rcb));
top := GDIPLUS_MAX(GetTop(rca),GetTop(rcb));
rcc.X := left;
rcc.Y := top;
rcc.Width := right - left;
rcc.Height := bottom - top;
Result := not IsEmptyArea(rcc);
end;

//!!----------------------------------------------------------------------------

Function IntersectsWith(const rca,rcb: TRectF): BOOL;
begin
Result := (GetLeft(rca) < GetRight(rcb)) and (GetTop(rca) < GetBottom(rcb)) and
          (GetRight(rca) > GetLeft(rcb)) and (GetBottom(rca) > GetTop(rcb));
end;

//!!----------------------------------------------------------------------------

Function Union(const rca,rcb: TRectF): TRectF;
begin
Union(Result,rca,rcb);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Union(out rcc: TRectF; const rca,rcb: TRectF): BOOL;
var
  right,bottom,left,top:  REAL;
begin
right := GDIPLUS_MAX(GetRight(rca),GetRight(rcb));
bottom := GDIPLUS_MAX(GetBottom(rca),GetBottom(rcb));
left := GDIPLUS_MIN(GetLeft(rca),GetLeft(rcb));
top := GDIPLUS_MIN(GetTop(rca),GetTop(rcb));
rcc.X := left;
rcc.Y := top;
rcc.Width := right - left;
rcc.Height := bottom - top;
Result := not IsEmptyArea(rcc);
end;

//!!----------------------------------------------------------------------------

Function Offset(const rc: TRectF; const pt: TPointF): TRectF;
begin
Result := Offset(rc,pt.X,pt.Y);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Offset(const rc: TRectF; dx,dy: REAL): TRectF;
begin
Result.X := rc.X + dx;
Result.Y := rc.Y + dy;
end;


{!!-----------------------------------------------------------------------------
    TRect - implementation
-------------------------------------------------------------------------------}

Function Rect: TRect;
begin
Result.X := 0;
Result.Y := 0;
Result.Width := 0;
Result.Height := 0;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Rect(x,y,width,height: INT): TRect;
begin
Result.X := x;
Result.Y := y;
Result.Width := width;
Result.Height := height;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Rect(const location: TPoint; const sz: TSize): TRect;
begin
Result.X := location.X;
Result.Y := location.Y;
Result.Width := sz.Width;
Result.Height := sz.Height;
end;

//!!----------------------------------------------------------------------------

Function Clone(const rc: TRect): TRect;
begin
Result := Rect(rc.X,rc.Y,rc.Width,rc.Height);
end;

//!!----------------------------------------------------------------------------

Function GetLocation(const rc: TRect): TPoint;
begin
Result.X := rc.X;
Result.Y := rc.Y;
end;

//!!----------------------------------------------------------------------------

Function GetSize(const rc: TRect): TSize;
begin
Result.Width := rc.Width;
Result.Height := rc.Height;
end;

//!!----------------------------------------------------------------------------

Function GetBounds(const rc: TRect): TRect;
begin
Result.X := rc.X;
Result.Y := rc.Y;
Result.Width := rc.Width;
Result.Height := rc.Height;
end;

//!!----------------------------------------------------------------------------

Function GetLeft(const rc: TRect): INT;
begin
Result := rc.X;
end;

//!!----------------------------------------------------------------------------

Function GetTop(const rc: TRect): INT;
begin
Result := rc.Y;
end;

//!!----------------------------------------------------------------------------

Function GetRight(const rc: TRect): INT;
begin
Result := rc.X + rc.Width;
end;

//!!----------------------------------------------------------------------------

Function GetBottom(const rc: TRect): INT;
begin
Result := rc.Y + rc.Height;
end;

//!!----------------------------------------------------------------------------

Function IsEmptyArea(const rc: TRect): BOOL;
begin
Result := (rc.Width <= 0) or (rc.Height <= 0);
end;

//!!----------------------------------------------------------------------------

Function Equals(const rca,rcb: TRect): BOOL;
begin
Result := (rca.X = rcb.X) and (rca.Y = rcb.Y) and (rca.Width = rcb.Width) and (rca.Height = rcb.Height);
end;

//!!----------------------------------------------------------------------------

Function Contains(const rc: TRect; x,y: INT): BOOL;
begin
Result := ((x >= rc.X) and (x < (rc.X + rc.Width))) and
          ((y >= rc.Y) and (y < (rc.Y + rc.Height)))
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Contains(const rc: TRect; const pt: TPoint): BOOL;
begin
Result := Contains(rc,pt.X,pt.Y);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Contains(const rca,rcb: TRect): BOOL;
begin
Result := ((rca.X <= rcb.X) and (GetRight(rcb) <= GetRight(rca))) and
          ((rca.Y <= rcb.Y) and (GetBottom(rcb) <= GetBottom(rca)));
end;

//!!----------------------------------------------------------------------------

Function Inflate(const rc: TRect; dx,dy: INT): TRect;
begin
Result.X := rc.X - dx;
Result.Y := rc.Y - dy;
Result.Width := rc.Width + (2 * dx);
Result.Height := rc.Height + (2 * dy);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Inflate(const rc: TRect; const pt: TPoint): TRect;
begin
Result := Inflate(rc,pt.X,pt.Y);
end;

//!!----------------------------------------------------------------------------

Function Intersect(const rca,rcb: TRect): TRect;
begin
Intersect(Result,rca,rcb);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Intersect(out rcc: TRect; const rca,rcb: TRect): BOOL;
var
  right,bottom,left,top:  INT;
begin
right := GDIPLUS_MIN(GetRight(rca),GetRight(rcb));
bottom := GDIPLUS_MIN(GetBottom(rca),GetBottom(rcb));
left := GDIPLUS_MAX(GetLeft(rca),GetLeft(rcb));
top := GDIPLUS_MAX(GetTop(rca),GetTop(rcb));
rcc.X := left;
rcc.Y := top;
rcc.Width := right - left;
rcc.Height := bottom - top;
Result := not IsEmptyArea(rcc);
end;

//!!----------------------------------------------------------------------------

Function IntersectsWith(const rca,rcb: TRect): BOOL;
begin
Result := (GetLeft(rca) < GetRight(rcb)) and (GetTop(rca) < GetBottom(rcb)) and
          (GetRight(rca) > GetLeft(rcb)) and (GetBottom(rca) > GetTop(rcb));
end;

//!!----------------------------------------------------------------------------

Function Union(const rca,rcb: TRect): TRect;
begin
Union(Result,rca,rcb);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Union(out rcc: TRect; const rca,rcb: TRect): BOOL;
var
  right,bottom,left,top:  INT;
begin
right := GDIPLUS_MAX(GetRight(rca),GetRight(rcb));
bottom := GDIPLUS_MAX(GetBottom(rca),GetBottom(rcb));
left := GDIPLUS_MIN(GetLeft(rca),GetLeft(rcb));
top := GDIPLUS_MIN(GetTop(rca),GetTop(rcb));
rcc.X := left;
rcc.Y := top;
rcc.Width := right - left;
rcc.Height := bottom - top;
Result := not IsEmptyArea(rcc);
end;

//!!----------------------------------------------------------------------------

Function Offset(const rc: TRect; const pt: TPoint): TRect;
begin
Result := Offset(rc,pt.X,pt.Y);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Offset(const rc: TRect; dx,dy: INT): TRect;
begin
Result.X := rc.X + dx;
Result.Y := rc.Y + dy;
end;


{!!-----------------------------------------------------------------------------
    TPathData - implementation
-------------------------------------------------------------------------------}

procedure PathDataInit(out PathData: TPathData);
begin
PathData.Count := 0;
PathData.Points := nil;
PathData.Types := nil;
end;

//!!----------------------------------------------------------------------------

procedure PathDataAlloc(var PathData: TPathData; Count: Integer);
begin
If Count > 0 then
  begin
    PathData.Count := count;
    PathData.Points := AllocMem(count * SizeOf(TPointF));
    PathData.Types := AllocMem(count);
  end
else PathDataFree(PathData);
end;

//!!----------------------------------------------------------------------------

procedure PathDataFree(var PathData: TPathData);
begin
If Assigned(PathData.Points) and (PathData.Count > 0) then
  FreeMem(PathData.Points,PathData.Count * SizeOf(TPointF));
IF Assigned(PathData.Types) and (PathData.Count > 0) then
  FreeMem(PathData.Types,PathData.Count);
PathData.Count := 0;
PathData.Points := nil;
PathData.Types := nil;
end;

//!!----------------------------------------------------------------------------

Function PathDataPointGet(const PathData: TPathData; Index: Integer): TPointF;
begin
If (Index >= 0) and (Index < PathData.Count) then
  Result := PPointF(PtrUInt(PathData.Points) + PtrUInt(Index * SizeOf(TPointF)))^
else
  raise EGDIPlusIndexOutOfBounds.CreateFmt('PathDataPointGet: Index (%d) out of bounds.',[Index]);
end;

//!!----------------------------------------------------------------------------

procedure PathDataPointSet(const PathData: TPathData; Index: Integer; Value: TPointF);
begin
If (Index >= 0) and (Index < PathData.Count) then
  PPointF(PtrUInt(PathData.Points) + PtrUInt(Index * SizeOf(TPointF)))^ := Value
else
  raise EGDIPlusIndexOutOfBounds.CreateFmt('PathDataPointSet: Index (%d) out of bounds.',[Index]);
end;

//!!----------------------------------------------------------------------------

Function PathDataTypeGet(const PathData: TPathData; Index: Integer): Byte;
begin
If (Index >= 0) and (Index < PathData.Count) then
  Result := PByte(PtrUInt(PathData.Points) + PtrUInt(Index))^
else
  raise EGDIPlusIndexOutOfBounds.CreateFmt('PathDataTypeGet: Index (%d) out of bounds.',[Index]);
end;

//!!----------------------------------------------------------------------------

procedure PathDataTypeSet(const PathData: TPathData; Index: Integer; Value: Byte);
begin
If (Index >= 0) and (Index < PathData.Count) then
  PByte(PtrUInt(PathData.Points) + PtrUInt(Index))^ := Value
else
  raise EGDIPlusIndexOutOfBounds.CreateFmt('PathDataTypeSet: Index (%d) out of bounds.',[Index]);
end;


{!!-----------------------------------------------------------------------------
    TCharacterRange - implementation
-------------------------------------------------------------------------------}

Function CharacterRange: TCharacterRange;
begin
Result.First := 0;
Result.Length := 0;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function CharacterRange(first,length: INT): TCharacterRange;
begin
Result.First := first;
Result.Length := length;
end;

//!!----------------------------------------------------------------------------

procedure Assign(var range: TCharacterRange; const rhs: TCharacterRange);
begin
range.First := rhs.First;
range.Length := rhs.Length;
end;

end.
