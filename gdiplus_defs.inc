{$IF not(defined(MSWINDOWS) or defined(WINDOWS))}
  {$MESSAGE FATAL 'Unsupported operating system.'}
{$IFEND}

{$IFDEF FPC}
  {$MODE ObjFPC}
  {$INLINE ON}
  {$DEFINE CanInline}
{$ELSE}
  {$IF CompilerVersion >= 17 then}  // Delphi 2005+
    {$DEFINE CanInline}
  {$ELSE}
    {$UNDEF CanInline}
  {$IFEND}
{$ENDIF}
{$H+}

{$MINENUMSIZE 4}
{$ALIGN 8}  // this should be default, but to be sure

{$DEFINE NewGDIP}

{$DEFINE ShowHints}
