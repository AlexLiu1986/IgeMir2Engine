unit Actor;  

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms,
  Grobal2, DxDraws, CliUtil, magiceff, Wil, SDK, ClFunc;

const
   HUMANFRAME = 600; //hum.wil,,,һ��Race��ռ��ͼƬ��
   MAXSAY = 5;
   RUN_MINHEALTH = 10;//�������Ѫ��ֻ���߶�
   DEFSPELLFRAME = 10; //ħ������
   MAGBUBBLEBASE = 3890;    //ħ����Ч��ͼλ��
   MAGBUBBLESTRUCKBASE = 3900; //������ʱħ����Ч��ͼλ��
   MAXWPEFFECTFRAME = 5;
   WPEFFECTBASE = 3750;
type
//��������
  TActionInfo = packed record
    start   :Word;//0x14              // ��ʼ֡
    frame   :Word;//0x16              // ֡��
    skip    :Word;//0x18              // ������֡��
    ftime   :Word;//0x1A              // ÿ֡���ӳ�ʱ�䣨���룩
    usetick :Word;//0x1C              // ���ƽ, �̵� ���ۿ��� ����
  end;
  pTActionInfo = ^TActionInfo;

//��ҵĶ�������
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
   //���ද������
   //ÿ������ÿ������ÿ���Ա�600��ͼ
   //�輶��=L���Ա�=S����ʼ֡=L*600+600*S

   //Start:�ö�������������µĿ�ʼ֡
   //frame:�ö�����Ҫ��֡��
   //skip:������֡��
   HA: THumanAction = (//��ʼ֡       ��Ч֡     ����֡    ÿ֡�ӳ�
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
   MA10: TMonsterAction = (  //(8Frame) ������ʿ
           //ÿ������8֡    //����������Ʋ�������м��֣�//������280��
        ActStand:  (start: 0;      frame: 4;  skip: 4;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 64;     frame: 6;  skip: 2;  ftime: 120;  usetick: 3);
        ActAttack: (start: 128;    frame: 4;  skip: 4;  ftime: 150;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 192;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 208;    frame: 4;  skip: 4;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 272;    frame: 1;  skip: 0;  ftime: 0;    usetick: 0);
      );
   MA11: TMonsterAction = (  //�罿(10Frame¥��)  //ÿ������10֡ //280,(360��),440,430,,
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 120;  usetick: 3);
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 340;    frame: 1;  skip: 0;  ftime: 0;    usetick: 0);
      );
   MA12: TMonsterAction = (  //���, ������ �ӵ� ������.//ÿ������8֡��ÿ������8�����򣬹�7�ֶ��� (280),360,440,430,,
        ActStand:  (start: 0;      frame: 4;  skip: 4;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 64;     frame: 6;  skip: 2;  ftime: 120;  usetick: 3);
        ActAttack: (start: 128;    frame: 6;  skip: 2;  ftime: 150;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 192;    frame: 2;  skip: 0;  ftime: 150;  usetick: 0);
        ActDie:    (start: 208;    frame: 4;  skip: 4;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 272;    frame: 1;  skip: 0;  ftime: 0;    usetick: 0);
      );
   MA13: TMonsterAction = (  //   mon2.wil�е�ʳ�˻�
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        //��mon2.wil���Կ���ʳ�˻�,actstand��ʳ�˻�վ��״̬
        ActWalk:   (start: 10;     frame: 8;  skip: 2;  ftime: 160;  usetick: 0); 
        //actwalkʵ������ʳ�˻�վ������������Ч��ע�⵽��β������ʵ��һЩobjects.wil����Ҳ������tiles
         //ʯĹʬ�������ʱ�ĵ�ͼЧ������ʳ�˻���Ч�����������ƣ���֪�������Ķ��������ǲ���Ҳ����ma13
        ActAttack: (start: 30;     frame: 6;  skip: 4;  ftime: 120;  usetick: 0);
        //actattack��30��ʼ�ǴӸ�����λ������Ч��
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        //actcritical���������ȥ
        ActStruck: (start: 110;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        //����110��ʼ����
        ActDie:    (start: 130;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        //130��ʼ����Ч��
        ActDeath:  (start: 20;     frame: 9;  skip: 0;  ftime: 150;  usetick: 0);
        //20��ʼ��ʳ�˻�������Ч��Ҳ��������Ч�������������ã���ֻ��9֡���һ֡��ȥ
      );
   MA14: TMonsterAction = (  //�ذ� ���� mon3���������սʿ,,��������ͬma13
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 340;    frame: 10; skip: 0;  ftime: 100;  usetick: 0); //����ΰ��(��ȯ)
      );
   MA15: TMonsterAction = (  //����ս��??�����⣺Դ�����жԹ���ķ����߼��ǲ��Ǿ���mon*.wil�ķ����߼�
        //��ע�⵽����սʿ������û��,�����Ŀ��Ǻ��꣬���ѵ���Ҳ��hum.wilһ��Ҫ��weapon.wil�ҹ����ܹ�������������?
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        //die��death��ʲô����???һ����������ʼ����һ�����ڵ����ϵĲк�??���ǰ�����˵������߼����԰�!!
        ActDeath:  (start: 1;      frame: 1;  skip: 0;  ftime: 100;  usetick: 0);
      );
   MA16: TMonsterAction = (  //������� ������  mon5����ĵ罩ʬ����������ƶ���ħ�����������Ĺ���һ��??
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 4;  skip: 6;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 1;  skip: 0;  ftime: 160;  usetick: 0);
      );
   MA17: TMonsterAction = (  //�ٵ������� ��  mon6�еĺ��н�������ʯĹʬ������һ����
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
   MA24: TMonsterAction = (  // (����) mon14�е�Ы��??ͨ�����µķ��������ֲ���?
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
             //��ʼ֡    ��Ч֡    ����֡   ÿ֡�ӳ�
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    //actstand��վ��״̬
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:200;  usetick:3);
    ActAttack:(Start:160;  frame:6;  skip:4;  ftime:120;  usetick:0);
    //actattack��30��ʼ�ǴӸ�����λ������Ч��
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
  {MA47: TMonsterAction = (//4C0A4C ��Ѫ����
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
  MA50: TMonsterAction = ( //ѩ��
    ActStand:  (start: 0;      frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    ActWalk:   (start: 0;     frame: 10;  skip: 0;  ftime: 60;  usetick: 3);
    ActAttack: (start: 0;    frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    ActCritical:(start: 0;   frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    ActStruck: (start: 0;    frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    ActDie:    (start: 0;    frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    ActDeath:  (start: 0;   frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    );
  MA51: TMonsterAction = ( //ѩ��
    ActStand:  (start: 0;      frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    ActWalk:   (start: 0;     frame: 1;  skip: 0;  ftime: 60;  usetick: 3);
    ActAttack: (start: 0;    frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    ActCritical:(start: 0;   frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    ActStruck: (start: 0;    frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    ActDie:    (start: 0;    frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    ActDeath:  (start: 0;   frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    );
  MA70: TMonsterAction = (//�����ʼ�NPC
    ActStand:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActAttack:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActCritical:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActStruck:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActDie:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    );
  MA71: TMonsterAction = (//�ƹ�3������NPC 20080308
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:10;  frame:19;  skip:0;  ftime:200;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA93: TMonsterAction = ( //�������� 200808012
      ActStand:  (start: 0;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
      ActWalk:   (start: 80;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3);
      ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
      ActCritical:(start: 340;     frame: 10;  skip: 0;  ftime: 160;    usetick: 0);
      ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
      ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 160;  usetick: 0);
      ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 0;  usetick: 0);
    );
  MA100: TMonsterAction = (//����
    ActStand:(Start:360;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:440;  frame:6;  skip:4;  ftime:200;  usetick:3);
    ActAttack:(Start:520;  frame:6;  skip:4;  ftime:160;  usetick:0);

    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:600;  frame:2;  skip:0;  ftime:100;  usetick:0);//�ܹ���
    ActDie:(Start:620;  frame:6;  skip:4;  ftime:130;  usetick:0);
    ActDeath:(Start:0;  frame:10;  skip:0;  ftime:100;  usetick:0);
    );
{------------------------------------------------------------------------------}
// ��������˳�� (�Ƿ������������: 0��/1��)
// WEAPONORDERS: array [Sex, FrameIndex] of Byte
{------------------------------------------------------------------------------}
   WORDER: Array[0..1, 0..599] of byte = (  //1: Ů,  0: ��
                                            //��һά���Ա𣬵ڶ�ά�Ƕ���ͼƬ����
      (       //��
      //վ
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,1,1,1,1,
      0,0,0,0,1,1,1,1,    0,0,0,0,1,1,1,1,
      //��
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,0,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //��
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,1,1,1,1,1,1,    0,0,1,1,1,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //war���
      0,1,1,1,0,0,0,0,
      //��
      1,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,    1,1,1,0,0,0,0,0,
      1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,0,0,0,0,0,
      0,0,0,0,0,0,0,0,    1,1,1,1,0,0,1,1,
      //�� 2
      0,1,1,0,0,0,1,1,    0,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,
      1,1,1,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,0,1,1,1,0,0,    0,1,1,1,1,0,1,1,
      //��3
      1,1,0,1,0,0,0,0,    1,1,0,0,0,0,0,0,    1,1,1,1,1,0,0,0,
      1,1,0,0,1,0,0,0,    1,1,1,0,0,0,0,1,    0,1,1,0,0,0,0,0,
      0,0,0,0,1,1,1,0,    1,1,1,1,1,0,0,0,
      //����
      0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,
      1,0,0,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,1,1,0,0,1,1,    0,0,0,1,0,0,1,1,
      //�ر�
      0,0,1,0,1,1,1,1,    1,1,0,0,0,1,0,0,
      //�±�
      0,0,0,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      //������
      0,0,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1
      ),

      (
      //����
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,1,1,1,1,
      0,0,0,0,1,1,1,1,    0,0,0,0,1,1,1,1,
      //�ȱ�
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,0,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //�ٱ�
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,1,1,1,1,1,1,    0,0,1,1,1,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //war���
      1,1,1,1,0,0,0,0,
      //����
      1,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,    1,1,1,0,0,0,0,0,
      1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,0,0,0,0,0,
      0,0,0,0,0,0,0,0,    1,1,1,1,0,0,1,1,
      //���� 2
      0,1,1,0,0,0,1,1,    0,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,
      1,1,1,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,0,1,1,1,0,0,    0,1,1,1,1,0,1,1,
      //����3
      1,1,0,1,0,0,0,0,    1,1,0,0,0,0,0,0,    1,1,1,1,1,0,0,0,
      1,1,0,0,1,0,0,0,    1,1,1,0,0,0,0,1,    0,1,1,0,0,0,0,0,
      0,0,0,0,1,1,1,0,    1,1,1,1,1,0,0,0,
      //����
      0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,
      1,0,0,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,1,1,0,0,1,1,    0,0,0,1,0,0,1,1,
      //�ر�
      0,0,1,0,1,1,1,1,    1,1,0,0,0,1,0,0,
      //�±�
      0,0,0,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      //������
      0,0,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1
      )
   );


type
   TActor = class
     m_nRecogId                :Integer;    //��ɫ��ʶ 0x4
     m_nCurrX                  :Integer;    //��ǰ���ڵ�ͼ����X 0x08
     m_nCurrY                  :Integer;    //��ǰ���ڵ�ͼ����Y 0x0A
     m_btDir                   :Byte;       //��ǰվ������ 0x0C
     m_btSex                   :Byte;       //�Ա� 0x0D
     m_btRace                  :Byte;       //0x0E
     m_btHair                  :Byte;       //ͷ������ 0x0F
     m_btDress                 :Byte;       //�·����� 0x10
     m_btWeapon                :Byte;       //��������
     //m_btHorse                 :Byte;       //������   20080721 ע������
     m_btEffect                :Byte;       //��ʹ����
     m_btJob                   :Byte;       //ְҵ 0:��ʿ  1:��ʦ  2:��ʿ
     m_wAppearance             :Word;       //0x14 DIV 10=���壨��ò���� Mod 10=��òͼƬ��ͼƬ���е�λ�ã��ڼ��֣�
     m_nLoyal                  :Integer;    //Ӣ���ҳ϶�
     m_nFeature                :Integer;    //0x18
     m_nFeatureEx              :Integer;    //0x18
     m_nState                  :Integer;    //0x1C
     m_boDeath                 :Boolean;    //0x20
     m_boSkeleton              :Boolean;    //0x21
     m_boDelActor              :Boolean;    //0x22
     m_boDelActionAfterFinished :Boolean;   //0x23
     m_sDescUserName           :String;     //�������ƣ���׺
     m_sUserName               :String;     //����
     m_nNameColor              :Integer;    //������ɫ
     m_btMiniMapHeroColor      :byte;       //Ӣ��С��ͼ������ɫ
     m_Abil                    :TAbility;   //��������
     m_nGold                   :Integer;    //�������0x58
     m_nGameGold               :Integer;    //��Ϸ������
     m_nGamePoint              :Integer;    //��Ϸ������
     m_nGameDiaMond            :Integer;    //���ʯ����  2008.02.11
     m_nGameGird               :Integer;    //�������  2008.02.11
     m_nGameGlory              :Byte; //�������� 20080511

     m_nHitSpeed               :ShortInt;   //�����ٶ� 0: �⺻, (-)���� (+)����
     m_boVisible               :Boolean;    //0x5D
     m_boHoldPlace             :Boolean;    //0x5E

     m_SayingArr               :array[0..MAXSAY-1] of String;  //���˵�Ļ�
     m_SayWidthsArr            :array[0..MAXSAY-1] of Integer; //ÿ�仰�Ŀ��
     m_dwSayTime               :LongWord;
     m_nSayX                   :Integer;
     m_nSayY                   :Integer;
     m_nSayLineCount           :Integer;

     m_nShiftX                 :Integer;    //0x98
     m_nShiftY                 :Integer;    //0x9C

     //m_nLightX                 :Integer;  //����ͼƬ���� �� 2007.12.12
     m_nPx                     :Integer;  //0xA0
     m_nHpx                    :Integer;  //0xA4
     m_nWpx                    :Integer;  //0xA8
     m_nSpx                    :Integer;  //0xAC

     //m_nLightY                 :Integer;  //����ͼƬ���� �� 2007.12.12
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
     m_nCurrentEvent           :Integer; //������ �̺�Ʈ ���̵�
     m_boDigFragment           :Boolean; //�ڿ�Ч��
     //m_boThrow                 :Boolean;  20080803ע��

     m_nBodyOffset             :Integer;     //0x0E8   //0x0D0 // ����ͼƬ��������ƫ��
     m_nHairOffset             :Integer;     //0x0EC           // ͷ��ͼƬ��������ƫ��
     m_nHumWinOffset           :Integer;   //0x0F0
     m_nWeaponOffset           :Integer;   //0x0F4             // ����ͼƬ��������ƫ��
     m_boUseMagic              :Boolean;    //0x0F8   //0xE0
     m_boHitEffect             :Boolean;   //0x0F9    //0xE1
     m_boUseEffect             :Boolean;   //0x0FA    //0xE2
     m_nHitEffectNumber        :Integer;              //0xE4
     m_dwWaitMagicRequest      :LongWord;
     m_nWaitForRecogId         :Integer;  //�ڽ��� ������� WaitFor�� actor�� visible ��Ų��.
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

      //SRc: TRect;  //Screen Rect ȭ���� ������ǥ(���콺 ����)
     m_BodySurface             :TDirectDrawSurface;    //0x14C   //0x134

    // m_LightSurface             :TDirectDrawSurface;    //0x14C   //0x134

     m_boGrouped               :Boolean;    // �Ƿ����
     m_nCurrentAction          :Integer;    //0x154         //0x13C
     m_boReverseFrame          :Boolean;    //0x158
     m_boWarMode               :Boolean;    //0x159
     m_dwWarModeTime           :LongWord;   //0x15C
     m_nChrLight               :Integer;    //0x160
     m_nMagLight               :Integer;    //0x164
     m_nRushDir                :Integer;  //0, 1
     //m_nXxI                    :Integer; //0x16C   20080521 ע��û�õ�����
     m_boLockEndFrame          :Boolean;
     m_dwLastStruckTime        :LongWord;  
     m_dwSendQueryUserNameTime :LongWord;
     m_dwDeleteTime            :LongWord;


     m_nMagicStruckSound       :Integer;  //0x180 ��ħ��������������������
     m_boRunSound              :Boolean;  //0x184 �ܲ�����������
     m_nFootStepSound          :Integer;  //CM_WALK, CM_RUN //0x188  �߲���
     m_nStruckSound            :Integer;  //SM_STRUCK         //0x18C  ��������
     m_nStruckWeaponSound      :Integer;                //0x190  ��ָ������������������

     m_nAppearSound            :Integer;  //����Ҹ� 0    //0x194
     m_nNormalSound            :Integer;  //�ϹݼҸ� 1    //0x198
     m_nAttackSound            :Integer;  //         2    //0x19C
     m_nWeaponSound            :Integer; //          3    //0x1A0
     m_nScreamSound            :Integer;  //         4    //0x1A4
     m_nDieSound               :Integer;     //������   5 SM_DEATHNOW //0x1A8
     m_nDie2Sound              :Integer;                    //0x1AC

     m_nMagicStartSound        :Integer;     //0x1B0
     m_nMagicFireSound         :Integer;      //0x1B4
     m_nMagicExplosionSound    :Integer; //0x1B8
     m_Action                  :pTMonsterAction;
     //Ӣ���ٻ����˳� begin
     HeroLoginStartFrame       :Integer; //Ӣ�۵�½��ʼ֡
     HeroLoginExplosionFrame   :Integer; //Ӣ�۵�½���󲥷ŵ�֡��
     HeroLoginNextFrameTime    :Integer; //Ӣ�۵�½ʱ����
     HeroTime                  :LongWord;
     HeroFrame                 :Integer;
     g_HeroLoginOrLogOut       :Boolean; //Ӣ���ٻ����˳�
     // end
{******************************************************************************}
     //��������ʾ���� begin   2008.01.13
     m_nMyShowStartFrame        :Integer; //��������ʼ֡
     m_nMyShowExplosionFrame    :Integer; //���������󲥷ŵ�֡��
     m_nMyShowNextFrameTime     :LongWord; //������ʱ����
     m_nMyShowTime              :LongWord; //��ǰʱ��
     m_nMyShowFrame             :Integer; //��ǰ֡
     g_boIsMyShow               :Boolean; //�Ƿ���ʾ����{�ӵ���ϢΪTrue}
     g_MagicBase                :TWMImages; //ͼ��
     m_boNoChangeIsMyShow       :Boolean; //�Ƿ񷢳��Ķ������겻�������ﶯ�����仯  20080306
     m_nNoChangeX, m_nNoChangeY :Integer; //���ı䶯��������X��Y  20080306
{******************************************************************************}
     //g_boIsHero                 :Boolean;

      m_Skill69NH: Word;//��ǰ����ֵ 20080930
      m_Skill69MaxNH: Word;//�������ֵ 20080930

   private
     function GetMessage(ChrMsg:pTChrMsg):Boolean;
   protected
     m_nStartFrame             :Integer;      //0x1BC        //0x1A8  // ��ǰ�����Ŀ�ʼ֡����
     m_nEndFrame               :Integer;        //0x1C0      //0x1AC  // ��ǰ�����Ľ���֡����
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
     //m_nSkipTick               :Integer;           //20080816ע�͵��𲽸���
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
      procedure  RunFrameAction (frame: integer); dynamic;  //�����Ӹ��� ��Ư�ϰ� �ؾ�����
      procedure  ActionEnded; dynamic;
      function   Move (step: integer): Boolean;
      procedure  MoveFail;
      function   CanCancelAction: Boolean;
      procedure  CancelAction;
      procedure  FeatureChanged; dynamic;
      function   Light: integer; dynamic;
      procedure  LoadSurface; dynamic;
      function   GetDrawEffectValue: TColorEffect;
      procedure  HeroLoginOrLogOut(dsurface: TDirectDrawSurface;dx,dy:integer); dynamic; //�ٻ�Ӣ�۶���
      procedure  DrawMyShow(dsurface: TDirectDrawSurface;dx,dy:integer); //ͨ������������ʾ 20080113
      procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); dynamic;
      procedure  DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); dynamic;
   end;

   TNpcActor = class (TActor)
   private
     m_nEffX      :Integer; //0x240
     m_nEffY      :Integer; //0x244
     m_bo248      :Boolean; //0x248
     m_dwUseEffectTick    :LongWord; //0x24C
     m_EffSurface       :TDirectDrawSurface; //��NPC ħ������Ч��
     //�ƹ�2���ϰ����߶�  20080621
     m_boNpcWalkEffect  :Boolean;  //�Ƿ��߶��йֶ���Ч�� 
     m_boNpcWalkEffectSurface :TDirectDrawSurface;
     m_nNpcWalkEffectPx :Integer;
     m_nNpcWalkEffectPy :Integer;
   public
     g_boNpcWalk  :Boolean; //NPC�߶� 20080621
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
     m_HairSurface         :TDirectDrawSurface; //0x250  //0x240  //ͷ����� ���� 2007.10.21
     m_WeaponSurface       :TDirectDrawSurface; //0x254  //0x244  //������� ���� 2007.10.21
     m_HumWinSurface       :TDirectDrawSurface; //0x258  //0x248  //������� ���� 2007.10.21
     m_boWeaponEffect      :Boolean;            //0x25C  //0x24C
     m_nCurWeaponEffect    :Integer;            //0x260  //0x250
     m_nCurBubbleStruck    :Integer;            //0x264  //0x254
     m_nCurProtEctionStruck :Integer;
     m_dwProtEctionStruckTime :Longword;
     
     m_dwWeaponpEffectTime :LongWord;           //0x268
     //m_boHideWeapon        :Boolean;            20080803ע��
     m_nFrame              :Integer;
     m_dwFrameTick         :LongWord;
     m_dwFrameTime         :LongWord;
//     m_bo2D0               :Boolean;   //20080721
   protected
      procedure CalcActorFrame; override;
      procedure DefaultMotion; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
   public
      //m_boMagbubble4  :Boolean; //�Ƿ���4��ħ����״̬
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
  m_nFootStepSound           := -1; //����  //���ΰ��ΰ��, CM_WALK, CM_RUN
  m_nAttackSound             := -1;
  m_nWeaponSound             := -1;
  m_nStruckSound             := s_struck_body_longstick;  //������ ���� �Ҹ�    SM_STRUCK
  m_nStruckWeaponSound       := -1;
  m_nScreamSound             := -1;
  m_nDieSound                := -1;    //����    //������ ���� �Ҹ�    SM_DEATHNOW
  m_nDie2Sound               := -1;


   m_Skill69NH:=0;//��ǰ����ֵ 20080930
   m_Skill69MaxNH:=0;//�������ֵ 20080930
end;


function GetRaceByPM (race: integer;Appr:word): pTMonsterAction;
begin
   Result := nil;
  case Race of
    9{01}: Result:=@MA9; //δ֪
    10{02}: Result:=@MA10; //δ֪
    11{03}: Result:=@MA11; //����¹
    12{04}: Result:=@MA12; //����ʿ
    13{05}: Result:=@MA13; //ʳ�˻�
    14{06}: Result:=@MA14; //����ϵ�й�
    15{07}: Result:=@MA15; //��������
    16{08}: Result:=@MA16; //����
    17{06}: Result:=@MA14; //�๳è
    18{06}: Result:=@MA14; //������
    19{0A}: Result:=@MA19; //�����ˡ���󡡢��֩��֮���
    20{0A}: Result:=@MA19; //��������
    21{0A}: Result:=@MA19; //�������
    22{07}: Result:=@MA15; //����սʿ������֩��
    23{06}: Result:=@MA14; //��������
    24{04}: Result:=@MA12; //��������
    30{09}: Result:=@MA17; //δ֪
    31{09}: Result:=@MA17; //�۷�
    32{0F}: Result:=@MA24; //Ы��
    33{10}: Result:=@MA25; //������
    34{11}: Result:=@MA30; //���¶�ħ�����䡢ǧ������
    35{12}: Result:=@MA31; //δ֪
    36{13}: Result:=@MA32; //475E48
    37{0A}: Result:=@MA19; //475DDC
    40{0A}: Result:=@MA19; //475DDC
    41{0B}: Result:=@MA20; //475DE8
    42{0B}: Result:=@MA20; //475DE8
    43{0C}: Result:=@MA21; //475DF4
    45{0A}: Result:=@MA19; //475DDC
    47{0D}: Result:=@MA22; //�������
    48{0E}: Result:=@MA23; //475E0C
    49{0E}: Result:=@MA23; //�������
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
        53{03}: Result:=@MA35; //������� 20081024
        54..58: Result:=@MA50; //ѩ��
        59    : Result:=@MA51; //ѩ��
        62    : Result:=@MA70; //���ر���  20080301
        65..66: Result:=@MA70;  //��������  20080301
        70..75: Result:=@MA70;  //����NPC
        90..92: Result:=@MA70; //������Ŀձ���NPC  20080301
        82..84: Result:=@MA71; //�ƹ�3������NPC 20080308
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
    83{23}: Result:=@MA44; //��������  20080305
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
    92: Result := @MA19;   //����֩��
    93: Result := @MA93;  //��������
    100{28}: Result:=@MA100//����
  end

end;

//�����������òȷ����ͼƬ���еĿ�ʼλ��
function GetOffset (appr: integer): integer;
var
   nrace, npos: integer;
begin
   Result := 0;
   if (appr >= 1000) then Exit;
   nrace := appr div 10;         //ͼƬ��
   npos := appr mod 10;          //ͼƬ���е��������
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
      18:   case npos of  //20080508�޸�    ħ��ϵ�й�
              { 0: Result := 0;   //����
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
               0: Result := 0;   //����
               1: Result := 370;
               2: Result := 810;
               3: Result := 1250;
               4: Result := 1630;
               5: Result := 2010;
               6: Result := 2390;
            end;
      20:   case npos of
               0: Result := 0;   //����
               1: Result := 360;
               2: Result := 720;
               3: Result := 1080;
               4: Result := 1440;
               5: Result := 1800;
               6: Result := 2350;
               7: Result := 3060;
            end;
      21:   case npos of
               0: Result := 0;   //����
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
      23:   case npos of    //20080328 24.wil ��չ
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
      24:   case npos of    //20081213 25.wil��չ
               0: Result := 0;
               1: Result := 510;
            end;
      25:   case npos of   //20081213 26.wil��չ
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
      26:   case npos of  //20081213 27.wil��չ
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
               0: Result := 0;   //����
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
               0: Result := 80;   //����
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
    //ѩ��NPC
    54: Result:=4490;
    55: Result:=4500;
    56: Result:=4510;
    57: Result:=4520;
    58: Result:=4530;
    59: Result:=4540;

    //����
    70: Result:=3780;
    71: Result:=3790;
    72: Result:=3800;
    73: Result:=3810;
    74: Result:=3820;
    75: Result:=3830;
    90: Result:=3750; //������Ŀձ���NPC  20080301
    91: Result:=3760; //������Ŀձ���NPC  20080301
    92: Result:=3770; //������Ŀձ���NPC  20080301
    65: Result:=3360; //�������� NPC 20080301 ��λ1
    66: Result:=3380; //�������� NPC 20080301 ��λ2
    62: Result:=3180; //���ر��� NPC 20080301
    80: Result:=3840; //�ƹݵĵ�С�� 20080308
    81: Result:=3900; //�ƹ��ϰ���  20080308
    82: Result:=3960; //�ƹ�Ӱ�� 20080308
    83: Result:=3980; //�ƹݳ��� 20080308
    84: Result:=4000; //�ƹ����� 20080308
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


//��ɫ���յ�����Ϣ
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

//������Ϣ���£����Ѿ����ڣ���Ϣ�б�
procedure TActor.UpdateMsg(wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer);
var
  I: integer;
  Msg:pTChrMsg;
begin
  m_MsgList.Lock;
  try
    I:= 0;
    while TRUE do begin
      //�ӵ�ǰ��Ϣ�б���Ѱ��,���ҵ�,��ɾ��,ͬʱ�����ǰ��ҿ��ƵĽ�ɫ���ߡ��ܵ���Ϣ����Ϊ��Щ��Ϣ�Ѿ������ˡ�
      if I >= m_MsgList.Count then break;
      Msg:=m_MsgList.Items[I]; //ԭ����
      if ((Self = g_MySelf) and (Msg.Ident >= 3000) and (Msg.Ident <= 3099)) or (Msg.Ident = wIdent) then begin
        Dispose(Msg);       //ɾ���Ѿ����ڵ���ͬ��Ϣ
        m_MsgList.Delete(I);
        Continue;
      end;
      Inc(I);
    end;
  finally
    m_MsgList.UnLock;
  end;
  SendMsg (wIdent,nX,nY,nDir,nFeature,nState,sStr,nSound);   //�����Ϣ
end;

//�����Ϣ����[3000,3099]֮�����Ϣ
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
      {if (Msg.Ident >= 3000) and //�����˶���Ϣ���ߡ��ܵ�
         (Msg.Ident <= 3099) then begin }
       if (Msg.Ident > 2999) and //�����˶���Ϣ���ߡ��ܵ�
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

//��ɫ��������
procedure TActor.CalcActorFrame;
begin
  m_boUseMagic    := FALSE;
  m_nCurrentFrame := -1;
  //����appr���㱾��ɫ��ͼƬ���еĿ�ʼͼƬ����
  m_nBodyOffset   := GetOffset (m_wAppearance);
  //������Ӧ��ͼƬ���ж���
  m_Action := GetRaceByPM(m_btRace,m_wAppearance);
  if m_Action = nil then exit;

   case m_nCurrentAction of
      SM_TURN://ת��=վ�������Ŀ�ʼ֡ + ���� X վ��������ͼƬ��
         begin
            m_nStartFrame := m_Action.ActStand.start + m_btDir * (m_Action.ActStand.frame + m_Action.ActStand.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActStand.frame - 1;
            m_dwFrameTime := m_Action.ActStand.ftime;
            m_dwStartTime := GetTickCount;
            m_nDefFrameCount := m_Action.ActStand.frame;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_WALK{��}, SM_RUSH, SM_RUSHKUNG, SM_BACKSTEP:  //�߶�=�߶������Ŀ�ʼ֡ + ���� X ÿ�����߶�������ͼƬ��
         begin
            m_nStartFrame := m_Action.ActWalk.start + m_btDir * (m_Action.ActWalk.frame + m_Action.ActWalk.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActWalk.frame - 1;
            m_dwFrameTime := m_Action.ActWalk.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := m_Action.ActWalk.UseTick;
            m_nCurTick := 0;
            m_nMoveStep := 1;
            if m_nCurrentAction = SM_BACKSTEP then    //ת��
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
      SM_HIT{��ͨ����}:
         begin
            m_nStartFrame := m_Action.ActAttack.start + m_btDir * (m_Action.ActAttack.frame + m_Action.ActAttack.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActAttack.frame - 1;
            m_dwFrameTime := m_Action.ActAttack.ftime;
            m_dwStartTime := GetTickCount;
            //WarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_STRUCK:{�ܹ���}
         begin
            m_nStartFrame := m_Action.ActStruck.start + m_btDir * (m_Action.ActStruck.frame + m_Action.ActStruck.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActStruck.frame - 1;
            m_dwFrameTime := m_dwStruckFrameTime; //pm.ActStruck.ftime;
            m_dwStartTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_DEATH:   //������
         begin
            m_nStartFrame := m_Action.ActDie.start + m_btDir * (m_Action.ActDie.frame + m_Action.ActDie.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActDie.frame - 1;
            m_nStartFrame := m_nEndFrame; //
            m_dwFrameTime := m_Action.ActDie.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_NOWDEATH: //����
         begin
            m_nStartFrame := m_Action.ActDie.start + m_btDir * (m_Action.ActDie.frame + m_Action.ActDie.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActDie.frame - 1;
            m_dwFrameTime := m_Action.ActDie.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_SKELETON:  //�������ˣ����ٶ�����
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
   m_nActBeforeX := m_nCurrX;        //����֮ǰ��λ�ã������������Ͽ�ʱ���Ի�ȥ)
   m_nActBeforeY := m_nCurrY;

   if msg.Ident = SM_ALIVE then begin      //����
      m_boDeath := FALSE;
      m_boSkeleton := FALSE;
   end;
   if not m_boDeath then begin
      case msg.Ident of
         SM_TURN, SM_WALK, SM_NPCWALK, SM_BACKSTEP, SM_RUSH, SM_RUSHKUNG, SM_RUN, {SM_HORSERUN,20080803ע��������Ϣ} SM_DIGUP, SM_ALIVE:
            begin
               m_nFeature := msg.feature;
               m_nState := msg.state;
               //�Ƿ���Բ鿴��ɫ����ֵ
               if m_nState and STATE_OPENHEATH <> 0 then m_boOpenHealth := TRUE
               else m_boOpenHealth := FALSE;
            end;
      end;
      if msg.ident = SM_LIGHTING then n := 0;
      if (g_MySelf = self) then begin
         if (msg.Ident = CM_WALK) then
            if not PlayScene.CanWalk (msg.x, msg.y) then
               exit;  //��������
         if (msg.Ident = CM_RUN) then
            if not PlayScene.CanRun (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, msg.x, msg.y) then
               exit; //������
         {if (msg.Ident = CM_HORSERUN) then  20080803ע��������Ϣ
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
                  RealActionMsg := msg; //���浱ǰ����
                  msg.Ident := msg.Ident - 3000;  //SM_?? ���� ��ȯ ��
               end;
            {CM_HORSERUN: begin  20080803ע��������Ϣ
              RealActionMsg:=msg;
              msg.Ident:=SM_HORSERUN;
            end; }
            CM_THROW: begin
              if m_nFeature <> 0 then begin
                m_nTargetX := TActor(msg.feature).m_nCurrX;  //x ������ ��ǥ
                m_nTargetY := TActor(msg.feature).m_nCurrY;    //y
                m_nTargetRecog := TActor(msg.feature).m_nRecogId;
              end;
              RealActionMsg := msg;
              msg.Ident := SM_THROW;
            end;
            CM_FIREHIT: begin  //�һ�
              RealActionMsg := msg;
              msg.Ident := SM_FIREHIT;
            end;
            CM_4FIREHIT: begin  //4���һ�
              RealActionMsg := msg;
              msg.Ident := SM_4FIREHIT;
            end;
            CM_DAILY: begin //���ս��� 20080511
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
            CM_QTWINHIT: begin   //����ն��� 2008.02.12
              RealActionMsg := msg;
              msg.Ident := SM_QTWINHIT;
            end;
            CM_CIDHIT: begin {��Ӱ����}
              RealActionMsg := msg;
              msg.Ident := SM_CIDHIT;
            end;
            CM_3037: begin
              RealActionMsg := msg;
              msg.Ident := SM_41;
            end;
            CM_SPELL: begin
                  RealActionMsg := msg;
                  UseMagic := PTUseMagicInfo (msg.feature);   //����msg.feature���pmagָ��
                  RealActionMsg.Dir := UseMagic.MagicSerial;
                  msg.Ident := msg.Ident - 3000;  //SM_?? ���� ��ȯ ��
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
               //m_dwLastStruckTime := GetTickCount;  20080521 ע��û�õ�����
            end;
         SM_SPELL:
            begin
               m_btDir := msg.dir;
               //msg.x  :targetx
               //msg.y  :targety
               UseMagic := PTUseMagicInfo (msg.feature);
               if UseMagic <> nil then begin
                  m_CurMagic := UseMagic^;
                  m_CurMagic.ServerMagicCode := -1; //FIRE ���
                  //CurMagic.MagicSerial := 0;
                  m_CurMagic.TargX := msg.x;
                  m_CurMagic.TargY := msg.y;
                  Dispose (UseMagic);
               end;
            end;
         SM_RUSHKUNG: begin  //20080409  ��ֹӢ����Ұ����ʧ
               m_nFeature := msg.feature;
               m_nState := msg.state;
               //�Ƿ���Բ鿴��ɫ����ֵ
               if m_nState and STATE_OPENHEATH <> 0 then m_boOpenHealth := TRUE
               else m_boOpenHealth := FALSE;
         end;
         else begin  //�˾����ü���ʧ�� �����ܵ���Ϣ����ȥ  20080409
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

         SM_SPACEMOVE_HIDE: begin  //�޸Ĵ��͵�ͼ����ʾ���� 20080521
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
         SM_SPACEMOVE_SHOW: begin  //�޸Ĵ��͵�ͼ����ʾ���� 20080521
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
         SM_CRSHIT,SM_TWINHIT,SM_QTWINHIT,SM_CIDHIT, SM_4FIREHIT,SM_FAIRYATTACKRATE,SM_DAILY{���ս���},SM_LEITINGHIT{����һ��սʿЧ�� 20080611}: ReadyAction (msg); //���Ӣ�۷ſ�����Ӱ ����������
         else
            begin
               //ReadyAction (msg); //�������ı��ͼ�������� 20080410
            end;
      end;
   end;

end;

procedure TActor.ProcHurryMsg; //������Ϣ����ʹ��ħ����ħ��ʧ��
var
   n: integer;
   msg: TChrMsg;
   fin: Boolean;
begin
   n := 0;
   while TRUE do begin    
      if m_MsgList.Count <= n then break;
      msg := PTChrMsg (m_MsgList[n])^;   //ȡ����Ϣ
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
               //���������ʾʹ��ħ�������ƣ����ǿͻ��˲�֪��ħ�������ƣ�
               //Ӧ���ڱ��ر���һ��ħ�������б�����ServerMaigicCode�������
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
//��ǰ�Ƿ�û�п�ִ�еĶ���
function  TActor.IsIdle: Boolean;
begin
   if (m_nCurrentAction = 0) and (m_MsgList.Count = 0) then
      Result := TRUE
   else Result := FALSE;
end;
//��ǰ�����Ƿ��Ѿ����
function  TActor.ActionFinished: Boolean;
begin
   if (m_nCurrentAction = 0) or (m_nCurrentFrame >= m_nEndFrame) then
      Result := TRUE
   else Result := FALSE;
end;
//�ɷ�����
function  TActor.CanWalk: Integer;
begin
   if {(GetTickCount - LastStruckTime < 1300) or}(GetTickCount - g_dwLatestSpellTick < g_dwMagicPKDelayTime) then
      Result := -1   
   else
      Result := 1;
end;
//�ɷ���
function  TActor.CanRun: Integer;
begin
   Result := 1;
   //��������HPֵ�Ƿ����ָ��ֵ������ָ��ֵ����������
   if m_Abil.HP < RUN_MINHEALTH then begin
      Result := -1;
   end else
   //��������Ƿ񱻹�����������������������ܣ�ȡ����⽫�����ܲ�����
//   if (GetTickCount - LastStruckTime < 3*1000) or (GetTickCount - LatestSpellTime < MagicPKDelayTime) then
//      Result := -2;

end;


//dir : ����
//step : ����  (����1������2��
//cur : ��ǰ֡(ȫ��֡�еĵڼ�֡��
//max : ȫ��֡
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
//������ò�����ı�
procedure  TActor.FeatureChanged;
var
   haircount: integer;
begin
   case m_btRace of
      0,1,150: begin //����,Ӣ��,���� 20080629
         m_btHair   := HAIRfeature (m_nFeature);// �õ�M2������Ӧ�ķ��� , Ů=7 ��=6 ����,Ӣ�� Ů=3 ��=4
         m_btDress  := DRESSfeature (m_nFeature);
         m_btWeapon := WEAPONfeature (m_nFeature);
         //m_btHorse  := Horsefeature(m_nFeatureEx); 20080721 ע������
         m_btEffect := Effectfeature(m_nFeatureEx);
         m_nBodyOffset := HUMANFRAME * m_btDress; //��0, Ů1
         haircount := g_WHairImgImages.ImageCount div {HUMANFRAME}1200 div 2; //ÿ�Ա�����=3600 /600 /2 =3
        if m_btHair = High(m_btHair) then begin //����
            m_nHairOffset := HUMANFRAME*(m_btSex + 6);
        end else 
        if m_btHair = 254 then begin     //��ɫ����Ϊ254
            m_nHairOffset := HUMANFRAME * (m_btSex + 8);
        end else begin
              if m_btSex = 1 then begin //Ů
                if m_btHair = 1 then m_nHairOffset := 600
                else begin
                   if m_btHair > haircount-1 then m_btHair := haircount-1;
                   m_btHair := m_btHair * 2;
                   if m_btHair > 1 then
                      m_nHairOffset := HUMANFRAME * (m_btHair + m_btSex)
                   else m_nHairOffset := -1;
                end;
              end else begin                 //��
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
//װ�ص�ǰ������Ӧ��ͼƬ
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
//ȡ��ɫ�Ŀ��
function  TActor.CharWidth: Integer;
begin
   if m_BodySurface <> nil then
      Result := m_BodySurface.Width
   else Result := 48;
end;
//ȡ��ɫ�ĸ߶�
function  TActor.CharHeight: Integer;
begin
   if m_BodySurface <> nil then
      Result := m_BodySurface.Height
   else Result := 70;
end;
//�ж�ĳһ���Ƿ��ǽ�ɫ������
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
    //����
     ErrorCode := 0;
     if m_nState and $00800000 <> 0 then blend := TRUE;  //�����ʾ
     ErrorCode := 1;
     if source.Height > 350 then begin  //20080608 ����������������ĳ������
       drawex(dsurface, ddx, ddy, source, 0, 0, source.Width, source.Height, 0);
       Exit; ////thedeath
     end;
     ErrorCode := 2;
     if source <> nil then begin
       if not Blend then begin
          if ceff = ceNone then begin    //ɫ����Ч������͸��Ч��ֱ����ʾ
                ErrorCode := 3;
                dsurface.Draw (ddx, ddy, source.ClientRect, source, TRUE);
                ErrorCode := 4;
          end else begin
                //������ɫ���Ч�����ٻ���
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
//��������˸��
procedure TActor.DrawWeaponGlimmer (dsurface: TDirectDrawSurface; ddx, ddy: integer);
//var
//   idx, ax, ay: integer;
//   d: TDirectDrawSurface;
begin
   //������..(��ȭ��) �׷��� ����...
   (*if BoNextTimeFireHit and WarMode and GlimmingMode then begin
      if GetTickCount - GlimmerTime > 200 then begin
         GlimmerTime := GetTickCount;
         Inc (CurGlimmer);
         if CurGlimmer >= MaxGlimmer then CurGlimmer := 0;
      end;
      idx := GetEffectBase (5-1{��ȭ���¦��}, 1) + Dir*10 + CurGlimmer;
      d := FrmMain.WMagic.GetCachedImage (idx, ax, ay);
      if d <> nil then
         DrawBlend (dsurface, ddx + ax, ddy + ay, d, 1);
                          //dx + ax + ShiftX,
                          //dy + ay + ShiftY,
                          //d, 1);
   end;*)
end;
//���ݵ�ǰ״̬state�����ɫЧ���������ж�״̬�ȣ�������ʾ����ɫ�Ϳ��ܲ�ͬ��
function TActor.GetDrawEffectValue: TColorEffect;
var
   ceff: TColorEffect;
begin
   ceff := ceNone;

   //����
   if (g_FocusCret = self) or (g_MagicTarget = self) then begin
      ceff := ceBright;
   end;

   //�����̶�
   if m_nState and $80000000 <> 0 then begin
      ceff := ceGreen;
   end;
   if m_nState and $40000000 <> 0 then begin
      ceff := ceRed;
   end;
   if m_nState and $20000000 <> 0 then begin
      ceff := ceBlue;
   end;
   { //��״̬���� �������� С��״̬����  20080812
   if m_nState and $10000000 <> 0 then begin
      ceff := ceYellow;
   end;}
   //�����
   if m_nState and $08000000 <> 0 then begin
      ceff := ceFuchsia;
   end;
   if m_nState and $04000000 <> 0 then begin
      ceff := ceGrayScale;
   end;
   Result := ceff;
end;
(*******************************************************************************
  ���� : ��ʾ��������  [ͨ����]      ���ڣ�2008.01.13
  ���� : DrawMyShow(dsurface: TDirectDrawSurface;dx,dy:integer);
  ���� : dsurfaceΪ������DXΪX���ꣻ DYΪY���ꣻ
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
      if not m_boNoChangeIsMyShow then begin//�Ƿ�������ﶯ���仯���仯     20080306
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

//Ӣ���ٻ����˳� ������ʾ
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

{//ƮѪ��ʾ
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
      //�Ӽ�Ѫ��ʾ

      if IsAddBlood then begin
         BooldNum := abs(AddBloodNum);//BooldNum�������ٵ�Ѫ
         jj:=1;
         if Self=g_Myself then w := 12 else w := 8;
         if AddBloodnum > 0 then
           d := g_qingqingImages.Images[16]
         else
           d := g_qingqingImages.Images[15];

           if d <> nil then
            dsurface.Draw(m_nSayX - d.Width div 2+AddBloodFram*(2), dy + m_nhpy + m_nShiftY - 10-AddBloodFram*(2), d.ClientRect, d, True);
         while BooldNum >= 0 do begin
           BooldIndex := GetIndex(BooldNum);//ȡ��ͼƬ
           d := g_qingqingImages.Images[BooldIndex];
           if d <> nil then
            dsurface.Draw(m_nSayX - d.Width div 2 + AddBloodFram * (2) + jj * w, dy + m_nhpy + m_nShiftY - 10 - AddBloodFram * (2), d.ClientRect, d, True);
           Inc(jj);
         end;
      end;
  end;
end;  }
//��ʾ��ɫ
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
       LoadSurface; //����ͼƬÿ60����ͷ�һ�Σ�60����δʹ�õĻ���������ÿ60��Ҫ���һ���Ƿ��Ѿ����ͷ���.
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
    DrawMyShow(dsurface,dx,dy); //��ʾ������
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

//ȱʡ֡
function  TActor.GetDefaultFrame (wmode: Boolean): integer;
var
   cf: integer;
   pm: PTMonsterAction;
begin
   Result:=0;
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;
   if m_boDeath then begin            //����
      if m_boSkeleton then            //����ʬ������
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
//Ĭ���˶�
procedure TActor.DefaultMotion;   //ȱʡ����
begin
   m_boReverseFrame := FALSE;
   if m_boWarMode then begin
      if (GetTickCount - m_dwWarModeTime > 4000) then //and not BoNextTimeFireHit then
         m_boWarMode := FALSE;
   end;
   m_nCurrentFrame := GetDefaultFrame (m_boWarMode);
   Shift (m_btDir, 0, 1, 1);
end;

//���ﶯ������(�Ų���������������)
procedure TActor.SetSound;
var
   cx, cy, bidx, wunit, attackweapon: integer;
   hiter: TActor;
begin
   if (m_btRace = 0) or (m_btRace = 1) or (m_btRace = 150){����,Ӣ��,����20080629} then begin              //�������
      if (self = g_MySelf) and             //��������
         ((m_nCurrentAction=SM_WALK) or
          (m_nCurrentAction=SM_BACKSTEP) or
          (m_nCurrentAction=SM_RUN) or
          //(m_nCurrentAction=SM_HORSERUN) or  20080803ע��������Ϣ
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
               m_nFootStepSound := s_walk_lawn_l;  //�ݵ�������
               
            250..254, 1005..1009, 1050..1054, 1060..1064, 1450..1454,
            1650..1654:
               m_nFootStepSound := s_walk_rough_l; //�ֲڵĵ���

            605..609, 650..654, 660..664, 2000..2049,
            3025..3049, 2400..2424, 4625..4649, 4675..4678:
               m_nFootStepSound := s_walk_stone_l;  //ʯͷ����������

            1825..1924, 2150..2174, 3075..3099, 3325..3349,
            3375..3399:
               m_nFootStepSound := s_walk_cave_l;  //��Ѩ������

           3230, 3231, 3246, 3277:
               m_nFootStepSound := s_walk_wood_l;  //ľͷ��������

           //����..
           3780..3799:
               m_nFootStepSound := s_walk_wood_l;

           3825..4434:
               if (bidx-3825) mod 25 = 0 then m_nFootStepSound := s_walk_wood_l
               else m_nFootStepSound := s_walk_ground_l;

             2075..2099, 2125..2149:
               m_nFootStepSound := s_walk_room_l;   //������

            1800..1824:
               m_nFootStepSound := s_walk_water_l;  //ˮ��

            else
               m_nFootStepSound := s_walk_ground_l;
         end;
         //��������
         if (bidx >= 825) and (bidx <= 1349) then begin
            if ((bidx-825) div 25) mod 2 = 0 then
               m_nFootStepSound := s_walk_stone_l;
         end;
         //��������
         if (bidx >= 1375) and (bidx <= 1799) then begin
            if ((bidx-1375) div 25) mod 2 = 0 then
               m_nFootStepSound := s_walk_cave_l;
         end;
         case bidx of
            1385, 1386, 1391, 1392:
               m_nFootStepSound := s_walk_wood_l;
         end;

         bidx := Map.m_MArr[cx, cy].wMidImg and $7FFF;   //����ͼ����
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
         if (m_nCurrentAction = SM_RUN){ or (m_nCurrentAction = SM_HORSERUN)20080803ע��������Ϣ }then
            m_nFootStepSound := m_nFootStepSound + 2;
      end;

      if m_btSex = 0 then begin //��
         m_nScreamSound := s_man_struck;
         m_nDieSound := s_man_die;
      end else begin //Ů
         m_nScreamSound := s_wom_struck;
         m_nDieSound := s_wom_die;
      end;

      case m_nCurrentAction of      //��������
         SM_THROW, SM_HIT, SM_HIT+1, SM_HIT+2, SM_POWERHIT, SM_LONGHIT, SM_WIDEHIT, SM_FIREHIT{�һ�}, SM_DAILY{���ս���}, SM_4FIREHIT{4���һ�}, SM_CRSHIT, SM_TWINHIT{����ն�ػ�}, SM_QTWINHIT{����ն���}, SM_CIDHIT{��Ӱ����}, SM_LEITINGHIT{����һ��սʿЧ�� 20080611}:
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
         SM_STRUCK: //�ܹ���
            begin
               if m_nMagicStruckSound >= 1 then begin
                  //strucksound := s_struck_magic;
               end else begin
                  hiter := PlayScene.FindActor (m_nHiterCode);
                  //attackweapon := 0;
                  if hiter <> nil then begin
                     attackweapon := hiter.m_btWeapon div 2;
                     if (hiter.m_btRace = 0) or (hiter.m_btRace = 1) or (hiter.m_btRace = 150) then //����,Ӣ��,����20080629
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
        case m_CurMagic.MagicSerial of  //MagicSerialΪħ��ID 20080302
          41: m_nMagicStartSound := 10430;//ʨ�Ӻ�  20080314
          44: begin //������
            m_nMagicStartSound := 10000 + (m_CurMagic.MagicSerial-5) * 10;
            m_nMagicFireSound := 10000 + (m_CurMagic.MagicSerial-5) + 1;
            m_nMagicExplosionSound := 10000 + (m_CurMagic.MagicSerial-5) * 10 + 2;
          end;
          45: begin //�����
            m_nMagicStartSound := 10000 + (m_CurMagic.MagicSerial-10) * 10;
            m_nMagicExplosionSound := 10000 + (m_CurMagic.MagicSerial-10) + 2;
          end;
          48: begin
            m_nMagicStartSound := 10370;  //������ 20080321
            m_nMagicExplosionSound := 0;
          end;
          50: begin
            m_nMagicStartSound := 10360;//�޼�����  20080314
            m_nMagicExplosionSound := 0;
          end;
          59: begin
            m_nMagicStartSound := 10480;//��Ѫ��  20080511
            m_nMagicExplosionSound := 10482;
          end;
          62: begin//����һ�� 20080405
              m_nMagicStartSound := 10520;
              m_nMagicExplosionSound := 10522;
          end;
          63: begin  //�ɻ����� 20080405
              m_nMagicStartSound := 10530;
              m_nMagicExplosionSound := 10532;
          end;
          64: begin  //ĩ������ 20080405
              m_nMagicStartSound := 10540;
              m_nMagicExplosionSound := 10542;
          end;
          65: begin  //�������� 20080405
              m_nMagicStartSound := 10550;
              m_nMagicExplosionSound := 10552;
          end;
          72: begin //�ٻ�����
            m_nMagicStartSound := 10410;
          end;
          66: begin //4��ħ����
            m_nMagicStartSound := 10310;
            m_nMagicFireSound := 10311;
            m_nMagicExplosionSound := 10312;
          end;
          {100: begin //�������
            m_nMagicStartSound := 11000;
            m_nMagicExplosionSound := 11002;
          end;
          101: begin //�����ػ�
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
      if m_nCurrentAction = SM_STRUCK then begin //�ܹ���
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
         m_nDieSound := 1925 //������������  20080302
         else
         m_nDieSound := 200 + (m_wAppearance) * 10 + 5;
         m_nDie2Sound := 200 + (m_wAppearance) * 10 + 6;
      end;
   end;


   if m_nCurrentAction = SM_STRUCK then begin  //�ܹ���
      hiter := PlayScene.FindActor (m_nHiterCode);
      //attackweapon := 0;
      if hiter <> nil then begin
         attackweapon := hiter.m_btWeapon div 2;
         if hiter.m_btRace in [0,1,150] then //����,Ӣ��,����20080629
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

//���Ŷ�����Ч
procedure  TActor.RunSound;
begin
   m_boRunSound := TRUE;
   SetSound;
   case m_nCurrentAction of
      SM_STRUCK:  //������
         begin
            if (m_nStruckWeaponSound >= 0) then PlaySound (m_nStruckWeaponSound); //��������������Ч
            if (m_nStruckSound >= 0) then PlaySound (m_nStruckSound);             //����������Ч
            if (m_nScreamSound >= 0) then PlaySound (m_nScreamSound);              //���
         end;
      SM_NOWDEATH:
         begin
            if (m_nDieSound >= 0) then begin
              PlaySound (m_nDieSound);
            end;
         end;
      SM_THROW, SM_HIT, SM_FLYAXE, SM_LIGHTING, SM_DIGDOWN{������}:
         begin
            if m_nAttackSound >= 0 then PlaySound (m_nAttackSound);
         end;
      SM_ALIVE, SM_DIGUP{����,������}:
         begin
            PlaySound (m_nAppearSound);
         end;
      SM_SPELL:
         begin
            PlaySound (m_nMagicStartSound);
            if m_CurMagic.EffectNumber = 91 then MyPlaySound (heroshield_ground); //�����������
            if m_CurMagic.MagicSerial = 60 then PHHitSound(1);
            if m_CurMagic.MagicSerial = 61 then PHHitSound(2);
            if m_CurMagic.EffectNumber = 51 then MyPlaySound ('wav\M58-0.wav'); //����������� 20080511
         end;
   end;
end;

procedure  TActor.RunActSound (frame: integer);
begin
   if m_boRunSound then begin     //��Ҫ������Ч
      if (m_btRace = 0) or (m_btRace = 1) or (m_btRace = 150) then begin  //����,Ӣ��,����20080629
         case m_nCurrentAction of
            SM_THROW, SM_HIT, SM_HIT+1, SM_HIT+2:    //�ӡ���
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  m_boRunSound := FALSE; //��Ч�Ѿ�����
               end;
            SM_POWERHIT:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  //�������������
                  if m_btSex = 0 then PlaySound (s_yedo_man)
                  else PlaySound (s_yedo_woman);
                  m_boRunSound := FALSE; //�ѹ��� �Ҹ���
               end;
            SM_LONGHIT:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_longhit);
                  m_boRunSound := FALSE; //�ѹ��� �Ҹ���
               end;
            SM_WIDEHIT:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_widehit);
                  m_boRunSound := FALSE; //�ѹ��� �Ҹ���
               end;
            SM_FIREHIT{�һ�}, SM_4FIREHIT{4���һ�}:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_firehit);
                  m_boRunSound := FALSE; //�ѹ��� �Ҹ���
               end;
            SM_CRSHIT:
              if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_firehit); //Damian
                  m_boRunSound := FALSE; //�ѹ��� �Ҹ���
              end;
            SM_TWINHIT: //����ն �ػ�
              if frame = 2 then begin
                  MyPlaySound (longswordhit_ground);
                  m_boRunSound := FALSE;
              end;
            SM_QTWINHIT: //����ն ���
              if frame = 2 then begin
                  MyPlaySound (longswordhit_ground);
                  m_boRunSound := FALSE;
              end;
            SM_DAILY: //���ս��� 20080511
              if frame = 2 then begin
                  if m_btSex = 0 then //��
                    MyPlaySound ('wav\M56-0.wav')
                  else
                    MyPlaySound ('wav\M56-3.wav'); //Ů
                  m_boRunSound := FALSE;
              end;
            SM_CIDHIT:{��Ӱ����}
              if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (142); //20080403
                  m_boRunSound := False;
              end;
         end;
      end else begin
         {if m_btRace = 50 then begin  //20080803�޸�
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
            { //20080803�޸�
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
      //(m_nCurrentAction = SM_HORSERUN) or 20080803ע��������Ϣ
      (m_nCurrentAction = SM_RUSH) or
      (m_nCurrentAction = SM_RUSHKUNG)
   then Exit;

   m_boMsgMuch := FALSE;
   if self <> g_MySelf then begin
      if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
   end;

   //����Ч��
   RunActSound (m_nCurrentFrame - m_nStartFrame);
   RunFrameAction (m_nCurrentFrame - m_nStartFrame);

   prv := m_nCurrentFrame;
   if m_nCurrentAction <> 0 then begin  //������Ϊ��
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
                     if m_CurMagic.EffectNumber = 51 then //����������� 20080511
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
   end else begin    //����Ϊ��
      if (m_btRace = 50) and (m_wAppearance in [54..58]) then begin   //ѩ��NPC 20081229
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

//���ݵ�ǰ������״̬������һ��������Ӧ��֡
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
      //g_boMoveSlow := FALSE;  20080816ע�͵��𲽸���
      //g_boAttackSlow := FALSE; //20080816 ע�� ��������
      //20080816ע�͵��𲽸���
      //g_nMoveSlowLevel := 0;
      {//�����ܲ�
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
      //�⸺��
      if g_boMoveSlow and (m_nSkipTick < g_nMoveSlowLevel) and (not g_boMoveSlow1) then begin

         Inc (m_nSkipTick);
         exit;
      end else begin }
         //m_nSkipTick := 0;
      //end;
      //�߶�������
      if (m_nCurrentAction = SM_WALK) or
         (m_nCurrentAction = SM_BACKSTEP) or
         (m_nCurrentAction = SM_RUN) or
         //(m_nCurrentAction = SM_HORSERUN) or  20080803ע��������Ϣ
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
   //�ƶ�
   if (m_nCurrentAction = SM_WALK) or
      (m_nCurrentAction = SM_RUN) or
      //(m_nCurrentAction = SM_HORSERUN) or 20080803ע��������Ϣ
      (m_nCurrentAction = SM_RUSH) or
      (m_nCurrentAction = SM_RUSHKUNG)
   then begin
     //������ǰ֡
      if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then begin
         m_nCurrentFrame := m_nStartFrame - 1;
      end;
      if m_nCurrentFrame < m_nEndFrame then begin
         Inc (m_nCurrentFrame);

         if m_boMsgMuch and not normmove then //�ӿ첽��
            if m_nCurrentFrame < m_nEndFrame then
               Inc (m_nCurrentFrame);

         curstep := m_nCurrentFrame-m_nStartFrame + 1;
         maxstep := m_nEndFrame-m_nStartFrame + 1;
         Shift (m_btDir, m_nMoveStep, curstep, maxstep);  //����
      end;
      if m_nCurrentFrame >= m_nEndFrame then begin
         if self = g_MySelf then begin
            if FrmMain.ServerAcceptNextAction then begin
               m_nCurrentAction := 0;      //��ǰ��������
               m_boLockEndFrame := TRUE;
               m_dwSmoothMoveTime := GetTickCount;
            end;
         end else begin
            m_nCurrentAction := 0; //���� �Ϸ�
            m_boLockEndFrame := TRUE;
            m_dwSmoothMoveTime := GetTickCount;
         end;
         Result := TRUE;
      end;
      if m_nCurrentAction = SM_RUSH then begin
         if self = g_MySelf then begin
            g_dwDizzyDelayStart := GetTickCount;
            g_dwDizzyDelayTime := 300; //������
         end;
      end;
      if m_nCurrentAction = SM_RUSHKUNG then begin  //Ұ����ײ
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
   if (m_nCurrentAction = SM_BACKSTEP) then begin  //����
      if (m_nCurrentFrame > m_nEndFrame) or (m_nCurrentFrame < m_nStartFrame) then begin
         m_nCurrentFrame := m_nEndFrame + 1;
      end;
      if m_nCurrentFrame > m_nStartFrame then begin
         Dec (m_nCurrentFrame);
         if m_boMsgMuch or fastmove then
            if m_nCurrentFrame > m_nStartFrame then Dec (m_nCurrentFrame);

         //�ε巴�� �̵��ϰ� �Ϸ���
         curstep := m_nEndFrame - m_nCurrentFrame + 1;
         maxstep := m_nEndFrame - m_nStartFrame + 1;
         Shift (GetBack(m_btDir), m_nMoveStep, curstep, maxstep);
      end;
      if m_nCurrentFrame <= m_nStartFrame then begin
         if self = g_MySelf then begin
            //if FrmMain.ServerAcceptNextAction then begin
               m_nCurrentAction := 0;     //��ϢΪ��
               m_boLockEndFrame := TRUE;   //������ǰ����
               m_dwSmoothMoveTime := GetTickCount;

               //�ڷ� �и� ���� �ѵ��� �� �����δ�.
               g_dwDizzyDelayStart := GetTickCount;
               g_dwDizzyDelayTime := 1000; //1�� ������
            //end;
         end else begin
            m_nCurrentAction := 0; //���� �Ϸ�
            m_boLockEndFrame := TRUE;
            m_dwSmoothMoveTime := GetTickCount;
         end;
         Result := TRUE;
      end;
      Result := TRUE;
   end;
   //����ǰ��������һ������֡��ͬ����װ�ص�ǰ��������
   if prv <> m_nCurrentFrame then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface;
   end;
end;

//�ƶ�ʧ�ܣ��������������ƶ����ʱ���˻ص��ϴε�λ��
procedure TActor.MoveFail;
begin
   m_nCurrentAction := 0; //���� �Ϸ�
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
   m_nCurrentAction := 0; //���� �Ϸ�
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

//ʵ�ַ�����ʾ˵�����ݵ�Saying
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
                //npcΪ50
  Pm:=GetRaceByPM(m_btRace,m_wAppearance);
  if pm = nil then exit;
  m_btDir := m_btDir mod 3;
  case m_nCurrentAction of
    SM_TURN: begin //ת��
      if g_boNpcWalk then Exit;
      if m_wAppearance in [54..59,70..75,90..92,65..66,62,82..84] then begin //�����ʼ�NPC
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
    SM_HIT: begin  //����
      if g_boNpcWalk then Exit;
      case m_wAppearance of
        33,34,52,54..59,70..75,90..92,65..66,62{,82..84}: begin //70 �����ʼ�NPC
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
    SM_NPCWALK: begin //NPC�߶�
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
// ��NPC ��������ͼ
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
      if m_wAppearance in [54..58] then begin //ѩ��NPC
        DrawBlend (dsurface,
               dx + m_nPx + m_nShiftX,
               dy + m_nPy + m_nShiftY,
               m_BodySurface,
               1);
      end else
      if m_wAppearance = 51 then begin  //�ƹ��ϰ���
        DrawEffSurface (dsurface,
                        m_BodySurface,
                        dx + m_nPx + m_nShiftX,
                        dy + m_nPy + m_nShiftY,
                        True,
                        ceff);
      end else begin
        DrawEffSurface (dsurface,      //�˴�Ϊ��
                        m_BodySurface,
                        dx + m_nPx + m_nShiftX,
                        dy + m_nPy + m_nShiftY,
                        blend,
                        ceff);
      end;
    end;
    if m_boNpcWalkEffect then begin   //���ƹ�2�� �ϰ���Ч��(�߳������Ĺ�)
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
   m_btDir := m_btDir mod 3;  //NPCֻ��3�����������ˣ�

   if m_nCurrentDefFrame < 0 then cf := 0
   else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
   else cf := m_nCurrentDefFrame;
   if m_wAppearance in [54..59,70..75,90..92,65..66,62,82..84] then  //�����ʼ�NPC
    Result := pm.ActStand.start + cf
   else
   Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
end;

procedure TNpcActor.LoadSurface;
begin
  if (m_wAppearance = 81) and g_boNpcWalk then begin  //�ϰ���
   m_BodySurface:=g_WNpcImgImages.GetCachedImage(m_nCurrentFrame, m_nPx, m_nPy); //ȡͼ
   if m_boNpcWalkEffect then  //ȡ�������ͼ 20080621
     m_boNpcWalkEffectSurface:=g_WNpcImgImages.GetCachedImage(m_nCurrentFrame+79, m_nNpcWalkEffectPx, m_nNpcWalkEffectPy); //ȡͼ
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
    end else if m_wAppearance in [70..75,90..92,65..66] then begin //�����ʼ�NPC
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
      SendMsg (SM_TURN, m_nCurrX, m_nCurrY, m_btDir, m_nFeature, m_nState, '', 0); //ת��
    end;
  end;

  nEffectFrame:=m_nEffectFrame;
  if m_boUseEffect then begin    //NPC�Ƿ�ʹ����ħ����
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
  if nEffectFrame <> m_nEffectFrame then begin     //ħ����
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
  m_btHair   := HAIRfeature (m_nFeature);         //����
  m_btDress  := DRESSfeature (m_nFeature);        //����//��װ
  m_btWeapon := WEAPONfeature (m_nFeature);
 // m_btHorse  :=Horsefeature(m_nFeatureEx);  20080721 ע������
  m_btEffect :=Effectfeature(m_nFeatureEx);
  m_nBodyOffset := HUMANFRAME * (m_btDress); //m_btSex; //��0, Ů1

  haircount := g_WHairImgImages.ImageCount div {HUMANFRAME}1200 div 2;  //����ͷ����=3600/600/2=3,��ÿ���Ա�ķ�����
  if m_btHair = High(m_btHair) then begin   //����Ϊ255
      m_nHairOffset := HUMANFRAME * (m_btSex + 6);
  end else
  if m_btHair = 254 then begin     //��ɫ����Ϊ254
      m_nHairOffset := HUMANFRAME * (m_btSex + 8);
  end else begin
      if m_btSex = 1 then begin //Ů
        if m_btHair = 1 then m_nHairOffset := 600
        else begin
           if m_btHair > haircount-1 then m_btHair := haircount-1;
           m_btHair := m_btHair * 2;
           if m_btHair > 1 then
              m_nHairOffset := HUMANFRAME * (m_btHair + m_btSex)
           else m_nHairOffset := -1;
        end;
      end else begin                 //��
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
     {if m_btSex = 1 then begin   //Ů
      if m_btHair = 1 then m_nHairOffset := -1;
     end else begin
      if m_btSex = 0 then   //��
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
  m_nWeaponOffset := HUMANFRAME * m_btWeapon; //(weapon*2 + m_btSex);    //����ͼƬ��ʼ֡�������Ա𣿣�
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
      SM_TURN: //ת
         begin
            m_nStartFrame := HA.ActStand.start + m_btDir * (HA.ActStand.frame + HA.ActStand.skip);
            m_nEndFrame := m_nStartFrame + HA.ActStand.frame - 1;
            m_dwFrameTime := HA.ActStand.ftime;
            m_dwStartTime := GetTickCount;
            m_nDefFrameCount := HA.ActStand.frame;
            Shift (m_btDir, 0, 0, m_nEndFrame-m_nStartFrame+1);
         end;
      SM_WALK, //��
      SM_BACKSTEP: //����
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
      SM_RUSH: //�ܶ��иı䷽��
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
      SM_RUSHKUNG: //Ұ����ײ
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
      { 20080803ע��������Ϣ
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
      {SM_THROW:  //20080803ע��
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
      SM_HIT, SM_POWERHIT, SM_LONGHIT, SM_WIDEHIT, SM_FIREHIT{�һ�}, SM_4FIREHIT{4���һ�}, SM_CRSHIT, SM_TWINHIT{����ն�ػ�}, SM_QTWINHIT{����ն���}, SM_CIDHIT{��Ӱ����},SM_LEITINGHIT:
         begin
            m_nStartFrame := HA.ActHit.start + m_btDir * (HA.ActHit.frame + HA.ActHit.skip);
            m_nEndFrame := m_nStartFrame + HA.ActHit.frame - 1;
            m_dwFrameTime := HA.ActHit.ftime;
            m_dwStartTime := GetTickCount;
            m_boWarMode := TRUE;
            m_dwWarModeTime := GetTickCount;

            if (m_nCurrentAction = SM_POWERHIT) then begin //��ɱ
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 1;
            end;
            if (m_nCurrentAction = SM_LONGHIT) then begin  //��ɱ
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 2;
            end;
            if (m_nCurrentAction = SM_WIDEHIT) then begin  //����
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 3;
            end;
            if (m_nCurrentAction = SM_FIREHIT) then begin  //�һ�
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 4;
            end;
            if (m_nCurrentAction = SM_4FIREHIT) then begin  //4���һ�
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 9;
            end;
            if (m_nCurrentAction = SM_CRSHIT) then begin   //����
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 6;
            end;
            if (m_nCurrentAction = SM_TWINHIT) then begin  //����ն�ػ�
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 7;
            end;
            if (m_nCurrentAction = SM_QTWINHIT) then begin  //����ն��� 2008.02.12
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 10;
            end;
            if (m_nCurrentAction = SM_CIDHIT) then begin  //��Ӱ����
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               //m_nEndFrame := m_nStartFrame + 15 - 1;
               m_nHitEffectNumber := 8;
            end;
            if (m_nCurrentAction = SM_LEITINGHIT{����һ��սʿЧ�� 20080611}) then begin
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
      SM_BIGHIT, SM_DAILY{���ս���}:
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
      SM_SPELL: //����ʹ��ħ����Ϣ
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
               22: begin //��ǽ
                     m_nMagLight := 4;  //�ڼ�ȭ
                     m_nSpellFrame := 10; //�ڼ�ȭ�� 10 ���������� ����
                  end;
               26: begin //������ʾ
                     m_nMagLight := 2;
                     m_nSpellFrame := 20;
                     m_dwFrameTime := m_dwFrameTime div 2;
                  end;
               43: begin //ʨ�Ӻ�
                     m_nMagLight := 2;
                     m_nSpellFrame := 20;
                  end;
               52: begin  //�ļ�ħ����
                  m_nSpellFrame := 9;
               end;
               91: begin  //�������
                    m_nSpellFrame := 10;
                  end;
               66: begin //��������
                    m_nSpellFrame := 16;
               end;
             100, 101: begin  //4����� 20080111  4������� 20080111
                    m_nSpellFrame := 6;
                  end;
               else begin 
                  m_nMagLight := 2;
                  m_nSpellFrame := DEFSPELLFRAME;
               end;
            end;

            if (m_btRace = 1) or (m_btRace = 150) then  //Ӣ�ۣ�����
              m_dwWaitMagicRequest := GetTickCount - 1500 //��ֹ,����������ʱ����Ϣ�ۻ�,Ӣ���������ӷ�ħ��ʱ,���־��ֿ����� ���پ��ַ��µ�ʱ����20080720
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

function  THumActor.GetDefaultFrame (wmode: Boolean): integer;   //��̬����
var
   cf: integer;
begin
   //GlimmingMode := FALSE;
   //dr := Dress div 2;            //HUMANFRAME * (dr)
   if m_boDeath then      //����
      Result := HA.ActDie.start + m_btDir * (HA.ActDie.frame + HA.ActDie.skip) + (HA.ActDie.frame - 1)
   else
   if wmode then begin      //ս��״̬
      //GlimmingMode := TRUE;
      Result := HA.ActWarMode.start + m_btDir * (HA.ActWarMode.frame + HA.ActWarMode.skip);
   end else begin           //վ��״̬
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
   //m_boHideWeapon := FALSE; 20080803ע��
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
   (*//20080803ע��
   if m_nCurrentAction = SM_THROW then begin
      if (frame = 3) and (m_boThrow) then begin
         m_boThrow := FALSE;
         //�Ӹ�ͷЧ��
         mfly := TFlyingAxe (PlayScene.NewFlyObject (self,
                          m_nCurrX,
                          m_nCurrY,
                          m_nTargetX,
                          m_nTargetY,
                          m_nTargetRecog,
                          mtFlyAxe));
         if mfly <> nil then begin
            TFlyingAxe(mfly).ReadyFrame := 40;
            mfly.ImgLib := {FrmMain.WMon3Img20080720ע��}g_WMonImagesArr[2];
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
  //�ж�ħ���Ƿ��Ѿ���ɣ����ࣺ3�룬������2�룩
   function MagicTimeOut: Boolean;
   begin
      if self = g_MySelf then begin
        if m_CurMagic.EffectNumber = 60 then   //�ƻ�ն  �������￳��ȥ�Ķ��� 20080227
         Result := GetTickCount - m_dwWaitMagicRequest > 500
        else
         Result := GetTickCount - m_dwWaitMagicRequest > 3000;
      end else
        if m_CurMagic.EffectNumber = 60 then
         Result := GetTickCount - m_dwWaitMagicRequest > 500  //�ƻ�ն  �������￳��ȥ�Ķ��� 20080227
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
   if GetTickCount - m_dwGenAnicountTime > 120 then begin //�ּ��Ǹ� ��... �ִϸ��̼� ȿ��
      m_dwGenAnicountTime := GetTickCount;
      Inc (m_nGenAniCount);
      if m_nGenAniCount > 100000 then m_nGenAniCount := 0;
      Inc (m_nCurBubbleStruck);
   end;

   if m_boWeaponEffect then begin  //����Ч����ÿ120��仯һ֡����5֡
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
      //(m_nCurrentAction = SM_HORSERUN) or 20080803ע��������Ϣ
      (m_nCurrentAction = SM_RUSH) or
      (m_nCurrentAction = SM_RUSHKUNG)
   then Exit;
   m_boMsgMuch := FALSE;
   if self <> g_MySelf then begin
      if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
   end;
   //������Ч
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
               if (m_nCurEffFrame = m_nSpellFrame-2) or (MagicTimeOut) then begin //ħ��ִ����
                  if (m_CurMagic.ServerMagicCode >= 0) or (MagicTimeOut) then begin //������ ���� ���� ���. ���� �ȿ����� ��ٸ�
                     Inc (m_nCurrentFrame);
                     Inc (m_nCurEffFrame);
                     m_dwStartTime := GetTickCount;
                  end;
               end else begin
                  if m_nCurrentFrame < m_nEndFrame - 1 then Inc (m_nCurrentFrame);
                  Inc (m_nCurEffFrame);
                  m_dwStartTime := GetTickCount;
               end;
            end else begin   //������ ���з�ӳ
               Inc (m_nCurrentFrame);
               m_dwStartTime := GetTickCount;
            end;
         end else begin
            if Self = g_MySelf then begin
               if FrmMain.ServerAcceptNextAction then begin //�������ﱾ�� ���������ؽ�� ���ͷ�
                  m_nCurrentAction := 0;
                  m_boUseMagic := FALSE;
               end;
            end else begin     //��������
               m_nCurrentAction := 0;  //����Ϊ��
               m_boUseMagic := FALSE;
            end;
            m_boHitEffect := FALSE;
         end;
         if m_boHitEffect and ((m_nHitEffectNumber = 7) or (m_nHitEffectNumber = 8) or (m_nHitEffectNumber = 10) or (m_nHitEffectNumber = 12)) then begin//ħ������Ч��  20080202
           if m_nCurrentFrame = m_nEndFrame - 1 then begin
              case m_nHitEffectNumber of
                  8: FrmMain.ShowMyShow(Self,1); //��Ӱ����  ��9������Ч�� 20080202
                    //MyShow.Create(m_nCurrX,m_nCurrY,1,80,9,m_btDir,g_WMagic2Images);
                  7: FrmMain.ShowMyShow(Self,2); //����ն�ػ����Ч��
                 10: FrmMain.ShowMyShow(Self,3); //����ն������Ч��
                 12: FrmMain.ShowMyShow(Self,6);//����һ��սʿЧ��
              end;
           end;
         end;
         if m_boUseMagic then begin
            if m_nCurEffFrame = m_nSpellFrame - 1 then begin //ħ������ �ȷ�����ħ�� ��-1ͼ
               //���� �߻�
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
                     if m_CurMagic.EffectNumber = 51 then //����������� 20080511
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
      if (m_btRace = 0) or (m_btRace = 1) or (m_btRace = 150) then m_nCurrentDefFrame := 0 //����,Ӣ��,����20080629
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
         if m_nFrame < 7 then Inc(m_nFrame)   //8������ 
         else m_nFrame:=0;
         m_dwFrameTick:=GetTickCount();
       end;
       m_HumWinSurface:=g_WHumWingImages.GetCachedImage (m_nHumWinOffset+ (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
     end else begin
       m_HumWinSurface:=g_WHumWingImages.GetCachedImage (m_nHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy); //����������
     end;
   end;

   m_WeaponSurface:=FrmMain.GetWWeaponImg(m_btWeapon,m_btSex,m_nCurrentFrame, m_nWpx, m_nWpy);
   if m_WeaponSurface = nil then
     m_WeaponSurface:=FrmMain.GetWWeaponImg(0,m_btSex,m_nCurrentFrame, m_nWpx, m_nWpy);
end;

{-----------------------------------------------------------------}
//��������
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
   if m_btDir > 7 then Exit; //��ǰվ������ ������0..7
   if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin  //60���ͷ�һ��δʹ�õ�ͼƬ������ÿ��60��Ҫ����װ��һ��
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface; //����װ��ͼƬ��bodysurface
   end;
   ceff := GetDrawEffectValue;//������ʾ��ɫ
   ErrorCode := 3;
   if (m_btRace = 0) or (m_btRace = 1) or (m_btRace = 150) then begin //����,Ӣ��,����20080629
      if (m_nCurrentFrame >= 0) and (m_nCurrentFrame <= 599) then
         m_nWpord := WORDER[m_btSex, m_nCurrentFrame];
      if (m_btEffect <> 0) then begin
        if ((m_btDir = 3) or (m_btDir = 4) or (m_btDir = 5)) and (m_HumWinSurface <> nil) then begin
          if (g_MySelf = Self) then begin
            //if blend then begin   20080616���������� ��򿴲�������
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
      //�Ȼ�����
      if (m_nWpord = 0) and (not blend) and (m_btWeapon >= 2) and (m_WeaponSurface <> nil) {and (not m_boHideWeapon)20080803ע��} then begin
         DrawEffSurface (dsurface, m_WeaponSurface, dx + m_nWpx + m_nShiftX, dy + m_nWpy + m_nShiftY, blend, ceNone);  //Į�� ���� �Ⱥ���
         //DrawWeaponGlimmer (dsurface, dx + m_nShiftX, dy + m_nShiftY);
         //dsurface.Draw (dx + wpx + ShiftX, dy + wpy + ShiftY, WeaponSurface.ClientRect, WeaponSurface, TRUE);
      end;
      //������
      ErrorCode := 5;
      if m_BodySurface <> nil then
         DrawEffSurface (dsurface, m_BodySurface, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, blend, ceff);
      //��ͷ��
      if m_HairSurface <> nil then
         DrawEffSurface (dsurface, m_HairSurface, dx + m_nHpx + m_nShiftX, dy + m_nHpy + m_nShiftY, blend, ceff);
      ErrorCode := 6;
      //������
      if (m_nWpord = 1) and {(not blend) and} (m_btWeapon >= 2) and (m_WeaponSurface <> nil) {and (not m_boHideWeapon)20080803ע��} then begin
         DrawEffSurface (dsurface, m_WeaponSurface, dx + m_nWpx + m_nShiftX, dy + m_nWpy + m_nShiftY, blend, ceNone);
         //DrawWeaponGlimmer (dsurface, dx + m_nShiftX, dy + m_nShiftY);
      end;
      ErrorCode := 7;
      if (m_btEffect = 50) then begin
        if not m_boDeath then begin //20080424 ����������������ʾ�⻷
          if (m_HumWinSurface <> nil) then
            DrawBlend (dsurface, dx + m_nSpx + m_nShiftX, dy + m_nSpy + m_nShiftY, m_HumWinSurface, 1);
        end;
      end else
      if m_btEffect <> 0 then begin
        if ((m_btDir = 0) or (m_btDir = 7) or (m_btDir = 1) or (m_btDir = 6)  or (m_btDir = 2)) and (m_HumWinSurface <> nil) then begin
          if g_MySelf = Self then begin
            //if blend then begin    20080616���������� ��򿴲�������
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
      if m_nState and $10000000 <> 0 then begin //С��״̬
          idx := 3740 + (m_nGenAniCount mod 10);;
          d := g_WMonImagesArr[23].GetCachedImage(idx, ax, ay);
          if d <> nil then
            DrawBlend (dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, d, 1);
      end;
      ErrorCode := 9;

      //��ʾħ����ʱЧ��
      if m_nState and $00100000{STATE_BUBBLEDEFENCEUP} <> 0 then begin  //�ּ��Ǹ�
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
         {if g_boSkill31Effect and m_boMagbubble4 then begin  //4��ħ����Ч��
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
   DrawMyShow(dsurface,dx,dy); //��ʾ������   20080229
   ErrorCode := 11;
   //��ʾħ��Ч��
   if m_boUseMagic and (m_CurMagic.EffectNumber > 0) then begin
      if m_nCurEffFrame in [0..m_nSpellFrame-1] then begin
         ErrorCode := 15;
         GetEffectBase (m_CurMagic.EffectNumber-1, 0, wimg, idx);//ȡ��ħ��Ч������ͼ��
         idx := idx + m_nCurEffFrame;//IDx��ӦWIL�ļ� ���ͼƬλ�ã����ü���ʱ��ʾ�Ķ���
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
//��ʾ����Ч��              2007.10.31 updata
//m_boHitEffect �Ƿ��ǹ�������
//m_nHitEffectNumber  ʹ�ù��������� ȡ��ͼ�ĺ�
//m_btDir  ����
//m_nCurrentFrame ��ǰ������   m_nStartFrame��ʼ������
{----------------------------------------------------------------------------}
   if m_boHitEffect and (m_nHitEffectNumber > 0) then begin
      GetEffectBase (m_nHitEffectNumber - 1, 1, wimg, idx);
      if m_nHitEffectNumber = 8 then idx := idx{��ʼ�ĺ�} + m_btDir{����}*20 + (m_nCurrentFrame-m_nStartFrame){��Ӱ����}
      else idx := idx{��ʼ�ĺ�} + m_btDir{����}*10 + (m_nCurrentFrame-m_nStartFrame);
       if wimg <> nil then
         d := wimg.GetCachedImage (idx, ax, ay);
      if d <> nil then
         DrawBlend (dsurface,
                          dx + ax + m_nShiftX,
                          dy + ay + m_nShiftY,
                          d, 1);
   end;
   ErrorCode := 13;
   //��ʾ����Ч��
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