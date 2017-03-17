unit frmAccidentTimeSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,DateUtils;

type
  TAccidentTimeSelectFrom = class(TForm)
    dtpBeginTime: TDateTimePicker;
    lbl2: TLabel;
    dtpBeginDate: TDateTimePicker;
    Label1: TLabel;
    dtpEndDate: TDateTimePicker;
    dtpEndTime: TDateTimePicker;
    btnSave: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    sBegin_Time: string;
    sEnd_Time: string;
    { Public declarations }
  end;

var
  AccidentTimeSelectFrom: TAccidentTimeSelectFrom;

implementation

{$R *.dfm}

procedure TAccidentTimeSelectFrom.FormCreate(Sender: TObject);
begin
  dtpBeginDate.Date := Date();
  dtpEndDate.Date := Date();
  dtpBeginTime.Time := Time;
  dtpEndTime.Time := Time;

  sBegin_Time := DateToStr(dtpBeginDate.Date)+' '+TimeToStr(dtpBeginTime.Time);
  sEnd_Time:= DateToStr(dtpEndDate.Date)+' '+TimeToStr(dtpEndTime.Time);
end;

procedure TAccidentTimeSelectFrom.btnSaveClick(Sender: TObject);
begin
  sBegin_Time := DateToStr(dtpBeginDate.Date)+' '+TimeToStr(dtpBeginTime.Time);
  sEnd_Time:= DateToStr(dtpEndDate.Date)+' '+TimeToStr(dtpEndTime.Time);
end;

procedure TAccidentTimeSelectFrom.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var BelowNow: Boolean;
begin
  //if Self.ModalResult = mrOK then
 // begin
    BelowNow := CompareDateTime(StrToDateTime(sBegin_Time),now)<=0;
    CanClose := BelowNow and (CompareDateTime(IncMinute(StrToDateTime(sBegin_Time)),StrToDateTime(sEnd_Time))<=0);
    if not canclose then
      showmessage('开始时间必须小于或等于当前时间'+#13#10+
                   '最少停机时间需要1分钟才做记录');
  //end;
end;

end.
