{******************************************************************************
                                                                              
       软件名称 FNM                                                            
       版权所有 (C) 2004-2009 ESQUEL GROUP GET/IT
       单元名称 frmTraceRepair.pas
       创建日期 2009-04-28 10:54:40                                            
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
unit frmTraceRepair;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, StdCtrls, Buttons, ExtCtrls, DBClient;

type
  TTraceRepairForm = class(TBaseForm)
    pnl1: TPanel;
    pnl2: TPanel;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Refresh: TBitBtn;
    btnCancel: TBitBtn;
    cxgridTraceRepair: TcxGrid;
    cxgridtvTraceRepair: TcxGridDBTableView;
    cxGridlTraceRepair: TcxGridLevel;
    dsTraceRepair: TDataSource;
    cdsTraceRepair: TClientDataSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure cxgridtvTraceRepairFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure cxgridtvTraceRepairFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
  private
    { Private declarations }   
    bModified:Boolean;
    procedure SetBtnState;
    procedure DataRefresh;
    procedure DataSave;
    procedure DataCancel;
    procedure DataModify;
    function CloseQuery:Boolean;
  public
    { Public declarations }
  end;

var
  TraceRepairForm: TTraceRepairForm;

implementation

uses ServerDllPub, uLogin, uShowMessage, uGlobal, uGridDecorator;

{$R *.dfm}

function TTraceRepairForm.CloseQuery: Boolean;
begin
  if not TGlobal.DeltaIsNull(cdsTraceRepair) then
    if TMsgDialog.ShowMsgDialog('数据未保存，是否保存！', mtConfirmation, [mebYes, mebNo], mebYes)= mrNo then
      Result := false
     else
       Result := true
  else
    Result := False;
end;

procedure TTraceRepairForm.DataCancel;
begin
  cdsTraceRepair.CancelUpdates;
  SetBtnState;
end;

procedure TTraceRepairForm.DataModify;
begin
  //如果修改了增加修改人、修改时间
  if bModified then
  begin
    with cdsTraceRepair do
    begin
      FieldByName('Operator').ReadOnly := False;
      FieldByName('Operate_Time').ReadOnly := False;
      FieldByName('Dept').ReadOnly := False;

      Edit;
      FieldByName('Operator').Value := login.LoginName;
      FieldByName('Operate_Time').Value := TGlobal.GetServerTime;
      FieldByName('Dept').Value := login.CurrentDepartment;
      Post;

      FieldByName('Operator').ReadOnly := True;
      FieldByName('Operate_Time').ReadOnly := True;
      FieldByName('Dept').ReadOnly := True;
    end;
  end;
  bModified := False;
  SetBtnState;
end;

procedure TTraceRepairForm.DataRefresh;
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
begin
  try
    ShowMsg('', crHourGlass);
    cdsTraceRepair.DisableControls;

    if CloseQuery then Exit;

    sSQL := QuotedStr(login.CurrentDepartment);
    FNMServerObj.GetQueryData(vData, 'GetRepairInfo', sSQL, sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsTraceRepair.Data := vData;

    if cdsTraceRepair.IsEmpty then Exit;
    if cxgridtvTraceRepair.ColumnCount<2 then
    begin
      GridDecorator.BindCxViewWithDataSource(cxgridtvTraceRepair, dsTraceRepair);

      //'Operator', 'Operate_Time', 'Dept'
      GridDecorator.SetcxTableView(cxgridtvTraceRepair, ['Dept'], ['Repair_Grade', 'Pre_Dispose', 'Pre_Time', 'Fact_Dispose', 'Remark']);
    end;

  finally
    cdsTraceRepair.EnableControls;
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TTraceRepairForm.DataSave;
var
  vData: OleVariant;
  sErrMsg:WideString;
  i: Integer;
begin
  try
    ShowMsg('', crHourGlass);
    if TGlobal.DeltaIsNull(cdsTraceRepair) then Exit;

    cdsTraceRepair.DisableControls;

    with cdsTraceRepair do
    begin
      //'Repair_Grade', 'Pre_Dispose', 'Pre_Time', 'Fact_Dispose', 'Remark'
      if (FieldByName('Repair_Grade').OldValue<>FieldByName('Repair_Grade').Value)
        or (FieldByName('Pre_Dispose').OldValue<>FieldByName('Pre_Dispose').Value)
        or (FieldByName('Pre_Time').OldValue<>FieldByName('Pre_Time').Value)
        or (FieldByName('Fact_Dispose').OldValue<>FieldByName('Fact_Dispose').Value)
        or (FieldByName('Remark').OldValue<>FieldByName('Remark').Value) then
      begin
        bModified := True;
        DataModify;
        bModified := False;
      end;
    end;
    //保存数据
    vData := cdsTraceRepair.Delta;
    FNMServerObj.SaveBaseTableInfo(vData, 'fnTraceRepair', 'Fabric_NO,Repair_Reason,Quantity', sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsTraceRepair.MergeChangeLog;

  finally
    cdsTraceRepair.EnableControls;
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TTraceRepairForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TTraceRepairForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := not CloseQuery;
end;

procedure TTraceRepairForm.FormDestroy(Sender: TObject);
begin
  inherited;
  TraceRepairForm := nil;
end;

procedure TTraceRepairForm.FormShow(Sender: TObject);
begin
  inherited;
  DataRefresh;
end;

procedure TTraceRepairForm.SetBtnState;
begin
  btn_Save.Enabled := not TGlobal.DeltaIsNull(cdsTraceRepair);
  btnCancel.Enabled := btn_Save.Enabled;
end;

procedure TTraceRepairForm.btn_RefreshClick(Sender: TObject);
begin
  inherited;
  DataRefresh;
end;

procedure TTraceRepairForm.btn_SaveClick(Sender: TObject);
begin
  inherited;
  DataSave;
end;

procedure TTraceRepairForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  DataCancel;
end;

procedure TTraceRepairForm.btn_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TTraceRepairForm.cxgridtvTraceRepairFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  SetBtnState;
end;

procedure TTraceRepairForm.cxgridtvTraceRepairFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;  
  SetBtnState;
end;

end.




