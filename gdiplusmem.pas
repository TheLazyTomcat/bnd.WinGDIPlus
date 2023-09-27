(**************************************************************************\
*
* Copyright (c) 1998-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:
*
*   GdiplusMem.h
*
* Abstract:
*
*   GDI+ Private Memory Management APIs
*
\**************************************************************************)
unit gdiplusmem;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  gdiplus_common;

//----------------------------------------------------------------------------
// Memory Allocation APIs
//----------------------------------------------------------------------------

Function GdipAlloc(size: size_t): Pointer; stdcall; external GDIPLIB;

procedure GdipFree(ptr: Pointer); stdcall; external GDIPLIB;

implementation

end.
