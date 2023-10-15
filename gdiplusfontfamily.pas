(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusFontFamily.h
*
* Abstract:
*
*   GDI+ Font Family class
*
\**************************************************************************)
unit gdiplusfontfamily;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  AuxTypes,
  gdiplus_common,
  gdiplusheaders, gdiplustypes, gdiplusgpstubs, gdiplusfontcollection;

{!!=============================================================================
    TFontFamily - class declaration
===============================================================================}
type
  TFontFamily = class(gdiplusheaders.TFontFamily)
  protected
    Function SetStatus(Status: TStatus): TStatus;
    constructor Create(NativeFamily: PGpFontFamily; Status: TStatus); overload;
  public
    constructor Create; overload;
    constructor Create(Name: PWideChar; FontCollection: TFontCollection = nil); overload;
    constructor Create(const Name: String; FontCollection: TFontCollection = nil); overload;
    destructor Destroy; override;
  {!!
    Unlike in original C++ source, the following functions are returning unique
    instances of TFontFamily, which means they must be explicitly freed.
  }
    class Function GenericSansSerif: TFontFamily;
    class Function GenericSerif: TFontFamily;
    class Function GenericMonospace: TFontFamily;
    //!! Name must point to a buffer LF_FACESIZE wide characters (not bytes!) long
    Function GetFamilyName(Name: PWideChar; Language: LANGID = 0): TStatus; overload;
    Function GetFamilyName(out Name: String; Language: LANGID = 0): TStatus; overload;
    Function Clone: TFontFamily;
    Function IsAvailable: BOOL;
    Function IsStyleAvailable(Style: INT): BOOL;
    Function GetEmHeight(Style: INT): UINT16;
    Function GetCellAscent(Style: INT): UINT16;
    Function GetCellDescent(Style: INT): UINT16;
    Function GetLineSpacing(Style: INT): UINT16;
    Function GetLastStatus: TStatus;
  end;

implementation

uses
  StrRect,
  gdiplusflat;

{!!=============================================================================
    TFontFamily - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TFontFamily - protected methods
-------------------------------------------------------------------------------}

Function TFontFamily.SetStatus(Status: TStatus): TStatus;
begin
If Status <> Ok then
  fLastResult := Status;
Result := Status;
end;

//!!----------------------------------------------------------------------------

constructor TFontFamily.Create(NativeFamily: PGpFontFamily; Status: TStatus);
begin
inherited Create;
fLAstResult := Status;
fNativeFamily := NativeFamily;
end;

{!!-----------------------------------------------------------------------------
    TFontFamily - public methods
-------------------------------------------------------------------------------}

constructor TFontFamily.Create;
begin
inherited Create;
fNativeFamily := nil;
fLastResult := Ok;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TFontFamily.Create(Name: PWideChar; FontCollection: TFontCollection = nil);
begin
inherited Create;
fNativeFamily := nil;
fLastResult := GdipCreateFontFamilyFromName(Name,FontCollection.NativeObject,@fNativeFamily);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TFontFamily.Create(const Name: String; FontCollection: TFontCollection = nil);
begin
Create(PWideChar(StrToWide(Name)),FontCollection);
end;

//!!----------------------------------------------------------------------------

destructor TFontFamily.Destroy;
begin
GdipDeleteFontFamily(fNativeFamily);
inherited;
end;

//!!----------------------------------------------------------------------------

class Function TFontFamily.GenericSansSerif: TFontFamily;
var
  NativeFontFamily: PGpFontFamily;
  Status:           TStatus;
begin
Status := GdipGetGenericFontFamilySansSerif(@NativeFontFamily);
Result := TFontFamily.Create(NativeFontFamily,Status);
end;

//!!----------------------------------------------------------------------------

class Function TFontFamily.GenericSerif: TFontFamily;
var
  NativeFontFamily: PGpFontFamily;
  Status:           TStatus;
begin
Status := GdipGetGenericFontFamilySerif(@NativeFontFamily);
Result := TFontFamily.Create(NativeFontFamily,Status);
end;

//!!----------------------------------------------------------------------------

class Function TFontFamily.GenericMonospace: TFontFamily;
var
  NativeFontFamily: PGpFontFamily;
  Status:           TStatus;
begin
Status := GdipGetGenericFontFamilyMonospace(@NativeFontFamily);
Result := TFontFamily.Create(NativeFontFamily,Status);
end;

//!!----------------------------------------------------------------------------

Function TFontFamily.GetFamilyName(Name: PWideChar; Language: LANGID = 0): TStatus;
begin
Result := SetStatus(GdipGetFamilyName(fNativeFamily,Name,Language));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TFontFamily.GetFamilyName(out Name: String; Language: LANGID = 0): TStatus;
var
  Buffer: WideString;
begin
SetLength(Buffer,LF_FACESIZE);
Result := GetFamilyName(PWideChar(Buffer),Language);
Name := WideToStr(Buffer);
end;

//!!----------------------------------------------------------------------------

Function TFontFamily.Clone: TFontFamily;
var
  ClonedFamily: PGpFontFamily;
begin
ClonedFamily := nil;
SetStatus(GdipCloneFontFamily(fNativeFamily,@ClonedFamily));
Result := TFontFamily.Create(ClonedFamily,fLastResult);
end;

//!!----------------------------------------------------------------------------

Function TFontFamily.IsAvailable: BOOL;
begin
Result := Assigned(fNativeFamily);
end;

//!!----------------------------------------------------------------------------

Function TFontFamily.IsStyleAvailable(Style: INT): BOOL;
begin
If SetStatus(GdipIsStyleAvailable(fNativeFamily,Style,@Result)) <> Ok then
  Result := False;
end;

//!!----------------------------------------------------------------------------

Function TFontFamily.GetEmHeight(Style: INT): UINT16;
begin
SetStatus(GdipGetEmHeight(fNativeFamily,Style,@Result));
end;

//!!----------------------------------------------------------------------------

Function TFontFamily.GetCellAscent(Style: INT): UINT16;
begin
SetStatus(GdipGetCellAscent(fNativeFamily,Style,@Result));
end;

//!!----------------------------------------------------------------------------

Function TFontFamily.GetCellDescent(Style: INT): UINT16;
begin
SetStatus(GdipGetCellDescent(fNativeFamily,Style,@Result));
end;

//!!----------------------------------------------------------------------------

Function TFontFamily.GetLineSpacing(Style: INT): UINT16;
begin
SetStatus(GdipGetLineSpacing(fNativeFamily,Style,@Result));
end;

//!!----------------------------------------------------------------------------

Function TFontFamily.GetLastStatus: TStatus;
begin
Result := fLastResult;
fLastResult := Ok;
end;

end.
