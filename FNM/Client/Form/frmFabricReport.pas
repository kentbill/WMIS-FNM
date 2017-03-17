unit frmFabricReport;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmFabricReport.pas                                            }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  保存打卡记录                                                 }
{                                                                              }
{******************************************************************************}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxSplitter, TeeProcs, TeEngine, Chart,
  DbChart, ExtCtrls, StdCtrls, Series, Buttons, ComCtrls;

type
  TFabricReportForm = class(TBaseForm)
    pnlBottom: TPanel;
    pnlClient: TPanel;
    cxgridtvFabricReport: TcxGridDBTableView;
    cxGridlFabricReport: TcxGridLevel;
    cxgridFabricReport: TcxGrid;
    dsFabricReport: TDataSource;
    cdsFabricReport: TClientDataSet;
    btnClose: TBitBtn;
    btnRefresh: TBitBtn;
    dtpBeginDate: TDateTimePicker;
    dtpBeginTime: TDateTimePicker;
    dtpEndDate: TDateTimePicker;
    dtpEndTime: TDateTimePicker;
    lblBeginTime: TLabel;
    lblEndTime: TLabel;
    lbl1: TLabel;
    cbbCurrentDept: TComboBox;
    cbbReportType: TComboBox;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cbbReportTypeChange(Sender: TObject);
  private
    { Private declarations }
    procedure Initialize();
    procedure GetFabricReportInfo();
    procedure GetData();
  public
    { Public declarations }
    procedure PublicQuery; override;
    procedure PublicExport; override;
  end;

var
  FabricReportForm: TFabricReportForm;

implementation

uses  ServerDllPub, uGlobal, UShowMessage, uGridDecorator, uAppOption, uLogin,
  frmMain,uDictionary;

{$R *.dfm}
procedure TFabricReportForm.PublicQuery;
begin
  GetData();
end;

procedure TFabricReportForm.PublicExport;
begin
  TGlobal.SaveDataToFile(cdsFabricReport, sftXLS);
end;

procedure TFabricReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFabricReportForm.FormDestroy(Sender: TObject);
begin
  inherited;
  FabricReportForm := nil;
end;

procedure TFabricReportForm.GetData();
begin
  GetFabricReportInfo();
end;

procedure TFabricReportForm.GetFabricReportInfo();
var vData: OleVariant;
    iType:Integer;
    sCondition,sCurrentDepartment,sBeginTime,sEndTime,sErrorMsg: WideString;

begin
  try
    ShowMsg('正在获取数据稍等！',crHourGlass);
    //获取日/月报的统计信息
    iType := cbbReportType.ItemIndex;
    sBeginTime := DateTimeToStr(Trunc(dtpBeginDate.Date) + Frac(dtpBeginTime.Time));
    sEndTime := DateTimeToStr(Trunc(dtpEndDate.Date) + Frac(dtpEndTime.Time));
    sCurrentDepartment := copy(cbbCurrentDept.Text,1,pos('->',cbbCurrentDept.Text)-1);
    sCondition := QuotedStr(sBeginTime)+ ','+ QuotedStr(sEndTime)+','+ QuotedStr(sCurrentDepartment)+','+IntToStr(iType);
    FNMServerObj.GetQueryData(vData,'GetFabricReportInfo',sCondition,sErrorMsg);
//    FNMServerObj.GetFabricReportInfo(vData,sBeginTime,sEndTime,sCurrentDepartment,iType,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsFabricReport.Data := vData;
    if cdsFabricReport.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有相应的数据,请重新查询',1);
      cdsFabricReport.EmptyDataSet;
      Exit;
    end;
    GridDecorator.BindCxViewWithDataSource(cxgridtvFabricReport, dsFabricReport,True);
    if cbbReportType.ItemIndex <> 3 then
      GridDecorator.AddFooter(cxgridtvFabricReport,['Quantity'],[skSum])
    else
      GridDecorator.AddFooter(cxgridtvFabricReport,['上日存','上月存','日收坯','月收坯','日收对方后整','月收对方后整','日非FN外回修','月非FN外回修','日FN外回修',
        '月FN外回修','日送成品','月送成品','日送对方后整','月送对方后整','日送外发','月送外发','日送其他','月送其他'],
        [skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum]);
  finally
    ShowMsg('',crDefault);
  end;
end;
procedure TFabricReportForm.Initialize();
begin
  dtpBeginDate.Date := Now()-1;
  dtpBeginTime.Time := StrToTime('07:00:00');
  dtpEndDate.Date := dtpBeginDate.Date+1;
  dtpEndTime.Time:= dtpBeginTime.Time;
  cbbReportType.ItemIndex := 0;
  TGlobal.FillComboBoxFromDataSet(Dictionary.cds_DepartmentList,'Department','Description','->',cbbCurrentDept);
  cbbCurrentDept.Text := FNMMainForm.cbbCurrentDept.Text;
end;

procedure TFabricReportForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize();
end;

procedure TFabricReportForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetData();
end;

procedure TFabricReportForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFabricReportForm.cbbReportTypeChange(Sender: TObject);
begin
  inherited;
  dtpBeginDate.Visible := cbbReportType.ItemIndex <>1;
  dtpBeginTime.Visible := cbbReportType.ItemIndex <>1;
  dtpEndDate.Visible := cbbReportType.ItemIndex <>1;
  dtpEndTime.Visible := cbbReportType.ItemIndex <>1;
  lblBeginTime.Visible := cbbReportType.ItemIndex <>1;
  lblEndTime.Visible := cbbReportType.ItemIndex <>1;
end;

end.
