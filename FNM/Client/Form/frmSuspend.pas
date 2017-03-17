unit frmSuspend;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmSuspend.pas                                                }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  机台停机记录                                                 }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,DateUtils;

type
  TSuspendForm = class(TForm)
    lbl1: TLabel;
    cbbSuspend: TComboBox;
    btnSave: TButton;
    btnClose: TButton;
    lbl2: TLabel;
    dtpBeginDate: TDateTimePicker;
    dtpBeginTime: TDateTimePicker;
    Label1: TLabel;
    dtpEndDate: TDateTimePicker;
    dtpEndTime: TDateTimePicker;
    mmoRemark: TMemo;
    lbl3: TLabel;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sBegin_Time: string;
    sEnd_Time: string;
    sRemark: string;
  end;

var
  SuspendForm: TSuspendForm;

implementation

{$R *.dfm}

procedure TSuspendForm.btnSaveClick(Sender: TObject);
begin
  sBegin_Time := DateToStr(dtpBeginDate.Date)+' '+TimeToStr(dtpBeginTime.Time);
  sEnd_Time:= DateToStr(dtpEndDate.Date)+' '+TimeToStr(dtpEndTime.Time);
  sRemark := Trim(mmoRemark.Text);
end;

procedure TSuspendForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TSuspendForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var BelowNow: Boolean;
begin
  if Self.ModalResult = mrOK then
  begin
    BelowNow := CompareDateTime(StrToDateTime(sBegin_Time),now)<=0;
    CanClose := BelowNow and (CompareDateTime(IncMinute(StrToDateTime(sBegin_Time)),StrToDateTime(sEnd_Time))<=0) and (cbbSuspend.Text <>'');
    if not canclose then
      showmessage('开始时间必须小于或等于当前时间'+#13#10+
                   '最少停机时间需要1分钟才做记录'+#13#10+
                   '停机原因没选择');
  end;
end;

procedure TSuspendForm.FormCreate(Sender: TObject);
begin
  dtpBeginDate.Date := Date();
  dtpEndDate.Date := Date();
  dtpBeginTime.Time := Time;
  dtpEndTime.Time := Time;
end;

end.

