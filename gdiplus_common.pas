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

  EGDIPlusError = class(EGDIPlusException);
  EGDIPlusIndexOutOfBounds = class(EGDIPlusException);
  EGDIPlusObjecNotAssigned = class(EGDIPlusException);
  
{!!-----------------------------------------------------------------------------
    Constants and types
-------------------------------------------------------------------------------}
const
  GDIPLIB = 'gdiplus.dll';

type
  // integer types
  INT       = Int32;        PINT = ^INT;
  DWORDLONG = UInt64;
  size_t    = PtrUInt;
  ULONG_PTR = PtrUInt;      PULONG_PTR = ^ULONG_PTR;
  UINT_PTR  = PtrUInt;
  PROPID    = ULONG;

  // handle types
  HINSTANCE = THandle;
  HANDLE = THandle;

  // floating-point types
  float = Single;

  // pointer types
  PHRGN         = ^HRGN;
  PHBITMAP      = ^HBITMAP;
  PHICON        = ^HICON;
  PHDC          = ^HDC;
  PIStream      = ^IStream;
  PLANGID       = ^LANGID;
  LPBYTE        = PByte;
  PHENHMETAFILE = ^HENHMETAFILE;

  // structured types
  RECTL  = Windows.TRect;
  SIZEL  = Windows.TSize;
  TCLSID = TGUID;

//!! translation starts here ===================================================
const
  GDIPVER = {$IFDEF NewGDIP}$0110{$ELSE}$0100{$ENDIF};  //!! for conditional compilation

type
  //!! just some placeholder I assume
  IDirectDrawSurface7  = IUnknown;

implementation

end.
