unit HumanOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ComCtrls, IniFiles,HUtil32{20080220},DBShare,
  ExtCtrls;

type
  THumanOrderFrm = class(TForm)
    GroupBox1: TGroupBox;
    boAutoSort: TCheckBox;
    Label10: TLabel;
    SortLevel: TSpinEdit;
    Label11: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    SpinEdit4: TSpinEdit;
    Label1: TLabel;
    SpinEdit2: TSpinEdit;
    Label3: TLabel;
    SpinEdit3: TSpinEdit;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    PageControl3: TPageControl;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    ListView1: TListView;
    ListView2: TListView;
    ListView3: TListView;
    ListView4: TListView;
    PageControl5: TPageControl;
    TabSheet16: TTabSheet;
    ListView5: TListView;
    TabSheet17: TTabSheet;
    ListView6: TListView;
    TabSheet18: TTabSheet;
    ListView7: TListView;
    TabSheet19: TTabSheet;
    ListView8: TListView;
    ListView9: TListView;
    ListView10: TListView;
    ListView11: TListView;
    ListView12: TListView;
    Label5: TLabel;
    Timer1: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure boAutoSortClick(Sender: TObject);
    procedure SortLevelChange(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure ModValue();
    procedure uModValue();
    procedure LoadHumanOrder; //读取排行榜 20080220;
  public
    { Public declarations }
  end;

var
  HumanOrderFrm: THumanOrderFrm;

implementation
uses  Grobal2, HumDB;

{$R *.dfm}

procedure THumanOrderFrm.ModValue();
begin
  Button1.Enabled := True;
end;

procedure THumanOrderFrm.uModValue();
begin
  Button1.Enabled := False;
end;

procedure THumanOrderFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure THumanOrderFrm.FormDestroy(Sender: TObject);
begin
  HumanOrderFrm:= nil;
end;

procedure THumanOrderFrm.FormShow(Sender: TObject);
begin
  boAutoSort.Checked:= m_boAutoSort;
  SortLevel.Value := nSortLevel;
  SpinEdit1.Value := nSortHour;
  SpinEdit4.Value := nSortMinute;
  SpinEdit2.Value := nSortHour;
  SpinEdit3.Value := nSortMinute;
  case nSortClass of
    0: RadioButton2.Checked:= True;
    1: RadioButton1.Checked:= True;
  end;

  uModValue();
  //LoadHumanOrder;//读取排行数据
  Timer1.Enabled := True;
  boHumanOrder:= False;//20080819 增加
end;

procedure THumanOrderFrm.Button1Click(Sender: TObject);
var
  Config: TIniFile;
begin
  Config := TIniFile.Create(sConfFileName);
  if Config <> nil then begin
    Config.WriteBool('Setup', 'AutoSort', m_boAutoSort);
    Config.WriteInteger('Setup', 'SortClass', nSortClass);
    Config.WriteInteger('Setup', 'SortHour', nSortHour);
    Config.WriteInteger('Setup', 'SortMinute', nSortMinute);
    Config.WriteInteger('Setup', 'SortLevel', nSortLevel);
    uModValue();
    Config.Free;
  end;
end;

procedure THumanOrderFrm.boAutoSortClick(Sender: TObject);
begin
  m_boAutoSort := boAutoSort.Checked;
  ModValue();
end;

procedure THumanOrderFrm.SortLevelChange(Sender: TObject);
begin
  nSortLevel := SortLevel.Value;
  ModValue();
end;

procedure THumanOrderFrm.RadioButton2Click(Sender: TObject);
begin
  if RadioButton2.Checked then nSortClass := 0;
  ModValue();
end;

procedure THumanOrderFrm.RadioButton1Click(Sender: TObject);
begin
  if RadioButton1.Checked then nSortClass := 1;
  ModValue();
end;

procedure THumanOrderFrm.SpinEdit2Change(Sender: TObject);
begin
  if not RadioButton2.Checked then Exit;
  nSortHour:= SpinEdit2.Value ;
  ModValue();
end;

procedure THumanOrderFrm.SpinEdit3Change(Sender: TObject);
begin
  if not RadioButton2.Checked then Exit;
  nSortMinute:= SpinEdit3.Value ;
  ModValue();
end;

procedure THumanOrderFrm.SpinEdit1Change(Sender: TObject);
begin
  if not RadioButton1.Checked then Exit;
  nSortHour:= SpinEdit1.Value ;
  ModValue();
end;

procedure THumanOrderFrm.SpinEdit4Change(Sender: TObject);
begin
  if not RadioButton1.Checked then Exit;
  nSortMinute:= SpinEdit4.Value ;
  ModValue();
end;

procedure THumanOrderFrm.Button2Click(Sender: TObject);
begin
  try
    if not boHumanOrder then begin
      Button2.Enabled:= False;
      Label5.Caption:= '';
      RecHumanOrder;
      //LoadHumanOrder;//读取排行数据
      Timer1.Enabled := True;
      Label5.Caption:= '人物排行数据计算完毕!';
      //Button2.Enabled:= True;
    end;
  except
    if boViewHackMsg then MainOutMessage('[异常] THumanOrderFrm.Button2Click');
  end;
end;

//读取排行榜 20080220;
procedure THumanOrderFrm.LoadHumanOrder;
  function IsFileInUse(fName : string) : boolean;//判断文件是否在使用
  var
     HFileRes : HFILE;
  begin
     Result := false; //返回值为假(即文件不被使用)
   (*  if not FileExists(fName) then exit; //如果文件不存在则退出
     HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE, 0 , nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
     Result := (HFileRes = INVALID_HANDLE_VALUE); //如果CreateFile返回失败 那么Result为真(即文件正在被使用)
     CloseHandle(HFileRes);//那么关闭句柄  *)
  end;
var
  sHumDBFile, sWarrHum, sWizardHum, sTaosHum, sMaster: string;
  sAllHero, sWarrHero, sWizardHero, sTaosHero: string;

  LoadList: TStringList;
  ListItem: TListItem;
  I:Integer;
  sLineText, sData ,s_Master: string;
  nCode: Byte;
begin
  Try
    nCode:= 0;
    Try
      LoadList := TStringList.Create;
      sHumDBFile := sSort + 'AllHum.DB';
      sWarrHum:= sSort +'WarrHum.DB';
      sWizardHum:= sSort +'WizardHum.DB';
      sTaosHum:= sSort +'TaosHum.DB';
      sMaster:= sSort +'Master.DB';
      sAllHero:= sSort +'AllHero.DB';
      sWarrHero:= sSort +'WarrHero.DB';
      sWizardHero:= sSort +'WizardHero.DB';
      sTaosHero:= sSort +'TaosHero.DB';

      nCode:= 1;
      if FileExists(sHumDBFile) and (not IsFileInUse(sHumDBFile)) then begin
        ListView1.clear;
        LoadList.LoadFromFile(sHumDBFile);
        nCode:= 2;
        if LoadList.Count > 0 then begin
          ListView1.Items.BeginUpdate;
          try
            for I := 0 to LoadList.Count - 1 do begin
             sLineText := LoadList.Strings[I];
             if (sLineText <> '') and (sLineText[1] <> ';') then begin
               sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
               nCode:= 3;
               ListItem := ListView1.Items.Add;
               ListItem.Caption := Inttostr(I + 1);
               ListItem.SubItems.Add(sData);
               ListItem.SubItems.Add(sLineText);
             end;
            end;
          finally
            ListView1.Items.EndUpdate;
          end;
        end;
      end;

      if FileExists(sWarrHum) and (not IsFileInUse(sWarrHum)) then begin
        ListView2.clear;
        LoadList.Clear;
        LoadList.LoadFromFile(sWarrHum);
        nCode:= 4;
        if LoadList.Count > 0 then begin
          ListView2.Items.BeginUpdate;
          try
            for I := 0 to LoadList.Count - 1 do begin
             sLineText := LoadList.Strings[I];
             if (sLineText <> '') and (sLineText[1] <> ';') then begin
               sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
               nCode:= 5;
               ListItem := ListView2.Items.Add;
               ListItem.Caption := Inttostr(I + 1);
               ListItem.SubItems.Add(sData);
               ListItem.SubItems.Add(sLineText);
             end;
            end;
          finally
            ListView2.Items.EndUpdate;
          end;
        end;
      end;

      if FileExists(sWizardHum) and (not IsFileInUse(sWizardHum)) then begin
        ListView3.clear;
        LoadList.Clear;
        LoadList.LoadFromFile(sWizardHum);
        nCode:= 6;
        if LoadList.Count > 0 then begin
          ListView3.Items.BeginUpdate;
          try
            for I := 0 to LoadList.Count - 1 do begin
             sLineText := LoadList.Strings[I];
             if (sLineText <> '') and (sLineText[1] <> ';') then begin
               sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
               nCode:= 7;
               ListItem := ListView3.Items.Add;
               ListItem.Caption := Inttostr(I + 1);
               ListItem.SubItems.Add(sData);
               ListItem.SubItems.Add(sLineText);
             end;
            end;
          finally
            ListView3.Items.EndUpdate;
          end;
        end;
      end;

      if FileExists(sTaosHum) and (not IsFileInUse(sTaosHum)) then begin
        ListView4.clear;
        LoadList.Clear;
        LoadList.LoadFromFile(sTaosHum);
        nCode:= 8;
        if LoadList.Count > 0 then begin
          ListView4.Items.BeginUpdate;
          try
            for I := 0 to LoadList.Count - 1 do begin
             sLineText := LoadList.Strings[I];
             if (sLineText <> '') and (sLineText[1] <> ';') then begin
               sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
               nCode:= 9;
               ListItem := ListView4.Items.Add;
               ListItem.Caption := Inttostr(I + 1);
               ListItem.SubItems.Add(sData);
               ListItem.SubItems.Add(sLineText);
             end;
            end;
          finally
            ListView4.Items.EndUpdate;
          end;
        end;
      end;

      if FileExists(sMaster) and (not IsFileInUse(sMaster)) then begin
        ListView12.clear;
        LoadList.Clear;
        LoadList.LoadFromFile(sMaster);
        nCode:= 10;
        if LoadList.Count > 0 then begin
          ListView12.Items.BeginUpdate;
          try
            for I := 0 to LoadList.Count - 1 do begin
             sLineText := LoadList.Strings[I];
             if (sLineText <> '') and (sLineText[1] <> ';') then begin
               sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
               nCode:= 11;
               ListItem := ListView12.Items.Add;
               ListItem.Caption := Inttostr(I + 1);
               ListItem.SubItems.Add(sData);
               ListItem.SubItems.Add(sLineText);
             end;
            end;
          finally
            ListView12.Items.EndUpdate;
          end;
        end;
      end;

      if FileExists(sAllHero) and (not IsFileInUse(sAllHero)) then begin
        ListView7.clear;
        LoadList.Clear;
        LoadList.LoadFromFile(sAllHero);
        nCode:= 12;
        if LoadList.Count > 0 then begin
          ListView7.Items.BeginUpdate;
          try
            for I := 0 to LoadList.Count - 1 do begin
             sLineText := LoadList.Strings[I];
             if (sLineText <> '') and (sLineText[1] <> ';') then begin
               sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
               sLineText := GetValidStrCap(sLineText, s_Master, [' ', #9]);
               nCode:= 13;
               ListItem := ListView7.Items.Add;
               ListItem.Caption := Inttostr(I + 1);
               ListItem.SubItems.Add(s_Master);
               ListItem.SubItems.Add(sData);
               ListItem.SubItems.Add(sLineText);
             end;
            end;
          finally
            ListView7.Items.EndUpdate;
          end;
        end;
      end;

      if FileExists(sWarrHero) and (not IsFileInUse(sWarrHero)) then begin
        ListView9.clear;
        LoadList.Clear;
        LoadList.LoadFromFile(sWarrHero);
        nCode:= 14;
        if LoadList.Count > 0 then begin
          ListView9.Items.BeginUpdate;
          try
            for I := 0 to LoadList.Count - 1 do begin
             sLineText := LoadList.Strings[I];
             if (sLineText <> '') and (sLineText[1] <> ';') then begin
               sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
               sLineText := GetValidStrCap(sLineText, s_Master, [' ', #9]);
               nCode:= 15;
               ListItem := ListView9.Items.Add;
               ListItem.Caption := Inttostr(I + 1);
               ListItem.SubItems.Add(s_Master);
               ListItem.SubItems.Add(sData);
               ListItem.SubItems.Add(sLineText);
             end;
            end;
          finally
            ListView9.Items.EndUpdate;
          end;
        end;
      end;

      if FileExists(sWizardHero) and (not IsFileInUse(sWizardHero)) then begin
        ListView10.clear;
        LoadList.Clear;
        nCode:= 16;
        LoadList.LoadFromFile(sWizardHero);
        if LoadList.Count > 0 then begin
          ListView10.Items.BeginUpdate;
          try
            for I := 0 to LoadList.Count - 1 do begin
             sLineText := LoadList.Strings[I];
             if (sLineText <> '') and (sLineText[1] <> ';') then begin
               sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
               sLineText := GetValidStrCap(sLineText, s_Master, [' ', #9]);
               nCode:= 17;
               ListItem := ListView10.Items.Add;
               ListItem.Caption := Inttostr(I + 1);
               ListItem.SubItems.Add(s_Master);
               ListItem.SubItems.Add(sData);
               ListItem.SubItems.Add(sLineText);
             end;
            end;
          finally
            ListView10.Items.EndUpdate;
          end;
        end;
      end;

      if FileExists(sTaosHero) and (not IsFileInUse(sTaosHero)) then begin
        ListView11.clear;
        LoadList.Clear;
        nCode:= 18;
        LoadList.LoadFromFile(sTaosHero);
        if LoadList.Count > 0 then begin
          ListView11.Items.BeginUpdate;
          try
            for I := 0 to LoadList.Count - 1 do begin
             sLineText := LoadList.Strings[I];
             if (sLineText <> '') and (sLineText[1] <> ';') then begin
               sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
               sLineText := GetValidStrCap(sLineText, s_Master, [' ', #9]);
               nCode:= 19;
               ListItem := ListView11.Items.Add;
               ListItem.Caption := Inttostr(I + 1);
               ListItem.SubItems.Add(s_Master);
               ListItem.SubItems.Add(sData);
               ListItem.SubItems.Add(sLineText);
             end;
            end;
          finally
            ListView11.Items.EndUpdate;
          end;
        end;
      end;
    except
      if boViewHackMsg then MainOutMessage('[异常] THumanOrderFrm.LoadHumanOrder Code:'+inttostr(nCode));
    end;
  finally
    LoadList.Free;
  end;
end;

procedure THumanOrderFrm.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  LoadHumanOrder;//读取排行数据
  Button2.Enabled := True;
end;

end.
