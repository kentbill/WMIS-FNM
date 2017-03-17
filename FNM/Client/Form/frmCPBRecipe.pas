unit frmCPBRecipe;
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
  cxData, cxDataStorage, cxDBData, DBCtrls, Mask, frmBase, DBGrids, Menus;

type
  TCPBRecipeForm = class(TBaseForm)
    pnlTop: TPanel;
    grp2: TGroupBox;
    gbChemicalList: TGroupBox;
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
    gbLeft: TGroupBox;
    vleChemicallist: TValueListEditor;
    gbClient: TGroupBox;
    cxGrid1: TcxGrid;
    cxGridTVCPBDtl: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    gbRight: TGroupBox;
    Panel1: TPanel;
    Label2: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    lblFNColorCode: TLabel;
    edtRecipeNO: TEdit;
    edtQuantity: TEdit;
    edtFNColorCode: TEdit;
    edtCustomer: TEdit;
    plShowColor: TPanel;
    cxSplitter4: TcxSplitter;
    btnDown: TSpeedButton;
    btnUp: TSpeedButton;
    lvChemicalGroup: TListView;
    Label3: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtLB_NO: TEdit;
    edtPatternName: TEdit;
    edtStyleName: TEdit;
    edtFabColorName: TEdit;
    edtPatternID: TEdit;
    cbExport: TCheckBox;
    pnl1: TPanel;
    lbLBNO: TLabel;
    Label1: TLabel;
    btnQuery: TSpeedButton;
    btnRefresh: TSpeedButton;
    edtLBNO: TEdit;
    edtFabColorCode: TEdit;
    btnCalc: TSpeedButton;
    lbl1: TLabel;
    lbl2: TLabel;
    edtFinishMethod: TEdit;
    edtLaunchTime: TEdit;
    lbl3: TLabel;
    edtPPOType: TEdit;
    vlePDParam: TValueListEditor;
    btnAdd: TSpeedButton;
    btnGroup: TSpeedButton;
    cbChemicalGroup: TComboBox;
    cbViewChemical: TCheckBox;
    btnDel: TSpeedButton;
    Label7: TLabel;
    Label12: TLabel;
    cbGFNO: TComboBox;
    cbbRecipeType: TComboBox;
    btnSave: TBitBtn;
    btnExit: TBitBtn;
    popMChemical: TPopupMenu;
    popMChemicalN1: TMenuItem;
    popMChemicalN2: TMenuItem;
    Label4: TLabel;
    lbl4: TLabel;
    cbbOperator: TComboBox;
    cbbToner: TComboBox;
    Label5: TLabel;
    edtConstruction: TEdit;
    Panel2: TPanel;
    edtOperator: TEdit;
    cxGridTVCPBDtlDBColumn1: TcxGridDBColumn;
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
    procedure edtFabColorCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtLBNOKeyPress(Sender: TObject; var Key: Char);
    procedure cxgdTVTaskCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure lvChemicalGroupDblClick(Sender: TObject);
    procedure btnCalcClick(Sender: TObject);
    procedure edtFabColorCodeChange(Sender: TObject);
    procedure vlePDParamGetPickList(Sender: TObject; const KeyName: String;
      Values: TStrings);
    procedure vleChemicallistKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnGroupClick(Sender: TObject);
    procedure cbGFNOChange(Sender: TObject);
    procedure vleChemicallistSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure vleChemicallistDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure cxGridTVCPBDtlCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cbViewChemicalClick(Sender: TObject);
    procedure cbbFabricTypeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbGFNOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbbOperatorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbbTonerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbbRecipeTypeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vlePDParamStringsChange(Sender: TObject);
    procedure cbGFNODropDown(Sender: TObject);
    procedure popMChemicalN1Click(Sender: TObject);
    procedure popMChemicalN2Click(Sender: TObject);
    procedure cxGridTVCPBDtlDblClick(Sender: TObject);
    procedure cbbOperatorChange(Sender: TObject);
    procedure cxGridTVCPBDtlCustomDrawIndicatorCell(
      Sender: TcxGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxCustomGridIndicatorItemViewInfo; var ADone: Boolean);
    procedure cxGridTVCPBDtlCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { private declarations }
    UpdateItemNO: string;
    Ppo_Type : string;
    procedure ResetVle;
    //将所有控件的数据清空
    procedure SetBtnState;
    procedure ResetValue;
    function CheckChemmicalData(var AChemicalStr: string; var AUnitQtyStr: string): Boolean;
    function FillChemicalGroup(Param_NO: string):string;
    procedure CalcAuxiliaries;
    procedure GetRecipeHdrInfo;
    procedure GetRecipeDtlInfo(Param_NO: string; Chemical_Group: string);
    procedure xriteRecipe(Item_NO: string);
    function CheckChemicalValue(sType:String):Boolean;
    procedure SaveRecipeInfo;
    //--Content:手工增加化料，主要是878	CPB助剂	水玻璃（37-40Be) 879	CPB助剂	NaOH 50%    Reason:    Added By Danny at 2015-02-04 10:55:39:675
    procedure AddChemical(Chemical_ID:Integer);
    //--Content:前后配方比例相差±10倍，保存时系统提示确认；    Reason:    Added By Danny at 2015-02-04 11:39:40:562
    function CheckChemicalQty:Boolean;
  protected
    procedure UpdateActions; override;  
  public
    { Public declarations }
    OldRaw_No:string;
    //获取品名规格
    function GetConstruction(GF_NO:string):string;
  end;

var
  CPBRecipeForm: TCPBRecipeForm;
  oldStrings:string;

implementation

uses Math, StrUtils, ServerDllPub, uFNMArtInfo,uFNMResource ,
    uDictionary, uShowMessage, uLogin, UAppOption, uGlobal, UGridDecorator,
  frmCPBChemicalGroup;

{$R *.dfm}
function TCPBRecipeForm.CheckChemmicalData(var AChemicalStr: string; var AUnitQtyStr: string): Boolean;
var i: Integer;
begin
  Result := False;
  if vleChemicallist.Strings.Text <> '' then
  begin
    //cuijf 2009-12-25 根据品名选择组织规格
    if (cbGFNO.Text ='') then
    begin
      TMsgDialog.ShowMsgDialog('请选择组织规格！',mtInformation);
      cbGFNO.SetFocus;
      Exit;
    end;
    if (edtOperator.Text ='') then
    begin
      TMsgDialog.ShowMsgDialog('请选择打板员！',mtInformation);
      cbbOperator.SetFocus;
      Exit;
    end;  
    if (cbbToner.Text ='') then
    begin
      TMsgDialog.ShowMsgDialog('请选择调色师！',mtInformation);
      cbbToner.SetFocus;
      Exit;
    end;
    if (cbbRecipeType.Text ='') then
    begin
      TMsgDialog.ShowMsgDialog('请选择打板类型！',mtInformation);
      cbbRecipeType.SetFocus;
      Exit;
    end;
    {
    if (StrToInt(edtQuantity.Text) mod 30)<>0 then
    begin
      TMsgDialog.ShowMsgDialog('码长需为30的整数倍！',mtInformation);
      cbbOperator.SetFocus;
      Exit;
    end;
     }
    //2009-11-24 保存前检查染料用量不能为0
    if not CheckChemicalValue('CheckData') then
    begin
      Result := False;
      Exit;
    end;
    
    for i := 1 to vleChemicallist.RowCount - 1 do
    begin
      AChemicalStr := AChemicalStr + IntTostr(Integer(vleChemicallist.Strings.Objects[i-1])) + '+';
      AUnitQtyStr := AUnitQtyStr + vleChemicallist.Values[vleChemicallist.Keys[i]] + '+';
    end;
  end;
  Result := (AChemicalStr<>'') and (AUnitQtyStr<>'');
end;

procedure TCPBRecipeForm.CalcAuxiliaries;
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
    ResetVle;
    FillItemsFromDataSet(TempClientDataSet, 'Chemical_Name', 'Unit_QTY', 'Chemical_ID', '=', vleChemicallist.Strings);
    TMsgDialog.ShowMsgDialog('计算助剂成功！',mtInformation);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;    

function TCPBRecipeForm.FillChemicalGroup(Param_NO: string): string;
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
    if TempClientDataSet.IsEmpty then
      Exit;
      
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
    lvChemicalGroup.Items[0].Selected := lvChemicalGroup.Items.Count > 1;
    if lvChemicalGroup.Visible then
      lvChemicalGroup.SetFocus;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCPBRecipeForm.GetRecipeHdrInfo;
var vData: OleVariant;
    sCondition, sErrorMsg: WideString;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    sCondition := QuotedStr(edtLBNO.Text)+','+ QuotedStr(edtFabColorCode.Text)+','+QuotedStr('')+','+QuotedStr(login.CurrentDepartment)+',0';
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
    lblFNColorCode.Caption := edtFabColorCode.Text;
    edtRecipeNO.Text := '';
    edtRecipeNO.Text := TempClientDataSet.FieldByName('Recipe_NO').AsString;
    edtPatternID.Text := TempClientDataSet.FieldByName('Pattern_ID').AsString;
    edtCustomer.Text := TempClientDataSet.FieldByName('Customer').AsString;
    edtLBNO.Text := TempClientDataSet.FieldByName('LB_NO').AsString;
    edtLB_NO.Text := TempClientDataSet.FieldByName('LB_NO').AsString;
    edtPatternName.Text := TempClientDataSet.FieldByName('Pattern_Name').AsString;
    edtStyleName.Text := TempClientDataSet.FieldByName('Style_Name').AsString;
    edtFabColorName.Text := TempClientDataSet.FieldByName('Fab_Color_Name').AsString;
    edtConstruction.Text := TempClientDataSet.FieldByName('Construction').AsString;
    edtFinishMethod.Text := TempClientDataSet.FieldByName('Finish_Method').AsString;
    edtLaunchTime.Text := TempClientDataSet.FieldByName('Launch_Time').AsString;
    edtPPOType.Text := TempClientDataSet.FieldByName('PPO_Type').AsString;
    Ppo_Type := TempClientDataSet.FieldByName('Ppo_Type').AsString;
    edtQuantity.Text := TempClientDataSet.FieldByName('Quantity').AsString;

    edtFNColorCode.Text := TempClientDataSet.FieldByName('FN_Color_Code').AsString;
    plShowColor.Color := TempClientDataSet.FieldByName('RGB').AsInteger;
    TGlobal.SetComboBoxValue(cbGFNO, TempClientDataSet.FieldByName('GF_NO').AsString);

    TempClientDataSet.Data := vData[1];

    {
    //--Content:打板样式改为固色方法    Reason:    Added By Danny at 2015-02-05 15:08:23:363
      TempClientDataSet.First;
      while not TempClientDataSet.Eof do
      begin
        {
        if TempClientDataSet.FieldByName('Item_Name').AsString='打板样式' then
        begin
          Delete;
          TempClientDataSet.Edit;
          TempClientDataSet.FieldByName('Item_Name').Value:='固色方法';
          TempClientDataSet.Post;
        end;

        TempClientDataSet.Next;
      end;
      }
      TempClientDataSet.EmptyDataSet;
      TempClientDataSet.Append;
      TempClientDataSet.FieldByName('Item_Name').Value:= '固色方法';
      TempClientDataSet.FieldByName('Item_Value').Value:= '烘箱法';
      TempClientDataSet.Append;
      TempClientDataSet.FieldByName('Item_Name').Value:= '堆置|时间(h)';
      TempClientDataSet.FieldByName('Item_Value').Value:= '2H';
      TempClientDataSet.Post;
      TempClientDataSet.First;

    FillItemsFromDataSet(TempClientDataSet, 'Item_Name', 'Item_Value', '', '=', vlePDParam.Strings);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCPBRecipeForm.GetRecipeDtlInfo(Param_NO: string; Chemical_Group: string);
var
  vData: OleVariant;
  sCondition: string;
  sErrorMsg: WideString;
  iIndex,i,ChemicalCount:Integer;
  sItemValue: string;

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
    ResetVle;

    FillItemsFromDataSet(TempClientDataSet, 'Chemical_Name', 'Unit_QTY', 'Chemical_ID', '=', vleChemicallist.Strings);

    //删除用量为0的染料不显示
    {
    ChemicalCount :=vleChemicallist.Strings.Count;
    for i := ChemicalCount downto 1 do
    begin
      sItemValue:= vleChemicallist.Values[vleChemicallist.Keys[i]];
      if StrToFloatDef(sItemValue,0) = 0 then
         vleChemicallist.Strings.Delete(i-1);
    end;
    }

    //
    cdsCPBRecipeDtl.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxGridTVCPBDtl, dsCPBRecipeDtl,True);
    //add by dengshch
    GridDecorator.HideFields(cxGridTVCPBDtl,['Chemical_ID', 'Chemical_Type', 'Unit_QTY','seq_no','seq_no1','Chemical_Name','Recipe_NO']);
    cxGridTVCPBDtl.OptionsView.IndicatorWidth:=180;
    //


    //修正配方
    xriteRecipe(edtFabColorCode.Text);

    //cuijf 后台默认的染料组合的第一个
   iIndex:= 1;
    if Chemical_Group<>'' then
      iIndex:= cbChemicalGroup.Items.IndexOf(Chemical_Group);
    cbChemicalGroup.ItemIndex := iIndex;
    if Chemical_Group='' then
      cbChemicalGroup.OnChange(cbChemicalGroup);

  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCPBRecipeForm.FormCreate(Sender: TObject);
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
  cbChemicalGroup.Sorted:= True;
  tvChemical.FullExpand;
{
  with Dictionary.cds_CPBStock do
  begin
    First;
    while not Eof do
    begin
      cbGFNO.Items.Add(FieldByName('Construction').AsString);
      Next;
    end;
  end;
 }
  FillItemsFromDataSet(Dictionary.cds_CPBStock, 'GF_NO', '', '', '', cbGFNO.Items);
 // cbbFabricType.Items.Text :=  Dictionary.GetItemList('CPB布种',Login.CurrentDepartment,'');
  cbbOperator.Items.Text := Dictionary.GetItemList('CPB打板员',Login.CurrentDepartment,'');
  cbbToner.Items.Text := Dictionary.GetItemList('CPB调色师',Login.CurrentDepartment,'');
  cbbRecipeType.Items.Text := Dictionary.GetItemList('CPB打板类型',Login.CurrentDepartment,'');
  if cbbOperator.Items.Count > 0 then
    cbbOperator.ItemIndex := 0;
  if cbbToner.Items.Count > 0 then
    cbbToner.ItemIndex := 0;
  if cbbRecipeType.Items.Count > 0 then
    cbbRecipeType.ItemIndex := 0;
//  edtOperator.Text:= cbbOperator.Text;

end;

procedure TCPBRecipeForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TCPBRecipeForm.FormDestroy(Sender: TObject);
begin
  CPBRecipeForm:=nil;
end;

procedure TCPBRecipeForm.btnSaveClick(Sender: TObject);
begin
  SaveRecipeInfo;
end;

procedure TCPBRecipeForm.SaveRecipeInfo;
var
  Recipe_NO,sCondition, sErrorMsg: WideString;
  i : Integer;
  ChemicalStr, UnitQtyStr,ItemNameStr,ItemValueStr: string;
begin
  if edtLBNO.Text = '' then Exit;
  if edtFabColorCode.Text = '' then Exit;
  if edtPatternID.Text = '' then
  begin
    TMsgDialog.ShowMsgDialog('请刷新数据!',mtInformation);
    Exit;
  end;

  ChemicalStr := '';
  UnitQtyStr := '';
  if not CheckChemmicalData(ChemicalStr,UnitQtyStr) then Exit;
  if not CheckChemicalValue('CheckZJ') then Exit;

  //--Content:前后配方比例相差±10倍，保存时系统提示确认；    Reason:    Added By Danny at 2015-02-04 12:48:40:064
  if not CheckChemicalQty then Exit;
  
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

  //cuijf 2009-11-19 修改为必须选择染料组合
  if cbChemicalGroup.Text='' then
  begin
    cbChemicalGroup.SetFocus;
    TMsgDialog.ShowMsgDialog('染料组合不能为空，请选择染料组合!',mtInformation);
    Exit;
  end;

  sCondition := QuotedStr('')+',' + QuotedStr(edtPatternID.Text)+','+
                QuotedStr(edtLBNO.Text)+','+ QuotedStr(edtFabColorName.Text)+',' +
                QuotedStr(cbGFNO.Text)+',' + QuotedStr(edtQuantity.Text)+',' +
                QuotedStr(ChemicalStr)+','+  QuotedStr(UnitQtyStr)+','+
                QuotedStr(ItemNameStr)+','+ QuotedStr(ItemValueStr)+','+
                QuotedStr(Ppo_Type)+','+ QuotedStr(edtFNColorCode.Text)+','+
                QuotedStr(Login.CurrentDepartment)+','+
                //QuotedStr(Login.LoginID+ '-'+ edtOperator.Text)+','+
                QuotedStr(edtOperator.Text)+','+
                QuotedStr(cbbToner.Text)+ ','+  QuotedStr(cbbRecipeType.Text)+ ','+ 
                QuotedStr(cbChemicalGroup.Text)+','+ QuotedStr(UpdateItemNO)+','+
                IfThen(cbExport.Checked,'1','0');
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    FNMServerObj.SaveDataBySQLEx('CPBSaveRecipe',sCondition,Recipe_NO,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    edtRecipeNO.Text := Recipe_NO;

    if cdsTask.Active and (not cdsTask.IsEmpty) then
    begin
      while cdsTask.Locate('Pattern_ID', edtPatternID.Text, []) do
        cdsTask.Delete;
    end;
    if cbExport.Checked then
      TGlobal.GenerateRCPFile(Recipe_NO);
    //2009-11-24 保存后将组合中的染料用量设置为0
    CheckChemicalValue('ResetData');
    TMsgDialog.ShowMsgDialog('保存数据成功',mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBRecipeForm.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TCPBRecipeForm.vleChemicallistValidate(Sender: TObject; ACol,
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

procedure TCPBRecipeForm.btnQueryClick(Sender: TObject);
var
  ChemicalGroup: string;
begin
  edtOperator.Clear;
  cbbRecipeType.ItemIndex:= 0;
  if cbbToner.ItemIndex < 0 then cbbToner.ItemIndex := 0;
  OldRaw_No:='';
  UpdateItemNO := '';
  if (edtFabColorCode.Text = '') then
  begin
    ResetValue;
    Exit;
  end;
  //2009-12-23 复位布种过滤
  {
  if cbbFabricType.ItemIndex>0 then
  begin
    cbbFabricType.ItemIndex := 0;
    cbbFabricTypeChange(cbbFabricType);
  end;
  }
  if lvChemicalGroup.Items.Count>0 then
    lvChemicalGroup.Items.Clear;

  GetRecipeHdrInfo;
  if edtFNColorCode.Text<>'' then
  begin
    ChemicalGroup := FillChemicalGroup(edtFabColorCode.Text);
    GetRecipeDtlInfo(edtFabColorCode.Text,ChemicalGroup);
  end;
end;

procedure TCPBRecipeForm.btnAddClick(Sender: TObject);
var
  Chemical_ID: Integer;
begin
  inherited;
  if edtPatternID.Text = '' then Exit;
  if (tvChemical.Selected = nil) or (tvChemical.Selected.Level = 0) then exit;
  Chemical_ID:=Integer(tvChemical.Selected.Data);
  if (Chemical_ID=878) or (Chemical_ID=879) then
    AddChemical(Chemical_ID)
  else
  begin
    if vleChemicallist.Strings.IndexOfObject(TObject(Chemical_ID)) = -1 then
       if vleChemicallist.RowCount = 2 then
         vleChemicallist.Strings.AddObject(tvChemical.Selected.Text + '=0.00', TObject(Chemical_ID))
       else
         vleChemicallist.Strings.InsertObject(vleChemicallist.Row, tvChemical.Selected.Text + '=0.00', TObject(Chemical_ID));
  end;
end;

procedure TCPBRecipeForm.btnDelClick(Sender: TObject);
var
  iRow:Integer;
  Chemical_ID: String;
begin
  inherited;
  if vleChemicallist.Strings.Text <> '' then
  begin
    iRow := vleChemicallist.Row;
    Chemical_ID := IntTostr(Integer(vleChemicallist.Strings.Objects[iRow-1]));
    //2010-8-17助剂不能删除
    if Dictionary.cds_CPBChemical.Locate('Chemical_ID;Chemical_Type',VarArrayOf([Chemical_ID, 'CPB助剂']), []) then
    begin
      if TMsgDialog.ShowMsgDialog('是否要删除该助剂?',mtConfirmation, [mebYes, mebCancel], mebYes)= mrCancel then
         Exit;
    end;
    vleChemicallist.DeleteRow(vleChemicallist.Row);
  end
end;

procedure TCPBRecipeForm.btnRefreshClick(Sender: TObject);
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
begin
  inherited;
  sCondition := QuotedStr(Login.CurrentDepartment)+',0';
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
  cxgdTVTask.GetColumnByFieldName('Pattern_ID').Visible := False;
  cxgdTVTask.DataController.Groups.FullExpand;
end;

procedure TCPBRecipeForm.cbChemicalGroupChange(Sender: TObject);
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

procedure TCPBRecipeForm.cxgdTVTaskDblClick(Sender: TObject);
begin
  inherited;
  if not cdsTask.Active then Exit;
  edtLBNO.Text := cdsTask.FieldByName('LB_NO').AsString;
  edtFabColorCode.Text := cdsTask.FieldByName('Fab_Color_Code').AsString;
  Ppo_Type := cdsTask.FieldByName('Ppo_Type').AsString;
  btnQuery.Click;
end;

procedure TCPBRecipeForm.tvChemicalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    btnAdd.Click;
end;

procedure TCPBRecipeForm.cbbChemicalNameDblClick(Sender: TObject);
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

procedure TCPBRecipeForm.edtFabColorCodeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key =  13 then
   btnQuery.Click;
end;

procedure TCPBRecipeForm.edtLBNOKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
   edtFabColorCode.SetFocus;
end;

procedure TCPBRecipeForm.cxgdTVTaskCustomDrawCell(
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

procedure TCPBRecipeForm.btnUpClick(Sender: TObject);
begin
  inherited;
  if (vleChemicallist.Strings.Text <>'') and (vleChemicallist.Row >1) then
   begin
     vleChemicallist.Strings.Exchange(vleChemicallist.Row-1,vleChemicallist.Row-2);
     SendMessage(vleChemicallist.Handle, WM_KEYDOWN, VK_UP, 0);
  end;
end;

procedure TCPBRecipeForm.btnDownClick(Sender: TObject);
begin
  inherited;
  if (vleChemicallist.Strings.Text <>'') and (vleChemicallist.Row <vleChemicallist.RowCount-1) then
  begin
    vleChemicallist.Strings.Exchange(vleChemicallist.Row-1,vleChemicallist.Row);
    SendMessage(vleChemicallist.Handle, WM_KEYDOWN, VK_DOWN, 0);
  end;
end;

procedure TCPBRecipeForm.lvChemicalGroupDblClick(Sender: TObject);
var
  ChemicalGroup: string;
begin
  if lvChemicalGroup.Selected = nil then Exit;
  ChemicalGroup := lvChemicalGroup.Selected.Caption;
  GetRecipeDtlInfo(edtFabColorCode.Text,ChemicalGroup);
end;

procedure TCPBRecipeForm.btnCalcClick(Sender: TObject);
begin
  CalcAuxiliaries;
end;

procedure TCPBRecipeForm.edtFabColorCodeChange(Sender: TObject);
begin
  inherited;
  edtPatternID.Text := '';
end;

procedure TCPBRecipeForm.vlePDParamGetPickList(Sender: TObject;
  const KeyName: String; Values: TStrings);
  function GetKeyValue(strKeyName:String):string;
  var i:Word;
  begin
    Result:='';
    i:=vlePDParam.Strings.IndexOfObject(TObject(KeyName));
    if i>=0 then
      Result:=vlePDParam.Values[strKeyName];
  end;
begin
  inherited;
{
  if KeyName='打板样式' then
     Values.Text := '微波打板' + #13 + '堆置打板'+ #13 + '烘箱打板'
  else if KeyName='固色时间' then
     Values.Text := '18' + #13 + '24'
  else if KeyName='堆置|时间(h)' then
     Values.Text := '18' + #13 + '24'
  else if KeyName='水洗|皂洗剂(g/l)' then
     Values.Text := '0' + #13 + '1' + #13 + '2'
  else if KeyName='染色|车速(m/min)' then
     Values.Text := '30' + #13 + '40' + #13 + '50';
}
//  if (KeyName= '打板样式') or (KeyName='固色时间') or (KeyName='堆置|时间(h)')
//    or (KeyName= '水洗|皂洗剂(g/l)') or (KeyName= '染色|车速(m/min)') then


  //--Content:打板样式改为固色方法    Reason:    Added By Danny at 2015-02-05 15:08:23:363
  //if Values.Text= '' then
    //Values.Text := Dictionary.GetItemList('CPB'+KeyName,Login.CurrentDepartment,'');
  //新实现方法
  if Values.Text='' then
  begin
    if KeyName='固色方法' then
      Values.Text:='微波法'#13'烘箱法'#13'堆置法'
    else if (KeyName='堆置|时间(h)') and (GetKeyValue('固色方法')='堆置法') then
      Values.Text:='18H'#13'24H'
    else
      Values.Text := Dictionary.GetItemList('CPB'+KeyName,Login.CurrentDepartment,'');
  end;
end;

procedure TCPBRecipeForm.vleChemicallistKeyPress(Sender: TObject;
  var Key: Char);
var
  iRow:Integer;
begin
  inherited;
  if(Key=#13) then
  begin
    iRow := vleChemicallist.Row;
    vleChemicallist.Row := IfThen(iRow<vleChemicallist.RowCount-1,iRow+1, vleChemicallist.TopRow);
//    SendMessage(TWinControl(Sender).Handle, WM_KEYDOWN, VK_DOWN, 0);
  end;
end;

procedure TCPBRecipeForm.FormShow(Sender: TObject);
begin
  inherited;
  edtFabColorCode.SetFocus;
  cxSplitter1.CloseSplitter;
  //cxSplitter2.CloseSplitter;
end;

procedure TCPBRecipeForm.btnGroupClick(Sender: TObject);
var
  sGroupName:String;
begin
  inherited;
  sGroupName:= CPBChemicalGroupForm.SetModel;
  if sGroupName='' then Exit;
  cbChemicalGroup.ItemIndex := cbChemicalGroup.Items.IndexOf(sGroupName);
  cbChemicalGroup.OnChange(sender);
end;

procedure TCPBRecipeForm.SetBtnState;
begin
  btnAdd.Enabled := (edtFNColorCode.Text<>'');
  btnDel.Enabled := btnAdd.Enabled;
  btnGroup.Enabled := btnAdd.Enabled;
  cbChemicalGroup.Enabled := btnAdd.Enabled;
  btnCalc.Enabled := btnAdd.Enabled and (cbChemicalGroup.Text<>'');
  btnUp.Enabled := btnAdd.Enabled;
  btnDown.Enabled := btnAdd.Enabled;
  btnSave.Enabled := (edtFNColorCode.Text<>'');
  vlePDParam.Enabled := btnAdd.Enabled;
  edtQuantity.Enabled := btnAdd.Enabled;
  vleChemicallist.Enabled := btnAdd.Enabled;
  cbbOperator.Enabled:= btnAdd.Enabled;
  edtOperator.Enabled:= btnAdd.Enabled;
  cbGFNO.Enabled:= btnAdd.Enabled;
//  cbbFabricType.Enabled:= btnAdd.Enabled;
  cbbToner.Enabled:= btnAdd.Enabled;
  
  //cuijf 2009-12-24
  //lvChemicalGroup.Visible := lvChemicalGroup.Items.Count > 1;
//  if lvChemicalGroup.Visible then
//    cxSplitter2.OpenSplitter
//  else
//    cxSplitter2.CloseSplitter;
end;

procedure TCPBRecipeForm.UpdateActions;
begin
  inherited;
  SetBtnState;
end;

function TCPBRecipeForm.CheckChemicalValue(sType:String):Boolean;
var
  Chemical_ID, sItemValue: string;
  i, ChemicalCount:Integer;

begin
  inherited;
  Result := False;
  if cbChemicalGroup.Text = '' then
  begin
    TMsgDialog.ShowMsgDialog('组合不能为空!',mtInformation);
    cbChemicalGroup.SetFocus;
    Exit;
  end;
  
  ChemicalCount :=vleChemicallist.Strings.Count-1;
  if ChemicalCount<2 then
  begin
    TMsgDialog.ShowMsgDialog('化料太少!',mtInformation);
    Exit;
  end;

  for i := 1 to ChemicalCount do
  begin
    Chemical_ID := IntTostr(Integer(vleChemicallist.Strings.Objects[i-1]));
    sItemValue := vleChemicallist.Values[vleChemicallist.Keys[i]];
    if Dictionary.cds_CPBChemical.Locate('Chemical_ID;Chemical_Type',VarArrayOf([Chemical_ID, 'CPB染料']), []) then
    begin
      //保存前检查染料用量不能为0
      if sType= 'CheckData' then
      begin
        //2012-04-20为0也可以保存
        if StrToFloat(sItemValue)<0 then
        begin
          TMsgDialog.ShowMsgDialog('染料用量需大于或者等于0!',mtWarning);
          Exit;
        end;
      end
      //保存后将染料用量归零
      else if sType= 'ResetData' then
      begin
        vleChemicallist.Values[vleChemicallist.Keys[i]] := '0.0';
      end;
    end;
    
    if Dictionary.cds_CPBChemical.Locate('Chemical_ID;Chemical_Type',VarArrayOf([Chemical_ID, 'CPB助剂']), []) then
    begin
      //保存前检查染料用量不能为0
      if sType= 'CheckZJ' then
      begin
        if StrToFloat(sItemValue)<=0 then
        begin
          TMsgDialog.ShowMsgDialog('请计算助剂!',mtWarning);
          Exit;
        end;
      end;
    end;
  end;
  Result := True;
end;

procedure TCPBRecipeForm.cbGFNOChange(Sender: TObject);
begin
  edtConstruction.Text:=GetConstruction(cbGFNO.Text);
  Exit;
  with Dictionary.cds_CPBStock do
  begin
    if Locate('GF_NO',cbGFNO.Text,[]) then
      edtConstruction.Text :=  FieldByName('Construction').AsString
    else
      edtConstruction.Text :='';
  end;
end;

procedure TCPBRecipeForm.vleChemicallistSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  sChemicalID, sItemValue: string;
  iRowCount:Integer;
begin
  inherited;
    iRowCount:= vleChemicallist.RowCount;
    if iRowCount<4 then Exit;

    if (ARow<1) or (ARow>iRowCount) then Exit;
    if StrToFloat(vleChemicallist.Values[vleChemicallist.Keys[iRowCount-1]])>0 then Exit;

    sChemicalID := IntTostr(Integer(vleChemicallist.Strings.Objects[ARow-1]));
    sItemValue := vleChemicallist.Values[vleChemicallist.Keys[ARow]];
    //不是染料时提示计算染料
    if Dictionary.cds_CPBChemical.Locate('Chemical_ID;Chemical_Type',VarArrayOf([sChemicalID, 'CPB染料']), []) then Exit;
    btnCalc.Click;
end;

procedure TCPBRecipeForm.ResetVle;
begin
  vleChemicallist.OnSelectCell := nil;
  vleChemicallist.Strings.Clear;      
  vleChemicallist.OnSelectCell := vleChemicallistSelectCell;
end;

procedure TCPBRecipeForm.vleChemicallistDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  i,j:Integer;
  CellText,Chemical_ID:String;
begin
  try



    inherited;
    with Sender as TCustomDrawGrid do
    begin
      if vleChemicallist.RowCount>2 then
      begin
        for i := 1 to vleChemicallist.RowCount-1 do
        begin
          Chemical_ID := IntTostr(Integer(vleChemicallist.Strings.Objects[i-1]));
          if (Chemical_ID<>'') and (not Dictionary.cds_CPBChemical.Locate('Chemical_ID;Chemical_Type',VarArrayOf([Chemical_ID, 'CPB染料']), [])) then
          begin
            for j:=0 to 1 do
            begin
              Rect:= CellRect(j,i);
              Canvas.Brush.Color := clBtnFace;
              Canvas.FillRect(Rect);
              Canvas.Font.Color := clBlue;
              CellText := vleChemicallist.Cells[j, i];
              Canvas.TextRect(Rect, Rect.Left+2, Rect.Top+2, CellText);
            end;
          end;
        end;
      end;
    end;

  except
    on e:Exception do
      OutputDebugString(PChar(e.Message));
  end;
end;

{
procedure TCPBRecipeForm.cbbFabricTypeChange(Sender: TObject);
begin
  inherited;
  Dictionary.cds_CPBStock.Filter := '';
  Dictionary.cds_CPBStock.Filtered := False;
  if cbbFabricType.Text<> '' then
  begin
    Dictionary.cds_CPBStock.Filtered := False;
    Dictionary.cds_CPBStock.Filter := 'Fabric_Type= '''+ cbbFabricType.Text+ '''';
    Dictionary.cds_CPBStock.Filtered := True;
  end;
  FillItemsFromDataSet(Dictionary.cds_CPBStock, 'GF_NO', '', '', '', cbGFNO.Items);
  if cbGFNO.Items.Count > 0 then
   cbGFNO.ItemIndex := 0;
end;
}

procedure TCPBRecipeForm.cxGridTVCPBDtlCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  iChemicalType:Integer;
begin
  inherited;
  if AViewInfo.Focused then Exit;
  iChemicalType := TcxGridDBTableView(Sender).GetColumnByFieldName('Chemical_Type').Index;
  if AViewInfo.GridRecord.Values[iChemicalType] = 'CPB助剂' then
    ACanvas.Font.Color := clSilver;
end;

procedure TCPBRecipeForm.ResetValue;
begin
  edtPatternID.Text := '';
  edtCustomer.Text := '';
  edtLBNO.Text := '';
  edtLB_NO.Text := '';
  edtPatternName.Text := '';
  edtStyleName.Text := '';
  edtFabColorName.Text := '';
  edtConstruction.Text := '';
  edtFinishMethod.Text := '';
  edtLaunchTime.Text := '';
  edtPPOType.Text := '';
  edtQuantity.Text := '';
  edtOperator.Text:= '';
  edtFNColorCode.Text := '';
end;

procedure TCPBRecipeForm.cbViewChemicalClick(Sender: TObject);
begin
  inherited;
  gbChemicalList.Visible := cbViewChemical.Checked
end;

procedure TCPBRecipeForm.cbbFabricTypeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
    cbGFNO.SetFocus;
end;

procedure TCPBRecipeForm.cbGFNOKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
  begin
    cbGFNO.OnChange(Sender);
    cbbRecipeType.SetFocus;
  end else if Key=VK_DOWN then
  begin
    cbGFNODropDown(Sender);
  end;
end;

procedure TCPBRecipeForm.cbbOperatorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
    cbbToner.SetFocus;
end;

procedure TCPBRecipeForm.cbbTonerKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
    btnSave.SetFocus;
end;

procedure TCPBRecipeForm.cbbRecipeTypeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
    cbbOperator.SetFocus;
end;

procedure TCPBRecipeForm.xriteRecipe(Item_NO: string);
var
   vData: OleVariant;
   sCondition,sErrorMsg: widestring;
   i,Chemical_ID: Integer;
begin
  sCondition := QuotedStr(Item_NO)+','+QuotedStr('')+','+QuotedStr(Login.CurrentDepartment)+',8';
  FNMServerObj.GetQueryData(vData,'CPBGetRecipeDtl',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TempClientDataSet.Data := vData;
  if not TempClientDataSet.Active or TempClientDataSet.IsEmpty then Exit;
  UpdateItemNO := TempClientDataSet.FieldByName('Item_NO').AsString;
  for i := 1 to vleChemicallist.RowCount-1 do
  begin
    Chemical_ID := Integer(vleChemicallist.Strings.Objects[i-1]);
    if TempClientDataSet.Locate('Chemical_ID',Chemical_ID,[]) then
      vleChemicallist.Values[vleChemicallist.Keys[i]] := TempClientDataSet.FieldByName('Usage').AsString;
  end;
  CalcAuxiliaries;
end;



procedure TCPBRecipeForm.vlePDParamStringsChange(Sender: TObject);
begin
  inherited;
  vlePDParam.Invalidate;
  if  (oldStrings <> vlePDParam.Cells[1,1]) then
  begin
    if vlePDParam.Cells[1,1] = '微波打板' then
    begin
      oldStrings := vlePDParam.Cells[1,1];
      vlePDParam.Cells[1,2] := '5Min';
    end;
    if vlePDParam.Cells[1,1] = '堆置打板' then
    begin
      oldStrings := vlePDParam.Cells[1,1];
      vlePDParam.Cells[1,2] := '18H';
    end;
    if vlePDParam.Cells[1,1] = '烘箱打板' then
    begin
      oldStrings := vlePDParam.Cells[1,1];
      vlePDParam.Cells[1,2] := '2H';
    end;

    //--Content:    Reason:    Added By Danny at 2015-02-05 16:02:20:664
    if vlePDParam.Cells[1,1] = '微波法' then
    begin
      oldStrings := vlePDParam.Cells[1,1];
      vlePDParam.Cells[1,2] := '5Min';
    end;
    if vlePDParam.Cells[1,1] = '烘箱法' then
    begin
      oldStrings := vlePDParam.Cells[1,1];
      vlePDParam.Cells[1,2] := '2H';
    end;
    if vlePDParam.Cells[1,1] = '堆置法' then
    begin
      oldStrings := vlePDParam.Cells[1,1];
      vlePDParam.Cells[1,2] := '18H';
    end;


  end;

end;

procedure TCPBRecipeForm.cbGFNODropDown(Sender: TObject);
var orgFilter:String;
    orgFiltered:Boolean;
    gk_no,rawno:string;
    vData:OleVariant;
    tmpCds:TClientDataSet;
    sCondition:string;
    sErrorMsg: WideString;
    Default_Cur:TCursor;
begin
  inherited;
  Default_Cur:=Screen.Cursor;

  //--Content:输入坯布品名找出对CPB对应的成品品名，供下拉选择    Reason:    Added By Danny at 2015-02-03 11:35:33:522
  gk_no:=cbGFNO.Text;
  
  if Pos('-', gk_no)>1 then
    rawno:=LeftStr(gk_no, Pos('-', gk_no)-1)
  else
    rawno:=gk_no;

  if OldRaw_No=rawno then Exit;
  OldRaw_No:=rawno;
  
  tmpCds:=TClientDataSet.Create(Self);
  if gk_no<>'' then
  begin
    try
      Screen.Cursor:=crHourGlass;
      if Pos('-',gk_no)>1 then
      begin
        if (cbGFNO.Items.Count>0 ) and (Pos(gk_no,cbGFNO.Items.Text)>0) then Exit;
        //--Content:如果是成品品名，截取坯布品名    Reason:    Added By Danny at 2015-02-03 14:08:36:453
        gk_no:=LeftStr(gk_no,Pos('-',gk_no)-1);
      end;
      sCondition:=gk_no;
      FNMServerObj.GetQueryData(vData, 'GetGf_noByRaw', sCondition, sErrorMsg);
      if sErrorMsg<>'' then raise Exception.Create(sErrorMsg);
      
      tmpCds.Data:=vData;
      FillItemsFromDataSet(tmpCds, 'GF_NO', '', '', '', cbGFNO.Items);

//      with Dictionary.cds_CPBStock do
//      begin
//       orgFilter:=Filter;
//       orgFiltered:=Filtered;
//
//       Filter:='GF_NO like ''%'+gk_no+'%'' OR '+'GF_NO like ''%'+UpperCase(gk_no)+'%'' OR '+'GF_NO like ''%'+LowerCase(gk_no)+'%''';
//       Filtered:=True;
//
//       FillItemsFromDataSet(Dictionary.cds_CPBStock, 'GF_NO', '', '', '', cbGFNO.Items);
//
//      end;
        Screen.Cursor:=Default_Cur;
    except
      on e:Exception do
      begin
        Screen.Cursor:=Default_Cur;
        ShowMsg(e.Message+char(13)+'坯布品名找出CPB成品品名出错!');
      end;
    end;

    Dictionary.cds_CPBStock.Filter:=orgFilter;
    Dictionary.cds_CPBStock.Filtered:=orgFiltered;
  end;
  FreeAndNil(tmpCds);
  //end--Content
end;

{-------------------------------------------------------------------------------
  过程名:    TCPBRecipeForm.AddChemical
  作者:      Danny duda
  日期:      2015.02.04 10:57:01
  参数:      Chimcal_ID: Integer 化料ID
  返回值:    无
  描述:      手工增加化料，主要是878	CPB助剂	水玻璃（37-40Be) 879	CPB助剂	NaOH 50%
  修改内容:
-------------------------------------------------------------------------------}
procedure TCPBRecipeForm.AddChemical(Chemical_ID: Integer);
var Last_Chimcal_ID:Integer;
    Row:Integer;
    Chimcal_Text:String;
begin
  if (Chemical_ID=878) or (Chemical_ID=879) then
  begin
    if Chemical_ID=878 then
    begin
      Last_Chimcal_ID:=879;
      if vleChemicallist.Strings.IndexOfObject(TObject(Last_Chimcal_ID)) = -1 then
        Last_Chimcal_ID:=887;
      Chimcal_Text:='水玻璃（37-40Be)';
    end else
    begin
      Last_Chimcal_ID:=887;
      Chimcal_Text:='NaOH 50%';
    end;

    row:=vleChemicallist.Strings.IndexOfObject(TObject(Last_Chimcal_ID));
    if Row<>-1 then
    begin
      Row:=Row-0;
    end else
      Row:=vleChemicallist.RowCount-1;

    if vleChemicallist.Strings.IndexOfObject(TObject(Chemical_ID)) = -1 then
     if vleChemicallist.RowCount = 2 then
       vleChemicallist.Strings.AddObject(Chimcal_Text + '=0.00', TObject(Chemical_ID))
     else
       vleChemicallist.Strings.InsertObject(Row, Chimcal_Text + '=0.00', TObject(Chemical_ID));
  end;
end;

procedure TCPBRecipeForm.popMChemicalN1Click(Sender: TObject);
begin
  inherited;
  AddChemical(878);
end;

procedure TCPBRecipeForm.popMChemicalN2Click(Sender: TObject);
begin
  inherited;
  AddChemical(879);
end;

{-------------------------------------------------------------------------------
  过程名:    TCPBRecipeForm.CheckChemicalQty
  作者:      Danny duda
  日期:      2015.02.04 11:42:18
  参数:      无
  返回值:    无
  描述:      前后配方比例相差±10倍，保存时系统提示确认；
  修改内容:
-------------------------------------------------------------------------------}
function TCPBRecipeForm.CheckChemicalQty:Boolean;
var i:Word;
    Chemical_ID:Integer;
    qty, qty1:Double;
    cds:TClientDataSet;
    msg:String;
begin
  Result:=True;
  cds:=TClientDataSet(cxGridTVCPBDtl.DataController.DataSource.DataSet);
  cds.DisableControls;
  msg:='';
  if (cxGridTVCPBDtl.ColumnCount>5)  then
    for i := 1 to vleChemicallist.RowCount - 1 do
    begin
      Chemical_ID := Integer(vleChemicallist.Strings.Objects[i-1]);
      qty :=  StrToFloat(vleChemicallist.Values[vleChemicallist.Keys[i]]);

      cds.First;
      while not cds.Eof do
      begin
        if Chemical_ID=cds.FieldByName('Chemical_ID').AsInteger then
        begin
          qty1:=cds.FieldByName('Unit_QTY').AsFloat;
          if qty<>qty1 then
          begin
            if (qty=0) or (qty1=0) or (qty/qty1> 9.9999999) or (qty1/qty> 9.9999999) then
            begin
              msg:=msg+ifthen(msg='', '', Char(13))+cds.fieldByName('Chemical_Name').AsString;
            end;
          end;
        end;
        cds.Next;
      end;
    end;
  cds.EnableControls;

  if msg<>'' then
  begin
    msg:='以下化料和前次配方对比超过10倍'+char(13)+msg+char(13)+'是否继续操作?';
    Result:=TMsgDialog.ShowMsgDialog(msg,mtConfirmation, [mebYes, mebNo], mebYes)= mrYes;
  end;
end;


{-------------------------------------------------------------------------------
  过程名:    TCPBRecipeForm.cxGridTVCPBDtlDblClick
  作者:      Danny duda
  日期:      2015.02.04 13:10:56
  参数:      Sender: TObject
  返回值:    无
  描述:      采用历史配方
  修改内容:
-------------------------------------------------------------------------------}
procedure TCPBRecipeForm.cxGridTVCPBDtlDblClick(Sender: TObject);
var i:Word;
    Chemical_ID:Integer;
    Chemical_Text:String;
    qty:string;
begin
  inherited;

  if (cxGridTVCPBDtl.Controller.FocusedColumnIndex < 0) or (TMsgDialog.ShowMsgDialog('是否采用配方'+cxGridTVCPBDtl.Controller.FocusedColumn.Caption+'？',mtConfirmation, [mebYes, mebNo], mebYes)<> mrYes) then Exit;

  for i:=vleChemicallist.RowCount-1 downto 1 do
  begin
    vleChemicallist.DeleteRow(i);
  end;
  //cxGridTVCPBDtl.DataController.GetValue(1,);
  for i:=0 to cxGridTVCPBDtl.DataController.RowCount-1 do
  begin
    Chemical_ID:=cxGridTVCPBDtl.DataController.GetValue(i,1);
    Chemical_Text:=cxGridTVCPBDtl.DataController.GetValue(i,3);
    qty:=cxGridTVCPBDtl.DataController.GetValue(i,cxGridTVCPBDtl.Controller.FocusedColumnIndex +5);
    if StrToFloatDef(qty,0) > 0 then
    vleChemicallist.Strings.AddObject(Chemical_Text+ '='+qty, TObject(Chemical_ID));
  end;
end;

{-------------------------------------------------------------------------------
  过程名:    TCPBRecipeForm.GetConstruction
  作者:      Danny duda
  日期:      2015.03.03 10:18:00
  参数:      GF_NO: string
  返回值:    string
  描述:      获取品名规格
  修改内容:
-------------------------------------------------------------------------------}
function TCPBRecipeForm.GetConstruction(GF_NO: string): string;
var
  sMsg, sSQL, sErrMsg: WideString;
  vData:OleVariant;
  cdsTemp:TClientDataSet;
  default_Cur:TCursor;
begin
  default_Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  try

    sSQL := 'SELECT TOP 1 Construction = FNMDB.dbo.udf_cpbGetConstruction(GF_ID) FROM	PDMDB..tdBasicInfo with(nolock) WHERE	GF_NO = '+QuotedStr(GF_NO);
    FNMServerObj.GetQueryBySQL(vData, sSQL,sErrMsg);
    if sErrMsg <> '' then
    begin
      Raise Exception.Create(sErrMsg);
    end;
    cdsTemp:=TClientDataSet.Create(Self);
    cdsTemp.Data:=vData;
    if not cdsTemp.IsEmpty then
      Result:=cdsTemp.FieldByName('Construction').AsString;
    FreeAndNil(cdsTemp);

  finally
    Screen.Cursor:=default_Cur;
  end;

end;

procedure TCPBRecipeForm.cbbOperatorChange(Sender: TObject);
var
  Tempstr: string;
begin
  inherited;
  if Pos(cbbOperator.Text,edtOperator.Text) = 0 then
  begin
    edtOperator.Text:= Trim(edtOperator.Text) + ',' + Trim(cbbOperator.Text);
    if Pos(',',edtOperator.Text) = 1 then
    begin
      Tempstr:= Trim(edtOperator.Text);
      Delete(Tempstr,1,1);
      edtOperator.Text:= Tempstr;
    end;
  end;
end;

procedure TCPBRecipeForm.cxGridTVCPBDtlCustomDrawIndicatorCell(
  Sender: TcxGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridIndicatorItemViewInfo; var ADone: Boolean);
var
  FValue: string;
  FBounds: TRect;
begin
  inherited;
  FBounds := AViewInfo.Bounds;
  if (AViewInfo is TcxGridIndicatorRowItemViewInfo) then
  begin
    ACanvas.FillRect(FBounds);
    ACanvas.DrawComplexFrame(FBounds, clBlack, clBlack, [bBottom, bLeft, bRight], 1);
    FValue:= cxGridTVCPBDtl.DataController.GetValue(TcxGridIndicatorRowItemViewInfo(AViewInfo).GridRecord.Index,3);
    InflateRect(FBounds, -3, -2);
    ACanvas.Font.Color := clBlack;
    ACanvas.Brush.Style := bsClear;
    ACanvas.DrawText(FValue, FBounds, cxAlignLeft or cxAlignTop);
    ADone := True;
    OutputDebugString(PChar(IntToStr(cxGridTVCPBDtl.OptionsView.IndicatorWidth)));
  end;
end;

procedure TCPBRecipeForm.cxGridTVCPBDtlCellClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
var
  sMsg, sSQL, sErrMsg: WideString;
  vData:OleVariant;
  cdsTemp:TClientDataSet;
  default_Cur:TCursor;
  sRecipe_no: string;
  i: Integer;
begin
  inherited;
  //表格在前面隐藏了5个字段
  sRecipe_no:= cxGridTVCPBDtl.Columns[cxGridTVCPBDtl.Controller.FocusedColumnIndex+5].Caption;
  edtRecipeNO.Text:= sRecipe_no;
  if sRecipe_no = '' then Exit;
  default_Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  try

    sSQL := ' select top 1 a.Operator,a.Toner from fnCPBRecipeTrace a WITH (nolock)  ' +
            'where a.Recipe_no  = '+QuotedStr(sRecipe_no);
    FNMServerObj.GetQueryBySQL(vData, sSQL,sErrMsg);
    if sErrMsg <> '' then
    begin
      Raise Exception.Create(sErrMsg);
    end;
    cdsTemp:=TClientDataSet.Create(Self);
    cdsTemp.Data:=vData;
    if not cdsTemp.IsEmpty then
    begin
      cbbToner.ItemIndex:= cbbToner.Items.IndexOf(cdsTemp.FieldByName('Toner').AsString);
      edtOperator.Text:= cdsTemp.FieldByName('Operator').AsString;
      i:=  Pos('-',cdsTemp.FieldByName('Operator').AsString);
      if i > 0 then
        edtOperator.Text:= Copy(cdsTemp.FieldByName('Operator').AsString,i+1,Length(cdsTemp.FieldByName('Operator').AsString)-i);
    end;


    sSQL := ' select a.Recipe_Type,(SELECT GF_NO FROM PDMDB..tdGFID WITH(NOLOCK) WHERE GF_ID = a.GF_ID) GF_NO   ' +
            ' from fnCPBRecipeHdr a WITH(NOLOCK)  ' + 
            ' where a.Recipe_no  = '+QuotedStr(sRecipe_no);
    FNMServerObj.GetQueryBySQL(vData, sSQL,sErrMsg);
    if sErrMsg <> '' then
    begin
      Raise Exception.Create(sErrMsg);
    end;
    cdsTemp:=TClientDataSet.Create(Self);
    cdsTemp.Data:=vData;
    if not cdsTemp.IsEmpty then
    begin
      TGlobal.SetComboBoxValue(cbGFNO, cdsTemp.FieldByName('GF_NO').AsString);
      cbbRecipeType.ItemIndex:= cbbRecipeType.Items.IndexOf(cdsTemp.FieldByName('Recipe_Type').AsString);
    end;
    FreeAndNil(cdsTemp);
  finally
    Screen.Cursor:=default_Cur;
  end;
end;

end.


