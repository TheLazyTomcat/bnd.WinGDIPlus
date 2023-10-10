(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusStringFormat.h
*
* Abstract:
*
*   GDI+ StringFormat class
*
\**************************************************************************)
unit gdiplusstringformat;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  gdiplus_common,
  gdiplusbase, gdiplusgpstubs, gdiplustypes, gdiplusenums;

{!!=============================================================================
    TStringFormat - class declaration
===============================================================================}
type
  TStringFormat = class(TGdiPlusBase)
  protected
    fNativeFormat:  PGpStringFormat;
    fLastError:     TStatus;
    Function GetNativeObject: Pointer; override;
    Function GetNativeObjectAddr: Pointer; override;
    Function SetStatus(NewStatus: TGpStatus): TStatus; 
    constructor Create(ClonedStringFormat: PGpStringFormat; Status: TStatus); overload;
  public
    constructor Create(FormatFlags: INT = 0; Language: LANGID = LANG_NEUTRAL); overload;
    {$message 'write warning - the result must be explicitly freed'}
  {!!
    Implementation of methods GenericDefault and GenericTypographic differs
    significantly from original C++ headers.

    In the original, these functions return pointer to a global variable that
    technically contains the requested object. Not going into the gory details,
    this would be problematic in pascal.

    Therefore here, these funtions are instead returning full unique instance
    of TStringFormat class. This means that, unlike in the original, you must
    manually free the returned object after you are done with it.
  }
    class Function GenericDefault: TStringFormat; 
    class Function GenericTypographic: TStringFormat; 
    constructor Create(Format: TStringFormat); overload;
    Function Clone: TStringFormat; 
    destructor Destroy; override;
    Function SetFormatFlags(Flags: INT): TStatus; 
    Function GetFormatFlags: INT;
    Function SetAlignment(Align: TStringAlignment): TStatus; 
    Function GetAlignment: TStringAlignment;
    Function SetLineAlignment(Align: TStringAlignment): TStatus; 
    Function GetLineAlignment: TStringAlignment;
    Function SetHotkeyPrefix(HotkeyPrefix: THotkeyPrefix): TStatus; 
    Function GetHotkeyPrefix: THotkeyPrefix;
    Function SetTabStops(FirstTabOffset: REAL; Count: INT; TabStops: PREAL): TStatus; 
    Function GetTabStopCount: INT; 
    Function GetTabStops(Count: INT; FirstTabOffset,TabStops: PREAL): TStatus;
    Function SetDigitSubstitution(Language: LANGID; Substitute: TStringDigitSubstitute): TStatus; 
    Function GetDigitSubstitutionLanguage: LANGID; 
    Function GetDigitSubstitutionMethod: TStringDigitSubstitute;
    Function SetTrimming(Trimming: TStringTrimming): TStatus; 
    Function GetTrimming: TStringTrimming;
    Function SetMeasurableCharacterRanges(RangeCount: INT; Ranges: PCharacterRange): TStatus; 
    Function GetMeasurableCharacterRangeCount: INT; 
    Function GetLastStatus: TStatus; 
  end;

implementation

uses
  gdiplusflat;

{!!=============================================================================
    TStringFormat - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TStringFormat - protected methods
-------------------------------------------------------------------------------}

Function TStringFormat.GetNativeObject: Pointer;
begin
Result := fNativeFormat;
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.GetNativeObjectAddr: Pointer;
begin
Result := Addr(fNativeFormat);
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.SetStatus(NewStatus: TGpStatus): TStatus;
begin
If NewStatus <> Ok then
  fLastError := NewStatus;
Result := NewStatus;
end;

//!!----------------------------------------------------------------------------

constructor TStringFormat.Create(ClonedStringFormat: PGpStringFormat; Status: TStatus);
begin
inherited Create;
fLastError := Status;
fNativeFormat := ClonedStringFormat;
end;

{!!-----------------------------------------------------------------------------
    TStringFormat - public methods
-------------------------------------------------------------------------------}

constructor TStringFormat.Create(FormatFlags: INT = 0; Language: LANGID = LANG_NEUTRAL);
begin
inherited Create;
fNativeFormat := nil;
fLastError := GdipCreateStringFormat(FormatFlags,Language,@fNativeFormat);
end;

//!!----------------------------------------------------------------------------

class Function TStringFormat.GenericDefault: TStringFormat;
var
  Status:       TStatus;
  NativeFormat: PGpStringFormat;
begin
Status := GdipStringFormatGetGenericDefault(@NativeFormat);
Result := TStringFormat.Create(NativeFormat,Status);
end;

//!!----------------------------------------------------------------------------

class Function TStringFormat.GenericTypographic: TStringFormat;
var
  Status:       TStatus;
  NativeFormat: PGpStringFormat;
begin
Status := GdipStringFormatGetGenericTypographic(@NativeFormat);
Result := TStringFormat.Create(NativeFormat,Status);
end;

//!!----------------------------------------------------------------------------

constructor TStringFormat.Create(Format: TStringFormat);
begin
inherited Create;
fNativeFormat := nil;
fLastError := GdipCloneStringFormat(Format.NativeObject,@fNativeFormat)
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.Clone: TStringFormat;
var
  ClonedStringFormat: PGpStringFormat;
begin
fLastError := GdipCloneStringFormat(fNativeFormat,@ClonedStringFormat);
If fLastError = Ok then
  Result := TStringFormat.Create(ClonedStringFormat,fLastError)
else
  Result := nil;
end;

//!!----------------------------------------------------------------------------

destructor TStringFormat.Destroy;
begin
GdipDeleteStringFormat(fNativeFormat);
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.SetFormatFlags(Flags: INT): TStatus;
begin
Result := SetStatus(GdipSetStringFormatFlags(fNativeFormat,Flags));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.GetFormatFlags: INT;
begin
SetStatus(GdipGetStringFormatFlags(fNativeFormat,@Result));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.SetAlignment(Align: TStringAlignment): TStatus;
begin
Result := SetStatus(GdipSetStringFormatAlign(fNativeFormat,Align));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.GetAlignment: TStringAlignment;
begin
SetStatus(GdipGetStringFormatAlign(fNativeFormat,@Result));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.SetLineAlignment(Align: TStringAlignment): TStatus;
begin
Result := SetStatus(GdipSetStringFormatLineAlign(fNativeFormat,Align));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.GetLineAlignment: TStringAlignment;
begin
SetStatus(GdipGetStringFormatLineAlign(fNativeFormat,@Result));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.SetHotkeyPrefix(HotkeyPrefix: THotkeyPrefix): TStatus;
begin
Result := SetStatus(GdipSetStringFormatHotkeyPrefix(fNativeFormat,INT(HotkeyPrefix)));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.GetHotkeyPrefix: THotkeyPrefix;
begin
SetStatus(GdipGetStringFormatHotkeyPrefix(fNativeFormat,@Result));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.SetTabStops(FirstTabOffset: REAL; Count: INT; TabStops: PREAL): TStatus;
begin
Result := SetStatus(GdipSetStringFormatTabStops(fNativeFormat,FirstTabOffset,Count,TabStops));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.GetTabStopCount: INT;
begin
SetStatus(GdipGetStringFormatTabStopCount(fNativeFormat,@Result));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.GetTabStops(Count: INT; FirstTabOffset,TabStops: PREAL): TStatus;
begin
Result := SetStatus(GdipGetStringFormatTabStops(fNativeFormat,Count,FirstTabOffset,TabStops));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.SetDigitSubstitution(Language: LANGID; Substitute: TStringDigitSubstitute): TStatus;
begin
Result := SetStatus(GdipSetStringFormatDigitSubstitution(fNativeFormat,Language,Substitute));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.GetDigitSubstitutionLanguage: LANGID;
begin
SetStatus(GdipGetStringFormatDigitSubstitution(fNativeFormat,@Result,nil));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.GetDigitSubstitutionMethod: TStringDigitSubstitute;
begin
SetStatus(GdipGetStringFormatDigitSubstitution(fNativeFormat,nil,@Result));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.SetTrimming(Trimming: TStringTrimming): TStatus;
begin
Result := SetStatus(GdipSetStringFormatTrimming(fNativeFormat,Trimming));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.GetTrimming: TStringTrimming;
begin
SetStatus(GdipGetStringFormatTrimming(fNativeFormat,@Result));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.SetMeasurableCharacterRanges(RangeCount: INT; Ranges: PCharacterRange): TStatus;
begin
Result := SetStatus(GdipSetStringFormatMeasurableCharacterRanges(fNativeFormat,RangeCount,Ranges));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.GetMeasurableCharacterRangeCount: INT;
begin
SetStatus(GdipGetStringFormatMeasurableCharacterRangeCount(fNativeFormat,@Result));
end;

//!!----------------------------------------------------------------------------

Function TStringFormat.GetLastStatus: TStatus;
begin
Result := fLastError;
fLastError := Ok;
end;

end.
