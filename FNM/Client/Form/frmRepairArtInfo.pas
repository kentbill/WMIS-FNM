unit frmRepairArtInfo;
{*|<PRE>*****************************************************************************
                                                                             
       ������� FNM CLIENT MODEL
       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT
       ��Ԫ���� frmRepairArtInfo.pas                                           
       �������� 2004-8-30 ���� 07:17:54                                        
       ������Ա lvzd
       �޸���Ա                                                                
       �޸�����                                                                
       �޸�ԭ��
       ��Ӧ����                                                                
       �ֶ�����                                                                
       ������ݿ��                                                            
       ������Ҫ����/SQL����˵��                                                
       �������� �ƶ�����޹���
                                                                              
******************************************************************************}

interface

uses
  uFNMArtInfo, Windows, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ValEdit, ComCtrls, ExtCtrls, Buttons,
  cxControls, cxSplitter, DB, ADODB, DBClient;

type
  TRepairArtInfoForm = class(TForm)
    cxspl_XX: TcxSplitter;
    pnl_Only: TPanel;
    pnl_Only1: TPanel;
    txt1: TStaticText;
    edt_Customer: TEdit;
    edt_Grey_Width: TEdit;
    edt_Width: TEdit;
    edt_GreyDensity: TEdit;
    edt_Density: TEdit;
    edt_GF_NO: TEdit;
    btn_Help: TSpeedButton;
    btn_Exit: TSpeedButton;
    btn_SaveArt: TSpeedButton;
    pnl_Only2: TPanel;
    txt_Only: TStaticText;
    edt_FN_Shrinkage: TEdit;
    edt_Anti_Fluorescence: TEdit;
    edt_Designer: TEdit;
    edt_Designer_Time: TEdit;
    edt_Version: TEdit;
    lv_RepairCardList: TListView;
    edt_BR: TEdit;
    spl1: TSplitter;
    lst_Operationlist: TListBox;
    btn_MoveUP_Operation: TSpeedButton;
    btn_MoveDown_Operation: TSpeedButton;
    btn_Del_Operation: TSpeedButton;
    btn_Add_Operation: TSpeedButton;
    pgc_Operation: TPageControl;
    vle_Operation_Parlist: TValueListEditor;
    grp_Only: TGroupBox;
    mmo_Remark: TMemo;
    edt_FN_Art_NO1: TEdit;
    edt_ColorCode: TEdit;
    edt_FN_Art_NO4: TEdit;
    edt_FN_Art_NO2: TEdit;
    edt_Shrinkage: TEdit;
    edt_HandFeel: TEdit;
    btn_RefreshRepairFabric: TSpeedButton;
    btn_CreateFactArt: TSpeedButton;
    ts_Only: TTabSheet;
    cbb_Operation_Name: TComboBox;
    edt_ReedWidth: TEdit;
    btn_ViewArtDtl: TSpeedButton;
    btn_CheckRepairArt: TSpeedButton;
    edt_ProductWidth: TEdit;
    aqry1: TADOQuery;
    cbb_ReasonType: TComboBox;
    cbb_ReasonName: TComboBox;
    cdsCheckRecipe: TClientDataSet;
    chkIsQualityOperator: TCheckBox;
    btnFIInfo: TSpeedButton;
    CDS_StdHdr: TClientDataSet;
    CDS_StdDtl: TClientDataSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lst_OperationlistClick(Sender: TObject);
    procedure vle_Operation_ParlistValidate(Sender: TObject; ACol,
      ARow: Integer; const KeyName, KeyValue: String);
    procedure btn_Add_OperationClick(Sender: TObject);
    procedure btn_Operation(Sender: TObject);
    procedure KeyDownAControl(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChangeAEdit(Sender: TObject);
    procedure btn_CreateFactArtClick(Sender: TObject);
    
    procedure btn_SaveArtClick(Sender: TObject);
    procedure SaveRepairArt(var vData: OleVariant; vDataHdr,
  vDataDtl: OleVariant; var sErrorMsg: WideString);
    procedure vle_Operation_ParlistEditButtonClick(Sender: TObject);
    procedure vle_Operation_ParlistKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RefreshRepairFabircNO(Sender: TObject);
    procedure btn_ViewArtDtlClick(Sender: TObject);
    procedure pgc_OperationChange(Sender: TObject);
    procedure btn_CheckRepairArtClick(Sender: TObject);
    procedure cbb_ReasonTypeSelect(Sender: TObject);
    procedure cbb_ReasonNameSelect(Sender: TObject);
    procedure lv_RepairCardListDrawItem(Sender: TCustomListView;
      Item: TListItem; Rect: TRect; State: TOwnerDrawState);
    procedure lv_RepairCardListCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lv_RepairCardListColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure btnFIInfoClick(Sender: TObject);
  private
    { private declarations }
    RepairIden: Integer;
    SelectGFID: Integer;
    SelectCard: String;
    SelectQuantity: Double;
    RepairArt: TRepairArtDtlInfo;
    IsQualityOperator: Boolean;  //����
    {* ���޹��������}
    DumbList: TStringList;
    //�Ƿ��Ѽ��ر�׼����
    LoadStdArt:Integer;
    procedure ChangeEditControlEnable(EnableEdit: Boolean);
    procedure SelectAOperation;
    function GetSelectIden: String;
    function GetSelectGFID: String;
    function GetSelectCard: String;
    function GetSelectQuantity: Double;
    procedure CheckRecipe;

    procedure ArtAfterEdit(Sender: TObject);
    {* �����ձ��༭��,��FormCreate�¼���:StdArtData.OnAfterEdit:=ArtAfterEdit;}
    procedure ArtBeforeSave(Sender: TObject);
    {* ���ձ���֮ǰ��������ú���,��FormCreate�¼���:StdArtData.OnBeforeSave:=ArtBeforeSave;}
    procedure ArtAfterSave(Sender: TObject);
    {* �����ձ���ɹ���,��FormCreate�¼���:StdArtData.OnAfterSave:=ArtAfterSave;}
  public
    { Public declarations }
  end;

var
  RepairArtInfoForm: TRepairArtInfoForm;
implementation

uses frmCreateSample, uLogin, UFNMResource, ServerDllPub, uShowMessage,UAppOption,
     uCADInfo, uDictionary, Math, StrUtils, SysUtils, Variants, uGlobal, UGridDecorator, frmCreateStdPrescription,frmqiFabricList;

{$R *.dfm}

procedure TRepairArtInfoForm.SelectAOperation;
var
  Step_NO: Integer;
begin
  if lst_Operationlist.ItemIndex <> -1 then
  begin
    Step_NO:=Integer(lst_Operationlist.Items.Objects[lst_Operationlist.ItemIndex]);
    if (Vle_Operation_Parlist.Tag <> Step_NO) or (Vle_Operation_Parlist.Strings.Count = 0) then
    begin
      RepairArt.FillAStepToAListControls(Step_NO, Vle_Operation_Parlist);
      Vle_Operation_Parlist.Tag:=Step_NO;
    end;
  end;
  Vle_Operation_Parlist.Enabled:=Vle_Operation_Parlist.Strings.Count > 0;
  //�����೤����ֻ�����빤�����������
  if IsQualityOperator then
    Vle_Operation_Parlist.Options:=Vle_Operation_Parlist.Options + [goEditing]
  else
    Vle_Operation_Parlist.Options:=Vle_Operation_Parlist.Options + [goEditing];


  if lst_Operationlist.Focused then
    pgc_Operation.ActivePageIndex := 1;
end;

function TRepairArtInfoForm.GetSelectIden: String;
var
  i: Integer;
begin
  result:='';
  with lv_RepairCardList.Items do
  for I := 0 to Count - 1 do
  begin
    if Item[i].Checked then
    begin
      if result = '' then
        result := Item[i].SubItems.Strings[4]
      else
      begin
        if (result <> '0') and (result <> Item[i].SubItems.Strings[4]) then
          raise Exception.CreateRes(@INV_IdenDifferent);
      end;
    end;
  end;
  if result = '' then
    raise Exception.CreateRes(@INV_NOCardSelected);
end;


function TRepairArtInfoForm.GetSelectGFID: String;
var
  i: Integer;
begin
  result:='';
  with lv_RepairCardList.Items do
  for I := 0 to Count - 1 do
  begin
    if Item[i].Checked then
    begin
      if result = '' then
        result := Item[i].SubItems.Strings[3]
      else
      begin
        if result <> Item[i].SubItems.Strings[3] then
          raise Exception.CreateRes(@INV_GFIDDifferent);
      end;
    end;
  end;
  if result = '' then
    raise Exception.CreateRes(@INV_NOCardSelected);
end;

function TRepairArtInfoForm.GetSelectCard: String;
var
  i: Integer;
begin
  Result := '';
  with lv_RepairCardList.Items do
    for i := 0 to Count - 1 do
      if Item[i].Checked then
        Result :=Result + Item[i].Caption + ',';
  if Result = '' then
    raise Exception.CreateRes(@INV_NOSelectRepairFabricNO);
end;

function TRepairArtInfoForm.GetSelectQuantity: Double;
var
  i: Integer;
begin
  Result := 0;
  with lv_RepairCardList.Items do
    for I := 0 to Count - 1 do
      if Item[i].Checked then
        Result := Result + StrToFloat(Item[i].SubItems.Strings[1]);
end;

procedure TRepairArtInfoForm.ChangeEditControlEnable(EnableEdit: Boolean);
begin
  if not EnableEdit then
  begin
    edt_GF_NO.Text:='';
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
    edt_FN_Art_NO2.Text:='';
    edt_FN_Art_NO4.Text:='';
    edt_FN_Art_NO1.Text:='';
    edt_ColorCode.Text:='';
    edt_Shrinkage.Text:='';

    lst_Operationlist.Clear;
    mmo_Remark.Lines.Clear;
    Vle_Operation_Parlist.Enabled:=EnableEdit;
    Vle_Operation_Parlist.Strings.Clear;
  end;

  btn_Add_Operation.Enabled:=EnableEdit and (pgc_Operation.ActivePageIndex = 0);
  btn_Del_Operation.Enabled:=EnableEdit;
  btn_MoveDown_Operation.Enabled:=EnableEdit;
  btn_MoveUP_Operation.Enabled:=EnableEdit;
  lst_Operationlist.Enabled:=EnableEdit;
  mmo_Remark.Enabled:=EnableEdit;
end;

procedure TRepairArtInfoForm.ArtAfterEdit(Sender: TObject);
begin
  //���ձ��༭�¼�
  btn_SaveArt.Enabled:=RepairArt.Modify;
end;

procedure TRepairArtInfoForm.ArtBeforeSave(Sender: TObject);
begin
  if cbb_ReasonName.Text = '' then
  begin
    raise Exception.CreateRes(@INV_NOSelectRepairReason);
    cbb_ReasonName.SetFocus;
    Exit;
  end;

  with Sender as TRepairArtDtlInfo do
  begin
    Operator:=Login.LoginName;
    Remark:=mmo_Remark.Text;
    CardList:= GetSelectCard;
  end;
end;

procedure TRepairArtInfoForm.ArtAfterSave(Sender: TObject);
var
  i: Integer;
begin
  with lv_RepairCardList.Items, Sender as TRepairArtDtlInfo do
  for i := Count - 1 downto 0 do
  begin
    if Pos(Item[i].Caption, CardList) <> 0 then
      Item[i].Delete;
    next;
  end;
  RepairIden := -1;
  SelectGFID := -1;
  SelectQuantity := 0;
  SelectCard := '';
  cbb_ReasonType.Text := '';
  cbb_ReasonName.Text := '';
end;

procedure TRepairArtInfoForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caNone;
  if not RepairArt.CloseArt then exit;
  Action:=caFree;
end;

procedure TRepairArtInfoForm.FormDestroy(Sender: TObject);
begin
  DumbList.Free;
  RepairArtInfoForm := nil;
end;

procedure TRepairArtInfoForm.FormCreate(Sender: TObject);
begin
  DumbList := TStringList.Create;
  IsQualityOperator := (Login.UserLevelList = '') or (Pos('1',Login.UserLevelList) > 0);
  //����ͼ��
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btn_SaveArt.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Help.Glyph.LoadFromResourceName(HInstance, RES_HELPABOUT);
  btn_CreateFactArt.Glyph.LoadFromResourceName(HInstance, RES_NEW);
  btn_Add_Operation.Glyph.LoadFromResourceName(HInstance, RES_LEFT);
  btn_RefreshRepairFabric.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btn_Del_Operation.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btn_MoveUP_Operation.Glyph.LoadFromResourceName(HInstance, RES_MOVEUP);
  btn_MoveDown_Operation.Glyph.LoadFromResourceName(HInstance, RES_MOVEDOWN);
  //TListView��˫���¼�
  lv_RepairCardList.OnDblClick:=TGlobal.DblClickAListview;
  //TWinControl��˫���¼�
  cbb_Operation_Name.OnDblClick:=TGlobal.DblClickAWinControl;

  //���ý���
  btn_SaveArt.Enabled:=false;
  ChangeEditControlEnable(false);

  (btn_RefreshRepairFabric as TControl).Align:=alLeft;
  (btn_CreateFactArt as TControl).Align:=alClient;
  (cbb_Operation_Name as TControl).Align:=alClient;
  pnl_Only2.Align:=alClient;
  pgc_Operation.ActivePageIndex:=0;
  //����ʵ�ʹ�����
  RepairArt:=TRepairArtDtlInfo.Create(Self);
  RepairArt.OnAfterEdit:=ArtAfterEdit;
  RepairArt.OnBeforeSave:=ArtBeforeSave;
  RepairArt.OnAfterSave:=ArtAfterSave;
end;

procedure TRepairArtInfoForm.lst_OperationlistClick(Sender: TObject);
begin
  SelectAOperation;
end;

procedure TRepairArtInfoForm.vle_Operation_ParlistValidate(Sender: TObject; ACol, ARow: Integer; const KeyName, KeyValue: String);
var
  ItemValue: string;
begin
  try
    Vle_Operation_Parlist.OnValidate:=nil;

    if KeyName = '' then Exit;

    if RepairArt.Active then
    begin
      ItemValue:=RepairArt.SetAOperateParameterValue(Vle_Operation_Parlist.Tag, Trim(KeyName), Trim(KeyValue));

      Vle_Operation_Parlist.Cells[ACol, ARow]:=ItemValue;
    end;
  finally
    Vle_Operation_Parlist.OnValidate:=Vle_Operation_ParlistValidate;
  end;
end;

procedure TRepairArtInfoForm.btn_Add_OperationClick(Sender: TObject);
var
  OperationID: Integer;
begin
  if not btn_Add_Operation.Enabled then exit;

  with cbb_Operation_Name do
  begin
    if (Text = '') or (Items.IndexOf(Text) = -1)then exit;
    OperationID:=Integer(Items.Objects[Items.IndexOf(Text)]);
    Text:='';
  end;

  //�������
  RepairArt.AddAOperateStep(OperationID);

  //�����ǰѡ��Ĺ���Ϊԭ��׼�����еĹ���,��ѭ������ù������Ĺ��򵽻��޹����� chengg 2016-8-20
  if (LoadStdArt=0) and (CDS_StdDtl.Active) then
  begin
    CDS_StdDtl.First;
    while not CDS_StdDtl.Eof do
    begin
      IF CDS_StdDtl.FieldByName('OperationID').AsInteger=OperationID then
      begin
        CDS_StdDtl.Next;
        while not CDS_StdDtl.Eof do
        Begin
          OperationID:= CDS_StdDtl.FieldByName('OperationID').AsInteger;
          RepairArt.AddAOperateStep(OperationID);
          CDS_StdDtl.Next;
        end;
        LoadStdArt:=1;
      end;
      CDS_StdDtl.Next;
    end;

  end;

  //���沼��
  RepairArt.FillOperationToAListControls(lst_Operationlist.Items);
  lst_Operationlist.ItemIndex:=lst_Operationlist.Count -1;
  SelectAOperation;
end;

procedure TRepairArtInfoForm.btn_Operation(Sender: TObject);
var
  ItemIndex, Step_NO: Integer;
begin
  ItemIndex:=lst_Operationlist.ItemIndex;
  if ItemIndex = -1 then exit;
  
  Step_NO:=Integer(lst_Operationlist.Items.Objects[ItemIndex]);

  //�û�����btn_Del_Operation��ť
  if Sender = btn_Del_Operation then
  begin
    RepairArt.MoveAOperateStep(Step_NO, ooDelete);
    ItemIndex:=ItemIndex-1
  end;

  //�û�����btn_MoveDown_Operation��ť
  if Sender = btn_MoveDown_Operation then
  begin
    if ItemIndex < lst_Operationlist.Count - 1 then
    begin
      RepairArt.MoveAOperateStep(Step_NO, ooMoveDown);
      ItemIndex:=ItemIndex+1
    end;
  end;

  //�û�����btn_MoveUP_Operation��ť
  if Sender = btn_MoveUP_Operation then
  begin
    if ItemIndex > 0 then
    begin
      RepairArt.MoveAOperateStep(Step_NO, ooMoveUP);
      ItemIndex:=ItemIndex-1
    end;
  end;

  //���沼��
  if ItemIndex <> lst_Operationlist.ItemIndex then
  begin
    RepairArt.FillOperationToAListControls(lst_Operationlist.Items);
    Vle_Operation_Parlist.Strings.Clear;
    if lst_Operationlist.Items.Count <> 0 then
    begin
      lst_Operationlist.ItemIndex:=ifthen(ItemIndex = -1, 0, ItemIndex);
      SelectAOperation;
    end;
  end;
end;

procedure TRepairArtInfoForm.KeyDownAControl(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Sender = Self then
  case Key of
    VK_F5: btn_RefreshRepairFabric.Click;
   VK_F8: RepairArt.SaveArtToDataBase(IsQualityOperator,RepairIden,SelectGFID,SelectQuantity,LeftStr(cbb_ReasonName.Text,5), Login.CurrentDepartment,Login.LoginName);
  end;

  //������ KeyDown
  if Sender = lst_Operationlist then
  case Key of
    VK_RETURN, VK_UP, VK_DOWN: SelectAOperation;
  end;

  //������ KeyDown
  if Sender = cbb_Operation_Name then
  case Key of
    VK_RETURN: btn_Add_Operation.Click;
  end;

  //�����б� KeyDown
  if Sender = lv_RepairCardList then
  case Key of
    VK_RETURN: btn_CreateFactArt.Click;
  end;
end;

procedure TRepairArtInfoForm.ChangeAEdit(Sender: TObject);
begin
  RepairArt.Modify:=True;
end;

procedure TRepairArtInfoForm.btn_CreateFactArtClick(Sender: TObject);
var
  TheFN_Art_NO,SqlText: String;
  SubStrLen: Integer;
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  RepairIden := StrToInt(GetSelectIden);
  SelectGFID:=StrToInt(GetSelectGFID);
  SelectCard := GetSelectCard;
  SelectQuantity := GetSelectQuantity;

  //�������޹���(�ӱ�׼���տ���)
  RepairArt.CreateRepairArt(RepairIden, SelectGFID, SelectCard, Login.CurrentDepartment, Login.LoginName);

  TheFN_Art_NO:=RepairArt.FN_Art_NO;
  SubStrLen:=pos(';', TheFN_Art_NO);
  edt_FN_Art_NO1.Text:=LeftStr(TheFN_Art_NO, SubStrLen - 1);
  System.Delete(TheFN_Art_NO, 1, SubStrLen);

  SubStrLen:=pos(';', TheFN_Art_NO);
  edt_FN_Art_NO2.Text:=LeftStr(TheFN_Art_NO, SubStrLen - 1);
  System.Delete(TheFN_Art_NO, 1, SubStrLen);

  SubStrLen:=pos(';', TheFN_Art_NO);
  edt_FN_Art_NO4.Text:=LeftStr(TheFN_Art_NO, SubStrLen - 1);
  System.Delete(TheFN_Art_NO, 1, SubStrLen);

  edt_ColorCode.Text:=RepairArt.FN_Color_Code;
  edt_Shrinkage.Text:=RepairArt.Shrinkage;
  edt_HandFeel.Text:=RepairArt.HandFeel;
  edt_ProductWidth.Text:=RepairArt.Product_Width;

  mmo_Remark.Text := RepairArt.Remark;
  edt_Version.Text := '-1';
  edt_Designer.Text := RepairArt.Operator;
  edt_Designer_Time.Text := RepairArt.Operate_Time;
  cbb_ReasonType.Text := RepairArt.Reason_Type;
  cbb_ReasonName.Text := RepairArt.Reason_Info;

   //��乤��
  RepairArt.FillOperationToAListControls(lst_Operationlist.Items);

  //��ʾCAD��Ϣ
  with CADInfo do
  begin
    OrgGFKeyValue:=RepairArt.GF_ID;
    edt_Width.Text:=Width;
    edt_BR.Text:=BRUnitUsage;
    edt_Density.Text:=Density;
    edt_GF_NO.Text:=GF_NO;
    edt_Customer.Text:=Customer_Code;
    edt_FN_Shrinkage.Text:=Shrinkage;
    edt_Grey_Width.Text:=CADInfo.GreyWidth;
    edt_ReedWidth.Text:=CADInfo.Reed_Width;
    edt_GreyDensity.Text:=CADInfo.GreyDensity;
    edt_Anti_Fluorescence.Text:=FluorescencePercent;
  end;
    //��ʾCAD������Ϣ
  AutoShowCADPicture(CADInfo.OrgGFKeyValue);
   //��ȡ��׼����
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('���ڻ�ȡ�����Եȣ�', crHourGlass);
   //��ȡ��׼��������Ϣ
    LoadStdArt:=0;
    sqltext := 'SELECT DISTINCT A.Art_ID FROM  fnmdb.dbo.uvw_fnStdArtHdr A WITH(NOLOCK) WHERE  a.gf_id='+ inttostr(RepairArt.GF_ID) + ' AND a.Current_Department=' + QuotedStr(Login.CurrentDepartment) + ' AND a.Is_Active=1';
    FNMServerObj.GetQueryBySQL(vData, sqltext, sErrorMsg);

    if sErrorMsg <> '' then
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError)
    else
      CDS_StdHdr.Data := vData;

    if CDS_StdHdr.IsEmpty then
      TMsgDialog.ShowMsgDialog('û�в鵽��׼������Ϣ',2)
    else if CDS_StdHdr.RecordCount>1 then
       TMsgDialog.ShowMsgDialog('�ж����׼����,�����˹���ѯ��׼�����е���Ϣ�ƶ����޹���',2)
    else
    begin
     //��ȡ��׼������ϸ��Ϣ
      sqltext := 'SELECT DISTINCT Step_NO, a.Operation_Code,B.Iden As OperationID  FROM dbo.fnStdArtDtl a WITH(NOLOCK) inner join '
                +'fnmdb.dbo.fnOperationHdrList b with(nolock) on a.Operation_Code=b.Operation_Code '
                +'WHERE STD_Art_ID ='+ CDS_StdHdr.fieldbyname('Art_ID').asstring + '  ORDER BY Step_NO';
      FNMServerObj.GetQueryBySQL(vData, sqltext, sErrorMsg);
      if sErrorMsg <> '' then
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError)
      else
       CDS_StdDtl.Data := vData;
    end;


  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;


  //���ý���
  ChangeEditControlEnable(RepairArt.Active);
end;

procedure TRepairArtInfoForm.SaveRepairArt(var vData: OleVariant; vDataHdr,
  vDataDtl: OleVariant; var sErrorMsg: WideString);
const
 // David Add 2014-10-09 begin, �Զ����ɻ��޹���
 UPDATE_REPAIR_HDR_SQL = 'UPDATE dbo.fnFactArtHdr SET Operator=''%s'' ' +
        'WHERE FN_Card=''%s'''+#13#10;
 DELETE_REPAIR_DTL_SQL = 'DELETE dbo.fnFactArtDtl WHERE Fact_Art_ID=''%s''' +#13#10;
 // David Add 2014-10-09 end, �Զ����ɻ��޹���
 INSERT_REPAIR_HDR_SQL = 'INSERT INTO dbo.fnFactArtHdr (GF_ID, STD_Art_ID, STD_Art_Version, Art_Type, Material_Quality, Operator, Remark) '+
                         'VALUES(''%s'', -1, 0, ''%s'', ''%s'', ''%s'', ''%s'')' +#13#10;
 INSERT_REPAIR_DTL_SQL = 'INSERT INTO dbo.fnFactArtDtl (Fact_Art_ID, Step_NO, Operation_Code, Item_Name, Item_Value, Operator, Operate_Time) '+
                         'VALUES(@Fact_Art_ID, ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'') ' +#13#10;
 INSERT_REPAIROPERATION_SQL0 = 'INSERT INTO dbo.fnRepairOperation (GF_ID,Quantity,FN_Card, Reason_Code, Internal_External, Repair_Operation, Current_Department, Operator, Operate_Time) '+
                              'VALUES(''%s'',''%s'',''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', GETDATE())' +#13#10;
 INSERT_REPAIROPERATION_SQL1 = 'INSERT INTO dbo.fnRepairOperation (GF_ID,Quantity,FN_Card, Reason_Code, Internal_External, Repair_Operation, Current_Department, Operator, Operate_Time, Checker, Check_Time) '+
                              'VALUES(''%s'',''%s'',''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', GETDATE(), ''%s'',GETDATE())' +#13#10;
 UPDATE_REPAIROPERATION_SQL0 = 'UPDATE dbo.fnRepairOperation  SET GF_ID = ''%s'', Quantity = ''%s'',FN_Card = ''%s'', Reason_Code = ''%s'', Internal_External= ''%s'', Repair_Operation= ''%s'', Current_Department= ''%s'','+
                              ' Operator = ''%s'', Operate_Time = GETDATE() '+
                              ' WHERE Check_Time IS NULL AND Iden = ''%s'''+#13#10;
 UPDATE_REPAIROPERATION_SQL1 = 'UPDATE dbo.fnRepairOperation  SET Checker = ''%s'', Check_Time = GETDATE() '+
                              ' WHERE Check_Time IS NULL AND Iden = ''%s'''+#13#10;
var
  i: Integer;
  SqlText, FNCardList: String;
  cds_Art: TClientDataSet;
begin
  SqlText := '';
  //���½��ȸ��ټ�¼
  FNCardList:= vData[0][4];
  while FNCardList[Length(FNCardList)] = ',' do
    System.Delete(FNCardList, Length(FNCardList), 1);
  FNCardList:='(''' + StringReplace(FNCardList, ',', ''',''', [rfReplaceAll]) + ''')';
  
  if vData[0][0] = 1 then //IsQualityOperator
  begin
    if vData[0][1] = 0 then  //new
      SqlText :=  SqlText + Format(INSERT_REPAIROPERATION_SQL0,[vData[0][2],vData[0][3],vData[0][4],vData[0][5],vData[0][6],vData[0][7],vData[0][8],vData[0][9]])
     else  //edit
      SqlText :=  SqlText + Format(UPDATE_REPAIROPERATION_SQL0,[vData[0][2],vData[0][3],vData[0][4],vData[0][5],vData[0][6],vData[0][7],vData[0][8],vData[0][9],vData[0][1]]);
  end else
  begin
    if vData[0][1] = 0 then  //new
      SqlText :=  SqlText + Format(INSERT_REPAIROPERATION_SQL1,[vData[0][2],vData[0][3],vData[0][4],vData[0][5],vData[0][6],vData[0][7],vData[0][8],vData[0][9],vData[0][9]])
     else  //edit
      SqlText :=  SqlText + Format(UPDATE_REPAIROPERATION_SQL1,[vData[0][9],vData[0][1]]);
  end;
  if  vData[0][0] <> 1 then
  begin
    cds_Art:=nil;
    try
      cds_Art:=TClientDataSet.Create(nil);
        cds_Art.Data:=vDataHdr;
        SqlText := SqlText + 'DECLARE @Fact_Art_ID Int '#13#10;
        with cds_Art do
        begin
        // David 2014-10-09 �޸ģ�ĳЩ�������ʹõ���ڴ�ʱ���ɹ��գ���Ҫ�����ж��Ƿ��Ѿ����ɹ���
        // ����42677 �ƶ����޹��գ��ο� usp_fnAutoGenerateRepairParas
        SqlText :=  SqlText + 'SET @Fact_Art_ID=-1' + #13#10;
        SqlText :=  SqlText + FORMAT('SELECT TOP 1 @Fact_Art_ID=Fact_Art_ID FROM dbo.fnRepairCardAutoFactArtID WHERE FN_Card=''%s''', [FNCardList]);
        SqlText :=  SqlText + 'IF @Fact_Art_ID>0' + #13#10;
        SqlText :=  SqlText + 'BEGIN'+ #13#10;
          // ����Ѿ����ɹ��տ�ʼ David
          SqlText :=  SqlText + Format(UPDATE_REPAIR_HDR_SQL, [FieldByName('Operator').AsString, FNCardList]) + #13#10;
          SqlText :=  SqlText + Format(DELETE_REPAIR_DTL_SQL, ['@Fact_Art_ID'])+ #13#10;
          // ����Ѿ����ɹ��ս��� David
        SqlText :=  SqlText + 'END'+ #13#10;
        
        SqlText :=  SqlText + 'ELSE'+ #13#10;
        SqlText :=  SqlText + 'BEGIN'+ #13#10;
          // ���û�����ɹ��� begin, David
          SqlText := SqlText + Format(INSERT_REPAIR_HDR_SQL,[FieldByName('GF_ID').AsString,
                                                             FieldByName('Art_Type').AsString,
                                                             FieldByName('Material_Quality').AsString,
                                                             FieldByName('Operator').AsString,
                                                             FieldByName('Remark').AsString]);

          SqlText := SqlText + 'SET @Fact_Art_ID =IDENT_CURRENT(''fnFactArtHdr'') '+ #13#10;
          // ���û�����ɹ��� end, David
        SqlText :=  SqlText + 'END'+ #13#10;
          
          
          cds_Art.Data:=vDataDtl;
          for i := 0 to RecordCount - 1 do
          begin
            SqlText:=SqlText + Format(INSERT_REPAIR_DTL_SQL,[FieldByName('Step_NO').AsString,
                                                             FieldByName('Operation_Code').AsString,
                                                             FieldByName('Item_Name').AsString,
                                                             FieldByName('Item_Value').AsString,
                                                             FieldByName('Operator').AsString,
                                                             FieldByName('Operate_Time').AsString]);
            Next;
          end;
          //����ͷ(000)β(999)����
          SqlText:=SqlText + 'EXEC dbo.usp_InsertHeadOperate @Fact_Art_ID ' + #13#10;
        end;
    finally
      FreeAndNil(cds_Art);
    end;
  end;
 

  if vData[0][0] = 1 then //IsQualityOperator    //���ڲ����೤���빤��ʱ������ȡ
    SqlText := SqlText + 'UPDATE dbo.fnJobTraceHdr SET Fact_Art_ID = -999 ' +
                          Format('WHERE FN_Card IN %s '#13#10, [FNCardList])
  else
    SqlText := SqlText + 'UPDATE fnJobTraceHdr SET FACT_Art_ID = @Fact_Art_ID, Step_NO = 1, Operation_Code = dbo.udf_GetOperationCode(@Fact_Art_ID, 1) '+
                          Format('WHERE FN_Card IN %s '#13#10, [FNCardList]);

  //������չ������޹���
  if vData[0][0] <> 1 then
    SqlText := SqlText + ' EXEC dbo.usp_SaveRepairArtEx @Fact_Art_ID ';

end;
procedure TRepairArtInfoForm.btn_SaveArtClick(Sender: TObject);
begin
  lv_RepairCardList.SetFocus;
  CheckRecipe;
  // David for test, set quality as true.
  RepairArt.SaveArtToDataBase(IsQualityOperator, RepairIden,SelectGFID,SelectQuantity, LeftStr(cbb_ReasonName.Text,5), Login.CurrentDepartment,Login.LoginName);
  RepairArt.CloseArt;
end;

procedure TRepairArtInfoForm.CheckRecipe;
var
 sSQL,sErrorMsg : WideString;
  vData:OleVariant;
  sCards:string;
begin
  sCards := GetSelectCard;
  sSQL := QuotedStr(sCards) + ',1';
  FNMServerObj.GetQueryData(vData, 'CheckRecipeRole', sSQL, sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
  end;
  cdsCheckRecipe.Data := vData;
  if cdsCheckRecipe.RecordCount > 0 then
  begin
    if cdsCheckRecipe.FieldByName('Alert_text').AsString <> '' then
      TMsgDialog.ShowMsgDialog(cdsCheckRecipe.FieldByName('Alert_text').AsString, mtWarning);
  end;
end;

procedure TRepairArtInfoForm.vle_Operation_ParlistEditButtonClick(Sender: TObject);
var
  Item_Value: String;
begin
  with Sender as TValueListEditor do
  begin
    if Pos('ȡ��', Trim(Cells[0,Row])) > 0 then
      Item_Value:=GetSampleNo(Cells[1,Row]);
    if Pos('�䷽', Trim(Cells[0,Row])) > 0 then
      Item_Value:=GetStdPrescriptionNo(RepairArt.GetStepOperateCode(Tag), 'R',Cells[1,Row]);

    if (Item_Value <> '') and (Item_Value <> Cells[Col,Row]) then
    begin
       Cells[Col,Row] := Item_Value;
      (Sender as TValueListEditor).OnValidate(Sender, Col, Row, Cells[0, Row], Cells[Col,Row]);
    end;
  end;
end;

procedure TRepairArtInfoForm.vle_Operation_ParlistKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TRepairArtInfoForm.btn_ExitClick(Sender: TObject);
begin
  close;
end;

procedure TRepairArtInfoForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  //ˢ�½�������
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
   //��乤��ѡ����
  Dictionary.cds_OperationDtlList.Filter :='Use_Department LIKE ''%'+Login.CurrentDepartment + '%''';
  Dictionary.cds_OperationDtlList.Filtered := False;
  FillItemsFromDataSet(Dictionary.cds_OperationDtlList, 'Operation_Code', 'Operation_CHN', 'Iden', '--', cbb_Operation_Name.Items);

  //����õ����
  with Dictionary,Dictionary.cds_RepairReasonList do
  try
    if Pos('1',Login.UserLevelList)>0  then
       Filter:='Quality_Type = '+QuotedStr('����')
    else if Pos('2',Login.UserLevelList)>0 then
      Filter:='Quality_Type = '+QuotedStr('����')
    else
      Filter:='';

    Filtered:=False;
    FillItemsFromDataSet(Dictionary.cds_RepairReasonList, 'Reason_Type', '', '','', cbb_ReasonType.Items);
  finally
     Filtered:=False;
  end;

  OnActivate:=nil;
end;

procedure TRepairArtInfoForm.RefreshRepairFabircNO(Sender: TObject);
var
  vData: OleVariant;
  sErrorMsg: WideString;
  sCD: string;
  sql: WideString; // Added by WuDev 2016/9/9 15:47:04
begin
  cbb_ReasonType.Text := '';
  cbb_ReasonName.Text := '';
  if RepairArt.Active then
    RepairArt.CloseArt;
  ChangeEditControlEnable(False);
  //ˢ�·��������б�
  sCD:=Login.CurrentDepartment;
  // Modified by WuDev 2016/9/9 15:25:41  ���ô洢���ؽ������Ȼ��Ҫ�Ķ��м������
 // FNMServerArtObj.GetNoArtRepairCard(Login.CurrentDepartment, vData, sErrorMsg);
  sql:= 'Exec GetNoArtRepairCard '+quotedstr(Login.CurrentDepartment);
  FNMServerObj.GetQueryBySQL(vData, sql, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetRepairFNCard, [sErrorMsg]);
  TempClientDataSet.Data:=vData;
  if TempClientDataSet.IsEmpty then
    raise Exception.CreateRes(@EMP_RepairFNCard);
  //���˲����೤�Ŀ���
  {
  if Pos('1',Login.UserLevelList) > 0 then
    TempClientDataSet.Filter := 'Repair_Reason like ''%����%'''
  else //if Pos('2',Login.UserLevelList)>0 then
    TempClientDataSet.Filter := 'not Repair_Reason like ''%����%'' OR RepairIden <> 0';
    }
//  else
//    TempClientDataSet.Filter := '';

  //�ȴ��ƶ���׼���գ�Ȼ���ڲ��رմ��������´��ƶ����޹���
  //�ͻ������Ϊ��������֮������һ��������TempClientDataSet��Ȼ���л�֮��û����չ���������Ҳ����Ǹ��ֶΡ�
  // support  151422
  TempClientDataSet.Filter := '';

  TempClientDataSet.Filtered := True;
  FillListItemsFromDataSet(TempClientDataSet, 'FN_Card', 'GF_ID', ['GF_NO', 'Quantity', 'Repair_Reason','GF_ID','RepairIden','Internal_Repair_Times','External_Repair_Times'], lv_RepairCardList.Items);
  TempClientDataSet.Filtered := False;
end;

procedure TRepairArtInfoForm.btn_ViewArtDtlClick(Sender: TObject);
begin
  RepairArt.ViewArtDtlInNewForm;
end;

procedure TRepairArtInfoForm.pgc_OperationChange(Sender: TObject);
begin
  with Sender as TPageControl do
  begin
    btn_Add_Operation.Enabled:= (ActivePageIndex = 0) and (RepairArt.Active);
  end;
end;

procedure TRepairArtInfoForm.btn_CheckRepairArtClick(Sender: TObject);
begin
  if btn_SaveArt.Enabled then btn_SaveArt.Click;
  RepairArt.CloseArt;
end;

procedure TRepairArtInfoForm.cbb_ReasonTypeSelect(Sender: TObject);
begin
  if Sender = cbb_ReasonType then
  begin
    cbb_ReasonName.ItemIndex:= -1;
    if cbb_ReasonType.ItemIndex = -1 then exit;
    with Dictionary, Dictionary.cds_RepairReasonList do
    try
      if Pos('1',Login.UserLevelList)>0 then
        Filter:='Quality_Type = '+QuotedStr('����') + ' AND Reason_Type = ' +QuotedStr(cbb_ReasonType.Text)
      else if Pos('2',Login.UserLevelList)>0 then
        Filter:='Quality_Type = '+QuotedStr('����') + ' AND Reason_Type = ' +QuotedStr(cbb_ReasonType.Text)
      else
        Filter:= 'Reason_Type = ' +QuotedStr(cbb_ReasonType.Text);
      Filtered:=false;
      FillItemsFromDataSet(cds_RepairReasonList, 'Reason_Code', 'Reason_Info', '', '->', cbb_ReasonName.Items);
    finally
      Filtered:=False;
    end;
  end;
end;

procedure TRepairArtInfoForm.cbb_ReasonNameSelect(Sender: TObject);
var
  i: Integer;
begin
  //������еĹ���
  RepairArt.ClearAllOperateStep;

  if cbb_ReasonName.ItemIndex = -1 then exit;
   //�������
  if Dictionary.cds_RepairReasonList.Locate('Reason_Code',LeftStr(cbb_ReasonName.Text ,5),[]) then
  begin
    DumbList.Delimiter := '/';
    DumbList.DelimitedText := Dictionary.cds_RepairReasonList.FieldByName('Repair_Operation').AsString;
    for i := 0 to DumbList.Count - 1 do
      RepairArt.AddAOperateStep(-1,DumbList.Strings[i]);
   //���沼��
    RepairArt.FillOperationToAListControls(lst_Operationlist.Items);
    lst_Operationlist.ItemIndex:=lst_Operationlist.Count -1;
    SelectAOperation;
  end;  
end;

procedure TRepairArtInfoForm.lv_RepairCardListDrawItem(
  Sender: TCustomListView; Item: TListItem; Rect: TRect;
  State: TOwnerDrawState);
begin
  if Item.SubItems[4] <> '0' then
    lv_RepairCardList.Canvas.Font.Color := clBlue;
end;

procedure TRepairArtInfoForm.lv_RepairCardListCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
   if Item.SubItems[4] <> '0' then
    lv_RepairCardList.Canvas.Font.Color := clBlue;
end;

procedure TRepairArtInfoForm.lv_RepairCardListColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  TGlobal.SortListView(lv_RepairCardList,Column);
end;

procedure TRepairArtInfoForm.btnFIInfoClick(Sender: TObject);
var
  FN_Card_List: string;
begin
  FN_Card_List:= GetSelectCard;
  IF  FN_Card_List='' THEN
  begin
    TMsgDialog.ShowMsgDialog('��ѡ�񿨺�',2);
    Exit;
  end;
  FN_Card_List:=copy(FN_Card_List,1,length(FN_Card_List)-1);
  FN_Card_List:=StringReplace(FN_Card_List, ',',''',''',[rfReplaceAll]);
   with TqiFabricListForm.Create(nil) do
         begin
            try
               GetFabricInfoList(FN_Card_List); //���ݲ�ѯ
               showmodal;
            except
               close;
               free;
            end;
         end;

end;


end.


