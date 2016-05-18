unit Share;

interface

const
  RUNLOGINCODE       = 0; //进入游戏状态码,默认为0 测试为 9
  CLIENTTYPE         = 0; //普通的为0 ,99 为管理客户端
    //0为测试版 1为普通版 2商业版
  Version = 2;      //1和2必须外面运行登陆器  否则客户端关闭

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

   MAPDIR             = 'Map\'; //地图文件所在目录
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

  DEFAULTCURSOR = 0; //系统默认光标
  IMAGECURSOR   = 1; //图形光标

  USECURSOR     = DEFAULTCURSOR; //使用什么类型的光标

  MAXBAGITEMCL = 52;
  ENEMYCOLOR = 69;

implementation

end.
