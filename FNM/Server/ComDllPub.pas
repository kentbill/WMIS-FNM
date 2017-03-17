unit ComDllPub;

interface
uses Forms,Windows,COMObj,FNMFacade_TLB,DBClient,FNMDAO_TLB, Variants,XMLIntf, XMLDoc,SysUtils,StrUtils;

{$WARN SYMBOL_PLATFORM OFF}
function GetLibraryFullPath(sLibraryName: string): string;
function GetConnectionString(sLibraryName: string;sSystemId: string): string;
function GetHostName():string;

function ComConnect(ClassID: TGUID): IDispatch; // 创建联接
function ServerObj:IFNMFacadeLibDisp;  
function FNMDAOInfo:IFNMDAOInfoDisp;
function FNMDAOUpt:IFNMDAOUptDisp;
function ThirdDAOInfo:IThirdDAOInfoDisp;
function ThirdDAOUpt:IThirdDAOUptDisp;

implementation

 //获取当前机器名称
function GetHostName():string ;
var
  HostName: PChar;
  Size: DWord;
begin
  GetMem(HostName, 255);
  Size := 255;
  try
    try
      if GetComputerName(HostName, Size) = False then
        begin
          FreeMem(HostName);
          Exit;
        end;
      result:= HostName;
    except
      raise Exception.Create('获取服务器名称失败!');
    end;
  finally
    FreeMem(HostName);
  end;
end;

//该函数根据com+执行的库文件名称，找到该库文件物理路经，再找到放置连接
//属性的xml文件（该文件相对库文件路径的位置是　..\Configer\系统名称.XML），
//最后读出连接属性构造一个完整的连接字符串

function GetConnectionString(sLibraryName: string;sSystemId: string): string;
var
  ANode: IXMLNode;
  xmlDoc: TXMLDocument;
  iStringLength:integer;
  connXMLFile,ConfigerFilePath,LibraryFullPath,ServerName,DatabaseName,UserID,Password,TimeOut: string;
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
        ';Connect TimeOut='+TimeOut+
        ';Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;' +
        'Use Encryption for Data=False;Tag with column collation when possible=False';
end;

 //该函数根据com+组件实际调用的动态库文件名称，返回该文件的物理路径
function GetLibraryFullPath(sLibraryName: string): string;
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

function ComConnect(ClassID: TGUID): IDispatch;
begin
  Result := CreateRemoteComObject(GetHostName, ClassID) as IDispatch;
end;

function ServerObj:IFNMFacadeLibDisp;
begin
  Result := IFNMFacadeLibDisp(ComConnect(CLASS_FNMFacadeLib));
end;

function FNMDAOInfo:IFNMDAOInfoDisp;
begin
  Result := IFNMDAOInfoDisp(ComConnect(CLASS_FNMDAOInfo));
end;

function FNMDAOUpt:IFNMDAOUptDisp;
begin
  Result := IFNMDAOUptDisp(ComConnect(CLASS_FNMDAOUpt));
end;

function ThirdDAOInfo:IThirdDAOInfoDisp;
begin
  Result := IThirdDAOInfoDisp(ComConnect(CLASS_ThirdDAOInfo));
end;

function ThirdDAOUpt:IThirdDAOUptDisp;
begin
  Result := IThirdDAOUptDisp(ComConnect(CLASS_ThirdDAOUpt));
end;

end.




