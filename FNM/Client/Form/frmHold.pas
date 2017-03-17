unit frmHold;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmHold.pas                                                   }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 lvzd                                                          }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  HOLD维护                                                     }
{                                                                              }
{******************************************************************************}

interface

uses
  uFNMArtInfo,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  DB, DBClient, StdCtrls, ComCtrls, ExtCtrls;

type
  THoldForm = class(TForm)
    pnl_Only: TPanel;
    btn_Previou: TButton;
    btn_Next: TButton;
    btn_Exit: TButton;
    pgc_Only: TPageControl;
    ts_Only: TTabSheet;
    rb_UnHold: TRadioButton;
    rb_NewHold: TRadioButton;
    rb_HoldClass1: TRadioButton;
    rb_HoldClass2: TRadioButton;
    ts1: TTabSheet;
    edt_GFKeyValue: TEdit;
    lblHoldReason: TLabel;
    cbb_Operation: TComboBox;
    lv_CardList: TListView;
    txt_Only: TStaticText;
    mmo_Result: TMemo;
    chk_EffectRepair: TCheckBox;
    txt_HoldListTitle: TStaticText;
    txt_Reason: TStaticText;
    mmo_Reason: TMemo;
    cdsHold: TClientDataSet;
    lv_HoldList: TListView;
    edtFilter: TEdit;
    procedure btn_Previou_NextClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure rb_HoldClassClick(Sender: TObject);
    procedure edt_GFKeyValueChange(Sender: TObject);
    procedure cbb_OperationDropDown(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lv_HoldListColumnClick(Sender: TObject; Column: TListColumn);
    procedure edtFilterKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    SelectPath: String;
    StdArt: TSTDArtDtlInfo;
    function GetCheckedItems: String;
    procedure SelectNextPage;
    procedure GetHoldList;
    procedure TestGFKeyValueExist(GF_KeyValue: String);
    function SaveHoldData: Boolean;
  public
    { Public declarations }
  end;

var
  HoldForm: THoldForm;

implementation

uses Math, Dialogs, StrUtils, uDictionary, uShowMessage, ServerDllPub,
  uFNMResource, uLogin, uGlobal;

{$R *.dfm}

procedure THoldForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOk then
    if not SaveHoldData then
      Action:=caNone;
end;

procedure THoldForm.FormDestroy(Sender: TObject);
begin
  StdArt.Destroy;
  HoldForm:=nil;
end;

function THoldForm.GetCheckedItems: String;
var
  i: Integer;
begin
  result:='';
  with lv_CardList.Items do
  for i := 0 to Count - 1 do
  begin
    if Item[i].Checked then
      result := result + Item[i].Caption + ';';
  end;    
end;

procedure THoldForm.btn_Previou_NextClick(Sender: TObject);
var
  OldPageIndex: Integer;
begin
  if (Sender = btn_Previou) and (SelectPath <> '') then
  begin
    pgc_Only.ActivePageIndex:=StrToInt(LeftStr(SelectPath, Pos(',', SelectPath) - 1));
    System.Delete(SelectPath, 1, Pos(',', SelectPath));
    edtFilter.Visible := (pgc_Only.ActivePageIndex = 2) and (rb_UnHold.Checked);
  end;

  if Sender = btn_Next then
  begin
    OldPageIndex:=pgc_Only.ActivePageIndex;
    SelectNextPage;
    SelectPath:=IntToStr(OldPageIndex) + ',' + SelectPath;
    pgc_Only.ActivePageIndex:=ifthen(pgc_Only.ActivePageIndex < pgc_Only.PageCount - 1, pgc_Only.ActivePageIndex + 1, pgc_Only.PageCount -1);
    edtFilter.Visible := (pgc_Only.ActivePageIndex = 2) and (rb_UnHold.Checked);
  end;

  btn_Previou.Enabled:=pgc_Only.ActivePageIndex <> 0;
  btn_Next.Enabled:=pgc_Only.ActivePageIndex <> pgc_Only.PageCount - 1;
  if btn_Next.Enabled then
  begin
     btn_Exit.Caption:='取消(&C)';
     btn_Exit.Cancel:=true;
     btn_Exit.Default:=false;
     btn_Exit.ModalResult:=mrCancel;
  end
  else
  begin
     btn_Exit.Caption:='完成(&O)';
     btn_Exit.Cancel:=false;
     btn_Exit.Default:=True;
     btn_Exit.ModalResult:=mrOk;
  end;
end;

procedure THoldForm.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to pgc_Only.PageCount - 1 do
  begin
    pgc_Only.Pages[i].TabVisible:=false;
    pgc_Only.Pages[i].Visible:=true;
  end;
  pgc_Only.ActivePageIndex:=0;

  btn_Previou.Enabled:=false;
  btn_Next.Enabled:=true;
  btn_Exit.Caption:='取消(&C)';
  btn_Exit.Cancel:=true;
  btn_Exit.Default:=false;
  btn_Exit.ModalResult:=mrCancel;
  SelectPath:='';
  //构造标准工艺类
  StdArt:=TSTDArtDtlInfo.Create(Self);
  StdArt.OrgDepartment:=Login.CurrentDepartment;
end;

procedure THoldForm.SelectNextPage;
var
  i:Integer;
  is_check:Boolean;
  sGFNO,sOperation,sFnCard:string;
begin
  is_check:= False;
  if pgc_Only.ActivePageIndex = 0 then
  begin
    if rb_UnHold.Checked then
    begin
      txt_HoldListTitle.Caption:='请选择需要解除HOLD的项.';
      txt_Reason.Caption:='请输入解除HOLD的原因.';

      GetHoldList;
      lv_HoldList.BringToFront;
      pgc_Only.ActivePageIndex:= 1;
    end;
    if rb_NewHold.Checked then
    begin
      txt_Reason.Caption:='请输入HOLD的原因.';
    end;
    exit;
  end;

  if pgc_Only.ActivePageIndex = 1 then
  begin
    //test 品名是否存在。
    if Trim(edt_GFKeyValue.Text) = '' then
      raise Exception.CreateRes(@INV_NOInPutGFKeyValue);

    TestGFKeyValueExist(edt_GFKeyValue.Text);

    if rb_HoldClass1.Checked then
    begin
      pgc_Only.ActivePageIndex:= 2;
    end
    else
    begin
      if cbb_Operation.Text = '' then
        raise Exception.CreateRes(@INV_NOOperation);
        
      txt_HoldListTitle.Caption:='请选择需要HOLD的卡号.';
      GetOnLineCardByGFKeyValue(edt_GFKeyValue.Text, Login.CurrentDepartment, cdsHold);
      lv_CardList.BringToFront;
      try
        cdsHold.Filter:='Is_Hold = ''0''';
        cdsHold.Filtered:=true;
        FillListItemsFromDataSet(cdsHold, 'FN_Card', '',
          ['GF_ID', 'GF_NO', 'Job_NO', 'Operation_Code', 'Operation_CHN', 'Quantity', 'Is_Hold'], lv_CardList.Items);
      finally
        cdsHold.Filtered:=False;
      end;
    end;
    exit;
  end;

  if pgc_Only.ActivePageIndex = 2 then
  begin
    if rb_UnHold.Checked then
    begin
      for i := 0 to lv_HoldList.Items.Count - 1 do
      begin
        if lv_HoldList.Items.Item[i].Checked then
        begin
          is_check := True;
          Break;
        end;
      end;
      if not is_check then
        raise Exception.Create('WAR_' + txt_HoldListTitle.Caption);
    end;
    if rb_NewHold.Checked then
    begin
      if GetCheckedItems = '' then
        raise Exception.Create('WAR_' + txt_HoldListTitle.Caption);
    end;
    exit;
  end;

  if pgc_Only.ActivePageIndex = 3 then
  begin
    if mmo_Reason.Text = '' then
      raise Exception.Create('WAR_' + txt_Reason.Caption);

    mmo_Result.Lines.Clear;

    if rb_UnHold.Checked then
      mmo_Result.Lines.Add('解除HOLD信息:')
    else
      mmo_Result.Lines.Add('HOLD信息:');
    mmo_Result.Lines.Add('---------------------------');

    if rb_UnHold.Checked then
    begin
      for i := 0 to lv_HoldList.Items.Count - 1 do
      begin
        if lv_HoldList.Items.Item[i].Checked then
        begin
          sGFNO := sGFNO + lv_HoldList.Items.Item[i].SubItems.Strings[0] + ';';
          sFnCard:=sFnCard + lv_HoldList.Items.Item[i].SubItems.Strings[1]+ ';';
          sOperation:= sOperation + lv_HoldList.Items.Item[i].SubItems.Strings[2]+ ';';
        end;
      end;
      mmo_Result.Lines.Add(Format('品名:%s', [sGFNO]));
      mmo_Result.Lines.Add(Format('卡号:%s', [sFnCard]));
      mmo_Result.Lines.Add(Format('工序:%s', [sOperation]));
    end
    else
    begin
      mmo_Result.Lines.Add(Format('品名:%s', [edt_GFKeyValue.Text]));
      if rb_HoldClass2.Checked then
        mmo_Result.Lines.Add(Format('卡号:%s', [GetCheckedItems]))
      else
      begin
        if cbb_Operation.ItemIndex = -1 then
          mmo_Result.Lines.Add('立即HOLD')
        else
          mmo_Result.Lines.Add(Format('工序:%s', [cbb_Operation.Text]));
        if chk_EffectRepair.Checked then
          mmo_Result.Lines.Add('对回修布有效.')
      end;
    end;
    mmo_Result.Lines.Add(Format('原因:%s', [mmo_Reason.Text]));
    exit;
  end;
end;

procedure THoldForm.rb_HoldClassClick(Sender: TObject);
begin
  chk_EffectRepair.Enabled:=Sender = rb_HoldClass1;
end;

procedure THoldForm.GetHoldList;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    FNMServerObj.GetBaseTableInfo(vData, 'fnHold', sErrorMsg);
    if sErrorMsg <> '' then
      raise Exception.Create(sErrorMsg);
      
    cdsHold.Data := vData;
    if cdsHold.IsEmpty then
      raise Exception.CreateRes(@EMP_HoldList);
                                                         
    FillListItemsFromDataSet(cdsHold, 'GF_ID', 'Iden',
      ['GF_NO', 'FN_Card', 'Operation_Code', 'Operation_Name', 'Hold_Reason', 'Is_EffectRepair', 'Holder', 'Hold_Time'], lv_HoldList.Items);
  finally

    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure THoldForm.TestGFKeyValueExist(GF_KeyValue: String);
var
  sErrorMsg: WideString;
  GF_ID, Art_ID: Integer;
begin
  FNMServerArtObj.GetCheckGFIDAndSTDArt(GF_KeyValue, login.CurrentDepartment, GF_ID, Art_ID, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetCheckGFIDAndSTDArt, [sErrorMsg]);

  //品名不存在
  if GF_ID = -1 then
    raise ExceptionEx.CreateResFmt(@INV_GFIDorGF_NO, [GF_KeyValue]);
end;

procedure THoldForm.edt_GFKeyValueChange(Sender: TObject);
begin
  cbb_Operation.Items.Clear;
end;

procedure THoldForm.cbb_OperationDropDown(Sender: TObject);
var
  Art_ID, GF_ID: Integer;
begin
  if cbb_Operation.Items.Count = 0 then
  begin
    if Trim(edt_GFKeyValue.Text) = '' then exit;

    GetStdArtIDbyGFNO(edt_GFKeyValue.Text, Login.CurrentDepartment, Art_ID, GF_ID);
    if Art_ID = -1 then
      raise Exception.CreateRes(@EMP_StdArtInfoDtlCantCopy);
    StdArt.OrgArt_ID:=Art_ID;
    StdArt.OpenFNSTDArt;

    StdArt.FillOperationToAListControls(cbb_Operation.Items);
    if cbb_Operation.Items.Count = 0 then
      raise Exception.CreateRes(@EMP_STDArt);
  end;
end;

function THoldForm.SaveHoldData: Boolean;
var
  sCondition,sErrorMsg:WideString;
  iden,i,Is_Hold, Is_EffectRepair: Integer;
  UnHoldIden,GFKeyValue, Reason, FN_Cards, Operation_Code,s: String;
begin
  result := False;
  UnHoldIden:= '';
  try
    ShowStatusMessage(@STA_SaveMessage, ['数据']);
    //UnHoldIden:=-1;

    //if lv_HoldList.Selected <> nil then
    //  UnHoldIden:=string(lv_HoldList.Selected.SubItems.Objects[0]);
    for i := 0 to lv_HoldList.Items.Count - 1 do
    begin
      if lv_HoldList.Items.Item[i].Checked then
      begin
        iden:= Integer(lv_HoldList.Items.Item[i].SubItems.Objects[0]);
        UnHoldIden := UnHoldIden + IntToStr(iden) + ',';
      end;
    end;

    Is_Hold:=ifthen(rb_NewHold.Checked, 1, 0);
    Is_EffectRepair:=ifthen(chk_EffectRepair.Checked, 1, 0);
    GFKeyValue:=edt_GFKeyValue.Text;
    Reason:=mmo_Reason.Text;
    FN_Cards:=GetCheckedItems;
    Operation_Code:='';
    if cbb_Operation.ItemIndex <> -1 then
      Operation_Code:=StdArt.GetStepOperateCode(cbb_Operation.ItemIndex + 1);

    sCondition := IntToStr(Is_Hold)+ ','+QuotedStr(UnHoldIden)+ ','+QuotedStr(GFKeyValue)+ ','+QuotedStr(Operation_Code)+ ','+QuotedStr(FN_Cards)+ ','+IntToStr(Is_EffectRepair)+ ','+QuotedStr(Reason)+','+QuotedStr(Login.LoginName);
    FNMServerObj.SaveDataBySQL('SaveHoldInfo',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      raise Exception.Create(sErrorMsg);
      exit;
    end;
    TMsgDialog.ShowMsgDialog('数据保存成功！',mtInformation);
    result := True;
    lv_CardList.clear;
  finally
    ShowStatusMessage(@STA_Ready, []);
  end;
end;

procedure THoldForm.FormShow(Sender: TObject);
begin
  pgc_Only.ActivePageIndex := 0;
  btn_Previou.Enabled:=false;
  btn_Next.Enabled:=true;
  btn_Exit.Caption:='取消(&C)';
  SelectPath:='';
  edt_GFKeyValue.Text:='';
  cbb_Operation.ItemIndex:=-1;
  lv_HoldList.Items.Clear;
  mmo_Reason.Lines.Clear;
  mmo_Result.Lines.Clear;
end;

procedure THoldForm.lv_HoldListColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  TGlobal.SortListView(lv_HoldList,Column);
end;

//2009-5-14 cuijf 快速查找定位
procedure THoldForm.edtFilterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:Integer;
begin
  if Key=13 then
  begin
    for i:=0 to lv_HoldList.Items.Count-1 do
    begin
      if lv_HoldList.Items[i].SubItems.IndexOf(edtFilter.Text)>-1 then
      begin
        lv_HoldList.Items[i].Selected := true;
        lv_HoldList.Items[i].MakeVisible(true);
        Break;
      end
    end;
  end;
end;

end.
