(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusGraphics.h
*
* Abstract:
*
*   GDI+ Graphics Object
*
\**************************************************************************)
unit gdiplusgraphics;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  AuxTypes,
  gdiplus_common,
  gdiplusbase, gdiplusheaders, gdiplustypes, gdiplusgpstubs, gdipluspen,
  gdiplusenums, gdiplusmatrix, gdipluscolor, gdipluspath, gdiplusbrush,
  gdiplusstringformat, gdiplusimageattributes, gdipluseffects;

{!!=============================================================================
    TGraphics - class declaration
===============================================================================}
type
  TGraphics = class(gdiplusheaders.TGraphics)
  protected
    constructor Create(Graphics: PGpGraphics);
    procedure SetNativeGraphics(Graphics: PGpGraphics);
    Function SetStatus(Status: TStatus): TStatus;
    Function GetNativeGraphics: PGpGraphics;
    Function GetNativePen(Pen: TPen): PGpPen;
  public
    class Function FromHDC(hDC: HDC): TGraphics; overload;
    class Function FromHDC(hDC: HDC; hDevice: HANDLE): TGraphics; overload;
    class Function FromHWND(hWnd: HWND; ICM: BOOL = False): TGraphics;
    class Function FromImage(Image: TImage): TGraphics;
  {!!
    Following constructors have extended names (ie. not just "Create") because
    delphi cannot distinguish between HDC and HWND (it sees them as the same
    type) and select proper overload/constructor.
  }
    constructor CreateFromHDC(hDC: HDC); overload;
    constructor CreateFromHDC(hDC: HDC; hDevice: HANDLE); overload;
    constructor CreateFromHWND(hWnd: HWND; ICM: BOOL = False);
    constructor CreateFromImage(Image: TImage);
    destructor Destroy; override;
    procedure Flush(Intention: TFlushIntention = FlushIntentionFlush);
    //------------------------------------------------------------------------
    // GDI Interop methods
    //------------------------------------------------------------------------
    // Locks the graphics until ReleaseDC is called
    Function GetHDC: HDC;
    procedure ReleaseHDC(hDC: HDC);
    //------------------------------------------------------------------------
    // Rendering modes
    //------------------------------------------------------------------------
    Function SetRenderingOrigin(X,Y: INT): TStatus;
    Function GetRenderingOrigin(X,Y: PINT): TStatus; 
    Function SetCompositingMode(CompositingMode: TCompositingMode): TStatus;
    Function GetCompositingMode: TCompositingMode;
    Function SetCompositingQuality(CompositingQuality: TCompositingQuality): TStatus;
    Function GetCompositingQuality: TCompositingQuality;
    Function SetTextRenderingHint(NewMode: TTextRenderingHint): TStatus;
    Function GetTextRenderingHint: TTextRenderingHint;
    Function SetTextContrast(Contrast: UINT): TStatus;
    Function GetTextContrast: UINT;
    Function GetInterpolationMode: TInterpolationMode;
    Function SetInterpolationMode(InterpolationMode: TInterpolationMode): TStatus;
  {$IF GDIPVER >= $0110}
    Function SetAbort(PIAbort: PGdiplusAbort): TStatus;
  {$IFEND}
    Function GetSmoothingMode: TSmoothingMode;
    Function SetSmoothingMode(SmoothingMode: TSmoothingMode): TStatus;
    Function GetPixelOffsetMode: TPixelOffsetMode;
    Function SetPixelOffsetMode(PixelOffsetMode: TPixelOffsetMode): TStatus;
    //------------------------------------------------------------------------
    // Manipulate current world transform
    //------------------------------------------------------------------------
    Function SetTransform(Matrix: TMatrix): TStatus;
    Function ResetTransform: TStatus;
    Function MultiplyTransform(Matrix: TMatrix; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
    Function TranslateTransform(DX,DY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
    Function ScaleTransform(SX,SY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
    Function RotateTransform(Angle: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
    Function GetTransform(Matrix: TMatrix): TStatus;
    Function SetPageUnit(PageUnit: TUnit): TStatus;
    Function SetPageScale(Scale: REAL): TStatus;
    Function GetPageUnit: TUnit;
    Function GetPageScale: REAL;
    Function GetDpiX: REAL;
    Function GetDpiY: REAL;
    Function TransformPoints(DestSpace,SrcSpace: TCoordinateSpace; Pts: PPointF; Count: INT): TStatus; overload;
    Function TransformPoints(DestSpace,SrcSpace: TCoordinateSpace; Pts: PPoint; Count: INT): TStatus; overload;
    //------------------------------------------------------------------------
    // GetNearestColor (for <= 8bpp surfaces).  Note: Alpha is ignored.
    //------------------------------------------------------------------------
    Function GetNearestColor(Color: PColor): TStatus;
    Function DrawLine(Pen: TPen; X1,Y1,X2,Y2: REAL): TStatus; overload;
    Function DrawLine(Pen: TPen; const Pt1,Pt2: TPointF): TStatus; overload;
    Function DrawLines(Pen: TPen; Points: PPointF; Count: INT): TStatus; overload;
    Function DrawLine(Pen: TPen; X1,Y1,X2,Y2: INT): TStatus; overload;
    Function DrawLine(Pen: TPen; const Pt1,Pt2: TPoint): TStatus; overload;
    Function DrawLines(Pen: TPen; Points: PPoint; Count: INT): TStatus; overload;
    Function DrawArc(Pen: TPen; X,Y,Width,Height,StartAngle,SweepAngle: REAL): TStatus; overload;
    Function DrawArc(Pen: TPen; const Rect: TRectF; StartAngle,SweepAngle: REAL): TStatus; overload;
    Function DrawArc(Pen: TPen; X,Y,Width,Height: INT; StartAngle,SweepAngle: REAL): TStatus; overload;
    Function DrawArc(Pen: TPen; const Rect: TRect; StartAngle,SweepAngle: REAL): TStatus; overload;
    Function DrawBezier(Pen: TPen; X1,Y1,X2,Y2,X3,Y3,X4,Y4: REAL): TStatus; overload;
    Function DrawBezier(Pen: TPen; const Pt1,Pt2,Pt3,Pt4: TPointF): TStatus; overload;
    Function DrawBeziers(Pen: TPen; Points: PPointF; Count: INT): TStatus; overload;
    Function DrawBezier(Pen: TPen; X1,Y1,X2,Y2,X3,Y3,X4,Y4: INT): TStatus; overload;
    Function DrawBezier(Pen: TPen; const Pt1,Pt2,Pt3,Pt4: TPoint): TStatus; overload;
    Function DrawBeziers(Pen: TPen; Points: PPoint; Count: INT): TStatus; overload;
    Function DrawRectangle(Pen: TPen; const Rect: TRectF): TStatus; overload;
    Function DrawRectangle(Pen: TPen; X,Y,Width,Height: REAL): TStatus; overload;
    Function DrawRectangles(Pen: TPen; Rects: PRectF; Count: INT): TStatus; overload;
    Function DrawRectangle(Pen: TPen; const Rect: TRect): TStatus; overload;
    Function DrawRectangle(Pen: TPen; X,Y,Width,Height: INT): TStatus; overload;
    Function DrawRectangles(Pen: TPen; Rects: PRect; Count: INT): TStatus; overload;
    Function DrawEllipse(Pen: TPen; const Rect: TRectF): TStatus; overload;
    Function DrawEllipse(Pen: TPen; X,Y,Width,Height: REAL): TStatus; overload;
    Function DrawEllipse(Pen: TPen; const Rect: TRect): TStatus; overload;
    Function DrawEllipse(Pen: TPen; X,Y,Width,Height: INT): TStatus; overload;
    Function DrawPie(Pen: TPen; const Rect: TRectF; StartAngle,SweepAngle: REAL): TStatus; overload;
    Function DrawPie(Pen: TPen; X,Y,Width,Height,StartAngle,SweepAngle: REAL): TStatus; overload;
    Function DrawPie(Pen: TPen; const Rect: TRect; StartAngle,SweepAngle: REAL): TStatus; overload;
    Function DrawPie(Pen: TPen; X,Y,Width,Height: INT; StartAngle,SweepAngle: REAL): TStatus; overload;
    Function DrawPolygon(Pen: TPen; Points: PPointF; Count: INT): TStatus; overload;
    Function DrawPolygon(Pen: TPen; Points: PPoint; Count: INT): TStatus; overload;
    Function DrawPath(Pen: TPen; Path: TGraphicsPath): TStatus;
    Function DrawCurve(Pen: TPen; Points: PPointF; Count: INT): TStatus; overload;
    Function DrawCurve(Pen: TPen; Points: PPointF; Count: INT; Tension: REAL): TStatus; overload;
    Function DrawCurve(Pen: TPen; Points: PPointF; Count,Offset,NumberOfSegments: INT; Tension: REAL = 0.5): TStatus; overload;
    Function DrawCurve(Pen: TPen; Points: PPoint; Count: INT): TStatus; overload;
    Function DrawCurve(Pen: TPen; Points: PPoint; Count: INT; Tension: REAL): TStatus; overload;
    Function DrawCurve(Pen: TPen; Points: PPoint; Count,Offset,NumberOfSegments: INT; Tension: REAL = 0.5): TStatus; overload;
    Function DrawClosedCurve(Pen: TPen; Points: PPointF; Count: INT): TStatus; overload;
    Function DrawClosedCurve(Pen: TPen; Points: PPointF; Count: INT; Tension: REAL): TStatus; overload;
    Function DrawClosedCurve(Pen: TPen; Points: PPoint; Count: INT): TStatus; overload;
    Function DrawClosedCurve(Pen: TPen; Points: PPoint; Count: INT; Tension: REAL): TStatus; overload;
    Function Clear(const Color: TColor): TStatus;
    Function FillRectangle(Brush: TBrush; const Rect: TRectF): TStatus; overload;
    Function FillRectangle(Brush: TBrush; X,Y,Width,Height: REAL): TStatus; overload;
    Function FillRectangles(Brush: TBrush; Rects: PRectF; Count: INT): TStatus; overload;
    Function FillRectangle(Brush: TBrush; const Rect: TRect): TStatus; overload;
    Function FillRectangle(Brush: TBrush; X,Y,Width,Height: INT): TStatus; overload;
    Function FillRectangles(Brush: TBrush; Rects: PRect; Count: INT): TStatus; overload;
    Function FillPolygon(Brush: TBrush; Points: PPointF; Count: INT): TStatus; overload;
    Function FillPolygon(Brush: TBrush; Points: PPointF; Count: INT; FillMode: TFillMode): TStatus; overload;
    Function FillPolygon(Brush: TBrush; Points: PPoint; Count: INT): TStatus; overload;
    Function FillPolygon(Brush: TBrush; Points: PPoint; Count: INT; FillMode: TFillMode): TStatus; overload;
    Function FillEllipse(Brush: TBrush; const Rect: TRectF): TStatus; overload;
    Function FillEllipse(Brush: TBrush; X,Y,Width,Height: REAL): TStatus; overload;
    Function FillEllipse(Brush: TBrush; const Rect: TRect): TStatus; overload;
    Function FillEllipse(Brush: TBrush; X,Y,Width,Height: INT): TStatus; overload;
    Function FillPie(Brush: TBrush; const Rect: TRectF; StartAngle,SweepAngle: REAL): TStatus; overload;
    Function FillPie(Brush: TBrush; X,Y,Width,Height,StartAngle,SweepAngle: REAL): TStatus; overload;
    Function FillPie(Brush: TBrush; const Rect: TRect; StartAngle,SweepAngle: REAL): TStatus; overload;
    Function FillPie(Brush: TBrush; X,Y,Width,Height: INT; StartAngle,SweepAngle: REAL): TStatus; overload;
    Function FillPath(Brush: TBrush; Path: TGraphicsPath): TStatus;
    Function FillClosedCurve(Brush: TBrush; Points: PPointF; Count: INT): TStatus; overload;
    Function FillClosedCurve(Brush: TBrush; Points: PPointF; Count: INT; FillMode: TFillMode; Tension: REAL = 0.5): TStatus; overload;
    Function FillClosedCurve(Brush: TBrush; Points: PPoint; Count: INT): TStatus; overload;
    Function FillClosedCurve(Brush: TBrush; Points: PPoint; Count: INT; FillMode: TFillMode; Tension: REAL = 0.5): TStatus; overload;
    Function FillRegion(Brush: TBrush; Region: TRegion): TStatus;
    Function DrawString(Str: PWideChar; Length: INT; Font: TFont; const LayoutRect: TRectF; StringFormat: TStringFormat;
      Brush: TBrush): TStatus; overload;
    Function DrawString(const Str: String; Length: INT; Font: TFont; const LayoutRect: TRectF; StringFormat: TStringFormat;
      Brush: TBrush): TStatus; overload;
    Function DrawString(Str: PWideChar; Length: INT; Font: TFont; const Origin: TPointF; Brush: TBrush): TStatus; overload;
    Function DrawString(const Str: String; Length: INT; Font: TFont; const Origin: TPointF; Brush: TBrush): TStatus; overload;
    Function DrawString(Str: PWideChar; Length: INT; Font: TFont; const Origin: TPointF; StringFormat: TStringFormat;
      Brush: TBrush): TStatus; overload;
    Function DrawString(const Str: String; Length: INT; Font: TFont; const Origin: TPointF; StringFormat: TStringFormat;
      Brush: TBrush): TStatus; overload;
    Function MeasureString(Str: PWideChar; Length: INT; Font: TFont; const LayoutRect: TRectF; StringFormat: TStringFormat;
      BoundingBox: PRectF; CodepointsFitted: PINT = nil; LinesFilled: PINT = nil): TStatus; overload;
    Function MeasureString(const Str: String; Length: INT; Font: TFont; const LayoutRect: TRectF; StringFormat: TStringFormat;
      BoundingBox: PRectF; CodepointsFitted: PINT = nil; LinesFilled: PINT = nil): TStatus; overload;
    Function MeasureString(Str: PWideChar; Length: INT; Font: TFont; const LayoutRectSize: TSizeF; StringFormat: TStringFormat;
      Size: PSizeF; CodepointsFitted: PINT = nil; LinesFilled: PINT = nil): TStatus; overload;
    Function MeasureString(const Str: String; Length: INT; Font: TFont; const LayoutRectSize: TSizeF; StringFormat: TStringFormat;
      Size: PSizeF; CodepointsFitted: PINT = nil; LinesFilled: PINT = nil): TStatus; overload;
    Function MeasureString(Str: PWideChar; Length: INT; Font: TFont; const Origin: TPointF; StringFormat: TStringFormat;
      BoundingBox: PRectF): TStatus; overload;
    Function MeasureString(const Str: String; Length: INT; Font: TFont; const Origin: TPointF; StringFormat: TStringFormat;
      BoundingBox: PRectF): TStatus; overload;
    Function MeasureString(Str: PWideChar; Length: INT; Font: TFont; const LayoutRect: TRectF; BoundingBox: PRectF): TStatus; overload;
    Function MeasureString(const Str: String; Length: INT; Font: TFont; const LayoutRect: TRectF; BoundingBox: PRectF): TStatus; overload;
    Function MeasureString(Str: PWideChar; Length: INT; Font: TFont; const Origin: TPointF; BoundingBox: PRectF): TStatus; overload;
    Function MeasureString(const Str: String; Length: INT; Font: TFont; const Origin: TPointF; BoundingBox: PRectF): TStatus; overload;
    Function MeasureCharacterRanges(Str: PWideChar; Length: INT; Font: TFont; const LayoutRect: TRectF; StringFormat: TStringFormat;
      RegionCount: INT; Regions: PRegion): TStatus; overload;
    Function MeasureCharacterRanges(const Str: String; Length: INT; Font: TFont; const LayoutRect: TRectF; StringFormat: TStringFormat;
      RegionCount: INT; Regions: PRegion): TStatus; overload;
    Function DrawDriverString(Text: PUINT16; Length: INT; Font: TFont; Brush: TBrush; Positions: PPointF;
      Flags: INT; Matrix: TMatrix): TStatus;
    Function MeasureDriverString(Text: PUINT16; Length: INT; Font: TFont; Positions: PPointF; Flags: INT;
      Matrix: TMatrix; BoundingBox: PRectF): TStatus;
    // Draw a cached bitmap on this graphics destination offset by
    // x, y. Note this will fail with WrongState if the CachedBitmap
    // native format differs from this Graphics.
    Function DrawCachedBitmap(CB: TCachedBitmap; X,Y: INT): TStatus;
    Function DrawImage(Image: TImage; const Point: TPointF): TStatus; overload;
    Function DrawImage(Image: TImage; X,Y: REAL): TStatus; overload;
    Function DrawImage(Image: TImage; const Rect: TRectF): TStatus; overload;
    Function DrawImage(Image: TImage; X,Y,Width,Height: REAL): TStatus; overload;
    Function DrawImage(Image: TImage; const Point: TPoint): TStatus; overload;
    Function DrawImage(Image: TImage; X,Y: INT): TStatus; overload;
    Function DrawImage(Image: TImage; const Rect: TRect): TStatus; overload;
    Function DrawImage(Image: TImage; X,Y,Width,Height: INT): TStatus; overload;
    Function DrawImage(Image: TImage; DestPoints: PPointF; Count: INT): TStatus; overload;
    Function DrawImage(Image: TImage; DestPoints: PPoint; Count: INT): TStatus; overload;
    Function DrawImage(Image: TImage; X,Y,SrcX,SrcY,SrcWidth,SrcHeight: REAL; SrcUnit: TUnit): TStatus; overload;
    Function DrawImage(Image: TImage; const DestRect: TRectF; SrcX,SrcY,SrcWidth,SrcHeight: REAL; SrcUnit: TUnit;
      ImageAttributes: TImageAttributes = nil; Callback: TDrawImageAbort = nil; CallbackData: Pointer = nil): TStatus; overload;
    Function DrawImage(Image: TImage; DestPoints: PPointF; Count: INT; SrcX,SrcY,SrcWidth,SrcHeight: REAL; SrcUnit: TUnit;
      ImageAttributes: TImageAttributes = nil; Callback: TDrawImageAbort = nil; CallbackData: Pointer = nil): TStatus; overload;
    Function DrawImage(Image: TImage; X,Y,SrcX,SrcY,SrcWidth,SrcHeight: INT; SrcUnit: TUnit): TStatus; overload;
    Function DrawImage(Image: TImage; const DestRect: TRect; SrcX,SrcY,SrcWidth,SrcHeight: INT; SrcUnit: TUnit;
      ImageAttributes: TImageAttributes = nil; Callback: TDrawImageAbort = nil; CallbackData: Pointer = nil): TStatus; overload;
    Function DrawImage(Image: TImage; DestPoints: PPoint; Count: INT; SrcX,SrcY,SrcWidth,SrcHeight: INT; SrcUnit: TUnit;
      ImageAttributes: TImageAttributes = nil; Callback: TDrawImageAbort = nil; CallbackData: Pointer = nil): TStatus; overload;
  {$IF GDIPVER >= $0110}
    Function DrawImage(Image: TImage; const DestRect,SourceRect: TRectF; SrcUnit: TUnit;
      ImageAttributes: TImageAttributes = nil): TStatus; overload;
    Function DrawImage(Image: TImage; const SourceRect: TRectF; XForm: TMatrix; Effect: TEffect;
      ImageAttributes: TImageAttributes; SrcUnit: TUnit): TStatus; overload;
  {$IFEND}
    // The following methods are for playing an EMF+ to a graphics
    // via the enumeration interface.  Each record of the EMF+ is
    // sent to the callback (along with the callbackData).  Then
    // the callback can invoke the Metafile::PlayRecord method
    // to play the particular record.
    Function EnumerateMetafile(MetaFile: TMetafile; const DestPoint: TPointF; Callback: TEnumerateMetafileProc;
      CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus; overload;
    Function EnumerateMetafile(MetaFile: TMetafile; const DestPoint: TPoint; Callback: TEnumerateMetafileProc;
      CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus; overload;
    Function EnumerateMetafile(MetaFile: TMetafile; const DestRect: TRectF; Callback: TEnumerateMetafileProc;
      CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus; overload;
    Function EnumerateMetafile(MetaFile: TMetafile; const DestRect: TRect; Callback: TEnumerateMetafileProc;
      CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus; overload;
    Function EnumerateMetafile(MetaFile: TMetafile; DestPoints: PPointF; Count: INT; Callback: TEnumerateMetafileProc;
      CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus; overload;
    Function EnumerateMetafile(MetaFile: TMetafile; DestPoints: PPoint; Count: INT; Callback: TEnumerateMetafileProc;
      CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus; overload;      
    Function EnumerateMetafile(MetaFile: TMetafile; const DestPoint: TPointF; const SrcRect: TRectF; SrcUnit: TUnit;
      Callback: TEnumerateMetafileProc; CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus; overload;
    Function EnumerateMetafile(MetaFile: TMetafile; const DestPoint: TPoint; const SrcRect: TRect; SrcUnit: TUnit;
      Callback: TEnumerateMetafileProc; CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus; overload;
    Function EnumerateMetafile(MetaFile: TMetafile; const DestRect,SrcRect: TRectF; SrcUnit: TUnit;
      Callback: TEnumerateMetafileProc; CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus; overload;
    Function EnumerateMetafile(MetaFile: TMetafile; const DestRect,SrcRect: TRect; SrcUnit: TUnit;
      Callback: TEnumerateMetafileProc; CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus; overload;
    Function EnumerateMetafile(MetaFile: TMetafile; DestPoints: PPointF; Count: INT; const SrcRect: TRectF; SrcUnit: TUnit;
      Callback: TEnumerateMetafileProc; CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus; overload;
    Function EnumerateMetafile(MetaFile: TMetafile; DestPoints: PPoint; Count: INT; const SrcRect: TRect; SrcUnit: TUnit;
      Callback: TEnumerateMetafileProc; CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus; overload;
    Function SetClip(G: TGraphics; CombineMode: TCombineMode = CombineModeReplace): TStatus; overload;
    Function SetClip(const Rect: TRectF; CombineMode: TCombineMode = CombineModeReplace): TStatus; overload;
    Function SetClip(const Rect: TRect; CombineMode: TCombineMode = CombineModeReplace): TStatus; overload;
    Function SetClip(Path: TGraphicsPath; CombineMode: TCombineMode = CombineModeReplace): TStatus; overload;
    Function SetClip(Region: TRegion; CombineMode: TCombineMode = CombineModeReplace): TStatus; overload;
    // This is different than the other SetClip methods because it assumes
    // that the HRGN is already in device units, so it doesn't transform
    // the coordinates in the HRGN.
    Function SetClip(HRgn: HRGN; CombineMode: TCombineMode = CombineModeReplace): TStatus; overload;
    Function IntersectClip(const Rect: TRectF): TStatus; overload;
    Function IntersectClip(const Rect: TRect): TStatus; overload;
    Function IntersectClip(Region: TRegion): TStatus; overload;
    Function ExcludeClip(const Rect: TRectF): TStatus; overload;
    Function ExcludeClip(const Rect: TRect): TStatus; overload;
    Function ExcludeClip(Region: TRegion): TStatus; overload;
    Function ResetClip: TStatus;
    Function TranslateClip(DX,DY: REAL): TStatus; overload;
    Function TranslateClip(DX,DY: INT): TStatus; overload;
    Function GetClip(Region: TRegion): TStatus;
    Function GetClipBounds(Rect: PRectF): TStatus; overload;
    Function GetClipBounds(Rect: PRect): TStatus; overload;
    Function IsClipEmpty: BOOL;
    Function GetVisibleClipBounds(Rect: PRectF): TStatus; overload;
    Function GetVisibleClipBounds(Rect: PRect): TStatus; overload;
    Function IsVisibleClipEmpty: BOOL;
    Function IsVisible(X,Y: INT): BOOL; overload;
    Function IsVisible(const Point: TPoint): BOOL; overload;
    Function IsVisible(X,Y,Width,Height: INT): BOOL; overload;
    Function IsVisible(const Rect: TRect): BOOL; overload;
    Function IsVisible(X,Y: REAL): BOOL; overload;
    Function IsVisible(const Point: TPointF): BOOL; overload;
    Function IsVisible(X,Y,Width,Height: REAL): BOOL; overload;
    Function IsVisible(const Rect: TRectF): BOOL; overload;
    Function Save: TGraphicsState;
    Function Restore(GState: TGraphicsState): TStatus;
    Function BeginContainer(const DstRect,SrcRect: TRectF; aUnit: TUnit): TGraphicsContainer; overload;
    Function BeginContainer(const DstRect,SrcRect: TRect; aUnit: TUnit): TGraphicsContainer; overload;
    Function BeginContainer: TGraphicsContainer; overload;
    Function EndContainer(State: TGraphicsContainer): TStatus;
    // Only valid when recording metafiles.
    Function AddMetafileComment(Data: PBYTE; SizeData: UINT): TStatus;
    Function GetHalftonePalette: HPALETTE;
    Function GetLastStatus: TStatus;
  end;

//----------------------------------------------------------------------------
// Implementation of GraphicsPath methods that use Graphics
//----------------------------------------------------------------------------

{!!
  Implemantation of methods TGraphicsPath.GetBounds, TGraphicsPath.IsVisible
  and TGraphicsPath.IsOutlineVisible, originally placed here, were moved to
  main implementation of TGraphicsPath class.
}

implementation

uses
  StrRect,
  gdiplusflat, gdipluspixelformats;

{!!=============================================================================
    TGraphics - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TGraphics - protected methods
-------------------------------------------------------------------------------}

constructor TGraphics.Create(Graphics: PGpGraphics);
begin
inherited Create;
fLAstResult := Ok;
SetNativeGraphics(Graphics);
end;

//!!----------------------------------------------------------------------------

procedure TGraphics.SetNativeGraphics(Graphics: PGpGraphics);
begin
fNativeGraphics := Graphics;
end;

//!!----------------------------------------------------------------------------

Function TGraphics.SetStatus(Status: TStatus): TStatus;
begin
If Status <> Ok then
  fLastResult := Status;
Result := Status;
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetNativeGraphics: PGpGraphics;
begin
Result := fNativeGraphics;
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetNativePen(Pen: TPen): PGpPen;
begin
Result := Pen.NativeObject;
end;

{!!-----------------------------------------------------------------------------
    TGraphics - public methods
-------------------------------------------------------------------------------}

class Function TGraphics.FromHDC(hDC: HDC): TGraphics;
begin
Result := TGraphics.CreateFromHDC(hDC);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class Function TGraphics.FromHDC(hDC: HDC; hDevice: HANDLE): TGraphics;
begin
Result := TGraphics.CreateFromHDC(hDC,hDevice);
end;

//!!----------------------------------------------------------------------------

class Function TGraphics.FromHWND(hWnd: HWND; ICM: BOOL = False): TGraphics;
begin
Result := TGraphics.CreateFromHWND(hWnd,ICM);
end;

//!!----------------------------------------------------------------------------

class Function TGraphics.FromImage(Image: TImage): TGraphics;
begin
Result := TGraphics.CreateFromImage(Image);
end;

//!!----------------------------------------------------------------------------

constructor TGraphics.CreateFromHDC(hDC: HDC);
var
  Graphics: PGpGraphics;
begin
inherited Create;
Graphics := nil;
fLastResult := GdipCreateFromHDC(hDC,@Graphics);
SetNativeGraphics(Graphics);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TGraphics.CreateFromHDC(hDC: HDC; hDevice: HANDLE);
var
  Graphics: PGpGraphics;
begin
inherited Create;
Graphics := nil;
fLastResult := GdipCreateFromHDC2(hDC,hDevice,@Graphics);
SetNativeGraphics(Graphics);
end;

//!!----------------------------------------------------------------------------

constructor TGraphics.CreateFromHWND(hWnd: HWND; ICM: BOOL = False);
var
  Graphics: PGpGraphics;
begin
inherited Create;
Graphics := nil;
If ICM then
  fLastResult := GdipCreateFromHWNDICM(hWnd,@Graphics)
else
  fLastResult := GdipCreateFromHWND(hWnd,@Graphics);
SetNativeGraphics(Graphics);
end;

//!!----------------------------------------------------------------------------

constructor TGraphics.CreateFromImage(Image: TImage);
var
  Graphics: PGpGraphics;
begin
inherited Create;
Graphics := nil;
If Assigned(Image) then
  fLastResult := GdipGetImageGraphicsContext(Image.NativeObject,@Graphics);
SetNativeGraphics(Graphics);
end;

//!!----------------------------------------------------------------------------

destructor TGraphics.Destroy;
begin
GdipDeleteGraphics(fNativeGraphics);
inherited;
end;

//!!----------------------------------------------------------------------------

procedure TGraphics.Flush(Intention: TFlushIntention = FlushIntentionFlush);
begin
GdipFlush(fNativeGraphics,Intention);
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetHDC: HDC;
begin
SetStatus(GdipGetDC(fNativeGraphics,@Result));
end;

//!!----------------------------------------------------------------------------

procedure TGraphics.ReleaseHDC(hDC: HDC);
begin
SetStatus(GdipReleaseDC(fNativeGraphics,hDC));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.SetRenderingOrigin(X,Y: INT): TStatus;
begin
Result := SetStatus(GdipSetRenderingOrigin(fNativeGraphics,X,Y));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetRenderingOrigin(X,Y: PINT): TStatus;
begin
Result := SetStatus(GdipGetRenderingOrigin(fNativeGraphics,X,Y));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.SetCompositingMode(CompositingMode: TCompositingMode): TStatus;
begin
Result := SetStatus(GdipSetCompositingMode(fNativeGraphics,CompositingMode));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetCompositingMode: TCompositingMode;
begin
SetStatus(GdipGetCompositingMode(fNativeGraphics,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.SetCompositingQuality(CompositingQuality: TCompositingQuality): TStatus;
begin
Result := SetStatus(GdipSetCompositingQuality(fNativeGraphics,CompositingQuality));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetCompositingQuality: TCompositingQuality;
begin
SetStatus(GdipGetCompositingQuality(fNativeGraphics,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.SetTextRenderingHint(NewMode: TTextRenderingHint): TStatus;
begin
Result := SetStatus(GdipSetTextRenderingHint(fNativeGraphics,NewMode));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetTextRenderingHint: TTextRenderingHint;
begin
SetStatus(GdipGetTextRenderingHint(fNativeGraphics,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.SetTextContrast(Contrast: UINT): TStatus;
begin
Result := SetStatus(GdipSetTextContrast(fNativeGraphics,Contrast));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetTextContrast: UINT;
begin
SetStatus(GdipGetTextContrast(fNativeGraphics,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetInterpolationMode: TInterpolationMode;
begin
SetStatus(GdipGetInterpolationMode(fNativeGraphics,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.SetInterpolationMode(InterpolationMode: TInterpolationMode): TStatus;
begin
Result := SetStatus(GdipSetInterpolationMode(fNativeGraphics,InterpolationMode));
end;

{$IF GDIPVER >= $0110}
//!!----------------------------------------------------------------------------

Function TGraphics.SetAbort(PIAbort: PGdiplusAbort): TStatus;
begin
Result := SetStatus(GdipGraphicsSetAbort(fNativeGraphics,PIAbort));
end;

{$IFEND}
//!!----------------------------------------------------------------------------

Function TGraphics.GetSmoothingMode: TSmoothingMode;
begin
SetStatus(GdipGetSmoothingMode(fNativeGraphics,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.SetSmoothingMode(SmoothingMode: TSmoothingMode): TStatus;
begin
Result := SetStatus(GdipSetSmoothingMode(fNativeGraphics,SmoothingMode));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetPixelOffsetMode: TPixelOffsetMode;
begin
SetStatus(GdipGetPixelOffsetMode(fNativeGraphics,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.SetPixelOffsetMode(PixelOffsetMode: TPixelOffsetMode): TStatus;
begin
Result := SetStatus(GdipSetPixelOffsetMode(fNativeGraphics,PixelOffsetMode));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.SetTransform(Matrix: TMatrix): TStatus;
begin
Result := SetStatus(GdipSetWorldTransform(fNativeGraphics,Matrix.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.ResetTransform: TStatus;
begin
Result := SetStatus(GdipResetWorldTransform(fNativeGraphics));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.MultiplyTransform(Matrix: TMatrix; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipMultiplyWorldTransform(fNativeGraphics,Matrix.NativeObject,Order));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.TranslateTransform(DX,DY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipTranslateWorldTransform(fNativeGraphics,DX,DY,Order));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.ScaleTransform(SX,SY: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipScaleWorldTransform(fNativeGraphics,SX,SY,Order));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.RotateTransform(Angle: REAL; Order: TMatrixOrder = MatrixOrderPrepend): TStatus;
begin
Result := SetStatus(GdipRotateWorldTransform(fNativeGraphics,Angle,Order));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetTransform(Matrix: TMatrix): TStatus;
begin
Result := SetStatus(GdipGetWorldTransform(fNativeGraphics,Matrix.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.SetPageUnit(PageUnit: TUnit): TStatus;
begin
Result := SetStatus(GdipSetPageUnit(fNativeGraphics,PageUnit));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.SetPageScale(Scale: REAL): TStatus;
begin
Result := SetStatus(GdipSetPageScale(fNativeGraphics,Scale));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetPageUnit: TUnit;
begin
SetStatus(GdipGetPageUnit(fNativeGraphics,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetPageScale: REAL;
begin
SetStatus(GdipGetPageScale(fNativeGraphics,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetDpiX: REAL;
begin
SetStatus(GdipGetDpiX(fNativeGraphics,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetDpiY: REAL;
begin
SetStatus(GdipGetDpiY(fNativeGraphics,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.TransformPoints(DestSpace,SrcSpace: TCoordinateSpace; Pts: PPointF; Count: INT): TStatus;
begin
Result := SetStatus(GdipTransformPoints(fNativeGraphics,DestSpace,SrcSpace,PGpPointF(Pts),Count));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.TransformPoints(DestSpace,SrcSpace: TCoordinateSpace; Pts: PPoint; Count: INT): TStatus;
begin
Result := SetStatus(GdipTransformPointsI(fNativeGraphics,DestSpace,SrcSpace,PGpPoint(Pts),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetNearestColor(Color: PColor): TStatus;
var
  Argb: TARGB;
begin
If Assigned(Color) then
  begin
    Result := SetStatus(GdipGetNearestColor(fNativeGraphics,@Argb));
    SetValue(Color^,Argb);
  end
else Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawLine(Pen: TPen; X1,Y1,X2,Y2: REAL): TStatus;
begin
Result := SetStatus(GdipDrawLine(fNativeGraphics,Pen.NativeObject,X1,Y1,X2,Y2));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawLine(Pen: TPen; const Pt1,Pt2: TPointF): TStatus;
begin
Result := DrawLine(Pen,Pt1.X,Pt1.Y,Pt2.X,Pt2.Y);
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawLines(Pen: TPen; Points: PPointF; Count: INT): TStatus;
begin
Result := SetStatus(GdipDrawLines(fNativeGraphics,Pen.NativeObject,PGpPointF(Points),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawLine(Pen: TPen; X1,Y1,X2,Y2: INT): TStatus;
begin
Result := SetStatus(GdipDrawLineI(fNativeGraphics,Pen.NativeObject,X1,Y1,X2,Y2));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawLine(Pen: TPen; const Pt1,Pt2: TPoint): TStatus;
begin
Result := DrawLine(Pen,Pt1.X,Pt1.Y,Pt2.X,Pt2.Y);
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawLines(Pen: TPen; Points: PPoint; Count: INT): TStatus;
begin
Result := SetStatus(GdipDrawLinesI(fNativeGraphics,Pen.NativeObject,PGpPoint(Points),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawArc(Pen: TPen; X,Y,Width,Height,StartAngle,SweepAngle: REAL): TStatus;
begin
Result := SetStatus(GdipDrawArc(fNativeGraphics,Pen.NativeObject,X,Y,Width,Height,StartAngle,SweepAngle));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawArc(Pen: TPen; const Rect: TRectF; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := DrawArc(Pen,Rect.X,Rect.Y,Rect.Width,Rect.Height,StartAngle,SweepAngle);
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawArc(Pen: TPen; X,Y,Width,Height: INT; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := SetStatus(GdipDrawArcI(fNativeGraphics,Pen.NativeObject,X,Y,Width,Height,StartAngle,SweepAngle));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawArc(Pen: TPen; const Rect: TRect; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := DrawArc(Pen,Rect.X,Rect.Y,Rect.Width,Rect.Height,StartAngle,SweepAngle);
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawBezier(Pen: TPen; X1,Y1,X2,Y2,X3,Y3,X4,Y4: REAL): TStatus;
begin
Result := SetStatus(GdipDrawBezier(fNativeGraphics,Pen.NativeObject,X1,Y1,X2,Y2,X3,Y3,X4,Y4));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawBezier(Pen: TPen; const Pt1,Pt2,Pt3,Pt4: TPointF): TStatus;
begin
Result := DrawBezier(Pen,Pt1.X,Pt1.Y,Pt2.X,Pt2.Y,Pt3.X,Pt3.Y,Pt4.X,Pt4.Y);
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawBeziers(Pen: TPen; Points: PPointF; Count: INT): TStatus;
begin
Result := SetStatus(GdipDrawBeziers(fNativeGraphics,Pen.NativeObject,PGpPointF(Points),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawBezier(Pen: TPen; X1,Y1,X2,Y2,X3,Y3,X4,Y4: INT): TStatus;
begin
Result := SetStatus(GdipDrawBezierI(fNativeGraphics,Pen.NativeObject,X1,Y1,X2,Y2,X3,Y3,X4,Y4));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawBezier(Pen: TPen; const Pt1,Pt2,Pt3,Pt4: TPoint): TStatus;
begin
Result := DrawBezier(Pen,Pt1.X,Pt1.Y,Pt2.X,Pt2.Y,Pt3.X,Pt3.Y,Pt4.X,Pt4.Y);
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawBeziers(Pen: TPen; Points: PPoint; Count: INT): TStatus;
begin
Result := SetStatus(GdipDrawBeziersI(fNativeGraphics,Pen.NativeObject,PGpPoint(Points),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawRectangle(Pen: TPen; const Rect: TRectF): TStatus;
begin
Result := DrawRectangle(PEn,Rect.X,Rect.Y,Rect.Width,Rect.Height);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawRectangle(Pen: TPen; X,Y,Width,Height: REAL): TStatus;
begin
Result := SetStatus(GdipDrawRectangle(fNativeGraphics,Pen.NativeObject,X,Y,Width,Height));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawRectangles(Pen: TPen; Rects: PRectF; Count: INT): TStatus;
begin
Result := SetStatus(GdipDrawRectangles(fNativeGraphics,Pen.NativeObject,PGpRectF(Rects),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawRectangle(Pen: TPen; const Rect: TRect): TStatus;
begin
Result := DrawRectangle(PEn,Rect.X,Rect.Y,Rect.Width,Rect.Height);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawRectangle(Pen: TPen; X,Y,Width,Height: INT): TStatus;
begin
Result := SetStatus(GdipDrawRectangleI(fNativeGraphics,Pen.NativeObject,X,Y,Width,Height));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawRectangles(Pen: TPen; Rects: PRect; Count: INT): TStatus;
begin
Result := SetStatus(GdipDrawRectanglesI(fNativeGraphics,Pen.NativeObject,PGpRect(Rects),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawEllipse(Pen: TPen; const Rect: TRectF): TStatus;
begin
Result := DrawEllipse(Pen,Rect.X,Rect.Y,Rect.Width,Rect.Height);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawEllipse(Pen: TPen; X,Y,Width,Height: REAL): TStatus;
begin
Result := SetStatus(GdipDrawEllipse(fNativeGraphics,Pen.NativeObject,X,Y,Width,Height));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawEllipse(Pen: TPen; const Rect: TRect): TStatus;
begin
Result := DrawEllipse(Pen,Rect.X,Rect.Y,Rect.Width,Rect.Height);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawEllipse(Pen: TPen; X,Y,Width,Height: INT): TStatus;
begin
Result := SetStatus(GdipDrawEllipseI(fNativeGraphics,Pen.NativeObject,X,Y,Width,Height));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawPie(Pen: TPen; const Rect: TRectF; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := DrawPie(Pen,Rect.X,Rect.Y,Rect.Width,Rect.Height,StartAngle,SweepAngle);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawPie(Pen: TPen; X,Y,Width,Height,StartAngle,SweepAngle: REAL): TStatus;
begin
Result := SetStatus(GdipDrawPie(fNativeGraphics,Pen.NativeObject,X,Y,Width,Height,StartAngle,SweepAngle));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawPie(Pen: TPen; const Rect: TRect; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := DrawPie(Pen,Rect.X,Rect.Y,Rect.Width,Rect.Height,StartAngle,SweepAngle);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawPie(Pen: TPen; X,Y,Width,Height: INT; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := SetStatus(GdipDrawPieI(fNativeGraphics,Pen.NativeObject,X,Y,Width,Height,StartAngle,SweepAngle));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawPolygon(Pen: TPen; Points: PPointF; Count: INT): TStatus;
begin
Result := SetStatus(GdipDrawPolygon(fNativeGraphics,Pen.NativeObject,PGpPointF(Points),Count));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawPolygon(Pen: TPen; Points: PPoint; Count: INT): TStatus;
begin
Result := SetStatus(GdipDrawPolygonI(fNativeGraphics,Pen.NativeObject,PGpPoint(Points),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawPath(Pen: TPen; Path: TGraphicsPath): TStatus;
begin
Result := SetStatus(GdipDrawPath(fNativeGraphics,Pen.NativeObject,Path.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawCurve(Pen: TPen; Points: PPointF; Count: INT): TStatus;
begin
Result := SetStatus(GdipDrawCurve(fNativeGraphics,Pen.NativeObject,PGpPointF(Points),Count));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawCurve(Pen: TPen; Points: PPointF; Count: INT; Tension: REAL): TStatus;
begin
Result := SetStatus(GdipDrawCurve2(fNativeGraphics,Pen.NativeObject,PGpPointF(Points),Count,Tension));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawCurve(Pen: TPen; Points: PPointF; Count,Offset,NumberOfSegments: INT; Tension: REAL = 0.5): TStatus;
begin
Result := SetStatus(GdipDrawCurve3(fNativeGraphics,Pen.NativeObject,PGpPointF(Points),Count,Offset,NumberOfSegments,Tension));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawCurve(Pen: TPen; Points: PPoint; Count: INT): TStatus;
begin
Result := SetStatus(GdipDrawCurveI(fNativeGraphics,Pen.NativeObject,PGpPoint(Points),Count));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawCurve(Pen: TPen; Points: PPoint; Count: INT; Tension: REAL): TStatus;
begin
Result := SetStatus(GdipDrawCurve2I(fNativeGraphics,Pen.NativeObject,PGpPoint(Points),Count,Tension));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawCurve(Pen: TPen; Points: PPoint; Count,Offset,NumberOfSegments: INT; Tension: REAL = 0.5): TStatus;
begin
Result := SetStatus(GdipDrawCurve3I(fNativeGraphics,Pen.NativeObject,PGpPoint(Points),Count,Offset,NumberOfSegments,Tension));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawClosedCurve(Pen: TPen; Points: PPointF; Count: INT): TStatus;
begin
Result := SetStatus(GdipDrawClosedCurve(fNativeGraphics,Pen.NativeObject,PGpPointF(Points),Count));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawClosedCurve(Pen: TPen; Points: PPointF; Count: INT; Tension: REAL): TStatus;
begin
Result := SetStatus(GdipDrawClosedCurve2(fNativeGraphics,Pen.NativeObject,PGpPointF(Points),Count,Tension));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawClosedCurve(Pen: TPen; Points: PPoint; Count: INT): TStatus;
begin
Result := SetStatus(GdipDrawClosedCurveI(fNativeGraphics,Pen.NativeObject,PGpPoint(Points),Count));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawClosedCurve(Pen: TPen; Points: PPoint; Count: INT; Tension: REAL): TStatus;
begin
Result := SetStatus(GdipDrawClosedCurve2I(fNativeGraphics,Pen.NativeObject,PGpPoint(Points),Count,Tension));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.Clear(const Color: TColor): TStatus;
begin
Result := SetStatus(GdipGraphicsClear(fNativeGraphics,GetValue(Color)));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.FillRectangle(Brush: TBrush; const Rect: TRectF): TStatus;
begin
Result := FillRectangle(Brush,Rect.X,Rect.Y,Rect.Width,Rect.Height);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.FillRectangle(Brush: TBrush; X,Y,Width,Height: REAL): TStatus;
begin
Result := SetStatus(GdipFillRectangle(fNativeGraphics,Brush.NativeObject,X,Y,Width,Height));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.FillRectangles(Brush: TBrush; Rects: PRectF; Count: INT): TStatus;
begin
Result := SetStatus(GdipFillRectangles(fNativeGraphics,Brush.NativeObject,PGpRectF(Rects),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.FillRectangle(Brush: TBrush; const Rect: TRect): TStatus;
begin
Result := FillRectangle(Brush,Rect.X,Rect.Y,Rect.Width,Rect.Height);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.FillRectangle(Brush: TBrush; X,Y,Width,Height: INT): TStatus;
begin
Result := SetStatus(GdipFillRectangleI(fNativeGraphics,Brush.NativeObject,X,Y,Width,Height));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.FillRectangles(Brush: TBrush; Rects: PRect; Count: INT): TStatus;
begin
Result := SetStatus(GdipFillRectanglesI(fNativeGraphics,Brush.NativeObject,PGpRect(Rects),Count));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.FillPolygon(Brush: TBrush; Points: PPointF; Count: INT): TStatus;
begin
Result := FillPolygon(Brush,Points,Count,FillModeAlternate);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.FillPolygon(Brush: TBrush; Points: PPointF; Count: INT; FillMode: TFillMode): TStatus;
begin
Result := SetStatus(GdipFillPolygon(fNativeGraphics,Brush.NativeObject,PGpPointF(Points),Count,FillMode));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.FillPolygon(Brush: TBrush; Points: PPoint; Count: INT): TStatus;
begin
Result := FillPolygon(Brush,Points,Count,FillModeAlternate);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.FillPolygon(Brush: TBrush; Points: PPoint; Count: INT; FillMode: TFillMode): TStatus;
begin
Result := SetStatus(GdipFillPolygonI(fNativeGraphics,Brush.NativeObject,PGpPoint(Points),Count,FillMode));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.FillEllipse(Brush: TBrush; const Rect: TRectF): TStatus;
begin
Result := FillEllipse(Brush,Rect.X,Rect.Y,Rect.Width,Rect.Height);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.FillEllipse(Brush: TBrush; X,Y,Width,Height: REAL): TStatus;
begin
Result := SetStatus(GdipFillEllipse(fNativeGraphics,Brush.NativeObject,X,Y,Width,Height));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.FillEllipse(Brush: TBrush; const Rect: TRect): TStatus;
begin
Result := FillEllipse(Brush,Rect.X,Rect.Y,Rect.Width,Rect.Height);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.FillEllipse(Brush: TBrush; X,Y,Width,Height: INT): TStatus;
begin
Result := SetStatus(GdipFillEllipseI(fNativeGraphics,Brush.NativeObject,X,Y,Width,Height));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.FillPie(Brush: TBrush; const Rect: TRectF; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := FillPie(Brush,Rect.X,Rect.Y,Rect.Width,Rect.Height,StartAngle,SweepAngle);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.FillPie(Brush: TBrush; X,Y,Width,Height,StartAngle,SweepAngle: REAL): TStatus;
begin
Result := SetStatus(GdipFillPie(fNativeGraphics,Brush.NativeObject,X,Y,Width,Height,StartAngle,SweepAngle));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.FillPie(Brush: TBrush; const Rect: TRect; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := FillPie(Brush,Rect.X,Rect.Y,Rect.Width,Rect.Height,StartAngle,SweepAngle);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.FillPie(Brush: TBrush; X,Y,Width,Height: INT; StartAngle,SweepAngle: REAL): TStatus;
begin
Result := SetStatus(GdipFillPieI(fNativeGraphics,Brush.NativeObject,X,Y,Width,Height,StartAngle,SweepAngle));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.FillPath(Brush: TBrush; Path: TGraphicsPath): TStatus;
begin
Result := SetStatus(GdipFillPath(fNativeGraphics,Brush.NativeObject,Path.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.FillClosedCurve(Brush: TBrush; Points: PPointF; Count: INT): TStatus;
begin
Result := SetStatus(GdipFillClosedCurve(fNativeGraphics,Brush.NativeObject,PGpPointF(Points),Count));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.FillClosedCurve(Brush: TBrush; Points: PPointF; Count: INT; FillMode: TFillMode; Tension: REAL = 0.5): TStatus;
begin
Result := SetStatus(GdipFillClosedCurve2(fNativeGraphics,Brush.NativeObject,PGpPointF(Points),Count,Tension,FillMode));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.FillClosedCurve(Brush: TBrush; Points: PPoint; Count: INT): TStatus;
begin
Result := SetStatus(GdipFillClosedCurveI(fNativeGraphics,Brush.NativeObject,PGpPoint(Points),Count));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.FillClosedCurve(Brush: TBrush; Points: PPoint; Count: INT; FillMode: TFillMode; Tension: REAL = 0.5): TStatus;
begin
Result := SetStatus(GdipFillClosedCurve2I(fNativeGraphics,Brush.NativeObject,PGpPoint(Points),Count,Tension,FillMode));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.FillRegion(Brush: TBrush; Region: TRegion): TStatus;
begin
Result := SetStatus(GdipFillRegion(fNativeGraphics,Brush.NativeObject,Region.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawString(Str: PWideChar; Length: INT; Font: TFont; const LayoutRect: TRectF; StringFormat: TStringFormat;
  Brush: TBrush): TStatus;
begin
Result := SetStatus(GdipDrawString(fNativeGraphics,Str,Length,Font.NativeObject,@LayoutRect,StringFormat.NativeObject,Brush.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawString(const Str: String; Length: INT; Font: TFont; const LayoutRect: TRectF; StringFormat: TStringFormat;
  Brush: TBrush): TStatus;
begin
Result := DrawString(PWideChar(StrToWide(Str)),Length,Font,LayoutRect,StringFormat,Brush);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawString(Str: PWideChar; Length: INT; Font: TFont; const Origin: TPointF;Brush: TBrush): TStatus;
var
  LayoutRect: TRectF;
begin
LayoutRect := RectF(Origin.X,Origin.Y,0.0,0.0);
Result := SetStatus(GdipDrawString(fNativeGraphics,Str,Length,Font.NativeObject,@LayoutRect,nil,Brush.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawString(const Str: String; Length: INT; Font: TFont; const Origin: TPointF; Brush: TBrush): TStatus;
begin
Result := DrawString(PWideChar(StrToWide(Str)),Length,Font,Origin,Brush);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawString(Str: PWideChar; Length: INT; Font: TFont; const Origin: TPointF; StringFormat: TStringFormat;
  Brush: TBrush): TStatus;
var
  LayoutRect: TRectF;
begin
LayoutRect := RectF(Origin.X,Origin.Y,0.0,0.0);
Result := SetStatus(GdipDrawString(fNativeGraphics,Str,Length,Font.NativeObject,@LayoutRect,StringFormat.NativeObject,Brush.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawString(const Str: String; Length: INT; Font: TFont; const Origin: TPointF; StringFormat: TStringFormat;
  Brush: TBrush): TStatus;
begin
Result := DrawString(PWideChar(StrToWide(Str)),Length,Font,Origin,StringFormat,Brush);
end;

//!!----------------------------------------------------------------------------

Function TGraphics.MeasureString(Str: PWideChar; Length: INT; Font: TFont; const LayoutRect: TRectF; StringFormat: TStringFormat;
  BoundingBox: PRectF; CodepointsFitted: PINT = nil; LinesFilled: PINT = nil): TStatus;
begin
Result := SetStatus(GdipMeasureString(fNativeGraphics,Str,Length,Font.NativeObject,@LayoutRect,
  StringFormat.NativeObject,BoundingBox,CodepointsFitted,LinesFilled));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.MeasureString(const Str: String; Length: INT; Font: TFont; const LayoutRect: TRectF; StringFormat: TStringFormat;
  BoundingBox: PRectF; CodepointsFitted: PINT = nil; LinesFilled: PINT = nil): TStatus;
begin
Result := MeasureString(PwideChar(StrToWide(Str)),Length,Font,LayoutRect,StringFormat,BoundingBox,CodepointsFitted,LinesFilled);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.MeasureString(Str: PWideChar; Length: INT; Font: TFont; const LayoutRectSize: TSizeF; StringFormat: TStringFormat;
  Size: PSizeF; CodepointsFitted: PINT = nil; LinesFilled: PINT = nil): TStatus;
var
  LayoutRect:     TRectF;
  BoundingBox:    TRectF;
  BoundingBoxPtr: PRectF;
begin
If Assigned(Size) then
  begin
    LayoutRect := RectF(0,0,LayoutRectSize.Width,LayoutRectSize.Height);
  {!!
    Following code seems to be superfluous, because the Size argument was
    already checked, but it is this way in the orginal source, so...

    ...or I have misunderstood the original. Also a posibility.
  }
    If Assigned(Size) then
      BoundingBoxPtr := @BoundingBox
    else
      BoundingBoxPtr := nil;
    Result := SetStatus(GdipMeasureString(fNativeGraphics,Str,Length,Font.NativeObject,@LayoutRect,
      StringFormat.NativeObject,BoundingBoxPtr,CodepointsFitted,LinesFilled));
    If Assigned(Size) and (Result = Ok) then
      begin
        Size^.Width := BoundingBox.Width;
        Size^.Height := BoundingBox.Height;
      end;
  end
else Result := SetStatus(InvalidParameter);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.MeasureString(const Str: String; Length: INT; Font: TFont; const LayoutRectSize: TSizeF; StringFormat: TStringFormat;
  Size: PSizeF; CodepointsFitted: PINT = nil; LinesFilled: PINT = nil): TStatus;
begin
Result := MeasureString(PwideChar(StrToWide(Str)),Length,Font,LayoutRectSize,StringFormat,Size,CodepointsFitted,LinesFilled);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.MeasureString(Str: PWideChar; Length: INT; Font: TFont; const Origin: TPointF; StringFormat: TStringFormat;
  BoundingBox: PRectF): TStatus;
var
  LayoutRect: TRectF;
begin
LayoutRect := RectF(Origin.X,Origin.Y,0.0,0.0);
Result := SetStatus(GdipMeasureString(fNativeGraphics,Str,Length,Font.NativeObject,@LayoutRect,StringFormat.NativeObject,BoundingBox,nil,nil));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.MeasureString(const Str: String; Length: INT; Font: TFont; const Origin: TPointF; StringFormat: TStringFormat;
  BoundingBox: PRectF): TStatus;
begin
Result := MeasureString(PwideChar(StrToWide(Str)),Length,Font,Origin,StringFormat,BoundingBox);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.MeasureString(Str: PWideChar; Length: INT; Font: TFont; const LayoutRect: TRectF; BoundingBox: PRectF): TStatus;
begin
Result := SetStatus(GdipMeasureString(fNativeGraphics,Str,Length,Font.NativeObject,@LayoutRect,nil,BoundingBox,nil,nil));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.MeasureString(const Str: String; Length: INT; Font: TFont; const LayoutRect: TRectF; BoundingBox: PRectF): TStatus;
begin
Result := MeasureString(PwideChar(StrToWide(Str)),Length,Font,LayoutRect,BoundingBox);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.MeasureString(Str: PWideChar; Length: INT; Font: TFont; const Origin: TPointF; BoundingBox: PRectF): TStatus;
var
  LayoutRect: TRectF;
begin
LayoutRect := RectF(Origin.X,Origin.Y,0.0,0.0);
Result := SetStatus(GdipMeasureString(fNativeGraphics,Str,Length,Font.NativeObject,@LayoutRect,nil,BoundingBox,nil,nil));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.MeasureString(const Str: String; Length: INT; Font: TFont; const Origin: TPointF; BoundingBox: PRectF): TStatus;
begin
Result := MeasureString(PwideChar(StrToWide(Str)),Length,Font,Origin,BoundingBox);
end;

//!!----------------------------------------------------------------------------

Function TGraphics.MeasureCharacterRanges(Str: PWideChar; Length: INT; Font: TFont; const LayoutRect: TRectF; StringFormat: TStringFormat;
  RegionCount: INT; Regions: PRegion): TStatus;
var
  NativeRegions:  array of PGpRegion;
  i:              Integer;
begin
If Assigned(Regions) and (RegionCount > 0) then
  begin
    SetLength(NativeRegions,RegionCount);
    If System.Length(NativeRegions) > 0 then  //!! conflict with Length argument
      begin
        For i := 0 to Pred(RegionCount) do
          NativeRegions[i] := PRegionArray(Regions)^[i].NativeObject;
        Result := SetStatus(GdipMeasureCharacterRanges(fNativeGraphics,Str,Length,Font.NativeObject,@LayoutRect,
          StringFormat.NativeObject,RegionCount,Pointer(NativeRegions)));
        SetLength(NativeRegions,0);
      end
    else Result := OutOfMemory;
  end
else Result := InvalidParameter;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.MeasureCharacterRanges(const Str: String; Length: INT; Font: TFont; const LayoutRect: TRectF; StringFormat: TStringFormat;
  RegionCount: INT; Regions: PRegion): TStatus; 
begin
Result := MeasureCharacterRanges(PWideChar(StrToWide(Str)),Length,Font,LayoutRect,StringFormat,RegionCount,Regions);
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawDriverString(Text: PUINT16; Length: INT; Font: TFont; Brush: TBrush; Positions: PPointF;
  Flags: INT; Matrix: TMatrix): TStatus;
begin
Result := SetStatus(GdipDrawDriverString(fNativeGraphics,Text,Length,Font.NativeObject,
  Brush.NativeObject,Positions,Flags,Matrix.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.MeasureDriverString(Text: PUINT16; Length: INT; Font: TFont; Positions: PPointF; Flags: INT;
  Matrix: TMatrix; BoundingBox: PRectF): TStatus;
begin
Result := SetStatus(GdipMeasureDriverString(fNativeGraphics,Text,Length,Font.NativeObject,
  Positions,Flags,Matrix.NativeObject,BoundingBox));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawCachedBitmap(CB: TCachedBitmap; X,Y: INT): TStatus;
begin
Result := SetStatus(GdipDrawCachedBitmap(fNativeGraphics,CB.NativeObject,X,Y));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.DrawImage(Image: TImage; const Point: TPointF): TStatus;
begin
Result := DrawImage(Image,Point.X,Point.Y);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; X,Y: REAL): TStatus;
begin
Result := SetStatus(GdipDrawImage(fNativeGraphics,Image.NativeObject,X,Y))
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; const Rect: TRectF): TStatus;
begin
Result := DrawImage(Image,Rect.X,Rect.Y,Rect.Width,Rect.Height);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; X,Y,Width,Height: REAL): TStatus;
begin
Result := SetStatus(GdipDrawImageRect(fNativeGraphics,Image.NativeObject,X,Y,Width,Height))
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; const Point: TPoint): TStatus;
begin
Result := DrawImage(Image,Point.X,Point.Y);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; X,Y: INT): TStatus;
begin
Result := SetStatus(GdipDrawImageI(fNativeGraphics,Image.NativeObject,X,Y))
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; const Rect: TRect): TStatus;
begin
Result := DrawImage(Image,Rect.X,Rect.Y,Rect.Width,Rect.Height);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; X,Y,Width,Height: INT): TStatus;
begin
Result := SetStatus(GdipDrawImageRectI(fNativeGraphics,Image.NativeObject,X,Y,Width,Height))
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; DestPoints: PPointF; Count: INT): TStatus;
begin
If Count in [3,4] then
  Result := SetStatus(GdipDrawImagePoints(fNativeGraphics,Image.NativeObject,PGpPointF(DestPoints),Count))
else
  Result := SetStatus(InvalidParameter);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; DestPoints: PPoint; Count: INT): TStatus;
begin
If Count in [3,4] then
  Result := SetStatus(GdipDrawImagePointsI(fNativeGraphics,Image.NativeObject,PGpPoint(DestPoints),Count))
else
  Result := SetStatus(InvalidParameter);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; X,Y,SrcX,SrcY,SrcWidth,SrcHeight: REAL; SrcUnit: TUnit): TStatus;
begin
Result := SetStatus(GdipDrawImagePointRect(fNativeGraphics,Image.NativeObject,X,Y,SrcX,SrcY,SrcWidth,SrcHeight,SrcUnit))
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; const DestRect: TRectF; SrcX,SrcY,SrcWidth,SrcHeight: REAL; SrcUnit: TUnit;
  ImageAttributes: TImageAttributes = nil; Callback: TDrawImageAbort = nil; CallbackData: Pointer = nil): TStatus;
begin
Result := SetStatus(GdipDrawImageRectRect(fNativeGraphics,Image.NativeObject,DestRect.X,DestRect.Y,DestRect.Width,DestRect.Height,
  SrcX,SrcY,SrcWidth,SrcHeight,SrcUnit,ImageAttributes.NativeObject,Callback,CallbackData));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; DestPoints: PPointF; Count: INT; SrcX,SrcY,SrcWidth,SrcHeight: REAL; SrcUnit: TUnit;
  ImageAttributes: TImageAttributes = nil; Callback: TDrawImageAbort = nil; CallbackData: Pointer = nil): TStatus;
begin
Result := SetStatus(GdipDrawImagePointsRect(fNativeGraphics,Image.NativeObject,PGpPointF(DestPoints),Count,
  SrcX,SrcY,SrcWidth,SrcHeight,SrcUnit,ImageAttributes.NativeObject,Callback,CallbackData));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; X,Y,SrcX,SrcY,SrcWidth,SrcHeight: INT; SrcUnit: TUnit): TStatus;
begin
Result := SetStatus(GdipDrawImagePointRectI(fNativeGraphics,Image.NativeObject,X,Y,SrcX,SrcY,SrcWidth,SrcHeight,SrcUnit))
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; const DestRect: TRect; SrcX,SrcY,SrcWidth,SrcHeight: INT; SrcUnit: TUnit;
  ImageAttributes: TImageAttributes = nil; Callback: TDrawImageAbort = nil; CallbackData: Pointer = nil): TStatus;
begin
Result := SetStatus(GdipDrawImageRectRectI(fNativeGraphics,Image.NativeObject,DestRect.X,DestRect.Y,DestRect.Width,DestRect.Height,
  SrcX,SrcY,SrcWidth,SrcHeight,SrcUnit,ImageAttributes.NativeObject,Callback,CallbackData));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; DestPoints: PPoint; Count: INT; SrcX,SrcY,SrcWidth,SrcHeight: INT; SrcUnit: TUnit;
  ImageAttributes: TImageAttributes = nil; Callback: TDrawImageAbort = nil; CallbackData: Pointer = nil): TStatus;
begin
Result := SetStatus(GdipDrawImagePointsRectI(fNativeGraphics,Image.NativeObject,PGpPoint(DestPoints),Count,
  SrcX,SrcY,SrcWidth,SrcHeight,SrcUnit,ImageAttributes.NativeObject,Callback,CallbackData));
end;

{$IF GDIPVER >= $0110}
//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; const DestRect,SourceRect: TRectF; SrcUnit: TUnit;
  ImageAttributes: TImageAttributes = nil): TStatus;
begin
Result := SetStatus(GdipDrawImageRectRect(fNativeGraphics,Image.NativeObject,DestRect.X,DestRect.Y,DestRect.Width,DestRect.Height,
  SourceRect.X,SourceRect.Y,SourceRect.Width,SourceRect.Height,SrcUnit,ImageAttributes.NativeObject,nil,nil))
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.DrawImage(Image: TImage; const SourceRect: TRectF; XForm: TMatrix; Effect: TEffect;
  ImageAttributes: TImageAttributes; SrcUnit: TUnit): TStatus;
begin
Result := SetStatus(GdipDrawImageFX(fNativeGraphics,Image.NativeObject,@SourceRect,XForm.NativeObject,
  Effect.NativeObject,ImageAttributes.NativeObject,SrcUnit));
end;

{$IFEND}
//!!----------------------------------------------------------------------------

Function TGraphics.EnumerateMetafile(MetaFile: TMetafile; const DestPoint: TPointF; Callback: TEnumerateMetafileProc;
  CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus;
begin
Result := SetStatus(GdipEnumerateMetafileDestPoint(fNativeGraphics,MetaFile.NativeObject,
  @DestPoint,Callback,CallbackData,ImageAttributes.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.EnumerateMetafile(MetaFile: TMetafile; const DestPoint: TPoint; Callback: TEnumerateMetafileProc;
  CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus;
begin
Result := SetStatus(GdipEnumerateMetafileDestPointI(fNativeGraphics,MetaFile.NativeObject,
  @DestPoint,Callback,CallbackData,ImageAttributes.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.EnumerateMetafile(MetaFile: TMetafile; const DestRect: TRectF; Callback: TEnumerateMetafileProc;
  CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus;
begin
Result := SetStatus(GdipEnumerateMetafileDestRect(fNativeGraphics,MetaFile.NativeObject,
  @DestRect,Callback,CallbackData,ImageAttributes.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.EnumerateMetafile(MetaFile: TMetafile; const DestRect: TRect; Callback: TEnumerateMetafileProc;
  CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus;
begin
Result := SetStatus(GdipEnumerateMetafileDestRectI(fNativeGraphics,MetaFile.NativeObject,
  @DestRect,Callback,CallbackData,ImageAttributes.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.EnumerateMetafile(MetaFile: TMetafile; DestPoints: PPointF; Count: INT; Callback: TEnumerateMetafileProc;
  CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus;
begin
Result := SetStatus(GdipEnumerateMetafileDestPoints(fNativeGraphics,MetaFile.NativeObject,
  DestPoints,Count,Callback,CallbackData,ImageAttributes.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.EnumerateMetafile(MetaFile: TMetafile; DestPoints: PPoint; Count: INT; Callback: TEnumerateMetafileProc;
  CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus;
begin
Result := SetStatus(GdipEnumerateMetafileDestPointsI(fNativeGraphics,MetaFile.NativeObject,
  DestPoints,Count,Callback,CallbackData,ImageAttributes.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.EnumerateMetafile(MetaFile: TMetafile; const DestPoint: TPointF; const SrcRect: TRectF; SrcUnit: TUnit;
  Callback: TEnumerateMetafileProc; CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus;
begin
Result := SetStatus(GdipEnumerateMetafileSrcRectDestPoint(fNativeGraphics,MetaFile.NativeObject,
  @DestPoint,@SrcRect,SrcUnit,Callback,CallbackData,ImageAttributes.NativeObject));
end;
  
//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.EnumerateMetafile(MetaFile: TMetafile; const DestPoint: TPoint; const SrcRect: TRect; SrcUnit: TUnit;
  Callback: TEnumerateMetafileProc; CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus;
begin
Result := SetStatus(GdipEnumerateMetafileSrcRectDestPointI(fNativeGraphics,MetaFile.NativeObject,
  @DestPoint,@SrcRect,SrcUnit,Callback,CallbackData,ImageAttributes.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.EnumerateMetafile(MetaFile: TMetafile; const DestRect,SrcRect: TRectF; SrcUnit: TUnit;
  Callback: TEnumerateMetafileProc; CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus;
begin
Result := SetStatus(GdipEnumerateMetafileSrcRectDestRect(fNativeGraphics,MetaFile.NativeObject,
  @DestRect,@SrcRect,SrcUnit,Callback,CallbackData,ImageAttributes.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.EnumerateMetafile(MetaFile: TMetafile; const DestRect,SrcRect: TRect; SrcUnit: TUnit;
  Callback: TEnumerateMetafileProc; CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus;
begin
Result := SetStatus(GdipEnumerateMetafileSrcRectDestRectI(fNativeGraphics,MetaFile.NativeObject,
  @DestRect,@SrcRect,SrcUnit,Callback,CallbackData,ImageAttributes.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.EnumerateMetafile(MetaFile: TMetafile; DestPoints: PPointF; Count: INT; const SrcRect: TRectF; SrcUnit: TUnit;
  Callback: TEnumerateMetafileProc; CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus;
begin
Result := SetStatus(GdipEnumerateMetafileSrcRectDestPoints(fNativeGraphics,MetaFile.NativeObject,
  DestPoints,Count,@SrcRect,SrcUnit,Callback,CallbackData,ImageAttributes.NativeObject));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.EnumerateMetafile(MetaFile: TMetafile; DestPoints: PPoint; Count: INT; const SrcRect: TRect; SrcUnit: TUnit;
  Callback: TEnumerateMetafileProc; CallbackData: Pointer = nil; ImageAttributes: TImageAttributes = nil): TStatus;
begin
Result := SetStatus(GdipEnumerateMetafileSrcRectDestPointsI(fNativeGraphics,MetaFile.NativeObject,
  DestPoints,Count,@SrcRect,SrcUnit,Callback,CallbackData,ImageAttributes.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.SetClip(G: TGraphics; CombineMode: TCombineMode = CombineModeReplace): TStatus;
begin
Result := SetStatus(GdipSetClipGraphics(fNativeGraphics,G.NativeObject,CombineMode));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.SetClip(const Rect: TRectF; CombineMode: TCombineMode = CombineModeReplace): TStatus;
begin
Result := SetStatus(GdipSetClipRect(fNativeGraphics,Rect.X,Rect.Y,Rect.Width,Rect.Height,CombineMode));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.SetClip(const Rect: TRect; CombineMode: TCombineMode = CombineModeReplace): TStatus;
begin
Result := SetStatus(GdipSetClipRectI(fNativeGraphics,Rect.X,Rect.Y,Rect.Width,Rect.Height,CombineMode));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.SetClip(Path: TGraphicsPath; CombineMode: TCombineMode = CombineModeReplace): TStatus;
begin
Result := SetStatus(GdipSetClipPath(fNativeGraphics,Path.NativeObject,CombineMode));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.SetClip(Region: TRegion; CombineMode: TCombineMode = CombineModeReplace): TStatus;
begin
Result := SetStatus(GdipSetClipRegion(fNativeGraphics,Region.NativeObject,CombineMode));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.SetClip(HRgn: HRGN; CombineMode: TCombineMode = CombineModeReplace): TStatus;
begin
Result := SetStatus(GdipSetClipHrgn(fNativeGraphics,HRgn,CombineMode));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.IntersectClip(const Rect: TRectF): TStatus;
begin
Result := SetStatus(GdipSetClipRect(fNativeGraphics,Rect.X,Rect.Y,Rect.Width,Rect.Height,CombineModeIntersect));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.IntersectClip(const Rect: TRect): TStatus;
begin
Result := SetStatus(GdipSetClipRectI(fNativeGraphics,Rect.X,Rect.Y,Rect.Width,Rect.Height,CombineModeIntersect));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.IntersectClip(Region: TRegion): TStatus;
begin
Result := SetStatus(GdipSetClipRegion(fNativeGraphics,Region.NativeObject,CombineModeIntersect));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.ExcludeClip(const Rect: TRectF): TStatus;
begin
Result := SetStatus(GdipSetClipRect(fNativeGraphics,Rect.X,Rect.Y,Rect.Width,Rect.Height,CombineModeExclude));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.ExcludeClip(const Rect: TRect): TStatus;
begin
Result := SetStatus(GdipSetClipRectI(fNativeGraphics,Rect.X,Rect.Y,Rect.Width,Rect.Height,CombineModeExclude));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.ExcludeClip(Region: TRegion): TStatus;
begin
Result := SetStatus(GdipSetClipRegion(fNativeGraphics,Region.NativeObject,CombineModeExclude));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.ResetClip: TStatus;
begin
Result := SetStatus(GdipResetClip(fNativeGraphics));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.TranslateClip(DX,DY: REAL): TStatus;
begin
Result := SetStatus(GdipTranslateClip(fNativeGraphics,DX,DY));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.TranslateClip(DX,DY: INT): TStatus;
begin
Result := SetStatus(GdipTranslateClipI(fNativeGraphics,DX,DY));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetClip(Region: TRegion): TStatus;
begin
Result := SetStatus(GdipGetClip(fNativeGraphics,Region.NativeObject));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetClipBounds(Rect: PRectF): TStatus;
begin
Result := SetStatus(GdipGetClipBounds(fNativeGraphics,PGpRectF(Rect)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.GetClipBounds(Rect: PRect): TStatus;
begin
Result := SetStatus(GdipGetClipBoundsI(fNativeGraphics,PGpRect(Rect)));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.IsClipEmpty: BOOL;
begin
SetStatus(GdipIsClipEmpty(fNativeGraphics,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetVisibleClipBounds(Rect: PRectF): TStatus;
begin
Result := SetStatus(GdipGetVisibleClipBounds(fNativeGraphics,PGpRectF(Rect)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.GetVisibleClipBounds(Rect: PRect): TStatus;
begin
Result := SetStatus(GdipGetVisibleClipBoundsI(fNativeGraphics,PGpRect(Rect)));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.IsVisibleClipEmpty: BOOL;
begin
SetStatus(GdipIsVisibleClipEmpty(fNativeGraphics,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.IsVisible(X,Y: INT): BOOL;
begin
Result := IsVisible(Point(X,Y));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.IsVisible(const Point: TPoint): BOOL;
begin
SetStatus(GdipIsVisiblePointI(fNativeGraphics,Point.X,Point.Y,@Result));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.IsVisible(X,Y,Width,Height: INT): BOOL;
begin
Result := IsVisible(Rect(X,Y,Width,Height));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.IsVisible(const Rect: TRect): BOOL;
begin
SetStatus(GdipIsVisibleRectI(fNativeGraphics,Rect.X,Rect.Y,Rect.Width,Rect.Height,@Result));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.IsVisible(X,Y: REAL): BOOL;
begin
Result := IsVisible(PointF(X,Y));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.IsVisible(const Point: TPointF): BOOL;
begin
SetStatus(GdipIsVisiblePoint(fNativeGraphics,Point.X,Point.Y,@Result));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.IsVisible(X,Y,Width,Height: REAL): BOOL;
begin
Result := IsVisible(RectF(X,Y,Width,Height));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.IsVisible(const Rect: TRectF): BOOL;
begin
SetStatus(GdipIsVisibleRect(fNativeGraphics,Rect.X,Rect.Y,Rect.Width,Rect.Height,@Result));
end;
//!!----------------------------------------------------------------------------

Function TGraphics.Save: TGraphicsState;
begin
SetStatus(GdipSaveGraphics(fNativeGraphics,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.Restore(GState: TGraphicsState): TStatus;
begin
Result := SetStatus(GdipRestoreGraphics(fNativeGraphics,GState));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.BeginContainer(const DstRect,SrcRect: TRectF; aUnit: TUnit): TGraphicsContainer;
begin
SetStatus(GdipBeginContainer(fNativeGraphics,@DstRect,@SrcRect,aUnit,@Result));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.BeginContainer(const DstRect,SrcRect: TRect; aUnit: TUnit): TGraphicsContainer;
begin
SetStatus(GdipBeginContainerI(fNativeGraphics,@DstRect,@SrcRect,aUnit,@Result));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TGraphics.BeginContainer: TGraphicsContainer;
begin
SetStatus(GdipBeginContainer2(fNativeGraphics,@Result));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.EndContainer(State: TGraphicsContainer): TStatus;
begin
Result := SetStatus(GdipEndContainer(fNativeGraphics,State));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.AddMetafileComment(Data: PBYTE; SizeData: UINT): TStatus;
begin
Result := SetStatus(GdipComment(fNativeGraphics,SizeData,Data));
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetHalftonePalette: HPALETTE;
begin
Result := GdipCreateHalftonePalette;
end;

//!!----------------------------------------------------------------------------

Function TGraphics.GetLastStatus: TStatus;
begin
Result := fLastResult;
fLastResult := Ok;
end;

end.
