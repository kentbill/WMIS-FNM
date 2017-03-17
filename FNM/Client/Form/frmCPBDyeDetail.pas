{*******************************************************}
{                                                       }
{       CPB染色明细                                     }
{                                                       }
{       版权所有 (C) 2015 Danny                         }
{                                                       }
{       时间:   2015.03.06 00:30:18}
{                                                       }
{       作者:   Danny                                                 }
{                                                       }
{                                                       }
{       功能描述:  大货报表
染色明细
染色时间	品名	色号	码长	类型	上工序时间	客户	交期	收布时间	DIP时间	周期	调色师	开单人
2011-5-11 13:00	PDDC00160-100579	0078RD02	12102	大货	2011-5-10 4:59	KOHL'S	2011-5-20	2011-5-8 13:00	2011-5-11 11:59	1	罗	罗
												
												
规则												
1、以染色时间作为查询条件							
2、明细汇总中要求以每次大货DIP的总码数显示为码长							
3、增加接收复板布时间,并由将新增的接收复板布界面调取收布时间数据							
4、上工序时间显示为接收复板布时同批中最晚到染色复板状态的一个卡号的时间							
5、DIP时间要求显示同批大货复板DIP时最先DIP下去的卡号的时间			 				
6、周期=（DIP时间-收布时间）/24，此处的时间需精确到小时计算，保留两位小数							
7、类型：大货、先锋样、试样、翻单、加色							
                                              }
{                                                       }
{                                                       }
{                                                       }
{                                                       }
{                                                       }
{*******************************************************}

unit frmCPBDyeDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, Buttons, ExtCtrls,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DBClient, ComCtrls;

type
  TCPBDyeDetailForm = class(TBaseForm)
    PanelHeader: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dpBeginDate: TDateTimePicker;
    dpEndDate: TDateTimePicker;
    cxgridCPBDye: TcxGrid;
    cxgridtvCPBDye: TcxGridDBTableView;
    cxGridlCPBDye: TcxGridLevel;
    dsCPBDye: TDataSource;
    cdsCPBDye: TClientDataSet;
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
  CPBDyeDetailForm: TCPBDyeDetailForm;

implementation
uses  ServerDllPub, uGlobal, uShowMessage, uFNMResource, uGridDecorator, uAppOption, uLogin,
  frmMain,uDictionary;
{$R *.dfm}


procedure TCPBDyeDetailForm.FormCreate(Sender: TObject);
begin
  inherited;
  dpEndDate.DateTime:=Now-1;
  dpBeginDate.DateTime:=dpEndDate.DateTime-7;
end;

procedure TCPBDyeDetailForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  Query;
end;

procedure TCPBDyeDetailForm.Query;
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
    FNMServerObj.GetQueryData(vData, 'CPBDyeDetail', sCondition, sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsCPBDye.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxgridtvCPBDye, dsCPBDye);
  finally
    Screen.Cursor :=  crDefault;
    ShowMsg('',crDefault);
  end;
end;

procedure TCPBDyeDetailForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
