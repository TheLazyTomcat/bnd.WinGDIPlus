{$IF not(defined(MSWINDOWS) or defined(WINDOWS))}
  {$MESSAGE FATAL 'Unsupported operating system.'}
{$IFEND}

{$IFDEF FPC}
  {$MODE ObjFPC}
  {$MODESWITCH DuplicateLocals+}
  {$MODESWITCH ClassicProcVars+}
  {$WARN 3031 OFF}  //!! Values in enumeration types have to be ascending
  {$WARN 3018 OFF}  //!! Constructor should be public
  {$INLINE ON}
  {$DEFINE CanInline}
  {$DEFINE FPC_DisableWarns}
  {$MACRO ON}
{$ELSE}
  {$IF CompilerVersion >= 17 then}  //!! Delphi 2005+
    {$DEFINE CanInline}
  {$ELSE}
    {$UNDEF CanInline}
  {$IFEND}
{$ENDIF}
{$H+}

{$MINENUMSIZE 4}
{$ALIGN 8}  //!! this should be default, but to be sure

{!!
  NewGDIP

  When this symbol is defined, then types, constants, functions, classes and
  methods from GDI+ version 1.1 are made accessible. When it is not defined,
  these objects are inccessible and are completely removed from compilation
  and only objects from GDI+ version 1.0 are provided.

  Defined by default.

  To disable/undefine this symbol in a project without changing this library,
  define project-wide symbol WinGDIPlus_NewGDIP_Off.
}
{$DEFINE NewGDIP}
{$IFDEF WinGDIPlus_NewGDIP_Off}
  {$UNDEF NewGDIP}
{$ENDIF}

{!!
  NewGDIPStatic

  When defined, the external functions from newer GDI+ versions (currently
  version 1.1) are statically bound/resolved.
  When not defined (the default state), then these functions are resolved
  dynamically and only if new GDI+ version is requested when initializing
  (calling GdiplusStartup).

  This is here to allow use of code that is calling these functions on older
  systems not supporting new GDI+ versions. There, the initialization and used
  code can be selected at runtime based on supported version (use provided
  helper function VersionSupported).
  If the symbols were resolved statically, it would lead to fatal error even if
  they would not be called.

    NOTE - this symbol has effect only when symbol NewGDIP is defined.

  Not defined by default.

  To enable/define this symbol in a project without changing this library,
  define project-wide symbol WinGDIPlus_NewGDIPStatic_ON.
}
{$UNDEF NewGDIPStatic}
{$IFDEF WinGDIPlus_NewGDIPStatic_ON}
  {$DEFINE NewGDIPStatic}
{$ENDIF}
