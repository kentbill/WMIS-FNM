{*******************************************************}
{                                                       }
{       软件名称 W.MIS CLIENT MODEL                     }
{       版权所有 (C) 2003, 2004 Esquel.IT               }
{       单元名称 UOutLookMail.pas                       }
{       创建日期 2004-8-3 11:04:09                      }
{       创建人员 wuwj                                   }
{                                                       }
{*******************************************************}

unit UOutLookMail;
{* 用OutLook客户端发送邮件类单元 }

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
Outlook8, OleServer, COMobj, ActiveX,Variants;

type

  TMailRecord= record
  {*
        单元名称： UOutLookMail.pas
        类 名 称： TMailRecord
        创建人名： wuwj
        创建时间： 2004-8-3 11:26:20
        详细描述：
   }
    FileToAttach : String;
    MailTo : String;
    CC : String;
    BCC : String;
    Subject : String;
    Body : String;
  end;


{*
 过程名:    OutLookMailProc
 作者:      wuwj
 日期:      2004.08.03
 参数:      MailDetail:TMailRecord
 返回值:    无
}
procedure OutLookMailProc(MailDetail:TMailRecord);


implementation

procedure OutLookMailProc(MailDetail:TMailRecord);
VAR
  objOutlook : OutlookApplication;
  CurrentInterface : IUnknown;
  ActiveApplication : HResult;
  CurrentMailItem : MailItem;
  MailInspector : Inspector;
begin
  ActiveApplication:=GetActiveObject(CLASS_OutlookApplication, nil, CurrentInterface);
  if ActiveApplication = MK_E_UNAVAILABLE then
     objOutlook := CoOutlookApplication.Create
  else
  begin
    OleCheck(ActiveApplication);
    OleCheck(CurrentInterface.QueryInterface(OutlookApplication, objOutlook));
  end;
  try
    CurrentMailItem:= objOutlook.CreateItem(0) as MailItem;
    CurrentMailItem.To_ :=MailDetail.MailTo;
    if MailDetail.FileToAttach<>'' then
      CurrentMailItem.Attachments.Add(MailDetail.FileToAttach,EmptyParam, EmptyParam, EmptyParam);
    CurrentMailItem.cc:=MailDetail.CC;
    CurrentMailItem.BCC:=MailDetail.BCC;
    CurrentMailItem.Subject := MailDetail.Subject;
    CurrentMailItem.Body := MailDetail.Body;
    MailInspector := CurrentMailItem.GetInspector;
    MailInspector.Display(False);
    //objOutlook.Quit;
  finally
    objOutlook := nil;
  end;
end;

end.
