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
