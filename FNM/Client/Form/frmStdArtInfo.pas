unit frmStdArtInfo;
{*|<PRE>*****************************************************************************
                                                                             
       ������� FNM CLIENT MODEL
       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                              
       ��Ԫ���� frmStdArtInfo.pas                                              
       �������� 2004-8-30 ���� 04:26:18
       ������Ա lvzd
       ��Ӧ����
        2.1.	�ƶ���׼����
       ������ݿ��:
        1: fnStdArtHdr
        2: fnStdArtDtl
       ������Ҫ����/SQL����˵��
        1: �����м�㺯��:FNMServerArtObj.GetNoArtOrCheckGFNO
       ��������:
        ����, �޸�, ȷ�ϱ�׼����                                                                
                                                                              
******************************************************************************}

interface

uses
  uFNMArtInfo, Forms, SysUtils, Windows, Graphics, Messages, Menus,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, StdCtrls,
  Grids, ValEdit, ExtCtrls, cxSplitter, Tabs, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGrid, Controls, ComCtrls, Buttons, Classes, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData,
  cxGridDBTableView, DBClient, DBGrids;

type
  TStdArtInfoForm = class(TForm)
    btn_CheckArtData: TSpeedButton;
    btn_CopyExistArt: TSpeedButton;
    btn_Exit: TSpeedButton;
    btn_Help: TSpeedButton;
    btn_RefrshGFNOList: TSpeedButton;
    btn_SaveArt: TSpeedButton;
    cxbe_GFKeyValue: TcxButtonEdit;
    cxspl_Only: TcxSplitter;
    edt_Anti_Fluorescence: TEdit;
    edt_Check: TEdit;
    edt_Check_Time: TEdit;
    edt_CopyExistArt: TEdit;
    edt_Customer: TEdit;
    edt_GreyDensity: TEdit;
    edt_Designer: TEdit;
    edt_Designer_Time: TEdit;
    edt_BR: TEdit;
    edt_Grey_Width: TEdit;
    edt_Version: TEdit;
    edt_Density: TEdit;
    pm_CopyExistArt: TPopupMenu;
    pnl_Only: TPanel;
    txt_Only: TStaticText;
    edt_ReedWidth: TEdit;
    edt_Width: TEdit;
    btn_ViewArtDtl: TSpeedButton;
    pgc_GFNOList: TPageControl;
    lv_CurNOCheckArt: TListView;
    ts_Other: TTabSheet;
    lv_OtherNOCheckArt: TListView;
    ts_NoCheck: TTabSheet;
    edtGFID: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    pnl_Only1: TPanel;
    spl1: TSplitter;
    grp_Only: TGroupBox;
    mmo_Remark: TMemo;
    lst_Operationlist: TListBox;
    btn_MoveUP_Operation: TSpeedButton;
    btn_MoveDown_Operation: TSpeedButton;
    btn_Del_Operation: TSpeedButton;
    btn_Add_Operation: TSpeedButton;
    pgc_Operation: TPageControl;
    cbb_Operation_Name: TComboBox;
    Vle_Operation_Parlist: TValueListEditor;
    cbb_ColorCode: TComboBox;
    cbb_FN_Art_NO1: TComboBox;
    cbb_FN_Art_NO2: TComboBox;
    cbb_FN_Art_NO4: TComboBox;
    cbb_Shrinkage: TComboBox;
    edt_HandFeel: TEdit;
    chk_Is_Active: TCheckBox;
    edt_ProductWidth: TEdit;
    cxGridDBTVFeedback: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    mmoPDA: TMemo;
    mmoPDM: TMemo;
    chbPDA: TCheckBox;
    chbPDM: TCheckBox;
    ts_Feedback: TTabSheet;
    dsFeedback: TDataSource;
    cdsFeedback: TClientDataSet;
    lv_Feedback: TListView;
    TabSheet3: TTabSheet;
    mmoArtView: TMemo;
    rgFilter: TRadioGroup;
    sbFeedback: TSpeedButton;
    Panel2: TPanel;
    edt_Feedback: TEdit;
    edt_Feedback_Time: TEdit;
    edtSpecialYarnRate: TEdit;
    cdsRecipe: TClientDataSet;
    cdsCheckRecipe: TClientDataSet;
    lblRadio: TLabel;
    cdsRadio: TClientDataSet;
    btnDeleteArtByHand: TBitBtn;
    chkArtByHand: TCheckBox;
    cdsArtbyHand: TClientDataSet;
    ts_UnConfirm: TTabSheet;
    lv_UNConfirm: TListView;
    procedure cxbe_PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure btn_Operation(Sender: TObject);
    procedure KeyDownAControl(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure lst_OperationlistClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Vle_Operation_ParlistValidate(Sender: TObject; ACol, ARow: Integer; const KeyName, KeyValue: String);
    procedure btn_SaveArtClick(Sender: TObject);
    procedure btn_CopyExistArtClick(Sender: TObject);
    procedure pm_CopyExistArtPopup(Sender: TObject);
    procedure btn_Add_OperationClick(Sender: TObject);
    procedure ChangeAEdit(Sender: TObject);
    procedure btn_RefrshGFNOListClick(Sender: TObject);
    procedure Vle_Operation_ParlistEditButtonClick(Sender: TObject);
    procedure KeyDownAComboBox(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pgc_OperationChange(Sender: TObject);
    procedure Vle_Operation_ParlistKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_CheckArtDataClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btn_ViewArtDtlClick(Sender: TObject);
    procedure cbb_FN_Art_NO2CloseUp(Sender: TObject);
    procedure lv_CurNOCheckArtColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure lv_OtherNOCheckArtColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure chbPDAClick(Sender: TObject);
    procedure chbPDMClick(Sender: TObject);
    procedure lv_FeedbackColumnClick(Sender: TObject; Column: TListColumn);
    procedure lv_CurNOCheckArtCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lv_OtherNOCheckArtCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lv_FeedbackCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure cxGridDBTVFeedbackCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure pgc_GFNOListChange(Sender: TObject);
    procedure rgFilterClick(Sender: TObject);
    procedure sbFeedbackClick(Sender: TObject);
    procedure getRedio();
    procedure btnDeleteArtByHandClick(Sender: TObject);
  private
    { private declarations }
    OldFNArtNO2: string;
    function FindItem(FindStr: string; ListView: TListView): Boolean;
    procedure SaveData(Index: Integer);
    procedure SaveFnmArtbyHand;
    {* ������ϸ����Ʒ������Ϣ��.}
    function CheckArtByHand(gf_no: string):Boolean;
    {* �ж�Ʒ���Ƿ��Ѵ���Ʒ������Ϣ����.}
  public
    { public declarations }
    StdArtData: TSTDArtDtlInfo;
    {* ��׼���������}

    procedure ChangeEditControlEnable(EnableEdit: Boolean);
    {* �ı乤��ȱ༭�ؼ��ı༭״̬.}
    procedure ChangeParameterEditMode(EditMode: Boolean);
    {* �ı乤������ȱ༭�ؼ��ı༭״̬}
    procedure OpenStdArt(DataID: Integer; OpenType: String);
    {* ȡ�����չ��û��༭}
    procedure SelectAOperation;
    {* �û�ѡ����һ������}
    procedure CopyStdArtClick(Sender: TObject);
    {* �������ղ˵��ĵ����¼�}
    
    procedure ArtAfterEdit(Sender: TObject);
    {* �����ձ��༭��,��FormCreate�¼���:StdArtData.OnAfterEdit:=ArtAfterEdit;}
    procedure ArtBeforeSave(Sender: TObject);
    {* ���ձ���֮ǰ��������ú���,��FormCreate�¼���:StdArtData.OnBeforeSave:=ArtBeforeSave;}
    procedure ArtAfterSave(Sender: TObject);
    {* �����ձ���ɹ���,��FormCreate�¼���:StdArtData.OnAfterSave:=ArtAfterSave;}
    procedure ArtAfterOpen(Sender: TObject);
    {* �����մ򿪺�,��FormCreate�¼���:StdArtData.OnAfterOpen:=ArtAfterOpen;}
    procedure ArtAfterClose(Sender: TObject);
    {* �����չرպ�,��FormCreate�¼���:StdArtData.OnArtAfterClose:=ArtAfterClose;}
  end;

var
  StdArtInfoForm: TStdArtInfoForm;
implementation

uses Variants, Math, StrUtils, frmCreateSample, uDictionary,
    Dialogs, uFNMResource, ULogin, UGlobal, uShowMessage, UGridDecorator,
    ServerDllPub, UAppOption, uCADInfo, frmCreateStdPrescription;

{$R *.dfm}

function TStdArtInfoForm.FindItem(FindStr: string; ListView: TListView):Boolean;
var i: integer;
begin
  Result := False;
  for i:=0 to ListView.Items.Count -1 do
    if ListView.Items[i].Caption = FindStr then
    begin
      Result := True;
      ListView.Items[i].Selected := true;
      TPageControl(ListView.Parent.Parent).ActivePage := TTabSheet(ListView.Parent);
      ListView.SetFocus;
      break;
    end;
end;

procedure TStdArtInfoForm.SelectAOperation;
var
  Step_NO: Integer;
begin
  if lst_Operationlist.Focused then
    pgc_Operation.ActivePageIndex := 1;
    
  if lst_Operationlist.ItemIndex <> -1 then
  begin
    Step_NO:=Integer(lst_Operationlist.Items.Objects[lst_Operationlist.ItemIndex]);
    if (Vle_Operation_Parlist.Tag <> Step_NO) or (Vle_Operation_Parlist.Strings.Count = 0) then
    begin
      StdArtData.FillAStepToAListControls(Step_NO, Vle_Operation_Parlist);
      Vle_Operation_Parlist.Tag:=Step_NO;
    end;
  end;
  Vle_Operation_Parlist.Enabled:=Vle_Operation_Parlist.Strings.Count > 0;
  if Trim(StdArtData.Checker) <>'' then    //CHECK���ܱ༭
    Vle_Operation_Parlist.Options:=Vle_Operation_Parlist.Options - [goEditing]
  else
    Vle_Operation_Parlist.Options:=Vle_Operation_Parlist.Options + [goEditing];

end;

procedure TStdArtInfoForm.ChangeEditControlEnable(EnableEdit: Boolean);
begin
  if not EnableEdit then
  begin
    cbb_ColorCode.ItemIndex:=-1;
    cbb_FN_Art_NO1.ItemIndex:=-1;
    cbb_FN_Art_NO2.ItemIndex:=-1;
    cbb_FN_Art_NO4.ItemIndex:=-1;
    cbb_Shrinkage.Text:=''; 
    edt_BR.Text:='';
    edt_Anti_Fluorescence.Text:='';
    edt_Check.Text:='';
    edt_Check_Time.Text:='';
    edt_Feedback.Text :='';
    edt_Feedback_Time.Text :='';
    edt_Customer.Text:='';
    edt_Density.Text:='';
    edt_Designer.Text:='';
    edt_Designer_Time.Text:='';
    edt_Grey_Width.Text:='';
    edt_GreyDensity.Text:='';
    edt_ReedWidth.Text:='';
    edt_Version.Text:='';
    edt_Width.Text:='';
    edt_CopyExistArt.Text:='';
    lst_Operationlist.Clear;
    mmo_Remark.Lines.Clear;
    mmoPDA.Lines.Clear;
    mmoPDM.Lines.Clear;
    Vle_Operation_Parlist.Enabled:=EnableEdit;
    Vle_Operation_Parlist.Strings.Clear;
  end;
  //����ID : 258664  ȡ�������û������ƹ��ա�Ȩ��	tracy tan 2016-9-12
  // edt_CopyExistArt.Enabled:=EnableEdit;
  // btn_CopyExistArt.Enabled:=EnableEdit;
  btn_Add_Operation.Enabled:=EnableEdit and (pgc_Operation.ActivePageIndex = 0);
  btn_Del_Operation.Enabled:=EnableEdit;
  btn_MoveDown_Operation.Enabled:=EnableEdit;
  btn_MoveUP_Operation.Enabled:=EnableEdit;
  cbb_ColorCode.Enabled:=EnableEdit;
  cbb_FN_Art_NO1.Enabled:=EnableEdit;
  cbb_FN_Art_NO2.Enabled:=EnableEdit;
  cbb_FN_Art_NO4.Enabled:=EnableEdit;
  cbb_Shrinkage.Enabled:=EnableEdit;
  chk_Is_Active.Enabled:=EnableEdit;
  lst_Operationlist.Enabled:=EnableEdit;
  mmo_Remark.Enabled:=EnableEdit;
//  tv_Operation_Name.Enabled:=EnableEdit;
end;

procedure TStdArtInfoForm.ChangeParameterEditMode(EditMode: Boolean);
begin
  Vle_Operation_Parlist.Enabled:=EditMode;
end;

procedure TStdArtInfoForm.OpenStdArt(DataID: Integer; OpenType: String);
begin
  if OpenType = 'Open' then
  begin
    //if StdArtData.OrgArt_ID = DataID then exit;
    StdArtData.OrgArt_ID:=DataID;
    StdArtData.OpenFNSTDArt;
  end;

  if OpenType = 'Create' then
  begin
    if VarToStr(StdArtData.GF_ID) = IntToStr(DataID) then exit;

    if TMsgDialog.ShowMsgDialog(GetResourceString(@MSG_WillCreateStdArt), mtConfirmation, [mebYes, mebNo]) = mrYes then
    begin
      StdArtData.CreateStdArt(DataID, Login.CurrentDepartment, Login.LoginName);
      cxbe_PropertiesButtonClick(cxbe_GFKeyValue,0);
    end;
  end;
end;

procedure TStdArtInfoForm.CopyStdArtClick(Sender: TObject);
var
  Department: String;
  iSTD_Art_ID, iGF_ID: Integer;
begin
  if edt_CopyExistArt.Text = '' then exit;

  //ȡƷ��ID��Std_Art_ID
  with Dictionary.cds_DepartmentList do
  if Locate('Iden', (Sender as TMenuItem).Tag, []) then
    Department:=FieldByName('Department').AsString;

  GetStdArtIDbyGFNO(edt_CopyExistArt.Text, Department, iSTD_Art_ID, iGF_ID);
  if iSTD_Art_ID = -1 then
    raise Exception.CreateRes(@EMP_StdArtInfoDtlCantCopy);

  StdArtData.CopyAExistSTDArt(iSTD_Art_ID);
end;

procedure TStdArtInfoForm.ArtAfterEdit(Sender: TObject);
begin
  btn_SaveArt.Enabled:=(Sender as TSTDArtDtlInfo).Modify;
end;

procedure TStdArtInfoForm.ArtBeforeSave(Sender: TObject);
begin
  cxbe_GFKeyValue.SetFocus;
  //�ѽ����ϵ����ݱ��浽����ʵ����
  with Sender as TSTDArtDtlInfo do
  begin                                     
    FN_Art_NO:=format('%s;%s;%s;',
      [LeftStr(cbb_FN_Art_NO1.Text, Pos(' ', cbb_FN_Art_NO1.Text) - 1),
       LeftStr(cbb_FN_Art_NO2.Text, Pos(' ', cbb_FN_Art_NO2.Text) - 1),
       LeftStr(cbb_FN_Art_NO4.Text, Pos(' ', cbb_FN_Art_NO4.Text) - 1)]);

    Shrinkage:=cbb_Shrinkage.Text;
    Handfeel:=edt_HandFeel.Text;
    Product_Width:=edt_ProductWidth.Text;
    FN_Color_Code:=cbb_ColorCode.Text;
    Remark:=mmo_Remark.Text;
    Is_Active:=ifthen(chk_Is_Active.Checked, '1', '0');
    Operator:=Login.LoginName;
  end;
end;

procedure TStdArtInfoForm.ArtAfterSave(Sender: TObject);
begin
  btn_SaveArt.Enabled:=false;
end;

procedure TStdArtInfoForm.ArtAfterOpen(Sender: TObject);
var
  SubStrLen: Integer;
  TheFN_Art_NO: String;
  a:BOOL;
begin
  with Sender as TSTDArtDtlInfo do
  begin
    TheFN_Art_NO:=FN_Art_NO;

    //���մ���
    SubStrLen:=pos(';', TheFN_Art_NO);
    TGlobal.SetComboBoxValue(cbb_FN_Art_NO1, LeftStr(TheFN_Art_NO, SubStrLen - 1));
    System.Delete(TheFN_Art_NO, 1, SubStrLen);
    //ӫ��
    SubStrLen:=pos(';', TheFN_Art_NO);
    TGlobal.SetComboBoxValue(cbb_FN_Art_NO2, LeftStr(TheFN_Art_NO, SubStrLen - 1));
    System.Delete(TheFN_Art_NO, 1, SubStrLen);
    //��֯�ṹ
    SubStrLen:=pos(';', TheFN_Art_NO);
    TGlobal.SetComboBoxValue(cbb_FN_Art_NO4, LeftStr(TheFN_Art_NO, SubStrLen - 1));
    System.Delete(TheFN_Art_NO, 1, SubStrLen);
    //��ˮҪ��
    cbb_Shrinkage.Text:=Shrinkage;
    //�ָ�Ҫ��
    edt_HandFeel.Text:=HandFeel;
    //�ŷ�
    edt_ProductWidth.Text:=Product_Width;
    //��ɫ
    TGlobal.SetComboBoxValue(cbb_ColorCode, FN_Color_Code);

    chk_Is_Active.Checked:=Is_Active = '1';
    edt_Check.Text:=Checker;
    edt_Check_Time.Text:=Check_Time;
    edt_Feedback.Text := Feedback;
    edt_Feedback_Time.Text := Feedback_Time;
    edt_Designer.Text:=Operator;
    edt_Designer_Time.Text:=Operate_Time;
    edt_Version.Text:=Version;
    mmo_Remark.Text:=Remark;
    mmoPDA.Text := PDARemark;
    mmoPDM.Text := PDMRemark;
    //��乤���б����
    FillOperationToAListControls(lst_Operationlist.Items);
  end;
  //��ʾCAD��Ϣ
  with Sender as TSTDArtDtlInfo do
    CADInfo.OrgGFKeyValue:= StrUtils.ifthen(GF_NO = '', GF_ID, GF_NO);
  with CADInfo do
  begin
    edtGFID.Text := IntToStr(GF_ID);
    edt_Width.Text:=Width;
    edt_BR.Text:=BRUnitUsage;
    edt_Density.Text:=Density;
    cxbe_GFKeyValue.Text:=GF_NO;
    edt_Customer.Text:=Customer_Code;
    edt_Grey_Width.Text:=CADInfo.GreyWidth;
    edt_ReedWidth.Text:=CADInfo.Reed_Width;
    edt_GreyDensity.Text:=CADInfo.GreyDensity;
    edt_Anti_Fluorescence.Text:=FluorescencePercent;
    edtSpecialYarnRate.Text := SpecialYarnRate;

    if (edt_Anti_Fluorescence.Text = 'W:0%F:0%') and (cbb_FN_Art_NO2.ItemIndex = -1) then
      TGlobal.SetComboBoxValue(cbb_FN_Art_NO2, 'BP');

    //��ˮҪ��
    if cbb_Shrinkage.Text = '' then
      cbb_Shrinkage.Text:=Shrinkage;
    //�ָ�Ҫ��
    if edt_HandFeel.Text = '' then
      edt_HandFeel.Text:=Handfeel;
    //�ŷ�
    if edt_ProductWidth.Text = '' then
      edt_ProductWidth.Text:=Width;
  end;
  OldFNArtNO2 := cbb_FN_Art_NO2.Text;
  //��ʾ���Ϳؼ�
  AutoShowCADPicture(CADInfo.OrgGFKeyValue);
    //���ñ༭�ؼ�����
  ChangeEditControlEnable(true);
  //����δȷ����ȷ�ϰ�ť����.
  with Sender as TSTDArtDtlInfo do
  begin
    btn_CheckArtData.Enabled:=(Trim(Art_ID) <> '') and (Current_Department = Login.CurrentDepartment);
    if btn_CheckArtData.Enabled then
    begin
      if Trim(Checker) = '' then
        btn_CheckArtData.Caption:='ȷ��(&V)'
      else
        btn_CheckArtData.Caption:='ȡ��ȷ��(&V)'
    end
  end;
  getRedio;
  //���Ʒ�����Ƿ��Ѵ���   liaogc 2015-12-21

  if not CheckArtByHand(cxbe_GFKeyValue.Text) then
  begin
     chkArtByHand.Caption:='����Ʒ����'
  end
  else     chkArtByHand.Caption:='����Ʒ����'
end;

procedure TStdArtInfoForm.ArtAfterClose(Sender: TObject);
begin
  btn_SaveArt.Enabled:=False;
  btn_CheckArtData.Enabled:=False;
  ChangeEditControlEnable(false);
end;

procedure TStdArtInfoForm.FormCreate(Sender: TObject);
begin

  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btn_SaveArt.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Help.Glyph.LoadFromResourceName(HInstance, RES_HELPABOUT);
  btn_Add_Operation.Glyph.LoadFromResourceName(HInstance, RES_LEFT);
  btn_CopyExistArt.Glyph.LoadFromResourceName(HInstance, RES_COPY);
  btn_Del_Operation.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btn_RefrshGFNOList.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btn_MoveUP_Operation.Glyph.LoadFromResourceName(HInstance, RES_MOVEUP);
  btn_MoveDown_Operation.Glyph.LoadFromResourceName(HInstance, RES_MOVEDOWN);
  sbFeedback.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  cxbe_GFKeyValue.Properties.Buttons.Items[0].Glyph.LoadFromResourceName(HInstance, RES_QUERYSMALL);

  ChangeEditControlEnable(false);
  ChangeParameterEditMode(false);
  btn_CheckArtData.Enabled:=false;
  btn_SaveArt.Enabled:=false;

  (cbb_Operation_Name as TControl).Align:=alClient;
  //Ĭ����ʾ��һҳ
  pgc_GFNOList.ActivePageIndex:=0;
  pgc_Operation.ActivePageIndex:=0;
  PageControl1.ActivePageIndex := 0;

  //ListView��˫���¼�
  lv_CurNOCheckArt.OnDblClick:=TGlobal.DblClickAListview;
  lv_OtherNOCheckArt.OnDblClick:=TGlobal.DblClickAListview;
  lv_Feedback.OnDblClick:=TGlobal.DblClickAListview;
  //TWinControl��˫���¼�
  cbb_Operation_Name.OnDblClick:=TGlobal.DblClickAWinControl;
  //�����׼������
  StdArtData:=TSTDArtDtlInfo.Create(Self);
  StdArtData.OrgDepartment:=Login.CurrentDepartment;
  StdArtData.OnAfterEdit:=ArtAfterEdit;
  StdArtData.OnBeforeSave:=ArtBeforeSave;
  StdArtData.OnAfterSave:=ArtAfterSave;
  StdArtData.OnAfterOpen:=ArtAfterOpen;
  StdArtData.OnAfterClose:=ArtAfterClose;
  //����ID : 252770�����е� ������Ʒ���⡱��Ȩ��ֻ���� fangy/ gaoyp, �����û�Ȩ�޷��  tracy tan     2016-8-18
   if (UpperCase(Login.LoginID) = UpperCase('fangy')) or (UpperCase(Login.LoginID) = UpperCase('gaoyp'))    then
      begin
        chkartbyhand.Enabled:=true ;
      end
      else
      chkartbyhand.Enabled:=False ;
end;

procedure TStdArtInfoForm.KeyDownAControl(Sender: TObject; var Key: Word; Shift: TShiftState);
//var   Art_ID: Integer;
begin
  //����KeyDown
  if Sender = Self then
  case Key of
    VK_F5: btn_RefrshGFNOList.Click;
    VK_F8: StdArtData.SaveArtToDataBase;
  end;

  //Ʒ���༭��KeyDown
  if Sender = cxbe_GFKeyValue then
  case Key of
    VK_RETURN:
      cxbe_GFKeyValue.Properties.OnButtonClick(Sender, 0);
  end;

  //�޹���Ʒ�� �� ��ȷ��Ʒ����ListView��KeyDown
  if Sender.ClassNameIs('TListView') then
  case Key of
    VK_RETURN:
    begin
      //����δ�������˳�
      if (Sender as TListView).Selected = nil then exit;
      if (Sender = lv_CurNOCheckArt) or (Sender = lv_OtherNOCheckArt) or (Sender = lv_Feedback)then
      begin
        OpenStdArt(StrToInt((Sender as TListView).Selected.SubItems.Strings[0]), 'Open');
        if cdsFeedback.Active then
          cdsFeedback.EmptyDataSet;
        PageControl1.ActivePageIndex := 0;
        if (Sender = lv_Feedback) then
        begin
          PageControl1.ActivePageIndex := 1;
          cdsFeedback.Data := StdArtData.GetFeedbackInfo;
          GridDecorator.BindCxViewWithDataSource(cxGridDBTVFeedback,dsFeedback);
        end;
      end;
    end;
  end;

  //���տ���Ʒ���༭��KeyDown
  if Sender = edt_CopyExistArt then
  case Key of
    VK_RETURN: btn_CopyExistArt.Click;
  end;

  //�����б� KeyDown
  if Sender = cbb_Operation_Name then
  case Key of
    VK_RETURN: btn_Add_Operation.Click;
  end;

  //�����б�KeyDown
  if Sender = lst_Operationlist then
  case Key of
    VK_RETURN, VK_UP, VK_DOWN: SelectAOperation;
  end;
end;

procedure TStdArtInfoForm.cxbe_PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  iGF_ID, iSTD_Art_ID: Integer;
begin
  if Sender = cxbe_GFKeyValue then
  begin
    if cxbe_GFKeyValue.Text = '' then exit;

    //�û�Ҫ������ˢ������
//    if cxbe_GFKeyValue.Text = StdArtData.GF_NO then exit;

    //���չر�ʧ�����˳�
    if not StdArtData.CloseArt then exit;
    //ȡƷ��ID��Std_Art_ID
    GetStdArtIDbyGFNO(cxbe_GFKeyValue.Text, Login.CurrentDepartment, iSTD_Art_ID, iGF_ID);
    //�򿪻�������
    if iSTD_Art_ID <> -1 then
      OpenStdArt(iSTD_Art_ID, 'Open')
    else
      OpenStdArt(iGF_ID, 'Create');
    //��λ��LISTVIEW
    FindItem(cxbe_GFKeyValue.Text,lv_OtherNOCheckArt);
    FindItem(cxbe_GFKeyValue.Text,lv_CurNOCheckArt);
    if  StdArtData.Active then ////FindItem(cxbe_GFKeyValue.Text,lv_Feedback) and
    begin
      if cdsFeedback.Active then
          cdsFeedback.EmptyDataSet;
      cdsFeedback.Data := StdArtData.GetFeedbackInfo;
      GridDecorator.BindCxViewWithDataSource(cxGridDBTVFeedback,dsFeedback);
    end;
    pgc_GFNOList.OnChange(Self);
  end;
end;

procedure TStdArtInfoForm.btn_Add_OperationClick(Sender: TObject);
var
  OperationID: Integer;
begin
  if not btn_Add_Operation.Enabled then exit;

  with cbb_Operation_Name do
    if (Text = '') or (Items.IndexOf(Text) = -1)then exit;

  with cbb_Operation_Name do
  begin
    OperationID:=Integer(Items.Objects[Items.IndexOf(Text)]);
    Text:='';
  end;

  //�������
  StdArtData.AddAOperateStep(OperationID);

  //���沼��
  StdArtData.FillOperationToAListControls(lst_Operationlist.Items);
  lst_Operationlist.ItemIndex:=lst_Operationlist.Count -1;
  SelectAOperation;
end;

procedure TStdArtInfoForm.btn_Operation(Sender: TObject);
var
  ItemIndex, Step_NO: Integer;
begin
  if Trim(StdArtData.Checker) <>'' then
  begin
    TMsgDialog.ShowMsgDialog('��Ʒ�������Ѿ�ȷ��,����ȡ��ȷ�����޸Ĺ���',mtInformation);
    Exit;
  end;
  
  ItemIndex:=lst_Operationlist.ItemIndex;
  if ItemIndex = -1 then exit;

  Step_NO:=Integer(lst_Operationlist.Items.Objects[ItemIndex]);

  //�û�����btn_Del_Operation��ť
  if Sender = btn_Del_Operation then
  begin
    StdArtData.MoveAOperateStep(Step_NO, ooDelete);
    ItemIndex:=ItemIndex-1;
  end;

  //�û�����btn_MoveDown_Operation��ť
  if Sender = btn_MoveDown_Operation then
  begin
    if ItemIndex < lst_Operationlist.Count - 1 then
    begin
      StdArtData.MoveAOperateStep(Step_NO, ooMoveDown);
      ItemIndex:=ItemIndex+1;
    end;
  end;

  //�û�����btn_MoveUP_Operation��ť
  if Sender = btn_MoveUP_Operation then
  begin
    if ItemIndex > 0 then
    begin
      StdArtData.MoveAOperateStep(Step_NO, ooMoveUP);
      ItemIndex:=ItemIndex-1;
    end;
  end;

  //���沼��
  if ItemIndex <> lst_Operationlist.ItemIndex then
  begin
    StdArtData.FillOperationToAListControls(lst_Operationlist.Items);
    Vle_Operation_Parlist.Strings.Clear;
    if lst_Operationlist.Items.Count <> 0 then
    begin
      lst_Operationlist.ItemIndex:=ifthen(ItemIndex = -1, 0, ItemIndex);
      SelectAOperation;
    end;
  end;
end;

procedure TStdArtInfoForm.lst_OperationlistClick(Sender: TObject);
begin
  SelectAOperation
end;

procedure TStdArtInfoForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  StdArtData.CloseArt;
  if StdArtData.Modify then
    Action:=caNone
  else
  begin
    StdArtData.Destroy;
    Action:=caFree;
  end;
end;

procedure TStdArtInfoForm.FormDestroy(Sender: TObject);
begin
  StdArtInfoForm := nil;
end;

procedure TStdArtInfoForm.Vle_Operation_ParlistValidate(Sender: TObject; ACol, ARow: Integer; const KeyName, KeyValue: String);
var
  ItemValue: string;
  vData:OleVariant;
  sSql,sErrMsg:WideString;
begin
  try
    Vle_Operation_Parlist.OnValidate:=nil;
    if KeyName = '' then Exit;
    if StdArtData.Active then
    begin
      ItemValue:=StdArtData.SetAOperateParameterValue(Vle_Operation_Parlist.Tag, Trim(KeyName), Trim(KeyValue));
      
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

procedure TStdArtInfoForm.getRedio();
var
  sCondition,sErrorMsg:WideString;
  vData:OleVariant;
begin
  //��ʾ�޸ı���
  //lblRadio.Caption := '10%';
  if VarToStr(StdArtData.Art_ID) = '' then Exit;
  
  sCondition := IntToStr(StdArtData.Art_ID) + ',' +
                       QuotedStr('') + ',' +
                       QuotedStr('') + ',' +
                       QuotedStr('') + ',' +
                       '1';
  FNMServerObj.GetQueryData(vData,'SaveParaChange',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog('��ȡ�޸ı���ʧ��!',mtError);
  end;
  cdsRadio.Data := vData;
  lblRadio.Caption := cdsRadio.FieldByName('result').AsString ;
end;

procedure TStdArtInfoForm.SaveData(Index: Integer);
var
  i: Integer;
begin
  if chbPDA.Checked then
    StdArtData.PDARemark := mmoPDA.Lines.Text;
  if chbPDM.Checked then
    StdArtData.PDMRemark := mmoPDM.Lines.Text;
  if Index = 0 then
    //cuijf 2009-11-25
    if not StdArtData.SaveArtToDataBase then
      Exit
  else
    StdArtData.SaveFeedbackInfo;

  //ˢ�·�������
  with lv_Feedback.Items do
  begin
    for i := 0 to Count - 1 do
      if Item[i].Caption = StdArtData.GF_NO then
      begin
        Item[i].Delete;
        break;
      end;
  end;
  ts_Feedback.Caption := Login.CurrentDepartment + '���շ���['+ IntToStr(lv_Feedback.Items.Count)+']';

  //��ʾ�޸ı���
  getRedio;

  if cdsFeedback.Active then
    cdsFeedback.EmptyDataSet;
  StdArtData.CloseArt;
end;

procedure TStdArtInfoForm.btn_SaveArtClick(Sender: TObject);
begin
  SaveData(0);
end;

procedure TStdArtInfoForm.btn_CopyExistArtClick(Sender: TObject);
var
  PopupPoint: TPoint;
  ClickButton: TSpeedButton;
begin
  //PopuAMenu
  ClickButton:=(Sender as TSpeedButton);
  PopupPoint:=ClickButton.Parent.ClientToScreen(Point(ClickButton.Left, ClickButton.Top+ClickButton.Height));
  ClickButton.PopupMenu.Popup(PopupPoint.X,PopupPoint.Y);
end;

procedure TStdArtInfoForm.KeyDownAComboBox(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Sender as TComboBox).DroppedDown then
  case Key of
    VK_TAB:
    begin
      Key:=0;
      PerForm(WM_NEXTDLGCTL, Ord(Shift = [ssShift]), 0);
    end
  end;
end;

procedure TStdArtInfoForm.pm_CopyExistArtPopup(Sender: TObject);
begin
  if pm_CopyExistArt.Items.Count = 0 then
    StdArtData.InitializeDepartmentMenuItem(pm_CopyExistArt.Items, CopyStdArtClick);
end;

procedure TStdArtInfoForm.ChangeAEdit(Sender: TObject);
begin
  StdArtData.Modify:=True;
end;

procedure TStdArtInfoForm.btn_RefrshGFNOListClick(Sender: TObject);
var
  sDept, sErrorMsg : WideString;
  vData:OleVariant;
begin
  sDept := Login.CurrentDepartment;
  FNMServerArtObj.GetNoCheckGFNO(sDept, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise Exception.Create(sErrorMsg);

  TempClientDataSet.Data:=vData;

  //�������(���GF_ID��Items��Object�����б�)
    // ���ӹ������� AND is_confirm>0  liaogc 20160421
  TempClientDataSet.Filter:=Format('Current_Department = ''%s'' AND Type = ''%s'' AND is_confirm>0 ', [Login.CurrentDepartment,'��ȷ��']);
  TempClientDataSet.Filtered:=True;
  FillListItemsFromDataSet(TempClientDataSet, 'GF_NO', '', ['STD_Art_ID', 'Construction','CADChange'], lv_CurNOCheckArt.Items);
  ts_NoCheck.Caption := Login.CurrentDepartment + '��ȷ��['+ IntToStr(lv_CurNOCheckArt.Items.Count)+']';

  TempClientDataSet.Filter:= Format('Current_Department <> ''%s'' AND Type <> ''%s'' AND is_confirm>0 ', [Login.CurrentDepartment ,'���շ���']);
  TempClientDataSet.Filtered:=True;
  FillListItemsFromDataSet(TempClientDataSet, 'GF_NO', '', ['STD_Art_ID', 'Construction','CADChange'], lv_OtherNOCheckArt.Items);
  ts_Other.Caption := '������ȷ��['+ IntToStr(lv_OtherNOCheckArt.Items.Count)+']';

  if Login.CurrentDepartment= 'FG' then
    TempClientDataSet.Filter:=Format('Current_Department = ''%s'' AND Type = ''%s'' AND is_confirm>0 ', [Login.CurrentDepartment ,'���շ���'])
  else
    TempClientDataSet.Filter:=Format('Current_Department = ''%s'' AND Type = ''%s'' AND is_confirm>0 ', [Login.CurrentDepartment ,'���շ���']);
  TempClientDataSet.Filtered:=True;
  FillListItemsFromDataSet(TempClientDataSet, 'GF_NO', '', ['STD_Art_ID', 'Construction','CADChange'], lv_Feedback.Items);
  ts_Feedback.Caption := Login.CurrentDepartment + '���շ���['+ IntToStr(lv_Feedback.Items.Count)+']';

 //���������ȷ������
  TempClientDataSet.Filter:= Format('is_confirm=0 ', [Login.CurrentDepartment ,'��ȷ��']);
  TempClientDataSet.Filtered:=True;
  FillListItemsFromDataSet(TempClientDataSet, 'GF_NO', '', ['STD_Art_ID', 'Construction','CADChange'], lv_UNConfirm.Items);
  ts_UnConfirm.Caption := '������ȷ��['+ IntToStr(lv_UNConfirm.Items.Count)+']';


  TempClientDataSet.Filtered := False;
end;

procedure TStdArtInfoForm.Vle_Operation_ParlistEditButtonClick(Sender: TObject);
var
  Item_Value: String;
begin
  with Sender as TValueListEditor do
  begin
    if Pos('ȡ��', Trim(Cells[0,Row])) > 0 then
      Item_Value:=GetSampleNo(Cells[1,Row]);
    if Pos('�䷽', Trim(Cells[0,Row])) > 0 then
      Item_Value:=GetStdPrescriptionNo(StdArtData.GetStepOperateCode(Tag), 'S', Cells[1,Row]);

    if (Item_Value <> '') and (Item_Value <> Cells[Col,Row]) then
    begin
       Cells[Col,Row] := Item_Value;
      (Sender as TValueListEditor).OnValidate(Sender, Col, Row, Cells[0, Row], Cells[Col,Row]);
    end;
  end;
end;

procedure TStdArtInfoForm.pgc_OperationChange(Sender: TObject);
begin
  with Sender as TPageControl do
  begin
    btn_Add_Operation.Enabled:= (ActivePageIndex = 0) and (StdArtData.Active);
    if (ActivePageIndex = 2) and StdArtData.Active then
      mmoArtView.Lines.Text := StdArtData.ViewArtDtl(rgFilter.ItemIndex);
  end;
end;

procedure TStdArtInfoForm.Vle_Operation_ParlistKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Sender = Vle_Operation_Parlist then
  with Sender as TValueListEditor do
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

procedure TStdArtInfoForm.btn_CheckArtDataClick(Sender: TObject);
var
  i,j: Integer;
  sSQL,sErrorMsg : WideString;
  vData:OleVariant;
  sParam:array of string;
begin

  if cbb_FN_Art_NO2.Text = '' then
  begin
    TMsgDialog.ShowMsgDialog('ӫ������Ϊ�գ�����ȷ��!',mtInformation);
    Exit;
  end;

  if (Login.LoginID <> 'liaogc') and (Login.UserLevelList = '') or (Pos('3',Login.UserLevelList)<0) then   //3--�й���ȷ�Ϻ�ȡ��Ȩ��
  begin
    TMsgDialog.ShowMsgDialog('��û�й���ȷ�Ϻ�ȡ����Ȩ��,����ϵ���ǵ��鳤',mtInformation);
    Exit;
  end;

  cxbe_GFKeyValue.SetFocus;
  if btn_CheckArtData.Caption <> 'ȷ��(&V)' then
  begin
    StdArtData.CheckStdArt(0);//ȡ��ȷ��
    btn_CheckArtData.Caption:='ȷ��(&V)';
    edt_Check.Text:='';
    edt_Check_Time.Text:='';
    with lv_CurNOCheckArt.Items.Add do
    begin
      Caption:=StdArtData.GF_NO;
      SubItems.Add(StdArtData.Art_ID);
      SubItems.Add(StdArtData.GF_ID);
    end;
  end
  else
  begin
    if not chk_Is_Active.Checked then
    begin
      TMsgDialog.ShowMsgDialog('��Ʒ��������Ч,����ѡ������Ч�����ȷ�Ϻ�ȡ��ȷ��',mtInformation);
      Exit;
    end;
    StdArtData.CheckStdArt(1); //ȷ��
    if chkArtByHand.Checked=True then
       SaveFnmArtbyHand;    //ȷ�ϣ�����Ʒ���⹤����Ϣ liaogc 2015-12-25

    getRedio();
    btn_CheckArtData.Caption:='ȡ��ȷ��(&V)';
    edt_Check.Text:=Login.LoginName;
    edt_Check_Time.Text:=DateTimeToStr(Now);
    with lv_CurNOCheckArt.Items do
    begin
      for i := 0 to Count - 1 do
        if Item[i].Caption = StdArtData.GF_NO then
        begin
          Item[i].Delete;
          break;
        end;
    end;
  end;
  if btn_CheckArtData.Caption ='ȡ��ȷ��(&V)' then
  begin
    SetLength(sParam,5);
    sParam[0] := '3';   // 213-8-12 ����Ƿ��Ǵ��� ����ʾҲ��������
    sParam[1] := '4';   // 213-8-15 ���CUSTOMER_ID ����ʾҲ��������
    sParam[2] := '0';   // 213-8-12 ����Ƿ��Ǵ��� ����ʾҲ��������
    sParam[3] := '5';   // 213-10-16 ���˿�ⶨ���Ƿ������������
    sParam[4] := '6';   // 213-10-18  ��� ���ձ�ע ��ʾ
    for j:=0 to Length(sParam) - 1 do
    begin
      sSQL := QuotedStr(StdArtData.Art_ID) + ',' + sParam[j];
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
  end;

//  // 213-8-12 ����Ƿ��Ǵ��� ����ʾҲ��������
//  sSQL := QuotedStr(StdArtData.Art_ID) + ',3';
//  FNMServerObj.GetQueryData(vData, 'CheckRecipeRole', sSQL, sErrorMsg);
//  if sErrorMsg<>'' then
//  begin
//    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
//  end;
//  cdsCheckRecipe.Data := vData;
//  if cdsCheckRecipe.RecordCount > 0 then
//  begin
//    if cdsCheckRecipe.FieldByName('Alert_text').AsString <> '' then
//      TMsgDialog.ShowMsgDialog(cdsCheckRecipe.FieldByName('Alert_text').AsString, mtWarning);
//  end;
//
//  // 213-8-15 ���CUSTOMER_ID ����ʾҲ��������
//  sSQL := QuotedStr(StdArtData.Art_ID) + ',4';
//  FNMServerObj.GetQueryData(vData, 'CheckRecipeRole', sSQL, sErrorMsg);
//  if sErrorMsg<>'' then
//  begin
//    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
//  end;
//  cdsCheckRecipe.Data := vData;
//  if cdsCheckRecipe.RecordCount > 0 then
//  begin
//    if cdsCheckRecipe.FieldByName('Alert_text').AsString <> '' then
//      TMsgDialog.ShowMsgDialog(cdsCheckRecipe.FieldByName('Alert_text').AsString, mtWarning);
//  end;
//
//  // ����䷽ --- begin---------
//  // 213-8-12 ����Ƿ��Ǵ��� ����ʾҲ��������
//  sSQL := QuotedStr(StdArtData.Art_ID) + ',0';
//  FNMServerObj.GetQueryData(vData, 'CheckRecipeRole', sSQL, sErrorMsg);
//  if sErrorMsg<>'' then
//  begin
//    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
//  end;
//  cdsCheckRecipe.Data := vData;
//  if cdsCheckRecipe.RecordCount > 0 then
//  begin
//    if cdsCheckRecipe.FieldByName('Alert_text').AsString <> '' then
//      TMsgDialog.ShowMsgDialog(cdsCheckRecipe.FieldByName('Alert_text').AsString, mtWarning);
//  end;
//  // ����䷽ --- end---------

  //��ʾ�޸ı���
  getRedio;

  StdArtData.CloseArt;
  PageControl1.ActivePageIndex := 0;
  ts_NoCheck.Caption := Login.CurrentDepartment + '��ȷ��['+ IntToStr(lv_CurNOCheckArt.Items.Count)+']';  
end;

procedure TStdArtInfoForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  //ˢ�½�������
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
  //���غ������մ����ֵ�
  FillArt_NOListToAComboBox('G', cbb_FN_Art_NO1);
  FillFN_Art_NOListToAComboBox('ӫ������', cbb_FN_Art_NO2);
  FillFN_Art_NOListToAComboBox('����', cbb_FN_Art_NO4);
  //������ɫ�ֵ�
  FillItemsFromDataSet(Dictionary.cds_ColorList, 'FN_Color_Code', 'FN_Color_Name', 'Iden','-', cbb_ColorCode.Items);
  cbb_ColorCode.DropDownCount:=cbb_ColorCode.Items.Count;
  //��ˮҪ���ֵ�
  FillItemsFromDataSet(Dictionary.cds_ShrinkageList, 'Shrinkage', '', '','', cbb_Shrinkage.Items);
 //��乤��ѡ����
  Dictionary.cds_OperationDtlList.Filter :='Use_Department LIKE ''%'+Login.CurrentDepartment + '%''';
  Dictionary.cds_OperationDtlList.Filtered := True;
  FillItemsFromDataSet(Dictionary.cds_OperationDtlList, 'Operation_Code', 'Operation_CHN', 'Iden', '--', cbb_Operation_Name.Items);
  TabSheet2.Enabled := pgc_GFNOList.ActivePageIndex= 2;
  sbFeedback.Align := alBottom;
  GroupBox2.Align := alClient;
  OnActivate:=nil;
end;

procedure TStdArtInfoForm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TStdArtInfoForm.btn_ViewArtDtlClick(Sender: TObject);
begin
  StdArtData.ViewArtDtlInNewForm;
end;

procedure TStdArtInfoForm.cbb_FN_Art_NO2CloseUp(Sender: TObject);
var OldIndex: Integer;
begin
  OldIndex := cbb_FN_Art_NO2.Items.IndexOf(OldFNArtNO2);
  if edt_Anti_Fluorescence.Text = 'W:0.00%F:0.00%' then
  begin
    TMsgDialog.ShowMsgDialog('�˲�����ӫ��,ӫ������ֻ������Ϊ [BP-Ư�׷�ӫ��]', mtWarning);
    cbb_FN_Art_NO2.ItemIndex := 2
  end else
    if cbb_FN_Art_NO2.ItemIndex = 2 then
    begin
      TMsgDialog.ShowMsgDialog('�˲���ӫ��,ӫ�����Բ�������Ϊ [BP-Ư�׷�ӫ��]', mtWarning);
      cbb_FN_Art_NO2.ItemIndex := OldIndex;
    end;
  OldFNArtNO2 := cbb_FN_Art_NO2.Text;
end;

procedure TStdArtInfoForm.lv_CurNOCheckArtColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  TGlobal.SortListView(lv_CurNOCheckArt,Column);
end;

procedure TStdArtInfoForm.lv_OtherNOCheckArtColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  TGlobal.SortListView(lv_OtherNOCheckArt,Column);
end;

procedure TStdArtInfoForm.chbPDAClick(Sender: TObject);
begin
  mmoPDA.Enabled := chbPDA.Checked;
  if mmoPDA.Enabled then
    mmoPDA.Color := clWindow
  else
    mmoPDA.Color := clBtnFace;
end;

procedure TStdArtInfoForm.chbPDMClick(Sender: TObject);
begin
  mmoPDM.Enabled := chbPDM.Checked;
  if mmoPDM.Enabled then
    mmoPDM.Color := clWindow
  else
    mmoPDM.Color := clBtnFace;
end;

procedure TStdArtInfoForm.lv_FeedbackColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  TGlobal.SortListView(lv_Feedback,Column);
end;

procedure TStdArtInfoForm.lv_CurNOCheckArtCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  if Item.SubItems[2] <> '0' then
    Sender.Canvas.Font.Color := clBlue;
end;

procedure TStdArtInfoForm.lv_OtherNOCheckArtCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  if Item.SubItems[2] <> '0' then
    Sender.Canvas.Font.Color := clBlue;
end;

procedure TStdArtInfoForm.lv_FeedbackCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  if Item.SubItems[2] <> '0' then
    Sender.Canvas.Font.Color := clBlue;
end;

procedure TStdArtInfoForm.cxGridDBTVFeedbackCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var col:Integer;
begin
   col := TcxGridDBTableView(Sender).GetColumnByFieldName('Is_OK').Index;
  if not AViewInfo.GridRecord.Values[col]  then
    ACanvas.Font.Color := clRed;
end;

procedure TStdArtInfoForm.pgc_GFNOListChange(Sender: TObject);
begin
  if pgc_GFNOList.ActivePageIndex = 2 then
    PageControl1.ActivePageIndex := 1
  else
    PageControl1.ActivePageIndex := 0;
  TabSheet2.Enabled := pgc_GFNOList.ActivePageIndex= 2;
end;

procedure TStdArtInfoForm.rgFilterClick(Sender: TObject);
begin
  if (pgc_Operation.ActivePageIndex = 2) and StdArtData.Active then
     mmoArtView.Lines.Text := StdArtData.ViewArtDtl(rgFilter.ItemIndex);
end;    

procedure TStdArtInfoForm.sbFeedbackClick(Sender: TObject);
begin
  SaveData(1);
end;


procedure TStdArtInfoForm.SaveFnmArtbyHand;
var
  sql_text,sErrorMsg: WideString;
  vData:OleVariant;
begin
   if cxbe_GFKeyValue.Text='' then
   begin
        showmessage('���������ѯƷ��');
        exit;
   end;
   sql_text:='exec usp_UpdateFnmArtByHand 1,' +QuotedStr(cxbe_GFKeyValue.Text)+','+QuotedStr(login.CurrentDepartment)
            +','+QuotedStr(login.LoginName);
   FNMServerObj.GetQueryBySQL(vData,sql_text,sErrorMsg);
   if sErrorMsg <> '' then
   begin
      raise ExceptionEx.CreateResFmt(@SaveCheckArtDataError, [sErrorMsg]);
   end
   else TMsgDialog.ShowMsgDialog(chkArtByHand.Caption+'�ɹ�',mtInformation);

end;


procedure TStdArtInfoForm.btnDeleteArtByHandClick(Sender: TObject);
var
  sql_text,sErrorMsg: WideString;
  vData:OleVariant;
begin
   if cxbe_GFKeyValue.Text='' then
   begin
        showmessage('���������ѯƷ��');
        exit;
   end;
   sql_text:='exec usp_UpdateFnmArtByHand 2,' +QuotedStr(cxbe_GFKeyValue.Text);
   FNMServerObj.GetQueryBySQL(vData,sql_text,sErrorMsg);
   if sErrorMsg <> '' then
   begin
      raise ExceptionEx.CreateResFmt(@SaveCheckArtDataError, [sErrorMsg]);
   end
   else TMsgDialog.ShowMsgDialog('��ɾ��Ʒ�� '+cxbe_GFKeyValue.Text,mtInformation);

end;

function TStdArtInfoForm.CheckArtByHand(gf_no: string):Boolean;
var
  sql_text,sErrorMsg: WideString;
  vData:OleVariant;
begin
    if cxbe_GFKeyValue.Text='' then
   begin
        showmessage('���������ѯƷ��');
        exit;
   end;
   sql_text:='exec usp_UpdateFnmArtByHand 3,' +QuotedStr(cxbe_GFKeyValue.Text);
   FNMServerObj.GetQueryBySQL(vData,sql_text,sErrorMsg);
   if sErrorMsg <> '' then
   begin
      raise ExceptionEx.CreateResFmt(@SaveCheckArtDataError, [sErrorMsg]);
   end ;
   cdsArtbyHand.Data:=vData;
   if    cdsArtbyHand.FieldByName('gf_id').AsInteger>0 then
     Result:=True
   else    Result:=False;
end;

end.


