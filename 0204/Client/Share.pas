unit Share;

interface

const
  RUNLOGINCODE       = 0; //������Ϸ״̬��,Ĭ��Ϊ0 ����Ϊ 9
  CLIENTTYPE         = 0; //��ͨ��Ϊ0 ,99 Ϊ����ͻ���
    //0Ϊ���԰� 1Ϊ��ͨ�� 2��ҵ��
  Version = 2;      //1��2�����������е�½��  ����ͻ��˹ر�

  DEBUG         = 0;
  SWH800        = 0;
  SWH1024       = 1;
  SWH           = SWH800;

{$IF SWH = SWH800}
   SCREENWIDTH = 800;
   SCREENHEIGHT = 600;
{$ELSEIF SWH = SWH1024}
   SCREENWIDTH = 1024;
   SCREENHEIGHT = 768;
{$IFEND}

   MAPSURFACEWIDTH = SCREENWIDTH;
   MAPSURFACEHEIGHT = SCREENHEIGHT- 155;

   WINLEFT = 60;
   WINTOP  = 60;
   WINRIGHT = SCREENWIDTH-60;
   BOTTOMEDGE = SCREENHEIGHT-30;  // Bottom WINBOTTOM

   MAPDIR             = 'Map\'; //��ͼ�ļ�����Ŀ¼
   CONFIGFILE         = 'Config\%s.ini';
   SDOCONFIGFILE      = 'Config\Ly%s_%s\%s.ini';
   MAINIMAGEFILE      = 'Data\Prguse.wil';
   MAINIMAGEFILE2     = 'Data\Prguse2.wil';
   MAINIMAGEFILE3     = 'Data\Prguse3.wil';
   EFFECTIMAGEDIR     = 'Data\';

   CHRSELIMAGEFILE    = 'Data\ChrSel.wil';
   MINMAPIMAGEFILE    = 'Data\mmap.wil';
   TITLESIMAGEFILE    = 'Data\Tiles.wil';
   SMLTITLESIMAGEFILE = 'Data\SmTiles.wil';
   HUMWINGIMAGESFILE  = 'Data\HumEffect.wil';
   MAGICONIMAGESFILE  = 'Data\MagIcon.wil';
   HUMIMGIMAGESFILE   = 'Data\Hum.wil';
   HUM2IMGIMAGESFILE  = 'Data\Hum2.wil'; //20080501
   HAIRIMGIMAGESFILE  = 'Data\Hair2.wil';
   WEAPONIMAGESFILE   = 'Data\Weapon.wil';
   WEAPON2IMAGESFILE  = 'Data\Weapon2.wil'; //20080501
   NPCIMAGESFILE      = 'Data\Npc.wil';
   MAGICIMAGESFILE    = 'Data\Magic.wil';
   MAGIC2IMAGESFILE   = 'Data\Magic2.wil';
   MAGIC3IMAGESFILE   = 'Data\Magic3.wil';
   MAGIC4IMAGESFILE   = 'Data\Magic4.wil'; //2007.10.28
   MAGIC5IMAGESFILE   = 'Data\Magic5.wil'; //2007.11.29
   MAGIC6IMAGESFILE   = 'Data\Magic6.wil'; //2007.11.29
   qingqingFILE       = 'Data\Qk_Prguse.wil';
   BAGITEMIMAGESFILE   = 'Data\Items.wil';
   STATEITEMIMAGESFILE = 'Data\StateItem.wil';
   DNITEMIMAGESFILE    = 'Data\DnItems.wil';
   OBJECTIMAGEFILE     = 'Data\Objects.wil';
   OBJECTIMAGEFILE1    = 'Data\Objects%d.wil';
   MONIMAGEFILE        = 'Data\Mon%d.wil';
   DRAGONIMAGEFILE     = 'Data\Dragon.wil';
   EFFECTIMAGEFILE     = 'Data\Effect.wil';
   DRAGONIMGESFILE     = 'Data\Dragon.wil';
   {
   MAXX = 40;
   MAXY = 40;
   }
  MAXX = SCREENWIDTH div 20;
  MAXY = SCREENWIDTH div 20;

  DEFAULTCURSOR = 0; //ϵͳĬ�Ϲ��
  IMAGECURSOR   = 1; //ͼ�ι��

  USECURSOR     = DEFAULTCURSOR; //ʹ��ʲô���͵Ĺ��

  MAXBAGITEMCL = 52;
  ENEMYCOLOR = 69;

implementation

end.
