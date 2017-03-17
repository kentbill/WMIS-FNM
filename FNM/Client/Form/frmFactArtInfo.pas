unit frmFactArtInfo;
{*|<PRE>*****************************************************************************
                                                                             
       ������� FNM CLIENT MODEL                                               
       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT
       ��Ԫ���� frmFactArtInfo.pas                                             
       �������� 2004-8-30 ���� 07:17:29
       ������Ա lvzd                                                           
       �޸���Ա                                                                
       �޸�����                                                                
       �޸�ԭ��                                                                
       ��Ӧ����                                                                
       �ֶ�����                                                                
       ������ݿ��                                                            
       ������Ҫ����/SQL����˵��                                                
       �������� �޸ĺͲ�����޹���                                                               
                                                                              
******************************************************************************}

interface

uses
  uFNMArtInfo, Windows, Messages, SysUtils, Variants, Classes, Forms,
  Graphics, StdCtrls, Grids, ValEdit, ComCtrls, Controls, ExtCtrls, Dialogs,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, Buttons,
  cxControls, cxSplitter, CheckLst, DB, DBClient;

type
  TFactArtInfoForm = class(TForm)
    btn_Add_Operation: TSpeedButton;
    btn_Del_Operation: TSpeedButton;
    btn_MoveDown_Operation: TSpeedButton;
    btn_MoveUP_Operation: TSpeedButton;
    cxbe_GFKeyValue: TcxButtonEdit;
    cxspl_XX: TcxSplitter;
    mmo_Remark: TMemo;
    pgc_Operation: TPageControl;
    pnl_Only: TPanel;
    pnl_Only1: TPanel;
    spl1: TSplitter;
    ts_Only: TTabSheet;
    txt_Only: TStaticText;
    txt1: TStaticText;
    edt_Customer: TEdit;
    edt_Grey_Width: TEdit;
    edt_Width: TEdit;
    edt_GreyDensity: TEdit;
    edt_Designer: TEdit;
    edt_Designer_Time: TEdit;
    edt_Density: TEdit;
    edt_GFKeyValue: TEdit;
    btn_Help: TSpeedButton;
    btn_Exit: TSpeedButton;
    btn_SaveArt: TSpeedButton;
    Vle_Operation_Parlist: TValueListEditor;
    grp_Only: TGroupBox;
    edt_FN_Shrinkage: TEdit;
    edt_Anti_Fluorescence: TEdit;
    edt_Version: TEdit;
    btn_OpenFactArt: TSpeedButton;
    pnl_Only2: TPanel;
    tv_CardList: TTreeView;
    edt_ColorCode: TEdit;
    edt_FN_Art_NO1: TEdit;
    edt_FN_Art_NO4: TEdit;
    edt_FN_Art_NO2: TEdit;
    edt_Shrinkage: TEdit;
    edt_HandFeel: TEdit;
    edt_BR: TEdit;
    cbb_Operation_Name: TComboBox;
    edt_ReedWidth: TEdit;
    btn_ViewArtDtl: TSpeedButton;
    edt_ProductWidth: TEdit;
    lst_Operationlist: TListBox;
    cbb_ReasonName: TComboBox;
    cbb_ReasonType: TComboBox;
    lblRemark: TLabel;
    cdsRemark: TClientDataSet;
    cdsRecipe: TClientDataSet;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure chklst_OperationlistClick(Sender: TObject);
    procedure Vle_Operation_ParlistValidate(Sender: TObject; ACol,
      ARow: Integer; const KeyName, KeyValue: String);
    procedure btn_SaveArtClick(Sender: TObject);
    procedure btn_Add_OperationClick(Sender: TObject);
    procedure btn_Operation(Sender: TObject);
    procedure cxbe_GF_NO_FNCardPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure ClickOpenFactArt(Sender: TObject);
    procedure ChangeAEdit(Sender: TObject);
    procedure KeyDownAComboBox(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Vle_Operation_ParlistEditButtonClick(Sender: TObject);
    procedure KeyDownAControl(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pgc_OperationChange(Sender: TObject);
    procedure Vle_Operation_ParlistKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tv_CardListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_ViewArtDtlClick(Sender: TObject);
    procedure cbb_ReasonTypeSelect(Sender: TObject);
    procedure GetGIRemark(sFNCard:String);
  private
    { private declarations }
    FactArtData: TFactArtDtlInfo;
    {* ʵ�ʹ��������}
    SelectStepNO: integer;
    {* ��ǰ����}
    procedure ChangeEditControlEnable(EnableEdit: Boolean);

    procedure SelectAOperation;
    {* }
    procedure RefreshFinishCardList;
    {* }
    procedure ArtAfterEdit(Sender: TObject);
    {* �����ձ��༭��,��FormCreate�¼���:StdArtData.OnAfterEdit:=ArtAfterEdit;}
    procedure ArtBeforeSave(Sender: TObject);
    {* ���ձ���֮ǰ��������ú���,��FormCreate�¼���:StdArtData.OnBeforeSave:=ArtBeforeSave;}
    procedure ArtAfterSave(Sender: TObject);
    {* �����ձ���ɹ���,��FormCreate�¼���:StdArtData.OnAfterSave:=ArtAfterSave;}
    procedure ArtAfterOpen(Sender: TObject);
    {* �����մ򿪺�,��FormCreate�¼���:StdArtData.OnAfterOpen:=ArtAfterOpen;}
    procedure ArtAfterClose(Sender: TObject);
    {* �����չرպ�,��FormCreate�¼���:StdArtData.OnAfterClose:=ArtAfterClose;}

    procedure CheckArt();

    {* ���ʵ�ʹ���}
  public
    { Public declarations }
    checkResult:string;
    checkOperation:string;
  end;

var
  FactArtInfoForm: TFactArtInfoForm;

implementation

uses Math, StrUtils, CommCtrl, uDictionary, frmCreateSample, uLogin,
    uGlobal, uFNMResource, uCADInfo, ServerDllPub,  uShowMessage,
    UAppOption, frmCreateStdPrescription;

{$R *.dfm}

const
  {$EXTERNALSYM TVM_GETITEMSTATE}
  TVM_GETITEMSTATE = TV_FIRST + 39;

function TreeView_GetCheckState(hwndTV: HWND; hitem: HTreeItem): Integer;
begin
  //Checked 1 Unchecked 0 No Check Box Image -1
  Result := (SendMessage(hwndTV, TVM_GETITEMSTATE, Longint(hitem), TVIS_STATEIMAGEMASK) shr 12) - 1 ;
end;

procedure TreeView_SetCheckState(hwndTV: HWND; hitem: HTreeItem; Checked: Boolean);
var
  Item: TTVItem;
begin
  Item.hItem :=hitem;
  Item.mask := TVIF_STATE;
  Item.statemask := TVIS_STATEIMAGEMASK;
  Item.State := ((Integer(Checked) and 1) + 1) shl 12;
  TreeView_SetItem(hwndTV, Item);
end;

procedure TFactArtInfoForm.SelectAOperation;
var
  Step_NO: Integer;    
begin
  Vle_Operation_Parlist.Enabled:=Vle_Operation_Parlist.Strings.Count > 0;
  if lst_Operationlist.Focused then
    pgc_Operation.ActivePageIndex := 1;

  if lst_Operationlist.ItemIndex <> -1 then
  begin
    Step_NO:=Integer(lst_Operationlist.Items.Objects[lst_Operationlist.ItemIndex]);
    //��⵱ǰѡ��Ĺ����Ƿ����Ѿ��ӹ����Ĺ��򣬼ӹ����Ĺ������޸Ĺ����ˡ�
    if (Step_NO < SelectStepNO) then // or (Pos('1',Login.UserLevelList)>0)then
      Vle_Operation_Parlist.Options:=Vle_Operation_Parlist.Options - [goEditing]
    else
      Vle_Operation_Parlist.Options:=Vle_Operation_Parlist.Options + [goEditing];

    if Vle_Operation_Parlist.Tag <> Step_NO then
    begin
      FactArtData.FillAStepToAListControls(Step_NO, Vle_Operation_Parlist);
      Vle_Operation_Parlist.Tag:=Step_NO;
    end;
  end;

end;

procedure TFactArtInfoForm.ChangeEditControlEnable(EnableEdit: Boolean);
begin
  if not EnableEdit then
  begin
    edt_GFKeyValue.Text:='';
    edt_Customer.Text:='';
    edt_Anti_Fluorescence.Text:='';
    edt_BR.Text:='';
    edt_Width.Text:='';
    edt_Grey_Width.Text:='';
    edt_GreyDensity.Text:='';
    edt_ReedWidth.Text:='';
    edt_Density.Text:='';
    edt_FN_Shrinkage.Text:='';
    edt_Version.Text:='';
    edt_Designer.Text:='';
    edt_Designer_Time.Text:='';
    edt_Shrinkage.Text:='';
    edt_HandFeel.Text:='';
    edt_FN_Art_NO4.Text:='';
    edt_FN_Art_NO2.Text:='';
    edt_FN_Art_NO1.Text:='';
    edt_ColorCode.Text:='';

    lst_Operationlist.Clear;
    mmo_Remark.Lines.Clear;
    cbb_ReasonType.Enabled:=EnableEdit;
    cbb_ReasonName.Enabled:=EnableEdit;
    Vle_Operation_Parlist.Enabled:=EnableEdit;
    Vle_Operation_Parlist.Strings.Clear;
    btn_SaveArt.Enabled:=EnableEdit;
  end;

  btn_Add_Operation.Enabled:=EnableEdit and (pgc_Operation.ActivePageIndex = 0);
  btn_Del_Operation.Enabled:=EnableEdit;
  btn_MoveDown_Operation.Enabled:=EnableEdit;
  btn_MoveUP_Operation.Enabled:=EnableEdit;
  lst_Operationlist.Enabled:=EnableEdit;
  mmo_Remark.Enabled:=EnableEdit;
end;

procedure TFactArtInfoForm.RefreshFinishCardList;
var
  i: Integer;
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  if not FactArtData.CloseArt then exit;
  FactArtData.FACT_Art_ID:= -1;

  //ˢ�¿����б�
  FNMServerArtObj.GetEditCardLists(cxbe_GFKeyValue.Text, Login.CurrentDepartment, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetOnLineCard, [sErrorMsg]);

  TempClientDataSet.Data:=vData;
  if TempClientDataSet.IsEmpty then

    raise Exception.CreateRes(@EMP_OnLineCard);

  tv_CardList.Items.Clear;
  FillTreeItemsFromDataSetByClassField(TempClientDataSet, 'FN_Card', 'Fact_Art_Step_NO', '', '', tv_CardList.Items);
  with tv_CardList.Items, tv_CardList do
  if Count > 0 then
  begin
    for i := 0 to Count - 1 do
    begin
      if Item[i].Level = 0 then
        Item[i].StateIndex := 0;
    end;

    FullExpand;
    Selected:=tv_CardList.Items.Item[0];
    Selected.MakeVisible;
    Enabled:=true;
  end;

  btn_OpenFactArt.Enabled:=true;
  ChangeEditControlEnable(false);
end;

procedure TFactArtInfoForm.ArtAfterEdit(Sender: TObject);
begin
//���ձ��༭�¼�
  btn_SaveArt.Enabled:=(Sender as TFactArtDtlInfo).Modify;
end;

procedure TFactArtInfoForm.ArtBeforeSave(Sender: TObject);
begin
  lst_Operationlist.SetFocus;

  with Sender as TFactArtDtlInfo do
  begin
    RepairReason:=cbb_ReasonName.Text;
    Operator:=Login.LoginName;
    Remark:=mmo_Remark.Text;
  end;    
end;

procedure TFactArtInfoForm.ArtAfterSave(Sender: TObject);
begin
  //���ձ��ر��¼�
  btn_SaveArt.Enabled:=false;
end;

procedure TFactArtInfoForm.ArtAfterOpen(Sender: TObject);
var
  SubStrLen: Integer;
  TheFN_Art_NO: String;
begin
  with Sender as TFactArtDtlInfo do
  begin
    TheFN_Art_NO:=FN_Art_NO;
    SubStrLen:=pos(';', TheFN_Art_NO);
    edt_FN_Art_NO1.Text:=LeftStr(TheFN_Art_NO, SubStrLen - 1);
    System.Delete(TheFN_Art_NO, 1, SubStrLen);

    SubStrLen:=pos(';', TheFN_Art_NO);
    edt_FN_Art_NO2.Text:=LeftStr(TheFN_Art_NO, SubStrLen - 1);
    System.Delete(TheFN_Art_NO, 1, SubStrLen);

    SubStrLen:=pos(';', TheFN_Art_NO);
    edt_FN_Art_NO4.Text:=LeftStr(TheFN_Art_NO, SubStrLen - 1);
    System.Delete(TheFN_Art_NO, 1, SubStrLen);

    edt_ColorCode.Text:=FN_Color_Code;
    //��ˮҪ��
    edt_Shrinkage.Text:=Shrinkage;
    //�ָ�Ҫ��
    edt_HandFeel.Text:=HandFeel;
    //�ŷ�
    edt_ProductWidth.Text:=Product_Width;
    mmo_Remark.Text:=Remark;
    edt_Version.Text:=STD_Art_Version;
    edt_Designer.Text:=Operator;
    edt_Designer_Time.Text:=Operate_Time;

    RepairReason:='';
    Internal_Repair:=False;
    //��乤���б����
    FillOperationToAListControls(lst_Operationlist.Items);
  end;

  if (Sender as TFactArtDtlInfo).Art_Type <> 'H' then
  begin
    //��ʾCAD��Ϣ
    with Sender as TFactArtDtlInfo do
      CADInfo.OrgGFKeyValue:=GF_ID;
    with CADInfo do
    begin
      edt_Width.Text:=Width;
      edt_BR.Text:=BRUnitUsage;
      edt_Density.Text:=Density;
      edt_GFKeyValue.Text:=GF_NO;
      edt_Customer.Text:=Customer_Code;
      edt_Grey_Width.Text:=CADInfo.GreyWidth;
      edt_ReedWidth.Text:=CADInfo.Reed_Width;
      edt_GreyDensity.Text:=CADInfo.GreyDensity;
      edt_Anti_Fluorescence.Text:=FluorescencePercent;
    end;
    //��ʾ���Ϳؼ�
    AutoShowCADPicture(CADInfo.OrgGFKeyValue);
  end;
  //���ñ༭�ؼ�����
  ChangeEditControlEnable(true);
  btn_OpenFactArt.Enabled:=false;
end;

procedure TFactArtInfoForm.ArtAfterClose(Sender: TObject);
begin
  cbb_ReasonType.ItemIndex := -1;
  cbb_ReasonName.ItemIndex := -1;
  btn_SaveArt.Enabled := False;
  ChangeEditControlEnable(false);
end;

procedure TFactArtInfoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FactArtData.CloseArt;
  if FactArtData.Modify then
    Action:=caNone
  else
  begin
    FactArtData.Destroy;
    Action:=caFree;
  end;
end;

procedure TFactArtInfoForm.FormDestroy(Sender: TObject);
begin
  FactArtInfoForm:=nil;
end;

procedure TFactArtInfoForm.FormCreate(Sender: TObject);
var
  Style: Integer;
begin
  //����ͼ��
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btn_SaveArt.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Help.Glyph.LoadFromResourceName(HInstance, RES_HELPABOUT);
  btn_Add_Operation.Glyph.LoadFromResourceName(HInstance, RES_LEFT);
  btn_Del_Operation.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btn_MoveUP_Operation.Glyph.LoadFromResourceName(HInstance, RES_MOVEUP);
  btn_MoveDown_Operation.Glyph.LoadFromResourceName(HInstance, RES_MOVEDOWN);
  cxbe_GFKeyValue.Properties.Buttons.Items[0].Glyph.LoadFromResourceName(HInstance, RES_QUERYSMALL);
  //���ý���
  (cbb_Operation_Name as TControl).Align:=alClient;
  (btn_OpenFactArt as TControl).Align:=alBottom;
  pnl_Only2.Align:=alClient;
  btn_SaveArt.Enabled:=false;
  ChangeEditControlEnable(false);
  pgc_Operation.ActivePageIndex:=0;
  //��ʼ������
  SelectStepNO:=-1;
  //TWinControl��˫���¼�
  cbb_Operation_Name.OnDblClick:=TGlobal.DblClickAWinControl;
  //TreeView��˫���¼�
  tv_CardList.OnDblClick:=TGlobal.DblClickATreeview;
  //����CheckBox
  Style := GetWindowLong(tv_CardList.Handle, GWL_STYLE);
  Style := Style or TVS_CHECKBOXES;
  SetWindowLong(tv_CardList.Handle, GWL_STYLE, Style);

  //����ʵ�ʹ�����
  FactArtData:=TFactArtDtlInfo.Create(Self);
  FactArtData.OnAfterEdit:=ArtAfterEdit;
  FactArtData.OnAfterOpen:=ArtAfterOpen;
  FactArtData.OnBeforeSave:=ArtBeforeSave;
  FactArtData.OnAfterClose:=ArtAfterClose;
  FactArtData.OnAfterSave:=ArtAfterSave;
end;

procedure TFactArtInfoForm.btn_SaveArtClick(Sender: TObject);
var
  sMsg:string;
begin
  lst_Operationlist.SetFocus;
  //�����޸ĺ��ʵ�ʹ���Ϊ��׼����
  if Pos('4',Login.UserLevelList) > 0 then
  begin
    //����ID : 243008   tracy tan     ���æȡ�����¹��� 2016/7/14
   // if TMsgDialog.ShowMsgDialog('�Ƿ��滻��Ʒ����'+FactArtData.GF_NO+'���ı�׼���գ�', mtConfirmation, [mebYes, mebNo], mebYes) = mrYes then
     //  FactArtData.AsSTDArt := True;
  end;

  checkResult := 'T';
  CheckArt;
  IF checkResult = 'F' then
  begin
    sMsg := '��ԭ ' + checkOperation + ' ���������һ�£���ȷ��!' ;
    if MessageDlg(sMsg, mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
  end;
  checkOperation := '';

  FactArtData.SaveArtToDataBase;
  FactArtData.CloseArt;
end;

procedure  TFactArtInfoForm.CheckArt;
var
  i:Integer;
  step_no,find_step_no :Integer;
  sOperation,sItem,sValue,sFindValue:string;
  find_value:variant;
begin
  with FactArtData.fact_art_dtl do
  begin
    while not Eof do
    begin
      step_no    := FieldByName('step_no').AsInteger;
      sOperation := FieldByName('Operation_code').AsString;
      sItem      := FieldByName('Item_name').AsString;
      sValue     := FieldByName('Item_value').AsString;
      for i:=0 to step_no - 1 do
      begin
        find_step_no := i;
        find_value := FactArtData.Org_fact_art_dtl.Lookup('step_no;Operation_code;Item_name',VarArrayOf([inttostr(find_step_no),sOperation,sItem]),'item_value');
        if varisnull(find_value) then sFindValue:='' else sFindValue:=find_value;
        if  sFindValue <> '' then
        begin
           if sValue = '' then
           begin
             checkResult := 'F';
             checkOperation := sOperation;
             Exit;
           end;
        end;
      end;
      Next;
    end;
    checkResult := 'T';
  end;
end;

procedure TFactArtInfoForm.chklst_OperationlistClick(Sender: TObject);
begin
  SelectAOperation;
end;

procedure TFactArtInfoForm.Vle_Operation_ParlistValidate(Sender: TObject; ACol, ARow: Integer; const KeyName, KeyValue: String);
var
  ItemValue: string;
  vData:OleVariant;
  sSql,sErrMsg:WideString;
begin
  try
    Vle_Operation_Parlist.OnValidate:=nil;

    if KeyName = '' then Exit;

    if FactArtData.Active then
    begin
      ItemValue:=FactArtData.SetAOperateParameterValue(Vle_Operation_Parlist.Tag, Trim(KeyName), Trim(KeyValue));

      //�ж��䷽�Ƿ���� --begin----
      if Trim(KeyName) = '�䷽' then
      begin
        sSql := QuotedStr(Trim(KeyValue));
        FNMServerObj.GetQueryData(vData,'CheckRecipe',sSql,sErrMsg);
        if sErrMsg <> '' then
        begin
          TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
          Exit;
        end;
        cdsRecipe.Data := vData;
        if cdsRecipe.FieldByName('val').AsString <> '0' then
        begin
          ShowMessage('���䷽' + Trim(KeyValue) + '������ʹ�ã����޸ģ�');
        end;
      end;
      //�ж��䷽�Ƿ���� --end----

      Vle_Operation_Parlist.Cells[ACol, ARow]:=ItemValue;
    end;
  finally
    Vle_Operation_Parlist.OnValidate:=Vle_Operation_ParlistValidate;
  end;
end;

procedure TFactArtInfoForm.btn_Add_OperationClick(Sender: TObject);
var
  OperationName: string;
  StepNO, OperationID: Integer;
begin
  if not btn_Add_Operation.Enabled then exit;

  with cbb_Operation_Name do
    if (Text = '') or (Items.IndexOf(Text) = -1)then exit;

  with cbb_Operation_Name do
  begin
    OperationID:=Integer(Items.Objects[Items.IndexOf(Text)]);
    OperationName:=cbb_Operation_Name.Text;
    Text:='';
  end;

  //�������
  StepNO:=FactArtData.AddAOperateStep(OperationID);
  if RightStr(OperationName, 4) <> '����' then
    FactArtData.SetAOperateParameterValue(StepNO, '�ڻ���()', 'True');

  //���沼��
  FactArtData.FillOperationToAListControls(lst_Operationlist.Items);
  lst_Operationlist.ItemIndex:=lst_Operationlist.Count -1;
  SelectAOperation;
end;

procedure TFactArtInfoForm.btn_Operation(Sender: TObject);
var
  ItemIndex, Step_NO: Integer;
begin
  ItemIndex:=lst_Operationlist.ItemIndex;
  if ItemIndex = -1 then exit;

  Step_NO:=Integer(lst_Operationlist.Items.Objects[ItemIndex]);

  //�û�����btn_Del_Operation��ť
  if Sender = btn_Del_Operation then
  begin
    //��⵱ǰѡ��Ĺ����Ƿ����Ѿ��ӹ����Ĺ��򣬼ӹ����Ĺ������޸Ĺ����ˡ�
    if SelectStepNO > Step_NO then exit;
    
    FactArtData.MoveAOperateStep(Step_NO, ooDelete);
    FactArtData.UpdateAStepNO(Step_NO, ooDelete);
    ItemIndex:=ItemIndex-1;
  end;

  //�û�����btn_MoveDown_Operation��ť
  if Sender = btn_MoveDown_Operation then
  begin
    //��⵱ǰѡ��Ĺ����Ƿ����Ѿ��ӹ����Ĺ��򣬼ӹ����Ĺ������޸Ĺ����ˡ�
    if SelectStepNO > Step_NO then exit;
    
    if ItemIndex < lst_Operationlist.Count - 1 then
    begin
      FactArtData.MoveAOperateStep(Step_NO, ooMoveDown);
      FactArtData.UpdateAStepNO(Step_NO, ooMoveDown);
      ItemIndex:=ItemIndex+1;
    end;
  end;

  //�û�����btn_MoveUP_Operation��ť
  if Sender = btn_MoveUP_Operation then
  begin
    //��⵱ǰѡ��Ĺ����Ƿ����Ѿ��ӹ����Ĺ��򣬼ӹ����Ĺ������޸Ĺ����ˡ�
    if SelectStepNO > Step_NO - 1 then exit;
    
    if ItemIndex > 0 then
    begin
      FactArtData.MoveAOperateStep(Step_NO, ooMoveUP);
      FactArtData.UpdateAStepNO(Step_NO, ooMoveUP);
      ItemIndex:=ItemIndex-1;
    end;
  end;

  //���沼��
  if ItemIndex <> lst_Operationlist.ItemIndex then
  begin
    FactArtData.FillOperationToAListControls(lst_Operationlist.Items);
    Vle_Operation_Parlist.Strings.Clear;
    if lst_Operationlist.Items.Count <> 0 then
    begin
      lst_Operationlist.ItemIndex:=ifthen(ItemIndex = -1, 0, ItemIndex);
      SelectAOperation;
    end;
  end;
end;

procedure TFactArtInfoForm.cxbe_GF_NO_FNCardPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  RefreshFinishCardList;
end;

procedure TFactArtInfoForm.ClickOpenFactArt(Sender: TObject);
var
  i, CurStepNO: Integer;
  CheckedNode: TTreeNode;
  RepairList: TStringList;
  SubStrLen, SpacePos: Integer;
  CheckedNodeText, SelectCardList: String;
begin
  //ȡ���մ��źͼӹ�����
  CheckedNode:=nil;
  with tv_CardList do
  begin
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Item[i].Level = 1) and (TreeView_GetCheckState(Handle, Items.Item[i].ItemId) = 1) then
        CheckedNode:=Items.Item[i].Parent;
    end;
    if CheckedNode = nil then exit;
  end;

  CheckedNodeText:=CheckedNode.Text + ' ';
  SubStrLen:=pos('/', CheckedNodeText);
  SpacePos:=pos(' ', CheckedNodeText);
  FactArtData.FACT_Art_ID:=StrToInt(LeftStr(CheckedNodeText, SubStrLen - 1));
  SelectStepNO:=StrToInt(MidStr(CheckedNodeText, SubStrLen + 1, SpacePos - SubStrLen - 1));

  //ȡѡ��Ŀ���
  SelectCardList:='';
  with tv_CardList do
  for i := 0 to Items.Count - 1 do
    if TreeView_GetCheckState(Handle, Items.Item[i].ItemId) = 1 then
      SelectCardList:=SelectCardList + LeftStr(Items.Item[i].Text, 9) + ',';

  GetGIRemark(SelectCardList);
  //�򿪹���
  with FactArtData do
  begin
    GetJobTraceDtlInfo(SelectCardList, SelectStepNO);
    OpenFNArt;
    CardList:=SelectCardList;
    Internal_Repair:=Trim(cxbe_GFKeyValue.Text) = '';
    cbb_ReasonType.Enabled:=not Internal_Repair;
    cbb_ReasonName.Enabled:=not Internal_Repair;
  end;

  //�����ڻ��޹���
  tv_CardList.Enabled:=false;

  RepairList:=TStringList.Create;
  try
    RepairList.Delimiter:='/';
    RepairList.DelimitedText:=MidStr(CheckedNodeText, SpacePos + 1, MaxInt);

    if RepairList.Count <> 0 then
    begin
      RepairList.Delete(0);
      for i := 0 to RepairList.Count - 1 do
      begin
        CurStepNO:=FactArtData.AddAOperateStep(-1, RepairList.Strings[i]);
        if RightStr(FactArtData.GetStepOperateName(CurStepNO), 4) <> '����' then
          FactArtData.SetAOperateParameterValue(CurStepNO, '�ڻ���()', 'True');
      end;
    end;
  finally
    RepairList.Free;
  end;

  FactArtData.FillOperationToAListControls(lst_Operationlist.Items);
  Vle_Operation_Parlist.Strings.Clear;
end;

procedure TFactArtInfoForm.ChangeAEdit(Sender: TObject);
begin
  FactArtData.Modify:=True;
end;

procedure TFactArtInfoForm.KeyDownAComboBox(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_TAB:
    begin
      if (Sender as TComboBox).DroppedDown then
      begin
        Key:=0;
        PerForm(WM_NEXTDLGCTL, Ord(Shift = [ssShift]), 0);
      end
    end;
  end;
end;

procedure TFactArtInfoForm.Vle_Operation_ParlistEditButtonClick(Sender: TObject);
var
  Item_Value: String;
begin
  with Sender as TValueListEditor do
  begin
    if Pos('ȡ��', Trim(Cells[0,Row])) > 0 then
      Item_Value:=GetSampleNo(Cells[1,Row]);
    if Pos('�䷽', Trim(Cells[0,Row])) > 0 then
      Item_Value:=GetStdPrescriptionNo(FactArtData.GetStepOperateCode(Tag), 'F', Cells[1,Row]);

    if (Item_Value <> '') and (Item_Value <> Cells[Col,Row]) then
    begin
       Cells[Col,Row] := Item_Value;
      (Sender as TValueListEditor).OnValidate(Sender, Col, Row, Cells[0, Row], Cells[Col,Row]);
    end;
  end;
end;

procedure TFactArtInfoForm.KeyDownAControl(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i: Integer;
begin
  //����KeyDown
  if Sender = Self then
  case Key of
    VK_F5: RefreshFinishCardList;
    VK_F8: FactArtData.SaveArtToDataBase;
  end;

  //Ʒ���༭��KeyDown
  if Sender = cxbe_GFKeyValue then
  case Key of
    VK_RETURN: cxbe_GFKeyValue.Properties.OnButtonClick(cxbe_GFKeyValue, 0);
  end;

  //�����б�KeyDown
  if Sender = lst_Operationlist then
  case Key of
    VK_RETURN, VK_UP, VK_DOWN: SelectAOperation;
  end;

  //�����б� KeyDown
  if Sender = cbb_Operation_Name then
  case Key of
    VK_RETURN: btn_Add_Operation.Click;
  end;

  //������ KeyDown
  if Sender = tv_CardList then
  case Key of
    VK_RETURN: btn_OpenFactArt.Click;
    VK_SPACE:
    begin
      with tv_CardList do
      begin
        if (Selected = nil) or (Selected.Level = 0)then exit;

        if TreeView_GetCheckState(Handle, Selected.ItemId) = 1 then
        begin
          for i := 0 to Items.Count - 1 do
          begin
            if (Items.Item[i].Level = 1) and (Items.Item[i].Parent <> Selected.Parent) then
              TreeView_SetCheckState(Handle, Items.Item[i].ItemId, False);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFactArtInfoForm.pgc_OperationChange(Sender: TObject);
begin
  with Sender as TPageControl do
  begin
    btn_Add_Operation.Enabled:= (ActivePageIndex = 0) and (FactArtData.Active);
  end;
end;

procedure TFactArtInfoForm.Vle_Operation_ParlistKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if not Sender.ClassNameIs('TValueListEditor') then exit;

  with Sender as TValueListEditor do
  begin
    if Sender = Vle_Operation_Parlist then
    case Key of
      VK_UP, VK_DOWN:
      begin
        if ssShift in Shift then
        begin
          lst_Operationlist.SetFocus;
          SendMessage(lst_Operationlist.Handle, WM_KEYDOWN, Key, 0);
          Key:=0;
          Vle_Operation_Parlist.SetFocus;
        end
      end;
      VK_RETURN:
        SendMessage(Vle_Operation_Parlist.Handle, WM_KEYDOWN, VK_DOWN, 0);
    end;
  end;
end;

procedure TFactArtInfoForm.btn_ExitClick(Sender: TObject);
begin
  close;
end;

procedure TFactArtInfoForm.FormActivate(Sender: TObject);
begin
  Self.OnActivate:=nil;
  Application.ProcessMessages;
  //ˢ�½�������
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
  //��乤��ѡ����
  Dictionary.cds_OperationDtlList.Filter :='Use_Department LIKE ''%'+Login.CurrentDepartment + '%''';
  Dictionary.cds_OperationDtlList.Filtered := True;
  FillItemsFromDataSet(Dictionary.cds_OperationDtlList, 'Operation_Code', 'Operation_CHN', 'Iden', '--', cbb_Operation_Name.Items);
  //����õ����
  with Dictionary, Dictionary.cds_RepairReasonList do
  try
    Filter:='Quality_Type = ''����''';
    Filtered:=true;
    FillItemsFromDataSet(cds_RepairReasonList, 'Reason_Type', '', '','', cbb_ReasonType.Items);
  finally
    Filtered:=False;
  end;
end;

procedure TFactArtInfoForm.tv_CardListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
  DownTreeNode: TTreeNode;
begin
  with Sender as TTreeView do
  if htOnStateIcon in GetHitTestInfoAt(X, Y) then
  begin
    DownTreeNode:=GetNodeAt(X, Y);
    if TreeView_GetCheckState(Handle, DownTreeNode.ItemId) = 1 then
    begin
      for i := 0 to Items.Count - 1 do
      begin
        if (Items.Item[i].Level = 1) and (Items.Item[i].Parent <> DownTreeNode.Parent) then
          TreeView_SetCheckState(Handle,Items.Item[i].ItemId, False);
      end;
    end;
  end;
end;

procedure TFactArtInfoForm.btn_ViewArtDtlClick(Sender: TObject);
begin
  FactArtData.ViewArtDtlInNewForm;
end;

procedure TFactArtInfoForm.cbb_ReasonTypeSelect(Sender: TObject);
begin
  if cbb_ReasonType.ItemIndex = -1 then exit;
  
  with Dictionary, Dictionary.cds_RepairReasonList do
  try
    Filter:=Format('Reason_Type = ''%s'' AND Quality_Type = ''����''', [cbb_ReasonType.Text]);
    Filtered:=True;
    FillItemsFromDataSet(cds_RepairReasonList, 'Reason_Code', 'Reason_Info', '', '->', cbb_ReasonName.Items);
    if cbb_ReasonName.Items.Count <> 0 then
      cbb_ReasonName.ItemIndex := 0;
  finally
    Filtered:=False;
  end;
end;

procedure TFactArtInfoForm.GetGIRemark(sFNCard: String);
var
  sSQL, sErrMsg: WideString;
  vData: OleVariant;
begin
  if sFNCard= '' then Exit;
  
  sSQL := QuotedStr('GetQIRemark')+','+ QuotedStr(sFNCard);
  FNMServerObj.GetQueryData(vData, 'CommonSQL', sSQL, sErrMsg);
  if sErrMsg<>'' then
  begin
      TMsgDialog.ShowMsgDialog(sErrMsg,2);
  end;
  cdsRemark.Data := vData;

  if cdsRemark.IsEmpty then Exit;
  lblRemark.Caption := cdsRemark.FieldByName('Remark').AsString;
end;

end.
