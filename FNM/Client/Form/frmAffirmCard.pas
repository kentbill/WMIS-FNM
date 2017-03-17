unit frmAffirmCard;
{******************************************************************************

       软件名称 FNM
       版权所有 (C) 2004-2012 ESQUEL GROUP GET/IT
       创建日期 2011-04-12 10:54:40
       创建人员 cuijf
       修改人员
       修改日期
       修改原因
       对应用例
       字段描述
       相关数据库表
       调用重要函数/SQL对象说明
       功能描述

******************************************************************************}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ExtCtrls, cxContainer, cxCheckBox, StdCtrls,
  Buttons, cxDBEdit,frmAffirmBox,frmCreateAffirmHand;

type
  TAffirmCardForm = class(TBaseForm)
    pnl2: TPanel;
    cxgrdSTDArt: TcxGrid;
    cxgdtvSTDArt: TcxGridDBTableView;
    cxgrdlvlSTDArt: TcxGridLevel;
    dsAffirmCard: TDataSource;
    cdsAffirmCard: TClientDataSet;
    pnl1: TPanel;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Refresh: TBitBtn;
    btnCancel: TBitBtn;
    cxcbAll: TcxCheckBox;
    cxcbCheckAll: TcxCheckBox;
    cxcbNoTrace: TcxCheckBox;
    cxgrdAffirmCard: TcxGrid;
    cxgdtvAffirmCard: TcxGridDBTableView;
    cxgrdlvlAffirmCard: TcxGridLevel;
    cdsSTDArt: TClientDataSet;
    dsSTDArt: TDataSource;
    btn_NotTrace: TBitBtn;
    btn_Ignore: TBitBtn;
    btn_Trace: TBitBtn;
    btnNew: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cxgdtvSTDArtFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure cxcbCheckAllPropertiesChange(Sender: TObject);
    procedure cxcbNoTracePropertiesChange(Sender: TObject);
    procedure cxcbAllPropertiesChange(Sender: TObject);
    procedure cxgdtvAffirmCardDblClick(Sender: TObject);
    procedure cxgdtvAffirmCardCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgdtvAffirmCardMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure cxcbNoTraceClick(Sender: TObject);
    procedure cxcbCheckAllClick(Sender: TObject);
    procedure btn_NotTraceClick(Sender: TObject);
    procedure btn_TraceClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btn_IgnoreClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetBtnState;
    procedure DataRefresh;
    procedure DataSave;
    procedure DataCancel;
    procedure DataQuery;
    function CloseQuery:Boolean;
    procedure SetFieldValue(Sender: TField; const Text: String);
  public
    { Public declarations }
  end;

var
  AffirmCardForm: TAffirmCardForm;

implementation

uses  ServerDllPub, uGlobal, uShowMessage, uLogin, uGridDecorator, uFNMArtInfo,
  uDictionary;
{$R *.dfm}

procedure TAffirmCardForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TAffirmCardForm.FormDestroy(Sender: TObject);
begin
  inherited;
  AffirmCardForm := nil;
end;

procedure TAffirmCardForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := CloseQuery;
end;

function TAffirmCardForm.CloseQuery: Boolean;
begin
  Result := True;
  if not TGlobal.DeltaIsNull(cdsAffirmCard) then
  begin
    if TMsgDialog.ShowMsgDialog('数据未保存，是否保存！', mtConfirmation, [mebYes, mebNo], mebYes)= mrYes then
      Result := false;
  end
  else
    Result := True;
end;

procedure TAffirmCardForm.DataCancel;
begin
  cdsAffirmCard.CancelUpdates;
end;

procedure TAffirmCardForm.DataQuery;
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
begin
  try
    ShowMsg('正在查询稍等！', crHourGlass);

    //if not CloseQuery then Exit;

    //FNMServerObj.GetBaseTableInfo(vData,'fnAffirmCardTrace',sErrMsg);
    sSQL := QuotedStr(login.CurrentDepartment);
    FNMServerObj.GetQueryData(vData, 'fnAffirmCardTrace', sSQL, sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsAffirmCard.Data := vData;

    //if cdsAffirmCard.IsEmpty then Exit;
    if cxgdtvAffirmCard.ColumnCount<2 then
    begin
      GridDecorator.BindCxViewWithDataSource(cxgdtvAffirmCard, dsAffirmCard);
      //GridDecorator.SetcxTableView(cxgdtvAffirmCard, ['Operator','Operate_Time','Dept'], ['Ignore','Remark','Operator','Operate_Time','Is_Active']);
      cxgdtvAffirmCard.GetColumnByFieldName('Defect_Prevent').Caption := '疵点防范';
      cxgdtvAffirmCard.GetColumnByFieldName('Ignore').Caption := '忽略';
      cxgdtvAffirmCard.GetColumnByFieldName('Is_Active').Caption := '跟踪';

      cdsAffirmCard.FieldByName('Ignore').OnSetText := SetFieldValue;
      cdsAffirmCard.FieldByName('Remark').OnSetText := SetFieldValue;
    end;

    cxgdtvAffirmCard.ApplyBestFit(nil);
//    if not cxcbAll.Checked then
//    begin
//      cdsAffirmCard.Filtered := False;
//      cdsAffirmCard.Filter := 'Is_Active';
//      cdsAffirmCard.Filtered := True;
//    end
//    else
//      cdsAffirmCard.Filtered := False;


  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TAffirmCardForm.DataRefresh;
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

procedure TAffirmCardForm.DataSave;
var
  vData: OleVariant;
  sErrMsg: WideString;
  GF_ID, Step_NO, i,is_Active,is_ignore:Integer;
  Job_NO, Defect_Prevent:String;
begin
  try
    ShowMsg('', crHourGlass);

    with cxgdtvAffirmCard do
    begin
      for i:=0 to Controller.SelectedRowCount-1 do
      begin
        GF_ID := Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_ID').Index];
        Step_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Step_NO').Index];
        Job_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Job_NO').Index];
        Defect_Prevent := Controller.SelectedRows[i].Values[GetColumnByFieldName('Defect_Prevent').Index];
        is_Active := Controller.SelectedRows[i].Values[GetColumnByFieldName('is_active').Index];
        is_ignore := Controller.SelectedRows[i].Values[GetColumnByFieldName('Ignore').Index];

        if cdsAffirmCard.Locate('GF_ID;Step_NO;Job_NO;Defect_Prevent',VarArrayOf([GF_ID,Step_NO,Job_NO,Defect_Prevent]),[]) then
        with cdsAffirmCard do
        begin
          Edit;
          if is_ignore = 0 then
            FieldByName('Ignore').AsBoolean := False
          else
            FieldByName('Ignore').AsBoolean := True;

          if is_Active = 0 then
            FieldByName('is_active').AsBoolean := False
          else
            FieldByName('is_active').AsBoolean := True;

          FieldByName('Operator').AsString:= login.LoginName;
          FieldByName('Operate_Time').AsDateTime:= TGlobal.GetServerTime;
          Post;
        end;
      end;
    end;

    if TGlobal.DeltaIsNull(cdsAffirmCard) then Exit;

    vData := cdsAffirmCard.Delta;
    FNMServerObj.SaveBaseTableInfo(vData,'uvw_fnAffirmCardTrace','',sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsAffirmCard.MergeChangeLog;

    TMsgDialog.ShowMsgDialog('数据保存成功！',mtInformation);
  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;

end;

procedure TAffirmCardForm.SetBtnState;
begin
  btn_Save.Enabled := not TGlobal.DeltaIsNull(cdsAffirmCard);
  btnCancel.Enabled := btn_Save.Enabled;               
end;

procedure TAffirmCardForm.btn_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TAffirmCardForm.FormShow(Sender: TObject);
begin
  inherited;
  DataRefresh;
end;

procedure TAffirmCardForm.btn_RefreshClick(Sender: TObject);
begin
  inherited;
  DataRefresh;
end;

procedure TAffirmCardForm.btn_SaveClick(Sender: TObject);
begin
  inherited;
  DataSave;
end;

procedure TAffirmCardForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  DataCancel;
end;

procedure TAffirmCardForm.SetFieldValue(Sender: TField; const Text: String);
begin
  with Sender.DataSet do
  begin
    if Text <> '' then
        FieldByName(Sender.FieldName).AsString := Text;

    Sender.DataSet.FieldByName('Operator').AsString:= login.LoginName;
    Sender.DataSet.FieldByName('Operate_Time').AsDateTime:= TGlobal.GetServerTime;

  end;
  SetBtnState;
end;

procedure TAffirmCardForm.cxgdtvSTDArtFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  SetBtnState;
end;

procedure TAffirmCardForm.cxcbCheckAllPropertiesChange(Sender: TObject);
var
  GF_ID, Step_NO, i:Integer;
  Job_NO, Defect_Prevent:String;
begin
  inherited;
//  if cxcbCheckAll.Checked then
//  begin
//    try
//      ShowMsg('',crHourGlass);
//      with cxgdtvAffirmCard do
//      begin
//        //DataController.SelectAll;
//        if Controller.SelectedRowCount>100 then
//        begin
//          TMsgDialog.ShowMsgDialog('一次操作数据太多，请分批操作！', mtInformation);
//          Exit;
//        end;
//
//        cdsAffirmCard.DisableControls;
//        for i:=0 to Controller.SelectedRowCount-1 do
//        begin
//          GF_ID := Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_ID').Index];
//          Step_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Step_NO').Index];
//          Job_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Job_NO').Index];
//          Defect_Prevent := Controller.SelectedRows[i].Values[GetColumnByFieldName('Defect_Prevent').Index];
//          if cdsAffirmCard.Locate('GF_ID;Step_NO;Job_NO;Defect_Prevent',VarArrayOf([GF_ID,Step_NO,Job_NO,Defect_Prevent]),[]) then
//          with cdsAffirmCard do
//          begin
//            Edit;
//            if cxcbCheckAll.Checked then
//              FieldByName('Ignore').AsBoolean := True
//            else
//              FieldByName('Ignore').AsBoolean := False;
//
//            FieldByName('Operator').AsString:= login.LoginName;
//            FieldByName('Operate_Time').AsDateTime:= TGlobal.GetServerTime;
//            Post;
//          end;
//        end;
//      end;
//    finally
//        cdsAffirmCard.enableControls;
//        ShowMsg('',crDefault);
//    end;
//  end;
end;

procedure TAffirmCardForm.cxcbNoTracePropertiesChange(Sender: TObject);
var
  GF_ID, Step_NO, i:Integer;
  Job_NO, Defect_Prevent:String;
begin
  inherited;
//  if cxcbNoTrace.Checked then
//  begin
//    try
//      ShowMsg('',crHourGlass);
//      with cxgdtvAffirmCard do
//      begin
//        //DataController.SelectAll;
//        if Controller.SelectedRowCount>100 then
//        begin
//          TMsgDialog.ShowMsgDialog('一次操作数据太多，请分批操作！', mtInformation);
//          Exit;
//        end;
//
//        cdsAffirmCard.DisableControls;
////        cdsAffirmCard.Filtered := False;
//        for i:=0 to Controller.SelectedRowCount-1 do
//        begin
//          GF_ID := Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_ID').Index];
//          Step_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Step_NO').Index];
//          Job_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Job_NO').Index];
//          Defect_Prevent := Controller.SelectedRows[i].Values[GetColumnByFieldName('Defect_Prevent').Index];
//          if cdsAffirmCard.Locate('GF_ID;Step_NO;Job_NO;Defect_Prevent',VarArrayOf([GF_ID,Step_NO,Job_NO,Defect_Prevent]),[]) then
//          with cdsAffirmCard do
//          begin
//            Edit;
//            if cxcbNoTrace.Checked then
//              FieldByName('Is_Active').AsBoolean := False
//            else
//              FieldByName('Is_Active').AsBoolean := True;
//
//            FieldByName('Operator').AsString:= login.LoginName;
//            FieldByName('Operate_Time').AsDateTime:= TGlobal.GetServerTime;
//            Post;
//          end;
//        end;
//      end;
//    finally
////      cdsAffirmCard.Filtered := True;
//      cdsAffirmCard.EnableControls;
//      ShowMsg('',crDefault);
//    end;
//  end;
end;

procedure TAffirmCardForm.cxcbAllPropertiesChange(Sender: TObject);
begin
  inherited;
//  if not cxcbAll.Checked then
//  begin
//    cdsAffirmCard.Filtered := False;
//    cdsAffirmCard.Filter := 'Is_Active';
//    cdsAffirmCard.Filtered := True;
//  end
//  else
//    cdsAffirmCard.Filtered := False;
end;

procedure TAffirmCardForm.cxgdtvAffirmCardDblClick(Sender: TObject);
var
  sSQL,sGF_NO:string;
  vData:OleVariant ;
  sErrMsg:WideString;
begin
  inherited;
  sGF_NO := cxgdtvAffirmCard.Controller.SelectedRows[0].Values[cxgdtvAffirmCard.GetColumnByFieldName('GF_NO').Index];
    sSQL :=QuotedStr(sGF_NO) + ',5,' + QuotedStr(login.CurrentDepartment);
    FNMServerObj.GetQueryData(vData, 'GetColorInfo', sSQL, sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsSTDArt.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxgdtvSTDArt, dsSTDArt);
end;

procedure TAffirmCardForm.cxgdtvAffirmCardCellClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  if cxgdtvAffirmCard.Controller.SelectedRowCount >0 then
     btn_Save.Enabled := True;
  cxcbNoTrace.Checked := False;
end;

procedure TAffirmCardForm.cxgdtvAffirmCardMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if cxgdtvAffirmCard.Controller.SelectedRowCount >0 then
     btn_Save.Enabled := True;
end;

procedure TAffirmCardForm.cxcbNoTraceClick(Sender: TObject);
var
  GF_ID, Step_NO, i:Integer;
  Job_NO, Defect_Prevent:String;
begin
  inherited;
  try
    ShowMsg('',crHourGlass);
    with cxgdtvAffirmCard do
    begin
      //DataController.SelectAll;
      if Controller.SelectedRowCount>100 then
      begin
        TMsgDialog.ShowMsgDialog('一次操作数据太多，请分批操作！', mtInformation);
        Exit;
      end;

      cdsAffirmCard.DisableControls;
//        cdsAffirmCard.Filtered := False;
      for i:=0 to Controller.SelectedRowCount-1 do
      begin
        GF_ID := Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_ID').Index];
        Step_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Step_NO').Index];
        Job_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Job_NO').Index];
        Defect_Prevent := Controller.SelectedRows[i].Values[GetColumnByFieldName('Defect_Prevent').Index];
        if cdsAffirmCard.Locate('GF_ID;Step_NO;Job_NO;Defect_Prevent',VarArrayOf([GF_ID,Step_NO,Job_NO,Defect_Prevent]),[]) then
        with cdsAffirmCard do
        begin
          Edit;
          if cxcbNoTrace.Checked then
            FieldByName('Is_Active').AsBoolean := False
          else
            FieldByName('Is_Active').AsBoolean := True;

          FieldByName('Operator').AsString:= login.LoginName;
          FieldByName('Operate_Time').AsDateTime:= TGlobal.GetServerTime;
          Post;
        end;
      end;
    end;
  finally
//      cdsAffirmCard.Filtered := True;
    cdsAffirmCard.EnableControls;
    ShowMsg('',crDefault);
  end;
end;

procedure TAffirmCardForm.cxcbCheckAllClick(Sender: TObject);
var
  GF_ID, Step_NO, i:Integer;
  Job_NO, Defect_Prevent:String;
begin
  inherited;
  try
    ShowMsg('',crHourGlass);
    with cxgdtvAffirmCard do
    begin
      //DataController.SelectAll;
      if Controller.SelectedRowCount>100 then
      begin
        TMsgDialog.ShowMsgDialog('一次操作数据太多，请分批操作！', mtInformation);
        Exit;
      end;

      cdsAffirmCard.DisableControls;
      for i:=0 to Controller.SelectedRowCount-1 do
      begin
        GF_ID := Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_ID').Index];
        Step_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Step_NO').Index];
        Job_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Job_NO').Index];
        Defect_Prevent := Controller.SelectedRows[i].Values[GetColumnByFieldName('Defect_Prevent').Index];
        if cdsAffirmCard.Locate('GF_ID;Step_NO;Job_NO;Defect_Prevent',VarArrayOf([GF_ID,Step_NO,Job_NO,Defect_Prevent]),[]) then
        with cdsAffirmCard do
        begin
          Edit;
          if cxcbCheckAll.Checked then
            FieldByName('Ignore').AsBoolean := True
          else
            FieldByName('Ignore').AsBoolean := False;

          FieldByName('Operator').AsString:= login.LoginName;
          FieldByName('Operate_Time').AsDateTime:= TGlobal.GetServerTime;
          Post;
        end;
      end;
    end;
  finally
      cdsAffirmCard.enableControls;
      ShowMsg('',crDefault);
  end;

end;

procedure TAffirmCardForm.btn_NotTraceClick(Sender: TObject);
var
  sCondition,sErrorMsg: WideString;
  i:Integer;
  GF_ID, Step_NO, Operation_Code :string;
begin
  inherited;
  with cxgdtvAffirmCard do
  begin
    for i:=0 to Controller.SelectedRowCount-1 do
    begin
      GF_ID := Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_ID').Index];
      Step_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Step_NO').Index];
      Operation_Code := Controller.SelectedRows[i].Values[GetColumnByFieldName('Operation_Code').Index];
      sCondition := sCondition  + QuotedStr(GF_ID) + ',' + Step_NO + ',' + QuotedStr(Operation_Code) + ';';
    end;
  end;
  sCondition := QuotedStr(login.LoginName) + ',' + QuotedStr(login.CurrentDepartment) + ',' + QuotedStr(sCondition) + ',1,0';
  FNMServerObj.SaveDataBySQL('SaveAffirmCardTrace',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog('修改状态失败!',mtError);
    Exit;
  end;
  TMsgDialog.ShowMsgDialog('修改成功!',mtInformation);
end;

procedure TAffirmCardForm.btn_TraceClick(Sender: TObject);
var
  sCondition,sErrorMsg: WideString;
  i:Integer;
  GF_ID, Step_NO, Operation_Code :string;
begin
  inherited;
  with cxgdtvAffirmCard do
  begin
    for i:=0 to Controller.SelectedRowCount-1 do
    begin
      GF_ID := Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_ID').Index];
      Step_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Step_NO').Index];
      Operation_Code := Controller.SelectedRows[i].Values[GetColumnByFieldName('Operation_Code').Index];
      sCondition := sCondition  + QuotedStr(GF_ID) + ',' + Step_NO + ',' + QuotedStr(Operation_Code) + ';';
    end;
  end;
  sCondition := QuotedStr(login.LoginName) + ',' + QuotedStr(login.CurrentDepartment) + ',' + QuotedStr(sCondition) + ',1,1';
  FNMServerObj.SaveDataBySQL('SaveAffirmCardTrace',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog('修改状态失败!',mtError);
    Exit;
  end;
  CreateNewRemark(GF_ID,Step_NO,Operation_Code);
  TMsgDialog.ShowMsgDialog('修改成功!',mtInformation);
end;

procedure TAffirmCardForm.btnNewClick(Sender: TObject);
begin
  inherited;
  if CreateAffirmHandForm = nil then
     CreateAffirmHandForm:=TCreateAffirmHandForm.Create(Application);
  CreateAffirmHandForm.ShowModal;
end;

procedure TAffirmCardForm.btn_IgnoreClick(Sender: TObject);
var
  sCondition,sErrorMsg: WideString;
  i:Integer;
  GF_ID, Step_NO, Operation_Code :string;
begin
  inherited;
   with cxgdtvAffirmCard do
  begin
    for i:=0 to Controller.SelectedRowCount-1 do
    begin
      GF_ID := Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_ID').Index];
      Step_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Step_NO').Index];
      Operation_Code := Controller.SelectedRows[i].Values[GetColumnByFieldName('Operation_Code').Index];
      sCondition := sCondition  + QuotedStr(GF_ID) + ',' + Step_NO + ',' + QuotedStr(Operation_Code) + ';';
    end;
  end;
  sCondition := QuotedStr(login.LoginName) + ',' + QuotedStr(login.CurrentDepartment) + ',' + QuotedStr(sCondition) + ',0,1';
  FNMServerObj.SaveDataBySQL('SaveAffirmCardTrace',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog('修改状态失败!',mtError);
    Exit;
  end;
  CreateNewRemark(GF_ID,Step_NO,Operation_Code);
  TMsgDialog.ShowMsgDialog('修改成功!',mtInformation);
end;

end.

