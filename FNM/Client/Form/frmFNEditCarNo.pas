unit frmFNEditCarNo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, Buttons, ExtCtrls, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, DBClient, StdCtrls, StrUtils, frmBase,
  Grids, DBGrids;

type
  TFNEditCarNoForm = class(TBaseForm)
    cxTVEditCarNO: TcxGridDBTableView;
    cxLEditCarNO: TcxGridLevel;
    cxGEditCarNO: TcxGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    SBtnExit: TSpeedButton;
    CDSEditCarNO: TClientDataSet;
    DSEditCarNOData: TDataSource;
    SBtnRefresh: TSpeedButton;
    chkLocalQuery: TCheckBox;
    Label1: TLabel;
    EdtNewLocation: TEdit;
    BtnEdit: TButton;
    Label2: TLabel;
    EctCarNo: TEdit;
    SBtnSave: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure SBtnExitClick(Sender: TObject);
    procedure chkLocalQueryClick(Sender: TObject);
    procedure SBtnRefreshClick(Sender: TObject);
    procedure SBtnSaveClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure CDSEditCarNOAfterScroll(DataSet: TDataSet);
    procedure EdtNewLocationKeyPress(Sender: TObject; var Key: Char);
    procedure cxTVEditCarNODataControllerFilterBeforeChange(
      Sender: TcxDBDataFilterCriteria; ADataSet: TDataSet;
      const AFilterText: String);
    procedure cxTVEditCarNOEditValueChanged(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem);
  private
    { Private declarations }
    procedure init;                                                             //初始化方法
    function GetEditCarNoData(aDepartment : string) : Boolean;                  //获取要修改车位满车记录数据
    function GetSaveString(aCDS : TClientDataSet; aCarNo : string) : String; overload;//获取本地修改过的布号列表
    function GetSaveString(var returnCarNo : string; aCDS : TClientDataSet) : String; overload;
    procedure Query;                                                            //查询方法
    procedure FillStrings(aCDS : TClientDataSet; aFieldName : string; aList : TStrings); //根据指定字段填充TStrings
    procedure Save;
    procedure SaveByCarNo;                                                      //根据车号保存方法
    procedure SaveByFnCard;                                                     //根据后整卡号保存方法
    procedure EditNewLocation(aCDS: TClientDataSet; aCarNo, src_Dep, aNewLocation : String); overload;
    function EditNewLocation(aCDS: TClientDataSet; filterField, filterValue : array of String; aLocateField, aEditField, aEditValue : String) : Boolean; overload;
    //function CheckIsSample(aFnCard : String) : Boolean; //2015-03-04 APJ zhaogang Edit
    function CheckIsSampleORIsDisposal(aFabricNO : String) : Boolean;            //根据后整卡号，检查是否为样布或处理布
  public
    { Public declarations }
    OldCar_No : String  // Added by WuDev 2016/9/8 11:21:38  增加车牌号修改
  end;

var
  FNEditCarNoForm: TFNEditCarNoForm;

implementation

uses uFNMResource, ServerDllPub, uShowMessage, uGridDecorator, uLogin;

{$R *.dfm}

{ TFNEditCarNoForm }

procedure TFNEditCarNoForm.init;
begin
  SBtnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  SBtnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  SBtnExit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
end;

procedure TFNEditCarNoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFNEditCarNoForm.FormDestroy(Sender: TObject);
begin
  FNEditCarNoForm := nil;
end;

procedure TFNEditCarNoForm.SBtnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFNEditCarNoForm.chkLocalQueryClick(Sender: TObject);
begin
  cxTVEditCarNO.OptionsView.GroupByBox := chkLocalQuery.Checked;
end;
{
function TFNEditCarNoForm.GetgiFullCarFabricsFramework : Boolean;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  Result := False;
  sql := QuotedStr('GetgiFullCarFabricsFramework') + ',' + QuotedStr('');
  FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);

  if Trim(sErrorMsg) <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;//if

  CDSEditCarNO.Data := vData;
  Result := True;
end;
}
function TFNEditCarNoForm.GetEditCarNoData(aDepartment: string): Boolean;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  Result := False;
  try
    ShowMsg('正在获取数据稍等!', crHourGlass);

    sql := QuotedStr('GetEditCarNOData') + ',' + QuotedStr(aDepartment);
    FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);

    if Trim(sErrorMsg) <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;//if

    CDSEditCarNO.Data := vData;
    Result := ((CDSEditCarNO.Active) and (CDSEditCarNO.RecordCount > 0));
  finally
    ShowMsg('', crDefault);
  end;//finally
end;

procedure TFNEditCarNoForm.Query;
var
  i : Integer;
begin
  if not GetEditCarNoData(Login.CurrentDepartment) then
  begin
      SBtnSave.Enabled := False;
      BtnEdit.Enabled := False;
      TMsgDialog.ShowMsgDialog('没有待修改车位的坯布数据', 2);
      Exit;
  end;//if

  //绑定cxGrid
  GridDecorator.BindCxViewWithDataSource(cxTVEditCarNO, DSEditCarNOData);
  for i := 0 to cxTVEditCarNO.ColumnCount - 1 do
    cxTVEditCarNO.Columns[i].Options.Editing := False;
    
  //序号列可修改
  cxTVEditCarNO.GetColumnByFieldName('Sequence').Options.Editing := True;

  //cxTVEditCarNO.GetColumnByFieldName('NewLocation').Options.Editing := True;
  if CDSEditCarNO.RecordCount > 0 then
  begin
    SBtnSave.Enabled := True;
    CDSEditCarNO.IndexFieldNames := 'Car_No;FN_Card';
    //FillStrings(CDSEditCarNO, 'Car_No', CBBCarNo.Items);
    CDSEditCarNO.First;
    EctCarNo.Text := CDSEditCarNO.FieldByName('Car_No').AsString;
  end;//if
end;


procedure TFNEditCarNoForm.SBtnRefreshClick(Sender: TObject);
begin
  Query;
end;

procedure TFNEditCarNoForm.SaveByCarNo;
var
  updateList, carNo : string;
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  if (Trim(EctCarNo.Text) <> '') or (CDSEditCarNO.Active) then
  begin
    if CDSEditCarNO.State in [dsEdit, dsInsert] then
      CDSEditCarNO.Post;

    if CDSEditCarNO.RecordCount > 0 then
    begin
      try
        ShowMsg('正在保存数据稍等!', crHourGlass);
        {
        updateList := GetSaveString(CDSEditCarNO, EctCarNo.text); //组织数据
        //后整卡号列表 | 新车号列表 | 各卡号总码长 | 全部卡号总码长 | 当前部门 | 操作人ID
        sql := updateList + '|' + login.CurrentDepartment + '|' + login.LoginID;
        sql := QuotedStr('SaveEditCarNOData') + ',' + QuotedStr(sql);}

        //车号| 新车位| 源部门 | 当前部门 | 操作人ID | 车号
        updateList := GetSaveString(carNo, CDSEditCarNO); //组织数据

        if updateList = '' then
          Exit;

        if MessageDlg('是否对车号[' + carNo + ']执行运输下机操作?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
          Exit;

        sql := updateList + '|' + login.CurrentDepartment + '|' + login.LoginID + '|' +oldCar_No;
        sql := QuotedStr('SaveEditCarNODataByCarNo') + ',' + QuotedStr(sql);

        FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);
        if Trim(sErrorMsg) <> '' then
        begin
          TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
          Exit;
        end;//if
        CDSEditCarNO.MergeChangeLog;
        if GetEditCarNoData(Login.CurrentDepartment) then
           TMsgDialog.ShowMsgDialog('数据保存成功', mtInformation);
      finally
        ShowMsg('', crDefault);
      end;//finally
    end;//if
  end;//if
end;

function TFNEditCarNoForm.GetSaveString(aCDS : TClientDataSet; aCarNo : string) : String;
var
  fnCardList, quantityList, newLocationList : string;
  fnCard, newLocation : String;
  quantity, total : Real;
  i : Integer;
begin
  Result := '';
  if (aCDS.Active) and (aCDS.RecordCount > 0) and (Trim(aCarNo) <> '') then
  begin
    try
      total := 0;
      quantity := -1;
      aCDS.DisableControls;
      aCDS.Filter := 'Car_No = ' + QuotedStr(aCarNo);
      aCDS.Filtered := True;
      aCDS.First;
      while not aCDS.Eof do
      begin
        if fnCard <> aCDS.FieldByName('FN_Card').AsString then
        begin
          quantity := 0;
          //卡号
          fnCard := aCDS.FieldByName('FN_Card').AsString;
          fnCardList := fnCardList + fnCard + ','; //累加卡号
          //新车位
          //如果新车位（后整车位就是车号）为空，则用原车号
          newLocation := aCDS.FieldByName('NewLocation').AsString;
          if Trim(newLocation) = '' then
            newLocation := EdtNewLocation.Text;
          if Trim(newLocation) = '' then
            newLocation := aCDS.FieldByName('Car_No').AsString;
          newLocationList := newLocationList + newLocation + ',';//累加记录车位
        end;
        quantity := quantity + aCDS.FieldByName('Quantity').AsFloat;//卡号总码长
        //总码长
        total := total + aCDS.FieldByName('Quantity').AsFloat; //累加计算全部卡号总码长
        aCDS.Next;
        if (fnCard <> aCDS.FieldByName('FN_Card').AsString) or (aCDS.Eof) then
          quantityList := quantityList + FloatToStr(quantity)+ ',';//aCDS.FieldByName('Quantity').AsString + ',';//每张卡码长}
      end;//while
      {
      //累加个卡号的总码长
      for i := 0 to fncList.Count - 1 do
      begin
        aCDS.Filter := 'FN_Card = ' + QuotedStr(fncList.Strings[i]);
        aCDS.Filtered := True;
        aCDS.First;
        while not aCDS.Eof do
        begin
          quantity := quantity + aCDS.FieldByName('Quantity').AsFloat;
          aCDS.Next;
        end;//while
        quantityList := quantityList + FloatToStr(quantity) + ',';
        total := total + quantity; //累加计算全部卡号总码长
        quantity := 0;
      end;//for
      }
      Result := fnCardList + '|' + NewLocationList + '|' + quantityList + '|' + FloatToStr(total);
    finally
      aCDS.Filtered := False;
      aCDS.Filter := '';
      aCDS.IndexFieldNames := 'Car_No';
      aCDS.EnableControls;
    end;//finally
  end;//if
end;

procedure TFNEditCarNoForm.FillStrings(aCDS: TClientDataSet; aFieldName : string; aList: TStrings);
var
  aField : string;
begin
  aCDS.First;
  aList.Clear;
  while not aCDS.Eof do
  begin
    if aField <> aCDS.FieldByName(aFieldName).AsString then
    begin
      aField := aCDS.FieldByName(aFieldName).AsString;
      aList.Add(aField);
    end;//if
    aCDS.Next;
  end;//while
end;

procedure TFNEditCarNoForm.SBtnSaveClick(Sender: TObject);
begin
  inherited;
  Save;
end;

procedure TFNEditCarNoForm.EditNewLocation(aCDS: TClientDataSet; aCarNo, src_Dep, aNewLocation : String);
var
  oldFilter, carNo : string;
begin
  if (EdtNewLocation.Text <> '') and (aCDS.Active) and (aCDS.RecordCount > 0) then
  begin
    carNo := aCDS.FieldByName('Car_No').AsString;
    oldFilter := aCDS.Filter;                    //记录原过滤条件
    try
      aCDS.MergeChangeLog;//清空之前的修改记录
      aCDS.DisableControls;
      aCDS.Filter := 'Car_No = ' + QuotedStr(aCarNo) + ' and Src_Department = ' + QuotedStr(src_Dep);
      aCDS.Filtered := True;
      if aCDS.RecordCount > 0 then
      begin
        aCDS.First;
        while not aCDS.Eof do
        begin
          aCDS.Edit;
          aCDS.FieldByName('NewLocation').AsString := aNewLocation;
          aCDS.Post;
          aCDS.Next;
        end;//while
      end;//if
    finally
      aCDS.Filtered := False;
      aCDS.Filter := '';
      if oldFilter <> '' then
      begin
        aCDS.Filter := oldFilter;
        aCDS.Filtered := True;
      end;//if
      aCDS.Locate('Car_No', carNo, []);
      aCDS.EnableControls;
    end;//finally
  end;//if
end;

procedure TFNEditCarNoForm.BtnEditClick(Sender: TObject);
begin
  inherited;
  {EditNewLocation(CDSEditCarNO,
    CDSEditCarNO.FieldByName('Car_No').AsString,
    CDSEditCarNO.FieldByName('Src_Department').AsString,
    EdtNewLocation.Text); }

  // Added by WuDev 2016/9/7 11:03:47 增加车牌号修改
  OldCar_No:= CDSEditCarNO.FieldByName('Car_No').AsString;
  EditNewLocation(CDSEditCarNO,
    ['FN_Card','Src_Department'],
    [CDSEditCarNO.fieldByName('FN_Card').AsString, CDSEditCarNO.FieldByName('Src_Department').AsString],
    'Fabric_NO', 'Car_No', EctCarNo.Text);
  // end

  EditNewLocation(CDSEditCarNO,
    ['Car_No','Src_Department'],
    [CDSEditCarNO.FieldByName('Car_No').AsString, CDSEditCarNO.FieldByName('Src_Department').AsString],
    'Fabric_NO', 'NewLocation', EdtNewLocation.Text);
end;

procedure TFNEditCarNoForm.CDSEditCarNOAfterScroll(DataSet: TDataSet);
begin
  inherited;
  EctCarNo.Text := TClientDataSet(DataSet).FieldByName('Car_No').AsString;
end;

procedure TFNEditCarNoForm.EdtNewLocationKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TEdit(Sender).CharCase := ecUpperCase;
end;

procedure TFNEditCarNoForm.cxTVEditCarNODataControllerFilterBeforeChange(
  Sender: TcxDBDataFilterCriteria; ADataSet: TDataSet;
  const AFilterText: String);
begin
  inherited;
  if AFilterText <> '' then
  begin
    if Pos('= TRUE', UpperCase(AFilterText)) > 0 then
      ADataSet.Filter := Stringreplace(UpperCase(AFilterText), '= TRUE', '<> FALSE', [rfReplaceAll])
    else
      ADataSet.Filter := AFilterText;
    ADataSet.Filtered := True;
    ADataSet.First;
  end
  else
  begin
    ADataSet.Filtered := False;
    ADataSet.Filter := '';
  end;//else}
end;

function TFNEditCarNoForm.GetSaveString(var returnCarNo : string; aCDS: TClientDataSet): String;
var
  carNo, newLocation, srcDep, Sequence : String;
  cds : TClientDataSet;
begin
  Result := '';
  if aCDS.Active then
  begin
    if aCDS.ChangeCount < 1 then
    begin
      TMsgDialog.ShowMsgDialog('请修改车位后再执行保存', mtWarning);
      Exit;
    end;//if
    cds := TClientDataSet.Create(nil);
    try
      cds.Data := aCDS.Delta;
      //防止同车中有试样布和处理布
      cds.First;
      while not cds.Eof do
      begin
        if cds.FieldByName('Car_No').AsString <> '' then
          if (cds.FieldByName('Is_Sample').AsBoolean) or (cds.FieldByName('Is_Disposal').AsBoolean) then
          begin
            TMsgDialog.ShowMsgDialog('同车中有非正常布，请先让试样布或处理布执行运输下机操作', mtWarning);
            Exit;
          end;//if
        cds.Next;
      end;//while

      cds.Data := aCDS.Data;     // Added by WuDev 2016/9/8 14:48:31  
      cds.First;
      while not cds.Eof do
      begin
        if cds.FieldByName('Car_No').AsString <> '' then
        begin
          carNo := cds.FieldByName('Car_No').AsString;
          srcDep := cds.FieldByName('Src_Department').AsString;
          newLocation := cds.FieldByName('NewLocation').AsString;   // Added by WuDev 2016/9/8 11:50:20  增加地位号的修改
        end
        else
        begin
          Sequence := cds.FieldByName('Sequence').AsString;
          newLocation := cds.FieldByName('NewLocation').AsString;
          Break;
        end;//else
        cds.Next;
      end;//while
      returnCarNo := carNo;
      Result := carNo + '|' + newLocation + '|' + srcDep + '|' + Sequence;
    finally
      if Assigned(cds) then
      begin
        cds.Close;
        FreeAndNil(cds);
      end;//if
    end;//finally
  end;//if
end;

function TFNEditCarNoForm.EditNewLocation(aCDS: TClientDataSet;
  filterField, filterValue: array of String; aLocateField, aEditField,
  aEditValue: String): Boolean;
var
  locateValue, value, oldFilterStr, filterStr,oldIndex : String;
  i : Integer;
begin
  Result := False;
  //carNo := aCDS.FieldByName('Car_No').AsString;
  locateValue := aCDS.FieldByName(aLocateField).AsString;
  oldFilterStr := aCDS.Filter;
  // Added by WuDev 2016/9/7 17:58:51  去掉排序功能
  oldIndex:= aCDS.IndexFieldNames;
  aCDS.IndexFieldNames:= '';
  try
    aCDS.DisableControls;
    for i := 0 to Length(filterField) - 1 do
    begin
      if (filterStr <> '') then
        filterStr := filterStr + ' and ' + filterField[i] + ' = ' + QuotedStr(filterValue[i])
      else
        filterStr := filterField[i] + ' = ' + QuotedStr(filterValue[i]);
    end;
    aCDS.Filter := filterStr;
    aCDS.Filtered := True;

    if aCDS.RecordCount > 0 then
    begin
      aCDS.First;
      while not aCDS.Eof do
      begin
        value := aCDS.FieldByName(aEditField).AsString;
        if value <> aEditValue then
        begin
          aCDS.Edit;
          aCDS.FieldByName(aEditField).AsString := aEditValue;
          aCDS.Post;
          Result := True;
        end;//if
        aCDS.Next;
      end;//while
    end;//if
  finally
    aCDS.Filtered := False;
    aCDS.Filter := '';
    aCDS.IndexFieldNames:= oldIndex;
    if oldFilterStr <> '' then
    begin
      aCDS.Filter := oldFilterStr;
      aCDS.Filtered := True;
    end;//if
    aCDS.Locate(aLocateField, locateValue, []);
    aCDS.EnableControls;
  end;//finally
end;

procedure TFNEditCarNoForm.cxTVEditCarNOEditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
var
  value : String;
begin
  inherited;
  if cxTVEditCarNO.GetColumnByFieldName('Sequence').Editing then
  begin
    value := VarToStr(cxTVEditCarNO.Controller.EditingController.Edit.EditValue);
    EditNewLocation(CDSEditCarNO,
        ['Car_No','Src_Department'],
        [EctCarNo.Text, CDSEditCarNO.FieldByName('Src_Department').AsString],
        'Fabric_NO', 'Sequence', value);
  end;//if
end;

function TFNEditCarNoForm.CheckIsSampleORIsDisposal(aFabricNO: String): Boolean;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
  cds : TClientDataSet;
begin
  Result := False;
  cds := TClientDataSet.Create(nil);
  try
    sql := QuotedStr('CheckIsSampleORIsDisposal') + ',' + QuotedStr(aFabricNO);
    FNMServerObj.GetQueryData(vData, 'GiFullCarFabricsData', sql, sErrorMsg);
    if Trim(sErrorMsg) <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;//if
    
    cds.Data := vData;
    if(cds.Active) and (not cds.IsEmpty) then
    begin
      if (cds.FieldByName('Is_Sample').AsBoolean)
        or (cds.FieldByName('Is_Disposal').AsBoolean) then
        Result := True
    end;
  finally
    if Assigned(cds) then
      FreeAndNil(cds);
  end;//finally
end;

procedure TFNEditCarNoForm.Save;
begin
  if (not CDSEditCarNO.Active) and (CDSEditCarNO.RecordCount = 0) then
    Exit;

  try
    cxGEditCarNO.Enabled := False;
    //检查是否为样布或处理布
    if CheckIsSampleORIsDisposal(CDSEditCarNO.FieldByName('Fabric_NO').AsString) then
      SaveByFnCard  //如果是样布或处理布，则以卡号为单位进行下机
    else
      SaveByCarNo; //如果是正常布，则以车号为单位进行下机
  finally
    cxGEditCarNO.Enabled := True;
  end;//finally
end;

procedure TFNEditCarNoForm.SaveByFnCard;
var
  newLocation,newCarNo : String;
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  try
    newLocation := CDSEditCarNO.FieldByName('NewLocation').AsString;
    newCarNo:= CDSEditCarNO.fieldByName('Car_No').AsString;       // Added by WuDev 2016/9/7 15:52:51 增加车牌号修改
    if newLocation = '' then
      newLocation := CDSEditCarNO.FieldByName('Location').AsString;

    sql := CDSEditCarNO.FieldByName('FN_Card').AsString + '|' + newLocation + '|' + login.LoginID + '|' +newCarNo;  // Modified by WuDev 2016/9/7 15:53:11  增加车牌号修改
    sql := QuotedStr('UpdateEditCarNODataByFnCard') + ',' +  QuotedStr(sql);
    FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);

    if Trim(sErrorMsg) <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;//if
    
    CDSEditCarNO.MergeChangeLog;
    if GetEditCarNoData(Login.CurrentDepartment) then
      TMsgDialog.ShowMsgDialog('数据保存成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;//finally
end;


end.
