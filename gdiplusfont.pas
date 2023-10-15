(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusFont.h
*
* Abstract:
*
*   GDI+ Font class
*
\**************************************************************************)
unit gdiplusfont;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  gdiplus_common,
  gdiplusheaders, gdiplustypes, gdiplusgpstubs, gdiplusenums, gdiplusfontfamily,
  gdiplusfontcollection;

{!!=============================================================================
    TFont - class declaration
===============================================================================}
type
  TFont = class(gdiplusheaders.TFont)
  protected
    constructor Create(Font: PGpFont; Status: TStatus); overload;
    procedure SetNativeFont(Font: PGpFont);
    Function SetStatus(Status: TStatus): TStatus;
  public
    constructor Create(hDC: HDC); overload;
    constructor Create(hDC: HDC; LogFont: PLogFontA); overload;
    constructor Create(hDC: HDC; LogFont: PLogFontW); overload;
    constructor Create(hDC: HDC; hFont: HFONT); overload;
    constructor Create(Family: TFontFamily; EmSize: REAL; Style: INT = FontStyleRegular; aUnit: TUnit = UnitPoint); overload;
    constructor Create(FamilyName: PWideChar; EmSize: REAL; Style: INT = FontStyleRegular; aUnit: TUnit = UnitPoint;
      FontCollection: TFontCollection = nil); overload;
    constructor Create(const FamilyName: String; EmSize: REAL; Style: INT = FontStyleRegular; aUnit: TUnit = UnitPoint;
      FontCollection: TFontCollection = nil); overload;
    Function GetLogFontA(G: TGraphics; LogFontA: PLOGFONTA): TStatus;
    Function GetLogFontW(G: TGraphics; LogFontW: PLOGFONTW): TStatus;
    Function GetLogFont(G: TGraphics; LogFont: PLOGFONT): TStatus;
    Function Clone: TFont;
    destructor Destroy; override;
    // Operations
    Function IsAvailable: BOOL;
    Function GetStyle: INT;
    Function GetSize: REAL;
    Function GetUnit: TUnit;
    Function GetLastStatus: TStatus;
    Function GetHeight(Graphics: TGraphics): REAL; overload;
    Function GetHeight(Dpi: REAL): REAL; overload;
    Function GetFamily(Family: TFontFamily): TStatus;
  end;

implementation

uses
  SysUtils,
  StrRect,
  gdiplusflat;

{!!=============================================================================
    TFont - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TFont - protected methods
-------------------------------------------------------------------------------}

constructor TFont.Create(Font: PGpFont; Status: TStatus);
begin
inherited Create;
fLastResult := Status;
SetNativeFont(Font);
end;

//!!----------------------------------------------------------------------------

procedure TFont.SetNativeFont(Font: PGpFont);
begin
fNativeFont := Font;
end;

//!!----------------------------------------------------------------------------

Function TFont.SetStatus(Status: TStatus): TStatus;
begin
If Status <> Ok then
  fLastResult := Status;
Result := Status;
end;

{!!-----------------------------------------------------------------------------
    TFont - public methods
-------------------------------------------------------------------------------}

constructor TFont.Create(hDC: HDC);
var
  Font: PGpFont;
begin
inherited Create;
Font := nil;
fLastResult := GdipCreateFontFromDC(hDC,@Font);
SetNativeFont(Font);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TFont.Create(hDC: HDC; LogFont: PLogFontA);
var
  Font: PGpFont;
begin
inherited Create;
Font := nil;
If Assigned(LogFont) then
  fLastResult := GdipCreateFontFromLogfontA(hDC,LogFont,@Font)
else
  fLastResult := GdipCreateFontFromDC(hDC,@Font);
SetNativeFont(Font);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TFont.Create(hDC: HDC; LogFont: PLogFontW);
var
  Font: PGpFont;
begin
inherited Create;
Font := nil;
If Assigned(LogFont) then
  fLastResult := GdipCreateFontFromLogfontW(hDC,LogFont,@Font)
else
  fLastResult := GdipCreateFontFromDC(hDC,@Font);
SetNativeFont(Font);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TFont.Create(hDC: HDC; hFont: HFONT);
var
  Font:     PGpFont;
  LogFont:  TLOGFONTA;
begin
inherited Create;
Font := nil;
If hFont <> 0 then
  begin
    If GetObjectA(hFont,SizeOf(TLOGFONTA),@LogFont) <> 0 then
      fLastResult := GdipCreateFontFromLogfontA(hDC,@LogFont,@Font)
    else
      fLastResult := GdipCreateFontFromDC(hDC,@Font);
  end
else fLastResult := GdipCreateFontFromDC(hDC,@Font);
SetNativeFont(Font);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TFont.Create(Family: TFontFamily; EmSize: REAL; Style: INT = FontStyleRegular; aUnit: TUnit = UnitPoint);
var
  Font: PGpFont;
begin
inherited Create;
Font := nil;
fLastResult := GdipCreateFont(Family.NativeObject,EmSize,Style,aUnit,@Font);
SetNativeFont(Font);
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TFont.Create(FamilyName: PWideChar; EmSize: REAL; Style: INT = FontStyleRegular; aUnit: TUnit = UnitPoint;
  FontCollection: TFontCollection = nil);
var
  Family: TFontFamily;
begin
inherited Create;
fNativeFont := nil;
Family := TFontFamily.Create(FamilyName,FontCollection);
try
  If Family.GetLastStatus <> Ok then
    begin
      FreeAndNil(Family);
      Family := TFontFamily.GenericSansSerif;
      fLastResult := Family.GetLastStatus;
      If fLastResult <> Ok then
        Exit;
    end;
  fLastResult := GdipCreateFont(Family.NativeObject,EmSize,Style,aUnit,@fNativeFont);
  //!! following seems to be just a copy of previous lines, but it is this way in the original source too
  If fLastResult <> Ok then
    begin
      FreeAndNil(Family);
      Family := TFontFamily.GenericSansSerif;
      fLastResult := Family.GetLastStatus;
      If fLastResult <> Ok then
        Exit;
      fLastResult := GdipCreateFont(Family.NativeObject,EmSize,Style,aUnit,@fNativeFont);
    end;
finally
  FreeAndNil(Family);
end;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TFont.Create(const FamilyName: String; EmSize: REAL; Style: INT = FontStyleRegular; aUnit: TUnit = UnitPoint;
  FontCollection: TFontCollection = nil);
begin
Create(PWideChar(StrToWide(FamilyName)),EmSize,Style,aUnit,FontCollection);
end;

//!!----------------------------------------------------------------------------

Function TFont.GetLogFontA(G: TGraphics; LogFontA: PLOGFONTA): TStatus;
begin
Result := SetStatus(GdipGetLogFontA(fNativeFont,G.NativeObject,LogFontA));
end;

//!!----------------------------------------------------------------------------

Function TFont.GetLogFontW(G: TGraphics; LogFontW: PLOGFONTW): TStatus;
begin
Result := SetStatus(GdipGetLogFontW(fNativeFont,G.NativeObject,LogFontW));
end;

//!!----------------------------------------------------------------------------

Function TFont.GetLogFont(G: TGraphics; LogFont: PLOGFONT): TStatus;
begin
Result := SetStatus(GdipGetLogFont(fNativeFont,G.NativeObject,LogFont));
end;

//!!----------------------------------------------------------------------------

Function TFont.Clone: TFont;
var
  CloneFont: PGpFont;
begin
CloneFont := nil;
SetStatus(GdipCloneFont(fNativeFont,@CloneFont));
Result := TFont.Create(CloneFont,fLastResult);
end;

//!!----------------------------------------------------------------------------

destructor TFont.Destroy;
begin
GdipDeleteFont(fNativeFont);
end;

//!!----------------------------------------------------------------------------

Function TFont.IsAvailable: BOOL;
begin
Result := Assigned(fNativeFont);
end;

//!!----------------------------------------------------------------------------

Function TFont.GetStyle: INT;
begin
SetStatus(GdipGetFontStyle(fNativeFont,@Result));
end;

//!!----------------------------------------------------------------------------

Function TFont.GetSize: REAL;
begin
SetStatus(GdipGetFontSize(fNativeFont,@Result));
end;

//!!----------------------------------------------------------------------------

Function TFont.GetUnit: TUnit;
begin
SetStatus(GdipGetFontUnit(fNativeFont,@Result));
end;

//!!----------------------------------------------------------------------------

Function TFont.GetLastStatus: TStatus;
begin
Result := fLastResult;
end;

//!!----------------------------------------------------------------------------

Function TFont.GetHeight(Graphics: TGraphics): REAL;
begin
SetStatus(GdipGetFontHeight(fNativeFont,Graphics.NativeObject,@Result));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TFont.GetHeight(Dpi: REAL): REAL;
begin
SetStatus(GdipGetFontHeightGivenDPI(fNativeFont,Dpi,@Result));
end;

//!!----------------------------------------------------------------------------

type
  //!! exposing protected methods
  TFontFamily_ = class(TFontFamily);  {$message 'remove when joining'} 

Function TFont.GetFamily(Family: TFontFamily): TStatus;
var
  Status: TStatus;
begin
If Assigned(Family) then
  begin
    Status := GdipGetFamily(fNativeFont,Family.NativeObjectAddr);
    TFontFamily_(Family).SetStatus(Status);
    Result := SetStatus(Status);
  end
else Result := SetStatus(InvalidParameter);
end;

end.
