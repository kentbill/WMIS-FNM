unit frmCPBDirect;
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
  Windows, Messages, SysUtils, Variants,Dialogs, Graphics,
  Classes, Controls, Forms, DB, DBClient, cxButtonEdit, cxSplitter,
  ComCtrls, StdCtrls, Grids, ValEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxSpinEdit, Buttons, ExtCtrls, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGrid, cxGridDBTableView, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxDBData, DBCtrls, Mask, frmBase, DBGrids;

type
  TCPBDirectForm = class(TBaseForm)
    pnlTop: TPanel;
    btnSave: TSpeedButton;
    btnExit: TSpeedButton;
    grp2: TGroupBox;
    Label1: TLabel;
    edtSampleGFNO: TEdit;
    btnQuery: TSpeedButton;
    btnRefresh: TSpeedButton;
    GroupBox4: TGroupBox;
    btnAdd: TSpeedButton;
    btnDel: TSpeedButton;
    dsTask: TDataSource;
    cdsTask: TClientDataSet;
    cxGrid2: TcxGrid;
    cxgdTVTask: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    tvChemical: TTreeView;
    cbbChemicalName: TComboBox;
    cxSplitter1: TcxSplitter;
    pn1: TPanel;
    cxSplitter3: TcxSplitter;
    cdsCPBRecipeDtl: TClientDataSet;
    dsCPBRecipeDtl: TDataSource;
    cbChemicalGroup: TComboBox;
    Label4: TLabel;
    gbLeft: TGroupBox;
    vleChemicallist: TValueListEditor;
    cxSplitter2: TcxSplitter;
    gbClient: TGroupBox;
    cxGrid1: TcxGrid;
    cxGridTVCPBDtl: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    gbRight: TGroupBox;
    Panel1: TPanel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    lblFNColorCode: TLabel;
    edtRecipeNO: TEdit;
    edtQuantity: TEdit;
    edtFNColorCode: TEdit;
    edtGFNO: TEdit;
    edtCustomer: TEdit;
    plShowColor: TPanel;
    vlePDParam: TValueListEditor;
    cxSplitter4: TcxSplitter;
    btnDown: TSpeedButton;
    btnUp: TSpeedButton;
    lvChemicalGroup: TListView;
    btnCalc: TSpeedButton;
    Label3: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtLBNO: TEdit;
    edtPatternName: TEdit;
    edtStyleName: TEdit;
    edtFabColorName: TEdit;
    edtPatternID: TEdit;
    cbExport: TCheckBox;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure vleChemicallistValidate(Sender: TObject; ACol,
      ARow: Integer; const KeyName, KeyValue: String);
    procedure btnSaveClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure cbChemicalGroupChange(Sender: TObject);
    procedure cxgdTVTaskDblClick(Sender: TObject);
    procedure tvChemicalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbbChemicalNameDblClick(Sender: TObject);
    procedure edtSampleGFNOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgdTVTaskCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure lvChemicalGroupDblClick(Sender: TObject);
    procedure btnCalcClick(Sender: TObject);
    procedure edtLBNOChange(Sender: TObject);
    procedure edtSampleGFNOChange(Sender: TObject);
    procedure vlePDParamGetPickList(Sender: TObject; const KeyName: String;
      Values: TStrings);
  private
    { private declarations }
    Ppo_Type : string;
    procedure RefreshTaskInfo;
    function CheckChemmicalData(var AChemicalStr: string; var AUnitQtyStr: string): Boolean;
    procedure CalcAuxiliaries;
    function FillChemicalGroup(Param_NO: string):string;
    procedure GetRecipeHdrInfo;
    procedure GetRecipeDtlInfo(Param_NO: string; Chemical_Group: string);
  public
    { Public declarations }
  end;

var
  CPBDirectForm: TCPBDirectForm;

implementation

uses Math, StrUtils, ServerDllPub, uFNMArtInfo,uFNMResource ,
    uDictionary, uShowMessage, uLogin, UAppOption, uGlobal, UGridDecorator;

{$R *.dfm}
function TCPBDirectForm.CheckChemmicalData(var AChemicalStr: string; var AUnitQtyStr: string): Boolean;
var i: Integer;
begin
  Result := False;
  if vleChemicallist.Strings.Text <> '' then
  begin
    for i := 1 to vleChemicallist.RowCount - 1 do
    begin
      AChemicalStr := AChemicalStr + IntTostr(Integer(vleChemicallist.Strings.Objects[i-1])) + '+';
      AUnitQtyStr := AUnitQtyStr + vleChemicallist.Values[vleChemicallist.Keys[i]] + '+';
    end;
  end;
  Result := (AChemicalStr<>'') and (AUnitQtyStr<>'');
end;

procedure TCPBDirectForm.CalcAuxiliaries;
var
  ChemicalStr, UnitQtyStr: string;
  vData: OleVariant;
  sCondition: string;
  sErrorMsg: WideString;
begin
  ChemicalStr := '';
  UnitQtyStr := '';
  if not CheckChemmicalData(ChemicalStr,UnitQtyStr) then Exit;
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    sCondition := QuotedStr(ChemicalStr)+','+QuotedStr(UnitQtyStr);
    FNMServerObj.GetQueryData(vData,'CPBCalcAuxiliaries',sCondition,sErrorMsg);
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
    FillItemsFromDataSet(TempClientDataSet, 'Chemical_Name', 'Unit_QTY', 'Chemical_ID', '=', vleChemicallist.Strings);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;    

function TCPBDirectForm.FillChemicalGroup(Param_NO: string): string;
var vData: OleVariant;
    sCondition: string;
    sErrorMsg: WideString;
begin
  Result := '';
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    sCondition := QuotedStr(Param_NO)+','+QuotedStr(Login.CurrentDepartment)+',0';
    FNMServerObj.GetQueryData(vData,'CPBGetChemicalGroup',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TempClientDataSet.Data := vData;
    if TempClientDataSet.IsEmpty then Exit;
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
    lvChemicalGroup.Visible := lvChemicalGroup.Items.Count > 1;
    lvChemicalGroup.Items[0].Selected := lvChemicalGroup.Items.Count > 1;
    if lvChemicalGroup.Visible then
      lvChemicalGroup.SetFocus;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCPBDirectForm.GetRecipeHdrInfo;
var vData: OleVariant;
    sCondition, sErrorMsg: WideString;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    sCondition := QuotedStr(edtLBNO.Text)+','+ QuotedStr(edtFNColorCode.Text)+','+QuotedStr('')+','+QuotedStr(login.CurrentDepartment)+',0';
    FNMServerObj.GetQueryData(vData,'CPBGetRecipeHdr',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TempClientDataSet.Data := vData[0];
    if TempClientDataSet.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有此色号相关信息,请检查输入的来样编号或色号是否正确!',mtInformation);
      Exit;
    end;
    edtRecipeNO.Text := '';
   // edtRecipeNO.Text := TempClientDataSet.FieldByName('Recipe_NO').AsString;
    edtPatternID.Text := TempClientDataSet.FieldByName('Pattern_ID').AsString;
    edtCustomer.Text := TempClientDataSet.FieldByName('Customer').AsString;
    edtLBNO.Text := TempClientDataSet.FieldByName('LB_NO').AsString;
    edtPatternName.Text := TempClientDataSet.FieldByName('Pattern_Name').AsString;
    edtStyleName.Text := TempClientDataSet.FieldByName('Style_Name').AsString;
    edtFabColorName.Text := TempClientDataSet.FieldByName('Fab_Color_Name').AsString;
    edtGFNO.Text := TempClientDataSet.FieldByName('GF_NO').AsString;
    Ppo_Type := TempClientDataSet.FieldByName('Ppo_Type').AsString;
    edtQuantity.Text := TempClientDataSet.FieldByName('Quantity').AsString;
    edtFNColorCode.Text := TempClientDataSet.FieldByName('FN_Color_Code').AsString;
    plShowColor.Color := TempClientDataSet.FieldByName('RGB').AsInteger;

    TempClientDataSet.Data := vData[1];
    FillItemsFromDataSet(TempClientDataSet, 'Item_Name', 'Item_Value', '', '=', vlePDParam.Strings);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCPBDirectForm.GetRecipeDtlInfo(Param_NO: string; Chemical_Group: string);
var vData: OleVariant;
    sCondition: string;
    sErrorMsg: WideString;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    sCondition := QuotedStr(Param_NO)+','+QuotedStr(Chemical_Group)+','+QuotedStr(Login.CurrentDepartment)+',0';
    FNMServerObj.GetQueryData(vData,'CPBGetRecipeDtl',sCondition,sErrorMsg);
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
    FillItemsFromDataSet(TempClientDataSet, 'Chemical_Name', 'Unit_QTY', 'Chemical_ID', '=', vleChemicallist.Strings);
    cdsCPBRecipeDtl.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxGridTVCPBDtl, dsCPBRecipeDtl,True);
    GridDecorator.HideFields(cxGridTVCPBDtl,['Chemical_ID','Unit_QTY']);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCPBDirectForm.FormCreate(Sender: TObject);
begin
  btnCalc.Glyph.LoadFromResourceName(HInstance, RES_CALCULATE);
  btnQuery.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnAdd.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnUp.Glyph.LoadFromResourceName(HInstance, RES_UP);
  btnDown.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnDel.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnExit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  SetWindowLong(edtQuantity.Handle, GWL_STYLE, GetWindowLong(edtQuantity.Handle, GWL_STYLE) or ES_NUMBER);
  PageControl1.ActivePageIndex := 0;
  cbbChemicalName.Align := alClient;
  FillItemsFromDataSet(Dictionary.cds_ChemicalList, 'Chemical_Short_Name', '', 'Chemical_ID', '', cbbChemicalName.Items);
  FillTreeItemsFromDataSetByClassField(Dictionary.cds_CPBChemical, 'Chemical_Name', 'Chemical_Type','Chemical_ID', '', tvChemical.Items);
  FillItemsFromDataSet(Dictionary.cds_CPBChemicalGroup, 'Group_Name', '', '', '', cbChemicalGroup.Items);
  cbChemicalGroup.Items.Insert(0,''); 
end;

procedure TCPBDirectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCPBDirectForm.FormDestroy(Sender: TObject);
begin
  CPBDirectForm :=nil;
end;

procedure TCPBDirectForm.btnSaveClick(Sender: TObject);
var
  Recipe_NO,sCondition, sErrorMsg: WideString;
  i : Integer;
  ChemicalStr, UnitQtyStr,ItemNameStr,ItemValueStr: string;
begin
  if edtLBNO.Text = '' then Exit;
  if edtFNColorCode.Text = '' then Exit;
  if edtPatternID.Text = '' then
  begin
    TMsgDialog.ShowMsgDialog('请刷新数据!',mtInformation);
    Exit;
  end;

  if cbChemicalGroup.Text='' then
  begin
    cbChemicalGroup.SetFocus;
    TMsgDialog.ShowMsgDialog('染料组合不能为空，请选择染料组合!',mtInformation);
    Exit;
  end;

  ChemicalStr := '';
  UnitQtyStr := '';
  if not CheckChemmicalData(ChemicalStr,UnitQtyStr) then Exit;
  
  ItemNameStr := '';
  ItemValueStr := '';
  if vlePDParam.Strings.Text <> '' then
  begin
    for i := 1 to vlePDParam.RowCount - 1 do
    begin
      ItemNameStr := ItemNameStr + vlePDParam.Keys[i] + '+';
      ItemValueStr := ItemValueStr + vlePDParam.Values[vlePDParam.Keys[i]] + '+';
    end;
  end;
  sCondition := QuotedStr('')+',' + QuotedStr(edtPatternID.Text)+',' + QuotedStr(edtLBNO.Text)+','+
                QuotedStr(edtFabColorName.Text)+',' +QuotedStr(edtSampleGFNO.Text)+',' +QuotedStr(edtQuantity.Text)+',' +
                QuotedStr(ChemicalStr)+','+  QuotedStr(UnitQtyStr)+','+QuotedStr(ItemNameStr)+','+QuotedStr(ItemValueStr)+','+
                QuotedStr(Ppo_Type)+','+ QuotedStr(edtFNColorCode.Text)+','+
                QuotedStr(Login.CurrentDepartment)+','+QuotedStr(Login.LoginID)+','+
                QuotedStr(cbChemicalGroup.Text)+','+ IfThen(cbExport.Checked,'1','0');
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    FNMServerObj.SaveDataBySQLEx('CPBSaveRecipeEx',sCondition,Recipe_NO,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    edtRecipeNO.Text := Recipe_NO;

    if cdsTask.Active and (not cdsTask.IsEmpty) then
    begin
      while cdsTask.Locate('GF_NO',edtSampleGFNO.Text, []) do
        cdsTask.Delete;
    end;

    if cbExport.Checked then
      TGlobal.GenerateRCPFile(Recipe_NO);
    TMsgDialog.ShowMsgDialog('保存数据成功',mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBDirectForm.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TCPBDirectForm.vleChemicallistValidate(Sender: TObject; ACol,
  ARow: Integer; const KeyName, KeyValue: String);
var
  tempe: Extended;
  Unit_QTY: string;
begin
  if KeyName ='' then Exit;
  Unit_QTY := StringReplace(KeyValue, ' ', '', [rfReplaceAll]);

  if not TryStrToFloat(Unit_QTY, tempe)then
    raise Exception.CreateResFmt(@INV_NOItemValue, ['Numeric', 'Numeric']);

  if tempe < 0 then
    raise Exception.CreateResFmt(@INV_ValueIsLessThenZero, ['']);
end;

procedure TCPBDirectForm.btnQueryClick(Sender: TObject);
var
  ChemicalGroup: string;
begin
  if edtSampleGFNO.Text = '' then Exit;
  if not cdsTask.Active and cdsTask.IsEmpty then
    RefreshTaskInfo;
  if not cdsTask.Locate('GF_NO',edtSampleGFNO.Text,[]) then
    RefreshTaskInfo;
  if not cdsTask.Locate('GF_NO',edtSampleGFNO.Text,[]) then
  begin
    TMsgDialog.ShowMsgDialog('没有此品名相关信息,请检查输入的品名是否正确或联系系统管理员!',mtInformation);
    Exit;
  end else
  begin
    edtLBNO.Text := cdsTask.FieldByName('LB_NO').AsString;
    edtFNColorCode.Text := cdsTask.FieldByName('Fab_Color_Code').AsString;
    lblFNColorCode.Caption := edtFNColorCode.Text;
  end;
  GetRecipeHdrInfo;
  ChemicalGroup := FillChemicalGroup(edtFNColorCode.Text);
  GetRecipeDtlInfo(edtFNColorCode.Text,ChemicalGroup);
end;

procedure TCPBDirectForm.btnAddClick(Sender: TObject);
var
  Chemical_ID: Integer;
begin
  inherited;
  if edtPatternID.Text = '' then Exit;
  if (tvChemical.Selected = nil) or (tvChemical.Selected.Level = 0) then exit;
  Chemical_ID:=Integer(tvChemical.Selected.Data);
  if vleChemicallist.Strings.IndexOfObject(TObject(Chemical_ID)) = -1 then
     if vleChemicallist.RowCount = 2 then
       vleChemicallist.Strings.AddObject(tvChemical.Selected.Text + '=0.00', TObject(Chemical_ID))
     else
       vleChemicallist.Strings.InsertObject(vleChemicallist.Row, tvChemical.Selected.Text + '=0.00', TObject(Chemical_ID));
end;

procedure TCPBDirectForm.btnDelClick(Sender: TObject);
begin
  inherited;
  if vleChemicallist.Strings.Text <> '' then
    vleChemicallist.DeleteRow(vleChemicallist.Row);
end;

procedure TCPBDirectForm.btnRefreshClick(Sender: TObject);
begin
  RefreshTaskInfo;
end;

procedure TCPBDirectForm.RefreshTaskInfo;
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
begin
  inherited;
  sCondition := QuotedStr(Login.CurrentDepartment)+',10';
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

procedure TCPBDirectForm.cbChemicalGroupChange(Sender: TObject);
var
  Chemical_ID,GroupName: string;
  i,ChemicalCount:Integer;
begin
  inherited;
  if edtPatternID.Text = '' then Exit;
  if cbChemicalGroup.Text = '' then Exit;
  ChemicalCount :=vleChemicallist.Strings.Count-1;
  for i := 0 to ChemicalCount do 
  begin
    Chemical_ID := IntTostr(Integer(vleChemicallist.Strings.Objects[0]));
    if Dictionary.cds_CPBChemical.Locate('Chemical_ID;Chemical_Type',VarArrayOf([Chemical_ID, 'CPB染料']), []) then
       vleChemicallist.Strings.Delete(0);
  end;

  GroupName := cbChemicalGroup.Text;
  with Dictionary.cds_CPBChemicalGroup do
  try
    Filter:=Format('Group_Name = ''%s''', [GroupName]);
    Filtered:=true;
    First;
    while not Eof do
    begin
      vleChemicallist.Strings.InsertObject(0,FieldByName('Chemical_Name').AsString+'=0.0',TObject(FieldByName('Chemical_ID').AsInteger));
      Next;
    end;
  finally
    Filtered:=False;
  end;
end;

procedure TCPBDirectForm.cxgdTVTaskDblClick(Sender: TObject);
begin
  inherited;
  if not cdsTask.Active then Exit;
  edtSampleGFNO.Text := cdsTask.FieldByName('GF_NO').AsString;
  edtLBNO.Text := cdsTask.FieldByName('LB_NO').AsString;
  edtFNColorCode.Text := cdsTask.FieldByName('Fab_Color_Code').AsString;
  Ppo_Type := cdsTask.FieldByName('Ppo_Type').AsString;
  btnQuery.Click;
end;

procedure TCPBDirectForm.tvChemicalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    btnAdd.Click;
end;

procedure TCPBDirectForm.cbbChemicalNameDblClick(Sender: TObject);
var
  Chemical_ID: Integer;
begin
  inherited;
  if edtPatternID.Text = '' then Exit;
  with cbbChemicalName do
  begin
    if Text = '' then Exit;
    Chemical_ID := Integer(Items.Objects[Items.IndexOf(Text)]);
  end;
  if vleChemicallist.Strings.IndexOfObject(TObject(Chemical_ID)) = -1 then
     vleChemicallist.Strings.AddObject(cbbChemicalName.Items[cbbChemicalName.ItemIndex] + '=0.00', TObject(Chemical_ID));
end;

procedure TCPBDirectForm.edtSampleGFNOKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key =  13 then
   btnQuery.Click;
end;

procedure TCPBDirectForm.cxgdTVTaskCustomDrawCell(
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

procedure TCPBDirectForm.btnUpClick(Sender: TObject);
begin
  inherited;
  if (vleChemicallist.Strings.Text <>'') and (vleChemicallist.Row >1) then
     vleChemicallist.Strings.Exchange(vleChemicallist.Row-1,vleChemicallist.Row-2);
end;

procedure TCPBDirectForm.btnDownClick(Sender: TObject);
begin
  inherited;
  if (vleChemicallist.Strings.Text <>'') and (vleChemicallist.Row <vleChemicallist.RowCount-1) then
     vleChemicallist.Strings.Exchange(vleChemicallist.Row-1,vleChemicallist.Row);
end;

procedure TCPBDirectForm.lvChemicalGroupDblClick(Sender: TObject);
var
  ChemicalGroup: string;
begin
  if lvChemicalGroup.Selected = nil then Exit;
  ChemicalGroup := lvChemicalGroup.Selected.Caption;
  GetRecipeDtlInfo(edtFNColorCode.Text,ChemicalGroup);
end;

procedure TCPBDirectForm.btnCalcClick(Sender: TObject);
begin
  CalcAuxiliaries;
end;

procedure TCPBDirectForm.edtLBNOChange(Sender: TObject);
begin
  inherited;
  edtPatternID.Text := '';
end;

procedure TCPBDirectForm.edtSampleGFNOChange(Sender: TObject);
begin
  inherited;
  edtPatternID.Text := '';
end;

procedure TCPBDirectForm.vlePDParamGetPickList(Sender: TObject;
  const KeyName: String; Values: TStrings);
begin
  inherited;
  if KeyName='打板样式' then
     Values.Text := '微波打板' + #13 + '堆置打板';
end;

end.

