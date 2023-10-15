(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusMetafile.h
*
* Abstract:
*
*   GDI+ Metafile class
*
\**************************************************************************)
unit gdiplusmetafile;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows, ActiveX, Classes,
  AuxTypes,
  gdiplus_common,
  gdiplusheaders, gdiplusmetaheader, gdiplusenums, gdiplustypes;

{!!=============================================================================
    TMetafile - class declaration
===============================================================================}
type
  TMetafile = class(gdiplusheaders.TMetafile)
  protected
    constructor Create; overload;
  public
    // Playback a metafile from a HMETAFILE
    // If deleteWmf is TRUE, then when the metafile is deleted,
    // the hWmf will also be deleted.  Otherwise, it won't be.
    constructor Create(HWmf: HMETAFILE; WmfPlaceableFileHeader: PWmfPlaceableFileHeader; DeleteWmf: BOOL = FALSE); overload;
    // Playback a metafile from a HENHMETAFILE
    // If deleteEmf is TRUE, then when the metafile is deleted,
    // the hEmf will also be deleted.  Otherwise, it won't be.
    constructor Create(HEmf: HENHMETAFILE; DeleteWmf: BOOL = FALSE); overload;
    constructor Create(Filename: PWideChar); overload;
    constructor Create(const Filename: String); overload;
    // Playback a WMF metafile from a file.
    constructor Create(Filename: PWideChar; WmfPlaceableFileHeader: PWmfPlaceableFileHeader); overload;
    constructor Create(const Filename: String; WmfPlaceableFileHeader: PWmfPlaceableFileHeader); overload;
    constructor Create(Stream: IStream); overload;
    constructor Create(Stream: TStream); overload;
    // Record a metafile to memory.
    constructor Create(ReferenceHdc: HDC; EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil); overload;
    constructor Create(ReferenceHdc: HDC; EmfType: TEmfType; const Description: String); overload;
    // Record a metafile to memory.
    constructor Create(ReferenceHdc: HDC; const FrameRect: TRectF; FrameUnit: TMetafileFrameUnit = MetafileFrameUnitGdi;
      EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil); overload;
    constructor Create(ReferenceHdc: HDC; const FrameRect: TRectF; FrameUnit: TMetafileFrameUnit; EmfType: TEmfType;
      const Description: String); overload;
    // Record a metafile to memory.
    constructor Create(ReferenceHdc: HDC; const FrameRect: TRect; FrameUnit: TMetafileFrameUnit = MetafileFrameUnitGdi;
      EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil); overload;
    constructor Create(ReferenceHdc: HDC; const FrameRect: TRect; FrameUnit: TMetafileFrameUnit; EmfType: TEmfType;
      const Description: String); overload;
    constructor Create(Filename: PWideChar; ReferenceHdc: HDC; EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil); overload;
    constructor Create(const Filename: String; ReferenceHdc: HDC; EmfType: TEmfType; const Description: String); overload;
    constructor Create(Filename: PWideChar; ReferenceHdc: HDC; const FrameRect: TRectF; FrameUnit: TMetafileFrameUnit = MetafileFrameUnitGdi;
      EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil); overload;
    constructor Create(const Filename: String; ReferenceHdc: HDC; const FrameRect: TRectF; FrameUnit: TMetafileFrameUnit; EmfType: TEmfType;
      const Description: String); overload;
    constructor Create(Filename: PWideChar; ReferenceHdc: HDC; const FrameRect: TRect; FrameUnit: TMetafileFrameUnit = MetafileFrameUnitGdi;
      EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil); overload;
    constructor Create(const Filename: String; ReferenceHdc: HDC; const FrameRect: TRect; FrameUnit: TMetafileFrameUnit; EmfType: TEmfType;
      const Description: String); overload;
    constructor Create(Stream: IStream; ReferenceHdc: HDC; EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil); overload;
    constructor Create(Stream: TStream; ReferenceHdc: HDC; EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil); overload;
    constructor Create(Stream: IStream; ReferenceHdc: HDC; EmfType: TEmfType; const Description: String); overload;
    constructor Create(Stream: TStream; ReferenceHdc: HDC; EmfType: TEmfType; const Description: String); overload;
    constructor Create(Stream: IStream; ReferenceHdc: HDC; const FrameRect: TRectF; FrameUnit: TMetafileFrameUnit = MetafileFrameUnitGdi;
      EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil); overload;
    constructor Create(Stream: TStream; ReferenceHdc: HDC; const FrameRect: TRectF; FrameUnit: TMetafileFrameUnit = MetafileFrameUnitGdi;
      EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil); overload;
    constructor Create(Stream: IStream; ReferenceHdc: HDC; const FrameRect: TRectF; FrameUnit: TMetafileFrameUnit; EmfType: TEmfType;
      const Description: String); overload;
    constructor Create(Stream: TStream; ReferenceHdc: HDC; const FrameRect: TRectF; FrameUnit: TMetafileFrameUnit; EmfType: TEmfType;
      const Description: String); overload;
    constructor Create(Stream: IStream; ReferenceHdc: HDC; const FrameRect: TRect; FrameUnit: TMetafileFrameUnit = MetafileFrameUnitGdi;
      EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil); overload;
    constructor Create(Stream: TStream; ReferenceHdc: HDC; const FrameRect: TRect; FrameUnit: TMetafileFrameUnit = MetafileFrameUnitGdi;
      EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil); overload;
    constructor Create(Stream: IStream; ReferenceHdc: HDC; const FrameRect: TRect; FrameUnit: TMetafileFrameUnit; EmfType: TEmfType;
      const Description: String); overload;
    constructor Create(Stream: TStream; ReferenceHdc: HDC; const FrameRect: TRect; FrameUnit: TMetafileFrameUnit; EmfType: TEmfType;
      const Description: String); overload;
    class Function GetMetafileHeader(HWmf: HMETAFILE; WmfPlaceableFileHeader: PWmfPlaceableFileHeader; Header: PMetafileHeader): TStatus; overload;
    class Function GetMetafileHeader(HEmf: HENHMETAFILE; Header: PMetafileHeader): TStatus; overload;
    class Function GetMetafileHeader(Filename: PWideChar; Header: PMetafileHeader): TStatus; overload;
    class Function GetMetafileHeader(const Filename: String; Header: PMetafileHeader): TStatus; overload;
    class Function GetMetafileHeader(Stream: IStream; Header: PMetafileHeader): TStatus; overload;
    class Function GetMetafileHeader(Stream: TStream; Header: PMetafileHeader): TStatus; overload;
    Function GetMetafileHeader(Header: PMetafileHeader): TStatus; overload;
    // Once this method is called, the Metafile object is in an invalid state
    // and can no longer be used.  It is the responsiblity of the caller to
    // invoke DeleteEnhMetaFile to delete this hEmf.
    Function GetHENHMETAFILE: HENHMETAFILE;
    // Used in conjuction with Graphics::EnumerateMetafile to play an EMF+
    // The data must be DWORD aligned if it's an EMF or EMF+.  It must be
    // WORD aligned if it's a WMF.
    Function PlayRecord(RecordType: TEmfPlusRecordType; Flags,DataSize: UINT; Data: PBYTE): TStatus;
    // If you're using a printer HDC for the metafile, but you want the
    // metafile rasterized at screen resolution, then use this API to set
    // the rasterization dpi of the metafile to the screen resolution,
    // e.g. 96 dpi or 120 dpi.
    Function SetDownLevelRasterizationLimit(MetafileRasterizationLimitDpi: UINT): TStatus;
    Function GetDownLevelRasterizationLimit: UINT;
    class Function EmfToWmfBits(hEmf: HENHMETAFILE; cbData16: UINT16; pData16: LPBYTE; iMapMode: INT = MM_ANISOTROPIC;
      eFlags: INT = EmfToWmfBitsFlagsDefault): UINT;
  {$IF GDIPVER >= $0110}
    Function ConvertToEmfPlus(RefGraphics: TGraphics; ConversionFailureFlag: PINT = nil;
      EmfType: TEmfType = EmfTypeEmfPlusOnly; Description: PWideChar = nil): TStatus; overload;
    Function ConvertToEmfPlus(RefGraphics: TGraphics; ConversionFailureFlag: PINT;
      EmfType: TEmfType; const Description: String): TStatus; overload;
    Function ConvertToEmfPlus(RefGraphics: TGraphics; Filename: PWideChar; ConversionFailureFlag: PINT = nil;
      EmfType: TEmfType = EmfTypeEmfPlusOnly; Description: PWideChar = nil): TStatus; overload;
    Function ConvertToEmfPlus(RefGraphics: TGraphics; const Filename: String; ConversionFailureFlag: PINT;
      EmfType: TEmfType; const Description: String): TStatus; overload;
    Function ConvertToEmfPlus(RefGraphics: TGraphics; Stream: IStream; ConversionFailureFlag: PINT = nil;
      EmfType: TEmfType = EmfTypeEmfPlusOnly; Description: PWideChar = nil): TStatus; overload;
    Function ConvertToEmfPlus(RefGraphics: TGraphics; Stream: TStream; ConversionFailureFlag: PINT = nil;
      EmfType: TEmfType = EmfTypeEmfPlusOnly; Description: PWideChar = nil): TStatus; overload;
    Function ConvertToEmfPlus(RefGraphics: TGraphics; Stream: IStream; ConversionFailureFlag: PINT;
      EmfType: TEmfType; const Description: String): TStatus; overload;
    Function ConvertToEmfPlus(RefGraphics: TGraphics; Stream: TStream; ConversionFailureFlag: PINT;
      EmfType: TEmfType; const Description: String): TStatus; overload;
  {$IFEND}
  end;

implementation

uses
  StrRect,
  gdiplusflat, gdiplusgpstubs;

{!!=============================================================================
    TMetafile - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TMetafile - protected methods
-------------------------------------------------------------------------------}

constructor TMetafile.Create;
begin
inherited Create;
SetNativeImage(nil);
fLastResult := Ok;
end;

{!!-----------------------------------------------------------------------------
    TMetafile - public methods
-------------------------------------------------------------------------------}

constructor TMetafile.Create(HWmf: HMETAFILE; WmfPlaceableFileHeader: PWmfPlaceableFileHeader; DeleteWmf: BOOL = FALSE);
var
  Metafile: PGpMetafile;
begin
Create;
Metafile := nil;
fLastResult := GdipCreateMetafileFromWmf(HWmf,DeleteWmf,WmfPlaceableFileHeader,@MetaFile);
SetNativeImage(PGpImage(MetaFile));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(HEmf: HENHMETAFILE; DeleteWmf: BOOL = FALSE);
var
  Metafile: PGpMetafile;
begin
Create;
Metafile := nil;
fLastResult := GdipCreateMetafileFromEmf(HEmf,DeleteWmf,@MetaFile);
SetNativeImage(PGpImage(MetaFile));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Filename: PWideChar);
var
  Metafile: PGpMetafile;
begin
Create;
Metafile := nil;
fLastResult := GdipCreateMetafileFromFile(Filename,@MetaFile);
SetNativeImage(PGpImage(MetaFile));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(const Filename: String);
begin
Create(PWideChar(StrToWide(Filename)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Filename: PWideChar; WmfPlaceableFileHeader: PWmfPlaceableFileHeader);
var
  Metafile: PGpMetafile;
begin
Create;
Metafile := nil;
fLastResult := GdipCreateMetafileFromWmfFile(Filename,WmfPlaceableFileHeader,@MetaFile);
SetNativeImage(PGpImage(MetaFile));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(const Filename: String; WmfPlaceableFileHeader: PWmfPlaceableFileHeader);
begin
Create(PWideChar(StrToWide(Filename)),WmfPlaceableFileHeader);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Stream: IStream);
var
  Metafile: PGpMetafile;
begin
Create;
Metafile := nil;
fLastResult := GdipCreateMetafileFromStream(Stream,@MetaFile);
SetNativeImage(PGpImage(MetaFile));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Stream: TStream);
begin
Create(IStream(TStreamAdapter.Create(Stream)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(ReferenceHdc: HDC; EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil);
var
  Metafile: PGpMetafile;
begin
Create;
Metafile := nil;
fLastResult := GdipRecordMetafile(ReferenceHDC,EmfType,nil,MetafileFrameUnitGdi,Description,@MetaFile);
SetNativeImage(PGpImage(MetaFile));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(ReferenceHdc: HDC; EmfType: TEmfType; const Description: String);
begin
Create(ReferenceHdc,EmfType,PWideChar(StrToWide(Description)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(ReferenceHdc: HDC; const FrameRect: TRectF; FrameUnit: TMetafileFrameUnit = MetafileFrameUnitGdi;
  EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil);
var
  Metafile: PGpMetafile;
begin
Create;
Metafile := nil;
fLastResult := GdipRecordMetafile(ReferenceHDC,EmfType,@FrameRect,FrameUnit,Description,@MetaFile);
SetNativeImage(PGpImage(MetaFile));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(ReferenceHdc: HDC; const FrameRect: TRectF; FrameUnit: TMetafileFrameUnit; EmfType: TEmfType;
  const Description: String);
begin
Create(ReferenceHdc,FrameRect,FrameUnit,EmfType,PWideChar(StrToWide(Description)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(ReferenceHdc: HDC; const FrameRect: TRect; FrameUnit: TMetafileFrameUnit = MetafileFrameUnitGdi;
  EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil);
var
  Metafile: PGpMetafile;
begin
Create;
Metafile := nil;
fLastResult := GdipRecordMetafileI(ReferenceHDC,EmfType,@FrameRect,FrameUnit,Description,@MetaFile);
SetNativeImage(PGpImage(MetaFile));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(ReferenceHdc: HDC; const FrameRect: TRect; FrameUnit: TMetafileFrameUnit; EmfType: TEmfType;
  const Description: String);
begin
Create(ReferenceHdc,FrameRect,FrameUnit,EmfType,PWideChar(StrToWide(Description)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
constructor TMetafile.Create(Filename: PWideChar; ReferenceHdc: HDC; EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil);
var
  Metafile: PGpMetafile;
begin
Create;
Metafile := nil;
fLastResult := GdipRecordMetafileFileName(Filename,ReferenceHDC,EmfType,nil,MetafileFrameUnitGdi,Description,@MetaFile);
SetNativeImage(PGpImage(MetaFile));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(const Filename: String; ReferenceHdc: HDC; EmfType: TEmfType; const Description: String);
begin
Create(PWideChar(StrToWide(Filename)),ReferenceHdc,EmfType,PWideChar(StrToWide(Description)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Filename: PWideChar; ReferenceHdc: HDC; const FrameRect: TRectF; FrameUnit: TMetafileFrameUnit = MetafileFrameUnitGdi;
  EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil);
var
  Metafile: PGpMetafile;
begin
Create;
Metafile := nil;
fLastResult := GdipRecordMetafileFileName(Filename,ReferenceHDC,EmfType,@FrameRect,FrameUnit,Description,@MetaFile);
SetNativeImage(PGpImage(MetaFile));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(const Filename: String; ReferenceHdc: HDC; const FrameRect: TRectF; FrameUnit: TMetafileFrameUnit; EmfType: TEmfType;
  const Description: String);
begin
Create(PWideChar(StrToWide(Filename)),ReferenceHdc,FrameRect,FrameUnit,EmfType,PWideChar(StrToWide(Description)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Filename: PWideChar; ReferenceHdc: HDC; const FrameRect: TRect; FrameUnit: TMetafileFrameUnit = MetafileFrameUnitGdi;
  EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil);
var
  Metafile: PGpMetafile;
begin
Create;
Metafile := nil;
fLastResult := GdipRecordMetafileFileNameI(Filename,ReferenceHDC,EmfType,@FrameRect,FrameUnit,Description,@MetaFile);
SetNativeImage(PGpImage(MetaFile));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(const Filename: String; ReferenceHdc: HDC; const FrameRect: TRect; FrameUnit: TMetafileFrameUnit; EmfType: TEmfType;
  const Description: String);
begin
Create(PWideChar(StrToWide(Filename)),ReferenceHdc,FrameRect,FrameUnit,EmfType,PWideChar(StrToWide(Description)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Stream: IStream; ReferenceHdc: HDC; EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil);
var
  Metafile: PGpMetafile;
begin
Create;
Metafile := nil;
fLastResult := GdipRecordMetafileStream(Stream,ReferenceHDC,EmfType,nil,MetafileFrameUnitGdi,Description,@MetaFile);
SetNativeImage(PGpImage(MetaFile));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Stream: TStream; ReferenceHdc: HDC; EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil);
begin
Create(IStream(TStreamAdapter.Create(Stream)),ReferenceHdc,EmfType,Description);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Stream: IStream; ReferenceHdc: HDC; EmfType: TEmfType; const Description: String);
begin
Create(Stream,ReferenceHdc,EmfType,PWideChar(StrToWide(Description)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Stream: TStream; ReferenceHdc: HDC; EmfType: TEmfType; const Description: String);
begin
Create(IStream(TStreamAdapter.Create(Stream)),ReferenceHdc,EmfType,PWideChar(StrToWide(Description)));
end;      

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Stream: IStream; ReferenceHdc: HDC; const FrameRect: TRectF; FrameUnit: TMetafileFrameUnit = MetafileFrameUnitGdi;
  EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil);
var
  Metafile: PGpMetafile;
begin
Create;
Metafile := nil;
fLastResult := GdipRecordMetafileStream(Stream,ReferenceHDC,EmfType,@FrameRect,FrameUnit,Description,@MetaFile);
SetNativeImage(PGpImage(MetaFile));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Stream: TStream; ReferenceHdc: HDC; const FrameRect: TRectF; FrameUnit: TMetafileFrameUnit = MetafileFrameUnitGdi;
  EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil);
begin
Create(IStream(TStreamAdapter.Create(Stream)),ReferenceHdc,FrameRect,FrameUnit,EmfType,Description);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Stream: IStream; ReferenceHdc: HDC; const FrameRect: TRectF; FrameUnit: TMetafileFrameUnit; EmfType: TEmfType;
  const Description: String);
begin
Create(Stream,ReferenceHdc,FrameRect,FrameUnit,EmfType,PWideChar(StrToWide(Description)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Stream: TStream; ReferenceHdc: HDC; const FrameRect: TRectF; FrameUnit: TMetafileFrameUnit; EmfType: TEmfType;
  const Description: String);
begin
Create(IStream(TStreamAdapter.Create(Stream)),ReferenceHdc,FrameRect,FrameUnit,EmfType,PWideChar(StrToWide(Description)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Stream: IStream; ReferenceHdc: HDC; const FrameRect: TRect; FrameUnit: TMetafileFrameUnit = MetafileFrameUnitGdi;
  EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil);
var
  Metafile: PGpMetafile;
begin
Create;
Metafile := nil;
fLastResult := GdipRecordMetafileStreamI(Stream,ReferenceHDC,EmfType,@FrameRect,FrameUnit,Description,@MetaFile);
SetNativeImage(PGpImage(MetaFile));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Stream: TStream; ReferenceHdc: HDC; const FrameRect: TRect; FrameUnit: TMetafileFrameUnit = MetafileFrameUnitGdi;
  EmfType: TEmfType = EmfTypeEmfPlusDual; Description: PWideChar = nil);
begin
Create(IStream(TStreamAdapter.Create(Stream)),ReferenceHdc,FrameRect,FrameUnit,EmfType,Description);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Stream: IStream; ReferenceHdc: HDC; const FrameRect: TRect; FrameUnit: TMetafileFrameUnit; EmfType: TEmfType;
  const Description: String);
begin
Create(Stream,ReferenceHdc,FrameRect,FrameUnit,EmfType,PWideChar(StrToWide(Description)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TMetafile.Create(Stream: TStream; ReferenceHdc: HDC; const FrameRect: TRect; FrameUnit: TMetafileFrameUnit; EmfType: TEmfType;
  const Description: String);
begin
Create(IStream(TStreamAdapter.Create(Stream)),ReferenceHdc,FrameRect,FrameUnit,EmfType,PWideChar(StrToWide(Description)));
end;

//!!----------------------------------------------------------------------------

class Function TMetafile.GetMetafileHeader(HWmf: HMETAFILE; WmfPlaceableFileHeader: PWmfPlaceableFileHeader; Header: PMetafileHeader): TStatus;
begin
Result := GdipGetMetafileHeaderFromWmf(HWmf,WmfPlaceableFileHeader,Header);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class Function TMetafile.GetMetafileHeader(HEmf: HENHMETAFILE; Header: PMetafileHeader): TStatus;
begin
Result := GdipGetMetafileHeaderFromEmf(HEmf,Header);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class Function TMetafile.GetMetafileHeader(Filename: PWideChar; Header: PMetafileHeader): TStatus;
begin
Result := GdipGetMetafileHeaderFromFile(Filename,Header);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class Function TMetafile.GetMetafileHeader(const Filename: String; Header: PMetafileHeader): TStatus;
begin
Result := GetMetafileHeader(PWideChar(StrToWide(FileName)),Header);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class Function TMetafile.GetMetafileHeader(Stream: IStream; Header: PMetafileHeader): TStatus;
begin
Result := GdipGetMetafileHeaderFromStream(Stream,Header);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class Function TMetafile.GetMetafileHeader(Stream: TStream; Header: PMetafileHeader): TStatus;
begin
Result := GetMetafileHeader(IStream(TStreamAdapter.Create(Stream)),Header);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TMetafile.GetMetafileHeader(Header: PMetafileHeader): TStatus;
begin
Result := GdipGetMetafileHeaderFromMetafile(PGpMetafile(fNativeImage),Header);
end;

//!!----------------------------------------------------------------------------

Function TMetafile.GetHENHMETAFILE: HENHMETAFILE;
begin
SetStatus(GdipGetHemfFromMetafile(PGpMetafile(fNativeImage),@Result));
end;

//!!----------------------------------------------------------------------------

Function TMetafile.PlayRecord(RecordType: TEmfPlusRecordType; Flags,DataSize: UINT; Data: PBYTE): TStatus;
begin
Result := SetStatus(GdipPlayMetafileRecord(PGpMetafile(fNativeImage),RecordType,Flags,DataSize,Data));
end;

//!!----------------------------------------------------------------------------

Function TMetafile.SetDownLevelRasterizationLimit(MetafileRasterizationLimitDpi: UINT): TStatus;
begin
Result := SetStatus(GdipSetMetafileDownLevelRasterizationLimit(PGpMetafile(fNativeImage),MetafileRasterizationLimitDpi));
end;

//!!----------------------------------------------------------------------------

Function TMetafile.GetDownLevelRasterizationLimit: UINT;
begin
SetStatus(GdipGetMetafileDownLevelRasterizationLimit(PGpMetafile(fNativeImage),@Result));
end;

//!!----------------------------------------------------------------------------

class Function TMetafile.EmfToWmfBits(hEmf: HENHMETAFILE; cbData16: UINT16; pData16: LPBYTE; iMapMode: INT = MM_ANISOTROPIC;
  eFlags: INT = EmfToWmfBitsFlagsDefault): UINT;
begin
Result := GdipEmfToWmfBits(hEmf,cbData16,pData16,iMapMode,eFlags);
end;

{$IF GDIPVER >= $0110}
//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TMetafile.ConvertToEmfPlus(RefGraphics: TGraphics; ConversionFailureFlag: PINT = nil;
  EmfType: TEmfType = EmfTypeEmfPlusOnly; Description: PWideChar = nil): TStatus;
var
  Metafile: PGpMetafile;
begin
Metafile := nil;
Result := GdipConvertToEmfPlus(RefGraphics.NativeObject,PGpMetafile(fNativeImage),
  ConversionFailureFlag,EmfType,Description,@Metafile);
If Assigned(Metafile) then
  begin
    If Result = Ok then
      begin
        GdipDisposeImage(fNativeImage);
        SetNativeImage(PGpImage(Metafile));
      end
    else GdipDisposeImage(PGpImage(Metafile));
  end;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TMetafile.ConvertToEmfPlus(RefGraphics: TGraphics; ConversionFailureFlag: PINT;
  EmfType: TEmfType; const Description: String): TStatus;
begin
Result := ConvertToEmfPlus(RefGraphics,ConversionFailureFlag,EmfType,PWideChar(StrToWide(Description)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TMetafile.ConvertToEmfPlus(RefGraphics: TGraphics; Filename: PWideChar; ConversionFailureFlag: PINT = nil;
  EmfType: TEmfType = EmfTypeEmfPlusOnly; Description: PWideChar = nil): TStatus;
var
  Metafile: PGpMetafile;
begin
Metafile := nil;
Result := GdipConvertToEmfPlusToFile(RefGraphics.NativeObject,PGpMetafile(fNativeImage),
  ConversionFailureFlag,Filename,EmfType,Description,@Metafile);
If Assigned(Metafile) then
  begin
    If Result = Ok then
      begin
        GdipDisposeImage(fNativeImage);
        SetNativeImage(PGpImage(Metafile));
      end
    else GdipDisposeImage(PGpImage(Metafile));
  end;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TMetafile.ConvertToEmfPlus(RefGraphics: TGraphics; const Filename: String; ConversionFailureFlag: PINT;
  EmfType: TEmfType; const Description: String): TStatus;
begin
Result := ConvertToEmfPlus(RefGraphics,PWideChar(StrToWide(Filename)),ConversionFailureFlag,EmfType,PWideChar(StrToWide(Description)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TMetafile.ConvertToEmfPlus(RefGraphics: TGraphics; Stream: IStream; ConversionFailureFlag: PINT = nil;
  EmfType: TEmfType = EmfTypeEmfPlusOnly; Description: PWideChar = nil): TStatus;
var
  Metafile: PGpMetafile;
begin
Metafile := nil;
Result := GdipConvertToEmfPlusToStream(RefGraphics.NativeObject,PGpMetafile(fNativeImage),
  ConversionFailureFlag,Stream,EmfType,Description,@Metafile);
If Assigned(Metafile) then
  begin
    If Result = Ok then
      begin
        GdipDisposeImage(fNativeImage);
        SetNativeImage(PGpImage(Metafile));
      end
    else GdipDisposeImage(PGpImage(Metafile));
  end;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TMetafile.ConvertToEmfPlus(RefGraphics: TGraphics; Stream: TStream; ConversionFailureFlag: PINT = nil;
  EmfType: TEmfType = EmfTypeEmfPlusOnly; Description: PWideChar = nil): TStatus;
begin
Result := ConvertToEmfPlus(RefGraphics,IStream(TStreamAdapter.Create(Stream)),ConversionFailureFlag,EmfType,Description);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TMetafile.ConvertToEmfPlus(RefGraphics: TGraphics; Stream: IStream; ConversionFailureFlag: PINT;
  EmfType: TEmfType; const Description: String): TStatus;
begin
Result := ConvertToEmfPlus(RefGraphics,Stream,ConversionFailureFlag,EmfType,PWideChar(StrToWide(Description)));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TMetafile.ConvertToEmfPlus(RefGraphics: TGraphics; Stream: TStream; ConversionFailureFlag: PINT;
  EmfType: TEmfType; const Description: String): TStatus;
begin
Result := ConvertToEmfPlus(RefGraphics,IStream(TStreamAdapter.Create(Stream)),ConversionFailureFlag,EmfType,PWideChar(StrToWide(Description)));
end;

{$IFEND}
end.
