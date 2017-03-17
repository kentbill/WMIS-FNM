{*******************************************************}
{                                                       }
{       软件名称 W.MIS CLIENT MODEL                     }
{       版权所有 (C) 2003, 2004 Esquel.IT               }
{       单元名称 ServerDllPub.pas                       }
{       创建日期 2004-8-3 11:00:48                      }
{       创建人员 Wangli                                 }
{                                                       }
{*******************************************************}

unit ServerDllPub;
{* 客户端访问服务器端组件接口单元 }

interface

{$I Terminal.inc}
uses COMObj, FNMFacade_TLB, ULogin
    {$IFNDEF TERMINAL}
      ,frmWelcome,frmMain
    {$ENDIF};



{$WARN SYMBOL_PLATFORM OFF}
//创建联接
function ComConnect(ClassID: TGUID): IDispatch;
function FNMServerObj: IFNMFacadeLibDisp;
function FNMServerArtObj: IFNMArtFacadeLibDisp;
function ThirdFacadeObj: IThirdFacadeDisp;

implementation
{$IFNDEF TERMINAL}
procedure ChangeComPlusServer;
var i:Integer;
begin
  try
    if not Assigned(FNMWelcome) then
      FNMWelcome:=TFNMWelcome.Create(nil);
    for i:=0 to FNMWelcome.cmbComPlusServers.Items.Count-1 do
    begin
      if FNMWelcome.cmbComPlusServers.Items[i]<>Login.ComPlusServer then
      begin
        Login.ComPlusServer:=FNMWelcome.cmbComPlusServers.Items[i];
        FNMMainForm.SetStatusBar;
        Break;
      end;
    end;
  finally
    FNMWelcome:=nil;
    FNMWelcome.Free;
  end;
end;
{$ENDIF}

function ComConnect(ClassID: TGUID): IDispatch;
begin
  try
    Result := CreateRemoteComObject(Login.ComPlusServer, ClassID) as IDispatch;
  except
    {$IFNDEF TERMINAL}
     ChangeComPlusServer;
    {$ENDIF}
    Result := CreateRemoteComObject(Login.ComPlusServer, ClassID) as IDispatch;
  end;
end;

function ComConnectTest(ClassID: TGUID): IDispatch;
begin
  //连接到测试服务器
  Result := CreateRemoteComObject('GET03C0062', ClassID) as IDispatch;
end;

function FNMServerObj:IFNMFacadeLibDisp;
begin
  Result := IFNMFacadeLibDisp(ComConnect(CLASS_FNMFacadeLib));
end;

function FNMServerArtObj:IFNMArtFacadeLibDisp;
begin
  Result := IFNMArtFacadeLibDisp(ComConnect(CLASS_FNMArtFacadeLib));
end;

function ThirdFacadeObj: IThirdFacadeDisp;
begin
  Result := IThirdFacadeDisp(ComConnect(CLASS_ThirdFacade));
end;

end.



