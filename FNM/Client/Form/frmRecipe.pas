unit frmRecipe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, Buttons, ComCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, ExtCtrls, cxSplitter, DB,
  DBClient, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Menus,
  Grids, ValEdit;

type
  TRecipeForm = class(TBaseForm)
    pgcRecipe: TPageControl;
    ts_Only: TTabSheet;
    cxbeGFKey: TcxButtonEdit;
    cbbOnlineOperation: TComboBox;
    GroupBox2: TGroupBox;
    lstUncheck: TListBox;
    tvOnline: TTreeView;
    Label1: TLabel;
    btnCheck: TSpeedButton;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    btnDeletet: TSpeedButton;
    btnRefresh: TSpeedButton;
    cxspl_Only: TcxSplitter;
    pnl_Only: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    cbbFloodPercent: TComboBox;
    cbbFloodClass: TComboBox;
    cbbMachineID: TComboBox;
    cbbSampleType: TComboBox;
    cbTrace: TCheckBox;
    edtRecipeNO: TEdit;
    edtOperationName: TEdit;
    edtOperator: TEdit;
    edtOperateTime: TEdit;
    edtChecker: TEdit;
    edtCheckTime: TEdit;
    cdsCards: TClientDataSet;
    Label13: TLabel;
    edtCurVolume: TEdit;
    Splitter1: TSplitter;
    PopupMenu1: TPopupMenu;
    NAddTry: TMenuItem;
    NDiluteTry: TMenuItem;
    grp1: TGroupBox;
    lvIncludeCard: TListView;
    chkAll: TCheckBox;
    pnlClient: TPanel;
    grp_Only: TGroupBox;
    mmoRemark: TMemo;
    GroupBox1: TGroupBox;
    tvChemical: TTreeView;
    btnAdd: TSpeedButton;
    btnDel: TSpeedButton;
    cxSplitter1: TcxSplitter;
    vleChemicallist: TValueListEditor;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure btnDeletetClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cxbeGFKeyPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cbbOnlineOperationKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lstUncheckKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAddClick(Sender: TObject);
    procedure tvOnlineKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDelClick(Sender: TObject);
    procedure NAddTryClick(Sender: TObject);
    procedure NDiluteTryClick(Sender: TObject);
    procedure ChangeValues(Sender: TObject);
    procedure cbTraceClick(Sender: TObject);
    procedure chkAllClick(Sender: TObject);
    procedure tvChemicalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pgcRecipeChange(Sender: TObject);
  private
    { Private declarations }
    Modify:  Boolean;
    procedure GenerateSubRecipe(aType: string);
    procedure GetRecipeCardInfo;
    procedure Refresh;
    procedure FillCards(cdsCards: TClientDataSet);
    procedure GetRecipeInfo(Recipe_NO: string);
    function SaveRecipeInfo(Checker: string;IType: Integer): string;
    function CheckChemmicalData(var AChemicalStr: string; var AUnitQtyStr: string): Boolean;
  protected
    procedure UpdateActions; override;
  public
    { Public declarations }
  end;

var
  RecipeForm: TRecipeForm;

implementation

uses StrUtils, Math,  ServerDllPub, uLogin, uFNMArtInfo, uGridDecorator,
  UAppOption, uShowMessage, uCADInfo, UFNMResource, uDictionary, uGlobal,
  frmSubRecipe;

{$R *.dfm}
function TRecipeForm.CheckChemmicalData(var AChemicalStr: string; var AUnitQtyStr: string): Boolean;
var i: Integer;
begin
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

procedure TRecipeForm.GenerateSubRecipe(aType: string);
var
  i:Integer;
  Recipe_NO: string;
  Node: TTreeNode;
  sCondition,SubRecipeNO,sErrorMsg: widestring;
begin
  if tvOnline.Selected = nil then Exit;
  Recipe_NO := tvOnline.Selected.Text;
  if tvOnline.Selected.HasChildren then
    Node := tvOnline.Selected
  else
    Node := tvOnline.Selected.Parent;

  if Recipe_NO <> edtRecipeNO.Text then  GetRecipeInfo(Recipe_NO);
  if vleChemicallist.Strings.Text = '' then Exit;

  if not Assigned(SubRecipeForm) then
    SubRecipeForm:= TSubRecipeForm.Create(Self);
  with SubRecipeForm do
  begin
    sType := aType;
    if aType = '冲稀' then
    begin
      Caption := '化料冲稀';
      if vleChemicallist.Strings.Text <> '' then
        for i := 1 to vleChemicallist.RowCount - 1 do
          clbChemicalList.Items.AddObject(vleChemicallist.Keys[i] + ':'+StringOfChar(' ', 20 - Length(vleChemicallist.Keys[i]))+ vleChemicallist.Values[vleChemicallist.Keys[i]],vleChemicallist.Strings.Objects[i-1]);
      gbDilute.BringToFront;
    end else
    begin
      Caption := '化料加料';
      if vleChemicallist.Strings.Text <> '' then
        for i := 1 to vleChemicallist.RowCount - 1 do
          SubChemicallist.Strings.AddObject(vleChemicallist.Keys[i] + ':'+StringOfChar(' ', 25 - Length(vleChemicallist.Keys[i]))+ vleChemicallist.Values[vleChemicallist.Keys[i]]+'='+vleChemicallist.Values[vleChemicallist.Keys[i]],vleChemicallist.Strings.Objects[i-1]);
      gbAdd.BringToFront;
    end;
    if ShowModal = mrOK then
    begin
      if (ChemicalStr <>'') and (UnitQtyStr <>'') then
      begin
        sCondition := QuotedStr(aType)+','+QuotedStr(Recipe_NO)+','+
                      QuotedStr(ChemicalStr)+','+ QuotedStr(UnitQtyStr)+','+
                      QuotedStr(edtCurVolume.Text)+','+QuotedStr(Login.LoginID);
        FNMServerObj.SaveDataBySQLEx('RCPCreateSubRecipeInfo',sCondition,SubRecipeNO,sErrorMsg);
        if sErrorMsg <> '' then
          raise ExceptionEx.CreateResFmt(@ERR_SaveAssiPrescription, [sErrorMsg]);
        ShowMsgDialog(@MSG_SaveRecipeSuccess, mtInformation);
        tvOnline.Items.AddChild(Node,SubRecipeNO);
        Node.Expand(True);
        GetRecipeInfo(SubRecipeNO);
      end;
    end;
  end;
end;

procedure TRecipeForm.FillCards(cdsCards: TClientDataSet);
begin
  if not cdsCards.Active then Exit;
  lvIncludeCard.Items.BeginUpdate;
  lvIncludeCard.Items.Clear;
  with cdsCards do
  begin
    DisableControls;
    First;
    while not Eof do
    begin
      with lvIncludeCard.Items.Add do
      begin
        Caption := Trim(FieldByName('FN_Card').AsString);
        SubItems.Add(Trim(FieldByName('GF_NO').AsString));
        SubItems.Add(Trim(FieldByName('Quantity').AsString));
        Checked := True;
      end;
      Next;
    end;
    EnableControls;
  end;
  lvIncludeCard.Items.EndUpdate;
end;

function TRecipeForm.SaveRecipeInfo(Checker: string;iType: Integer): string;
var
  ChemicalStr,  UnitQtyStr,  FNCardStr: string;
  i: Integer;
  sCondition,Recipe_NO,sErrorMsg: widestring;
begin
  ChemicalStr := '';
  UnitQtyStr := '';
  if not CheckChemmicalData(ChemicalStr,UnitQtyStr) then Exit;

  FNCardStr := '';
  for i := 0 to lvIncludeCard.Items.Count - 1 do
    if lvIncludeCard.Items[i].Checked then
       FNCardStr := FNCardStr + lvIncludeCard.Items[i].Caption + ',';
  if FNCardStr = '' then Exit;

  sCondition := QuotedStr(edtRecipeNO.Text)+','+QuotedStr(edtOperationName.Hint)+','+
                QuotedStr(LeftStr(cbbMachineID.Text,4))+',0,0'+','+QuotedStr(cbbFloodClass.Text)+','+
                QuotedStr(cbbFloodPercent.Text)+','+QuotedStr(IntToStr(cbbSampleType.ItemIndex))+','+
                QuotedStr(ifThen(cbTrace.Checked,'1','0'))+','+QuotedStr(mmoRemark.Text)+','+
                QuotedStr(ChemicalStr)+','+ QuotedStr(UnitQtyStr)+','+QuotedStr(FNCardStr)+','+
                QuotedStr(Login.CurrentDepartment)+','+QuotedStr(Login.LoginID)+','+
                QuotedStr(Checker)+','+ IntToStr(iType);

  FNMServerObj.SaveDataBySQLEx('RCPSaveRecipeInfo',sCondition,Recipe_NO,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveAssiPrescription, [sErrorMsg]);
  ShowMsgDialog(@MSG_SaveRecipeSuccess, mtInformation);
  result := Recipe_NO;
end;

procedure TRecipeForm.GetRecipeCardInfo;
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  if Trim(cxbeGFKey.Text) = '' then exit;

  sCondition := QuotedStr('') + ','+ QuotedStr(cxbeGFKey.Text) + ','+
                QuotedStr('') + ','+  QuotedStr('') + ','+
                QuotedStr('') + ','+ QuotedStr(Login.CurrentDepartment) + ',2';
  FNMServerObj.GetQueryData(vData,'RCPGetRecipeCardInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
     raise ExceptionEx.CreateResFmt(@ERR_GetOnlineStdPrescripNO, [sErrorMsg]);

  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetOnLineOperationList, [(cxbeGFKey.Text), sErrorMsg]);
  cdsCards.Data:=vData;

  if cdsCards.IsEmpty then
    raise Exception.CreateResFmt(@ERR_OnLineOperationList, [(cxbeGFKey.Text)]);

  cxbeGFKey.Text:=cdsCards['GF_NO'];
  cxbeGFKey.Tag:=cdsCards['GF_ID'];
  FillItemsFromDataSet(cdsCards, 'Operation_Code', 'Operation_Name', '', '--', cbbOnLineOperation.Items);
end;

procedure TRecipeForm.GetRecipeInfo(Recipe_NO: string);
var
  sCondition,sErrorMsg: WideString;
  vData: OleVariant;
begin
  sCondition := QuotedStr(Recipe_NO);
  FNMServerObj.GetQueryData(vData,'RCPGetRecipeInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@GetAssiPrescriptionError, [sErrorMsg]);

  TempClientDataSet.Data := vData[0];
  with TempClientDataSet do
  begin
    FillMachineListByOperationCode(Login.CurrentDepartment,FieldByName('Operation_Code').AsString, cbbMachineID.Items);
    TGlobal.SetComboBoxValue(cbbMachineID,    Trim(FieldByName('Machine_ID').AsString));
    TGlobal.SetComboBoxValue(cbbFloodClass,   Trim(FieldByName('Flood_Class').AsString));
    TGlobal.SetComboBoxValue(cbbFloodPercent, Trim(FieldByName('Flood_Percent').AsString));
    TGlobal.SetComboBoxValue(cbbSampleType,   Trim(FieldByName('Sample_Type').AsString));
    edtRecipeNO.Text := FieldByName('Recipe_NO').AsString;
    edtCurVolume.Text := FieldByName('Fact_Volume').AsString;
    edtOperationName.Text :=FieldByName('Operation_CHN').AsString;
    edtOperationName.Hint :=FieldByName('Operation_Code').AsString;
    edtOperator.Text:=FieldByName('Operator').AsString;
    edtOperateTime.Text:=FieldByName('Operate_Time').AsString;
    edtChecker.Text:=FieldByName('Checker').AsString;
    edtCheckTime.Text:=FieldByName('Check_Time').AsString;
    mmoRemark.Text:=FieldByName('Remark').AsString;
  end;
  //填充具体化工料
  TempClientDataSet.Data := vData[1];
  FillItemsFromDataSet(TempClientDataSet, 'Chemical_Name', 'Unit_QTY', 'Chemical_ID', '=', vleChemicallist.Strings);
  //填充卡号
  TempClientDataSet.Data := vData[2];
  FillCards(TempClientDataSet);
end;

procedure TRecipeForm.UpdateActions;
begin
  btnAdd.Enabled := pgcRecipe.ActivePageIndex = 0;
  btnDel.Enabled := pgcRecipe.ActivePageIndex = 0;
  btnSave.Enabled := pgcRecipe.ActivePageIndex = 0;
  btnCheck.Enabled := (pgcRecipe.ActivePageIndex = 0) AND (edtRecipeNO.Text<>'');
  btnDeletet.Enabled := (pgcRecipe.ActivePageIndex = 0) AND (edtRecipeNO.Text<>'');

  if pgcRecipe.ActivePageIndex = 0 then
     vleChemicallist.Options:=vleChemicallist.Options + [goEditing]
  else
     vleChemicallist.Options:=vleChemicallist.Options - [goEditing];
  lvIncludeCard.Enabled := pgcRecipe.ActivePageIndex = 0;
  mmoRemark.ReadOnly := pgcRecipe.ActivePageIndex = 1;
end;

procedure TRecipeForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:=caFree;
end;

procedure TRecipeForm.FormCreate(Sender: TObject);
begin
  inherited;
 //加载图标
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnAdd.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnDel.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  cxbeGFKey.Properties.Buttons.Items[0].Glyph.LoadFromResourceName(HInstance, RES_QUERYSMALL);

  pgcRecipe.ActivePageIndex:=0;
  tvChemical.OnDblClick:=TGlobal.DblClickATreeview;
  tvOnline.OnDblClick:=TGlobal.DblClickATreeview;
  cbbOnlineOperation.OnDblClick:=TGlobal.DblClickAWinControl;
  lstUncheck.OnDblClick:=TGlobal.DblClickAWinControl;
  cbbOnLineOperation.Align:=alClient;
  pgcRecipe.ActivePageIndex := 0;
  Modify := False;
end;

procedure TRecipeForm.FormDestroy(Sender: TObject);
begin
  inherited;
  RecipeForm:=nil;
end;

procedure TRecipeForm.FormActivate(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
  //填充可选化工料
  FillTreeItemsFromDataSetByClassField(Dictionary.cds_ChemicalList, 'Chemical_Name', 'Chemical_Type', 'Chemical_ID', '', tvChemical.Items);
  OnActivate:=nil;
end;

procedure TRecipeForm.btnRefreshClick(Sender: TObject);
begin
  Refresh;
end;
procedure TRecipeForm.Refresh;
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  if pgcRecipe.ActivePageIndex = 0 then
    sCondition := QuotedStr(Login.CurrentDepartment)+',0'
  else
    sCondition := QuotedStr(Login.CurrentDepartment)+',4';

  FNMServerObj.GetQueryData(vData, 'RCPGetRecipeTaskInfo', sCondition, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetNoCheckRecipe, [sErrorMsg]);

  TempClientDataSet.Data:=vData;
  if TempClientDataSet.IsEmpty then
    raise Exception.CreateRes(@EMP_NoCheckRecipe);

  if pgcRecipe.ActivePageIndex = 0 then
    FillItemsFromDataSet(TempClientDataSet, 'Recipe_NO', '', '', '', lstUncheck.Items, False, True, True)
  else
  begin
    tvOnline.Items.Clear;
    FillTreeItemsFromDataSetByClassField(TempClientDataSet, 'Recipe_NO', 'Recipe_Type', '', '', tvOnline.Items);
  end;
end;

procedure TRecipeForm.btnCheckClick(Sender: TObject);
var
  Recipe_NO: widestring;
begin
  inherited;
  if Modify then
    Recipe_NO := SaveRecipeInfo(Login.LoginID,1) // check配方时更改了配方
  else
    Recipe_NO := SaveRecipeInfo(Login.LoginID,2);//直接check配方

  if lstUncheck.Items.IndexOf(Recipe_NO) > 0 then
    lstUncheck.Items.Delete(lstUncheck.Items.IndexOf(Recipe_NO));
  ShowMsgDialog(@MSG_SaveCheckPrescriptionSuccess, mtInformation);
end;

procedure TRecipeForm.btnDeletetClick(Sender: TObject);
var
  sCondition,sErrorMsg: WideString;
begin
  if edtRecipeNO.Text = '' then Exit;
  sCondition := QuotedStr(edtRecipeNO.Text)+ ','+ QuotedStr(Login.LoginName)+','+QuotedStr('1');
  FNMServerObj.SaveDataBySQL('RCPDeleteRecipeInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveDelRecipe, [sErrorMsg]);

  ShowMsgDialog(@MSG_SaveDelRecipeSuccess, mtInformation);
end;

procedure TRecipeForm.btnSaveClick(Sender: TObject);
var
  Recipe_NO: string;
begin
  inherited;
  Recipe_NO := SaveRecipeInfo('',0);  //新建工艺
  if pgcRecipe.ActivePageIndex = 0 then
  begin
    if lstUncheck.Items.IndexOf(Recipe_NO) = -1 then
       lstUncheck.Items.Add(Recipe_NO);
  end;
end;

procedure TRecipeForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TRecipeForm.cxbeGFKeyPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  GetRecipeCardInfo;
end;

procedure TRecipeForm.cbbOnlineOperationKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  Operation_Code: string;
begin
  inherited;
  if Key =  VK_RETURN then
  begin
    if cbbOnlineOperation.ItemIndex  = -1 then exit;
    Operation_Code := LeftStr(cbbOnlineOperation.Text, 3);
    FillMachineListByOperationCode(Login.CurrentDepartment, Operation_Code, cbbMachineID.Items);
    cdsCards.Filtered := False;
    cdsCards.Filter := 'Operation_Code = ' +  QuotedStr(Operation_Code);
    cdsCards.Filtered := True;
    FillCards(cdsCards);
  end;
end;

procedure TRecipeForm.lstUncheckKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key =  VK_RETURN then
  begin
    if lstUncheck.ItemIndex = -1 then Exit;
    GetRecipeInfo(lstUncheck.Items[lstUncheck.ItemIndex]);
  end;
end;

procedure TRecipeForm.btnAddClick(Sender: TObject);
var
  Chemical_ID: Integer;
begin
  inherited;
  if (tvChemical.Selected = nil) or (tvChemical.Selected.Level = 0) then exit;
  Chemical_ID:=Integer(tvChemical.Selected.Data);
  if vleChemicallist.Strings.IndexOfObject(TObject(Chemical_ID)) = -1 then
     if vleChemicallist.RowCount = 2 then
       vleChemicallist.Strings.AddObject(tvChemical.Selected.Text + '=0.00', TObject(Chemical_ID))
     else
       vleChemicallist.Strings.InsertObject(vleChemicallist.Row, tvChemical.Selected.Text + '=0.00', TObject(Chemical_ID));
end;

procedure TRecipeForm.tvOnlineKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    if tvOnline.Selected = nil then Exit;
    GetRecipeInfo(tvOnline.Selected.Text);
  end;
end;

procedure TRecipeForm.btnDelClick(Sender: TObject);
begin
  inherited;
  if vleChemicallist.Strings.Text <> '' then
    vleChemicallist.DeleteRow(vleChemicallist.Row);
end;

procedure TRecipeForm.NAddTryClick(Sender: TObject);
begin
  inherited;
  GenerateSubRecipe('加料');
end;

procedure TRecipeForm.NDiluteTryClick(Sender: TObject);
begin
  inherited;
  GenerateSubRecipe('冲稀');
end;

procedure TRecipeForm.ChangeValues(Sender: TObject);
begin
  Modify := True;
end;

procedure TRecipeForm.cbTraceClick(Sender: TObject);
begin
  inherited;
  Modify := True;
end;

procedure TRecipeForm.chkAllClick(Sender: TObject);
var
  i: Integer;
begin
  with lvIncludeCard.Items do
  for i := 0 to Count - 1 do
    Item[i].Checked := chkAll.Checked;;
end;

procedure TRecipeForm.tvChemicalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) and (pgcRecipe.ActivePageIndex = 0) then
     btnAdd.Click;
end;

procedure TRecipeForm.pgcRecipeChange(Sender: TObject);
begin
  inherited;
  vleChemicallist.Strings.Clear;
  lvIncludeCard.Clear;
  mmoRemark.Lines.Clear;
  if tvOnline.Items.Count = 0 then
    Refresh;
end;

end.
