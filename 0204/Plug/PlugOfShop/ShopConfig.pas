unit ShopConfig;

interface

uses
  Windows, SysUtils, Classes,  Controls, Forms,
  Dialogs,  Spin, ComCtrls, EngineAPI, EngineType,
  RzPanel, IniFiles, StdCtrls, ExtCtrls;

type
  TFrmShopItem = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    ListViewItemList: TListView;
    ListBoxItemList: TListBox;
    Label1: TLabel;
    EditShopItemName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    ButtonChgShopItem: TButton;
    ButtonDelShopItem: TButton;
    SpinEditPrice: TSpinEdit;
    Memo1: TMemo;
    ButtonAddShopItem: TButton;
    ButtonLoadShopItemList: TButton;
    ButtonSaveShopItemList: TButton;
    RzPanel1: TRzPanel;
    Label4: TLabel;
    EditShopItemIntroduce: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    EditShopImgBegin: TEdit;
    EditShopImgEnd: TEdit;
    Label7: TLabel;
    ShopTypeBoBox: TComboBox;
    Label8: TLabel;
    GroupBox3: TGroupBox;
    CheckBoxBuyGameGird: TCheckBox;
    SpinEditGameGird: TSpinEdit;
    Label9: TLabel;
    procedure ListViewItemListClick(Sender: TObject);
    procedure ButtonChgShopItemClick(Sender: TObject);
    procedure ButtonDelShopItemClick(Sender: TObject);
    procedure ButtonAddShopItemClick(Sender: TObject);
    procedure ListBoxItemListClick(Sender: TObject);
    procedure ButtonSaveShopItemListClick(Sender: TObject);
    procedure ButtonLoadShopItemListClick(Sender: TObject);
    procedure RzTabControl1Change(Sender: TObject);
    procedure CheckBoxBuyGameGirdClick(Sender: TObject);
    procedure SpinEditGameGirdChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBoxItemListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    function InListViewItemList(sItemName: string): Boolean;
    procedure RefLoadShopItemList();
    procedure FindListBox(); //�����б������Ʒ 20080615
  public
    { Public declarations }
    procedure Open();
  end;

var
  FrmShopItem: TFrmShopItem;
implementation
uses PlayShop, HUtil32, PlugShare;
{$R *.dfm}
function TFrmShopItem.InListViewItemList(sItemName: string): Boolean;
var
  I: Integer;
  ListItem: TListItem;
begin
  Result := False;
  Try
  ListViewItemList.Items.BeginUpdate;
  try
    for I := 0 to ListViewItemList.Items.Count - 1 do begin
      ListItem := ListViewItemList.Items.Item[I];
      if CompareText(sItemName, ListItem.Caption) = 0 then begin
        Result := True;
        Break;
      end;
    end;
  finally
    ListViewItemList.Items.EndUpdate;
  end;
  except
    MainOutMessage('[�쳣] PlugOfShop.InListViewItemList');
  end;
end;

procedure TFrmShopItem.RefLoadShopItemList();
var
  I: Integer;
  ListItem: TListItem;
  sItemName: string;
  sPrice: string;
  ShopInfo: pTShopInfo;
  sMemo: string;

  //���� 2007.11.15
  sIdx: string;
  sImgBegin: string;
  sImgend: string;
  sIntroduce: string;
  //pp:pTShopInfo;
  ///////////////////
begin
Try
  ListViewItemList.Clear;
  if g_ShopItemList <> nil then begin
    if g_ShopItemList.Count > 0 then begin//20080629
      for I := 0 to g_ShopItemList.Count - 1 do begin
        ShopInfo := pTShopInfo(g_ShopItemList.Items[I]);
        sIdx := ShopInfo.Idx;//���� 2007.11.15
        sItemName := ShopInfo.StdItem.szName;
        sPrice := IntToStr(ShopInfo.StdItem.nPrice div 100);
        sImgBegin := ShopInfo.ImgBegin; //���� 2007.11.15
        sImgEnd := ShopInfo.Imgend;  //���� 2007.11.15
        sIntroduce := ShopInfo.Introduce1; //���� 2007.11.15

        sMemo := StrPas(@ShopInfo.sIntroduce);

          ListViewItemList.Items.BeginUpdate;
        try
          {pp := AllocMem(SizeOf(TShopInfo));
          pp^.Idx:=sIdx;
          pp^.ImgBegin:=sImgBegin;
          pp^.Imgend:=sImgEnd;
          pp^.Introduce1:=sIntroduce;
          Move(sMemo, pp^.sIntroduce, Length(sMemo));
          ListItem.Data:=pp; }

          ListItem := ListViewItemList.Items.Add;
          ListItem.Caption := sItemName;
          ListItem.SubItems.Add(sIdx);
          ListItem.SubItems.Add(sPrice);

          ListItem.SubItems.Add(sImgBegin);//���� 2007.11.15
          ListItem.SubItems.Add(sImgEnd);//���� 2007.11.15
          ListItem.SubItems.Add(sIntroduce);//���� 2007.11.15
          ListItem.SubItems.Add(sMemo);

        finally
          ListViewItemList.Items.EndUpdate;
        end;
      end;//for
    end;
  end;
  except
    MainOutMessage('[�쳣] PlugOfShop.RefLoadShopItemList');
  end;
end;

procedure TFrmShopItem.Open();
var
  I: Integer;
  //StdItem: _LPTOSTDITEM;  //20080728�޸� ʹ������
  StdItem: _LPTSTDITEM;
  List: Classes.TList;
begin
Try
  ButtonChgShopItem.Enabled := False;
  ButtonDelShopItem.Enabled := False;
  ButtonAddShopItem.Enabled := False;
  ListBoxItemList.Items.Clear;
  List := Classes.TList(TUserEngine_GetStdItemList);
  if List <> nil then begin
    if List.Count > 0 then begin//20080629
      for I := 0 to List.Count - 1 do begin
        StdItem := List.Items[I];
        ListBoxItemList.Items.AddObject(StdItem.szName, TObject(StdItem));
      end;
    end;
  end;
  //LoadShopItemList();
  RefLoadShopItemList();
  ShowModal;
  except
    MainOutMessage('[�쳣] PlugOfShop.Open');
  end;
end;

procedure TFrmShopItem.ListViewItemListClick(Sender: TObject);
var
  nItemIndex: Integer;
  ListItem: TListItem;
begin
  try
    nItemIndex := ListViewItemList.ItemIndex;
    ListItem := ListViewItemList.Items.Item[nItemIndex];
    EditShopItemName.Text := ListItem.Caption;
    SpinEditPrice.Value := Str_ToInt(ListItem.SubItems.Strings[1], 0);
    EditShopImgBegin.Text :=ListItem.SubItems.Strings[2];
    EditShopImgEnd.Text :=ListItem.SubItems.Strings[3];
    EditShopItemIntroduce.Text := ListItem.SubItems.Strings[4];
    ShopTypeBoBox.ItemIndex := Str_ToInt(ListItem.SubItems.Strings[0], 0);
    Memo1.Text := ListItem.SubItems.Strings[5];
    ButtonChgShopItem.Enabled := True;
    ButtonDelShopItem.Enabled := True;
  except
    ButtonChgShopItem.Enabled := False;
    ButtonDelShopItem.Enabled := False;
  end;
end;

procedure TFrmShopItem.ButtonChgShopItemClick(Sender: TObject);
var
  nItemIndex: Integer;
  ListItem: TListItem;
begin
  try
    nItemIndex := ListViewItemList.ItemIndex;
    ListItem := ListViewItemList.Items.Item[nItemIndex];
    ListItem.SubItems.Strings[0] := IntToStr(ShopTypeBoBox.ItemIndex);
    ListItem.SubItems.Strings[1] := IntToStr(SpinEditPrice.Value);
    ListItem.SubItems.Strings[2] := Trim(EditShopImgBegin.Text);  //���� 2007.11.15
    ListItem.SubItems.Strings[3] := Trim(EditShopImgEnd.Text);  //���� 2007.11.15
    ListItem.SubItems.Strings[4] := Trim(EditShopItemIntroduce.Text);  //���� 2007.11.15
    ListItem.SubItems.Strings[5] := Trim(Memo1.Text);
    ButtonSaveShopItemList.Enabled:= True;//20080320
  except
  end;
end;

procedure TFrmShopItem.ButtonDelShopItemClick(Sender: TObject);
begin
  ListViewItemList.Items.BeginUpdate;
  try
    ListViewItemList.DeleteSelected;
    ButtonSaveShopItemList.Enabled:= True;//20080320
  finally
    ListViewItemList.Items.EndUpdate;
  end;
end;

procedure TFrmShopItem.ButtonAddShopItemClick(Sender: TObject);
var
  ListItem: TListItem;
  //���� 2007.11.15
  sIdx: string;
  sImgBegin: string;
  sImgend: string;
  sIntroduce: string;
  ///////////////////
  sItemName: string;
  sPrice: string;
  sMemo: string;
begin
 Try
  sIdx := IntToStr(ShopTypeBoBox.ItemIndex);
  sItemName := Trim(EditShopItemName.Text);
  sPrice := IntToStr(SpinEditPrice.Value);
  //���� 2007.11.15
  sImgBegin := Trim(EditShopImgBegin.Text);
  sImgEnd := Trim(EditShopImgEnd.Text);
  sIntroduce := Trim(EditShopItemIntroduce.Text);
  sMemo := Trim(Memo1.Text);
  if sItemName = '' then begin
    Application.MessageBox('��ѡ����Ҫ��ӵ���Ʒ������', '��ʾ��Ϣ', MB_ICONQUESTION);
    Exit;
  end;
  if sMemo = '' then begin
    Application.MessageBox('��������Ʒ����������', '��ʾ��Ϣ', MB_ICONQUESTION);
    Exit;
  end;
  if InListViewItemList(sItemName) then begin
    Application.MessageBox('��Ҫ��ӵ���Ʒ�Ѿ����ڣ���ѡ��������Ʒ������', '��ʾ��Ϣ', MB_ICONQUESTION);
    Exit;
  end;
  ListViewItemList.Items.BeginUpdate;
  try
    ListItem := ListViewItemList.Items.Add;
    ListItem.SubItems.Add(sIdx);//���� 2007.11.15
    ListItem.Caption := sItemName;
    ListItem.SubItems.Add(sPrice);
    ListItem.SubItems.Add(sImgBegin); //���� 2007.11.15
    ListItem.SubItems.Add(sImgEnd); //���� 2007.11.15
    ListItem.SubItems.Add(sIntroduce); //���� 2007.11.15
    ListItem.SubItems.Add(sMemo);
    ButtonSaveShopItemList.Enabled:= True;//20080320
  finally
    ListViewItemList.Items.EndUpdate;
  end;
  except
    MainOutMessage('[�쳣] PlugOfShop.ButtonAddShopItemClick');
  end;
end;

procedure TFrmShopItem.ListBoxItemListClick(Sender: TObject);
var
  nItemIndex: Integer;
begin
  try
    nItemIndex := ListBoxItemList.ItemIndex;
    EditShopItemName.Text := ListBoxItemList.Items.Strings[nItemIndex];
    ButtonAddShopItem.Enabled := True;
  except
    ButtonAddShopItem.Enabled := False;
  end;
end;

procedure TFrmShopItem.ButtonSaveShopItemListClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: Classes.TStringList;

  sIdx      : string;
  sImgBegin : string;
  sImgEnd   : string;
  sIntroduce: string;

  sLineText : string;
  sFileName : string;
  sItemName : string;
  sPrice    : string;
  sMemo     : string;
  MyIni     : TIniFile;   //����һ�  20080302
begin
Try
  //ButtonSaveShopItemList.Enabled := False;
  sFileName := '.\BuyItemList.txt';
  SaveList := Classes.TStringList.Create();
  SaveList.Add(';���������������ļ�');
  SaveList.Add(';��Ʒ����'#9'��Ʒ����'#9'���ۼ۸�'#9'ͼƬ��ʼ'#9'ͼƬ����'#9'�򵥽���'#9'��Ʒ����');
  ListViewItemList.Items.BeginUpdate;
  try
    for I := 0 to ListViewItemList.Items.Count - 1 do begin
      ListItem := ListViewItemList.Items.Item[I];

      sIdx := ListItem.SubItems.Strings[0];

      sItemName := ListItem.Caption;
      sPrice := ListItem.SubItems.Strings[1];

      sImgBegin := ListItem.SubItems.Strings[2]; //���� 2007.11.15
      sImgEnd := ListItem.SubItems.Strings[3]; //���� 2007.11.15
      sIntroduce := ListItem.SubItems.Strings[4]; //���� 2007.11.15

      sMemo := ListItem.SubItems.Strings[5];

      sLineText := sIdx + #9 + sItemName + #9 + sPrice + #9 + sImgBegin + #9 + sImgEnd + #9 + sIntroduce + #9 + sMemo;
      SaveList.Add(sLineText);
    end;
  finally
    ListViewItemList.Items.EndUpdate;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Application.MessageBox('������ɣ�����', '��ʾ��Ϣ', MB_ICONQUESTION);
  ButtonSaveShopItemList.Enabled := False;
{******************************************************************************}
//����Ϊ����һ�������� 20080302
  MyIni := TIniFile.Create('.\!SetUp.txt');
  MyIni.WriteBool('Shop','ShopBuyGameGird',g_boGameGird);
  MyIni.WriteInteger('Shop','GameGold',g_nGameGold);
  MyIni.Free;
{******************************************************************************}
  except
    MainOutMessage('[�쳣] PlugOfShop.ButtonSaveShopItemListClick');
  end;
end;

procedure TFrmShopItem.ButtonLoadShopItemListClick(Sender: TObject);
var
  MyIni     : TIniFile;   //����һ�  20080302
begin
Try
  ButtonLoadShopItemList.Enabled := False;
{******************************************************************************}
//����Ϊ����һ�������� 20080302
  MyIni := TIniFile.Create('.\!SetUp.txt');
  g_boGameGird := MyIni.ReadBool('Shop','ShopBuyGameGird',g_boGameGird);
  g_nGameGold := MyIni.ReadInteger('Shop','GameGold',g_nGameGold);
  MyIni.Free;
{******************************************************************************}
  LoadShopItemList();
  RefLoadShopItemList();
  Application.MessageBox('���¼������б���ɣ�����', '��ʾ��Ϣ', MB_ICONQUESTION);
  ButtonLoadShopItemList.Enabled := True;
  except
    MainOutMessage('[�쳣] PlugOfShop.ButtonLoadShopItemListClick');
  end;
end;

procedure TFrmShopItem.RzTabControl1Change(Sender: TObject);
begin
RefLoadShopItemList;
end;

procedure TFrmShopItem.CheckBoxBuyGameGirdClick(Sender: TObject);
begin
  g_boGameGird := CheckBoxBuyGameGird.Checked;
  ButtonSaveShopItemList.Enabled := True;
end;

procedure TFrmShopItem.SpinEditGameGirdChange(Sender: TObject);
begin
  g_nGameGold := SpinEditGameGird.Value;
  ButtonSaveShopItemList.Enabled := True;
end;

procedure TFrmShopItem.FormCreate(Sender: TObject);
begin
     CheckBoxBuyGameGird.Checked := g_boGameGird;
       SpinEditGameGird.Value := g_nGameGold;
end;

procedure TFrmShopItem.ListBoxItemListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = Word('F') then begin
   if ssCtrl in Shift then begin
      FindListBox();
   end;
  end;
end;

procedure TFrmShopItem.FindListBox;
var
  s: string;
  I: Integer;
begin
  Try
  s := inputBox('������Ʒ','������Ҫ���ҵ���Ʒ����:','');
  for I:=0 to ListBoxItemList.Count - 1 do begin
    if CompareText(ListBoxItemList.Items.Strings[I],s) = 0 then begin
       ListBoxItemList.ItemIndex:=I;
       Exit;
    end;
  end;
  except
    MainOutMessage('[�쳣] PlugOfShop.FindListBox');
  end;
end;

end.

