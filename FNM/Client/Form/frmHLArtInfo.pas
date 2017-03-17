unit frmHLArtInfo;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmHLArtInfo.pas                                              }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 Lvzd                                                          }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  手织板工艺制定                                               }
{                                                                              }
{******************************************************************************}

interface

uses
  uFNMArtInfo,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ValEdit, ComCtrls, ExtCtrls, DB, DBClient,
  Buttons, cxControls, cxSplitter, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridLevel, cxGrid, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit;

type
  THLArtForm = class(TForm)
    btn_Exit: TSpeedButton;
    btn_Help: TSpeedButton;
    btn_CreateHLArt: TSpeedButton;
    btn_SaveArt: TSpeedButton;
    cxspl_XX: TcxSplitter;
    pnl_Only: TPanel;
    pnl_Only2: TPanel;
    txt_Only: TStaticText;
    cds_HLBasicInfo: TClientDataSet;
    ds_HLBasicInfo: TDataSource;
    btn_ViewArtDtl: TSpeedButton;
    spl1: TSplitter;
    lst_Operationlist: TListBox;
    btn_MoveUP_Operation: TSpeedButton;
    btn_MoveDown_Operation: TSpeedButton;
    btn_Del_Operation: TSpeedButton;
    btn_Add_Operation: TSpeedButton;
    grp_Only: TGroupBox;
    mmo_Remark: TMemo;
    pgc_Operation: TPageControl;
    ts_Only: TTabSheet;
    cbb_Operation_Name: TComboBox;
    vle_Operation_Parlist: TValueListEditor;
    edt_BR: TEdit;
    txt1: TStaticText;
    edt_HL_NO: TEdit;
    edt_Anti_Fluorescence: TEdit;
    edt_Mercerizing: TEdit;
    edt_Class: TEdit;
    cbb_FN_Art_NO1: TComboBox;
    cxGridl_HLFNNO: TcxGridLevel;
    cxgrid_HLFNNO: TcxGrid;
    cxgtv_HLFNNO: TcxGridTableView;
    btn_Refresh: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure KeyDownAControl(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure btn_Add_OperationClick(Sender: TObject);
    procedure btn_Operation(Sender: TObject);
    procedure btn_CreateHLArtClick(Sender: TObject);
    procedure lst_OperationlistClick(Sender: TObject);
    procedure vle_Operation_ParlistKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vle_Operation_ParlistKeyPress(Sender: TObject;
      var Key: Char);
    procedure vle_Operation_ParlistValidate(Sender: TObject; ACol,
      ARow: Integer; const KeyName, KeyValue: String);
    procedure btn_SaveArtClick(Sender: TObject);
    procedure cbb_FN_Art_NO1Change(Sender: TObject);
    procedure vle_Operation_ParlistEditButtonClick(Sender: TObject);
    procedure btn_ViewArtDtlClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    HLArtInfo: THLArtDtlInfo;

    procedure SelectAOperation;
    procedure GetNoArtReceiveHLList;
    procedure ChangeEditControlEnable(EnableEdit: Boolean);

    procedure ArtAfterEdit(Sender: TObject);
    {* 当工艺被编辑后,见FormCreate事件中:StdArtData.OnAfterEdit:=ArtAfterEdit;}
    procedure ArtBeforeSave(Sender: TObject);
    {* 工艺保存之前工艺类调用函数,见FormCreate事件中:StdArtData.OnBeforeSave:=ArtBeforeSave;}
    procedure ArtAfterSave(Sender: TObject);
    {* 当工艺保存成功后,见FormCreate事件中:StdArtData.OnAfterSave:=ArtAfterSave;}
    procedure ArtAfterClose(Sender: TObject);
    {* 当工艺关闭后,见FormCreate事件中:StdArtData.OnArtAfterClose:=ArtAfterClose;}
  end;

var
  HLArtForm: THLArtForm;

implementation

uses StrUtils, Math, uFNMResource, uGlobal, uDictionary, uLogin,
    ServerDllPub, uGridDecorator, frmCreateSample, frmCreateStdPrescription;

{$R *.dfm}

procedure THLArtForm.SelectAOperation;
var
  Step_NO: Integer;
begin
  if lst_Operationlist.ItemIndex <> -1 then
  begin
    Step_NO:=Integer(lst_Operationlist.Items.Objects[lst_Operationlist.ItemIndex]);
    if Vle_Operation_Parlist.Tag <> Step_NO then
    begin
      HLArtInfo.FillAStepToAListControls(Step_NO, Vle_Operation_Parlist);
      Vle_Operation_Parlist.Tag:=Step_NO;
    end;
  end;
  Vle_Operation_Parlist.Enabled:=Vle_Operation_Parlist.Strings.Count > 0;
  
  if lst_Operationlist.Focused then
    pgc_Operation.ActivePageIndex := 1;
end;

procedure THLArtForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure THLArtForm.FormDestroy(Sender: TObject);
begin
  HLArtForm:=nil;
end;

procedure THLArtForm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure THLArtForm.FormCreate(Sender: TObject);
begin
  //加载图标
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btn_SaveArt.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Help.Glyph.LoadFromResourceName(HInstance, RES_HELPABOUT);
  btn_CreateHLArt.Glyph.LoadFromResourceName(HInstance, RES_NEW);
  btn_Add_Operation.Glyph.LoadFromResourceName(HInstance, RES_LEFT);
  btn_Del_Operation.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btn_MoveUP_Operation.Glyph.LoadFromResourceName(HInstance, RES_MOVEUP);
  btn_MoveDown_Operation.Glyph.LoadFromResourceName(HInstance, RES_MOVEDOWN);
  //WinControl的双击事件
  cbb_Operation_Name.OnDblClick:=TGlobal.DblClickAWinControl;
  cxgtv_HLFNNO.OnDblClick:=TGlobal.DblClickAWinControl;
  //布置界面
  btn_SaveArt.Enabled:=false;
  cbb_Operation_Name.Align:=alClient;
  ChangeEditControlEnable(false);

  (btn_CreateHLArt as TControl).Align:=alTop;
  pnl_Only2.Align:=alClient;
  pgc_Operation.ActivePageIndex:=0;
  //构造实际工艺类
  HLArtInfo:=THLArtDtlInfo.Create(Self);
  HLArtInfo.OnAfterEdit:=ArtAfterEdit;
  HLArtInfo.OnBeforeSave:=ArtBeforeSave;
  HLArtInfo.OnAfterSave:=ArtAfterSave;
  HLArtInfo.OnAfterClose:=ArtAfterClose;
end;

procedure THLArtForm.ChangeEditControlEnable(EnableEdit: Boolean);
begin
  if not EnableEdit then
  begin
    cbb_FN_Art_NO1.ItemIndex:=-1;
    edt_Anti_Fluorescence.Text:='';
    edt_BR.Text:='';
    edt_Class.Text:='';
    edt_HL_NO.Text:='';
    edt_Mercerizing.Text:='';
    mmo_Remark.Text:='';
    lst_Operationlist.Items.Clear;
    Vle_Operation_Parlist.Strings.Clear;
  end;

  btn_Add_Operation.Enabled:=EnableEdit;
  btn_CreateHLArt.Enabled:=not EnableEdit;
  btn_Del_Operation.Enabled:=EnableEdit;
  btn_MoveDown_Operation.Enabled:=EnableEdit;
  btn_MoveUP_Operation.Enabled:=EnableEdit;
  cbb_FN_Art_NO1.Enabled:=EnableEdit;
  lst_Operationlist.Enabled:=EnableEdit;
  mmo_Remark.Enabled:=EnableEdit;
  Vle_Operation_Parlist.Enabled:=EnableEdit;
end;

procedure THLArtForm.KeyDownAControl(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Sender = Self then
  case Key of
    VK_F5: GetNoArtReceiveHLList;
    VK_F8: HLArtInfo.SaveArtToDataBase;
  end;

  if Sender = lst_Operationlist then
  case Key of
    VK_RETURN, VK_UP, VK_DOWN: SelectAOperation;
  end;

  if Sender = cbb_Operation_Name then
  case Key of
    VK_RETURN: btn_Add_Operation.Click;
  end;

  //无工艺品名表格
  if Sender.ClassNameIs('TcxgridSite') and ((Sender as TcxgridSite).GridView = cxgtv_HLFNNO)then
  case Key of
    VK_RETURN:
    begin
      btn_CreateHLArt.Click;
    end;
  end;
end;

procedure THLArtForm.btn_Add_OperationClick(Sender: TObject);
var
  OperationID: Integer;
begin
  if not HLArtInfo.Active then exit;
  if not btn_Add_Operation.Enabled then exit;

  with cbb_Operation_Name do
    if (Text = '') or (Items.IndexOf(Text) = -1)then exit;
    
  //加入参数
  with cbb_Operation_Name do
  begin
    OperationID:=Integer(Items.Objects[Items.IndexOf(Text)]);
    Text:='';
  end;

  HLArtInfo.AddAOperateStep(OperationID);

  //界面布置
  HLArtInfo.FillOperationToAListControls(lst_Operationlist.Items);
  lst_Operationlist.ItemIndex:=lst_Operationlist.Count -1;
  SelectAOperation;
end;

procedure THLArtForm.btn_Operation(Sender: TObject);
var
  ItemIndex, Step_NO: Integer;
begin
  ItemIndex:=lst_Operationlist.ItemIndex;
  if ItemIndex = -1 then exit;
  
  Step_NO:=Integer(lst_Operationlist.Items.Objects[ItemIndex]);

  //用户按下btn_Del_Operation按钮
  if Sender = btn_Del_Operation then
  begin
    HLArtInfo.MoveAOperateStep(Step_NO, ooDelete);
    ItemIndex:=ItemIndex - 1;
  end;

  //用户按下btn_MoveDown_Operation按钮
  if Sender = btn_MoveDown_Operation then
  begin
    if ItemIndex < lst_Operationlist.Count - 1 then
    begin
      HLArtInfo.MoveAOperateStep(Step_NO, ooMoveDown);
      ItemIndex:=ItemIndex + 1;
    end;
  end;

  //用户按下btn_MoveUP_Operation按钮
  if Sender = btn_MoveUP_Operation then
  begin
    if ItemIndex > 0 then
    begin
      HLArtInfo.MoveAOperateStep(Step_NO, ooMoveUP);
      ItemIndex:=ItemIndex - 1
    end;
  end;

  //界面布置
  if ItemIndex <> lst_Operationlist.ItemIndex then
  begin
    HLArtInfo.FillOperationToAListControls(lst_Operationlist.Items);
    Vle_Operation_Parlist.Strings.Clear;
    if lst_Operationlist.Items.Count <> 0 then
    begin
      lst_Operationlist.ItemIndex:=ifthen(ItemIndex = -1, 0, ItemIndex);
      SelectAOperation;
    end;
  end;
end;

procedure THLArtForm.btn_CreateHLArtClick(Sender: TObject);
var
  FN_ID, FN_NO: String;
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  if not HLArtInfo.CloseArt then
    exit;
  with cxgtv_HLFNNO do
  begin
    if Controller.SelectedRowCount = 0 then exit;
    FN_NO:=Controller.SelectedRows[0].Values[FindItemByName('FN_NO').Index];//lv_FNNOList.Selected.Caption;
    FN_ID:=Controller.SelectedRows[0].Values[FindItemByName('Iden').Index];//lv_FNNOList.Selected.SubItems.Strings[0];

    edt_HL_NO.Text:=Controller.SelectedRows[0].Values[FindItemByName('FN_NO').Index];
    edt_Anti_Fluorescence.Text:=Controller.SelectedRows[0].Values[FindItemByName('Fluorescence').Index];
    edt_Class.Text:=Controller.SelectedRows[0].Values[FindItemByName('HL_Type').Index];
    edt_Mercerizing.Text:=Controller.SelectedRows[0].Values[FindItemByName('Mercerizing').Index];
    edt_BR.Text:=Controller.SelectedRows[0].Values[FindItemByName('Is_Blue_R').Index];
   end;
{
  FNMServerArtObj.GetFNNOInfo(FN_NO, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetNOArtReceiveHL, [sErrorMsg]);

  TempClientDataSet.Data:=vData;
  if TempClientDataSet.IsEmpty then
    raise Exception.CreateRes(@EMP_FNNOInfo);

  edt_HL_NO.Text:=TempClientDataSet.FieldValues['FN_NO'];
  edt_Anti_Fluorescence.Text:=TempClientDataSet.FieldValues['Fluorescence'];
  edt_Class.Text:=TempClientDataSet.FieldValues['HL_Type'];
  edt_Mercerizing.Text:=TempClientDataSet.FieldValues['Mercerizing'];
  edt_BR.Text:=TempClientDataSet.FieldValues['Is_Blue_R'];
}

  HLArtInfo.CreateHLArt(FN_ID, FN_NO, Login.LoginName);

  btn_CreateHLArt.Enabled:=false;
  ChangeEditControlEnable(True);
end;

procedure THLArtForm.lst_OperationlistClick(Sender: TObject);
begin
  SelectAOperation;
end;

procedure THLArtForm.vle_Operation_ParlistKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

procedure THLArtForm.vle_Operation_ParlistKeyPress(Sender: TObject;
  var Key: Char);
begin
  with Sender as TValueListEditor do
  begin
    if ItemProps[Cells[0,Row]].EditStyle = esEllipsis then
    begin
      if Assigned(OnEditButtonClick) then
        OnEditButtonClick(Sender);
    end
  end;
end;

procedure THLArtForm.vle_Operation_ParlistValidate(Sender: TObject; ACol,
  ARow: Integer; const KeyName, KeyValue: String);
begin
  HLArtInfo.SetAOperateParameterValue(Vle_Operation_Parlist.Tag, Trim(KeyName), Trim(KeyValue));
end;

procedure THLArtForm.GetNoArtReceiveHLList;
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  sCondition := '2';
  FNMServerObj.GetQueryData(vData,'GetFNNOInfo',sCondition,sErrorMsg);
//  FNMServerArtObj.GetFNNOList(2, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetNOArtReceiveHL, [sErrorMsg]);
  TempClientDataSet.Data:=vData;

  if TempClientDataSet.IsEmpty then
    raise Exception.CreateRes(@EMP_NoArtReceiveedHL);

  GridDecorator.BindcxTableView(cxgtv_HLFNNO, TempClientDataSet, ['FN_NO', 'IDen','Fluorescence','HL_Type','Mercerizing','Is_Blue_R']);
  //FillListItemsFromDataSet(TempClientDataSet, 'FN_NO', '', ['Iden'], lv_FNNOList.Items);
end;

procedure THLArtForm.ArtAfterEdit(Sender: TObject);
begin
  btn_SaveArt.Enabled:=HLArtInfo.Modify;
end;

procedure THLArtForm.ArtAfterSave(Sender: TObject);
begin
  btn_SaveArt.Enabled:=false;
end;

procedure THLArtForm.ArtBeforeSave(Sender: TObject);
begin
  cxgrid_HLFNNO.SetFocus;
  HLArtInfo.FN_Art_NO:=format('%s;%s',
      [LeftStr(cbb_FN_Art_NO1.Text, Pos(' ', cbb_FN_Art_NO1.Text) - 1),
       edt_Anti_Fluorescence.text]);
  HLArtInfo.Remark:=mmo_Remark.Text;
end;

procedure THLArtForm.btn_SaveArtClick(Sender: TObject);
var
  RecordIndex: Integer;
begin
  cxgrid_HLFNNO.SetFocus;
  HLArtInfo.SaveArtToDataBase;
  with cxgtv_HLFNNO, cxgtv_HLFNNO.DataController do
  begin
    RecordIndex:= FindRecordIndexByText(0, FindItemByName('FN_NO').Index, HLArtInfo.FN_NO, True, True, True);
    if RecordIndex <> -1 then
      DeleteRecord(RecordIndex);
  end;
  HLArtInfo.CloseArt;
end;

procedure THLArtForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  //刷新界面数据
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
  //加载后整工艺代号字典
  FillArt_NOListToAComboBox('H', cbb_FN_Art_NO1);
   //填充工序选择树
  Dictionary.cds_OperationDtlList.Filter :='Use_Department LIKE ''%'+Login.CurrentDepartment + '%''';
  Dictionary.cds_OperationDtlList.Filtered := True;
  FillItemsFromDataSet(Dictionary.cds_OperationDtlList, 'Operation_Code', 'Operation_CHN', 'Iden', '--', cbb_Operation_Name.Items);

  OnActivate:=nil;
end;

procedure THLArtForm.cbb_FN_Art_NO1Change(Sender: TObject);
var
  i, MessResult: Integer;
begin
  if HLArtInfo.GetOperateStepCount <> 0 then
  begin
    MessResult:= ShowMsgDialog(@MSG_ClearCurOperate, mtConfirmation);
    if MessResult <> mrOk then exit;

    HLArtInfo.ClearAllOperateStep;
  end;

  with Dictionary.cds_StdArtDtlList do
  try
    Filter:='Type = ''H'' AND Art_NO = ''' + LeftStr(cbb_FN_Art_NO1.Text, Pos(' ', cbb_FN_Art_NO1.Text) - 1) + '''';
    Filtered:=True;
    for i := 0 to RecordCount - 1 do
    begin
      HLArtInfo.AddAOperateStep(Dictionary.cds_StdArtDtlList.FieldByName('Operation_Iden').AsInteger);
      next;
    end;
  finally
    Filtered:=false;
    //界面布置
    HLArtInfo.FillOperationToAListControls(lst_Operationlist.Items);
    lst_Operationlist.ItemIndex:=lst_Operationlist.Count -1;
    SelectAOperation;
  end;
end;

procedure THLArtForm.ArtAfterClose(Sender: TObject);
begin
  btn_SaveArt.Enabled:=False;
  ChangeEditControlEnable(false);
end;

procedure THLArtForm.vle_Operation_ParlistEditButtonClick(Sender: TObject);
begin
  with Sender as TValueListEditor do
  begin
    if Pos('取样', Trim(Cells[0,Row])) > 0 then
      Cells[Col,Row]:=GetSampleNo(Cells[1,Row]);
    if Pos('配方', Trim(Cells[0,Row])) > 0 then
      Cells[Col,Row]:=GetStdPrescriptionNo(HLArtInfo.GetStepOperateCode(Tag),'H', Cells[1,Row]);

    (Sender as TValueListEditor).OnValidate(Sender, Col, Row, Cells[0, Row], Cells[Col,Row]);
  end;

end;

procedure THLArtForm.btn_ViewArtDtlClick(Sender: TObject);
begin
  HLArtInfo.ViewArtDtlInNewForm;
end;

procedure THLArtForm.btn_RefreshClick(Sender: TObject);
begin
  GetNoArtReceiveHLList;
end;

end.

