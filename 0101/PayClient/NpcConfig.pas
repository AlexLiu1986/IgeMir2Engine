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
    Application.MessageBox('����д���Ŵ����!'+#13+'��ʾ���뵽��֧����̨�鿴���Ķ��Ŵ����', '��ʾ', MB_OK + MB_ICONASTERISK);
    Exit;
  end;
  nRatio := SEdtRatio.Value;
  MemoNpc.Clear;
  MemoNpc.Lines.Add('[@main]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('#SAY');
  MemoNpc.Lines.Add('<$USERNAME>��ã���ӭ����<$SERVERNAME>���ܸ���Ϊ������\');
  MemoNpc.Lines.Add('��֧����ֵԪ��ע������-----����Ԫ������1ԪRMB='+IntToStr(SEdtRatio.Value)+'Ԫ��\');
  MemoNpc.Lines.Add('�ٱ�ϵͳ֧��������ʢ��,������,��;��,������,����,ħ������,��Ѷ��\');
  MemoNpc.Lines.Add('�ڳ�ֵ���������������ϵõ�Ԫ���������GM��װ��\');
  MemoNpc.Lines.Add('��<��ƽ̨�Ƴ���ֻҪ�������һ������ĵ���ֵϵͳ>|<www.zhaopay.com>\');
  MemoNpc.Lines.Add('���ʷ�:����1ԪRMB='+IntToStr(SEdtRatio.Value)+'Ԫ�� ��������ٷ���վ����ӭ���ʹ��\');
  MemoNpc.Lines.Add('������������ɹ�,����ȡ�κη���.��֤�ٷְٲ���������\');
  MemoNpc.Lines.Add('<Ԫ����ֵ/@��ֵ>��<Ԫ����ȡ/@��ȡ1>��<Ԫ����ѯ/@Ԫ����ѯ>��<�˳�/@exit>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@Ԫ����ѯ]');
  MemoNpc.Lines.Add('#SAY');
  MemoNpc.Lines.Add('����ǰ��Ԫ��Ϊ��<$GAMEGOLD>�� ');
  MemoNpc.Lines.Add('\');
  MemoNpc.Lines.Add('\');
  MemoNpc.Lines.Add('<������ȡԪ��/@��ȡ1>������\');
  MemoNpc.Lines.Add('<����/@main>������<�˳�/@exit>\\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@��ֵ]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('#SAY');
  MemoNpc.Lines.Add('<������ֵ�㿨��ƽ̨�뿴������ҳ��>\');
  MemoNpc.Lines.Add('<�ƶ�1Ԫ   �༭WDC'+EdtDuanXinNum.Text+'��Ϸ�ʺ� ���͵�106696588>(<��ֵ˵��/@106696588>)\');
  MemoNpc.Lines.Add('<�ƶ�1.5Ԫ �༭192'+EdtDuanXinNum.Text+'��Ϸ�ʺ� ���͵�106698815>(<��ֵ˵��/@106698815>)\');
  MemoNpc.Lines.Add('<�ƶ�1Ԫ   �༭192'+EdtDuanXinNum.Text+'��Ϸ�ʺ� ���͵�106698812>(<��ֵ˵��/@106698812>)\');
  MemoNpc.Lines.Add('<��һҳ����ͨ��/@��ֵ2>��<Ԫ����ȡ/@��ȡ1>��<Ԫ����ѯ/@Ԫ����ѯ>��<����/@main>\');
  MemoNpc.Lines.Add('<��֧��ƽ̨�������һҳ����ͨ���и���ѡ��^^^^^^^^^\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@��ֵ2]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('#SAY');
  MemoNpc.Lines.Add('<������ֵ�㿨��ƽ̨�뿴������ҳ��>\');
  MemoNpc.Lines.Add('<�ƶ�1Ԫ   �༭ 54'+EdtDuanXinNum.Text+'��Ϸ�ʺ� ���͵�10665123906>(<��ֵ˵��/@10665123906>)\');
  MemoNpc.Lines.Add('<�ƶ�1Ԫ   �༭543'+EdtDuanXinNum.Text+'��Ϸ�ʺ� ���͵�10666000968>(<��ֵ˵��/@10666000968>)\');
  MemoNpc.Lines.Add('<��ͨ2Ԫ   �༭ 4#'+EdtDuanXinNum.Text+'��Ϸ�ʺ� ���͵�1066960016720>(<��ֵ˵��/@1066960016720>)\');
  MemoNpc.Lines.Add('<�ƶ�2Ԫ   �༭337'+EdtDuanXinNum.Text+'��Ϸ�ʺ� ���͵�10666000923>(<��ֵ˵��/@10666000923>)\');
  MemoNpc.Lines.Add('<�ƶ�2Ԫ   �༭237'+EdtDuanXinNum.Text+'��Ϸ�ʺ� ���͵�10666000168>(<��ֵ˵��/@10666000168>)\');
  MemoNpc.Lines.Add('<�ƶ�IVR 5Ԫ10Ԫ20Ԫ �༭237'+EdtDuanXinNum.Text+'��Ϸ�ʺ� ���͵�10666000168>(<��ֵ˵��/@10666000168>)\');
  MemoNpc.Lines.Add('<��һҳͨ��/@��ֵ>��<Ԫ����ȡ/@��ȡ1>��<Ԫ����ѯ/@Ԫ����ѯ>��<����/@main>\');
  MemoNpc.Lines.Add('<��֧��ƽ̨�����֧�������Ƿ�չ�Ķ���^^^^^^^^^\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@106698815]');
  MemoNpc.Lines.Add('<��ֵ��Χ��1Ԫ�й��ƶ� ���㽭�������ɲ�֧��.��10����30��(������ͨ��)>\');
  MemoNpc.Lines.Add('<ʾ��:��Ϸ�ʺ�Ϊaaaaa ���д192'+EdtDuanXinNum.Text+'aaaaa ���͵�106698815>\');
  MemoNpc.Lines.Add('<�����Ǵ���ʾ���벻Ҫ���͡�>\');
  MemoNpc.Lines.Add('<�������1-5����������ȡ��Ԫ��,����۷ѳɹ���ȡ����Ԫ����ϵ����GM��ͷ�>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@106698812]');
  MemoNpc.Lines.Add('<��ֵ��Χ��1Ԫ�й��ƶ� ������ ���� ��֧��.��10����30��(������ͨ��)>\');
  MemoNpc.Lines.Add('<ʾ��:��Ϸ�ʺ�Ϊaaaaa ���д192'+EdtDuanXinNum.Text+'aaaaa ���͵�106698812>\');
  MemoNpc.Lines.Add('<�����Ǵ���ʾ���벻Ҫ���͡�>\');
  MemoNpc.Lines.Add('<�������1-5����������ȡ��Ԫ��,����۷ѳɹ���ȡ����Ԫ����ϵ����GM��ͷ�>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@106696588]');
  MemoNpc.Lines.Add('<��ֵ��Χ��1Ԫ �������Ϻ�����֧��.��10����30��>\');
  MemoNpc.Lines.Add('<��ֵ���ֻࣺ���й��ƶ�> �Ƽ�ʹ�ñ���ͨ����\ ');
  MemoNpc.Lines.Add('<ʾ��:��Ϸ�ʺ�Ϊaaaaa ���дWDC'+EdtDuanXinNum.Text+'aaaaa ���͵�106696588>\');
  MemoNpc.Lines.Add('<�����Ǵ���ʾ���벻Ҫ���͡�>\');
  MemoNpc.Lines.Add('<�������1-5����������ȡ��Ԫ��,����۷ѳɹ���ȡ����Ԫ����ϵ����GM��ͷ�>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@10665123906]');
  MemoNpc.Lines.Add('<��ֵ��Χ��1Ԫ �й��ƶ� �Ϻ�,����,�㽭,����,����,��֧��.��10����30��>\');
  MemoNpc.Lines.Add('<ʾ��:��Ϸ�ʺ�Ϊaaaaa ���д4#'+EdtDuanXinNum.Text+'aaaaa ���͵�10665123906>\');
  MemoNpc.Lines.Add('<�����Ǵ���ʾ���벻Ҫ���͡�>\');
  MemoNpc.Lines.Add('<�������1-5����������ȡ��Ԫ��,����۷ѳɹ���ȡ����Ԫ����ϵ����GM��ͷ�>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@1066960016720]');
  MemoNpc.Lines.Add('<��ֵ��Χ��2Ԫ ȫ����ͨ. ��7����15��>�Ƽ�ʹ�ñ���ͨ��\');
  MemoNpc.Lines.Add('<ʾ��:��Ϸ�ʺ�Ϊaaaaa ���д4#'+EdtDuanXinNum.Text+'aaaaa ���͵�1066960016720>\');
  MemoNpc.Lines.Add('<�����Ǵ���ʾ���벻Ҫ���͡�>\');
  MemoNpc.Lines.Add('<�������1-5����������ȡ��Ԫ��,����۷ѳɹ���ȡ����Ԫ����ϵ����GM��ͷ�>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@10666000008]');
  MemoNpc.Lines.Add('<��ֵ��Χ��ȫ���ƶ���ѯIVR 5Ԫ10Ԫ20Ԫ .��20Ԫ��40Ԫ>\');
  MemoNpc.Lines.Add('<���ƶ��ֻ���12590775517Ȼ��4�ż���5��10��20���Ӻ���Զ��Ҷ�>\');
  MemoNpc.Lines.Add('<���<�鿴��ֵ����/@��ֵ>���ʹ���.�������ٷ��ʹ���,�ȶ��Ŷ�һ������>\');
  MemoNpc.Lines.Add('<ʾ��:��Ϸ�ʺ�Ϊaaaaa ���д337'+EdtDuanXinNum.Text+'aaaaa ���͵�10666000008>\');
  MemoNpc.Lines.Add('<�����Ǵ���ʾ���벻Ҫ���͡�>\');
  MemoNpc.Lines.Add('<�������1-5����������ȡ��Ԫ��,����۷ѳɹ���ȡ����Ԫ����ϵ����GM��ͷ�>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@10666000968]');
  MemoNpc.Lines.Add('<��ֵ��Χ��1Ԫ ȫ���ƶ�֧��.��15����30��>\');
  MemoNpc.Lines.Add('<ʾ��:��Ϸ�ʺ�Ϊaaaaa ���д543'+EdtDuanXinNum.Text+'aaaaa ���͵�10666000968>\');
  MemoNpc.Lines.Add('<�����Ǵ���ʾ���벻Ҫ���͡�>\');
  MemoNpc.Lines.Add('<�������1-5����������ȡ��Ԫ��,����۷ѳɹ���ȡ����Ԫ����ϵ����GM��ͷ�>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@10666000968]');
  MemoNpc.Lines.Add('<��ֵ��Χ��2Ԫ�ƶ� ֻ֧����򡢽������㽭���������½�ʡ����7����15��>\');
  MemoNpc.Lines.Add('<ʾ��:��Ϸ�ʺ�Ϊaaaaa ���д543'+EdtDuanXinNum.Text+'aaaaa ���͵�10666000968>\');
  MemoNpc.Lines.Add('<�����Ǵ���ʾ���벻Ҫ���͡�>\');
  MemoNpc.Lines.Add('<�������1-5����������ȡ��Ԫ��,����۷ѳɹ���ȡ����Ԫ����ϵ����GM��ͷ�>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@10666000168]');
  MemoNpc.Lines.Add('<��ֵ��Χ��2Ԫ����ͨ�� ȫ���ƶ�֧��.��7����15��>\');
  MemoNpc.Lines.Add('<ʾ��:��Ϸ�ʺ�Ϊaaaaa ���д237'+EdtDuanXinNum.Text+'aaaaa ���͵�10666000168>\');
  MemoNpc.Lines.Add('<�����Ǵ���ʾ���벻Ҫ���͡�>\');
  MemoNpc.Lines.Add('<�������1-5����������ȡ��Ԫ��,����۷ѳɹ���ȡ����Ԫ����ϵ����GM��ͷ�>\');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@��ȡ1]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/1y/1y1.txt ;��·���벻Ҫ�����޸�');
  MemoNpc.Lines.Add('#ACT');
  MemoNpc.Lines.Add('GAMEGOLD + '+IntToStr(1*nRatio));
  MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/1y/1y1.txt ;��·���벻Ҫ�����޸�');
  MemoNpc.Lines.Add('SendMsg 7 ��ȡ�ɹ�.����ǰ��Ԫ��Ϊ:<$GAMEGOLD>��');
  MemoNpc.Lines.Add('SENDMSG 1 �﹧ϲ���<$USERNAME>ʹ���ҷ��Ƴ������߳�ֵ����,���Ԫ���������Ҳ��Ҫ����Ͻ���Ԫ��ʹ�߹���ɣ�');
  for I:=2 to 100 do begin
    MemoNpc.Lines.Add('goto @��ȡ'+IntToStr(I));
  end;
  for I:=102 to 107 do begin
    MemoNpc.Lines.Add('goto @��ȡ'+IntToStr(I));
  end;
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('#ElseACT');
  for I:=2 to 100 do begin
    MemoNpc.Lines.Add('goto @��ȡ'+IntToStr(I));
  end;
  for I:=102 to 107 do begin
    MemoNpc.Lines.Add('goto @��ȡ'+IntToStr(I));
  end;
  MemoNpc.Lines.Add('#Elsesay');
  MemoNpc.Lines.Add('����ǰ��û�г�ֵ������ȡ�ɹ�,��鿴�Լ���Ԫ������!\');
  MemoNpc.Lines.Add('û�г�ֵ�밴��ʾ���г�ֵ!\');
  MemoNpc.Lines.Add('�����κ�����,���½��ֵ������վ:<pay.zhaopay.com>\');
  MemoNpc.Lines.Add('<������ȡԪ��/@��ȡ1>������<Ԫ����ѯ/@Ԫ����ѯ>\');
  MemoNpc.Lines.Add('<����/@main>������<�˳�/@exit>\\');
  for I:=2 to 100 do begin
    MemoNpc.Lines.Add('');
    MemoNpc.Lines.Add('[@��ȡ'+IntToStr(I)+']');
    MemoNpc.Lines.Add('#IF');
    MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/'+IntToStr(I)+'y/'+IntToStr(I)+'y1.txt ;��·���벻Ҫ�����޸�');
    MemoNpc.Lines.Add('#ACT');
    MemoNpc.Lines.Add('GAMEGOLD + ' + IntToStr(I*nRatio));
    MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/'+IntToStr(I)+'y/'+IntToStr(I)+'y1.txt ;��·���벻Ҫ�����޸�');
    MemoNpc.Lines.Add('sendmsg 7 ��ȡ�ɹ�.����ǰ��Ԫ��Ϊ:<$GAMEGOLD>��');
    MemoNpc.Lines.Add('SENDMSG 1 �﹧ϲ���<$USERNAME>ʹ���ҷ��Ƴ������߳�ֵ����,���Ԫ���������Ҳ��Ҫ����Ͻ���Ԫ��ʹ�߹���ɣ�');
  end;
  MemoNpc.Lines.Add('[@��ȡ101]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/0.5y/0.5y1.txt ;��·���벻Ҫ�����޸�');
  MemoNpc.Lines.Add('#ACT');
  MemoNpc.Lines.Add('GAMEGOLD + ' + IntToStr(Trunc(0.5*nRatio)));  //ֻȡ��������
  MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/0.5y/0.5y1.txt ;��·���벻Ҫ�����޸�');
  MemoNpc.Lines.Add('sendmsg 7 ��ȡ�ɹ�.����ǰ��Ԫ��Ϊ:<$GAMEGOLD>��');
  MemoNpc.Lines.Add('SENDMSG 1 �﹧ϲ���<$USERNAME>ʹ���ҷ��Ƴ������߳�ֵ����,���Ԫ���������Ҳ��Ҫ����Ͻ���Ԫ��ʹ�߹���ɣ�');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@��ȡ102]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/1.5y/1.5y1.txt ;��·���벻Ҫ�����޸�');
  MemoNpc.Lines.Add('#ACT');
  MemoNpc.Lines.Add('GAMEGOLD + '+ IntToStr(Trunc(1.5*nRatio)));  //ֻȡ��������
  MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/1.5y/1.5y1.txt ;��·���벻Ҫ�����޸�');
  MemoNpc.Lines.Add('sendmsg 7 ��ȡ�ɹ�.����ǰ��Ԫ��Ϊ:<$GAMEGOLD>��');
  MemoNpc.Lines.Add('SENDMSG 1 �﹧ϲ���<$USERNAME>ʹ���ҷ��Ƴ������߳�ֵ����,���Ԫ���������Ҳ��Ҫ����Ͻ���Ԫ��ʹ�߹���ɣ�');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@��ȡ103]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/150y/150y1.txt ;��·���벻Ҫ�����޸�');
  MemoNpc.Lines.Add('#ACT');
  MemoNpc.Lines.Add('GAMEGOLD + ' + IntToStr(150*nRatio));
  MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/150y/150y1.txt ;��·���벻Ҫ�����޸�');
  MemoNpc.Lines.Add('sendmsg 7 ��ȡ�ɹ�.����ǰ��Ԫ��Ϊ:<$GAMEGOLD>��');
  MemoNpc.Lines.Add('SENDMSG 1 �﹧ϲ���<$USERNAME>ʹ���ҷ��Ƴ������߳�ֵ����,���Ԫ���������Ҳ��Ҫ����Ͻ���Ԫ��ʹ�߹���ɣ�');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@��ȡ104]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/200y/200y1.txt ;��·���벻Ҫ�����޸�');
  MemoNpc.Lines.Add('#ACT');
  MemoNpc.Lines.Add('GAMEGOLD + '+ IntToStr(200*nRatio));
  MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/200y/200y1.txt ;��·���벻Ҫ�����޸�');
  MemoNpc.Lines.Add('sendmsg 7 ��ȡ�ɹ�.����ǰ��Ԫ��Ϊ:<$GAMEGOLD>��');
  MemoNpc.Lines.Add('SENDMSG 1 �﹧ϲ���<$USERNAME>ʹ�ö��Ź���Ԫ������,���Ԫ���������Ҳ��Ҫ����Ͻ���Ԫ��ʹ�߹���ɣ�');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@��ȡ105]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/300y/300y1.txt ;��·���벻Ҫ�����޸�');
  MemoNpc.Lines.Add('#ACT');
  MemoNpc.Lines.Add('GAMEGOLD + ' + IntToStr(300*nRatio));
  MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/300y/300y1.txt ;��·���벻Ҫ�����޸�');
  MemoNpc.Lines.Add('sendmsg 7 ��ȡ�ɹ�.����ǰ��Ԫ��Ϊ:<$GAMEGOLD>��');
  MemoNpc.Lines.Add('SENDMSG 1 �﹧ϲ���<$USERNAME>ʹ���ҷ��Ƴ������߳�ֵ����,���Ԫ���������Ҳ��Ҫ����Ͻ���Ԫ��ʹ�߹���ɣ�');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@��ȡ106]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/500y/500y1.txt ;��·���벻Ҫ�����޸�');
  MemoNpc.Lines.Add('#ACT');
  MemoNpc.Lines.Add('GAMEGOLD + ' + IntToStr(500*nRatio));
  MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/500y/500y1.txt ;��·���벻Ҫ�����޸�');
  MemoNpc.Lines.Add('sendmsg 7 ��ȡ�ɹ�.����ǰ��Ԫ��Ϊ:<$GAMEGOLD>��');
  MemoNpc.Lines.Add('SENDMSG 1 �﹧ϲ���<$USERNAME>ʹ���ҷ��Ƴ������߳�ֵ����,���Ԫ���������Ҳ��Ҫ����Ͻ���Ԫ��ʹ�߹���ɣ�');
  MemoNpc.Lines.Add('');
  MemoNpc.Lines.Add('[@��ȡ107]');
  MemoNpc.Lines.Add('#IF');
  MemoNpc.Lines.Add('CHECKACCOUNTLIST 	56yb/1000y/1000y1.txt ;��·���벻Ҫ�����޸�');
  MemoNpc.Lines.Add('#ACT');
  MemoNpc.Lines.Add('GAMEGOLD + ' + IntToStr(1000*nRatio));
  MemoNpc.Lines.Add('DELACCOUNTLIST 	56yb/1000y/1000y1.txt ;��·���벻Ҫ�����޸�');
  MemoNpc.Lines.Add('sendmsg 7 ��ȡ�ɹ�.����ǰ��Ԫ��Ϊ:<$GAMEGOLD>��');
  MemoNpc.Lines.Add('SENDMSG 1 �﹧ϲ���<$USERNAME>ʹ���ҷ��Ƴ������߳�ֵ����,���Ԫ���������Ҳ��Ҫ����Ͻ���Ԫ��ʹ�߹���ɣ�');
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
    Application.MessageBox('���ѡ��·����ť��ѡ�����Ŀ¼', '��ʾ', MB_OK + MB_ICONASTERISK);
    Exit;
  end;
  try
    MemoNpc.Lines.SaveToFile(sDir+'Mir200\Envir\Npc_def\����Ԫ��ʹ��-3.txt');
  except
    Application.MessageBox(PChar('��ķ����'+sDir+'Mir200\Envir\Npc_def\    ��Ŀ¼������'+#13+'��ѡ����ȷ�ķ����Ŀ¼��'), '��ʾ', MB_OK + MB_ICONASTERISK);
    Exit;
  end;
  LoadList := TStringList.Create;
  if FileExists(sDir+'Mir200\Envir\Npcs.txt') then begin
      try
        LoadList.LoadFromFile(sDir+'Mir200\Envir\Npcs.txt');
      except
        Application.MessageBox(PChar('�ļ���ȡʧ�� => ' + sDir+'Mir200\Envir\Npcs.txt'), '��ʾ', MB_OK + MB_ICONASTERISK);
        LoadList.Free;
        Exit;
      end;
  end;
  bo15 := False;
  if LoadList.Count > 0 then begin//20080629
    for I := 0 to LoadList.Count - 1 do begin
      s10 := Trim(LoadList.Strings[I]);
      if CompareText('����Ԫ��ʹ��	0	3	343	336	0	12', s10) = 0 then begin
        bo15 := True;
        Break;
      end;
    end;
  end;
  if not bo15 then begin
    LoadList.Add('����Ԫ��ʹ��	0	3	343	336	0	12');
    try
      LoadList.SaveToFile(sDir+'Mir200\Envir\Npcs.txt');
    except
      Application.MessageBox(PChar('�ļ�����ʧ�� => ' + sDir+'Mir200\Envir\Npcs.txt'), '��ʾ', MB_OK + MB_ICONASTERISK);
      LoadList.Free;
      Exit;
    end;
  end;
  LoadList.Free;
  for I:=1 to 100 do begin
    if ForceDirectories(sDir+'Mir200\Envir\Npc_def\56yb\'+IntToStr(I)+'y') then begin
      AssignFile(F, sDir+'Mir200\Envir\Npc_def\56yb\'+IntToStr(I)+'y\'+IntToStr(I)+'y1.txt'); // ���ļ���F�����������ӣ��������ʹ��F�������ļ����в�����
      if not FileExists(sDir+'Mir200\Envir\Npc_def\56yb\'+IntToStr(I)+'y\'+IntToStr(I)+'y1.txt') then begin
        ReWrite(f);
        CloseFile(f);
      end;
    end;
  end;
  if ForceDirectories(sDir+'Mir200\Envir\Npc_def\56yb\0.5y') then begin
    AssignFile(F, sDir+'Mir200\Envir\Npc_def\56yb\0.5y\0.5y1.txt'); // ���ļ���F�����������ӣ��������ʹ��F�������ļ����в�����
    if not FileExists(sDir+'Mir200\Envir\Npc_def\56yb\0.5y\0.5y1.txt') then begin
      ReWrite(f);
      CloseFile(f);
    end;
  end;
  if ForceDirectories(sDir+'Mir200\Envir\Npc_def\56yb\1.5y') then begin
    AssignFile(F, sDir+'Mir200\Envir\Npc_def\56yb\1.5y\1.5y1.txt'); // ���ļ���F�����������ӣ��������ʹ��F�������ļ����в�����
    if not FileExists(sDir+'Mir200\Envir\Npc_def\56yb\1.5y\1.5y1.txt') then begin
      ReWrite(f);
      CloseFile(f);
    end;
  end;
  if ForceDirectories(sDir+'Mir200\Envir\Npc_def\56yb\150y') then begin
    AssignFile(F, sDir+'Mir200\Envir\Npc_def\56yb\150y\150y1.txt'); // ���ļ���F�����������ӣ��������ʹ��F�������ļ����в�����
    if not FileExists(sDir+'Mir200\Envir\Npc_def\56yb\150y\150y1.txt') then begin
      ReWrite(f);
      CloseFile(f);
    end;
  end;
  if ForceDirectories(sDir+'Mir200\Envir\Npc_def\56yb\200y') then begin
    AssignFile(F, sDir+'Mir200\Envir\Npc_def\56yb\200y\200y1.txt'); // ���ļ���F�����������ӣ��������ʹ��F�������ļ����в�����
    if not FileExists(sDir+'Mir200\Envir\Npc_def\56yb\200y\200y1.txt') then begin
      ReWrite(f);
      CloseFile(f);
    end;
  end;
  if ForceDirectories(sDir+'Mir200\Envir\Npc_def\56yb\300y') then begin
    AssignFile(F, sDir+'Mir200\Envir\Npc_def\56yb\300y\300y1.txt'); // ���ļ���F�����������ӣ��������ʹ��F�������ļ����в�����
    if not FileExists(sDir+'Mir200\Envir\Npc_def\56yb\300y\300y1.txt') then begin
      ReWrite(f);
      CloseFile(f);
    end;
  end;
  if ForceDirectories(sDir+'Mir200\Envir\Npc_def\56yb\500y') then begin
    AssignFile(F, sDir+'Mir200\Envir\Npc_def\56yb\500y\500y1.txt'); // ���ļ���F�����������ӣ��������ʹ��F�������ļ����в�����
    if not FileExists(sDir+'Mir200\Envir\Npc_def\56yb\500y\500y1.txt') then begin
      ReWrite(f);
      CloseFile(f);
    end;
  end;
  if ForceDirectories(sDir+'Mir200\Envir\Npc_def\56yb\1000y') then begin
    AssignFile(F, sDir+'Mir200\Envir\Npc_def\56yb\1000y\1000y1.txt'); // ���ļ���F�����������ӣ��������ʹ��F�������ļ����в�����
    if not FileExists(sDir+'Mir200\Envir\Npc_def\56yb\1000y\1000y1.txt') then begin
      ReWrite(f);
      CloseFile(f);
    end;
  end;
  Application.MessageBox('�ļ�����ɹ���'+#13+'����Ԫ��ʹ�߻���������ذ�ȫ��', '��ʾ', MB_OK + MB_ICONASTERISK);
end;

procedure TFrmNpcConfig.BtnSelDirClick(Sender: TObject);
  //����Ƿ�������Ŀ¼
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
  if SelectDirectory('ѡ��������ķ����Ŀ¼'+#13+'����X:\MirServer\', 'ѡ��Ŀ¼', Dir, Handle) then begin
     sDir := Dir + '\';
     if not CheckMirServerDir(sDir) then begin
       Application.MessageBox('��ѡ��ķ����Ŀ¼�Ǵ��'+#13+'��ʾ��ѡ�����˵���Ŀ¼�Ϳ���'+#13+'���ӣ�X:\MirServer\', '��ʾ', MB_OK + MB_ICONASTERISK);
       sDir := '';
       Exit;
     end;
  end;
end;

end.
