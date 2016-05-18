unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzTabs, RzButton, RzBtnEdt, StdCtrls, Mask, RzEdit, RzLabel,
  ExtDlgs, jpeg;

type
  TForm1 = class(TForm)
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RzEdit1: TRzEdit;
    RzEdit2: TRzEdit;
    RzEdit3: TRzEdit;
    RzEdit4: TRzEdit;
    RzEdit5: TRzEdit;
    RzEdit6: TRzEdit;
    RzEdit7: TRzEdit;
    RzLabel8: TRzLabel;
    RzEdit8: TRzEdit;
    RzLabel9: TRzLabel;
    RzButtonEdit1: TRzButtonEdit;
    RzButton1: TRzButton;
    RzButton2: TRzButton;
    RzButton3: TRzButton;
    OpenPictureDialog1: TOpenPictureDialog;
    RzButtonEdit2: TRzButtonEdit;
    RzLabel10: TRzLabel;
    OpenDialog1: TOpenDialog;
    Edit1: TEdit;
    RzLabel11: TRzLabel;
    RzButton4: TRzButton;
    RzLabel12: TRzLabel;
    RzButtonEdit3: TRzButtonEdit;
    RzLabel13: TRzLabel;
    RzButtonEdit4: TRzButtonEdit;
    procedure RzButton1Click(Sender: TObject);
    procedure RzButton3Click(Sender: TObject);
    procedure RzButtonEdit1ButtonClick(Sender: TObject);
    procedure RzButtonEdit2ButtonClick(Sender: TObject);
    procedure RzButton2Click(Sender: TObject);
    procedure RzButton4Click(Sender: TObject);
    procedure RzButtonEdit3ButtonClick(Sender: TObject);
    procedure RzButtonEdit4ButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
type
  //×ÔÉíÐÅÏ¢¼ÇÂ¼
  TRecinfo = record
    GameListURL: string[255];
    BakGameListURL: string[255];
    PatchListURL: string[255];
    GameMonListURL: string[255];
    GameESystemUrl: string[255];
    boGameMon :Boolean;
    lnkName: string[20];
    ClientFileName: string[20];
    GameSdoFilter: array[0..50000] of char;
    GatePass: string[255];
    SourceFileSize: Int64;
  end;
  //×ÔÉíÐÅÏ¢¼ÇÂ¼
  TRecGateinfo = record
    GatePass: string[30];
  end;
const
  RecInfoSize = Sizeof(TRecinfo);  //·µ»Ø±»TRecinfoËùÕ¼ÓÃµÄ×Ö½ÚÊý
  RecGateInfoSize = SizeOf(TRecGateinfo);
var
  Form1: TForm1;

implementation
uses EDcodeUnit, Share;
{$R *.dfm}

//½«ÊäÈëµÄÐÅÏ¢Ð´ÈëµÇÂ½Æ÷
function WriteInfo(const FilePath: string; MyRecInfo: TRecInfo): Boolean;
var
  TargetFile: file;
begin
  try
    Result := True;
    AssignFile(TargetFile, FilePath);
    FileMode := 2;
    Reset(TargetFile, 1);
    Seek(TargetFile, FileSize(TargetFile));
    BlockWrite(TargetFile, MyRecInfo, RecInfoSize);
    CloseFile(TargetFile);
  except
    Result := False;
  end;
end;

//½«ÊäÈëµÄÐÅÏ¢Ð´ÈëÍø¹Ø
function WriteGateInfo(const FilePath: string; MyRecInfo: TRecGateInfo): Boolean;
var
  TargetFile: file;
begin
  try
    Result := True;
    AssignFile(TargetFile, FilePath);
    FileMode := 2;
    Reset(TargetFile, 1);
    Seek(TargetFile, FileSize(TargetFile));
    BlockWrite(TargetFile, MyRecInfo, RecGateInfoSize);
    CloseFile(TargetFile);
  except
    Result := False;
  end;
end;

//½âÃÜÃÜÔ¿
function CertKey(key: string): string;
var i: Integer;
begin
  for i:=1 to length(key) do
    result := result + chr(ord(key[i]) xor length(key)*i*i)
end;

procedure TForm1.RzButton1Click(Sender: TObject);
  //Ëæ»úÈ¡Ãû
  function RandomGetName():string;
  var
    s,s1:string;
    I,i0:integer;
  begin
      s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
      s1:='';
      Randomize(); //Ëæ»úÖÖ×Ó
      for i:=0 to 6 do begin
        i0:=random(35);
        s1:=s1+copy(s,i0,1);
      end;
      Result := s1;
  end;
begin
  RzEdit8.Text := RandomGetName()+'.THG';
end;

procedure TForm1.RzButton3Click(Sender: TObject);
  //Ëæ»úÈ¡Ãû
  function RandomGetName():string;
  var
    s,s1:string;
    I,i0:integer;
  begin
      s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
      s1:='';
      Randomize(); //Ëæ»úÖÖ×Ó
      for i:=0 to 19 do begin
        i0:=random(35);
        s1:=s1+copy(s,i0,1);
      end;
      Result := s1;
  end;
begin
  RzEdit7.Text := RandomGetName();
end;

procedure TForm1.RzButtonEdit1ButtonClick(Sender: TObject);
begin
  OpenPictureDialog1.Filter := 'µÇÂ½Æ÷½çÃæÍ¼(*.jpg)|*.jpg';
  if OpenPictureDialog1.Execute then begin
    RzButtonEdit1.Text := OpenPictureDialog1.FileName;
  end;
end;

procedure TForm1.RzButtonEdit2ButtonClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'µÇÂ½Æ÷³ÌÐò(*.exe)|*.exe';
  if OpenDialog1.Execute then begin
    RzButtonEdit2.Text := OpenDialog1.FileName;
  end;
end;

procedure TForm1.RzButton2Click(Sender: TObject);
  //×Ö·û´®¼Ó½âÃÜº¯Êý 20071225
  Function SetDate(Text: String): String;
  Var
    I     :Word;
    C     :Word;
  Begin
    Result := '';
    For I := 1 To Length(Text) Do Begin
      C := Ord(Text[I]);
      Result := Result + Chr((C Xor 15));
    End;
  End;
var
  Target,Pic_Memo: TMemoryStream;//Í¼Æ¬Á÷
  Dest_Memo: TMemoryStream;
  JpgImage: TJpegImage;
  nSourceFileSize: Int64;
  MyRecInfo: TRecinfo;
  AssistantFilterList: TStringList;
  s: string;
  ssStr,ssStr1,ssStr2,ssStr3: string;
const
  s_s01 = '.O,+*Q)%''&&&&&&&P$>=<;:9^XJKIHGEB';
  s_s02 = 'K_pxJodu';
  s_s03 = 'JoijVo`rK_\rVriiJoXsI\';
  s_s04 = 'VOUfJ?dxJ_xwJBprI_\wWL';
begin
    Pic_Memo:= TMemoryStream.Create;
    Target:=TMemoryStream.Create;
    Dest_Memo:=TMemoryStream.Create;
    JpgImage := TJpegImage.Create;
    try
      JpgImage.LoadFromFile(PChar(RzButtonEdit1.Text));
      JpgImage.SaveToStream(Pic_Memo);
      //Image1.Picture.LoadFromFile(sMainImages);
      //Image1.Picture.Graphic.SaveToStream(Pic_Memo);
      Pic_Memo.Position:=0;
      Target.LoadFromFile(PChar(RzButtonEdit2.Text));//g_MakeDir + '\' + sTangeFile);
      Target.Position:=0;
      nSourceFileSize := Target.Size;
      Dest_Memo.SetSize(Target.Size+Pic_Memo.size);
      Dest_Memo.Position:=0;
      Dest_Memo.CopyFrom(Target,Target.Size);
      Dest_Memo.CopyFrom(Pic_Memo,Pic_Memo.Size);
      Dest_Memo.SaveToFile('C:\1.exe');
    finally
      Dest_Memo.free;
      Target.Free;
      Pic_Memo.Free;
      JpgImage.Free;
    end;
      MyRecInfo.lnkName := RzEdit1.Text;
      ssStr1 := SetDate(DecodeString(s_s01)); //´òÂÒÆÆ½âÈËµÄÊÓÏß
      ssStr2 := SetDate(DecodeString(s_s02)); //´òÂÒÆÆ½âÈËµÄÊÓÏß
      ssStr2 := SetDate(DecodeString(s_s04)); //´òÂÒÆÆ½âÈËµÄÊÓÏß
      ssStr := LoginMainImagesA(RzEdit2.Text, SetDate(DecodeString(s_s03)));
      MyRecInfo.GameListURL := LoginMainImagesC(ssStr, SetDate(DecodeString(s_s03)));//EncodeString_3des(sGameListUrl, CertKey('9òzÙ<L£×Å®'));
      ssStr := LoginMainImagesA(RzEdit3.Text, SetDate(DecodeString(s_s03)));
      MyRecInfo.BakGameListURL := LoginMainImagesC(ssStr, SetDate(DecodeString(s_s03)));//EncodeString_3des(sBakGameListUrl, CertKey('9òzÙ<L£×Å®'));
      MyRecInfo.boGameMon := True;
      ssStr := LoginMainImagesA(RzEdit5.Text, SetDate(DecodeString(s_s03)));
      MyRecInfo.GameMonListURL := LoginMainImagesC(ssStr, SetDate(DecodeString(s_s03)));//EncodeString_3des(sGameMonListUrl, CertKey('9òzÙ<L£×Å®'));
      ssStr := LoginMainImagesA(RzEdit4.Text, SetDate(DecodeString(s_s03)));
      MyRecInfo.PatchListURL := LoginMainImagesC(ssStr, SetDate(DecodeString(s_s03)));//EncodeString_3des(sPatchListUrl, CertKey('9òzÙ<L£×Å®'));
      ssStr := LoginMainImagesA(RzEdit6.Text, SetDate(DecodeString(s_s03)));
      MyRecInfo.GameESystemUrl := LoginMainImagesC(ssStr, SetDate(DecodeString(s_s03)));//EncodeString_3des(sGameESystemUrl, CertKey('9òzÙ<L£×Å®'));
      MyRecInfo.ClientFileName := RzEdit8.Text;
      if RzButtonEdit4.Text <> '' then begin
        AssistantFilterList := TStringList.Create();
        try
          AssistantFilterList.LoadFromFile(PChar(RzButtonEdit4.Text));
          //Memo1.Lines.LoadFromFile(g_UpFileDir+'\'+sAccount+'_FilterItemList.txt');
          S:= AssistantFilterList.Text;
          Strpcopy(pchar(@MyRecInfo.GameSdoFilter),s); //½«S  ¸³¸øMyRecInfo.GameSdoFilterÊý×é   ÔõÃ´ÏÔÊ¾³öÀ´²Î¿¼µÇÂ½Æ÷
        finally
          FreeAndNil(AssistantFilterList);
        end;
      end else begin
        MyRecInfo.GameSdoFilter := '';
      end;
      ssStr := LoginMainImagesA(RzEdit7.Text, SetDate(DecodeString(s_s03)));
      MyRecInfo.GatePass := LoginMainImagesC(ssStr, SetDate(DecodeString(s_s03)));//EncodeString_3des(sPass, CertKey('9òzÙ<L£×Å®'));

    {MyRecInfo.lnkName := RzEdit1.Text;
    MyRecInfo.GameListURL := EncodeString_3des(RzEdit2.Text, CertKey('9òzÙ<L£×Å®'));
    MyRecInfo.BakGameListURL := EncodeString_3des(RzEdit3.Text, CertKey('9òzÙ<L£×Å®'));
    MyRecInfo.boGameMon := True;
    MyRecInfo.GameMonListURL := EncodeString_3des(RzEdit5.Text, CertKey('9òzÙ<L£×Å®'));
    MyRecInfo.PatchListURL := EncodeString_3des(RzEdit4.Text, CertKey('9òzÙ<L£×Å®'));
    MyRecInfo.GameESystemUrl := EncodeString_3des(RzEdit6.Text, CertKey('9òzÙ<L£×Å®'));
    MyRecInfo.ClientFileName := RzEdit8.Text;
    AssistantFilterList := TStringList.Create();
    try
      AssistantFilterList.LoadFromFile(PChar(RzButtonEdit4.Text));
      //Memo1.Lines.LoadFromFile(g_UpFileDir+'\'+sAccount+'_FilterItemList.txt');
      S:= AssistantFilterList.Text;
      Strpcopy(pchar(@MyRecInfo.GameSdoFilter),s); //½«S  ¸³¸øMyRecInfo.GameSdoFilterÊý×é   ÔõÃ´ÏÔÊ¾³öÀ´²Î¿¼µÇÂ½Æ÷
    finally
      FreeAndNil(AssistantFilterList);
    end;
    MyRecInfo.GatePass := EncodeString_3des(RzEdit7.Text, CertKey('9òzÙ<L£×Å®'));  }
    MyRecInfo.SourceFileSize := nSourceFileSize;
    WriteInfo('C:\1.exe', MyRecInfo);
    Application.MessageBox('Éú³ÉµÇÂ½Æ÷³É¹¦£¡', 'ÌáÊ¾', MB_OK + 
      MB_ICONINFORMATION);
end;

procedure TForm1.RzButton4Click(Sender: TObject);
var
  MyRecInfo: TRecGateinfo;
begin
  if CopyFile(PChar(RzButtonEdit3.Text), PChar('C:\2.exe'), False) then begin
    MyRecInfo.GatePass := EncodeString_3des(Edit1.Text, CertKey('>‚Eåk‡8V'));
    if WriteGateInfo('C:\2.exe', MyRecInfo) then Application.MessageBox('Éú³ÉÍø¹Ø³É¹¦£¡', 
      'ÌáÊ¾',
      MB_OK + 
      MB_ICONINFORMATION);
  end;
end;

procedure TForm1.RzButtonEdit3ButtonClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'Íø¹Ø³ÌÐò(*.exe)|*.exe';
  if OpenDialog1.Execute then begin
    RzButtonEdit3.Text := OpenDialog1.FileName;
  end;
end;

procedure TForm1.RzButtonEdit4ButtonClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'ÓÎÏ·ÎïÆ·¹ýÂËÎÄ¼þ(*.txt)|*.txt';
  if OpenDialog1.Execute then begin
    RzButtonEdit4.Text := OpenDialog1.FileName;
  end;
end;

end.
