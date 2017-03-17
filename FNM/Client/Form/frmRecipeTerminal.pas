unit frmRecipeTerminal;
{*|<PRE>*****************************************************************************
                                                                             
       软件名称 FNM CLIENT MODEL                                               
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                              
       单元名称 frmRecipeTerminal.pas
       创建日期 2004-8-30 下午 07:16:48
       创建人员 lvzd
       修改人员
       修改日期                                                                
       修改原因                                                                
       对应用例                                                                
       字段描述                                                                
       相关数据库表                                                            
       调用重要函数/SQL对象说明                                                
       功能描述 化料房终端                                                               
                                                                              
******************************************************************************}

interface

{$I Terminal.inc}

uses
  Windows, Messages, SysUtils, Variants, cxGraphics, 
  Classes, Graphics, Controls, Forms, DB, DBClient, StdCtrls, ComCtrls,
  ExtCtrls, Buttons, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxSplitter, cxContainer, cxTextEdit, cxMaskEdit, cxSpinEdit;

type
  TRecipeTerminalForm = class(TForm)
    btn_Exit: TSpeedButton;
    txt2: TStaticText;
    edt_ScrapVol: TEdit;
    cds_UnFinishBatch: TClientDataSet;
    ds_UnFinishBatch: TDataSource;
    cxGrid2: TcxGrid;
    cxgtv_RecipeNOBatch: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    btn_Cancel: TSpeedButton;
    btn_scrap: TSpeedButton;
    btn_End: TSpeedButton;
    btn_Refresh: TSpeedButton;
    Splitter1: TSplitter;
    lv_Chemicallist: TListView;
    pen_Only: TPanel;
    txt1: TStaticText;
    cbb_VatStudio: TComboBox;
    btn_Begin: TSpeedButton;
    cbb_Reciper: TComboBox;
    StaticText1: TStaticText;
    btn_endrecipe: TSpeedButton;
    btn_ChangeVat: TSpeedButton;
    btn_ExportTOCS: TSpeedButton;
    cxsplBottom: TcxSplitter;
    pnl1: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    chkAutoRefresh: TCheckBox;
    tmr1: TTimer;
    cxseInterval: TcxSpinEdit;
    cdsVatInfo: TClientDataSet;
    grp1: TGroupBox;
    cxgridRecipeInfo: TcxGrid;
    cxgridtvRecipeInfo: TcxGridDBTableView;
    cxGridl1: TcxGridLevel;
    sclbVat: TScrollBox;
    btnVat: TBitBtn;
    pnl2: TPanel;
    btnUp: TSpeedButton;
    btnDown: TSpeedButton;
    cdsChemical: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure KeyDownAControl(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ClickABotton(Sender: TObject);
    procedure EnterAListView(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure cds_UnFinishBatchAfterScroll(DataSet: TDataSet);
    procedure cxgtv_RecipeNOBatchCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btn_ChangeVatClick(Sender: TObject);
    procedure btn_ExportTOCSClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure chkAutoRefreshClick(Sender: TObject);
    procedure cxseIntervalPropertiesChange(Sender: TObject);
    procedure btnVatClick(Sender: TObject);
    procedure cxsplBottomAfterOpen(Sender: TObject);
    procedure cxsplBottomAfterClose(Sender: TObject);
    procedure TextClick(Sender: TObject);
  private
    { private declarations }
    procedure Exchange(index1,index2: Integer);
    procedure GetBatchTaskInfo;
    procedure DrawVatState;
    procedure SetOrder(sType:String);
    procedure ExportRecipeToCS;
    procedure SaveBatchTraceInfo(Sender: TObject);
  protected
    procedure UpdateActions; override;    
  public
  end;

var
  RecipeTerminalForm: TRecipeTerminalForm;

implementation

uses
  uGlobal, uDictionary, uLogin, Dialogs, Math, ServerDllPub, uFNMResource, uShowMessage,
  UGridDecorator, StrUtils, frmInput,
  {$IFDEF TERMINAL}
  uTerminal,
  {$ENDIF}
  uFNMArtInfo;
{$R *.dfm}

procedure TRecipeTerminalForm.FormCreate(Sender: TObject);
var
  EditStyle: Longint;
begin
{$IFDEF TERMINAL}
  FormStyle := fsNormal;
  CreateComControl(Self);
  cbb_VatStudio.Enabled:=false;
  cbb_VatStudio.Color:=clBtnFace;
  cbb_VatStudio.Style:=csSimple;
{$ELSE}
  FormStyle := fsMDIChild;
{$ENDIF}

  EditStyle:=GetWindowLong(edt_ScrapVol.Handle, GWL_STYLE);
  SetWindowLong(edt_ScrapVol.Handle, GWL_STYLE, EditStyle or ES_NUMBER);
  cxgtv_RecipeNOBatch.OnDblClick:=TGlobal.DblClickAWinControl;
end;

procedure TRecipeTerminalForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dictionary.cds_VatList.Close;
  Action:=caFree;
end;

procedure TRecipeTerminalForm.FormDestroy(Sender: TObject);
begin
  RecipeTerminalForm:=nil;
end;

procedure TRecipeTerminalForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  OnActivate:=nil;
  //刷新界面数据
{$IFDEF TERMINAL}
  cbb_VatStudio.Text:=RecipeVatStudio;
  Caption:=RecipeVatStudio + ' ' + '化料房终端';
  Application.Title:=Caption;
  btn_Refresh.Click;
{$ELSE}
  //刷新界面数据
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
{$ENDIF}
  edt_ScrapVol.Text := '0';
  cxsplBottom.CloseSplitter;
  //填充化料缸
  with Dictionary.cds_VatList do
  try
    Dictionary.cds_VatList.Filter:=Format('Vat_Studio LIKE ''%s''', [Login.CurrentDepartment + '%']);
    Filtered:=True;
    FillItemsFromDataSet(Dictionary.cds_VatList, 'Vat_Studio', '', '', '', cbb_VatStudio.Items);
  finally
    Filtered:=False;
  end;
end;

procedure TRecipeTerminalForm.KeyDownAControl(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Sender = Self then
    case Key of
      VK_F5:  btn_Refresh.Click;
    end;
end;

procedure TRecipeTerminalForm.btn_RefreshClick(Sender: TObject);
begin
  GetbatchTaskInfo;
end;

procedure TRecipeTerminalForm.GetBatchTaskInfo;
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  if cbb_VatStudio.Text = '' then Exit;

  sCondition := QuotedStr(cbb_VatStudio.Text)+',2';
  FNMServerObj.GetQueryData(vData, 'RCPGetRecipeTaskInfo', sCondition, sErrorMsg);
 // FNMServerArtObj.GetNoFinishRecipeBatch(cbb_VatStudio.Text, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetNoFinishRecipe, [sErrorMsg]);

  try
    cds_UnFinishBatch.DisableControls;
    cds_UnFinishBatch.Data := vData;
    if cds_UnFinishBatch.IsEmpty then
      raise Exception.CreateRes(@EMP_NoFinishRecipeBatch);

    GridDecorator.BindCxViewWithDataSource(cxgtv_RecipeNOBatch, ds_UnFinishBatch);
  finally
    cds_UnFinishBatch.EnableControls;
    cds_UnFinishBatch.AfterScroll(cds_UnFinishBatch);
  end;

  //填充化料房人员
  with Dictionary.cds_WorkerStationList do
  try
    Filter := Format('Machine_ID = ''%s''', [cbb_VatStudio.Text]);
    Filtered := True;
    TGlobal.FillItemsFromDataSet(Dictionary.cds_WorkerStationList, 'Worker_ID', '', '', cbb_Reciper.Items);
  finally 
    Filtered:=False;
  end;
  if Login.LoginName <> '' then
  begin
    cbb_Reciper.Items.Add(Login.LoginName);
    cbb_Reciper.ItemIndex := -1
  end;
end;

procedure TRecipeTerminalForm.ClickABotton(Sender: TObject);
begin
  SaveBatchTraceInfo(Sender);
end;

procedure TRecipeTerminalForm.SaveBatchTraceInfo;
var
//  ScrapVolume: integer;
  sCondition,sErrorMsg: WideString;
  Operator, OperateType, BatchNO: string;
begin
  if (not cds_UnFinishBatch.Active) or (cds_UnFinishBatch.IsEmpty) then Exit;

  OperateType:='';
//  ScrapVolume:=0;
  Operator:=cbb_Reciper.Text;
  if Pos('(', Operator) <> 0 then
    Operator := LeftStr(Operator, Pos('(', Operator) - 1);

  if Operator = '' then
    raise Exception.Create('WAR_请输入化料人员');

  BatchNO:=cds_UnFinishBatch['Batch_NO'];

  if Sender = btn_scrap then Exit; //屏蔽放料功能

  //开始化料
  if (Sender = btn_Begin) and (cds_UnFinishBatch['Status'] = 0) then
    OperateType:='beginrecipe';

  //取消化料
  if (Sender = btn_Cancel) and (cds_UnFinishBatch['Status'] = 1) then
    OperateType:='cancelrecipe';

  //结束化料
  if (Sender = btn_endrecipe) and (cds_UnFinishBatch['Status'] = 1) then
    OperateType:='endrecipe';

  //完成使用
  if (Sender = btn_End) and (cds_UnFinishBatch['Status'] = 2) then
  begin
    OperateType:='finishend';
//    ScrapVolume:=StrToInt(edt_ScrapVol.Text);
  end;

  if OperateType = '' then Exit;
    
  //保存数据
  sCondition := QuotedStr(OperateType)+ ','+ QuotedStr(BatchNO)+','+ QuotedStr(edt_ScrapVol.Text)+','+  QuotedStr(Operator);
  FNMServerObj.SaveDataBySQL('RCPSaveBatchTraceInfo',sCondition,sErrorMsg);
//  FNMServerArtObj.SaveBatchTraceInfo(OperateType, BatchNO, ScrapVolume, Operator, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveRecipeTraceInfo, [sErrorMsg]);

  //开始化料
  if (Sender = btn_Begin) and (cds_UnFinishBatch['Status'] = 0) then
  begin
    cds_UnFinishBatch.Edit;
    cds_UnFinishBatch['Status'] := 1;
    cds_UnFinishBatch['Reciper'] := Operator;
    cds_UnFinishBatch['Recipe_Time'] := Now;
  end;

  //取消化料
  if (Sender = btn_Cancel) and (cds_UnFinishBatch['Status'] = 1) then
  begin
    cds_UnFinishBatch.Edit;
    cds_UnFinishBatch['Status'] := 0;
    cds_UnFinishBatch['Reciper'] := '';
    cds_UnFinishBatch.FieldByName('Recipe_Time').Clear;
  end;

  //结束化料
  if (Sender = btn_endrecipe) and (cds_UnFinishBatch['Status'] = 1) then
  begin
    cds_UnFinishBatch.Edit;
    cds_UnFinishBatch['Status'] := 2;
    cds_UnFinishBatch['Begin_Operator'] := Operator;
    cds_UnFinishBatch['Begin_Time'] := Now;
  end;

  //完成使用
  if (Sender = btn_End) and (cds_UnFinishBatch['Status'] = 2) then
    cds_UnFinishBatch.Delete;

  cds_UnFinishBatch.AfterScroll(cds_UnFinishBatch);
end;

procedure TRecipeTerminalForm.EnterAListView(Sender: TObject);
begin
  with Sender As TListView do
  begin
    if (Items.Count <> 0) and (Selected = nil) then
      Selected:=Items.Item[0];
  end;
end;

procedure TRecipeTerminalForm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TRecipeTerminalForm.UpdateActions;
begin
  inherited;
  btnDown.Enabled :=  (lv_Chemicallist.Selected <> nil) and ( lv_Chemicallist.Selected.Index<>lv_Chemicallist.Items.Count-1);
  btnUp.Enabled :=  (lv_Chemicallist.Selected <> nil) and ( lv_Chemicallist.Selected.Index<>0);
end;

procedure TRecipeTerminalForm.cds_UnFinishBatchAfterScroll(
  DataSet: TDataSet);
var
  BatchNO: String;
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  if DataSet.ControlsDisabled or DataSet.IsEmpty then Exit;

  //取化工料明细
  BatchNO:=DataSet['Batch_NO'];
  sCondition := QuotedStr(BatchNO)+',3';
  FNMServerObj.GetQueryData(vData, 'RCPGetRecipeTaskInfo', sCondition, sErrorMsg);
//  FNMServerArtObj.GetBatchDtlInfo(BatchNO, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetBatchDtlInfo, [sErrorMsg]);

  TempClientDataSet.Data:=vData;
  FillListItemsFromDataSet(TempClientDataSet, 'Step_ID', '', ['Chemical_Name', 'Unit_QTY', 'Dosage', 'Chemical_ID'], lv_Chemicallist.Items);
  TempClientDataSet.Close;

  btn_Begin.Enabled:=DataSet['Status'] = 0;
  btn_endrecipe.Enabled:=DataSet['Status'] = 1;
  btn_Cancel.Enabled:=DataSet['Is_ExportTOCS'] = 1;
  btn_End.Enabled:=DataSet['Status'] = 2;
  btn_ChangeVat.Enabled:=DataSet['Status'] = 0;
  //(DataSet['Status'] = 0) and
  btn_ExportTOCS.Enabled:=DataSet['Vat_NO']<>'';//(Pos('FA', DataSet['Vat_Code']) = 1) and (Pos('ST', DataSet['Machine_ID']) = 1);
//  btnUp.Enabled := lv_Chemicallist.Items.Count>0;
//  btnDown.Enabled := btnUp.Enabled;
end;

procedure TRecipeTerminalForm.cxgtv_RecipeNOBatchCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  col: Integer;
begin
  if AViewInfo.Focused then Exit;

  cds_UnFinishBatch.AfterScroll := nil;
  try
    col := TcxGridDBTableView(Sender).GetColumnByFieldName('Status').Index;
    if AViewInfo.GridRecord.Values[col] = 1 then
    begin
      ACanvas.Brush.Color:=clWhite;
      ACanvas.Font.Color:=clRed; //已经开始化料
    end
    else if AViewInfo.GridRecord.Values[col] = 2 then
    begin
      ACanvas.Brush.Color:=clWhite;
      ACanvas.Font.Color:=clBlue;  //已经完成化料
    end;

    //是否已经导CS
    col := TcxGridDBTableView(Sender).GetColumnByFieldName('Is_ExportTOCS').Index;
    if AViewInfo.GridRecord.Values[col] = 1 then //已导
    begin
      ACanvas.Brush.Color:=clSilver;
    end;
  finally
    cds_UnFinishBatch.AfterScroll := cds_UnFinishBatchAfterScroll;
  end;
end;

procedure TRecipeTerminalForm.btn_ChangeVatClick(Sender: TObject);
var
  Volume: Single;
  BatchNO, MachineID, VatStudio, CurVatCode, CurVatNO, NewVatCode: string;
begin
  with cds_UnFinishBatch do
  begin
    BatchNO:=FieldByName('Batch_NO').AsString;
    if FieldByName('Status').AsInteger <> 0 then
      raise Exception.CreateFmt('当前缸号:%s已经开始化料,请取消化料后再修改缸号.', [BatchNO]);
  //  CurVatNO:=cds_NoFinishRecipeBatch.FieldByName('Vat_NO').AsString;
    VatStudio:=cbb_VatStudio.Text;
    MachineID:=Trim(FieldByName('Machine_ID').AsString);
    CurVatCode:=Trim(FieldByName('Vat_Code').AsString);
    Volume:=FieldByName('Volume').AsFloat;

    NewVatCode:=GetNewVatNo(BatchNO, MachineID, VatStudio, CurVatCode, Volume);
    if NewVatCode = '' then Exit;

    CurVatCode:=LeftStr(NewVatCode, 8);
    CurVatNO:=MidStr(NewVatCode, 10, MAXINT);

    Edit;
    FieldByName('Vat_NO').AsString:=CurVatNO;
    FieldByName('Vat_Code').AsString:=CurVatCode;
    CheckBrowseMode;
    MergeChangeLog;
  end;
end;

procedure TRecipeTerminalForm.btn_ExportTOCSClick(Sender: TObject);
begin
  ExportRecipeToCS;
end;

procedure TRecipeTerminalForm.Exchange(index1,index2: Integer);
var SubStr: string;
begin
  SubStr := lv_Chemicallist.Items[index1].SubItems.Text;
  lv_Chemicallist.Items[index1].SubItems.Text := lv_Chemicallist.Items[index2].SubItems.Text;
  lv_Chemicallist.Items[index2].SubItems.Text:= SubStr;
  lv_Chemicallist.Items[index2].Selected := True;
end;

procedure TRecipeTerminalForm.SetOrder(sType: String);
var
  ts, tc: String;
  i, c, j: Integer;
begin
  //没有选择跳过
  c := lv_Chemicallist.Items.Count;

  if lv_Chemicallist.SelCount =0 then Exit;
  i := lv_Chemicallist.Selected.Index;
  //如果是向上移动，移到0不移，向下移动，移到尾不移
  if sType= 'P' then  //向上移
  begin
    if i=0 then Exit;
    j := i-1;
  end
  else    //向下移 'N'
  begin
    if i=c then Exit;
    j := i+1;
  end;

  ts := lv_Chemicallist.Items[i].SubItems.Text;
  tc := lv_Chemicallist.Items[i].Caption;
  lv_Chemicallist.Items.Delete(i);

  with lv_Chemicallist.Items.Insert(j) do
  begin
    SubItems.Text := ts;
    Caption := tc;
    Selected := True;
  end;
end;

procedure TRecipeTerminalForm.btnUpClick(Sender: TObject);
begin
  Exchange(lv_Chemicallist.Selected.Index,lv_Chemicallist.Selected.Index-1)
//  SetOrder('P');
end;

procedure TRecipeTerminalForm.btnDownClick(Sender: TObject);
begin
  Exchange(lv_Chemicallist.Selected.Index,lv_Chemicallist.Selected.Index+1)
//  SetOrder('N');
end;

//导数到cs-dlvs [GET02C0416\GEW]
procedure TRecipeTerminalForm.ExportRecipeToCS;
var
  i: Integer;
  Operator, ChemicalIDStr,StepIDStr, BatchNO, sCondition,sErrorMsg: WideString;
begin
  if cds_UnFinishBatch.ControlsDisabled or cds_UnFinishBatch.IsEmpty then Exit;
  if lv_Chemicallist.Items.Count=0 then Exit;

  Operator := cbb_Reciper.Text;
  if Pos('(', Operator) <> 0 then
    Operator := LeftStr(Operator, Pos('(', Operator) - 1);
  if Operator = '' then
    raise Exception.Create('WAR_请输入化料人员');

  //取化工料明细
  BatchNO:=cds_UnFinishBatch.FieldByName('Batch_NO').AsString;
  if TMsgDialog.ShowMsgDialog('是否导入【'+ BatchNO+ '】这个缸？', mtConfirmation, [mebYes, mebNo], mebYes) = mrNO then Exit;
  ChemicalIDStr := '';
  StepIDStr := '';
  for i:=0 to lv_Chemicallist.Items.Count-1 do
  begin
    StepIDStr := StepIDStr + lv_Chemicallist.Items[i].Caption+',';
    ChemicalIDStr := ChemicalIDStr+lv_Chemicallist.Items[i].SubItems.Strings[3]+',';
  end;

  sCondition := QuotedStr(BatchNO)+ ','+ QuotedStr(ChemicalIDStr)+ ','+ QuotedStr(StepIDStr) + ','+ QuotedStr(Operator);
  FNMServerObj.SaveDataBySQL('RCPExportRecipeToCS',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_ExportBatchToCS, [sErrorMsg]);
  TMsgDialog.ShowMsgDialog('数据导入成功!', 10);
end;
{
procedure TRecipeTerminalForm.ExportRecipeToCS;
var
  i: Integer;
  vData: OleVariant;
  sOperator, sID, sBatchNO, sErrorMsg: WideString;
begin
  if cds_UnFinishBatch.ControlsDisabled or cds_UnFinishBatch.IsEmpty then Exit;
  if lv_Chemicallist.Items.Count=0 then Exit;

  sOperator:=cbb_Reciper.Text;
  if Pos('(', sOperator) <> 0 then
    sOperator := LeftStr(sOperator, Pos('(', sOperator) - 1);
  if sOperator = '' then
    raise Exception.Create('WAR_请输入化料人员');

  //取化工料明细
  sBatchNO:=cds_UnFinishBatch.FieldByName('Batch_NO').AsString;
  if TMsgDialog.ShowMsgDialog('是否导入'+ sBatchNO+ '这个缸？', mtConfirmation, [mebYes, mebNo], mebYes) = mrNO then
    Exit;

  FNMServerObj.GetRecipeChemical(sBatchNO, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetBatchDtlInfo, [sErrorMsg]);
   TempClientDataSet.Data:=vData;
   //根据ListView的顺序设置化工料顺序Step_ID
  for i:=0 to lv_Chemicallist.Items.Count-1 do
  begin
    sID := lv_Chemicallist.Items[i].SubItems.Strings[3];
    with TempClientDataSet do
    begin
      if Locate('Chemical_ID', sID, []) then
      begin
        Edit;
        FieldByName('Step_ID').AsInteger := i+1;
        Post;
      end;
    end;
  end;
  if TGlobal.DeltaIsNull(TempClientDataSet) then Exit;
  vData := TempClientDataSet.Delta;

  sErrorMsg := QuotedStr(sBatchNO)+ ','+ QuotedStr(sOperator);
  FNMServerObj.SaveData('RecipeChemical', vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_ExportBatchToCS, [sErrorMsg]);

  FNMServerArtObj.GetBatchDtlInfo(sBatchNO, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetBatchDtlInfo, [sErrorMsg]);
  TempClientDataSet.Data:=vData;
  FillListItemsFromDataSet(TempClientDataSet, 'Step_ID', '', ['Chemical_Name', 'Unit_QTY', 'Dosage', 'Chemical_ID'], lv_Chemicallist.Items);
  TempClientDataSet.Close;
  TMsgDialog.ShowMsgDialog('数据导入成功!', 10);
end;
}
procedure TRecipeTerminalForm.tmr1Timer(Sender: TObject);
begin
  DrawVatState;
end;

procedure TRecipeTerminalForm.chkAutoRefreshClick(Sender: TObject);
begin
  tmr1.Enabled := chkAutoRefresh.Checked;
end;

procedure TRecipeTerminalForm.cxseIntervalPropertiesChange(Sender: TObject);
begin
  tmr1.Interval := cxseInterval.Value*6000;
end;

procedure TRecipeTerminalForm.btnVatClick(Sender: TObject);
begin
  DrawVatState;
end;

//画缸状态
procedure TRecipeTerminalForm.DrawVatState;
var
  pnl: TPanel;
  lbl: TLabel;
 // FontColor: TColor;
  C, R: Double;
  gWidth, gHeight, iRecordCount, i, j, W, H: Integer;
//  Status_CN: string;
  vData: Olevariant;
  sSQL, sErrorMsg: WideString;
begin
  sclbVat.Visible := False;

  sSQL := QuotedStr(Login.CurrentDepartment);
  FNMServerObj.GetQueryData(vData, 'RCPGetCSVatStatus', sSQL, sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  cdsVatInfo.Data := vData;
  if cdsVatInfo.IsEmpty then Exit;

  //设置Panel大小
  gWidth := 220;
  gHeight := 100;
  W := 10; //Panel的Left
  H := 10; //Panel的Top
  iRecordCount := cdsVatInfo.RecordCount;

  //第一次画
  if sclbVat.ControlCount<>iRecordCount then
  begin
    if sclbVat.ControlCount>0 then
    begin
      for i:= sclbVat.ControlCount-1 downto 0 do
        sclbVat.Controls[i].Destroy;
    end;
    // 一行显示的个数,列数
    C := Int((sclbVat.Width - 20) / gWidth);
    if C = 0 then C := 1;

    //计算行数
    if Frac(iRecordCount / C) > 0 then
      R := Int(iRecordCount / C) + 1
    else
      R := Int(iRecordCount / C);

    with cdsVatInfo do
    begin
      First;
      for i := 0 to Floor(R) - 1 do
      begin
        for j := 0 to Floor(C) - 1 do
        begin
          if Eof then break;
          //创建Panel
          pnl := TPanel.Create(self);
          pnl.Parent := sclbVat;
          pnl.Left := W;
          pnl.Top := H;
          pnl.Width := gWidth;
          pnl.Height := gHeight;
          pnl.BorderStyle := bsSingle;
          pnl.BevelInner := bvRaised;

          //向架位上放入Label显示架位信息
          lbl := TLabel.Create(self);
          lbl.Parent := pnl;
          lbl.Align := alClient;
          lbl.Alignment := taLeftJustify;
          lbl.Font.Size := 15;
          lbl.Font.Style := [fsBold];
//          lbl.Font.Color := FontColor;
          lbl.Caption := '';
          W := W + gWidth;
          if Eof then break else Next;
        end;
        H := H + gHeight;
        W := W - Floor(C) * gWidth;
      end
    end;
  end;

  //赋值
  cdsVatInfo.First;
  for i := sclbVat.ControlCount - 1 downto 0 do
  begin

    if TPanel(sclbVat.Controls[i]).Controls[0].ClassName= 'TLabel' then
    begin
      with TLabel(TPanel(sclbVat.Controls[i]).Controls[0]) do
      begin
        Caption := cdsVatInfo.FieldByName('Caption').AsString;
        Font.Color := StringToColor(cdsVatInfo.FieldByName('Font_Color').AsString);
        Color := StringToColor(cdsVatInfo.FieldByName('Color').AsString);
        Hint := cdsVatInfo.FieldByName('Remark').AsString;
        OnClick := TextClick;
      end;                                                

      if not cdsVatInfo.Eof then
        cdsVatInfo.Next;
    end;
  end;

  sclbVat.Visible := True;
end;

procedure TRecipeTerminalForm.cxsplBottomAfterOpen(Sender: TObject);
begin
  tmr1.Enabled := True;
end;

procedure TRecipeTerminalForm.cxsplBottomAfterClose(Sender: TObject);
begin
  tmr1.Enabled := False;
end;

procedure TRecipeTerminalForm.TextClick(Sender: TObject);
begin
 // if TLabel(Sender).Hint<>'' then
    TMsgDialog.ShowMsgDialog(TLabel(Sender).Caption+ TLabel(Sender).Hint, 10);
end;

end.
