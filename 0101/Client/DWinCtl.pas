{------------------------------------------------------------------------------}
{ 单元名称: DWinCtl.pas                                                        }
{                                                                              }
{ 单元作者: 未知  修改作者: 清清                                               }
{ 创建日期: 未知                                                               }
{                                                                              }
{ 功能介绍: 控件实现单元                                                       }
{ 修改: 增加DTEDIT控件                                                         }
{ 20080623: 增加BUTTON Moveed属性. 功能：当鼠标移动到控件上,此函数为TRUE       }
{------------------------------------------------------------------------------}
unit DWinCtl;

interface

uses
  Windows, Classes, Graphics, Controls, DXDraws, 
  Grids, Wil, Clipbrd;


type
   TClickSound = (csNone, csStone, csGlass, csNorm);
   TDControl = class;
   TOnDirectPaint = procedure(Sender: TObject; dsurface: TDirectDrawSurface) of object;
   TOnKeyPress = procedure(Sender: TObject; var Key: Char) of object;
   TOnKeyDown = procedure(Sender: TObject; var Key: word; Shift: TShiftState) of object;
   TOnMouseMove = procedure(Sender: TObject; Shift: TShiftState; X, Y: integer) of object;
   TOnMouseDown = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer) of object;
   TOnMouseUp = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer) of object;
   TOnClick = procedure(Sender: TObject) of object;
   TOnClickEx = procedure(Sender: TObject; X, Y: integer) of object;
   TOnInRealArea = procedure(Sender: TObject; X, Y: integer; var IsRealArea: Boolean) of object;
   TOnGridSelect = procedure(Sender: TObject; ACol, ARow: integer; Shift: TShiftState) of object;
   TOnGridPaint = procedure(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface) of object;
   TOnClickSound = procedure(Sender: TObject; Clicksound: TClickSound) of object;

   TDControl = class (TCustomControl)
   private
      FCaption: string;      //0x1F0
      FDParent: TDControl;   //0x1F4
      FEnableFocus: Boolean; //0x1F8
      FOnDirectPaint: TOnDirectPaint; //0x1FC
      FOnKeyPress: TOnKeyPress; //0x200
      FOnKeyDown: TOnKeyDown;   //0x204
      FOnMouseMove: TOnMouseMove; //0x208
      FOnMouseDown: TOnMouseDown; //0x20C
      FOnMouseUp: TOnMouseUp;     //0x210
      FOnDblClick: TNotifyEvent;  //0x214
      FOnClick: TOnClickEx;       //0x218
      FOnInRealArea: TOnInRealArea; //0x21C
      FOnBackgroundClick: TOnClick; //0x220
      procedure SetCaption (str: string);
   protected
      FVisible: Boolean;
   public
      Background: Boolean; //0x24D
      DControls: TList;    //0x250
      //FaceSurface: TDirectDrawSurface;
      WLib: TWMImages;     //0x254
      FaceIndex: integer;  //0x258
      WantReturn: Boolean; //Background老锭, Click狼 荤侩 咯何..
      constructor Create (AOwner: TComponent); override;
      destructor Destroy; override;
      procedure Paint; override;
      procedure Loaded; override;
      function  SurfaceX (x: integer): integer;
      function  SurfaceY (y: integer): integer;
      function  LocalX (x: integer): integer;
      function  LocalY (y: integer): integer;
      procedure AddChild (dcon: TDControl);
      procedure ChangeChildOrder (dcon: TDControl);
      function  InRange (x, y: integer): Boolean;
      function  KeyPress (var Key: Char): Boolean; dynamic;
      function  KeyDown (var Key: Word; Shift: TShiftState): Boolean; dynamic;
      function  MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; dynamic;
      function  MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; dynamic;
      function  MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; dynamic;
      function  DblClick (X, Y: integer): Boolean; dynamic;
      function  Click (X, Y: integer): Boolean; dynamic;

      function  CanFocusMsg: Boolean;
      function  Focused: Boolean;

      procedure SetImgIndex (Lib: TWMImages; index: integer);
      procedure DirectPaint (dsurface: TDirectDrawSurface); dynamic;

   published
      property OnDirectPaint: TOnDirectPaint read FOnDirectPaint write FOnDirectPaint;
      property OnKeyPress: TOnKeyPress read FOnKeyPress write FOnKeyPress;
      property OnKeyDown: TOnKeyDown read FOnKeyDown write FOnKeyDown;
      property OnMouseMove: TOnMouseMove read FOnMouseMove write FOnMouseMove;
      property OnMouseDown: TOnMouseDown read FOnMouseDown write FOnMouseDown;
      property OnMouseUp: TOnMouseUp read FOnMouseUp write FOnMouseUp;
      property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
      property OnClick: TOnClickEx read FOnClick write FOnClick;
      property OnInRealArea: TOnInRealArea read FOnInRealArea write FOnInRealArea;
      property OnBackgroundClick: TOnClick read FOnBackgroundClick write FOnBackgroundClick;
      property Caption: string read FCaption write SetCaption;
      property DParent: TDControl read FDParent write FDParent;
      property Visible: Boolean read FVisible write FVisible;
      property EnableFocus: Boolean read FEnableFocus write FEnableFocus;
      property Color;
      property Font;
      property Hint;
      property ShowHint;
      property Align;
   end;

   TDButton = class (TDControl)
   private
      FClickSound: TClickSound;
      FOnClick: TOnClickEx;
      FOnClickSound: TOnClickSound;
   public
      Downed: Boolean;
      Moveed: Boolean; //20080624
      constructor Create (AOwner: TComponent); override;
      function  MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
      function  MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
      function  MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
   published
      property ClickCount: TClickSound read FClickSound write FClickSound;
      property OnClick: TOnClickEx read FOnClick write FOnClick;
      property OnClickSound: TOnClickSound read FOnClickSound write FOnClickSound;
   end;

   TDGrid = class (TDControl)
   private
      FColCount, FRowCount: integer;
      FColWidth, FRowHeight: integer;
      FViewTopLine: integer;
      SelectCell: TPoint;
      DownPos: TPoint;
      FOnGridSelect: TOnGridSelect;
      FOnGridMouseMove: TOnGridSelect;
      FOnGridPaint: TOnGridPaint;
      function  GetColRow (x, y: integer; var acol, arow: integer): Boolean;
   public
      CX, CY: integer;
      Col, Row: integer;
      constructor Create (AOwner: TComponent); override;
      function  MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
      function  MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
      function  MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
      function  Click (X, Y: integer): Boolean; override;
      procedure DirectPaint (dsurface: TDirectDrawSurface); override;
   published
      property ColCount: integer read FColCount write FColCount;
      property RowCount: integer read FRowCount write FRowCount;
      property ColWidth: integer read FColWidth write FColWidth;
      property RowHeight: integer read FRowHeight write FRowHeight;
      property ViewTopLine: integer read FViewTopLine write FViewTopLine;
      property OnGridSelect: TOnGridSelect read FOnGridSelect write FOnGridSelect;
      property OnGridMouseMove: TOnGridSelect read FOnGridMouseMove write FOnGridMouseMove;
      property OnGridPaint: TOnGridPaint read FOnGridPaint write FOnGridPaint;
   end;

   TDWindow = class (TDButton)
   private
      FFloating: Boolean;
      SpotX, SpotY: integer;
   protected
      procedure SetVisible (flag: Boolean);
   public
      DialogResult: TModalResult;
      constructor Create (AOwner: TComponent); override;
      function  MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
      function  MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
      function  MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
      procedure Show;
      function  ShowModal: integer;
   published
      property Visible: Boolean read FVisible write SetVisible;
      property Floating: Boolean read FFloating write FFloating;
   end;


   TDWinManager = class (TComponent)
   private
   public
      DWinList: TList; //list of TDControl;
      constructor Create (AOwner: TComponent); override;
      destructor Destroy; override;
      procedure AddDControl (dcon: TDControl; visible: Boolean);
      procedure DelDControl (dcon: TDControl);
      procedure ClearAll;

      function  KeyPress (var Key: Char): Boolean;
      function  KeyDown (var Key: Word; Shift: TShiftState): Boolean;
      function  MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
      function  MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
      function  MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
      function  DblClick (X, Y: integer): Boolean;
      function  Click (X, Y: integer): Boolean;
      procedure DirectPaint (dsurface: TDirectDrawSurface);
   end;


  TDEdit = class(TDControl)
  private
     FText: Widestring;
     FOnChange:TNotifyEvent;
     FFont:TFont;
     F3D:boolean;
     FColor:TColor;
     FTransparent:boolean;
     FMaxLength: Integer;
     XDif:integer;
     FSelCol:TColor;
     CursorTime:integer;
     InputStr:string;
     KeyByteCount: Byte;
     boDoubleByte: Boolean;
     SelStart:integer;
     SelStop:integer;
     procedure DoMove; //光标闪烁
     procedure DelSelText;
     function CopySelText():string;
     procedure SetText (str: Widestring);
     procedure SetMaxLength(const Value: Integer);
  protected
     DrawFocused:boolean;
     DrawEnabled:boolean;
     DrawHovered:boolean;
     CursorVisible:boolean;
     BlinkSpeed:integer;
     Hovered:boolean;
     function  KeyDown (var Key: Word; Shift: TShiftState): Boolean; override;
     function  KeyPress (var Key: Char): Boolean; override;
     function  MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
     function  MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
     function  MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
     function  GetSelCount:integer;
  public
     Moveed: Boolean; //20080624
     procedure SetFocus();
     property SelCount:integer read GetSelCount;
     function MouseToSelPos(AX:integer):integer;
     procedure DirectPaint (dsurface: TDirectDrawSurface); override;
     procedure Update;override;
     constructor Create (AOwner: TComponent); override;
     destructor Destroy; override;
  published
     property OnChange:TNotifyEvent read FOnChange write FOnChange;
     property Text: Widestring read FText write SetText;
     property MaxLength: Integer read FMaxLength write SetMaxLength;
     property Font:TFont read FFont write FFont;
     property Ctrl3D:boolean read F3D write F3D;
     property Color:TColor read FColor write FColor;
     property SelectionColor:TColor read FSelCol write FSelCol;
     property Transparent:boolean read FTransparent write FTransparent;
  end;

   TDCheckBox = class (TDControl)
   private
      FClickSound: TClickSound;
      FOnClick: TOnClickEx;
      FOnClickSound: TOnClickSound;
      FChecked: Boolean;
    procedure SetChecked(Value: Boolean);
    function GetChecked: Boolean;
   public
      Moveed: Boolean; //20080624
      constructor Create (AOwner: TComponent); override;
      function  MouseMove (Shift: TShiftState; X, Y: Integer): Boolean; override;
      //procedure DirectPaint (dsurface: TDirectDrawSurface); override;
      function  MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
      function  MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
   published
      property ClickCount: TClickSound read FClickSound write FClickSound;
      property Checked: Boolean read GetChecked write SetChecked;
      property OnClick: TOnClickEx read FOnClick write FOnClick;
      property OnClickSound: TOnClickSound read FOnClickSound write FOnClickSound;
   end;


procedure Register;
procedure SetDFocus (dcon: TDControl);
procedure ReleaseDFocus;
procedure SetDCapture (dcon: TDControl);
procedure ReleaseDCapture;

var
   MouseCaptureControl: TDControl; //mouse message
   FocusedControl: TDControl; //Key message
   MainWinHandle: integer;
   ModalDWindow: TDControl;
implementation

procedure Register;
begin
   RegisterComponents('MirGame', [TDWinManager, TDControl, TDButton, TDGrid, TDWindow, TDEdit, TDCheckBox]);
end;


procedure SetDFocus (dcon: TDControl);
begin
   FocusedControl := dcon;
end;

procedure ReleaseDFocus;
begin
   FocusedControl := nil;
end;

procedure SetDCapture (dcon: TDControl);
begin
   SetCapture (MainWinHandle);
   MouseCaptureControl := dcon;
end;

procedure ReleaseDCapture;
begin
   ReleaseCapture;
   MouseCaptureControl := nil;
end;

{----------------------------- TDControl -------------------------------}

constructor TDControl.Create (AOwner: TComponent);
begin
   inherited Create (AOwner);
   DParent := nil;
   inherited Visible := FALSE;
   FEnableFocus := FALSE;
   Background := FALSE;
   FOnDirectPaint := nil;
   FOnKeyPress := nil;
   FOnKeyDown := nil;
   FOnMouseMove := nil;
   FOnMouseDown := nil;
   FOnMouseUp := nil;
   FOnInRealArea := nil;
   DControls := TList.Create;
   FDParent := nil;

   Width := 80;
   Height:= 24;
   FCaption := '';
   FVisible := TRUE;
   //FaceSurface := nil;
   WLib := nil;
   FaceIndex := 0;
end;

destructor TDControl.Destroy;
begin
   DControls.Free;
   inherited Destroy;
end;

function TDControl.Focused: Boolean;  //20080624
begin
  if FocusedControl = Self then Result := True
  else Result := False;
end;

procedure TDControl.SetCaption (str: string);
begin
   FCaption := str;
   if csDesigning in ComponentState then begin
      Refresh;
   end;
end;

procedure TDControl.Paint;
begin
   if csDesigning in ComponentState then begin
      if self is TDWindow then begin
         with Canvas do begin
            Pen.Color := clBlack;
            MoveTo (0, 0);
            LineTo (Width-1, 0);
            LineTo (Width-1, Height-1);
            LineTo (0, Height-1);
            LineTo (0, 0);
            LineTo (Width-1, Height-1);
            MoveTo (Width-1, 0);
            LineTo (0, Height-1);
            TextOut ((Width-TextWidth(Caption)) div 2, (Height-TextHeight(Caption)) div 2, Caption);
         end;
      end else begin
         with Canvas do begin
            Pen.Color := clBlack;
            MoveTo (0, 0);
            LineTo (Width-1, 0);
            LineTo (Width-1, Height-1);
            LineTo (0, Height-1);
            LineTo (0, 0);
            TextOut ((Width-TextWidth(Caption)) div 2, (Height-TextHeight(Caption)) div 2, Caption);
         end;
      end;
   end;
end;

procedure TDControl.Loaded;
var
   i: integer;
   dcon: TDControl;
begin
   if not (csDesigning in ComponentState) then begin
      if Parent <> nil then
         if TControl(Parent).ComponentCount > 0 then //20080629
         for i:=0 to TControl(Parent).ComponentCount-1 do begin
            if TControl(Parent).Components[i] is TDControl then begin
               dcon := TDControl(TControl(Parent).Components[i]);
               if dcon.DParent = self then begin
                  AddChild (dcon);
               end;
            end;
         end;
   end;
end;

//瘤开 谅钎甫 傈眉 谅钎肺 官厕
function  TDControl.SurfaceX (x: integer): integer;
var
   d: TDControl;
begin
   d := self;
   while TRUE do begin
      if d.DParent = nil then break;
      x := x + d.DParent.Left;
      d := d.DParent;
   end;
   Result := x;
end;

function  TDControl.SurfaceY (y: integer): integer;
var
   d: TDControl;
begin
   d := self;
   while TRUE do begin
      if d.DParent = nil then break;
      y := y + d.DParent.Top;
      d := d.DParent;
   end;
   Result := y;
end;

//傈眉谅钎甫 按眉狼 谅钎肺 官厕
function  TDControl.LocalX (x: integer): integer;
var
   d: TDControl;
begin
   d := self;
   while TRUE do begin
      if d.DParent = nil then break;
      x := x - d.DParent.Left;
      d := d.DParent;
   end;
   Result := x;
end;

function  TDControl.LocalY (y: integer): integer;
var
   d: TDControl;
begin
   d := self;
   while TRUE do begin
      if d.DParent = nil then break;
      y := y - d.DParent.Top;
      d := d.DParent;
   end;
   Result := y;
end;

procedure TDControl.AddChild (dcon: TDControl);
begin
   DControls.Add (Pointer (dcon));
end;

procedure TDControl.ChangeChildOrder (dcon: TDControl);
var
   i: integer;
begin
   if not (dcon is TDWindow) then exit;
   //if TDWindow(dcon).Floating then begin  //20081024修改
      if DControls.Count > 0 then //20080629
      for i:=0 to DControls.Count-1 do begin
         if dcon = DControls[i] then begin
            DControls.Delete (i);
            break;
         end;
      end;
      DControls.Add (dcon);
   //end;
end;

function  TDControl.InRange (x, y: integer): Boolean;
var
   inrange: Boolean;
   d: TDirectDrawSurface;
begin
   if (x >= Left) and (x < Left+Width) and (y >= Top) and (y < Top+Height) then begin
      inrange := TRUE;
      if Assigned (FOnInRealArea) then
         FOnInRealArea(self, x-Left, y-Top, inrange)
      else
         if WLib <> nil then begin
            d := WLib.Images[FaceIndex];
            if d <> nil then
               if d.Pixels[x-Left, y-Top] <= 0 then
                  inrange := FALSE;
         end;
      Result := inrange;
   end else
      Result := FALSE;
end;

function  TDControl.KeyPress (var Key: Char): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if Background then exit;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TDControl(DControls[i]).Visible then
         if TDControl(DControls[i]).KeyPress(Key) then begin
            Result := TRUE;
            exit;
         end;
   if (FocusedControl=self) then begin
      if Assigned (FOnKeyPress) then FOnKeyPress (self, Key);
      Result := TRUE;
   end;
end;

function  TDControl.KeyDown (var Key: Word; Shift: TShiftState): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if Background then exit;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TDControl(DControls[i]).Visible then
         if TDControl(DControls[i]).KeyDown(Key, Shift) then begin
            Result := TRUE;
            exit;
         end;
   if (FocusedControl=self) then begin
      if Assigned (FOnKeyDown) then FOnKeyDown (self, Key, Shift);
      Result := TRUE;
   end;
end;

function  TDControl.CanFocusMsg: Boolean;
begin
   if (MouseCaptureControl = nil) or ((MouseCaptureControl <> nil) and ((MouseCaptureControl=self) or (MouseCaptureControl=DParent))) then
      Result := TRUE
   else
      Result := FALSE;
end;

function  TDControl.MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TDControl(DControls[i]).Visible then 
         if TDControl(DControls[i]).MouseMove(Shift, X-Left, Y-Top) then begin
            Result := TRUE;
            exit;
         end;

   if (MouseCaptureControl <> nil) then begin //MouseCapture 捞搁 磊脚捞 快急
      if (MouseCaptureControl = self) then begin
         if Assigned (FOnMouseMove) then
            FOnMouseMove (self, Shift, X, Y);
         Result := TRUE;
      end;
      exit;
   end;

   if Background then exit;
   if InRange (X, Y) then begin
      if Assigned (FOnMouseMove) then
         FOnMouseMove (self, Shift, X, Y);
      Result := TRUE;
   end;
end;

function  TDControl.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   //showmessage('11');
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TDControl(DControls[i]).Visible then
         if TDControl(DControls[i]).MouseDown(Button, Shift, X-Left, Y-Top) then begin
            //showmessage('22');
            Result := TRUE;
            exit;
         end;
   if Background then begin
      if Assigned (FOnBackgroundClick) then begin
         WantReturn := FALSE;
         FOnBackgroundClick (self);
         if WantReturn then Result := TRUE;
      end;
      ReleaseDFocus;
      exit;
   end;
   if CanFocusMsg then begin
      if InRange (X, Y) or (MouseCaptureControl = self) then begin
         if Assigned (FOnMouseDown) then
            FOnMouseDown (self, Button, Shift, X, Y);
         if EnableFocus then SetDFocus (self);
         //else ReleaseDFocus;
         Result := TRUE;
      end;
   end;
end;

function  TDControl.MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TDControl(DControls[i]).Visible then
         if TDControl(DControls[i]).MouseUp(Button, Shift, X-Left, Y-Top) then begin
            Result := TRUE;
            exit;
         end;

   if (MouseCaptureControl <> nil) then begin //MouseCapture 捞搁 磊脚捞 快急
      if (MouseCaptureControl = self) then begin
         if Assigned (FOnMouseUp) then
            FOnMouseUp (self, Button, Shift, X, Y);
         Result := TRUE;
      end;
      exit;
   end;

   if Background then exit;
   if InRange (X, Y) then begin
      if Assigned (FOnMouseUp) then
         FOnMouseUp (self, Button, Shift, X, Y);
      Result := TRUE;
   end;
end;

function  TDControl.DblClick (X, Y: integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if (MouseCaptureControl <> nil) then begin //MouseCapture 捞搁 磊脚捞 快急
      if (MouseCaptureControl = self) then begin
         if Assigned (FOnDblClick) then
            FOnDblClick (self);
         Result := TRUE;
      end;
      exit;
   end;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TDControl(DControls[i]).Visible then
         if TDControl(DControls[i]).DblClick(X-Left, Y-Top) then begin
            Result := TRUE;
            exit;
         end;
   if Background then exit;
   if InRange (X, Y) then begin
      if Assigned (FOnDblClick) then
         FOnDblClick (self);
      Result := TRUE;
   end;
end;

function  TDControl.Click (X, Y: integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if (MouseCaptureControl <> nil) then begin //MouseCapture 捞搁 磊脚捞 快急
      if (MouseCaptureControl = self) then begin
         if Assigned (FOnClick) then
            FOnClick (self, X, Y);
         Result := TRUE;
      end;
      exit;
   end;
   if DControls.Count > 0 then //20080629
   for i:=DControls.Count-1 downto 0 do
      if TDControl(DControls[i]).Visible then
         if TDControl(DControls[i]).Click(X-Left, Y-Top) then begin
            Result := TRUE;
            exit;
         end;
   if Background then exit;
   if InRange (X, Y) then begin
      if Assigned (FOnClick) then
         FOnClick (self, X, Y);
      Result := TRUE;
   end;
end;

procedure TDControl.SetImgIndex (Lib: TWMImages; index: integer);
var
   d: TDirectDrawSurface;
begin
   //FaceSurface := dsurface;
   if Lib <> nil then begin
      d := Lib.Images[index];
      WLib := Lib;
      FaceIndex := index;
      if d <> nil then begin
        Width := d.Width;
        Height := d.Height;
      end;
   end;
end;

procedure TDControl.DirectPaint (dsurface: TDirectDrawSurface);
var
   i: integer;
   d: TDirectDrawSurface;
begin
   if Assigned (FOnDirectPaint) then
      FOnDirectPaint (self, dsurface)
   else
      if WLib <> nil then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   if DControls.Count > 0 then //20080629
   for i:=0 to DControls.Count-1 do
      if TDControl(DControls[i]).Visible then
         TDControl(DControls[i]).DirectPaint (dsurface);
end;


{--------------------- TDButton --------------------------}


constructor TDButton.Create (AOwner: TComponent);
begin
   inherited Create (AOwner);
   Downed := FALSE;
   Moveed := False;
   FOnClick := nil;
   FEnableFocus := TRUE;
   FClickSound := csNone;
end;

function  TDButton.MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
begin
   Result := inherited MouseMove (Shift, X, Y);
   Moveed := Result;
   if (not Background) and (not Result) then begin
      Result := inherited MouseMove (Shift, X, Y);
      if MouseCaptureControl = self then
         if InRange (X, Y) then
          Downed := TRUE
         else
          Downed := FALSE;
   end;
end;

function  TDButton.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseDown (Button, Shift, X, Y) then begin
      if (not Background) and (MouseCaptureControl=nil) then begin
         Downed := TRUE;
         SetDCapture (self);
      end;
      Result := TRUE;
   end;
end;

function  TDButton.MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseUp (Button, Shift, X, Y) then begin
      ReleaseDCapture;
      if not Background then begin
         if InRange (X, Y) then begin
            if Assigned (FOnClickSound) then FOnClickSound(self, FClickSound);
            if Assigned (FOnClick) then FOnClick(self, X, Y);
         end;
      end;
      Downed := FALSE;
      Result := TRUE;
      exit;
   end else begin
      ReleaseDCapture;
      Downed := FALSE;
   end;
end;

{------------------------- TDGrid --------------------------}

constructor TDGrid.Create (AOwner: TComponent);
begin
   inherited Create (AOwner);
   FColCount := 8;
   FRowCount := 5;
   FColWidth := 36;
   FRowHeight:= 32;
   FOnGridSelect := nil;
   FOnGridMouseMove := nil;
   FOnGridPaint := nil;
end;

function  TDGrid.GetColRow (x, y: integer; var acol, arow: integer): Boolean;
begin
   Result := FALSE;
   if InRange (x, y) then begin
      acol := (x-Left) div FColWidth;
      arow := (y-Top) div FRowHeight;
      Result := TRUE;
   end;
end;

function  TDGrid.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
   acol, arow: integer;
begin
   Result := FALSE;
   if mbLeft = Button then begin
      if GetColRow (X, Y, acol, arow) then begin
         SelectCell.X := acol;
         SelectCell.Y := arow;
         DownPos.X := X;
         DownPos.Y := Y;
         SetDCapture (self);
         Result := TRUE;
      end;
   end;
end;

function  TDGrid.MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
var
   acol, arow: integer;
begin
   Result := FALSE;
   if InRange (X, Y) then begin
      if GetColRow (X, Y, acol, arow) then begin
         if Assigned (FOnGridMouseMove) then
            FOnGridMouseMove (self, acol, arow, Shift);
      end;
      Result := TRUE;
   end;
end;

function  TDGrid.MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
   acol, arow: integer;
begin
   Result := FALSE;
   if mbLeft = Button then begin
      if GetColRow (X, Y, acol, arow) then begin
         if (SelectCell.X = acol) and (SelectCell.Y = arow) then begin
            Col := acol;
            Row := arow;
            if Assigned (FOnGridSelect) then
               FOnGridSelect (self, acol, arow, Shift);
         end;
         Result := TRUE;
      end;
      ReleaseDCapture;
   end;
end;

function  TDGrid.Click (X, Y: integer): Boolean;
{var
   acol, arow: integer; }
begin
   Result := FALSE;
  { if GetColRow (X, Y, acol, arow) then begin
      if Assigned (FOnGridSelect) then
         FOnGridSelect (self, acol, arow, []);
      Result := TRUE;
   end; }
end;

procedure TDGrid.DirectPaint (dsurface: TDirectDrawSurface);
var
   i, j: integer;
   rc: TRect;
begin
   if Assigned (FOnGridPaint) then
      if FRowCount > 0 then //20080629
      for i:=0 to FRowCount-1 do
         for j:=0 to FColCount-1 do begin
            rc := Rect (Left + j*FColWidth, Top + i*FRowHeight, Left+j*(FColWidth+1)-1, Top+i*(FRowHeight+1)-1);
            if (SelectCell.Y = i) and (SelectCell.X = j) then
               FOnGridPaint (self, j, i, rc, [gdSelected], dsurface)
            else FOnGridPaint (self, j, i, rc, [], dsurface);
         end;
end;


{--------------------- TDWindown --------------------------}


constructor TDWindow.Create (AOwner: TComponent);
begin
   inherited Create (AOwner);
   FFloating := FALSE;
   FEnableFocus := TRUE;
   Width := 120;
   Height := 120;
end;

procedure TDWindow.SetVisible (flag: Boolean);
begin
   FVisible := flag;
   if Floating then begin
      if DParent <> nil then
         DParent.ChangeChildOrder (self);
   end;
end;

function  TDWindow.MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
//var
  // al, at: integer;
begin
   Result := inherited MouseMove (Shift, X, Y);
   if Result and FFloating and (MouseCaptureControl=self) then begin
      if (SpotX <> X) or (SpotY <> Y) then begin
         Left := Left + (X - SpotX);
         Top := Top + (Y - SpotY);
         //if al+Width < WINLEFT then al := WINLEFT - Width;
         //if al > WINRIGHT then al := WINRIGHT;
         //if at+Height < WINTOP then at := WINTOP - Height;
         //if at+Height > BOTTOMEDGE then at := BOTTOMEDGE-Height;
         //Left := al;
         //Top := at;
         SpotX := X;
         SpotY := Y;

      end;
   end;
end;

function  TDWindow.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
   Result := inherited MouseDown (Button, Shift, X, Y);
   if Result then begin
      //if Floating then begin   //20081024修改
         if DParent <> nil then
            DParent.ChangeChildOrder (self);
      //end;
      SpotX := X;
      SpotY := Y;
   end;
end;

function  TDWindow.MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
   Result := inherited MouseUp (Button, Shift, X, Y);
end;

procedure TDWindow.Show;
begin
   Visible := TRUE;
   if Floating then begin
      if DParent <> nil then
         DParent.ChangeChildOrder (self);
   end;
   if EnableFocus then SetDFocus (self);
end;

function  TDWindow.ShowModal: integer;
begin
   Result:=0;//Jacky
   Visible := TRUE;
   ModalDWindow := self;
   if EnableFocus then SetDFocus (self);
end;


{--------------------- TDWinManager --------------------------}


constructor TDWinManager.Create (AOwner: TComponent);
begin
   inherited Create (AOwner);
   DWinList := TList.Create;
   MouseCaptureControl := nil;
   FocusedControl := nil;
end;

destructor TDWinManager.Destroy;
begin
   DWinList.Free;
   inherited Destroy;
end;

procedure TDWinManager.ClearAll;
begin
   DWinList.Clear;
end;

procedure TDWinManager.AddDControl (dcon: TDControl; visible: Boolean);
begin
   dcon.Visible := visible;
   DWinList.Add (dcon);
end;

procedure TDWinManager.DelDControl (dcon: TDControl);
var
   i: integer;
begin
   if DWinList.Count > 0 then //20080629
   for i:=0 to DWinList.Count-1 do
      if DWinList[i] = dcon then begin
         DWinList.Delete (i);
         break;
      end;
end;

function  TDWinManager.KeyPress (var Key: Char): Boolean;
begin
   Result := FALSE;
   if ModalDWindow <> nil then begin
      if ModalDWindow.Visible then begin
         with ModalDWindow do
            Result := KeyPress (Key);
         exit;
      end else
         ModalDWindow := nil;
      Key := #0; //ModalDWindow啊 KeyDown阑 芭摹搁辑 Visible=false肺 函窍搁辑
             //KeyPress甫 促矫芭媚辑 ModalDwindow=nil捞 等促.
   end;

   if FocusedControl <> nil then begin
      if FocusedControl.Visible then begin
         Result := FocusedControl.KeyPress (Key);
      end else
         ReleaseDFocus;
   end;
   {for i:=0 to DWinList.Count-1 do begin
      if TDControl(DWinList[i]).Visible then begin
         if TDControl(DWinList[i]).KeyPress (Key) then begin
            Result := TRUE;
            break;
         end;
      end;
   end; }
end;

function  TDWinManager.KeyDown (var Key: Word; Shift: TShiftState): Boolean;
begin
   Result := FALSE;
   if ModalDWindow <> nil then begin
      if ModalDWindow.Visible then begin
         with ModalDWindow do
            Result := KeyDown (Key, Shift);
         exit;
      end else MOdalDWindow := nil;
   end;
   if FocusedControl <> nil then begin
      if FocusedControl.Visible then
         Result := FocusedControl.KeyDown (Key, Shift)
      else
         ReleaseDFocus;
   end;
   {for i:=0 to DWinList.Count-1 do begin
      if TDControl(DWinList[i]).Visible then begin
         if TDControl(DWinList[i]).KeyDown (Key, Shift) then begin
            Result := TRUE;
            break;
         end;
      end;
   end; }
end;

function  TDWinManager.MouseMove (Shift: TShiftState; X, Y: Integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if ModalDWindow <> nil then begin
      if ModalDWindow.Visible then begin
         with ModalDWindow do
            MouseMove (Shift, LocalX(X), LocalY(Y));
         Result := TRUE;
         exit;
      end else MOdalDWindow := nil;
   end;
   if MouseCaptureControl <> nil then begin
      with MouseCaptureControl do
         Result := MouseMove (Shift, LocalX(X), LocalY(Y));
   end else
      if DWinList.Count > 0 then //20080629
      for i:=0 to DWinList.Count-1 do begin
         if TDControl(DWinList[i]).Visible then begin
            if TDControl(DWinList[i]).MouseMove (Shift, X, Y) then begin
               Result := TRUE;
               break;
            end;
         end;
      end;
end;

function  TDWinManager.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if ModalDWindow <> nil then begin
      if ModalDWindow.Visible then begin
         with ModalDWindow do
            MouseDown (Button, Shift, LocalX(X), LocalY(Y));
         Result := TRUE;    
         exit;
      end else ModalDWindow := nil;     
   end;
   if MouseCaptureControl <> nil then begin
      with MouseCaptureControl do
         Result := MouseDown (Button, Shift, LocalX(X), LocalY(Y));
   end else
      if DWinList.Count > 0 then //20080629
      for i:=0 to DWinList.Count-1 do begin
         if TDControl(DWinList[i]).Visible then begin
            if TDControl(DWinList[i]).MouseDown (Button, Shift, X, Y) then begin
               Result := TRUE;
               break;
            end;
         end;
      end;
end;

function  TDWinManager.MouseUp (Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
   i: integer;
begin
   Result := TRUE;
   if ModalDWindow <> nil then begin
      if ModalDWindow.Visible then begin
         with ModalDWindow do
            Result := MouseUp (Button, Shift, LocalX(X), LocalY(Y));
         exit;
      end else ModalDWindow := nil;
   end;
   if MouseCaptureControl <> nil then begin
      with MouseCaptureControl do
         Result := MouseUp (Button, Shift, LocalX(X), LocalY(Y));
   end else
      if DWinList.Count > 0 then //20080629
      for i:=0 to DWinList.Count-1 do begin
         if TDControl(DWinList[i]).Visible then begin
            if TDControl(DWinList[i]).MouseUp (Button, Shift, X, Y) then begin
               Result := TRUE;
               break;
            end;
         end;
      end;
end;

function  TDWinManager.DblClick (X, Y: integer): Boolean;
var
   i: integer;
begin
   Result := TRUE;
   if ModalDWindow <> nil then begin
      if ModalDWindow.Visible then begin
         with ModalDWindow do
            Result := DblClick (LocalX(X), LocalY(Y));
         exit;
      end else ModalDWindow := nil;
   end;
   if MouseCaptureControl <> nil then begin
      with MouseCaptureControl do
         Result := DblClick (LocalX(X), LocalY(Y));
   end else
      if DWinList.Count > 0 then //20080629
      for i:=0 to DWinList.Count-1 do begin
         if TDControl(DWinList[i]).Visible then begin
            if TDControl(DWinList[i]).DblClick (X, Y) then begin
               Result := TRUE;
               break;
            end;
         end;
      end;
end;

function  TDWinManager.Click (X, Y: integer): Boolean;
var
   i: integer;
begin
   Result := TRUE;
   if ModalDWindow <> nil then begin
      if ModalDWindow.Visible then begin
         with ModalDWindow do
            Result := Click (LocalX(X), LocalY(Y));
         exit;
      end else ModalDWindow := nil;
   end;
   if MouseCaptureControl <> nil then begin
      with MouseCaptureControl do
         Result := Click (LocalX(X), LocalY(Y));
   end else
      if DWinList.Count > 0 then //20080629
      for i:=0 to DWinList.Count-1 do begin
         if TDControl(DWinList[i]).Visible then begin
            if TDControl(DWinList[i]).Click (X, Y) then begin
               Result := TRUE;
               break;
            end;
         end;
      end;
end;

procedure TDWinManager.DirectPaint (dsurface: TDirectDrawSurface);
var
   i: integer;
begin
   if DWinList.Count > 0 then //20080629 
   for i:=0 to DWinList.Count-1 do begin
      if TDControl(DWinList[i]).Visible then begin
         TDControl(DWinList[i]).DirectPaint (dsurface);
      end;
   end;
   if ModalDWindow <> nil then begin
      if ModalDWindow.Visible then
         with ModalDWindow do
            DirectPaint (dsurface);
   end;
end;

{ TDEdit }
constructor TDEdit.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);   //组件创建
  //F3D := true;
  FColor := clWhite;           //字体颜色
  Width := 30;                //宽度
  Height := 19;                //高度
  //Cursor := crIBeam;           //光标
  BorderWidth := 2;            //边框宽度
  Font := TFont.Create;        //字体创建
  //FCanGetFocus := true;
  Moveed := False; 
  BlinkSpeed := 20;            //光标闪烁
  FSelCol := clHotLight;      //选择颜色
  FText:= '';
  KeyByteCount := 0;
  FMaxLength := 0;
  //FEnableFocus := True;        //是否有焦点
end;
//删除文字
procedure TDEdit.DelSelText;
var s:integer;
begin
  s := selStart;
  if SelStart > SelStop then s := SelStop;
  Delete(FText,S+1,SelCount);
  SelStart := s;
  SelStop := s;
end;
function TDEdit.CopySelText():string;
var
  s:Integer;
begin
  Result := '';
  s := SelStart;
  if SelStart > SelStop then s := SelStop;
  Result := Copy(FText,S+1,SelCount);
end;
//画的方法
procedure TDEdit.DirectPaint(dsurface: TDirectDrawSurface);
var 
    SelStartX:integer;
    SelStopX:integer;
    Ypos:integer;
begin
    with dsurface.Canvas do begin
  if not FTransparent then begin
      Brush.Color := FColor;//FSelCol;
      FillRect(Rect(SurfaceX(Left),  //左边
                    SurfaceY(Top),      //上边
                    SurfaceX(Left)+Width,   //右边
                    SurfaceY(Top)+Height));//下边
  end;
  inherited DirectPaint(dsurface);
  //if DesignMode then exit;


//    Lock;
    if assigned(Font) then Canvas.Font.Assign(Font);

    SelStartX := TextWidth(copy(FText,1,SelStart));
    SelStopX := TextWidth(copy(FText,1,SelStop));
    YPos := ((Height) - TextHeight(FText)) div 2;
    XDif := 0;
    if SelStopX > Width-5 then
    begin
      XDif := SelStopX-Width+TextWidth('W')*2;
    end;

    {rgn := Windows.CreateRectRgnIndirect(rect(BoundsRect.Left+BorderWidth,BoundsRect.Top+BorderWidth,
                                              BoundsRect.Right-BorderWidth,BoundsRect.Bottom-BorderWidth));
    Windows.SelectClipRgn(Canvas.Handle,rgn);    }



    {*********此函数为选择了某字符而变色*******}
    //showmessage(inttostr(SurfaceX(Left)));
      //Canvas.FillRect(rect(X+SelStartX+1-XDif,Y+borderwidth+1,X+SelStopX+1-XDif,Y+Self.Height-BorderWidth));
    if (SelCount > 0) and (FocusedControl = Self) then
    begin
      Brush.Color := FSelCol;//FSelCol;
      FillRect(Rect(SurfaceX(Left)+SelStartX+1-XDif,  //左边
                    SurfaceY(Top)+TextHeight('H') div 2 -2,      //上边
                    SurfaceX(Left)+SelStopX+1-XDif,   //右边
                    SurfaceY(Top)+Height-TextHeight('H') div 2 + 3));//下边
    end;
    Brush.Style := bsClear;
    {******************************************}
    //输出Capiton内容
    Font.Color := FFont.Color;
    TextRect(rect(SurfaceX(Left),SurfaceY(Top),SurfaceX(Left)+Width,SurfaceY(Top)+Height),
      SurfaceX(Left)+BorderWidth-XDif, SurfaceY(Top)+YPos + 1,FText);
    //TextOut(SurfaceX(Left)+BorderWidth-XDif,SurfaceY(Top)+YPos,FText);
    //Windows.DeleteObject(rgn);
    Release;
     DoMove;
    if (FocusedControl=self) and (cursorvisible) then
      if cursorvisible then   //光标是否可见   闪烁用的这个
    begin

      //画光标
     pen.Color := clWhite;
               //左                               //上                            //右
     Rectangle(SurfaceX(Left)+SelStopX+BorderWidth-XDif,SurfaceY(Top)+TextHeight('H') div 2 -2,SurfaceX(Left)+SelStopX-XDif+BorderWidth+2,SurfaceY(Top)+Height-TextHeight('H') div 2+3);

    end;
//    UnLock;
  Release;
  end;
end;
//光标闪烁函数
procedure TDEdit.DoMove;
begin
  CursorTime := CursorTime + 1;
  If CursorTime > BlinkSpeed then
  begin
    CursorVisible := not CursorVisible;
    CursorTime := 0;
  end;
end;
//得到选择数量
function TDEdit.GetSelCount: integer;
begin
  result := abs(SelStop-SelStart);
end;
//最大输入数量
procedure TDEdit.SetMaxLength(const Value: Integer);
begin
  FMaxLength := Value;

  if (FMaxLength > 0) and (Length(string(FText)) > FMaxLength) then
  begin
    FText := Copy(FText, 1, FMaxLength);
    if (SelStart > Length(string(FText))) then SelStart := Length(string(FText));
  end;
end;

function TDEdit.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
var
  Clipboard: TClipboard;
  AddTx: string;
begin
  //if not FVisible then ReleaseDFocus;
  if not FVisible or not DParent.FVisible then Exit;
  Result := inherited KeyDown(Key, Shift); //处理按键 主程序不执行了按键效果
  if (Result) and (not Background) then begin
      //Result := inherited KeyDown(Key, Shift); 
      CursorVisible := true;
      CursorTime := 0;
      if key = VK_BACK then begin
        if SelCount = 0 then begin
          Delete(FText,SelStart,1);
          SelStart := SelStart-1;
          SelStop := SelStart;
        end else begin
          DelSelText;
        end;
        if (Assigned(FOnChange)) then FOnChange(Self);
      end;
      if key = VK_DELETE then begin
        if SelCount = 0 then begin
          Delete(FText,SelStart+1,1);
        end else
          DelSelText;
        if (Assigned(FOnChange)) then FOnChange(Self);
      end;
      if key = VK_LEFT then begin
        if ssShift in Shift then begin
          SelStop := SelStop-1;
        end else begin
          if SelStop < SelStart then begin
            SelStart := SelStop;
          end else begin
            if SelStop > SelStart then begin
              SelStart := SelStop;
            end else begin
              SelStart := SelStart-1;
              SelStop := SelStart;
            end;
          end;
        end;
      end;
      if key = VK_HOME then begin
        if ssShift in Shift then begin
          SelStop := 0;
        end else begin
          SelStart := 0;
          SelStop := 0;
        end;
      end;
      if key = VK_END then begin
        if ssShift in Shift then begin
          SelStop := Length(FText);
        end else begin
          SelStart := Length(FText);
          SelStop := Length(FText);
        end;
      end;
      if key = VK_RIGHT then begin
        if ssShift in Shift then begin
          SelStop := SelStop+1;
        end else begin
          if SelStop < SelStart then begin
            SelStart := SelStop;
          end else begin
            if SelStop > SelStart then begin
              SelStart := SelStop;
            end else begin
              SelStart := SelStart+1;
              SelStop := SelStart;
            end;
          end;
        end;
      end;

      if (Key = Byte('V')) and (ssCtrl in Shift) then begin   //粘贴代码
        Clipboard := TClipboard.Create();
        AddTx := Clipboard.AsText;
        Insert(AddTx, FText, SelStart + 1);
        Inc(SelStart, Length(AddTx));
        if (FMaxLength > 0) and (Length(FText) > FMaxLength) then begin
          FText := Copy(FText, 1, FMaxLength);
          if (SelStart > Length(FText)) then SelStart := Length(FText);
        end;
        SelStop := SelStart;
        Clipboard.Free();
        if (Assigned(FOnChange)) then FOnChange(Self);
      end;

      if (Key = Byte('C')) and (ssCtrl in Shift) then begin   //复制
        Clipboard := TClipboard.Create();
        Clipboard.AsText := CopySelText();
       //Showmessage(CopySelText);
        Clipboard.Free();
      end;

      if SelStart < 0 then SelStart := 0;
      if SelStart > Length(FText) then SelStart := Length(FText);
      if SelStop < 0 then SelStop := 0;
      if SelStop > Length(FText) then SelStop := Length(FText);
  end;
end;

function TDEdit.KeyPress(var Key: Char): Boolean;
begin

  if not FVisible or not DParent.FVisible then Exit;
  if (inherited KeyPress(Key)) and (not Background) then begin
      Result := inherited KeyPress(Key); //处理按键 主程序不执行了按键效果
      if (ord(key) > 31) and ((ord(key) < 127) or (ord(key) > 159)) then begin
        if SelCount > 0 then DelSelText;

          {if (FMaxLength > 0) and (Length(string(FText)) > FMaxLength) then
          begin
            FText := Copy(FText, 1, FMaxLength);
            if (SelStop > Length(string(FText))) then SelStop := Length(string(FText));
          end;  }

     //--------------By huasoft-------------------------------------------------------
        if ((FMaxLength < 1) or (Length(string(FText)) < FMaxLength)) then begin
        if  IsDBCSLeadByte(Ord(Key)) or boDoubleByte then //判断是否是汉字
        begin
            boDoubleByte :=true;
            Inc(KeyByteCount);          //字节数
            InputStr:=InputStr+ Key;
        end;


        if not boDoubleByte then begin
          if SelStart >= Length(FText) then begin
            FText := FText + Key;
          end else begin
            Insert(Key,FText,SelStart+1);
          end;
          Inc(SelStart);
        end else begin
          if KeyByteCount >= 2 then begin   //字节数为2则为汉字
            if SelStart >= Length(FText) then begin
              FText := FText + InputStr;
            end else begin
              Insert(InputStr,FText,SelStart+1);
            end;
          boDoubleByte := False;
          KeyByteCount := 0;
          InputStr := '';
          Inc(SelStart);
          end;
        end;
          //SelStart := SelStart+1;
          SelStop := SelStart;
        end;
        if (Assigned(FOnChange)) then FOnChange(Self);
      end;
    end;
end;

//先试这个  我给你看


//这个是鼠标移动事件  就这地方有问题
function TDEdit.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  if not FVisible or not DParent.FVisible then Exit;
   //if ssLeft in Shift then begin
   Result := inherited MouseMove (Shift, X, Y);
   Moveed := Result;
   if ssLeft in Shift then begin
   if (not Background){ and (not Result)} then begin
      Result := inherited MouseMove (Shift, X, Y);
      if MouseCaptureControl = self then begin
         {if InRange (X, Y) then} SelStop := MouseToSelPos(x-left);
         //else Downed := FALSE;
      end;
   end;
   end;

end;

//这个是鼠标按下的事件   没问题
function TDEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
 { Result := FALSE;
  if inherited MouseDown (Button, Shift, X, Y) then begin   //如果是控件本身
    if mbLeft = Button then 
    if not Background then begin
        SelStart := MouseToSelPos(x-left);
        SelStop := SelStart;
        SetDCapture (self);
        Result := True;
    end;
  end;  }
  if not FVisible or not DParent.FVisible then Exit;
   Result := FALSE;
   if inherited MouseDown (Button, Shift, X, Y) then begin
      if (not Background) and (MouseCaptureControl=nil) then begin
         SelStart := MouseToSelPos(x-left);
         SelStop := SelStart;
         SetDCapture (self);
      end;
      Result := TRUE;
   end;
end;

function TDEdit.MouseToSelPos(AX: integer): integer;
var
  I:integer;
  AX1: Integer;
begin
  Result := length(FText);
  AX1 := AX-Borderwidth+XDif -3;
  if length(FText) <= 0 then begin //2080629
    Exit;
  end;
  for i := 0 to length(FText) do begin
    if Canvas.TextWidth(copy(FText,1,I)) >= AX1 then begin
      Result := I;
      break;
    end;
  end;
end;



procedure TDEdit.Update;
begin
  inherited;

end;


function TDEdit.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseUp (Button, Shift, X, Y) then begin
      ReleaseDCapture;
      if not Background then begin
         if InRange (X, Y) then begin
            if Assigned (FOnClick) then FOnClick(self, X, Y);
         end;
      end;
      Result := TRUE;
      exit;
   end else begin
      ReleaseDCapture;
   end;
end;

procedure TDEdit.SetText (str: Widestring);
begin
   FText := str;
   if csDesigning in ComponentState then begin
      Refresh;
   end;
end;

procedure TDEdit.SetFocus;
begin
  SetDFocus (self);
end;

destructor TDEdit.Destroy;
begin
  Font.Free;
  inherited;
end;

{ TDCheckBox }

constructor TDCheckBox.Create(AOwner: TComponent);
begin
   inherited Create (AOwner);
   Moveed := False;
   FChecked := False;
   FOnClick := nil;
   FEnableFocus := TRUE;
   FClickSound := csNone;
end;

{procedure TDCheckBox.DirectPaint(dsurface: TDirectDrawSurface);
begin

end;   }

function TDCheckBox.GetChecked: Boolean;
begin
  Result := FChecked;
end;

procedure TDCheckBox.SetChecked(Value: Boolean);
begin
  if FChecked <> Value then FChecked := Value;
end;

function TDCheckBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseDown (Button, Shift, X, Y) then begin
      if (not Background) and (MouseCaptureControl=nil) then begin
         SetDCapture (self);
      end;
      Result := TRUE;
   end;
end;

function TDCheckBox.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
   Result := inherited MouseMove (Shift, X, Y);
   Moveed := Result;
   if (not Background) and (not Result) then 
      Result := inherited MouseMove (Shift, X, Y);
end;

function TDCheckBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
   Result := FALSE;
   if inherited MouseUp (Button, Shift, X, Y) then begin
      ReleaseDCapture;
      if not Background then begin
         if InRange (X, Y) then begin
           if Button = mbLeft then begin
            SetChecked(not FChecked);
            if Assigned (FOnClickSound) then FOnClickSound(self, FClickSound);
            if Assigned (FOnClick) then FOnClick(self, X, Y);
           end;
         end;
      end;
      Result := TRUE;
      exit;
   end else begin
      ReleaseDCapture;
   end;
end;







end.
