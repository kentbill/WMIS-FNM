{*******************************************************}
{                                                       }
{       ������� W.MIS CLIENT MODEL                     }
{       ��Ȩ���� (C) 2003, 2004 Esquel.IT               }
{       ��Ԫ���� UOutLookMail.pas                       }
{       �������� 2004-8-3 11:04:09                      }
{       ������Ա wuwj                                   }
{                                                       }
{*******************************************************}

unit UOutLookMail;
{* ��OutLook�ͻ��˷����ʼ��൥Ԫ }

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
Outlook8, OleServer, COMobj, ActiveX,Variants;

type

  TMailRecord= record
  {*
        ��Ԫ���ƣ� UOutLookMail.pas
        �� �� �ƣ� TMailRecord
        ���������� wuwj
        ����ʱ�䣺 2004-8-3 11:26:20
        ��ϸ������
   }
    FileToAttach : String;
    MailTo : String;
    CC : String;
    BCC : String;
    Subject : String;
    Body : String;
  end;


{*
 ������:    OutLookMailProc
 ����:      wuwj
 ����:      2004.08.03
 ����:      MailDetail:TMailRecord
 ����ֵ:    ��
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
