unit frmCPBCheck;
{*|<PRE>*****************************************************************************

       软件名称 FNM CLIENT MODEL
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT
       单元名称 frmDiluteRecipe.pas
       创建日期
       创建人员
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
  Dialogs, frmBase, ComCtrls, Buttons, Grids, ValEdit, StdCtrls, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, DBClient, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, CheckLst, cxSplitter;
type
  TCPBCheckForm = class(TBaseForm)
    pnl_Only1: TPanel;
    grp2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    vlePDParam: TValueListEditor;
    cxGrid2: TcxGrid;
    cxgdTVTask: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cdsTask: TClientDataSet;
    dsTask: TDataSource;
    cxSplitter1: TcxSplitter;
    cxSplitter2: TcxSplitter;
    pnlLeft: TPanel;
    btnRefresh: TSpeedButton;
    cxGrid1: TcxGrid;
    cxGridTVCPBDtl: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    dsCPBRecipeDtl: TDataSource;
    cdsCPBRecipeDtl: TClientDataSet;
    lvChemicalGroup: TListView;
    pnlCaption: TPanel;
    btnSave: TBitBtn;
    btnExit: TBitBtn;
    Label10: TLabel;
    cbbOperator: TComboBox;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    gbDeleteShade: TGroupBox;
    btnDelete: TSpeedButton;
    lblDeleteNO: TLabel;
    edtDeleteNO: TEdit;
    lbParam: TLabel;
    edtParam: TEdit;
    btnQuery: TSpeedButton;
    Panel2: TPanel;
    Panel3: TPanel;
    mmoFaultReason: TMemo;
    lbOKType: TLabel;
    lblFNColorCode: TLabel;
    lbFaultReason: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    edtStyleName: TEdit;
    edtRecipeNO: TEdit;
    edtQuantity: TEdit;
    edtPatternName: TEdit;
    edtLBNO: TEdit;
    edtFNColorCode: TEdit;
    edtFabColorName: TEdit;
    edtCustomer: TEdit;
    edtCPBGFNO: TEdit;
    edtCommentTime: TEdit;
    cbShade: TComboBox;
    cbOKType: TComboBox;
    cbCommentPeople: TComboBox;
    Label15: TLabel;
    plShowColor: TPanel;
    edtPatternID: TEdit;
    rgType: TRadioGroup;
    cbComment: TMemo;
    edtPrintCount: TComboBox;
    cdsHistory: TClientDataSet;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure cxgdTVTaskDblClick(Sender: TObject);
    procedure rgTypeClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure cxGridTVCPBDtlCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure edtParamKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgdTVTaskCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure lvChemicalGroupDblClick(Sender: TObject);
    procedure cxGridTVCPBDtlCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnDeleteClick(Sender: TObject);
    procedure cxGridTVCPBDtlCustomDrawIndicatorCell(
      Sender: TcxGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxCustomGridIndicatorItemViewInfo; var ADone: Boolean);
    procedure cbCommentPeopleChange(Sender: TObject);
    procedure edtPrintCountChange(Sender: TObject);

  private
    { private declarations }
    FiType:Integer;
    procedure InitializeShade;
    function FillChemicalGroup(Param_NO: string):string;
    procedure GetRecipeHdrInfo(Recipe_NO: string);
    procedure GetRecipeDtlInfo(Param_NO: string; Chemical_Group: string);
    procedure CheckRecipeInfo;
    procedure DeleteShadeInfo;
    procedure SetiType(const Value: Integer);
    function GetiType: Integer;
    procedure GetPrintCount(pRecipe_No:String);
  protected
    procedure UpdateActions; override;
  public
    { Public declarations }
    Status_ID: Integer;
    property iType: Integer read GetiType write SetiType;
  end;

var
  CPBCheckForm: TCPBCheckForm;
  CPBSELFCheckForm: TCPBCheckForm;
  CPBCustomerCheckForm: TCPBCheckForm;
  CPBSampleCheckForm: TCPBCheckForm;
implementation

uses Math, StrUtils, ServerDllPub, uFNMArtInfo,uFNMResource ,
    uDictionary, uShowMessage, uLogin, UAppOption, uGlobal, UGridDecorator,
    rptCPB;

{$R *.dfm}

function TCPBCheckForm.FillChemicalGroup(Param_NO: string): string;
var vData: OleVariant;
    sCondition: string;
    sErrorMsg: WideString;
begin
  Result := '';
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    sCondition := QuotedStr(Param_NO)+','+QuotedStr(Login.CurrentDepartment)+',' + IntToStr(iType);
    FNMServerObj.GetQueryData(vData,'CPBGetChemicalGroup',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TempClientDataSet.Data := vData;
    if TempClientDataSet.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有相关信息,请检查你的查询条件!',mtInformation);
      Exit;
    end;
    with TempClientDataSet do
    begin
      First;
      lvChemicalGroup.Items.Clear;
      while not Eof do
      begin
        lvChemicalGroup.Items.Add.Caption := FieldByName('Chemical_Group').AsString;
        Next;
      end;
    end;
    Result := lvChemicalGroup.Items[0].Caption;
    lvChemicalGroup.Visible := lvChemicalGroup.Items.Count > 1 ;
    lvChemicalGroup.Items[0].Selected := lvChemicalGroup.Items.Count > 1;
    if lvChemicalGroup.Visible then
      lvChemicalGroup.SetFocus;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCPBCheckForm.GetRecipeHdrInfo(Recipe_NO: string);
var vData: OleVariant;
    sCondition: string;
    sErrorMsg: WideString;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    sCondition := QuotedStr('')+','+QuotedStr('')+','+QuotedStr(Recipe_NO)+','+QuotedStr(Login.CurrentDepartment)+',' + IntToStr(iType);
    FNMServerObj.GetQueryData(vData,'CPBGetRecipeHdr',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TempClientDataSet.Data := vData[0];
    if TempClientDataSet.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有相关信息,请检查你的查询条件!',mtInformation);
      Exit;
    end;
    edtPatternID.Text := TempClientDataSet.FieldByName('Pattern_ID').AsString;
    edtCustomer.Text := TempClientDataSet.FieldByName('Customer').AsString;
    edtLBNO.Text := TempClientDataSet.FieldByName('LB_NO').AsString;
    edtPatternName.Text := TempClientDataSet.FieldByName('Pattern_Name').AsString;
    edtStyleName.Text := TempClientDataSet.FieldByName('Style_Name').AsString;
    edtFabColorName.Text := TempClientDataSet.FieldByName('Fab_Color_Name').AsString;
    TGlobal.SetComboBoxValue(cbShade, TempClientDataSet.FieldByName('Shade').AsString);
    edtCPBGFNO.Text := TempClientDataSet.FieldByName('GF_NO').AsString;
    edtQuantity.Text := TempClientDataSet.FieldByName('Quantity').AsString;
    edtFNColorCode.Text := TempClientDataSet.FieldByName('FN_Color_Code').AsString;
    lblFNColorCode.Caption:= TempClientDataSet.FieldByName('FN_Color_Code').AsString;
    plShowColor.Color := TempClientDataSet.FieldByName('RGB').AsInteger;
    mmoFaultReason.Lines.Text := TempClientDataSet.FieldByName('Fault_Reason').AsString;

    TempClientDataSet.Data := vData[1];
    FillItemsFromDataSet(TempClientDataSet, 'Item_Name', 'Item_Value', '', '=', vlePDParam.Strings);


  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCPBCheckForm.GetRecipeDtlInfo(Param_NO: string; Chemical_Group: string);
var vData: OleVariant;
    sCondition: string;
    sErrorMsg: WideString;
    i: Integer;
    Caption: string;
begin
  edtRecipeNO.Clear;
  edtPatternID.Clear;
  edtCustomer.Clear;
  edtLBNO.Clear;
  edtPatternName.Clear;
  edtStyleName.Clear;
  edtFabColorName.Clear;
  cbShade.Text := '';
  edtCPBGFNO.Clear;
  edtQuantity.Clear;
  edtFNColorCode.Clear;
  plShowColor.Color := clBtnFace;
  vlePDParam.Strings.Clear;
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    sCondition := QuotedStr(Param_NO)+','+QuotedStr(Chemical_Group)+','+QuotedStr(Login.CurrentDepartment)+',' + IntToStr(iType);
    FNMServerObj.GetQueryData(vData,'CPBGetRecipeDtl',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsCPBRecipeDtl.Data := vData;
    if cdsCPBRecipeDtl.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有相关信息,请检查你的查询条件!',mtInformation);
      Exit;
    end;
    GridDecorator.BindCxViewWithDataSource(cxGridTVCPBDtl, dsCPBRecipeDtl,True);
    GridDecorator.HideFields(cxGridTVCPBDtl,['Chemical_ID', 'Chemical_Type', 'Chemical_Name','Seq_NO','Seq_NO1']);
     // 客户OK 的配方,红色显示
    if iType = 2 then
    begin
      sCondition := QuotedStr(Param_NO)+','+QuotedStr(Chemical_Group)+','+QuotedStr(Login.CurrentDepartment)+',' + IntToStr(7);
      FNMServerObj.GetQueryData(vData,'CPBGetRecipeDtl',sCondition,sErrorMsg);
      TempClientDataSet.Data := vData;
      for i:= 0 to cxGridTVCPBDtl.ColumnCount - 1 do
      begin
        Caption := cxGridTVCPBDtl.Columns[i].Caption;
        if (Copy(Caption,1,2)='PD') and TempClientDataSet.locate('Recipe_NO',Caption,[]) then
          cxGridTVCPBDtl.Columns[i].Styles.Header := cxStyle1;
      end;
    end;

    //Content:（1）化工料名一栏冻结 拖动按扭 拖动时只有配方号滑动    Reason:    Added By Danny at 2015-02-10 10:32:33:664
//    for i:= 0 to cxGridTVCPBDtl.ColumnCount - 1 do
//    begin
//      if  cxGridTVCPBDtl.Columns[i].DataBinding.FieldName='Chemical_Name' then
//      begin
//        cxGridTVCPBDtl.Columns[i].VisibleIndex:=cxGridTVCPBDtl.ColumnCount-3;
//        Break;
//      end;
//    end;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
  cxGridTVCPBDtl.OptionsView.IndicatorWidth:=180;
end;

procedure TCPBCheckForm.DeleteShadeInfo;
var
  sCondition, sErrorMsg: WideString;
begin
  inherited;
  if (edtDeleteNO.Text ='')then Exit;
  if IDNO = Application.MessageBox('是否确定删除当前配方色级？', '提示', MB_YESNO + MB_ICONQUESTION) then exit;
  sCondition := QuotedStr(edtDeleteNO.Text)+','+ QuotedStr(Login.CurrentDepartment)+','+QuotedStr(Login.LoginID);
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    FNMServerObj.SaveDataBySQL('CPBDeleteShade',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    edtDeleteNO.Text := '';
    btnDelete.Enabled := False;
    TMsgDialog.ShowMsgDialog('删除配方色级成功',mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBCheckForm.FormCreate(Sender: TObject);
var
  str:string;
begin
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnExit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  cbbOperator.Items.Text := Dictionary.GetItemList('CPB调色师',Login.CurrentDepartment,'');

  if cbbOperator.Items.Count > 0 then
    cbbOperator.ItemIndex := 0;
  InitializeShade;
end;

procedure TCPBCheckForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TCPBCheckForm.FormDestroy(Sender: TObject);
begin
  CPBCheckForm:=nil;
  CPBSELFCheckForm := nil;
  CPBCustomerCheckForm := nil;
  CPBSampleCheckForm := nil;
end;

procedure TCPBCheckForm.btnSaveClick(Sender: TObject);
begin
  CheckRecipeInfo;
end;

procedure TCPBCheckForm.CheckRecipeInfo;
var
  sCondition, sErrorMsg: WideString;
  i : Integer;
  ItemNameStr,ItemValueStr: string;
begin
  if edtRecipeNO.Text ='' then
  begin
    TMsgDialog.ShowMsgDialog('请先选择配方号',mtWarning);
    Exit;
  end;
  if (rgType.ItemIndex = 1) and (mmoFaultReason.Lines.Text = '') then
  begin
    TMsgDialog.ShowMsgDialog('请输入错误原因',mtError);
    mmoFaultReason.SetFocus;
    Exit;
  end;

  ItemNameStr := '';
  ItemValueStr := '';
  if vlePDParam.Strings.Text <> '' then
  begin
    for i := 1 to vlePDParam.RowCount - 1 do //delete the first caption row
    begin
      ItemNameStr := ItemNameStr + vlePDParam.Keys[i] + '+';
      ItemValueStr := ItemValueStr + vlePDParam.Values[vlePDParam.Keys[i]] + '+';
    end;
  end;

  sCondition := QuotedStr(edtRecipeNO.Text)+',' + QuotedStr(edtPatternID.Text)+',' +
                QuotedStr(cbShade.Text)+','+
                QuotedStr(ItemNameStr)+','+QuotedStr(ItemValueStr)+','+
                QuotedStr(cbOKType.Text)+',' +QuotedStr(mmoFaultReason.Lines.Text)+',' +
                IntToStr(Status_ID)+','+ QuotedStr(Login.CurrentDepartment)+','+
                QuotedStr(cbbOperator.Text)+','+IntToStr(iType);
  if iType=2 then
  begin
    //Content:增加评语，评语人， 评语时间    Reason:    Added By Danny at 2015-02-10 15:53:00:321
    sCondition:=sCondition+','+QuotedStr(cbComment.Text)+','+QuotedStr(cbCommentPeople.Text)+','+QuotedStr(edtCommentTime.Text) + ',' + QuotedStr(lblFNColorCode.Caption);
  end;
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    FNMServerObj.SaveDataBySQL('CPBCheckRecipe',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    if cdsTask.Active and (not cdsTask.IsEmpty) then
    begin
      while cdsTask.Locate('FN_Color_Code', edtParam.Text, []) do
        cdsTask.Delete;
    end;
    edtParam.Clear;

    //cuijf 2009-11-22 OK处方
    if (iType=2) and (rgType.ItemIndex = 0) then
    begin
      ShowMsg('', crDefault);
      if TMsgDialog.ShowMsgDialog('是否打印ＯＫ处方存档卡?', mtConfirmation, [mebYes, mebNo], mebYes)= mrYes then
      begin
        if not Assigned(CPBReport) then
          CPBReport := TCPBReport.Create(nil);
        CPBReport.sOKType := cbOKType.Text;
        CPBReport.PreivewCPBOKRecipeReport(edtRecipeNO.Text,True);
      end;
    end;

    TMsgDialog.ShowMsgDialog('保存数据成功',mtInformation);
    cbComment.Clear;
  finally
    ShowMsg('', crDefault);
  end; 
end;

procedure TCPBCheckForm.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TCPBCheckForm.btnRefreshClick(Sender: TObject);
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
begin
  inherited;
  sCondition := QuotedStr(Login.CurrentDepartment)+','+IntToStr(iType);
  FNMServerObj.GetQueryData(vData,'CPBGetTask',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  cdsTask.Data := vData;
  GridDecorator.BindCxViewWithDataSource(cxgdTVTask, dsTask);
  with cxgdTVTask.GetColumnByFieldName('Ppo_Type') do
  begin
    GroupIndex := 0;
    Visible := False;
  end;
  cxgdTVTask.DataController.Groups.FullExpand;
end;

procedure TCPBCheckForm.cxgdTVTaskDblClick(Sender: TObject);
begin
  edtParam.Text := cdsTask.FieldByName('FN_Color_Code').AsString;
  btnQuery.Click;
end;

procedure TCPBCheckForm.rgTypeClick(Sender: TObject);
begin
  inherited;
  if iType = 1 then
  begin
    if rgType.ItemIndex = 0 then
      Status_ID := 3   //3 FN打板OK方
    else
      Status_ID := 5;  //5 FN打板不OK方
  end;
  if iType = 2 then
  begin
    if rgType.ItemIndex = 0 then
      Status_ID := 4   //4 FN客户OK方
    else
      Status_ID := 6;  //6 FN客户不OK方
  end;
  if iType = 3 then
  begin
    if rgType.ItemIndex = 0 then
      Status_ID := 8   //8 FN小样OK方
    else
      Status_ID := 9;  //9 FN不OK方
  end;
  mmoFaultReason.SetFocus;
end;

procedure TCPBCheckForm.btnQueryClick(Sender: TObject);
var
  ChemicalGroup: string;
begin
  lblFNColorCode.Caption := edtParam.Text;
  if edtParam.Text='' then
    Exit;
  //2009-12-23 小样Check时，显示的是品名，比较长需要将字体缩小
  if iType=3 then
  begin
    lblFNColorCode.Font.Size := 14;
    lblFNColorCode.Caption:= '';
  end;
  plShowColor.Left:= lblFNColorCode.Left;
  plShowColor.Top:= lblFNColorCode.Top + lblFNColorCode.Height + 5;
  ChemicalGroup := FillChemicalGroup(edtParam.Text);
  GetRecipeDtlInfo(edtParam.Text,ChemicalGroup);

  if iType=2 then
  begin
    //Content:增加评语，评语人， 评语时间    Reason:    Added By Danny at 2015-02-10 15:53:00:321
    cbComment.Clear;
    edtCommentTime.Clear;
    cbCommentPeople.Text:= '';
    cbCommentPeople.ItemIndex:= -1;
    edtPrintCount.ItemIndex:= -1;
    GetPrintCount(Trim(edtParam.Text));
  end;
  InitializeShade;
end;

procedure TCPBCheckForm.cxGridTVCPBDtlCellClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  if Copy(ACellViewInfo.Item.Caption,1,2)='PD' then
    edtRecipeNO.Text := ACellViewInfo.Item.Caption
  else
    edtRecipeNO.Text := '';
  if edtRecipeNO.Text = '' then Exit;
  GetRecipeHdrInfo(edtRecipeNO.Text);
end;

procedure TCPBCheckForm.edtParamKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
    btnQuery.Click;
end;

procedure TCPBCheckForm.cxgdTVTaskCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var col:Integer;
begin
  inherited;
  col := TcxGridDBTableView(Sender).GetColumnByFieldName('RGB').Index;
  if AViewInfo.Item.Caption = 'RGB' then
  begin
    ACanvas.Brush.Color := AViewInfo.GridRecord.Values[col];
    ACanvas.Font.Color := AViewInfo.GridRecord.Values[col];
  end;
end;

procedure TCPBCheckForm.lvChemicalGroupDblClick(Sender: TObject);
var
  ChemicalGroup: string;
begin
  inherited;
  if lvChemicalGroup.Selected = nil then Exit;
  ChemicalGroup := lvChemicalGroup.Selected.Caption;
  GetRecipeDtlInfo(edtParam.Text,ChemicalGroup);
end;

procedure TCPBCheckForm.cxGridTVCPBDtlCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  iChemicalType:Integer;
begin
  inherited;
  if AViewInfo.Focused then
    Exit;

  iChemicalType := TcxGridDBTableView(Sender).GetColumnByFieldName('Chemical_Type').Index;
  if AViewInfo.GridRecord.Values[iChemicalType] = 'CPB助剂' then
    ACanvas.Font.Color := clSilver;
end;

procedure TCPBCheckForm.UpdateActions;
begin
  inherited;
  cbShade.Enabled := edtRecipeNO.Text<>'';
  btnSave.Enabled := cbShade.Enabled;
  gbDeleteShade.Visible := (iType=2) and (Status_ID = 4);
end;

procedure TCPBCheckForm.InitializeShade;
begin
  cbShade.Items.Text := Dictionary.GetItemList('CPB色级',edtParam.Text, Login.CurrentDepartment);
end;

procedure TCPBCheckForm.btnDeleteClick(Sender: TObject);
begin
  DeleteShadeInfo;
end;

procedure TCPBCheckForm.cxGridTVCPBDtlCustomDrawIndicatorCell(
  Sender: TcxGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridIndicatorItemViewInfo; var ADone: Boolean);
var
  FValue:string;
  FBounds: TRect;
begin
  inherited;
  FBounds := AViewInfo.Bounds;
  if (AViewInfo is TcxGridIndicatorRowItemViewInfo) then
  begin
    ACanvas.FillRect(FBounds);
    ACanvas.DrawComplexFrame(FBounds, clBlack, clBlack, [bBottom, bLeft, bRight], 1);
    //FValue := IntToStr(TcxGridIndicatorRowItemViewInfo(AViewInfo).GridRecord.Index+1);
    FValue:=cxGridTVCPBDtl.DataController.GetValue(TcxGridIndicatorRowItemViewInfo(AViewInfo).GridRecord.Index,3);
    InflateRect(FBounds, -3, -2); //Platform specific. May not work on Linux.
    ACanvas.Font.Color := clBlack;
    ACanvas.Brush.Style := bsClear;
    //ACanvas.DrawText(FValue, FBounds, cxAlignCenter or cxAlignTop);
    ACanvas.DrawText(FValue, FBounds, cxAlignLeft or cxAlignTop);
    ADone := True;
    OutputDebugString(PChar(IntToStr(cxGridTVCPBDtl.OptionsView.IndicatorWidth)));
  end;
end;

procedure TCPBCheckForm.SetiType(const Value: Integer);
begin
  FiType := Value;
  if FiType=2 then
  begin
    //Content:（1）保留配方参数，配方号，品名，RGB信息，色级选项框，删除色级对话框，其余信息删除。    Reason:    Added By Danny at 2015-02-10 15:06:49:612
    Label11.Visible:=False;
    edtCustomer.Visible:=False;
    Label1.Visible:=False;
    edtLBNO.Visible:=False;
    Label3.Visible:=False;
    edtPatternName.Visible:=False;
    Label5.Visible:=False;
    edtStyleName.Visible:=False;
    Label9.Visible:=False;
    edtFabColorName.Visible:=False;
    Label7.Visible:=False;
    edtQuantity.Visible:=False;
    Label8.Visible:=False;
    edtFNColorCode.Visible:=False;

    Label12.Left:=Label3.Left;  Label12.Top:=Label3.Top; Label12.Visible:=True;
    Label13.Left:=Label6.Left;  Label13.Top:=Label6.Top; Label13.Visible:=True;
    Label14.Left:=Label7.Left;  Label14.Top:=Label7.Top; Label14.Visible:=True;
    Label15.Left:=Label1.Left;  Label15.Top:=Label1.Top; Label15.Visible:=True;

    cbComment.Left:= edtPatternName.Left;   cbComment.Top:=edtPatternName.Top;  cbComment.Visible:=True;
    cbCommentPeople.Left:=edtCPBGFNO.Left;    cbCommentPeople.Top:=edtCPBGFNO.Top;   cbCommentPeople.Visible:=True;
    edtCommentTime.Left:=edtQuantity.Left;  edtCommentTime.Top:=edtQuantity.Top; edtCommentTime.Visible:=True;
    edtPrintCount.Left:= edtLBNO.Left; edtPrintCount.Top:= edtLBNO.Top; edtPrintCount.Visible:= True;
    cbCommentPeople.Items.Text:=cbbOperator.Items.Text;

    Label6.Top:=Label11.Top;
    edtCPBGFNO.Top:=edtCustomer.Top;
    //Label4.Top:=Label1.Top;
    //cbShade.Top:=edtLBNO.Top;
  end;
end;

function TCPBCheckForm.GetiType: Integer;
begin
  Result:=FiType;
end;

procedure TCPBCheckForm.cbCommentPeopleChange(Sender: TObject);
begin
  inherited;
  if cbCommentPeople.Visible then
  begin
    edtCommentTime.Text:=FormatDateTime('yyyy-MM-dd HH:mm:ss', Now);
  end;
end;

procedure TCPBCheckForm.GetPrintCount(pRecipe_No: String);
var
  sCondition: String;
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  edtPrintCount.Text:= '';
  edtPrintCount.Items.Clear;
  sCondition := QuotedStr(edtParam.Text) + ',' + QuotedStr(Login.CurrentDepartment);
  FNMServerObj.GetQueryData(vData,'GetRePrintRecipeInfo',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  cdsHistory.Data := vData;
  if not cdsHistory.IsEmpty then
  begin
    cdsHistory.First;
    while not cdsHistory.Eof do
    begin
      edtPrintCount.Items.Add(cdsHistory.FieldByName('PrintCount').AsString);
      cdsHistory.Next;
    end;
    //指向最大打印次数
    cdsHistory.Last;
    edtPrintCount.ItemIndex:= edtPrintCount.Items.IndexOf(cdsHistory.FieldByName('PrintCount').AsString);
    cbComment.Text:=cdsHistory.FieldByName('Comment').AsString;
    cbCommentPeople.Text:=cdsHistory.FieldByName('CommentPeoper').AsString;
    edtCommentTime.Text:=cdsHistory.FieldByName('CommentTime').AsString;
  end;
end;

procedure TCPBCheckForm.edtPrintCountChange(Sender: TObject);
begin
  inherited;
  if iType=2 then
  begin
    if not cdsHistory.IsEmpty then
    begin
      cbComment.Text:= '';
      cbCommentPeople.Text:='';
      edtCommentTime.Text:= '';
      if cdsHistory.Locate('PrintCount',StrToIntDef(edtPrintCount.Text,0),[]) then
      begin
        cbComment.Text:=cdsHistory.FieldByName('Comment').AsString;
        cbCommentPeople.Text:=cdsHistory.FieldByName('CommentPeoper').AsString;
        edtCommentTime.Text:=cdsHistory.FieldByName('CommentTime').AsString;
      end;
    end;
  end;
end;

end.
