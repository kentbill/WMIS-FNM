unit frmAdjustJobTraceDtl;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmAdjustJobTraceDtl.pas                                            }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  调整机台及车速                                               }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxSplitter, ExtCtrls, DBClient, StdCtrls,
  Buttons, cxDBLookupComboBox, Provider, ADODB, ComCtrls;

type
  TAdjustJobTraceDtlForm = class(TBaseForm)
    pnlClient: TPanel;
    pnlBottom: TPanel;
    cxSplBottom: TcxSplitter;
    cxGridtvJobTraceDtl: TcxGridDBTableView;
    cxGridlJobTraceDtlLevel: TcxGridLevel;
    cxGridJobTraceDtl: TcxGrid;
    dsJobTraceDtl: TDataSource;
    cdsJobTraceDtl: TClientDataSet;
    btnQuery: TSpeedButton;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    cxGridtvJobTraceDtlIden: TcxGridDBColumn;
    cxGridtvJobTraceDtlGF_NO: TcxGridDBColumn;
    cxGridtvJobTraceDtlFN_Card: TcxGridDBColumn;
    cxGridtvJobTraceDtlQuantity: TcxGridDBColumn;
    cxGridtvJobTraceDtlStep_NO: TcxGridDBColumn;
    cxGridtvJobTraceDtlOperation_CHN: TcxGridDBColumn;
    cxGridtvJobTraceDtlMachine_ID: TcxGridDBColumn;
    cxGridtvJobTraceDtlSpeed: TcxGridDBColumn;
    cxGridtvJobTraceDtlBegin_Time: TcxGridDBColumn;
    cxGridtvJobTraceDtlEnd_Time: TcxGridDBColumn;
    cxGridtvJobTraceDtlBefor_Operator: TcxGridDBColumn;
    cxGridtvJobTraceDtlMiddle_Operator: TcxGridDBColumn;
    cxGridtvJobTraceDtlAfter_Operator: TcxGridDBColumn;
    cxGridtvJobTraceDtlOperator: TcxGridDBColumn;
    cxGridtvJobTraceDtlOperate_Time: TcxGridDBColumn;
    cxGridtvJobTraceDtlGF_ID: TcxGridDBColumn;
    cxGridtvJobTraceDtlJob_NO: TcxGridDBColumn;
    cxGridtvJobTraceDtlOperation_Code: TcxGridDBColumn;
    dsMachineList: TDataSource;
    dsWorkerList: TDataSource;
    cdsJobTraceDtlIden: TAutoIncField;
    cdsJobTraceDtlGF_NO: TStringField;
    cdsJobTraceDtlFN_Card: TStringField;
    cdsJobTraceDtlQuantity: TBCDField;
    cdsJobTraceDtlStep_NO: TSmallintField;
    cdsJobTraceDtlOperation_CHN: TStringField;
    cdsJobTraceDtlMachine_ID: TStringField;
    cdsJobTraceDtlSpeed: TBCDField;
    cdsJobTraceDtlBegin_Time: TDateTimeField;
    cdsJobTraceDtlEnd_Time: TDateTimeField;
    cdsJobTraceDtlBefor_Operator: TStringField;
    cdsJobTraceDtlMiddle_Operator: TStringField;
    cdsJobTraceDtlAfter_Operator: TStringField;
    cdsJobTraceDtlOperator: TStringField;
    cdsJobTraceDtlOperate_Time: TDateTimeField;
    cdsJobTraceDtlGF_ID: TIntegerField;
    cdsJobTraceDtlJob_NO: TStringField;
    cdsJobTraceDtlOperation_Code: TStringField;
    pgcType: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    lblFNCard: TLabel;
    edtFNCard: TEdit;
    lblBeginTime: TLabel;
    lblEndTime: TLabel;
    dtpBeginDate: TDateTimePicker;
    dtpBeginTime: TDateTimePicker;
    dtpEndDate: TDateTimePicker;
    dtpEndTime: TDateTimePicker;
    Label1: TLabel;
    cbbMachineList: TComboBox;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure edtFNCardKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure GetJobTraceDtlInfo;
    procedure GetData();
    procedure SaveJobTraceDtlInfo();
    procedure SaveData();
  public
    { Public declarations }
    procedure PublicQuery; override;
    procedure PublicSave; override;
  end;

var
  AdjustJobTraceDtlForm: TAdjustJobTraceDtlForm;

implementation

uses ServerDllPub,uGlobal, uShowMessage, uLogin, uGridDecorator,
  uAppOption, uCADInfo, uFNMResource,uDictionary;

{$R *.dfm}

procedure TAdjustJobTraceDtlForm.PublicQuery;
begin
  GetData();
end;

procedure TAdjustJobTraceDtlForm.PublicSave;
begin
  SaveData();
end;

procedure TAdjustJobTraceDtlForm.GetJobTraceDtlInfo();
var vData: OleVariant;
    sParam,sBegin_Time,sEnd_Time: string;
    sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    //获取卡的进度跟踪信息
    sBegin_Time := '';
    sEnd_Time := '';
    if pgcType.ActivePageIndex = 0 then
    begin
      sParam := Copy(cbbMachineList.Text,1,POS('->',cbbMachineList.Text)-1);
      if sParam='' then Exit;
      sBegin_Time := DateTimeToStr(Trunc(dtpBeginDate.Date) + Frac(dtpBeginTime.Time));
      sEnd_Time := DateTimeToStr(Trunc(dtpEndDate.Date) + Frac(dtpEndTime.Time));
    end else
    begin
     sParam := Trim(edtFNCard.Text);
     if Length(sParam) <> 9 then
     begin
       TMsgDialog.ShowMsgDialog('卡号位数不对,请重新输入', 1);
       Exit;
     end;
    end;
    FNMServerObj.GetJobTraceDtlInfo(vData,sParam,sBegin_Time,sEnd_Time,Login.CurrentDepartment,pgcType.ActivePageIndex,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      Application.ShowException(Exception.Create(sErrorMsg));
      Exit;
    end;
    cdsJobTraceDtl.Data := vData;
    if cdsJobTraceDtl.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有相应的数据,请重新查询', 1);
      Exit;
    end;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TAdjustJobTraceDtlForm.GetData();
begin
  GetJobTraceDtlInfo();
end;

procedure TAdjustJobTraceDtlForm.SaveJobTraceDtlInfo();
var vData:OleVariant;
  sIndexList,sErrorMsg: WideString;
begin
  try
    ShowMsg('正在保存数据稍等！', crHourGlass);
    if TGlobal.DeltaIsNull(cdsJobTraceDtl) then Exit;
    TempClientDataSet.Data := cdsJobTraceDtl.Delta;
    sIndexList := '';
    while not TempClientDataSet.Eof do
    begin
       sIndexList := sIndexList+TempClientDataSet.FieldByName('Iden').AsString+#13;
       TempClientDataSet.Next;
       TempClientDataSet.Next;
    end;
    vData := cdsJobTraceDtl.Data;
    FNMServerObj.AdjustJobTraceDtlInfo(vData,sIndexList,Login.LoginName,Login.CurrentDepartment,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsJobTraceDtl.MergeChangeLog;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TAdjustJobTraceDtlForm.SaveData();
begin
  SaveJobTraceDtlInfo();
end;

procedure TAdjustJobTraceDtlForm.FormDestroy(Sender: TObject);
begin
  inherited;
  AdjustJobTraceDtlForm := nil;
end;

procedure TAdjustJobTraceDtlForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TAdjustJobTraceDtlForm.FormCreate(Sender: TObject);
var FilterStr: string;
begin
  inherited;
  btnQuery.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  FilterStr := 'Department =' + QuotedStr(Login.CurrentDepartment);
  TGlobal.FilterData(Dictionary.cds_WorkerList,FilterStr);
  dsWorkerList.DataSet :=Dictionary.cds_WorkerList;
  TGlobal.FilterData(Dictionary.cds_FinishMachineList,FilterStr);
  TGlobal.FillItemsFromDataSet(Dictionary.cds_FinishMachineList, 'Machine_ID', 'Machine_Model_CHN', '->', cbbMachineList.Items);
  dsMachineList.DataSet :=Dictionary.cds_FinishMachineList;
  dtpBeginDate.Date := Now()-1;
  dtpBeginTime.Time := StrToTime('07:00:00');
  dtpEndDate.Date := dtpBeginDate.Date+1;
  dtpEndTime.Time:= dtpBeginTime.Time;
  cbbMachineList.Items.Insert(0,'063->缝头');
end;

procedure TAdjustJobTraceDtlForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  GetData();
end;

procedure TAdjustJobTraceDtlForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData();
end;

procedure TAdjustJobTraceDtlForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TAdjustJobTraceDtlForm.edtFNCardKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
     GetData();
end;

end.
