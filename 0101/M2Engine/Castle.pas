unit Castle;

interface
uses
  Windows, Classes, SysUtils, IniFiles, Grobal2, ObjBase, ObjMon2, Guild, Envir;
const
  MAXCASTLEARCHER = 12;
  MAXCALSTEGUARD = 4;
type
  TDefenseUnit = record
    nMainDoorX: Integer; //0x00
    nMainDoorY: Integer; //0x04
    sMainDoorName: string; //0x08
    boXXX: Boolean; //0x0C
    wMainDoorHP: Word; //0x10
    MainDoor: TBaseObject;
    LeftWall: TBaseObject;
    CenterWall: TBaseObject;
    RightWall: TBaseObject;
    Archer: TBaseObject;
  end;
  pTDefenseUnit = ^TDefenseUnit;
  TObjUnit = record
    nX: Integer; //0x0
    nY: Integer; //0x4
    sName: string; //0x8
    //    nStatus     :Integer;   //0x0C
    nStatus: Boolean; //0x0C
    nHP: Integer; //0x10
    BaseObject: TBaseObject; //0x14
  end;
  pTObjUnit = ^TObjUnit;
  TAttackerInfo = record
    AttackDate: TDateTime;
    sGuildName: string;
    Guild: TGUild;
  end;
  pTAttackerInfo = ^TAttackerInfo;
  TUserCastle = class
    m_MapCastle: TEnvirnoment; //�Ǳ����ڵ�ͼ
    m_MapPalace: TEnvirnoment; //�ʹ����ڵ�ͼ
    m_MapSecret: TEnvirnoment; //�ܵ����ڵ�ͼ
    m_DoorStatus: pTDoorStatus; //�ʹ���״̬
    m_sMapName: string; //�Ǳ����ڵ�ͼ��
    m_sName: string; //�Ǳ�����
    m_sOwnGuild: string; //�����л�����
    m_MasterGuild: TGUild; //�����л�
    m_sHomeMap: string; //�л�سǵ��ͼ
    m_nHomeX: Integer; //�л�سǵ�X
    m_nHomeY: Integer; //�л�سǵ�Y
    m_ChangeDate: TDateTime; //0x30
    m_WarDate: TDateTime; //��������
    m_boStartWar: Boolean; //�Ƿ�ʼ����
    m_boUnderWar: Boolean; //�Ƿ����ڹ���
    m_boShowOverMsg: Boolean; //�Ƿ�����ʾ���ǽ�����Ϣ
    m_dwStartCastleWarTick: LongWord; //0x44
    m_dwSaveTick: LongWord; //������
    m_AttackWarList: TList; //�����б�
    m_AttackGuildList: TList; //�����л��б�
    m_MainDoor: TObjUnit; //����
    m_LeftWall: TObjUnit; //�ʹ���
    m_CenterWall: TObjUnit; //�ʹ���
    m_RightWall: TObjUnit; //�ʹ���
    m_Guard: array[0..MAXCALSTEGUARD - 1] of TObjUnit; //0xB4
    m_Archer: array[0..MAXCASTLEARCHER - 1] of TObjUnit; //0x114 0x264
    m_IncomeToday: TDateTime; //0x238
    m_nTotalGold: Integer; //0x240
    m_nTodayIncome: Integer; //0x244
    m_nWarRangeX: Integer; //��������ΧX
    m_nWarRangeY: Integer; //��������ΧY
    //m_boStatus: Boolean;//δʹ�� 20080702
    m_sPalaceMap: string; //�ʹ����ڵ�ͼ
    m_sSecretMap: string; //�ܵ����ڵ�ͼ
    m_nPalaceDoorX: Integer; //�ʹ�����X
    m_nPalaceDoorY: Integer; //�ʹ�����Y
    m_sConfigDir: string;
    m_EnvirList: TStringList;

    m_nTechLevel: Integer; //�Ƽ��ȼ�
    m_nPower: Integer; //������
  private
    procedure LoadAttackSabukWall();
    procedure SaveConfigFile();
    procedure LoadConfig(IsReLoad: Boolean);
    procedure SaveAttackSabukWall();
    function InAttackerList(Guild: TGUild): Boolean;
    procedure SetTechLevel(nLevel: Integer);
    procedure SetPower(nPower: Integer);
   // function m_nChiefItemCount: Integer; //δʹ�� 20080330
  public
    constructor Create(sCastleDir: string);
    destructor Destroy; override;
    procedure Initialize();
    procedure Run();
    procedure Save();
    function InCastleWarArea(Envir: TEnvirnoment; nX, nY: Integer): Boolean;
    function IsMember(Cert: TBaseObject): Boolean;
    function IsMasterGuild(Guild: TGUild): Boolean;
    function IsAttackGuild(Guild: TGUild): Boolean;
    function IsAttackAllyGuild(Guild: TGUild): Boolean;
    function IsDefenseGuild(Guild: TGUild): Boolean;
    function IsDefenseAllyGuild(Guild: TGUild): Boolean;

    function CanGetCastle(Guild: TGUild): Boolean;
    procedure GetCastle(Guild: TGUild);
    procedure StartWallconquestWar;
    procedure StopWallconquestWar();
    function InPalaceGuildCount(): Integer;
    function GetHomeX(): Integer;
    function GetHomeY(): Integer;
    function GetMapName(): string;
    function AddAttackerInfo(Guild: TGUild; nCode: Byte): Boolean;
    function CheckInPalace(nX, nY: Integer; Cert: TBaseObject): Boolean;
    function GetWarDate(): string;
    function GetAttackWarList(): string;
    procedure IncRateGold(nGold: Integer);
    function WithDrawalGolds(PlayObject: TPlayObject; nGold: Integer): Integer;
    function ReceiptGolds(PlayObject: TPlayObject; nGold: Integer): Integer;
    procedure MainDoorControl(boClose: Boolean);
    function RepairDoor(): Boolean;
    function RepairWall(nWallIndex: Integer): Boolean;
    property nTechLevel: Integer read m_nTechLevel write SetTechLevel;
    property nPower: Integer read m_nPower write SetPower;
  end;

  TCastleManager = class
  private

    CriticalSection: TRTLCriticalSection;
  protected

  public
    m_CastleList: TList;//�Ǳ��б�
    constructor Create();
    destructor Destroy; override;
    procedure LoadCastleList();
    procedure SaveCastleList();
    procedure Initialize();
    procedure Lock;
    procedure UnLock;
    procedure Run();
    procedure Save();
    function Find(sCASTLENAME: string): TUserCastle;
    function GetCastle(nIndex: Integer): TUserCastle;
    function InCastleWarArea(BaseObject: TBaseObject): TUserCastle; overload;
    function InCastleWarArea(Envir: TEnvirnoment; nX, nY: Integer): TUserCastle; overload;
    function IsCastleMember(BaseObject: TBaseObject): TUserCastle;
    function IsCastlePalaceEnvir(Envir: TEnvirnoment): TUserCastle;
    function IsCastleEnvir(Envir: TEnvirnoment): TUserCastle;
    procedure GetCastleGoldInfo(List: TStringList);
    procedure GetCastleNameList(List: TStringList);
    procedure IncRateGold(nGold: Integer);

    procedure ReLoadCastle();
  end;
implementation

uses UsrEngn, M2Share, HUtil32;

{ TUserCastle }
constructor TUserCastle.Create(sCastleDir: string);
begin
  m_MasterGuild := nil;
  m_sHomeMap := g_Config.sCastleHomeMap {'3'};
  m_nHomeX := g_Config.nCastleHomeX {644};
  m_nHomeY := g_Config.nCastleHomeY {290};
  m_sName := g_Config.sCASTLENAME {'ɳ�Ϳ�'};

  m_sConfigDir := sCastleDir;
  m_sPalaceMap := '0150';
  m_sSecretMap := 'D701';
  m_MapCastle := nil;
  m_DoorStatus := nil;
  m_boStartWar := False;
  m_boUnderWar := False;
  m_boShowOverMsg := False;
  m_AttackWarList := TList.Create;
  m_AttackGuildList := TList.Create;
  m_dwSaveTick := 0;
  m_nWarRangeX := g_Config.nCastleWarRangeX;
  m_nWarRangeY := g_Config.nCastleWarRangeY;
  m_EnvirList := TStringList.Create;
end;

destructor TUserCastle.Destroy; //0048E51C
var
  I: Integer;
begin
  if m_AttackWarList.Count > 0 then begin//20080630
    for I := 0 to m_AttackWarList.Count - 1 do begin
      if pTAttackerInfo(m_AttackWarList.Items[I]) <> nil then
         Dispose(pTAttackerInfo(m_AttackWarList.Items[I]));
    end;
  end;
  m_AttackWarList.Free;
  m_AttackGuildList.Free;
  m_EnvirList.Free;
  inherited;
end;
procedure TUserCastle.Initialize;
var
  I: Integer;
  ObjUnit: pTObjUnit;
  Door: pTDoorInfo;
begin
  LoadConfig(False);
  LoadAttackSabukWall();
  if g_MapManager.GetMapOfServerIndex(m_sMapName) = nServerIndex then begin
    //m_MapPalace:=EnvirList.FindMap('0150');
    m_MapPalace := g_MapManager.FindMap(m_sPalaceMap);
    if m_MapPalace = nil then begin
      MainOutMessage(Format('�ʹ���ͼ%sû�ҵ�������', [m_sPalaceMap]));
    end;
    m_MapSecret := g_MapManager.FindMap(m_sSecretMap);
    if m_MapSecret = nil then begin
      MainOutMessage(Format('�ܵ���ͼ%sû�ҵ�������', [m_sSecretMap]));
    end;
    m_MapCastle := g_MapManager.FindMap(m_sMapName);
    if m_MapCastle <> nil then begin
      m_MainDoor.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_MainDoor.nX, m_MainDoor.nY, m_MainDoor.sName);
      if m_MainDoor.BaseObject <> nil then begin
        m_MainDoor.BaseObject.m_WAbil.HP := m_MainDoor.nHP;
        m_MainDoor.BaseObject.m_Castle := Self;
        //m_MainDoor.BaseObject.m_nCurrX := m_MainDoor.nX;//20080928
        //m_MainDoor.BaseObject.m_nCurrY := m_MainDoor.nY;//20080928
        //if MainDoor.nStatus <> 0 then begin
        if m_MainDoor.nStatus then begin
          TCastleDoor(m_MainDoor.BaseObject).Open;
        end;
      end else begin
        MainOutMessage('[������Ϣ] �Ǳ���ʼ������ʧ�ܣ����������ݿ�����û���ŵ�����: ' + m_MainDoor.sName);
      end;

      m_LeftWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_LeftWall.nX, m_LeftWall.nY, m_LeftWall.sName);
      if m_LeftWall.BaseObject <> nil then begin
        m_LeftWall.BaseObject.m_WAbil.HP := m_LeftWall.nHP;
        m_LeftWall.BaseObject.m_Castle := Self;
        //m_LeftWall.BaseObject.m_nCurrX := m_LeftWall.nX;//20080928
        //m_LeftWall.BaseObject.m_nCurrY := m_LeftWall.nY;//20080928
      end else begin
        MainOutMessage('[������Ϣ] �Ǳ���ʼ�����ǽʧ�ܣ����������ݿ�����û���ǽ������: ' + m_LeftWall.sName);
      end;

      m_CenterWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_CenterWall.nX, m_CenterWall.nY, m_CenterWall.sName);
      if m_CenterWall.BaseObject <> nil then begin
        m_CenterWall.BaseObject.m_WAbil.HP := m_CenterWall.nHP;
        m_CenterWall.BaseObject.m_Castle := Self;
        //m_CenterWall.BaseObject.m_nCurrX := m_CenterWall.nX;//20080928
        //m_CenterWall.BaseObject.m_nCurrY := m_CenterWall.nY;//20080928
      end else begin
        MainOutMessage('[������Ϣ] �Ǳ���ʼ���г�ǽʧ�ܣ����������ݿ�����û�г�ǽ������: ' + m_CenterWall.sName);
      end;

      m_RightWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_RightWall.nX, m_RightWall.nY, m_RightWall.sName);
      if m_RightWall.BaseObject <> nil then begin
        m_RightWall.BaseObject.m_WAbil.HP := m_RightWall.nHP;
        m_RightWall.BaseObject.m_Castle := Self;
        //m_RightWall.BaseObject.m_nCurrX := m_RightWall.nX;//20080928
        //m_RightWall.BaseObject.m_nCurrY := m_RightWall.nY;//20080928
      end else begin
        MainOutMessage('[������Ϣ] �Ǳ���ʼ���ҳ�ǽʧ�ܣ����������ݿ�����û�ҳ�ǽ������: ' + m_RightWall.sName);
      end;

      for I := Low(m_Archer) to High(m_Archer) do begin
        ObjUnit := @m_Archer[I];
        if ObjUnit.nHP <= 0 then Continue;
        ObjUnit.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, ObjUnit.nX, ObjUnit.nY, ObjUnit.sName);
        if ObjUnit.BaseObject <> nil then begin
          ObjUnit.BaseObject.m_WAbil.HP := m_Archer[I].nHP;
          ObjUnit.BaseObject.m_Castle := Self;
          TGuardUnit(ObjUnit.BaseObject).m_nX550 := ObjUnit.nX;
          TGuardUnit(ObjUnit.BaseObject).m_nY554 := ObjUnit.nY;
          TGuardUnit(ObjUnit.BaseObject).m_nDirection := 3;
        end else begin
          MainOutMessage('[������Ϣ] �Ǳ���ʼ��������ʧ�ܣ����������ݿ�����û�����ֵ�����: ' + ObjUnit.sName);
        end;
      end;
      for I := Low(m_Guard) to High(m_Guard) do begin
        ObjUnit := @m_Guard[I];
        if ObjUnit.nHP <= 0 then Continue;
        ObjUnit.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, ObjUnit.nX, ObjUnit.nY, ObjUnit.sName);
        if ObjUnit.BaseObject <> nil then begin
          ObjUnit.BaseObject.m_WAbil.HP := m_Guard[I].nHP;
        end else begin
          MainOutMessage('[������Ϣ] �Ǳ���ʼ������ʧ��(���������ݿ�����û��������)');
        end;
      end;
      if m_MapCastle.m_DoorList.Count > 0 then begin//20080630
        for I := 0 to m_MapCastle.m_DoorList.Count - 1 do begin
          Door := m_MapCastle.m_DoorList.Items[I];
          if (abs(Door.nX - m_nPalaceDoorX {631}) <= 3) and (abs(Door.nY - m_nPalaceDoorY {274}) <= 3) then begin
            m_DoorStatus := Door.Status;
          end;
        end;
      end;
    end else begin
      MainOutMessage(Format('[������Ϣ] �Ǳ����ڵ�ͼ������(����ͼ�����ļ����Ƿ��е�ͼ%s������)', [m_sMapName]));
    end;
  end;
end;

procedure TUserCastle.LoadConfig(IsReLoad: Boolean); //��ȡɳ�Ϳ������ļ�
var
  sFileName, sConfigFile: string;
  CastleConf: TIniFile;
  I: Integer;
  ObjUnit: pTObjUnit;
  sMapList, sMAP: string;
begin
  if not DirectoryExists(g_Config.sCastleDir + m_sConfigDir) then begin
    CreateDir(g_Config.sCastleDir + m_sConfigDir);
  end;
  sConfigFile := 'SabukW.txt';
  sFileName := g_Config.sCastleDir + m_sConfigDir + '\' + sConfigFile;
  CastleConf := TIniFile.Create(sFileName);
  if CastleConf <> nil then begin
    m_sName := CastleConf.ReadString('Setup', 'CastleName', m_sName);
    m_sOwnGuild := CastleConf.ReadString('Setup', 'OwnGuild', '');
    m_ChangeDate := CastleConf.ReadDateTime('Setup', 'ChangeDate', Now);
    m_WarDate := CastleConf.ReadDateTime('Setup', 'WarDate', Now);
    m_IncomeToday := CastleConf.ReadDateTime('Setup', 'IncomeToday', Now);
    m_nTotalGold := CastleConf.ReadInteger('Setup', 'TotalGold', 0);
    m_nTodayIncome := CastleConf.ReadInteger('Setup', 'TodayIncome', 0);

    sMapList := CastleConf.ReadString('Defense', 'CastleMapList', '');
    if sMapList <> '' then begin
      if IsReLoad then m_EnvirList.Clear;//��������أ�������б����ݣ��Է�ֹ�ظ� 20081130
      while (sMapList <> '') do begin
        sMapList := GetValidStr3(sMapList, sMAP, [',']);
        if sMAP = '' then Break;
        m_EnvirList.Add(sMAP);
      end;
    end;
    if m_EnvirList.Count > 0 then begin//20080630
      for I := 0 to m_EnvirList.Count - 1 do begin
        m_EnvirList.Objects[I] := g_MapManager.FindMap(m_EnvirList.Strings[I]);
      end;
    end;

    m_sMapName := CastleConf.ReadString('Defense', 'CastleMap', '3');
    m_sHomeMap := CastleConf.ReadString('Defense', 'CastleHomeMap', m_sHomeMap);
    m_nHomeX := CastleConf.ReadInteger('Defense', 'CastleHomeX', m_nHomeX);
    m_nHomeY := CastleConf.ReadInteger('Defense', 'CastleHomeY', m_nHomeY);
    m_nWarRangeX := CastleConf.ReadInteger('Defense', 'CastleWarRangeX', m_nWarRangeX);
    m_nWarRangeY := CastleConf.ReadInteger('Defense', 'CastleWarRangeY', m_nWarRangeY);
    m_sPalaceMap := CastleConf.ReadString('Defense', 'CastlePlaceMap', m_sPalaceMap);
    m_sSecretMap := CastleConf.ReadString('Defense', 'CastleSecretMap', m_sSecretMap);
    m_nPalaceDoorX := CastleConf.ReadInteger('Defense', 'CastlePalaceDoorX', 631);
    m_nPalaceDoorY := CastleConf.ReadInteger('Defense', 'CastlePalaceDoorY', 274);

    m_MainDoor.nX := CastleConf.ReadInteger('Defense', 'MainDoorX', 672);
    m_MainDoor.nY := CastleConf.ReadInteger('Defense', 'MainDoorY', 330);
    m_MainDoor.sName := CastleConf.ReadString('Defense', 'MainDoorName', '����');
    m_MainDoor.nStatus := CastleConf.ReadBool('Defense', 'MainDoorOpen', True);
    m_MainDoor.nHP := CastleConf.ReadInteger('Defense', 'MainDoorHP', 2000);
    //if m_MainDoor.nHP <= 0 then m_MainDoor.nHP := 2000;//20081028 �޸�
    if m_MainDoor.nHP <= 0 then begin
      if m_MainDoor.BaseObject <> nil then begin
        m_MainDoor.BaseObject.m_boGhost := True;
        m_MainDoor.BaseObject.DisappearA();
      end;
      m_MainDoor.nHP := 2000;
    end;
    if not IsReLoad then m_MainDoor.BaseObject := nil;

    m_LeftWall.nX := CastleConf.ReadInteger('Defense', 'LeftWallX', 624);
    m_LeftWall.nY := CastleConf.ReadInteger('Defense', 'LeftWallY', 278);
    m_LeftWall.sName := CastleConf.ReadString('Defense', 'LeftWallName', '���ǽ');
    m_LeftWall.nHP := CastleConf.ReadInteger('Defense', 'LeftWallHP', 2000);
    //if m_LeftWall.nHP <= 0 then m_LeftWall.nHP := 2000;//20081028 �޸�
    if m_LeftWall.nHP <= 0 then begin
      if m_LeftWall.BaseObject <> nil then begin
        m_LeftWall.BaseObject.m_boGhost := True;
        m_LeftWall.BaseObject.DisappearA();
      end;
      m_LeftWall.nHP := 2000;
    end;
    if not IsReLoad then m_LeftWall.BaseObject := nil;

    m_CenterWall.nX := CastleConf.ReadInteger('Defense', 'CenterWallX', 627);
    m_CenterWall.nY := CastleConf.ReadInteger('Defense', 'CenterWallY', 278);
    m_CenterWall.sName := CastleConf.ReadString('Defense', 'CenterWallName', '�г�ǽ');
    m_CenterWall.nHP := CastleConf.ReadInteger('Defense', 'CenterWallHP', 2000);
    //if m_CenterWall.nHP <= 0 then m_CenterWall.nHP := 2000;//20081028 �޸�
    if m_LeftWall.nHP <= 0 then begin
      if m_CenterWall.BaseObject <> nil then begin
        m_CenterWall.BaseObject.m_boGhost := True;
        m_CenterWall.BaseObject.DisappearA();
      end;
      m_CenterWall.nHP := 2000;
    end;
    if not IsReLoad then m_CenterWall.BaseObject := nil;

    m_RightWall.nX := CastleConf.ReadInteger('Defense', 'RightWallX', 634);
    m_RightWall.nY := CastleConf.ReadInteger('Defense', 'RightWallY', 271);
    m_RightWall.sName := CastleConf.ReadString('Defense', 'RightWallName', '�ҳ�ǽ');
    m_RightWall.nHP := CastleConf.ReadInteger('Defense', 'RightWallHP', 2000);
    //if m_RightWall.nHP <= 0 then m_RightWall.nHP := 2000; //20081028 �޸�
    if m_RightWall.nHP <= 0 then begin
      if m_RightWall.BaseObject <> nil then begin
        m_RightWall.BaseObject.m_boGhost := True;
        m_RightWall.BaseObject.DisappearA();
      end;
      m_RightWall.nHP := 2000;
    end;
    if not IsReLoad then m_RightWall.BaseObject := nil;

    for I := Low(m_Archer) to High(m_Archer) do begin
      ObjUnit := @m_Archer[I];
      ObjUnit.nX := CastleConf.ReadInteger('Defense', 'Archer_' + IntToStr(I + 1) + '_X', 0);
      ObjUnit.nY := CastleConf.ReadInteger('Defense', 'Archer_' + IntToStr(I + 1) + '_Y', 0);
      ObjUnit.sName := CastleConf.ReadString('Defense', 'Archer_' + IntToStr(I + 1) + '_Name', '������');
      ObjUnit.nHP := CastleConf.ReadInteger('Defense', 'Archer_' + IntToStr(I + 1) + '_HP', 2000);
      if not IsReLoad then ObjUnit.BaseObject := nil;
    end;

    for I := Low(m_Guard) to High(m_Guard) do begin
      ObjUnit := @m_Guard[I];
      ObjUnit.nX := CastleConf.ReadInteger('Defense', 'Guard_' + IntToStr(I + 1) + '_X', 0);
      ObjUnit.nY := CastleConf.ReadInteger('Defense', 'Guard_' + IntToStr(I + 1) + '_Y', 0);
      ObjUnit.sName := CastleConf.ReadString('Defense', 'Guard_' + IntToStr(I + 1) + '_Name', '����');
      ObjUnit.nHP := CastleConf.ReadInteger('Defense', 'Guard_' + IntToStr(I + 1) + '_HP', 2000);
      if not IsReLoad then ObjUnit.BaseObject := nil;
    end;
    CastleConf.Free;
  end;
  m_MasterGuild := g_GuildManager.FindGuild(m_sOwnGuild);
end;

procedure TUserCastle.SaveConfigFile();//����ɳ�Ϳ������ļ�
var
  CastleConf: TIniFile;
  ObjUnit: pTObjUnit;
  sFileName, sConfigFile: string;
  sMapList: string;
  I: Integer;
  nCode:Byte;
begin
  nCode:= 0;
  try
    if not DirectoryExists(g_Config.sCastleDir + m_sConfigDir) then begin
      CreateDir(g_Config.sCastleDir + m_sConfigDir);
    end;
    nCode:= 1;
    if g_MapManager.GetMapOfServerIndex(m_sMapName) <> nServerIndex then Exit;
    sConfigFile := 'SabukW.txt';
    sFileName := g_Config.sCastleDir + m_sConfigDir + '\' + sConfigFile;
    CastleConf := TIniFile.Create(sFileName);
    nCode:= 2;
    if CastleConf <> nil then begin
      if m_sName <> '' then CastleConf.WriteString('Setup', 'CastleName', m_sName);
      if m_sOwnGuild <> '' then CastleConf.WriteString('Setup', 'OwnGuild', m_sOwnGuild);
      nCode:= 3;
      CastleConf.WriteDateTime('Setup', 'ChangeDate', m_ChangeDate);
      CastleConf.WriteDateTime('Setup', 'WarDate', m_WarDate);
      CastleConf.WriteDateTime('Setup', 'IncomeToday', m_IncomeToday);
      if m_nTotalGold <> 0 then CastleConf.WriteInteger('Setup', 'TotalGold', m_nTotalGold);
      if m_nTodayIncome <> 0 then CastleConf.WriteInteger('Setup', 'TodayIncome', m_nTodayIncome);

      if m_EnvirList.Count > 0 then begin//20080630
        nCode:= 4;
        for I := 0 to m_EnvirList.Count - 1 do begin
          sMapList := sMapList + m_EnvirList.Strings[I] + ',';
        end;
      end;
      if sMapList <> '' then CastleConf.WriteString('Defense', 'CastleMapList', sMapList);

      if m_sMapName <> '' then CastleConf.WriteString('Defense', 'CastleMap', m_sMapName);
      if m_sHomeMap <> '' then CastleConf.WriteString('Defense', 'CastleHomeMap', m_sHomeMap);
      if m_nHomeX <> 0 then CastleConf.WriteInteger('Defense', 'CastleHomeX', m_nHomeX);
      if m_nHomeY <> 0 then CastleConf.WriteInteger('Defense', 'CastleHomeY', m_nHomeY);
      if m_nWarRangeX <> 0 then CastleConf.WriteInteger('Defense', 'CastleWarRangeX', m_nWarRangeX);
      if m_nWarRangeY <> 0 then CastleConf.WriteInteger('Defense', 'CastleWarRangeY', m_nWarRangeY);

      if m_sPalaceMap <> '' then CastleConf.WriteString('Defense', 'CastlePlaceMap', m_sPalaceMap);
      if m_sSecretMap <> '' then CastleConf.WriteString('Defense', 'CastleSecretMap', m_sSecretMap);
      if m_nPalaceDoorX <> 0 then CastleConf.WriteInteger('Defense', 'CastlePalaceDoorX', m_nPalaceDoorX);
      if m_nPalaceDoorY <> 0 then CastleConf.WriteInteger('Defense', 'CastlePalaceDoorY', m_nPalaceDoorY);

      if m_MainDoor.nX <> 0 then CastleConf.WriteInteger('Defense', 'MainDoorX', m_MainDoor.nX);
      if m_MainDoor.nY <> 0 then CastleConf.WriteInteger('Defense', 'MainDoorY', m_MainDoor.nY);
      if m_MainDoor.sName <> '' then CastleConf.WriteString('Defense', 'MainDoorName', m_MainDoor.sName);
      nCode:= 5;
      if m_MainDoor.BaseObject <> nil then begin
        nCode:= 6;
        CastleConf.WriteBool('Defense', 'MainDoorOpen', m_MainDoor.nStatus);
        CastleConf.WriteInteger('Defense', 'MainDoorHP', m_MainDoor.BaseObject.m_WAbil.HP);
      end;

      if m_LeftWall.nX <> 0 then CastleConf.WriteInteger('Defense', 'LeftWallX', m_LeftWall.nX);
      if m_LeftWall.nY <> 0 then CastleConf.WriteInteger('Defense', 'LeftWallY', m_LeftWall.nY);
      if m_LeftWall.sName <> '' then CastleConf.WriteString('Defense', 'LeftWallName', m_LeftWall.sName);
      nCode:= 7;
      if m_LeftWall.BaseObject <> nil then begin
        CastleConf.WriteInteger('Defense', 'LeftWallHP', m_LeftWall.BaseObject.m_WAbil.HP);
      end;
      nCode:= 8;
      if m_CenterWall.nX <> 0 then CastleConf.WriteInteger('Defense', 'CenterWallX', m_CenterWall.nX);
      if m_CenterWall.nY <> 0 then CastleConf.WriteInteger('Defense', 'CenterWallY', m_CenterWall.nY);
      if m_CenterWall.sName <> '' then CastleConf.WriteString('Defense', 'CenterWallName', m_CenterWall.sName);
      nCode:= 9;
      if m_CenterWall.BaseObject <> nil then begin
        CastleConf.WriteInteger('Defense', 'CenterWallHP', m_CenterWall.BaseObject.m_WAbil.HP);
      end;
      nCode:= 10;
      if m_RightWall.nX <> 0 then CastleConf.WriteInteger('Defense', 'RightWallX', m_RightWall.nX);
      if m_RightWall.nY <> 0 then CastleConf.WriteInteger('Defense', 'RightWallY', m_RightWall.nY);
      if m_RightWall.sName <> '' then CastleConf.WriteString('Defense', 'RightWallName', m_RightWall.sName);
      nCode:= 11;
      if m_RightWall.BaseObject <> nil then begin
        CastleConf.WriteInteger('Defense', 'RightWallHP', m_RightWall.BaseObject.m_WAbil.HP);
      end;
      nCode:= 12;
      for I := Low(m_Archer) to High(m_Archer) do begin
        ObjUnit := @m_Archer[I];
        nCode:= 13;
        if ObjUnit.nX <> 0 then CastleConf.WriteInteger('Defense', 'Archer_' + IntToStr(I + 1) + '_X', ObjUnit.nX);
        if ObjUnit.nY <> 0 then CastleConf.WriteInteger('Defense', 'Archer_' + IntToStr(I + 1) + '_Y', ObjUnit.nY);
        if ObjUnit.sName <> '' then CastleConf.WriteString('Defense', 'Archer_' + IntToStr(I + 1) + '_Name', ObjUnit.sName);
        nCode:= 14;
        if ObjUnit.BaseObject <> nil then begin
          CastleConf.WriteInteger('Defense', 'Archer_' + IntToStr(I + 1) + '_HP', ObjUnit.BaseObject.m_WAbil.HP);
        end else begin
          CastleConf.WriteInteger('Defense', 'Archer_' + IntToStr(I + 1) + '_HP', 0);
        end;
      end;
      nCode:= 15;
      for I := Low(m_Guard) to High(m_Guard) do begin
        ObjUnit := @m_Guard[I];
        nCode:= 16;
        if ObjUnit.nX <> 0 then CastleConf.WriteInteger('Defense', 'Guard_' + IntToStr(I + 1) + '_X', ObjUnit.nX);
        if ObjUnit.nY <> 0 then CastleConf.WriteInteger('Defense', 'Guard_' + IntToStr(I + 1) + '_Y', ObjUnit.nY);
        if ObjUnit.sName <> '' then CastleConf.WriteString('Defense', 'Guard_' + IntToStr(I + 1) + '_Name', ObjUnit.sName);
        nCode:= 17;
        if ObjUnit.BaseObject <> nil then begin
          CastleConf.WriteInteger('Defense', 'Guard_' + IntToStr(I + 1) + '_HP', ObjUnit.BaseObject.m_WAbil.HP);
        end else begin
          CastleConf.WriteInteger('Defense', 'Guard_' + IntToStr(I + 1) + '_HP', 0);
        end;
      end;
      CastleConf.Free;
    end;
  except
    MainOutMessage('{�쳣} TUserCastle.SaveConfigFile Code:'+IntToStr(nCode));
  end;
end;
//��ȡ�����б�
procedure TUserCastle.LoadAttackSabukWall();
var
  I: Integer;
  sFileName, sConfigFile: string;
  LoadList: TStringList;
  sData: string;
  s20, sGuildName: string;
  Guild: TGUild;
  AttackerInfo: pTAttackerInfo;
begin
  //  sFileName:=g_Config.sCastleDir + 'AttackSabukWall.txt';
  if not DirectoryExists(g_Config.sCastleDir + m_sConfigDir) then begin
    CreateDir(g_Config.sCastleDir + m_sConfigDir);
  end;
  sConfigFile := 'AttackSabukWall.txt';
  sFileName := g_Config.sCastleDir + m_sConfigDir + '\' + sConfigFile;
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sFileName);
      if m_AttackWarList.Count > 0 then begin//20080630
        for I := 0 to m_AttackWarList.Count - 1 do begin
          if pTAttackerInfo(m_AttackWarList.Items[I]) <> nil then
             Dispose(pTAttackerInfo(m_AttackWarList.Items[I]));
        end;
      end;
      m_AttackWarList.Clear;
      if LoadList.Count > 0 then begin//20080630
        for I := 0 to LoadList.Count - 1 do begin
          sData := LoadList.Strings[I];
          s20 := GetValidStr3(sData, sGuildName, [' ', #9]);
          Guild := g_GuildManager.FindGuild(sGuildName);
          if Guild <> nil then begin
            New(AttackerInfo);
            ArrestStringEx(s20, '"', '"', s20);
            try
              AttackerInfo.AttackDate := StrToDate(s20);
            except
              AttackerInfo.AttackDate := Now();
            end;
            AttackerInfo.sGuildName := sGuildName;
            AttackerInfo.Guild := Guild;
            m_AttackWarList.Add(AttackerInfo);
          end;
        end;//for
      end;
    except
      MainOutMessage('��ȡ�����ļ�ʧ��:'+ sFileName);
    end;
    LoadList.Free;
  end;
end;
//���湥���б�
procedure TUserCastle.SaveAttackSabukWall();
var
  I: Integer;
  sFileName, sConfigFile: string;
  LoadLis: TStringList;
  AttackerInfo: pTAttackerInfo;
begin
  if not DirectoryExists(g_Config.sCastleDir + m_sConfigDir) then begin
    CreateDir(g_Config.sCastleDir + m_sConfigDir);
  end;
  sConfigFile := 'AttackSabukWall.txt';
  sFileName := g_Config.sCastleDir + m_sConfigDir + '\' + sConfigFile;
  LoadLis := TStringList.Create;
  if m_AttackWarList.Count > 0 then begin//20080630
    for I := 0 to m_AttackWarList.Count - 1 do begin
      AttackerInfo := m_AttackWarList.Items[I];
      LoadLis.Add(AttackerInfo.sGuildName + '       "' + DateToStr(AttackerInfo.AttackDate) + '"');
    end;
  end;
  try
    LoadLis.SaveToFile(sFileName);
  except
    MainOutMessage('���湥����Ϣʧ��: ' + sFileName);
  end;
  LoadLis.Free;
end;
procedure TUserCastle.Run; //0048FE4C
{$IF SoftVersion <> VERDEMO}
var
  I: Integer;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  wYear, wMonth, wDay: Word;
  AttackerInfo: pTAttackerInfo;
  s20: string;
{$IFEND}
resourcestring
  sWarStartMsg = '[%s ����ս�Ѿ���ʼ]';
  sWarStopTimeMsg = '[%s ����ս���������%d����]';
  sExceptionMsg = '{�쳣} TUserCastle::Run';
begin
  try
    if nServerIndex <> g_MapManager.GetMapOfServerIndex(m_sMapName) then Exit;
{$IF SoftVersion <> VERDEMO}
    DecodeDate(Now, Year, Month, Day);
    DecodeDate(m_IncomeToday, wYear, wMonth, wDay);
    if (Year <> wYear) or (Month <> wMonth) or (Day <> wDay) then begin
      m_nTodayIncome := 0;
      m_IncomeToday := Now();
      m_boStartWar := False;
    end;
    if not m_boStartWar and (not m_boUnderWar) then begin
      DecodeTime(Time, Hour, Min, Sec, MSec);
      if Hour = g_Config.nStartCastlewarTime {20} then begin
        m_boStartWar := True; ;
        m_AttackGuildList.Clear;
        for I := m_AttackWarList.Count - 1 downto 0 do begin
          if m_AttackWarList.Count <= 0 then Break;
          AttackerInfo := m_AttackWarList.Items[I];
          DecodeDate(AttackerInfo.AttackDate, wYear, wMonth, wDay);
          if (Year = wYear) and (Month = wMonth) and (Day = wDay) then begin
            m_boUnderWar := True;
            m_boShowOverMsg := False;
            m_WarDate := Now();
            m_dwStartCastleWarTick := GetTickCount();
            m_AttackGuildList.Add(AttackerInfo.Guild);
            Dispose(AttackerInfo);
            m_AttackWarList.Delete(I);
          end;
        end;
        if m_boUnderWar then begin//��ʼ����
          m_AttackGuildList.Add(m_MasterGuild);
          StartWallconquestWar();
          SaveAttackSabukWall();
          UserEngine.SendServerGroupMsg(SS_212, nServerIndex, '');
          s20 := Format(sWarStartMsg, [m_sName]);
          UserEngine.SendBroadCastMsgExt(s20, t_System);
          UserEngine.SendServerGroupMsg(SS_204, nServerIndex, s20);
          MainOutMessage(s20);
          MainDoorControl(True);
        end;
      end;
    end;
    for I := Low(m_Guard) to High(m_Guard) do begin
      if (m_Guard[I].BaseObject <> nil) and (m_Guard[I].BaseObject.m_boGhost) then begin
        m_Guard[I].BaseObject := nil;
      end;
    end;
    for I := Low(m_Archer) to High(m_Archer) do begin
      if (m_Archer[I].BaseObject <> nil) and (m_Archer[I].BaseObject.m_boGhost) then begin
        m_Archer[I].BaseObject := nil;
      end;
    end;
    if m_boUnderWar then begin//���ڹ���
      if (m_MainDoor.BaseObject <> nil) then begin//20081201 ����ֵ��������ò���Ӧ�����ؽ�
        if (CompareText(m_MainDoor.BaseObject.m_sCharName, m_MainDoor.sName) <> 0) then begin
          m_MainDoor.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_MainDoor.nX, m_MainDoor.nY, m_MainDoor.sName);
          if m_MainDoor.BaseObject <> nil then begin
            m_MainDoor.BaseObject.m_WAbil.HP := m_MainDoor.nHP;
            m_MainDoor.BaseObject.m_Castle := self;
            m_MainDoor.BaseObject.m_nCurrX := m_MainDoor.nX;
            m_MainDoor.BaseObject.m_nCurrY := m_MainDoor.nY;
            MainDoorControl(True);
          end;
        end;
      end;
      if m_LeftWall.BaseObject <> nil then begin//20081201 ����ֵ��������ò���Ӧ�����ؽ�
        if (CompareText(m_LeftWall.BaseObject.m_sCharName, m_LeftWall.sName) <> 0) then begin//20081201
          m_LeftWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_LeftWall.nX, m_LeftWall.nY, m_LeftWall.sName);
          if m_LeftWall.BaseObject <> nil then begin
            m_LeftWall.BaseObject.m_WAbil.HP := m_LeftWall.nHP;
            m_LeftWall.BaseObject.m_Castle := self;
            m_LeftWall.BaseObject.m_nCurrX := m_LeftWall.nX;
            m_LeftWall.BaseObject.m_nCurrY := m_LeftWall.nY;
          end;
        end;
        m_LeftWall.BaseObject.m_boStoneMode := False;
      end;
      if m_CenterWall.BaseObject <> nil then begin//20081201 ����ֵ��������ò���Ӧ�����ؽ�
        if (CompareText(m_CenterWall.BaseObject.m_sCharName, m_CenterWall.sName) <> 0) then begin//20081201
          m_CenterWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_CenterWall.nX, m_CenterWall.nY, m_CenterWall.sName);
          if m_CenterWall.BaseObject <> nil then begin
            m_CenterWall.BaseObject.m_WAbil.HP := m_CenterWall.nHP;
            m_CenterWall.BaseObject.m_Castle := self;
            m_CenterWall.BaseObject.m_nCurrX := m_CenterWall.nX;
            m_CenterWall.BaseObject.m_nCurrY := m_CenterWall.nY;
          end;
        end;
        m_CenterWall.BaseObject.m_boStoneMode := False;
      end;
      if m_RightWall.BaseObject <> nil then begin//20081201 ����ֵ��������ò���Ӧ�����ؽ�
        if (CompareText(m_RightWall.BaseObject.m_sCharName, m_RightWall.sName) <> 0) then begin//20081201
          m_RightWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_RightWall.nX, m_RightWall.nY, m_RightWall.sName);
          if m_CenterWall.BaseObject <> nil then begin
            m_RightWall.BaseObject.m_WAbil.HP := m_RightWall.nHP;
            m_RightWall.BaseObject.m_Castle := self;
            m_RightWall.BaseObject.m_nCurrX := m_RightWall.nX;
            m_RightWall.BaseObject.m_nCurrY := m_RightWall.nY;
          end;
        end;
        m_RightWall.BaseObject.m_boStoneMode := False;
      end;
      if not m_boShowOverMsg then begin //00490181
        if (GetTickCount - m_dwStartCastleWarTick) > (g_Config.dwCastleWarTime - g_Config.dwShowCastleWarEndMsgTime) {3 * 60 * 60 * 1000 - 10 * 60 * 1000} then begin
          m_boShowOverMsg := True;
          s20 := Format(sWarStopTimeMsg, [m_sName, g_Config.dwShowCastleWarEndMsgTime div 60000{(60 * 1000)}]);
          UserEngine.SendBroadCastMsgExt(s20, t_System);
          UserEngine.SendServerGroupMsg(SS_204, nServerIndex, s20);
          MainOutMessage(s20);
        end;
      end;
      if (GetTickCount - m_dwStartCastleWarTick) > g_Config.dwCastleWarTime {3 * 60 * 60 * 1000} then begin
        StopWallconquestWar();//ֹͣ����
      end;
    end else begin
      if m_LeftWall.BaseObject <> nil then m_LeftWall.BaseObject.m_boStoneMode := True;
      if m_CenterWall.BaseObject <> nil then m_CenterWall.BaseObject.m_boStoneMode := True;
      if m_RightWall.BaseObject <> nil then m_RightWall.BaseObject.m_boStoneMode := True;
    end;
{$IFEND}
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TUserCastle.Save;
begin
  SaveConfigFile();
  SaveAttackSabukWall();
end;

function TUserCastle.InCastleWarArea(Envir: TEnvirnoment; nX, nY: Integer): Boolean; //004910F4
var
  I: Integer;
begin
  Result := False;
  if (Envir = m_MapCastle) and
    (abs(m_nHomeX - nX) < m_nWarRangeX {100}) and
    (abs(m_nHomeY - nY) < m_nWarRangeY {100}) then begin
    Result := True;
    Exit;
  end;
  if (Envir = m_MapPalace) or (Envir = m_MapSecret) then begin
    Result := True;
    Exit;
  end;
  //����ȡ�óǱ����е�ͼ�б�
  if m_EnvirList.Count > 0 then begin//20080630
    for I := 0 to m_EnvirList.Count - 1 do begin
      if m_EnvirList.Objects[I] = Envir then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;
//�ǵĻ�Ա
function TUserCastle.IsMember(Cert: TBaseObject): Boolean; //00490438
begin
  Result := IsMasterGuild(TGUild(Cert.m_MyGuild));
end;

//����Ƿ�Ϊ���Ƿ��л�������л�
function TUserCastle.IsAttackAllyGuild(Guild: TGUild): Boolean;
var
  I: Integer;
  AttackGuild: TGUild;
begin
  Result := False;
  if m_AttackGuildList.Count > 0 then begin//20080630
    for I := 0 to m_AttackGuildList.Count - 1 do begin
      AttackGuild := TGUild(m_AttackGuildList.Items[I]);
      if (AttackGuild <> m_MasterGuild) and AttackGuild.IsAllyGuild(Guild) then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;
//����Ƿ�Ϊ���Ƿ��л�
function TUserCastle.IsAttackGuild(Guild: TGUild): Boolean; //00491160
var
  I: Integer;
  AttackGuild: TGUild;
begin
  Result := False;
  if m_AttackGuildList.Count > 0 then begin//20080630
    for I := 0 to m_AttackGuildList.Count - 1 do begin
      AttackGuild := TGUild(m_AttackGuildList.Items[I]);
      if (AttackGuild <> m_MasterGuild) and (AttackGuild = Guild) then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

function TUserCastle.CanGetCastle(Guild: TGUild): Boolean; //004911D0
var
  I: Integer;
  List14: TList;
  PlayObject: TPlayObject;
begin
  Result := False;
  if (GetTickCount - m_dwStartCastleWarTick) > g_Config.dwGetCastleTime {10 * 60 * 1000} then begin
    List14 := TList.Create;
    UserEngine.GetMapRageHuman(m_MapPalace, 0, 0, 1000, List14);
    Result := True;
    if List14.Count > 0 then begin//20080630
      for I := 0 to List14.Count - 1 do begin
        PlayObject := TPlayObject(List14.Items[I]);
        if not PlayObject.m_boDeath and (PlayObject.m_MyGuild <> Guild) then begin
          Result := False;
          Break;
        end;
      end;
    end;
    List14.Free;
  end;
end;
//ɳ�Ǳ�ռ��
procedure TUserCastle.GetCastle(Guild: TGUild);
var
  OldGuild: TGUild;
  s10: string;
  nCode: Byte;
resourcestring
  sGetCastleMsg = '[%s �ѱ� %s ռ��]';
begin
  nCode:= 0;
  try  
    OldGuild := m_MasterGuild;
    nCode:= 1;
    m_MasterGuild := Guild;
    nCode:= 2;
    m_sOwnGuild := Guild.sGuildName;
    nCode:= 3;
    m_ChangeDate := Now();
    nCode:= 4;
    SaveConfigFile();
    nCode:= 5;
    if OldGuild <> nil then OldGuild.RefMemberName;
    nCode:= 6;
    if m_MasterGuild <> nil then m_MasterGuild.RefMemberName;
    nCode:= 7;
    s10 := Format(sGetCastleMsg, [m_sName, m_sOwnGuild]);
    nCode:= 8;
    UserEngine.SendBroadCastMsgExt(s10, t_System);
    nCode:= 9;
    UserEngine.SendServerGroupMsg(SS_204, nServerIndex, s10);
    nCode:= 10;
    MainOutMessage(s10);
  except
    MainOutMessage('{�쳣} TUserCastle.GetCastle Code:'+inttostr(nCode));
  end;
end;

procedure TUserCastle.StartWallconquestWar; //00491074
var
  ListC: TList;
  I: Integer;
  PlayObject: TPlayObject;
begin
  ListC := TList.Create;
  UserEngine.GetMapRageHuman(m_MapPalace, m_nHomeX, m_nHomeY, 100, ListC);
  if ListC.Count > 0 then begin//20080630
    for I := 0 to ListC.Count - 1 do begin
      PlayObject := TPlayObject(ListC.Items[I]);
      PlayObject.RefShowName();
    end;
  end;
  ListC.Free;
end;

procedure TUserCastle.StopWallconquestWar;
var
//  I: Integer;
//  ListC: TList;
//  PlayObject: TPlayObject;
  s14: string;
resourcestring
  sWallWarStop = '[%s ����ս�Ѿ�����]';
begin
  m_boUnderWar := False;
  m_AttackGuildList.Clear;
  {ListC := TList.Create;
  //UserEngine.GetMapOfRangeHumanCount(m_MapCastle, m_nHomeX, m_nHomeY, 100);
  UserEngine.GetMapRageHuman(m_MapPalace, m_nHomeX, m_nHomeY, 100, ListC);
  for i := 0 to ListC.Count - 1 do begin
    PlayObject := TPlayObject(ListC.Items[i]);
    PlayObject.ChangePKStatus(False);
    if PlayObject.m_MyGuild <> m_MasterGuild then
      PlayObject.MapRandomMove(PlayObject.m_sHomeMap, 0);
  end;
  ListC.Free;   }
  s14 := Format(sWallWarStop, [m_sName]);
  UserEngine.SendBroadCastMsgExt(s14, t_System);
  UserEngine.SendServerGroupMsg(SS_204, nServerIndex, s14);
  MainOutMessage(s14);
end;

function TUserCastle.InPalaceGuildCount: Integer; //����GM�ڻʹ�����ʾ���ǽ���
{var
  i: Integer;
  ListC: TList;
  PlayObject: TPlayObject;
  OldGuild: TGUild;
  nCount: Integer;}
begin
  {Result := 0;
  OldGuild := nil;
  nCount := 0;
  ListC := TList.Create;
  UserEngine.GetMapRageHuman(m_MapPalace, 0, 0, 1000, ListC);
  for i := 0 to ListC.Count - 1 do begin
    PlayObject := TPlayObject(ListC.Items[i]);
    if (not PlayObject.m_boDeath) and ((OldGuild = nil) or (OldGuild <> TGUild(PlayObject.m_MyGuild))) and (PlayObject.m_btPermission < 10) then begin
      OldGuild := TGUild(PlayObject.m_MyGuild);
      Inc(nCount);
    end;
  end;
  ListC.Free;
  Result := nCount; }
  Result := m_AttackGuildList.Count;
end;

function TUserCastle.IsDefenseAllyGuild(Guild: TGUild): Boolean;
begin
  Result := False;
  if not m_boUnderWar then Exit; //���δ��ʼ���ǣ�����Ч
  if m_MasterGuild <> nil then
    Result := m_MasterGuild.IsAllyGuild(Guild);
end;

//����Ƿ�Ϊ�سǷ��л�
function TUserCastle.IsDefenseGuild(Guild: TGUild): Boolean;
begin
  Result := False;
  if not m_boUnderWar then Exit; //���δ��ʼ���ǣ�����Ч
  if Guild = m_MasterGuild then Result := True;
end;
//����Ƿ�Ϊɳ�������л�
function TUserCastle.IsMasterGuild(Guild: TGUild): Boolean; 
begin
  Result := False;
  if (m_MasterGuild <> nil) and (m_MasterGuild = Guild) then
    Result := True;
end;

function TUserCastle.GetHomeX: Integer; //004902B0
begin
  Result := (m_nHomeX - 4) + Random(9);
end;

function TUserCastle.GetHomeY: Integer; //004902D8
begin
  Result := (m_nHomeY - 4) + Random(9);
end;

function TUserCastle.GetMapName: string; //00490290
begin
  Result := m_sMapName;
end;

function TUserCastle.CheckInPalace(nX, nY: Integer; Cert: TBaseObject): Boolean; //490300
var
  ObjUnit: pTObjUnit;
begin
  Result := IsMasterGuild(TGUild(Cert.m_MyGuild));
  if Result then Exit;
  ObjUnit := @m_LeftWall;
  if (ObjUnit.BaseObject <> nil) and
    (ObjUnit.BaseObject.m_boDeath) and
    (ObjUnit.BaseObject.m_nCurrX = nX) and
    (ObjUnit.BaseObject.m_nCurrY = nY) then begin
    Result := True;
  end;
  ObjUnit := @m_CenterWall;
  if (ObjUnit.BaseObject <> nil) and
    (ObjUnit.BaseObject.m_boDeath) and
    (ObjUnit.BaseObject.m_nCurrX = nX) and
    (ObjUnit.BaseObject.m_nCurrY = nY) then begin
    Result := True;
  end;
  ObjUnit := @m_RightWall;
  if (ObjUnit.BaseObject <> nil) and
    (ObjUnit.BaseObject.m_boDeath) and
    (ObjUnit.BaseObject.m_nCurrX = nX) and
    (ObjUnit.BaseObject.m_nCurrY = nY) then begin
    Result := True;
  end;
end;
//ȡ��������
function TUserCastle.GetWarDate: string;
var
  AttackerInfo: pTAttackerInfo;
  Year: Word;
  Month: Word;
  Day: Word;
resourcestring
  sMsg = '%d��%d��%d��';
begin
  Result := '';
  if m_AttackWarList.Count <= 0 then Exit;
  AttackerInfo := m_AttackWarList.Items[0];
  DecodeDate(AttackerInfo.AttackDate, Year, Month, Day);
  Result := Format(sMsg, [Year, Month, Day]);
end;

function TUserCastle.GetAttackWarList: string;
var
  I, n10: Integer;
  AttackerInfo: pTAttackerInfo;
  Year, Month, Day: Word;
  wYear, wMonth, wDay: Word;
  s20: string;
begin
  Result := '';
  wYear := 0;
  wMonth := 0;
  wDay := 0;
  n10 := 0;
  if m_AttackWarList.Count > 0 then begin//20080630
    for I := 0 to m_AttackWarList.Count - 1 do begin
      AttackerInfo := m_AttackWarList.Items[I];
      DecodeDate(AttackerInfo.AttackDate, Year, Month, Day);
      if (Year <> wYear) or (Month <> wMonth) or (Day <> wDay) then begin
        wYear := Year;
        wMonth := Month;
        wDay := Day;
        if Result <> '' then
          Result := Result + '\';
        Result := Result + IntToStr(wYear) + '��' + IntToStr(wMonth) + '��' + IntToStr(wDay) + '��\';
        n10 := 0;
      end;
      if n10 > 40 then begin
        Result := Result + '\';
        n10 := 0;
      end;
      s20 := '"' + AttackerInfo.sGuildName + '"';
      Inc(n10, Length(s20));
      Result := Result + s20;
    end; // for
  end;
end;

procedure TUserCastle.IncRateGold(nGold: Integer); //004904C4
var
  nInGold: Integer;
begin
  nInGold := Round(nGold * (g_Config.nCastleTaxRate / 100) {0.05});
  if (m_nTodayIncome + nInGold) <= g_Config.nCastleOneDayGold then begin
    Inc(m_nTodayIncome, nInGold);
  end else begin
    if m_nTodayIncome >= g_Config.nCastleOneDayGold then begin
      nInGold := 0;
    end else begin
      nInGold := g_Config.nCastleOneDayGold - m_nTodayIncome;
      m_nTodayIncome := g_Config.nCastleOneDayGold;
    end;
  end;
  if nInGold > 0 then begin
    if (m_nTotalGold + nInGold) < g_Config.nCastleGoldMax then begin
      Inc(m_nTotalGold, nInGold);
    end else begin
      m_nTotalGold := g_Config.nCastleGoldMax;
    end;
  end;
  if (GetTickCount - m_dwSaveTick) > 600000{10 * 60 * 1000} then begin
    m_dwSaveTick := GetTickCount();
    if g_boGameLogGold then
      AddGameDataLog('23' + #9 +
        '0' + #9 +
        '0' + #9 +
        '0' + #9 +
        'autosave' + #9 +
        sSTRING_GOLDNAME + #9 +
        IntToStr(m_nTotalGold) + #9 +
        '1' + #9 +
        '0');
  end;
end;
//ȡ�ؽ��
function TUserCastle.WithDrawalGolds(PlayObject: TPlayObject; nGold: Integer): Integer; //0049066C
begin
  Result := -1;
  if nGold <= 0 then begin
    Result := -4;
    Exit;
  end;
  if (m_MasterGuild = PlayObject.m_MyGuild) and (PlayObject.m_nGuildRankNo = 1) and (nGold > 0) then begin
    if (nGold > 0) and (nGold <= m_nTotalGold) then begin
      if (PlayObject.m_nGold + nGold) <= PlayObject.m_nGoldMax then begin
        Dec(m_nTotalGold, nGold);
        PlayObject.IncGold(nGold);
        if g_boGameLogGold then
          AddGameDataLog('22' + #9 +
            PlayObject.m_sMapName + #9 +
            IntToStr(PlayObject.m_nCurrX) + #9 +
            IntToStr(PlayObject.m_nCurrY) + #9 +
            PlayObject.m_sCharName + #9 +
            sSTRING_GOLDNAME + #9 +
            IntToStr(nGold) + #9 +
            '1' + #9 +
            '0');
        PlayObject.GoldChanged;
        Result := 1;
      end else Result := -3;
    end else Result := -2;
  end;
end;
//ɳ�Ϳ˴��ʽ�
function TUserCastle.ReceiptGolds(PlayObject: TPlayObject; nGold: Integer): Integer; //00490864
begin
  Result := -1;
  if nGold <= 0 then begin
    Result := -4;
    Exit;
  end;
  if (m_MasterGuild = PlayObject.m_MyGuild) and (PlayObject.m_nGuildRankNo = 1) and (nGold > 0) then begin
    if (nGold <= PlayObject.m_nGold) then begin
      if (m_nTotalGold + nGold) <= g_Config.nCastleGoldMax then begin
        Dec(PlayObject.m_nGold, nGold);
        Inc(m_nTotalGold, nGold);
        if g_boGameLogGold then
          AddGameDataLog('23' + #9 +
            PlayObject.m_sMapName + #9 +
            IntToStr(PlayObject.m_nCurrX) + #9 +
            IntToStr(PlayObject.m_nCurrY) + #9 +
            PlayObject.m_sCharName + #9 +
            sSTRING_GOLDNAME + #9 +
            IntToStr(nGold) + #9 +
            '1' + #9 +
            '0');
        PlayObject.GoldChanged;
        Result := 1;
      end else Result := -3;
    end else Result := -2;
  end;
end;

procedure TUserCastle.MainDoorControl(boClose: Boolean); //00490460
begin
  if (m_MainDoor.BaseObject <> nil) and not m_MainDoor.BaseObject.m_boGhost then begin
    if boClose then begin
      if TCastleDoor(m_MainDoor.BaseObject).m_boOpened then TCastleDoor(m_MainDoor.BaseObject).Close;
    end else begin
      if not TCastleDoor(m_MainDoor.BaseObject).m_boOpened then TCastleDoor(m_MainDoor.BaseObject).Open;
    end;
  end;
end;
//�޸�����
function TUserCastle.RepairDoor(): Boolean; //00490A70
var
  CastleDoor: pTObjUnit;
begin
  Result := False;
  CastleDoor := @m_MainDoor;
  if (CastleDoor.BaseObject = nil) or (m_boUnderWar) or
    (CastleDoor.BaseObject.m_WAbil.HP >= CastleDoor.BaseObject.m_WAbil.MaxHP) then begin
    Exit;
  end;
  if not CastleDoor.BaseObject.m_boDeath then begin
    if (GetTickCount - CastleDoor.BaseObject.m_dwStruckTick) > 60000{60 * 1000} then begin
      CastleDoor.BaseObject.m_WAbil.HP := CastleDoor.BaseObject.m_WAbil.MaxHP;
      TCastleDoor(CastleDoor.BaseObject).RefStatus();
      Result := True;
    end;
  end else begin
    if (GetTickCount - CastleDoor.BaseObject.m_dwStruckTick) > 60000{60 * 1000} then begin
      CastleDoor.BaseObject.m_WAbil.HP := CastleDoor.BaseObject.m_WAbil.MaxHP;
      CastleDoor.BaseObject.m_boDeath := False;
      TCastleDoor(CastleDoor.BaseObject).m_boOpened := False;
      TCastleDoor(CastleDoor.BaseObject).RefStatus();
      Result := True;
    end;
  end;
end;
//�޸���ǽ
function TUserCastle.RepairWall(nWallIndex: Integer): Boolean; //00490B78
var
  Wall: TBaseObject;
begin
  Result := False;
  Wall := nil;
  case nWallIndex of
    1: Wall := m_LeftWall.BaseObject;//��
    2: Wall := m_CenterWall.BaseObject;//��
    3: Wall := m_RightWall.BaseObject;//��
  end;
  if (Wall = nil) or (m_boUnderWar) or (Wall.m_WAbil.HP >= Wall.m_WAbil.MaxHP) then begin
    Exit;
  end;
  if not Wall.m_boDeath then begin
    if (GetTickCount - Wall.m_dwStruckTick) > 60000{60 * 1000} then begin
      Wall.m_WAbil.HP := Wall.m_WAbil.MaxHP;
      TWallStructure(Wall).RefStatus();
      Result := True;
    end;
  end else begin
    if (GetTickCount - Wall.m_dwStruckTick) > 60000{60 * 1000} then begin
      Wall.m_WAbil.HP := Wall.m_WAbil.MaxHP;
      Wall.m_boDeath := False;
      TWallStructure(Wall).RefStatus();
      Result := True;
    end;
  end;
end;
//���ӹ����л���Ϣ
function TUserCastle.AddAttackerInfo(Guild: TGUild; nCode: Byte): Boolean; //00490CD8
var
  AttackerInfo: pTAttackerInfo;
begin
  Result := False;
  if InAttackerList(Guild) then Exit;
  New(AttackerInfo);
  if nCode = 0 then
    AttackerInfo.AttackDate := AddDateTimeOfDay(Now, g_Config.nStartCastleWarDays)
  else AttackerInfo.AttackDate := Now;//��ǰ
  AttackerInfo.sGuildName := Guild.sGuildName;
  AttackerInfo.Guild := Guild;
  m_AttackWarList.Add(AttackerInfo);
  SaveAttackSabukWall();
  UserEngine.SendServerGroupMsg(SS_212, nServerIndex, '');
  Result := True;
end;
//�ڹ����б���
function TUserCastle.InAttackerList(Guild: TGUild): Boolean; //00490C84
var
  I: Integer;
begin
  Result := False;
  if m_AttackWarList.Count > 0 then begin//20080630
    for I := 0 to m_AttackWarList.Count - 1 do begin
      if pTAttackerInfo(m_AttackWarList.Items[I]).Guild = Guild then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;
{δʹ�� 20080330
function TUserCastle.m_nChiefItemCount: Integer;
begin

end; }

procedure TUserCastle.SetPower(nPower: Integer);
begin
  m_nPower := nPower;
end;

procedure TUserCastle.SetTechLevel(nLevel: Integer);
begin
  m_nTechLevel := nLevel;
end;

{ TCastleManager }



constructor TCastleManager.Create;
begin
  m_CastleList := TList.Create;
  InitializeCriticalSection(CriticalSection);
end;


destructor TCastleManager.Destroy;
var
  I: Integer;
  UserCastle: TUserCastle;
begin
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      UserCastle := TUserCastle(m_CastleList.Items[I]);
      UserCastle.Save;
      UserCastle.Free;
    end;
  end;
  m_CastleList.Free;
  DeleteCriticalSection(CriticalSection);
  inherited;
end;


function TCastleManager.Find(sCASTLENAME: string): TUserCastle;
var
  I: Integer;
  Castle: TUserCastle;
begin
  Result := nil;
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      Castle := TUserCastle(m_CastleList.Items[I]);
      if CompareText(Castle.m_sName, sCASTLENAME) = 0 then begin
        Result := Castle;
        Break;
      end;
    end;
  end;
end;

//ȡ�ý�ɫ��������ĳǱ�
function TCastleManager.InCastleWarArea(BaseObject: TBaseObject): TUserCastle;
var
  I: Integer;
  Castle: TUserCastle;
begin
  Result := nil;
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      Castle := TUserCastle(m_CastleList.Items[I]);
      if Castle.InCastleWarArea(BaseObject.m_PEnvir, BaseObject.m_nCurrX, BaseObject.m_nCurrY) then begin
        Result := Castle;
        Break;
      end;
    end;
  end;
end;

function TCastleManager.InCastleWarArea(Envir: TEnvirnoment; nX,
  nY: Integer): TUserCastle;
var
  I: Integer;
  Castle: TUserCastle;
begin
  Result := nil;
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      Castle := TUserCastle(m_CastleList.Items[I]);
      if Castle.InCastleWarArea(Envir, nX, nY) then begin
        Result := Castle;
        Break;
      end;
    end;
  end;
end;

procedure TCastleManager.Initialize;
var
  I: Integer;
  Castle: TUserCastle;
begin
  if m_CastleList.Count <= 0 then begin
    Castle := TUserCastle.Create(g_Config.sCastleDir);
    m_CastleList.Add(Castle);
    Castle.Initialize;
    Castle.m_sConfigDir := '0';
    Castle.m_EnvirList.Add('0151');
    Castle.m_EnvirList.Add('0152');
    Castle.m_EnvirList.Add('0153');
    Castle.m_EnvirList.Add('0154');
    Castle.m_EnvirList.Add('0155');
    Castle.m_EnvirList.Add('0156');
    if Castle.m_EnvirList.Count > 0 then begin//20080630
      for I := 0 to Castle.m_EnvirList.Count - 1 do begin
        Castle.m_EnvirList.Objects[I] := g_MapManager.FindMap(Castle.m_EnvirList.Strings[I]);
      end;
    end;
    Save();
    Exit;
  end;

  for I := 0 to m_CastleList.Count - 1 do begin
    Castle := TUserCastle(m_CastleList.Items[I]);
    Castle.Initialize;
  end;
end;

//����������� 20081013
procedure TCastleManager.ReLoadCastle();
var
  I, K: Integer;
  Castle: TUserCastle;
  ObjUnit: pTObjUnit;
  Door: pTDoorInfo;
  boUnderWar: Boolean;//20081019
begin
  g_Config.sGuildNotice := StringConf.ReadString('Guild', 'GuildNotice', g_Config.sGuildNotice);
  g_Config.sGuildWar := StringConf.ReadString('Guild', 'GuildWar', g_Config.sGuildWar);
  g_Config.sGuildAll := StringConf.ReadString('Guild', 'GuildAll', g_Config.sGuildAll);
  g_Config.sGuildMember := StringConf.ReadString('Guild', 'GuildMember', g_Config.sGuildMember);
  g_Config.sGuildMemberRank := StringConf.ReadString('Guild', 'GuildMemberRank', g_Config.sGuildMemberRank);
  g_Config.sGuildChief := StringConf.ReadString('Guild', 'GuildChief', g_Config.sGuildChief);

  if m_CastleList.Count <= 0 then begin
    Castle := TUserCastle.Create(g_Config.sCastleDir);
    m_CastleList.Add(Castle);
    Castle.Initialize;
    Castle.m_sConfigDir := '0';
    Castle.m_EnvirList.Add('0151');
    Castle.m_EnvirList.Add('0152');
    Castle.m_EnvirList.Add('0153');
    Castle.m_EnvirList.Add('0154');
    Castle.m_EnvirList.Add('0155');
    Castle.m_EnvirList.Add('0156');
    if Castle.m_EnvirList.Count > 0 then begin//20080630
      for I := 0 to Castle.m_EnvirList.Count - 1 do begin
        Castle.m_EnvirList.Objects[I] := g_MapManager.FindMap(Castle.m_EnvirList.Strings[I]);
      end;
    end;
    Save();
    Exit;
  end;

  for I := 0 to m_CastleList.Count - 1 do begin
    Castle := TUserCastle(m_CastleList.Items[I]);
    with Castle do begin
      boUnderWar:= m_boUnderWar;//20081019
      m_boUnderWar:= False;//20081126 �ȳ�ʼ״̬
      LoadConfig(True);
      LoadAttackSabukWall();
      if g_MapManager.GetMapOfServerIndex(m_sMapName) = nServerIndex then begin
        m_MapPalace := g_MapManager.FindMap(Castle.m_sPalaceMap);
        if m_MapPalace = nil then begin
          MainOutMessage(Format('�ʹ���ͼ%sû�ҵ�������', [m_sPalaceMap]));
        end;
        m_MapSecret := g_MapManager.FindMap(m_sSecretMap);
        if Castle.m_MapSecret = nil then begin
          MainOutMessage(Format('�ܵ���ͼ%sû�ҵ�������', [m_sSecretMap]));
        end;
        m_MapCastle := g_MapManager.FindMap(m_sMapName);
        if m_MapCastle <> nil then begin
          if m_MainDoor.BaseObject <> nil then begin
            if (not m_MainDoor.BaseObject.m_boGhost) and (not m_MainDoor.BaseObject.m_boDeath)
              and (not m_MainDoor.BaseObject.m_boFixedHideMode) and (CompareText(m_MainDoor.BaseObject.m_sCharName, m_MainDoor.sName) = 0) then begin//20081126
              if m_MainDoor.BaseObject.m_WAbil.HP <= 0 then m_MainDoor.BaseObject.ReAlive;
              m_MainDoor.BaseObject.m_WAbil.HP := m_MainDoor.nHP;
              m_MainDoor.BaseObject.SendRefMsg(RM_HEALTHSPELLCHANGED, 0, 0, 0, 0, '');
              m_MainDoor.BaseObject.m_Castle := Castle;
            end else begin
              if m_MainDoor.BaseObject <> nil then begin
                if (CompareText(m_MainDoor.BaseObject.m_sCharName, m_MainDoor.sName) = 0) then begin
                  if not m_MainDoor.BaseObject.m_boDeath then begin
                    m_MainDoor.BaseObject.m_WAbil.HP := m_MainDoor.BaseObject.m_WAbil.MaxHP;
                    TCastleDoor(m_MainDoor.BaseObject).RefStatus();
                    MainOutMessage('[�Ǳ�����A-1] ' + m_MainDoor.BaseObject.m_sCharName);
                  end else begin
                    m_MainDoor.BaseObject.m_WAbil.HP := m_MainDoor.BaseObject.m_WAbil.MaxHP;
                    TCastleDoor(m_MainDoor.BaseObject).m_boOpened := boUnderWar;//�����Ƿ�ر�
                    m_MainDoor.BaseObject.ReAlive;//20081202
                    MainOutMessage('[�Ǳ�����A-2] ' + m_MainDoor.BaseObject.m_sCharName);
                  end;
                end else begin
                  m_MainDoor.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_MainDoor.nX, m_MainDoor.nY, m_MainDoor.sName);
                  if m_MainDoor.BaseObject <> nil then begin
                    m_MainDoor.BaseObject.m_WAbil.HP := m_MainDoor.nHP;
                    m_MainDoor.BaseObject.m_Castle := Castle;
                    m_MainDoor.BaseObject.m_nCurrX := m_MainDoor.nX;
                    m_MainDoor.BaseObject.m_nCurrY := m_MainDoor.nY;
                    MainOutMessage('[�Ǳ�����A-3] ' + m_MainDoor.BaseObject.m_sCharName);
                  end else begin              
                    MainOutMessage('[������Ϣ] �Ǳ���ʼ������ʧ�ܣ����������ݿ�����û���ŵ�����: ' + m_MainDoor.sName);
                  end;
                end;
              end else begin
                m_MainDoor.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_MainDoor.nX, m_MainDoor.nY, m_MainDoor.sName);
                if m_MainDoor.BaseObject <> nil then begin
                  m_MainDoor.BaseObject.m_WAbil.HP := m_MainDoor.nHP;
                  m_MainDoor.BaseObject.m_Castle := Castle;
                end else begin
                  MainOutMessage('[������Ϣ] �Ǳ���ʼ������ʧ�ܣ����������ݿ�����û���ŵ�����: ' + m_MainDoor.sName);
                end;
              end;
            end;
            if m_MainDoor.nStatus and (m_MainDoor.BaseObject <> nil) then TCastleDoor(m_MainDoor.BaseObject).Open;
          end else begin
            MainOutMessage('[������Ϣ] �Ǳ���ʼ������ʧ�ܣ����������ݿ�����û���ŵ�����: ' + m_MainDoor.sName);
          end;

          if m_LeftWall.BaseObject <> nil then begin
            if (not m_LeftWall.BaseObject.m_boGhost) and (not m_LeftWall.BaseObject.m_boDeath)
              and (not m_LeftWall.BaseObject.m_boFixedHideMode) and (CompareText(m_LeftWall.BaseObject.m_sCharName, m_LeftWall.sName) = 0) then begin//20081126
              if m_LeftWall.BaseObject.m_WAbil.HP <= 0 then m_LeftWall.BaseObject.ReAlive;
              m_LeftWall.BaseObject.m_WAbil.HP := m_LeftWall.nHP;
              m_LeftWall.BaseObject.SendRefMsg(RM_HEALTHSPELLCHANGED, 0, 0, 0, 0, '');
              m_LeftWall.BaseObject.m_Castle := Castle;
            end else begin
              if m_LeftWall.BaseObject <> nil then begin
                if (CompareText(m_LeftWall.BaseObject.m_sCharName, m_LeftWall.sName) = 0) then begin
                  if not m_LeftWall.BaseObject.m_boDeath then begin
                    m_LeftWall.BaseObject.m_WAbil.HP := m_LeftWall.BaseObject.m_WAbil.MaxHP;
                    TWallStructure(m_LeftWall.BaseObject).RefStatus();
                    MainOutMessage('[�Ǳ�����B-1] ' + m_LeftWall.BaseObject.m_sCharName);
                  end else begin
                    m_LeftWall.BaseObject.m_WAbil.HP := m_LeftWall.BaseObject.m_WAbil.MaxHP;
                    m_LeftWall.BaseObject.ReAlive;//20081202
                    MainOutMessage('[�Ǳ�����B-2] ' + m_LeftWall.BaseObject.m_sCharName);
                  end;
                end else begin
                  m_LeftWall.BaseObject:= UserEngine.RegenMonsterByName(m_sMapName, m_LeftWall.nX, m_LeftWall.nY, m_LeftWall.sName);
                  if m_LeftWall.BaseObject <> nil then begin
                    m_LeftWall.BaseObject.m_WAbil.HP := m_LeftWall.nHP;
                    m_LeftWall.BaseObject.m_Castle := Castle;
                    m_LeftWall.BaseObject.m_nCurrX := m_LeftWall.nX;
                    m_LeftWall.BaseObject.m_nCurrY := m_LeftWall.nY;
                    MainOutMessage('[�Ǳ�����B-3] ' + m_LeftWall.BaseObject.m_sCharName);
                  end else begin
                    MainOutMessage('[������Ϣ] �Ǳ���ʼ�����ǽʧ�ܣ����������ݿ�����û���ǽ������: ' + m_LeftWall.sName);
                  end;
                end;
              end else begin
                m_LeftWall.BaseObject:= UserEngine.RegenMonsterByName(m_sMapName, m_LeftWall.nX, m_LeftWall.nY, m_LeftWall.sName);
                if m_LeftWall.BaseObject <> nil then begin
                  m_LeftWall.BaseObject.m_WAbil.HP := m_LeftWall.nHP;
                  m_LeftWall.BaseObject.m_Castle := Castle;
                end else begin
                  MainOutMessage('[������Ϣ] �Ǳ���ʼ�����ǽʧ�ܣ����������ݿ�����û���ǽ������: ' + m_LeftWall.sName);
                end;
              end;
            end;
          end else begin
            MainOutMessage('[������Ϣ] �Ǳ��������ǽʧ�ܣ����������ݿ�����û���ǽ������: ' + m_LeftWall.sName);
          end;

          if m_CenterWall.BaseObject <> nil then begin
            if (not m_CenterWall.BaseObject.m_boGhost) and (not m_CenterWall.BaseObject.m_boDeath)
              and (not m_CenterWall.BaseObject.m_boFixedHideMode) and (CompareText(m_CenterWall.BaseObject.m_sCharName, m_CenterWall.sName) = 0) then begin//20081126
              if m_CenterWall.BaseObject.m_WAbil.HP <= 0 then m_CenterWall.BaseObject.ReAlive;
              m_CenterWall.BaseObject.m_WAbil.HP := m_CenterWall.nHP;
              m_CenterWall.BaseObject.SendRefMsg(RM_HEALTHSPELLCHANGED, 0, 0, 0, 0, '');
              m_CenterWall.BaseObject.m_Castle := Castle;
            end else begin
              if m_CenterWall.BaseObject <> nil then begin
                if (CompareText(m_CenterWall.BaseObject.m_sCharName, m_CenterWall.sName) = 0) then begin
                  if not m_CenterWall.BaseObject.m_boDeath then begin
                    m_CenterWall.BaseObject.m_WAbil.HP := m_CenterWall.BaseObject.m_WAbil.MaxHP;
                    TWallStructure(m_CenterWall.BaseObject).RefStatus();
                    MainOutMessage('[�Ǳ�����C-1] ' + m_CenterWall.BaseObject.m_sCharName);
                  end else begin
                    m_CenterWall.BaseObject.m_WAbil.HP := m_CenterWall.BaseObject.m_WAbil.MaxHP;
                    m_CenterWall.BaseObject.ReAlive;//20081202
                    MainOutMessage('[�Ǳ�����C-2] ' + m_CenterWall.BaseObject.m_sCharName);
                  end;
                end else begin
                  m_CenterWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_CenterWall.nX, m_CenterWall.nY, m_CenterWall.sName);
                  if m_CenterWall.BaseObject <> nil then begin
                    m_CenterWall.BaseObject.m_WAbil.HP := m_CenterWall.nHP;
                    m_CenterWall.BaseObject.m_Castle := Castle;
                    m_CenterWall.BaseObject.m_nCurrX := m_CenterWall.nX;
                    m_CenterWall.BaseObject.m_nCurrY := m_CenterWall.nY;
                    MainOutMessage('[�Ǳ�����C-3] ' + m_CenterWall.BaseObject.m_sCharName);
                  end else begin
                    MainOutMessage('[������Ϣ] �Ǳ���ʼ���г�ǽʧ�ܣ����������ݿ�����û�г�ǽ������: ' + m_CenterWall.sName);
                  end;
                end;
              end else begin
                m_CenterWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_CenterWall.nX, m_CenterWall.nY, m_CenterWall.sName);
                if m_CenterWall.BaseObject <> nil then begin
                  m_CenterWall.BaseObject.m_WAbil.HP := m_CenterWall.nHP;
                  m_CenterWall.BaseObject.m_Castle := Castle;
                end else begin
                  MainOutMessage('[������Ϣ] �Ǳ���ʼ���г�ǽʧ�ܣ����������ݿ�����û�г�ǽ������: ' + m_CenterWall.sName);
                end;
              end;
            end;
          end else begin
            MainOutMessage('[������Ϣ] �Ǳ���ʼ���г�ǽʧ�ܣ����������ݿ�����û�г�ǽ������: ' + m_CenterWall.sName);
          end;

          if m_RightWall.BaseObject <> nil then begin
            if (not m_RightWall.BaseObject.m_boGhost) and (not m_RightWall.BaseObject.m_boDeath)
              and (not m_RightWall.BaseObject.m_boFixedHideMode) and (CompareText(m_RightWall.BaseObject.m_sCharName, m_RightWall.sName) = 0) then begin//20081126
              if m_RightWall.BaseObject.m_WAbil.HP <= 0 then m_RightWall.BaseObject.ReAlive;
              m_RightWall.BaseObject.m_WAbil.HP := m_RightWall.nHP;
              m_RightWall.BaseObject.SendRefMsg(RM_HEALTHSPELLCHANGED, 0, 0, 0, 0, '');
              m_RightWall.BaseObject.m_Castle := Castle;
            end else begin
              if m_RightWall.BaseObject <> nil then begin
                if (CompareText(m_RightWall.BaseObject.m_sCharName, m_RightWall.sName) = 0) then begin
                  if not m_RightWall.BaseObject.m_boDeath then begin
                    m_RightWall.BaseObject.m_WAbil.HP := m_RightWall.BaseObject.m_WAbil.MaxHP;
                    TWallStructure(m_RightWall.BaseObject).RefStatus();
                    MainOutMessage('[�Ǳ�����D-1] ' + m_RightWall.BaseObject.m_sCharName);
                  end else begin
                    m_RightWall.BaseObject.m_WAbil.HP := m_RightWall.BaseObject.m_WAbil.MaxHP;
                    m_RightWall.BaseObject.ReAlive;//20081202
                    MainOutMessage('[�Ǳ�����D-2] ' + m_RightWall.BaseObject.m_sCharName);
                  end;
                end else begin
                  m_RightWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_RightWall.nX, m_RightWall.nY, m_RightWall.sName);
                  if m_RightWall.BaseObject <> nil then begin
                    m_RightWall.BaseObject.m_WAbil.HP := m_RightWall.nHP;
                    m_RightWall.BaseObject.m_Castle := Castle;
                    m_RightWall.BaseObject.m_nCurrX := m_RightWall.nX;
                    m_RightWall.BaseObject.m_nCurrY := m_RightWall.nY;
                    MainOutMessage('[�Ǳ�����D-3] ' + m_RightWall.BaseObject.m_sCharName);
                  end else begin
                    MainOutMessage('[������Ϣ] �Ǳ���ʼ���ҳ�ǽʧ�ܣ����������ݿ�����û�ҳ�ǽ������: ' + m_RightWall.sName);
                  end;
                end;
              end else begin
                m_RightWall.BaseObject := UserEngine.RegenMonsterByName(m_sMapName, m_RightWall.nX, m_RightWall.nY, m_RightWall.sName);
                if m_RightWall.BaseObject <> nil then begin
                  m_RightWall.BaseObject.m_WAbil.HP := m_RightWall.nHP;
                  m_RightWall.BaseObject.m_Castle := Castle;
                end else begin
                  MainOutMessage('[������Ϣ] �Ǳ���ʼ���ҳ�ǽʧ�ܣ����������ݿ�����û�ҳ�ǽ������: ' + m_RightWall.sName);
                end;
              end;
            end;
          end else begin
            MainOutMessage('[������Ϣ] �Ǳ���ʼ���ҳ�ǽʧ�ܣ����������ݿ�����û�ҳ�ǽ������: ' + m_RightWall.sName);
          end;

          for K := Low(m_Archer) to High(m_Archer) do begin
            ObjUnit := @m_Archer[K];
            if ObjUnit.nHP <= 0 then Continue;
            if ObjUnit.BaseObject <> nil then begin
              ObjUnit.BaseObject.m_WAbil.HP := m_Archer[K].nHP;
              ObjUnit.BaseObject.m_Castle := Castle;
              TGuardUnit(ObjUnit.BaseObject).m_nX550 := ObjUnit.nX;
              TGuardUnit(ObjUnit.BaseObject).m_nY554 := ObjUnit.nY;
              TGuardUnit(ObjUnit.BaseObject).m_nDirection := 3;
            end else begin
              MainOutMessage('[������Ϣ] �Ǳ���ʼ��������ʧ�ܣ����������ݿ�����û�����ֵ�����: ' + ObjUnit.sName);
            end;
          end;
          for K := Low(m_Guard) to High(m_Guard) do begin
            ObjUnit := @m_Guard[K];
            if ObjUnit.nHP <= 0 then Continue;
            if ObjUnit.BaseObject <> nil then begin
              ObjUnit.BaseObject.m_WAbil.HP := m_Guard[K].nHP;
            end else begin
              MainOutMessage('[������Ϣ] �Ǳ���ʼ������ʧ��(���������ݿ�����û��������)');
            end;
          end;
          if m_MapCastle.m_DoorList.Count > 0 then begin
            for K := 0 to m_MapCastle.m_DoorList.Count - 1 do begin
              Door := m_MapCastle.m_DoorList.Items[K];
              if (abs(Door.nX - m_nPalaceDoorX {631}) <= 3) and (abs(Door.nY - m_nPalaceDoorY {274}) <= 3) then begin
                m_DoorStatus := Door.Status;
              end;
            end;
          end;
        end else begin
          MainOutMessage(Format('[������Ϣ] �Ǳ����ڵ�ͼ������(����ͼ�����ļ����Ƿ��е�ͼ%s������)', [m_sMapName]));
        end;        
      end;
      m_boUnderWar:= boUnderWar;//20081019
      if m_boUnderWar and TCastleDoor(m_MainDoor.BaseObject).m_boOpened then TCastleDoor(m_MainDoor.BaseObject).Close;//20081202 �رճ���
    end;//with
  end;
end;

//�Ǳ��ʹ����ڵ�ͼ
function TCastleManager.IsCastlePalaceEnvir(Envir: TEnvirnoment): TUserCastle;
var
  I: Integer;
  Castle: TUserCastle;
begin
  Result := nil;
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      Castle := TUserCastle(m_CastleList.Items[I]);
      if Castle.m_MapPalace = Envir then begin
        Result := Castle;
        Break;
      end;
    end;
  end;
end;
//�Ǳ����ڵ�ͼ
function TCastleManager.IsCastleEnvir(Envir: TEnvirnoment): TUserCastle;
var
  I: Integer;
  Castle: TUserCastle;
begin
  Result := nil;
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      Castle := TUserCastle(m_CastleList.Items[I]);
      if Castle.m_MapCastle = Envir then begin
        Result := Castle;
        Break;
      end;
    end;
  end;
end;
//�ǳǱ���Ա
function TCastleManager.IsCastleMember(BaseObject: TBaseObject): TUserCastle;
var
  I: Integer;
  Castle: TUserCastle;
begin
  Result := nil;
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      Castle := TUserCastle(m_CastleList.Items[I]);
      if Castle.IsMember(BaseObject) then begin
        Result := Castle;
        Break;
      end;
    end;
  end;
end;

procedure TCastleManager.Run;
var
  I: Integer;
  UserCastle: TUserCastle;
begin
  Lock;
  try
    Try
      if m_CastleList.Count > 0 then begin//20080630
        for I := 0 to m_CastleList.Count - 1 do begin
          UserCastle := TUserCastle(m_CastleList.Items[I]);
          UserCastle.Run;
        end;
      end;
    except
      MainOutMessage('{�쳣} TCastleManager.Run');
    end;
  finally
    UnLock;
  end;
end;

procedure TCastleManager.GetCastleGoldInfo(List: TStringList);
var
  I: Integer;
  Castle: TUserCastle;
begin
  if  m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      Castle := TUserCastle(m_CastleList.Items[I]);
      List.Add(Format(g_sGameCommandSbkGoldShowMsg, [Castle.m_sName, Castle.m_nTotalGold, Castle.m_nTodayIncome]));
    end;
  end;
end;

procedure TCastleManager.Save;
var
  I: Integer;
 //Castle: TUserCastle;
begin
  SaveCastleList();
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      //Castle := TUserCastle(m_CastleList.Items[I]);
      //Castle.Save;
      TUserCastle(m_CastleList.Items[I]).Save;
    end;
  end;
end;

procedure TCastleManager.LoadCastleList;
var
  LoadList: TStringList;
  Castle: TUserCastle;
  sCastleDir: string;
  I: Integer;
begin
  if FileExists(g_Config.sCastleFile) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(g_Config.sCastleFile);
    if LoadList.Count > 0 then begin//20080630
      for I := 0 to LoadList.Count - 1 do begin
        sCastleDir := Trim(LoadList.Strings[I]);
        if sCastleDir <> '' then begin
          Castle := TUserCastle.Create(sCastleDir);
          m_CastleList.Add(Castle);
        end;
      end;
    end;
    LoadList.Free;
    MainOutMessage('�Ѷ�ȡ ' + IntToStr(m_CastleList.Count) + '���Ǳ���Ϣ...');
  end else begin
    MainOutMessage('�Ǳ��б��ļ�δ�ҵ�������');
  end;
end;

procedure TCastleManager.SaveCastleList;
var
  I: Integer;
  LoadList: TStringList;
begin
  Try
    if not DirectoryExists(g_Config.sCastleDir) then CreateDir(g_Config.sCastleDir);

    if m_CastleList.Count > 0 then begin//20080630
      LoadList := TStringList.Create;
      for I := 0 to m_CastleList.Count - 1 do begin
        LoadList.Add(IntToStr(I));
      end;
      LoadList.SaveToFile(g_Config.sCastleFile);
      LoadList.Free;
    end;
  except
    MainOutMessage('{�쳣} CastleManager.SaveCastleList...'+ g_Config.sCastleFile);
  end;
end;

function TCastleManager.GetCastle(nIndex: Integer): TUserCastle;
begin
  Result := nil;
  if (nIndex >= 0) and (nIndex < m_CastleList.Count) then
    Result := TUserCastle(m_CastleList.Items[nIndex]);
end;

procedure TCastleManager.GetCastleNameList(List: TStringList);
var
  I: Integer;
  Castle: TUserCastle;
begin
  if m_CastleList.Count > 0 then begin//20080630
    for I := 0 to m_CastleList.Count - 1 do begin
      Castle := TUserCastle(m_CastleList.Items[I]);
      List.Add(Castle.m_sName);
    end;
  end;
end;

procedure TCastleManager.IncRateGold(nGold: Integer);
var
  I: Integer;
  Castle: TUserCastle;
begin
  Lock;
  try
    if  m_CastleList.Count > 0 then begin//20080630
      for I := 0 to m_CastleList.Count - 1 do begin
        Castle := TUserCastle(m_CastleList.Items[I]);
        Castle.IncRateGold(nGold);
      end;
    end;
  finally
    UnLock;
  end;
end;

procedure TCastleManager.Lock;
begin
  EnterCriticalSection(CriticalSection);
end;

procedure TCastleManager.UnLock;
begin
  LeaveCriticalSection(CriticalSection);
end;

end.
