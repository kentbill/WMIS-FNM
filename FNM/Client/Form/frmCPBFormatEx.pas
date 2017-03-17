unit frmCPBFormatEx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ComCtrls, Buttons, Grids, ValEdit, StdCtrls, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, DBClient, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, CheckLst, cxSplitter;

type
  TCPBFormatExForm = class(TBaseForm)
    pnlTop: TPanel;
    grp2: TGroupBox;
    btnSave: TSpeedButton;
    btnExit: TSpeedButton;
    lb0: TLabel;
    btnQuery: TSpeedButton;
    Label1: TLabel;
    edtNewRecipe: TEdit;
    pn1: TPanel;
    cxSplitter2: TcxSplitter;
    cxSplitter1: TcxSplitter;
    cxSplitter3: TcxSplitter;
    cdsCPBRecipeDtl: TClientDataSet;
    dsCPBRecipeDtl: TDataSource;
    GroupBox2: TGroupBox;
    cxSplitter4: TcxSplitter;
    pnlRight: TPanel;
    gbHistory: TGroupBox;
    cxGrid1: TcxGrid;
    cxGridTVCPBDtl: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    gbFNCard: TGroupBox;
    cbAll: TCheckBox;
    vleChemicallist: TValueListEditor;
    GroupBox3: TGroupBox;
    vlePDParam: TValueListEditor;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    lblFNColorCode: TLabel;
    edtRecipeNO: TEdit;
    edtPatternName: TEdit;
    edtCPBGFNO: TEdit;
    edtQuantity: TEdit;
    edtFNColorCode: TEdit;
    edtLBNO: TEdit;
    edtFabColorName: TEdit;
    cbShade: TComboBox;
    plShowColor: TPanel;
    GroupBox4: TGroupBox;
    btnAdd: TSpeedButton;
    btnDel: TSpeedButton;
    Label10: TLabel;
    cbChemicalGroup: TComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    tvChemical: TTreeView;
    TabSheet2: TTabSheet;
    cbbChemicalName: TComboBox;
    btnDown: TSpeedButton;
    btnUp: TSpeedButton;
    lvChemicalGroup: TListView;
    btnCalc: TSpeedButton;
    lvFNCard: TListView;
    edtPatternID: TEdit;
    Label11: TLabel;
    edtStyleName: TEdit;
    btnDelete: TSpeedButton;
    edtDeleteNO: TEdit;
    lblDeleteNO: TLabel;
    gbHistoryRecipe: TGroupBox;
    cbbHistoryRecipe: TComboBox;
    btnPrint: TSpeedButton;
    edtFabColorCode: TEdit;
    btnRefresh: TSpeedButton;
    lvGFNO: TListView;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure tvChemicalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSaveClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbAllClick(Sender: TObject);
    procedure cbbChemicalNameDblClick(Sender: TObject);
    procedure cxgdTVTaskCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cbChemicalGroupChange(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure lvChemicalGroupDblClick(Sender: TObject);
    procedure vleChemicallistValidate(Sender: TObject; ACol, ARow: Integer;
      const KeyName, KeyValue: String);
    procedure btnCalcClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure edtFabColorCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRefreshClick(Sender: TObject);
  private
    { Private declarations }
    tmpGFNO: string;
    procedure FillGFNO(FabColorCode: string);
    procedure FillFNCard;
    function FillChemicalGroup(GF_NO: string): string;
    procedure GetRecipeHdrInfo(Recipe_NO: string);
    function GetRecipeDtlInfo(GF_NO: string;Chemical_Group: string): string;
    function CheckChemmicalData(var AChemicalStr:string; var AUnitQtyStr: string): Boolean;
    procedure CalcAuxiliaries;
    procedure SaveFormatInfo;
    procedure DeleteRecipeInfo;
  protected
    procedure UpdateActions; override;
  public
    { Public declarations }
    iType: Integer;
  end;

var
  CPBFormatExForm: TCPBFormatExForm;
  CPBSampleExForm: TCPBFormatExForm;
  CPBBulkExForm: TCPBFormatExForm;
implementation

uses Math, StrUtils, ServerDllPub, uFNMArtInfo,uFNMResource , uDictionary,
     uShowMessage, uLogin, UAppOption, uGlobal, UGridDecorator, rptCPB;
{$R *.dfm}

function TCPBFormatExForm.CheckChemmicalData(var AChemicalStr: string; var AUnitQtyStr: string): Boolean;
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

procedure TCPBFormatExForm.CalcAuxiliaries;
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

procedure TCPBFormatExForm.FillGFNO(FabColorCode: string);
var vData: OleVariant;
    sCondition: string;
    sErrorMsg: WideString;
begin
  if Trim( FabColorCode) = '' then Exit;
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    sCondition := QuotedStr(Login.CurrentDepartment)+','+ IntTostr(iType);
    FNMServerObj.GetQueryData(vData,'CPBGetTask',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TempClientDataSet.Data := vData;
    lvFNCard.Clear;
    with TempClientDataSet do
    begin
      First;
      while not Eof do
      begin
        with lvGFNO.Items.Add do
        begin
          Caption := FieldByName('GF_NO').AsString;
//          SubItems.Add(FieldByName('Fab_Color_Name').AsString);
//          SubItems.Add(FieldByName('Construction').AsString);
//          SubItems.Add(FieldByName('RGB').AsString);
          Checked := True;
        end;
        Next;
      end;
    end;
    if lvGFNO.Items.Count > 0 then
      tmpGFNO := lvGFNO.Items[0].Caption;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCPBFormatExForm.FillFNCard;
var vData: OleVariant;
    sCondition: string;
    sErrorMsg: WideString;
    i: Integer;
    GFNOStr: string;
begin
  GFNOStr := '';
  for i :=0 to lvGFNO.Items.Count - 1 do
    if lvGFNO.Items[i].Checked then
       GFNOStr := GFNOStr + lvGFNO.Items[i].Caption + '+';

  if Trim(GFNOStr) = '' then Exit;
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    sCondition := QuotedStr(GFNOStr)+','+QuotedStr(Login.CurrentDepartment);
    FNMServerObj.GetQueryData(vData,'CPBGetFormatCard',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TempClientDataSet.Data := vData;
    lvFNCard.Clear;
    with TempClientDataSet do
    begin
      First;
      while not Eof do
      begin
        with lvFNCard.Items.Add do
        begin
          Caption := FieldByName('FN_Card').AsString;
          SubItems.Add(FieldByName('Quantity').AsString);
          SubItems.Add(FieldByName('White').AsString);
          SubItems.Add(FieldByName('One_Minute').AsString);
          SubItems.Add(FieldByName('GF_NO').AsString);
          Checked := True;
        end;
        Next;
      end;
    end;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

function TCPBFormatExForm.FillChemicalGroup(GF_NO: string):string;
var vData: OleVariant;
    sCondition: string;
    sErrorMsg: WideString;
begin
  Result := ''; 
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    sCondition := QuotedStr(GF_NO)+','+QuotedStr(Login.CurrentDepartment)+',' + IntToStr(iType);
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

procedure TCPBFormatExForm.GetRecipeHdrInfo(Recipe_NO: string);
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
    edtRecipeNO.Text := TempClientDataSet.FieldByName('Recipe_NO').AsString;
    edtPatternID.Text := TempClientDataSet.FieldByName('Pattern_ID').AsString;
    edtLBNO.Text := TempClientDataSet.FieldByName('LB_NO').AsString;
    edtPatternName.Text := TempClientDataSet.FieldByName('Pattern_Name').AsString;
    edtStyleName.Text := TempClientDataSet.FieldByName('Style_Name').AsString;
    edtFabColorName.Text := TempClientDataSet.FieldByName('Fab_Color_Name').AsString;
    TGlobal.SetComboBoxValue(cbShade, TempClientDataSet.FieldByName('Shade').AsString);
    edtCPBGFNO.Text := TempClientDataSet.FieldByName('GF_NO').AsString;
    edtQuantity.Text := TempClientDataSet.FieldByName('Quantity').AsString;
    edtFNColorCode.Text := TempClientDataSet.FieldByName('Fn_Color_Code').AsString;
    lblFNColorCode.Caption := TempClientDataSet.FieldByName('Fn_Color_Code').AsString;
    plShowColor.Color := TempClientDataSet.FieldByName('RGB').AsInteger;
    TempClientDataSet.Data := vData[1];
    FillItemsFromDataSet(TempClientDataSet, 'Item_Name', 'Item_Value', '', '=', vlePDParam.Strings);
    btnSave.Enabled := True;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

function TCPBFormatExForm.GetRecipeDtlInfo(GF_NO: string; Chemical_Group: string): string;
var vData: OleVariant;
    sCondition: string;
    sErrorMsg: WideString;
begin
  lvFNCard.Items.Clear;
  edtRecipeNO.Clear;
  edtPatternID.Clear;
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
  btnSave.Enabled := False;
  Result := '';
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    sCondition := QuotedStr(GF_NO)+','+QuotedStr(Chemical_Group)+','+QuotedStr(Login.CurrentDepartment)+',' + IntToStr(iType);
    FNMServerObj.GetQueryData(vData,'CPBGetRecipeDtl',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TempClientDataSet.Data := vData;
    FillItemsFromDataSet(TempClientDataSet, 'Chemical_Name', 'Unit_QTY', 'Chemical_ID', '=', vleChemicallist.Strings);
    if TempClientDataSet.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有相关信息,请检查你的查询条件!',mtInformation);
      Exit;
    end;
    Result := TempClientDataSet.FieldByName('Recipe_NO').AsString;
   //历史配方明细
    if iType = 4 then
    begin
      cdsCPBRecipeDtl.Data := vData;
      GridDecorator.BindCxViewWithDataSource(cxGridTVCPBDtl, dsCPBRecipeDtl,True);
      GridDecorator.HideFields(cxGridTVCPBDtl,['Recipe_NO','Chemical_ID','Unit_QTY']);
    end;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCPBFormatExForm.UpdateActions;
begin
  inherited;
  btnPrint.Enabled := Trim(cbbHistoryRecipe.Text) <> '';
  btnDelete.Enabled := Trim(edtDeleteNO.Text) <> '';
end;

procedure TCPBFormatExForm.FormCreate(Sender: TObject);
begin
  inherited;
  tmpGFNO := '';
  btnCalc.Glyph.LoadFromResourceName(HInstance, RES_CALCULATE);
  btnQuery.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnAdd.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnUp.Glyph.LoadFromResourceName(HInstance, RES_UP);
  btnDown.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnDel.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btnDelete.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnExit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btnPrint.Glyph.LoadFromResourceName(HInstance, RES_PRINT);
  PageControl1.ActivePageIndex := 0;
  cbbChemicalName.Align := alClient;
  gbHistory.Align := alClient;
  gbFNCard.Align := alClient;
  FillItemsFromDataSet(Dictionary.cds_ChemicalList, 'Chemical_Short_Name', '', 'Chemical_ID', '', cbbChemicalName.Items);
  FillTreeItemsFromDataSetByClassField(Dictionary.cds_CPBChemical,'Chemical_Name', 'Chemical_Type','Chemical_ID', '', tvChemical.Items);
  cbShade.Items.Text := Dictionary.GetItemList('CPB色级',Login.CurrentDepartment,'');
  FillItemsFromDataSet(Dictionary.cds_CPBChemicalGroup, 'Group_Name', '', '', '', cbChemicalGroup.Items);
  cbChemicalGroup.Items.Insert(0,'');
  TControl(btnPrint).Align := alBottom;
  TControl(cbbHistoryRecipe).Align := alClient;
end;

procedure TCPBFormatExForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCPBFormatExForm.FormDestroy(Sender: TObject);
begin
  inherited;
  CPBFormatExForm := nil;
  CPBSampleExForm := nil;
  CPBBulkExForm := nil;
end;

procedure TCPBFormatExForm.btnAddClick(Sender: TObject);
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

procedure TCPBFormatExForm.btnDelClick(Sender: TObject);
begin
  inherited;
  if vleChemicallist.Strings.Text <> '' then
    vleChemicallist.DeleteRow(vleChemicallist.Row);
end;

procedure TCPBFormatExForm.tvChemicalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    btnAdd.Click;
end;

procedure TCPBFormatExForm.btnDeleteClick(Sender: TObject);
begin
  inherited;
  DeleteRecipeInfo;
end;

procedure TCPBFormatExForm.btnSaveClick(Sender: TObject);
begin
  SaveFormatInfo;
end;


procedure TCPBFormatExForm.DeleteRecipeInfo;
var
  sCondition, sErrorMsg: WideString;
begin
  inherited;
  if (edtDeleteNO.Text ='')then Exit;
  if IDNO = Application.MessageBox('是否删除当前配方号？', '提示', MB_YESNO + MB_ICONQUESTION) then exit;
  sCondition := QuotedStr(edtDeleteNO.Text)+','+ QuotedStr(Login.CurrentDepartment)+','+QuotedStr(Login.LoginID);
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    FNMServerObj.SaveDataBySQL('CPBDeleteRecipe',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    edtDeleteNO.Text := '';
    btnDelete.Enabled := False;
    TMsgDialog.ShowMsgDialog('删除数据成功',mtInformation);
  finally
    ShowMsg('', crDefault);
  end;  
end;

procedure TCPBFormatExForm.SaveFormatInfo;
var
  Recipe_NO,sCondition, sErrorMsg: WideString;
  i : Integer;
  Ppo_Type,GFNOStr,FNCardStr,ChemicalStr, UnitQtyStr,ItemNameStr,ItemValueStr: string;
begin
  if vleChemicallist.RowCount<2 then Exit;
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
  GFNOStr := '';
  FNCardStr := '';
  Ppo_Type := '';
  for i :=0 to lvGFNO.Items.Count - 1 do
    if lvGFNO.Items[i].Checked then
       GFNOStr := GFNOStr + lvGFNO.Items[i].Caption + '+';
  if length(GFNOStr) <= 1 then
  begin
    TMsgDialog.ShowMsgDialog('先选择复版的品名',mtInformation);
    Exit;
  end;

  if iType = 4 then  // 小样复板
  begin
    Ppo_Type := '小样复板';
    FNCardStr := '';
  end else
  begin
    Ppo_Type := '大货复板';
    for i :=0 to lvFNCard.Items.Count - 1 do
      if lvFNCard.Items[i].Checked then
         FNCardStr := FNCardStr + lvFNCard.Items[i].Caption + '+';
    if length(FNCardStr)<=1 then
    begin
      TMsgDialog.ShowMsgDialog('大货复版时请先选择卡号',mtInformation);
      Exit;
    end
  end;
  sCondition := QuotedStr(edtRecipeNO.Text)+',' + QuotedStr(edtPatternID.Text)+',' + QuotedStr(edtLBNO.Text)+','+
                QuotedStr(edtFabColorName.Text)+',' +QuotedStr(cbShade.Text)+',' +QuotedStr(GFNOStr)+',' +
                QuotedStr(ChemicalStr)+','+  QuotedStr(UnitQtyStr)+','
                +QuotedStr(ItemNameStr)+','+ QuotedStr(ItemValueStr)+','
                +QuotedStr(FNCardStr)+','+ QuotedStr(Ppo_Type)+','+ QuotedStr(edtFNColorCode.Text)+','+
                QuotedStr(Login.CurrentDepartment)+','+QuotedStr(Login.LoginID);
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    FNMServerObj.SaveDataBySQLEx('CPBFormatRecipeEx',sCondition,Recipe_NO,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    edtNewRecipe.Text := Recipe_NO;
    edtFabColorCode.Clear;
    lvGFNO.Clear;
    lvFNCard.Clear;
    if iType = 5 then   //大货复板时只复板一次
    begin
      btnSave.Enabled := False;
      if cbbHistoryRecipe.Items.IndexOf(Recipe_NO) = -1 then
        cbbHistoryRecipe.Items.Add(Recipe_NO);
      if not Assigned(CPBReport) then
        CPBReport := TCPBReport.Create(nil);
      CPBReport.PreviewReport(Recipe_NO,True);
    end;
    TMsgDialog.ShowMsgDialog('保存数据成功',mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBFormatExForm.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCPBFormatExForm.btnQueryClick(Sender: TObject);
var
  ChemicalGroup,RecipeNO: string;
begin
  if edtFabColorCode.Text='' then Exit;
  FillGFNO(edtFabColorCode.Text);
  ChemicalGroup := FillChemicalGroup(tmpGFNO);
  if ChemicalGroup = '' then Exit;
  if iType = 5 then
    FillFNCard;
  RecipeNO := GetRecipeDtlInfo(tmpGFNO,ChemicalGroup);
  if RecipeNO <> '' then
    GetRecipeHdrInfo(RecipeNO);
end;

procedure TCPBFormatExForm.cbAllClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i := 0 to lvFNCard.Items.Count -1 do
    lvFNCard.Items[i].Checked := cbAll.Checked;
end;

procedure TCPBFormatExForm.cbbChemicalNameDblClick(Sender: TObject);
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

procedure TCPBFormatExForm.edtFabColorCodeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key =13 then
    btnQuery.Click;
end;

procedure TCPBFormatExForm.cxgdTVTaskCustomDrawCell(
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

procedure TCPBFormatExForm.cbChemicalGroupChange(Sender: TObject);
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

procedure TCPBFormatExForm.btnUpClick(Sender: TObject);
begin
  inherited;
  if (vleChemicallist.Strings.Text <>'') and (vleChemicallist.Row >1) then
     vleChemicallist.Strings.Exchange(vleChemicallist.Row-1,vleChemicallist.Row-2);
end;

procedure TCPBFormatExForm.btnDownClick(Sender: TObject);
begin
  inherited;
  if (vleChemicallist.Strings.Text <>'') and (vleChemicallist.Row <vleChemicallist.RowCount-1) then
     vleChemicallist.Strings.Exchange(vleChemicallist.Row-1,vleChemicallist.Row);
end;

procedure TCPBFormatExForm.lvChemicalGroupDblClick(Sender: TObject);
var
  ChemicalGroup,RecipeNO: string;
begin
  inherited;
  if tmpGFNO='' then Exit;
  if lvChemicalGroup.Selected = nil then Exit;
  ChemicalGroup := lvChemicalGroup.Selected.Caption;
  RecipeNO := GetRecipeDtlInfo(tmpGFNO,ChemicalGroup);
  if RecipeNO <> '' then
    GetRecipeHdrInfo(RecipeNO);
end;

procedure TCPBFormatExForm.vleChemicallistValidate(Sender: TObject; ACol,
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

procedure TCPBFormatExForm.btnCalcClick(Sender: TObject);
begin
  inherited;
  CalcAuxiliaries;
end;

procedure TCPBFormatExForm.btnPrintClick(Sender: TObject);
var Recipe_NO: string;
begin
  inherited;
  Recipe_NO := cbbHistoryRecipe.Text;
  if not Assigned(CPBReport) then
    CPBReport := TCPBReport.Create(nil);
  CPBReport.PreviewReport(Recipe_NO,True);
end;

procedure TCPBFormatExForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  FillFNCard;
end;

end.
