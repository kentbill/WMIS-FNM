unit frmRecipeEdit;
{*|<PRE>*****************************************************************************

       软件名称 FNM CLIENT MODEL                                               
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT
       单元名称 frmFactAssiPrescription.pas                                    
       创建日期 2004-8-30 下午 04:31:38                                        
       创建人员 lvzd
       修改人员
       修改日期
       修改原因                                                                
       对应用例                                                                
       字段描述
       相关数据库表                                                            
       调用重要函数/SQL对象说明                                                
       功能描述 开实际处方单                                                               

******************************************************************************}

interface

uses
  uFNMPrescriptionInfo, Windows, Messages, SysUtils, Variants,
  Classes, Controls, Forms, DB, DBClient, cxButtonEdit, cxSplitter,
  ComCtrls, StdCtrls, Grids, ValEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxSpinEdit, Buttons, ExtCtrls, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGrid, cxGridDBTableView;

type
  TRecipeEditForm = class(TForm)
    dsz: TClientDataSet;
    spl1: TSplitter;
    btn_Add_Chemical: TSpeedButton;
    btn_Del_Chemical: TSpeedButton;
    tv_ChemicalName: TTreeView;
    pnl_Only1: TPanel;
    btn_Help: TSpeedButton;
    spl3: TSplitter;
    Vle_Chemicallist: TValueListEditor;
    cds_NoFinishRecipe: TClientDataSet;
    ds_NoFinishRecipe: TDataSource;
    btn_Query: TSpeedButton;
    btn_NewStep: TSpeedButton;
    lst_StepList: TListBox;
    spl2: TSplitter;
    btn_DelStep: TSpeedButton;
    pnl2: TPanel;
    Splitter1: TSplitter;
    grp_Only: TGroupBox;
    mmo_Remark: TMemo;
    grp1: TGroupBox;
    btn_DeleteCard: TSpeedButton;
    lv_IncludeCard: TListView;
    edt_OperationName: TEdit;
    edt_Designer: TEdit;
    edt_DesignerTime: TEdit;
    edt_RecipeNO: TEdit;
    cbb_FloodPercent: TComboBox;
    cxSE_Pre_Dry_Temperature: TcxSpinEdit;
    cxSE_Dry_Temperature: TcxSpinEdit;
    cbb_FloodClass: TComboBox;
    cbb_MachineID: TComboBox;
    cbb_SampleType: TComboBox;
    cbb_NeedTrace: TComboBox;
    Only: TStaticText;
    edt_RecipeNO1: TEdit;
    btn_DeleteRecipe: TSpeedButton;
    btn_SaveRecipe: TSpeedButton;
    btn_Exit: TSpeedButton;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClickASpeedButton(Sender: TObject);
    procedure ChangeValues(Sender: TObject);
    procedure Vle_ChemicallistValidate(Sender: TObject; ACol,
      ARow: Integer; const KeyName, KeyValue: String);
    procedure Vle_ChemicallistGetPickList(Sender: TObject;
      const KeyName: String; Values: TStrings);
    procedure KeyDownAControl(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ClickAButton(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Vle_ChemicallistGetEditMask(Sender: TObject; ACol,
      ARow: Integer; var Value: String);
    procedure btn_QueryClick(Sender: TObject);
  private
    { private declarations }
  public
    { Public declarations }
    Recipe: TRecipeInfo;
    {* 手工化料单实例}

    procedure ChangeEditControlEnable(EnableEdit: Boolean);
    {* 改变工序等编辑控件的编辑状态.}

    procedure RecipeAfterEdit(Sender: TObject);
    {* 实际工艺类被编辑}
    procedure RecipeAfterOpen(Sender: TObject);
    {* 实际工艺类被打开}
    procedure RecipeBeforeSave(Sender: TObject);
    {* 实际工艺类开始保存}
    procedure RecipeAfterSave(Sender: TObject);
    {* 实际工艺类保存后}
    procedure RecipeAfterClose(Sender: TObject);
    {* 实际工艺类关闭}
  end;

var
  RecipeEditForm: TRecipeEditForm;

implementation

uses Math, StrUtils, Dialogs,UFNMResource, ServerDllPub, uFNMArtInfo, uCADInfo,
    uDictionary, uShowMessage, uLogin, UAppOption, uGlobal, UGridDecorator;

{$R *.dfm}

procedure TRecipeEditForm.FormCreate(Sender: TObject);
begin
  //加载图标
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btn_Help.Glyph.LoadFromResourceName(HInstance, RES_HELPABOUT);
  btn_SaveRecipe.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Add_Chemical.Glyph.LoadFromResourceName(HInstance, RES_RIGHT);
  btn_Del_Chemical.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btn_Query.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btn_DelStep.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  //界面布置
  btn_Query.Align:=alRight;
  edt_RecipeNO.Align:=alClient;
  btn_DelStep.Align:=alRight;
  btn_NewStep.Align:=alClient;

  ChangeEditControlEnable(false);
  //TreeView的双击事件
  tv_ChemicalName.OnDblClick:=TGlobal.DblClickATreeview;
  lst_StepList.OnClick:=TGlobal.DblClickAWinControl;
  //构造标准配方单类
  Recipe:=TRecipeInfo.Create(Self);
  Recipe.OnAfterEdit:=RecipeAfterEdit;
  Recipe.OnAfterOpen:=RecipeAfterOpen;
  Recipe.OnBeforeSave:=RecipeBeforeSave;
  Recipe.OnAfterSave:=RecipeAfterSave;
  Recipe.OnAfterClose:=RecipeAfterClose;
end;

procedure TRecipeEditForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  OnActivate:=nil;
  //刷新界面数据
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
  //填充可选化工料
  FillTreeItemsFromDataSetByClassField(Dictionary.cds_ChemicalList, 'Chemical_Name', 'Chemical_Type',
    'Chemical_ID', '', tv_ChemicalName.Items);
end;

procedure TRecipeEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caNone;
//  if not Recipe.Close then exit;
//
//  Recipe.Modify:=false;
//  Recipe.Destroy;
//
  Action:=caFree;
end;

procedure TRecipeEditForm.FormDestroy(Sender: TObject);
begin
  RecipeEditForm:=nil;
end;

procedure TRecipeEditForm.btn_QueryClick(Sender: TObject);
begin
  if edt_RecipeNO.Text = '' then Exit;
        
  Recipe.OrgIden_NO:=edt_RecipeNO.Text;
  Recipe.Open;
  lst_StepList.Focused;
end;

procedure TRecipeEditForm.ChangeEditControlEnable(EnableEdit: Boolean);
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
    btn_SaveRecipe.Enabled:=EnableEdit;
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

procedure TRecipeEditForm.RecipeAfterEdit(Sender: TObject);
begin
  btn_SaveRecipe.Enabled:=Recipe.Modify;
end;

procedure TRecipeEditForm.RecipeAfterOpen(Sender: TObject);
begin
  with Sender as TRecipeInfo do
  begin
    if (Sender as TRecipeInfo).Checker = '' then
    begin
      raise Exception.Create('WAR_化料单尚未确认,不能修改');
      Exit;
    end;
      
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
    edt_RecipeNO1.Text:=Recipe_NO;
//    edt_PrescripNO.Text:=Prescrip_NO;
    edt_DesignerTime.Text:=Operate_Time;
    edt_OperationName.Text:=Operation_CHN;
    cxSE_Dry_Temperature.Text:=ifthen(VarToStr(Dry_Temperature) = '', '0', Trim(Dry_Temperature));
    cxSE_Pre_Dry_Temperature.Text:=ifthen(VarToStr(Pre_DryTemperature) = '', '0', Trim(Pre_DryTemperature));

//    填充具体化工料
//    FillChemicalToAListControl(Vle_Chemicallist.Strings);
    //填充卡号
    FillCardListToAListView(lv_IncludeCard.Items);
    //填充步骤
    FillStepToItems(lst_StepList.Items);
    //
    lst_StepList.ItemIndex:=0;
    sendMessage(lst_StepList.Handle, WM_KEYDOWN, VK_RETURN, 0);

    ChangeEditControlEnable(True);
  end;
end;

procedure TRecipeEditForm.RecipeBeforeSave(Sender: TObject);
begin
  tv_ChemicalName.SetFocus;
  with Sender as TRecipeInfo do
  begin
{    //溢流类型
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
}  end;
end;

procedure TRecipeEditForm.RecipeAfterSave(Sender: TObject);
begin
  (Sender as TRecipeInfo).Close;
  btn_SaveRecipe.Enabled:=false;
end;

procedure TRecipeEditForm.RecipeAfterClose(Sender: TObject);
begin
  ChangeEditControlEnable(false);
  btn_SaveRecipe.Enabled:=false;
end;

procedure TRecipeEditForm.ClickASpeedButton(Sender: TObject);
var
  Chemical_ID: Integer;
begin
  if not (Sender as TSpeedButton).Enabled then Exit;

  //加入一个化工料
  if Sender = btn_Add_Chemical then
  begin
    if (tv_ChemicalName.Selected = nil) or (tv_ChemicalName.Selected.Level = 0) then exit;

    Chemical_ID:=Integer(tv_ChemicalName.Selected.Data);
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

procedure TRecipeEditForm.ChangeValues(Sender: TObject);
begin
  Recipe.Modify:=true;
end;

procedure TRecipeEditForm.Vle_ChemicallistValidate(Sender: TObject; ACol, ARow: Integer; const KeyName, KeyValue: String);
begin
  if Recipe.Active then
    Recipe.SetAChemicalUnit_QTY(Integer(Vle_Chemicallist.Strings.Objects[ARow-1]),
                                       StringReplace(KeyValue, ' ', '', [rfReplaceAll]));
end;

procedure TRecipeEditForm.Vle_ChemicallistGetPickList(Sender: TObject; const KeyName: String; Values: TStrings);
begin
  Recipe.GetPickListString(KeyName, Values);
end;

procedure TRecipeEditForm.KeyDownAControl(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  //窗体KeyDown
  if Sender = Self then
  case Key of
    VK_F8:  if btn_SaveRecipe.Enabled then btn_SaveRecipe.Click;
  end;

  //窗体KeyDown
  if Sender = tv_ChemicalName then
  case Key of
    VK_RETURN: btn_Add_Chemical.Click;
  end;

  //化工料列表树的KeyDown
  if Sender = lst_StepList then
  case Key of
    VK_RETURN:
    begin
      if lst_StepList.ItemIndex = -1 then Exit;
      Recipe.SetCurrentSteps(lst_StepList.ItemIndex + 1);

      //TGlobal.SetComboBoxValue(cbb_SampleType, Trim(Need_Trace));
      //TGlobal.SetComboBoxValue(cbb_NeedTrace,  Trim(Machine_ID));
      Recipe.FillChemicalToAListControl(Vle_Chemicallist.Strings);

      cbb_NeedTrace.Enabled:=True;
      cbb_SampleType.Enabled:=True;
      btn_Add_Chemical.Enabled:=True;
      btn_Del_Chemical.Enabled:=True;
      Vle_Chemicallist.Enabled:=True;
    end;
  end;
end;

procedure TRecipeEditForm.ClickAButton(Sender: TObject);
begin
  if Sender = btn_SaveRecipe then
    Recipe.SaveRecipeToDataBase;
end;

procedure TRecipeEditForm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TRecipeEditForm.Vle_ChemicallistGetEditMask(
  Sender: TObject; ACol, ARow: Integer; var Value: String);
begin
  if Recipe.Active and (Vle_Chemicallist.Strings.Count <> 0) then
    Recipe.GetEditMask(Integer(Vle_Chemicallist.Strings.Objects[ARow-1]), Value);
end;

end.

