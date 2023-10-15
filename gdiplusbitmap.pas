(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusBitmap.h
*
* Abstract:
*
*   GDI+ Bitmap class
*
\**************************************************************************)
unit gdiplusbitmap;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows, ActiveX, Classes,
  gdiplus_common,
  gdiplusheaders, gdiplusgpstubs, gdiplustypes, gdiplusimaging, gdiplusenums,
  gdipluspixelformats, gdipluscolor, gdipluseffects, gdipluscolormatrix;

{!!=============================================================================
    TImage - class declaration
===============================================================================}
type
  TImage = class(gdiplusheaders.TImage)
  public
    constructor Create(Filename: PWideChar; UseEmbeddedColorManagement: BOOL = False); overload;
    constructor Create(const Filename: String; UseEmbeddedColorManagement: BOOL = False); overload;
  {!!
    Be warned, the following constructors are NOT equivalent to loading. The
    streams are touched only when needed, meaning the underlying objects must
    exist and must not be altered the whole time the TBitmap instance exists.
  }    
    constructor Create(Stream: IStream; UseEmbeddedColorManagement: BOOL = False); overload;
    constructor Create(Stream: TStream; UseEmbeddedColorManagement: BOOL = False); overload;
    class Function FromFile(Filename: PWideChar; UseEmbeddedColorManagement: BOOL = False): TImage; overload;
    class Function FromFile(const Filename: String; UseEmbeddedColorManagement: BOOL = False): TImage; overload;
    class Function FromStream(Stream: IStream; UseEmbeddedColorManagement: BOOL = False): TImage; overload;
    class Function FromStream(Stream: TStream; UseEmbeddedColorManagement: BOOL = False): TImage; overload;
    destructor Destroy; override;
    Function Clone: TImage;
    Function Save(Filename: PWideChar; ClsidEncoder: PCLSID; EncoderParams: PEncoderParameters = nil): TStatus; overload;
    Function Save(const Filename: String; ClsidEncoder: PCLSID; EncoderParams: PEncoderParameters = nil): TStatus; overload;
    Function Save(Stream: IStream; ClsidEncoder: PCLSID; EncoderParams: PEncoderParameters = nil): TStatus; overload;
    Function Save(Stream: TStream; ClsidEncoder: PCLSID; EncoderParams: PEncoderParameters = nil): TStatus; overload;
    Function SaveAdd(EncoderParams: PEncoderParameters): TStatus; overload;
    Function SaveAdd(NewImage: TImage; EncoderParams: PEncoderParameters): TStatus; overload;
    Function GetType: TImageType;
    Function GetPhysicalDimension(Size: PSizeF): TStatus;
    Function GetBounds(SrcRect: PRectF; SrcUnit: PUnit): TStatus;
    Function GetWidth: UINT;
    Function GetHeight: UINT;
    Function GetHorizontalResolution: REAL;
    Function GetVerticalResolution: REAL;   
    Function GetFlags: UINT;
    Function GetRawFormat(Format: PGUID): TStatus;
    Function GetPixelFormat: TPixelFormat;
    Function GetPaletteSize: INT;
    Function GetPalette(Palette: PColorPalette; Size: INT): TStatus;
    Function SetPalette(Palette: PColorPalette): TStatus; 
    Function GetThumbnailImage(ThumbWidth,ThumbHeight: UINT; Callback: TGetThumbnailImageAbort = nil; CallbackData: Pointer = nil): TImage;
    Function GetFrameDimensionsCount: UINT;
    Function GetFrameDimensionsList(DimensionsIDs: PGUID; Count: UINT): TStatus;
    Function GetFrameCount(DimensionID: PGUID): UINT;
    Function SelectActiveFrame(DimensionID: PGUID; FrameIndex: UINT): TStatus;
    Function RotateFlip(RotateFlipType: TRotateFlipType): TStatus;
    Function GetPropertyCount: UINT;
    Function GetPropertyIdList(NumOfProperty: UINT; List: PPROPID): TStatus;
    Function GetPropertyItemSize(PropId: PROPID): UINT;
    Function GetPropertyItem(PropId: PROPID; PropSize: UINT; Buffer: PPropertyItem): TStatus;
    Function GetPropertySize(TotalBufferSize,NumProperties: PUINT): TStatus;
    Function GetAllPropertyItems(TotalBufferSize,NumProperties: UINT; AllItems: PPropertyItem): TStatus;
    Function RemovePropertyItem(PropId: PROPID): TStatus;
    Function SetPropertyItem(Item: PPropertyItem): TStatus;
    Function GetEncoderParameterListSize(ClsidEncoder: PCLSID): UINT;
    Function GetEncoderParameterList(ClsidEncoder: PCLSID; Size: UINT; Buffer: PEncoderParameters): TStatus;
  {$IF GDIPVER >= $0110}
    Function FindFirstItem(Item: PImageItemData): TStatus;
    Function FindNextItem(Item: PImageItemData): TStatus;
    Function GetItemData(Item: PImageItemData): TStatus;
    Function SetAbort(PIAbort: PGdiplusAbort): TStatus;
  {$IFEND}
    Function GetLastStatus: TStatus;
  end;

{!!=============================================================================
    TBitmap - class declaration
===============================================================================}
type
  PBitmap = ^TBitmap;
  TBitmap = class(TImage)
  protected
    constructor Create(NativeBitmap: PGpBitmap); overload;
  public
    constructor Create(Filename: PWideChar; UseEmbeddedColorManagement: BOOL = False); overload;
    constructor Create(const Filename: String; UseEmbeddedColorManagement: BOOL = False); overload;
    constructor Create(Stream: IStream; UseEmbeddedColorManagement: BOOL = False); overload;
    constructor Create(Stream: TStream; UseEmbeddedColorManagement: BOOL = False); overload;
    class Function FromFile(Filename: PWideChar; UseEmbeddedColorManagement: BOOL = False): TBitmap; overload;
    class Function FromFile(const Filename: String; UseEmbeddedColorManagement: BOOL = False): TBitmap; overload;
    class Function FromStream(Stream: IStream; UseEmbeddedColorManagement: BOOL = False): TBitmap; overload;
    class Function FromStream(Stream: TStream; UseEmbeddedColorManagement: BOOL = False): TBitmap; overload;
    constructor Create(Width,Height,Stride: INT; Format: TPixelFormat; Scan0: PBYTE); overload;
    constructor Create(Width,Height: INT; Format: TPixelFormat); overload;
    constructor Create(Width,Height: INT; Target: TGraphics); overload;
    Function Clone(const Rect: TRect; Format: TPixelFormat): TBitmap; overload;
    Function Clone(X,Y,Width,Height: INT; Format: TPixelFormat): TBitmap; overload;
    Function Clone(const Rect: TRectF; Format: TPixelFormat): TBitmap; overload;
    Function Clone(X,Y,Width,Height: REAL; Format: TPixelFormat): TBitmap; overload;
    Function LockBits(const Rect: TRect; Flags: UINT; Format: TPixelFormat; LockedBitmapData: PBitmapData): TStatus;
    Function UnlockBits(LockedBitmapData: PBitmapData): TStatus;
    Function GetPixel(X,Y: INT; Color: PColor): TStatus;
    Function SetPixel(X,Y: INT; const Color: TColor): TStatus;
  {$IF GDIPVER >= $0110}
    Function ConvertFormat(Format: TPixelFormat; DitherType: TDitherType; PaletteType: TPaletteType; Palette: PColorPalette;
      AlphaThresholdPercent: REAL): TStatus;
    // The palette must be allocated and count must be set to the number of
    // entries in the palette. If there are not enough, the API will fail.
    class Function InitializePalette(
        Palette:              PColorPalette;  // Palette to initialize. output palette. must be allocated.
        PaletteType:          TPaletteType;   // palette enumeration type.
        OptimalColors:        INT;            // how many optimal colors
        UseTransparentColor:  BOOL;           // add a transparent color to the palette.
        Bitmap:               TBitmap         // optional bitmap for median cut.
      ): TStatus;
    Function ApplyEffect(Effect: TEffect; ROI: Windows.PRECT): TStatus; overload;
    class Function ApplyEffect(Inputs: PBitmap; NumInputs: INT; Effect: TEffect; ROI,OutputRect: Windows.PRECT; // optional parameter.
      Output: PBitmap): TStatus; overload;
    Function GetHistogram(Format: THistogramFormat; NumberOfEntries: UINT; Channel0,Channel1,Channel2,Channel3: PUINT): TStatus;
    class Function GetHistogramSize(Format: THistogramFormat; NumberOfEntries: PUINT): TStatus;
  {$IFEND}
    Function SetResolution(XDpi,YDpi: REAL): TStatus;
    constructor Create(Surface: IDirectDrawSurface7); overload;
    constructor Create(GdiBitmapInfo: PBITMAPINFO; GdiBitmapData: Pointer); overload;
    constructor Create(hBM: HBITMAP; hPal: HPALETTE); overload;
    constructor Create(hIcon: HICON); overload;
    constructor Create(hInstance: HINSTANCE; BitmapName: PWideChar); overload;
    constructor Create(hInstance: HINSTANCE; const BitmapName: String); overload;
    class Function FromDirectDrawSurface7(Surface: IDirectDrawSurface7): TBitmap;
    class Function FromBITMAPINFO(GdiBitmapInfo: PBITMAPINFO; GdiBitmapData: Pointer): TBitmap;
    class Function FromHBITMAP(hBM: HBITMAP; hPal: HPALETTE): TBitmap;
    class Function FromHICON(hIcon: HICON): TBitmap;
    class Function FromResource(hInstance: HINSTANCE; BitmapName: PWideChar): TBitmap; overload;
    class Function FromResource(hInstance: HINSTANCE; const BitmapName: String): TBitmap; overload;
    Function GetHBITMAP(const ColorBackground: TColor; hBMReturn: PHBITMAP): TStatus;
    Function GetHICON(hIcon: PHICON): TStatus;
  end;

  TBitmapArray = array[0..Pred(MaxInt div SizeOf(TBitmap))] of TBitmap;
  PBitmapArray = ^TBitmapArray;

implementation

uses
  StrRect,
  gdiplusflat, gdiplusmem;

{!!=============================================================================
    TImage - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TImage - public methods
-------------------------------------------------------------------------------}

constructor TImage.Create(Filename: PWideChar; UseEmbeddedColorManagement: BOOL = False);
begin
inherited Create;
fNativeImage := nil;
If UseEmbeddedColorManagement then
  fLastResult := GdipLoadImageFromFileICM(FileName,@fNativeImage)
else
  fLastResult := GdipLoadImageFromFile(FileName,@fNativeImage);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TImage.Create(const Filename: String; UseEmbeddedColorManagement: BOOL = False);
begin
Create(PWideChar(StrToWide(FileName)),UseEmbeddedColorManagement);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TImage.Create(Stream: IStream; UseEmbeddedColorManagement: BOOL = False);
begin
inherited Create;
fNativeImage := nil;
If UseEmbeddedColorManagement then
  fLastResult := GdipLoadImageFromStreamICM(Stream,@fNativeImage)
else
  fLastResult := GdipLoadImageFromStream(Stream,@fNativeImage);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TImage.Create(Stream: TStream; UseEmbeddedColorManagement: BOOL = False);
begin
{!!
  Instance of TStreamAdapter is automatically freed since it is passed as an
  ref-counted interface.
}
Create(IStream(TStreamAdapter.Create(Stream)),UseEmbeddedColorManagement);
end;

//!!----------------------------------------------------------------------------

class Function TImage.FromFile(Filename: PWideChar; UseEmbeddedColorManagement: BOOL = False): TImage;
begin
Result := TImage.Create(Filename,UseEmbeddedColorManagement);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class Function TImage.FromFile(const Filename: String; UseEmbeddedColorManagement: BOOL = False): TImage;
begin
Result := TImage.Create(Filename,UseEmbeddedColorManagement);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class Function TImage.FromStream(Stream: IStream; UseEmbeddedColorManagement: BOOL = False): TImage;
begin
Result := TImage.Create(Stream,UseEmbeddedColorManagement);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class Function TImage.FromStream(Stream: TStream; UseEmbeddedColorManagement: BOOL = False): TImage;
begin
Result := TImage.Create(Stream,UseEmbeddedColorManagement);
end;

//!!----------------------------------------------------------------------------

destructor TImage.Destroy;
begin
GdipDisposeImage(fNativeImage);
inherited;
end;

//!!----------------------------------------------------------------------------

Function TImage.Clone: TImage;
var
  CloneImage: PGpImage;
begin
CloneImage := nil;
SetStatus(GdipCloneImage(fNativeImage,@CloneImage));
Result := TImage.Create(CloneImage,fLastResult);
end;

//!!----------------------------------------------------------------------------

Function TImage.Save(Filename: PWideChar; ClsidEncoder: PCLSID; EncoderParams: PEncoderParameters = nil): TStatus;
begin
Result := SetStatus(GdipSaveImageToFile(fNativeImage,Filename,ClsidEncoder,EncoderParams));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TImage.Save(const Filename: String; ClsidEncoder: PCLSID; EncoderParams: PEncoderParameters = nil): TStatus;
begin
Result := Save(PWideChar(StrToWide(Filename)),ClsidEncoder,EncoderParams);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TImage.Save(Stream: IStream; ClsidEncoder: PCLSID; EncoderParams: PEncoderParameters = nil): TStatus;
begin
Result := SetStatus(GdipSaveImageToStream(fNativeImage,Stream,ClsidEncoder,EncoderParams));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TImage.Save(Stream: TStream; ClsidEncoder: PCLSID; EncoderParams: PEncoderParameters = nil): TStatus;
begin
Result := Save(IStream(TStreamAdapter.Create(Stream)),ClsidEncoder,EncoderParams);
end;

//!!----------------------------------------------------------------------------

Function TImage.SaveAdd(EncoderParams: PEncoderParameters): TStatus;
begin
Result := SetStatus(GdipSaveAdd(fNativeImage,EncoderParams));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TImage.SaveAdd(NewImage: TImage; EncoderParams: PEncoderParameters): TStatus;
begin
If Assigned(NewImage) then
  Result := SetStatus(GdipSaveAddImage(fNativeImage,NewImage.NativeObject,EncoderParams))
else
  Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TImage.GetType: TImageType;
begin
Result := ImageTypeUnknown;
SetStatus(GdipGetImageType(fNativeImage,@Result));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetPhysicalDimension(Size: PSizeF): TStatus;
var
  Width, Height:  REAL;
begin
If Assigned(Size) then
  begin
    Result := SetStatus(GdipGetImageDimension(fNativeImage,@Width,@Height));
    Size^.Width := Width;
    Size^.Height := Height;
  end
else Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TImage.GetBounds(SrcRect: PRectF; SrcUnit: PUnit): TStatus;
begin
Result := SetStatus(GdipGetImageBounds(fNativeImage,PGpRectF(SrcRect),PGpUnit(SrcUnit)));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetWidth: UINT;
begin
Result := 0;
SetStatus(GdipGetImageWidth(fNativeImage,@Result));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetHeight: UINT;
begin
Result := 0;
SetStatus(GdipGetImageHeight(fNativeImage,@Result));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetHorizontalResolution: REAL;
begin
Result := 0.0;
SetStatus(GdipGetImageHorizontalResolution(fNativeImage,@Result));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetVerticalResolution: REAL;
begin
Result := 0.0;
SetStatus(GdipGetImageVerticalResolution(fNativeImage,@Result));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetFlags: UINT;
begin
Result := 0;
SetStatus(GdipGetImageFlags(fNativeImage,@Result));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetRawFormat(Format: PGUID): TStatus;
begin
Result := SetStatus(GdipGetImageRawFormat(fNativeImage,Format));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetPixelFormat: TPixelFormat;
begin
SetStatus(GdipGetImagePixelFormat(fNativeImage,@Result));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetPaletteSize: INT;
begin
Result := 0;
SetStatus(GdipGetImagePaletteSize(fNativeImage,@Result));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetPalette(Palette: PColorPalette; Size: INT): TStatus;
begin
Result := SetStatus(GdipGetImagePalette(fNativeImage,Palette,Size));
end;

//!!----------------------------------------------------------------------------

Function TImage.SetPalette(Palette: PColorPalette): TStatus;
begin
Result := SetStatus(GdipSetImagePalette(fNativeImage,Palette));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetThumbnailImage(ThumbWidth,ThumbHeight: UINT; Callback: TGetThumbnailImageAbort = nil; CallbackData: Pointer = nil): TImage;
var
  ThumbImage: PGpImage;
begin
ThumbImage := nil;
SetStatus(GdipGetImageThumbnail(fNativeImage,ThumbWidth,ThumbHeight,@ThumbImage,Callback,CallbackData));
Result := TImage.Create(ThumbImage,fLastResult);
If not Assigned(Result) then
  GdipDisposeImage(ThumbImage);
end;

//!!----------------------------------------------------------------------------

Function TImage.GetFrameDimensionsCount: UINT;
begin
Result := 0;
SetStatus(GdipImageGetFrameDimensionsCount(fNativeImage,@Result));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetFrameDimensionsList(DimensionsIDs: PGUID; Count: UINT): TStatus;
begin
Result := SetStatus(GdipImageGetFrameDimensionsList(fNativeImage,DimensionsIDs,Count));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetFrameCount(DimensionID: PGUID): UINT;
begin
Result := 0;
SetStatus(GdipImageGetFrameCount(fNativeImage,DimensionID,@Result));
end;

//!!----------------------------------------------------------------------------

Function TImage.SelectActiveFrame(DimensionID: PGUID; FrameIndex: UINT): TStatus;
begin
Result := SetStatus(GdipImageSelectActiveFrame(fNativeImage,DimensionID,FrameIndex));
end;

//!!----------------------------------------------------------------------------

Function TImage.RotateFlip(RotateFlipType: TRotateFlipType): TStatus;
begin
Result := SetStatus(GdipImageRotateFlip(fNativeImage,RotateFlipType));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetPropertyCount: UINT;
begin
Result := 0;
SetStatus(GdipGetPropertyCount(fNativeImage,@Result));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetPropertyIdList(NumOfProperty: UINT; List: PPROPID): TStatus;
begin
Result := SetStatus(GdipGetPropertyIdList(fNativeImage,NumOfProperty,List));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetPropertyItemSize(PropId: PROPID): UINT;
begin
Result := 0;
SetStatus(GdipGetPropertyItemSize(fNativeImage,PropId,@Result));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetPropertyItem(PropId: PROPID; PropSize: UINT; Buffer: PPropertyItem): TStatus;
begin
Result := SetStatus(GdipGetPropertyItem(fNativeImage,PropId,PropSize,Buffer));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetPropertySize(TotalBufferSize,NumProperties: PUINT): TStatus;
begin
Result := SetStatus(GdipGetPropertySize(fNativeImage,TotalBufferSize,NumProperties));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetAllPropertyItems(TotalBufferSize,NumProperties: UINT; AllItems: PPropertyItem): TStatus;
begin
If Assigned(AllItems) then
  Result := SetStatus(GdipGetAllPropertyItems(fNativeImage,TotalBufferSize,NumProperties,AllItems))
else
  Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TImage.RemovePropertyItem(PropId: PROPID): TStatus;
begin
Result := SetStatus(GdipRemovePropertyItem(fNativeImage,PropId));
end;

//!!----------------------------------------------------------------------------

Function TImage.SetPropertyItem(Item: PPropertyItem): TStatus;
begin
Result := SetStatus(GdipSetPropertyItem(fNativeImage,Item));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetEncoderParameterListSize(ClsidEncoder: PCLSID): UINT;
begin
Result := 0;
SetStatus(GdipGetEncoderParameterListSize(fNativeImage,ClsidEncoder,@Result));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetEncoderParameterList(ClsidEncoder: PCLSID; Size: UINT; Buffer: PEncoderParameters): TStatus;
begin
Result := SetStatus(GdipGetEncoderParameterList(fNativeImage,ClsidEncoder,Size,Buffer));
end;

{$IF GDIPVER >= $0110}
//!!----------------------------------------------------------------------------

Function TImage.FindFirstItem(Item: PImageItemData): TStatus;
begin
Result := SetStatus(GdipFindFirstImageItem(fNativeImage,Item));
end;

//!!----------------------------------------------------------------------------

Function TImage.FindNextItem(Item: PImageItemData): TStatus;
begin
Result := SetStatus(GdipFindNextImageItem(fNativeImage,Item));
end;

//!!----------------------------------------------------------------------------

Function TImage.GetItemData(Item: PImageItemData): TStatus;
begin
Result := SetStatus(GdipGetImageItemData(fNativeImage,Item));
end;

//!!----------------------------------------------------------------------------

Function TImage.SetAbort(PIAbort: PGdiplusAbort): TStatus;
begin
Result := SetStatus(GdipImageSetAbort(fNativeImage,PIAbort));
end;

{$IFEND}
//!!----------------------------------------------------------------------------

Function TImage.GetLastStatus: TStatus;
begin
Result := fLastResult;
fLastResult := Ok;
end;


{!!=============================================================================
    TBitmap - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TBitmap - protected methods
-------------------------------------------------------------------------------}

constructor TBitmap.Create(NativeBitmap: PGpBitmap);
begin
inherited Create;
fLastResult := Ok;
SetNativeImage(PGpImage(NativeBitmap));
end;

{!!-----------------------------------------------------------------------------
    TBitmap - public methods
-------------------------------------------------------------------------------}

constructor TBitmap.Create(Filename: PWideChar; UseEmbeddedColorManagement: BOOL = False);
var
  Bitmap: PGpBitmap;
begin
inherited Create;
Bitmap := nil;
If UseEmbeddedColorManagement then
  fLastResult := GdipCreateBitmapFromFileICM(Filename,@Bitmap)
else
  fLastResult := GdipCreateBitmapFromFile(Filename,@Bitmap);
SetNativeImage(PGpImage(Bitmap));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TBitmap.Create(const Filename: String; UseEmbeddedColorManagement: BOOL = False);
begin
Create(PwideChar(StrToWide(Filename)),UseEmbeddedColorManagement);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TBitmap.Create(Stream: IStream; UseEmbeddedColorManagement: BOOL = False);
var
  Bitmap: PGpBitmap;
begin
inherited Create;
Bitmap := nil;
If UseEmbeddedColorManagement then
  fLastResult := GdipCreateBitmapFromStreamICM(Stream,@Bitmap)
else
  fLastResult := GdipCreateBitmapFromStream(Stream,@Bitmap);
SetNativeImage(PGpImage(Bitmap));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TBitmap.Create(Stream: TStream; UseEmbeddedColorManagement: BOOL = False);
begin
Create(IStream(TStreamAdapter.Create(Stream)),UseEmbeddedColorManagement);
end;

//!!----------------------------------------------------------------------------

class Function TBitmap.FromFile(Filename: PWideChar; UseEmbeddedColorManagement: BOOL = False): TBitmap;
begin
Result := TBitmap.Create(Filename,UseEmbeddedColorManagement);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class Function TBitmap.FromFile(const Filename: String; UseEmbeddedColorManagement: BOOL = False): TBitmap;
begin
Result := TBitmap.Create(Filename,UseEmbeddedColorManagement);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class Function TBitmap.FromStream(Stream: IStream; UseEmbeddedColorManagement: BOOL = False): TBitmap;
begin
Result := TBitmap.Create(Stream,UseEmbeddedColorManagement);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class Function TBitmap.FromStream(Stream: TStream; UseEmbeddedColorManagement: BOOL = False): TBitmap;
begin
Result := TBitmap.Create(Stream,UseEmbeddedColorManagement);
end;

//!!----------------------------------------------------------------------------

constructor TBitmap.Create(Width,Height,Stride: INT; Format: TPixelFormat; Scan0: PBYTE);
var
  Bitmap: PGpBitmap;
begin
inherited Create;
Bitmap := nil;
fLastResult := GdipCreateBitmapFromScan0(Width,Height,Stride,Format,Scan0,@Bitmap);
SetNativeImage(PGpImage(Bitmap));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TBitmap.Create(Width,Height: INT; Format: TPixelFormat);
var
  Bitmap: PGpBitmap;
begin
inherited Create;
Bitmap := nil;
fLastResult := GdipCreateBitmapFromScan0(Width,Height,0,Format,nil,@Bitmap);
SetNativeImage(PGpImage(Bitmap));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TBitmap.Create(Width,Height: INT; Target: TGraphics);
var
  Bitmap: PGpBitmap;
begin
inherited Create;
Bitmap := nil;
fLastResult := GdipCreateBitmapFromGraphics(Width,Height,Target.NativeObject,@Bitmap);
SetNativeImage(PGpImage(Bitmap));
end;

//!!----------------------------------------------------------------------------

Function TBitmap.Clone(const Rect: TRect; Format: TPixelFormat): TBitmap;
begin
Result := Clone(Rect.X,Rect.Y,Rect.Width,Rect.Height,Format);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TBitmap.Clone(X,Y,Width,Height: INT; Format: TPixelFormat): TBitmap;
var
  GpDstBitmap:  PGpBitmap;
begin
GpDstBitmap := nil;
If SetStatus(GdipCloneBitmapAreaI(X,Y,Width,Height,Format,PGpBitmap(fNativeImage),@GpDstBitmap)) = Ok then
  begin
    Result := TBitmap.Create(GpDstBitmap);
    If not Assigned(Result) then
      GdipDisposeImage(PGpImage(GpDstBitmap));
  end
else Result := nil;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TBitmap.Clone(const Rect: TRectF; Format: TPixelFormat): TBitmap;
begin
Result := Clone(Rect.X,Rect.Y,Rect.Width,Rect.Height,Format);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TBitmap.Clone(X,Y,Width,Height: REAL; Format: TPixelFormat): TBitmap;
var
  GpDstBitmap:  PGpBitmap;
begin
GpDstBitmap := nil;
If SetStatus(GdipCloneBitmapArea(X,Y,Width,Height,Format,PGpBitmap(fNativeImage),@GpDstBitmap)) = Ok then
  begin
    Result := TBitmap.Create(GpDstBitmap);
    If not Assigned(Result) then
      GdipDisposeImage(PGpImage(GpDstBitmap));
  end
else Result := nil;
end;

//!!----------------------------------------------------------------------------

Function TBitmap.LockBits(const Rect: TRect; Flags: UINT; Format: TPixelFormat; LockedBitmapData: PBitmapData): TStatus;
begin
Result := SetStatus(GdipBitmapLockBits(PGpBitmap(fNativeImage),@Rect,Flags,Format,LockedBitmapData));
end;

//!!----------------------------------------------------------------------------

Function TBitmap.UnlockBits(LockedBitmapData: PBitmapData): TStatus;
begin
Result := SetStatus(GdipBitmapUnlockBits(PGpBitmap(fNativeImage),LockedBitmapData));
end;

//!!----------------------------------------------------------------------------

Function TBitmap.GetPixel(X,Y: INT; Color: PColor): TStatus;
var
  Argb: TARGB;
begin
Result := SetStatus(GdipBitmapGetPixel(PGpBitmap(fNativeImage),X,Y,@Argb));
If Result = Ok  then
  SetValue(Color^,Argb);
end;

//!!----------------------------------------------------------------------------

Function TBitmap.SetPixel(X,Y: INT; const Color: TColor): TStatus;
begin
Result := SetStatus(GdipBitmapSetPixel(PGpBitmap(fNativeImage),X,Y,GetValue(Color)));
end;

{$IF GDIPVER >= $0110}
//!!----------------------------------------------------------------------------

Function TBitmap.ConvertFormat(Format: TPixelFormat; DitherType: TDitherType; PaletteType: TPaletteType; Palette: PColorPalette;
  AlphaThresholdPercent: REAL): TStatus;
begin
Result := SetStatus(GdipBitmapConvertFormat(PGpBitmap(fNativeImage),Format,DitherType,
  PaletteType,Palette,AlphaThresholdPercent));
end;

//!!----------------------------------------------------------------------------

class Function TBitmap.InitializePalette(Palette: PColorPalette; PaletteType: TPaletteType; OptimalColors: INT;
  UseTransparentColor: BOOL; Bitmap: TBitmap): TStatus;
begin
Result := GdipInitializePalette(Palette,PaletteType,OptimalColors,UseTransparentColor,Bitmap.NativeObject);
end;

//!!----------------------------------------------------------------------------
type
  TEffect_ = class(TEffect);  {$message 'remove when joining'} 

Function TBitmap.ApplyEffect(Effect: TEffect; ROI: Windows.PRECT): TStatus;
begin
If Assigned(TEffect_(Effect).fAuxData) then
  begin
    GdipFree(TEffect_(Effect).fAuxData);
    TEffect_(Effect).fAuxData := nil;
    TEffect_(Effect).fAuxDataSize := 0;
  end;
Result := GdipBitmapApplyEffect(PGpBitmap(fNativeImage),Effect.NativeObject,ROI,TEffect_(Effect).fUseAuxData,
  Addr(TEffect_(Effect).fAuxData),Addr(TEffect_(Effect).fAuxDataSize));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class Function TBitmap.ApplyEffect(Inputs: PBitmap; NumInputs: INT; Effect: TEffect; ROI,OutputRect: Windows.PRECT; Output: PBitmap): TStatus;
var
  OutputNative: PGpBitmap;
  NativeInputs: array of PGpBitmap;
  i:            Integer;
begin
If NumInputs >= 0 then
  begin
    OutputNative := nil;
    SetLength(NativeInputs,NumInputs);
    If Length(NativeInputs) > 0 then
      begin
        For i := 0 to Pred(NumInputs) do
          NativeInputs[i] := PBitmapArray(Inputs)^[i].NativeObject;
        If Assigned(TEffect_(Effect).fAuxData) then
          begin
            GdipFree(TEffect_(Effect).fAuxData);
            TEffect_(Effect).fAuxData := nil;
            TEffect_(Effect).fAuxDataSize := 0;
          end;
        Result := GdipBitmapCreateApplyEffect(Pointer(NativeInputs),NumInputs,Effect.NativeObject,ROI,OutputRect,@OutputNative,
          TEffect_(Effect).fUseAuxData,Addr(TEffect_(Effect).fAuxData),Addr(TEffect_(Effect).fAuxDataSize));
        If (Result = Ok) and Assigned(OutputNative) then
          begin
            Output^ := TBitmap.Create(OutputNative);
            If not Assigned(Output^) then
              begin
                Result := OutOfMemory;
                GdipDisposeImage(PGpImage(OutputNative));
              end;
          end
        else Output^ := nil;
        SetLength(NativeInputs,0);
      end
    else Result := OutOfMemory;
  end
else Result := InvalidParameter;
end;

//!!----------------------------------------------------------------------------

Function TBitmap.GetHistogram(Format: THistogramFormat; NumberOfEntries: UINT; Channel0,Channel1,Channel2,Channel3: PUINT): TStatus;
begin
Result := GdipBitmapGetHistogram(PGpBitmap(fNativeImage),Format,NumberOfEntries,Channel0,Channel1,Channel2,Channel3);
end;

//!!----------------------------------------------------------------------------

class Function TBitmap.GetHistogramSize(Format: THistogramFormat; NumberOfEntries: PUINT): TStatus;
begin
Result := GdipBitmapGetHistogramSize(Format,NumberOfEntries);
end;

{$IFEND}
//!!----------------------------------------------------------------------------

Function TBitmap.SetResolution(XDpi,YDpi: REAL): TStatus;
begin
Result := SetStatus(GdipBitmapSetResolution(PGpBitmap(fNativeImage),XDpi,YDpi));
end;

//!!----------------------------------------------------------------------------

constructor TBitmap.Create(Surface: IDirectDrawSurface7);
var
  Bitmap: PGpBitmap;
begin
inherited Create;
Bitmap := nil;
fLastResult := GdipCreateBitmapFromDirectDrawSurface(Surface,@Bitmap);
SetNativeImage(PGpImage(Bitmap));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TBitmap.Create(GdiBitmapInfo: PBITMAPINFO; GdiBitmapData: Pointer);
var
  Bitmap: PGpBitmap;
begin
inherited Create;
Bitmap := nil;
fLastResult := GdipCreateBitmapFromGdiDib(GdiBitmapInfo,GdiBitmapData,@Bitmap);
SetNativeImage(PGpImage(Bitmap));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TBitmap.Create(hBM: HBITMAP; hPal: HPALETTE);
var
  Bitmap: PGpBitmap;
begin
inherited Create;
Bitmap := nil;
fLastResult := GdipCreateBitmapFromHBITMAP(hBM,hPal,@Bitmap);
SetNativeImage(PGpImage(Bitmap));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TBitmap.Create(hIcon: HICON);
var
  Bitmap: PGpBitmap;
begin
inherited Create;
Bitmap := nil;
fLastResult := GdipCreateBitmapFromHICON(hIcon,@Bitmap);
SetNativeImage(PGpImage(Bitmap));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TBitmap.Create(hInstance: HINSTANCE; BitmapName: PWideChar);
var
  Bitmap: PGpBitmap;
begin
inherited Create;
Bitmap := nil;
fLastResult := GdipCreateBitmapFromResource(hInstance,BitmapName,@Bitmap);
SetNativeImage(PGpImage(Bitmap));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TBitmap.Create(hInstance: HINSTANCE; const BitmapName: String);
begin
Create(hInstance,PWideChar(StrToWide(BitmapName)));
end;

//!!----------------------------------------------------------------------------

class Function TBitmap.FromDirectDrawSurface7(Surface: IDirectDrawSurface7): TBitmap;
begin
Result := TBitmap.Create(Surface);
end;

//!!----------------------------------------------------------------------------

class Function TBitmap.FromBITMAPINFO(GdiBitmapInfo: PBITMAPINFO; GdiBitmapData: Pointer): TBitmap;
begin
Result := TBitmap.Create(GdiBitmapInfo,GdiBitmapData);
end;

//!!----------------------------------------------------------------------------

class Function TBitmap.FromHBITMAP(hBM: HBITMAP; hPal: HPALETTE): TBitmap;
begin
Result := TBitmap.Create(hBM,hPal);
end;

//!!----------------------------------------------------------------------------

class Function TBitmap.FromHICON(hIcon: HICON): TBitmap;
begin
Result := TBitmap.Create(hIcon);
end;

//!!----------------------------------------------------------------------------

class Function TBitmap.FromResource(hInstance: HINSTANCE; BitmapName: PWideChar): TBitmap;
begin
Result := TBitmap.Create(hInstance,BitmapName);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class Function TBitmap.FromResource(hInstance: HINSTANCE; const BitmapName: String): TBitmap;
begin
Result := TBitmap.Create(hInstance,BitmapName);
end;

//!!----------------------------------------------------------------------------

Function TBitmap.GetHBITMAP(const ColorBackground: TColor; hBMReturn: PHBITMAP): TStatus;
begin
Result := SetStatus(GdipCreateHBITMAPFromBitmap(PGpBitmap(fNativeImage),hBMReturn,GetValue(ColorBackground)));
end;

//!!----------------------------------------------------------------------------

Function TBitmap.GetHICON(hIcon: PHICON): TStatus;
begin
Result := SetStatus(GdipCreateHICONFromBitmap(PGpBitmap(fNativeImage),hIcon));
end;

end.
