(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusFlat.h
*
* Abstract:
*
*   Private GDI+ header file.
*
\**************************************************************************)
unit gdiplusflat;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows, ActiveX{!! for IStream},
  AuxTypes,
  gdiplus_common, gdiplusenums, gdiplustypes, gdipluspixelformats,
  gdiplusgpstubs, gdipluscolor, gdiplusimaging, gdipluseffects,
  gdipluscolormatrix, gdiplusmetaheader;

//----------------------------------------------------------------------------
// GraphicsPath APIs
//----------------------------------------------------------------------------

Function GdipCreatePath(brushMode: TGpFillMode; path: PPGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreatePath2(points: PGpPointF; types: PByte; count: INT; fillMode: TGpFillMode; path: PPGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreatePath2I(points: PGpPoint; types: PByte; count: INT; fillMode: TGpFillMode; path: PPGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipClonePath(path: PGpPath; clonePath: PPGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipDeletePath(path: PGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipResetPath(path: PGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPointCount(path: PGpPath; count: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathTypes(path: PGpPath; types: PByte; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathPoints(path: PGpPath; points: PGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathPointsI(path: PGpPath; points: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathFillMode(path: PGpPath; fillmode: PGpFillMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPathFillMode(path: PGpPath; fillmode: TGpFillMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathData(path: PGpPath; pathData: PGpPathData): TGpStatus; stdcall; external GDIPLIB;

Function GdipStartPathFigure(path: PGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipClosePathFigure(path: PGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipClosePathFigures(path: PGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPathMarker(path: PGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipClearPathMarkers(path: PGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipReversePath(path: PGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathLastPoint(path: PGpPath; lastPoint: PGpPointF): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathLine(path: PGpPath; x1,y1,x2,y2: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathLine2(path: PGpPath; points: PGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathArc(path: PGpPath; x,y,width,height,startAngle,sweepAngle: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathBezier(path: PGpPath; x1,y1,x2,y2,x3,y3,x4,y4: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathBeziers(path: PGpPath; points: PGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathCurve(path: PGpPath; points: PGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathCurve2(path: PGpPath; points: PGpPointF; count: INT; tension: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathCurve3(path: PGpPath; points: PGpPointF; count,offset,numberOfSegments: INT; tension: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathClosedCurve(path: PGpPath; points: PGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathClosedCurve2(path: PGpPath; points: PGpPointF; count: INT; tension: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathRectangle(path: PGpPath; x,y,width,height: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathRectangles(path: PGpPath; rects: PGpRectF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathEllipse(path: PGpPath; x,y,width,height: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathPie(path: PGpPath; x,y,width,height,startAngle,sweepAngle: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathPolygon(path: PGpPath; points: PGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathPath(path: PGpPath; addingPath: PGpPath; connect: BOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathString(path: PGpPath; str: PWideChar; length: INT; family: PGpFontFamily; style: INT;
  emSize: REAL; layoutRect: PRectF; format: PGpStringFormat): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathStringI(path: PGpPath; str: PWideChar; length: INT; family: PGpFontFamily; style: INT;
  emSize: REAL; layoutRect: PRect; format: PGpStringFormat): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathLineI(path: PGpPath; x1,y1,x2,y2: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathLine2I(path: PGpPath; points: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathArcI(path: PGpPath; x,y,width,height: INT; startAngle,sweepAngle: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathBezierI(path: PGpPath; x1,y1,x2,y2,x3,y3,x4,y4: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathBeziersI(path: PGpPath; points: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathCurveI(path: PGpPath; points: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathCurve2I(path: PGpPath; points: PGpPoint; count: INT; tension: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathCurve3I(path: PGpPath; points: PGpPoint; count,offset,numberOfSegments: INT; tension: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathClosedCurveI(path: PGpPath; points: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathClosedCurve2I(path: PGpPath; points: PGpPoint; count: INT; tension: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathRectangleI(path: PGpPath; x,y,width,height: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathRectanglesI(path: PGpPath; rects: PGpRect; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathEllipseI(path: PGpPath; x,y,width,height: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathPieI(path: PGpPath; x,y,width,height: INT; startAngle,sweepAngle: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipAddPathPolygonI(path: PGpPath; points: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipFlattenPath(path: PGpPath; matrix: PGpMatrix; flatness: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipWindingModeOutline(path: PGpPath; matrix: PGpMatrix; flatness: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipWidenPath(nativePath: PGpPath; pen: PGpPen; matrix: PGpMatrix; flatness: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipWarpPath(path: PGpPath; matrix: PGpMatrix; points: PGpPointF; count: INT; srcx,srcy,srcwidth,srcheight: REAL;
  warpMode: TWarpMode; flatness: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipTransformPath(path: PGpPath; matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathWorldBounds(path: PGpPath; bounds: PGpRectF; matrix: PGpMatrix; pen: PGpPen): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathWorldBoundsI(path: PGpPath; bounds: PGpRect; matrix: PGpMatrix; pen: PGpPen): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsVisiblePathPoint(path: PGpPath; x,y: REAL; graphics: PGpGraphics; result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsVisiblePathPointI(path: PGpPath; x,y: INT; graphics: PGpGraphics; result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsOutlineVisiblePathPoint(path: PGpPath; x,y: REAL; pen: PGpPen; graphics: PGpGraphics;
  result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsOutlineVisiblePathPointI(path: PGpPath; x,y: INT; pen: PGpPen; graphics: PGpGraphics;
  result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// PathIterator APIs
//----------------------------------------------------------------------------

Function GdipCreatePathIter(iterator: PPGpPathIterator; path: PGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipDeletePathIter(iterator: PGpPathIterator): TGpStatus; stdcall; external GDIPLIB;

Function GdipPathIterNextSubpath(iterator: PGpPathIterator; resultCount,startIndex,endIndex: PINT;
  isClosed: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipPathIterNextSubpathPath(iterator: PGpPathIterator; resultCount: PINT; path: PGpPath;
  isClosed: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipPathIterNextPathType(iterator: PGpPathIterator; resultCount: PINT; pathType: PBYTE;
  startIndex,endIndex: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipPathIterNextMarker(iterator: PGpPathIterator; resultCount,startIndex,endIndex: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipPathIterNextMarkerPath(iterator: PGpPathIterator; resultCount: PINT; path: PGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipPathIterGetCount(iterator: PGpPathIterator; count: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipPathIterGetSubpathCount(iterator: PGpPathIterator; count: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipPathIterIsValid(iterator: PGpPathIterator; valid: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipPathIterHasCurve(iterator: PGpPathIterator; hasCurve: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipPathIterRewind(iterator: PGpPathIterator): TGpStatus; stdcall; external GDIPLIB;

Function GdipPathIterEnumerate(iterator: PGpPathIterator; resultCount: PINT; points: PGpPointF;
  types: PBYTE; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipPathIterCopyData(iterator: PGpPathIterator; resultCount: PINT; points: PGpPointF;
  types: PBYTE; startIndex,endIndex: INT): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// Matrix APIs
//----------------------------------------------------------------------------

Function GdipCreateMatrix(matrix: PPGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateMatrix2(m11,m12,m21,m22,dx,dy: REAL; matrix: PPGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateMatrix3(rect: PGpRectF; dstplg: PGpPointF; matrix: PPGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateMatrix3I(rect: PGpRect; dstplg: PGpPoint; matrix: PPGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipCloneMatrix(matrix: PGpMatrix; cloneMatrix: PPGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipDeleteMatrix(matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetMatrixElements(matrix: PGpMatrix; m11,m12,m21,m22,dx,dy: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipMultiplyMatrix(matrix: PGpMatrix; matrix2: PGpMatrix; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipTranslateMatrix(matrix: PGpMatrix; offsetX,offsetY: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipScaleMatrix(matrix: PGpMatrix; scaleX,scaleY: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipRotateMatrix(matrix: PGpMatrix; angle: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipShearMatrix(matrix: PGpMatrix; shearX,shearY: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipInvertMatrix(matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipTransformMatrixPoints(matrix: PGpMatrix; pts: PGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipTransformMatrixPointsI(matrix: PGpMatrix; pts: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipVectorTransformMatrixPoints(matrix: PGpMatrix; pts: PGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipVectorTransformMatrixPointsI(matrix: PGpMatrix; pts: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetMatrixElements(matrix: PGpMatrix; matrixOut: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsMatrixInvertible(matrix: PGpMatrix; result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsMatrixIdentity(matrix: PGpMatrix; result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsMatrixEqual(matrix,matrix2: PGpMatrix; result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// Region APIs
//----------------------------------------------------------------------------

Function GdipCreateRegion(region: PPGpRegion): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateRegionRect(rect: PGpRectF; region: PPGpRegion): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateRegionRectI(rect: PGpRect; region: PPGpRegion): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateRegionPath(path: PGpPath; region: PPGpRegion): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateRegionRgnData(regionData: PBYTE; size: INT; region: PPGpRegion): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateRegionHrgn(hRgn: HRGN; region: PPGpRegion): TGpStatus; stdcall; external GDIPLIB;

Function GdipCloneRegion(region: PGpRegion; cloneRegion: PPGpRegion): TGpStatus; stdcall; external GDIPLIB;

Function GdipDeleteRegion(region: PGpRegion): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetInfinite(region: PGpRegion): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetEmpty(region: PGpRegion): TGpStatus; stdcall; external GDIPLIB;

Function GdipCombineRegionRect(region: PGpRegion; rect: PGpRectF; combineMode: TCombineMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipCombineRegionRectI(region: PGpRegion; rect: PGpRect; combineMode: TCombineMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipCombineRegionPath(region: PGpRegion; path: PGpPath; combineMode: TCombineMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipCombineRegionRegion(region,region2: PGpRegion; combineMode: TCombineMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipTranslateRegion(region: PGpRegion; dx,dy: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipTranslateRegionI(region: PGpRegion; dx,dy: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipTransformRegion(region: PGpRegion; matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetRegionBounds(region: PGpRegion; graphics: PGpGraphics; rect: PGpRectF): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetRegionBoundsI(region: PGpRegion; graphics: PGpGraphics; rect: PGpRect): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetRegionHRgn(region: PGpRegion; graphics: PGpGraphics; hRgn: PHRGN): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsEmptyRegion(region: PGpRegion; graphics: PGpGraphics; result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsInfiniteRegion(region: PGpRegion; graphics: PGpGraphics; result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsEqualRegion(region,region2: PGpRegion; graphics: PGpGraphics; result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetRegionDataSize(region: PGpRegion; bufferSize: PUINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetRegionData(region: PGpRegion; buffer: PBYTE; bufferSize: UINT; sizeFilled: PUINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsVisibleRegionPoint(region: PGpRegion; x,y: REAL; graphics: PGpGraphics; result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsVisibleRegionPointI(region: PGpRegion; x,y: INT; graphics: PGpGraphics; result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsVisibleRegionRect(region: PGpRegion; x,y,width,height: REAL; graphics: PGpGraphics;
  result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsVisibleRegionRectI(region: PGpRegion; x,y,width,height: INT; graphics: PGpGraphics;
  result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetRegionScansCount(region: PGpRegion; count: PUINT; matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetRegionScans(region: PGpRegion; rects: PGpRectF; count: PINT; matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetRegionScansI(region: PGpRegion; rects: PGpRect; count: PINT; matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// Brush APIs
//----------------------------------------------------------------------------

Function GdipCloneBrush(brush: PGpBrush; cloneBrush: PPGpBrush): TGpStatus; stdcall; external GDIPLIB;

Function GdipDeleteBrush(brush: PGpBrush): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetBrushType(brush: PGpBrush; type_: PGpBrushType): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// HatchBrush APIs
//----------------------------------------------------------------------------

Function GdipCreateHatchBrush(hatchstyle: TGpHatchStyle; forecol,backcol: TARGB; brush: PPGpHatch): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetHatchStyle(brush: PGpHatch; hatchstyle: PGpHatchStyle): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetHatchForegroundColor(brush: PGpHatch; forecol: PARGB): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetHatchBackgroundColor(brush: PGpHatch; backcol: PARGB): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// TextureBrush APIs
//----------------------------------------------------------------------------

Function GdipCreateTexture(image: PGpImage; wrapmode: TGpWrapMode; texture: PPGpTexture): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateTexture2(image: PGpImage; wrapmode: TGpWrapMode; x,y,width,height: REAL;
  texture: PPGpTexture): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateTextureIA(image: PGpImage; imageAttributes: PGpImageAttributes; x,y,width,height: REAL;
  texture: PPGpTexture): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateTexture2I(image: PGpImage; wrapmode: TGpWrapMode; x,y,width,height: INT;
  texture: PPGpTexture): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateTextureIAI(image: PGpImage; imageAttributes: PGpImageAttributes; x,y,width,height: INT;
  texture: PPGpTexture): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetTextureTransform(brush: PGpTexture; matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetTextureTransform(brush: PGpTexture; matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipResetTextureTransform(brush: PGpTexture): TGpStatus; stdcall; external GDIPLIB;

Function GdipMultiplyTextureTransform(brush: PGpTexture; matrix: PGpMatrix; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipTranslateTextureTransform(brush: PGpTexture; dx,dy: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipScaleTextureTransform(brush: PGpTexture; sx,sy: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipRotateTextureTransform(brush: PGpTexture; angle: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetTextureWrapMode(brush: PGpTexture; wrapmode: TGpWrapMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetTextureWrapMode(brush: PGpTexture; wrapmode: PGpWrapMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetTextureImage(brush: PGpTexture; image: PPGpImage): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// SolidBrush APIs
//----------------------------------------------------------------------------

Function GdipCreateSolidFill(color: TARGB; brush: PPGpSolidFill): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetSolidFillColor(brush: PGpSolidFill; color: TARGB): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetSolidFillColor(brush: PGpSolidFill; color: PARGB): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// LineBrush APIs
//----------------------------------------------------------------------------

Function GdipCreateLineBrush(point1,point2: PGpPointF; color1,color2: TARGB;
  wrapMode: TGpWrapMode; lineGradient: PPGpLineGradient): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateLineBrushI(point1,point2: PGpPoint; color1,color2: TARGB;
  wrapMode: TGpWrapMode; lineGradient: PPGpLineGradient): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateLineBrushFromRect(rect: PGpRectF; color1,color2: TARGB; mode: TLinearGradientMode;
  wrapMode: TGpWrapMode; lineGradient: PPGpLineGradient): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateLineBrushFromRectI(rect: PGpRect; color1,color2: TARGB; mode: TLinearGradientMode;
  wrapMode: TGpWrapMode; lineGradient: PPGpLineGradient): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateLineBrushFromRectWithAngle(rect: PGpRectF; color1,color2: TARGB; angle: REAL; isAngleScalable: BOOL;
  wrapMode: TGpWrapMode; lineGradient: PPGpLineGradient): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateLineBrushFromRectWithAngleI(rect: PGpRect; color1,color2: TARGB; angle: REAL; isAngleScalable: BOOL;
  wrapMode: TGpWrapMode; lineGradient: PPGpLineGradient): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetLineColors(brush: PGpLineGradient; color1,color2: TARGB): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetLineColors(brush: PGpLineGradient; colors: PARGB): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetLineRect(brush: PGpLineGradient; rect: PGpRectF): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetLineRectI(brush: PGpLineGradient; rect: PGpRect): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetLineGammaCorrection(brush: PGpLineGradient; useGammaCorrection: BOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetLineGammaCorrection(brush: PGpLineGradient; useGammaCorrection: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetLineBlendCount(brush: PGpLineGradient; count: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetLineBlend(brush: PGpLineGradient; blend,positions: PREAL; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetLineBlend(brush: PGpLineGradient; blend,positions: PREAL; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetLinePresetBlendCount(brush: PGpLineGradient; count: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetLinePresetBlend(brush: PGpLineGradient; blend: PARGB; positions: PREAL; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetLinePresetBlend(brush: PGpLineGradient; blend: PARGB; positions: PREAL; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetLineSigmaBlend(brush: PGpLineGradient; focus,scale: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetLineLinearBlend(brush: PGpLineGradient; focus,scale: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetLineWrapMode(brush: PGpLineGradient; wrapmode: TGpWrapMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetLineWrapMode(brush: PGpLineGradient; wrapmode: PGpWrapMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetLineTransform(brush: PGpLineGradient; matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetLineTransform(brush: PGpLineGradient; matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipResetLineTransform(brush: PGpLineGradient): TGpStatus; stdcall; external GDIPLIB;

Function GdipMultiplyLineTransform(brush: PGpLineGradient; matrix: PGpMatrix; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipTranslateLineTransform(brush: PGpLineGradient; dx,dy: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipScaleLineTransform(brush: PGpLineGradient; sx,sy: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipRotateLineTransform(brush: PGpLineGradient; angle: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// PathGradientBrush APIs
//----------------------------------------------------------------------------

Function GdipCreatePathGradient(points: PGpPointF; count: INT; wrapMode: TGpWrapMode;
  polyGradient: PPGpPathGradient): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreatePathGradientI(points: PGpPoint; count: INT; wrapMode: TGpWrapMode;
  polyGradient: PPGpPathGradient): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreatePathGradientFromPath(path: PGpPath; polyGradient: PPGpPathGradient): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientCenterColor(brush: PGpPathGradient; colors: PARGB): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPathGradientCenterColor(brush: PGpPathGradient; colors: TARGB): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientSurroundColorsWithCount(brush: PGpPathGradient; color: PARGB; count: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPathGradientSurroundColorsWithCount(brush: PGpPathGradient; color: PARGB; count: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientPath(brush: PGpPathGradient; path: PGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPathGradientPath(brush: PGpPathGradient; path: PGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientCenterPoint(brush: PGpPathGradient; points: PGpPointF): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientCenterPointI(brush: PGpPathGradient; points: PGpPoint): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPathGradientCenterPoint(brush: PGpPathGradient; points: PGpPointF): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPathGradientCenterPointI(brush: PGpPathGradient; points: PGpPoint): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientRect(brush: PGpPathGradient; rect: PGpRectF): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientRectI(brush: PGpPathGradient; rect: PGpRect): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientPointCount(brush: PGpPathGradient; count: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientSurroundColorCount(brush: PGpPathGradient; count: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPathGradientGammaCorrection(brush: PGpPathGradient; useGammaCorrection: BOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientGammaCorrection(brush: PGpPathGradient; useGammaCorrection: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientBlendCount(brush: PGpPathGradient; count: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientBlend(brush: PGpPathGradient; blend,positions: PREAL; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPathGradientBlend(brush: PGpPathGradient; blend,positions: PREAL; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientPresetBlendCount(brush: PGpPathGradient; count: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientPresetBlend(brush: PGpPathGradient; blend: PARGB; positions: PREAL; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPathGradientPresetBlend(brush: PGpPathGradient; blend: PARGB; positions: PREAL; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPathGradientSigmaBlend(brush: PGpPathGradient; focus,scale: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPathGradientLinearBlend(brush: PGpPathGradient; focus,scale: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientWrapMode(brush: PGpPathGradient; wrapmode: PGpWrapMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPathGradientWrapMode(brush: PGpPathGradient; wrapmode: TGpWrapMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientTransform(brush: PGpPathGradient; matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPathGradientTransform(brush: PGpPathGradient; matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipResetPathGradientTransform(brush: PGpPathGradient): TGpStatus; stdcall; external GDIPLIB;

Function GdipMultiplyPathGradientTransform(brush: PGpPathGradient; matrix: PGpMatrix; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipTranslatePathGradientTransform(brush: PGpPathGradient; dx,dy: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipScalePathGradientTransform(brush: PGpPathGradient; sx,sy: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipRotatePathGradientTransform(brush: PGpPathGradient; angle: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPathGradientFocusScales(brush: PGpPathGradient; xScale,yScale: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPathGradientFocusScales(brush: PGpPathGradient; xScale,yScale: REAL): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// Pen APIs
//----------------------------------------------------------------------------

Function GdipCreatePen1(color: TARGB; width: REAL; unit_: TGpUnit; pen: PPGpPen): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreatePen2(brush: PGpBrush; width: REAL; unit_: TGpUnit; pen: PPGpPen): TGpStatus; stdcall; external GDIPLIB;

Function GdipClonePen(pen: PGpPen; clonepen: PPGpPen): TGpStatus; stdcall; external GDIPLIB;

Function GdipDeletePen(pen: PGpPen): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenWidth(pen: PGpPen; width: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenWidth(pen: PGpPen; width: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenUnit(pen: PGpPen; unit_: TGpUnit): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenUnit(pen: PGpPen; unit_: PGpUnit): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenLineCap197819(pen: PGpPen; startCap,endCap: TGpLineCap; dashCap: TGpDashCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenStartCap(pen: PGpPen; startCap: TGpLineCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenEndCap(pen: PGpPen; endCap: TGpLineCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenDashCap197819(pen: PGpPen; dashCap: TGpDashCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenStartCap(pen: PGpPen; startCap: PGpLineCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenEndCap(pen: PGpPen; endCap: PGpLineCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenDashCap197819(pen: PGpPen; dashCap: PGpDashCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenLineJoin(pen: PGpPen; lineJoin: TGpLineJoin): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenLineJoin(pen: PGpPen; lineJoin: PGpLineJoin): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenCustomStartCap(pen: PGpPen; customCap: PGpCustomLineCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenCustomStartCap(pen: PGpPen; customCap: PPGpCustomLineCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenCustomEndCap(pen: PGpPen; customCap: PGpCustomLineCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenCustomEndCap(pen: PGpPen; customCap: PPGpCustomLineCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenMiterLimit(pen: PGpPen; miterLimit: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenMiterLimit(pen: PGpPen; miterLimit: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenMode(pen: PGpPen; penMode: TGpPenAlignment): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenMode(pen: PGpPen; penMode: PGpPenAlignment): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenTransform(pen: PGpPen; matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenTransform(pen: PGpPen; matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipResetPenTransform(pen: PGpPen): TGpStatus; stdcall; external GDIPLIB;

Function GdipMultiplyPenTransform(pen: PGpPen; matrix: PGpMatrix; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipTranslatePenTransform(pen: PGpPen; dx,dy: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipScalePenTransform(pen: PGpPen; sx,sy: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipRotatePenTransform(pen: PGpPen; angle: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenColor(pen: PGpPen; argb: TARGB): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenColor(pen: PGpPen; argb: PARGB): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenBrushFill(pen: PGpPen; brush: PGpBrush): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenBrushFill(pen: PGpPen; brush: PPGpBrush): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenFillType(pen: PGpPen; type_: PGpPenType): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenDashStyle(pen: PGpPen; dashstyle: PGpDashStyle): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenDashStyle(pen: PGpPen; dashstyle: TGpDashStyle): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenDashOffset(pen: PGpPen; offset: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenDashOffset(pen: PGpPen; offset: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenDashCount(pen: PGpPen; count: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenDashArray(pen: PGpPen; dash: PREAL; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenDashArray(pen: PGpPen; dash: PREAL; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenCompoundCount(pen: PGpPen; count: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPenCompoundArray(pen: PGpPen; dash: PREAL; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPenCompoundArray(pen: PGpPen; dash: PREAL; count: INT): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// CustomLineCap APIs
//----------------------------------------------------------------------------

Function GdipCreateCustomLineCap(fillPath,strokePath: PGpPath; baseCap: TGpLineCap; baseInset: REAL;
  customCap: PPGpCustomLineCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipDeleteCustomLineCap(customCap: PGpCustomLineCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipCloneCustomLineCap(customCap: PGpCustomLineCap; clonedCap: PPGpCustomLineCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetCustomLineCapType(customCap: PGpCustomLineCap; capType: PCustomLineCapType): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetCustomLineCapStrokeCaps(customCap: PGpCustomLineCap; startCap,endCap: TGpLineCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetCustomLineCapStrokeCaps(customCap: PGpCustomLineCap; startCap,endCap: PGpLineCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetCustomLineCapStrokeJoin(customCap: PGpCustomLineCap; lineJoin: TGpLineJoin): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetCustomLineCapStrokeJoin(customCap: PGpCustomLineCap; lineJoin: PGpLineJoin): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetCustomLineCapBaseCap(customCap: PGpCustomLineCap; baseCap: TGpLineCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetCustomLineCapBaseCap(customCap: PGpCustomLineCap; baseCap: PGpLineCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetCustomLineCapBaseInset(customCap: PGpCustomLineCap; inset: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetCustomLineCapBaseInset(customCap: PGpCustomLineCap; inset: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetCustomLineCapWidthScale(customCap: PGpCustomLineCap; widthScale: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetCustomLineCapWidthScale(customCap: PGpCustomLineCap; widthScale: PREAL): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// AdjustableArrowCap APIs
//----------------------------------------------------------------------------

Function GdipCreateAdjustableArrowCap(height,width: REAL; isFilled: BOOL; cap: PPGpAdjustableArrowCap): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetAdjustableArrowCapHeight(cap: PGpAdjustableArrowCap; height: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetAdjustableArrowCapHeight(cap: PGpAdjustableArrowCap; height: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetAdjustableArrowCapWidth(cap: PGpAdjustableArrowCap; width: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetAdjustableArrowCapWidth(cap: PGpAdjustableArrowCap; width: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetAdjustableArrowCapMiddleInset(cap: PGpAdjustableArrowCap; middleInset: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetAdjustableArrowCapMiddleInset(cap: PGpAdjustableArrowCap; middleInset: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetAdjustableArrowCapFillState(cap: PGpAdjustableArrowCap; fillState: BOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetAdjustableArrowCapFillState(cap: PGpAdjustableArrowCap; fillState: PBOOL): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// Image APIs
//----------------------------------------------------------------------------

//!! note in pascal IStream is already a pointer to the interface
Function GdipLoadImageFromStream(stream: IStream; image: PPGpImage): TGpStatus; stdcall; external GDIPLIB;

Function GdipLoadImageFromFile(filename: PWideChar; image: PPGpImage): TGpStatus; stdcall; external GDIPLIB;

Function GdipLoadImageFromStreamICM(stream: IStream; image: PPGpImage): TGpStatus; stdcall; external GDIPLIB;

Function GdipLoadImageFromFileICM(filename: PWideChar; image: PPGpImage): TGpStatus; stdcall; external GDIPLIB;

Function GdipCloneImage(image: PGpImage; cloneImage: PPGpImage): TGpStatus; stdcall; external GDIPLIB;

Function GdipDisposeImage(image: PGpImage): TGpStatus; stdcall; external GDIPLIB;

Function GdipSaveImageToFile(image: PGpImage; filename: PWideChar; clsidEncoder: PCLSID;
  encoderParams: PEncoderParameters): TGpStatus; stdcall; external GDIPLIB;

Function GdipSaveImageToStream(image: PGpImage; stream: IStream; clsidEncoder: PCLSID;
  encoderParams: PEncoderParameters): TGpStatus; stdcall; external GDIPLIB;

Function GdipSaveAdd(image: PGpImage; encoderParams: PEncoderParameters): TGpStatus; stdcall; external GDIPLIB;

Function GdipSaveAddImage(image,newImage: PGpImage; encoderParams: PEncoderParameters): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageGraphicsContext(image: PGpImage; graphics: PPGpGraphics): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageBounds(image: PGpImage; srcRect: PGpRectF; srcUnit: PGpUnit): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageDimension(image: PGpImage; width,height: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageType(image: PGpImage; type_: PImageType): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageWidth(image: PGpImage; width: PUINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageHeight(image: PGpImage; height: PUINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageHorizontalResolution(image: PGpImage; resolution: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageVerticalResolution(image: PGpImage; resolution: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageFlags(image: PGpImage; flags: PUINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageRawFormat(image: PGpImage; format: PGUID): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImagePixelFormat(image: PGpImage; format: PPixelFormat): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageThumbnail(image: PGpImage; thumbWidth,thumbHeight: UINT; thumbImage: PPGpImage;
  callback: TGetThumbnailImageAbort; callbackData: Pointer): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetEncoderParameterListSize(image: PGpImage; clsidEncoder: PCLSID; size: PUINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetEncoderParameterList(image: PGpImage; clsidEncoder: PCLSID; size: UINT;
  bufer: PEncoderParameters): TGpStatus; stdcall; external GDIPLIB;

Function GdipImageGetFrameDimensionsCount(image: PGpImage; count: PUINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipImageGetFrameDimensionsList(image: PGpImage; dimensionIDs: PGUID; count: UINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipImageGetFrameCount(image: PGpImage; dimensionID: PGUID; count: PUINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipImageSelectActiveFrame(image: PGpImage; dimensionID: PGUID; frameIndex: UINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipImageRotateFlip(image: PGpImage; rfType: TRotateFlipType): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImagePalette(image: PGpImage; palette: PColorPalette; size: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetImagePalette(image: PGpImage; palette: PColorPalette): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImagePaletteSize(image: PGpImage; size: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPropertyCount(image: PGpImage; numOfProperty: PUINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPropertyIdList(image: PGpImage; numOfProperty: UINT; list: PPROPID): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPropertyItemSize(image: PGpImage; propId: TPROPID; size: PUINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPropertyItem(image: PGpImage; propId: TPROPID; propSize: UINT; buffer: PPropertyItem): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPropertySize(image: PGpImage; totalBufferSize,numProperties: PUINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetAllPropertyItems(image: PGpImage; totalBufferSize,numProperties: UINT; allItems: PPropertyItem): TGpStatus; stdcall; external GDIPLIB;

Function GdipRemovePropertyItem(image: PGpImage; propId: TPROPID): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPropertyItem(image: PGpImage; item: PPropertyItem): TGpStatus; stdcall; external GDIPLIB;

{$IF GDIPVER >= $0110}

Function GdipFindFirstImageItem(image: PGpImage; item: PImageItemData): TGpStatus; stdcall; external GDIPLIB;

Function GdipFindNextImageItem(image: PGpImage; item: PImageItemData): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageItemData(image: PGpImage; item: PImageItemData): TGpStatus; stdcall; external GDIPLIB;

{$IFEND}

Function GdipImageForceValidation(image: PGpImage): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// Bitmap APIs
//----------------------------------------------------------------------------

Function GdipCreateBitmapFromStream(stream: IStream; bitmap: PPGpBitmap): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateBitmapFromFile(filename: PWideChar; bitmap: PPGpBitmap): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateBitmapFromStreamICM(stream: IStream; bitmap: PPGpBitmap): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateBitmapFromFileICM(filename: PWideChar; bitmap: PPGpBitmap): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateBitmapFromScan0(width,height,stride: INT; format: TPixelFormat; scan0: PBYTE;
  bitmap: PPGpBitmap): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateBitmapFromGraphics(width,height: INT; target: PGpGraphics; bitmap: PPGpBitmap): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateBitmapFromDirectDrawSurface(surface: IDirectDrawSurface7; bitmap: PPGpBitmap): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateBitmapFromGdiDib(gdiBitmapInfo: PBITMAPINFO; gdiBitmapData: Pointer; bitmap: PPGpBitmap): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateBitmapFromHBITMAP(hbm: HBITMAP; hpal: HPALETTE; bitmap: PPGpBitmap): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateHBITMAPFromBitmap(bitmap: PGpBitmap; hbmReturn: PHBITMAP; background: TARGB): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateBitmapFromHICON(hicon: HICON; bitmap: PPGpBitmap): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateHICONFromBitmap(bitmap: PGpBitmap; hbmReturn: PHICON): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateBitmapFromResource(hInstance: HINSTANCE; lpBitmapName: PWideChar; bitmap: PPGpBitmap): TGpStatus; stdcall; external GDIPLIB;

Function GdipCloneBitmapArea(x,y,width,height: REAL; format: TPixelFormat; srcBitmap: PGpBitmap;
  dstBitmap: PPGpBitmap): TGpStatus; stdcall; external GDIPLIB;

Function GdipCloneBitmapAreaI(x,y,width,height: INT; format: TPixelFormat; srcBitmap: PGpBitmap;
  dstBitmap: PPGpBitmap): TGpStatus; stdcall; external GDIPLIB;

Function GdipBitmapLockBits(bitmap: PGpBitmap; rect: PGpRect; flags: UINT; format: TPixelFormat;
  lockedBitmapData: PBitmapData): TGpStatus; stdcall; external GDIPLIB;

Function GdipBitmapUnlockBits(bitmap: PGpBitmap; lockedBitmapData: PBitmapData): TGpStatus; stdcall; external GDIPLIB;

Function GdipBitmapGetPixel(bitmap: PGpBitmap; x,y: INT; color: PARGB): TGpStatus; stdcall; external GDIPLIB;

Function GdipBitmapSetPixel(bitmap: PGpBitmap; x,y: INT; color: TARGB): TGpStatus; stdcall; external GDIPLIB;

{$IF GDIPVER >= $0110}

Function GdipImageSetAbort(pImage: PGpImage; pIAbort: PGdiplusAbort): TGpStatus; stdcall; external GDIPLIB;

Function GdipGraphicsSetAbort(pGraphics: PGpGraphics; pIAbort: PGdiplusAbort): TGpStatus; stdcall; external GDIPLIB;

Function GdipBitmapConvertFormat(pInputBitmap : PGpBitmap; format: TPixelFormat; dithertype: TDitherType;
  palettetype: TPaletteType; palette: PColorPalette; alphaThresholdPercent: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipInitializePalette(
    palette:              PColorPalette;    // output palette. must be allocated.
    palettetype:          TPaletteType;     // palette enumeration type.
    optimalColors:        INT;              // how many optimal colors
    useTransparentColor:  BOOL;             // add a transparent color to the palette.
    bitmap:               PGpBitmap         // optional bitmap for median cut.
  ): TGpStatus; stdcall; external GDIPLIB;
    
Function GdipBitmapApplyEffect(bitmap: PGpBitmap; effect: PCGpEffect; roi: Windows.PRECT;
  useAuxData: BOOL; auxData: PPointer; auxDataSize: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipBitmapCreateApplyEffect(inputBitmaps: PPGpBitmap; numInputs: INT; effect: PCGpEffect; roi: Windows.PRECT;
  outputRect: Windows.PRECT; outputBitmap: PPGpBitmap; useAuxData: BOOL; auxData: PPointer; auxDataSize: PINT
  ): TGpStatus; stdcall; external GDIPLIB;

Function GdipBitmapGetHistogram(bitmap: PGpBitmap; format: THistogramFormat; NumberOfEntries: UINT;
  channel0,channel1,channel2,channel3: PUINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipBitmapGetHistogramSize(format: THistogramFormat; NumberOfEntries: PUINT): TGpStatus; stdcall; external GDIPLIB;

{$IFEND}

Function GdipBitmapSetResolution(bitmap: PGpBitmap; xdpi,ydpi: REAL): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// ImageAttributes APIs
//----------------------------------------------------------------------------

Function GdipCreateImageAttributes(imageattr: PPGpImageAttributes): TGpStatus; stdcall; external GDIPLIB;

Function GdipCloneImageAttributes(imageattr: PGpImageAttributes; cloneImageattr: PPGpImageAttributes): TGpStatus; stdcall; external GDIPLIB;

Function GdipDisposeImageAttributes(imageattr: PGpImageAttributes): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetImageAttributesToIdentity(imageattr: PGpImageAttributes; type_: TColorAdjustType): TGpStatus; stdcall; external GDIPLIB;

Function GdipResetImageAttributes(imageattr: PGpImageAttributes; type_: TColorAdjustType): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetImageAttributesColorMatrix(imageattr: PGpImageAttributes; type_: TColorAdjustType; enableFlag: BOOL;
  colorMatrix,grayMatrix: PColorMatrix; flags: TColorMatrixFlags): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetImageAttributesThreshold(imageattr: PGpImageAttributes; type_: TColorAdjustType; enableFlag: BOOL;
  threshold: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetImageAttributesGamma(imageattr: PGpImageAttributes; type_: TColorAdjustType; enableFlag: BOOL;
  gamma: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetImageAttributesNoOp(imageattr: PGpImageAttributes; type_: TColorAdjustType; enableFlag: BOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetImageAttributesColorKeys(imageattr: PGpImageAttributes; type_: TColorAdjustType; enableFlag: BOOL;
  colorLow,colorHigh: TARGB): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetImageAttributesOutputChannel(imageattr: PGpImageAttributes; type_: TColorAdjustType; enableFlag: BOOL;
  channelFlags: TColorChannelFlags): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetImageAttributesOutputChannelColorProfile(imageattr: PGpImageAttributes; type_: TColorAdjustType; enableFlag: BOOL;
  colorProfileFilename: PWideChar): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetImageAttributesRemapTable(imageattr: PGpImageAttributes; type_: TColorAdjustType; enableFlag: BOOL;
  mapSize: UINT; map: PColorMap): TGpStatus; stdcall; external GDIPLIB;
  
Function GdipSetImageAttributesWrapMode(imageAttr: PGpImageAttributes; wrap: TWrapMode; argb: TARGB;
  clamp: BOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetImageAttributesICMMode(imageAttr: PGpImageAttributes; on_: BOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageAttributesAdjustedPalette(imageAttr: PGpImageAttributes; colorPalette: PColorPalette;
  colorAdjustType: TColorAdjustType): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// Graphics APIs
//----------------------------------------------------------------------------

Function GdipFlush(graphics: PGpGraphics; intention: TGpFlushIntention): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateFromHDC(hdc: HDC; graphics: PPGpGraphics): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateFromHDC2(hdc: HDC; hDevice: HANDLE; graphics: PPGpGraphics): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateFromHWND(hwnd: HWND; graphics: PPGpGraphics): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateFromHWNDICM(hwnd: HWND; graphics: PPGpGraphics): TGpStatus; stdcall; external GDIPLIB;

Function GdipDeleteGraphics(graphics: PGpGraphics): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetDC(graphics: PGpGraphics; hdc: PHDC): TGpStatus; stdcall; external GDIPLIB;

Function GdipReleaseDC(graphics: PGpGraphics; hdc: HDC): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetCompositingMode(graphics: PGpGraphics; compositingMode: TCompositingMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetCompositingMode(graphics: PGpGraphics; compositingMode: PCompositingMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetRenderingOrigin(graphics: PGpGraphics; x,y: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetRenderingOrigin(graphics: PGpGraphics; x,y: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetCompositingQuality(graphics: PGpGraphics; compositingQuality: TCompositingQuality): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetCompositingQuality(graphics: PGpGraphics; compositingQuality: PCompositingQuality): TGpStatus; stdcall; external GDIPLIB;
                          
Function GdipSetSmoothingMode(graphics: PGpGraphics; smoothingMode: TSmoothingMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetSmoothingMode(graphics: PGpGraphics; smoothingMode: PSmoothingMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPixelOffsetMode(graphics: PGpGraphics; pixelOffsetMode: TPixelOffsetMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPixelOffsetMode(graphics: PGpGraphics; pixelOffsetMode: PPixelOffsetMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetTextRenderingHint(graphics: PGpGraphics; mode: TTextRenderingHint): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetTextRenderingHint(graphics: PGpGraphics; mode: PTextRenderingHint): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetTextContrast(graphics: PGpGraphics; contrast: UINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetTextContrast(graphics: PGpGraphics; contrast: PUINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetInterpolationMode(graphics: PGpGraphics; interpolationMode: TInterpolationMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetInterpolationMode(graphics: PGpGraphics; interpolationMode: PInterpolationMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetWorldTransform(graphics: PGpGraphics; matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipResetWorldTransform(graphics: PGpGraphics): TGpStatus; stdcall; external GDIPLIB;

Function GdipMultiplyWorldTransform(graphics: PGpGraphics; matrix: PGpMatrix; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipTranslateWorldTransform(graphics: PGpGraphics; dx,dy: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipScaleWorldTransform(graphics: PGpGraphics; sx,sy: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipRotateWorldTransform(graphics: PGpGraphics; angle: REAL; order: TGpMatrixOrder): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetWorldTransform(graphics: PGpGraphics; matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipResetPageTransform(graphics: PGpGraphics): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPageUnit(graphics: PGpGraphics; unit_: PGpUnit): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetPageScale(graphics: PGpGraphics; scale: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPageUnit(graphics: PGpGraphics; unit_: TGpUnit): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetPageScale(graphics: PGpGraphics; scale: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetDpiX(graphics: PGpGraphics; dpi: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetDpiY(graphics: PGpGraphics; dpi: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipTransformPoints(graphics: PGpGraphics; destSpace,srcSpace: TGpCoordinateSpace;
  points: PGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipTransformPointsI(graphics: PGpGraphics; destSpace,srcSpace: TGpCoordinateSpace;
  points: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetNearestColor(graphics: PGpGraphics; argb: PARGB): TGpStatus; stdcall; external GDIPLIB;

// Creates the Win9x Halftone Palette (even on NT) with correct Desktop colors
Function GdipCreateHalftonePalette(): HPALETTE; stdcall; external GDIPLIB;

Function GdipDrawLine(graphics: PGpGraphics; pen: PGpPen; x1,y1,x2,y2: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawLineI(graphics: PGpGraphics; pen: PGpPen; x1,y1,x2,y2: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawLines(graphics: PGpGraphics; pen: PGpPen; points: PGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawLinesI(graphics: PGpGraphics; pen: PGpPen; points: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawArc(graphics: PGpGraphics; pen: PGpPen; x,y,width,height,startAngle,sweepAngle: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawArcI(graphics: PGpGraphics; pen: PGpPen; x,y,width,height: INT; startAngle,sweepAngle: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawBezier(graphics: PGpGraphics; pen: PGpPen; x1,y1,x2,y2,x3,y3,x4,y4: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawBezierI(graphics: PGpGraphics; pen: PGpPen; x1,y1,x2,y2,x3,y3,x4,y4: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawBeziers(graphics: PGpGraphics; pen: PGpPen; points: PGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawBeziersI(graphics: PGpGraphics; pen: PGpPen; points: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawRectangle(graphics: PGpGraphics; pen: PGpPen; x,y,width,height: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawRectangleI(graphics: PGpGraphics; pen: PGpPen; x,y,width,height: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawRectangles(graphics: PGpGraphics; pen: PGpPen; rects: PGpRectF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawRectanglesI(graphics: PGpGraphics; pen: PGpPen; rects: PGpRect; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawEllipse(graphics: PGpGraphics; pen: PGpPen; x,y,width,height: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawEllipseI(graphics: PGpGraphics; pen: PGpPen; x,y,width,height: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawPie(graphics: PGpGraphics; pen: PGpPen; x,y,width,height,startAngle,sweepAngle: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawPieI(graphics: PGpGraphics; pen: PGpPen; x,y,width,height: INT; startAngle,sweepAngle: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawPolygon(graphics: PGpGraphics; pen: PGpPen; points: PGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawPolygonI(graphics: PGpGraphics; pen: PGpPen; points: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawPath(graphics: PGpGraphics; pen: PGpPen; path: PGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawCurve(graphics: PGpGraphics; pen: PGpPen; points: PGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawCurveI(graphics: PGpGraphics; pen: PGpPen; points: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawCurve2(graphics: PGpGraphics; pen: PGpPen; points: PGpPointF; count: INT; tension: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawCurve2I(graphics: PGpGraphics; pen: PGpPen; points: PGpPoint; count: INT; tension: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawCurve3(graphics: PGpGraphics; pen: PGpPen; points: PGpPointF; count,offset,numberOfSegments: INT;
  tension: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawCurve3I(graphics: PGpGraphics; pen: PGpPen; points: PGpPoint; count,offset,numberOfSegments: INT;
  tension: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawClosedCurve(graphics: PGpGraphics; pen: PGpPen; points: pGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawClosedCurveI(graphics: PGpGraphics; pen: PGpPen; points: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawClosedCurve2(graphics: PGpGraphics; pen: PGpPen; points: PGpPointF; count: INT; tension: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawClosedCurve2I(graphics: PGpGraphics; pen: PGpPen; points: PGpPoint; count: INT; tension: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGraphicsClear(graphics: PGpGraphics; color: TARGB): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillRectangle(graphics: PGpGraphics; brush: PGpBrush; x,y,width,height: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillRectangleI(graphics: PGpGraphics; brush: PGpBrush; x,y,width,height: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillRectangles(graphics: PGpGraphics; brush: PGpBrush; rects: PGpRectF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillRectanglesI(graphics: PGpGraphics; brush: PGpBrush; rects: PGpRect; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillPolygon(graphics: PGpGraphics; brush: PGpBrush; points: PGpPointF; count: INT;
  fillMode: TGpFillMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillPolygonI(graphics: PGpGraphics; brush: PGpBrush; points: PGpPoint; count: INT;
  fillMode: TGpFillMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillPolygon2(graphics: PGpGraphics; brush: PGpBrush; points: PGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillPolygon2I(graphics: PGpGraphics; brush: PGpBrush; points: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillEllipse(graphics: PGpGraphics; brush: PGpBrush; x,y,width,height: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillEllipseI(graphics: PGpGraphics; brush: PGpBrush; x,y,width,height: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillPie(graphics: PGpGraphics; brush: PGpBrush; x,y,width,height,startAngle,sweepAngle: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillPieI(graphics: PGpGraphics; brush: PGpBrush; x,y,width,height: INT;
  startAngle,sweepAngle: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillPath(graphics: PGpGraphics; brush: PGpBrush; path: PGpPath): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillClosedCurve(graphics: PGpGraphics; brush: PGpBrush; points: PGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillClosedCurveI(graphics: PGpGraphics; brush: PGpBrush; points: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillClosedCurve2(graphics: PGpGraphics; brush: PGpBrush; points: PGpPointF; count: INT; tension: REAL;
  fillMode: TGpFillMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillClosedCurve2I(graphics: PGpGraphics; brush: PGpBrush; points: PGpPoint; count: INT; tension: REAL;
  fillMode: TGpFillMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipFillRegion(graphics: PGpGraphics; brush: PGpBrush; region: PGpRegion): TGpStatus; stdcall; external GDIPLIB;

{$IF GDIPVER >= $0110}

Function GdipDrawImageFX(graphics: PGpGraphics; image: PGpImage; source: PGpRectF; xForm: PGpMatrix; effect: PCGpEffect;
  imageAttributes: PGpImageAttributes; srcUnit: TGpUnit): TGpStatus; stdcall; external GDIPLIB;

{$IFEND}

Function GdipDrawImage(graphics: PGpGraphics; image: PGpImage; x,y: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawImageI(graphics: PGpGraphics; image: PGpImage; x,y: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawImageRect(graphics: PGpGraphics; image: PGpImage; x,y,width,height: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawImageRectI(graphics: PGpGraphics; image: PGpImage; x,y,width,height: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawImagePoints(graphics: PGpGraphics; image: PGpImage; dstpoints: PGpPointF; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawImagePointsI(graphics: PGpGraphics; image: PGpImage; dstpoints: PGpPoint; count: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawImagePointRect(graphics: PGpGraphics; image: PGpImage; x,y,srcx,srcy,srcwidth,srcheight: REAL;
  srcUnit: TGpUnit): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawImagePointRectI(graphics: PGpGraphics; image: PGpImage; x,y,srcx,srcy,srcwidth,srcheight: INT;
  srcUnit: TGpUnit): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawImageRectRect(graphics: PGpGraphics; image: PGpImage; dstx,dsty,dstwidth,dstheight,srcx,srcy,srcwidth,srcheight: REAL;
  srcUnit: TGpUnit; imageAttributes: PGpImageAttributes; callback: TDrawImageAbort; callbackData: Pointer): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawImageRectRectI(graphics: PGpGraphics; image: PGpImage; dstx,dsty,dstwidth,dstheight,srcx,srcy,srcwidth,srcheight: INT;
  srcUnit: TGpUnit; imageAttributes: PGpImageAttributes; callback: TDrawImageAbort; callbackData: Pointer): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawImagePointsRect(graphics: PGpGraphics; image: PGpImage; points: PGpPointF; count: INT; srcx,srcy,srcwidth,srcheight: REAL;
  srcUnit: TGpUnit; imageAttributes: PGpImageAttributes; callback: TDrawImageAbort; callbackData: Pointer): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawImagePointsRectI(graphics: PGpGraphics; image: PGpImage; points: PGpPoint; count,srcx,srcy,srcwidth,srcheight: INT;
  srcUnit: TGpUnit; imageAttributes: PGpImageAttributes; callback: TDrawImageAbort; callbackData: Pointer): TGpStatus; stdcall; external GDIPLIB;

Function GdipEnumerateMetafileDestPoint(graphics: PGpGraphics; metafile: PGpMetafile; destPoint: PPointF; callback: TEnumerateMetafileProc;
  callbackData: Pointer; imageAttributes: PGpImageAttributes): TGpStatus; stdcall; external GDIPLIB;

Function GdipEnumerateMetafileDestPointI(graphics: PGpGraphics; metafile: PGpMetafile; destPoint: PPoint; callback: TEnumerateMetafileProc;
  callbackData: Pointer; imageAttributes: PGpImageAttributes): TGpStatus; stdcall; external GDIPLIB;

Function GdipEnumerateMetafileDestRect(graphics: PGpGraphics; metafile: PGpMetafile; destRect: PRectF; callback: TEnumerateMetafileProc;
  callbackData: Pointer; imageAttributes: PGpImageAttributes): TGpStatus; stdcall; external GDIPLIB;

Function GdipEnumerateMetafileDestRectI(graphics: PGpGraphics; metafile: PGpMetafile; destRect: PRect; callback: TEnumerateMetafileProc;
  callbackData: Pointer; imageAttributes: PGpImageAttributes): TGpStatus; stdcall; external GDIPLIB;

Function GdipEnumerateMetafileDestPoints(graphics: PGpGraphics; metafile: PGpMetafile; destPoints: PPointF; count: INT;
  callback: TEnumerateMetafileProc; callbackData: Pointer; imageAttributes: PGpImageAttributes): TGpStatus; stdcall; external GDIPLIB;

Function GdipEnumerateMetafileDestPointsI(graphics: PGpGraphics; metafile: PGpMetafile; destPoints: PPoint; count: INT;
  callback: TEnumerateMetafileProc; callbackData: Pointer; imageAttributes: PGpImageAttributes): TGpStatus; stdcall; external GDIPLIB;

Function GdipEnumerateMetafileSrcRectDestPoint(graphics: PGpGraphics; metafile: PGpMetafile; destPoint: PPointF; srcRect: PRectF; srcUnit: TUnit;
  callback: TEnumerateMetafileProc; callbackData: Pointer; imageAttributes: PGpImageAttributes): TGpStatus; stdcall; external GDIPLIB;

Function GdipEnumerateMetafileSrcRectDestPointI(graphics: PGpGraphics; metafile: PGpMetafile; destPoint: PPoint; srcRect: PRect; srcUnit: TUnit;
  callback: TEnumerateMetafileProc; callbackData: Pointer; imageAttributes: PGpImageAttributes): TGpStatus; stdcall; external GDIPLIB;

Function GdipEnumerateMetafileSrcRectDestRect(graphics: PGpGraphics; metafile: PGpMetafile; destRect,srcRect: PRectF; srcUnit: TUnit;
  callback: TEnumerateMetafileProc; callbackData: Pointer; imageAttributes: PGpImageAttributes): TGpStatus; stdcall; external GDIPLIB;

Function GdipEnumerateMetafileSrcRectDestRectI(graphics: PGpGraphics; metafile: PGpMetafile; destRect,srcRect: PRect; srcUnit: TUnit;
  callback: TEnumerateMetafileProc; callbackData: Pointer; imageAttributes: PGpImageAttributes): TGpStatus; stdcall; external GDIPLIB;

Function GdipEnumerateMetafileSrcRectDestPoints(graphics: PGpGraphics; metafile: PGpMetafile; destPoints: PPointF; count: INT; srcRect: PRectF;
  srcUnit: TUnit; callback: TEnumerateMetafileProc; callbackData: Pointer; imageAttributes: PGpImageAttributes): TGpStatus; stdcall; external GDIPLIB;

Function GdipEnumerateMetafileSrcRectDestPointsI(graphics: PGpGraphics; metafile: PGpMetafile; destPoints: PPoint; count: INT; srcRect: PRect;
  srcUnit: TUnit; callback: TEnumerateMetafileProc; callbackData: Pointer; imageAttributes: PGpImageAttributes): TGpStatus; stdcall; external GDIPLIB;

Function GdipPlayMetafileRecord(metafile: PGpMetafile; recordType: TEmfPlusRecordType; flags,dataSize: UINT;
  data: PBYTE): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetClipGraphics(graphics: PGpGraphics; srcgraphics: PGpGraphics; combineMode: TCombineMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetClipRect(graphics: PGpGraphics; x,y,width,height: REAL; combineMode: TCombineMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetClipRectI(graphics: PGpGraphics; x,y,width,height: INT; combineMode: TCombineMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetClipPath(graphics: PGpGraphics; path: PGpPath; combineMode: TCombineMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetClipRegion(graphics: PGpGraphics; region: PGpRegion; combineMode: TCombineMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetClipHrgn(graphics: PGpGraphics; hRgn: HRGN; combineMode: TCombineMode): TGpStatus; stdcall; external GDIPLIB;

Function GdipResetClip(graphics: PGpGraphics): TGpStatus; stdcall; external GDIPLIB;

Function GdipTranslateClip(graphics: PGpGraphics; dx,dy: REAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipTranslateClipI(graphics: PGpGraphics; dx,dy: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetClip(graphics: PGpGraphics; region: PGpRegion): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetClipBounds(graphics: PGpGraphics; rect: PGpRectF): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetClipBoundsI(graphics: PGpGraphics; rect: PGpRect): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsClipEmpty(graphics: PGpGraphics; result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetVisibleClipBounds(graphics: PGpGraphics; rect: PGpRectF): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetVisibleClipBoundsI(graphics: PGpGraphics; rect: PGpRect): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsVisibleClipEmpty(graphics: PGpGraphics; result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsVisiblePoint(graphics: PGpGraphics; x,y: REAL; result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsVisiblePointI(graphics: PGpGraphics; x,y: INT; result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsVisibleRect(graphics: PGpGraphics; x,y,width,height: REAL; result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsVisibleRectI(graphics: PGpGraphics; x,y,width,height: INT; result: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipSaveGraphics(graphics: PGpGraphics; state: PGraphicsState): TGpStatus; stdcall; external GDIPLIB;

Function GdipRestoreGraphics(graphics: PGpGraphics; state: TGraphicsState): TGpStatus; stdcall; external GDIPLIB;

Function GdipBeginContainer(graphics: PGpGraphics; dstrect,srcrect: PGpRectF; unit_: TGpUnit;
   state: PGraphicsContainer): TGpStatus; stdcall; external GDIPLIB;

Function GdipBeginContainerI(graphics: PGpGraphics; dstrect,srcrect: PGpRect; unit_: TGpUnit;
  state: PGraphicsContainer): TGpStatus; stdcall; external GDIPLIB;

Function GdipBeginContainer2(graphics: PGpGraphics; state: PGraphicsContainer): TGpStatus; stdcall; external GDIPLIB;

Function GdipEndContainer(graphics: PGpGraphics; state: TGraphicsContainer): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetMetafileHeaderFromWmf(hWmf: HMETAFILE; wmfPlaceableFileHeader: PWmfPlaceableFileHeader;
  header: PMetafileHeader): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetMetafileHeaderFromEmf(hEmf: HENHMETAFILE; header: PMetafileHeader): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetMetafileHeaderFromFile(filename: PWIdeChar; header: PMetafileHeader): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetMetafileHeaderFromStream(stream: IStream; header: PMetafileHeader): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetMetafileHeaderFromMetafile(metafile: PGpMetafile; header: PMetafileHeader): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetHemfFromMetafile(metafile: PGpMetafile; hEmf: PHENHMETAFILE): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateStreamOnFile(filename: PWideChar; access: UINT; stream: PIStream): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateMetafileFromWmf(hWmf: HMETAFILE; deleteWmf: BOOL; wmfPlaceableFileHeader: PWmfPlaceableFileHeader;
  metafile: PPGpMetafile): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateMetafileFromEmf(hEmf: HENHMETAFILE; deleteEmf: BOOL; metafile: PPGpMetafile): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateMetafileFromFile(file_: PWideChar; metafile: PPGpMetafile): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateMetafileFromWmfFile(file_: PWideChar; wmfPlaceableFileHeader: PWmfPlaceableFileHeader;
  metafile: PPGpMetafile): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateMetafileFromStream(stream: IStream; metafile: PPGpMetafile): TGpStatus; stdcall; external GDIPLIB;

Function GdipRecordMetafile(referenceHdc: HDC; type_: TEmfType; frameRect: PGpRectF; frameUnit: TMetafileFrameUnit;
  description: PWideChar; metafile: PPGpMetafile): TGpStatus; stdcall; external GDIPLIB;

Function GdipRecordMetafileI(referenceHdc: HDC; type_: TEmfType; frameRect: PGpRect; frameUnit: TMetafileFrameUnit;
  description: PWideChar; metafile: PPGpMetafile): TGpStatus; stdcall; external GDIPLIB;

Function GdipRecordMetafileFileName(fileName: PWideChar; referenceHdc: HDC; type_: TEmfType; frameRect: PGpRectF;
  frameUnit: TMetafileFrameUnit; description: PWideChar; metafile: PPGpMetafile): TGpStatus; stdcall; external GDIPLIB;

Function GdipRecordMetafileFileNameI(fileName: PWideChar; referenceHdc: HDC; type_: TEmfType; frameRect: PGpRect;
  frameUnit: TMetafileFrameUnit; description: PWideChar; metafile: PPGpMetafile): TGpStatus; stdcall; external GDIPLIB;

Function GdipRecordMetafileStream(stream: IStream; referenceHdc: HDC; type_: TEmfType; frameRect: PGpRectF;
  frameUnit: TMetafileFrameUnit; description: PWideChar; metafile: PPGpMetafile): TGpStatus; stdcall; external GDIPLIB;

Function GdipRecordMetafileStreamI(stream: IStream; referenceHdc: HDC; type_: TEmfType; frameRect: PGpRect;
  frameUnit: TMetafileFrameUnit; description: PWideChar; metafile: PPGpMetafile): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetMetafileDownLevelRasterizationLimit(metafile: PGpMetafile; metafileRasterizationLimitDpi: UINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetMetafileDownLevelRasterizationLimit(metafile: PGpMetafile; metafileRasterizationLimitDpi: PUINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageDecodersSize(numDecoders,size: PUINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageDecoders(numDecoders,size: UINT; decoders: PImageCodecInfo): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageEncodersSize(numEncoders,size: PUINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetImageEncoders(numEncoders,size: UINT; encoders: PImageCodecInfo): TGpStatus; stdcall; external GDIPLIB;

Function GdipComment(graphics: PGpGraphics; sizeData: UINT; data: PBYTE): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// FontFamily APIs
//----------------------------------------------------------------------------

Function GdipCreateFontFamilyFromName(name: PWideChar; fontCollection: PGpFontCollection;
  fontFamily: PPGpFontFamily): TGpStatus; stdcall; external GDIPLIB;

Function GdipDeleteFontFamily(fontFamily: PGpFontFamily): TGpStatus; stdcall; external GDIPLIB;

Function GdipCloneFontFamily(fontFamily: PGpFontFamily; clonedFontFamily: PPGpFontFamily): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetGenericFontFamilySansSerif(nativeFamily: PPGpFontFamily): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetGenericFontFamilySerif(nativeFamily: PPGpFontFamily): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetGenericFontFamilyMonospace(nativeFamily: PPGpFontFamily): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetFamilyName(family: PGpFontFamily; name: PWideChar; language: LANGID): TGpStatus; stdcall; external GDIPLIB;

Function GdipIsStyleAvailable(family: PGpFontFamily; style: INT; IsStyleAvailable: PBOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipFontCollectionEnumerable(fontCollection: PGpFontCollection; graphics: PGpGraphics;
  numFound: PINT): TGpStatus; stdcall; external GDIPLIB;

//!! gpfamilies is a pointer to array of PGpFontFamily, original declaration: GpFontFamily* gpfamilies[]
Function GdipFontCollectionEnumerate(fontCollection: PGpFontCollection; numSought: INT; gpfamilies: PPGpFontFamily;
  numFound: PINT; graphics: PGpGraphics): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetEmHeight(family: PGpFontFamily; style: INT; EmHeight: PUINT16): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetCellAscent(family: PGpFontFamily; style: INT; CellAscent: PUINT16): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetCellDescent(family: PGpFontFamily; style: INT; CellDescent: PUINT16): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetLineSpacing(family: PGpFontFamily; style: INT; LineSpacing: PUINT16): TGpStatus; stdcall; external GDIPLIB;  

//----------------------------------------------------------------------------
// Font APIs
//----------------------------------------------------------------------------

Function GdipCreateFontFromDC(hdc: HDC; font: PPGpFont): TGpStatus; stdcall; external GDIPLIB;

Function GdipCreateFontFromLogfontA(hdc: HDC; logfont: PLOGFONTA; font: PPGpFont): TGpStatus; stdcall; external GDIPLIB;
Function GdipCreateFontFromLogfontW(hdc: HDC; logfont: PLOGFONTW; font: PPGpFont): TGpStatus; stdcall; external GDIPLIB; 
Function GdipCreateFontFromLogfont(hdc: HDC; logfont: PLOGFONT; font: PPGpFont): TGpStatus; stdcall; external GDIPLIB name
{$IFDEF Unicode}'GdipCreateFontFromLogfontW'{$ELSE}'GdipCreateFontFromLogfontA'{$ENDIF};

Function GdipCreateFont(fontFamily: PGpFontFamily; emSize: REAL; style: INT; unit_: TUnit; font: PPGpFont): TGpStatus; stdcall; external GDIPLIB;

Function GdipCloneFont(font: PGpFont; cloneFont: PPGpFont): TGpStatus; stdcall; external GDIPLIB;

Function GdipDeleteFont(font: PGpFont): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetFamily(font: PGpFont; family: PPGpFontFamily): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetFontStyle(font: PGpFont; style: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetFontSize(font: PGpFont; size: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetFontUnit(font: PGpFont; unit_: PUnit): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetFontHeight(font: PGpFont; graphics: PGpGraphics; height: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetFontHeightGivenDPI(font: PGpFont; dpi: REAL; height: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetLogFontA(font: PGpFont; graphics: PGpGraphics; logfontA: PLOGFONTA): TGpStatus; stdcall; external GDIPLIB;
Function GdipGetLogFontW(font: PGpFont; graphics: PGpGraphics; logfontW: PLOGFONTW): TGpStatus; stdcall; external GDIPLIB;
Function GdipGetLogFont(font: PGpFont; graphics: PGpGraphics; logfontW: PLOGFONT): TGpStatus; stdcall; external GDIPLIB name
{$IFDEF Unicode}'GdipGetLogFontW'{$ELSE}'GdipGetLogFontA'{$ENDIF};

Function GdipNewInstalledFontCollection(fontCollection: PPGpFontCollection): TGpStatus; stdcall; external GDIPLIB;

Function GdipNewPrivateFontCollection(fontCollection: PPGpFontCollection): TGpStatus; stdcall; external GDIPLIB;

Function GdipDeletePrivateFontCollection(fontCollection: PPGpFontCollection): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetFontCollectionFamilyCount(fontCollection: PGpFontCollection; numFound: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetFontCollectionFamilyList(fontCollection: PGpFontCollection; numSought: INT; gpfamilies:
  PPGpFontFamily{!!pointer to array of PGpFontFamily}; numFound: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipPrivateAddFontFile(fontCollection: PGpFontCollection; filename: PWideChar): TGpStatus; stdcall; external GDIPLIB;

Function GdipPrivateAddMemoryFont(fontCollection: PGpFontCollection; memory: Pointer; length: INT): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// Text APIs
//----------------------------------------------------------------------------

Function GdipDrawString(graphics: PGpGraphics; str: PWideChar; length: INT; font: PGpFont; layoutRect: PRectF; stringFormat: PGpStringFormat;
  brush: PGpBrush): TGpStatus; stdcall; external GDIPLIB;

Function GdipMeasureString(graphics: PGpGraphics; str: PWideChar; length: INT; font: PGpFont; layoutRect: PRectF; stringFormat: PGpStringFormat;
  boundingBox: PRectF; codepointsFitted: PINT; linesFilled: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipMeasureCharacterRanges(graphics: PGpGraphics; str: PWideChar; length: INT; font: PGpFont; layoutRect: PRectF;
  stringFormat: PGpStringFormat; regionCount: INT; regions: PPGpRegion): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawDriverString(graphics: PGpGraphics; text: PUINT16; length: INT; font: PGpFont; brush: PGpBrush;
  positions: PPointF; flags: INT; matrix: PGpMatrix): TGpStatus; stdcall; external GDIPLIB;

Function GdipMeasureDriverString(graphics: PGpGraphics; text: PUINT16; length: INT; font: PGpFont; positions: PPointF;
  flags: INT; matrix: PGpMatrix; boundingBox: PRectF): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// String format APIs
//----------------------------------------------------------------------------

Function GdipCreateStringFormat(formatAttributes: INT; language: LANGID; format: PPGpStringFormat): TGpStatus; stdcall; external GDIPLIB;

Function GdipStringFormatGetGenericDefault(format: PPGpStringFormat): TGpStatus; stdcall; external GDIPLIB;

Function GdipStringFormatGetGenericTypographic(format: PPGpStringFormat): TGpStatus; stdcall; external GDIPLIB;

Function GdipDeleteStringFormat(format: PGpStringFormat): TGpStatus; stdcall; external GDIPLIB;

Function GdipCloneStringFormat(format: PGpStringFormat; newFormat: PPGpStringFormat): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetStringFormatFlags(format: PGpStringFormat; flags: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetStringFormatFlags(format: PGpStringFormat; flags: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetStringFormatAlign(format: PGpStringFormat; align: TStringAlignment): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetStringFormatAlign(format: PGpStringFormat; align: PStringAlignment): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetStringFormatLineAlign(format: PGpStringFormat; align: TStringAlignment): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetStringFormatLineAlign(format: PGpStringFormat; align: PStringAlignment): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetStringFormatTrimming(format: PGpStringFormat; trimming: TStringTrimming): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetStringFormatTrimming(format: PGpStringFormat; trimming: PStringTrimming): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetStringFormatHotkeyPrefix(format: PGpStringFormat; hotkeyPrefix: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetStringFormatHotkeyPrefix(format: PGpStringFormat; hotkeyPrefix: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetStringFormatTabStops(format: PGpStringFormat; firstTabOffset: REAL; count: INT;
  tabStops: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetStringFormatTabStops(format: PGpStringFormat; count: INT; firstTabOffset,tabStops: PREAL): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetStringFormatTabStopCount(format: PGpStringFormat; count: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetStringFormatDigitSubstitution(format: PGpStringFormat; language: LANGID;
  substitute: TStringDigitSubstitute): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetStringFormatDigitSubstitution(format: PGpStringFormat; language: PLANGID;
  substitute: PStringDigitSubstitute): TGpStatus; stdcall; external GDIPLIB;

Function GdipGetStringFormatMeasurableCharacterRangeCount(format: PGpStringFormat; count: PINT): TGpStatus; stdcall; external GDIPLIB;

Function GdipSetStringFormatMeasurableCharacterRanges(format: PGpStringFormat; rangeCount: INT;
  ranges: PCharacterRange): TGpStatus; stdcall; external GDIPLIB;

//----------------------------------------------------------------------------
// Cached Bitmap APIs
//----------------------------------------------------------------------------

Function GdipCreateCachedBitmap(bitmap: PGpBitmap; graphics: PGpGraphics; cachedBitmap: PPGpCachedBitmap): TGpStatus; stdcall; external GDIPLIB;

Function GdipDeleteCachedBitmap(cachedBitmap: PGpCachedBitmap): TGpStatus; stdcall; external GDIPLIB;

Function GdipDrawCachedBitmap(graphics: PGpGraphics; cachedBitmap: PGpCachedBitmap; x,y: INT): TGpStatus; stdcall; external GDIPLIB;

Function GdipEmfToWmfBits(hemf: HENHMETAFILE; cbData16: UINT; pData16: LPBYTE; iMapMode,eFlags: INT): UINT; stdcall; external GDIPLIB;

Function GdipSetImageAttributesCachedBackground(imageattr: PGpImageAttributes; enableFlag: BOOL): TGpStatus; stdcall; external GDIPLIB;

Function GdipTestControl(control: TGpTestControlEnum; param: Pointer): TGpStatus; stdcall; external GDIPLIB;

Function GdiplusNotificationHook(token: PULONG_PTR): TGpStatus; stdcall; external GDIPLIB;

procedure GdiplusNotificationUnhook(token: ULONG_PTR); stdcall; external GDIPLIB;

{$IF GDIPVER >= $0110}

Function GdipConvertToEmfPlus(refGraphics: PGpGraphics; metafile: PGpMetafile; conversionFailureFlag: PINT; emfType: TEmfType;
  description: PWideChar; out_metafile: PPGpMetafile): TGpStatus; stdcall; external GDIPLIB;

Function GdipConvertToEmfPlusToFile(refGraphics: PGpGraphics; metafile: PGpMetafile; conversionFailureFlag: PINT; filename: PWideChar;
   emfType: TEmfType; description: PWideChar; out_metafile: PPGpMetafile): TGpStatus; stdcall; external GDIPLIB;

Function GdipConvertToEmfPlusToStream(refGraphics: PGpGraphics; metafile: PGpMetafile; conversionFailureFlag: PINT; stream: IStream;
   emfType: TEmfType; description: PWideChar; out_metafile: PPGpMetafile): TGpStatus; stdcall; external GDIPLIB;

{$IFEND}

implementation

end.
