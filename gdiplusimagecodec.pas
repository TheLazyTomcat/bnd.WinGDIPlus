(**************************************************************************\
*
* Copyright (c) 2000-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusImageCodec.h
*
* Abstract:
*
*   GDI+ Codec Image APIs
*
\**************************************************************************)
unit gdiplusimagecodec;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  gdiplus_common,
  gdiplustypes, gdiplusimaging;

//--------------------------------------------------------------------------
// Codec Management APIs
//--------------------------------------------------------------------------

Function GetImageDecodersSize(NumDecoders: PUINT; Size: PUINT): TStatus;{$IFDEF CanInline} inline;{$ENDIF}

Function GetImageDecoders(NumDecoders: UINT; Size: UINT; Decoders: PImageCodecInfo): TStatus;{$IFDEF CanInline} inline;{$ENDIF}

Function GetImageEncodersSize(NumEncoders: PUINT; Size: PUINT): TStatus;{$IFDEF CanInline} inline;{$ENDIF}

Function GetImageEncoders(NumEncoders: UINT; Size: UINT; Encoders: PImageCodecInfo): TStatus;{$IFDEF CanInline} inline;{$ENDIF}

implementation

uses
  gdiplusflat;

Function GetImageDecodersSize(NumDecoders: PUINT; Size: PUINT): TStatus;
begin
Result := GdipGetImageDecodersSize(NumDecoders,Size);
end;

//!!----------------------------------------------------------------------------

Function GetImageDecoders(NumDecoders: UINT; Size: UINT; Decoders: PImageCodecInfo): TStatus;
begin
Result := GdipGetImageDecoders(NumDecoders,Size,Decoders);
end;

//!!----------------------------------------------------------------------------

Function GetImageEncodersSize(NumEncoders: PUINT; Size: PUINT): TStatus;
begin
Result := GdipGetImageEncodersSize(NumEncoders,Size);
end;

//!!----------------------------------------------------------------------------

Function GetImageEncoders(NumEncoders: UINT; Size: UINT; Encoders: PImageCodecInfo): TStatus;
begin
Result := GdipGetImageEncoders(NumEncoders,Size,Encoders);
end;

end.
