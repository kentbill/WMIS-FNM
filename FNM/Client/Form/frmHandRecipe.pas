unit frmHandRecipe;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmAssiPrescription.pas                                       }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 Lvzd                                                          }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  开标准处方单                                                 }
{                                                                              }
{******************************************************************************}

interface

uses
  uFNMArtInfo, uFNMPrescriptionInfo, Windows, Messages, SysUtils,
  Classes, Graphics, Forms, StdCtrls, cxSplitter, ComCtrls, Controls,
  cxButtonEdit, Grids, ValEdit, Buttons, ExtCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit, DB, DBClient, ADODB;

type
  THandRecipeForm = class(TForm)
    btn_Add_Chemical: TSpeedButton;
    btn_Del_Chemical: TSpeedButton;
    cbb_FloodPercent: TComboBox;
    cxbe_GF_KeyValue: TcxButtonEdit;
    cxSE_Dry_Temperature: TcxSpinEdit;
    cxSE_Pre_Dry_Temperature: TcxSpinEdit;
    cxspl_Only: TcxSplitter;
    pgc_HandRecipe: TPageControl;
    pnl_Only: TPanel;
    pnl_Only1: TPanel;
    spl1: TSplitter;
    ts_Only: TTabSheet;
    tv_Chemical_Name: TTreeView;
    cbb_FloodClass: TComboBox;
    pnl2: TPanel;
    spl2: TSplitter;
    btn_RefrshNoCheckList: TSpeedButton;
    cbb_OnLineOperation: TComboBox;
    txt_Only: TStaticText;
    cbb_MachineID: TComboBox;
    cbb_SampleType: TComboBox;
    cbb_NeedTrace: TComboBox;
    lst_NOCheckList: TListBox;
    btn_Help: TSpeedButton;
    btn_Check: TSpeedButton;
    btn_Save: TSpeedButton;
    btn_Exit: TSpeedButton;
    btn_DeletetAssiPrescription: TSpeedButton;
    grp_Only: TGroupBox;
    mmo_Remark: TMemo;
    Vle_Chemicallist: TValueListEditor;
    grp1: TGroupBox;
    lv_IncludeCard: TListView;
    ds_NoRecipeCards: TClientDataSet;
    btn_DeleteCard: TSpeedButton;
    edt_OperationName: TEdit;
    edt_Designer: TEdit;
    edt_DesignerTime: TEdit;
    edt_RecipeNO: TEdit;
    spl3: TSplitter;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClickAcxbePropertiesButton(Sender: TObject;
      AButtonIndex: Integer);
    procedure KeyDownAControl(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ClickASpeedButton(Sender: TObject);
    procedure Vle_ChemicallistValidate(Sender: TObject; ACol,
      ARow: Integer; const KeyName, KeyValue: String);
    procedure btn_RefrshNoCheckListClick(Sender: TObject);
    procedure Vle_ChemicallistGetPickList(Sender: TObject;
      const KeyName: String; Values: TStrings);
    procedure ChangeValues(Sender: TObject);
    procedure btn_CheckClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure pgc_HandRecipeChange(Sender: TObject);
    procedure Vle_ChemicallistGetEditMask(Sender: TObject; ACol,
      ARow: Integer; var Value: String);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_DeletetAssiPrescriptionClick(Sender: TObject);
    procedure Vle_ChemicallistKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { private declarations }
    Recipe: TRecipeInfo;
    {* 手工化料单实例}

    procedure GetNoRecipeCards(GFKeyValue: String);
    {* 取指定品名无化料单的卡号}
    procedure ChangeEditControlEnable(EnableEdit: Boolean);
    {* 改变工序等编辑控件的编辑状态.}

    procedure RecipeAfterEdit(Sender: TObject);
    procedure RecipeAfterOpen(Sender: TObject);
    procedure RecipeBeforeSave(Sender: TObject);
    procedure RecipeAfterSave(Sender: TObject);
    procedure RecipeAfterClose(Sender: TObject);
  public
    { Public declarations }
  end;

var
  HandRecipeForm: THandRecipeForm;

implementation

uses StrUtils, Math, Variants, Dialogs, ServerDllPub, uLogin,
  UAppOption, uShowMessage, uCADInfo, UFNMResource, uDictionary, uGlobal;

{$R *.dfm}

procedure THandRecipeForm.FormCreate(Sender: TObject);
begin
  //加载图标
  btn_Save.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Add_Chemical.Glyph.LoadFromResourceName(HInstance, RES_RIGHT);
  btn_Del_Chemical.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btn_DeleteCard.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btn_Help.Glyph.LoadFromResourceName(HInstance, RES_HELPABOUT);
  btn_RefrshNoCheckList.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  cxbe_GF_KeyValue.Properties.Buttons.Items[0].Glyph.LoadFromResourceName(HInstance, RES_QUERYSMALL);
  //布置界面
  btn_DeleteCard.Align:=alClient;
  btn_RefrshNoCheckList.Align:=alTop;
  cbb_OnLineOperation.Align:=alClient;
  pgc_HandRecipe.ActivePageIndex:=0;
  ChangeEditControlEnable(False);
  btn_DeletetAssiPrescription.Enabled:=false;
  //TreeView的双击事件
  tv_Chemical_Name.OnDblClick:=TGlobal.DblClickATreeview;
  //TWinControl的双击事件
  cbb_OnLineOperation.OnDblClick:=TGlobal.DblClickAWinControl;
  lst_NOCheckList.OnDblClick:=TGlobal.DblClickAWinControl;
  //构造标准配方单类
  Recipe:=TRecipeInfo.Create(Self);
  Recipe.OnAfterEdit:=RecipeAfterEdit;
  Recipe.OnAfterOpen:=RecipeAfterOpen;
  Recipe.OnBeforeSave:=RecipeBeforeSave;
  Recipe.OnAfterSave:=RecipeAfterSave;
  Recipe.OnAfterClose:=RecipeAfterClose;
end;

procedure THandRecipeForm.FormDestroy(Sender: TObject);
begin
  HandRecipeForm:=nil;
end;

procedure THandRecipeForm.GetNoRecipeCards(GFKeyValue: String);
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  if Trim(GFKeyValue) = '' then exit;

  FNMServerArtObj.GetNoRecipeCards(GFKeyValue, Login.CurrentDepartment, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetOnLineOperationList, [GFKeyValue, sErrorMsg]);
  ds_NoRecipeCards.Data:=vData;

  if ds_NoRecipeCards.IsEmpty then
    raise Exception.CreateResFmt(@ERR_OnLineOperationList, [GFKeyValue]);

  cxbe_GF_KeyValue.Text:=ds_NoRecipeCards['GF_NO'];
  cxbe_GF_KeyValue.Tag:=ds_NoRecipeCards['GF_ID'];
  FillItemsFromDataSet(ds_NoRecipeCards, 'Operation_Code', 'Operation_Name', '', '--', cbb_OnLineOperation.Items);
end;

procedure THandRecipeForm.ChangeEditControlEnable(EnableEdit: Boolean);
begin
  if not EnableEdit then
  begin
    cbb_FloodClass.ItemIndex := -1;
    cbb_FloodPercent.ItemIndex := -1;
    cbb_SampleType.ItemIndex := -1;
    cbb_NeedTrace.ItemIndex := -1;
    cbb_MachineID.ItemIndex := -1;

    mmo_Remark.Text:='';
    cxSE_Dry_Temperature.Text:='0';
    cxSE_Pre_Dry_Temperature.Text:='0';
    Vle_Chemicallist.Strings.Clear;
    btn_Save.Enabled:=EnableEdit;
    btn_Check.Enabled:=EnableEdit;
  end;

  btn_DeleteCard.Enabled:=EnableEdit;
  btn_Add_Chemical.Enabled:=EnableEdit;
  btn_Del_Chemical.Enabled:=EnableEdit;

  cbb_FloodClass.Enabled:=EnableEdit;
  cbb_FloodPercent.Enabled:=EnableEdit;
  cbb_SampleType.Enabled:=EnableEdit;
  cbb_NeedTrace.Enabled:=EnableEdit;
  cbb_MachineID.Enabled:=EnableEdit;

  cxSE_Dry_Temperature.Enabled:=EnableEdit;
  cxSE_Pre_Dry_Temperature.Enabled:=EnableEdit;
  mmo_Remark.Enabled:=EnableEdit;
  Vle_Chemicallist.Enabled:=EnableEdit;
end;

procedure THandRecipeForm.RecipeAfterEdit(Sender: TObject);
begin
  btn_Save.Enabled:=Recipe.Modify;
end;

procedure THandRecipeForm.RecipeAfterOpen(Sender: TObject);
begin
  with Sender as TRecipeInfo do
  begin
    //重新加载机台
    FillMachineListByOperationCode(Login.CurrentDepartment, Operation_Code, cbb_MachineID.Items);
    //标准处方的基本信息
    TGlobal.SetComboBoxValue(cbb_NeedTrace,    Trim(Need_Trace));
    TGlobal.SetComboBoxValue(cbb_MachineID,    Trim(Machine_ID));
    TGlobal.SetComboBoxValue(cbb_FloodClass,   Trim(Flood_Class));
    TGlobal.SetComboBoxValue(cbb_FloodPercent, Trim(Flood_Percent));
    TGlobal.SetComboBoxValue(cbb_SampleType,   Trim(Sample_Type));

    mmo_Remark.Text:=Remark;
//    edt_Checker.Text:=Checker;
    edt_Designer.Text:=Operator;
//    edt_CheckTime.Text:=Check_Time;
    edt_RecipeNO.Text:=Recipe_NO;
//    edt_PrescripNO.Text:=Prescrip_NO;
    edt_DesignerTime.Text:=Operate_Time;
    edt_OperationName.Text:=Operation_CHN;
    cxSE_Dry_Temperature.Text:=ifthen(VarToStr(Dry_Temperature) = '', '0', Trim(Dry_Temperature));
    cxSE_Pre_Dry_Temperature.Text:=ifthen(VarToStr(Pre_DryTemperature) = '', '0', Trim(Pre_DryTemperature));

    //检测标准配方是否被确认
    btn_Check.Enabled:=(Checker = '');// and (Prescrip_NO <> '');
    //填充具体化工料
    FillChemicalToAListControl(Vle_Chemicallist.Strings);
    //填充卡号
    FillCardListToAListView(lv_IncludeCard.Items);

    ChangeEditControlEnable(True);
  end;
end;

procedure THandRecipeForm.RecipeBeforeSave(Sender: TObject);
begin
  tv_Chemical_Name.SetFocus;
  with Sender as TRecipeInfo do
  begin
    //溢流类型
    Flood_Class:=cbb_FloodClass.Text;
    //溢流比
    Flood_Percent:=cbb_FloodPercent.Text;
    //预烘温度
    Pre_DryTemperature:=cxSE_Pre_Dry_Temperature.Text;
    //烘干温度
    Dry_Temperature:=cxSE_Dry_Temperature.Text;
    //加工机台
    Machine_ID:=LeftStr(cbb_MachineID.Text, 4);
    //试样类型
    Sample_Type:=LeftStr(cbb_SampleType.Text, 1);
    //是否需要跟踪
    Need_Trace:=LeftStr(cbb_NeedTrace.Text, 1);
    //备注
    Remark:=mmo_Remark.Text;
  end;
end;

procedure THandRecipeForm.RecipeAfterSave(Sender: TObject);
begin
  (Sender as TRecipeInfo).Close;
  btn_Save.Enabled:=false;
end;

procedure THandRecipeForm.RecipeAfterClose(Sender: TObject);
begin
  ChangeEditControlEnable(false);
  btn_Save.Enabled:=false;
end;

procedure THandRecipeForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Recipe.Close;
  if Recipe.Modify then
    Action:=caNone
  else
  begin
    Recipe.Destroy;
    Action:=caFree;
  end;
end;

procedure THandRecipeForm.ClickAcxbePropertiesButton(Sender: TObject; AButtonIndex: Integer);
begin
  if Sender = cxbe_GF_KeyValue then
    GetNoRecipeCards(cxbe_GF_KeyValue.Text);
end;

procedure THandRecipeForm.KeyDownAControl(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i: Integer;
begin
  //窗体KeyDown
  if Sender = Self then
  case Key of
    VK_F5: if pgc_HandRecipe.ActivePageIndex = 1 then btn_RefrshNoCheckList.Click;
    VK_F8: Recipe.SaveRecipeToDataBase;
  end;

  //制订配方品名编辑框KeyDown
  if Sender = cxbe_GF_KeyValue then
    case Key of
      VK_RETURN: cxbe_GF_KeyValue.Properties.OnButtonClick(Sender, 0);
    end;

  //在线工序选择框KeyDown
  if Sender = cbb_OnLineOperation then
    case Key of
      VK_RETURN:
      with Sender as TComboBox do
      begin
        if (Text = '') or (Items.IndexOf(Text) = -1) then exit;
        if not Recipe.Close then exit;

        ChangeEditControlEnable(False);
        if TMsgDialog.ShowMsgDialog(GetResourceString(@MSG_WillCreateRecipe), mtConfirmation, [mebYes, mebNo]) = mrYes then
          Recipe.CreateRecipe(LeftStr(Text, 3), Login.CurrentDepartment, Login.LoginName);
        ds_NoRecipeCards.First;
        for i := 0 to ds_NoRecipeCards.RecordCount - 1 do
        begin
          if ds_NoRecipeCards['Operation_Code'] = LeftStr(Text, 3) then
            Recipe.AddCard(ds_NoRecipeCards['FN_Card'], ds_NoRecipeCards['GF_NO'], ds_NoRecipeCards['Quantity']);
          ds_NoRecipeCards.next;
        end;
        Recipe.FillCardListToAListView(lv_IncludeCard.Items);
        Text:='';
      end;
    end;

  //化工料列表框KeyDown
  if Sender = tv_Chemical_Name then
    case Key of
      VK_RETURN: btn_Add_Chemical.Click;
    end;

  //审核配方列表框
  if Sender = lst_NOCheckList then
    case Key of
      VK_RETURN:
      begin
        if lst_NOCheckList.ItemIndex = -1 then Exit;
//        if Recipe.OrgIden_NO <> lst_NOCheckList.Items.Strings[lst_NOCheckList.ItemIndex] then
//        begin
          Recipe.OrgIden_NO:=lst_NOCheckList.Items.Strings[lst_NOCheckList.ItemIndex];
          ChangeEditControlEnable(False);
          Recipe.Open;
//        end;
      end;
    end;
end;

procedure THandRecipeForm.ClickASpeedButton(Sender: TObject);
var
  Chemical_ID: Integer;
begin
  if not (Sender as TSpeedButton).Enabled then Exit;
    
  //加入一个化工料
  if Sender = btn_Add_Chemical then
  begin
    if (tv_Chemical_Name.Selected = nil) or (tv_Chemical_Name.Selected.Level = 0) then exit;

    Chemical_ID:=Integer(tv_Chemical_Name.Selected.Data);
    Recipe.AddAChemical(Chemical_ID);
    Recipe.FillChemicalToAListControl(Vle_Chemicallist.Strings);
  end;

  //删除一个化工料
  if Sender = btn_Del_Chemical then
  begin
    if (Vle_Chemicallist.Strings.Count = 0) or (Vle_Chemicallist.Row = 0) then exit;

    Chemical_ID:=Integer(Vle_Chemicallist.Strings.Objects[Vle_Chemicallist.Row - 1]);
    Recipe.ReMoveAChemical(Chemical_ID);
    Recipe.FillChemicalToAListControl(Vle_Chemicallist.Strings);
  end;

  //删除一个包含的卡号
  if Sender = btn_DeleteCard then
  begin
    if lv_IncludeCard.Selected = nil then exit;
    
    Recipe.DeleteACard(lv_IncludeCard.Selected.Caption);
    Recipe.FillCardListToAListView(lv_IncludeCard.Items);
  end;
end;

procedure THandRecipeForm.Vle_ChemicallistGetPickList(Sender: TObject; const KeyName: String; Values: TStrings);
begin
  Recipe.GetPickListString(KeyName, Values);
end;

procedure THandRecipeForm.Vle_ChemicallistValidate(Sender: TObject; ACol, ARow: Integer; const KeyName, KeyValue: String);
begin
  if Recipe.Active then
    Recipe.SetAChemicalUnit_QTY(Integer(Vle_Chemicallist.Strings.Objects[ARow-1]),
                                       StringReplace(KeyValue, ' ', '', [rfReplaceAll]));
end;

procedure THandRecipeForm.btn_RefrshNoCheckListClick(Sender: TObject);
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  if pgc_HandRecipe.ActivePageIndex = 0 then Exit;

  sCondition := QuotedStr(Login.CurrentDepartment)+',0';
  FNMServerObj.GetQueryData(vData, 'RCPGetRecipeTaskInfo', sCondition, sErrorMsg);
//  FNMServerArtObj.GetNoCheckRecipe(Login.CurrentDepartment, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetNoCheckRecipe, [sErrorMsg]);

  TempClientDataSet.Data:=vData;
  if TempClientDataSet.IsEmpty then
    raise Exception.CreateRes(@EMP_NoCheckRecipe);

  FillItemsFromDataSet(TempClientDataSet, 'Recipe_NO', '', '', '', lst_NOCheckList.Items, False, True, True);
end;

procedure THandRecipeForm.ChangeValues(Sender: TObject);
begin
  Recipe.Modify:=true;
end;

procedure THandRecipeForm.btn_CheckClick(
  Sender: TObject);
begin
  Recipe.CheckRecipe(Login.LoginName);
  Recipe.Close;
end;

procedure THandRecipeForm.btn_ExitClick(Sender: TObject);
begin
  close;
end;

procedure THandRecipeForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  //刷新界面数据
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
  //填充可选化工料
  FillTreeItemsFromDataSetByClassField(Dictionary.cds_ChemicalList, 'Chemical_Name', 'Chemical_Type', 'Chemical_ID', '', tv_Chemical_Name.Items);
  OnActivate:=nil;
end;

procedure THandRecipeForm.pgc_HandRecipeChange(Sender: TObject);
begin
  if (pgc_HandRecipe.ActivePageIndex = 1) and (lst_NOCheckList.Count = 0) then
    btn_RefrshNoCheckList.Click;
end;

procedure THandRecipeForm.Vle_ChemicallistGetEditMask(
  Sender: TObject; ACol, ARow: Integer; var Value: String);
begin
  if Recipe.Active and (Vle_Chemicallist.Strings.Count <> 0) then
    Recipe.GetEditMask(Integer(Vle_Chemicallist.Strings.Objects[ARow-1]), Value);
end;

procedure THandRecipeForm.btn_SaveClick(Sender: TObject);
  var  i,flag1,flag2:Integer;
       value1,value2,quality:string;
begin
    //判断输入的有效性
    if  (Vle_Chemicallist.Strings.Count>0) then
        begin
              for i:=1 to Vle_Chemicallist.Strings.Count do
                  begin
                    if  Vle_Chemicallist.Keys[i]='Uvitex BMU LIQ' then
                        begin
                            value1:=StringReplace(Vle_Chemicallist.Values[Vle_Chemicallist.Keys[i]],' ','',[rfReplaceAll]);
                            flag1:=1;
                            Break;
                        end;

                  end;

              for i:=1 to Vle_Chemicallist.Strings.Count do
                  begin
                    if  Vle_Chemicallist.Keys[i]='Uvitex BMU-V LIQ' then
                        begin
                            value2:=StringReplace(Vle_Chemicallist.Values[Vle_Chemicallist.Keys[i]],' ','',[rfReplaceAll]);
                            flag2:=1;
                            Break;
                        end;

                  end;

              if (flag1=0) and (flag2=1) and (StrToFloat(value2)>2) then
                  begin
                      ShowMessage('荧光用量有误');
                      exit;
                  end;

              if (flag1=1) and (flag2=1) and (StrToFloat(value1)<StrToFloat(value2)) then
                  begin
                      ShowMessage('荧光用量有误');
                      exit;
                  end;

        end;

    tv_Chemical_Name.SetFocus;
    Recipe.SaveRecipeToDataBase;
end;

procedure THandRecipeForm.btn_DeletetAssiPrescriptionClick(
  Sender: TObject);
var
  sCondition,sErrorMsg: WideString;
begin
  if not Recipe.Active then exit;
  //工艺员删除化工料
  sCondition := QuotedStr(Recipe.Recipe_NO)+ ','+ QuotedStr(Login.LoginName)+','+QuotedStr('1');
  FNMServerObj.SaveDataBySQL('RCPDeleteRecipeInfo',sCondition,sErrorMsg);
//  FNMServerArtObj.SaveDelRecipe(Recipe.Recipe_NO, '1', sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveDelRecipe, [sErrorMsg]);

  Recipe.Close;
  ShowMsgDialog(@MSG_SaveDelRecipeSuccess, mtInformation);
end;

procedure THandRecipeForm.Vle_ChemicallistKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  var  row:Integer;
       keyValue,value:string;
       valueFloat:real;
begin
        if Key= VK_RETURN then
            begin
                row:=Vle_Chemicallist.Row;
                keyValue:=Vle_Chemicallist.Keys[Vle_Chemicallist.Row];
                value:=StringReplace(Vle_Chemicallist.Values[Vle_Chemicallist.Keys[Vle_Chemicallist.Row]],' ','',[rfReplaceAll]);
                if (keyValue='Red F5G') or (keyValue='Yellow ARLE154%') or (keyValue='Blue GL') or (keyValue='Violet B') or (keyValue='Lanaset Violet B') or (keyValue='Lanaset Blue 2R') then
                    begin
                        valueFloat:=StrToFloat(value)/1000;
                        Vle_Chemicallist.Values [keyValue]:=FloatToStr(valueFloat);
                    end;

            end;
end;

end.

