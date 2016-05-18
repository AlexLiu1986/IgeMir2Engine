unit PlugShare;

interface
uses
  Windows, Classes, EngineType;
resourcestring
  sDBHeaderDesc = '�Զ���ħ�����ݿ� ����������http://www.IGEM2.com.cn';
  m_sDBFileName='UserMagic.db';
type
  TDBHeader = packed record //Size 12
    sDesc: string[49]; //0x00    36
    nLastIndex: Integer; //0x5C
    nMagicCount: Integer; //0x68
    dCreateDate: TDateTime; //����ʱ��
  end;
  pTDBHeader = ^TDBHeader;

  TRecordHeader = packed record //Size 12
    boDeleted: Boolean;
    dCreateDate: TDateTime; //����ʱ��
  end;
  pTRecordHeader = ^TRecordHeader;

  TMagicConfig = packed record
    nSelMagicID: Integer; //ʹ��ĳ��ħ����Ч��
    nMagicCount: Integer;
    nAttackRange: Integer; //������Χ
    nAttackWay: Integer; //������ʽ
    nNeed: Integer; //ʹ��ħ����Ҫ��Ʒ
    boHP: Boolean;
    boMP: Boolean;
    boAC: Boolean;
    boMC: Boolean;
    boAbil: Boolean;
  end;
  pTMagicConfig = ^TMagicConfig;

  TMagicRcd = packed record
    RecordHeader: TRecordHeader;
    Magic: _TMAGIC;
    MagicConfig: TMagicConfig;
  end;
  pTMagicRcd = ^TMagicRcd;

var
  PlugHandle: Integer;
  PlugClass: string = 'Config';
  g_MagicList: Classes.TList;
  nSelMagicID: Integer;
  m_nFileHandle:Integer;
  m_Header:TDBHeader;
implementation

end.

