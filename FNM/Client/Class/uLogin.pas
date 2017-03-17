{*******************************************************}
{                                                       }
{       ������� W.MIS CLIENT MODEL                     }
{       ��Ȩ���� (C) 2003, 2004 Esquel.IT               }
{       ��Ԫ���� ULogin.pas                             }
{       �������� 2004-8-3 11:02:58                      }
{       ������Ա wuwj                                   }
{                                                       }
{*******************************************************}

unit ULogin;
{* �û���¼�൥Ԫ }

interface

uses
  Classes, Types, Windows, Dialogs, SysUtils, WMISUserRightPJT_TLB, ComObj, DBClient;

type

  WTS_INFO_CLASS = (
    WTSInitialProgram,
    WTSApplicationName,
    WTSWorkingDirectory,
    WTSOEMId,
    WTSSessionId,
    WTSUserName,
    WTSWinStationName,
    WTSDomainName,
    WTSConnectState,
    WTSClientBuildNumber,
    WTSClientName,
    WTSClientDirectory,
    WTSClientProductId,
    WTSClientHardwareId,
    WTSClientAddress,
    WTSClientDisplay,
    WTSClientProtocolType);
    {*
        ��Ԫ���ƣ� ULogin.pas
        �� �� �ƣ� WTS_INFO_CLASS
        ���������� wuwj
        ����ʱ�䣺 2004-8-3 11:42:50
        ��ϸ������ ��ȡ�ն˻�����Ϣ�ṹ��
     }

  TQuerySession = function(hServer: HWND;
    SessionId: DWORD;
    WTSInfoClass: WTS_INFO_CLASS;
    var ppBuffer: PChar;
    var pBytesReturned: DWORD): BOOL; stdcall;
    {*
        ��Ԫ���ƣ� ULogin.pas
        �� �� �ƣ� TQuerySession
        ���������� wuwj
        ����ʱ�䣺 2004-8-3 11:52:25
        ��ϸ������ ��ѯ�Ự��
     }

  TLogin=class
  {*
        ��Ԫ���ƣ� ULogin.pas
        �� �� �ƣ� TLogin
        ���������� wuwj
        ����ʱ�䣺 2004-8-3 11:53:04
        ��ϸ������ �û���¼�����ࣻ
   }
  private
    { private fields }

    FSystemID: integer;
    FSystemFullName: string;
    FUpdatePath: string ;
    FComPlusServer: string;
    FWorkStation: string;
    FLoginID: string;
    FLoginName: string;
    FMailBox:string;
    FLoginTime: TDatetime;

    FSetPermissionWhenLogin: Boolean;
    FDepartmentList: string;
    FDefaultDepartment: string;
    FCurrentDepartment: string;
    FSysMenus: TClientDataSet;
    FUserDepartments: TClientDataSet;
    FUserLevelList: String;
    { private procedures}
   

    procedure SetComPlusServer(value :string);
     {*
     ������:    SetComPlusServer
     ����:      value :string
     ����ֵ:    ��
     ������     ����COM+���������ƣ�
     }

    procedure SetLoginID(value :string);
    {*
     ������:    SetLoginID
     ����:      value :string
     ����ֵ:    ��
     ������     ���õ�¼ϵͳ���û�ID��
     }

    procedure SetLoginName(value:string);
    {*
     ������:    SetLoginName
     ����:      value:string
     ����ֵ:    ��
     ������     ���õ�¼ϵͳ���û����ƣ�
     }

    procedure SetLoginTime(value:TDateTime);
    {*
     ������:    SetLoginTime
     ����:      value:TDateTime
     ����ֵ:    ��
     ������     ���õ�¼ϵͳ��ʱ�䣻
     }


  

    procedure SetSystemID(value:integer);
    {*
     ������:    SetSystemID
     ����:      value:integer
     ����ֵ:    ��
     ������     ����Ҫ��¼��ϵͳ�ı�ţ�
     }


    procedure GetWorkStation;
    {*
     ������:    GetWorkStation
     ����:      ��
     ����ֵ:    ��
     ������     ��ȡ�����Ĺ���վ���ƣ�
    }

    procedure SetSetPermissionWhenLogin(Value: Boolean);
    procedure SetSystemFullName(const Value: string);
    procedure SetUpdatePath(const Value: string);

    function GetComConnection(const ClassID: TGUID): IDispatch;
    function GetUserRightLib: IWMISUserRightDisp;
    function GetSessionName: string;
    procedure SetMailBox(const Value: string);
    procedure SetCurrentDepartment(const Value: string);
    procedure GetSysMenus(AUserID:string;ASysID:Integer);
    procedure GetUserDepartments(AUserID:string;ASysID:Integer);
  public
    { properties }
    property ComPlusServer:string read fComPlusServer write SetComPlusServer;
    property WorkStation:string read fWorkStation;
    property LoginID:string read fLoginID write SetLoginID;
    property LoginName:string read FLoginName write SetLoginName;
    property LoginTime:TDateTime read fLoginTime write SetLoginTime;
    property MailBox:string read fMailBox write SetMailBox;
    property SystemID:integer read fSystemID write SetSystemID;
    property SetPermissionWhenLogin: Boolean read FSetPermissionWhenLogin write SetSetPermissionWhenLogin;
    property SystemFullName: string read FSystemFullName write SetSystemFullName;
    property UpdatePath: string read FUpdatePath write SetUpdatePath;
    property DepartmentList: string read FDepartmentList;
    property DefaultDepartment: string read FDefaultDepartment;
    property CurrentDepartment: string read FCurrentDepartment write
        SetCurrentDepartment;
    property SysMenus: TClientDataSet read FSysMenus;
    property UserDepartments: TClientDataSet read FUserDepartments;
    property UserLevelList: String read FUserLevelList;
    procedure GetSystemInfo;
    procedure Logoff;
    constructor Create;
    function  GetPermission():widestring;//��ϵͳ������ݿ��ȡ��ǰ��¼�û���Ȩ��ʹ�õĲ˵����б�
    function  GetSystemName:string;
    function  OS():string;
    procedure Initialize;
    destructor Destroy; override;
end;

const
  SYSTEMNAME='FNM';

function Login:TLogin;

implementation

uses
  uShowMessage, Forms;

var
  FLogin:TLogin;

constructor TLogin.Create;
begin
  LoginTime:=now;
  FSysMenus:=TClientDataSet.Create(nil);
  FUserDepartments:=TClientDataSet.Create(nil);
end;

function TLogin.GetPermission():widestring;
var
  vMenuList: widestring;
  vLoginId:widestring;
  vLoginName:widestring;
  vUserLevelList: WideString;
  vMsg:widestring;
  sDepartmentList:widestring;
  sDefaultDepartment:WideString;
begin
  try
    //2008.2.22ȡϵͳƽ̨�������Ĳ���
    if Length(PChar(ParamStr(2)))>0 then
      vLoginID:=Copy(PChar(ParamStr(2)),2,Length(PChar(ParamStr(2)))-1);

    GetUserRightLib.Login(SystemID,WorkStation , vLoginID, vLoginName,vMenuList,vMsg);
    if vMsg <> 'OK' then
    begin
      TMsgDialog.ShowMsgDialog(vMsg, mtError);
      Application.Terminate;
      Exit;
    end;

    vMsg:='';
    GetUserRightLib.GetUserDepartmentList(vLoginID,sDepartmentList,vMsg);
    if vMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(vMsg, mtError);
      Application.Terminate;
      Exit;
    end;
    FDepartmentList:=sDepartmentList;

    vMsg:='';
    GetUserRightLib.GetDefaultDepartment(vLoginID,sDefaultDepartment,vMsg);
    if vMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(vMsg, mtError);
      Application.Terminate;
      Exit;
    end;

  //  GetUserRightLib.GetUserLevel(SystemID,WorkStation,vUserLevelList);
     GetUserRightLib.GetUserLevelByUserid(SystemID,vLoginID,vUserLevelList);
    if vMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(vMsg, mtError);
      Exit;
    end;
    FUserLevelList := vUserLevelList;
    FDefaultDepartment:=sDefaultDepartment;
    LoginID:=vLoginID;
    LoginName:=vLoginName;

    GetSysMenus(LoginID,SystemID);
    GetUserDepartments(LoginID,SystemID);
  finally
    result:=vmenuList;
  end;
end;

procedure TLogin.GetWorkStation;
var
  Computer: PChar;
  Size: DWORD;
  vComputer_Name,session: WideString;
  vTerminal: WordBool;
begin
  Size := 255;
  GetMem(Computer, 255);
  GetComputerName(Computer, Size);
  vComputer_Name := UpperCase(Trim(Computer));
  FreeMem(Computer);

  session:=GetSessionName;
  if copy(session,1,3)='RDP' then
     FWorkStation := vComputer_Name + session
  else
    FWorkStation:=vComputer_Name;

 { try
    GetUserRightLib.IsTerminal(vComputer_Name, vTerminal);
    if vTerminal then
      FWorkStation := vComputer_Name + GetSessionName
    else
      FWorkStation := vComputer_Name;
  except
    FWorkStation := vComputer_Name;
  end;
  }
  FWorkStation := UpperCase(FWorkStation);
end;

procedure TLogin.SetComPlusServer(value: string);
begin
  FComPlusServer:=value;
end;

procedure TLogin.SetLoginID(value: string);
begin
  FLoginID:=value;
end;


procedure TLogin.SetLoginName(value: string);
begin
  FLoginName:=value;
end;

procedure TLogin.SetLoginTime(value: TDateTime);
begin
  FLoginTime:=value;
end;

procedure TLogin.SetSystemID(value: integer);
begin
  FSystemID:=value;
end;

procedure TLogin.SetSetPermissionWhenLogin(Value: Boolean);
begin
  self.FSetPermissionWhenLogin:=value;
end;

procedure TLogin.SetSystemFullName(const Value: string);
begin
  FSystemFullName:=value;
end;

procedure TLogin.SetUpdatePath(const Value: string);
begin
  FUpdatePath:=value;
end;

procedure TLogin.GetSystemInfo;
var sysid: integer;
    sysfullname,utpath,mail:widestring;
begin

  GetUserRightLib.GetSystemInfo(SYSTEMNAME,sysid,sysfullname,utpath,mail);
  self.SystemID :=sysid;
  self.SystemFullName :=sysfullname;
  self.UpdatePath :=utpath;
  self.MailBox := mail;
end;

procedure TLogin.Logoff;
begin
  GetUserRightLib.Logoff(SystemID ,LoginID,self.WorkStation)
end;

function TLogin.GetSystemName: string;
begin
  result:=SYSTEMNAME;
end;


function TLogin.OS: string;
begin
  case Win32Platform of
    VER_PLATFORM_WIN32_WINDOWS:
      begin
        result:='95/98';
      end;
    VER_PLATFORM_WIN32_NT:
      begin
        result:='NT';
      end;
    else
      begin
        result:='Windows';
      end;
  end;
end;

function Login:TLogin;
begin
  if FLogin=nil then
     FLogin:=TLogin.Create;
  Result:=FLogin;
end;

function TLogin.GetComConnection(const ClassID: TGUID): IDispatch;
begin
  Result := CreateRemoteComObject(ComPlusServer, ClassID) as IDispatch;
end;

function TLogin.GetSessionName: string;
var
  hdll: HWND;
  P: Pointer;
  GetSessionInfo: TQuerySession;
  SessionName: PChar;
  f: DWORD;
begin
  Result := '';
  SessionName := '';
  hdll := LoadLibrary('wtsapi32.dll');
  if hdll <= 0 then
    Exit;
  try
    P := GetProcAddress(hdll, 'WTSQuerySessionInformationA');
    if P = nil then
      Exit;
    GetSessionInfo := TQuerySession(P);
    try
      GetSessionInfo(HWND(0), DWORD(-1), WTSWinStationName, SessionName, f);
    except
      Exit;
    end;
    Result := SessionName;
  finally
    FreeLibrary(hdll);
  end;
end;

function TLogin.GetUserRightLib: IWMISUserRightDisp;
begin
  Result := IWMISUserRightDisp(GetComConnection(CLASS_WMISUserRight));
end;

procedure TLogin.Initialize;
begin
  GetWorkStation;
  GetSystemInfo;
end;

procedure TLogin.SetMailBox(const Value: string);
begin
  fMailBox := Value;
end;

procedure TLogin.SetCurrentDepartment(const Value: string);
begin
  if FCurrentDepartment <> Value then
  begin
    FCurrentDepartment := Value;
  end;
end;

destructor TLogin.Destroy;
begin
  FSysMenus.Free;
  FUserDepartments.Free;
  inherited;
end;

procedure TLogin.GetSysMenus(AUserID:string;ASysID:Integer);
var
  sErrMsg:WideString;
  vData:OleVariant;
begin
  GetUserRightLib.GetMenuInfo(AUserID,ASysID,vData,sErrMsg);
  if sErrMsg<>'' then
    begin
      Showmessage(sErrMsg);
      Exit;
    end;
  FSysMenus.Data:=vData;
end;

procedure TLogin.GetUserDepartments(AUserID:string;ASysID:Integer);
var
  sErrMsg:WideString;
  vData:OleVariant;
begin
  GetUserRightLib.GetUserDepartments(AUserID,ASysID,vData,sErrMsg);
  if sErrMsg<>'' then
    begin
      Showmessage(sErrMsg);
      Exit;
    end;
  FUserDepartments.Data:=vData;
end;

end.
