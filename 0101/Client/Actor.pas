unit Actor;  

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms,
  Grobal2, DxDraws, CliUtil, magiceff, Wil, SDK, ClFunc;

const
   HUMANFRAME = 600; //hum.wil,,,一种Race所占的图片数
   MAXSAY = 5;
   RUN_MINHEALTH = 10;//低于这个血量只能走动
   DEFSPELLFRAME = 10; //魔法最大浈
   MAGBUBBLEBASE = 3890;    //魔法盾效果图位置
   MAGBUBBLESTRUCKBASE = 3900; //被攻击时魔法盾效果图位置
   MAXWPEFFECTFRAME = 5;
   WPEFFECTBASE = 3750;
type
//动作定义
  TActionInfo = packed record
    start   :Word;//0x14              // 开始帧
    frame   :Word;//0x16              // 帧数
    skip    :Word;//0x18              // 跳过的帧数
    ftime   :Word;//0x1A              // 每帧的延迟时间（毫秒）
    usetick :Word;//0x1C              // 荤侩平, 捞悼 悼累俊父 荤侩凳
  end;
  pTActionInfo = ^TActionInfo;

//玩家的动作定义
  THumanAction = packed record
    ActStand:      TActionInfo;   //1
    ActWalk:       TActionInfo;   //8
    ActRun:        TActionInfo;   //8
    ActRushLeft:   TActionInfo;
    ActRushRight:  TActionInfo;
    ActWarMode:    TActionInfo;   //1
    ActHit:        TActionInfo;   //6
    ActHeavyHit:   TActionInfo;   //6
    ActBigHit:     TActionInfo;   //6
    ActFireHitReady: TActionInfo; //6
    ActSpell:      TActionInfo;   //6
    ActSitdown:    TActionInfo;   //1
    ActStruck:     TActionInfo;   //3
    ActDie:        TActionInfo;   //4
  end;
  pTHumanAction = ^THumanAction;
  TMonsterAction = packed record
    ActStand:      TActionInfo;   //1
    ActWalk:       TActionInfo;   //8
    ActAttack:     TActionInfo;   //6 0x14 - 0x1C
    ActCritical:   TActionInfo;   //6 0x20 -
    ActStruck:     TActionInfo;   //3
    ActDie:        TActionInfo;   //4
    ActDeath:      TActionInfo;
  end;
  pTMonsterAction = ^TMonsterAction;
const
   //人类动作定义
   //每个人物每个级别每个性别共600幅图
   //设级别=L，性别=S，则开始帧=L*600+600*S

   //Start:该动作在这组外观下的开始帧
   //frame:该动作需要的帧数
   //skip:跳过的帧数
   HA: THumanAction = (//开始帧       有效帧     跳过帧    每帧延迟
        ActStand:  (start: 0;      frame: 4;  skip: 4;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 64;     frame: 6;  skip: 2;  ftime: 90;   usetick: 2);
        ActRun:    (start: 128;    frame: 6;  skip: 2;  ftime: 120;  usetick: 3);
        ActRushLeft: (start: 128;    frame: 3;  skip: 5;  ftime: 120;  usetick: 3);
        ActRushRight:(start: 131;    frame: 3;  skip: 5;  ftime: 120;  usetick: 3);
        ActWarMode:(start: 192;    frame: 1;  skip: 0;  ftime: 200;  usetick: 0);
        //ActHit:    (start: 200;    frame: 5;  skip: 3;  ftime: 140;  usetick: 0);
        ActHit:    (start: 200;    frame: 6;  skip: 2;  ftime: 85;   usetick: 0);
        ActHeavyHit:(start: 264;   frame: 6;  skip: 2;  ftime: 90;   usetick: 0);
        ActBigHit: (start: 328;    frame: 8;  skip: 0;  ftime: 70;   usetick: 0);
        ActFireHitReady: (start: 192; frame: 6;  skip: 4;  ftime: 70;   usetick: 0);
        ActSpell:  (start: 392;    frame: 6;  skip: 2;  ftime: 60;   usetick: 0);
        ActSitdown:(start: 456;    frame: 2;  skip: 0;  ftime: 300;  usetick: 0);
        ActStruck: (start: 472;    frame: 3;  skip: 5;  ftime: 70;  usetick: 0);
        ActDie:    (start: 536;    frame: 4;  skip: 4;  ftime: 120;  usetick: 0)
      );
  MA9: TMonsterAction = (//4C03D4
    ActStand:(Start:0;  frame:1;  skip:7;  ftime:200;  usetick:0);
    ActWalk:(Start:64;  frame:6;  skip:2;  ftime:120;  usetick:3);
    ActAttack:(Start:64;  frame:6;  skip:2;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:64;  frame:6;  skip:2;  ftime:100;  usetick:0);
    ActDie:(Start:0;  frame:1;  skip:7;  ftime:140;  usetick:0);
    ActDeath:(Start:0;  frame:1;  skip:7;  ftime:0;  usetick:0);
    );
   MA10: TMonsterAction = (  //(8Frame) 带刀卫士
           //每个动作8帧    //从这里可以推测出怪物有几种？//这里是280的
        ActStand:  (start: 0;      frame: 4;  skip: 4;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 64;     frame: 6;  skip: 2;  ftime: 120;  usetick: 3);
        ActAttack: (start: 128;    frame: 4;  skip: 4;  ftime: 150;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 192;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 208;    frame: 4;  skip: 4;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 272;    frame: 1;  skip: 0;  ftime: 0;    usetick: 0);
      );
   MA11: TMonsterAction = (  //荤娇(10Frame楼府)  //每个动作10帧 //280,(360的),440,430,,
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 120;  usetick: 3);
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 340;    frame: 1;  skip: 0;  ftime: 0;    usetick: 0);
      );
   MA12: TMonsterAction = (  //版厚捍, 锭府绰 加档 狐福促.//每个动作8帧，每个动作8个方向，共7种动作 (280),360,440,430,,
        ActStand:  (start: 0;      frame: 4;  skip: 4;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 64;     frame: 6;  skip: 2;  ftime: 120;  usetick: 3);
        ActAttack: (start: 128;    frame: 6;  skip: 2;  ftime: 150;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 192;    frame: 2;  skip: 0;  ftime: 150;  usetick: 0);
        ActDie:    (start: 208;    frame: 4;  skip: 4;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 272;    frame: 1;  skip: 0;  ftime: 0;    usetick: 0);
      );
   MA13: TMonsterAction = (  //   mon2.wil中的食人花
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        //打开mon2.wil可以看到食人花,actstand是食人花站立状态
        ActWalk:   (start: 10;     frame: 8;  skip: 2;  ftime: 160;  usetick: 0); 
        //actwalk实际上是食人花站出来或消隐的效果注意到花尾的泥土实际一些objects.wil里面也有泥土tiles
         //石墓尸王钻出来时的地图效果，，食人花的效果跟暗龙相似，不知道暗龙的动作类型是不是也属于ma13
        ActAttack: (start: 30;     frame: 6;  skip: 4;  ftime: 120;  usetick: 0);
        //actattack从30开始是从各个方位攻击的效果
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        //actcritical这个动作略去
        ActStruck: (start: 110;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        //受伤110开始，，
        ActDie:    (start: 130;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        //130开始死亡效果
        ActDeath:  (start: 20;     frame: 9;  skip: 0;  ftime: 150;  usetick: 0);
        //20开始是食人花消隐的效果也是它死亡效果所以在这重用，，只有9帧最后一帧略去
      );
   MA14: TMonsterAction = (  //秦榜 坷付 mon3里面的骷髅战士,,分析方法同ma13
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 340;    frame: 10; skip: 0;  ftime: 100;  usetick: 0); //归榜牢版快(家券)
      );
   MA15: TMonsterAction = (  //沃玛战土??新问题：源程序中对怪物的分类逻辑是不是就是mon*.wil的分类逻辑
        //又注意到沃玛战士的五器没有,它带的可是海魂，，难道它也跟hum.wil一样要跟weapon.wil挂钩才能钩成完整的形象?
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        //die跟death有什么区别啊???一个是死亡开始，，一个是在地面上的残骸??但是按这样说下面的逻辑不对啊!!
        ActDeath:  (start: 1;      frame: 1;  skip: 0;  ftime: 100;  usetick: 0);
      );
   MA16: TMonsterAction = (  //啊胶筋绰 备单扁  mon5里面的电僵尸？？代表可移动的魔法攻击动作的怪物一类??
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 4;  skip: 6;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 1;  skip: 0;  ftime: 160;  usetick: 0);
      );
   MA17: TMonsterAction = (  //官迭波府绰 各  mon6中的和尚僵王（和石墓尸王共用一形象）
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 60;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 100;  usetick: 0);
        ActDeath:  (start: 340;    frame: 1;  skip: 0;  ftime: 140;  usetick: 0); //
      );
   MA19: TMonsterAction = (
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 340;    frame: 1;  skip: 0;  ftime: 140;  usetick: 0); //
      );
   MA20: TMonsterAction = (
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 120;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 100;  usetick: 0);
        ActDeath:  (start: 340;    frame: 10; skip: 0;  ftime: 170;  usetick: 0);
      );
   MA21: TMonsterAction = (
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 0;      frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActAttack: (start: 10;     frame: 6;  skip: 4;  ftime: 120;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 20;     frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 30;     frame: 10; skip: 0;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 0;    usetick: 0); 
      );
   MA22: TMonsterAction = (
        ActStand:  (start: 80;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3); 
        ActAttack: (start: 240;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 320;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 340;    frame: 10; skip: 0;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 6;  skip: 4;  ftime: 170;  usetick: 0);
      );
   MA23: TMonsterAction = (
        ActStand:  (start: 20;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 100;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 180;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0); //
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 260;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 280;    frame: 10; skip: 0;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 20; skip: 0;  ftime: 100;  usetick: 0);
      );
   MA24: TMonsterAction = (  // (攻击) mon14中的蝎蛇??通过以下的分析好像又不是?
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start:240;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActStruck: (start: 320;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 340;    frame: 10; skip: 0;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 420;    frame: 1;  skip: 0;  ftime: 140;  usetick: 0); //
      );
  MA25: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:70;  frame:10;  skip:0;  ftime:200;  usetick:3);
    ActAttack:(Start:20;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:10;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:50;  frame:2;  skip:0;  ftime:100;  usetick:0);
    ActDie:(Start:60;  frame:10;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:80;  frame:10;  skip:0;  ftime:200;  usetick:3);
    );

   MA26: TMonsterAction = (  
        ActStand:  (start: 0;      frame: 1;  skip: 7;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 0;      frame: 0;  skip: 0;  ftime: 160;  usetick: 0);
        ActAttack: (start: 56;     frame: 6;  skip: 2;  ftime: 500;  usetick: 0);
        ActCritical:(start: 64;    frame: 6;  skip: 2;  ftime: 500;  usetick: 0);
        ActStruck: (start: 0;      frame: 4;  skip: 4;  ftime: 100;  usetick: 0);
        ActDie:    (start: 24;     frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 150;  usetick: 0);
      );
   MA27: TMonsterAction = (
        ActStand:  (start: 0;     frame: 1;  skip: 7;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 0;     frame: 0;  skip: 0;  ftime: 160;  usetick: 0);
        ActAttack: (start: 0;     frame: 0;  skip: 0;  ftime: 250;  usetick: 0);
        ActCritical:(start: 0;    frame: 0;  skip: 0;  ftime: 250;  usetick: 0);
        ActStruck: (start: 0;     frame: 0;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 0;     frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 0;     frame: 0;  skip: 0;  ftime: 150;  usetick: 0);
      );
   MA28: TMonsterAction = (
        ActStand:  (start: 80;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3);
        ActAttack: (start:  0;     frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start:  0;     frame: 10; skip: 0;  ftime: 100;  usetick: 0);
      );
   MA29: TMonsterAction = (
        ActStand:  (start: 80;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3);
        ActAttack: (start: 240;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 10; skip: 0;  ftime: 100;  usetick: 0);
        ActStruck: (start: 320;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 340;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start:  0;     frame: 10; skip: 0;  ftime: 100;  usetick: 0);
      );
  MA30: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:10;  skip:0;  ftime:200;  usetick:3);
    ActAttack:(Start:10;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:10;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:20;  frame:2;  skip:0;  ftime:100;  usetick:0);
    ActDie:(Start:30;  frame:20;  skip:0;  ftime:150;  usetick:0);
    ActDeath:(Start:0;  frame:10;  skip:0;  ftime:200;  usetick:3);
    );
  MA31: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:10;  skip:0;  ftime:200;  usetick:3);
    ActAttack:(Start:10;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:0;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:0;  frame:2;  skip:8;  ftime:100;  usetick:0);
    ActDie:(Start:20;  frame:10;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:0;  frame:10;  skip:0;  ftime:200;  usetick:3);
    );
  MA32: TMonsterAction = (
    ActStand:(Start:0;  frame:1;  skip:9;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:6;  skip:4;  ftime:200;  usetick:3);
    ActAttack:(Start:0;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:0;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:0;  frame:2;  skip:8;  ftime:100;  usetick:0);
    ActDie:(Start:80;  frame:10;  skip:0;  ftime:80;  usetick:0);
    ActDeath:(Start:80;  frame:10;  skip:0;  ftime:200;  usetick:3);
    );
  MA33: TMonsterAction = (
             //开始帧    有效帧    跳过帧   每帧延迟
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    //actstand是站立状态
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:200;  usetick:3);
    ActAttack:(Start:160;  frame:6;  skip:4;  ftime:120;  usetick:0);
    //actattack从30开始是从各个方位攻击的效果
    ActCritical:(Start:340;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:240;  frame:2;  skip:0;  ftime:100;  usetick:0);
    ActDie:(Start:260;  frame:10;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:260;  frame:10;  skip:0;  ftime:200;  usetick:0);
    );
  MA34: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:200;  usetick:3);
    ActAttack:(Start:160;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:320;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:400;  frame:2;  skip:0;  ftime:100;  usetick:0);
    ActDie:(Start:420;  frame:20;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:420;  frame:20;  skip:0;  ftime:200;  usetick:0);
    );
  MA35: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:30;  frame:10;  skip:0;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:1;  skip:9;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA36: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:30;  frame:20;  skip:0;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:1;  skip:9;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA37: TMonsterAction = (
    ActStand:(Start:30;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:30;  frame:4;  skip:6;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:1;  skip:9;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA38: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:80;  frame:6;  skip:4;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA39: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:300;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:10;  frame:6;  skip:4;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:20;  frame:2;  skip:0;  ftime:150;  usetick:0);
    ActDie:(Start:30;  frame:10;  skip:0;  ftime:80;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA40: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:250;  usetick:0);
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:210;  usetick:3);
    ActAttack:(Start:160;  frame:6;  skip:4;  ftime:110;  usetick:0);
    ActCritical:(Start:580;  frame:20;  skip:0;  ftime:135;  usetick:0);
    ActStruck:(Start:240;  frame:2;  skip:0;  ftime:120;  usetick:0);
    ActDie:(Start:260;  frame:20;  skip:0;  ftime:130;  usetick:0);
    ActDeath:(Start:260;  frame:20;  skip:0;  ftime:130;  usetick:0);
    );
  MA41: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA42: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:10;  frame:8;  skip:2;  ftime:160;  usetick:0);
    ActAttack:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDie:(Start:30;  frame:10;  skip:0;  ftime:120;  usetick:0);
    ActDeath:(Start:30;  frame:10;  skip:0;  ftime:150;  usetick:0);
    );
  MA43: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:160;  usetick:0);
    ActAttack:(Start:160;  frame:6;  skip:4;  ftime:160;  usetick:0);
    ActCritical:(Start:160;  frame:6;  skip:4;  ftime:160;  usetick:0);
    ActStruck:(Start:240;  frame:2;  skip:0;  ftime:150;  usetick:0);
    ActDie:(Start:260;  frame:10;  skip:0;  ftime:120;  usetick:0);
    ActDeath:(Start:340;  frame:10;  skip:0;  ftime:100;  usetick:0);
    );
  MA44: TMonsterAction = (
    ActStand:(Start:0;  frame:10;  skip:0;  ftime:300;  usetick:0);
    ActWalk:(Start:10;  frame:6;  skip:4;  ftime:150;  usetick:0);
    ActAttack:(Start:20;  frame:6;  skip:4;  ftime:150;  usetick:0);
    ActCritical:(Start:40;  frame:10;  skip:0;  ftime:150;  usetick:0);
    ActStruck:(Start:40;  frame:2;  skip:8;  ftime:150;  usetick:0);
    ActDie:(Start:30;  frame:6;  skip:4;  ftime:150;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA45: TMonsterAction = (
    ActStand:(Start:0;  frame:10;  skip:0;  ftime:300;  usetick:0);
    ActWalk:(Start:0;  frame:10;  skip:0;  ftime:300;  usetick:0);
    ActAttack:(Start:10;  frame:10;  skip:0;  ftime:300;  usetick:0);
    ActCritical:(Start:10;  frame:10;  skip:0;  ftime:100;  usetick:0);
    ActStruck:(Start:0;  frame:1;  skip:9;  ftime:300;  usetick:0);
    ActDie:(Start:0;  frame:1;  skip:9;  ftime:300;  usetick:0);
    ActDeath:(Start:0;  frame:1;  skip:9;  ftime:300;  usetick:0);
    );
  MA46: TMonsterAction = (
    ActStand:(Start:0;  frame:20;  skip:0;  ftime:100;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  {MA47: TMonsterAction = (//4C0A4C 嗜血教主
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:200;  usetick:3);
    ActAttack:(Start:160;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:260;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:240;  frame:2;  skip:0;  ftime:100;  usetick:0);
    ActDie:(Start:524;  frame:6;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:524;  frame:6;  skip:0;  ftime:200;  usetick:0);
    ); }
  MA49: TMonsterAction = (
    ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
    ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3);
    ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 0);
    ActCritical:(start: 340;   frame: 6;  skip: 4;  ftime: 160;  usetick: 0);
    ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
    ActDie:    (start: 260;    frame: 10;  skip: 0;  ftime: 160;  usetick: 0);
    ActDeath:  (start: 420;   frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
    );
  MA50: TMonsterAction = ( //雪域
    ActStand:  (start: 0;      frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    ActWalk:   (start: 0;     frame: 10;  skip: 0;  ftime: 60;  usetick: 3);
    ActAttack: (start: 0;    frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    ActCritical:(start: 0;   frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    ActStruck: (start: 0;    frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    ActDie:    (start: 0;    frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    ActDeath:  (start: 0;   frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    );
  MA51: TMonsterAction = ( //雪域
    ActStand:  (start: 0;      frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    ActWalk:   (start: 0;     frame: 1;  skip: 0;  ftime: 60;  usetick: 3);
    ActAttack: (start: 0;    frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    ActCritical:(start: 0;   frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    ActStruck: (start: 0;    frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    ActDie:    (start: 0;    frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    ActDeath:  (start: 0;   frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    );
  MA70: TMonsterAction = (//卧龙笔记NPC
    ActStand:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActAttack:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActCritical:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActStruck:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActDie:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    );
  MA71: TMonsterAction = (//酒馆3个人物NPC 20080308
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:10;  frame:19;  skip:0;  ftime:200;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA93: TMonsterAction = ( //雷炎蛛王 200808012
      ActStand:  (start: 0;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
      ActWalk:   (start: 80;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3);
      ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
      ActCritical:(start: 340;     frame: 10;  skip: 0;  ftime: 160;    usetick: 0);
      ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
      ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 160;  usetick: 0);
      ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 0;  usetick: 0);
    );
  MA100: TMonsterAction = (//月灵
    ActStand:(Start:360;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:440;  frame:6;  skip:4;  ftime:200;  usetick:3);
    ActAttack:(Start:520;  frame:6;  skip:4;  ftime:160;  usetick:0);

    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:600;  frame:2;  skip:0;  ftime:100;  usetick:0);//受攻击
    ActDie:(Start:620;  frame:6;  skip:4;  ftime:130;  usetick:0);
    ActDeath:(Start:0;  frame:10;  skip:0;  ftime:100;  usetick:0);
    );
{------------------------------------------------------------------------------}
// 武器绘制顺序 (是否先于身体绘制: 0是/1否)
// WEAPONORDERS: array [Sex, FrameIndex] of Byte
{------------------------------------------------------------------------------}
   WORDER: Array[0..1, 0..599] of byte = (  //1: 女,  0: 男
                                            //第一维是性别，第二维是动作图片索引
      (       //男
      //站
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,1,1,1,1,
      0,0,0,0,1,1,1,1,    0,0,0,0,1,1,1,1,
      //走
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,0,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //跑
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,1,1,1,1,1,1,    0,0,1,1,1,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //war葛靛
      0,1,1,1,0,0,0,0,
      //击
      1,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,    1,1,1,0,0,0,0,0,
      1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,0,0,0,0,0,
      0,0,0,0,0,0,0,0,    1,1,1,1,0,0,1,1,
      //击 2
      0,1,1,0,0,0,1,1,    0,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,
      1,1,1,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,0,1,1,1,0,0,    0,1,1,1,1,0,1,1,
      //击3
      1,1,0,1,0,0,0,0,    1,1,0,0,0,0,0,0,    1,1,1,1,1,0,0,0,
      1,1,0,0,1,0,0,0,    1,1,1,0,0,0,0,1,    0,1,1,0,0,0,0,0,
      0,0,0,0,1,1,1,0,    1,1,1,1,1,0,0,0,
      //付过
      0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,
      1,0,0,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,1,1,0,0,1,1,    0,0,0,1,0,0,1,1,
      //澵扁
      0,0,1,0,1,1,1,1,    1,1,0,0,0,1,0,0,
      //嘎扁
      0,0,0,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      //静矾咙
      0,0,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1
      ),

      (
      //沥瘤
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,1,1,1,1,
      0,0,0,0,1,1,1,1,    0,0,0,0,1,1,1,1,
      //叭扁
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,0,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //顿扁
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,1,1,1,1,1,1,    0,0,1,1,1,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //war葛靛
      1,1,1,1,0,0,0,0,
      //傍拜
      1,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,    1,1,1,0,0,0,0,0,
      1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,0,0,0,0,0,
      0,0,0,0,0,0,0,0,    1,1,1,1,0,0,1,1,
      //傍拜 2
      0,1,1,0,0,0,1,1,    0,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,
      1,1,1,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,0,1,1,1,0,0,    0,1,1,1,1,0,1,1,
      //傍拜3
      1,1,0,1,0,0,0,0,    1,1,0,0,0,0,0,0,    1,1,1,1,1,0,0,0,
      1,1,0,0,1,0,0,0,    1,1,1,0,0,0,0,1,    0,1,1,0,0,0,0,0,
      0,0,0,0,1,1,1,0,    1,1,1,1,1,0,0,0,
      //付过
      0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,
      1,0,0,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,1,1,0,0,1,1,    0,0,0,1,0,0,1,1,
      //澵扁
      0,0,1,0,1,1,1,1,    1,1,0,0,0,1,0,0,
      //嘎扁
      0,0,0,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      //静矾咙
      0,0,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1
      )
   );


type
   TActor = class
     m_nRecogId                :Integer;    //角色标识 0x4
     m_nCurrX                  :Integer;    //当前所在地图座标X 0x08
     m_nCurrY                  :Integer;    //当前所在地图座标Y 0x0A
     m_btDir                   :Byte;       //当前站立方向 0x0C
     m_btSex                   :Byte;       //性别 0x0D
     m_btRace                  :Byte;       //0x0E
     m_btHair                  :Byte;       //头发类型 0x0F
     m_btDress                 :Byte;       //衣服类型 0x10
     m_btWeapon                :Byte;       //武器类型
     //m_btHorse                 :Byte;       //马类型   20080721 注释骑马
     m_btEffect                :Byte;       //天使类型
     m_btJob                   :Byte;       //职业 0:武士  1:法师  2:道士
     m_wAppearance             :Word;       //0x14 DIV 10=种族（外貌）， Mod 10=外貌图片在图片库中的位置（第几种）
     m_nLoyal                  :Integer;    //英雄忠诚度
     m_nFeature                :Integer;    //0x18
     m_nFeatureEx              :Integer;    //0x18
     m_nState                  :Integer;    //0x1C
     m_boDeath                 :Boolean;    //0x20
     m_boSkeleton              :Boolean;    //0x21
     m_boDelActor              :Boolean;    //0x22
     m_boDelActionAfterFinished :Boolean;   //0x23
     m_sDescUserName           :String;     //人物名称，后缀
     m_sUserName               :String;     //名字
     m_nNameColor              :Integer;    //名字颜色
     m_btMiniMapHeroColor      :byte;       //英雄小地图名字颜色
     m_Abil                    :TAbility;   //基本属性
     m_nGold                   :Integer;    //金币数量0x58
     m_nGameGold               :Integer;    //游戏币数量
     m_nGamePoint              :Integer;    //游戏点数量
     m_nGameDiaMond            :Integer;    //金刚石数量  2008.02.11
     m_nGameGird               :Integer;    //灵符数量  2008.02.11
     m_nGameGlory              :Byte; //荣誉数量 20080511

     m_nHitSpeed               :ShortInt;   //攻击速度 0: 扁夯, (-)蠢覆 (+)狐抚
     m_boVisible               :Boolean;    //0x5D
     m_boHoldPlace             :Boolean;    //0x5E

     m_SayingArr               :array[0..MAXSAY-1] of String;  //最近说的话
     m_SayWidthsArr            :array[0..MAXSAY-1] of Integer; //每句话的宽度
     m_dwSayTime               :LongWord;
     m_nSayX                   :Integer;
     m_nSayY                   :Integer;
     m_nSayLineCount           :Integer;

     m_nShiftX                 :Integer;    //0x98
     m_nShiftY                 :Integer;    //0x9C

     //m_nLightX                 :Integer;  //月灵图片坐标 光 2007.12.12
     m_nPx                     :Integer;  //0xA0
     m_nHpx                    :Integer;  //0xA4
     m_nWpx                    :Integer;  //0xA8
     m_nSpx                    :Integer;  //0xAC

     //m_nLightY                 :Integer;  //月灵图片坐标 光 2007.12.12
     m_nPy                     :Integer;
     m_nHpy                    :Integer;
     m_nWpy                    :Integer;
     m_nSpy                    :Integer;  //0xB0 0xB4 0xB8 0xBC

     m_nRx                     :Integer;
     m_nRy                     :Integer;//0xC0 0xC4
     m_nDownDrawLevel          :Integer;    //0xC8
     m_nTargetX                :Integer;
     m_nTargetY                :Integer; //0xCC 0xD0
     m_nTargetRecog            :Integer;      //0xD4
     m_nHiterCode              :Integer;        //0xD8
     m_nMagicNum               :Integer;         //0xDC
     m_nCurrentEvent           :Integer; //辑滚狼 捞亥飘 酒捞叼
     m_boDigFragment           :Boolean; //挖矿效果
     //m_boThrow                 :Boolean;  20080803注释

     m_nBodyOffset             :Integer;     //0x0E8   //0x0D0 // 身体图片索引的主偏移
     m_nHairOffset             :Integer;     //0x0EC           // 头发图片索引的主偏移
     m_nHumWinOffset           :Integer;   //0x0F0
     m_nWeaponOffset           :Integer;   //0x0F4             // 武器图片索引的主偏移
     m_boUseMagic              :Boolean;    //0x0F8   //0xE0
     m_boHitEffect             :Boolean;   //0x0F9    //0xE1
     m_boUseEffect             :Boolean;   //0x0FA    //0xE2
     m_nHitEffectNumber        :Integer;              //0xE4
     m_dwWaitMagicRequest      :LongWord;
     m_nWaitForRecogId         :Integer;  //磊脚捞 荤扼瘤搁 WaitFor狼 actor甫 visible 矫挪促.
     m_nWaitForFeature         :Integer;
     m_nWaitForStatus          :Integer;


     m_nCurEffFrame            :Integer;       //0x110
     m_nSpellFrame             :Integer;        //0x114
     m_CurMagic                :TUseMagicInfo;    //0x118  //m_CurMagic.EffectNumber 0x110

     m_nGenAniCount            :Integer;                   //0x124
     m_boOpenHealth            :Boolean;        //0x140
     m_noInstanceOpenHealth    :Boolean;//0x141
     m_dwOpenHealthStart       :LongWord;
     m_dwOpenHealthTime        :LongWord;//Integer;jacky

      //SRc: TRect;  //Screen Rect 拳搁狼 角力谅钎(付快胶 扁霖)
     m_BodySurface             :TDirectDrawSurface;    //0x14C   //0x134

    // m_LightSurface             :TDirectDrawSurface;    //0x14C   //0x134

     m_boGrouped               :Boolean;    // 是否组队
     m_nCurrentAction          :Integer;    //0x154         //0x13C
     m_boReverseFrame          :Boolean;    //0x158
     m_boWarMode               :Boolean;    //0x159
     m_dwWarModeTime           :LongWord;   //0x15C
     m_nChrLight               :Integer;    //0x160
     m_nMagLight               :Integer;    //0x164
     m_nRushDir                :Integer;  //0, 1
     //m_nXxI                    :Integer; //0x16C   20080521 注释没用到变量
     m_boLockEndFrame          :Boolean;
     m_dwLastStruckTime        :LongWord;  
     m_dwSendQueryUserNameTime :LongWord;
     m_dwDeleteTime            :LongWord;


     m_nMagicStruckSound       :Integer;  //0x180 被魔法攻击弯腰发出的声音
     m_boRunSound              :Boolean;  //0x184 跑步发出的声音
     m_nFootStepSound          :Integer;  //CM_WALK, CM_RUN //0x188  走步声
     m_nStruckSound            :Integer;  //SM_STRUCK         //0x18C  弯腰声音
     m_nStruckWeaponSound      :Integer;                //0x190  被指定武器攻击弯腰声音

     m_nAppearSound            :Integer;  //殿厘家府 0    //0x194
     m_nNormalSound            :Integer;  //老馆家府 1    //0x198
     m_nAttackSound            :Integer;  //         2    //0x19C
     m_nWeaponSound            :Integer; //          3    //0x1A0
     m_nScreamSound            :Integer;  //         4    //0x1A4
     m_nDieSound               :Integer;     //磷阑锭   5 SM_DEATHNOW //0x1A8
     m_nDie2Sound              :Integer;                    //0x1AC

     m_nMagicStartSound        :Integer;     //0x1B0
     m_nMagicFireSound         :Integer;      //0x1B4
     m_nMagicExplosionSound    :Integer; //0x1B8
     m_Action                  :pTMonsterAction;
     //英雄召唤或退出 begin
     HeroLoginStartFrame       :Integer; //英雄登陆开始帧
     HeroLoginExplosionFrame   :Integer; //英雄登陆往后播放的帧数
     HeroLoginNextFrameTime    :Integer; //英雄登陆时间间隔
     HeroTime                  :LongWord;
     HeroFrame                 :Integer;
     g_HeroLoginOrLogOut       :Boolean; //英雄召唤或退出
     // end
{******************************************************************************}
     //人自身显示动画 begin   2008.01.13
     m_nMyShowStartFrame        :Integer; //自身动画开始帧
     m_nMyShowExplosionFrame    :Integer; //自身动画往后播放的帧数
     m_nMyShowNextFrameTime     :LongWord; //自身动画时间间隔
     m_nMyShowTime              :LongWord; //当前时间
     m_nMyShowFrame             :Integer; //当前帧
     g_boIsMyShow               :Boolean; //是否显示动画{接到消息为True}
     g_MagicBase                :TWMImages; //图库
     m_boNoChangeIsMyShow       :Boolean; //是否发出的动画坐标不随着人物动作而变化  20080306
     m_nNoChangeX, m_nNoChangeY :Integer; //不改变动画的坐标X，Y  20080306
{******************************************************************************}
     //g_boIsHero                 :Boolean;

      m_Skill69NH: Word;//当前内力值 20080930
      m_Skill69MaxNH: Word;//最大内力值 20080930

   private
     function GetMessage(ChrMsg:pTChrMsg):Boolean;
   protected
     m_nStartFrame             :Integer;      //0x1BC        //0x1A8  // 当前动作的开始帧索引
     m_nEndFrame               :Integer;        //0x1C0      //0x1AC  // 当前动作的结束帧索引
     m_nCurrentFrame           :Integer;    //0x1C4          //0x1B0
     m_nEffectStart            :Integer;     //0x1C8         //0x1B4
     m_nEffectFrame            :Integer;     //0x1CC         //0x1B8
     m_nEffectEnd              :Integer;       //0x1D0       //0x1BC
     m_dwEffectStartTime       :LongWord;//0x1D4             //0x1C0
     m_dwEffectFrameTime       :LongWord;//0x1D8             //0x1C4
     m_dwFrameTime             :LongWord;      //0x1DC       //0x1C8
     m_dwStartTime             :LongWord;      //0x1E0       //0x1CC
     m_nMaxTick                :Integer;         //0x1E4
     m_nCurTick                :Integer;         //0x1E8
     m_nMoveStep               :Integer;        //0x1EC
     m_boMsgMuch               :Boolean;            //0x1F0
     m_dwStruckFrameTime       :LongWord;   //0x1F4
     m_nCurrentDefFrame        :Integer;    //0x1F8          //0x1E4
     m_dwDefFrameTime          :LongWord;      //0x1FC       //0x1E8
     m_nDefFrameCount          :Integer;      //0x200        //0x1EC
     //m_nSkipTick               :Integer;           //20080816注释掉起步负重
     m_dwSmoothMoveTime        :LongWord;    //0x208
     m_dwGenAnicountTime       :LongWord;   //0x20C
     m_dwLoadSurfaceTime       :LongWord;   //0x210  //0x200

     m_nOldx                   :Integer;
     m_nOldy                   :Integer;
     m_nOldDir                 :Integer; //0x214 0x218 0x21C
     m_nActBeforeX             :Integer;
     m_nActBeforeY             :Integer;  //0x220 0x224
     m_nWpord                  :Integer;                   //0x228

      procedure CalcActorFrame; dynamic;
      procedure DefaultMotion; dynamic;
      function  GetDefaultFrame (wmode: Boolean): integer; dynamic;
      procedure DrawEffSurface (dsurface, source: TDirectDrawSurface; ddx, ddy: integer; blend: Boolean; ceff: TColorEffect);
      procedure DrawWeaponGlimmer (dsurface: TDirectDrawSurface; ddx, ddy: integer);
   public
      m_MsgList: TGList;       //list of PTChrMsg 0x22C  //0x21C
      RealActionMsg: TChrMsg; //FrmMain    0x230
      constructor Create; dynamic;
      destructor Destroy; override;
      procedure  SendMsg (wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer);
      procedure  UpdateMsg(wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer);
      procedure  CleanUserMsgs;
      procedure  ProcMsg;
      procedure  ProcHurryMsg;
      function   IsIdle: Boolean;
      function   ActionFinished: Boolean;
      function   CanWalk: Integer;
      function   CanRun: Integer;
      procedure  Shift (dir, step, cur, max: integer);
      procedure  ReadyAction (msg: TChrMsg);
      function   CharWidth: Integer;
      function   CharHeight: Integer;
      function   CheckSelect (dx, dy: integer): Boolean;
      procedure  CleanCharMapSetting (x, y: integer);
      procedure  Say (str: string);
      procedure  SetSound; dynamic;
      procedure  Run; dynamic;
      procedure  RunSound; dynamic;
      procedure  RunActSound (frame: integer); dynamic;
      procedure  RunFrameAction (frame: integer); dynamic;  //橇贰烙付促 刀漂窍霸 秦具且老
      procedure  ActionEnded; dynamic;
      function   Move (step: integer): Boolean;
      procedure  MoveFail;
      function   CanCancelAction: Boolean;
      procedure  CancelAction;
      procedure  FeatureChanged; dynamic;
      function   Light: integer; dynamic;
      procedure  LoadSurface; dynamic;
      function   GetDrawEffectValue: TColorEffect;
      procedure  HeroLoginOrLogOut(dsurface: TDirectDrawSurface;dx,dy:integer); dynamic; //召唤英雄动画
      procedure  DrawMyShow(dsurface: TDirectDrawSurface;dx,dy:integer); //通用人自身动画显示 20080113
      procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); dynamic;
      procedure  DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); dynamic;
   end;

   TNpcActor = class (TActor)
   private
     m_nEffX      :Integer; //0x240
     m_nEffY      :Integer; //0x244
     m_bo248      :Boolean; //0x248
     m_dwUseEffectTick    :LongWord; //0x24C
     m_EffSurface       :TDirectDrawSurface; //画NPC 魔法动画效果
     //酒馆2卷老板娘走动  20080621
     m_boNpcWalkEffect  :Boolean;  //是否走动中怪动画效果 
     m_boNpcWalkEffectSurface :TDirectDrawSurface;
     m_nNpcWalkEffectPx :Integer;
     m_nNpcWalkEffectPy :Integer;
   public
     g_boNpcWalk  :Boolean; //NPC走动 20080621
     constructor Create; override;
     destructor Destroy; override;
     procedure  Run; override;
     procedure  CalcActorFrame; override;
     function   GetDefaultFrame (wmode: Boolean): integer; override;
     procedure  LoadSurface; override;
     procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
     procedure  DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override;
   end;

   THumActor = class (TActor)//Size: 0x27C Address: 0x00475BB8
   private
     m_HairSurface         :TDirectDrawSurface; //0x250  //0x240  //头发外观 清清 2007.10.21
     m_WeaponSurface       :TDirectDrawSurface; //0x254  //0x244  //武器外观 清清 2007.10.21
     m_HumWinSurface       :TDirectDrawSurface; //0x258  //0x248  //人物外观 清清 2007.10.21
     m_boWeaponEffect      :Boolean;            //0x25C  //0x24C
     m_nCurWeaponEffect    :Integer;            //0x260  //0x250
     m_nCurBubbleStruck    :Integer;            //0x264  //0x254
     m_nCurProtEctionStruck :Integer;
     m_dwProtEctionStruckTime :Longword;
     
     m_dwWeaponpEffectTime :LongWord;           //0x268
     //m_boHideWeapon        :Boolean;            20080803注释
     m_nFrame              :Integer;
     m_dwFrameTick         :LongWord;
     m_dwFrameTime         :LongWord;
//     m_bo2D0               :Boolean;   //20080721
   protected
      procedure CalcActorFrame; override;
      procedure DefaultMotion; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
   public
      //m_boMagbubble4  :Boolean; //是否是4级魔法盾状态
      constructor Create; override;
      destructor Destroy; override;
      procedure  Run; override;
      procedure  RunFrameAction (frame: integer); override;
      function   Light: integer; override;
      procedure  LoadSurface; override;
      procedure  DoWeaponBreakEffect;
      procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
   end;

   function GetRaceByPM (race: integer;Appr:word): PTMonsterAction;
   function GetOffset (appr: integer): integer;
   function GetNpcOffset(nAppr:Integer):Integer;

implementation

uses
   ClMain, SoundUtil, clEvent, MShare;
constructor TActor.Create;
begin
  inherited Create;
  FillChar(m_Abil,Sizeof(TAbility), 0);
  FillChar(m_Action,SizeOf(m_Action),0);

  m_MsgList           := TGList.Create;
  m_nRecogId          := 0;
  m_BodySurface       := nil;
  m_nGold             := 0;
  m_boVisible         := TRUE;
  m_boHoldPlace       := TRUE;
  m_nCurrentAction    := 0;
  m_boReverseFrame    := FALSE;
  m_nShiftX           := 0;
  m_nShiftY           := 0;
  m_nDownDrawLevel    := 0;
  m_nCurrentFrame     := -1;
  m_nEffectFrame      := -1;

  RealActionMsg.Ident := 0;
  m_sUserName         := '';
  m_nNameColor        := clWhite;
  m_dwSendQueryUserNameTime  := 0; //GetTickCount;
  m_boWarMode                := FALSE;
  m_dwWarModeTime            := 0;    //War mode
  m_boDeath                  := FALSE;
  m_boSkeleton               := FALSE;
  m_boDelActor               := FALSE;
  m_boDelActionAfterFinished := FALSE;

  m_nChrLight                := 0;
  m_nMagLight                := 0;
  m_boLockEndFrame           := FALSE;
  m_dwSmoothMoveTime         := 0; //GetTickCount;
  m_dwGenAnicountTime        := 0;
  m_dwDefFrameTime           := 0;
  m_dwLoadSurfaceTime        := GetTickCount;
  m_boGrouped                := FALSE;
  m_boOpenHealth             := FALSE;
  m_noInstanceOpenHealth     := FALSE;
  m_CurMagic.ServerMagicCode := 0;

  m_nSpellFrame              := DEFSPELLFRAME;

  m_nNormalSound             := -1;
  m_nFootStepSound           := -1; //绝澜  //林牢傍牢版快, CM_WALK, CM_RUN
  m_nAttackSound             := -1;
  m_nWeaponSound             := -1;
  m_nStruckSound             := s_struck_body_longstick;  //嘎阑锭 唱绰 家府    SM_STRUCK
  m_nStruckWeaponSound       := -1;
  m_nScreamSound             := -1;
  m_nDieSound                := -1;    //绝澜    //磷阑锭 唱绰 家府    SM_DEATHNOW
  m_nDie2Sound               := -1;


   m_Skill69NH:=0;//当前内力值 20080930
   m_Skill69MaxNH:=0;//最大内力值 20080930
end;


function GetRaceByPM (race: integer;Appr:word): pTMonsterAction;
begin
   Result := nil;
  case Race of
    9{01}: Result:=@MA9; //未知
    10{02}: Result:=@MA10; //未知
    11{03}: Result:=@MA11; //鸡和鹿
    12{04}: Result:=@MA12; //大刀卫士
    13{05}: Result:=@MA13; //食人花
    14{06}: Result:=@MA14; //骷髅系列怪
    15{07}: Result:=@MA15; //掷斧骷髅
    16{08}: Result:=@MA16; //洞蛆
    17{06}: Result:=@MA14; //多钩猫
    18{06}: Result:=@MA14; //稻草人
    19{0A}: Result:=@MA19; //半兽人、蛤蟆、毒蜘蛛之类的
    20{0A}: Result:=@MA19; //火焰沃玛
    21{0A}: Result:=@MA19; //沃玛教主
    22{07}: Result:=@MA15; //暗黑战士、暴牙蜘蛛
    23{06}: Result:=@MA14; //变异骷髅
    24{04}: Result:=@MA12; //带刀护卫
    30{09}: Result:=@MA17; //未知
    31{09}: Result:=@MA17; //蜜蜂
    32{0F}: Result:=@MA24; //蝎子
    33{10}: Result:=@MA25; //触龙神
    34{11}: Result:=@MA30; //赤月恶魔、宝箱、千年树妖
    35{12}: Result:=@MA31; //未知
    36{13}: Result:=@MA32; //475E48
    37{0A}: Result:=@MA19; //475DDC
    40{0A}: Result:=@MA19; //475DDC
    41{0B}: Result:=@MA20; //475DE8
    42{0B}: Result:=@MA20; //475DE8
    43{0C}: Result:=@MA21; //475DF4
    45{0A}: Result:=@MA19; //475DDC
    47{0D}: Result:=@MA22; //祖玛雕像
    48{0E}: Result:=@MA23; //475E0C
    49{0E}: Result:=@MA23; //祖玛教主
    50{27}: begin//NPC
      case Appr of
        23{01}: Result:=@MA36; //475F77
        24{02}: Result:=@MA37; //475F80
        25{02}: Result:=@MA37; //475F80
        26{00}: Result:=@MA35; //475F9B
        27{02}: Result:=@MA37; //475F80
        28{00}: Result:=@MA35; //475F9B
        29{00}: Result:=@MA35; //475F9B
        30{00}: Result:=@MA35; //475F9B
        31{00}: Result:=@MA35; //475F9B
        32{02}: Result:=@MA37; //475F80
        33{00}: Result:=@MA35; //475F9B
        34{00}: Result:=@MA35; //475F9B
        35{03}: Result:=@MA41; //475F89
        36{03}: Result:=@MA41; //475F89
        37{03}: Result:=@MA41; //475F89
        38{03}: Result:=@MA41; //475F89
        39{03}: Result:=@MA41; //475F89
        40{03}: Result:=@MA41; //475F89
        41{03}: Result:=@MA41; //475F89
        42{04}: Result:=@MA46; //475F92
        43{04}: Result:=@MA46; //475F92
        44{04}: Result:=@MA46; //475F92
        45{04}: Result:=@MA46; //475F92
        46{04}: Result:=@MA46; //475F92
        47{04}: Result:=@MA46; //475F92
        48{03}: Result:=@MA41; //4777B3
        49{03}: Result:=@MA41; //4777B3
        50{03}: Result:=@MA41; //4777B3
        51{00}: Result:=@MA35; //4777C5
        52{03}: Result:=@MA41; //4777B3
        53{03}: Result:=@MA35; //酒神弟子 20081024
        54..58: Result:=@MA50; //雪域
        59    : Result:=@MA51; //雪域
        62    : Result:=@MA70; //神秘宝藏  20080301
        65..66: Result:=@MA70;  //火龙宝箱  20080301
        70..75: Result:=@MA70;  //卧龙NPC
        90..92: Result:=@MA70; //卧龙里的空宝箱NPC  20080301
        82..84: Result:=@MA71; //酒馆3个人物NPC 20080308
        else Result:=@MA35;
      end;
    end;

    52{0A}: Result:=@MA19; //475DDC
    53{0A}: Result:=@MA19; //475DDC
    54{14}: Result:=@MA28; //475E54
    55{15}: Result:=@MA29; //475E60
    60{16}: Result:=@MA33; //475E6C
    61{16}: Result:=@MA33; //475E6C
    62{16}: Result:=@MA33; //475E6C
    63{17}: Result:=@MA34; //475E78
    64{18}: Result:=@MA19; //475E84
    65{18}: Result:=@MA19; //475E84
    66{18}: Result:=@MA19; //475E84
    67{18}: Result:=@MA19; //475E84
    68{18}: Result:=@MA19; //475E84
    69{18}: Result:=@MA19; //475E84
    70{19}: Result:=@MA33; //475E90
    71{19}: Result:=@MA33; //475E90
    72{19}: Result:=@MA33; //475E90
    73{1A}: Result:=@MA19; //475E9C
    74{1B}: Result:=@MA19; //475EA8
    75{1C}: Result:=@MA39; //475EB4
    76{1D}: Result:=@MA38; //475EC0
    77{1E}: Result:=@MA39; //475ECC
    78{1F}: Result:=@MA40; //475ED8
    79{20}: Result:=@MA19; //475EE4
    80{21}: Result:=@MA42; //475EF0
    81{22}: Result:=@MA43; //475EFC
    83{23}: Result:=@MA44; //火龙教主  20080305
    84{24}: Result:=@MA45; //475F14
    85{24}: Result:=@MA45; //475F14
    86{24}: Result:=@MA45; //475F14
    87{24}: Result:=@MA45; //475F14
    88{24}: Result:=@MA45; //475F14
    89{24}: Result:=@MA45; //475F14
    90{11}: Result:=@MA30; //475E30
    98{25}: Result:=@MA27; //475F20
    99{26}: Result:=@MA26; //475F29
    91{27}: Result:=@MA49;
    92: Result := @MA19;   //金杖蜘蛛
    93: Result := @MA93;  //雷炎蛛王
    100{28}: Result:=@MA100//月灵
  end

end;

//根据种族和外貌确定在图片库中的开始位置
function GetOffset (appr: integer): integer;
var
   nrace, npos: integer;
begin
   Result := 0;
   if (appr >= 1000) then Exit;
   nrace := appr div 10;         //图片库
   npos := appr mod 10;          //图片库中的形象序号
   case nrace of
      0:    Result := npos * 280;
      1:    Result := npos * 230;
      2,3,7..12:    Result := npos * 360;
      4:    begin
               Result := npos * 360;        //
               if npos = 1 then Result := 600;
            end;
      5:    Result := npos * 430;   //
      6:    Result := npos * 440;   //
//      13:   Result := npos * 360;
      13: case npos of
            0: Result:= 0;
            1: Result:= 360;
            2: Result:= 440;
            3: Result:= 550;
            else Result:= npos * 360;
          end;
      14:   Result := npos * 360;
      15:   Result := npos * 360;
      16:   Result := npos * 360;
      17:   case npos of  
               2: Result := 920;
               else Result := npos * 350;
            end;
      18:   case npos of  //20080508修改    魔龙系列怪
              { 0: Result := 0;   //己巩
               1: Result := 520;
               2: Result := 950;   }
               0: Result := 0;
               1: Result := 520;
               2: Result := 950;
               3: Result := 1574;
               4: Result := 1934;
               5: Result := 2294;
               6: Result := 2654;
               7: Result := 3014;
            end;
      19:   case npos of
               0: Result := 0;   //己巩
               1: Result := 370;
               2: Result := 810;
               3: Result := 1250;
               4: Result := 1630;
               5: Result := 2010;
               6: Result := 2390;
            end;
      20:   case npos of
               0: Result := 0;   //己巩
               1: Result := 360;
               2: Result := 720;
               3: Result := 1080;
               4: Result := 1440;
               5: Result := 1800;
               6: Result := 2350;
               7: Result := 3060;
            end;
      21:   case npos of
               0: Result := 0;   //己巩
               1: Result := 460;
               2: Result := 820;
               3: Result := 1180;
               4: Result := 1540;
               5: Result := 1900;
//               6: Result := 2260;
               6: Result := 2440;
               7: Result := 2570;
               8: Result := 2700;
            end;
      22:   case npos of
               0: Result := 0;
               1: Result := 430;
               2: Result := 1290;
               3: Result := 1810;
            end;
      23:   case npos of    //20080328 24.wil 扩展
               0: Result := 0;
               1: Result := 340;
               2: Result := 680;
               3: Result := 1180;
               4: Result := 1770;
               5: Result := 2610;
               6: Result := 2950;
               7: Result := 3290;
               8: Result := 3750;
               9: Result := 4100;
              10: Result := 4460;
              11: Result := 4810;
            end;
      24:   case npos of    //20081213 25.wil扩展
               0: Result := 0;
               1: Result := 510;
            end;
      25:   case npos of   //20081213 26.wil扩展
               0: Result := 0;
               1: Result := 510;
               2: Result := 1020;
               3: Result := 1370;
               4: Result := 1720;
               5: Result := 2070;
               6: Result := 2740;
               7: Result := 3780;
               8: Result := 3820;
               9: Result := 4170;
            end;
      26:   case npos of  //20081213 27.wil扩展
               0: Result := 0;
               1: Result := 340;
               2: Result := 680;
               3: Result := 1190;
               4: Result := 1930;
               5: Result := 2100;
               6: Result := 2440;
            end;

      49,50,51,52,53: Result := npos * 360;
      80:   case npos of
               0: Result := 0;   //己巩
               1: Result := 80;
               2: Result := 300;
               3: Result := 301;
               4: Result := 302;
               5: Result := 320;
               6: Result := 321;
               7: Result := 322;
               8: Result := 321;
            end;
      90:   case npos of
               0: Result := 80;   //己巩
               1: Result := 168;
               2: Result := 184;
               3: Result := 200;
            end;
   end;
end;
function GetNpcOffset(nAppr:Integer):Integer;
begin
  Result:=0;
  case nAppr of
    24,25: Result:=(nAppr - 24) * 60 + 1470;
    0..22: Result:=nAppr * 60;
    23: Result:=1380;
    27,32: Result:=(nAppr - 26) * 60 + 1620 - 30;
    26,28,29,30,31,33..41: Result:=(nAppr - 26) * 60 + 1620;
    42,43: Result:=2580;
    44..47: Result:=2640;
    48..50: Result:=(nAppr - 48) * 60 + 2700;
    51: Result:=2880;
    52: Result:=2960;
    53: Result:=4180;
    //雪域NPC
    54: Result:=4490;
    55: Result:=4500;
    56: Result:=4510;
    57: Result:=4520;
    58: Result:=4530;
    59: Result:=4540;

    //卧龙
    70: Result:=3780;
    71: Result:=3790;
    72: Result:=3800;
    73: Result:=3810;
    74: Result:=3820;
    75: Result:=3830;
    90: Result:=3750; //卧龙里的空宝箱NPC  20080301
    91: Result:=3760; //卧龙里的空宝箱NPC  20080301
    92: Result:=3770; //卧龙里的空宝箱NPC  20080301
    65: Result:=3360; //火龙宝箱 NPC 20080301 方位1
    66: Result:=3380; //火龙宝箱 NPC 20080301 方位2
    62: Result:=3180; //神秘宝藏 NPC 20080301
    80: Result:=3840; //酒馆的店小二 20080308
    81: Result:=3900; //酒馆老板娘  20080308
    82: Result:=3960; //酒馆影月 20080308
    83: Result:=3980; //酒馆辰星 20080308
    84: Result:=4000; //酒馆翔天 20080308
  end;
end;

destructor TActor.Destroy;
var
  I: Integer;
begin
  if m_MsgList.Count > 0 then //20080629
  for I := 0 to m_MsgList.Count - 1 do begin
    if pTChrMsg(m_MsgList.Items[I]) <> nil then Dispose(pTChrMsg(m_MsgList.Items[I]));
  end;
  m_MsgList.Clear;
  FreeAndNil(m_MsgList);
  inherited Destroy;
end;


//角色接收到的消息
procedure  TActor.SendMsg(wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer);
var
  Msg:pTChrMsg;
begin
  m_MsgList.Lock;
  try
  New(Msg);
  Msg.ident   := wIdent;
  Msg.x       := nX;
  Msg.y       := nY;
  Msg.dir     := ndir;
  Msg.feature := nFeature;
  Msg.state   := nState;
  Msg.saying  := sStr;
  Msg.Sound   := nSound;
    m_MsgList.Add(Msg);
  finally
    m_MsgList.UnLock;
  end;
end;

//用新消息更新（若已经存在）消息列表
procedure TActor.UpdateMsg(wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer);
var
  I: integer;
  Msg:pTChrMsg;
begin
  m_MsgList.Lock;
  try
    I:= 0;
    while TRUE do begin
      //从当前消息列表中寻找,若找到,则删除,同时清除当前玩家控制的角色的走、跑等消息，因为这些消息已经处理了。
      if I >= m_MsgList.Count then break;
      Msg:=m_MsgList.Items[I]; //原代码
      if ((Self = g_MySelf) and (Msg.Ident >= 3000) and (Msg.Ident <= 3099)) or (Msg.Ident = wIdent) then begin
        Dispose(Msg);       //删除已经存在的相同消息
        m_MsgList.Delete(I);
        Continue;
      end;
      Inc(I);
    end;
  finally
    m_MsgList.UnLock;
  end;
  SendMsg (wIdent,nX,nY,nDir,nFeature,nState,sStr,nSound);   //添加消息
end;

//清除消息号在[3000,3099]之间的消息
procedure TActor.CleanUserMsgs;
var
  I:Integer;
  Msg:pTChrMsg;
begin
  m_MsgList.Lock;
  try
    I:= 0;
    while TRUE do begin
      if I >= m_MsgList.Count then break;
      Msg:=m_MsgList.Items[I]; 
      {if (Msg.Ident >= 3000) and //基本运动消息：走、跑等
         (Msg.Ident <= 3099) then begin }
       if (Msg.Ident > 2999) and //基本运动消息：走、跑等
         (Msg.Ident < 3100) then begin
        Dispose(Msg); 
        m_MsgList.Delete (I);
        Continue;
      end;
      Inc(I);
    end;
  finally
    m_MsgList.UnLock;
  end;
end;

//角色动作动画
procedure TActor.CalcActorFrame;
begin
  m_boUseMagic    := FALSE;
  m_nCurrentFrame := -1;
  //根据appr计算本角色在图片库中的开始图片索引
  m_nBodyOffset   := GetOffset (m_wAppearance);
  //动作对应的图片序列定义
  m_Action := GetRaceByPM(m_btRace,m_wAppearance);
  if m_Action = nil then exit;

   case m_nCurrentAction of
      SM_TURN://转身=站立动作的开始帧 + 方向 X 站立动作的图片数
         begin
            m_nStartFrame := m_Action.ActStand.start + m_btDir * (m_Action.ActStand.frame + m_Action.ActStand.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActStand.frame - 1;
            m_dwFrameTime := m_Action.ActStand.ftime;
            m_dwStartTime := GetTickCount;
            m_nDefFrameCount := m_Action.ActStand.frame;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_WALK{走}, SM_RUSH, SM_RUSHKUNG, SM_BACKSTEP:  //走动=走动动作的开始帧 + 方向 X 每方向走动动作的图片数
         begin
            m_nStartFrame := m_Action.ActWalk.start + m_btDir * (m_Action.ActWalk.frame + m_Action.ActWalk.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActWalk.frame - 1;
            m_dwFrameTime := m_Action.ActWalk.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := m_Action.ActWalk.UseTick;
            m_nCurTick := 0;
            m_nMoveStep := 1;
            if m_nCurrentAction = SM_BACKSTEP then    //转身
               Shift (GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1)
            else
               Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
         end;
      {SM_BACKSTEP:
         begin
            startframe := pm.ActWalk.start + (pm.ActWalk.frame - 1) + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
            m_nEndFrame := startframe - (pm.ActWalk.frame - 1);
            m_dwFrameTime := pm.ActWalk.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := pm.ActWalk.UseTick;
            m_nCurTick := 0;
            m_nMoveStep := 1;
            Shift (GetBack(Dir), m_nMoveStep, 0, m_nEndFrame-startframe+1);
         end;}
      SM_HIT{普通攻击}:
         begin
            m_nStartFrame := m_Action.ActAttack.start + m_btDir * (m_Action.ActAttack.frame + m_Action.ActAttack.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActAttack.frame - 1;
            m_dwFrameTime := m_Action.ActAttack.ftime;
            m_dwStartTime := GetTickCount;
            //WarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_STRUCK:{受攻击}
         begin
            m_nStartFrame := m_Action.ActStruck.start + m_btDir * (m_Action.ActStruck.frame + m_Action.ActStruck.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActStruck.frame - 1;
            m_dwFrameTime := m_dwStruckFrameTime; //pm.ActStruck.ftime;
            m_dwStartTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_DEATH:   //被打死
         begin
            m_nStartFrame := m_Action.ActDie.start + m_btDir * (m_Action.ActDie.frame + m_Action.ActDie.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActDie.frame - 1;
            m_nStartFrame := m_nEndFrame; //
            m_dwFrameTime := m_Action.ActDie.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_NOWDEATH: //死了
         begin
            m_nStartFrame := m_Action.ActDie.start + m_btDir * (m_Action.ActDie.frame + m_Action.ActDie.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActDie.frame - 1;
            m_dwFrameTime := m_Action.ActDie.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_SKELETON:  //彻底死了（不再动作）
         begin
            m_nStartFrame := m_Action.ActDeath.start + m_btDir;
            m_nEndFrame := m_nStartFrame + m_Action.ActDeath.frame - 1;
            m_dwFrameTime := m_Action.ActDeath.ftime;
            m_dwStartTime := GetTickCount;
         end;
   end;
end;

procedure TActor.ReadyAction (msg: TChrMsg);
var
   n: integer;
   UseMagic: PTUseMagicInfo;
begin
   m_nActBeforeX := m_nCurrX;        //动作之前的位置（当服务器不认可时可以回去)
   m_nActBeforeY := m_nCurrY;

   if msg.Ident = SM_ALIVE then begin      //复活
      m_boDeath := FALSE;
      m_boSkeleton := FALSE;
   end;
   if not m_boDeath then begin
      case msg.Ident of
         SM_TURN, SM_WALK, SM_NPCWALK, SM_BACKSTEP, SM_RUSH, SM_RUSHKUNG, SM_RUN, {SM_HORSERUN,20080803注释骑马消息} SM_DIGUP, SM_ALIVE:
            begin
               m_nFeature := msg.feature;
               m_nState := msg.state;
               //是否可以查看角色生命值
               if m_nState and STATE_OPENHEATH <> 0 then m_boOpenHealth := TRUE
               else m_boOpenHealth := FALSE;
            end;
      end;
      if msg.ident = SM_LIGHTING then n := 0;
      if (g_MySelf = self) then begin
         if (msg.Ident = CM_WALK) then
            if not PlayScene.CanWalk (msg.x, msg.y) then
               exit;  //不可行走
         if (msg.Ident = CM_RUN) then
            if not PlayScene.CanRun (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, msg.x, msg.y) then
               exit; //不能跑
         {if (msg.Ident = CM_HORSERUN) then  20080803注释骑马消息
            if not PlayScene.CanRun (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, msg.x, msg.y) then
               exit;   }
         //msg
         case msg.Ident of
            CM_TURN,
            CM_WALK,
            CM_SITDOWN,
            CM_RUN,
            CM_HIT,
            CM_HEAVYHIT,
            CM_BIGHIT,
            CM_POWERHIT,
            CM_LONGHIT,
            CM_WIDEHIT:
               begin
                  RealActionMsg := msg; //保存当前动作
                  msg.Ident := msg.Ident - 3000;  //SM_?? 栏肺 函券 窃
               end;
            {CM_HORSERUN: begin  20080803注释骑马消息
              RealActionMsg:=msg;
              msg.Ident:=SM_HORSERUN;
            end; }
            CM_THROW: begin
              if m_nFeature <> 0 then begin
                m_nTargetX := TActor(msg.feature).m_nCurrX;  //x 带瘤绰 格钎
                m_nTargetY := TActor(msg.feature).m_nCurrY;    //y
                m_nTargetRecog := TActor(msg.feature).m_nRecogId;
              end;
              RealActionMsg := msg;
              msg.Ident := SM_THROW;
            end;
            CM_FIREHIT: begin  //烈火
              RealActionMsg := msg;
              msg.Ident := SM_FIREHIT;
            end;
            CM_4FIREHIT: begin  //4级烈火
              RealActionMsg := msg;
              msg.Ident := SM_4FIREHIT;
            end;
            CM_DAILY: begin //逐日剑法 20080511
              RealActionMsg := msg;
              msg.Ident := SM_DAILY;
            end;
            CM_CRSHIT: begin
              RealActionMsg := msg;
              msg.Ident := SM_CRSHIT;
            end;
            CM_TWINHIT: begin
              RealActionMsg := msg;
              msg.Ident := SM_TWINHIT;
            end;
            CM_QTWINHIT: begin   //开天斩轻击 2008.02.12
              RealActionMsg := msg;
              msg.Ident := SM_QTWINHIT;
            end;
            CM_CIDHIT: begin {龙影剑法}
              RealActionMsg := msg;
              msg.Ident := SM_CIDHIT;
            end;
            CM_3037: begin
              RealActionMsg := msg;
              msg.Ident := SM_41;
            end;
            CM_SPELL: begin
                  RealActionMsg := msg;
                  UseMagic := PTUseMagicInfo (msg.feature);   //根据msg.feature获得pmag指针
                  RealActionMsg.Dir := UseMagic.MagicSerial;
                  msg.Ident := msg.Ident - 3000;  //SM_?? 栏肺 函券 窃
            end;
         end;
         m_nOldx := m_nCurrX;
         m_nOldy := m_nCurrY;
         m_nOldDir := m_btDir;
      end;
      case msg.Ident of
         SM_STRUCK:
            begin
               //Abil.HP := msg.x; {HP}
               //Abil.MaxHP := msg.y; {maxHP}
               //msg.dir {damage}
               m_nMagicStruckSound := msg.x; 
               n := Round (200 - m_Abil.Level * 5);
               if n > 80 then m_dwStruckFrameTime := n
               else m_dwStruckFrameTime := 80;
               //m_dwLastStruckTime := GetTickCount;  20080521 注释没用到变量
            end;
         SM_SPELL:
            begin
               m_btDir := msg.dir;
               //msg.x  :targetx
               //msg.y  :targety
               UseMagic := PTUseMagicInfo (msg.feature);
               if UseMagic <> nil then begin
                  m_CurMagic := UseMagic^;
                  m_CurMagic.ServerMagicCode := -1; //FIRE 措扁
                  //CurMagic.MagicSerial := 0;
                  m_CurMagic.TargX := msg.x;
                  m_CurMagic.TargY := msg.y;
                  Dispose (UseMagic);
               end;
            end;
         SM_RUSHKUNG: begin  //20080409  防止英雄用野蛮消失
               m_nFeature := msg.feature;
               m_nState := msg.state;
               //是否可以查看角色生命值
               if m_nState and STATE_OPENHEATH <> 0 then m_boOpenHealth := TRUE
               else m_boOpenHealth := FALSE;
         end;
         else begin  //此句是用技能失败 人物跑到消息坐标去  20080409
               m_nCurrX := msg.x;
               m_nCurrY := msg.y;
               m_btDir := msg.dir;
            end;
      end;

      m_nCurrentAction := msg.Ident;
      CalcActorFrame;
      //DScreen.AddSysMsg (IntToStr(msg.Ident) + ' ' + IntToStr(XX) + ' ' + IntToStr(YY) + ' : ' + IntToStr(msg.x) + ' ' + IntToStr(msg.y));
   end else begin
      if msg.Ident = SM_SKELETON then begin
         m_nCurrentAction := msg.Ident;
         CalcActorFrame;
         m_boSkeleton := TRUE;
      end;
   end;
   if (msg.Ident = SM_DEATH) or (msg.Ident = SM_NOWDEATH) then begin
      m_boDeath := TRUE;
      //m_dwDeathTime := GetTickCount;
      PlayScene.ActorDied (self);
   end;
   RunSound;
end;


function TActor.GetMessage(ChrMsg:pTChrMsg): Boolean;
var
  Msg:pTChrMsg;
begin
  Result:=False;
  m_MsgList.Lock;
  try
    if m_MsgList.Count > 0 then begin
      Msg:=pTChrMsg(m_MsgList.Items[0]);
      ChrMsg.Ident:=Msg.Ident;
      ChrMsg.X:=Msg.X;
      ChrMsg.Y:=Msg.Y;
      ChrMsg.Dir:=Msg.Dir;
      ChrMsg.State:=Msg.State;
      ChrMsg.feature:=Msg.feature;
      ChrMsg.saying:=Msg.saying;
      ChrMsg.Sound:=Msg.Sound;
      Dispose(Msg);
      m_MsgList.Delete(0);
      Result:=True;
    end;
  finally
    m_MsgList.UnLock;
  end;
end;

procedure TActor.ProcMsg;
var
  Msg:TChrMsg;
  Meff:TMagicEff;
begin
   while (m_nCurrentAction = 0) and GetMessage(@Msg) do begin
      case Msg.ident of
         SM_STRUCK: begin
           m_nHiterCode := msg.Sound;
           ReadyAction (msg);
         end;
         SM_DEATH,  //27
         SM_NOWDEATH,
         SM_SKELETON,
         SM_ALIVE,
         SM_ACTION_MIN..SM_ACTION_MAX,  //26
         SM_ACTION2_MIN..SM_ACTION2_MAX,//35   2293    293
         SM_NPCWALK,
         3000..3099: ReadyAction (msg);

         SM_SPACEMOVE_HIDE: begin  //修改传送地图不显示动画 20080521
           meff := TScrollHideEffect.Create (250, 10, m_nCurrX, m_nCurrY, self);
           PlayScene.m_EffectList.Add (meff);
           PlaySound (s_spacemove_out);
          {if g_TargetCret <> nil then
            PlayScene.DeleteActor (g_TargetCret.m_nRecogId);  }
         end;
         SM_SPACEMOVE_HIDE2: begin
           meff := TScrollHideEffect.Create (1590, 10, m_nCurrX, m_nCurrY, self);
           PlayScene.m_EffectList.Add (meff);
           PlaySound (s_spacemove_out);
         end;
         SM_SPACEMOVE_SHOW: begin  //修改传送地图不显示动画 20080521
           meff := TCharEffect.Create (260, 10, self);
           PlayScene.m_EffectList.Add (meff);
           msg.ident := SM_TURN;
           ReadyAction (msg);
           PlaySound (s_spacemove_in);
         end;
         SM_SPACEMOVE_SHOW2: begin
           meff := TCharEffect.Create (1600, 10, self);
           PlayScene.m_EffectList.Add (meff);
           msg.ident := SM_TURN;
           ReadyAction (msg);
           PlaySound (s_spacemove_in);
         end;
         SM_CRSHIT,SM_TWINHIT,SM_QTWINHIT,SM_CIDHIT, SM_4FIREHIT,SM_FAIRYATTACKRATE,SM_DAILY{逐日剑法},SM_LEITINGHIT{雷霆一击战士效果 20080611}: ReadyAction (msg); //解决英雄放开天龙影 看不到问题
         else
            begin
               //ReadyAction (msg); //解决人物改变地图黑屏问题 20080410
            end;
      end;
   end;

end;

procedure TActor.ProcHurryMsg; //紧急消息处理：使用魔法、魔法失败
var
   n: integer;
   msg: TChrMsg;
   fin: Boolean;
begin
   n := 0;
   while TRUE do begin    
      if m_MsgList.Count <= n then break;
      msg := PTChrMsg (m_MsgList[n])^;   //取出消息
      fin := FALSE;
      case msg.Ident of
         SM_MAGICFIRE: begin
            if m_CurMagic.ServerMagicCode <> 0 then begin
               m_CurMagic.ServerMagicCode := 111;
               m_CurMagic.Target := msg.x;
               if msg.y in [0..MAXMAGICTYPE-1] then
               m_CurMagic.EffectType := TMagicType(msg.y); //EffectType
               m_CurMagic.EffectNumber := msg.dir; //Effect
               m_CurMagic.TargX := msg.feature;
               m_CurMagic.TargY := msg.state;
               m_CurMagic.Recusion := TRUE;
               fin := TRUE;
               //这里可以显示使用魔法的名称，但是客户端不知道魔法的名称，
               //应该在本地保留一个魔法名称列表，根据ServerMaigicCode获得名称
            end;
         end;
         SM_MAGICFIRE_FAIL:
            if m_CurMagic.ServerMagicCode <> 0 then begin
               m_CurMagic.ServerMagicCode := 0;
               fin := TRUE;
            end;
      end;
      if fin then begin
         Dispose (PTChrMsg (m_MsgList[n]));
         m_MsgList.Delete (n);
      end else
         Inc (n);
   end;
end;
//当前是否没有可执行的动作
function  TActor.IsIdle: Boolean;
begin
   if (m_nCurrentAction = 0) and (m_MsgList.Count = 0) then
      Result := TRUE
   else Result := FALSE;
end;
//当前动作是否已经完成
function  TActor.ActionFinished: Boolean;
begin
   if (m_nCurrentAction = 0) or (m_nCurrentFrame >= m_nEndFrame) then
      Result := TRUE
   else Result := FALSE;
end;
//可否行走
function  TActor.CanWalk: Integer;
begin
   if {(GetTickCount - LastStruckTime < 1300) or}(GetTickCount - g_dwLatestSpellTick < g_dwMagicPKDelayTime) then
      Result := -1   
   else
      Result := 1;
end;
//可否跑
function  TActor.CanRun: Integer;
begin
   Result := 1;
   //检查人物的HP值是否低于指定值，低于指定值将不允许跑
   if m_Abil.HP < RUN_MINHEALTH then begin
      Result := -1;
   end else
   //检查人物是否被攻击，如果被攻击将不允许跑，取消检测将可以跑步逃跑
//   if (GetTickCount - LastStruckTime < 3*1000) or (GetTickCount - LatestSpellTime < MagicPKDelayTime) then
//      Result := -2;

end;


//dir : 方向
//step : 步长  (走是1，跑是2）
//cur : 当前帧(全部帧中的第几帧）
//max : 全部帧
procedure TActor.Shift (dir, step, cur, max: integer);
var
   unx, uny, ss, v: integer;
begin
   unx := UNITX * step;
   uny := UNITY * step;
   if cur > max then cur := max;
   m_nRx := m_nCurrX;
   m_nRy := m_nCurrY;
//   ss := Round((max-cur-1) / max) * step;
   case dir of
      DR_UP: begin
        ss := Round((max-cur) / max) * step;
        m_nShiftX := 0;
        m_nRy := m_nCurrY + ss;
        if ss = step then m_nShiftY := -Round(uny / max * cur)
        else m_nShiftY := Round(uny / max * (max-cur));
      end;
      DR_UPRIGHT:
         begin
            if max >= 6 then v := 2
            else v := 0;
            ss := Round((max-cur+v) / max) * step;
            m_nRx := m_nCurrX - ss;
            m_nRy := m_nCurrY + ss;
            if ss = step then begin
               m_nShiftX:=  Round(unx / max * cur);
               m_nShiftY:= -Round(uny / max * cur);
            end else begin
               m_nShiftX:= -Round(unx / max * (max-cur));
               m_nShiftY:=  Round(uny / max * (max-cur));
            end;
         end;
      DR_RIGHT:
         begin
            ss := Round((max-cur) / max) * step;
            m_nRx := m_nCurrX - ss;
            if ss = step then m_nShiftX := Round(unx / max * cur)
            else m_nShiftX := -Round(unx / max * (max-cur));
            m_nShiftY := 0;
         end;
      DR_DOWNRIGHT:
         begin
            if max >= 6 then v := 2
            else v := 0;
            ss := Round((max-cur-v) / max) * step;
            m_nRx := m_nCurrX - ss;
            m_nRy := m_nCurrY - ss;
            if ss = step then begin
               m_nShiftX:= Round(unx / max * cur);
               m_nShiftY:= Round(uny / max * cur);
            end else begin
               m_nShiftX:= -Round(unx / max * (max-cur));
               m_nShiftY:= -Round(uny / max * (max-cur));
            end;
         end;
      DR_DOWN:
         begin
            if max >= 6 then v := 1
            else v := 0;
            ss := Round((max-cur-v) / max) * step;
            m_nShiftX := 0;
            m_nRy := m_nCurrY - ss;
            if ss = step then m_nShiftY := Round(uny / max * cur)
            else m_nShiftY := -Round(uny / max * (max-cur));
         end;
      DR_DOWNLEFT:
         begin
            if max >= 6 then v := 2
            else v := 0;
            ss := Round((max-cur-v) / max) * step;
            m_nRx := m_nCurrX + ss;
            m_nRy := m_nCurrY - ss;
            if ss = step then begin
               m_nShiftX := -Round(unx / max * cur);
               m_nShiftY :=  Round(uny / max * cur);
            end else begin
               m_nShiftX :=  Round(unx / max * (max-cur));
               m_nShiftY := -Round(uny / max * (max-cur));
            end;
         end;
      DR_LEFT:
         begin
            ss := Round((max-cur) / max) * step;
            m_nRx := m_nCurrX + ss;
            if ss = step then m_nShiftX := -Round(unx / max * cur)
            else m_nShiftX := Round(unx / max * (max-cur));
            m_nShiftY := 0;
         end;
      DR_UPLEFT:
         begin
            if max >= 6 then v := 2
            else v := 0;
            ss := Round((max-cur+v) / max) * step;
            m_nRx := m_nCurrX + ss;
            m_nRy := m_nCurrY + ss;
            if ss = step then begin
               m_nShiftX := -Round(unx / max * cur);
               m_nShiftY := -Round(uny / max * cur);
            end else begin
               m_nShiftX := Round(unx / max * (max-cur));
               m_nShiftY := Round(uny / max * (max-cur));
            end;
         end;
   end;
end;
//人物外貌特征改变
procedure  TActor.FeatureChanged;
var
   haircount: integer;
begin
   case m_btRace of
      0,1,150: begin //人物,英雄,人型 20080629
         m_btHair   := HAIRfeature (m_nFeature);// 得到M2发来对应的发型 , 女=7 男=6 主体,英雄 女=3 男=4
         m_btDress  := DRESSfeature (m_nFeature);
         m_btWeapon := WEAPONfeature (m_nFeature);
         //m_btHorse  := Horsefeature(m_nFeatureEx); 20080721 注释骑马
         m_btEffect := Effectfeature(m_nFeatureEx);
         m_nBodyOffset := HUMANFRAME * m_btDress; //男0, 女1
         haircount := g_WHairImgImages.ImageCount div {HUMANFRAME}1200 div 2; //每性别发型数=3600 /600 /2 =3
        if m_btHair = High(m_btHair) then begin //斗笠
            m_nHairOffset := HUMANFRAME*(m_btSex + 6);
        end else 
        if m_btHair = 254 then begin     //金色斗笠为254
            m_nHairOffset := HUMANFRAME * (m_btSex + 8);
        end else begin
              if m_btSex = 1 then begin //女
                if m_btHair = 1 then m_nHairOffset := 600
                else begin
                   if m_btHair > haircount-1 then m_btHair := haircount-1;
                   m_btHair := m_btHair * 2;
                   if m_btHair > 1 then
                      m_nHairOffset := HUMANFRAME * (m_btHair + m_btSex)
                   else m_nHairOffset := -1;
                end;
              end else begin                 //男
                if m_btHair = 0 then m_nHairOffset := -1
                else begin
                   if m_btHair > haircount-1 then m_btHair := haircount-1;
                   m_btHair := m_btHair * 2;
                   if m_btHair > 1 then
                      m_nHairOffset := HUMANFRAME * (m_btHair + m_btSex)
                   else m_nHairOffset := -1;
                end;
              end;
          end;

         m_nWeaponOffset := HUMANFRAME * m_btWeapon; //(weapon*2 + m_btSex);

        if m_btEffect <> 0 then begin
          if m_btEffect = 50 then m_nHumWinOffset:=352
          else m_nHumWinOffset:=(m_btEffect - 1) * HUMANFRAME;
        end;
      end;
      50: ;  //npc
      else begin
         m_wAppearance := APPRfeature (m_nFeature);
         m_nBodyOffset := GetOffset (m_wAppearance);
      end;
   end;
end;

function   TActor.Light: integer;
begin
   Result := m_nChrLight;
end;
//装载当前动作对应的图片
procedure  TActor.LoadSurface;
var
   mimg: TWMImages;
begin
   mimg := GetMonImg (m_wAppearance);
   if mimg <> nil then begin
      if (not m_boReverseFrame) then begin
         m_BodySurface := mimg.GetCachedImage (GetOffset (m_wAppearance) + m_nCurrentFrame, m_nPx, m_nPy);
      end else begin
         m_BodySurface := mimg.GetCachedImage (
                            GetOffset (m_wAppearance) + m_nEndFrame - (m_nCurrentFrame-m_nStartFrame),
                            m_nPx, m_nPy);

      end;
   end;
end;
//取角色的宽度
function  TActor.CharWidth: Integer;
begin
   if m_BodySurface <> nil then
      Result := m_BodySurface.Width
   else Result := 48;
end;
//取角色的高度
function  TActor.CharHeight: Integer;
begin
   if m_BodySurface <> nil then
      Result := m_BodySurface.Height
   else Result := 70;
end;
//判断某一点是否是角色的身体
function  TActor.CheckSelect (dx, dy: integer): Boolean;
var
  c:Integer;
begin
  Result := FALSE;
  if m_BodySurface <> nil then begin
    c := m_BodySurface.Pixels[dx, dy];
    if (c <> 0) and
       ((m_BodySurface.Pixels[dx-1, dy] <> 0) and
       (m_BodySurface.Pixels[dx+1, dy] <> 0) and
       (m_BodySurface.Pixels[dx, dy-1] <> 0) and
       (m_BodySurface.Pixels[dx, dy+1] <> 0)) then
     Result := TRUE;
  end;
end;

procedure TActor.DrawEffSurface (dsurface, source: TDirectDrawSurface; ddx, ddy: integer; blend: Boolean; ceff: TColorEffect);
var
  ErrorCode: Integer;
begin
  try
    //隐身
     ErrorCode := 0;
     if m_nState and $00800000 <> 0 then blend := TRUE;  //混合显示
     ErrorCode := 1;
     if source.Height > 350 then begin  //20080608 修正火龙教主引起的程序崩溃
       drawex(dsurface, ddx, ddy, source, 0, 0, source.Width, source.Height, 0);
       Exit; ////thedeath
     end;
     ErrorCode := 2;
     if source <> nil then begin
       if not Blend then begin
          if ceff = ceNone then begin    //色彩无效果，以透明效果直接显示
                ErrorCode := 3;
                dsurface.Draw (ddx, ddy, source.ClientRect, source, TRUE);
                ErrorCode := 4;
          end else begin
                //生成颜色混合效果，再画出
                ErrorCode := 5;
                g_ImgMixSurface.Draw (0, 0, source.ClientRect, source, FALSE);
                ErrorCode := 6;
                DrawEffect (0, 0, source.Width, source.Height, g_ImgMixSurface, ceff);
                ErrorCode := 7;
                dsurface.Draw (ddx, ddy, source.ClientRect, g_ImgMixSurface, TRUE);
                ErrorCode := 8;
          end;
       end else begin
          if ceff = ceNone then begin
                ErrorCode := 9;
                DrawBlend (dsurface, ddx, ddy, source, 0);
          end else begin
                ErrorCode := 10;
                g_ImgMixSurface.Fill(0);
                ErrorCode := 11;
                g_ImgMixSurface.Draw (0, 0, source.ClientRect, source, FALSE);
                ErrorCode := 12;
                DrawEffect (0, 0, source.Width, source.Height, g_ImgMixSurface, ceff);
                ErrorCode := 13;
                DrawBlend (dsurface, ddx, ddy, g_ImgMixSurface, 0);
                ErrorCode := 14;
          end;
       end;
     end;
   except
     DebugOutStr('TActor.DrawEffSurface'+IntToStr(ErrorCode));
   end;
end;
//画武器闪烁光
procedure TActor.DrawWeaponGlimmer (dsurface: TDirectDrawSurface; ddx, ddy: integer);
//var
//   idx, ax, ay: integer;
//   d: TDirectDrawSurface;
begin
   //荤侩救窃..(堪拳搬) 弊贰侨 坷幅...
   (*if BoNextTimeFireHit and WarMode and GlimmingMode then begin
      if GetTickCount - GlimmerTime > 200 then begin
         GlimmerTime := GetTickCount;
         Inc (CurGlimmer);
         if CurGlimmer >= MaxGlimmer then CurGlimmer := 0;
      end;
      idx := GetEffectBase (5-1{堪拳搬馆娄烙}, 1) + Dir*10 + CurGlimmer;
      d := FrmMain.WMagic.GetCachedImage (idx, ax, ay);
      if d <> nil then
         DrawBlend (dsurface, ddx + ax, ddy + ay, d, 1);
                          //dx + ax + ShiftX,
                          //dy + ay + ShiftY,
                          //d, 1);
   end;*)
end;
//根据当前状态state获得颜色效果（比如中毒状态等，人物显示的颜色就可能不同）
function TActor.GetDrawEffectValue: TColorEffect;
var
   ceff: TColorEffect;
begin
   ceff := ceNone;

   //高亮
   if (g_FocusCret = self) or (g_MagicTarget = self) then begin
      ceff := ceBright;
   end;

   //中了绿毒
   if m_nState and $80000000 <> 0 then begin
      ceff := ceGreen;
   end;
   if m_nState and $40000000 <> 0 then begin
      ceff := ceRed;
   end;
   if m_nState and $20000000 <> 0 then begin
      ceff := ceBlue;
   end;
   { //此状态用在 雷炎蛛王 小网状态上了  20080812
   if m_nState and $10000000 <> 0 then begin
      ceff := ceYellow;
   end;}
   //付厚幅
   if m_nState and $08000000 <> 0 then begin
      ceff := ceFuchsia;
   end;
   if m_nState and $04000000 <> 0 then begin
      ceff := ceGrayScale;
   end;
   Result := ceff;
end;
(*******************************************************************************
  作用 : 显示人自身动画  [通用类]      日期：2008.01.13
  过程 : DrawMyShow(dsurface: TDirectDrawSurface;dx,dy:integer);
  参数 : dsurface为画布；DX为X坐标； DY为Y坐标；
*******************************************************************************)
procedure TActor.DrawMyShow(dsurface: TDirectDrawSurface;dx,dy:integer);
var
  d:TDirectDrawSurface;
  img,ax,ay: integer;
  FlyX, FlyY: Integer;
begin
  if g_boIsMyShow then begin
    if GetTickCount - m_nMyShowTime >  m_nMyShowNextFrameTime{140} then begin
      m_nMyShowTime := GetTickCount;
      Inc(m_nMyShowFrame);
    end;
    //if g_boIsMyShow then begin
    if m_nMyShowFrame > m_nMyShowExplosionFrame then g_boIsMyShow := FALSE;
      img:= m_nMyShowStartFrame + m_nMyShowFrame;
      d := g_MagicBase.GetCachedImage(img,ax,ay);
      if not m_boNoChangeIsMyShow then begin//是否跟着人物动作变化而变化     20080306
        if d <> nil then
          DrawBlend (dsurface,dx+ ax + m_nShiftX,
                                 dy + ay + m_nShiftY,
                                 d, 1)
      end else begin
          PlayScene.ScreenXYfromMCXY (m_nNoChangeX, m_nNoChangeY, FlyX, FlyY);
          if d <> nil then
              DrawBlend (dsurface,FlyX+ ax  - UNITX div 2,
                                 FlyY + ay - UNITY div 2,
                                 d, 1);
      end;
  end;
    //end;
end;

//英雄召唤与退出 动画显示
procedure TActor.HeroLoginOrLogOut(dsurface: TDirectDrawSurface;dx,dy:integer);
var
  d:TDirectDrawSurface;
  img,ax,ay: integer;
begin
  if g_HeroLoginOrLogOut then begin
    if GetTickCount - HeroTime >  140 then begin
      HeroTime:=GetTickCount;
      inc(HeroFrame);
    end;
      if HeroFrame > HeroLoginExplosionFrame then g_HeroLoginOrLogOut := FALSE;

      img:=HeroLoginStartFrame+HeroFrame;
           d := g_WEffectImages.GetCachedImage(img,ax,ay);
      if d <> nil then
      DrawBlend (dsurface,dx+ax+ m_nShiftX,
                             dy +ay+ m_nShiftY,
                             d, 1);
  end;
end;

{//飘血显示
procedure TActor.DrawAddBlood(dsurface: TDirectDrawSurface;dx, dy: Integer);
var
   BooldNum,jj,BooldIndex: Integer;
   d: TDirectDrawSurface;
   p,w:integer;
 function GetIndex(var Index:Integer):Integer;
 var
    s:String;
 begin
    s:=Inttostr(Index);
    Result:=StrToInt(S[1])+5;
    Delete(s,1,1);
    if s<>'' then
     Index:=Strtoint(s)
    else
     Index:=-1;
 end;
begin
  if g_boShowMoveRedHp then begin
    if IsAddBlood then begin
      if GetTickCount - AddBloodTime >  1000 then IsAddBlood := False;
      if GetTickCount - AddBloodStartTime > 40 then begin
        Inc(AddBloodFram);
        AddBloodStartTime := GetTickCount;
      end;
    end;
      //加减血显示

      if IsAddBlood then begin
         BooldNum := abs(AddBloodNum);//BooldNum等于人少的血
         jj:=1;
         if Self=g_Myself then w := 12 else w := 8;
         if AddBloodnum > 0 then
           d := g_qingqingImages.Images[16]
         else
           d := g_qingqingImages.Images[15];

           if d <> nil then
            dsurface.Draw(m_nSayX - d.Width div 2+AddBloodFram*(2), dy + m_nhpy + m_nShiftY - 10-AddBloodFram*(2), d.ClientRect, d, True);
         while BooldNum >= 0 do begin
           BooldIndex := GetIndex(BooldNum);//取出图片
           d := g_qingqingImages.Images[BooldIndex];
           if d <> nil then
            dsurface.Draw(m_nSayX - d.Width div 2 + AddBloodFram * (2) + jj * w, dy + m_nhpy + m_nShiftY - 10 - AddBloodFram * (2), d.ClientRect, d, True);
           Inc(jj);
         end;
      end;
  end;
end;  }
//显示角色
procedure TActor.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean);
var
   idx, ax, ay: integer;
   d: TDirectDrawSurface;
   ceff: TColorEffect;
   wimg: TWMImages;
   ErrorCode: Integer;
begin
  try
    ErrorCode := 0;
    d:=nil;
    //if not (m_btDir in [0..7]) then Exit;
    if m_btDir > 7 then Exit;
    ErrorCode := 1;
    if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
       m_dwLoadSurfaceTime := GetTickCount;
       LoadSurface; //由于图片每60秒会释放一次（60秒内未使用的话），所以每60秒要检查一下是否已经被释放了.
    end;
    ErrorCode := 2;
    ceff := GetDrawEffectValue;
    ErrorCode := 3;
    if m_BodySurface <> nil then begin
       DrawEffSurface (dsurface,
                      m_BodySurface,
                      dx + m_nPx + m_nShiftX,
                      dy + m_nPy + m_nShiftY,
                      blend,
                      ceff);
    end;
    ErrorCode := 4;
    HeroLoginOrLogOut(dsurface,dx,dy);
    ErrorCode := 5;
    DrawMyShow(dsurface,dx,dy); //显示自身动画
    ErrorCode := 6;
    if m_boUseMagic and (m_CurMagic.EffectNumber > 0) then begin
       if m_nCurEffFrame in [0..m_nSpellFrame-1] then begin
          GetEffectBase (m_CurMagic.EffectNumber-1, 0, wimg, idx);
          idx := idx + m_nCurEffFrame;
          if wimg <> nil then
             d := wimg.GetCachedImage (idx, ax, ay);
          if d <> nil then
             DrawBlend (dsurface,
                             dx + ax + m_nShiftX,
                             dy + ay + m_nShiftY,
                             d, 1);
       end;
    end;
    ErrorCode := 7;
   except
    DebugOutStr('TActor.DrawChr:'+IntToStr(ErrorCode));
   end;
end; 

procedure  TActor.DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer);
begin
end;

//缺省帧
function  TActor.GetDefaultFrame (wmode: Boolean): integer;
var
   cf: integer;
   pm: PTMonsterAction;
begin
   Result:=0;
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;
   if m_boDeath then begin            //死亡
      if m_boSkeleton then            //地上尸体骷髅
         Result := pm.ActDeath.start
      else Result := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip) + (pm.ActDie.frame - 1);
   end else begin
      m_nDefFrameCount := pm.ActStand.frame;
      if m_nCurrentDefFrame < 0 then cf := 0
        else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
        else cf := m_nCurrentDefFrame;
      Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
   end;
end;
//默认运动
procedure TActor.DefaultMotion;   //缺省动作
begin
   m_boReverseFrame := FALSE;
   if m_boWarMode then begin
      if (GetTickCount - m_dwWarModeTime > 4000) then //and not BoNextTimeFireHit then
         m_boWarMode := FALSE;
   end;
   m_nCurrentFrame := GetDefaultFrame (m_boWarMode);
   Shift (m_btDir, 0, 1, 1);
end;

//人物动作声音(脚步声、武器攻击声)
procedure TActor.SetSound;
var
   cx, cy, bidx, wunit, attackweapon: integer;
   hiter: TActor;
begin
   if (m_btRace = 0) or (m_btRace = 1) or (m_btRace = 150){人类,英雄,人型20080629} then begin              //人类玩家
      if (self = g_MySelf) and             //基本动作
         ((m_nCurrentAction=SM_WALK) or
          (m_nCurrentAction=SM_BACKSTEP) or
          (m_nCurrentAction=SM_RUN) or
          //(m_nCurrentAction=SM_HORSERUN) or  20080803注释骑马消息
          (m_nCurrentAction=SM_RUSH) or
          (m_nCurrentAction=SM_RUSHKUNG)
         )
      then begin
         cx := g_MySelf.m_nCurrX - Map.m_nBlockLeft;
         cy := g_MySelf.m_nCurrY - Map.m_nBlockTop;
         cx := cx div 2 * 2;
         cy := cy div 2 * 2;
         bidx := Map.m_MArr[cx, cy].wBkImg and $7FFF;
         wunit := Map.m_MArr[cx, cy].btArea;
         bidx := wunit * 10000 + bidx - 1;
         case bidx of
            330..349, 450..454, 550..554, 750..754,
            950..954, 1250..1254, 1400..1424, 1455..1474,
            1500..1524, 1550..1574:
               m_nFootStepSound := s_walk_lawn_l;  //草地上行走
               
            250..254, 1005..1009, 1050..1054, 1060..1064, 1450..1454,
            1650..1654:
               m_nFootStepSound := s_walk_rough_l; //粗糙的地面

            605..609, 650..654, 660..664, 2000..2049,
            3025..3049, 2400..2424, 4625..4649, 4675..4678:
               m_nFootStepSound := s_walk_stone_l;  //石头地面上行走

            1825..1924, 2150..2174, 3075..3099, 3325..3349,
            3375..3399:
               m_nFootStepSound := s_walk_cave_l;  //洞穴里行走

           3230, 3231, 3246, 3277:
               m_nFootStepSound := s_walk_wood_l;  //木头地面行走

           //带傈..
           3780..3799:
               m_nFootStepSound := s_walk_wood_l;

           3825..4434:
               if (bidx-3825) mod 25 = 0 then m_nFootStepSound := s_walk_wood_l
               else m_nFootStepSound := s_walk_ground_l;

             2075..2099, 2125..2149:
               m_nFootStepSound := s_walk_room_l;   //房间里

            1800..1824:
               m_nFootStepSound := s_walk_water_l;  //水中

            else
               m_nFootStepSound := s_walk_ground_l;
         end;
         //泵傈郴何
         if (bidx >= 825) and (bidx <= 1349) then begin
            if ((bidx-825) div 25) mod 2 = 0 then
               m_nFootStepSound := s_walk_stone_l;
         end;
         //悼奔郴何
         if (bidx >= 1375) and (bidx <= 1799) then begin
            if ((bidx-1375) div 25) mod 2 = 0 then
               m_nFootStepSound := s_walk_cave_l;
         end;
         case bidx of
            1385, 1386, 1391, 1392:
               m_nFootStepSound := s_walk_wood_l;
         end;

         bidx := Map.m_MArr[cx, cy].wMidImg and $7FFF;   //检查地图属性
         bidx := bidx - 1;
         case bidx of
            0..115:
               m_nFootStepSound := s_walk_ground_l;
            120..124:
               m_nFootStepSound := s_walk_lawn_l;
         end;

         bidx := Map.m_MArr[cx, cy].wFrImg and $7FFF;
         bidx := bidx - 1;
         case bidx of
            221..289, 583..658, 1183..1206, 7163..7295,
            7404..7414:
               m_nFootStepSound := s_walk_stone_l;
            3125..3267, {3319..3345, 3376..3433,} 3757..3948,
            6030..6999:
               m_nFootStepSound := s_walk_wood_l;
            3316..3589:
               m_nFootStepSound := s_walk_room_l;
         end;
         if (m_nCurrentAction = SM_RUN){ or (m_nCurrentAction = SM_HORSERUN)20080803注释骑马消息 }then
            m_nFootStepSound := m_nFootStepSound + 2;
      end;

      if m_btSex = 0 then begin //男
         m_nScreamSound := s_man_struck;
         m_nDieSound := s_man_die;
      end else begin //女
         m_nScreamSound := s_wom_struck;
         m_nDieSound := s_wom_die;
      end;

      case m_nCurrentAction of      //攻击动作
         SM_THROW, SM_HIT, SM_HIT+1, SM_HIT+2, SM_POWERHIT, SM_LONGHIT, SM_WIDEHIT, SM_FIREHIT{烈火}, SM_DAILY{逐日剑法}, SM_4FIREHIT{4级烈火}, SM_CRSHIT, SM_TWINHIT{开天斩重击}, SM_QTWINHIT{开天斩轻击}, SM_CIDHIT{龙影剑法}, SM_LEITINGHIT{雷霆一击战士效果 20080611}:
            begin
               case (m_btWeapon div 2) of
                  6, 20:  m_nWeaponSound := s_hit_short;
                  1:  m_nWeaponSound := s_hit_wooden;
                  2, 13, 9, 5, 14, 22:  m_nWeaponSound := s_hit_sword;
                  4, 17, 10, 15, 16, 23:  m_nWeaponSound := s_hit_do;
                  3, 7, 11:  m_nWeaponSound := s_hit_axe;
                  24:  m_nWeaponSound := s_hit_club;
                  8, 12, 18, 21:  m_nWeaponSound := s_hit_long;
                  else m_nWeaponSound := s_hit_fist;
               end;
            end;
         SM_STRUCK: //受攻击
            begin
               if m_nMagicStruckSound >= 1 then begin
                  //strucksound := s_struck_magic;
               end else begin
                  hiter := PlayScene.FindActor (m_nHiterCode);
                  //attackweapon := 0;
                  if hiter <> nil then begin
                     attackweapon := hiter.m_btWeapon div 2;
                     if (hiter.m_btRace = 0) or (hiter.m_btRace = 1) or (hiter.m_btRace = 150) then //人类,英雄,人型20080629
                        case (m_btDress div 2) of
                           3:
                              case attackweapon of
                                 6:  m_nStruckSound := s_struck_armor_sword;
                                 1,2,4,5,9,10,13,14,15,16,17: m_nStruckSound := s_struck_armor_sword;
                                 3,7,11: m_nStruckSound := s_struck_armor_axe;
                                 8,12,18: m_nStruckSound := s_struck_armor_longstick;
                                 else m_nStruckSound := s_struck_armor_fist;
                              end;
                           else
                              case attackweapon of
                                 6: m_nStruckSound := s_struck_body_sword;
                                 1,2,4,5,9,10,13,14,15,16,17: m_nStruckSound := s_struck_body_sword;
                                 3,7,11: m_nStruckSound := s_struck_body_axe;
                                 8,12,18: m_nStruckSound := s_struck_body_longstick;
                                 else m_nStruckSound := s_struck_body_fist;
                              end;
                        end;
                  end;
               end;
            end;
      end;


      if m_boUseMagic and (m_CurMagic.MagicSerial > 0) then begin
        case m_CurMagic.MagicSerial of  //MagicSerial为魔法ID 20080302
          41: m_nMagicStartSound := 10430;//狮子吼  20080314
          44: begin //寒冰掌
            m_nMagicStartSound := 10000 + (m_CurMagic.MagicSerial-5) * 10;
            m_nMagicFireSound := 10000 + (m_CurMagic.MagicSerial-5) + 1;
            m_nMagicExplosionSound := 10000 + (m_CurMagic.MagicSerial-5) * 10 + 2;
          end;
          45: begin //灭天火
            m_nMagicStartSound := 10000 + (m_CurMagic.MagicSerial-10) * 10;
            m_nMagicExplosionSound := 10000 + (m_CurMagic.MagicSerial-10) + 2;
          end;
          48: begin
            m_nMagicStartSound := 10370;  //气功波 20080321
            m_nMagicExplosionSound := 0;
          end;
          50: begin
            m_nMagicStartSound := 10360;//无极真气  20080314
            m_nMagicExplosionSound := 0;
          end;
          59: begin
            m_nMagicStartSound := 10480;//噬血术  20080511
            m_nMagicExplosionSound := 10482;
          end;
          62: begin//雷霆一击 20080405
              m_nMagicStartSound := 10520;
              m_nMagicExplosionSound := 10522;
          end;
          63: begin  //噬魂沼泽 20080405
              m_nMagicStartSound := 10530;
              m_nMagicExplosionSound := 10532;
          end;
          64: begin  //末日审判 20080405
              m_nMagicStartSound := 10540;
              m_nMagicExplosionSound := 10542;
          end;
          65: begin  //火龙气焰 20080405
              m_nMagicStartSound := 10550;
              m_nMagicExplosionSound := 10552;
          end;
          72: begin //召唤月灵
            m_nMagicStartSound := 10410;
          end;
          66: begin //4级魔法盾
            m_nMagicStartSound := 10310;
            m_nMagicFireSound := 10311;
            m_nMagicExplosionSound := 10312;
          end;
          {100: begin //月灵轻击
            m_nMagicStartSound := 11000;
            m_nMagicExplosionSound := 11002;
          end;
          101: begin //月灵重击
            m_nMagicStartSound := 11010;
            m_nMagicExplosionSound := 11012;
          end; }
          else begin
           m_nMagicStartSound := 10000 + m_CurMagic.MagicSerial * 10;
           m_nMagicFireSound := 10000 + m_CurMagic.MagicSerial * 10 + 1;
           m_nMagicExplosionSound := 10000 + m_CurMagic.MagicSerial * 10 + 2;
          end;
        end;
      end;

   end else begin
      if m_nCurrentAction = SM_STRUCK then begin //受攻击
         if m_nMagicStruckSound >= 1 then begin
            //strucksound := s_struck_magic;
         end else begin
            hiter := PlayScene.FindActor (m_nHiterCode);
            if hiter <> nil then begin
               attackweapon := hiter.m_btWeapon div 2;
               case attackweapon of
                  6: m_nStruckSound := s_struck_body_sword;
                  1,2,4,5,9,10,13,14,15,16,17: m_nStruckSound := s_struck_body_sword;
                  3,11: m_nStruckSound := s_struck_body_axe;
                  8,12,18: m_nStruckSound := s_struck_body_longstick;
                  else m_nStruckSound := s_struck_body_fist;
               end;
            end;
         end;
      end;

      if m_btRace <> 50 then begin
         m_nAppearSound := 200 + (m_wAppearance) * 10;
         m_nNormalSound := 200 + (m_wAppearance) * 10 + 1;
         m_nAttackSound := 200 + (m_wAppearance) * 10 + 2;
         m_nWeaponSound := 200 + (m_wAppearance) * 10 + 3;
         m_nScreamSound := 200 + (m_wAppearance) * 10 + 4;
         if m_btRace = 108 then
         m_nDieSound := 1925 //月灵死亡声音  20080302
         else
         m_nDieSound := 200 + (m_wAppearance) * 10 + 5;
         m_nDie2Sound := 200 + (m_wAppearance) * 10 + 6;
      end;
   end;


   if m_nCurrentAction = SM_STRUCK then begin  //受攻击
      hiter := PlayScene.FindActor (m_nHiterCode);
      //attackweapon := 0;
      if hiter <> nil then begin
         attackweapon := hiter.m_btWeapon div 2;
         if hiter.m_btRace in [0,1,150] then //人类,英雄,人型20080629
            case (attackweapon div 2) of
               6, 20:  m_nStruckWeaponSound := s_struck_short;
               1:  m_nStruckWeaponSound := s_struck_wooden;
               2, 13, 9, 5, 14, 22:  m_nStruckWeaponSound := s_struck_sword;
               4, 17, 10, 15, 16, 23:  m_nStruckWeaponSound := s_struck_do;
               3, 7, 11:  m_nStruckWeaponSound := s_struck_axe;
               24:  m_nStruckWeaponSound := s_struck_club;
               8, 12, 18, 21:  m_nStruckWeaponSound := s_struck_wooden; //long;
               //else struckweaponsound := s_struck_fist;
            end;
      end;
   end;

end;

//播放动作声效
procedure  TActor.RunSound;
begin
   m_boRunSound := TRUE;
   SetSound;
   case m_nCurrentAction of
      SM_STRUCK:  //被攻击
         begin
            if (m_nStruckWeaponSound >= 0) then PlaySound (m_nStruckWeaponSound); //攻击的武器的声效
            if (m_nStruckSound >= 0) then PlaySound (m_nStruckSound);             //被攻击的声效
            if (m_nScreamSound >= 0) then PlaySound (m_nScreamSound);              //尖叫
         end;
      SM_NOWDEATH:
         begin
            if (m_nDieSound >= 0) then begin
              PlaySound (m_nDieSound);
            end;
         end;
      SM_THROW, SM_HIT, SM_FLYAXE, SM_LIGHTING, SM_DIGDOWN{巩摧塞}:
         begin
            if m_nAttackSound >= 0 then PlaySound (m_nAttackSound);
         end;
      SM_ALIVE, SM_DIGUP{殿厘,巩凯覆}:
         begin
            PlaySound (m_nAppearSound);
         end;
      SM_SPELL:
         begin
            PlaySound (m_nMagicStartSound);
            if m_CurMagic.EffectNumber = 91 then MyPlaySound (heroshield_ground); //护体神盾声音
            if m_CurMagic.MagicSerial = 60 then PHHitSound(1);
            if m_CurMagic.MagicSerial = 61 then PHHitSound(2);
            if m_CurMagic.EffectNumber = 51 then MyPlaySound ('wav\M58-0.wav'); //漫天火雨声音 20080511
         end;
   end;
end;

procedure  TActor.RunActSound (frame: integer);
begin
   if m_boRunSound then begin     //需要播放声效
      if (m_btRace = 0) or (m_btRace = 1) or (m_btRace = 150) then begin  //人类,英雄,人型20080629
         case m_nCurrentAction of
            SM_THROW, SM_HIT, SM_HIT+1, SM_HIT+2:    //扔、击
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  m_boRunSound := FALSE; //声效已经播放
               end;
            SM_POWERHIT:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  //播放人物的声音
                  if m_btSex = 0 then PlaySound (s_yedo_man)
                  else PlaySound (s_yedo_woman);
                  m_boRunSound := FALSE; //茄锅父 家府晨
               end;
            SM_LONGHIT:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_longhit);
                  m_boRunSound := FALSE; //茄锅父 家府晨
               end;
            SM_WIDEHIT:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_widehit);
                  m_boRunSound := FALSE; //茄锅父 家府晨
               end;
            SM_FIREHIT{烈火}, SM_4FIREHIT{4级烈火}:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_firehit);
                  m_boRunSound := FALSE; //茄锅父 家府晨
               end;
            SM_CRSHIT:
              if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_firehit); //Damian
                  m_boRunSound := FALSE; //茄锅父 家府晨
              end;
            SM_TWINHIT: //开天斩 重击
              if frame = 2 then begin
                  MyPlaySound (longswordhit_ground);
                  m_boRunSound := FALSE;
              end;
            SM_QTWINHIT: //开天斩 轻击
              if frame = 2 then begin
                  MyPlaySound (longswordhit_ground);
                  m_boRunSound := FALSE;
              end;
            SM_DAILY: //逐日剑法 20080511
              if frame = 2 then begin
                  if m_btSex = 0 then //男
                    MyPlaySound ('wav\M56-0.wav')
                  else
                    MyPlaySound ('wav\M56-3.wav'); //女
                  m_boRunSound := FALSE;
              end;
            SM_CIDHIT:{龙影剑法}
              if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (142); //20080403
                  m_boRunSound := False;
              end;
         end;
      end else begin
         {if m_btRace = 50 then begin  //20080803修改
         end else begin}
          if m_btRace <> 50 then begin
            if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_TURN) then begin
               if (frame = 1) and (Random(8) = 1) then begin
                  PlaySound (m_nNormalSound);
                  m_boRunSound := FALSE;
               end;
            end;
            if m_nCurrentAction = SM_HIT then begin
               if (frame = 3) and (m_nAttackSound >= 0) then begin
                  PlaySound (m_nWeaponSound);
                  m_boRunSound := FALSE;
               end;
            end;
            { //20080803修改
            case m_wAppearance of
               80: begin
                  if m_nCurrentAction = SM_NOWDEATH then begin
                     if (frame = 2) then begin
                        PlaySound (m_nDie2Sound);
                        m_boRunSound := FALSE;
                     end;
                  end;
               end;
            end; }
            if m_wAppearance = 80 then begin
               if (m_nCurrentAction = SM_NOWDEATH) and (frame = 2) then begin
                 PlaySound (m_nDie2Sound);
                 m_boRunSound := FALSE;
               end;
            end;
         end;
      end;
   end;
end;

procedure  TActor.RunFrameAction (frame: integer);
begin
end;

procedure  TActor.ActionEnded;
begin
end;

procedure TActor.Run;
   function MagicTimeOut: Boolean;
   begin
      if self = g_MySelf then begin
         Result := GetTickCount - m_dwWaitMagicRequest > 3000;
      end else
         Result := GetTickCount - m_dwWaitMagicRequest > 2000;
      if Result then
         m_CurMagic.ServerMagicCode := 0;
   end;
var
   prv: integer;
   m_dwFrameTimetime: longword;
   bofly: Boolean;
begin
   if (m_nCurrentAction = SM_WALK) or
      (m_nCurrentAction = SM_BACKSTEP) or
      (m_nCurrentAction = SM_RUN) or
      //(m_nCurrentAction = SM_HORSERUN) or 20080803注释骑马消息
      (m_nCurrentAction = SM_RUSH) or
      (m_nCurrentAction = SM_RUSHKUNG)
   then Exit;

   m_boMsgMuch := FALSE;
   if self <> g_MySelf then begin
      if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
   end;

   //声音效果
   RunActSound (m_nCurrentFrame - m_nStartFrame);
   RunFrameAction (m_nCurrentFrame - m_nStartFrame);

   prv := m_nCurrentFrame;
   if m_nCurrentAction <> 0 then begin  //动作不为空
      if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then
         m_nCurrentFrame := m_nStartFrame;

      if (self <> g_MySelf) and (m_boUseMagic) then begin
         m_dwFrameTimetime := Round(m_dwFrameTime / 1.8);
      end else begin
         if m_boMsgMuch then m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
         else m_dwFrameTimetime := m_dwFrameTime;
      end;

      if GetTickCount - m_dwStartTime > m_dwFrameTimetime then begin
         if m_nCurrentFrame < m_nEndFrame then begin
            if m_boUseMagic then begin
               if (m_nCurEffFrame = m_nSpellFrame-2) or (MagicTimeOut) then begin
                  if (m_CurMagic.ServerMagicCode >= 0) or (MagicTimeOut) then begin
                     Inc (m_nCurrentFrame);
                     Inc(m_nCurEffFrame);
                     m_dwStartTime := GetTickCount;
                  end;
               end else begin
                  if m_nCurrentFrame < m_nEndFrame - 1 then Inc (m_nCurrentFrame);
                  Inc (m_nCurEffFrame);
                  m_dwStartTime := GetTickCount;
               end;
            end else begin
               Inc (m_nCurrentFrame);
               m_dwStartTime := GetTickCount;
            end;
         end else begin
            if m_boDelActionAfterFinished then begin
               m_boDelActor := TRUE;
            end;
            if self = g_MySelf then begin  
               if FrmMain.ServerAcceptNextAction then begin
                  ActionEnded;
                  m_nCurrentAction := 0;
                  m_boUseMagic := FALSE;
               end;
            end else begin
               ActionEnded;
               m_nCurrentAction := 0;
               m_boUseMagic := FALSE;
            end;
         end;
         if m_boUseMagic then begin
            if m_nCurEffFrame = m_nSpellFrame-1 then begin
               if m_CurMagic.ServerMagicCode > 0 then begin
                  with m_CurMagic do
                     PlayScene.NewMagic (self,
                                      ServerMagicCode,
                                      EffectNumber, //Effect
                                      m_nCurrX,
                                      m_nCurrY,
                                      TargX,
                                      TargY,
                                      Target,
                                      EffectType, //EffectType
                                      Recusion,
                                      AniTime,
                                      bofly);
                  if bofly then
                     PlaySound (m_nMagicFireSound)
                  else begin
                     if m_CurMagic.EffectNumber = 51 then //漫天火雨声音 20080511
                      MyPlaySound ('wav\M58-3.wav') 
                     else
                     PlaySound (m_nMagicExplosionSound);
                  end;
               end;
               //LatestSpellTime := GetTickCount;
               m_CurMagic.ServerMagicCode := 0;
            end;
         end;
      end;
      if (m_wAppearance = 0) or (m_wAppearance = 1) or (m_wAppearance = 43) then m_nCurrentDefFrame := -10
      else m_nCurrentDefFrame := 0;
      m_dwDefFrameTime := GetTickCount;
   end else begin    //动作为空
      if (m_btRace = 50) and (m_wAppearance in [54..58]) then begin   //雪域NPC 20081229
         if GetTickCount - m_dwDefFrameTime > m_dwFrameTime then begin
            m_dwDefFrameTime := GetTickCount;
            Inc (m_nCurrentDefFrame);
            if m_nCurrentDefFrame >= m_nDefFrameCount then
               m_nCurrentDefFrame := 0;
         end;
         DefaultMotion;
      end else begin
        if GetTickCount - m_dwSmoothMoveTime > 200 then begin
           if GetTickCount - m_dwDefFrameTime > 500 then begin
              m_dwDefFrameTime := GetTickCount;
              Inc (m_nCurrentDefFrame);
              if m_nCurrentDefFrame >= m_nDefFrameCount then
                 m_nCurrentDefFrame := 0;
           end;
           DefaultMotion;
        end;
      end;
   end;

   if prv <> m_nCurrentFrame then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface;
   end;

end;

//根据当前动作和状态计算下一个动作对应的帧
function  TActor.Move (step: integer): Boolean;
var
   prv, curstep, maxstep: integer;
   Fastmove, normmove: Boolean;
begin
   Result := FALSE;
   fastmove := FALSE;
   normmove := FALSE;
   if (m_nCurrentAction = SM_BACKSTEP) then //or (CurrentAction = SM_RUSH) or (CurrentAction = SM_RUSHKUNG) then
      Fastmove := TRUE;
   if (m_nCurrentAction = SM_RUSH) or (m_nCurrentAction = SM_RUSHKUNG) then
      normmove := TRUE;
   if (self = g_MySelf) and (not fastmove) and (not normmove) then begin
      //g_boMoveSlow := FALSE;  20080816注释掉起步负重
      //g_boAttackSlow := FALSE; //20080816 注释 腕力不足
      //20080816注释掉起步负重
      //g_nMoveSlowLevel := 0;
      {//超重跑步
      if m_Abil.Weight > m_Abil.MaxWeight then begin
         g_nMoveSlowLevel := m_Abil.Weight div m_Abil.MaxWeight;
         g_boMoveSlow := TRUE;
      end;
      if m_Abil.WearWeight > m_Abil.MaxWearWeight then begin
         g_nMoveSlowLevel := g_nMoveSlowLevel + m_Abil.WearWeight div m_Abil.MaxWearWeight;
         g_boMoveSlow := TRUE;
      end;
      if m_Abil.HandWeight > m_Abil.MaxHandWeight then begin
         g_boAttackSlow := TRUE
      end;
      //免负重
      if g_boMoveSlow and (m_nSkipTick < g_nMoveSlowLevel) and (not g_boMoveSlow1) then begin

         Inc (m_nSkipTick);
         exit;
      end else begin }
         //m_nSkipTick := 0;
      //end;
      //走动的声音
      if (m_nCurrentAction = SM_WALK) or
         (m_nCurrentAction = SM_BACKSTEP) or
         (m_nCurrentAction = SM_RUN) or
         //(m_nCurrentAction = SM_HORSERUN) or  20080803注释骑马消息
         (m_nCurrentAction = SM_RUSH) or
         (m_nCurrentAction = SM_RUSHKUNG)
      then begin
         case (m_nCurrentFrame - m_nStartFrame) of
            1: PlaySound (m_nFootStepSound);
            4: PlaySound (m_nFootStepSound + 1);
         end;
      end;
   end;

   Result := FALSE;
   m_boMsgMuch := FALSE;
   if self <> g_MySelf then begin
      if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
   end;
   prv := m_nCurrentFrame;
   //移动
   if (m_nCurrentAction = SM_WALK) or
      (m_nCurrentAction = SM_RUN) or
      //(m_nCurrentAction = SM_HORSERUN) or 20080803注释骑马消息
      (m_nCurrentAction = SM_RUSH) or
      (m_nCurrentAction = SM_RUSHKUNG)
   then begin
     //调整当前帧
      if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then begin
         m_nCurrentFrame := m_nStartFrame - 1;
      end;
      if m_nCurrentFrame < m_nEndFrame then begin
         Inc (m_nCurrentFrame);

         if m_boMsgMuch and not normmove then //加快步伐
            if m_nCurrentFrame < m_nEndFrame then
               Inc (m_nCurrentFrame);

         curstep := m_nCurrentFrame-m_nStartFrame + 1;
         maxstep := m_nEndFrame-m_nStartFrame + 1;
         Shift (m_btDir, m_nMoveStep, curstep, maxstep);  //变速
      end;
      if m_nCurrentFrame >= m_nEndFrame then begin
         if self = g_MySelf then begin
            if FrmMain.ServerAcceptNextAction then begin
               m_nCurrentAction := 0;      //当前动作：无
               m_boLockEndFrame := TRUE;
               m_dwSmoothMoveTime := GetTickCount;
            end;
         end else begin
            m_nCurrentAction := 0; //悼累 肯丰
            m_boLockEndFrame := TRUE;
            m_dwSmoothMoveTime := GetTickCount;
         end;
         Result := TRUE;
      end;
      if m_nCurrentAction = SM_RUSH then begin
         if self = g_MySelf then begin
            g_dwDizzyDelayStart := GetTickCount;
            g_dwDizzyDelayTime := 300; //掉饭捞
         end;
      end;
      if m_nCurrentAction = SM_RUSHKUNG then begin  //野蛮冲撞
         if m_nCurrentFrame >= m_nEndFrame - 3 then begin
            m_nCurrX := m_nActBeforeX;
            m_nCurrY := m_nActBeforeY;
            m_nRx := m_nCurrX;
            m_nRy := m_nCurrY;
            m_nCurrentAction := 0;
            m_boLockEndFrame := TRUE;
            //m_dwSmoothMoveTime := GetTickCount;
         end;
      end;
      Result := TRUE;
   end;
   if (m_nCurrentAction = SM_BACKSTEP) then begin  //后退
      if (m_nCurrentFrame > m_nEndFrame) or (m_nCurrentFrame < m_nStartFrame) then begin
         m_nCurrentFrame := m_nEndFrame + 1;
      end;
      if m_nCurrentFrame > m_nStartFrame then begin
         Dec (m_nCurrentFrame);
         if m_boMsgMuch or fastmove then
            if m_nCurrentFrame > m_nStartFrame then Dec (m_nCurrentFrame);

         //何靛反霸 捞悼窍霸 窍妨绊
         curstep := m_nEndFrame - m_nCurrentFrame + 1;
         maxstep := m_nEndFrame - m_nStartFrame + 1;
         Shift (GetBack(m_btDir), m_nMoveStep, curstep, maxstep);
      end;
      if m_nCurrentFrame <= m_nStartFrame then begin
         if self = g_MySelf then begin
            //if FrmMain.ServerAcceptNextAction then begin
               m_nCurrentAction := 0;     //消息为空
               m_boLockEndFrame := TRUE;   //锁定当前操作
               m_dwSmoothMoveTime := GetTickCount;

               //第肺 剐赴 促澜 茄悼救 给 框流牢促.
               g_dwDizzyDelayStart := GetTickCount;
               g_dwDizzyDelayTime := 1000; //1檬 掉饭捞
            //end;
         end else begin
            m_nCurrentAction := 0; //悼累 肯丰
            m_boLockEndFrame := TRUE;
            m_dwSmoothMoveTime := GetTickCount;
         end;
         Result := TRUE;
      end;
      Result := TRUE;
   end;
   //若当前动作和上一个动作帧不同，则装载当前动作画面
   if prv <> m_nCurrentFrame then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface;
   end;
end;

//移动失败（服务器不接受移动命令）时，退回到上次的位置
procedure TActor.MoveFail;
begin
   m_nCurrentAction := 0; //悼累 肯丰
   m_boLockEndFrame := TRUE;
   g_MySelf.m_nCurrX := m_nOldx;
   g_MySelf.m_nCurrY := m_nOldy;
   g_MySelf.m_btDir := m_nOldDir;
   CleanUserMsgs;
end;

function  TActor.CanCancelAction: Boolean;
begin
   Result := FALSE;
   if m_nCurrentAction = SM_HIT then
      if not m_boUseEffect then
         Result := TRUE;
end;

procedure TActor.CancelAction;
begin
   m_nCurrentAction := 0; //悼累 肯丰
   m_boLockEndFrame := TRUE;
end;

procedure TActor.CleanCharMapSetting (x, y: integer);
begin
   g_MySelf.m_nCurrX := x;
   g_MySelf.m_nCurrY := y;
   g_MySelf.m_nRx := x;
   g_MySelf.m_nRy := y;
   m_nOldx := x;
   m_nOldy := y;
   m_nCurrentAction := 0;
   m_nCurrentFrame := -1;
   CleanUserMsgs;
end;

//实现分行显示说话内容到Saying
procedure TActor.Say (str: string);
var
   i, len, aline, n: integer;
   temp: string;
   loop: Boolean;
const
   MAXWIDTH = 150;
begin
   m_dwSayTime := GetTickCount;
   m_nSayLineCount := 0;

   n := 0;
   loop := TRUE;
   while loop do begin
      temp := '';
      i := 1;
      len := Length (str);
      while TRUE do begin
         if i > len then begin
            loop := FALSE;
            break;
         end;
         if byte (str[i]) >= 128 then begin
            temp := temp + str[i];
            Inc (i);
            if i <= len then temp := temp + str[i]
            else begin
               loop := FALSE;
               break;
            end;
         end else
            temp := temp + str[i];

         aline := FrmMain.Canvas.TextWidth (temp);
         if aline > MAXWIDTH then begin
            m_SayingArr[n] := temp;
            m_SayWidthsArr[n] := aline;
            Inc (m_nSayLineCount);
            Inc (n);
            if n >= MAXSAY then begin
               loop := FALSE;
               break;
            end;
            str := Copy (str, i+1, Len-i);
            temp := '';
            break;
         end;
         Inc (i);
      end;
      if temp <> '' then begin
         if n < MAXWIDTH then begin
            m_SayingArr[n] := temp;
            m_SayWidthsArr[n] := FrmMain.Canvas.TextWidth (temp);
            Inc (m_nSayLineCount);
         end;
      end;
   end;
end;


{============================== NPCActor =============================}
procedure TNpcActor.CalcActorFrame;
var
  Pm:pTMonsterAction;
begin
  m_boUseMagic    :=False;
  m_nCurrentFrame :=-1;
  m_nBodyOffset   :=GetNpcOffset(m_wAppearance);
                //npc为50
  Pm:=GetRaceByPM(m_btRace,m_wAppearance);
  if pm = nil then exit;
  m_btDir := m_btDir mod 3;
  case m_nCurrentAction of
    SM_TURN: begin //转向
      if g_boNpcWalk then Exit;
      if m_wAppearance in [54..59,70..75,90..92,65..66,62,82..84] then begin //卧龙笔记NPC
        m_nStartFrame := pm.ActStand.start;// + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
        m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
        m_dwFrameTime := pm.ActStand.ftime;
        m_dwStartTime := GetTickCount;
        m_nDefFrameCount := pm.ActStand.frame;
        Shift (m_btDir, 0, 0, 1);
        if m_wAppearance in [54..59,62,82..84] then
          m_boUseEffect:=False
        else m_boUseEffect:=True;
        if m_boUseEffect then begin
          if m_wAppearance in [65..66] then
            m_nEffectStart:=pm.ActStand.start + 180
          else m_nEffectStart:=pm.ActStand.start + 4;
          m_nEffectFrame:=m_nEffectStart;
          m_nEffectEnd:=m_nEffectStart + 3;
          m_dwEffectStartTime:=GetTickCount();
          m_dwEffectFrameTime:=600;
        end;
      end else begin
          m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
          m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
          m_dwFrameTime := pm.ActStand.ftime;
          m_dwStartTime := GetTickCount;
          m_nDefFrameCount := pm.ActStand.frame;
          Shift (m_btDir, 0, 0, 1);
          if ((m_wAppearance = 33) or (m_wAppearance = 34))and not m_boUseEffect then begin
            m_boUseEffect:=True;
            m_nEffectFrame:=m_nEffectStart;
            m_nEffectEnd:=m_nEffectStart + 9;
            m_dwEffectStartTime:=GetTickCount();
            m_dwEffectFrameTime:=300;
          end else begin
            if m_wAppearance in [42..47] then begin
              m_nStartFrame:=20;
              m_nEndFrame:=10;
              m_boUseEffect:=True;
              m_nEffectStart:=0;
              m_nEffectFrame:=0;
              m_nEffectEnd:=19;
              m_dwEffectStartTime:=GetTickCount();
              m_dwEffectFrameTime:=100;
            end else begin
              if m_wAppearance = 51 then begin
                m_boUseEffect:=True;
                m_nEffectStart:=60;
                m_nEffectFrame:=m_nEffectStart;
                m_nEffectEnd:=m_nEffectStart + 7;
                m_dwEffectStartTime:=GetTickCount();
                m_dwEffectFrameTime:=500;
              end;
            end;
          end;
        end;
    end;
    SM_HIT: begin  //攻击
      if g_boNpcWalk then Exit;
      case m_wAppearance of
        33,34,52,54..59,70..75,90..92,65..66,62{,82..84}: begin //70 卧龙笔记NPC
          if m_wAppearance in [54..59,70..75,90..92,65..66,62{,82..84}] then m_nStartFrame := pm.ActStand.start else
          m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
          m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
          m_dwStartTime := GetTickCount;
          m_nDefFrameCount := pm.ActStand.frame;
        end;
        else begin
          m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
          m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
          m_dwFrameTime := pm.ActAttack.ftime;
          m_dwStartTime := GetTickCount;
          if m_wAppearance = 51 then begin
            m_boUseEffect:=True;
            m_nEffectStart:=60;
            m_nEffectFrame:=m_nEffectStart;
            m_nEffectEnd:=m_nEffectStart + 7;
            m_dwEffectStartTime:=GetTickCount();
            m_dwEffectFrameTime:=500;
          end else
            if m_wAppearance in [82..84] then begin
              m_nStartFrame := pm.ActAttack.start;
              m_nEndFrame := m_nStartFrame + pm.ActStand.frame;
            end;
        end;
      end;
    end;
    SM_DIGUP: begin
      if m_wAppearance = 52 then begin
        m_bo248:=True;
        m_dwUseEffectTick:=GetTickCount + 23000;
        Randomize;
        PlaySound(Random(7) + 146);
        m_boUseEffect:=True;
        m_nEffectStart:=60;
        m_nEffectFrame:=m_nEffectStart;
        m_nEffectEnd:=m_nEffectStart + 11;
        m_dwEffectStartTime:=GetTickCount();
        m_dwEffectFrameTime:=100;
      end;
    end;
    SM_NPCWALK: begin //NPC走动
      if m_wAppearance = 81 then begin
        m_nStartFrame := 4250;
        m_nEndFrame := m_nStartFrame + 79;
        m_nCurrentFrame := -1;
        m_dwFrameTime := 80;
        m_dwStartTime := GetTickCount;
        g_boNpcWalk := True;
      end;
   end;
  end;
end;

constructor TNpcActor.Create; //0x0047C42C
begin
  inherited;
  m_EffSurface:=nil;
  m_boHitEffect:=False;
  m_bo248:=False;
  m_boNpcWalkEffect := False; //20080621
  m_boNpcWalkEffectSurface := nil; //20080621
  g_boNpcWalk := False;
end;

destructor TNpcActor.Destroy;
begin
  inherited Destroy;
end;
// 画NPC 人物自身图
procedure TNpcActor.DrawChr(dsurface: TDirectDrawSurface; dx, dy: integer;
  blend, boFlag: Boolean);
var
  ceff: TColorEffect;
begin
  m_btDir := m_btDir mod 3;
  if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
    m_dwLoadSurfaceTime := GetTickCount;
    LoadSurface;
  end;
  ceff := GetDrawEffectValue;

    if m_BodySurface <> nil then begin
      if m_wAppearance in [54..58] then begin //雪域NPC
        DrawBlend (dsurface,
               dx + m_nPx + m_nShiftX,
               dy + m_nPy + m_nShiftY,
               m_BodySurface,
               1);
      end else
      if m_wAppearance = 51 then begin  //酒馆老板娘
        DrawEffSurface (dsurface,
                        m_BodySurface,
                        dx + m_nPx + m_nShiftX,
                        dy + m_nPy + m_nShiftY,
                        True,
                        ceff);
      end else begin
        DrawEffSurface (dsurface,      //此处为画
                        m_BodySurface,
                        dx + m_nPx + m_nShiftX,
                        dy + m_nPy + m_nShiftY,
                        blend,
                        ceff);
      end;
    end;
    if m_boNpcWalkEffect then begin   //画酒馆2卷 老板娘效果(走出门帘的光)
      if m_boNpcWalkEffectSurface <> nil then begin
        DrawBlend (dsurface,
               dx + m_nNpcWalkEffectPx + m_nShiftX,
               dy + m_nNpcWalkEffectPy + m_nShiftY,
               m_boNpcWalkEffectSurface,
               1);
      end;
    end;
end;


procedure TNpcActor.DrawEff(dsurface: TDirectDrawSurface; dx, dy: integer);
begin
  if m_boUseEffect and (m_EffSurface <> nil) then begin
    DrawBlend (dsurface,
               dx + m_nEffX + m_nShiftX,
               dy + m_nEffY + m_nShiftY,
               m_EffSurface,
               1);
  end;
end;

function  TNpcActor.GetDefaultFrame (wmode: Boolean): integer;
var
   cf: integer;
   pm: PTMonsterAction;
begin
   Result:=0;//Jacky
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;
   m_btDir := m_btDir mod 3;  //NPC只有3个方向（如商人）

   if m_nCurrentDefFrame < 0 then cf := 0
   else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
   else cf := m_nCurrentDefFrame;
   if m_wAppearance in [54..59,70..75,90..92,65..66,62,82..84] then  //卧龙笔记NPC
    Result := pm.ActStand.start + cf
   else
   Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
end;

procedure TNpcActor.LoadSurface;
begin
  if (m_wAppearance = 81) and g_boNpcWalk then begin  //老板娘
   m_BodySurface:=g_WNpcImgImages.GetCachedImage(m_nCurrentFrame, m_nPx, m_nPy); //取图
   if m_boNpcWalkEffect then  //取门帘光的图 20080621
     m_boNpcWalkEffectSurface:=g_WNpcImgImages.GetCachedImage(m_nCurrentFrame+79, m_nNpcWalkEffectPx, m_nNpcWalkEffectPy); //取图
  end else
  m_BodySurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nCurrentFrame, m_nPx, m_nPy);

  if m_wAppearance in [42..47] then
    m_BodySurface:=nil;
  if m_boUseEffect then begin
    if m_wAppearance in [33..34] then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end else if m_wAppearance = 42 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 71;
      m_nEffY:=m_nEffY + 5;
    end else if m_wAppearance = 43 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 71;
      m_nEffY:=m_nEffY + 37;
    end else if m_wAppearance = 44 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 7;
      m_nEffY:=m_nEffY + 12;
    end else if m_wAppearance = 45 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 6;
      m_nEffY:=m_nEffY + 12;
    end else if m_wAppearance = 46 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 7;
      m_nEffY:=m_nEffY + 12;
    end else if m_wAppearance = 47 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 8;
      m_nEffY:=m_nEffY + 12;
    end else if m_wAppearance = 51 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end else if m_wAppearance = 52 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end else if m_wAppearance in [70..75,90..92,65..66] then begin //卧龙笔记NPC
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end;
  end;
end;


procedure TNpcActor.Run;
var
  nEffectFrame:Integer;
  dwEffectFrameTime:LongWord;
begin
  inherited Run;
  if (m_wAppearance = 81) and g_boNpcWalk then begin
    if not m_boNpcWalkEffect then begin
      if m_nCurrentFrame = 4297 then m_boNpcWalkEffect := True;
    end;
    
    if m_nCurrentFrame >= m_nEndFrame then begin
      g_boNpcWalk := False;
      m_boNpcWalkEffect := False;
      SendMsg (SM_TURN, m_nCurrX, m_nCurrY, m_btDir, m_nFeature, m_nState, '', 0); //转向
    end;
  end;

  nEffectFrame:=m_nEffectFrame;
  if m_boUseEffect then begin    //NPC是否使用了魔法类
    if m_boUseMagic then begin
      dwEffectFrameTime:=Round(m_dwEffectFrameTime / 3);
    end else dwEffectFrameTime:=m_dwEffectFrameTime;

    if GetTickCount - m_dwEffectStartTime > dwEffectFrameTime then begin
      m_dwEffectStartTime:=GetTickCount();
      if m_nEffectFrame < m_nEffectEnd then begin
        Inc(m_nEffectFrame);
      end else begin
        if m_bo248 then begin
          if GetTickCount > m_dwUseEffectTick then begin
            m_boUseEffect:=False;
            m_bo248:=False;
            m_dwUseEffectTick:=GetTickCount();
          end;
          m_nEffectFrame:=m_nEffectStart;
        end else m_nEffectFrame:=m_nEffectStart;
        m_dwEffectStartTime:=GetTickCount();
      end;
    end;
  end;
  if nEffectFrame <> m_nEffectFrame then begin     //魔法桢
    m_dwLoadSurfaceTime:=GetTickCount();
    LoadSurface();
  end;
end;


{============================== HUMActor =============================}
constructor THumActor.Create;
begin
   inherited Create;
   m_HairSurface := nil;
   m_WeaponSurface := nil;
   m_HumWinSurface:=nil;
   m_boWeaponEffect := FALSE;
   //m_boMagbubble4      := False; //20080811
   m_dwFrameTime:=150;
   m_dwFrameTick:=GetTickCount();
   m_nFrame:=0;
   m_nHumWinOffset:=0;
end;

destructor THumActor.Destroy;
begin
  inherited Destroy;
end;

procedure THumActor.CalcActorFrame;
var
  haircount: integer;
begin
  m_boUseMagic := FALSE;
  m_boHitEffect := FALSE;
  m_nCurrentFrame := -1;
   //human
  m_btHair   := HAIRfeature (m_nFeature);         //发型
  m_btDress  := DRESSfeature (m_nFeature);        //武器//服装
  m_btWeapon := WEAPONfeature (m_nFeature);
 // m_btHorse  :=Horsefeature(m_nFeatureEx);  20080721 注释骑马
  m_btEffect :=Effectfeature(m_nFeatureEx);
  m_nBodyOffset := HUMANFRAME * (m_btDress); //m_btSex; //男0, 女1

  haircount := g_WHairImgImages.ImageCount div {HUMANFRAME}1200 div 2;  //所有头发数=3600/600/2=3,即每个性别的发型数
  if m_btHair = High(m_btHair) then begin   //斗笠为255
      m_nHairOffset := HUMANFRAME * (m_btSex + 6);
  end else
  if m_btHair = 254 then begin     //金色斗笠为254
      m_nHairOffset := HUMANFRAME * (m_btSex + 8);
  end else begin
      if m_btSex = 1 then begin //女
        if m_btHair = 1 then m_nHairOffset := 600
        else begin
           if m_btHair > haircount-1 then m_btHair := haircount-1;
           m_btHair := m_btHair * 2;
           if m_btHair > 1 then
              m_nHairOffset := HUMANFRAME * (m_btHair + m_btSex)
           else m_nHairOffset := -1;
        end;
      end else begin                 //男
        if m_btHair = 0 then m_nHairOffset := -1
        else begin
           if m_btHair > haircount-1 then m_btHair := haircount-1;
           m_btHair := m_btHair * 2;
           if m_btHair > 1 then
              m_nHairOffset := HUMANFRAME * (m_btHair + m_btSex)
           else m_nHairOffset := -1;
        end;
      end;
  end;
     {if m_btSex = 1 then begin   //女
      if m_btHair = 1 then m_nHairOffset := -1;
     end else begin
      if m_btSex = 0 then   //男
      if m_btHair = 0 then m_nHairOffset := -1;
     end
     else begin
       if m_btHair > haircount-1 then m_btHair := haircount-1;
       m_btHair := m_btHair * 2;
       if m_btHair > 1 then
          m_nHairOffset := HUMANFRAME * (m_btHair + m_btSex)
       else m_nHairOffset := -1;
     end;
   end;  }
  {  if m_btHair > haircount-1 then m_btHair := haircount-1;
  m_btHair := m_btHair * 2;
  if m_btHair > 1 then
    m_nHairOffset := HUMANFRAME * (m_btHair + m_btSex)
  else m_nHairOffset := -1; }
  m_nWeaponOffset := HUMANFRAME * m_btWeapon; //(weapon*2 + m_btSex);    //武器图片开始帧（不分性别？）
//   if Dress in [1..4] then begin
//   if Dress in [18..21] then begin
//     HumWinOffset:=(Dress - 18)* HUMANFRAME;
//   end;
  if (m_btEffect = 50) then begin
    m_nHumWinOffset:=352;
  end else
  if m_btEffect <> 0 then
     m_nHumWinOffset:=(m_btEffect - 1) * HUMANFRAME;

   case m_nCurrentAction of
      SM_TURN: //转
         begin
            m_nStartFrame := HA.ActStand.start + m_btDir * (HA.ActStand.frame + HA.ActStand.skip);
            m_nEndFrame := m_nStartFrame + HA.ActStand.frame - 1;
            m_dwFrameTime := HA.ActStand.ftime;
            m_dwStartTime := GetTickCount;
            m_nDefFrameCount := HA.ActStand.frame;
            Shift (m_btDir, 0, 0, m_nEndFrame-m_nStartFrame+1);
         end;
      SM_WALK, //走
      SM_BACKSTEP: //后退
         begin
            m_nStartFrame := HA.ActWalk.start + m_btDir * (HA.ActWalk.frame + HA.ActWalk.skip);
            m_nEndFrame := m_nStartFrame + HA.ActWalk.frame - 1;
            m_dwFrameTime := HA.ActWalk.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := HA.ActWalk.UseTick;
            m_nCurTick := 0;
            //WarMode := FALSE;
            m_nMoveStep := 1;
            if m_nCurrentAction = SM_BACKSTEP then
               Shift (GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1)
            else
               Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
         end;
      SM_RUSH: //跑动中改变方向
         begin
            if m_nRushDir = 0 then begin
               m_nRushDir := 1;
               m_nStartFrame := HA.ActRushLeft.start + m_btDir * (HA.ActRushLeft.frame + HA.ActRushLeft.skip);
               m_nEndFrame := m_nStartFrame + HA.ActRushLeft.frame - 1;
               m_dwFrameTime := HA.ActRushLeft.ftime;
               m_dwStartTime := GetTickCount;
               m_nMaxTick := HA.ActRushLeft.UseTick;
               m_nCurTick := 0;
               m_nMoveStep := 1;
               Shift (m_btDir, 1, 0, m_nEndFrame-m_nStartFrame+1);
            end else begin
               m_nRushDir := 0;
               m_nStartFrame := HA.ActRushRight.start + m_btDir * (HA.ActRushRight.frame + HA.ActRushRight.skip);
               m_nEndFrame := m_nStartFrame + HA.ActRushRight.frame - 1;
               m_dwFrameTime := HA.ActRushRight.ftime;
               m_dwStartTime := GetTickCount;
               m_nMaxTick := HA.ActRushRight.UseTick;
               m_nCurTick := 0;
               m_nMoveStep := 1;
               Shift (m_btDir, 1, 0, m_nEndFrame-m_nStartFrame+1);
            end;
         end;
      SM_RUSHKUNG: //野蛮冲撞
         begin
            m_nStartFrame := HA.ActRun.start + m_btDir * (HA.ActRun.frame + HA.ActRun.skip);
            m_nEndFrame := m_nStartFrame + HA.ActRun.frame - 1;
            m_dwFrameTime := HA.ActRun.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := HA.ActRun.UseTick;
            m_nCurTick := 0;
            m_nMoveStep := 1;
            Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
         end;
      {SM_BACKSTEP:
         begin
            startframe := pm.ActWalk.start + (pm.ActWalk.frame - 1) + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
            m_nEndFrame := startframe - (pm.ActWalk.frame - 1);
            m_dwFrameTime := pm.ActWalk.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := pm.ActWalk.UseTick;
            m_nCurTick := 0;
            m_nMoveStep := 1;
            Shift (GetBack(Dir), m_nMoveStep, 0, m_nEndFrame-startframe+1);
         end;  }
      SM_SITDOWN:
         begin
            m_nStartFrame := HA.ActSitdown.start + m_btDir * (HA.ActSitdown.frame + HA.ActSitdown.skip);
            m_nEndFrame := m_nStartFrame + HA.ActSitdown.frame - 1;
            m_dwFrameTime := HA.ActSitdown.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_RUN:
         begin
            m_nStartFrame := HA.ActRun.start + m_btDir * (HA.ActRun.frame + HA.ActRun.skip);
            m_nEndFrame := m_nStartFrame + HA.ActRun.frame - 1;
            m_dwFrameTime := HA.ActRun.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := HA.ActRun.UseTick;
            m_nCurTick := 0;
            //WarMode := FALSE;
            if m_nCurrentAction = SM_RUN then m_nMoveStep := 2
            else m_nMoveStep := 1;

            //m_nMoveStep := 2;
            Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
         end;
      { 20080803注释骑马消息
      SM_HORSERUN: begin
            m_nStartFrame := HA.ActRun.start + m_btDir * (HA.ActRun.frame + HA.ActRun.skip);
            m_nEndFrame := m_nStartFrame + HA.ActRun.frame - 1;
            m_dwFrameTime := HA.ActRun.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := HA.ActRun.UseTick;
            m_nCurTick := 0;
            //WarMode := FALSE;
            if m_nCurrentAction = SM_HORSERUN then m_nMoveStep := 3
            else m_nMoveStep := 1;

            //m_nMoveStep := 2;
            Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
      end;    }
      {SM_THROW:  //20080803注释
         begin
            m_nStartFrame := HA.ActHit.start + m_btDir * (HA.ActHit.frame + HA.ActHit.skip);
            m_nEndFrame := m_nStartFrame + HA.ActHit.frame - 1;
            m_dwFrameTime := HA.ActHit.ftime;
            m_dwStartTime := GetTickCount;
            m_boWarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            m_boThrow := TRUE;
            Shift (m_btDir, 0, 0, 1);
         end; }
      SM_HIT, SM_POWERHIT, SM_LONGHIT, SM_WIDEHIT, SM_FIREHIT{烈火}, SM_4FIREHIT{4级烈火}, SM_CRSHIT, SM_TWINHIT{开天斩重击}, SM_QTWINHIT{开天斩轻击}, SM_CIDHIT{龙影剑法},SM_LEITINGHIT:
         begin
            m_nStartFrame := HA.ActHit.start + m_btDir * (HA.ActHit.frame + HA.ActHit.skip);
            m_nEndFrame := m_nStartFrame + HA.ActHit.frame - 1;
            m_dwFrameTime := HA.ActHit.ftime;
            m_dwStartTime := GetTickCount;
            m_boWarMode := TRUE;
            m_dwWarModeTime := GetTickCount;

            if (m_nCurrentAction = SM_POWERHIT) then begin //攻杀
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 1;
            end;
            if (m_nCurrentAction = SM_LONGHIT) then begin  //刺杀
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 2;
            end;
            if (m_nCurrentAction = SM_WIDEHIT) then begin  //半月
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 3;
            end;
            if (m_nCurrentAction = SM_FIREHIT) then begin  //烈火
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 4;
            end;
            if (m_nCurrentAction = SM_4FIREHIT) then begin  //4级烈火
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 9;
            end;
            if (m_nCurrentAction = SM_CRSHIT) then begin   //抱月
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 6;
            end;
            if (m_nCurrentAction = SM_TWINHIT) then begin  //开天斩重击
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 7;
            end;
            if (m_nCurrentAction = SM_QTWINHIT) then begin  //开天斩轻击 2008.02.12
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 10;
            end;
            if (m_nCurrentAction = SM_CIDHIT) then begin  //龙影剑法
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               //m_nEndFrame := m_nStartFrame + 15 - 1;
               m_nHitEffectNumber := 8;
            end;
            if (m_nCurrentAction = SM_LEITINGHIT{雷霆一击战士效果 20080611}) then begin
               m_boHitEffect := True;
               m_nMagLight := 2;
               m_nHitEffectNumber := 12;
            end;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_HEAVYHIT:
         begin
            m_nStartFrame := HA.ActHeavyHit.start + m_btDir * (HA.ActHeavyHit.frame + HA.ActHeavyHit.skip);
            m_nEndFrame := m_nStartFrame + HA.ActHeavyHit.frame - 1;
            m_dwFrameTime := HA.ActHeavyHit.ftime;
            m_dwStartTime := GetTickCount;
            m_boWarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_BIGHIT, SM_DAILY{逐日剑法}:
         begin
            m_nStartFrame := HA.ActBigHit.start + m_btDir * (HA.ActBigHit.frame + HA.ActBigHit.skip);
            m_nEndFrame := m_nStartFrame + HA.ActBigHit.frame - 1;
            m_dwFrameTime := HA.ActBigHit.ftime;
            m_dwStartTime := GetTickCount;
            m_boWarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);

            if (m_nCurrentAction = SM_DAILY) then begin
               m_boHitEffect := True;
               m_nMagLight := 2;
               m_nHitEffectNumber := 11;
            end;            
         end;
      SM_SPELL: //接收使用魔法消息
         begin
              m_nStartFrame := HA.ActSpell.start + m_btDir * (HA.ActSpell.frame + HA.ActSpell.skip);
              m_nEndFrame := m_nStartFrame + HA.ActSpell.frame - 1;
              m_dwFrameTime := HA.ActSpell.ftime;
              m_dwStartTime := GetTickCount;
              m_nCurEffFrame := 0;
              m_boUseMagic := TRUE;

            case m_CurMagic.EffectNumber of
               60: begin
                  m_nStartFrame := HA.ActHit.start + m_btDir * (HA.ActHit.frame + HA.ActHit.skip);
                  m_nEndFrame := m_nStartFrame + HA.ActHit.frame - 1;
                  m_dwFrameTime := HA.ActHit.ftime;
                  m_nMagLight := 2;
                  m_nSpellFrame := 2;
                  //m_nSpellFrame := 15;//15
                  end;
               22: begin //火墙
                     m_nMagLight := 4;  //汾汲拳
                     m_nSpellFrame := 10; //汾汲拳绰 10 橇贰烙栏肺 函版
                  end;
               26: begin //心灵启示
                     m_nMagLight := 2;
                     m_nSpellFrame := 20;
                     m_dwFrameTime := m_dwFrameTime div 2;
                  end;
               43: begin //狮子吼
                     m_nMagLight := 2;
                     m_nSpellFrame := 20;
                  end;
               52: begin  //四级魔法盾
                  m_nSpellFrame := 9;
               end;
               91: begin  //护体神盾
                    m_nSpellFrame := 10;
                  end;
               66: begin //酒气护体
                    m_nSpellFrame := 16;
               end;
             100, 101: begin  //4级火符 20080111  4级灭天火 20080111
                    m_nSpellFrame := 6;
                  end;
               else begin 
                  m_nMagLight := 2;
                  m_nSpellFrame := DEFSPELLFRAME;
               end;
            end;

            if (m_btRace = 1) or (m_btRace = 150) then  //英雄，人型
              m_dwWaitMagicRequest := GetTickCount - 1500 //防止,由于网络延时或消息累积,英雄人形连接放魔法时,出现举手卡现像 减少举手放下的时间间隔20080720
            else
              m_dwWaitMagicRequest := GetTickCount;
            m_boWarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      (*SM_READYFIREHIT:
         begin
            startframe := HA.ActFireHitReady.start + Dir * (HA.ActFireHitReady.frame + HA.ActFireHitReady.skip);
            m_nEndFrame := startframe + HA.ActFireHitReady.frame - 1;
            m_dwFrameTime := HA.ActFireHitReady.ftime;
            m_dwStartTime := GetTickCount;

            BoHitEffect := TRUE;
            HitEffectNumber := 4;
            MagLight := 2;

            CurGlimmer := 0;
            MaxGlimmer := 6;

            WarMode := TRUE;
            WarModeTime := GetTickCount;
            Shift (Dir, 0, 0, 1);
         end; *)
      SM_STRUCK:
         begin
            m_nStartFrame := HA.ActStruck.start + m_btDir * (HA.ActStruck.frame + HA.ActStruck.skip);
            m_nEndFrame := m_nStartFrame + HA.ActStruck.frame - 1;
            m_dwFrameTime := m_dwStruckFrameTime; //HA.ActStruck.ftime;
            m_dwStartTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);

            m_dwGenAnicountTime := GetTickCount;
            m_nCurBubbleStruck := 0;
            m_nCurProtEctionStruck := 0;
            m_dwProtEctionStruckTime := GetTickCount;
         end;
      SM_NOWDEATH:
         begin
            m_nStartFrame := HA.ActDie.start + m_btDir * (HA.ActDie.frame + HA.ActDie.skip);
            m_nEndFrame := m_nStartFrame + HA.ActDie.frame - 1;
            m_dwFrameTime := HA.ActDie.ftime;
            m_dwStartTime := GetTickCount;
         end;
   end;
end;

procedure THumActor.DefaultMotion;
begin
   inherited DefaultMotion;
   if (m_btEffect = 50) then begin
     if (m_nCurrentFrame <= 536) then begin
       if (GetTickCount - m_dwFrameTick) > 100 then begin
         if m_nFrame < 19 then Inc(m_nFrame)
         else begin
           {if not m_bo2D0 then m_bo2D0:=True
           else m_bo2D0:=False;  }
           m_nFrame:=0;
         end;
         m_dwFrameTick:=GetTickCount();
       end;
       if (not m_boDeath){20080406} then
       m_HumWinSurface:={FrmMain.WEffectImg}g_WEffectImages.GetCachedImage (m_nHumWinOffset + m_nFrame, m_nSpx, m_nSpy);
     end;
   end else
   if (m_btEffect <> 0) then begin
     if m_nCurrentFrame < 64 then begin
       if (GetTickCount - m_dwFrameTick) > m_dwFrameTime then begin
         if m_nFrame < 7 then Inc(m_nFrame)
         else m_nFrame:=0;
         m_dwFrameTick:=GetTickCount();
       end;
       m_HumWinSurface:=g_WHumWingImages.GetCachedImage (m_nHumWinOffset+ (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
     end else begin
       m_HumWinSurface:=g_WHumWingImages.GetCachedImage (m_nHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy);
     end;
   end;
end;

function  THumActor.GetDefaultFrame (wmode: Boolean): integer;   //动态函数
var
   cf: integer;
begin
   //GlimmingMode := FALSE;
   //dr := Dress div 2;            //HUMANFRAME * (dr)
   if m_boDeath then      //死亡
      Result := HA.ActDie.start + m_btDir * (HA.ActDie.frame + HA.ActDie.skip) + (HA.ActDie.frame - 1)
   else
   if wmode then begin      //战斗状态
      //GlimmingMode := TRUE;
      Result := HA.ActWarMode.start + m_btDir * (HA.ActWarMode.frame + HA.ActWarMode.skip);
   end else begin           //站立状态
      m_nDefFrameCount := HA.ActStand.frame;
      if m_nCurrentDefFrame < 0 then cf := 0
      else if m_nCurrentDefFrame >= HA.ActStand.frame then cf := 0 //HA.ActStand.frame-1
      else cf := m_nCurrentDefFrame;
      Result := HA.ActStand.start + m_btDir * (HA.ActStand.frame + HA.ActStand.skip) + cf;
   end;
end;

procedure  THumActor.RunFrameAction (frame: integer);
var
   meff: TMapEffect;
   event: TClEvent;
   mfly: TFlyingAxe;
begin
   //m_boHideWeapon := FALSE; 20080803注释
   if m_nCurrentAction = SM_HEAVYHIT then begin
      if (frame = 5) and (m_boDigFragment) then begin
         m_boDigFragment := FALSE;
         meff := TMapEffect.Create (8 * m_btDir, 3, m_nCurrX, m_nCurrY);
         meff.ImgLib := {FrmMain.WEffectImg}g_WEffectImages;
         meff.NextFrameTime := 80;
         PlaySound (s_strike_stone);
         //PlaySound (s_drop_stonepiece);
         PlayScene.m_EffectList.Add (meff);
         event := EventMan.GetEvent (m_nCurrX, m_nCurrY, ET_PILESTONES);
         if event <> nil then
            event.m_nEventParam := event.m_nEventParam + 1;
      end;
   end;
   (*//20080803注释
   if m_nCurrentAction = SM_THROW then begin
      if (frame = 3) and (m_boThrow) then begin
         m_boThrow := FALSE;
         //扔斧头效果
         mfly := TFlyingAxe (PlayScene.NewFlyObject (self,
                          m_nCurrX,
                          m_nCurrY,
                          m_nTargetX,
                          m_nTargetY,
                          m_nTargetRecog,
                          mtFlyAxe));
         if mfly <> nil then begin
            TFlyingAxe(mfly).ReadyFrame := 40;
            mfly.ImgLib := {FrmMain.WMon3Img20080720注释}g_WMonImagesArr[2];
            mfly.FlyImageBase := FLYOMAAXEBASE;
         end;

      end;
      if frame >= 3 then
         m_boHideWeapon := TRUE;
   end;   *)
end;

procedure  THumActor.DoWeaponBreakEffect;
begin
   m_boWeaponEffect := TRUE;
   m_nCurWeaponEffect := 0;
end;

procedure  THumActor.Run;
  //判断魔法是否已经完成（人类：3秒，其他：2秒）
   function MagicTimeOut: Boolean;
   begin
      if self = g_MySelf then begin
        if m_CurMagic.EffectNumber = 60 then   //破魂斩  缩短人物砍下去的动作 20080227
         Result := GetTickCount - m_dwWaitMagicRequest > 500
        else
         Result := GetTickCount - m_dwWaitMagicRequest > 3000;
      end else
        if m_CurMagic.EffectNumber = 60 then
         Result := GetTickCount - m_dwWaitMagicRequest > 500  //破魂斩  缩短人物砍下去的动作 20080227
        else
         Result := GetTickCount - m_dwWaitMagicRequest > 2000;
      if Result then
         m_CurMagic.ServerMagicCode := 0;
   end;
var
   prv: integer;
   m_dwFrameTimetime: longword;
   bofly: Boolean;
begin
   if GetTickCount - m_dwGenAnicountTime > 120 then begin //林贱狼阜 殿... 局聪皋捞记 瓤苞
      m_dwGenAnicountTime := GetTickCount;
      Inc (m_nGenAniCount);
      if m_nGenAniCount > 100000 then m_nGenAniCount := 0;
      Inc (m_nCurBubbleStruck);
   end;

   if m_boWeaponEffect then begin  //武器效果，每120秒变化一帧，共5帧
      if GetTickCount - m_dwWeaponpEffectTime > 120 then begin
         m_dwWeaponpEffectTime := GetTickCount;
         Inc (m_nCurWeaponEffect);
         if m_nCurWeaponEffect >= MAXWPEFFECTFRAME then
            m_boWeaponEffect := FALSE;
      end;
   end;
   if (m_nCurrentAction = SM_WALK) or
      (m_nCurrentAction = SM_NPCWALK) or
      (m_nCurrentAction = SM_BACKSTEP) or
      (m_nCurrentAction = SM_RUN) or
      //(m_nCurrentAction = SM_HORSERUN) or 20080803注释骑马消息
      (m_nCurrentAction = SM_RUSH) or
      (m_nCurrentAction = SM_RUSHKUNG)
   then Exit;
   m_boMsgMuch := FALSE;
   if self <> g_MySelf then begin
      if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
   end;
   //动作声效
   RunActSound (m_nCurrentFrame - m_nStartFrame);
   RunFrameAction (m_nCurrentFrame - m_nStartFrame);

   prv := m_nCurrentFrame;
   if m_nCurrentAction <> 0 then begin
      if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then
         m_nCurrentFrame := m_nStartFrame;
      if (self <> g_MySelf) and (m_boUseMagic) then begin
         m_dwFrameTimetime := Round(m_dwFrameTime / 1.8);
      end else begin
         if m_boMsgMuch then m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
         else m_dwFrameTimetime := m_dwFrameTime;
      end;

      if GetTickCount - m_dwStartTime > m_dwFrameTimetime then begin
         if m_nCurrentFrame < m_nEndFrame then begin
            if m_boUseMagic then begin
               if (m_nCurEffFrame = m_nSpellFrame-2) or (MagicTimeOut) then begin //魔法执行完
                  if (m_CurMagic.ServerMagicCode >= 0) or (MagicTimeOut) then begin //辑滚肺 何磐 罐篮 搬苞. 酒流 救吭栏搁 扁促覆
                     Inc (m_nCurrentFrame);
                     Inc (m_nCurEffFrame);
                     m_dwStartTime := GetTickCount;
                  end;
               end else begin
                  if m_nCurrentFrame < m_nEndFrame - 1 then Inc (m_nCurrentFrame);
                  Inc (m_nCurEffFrame);
                  m_dwStartTime := GetTickCount;
               end;
            end else begin   //攻击怪 这有反映
               Inc (m_nCurrentFrame);
               m_dwStartTime := GetTickCount;
            end;
         end else begin
            if Self = g_MySelf then begin
               if FrmMain.ServerAcceptNextAction then begin //锁定人物本身 服务器返回结果 则释放
                  m_nCurrentAction := 0;
                  m_boUseMagic := FALSE;
               end;
            end else begin     //不是人物
               m_nCurrentAction := 0;  //动作为空
               m_boUseMagic := FALSE;
            end;
            m_boHitEffect := FALSE;
         end;
         if m_boHitEffect and ((m_nHitEffectNumber = 7) or (m_nHitEffectNumber = 8) or (m_nHitEffectNumber = 10) or (m_nHitEffectNumber = 12)) then begin//魔法攻击效果  20080202
           if m_nCurrentFrame = m_nEndFrame - 1 then begin
              case m_nHitEffectNumber of
                  8: FrmMain.ShowMyShow(Self,1); //龙影剑法  后9个动画效果 20080202
                    //MyShow.Create(m_nCurrX,m_nCurrY,1,80,9,m_btDir,g_WMagic2Images);
                  7: FrmMain.ShowMyShow(Self,2); //开天斩重击碎冰效果
                 10: FrmMain.ShowMyShow(Self,3); //开天斩轻击碎冰效果
                 12: FrmMain.ShowMyShow(Self,6);//雷霆一击战士效果
              end;
           end;
         end;
         if m_boUseMagic then begin
            if m_nCurEffFrame = m_nSpellFrame - 1 then begin //魔法过程 先放自身魔法 的-1图
               //付过 惯荤
               if m_CurMagic.ServerMagicCode > 0 then begin
                  with m_CurMagic do
                     PlayScene.NewMagic (self,
                                      ServerMagicCode,
                                      EffectNumber,
                                      m_nCurrX,
                                      m_nCurrY,
                                      TargX,
                                      TargY,
                                      Target,
                                      EffectType,
                                      Recusion,
                                      AniTime,
                                      bofly);
                  if bofly then
                     PlaySound (m_nMagicFireSound)
                  else begin
                     if m_CurMagic.EffectNumber = 51 then //漫天火雨声音 20080511
                       MyPlaySound ('wav\M58-3.wav')
                     else
                       PlaySound (m_nMagicExplosionSound);
                  end;
               end;
               if self = g_MySelf then
                  g_dwLatestSpellTick := GetTickCount;
               m_CurMagic.ServerMagicCode := 0;
            end;
         end;

      end;
      if (m_btRace = 0) or (m_btRace = 1) or (m_btRace = 150) then m_nCurrentDefFrame := 0 //人类,英雄,人型20080629
      else m_nCurrentDefFrame := -10;
      m_dwDefFrameTime := GetTickCount;
   end else begin
      if GetTickCount - m_dwSmoothMoveTime > 200 then begin
         if GetTickCount - m_dwDefFrameTime > 500 then begin
            m_dwDefFrameTime := GetTickCount;
            Inc (m_nCurrentDefFrame);
            if m_nCurrentDefFrame >= m_nDefFrameCount then
               m_nCurrentDefFrame := 0;
         end;
         DefaultMotion;
      end;
   end;
   if prv <> m_nCurrentFrame then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface;
   end;
end;

function   THumActor.Light: integer;
var
   l: integer;
begin
   l := m_nChrLight;
   if l < m_nMagLight then begin
      if m_boUseMagic or m_boHitEffect then
         l := m_nMagLight;
   end;
   Result := l;
end;

procedure  THumActor.LoadSurface;
begin
   m_BodySurface := FrmMain.GetWHumImg(m_btDress,m_btSex ,m_nCurrentFrame, m_nPx, m_nPy);
   if m_BodySurface = nil then
     m_BodySurface := FrmMain.GetWHumImg(0,m_btSex ,m_nCurrentFrame, m_nPx, m_nPy);


   if m_nHairOffset >= 0 then
      m_HairSurface := g_WHairImgImages.GetCachedImage (m_nHairOffset + m_nCurrentFrame, m_nHpx, m_nHpy)
   else m_HairSurface := nil;
   if (m_btEffect = 50) then begin
       if (m_nCurrentFrame <= 536) then begin
         if (GetTickCount - m_dwFrameTick) > 100 then begin
           if m_nFrame < 19 then Inc(m_nFrame)
           else begin
             {if not m_bo2D0 then m_bo2D0:=True
             else m_bo2D0:=False;  }
             m_nFrame:=0;
           end;
           m_dwFrameTick:=GetTickCount();
         end;
         m_HumWinSurface:={FrmMain.WEffectImg}g_WEffectImages.GetCachedImage (m_nHumWinOffset + m_nFrame, m_nSpx, m_nSpy);
       end;
   end else
   if (m_btEffect <> 0) then begin
     if m_nCurrentFrame < 64 then begin
       if (GetTickCount - m_dwFrameTick) > m_dwFrameTime then begin
         if m_nFrame < 7 then Inc(m_nFrame)   //8个动作 
         else m_nFrame:=0;
         m_dwFrameTick:=GetTickCount();
       end;
       m_HumWinSurface:=g_WHumWingImages.GetCachedImage (m_nHumWinOffset+ (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
     end else begin
       m_HumWinSurface:=g_WHumWingImages.GetCachedImage (m_nHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy); //画人物身体
     end;
   end;

   m_WeaponSurface:=FrmMain.GetWWeaponImg(m_btWeapon,m_btSex,m_nCurrentFrame, m_nWpx, m_nWpy);
   if m_WeaponSurface = nil then
     m_WeaponSurface:=FrmMain.GetWWeaponImg(0,m_btSex,m_nCurrentFrame, m_nWpx, m_nWpy);
end;

{-----------------------------------------------------------------}
//绘制人物
{-----------------------------------------------------------------}
procedure  THumActor.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean);
var
   idx, ax, ay: integer;
   d: TDirectDrawSurface;
   ceff: TColorEffect;
   wimg: TWMImages;
   ErrorCode: Integer;
begin
  try
   HeroLoginOrLogOut(dsurface,dx,dy);
   d := nil;//Jacky
   if m_btDir > 7 then Exit; //当前站立方向 不属于0..7
   if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin  //60秒释放一次未使用的图片，所以每隔60秒要重新装载一次
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface; //重新装载图片到bodysurface
   end;
   ceff := GetDrawEffectValue;//人物显示颜色
   ErrorCode := 3;
   if (m_btRace = 0) or (m_btRace = 1) or (m_btRace = 150) then begin //人类,英雄,人型20080629
      if (m_nCurrentFrame >= 0) and (m_nCurrentFrame <= 599) then
         m_nWpord := WORDER[m_btSex, m_nCurrentFrame];
      if (m_btEffect <> 0) then begin
        if ((m_btDir = 3) or (m_btDir = 4) or (m_btDir = 5)) and (m_HumWinSurface <> nil) then begin
          if (g_MySelf = Self) then begin
            //if blend then begin   20080616修正隐身术 翅膀看不到问题
              {if not boFlag then begin
                 DrawBlend (dsurface, dx + m_nSpx + m_nShiftX, dy + m_nSpy + m_nShiftY, m_HumWinSurface, 1);
              end else begin//0x0047CED1 }
                 DrawBlend (dsurface, dx + m_nSpx + m_nShiftX, dy + m_nSpy + m_nShiftY, m_HumWinSurface, 1);
              //end;
            //end;//0x0047D03F
          end else begin;//0x0047CF4D
              if ((g_FocusCret <> nil) or (g_MagicTarget <> nil)) and blend and not boFlag then begin
                 DrawBlend (dsurface,
                            dx + m_nSpx + m_nShiftX,
                            dy + m_nSpy + m_nShiftY,
                            m_HumWinSurface,
                            1);
              end else begin;//0x0047CFD4
                if boFlag then begin
                   DrawBlend (dsurface,
                              dx + m_nSpx + m_nShiftX,
                              dy + m_nSpy + m_nShiftY,
                              m_HumWinSurface,
                              1);
                end;//0x0047D03F
              end;
          end;
        end;
      end;//0x0047D03F
      ErrorCode := 4;
      //先画武器
      if (m_nWpord = 0) and (not blend) and (m_btWeapon >= 2) and (m_WeaponSurface <> nil) {and (not m_boHideWeapon)20080803注释} then begin
         DrawEffSurface (dsurface, m_WeaponSurface, dx + m_nWpx + m_nShiftX, dy + m_nWpy + m_nShiftY, blend, ceNone);  //漠篮 祸捞 救函窃
         //DrawWeaponGlimmer (dsurface, dx + m_nShiftX, dy + m_nShiftY);
         //dsurface.Draw (dx + wpx + ShiftX, dy + wpy + ShiftY, WeaponSurface.ClientRect, WeaponSurface, TRUE);
      end;
      //画人物
      ErrorCode := 5;
      if m_BodySurface <> nil then
         DrawEffSurface (dsurface, m_BodySurface, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, blend, ceff);
      //画头发
      if m_HairSurface <> nil then
         DrawEffSurface (dsurface, m_HairSurface, dx + m_nHpx + m_nShiftX, dy + m_nHpy + m_nShiftY, blend, ceff);
      ErrorCode := 6;
      //后画武器
      if (m_nWpord = 1) and {(not blend) and} (m_btWeapon >= 2) and (m_WeaponSurface <> nil) {and (not m_boHideWeapon)20080803注释} then begin
         DrawEffSurface (dsurface, m_WeaponSurface, dx + m_nWpx + m_nShiftX, dy + m_nWpy + m_nShiftY, blend, ceNone);
         //DrawWeaponGlimmer (dsurface, dx + m_nShiftX, dy + m_nShiftY);
      end;
      ErrorCode := 7;
      if (m_btEffect = 50) then begin
        if not m_boDeath then begin //20080424 修正凤天死亡不显示光环
          if (m_HumWinSurface <> nil) then
            DrawBlend (dsurface, dx + m_nSpx + m_nShiftX, dy + m_nSpy + m_nShiftY, m_HumWinSurface, 1);
        end;
      end else
      if m_btEffect <> 0 then begin
        if ((m_btDir = 0) or (m_btDir = 7) or (m_btDir = 1) or (m_btDir = 6)  or (m_btDir = 2)) and (m_HumWinSurface <> nil) then begin
          if g_MySelf = Self then begin
            //if blend then begin    20080616修正隐身术 翅膀看不到问题
            {if not boFlag then begin
               DrawBlend (dsurface, dx + m_nSpx + m_nShiftX, dy + m_nSpy + m_nShiftY, m_HumWinSurface, 1);
            end else begin//0x0047D27F}
               DrawBlend (dsurface, dx + m_nSpx + m_nShiftX, dy + m_nSpy + m_nShiftY, m_HumWinSurface, 1);
            //end;
            //end;// gogo 0x0047D41D
          end else begin;//0x0047D30D
            if ((g_FocusCret <> nil) or (g_MagicTarget <> nil)) and not boFlag then begin
                 DrawBlend (dsurface,
                            dx + m_nSpx + m_nShiftX,
                            dy + m_nSpy + m_nShiftY,
                            m_HumWinSurface,
                            1);
            end else begin;//0x0047D3A0
              if boFlag then begin
                 DrawBlend (dsurface,
                            dx + m_nSpx + m_nShiftX,
                            dy + m_nSpy + m_nShiftY,
                            m_HumWinSurface,
                            1);
              end;//0x0047D41D
            end;
          end;
        end;
      end;//0x0047D41D

      ErrorCode := 8;
      if m_nState and $10000000 <> 0 then begin //小网状态
          idx := 3740 + (m_nGenAniCount mod 10);;
          d := g_WMonImagesArr[23].GetCachedImage(idx, ax, ay);
          if d <> nil then
            DrawBlend (dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, d, 1);
      end;
      ErrorCode := 9;

      //显示魔法盾时效果
      if m_nState and $00100000{STATE_BUBBLEDEFENCEUP} <> 0 then begin  //林贱狼阜
         if (m_nCurrentAction = SM_STRUCK) and (m_nCurBubbleStruck < 3) then
            idx := MAGBUBBLESTRUCKBASE + m_nCurBubbleStruck
         else
            idx := MAGBUBBLEBASE + (m_nGenAniCount mod 3);
         d := g_WMagicImages.GetCachedImage (idx, ax, ay);
         if d <> nil then
            DrawBlend (dsurface,
                             dx + ax + m_nShiftX,
                             dy + ay + m_nShiftY,
                             d, 1);
         {if g_boSkill31Effect and m_boMagbubble4 then begin  //4级魔法盾效果
         if (m_nCurrentAction = SM_STRUCK) and (m_nCurBubbleStruck < 3) then
            idx := 723 + m_nCurBubbleStruck
         else
            idx := 720 + (m_nGenAniCount mod 3);
         d := g_WMagic6Images.GetCachedImage (idx, ax, ay);
         if d <> nil then
            DrawBlend (dsurface,
                             dx + ax + m_nShiftX,
                             dy + ay + m_nShiftY,
                             d, 1);
         end;}
      end;

   end;
   ErrorCode := 10;
   DrawMyShow(dsurface,dx,dy); //显示自身动画   20080229
   ErrorCode := 11;
   //显示魔法效果
   if m_boUseMagic and (m_CurMagic.EffectNumber > 0) then begin
      if m_nCurEffFrame in [0..m_nSpellFrame-1] then begin
         ErrorCode := 15;
         GetEffectBase (m_CurMagic.EffectNumber-1, 0, wimg, idx);//取得魔法效果所在图库
         idx := idx + m_nCurEffFrame;//IDx对应WIL文件 里的图片位置，即用技能时显示的动画
         ErrorCode := 16;
         if wimg <> nil then begin
            ErrorCode := 17;
            d := wimg.GetCachedImage (idx, ax, ay);
         end;
         if d <> nil then begin
            ErrorCode := 18;
            DrawBlend (dsurface,
                             dx + ax + m_nShiftX,
                             dy + ay + m_nShiftY,
                             d, 1);
         end;
      end;
   end;
   ErrorCode := 12;
{----------------------------------------------------------------------------}
//显示攻击效果              2007.10.31 updata
//m_boHitEffect 是否是攻击类型
//m_nHitEffectNumber  使用攻击的数组 取出图的号
//m_btDir  方向
//m_nCurrentFrame 当前的桢数   m_nStartFrame开始的桢数
{----------------------------------------------------------------------------}
   if m_boHitEffect and (m_nHitEffectNumber > 0) then begin
      GetEffectBase (m_nHitEffectNumber - 1, 1, wimg, idx);
      if m_nHitEffectNumber = 8 then idx := idx{开始的号} + m_btDir{方向}*20 + (m_nCurrentFrame-m_nStartFrame){龙影剑法}
      else idx := idx{开始的号} + m_btDir{方向}*10 + (m_nCurrentFrame-m_nStartFrame);
       if wimg <> nil then
         d := wimg.GetCachedImage (idx, ax, ay);
      if d <> nil then
         DrawBlend (dsurface,
                          dx + ax + m_nShiftX,
                          dy + ay + m_nShiftY,
                          d, 1);
   end;
   ErrorCode := 13;
   //显示武器效果
   if m_boWeaponEffect then begin
      idx := WPEFFECTBASE + m_btDir * 10 + m_nCurWeaponEffect;
      d := g_WMagicImages.GetCachedImage (idx, ax, ay);
      if d <> nil then
         DrawBlend (dsurface,
                     dx + ax + m_nShiftX,
                     dy + ay + m_nShiftY,
                     d, 1);
   end;
   ErrorCode := 14;
  except
    DebugOutStr('THumActor.DrawChr'+IntToStr(ErrorCode));
  end;
end;

end.