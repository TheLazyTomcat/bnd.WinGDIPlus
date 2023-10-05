(**************************************************************************
*
* Copyright (c) 2000-2003 Microsoft Corporation
*
* Module Name:
*
*   Gdiplus initialization
*
* Abstract:
*
*   GDI+ Startup and Shutdown APIs
*
**************************************************************************)
unit gdiplusinit;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  AuxTypes,
  gdiplus_common,
  gdiplustypes;

type
  TDebugEventLevel = (
    DebugEventLevelFatal,
    DebugEventLevelWarning
  );
  PDebugEventLevel = ^TDebugEventLevel;

// Callback function that GDI+ can call, on debug builds, for assertions
// and warnings.
type
  //!! dunno about ansi vs unicode, the only declaration in gdipluinit.h is "..., CHAR *message);"
  TDebugEventProc = procedure(level: TDebugEventLevel; message: PAnsiChar); stdcall;

// Notification functions which the user must call appropriately if
// "SuppressBackgroundThread" (below) is set.
type
  TNotificationHookProc   = Function(token: PULONG_PTR): TStatus; stdcall;
  TNotificationUnhookProc = procedure(token: ULONG_PTR); stdcall;

// Input structure for GdiplusStartup()
type
  TGdiplusStartupInput = record
    GdiplusVersion:           UINT32;           // Must be 1  (or 2 for the Ex version)
    DebugEventCallback:       TDebugEventProc;  // Ignored on free builds
    SuppressBackgroundThread: BOOL;             // FALSE unless you're prepared to call
                                                // the hook/unhook functions properly
    SuppressExternalCodecs:   BOOL;             // FALSE unless you want GDI+ only to use
                                                // its internal image codecs.
  end;
  PGdiplusStartupInput = ^TGdiplusStartupInput;

Function GdiplusStartupInput(
  debugEventCallback:       TDebugEventProc = nil;
  suppressBackgroundThread: BOOL = False;
  suppressExternalCodecs:   BOOL = False): TGdiplusStartupInput;


{$IF GDIPVER >= $0110}
type
  TGdiplusStartupInputEx = record
    GdiplusVersion:           UINT32;
    DebugEventCallback:       TDebugEventProc;
    SuppressBackgroundThread: BOOL;
    SuppressExternalCodecs:   BOOL;
    StartupParameters:        Int;  // Do we not set the FPU rounding mode
  end;
  PGdiplusStartupInputEx = ^TGdiplusStartupInputEx;

Function GdiplusStartupInputEx(
  startupParameters:        INT = 0;
  debugEventCallback:       TDebugEventProc = nil;
  suppressBackgroundThread: BOOL = False;
  suppressExternalCodecs:   BOOL = False): TGdiplusStartupInputEx;

type
  TGdiplusStartupParams = INT;
const
  GdiplusStartupDefault          = 0;     
  GdiplusStartupNoSetRound       = 1;
  GdiplusStartupSetPSValue       = 2;
  GdiplusStartupTransparencyMask = INT($FF000000);

{$IFEND}

// Output structure for GdiplusStartup()
type
  TGdiplusStartupOutput = record
    // The following 2 fields are NULL if SuppressBackgroundThread is FALSE.
    // Otherwise, they are functions which must be called appropriately to
    // replace the background thread.
    //
    // These should be called on the application's main message loop - i.e.
    // a message loop which is active for the lifetime of GDI+.
    // "NotificationHook" should be called before starting the loop,
    // and "NotificationUnhook" should be called after the loop ends.
    NotificationHook:   TNotificationHookProc;
    NotificationUnhook: TNotificationUnhookProc;
  end;
  PGdiplusStartupOutput = ^TGdiplusStartupOutput;

// GDI+ initialization. Must not be called from DllMain - can cause deadlock.
//
// Must be called before GDI+ API's or constructors are used.
//
// token  - may not be NULL - accepts a token to be passed in the corresponding
//          GdiplusShutdown call.
// input  - may not be NULL
// output - may be NULL only if input->SuppressBackgroundThread is FALSE.
Function GdiplusStartup(token: PULONG_PTR; input: PGdiplusStartupInput; output: PGdiplusStartupOutput): TStatus; stdcall; external GDIPLIB;

// GDI+ termination. Must be called before GDI+ is unloaded. 
// Must not be called from DllMain - can cause deadlock.
//
// GDI+ API's may not be called after GdiplusShutdown. Pay careful attention
// to GDI+ object destructors.
procedure GdiplusShutdown(token: ULONG_PTR); stdcall; external GDIPLIB;

implementation

Function GdiplusStartupInput(
  debugEventCallback:       TDebugEventProc = nil;
  suppressBackgroundThread: BOOL = False;
  suppressExternalCodecs:   BOOL = False): TGdiplusStartupInput;
begin
Result.GdiplusVersion := 1;
Result.DebugEventCallback := debugEventCallback;
Result.SuppressBackgroundThread := suppressBackgroundThread;
Result.SuppressExternalCodecs := suppressExternalCodecs;
end;

{$IF GDIPVER >= $0110}
//!!----------------------------------------------------------------------------

Function GdiplusStartupInputEx(
  startupParameters:        INT = 0;
  debugEventCallback:       TDebugEventProc = nil;
  suppressBackgroundThread: BOOL = False;
  suppressExternalCodecs:   BOOL = False): TGdiplusStartupInputEx;
begin
Result.GdiplusVersion := 2;
Result.DebugEventCallback := debugEventCallback;
Result.SuppressBackgroundThread := suppressBackgroundThread;
Result.SuppressExternalCodecs := suppressExternalCodecs;
Result.StartupParameters := startupParameters;
end;
{$IFEND}

end.
