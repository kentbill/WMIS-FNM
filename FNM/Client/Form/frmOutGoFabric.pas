unit frmOutGoFabric;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, Buttons, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ExtCtrls, StdCtrls, DBClient, cxSplitter, StrUtils,
  MakeSQL;

type
  TOutGoFabricForm = class(TBaseForm)
    GrpWait: TGroupBox;
    GrpSelection: TGroupBox;
    cxTVWait: TcxGridDBTableView;
    cxLWait: TcxGridLevel;
    cxGrdWait: TcxGrid;
    cxTVSelection: TcxGridDBTableView;
    cxLSelection: TcxGridLevel;
    cxGrdSelection: TcxGrid;
    CDSWait: TClientDataSet;
    CDSSelection: TClientDataSet;
    DSWait: TDataSource;
    DSSelection: TDataSource;
    Panel1: TPanel;
    SBtnAdd: TSpeedButton;
    SBtnCancel: TSpeedButton;
    SBtnRefresh: TSpeedButton;
    cxSplitter1: TcxSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    SBtnOutGo: TSpeedButton;
    SBtnExit: TSpeedButton;
    chkLocalQuery: TCheckBox;
    Label2: TLabel;
    Label1: TLabel;
    EdtNewLocation: TEdit;
    BtnEdit: TButton;
    BtnSave: TButton;
    EdtCarNo: TEdit;
    CBBSrcDepartment: TComboBox;
    Label3: TLabel;
    procedure SBtnAddClick(Sender: TObject);
    procedure SBtnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SBtnRefreshClick(Sender: TObject);
    procedure SBtnExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure cxTVWaitDblClick(Sender: TObject);
    procedure cxTVSelectionCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxTVWaitCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure SBtnOutGoClick(Sender: TObject);
    procedure chkLocalQueryClick(Sender: TObject);
    procedure cxTVSelectionDblClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure CDSWaitAfterScroll(DataSet: TDataSet);
    procedure cxTVWaitDataControllerFilterBeforeChange(
      Sender: TcxDBDataFilterCriteria; ADataSet: TDataSet;
      const AFilterText: String);
    procedure cxTVWaitEditValueChanged(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem);
    procedure EdtNewLocationKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    GFNCard, GSrcDep, GDestDep, GCarNo : string; //限制变量:后整卡号、源部门、目标部门，车号
    GIsEditNewLocation : Boolean;      //是否更新了车位
    GIsEditCarNo : Boolean;     // Added by WuDev 2016/9/6 15:10:38  是否更新了车牌号
    procedure init;
    procedure ProhibitEditGrid(aGridTV : TcxGridDBTableView);//禁止修改
    procedure Query;
    function GetOutGoFabricData(aDepartment : string) : Boolean;
    procedure FillStrings(aCDS : TClientDataSet; aFieldName : string; aList : TStrings); //根据指定字段填充TStrings
    function EditNewLocation(aCDS: TClientDataSet; filterField, filterValue : array of String; aLocateField, aEditField, aEditValue  : String) : Boolean;      // Modified by WuDev 2016/9/6 11:14:40 增加车牌号修改功能
    function GetSaveString(aCDS : TClientDataSet) : String;
    procedure Save;
    //procedure LocalFilter(aGFID, aCarNO : String);

    procedure Move(srcCDS, destCDS : TClientDataSet; fieldName, aValue : String); //数据移动，将一条源CDS的数据添加到目标CDS，并删除源CDS的数据
    function add : Boolean;
    procedure cancel;
    procedure BatchAdd;
    procedure BatchCancel;
    function GetFabricNoAndNewLocationList(aCDS: TClientDataSet) : string;
    procedure OutGoFabric;
    function IsEmpty(aValue, aReplaceValue : String) : string;
  public
    { Public declarations }
  end;

var
  OutGoFabricForm: TOutGoFabricForm;

implementation

uses uFNMResource, ServerDllPub, uShowMessage, uGridDecorator, uLogin;


{$R *.dfm}

{ TOutGoFabricForm }

procedure TOutGoFabricForm.init;
begin
  SBtnAdd.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  SBtnCancel.Glyph.LoadFromResourceName(HInstance, RES_UP);
  SBtnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  SBtnOutGo.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  SBtnExit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);

  CBBSrcDepartment.Items.Add('ALL');
  CBBSrcDepartment.Items.Add('G1');
  CBBSrcDepartment.Items.Add('G2');
  CBBSrcDepartment.Items.Add('G3');
  CBBSrcDepartment.ItemIndex := 0;

  GIsEditNewLocation := False;
  GIsEditCarNo := False;
end;

function TOutGoFabricForm.GetOutGoFabricData(aDepartment : string): Boolean;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  Result := False;
  try
    ShowMsg('正在获取数据稍等!', crHourGlass);
    //存储过程参数：调用代码段,来源部门|可出布类型类型: 1
    sql := QuotedStr('GetOutGoFabricData') + ',' +  QuotedStr(aDepartment + '|1'); // + '|' + Login.CurrentDepartment
    FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);
    if Trim(sErrorMsg) <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;//if

    CDSWait.Data := vData;
    Result := ((CDSWait.Active) and (CDSWait.RecordCount > 0));
  finally
    ShowMsg('', crDefault);
  end;//finally
end;

procedure TOutGoFabricForm.ProhibitEditGrid(aGridTV: TcxGridDBTableView);
var
  i : Integer;
begin
  for i := 0 to aGridTV.ColumnCount - 1 do
    aGridTV.Columns[i].Options.Editing := False;
end;

procedure TOutGoFabricForm.Query;
begin
  {if (CBBGF_NO.Text = '') and (CBBCarLocation.Text = '') then
  begin
    CDSWait.Filter := '';
    CDSWait.Filtered := False;
    GetOutGoFabricData(Login.CurrentDepartment);
  end
  else
    LocalFilter(CBBGF_NO.text, CBBCarLocation.text);
  }
  if Trim(CBBSrcDepartment.Text) = '' then
    Exit;

  GSrcDep := '';
  GFNCard := '';
  GDestDep := '';
  GCarNo := '';
  if not GetOutGoFabricData(CBBSrcDepartment.Text) then //Login.CurrentDepartment
  begin
    TMsgDialog.ShowMsgDialog('没有待出布数据', 2);
    Exit;
  end;//if

  //复制表结构
  if CDSWait.Active then
  begin
    if CDSSelection.Active then
    begin
      CDSSelection.Edit;
      CDSSelection.ClearFields;
      CDSSelection.Close;
    end;
    CDSSelection.FieldDefs := CDSWait.FieldDefs;
    CDSSelection.CreateDataSet;
  end;//if
  //关联cxGrid
  GridDecorator.BindCxViewWithDataSource(cxTVWait, DSWait);
  GridDecorator.BindCxViewWithDataSource(cxTVSelection, DSSelection);
  //禁止修改
  ProhibitEditGrid(cxTVWait);
  ProhibitEditGrid(cxTVSelection);
  //暂时只可修改是否可送后整字段为可修改
  //cxTVWait.GetColumnByFieldName('CanBeOutToFN').Options.Editing := True;
  

  CDSWait.IndexFieldNames := 'FN_Card;Fabric_NO';
  CDSWait.First;
  EdtCarNo.Text := CDSWait.FieldByName('Car_No').AsString;
  {
  if CDSWait.RecordCount > 0 then
  begin
    CDSWait.IndexFieldNames := 'Car_NO';
    CDSWait.First;
    FillStrings(CDSWait,'Car_No', CBBCarNo.Items);
  end;
  }
end;

{
procedure TOutGoFabricForm.LocalFilter(aGFID, aCarNO : String);
var
  filterStr : String;
begin
  if(CDSWait.Active) and (CDSWait.RecordCount > 0) then
  begin
    if aGFID <> '' then
      filterStr := 'GF_NO = ' + QuotedStr(aGFID);

    if aCarNO <> '' then
    begin
      if filterStr <> '' then
        filterStr := filterStr + ' and ';
        
      filterStr := filterStr + ' Car_NO = ' + QuotedStr(aCarNO);
      CDSWait.Filter := filterStr;
      CDSWait.Filtered := True;
    end;//if
  end;//if
end;
}

procedure TOutGoFabricForm.Move(srcCDS, destCDS: TClientDataSet; fieldName, aValue: String);
var
  i: Integer;
  fn : string;
begin
  if (srcCDS.Active) and (srcCDS.RecordCount > 0) and (destCDS.Active) then
  begin
    if (srcCDS.Locate(fieldName, aValue, [])) and (not destCDS.Locate(fieldName, aValue, [])) then
    begin
      destCDS.Append;
      for i := 0 to srcCDS.FieldList.Count - 1 do
      begin
          destCDS.Fields.Fields[i].Value := srcCDS.Fields.Fields[i].Value;
      end;//for
      destCDS.Post;
    end;//if
    srcCDS.Delete;
  end;//if
end;

function TOutGoFabricForm.add : Boolean;
begin
  Result := False;

  if CDSWait.FieldByName('CanBeOutToFN').AsBoolean = False then
    Exit;

  GFNCard := CDSWait.FieldByName('FN_Card').AsString;
  GSrcDep := CDSWait.FieldByName('Src_Department').AsString;
  GDestDep := CDSWait.FieldByName('Dest_Department').AsString;

  Move(CDSWait, CDSSelection, 'Fabric_NO', CDSWait.FieldByName('Fabric_NO').AsString);
  Result := True;
end;

procedure TOutGoFabricForm.cancel;
begin
  if CDSSelection.IsEmpty then
    Exit;
  Move(CDSSelection, CDSWait, 'Fabric_NO', CDSSelection.FieldByName('Fabric_NO').AsString);
  if CDSSelection.RecordCount = 0 then
  begin
    GSrcDep := '';
    GDestDep := '';
    GFNCard := '';
    GCarNo := '';
  end;//if
end;

procedure TOutGoFabricForm.BatchAdd;
var
  fabricNO, FN_Card : string;
  filterStr : String;
begin
    if CDSWait.State in [dsEdit, dsInsert] then
      CDSWait.Post;

  if (CDSWait.FieldByName('CanBeOutToFN').AsBoolean = False) or (CDSWait.FieldByName('FN_Card').AsString = '')then
    Exit;

  if (GFNCard <> '') or (GSrcDep <> '') or (GDestDep <> '') then
    if (GFNCard <> CDSWait.FieldByName('FN_Card').AsString) or (GSrcDep <> CDSWait.FieldByName('Src_Department').AsString)
      or (GDestDep <> CDSWait.FieldByName('Dest_Department').AsString) then
      Exit;

  try
    CDSWait.DisableControls;
    filterStr := CDSWait.Filter;//记录原过滤条件
    
    CDSWait.Filter := 'FN_Card = ' + QuotedStr(CDSWait.FieldByName('FN_Card').AsString);
    CDSWait.Filtered := True;
    CDSWait.First;

    fabricNO := CDSWait.FieldByName('Fabric_NO').AsString;
    FN_Card := CDSWait.FieldByName('FN_Card').AsString;

    CDSWait.Filtered := False;
    CDSWait.Filter := '';
    CDSWait.Locate('Fabric_NO', fabricNO, []);
    while not CDSWait.Eof do
    begin
      if not add then//if (GSrcDep <> CDSWait.FieldByName('Src_Department').AsString) or (GFNCard <> CDSWait.FieldByName('FN_Card').AsString)then
        CDSWait.Next;

      if FN_Card <> CDSWait.FieldByName('FN_Card').AsString then
        Break;
    end;//while
  finally
    if filterStr <> '' then
    begin
      CDSWait.Filtered := False;
      CDSWait.Filter := filterStr;
      CDSWait.Filtered := True;
    end;//if
    CDSWait.EnableControls;
  end;//finally
end;

procedure TOutGoFabricForm.BatchCancel;
begin
  CDSSelection.First;
  while not CDSSelection.Eof do
    cancel;
end;

procedure TOutGoFabricForm.SBtnAddClick(Sender: TObject);
begin
  inherited;
  //add;
  BatchAdd;
end;

procedure TOutGoFabricForm.SBtnCancelClick(Sender: TObject);
begin
  inherited;
  //Cancel;
  BatchCancel;
end;

procedure TOutGoFabricForm.FormShow(Sender: TObject);
begin
  inherited;
  init;
end;

procedure TOutGoFabricForm.SBtnRefreshClick(Sender: TObject);
begin
  inherited;
  Query;
end;

procedure TOutGoFabricForm.SBtnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TOutGoFabricForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TOutGoFabricForm.FormDestroy(Sender: TObject);
begin
  inherited;
  OutGoFabricForm := nil;
end;

procedure TOutGoFabricForm.cxTVWaitDblClick(Sender: TObject);
begin
  inherited;
  //add;
  BatchAdd;
end;

procedure TOutGoFabricForm.cxTVSelectionCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  //需要运输的数据行变色
  if AViewInfo.GridRecord.DisplayTexts[cxTVSelection.GetColumnByFieldName('CarNeedBeCarShip').Index] = 'True' then
  begin
    ACanvas.Brush.Color := $0080FF80;
    ACanvas.Font.Color := clBlack;
  end;
end;

procedure TOutGoFabricForm.cxTVWaitCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  //需要运输的数据行变色
  if AViewInfo.GridRecord.DisplayTexts[cxTVWait.GetColumnByFieldName('CarNeedBeCarShip').Index] = 'True' then
  begin
    ACanvas.Brush.Color := $0080FF80;
    ACanvas.Font.Color := clBlack;
    //cxTVSelection.GetColumnByFieldName('NewLocation').Options.Editing := false;
  end else
  begin
    //cxTVSelection.GetColumnByFieldName('NewLocation').Options.Editing := True;
  end;//else
end;

function TOutGoFabricForm.GetFabricNoAndNewLocationList(aCDS: TClientDataSet) : string;
var
  fabricNOList, newLocationList, fnCardList, quantityList, CarNoList : String;   // Added by WuDev 2016/9/19 9:41:31 增加车牌号信息
begin
  Result := '';
  if(aCDS.Active) and (aCDS.RecordCount > 0) then
  begin
    fabricNOList := '';
    newLocationList := '';
    aCDS.First;
    while not aCDS.Eof do
    begin
      fabricNOList := fabricNOList + aCDS.FieldByName('Fabric_NO').AsString + ','; //布号
      //各布车位号
      //如果 NewLocation 为空，则用回原车号
      newLocationList := newLocationList + IsEmpty(aCDS.FieldByName('NewLocation').AsString, aCDS.FieldByName('Car_No').AsString) + ',';
      fnCardList := fnCardList + aCDS.FieldByName('FN_Card').AsString + ','; //各布后整卡号
      quantityList := quantityList + aCDS.FieldByName('Quantity').AsString + ','; //各布码长
      CarNoList :=  CarNoList + aCDS.fieldByName('Car_No').AsString + ',';      // Added by WuDev 2016/9/19 9:45:22  增加车牌号信息
      aCDS.Next;
    end;//while
    //布号，各布车位，各布后整卡号，各布码长
    Result := fabricNOList + '|' + newLocationList + '|' + fnCardList + '|' + quantityList + '|' +CarNoList;  // Added by WuDev 2016/9/19 9:45:22  增加车牌号信息
  end;//if
end;

procedure TOutGoFabricForm.OutGoFabric;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  if(CDSSelection.Active) and (CDSSelection.RecordCount > 0) then
  begin
    try
      if CDSSelection.State in [dsEdit, dsInsert] then
        CDSSelection.Post;

      CDSSelection.DisableControls;
        
      ShowMsg('正在保存数据稍等!', crHourGlass);
      GrpWait.Enabled := False;
      GrpSelection.Enabled := False;

      //获取布号列表
      //布号，各布车位，各布后整卡号，各布码长，总码长
      sql := GetFabricNoAndNewLocationList(CDSSelection);

      //各布号、各布车位、各布后整卡号、各布码长、总码长、原部门、当前部门、操作人ID
      //sql := sql + '|' + GSrcDep + '|' + login.CurrentDepartment + '|' + login.LoginID;
      //由于限制每次出布是以卡号为单位，所以品名、排单一致，目标部门也会一致
      sql := sql + '|' + CDSSelection.FieldByName('Src_Department').AsString + '|' + CDSSelection.FieldByName('Dest_Department').AsString + '|' + login.LoginID;
      sql := QuotedStr('SaveOutGoFabricData') + ',' + QuotedStr(sql);
      FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);
      if Trim(sErrorMsg) <> '' then
      begin
        TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
        Exit;
      end;//if
      CDSSelection.MergeChangeLog;
      CDSSelection.EmptyDataSet;    //清空本地出布记录
      TMsgDialog.ShowMsgDialog('卡号[' + GFNCard + ']成功出布', mtInformation);

      GSrcDep := '';
      GDestDep := '';
      GFNCard := '';
      GCarNo := '';
    finally
      CDSSelection.EnableControls;
      GrpWait.Enabled := True;
      GrpSelection.Enabled := True;
      ShowMsg('', crDefault);
    end;//finally
  end;//if
end;

procedure TOutGoFabricForm.SBtnOutGoClick(Sender: TObject);
begin
  inherited;
  OutGoFabric;
end;

procedure TOutGoFabricForm.chkLocalQueryClick(Sender: TObject);
begin
  inherited;
  cxTVWait.OptionsView.GroupByBox := chkLocalQuery.Checked;
end;

procedure TOutGoFabricForm.cxTVSelectionDblClick(Sender: TObject);
begin
  inherited;
  //Cancel;
  BatchCancel;
end;

function TOutGoFabricForm.IsEmpty(aValue, aReplaceValue: String): string;
begin
  if Trim(aValue) <> '' then
    Result := aValue
  else
    Result := aReplaceValue;
end;


procedure TOutGoFabricForm.FillStrings(aCDS: TClientDataSet; aFieldName: string; aList: TStrings);
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

function TOutGoFabricForm.EditNewLocation(aCDS: TClientDataSet; filterField, filterValue : array of String; aLocateField, aEditField, aEditValue: string) : Boolean;
var
  //carNo : string;
  oldFilterStr, locateValue, value, filterStr: String;
  i : Integer;
begin
  Result := False;
  //carNo := aCDS.FieldByName('Car_No').AsString;
  oldFilterStr := aCDS.Filter;
  locateValue := aCDS.FieldByName(aLocateField).AsString;
  try
    aCDS.DisableControls;
    //aCDS.Filter := 'Car_No = ' + QuotedStr(EdtCarNo.Text);
    for i := 0 to Length(filterField) - 1 do
    begin
      if (filterStr <> '') then
        filterStr := filterStr + ' and ' + filterField[i] + ' = ' + QuotedStr(filterValue[i])
      else
        filterStr := filterField[i] + ' = ' + QuotedStr(filterValue[i]);
    end;//for
    
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
          //aCDS.FieldByName('NewLocation').AsString := Trim(EdtNewLocation.Text);
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
    if oldFilterStr <> '' then
    begin
      aCDS.Filter := oldFilterStr;
      aCDS.Filtered := True;
    end;
    //aCDS.Locate('Car_No', carNo, []);
    aCDS.Locate(aLocateField, locateValue, []);
    aCDS.EnableControls;
  end;//finally
end;

procedure TOutGoFabricForm.BtnEditClick(Sender: TObject);
begin
  inherited;
  // Modified by WuDev 2016/9/6 11:10:51
  GIsEditCarNo := EditNewLocation(CDSWait,
                    ['FN_Card','Src_Department','Dest_Department'],
                    [CDSWait.FieldByName('FN_Card').AsString, CDSWait.FieldByName('Src_Department').AsString, CDSWait.FieldByName('Dest_Department').AsString],
                    'Fabric_NO', 'Car_No', EdtCarNo.Text);
  GIsEditNewLocation := EditNewLocation(CDSWait,
                    ['Car_No','Src_Department','Dest_Department'],
                    [CDSWait.FieldByName('Car_No').AsString, CDSWait.FieldByName('Src_Department').AsString, CDSWait.FieldByName('Dest_Department').AsString],
                    'Fabric_NO', 'NewLocation', EdtNewLocation.Text);

end;

procedure TOutGoFabricForm.Save;
var
  updateList : string;
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  if CDSWait.State in [dsEdit, dsInsert] then
    CDSWait.Post;

  try
    ShowMsg('正在保存数据稍等!', crHourGlass);
    updateList := GetSaveString(CDSWait);
    //后整卡号列表 | 新车号列表 | 当前部门
    //sql :=  updateList + '|' + login.CurrentDepartment;
    sql := QuotedStr('SaveOutGoFabricNewLocationData') + ',' + QuotedStr(updateList);
    FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);
    if Trim(sErrorMsg) <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;//if
  finally
    ShowMsg('', crDefault);
  end;//finally
end;

procedure TOutGoFabricForm.BtnSaveClick(Sender: TObject);
begin
  inherited;
  Save;
end;

function TOutGoFabricForm.GetSaveString(aCDS : TClientDataSet): String;
var
  fnCardList, newLocationList, canBeToFNList,newCarNoList : string;
  fnCard : string;
  cds : TClientDataSet;
begin
  Result := '';
  if aCDS.ChangeCount = 0 then
    Exit;

  if aCDS.State in [dsEdit, dsInsert] then
    aCDS.Post;

  cds := TClientDataSet.Create(nil);
  try
    cds.Data := aCDS.Delta;
    if(cds.Active) and (cds.RecordCount > 0) then
    begin
      cds.First;
      while not cds.Eof do
      begin
        fnCard := cds.FieldByName('FN_Card').AsString;
        if Trim(fnCard) <> '' then
          fnCardList := fnCardList + fnCard + ','
        else
        begin
          //newLocation := Trim(cds.FieldByName('NewLocation').AsString);
          //canBeToFN := cds.FieldByName('CanBeOutToFN').AsString;
          if GIsEditNewLocation then
          begin
            newLocationList := newLocationList +
                IfThen(Trim(cds.FieldByName('NewLocation').AsString) <> '',
                          Trim(cds.FieldByName('NewLocation').AsString), 'NULL') + ',';
          end;//if
          // Added by WuDev 2016/9/6 15:12:57  增加车牌号修改
          if GIsEditCarNo then
          begin
            newCarNoList := newCarNoList +
                IfThen(Trim(cds.FieldByName('Car_No').AsString) <> '',
                          Trim(cds.FieldByName('Car_No').AsString), 'NULL') + ',';
          end;//if
          canBeToFNList := canBeToFNList + cds.FieldByName('CanBeOutToFN').AsString + ',';
        end;//else
        cds.Next;
      end;//while
      Result := fnCardList + '|' + newLocationList+ '|' + canBeToFNList + '|' +newCarNoList;
    end;//if
  finally
    GIsEditNewLocation := False;
    GIsEditCarNo:= False;
    if Assigned(cds) then
    begin
      cds.Close;
      FreeAndNil(cds);
    end;//if
  end;
end;

procedure TOutGoFabricForm.CDSWaitAfterScroll(DataSet: TDataSet);
begin
  inherited;
  EdtCarNo.Text := TClientDataSet(DataSet).FieldByName('Car_No').AsString;
end;

procedure TOutGoFabricForm.cxTVWaitDataControllerFilterBeforeChange(
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

procedure TOutGoFabricForm.cxTVWaitEditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
  inherited;
  {
  EditNewLocation(CDSWait, 'Fabric_NO', 'FN_Card', CDSWait.FieldByName('FN_Card').AsString,
    'CanBeOutToFN', ifthen(CDSWait.FieldByName('CanBeOutToFN').AsBoolean, 'False', 'True'));
  }
  EditNewLocation(CDSWait,
                    ['FN_Card','Src_Department','Dest_Department'],
                    [CDSWait.FieldByName('FN_Card').AsString, CDSWait.FieldByName('Src_Department').AsString, CDSWait.FieldByName('Dest_Department').AsString],
                    'Fabric_NO',
                    'CanBeOutToFN', ifthen(CDSWait.FieldByName('CanBeOutToFN').AsBoolean, 'False', 'True'));
end;

procedure TOutGoFabricForm.EdtNewLocationKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TEdit(Sender).CharCase := ecUpperCase;
end;

end.
