unit frmEditCarNoByFNCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, Buttons, ExtCtrls, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, DBClient, StdCtrls, StrUtils, frmBase,
  Grids, DBGrids;

type
  TEditCarNoByFNCardForm = class(TBaseForm)
    cxGEditCarNO: TcxGrid;
    cxTVEditCarNO: TcxGridDBTableView;
    cxLEditCarNO: TcxGridLevel;
    PnlBottom: TPanel;
    Panel2: TPanel;
    SBtnExit: TSpeedButton;
    EdtNewCarNo: TEdit;
    Label2: TLabel;
    CDSEditCarNO: TClientDataSet;
    DSEditCarNOData: TDataSource;
    Label1: TLabel;
    EdtFNCard: TEdit;
    ButQuery: TButton;
    BtnEdit: TButton;
    BtnSave: TButton;
    lbl1: TLabel;
    edt1: TEdit;
    procedure SBtnExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButQueryClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure cxTVEditCarNODataControllerFilterBeforeChange(
      Sender: TcxDBDataFilterCriteria; ADataSet: TDataSet;
      const AFilterText: String);
    procedure EdtFNCardChange(Sender: TObject);
  private
    { Private declarations }
    procedure MyFormKeyPress(Sender: TObject; var Key: Char);
    procedure init;                                                             //初始化
    procedure Query;                                                            //查询方法
    function GetEditCarNoDataByFnCard(aFNCard : String) : Boolean;              //根据后整卡号查询数据
    procedure ControlButton(isAction : Boolean);
    function EditNewLocation(aCDS : TClientDataSet; aNewCarNo, aLocateField : String) : Boolean;
    function EditNewCarNO(aCDS : TClientDataSet; aNewCarNo, aLocateField : String) : Boolean;  // Added by WuDev 2016/9/8 16:06:21 增加车牌号修改
    function GetSaveString(aCDS : TClientDataSet) : String;
    procedure save;
  public
    { Public declarations }
  end;

var
  EditCarNoByFNCardForm: TEditCarNoByFNCardForm;

implementation

uses uFNMResource, ServerDllPub, uShowMessage, uGridDecorator, uLogin;

{$R *.dfm}

{ TEditCarNoByFNCardForm }

procedure TEditCarNoByFNCardForm.init;
begin
  {SButQuery.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  SBtnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  SBtnExit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  SBtnEdit.Glyph.LoadFromResourceName(HInstance, RES_EDIT);}

  ControlButton(False);

  Self.OnKeyPress := MyFormKeyPress;
  EdtFNCard.OnKeyPress := MyFormKeyPress;
  EdtNewCarNo.OnKeyPress := MyFormKeyPress;

  EdtFNCard.SetFocus;
end;

procedure TEditCarNoByFNCardForm.SBtnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TEditCarNoByFNCardForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TEditCarNoByFNCardForm.FormDestroy(Sender: TObject);
begin
  EditCarNoByFNCardForm := nil;
end;

procedure TEditCarNoByFNCardForm.FormShow(Sender: TObject);
begin
  init;
end;

procedure TEditCarNoByFNCardForm.Query;
var
  i : Integer;
begin
  if EdtFNCard.Text = '' then
    Exit;

  if not GetEditCarNoDataByFnCard(EdtFNCard.Text) then
  begin
      ControlButton(False);
      TMsgDialog.ShowMsgDialog('没有待修改车位的坯布数据', 2);
      Exit;
  end;

  //绑定cxGrid
  GridDecorator.BindCxViewWithDataSource(cxTVEditCarNO, DSEditCarNOData);
  for i := 0 to cxTVEditCarNO.ColumnCount - 1 do
    cxTVEditCarNO.Columns[i].Options.Editing := False;

  ControlButton(True);
  CDSEditCarNO.IndexFieldNames := 'Car_No;FN_Card';
end;

function TEditCarNoByFNCardForm.GetEditCarNoDataByFnCard(aFNCard: String): Boolean;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  Result := False;
  try
    ShowMsg('正在获取数据稍等!', crHourGlass);

    sql := QuotedStr('GetEditCarNODataByFnCard') + ',' + QuotedStr(aFNCard); // + '|' + Login.CurrentDepartment
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

procedure TEditCarNoByFNCardForm.ControlButton(isAction : Boolean);
begin
  BtnEdit.Enabled := isAction;
  BtnSave.Enabled := isAction;
end;

function TEditCarNoByFNCardForm.EditNewLocation(aCDS : TClientDataSet; aNewCarNo, aLocateField : String) : Boolean;
var
  locateValue : string;
begin
  Result := False;
  if (aCDS.Active) and (aCDS.RecordCount > 0) and (aNewCarNo <> '') then
  begin
    locateValue := aCDS.FieldByName(aLocateField).AsString;
    try
      aCDS.DisableControls;
      aCDS.First;
      while not aCDS.Eof do
      begin
        aCDS.Edit;
        aCDS.FieldByName('NewLocation').AsString := aNewCarNo;
        aCDS.Post;
        aCDS.Next;
      end;//while
    finally
      aCDS.EnableControls;
      aCDS.Locate(aLocateField, locateValue, []);
    end;//finally
  end;//if
end;
// Added by WuDev 2016/9/8 16:05:24 增加车牌号修改
function TEditCarNoByFNCardForm.EditNewCarNO(aCDS : TClientDataSet; aNewCarNo, aLocateField : String) : Boolean;
var
  locateValue,IndexFieldNames : string;
begin
  Result := False;
  IndexFieldNames:= aCDS.IndexFieldNames;
  aCDS.IndexFieldNames:= '';
  if (aCDS.Active) and (aCDS.RecordCount > 0) and (aNewCarNo <> '') then
  begin
    locateValue := aCDS.FieldByName(aLocateField).AsString;
    try
      aCDS.DisableControls;
      aCDS.First;
      while not aCDS.Eof do
      begin
        aCDS.Edit;
        aCDS.FieldByName('Car_No').AsString := aNewCarNo;
        aCDS.Post;
        aCDS.Next;
      end;//while
    finally
      aCDS.IndexFieldNames:= IndexFieldNames;
      aCDS.EnableControls;
      aCDS.Locate(aLocateField, locateValue, []);
    end;//finally
  end;//if
end;

procedure TEditCarNoByFNCardForm.MyFormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key <> #13 then
  begin
    if TWinControl(Sender).Name = 'EdtNewCarNo' then
      TEdit(Sender).CharCase := ecUpperCase;
  end
  else
  begin
    if TWinControl(Sender).Name = 'EdtFNCard' then
    begin
      if trim(EdtFNCard.Text) <> '' then
      begin
         ButQuery.OnClick(Sender);
         EdtNewCarNo.SetFocus;
         EdtNewCarNo.SelectAll;
      end;//if
    end
    else if TWinControl(Sender).Name = 'EdtNewCarNo' then
    begin
      if (trim(TEdit(Sender).Text) <> '') and (BtnSave.Enabled) then  //(BtnEdit.Enabled) and 
        if (CDSEditCarNO.Active) then
        begin
          //BtnEdit.OnClick(Sender);
          //BtnSave.SetFocus;
          BtnSave.OnClick(Sender);
        end;//if
    end;//else if
  end;//else
end;

function TEditCarNoByFNCardForm.GetSaveString(aCDS: TClientDataSet): String;
var
  fnCard, newLocation , newCarNo: string;     // Added by WuDev 2016/9/8 16:01:53 增加车牌号修改
begin
  Result := '';
  try
    if(aCDS.Active) and (aCDS.RecordCount > 0) then
    begin
      aCDS.DisableControls;

      aCDS.First;
      while not aCDS.Eof do
      begin
        if fnCard <> aCDS.FieldByName('FN_Card').AsString then
        begin
          fnCard := '';
          newLocation := '';
          newCarNo := '';     // Added by WuDev 2016/9/8 16:01:53 增加车牌号修改
          
          fnCard := aCDS.FieldByName('FN_Card').AsString;
          newLocation := aCDS.FieldByName('NewLocation').AsString;
          newCarNo :=  aCDS.FieldByName('Car_No').AsString;
          if newLocation = '' then
            newLocation := aCDS.FieldByName('Car_No').AsString;
        end;//if
        aCDS.Next;
      end;//while
      Result := fnCard + '|' + newLocation + '|' + login.LoginID + '|' +newCarNo;
    end;//if
  finally
    aCDS.EnableControls;
  end;//finally
end;

procedure TEditCarNoByFNCardForm.save;
var
  updateList : string;
  sql, sErrorMsg : WideString;
  vData : OleVariant;
  cds : TClientDataSet;
begin
  if Trim(EdtNewCarNo.Text) = '' then
    Exit;

  {if MessageDlg('是否执行保存操作?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;
  }
  EditNewCarNO(CDSEditCarNO,edt1.text,'Fabric_NO');
  EditNewLocation(CDSEditCarNO, EdtNewCarNo.Text, 'Fabric_NO');

  if CDSEditCarNO.State in [dsEdit, dsInsert] then
    CDSEditCarNO.Post;

  if CDSEditCarNO.ChangeCount > 0 then
  begin
    cds := TClientDataSet.Create(nil);

    try
      ShowMsg('正在保存数据稍等!', crHourGlass);
      updateList := GetSaveString(CDSEditCarNO);
      sql := QuotedStr('UpdateEditCarNODataByFnCard') + ',' + QuotedStr(updateList);
      FNMServerObj.GetQueryData(vData, 'GiFullCarFabricsData', sql, sErrorMsg);
      if Trim(sErrorMsg) <> '' then
      begin
        TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
        Exit;
      end;//if
      CDSEditCarNO.MergeChangeLog;

      cds.Data := vData;
      if cds.Active then
      begin
        if cds.FieldByName('IsUpdateJobTrace').AsBoolean then
          TMsgDialog.ShowMsgDialog('数据保存成功', mtInformation)
        else
          TMsgDialog.ShowMsgDialog('数据保存成功, 但该卡未出布, 未能执行下机操作', mtWarning);

          EdtNewCarNo.Text := '';
      end;//if

      EdtFNCard.SetFocus;
      EdtFNCard.SelectAll;
    finally
      if Assigned(cds) then
        FreeAndNil(cds);

      ShowMsg('', crDefault);
    end;//finally
  end;//if
end;

procedure TEditCarNoByFNCardForm.ButQueryClick(Sender: TObject);
begin
  inherited;
  Query;
end;

procedure TEditCarNoByFNCardForm.BtnEditClick(Sender: TObject);
begin
  inherited;
  EditNewLocation(CDSEditCarNO, EdtNewCarNo.Text, 'Fabric_NO');
end;

procedure TEditCarNoByFNCardForm.BtnSaveClick(Sender: TObject);
begin
  inherited;
  save;
end;

procedure TEditCarNoByFNCardForm.cxTVEditCarNODataControllerFilterBeforeChange(
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

procedure TEditCarNoByFNCardForm.EdtFNCardChange(Sender: TObject);
var
  key : Char;
begin
  inherited;
  if Length(Trim(TEdit(Sender).Text)) >= 9 then
  begin
    key := #13;
    MyFormKeyPress(Sender, key);
  end;//if
end;

end.
