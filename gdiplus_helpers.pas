unit gdiplus_helpers;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Classes,
  gdiplus_common,
  gdiplustypes;

{!!
  VersionSupported

  Checks for existance of gdiplus.dll and selected symbols (functions) exported
  by it.

  If the library cannot be loaded, it returns 0, othervise following values
  can be returned (note that if a value not listed here is returned, it should
  be considered an error):

    1 ... GDI+ version 1.0 is supported
    2 ... GDI+ version 1.1 and older is supported
}
Function VersionSupported: Integer;

Function StatusAsStr(Status: TStatus): String;

Function StatusCheck(Status: TStatus): Boolean;
Function StatusRaise(Status: TStatus): TStatus;

type
  TCodecString = (csName,csDLLName,csFmtDescr,csFileExt,csMimeType);

procedure GetDecoders(List: TStringList; CodecString: TCodecString = csMimeType);
procedure GetEncoders(List: TStringList; CodecString: TCodecString = csMimeType);

Function GetDecoderCLSID(const MimeType: String): TCLSID;
Function GetEncoderCLSID(const MimeType: String): TCLSID;

implementation

uses
  Windows, SysUtils, DynLibUtils,
  StrRect,
  gdiplusimaging, gdiplusimagecodec, gdiplusflat;

Function VersionSupported: Integer;
begin
If LibraryIsPresent(GDIPLIB) then
  begin
    If SymbolIsPresent(GDIPLIB,'GdipImageSetAbort') then
      Result := 2
    else
      Result := 1;
  end
else Result := 0;
end;

//!!----------------------------------------------------------------------------

Function StatusAsStr(Status: TStatus): String;
begin
case Status of
  Ok:                         Result := 'Ok';
  GenericError:               Result := 'Generic error';
  InvalidParameter:           Result := 'Invalid parameter';
  OutOfMemory:                Result := 'Out of memory';
  ObjectBusy:                 Result := 'Object busy';
  InsufficientBuffer:         Result := 'Insufficient buffer';
  NotImplemented:             Result := 'Not implemented';
  Win32Error:                 Result := 'Win32 error';
  WrongState:                 Result := 'Wrong state';
  Aborted:                    Result := 'Aborted';
  FileNotFound:               Result := 'File not found';
  ValueOverflow:              Result := 'Value overflow';
  AccessDenied:               Result := 'Access denied';
  UnknownImageFormat:         Result := 'Unknown image format';
  FontFamilyNotFound:         Result := 'Font family not found';
  FontStyleNotFound:          Result := 'Font style not found';
  NotTrueTypeFont:            Result := 'Not TrueType font';
  UnsupportedGdiplusVersion:  Result := 'Unsupported Gdiplus version';
  GdiplusNotInitialized:      Result := 'Gdiplus not initialized';
  PropertyNotFound:           Result := 'Property not found';
  PropertyNotSupported:       Result := 'Property not supported';
{$IF GDIPVER >= $0110}
  ProfileNotFound:            Result := 'Profile not found';
{$IFEND}
else
  Result := Format('Unknown error (%d).',[Ord(Status)]);
end;
end;

//!!----------------------------------------------------------------------------

Function StatusCheck(Status: TStatus): Boolean;
begin
Result := Status = Ok;
end;

//!!----------------------------------------------------------------------------

Function StatusRaise(Status: TStatus): TStatus;
begin
Result := Status;
If Status <> Ok then
  raise EGDIPlusError.CreateFmt('GDI+ failed with error %d: %s.',[Ord(Status),StatusAsStr(Status)]);
end;

//!!----------------------------------------------------------------------------

procedure GetDecoders(List: TStringList; CodecString: TCodecString = csMimeType);
var
  Count,Size: UINT;
  Decoders:   PImageCodecInfo;
  MovingPtr:  PImageCodecInfo;
  i:          Integer;
begin
List.Clear;
If StatusCheck(GetImageDecodersSize(@Count,@Size)) then
  If Size > 0 then
    begin
      Decoders := AllocMem(Size);
      try
        If StatusCheck(GetImageDecoders(Count,Size,Decoders)) then
          begin
            MovingPtr := Decoders;
            For i := 0 to Pred(Count) do
              begin
                case CodecString of
                  csName:     List.Add(WideToStr(MovingPtr^.CodecName));
                  csDLLName:  List.Add(WideToStr(MovingPtr^.DllName));
                  csFmtDescr: List.Add(WideToStr(MovingPtr^.FormatDescription));
                  csFileExt:  List.Add(WideToStr(MovingPtr^.FilenameExtension));
                  csMimeType: List.Add(WideToStr(MovingPtr^.MimeType));
                end;
                Inc(MovingPtr);
              end;
          end;
      finally
        FreeMem(Decoders,Size);
      end;
    end;
end;

//!!----------------------------------------------------------------------------

procedure GetEncoders(List: TStringList; CodecString: TCodecString = csMimeType);
var
  Count,Size: UINT;
  Encoders:   PImageCodecInfo;
  MovingPtr:  PImageCodecInfo;
  i:          Integer;
begin
List.Clear;
If StatusCheck(GetImageEncodersSize(@Count,@Size)) then
  If Size > 0 then
    begin
      Encoders := AllocMem(Size);
      try
        If StatusCheck(GetImageEncoders(Count,Size,Encoders)) then
          begin
            MovingPtr := Encoders;
            For i := 0 to Pred(Count) do
              begin
                case CodecString of
                  csName:     List.Add(WideToStr(MovingPtr^.CodecName));
                  csDLLName:  List.Add(WideToStr(MovingPtr^.DllName));
                  csFmtDescr: List.Add(WideToStr(MovingPtr^.FormatDescription));
                  csFileExt:  List.Add(WideToStr(MovingPtr^.FilenameExtension));
                  csMimeType: List.Add(WideToStr(MovingPtr^.MimeType));
                end;
                Inc(MovingPtr);
              end;
          end;
      finally
        FreeMem(Encoders,Size);
      end;
    end;
end;

//!!----------------------------------------------------------------------------

Function GetDecoderCLSID(const MimeType: String): TCLSID;
var
  Count,Size: UINT;
  Decoders:   PImageCodecInfo;
  MovingPtr:  PImageCodecInfo;
  i:          Integer;
begin
If StatusCheck(GetImageDecodersSize(@Count,@Size)) then
  If Size > 0 then
    begin
      Decoders := AllocMem(Size);
      try
        If StatusCheck(GetImageDecoders(Count,Size,Decoders)) then
          begin
            MovingPtr := Decoders;
            For i := 0 to Pred(Count) do
              If WideStringCompare(MovingPtr^.MimeType,StrToWide(MimeType),False) = 0 then
                begin
                  Result := MovingPtr^.Clsid;
                  Exit;
                end
              else Inc(MovingPtr);
          end;
      finally
        FreeMem(Decoders,Size);
      end;
    end;
raise EGDIPlusCodecNotFound.CreateFmt('GetDecoderCLSID: Decoder for mime type "%s" not found.',[MimeType]);
end;

//!!----------------------------------------------------------------------------

Function GetEncoderCLSID(const MimeType: String): TCLSID;
var
  Count,Size: UINT;
  Encoders:   PImageCodecInfo;
  MovingPtr:  PImageCodecInfo;
  i:          Integer;
begin
If StatusCheck(GetImageEncodersSize(@Count,@Size)) then
  If Size > 0 then
    begin
      Encoders := AllocMem(Size);
      try
        If StatusCheck(GetImageEncoders(Count,Size,Encoders)) then
          begin
            MovingPtr := Encoders;
            For i := 0 to Pred(Count) do
              If WideStringCompare(MovingPtr^.MimeType,StrToWide(MimeType),False) = 0 then
                begin
                  Result := MovingPtr^.Clsid;
                  Exit;
                end
              else Inc(MovingPtr);
          end;
      finally
        FreeMem(Encoders,Size);
      end;
    end;
raise EGDIPlusCodecNotFound.CreateFmt('GetEncoderCLSID: Encoder for mime type "%s" not found.',[MimeType]);
end;

end.
