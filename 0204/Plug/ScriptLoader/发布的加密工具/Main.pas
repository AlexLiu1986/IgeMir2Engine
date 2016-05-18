unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, RzButton, RzLabel, ComCtrls, ExtCtrls, RzPanel,
  Clipbrd, RzStatus, RzListVw, Mask, RzEdit, RzBtnEdt, RzShellDialogs;

type
  TFrmMain = class(TForm)
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    RzStatusBar1: TRzStatusBar;
    RzStatusPane1: TRzStatusPane;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    RzBitBtn1: TRzBitBtn;
    BtnExit: TRzBitBtn;
    URLLabel1: TRzURLLabel;
    LabelCopyright: TRzLabel;
    URLLabel2: TRzURLLabel;
    Memo2: TMemo;
    Edit1: TEdit;
    EditEncodeStr: TEdit;
    Panel1: TPanel;
    RzGroupBox4: TRzGroupBox;
    RzLabel12: TRzLabel;
    RzLabel14: TRzLabel;
    ListViewTxt1: TRzListView;
    BtnLoadTxt1: TRzBitBtn;
    BtnClearTxt1: TRzBitBtn;
    Memo3: TMemo;
    RzBitBtn2: TRzBitBtn;
    RzLabel1: TRzLabel;
    EdtSaveDir: TRzButtonEdit;
    RzSelectFolderDialog1: TRzSelectFolderDialog;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
    procedure EdtSaveDirButtonClick(Sender: TObject);
    procedure BtnLoadTxt1Click(Sender: TObject);
    procedure BtnClearTxt1Click(Sender: TObject);
    procedure ListViewTxt1DblClick(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CreateParams(var Params:TCreateParams);override;//设置程序的类名 20080412
    { Public declarations }
  end;
  
var
  FrmMain: TFrmMain;
  Version:integer;
const
  g_sProductName = 'F98A4B4C40B4AC8764EE4EFEAD023A5621EC2E2CDECCFF9C4BB59F46A5EFE0D1F6826FE60CC8E2CBE0DC124F896135F1'; //脚本加密工具 版权所有 (C) 2008-2010 IGE科技
  g_sURL1 = '9BECFDD8143865D36ED84E1462AA3F04DB7F1D649F9A10D276741565D9B98BDA'; //Http://Www.IGEM2.Com
  g_sURL2 = 'DE71C38C94563C0F6ED84E1462AA3F04DB7F1D649F9A10D27F779F085CC2961B'; //Http://Www.IGEM2.Com.Cn
  HookSearchMode = 1;//0-免费模式 1-商业模式 20081017
{$IF HookSearchMode = 1}
  sKey1 = '>48;;<9';//2847705 注册,加解密密码
{$ELSE}
  sKey1 = '?548?>8?=';//398432431 注册,加解密密码
{$IFEND}
{const
  UserKey10 = 398432431; //过客的Q号,与M2相对应(M2Share.pas Version = 398432431)
  Version = UserKey10; }
implementation

uses DESTR, EncryptUnit{,AES},EDcodeUnit, FileCtrl;

{$R *.dfm}

{-------------------------------------------------------------------------------
过程名:    FindFile 遍历文件夹及子文件夹
作者:      清清
日期:      2008.07.02
参数:      AList,APath,Ext   1.在某个里表里显示 2.路径 3.定义扩展名 4.是否遍历子目录
返回值:    TStringList

   Eg：:= FindFile(ListBox1.Items, 'E:\极品飞车','*.exe',True) ;
-------------------------------------------------------------------------------}
function FindFile(AList: TRzListView; const APath: TFileName;
  const Ext: String; const Recurisive: Boolean): Integer;
var
  FSearchRec: TSearchRec;
  FPath: TFileName;
begin
  Result := -1;
  application.ProcessMessages;
  if Assigned(AList) then
  try
    FPath := IncludeTrailingPathDelimiter(APath);
    if FindFirst(FPath + '*.*', faAnyFile, FSearchRec) = 0 then
      repeat
        if (FSearchRec.Attr and faDirectory) = faDirectory then
        begin
          if Recurisive and (FSearchRec.Name <> '.') and (FSearchRec.Name <> '..') then
            FindFile(AList, FPath + FSearchRec.Name, Ext, Recurisive);
        end
        else if SameText(Ext, '.*') or
          SameText(LowerCase(Ext), LowerCase(ExtractFileExt(FSearchRec.Name))) then begin
              AList.Items.Add.Caption := FPath + FSearchRec.Name;
           end;
      until FindNext(FSearchRec) <> 0;
  finally
    SysUtils.FindClose(FSearchRec);
    Result := AList.Items.Count;
  end;
end;

//设置窗体类名 20080412
procedure TFrmMain.CreateParams(var Params:TCreateParams);
begin
  Inherited CreateParams(Params);
  Params.WinClassName:='www.IGEM2.com.cn';
end;

function EnCodeScript(sText, sKey: string): string;
begin
 Result := EncryStrHex(EncodeString_3des(sText, sKey), sKey);
end;

//字符串加解密函数 20071225
Function SetDate(Text: String): String;
Var
  I     :Word;
  C     :Word;
Begin
  Result := '';
  For I := 1 To Length(Text) Do
    Begin
      C := Ord(Text[I]);
      Result := Result + Chr((C Xor 12));
    End;
End;

Function EncrypKey(Src:String; Key:String):string;
var
  KeyLen :Integer;
{$IF HookSearchMode = 1}
  KeyPos :Integer;
  offset :Integer;
  dest :string;
  SrcPos :Integer;
  SrcAsc :Integer;
  TmpSrcAsc :Integer;
  Range :Integer;
{$IFEND}
begin
  KeyLen:=Length(Key);
  if KeyLen = 0 then key:='www.IGEM2.com.cn';
{$IF HookSearchMode = 1}
  KeyPos:=0;
  SrcPos:=0;
  SrcAsc:=0;
  Range:=256;

  Randomize;
  offset:=Random(Range);
  dest:=format('%1.2x',[offset]);
  for SrcPos := 1 to Length(Src) do
  begin
  SrcAsc:=(Ord(Src[SrcPos]) + offset) MOD 255;
  if KeyPos < KeyLen then KeyPos:= KeyPos + 1 else KeyPos:=1;
  SrcAsc:= SrcAsc xor Ord(Key[KeyPos]);
  dest:=dest + format('%1.2x',[SrcAsc]);
  offset:=SrcAsc;
  end;
  Result:=Dest;
{$ELSE}
  Result:=Src;//20080717 不使用此解密函数
{$IFEND}
end; 

procedure TFrmMain.N2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then Memo1.Lines.SaveToFile(OpenDialog1.FileName);
end;

procedure TFrmMain.N1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TFrmMain.N4Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Memo2.Lines.SaveToFile(OpenDialog1.FileName);
end;

procedure TFrmMain.N3Click(Sender: TObject);
begin
  Memo2.Lines.Clear;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  sProductName: string;
  sUrl1: string;
  sUrl2: string;
const
  s0=' [商业版]';
begin
  Decode(g_sProductName, sProductName);
  Decode(g_sUrl1, sUrl1);
  Decode(g_sUrl2, sUrl2);
  LabelCopyright.Caption := sProductName;
  URLLabel1.Caption := sUrl1;
  URLLabel1.URL := sUrl1;
  URLLabel2.Caption := sUrl2;
  URLLabel2.URL := sUrl2;
{$IF HookSearchMode = 1}
  Label1.Visible:= True;
  Label2.Visible:= True;
  Edit2.Visible:= True;
  Edit3.Visible:= True;
  Caption:= Caption + s0;
{$IFEND}
  Version:=StrToInt(Edit1.text);
end;

procedure TFrmMain.RzBitBtn1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    Memo1.Lines.Clear;
    Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
  end;
end;

procedure TFrmMain.BtnExitClick(Sender: TObject);
var
  i: integer;
  sLineText, sKey: string;
  FirstStr: string;
begin
  FirstStr := EditEncodeStr.Text;
{  if Edit1.Text = '' then begin
    Application.MessageBox('请输入密码！   ', '提示信息', MB_ICONASTERISK);
    Exit;
  end;
  if FirstStr = '' then begin
    Application.MessageBox('请输入加密标识！   ', '提示信息', MB_ICONASTERISK);
    Exit;
  end;}
  Memo2.Lines.Clear;
  Memo2.Lines.Add(FirstStr);
{$I VMProtectBegin.inc}
  if Edit2.Text <> '' then begin
    sKey := DecodeString_3des(Trim(Edit2.Text), IntToStr(Version * 4));
  end else begin
    sKey := DecodeString_3des(SetDate(sKey1), IntToStr(Version * 4));
  end;
  for i := 0 to Memo1.Lines.Count - 1 do begin
    Application.ProcessMessages;
    sLineText := Memo1.Lines.Strings[i];
    if (sLineText <> '') then begin
      sLineText := SetDate(sLineText);
      sLineText := EnCodeScript(sLineText, sKey);
      sLineText := EncrypKey(sLineText, sKey);
      Memo2.Lines.Add(sLineText);
    end;
  end;
{$I VMProtectEnd.inc}
  Clipbrd.Clipboard.AsText := Memo2.Text;//复制到剪切板上 20081019
end;

procedure TFrmMain.EdtSaveDirButtonClick(Sender: TObject);
begin
  if RzSelectFolderDialog1.Execute then EdtSaveDir.Text:= RzSelectFolderDialog1.SelectedPathName;
end;

procedure TFrmMain.BtnLoadTxt1Click(Sender: TObject);
var
  Dir: string;
begin
  if SelectDirectory('请选择源脚本文本目录', '选择目录', Dir) then begin
    BtnLoadTxt1.Enabled := False;
    RzLabel14.Caption := '正在搜索中……';
    ListViewTxt1.Clear;
    FindFile(ListViewTxt1,Dir,'.Txt',True);
    RzLabel14.Caption := IntToStr(ListViewTxt1.Items.Count);
    BtnLoadTxt1.Enabled := True;
    RzBitBtn2.Enabled := True;
    BtnClearTxt1.Enabled := True;
  end;
end;

procedure TFrmMain.BtnClearTxt1Click(Sender: TObject);
begin
  ListViewTxt1.Clear;
  RzLabel14.Caption := '0';
end;

procedure TFrmMain.ListViewTxt1DblClick(Sender: TObject);
begin
  ListViewTxt1.Items.BeginUpdate;
  try
    ListViewTxt1.DeleteSelected;
  finally
    ListViewTxt1.Items.EndUpdate;
  end;
end;

procedure TFrmMain.RzBitBtn2Click(Sender: TObject);
var
  I, J: Integer;
  LoadList, SaveList: TStringList;
  sLineText, sKey: string;
  FirstStr, SaveFileDir: string;
begin
  if (trim(EdtSaveDir.text)='') or (ListViewTxt1.Items.Count = 0) then begin
    Application.MessageBox(PChar(SetDate('绥驾渺翟位埠馗鄙讲配谙断')){请把相关路径、源脚本设置好！},PChar(SetDate('')){'理撇'},MB_ICONWARNING+MB_OK);
    Exit;
  end;
  RzBitBtn2.Enabled := False;
  Memo3.Clear;
  LoadList:= TStringList.Create;
  SaveList:= TStringList.Create;
  FirstStr := EditEncodeStr.Text;
  SaveFileDir := EdtSaveDir.text;
{$I VMProtectBegin.inc}
  if Edit3.Text <> '' then begin
    sKey := DecodeString_3des(Trim(Edit3.Text), IntToStr(Version * 4));
  end else begin
    sKey := DecodeString_3des(SetDate(sKey1), IntToStr(Version * 4));
  end;
  Try
    for I:= 0 to ListViewTxt1.Items.Count - 1 do begin
      LoadList.Clear;
      SaveList.Clear;
      LoadList.LoadFromFile(ListViewTxt1.Items.Item[I].Caption);
      if LoadList.Count > 0 then begin
        SaveList.Add(FirstStr);//写入加密标识
        for J := 0 to LoadList.Count - 1 do begin
          Application.ProcessMessages;
          sLineText := LoadList.Strings[J];
          if (sLineText <> '') then begin
            sLineText := SetDate(sLineText);
            sLineText := EnCodeScript(sLineText, sKey);
            sLineText := EncrypKey(sLineText, sKey);
            SaveList.Add(sLineText);
          end;
        end;
        SaveList.SaveToFile(SaveFileDir +'\'+ ExtractFileName(ListViewTxt1.Items.Item[I].Caption));
      end;
      Memo3.Lines.Add(SetDate('掭伶颗'){'已完成：'} + ListViewTxt1.Items.Item[I].Caption);
    end;
    Memo3.Lines.Add(SetDate('肾统斑闲伶颗"""'){'批量加密完成...'});
  Finally
    LoadList.Free;
    SaveList.Free;
    RzBitBtn2.Enabled := True;
  end;
{$I VMProtectEnd.inc} 
end;

end.

