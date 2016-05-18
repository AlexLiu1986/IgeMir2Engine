unit Work;

interface
uses Classes, SysUtils, Forms, Windows, Share, HumDB;

type
  TMainWorkThread = class (TThread)
    m_nTotalPostion   : Integer;
    m_nCurPostion     : Integer;
    m_sMainRoot       : string;//�ļ�·��
  private
    f_MainMirH        : THandle;
    f_MainHumH        : THandle;
    function  GetFileSize(const sFile: string; const OffSet: Integer; const DefSize: Integer): Integer;
    function  GetMaxWorkCount : Integer;//ȡ���Ĺ�������
    procedure MakeInOne(); //�ϲ�����
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSupsbended: Boolean = True);reintroduce;
    destructor  Destroy;override;
  end;

var
  MainWorkThread    : TMainWorkThread;

implementation
uses Main;
{ TMainWorkThread }

constructor TMainWorkThread.Create(CreateSupsbended: Boolean);
begin
  inherited Create(CreateSupsbended);
  m_nTotalPostion := 0;
  m_nCurPostion   := 0;
  f_MainMirH      := 0;
  f_MainHumH      := 0;
end;

destructor TMainWorkThread.Destroy;
begin
  inherited Destroy;
end;

procedure TMainWorkThread.Execute;
begin
  inherited;
  FrmMain.RzProgressBar1.TotalParts := GetMaxWorkCount;
  m_nTotalPostion := 0;
  //�ϲ�
  MakeInOne();
  Application.MessageBox('ת����ɣ�', '��ʾ', MB_OK + MB_ICONINFORMATION);
  FrmMain.ComboBox1.Enabled := True;
  FrmMain.RzButton1.Enabled := True;
end;

function TMainWorkThread.GetFileSize(const sFile: string; const OffSet,
  DefSize: Integer): Integer;
var
  Sc: TSearchRec;
begin
  if FindFirst(sFile, faAnyFile, Sc) = 0 then
    Result  := (Sc.Size - OffSet) div DefSize
    else Result  := 0;
  if Result < 0 then Result  := 0;
end;

{procedure Log(s, Name: string);stdcall;
var
  F : TextFile;
begin
  assignfile(f, PChar(ExtractFilePath(Paramstr(0))+ Name +'.txt'));
  if fileexists(PChar(ExtractFilePath(Paramstr(0))+ Name +'.txt')) then append(f)
  else rewrite(f);
  writeln(f,s);
  closefile(f);
end;}

procedure TMainWorkThread.MakeInOne;
var
  IDCount3:integer;
  m_Header2: TDBHeader1; //�������ݿ�ͷ
  f_HumH, f_MirH: THandle;
  DBHum: TLF_DBHum;
  NewDBHum: TDBHum;
  HumData:TLF_HumDataInfo;
  NewHumData:THumDataInfo;
  I, J, K: Integer;
  boMirOK: Boolean;
begin
  IDCount3:=0;//20080302
  if f_MainMirH = 0 then
    f_MainMirH  := FileCreate(Self.m_sMainRoot + '\DBServer\FDB\Mir.db', fmOpenReadWrite or fmShareDenyNone);

  if f_MainHumH = 0 then
    f_MainHumH  := FileCreate(Self.m_sMainRoot + '\DBServer\FDB\Hum.db', fmOpenReadWrite or fmShareDenyNone);

  f_HumH  := FileOpen(FrmMain.RzButtonEdit1.Text+'\Hum.DB', 0);
  f_MirH  := FileOpen(FrmMain.RzButtonEdit1.Text+'\Mir.DB', 0);

////////////////////////////////////////////////////////////////
  FileSeek(f_MainMirH, 0, 0);
  FileSeek(f_MainHumH, 0, 0);

  if FileRead(f_MainMirH, m_Header2, SizeOf(TDBHeader1)) = SizeOf(TDBHeader1) then
    IDCount3 := m_Header2.nHumCount;
//////////////////////////////////////////////////////////////////
  FileSeek(f_HumH, Sizeof(TDBHeader1), 0);//0---���ļ�ͷ��ʼ��λ
  m_nCurPostion := 0;
  while FileRead(f_HumH, DBHum, Sizeof(DBHum)) = Sizeof(DBHum) do begin //T ѭ��������������
    try
      if HumDataDB.OpenEx then begin
        J := HumDataDB.Index(DBHum.sChrName);
        if J >= 0 then begin
          if HumDataDB.Get(J, HumData) >= 0 then begin
            HumDataDB.m_QuickList.Delete(J);//���ҵ���,ɾ����Ӧ������,������ٶ� 20081018
          end;
        end else begin
          Inc(m_nCurPostion);
          Continue;
        end;
      end;
    finally
      HumDataDB.Close;
    end;
{20071119����,�ȸ�������ͷ,��д������}
    Inc(IDCount3);
      
    FileSeek(f_MainMirH, 0, 0);
    m_Header2.sDesc:=DBFileDesc;
    m_Header2.nHumCount:=IDCount3;
    FileWrite(f_MainMirH, m_Header2, SizeOf(TDBHeader1));
    FileSeek(f_MainMirH, 0, 2);//2---���ļ�β����λ

    FileSeek(f_MainHumH, 0, 0);
    FileWrite(f_MainHumH, m_Header2, SizeOf(TDBHeader1));

    FillChar(NewHumData, SizeOf(THumDataInfo), #0);
    FillChar(NewDBHum, SizeOf(TDBHum), #0);

    NewHumData.Header.boDeleted := HumData.Header.boDeleted;
    NewHumData.Header.nSelectID := HumData.Header.nSelectID;
    if HumData.Data.sMasterHeroName <> '' then begin
      NewHumData.Data.boIsHero:= True;
      NewHumData.Header.boIsHero := True;
    end else begin
      NewHumData.Data.boIsHero:= False;
      NewHumData.Header.boIsHero := False;
    end;

    NewHumData.Header.bt2 := HumData.Header.bt2;
    NewHumData.Header.dCreateDate := HumData.Header.UpdateDate;
    NewHumData.Header.sName := HumData.Header.sName;

    NewHumData.Data.sChrName:=HumData.Data.sChrName;
    NewHumData.Data.sCurMap:=HumData.Data.sCurMap;
    NewHumData.Data.wCurX:=HumData.Data.wCurX;
    NewHumData.Data.wCurY:=HumData.Data.wCurY;
    NewHumData.Data.btDir:=HumData.Data.btDir;
    NewHumData.Data.btHair:=HumData.Data.btHair;
    NewHumData.Data.btSex:=HumData.Data.btSex;
    NewHumData.Data.btJob:=HumData.Data.btJob;
    NewHumData.Data.nGold:=HumData.Data.nGold;

    NewHumData.Data.Abil.Level:=HumData.Data.Abil.Level;
    NewHumData.Data.Abil.AC:=HumData.Data.Abil.AC;
    NewHumData.Data.Abil.MAC:=HumData.Data.Abil.MAC;
    NewHumData.Data.Abil.DC:=HumData.Data.Abil.DC;
    NewHumData.Data.Abil.MC:=HumData.Data.Abil.MC;
    NewHumData.Data.Abil.SC:=HumData.Data.Abil.SC;
    NewHumData.Data.Abil.HP:=HumData.Data.Abil.HP;
    NewHumData.Data.Abil.MP:=HumData.Data.Abil.MP;
    NewHumData.Data.Abil.MaxHP:=HumData.Data.Abil.MaxHP;
    NewHumData.Data.Abil.MaxMP:=HumData.Data.Abil.MaxMP;
    NewHumData.Data.Abil.NG:= 0;
    NewHumData.Data.Abil.MaxNG:=0;
    NewHumData.Data.Abil.Exp:=HumData.Data.Abil.Exp;
    NewHumData.Data.Abil.MaxExp:=HumData.Data.Abil.MaxExp;
    NewHumData.Data.Abil.Weight:=HumData.Data.Abil.Weight;
    NewHumData.Data.Abil.MaxWeight:=HumData.Data.Abil.MaxWeight; //����
    NewHumData.Data.Abil.WearWeight:=HumData.Data.Abil.WearWeight;
    NewHumData.Data.Abil.MaxWearWeight:=HumData.Data.Abil.MaxWearWeight; //����
    NewHumData.Data.Abil.HandWeight:=HumData.Data.Abil.HandWeight;
    NewHumData.Data.Abil.MaxHandWeight:=HumData.Data.Abil.MaxHandWeight; //����

    //NewHumData.Data.wStatusTimeArr:=HumData.Data.wStatusTimeArr;//״̬
    //NewHumData.Data.btUnKnow1:=HumData.Data.UnKnow8;

    NewHumData.Data.sHomeMap:=HumData.Data.sHomeMap;
    NewHumData.Data.wHomeX:=HumData.Data.wHomeX;
    NewHumData.Data.wHomeY:=HumData.Data.wHomeY;
    NewHumData.Data.sDearName:=HumData.Data.sDearName;
    NewHumData.Data.sMasterName:=HumData.Data.sMasterName;
    NewHumData.Data.boMaster:=HumData.Data.boMaster;
    NewHumData.Data.btCreditPoint:=HumData.Data.btCreditPoint;
    if NewHumData.Data.sDearName <> '' then NewHumData.Data.btDivorce:=1//�Ƿ���
    else NewHumData.Data.btDivorce:=0;//�Ƿ���
      
    NewHumData.Data.btMarryCount:=0;//������
    NewHumData.Data.sStoragePwd:=HumData.Data.sStoragePwd;
    NewHumData.Data.btReLevel:=HumData.Data.btReLevel;
    NewHumData.Data.btUnKnow2[0]:=0;//�Ƿ�ͨԪ������ 20080316
    NewHumData.Data.btUnKnow2[1]:=0;//�Ƿ�Ĵ�Ӣ��(1-����Ӣ��)
    NewHumData.Data.btUnKnow2[2]:=0;//����ʱ�Ƶ�Ʒ��
    NewHumData.Data.BonusAbil:=HumData.Data.BonusAbil;
    NewHumData.Data.nBonusPoint:=HumData.Data.nBonusPoint;
    NewHumData.Data.nGameGold:=HumData.Data.nGameGold;
    NewHumData.Data.nGameDiaMond:=HumData.Data.Abil.GAMEDIAMOND;//���ʯ
    NewHumData.Data.nGameGird:= HumData.Data.Abil.GAMEGIRD;//���
    NewHumData.Data.nGamePoint:=HumData.Data.nGamePoint;
    NewHumData.Data.btGameGlory:=0;//���� 20080511
    NewHumData.Data.nPayMentPoint:=HumData.Data.nPayMentPoint;
    NewHumData.Data.nLoyal:= 0;//�ҳ϶�

    NewHumData.Data.nPKPOINT:=HumData.Data.nPKPOINT;
    NewHumData.Data.btAllowGroup:=HumData.Data.btAllowGroup;
    NewHumData.Data.btF9:=HumData.Data.btF9;
    NewHumData.Data.btAttatckMode:=HumData.Data.btAttatckMode;
    NewHumData.Data.btIncHealth:=HumData.Data.btIncHealth ;
    NewHumData.Data.btIncSpell:=HumData.Data.btIncSpell ;
    NewHumData.Data.btIncHealing:=HumData.Data.btIncHealing ;
    NewHumData.Data.btFightZoneDieCount:=HumData.Data.btFightZoneDieCount;
    NewHumData.Data.sAccount:=HumData.Data.sAccount;
    //NewHumData.Data.btEE:=HumData.Data.btEE ;
    NewHumData.Data.btEF:=0;//Ӣ������ 0-������Ӣ�� 1-����Ӣ�� 
    NewHumData.Data.boLockLogon:=HumData.Data.boLockLogon;
    NewHumData.Data.wContribution:=HumData.Data.wContribution;
    NewHumData.Data.nHungerStatus:=HumData.Data.nHungerStatus;
    NewHumData.Data.boAllowGuildReCall:=HumData.Data.boAllowGuildReCall;
    NewHumData.Data.wGroupRcallTime:=HumData.Data.wGroupRcallTime ;
    NewHumData.Data.dBodyLuck:=HumData.Data.dBodyLuck;
    NewHumData.Data.boAllowGroupReCall:=HumData.Data.boAllowGroupReCall;

    if HumData.Data.nTwoExp > 100 then begin
      NewHumData.Data.nEXPRATE:= HumData.Data.nTwoExp;//ɱ�־��鱶��(�������� 100 Ϊ��������)
      NewHumData.Data.nExpTime:= HumData.Data.nTwoExpTime;//���鱶��ʱ��
    end else begin
      NewHumData.Data.nEXPRATE:= 100;//ɱ�־��鱶��(�������� 100 Ϊ��������)
      NewHumData.Data.nExpTime:= 0;//���鱶��ʱ��
    end;
    
    NewHumData.Data.btLastOutStatus:= 0; //�˳�״̬ 0�����˳� 1Ϊ����
    NewHumData.Data.wMasterCount:= 0;//��ʦ��
    NewHumData.Data.boHasHero := False;//�Ƿ��а�����Ӣ��

    if (HumData.Data.sMasterHeroName <> '') and (HumData.Data.sHeroName = '') and (NewHumData.Data.boIsHero) then begin
      NewHumData.Data.sMasterName:= HumData.Data.sMasterHeroName;
      NewHumData.Header.boIsHero := True;
      NewHumData.Data.boIsHero:= True;
      NewHumData.Header.boDeleted:= False;
    end;

    NewHumData.Data.btStatus:= 0;//HumData.Data.btStatus;
    NewHumData.Data.sHeroChrName:=HumData.Data.sHeroName;
    if NewHumData.Data.sHeroChrName <> '' then NewHumData.Data.boHasHero := True;//��Ӣ����������Ϊ���а���Ӣ�� 20081218
    //NewHumData.Data.UnKnow:=HumData.Data.UnKnow;
   // NewHumData.Data.QuestFlag:=HumData.Data.QuestFlag;

    NewHumData.Data.n_WinExp:= 0;//�������ۼƾ���
    NewHumData.Data.n_UsesItemTick:= 0;//������ۼ�ʱ��
    NewHumData.Data.nReserved:= 0; //��Ƶ�ʱ��,�����ж೤ʱ�����ȡ�ؾ� 20080620
    NewHumData.Data.nReserved1:= 0; //��ǰҩ��ֵ 20080623
    NewHumData.Data.nReserved2:= 0; //ҩ��ֵ���� 20080623
    NewHumData.Data.nReserved3:= 0; //ʹ��ҩ��ʱ��,���㳤ʱ��ûʹ��ҩ�� 20080623
    NewHumData.Data.n_Reserved:= 0;   //��ǰ����ֵ 20080622
    NewHumData.Data.n_Reserved1:= 0;  //�������� 20080622
    NewHumData.Data.n_Reserved2:= 0;  //��ǰ��ƶ� 20080623
    NewHumData.Data.n_Reserved3:= 0;  //ҩ��ֵ�ȼ� 20080623
    NewHumData.Data.boReserved:=False; //�Ƿ������ T-�����
    NewHumData.Data.boReserved1:=False;//�Ƿ�������Ӣ�� 20080519
    NewHumData.Data.boReserved2:=False;//�Ƿ���� T-������� 20080620
    NewHumData.Data.boReserved3:=False;//���Ƿ�Ⱦ����� 20080627
    NewHumData.Data.m_GiveDate:= 0;//������ȡ�л��Ȫ���� 20080625
    NewHumData.Data.Exp68:= 0;//�������嵱ǰ���� 20080625
    NewHumData.Data.MaxExp68:= 0;//���������������� 20080625

    if NewHumData.Header.boIsHero and (HumData.Data.sHeroName = '') and (HumData.Data.sMasterHeroName <> '') then begin
      DBHum.Header.boDeleted:= False;
      DBHum.boDeleted:= False;
      DBHum.Header.bt2:= 1;//��Ӣ��
    end;

    for J := Low(THumItems) to High(THumItems) do begin
      NewHumData.Data.HumItems[J].MakeIndex:=HumData.Data.HumItems[J].MakeIndex;
      NewHumData.Data.HumItems[J].wIndex:=HumData.Data.HumItems[J].wIndex;
      NewHumData.Data.HumItems[J].Dura:=HumData.Data.HumItems[J].Dura;
      NewHumData.Data.HumItems[J].DuraMax:=HumData.Data.HumItems[J].DuraMax;
      for K:= 0 to 13 do begin
        NewHumData.Data.HumItems[J].btValue[K]:=HumData.Data.HumItems[J].btValue[K];
      end;
    end;

    for J := Low(TBagItems) to High(TBagItems) do begin
      NewHumData.Data.BagItems[J].MakeIndex:=HumData.Data.BagItems[J].MakeIndex;
      NewHumData.Data.BagItems[J].wIndex:=HumData.Data.BagItems[J].wIndex;
      NewHumData.Data.BagItems[J].Dura:=HumData.Data.BagItems[J].Dura;
      NewHumData.Data.BagItems[J].DuraMax:=HumData.Data.BagItems[J].DuraMax;
      for K:= 0 to 13 do begin
        NewHumData.Data.BagItems[J].btValue[K]:=HumData.Data.BagItems[J].btValue[K];
      end;
    end;

    for J := Low(TLF_HumMagic) to High(TLF_HumMagic) do begin
      if HumData.Data.Magic[J].wMagIdx = 71 then//71 ������=������ 55
        NewHumData.Data.HumMagics[J].wMagIdx:= 55
      else NewHumData.Data.HumMagics[J].wMagIdx:=HumData.Data.Magic[J].wMagIdx;
      NewHumData.Data.HumMagics[J].btLevel:=HumData.Data.Magic[J].btLevel;
      NewHumData.Data.HumMagics[J].btKey:=HumData.Data.Magic[J].btKey;
      NewHumData.Data.HumMagics[J].nTranPoint:=HumData.Data.Magic[J].nTranPoint;
    end;

    for J := Low(TStorageItems) to High(TStorageItems) do begin
      NewHumData.Data.StorageItems[J].MakeIndex:=HumData.Data.StorageItems[J].MakeIndex;
      NewHumData.Data.StorageItems[J].wIndex:=HumData.Data.StorageItems[J].wIndex;
      NewHumData.Data.StorageItems[J].Dura:=HumData.Data.StorageItems[J].Dura;
      NewHumData.Data.StorageItems[J].DuraMax:=HumData.Data.StorageItems[J].DuraMax;
      for K:= 0 to 13 do begin
        NewHumData.Data.StorageItems[J].btValue[K]:=HumData.Data.StorageItems[J].btValue[K];
      end;
    end;

    for J := Low(TLF_Hum2Items) to High(TLF_Hum2Items) do begin
      NewHumData.Data.HumAddItems[J+9].MakeIndex:=HumData.Data.HumItems2[J].MakeIndex;
      NewHumData.Data.HumAddItems[J+9].wIndex:=HumData.Data.HumItems2[J].wIndex;
      NewHumData.Data.HumAddItems[J+9].Dura:=HumData.Data.HumItems2[J].Dura;
      NewHumData.Data.HumAddItems[J+9].DuraMax:=HumData.Data.HumItems2[J].DuraMax;
      for K:= 0 to 13 do begin
        NewHumData.Data.HumAddItems[J+9].btValue[K]:=HumData.Data.HumItems2[J].btValue[K];
      end;
    end;

    for J := Low(TLF_QuestFlag) to High(TLF_QuestFlag) do begin//20081021 �ű�����ת��
      NewHumData.Data.QuestFlag[J]:= HumData.Data.QuestFlag[J];
    end;

    NewDBHum.Header.boDeleted := DBHum.Header.boDeleted;
    NewDBHum.Header.nSelectID := DBHum.Header.nSelectID;
    NewDBHum.Header.boIsHero := NewHumData.Header.boIsHero;

    NewDBHum.Header.bt2 := DBHum.Header.bt2;
    NewDBHum.Header.dCreateDate := DBHum.Header.UpdateDate;
    NewDBHum.Header.sName := DBHum.Header.sName;

    NewDBHum.sChrName := DBHum.sChrName;
    NewDBHum.sAccount := DBhum.sAccount;
    NewDBHum.boDeleted := DBHum.boDeleted;
    NewDBHum.bt1 := DBHum.bt1;
    NewDBHum.dModDate := DBHum.dModDate;
    NewDBHum.btCount := DBHum.btCount;
    NewDBHum.boSelected := DBHum.boSelected;
    {for J := Low(NewDBHum.n6) to High(NewDBHum.n6) do begin
      NewDBHum.n6[J] := DBHum.n6[j];
    end;}

   { Log(' DC:'+inttostr(HumData.Data.BonusAbil.DC)+' MC:'+inttostr(HumData.Data.BonusAbil.MC)+
        ' SC:'+inttostr(HumData.Data.BonusAbil.SC)+' AC:'+inttostr(HumData.Data.BonusAbil.AC)+
        ' MAC:'+inttostr(HumData.Data.BonusAbil.MAC)+' HP:'+inttostr(HumData.Data.BonusAbil.HP)+
        ' MP:'+inttostr(HumData.Data.BonusAbil.MP)+' Hit:'+inttostr(HumData.Data.BonusAbil.Hit)+
        ' Speed:'+inttostr(HumData.Data.BonusAbil.Speed)+' X2:'+inttostr(HumData.Data.BonusAbil.X2)+
        ' GAMEGIRD:'+inttostr(HumData.Data.Abil.GAMEGIRD)+' Exp:'+inttostr(HumData.Data.Abil.Exp)+
        ' MaxExp:'+inttostr(HumData.Data.Abil.MaxExp)+' Weight:'+inttostr(HumData.Data.Abil.Weight)+
        ' MaxWeight:'+inttostr(HumData.Data.Abil.MaxWeight)+' WearWeight:'+inttostr(HumData.Data.Abil.WearWeight)+
        ' MaxWearWeight:'+inttostr(HumData.Data.Abil.MaxWearWeight)+' HandWeight:'+inttostr(HumData.Data.Abil.HandWeight)+
        ' MaxHandWeight:'+inttostr(HumData.Data.Abil.MaxHandWeight)  
        ,'1');}

    FileWrite(f_MainMirH, NewHumData, Sizeof(THumDataInfo));//д��Mir.DB�ļ�

    FileSeek(f_MainHumH, 0, 2);//2---���ļ�β����λ
    FileWrite(f_MainHumH, NewDBHum, SizeOf(NewDBHum));//д��Hum.DB�ļ�
////////////////////////////////////////////////
    //Inc(m_nTotalPostion);
    FrmMain.RzProgressBar1.PartsComplete :=  FrmMain.RzProgressBar1.PartsComplete +1;
    Inc(m_nCurPostion);
    if Self.Terminated then Break;
  end;

  FileClose(f_HumH);
  FileClose(f_MirH);
  if f_MainMirH > 0 then FileClose(f_MainMirH);
  if f_MainHumH > 0 then FileClose(f_MainHumH);
  if HumDataDB <> nil then HumDataDB.Free;
  if FileExists(PChar(FrmMain.RzButtonEdit1.Text+'\Mir1.DB')) then DeleteFile(PChar(FrmMain.RzButtonEdit1.Text+'\Mir1.DB'));
  if FileExists(PChar(FrmMain.RzButtonEdit1.Text+'\Mir1.DB.idx')) then DeleteFile(PChar(FrmMain.RzButtonEdit1.Text+'\Mir1.DB.idx'));
end;

function TMainWorkThread.GetMaxWorkCount: Integer;
var
  nC: Integer;
begin
  nC  := 0;
  begin
    Inc(nC, GetFileSize(FrmMain.RzButtonEdit1.Text+'\Hum.db', Sizeof(TDBHeader1), Sizeof(TDBHum)));
    Sleep(1);
  end;
  Result := nC;
end;

end.
