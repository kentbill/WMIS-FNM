unit frmAnalysisOTD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, cxSplitter, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, cxTextEdit, cxContainer, cxCheckBox;

type
  TAnalysisOTDForm = class(TBaseForm)
    pnl_Only: TPanel;
    btn_Help: TSpeedButton;
    btn_Query: TSpeedButton;
    btn_Save: TSpeedButton;
    btn_Exit: TSpeedButton;
    btn_Delete: TSpeedButton;
    txt_Only: TStaticText;
    dtpDate: TDateTimePicker;
    pnl_Only1: TPanel;
    cxgridOTDDtl: TcxGrid;
    cxgridtvOTDDtl: TcxGridDBTableView;
    cxGridlOTDDtl: TcxGridLevel;
    txt2: TStaticText;
    pnl2: TPanel;
    btnAddItem: TSpeedButton;
    btnDeleteItem: TSpeedButton;
    btnCopyClipData: TSpeedButton;
    btnPasteClipData: TSpeedButton;
    btnClearClipData: TSpeedButton;
    cxgridOTDHdr: TcxGrid;
    cxgridtvOTDHdr: TcxGridDBTableView;
    cxGridlOTDHdr: TcxGridLevel;
    txt1: TStaticText;
    cxspl1: TcxSplitter;
    cdsOTDDtl: TClientDataSet;
    dsOTDDtl: TDataSource;
    cdsOTDHdr: TClientDataSet;
    dsOTDHdr: TDataSource;
    cds_JobTrance: TClientDataSet;
    cdsClipData: TClientDataSet;
    cxcbPD: TcxCheckBox;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_QueryClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure dtpDateChange(Sender: TObject);
    procedure DataChange(Sender: TObject);
    procedure cdsOTDHdrAfterScroll(DataSet: TDataSet);
    procedure cdsOTDDtlAfterEdit(DataSet: TDataSet);
    procedure btnAddItemClick(Sender: TObject);
    procedure btnCopyClipDataClick(Sender: TObject);
    procedure btnPasteClipDataClick(Sender: TObject);
    procedure btnClearClipDataClick(Sender: TObject);
    procedure cxgridtvOTDDtlKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDeleteItemClick(Sender: TObject);
  private
    { private declarations }
    procedure GetAnalysisData;
    procedure SetDataSetProperty;

    {* 设置控件的Edit Control Enabled属性}
    procedure GetOperationList(Sender: TObject);
    procedure SetStepNO(Sender: TField; const Text: String);
    procedure SetRemark(Sender: TField; const Text: String);
    procedure GetOperators(FN_Card, Current_Department,MachineID, EndTime: String; Step_NO, OperationTimes, KeyValue: Integer; Quantity: Single);
    procedure MergeDataSet(FirstDataSet, SecondDataSet: TClientDataSet);
  public
    { Public declarations }
  end;

var
  AnalysisOTDForm: TAnalysisOTDForm;

implementation

uses cxDropDownEdit, uDictionary, uFNMArtInfo, UAppOption,
    ServerDllPub, uFNMResource, StrUtils, uLogin, UGridDecorator,
  uShowMessage, frmInput, uGlobal;

{$R *.dfm}

procedure TAnalysisOTDForm.FormDestroy(Sender: TObject);
begin
  AnalysisOTDForm:=nil;
end;

procedure TAnalysisOTDForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TAnalysisOTDForm.FormCreate(Sender: TObject);
begin
  btn_Query.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btn_Help.Glyph.LoadFromResourceName(HInstance, RES_HELPABOUT);
  btn_Save.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  dtpDate.Date := Now-1;
  btn_Save.Enabled:=False;
end;

procedure TAnalysisOTDForm.GetOperationList(Sender: TObject);
var
  vData: OleVariant;
  sErrorMsg: WideString;
  FN_Card: String;
begin
  //加载工序列表
  FN_Card := cdsOTDHdr.FieldByName('FN_Card').AsString;
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

procedure TAnalysisOTDForm.GetAnalysisData;
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  try
    cdsOTDHdr.DisableControls;
    sCondition := QuotedStr(DateToStr(dtpDate.Date)) + ','+QuotedStr(Login.CurrentDepartment)+ ',0';
    if cxcbPD.Checked then
      sCondition := sCondition+',1';
    FNMServerObj.GetQueryData(vData,'GetOTDAnalysisData',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_GetAnalysisData, [sErrorMsg]);

    cdsOTDHdr.Data:=vData[0];
    cdsOTDDtl.Data:=vData[1];
    //构建 Copy Data 模板
    cdsClipData.Data := vData[1];
    cdsClipData.EmptyDataSet;
    cdsClipData.FieldByName('Iden').ReadOnly := False;

    GridDecorator.BindCxViewWithDataSource(cxgridtvOTDHdr, dsOTDHdr);
    GridDecorator.BindCxViewWithDataSource(cxgridtvOTDDtl, dsOTDDtl);
  finally
    cdsOTDHdr.EnableControls;
  end;
end;

procedure TAnalysisOTDForm.SetDataSetProperty;
var
  i: Integer;
begin
  cdsOTDHdr.FieldByName('Step_NO').OnSetText:=SetStepNO;
  cdsOTDHdr.FieldByName('Remark').OnSetText:=SetRemark;
  cdsOTDHdr.FieldByName('Iden').Visible:=false;

  for i := 0 to cxgridtvOTDHdr.ColumnCount - 1 do
    cxgridtvOTDHdr.Columns[i].Options.Editing:=false;
  cxgridtvOTDHdr.GetColumnByFieldName('Iden').Visible:=false;
  for i := 0 to cxgridtvOTDDtl.ColumnCount - 1 do
    cxgridtvOTDDtl.Columns[i].Options.Editing:=false;

  cxgridtvOTDDtl.GetColumnByFieldName('Analysis_ID').Visible:=false;
  cxgridtvOTDDtl.GetColumnByFieldName('Iden').Visible:=false;
  cxgridtvOTDDtl.GetColumnByFieldName('Worker_ID').Visible:=false;
  cxgridtvOTDDtl.GetColumnByFieldName('Monitor_ID').Visible:=false;
  
  with cxgridtvOTDHdr do
  begin
    //工序代码
    with GetColumnByFieldName('Step_NO') do
    begin
      Options.Editing:=true;
      PropertiesClassName:='TcxComboBoxProperties';
      (Properties as TcxComboBoxProperties).OnInitPopup :=GetOperationList;
    end; 
    with GetColumnByFieldName('Remark') do
    begin
      Options.Editing:=true;
    end;
    with GetColumnByFieldName('FN_Card') do
    begin
      Options.Editing:=true;
    end;
  end;
end;

procedure TAnalysisOTDForm.btn_QueryClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    GetAnalysisData;
    SetDataSetProperty;
  finally
    Screen.Cursor :=  crDefault;
  end;
end;

procedure TAnalysisOTDForm.btn_DeleteClick(Sender: TObject);
var
  sErrorMsg: WideString;
begin
{
  if (not cdsOTDHdr.Active) or (cdsOTDHdr.IsEmpty) then exit;
  if MessageDlg('你确认要删除OTD记录吗?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在删除数据稍等！', crHourGlass);
    FNMServerArtObj.DeleteInnerRepairInfo(cdsOTDHdr.FieldByName('Analysis_ID').AsInteger,Login.LoginName,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsOTDHdr.Delete;
    TMsgDialog.ShowMsgDialog('删除数据成功',mtInformation);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;
}  
end;

procedure TAnalysisOTDForm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TAnalysisOTDForm.btn_SaveClick(Sender: TObject);
var
  sErrMsg: WideString;
  vData1, vData2:OleVariant;
begin
  if TGlobal.DeltaIsNull(cdsOTDDtl) then Exit;
  try
    vData1 := cdsOTDHdr.Delta;
    vData2 := cdsOTDDtl.Delta;
    FNMServerObj.SaveMultiData('fnOTDAnalysisHdr', 'fnOTDAnalysisDtl', vData1, vData2, '','','','', sErrMsg);
    if sErrMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_SaveAnalysisQualtityData, [sErrMsg]);    
    TMsgDialog.ShowMsgDialog('保存数据成功',mtInformation);
  finally
    cdsOTDHdr.MergeChangeLog;
    cdsOTDDtl.MergeChangeLog;
    cdsOTDHdr.EmptyDataSet;
    cdsOTDDtl.EmptyDataSet;
    btn_Save.Enabled:=false;
  end;
end;

procedure TAnalysisOTDForm.dtpDateChange(Sender: TObject);
begin
  if cdsOTDHdr.Active then
    cdsOTDHdr.EmptyDataSet;
  if cdsOTDDtl.Active then
    cdsOTDDtl.EmptyDataSet;
end;

procedure TAnalysisOTDForm.DataChange(Sender: TObject);
begin
  // btn_Edit.Enabled:=true;
end;

procedure TAnalysisOTDForm.SetStepNO(Sender: TField; const Text: String);
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
                 RightStr(TempStr, 19), Sender.Value, OperationTimes, FieldByName('Iden').AsInteger, FieldByName('FN_Card_Count').AsInteger);
  end
  else
  begin
    Sender.Clear;
    FieldByName('Operation_CHN').Clear;
    Iden := cdsOTDDtl.FieldByName('Analysis_ID').AsInteger;
    if Iden > 0 then
      while cdsOTDDtl.Locate('Analysis_ID',Iden,[]) do
        cdsOTDDtl.Delete;
  end;

  Sender.DataSet.FieldByName('Operator').AsString:=login.LoginName;
  Sender.DataSet.FieldByName('Operate_Time').AsDateTime:=Now;
end;

procedure TAnalysisOTDForm.SetRemark(Sender: TField; const Text: String);
begin
  Sender.DataSet.FieldByName('Operator').AsString:=login.LoginName;
  Sender.DataSet.FieldByName('Operate_Time').AsDateTime:=Now;
  Sender.Value:= Text;
end;

procedure TAnalysisOTDForm.GetOperators(FN_Card, Current_Department, MachineID, EndTime: String; Step_NO, OperationTimes, KeyValue: Integer; Quantity: Single);
var
  i: Integer;
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  //添加用户选定工序的人员
  if MachineID = '' then exit;
  sCondition := QuotedStr(FN_Card) + ',' + IntToStr(Step_NO)+ ',' +
                IntToStr(OperationTimes)+ ',' + QuotedStr(MachineID)   + ',' +
                QuotedStr(Current_Department) +','+ QuotedStr(EndTime);
  FNMServerObj.GetQueryData(vData,'GetOTDAnalysisWorker',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetOperators, [sErrorMsg]);

  TempClientDataSet.Data:=vData;
  if TempClientDataSet.IsEmpty then
    raise Exception.CreateRes(@EMP_Operators);

  TempClientDataSet.FieldByName('Iden').ReadOnly:=false;
  for i := 0 to TempClientDataSet.RecordCount - 1 do
  begin
    if cdsOTDDtl.Locate('Worker_ID', TempClientDataSet.FieldByName('Worker_Name').AsString, []) then
      TempClientDataSet.Delete
    else
    begin
      TempClientDataSet.Edit;
      TempClientDataSet.FieldByName('Analysis_ID').Value:=KeyValue;
      TempClientDataSet.Next;
    end;
  end;
  MergeDataSet(cdsOTDDtl, TempClientDataSet);
//  cdsOTDDtl.MergeChangeLog;
end;

procedure TAnalysisOTDForm.MergeDataSet(FirstDataSet, SecondDataSet: TClientDataSet);
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
      if FirstDataSet.Fields.Fields[j].FieldName<>'Iden' then
        FirstDataSet.Fields.Fields[j].Value:=SecondDataSet.Fields.Fields[j].Value;
    SecondDataSet.Next;
  end;
end;

procedure TAnalysisOTDForm.cdsOTDHdrAfterScroll(
  DataSet: TDataSet);
var
  IdenValue: Integer;
begin
  if DataSet.ControlsDisabled then Exit;

  IdenValue:=DataSet.FieldByName('Iden').AsInteger;
  cdsOTDDtl.Filter:=Format('Analysis_ID = %d', [IdenValue]);
  cdsOTDDtl.Filtered:=True;
end;

procedure TAnalysisOTDForm.cdsOTDDtlAfterEdit(DataSet: TDataSet);
begin
  btn_Save.Enabled:=true;
end;

procedure TAnalysisOTDForm.btnAddItemClick(Sender: TObject);
var
  i, Iden,Analysis_ID: Integer;
  StrWorkerList,StrMonitorList,StrWorker,StrMonitor,WorkerID,WorkerName,MonitorID,MonitorName: String;
begin
  if (not cdsOTDDtl.Active) or (not cdsOTDDtl.Filtered) then Exit;  // (cdsOTDDtl.RecordCount = 0)
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
  if not cdsOTDDtl.IsEmpty then
  begin
    Analysis_ID := cdsOTDDtl['Analysis_ID'];
  end
  else
  begin
    Analysis_ID := cdsOTDHdr.FieldByName('Iden').AsInteger;
  end;
  for i := 0 to cdsOTDDtl.Fields.Count - 1 do
    cdsOTDDtl.Fields.Fields[i].ReadOnly := False;
  with cdsOTDDtl do
  begin
    if Locate('Worker_ID',WorkerID,[]) then Exit;
    Append;
    cdsOTDDtl['Analysis_ID'] := Analysis_ID;
    cdsOTDDtl['Worker_ID'] := WorkerID;
    cdsOTDDtl['Worker_Name'] := WorkerName;
    cdsOTDDtl['Monitor_Name'] := MonitorName;
    cdsOTDDtl['Monitor_ID'] := MonitorID;
  end;
end;

procedure TAnalysisOTDForm.btnDeleteItemClick(Sender: TObject);
begin
  with cdsOTDDtl do
  begin
    if (not Active) or (RecordCount = 0) then Exit;
    Delete;
  end;
end;

procedure TAnalysisOTDForm.btnCopyClipDataClick(Sender: TObject);
var
  i, j: Integer;
  Worker_ID: string;
Begin
  if cxgridtvOTDDtl.Controller.SelectedRowCount = 0 then Exit;
  try
    cdsOTDDtl.DisableControls;
    if not cdsClipData.IsEmpty then cdsClipData.EmptyDataSet;
    for i := cxgridtvOTDDtl.Controller.SelectedRowCount - 1 downto 0 do
    begin
      with cxgridtvOTDDtl do
         Worker_ID := Controller.SelectedRows[i].Values[GetColumnByFieldName('Worker_ID').Index];

      if cdsOTDDtl.Locate('Worker_ID', Worker_ID, []) then
      begin
        cdsClipData.Append;
        for j:= 0 to cdsOTDDtl.FieldCount - 1 do
          cdsClipData.Fields[j].Value := cdsOTDDtl.Fields[j].Value;
      end
      else
        TMsgDialog.ShowMsgDialog('不能定位这个工人！', mtWarning);
    end;
  finally
    cdsOTDDtl.EnableControls;
  end;
  cdsClipData.Tag := cdsOTDHdr.FieldByName('Step_NO').AsInteger;
  cdsClipData.Filter := cdsOTDHdr.FieldByName('Operation_CHN').AsString;
  cdsClipData.CheckBrowseMode;
  btnPasteClipData.Enabled := not cdsClipData.IsEmpty;
  btnClearClipData.Enabled := btnPasteClipData.Enabled ;
end;

procedure TAnalysisOTDForm.btnPasteClipDataClick(Sender: TObject);
var
  i, Analysis_ID: Integer;
Begin
  if cdsClipData.IsEmpty then Exit;
  Analysis_ID := cdsOTDHdr.FieldByName('Iden').AsInteger;
  if (Analysis_ID < 0) then Exit;

  for i := 0 to cdsOTDDtl.Fields.Count - 1 do
    cdsOTDDtl.Fields.Fields[i].ReadOnly := False;
    
  cdsClipData.First;
  while not cdsClipData.Eof do
  begin
    if not cdsOTDDtl.Locate('Worker_ID',cdsClipData.FieldByName('Worker_ID').AsString,[]) then
    begin
      cdsOTDDtl.Append;
      for i:= 0 to cdsClipData.FieldCount - 1 do
        cdsOTDDtl.Fields[i].Value := cdsClipData.Fields[i].Value;
      cdsOTDDtl.FieldByName('Analysis_ID').AsInteger := Analysis_ID;
    end;
    cdsClipData.Next;
  end;
  cdsOTDHdr.Edit;
  cdsOTDHdr.FieldByName('Step_NO').AsInteger := cdsClipData.Tag;
  cdsOTDHdr.FieldByName('Operation_CHN').AsString := cdsClipData.Filter;
  cdsOTDHdr.FieldByName('Operator').AsString := login.LoginName;
  cdsOTDHdr.FieldByName('Operate_Time').AsDateTime := Now;
  cdsOTDHdr.Post;
  cdsOTDDtl.CheckBrowseMode;
end;

procedure TAnalysisOTDForm.btnClearClipDataClick(Sender: TObject);
begin
  if not cdsClipData.IsEmpty then cdsClipData.EmptyDataSet;
  btnPasteClipData.Enabled := False;;
  btnClearClipData.Enabled := btnPasteClipData.Enabled ;
end;

procedure TAnalysisOTDForm.cxgridtvOTDDtlKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 case key of
   Word('C'): if Shift = [ssCtrl] then btnCopyClipData.Click;
   Word('V'): if Shift = [ssCtrl] then btnPasteClipData.Click;
 end;
end;
end.





