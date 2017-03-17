unit frmCPBFormat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ComCtrls, Buttons, Grids, ValEdit, StdCtrls, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, DBClient, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, CheckLst, cxSplitter, Menus;

type
  TCPBFormatForm = class(TBaseForm)
    pnlTop: TPanel;
    grp2: TGroupBox;
    cxGrid2: TcxGrid;
    cxgdTVTask: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    dsTask: TDataSource;
    cdsTask: TClientDataSet;
    lbLBNO: TLabel;
    btnQuery: TSpeedButton;
    edtGFNO: TEdit;
    btnRefresh: TSpeedButton;
    pn1: TPanel;
    cxSplitter2: TcxSplitter;
    cxSplitter1: TcxSplitter;
    cxSplitter3: TcxSplitter;
    cdsCPBRecipeDtl: TClientDataSet;
    dsCPBRecipeDtl: TDataSource;
    GroupBox2: TGroupBox;
    pnlRight: TPanel;
    gbHistory: TGroupBox;
    cxGrid1: TcxGrid;
    cxGridTVCPBDtl: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    gbFNCard: TGroupBox;
    cbAll: TCheckBox;
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
    gbChemicalList: TGroupBox;
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
    gbHistoryRecipe: TGroupBox;
    cbbHistoryRecipe: TComboBox;
    pnlCaption: TPanel;
    vleChemicallist: TValueListEditor;
    btnDel: TSpeedButton;
    lbl1: TLabel;
    lbl2: TLabel;
    edtFinishMethod: TEdit;
    edtLaunchTime: TEdit;
    cbExport: TCheckBox;
    pnlDelete: TPanel;
    btnDelete: TSpeedButton;
    lblDeleteNO: TLabel;
    edtDeleteNO: TEdit;
    lbl3: TLabel;
    edtNewRecipe: TEdit;
    btnSave: TBitBtn;
    btnExit: TBitBtn;
    btnAdd: TSpeedButton;
    cbViewChemical: TCheckBox;
    pnlGroup: TPanel;
    btnGroup: TSpeedButton;
    cbChemicalGroup: TComboBox;
    Panel2: TPanel;
    edtAddGFNO: TEdit;
    Label1: TLabel;
    btnAddGFNO: TSpeedButton;
    cbbRecipeType: TComboBox;
    Label12: TLabel;
    gbAddRatio: TGroupBox;
    edtRatio: TEdit;
    btnAddRatio: TSpeedButton;
    Label10: TLabel;
    cbbOperator: TComboBox;
    cbbToner: TComboBox;
    btnPrint: TSpeedButton;
    ComboBox1: TComboBox;
    pn0: TPanel;
    popMChemical: TPopupMenu;
    popMChemicalN1: TMenuItem;
    popMChemicalN2: TMenuItem;
    edtJQ: TEdit;
    edtKH: TEdit;
    edtJG: TEdit;
    Label16: TLabel;
    Label15: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    lbToner: TLabel;
    lblMC: TLabel;
    cdsHistoryRecipe: TClientDataSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure cxgdTVTaskDblClick(Sender: TObject);
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
    procedure edtGFNOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
    procedure vleChemicallistKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnGroupClick(Sender: TObject);
    procedure vleChemicallistSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure vleChemicallistDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure vlePDParamGetPickList(Sender: TObject; const KeyName: String;
      Values: TStrings);
    procedure cbViewChemicalClick(Sender: TObject);
    procedure btnAddGFNOClick(Sender: TObject);
    procedure btnAddRatioClick(Sender: TObject);
    procedure edtRatioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure popMChemicalN1Click(Sender: TObject);
    procedure popMChemicalN2Click(Sender: TObject);
    procedure vlePDParamStringsChange(Sender: TObject);
    procedure cbbHistoryRecipeClick(Sender: TObject);
    procedure lvFNCardClick(Sender: TObject);
  private
    FiType: Integer;
    { Private declarations }
    function CheckChemmicalData(var AChemicalStr:string; var AUnitQtyStr: string): Boolean;
    procedure CalcAuxiliaries;
    procedure CalcAddRatio;
    procedure FillFNCard(GF_NO: string;FN_Color_Code: string);
    function FillChemicalGroup(GF_NO: string): string;
    procedure GetRecipeHdrInfo(Recipe_NO: string);
    function GetRecipeDtlInfo(GF_NO: string;Chemical_Group: string): string;
    procedure SaveFormatInfo;
    procedure DeleteRecipeInfo;
    procedure SetBtnState;
    function CheckChemicalValue(sType:String):Boolean;
    function GetGuideQuantity: string;
    procedure SetiType(const Value: Integer);

  private
    procedure AddChemical(Chemical_ID: Integer);
    //ǰ���䷽��������10��������ʱϵͳ��ʾȷ�ϣ�
    function CheckChemicalQty: Boolean;
    //����������ֻ��ѡ���ܱ༭
    procedure SetTaskReadOnly;
    //��ȡ��ѡ���Ʒ��
    function GetSelectGFNO:TStrings;
    //ȡһ��GUID�����ø���
    function GetGUID: String;
    procedure FillData(GF_NO:String);
    procedure GetHistoryRecipe(GF_NO:string);
  protected
    procedure UpdateActions; override;
  public
    { Public declarations }
   property iType: Integer read FiType write SetiType;
  end;

var
  CPBFormatForm: TCPBFormatForm;
  CPBSampleForm: TCPBFormatForm;
  CPBBulkForm: TCPBFormatForm;
  oldStrings:string;
  
implementation

uses Math, StrUtils, ServerDllPub, uFNMArtInfo,uFNMResource ,
     uDictionary, uShowMessage, uLogin, UAppOption, uGlobal, UGridDecorator,
     rptCPB, frmCPBChemicalGroup;
{$R *.dfm}

function TCPBFormatForm.GetGuideQuantity: string;
var i,Chemical_ID: Integer;
    Unit_Qty:string;
    cpbUnitQty: real;
begin
  Result := '0';
  cpbUnitQty := 0;
  for i := 1 to vleChemicallist.RowCount - 1 do
  begin
    Chemical_ID := Integer(vleChemicallist.Strings.Objects[i-1]);
    Unit_Qty := vleChemicallist.Values[vleChemicallist.Keys[i]];
    if Dictionary.cds_CPBChemical.Locate('Chemical_ID;Chemical_Type',VarArrayOf([Chemical_ID, 'CPBȾ��']), []) then
      cpbUnitQty :=  cpbUnitQty +StrToFloat(Unit_Qty)
  end;
  if (cpbUnitQty < 1.0) then
  begin
    Result := '200';
    if not InputQuery('�Ƿ�����������볤', '�����뵼���볤:', Result) then
       Result:='0';
  end;
end;

function TCPBFormatForm.CheckChemmicalData(var AChemicalStr: string; var AUnitQtyStr: string): Boolean;
var i: Integer;
begin
  Result := False;
  if vleChemicallist.Strings.Text <> '' then
  begin
    //2009-11-30 ����ǰ���Ⱦ����������Ϊ0
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

procedure TCPBFormatForm.CalcAuxiliaries;
var
  ChemicalStr, UnitQtyStr: string;
  vData: OleVariant;
  sCondition: string;
  sErrorMsg: WideString;
begin
  //--Content:���������Ż��׶�,�ֽ׶β���Ҫϵͳ�Զ�����������������Ȼ�ֹ���������,������        ��������ϵͳ�Զ���������������    Reason:    Added By Danny at 2015-02-25 23:09:58:587
  //if iType=5 then Exit;
    
  ChemicalStr := '';
  UnitQtyStr := '';
  if not CheckChemmicalData(ChemicalStr,UnitQtyStr) then Exit;
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('���ڻ�ȡ�����Եȣ�',crHourGlass);
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
      TMsgDialog.ShowMsgDialog('û�������Ϣ,������Ĳ�ѯ����!',mtInformation);
      Exit;
    end;
    FillItemsFromDataSet(TempClientDataSet, 'Chemical_Name', 'Unit_QTY', 'Chemical_ID', '=', vleChemicallist.Strings);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCPBFormatForm.CalcAddRatio;
var
  Limit,Flag : Integer;
  Ratio: real;
  ItemValue,Dumb: string;
begin
  ItemValue := Trim(vleChemicallist.Values[vleChemicallist.Keys[vleChemicallist.Row]]);
  if ItemValue = '' then Exit; //������ֵ�˳�

  Flag := 1;
  Dumb := Trim(edtRatio.Text);
  if LeftStr(Dumb,1) = '-' then
  begin
    Delete(Dumb, 1, 1);
    Flag := -1;
  end;
  Ratio := StrToFloat(Dumb);

  ItemValue := FloatToStr(StrToFloat(ItemValue)* (100 + Flag*Ratio) * 0.01);
  vleChemicallist.Values[vleChemicallist.Keys[vleChemicallist.Row]]:= ItemValue;
end;

procedure TCPBFormatForm.FillFNCard(GF_NO: string;FN_Color_Code: string);
var vData: OleVariant;
    sCondition: string;
    sErrorMsg: WideString;
    fQuantity: Double;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('���ڻ�ȡ�����Եȣ�',crHourGlass);
    sCondition := QuotedStr(GF_NO)+','+QuotedStr(Login.CurrentDepartment)+','+QuotedStr(FN_Color_Code);
    FNMServerObj.GetQueryData(vData,'CPBGetFormatCard',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    fQuantity:= 0;
    TempClientDataSet.Data := vData;
    with TempClientDataSet do
    begin
      First;
      while not Eof do
      begin
        with lvFNCard.Items.Add do
        begin
          Caption := FieldByName('FN_Card').AsString;
          SubItems.Add(FieldByName('Quantity').AsString);
         // SubItems.Add(FieldByName('White').AsString);
//          SubItems.Add(FieldByName('One_Minute').AsString);
          SubItems.Add(FieldByName('GF_NO').AsString);
          Checked := True;
          fQuantity:= fQuantity + FieldByName('Quantity').AsFloat;
        end;
        Next;
      end;
    end;
  finally
    lblMC.Caption:= '���볤:' + FloatToStr(fQuantity);
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

function TCPBFormatForm.FillChemicalGroup(GF_NO: string):string;
var vData: OleVariant;
    sCondition: string;
    sErrorMsg: WideString;
begin
  Result := ''; 
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('���ڻ�ȡ�����Եȣ�',crHourGlass);
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
    //lvChemicalGroup.Visible := lvChemicalGroup.Items.Count > 1;
    lvChemicalGroup.Items[0].Selected := lvChemicalGroup.Items.Count > 1;
    if lvChemicalGroup.Visible then
      lvChemicalGroup.SetFocus;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCPBFormatForm.GetRecipeHdrInfo(Recipe_NO: string);
var vData: OleVariant;
    sCondition: string;
    sErrorMsg: WideString;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('���ڻ�ȡ�����Եȣ�',crHourGlass);
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
      TMsgDialog.ShowMsgDialog('û�������Ϣ,������Ĳ�ѯ����!',mtInformation);
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
    edtFinishMethod.Text := TempClientDataSet.FieldByName('Finish_Method').AsString;
    edtLaunchTime.Text := TempClientDataSet.FieldByName('Launch_Time').AsString;
    TGlobal.SetComboBoxValue(cbChemicalGroup, TempClientDataSet.FieldByName('Chemical_Group').AsString);
    plShowColor.Color := TempClientDataSet.FieldByName('RGB').AsInteger;
    TempClientDataSet.Data := vData[1];

    //--Content:�����ʽ��Ϊ��ɫ����    Reason:    Added By Danny at 2015-02-05 15:08:23:363
      TempClientDataSet.First;
      while not TempClientDataSet.Eof do
      begin
        if TempClientDataSet.FieldByName('Item_Name').AsString='�����ʽ' then
        begin
          TempClientDataSet.Edit;
          TempClientDataSet.FieldByName('Item_Name').Value:='��ɫ����';
          TempClientDataSet.Post;
        end;
        TempClientDataSet.Next;
      end;
      TempClientDataSet.First;

    FillItemsFromDataSet(TempClientDataSet, 'Item_Name', 'Item_Value', '', '=', vlePDParam.Strings);
    btnSave.Enabled := True;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

function TCPBFormatForm.GetRecipeDtlInfo(GF_NO: string; Chemical_Group: string): string;
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
    TStatusBarMessage.ShowMessageOnMainStatsusBar('���ڻ�ȡ�����Եȣ�',crHourGlass);
    if iType = 5 then
    begin
      lvFNCard.Clear;
      FillFNCard(GF_NO,'');
      FillData(GF_NO);
    end;
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
      TMsgDialog.ShowMsgDialog('û�������Ϣ,������Ĳ�ѯ����!',mtInformation);
      Exit;
    end;
    Result := TempClientDataSet.FieldByName('Recipe_NO').AsString;
    //��ʷ�䷽��ϸ
    //if iType = 4 then
    begin
      cdsCPBRecipeDtl.Data := vData;
      GridDecorator.BindCxViewWithDataSource(cxGridTVCPBDtl, dsCPBRecipeDtl,True);
      GridDecorator.HideFields(cxGridTVCPBDtl,['Seq_No','Recipe_NO','Chemical_ID','Unit_QTY','Seq_No1']);
    end;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCPBFormatForm.UpdateActions;
begin
  inherited;
  SetBtnState;
  btnPrint.Enabled := Trim(cbbHistoryRecipe.Text) <> '';
  btnDelete.Enabled := Trim(edtDeleteNO.Text) <> '';
end;

procedure TCPBFormatForm.FormCreate(Sender: TObject);
begin
  inherited;
  btnCalc.Glyph.LoadFromResourceName(HInstance, RES_CALCULATE);
  btnAddRatio.Glyph.LoadFromResourceName(HInstance, RES_CALCULATE);
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
  btnAddGFNO.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  PageControl1.ActivePageIndex := 0;
  cbbChemicalName.Align := alClient;
  gbHistory.Align := alClient;
  gbFNCard.Align := alClient;
  FillItemsFromDataSet(Dictionary.cds_ChemicalList, 'Chemical_Short_Name', '', 'Chemical_ID', '', cbbChemicalName.Items);
  FillTreeItemsFromDataSetByClassField(Dictionary.cds_CPBChemical,'Chemical_Name', 'Chemical_Type','Chemical_ID', '', tvChemical.Items);
  cbShade.Items.Text := Dictionary.GetItemList('CPBɫ��',Login.CurrentDepartment,'');
  FillItemsFromDataSet(Dictionary.cds_CPBChemicalGroup, 'Group_Name', '', '', '', cbChemicalGroup.Items);
  cbChemicalGroup.Items.Insert(0,'');
  cbbRecipeType.Items.Text := Dictionary.GetItemList('CPB��������',Login.CurrentDepartment,'');
  cbbOperator.Items.Text := Dictionary.GetItemList('CPB��ɫʦ',Login.CurrentDepartment,'');
  cbbToner.Items.Text := cbbOperator.Items.Text;//Dictionary.GetItemList('CPB��ɫʦ',Login.CurrentDepartment,'');
  if cbbOperator.Items.Count > 0 then
    cbbOperator.ItemIndex := 0;
  if cbbToner.Items.Count > 0 then
    cbbToner.ItemIndex := 0;
    
  //������� ����Ĭ��Ϊ��� add by dengshch 2015.05.07
  cbbRecipeType.ItemIndex:= cbbRecipeType.Items.IndexOf('���');
  TControl(btnPrint).Align := alBottom;
  TControl(cbbHistoryRecipe).Align := alClient;
end;

procedure TCPBFormatForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCPBFormatForm.FormDestroy(Sender: TObject);
begin
  inherited;
  CPBFormatForm := nil;
  CPBSampleForm := nil;
  CPBBulkForm := nil;
end;

procedure TCPBFormatForm.btnRefreshClick(Sender: TObject);
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
begin
  inherited;
  sCondition := QuotedStr(Login.CurrentDepartment)+','+ IntTostr(iType);
  FNMServerObj.GetQueryData(vData,'CPBGetTask',sCondition,sErrorMsg);

  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  cdsTask.Data := vData;
  GridDecorator.BindCxViewWithDataSource(cxgdTVTask, dsTask);

  SetTaskReadOnly();

end;

procedure TCPBFormatForm.cxgdTVTaskDblClick(Sender: TObject);
begin
  if not cdsTask.Active then Exit;
  edtGFNO.Text := cdsTask.FieldByName('GF_NO').AsString;
  btnQuery.Click;
end;

procedure TCPBFormatForm.btnAddClick(Sender: TObject);
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

procedure TCPBFormatForm.btnDelClick(Sender: TObject);
var
  iRow:Integer;
  Chemical_ID: String;
begin
  inherited;
  if vleChemicallist.Strings.Text <> '' then
  begin
    iRow := vleChemicallist.Row;
    Chemical_ID := IntTostr(Integer(vleChemicallist.Strings.Objects[iRow-1]));
    //2010-9-11��������ɾ��
    if Dictionary.cds_CPBChemical.Locate('Chemical_ID;Chemical_Type',VarArrayOf([Chemical_ID, 'CPB����']), []) then
    begin
      if TMsgDialog.ShowMsgDialog('�Ƿ�Ҫɾ��������?',mtConfirmation, [mebYes, mebCancel], mebYes)= mrCancel then
         Exit;
    end;
    vleChemicallist.DeleteRow(vleChemicallist.Row);
  end
end;

procedure TCPBFormatForm.tvChemicalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    btnAdd.Click;
end;

procedure TCPBFormatForm.btnDeleteClick(Sender: TObject);
begin
  inherited;
  DeleteRecipeInfo;
end;

procedure TCPBFormatForm.btnSaveClick(Sender: TObject);
begin
  SaveFormatInfo;
end;

procedure TCPBFormatForm.DeleteRecipeInfo;
var
  sCondition, sErrorMsg: WideString;
begin
  inherited;
  if (edtDeleteNO.Text ='')then Exit;
  if IDNO = Application.MessageBox('�Ƿ�ɾ����ǰ�䷽�ţ�', '��ʾ', MB_YESNO + MB_ICONQUESTION) then exit;
  sCondition := QuotedStr(edtDeleteNO.Text)+','+ QuotedStr(Login.CurrentDepartment)+','+QuotedStr(Login.LoginID);
  try
    ShowMsg('���ڻ�ȡ�����Եȣ�', crHourGlass);
    FNMServerObj.SaveDataBySQL('CPBDeleteRecipe',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    edtDeleteNO.Text := '';
    btnDelete.Enabled := False;
    TMsgDialog.ShowMsgDialog('ɾ�����ݳɹ�',mtInformation);
  finally
    ShowMsg('', crDefault);
  end;  
end;

procedure TCPBFormatForm.SaveFormatInfo;
var
  Recipe_NO,sCondition, sErrorMsg: WideString;
  i : Integer;
  Ppo_Type,FNCardStr,ChemicalStr, UnitQtyStr,ItemNameStr,ItemValueStr,GuideQuantity: string;

  tmpi:Integer;
  GFNOList:TStrings;//���ø�����
  ShareID:String;//���ø���ID
  tmpGFNO, tmpRecipe_NO, tmpFNCardStr, tmpChemicalStr,  tmpUnitQtyStr, tmpItemNameStr, tmpItemValueStr, tmpGuideQuantity:String;//���ø�����
begin
  if vleChemicallist.RowCount<2 then Exit;
  if edtGFNO.Text ='' then Exit;

  //--Content:��2��������ͣ� T/W���ȷ�������������������ޣ���Ϊ��ѡ��    Reason:    Added By Danny at 2015-02-11 21:13:05:289
  if (iType=4)and(cbbRecipeType.ItemIndex<0) then
  begin
    cbbRecipeType.SetFocus;
    TMsgDialog.ShowMsgDialog('��ѡ�񸴰�����!',mtInformation);
    Exit;
  end;
  ShareID:=GetGUID();

  //--Content:ǰ���䷽��������10��������ʱϵͳ��ʾȷ�ϣ�    Reason:    Added By Danny at 2015-02-04 12:48:40:064
  //if (iType=4) and (not CheckChemicalQty) then Exit;
  if not CheckChemicalQty then Exit;

  ChemicalStr := '';
  UnitQtyStr := '';
  GuideQuantity := '0';
  if not CheckChemmicalData(ChemicalStr,UnitQtyStr) then Exit;
  if iType = 5 then //�����볤
    GuideQuantity := GetGuideQuantity;

  ItemNameStr := '';
  ItemValueStr := '';
  if vlePDParam.Strings.Text <> '' then
  begin
    for i := 1 to vlePDParam.RowCount - 1 do
    begin
      if (iType = 5) and (vlePDParam.Keys[i]='������') and (Trim(vlePDParam.Values[vlePDParam.Keys[i]]) ='') then
      begin
        TMsgDialog.ShowMsgDialog('�������ʱ�������ʡ��������,����Ϊ��',mtInformation);
        Exit;
      end;
      ItemNameStr := ItemNameStr + vlePDParam.Keys[i] + '+';
      ItemValueStr := ItemValueStr + vlePDParam.Values[vlePDParam.Keys[i]] + '+';
    end;
  end;
  FNCardStr := '';
  Ppo_Type := '';
  if iType = 4 then  // С������
  begin
    Ppo_Type := 'С������';
    FNCardStr := '';
  end else
  begin
    Ppo_Type := '�������';
    for i :=0 to lvFNCard.Items.Count - 1 do
      if lvFNCard.Items[i].Checked then
         FNCardStr := FNCardStr + lvFNCard.Items[i].Caption + '+';
    if length(FNCardStr)<=1 then
    begin
      TMsgDialog.ShowMsgDialog('�������ʱ����ѡ�񿨺�',mtInformation);
      Exit;
    end
  end;
  sCondition := QuotedStr(edtRecipeNO.Text)+',' + QuotedStr(edtPatternID.Text)+',' + QuotedStr(edtLBNO.Text)+','
                +QuotedStr(edtFabColorName.Text)+',' +QuotedStr(cbShade.Text)+',' +QuotedStr(edtGFNO.Text)+','
                +QuotedStr(ChemicalStr)+','+  QuotedStr(UnitQtyStr)+','
                +QuotedStr(ItemNameStr)+','+ QuotedStr(ItemValueStr)+','
                +QuotedStr(FNCardStr)+','+ QuotedStr(Ppo_Type)+','+ QuotedStr(edtFNColorCode.Text)+','
                +QuotedStr(Login.CurrentDepartment)+','+QuotedStr(cbbOperator.Text)+','
                +QuotedStr(cbbToner.Text)+','+QuotedStr(cbbRecipeType.Text)+','
                +QuotedStr(cbChemicalGroup.Text)+','+QuotedStr(GuideQuantity);
//                {����ShareID��Ʒ�����Added By Danny at 2015-02-25 22:56:32:752}+','+QuotedStr(ShareID)+','+QuotedStr(getselectGFNO().Text);
  try
    ShowMsg('���ڻ�ȡ�����Եȣ�', crHourGlass);
    FNMServerObj.SaveDataBySQLEx('CPBFormatRecipe',sCondition,Recipe_NO,sErrorMsg);  //Content:������¼��    Reason:    Added By Danny at 2015-02-25 22:56:32:752
    //FNMServerObj.SaveDataBySQLEx('CPBFormatRecipeBatch',sCondition,Recipe_NO,sErrorMsg);

    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    edtNewRecipe.Text := Recipe_NO;

    //--Content:����ͬʱ������Ʒ��    Reason:    Added By Danny at 2015-02-12 10:27:06:204
    GFNOList:=GetSelectGFNO();
    if (iType=4) and (GFNOList.Count>0) then
    begin
      //���Ƶ�ǰ
      for tmpi:=0 to GFNOList.Count-1 do
      begin
        tmpGFNO:=GFNOList.Strings[tmpi];
        if tmpi<>0 then
        begin
          //ִ�и���

        end;
        //д���ø����fnCPBShareRecipe
      end;
    end;
    GFNOList.Free;

    if cdsTask.Active and (not cdsTask.IsEmpty) then
    begin
      while cdsTask.Locate('GF_NO', edtGFNO.Text, []) do
        cdsTask.Delete;
    end;
    //2009-12-30 ���ӵ���
    if iType = 4 then
    begin
      if cbExport.Checked then
        TGlobal.GenerateRCPFile(Recipe_NO);
    end
    else if iType = 5 then   //�������ʱֻ����һ��
    begin         
      edtGFNO.Clear;
      lvFNCard.Clear;
      btnSave.Enabled := False;
      if cbbHistoryRecipe.Items.IndexOf(Recipe_NO) = -1 then
        cbbHistoryRecipe.Items.Add(Recipe_NO);
      if not Assigned(CPBReport) then
        CPBReport := TCPBReport.Create(nil);
      CPBReport.PreviewReport(Recipe_NO,True);
    end;
    TMsgDialog.ShowMsgDialog('�������ݳɹ�',mtInformation);

  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBFormatForm.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCPBFormatForm.btnQueryClick(Sender: TObject);
var
  ChemicalGroup,RecipeNO: string;
  iIndex:Integer;
begin
  if edtGFNO.Text='' then Exit;
  ChemicalGroup := FillChemicalGroup(edtGFNO.Text);

  if ChemicalGroup = '' then Exit;

  // 2009-12-18 ��λ��ϣ�û�е�����
  iIndex := cbChemicalGroup.Items.IndexOf(ChemicalGroup);
  if iIndex>0 then
    cbChemicalGroup.ItemIndex := iIndex
  else
    cbChemicalGroup.Text := ChemicalGroup;

  RecipeNO := GetRecipeDtlInfo(edtGFNO.Text,ChemicalGroup);
  if RecipeNO <> '' then
  begin
    GetRecipeHdrInfo(RecipeNO);
  end;
  
  if (iType = 5) and (Trim(edtGFNO.Text) <> '') then    //��ȡ��ʷ�䷽��
  GetHistoryRecipe(Trim(edtGFNO.Text));
end;

procedure TCPBFormatForm.cbAllClick(Sender: TObject);
var
  i: Integer;
  fQuantity: Double;
begin
  inherited;
  begin
    fQuantity:= 0;
    for i := 0 to lvFNCard.Items.Count -1 do
    begin
      lvFNCard.Items[i].Checked := cbAll.Checked;
      if lvFNCard.Items[i].Checked then
      begin
        fQuantity:= fQuantity + StrToFloatDef(lvFNCard.Items[i].SubItems.Strings[0],0);
      end;
      lblMC.Caption:= 'Ⱦɫ�볤:' + FloatToStr(fQuantity);
    end;
  end;
end;

procedure TCPBFormatForm.cbbChemicalNameDblClick(Sender: TObject);
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

procedure TCPBFormatForm.edtGFNOKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key =13 then
   btnQuery.Click;
end;

procedure TCPBFormatForm.cxgdTVTaskCustomDrawCell(
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

procedure TCPBFormatForm.cbChemicalGroupChange(Sender: TObject);
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
    if Dictionary.cds_CPBChemical.Locate('Chemical_ID;Chemical_Type',VarArrayOf([Chemical_ID, 'CPBȾ��']), []) then
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
    //����������Ϊ��
    CheckChemicalValue('ResetData');
  finally
    Filtered:=False;
  end;
end;

procedure TCPBFormatForm.btnUpClick(Sender: TObject);
begin
  inherited;
  if (vleChemicallist.Strings.Text <>'') and (vleChemicallist.Row >1) then
  begin
     vleChemicallist.Strings.Exchange(vleChemicallist.Row-1,vleChemicallist.Row-2);
     SendMessage(vleChemicallist.Handle, WM_KEYDOWN, VK_UP, 0);
  end;
end;

procedure TCPBFormatForm.btnDownClick(Sender: TObject);
begin
  inherited;
  if (vleChemicallist.Strings.Text <>'') and (vleChemicallist.Row <vleChemicallist.RowCount-1) then
  begin
    vleChemicallist.Strings.Exchange(vleChemicallist.Row-1,vleChemicallist.Row);
    SendMessage(vleChemicallist.Handle, WM_KEYDOWN, VK_DOWN, 0);
  end;
end;

procedure TCPBFormatForm.lvChemicalGroupDblClick(Sender: TObject);
var
  ChemicalGroup,RecipeNO: string;
begin
  inherited;
  if edtGFNO.Text='' then Exit;
  if lvChemicalGroup.Selected = nil then Exit;
  ChemicalGroup := lvChemicalGroup.Selected.Caption;
  RecipeNO := GetRecipeDtlInfo(edtGFNO.Text,ChemicalGroup);
  if RecipeNO <> '' then
    GetRecipeHdrInfo(RecipeNO);
end;

procedure TCPBFormatForm.vleChemicallistValidate(Sender: TObject; ACol,
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

procedure TCPBFormatForm.btnCalcClick(Sender: TObject);
begin
  inherited;
  CalcAuxiliaries;
end;

procedure TCPBFormatForm.btnPrintClick(Sender: TObject);
var Recipe_NO: string;
begin
  inherited;
  Recipe_NO := cbbHistoryRecipe.Text;
  if not Assigned(CPBReport) then
      CPBReport := TCPBReport.Create(nil);
    CPBReport.PreviewReport(Recipe_NO,True);
end;

procedure TCPBFormatForm.vleChemicallistKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13) then
  begin
    SendMessage(TWinControl(Sender).Handle, WM_KEYDOWN, VK_DOWN, 0);
  end;
end;

procedure TCPBFormatForm.FormShow(Sender: TObject);
begin
  edtGFNO.SetFocus;
end;

function TCPBFormatForm.CheckChemicalValue(sType: String): Boolean;
var
  Chemical_ID, sItemValue: string;
  i, ChemicalCount:Integer;
begin
  inherited;
  Result := False;
  //������岻����ϣ�ֱ����ԭ����
  if (iType = 4) and (cbChemicalGroup.Text = '') then
  begin
    TMsgDialog.ShowMsgDialog('��ϲ���Ϊ��!',mtInformation);
    cbChemicalGroup.SetFocus;
    Exit;
  end;

  ChemicalCount :=vleChemicallist.Strings.Count-1;
  if ChemicalCount<2 then
  begin
    TMsgDialog.ShowMsgDialog('����̫��!',mtInformation);
    Exit;
  end;

  for i := 1 to ChemicalCount do
  begin
    Chemical_ID := IntTostr(Integer(vleChemicallist.Strings.Objects[i-1]));
    sItemValue := vleChemicallist.Values[vleChemicallist.Keys[i]];
    if sType= 'CheckData' then
    begin
      //����ǰ���Ⱦ����������Ϊ0
      {
      if Dictionary.cds_CPBChemical.Locate('Chemical_ID;Chemical_Type',VarArrayOf([Chemical_ID, 'CPBȾ��']), []) then
      begin
        if StrToFloat(sItemValue)<=0 then
        begin
          TMsgDialog.ShowMsgDialog('Ⱦ�����������0!',mtWarning);
          Exit;
        end;
      end;
      }
    end
    //��������������
    else if sType= 'ResetData' then
    begin
      if Dictionary.cds_CPBChemical.Locate('Chemical_ID',VarArrayOf([Chemical_ID]), []) then
        vleChemicallist.Values[vleChemicallist.Keys[i]] := '0.0';
    end;
  end;
  Result := True;
end;

procedure TCPBFormatForm.SetBtnState;
begin
  btnAdd.Enabled := (edtFNColorCode.Text<>'');
  //cuijf 2009-12-30 �������ʱ�������޸Ļ�����
  btnDel.Enabled := btnAdd.Enabled;
  btnGroup.Enabled := btnAdd.Enabled;
  cbChemicalGroup.Enabled := btnAdd.Enabled;
  btnCalc.Enabled := btnAdd.Enabled and (cbChemicalGroup.Text<>'');
  btnUp.Enabled := btnDel.Enabled;
  btnDown.Enabled := btnDel.Enabled;
  //btnSave.Enabled := (edtFNColorCode.Text<>'');
  vlePDParam.Enabled := btnAdd.Enabled;
  //edtQuantity.Enabled := btnAdd.Enabled;

  //cuijf 2009-12-30 �������ʱ�������޸Ļ�����
  vleChemicallist.Enabled := btnDel.Enabled;
  //cbbOperator.Enabled:= btnAdd.Enabled;
  
  //cuijf 2009-12-30
  //iType = 4 С�����壬��Ҫ���������ϻ�
  //iType = 5 �������ʱֻ����һ�Σ� һ�㲻�������µ��䷽
  cbExport.Enabled := btnDel.Enabled;
  pnlDelete.Visible := pnlDelete.Visible;//(iType = 4);

  //cuijf 2010-5-21��ȡ�����ƴ�����岻��ɾ���䷽
  cbExport.Visible := (iType = 4);// pnlDelete.Visible and (iType = 4);
  pnlGroup.Visible := pnlDelete.Visible and (iType = 4);
end;

procedure TCPBFormatForm.btnGroupClick(Sender: TObject);
var
  sGroupName:String;
begin
  inherited;
  sGroupName:= CPBChemicalGroupForm.SetModel;
  if sGroupName='' then Exit;
  cbChemicalGroup.ItemIndex := cbChemicalGroup.Items.IndexOf(sGroupName);
  cbChemicalGroup.OnChange(sender);
end;

procedure TCPBFormatForm.vleChemicallistSelectCell(Sender: TObject; ACol,
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
    if Dictionary.cds_CPBChemical.Locate('Chemical_ID;Chemical_Type',VarArrayOf([sChemicalID, 'CPBȾ��']), []) then
      Exit
    //����Ⱦ��ʱ��ʾ����Ⱦ��
    else
    begin
      btnCalc.Click;
    end;
end;

procedure TCPBFormatForm.vleChemicallistDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  i,j:Integer;
  CellText,Chemical_ID:String;
begin
  inherited;
  with Sender as TCustomDrawGrid do
  begin
    if vleChemicallist.RowCount>2 then
    begin
      for i := 1 to vleChemicallist.RowCount-1 do
      begin
        Chemical_ID := IntTostr(Integer(vleChemicallist.Strings.Objects[i-1]));
        if (Chemical_ID<>'') and (not Dictionary.cds_CPBChemical.Locate('Chemical_ID;Chemical_Type',VarArrayOf([Chemical_ID, 'CPBȾ��']), [])) then
        begin
          for j:=0 to 1 do
          begin
            Rect:= CellRect(j,i);
            //Canvas.Brush.Color := clBtnFace;
            //Canvas.FillRect(Rect);
            Canvas.Font.Color := clSilver;
            CellText := vleChemicallist.Cells[j, i];
            Canvas.TextRect(Rect, Rect.Left+2, Rect.Top+2, CellText);
          end;
        end;
      end;
    end;
  end;
end;

procedure TCPBFormatForm.vlePDParamGetPickList(Sender: TObject;
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
{ //2010-9-9
  if KeyName='�����ʽ' then
     Values.Text := '΢�����' + #13 + '���ô��'+ #13 + '������'
  else if KeyName='��ɫʱ��' then
     Values.Text := '18' + #13 + '24'
  else if KeyName='����|ʱ��(h)' then
     Values.Text := '18' + #13 + '24'
  else if KeyName='ˮϴ|��ϴ��(g/l)' then
     Values.Text := '0' + #13 + '1' + #13 + '2'
  else if KeyName='Ⱦɫ|����(m/min)' then
     Values.Text := '30' + #13 + '40' + #13 + '50';
}
//  if (KeyName= '�����ʽ') or (KeyName='��ɫʱ��') or (KeyName='����|ʱ��(h)')
//    or (KeyName= 'ˮϴ|��ϴ��(g/l)') or (KeyName= 'Ⱦɫ|����(m/min)') then


  //--Content:��ɫ������΢�����̶�5min�����䷨�̶�2H�����÷�18H��24H     Reason:    Added By Danny at 2015-02-11 22:43:20:405
//  if Values.Text= '' then
//    Values.Text := Dictionary.GetItemList('CPB'+KeyName,Login.CurrentDepartment,'');

  if Values.Text='' then
  begin
    if KeyName='��ɫ����' then
      Values.Text:='΢����'#13'���䷨'#13'���÷�'
    else if (KeyName='����|ʱ��(h)') and (GetKeyValue('��ɫ����')='���÷�') then
      Values.Text:='18H'#13'24H'
    else
      Values.Text := Dictionary.GetItemList('CPB'+KeyName,Login.CurrentDepartment,'');
  end;
end;

procedure TCPBFormatForm.cbViewChemicalClick(Sender: TObject);
begin
  inherited;
  gbChemicalList.Visible := cbViewChemical.Checked
end;

procedure TCPBFormatForm.btnAddGFNOClick(Sender: TObject);
begin
  inherited;
  if Trim(edtAddGFNO.Text) = '' then Exit;
  FillFNCard(edtAddGFNO.Text,edtFNColorCode.Text);
end;

procedure TCPBFormatForm.btnAddRatioClick(Sender: TObject);
begin
  inherited;
  CalcAddRatio;
end;

procedure TCPBFormatForm.edtRatioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = 38 then
    SendMessage(TWinControl(vleChemicallist).Handle, WM_KEYDOWN, VK_UP, 0);
  if key = 40 then
    SendMessage(TWinControl(vleChemicallist).Handle, WM_KEYDOWN, VK_DOWN, 0);
  if key = 13 then
    btnAddRatio.Click;
end;

procedure TCPBFormatForm.SetiType(const Value: Integer);
begin
  FiType := Value;
  if FiType= 4 then
  begin
    Label2.Visible:=True;
    edtRecipeNO.Visible:=True;
    Label6.Visible:=False;
    edtCPBGFNO.Visible:=False;
    Label5.Visible:=False;
    edtLBNO.Visible:=False;
    Label9.Visible:=False;
    edtFabColorName.Visible:=False;
    Label3.Visible:=False;
    edtPatternName.Visible:=False;
    Label8.Visible:=False;
    edtFNColorCode.Visible:=False;
    Label11.Visible:=False;
    edtStyleName.Visible:=False;
    lbl2.Visible:=False;
    edtLaunchTime.Visible:=false;
    Label4.Visible:=True;
    cbShade.Visible:=True;
    Label7.Visible:=False;
    edtQuantity.Visible:=False;
    lbl1.Visible:=False;
    edtFinishMethod.Visible:=False;
    Panel1.Width:=plShowColor.Width+ 30;

    Label4.Left:= Label5.Left;
    Label4.Top := Label5.Top;
    cbShade.Left:= edtLBNO.Left;
    cbShade.Top:= edtLBNO.Top;
    lblFNColorCode.Top:=Label3.Top;
    lblFNColorCode.Left:=Label3.Left;
    plShowColor.Left:=lblFNColorCode.Left;
    plShowColor.Top:=lblFNColorCode.Top+lblFNColorCode.Height+4;
    Label14.Visible:= iType = 5;
    if Label14.Visible then
    begin
      Label15.Visible:= Label14.Visible;
      Label16.Visible:= Label14.Visible;
      edtJG.Parent:=Panel1;
      edtKH.Parent:=Panel1;
      edtJQ.Parent:=Panel1;
      edtJG.Width:= 130;
      edtKH.Width:= edtJG.Width;
      edtJQ.Width:= edtJG.Width;

      edtJG.Visible:= Label14.Visible;
      edtKH.Visible:= Label14.Visible;
      edtJQ.Visible:= Label14.Visible;
      Label14.Left:= 9;
      Label14.Top:= 6+(21*0);
      edtJG.Left:= 69;
      edtJG.Top:= 5;

      Label15.Left:= 9;
      Label15.Top:= 6+(21*1);
      edtKH.Left:= 69;
      edtKH.Top:= 25;

      Label16.Left:= 9;
      Label16.Top:= 6+(21*2);
      edtJQ.Left:= 69;
      edtJQ.Top:= 45;
      lblFNColorCode.Top:= Label16.Top + Label16.Height + 10;
      lblFNColorCode.Left:= Label16.Left;
      plShowColor.Left:=lblFNColorCode.Left;
      plShowColor.Top:=lblFNColorCode.Top+lblFNColorCode.Height+10;
    end;
  end;
  if FiType=5 then
  begin
    //--Content:��3������ RGB��Ϣ��������䷽��Ҫ��Ϣɾ��    Reason:    Added By Danny at 2015-02-11 20:32:05:692
    Label2.Visible:=True;
    edtRecipeNO.Visible:=True;
    Label6.Visible:=False;
    edtCPBGFNO.Visible:=False;
    Label5.Visible:=False;
    edtLBNO.Visible:=False;
    Label9.Visible:=False;
    edtFabColorName.Visible:=False;
    Label3.Visible:=False;
    edtPatternName.Visible:=False;
    Label8.Visible:=False;
    edtFNColorCode.Visible:=False;
    Label11.Visible:=False;
    edtStyleName.Visible:=False;
    lbl2.Visible:=False;
    edtLaunchTime.Visible:=false;
    Label4.Visible:=True;
    cbShade.Visible:=True;
    Label7.Visible:=False;
    edtQuantity.Visible:=False;
    lbl1.Visible:=False;
    edtFinishMethod.Visible:=False;
    
    Label4.Left:= Label5.Left;
    Label4.Top := Label5.Top;
    cbShade.Left:= edtLBNO.Left;
    cbShade.Top:= edtLBNO.Top;
    Label14.Visible:= iType = 5;
    if Label14.Visible then
    begin
      Label15.Visible:= Label14.Visible;
      Label16.Visible:= Label14.Visible;
      edtJG.Parent:=Panel1;
      edtKH.Parent:=Panel1;
      edtJQ.Parent:=Panel1;
      edtJG.Width:= 130;
      edtKH.Width:= edtJG.Width;
      edtJQ.Width:= edtJG.Width;

      edtJG.Visible:= Label14.Visible;
      edtKH.Visible:= Label14.Visible;
      edtJQ.Visible:= Label14.Visible;
      Label14.Left:= 9;
      Label14.Top:= 6+(21*2);
      edtJG.Left:= 69;
      edtJG.Top:= 6+(21*2);

      Label15.Left:= 9;
      Label15.Top:= 6+(21*3);
      edtKH.Left:= 69;
      edtKH.Top:= 6+(21*3);

      Label16.Left:= 9;
      Label16.Top:= 6+(21*4);
      edtJQ.Left:= 69;
      edtJQ.Top:= 6+(21*4);
      lblFNColorCode.Top:= Label6.Top;
      lblFNColorCode.Left:= Label6.Left;
      plShowColor.Left:=lblFNColorCode.Left;
      plShowColor.Top:=lblFNColorCode.Top+lblFNColorCode.Height+10;
      Panel1.Width:= plShowColor.Left + plShowColor.Width + 30;
    end;
  end;
end;

procedure TCPBFormatForm.popMChemicalN1Click(Sender: TObject);
begin
  inherited;
  AddChemical(878);
end;

procedure TCPBFormatForm.popMChemicalN2Click(Sender: TObject);
begin
  inherited;
  AddChemical(879);
end;

{-------------------------------------------------------------------------------
  ������:    TCPBRecipeForm.AddChemical
  ����:      Danny duda
  ����:      2015.02.04 10:57:01
  ����:      Chimcal_ID: Integer ����ID
  ����ֵ:    ��
  ����:      �ֹ����ӻ��ϣ���Ҫ��878	CPB����	ˮ������37-40Be) 879	CPB����	NaOH 50%
  �޸�����:
-------------------------------------------------------------------------------}
procedure TCPBFormatForm.AddChemical(Chemical_ID: Integer);
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
      Chimcal_Text:='ˮ������37-40Be)';
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


{-------------------------------------------------------------------------------
  ������:    TCPBRecipeForm.CheckChemicalQty
  ����:      Danny duda
  ����:      2015.02.04 11:42:18
  ����:      ��
  ����ֵ:    ��
  ����:      ǰ���䷽��������10��������ʱϵͳ��ʾȷ�ϣ�
  �޸�����:
-------------------------------------------------------------------------------}
function TCPBFormatForm.CheckChemicalQty:Boolean;
var i:Word;
    Chemical_ID:Integer;
    qty, qty1:Double;
    cds:TClientDataSet;
    msg:String;
    Multiple,Multiple1,Multiple2,MultipleTemp:Double;//����
begin
  if iType=5 then
    Multiple:=10
  else if iType=4 then
    Multiple:=10
  else
    Multiple:=0.5;

  Result:=True;
  cds:= TClientDataSet.Create(nil);
  try
    cds.Data:=TClientDataSet(cxGridTVCPBDtl.DataController.DataSource.DataSet).Data;
    cds.DisableControls;
    msg:='';
    if iType = 4 then
    begin
      if (cxGridTVCPBDtl.ColumnCount<=5)  then  Exit;
    end;
    
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
              Multiple1:= qty/qty1  + 0.000001;
              Multiple2:= qty1/qty  + 0.000001;
              
              if (qty=0) or (qty1=0) or (Multiple1>Multiple) or (Multiple2>Multiple) then
              begin
                msg:=msg+ifthen(msg='', '', Char(13))+cds.fieldByName('Chemical_Name').AsString;
              end;
            end;
          end;
          cds.Next;
        end;
      end;
    cds.EnableControls;
  finally
    cds.Free;
  end;
  if msg<>'' then
  begin
    msg:='���»��Ϻ�ǰ���䷽�Աȳ���'+FloatToStr(Multiple)+'��'+char(13)+msg+char(13)+'�Ƿ��������?';
    Result:=TMsgDialog.ShowMsgDialog(msg,mtConfirmation, [mebYes, mebNo], mebYes)= mrYes;
  end;
end;

{-------------------------------------------------------------------------------
  ������:    TCPBFormatForm.SetTaskReadOnly
  ����:      Danny duda
  ����:      2015.02.12 00:05:52
  ����:      
  ����ֵ:    ��
  ����:      ����������ֻ��ѡ���ܱ༭
  �޸�����:
-------------------------------------------------------------------------------}
procedure TCPBFormatForm.SetTaskReadOnly();
var i:Word;
dbCol:TcxGridDBColumn;
begin
  dbCol:=nil;
  for i:=0 to cxgdTVTask.ColumnCount-1 do
  begin
    if i=0 then dbCol:= cxgdTVTask.Columns[i];
    cxgdTVTask.Columns[i].Options.Editing:=False;
  end;
  if dbCol<>nil then
  begin
    if iType=4 then
      dbCol.Options.Editing:=True
    else
      dbCol.Visible:=False;
  end;
end;

{-------------------------------------------------------------------------------
  ������:    TCPBFormatForm.GetSelectGFNO
  ����:      Danny duda
  ����:      2015.02.12 10:10:57
  ����:      ��
  ����ֵ:    string
  ����:      ��ȡ��ѡ���Ʒ��
  �޸�����:
-------------------------------------------------------------------------------}
function TCPBFormatForm.GetSelectGFNO: TStrings;
var bk: TBookmark;
    defaultGFNO:string;
    defaultGFNOSelect:Boolean;//�����ǰƷ��û��ѡ���򲻴����Ʒ��ͬ������
    Lists: TStringList;
begin
  Result:= nil;
  Lists:= TStringList.Create;
  try
    bk:=nil;
    defaultGFNO:=edtGFNO.Text;
    defaultGFNOSelect:=False;
    Lists.Add(defaultGFNO);
    if not cdsTask.IsEmpty then
    begin
      try
        try
          cdsTask.DisableControls;
          bk:=cdsTask.GetBookmark;
          cdsTask.First;
          while not cdsTask.Eof do
          begin
            if cdsTask.FieldByName('ѡ��').AsBoolean then
            begin
              if (cdsTask.FieldByName('GF_NO').asstring=defaultGFNO) then
                defaultGFNOSelect:=True
              else
                Lists.Add(cdsTask.FieldByName('GF_NO').asstring);//Result:=Result+ifthen(Result='', '', ',')+dsTask.FieldByName('GF_NO').asstring;
            end;
          end;
            if not defaultGFNOSelect then
              Lists.Clear;
        except
          on e:Exception do
          begin
            Lists.Clear;
          end;
        end;
      finally
        cdsTask.EnableControls;
        if bk<>nil then
        begin
          cdsTask.GotoBookmark(bk);
          cdsTask.FreeBookmark(bk);
        end;
      end;
    end;
    Result:=Lists;
  finally
  end;
end;

Function CoCreateGuid(out guid: TGUID): HResult; stdcall; external 'ole32.dll' name 'CoCreateGuid';
Function TCPBFormatForm.GetGUID():String;
var tmp_guid:TGUID;
begin
  Result:='';
  if CoCreateGuid(tmp_guid)=S_OK then
    Result:=GUIDToString(tmp_guid);
end;

procedure TCPBFormatForm.vlePDParamStringsChange(Sender: TObject);
begin
  inherited;
  vlePDParam.Invalidate;
  if  (oldStrings <> vlePDParam.Cells[1,1]) then
  begin
    if vlePDParam.Cells[1,1] = '΢����' then
    begin
      oldStrings := vlePDParam.Cells[1,1];
      vlePDParam.Cells[1,2] := '5Min';
    end;
    if vlePDParam.Cells[1,1] = '���䷨' then
    begin
      oldStrings := vlePDParam.Cells[1,1];
      vlePDParam.Cells[1,2] := '2H';
    end;
    if vlePDParam.Cells[1,1] = '���÷�' then
    begin
      oldStrings := vlePDParam.Cells[1,1];
      vlePDParam.Cells[1,2] := '18H';
    end;
  end;
end;

procedure TCPBFormatForm.FillData(GF_NO: String);
var vData: OleVariant;
    sCondition: string;
    sErrorMsg: WideString;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('���ڻ�ȡ�����Եȣ�',crHourGlass);
    sCondition := '';
    FNMServerObj.GetQueryData(vData,'CPBWIP',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TempClientDataSet.Data := vData;
    with TempClientDataSet do
    begin
      edtJG.Clear;
      edtKH.Clear;
      edtJQ.Clear;
      if Locate('Ʒ��',GF_NO,[]) then
      begin
        edtJG.Text:= FieldByName('�ṹ').AsString;
        edtKH.Text:= FieldByName('�ͻ�').AsString;
        edtJQ.Text:= FieldByName('����').AsString;
      end;
    end;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCPBFormatForm.cbbHistoryRecipeClick(Sender: TObject);
begin
  inherited;
  cbbHistoryRecipe.Text:= cbbHistoryRecipe.SelText;
end;

procedure TCPBFormatForm.GetHistoryRecipe(GF_NO: string);
var
  sCondition: String;
  sErrorMsg: WideString;
  vData: OleVariant;
  iCount: Integer;
begin
  sCondition := QuotedStr(GF_NO);
  FNMServerObj.GetQueryData(vData,'GetHistoryRecipe',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  cdsHistoryRecipe.Data := vData;
  if not cdsHistoryRecipe.IsEmpty then
  begin
    iCount:=0;
    cbbHistoryRecipe.Items.Clear;
    cdsHistoryRecipe.First;
    while not cdsHistoryRecipe.Eof do
    begin
      inc(iCount);
      if iCount <= 10 then
      begin
        cbbHistoryRecipe.Items.Add(cdsHistoryRecipe.FieldByName('Recipe_NO').AsString);
        cdsHistoryRecipe.Next;
      end
      else
      Break;
    end;
  end;
end;

procedure TCPBFormatForm.lvFNCardClick(Sender: TObject);
var
  fQuantity: Double;
  i: Integer;
begin
  inherited;
  fQuantity:=0;
  for i:= 0 to lvFNCard.Items.Count -1  do
  begin
    if lvFNCard.Items[i].Checked then
    begin
      fQuantity:= fQuantity + StrToFloatDef(lvFNCard.Items[i].SubItems.Strings[0],0);
    end;
  end;
  lblMC.Caption:= 'Ⱦɫ�볤:' + FloatToStr(fQuantity);
end;

end.
