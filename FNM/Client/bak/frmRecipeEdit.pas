unit frmRecipeEdit;
{*|<PRE>*****************************************************************************

       ������� FNM CLIENT MODEL                                               
       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT
       ��Ԫ���� frmFactAssiPrescription.pas                                    
       �������� 2004-8-30 ���� 04:31:38                                        
       ������Ա lvzd
       �޸���Ա
       �޸�����
       �޸�ԭ��                                                                
       ��Ӧ����                                                                
       �ֶ�����
       ������ݿ��                                                            
       ������Ҫ����/SQL����˵��                                                
       �������� ��ʵ�ʴ�����                                                               

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
    {* �ֹ����ϵ�ʵ��}

    procedure ChangeEditControlEnable(EnableEdit: Boolean);
    {* �ı乤��ȱ༭�ؼ��ı༭״̬.}

    procedure RecipeAfterEdit(Sender: TObject);
    {* ʵ�ʹ����౻�༭}
    procedure RecipeAfterOpen(Sender: TObject);
    {* ʵ�ʹ����౻��}
    procedure RecipeBeforeSave(Sender: TObject);
    {* ʵ�ʹ����࿪ʼ����}
    procedure RecipeAfterSave(Sender: TObject);
    {* ʵ�ʹ����ౣ���}
    procedure RecipeAfterClose(Sender: TObject);
    {* ʵ�ʹ�����ر�}
  end;

var
  RecipeEditForm: TRecipeEditForm;

implementation

uses Math, StrUtils, Dialogs,UFNMResource, ServerDllPub, uFNMArtInfo, uCADInfo,
    uDictionary, uShowMessage, uLogin, UAppOption, uGlobal, UGridDecorator;

{$R *.dfm}

procedure TRecipeEditForm.FormCreate(Sender: TObject);
begin
  //����ͼ��
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btn_Help.Glyph.LoadFromResourceName(HInstance, RES_HELPABOUT);
  btn_SaveRecipe.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Add_Chemical.Glyph.LoadFromResourceName(HInstance, RES_RIGHT);
  btn_Del_Chemical.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btn_Query.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btn_DelStep.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  //���沼��
  btn_Query.Align:=alRight;
  edt_RecipeNO.Align:=alClient;
  btn_DelStep.Align:=alRight;
  btn_NewStep.Align:=alClient;

  ChangeEditControlEnable(false);
  //TreeView��˫���¼�
  tv_ChemicalName.OnDblClick:=TGlobal.DblClickATreeview;
  lst_StepList.OnClick:=TGlobal.DblClickAWinControl;
  //�����׼�䷽����
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
  //ˢ�½�������
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
  //����ѡ������
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
      raise Exception.Create('WAR_���ϵ���δȷ��,�����޸�');
      Exit;
    end;
      
    //���¼��ػ�̨
    FillMachineListByOperationCode(Login.CurrentDepartment, Operation_Code, cbb_MachineID.Items);
    //��׼�����Ļ�����Ϣ
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

//    �����廯����
//    FillChemicalToAListControl(Vle_Chemicallist.Strings);
    //��俨��
    FillCardListToAListView(lv_IncludeCard.Items);
    //��䲽��
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
{    //��������
    Flood_Class:=cbb_FloodClass.Text;
    //������
    Flood_Percent:=cbb_FloodPercent.Text;
    //Ԥ���¶�
    Pre_DryTemperature:=cxSE_Pre_Dry_Temperature.Text;
    //����¶�
    Dry_Temperature:=cxSE_Dry_Temperature.Text;
    //�ӹ���̨
    Machine_ID:=LeftStr(cbb_MachineID.Text, 4);
    //��������
    Sample_Type:=LeftStr(cbb_SampleType.Text, 1);
    //�Ƿ���Ҫ����
    Need_Trace:=LeftStr(cbb_NeedTrace.Text, 1);
    //��ע
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

  //����һ��������
  if Sender = btn_Add_Chemical then
  begin
    if (tv_ChemicalName.Selected = nil) or (tv_ChemicalName.Selected.Level = 0) then exit;

    Chemical_ID:=Integer(tv_ChemicalName.Selected.Data);
    Recipe.AddAChemical(Chemical_ID);
    Recipe.FillChemicalToAListControl(Vle_Chemicallist.Strings);
  end;

  //ɾ��һ��������
  if Sender = btn_Del_Chemical then
  begin
    if (Vle_Chemicallist.Strings.Count = 0) or (Vle_Chemicallist.Row = 0) then exit;

    Chemical_ID:=Integer(Vle_Chemicallist.Strings.Objects[Vle_Chemicallist.Row - 1]);
    Recipe.ReMoveAChemical(Chemical_ID);
    Recipe.FillChemicalToAListControl(Vle_Chemicallist.Strings);
  end;

  //ɾ��һ�������Ŀ���
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
  //����KeyDown
  if Sender = Self then
  case Key of
    VK_F8:  if btn_SaveRecipe.Enabled then btn_SaveRecipe.Click;
  end;

  //����KeyDown
  if Sender = tv_ChemicalName then
  case Key of
    VK_RETURN: btn_Add_Chemical.Click;
  end;

  //�������б�����KeyDown
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

