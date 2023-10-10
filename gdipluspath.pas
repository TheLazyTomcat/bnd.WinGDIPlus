(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusPath.h
*
* Abstract:
*
*   GDI+ Graphics Path class
*
\**************************************************************************)
unit gdipluspath;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows, gdiplus_common,
  gdiplusbase, gdiplusgpstubs, gdiplustypes, gdiplusenums, gdiplusheaders,
  gdiplusstringformat, gdiplusmatrix, gdipluspen, gdiplusbrush, gdipluscolor;

{!!=============================================================================
    TGraphicsPath - class declaration
===============================================================================}
type
  TGraphicsPath = class(TGdiPlusBase)
  protected
    fNativePath:  PGpPath;
    fLastResult:  TStatus;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
    constructor Create(Path: TGraphicsPath); overload;
    constructor Create(NativePath: PGpPath); overload;
    procedure SetNativePath(NativePathArg: PGpPath); 
    Function SetStatus(Status: TStatus): TStatus; 
  public
    constructor Create(FillMode: TFillMode = FillModeAlternate); overload;
    constructor Create(Points: PPointF; Types: PBYTE; Count: INT; FillMode: TFillMode = FillModeAlternate); overload;
    constructor Create(Points: PPoint; Types: PBYTE; Count: INT; FillMode: TFillMode = FillModeAlternate); overload;
    destructor Destroy; override;
    Function Clone: TGraphicsPath;
    // Reset the path object to empty (and fill mode to FillModeAlternate)
    Function Reset: TStatus;
    Function GetFillMode: TFillMode; 
    Function SetFillMode(FillMode: TFillMode): TStatus;
    Function GetPathData(PathData: PPathData): TStatus;
    Function StartFigure: TStatus; 
    Function CloseFigure: TStatus; 
    Function CloseAllFigures: TStatus;
    Function SetMarker: TStatus; 
    Function ClearMarkers: TStatus;
    Function Reverse: TStatus;
    Function GetLastPoint(LastPoint: PPointF): TStatus;
    Function AddLine(const Pt1,Pt2: TPointF): TStatus; overload; 
    Function AddLine(X1,Y1,X2,Y2: REAL): TStatus; overload; 
    Function AddLines(Points: PPointF; Count: INT): TStatus; overload; 
    Function AddLine(const Pt1,Pt2: TPoint): TStatus; overload; 
    Function AddLine(X1,Y1,X2,Y2: INT): TStatus; overload; 
    Function AddLines(Points: PPoint; Count: INT): TStatus; overload;
    Function AddArc(const Rect: TRectF; StartAngle,SweepAngle: REAL): TStatus; overload; 
    Function AddArc(X,Y,Width,Height: REAL; StartAngle,SweepAngle: REAL): TStatus; overload; 
    Function AddArc(const Rect: TRect; StartAngle,SweepAngle: REAL): TStatus; overload; 
    Function AddArc(X,Y,Width,Height: INT; StartAngle,SweepAngle: REAL): TStatus; overload;
    Function AddBezier(const Pt1,Pt2,Pt3,Pt4: TPointF): TStatus; overload; 
    Function AddBezier(X1,Y1,X2,Y2,X3,Y3,X4,Y4: REAL): TStatus; overload; 
    Function AddBeziers(Points: PPointF; Count: INT): TStatus; overload; 
    Function AddBezier(const Pt1,Pt2,Pt3,Pt4: TPoint): TStatus; overload; 
    Function AddBezier(X1,Y1,X2,Y2,X3,Y3,X4,Y4: INT): TStatus; overload; 
    Function AddBeziers(Points: PPoint; Count: INT): TStatus; overload;
    Function AddCurve(Points: PPointF; Count: INT): TStatus; overload; 
    Function AddCurve(Points: PPointF; Count: INT; Tension: REAL): TStatus; overload; 
    Function AddCurve(Points: PPointF; Count,Offset,NumberOfSegments: INT; Tension: REAL): TStatus; overload; 
    Function AddCurve(Points: PPoint; Count: INT): TStatus; overload; 
    Function AddCurve(Points: PPoint; Count: INT; Tension: REAL): TStatus; overload; 
    Function AddCurve(Points: PPoint; Count,Offset,NumberOfSegments: INT; Tension: REAL): TStatus; overload;
    Function AddClosedCurve(Points: PPointF; Count: INT): TStatus; overload; 
    Function AddClosedCurve(Points: PPointF; Count: INT; Tension: REAL): TStatus; overload; 
    Function AddClosedCurve(Points: PPoint; Count: INT): TStatus; overload; 
    Function AddClosedCurve(Points: PPoint; Count: INT; Tension: REAL): TStatus; overload;
    Function AddRectangle(const Rect: TRectF): TStatus; overload; 
    Function AddRectangleS(Rects: PRectF; Count: INT): TStatus; overload; 
    Function AddRectangle(const Rect: TRect): TStatus; overload; 
    Function AddRectangleS(Rects: PRect; Count: INT): TStatus; overload;
    Function AddEllipse(const Rect: TRectF): TStatus; overload; 
    Function AddEllipse(X,Y,Width,Height: REAL): TStatus; overload; 
    Function AddEllipse(const Rect: TRect): TStatus; overload; 
    Function AddEllipse(X,Y,Width,Height: INT): TStatus; overload;
    Function AddPie(const Rect: TRectF; StartAngle,SweepAngle: REAL): TStatus; overload; 
    Function AddPie(X,Y,Width,Height: REAL; StartAngle,SweepAngle: REAL): TStatus; overload; 
    Function AddPie(const Rect: TRect; StartAngle,SweepAngle: REAL): TStatus; overload; 
    Function AddPie(X,Y,Width,Height: INT; StartAngle,SweepAngle: REAL): TStatus; overload;
    Function AddPolygon(Points: PPointF; Count: INT): TStatus; overload; 
    Function AddPolygon(Points: PPoint; Count: INT): TStatus; overload;
    Function AddPath(AddingPath: TGraphicsPath; Connect: BOOL): TStatus;
    Function AddString(Str: PWideChar; Length: Int; Family: TFontFamily; Style: INT; EmSize: REAL{World units};
      const Origin: TPointF; Format: TStringFormat): TStatus; overload;
    Function AddString(Str: PWideChar; Length: Int; Family: TFontFamily; Style: INT; EmSize: REAL;
      const LayoutRect: TRectF; Format: TStringFormat): TStatus; overload;
    Function AddString(Str: PWideChar; Length: Int; Family: TFontFamily; Style: INT; EmSize: REAL;
      const Origin: TPoint; Format: TStringFormat): TStatus; overload;
    Function AddString(Str: PWideChar; Length: Int; Family: TFontFamily; Style: INT; EmSize: REAL;
      const LayoutRect: TRect; Format: TStringFormat): TStatus; overload;
    Function AddString(const Str: String; Length: Int; Family: TFontFamily; Style: INT; EmSize: REAL;
      const Origin: TPointF; Format: TStringFormat): TStatus; overload;
    Function AddString(const Str: String; Length: Int; Family: TFontFamily; Style: INT; EmSize: REAL;
      const LayoutRect: TRectF; Format: TStringFormat): TStatus; overload;
    Function AddString(const Str: String; Length: Int; Family: TFontFamily; Style: INT; EmSize: REAL;
      const Origin: TPoint; Format: TStringFormat): TStatus; overload;
    Function AddString(const Str: String; Length: Int; Family: TFontFamily; Style: INT; EmSize: REAL;
      const LayoutRect: TRect; Format: TStringFormat): TStatus; overload;
    Function Transform(Matrix: TMatrix): TStatus;
    // This is not always the tightest bounds.
    Function GetBounds(const Bounds: TRectF; Matrix: TMatrix = nil; Pen: TPen = nil): TStatus; overload; 
    Function GetBounds(const Bounds: TRect; Matrix: TMatrix = nil; Pen: TPen = nil): TStatus; overload;
    // Once flattened, the resultant path is made of line segments and
    // the original path information is lost.  When matrix is NULL the
    // identity matrix is assumed.
    Function Flatten(Matrix: TMatrix; Flatness: REAL): TStatus; overload; 
    Function Flatten(Matrix: TMatrix = nil): TStatus; overload;
    Function Widen(Pen: TPen; Matrix: TMatrix; Flatness: REAL): TStatus; overload; 
    Function Widen(Pen: TPen; Matrix: TMatrix = nil): TStatus; overload;
    Function Outline(Matrix: TMatrix; Flatness: REAL): TStatus; overload; 
    Function Outline(Matrix: TMatrix = nil): TStatus; overload;
    // Once this is called, the resultant path is made of line segments and
    // the original path information is lost.  When matrix is NULL, the 
    // identity matrix is assumed.
    Function Warp(DestPoints: PPointF; Count: INT; const SrcRect: TRectF; Matrix: TMatrix;
      WarpMode: TWarpMode; Flatness: REAL): TStatus; overload; 
    Function Warp(DestPoints: PPointF; Count: INT; const SrcRect: TRectF; Matrix: TMatrix = nil;
      WarpMode: TWarpMode = WarpModePerspective): TStatus; overload;
    Function GetPointCount: INT;
    Function GetPathTypes(Types: PBYTE; Count: INT): TStatus; 
    Function GetPathPoints(Points: PPointF; Count: INT): TStatus; overload; 
    Function GetPathPoints(Points: PPoint; Count: INT): TStatus; overload;
    Function GetLastStatus: TStatus;
    Function IsVisible(const Point: TPointF; G: TGraphics = nil): BOOL; overload;
    Function IsVisible(X,Y: REAL; G: TGraphics = nil): BOOL; overload;
    Function IsVisible(const Point: TPoint; G: TGraphics = nil): BOOL; overload;
    Function IsVisible(X,Y: INT; G: TGraphics = nil): BOOL; overload;
    Function IsOutlineVisible(const Point: TPointF; Pen: TPen; G: TGraphics = nil): BOOL; overload; 
    Function IsOutlineVisible(X,Y: REAL; Pen: TPen; G: TGraphics = nil): BOOL; overload; 
    Function IsOutlineVisible(const Point: TPoint; Pen: TPen; G: TGraphics = nil): BOOL; overload; 
    Function IsOutlineVisible(X,Y: INT; Pen: TPen; G: TGraphics = nil): BOOL; overload; 
  end;

{!!=============================================================================
    TGraphicsPathIterator - class declaration
===============================================================================}
//--------------------------------------------------------------------------
// GraphisPathIterator class
//-------------------------------------------------------------------------- 
type
  TGraphicsPathIterator = class(TGdiPlusBase)
  protected
    fNativeIterator:  PGpPathIterator;
    fLastResult:      TStatus;
    procedure SetNativeIterator(NativeIteratorArg: PGpPathIterator); 
    Function SetStatus(Status: TStatus): TStatus; 
  public
    constructor Create(Path: TGraphicsPath);
    destructor Destroy; override;
    Function NextSubPath(StartIndex,EndIndex: PINT; IsClosed: PBOOL): INT; overload; 
    Function NextSubPath(Path: TGraphicsPath; IsClosed: PBOOL): INT; overload;
    Function NextPathType(PathType: PBYTE; StartIndex,EndIndex: PINT): INT;
    Function NextMarker(StartIndex,EndIndex: PINT): INT; overload; 
    Function NextMarker(Path: TGraphicsPath): INT; overload;
    Function GetCount: INT; 
    Function GetSubpathCount: INT;
    Function HasCurve: BOOL;
    procedure Rewind;
    Function Enumerate(Points: PPointF; Types: PBYTE; Count: INT): INT; 
    Function CopyData(Points: PPointF; Types: PBYTE; StartIndex,EndIndex: INT): INT; 
    Function GetLastStatus: TStatus; 
  end;

{!!=============================================================================
    TPathGradientBrush - class declaration
===============================================================================}
//--------------------------------------------------------------------------
// Path Gradient Brush
//--------------------------------------------------------------------------
type
  TPathGradientBrush = class(TBrush)
  public
    constructor Create(Points: PPointF; Count: INT; WrapMode: TWrapMode = WrapModeClamp); overload;
    constructor Create(Points: PPoint; Count: INT; WrapMode: TWrapMode = WrapModeClamp); overload;
    constructor Create(Path: TGraphicsPath); overload;
    Function GetCenterColor(Color: PColor): TStatus; 
    Function SetCenterColor(const Color: TColor): TStatus;
    Function GetPointCount: INT; 
    Function GetSurroundColorCount: INT;
    Function GetSurroundColors(Colors: PColor; Count: PINT): TStatus; 
    Function SetSurroundColors(Colors: PColor; Count: PINT): TStatus;
    Function GetGraphicsPath(Path: TGraphicsPath): TStatus; 
    Function SetGraphicsPath(Path: TGraphicsPath): TStatus;
    Function GetCenterPoint(Point: PPointF): TStatus; overload; 
    Function GetCenterPoint(Point: PPoint): TStatus; overload; 
    Function SetCenterPoint(const Point: TPointF): TStatus; overload; 
    Function SetCenterPoint(const Point: TPoint): TStatus; overload;
    Function GetRectangle(Rect: PRectF): TStatus; overload; 
    Function GetRectangle(Rect: PRect): TStatus; overload;
    Function SetGammaCorrection(UseGammaCorrection: BOOL): TStatus;
    Function GetGammaCorrection: BOOL;
    Function GetBlendCount: INT; 
    Function GetBlend(BlendFactors,BlendPositions: PREAL; Count: INT): TStatus; 
    Function SetBlend(BlendFactors,BlendPositions: PREAL; Count: INT): TStatus;
    Function GetInterpolationColorCount: INT; 
    Function SetInterpolationColors(PresetColors: PColor; BlendPositions: PREAL; Count: INT): TStatus; 
    Function GetInterpolationColors(PresetColors: PColor; BlendPositions: PREAL; Count: INT): TStatus;
    Function SetBlendBellShape(Focus: REAL; Scale: REAL = 1.0): TStatus;
    Function SetBlendTriangularShape(Focus: REAL; Scale: REAL = 1.0): TStatus;
    Function GetTransform(Matrix: TMatrix): TStatus;
    Function SetTransform(Matrix: TMatrix): TStatus;
    Function ResetTransform: TStatus;
    Function MultiplyTransform(Matrix: TMatrix; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
    Function TranslateTransform(DX,DY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
    Function ScaleTransform(SX,SY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
    Function RotateTransform(Angle: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
    Function GetFocusScales(XScale,YScale: PREAL): TStatus;
    Function SetFocusScales(XScale,YScale: REAL): TStatus;
    Function GetWrapMode: TWrapMode;
    Function SetWrapMode(WrapMode: TWrapMode): TStatus;
  end;

implementation

uses
  StrRect,
  gdiplusflat, gdipluspixelformats;

{!!=============================================================================
    TGraphicsPath - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TGraphicsPath - protected methods
-------------------------------------------------------------------------------}

Function TGraphicsPath.GetNativeObject: Pointer;
begin
Result := fNativePath;
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.GetNativeObjectAddr: Pointer;
begin
Result := Addr(fNativePath);
end;

//!!----------------------------------------------------------------------------

constructor TGraphicsPath.Create(Path: TGraphicsPath);
var
  ClonePath:  PGpPath;
begin
inherited Create;
ClonePath := nil;
SetStatus(GdipClonePath(Path.NativeObject,@ClonePath));
SetNativePath(ClonePath);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TGraphicsPath.Create(NativePath: PGpPath);
begin
inherited Create;
fLastResult := Ok;
SetNativePath(NativePath);
end;

//!!----------------------------------------------------------------------------

procedure TGraphicsPath.SetNativePath(NativePathArg: PGpPath);
begin
fNativePath := NativePathArg;
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.SetStatus(Status: TStatus): TStatus;
begin
If Status <> Ok then
  fLastResult := Status;
Result := Status;
end;

{!!-----------------------------------------------------------------------------
    TGraphicsPath - public methods
-------------------------------------------------------------------------------}

constructor TGraphicsPath.Create(FillMode: TFillMode = FillModeAlternate);
begin
inherited Create;
fNativePath := nil;
fLastResult := GdipCreatePath(FillMode,@fNativePath);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TGraphicsPath.Create(Points: PPointF; Types: PBYTE; Count: INT; FillMode: TFillMode = FillModeAlternate);
begin
inherited Create;
fNativePath := nil;
fLastResult := GdipCreatePath2(PGpPointF(Points),Types,Count,FillMode,@fNativePath);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TGraphicsPath.Create(Points: PPoint; Types: PBYTE; Count: INT; FillMode: TFillMode = FillModeAlternate);
begin
inherited Create;
fNativePath := nil;
fLastResult := GdipCreatePath2I(PGpPoint(Points),Types,Count,FillMode,@fNativePath);
end;

//!!----------------------------------------------------------------------------

destructor TGraphicsPath.Destroy;
begin
GdipDeletePath(fNativePath);
inherited;
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.Clone: TGraphicsPath;
var
  ClonePath: PGpPath;
begin
ClonePAth := nil;
SetStatus(GdipClonePath(fNativePath,@ClonePath));
Result := TGraphicsPath.Create(ClonePath);
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.Reset: TStatus;
begin
Result := SetStatus(GdipResetPath(fNativePath));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.GetFillMode: TFillMode;
begin
Result := FillModeAlternate;
SetStatus(GdipGetPathFillMode(fNativePath,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.SetFillMode(FillMode: TFillMode): TStatus;
begin
Result := SetStatus(GdipSetPathFillMode(fNativePath,FillMode));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.GetPathData(PathData: PPathData): TStatus;
var
  Count:  INT;
begin
If Assigned(PathData) then
  begin
    Count := GetPointCount;
    If (Count <= 0) or ((PathData^.Count > 0) and (PathData^.Count < Count)) then
      begin
        PathData^.Count := 0;
        If Assigned(PathData^.Points) then
          begin
            FreeMem(PathData^.Points);
            PathData^.Points := nil;
          end;
        If Assigned(PathData^.Types) then
          begin
            FreeMem(PathData^.Types);
            PathData^.Types := nil;
          end;
        If Count <= 0 then
          begin
            Result := Ok;
            Exit;
          end;
      end;
    If PathData^.Count = 0 then
      begin
        GetMem(PathData^.Points,Count * SizeOf(TPointF));
        If not Assigned(PathData^.Points) then
          begin
            Result := SetStatus(OutOfMemory);
            Exit;
          end;
        GetMem(PathData^.Types,Count);
        If not Assigned(PathData^.Types) then
          begin
            FreeMem(PathData^.Points);
            PathData^.Points := nil;
            Result := SetStatus(OutOfMemory);
            Exit;          
          end;
        PathData^.Count := Count;
      end;
    Result := SetStatus(GdipGetPathData(fNativePath,PGpPathData(PathData)));
  end
else Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.StartFigure: TStatus;
begin
Result := SetStatus(GdipStartPathFigure(fNativePath));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.CloseFigure: TStatus;
begin
Result := SetStatus(GdipClosePathFigure(fNativePath));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.CloseAllFigures: TStatus;
begin
Result := SetStatus(GdipClosePathFigures(fNativePath));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.SetMarker: TStatus;
begin
Result := SetStatus(GdipSetPathMarker(fNativePath));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.ClearMarkers: TStatus;
begin
Result := SetStatus(GdipClearPathMarkers(fNativePath));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.Reverse: TStatus;
begin
Result := SetStatus(GdipReversePath(fNativePath));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.GetLastPoint(LastPoint: PPointF): TStatus;
begin
Result := SetStatus(GdipGetPathLastPoint(fNativePath,PGpPointF(LastPoint)));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddLine(const Pt1,Pt2: TPointF): TStatus;
begin
Result := AddLine(Pt1.X,Pt1.Y,Pt2.X,Pt2.Y);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddLine(X1,Y1,X2,Y2: REAL): TStatus;
begin
Result := SetStatus(GdipAddPathLine(fNativePath,X1,Y1,X2,Y2));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddLines(Points: PPointF; Count: INT): TStatus;
begin
Result := SetStatus(GdipAddPathLine2(fNativePath,PGpPointF(Points),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddLine(const Pt1,Pt2: TPoint): TStatus;
begin
Result := AddLine(Pt1.X,Pt1.Y,Pt2.X,Pt2.Y);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddLine(X1,Y1,X2,Y2: INT): TStatus;
begin
Result := SetStatus(GdipAddPathLineI(fNativePath,X1,Y1,X2,Y2));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddLines(Points: PPoint; Count: INT): TStatus;
begin
Result := SetStatus(GdipAddPathLine2I(fNativePath,PGpPoint(Points),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddArc(const Rect: TRectF; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := AddArc(Rect.X,Rect.Y,Rect.Width,Rect.Height,StartAngle,SweepAngle);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddArc(X,Y,Width,Height: REAL; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := SetStatus(GdipAddPathArc(fNativePath,X,Y,Width,Height,StartAngle,SweepAngle));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddArc(const Rect: TRect; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := AddArc(Rect.X,Rect.Y,Rect.Width,Rect.Height,StartAngle,SweepAngle);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddArc(X,Y,Width,Height: INT; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := SetStatus(GdipAddPathArcI(fNativePath,X,Y,Width,Height,StartAngle,SweepAngle));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddBezier(const Pt1,Pt2,Pt3,Pt4: TPointF): TStatus;
begin
Result := AddBezier(Pt1.X,Pt1.Y,Pt2.X,Pt2.Y,Pt3.X,Pt3.Y,Pt4.X,Pt4.Y);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddBezier(X1,Y1,X2,Y2,X3,Y3,X4,Y4: REAL): TStatus;
begin
Result := SetStatus(GdipAddPathBezier(fNativePath,X1,Y1,X2,Y2,X3,Y3,X4,Y4));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddBeziers(Points: PPointF; Count: INT): TStatus;
begin
Result := SetStatus(GdipAddPathBeziers(fNativePath,PGpPointF(Points),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddBezier(const Pt1,Pt2,Pt3,Pt4: TPoint): TStatus;
begin
Result := AddBezier(Pt1.X,Pt1.Y,Pt2.X,Pt2.Y,Pt3.X,Pt3.Y,Pt4.X,Pt4.Y);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddBezier(X1,Y1,X2,Y2,X3,Y3,X4,Y4: INT): TStatus;
begin
Result := SetStatus(GdipAddPathBezierI(fNativePath,X1,Y1,X2,Y2,X3,Y3,X4,Y4));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddBeziers(Points: PPoint; Count: INT): TStatus;
begin
Result := SetStatus(GdipAddPathBeziersI(fNativePath,PGpPoint(Points),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddCurve(Points: PPointF; Count: INT): TStatus;
begin
Result := SetStatus(GdipAddPathCurve(fNativePath,PGpPointF(Points),Count));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddCurve(Points: PPointF; Count: INT; Tension: REAL): TStatus;
begin
Result := SetStatus(GdipAddPathCurve2(fNativePath,PGpPointF(Points),Count,Tension));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddCurve(Points: PPointF; Count,Offset,NumberOfSegments: INT; Tension: REAL): TStatus;
begin
Result := SetStatus(GdipAddPathCurve3(fNativePath,PGpPointF(Points),Count,Offset,NumberOfSegments,Tension));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddCurve(Points: PPoint; Count: INT): TStatus;
begin
Result := SetStatus(GdipAddPathCurveI(fNativePath,PGpPoint(Points),Count));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddCurve(Points: PPoint; Count: INT; Tension: REAL): TStatus;
begin
Result := SetStatus(GdipAddPathCurve2I(fNativePath,PGpPoint(Points),Count,Tension));
end;             

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddCurve(Points: PPoint; Count,Offset,NumberOfSegments: INT; Tension: REAL): TStatus;
begin
Result := SetStatus(GdipAddPathCurve3I(fNativePath,PGpPoint(Points),Count,Offset,NumberOfSegments,Tension));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddClosedCurve(Points: PPointF; Count: INT): TStatus;
begin
Result := SetStatus(GdipAddPathClosedCurve(fNativePath,PGpPointF(Points),Count));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddClosedCurve(Points: PPointF; Count: INT; Tension: REAL): TStatus;
begin
Result := SetStatus(GdipAddPathClosedCurve2(fNativePath,PGpPointF(Points),Count,Tension));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddClosedCurve(Points: PPoint; Count: INT): TStatus;
begin
Result := SetStatus(GdipAddPathClosedCurveI(fNativePath,PGpPoint(Points),Count));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddClosedCurve(Points: PPoint; Count: INT; Tension: REAL): TStatus;
begin
Result := SetStatus(GdipAddPathClosedCurve2I(fNativePath,PGpPoint(Points),Count,Tension));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddRectangle(const Rect: TRectF): TStatus;
begin
Result := SetStatus(GdipAddPathRectangle(fNativePath,Rect.X,Rect.Y,Rect.Width,Rect.Height));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddRectangleS(Rects: PRectF; Count: INT): TStatus;
begin
Result := SetStatus(GdipAddPathRectangles(fNativePath,PGpRectF(Rects),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddRectangle(const Rect: TRect): TStatus;
begin
Result := SetStatus(GdipAddPathRectangleI(fNativePath,Rect.X,Rect.Y,Rect.Width,Rect.Height));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddRectangleS(Rects: PRect; Count: INT): TStatus;
begin
Result := SetStatus(GdipAddPathRectanglesI(fNativePath,PGpRect(Rects),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddEllipse(const Rect: TRectF): TStatus;
begin
Result := AddEllipse(Rect.X,Rect.Y,Rect.Width,Rect.Height);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddEllipse(X,Y,Width,Height: REAL): TStatus;
begin
Result := SetStatus(GdipAddPathEllipse(fNativePath,X,Y,Width,Height));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddEllipse(const Rect: TRect): TStatus;
begin
Result := AddEllipse(Rect.X,Rect.Y,Rect.Width,Rect.Height);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddEllipse(X,Y,Width,Height: INT): TStatus;
begin
Result := SetStatus(GdipAddPathEllipseI(fNativePath,X,Y,Width,Height));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddPie(const Rect: TRectF; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := AddPie(Rect.X,Rect.Y,Rect.Width,Rect.Height,StartAngle,SweepAngle);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddPie(X,Y,Width,Height: REAL; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := SetStatus(GdipAddPathPie(fNativePath,X,Y,Width,Height,StartAngle,SweepAngle));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddPie(const Rect: TRect; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := AddPie(Rect.X,Rect.Y,Rect.Width,Rect.Height,StartAngle,SweepAngle);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddPie(X,Y,Width,Height: INT; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := SetStatus(GdipAddPathPieI(fNativePath,X,Y,Width,Height,StartAngle,SweepAngle));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddPolygon(Points: PPointF; Count: INT): TStatus;
begin
Result := SetStatus(GdipAddPathPolygon(fNativePath,PGpPointF(Points),Count));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddPolygon(Points: PPoint; Count: INT): TStatus;
begin
Result := SetStatus(GdipAddPathPolygonI(fNativePath,PGpPoint(Points),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddPath(AddingPath: TGraphicsPath; Connect: BOOL): TStatus;
begin
Result := SetStatus(GdipAddPathPath(fNativePath,AddingPath.NativeObject,Connect))
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.AddString(Str: PWideChar; Length: Int; Family: TFontFamily; Style: INT; EmSize: REAL;
  const Origin: TPointF; Format: TStringFormat): TStatus;
var
  LayoutRect: TRectF;
begin
LayoutRect := RectF(Origin.X,Origin.Y,0.0,0.0);
Result := SetStatus(GdipAddPathString(fNativePath,Str,Length,Family.NativeObject,Style,EmSize,@LayoutRect,Format.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddString(Str: PWideChar; Length: Int; Family: TFontFamily; Style: INT; EmSize: REAL{World units};
  const LayoutRect: TRectF; Format: TStringFormat): TStatus;
begin
Result := SetStatus(GdipAddPathString(fNativePath,Str,Length,Family.NativeObject,Style,EmSize,@LayoutRect,Format.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddString(Str: PWideChar; Length: Int; Family: TFontFamily; Style: INT; EmSize: REAL;
  const Origin: TPoint; Format: TStringFormat): TStatus;
var
  LayoutRect:   TRect;
begin
LayoutRect := Rect(Origin.X,Origin.Y,0,0);
Result := SetStatus(GdipAddPathStringI(fNativePath,Str,Length,Family.NativeObject,Style,EmSize,@LayoutRect,Format.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddString(Str: PWideChar; Length: Int; Family: TFontFamily; Style: INT; EmSize: REAL{World units};
  const LayoutRect: TRect; Format: TStringFormat): TStatus;
begin
Result := SetStatus(GdipAddPathStringI(fNativePath,Str,Length,Family.NativeObject,Style,EmSize,@LayoutRect,Format.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddString(const Str: String; Length: Int; Family: TFontFamily; Style: INT; EmSize: REAL;
  const Origin: TPointF; Format: TStringFormat): TStatus;
begin
Result := AddString(PWideChar(StrToWide(Str)),Length,Family,Style,EmSize,Origin,Format);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddString(const Str: String; Length: Int; Family: TFontFamily; Style: INT; EmSize: REAL;
  const LayoutRect: TRectF; Format: TStringFormat): TStatus;
begin
Result := AddString(PWideChar(StrToWide(Str)),Length,Family,Style,EmSize,LayoutRect,Format);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddString(const Str: String; Length: Int; Family: TFontFamily; Style: INT; EmSize: REAL;
  const Origin: TPoint; Format: TStringFormat): TStatus;
begin
Result := AddString(PWideChar(StrToWide(Str)),Length,Family,Style,EmSize,Origin,Format);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.AddString(const Str: String; Length: Int; Family: TFontFamily; Style: INT; EmSize: REAL;
  const LayoutRect: TRect; Format: TStringFormat): TStatus;
begin
Result := AddString(PWideChar(StrToWide(Str)),Length,Family,Style,EmSize,LayoutRect,Format);
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.Transform(Matrix: TMatrix): TStatus;
begin
If Assigned(Matrix) then
  Result := SetStatus(GdipTransformPath(fNativePath,Matrix.NativeObject))
else
  Result := Ok;
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.GetBounds(const Bounds: TRectF; Matrix: TMatrix = nil; Pen: TPen = nil): TStatus;
//!! originally implemented in gdiplusgraphics.h
begin
Result := SetStatus(GdipGetPathWorldBounds(fNativePath,@Bounds,Matrix.NativeObject,Pen.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.GetBounds(const Bounds: TRect; Matrix: TMatrix = nil; Pen: TPen = nil): TStatus;
//!! originally implemented in gdiplusgraphics.h
begin
Result := SetStatus(GdipGetPathWorldBoundsI(fNativePath,@Bounds,Matrix.NativeObject,Pen.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.Flatten(Matrix: TMatrix; Flatness: REAL): TStatus;
begin
Result := SetStatus(GdipFlattenPath(fNativePath,Matrix.NativeObject,Flatness));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.Flatten(Matrix: TMatrix = nil): TStatus;
begin
Result := Flatten(Matrix,FlatnessDefault);
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.Widen(Pen: TPen; Matrix: TMatrix; Flatness: REAL): TStatus;
begin
Result := SetStatus(GdipWidenPath(fNativePath,Pen.NativeObject,Matrix.NativeObject,Flatness));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.Widen(Pen: TPen; Matrix: TMatrix = nil): TStatus;
begin
Result := Widen(Pen,Matrix,FlatnessDefault);
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.Outline(Matrix: TMatrix; Flatness: REAL): TStatus;
begin
Result := SetStatus(GdipWindingModeOutline(fNativePath,Matrix.NativeObject,Flatness));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.Outline(Matrix: TMatrix = nil): TStatus;
begin
Result := Outline(Matrix,FlatnessDefault);
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.Warp(DestPoints: PPointF; Count: INT; const SrcRect: TRectF; Matrix: TMatrix;
  WarpMode: TWarpMode; Flatness: REAL): TStatus;
begin
Result := SetStatus(GdipWarpPath(fNativePath,Matrix.NativeObject,PGpPointF(DestPoints),Count,
  SrcRect.X,SrcRect.Y,SrcRect.Width,SrcRect.Height,WarpMode,Flatness));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.Warp(DestPoints: PPointF; Count: INT; const SrcRect: TRectF; Matrix: TMatrix = nil;
  WarpMode: TWarpMode = WarpModePerspective): TStatus;
begin
Result := Warp(DestPoints,Count,SrcRect,Matrix,WarpMode,FlatnessDefault);
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.GetPointCount: INT;
begin
SetStatus(GdipGetPointCount(fNativePath,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.GetPathTypes(Types: PBYTE; Count: INT): TStatus;
begin
Result := SetStatus(GdipGetPathTypes(fNativePath,Types,Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.GetPathPoints(Points: PPointF; Count: INT): TStatus;
begin
Result := SetStatus(GdipGetPathPoints(fNativePath,PGpPointF(Points),Count));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.GetPathPoints(Points: PPoint; Count: INT): TStatus;
begin
Result := SetStatus(GdipGetPathPointsI(fNativePath,PGpPoint(Points),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.GetLastStatus: TStatus;
begin
Result := fLastResult;
fLastResult := Ok;
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.IsVisible(const Point: TPointF; G: TGraphics = nil): BOOL;
begin
Result := IsVisible(Point.X,Point.Y,G);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.IsVisible(X,Y: REAL; G: TGraphics = nil): BOOL;
//!! originally implemented in gdiplusgraphics.h
begin
Result := False;
SetStatus(GdipIsVisiblePathPoint(fNativePath,X,Y,G.NativeObject,@Result));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.IsVisible(const Point: TPoint; G: TGraphics = nil): BOOL;
begin
Result := IsVisible(Point.X,Point.Y,G);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.IsVisible(X,Y: INT; G: TGraphics = nil): BOOL;
//!! originally implemented in gdiplusgraphics.h
begin
Result := False;
SetStatus(GdipIsVisiblePathPointI(fNativePath,X,Y,G.NativeObject,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPath.IsOutlineVisible(const Point: TPointF; Pen: TPen; G: TGraphics = nil): BOOL;
begin
Result := IsOutlineVisible(Point.X,Point.Y,Pen,G);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.IsOutlineVisible(X,Y: REAL; Pen: TPen; G: TGraphics = nil): BOOL;
//!! originally implemented in gdiplusgraphics.h
begin
Result := False;
SetStatus(GdipIsOutlineVisiblePathPoint(fNativePath,X,Y,Pen.NativeObject,G.NativeObject,@Result));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.IsOutlineVisible(const Point: TPoint; Pen: TPen; G: TGraphics = nil): BOOL;
begin
Result := IsOutlineVisible(Point.X,Point.Y,Pen,G);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPath.IsOutlineVisible(X,Y: INT; Pen: TPen; G: TGraphics = nil): BOOL;
//!! originally implemented in gdiplusgraphics.h
begin
Result := False;
SetStatus(GdipIsOutlineVisiblePathPointI(fNativePath,X,Y,Pen.NativeObject,G.NativeObject,@Result));
end;


{!!=============================================================================
    TGraphicsPathIterator - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TGraphicsPathIterator - protected methods
-------------------------------------------------------------------------------}

procedure TGraphicsPathIterator.SetNativeIterator(NativeIteratorArg: PGpPathIterator);
begin
fNativeIterator := NativeIteratorArg;
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPathIterator.SetStatus(Status: TStatus): TStatus;
begin
If Status <> Ok then
  fLastResult := Status;
Result := Status;
end;

{!!-----------------------------------------------------------------------------
    TGraphicsPathIterator - public methods
-------------------------------------------------------------------------------}

constructor TGraphicsPathIterator.Create(Path: TGraphicsPath);
var
  Iter: PGpPathIterator;
begin
inherited Create;
Iter := nil;
fLastResult := GdipCreatePathIter(@Iter,Path.NativeObject);
SetNativeIterator(Iter);
end;

//!!----------------------------------------------------------------------------

destructor TGraphicsPathIterator.Destroy;
begin
GdipDeletePathIter(fNativeIterator);
inherited;
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPathIterator.NextSubPath(StartIndex,EndIndex: PINT; IsClosed: PBOOL): INT;
begin
SetStatus(GdipPathIterNextSubpath(fNativeIterator,@Result,StartIndex,EndIndex,IsClosed));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPathIterator.NextSubPath(Path: TGraphicsPath; IsClosed: PBOOL): INT;
begin
SetStatus(GdipPathIterNextSubpathPath(fNativeIterator,@Result,Path.NativeObject,IsClosed));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPathIterator.NextPathType(PathType: PBYTE; StartIndex,EndIndex: PINT): INT;
begin
SetStatus(GdipPathIterNextPathType(fNativeIterator,@Result,PathType,StartIndex,EndIndex));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPathIterator.NextMarker(StartIndex,EndIndex: PINT): INT;
begin
SetStatus(GdipPathIterNextMarker(fNativeIterator,@Result,StartIndex,EndIndex));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphicsPathIterator.NextMarker(Path: TGraphicsPath): INT;
begin
SetStatus(GdipPathIterNextMarkerPath(fNativeIterator,@Result,Path.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPathIterator.GetCount: INT;
begin
SetStatus(GdipPathIterGetCount(fNativeIterator,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPathIterator.GetSubpathCount: INT;
begin
SetStatus(GdipPathIterGetSubpathCount(fNativeIterator,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPathIterator.HasCurve: BOOL;
begin
SetStatus(GdipPathIterHasCurve(fNativeIterator,@Result));
end;

//!!----------------------------------------------------------------------------

procedure TGraphicsPathIterator.Rewind;
begin
SetStatus(GdipPathIterRewind(fNativeIterator));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPathIterator.Enumerate(Points: PPointF; Types: PBYTE; Count: INT): INT;
begin
SetStatus(GdipPathIterEnumerate(fNativeIterator,@Result,PGpPointF(Points),Types,Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPathIterator.CopyData(Points: PPointF; Types: PBYTE; StartIndex,EndIndex: INT): INT;
begin
SetStatus(GdipPathIterCopyData(fNativeIterator,@Result,PGpPointF(Points),Types,StartIndex,EndIndex));
end;

//!!----------------------------------------------------------------------------

Function TGraphicsPathIterator.GetLastStatus: TStatus;
begin
Result := fLastResult;
fLastResult := Ok;
end;


{!!=============================================================================
    TPathGradientBrush - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TPathGradientBrush - public methods
-------------------------------------------------------------------------------}

constructor TPathGradientBrush.Create(Points: PPointF; Count: INT; WrapMode: TWrapMode = WrapModeClamp);
var
  Brush:  PGpPathGradient;
begin
inherited Create;
Brush := nil;
fLastResult := GdipCreatePathGradient(PGpPointF(Points),Count,WrapMode,@Brush);
SetNativeBrush(PGpBrush(Brush));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TPathGradientBrush.Create(Points: PPoint; Count: INT; WrapMode: TWrapMode = WrapModeClamp);
var
  Brush:  PGpPathGradient;
begin
inherited Create;
Brush := nil;
fLastResult := GdipCreatePathGradientI(PGpPoint(Points),Count,WrapMode,@Brush);
SetNativeBrush(PGpBrush(Brush));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TPathGradientBrush.Create(Path: TGraphicsPath);
var
  Brush:  PGpPathGradient;
begin
inherited Create;
Brush := nil;
fLastResult := GdipCreatePathGradientFromPath(Path.NativeObject,@Brush);
SetNativeBrush(PGpBrush(Brush));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.GetCenterColor(Color: PColor): TStatus;
var
  Argb: TARGB;
begin
If Assigned(Color) then
  begin
    SetStatus(GdipGetPathGradientCenterColor(PGpPathGradient(fNativeBrush),@Argb));
    SetValue(Color^,Argb);
    Result := fLastResult;
  end
else Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.SetCenterColor(const Color: TColor): TStatus;
begin
SetStatus(GdipSetPathGradientCenterColor(PGpPathGradient(fNativeBrush),GetValue(Color)));
Result := fLastResult;
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.GetPointCount: INT;
begin
SetStatus(GdipGetPathGradientPointCount(PGpPathGradient(fNativeBrush),@Result));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.GetSurroundColorCount: INT;
begin
SetStatus(GdipGetPathGradientSurroundColorCount(PGpPathGradient(fNativeBrush),@Result));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.GetSurroundColors(Colors: PColor; Count: PINT): TStatus;
var
  Count1: INT;
  Argbs:  array of TARGB;
  i:      Integer;
begin
If Assigned(Colors) and Assigned(Count) then
  begin
    SetStatus(GdipGetPathGradientSurroundColorCount(PGpPathGradient(fNativeBrush),@Count1));
    If fLastResult = Ok then
      begin
        If (Count^ >= Count1) and (Count1 > 0) then
          begin
            SetLength(Argbs,Count1);
            If Length(Argbs) > 0 then
              begin
                SetStatus(GdipGetPathGradientSurroundColorsWithCount(
                  PGpPathGradient(fNativeBrush),Pointer(Argbs),@Count1));
                If fLastResult = Ok then
                  begin
                    For i := 0 to Pred(Count1) do
                      SetValue(PColorArray(Colors)^[i],Argbs[i]);
                    Count^ := Count1;
                  end;
                SetLength(Argbs,0);
                Result := fLastResult;
              end
            else Result := SetStatus(OutOfMemory);
          end
        else Result := SetStatus(InsufficientBuffer);
      end
    else Result := fLastResult;
  end
else Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.SetSurroundColors(Colors: PColor; Count: PINT): TStatus;
var
  Count1: INT;
  Argbs:  array of TARGB;
  i:      Integer;
begin
If Assigned(Colors) and Assigned(Count) then
  begin
    Count1 := GetPointCount;
    If (Count^ <= Count1) and (Count1 > 0) then
      begin
        Count1 := Count^;
        SetLength(Argbs,Count1);
        If Length(Argbs) > 0 then
          begin
            For i := 0 to Pred(Count1) do
              Argbs[i] := GetValue(PColorArray(Colors)^[i]);
            SetStatus(GdipSetPathGradientSurroundColorsWithCount(
              PGpPathGradient(fNativeBrush),Pointer(Argbs),@Count1));
            If fLastResult = Ok then
              Count^ := Count1;
            SetLength(Argbs,0);
            Result := fLastResult;
          end
        else Result := SetStatus(OutOfMemory);
      end
    else Result := SetStatus(InvalidParameter);
  end
else Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.GetGraphicsPath(Path: TGraphicsPath): TStatus;
begin
If Assigned(Path) then
  Result := SetStatus(GdipGetPathGradientPath(PGpPathGradient(fNativeBrush),Path.NativeObject))
else
  Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.SetGraphicsPath(Path: TGraphicsPath): TStatus;
begin
If Assigned(Path) then
  Result := SetStatus(GdipSetPathGradientPath(PGpPathGradient(fNativeBrush),Path.NativeObject))
else
  Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.GetCenterPoint(Point: PPointF): TStatus;
begin
Result := SetStatus(GdipGetPathGradientCenterPoint(PGpPathGradient(fNativeBrush),PGpPointF(Point)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TPathGradientBrush.GetCenterPoint(Point: PPoint): TStatus;
begin
Result := SetStatus(GdipGetPathGradientCenterPointI(PGpPathGradient(fNativeBrush),PGpPoint(Point)));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.SetCenterPoint(const Point: TPointF): TStatus;
begin
Result := SetStatus(GdipSetPathGradientCenterPoint(PGpPathGradient(fNativeBrush),@Point));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TPathGradientBrush.SetCenterPoint(const Point: TPoint): TStatus;
begin
Result := SetStatus(GdipSetPathGradientCenterPointI(PGpPathGradient(fNativeBrush),@Point));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.GetRectangle(Rect: PRectF): TStatus;
begin
Result := SetStatus(GdipGetPathGradientRect(PGpPathGradient(fNativeBrush),@Rect));
end;
//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TPathGradientBrush.GetRectangle(Rect: PRect): TStatus;
begin
Result := SetStatus(GdipGetPathGradientRectI(PGpPathGradient(fNativeBrush),@Rect));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.SetGammaCorrection(UseGammaCorrection: BOOL): TStatus;
begin
Result := SetStatus(GdipSetPathGradientGammaCorrection(PGpPathGradient(fNativeBrush),UseGammaCorrection));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.GetGammaCorrection: BOOL;
begin
SetStatus(GdipGetPathGradientGammaCorrection(PGpPathGradient(fNativeBrush),@Result));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.GetBlendCount: INT;
begin
SetStatus(GdipGetPathGradientBlendCount(PGpPathGradient(fNativeBrush),@Result));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.GetBlend(BlendFactors,BlendPositions: PREAL; Count: INT): TStatus;
begin
Result := SetStatus(GdipGetPathGradientBlend(PGpPathGradient(fNativeBrush),BlendFactors,BlendPositions,Count));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.SetBlend(BlendFactors,BlendPositions: PREAL; Count: INT): TStatus;
begin
Result := SetStatus(GdipSetPathGradientBlend(PGpPathGradient(fNativeBrush),BlendFactors,BlendPositions,Count));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.GetInterpolationColorCount: INT;
begin
SetStatus(GdipGetPathGradientPresetBlendCount(PGpPathGradient(fNativeBrush),@Result));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.SetInterpolationColors(PresetColors: PColor; BlendPositions: PREAL; Count: INT): TStatus;
var
  Argbs:  array of TARGB;
  i:      Integer;
begin
SetLength(Argbs,Count);
If Length(Argbs) > 0 then
  begin
    For i := 0 to Pred(Count) do
      Argbs[i] := GetValue(PColorArray(PresetColors)^[i]);
    Result := SetStatus(GdipSetPathGradientPresetBlend(
      PGpPathGradient(fNativeBrush),Pointer(Argbs),BlendPositions,Count));
    SetLength(Argbs,0);
  end
else Result := SetStatus(OutOfMemory);
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.GetInterpolationColors(PresetColors: PColor; BlendPositions: PREAL; Count: INT): TStatus;
var
  Argbs:  array of TARGB;
  i:      Integer;
begin
If (Count > 0) and Assigned(PresetColors) then
  begin
    SetLength(Argbs,Count);
    If Length(Argbs) > 0 then
      begin
        Result := SetStatus(GdipGetPathGradientPresetBlend(
          PGpPathGradient(fNativeBrush),Pointer(Argbs),BlendPositions,Count));
        For i := 0 to Pred(Count) do
          PColorArray(PresetColors)^[i] := Color(Argbs[i]);
        SetLength(Argbs,0);
      end
    else Result := SetStatus(OutOfMemory);
  end
else Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.SetBlendBellShape(Focus: REAL; Scale: REAL = 1.0): TStatus;
begin
Result := SetStatus(GdipSetPathGradientSigmaBlend(PGpPathGradient(fNativeBrush),Focus,Scale));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.SetBlendTriangularShape(Focus: REAL; Scale: REAL = 1.0): TStatus;
begin
Result := SetStatus(GdipSetPathGradientLinearBlend(PGpPathGradient(fNativeBrush),Focus,Scale));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.GetTransform(Matrix: TMatrix): TStatus;
begin
Result := SetStatus(GdipGetPathGradientTransform(PGpPathGradient(fNativeBrush),Matrix.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.SetTransform(Matrix: TMatrix): TStatus;
begin
Result := SetStatus(GdipSetPathGradientTransform(PGpPathGradient(fNativeBrush),Matrix.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.ResetTransform: TStatus;
begin
Result := SetStatus(GdipResetPathGradientTransform(PGpPathGradient(fNativeBrush)));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.MultiplyTransform(Matrix: TMatrix; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipMultiplyPathGradientTransform(PGpPathGradient(fNativeBrush),Matrix.NativeObject,Order));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.TranslateTransform(DX,DY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipTranslatePathGradientTransform(PGpPathGradient(fNativeBrush),DX,DY,Order));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.ScaleTransform(SX,SY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipScalePathGradientTransform(PGpPathGradient(fNativeBrush),SX,SY,Order));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.RotateTransform(Angle: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipRotatePathGradientTransform(PGpPathGradient(fNativeBrush),Angle,Order));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.GetFocusScales(XScale,YScale: PREAL): TStatus;
begin
Result := SetStatus(GdipGetPathGradientFocusScales(PGpPathGradient(fNativeBrush),XScale,YScale));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.SetFocusScales(XScale,YScale: REAL): TStatus;
begin
Result := SetStatus(GdipSetPathGradientFocusScales(PGpPathGradient(fNativeBrush),XScale,YScale));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.GetWrapMode: TWrapMode;
begin
SetStatus(GdipGetPathGradientWrapMode(PGpPathGradient(fNativeBrush),@Result));
end;

//!!----------------------------------------------------------------------------

Function TPathGradientBrush.SetWrapMode(WrapMode: TWrapMode): TStatus;
begin
Result := SetStatus(GdipSetPathGradientWrapMode(PGpPathGradient(fNativeBrush),WrapMode));
end;

end.
