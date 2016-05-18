unit LogSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, StdCtrls, ComCtrls, Buttons, DB,
  ADODB, DBGrids;

type
  TLogFrm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label3: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Button1: TButton;
    ListView1: TListView;
    ADOConn: TADOConnection;
    ADOA: TADOQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
   //��ѯ���ݱ�
   procedure SelectTable(Str:string);
   //������־�ļ� 20080131
   Function SelectDirFile(Dir,SqlStr,Sqlstr1: String;Dt1,Dt2:Tdate):Boolean;
    { Private declarations }
  public
    StrString: String;
    { Public declarations }
  end;

type
  TLogFile = record //��־�ļ���
    sFileName: string;//ȥ��׺���ļ���
    sDir: string;//�ļ�ȫ·��
  end;
  pTLogFile = ^TLogFile;

  TQueryThread = class(TThread)//��ѯ�߳�
  private
  protected
    procedure Execute;override;
  public
    SQLText:String;
    constructor Create;
    destructor  Destroy;override;
  end;

var
  LogFrm: TLogFrm;
  List:TList;
  ColumnToSort: Integer;
  QueryThread: TQueryThread;

implementation

uses LogDataMain,DM ,LDShare;

{$R *.dfm}
constructor TQueryThread.Create;
begin
  SQLText:= '';
  FreeOnTerminate:= True;
  inherited  Create(True);
end;

destructor TQueryThread.Destroy;
begin
  inherited;
end;

procedure TQueryThread.Execute;
begin
  try
    LogFrm.SelectTable(SQLText);
  except
  end;
end;


procedure TLogFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=CaFree;
end;

//������־�ļ� 20080131
Function TLogFrm.SelectDirFile(Dir,SqlStr,Sqlstr1: String;Dt1,Dt2:Tdate):Boolean;
var
  sr: TSearchRec;
  I:integer;
  StrString:string;
  LogFile:pTLogFile;

  TempItem:TListItem;
  FileName,Str1: String;
begin
  Result:=False;
  ListView1.Clear;
  if List.Count > 0 then begin
    for I:=0 to List.Count - 1 do begin
      if pTLogFile(List.Items[I]) <> nil then Dispose(pTLogFile(List.Items[I]));
    end;
    List.Clear;
  end;
try
  if FindFirst(dir+'*.mdb', faAnyFile, sr) = 0 then begin
    repeat
      if (sr.Attr and faDirectory)=0 then begin
        if pos('.mdb',lowercase(sr.Name)) > 0 then begin
          FileName:=ExtractFileName(ChangeFileExt(sr.Name,''));
          if (int(StrToDate(FileName)) >= int(Dt1)) and (int(StrToDate(FileName)) <= int(Dt2)) then begin
            New(LogFile);
            LogFile.sFileName :=FileName;
            LogFile.sDir:= dir+sr.Name;
            List.Add(LogFile);//��Ŀ¼�µ�ȫ���ļ���
          end;
        end;
      end;
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;

  for I:=0 to List.Count-1 do begin
   LogFile:= pTLogFile(List.Items[I]);
   if LogFile <> nil then begin
      ADOConn.connected:=False;
      ADOConn.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+LogFile.sDir+';Persist Security Info=False';
      ADOConn.connected:=true;

      Str1:=Trim(Combobox1.text);
      if ComboBox1.text='���м�¼' then begin
        if SqlStr <> '' then
         StrString:='select ���,����,��ͼ,X����,Y����,��������,��Ʒ����,��ƷID,��¼,���׶���,'+
                    'ʱ�� from Log where '+SqlStr+' order by ʱ�� DESC'
        else StrString:='select ���,����,��ͼ,X����,Y����,��������,��Ʒ����,��ƷID,��¼,���׶���,ʱ�� from Log order by ʱ�� DESC'
      end else begin
      if SqlStr <> '' then
        {StrString:='select ���,����,��ͼ,X����,Y����,��������,��Ʒ����,��ƷID,��¼,���׶���,'+
                   'ʱ�� from Log where '+Str1+' like '+''''+'%%'+Sqlstr1+'%%'+''''+' and '+SqlStr+' order by ʱ��' }
         StrString:='select ���,����,��ͼ,X����,Y����,��������,��Ʒ����,��ƷID,��¼,���׶���,'+
                   'ʱ�� from Log where InStr(1,LCase('+Str1+'),LCase('+''''+Sqlstr1+''''+'),0)<>0 and '+SqlStr+' order by ʱ�� DESC'
        else
        {StrString:='select ���,����,��ͼ,X����,Y����,��������,��Ʒ����,��ƷID,��¼,���׶���,'+
                   'ʱ�� from Log where '+Str1+' like '+''''+'%'+Sqlstr1+'%'+''''+' order by ʱ��'; }
        {StrString:='select ���,����,��ͼ,X����,Y����,��������,��Ʒ����,��ƷID,��¼,���׶���,'+
                   'ʱ�� from Log where '+Str1+' ='+''''+Sqlstr1+''''+' order by ʱ��'; }
        StrString:='select ���,����,��ͼ,X����,Y����,��������,��Ʒ����,��ƷID,��¼,���׶���,'+
                   'ʱ�� from Log where InStr(1,LCase('+Str1+'),LCase('+''''+Sqlstr1+''''+'),0)<>0 order by ʱ�� DESC';

      end;
       ADOA.close;
       ADOA.sql.Clear;
       ADOA.sql.Add(StrString);
       ADOA.Open;
       if ADOA.RecordCount > 0 then begin
          ADOA.First;
          while not ADOA.Eof do begin
            TempItem:=ListView1.Items.Add;
            with TempItem do begin
              Caption:=ADOA.fieldbyName('���').AsString;
              SubItems.Add(ADOA.fieldbyName('����').AsString);
              SubItems.Add(ADOA.fieldbyName('��ͼ').AsString);
              SubItems.Add( ADOA.fieldbyName('X����').AsString);
              SubItems.Add( ADOA.fieldbyName('Y����').AsString);
              SubItems.Add( ADOA.fieldbyName('��������').AsString);
              SubItems.Add( ADOA.fieldbyName('��Ʒ����').AsString);
              SubItems.Add( ADOA.fieldbyName('��ƷID').AsString);
              SubItems.Add( ADOA.fieldbyName('��¼').AsString);
              SubItems.Add( ADOA.fieldbyName('���׶���').AsString);
              SubItems.Add(ADOA.fieldbyName('ʱ��').AsString );
            end;
            ADOA.Next;
          end;
        end;
        Result:=True;
    end;
  end; //for I:=0 to List.Count-1 do
  except
    Result:=True;
  end; 
end;

//��ѯ���ݱ�
procedure TLogFrm.SelectTable(Str:string);
var Str2:string;
begin
//���ö�������
case ComboBox2.ItemIndex of
   0:Str2:='';//ȫ������
   1:Str2:=' ����='+''''+'ȡ����Ʒ'+'''';//ȡ����Ʒ
   2:Str2:=' ����='+''''+'�����Ʒ'+'''';//�����Ʒ
   3:Str2:=' ����='+''''+'����ҩƷ'+'''';//����ҩƷ
   4:Str2:=' ����='+''''+'�־���ʧ'+'''';//�־���ʧ
   5:Str2:=' ����='+''''+'������Ʒ'+'''';//������Ʒ
   6:Str2:=' ����='+''''+'������Ʒ'+'''';//������Ʒ
   7:Str2:=' ����='+''''+'�ٵ���Ʒ'+'''';//�ٵ���Ʒ
   8:Str2:=' ����='+''''+'�ӵ���Ʒ'+'''';//�ӵ���Ʒ
   9:Str2:=' ����='+''''+'������Ʒ'+'''';//������Ʒ
   10:Str2:=' ����='+''''+'������Ʒ'+''''; //������Ʒ
   11:Str2:=' ����='+''''+'������Ʒ'+'''';//������Ʒ
   12:Str2:=' ����='+''''+'ʹ����Ʒ'+'''';//ʹ����Ʒ
   13:Str2:=' ����='+''''+'��������'+'''';//��������
   14:Str2:=' ����='+''''+'���ٽ��'+'''';//���ٽ��
   15:Str2:=' ����='+''''+'���ӽ��'+'''';//���ӽ��
   16:Str2:=' ����='+''''+'��������'+'''';//��������
   17:Str2:=' ����='+''''+'������Ʒ'+'''';//������Ʒ
   18:Str2:=' ����='+''''+'�ȼ�����'+'''';//�ȼ�����
   19:Str2:=' ����='+''''+'��������'+'''';//��������
   20:Str2:=' ����='+''''+'�����ɹ�'+'''';//�����ɹ�
   21:Str2:=' ����='+''''+'����ʧ��'+'''';//����ʧ��
   22:Str2:=' ����='+''''+'�Ǳ�ȡǮ'+'''';//�Ǳ�ȡǮ
   23:Str2:=' ����='+''''+'�Ǳ���Ǯ'+'''';//�Ǳ���Ǯ
   24:Str2:=' ����='+''''+'����ȡ��'+'''';//����ȡ��
   25:Str2:=' ����='+''''+'��������'+'''';//��������
   26:Str2:=' ����='+''''+'��������'+'''';//��������
   27:Str2:=' ����='+''''+'�ı����'+'''';//�ı����
   28:Str2:=' ����='+''''+'Ԫ���ı�'+'''';//Ԫ���ı�
   29:Str2:=' ����='+''''+'�����ı�'+'''';//�����ı�
   30:Str2:=' ����='+''''+'���̹���'+'''';//���̹���
   31:Str2:=' ����='+''''+'װ������'+'''';//װ������
   32:Str2:=' ����='+''''+'������Ʒ'+'''';//������Ʒ
   33:Str2:=' ����='+''''+'���۹���'+'''';//���۹���
   34:Str2:=' ����='+''''+'�����̵�'+'''';//�����̵�
   35:Str2:=' ����='+''''+'�л��Ȫ'+'''';//�л��Ȫ
   36:Str2:=' ����='+''''+'��ս��Ʒ'+'''';//��ս��Ʒ
   37:Str2:=' ����='+''''+'�����ι�'+'''';//�����ι�
   38:Str2:=' ����='+''''+'NPC ���'+'''';
   39:Str2:=' ����='+''''+'�ɳ��ı�'+'''';
   40:Str2:=' ����='+''''+'��ÿ�ʯ'+'''';
   41:Str2:=' ����='+''''+'��������'+'''';
   42:Str2:=' ����='+''''+'������Ʒ'+'''';
end;
  //�����ļ�,��������д����ʱ�� 20080131
  if SelectDirFile(sBaseDir,Str2,Str,DateTimePicker1.Date,DateTimePicker2.Date) then begin
     Button1.Enabled:=True;
  end;
end;

procedure TLogFrm.FormShow(Sender: TObject);
begin
  ComboBox1.ItemIndex:=0;
  ComboBox2.ItemIndex:=0;
  DateTimePicker1.Date:=Date();
  DateTimePicker2.Date:=Date();
end;

procedure TLogFrm.ComboBox1Click(Sender: TObject);
begin
if ComboBox1.text='���м�¼' then begin
  Edit1.Text:='*';
  Edit1.ReadOnly:=True;
  Edit1.Font.Color:=cl3DLight;
 end else
 begin
  Edit1.Text:='';
  Edit1.ReadOnly:=False;
  Edit1.Font.Color:=clWindowText;
 end;
end;

procedure TLogFrm.Button1Click(Sender: TObject);
begin
  Button1.Enabled:=False;
  if Trim(Edit1.text)='' then
  begin
    Application.MessageBox('ע��:�������ѯ���ݣ�','��ʾ��Ϣ',MB_ICONQUESTION+MB_OK);
    Button1.Enabled:=True;
    exit;
  end;
  //SelectTable(Trim(Edit1.text));//20080928 ע��,ʹ���߳�����ѯ����
  Try
    QueryThread:= TQueryThread.Create;
    QueryThread.SQLText:= Trim(Edit1.text);
    QueryThread.Resume;
  except
    Button1.Enabled:=True;
  end;
end;

procedure TLogFrm.FormCreate(Sender: TObject);
begin
  List:=TList.Create;
end;

procedure TLogFrm.ListView1Compare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  ix: Integer;
begin
  if ColumnToSort = 0 then
    Compare := CompareText(Item1.Caption,Item2.Caption)
  else begin
   ix := ColumnToSort - 1;
   Compare := CompareText(Item1.SubItems[ix],Item2.SubItems[ix]);
  end;
end;

procedure TLogFrm.ListView1ColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  if not Button1.Enabled then Exit;
   ColumnToSort := Column.Index;
  (Sender as TCustomListView).AlphaSort;
end;

procedure TLogFrm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var I: Integer;
begin
  for I:=0 to List.Count - 1 do begin
    if pTLogFile(List.Items[I]) <> nil then Dispose(pTLogFile(List.Items[I]));
  end;
  List.Free;
  LogFrm:= nil;
end;


procedure TLogFrm.FormDestroy(Sender: TObject);
begin
  LogFrm:= nil;
end;

end.
