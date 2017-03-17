unit frmSendSCInfo;

{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmSendInfo.pas                                               }
{       创建日期 2004-8-26 16:22:52                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{            读: FNMDB..fnStock表所有字段                                      }
{            写: FNMDB..fnPay表所有字段                                        }
{            写: FNMDB..fnJobTraceDtl表                                        }
{       调用重要函数/SQL对象说明                                               }
{       功能描述                                                               }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, ExtCtrls, OleCtrls, Buttons,
  DB, DBClient, ComCtrls, StrUtils, GFCADLib_TLB, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter,Math;

type
  TSendSCInfoForm = class(TBaseForm)
    cdsSendInfo: TClientDataSet;
    dsSendInfo: TDataSource;
    btnClose: TSpeedButton;
    btnSave: TSpeedButton;
    btnRefresh: TSpeedButton;
    cxspl1: TcxSplitter;
    spl1: TSplitter;
    grpSource: TGroupBox;
    pnl7: TPanel;
    lblQuantitySource: TLabel;
    edtQuantitySource: TEdit;
    lvSource: TListView;
    pnlButton: TPanel;
    btnRight: TSpeedButton;
    btnRightAll: TSpeedButton;
    btnLeft: TSpeedButton;
    btnLeftAll: TSpeedButton;
    grpDestinate: TGroupBox;
    pnl8: TPanel;
    lblQuantityDestinate: TLabel;
    edtQuantityDestinate: TEdit;
    lvDestinate: TListView;
    cxgrdOnlineSendInfo: TcxGrid;
    cxgrdtvSendInfo: TcxGridDBTableView;
    cxgrdlvlOnLineGridlcxgrid2Level1: TcxGridLevel;
    btnSb: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
    procedure btnRightAllClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
    procedure btnLeftAllClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure lvSourceDblClick(Sender: TObject);
    procedure lvDestinateDblClick(Sender: TObject);
    procedure lvSourceColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvDestinateColumnClick(Sender: TObject; Column: TListColumn);
    procedure FormCreate(Sender: TObject);
    procedure lvSourceKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvDestinateKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvDestinateCustomDraw(Sender: TCustomListView;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure cbbDestinateChange(Sender: TObject);
    procedure lvSourceChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvDestinateChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormActivate(Sender: TObject);
    procedure btnSbClick(Sender: TObject);
  private
    { Private declarations }
{* -----------------------------------------------------------------------------
   过程名称 Initialize
   创建人员 zhangjy
   创建日期 2004-8-26 14:24:10
   参数列表 None
   返回值   None
   功能描述 初始化窗体参数
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure Initialize;
{* -----------------------------------------------------------------------------
   过程名称 GetData
   创建人员 zhangjy
   创建日期 2004-8-26 14:24:39
   参数列表 None
   返回值   None
   功能描述 获取数据
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure GetSendInfo;
    procedure GetSendNoteInfo;
    procedure GetData;
{* -----------------------------------------------------------------------------
   过程名称 SaveData
   创建人员 zhangjy
   创建日期 2004-8-26 16:18:53
   参数列表 None
   返回值   None
   功能描述 保存送布信息
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure SaveSendInfo;
    procedure SaveData;
  public
    { Public declarations }
{* -----------------------------------------------------------------------------
   过程名称 PublicQuery ;PublicExport; PublicSave
   创建人员 zhangjy
   创建日期 2004-8-31 15:41:59
   参数列表 None
   返回值   None
   功能描述 响应TOOLBAR相应的事件
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    //procedure FiltercxGridTableView(FildName, FilterValue: String);
    procedure PublicQuery; override;
    procedure PublicExport; override;
    procedure PublicSave; override;
  end;
var
  SendSCInfoForm: TSendSCInfoForm;

implementation

uses ServerDllPub, uGlobal,uShowMessage, uLogin, uGridDecorator,
  uAppOption, uDictionary, uFNMResource,rptSendInfo, frmSendInfo;

{$R *.dfm}

procedure TSendSCInfoForm.PublicQuery;
begin
  GetData;
end;

procedure TSendSCInfoForm.PublicExport;
begin
  TGlobal.SaveDataToFile(cdsSendInfo, sftXLS)
end;

procedure TSendSCInfoForm.PublicSave;
begin
  SaveData;
end;

procedure TSendSCInfoForm.Initialize;
begin
  //设置BUTTON图片
  btnRight.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnRightAll.Glyph.LoadFromResourceName(HInstance, RES_DOWNALL);
  btnLeft.Glyph.LoadFromResourceName(HInstance, RES_UP);
  btnLeftAll.Glyph.LoadFromResourceName(HInstance, RES_UPALL);
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
   // 填充送布地点
  //Dictionary.cds_MaterialFlowList.Filtered := False;
  //Dictionary.cds_MaterialFlowList.Filter := 'Current_Department=' + QuotedStr(Login.CurrentDepartment) + ' AND Flow_Description=' + QuotedStr('送布地点');
  //Dictionary.cds_MaterialFlowList.Filtered := True;
  //TGlobal.FillItemsFromDataSet(Dictionary.cds_MaterialFlowList, 'Relation_Department', 'Relation_Department_CHN', '->', cbbDestinate.Items);

  //if Login.CurrentDepartment <> 'FX' Then
  //begin
  //计划班长/质量班长
  //Dictionary.cds_WorkerList.Filtered := False;
  //Dictionary.cds_WorkerList.Filter := 'Department=' + QuotedStr(Login.CurrentDepartment) + ' AND Worker_Group=' + QuotedStr('计划班长');
  //Dictionary.cds_WorkerList.Filtered := True;
  //TGlobal.FillItemsFromDataSet(Dictionary.cds_WorkerList, 'Worker_Name', '', '', cbPlanOperator.Items);
  //Dictionary.cds_WorkerList.Filtered := False;
  //Dictionary.cds_WorkerList.Filter := 'Department=' + QuotedStr(Login.CurrentDepartment) + ' AND Worker_Group=' + QuotedStr('操作班长');
  //Dictionary.cds_WorkerList.Filtered := True;
  //TGlobal.FillItemsFromDataSet(Dictionary.cds_WorkerList, 'Worker_Name', '', '', cbQualityOperator.Items);
  //end;
  //lbQualityOperator.Visible :=  Login.CurrentDepartment <> 'FX';
  //lbPlanOperator.Visible :=  Login.CurrentDepartment <> 'FX';
  //cbQualityOperator.Visible :=  Login.CurrentDepartment <> 'FX';
  //cbPlanOperator.Visible :=  Login.CurrentDepartment <> 'FX';

  //ListView多选
  //lvSource.MultiSelect := True;
  //lvDestinate.MultiSelect := True;

  edtQuantitySource.Text := '0.0';
  edtQuantityDestinate.Text := '0.0';
  //cbbDestinate.ItemIndex := 0;
end;

procedure TSendSCInfoForm.GetSendInfo;
var vData: OleVariant;
  sCondition,sErrorMsg,sDestination: WideString;
  i,j: Integer;
  sOperator: string;
begin
  lvDestinate.Items.Clear ; //Added by wlx
  edtQuantityDestinate.Text :='';
  //if cbbDestinate.Text ='' then
  //begin
  //  TMsgDialog.ShowMsgDialog('请选择送布地点！',mtWarning);
  //  cbbDestinate.SetFocus;
  //  exit;
  //end;
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
   //获取待打卡的卡号信息
    sDestination:='';
    sCondition := QuotedStr(sDestination)+',' + QuotedStr(Login.CurrentDepartment)+','+IntToStr(2);
    FNMServerObj.GetQueryData(vData,'GetSendInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TempClientDataSet.Filter := '';
    cdsSendInfo.Filter := '';
    TempClientDataSet.Data := vData;

    if TempClientDataSet.IsEmpty then
    begin
      lvSource.Items.Clear;
      lvDestinate.Items.Clear;
      TMsgDialog.ShowMsgDialog('没有待送布的信息',2);
      Exit;
    end;
    //填充未打卡的ListView
    //请求ID : 285178   tracy tan 2017-1-6

    TGlobal.FillItemsFromDataSet(TempClientDataSet, 'Quantity',['FN_Card','Quantity','Operation_CHN','GF_NO','step_no','job_no','Check_Value','Current_Department','Current_StepNo', 'Current_OperationCode','Location','WV_Actual_Finish_Date'],nil,edtQuantitySource,lvSource.Items);
    TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
    //填充cxGrid
    //GridDecorator.BindCxViewWithDataSource(cxgridtvSendInfo, dsSendInfo);
    //Dictionary.cds_WorkerStationList.Filtered := False;
//    if Dictionary.cds_WorkerStationList.Locate('Current_Department;Operate_Type',VarArrayOf([Login.CurrentDepartment,'计划']),[]) then
//    begin
//      sOperator:='';
//      sOperator :=  Dictionary.cds_WorkerStationList.FieldByName('Worker_ID').AsString;
//      i:= Pos('(',sOperator);
//      j:= Pos(')',sOperator);
//      sOperator := Copy(sOperator,i+1,j-i-1);
//      cbPlanOperator.ItemIndex := cbPlanOperator.Items.IndexOf(sOperator);
//    end;

//    if Dictionary.cds_WorkerStationList.Locate('Current_Department;Operate_Type',VarArrayOf([Login.CurrentDepartment,'质量']),[]) then
//    begin
//      sOperator:='';
//      sOperator :=  Dictionary.cds_WorkerStationList.FieldByName('Worker_ID').AsString;
//      i:= Pos('(',sOperator);
//      j:= Pos(')',sOperator);
//      sOperator := Copy(sOperator,i+1,j-i-1);
//      cbQualityOperator.ItemIndex := cbQualityOperator.Items.IndexOf(sOperator);
//    end;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TSendSCInfoForm.GetSendNoteInfo;
var vData: OleVariant;
  sCondition,sErrorMsg,sDestination: WideString;
begin
    sCondition := QuotedStr(sDestination)+',' + QuotedStr(Login.CurrentDepartment)+','+IntToStr(3);
    FNMServerObj.GetQueryData(vData,'GetSendInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsSendInfo.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxgrdtvSendInfo, dsSendInfo);
end;

procedure TSendSCInfoForm.GetData;
begin
  GetSendInfo;
  GetSendNoteInfo;
end;

procedure TSendSCInfoForm.SaveSendInfo;
var i: Integer;
   sCondition,sFNCardList, sStepNOList,sNote_NO,sOperator, sErrorMsg: WideString;
begin
  inherited;
  try
    if lvDestinate.Items.Count = 0 then Exit;

    ShowMsg('正在保存数据稍等！', crHourGlass);

    sOperator := Login.LoginName;


    sFNCardList := '';
    sStepNOList:='';
    for i := 0 to lvDestinate.Items.Count - 1 do
    begin
      sFNCardList := sFNCardList + lvDestinate.Items[i].Caption + ',';
      sStepNOList := sStepNOList + lvDestinate.Items[i].SubItems[3] + ',';
    end;
    sFNCardList := LeftStr(sFNCardList, Length(sFNCardList) - 1);
    sStepNOList := LeftStr(sStepNOList, Length(sStepNOList) - 1);

    sCondition :=  QuotedStr(sFNCardList)+',' + QuotedStr(sStepNOList)+','+ QuotedStr(Login.CurrentDepartment)+',' +
                 QuotedStr(sOperator);
    FNMServerObj.SaveDataBySQLEx('SaveSCSendInfo',sCondition,sNote_NO,sErrorMsg);
   //  FNMServerObj.SaveSendInfo(sFNCardList, sDestination, , sOperator, 0,sNote_NO, sErrorMsg);

    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      exit;
    end;

//    for i := 0 to lvDestinate.Items.Count - 1 do
//    begin
//      while cdsSendInfo.Locate('FN_Card;step_no', VarArrayOf([lvDestinate.Items[i].Caption,lvDestinate.Items[i].SubItems[3]]), []) do
//        cdsSendInfo.Delete;
//    end;

    lvDestinate.Items.Clear;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
      //打印送布单
//  if not Assigned(SendInfoReport) then
//    SendInfoReport := TSendInfoReport.Create(nil);
//  SendInfoReport.PreviewReport(sNote_No,True);
end;

procedure TSendSCInfoForm.SaveData;
begin
  SaveSendInfo;
end;

procedure TSendSCInfoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TSendSCInfoForm.FormDestroy(Sender: TObject);
begin
  inherited;
  SendSCInfoForm := nil;
end;

procedure TSendSCInfoForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetData;
end;

procedure TSendSCInfoForm.btnRightClick(Sender: TObject);
begin
  TGlobal.MoveDataEx(lvSource,lvDestinate,0,nil,edtQuantitySource,nil,edtQuantityDestinate);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TSendSCInfoForm.btnRightAllClick(Sender: TObject);
begin
  TGlobal.MoveDataEx(lvSource,lvDestinate,0,nil,edtQuantitySource,nil,edtQuantityDestinate,True);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TSendSCInfoForm.btnLeftClick(Sender: TObject);
begin
  TGlobal.MoveDataEx(lvDestinate,lvSource,0,nil,edtQuantityDestinate, nil, edtQuantitySource);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TSendSCInfoForm.btnLeftAllClick(Sender: TObject);
begin
  TGlobal.MoveDataEx(lvDestinate,lvSource,0,nil,edtQuantityDestinate, nil, edtQuantitySource,True);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TSendSCInfoForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData;
end;

procedure TSendSCInfoForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TSendSCInfoForm.lvSourceDblClick(Sender: TObject);
begin
  TGlobal.MoveDataEx(lvSource,lvDestinate,0,nil,edtQuantitySource,nil,edtQuantityDestinate);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;



procedure TSendSCInfoForm.lvDestinateDblClick(Sender: TObject);
begin
  TGlobal.MoveDataEx(lvDestinate,lvSource,0,nil,edtQuantityDestinate, nil, edtQuantitySource);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;


procedure TSendSCInfoForm.lvSourceColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  inherited;
  TGlobal.SortListView(lvSource, Column);
end;

procedure TSendSCInfoForm.lvDestinateColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  inherited;
  TGlobal.SortListView(lvDestinate, Column);
end;

procedure TSendSCInfoForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize;
end;

procedure TSendSCInfoForm.lvSourceKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    TGlobal.MoveDataEx(lvSource,lvDestinate,0,nil,edtQuantitySource, nil,edtQuantityDestinate);
    TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
  end;
end;

procedure TSendSCInfoForm.lvDestinateKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    TGlobal.MoveDataEx(lvDestinate,lvSource,0,nil,edtQuantityDestinate, nil, edtQuantitySource);
    TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
  end;
end;

procedure TSendSCInfoForm.lvDestinateCustomDraw(Sender: TCustomListView;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
  inherited;
  btnSave.Enabled := lvDestinate.Items.Count>0;
end;

procedure TSendSCInfoForm.cbbDestinateChange(Sender: TObject);
begin
  inherited;
  GetData();
end;

//procedure TSendSCInfoForm.FiltercxGridTableView(FildName, FilterValue: String);
//begin
//  with cxgridtvSendInfo, DataController.Filter do
//  begin
//    BeginUpdate;
//    try
//      Root.Clear;
//      Root.AddItem(cxgridtvSendInfo.GetColumnByFieldName(FildName), foEqual, FilterValue, FilterValue);
//      if not Active then
//        Active:=true;
//    finally
//      EndUpdate;
//    end;
//  end;
//end;

procedure TSendSCInfoForm.lvSourceChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  inherited;
  if lvSource.ItemIndex < 0 then Exit;
  //FiltercxGridTableView('FN_Card', lvSource.Items[lvSource.ItemIndex].Caption);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TSendSCInfoForm.lvDestinateChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  inherited;
  if lvDestinate.ItemIndex < 0 then Exit;
  //FiltercxGridTableView('FN_Card', lvDestinate.Items[lvDestinate.ItemIndex].Caption);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;



procedure TSendSCInfoForm.FormActivate(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
  //刷新界面数据
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
  btnRefresh.Click;
  OnActivate:=nil;
end;

procedure TSendSCInfoForm.btnSbClick(Sender: TObject);
var
  i:Integer;
  sCondition,sNoteNoList, sStepNOList,sNote_NO,sOperator, sErrorMsg: WideString;
begin
  inherited;

  with cxgrdtvSendInfo do
  begin
    for i :=Controller.SelectedRowCount - 1 downto 0 do
    begin
      sNoteNoList := sNoteNoList + Controller.SelectedRows[i].Values[GetColumnByFieldName('Note_no').Index] + ',';
    end;
  end;
  sStepNOList := '';
  sCondition :=  QuotedStr(sNoteNoList)+',' + QuotedStr(sStepNOList)+','+ QuotedStr(Login.CurrentDepartment)+',' +
                 QuotedStr(sOperator);
    FNMServerObj.SaveDataBySQLEx('SaveSCSendInfo',sCondition,sNote_NO,sErrorMsg);
   //  FNMServerObj.SaveSendInfo(sFNCardList, sDestination, , sOperator, 0,sNote_NO, sErrorMsg);

    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      exit;
    end;

//    for i := 0 to lvDestinate.Items.Count - 1 do
//    begin
//      while cdsSendInfo.Locate('FN_Card;step_no', VarArrayOf([lvDestinate.Items[i].Caption,lvDestinate.Items[i].SubItems[3]]), []) do
//        cdsSendInfo.Delete;
//    end;

    lvDestinate.Items.Clear;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
end;

end.
