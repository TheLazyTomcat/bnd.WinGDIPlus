(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   Metafile headers
*
* Abstract:
*
*   GDI+ Metafile Related Structures
*
\**************************************************************************)
unit gdiplusmetaheader;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  AuxTypes,
  gdiplus_common,
  gdiplusenums, gdiplustypes;

type
  TENHMETAHEADER3 = record
    iType:          DWORD;    // Record type EMR_HEADER
    nSize:          DWORD;    // Record size in bytes.  This may be greater
                              // than the sizeof(ENHMETAHEADER).
    rclBounds:      RECTL;    // Inclusive-inclusive bounds in device units
    rclFrame:       RECTL;    // Inclusive-inclusive Picture Frame .01mm unit
    dSignature:     DWORD;    // Signature.  Must be ENHMETA_SIGNATURE.
    nVersion:       DWORD;    // Version number
    nBytes:         DWORD;    // Size of the metafile in bytes
    nRecords:       DWORD;    // Number of records in the metafile
    nHandles:       WORD;     // Number of handles in the handle table
                              // Handle index zero is reserved.
    sReserved:      WORD;     // Reserved.  Must be zero.
    nDescription:   DWORD;    // Number of chars in the unicode desc string
                              // This is 0 if there is no description string
    offDescription: DWORD;    // Offset to the metafile description record.
                              // This is 0 if there is no description string
    nPalEntries:    DWORD;    // Number of entries in the metafile palette.
    szlDevice:      SIZEL;    // Size of the reference device in pels
    szlMillimeters: SIZEL;    // Size of the reference device in millimeters
  end;
  PENHMETAHEADER3 = ^TENHMETAHEADER3;

// Placeable WMFs

// Placeable Metafiles were created as a non-standard way of specifying how 
// a metafile is mapped and scaled on an output device.
// Placeable metafiles are quite wide-spread, but not directly supported by
// the Windows API. To playback a placeable metafile using the Windows API,
// you will first need to strip the placeable metafile header from the file.
// This is typically performed by copying the metafile to a temporary file
// starting at file offset 22 (0x16). The contents of the temporary file may
// then be used as input to the Windows GetMetaFile(), PlayMetaFile(),
// CopyMetaFile(), etc. GDI functions.

// Each placeable metafile begins with a 22-byte header,
//  followed by a standard metafile:

{$ALIGN 2}  //!! TWmfPlaceableFileHeader should be 22 bytes

type
  TPWMFRect16 = record
    Left:   INT16;
    Top:    INT16;
    Right:  INT16;
    Bottom: INT16;
  end;
  PPWMFRect16 = ^TPWMFRect16;

  TWmfPlaceableFileHeader = record
    Key:          UINT32;       // GDIP_WMF_PLACEABLEKEY
    Hmf:          INT16;        // Metafile HANDLE number (always 0)
    BoundingBox:  TPWMFRect16;  // Coordinates in metafile units
    Inch:         INT16;        // Number of metafile units per inch
    Reserved:     UINT32;       // Reserved (always 0)
    Checksum:     INT16;        // Checksum value for previous 10 WORDs
  end;
  PWmfPlaceableFileHeader = ^TWmfPlaceableFileHeader;

{$ALIGN 8}

// Key contains a special identification value that indicates the presence
// of a placeable metafile header and is always 0x9AC6CDD7.

// Handle is used to stored the handle of the metafile in memory. When written
// to disk, this field is not used and will always contains the value 0.

// Left, Top, Right, and Bottom contain the coordinates of the upper-left
// and lower-right corners of the image on the output device. These are
// measured in twips.

// A twip (meaning "twentieth of a point") is the logical unit of measurement
// used in Windows Metafiles. A twip is equal to 1/1440 of an inch. Thus 720
// twips equal 1/2 inch, while 32,768 twips is 22.75 inches.

// Inch contains the number of twips per inch used to represent the image.
// Normally, there are 1440 twips per inch; however, this number may be
// changed to scale the image. A value of 720 indicates that the image is
// double its normal size, or scaled to a factor of 2:1. A value of 360
// indicates a scale of 4:1, while a value of 2880 indicates that the image
// is scaled down in size by a factor of two. A value of 1440 indicates
// a 1:1 scale ratio.

// Reserved is not used and is always set to 0.

// Checksum contains a checksum value for the previous 10 WORDs in the header.
// This value can be used in an attempt to detect if the metafile has become
// corrupted. The checksum is calculated by XORing each WORD value to an
// initial value of 0.

// If the metafile was recorded with a reference Hdc that was a display.
const
  GDIP_EMFPLUSFLAGS_DISPLAY = $00000001;

type
  TMetafileHeader = record
    Type_:                    TMetafileType;
    Size:                     UINT;     // Size of the metafile (in bytes)
    Version:                  UINT;     // EMF+, EMF, or WMF version
    EmfPlusFlags:             UINT;
    DpiX:                     REAL;
    DpiY:                     REAL;
    X:                        INT;      // Bounds in device units
    Y:                        INT;
    Width:                    INT;
    Height:                   INT;
    case Integer of
      0: (WmfHeader:          METAHEADER);
      1: (EmfHeader:          TENHMETAHEADER3;
          EmfPlusHeaderSize:  INT;      // size of the EMF+ header in file
          LogicalDpiX:        INT;      // Logical Dpi of reference Hdc
          LogicalDpiY:        INT)      // usually valid only for EMF+
  end;
  PMetafileHeader = ^TMetafileHeader;

Function GetType(const header: TMetafileHeader): TMetafileType;
Function GetMetafileSize(const header: TMetafileHeader): UINT;
// If IsEmfPlus, this is the EMF+ version; else it is the WMF or EMF ver
Function GetVersion(const header: TMetafileHeader): UINT;
// Get the EMF+ flags associated with the metafile
Function GetEmfPlusFlags(const header: TMetafileHeader): UINT;
Function GetDpiX(const header: TMetafileHeader): REAL;
Function GetDpiY(const header: TMetafileHeader): REAL;
Function GetBounds(const header: TMetafileHeader): TRect;

// Is it any type of WMF (standard or Placeable Metafile)?
Function IsWmf(const header: TMetafileHeader): BOOL;
// Is this an Placeable Metafile?
Function IsWmfPlaceable(const header: TMetafileHeader): BOOL;
// Is this an EMF (not an EMF+)?
Function IsEmf(const header: TMetafileHeader): BOOL;
// Is this an EMF or EMF+ file?
Function IsEmfOrEmfPlus(const header: TMetafileHeader): BOOL;
// Is this an EMF+ file?
Function IsEmfPlus(const header: TMetafileHeader): BOOL;
// Is this an EMF+ dual (has dual, down-level records) file?
Function IsEmfPlusDual(const header: TMetafileHeader): BOOL;
// Is this an EMF+ only (no dual records) file?
Function IsEmfPlusOnly(const header: TMetafileHeader): BOOL;
// If it's an EMF+ file, was it recorded against a display Hdc?
Function IsDisplay(const header: TMetafileHeader): BOOL;
// Get the WMF header of the metafile (if it is a WMF)
Function GetWmfHeader(const header: TMetafileHeader): PMETAHEADER;
// Get the EMF header of the metafile (if it is an EMF)
Function GetEmfHeader(const header: TMetafileHeader): PENHMETAHEADER3;

implementation

{!!-----------------------------------------------------------------------------
    TMetafileHeader - implementation
-------------------------------------------------------------------------------}

Function GetType(const header: TMetafileHeader): TMetafileType;
begin
Result := header.Type_;
end;  

//!!----------------------------------------------------------------------------

Function GetMetafileSize(const header: TMetafileHeader): UINT;
begin
Result := header.Size;
end;

//!!----------------------------------------------------------------------------

Function GetVersion(const header: TMetafileHeader): UINT;
begin
Result := header.Version;
end;

//!!----------------------------------------------------------------------------

Function GetEmfPlusFlags(const header: TMetafileHeader): UINT;
begin
Result := header.EmfPlusFlags;
end;

//!!----------------------------------------------------------------------------

Function GetDpiX(const header: TMetafileHeader): REAL;
begin
Result := header.DpiX;
end;

//!!----------------------------------------------------------------------------

Function GetDpiY(const header: TMetafileHeader): REAL;
begin
Result := header.DpiY;
end;

//!!----------------------------------------------------------------------------

Function GetBounds(const header: TMetafileHeader): TRect;
begin
Result.X := header.X;
Result.Y := header.Y;
Result.Width := header.Width;
Result.Height := header.Height;
end;

//!!---------------------------------------------------------------------------

Function IsWmf(const header: TMetafileHeader): BOOL;
begin
Result := (header.Type_ = MetafileTypeWmf) or (header.Type_ = MetafileTypeWmfPlaceable);
end;

//!!----------------------------------------------------------------------------

Function IsWmfPlaceable(const header: TMetafileHeader): BOOL;
begin
Result := header.Type_ = MetafileTypeWmfPlaceable;
end;

//!!----------------------------------------------------------------------------

Function IsEmf(const header: TMetafileHeader): BOOL;
begin
Result := header.Type_ = MetafileTypeEmf;
end;
 
//!!----------------------------------------------------------------------------

Function IsEmfOrEmfPlus(const header: TMetafileHeader): BOOL;
begin
Result := header.Type_ >= MetafileTypeEmf;
end;
 
//!!----------------------------------------------------------------------------

Function IsEmfPlus(const header: TMetafileHeader): BOOL;
begin
Result := header.Type_ >= MetafileTypeEmfPlusOnly;
end;
 
//!!----------------------------------------------------------------------------

Function IsEmfPlusDual(const header: TMetafileHeader): BOOL;
begin
Result := header.Type_ = MetafileTypeEmfPlusDual;
end;

//!!----------------------------------------------------------------------------

Function IsEmfPlusOnly(const header: TMetafileHeader): BOOL;
begin
Result := header.Type_ = MetafileTypeEmfPlusOnly;
end;
 
//!!----------------------------------------------------------------------------

Function IsDisplay(const header: TMetafileHeader): BOOL;
begin
Result := IsEmfPlus(header) and ((header.EmfPlusFlags and GDIP_EMFPLUSFLAGS_DISPLAY) <> 0);
end;

//!!----------------------------------------------------------------------------

Function GetWmfHeader(const header: TMetafileHeader): PMETAHEADER;
begin
If IsWmf(header) then
  Result := Addr(header.WmfHeader)
else
  Result := nil;
end;

//!!----------------------------------------------------------------------------

Function GetEmfHeader(const header: TMetafileHeader): PENHMETAHEADER3;
begin
If IsEmfOrEmfPlus(header) then
  Result := Addr(header.EmfHeader)
else
  Result := nil;
end;

end.
