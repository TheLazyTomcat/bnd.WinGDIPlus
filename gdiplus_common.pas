unit gdiplus_common;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows, SysUtils, ActiveX,
  AuxTypes;

{!!-----------------------------------------------------------------------------
    Library-specific exceptions
-------------------------------------------------------------------------------}
type
  EGDIPlusException = class(Exception);

  EGDIPlusIndexOutOfBounds = class(EGDIPlusException);

{!!-----------------------------------------------------------------------------
    Constant and types
-------------------------------------------------------------------------------}
const
  GDIPLIB = 'gdiplus.dll';

type
  INT = Int32;              PINT = ^INT;

  DWORDLONG = UInt64;
  
  size_t = PtrUInt;

  ULONG_PTR = PtrUInt;      PULONG_PTR = ^ULONG_PTR;

  RECTL = Windows.TRect;

  SIZEL = Windows.TSize;

  TCLSID = TGUID;

  UINT_PTR = PtrUInt;

  PROPID = ULONG;

  float = Single;

  PHRGN = ^HRGN;

  PHBITMAP = ^HBITMAP;

  PHICON = ^HICON;

  HINSTANCE = THandle;

  PHDC = ^HDC;

  PHENHMETAFILE = ^HENHMETAFILE; 

  HANDLE = THandle;

  PIStream = ^IStream;

  PLANGID = ^LANGID;

  LPBYTE = PByte; 

//!! translation starts here ===================================================
const
  GDIPVER = {$IFDEF NewGDIP}$0110{$ELSE}$0100{$ENDIF};  //** for conditional compilation

type
  //!! just some placeholder I assume
  IDirectDrawSurface7  = IUnknown;
  PIDirectDrawSurface7 = ^IDirectDrawSurface7;

implementation

end.
