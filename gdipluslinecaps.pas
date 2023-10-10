(**************************************************************************\
* 
* Copyright (c) 2000-2001, Microsoft Corp.  All Rights Reserved.
*
* Module Name:        
* 
*    GdiplusLineCaps.h
*
* Abstract:
*
*   GDI+ CustomLineCap APIs
*
\**************************************************************************)
unit gdipluslinecaps;

{$INCLUDE '.\gdiplus_defs.inc'}

interface

uses
  Windows,
  gdiplusheaders, gdiplustypes, gdiplusgpstubs, gdipluspath, gdiplusenums;

{!!=============================================================================
    TCustomLineCap - class declaration
===============================================================================}
type
  TCustomLineCap = class(gdiplusheaders.TCustomLineCap)
  protected
    fLastResult:  TStatus;
    constructor Create; overload;
    constructor Create(NativeCapArg: PGpCustomLineCap; Status: TStatus); overload;
    procedure SetNativeCap(NativeCapArg: PGpCustomLineCap);
    Function SetStatus(Status: TStatus): TStatus;
  public
    constructor Create(FillPath,StrokePath: TGraphicsPath; BaseCap: TLineCap = LineCapFlat; BaseInset: REAL = 0); overload;
    destructor Destroy; override;
    Function Clone: TCustomLineCap; virtual;
    // This changes both the start and end cap.
    Function SetStrokeCap(StrokeCap: TLineCap): TStatus;
    Function SetStrokeCaps(StartCap,EndCap: TLineCap): TStatus;
    Function GetStrokeCaps(StartCap,EndCap: PLineCap): TStatus;
    Function SetStrokeJoin(LineJoin: TLineJoin): TStatus;
    Function GetStrokeJoin: TLineJoin;
    Function SetBaseCap(BaseCap: TLineCap): TStatus;
    Function GetBaseCap: TLineCap;
    Function SetBaseInset(Inset: REAL): TStatus;
    Function GetBaseInset: REAL;
    Function SetWidthScale(WidthScale: REAL): TStatus;
    Function GetWidthScale: REAL;
    Function GetLastStatus: TStatus;
  end;

{!!=============================================================================
    TAdjustableArrowCap - class declaration
===============================================================================}
type
  TAdjustableArrowCap = class(TCustomLineCap)
  public
    constructor Create(Height,Width: REAL; IsFilled: BOOL = True); overload;
    Function SetHeight(Height: REAL): TStatus;
    Function GetHeight: REAL;
    Function SetWidth(Width: REAL): TStatus;
    Function GetWidth: REAL;
    Function SetMiddleInset(MiddleInset: REAL): TStatus;
    Function GetMiddleInset: REAL; 
    Function SetFillState(IsFilled: BOOL): TStatus;
    Function IsFilled: BOOL;
  end;

implementation

uses
  gdiplusflat;

{!!=============================================================================
    TCustomLineCap - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TCustomLineCap - protected methods
-------------------------------------------------------------------------------}

constructor TCustomLineCap.Create;
begin
inherited Create;
fNativeCap := nil;
fLastResult := Ok;
end;

//!! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

constructor TCustomLineCap.Create(NativeCapArg: PGpCustomLineCap; Status: TStatus);
begin
Create; //!! do not call inherited constructor
fLastResult := Status;
SetNativeCap(NativeCapArg);
end;

//!!----------------------------------------------------------------------------

procedure TCustomLineCap.SetNativeCap(NativeCapArg: PGpCustomLineCap);
begin
fNativeCap := NativeCapArg;
end;

//!!----------------------------------------------------------------------------

Function TCustomLineCap.SetStatus(Status: TStatus): TStatus;
begin
If Status <> Ok then
  fLastResult := Status;
Result := Status;
end;

{!!-----------------------------------------------------------------------------
    TCustomLineCap - public methods
-------------------------------------------------------------------------------}

constructor TCustomLineCap.Create(FillPath,StrokePath: TGraphicsPath; BaseCap: TLineCap = LineCapFlat; BaseInset: REAL = 0);
begin
Create;
fNativeCap := nil;
fLastResult := GdipCreateCustomLineCap(FillPath.NativeObject,StrokePath.NativeObject,BaseCap,BaseInset,@fNativeCap);
end;

//!!----------------------------------------------------------------------------

destructor TCustomLineCap.Destroy;
begin
GdipDeleteCustomLineCap(fNativeCap);
inherited;
end;

//!!----------------------------------------------------------------------------

Function TCustomLineCap.Clone: TCustomLineCap;
var
  NewNativeLineCap: PGpCustomLineCap;
begin
NewNativeLineCap := nil;
SetStatus(GdipCloneCustomLineCap(fNativeCap,@NewNativeLineCap));
If fLastResult = Ok then
  begin
    Result := TCustomLineCap.Create(NewNativeLineCap,fLastResult);
    If not Assigned(Result) then
      SetStatus(GdipDeleteCustomLineCap(NewNativeLineCap));
  end
else Result := nil;
end;

//!!----------------------------------------------------------------------------

Function TCustomLineCap.SetStrokeCap(StrokeCap: TLineCap): TStatus;
begin
Result := SetStrokeCaps(StrokeCap,StrokeCap);
end;

//!!----------------------------------------------------------------------------

Function TCustomLineCap.SetStrokeCaps(StartCap,EndCap: TLineCap): TStatus;
begin
Result := SetStatus(GdipSetCustomLineCapStrokeCaps(fNativeCap,StartCap,EndCap));
end;

//!!----------------------------------------------------------------------------

Function TCustomLineCap.GetStrokeCaps(StartCap,EndCap: PLineCap): TStatus;
begin
Result := SetStatus(GdipGetCustomLineCapStrokeCaps(fNativeCap,PGpLineCap(StartCap),PGpLineCap(EndCap)));
end;

//!!----------------------------------------------------------------------------

Function TCustomLineCap.SetStrokeJoin(LineJoin: TLineJoin): TStatus;
begin
Result := SetStatus(GdipSetCustomLineCapStrokeJoin(fNativeCap,LineJoin));
end;

//!!----------------------------------------------------------------------------

Function TCustomLineCap.GetStrokeJoin: TLineJoin;
begin
SetStatus(GdipGetCustomLineCapStrokeJoin(fNativeCap,@Result));
end;

//!!----------------------------------------------------------------------------

Function TCustomLineCap.SetBaseCap(BaseCap: TLineCap): TStatus;
begin
Result := SetStatus(GdipSetCustomLineCapBaseCap(fNativeCap,BaseCap));
end;

//!!----------------------------------------------------------------------------

Function TCustomLineCap.GetBaseCap: TLineCap;
begin
SetStatus(GdipGetCustomLineCapBaseCap(fNativeCap,@Result));
end;

//!!----------------------------------------------------------------------------

Function TCustomLineCap.SetBaseInset(Inset: REAL): TStatus;
begin
Result := SetStatus(GdipSetCustomLineCapBaseInset(fNativeCap,Inset));
end;

//!!----------------------------------------------------------------------------

Function TCustomLineCap.GetBaseInset: REAL;
begin
SetStatus(GdipGetCustomLineCapBaseInset(fNativeCap,@Result));
end;

//!!----------------------------------------------------------------------------

Function TCustomLineCap.SetWidthScale(WidthScale: REAL): TStatus;
begin
Result := SetStatus(GdipSetCustomLineCapWidthScale(fNativeCap,WidthScale));
end;

//!!----------------------------------------------------------------------------

Function TCustomLineCap.GetWidthScale: REAL;
begin
SetStatus(GdipGetCustomLineCapWidthScale(fNativeCap,@Result));
end;

//!!----------------------------------------------------------------------------

Function TCustomLineCap.GetLastStatus: TStatus;
begin
Result := fLastResult;
fLastResult := Ok;
end;


{!!=============================================================================
    TAdjustableArrowCap - class implementation
===============================================================================}
{!!-----------------------------------------------------------------------------
    TAdjustableArrowCap - public methods
-------------------------------------------------------------------------------}

constructor TAdjustableArrowCap.Create(Height,Width: REAL; IsFilled: BOOL = True);
var
  Cap:  PGpAdjustableArrowCap;
begin
inherited Create;
Cap := nil;
fLastResult := GdipCreateAdjustableArrowCap(Height,Width,IsFilled,@Cap);
SetNativeCap(PGpCustomLineCap(Cap));
end;

//!!----------------------------------------------------------------------------

Function TAdjustableArrowCap.SetHeight(Height: REAL): TStatus;
begin
Result := SetStatus(GdipSetAdjustableArrowCapHeight(PGpAdjustableArrowCap(fNativeCap),Height));
end;

//!!----------------------------------------------------------------------------

Function TAdjustableArrowCap.GetHeight: REAL;
begin
SetStatus(GdipGetAdjustableArrowCapHeight(PGpAdjustableArrowCap(fNativeCap),@Result));
end;

//!!----------------------------------------------------------------------------

Function TAdjustableArrowCap.SetWidth(Width: REAL): TStatus;
begin
Result := SetStatus(GdipSetAdjustableArrowCapWidth(PGpAdjustableArrowCap(fNativeCap),Width));
end;

//!!----------------------------------------------------------------------------

Function TAdjustableArrowCap.GetWidth: REAL;
begin
SetStatus(GdipGetAdjustableArrowCapWidth(PGpAdjustableArrowCap(fNativeCap),@Result));
end;

//!!----------------------------------------------------------------------------

Function TAdjustableArrowCap.SetMiddleInset(MiddleInset: REAL): TStatus;
begin
Result := SetStatus(GdipSetAdjustableArrowCapMiddleInset(PGpAdjustableArrowCap(fNativeCap),MiddleInset));
end;

//!!----------------------------------------------------------------------------

Function TAdjustableArrowCap.GetMiddleInset: REAL;
begin
SetStatus(GdipGetAdjustableArrowCapMiddleInset(PGpAdjustableArrowCap(fNativeCap),@Result));
end;

//!!----------------------------------------------------------------------------

Function TAdjustableArrowCap.SetFillState(IsFilled: BOOL): TStatus;
begin
Result := SetStatus(GdipSetAdjustableArrowCapFillState(PGpAdjustableArrowCap(fNativeCap),IsFilled));
end;

//!!----------------------------------------------------------------------------

Function TAdjustableArrowCap.IsFilled: BOOL;
begin
SetStatus(GdipGetAdjustableArrowCapFillState(PGpAdjustableArrowCap(fNativeCap),@Result));
end;

end.
