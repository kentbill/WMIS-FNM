unit frmPrepareFabric;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, Buttons, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ExtCtrls, StdCtrls, DBClient, cxSplitter, StrUtils,
  MakeSQL, Grids, DBGrids;

type
  TPrepareFabricForm = class(TBaseForm)
    GroupBox1: TGroupBox;
    cxGrdWait: TcxGrid;
    cxTVWait: TcxGridDBTableView;
    cxLWait: TcxGridLevel;
    Panel1: TPanel;
    SBtnRefresh: TSpeedButton;
    Label3: TLabel;
    chkLocalQuery: TCheckBox;
    CBBSrcDepartment: TComboBox;
    CDSEditCarNO: TClientDataSet;
    DSWait: TDataSource;
    Panel2: TPanel;
    SBtnExit: TSpeedButton;
    Label2: TLabel;
    EdtCarNo: TEdit;
    Label1: TLabel;
    EdtNewLocation: TEdit;
    SBtnEdit: TSpeedButton;
    SBtnSave: TSpeedButton;
    SBtnCancelFNCard: TSpeedButton;
    CDSUserLevel: TClientDataSet;
    procedure SBtnExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure chkLocalQueryClick(Sender: TObject);
    procedure SBtnRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CDSEditCarNOAfterScroll(DataSet: TDataSet);
    procedure SBtnEditClick(Sender: TObject);
    procedure SBtnSaveClick(Sender: TObject);
    procedure cxTVWaitEditValueChanged(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem);
    procedure EdtNewLocationKeyPress(Sender: TObject; var Key: Char);
    procedure cxTVWaitDataControllerFilterBeforeChange(
      Sender: TcxDBDataFilterCriteria; ADataSet: TDataSet;
      const AFilterText: String);
    procedure SBtnCancelFNCardClick(Sender: TObject);
  private
    { Private declarations }
    GIsAction : Boolean;
    GIsEditNewLocation : Boolean;      //是否更新了车位
    index : Integer;
    procedure init;
    procedure Query;
    function GetOutGoFabricData(aDepartment : string) : Boolean;
    function GetUserLevel(aUserId, aSystemID : String) : Boolean;
    //ClientDataSet， 定位字段，过滤字段，过滤值，修改字段，修改值
    //function EditNewLocation(aCDS: TClientDataSet; aLocateField, aFilterField, aFilterValue, aEditField, aEditValue : String) : Boolean;
    function EditNewLocation(aCDS: TClientDataSet; filterField, filterValue : array of String; aLocateField, aEditField, aEditValue : String) : Boolean;
    function GetSaveString(aCDS : TClientDataSet) : String;
    procedure Save;
    procedure CancelFNCard(aFNCard : string);
  public
    { Public declarations }
  end;

var
  PrepareFabricForm: TPrepareFabricForm;

implementation

uses uFNMResource, ServerDllPub, uShowMessage, uGridDecorator, uLogin;

{$R *.dfm}

{ TPrepareFabricForm }

procedure TPrepareFabricForm.init;
begin
  SBtnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  SBtnEdit.Glyph.LoadFromResourceName(HInstance, RES_EDIT);
  SBtnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  SBtnExit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  SBtnCancelFNCard.Glyph.LoadFromResourceName(HInstance, RES_UNDO);

  CBBSrcDepartment.Items.Add('ALL');
  CBBSrcDepartment.Items.Add('G1');
  CBBSrcDepartment.Items.Add('G2');
  CBBSrcDepartment.Items.Add('G3');
  CBBSrcDepartment.ItemIndex := 0;
  GIsAction := False;
end;

procedure TPrepareFabricForm.Query;
var
  i : Integer;
  UserLevel : String;
begin
  GIsAction := False;
  if Trim(CBBSrcDepartment.Text) = '' then
    Exit;

  if not GetOutGoFabricData(CBBSrcDepartment.Text) then //Login.CurrentDepartment
  begin
    TMsgDialog.ShowMsgDialog('没有待出布数据', 2);
    Exit;
  end;//if

  //关联cxGrid
  GridDecorator.BindCxViewWithDataSource(cxTVWait, DSWait);
  //禁止修改
  for i := 0 to cxTVWait.ColumnCount - 1 do
    cxTVWait.Columns[i].Options.Editing := False;

  //CanBeOutToFN 字段修改权限设置, cxGrid CanBeOutToFN 列的修改权限
  if GetUserLevel(Login.LoginID, IntToStr(Login.SystemID)) then
  begin
    //if Pos('40',Login.UserLevelList) > 0 then
    if CDSUserLevel.Locate('userLevel', 40, []) then
      cxTVWait.GetColumnByFieldName('CanBeOutToFN').Options.Editing := True;
  end;//if
  
  CDSEditCarNO.IndexFieldNames := 'FN_Card;Fabric_NO';
  CDSEditCarNO.First;
  EdtCarNo.Text := CDSEditCarNO.FieldByName('Car_No').AsString;

  GIsAction := True;
end;

procedure TPrepareFabricForm.SBtnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TPrepareFabricForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TPrepareFabricForm.FormDestroy(Sender: TObject);
begin
  inherited;
  PrepareFabricForm := nil;
end;

function TPrepareFabricForm.GetOutGoFabricData(aDepartment: string): Boolean;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  Result := False;
  try
    ShowMsg('正在获取数据稍等!', crHourGlass);
    //获取备布数据
    sql := QuotedStr('GetOutGoFabricData') + ',' +  QuotedStr(aDepartment);
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

procedure TPrepareFabricForm.chkLocalQueryClick(Sender: TObject);
begin
  inherited;
  cxTVWait.OptionsView.GroupByBox := chkLocalQuery.Checked;
end;

procedure TPrepareFabricForm.SBtnRefreshClick(Sender: TObject);
begin
  inherited;
  Query;
end;

procedure TPrepareFabricForm.FormShow(Sender: TObject);
begin
  inherited;
  init;
end;

procedure TPrepareFabricForm.CDSEditCarNOAfterScroll(DataSet: TDataSet);
begin
  inherited;
  EdtCarNo.Text := TClientDataSet(DataSet).FieldByName('Car_No').AsString;
end;

function TPrepareFabricForm.EditNewLocation(aCDS: TClientDataSet; filterField, filterValue : array of String;
aLocateField, aEditField, aEditValue : String) : Boolean;
var
  //carNo : string;
  locateValue, value, oldFilterStr, filterStr : String;
  i : Integer;
begin
  Result := False;
  //carNo := aCDS.FieldByName('Car_No').AsString;
  locateValue := aCDS.FieldByName(aLocateField).AsString;
  oldFilterStr := aCDS.Filter;
  try
    aCDS.DisableControls;
    for i := 0 to Length(filterField) - 1 do
    begin
      if (filterStr <> '') then
        filterStr := filterStr + ' and ' + filterField[i] + ' = ' + QuotedStr(filterValue[i])
      else
        filterStr := filterField[i] + ' = ' + QuotedStr(filterValue[i]);
    end;
    //aCDS.Filter := 'Car_No = ' + QuotedStr(EdtCarNo.Text);
    aCDS.Filter := filterStr;// aFilterField + ' = ' + QuotedStr(aFilterValue);
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
          //aCDS.FieldByName('NewLocation').AsString := EdtNewLocation.Text;
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
    end;//if
    //aCDS.Locate('Car_No', carNo, []);
    aCDS.Locate(aLocateField, locateValue, []);
    aCDS.EnableControls;
  end;//finally
end;

procedure TPrepareFabricForm.Save;
var
  updateList : string;
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  if CDSEditCarNO.State in [dsEdit, dsInsert] then
    CDSEditCarNO.Post;

  if CDSEditCarNO.ChangeCount > 0  then
  begin
    try
      ShowMsg('正在保存数据稍等!', crHourGlass);

      updateList := GetSaveString(CDSEditCarNO);
      sql := QuotedStr('SaveOutGoFabricNewLocationData') + ',' + QuotedStr(updateList);
      FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);
      if Trim(sErrorMsg) <> '' then
      begin
        TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
        Exit;
      end;//if
      CDSEditCarNO.MergeChangeLog;
      TMsgDialog.ShowMsgDialog('数据保存成功', mtInformation);
    finally
      GIsEditNewLocation := false;
      ShowMsg('', crDefault);
    end;//finally
  end;//if
end;

function TPrepareFabricForm.GetSaveString(aCDS: TClientDataSet): String;
var
  fnCardList, newLocationList, canBeToFNList : string;
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
          if GIsEditNewLocation then
          begin
            newLocationList := newLocationList +
                IfThen(Trim(cds.FieldByName('NewLocation').AsString) <> '',
                          Trim(cds.FieldByName('NewLocation').AsString), 'NULL') + ',';
          end;//if
          canBeToFNList := canBeToFNList + cds.FieldByName('CanBeOutToFN').AsString + ',';
        end;//else
        cds.Next;
      end;//while
      Result := fnCardList + '|' + newLocationList + '|' + canBeToFNList;
    end;//if
  finally
    if Assigned(cds) then
    begin
      cds.Close;
      FreeAndNil(cds);
    end;//if
  end;
end;

procedure TPrepareFabricForm.SBtnEditClick(Sender: TObject);
begin
  inherited;
  //GIsEditNewLocation := EditNewLocation(CDSEditCarNO, 'Fabric_NO', 'Car_No', EdtCarNo.Text, 'NewLocation', EdtNewLocation.Text);
  GIsEditNewLocation := EditNewLocation(CDSEditCarNO,
                    ['Car_No','Src_Department','Dest_Department'],
                    [EdtCarNo.Text, CDSEditCarNO.FieldByName('Src_Department').AsString, CDSEditCarNO.FieldByName('Dest_Department').AsString],
                    'Fabric_NO', 'NewLocation', EdtNewLocation.Text);
end;

procedure TPrepareFabricForm.SBtnSaveClick(Sender: TObject);
begin
  inherited;
  Save;
end;

procedure TPrepareFabricForm.cxTVWaitEditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
  inherited;
  {
    EditNewLocation(CDSEditCarNO, 'Fabric_NO', 'FN_Card', CDSEditCarNO.FieldByName('FN_Card').AsString,
    'CanBeOutToFN', ifthen(CDSEditCarNO.FieldByName('CanBeOutToFN').AsBoolean, 'False', 'True'));
  }
  EditNewLocation(CDSEditCarNO,
                    ['FN_Card','Src_Department','Dest_Department'],
                    [CDSEditCarNO.FieldByName('FN_Card').AsString, CDSEditCarNO.FieldByName('Src_Department').AsString, CDSEditCarNO.FieldByName('Dest_Department').AsString],
                    'Fabric_NO',
                    'CanBeOutToFN', ifthen(CDSEditCarNO.FieldByName('CanBeOutToFN').AsBoolean, 'False', 'True'));
end;

procedure TPrepareFabricForm.EdtNewLocationKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  TEdit(Sender).CharCase := ecUpperCase;
end;

procedure TPrepareFabricForm.cxTVWaitDataControllerFilterBeforeChange(
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

procedure TPrepareFabricForm.CancelFNCard(aFNCard : string);
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
  locateStr, oldFilter : String;
begin
  if Trim(aFNCard) = '' then
    Exit;

  if MessageDlg('是否对卡号[' + aFNCard + ']执撤销后整卡号操作?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  try
    ShowMsg('正在处理数据稍等!', crHourGlass);
    sql := QuotedStr('CancelFNCard') + ',' + QuotedStr(aFNCard);
    FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);

    if Trim(sErrorMsg) <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;//if
    //清空本地卡号
    oldFilter :=  CDSEditCarNO.Filter;
    CDSEditCarNO.DisableControls;
    CDSEditCarNO.Filter := 'FN_Card = ' + QuotedStr(aFNCard);
    CDSEditCarNO.Filtered := True;
    
    CDSEditCarNO.First;
    locateStr := CDSEditCarNO.FieldByName('Fabric_NO').AsString;
    while not CDSEditCarNO.Eof do
    begin
      CDSEditCarNO.Edit;
      CDSEditCarNO.FieldByName('FN_Card').AsString := '';
      CDSEditCarNO.Post;
      //CDSEditCarNO.Next;
    end;//while
    CDSEditCarNO.MergeChangeLog;
    TMsgDialog.ShowMsgDialog('数据处理成功', mtInformation);
  finally
    CDSEditCarNO.Filtered := False;
    CDSEditCarNO.Filter := '';
    if oldFilter <> '' then
    begin
      CDSEditCarNO.Filter := oldFilter;
      CDSEditCarNO.Filtered := True;
    end;//if
    CDSEditCarNO.Locate('Fabric_NO', locateStr, []);
    CDSEditCarNO.EnableControls;
    ShowMsg('', crDefault);
  end;//finally
end;

procedure TPrepareFabricForm.SBtnCancelFNCardClick(Sender: TObject);
begin
  inherited;
  CancelFNCard(CDSEditCarNO.FieldByName('FN_Card').AsString);
end;

function TPrepareFabricForm.GetUserLevel(aUserId, aSystemID: String) : Boolean;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  Result := False;
  try
    sql := QuotedStr('GetUserLevel') + ',' + QuotedStr(aUserId + '|' + aSystemID);
    FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);
    if Trim(sErrorMsg) <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;//if

    CDSUserLevel.Data := vData;
    if (CDSUserLevel.Active) and (CDSUserLevel.RecordCount > 0) then
      Result := True;
  finally
    GIsEditNewLocation := false;
    ShowMsg('', crDefault);
  end;//finally
end;

end.
