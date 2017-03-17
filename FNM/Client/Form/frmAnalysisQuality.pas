unit frmAnalysisQuality;
{*|<PRE>*****************************************************************************

       软件名称 FNM CLIENT MODEL                                               
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                              
       单元名称 frmAnalysisQuality.pas
       创建日期 2004-10-13 15:47:43                                            
       创建人员 lvzd                                                           
       修改人员                                                                
       修改日期                                                                
       修改原因                                                                
       对应用例                                                                
       字段描述                                                                
       相关数据库表                                                            
       调用重要函数/SQL对象说明                                                
       功能描述 分析返工,C级,降等质量事故的工序.
                                                                              
******************************************************************************}

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs, DB,
  DBClient, cxSplitter, StdCtrls, ComCtrls, Buttons, ExtCtrls, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, Grids,
  DBGrids;

type
  TAnalysisQualityForm = class(TForm)
    cds_FabricData: TClientDataSet;
    cds_DutyData: TClientDataSet;
    ds_FabricData: TDataSource;
    ds_DutyData: TDataSource;
    cds_JobTrance: TClientDataSet;
    btn_Help: TSpeedButton;
    btn_Query: TSpeedButton;
    btn_Save: TSpeedButton;
    btn_Exit: TSpeedButton;
    txt_Only: TStaticText;
    pnl_Only: TPanel;
    pnl_Only1: TPanel;
    cxgrid2: TcxGrid;
    cxgridtv_DutyData: TcxGridDBTableView;
    cxGridl_DutyData: TcxGridLevel;
    txt2: TStaticText;
    cxgrid_FabricData: TcxGrid;
    cxgridtv_FabricData: TcxGridDBTableView;
    cxGridl_FabricData: TcxGridLevel;
    txt1: TStaticText;
    cxspl1: TcxSplitter;
    btn_Delete: TSpeedButton;
    pnl2: TPanel;
    btnAddItem: TSpeedButton;
    btnDeleteItem: TSpeedButton;
    dtp_Analysis: TDateTimePicker;
    btnCopyClipData: TSpeedButton;
    btnPasteClipData: TSpeedButton;
    cdsClipData: TClientDataSet;
    btnClearClipData: TSpeedButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_QueryClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure dtp_AnalysisChange(Sender: TObject);
    procedure DataChange(Sender: TObject);
    procedure cds_FabricDataAfterScroll(DataSet: TDataSet);
    procedure cds_DutyDataAfterEdit(DataSet: TDataSet);
    procedure btnAddItemClick(Sender: TObject);
    procedure btnCopyClipDataClick(Sender: TObject);
    procedure btnPasteClipDataClick(Sender: TObject);
    procedure btnClearClipDataClick(Sender: TObject);
    procedure cxgridtv_DutyDataKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDeleteItemClick(Sender: TObject);
  private
    { private declarations }
    procedure GetAnalysisData;
    procedure SetDataSetProperty;

    {* 设置控件的Edit Control Enabled属性}
    procedure GetOperationList(Sender: TObject);
    procedure SetStepNO(Sender: TField; const Text: String);
    procedure SetDefectCode(Sender: TField; const Text: String);
    procedure GetOperators(FN_Card, Current_Department,MachineID, EndTime: String; Step_NO, OperationTimes, KeyValue: Integer; Quantity: Single);
    procedure MergeDataSet(FirstDataSet, SecondDataSet: TClientDataSet);
  public
    { Public declarations }
  end;

var
  AnalysisQualityForm: TAnalysisQualityForm;

implementation

uses SysUtils, Variants, cxDropDownEdit, uDictionary, uFNMArtInfo, UAppOption,
    ServerDllPub, uFNMResource, StrUtils, uLogin, UGridDecorator,
  uShowMessage, frmInput;

{$R *.dfm}

procedure TAnalysisQualityForm.FormDestroy(Sender: TObject);
begin
  AnalysisQualityForm:=nil;
end;

procedure TAnalysisQualityForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TAnalysisQualityForm.FormCreate(Sender: TObject);
begin
  btn_Query.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btn_Help.Glyph.LoadFromResourceName(HInstance, RES_HELPABOUT);
  btn_Save.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  dtp_Analysis.Date := Now-1;
  btn_Save.Enabled:=False;
end;

procedure TAnalysisQualityForm.GetOperationList(Sender: TObject);
var
  vData: OleVariant;
  sErrorMsg: WideString;
  FN_Card: String;
begin
  //加载工序列表
  FN_Card := cds_FabricData.FieldByName('FN_Card').AsString;
  if FN_Card = '' then Exit;
  if (not cds_JobTrance.Active) or (not cds_JobTrance.Locate('FN_Card', FN_Card, [])) then
  begin
    FNMServerArtObj.GetOperationListByFN_Card(FN_Card, vData, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_GetCurCardOperationList, [sErrorMsg]);

    TempClientDataSet.Data:=vData;
    if TempClientDataSet.IsEmpty then
      raise Exception.CreateRes(@EMP_OperationList);
    MergeDataSet(cds_JobTrance, TempClientDataSet);
    TempClientDataSet.Close;
  end;
  cds_JobTrance.Filter:=Format('FN_Card = ''%s''', [FN_Card]);
  try
    cds_JobTrance.Filtered:=true;
    FillItemsFromDataSet(cds_JobTrance, 'Step_NO', 'Operation_CHN', 'Operation_Times', '->', (Sender as TcxComboBox).Properties.Items, True);
  finally
    cds_JobTrance.Filtered:=false;
  end;
end;

procedure TAnalysisQualityForm.GetAnalysisData;
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  try
    cds_FabricData.DisableControls;
    sCondition := QuotedStr(DateToStr(dtp_Analysis.Date)) + ','+QuotedStr(Login.CurrentDepartment);
    FNMServerObj.GetQueryData(vData,'GetDefectAnalysisData',sCondition,sErrorMsg);
//    FNMServerObj.GetTheMatterFabric(Login.CurrentDepartment, dtp_Analysis.Date, vData0, vData1, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_GetAnalysisData, [sErrorMsg]);

    cds_FabricData.Data:=vData[0];
    cds_DutyData.Data:=vData[1];
    //构建 Copy Data 模板
    cdsClipData.Data := vData[1];
    cdsClipData.EmptyDataSet;
    cdsClipData.FieldByName('Iden').ReadOnly := False;

    GridDecorator.BindCxViewWithDataSource(cxgridtv_FabricData, ds_FabricData);
    GridDecorator.BindCxViewWithDataSource(cxgridtv_DutyData, ds_DutyData);
  finally
    cds_FabricData.EnableControls;
  end;
end;

procedure TAnalysisQualityForm.SetDataSetProperty;
var
  i: Integer;
begin
  cds_FabricData.FieldByName('Step_NO').OnSetText:=SetStepNO;
  cds_FabricData.FieldByName('Defect_Code').OnSetText:=SetDefectCode;
  cds_FabricData.FieldByName('Defect_Analysis_ID').Visible:=false;

  for i := 0 to cxgridtv_FabricData.ColumnCount - 1 do
    cxgridtv_FabricData.Columns[i].Options.Editing:=false;
  cxgridtv_FabricData.GetColumnByFieldName('Defect_Analysis_ID').Visible:=false;
  for i := 0 to cxgridtv_DutyData.ColumnCount - 1 do
    cxgridtv_DutyData.Columns[i].Options.Editing:=false;

  cxgridtv_DutyData.GetColumnByFieldName('Quantity').Options.Editing:=True;
  cxgridtv_DutyData.GetColumnByFieldName('Defect_Analysis_ID').Visible:=false;
  cxgridtv_DutyData.GetColumnByFieldName('Iden').Visible:=false;
  cxgridtv_DutyData.GetColumnByFieldName('Worker_ID').Visible:=false;
  cxgridtv_DutyData.GetColumnByFieldName('Monitor_ID').Visible:=false;
  with cxgridtv_FabricData do
  begin
    //疵点代码
    with GetColumnByFieldName('Defect_Code') do
    begin
      Options.Editing:=true;
      PropertiesClassName:='TcxComboBoxProperties';
      FillItemsFromDataSet(Dictionary.cds_RepairReasonList, 'Reason_Code', 'Reason_Info', '', '->', (Properties as TcxComboBoxProperties).Items);
    end;
    //责任类型
    with GetColumnByFieldName('Quality_Type') do
    begin
      Options.Editing:=true;
      PropertiesClassName:='TcxComboBoxProperties';
      with Properties as TcxComboBoxProperties do
      begin
        Items.Add('工艺');
        Items.Add('操作');
        Items.Add('外部');
        Items.Add('QI');
      end;    
    end;
    //工序代码
    with GetColumnByFieldName('Step_NO') do
    begin
      Options.Editing:=true;
      PropertiesClassName:='TcxComboBoxProperties';
      (Properties as TcxComboBoxProperties).OnInitPopup :=GetOperationList;
    end;
    with GetColumnByFieldName('FN_Card') do
    begin
      Options.Editing:=true;
    end;
  end;
end;

procedure TAnalysisQualityForm.btn_QueryClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  GetAnalysisData;
  SetDataSetProperty;
  Screen.Cursor :=  crDefault
end;

procedure TAnalysisQualityForm.btn_DeleteClick(Sender: TObject);
var
  sErrorMsg: WideString;
begin
  if (not cds_FabricData.Active) or (cds_FabricData.IsEmpty) then exit;
  if MessageDlg('你确认要删除内回修记录吗?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在删除数据稍等！', crHourGlass);
    FNMServerArtObj.DeleteInnerRepairInfo(cds_fabricData.FieldByName('Defect_Analysis_ID').AsInteger,Login.LoginName,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cds_FabricData.Delete;
    TMsgDialog.ShowMsgDialog('删除数据成功',mtInformation);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;
end;

procedure TAnalysisQualityForm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TAnalysisQualityForm.btn_SaveClick(Sender: TObject);
var
  sErrorMsg: WideString;
begin
  cds_FabricData.MergeChangeLog;
  cds_DutyData.MergeChangeLog;
  FNMServerArtObj.SaveAnalysisQualtityData(cds_FabricData.Data, cds_DutyData.Data,
                                           dtp_Analysis.Date, Login.CurrentDepartment, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveAnalysisQualtityData, [sErrorMsg]);
    
  cds_FabricData.EmptyDataSet;
  cds_DutyData.EmptyDataSet;
  btn_Save.Enabled:=false;
end;

procedure TAnalysisQualityForm.dtp_AnalysisChange(Sender: TObject);
begin
  if cds_FabricData.Active then
    cds_FabricData.EmptyDataSet;
  if cds_DutyData.Active then
    cds_DutyData.EmptyDataSet;
end;

procedure TAnalysisQualityForm.DataChange(Sender: TObject);
begin
  // btn_Edit.Enabled:=true;
end;

procedure TAnalysisQualityForm.SetStepNO(Sender: TField; const Text: String);
var
  TempStr: string;
  Iden, OperationTimes: Integer;
begin
  with Sender.DataSet do
  if Text <> '' then
  begin
    if Sender.Value = LeftStr(Text, Pos('->', Text) - 1) then Exit;

    Sender.Value:=LeftStr(Text, Pos('->', Text) - 1);
    TempStr:=MidStr(Text, Pos('->', Text) + 2, MaxInt);
    FieldByName('Operation_CHN').Value:=LeftStr(TempStr, Pos('(', TempStr) - 1);

    TempStr:=MidStr(TempStr, Pos('(', TempStr) + 1, MaxInt);
    TempStr:=LeftStr(TempStr, Length(TempStr) - 1);
    //GET Operator

    OperationTimes:=1;
    GetOperators(FieldByName('FN_Card').AsString, LeftStr(TempStr,2), MidStr(TempStr,4, 4),
                 RightStr(TempStr, 19), Sender.Value, OperationTimes, FieldByName('Iden').AsInteger, FieldByName('Quantity').AsFloat);
  end
  else
  begin
   // if Sender.Value = '' then Exit;
    Sender.Clear;
    FieldByName('Operation_CHN').Clear;
    Iden := cds_DutyData.FieldByName('Iden').AsInteger;
    if Iden > 0 then
      while cds_DutyData.Locate('Iden',Iden,[]) do
        cds_DutyData.Delete;
   // GetOperators('', '','', '', 0, FieldByName('Iden').AsInteger, 0);
  end;

  Sender.DataSet.FieldByName('Operator').AsString:=login.LoginName;
  Sender.DataSet.FieldByName('Operate_Time').AsDateTime:=Now;
end;

procedure TAnalysisQualityForm.SetDefectCode(Sender: TField; const Text: String);
begin
  Sender.DataSet.FieldByName('Operator').AsString:=login.LoginName;
  Sender.DataSet.FieldByName('Operate_Time').AsDateTime:=Now;
  with Sender.DataSet do
  if Text <> '' then
  begin
    Sender.Value:=LeftStr(Text, Pos('->', Text) - 1);
    FieldByName('Defect_Name').Value:=MidStr(Text, Pos('->', Text) + 2, MAXINT);
  end else
  begin
    Sender.Clear;
    FieldByName('Defect_Name').Clear;
  end;
end;

procedure TAnalysisQualityForm.GetOperators(FN_Card, Current_Department, MachineID, EndTime: String; Step_NO, OperationTimes, KeyValue: Integer; Quantity: Single);
var
  i: Integer;
  lQuantity: Single;
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
//  删除原来的记录
//  cds_DutyData.Filter:=Format('Iden = %d', [KeyValue]);
//  try
//    cds_DutyData.Filtered:=True;
//    for i := 0 to cds_DutyData.RecordCount - 1 do
//    begin
//      cds_DutyData.Delete;
//      cds_DutyData.Next;
//    end;
//  finally
//    cds_DutyData.Filtered:=False;
//  end;

  //添加用户选定工序的人员
  if MachineID = '' then exit;
  sCondition := QuotedStr(FN_Card) + ',' + IntToStr(Step_NO)+ ',' +
                IntToStr(OperationTimes)+ ',' + QuotedStr(MachineID)   + ',' +
                QuotedStr(Current_Department) +','+ QuotedStr(EndTime);
  FNMServerObj.GetQueryData(vData,'GetDefectAnalysisWorker',sCondition,sErrorMsg);
//  FNMServerArtObj.GetDefectAnalysisWorker(Step_NO, OperationTimes, FN_Card, MachineID, EndTime, Current_Department, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetOperators, [sErrorMsg]);

  TempClientDataSet.Data:=vData;
  if TempClientDataSet.IsEmpty then
    raise Exception.CreateRes(@EMP_Operators);

  TempClientDataSet.FieldByName('Iden').ReadOnly:=false;
  lQuantity:=Quantity / TempClientDataSet.RecordCount;// -1();
  for i := 0 to TempClientDataSet.RecordCount - 1 do
  begin
    if cds_DutyData.Locate('Worker_ID', TempClientDataSet.FieldByName('Worker_Name').AsString, []) then
      TempClientDataSet.Delete
    else
    begin
      TempClientDataSet.Edit;
      TempClientDataSet.FieldByName('Iden').Value:=KeyValue;
      TempClientDataSet.FieldByName('Quantity').Value:=lQuantity;
      TempClientDataSet.Next;
    end;
  end;
  MergeDataSet(cds_DutyData, TempClientDataSet);
  cds_DutyData.MergeChangeLog;
end;

procedure TAnalysisQualityForm.MergeDataSet(FirstDataSet, SecondDataSet: TClientDataSet);
var
  i, j: Integer;
begin
  if not FirstDataSet.Active then
  begin
    FirstDataSet.Data:=SecondDataSet.Data;
    exit;
  end;

  for i := 0 to FirstDataSet.Fields.Count - 1 do
    FirstDataSet.Fields.Fields[i].ReadOnly:=false;

  SecondDataSet.First;
  for i := 0 to SecondDataSet.RecordCount - 1 do
  begin
    FirstDataSet.Append;
    for j := 0 to FirstDataSet.Fields.Count - 1 do
      FirstDataSet.Fields.Fields[j].Value:=SecondDataSet.Fields.Fields[j].Value;
    SecondDataSet.Next;
  end;
end;

procedure TAnalysisQualityForm.cds_FabricDataAfterScroll(
  DataSet: TDataSet);
var
  IdenValue: Integer;
begin
  if DataSet.ControlsDisabled then Exit;

  IdenValue:=DataSet.FieldByName('Iden').AsInteger;
  cds_DutyData.Filter:=Format('Iden = %d', [IdenValue]);
  cds_DutyData.Filtered:=True;

{
  with cxgridtv_DutyData.DataController, cxgridtv_DutyData.DataController.Filter do
  try
    BeginUpdate;
    Root.Clear;
    //构造主表关键字段值
    Root.AddItem(GetItemByFieldName('Iden'), foEqual, IdenValue, IntToStr(IdenValue));
    if not Active then
      Active:=true;
  finally
    EndUpdate;
  end;
}
end;

procedure TAnalysisQualityForm.cds_DutyDataAfterEdit(DataSet: TDataSet);
begin
  btn_Save.Enabled:=true;
end;

procedure TAnalysisQualityForm.btnAddItemClick(Sender: TObject);
var
  i, Iden,Defect_Analysis_ID: Integer;
  StrWorkerList,StrMonitorList,StrWorker,StrMonitor,WorkerID,WorkerName,MonitorID,MonitorName: String;
begin
  if (not cds_DutyData.Active) or (not cds_DutyData.Filtered) then Exit;  // (cds_DutyData.RecordCount = 0)
  if (StrWorkerList = '') or (StrMonitorList = '') then
  begin
    with Dictionary.cds_WorkerList do
    begin
      Filtered := False;
      Filter := 'Department = '+QuotedStr(Login.CurrentDepartment);
      Filtered := True;
      StrWorkerList := '0000000->无'+#13;
      StrMonitorList := '0000000->无'+#13;
      First;
      while not Eof do
      begin
        if Pos('班长',FieldByName('Worker_Group').AsString) = 0 then
          StrWorkerList := StrWorkerList + FieldByName('Worker_ID').AsString + '->' + FieldByName('Worker_Name').AsString+#13
        else
          StrMonitorList := StrMonitorList + FieldByName('Worker_ID').AsString + '->' + FieldByName('Worker_Name').AsString+#13;
        Next;
      end;
    end;
  end;
  if not InputBoxEx(StrWorkerList,StrMonitorList,StrWorker,StrMonitor) then Exit;
  WorkerID := LeftStr(StrWorker,Pos('->',StrWorker)-1);
  WorkerName := Copy(StrWorker,Pos('->',StrWorker)+2,10);
  MonitorID := LeftStr(StrMonitor,Pos('->',StrMonitor)-1);
  MonitorName := Copy(StrMonitor,Pos('->',StrMonitor)+2,10);
  if (WorkerID = '0000000') and  (MonitorID = '0000000') then Exit;
  if (WorkerID = '') and  (MonitorID = '') then Exit;
  if not cds_DutyData.IsEmpty then
  begin
    Defect_Analysis_ID := cds_DutyData['Defect_Analysis_ID'];
    Iden := cds_DutyData['Iden'];
  end  else
  begin
    Iden := cds_FabricData.FieldByName('Iden').AsInteger;
    Defect_Analysis_ID := cds_FabricData.FieldByName('Defect_Analysis_ID').AsInteger;
  end;
  for i := 0 to cds_DutyData.Fields.Count - 1 do
    cds_DutyData.Fields.Fields[i].ReadOnly := False;
  with cds_DutyData do
  begin
    if Locate('Worker_ID',WorkerID,[]) then Exit;
    Append;
    cds_DutyData['Iden'] := Iden;
    cds_DutyData['Defect_Analysis_ID'] := Defect_Analysis_ID;
    cds_DutyData['Operate_Type'] := '进布';
    cds_DutyData['Worker_ID'] := WorkerID;
    cds_DutyData['Worker_Name'] := WorkerName;
    cds_DutyData['Monitor_Name'] := MonitorName;
    cds_DutyData['Monitor_ID'] := MonitorID;
    cds_DutyData['Quantity'] := 0.0;
  end;
end;

procedure TAnalysisQualityForm.btnDeleteItemClick(Sender: TObject);
begin
  with cds_DutyData do
  begin
    if (not Active) or (RecordCount = 0) then Exit;
    Delete;
  end;
end;

procedure TAnalysisQualityForm.btnCopyClipDataClick(Sender: TObject);
var
  i, j: Integer;
  Worker_ID: string;
Begin
  if cxgridtv_DutyData.Controller.SelectedRowCount = 0 then Exit;
  try
    cds_DutyData.DisableControls;
    if not cdsClipData.IsEmpty then cdsClipData.EmptyDataSet;
    for i := cxgridtv_DutyData.Controller.SelectedRowCount - 1 downto 0 do
    begin
      with cxgridtv_DutyData do
         Worker_ID := Controller.SelectedRows[i].Values[GetColumnByFieldName('Worker_ID').Index];

      if cds_DutyData.Locate('Worker_ID', Worker_ID, []) then
      begin
        cdsClipData.Append;
        for j:= 0 to cds_DutyData.FieldCount - 1 do
          cdsClipData.Fields[j].Value := cds_DutyData.Fields[j].Value;
      end
      else
        TMsgDialog.ShowMsgDialog('不能定位这个工人！', mtWarning);
    end;
  finally
    cds_DutyData.EnableControls;
  end;
  cdsClipData.Tag := cds_FabricData.FieldByName('Step_NO').AsInteger;
  cdsClipData.Filter := cds_FabricData.FieldByName('Operation_CHN').AsString;
  cdsClipData.CheckBrowseMode;
  btnPasteClipData.Enabled := not cdsClipData.IsEmpty;
  btnClearClipData.Enabled := btnPasteClipData.Enabled ;
end;

procedure TAnalysisQualityForm.btnPasteClipDataClick(Sender: TObject);
var
  i, Iden, Defect_Analysis_ID: Integer;
Begin
  if cdsClipData.IsEmpty then Exit;
  Iden := cds_FabricData.FieldByName('Iden').AsInteger;
  Defect_Analysis_ID := cds_FabricData.FieldByName('Defect_Analysis_ID').AsInteger;
  if (Defect_Analysis_ID < 0) or (Iden < 0) then Exit;

  for i := 0 to cds_DutyData.Fields.Count - 1 do
    cds_DutyData.Fields.Fields[i].ReadOnly := False;
    
  cdsClipData.First;
  while not cdsClipData.Eof do
  begin
    if not cds_DutyData.Locate('Worker_ID',cdsClipData.FieldByName('Worker_ID').AsString,[]) then
    begin
      cds_DutyData.Append;
      for i:= 0 to cdsClipData.FieldCount - 1 do
        cds_DutyData.Fields[i].Value := cdsClipData.Fields[i].Value;
      cds_DutyData.FieldByName('Iden').AsInteger := Iden;
      cds_DutyData.FieldByName('Defect_Analysis_ID').AsInteger := Defect_Analysis_ID;
    end;
    cdsClipData.Next;
  end;
  cds_FabricData.Edit;
  cds_FabricData.FieldByName('Step_NO').AsInteger := cdsClipData.Tag;
  cds_FabricData.FieldByName('Operation_CHN').AsString := cdsClipData.Filter;
  cds_FabricData.FieldByName('Operator').AsString := login.LoginName;
  cds_FabricData.FieldByName('Operate_Time').AsDateTime := Now;
  cds_FabricData.Post;
  cds_DutyData.CheckBrowseMode;
end;

procedure TAnalysisQualityForm.btnClearClipDataClick(Sender: TObject);
begin
  if not cdsClipData.IsEmpty then cdsClipData.EmptyDataSet;
  btnPasteClipData.Enabled := False;;
  btnClearClipData.Enabled := btnPasteClipData.Enabled ;
end;

procedure TAnalysisQualityForm.cxgridtv_DutyDataKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 case key of
   Word('C'): if Shift = [ssCtrl] then btnCopyClipData.Click;
   Word('V'): if Shift = [ssCtrl] then btnPasteClipData.Click;
 end;
end;

end.



