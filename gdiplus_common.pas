unit gdiplus_common;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows, SysUtils,
  AuxTypes;

type
  EGDIPlusException = class(Exception);

  EGDIPlusIndexOutOfBound = class(EGDIPlusException);

const
  GDIPVER = $0110; // for conditional compilation

  GDIPLIB = 'gdiplus.dll';

type
  INT = Int32;

  DWORDLONG = UInt64;
  
  size_t = PtrUInt;

  ULONG_PTR = PtrUInt;      PULONG_PTR = ^ULONG_PTR;

  RECTL = Windows.TRect;

  SIZEL = Windows.TSize;

  TCLSID = TGUID;

  UINT_PTR = PtrUInt;

  PROPID = ULONG;

implementation

end.
