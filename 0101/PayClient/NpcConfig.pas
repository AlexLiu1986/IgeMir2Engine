unit NpcConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TFrmNpcConfig = class(TForm)
    GroupBox1: TGroupBox;
    MemoNpc: TMemo;
    Label1: TLabel;
    SEdtRatio: TSpinEdit;
    BtnMakeNpc: TButton;
    BtnSave: TButton;
    BtnSelDir: TButton;
    Label2: TLabel;
    EdtDuanXinNum: TEdit;
    procedure BtnMakeNpcClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnSelDirClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FrmNpcConfig: TFrmNpcConfig;
  sDir: string;
implementation
uses Share;
{$R *.dfm}

{ TFrmNpcConfig }

procedure TFrmNpcConfig.Open;
begin
  SEdtRatio.Value := 5;
  EdtDuanXinNum.Text := '';
  BtnSave.Enabled := False;
  sDir := '';
  MemoNpc.Lines.Clear;
  ShowModal();
end;

procedure TFrmNpcConfig.BtnMakeNpcClick(Sender: TObject);
var
  nRatio: Integer;
  I: Integer;
begin
  if EdtDuanXinNum.Text = '' then begin
    Application.MessageBox('请填写短信代码号!'+#13+'提示：请到找支付后台查看您的短信代码号', '提示', MB_OK + MB_ICONASTERISK);
    Exit;
  end;
  nRatio := SEdtRatio.Value;
  MemoNpc.Clear;
  MemoNpc.Lines.Add('[@main]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('#SAY');
  MemoNpc.Lines.Add('<$USERNAME>你好，欢迎来到<$SERVERNAME>，很高兴为您服务\');
  MemoNpc.Lines.Add('找支付充值元宝注意事项-----本区元宝比例1元RMB='+IntToStr(SEdtRatio.Value)+'元宝\');
  MemoNpc.Lines.Add('①本系统支持网银和盛大卡,俊网卡,征途卡,神州行,久游,魔兽世界,声讯等\');
  MemoNpc.Lines.Add('②充值后能三分钟能马上得到元宝，无须等GM发装备\');
  MemoNpc.Lines.Add('③<本平台推出：只要你想买就一定能买的到充值系统>|<www.zhaopay.com>\');
  MemoNpc.Lines.Add('④资费:比例1元RMB='+IntToStr(SEdtRatio.Value)+'元宝 详见本服官方网站。欢迎大家使用\');
  MemoNpc.Lines.Add('⑤如果订购不成功,不收取任何费用.保证百分百不掉单现象\');
  MemoNpc.Lines.Add('<元宝充值/@充值>┆<元宝领取/@领取1>┆<元宝查询/@元宝查询>┆<退出/@exit>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@元宝查询]');
  MemoNpc.Lines.Add('#SAY');
  MemoNpc.Lines.Add('您当前的元宝为：<$GAMEGOLD>个 ');
  MemoNpc.Lines.Add('\');
  MemoNpc.Lines.Add('\');
  MemoNpc.Lines.Add('<继续领取元宝/@领取1>┆┆┆\');
  MemoNpc.Lines.Add('<返回/@main>┆┆┆<退出/@exit>\\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@充值]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('#SAY');
  MemoNpc.Lines.Add('<本服充值点卡类平台请看本服主页┆>\');
  MemoNpc.Lines.Add('<移动1元   编辑WDC'+EdtDuanXinNum.Text+'游戏帐号 发送到106696588>(<充值说明/@106696588>)\');
  MemoNpc.Lines.Add('<移动1.5元 编辑192'+EdtDuanXinNum.Text+'游戏帐号 发送到106698815>(<充值说明/@106698815>)\');
  MemoNpc.Lines.Add('<移动1元   编辑192'+EdtDuanXinNum.Text+'游戏帐号 发送到106698812>(<充值说明/@106698812>)\');
  MemoNpc.Lines.Add('<下一页短信通道/@充值2>┆<元宝领取/@领取1>┆<元宝查询/@元宝查询>┆<返回/@main>\');
  MemoNpc.Lines.Add('<找支付平台：点击下一页短信通道有更多选择^^^^^^^^^\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@充值2]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('#SAY');
  MemoNpc.Lines.Add('<本服充值点卡类平台请看本服主页┆>\');
  MemoNpc.Lines.Add('<移动1元   编辑 54'+EdtDuanXinNum.Text+'游戏帐号 发送到10665123906>(<充值说明/@10665123906>)\');
  MemoNpc.Lines.Add('<移动1元   编辑543'+EdtDuanXinNum.Text+'游戏帐号 发送到10666000968>(<充值说明/@10666000968>)\');
  MemoNpc.Lines.Add('<联通2元   编辑 4#'+EdtDuanXinNum.Text+'游戏帐号 发送到1066960016720>(<充值说明/@1066960016720>)\');
  MemoNpc.Lines.Add('<移动2元   编辑337'+EdtDuanXinNum.Text+'游戏帐号 发送到10666000923>(<充值说明/@10666000923>)\');
  MemoNpc.Lines.Add('<移动2元   编辑237'+EdtDuanXinNum.Text+'游戏帐号 发送到10666000168>(<充值说明/@10666000168>)\');
  MemoNpc.Lines.Add('<移动IVR 5元10元20元 编辑237'+EdtDuanXinNum.Text+'游戏帐号 发送到10666000168>(<充值说明/@10666000168>)\');
  MemoNpc.Lines.Add('<上一页通道/@充值>┆<元宝领取/@领取1>┆<元宝查询/@元宝查询>┆<返回/@main>\');
  MemoNpc.Lines.Add('<找支付平台：你的支持是我们发展的动力^^^^^^^^^\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@106698815]');
  MemoNpc.Lines.Add('<充值范围：1元中国移动 除浙江北京内蒙不支持.日10条月30条(不掉单通道)>\');
  MemoNpc.Lines.Add('<示例:游戏帐号为aaaaa 请编写192'+EdtDuanXinNum.Text+'aaaaa 发送到106698815>\');
  MemoNpc.Lines.Add('<以上是代码示例请不要发送。>\');
  MemoNpc.Lines.Add('<发送完后1-5分钟内能领取到元宝,如果扣费成功领取不到元宝联系本服GM或客服>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@106698812]');
  MemoNpc.Lines.Add('<充值范围：1元中国移动 除北京 内蒙 不支持.日10条月30条(不掉单通道)>\');
  MemoNpc.Lines.Add('<示例:游戏帐号为aaaaa 请编写192'+EdtDuanXinNum.Text+'aaaaa 发送到106698812>\');
  MemoNpc.Lines.Add('<以上是代码示例请不要发送。>\');
  MemoNpc.Lines.Add('<发送完后1-5分钟内能领取到元宝,如果扣费成功领取不到元宝联系本服GM或客服>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@106696588]');
  MemoNpc.Lines.Add('<充值范围：1元 北京，上海，不支持.日10条月30条>\');
  MemoNpc.Lines.Add('<充值种类：只限中国移动> 推荐使用本条通道。\ ');
  MemoNpc.Lines.Add('<示例:游戏帐号为aaaaa 请编写WDC'+EdtDuanXinNum.Text+'aaaaa 发送到106696588>\');
  MemoNpc.Lines.Add('<以上是代码示例请不要发送。>\');
  MemoNpc.Lines.Add('<发送完后1-5分钟内能领取到元宝,如果扣费成功领取不到元宝联系本服GM或客服>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@10665123906]');
  MemoNpc.Lines.Add('<充值范围：1元 中国移动 上海,江西,浙江,北京,辽宁,不支持.日10条月30条>\');
  MemoNpc.Lines.Add('<示例:游戏帐号为aaaaa 请编写4#'+EdtDuanXinNum.Text+'aaaaa 发送到10665123906>\');
  MemoNpc.Lines.Add('<以上是代码示例请不要发送。>\');
  MemoNpc.Lines.Add('<发送完后1-5分钟内能领取到元宝,如果扣费成功领取不到元宝联系本服GM或客服>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@1066960016720]');
  MemoNpc.Lines.Add('<充值范围：2元 全国联通. 日7条月15条>推荐使用本条通道\');
  MemoNpc.Lines.Add('<示例:游戏帐号为aaaaa 请编写4#'+EdtDuanXinNum.Text+'aaaaa 发送到1066960016720>\');
  MemoNpc.Lines.Add('<以上是代码示例请不要发送。>\');
  MemoNpc.Lines.Add('<发送完后1-5分钟内能领取到元宝,如果扣费成功领取不到元宝联系本服GM或客服>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@10666000008]');
  MemoNpc.Lines.Add('<充值范围：全国移动声询IVR 5元10元20元 .日20元月40元>\');
  MemoNpc.Lines.Add('<用移动手机打12590775517然后按4号键听5或10、20分钟后会自动挂断>\');
  MemoNpc.Lines.Add('<最后到<查看充值代码/@充值>发送代码.先听歌再发送代码,比短信多一个步骤>\');
  MemoNpc.Lines.Add('<示例:游戏帐号为aaaaa 请编写337'+EdtDuanXinNum.Text+'aaaaa 发送到10666000008>\');
  MemoNpc.Lines.Add('<以上是代码示例请不要发送。>\');
  MemoNpc.Lines.Add('<发送完后1-5分钟内能领取到元宝,如果扣费成功领取不到元宝联系本服GM或客服>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@10666000968]');
  MemoNpc.Lines.Add('<充值范围：1元 全国移动支持.日15条月30条>\');
  MemoNpc.Lines.Add('<示例:游戏帐号为aaaaa 请编写543'+EdtDuanXinNum.Text+'aaaaa 发送到10666000968>\');
  MemoNpc.Lines.Add('<以上是代码示例请不要发送。>\');
  MemoNpc.Lines.Add('<发送完后1-5分钟内能领取到元宝,如果扣费成功领取不到元宝联系本服GM或客服>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@10666000968]');
  MemoNpc.Lines.Add('<充值范围：2元移动 只支持天津、江西、浙江、陕西、新疆省份日7条月15条>\');
  MemoNpc.Lines.Add('<示例:游戏帐号为aaaaa 请编写543'+EdtDuanXinNum.Text+'aaaaa 发送到10666000968>\');
  MemoNpc.Lines.Add('<以上是代码示例请不要发送。>\');
  MemoNpc.Lines.Add('<发送完后1-5分钟内能领取到元宝,如果扣费成功领取不到元宝联系本服GM或客服>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@10666000168]');
  MemoNpc.Lines.Add('<充值范围：2元彩信通道 全国移动支持.日7条月15条>\');
  MemoNpc.Lines.Add('<示例:游戏帐号为aaaaa 请编写237'+EdtDuanXinNum.Text+'aaaaa 发送到10666000168>\');
  MemoNpc.Lines.Add('<以上是代码示例请不要发送。>\');
  MemoNpc.Lines.Add('<发送完后1-5分钟内能领取到元宝,如果扣费成功领取不到元宝联系本服GM或客服>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@领取1]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/1y/1y1.txt ;此路径请不要随意修改');
  MemoNpc.Lines.Add('#ACT');
  MemoNpc.Lines.Add('GAMEGOLD + '+IntToStr(1*nRatio));
  MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/1y/1y1.txt ;此路径请不要随意修改');
  MemoNpc.Lines.Add('SendMsg 7 领取成功.您当前的元宝为:<$GAMEGOLD>个');
  MemoNpc.Lines.Add('SENDMSG 1 ★恭喜玩家<$USERNAME>使用我服推出的在线充值功能,获得元宝。如果你也想要，请赶紧找元宝使者购买吧！');
  for I:=2 to 100 do begin
    MemoNpc.Lines.Add('goto @领取'+IntToStr(I));
  end;
  for I:=102 to 107 do begin
    MemoNpc.Lines.Add('goto @领取'+IntToStr(I));
  end;
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('#ElseACT');
  for I:=2 to 100 do begin
    MemoNpc.Lines.Add('goto @领取'+IntToStr(I));
  end;
  for I:=102 to 107 do begin
    MemoNpc.Lines.Add('goto @领取'+IntToStr(I));
  end;
  MemoNpc.Lines.Add('#Elsesay');
  MemoNpc.Lines.Add('您当前还没有充值或已领取成功,请查看自己的元宝数量!\');
  MemoNpc.Lines.Add('没有充值请按提示进行充值!\');
  MemoNpc.Lines.Add('如有任何问题,请登陆冲值服务网站:<pay.zhaopay.com>\');
  MemoNpc.Lines.Add('<继续领取元宝/@领取1>┆┆┆<元宝查询/@元宝查询>\');
  MemoNpc.Lines.Add('<返回/@main>┆┆┆<退出/@exit>\\');
  for I:=2 to 100 do begin
    MemoNpc.Lines.Add('');
    MemoNpc.Lines.Add('[@领取'+IntToStr(I)+']');
    MemoNpc.Lines.Add('#IF');
    MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/'+IntToStr(I)+'y/'+IntToStr(I)+'y1.txt ;此路径请不要随意修改');
    MemoNpc.Lines.Add('#ACT');
    MemoNpc.Lines.Add('GAMEGOLD + ' + IntToStr(I*nRatio));
    MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/'+IntToStr(I)+'y/'+IntToStr(I)+'y1.txt ;此路径请不要随意修改');
    MemoNpc.Lines.Add('sendmsg 7 领取成功.您当前的元宝为:<$GAMEGOLD>个');
    MemoNpc.Lines.Add('SENDMSG 1 ★恭喜玩家<$USERNAME>使用我服推出的在线充值功能,获得元宝。如果你也想要，请赶紧找元宝使者购买吧！');
  end;
  MemoNpc.Lines.Add('[@领取101]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/0.5y/0.5y1.txt ;此路径请不要随意修改');
  MemoNpc.Lines.Add('#ACT');
  MemoNpc.Lines.Add('GAMEGOLD + ' + IntToStr(Trunc(0.5*nRatio)));  //只取整数部分
  MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/0.5y/0.5y1.txt ;此路径请不要随意修改');
  MemoNpc.Lines.Add('sendmsg 7 领取成功.您当前的元宝为:<$GAMEGOLD>个');
  MemoNpc.Lines.Add('SENDMSG 1 ★恭喜玩家<$USERNAME>使用我服推出的在线充值功能,获得元宝。如果你也想要，请赶紧找元宝使者购买吧！');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@领取102]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/1.5y/1.5y1.txt ;此路径请不要随意修改');
  MemoNpc.Lines.Add('#ACT');
  MemoNpc.Lines.Add('GAMEGOLD + '+ IntToStr(Trunc(1.5*nRatio)));  //只取整数部分
  MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/1.5y/1.5y1.txt ;此路径请不要随意修改');
  MemoNpc.Lines.Add('sendmsg 7 领取成功.您当前的元宝为:<$GAMEGOLD>个');
  MemoNpc.Lines.Add('SENDMSG 1 ★恭喜玩家<$USERNAME>使用我服推出的在线充值功能,获得元宝。如果你也想要，请赶紧找元宝使者购买吧！');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@领取103]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/150y/150y1.txt ;此路径请不要随意修改');
  MemoNpc.Lines.Add('#ACT');
  MemoNpc.Lines.Add('GAMEGOLD + ' + IntToStr(150*nRatio));
  MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/150y/150y1.txt ;此路径请不要随意修改');
  MemoNpc.Lines.Add('sendmsg 7 领取成功.您当前的元宝为:<$GAMEGOLD>个');
  MemoNpc.Lines.Add('SENDMSG 1 ★恭喜玩家<$USERNAME>使用我服推出的在线充值功能,获得元宝。如果你也想要，请赶紧找元宝使者购买吧！');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@领取104]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/200y/200y1.txt ;此路径请不要随意修改');
  MemoNpc.Lines.Add('#ACT');
  MemoNpc.Lines.Add('GAMEGOLD + '+ IntToStr(200*nRatio));
  MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/200y/200y1.txt ;此路径请不要随意修改');
  MemoNpc.Lines.Add('sendmsg 7 领取成功.您当前的元宝为:<$GAMEGOLD>个');
  MemoNpc.Lines.Add('SENDMSG 1 ★恭喜玩家<$USERNAME>使用短信购买元宝功能,获得元宝。如果你也想要，请赶紧找元宝使者购买吧！');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@领取105]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/300y/300y1.txt ;此路径请不要随意修改');
  MemoNpc.Lines.Add('#ACT');
  MemoNpc.Lines.Add('GAMEGOLD + ' + IntToStr(300*nRatio));
  MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/300y/300y1.txt ;此路径请不要随意修改');
  MemoNpc.Lines.Add('sendmsg 7 领取成功.您当前的元宝为:<$GAMEGOLD>个');
  MemoNpc.Lines.Add('SENDMSG 1 ★恭喜玩家<$USERNAME>使用我服推出的在线充值功能,获得元宝。如果你也想要，请赶紧找元宝使者购买吧！');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@领取106]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/500y/500y1.txt ;此路径请不要随意修改');
  MemoNpc.Lines.Add('#ACT');
  MemoNpc.Lines.Add('GAMEGOLD + ' + IntToStr(500*nRatio));
  MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/500y/500y1.txt ;此路径请不要随意修改');
  MemoNpc.Lines.Add('sendmsg 7 领取成功.您当前的元宝为:<$GAMEGOLD>个');
  MemoNpc.Lines.Add('SENDMSG 1 ★恭喜玩家<$USERNAME>使用我服推出的在线充值功能,获得元宝。如果你也想要，请赶紧找元宝使者购买吧！');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@领取107]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/1000y/1000y1.txt ;此路径请不要随意修改');
  MemoNpc.Lines.Add('#ACT');
  MemoNpc.Lines.Add('GAMEGOLD + ' + IntToStr(1000*nRatio));
  MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/1000y/1000y1.txt ;此路径请不要随意修改');
  MemoNpc.Lines.Add('sendmsg 7 领取成功.您当前的元宝为:<$GAMEGOLD>个');
  MemoNpc.Lines.Add('SENDMSG 1 ★恭喜玩家<$USERNAME>使用我服推出的在线充值功能,获得元宝。如果你也想要，请赶紧找元宝使者购买吧！');
  BtnSave.Enabled := True;
end;

procedure TFrmNpcConfig.BtnSaveClick(Sender: TObject);
var
  I: Integer;
  F : TextFile;
  LoadList: TStringList;
  bo15: Boolean;
  s10: string;
begin
  if sDir = '' then begin
    Application.MessageBox('请点选择路径按钮来选择分区目录', '提示', MB_OK + MB_ICONASTERISK);
    Exit;
  end;
  try
    MemoNpc.Lines.SaveToFile(sDir+'Mir200\Envir\Npc_def\短信元宝使者-3.txt');
  except
    Application.MessageBox(PChar('你的服务端'+sDir+'Mir200\Envir\Npc_def\    此目录不存在'+#13+'请选择正确的服务端目录！'), '提示', MB_OK + MB_ICONASTERISK);
    Exit;
  end;
  LoadList := TStringList.Create;
  if FileExists(sDir+'Mir200\Envir\Npcs.txt') then begin
      try
        LoadList.LoadFromFile(sDir+'Mir200\Envir\Npcs.txt');
      except
        Application.MessageBox(PChar('文件读取失败 => ' + sDir+'Mir200\Envir\Npcs.txt'), '提示', MB_OK + MB_ICONASTERISK);
        LoadList.Free;
        Exit;
      end;
  end;
  bo15 := False;
  if LoadList.Count > 0 then begin//20080629
    for I := 0 to LoadList.Count - 1 do begin
      s10 := Trim(LoadList.Strings[I]);
      if CompareText('短信元宝使者	0	3	343	336	0	12', s10) = 0 then begin
        bo15 := True;
        Break;
      end;
    end;
  end;
  if not bo15 then begin
    LoadList.Add('短信元宝使者	0	3	343	336	0	12');
    try
      LoadList.SaveToFile(sDir+'Mir200\Envir\Npcs.txt');
    except
      Application.MessageBox(PChar('文件保存失败 => ' + sDir+'Mir200\Envir\Npcs.txt'), '提示', MB_OK + MB_ICONASTERISK);
      LoadList.Free;
      Exit;
    end;
  end;
  LoadList.Free;
  for I:=1 to 100 do begin
    if ForceDirectories(sDir+'Mir200\Envir\Npc_def\56yb\'+IntToStr(I)+'y') then begin
      AssignFile(F, sDir+'Mir200\Envir\Npc_def\56yb\'+IntToStr(I)+'y\'+IntToStr(I)+'y1.txt'); // 将文件与F变量建立连接，后面可以使用F变量对文件进行操作。
      if not FileExists(sDir+'Mir200\Envir\Npc_def\56yb\'+IntToStr(I)+'y\'+IntToStr(I)+'y1.txt') then begin
        ReWrite(f);
        CloseFile(f);
      end;
    end;
  end;
  if ForceDirectories(sDir+'Mir200\Envir\Npc_def\56yb\0.5y') then begin
    AssignFile(F, sDir+'Mir200\Envir\Npc_def\56yb\0.5y\0.5y1.txt'); // 将文件与F变量建立连接，后面可以使用F变量对文件进行操作。
    if not FileExists(sDir+'Mir200\Envir\Npc_def\56yb\0.5y\0.5y1.txt') then begin
      ReWrite(f);
      CloseFile(f);
    end;
  end;
  if ForceDirectories(sDir+'Mir200\Envir\Npc_def\56yb\1.5y') then begin
    AssignFile(F, sDir+'Mir200\Envir\Npc_def\56yb\1.5y\1.5y1.txt'); // 将文件与F变量建立连接，后面可以使用F变量对文件进行操作。
    if not FileExists(sDir+'Mir200\Envir\Npc_def\56yb\1.5y\1.5y1.txt') then begin
      ReWrite(f);
      CloseFile(f);
    end;
  end;
  if ForceDirectories(sDir+'Mir200\Envir\Npc_def\56yb\150y') then begin
    AssignFile(F, sDir+'Mir200\Envir\Npc_def\56yb\150y\150y1.txt'); // 将文件与F变量建立连接，后面可以使用F变量对文件进行操作。
    if not FileExists(sDir+'Mir200\Envir\Npc_def\56yb\150y\150y1.txt') then begin
      ReWrite(f);
      CloseFile(f);
    end;
  end;
  if ForceDirectories(sDir+'Mir200\Envir\Npc_def\56yb\200y') then begin
    AssignFile(F, sDir+'Mir200\Envir\Npc_def\56yb\200y\200y1.txt'); // 将文件与F变量建立连接，后面可以使用F变量对文件进行操作。
    if not FileExists(sDir+'Mir200\Envir\Npc_def\56yb\200y\200y1.txt') then begin
      ReWrite(f);
      CloseFile(f);
    end;
  end;
  if ForceDirectories(sDir+'Mir200\Envir\Npc_def\56yb\300y') then begin
    AssignFile(F, sDir+'Mir200\Envir\Npc_def\56yb\300y\300y1.txt'); // 将文件与F变量建立连接，后面可以使用F变量对文件进行操作。
    if not FileExists(sDir+'Mir200\Envir\Npc_def\56yb\300y\300y1.txt') then begin
      ReWrite(f);
      CloseFile(f);
    end;
  end;
  if ForceDirectories(sDir+'Mir200\Envir\Npc_def\56yb\500y') then begin
    AssignFile(F, sDir+'Mir200\Envir\Npc_def\56yb\500y\500y1.txt'); // 将文件与F变量建立连接，后面可以使用F变量对文件进行操作。
    if not FileExists(sDir+'Mir200\Envir\Npc_def\56yb\500y\500y1.txt') then begin
      ReWrite(f);
      CloseFile(f);
    end;
  end;
  if ForceDirectories(sDir+'Mir200\Envir\Npc_def\56yb\1000y') then begin
    AssignFile(F, sDir+'Mir200\Envir\Npc_def\56yb\1000y\1000y1.txt'); // 将文件与F变量建立连接，后面可以使用F变量对文件进行操作。
    if not FileExists(sDir+'Mir200\Envir\Npc_def\56yb\1000y\1000y1.txt') then begin
      ReWrite(f);
      CloseFile(f);
    end;
  end;
  Application.MessageBox('文件保存成功！'+#13+'短信元宝使者会出现在盟重安全区', '提示', MB_OK + MB_ICONASTERISK);
end;

procedure TFrmNpcConfig.BtnSelDirClick(Sender: TObject);
  //检查是否传奇服务端目录
  function CheckMirServerDir(DirName: string): Boolean;
  begin
    if (not DirectoryExists(DirName + 'Mir200')) or
      (not DirectoryExists(DirName + 'Mud2')) or
      (not DirectoryExists(DirName + 'DBServer')) or
      (not FileExists(DirName + 'Mir200\M2Server.exe')) then
      Result := FALSE else Result := True;
  end;
var
  dir: string;
begin
  if SelectDirectory('选择你分区的服务端目录'+#13+'例：X:\MirServer\', '选择目录', Dir, Handle) then begin
     sDir := Dir + '\';
     if not CheckMirServerDir(sDir) then begin
       Application.MessageBox('你选择的服务端目录是错的'+#13+'提示：选择服务端的总目录就可以'+#13+'例子：X:\MirServer\', '提示', MB_OK + MB_ICONASTERISK);
       sDir := '';
       Exit;
     end;
  end;
end;

end.
