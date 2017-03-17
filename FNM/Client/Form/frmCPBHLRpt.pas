{*******************************************************}
{                                                       }
{       CPBHL报表                                       }
{                                                       }
{       版权所有 (C) 2015 Danny                         }
{                                                       }
{       时间:   2015.03.06 00:30:51}
{                                                       }
{       作者:   Danny                                                 }
{                                                       }
{                                                       }
{       功能描述:  H/L来样信息明细格式
序号	来样编号	色号	来样日期	完成日期	打样次数	打样个数	周期	REJECT	整理方式	客户	品名
1	LB12-597	0126KK01	4-1	4-4	6	20	3	REJECT	royal	EBO	PDKC00206


规则
1、来样日期：色号编制保存时间
2、完成日期：送样保存时间
3、打样次数：打样录入配方处的录入次数，前一次录入配方的保存时间到后一次录入配方的保存时间大于 0.5H 的算作一次。
4、打样个数：标记OK方界面 里面的所有个数
5、周期：（打样结束时间-色号编制时间）/24，时间精确到小时（保留两位小数）
6、REJECT 次数：输入重打评语的次数
                                              }
{                                                       }
{                                                       }
{                                                       }
{                                                       }
{                                                       }
{*******************************************************}

unit frmCPBHLRpt;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, Buttons, ExtCtrls,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DBClient, ComCtrls;

type
  TCPBHLRptForm = class(TBaseForm)
    PanelHeader: TPanel;
    Label1: TLabel;
    dpBeginDate: TDateTimePicker;
    Label2: TLabel;
    dpEndDate: TDateTimePicker;
    cxgridHLRpt: TcxGrid;
    cxgridtvCPBHLRpt: TcxGridDBTableView;
    cxGridlHLRpt: TcxGridLevel;
    dsCPBHLRpt: TDataSource;
    cdsCPBHLRpt: TClientDataSet;
    btnRefresh: TSpeedButton;
    btnClose: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Query();
  end;

var
  CPBHLRptForm: TCPBHLRptForm;

implementation
uses  ServerDllPub, uGlobal, uShowMessage, uFNMResource, uGridDecorator, uAppOption, uLogin,
  frmMain,uDictionary;
{$R *.dfm}


procedure TCPBHLRptForm.FormCreate(Sender: TObject);
begin
  inherited;
  dpEndDate.DateTime:=Now-1;
  dpBeginDate.DateTime:=dpEndDate.DateTime-7;
end;

procedure TCPBHLRptForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  Query;
end;

procedure TCPBHLRptForm.Query;
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
    sBeginDate, sEndDate:string;
begin
  try
    sBeginDate:='';
    sEndDate:='';

    if dpBeginDate.Checked then
      sBeginDate:=FormatDateTime('yyyy-MM-dd',dpBeginDate.DateTime);
    if dpEndDate.Checked then
      sEndDate:=FormatDateTime('yyyy-MM-dd',dpEndDate.DateTime);

    Screen.Cursor :=  crHourGlass;
    ShowMsg('正在获取数据稍等！',crHourGlass);
    sCondition := QuotedStr(sBeginDate)+','+QuotedStr(sEndDate);
    FNMServerObj.GetQueryData(vData, 'CPBHLRpt', sCondition, sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsCPBHLRpt.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxgridtvCPBHLRpt, dsCPBHLRpt);
  finally
    Screen.Cursor :=  crDefault;
    ShowMsg('',crDefault);
  end;
end;

procedure TCPBHLRptForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
