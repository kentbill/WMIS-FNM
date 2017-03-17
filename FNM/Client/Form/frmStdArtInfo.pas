unit frmStdArtInfo;
{*|<PRE>*****************************************************************************
                                                                             
       软件名称 FNM CLIENT MODEL
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                              
       单元名称 frmStdArtInfo.pas                                              
       创建日期 2004-8-30 下午 04:26:18
       创建人员 lvzd
       对应用例
        2.1.	制定标准工艺
       相关数据库表:
        1: fnStdArtHdr
        2: fnStdArtDtl
       调用重要函数/SQL对象说明
        1: 调用中间层函数:FNMServerArtObj.GetNoArtOrCheckGFNO
       功能描述:
        建立, 修改, 确认标准工艺                                                                
                                                                              
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
    {* 工艺明细插入品名库信息表.}
    function CheckArtByHand(gf_no: string):Boolean;
    {* 判断品名是否已存在品名库信息表中.}
  public
    { public declarations }
    StdArtData: TSTDArtDtlInfo;
    {* 标准工艺类对象}

    procedure ChangeEditControlEnable(EnableEdit: Boolean);
    {* 改变工序等编辑控件的编辑状态.}
    procedure ChangeParameterEditMode(EditMode: Boolean);
    {* 改变工序参数等编辑控件的编辑状态}
    procedure OpenStdArt(DataID: Integer; OpenType: String);
    {* 取出工艺供用户编辑}
    procedure SelectAOperation;
    {* 用户选择了一个工序}
    procedure CopyStdArtClick(Sender: TObject);
    {* 拷贝工艺菜单的单击事件}
    
    procedure ArtAfterEdit(Sender: TObject);
    {* 当工艺被编辑后,见FormCreate事件中:StdArtData.OnAfterEdit:=ArtAfterEdit;}
    procedure ArtBeforeSave(Sender: TObject);
    {* 工艺保存之前工艺类调用函数,见FormCreate事件中:StdArtData.OnBeforeSave:=ArtBeforeSave;}
    procedure ArtAfterSave(Sender: TObject);
    {* 当工艺保存成功后,见FormCreate事件中:StdArtData.OnAfterSave:=ArtAfterSave;}
    procedure ArtAfterOpen(Sender: TObject);
    {* 当工艺打开后,见FormCreate事件中:StdArtData.OnAfterOpen:=ArtAfterOpen;}
    procedure ArtAfterClose(Sender: TObject);
    {* 当工艺关闭后,见FormCreate事件中:StdArtData.OnArtAfterClose:=ArtAfterClose;}
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
  if Trim(StdArtData.Checker) <>'' then    //CHECK后不能编辑
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
  //请求ID : 258664  取消所有用户”复制工艺”权限	tracy tan 2016-9-12
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

  //取品名ID或Std_Art_ID
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
  //把界面上的数据保存到工艺实例中
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

    //工艺代号
    SubStrLen:=pos(';', TheFN_Art_NO);
    TGlobal.SetComboBoxValue(cbb_FN_Art_NO1, LeftStr(TheFN_Art_NO, SubStrLen - 1));
    System.Delete(TheFN_Art_NO, 1, SubStrLen);
    //荧光
    SubStrLen:=pos(';', TheFN_Art_NO);
    TGlobal.SetComboBoxValue(cbb_FN_Art_NO2, LeftStr(TheFN_Art_NO, SubStrLen - 1));
    System.Delete(TheFN_Art_NO, 1, SubStrLen);
    //组织结构
    SubStrLen:=pos(';', TheFN_Art_NO);
    TGlobal.SetComboBoxValue(cbb_FN_Art_NO4, LeftStr(TheFN_Art_NO, SubStrLen - 1));
    System.Delete(TheFN_Art_NO, 1, SubStrLen);
    //缩水要求
    cbb_Shrinkage.Text:=Shrinkage;
    //手感要求
    edt_HandFeel.Text:=HandFeel;
    //门幅
    edt_ProductWidth.Text:=Product_Width;
    //颜色
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
    //填充工序到列表框中
    FillOperationToAListControls(lst_Operationlist.Items);
  end;
  //显示CAD信息
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

    //缩水要求
    if cbb_Shrinkage.Text = '' then
      cbb_Shrinkage.Text:=Shrinkage;
    //手感要求
    if edt_HandFeel.Text = '' then
      edt_HandFeel.Text:=Handfeel;
    //门幅
    if edt_ProductWidth.Text = '' then
      edt_ProductWidth.Text:=Width;
  end;
  OldFNArtNO2 := cbb_FN_Art_NO2.Text;
  //显示花型控件
  AutoShowCADPicture(CADInfo.OrgGFKeyValue);
    //设置编辑控件可用
  ChangeEditControlEnable(true);
  //工艺未确认则确认按钮可用.
  with Sender as TSTDArtDtlInfo do
  begin
    btn_CheckArtData.Enabled:=(Trim(Art_ID) <> '') and (Current_Department = Login.CurrentDepartment);
    if btn_CheckArtData.Enabled then
    begin
      if Trim(Checker) = '' then
        btn_CheckArtData.Caption:='确认(&V)'
      else
        btn_CheckArtData.Caption:='取消确认(&V)'
    end
  end;
  getRedio;
  //检查品名库是否已存在   liaogc 2015-12-21

  if not CheckArtByHand(cxbe_GFKeyValue.Text) then
  begin
     chkArtByHand.Caption:='插入品名库'
  end
  else     chkArtByHand.Caption:='更新品名库'
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
  //默认显示第一页
  pgc_GFNOList.ActivePageIndex:=0;
  pgc_Operation.ActivePageIndex:=0;
  PageControl1.ActivePageIndex := 0;

  //ListView的双击事件
  lv_CurNOCheckArt.OnDblClick:=TGlobal.DblClickAListview;
  lv_OtherNOCheckArt.OnDblClick:=TGlobal.DblClickAListview;
  lv_Feedback.OnDblClick:=TGlobal.DblClickAListview;
  //TWinControl的双击事件
  cbb_Operation_Name.OnDblClick:=TGlobal.DblClickAWinControl;
  //构造标准工艺类
  StdArtData:=TSTDArtDtlInfo.Create(Self);
  StdArtData.OrgDepartment:=Login.CurrentDepartment;
  StdArtData.OnAfterEdit:=ArtAfterEdit;
  StdArtData.OnBeforeSave:=ArtBeforeSave;
  StdArtData.OnAfterSave:=ArtAfterSave;
  StdArtData.OnAfterOpen:=ArtAfterOpen;
  StdArtData.OnAfterClose:=ArtAfterClose;
  //请求ID : 252770界面中的 “插入品名库”的权限只给到 fangy/ gaoyp, 其他用户权限封闭  tracy tan     2016-8-18
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
  //窗体KeyDown
  if Sender = Self then
  case Key of
    VK_F5: btn_RefrshGFNOList.Click;
    VK_F8: StdArtData.SaveArtToDataBase;
  end;

  //品名编辑框KeyDown
  if Sender = cxbe_GFKeyValue then
  case Key of
    VK_RETURN:
      cxbe_GFKeyValue.Properties.OnButtonClick(Sender, 0);
  end;

  //无工艺品名 或 待确认品名的ListView的KeyDown
  if Sender.ClassNameIs('TListView') then
  case Key of
    VK_RETURN:
    begin
      //工艺未保存则退出
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

  //工艺拷贝品名编辑框KeyDown
  if Sender = edt_CopyExistArt then
  case Key of
    VK_RETURN: btn_CopyExistArt.Click;
  end;

  //工序列表 KeyDown
  if Sender = cbb_Operation_Name then
  case Key of
    VK_RETURN: btn_Add_Operation.Click;
  end;

  //工序列表KeyDown
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

    //用户要求总是刷新数据
//    if cxbe_GFKeyValue.Text = StdArtData.GF_NO then exit;

    //工艺关闭失败则退出
    if not StdArtData.CloseArt then exit;
    //取品名ID或Std_Art_ID
    GetStdArtIDbyGFNO(cxbe_GFKeyValue.Text, Login.CurrentDepartment, iSTD_Art_ID, iGF_ID);
    //打开或建立工艺
    if iSTD_Art_ID <> -1 then
      OpenStdArt(iSTD_Art_ID, 'Open')
    else
      OpenStdArt(iGF_ID, 'Create');
    //定位到LISTVIEW
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

  //加入参数
  StdArtData.AddAOperateStep(OperationID);

  //界面布置
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
    TMsgDialog.ShowMsgDialog('此品名工艺已经确认,请先取消确认再修改工艺',mtInformation);
    Exit;
  end;
  
  ItemIndex:=lst_Operationlist.ItemIndex;
  if ItemIndex = -1 then exit;

  Step_NO:=Integer(lst_Operationlist.Items.Objects[ItemIndex]);

  //用户按下btn_Del_Operation按钮
  if Sender = btn_Del_Operation then
  begin
    StdArtData.MoveAOperateStep(Step_NO, ooDelete);
    ItemIndex:=ItemIndex-1;
  end;

  //用户按下btn_MoveDown_Operation按钮
  if Sender = btn_MoveDown_Operation then
  begin
    if ItemIndex < lst_Operationlist.Count - 1 then
    begin
      StdArtData.MoveAOperateStep(Step_NO, ooMoveDown);
      ItemIndex:=ItemIndex+1;
    end;
  end;

  //用户按下btn_MoveUP_Operation按钮
  if Sender = btn_MoveUP_Operation then
  begin
    if ItemIndex > 0 then
    begin
      StdArtData.MoveAOperateStep(Step_NO, ooMoveUP);
      ItemIndex:=ItemIndex-1;
    end;
  end;

  //界面布置
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
      
      //判断配方是否可用 --begin----
      if Trim(KeyName) = '配方' then
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
          ShowMessage('此配方' + Trim(KeyValue) + '不允许使用，请修改！');
        end;
      end;
      //判断配方是否可用 --end----

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
  //显示修改比例
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
    TMsgDialog.ShowMsgDialog('获取修改比例失败!',mtError);
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

  //刷新反馈界面
  with lv_Feedback.Items do
  begin
    for i := 0 to Count - 1 do
      if Item[i].Caption = StdArtData.GF_NO then
      begin
        Item[i].Delete;
        break;
      end;
  end;
  ts_Feedback.Caption := Login.CurrentDepartment + '工艺反馈['+ IntToStr(lv_Feedback.Items.Count)+']';

  //显示修改比例
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

  //填充数据(填充GF_ID到Items的Object对象列表)
    // 增加过滤条件 AND is_confirm>0  liaogc 20160421
  TempClientDataSet.Filter:=Format('Current_Department = ''%s'' AND Type = ''%s'' AND is_confirm>0 ', [Login.CurrentDepartment,'待确认']);
  TempClientDataSet.Filtered:=True;
  FillListItemsFromDataSet(TempClientDataSet, 'GF_NO', '', ['STD_Art_ID', 'Construction','CADChange'], lv_CurNOCheckArt.Items);
  ts_NoCheck.Caption := Login.CurrentDepartment + '待确认['+ IntToStr(lv_CurNOCheckArt.Items.Count)+']';

  TempClientDataSet.Filter:= Format('Current_Department <> ''%s'' AND Type <> ''%s'' AND is_confirm>0 ', [Login.CurrentDepartment ,'工艺反馈']);
  TempClientDataSet.Filtered:=True;
  FillListItemsFromDataSet(TempClientDataSet, 'GF_NO', '', ['STD_Art_ID', 'Construction','CADChange'], lv_OtherNOCheckArt.Items);
  ts_Other.Caption := '其他待确认['+ IntToStr(lv_OtherNOCheckArt.Items.Count)+']';

  if Login.CurrentDepartment= 'FG' then
    TempClientDataSet.Filter:=Format('Current_Department = ''%s'' AND Type = ''%s'' AND is_confirm>0 ', [Login.CurrentDepartment ,'工艺反馈'])
  else
    TempClientDataSet.Filter:=Format('Current_Department = ''%s'' AND Type = ''%s'' AND is_confirm>0 ', [Login.CurrentDepartment ,'工艺反馈']);
  TempClientDataSet.Filtered:=True;
  FillListItemsFromDataSet(TempClientDataSet, 'GF_NO', '', ['STD_Art_ID', 'Construction','CADChange'], lv_Feedback.Items);
  ts_Feedback.Caption := Login.CurrentDepartment + '工艺反馈['+ IntToStr(lv_Feedback.Items.Count)+']';

 //增加需调度确认数据
  TempClientDataSet.Filter:= Format('is_confirm=0 ', [Login.CurrentDepartment ,'待确认']);
  TempClientDataSet.Filtered:=True;
  FillListItemsFromDataSet(TempClientDataSet, 'GF_NO', '', ['STD_Art_ID', 'Construction','CADChange'], lv_UNConfirm.Items);
  ts_UnConfirm.Caption := '待调度确认['+ IntToStr(lv_UNConfirm.Items.Count)+']';


  TempClientDataSet.Filtered := False;
end;

procedure TStdArtInfoForm.Vle_Operation_ParlistEditButtonClick(Sender: TObject);
var
  Item_Value: String;
begin
  with Sender as TValueListEditor do
  begin
    if Pos('取样', Trim(Cells[0,Row])) > 0 then
      Item_Value:=GetSampleNo(Cells[1,Row]);
    if Pos('配方', Trim(Cells[0,Row])) > 0 then
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
    TMsgDialog.ShowMsgDialog('荧光属性为空，不能确认!',mtInformation);
    Exit;
  end;

  if (Login.LoginID <> 'liaogc') and (Login.UserLevelList = '') or (Pos('3',Login.UserLevelList)<0) then   //3--有工艺确认和取消权限
  begin
    TMsgDialog.ShowMsgDialog('你没有工艺确认和取消的权限,请联系你们的组长',mtInformation);
    Exit;
  end;

  cxbe_GFKeyValue.SetFocus;
  if btn_CheckArtData.Caption <> '确认(&V)' then
  begin
    StdArtData.CheckStdArt(0);//取消确认
    btn_CheckArtData.Caption:='确认(&V)';
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
      TMsgDialog.ShowMsgDialog('此品名工艺无效,请先选择其有效后才能确认和取消确认',mtInformation);
      Exit;
    end;
    StdArtData.CheckStdArt(1); //确认
    if chkArtByHand.Checked=True then
       SaveFnmArtbyHand;    //确认，插入品名库工艺信息 liaogc 2015-12-25

    getRedio();
    btn_CheckArtData.Caption:='取消确认(&V)';
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
  if btn_CheckArtData.Caption ='取消确认(&V)' then
  begin
    SetLength(sParam,5);
    sParam[0] := '3';   // 213-8-12 检查是否是大花型 ，提示也放在这里
    sParam[1] := '4';   // 213-8-15 检查CUSTOMER_ID ，提示也放在这里
    sParam[2] := '0';   // 213-8-12 检查是否是大花型 ，提示也放在这里
    sParam[3] := '5';   // 213-10-16 检查丝光定幅是否大于坯布幅宽
    sParam[4] := '6';   // 213-10-18  检查 工艺备注 提示
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

//  // 213-8-12 检查是否是大花型 ，提示也放在这里
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
//  // 213-8-15 检查CUSTOMER_ID ，提示也放在这里
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
//  // 检查配方 --- begin---------
//  // 213-8-12 检查是否是大花型 ，提示也放在这里
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
//  // 检查配方 --- end---------

  //显示修改比例
  getRedio;

  StdArtData.CloseArt;
  PageControl1.ActivePageIndex := 0;
  ts_NoCheck.Caption := Login.CurrentDepartment + '待确认['+ IntToStr(lv_CurNOCheckArt.Items.Count)+']';  
end;

procedure TStdArtInfoForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  //刷新界面数据
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
  //加载后整工艺代号字典
  FillArt_NOListToAComboBox('G', cbb_FN_Art_NO1);
  FillFN_Art_NOListToAComboBox('荧光属性', cbb_FN_Art_NO2);
  FillFN_Art_NOListToAComboBox('花型', cbb_FN_Art_NO4);
  //加载颜色字典
  FillItemsFromDataSet(Dictionary.cds_ColorList, 'FN_Color_Code', 'FN_Color_Name', 'Iden','-', cbb_ColorCode.Items);
  cbb_ColorCode.DropDownCount:=cbb_ColorCode.Items.Count;
  //缩水要求字典
  FillItemsFromDataSet(Dictionary.cds_ShrinkageList, 'Shrinkage', '', '','', cbb_Shrinkage.Items);
 //填充工序选择树
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
    TMsgDialog.ShowMsgDialog('此布不含荧光,荧光属性只能设置为 [BP-漂白防荧光]', mtWarning);
    cbb_FN_Art_NO2.ItemIndex := 2
  end else
    if cbb_FN_Art_NO2.ItemIndex = 2 then
    begin
      TMsgDialog.ShowMsgDialog('此布含荧光,荧光属性不能设置为 [BP-漂白防荧光]', mtWarning);
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
        showmessage('请先输入查询品名');
        exit;
   end;
   sql_text:='exec usp_UpdateFnmArtByHand 1,' +QuotedStr(cxbe_GFKeyValue.Text)+','+QuotedStr(login.CurrentDepartment)
            +','+QuotedStr(login.LoginName);
   FNMServerObj.GetQueryBySQL(vData,sql_text,sErrorMsg);
   if sErrorMsg <> '' then
   begin
      raise ExceptionEx.CreateResFmt(@SaveCheckArtDataError, [sErrorMsg]);
   end
   else TMsgDialog.ShowMsgDialog(chkArtByHand.Caption+'成功',mtInformation);

end;


procedure TStdArtInfoForm.btnDeleteArtByHandClick(Sender: TObject);
var
  sql_text,sErrorMsg: WideString;
  vData:OleVariant;
begin
   if cxbe_GFKeyValue.Text='' then
   begin
        showmessage('请先输入查询品名');
        exit;
   end;
   sql_text:='exec usp_UpdateFnmArtByHand 2,' +QuotedStr(cxbe_GFKeyValue.Text);
   FNMServerObj.GetQueryBySQL(vData,sql_text,sErrorMsg);
   if sErrorMsg <> '' then
   begin
      raise ExceptionEx.CreateResFmt(@SaveCheckArtDataError, [sErrorMsg]);
   end
   else TMsgDialog.ShowMsgDialog('已删除品名 '+cxbe_GFKeyValue.Text,mtInformation);

end;

function TStdArtInfoForm.CheckArtByHand(gf_no: string):Boolean;
var
  sql_text,sErrorMsg: WideString;
  vData:OleVariant;
begin
    if cxbe_GFKeyValue.Text='' then
   begin
        showmessage('请先输入查询品名');
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


