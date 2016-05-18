unit Guild;
{�лᵥԪ}
interface
uses
  Windows, SysUtils, Classes, IniFiles, ObjBase;
type
  TGuildRank = record
    nRankNo: Integer;//����
    sRankName: string;//ְ��
    MemberList: TStringList;
  end;
  pTGuildRank = ^TGuildRank;
  TWarGuild = record
    Guild: TObject;
    dwWarTick: LongWord;
    dwWarTime: LongWord;
  end;
  pTWarGuild = ^TWarGuild;
  TGUild = class
    sGuildName: string;//�л�����
    NoticeList: TStringList;//�лṫ��
    GuildWarList: TStringList;
    GuildAllList: TStringList;
    m_RankList: TList; //ְλ�б�
    nContestPoint: Integer;
    boTeamFight: Boolean;
    //    MatchPoint   :Integer;
    TeamFightDeadList: TStringList;
    m_boEnableAuthAlly: Boolean;//�Ƿ������л����� 
    dwSaveTick: LongWord;//���ݱ�����
    boChanged: Boolean;//�Ƿ�ı�
    m_DynamicVarList: TList;
    m_nGuildFountain: Integer;//�л�Ȫˮ�ֿ� 20080625
    boGuildFountainOpen: Boolean;//�л�ֿ��Ƿ��� 20080625
    m_nGuildMemberCount: Word;//�л��Ա���� 20090115
  private
    m_Config: TIniFile;
    m_nBuildPoint: Integer; //������
    m_nAurae: Integer; //������
    m_nStability: Integer; //������
    m_nFlourishing: Integer; //���ٶ�
    m_nChiefItemCount: Integer; //�л���ȡװ������

    function SetGuildInfo(sChief: string): Boolean;
    procedure ClearRank();
    procedure SaveGuildFile(sFileName: string);
    procedure SaveGuildConfig(sFileName: string);
    function GetMemberCount(): Integer;//�л�����
    function GetMemgerIsFull(): Boolean;//�л��Ƿ���Ա
    procedure SetAuraePoint(nPoint: Integer);
    procedure SetBuildPoint(nPoint: Integer);
    procedure SetStabilityPoint(nPoint: Integer);
    procedure SetFlourishPoint(nPoint: Integer);
    procedure SetChiefItemCount(nPoint: Integer);
  public
    constructor Create(sName: string);
    destructor Destroy; override;
    procedure SaveGuildInfoFile();
    function LoadGuild(): Boolean;
    function LoadGuildFile(sGuildFileName: string): Boolean;
    function LoadGuildConfig(sGuildFileName: string): Boolean;
    procedure UpdateGuildFile;
    procedure CheckSaveGuildFile;
    function IsMember(sName: string): Boolean;
    function IsAllyGuild(Guild: TGUild): Boolean;
    function IsWarGuild(Guild: TGUild): Boolean;
    function DelAllyGuild(Guild: TGUild): Boolean;
    procedure TeamFightWhoDead(sName: string);
    procedure TeamFightWhoWinPoint(sName: string; nPoint: Integer);
    procedure SendGuildMsg(sMsg: string);//�л�����
    procedure SendGuildMsg1(sMsg: string; FColor, BColor: Byte);//�л�����2 (��NPC����-SendMsgʹ��) 20081214
    procedure RefMemberName();
    function GetRankName(PlayObject: TPlayObject; var nRankNo: Integer): string;
    function DelMember(sHumName: string): Boolean;
    function UpdateRank(sRankData: string): Integer;
    function CancelGuld(sHumName: string): Boolean;
    function IsNotWarGuild(Guild: TGUild): Boolean;
    function AllyGuild(Guild: TGUild): Boolean;

    function AddMember(PlayObject: TPlayObject): Boolean;
    procedure DelHumanObj(PlayObject: TPlayObject);
    function GetChiefName(): string;
    procedure BackupGuildFile();
    procedure sub_499B4C(Guild: TGUild);
    function AddWarGuild(Guild: TGUild): pTWarGuild;
    procedure StartTeamFight();
    procedure EndTeamFight();
    procedure AddTeamFightMember(sHumanName: string);
    property Count: Integer read GetMemberCount;
    property IsFull: Boolean read GetMemgerIsFull;
    property nBuildPoint: Integer read m_nBuildPoint write SetBuildPoint;
    property nAurae: Integer read m_nAurae write SetAuraePoint;
    property nStability: Integer read m_nStability write SetStabilityPoint;
    property nFlourishing: Integer read m_nFlourishing write SetFlourishPoint;
    property nChiefItemCount: Integer read m_nChiefItemCount write SetChiefItemCount;
  end;
  TGuildManager = class//�л������
    GuildList: TList;//�л��б�
  private
  public
    constructor Create();
    destructor Destroy; override;
    procedure LoadGuildInfo();
    procedure SaveGuildList();
    function MemberOfGuild(sName: string): TGUild;
    function AddGuild(sGuildName, sChief: string): Boolean;
    function FindGuild(sGuildName: string): TGUild;
    function DELGUILD(sGuildName: string): Boolean;
    procedure ClearGuildInf();
    procedure Run();
  end;
implementation

uses M2Share, HUtil32, Grobal2;

{ TGuildManager }
//�½��л�
function TGuildManager.AddGuild(sGuildName, sChief: string): Boolean;
var
  Guild: TGUild;
begin
  Result := False;
  if CheckGuildName(sGuildName) and (FindGuild(sGuildName) = nil) then begin
    Guild := TGUild.Create(sGuildName);
    Guild.SetGuildInfo(sChief);
    Guild.m_nGuildMemberCount:= g_Config.nGuildMemberCount;//�л��Ա���� 20090115
    GuildList.Add(Guild);
    SaveGuildList();
    Result := True;
  end;
end;
//ɾ���л�
function TGuildManager.DELGUILD(sGuildName: string): Boolean;
var
  I: Integer;
  Guild: TGUild;
begin
  Result := False;
  for I := 0 to GuildList.Count - 1 do begin//20080917 �޸�
    if GuildList.Count <= 0 then Break;//20080917
    Guild := TGUild(GuildList.Items[I]);
    if CompareText(Guild.sGuildName, sGuildName) = 0 then begin
      if Guild.m_RankList.Count > 1 then Break;
      Guild.BackupGuildFile();
      GuildList.Delete(I);
      SaveGuildList();
      Result := True;
      Break;
    end;
  end;
end;

procedure TGuildManager.ClearGuildInf;
var
  I: Integer;
begin
  if GuildList.Count > 0 then begin//20080630
    for I := 0 to GuildList.Count - 1 do begin
      TGUild(GuildList.Items[I]).Free;
    end;
  end;
  GuildList.Clear;
end;

constructor TGuildManager.Create;
begin
  GuildList := TList.Create;
end;

destructor TGuildManager.Destroy;
begin
  GuildList.Free;
  inherited;
end;
//�����л�
function TGuildManager.FindGuild(sGuildName: string): TGUild;
var
  I: Integer;
begin
  Result := nil;
  if GuildList.Count > 0 then begin//20080630
    for I := 0 to GuildList.Count - 1 do begin
      if TGUild(GuildList.Items[I]).sGuildName = sGuildName then begin
        Result := TGUild(GuildList.Items[I]);
        Break;
      end;
    end;
  end;
end;

procedure TGuildManager.LoadGuildInfo;
var
  LoadList: TStringList;
  Guild: TGUild;
  sGuildName: string;
  I: Integer;
begin
  if FileExists(g_Config.sGuildFile) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(g_Config.sGuildFile);
    if LoadList.Count > 0 then begin//20080630
      for I := 0 to LoadList.Count - 1 do begin
        sGuildName := Trim(LoadList.Strings[I]);
        if sGuildName <> '' then begin
          Guild := TGUild.Create(sGuildName);
          GuildList.Add(Guild);
        end;
      end;
    end;
    LoadList.Free;
    for I := GuildList.Count - 1 downto 0 do begin
      if GuildList.Count <= 0 then Break;//20080917
      Guild := GuildList.Items[I];
      if not Guild.LoadGuild() then begin
        MainOutMessage(Guild.sGuildName + ' ��ȡ��������');
        Guild.Free;
        GuildList.Delete(I);
        SaveGuildList();
      end;
    end;
    MainOutMessage('�Ѷ�ȡ ' + IntToStr(GuildList.Count) + '���л���Ϣ...');
  end else begin
    MainOutMessage('�л���Ϣ�ļ�δ�ҵ�������');
  end;
end;
//ȡ����������л�
function TGuildManager.MemberOfGuild(sName: string): TGUild;
var
  I: Integer;
begin
  Result := nil;
  if GuildList.Count > 0 then begin//20080630
    for I := 0 to GuildList.Count - 1 do begin
      if TGUild(GuildList.Items[I]).IsMember(sName) then begin
        Result := TGUild(GuildList.Items[I]);
        Break;
      end;
    end;
  end;
end;

procedure TGuildManager.SaveGuildList;
var
  I: Integer;
  SaveList: TStringList;
begin
  if nServerIndex <> 0 then Exit;
  SaveList := TStringList.Create;
  if GuildList.Count > 0 then begin//20080630
    for I := 0 to GuildList.Count - 1 do begin
      SaveList.Add(TGUild(GuildList.Items[I]).sGuildName);
    end; // for
  end;
  try
    SaveList.SaveToFile(g_Config.sGuildFile);
  except
    MainOutMessage('�л���Ϣ����ʧ�ܣ�����');
  end;
  SaveList.Free;
end;

procedure TGuildManager.Run;
var
  I: Integer;
  II: Integer;
  Guild: TGUild;
  boChanged: Boolean;
  WarGuild: pTWarGuild;
begin
  try
    if GuildList.Count > 0 then begin//20080630
      for I := 0 to GuildList.Count - 1 do begin
        Guild := TGUild(GuildList.Items[I]);
        boChanged := False;
        for II := Guild.GuildWarList.Count - 1 downto 0 do begin
          if Guild.GuildWarList.Count <= 0 then Break;//20080917
          WarGuild := pTWarGuild(Guild.GuildWarList.Objects[II]);
          if (GetTickCount - WarGuild.dwWarTick) > WarGuild.dwWarTime then begin
            Guild.sub_499B4C(TGUild(WarGuild.Guild));
            Guild.GuildWarList.Delete(II);
            Dispose(WarGuild);
            boChanged := True;
          end;
        end;
        if boChanged then begin
          Guild.UpdateGuildFile();
        end;
        Guild.CheckSaveGuildFile;
      end;
    end;
  except
    MainOutMessage('{�쳣} TGuildManager.Run');
  end;
end;

{ TGuild }
//����л�
procedure TGUild.ClearRank;
var
  I: Integer;
  GuildRank: pTGuildRank;
begin
  if m_RankList.Count > 0 then begin//20080630
    for I := 0 to m_RankList.Count - 1 do begin
      GuildRank := m_RankList.Items[I];
      GuildRank.MemberList.Free;
      Dispose(GuildRank);
    end; // for
  end;
  m_RankList.Clear;
end;

constructor TGUild.Create(sName: string);
var
  sFileName: string;
begin
  sGuildName := sName;
  NoticeList := TStringList.Create;
  GuildWarList := TStringList.Create;
  GuildAllList := TStringList.Create;
  m_RankList := TList.Create;
  TeamFightDeadList := TStringList.Create;
  dwSaveTick := 0;
  boChanged := False;
  nContestPoint := 0;
  boTeamFight := False;
  m_boEnableAuthAlly := False;

  sFileName := g_Config.sGuildDir + sName + '.ini';
  m_Config := TIniFile.Create(sFileName);
  if not FileExists(sFileName) then begin
    m_Config.WriteString('Guild', 'GuildName', sName);
  end;

  m_nBuildPoint := 0;
  m_nAurae := 0;
  m_nStability := 0;
  m_nFlourishing := 0;
  m_nChiefItemCount := 0;
  m_nGuildFountain:= 0;//�л�Ȫˮ�ֿ� 20080625
  boGuildFountainOpen:= False;//�л�ֿ��Ƿ��� 20080625
  m_nGuildMemberCount:= g_Config.nGuildMemberCount;//�л��Ա���� 20090115
  m_DynamicVarList := TList.Create;
end;

function TGUild.DelAllyGuild(Guild: TGUild): Boolean;
var
  I: Integer;
  AllyGuild: TGUild;
begin
  Result := False;
  for I := 0 to GuildAllList.Count - 1 do begin//20080917 �޸�
    if GuildAllList.Count <= 0 then Break;//20080917
    AllyGuild := TGUild(GuildAllList.Objects[I]);
    if AllyGuild = Guild then begin
      GuildAllList.Delete(I);
      Result := True;
      Break;
    end;
  end; // for
  SaveGuildInfoFile();
end;

destructor TGUild.Destroy;
var
  I: Integer;
begin
  NoticeList.Free;
  GuildWarList.Free;
  GuildAllList.Free;
  ClearRank();
  m_RankList.Free;
  TeamFightDeadList.Free;
  m_Config.Free;
  if m_DynamicVarList.Count > 0 then begin//20080630
    for I := 0 to m_DynamicVarList.Count - 1 do begin
      if pTDynamicVar(m_DynamicVarList.Items[I]) <> nil then
         Dispose(pTDynamicVar(m_DynamicVarList.Items[I]));
    end;
  end;
  m_DynamicVarList.Free;
  inherited;
end;

function TGUild.IsAllyGuild(Guild: TGUild): Boolean;
var
  I: Integer;
  AllyGuild: TGUild;
begin
  Result := False;
  for I := 0 to GuildAllList.Count - 1 do begin
    AllyGuild := TGUild(GuildAllList.Objects[I]);
    if AllyGuild = Guild then begin
      Result := True;
      Break;
    end;
  end;
end;
//�Ƿ����л��Ա
function TGUild.IsMember(sName: string): Boolean;
var
  I, II: Integer;
  GuildRank: pTGuildRank;
begin
  Result := False;
  for I := 0 to m_RankList.Count - 1 do begin
    GuildRank := m_RankList.Items[I];
    for II := 0 to GuildRank.MemberList.Count - 1 do begin
      if GuildRank.MemberList.Strings[II] = sName then begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

function TGUild.IsWarGuild(Guild: TGUild): Boolean;
var
  I: Integer;
begin
  Result := False;
  if GuildWarList.Count > 0 then begin//20080630
    for I := 0 to GuildWarList.Count - 1 do begin
      if pTWarGuild(GuildWarList.Objects[I]).Guild = Guild then begin
        Result := True;
        Break;
      end;
    end; // for
  end;
end;

function TGUild.LoadGuild(): Boolean;
var
  sFileName: string;
begin
  sFileName := sGuildName + '.txt';
  Result := LoadGuildFile(sFileName);
  LoadGuildConfig(sGuildName + '.ini');
end;

function TGUild.LoadGuildConfig(sGuildFileName: string): Boolean;
begin
  m_nBuildPoint := m_Config.ReadInteger('Guild', 'BuildPoint', m_nBuildPoint);
  m_nAurae := m_Config.ReadInteger('Guild', 'Aurae', m_nAurae);
  m_nStability := m_Config.ReadInteger('Guild', 'Stability', m_nStability);
  m_nFlourishing := m_Config.ReadInteger('Guild', 'Flourishing', m_nFlourishing);
  m_nChiefItemCount := m_Config.ReadInteger('Guild', 'ChiefItemCount', m_nChiefItemCount);
  m_nGuildFountain := m_Config.ReadInteger('Guild', 'GuildFountain', m_nGuildFountain);//�л�Ȫˮ�ֿ� 20080625
  boGuildFountainOpen := m_Config.ReadBool('Guild', 'GuildFountainOpen', boGuildFountainOpen);//�л�ֿ��Ƿ��� 20080625
  m_nGuildMemberCount:=  m_Config.ReadInteger('Guild', 'GuildMemberCount', m_nGuildMemberCount);//�л��Ա���� 20090115
  Result := True;
end;
//��ȡ�л��ļ�
function TGUild.LoadGuildFile(sGuildFileName: string): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  s18, s1C, s20, s24, sFileName: string;
  n28, n2C: Integer;
  GuildWar: pTWarGuild;
  GuildRank: pTGuildRank;
  Guild: TGUild;
begin
  Result := False;
  GuildRank := nil;
  sFileName := g_Config.sGuildDir + sGuildFileName;
  if not FileExists(sFileName) then Exit;
  ClearRank();
  NoticeList.Clear;
  if GuildWarList.Count > 0 then begin//20080630
    for I := 0 to GuildWarList.Count - 1 do begin
      if pTWarGuild(GuildWarList.Objects[I]) <> nil then
         Dispose(pTWarGuild(GuildWarList.Objects[I]));
    end; // for
  end;
  GuildWarList.Clear;
  GuildAllList.Clear;
  n28 := 0;
  n2C := 0;
  s24 := '';
  LoadList := TStringList.Create;
  LoadList.LoadFromFile(sFileName);
  for I := 0 to LoadList.Count - 1 do begin
    s18 := LoadList.Strings[I];
    if (s18 = '') or (s18[1] = ';') then Continue;
    if s18[1] <> '+' then begin
      if s18 = g_Config.sGuildNotice then n28 := 1;
      if s18 = g_Config.sGuildWar then n28 := 2;
      if s18 = g_Config.sGuildAll then n28 := 3;
      if s18 = g_Config.sGuildMember then n28 := 4;
      if s18[1] = '#' then begin
        s18 := Copy(s18, 2, Length(s18) - 1);
        s18 := GetValidStr3(s18, s1C, [' ', ',']);
        n2C := Str_ToInt(s1C, 0);//����
        s24 := Trim(s18);//ְ��
        GuildRank := nil;
      end;
      Continue;
    end;
    s18 := Copy(s18, 2, Length(s18) - 1);
    case n28 of
      1: NoticeList.Add(s18);
      2: begin
          while (s18 <> '') do begin
            s18 := GetValidStr3(s18, s1C, [' ', ',']);
            if s1C = '' then Break;
            New(GuildWar);
            GuildWar.Guild := g_GuildManager.FindGuild(s1C);
            if GuildWar.Guild <> nil then begin
              GuildWar.dwWarTick := GetTickCount();
              GuildWar.dwWarTime := Str_ToInt(Trim(s20), 0);
              GuildWarList.AddObject(TGUild(GuildWar.Guild).sGuildName, TObject(GuildWar));
            end else begin
              Dispose(GuildWar);
            end;
          end;
        end;
      3: begin
          while (s18 <> '') do begin
            s18 := GetValidStr3(s18, s1C, [' ', ',']);
            s18 := GetValidStr3(s18, s20, [' ', ',']);
            if s1C = '' then Break;
            Guild := g_GuildManager.FindGuild(s1C);
            if Guild <> nil then GuildAllList.AddObject(s1C, Guild);
          end;
        end;
      4: begin
          if (n2C > 0) and (s24 <> '') then begin
            if Length(s24) > 30 then //����ְ��ĳ���
              s24 := Copy(s24, 1, g_Config.nGuildRankNameLen {30});
            if GuildRank = nil then begin
              New(GuildRank);
              GuildRank.nRankNo := n2C;
              GuildRank.sRankName := s24;
              GuildRank.MemberList := TStringList.Create;
              m_RankList.Add(GuildRank);
            end;
            while (s18 <> '') do begin
              s18 := GetValidStr3(s18, s1C, [' ', ',']);
              if s1C = '' then Break;
              GuildRank.MemberList.Add(s1C);
            end;
          end;
        end;
    end; // case
  end;
  LoadList.Free;
  Result := True;
end;

procedure TGUild.RefMemberName;
var
  I, II: Integer;
  GuildRank: pTGuildRank;
  BaseObject: TBaseObject;
  nCode: Byte;//20080806
begin
  nCode:=0;
  try
    if m_RankList.Count > 0 then begin//20080630
      nCode:=1;
      for I := 0 to m_RankList.Count - 1 do begin
        nCode:= 2;
        GuildRank := m_RankList.Items[I];
        nCode:=3;
        if GuildRank <> nil then begin//20080806 ����
          nCode:=4;
          if GuildRank.MemberList.Count > 0 then begin//20080630
            nCode:=5;
            for II := 0 to GuildRank.MemberList.Count - 1 do begin
              nCode:=6;
              BaseObject := TBaseObject(GuildRank.MemberList.Objects[II]);
              nCode:=7;
              if BaseObject <> nil then BaseObject.RefShowName;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage('{�쳣} TGUild.RefMemberName Code:'+inttostr(nCode));
  end;
end;

procedure TGUild.SaveGuildInfoFile;
begin
  if nServerIndex = 0 then begin
    SaveGuildFile(g_Config.sGuildDir + sGuildName + '.txt');
    SaveGuildConfig(g_Config.sGuildDir + sGuildName + '.ini');
  end else begin
    SaveGuildFile(g_Config.sGuildDir + sGuildName + '.' + IntToStr(nServerIndex));
  end;
end;

procedure TGUild.SaveGuildConfig(sFileName: string);
begin
  m_Config.WriteString('Guild', 'GuildName', sGuildName);
  m_Config.WriteInteger('Guild', 'BuildPoint', m_nBuildPoint);
  m_Config.WriteInteger('Guild', 'Aurae', m_nAurae);
  m_Config.WriteInteger('Guild', 'Stability', m_nStability);
  m_Config.WriteInteger('Guild', 'Flourishing', m_nFlourishing);
  m_Config.WriteInteger('Guild', 'ChiefItemCount', m_nChiefItemCount);
  m_Config.WriteInteger('Guild', 'GuildFountain', m_nGuildFountain);//�л�Ȫˮ�ֿ� 20080625
  m_Config.WriteBool('Guild', 'GuildFountainOpen', boGuildFountainOpen);//�л�ֿ��Ƿ��� 20080625
  m_Config.WriteInteger('Guild', 'GuildMemberCount', m_nGuildMemberCount);//�л��Ա���� 20090115
end;

procedure TGUild.SaveGuildFile(sFileName: string);
var
  SaveList: TStringList;
  I, II: Integer;
  WarGuild: pTWarGuild;
  GuildRank: pTGuildRank;
  n14: Integer;
begin
  SaveList := TStringList.Create;
  try
    SaveList.Add(g_Config.sGuildNotice);
    for I := 0 to NoticeList.Count - 1 do begin
      SaveList.Add('+' + NoticeList.Strings[I]);
    end;
    SaveList.Add(' ');
    SaveList.Add(g_Config.sGuildWar);
    for I := 0 to GuildWarList.Count - 1 do begin
      WarGuild := pTWarGuild(GuildWarList.Objects[I]);
      n14 := WarGuild.dwWarTime - (GetTickCount - WarGuild.dwWarTick);
      if n14 <= 0 then Continue;
      SaveList.Add('+' + GuildWarList.Strings[I] + ' ' + IntToStr(n14));
    end;
    SaveList.Add(' ');
    SaveList.Add(g_Config.sGuildAll);
    for I := 0 to GuildAllList.Count - 1 do begin
      SaveList.Add('+' + GuildAllList.Strings[I]);
    end;
    SaveList.Add(' ');
    SaveList.Add(g_Config.sGuildMember);

    for I := 0 to m_RankList.Count - 1 do begin
      GuildRank := m_RankList.Items[I];
      SaveList.Add('#' + IntToStr(GuildRank.nRankNo) + ' ' + GuildRank.sRankName);
      for II := 0 to GuildRank.MemberList.Count - 1 do begin
        SaveList.Add('+' + GuildRank.MemberList.Strings[II]);
      end;
    end;
    try
      SaveList.SaveToFile(sFileName);
    except
      MainOutMessage('�����л���Ϣʧ�ܣ����� ' + sFileName);
    end;
  finally
    SaveList.Free;
  end;
end;
//�л�����
procedure TGUild.SendGuildMsg(sMsg: string);
var
  I: Integer;
  II: Integer;
  GuildRank: pTGuildRank;
  PlayObject: TPlayObject;
  nCheckCode: Integer;
begin
  nCheckCode := 0;
  try
    if g_Config.boShowPreFixMsg then sMsg := g_Config.sGuildMsgPreFix + sMsg;
    //if RankList = nil then exit;
    nCheckCode := 1;
    if m_RankList.Count > 0 then begin//20080630
      for I := 0 to m_RankList.Count - 1 do begin
        GuildRank := m_RankList.Items[I];
        nCheckCode := 2;
        if GuildRank.MemberList = nil then Continue;
        if GuildRank.MemberList.Count > 0 then begin//20080630
          for II := 0 to GuildRank.MemberList.Count - 1 do begin
            nCheckCode := 3;
            PlayObject := TPlayObject(GuildRank.MemberList.Objects[II]);              //�һ��������л���Ϣ
            if (PlayObject = nil) or (UserEngine.GetPlayObject(PlayObject) = nil) or (PlayObject.m_boNotOnlineAddExp) then Continue; {2007-01-27 ����}
            nCheckCode := 4;
            if PlayObject.m_boBanGuildChat then begin
              nCheckCode := 5;
              PlayObject.SendMsg(PlayObject, RM_GUILDMESSAGE, 0, g_Config.btGuildMsgFColor, g_Config.btGuildMsgBColor, 0, sMsg);
              nCheckCode := 6;
              if g_Config.boRecordClientMsg and (sMsg <> '') then begin//��¼�л�������Ϣ 20090129
                MainOutMessage('[�л�����] '+ sGuildName+':'+ sMsg);
              end;
            end;
          end;//for
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage('{�쳣} TGuild.SendGuildMsg CheckCode: ' + IntToStr(nCheckCode) + ' GuildName:' + sGuildName + ' Msg:' + sMsg);
      //MainOutMessage(E.Message);
    end;
  end;
end;

//�л�����2 (��NPC����-SendMsgʹ��) 20081214
procedure TGUild.SendGuildMsg1(sMsg: string; FColor, BColor: Byte);
var
  I: Integer;
  II: Integer;
  GuildRank: pTGuildRank;
  PlayObject: TPlayObject;
  nCheckCode: Integer;
begin
  nCheckCode := 0;
  try
    if g_Config.boShowPreFixMsg then sMsg := g_Config.sGuildMsgPreFix + sMsg;
    //if RankList = nil then exit;
    nCheckCode := 1;
    if m_RankList.Count > 0 then begin
      for I := 0 to m_RankList.Count - 1 do begin
        GuildRank := m_RankList.Items[I];
        nCheckCode := 2;
        if GuildRank.MemberList = nil then Continue;
        if GuildRank.MemberList.Count > 0 then begin
          for II := 0 to GuildRank.MemberList.Count - 1 do begin
            nCheckCode := 3;
            PlayObject := TPlayObject(GuildRank.MemberList.Objects[II]);              //�һ��������л���Ϣ
            if (PlayObject = nil) or (UserEngine.GetPlayObject(PlayObject) = nil) or (PlayObject.m_boNotOnlineAddExp) then Continue; {2007-01-27 ����}
            nCheckCode := 4;
            if PlayObject.m_boBanGuildChat then begin
              nCheckCode := 5;
              PlayObject.SendMsg(PlayObject, RM_GUILDMESSAGE, 0, FColor, BColor, 0, sMsg);
              nCheckCode := 6;
              if g_Config.boRecordClientMsg and (sMsg <> '') then begin//��¼�л�������Ϣ 20090129
                MainOutMessage('[�л�����] '+ sGuildName+':'+ sMsg);
              end;
            end;
          end;//for
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage('{�쳣} TGuild.SendGuildMsg1 CheckCode: ' + IntToStr(nCheckCode) + ' GuildName:' + sGuildName + ' Msg:' + sMsg);
      //MainOutMessage(E.Message);
    end;
  end;
end;
//���óǱ���Ϣ
function TGUild.SetGuildInfo(sChief: string): Boolean;
var
  GuildRank: pTGuildRank;
begin
  if m_RankList.Count = 0 then begin
    New(GuildRank);
    GuildRank.nRankNo := 1;//�ϴ�
    GuildRank.sRankName := g_Config.sGuildChief;//������
    GuildRank.MemberList := TStringList.Create;
    GuildRank.MemberList.Add(sChief);
    m_RankList.Add(GuildRank);
    SaveGuildInfoFile();
  end;
  Result := True;
end;
//ȡ�л���
function TGUild.GetRankName(PlayObject: TPlayObject; var nRankNo: Integer): string;
var
  I, II: Integer;
  GuildRank: pTGuildRank;
begin
  Result := '';
  if m_RankList.Count > 0 then begin//20080630
    for I := 0 to m_RankList.Count - 1 do begin
      GuildRank := m_RankList.Items[I];
      if GuildRank.MemberList.Count > 0 then begin//20080630
        for II := 0 to GuildRank.MemberList.Count - 1 do begin
          if GuildRank.MemberList.Strings[II] = PlayObject.m_sCharName then begin
            GuildRank.MemberList.Objects[II] := PlayObject;
            nRankNo := GuildRank.nRankNo;
            Result := GuildRank.sRankName;
            //PlayObject.RefShowName();
            PlayObject.SendMsg(PlayObject, RM_CHANGEGUILDNAME, 0, 0, 0, 0, '');
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

function TGUild.GetChiefName: string;
var
  GuildRank: pTGuildRank;
begin
  Result := '';
  if m_RankList.Count <= 0 then Exit;
  GuildRank := m_RankList.Items[0];
  if GuildRank.MemberList.Count <= 0 then Exit;
  Result := GuildRank.MemberList.Strings[0];
end;

procedure TGUild.CheckSaveGuildFile();
begin
  if boChanged and ((GetTickCount - dwSaveTick) > 30000{30 * 1000}) then begin
    boChanged := False;
    SaveGuildInfoFile();
  end;
end;

procedure TGUild.DelHumanObj(PlayObject: TPlayObject);
var
  I, II: Integer;
  GuildRank: pTGuildRank;
begin
  CheckSaveGuildFile();
  if m_RankList.Count > 0 then begin//20080630
    for I := 0 to m_RankList.Count - 1 do begin
      GuildRank := m_RankList.Items[I];
      if GuildRank.MemberList.Count > 0 then begin//20080630
        for II := 0 to GuildRank.MemberList.Count - 1 do begin
          if TPlayObject(GuildRank.MemberList.Objects[II]) = PlayObject then begin
            GuildRank.MemberList.Objects[II] := nil;
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

procedure TGUild.TeamFightWhoDead(sName: string);
var
  I, n10: Integer;
begin
  if not boTeamFight then Exit;
  if TeamFightDeadList.Count > 0 then begin//20080630
    for I := 0 to TeamFightDeadList.Count - 1 do begin
      if TeamFightDeadList.Strings[I] = sName then begin
        n10 := Integer(TeamFightDeadList.Objects[I]);
        TeamFightDeadList.Objects[I] := TObject(MakeLong(LoWord(n10) + 1, HiWord(n10)));
      end;
    end;
  end;
end;

procedure TGUild.TeamFightWhoWinPoint(sName: string; nPoint: Integer);
var
  I, n14: Integer;
begin
  if not boTeamFight then Exit;
  Inc(nContestPoint, nPoint);
  if TeamFightDeadList.Count > 0 then begin//20080630
    for I := 0 to TeamFightDeadList.Count - 1 do begin
      if TeamFightDeadList.Strings[I] = sName then begin
        n14 := Integer(TeamFightDeadList.Objects[I]);
        TeamFightDeadList.Objects[I] := TObject(MakeLong(LoWord(n14), HiWord(n14) + nPoint));
      end;
    end;
  end;
end;

procedure TGUild.UpdateGuildFile();
begin
  boChanged := True;
  dwSaveTick := GetTickCount();
  SaveGuildInfoFile();
end;
procedure TGUild.BackupGuildFile;
var
  I, II: Integer;
  PlayObject: TPlayObject;
  GuildRank: pTGuildRank;
begin
  if nServerIndex = 0 then
    SaveGuildFile(g_Config.sGuildDir + sGuildName + '.' + IntToStr(GetTickCount) + '.bak');
  if m_RankList.Count > 0 then begin//20080630
    for I := 0 to m_RankList.Count - 1 do begin
      GuildRank := m_RankList.Items[I];
      if GuildRank.MemberList.Count > 0 then begin//20080630
        for II := 0 to GuildRank.MemberList.Count - 1 do begin
          PlayObject := TPlayObject(GuildRank.MemberList.Objects[II]);
          if PlayObject <> nil then begin
            PlayObject.m_MyGuild := nil;
            PlayObject.RefRankInfo(0, '');
            PlayObject.RefShowName(); //10/31
          end;
        end;
      end;
      GuildRank.MemberList.Free;
      Dispose(GuildRank);
    end;
  end;
  m_RankList.Clear;
  NoticeList.Clear;
  if GuildWarList.Count > 0 then begin//20080630
    for I := 0 to GuildWarList.Count - 1 do begin
      if pTWarGuild(GuildWarList.Objects[I]) <> nil then
        Dispose(pTWarGuild(GuildWarList.Objects[I]));
    end;
  end;
  GuildWarList.Clear;
  GuildAllList.Clear;
  SaveGuildInfoFile();
end;
//�л����ӳ�Ա
function TGUild.AddMember(PlayObject: TPlayObject): Boolean;
var
  I: Integer;
  GuildRank: pTGuildRank;
  GuildRank18: pTGuildRank;
begin
  Result := False;
  GuildRank18 := nil;
  if m_RankList.Count > 0 then begin//20080630
    for I := 0 to m_RankList.Count - 1 do begin
      GuildRank := m_RankList.Items[I];
      if GuildRank.nRankNo = 99 then begin
        GuildRank18 := GuildRank;
        Break;
      end;
    end;
  end;
  if GuildRank18 = nil then begin
    New(GuildRank18);
    GuildRank18.nRankNo := 99;
    GuildRank18.sRankName := g_Config.sGuildMemberRank;
    GuildRank18.MemberList := TStringList.Create;
    m_RankList.Add(GuildRank18);
  end;
  GuildRank18.MemberList.AddObject(PlayObject.m_sCharName, TObject(PlayObject));
  UpdateGuildFile();//�����л��ļ�
  Result := True;
end;
//�л�ɾ����Ա
function TGUild.DelMember(sHumName: string): Boolean;
var
  I, II: Integer;
  GuildRank: pTGuildRank;
begin
  Result := False;
  for I := 0 to m_RankList.Count - 1 do begin
    GuildRank := m_RankList.Items[I];
    for II := GuildRank.MemberList.Count - 1 downto 0 do begin//20080917 �޸�
      if GuildRank.MemberList.Count <= 0 then Break;//20080917
      if GuildRank.MemberList.Strings[II] = sHumName then begin
        GuildRank.MemberList.Delete(II);
        Result := True;
        Break;
      end;
    end;
    if Result then Break;
  end;
  if Result then UpdateGuildFile;
end;

function TGUild.CancelGuld(sHumName: string): Boolean;
var
  GuildRank: pTGuildRank;
begin
  Result := False;
  if m_RankList.Count <> 1 then Exit;
  GuildRank := m_RankList.Items[0];
  if GuildRank.MemberList.Count <> 1 then Exit;
  if GuildRank.MemberList.Strings[0] = sHumName then begin
    BackupGuildFile();
    Result := True;
  end;
end;

function TGUild.UpdateRank(sRankData: string): Integer;
  procedure ClearRankList(var RankList: TList);
  var
    I: Integer;
    GuildRank: pTGuildRank;
  begin
    if RankList.Count > 0 then begin//20080630
      for I := 0 to RankList.Count - 1 do begin
        GuildRank := RankList.Items[I];
        GuildRank.MemberList.Free;
        Dispose(GuildRank);
      end;
    end;
    RankList.Free;
  end;
var
  I: Integer;
  II: Integer;
  III: Integer;
  GuildRankList: TList;
  GuildRank: pTGuildRank;
  NewGuildRank: pTGuildRank;
  sRankInfo: string;
  sRankNo: string;
  sRankName: string;
  sMemberName: string;
  n28: Integer;
  n2C: Integer;
  n30: Integer;
  boCheckChange: Boolean;
  PlayObject: TPlayObject;
begin
  Result := -1;
  Try
    GuildRankList := TList.Create;
    GuildRank := nil;
    while (True) do begin
      if sRankData = '' then Break;
      sRankData := GetValidStr3(sRankData, sRankInfo, [#$0D]);
      sRankInfo := Trim(sRankInfo);
      if sRankInfo = '' then Continue;
      if sRankInfo[1] = '#' then begin //ȡ��ְ�Ƶ�����
        sRankInfo := Copy(sRankInfo, 2, Length(sRankInfo) - 1);
        sRankInfo := GetValidStr3(sRankInfo, sRankNo, [' ', '<']);
        sRankInfo := GetValidStr3(sRankInfo, sRankName, ['<', '>']);
        if Length(sRankName) > 30 then //Jacky ����ְ�Ƶĳ���
          sRankName := Copy(sRankName, 1, 30);
        if GuildRank <> nil then begin
          GuildRankList.Add(GuildRank);
        end;
        New(GuildRank);
        GuildRank.nRankNo := Str_ToInt(sRankNo, 99);
        GuildRank.sRankName := Trim(sRankName);
        GuildRank.MemberList := TStringList.Create;
        Continue;
      end;

      if GuildRank = nil then Continue;
      I := 0;
      while (True) do begin //����Ա���Ƽ���ְ�Ʊ���
        if sRankInfo = '' then Break;
        sRankInfo := GetValidStr3(sRankInfo, sMemberName, [' ', ',']);
        if sMemberName <> '' then GuildRank.MemberList.Add(sMemberName);
        Inc(I);
        if I > g_Config.nGuildMemberMaxLimit then Break; //���Ƴ�Ա����
      end;
    end;

    if GuildRank <> nil then begin
      GuildRankList.Add(GuildRank);
    end;

    //У���Ա�б��Ƿ��иı䣬���δ�޸����˳�
    boCheckChange := False;
    if m_RankList.Count = GuildRankList.Count then begin
      boCheckChange := True;
      for I := 0 to m_RankList.Count - 1 do begin
        GuildRank := m_RankList.Items[I];
        NewGuildRank := GuildRankList.Items[I];
        if (GuildRank.nRankNo = NewGuildRank.nRankNo) and
          (GuildRank.sRankName = NewGuildRank.sRankName) and
          (GuildRank.MemberList.Count = NewGuildRank.MemberList.Count) then begin
            for II := 0 to GuildRank.MemberList.Count - 1 do begin
              if GuildRank.MemberList.Strings[II] <> NewGuildRank.MemberList.Strings[II] then begin
                boCheckChange := False; //����иı�������ΪFALSE
                Break;
              end;
            end;
        end else begin
          boCheckChange := False;
          Break;
        end;
      end;//for
      if boCheckChange then begin
        Result := -1;
        ClearRankList(GuildRankList);
        Exit;
      end;
    end;

    //����л�����ְҵ�Ƿ�Ϊ��
    Result := -2;
    if (GuildRankList.Count > 0) then begin
      GuildRank := GuildRankList.Items[0];
      if GuildRank.nRankNo = 1 then begin
        if GuildRank.sRankName <> '' then begin
          Result := 0;
        end else begin
          Result := -3;
        end;
      end;
    end;

    //����л��������Ƿ�����(������)
    if Result = 0 then begin
      GuildRank := GuildRankList.Items[0];
      if GuildRank.MemberList.Count <= 2 then begin
        n28 := GuildRank.MemberList.Count;
        for I := 0 to GuildRank.MemberList.Count - 1 do begin
          if UserEngine.GetPlayObject(GuildRank.MemberList.Strings[I]) = nil then begin
            Dec(n28);
            Break;
          end;
        end;
        if n28 <= 0 then Result := -5;
      end else begin
        Result := -4;
      end;
    end;

    if Result = 0 then begin
      n2C:=0;
      n30:=0;
      for I := 0 to m_RankList.Count - 1 do begin
        GuildRank := m_RankList.Items[I];
        boCheckChange := True;
        for II := 0 to GuildRank.MemberList.Count - 1 do begin
          boCheckChange := False;
          sMemberName := GuildRank.MemberList.Strings[II];
          Inc(n2C);
          for III := 0 to GuildRankList.Count - 1 do begin //�������б�
            NewGuildRank := GuildRankList.Items[III];
            for n28 := 0 to NewGuildRank.MemberList.Count - 1 do begin
              if NewGuildRank.MemberList.Strings[n28] = sMemberName then begin
                boCheckChange := True;
                Break;
              end;
            end;
            if boCheckChange then Break;
          end;//for

          if not boCheckChange then begin //ԭ�б��е����������Ƿ����µ��б���
            Result := -6;
            Break;
          end;
        end;//for
        if not boCheckChange then Break;
      end;//for

      for I := 0 to GuildRankList.Count - 1 do begin
        GuildRank := GuildRankList.Items[I];
        boCheckChange := True;
        for II := 0 to GuildRank.MemberList.Count - 1 do begin
          boCheckChange := False;
          sMemberName := GuildRank.MemberList.Strings[II];
          Inc(n30);
          for III := 0 to GuildRankList.Count - 1 do begin
            NewGuildRank := GuildRankList.Items[III];
            for n28 := 0 to NewGuildRank.MemberList.Count - 1 do begin
              if NewGuildRank.MemberList.Strings[n28] = sMemberName then begin
                boCheckChange := True;
                Break;
              end;
            end;
            if boCheckChange then Break;
          end;//for
          if not boCheckChange then begin
            Result := -6;
            Break;
          end;
        end;//for
        if not boCheckChange then Break;
      end;//for
      if (Result = 0) and (n2C <> n30) then begin//n2c n30 ���ڱȽ��޸Ĺ��������
        Result := -6;
      end;
    end;

    if Result = 0 then begin //�����������
      n2C := 0;
      for I := 0 to GuildRankList.Count - 1 do begin
        n28 := pTGuildRank(GuildRankList.Items[I]).nRankNo;
        if n28 = 1 then begin
          Inc(n2C);
          if n2C > 1 then begin
            Result := -4;
            Break;
          end;
        end;
      end;
    end;

    if Result = 0 then begin //���ְλ���Ƿ��ظ����Ƿ�
      for I := 0 to GuildRankList.Count - 1 do begin
        n28 := pTGuildRank(GuildRankList.Items[I]).nRankNo;
        for III := I + 1 to GuildRankList.Count - 1 do begin
          if (pTGuildRank(GuildRankList.Items[III]).nRankNo = n28) or (n28 <= 0) or (n28 > 99) then begin
            Result := -7;
            Break;
          end;
        end;
        if Result <> 0 then Break;
      end;//for
    end;

    if Result = 0 then begin
      ClearRankList(m_RankList);
      m_RankList := GuildRankList;
      //������������ְλ��
      for I := 0 to m_RankList.Count - 1 do begin
        GuildRank := m_RankList.Items[I];
        for III := 0 to GuildRank.MemberList.Count - 1 do begin
          PlayObject := UserEngine.GetPlayObject(GuildRank.MemberList.Strings[III]);
          if PlayObject <> nil then begin
            GuildRank.MemberList.Objects[III] := TObject(PlayObject);
            PlayObject.RefRankInfo(GuildRank.nRankNo, GuildRank.sRankName);
            PlayObject.RefShowName(); //10/31
          end;
        end;
      end;//for
      UpdateGuildFile();
    end else begin
      ClearRankList(GuildRankList);
    end;
  except
    MainOutMessage('{�쳣} TGUild.UpdateRank');
  end;
end;

function TGUild.IsNotWarGuild(Guild: TGUild): Boolean;
var
  I: Integer;
begin
  Result := False;
  if GuildWarList.Count > 0 then begin//20080630
    for I := 0 to GuildWarList.Count - 1 do begin
      if pTWarGuild(GuildWarList.Objects[I]).Guild = Guild then begin
        Exit;
      end;
    end;
  end;
  Result := True;
end;

function TGUild.AllyGuild(Guild: TGUild): Boolean; //00499C2C
var
  I: Integer;
begin
  Result := False;
  if GuildAllList.Count > 0 then begin//20080630
    for I := 0 to GuildAllList.Count - 1 do begin
      if GuildAllList.Objects[I] = Guild then begin
        Exit;
      end;
    end;
  end;
  GuildAllList.AddObject(Guild.sGuildName, Guild);
  SaveGuildInfoFile();
  Result := True;
end;
//�����л�ս
function TGUild.AddWarGuild(Guild: TGUild): pTWarGuild;
var
  I: Integer;
  WarGuild: pTWarGuild;
begin
  Result := nil;
  if Guild <> nil then begin
    if not IsAllyGuild(Guild) then begin
      WarGuild := nil;
      if GuildWarList.Count > 0 then begin//20080630
        for I := 0 to GuildWarList.Count - 1 do begin
          if pTWarGuild(GuildWarList.Objects[I]).Guild = Guild then begin
            WarGuild := pTWarGuild(GuildWarList.Objects[I]);
            WarGuild.dwWarTick := GetTickCount();
            WarGuild.dwWarTime := g_Config.dwGuildWarTime {10800000};
            SendGuildMsg('***' + Guild.sGuildName + '�л�ս������������Сʱ��');
            Break;
          end;
        end;
      end;
      if WarGuild = nil then begin
        New(WarGuild);
        WarGuild.Guild := Guild;
        WarGuild.dwWarTick := GetTickCount();
        WarGuild.dwWarTime := g_Config.dwGuildWarTime {10800000};
        GuildWarList.AddObject(Guild.sGuildName, TObject(WarGuild));
        SendGuildMsg('***' + Guild.sGuildName + '�л�ս����ʼ(����Сʱ)');
      end;
      Result := WarGuild;
    end;
  end;
  RefMemberName();
  UpdateGuildFile();
end;

procedure TGUild.sub_499B4C(Guild: TGUild);
begin
  SendGuildMsg('***' + Guild.sGuildName + '�л�ս������');
end;

function TGUild.GetMemberCount: Integer;
var
  I: Integer;
  GuildRank: pTGuildRank;
begin
  Result := 0;
  if m_RankList.Count > 0 then begin//20080630
    for I := 0 to m_RankList.Count - 1 do begin
      GuildRank := m_RankList.Items[I];
      Inc(Result, GuildRank.MemberList.Count);
    end;
  end;
end;

function TGUild.GetMemgerIsFull: Boolean;
begin
  Result := False;
  if GetMemberCount >= g_Config.nGuildMemberMaxLimit then begin
    Result := True;
  end;
end;

procedure TGUild.StartTeamFight;
begin
  nContestPoint := 0;
  boTeamFight := True;
  TeamFightDeadList.Clear;
end;

procedure TGUild.EndTeamFight;
begin
  boTeamFight := False;
end;

procedure TGUild.AddTeamFightMember(sHumanName: string);
begin
  TeamFightDeadList.Add(sHumanName);
end;


procedure TGUild.SetAuraePoint(nPoint: Integer);
begin
  m_nAurae := nPoint;
  boChanged := True;
end;

procedure TGUild.SetBuildPoint(nPoint: Integer);
begin
  m_nBuildPoint := nPoint;
  boChanged := True;
end;

procedure TGUild.SetFlourishPoint(nPoint: Integer);
begin
  m_nFlourishing := nPoint;
  boChanged := True;
end;

procedure TGUild.SetStabilityPoint(nPoint: Integer);
begin
  m_nStability := nPoint;
  boChanged := True;
end;
procedure TGUild.SetChiefItemCount(nPoint: Integer);
begin
  m_nChiefItemCount := nPoint;
  boChanged := True;
end;

end.
