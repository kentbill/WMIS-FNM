unit frmSuspend;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmSuspend.pas                                                }
{       �������� 2004-8-26 13:50:57                                            }
{       ������Ա zhangjy                                                       }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       ��������  ��̨ͣ����¼                                                 }
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
      showmessage('��ʼʱ�����С�ڻ���ڵ�ǰʱ��'+#13#10+
                   '����ͣ��ʱ����Ҫ1���Ӳ�����¼'+#13#10+
                   'ͣ��ԭ��ûѡ��');
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

