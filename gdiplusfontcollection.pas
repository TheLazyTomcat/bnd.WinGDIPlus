(**************************************************************************\
*
* Copyright (c) 2000, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
* 
*   GdiplusFontCollection.h
*
* Abstract:
*
*   Font collections (Installed and Private)
*
\**************************************************************************)
unit gdiplusfontcollection;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  gdiplus_common,
  gdiplusheaders, gdiplustypes;

{!!=============================================================================
    TFontCollection - class declaration
===============================================================================}
type
  TFontCollection = class(gdiplusheaders.TFontCollection)
  protected
    Function SetStatus(Status: TStatus): TStatus;
  public
    constructor Create;
    Function GetFamilyCount: INT;
    Function GetFamilies(NumSought: INT; Gpfamilies: PFontFamily; NumFound: PINT): TStatus;
    Function GetLastStatus: TStatus;
  end;

{!!=============================================================================
    TInstalledFontCollection - class declaration
===============================================================================}
type
  TInstalledFontCollection = class(TFontCollection)
  public
    constructor Create;
  end;

{!!=============================================================================
    TPrivateFontCollection - class declaration
===============================================================================}
type
  TPrivateFontCollection = class(TFontCollection)
  public
    constructor Create;
    destructor Destroy; override;
    Function AddFontFile(Filename: PWideChar): TStatus; overload;
    Function AddFontFile(const Filename: String): TStatus; overload;
    Function AddMemoryFont(Memory: Pointer; Length: INT): TStatus;
  end;

implementation

uses
  StrRect,
  gdiplusflat, gdiplusgpstubs;

{!!=============================================================================
    TFontCollection - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TFontCollection - protected methods
-------------------------------------------------------------------------------}

Function TFontCollection.SetStatus(Status: TStatus): TStatus;
begin
fLastResult := Status;
Result := fLastResult;
end;

{!!-----------------------------------------------------------------------------
    TFontCollection - public methods
-------------------------------------------------------------------------------}

constructor TFontCollection.Create;
begin
inherited Create;
fNativeFontCollection := nil;
end;

//!!----------------------------------------------------------------------------

Function TFontCollection.GetFamilyCount: INT;
begin
Result := 0;
fLastResult := GdipGetFontCollectionFamilyCount(fNativeFontCollection,@Result);
end;

//!!----------------------------------------------------------------------------

Function TFontCollection.GetFamilies(NumSought: INT; Gpfamilies: PFontFamily; NumFound: PINT): TStatus;
var
  NativeFamilyList: array of PGpFontFamily;
  i:                Integer;
begin
If (NumSought > 0) and Assigned(Gpfamilies) and Assigned(NumFound) then
  begin
    NumFound^ := 0;
    SetLength(NativeFamilyList,NumSought);
    If Length(NativeFamilyList) > 0 then
      begin
        Result := SetStatus(GdipGetFontCollectionFamilyList(fNativeFontCollection,
          NumSought,Pointer(NativeFamilyList),NumFound));
        If Result = Ok then
          For i := 0 to Pred(NumFound^) do
            GdipCloneFontFamily(NativeFamilyList[i],PFontFamilyArray(Gpfamilies)^[i].NativeObjectAddr);
        SetLength(NativeFamilyList,0);  
      end
    else Result := SetStatus(OutOfMemory);
  end
else Result := SetStatus(InvalidParameter);
end;

//!!----------------------------------------------------------------------------

Function TFontCollection.GetLastStatus: TStatus;
begin
Result := fLastResult;
end;


{!!=============================================================================
    TInstalledFontCollection - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TInstalledFontCollection - public methods
-------------------------------------------------------------------------------}

constructor TInstalledFontCollection.Create;
begin
inherited Create;
fNativeFontCollection := nil;
fLastResult := GdipNewInstalledFontCollection(@fNativeFontCollection);
end;


{!!=============================================================================
    TPrivateFontCollection - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TPrivateFontCollection - public methods
-------------------------------------------------------------------------------}

constructor TPrivateFontCollection.Create;
begin
inherited Create;
fNativeFontCollection := nil;
fLastResult := GdipNewPrivateFontCollection(@fNativeFontCollection);
end;

//!!----------------------------------------------------------------------------

destructor TPrivateFontCollection.Destroy;
begin
GdipDeletePrivateFontCollection(@fNativeFontCollection);
inherited;
end;

//!!----------------------------------------------------------------------------

Function TPrivateFontCollection.AddFontFile(Filename: PWideChar): TStatus;
begin
Result := SetStatus(GdipPrivateAddFontFile(fNativeFontCollection,Filename));
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function TPrivateFontCollection.AddFontFile(const Filename: String): TStatus;
begin
Result := AddFontFile(PWideChar(StrToWide(Filename)));
end;

//!!----------------------------------------------------------------------------

Function TPrivateFontCollection.AddMemoryFont(Memory: Pointer; Length: INT): TStatus;
begin
Result := SetStatus(GdipPrivateAddMemoryFont(fNativeFontCollection,Memory,Length));
end;

end.
