unit uWMISUserRight;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComServ, ComObj, VCLCom, StdVcl, bdemts, DataBkr, DBClient,
  MtsRdm, Mtx, WMISUserRightPJT_TLB, DB, ADODB,Provider,XMLIntf, XMLDoc,StrUtils;

type
  TWMISUserRight = class(TMtsDataModule, IWMISUserRight)
    adoqryPublic: TADOQuery;
    adoConnection: TADOConnection;
    procedure MtsDataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function GetLibraryFullPath(sLibraryName: string): string;
    function GetConnectionString(sLibraryName: string;sSystemId: string): string;

  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    procedure GetDefaultDepartment(const sUserID: WideString;
      var sDefaultDepartment, sErrMsg: WideString); safecall;
    procedure GetMenuInfo(const sUserID: WideString; iSysID: Integer;
      var vData: OleVariant; var sErrMs: WideString); safecall;
    procedure GetSystemInfo(const SysName: WideString; var SysId: Integer;
      var SysFullName, UpdatePath, Mail: WideString); safecall;
    procedure GetUserDepartmentList(const sUserID: WideString;
      var sDepartmentList, sErrMsg: WideString); safecall;
    procedure GetUserDepartments(const sUserID: WideString; iSysID: Integer;
      var vData: OleVariant; var sErrMsg: WideString); safecall;
    procedure GetUserLevel(vSystem_ID: Integer;
      const vComputer_Name: WideString; var vLevelList: WideString);
      safecall;
    procedure IsTerminal(const vComputer_Name: WideString;
      var vTerminal: WordBool); safecall;
    procedure Login(vSystem_ID: Integer; const vComputer_Name: WideString;
      var vUser_ID, vUser_Name, vMenuList, vMsg: WideString); safecall;
    procedure Logoff(vSystem_ID: Integer; const vUser_ID,
      vComputer_Name: WideString); safecall;
    procedure GetUserLevelByUserid(vSysID: Integer; const vUserID: WideString;
      var vLevelList: WideString); safecall;
  public
    { Public declarations }
  end;

var
  WMISUserRight: TWMISUserRight;

implementation

{$R *.DFM}

class procedure TWMISUserRight.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
begin
  if Register then
  begin
    inherited UpdateRegistry(Register, ClassID, ProgID);
    EnableSocketTransport(ClassID);
    EnableWebTransport(ClassID);
  end
  else
  begin
    DisableSocketTransport(ClassID);
    DisableWebTransport(ClassID);
    inherited UpdateRegistry(Register, ClassID, ProgID);
  end;
end;

procedure TWMISUserRight.IsTerminal(const vComputer_Name: WideString;
  var vTerminal: WordBool);
begin
  vTerminal := False;
  try
    adoConnection.Open;
    adoqryPublic.SQL.Text := 'SELECT ServerName '#13#10 +
      'FROM systempanel.dbo.TermServerName '#13#10 +
      'WHERE ServerName = ''' + vComputer_Name + ''' ';
    adoqryPublic.Open;
    if adoqryPublic.RecordCount > 0 then
      vTerminal := True;
  finally
    SetComplete;
    adoqryPublic.Close;
    adoConnection.Close;
  end;
end;

procedure TWMISUserRight.Login(vSystem_ID: Integer;
  const vComputer_Name: WideString; var vUser_ID, vUser_Name, vMenuList,
  vMsg: WideString);
begin
  vMsg := '错误！';
  try
    try
      adoConnection.Open;
      with adoqryPublic do
      begin
        SQL.Text := 'EXEC systempanel.dbo.up_GetUsername ''' +
          vComputer_Name + ''', ' + IntToStr(vSystem_ID)+','+Quotedstr(vUser_ID);
        Open;
        if RecordCount = 0 then
        begin
          vMsg := '对不起，你不能使用该系统！';
          Exit;
        end;
        vUser_ID := FieldByName('userid').AsString;
        vUser_Name := FieldByName('username').AsString;
        Close;
        SQL.Text := 'EXEC systempanel.dbo.up_GetRight ''' +
          vComputer_Name + ''', ' + IntToStr(vSystem_ID)+','+Quotedstr(vUser_ID);
        Open;
        if RecordCount = 0 then
        begin
          vMsg := '对不起，你没有权限使用本系统！';
          Exit;
        end;
        while not Eof do
        begin
          vMenuList := vMenuList + FieldByName('MenuId').AsString + #13#10;
          Next;
        end;
        vMsg := 'OK';
      end;
    except
      on E: Exception do
      begin
        vMsg := E.Message;
      end;
    end;
  finally
    SetComplete;
    adoqryPublic.Close;
    adoConnection.Close;
  end;
end;

procedure TWMISUserRight.Logoff(vSystem_ID: Integer; const vUser_ID,
  vComputer_Name: WideString);
begin
  try
    adoConnection.Open;
    adoqryPublic.SQL.Text := 'EXEC systempanel.dbo.write_exit_time ''' +
      vComputer_Name + ''', ''' + vUser_ID + ''', ' + IntToStr(vSystem_ID);
    adoqryPublic.ExecSQL;
  finally
    SetComplete;
    adoConnection.Close;
  end;
end;

procedure TWMISUserRight.GetUserLevel(vSystem_ID: Integer;
  const vComputer_Name: WideString; var vLevelList: WideString);
begin
  vLevelList := '';
  try
    adoConnection.Open;
    with adoqryPublic do
    begin
      SQL.Text := 'EXEC systempanel.dbo.up_GetUserLevel ''' +
        vComputer_Name + ''', ' + IntToStr(vSystem_ID);
      Open;
      while not Eof do
      begin
        vLevelList := vLevelList + FieldByName('userLevel').AsString + #13#10;
        Next;
      end;
    end;
  finally
    SetComplete;
    adoqryPublic.Close;
    adoConnection.Close;
  end;
end;

procedure TWMISUserRight.GetSystemInfo(const SysName: WideString;
  var SysId: Integer; var SysFullName, UpdatePath, Mail: WideString);
var sqlText:widestring;
begin
  sqlText:='select sysid,sysfullname_CHN,exefilepath,mailbox from systempanel.dbo.system_detail'+
   ' where sysname='''+sysName+'''';
 try
    adoConnection.Open;
    with adoqryPublic do
    begin
      SQL.Text :=sqlText;
      Open ;
      if not( Eof and Bof ) then
      begin
        sysid:=FieldBYName('SysId').AsInteger ;
        sysfullname:=FieldBYName('sysfullname_CHN').AsString ;
        updatepath:=FieldByName('ExeFilePath').AsString ;
        mail:=FieldByName('MailBox').AsString ;
      end
      else
        sysid:=-1;
    end;
  finally
    SetComplete;
    adoConnection.Close;
  end;
end;



procedure TWMISUserRight.GetUserDepartmentList(const sUserID: WideString;
  var sDepartmentList, sErrMsg: WideString);
var sqlText:widestring;
begin
  sqlText:='exec SystemPanel..usp_GetUserDepartmentList '+ QuotedStr(sUserID);
 try
    adoConnection.Open;
    with adoqryPublic do
    begin
      Close;
      SQL.Text :=sqlText;
      Open ;
      if not IsEmpty then
         sDepartmentList:=FieldBYName('DeptList').AsString
      else
        sDepartmentList:='';
    end;
  finally
    SetComplete;
    adoConnection.Close;
  end;

end;

procedure TWMISUserRight.GetDefaultDepartment(const sUserID: WideString;
  var sDefaultDepartment, sErrMsg: WideString);
var sqlText:widestring;
begin
  sqlText:='select Default_Department from user_info where UserID= '+ QuotedStr(sUserID);
 try
    adoConnection.Open;
    with adoqryPublic do
    begin
      Close;
      SQL.Text :=sqlText;
      Open ;
      if not IsEmpty then
         sDefaultDepartment:=FieldBYName('Default_Department').AsString
      else
        sDefaultDepartment:='';
    end;
  finally
    SetComplete;
    adoConnection.Close;
  end;
end;

procedure TWMISUserRight.GetMenuInfo(const sUserID: WideString;
  iSysID: Integer; var vData: OleVariant; var sErrMs: WideString);
var
  sqlText:widestring;
  Adsp:TDataSetProvider;
begin
  sqlText:=' exec usp_WmisGetSysMenuInfo '+ QuotedStr(sUserID)+','+IntToStr(iSysID);
  Adsp:=TDataSetProvider.Create(self);
  Adsp.DataSet:=adoqryPublic;
  try
    adoConnection.Open;
    with adoqryPublic do
    begin
      Close;
      SQL.Text :=sqlText;
      Open;
      vData:=Adsp.Data;
    end;
  finally
    SetComplete;
    Adsp.Free;
    adoConnection.Close;
  end;
end;

procedure TWMISUserRight.GetUserDepartments(const sUserID: WideString;
  iSysID: Integer; var vData: OleVariant; var sErrMsg: WideString);
var
  sqlText:widestring;
  Adsp:TDataSetProvider;
begin
  sqlText:=' exec usp_WmisGetUserDepartments '+ QuotedStr(sUserID)+','+IntToStr(iSysID);
  Adsp:=TDataSetProvider.Create(self);
  Adsp.DataSet:=adoqryPublic;
  try
    adoConnection.Open;
    with adoqryPublic do
    begin
      Close;
      SQL.Text :=sqlText;
      Open;
      vData:=Adsp.Data;
    end;
  finally
    SetComplete;
    Adsp.Free;
    adoConnection.Close;
  end;
end;
function TWMISUserRight.GetConnectionString(sLibraryName,
  sSystemId: string): string;
var connXMLFile,ConfigerFilePath,LibraryFullPath,ServerName,DatabaseName,UserID,Password,TimeOut: string;
    xmlDoc: TXMLDocument;
    ANode: IXMLNode;
    iStringLength:integer;

begin
  LibraryFullPath:=GetLibraryFullPath(sLibraryName);
  if Rightstr(LibraryFullPath,1)=':' then
     ConfigerFilePath:=LibraryFullPath+'\Configer\'
  else
  begin
    iStringLength:=Length(LibraryFullPath);
    while (iStringLength>=1) do
    begin
        if Midstr(LibraryFullPath,iStringLength,1)='\' then
          break
        else
          iStringLength:=iStringLength-1;
    end;
    ConfigerFilePath:=Copy(LibraryFullPath,1,iStringLength-1)+'\Configer\';
  end;

  connXMLFile:=ConfigerFilePath+sSystemId+'.XML';
  xmlDoc := TXMLDocument.Create(Application);
  xmlDoc.FileName :=connXMLFile;
  xmlDoc.Active :=true;

  try
    ANode:=xmlDoc.ChildNodes.FindNode('WMIS');
    ANode:=ANode.ChildNodes.FindNode('Connection');
    ServerName:=ANode.Attributes['ServerName'];
    DatabaseName:=ANode.Attributes['DatabaseName'];
    UserId:=ANode.Attributes['UserId'];
    Password:=Anode.Attributes['Password'];
    TimeOut:=inttostr(ANode.Attributes['TimeOut']);
  finally
    xmlDoc.Active := False;
    xmlDoc.Free;
  end;

  Result :=
        'Provider=SQLOLEDB.1;Password=' + Password +
        ';Persist Security Info=True;User ID=' + UserID +
        ';Initial Catalog=' + DatabaseName +
        ';Data Source=' + ServerName +
        ';TimeOut='+TimeOut+
        ';Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;' +
        'Use Encryption for Data=False;Tag with column collation when possible=False';


end;

function TWMISUserRight.GetLibraryFullPath(sLibraryName: string): string;
var
  hModule: THandle;
  buff: array[0..255] of Char;
  sFullName:string;
begin

  hModule := GetModuleHandle(pChar(sLibraryName));
  GetModuleFileName(hModule, buff, sizeof(buff));
  sFullName:=buff;
  result:=Copy(sFullName,1,Length(sFullName)-Length(sLibraryName)-1);
end;

procedure TWMISUserRight.MtsDataModuleCreate(Sender: TObject);
begin
  adoConnection.ConnectionString :=self.GetConnectionString('WMISUserRightPJT.dll','WMISUSERRIGHT');
end;

procedure TWMISUserRight.GetUserLevelByUserid(vSysID: Integer;
  const vUserID: WideString; var vLevelList: WideString);
begin
  vLevelList := '';
  try
    adoConnection.Open;
    with adoqryPublic do
    begin
      SQL.Text := 'EXEC systempanel.dbo.up_GetUserLevel '+quotedstr('')+','
         + IntToStr(vSysID)+','+quotedstr(vUserID);
      Open;
      while not Eof do
      begin
        vLevelList := vLevelList + FieldByName('userLevel').AsString + #13#10;
        Next;
      end;
    end;
  finally
    SetComplete;
    adoqryPublic.Close;
    adoConnection.Close;
  end;

end;

initialization
  TComponentFactory.Create(ComServer, TWMISUserRight,
    Class_WMISUserRight, ciMultiInstance, tmNeutral);
end.


