unit gdiplus_helpers;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Classes,
  gdiplus_common,
  gdiplustypes;

Function GDIPCheck(Status: TStatus): Boolean;
procedure GDIPError(Status: TStatus);

type
  TCodecTextType = (cttName,cttDLLName,cttFmtDescr,cttFileExt,cttMimeType);

procedure GetDecoders(List: TStringList; CodecTextType: TCodecTextType = cttMimeType);
procedure GetEncoders(List: TStringList; CodecTextType: TCodecTextType = cttMimeType);

Function GetDecoderCLSID(const MimeType: String): TCLSID;
Function GetEncoderCLSID(const MimeType: String): TCLSID;

implementation

uses
  Windows, SysUtils,
  StrRect,
  gdiplusimaging, gdiplusimagecodec;

Function GDIPCheck(Status: TStatus): Boolean;
begin
Result := Status = Ok;
end;

//!!----------------------------------------------------------------------------

procedure GDIPError(Status: TStatus);
begin
If Status <> Ok then
  raise EGDIPlusError.CreateFmt('GDI+ error %d.',[Ord(Status)]);
end;

//!!----------------------------------------------------------------------------

procedure GetDecoders(List: TStringList; CodecTextType: TCodecTextType = cttMimeType);
var
  Count,Size: UINT;
  Decoders:   PImageCodecInfo;
  MovingPtr:  PImageCodecInfo;
  i:          Integer;
begin
List.Clear;
If GDIPCheck(GetImageDecodersSize(@Count,@Size)) then
  If Size > 0 then
    begin
      Decoders := AllocMem(Size);
      try
        If GDIPCheck(GetImageDecoders(Count,Size,Decoders)) then
          begin
            MovingPtr := Decoders;
            For i := 0 to Pred(Count) do
              begin
                case CodecTextType of
                  cttName:      List.Add(WideToStr(MovingPtr^.CodecName));
                  cttDLLName:   List.Add(WideToStr(MovingPtr^.DllName));
                  cttFmtDescr:  List.Add(WideToStr(MovingPtr^.FormatDescription));
                  cttFileExt:   List.Add(WideToStr(MovingPtr^.FilenameExtension));
                  cttMimeType:  List.Add(WideToStr(MovingPtr^.MimeType));
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

procedure GetEncoders(List: TStringList; CodecTextType: TCodecTextType = cttMimeType);
var
  Count,Size: UINT;
  Encoders:   PImageCodecInfo;
  MovingPtr:  PImageCodecInfo;
  i:          Integer;
begin
List.Clear;
If GDIPCheck(GetImageEncodersSize(@Count,@Size)) then
  If Size > 0 then
    begin
      Encoders := AllocMem(Size);
      try
        If GDIPCheck(GetImageEncoders(Count,Size,Encoders)) then
          begin
            MovingPtr := Encoders;
            For i := 0 to Pred(Count) do
              begin
                case CodecTextType of
                  cttName:      List.Add(WideToStr(MovingPtr^.CodecName));
                  cttDLLName:   List.Add(WideToStr(MovingPtr^.DllName));
                  cttFmtDescr:  List.Add(WideToStr(MovingPtr^.FormatDescription));
                  cttFileExt:   List.Add(WideToStr(MovingPtr^.FilenameExtension));
                  cttMimeType:  List.Add(WideToStr(MovingPtr^.MimeType));
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
If GDIPCheck(GetImageDecodersSize(@Count,@Size)) then
  If Size > 0 then
    begin
      Decoders := AllocMem(Size);
      try
        If GDIPCheck(GetImageDecoders(Count,Size,Decoders)) then
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
raise EGDIPlusCodecNotFound.CreateFmt('GetDecoderCLSID: Decooder for mime type "%d" not found.',[MimeType]);
end;

//!!----------------------------------------------------------------------------

Function GetEncoderCLSID(const MimeType: String): TCLSID;
var
  Count,Size: UINT;
  Encoders:   PImageCodecInfo;
  MovingPtr:  PImageCodecInfo;
  i:          Integer;
begin
If GDIPCheck(GetImageEncodersSize(@Count,@Size)) then
  If Size > 0 then
    begin
      Encoders := AllocMem(Size);
      try
        If GDIPCheck(GetImageEncoders(Count,Size,Encoders)) then
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
raise EGDIPlusCodecNotFound.CreateFmt('GetEncoderCLSID: Encooder for mime type "%d" not found.',[MimeType]);
end;

end.
