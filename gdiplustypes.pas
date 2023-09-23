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
type {$IFDEF ShowHints}{$MESSAGE 'rewisit'}{$ENDIF}
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
  REAL = Single;

const
  REAL_MAX       = MaxSingle;
  REAL_MIN       = Minsingle;
  REAL_TOLERANCE = Minsingle * 100;
  REAL_EPSILON   = 1.192092896e-07; (* FLT_EPSILON *)

//--------------------------------------------------------------------------
// Forward declarations of common classes
//--------------------------------------------------------------------------
(*
class Size;
class SizeF;
class Point;
class PointF;
class Rect;
class RectF;
class CharacterRange;
*){$IFDEF ShowHints}{$MESSAGE 'not needed?'}{$ENDIF}

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
Function SizeF(size: TSizeF): TSizeF; overload;
Function SizeF(width,height: REAL): TSizeF; overload;

Function Add(a,b: TSizeF): TSizeF; overload;
Function Subtract(a,b: TSizeF): TSizeF; overload;

Function Equals(a,b: TSizeF): Boolean; overload;
Function Empty(a: TSizeF): Boolean; overload;

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
Function Size(size: TSize): TSize; overload;
Function Size(width,height: INT): TSize; overload;

Function Add(a,b: TSize): TSize; overload;
Function Subtract(a,b: TSize): TSize; overload;

Function Equals(a,b: TSize): Boolean; overload;
Function Empty(a: TSize): Boolean; overload;

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
Function PointF(point: TPointF): TPointF; overload;
Function PointF(size: TSizeF): TPointF; overload;
Function PointF(x,y: REAL): TPointF; overload;

Function Add(a,b: TPointF): TPointF; overload;
Function Subtract(a,b: TPointF): TPointF; overload;

Function Equals(a,b: TPointF): Boolean; overload;

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
Function Point(point: TPoint): TPoint; overload;
Function Point(size: TSize): TPoint; overload;
Function Point(x,y: INT): TPoint; overload;

Function Add(a,b: TPoint): TPoint; overload;
Function Subtract(a,b: TPoint): TPoint; overload;

Function Equals(a,b: TPoint): Boolean; overload;

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
Function RectF(location: TPointF; size: TSizeF): TRectF; overload;

Function Clone(a: TRectF): TRectF; overload;

Function GetLocation(a: TRectF): TPointF; overload;
Function GetSize(a: TRectF): TSizeF; overload;
Function GetBounds(a: TRectF): TRectF; overload;
Function GetLeft(a: TRectF): REAL; overload;
Function GetTop(a: TRectF): REAL; overload;
Function GetRight(a: TRectF): REAL; overload;
Function GetBottom(a: TRectF): REAL; overload;

Function IsEmptyArea(a: TRectF): Boolean; overload;
Function Equals(a,b: TRectF): Boolean; overload;
Function Contains(a: TRectF; x,y: REAL): Boolean; overload;
Function Contains(a: TRectF; pt: TPointF): Boolean; overload;
Function Contains(a: TRectF; b: TRectF): Boolean; overload;

Function Inflate(a: TRectF; dx,dy: REAL): TRectF; overload;
Function Inflate(a: TRectF; point: TPointF): TRectF; overload;
Function Intersect(a,b: TRectF): TRectF; overload;
Function Intersect(out c: TRectF; a,b: TRectF): Boolean; overload;
Function IntersectsWith(a,b: TRectF): Boolean; overload;
Function Union(a,b: TRectF): TRectF; overload;
Function Union(out c: TRectF; a,b: TRectF): Boolean; overload;
Function Offset(a: TRectF; point: TPointF): TRectF; overload;
Function Offset(a: TRectF; dx,dy: REAL): TRectF; overload;

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
Function Rect(location: TPoint; size: TSize): TRect; overload;

Function Clone(a: TRect): TRect; overload;

Function GetLocation(a: TRect): TPoint; overload;
Function GetSize(a: TRect): TSize; overload;
Function GetBounds(a: TRect): TRect; overload;
Function GetLeft(a: TRect): INT; overload;
Function GetTop(a: TRect): INT; overload;
Function GetRight(a: TRect): INT; overload;
Function GetBottom(a: TRect): INT; overload;

Function IsEmptyArea(a: TRect): Boolean; overload;
Function Equals(a,b: TRect): Boolean; overload;
Function Contains(a: TRect; x,y: INT): Boolean; overload;
Function Contains(a: TRect; pt: TPoint): Boolean; overload;
Function Contains(a: TRect; b: TRect): Boolean; overload;

Function Inflate(a: TRect; dx,dy: INT): TRect; overload;
Function Inflate(a: TRect; point: TPoint): TRect; overload;
Function Intersect(a,b: TRect): TRect; overload;
Function Intersect(out c: TRect; a,b: TRect): Boolean; overload;
Function IntersectsWith(a,b: TRect): Boolean; overload;
Function Union(a,b: TRect): TRect; overload;
Function Union(out c: TRect; a,b: TRect): Boolean; overload;
Function Offset(a: TRect; point: TPoint): TRect; overload;
Function Offset(a: TRect; dx,dy: INT): TRect; overload;

{-------------------------------------------------------------------------------
    TPathData - declaration
-------------------------------------------------------------------------------}
type
  TPathData = record
    Count:  INT;
    Points: PPointF;  // pointer to an array of TPointF data
    Types:  PByte;
  end;
  PPathData = ^TPathData;

Function PathDataCreate(count: Integer): TPathData;
procedure PathDataFree(var PathData: TPathData);

Function PathDataPointGet(PathData: TPathData; Index: Integer): TPointF;
procedure PathDataPointSet(PathData: TPathData; Index: Integer; Value: TPointF);

Function PathDataTypeGet(PathData: TPathData; Index: Integer): Byte;
procedure PathDataTypeSet(PathData: TPathData; Index: Integer; Value: Byte);

{-------------------------------------------------------------------------------
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

procedure Assign(var range: TCharacterRange; rhs: TCharacterRange); overload;


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

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function GDIPLUS_MIN(a,b: Single): Single;
begin
If a < b then
  Result := a
else
  Result := b;
end;

//------------------------------------------------------------------------------

Function GDIPLUS_MAX(a,b: Integer): Integer;
begin
If a > b then
  Result := a
else
  Result := b;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function GDIPLUS_MAX(a,b: Single): Single;
begin
If a > b then
  Result := a
else
  Result := b;
end;


{-------------------------------------------------------------------------------
    TSizeF - implementation
-------------------------------------------------------------------------------}

Function SizeF: TSizeF;
begin
Result.Width := 0.0;
Result.Height := 0.0;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function SizeF(size: TSizeF): TSizeF;
begin
Result.Width := size.Width;
Result.Height := size.Height;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function SizeF(width,height: REAL): TSizeF;
begin
Result.Width := width;
Result.Height := height;
end;

//------------------------------------------------------------------------------

Function Add(a,b: TSizeF): TSizeF;
begin
Result.Width := a.Width + b.Width;
Result.Height := a.Height + b.Height;
end;

//------------------------------------------------------------------------------

Function Subtract(a,b: TSizeF): TSizeF;
begin
Result.Width := a.Width - b.Width;
Result.Height := a.Height - b.Height;
end;

//------------------------------------------------------------------------------

Function Equals(a,b: TSizeF): Boolean;
begin
Result := (a.Width = b.Width) and (a.Height = b.Height);
end;

//------------------------------------------------------------------------------

Function Empty(a: TSizeF): Boolean;
begin
Result := (a.Width = 0.0) and (a.Height = 0.0);
end;

{-------------------------------------------------------------------------------
    TSize - implementation
-------------------------------------------------------------------------------}

Function Size: TSize;
begin
Result.Width := 0;
Result.Height := 0;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Size(size: TSize): TSize;
begin
Result.Width := size.Width;
Result.Height := size.Height;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Size(width,height: INT): TSize;
begin
Result.Width := width;
Result.Height := height;
end;

//------------------------------------------------------------------------------

Function Add(a,b: TSize): TSize;
begin
Result.Width := a.Width + b.Width;
Result.Height := a.Height + b.Height;
end;

//------------------------------------------------------------------------------

Function Subtract(a,b: TSize): TSize;
begin
Result.Width := a.Width - b.Width;
Result.Height := a.Height - b.Height;
end;

//------------------------------------------------------------------------------

Function Equals(a,b: TSize): Boolean;
begin
Result := (a.Width = b.Width) and (a.Height = b.Height);
end;

//------------------------------------------------------------------------------

Function Empty(a: TSize): Boolean;
begin
Result := (a.Width = 0) and (a.Height = 0);
end;

{-------------------------------------------------------------------------------
    TPointF - implementation
-------------------------------------------------------------------------------}

Function PointF: TPointF;
begin
Result.X := 0.0;
Result.Y := 0.0;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function PointF(point: TPointF): TPointF;
begin
Result.X := point.X;
Result.Y := point.Y;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function PointF(size: TSizeF): TPointF;
begin
Result.X := size.Width;
Result.Y := size.Height;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function PointF(x,y: REAL): TPointF;
begin
Result.X := x;
Result.Y := y;
end;

//------------------------------------------------------------------------------

Function Add(a,b: TPointF): TPointF;
begin
Result.X := a.X + b.X;
Result.Y := a.Y + b.Y;
end;

//------------------------------------------------------------------------------

Function Subtract(a,b: TPointF): TPointF;
begin
Result.X := a.X - b.X;
Result.Y := a.Y - b.Y;
end;

//------------------------------------------------------------------------------

Function Equals(a,b: TPointF): Boolean;
begin
Result := (a.X = b.X) and (a.Y = b.Y);
end;

{-------------------------------------------------------------------------------
    TPoint - implementation
-------------------------------------------------------------------------------}

Function Point: TPoint;
begin
Result.X := 0;
Result.Y := 0;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Point(point: TPoint): TPoint;
begin
Result.X := point.X;
Result.Y := point.Y;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Point(size: TSize): TPoint;
begin
Result.X := size.Width;
Result.Y := size.Height;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Point(x,y: INT): TPoint;
begin
Result.X := x;
Result.Y := y;
end;

//------------------------------------------------------------------------------

Function Add(a,b: TPoint): TPoint;
begin
Result.X := a.X + b.X;
Result.Y := a.Y + b.Y;
end;

//------------------------------------------------------------------------------

Function Subtract(a,b: TPoint): TPoint;
begin
Result.X := a.X - b.X;
Result.Y := a.Y - b.Y;
end;

//------------------------------------------------------------------------------

Function Equals(a,b: TPoint): Boolean;
begin
Result := (a.X = b.X) and (a.Y = b.Y);
end;

{-------------------------------------------------------------------------------
    TRectF - implementation
-------------------------------------------------------------------------------}

Function RectF: TRectF;
begin
Result.X := 0.0;
Result.Y := 0.0;
Result.Width := 0.0;
Result.Height := 0.0;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function RectF(x,y,width,height: REAL): TRectF;
begin
Result.X := x;
Result.Y := y;
Result.Width := width;
Result.Height := height;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function RectF(location: TPointF; size: TSizeF): TRectF;
begin
Result.X := location.X;
Result.Y := location.Y;
Result.Width := size.Width;
Result.Height := size.Height;
end;

//------------------------------------------------------------------------------

Function Clone(a: TRectF): TRectF;
begin
Result := RectF(a.X,a.Y,a.Width,a.Height);
end;

//------------------------------------------------------------------------------

Function GetLocation(a: TRectF): TPointF;
begin
Result.X := a.X;
Result.Y := a.Y;
end;

//------------------------------------------------------------------------------

Function GetSize(a: TRectF): TSizeF;
begin
Result.Width := a.Width;
Result.Height := a.Height;
end;

//------------------------------------------------------------------------------

Function GetBounds(a: TRectF): TRectF;
begin
Result.X := a.X;
Result.Y := a.Y;
Result.Width := a.Width;
Result.Height := a.Height;
end;

//------------------------------------------------------------------------------

Function GetLeft(a: TRectF): REAL;
begin
Result := a.X;
end;

//------------------------------------------------------------------------------

Function GetTop(a: TRectF): REAL;
begin
Result := a.Y;
end;

//------------------------------------------------------------------------------

Function GetRight(a: TRectF): REAL;
begin
Result := a.X + a.Width;
end;

//------------------------------------------------------------------------------

Function GetBottom(a: TRectF): REAL;
begin
Result := a.Y + a.Height;
end;

//------------------------------------------------------------------------------

Function IsEmptyArea(a: TRectF): Boolean;
begin
Result := (a.Width <= REAL_EPSILON) or (a.Height <= REAL_EPSILON);
end;

//------------------------------------------------------------------------------

Function Equals(a,b: TRectF): Boolean;
begin
Result := (a.X = b.X) and (a.Y = b.Y) and (a.Width = b.Width) and (a.Height = b.Height);
end;

//------------------------------------------------------------------------------

Function Contains(a: TRectF; x,y: REAL): Boolean;
begin
Result := ((x >= a.X) and (x < (a.X + a.Width))) and
          ((y >= a.Y) and (y < (a.Y + a.Height)))
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Contains(a: TRectF; pt: TPointF): Boolean;
begin
Result := Contains(a,pt.X,pt.Y);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Contains(a: TRectF; b: TRectF): Boolean;
begin
Result := ((a.X <= b.X) and (GetRight(b) <= GetRight(a))) and
          ((a.Y <= b.Y) and (GetBottom(b) <= GetBottom(a)));
end;

//------------------------------------------------------------------------------

Function Inflate(a: TRectF; dx,dy: REAL): TRectF;
begin
Result.X := a.X - dx;
Result.Y := a.Y - dy;
Result.Width := a.Width + (2 * dx);
Result.Height := a.Height + (2 * dy);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Inflate(a: TRectF; point: TPointF): TRectF;
begin
Result := Inflate(a,point.X,point.Y);
end;

//------------------------------------------------------------------------------

Function Intersect(a,b: TRectF): TRectF;
begin
Intersect(Result,a,b);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Intersect(out c: TRectF; a,b: TRectF): Boolean;
var
  right,bottom,left,top:  REAL;
begin
right := GDIPLUS_MIN(GetRight(a),GetRight(b));
bottom := GDIPLUS_MIN(GetBottom(a),GetBottom(b));
left := GDIPLUS_MAX(GetLeft(a),GetLeft(b));
top := GDIPLUS_MAX(GetTop(a),GetTop(b));
c.X := left;
c.Y := top;
c.Width := right - left;
c.Height := bottom - top;
Result := not IsEmptyArea(c);
end;

//------------------------------------------------------------------------------

Function IntersectsWith(a,b: TRectF): Boolean;
begin
Result := (GetLeft(a) < GetRight(b)) and (GetTop(a) < GetBottom(b)) and
          (GetRight(a) > GetLeft(b)) and (GetBottom(a) > GetTop(b));
end;

//------------------------------------------------------------------------------

Function Union(a,b: TRectF): TRectF;
begin
Union(Result,a,b);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Union(out c: TRectF; a,b: TRectF): Boolean;
var
  right,bottom,left,top:  REAL;
begin
right := GDIPLUS_MAX(GetRight(a),GetRight(b));
bottom := GDIPLUS_MAX(GetBottom(a),GetBottom(b));
left := GDIPLUS_MIN(GetLeft(a),GetLeft(b));
top := GDIPLUS_MIN(GetTop(a),GetTop(b));
c.X := left;
c.Y := top;
c.Width := right - left;
c.Height := bottom - top;
Result := not IsEmptyArea(c);
end;

//------------------------------------------------------------------------------

Function Offset(a: TRectF; point: TPointF): TRectF;
begin
Result := Offset(a,point.X,point.Y);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Offset(a: TRectF; dx,dy: REAL): TRectF;
begin
Result.X := a.X + dx;
Result.Y := a.Y + dy;
end;

{-------------------------------------------------------------------------------
    TRect - implementation
-------------------------------------------------------------------------------}

Function Rect: TRect;
begin
Result.X := 0;
Result.Y := 0;
Result.Width := 0;
Result.Height := 0;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Rect(x,y,width,height: INT): TRect;
begin
Result.X := x;
Result.Y := y;
Result.Width := width;
Result.Height := height;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Rect(location: TPoint; size: TSize): TRect;
begin
Result.X := location.X;
Result.Y := location.Y;
Result.Width := size.Width;
Result.Height := size.Height;
end;

//------------------------------------------------------------------------------

Function Clone(a: TRect): TRect;
begin
Result := Rect(a.X,a.Y,a.Width,a.Height);
end;

//------------------------------------------------------------------------------

Function GetLocation(a: TRect): TPoint;
begin
Result.X := a.X;
Result.Y := a.Y;
end;

//------------------------------------------------------------------------------

Function GetSize(a: TRect): TSize;
begin
Result.Width := a.Width;
Result.Height := a.Height;
end;

//------------------------------------------------------------------------------

Function GetBounds(a: TRect): TRect;
begin
Result.X := a.X;
Result.Y := a.Y;
Result.Width := a.Width;
Result.Height := a.Height;
end;

//------------------------------------------------------------------------------

Function GetLeft(a: TRect): INT;
begin
Result := a.X;
end;

//------------------------------------------------------------------------------

Function GetTop(a: TRect): INT;
begin
Result := a.Y;
end;

//------------------------------------------------------------------------------

Function GetRight(a: TRect): INT;
begin
Result := a.X + a.Width;
end;

//------------------------------------------------------------------------------

Function GetBottom(a: TRect): INT;
begin
Result := a.Y + a.Height;
end;

//------------------------------------------------------------------------------

Function IsEmptyArea(a: TRect): Boolean;
begin
Result := (a.Width <= 0) or (a.Height <= 0);
end;

//------------------------------------------------------------------------------

Function Equals(a,b: TRect): Boolean;
begin
Result := (a.X = b.X) and (a.Y = b.Y) and (a.Width = b.Width) and (a.Height = b.Height);
end;

//------------------------------------------------------------------------------

Function Contains(a: TRect; x,y: INT): Boolean;
begin
Result := ((x >= a.X) and (x < (a.X + a.Width))) and
          ((y >= a.Y) and (y < (a.Y + a.Height)))
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Contains(a: TRect; pt: TPoint): Boolean;
begin
Result := Contains(a,pt.X,pt.Y);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Contains(a: TRect; b: TRect): Boolean;
begin
Result := ((a.X <= b.X) and (GetRight(b) <= GetRight(a))) and
          ((a.Y <= b.Y) and (GetBottom(b) <= GetBottom(a)));
end;

//------------------------------------------------------------------------------

Function Inflate(a: TRect; dx,dy: INT): TRect;
begin
Result.X := a.X - dx;
Result.Y := a.Y - dy;
Result.Width := a.Width + (2 * dx);
Result.Height := a.Height + (2 * dy);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Inflate(a: TRect; point: TPoint): TRect;
begin
Result := Inflate(a,point.X,point.Y);
end;

//------------------------------------------------------------------------------

Function Intersect(a,b: TRect): TRect;
begin
Intersect(Result,a,b);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Intersect(out c: TRect; a,b: TRect): Boolean;
var
  right,bottom,left,top:  INT;
begin
right := GDIPLUS_MIN(GetRight(a),GetRight(b));
bottom := GDIPLUS_MIN(GetBottom(a),GetBottom(b));
left := GDIPLUS_MAX(GetLeft(a),GetLeft(b));
top := GDIPLUS_MAX(GetTop(a),GetTop(b));
c.X := left;
c.Y := top;
c.Width := right - left;
c.Height := bottom - top;
Result := not IsEmptyArea(c);
end;

//------------------------------------------------------------------------------

Function IntersectsWith(a,b: TRect): Boolean;
begin
Result := (GetLeft(a) < GetRight(b)) and (GetTop(a) < GetBottom(b)) and
          (GetRight(a) > GetLeft(b)) and (GetBottom(a) > GetTop(b));
end;

//------------------------------------------------------------------------------

Function Union(a,b: TRect): TRect;
begin
Union(Result,a,b);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Union(out c: TRect; a,b: TRect): Boolean;
var
  right,bottom,left,top:  INT;
begin
right := GDIPLUS_MAX(GetRight(a),GetRight(b));
bottom := GDIPLUS_MAX(GetBottom(a),GetBottom(b));
left := GDIPLUS_MIN(GetLeft(a),GetLeft(b));
top := GDIPLUS_MIN(GetTop(a),GetTop(b));
c.X := left;
c.Y := top;
c.Width := right - left;
c.Height := bottom - top;
Result := not IsEmptyArea(c);
end;

//------------------------------------------------------------------------------

Function Offset(a: TRect; point: TPoint): TRect;
begin
Result := Offset(a,point.X,point.Y);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function Offset(a: TRect; dx,dy: INT): TRect;
begin
Result.X := a.X + dx;
Result.Y := a.Y + dy;
end;

{-------------------------------------------------------------------------------
    TPathData - implementation
-------------------------------------------------------------------------------}

Function PathDataCreate(count: Integer): TPathData;
begin
If Count > 0 then
  begin
    Result.Count := count;
    Result.Points := AllocMem(count * SizeOf(TPointF));
    Result.Types := AllocMem(count);
  end
else
  begin
    Result.Count := 0;
    Result.Points := nil;
    Result.Types := nil;
  end;
end;

//------------------------------------------------------------------------------

procedure PathDataFree(var PathData: TPathData);
begin
FreeMem(PathData.Points,PathData.Count * SizeOf(TPointF));
FreeMem(PathData.Types,PathData.Count);
PathData.Count := 0;
PathData.Points := nil;
PathData.Types := nil;
end;

//------------------------------------------------------------------------------

Function PathDataPointGet(PathData: TPathData; Index: Integer): TPointF;
begin
If (Index >= 0) and (Index < PathData.Count) then
  Result := PPointF(PtrUInt(PathData.Points) + PtrUInt(Index * SizeOf(TPointF)))^
else
  raise EGDIPlusIndexOutOfBound.CreateFmt('PathDataPointGet: Index (%d) out of bounds.',[Index]);
end;

//------------------------------------------------------------------------------

procedure PathDataPointSet(PathData: TPathData; Index: Integer; Value: TPointF);
begin
If (Index >= 0) and (Index < PathData.Count) then
  PPointF(PtrUInt(PathData.Points) + PtrUInt(Index * SizeOf(TPointF)))^ := Value
else
  raise EGDIPlusIndexOutOfBound.CreateFmt('PathDataPointSet: Index (%d) out of bounds.',[Index]);
end;

//------------------------------------------------------------------------------

Function PathDataTypeGet(PathData: TPathData; Index: Integer): Byte;
begin
If (Index >= 0) and (Index < PathData.Count) then
  Result := PByte(PtrUInt(PathData.Points) + PtrUInt(Index))^
else
  raise EGDIPlusIndexOutOfBound.CreateFmt('PathDataTypeGet: Index (%d) out of bounds.',[Index]);
end;

//------------------------------------------------------------------------------

procedure PathDataTypeSet(PathData: TPathData; Index: Integer; Value: Byte);
begin
If (Index >= 0) and (Index < PathData.Count) then
  PByte(PtrUInt(PathData.Points) + PtrUInt(Index))^ := Value
else
  raise EGDIPlusIndexOutOfBound.CreateFmt('PathDataTypeSet: Index (%d) out of bounds.',[Index]);
end;

{-------------------------------------------------------------------------------
    TCharacterRange - implementation
-------------------------------------------------------------------------------}

Function CharacterRange: TCharacterRange;
begin
Result.First := 0;
Result.Length := 0;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function CharacterRange(first,length: INT): TCharacterRange;
begin
Result.First := first;
Result.Length := length;
end;

//------------------------------------------------------------------------------

procedure Assign(var range: TCharacterRange; rhs: TCharacterRange);
begin
range.First := rhs.First;
range.Length := rhs.Length;
end;

end.
