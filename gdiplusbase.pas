(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusBase.h
*
* Abstract:
*
*   GDI+ base memory allocation class
*
\**************************************************************************)
unit gdiplusbase;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  gdiplus_common;

{!!=============================================================================
    TGdiPlusWrapper - class declaration
===============================================================================}
{!!
  This class defines interface used when replacing some ternary operators used
  in the original source, namely operators of style...

      If Assigned(Obj) then
        Var := Obj.NativeObjectField
      else
        Var := nil;

    ...which might in the original look something like:

      Obj ? Obj->NativeObjectField : NULL
}
type
  TGdiPlusWrapper = class(TObject)
  protected
    Function GetNativeObject: Pointer; virtual; abstract;
    Function GetNativeObjectAddr: Pointer; virtual; abstract;
  public
    Function NativeObject: Pointer;
    Function NativeObjectAddr: Pointer;
  end;

type
  TGdiPlusBase = class(TGdiPlusWrapper);  //!! common ancestor for "big" objects

implementation

{!!=============================================================================
    TGdiPlusWrapper - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TGdiPlusWrapper - public methods
-------------------------------------------------------------------------------}

Function TGdiPlusWrapper.NativeObject: Pointer;
begin
If Assigned(Self) then
  Result := GetNativeObject
else
  Result := nil;
end;

//!!----------------------------------------------------------------------------

Function TGdiPlusWrapper.NativeObjectAddr: Pointer;
begin
If Assigned(Self) then
  Result := GetNativeObjectAddr
else
  raise EGDIPlusObjecNotAssigned.CreateFmt('TGdiPlusWrapper.NativeObjectAddr: Instance of class %s not assigned.',[ClassName]);
end;

end.
