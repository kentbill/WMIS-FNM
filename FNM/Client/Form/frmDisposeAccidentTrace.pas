{******************************************************************************
                                                                              
       软件名称 FNM                                                            
       版权所有 (C) 2004-2009 ESQUEL GROUP GET/IT
       单元名称 frmDisposeAccidentTrace.pas
       创建日期 2008-06-25 10:54:40                                            
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
unit frmDisposeAccidentTrace;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, Buttons, DBClient,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ExtCtrls, Grids, ValEdit, cxContainer, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCheckBox, cxDBEdit, cxMemo, ComCtrls;

type
  TDisposeAccidentTraceForm = class(TBaseForm)
    pnl1: TPanel;
    cdsAccident: TClientDataSet;
    dsAccident: TDataSource;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Refresh: TBitBtn;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    vle_RepairReasonList: TValueListEditor;
    cdsTmp: TClientDataSet;
    cxdbteAccident_NO: TcxDBTextEdit;
    cxdbteOperation_Name: TcxDBTextEdit;
    cxdbteDefect_Name: TcxDBTextEdit;
    cxdbteBefore_After: TcxDBTextEdit;
    cxdbteQuantity: TcxDBTextEdit;
    cxdbteQuality_Type: TcxDBTextEdit;
    cxdbteDispose_Info: TcxDBTextEdit;
    cxdbteQuality_Operation: TcxDBTextEdit;
    cxdbteRemark: TcxDBTextEdit;
    lbl10: TLabel;
    cxdbcbOK: TcxDBCheckBox;
    btnCancel: TBitBtn;
    cdsOthers: TClientDataSet;
    dsOthers: TDataSource;
    pnl2: TPanel;
    cxgridOthers: TcxGrid;
    cxgridtvOthers: TcxGridDBTableView;
    cxGridlOthers: TcxGridLevel;
    cxcbAll: TcxCheckBox;
    cxteFinal_Remark: TcxTextEdit;
    cxdbmemFinal_Remark: TcxDBMemo;
    lbl9: TLabel;
    tbcAccident: TTabControl;
    gbLeft: TGroupBox;
    cxgridAccident: TcxGrid;
    cxgridtvAccident: TcxGridDBTableView;
    cxGridlAccident: TcxGridLevel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cxgridtvAccidentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgridtvAccidentMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure cxdbteRemarkExit(Sender: TObject);
    procedure cxdbcbOKPropertiesChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cxteFinal_RemarkPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cxteFinal_RemarkEnter(Sender: TObject);
    procedure tbcAccidentChange(Sender: TObject);
  private
    { Private declarations }
    bModified:Boolean;
    sRemark, sFinalRemark:String;
    procedure SetBtnState;
    procedure DataQuery(Sender:TObject);
    procedure DataRefresh;
    procedure DataSave;
    procedure DataCancel;
    procedure DataModify;
    function CloseQuery:Boolean;
    procedure FilterAccident;
  public
    { Public declarations }
  end;

var
  DisposeAccidentTraceForm: TDisposeAccidentTraceForm;

implementation

uses ServerDllPub, uFNMArtInfo, uLogin, uShowMessage, uDictionary, uGlobal, uGridDecorator;

{$R *.dfm}

{ TDisposeAccidentTraceForm }

procedure TDisposeAccidentTraceForm.DataQuery(Sender:TObject);
var
  vData: OleVariant;
  sFNCard, sSQL, sErrMsg: WideString;
begin
  try
    ShowMsg('', crHourGlass);
    //cdsAccident.AfterScroll := nil;

{
    if not CloseQuery then
    begin
      cdsAccident.CancelUpdates;
      cdsAccident.MergeChangeLog;
    end;
}
    cxteFinal_Remark.Text := '';
    with TcxGridDBTableView(TcxGridSite(Sender).ViewInfo.GridView) do
    begin
      if ColumnCount<1 then Exit;
      if Controller.SelectedRowCount =0 then Exit;

      sSQL := Controller.SelectedRows[0].Values[GetColumnByFieldName('Accident_NO').Index];

      if (Name= 'cxgridtvAccident') then
      begin
        sFNCard := Controller.SelectedRows[0].Values[GetColumnByFieldName('FN_Card').Index];

        cxteFinal_Remark.Text := Controller.SelectedRows[0].Values[GetColumnByFieldName('Tmp_Remark').Index];

        cdsOthers.Filter := 'FN_Card= '+ QuotedStr(sFNCard);
        cdsOthers.Filtered := False;
        cdsOthers.Filtered := True;
      end
    end;

    sSQL := QuotedStr('fnGetAccidentDtlInfo')+','+ QuotedStr(sSQL);
    FNMServerObj.GetQueryData(vData, 'CommonSQL', sSQL, sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;

    cdsTmp.Data := vData;
    FillItemsFromDataSet(cdsTmp, 'Item_Name', 'Item_Value', '', '=', vle_RepairReasonList.Strings);

  finally
    SetBtnState;
    //cdsAccident.AfterScroll := cdsAccidentAfterScroll;
    ShowMsg('', crDefault);
  end;
end;

procedure TDisposeAccidentTraceForm.DataRefresh;
var
  vData: OleVariant;
  sType, sSQL, sErrMsg: WideString;
begin
  try
    ShowMsg('', crHourGlass);
    cdsAccident.DisableControls;
    //cdsAccident.AfterScroll := nil;
    cxdbcbOK.Properties.OnChange := nil;

    if CloseQuery then Exit;

    if cxcbAll.Checked then
      sType := '1'
    else
      sType := '0';
    sSQL := QuotedStr('fnGetAccidentInfo')+','+ QuotedStr(login.CurrentDepartment)+','+ QuotedStr(sType);
    FNMServerObj.GetQueryData(vData, 'CommonSQL', sSQL, sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    if sType= '0' then
    begin
      cdsAccident.Data := vData[0];
      cdsOthers.Data := vData[1];
    end else
      cdsAccident.Data := vData;
    //默认显示级别grade =1 的
    cdsAccident.Filtered := False;
    cdsAccident.Filter := 'Grade= 1';
    cdsAccident.Filtered := True;

    if cdsAccident.IsEmpty then Exit;
    if cxgridtvAccident.ColumnCount<2 then
    begin
      GridDecorator.BindCxViewWithDataSource(cxgridtvAccident, dsAccident);
      GridDecorator.SetcxTableView(cxgridtvAccident, ['Machine_ID', 'Current_Department', 'GF_ID', 'Dispose_ID', 'Tmp_Remark'], ['Final_Remark','Final_Result', 'Tmp_Remark', 'Remark']);
      //cxgridtvAccident.GetColumnByFieldName('').Caption := '';
    end;

    cxgridOthers.Visible := sType= '0';
    if (cxgridtvOthers.ColumnCount<2) and cdsOthers.Active then
    begin
      GridDecorator.BindCxViewWithDataSource(cxgridtvOthers, dsOthers);
      GridDecorator.SetcxTableView(cxgridtvOthers, ['FN_Card', 'Accident_NO', 'Dispose_ID'], []);
    end;
  finally
    cdsAccident.EnableControls;  
    //cdsAccident.AfterScroll := cdsAccidentAfterScroll;
    cxdbcbOK.Properties.OnChange := cxdbcbOKPropertiesChange;
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TDisposeAccidentTraceForm.DataSave;
var
  vData: OleVariant;
  sErrMsg:WideString;
  i: Integer;
begin
  try
    ShowMsg('', crHourGlass);
    if TGlobal.DeltaIsNull(cdsAccident) then Exit;

    cxdbcbOK.Properties.OnChange := nil;
    
    cdsAccident.DisableControls;
    //将最终意见串起来
    with cdsAccident do
    begin
      FieldByName('Final_Operator').ReadOnly := False;
      FieldByName('Final_Operate_Time').ReadOnly := False;
      First;
      while not Eof do
      begin
        if(FieldByName('Tmp_Remark').AsString<>'') then
        begin
          Edit;
          FieldByName('Final_Remark').AsString := FieldByName('Final_Remark').AsString
                + FieldByName('Tmp_Remark').AsString + char(10);
          FieldByName('Tmp_Remark').AsString := '';
          Post;
        end;

        if (FieldByName('Final_Result').AsBoolean) and (FieldByName('Final_Operator').AsString= '') then
        begin
          Edit;
          FieldByName('Final_Operator').Value := login.LoginName;
          FieldByName('Final_Operate_Time').Value := TGlobal.GetServerTime;
          Post;
        end;
        
        Next;
      end;
      FieldByName('Final_Operator').ReadOnly := True;
      FieldByName('Final_Operate_Time').ReadOnly := True;
    end;

    //保存数据
    vData := cdsAccident.Delta;
    FNMServerObj.SaveBaseTableInfo(vData, 'fnAccidentHdr', 'Accident_NO', sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsAccident.MergeChangeLog;

    //过滤
    cdsAccident.Filter := 'Final_Result =1 ';
    cdsAccident.Filtered := False;
    cdsAccident.Filtered := True;
    for i:= 0 to cdsAccident.RecordCount-1 do
      cdsAccident.Delete;
    cdsAccident.MergeChangeLog;
    cxteFinal_Remark.Text := '';
  finally
    cdsAccident.Filtered := False;
    cdsAccident.EnableControls;
    cxdbcbOK.Properties.OnChange := cxdbcbOKPropertiesChange;
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TDisposeAccidentTraceForm.SetBtnState;
begin                                                 
  cxdbcbOK.Enabled := cxgridtvAccident.Controller.SelectedRowCount>0;
  cxdbteRemark.Enabled := cxdbcbOK.Enabled;
  cxteFinal_Remark.Enabled := cxdbcbOK.Enabled;
  btn_Save.Enabled := not TGlobal.DeltaIsNull(cdsAccident);
  btnCancel.Enabled := btn_Save.Enabled;
end;

procedure TDisposeAccidentTraceForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TDisposeAccidentTraceForm.FormDestroy(Sender: TObject);
begin
  inherited;
  DisposeAccidentTraceForm := nil;
end;

procedure TDisposeAccidentTraceForm.btn_RefreshClick(Sender: TObject);
begin
  inherited;
  DataRefresh;
end;

procedure TDisposeAccidentTraceForm.btn_SaveClick(Sender: TObject);
begin
  inherited;
  DataSave;
end;

procedure TDisposeAccidentTraceForm.btn_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TDisposeAccidentTraceForm.CloseQuery: Boolean;
begin
  if not TGlobal.DeltaIsNull(cdsAccident) then
    if TMsgDialog.ShowMsgDialog('数据未保存，是否保存！', mtConfirmation, [mebYes, mebNo], mebYes)= mrNo then
      Result := false
     else
       Result := true
  else
    Result := False;
end;

procedure TDisposeAccidentTraceForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := not CloseQuery;
end;

procedure TDisposeAccidentTraceForm.FormShow(Sender: TObject);
begin
  inherited;
  DataRefresh;
end;

procedure TDisposeAccidentTraceForm.cxgridtvAccidentKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key= VK_Up) or (Key= VK_Down) then
    DataQuery(Sender);
end;

procedure TDisposeAccidentTraceForm.cxgridtvAccidentMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  DataQuery(Sender);
end;

procedure TDisposeAccidentTraceForm.cxdbteRemarkExit(Sender: TObject);
begin
  inherited;
  SetBtnState;
end;

procedure TDisposeAccidentTraceForm.cxdbcbOKPropertiesChange(
  Sender: TObject);
begin
  inherited;
  SetBtnState;
end;

procedure TDisposeAccidentTraceForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  DataCancel;
end;

procedure TDisposeAccidentTraceForm.DataCancel;
begin
  cdsAccident.CancelUpdates;
  cxteFinal_Remark.Text := '';
end;

procedure TDisposeAccidentTraceForm.cxteFinal_RemarkPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  if (sRemark <> DisplayValue) then
    bModified := True
  else
    bModified := False;

  DataModify;
  SetBtnState;
end;

procedure TDisposeAccidentTraceForm.cxteFinal_RemarkEnter(Sender: TObject);
begin
  inherited;
  sRemark := cxteFinal_Remark.Text;
  sFinalRemark := cxdbmemFinal_Remark.Text;
end;

procedure TDisposeAccidentTraceForm.DataModify;
begin
  //如果修改了增加修改人、修改时间
  if bModified then
  begin
    with cdsAccident do
    begin
      FieldByName('Final_Operator').ReadOnly := False;
      FieldByName('Final_Operate_Time').ReadOnly := False;

      Edit;
      //不同意见将用户意见串起来
      if (FieldByName('Final_Remark').AsString <> '') then
      begin
        FieldByName('Final_Remark').AsString := FieldByName('Final_Operator').AsString+ ':'+ FieldByName('Final_Remark').AsString+ char(10);
        FieldByName('Tmp_Remark').AsString := login.LoginName+ ':'+ cxteFinal_Remark.Text;
      end
      else
        FieldByName('Tmp_Remark').AsString := cxteFinal_Remark.Text;
        
      FieldByName('Final_Operator').Value := login.LoginName;
      FieldByName('Final_Operate_Time').Value := TGlobal.GetServerTime;

      Post;
      
      FieldByName('Final_Operator').ReadOnly := True;
      FieldByName('Final_Operate_Time').ReadOnly := True;
    end;
  end;
end;

procedure TDisposeAccidentTraceForm.FilterAccident;
var
  iGrade:Integer;
begin
  if not cdsAccident.Active then Exit;

  iGrade := tbcAccident.TabIndex+1;

//  cdsAccident.Filtered := False;
//  cdsAccident.Filter := 'Grade= '+ IntToStr(iGrade);
//  cdsAccident.Filtered := True;
end;

procedure TDisposeAccidentTraceForm.tbcAccidentChange(Sender: TObject);
begin
  inherited;
  FilterAccident;
end;

end.



