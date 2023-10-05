(**************************************************************************\
* 
* Copyright (c) 1999-2000  Microsoft Corporation
*
* Module Name:
*
*   GdiplusImaging.h
*
* Abstract:
*
*   GDI+ Imaging GUIDs
*
\**************************************************************************)
unit gdiplusimaging;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  gdiplus_common,
  gdipluspixelformats;

//---------------------------------------------------------------------------
// Image file format identifiers
//---------------------------------------------------------------------------
const
  ImageFormatUndefined: TGUID = '{b96b3ca9-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatMemoryBMP: TGUID = '{b96b3caa-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatBMP:       TGUID = '{b96b3cab-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatEMF:       TGUID = '{b96b3cac-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatWMF:       TGUID = '{b96b3cad-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatJPEG:      TGUID = '{b96b3cae-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatPNG:       TGUID = '{b96b3caf-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatGIF:       TGUID = '{b96b3cb0-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatTIFF:      TGUID = '{b96b3cb1-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatEXIF:      TGUID = '{b96b3cb2-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatIcon:      TGUID = '{b96b3cb5-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatHEIF:      TGUID = '{b96b3cb6-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatWEBP:      TGUID = '{b96b3cb7-0728-11d3-9d7b-0000f81ef32e}';

//---------------------------------------------------------------------------
// Predefined multi-frame dimension IDs
//---------------------------------------------------------------------------

  FrameDimensionTime:       TGUID = '{6aedbd6d-3fb5-418a-83a6-7f45229dc872}';
  FrameDimensionResolution: TGUID = '{84236f7b-3bd3-428f-8dab-4ea1439ca315}';
  FrameDimensionPage:       TGUID = '{7462dc86-6180-4c7e-8e3f-ee7333a7a483}';

//---------------------------------------------------------------------------
// Property sets
//---------------------------------------------------------------------------

  FormatIDImageInformation: TGUID = '{e5836cbe-5eef-4f1d-acde-ae4c43b608ce}';
  FormatIDJpegAppHeaders:   TGUID = '{1c4afdcd-6177-43cf-abc7-5f51af39ee85}';

//---------------------------------------------------------------------------
// Encoder parameter sets
//---------------------------------------------------------------------------

  EncoderCompression:      TGUID = '{e09d739d-ccd4-44ee-8eba-3fbf8be4fc58}';
  EncoderColorDepth:       TGUID = '{66087055-ad66-4c7c-9a18-38a2310b8337}';
  EncoderScanMethod:       TGUID = '{3a4e2661-3109-4e56-8536-42c156e7dcfa}';
  EncoderVersion:          TGUID = '{24d18c76-814a-41a4-bf53-1c219cccf797}';
  EncoderRenderMethod:     TGUID = '{6d42c53a-229a-4825-8bb7-5c99e2b9a8b8}';
  EncoderQuality:          TGUID = '{1d5be4b5-fa4a-452d-9cdd-5db35105e7eb}';
  EncoderTransformation:   TGUID = '{8d0eb2d1-a58e-4ea8-aa14-108074b7b6f9}';
  EncoderLuminanceTable:   TGUID = '{edb33bce-0266-4a77-b904-27216099e717}';
  EncoderChrominanceTable: TGUID = '{f2e455dc-09b3-4316-8260-676ada32481c}';
  EncoderSaveFlag:         TGUID = '{292266fc-ac40-47bf-8cfc-a85b89a655de}';

{$IF GDIPVER >= $0110}
  EncoderColorSpace: TGUID = '{ae7a62a0-ee2c-49d8-9d07-1ba8a927596e}';
  EncoderImageItems: TGUID = '{63875e13-1f1d-45ab-9195-a29b6066a650}';
  EncoderSaveAsCMYK: TGUID = '{a219bbc9-0a9d-4005-a3ee-3a421b8bb06c}';
{$IFEND}

  CodecIImageBytes: TGUID = '{025d1823-6c7d-447b-bbdb-a3cbc3dfa2fc}';

type
  IImageBytes = interface(IUnknown)
  ['{025D1823-6C7D-447B-BBDB-A3CBC3DFA2FC}']
    // Return total number of bytes in the IStream
    Function CountBytes(pcb: PUINT): HRESULT; stdcall;
    // Locks "cb" bytes, starting from "ulOffset" in the stream, and returns the
    // pointer to the beginning of the locked memory chunk in "ppvBytes"
    Function LockBytes(cb: UINT; ulOffset: ULONG; ppvBytes: PPointer): HRESULT; stdcall;
    // Unlocks "cb" bytes, pointed by "pvBytes", starting from "ulOffset" in the
    // stream
    Function UnlockBytes(pvBytes: Pointer; cb: UINT; ulOffset: ULONG): HRESULT; stdcall;
  end;

//--------------------------------------------------------------------------
// ImageCodecInfo structure
//--------------------------------------------------------------------------
type
  TImageCodecInfo = record
    Clsid:              TCLSID;
    FormatID:           TGUID;
    CodecName:          PWideChar;
    DllName:            PWideChar;
    FormatDescription:  PWideChar;
    FilenameExtension:  PWideChar;
    MimeType:           PWideChar;
    Flags:              DWORD;
    Version:            DWORD;
    SigCount:           DWORD;
    SigSize:            DWORD;
    SigPattern:         PByte;
    SigMask:            PByte;
  end;
  PImageCodecInfo = ^TImageCodecInfo;

//--------------------------------------------------------------------------
// Information flags about image codecs
//--------------------------------------------------------------------------
type
  TImageCodecFlags = DWORD;   PImageCodecFlags = ^TImageCodecFlags;
const
  ImageCodecFlagsEncoder        = $00000001;
  ImageCodecFlagsDecoder        = $00000002;
  ImageCodecFlagsSupportBitmap  = $00000004;
  ImageCodecFlagsSupportVector  = $00000008;
  ImageCodecFlagsSeekableEncode = $00000010;
  ImageCodecFlagsBlockingDecode = $00000020;

  ImageCodecFlagsBuiltin        = $00010000;
  ImageCodecFlagsSystem         = $00020000;
  ImageCodecFlagsUser           = $00040000;

//---------------------------------------------------------------------------
// Access modes used when calling Image::LockBits
//---------------------------------------------------------------------------
type
  TImageLockMode = UINT;    PImageLockMode = ^TImageLockMode;
const
  ImageLockModeRead         = $0001;
  ImageLockModeWrite        = $0002;
  ImageLockModeUserInputBuf = $0004;

//---------------------------------------------------------------------------
// Information about image pixel data
//---------------------------------------------------------------------------
type
  TBitmapData = record
    Width:        UINT;
    Height:       UINT;
    Stride:       INT;
    PixelFormat:  TPixelFormat;
    Scan0:        Pointer;
    Reserved:     UINT_PTR;
  end;
  PBitmapData = ^TBitmapData;

//---------------------------------------------------------------------------
// Image flags
//---------------------------------------------------------------------------
type
  TImageFlags = UINT;   PImageFlags = ^TImageFlags;
const
  ImageFlagsNone              = 0;

  // Low-word: shared with SINKFLAG_x

  ImageFlagsScalable          = $0001;
  ImageFlagsHasAlpha          = $0002;
  ImageFlagsHasTranslucent    = $0004;
  ImageFlagsPartiallyScalable = $0008;

  // Low-word: color space definition

  ImageFlagsColorSpaceRGB     = $0010;
  ImageFlagsColorSpaceCMYK    = $0020;
  ImageFlagsColorSpaceGRAY    = $0040;
  ImageFlagsColorSpaceYCBCR   = $0080;
  ImageFlagsColorSpaceYCCK    = $0100;

  // Low-word: image size info

  ImageFlagsHasRealDPI        = $1000;
  ImageFlagsHasRealPixelSize  = $2000;

  // High-word

  ImageFlagsReadOnly          = $00010000;
  ImageFlagsCaching           = $00020000;

type
  TRotateFlipType = (
    RotateNoneFlipNone = 0,
    Rotate90FlipNone   = 1,
    Rotate180FlipNone  = 2,
    Rotate270FlipNone  = 3,

    RotateNoneFlipX    = 4,
    Rotate90FlipX      = 5,
    Rotate180FlipX     = 6,
    Rotate270FlipX     = 7,

    RotateNoneFlipY    = Rotate180FlipX,
    Rotate90FlipY      = Rotate270FlipX,
    Rotate180FlipY     = RotateNoneFlipX,
    Rotate270FlipY     = Rotate90FlipX,

    RotateNoneFlipXY   = Rotate180FlipNone,
    Rotate90FlipXY     = Rotate270FlipNone,
    Rotate180FlipXY    = RotateNoneFlipNone,
    Rotate270FlipXY    = Rotate90FlipNone
  );
  PRotateFlipType = ^TRotateFlipType;

//---------------------------------------------------------------------------
// Encoder Parameter structure
//---------------------------------------------------------------------------
type
  TEncoderParameter = record
    Guid:           TGUID;      // GUID of the parameter
    NumberOfValues: ULONG;      // Number of the parameter values
    Type_:          ULONG;      // Value type, like ValueTypeLONG  etc.
    Value:          Pointer;    // A pointer to the parameter values
  end;
  PEncoderParameter = ^TEncoderParameter;

//---------------------------------------------------------------------------
// Encoder Parameters structure
//---------------------------------------------------------------------------
type
  TEncoderParameters = record
    Count:      UINT;                             // Number of parameters in this structure
    Parameter:  array[0..0] of TEncoderParameter; // Parameter values
  end;
  PEncoderParameters = ^TEncoderParameters;

{$IF GDIPVER >= $0110}
  TItemDataPosition = (
    ItemDataPositionAfterHeader  = $0,
    ItemDataPositionAfterPalette = $1,
    ItemDataPositionAfterBits    = $2
  );
  PItemDataPosition = ^TItemDataPosition;

//---------------------------------------------------------------------------
// External Data Item
//---------------------------------------------------------------------------
type
  TImageItemData = record
    Size:     UINT;       // size of the structure
    Position: UINT;       // flags describing how the data is to be used.
    Desc:     Pointer;    // description on how the data is to be saved.
                          // it is different for every codec type.
    DescSize: UINT;       // size memory pointed by Desc
    Data:     Pointer;    // pointer to the data that is to be saved in the
                          // file, could be anything saved directly.
    DataSize: UINT;       // size memory pointed by Data
    Cookie:   UINT;       // opaque for the apps data member used during
                          // enumeration of image data items.
  end;
  PImageItemData = ^TImageItemData;

{$IFEND}

//---------------------------------------------------------------------------
// Property Item
//---------------------------------------------------------------------------
type
  TPropertyItem = record
    id:     PROPID;     // ID of this property
    length: ULONG;      // Length of the property value, in bytes
    type_:  WORD;       // Type of the value, as one of TAG_TYPE_XXX
                        // defined above
    value:  Pointer;    // property value
  end;
  PPropertyItem = ^TPropertyItem;

//---------------------------------------------------------------------------
// Image property types 
//---------------------------------------------------------------------------
const
  PropertyTagTypeByte      =  1;
  PropertyTagTypeASCII     =  2;
  PropertyTagTypeShort     =  3;
  PropertyTagTypeLong      =  4;
  PropertyTagTypeRational  =  5;
  PropertyTagTypeUndefined =  7;
  PropertyTagTypeSLONG     =  9;
  PropertyTagTypeSRational = 10;

//---------------------------------------------------------------------------
// Image property ID tags
//---------------------------------------------------------------------------
const
  PropertyTagExifIFD                = $8769;
  PropertyTagGpsIFD                 = $8825;

  PropertyTagNewSubfileType         = $00FE;
  PropertyTagSubfileType            = $00FF;
  PropertyTagImageWidth             = $0100;
  PropertyTagImageHeight            = $0101;
  PropertyTagBitsPerSample          = $0102;
  PropertyTagCompression            = $0103;
  PropertyTagPhotometricInterp      = $0106;
  PropertyTagThreshHolding          = $0107;
  PropertyTagCellWidth              = $0108;
  PropertyTagCellHeight             = $0109;
  PropertyTagFillOrder              = $010A;
  PropertyTagDocumentName           = $010D;
  PropertyTagImageDescription       = $010E;
  PropertyTagEquipMake              = $010F;
  PropertyTagEquipModel             = $0110;
  PropertyTagStripOffsets           = $0111;
  PropertyTagOrientation            = $0112;
  PropertyTagSamplesPerPixel        = $0115;
  PropertyTagRowsPerStrip           = $0116;
  PropertyTagStripBytesCount        = $0117;
  PropertyTagMinSampleValue         = $0118;
  PropertyTagMaxSampleValue         = $0119;
  PropertyTagXResolution            = $011A;    // Image resolution in width direction
  PropertyTagYResolution            = $011B;    // Image resolution in height direction
  PropertyTagPlanarConfig           = $011C;    // Image data arrangement
  PropertyTagPageName               = $011D;
  PropertyTagXPosition              = $011E;
  PropertyTagYPosition              = $011F;
  PropertyTagFreeOffset             = $0120;
  PropertyTagFreeByteCounts         = $0121;
  PropertyTagGrayResponseUnit       = $0122;
  PropertyTagGrayResponseCurve      = $0123;
  PropertyTagT4Option               = $0124;
  PropertyTagT6Option               = $0125;
  PropertyTagResolutionUnit         = $0128;   // Unit of X and Y resolution
  PropertyTagPageNumber             = $0129;
  PropertyTagTransferFuncition      = $012D;
  PropertyTagSoftwareUsed           = $0131;
  PropertyTagDateTime               = $0132;
  PropertyTagArtist                 = $013B;
  PropertyTagHostComputer           = $013C;
  PropertyTagPredictor              = $013D;
  PropertyTagWhitePoint             = $013E;
  PropertyTagPrimaryChromaticities  = $013F;
  PropertyTagColorMap               = $0140;
  PropertyTagHalftoneHints          = $0141;
  PropertyTagTileWidth              = $0142;
  PropertyTagTileLength             = $0143;
  PropertyTagTileOffset             = $0144;
  PropertyTagTileByteCounts         = $0145;
  PropertyTagInkSet                 = $014C;
  PropertyTagInkNames               = $014D;
  PropertyTagNumberOfInks           = $014E;
  PropertyTagDotRange               = $0150;
  PropertyTagTargetPrinter          = $0151;
  PropertyTagExtraSamples           = $0152;
  PropertyTagSampleFormat           = $0153;
  PropertyTagSMinSampleValue        = $0154;
  PropertyTagSMaxSampleValue        = $0155;
  PropertyTagTransferRange          = $0156;

  PropertyTagJPEGProc               = $0200;
  PropertyTagJPEGInterFormat        = $0201;
  PropertyTagJPEGInterLength        = $0202;
  PropertyTagJPEGRestartInterval    = $0203;
  PropertyTagJPEGLosslessPredictors = $0205;
  PropertyTagJPEGPointTransforms    = $0206;
  PropertyTagJPEGQTables            = $0207;
  PropertyTagJPEGDCTables           = $0208;
  PropertyTagJPEGACTables           = $0209;

  PropertyTagYCbCrCoefficients      = $0211;
  PropertyTagYCbCrSubsampling       = $0212;
  PropertyTagYCbCrPositioning       = $0213;
  PropertyTagREFBlackWhite          = $0214;

  PropertyTagICCProfile             = $8773;    // This TAG is defined by ICC
                                                // for embedded ICC in TIFF
  PropertyTagGamma                  = $0301;
  PropertyTagICCProfileDescriptor   = $0302;
  PropertyTagSRGBRenderingIntent    = $0303;

  PropertyTagImageTitle             = $0320;
  PropertyTagCopyright              = $8298;

  // Extra TAGs (Like Adobe Image Information tags etc.)

  PropertyTagResolutionXUnit           = $5001;
  PropertyTagResolutionYUnit           = $5002;
  PropertyTagResolutionXLengthUnit     = $5003;
  PropertyTagResolutionYLengthUnit     = $5004;
  PropertyTagPrintFlags                = $5005;
  PropertyTagPrintFlagsVersion         = $5006;
  PropertyTagPrintFlagsCrop            = $5007;
  PropertyTagPrintFlagsBleedWidth      = $5008;
  PropertyTagPrintFlagsBleedWidthScale = $5009;
  PropertyTagHalftoneLPI               = $500A;
  PropertyTagHalftoneLPIUnit           = $500B;
  PropertyTagHalftoneDegree            = $500C;
  PropertyTagHalftoneShape             = $500D;
  PropertyTagHalftoneMisc              = $500E;
  PropertyTagHalftoneScreen            = $500F;
  PropertyTagJPEGQuality               = $5010;
  PropertyTagGridSize                  = $5011;
  PropertyTagThumbnailFormat           = $5012;   // 1 = JPEG, 0 = RAW RGB
  PropertyTagThumbnailWidth            = $5013;
  PropertyTagThumbnailHeight           = $5014;
  PropertyTagThumbnailColorDepth       = $5015;
  PropertyTagThumbnailPlanes           = $5016;
  PropertyTagThumbnailRawBytes         = $5017;
  PropertyTagThumbnailSize             = $5018;
  PropertyTagThumbnailCompressedSize   = $5019;
  PropertyTagColorTransferFunction     = $501A;
  PropertyTagThumbnailData             = $501B;   // RAW thumbnail bits in
                                                  // JPEG format or RGB format
                                                  // depends on
                                                  // PropertyTagThumbnailFormat

  // Thumbnail related TAGs

  PropertyTagThumbnailImageWidth            = $5020;  // Thumbnail width
  PropertyTagThumbnailImageHeight           = $5021;  // Thumbnail height
  PropertyTagThumbnailBitsPerSample         = $5022;  // Number of bits per
                                                      // component
  PropertyTagThumbnailCompression           = $5023;  // Compression Scheme
  PropertyTagThumbnailPhotometricInterp     = $5024;  // Pixel composition
  PropertyTagThumbnailImageDescription      = $5025;  // Image Tile
  PropertyTagThumbnailEquipMake             = $5026;  // Manufacturer of Image
                                                      // Input equipment
  PropertyTagThumbnailEquipModel            = $5027;  // Model of Image input
                                                      // equipment
  PropertyTagThumbnailStripOffsets          = $5028;  // Image data location
  PropertyTagThumbnailOrientation           = $5029;  // Orientation of image
  PropertyTagThumbnailSamplesPerPixel       = $502A;  // Number of components
  PropertyTagThumbnailRowsPerStrip          = $502B;  // Number of rows per strip
  PropertyTagThumbnailStripBytesCount       = $502C;  // Bytes per compressed
                                                      // strip
  PropertyTagThumbnailResolutionX           = $502D;  // Resolution in width
                                                      // direction
  PropertyTagThumbnailResolutionY           = $502E;  // Resolution in height
                                                      // direction
  PropertyTagThumbnailPlanarConfig          = $502F;  // Image data arrangement
  PropertyTagThumbnailResolutionUnit        = $5030;  // Unit of X and Y
                                                      // Resolution
  PropertyTagThumbnailTransferFunction      = $5031;  // Transfer function
  PropertyTagThumbnailSoftwareUsed          = $5032;  // Software used
  PropertyTagThumbnailDateTime              = $5033;  // File change date and
                                                      // time
  PropertyTagThumbnailArtist                = $5034;  // Person who created the
                                                      // image
  PropertyTagThumbnailWhitePoint            = $5035;  // White point chromaticity
  PropertyTagThumbnailPrimaryChromaticities = $5036;
                                                      // Chromaticities of
                                                      // primaries
  PropertyTagThumbnailYCbCrCoefficients     = $5037;  // Color space transforma-
                                                      // tion coefficients
  PropertyTagThumbnailYCbCrSubsampling      = $5038;  // Subsampling ratio of Y
                                                      // to C
  PropertyTagThumbnailYCbCrPositioning      = $5039;  // Y and C position
  PropertyTagThumbnailRefBlackWhite         = $503A;  // Pair of black and white
                                                      // reference values
  PropertyTagThumbnailCopyRight             = $503B;  // CopyRight holder

  PropertyTagLuminanceTable                 = $5090;
  PropertyTagChrominanceTable               = $5091;

  PropertyTagFrameDelay                     = $5100;
  PropertyTagLoopCount                      = $5101;

{$IF GDIPVER >= $0110}
  PropertyTagGlobalPalette                  = $5102;
  PropertyTagIndexBackground                = $5103;
  PropertyTagIndexTransparent               = $5104;
{$IFEND}

  PropertyTagPixelUnit        = $5110;  // Unit specifier for pixel/unit
  PropertyTagPixelPerUnitX    = $5111;  // Pixels per unit in X
  PropertyTagPixelPerUnitY    = $5112;  // Pixels per unit in Y
  PropertyTagPaletteHistogram = $5113;  // Palette histogram

  // EXIF specific tag

  PropertyTagExifExposureTime  = $829A;
  PropertyTagExifFNumber       = $829D;

  PropertyTagExifExposureProg  = $8822;
  PropertyTagExifSpectralSense = $8824;
  PropertyTagExifISOSpeed      = $8827;
  PropertyTagExifOECF          = $8828;

  PropertyTagExifVer           = $9000;
  PropertyTagExifDTOrig        = $9003;   // Date & time of original
  PropertyTagExifDTDigitized   = $9004;   // Date & time of digital data generation

  PropertyTagExifCompConfig    = $9101;
  PropertyTagExifCompBPP       = $9102;

  PropertyTagExifShutterSpeed  = $9201;
  PropertyTagExifAperture      = $9202;
  PropertyTagExifBrightness    = $9203;
  PropertyTagExifExposureBias  = $9204;
  PropertyTagExifMaxAperture   = $9205;
  PropertyTagExifSubjectDist   = $9206;
  PropertyTagExifMeteringMode  = $9207;
  PropertyTagExifLightSource   = $9208;
  PropertyTagExifFlash         = $9209;
  PropertyTagExifFocalLength   = $920A;
  PropertyTagExifSubjectArea   = $9214;   // exif 2.2 Subject Area
  PropertyTagExifMakerNote     = $927C;
  PropertyTagExifUserComment   = $9286;
  PropertyTagExifDTSubsec      = $9290;   // Date & Time subseconds
  PropertyTagExifDTOrigSS      = $9291;   // Date & Time original subseconds
  PropertyTagExifDTDigSS       = $9292;   // Date & TIme digitized subseconds

  PropertyTagExifFPXVer        = $A000;
  PropertyTagExifColorSpace    = $A001;
  PropertyTagExifPixXDim       = $A002;
  PropertyTagExifPixYDim       = $A003;
  PropertyTagExifRelatedWav    = $A004;   // related sound file
  PropertyTagExifInterop       = $A005;
  PropertyTagExifFlashEnergy   = $A20B;
  PropertyTagExifSpatialFR     = $A20C;   // Spatial Frequency Response
  PropertyTagExifFocalXRes     = $A20E;   // Focal Plane X Resolution
  PropertyTagExifFocalYRes     = $A20F;   // Focal Plane Y Resolution
  PropertyTagExifFocalResUnit  = $A210;   // Focal Plane Resolution Unit
  PropertyTagExifSubjectLoc    = $A214;
  PropertyTagExifExposureIndex = $A215;
  PropertyTagExifSensingMethod = $A217;
  PropertyTagExifFileSource    = $A300;
  PropertyTagExifSceneType     = $A301;
  PropertyTagExifCfaPattern    = $A302;

  // New EXIF 2.2 properties

  PropertyTagExifCustomRendered        = $A401;
  PropertyTagExifExposureMode          = $A402;
  PropertyTagExifWhiteBalance          = $A403;
  PropertyTagExifDigitalZoomRatio      = $A404;
  PropertyTagExifFocalLengthIn35mmFilm = $A405;
  PropertyTagExifSceneCaptureType      = $A406;
  PropertyTagExifGainControl           = $A407;
  PropertyTagExifContrast              = $A408;
  PropertyTagExifSaturation            = $A409;
  PropertyTagExifSharpness             = $A40A;
  PropertyTagExifDeviceSettingDesc     = $A40B;
  PropertyTagExifSubjectDistanceRange  = $A40C;
  PropertyTagExifUniqueImageID         = $A420;


  PropertyTagGpsVer              = $0000;
  PropertyTagGpsLatitudeRef      = $0001;
  PropertyTagGpsLatitude         = $0002;
  PropertyTagGpsLongitudeRef     = $0003;
  PropertyTagGpsLongitude        = $0004;
  PropertyTagGpsAltitudeRef      = $0005;
  PropertyTagGpsAltitude         = $0006;
  PropertyTagGpsGpsTime          = $0007;
  PropertyTagGpsGpsSatellites    = $0008;
  PropertyTagGpsGpsStatus        = $0009;
  PropertyTagGpsGpsMeasureMode   = $000A;
  PropertyTagGpsGpsDop           = $000B;   // Measurement precision
  PropertyTagGpsSpeedRef         = $000C;
  PropertyTagGpsSpeed            = $000D;
  PropertyTagGpsTrackRef         = $000E;
  PropertyTagGpsTrack            = $000F;
  PropertyTagGpsImgDirRef        = $0010;
  PropertyTagGpsImgDir           = $0011;
  PropertyTagGpsMapDatum         = $0012;
  PropertyTagGpsDestLatRef       = $0013;
  PropertyTagGpsDestLat          = $0014;
  PropertyTagGpsDestLongRef      = $0015;
  PropertyTagGpsDestLong         = $0016;
  PropertyTagGpsDestBearRef      = $0017;
  PropertyTagGpsDestBear         = $0018;
  PropertyTagGpsDestDistRef      = $0019;
  PropertyTagGpsDestDist         = $001A;
  PropertyTagGpsProcessingMethod = $001B;
  PropertyTagGpsAreaInformation  = $001C;
  PropertyTagGpsDate             = $001D;
  PropertyTagGpsDifferential     = $001E;   

implementation

end.
