(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusRegion.h
*
* Abstract:
*
*   GDI+ Region class implementation
*
\**************************************************************************)
unit gdiplusregion;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  gdiplus_common,
  gdiplusheaders, gdiplustypes, gdiplusgpstubs, gdipluspath, gdiplusmatrix;

{!!=============================================================================
    TRegion - class declaration
===============================================================================}
type
  TRegion = class(gdiplusheaders.TRegion)
  protected
    Function SetStatus(Status: TStatus): TStatus;
    constructor Create(NativeRegion: PGpRegion); overload;
    procedure SetNativeRegion(NewNativeRegion: PGpRegion);
  public
    constructor Create; overload;
    constructor Create(const Rect: TRectF); overload;
    constructor Create(const Rect: TRect); overload;
    constructor Create(Path: TGraphicsPath); overload;
    constructor Create(RegionData: PBYTE; Size: INT); overload;
    constructor Create(HRgn: HRGN); overload;
    class Function FromHRGN(HRgn: HRGN): TRegion;
    destructor Destroy; override;
    Function Clone: TRegion;
    Function MakeInfinite: TStatus;
    Function MakeEmpty: TStatus;
    // Get the size of the buffer needed for the GetData method
    Function GetDataSize: UINT;
    // buffer     - where to put the data
    // bufferSize - how big the buffer is (should be at least as big as GetDataSize())
    // sizeFilled - if not NULL, this is an OUT param that says how many bytes
    //              of data were written to the buffer.
    Function GetData(Buffer: PBYTE; BufferSize: UINT; SizeFilled: PUINT = nil): TStatus;
    Function Intersect(const Rect: TRect): TStatus; overload;
    Function Intersect(const Rect: TRectF): TStatus; overload;
    Function Intersect(Path: TGraphicsPath): TStatus; overload;
    Function Intersect(Region: TRegion): TStatus; overload;
    Function Union(const Rect: TRect): TStatus; overload;
    Function Union(const Rect: TRectF): TStatus; overload;
    Function Union(Path: TGraphicsPath): TStatus; overload;
    Function Union(Region: TRegion): TStatus; overload;
    //!! XOR is a reserved word in pascal...
    Function ExclusiveOR(const Rect: TRect): TStatus; overload;
    Function ExclusiveOR(const Rect: TRectF): TStatus; overload;
    Function ExclusiveOR(Path: TGraphicsPath): TStatus; overload;
    Function ExclusiveOR(Region: TRegion): TStatus; overload;
    Function Exclude(const Rect: TRect): TStatus; overload;
    Function Exclude(const Rect: TRectF): TStatus; overload;
    Function Exclude(Path: TGraphicsPath): TStatus; overload;
    Function Exclude(Region: TRegion): TStatus; overload;
    Function Complement(const Rect: TRect): TStatus; overload;
    Function Complement(const Rect: TRectF): TStatus; overload;
    Function Complement(Path: TGraphicsPath): TStatus; overload;
    Function Complement(Region: TRegion): TStatus; overload;
    Function Translate(DX,DY: REAL): TStatus; overload;
    Function Translate(DX,DY: INT): TStatus; overload;
    Function Transform(Matrix: TMatrix): TStatus;
    Function GetBounds(Rect: PRect; G: TGraphics): TStatus; overload;
    Function GetBounds(Rect: PRectF; G: TGraphics): TStatus; overload;
    Function GetHRGN(G: TGraphics): HRGN;
    Function IsEmpty(G: TGraphics): BOOL;
    Function IsInfinite(G: TGraphics): BOOL;
  (**
   * Hit testing operations
   *)
    Function IsVisible(X,Y: INT; G: TGraphics = nil): BOOL; overload;
    Function IsVisible(const Point: TPoint; G: TGraphics = nil): BOOL; overload;
    Function IsVisible(X,Y: REAL; G: TGraphics = nil): BOOL; overload;
    Function IsVisible(const Point: TPointF; G: TGraphics = nil): BOOL; overload;
    Function IsVisible(X,Y,Width,Height: INT; G: TGraphics): BOOL; overload;
    Function IsVisible(const Rect: TRect; G: TGraphics = nil): BOOL; overload;
    Function IsVisible(X,Y,Width,Height: REAL; G: TGraphics = nil): BOOL; overload;
    Function IsVisible(const Rect: TRectF; G: TGraphics = nil): BOOL; overload;
    Function Equals(Region: TRegion; G: TGraphics): BOOL;
    Function GetRegionScansCount(Matrix: TMatrix): UINT;
    // If rects is NULL, return the count of rects in the region.
    // Otherwise, assume rects is big enough to hold all the region rects
    // and fill them in and return the number of rects filled in.
    // The rects are returned in the units specified by the matrix
    // (which is typically a world-to-device transform).
    // Note that the number of rects returned can vary, depending on the
    // matrix that is used.
    Function GetRegionScans(Matrix: TMatrix; Rects: PRectF; Count: PINT): TStatus; overload;
    Function GetRegionScans(Matrix: TMatrix; Rects: PRect; Count: PINT): TStatus; overload;
    Function GetLastStatus: TStatus;
  end;

implementation

uses
  gdiplusflat, gdiplusenums;

{!!=============================================================================
    TRegion - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TRegion - protected methods
-------------------------------------------------------------------------------}

Function TRegion.SetStatus(Status: TStatus): TStatus;
begin
If Status <> Ok then
  fLastResult := Status;
Result := Status;
end;

//!!----------------------------------------------------------------------------

constructor TRegion.Create(NativeRegion: PGpRegion);
begin
inherited Create;
SetNativeRegion(NativeRegion);
end;

//!!----------------------------------------------------------------------------

procedure TRegion.SetNativeRegion(NewNativeRegion: PGpRegion);
begin
fNativeRegion := NewNativeRegion;
end;

{!!-----------------------------------------------------------------------------
    TRegion - public methods
-------------------------------------------------------------------------------}

constructor TRegion.Create;
var
  Region: PGpRegion;
begin
inherited Create;
Region := nil;
fLastResult := GdipCreateRegion(@Region);
SetNativeRegion(Region);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TRegion.Create(const Rect: TRectF);
var
  Region: PGpRegion;
begin
inherited Create;
Region := nil;
fLastResult := GdipCreateRegionRect(@Rect,@Region);
SetNativeRegion(Region);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TRegion.Create(const Rect: TRect);
var
  Region: PGpRegion;
begin
inherited Create;
Region := nil;
fLastResult := GdipCreateRegionRectI(@Rect,@Region);
SetNativeRegion(Region);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TRegion.Create(Path: TGraphicsPath);
var
  Region: PGpRegion;
begin
inherited Create;
Region := nil;
fLastResult := GdipCreateRegionPath(Path.NativeObject,@Region);
SetNativeRegion(Region);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TRegion.Create(RegionData: PBYTE; Size: INT);
var
  Region: PGpRegion;
begin
inherited Create;
Region := nil;
fLastResult := GdipCreateRegionRgnData(RegionData,Size,@Region);
SetNativeRegion(Region);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TRegion.Create(HRgn: HRGN);
var
  Region: PGpRegion;
begin
inherited Create;
Region := nil;
fLastResult := GdipCreateRegionHrgn(HRgn,@Region);
SetNativeRegion(Region);
end;

//!!----------------------------------------------------------------------------

class Function TRegion.FromHRGN(HRgn: HRGN): TRegion;
var
  Region: PGpRegion;
begin
Region := nil;
If GdipCreateRegionHrgn(HRgn,@Region) = Ok then
  begin
    Result := TRegion.Create(Region);
    If not Assigned(Result) then
      GdipDeleteRegion(Region);
  end
else Result := nil;
end;

//!!----------------------------------------------------------------------------

destructor TRegion.Destroy;
begin
GdipDeleteRegion(fNativeRegion);
inherited;
end;

//!!----------------------------------------------------------------------------

Function TRegion.Clone: TRegion;
var
  Region: PGpRegion;
begin
Region := nil;
SetStatus(GdipCloneRegion(fNativeRegion,@Region));
Result := TRegion.Create(Region);
end;

//!!----------------------------------------------------------------------------

Function TRegion.MakeInfinite: TStatus;
begin
Result := SetStatus(GdipSetInfinite(fNativeRegion));
end;

//!!----------------------------------------------------------------------------

Function TRegion.MakeEmpty: TStatus;
begin
Result := SetStatus(GdipSetEmpty(fNativeRegion));
end;

//!!----------------------------------------------------------------------------

Function TRegion.GetDataSize: UINT;
begin
Result := 0;
SetStatus(GdipGetRegionDataSize(fNativeRegion,@Result));
end;

//!!----------------------------------------------------------------------------

Function TRegion.GetData(Buffer: PBYTE; BufferSize: UINT; SizeFilled: PUINT = nil): TStatus;
begin
Result := SetStatus(GdipGetRegionData(fNativeRegion,Buffer,BufferSize,SizeFilled));
end;

//!!----------------------------------------------------------------------------

Function TRegion.Intersect(const Rect: TRect): TStatus;
begin
Result := SetStatus(GdipCombineRegionRect(fNativeRegion,@Rect,CombineModeIntersect));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.Intersect(const Rect: TRectF): TStatus;
begin
Result := SetStatus(GdipCombineRegionRectI(fNativeRegion,@Rect,CombineModeIntersect));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.Intersect(Path: TGraphicsPath): TStatus;
begin
Result := SetStatus(GdipCombineRegionPath(fNativeRegion,Path.NativeObject,CombineModeIntersect));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.Intersect(Region: TRegion): TStatus;
begin
Result := SetStatus(GdipCombineRegionRegion(fNativeRegion,Region.NativeObject,CombineModeIntersect));
end;

//!!----------------------------------------------------------------------------

Function TRegion.Union(const Rect: TRect): TStatus;
begin
Result := SetStatus(GdipCombineRegionRect(fNativeRegion,@Rect,CombineModeUnion));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.Union(const Rect: TRectF): TStatus;
begin
Result := SetStatus(GdipCombineRegionRectI(fNativeRegion,@Rect,CombineModeUnion));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.Union(Path: TGraphicsPath): TStatus;
begin
Result := SetStatus(GdipCombineRegionPath(fNativeRegion,Path.NativeObject,CombineModeUnion));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.Union(Region: TRegion): TStatus;
begin
Result := SetStatus(GdipCombineRegionRegion(fNativeRegion,Region.NativeObject,CombineModeUnion));
end;

//!!----------------------------------------------------------------------------

Function TRegion.ExclusiveOR(const Rect: TRect): TStatus;
begin
Result := SetStatus(GdipCombineRegionRect(fNativeRegion,@Rect,CombineModeXor));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.ExclusiveOR(const Rect: TRectF): TStatus;
begin
Result := SetStatus(GdipCombineRegionRectI(fNativeRegion,@Rect,CombineModeXor));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.ExclusiveOR(Path: TGraphicsPath): TStatus;
begin
Result := SetStatus(GdipCombineRegionPath(fNativeRegion,Path.NativeObject,CombineModeXor));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.ExclusiveOR(Region: TRegion): TStatus;
begin
Result := SetStatus(GdipCombineRegionRegion(fNativeRegion,Region.NativeObject,CombineModeXor));
end;

//!!----------------------------------------------------------------------------

Function TRegion.Exclude(const Rect: TRect): TStatus;
begin
Result := SetStatus(GdipCombineRegionRect(fNativeRegion,@Rect,CombineModeExclude));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.Exclude(const Rect: TRectF): TStatus;
begin
Result := SetStatus(GdipCombineRegionRectI(fNativeRegion,@Rect,CombineModeExclude));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.Exclude(Path: TGraphicsPath): TStatus;
begin
Result := SetStatus(GdipCombineRegionPath(fNativeRegion,Path.NativeObject,CombineModeExclude));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.Exclude(Region: TRegion): TStatus;
begin
Result := SetStatus(GdipCombineRegionRegion(fNativeRegion,Region.NativeObject,CombineModeExclude));
end;

//!!----------------------------------------------------------------------------

Function TRegion.Complement(const Rect: TRect): TStatus;
begin
Result := SetStatus(GdipCombineRegionRect(fNativeRegion,@Rect,CombineModeComplement));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.Complement(const Rect: TRectF): TStatus;
begin
Result := SetStatus(GdipCombineRegionRectI(fNativeRegion,@Rect,CombineModeComplement));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.Complement(Path: TGraphicsPath): TStatus;
begin
Result := SetStatus(GdipCombineRegionPath(fNativeRegion,Path.NativeObject,CombineModeComplement));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.Complement(Region: TRegion): TStatus;
begin
Result := SetStatus(GdipCombineRegionRegion(fNativeRegion,Region.NativeObject,CombineModeComplement));
end;

//!!----------------------------------------------------------------------------

Function TRegion.Translate(DX,DY: REAL): TStatus;
begin
Result := SetStatus(GdipTranslateRegion(fNativeRegion,DX,DY));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.Translate(DX,DY: INT): TStatus;
begin
Result := SetStatus(GdipTranslateRegionI(fNativeRegion,DX,DY));
end;

//!!----------------------------------------------------------------------------

Function TRegion.Transform(Matrix: TMatrix): TStatus;
begin
Result := SetStatus(GdipTransformRegion(fNativeRegion,Matrix.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TRegion.GetBounds(Rect: PRect; G: TGraphics): TStatus;
begin
Result := SetStatus(GdipGetRegionBoundsI(fNativeRegion,G.NativeObject,PGpRect(Rect)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.GetBounds(Rect: PRectF; G: TGraphics): TStatus;
begin
Result := SetStatus(GdipGetRegionBounds(fNativeRegion,G.NativeObject,PGpRectF(Rect)));
end;

//!!----------------------------------------------------------------------------

Function TRegion.GetHRGN(G: TGraphics): HRGN;
begin
SetStatus(GdipGetRegionHRgn(fNativeRegion,G.NativeObject,@Result));
end;

//!!----------------------------------------------------------------------------

Function TRegion.IsEmpty(G: TGraphics): BOOL;
begin
Result := False;
SetStatus(GdipIsEmptyRegion(fNativeRegion,G.NativeObject,@Result));
end;

//!!----------------------------------------------------------------------------

Function TRegion.IsInfinite(G: TGraphics): BOOL;
begin
Result := False;
SetStatus(GdipIsInfiniteRegion(fNativeRegion,G.NativeObject,@Result));
end;

//!!----------------------------------------------------------------------------

Function TRegion.IsVisible(X,Y: INT; G: TGraphics = nil): BOOL;
begin
Result := IsVisible(Point(X,Y),G);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.IsVisible(const Point: TPoint; G: TGraphics = nil): BOOL;
begin
Result := False;
SetStatus(GdipIsVisibleRegionPointI(fNativeRegion,Point.X,Point.Y,G.NativeObject,@Result));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.IsVisible(X,Y: REAL; G: TGraphics = nil): BOOL;
begin
Result := IsVisible(PointF(X,Y),G);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.IsVisible(const Point: TPointF; G: TGraphics = nil): BOOL;
begin
Result := False;
SetStatus(GdipIsVisibleRegionPoint(fNativeRegion,Point.X,Point.Y,G.NativeObject,@Result));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.IsVisible(X,Y,Width,Height: INT; G: TGraphics): BOOL;
begin
Result := IsVisible(Rect(X,Y,Width,Height),G);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.IsVisible(const Rect: TRect; G: TGraphics = nil): BOOL;
begin
Result := False;
SetStatus(GdipIsVisibleRegionRectI(fNativeRegion,Rect.X,Rect.Y,Rect.Width,Rect.Height,G.NativeObject,@Result));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.IsVisible(X,Y,Width,Height: REAL; G: TGraphics = nil): BOOL;
begin
Result := IsVisible(RectF(X,Y,Width,Height),G);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.IsVisible(const Rect: TRectF; G: TGraphics = nil): BOOL;
begin
Result := False;
SetStatus(GdipIsVisibleRegionRect(fNativeRegion,Rect.X,Rect.Y,Rect.Width,Rect.Height,G.NativeObject,@Result));
end;

//!!----------------------------------------------------------------------------

Function TRegion.Equals(Region: TRegion; G: TGraphics): BOOL;
begin
Result := False;
SetStatus(GdipIsEqualRegion(fNativeRegion,Region.NativeObject,G.NativeObject,@Result));
end;

//!!----------------------------------------------------------------------------

Function TRegion.GetRegionScansCount(Matrix: TMatrix): UINT;
begin
Result := 0;
SetStatus(GdipGetRegionScansCount(fNativeRegion,@Result,Matrix.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TRegion.GetRegionScans(Matrix: TMatrix; Rects: PRectF; Count: PINT): TStatus;
begin
Result := SetStatus(GdipGetRegionScans(fNativeRegion,PGpRectF(Rects),Count,Matrix.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TRegion.GetRegionScans(Matrix: TMatrix; Rects: PRect; Count: PINT): TStatus;
begin
Result := SetStatus(GdipGetRegionScansI(fNativeRegion,PGpRect(Rects),Count,Matrix.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TRegion.GetLastStatus: TStatus;
begin
Result := fLastResult;
fLastResult := Ok;
end;

end.
