unit frmSendInfoManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ExtCtrls, cxContainer, cxCheckBox, StdCtrls,
  Buttons, ComCtrls;


type
  TSendInfoManageForm = class(TBaseForm)
    GroupBox1: TGroupBox;
    cxgrdSendInfo: TcxGrid;
    cxgdtvSendInfo: TcxGridDBTableView;
    cxgrdlvlSendInfo: TcxGridLevel;
    dsSendInfo: TDataSource;
    cdsSendInfo: TClientDataSet;
    btn_Save: TBitBtn;
    btnCancel: TBitBtn;
    btn_Exit: TBitBtn;
    GroupBox2: TGroupBox;
    btn_AddCard: TSpeedButton;
    btn_RemoveCard: TSpeedButton;
    lv_Load: TListView;
    btn_Refefesh: TSpeedButton;
    procedure btn_RefreshClick(Sender: TObject);
    procedure DataRefresh;
    procedure DataQuery;
    procedure SetBtnState;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure DataCancel;
    procedure btn_AddCardClick(Sender: TObject);
    procedure btn_RefefeshClick(Sender: TObject);
    procedure btn_RemoveCardClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SendInfoManageForm: TSendInfoManageForm;

implementation

uses  ServerDllPub, uGlobal, uShowMessage, uLogin, uGridDecorator, uFNMArtInfo,
  uDictionary;
{$R *.dfm}

procedure TSendInfoManageForm.btn_RefreshClick(Sender: TObject);
begin
  DataRefresh;
end;

procedure TSendInfoManageForm.DataRefresh;
var
  vData: OleVariant;
  sErrMsg: WideString;
begin
  try
    ShowMsg('', crHourGlass);
    DataQuery;
  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TSendInfoManageForm.DataQuery;
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
begin
  try
    ShowMsg('正在查询稍等！', crHourGlass);

    if not CloseQuery then Exit;

    FNMServerObj.GetBaseTableInfo(vData, 'fnPayHdr', sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsSendInfo.Data := vData;

    if cdsSendInfo.RecordCount <=0 then Exit;
    begin
      GridDecorator.BindCxViewWithDataSource(cxgdtvSendInfo, dsSendInfo);
//      GridDecorator.SetcxTableView(cxgdtvSendInfo, ['Operator','Operate_Time','Dept'], ['Ignore','Remark','Operator','Operate_Time','Is_Active']);
//      cxgdtvSendInfo.GetColumnByFieldName('Defect_Prevent').Caption := '疵点防范';
//      cxgdtvSendInfo.GetColumnByFieldName('Ignore').Caption := '忽略';
//      cxgdtvSendInfo.GetColumnByFieldName('Is_Active').Caption := '跟踪';
//
//      cdsSendInfo.FieldByName('Ignore').OnSetText := SetFieldValue;
//      cdsSendInfo.FieldByName('Remark').OnSetText := SetFieldValue;
    end;

    cxgdtvSendInfo.ApplyBestFit(nil);
    cdsSendInfo.Filtered := False;
    cdsSendInfo.Filter := 'Current_Department = '+ QuotedStr(login.CurrentDepartment);
    cdsSendInfo.Filtered := True;


  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;


procedure TSendInfoManageForm.SetBtnState;
begin
  btn_Save.Enabled := not TGlobal.DeltaIsNull(cdsSendInfo);
  btnCancel.Enabled := btn_Save.Enabled;
end;

procedure TSendInfoManageForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TSendInfoManageForm.FormDestroy(Sender: TObject);
begin
  SendInfoManageForm := nil;
end;

procedure TSendInfoManageForm.btnCancelClick(Sender: TObject);
begin
  DataCancel;
end;

procedure TSendInfoManageForm.DataCancel;
begin
  cdsSendInfo.CancelUpdates;
end;

procedure TSendInfoManageForm.btn_AddCardClick(Sender: TObject);
var
  i,j:Integer ;
begin

  with cxgdtvSendInfo do
  begin
    for i := 0 to Controller.SelectedRowCount - 1 do
    begin
      if Controller.SelectedRows[i].Values[GetColumnByFieldName('Send_Status').Index] = '未装车' then
        begin
        with lv_Load.Items.Add do
        begin
          Caption := Controller.SelectedRows[i].Values[GetColumnByFieldName('Note_NO').Index];
          SubItems.Add(Controller.SelectedRows[i].Values[GetColumnByFieldName('Destination').Index]);
        end;
      end;
    end;
    DataController.ClearSelection;
  end;
  if lv_Load.Items.Count > 0 then
    btn_Save.Enabled := True;
end;

procedure TSendInfoManageForm.btn_RefefeshClick(Sender: TObject);
begin
  DataRefresh;
end;

procedure TSendInfoManageForm.btn_RemoveCardClick(Sender: TObject);
begin
  lv_Load.DeleteSelected;
  if lv_Load.Items.Count = 0 then
    btn_Save.Enabled := False;
end;

procedure TSendInfoManageForm.btn_SaveClick(Sender: TObject);
var
  i: Integer;
  strSelect :string;
  vData:OleVariant;
  sCondition,sErrorMsg:WideString;
begin
  for i:= 0 to lv_Load.Items.Count -1 do
  begin
    strSelect := strSelect + lv_Load.Items[i].Caption + ',';
//    cdsSendInfo.Fields[6].ReadOnly := False;
//    if cdsSendInfo.Locate('Note_NO',lv_Load.Items[i].Caption,[]) then
//    begin
//       cdsSendInfo.Edit;
//       cdsSendInfo.FieldByName('Send_Status').Value := '已装车未收';
//       cdsSendInfo.Post;
//    end;
  end;

//  try
//    ShowMsg('', crHourGlass);
//    if TGlobal.DeltaIsNull(cdsSendInfo) then Exit;
//
//    vData := cdsSendInfo.Delta;
//    FNMServerObj.SaveBaseTableInfo(vData,'fnPayHdr','',sErrMsg);
//    if sErrMsg<>'' then
//    begin
//      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
//      Exit;
//    end;
//    cdsSendInfo.MergeChangeLog;
//    TMsgDialog.ShowMsgDialog('数据保存成功！',mtInformation);
//  finally
//    SetBtnState;
//    ShowMsg('', crDefault);
//  end;
  sCondition := QuotedStr(strSelect);
  try
    ShowMsg('正在保存数据稍等！', crHourGlass);
    FNMServerObj.SaveDataBySQL('SavePayStatus',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
  TMsgDialog.ShowMsgDialog('保存数据成功',mtInformation);
  lv_Load.Items.Clear;
  //速度慢
  //DataQuery;

  finally
    ShowMsg('', crDefault);
  end;
end;

end.
