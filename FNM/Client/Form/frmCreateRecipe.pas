unit frmCreateRecipe;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmCreateRecipe.pas                                           }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 Lvzd                                                          }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  生成化料单                                                   }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons;

type
  TCreateRecipeForm = class(TForm)
    Panel1: TPanel;
    pgcType: TPageControl;
    ts2: TTabSheet;
    ts3: TTabSheet;
    btn_Query: TSpeedButton;
    edtBeginTimeSupply: TEdit;
    edtEndTimeSupply: TEdit;
    btnCancel: TButton;
    btn_OK: TButton;
    Memo1: TMemo;
    rbBase: TRadioButton;
    rbCard: TRadioButton;
    txt_Only: TStaticText;
    cbbOperationNew: TComboBox;
    cbbStdPrescriptionNew: TComboBox;
    cbbMachineIDNew: TComboBox;
    edtBaseVolumeNew: TEdit;
    StaticText1: TStaticText;
    cbbOperationSupply: TComboBox;
    cbbStdPrescriptionSupply: TComboBox;
    edtBaseVolumeSupply: TEdit;
    cbbMachineIDSupply: TComboBox;
    grp1: TGroupBox;
    chkAllSupply: TCheckBox;
    lvCardSupply: TListView;
    GroupBox1: TGroupBox;
    chkAllNew: TCheckBox;
    lvCardNew: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
//    procedure cbb_EnterAControl(Sender: TObject);
    procedure cbbOperationNewChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btn_QueryClick(Sender: TObject);
    procedure rbBaseClick(Sender: TObject);
    procedure rbCardClick(Sender: TObject);
    procedure cbbOperationSupplyChange(Sender: TObject);
    procedure cbbStdPrescriptionNewEnter(Sender: TObject);
    procedure cbbStdPrescriptionNewChange(Sender: TObject);
    procedure cbbMachineIDNewChange(Sender: TObject);
    procedure cbbMachineIDNewEnter(Sender: TObject);
    procedure cbbStdPrescriptionSupplyChange(Sender: TObject);
    procedure cbbMachineIDSupplyChange(Sender: TObject);
    procedure cbbMachineIDSupplyEnter(Sender: TObject);
    procedure cbbStdPrescriptionSupplyEnter(Sender: TObject);
    procedure chkAllNewClick(Sender: TObject);
    procedure chkAllSupplyClick(Sender: TObject);
    procedure pgcTypeChange(Sender: TObject);
    procedure lvCardNewCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvCardSupplyCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
  private
    { Private declarations }
    function CreateRecipeInfo: Boolean;
    {* 保存化料单}
    function GetCheckedCard(lv:TListView; iHold: Integer) : string;
    procedure CheckedLV(lv:TListView; iHold: Integer; bCheck: Boolean);
    {* 取选择的卡号}
    procedure GetRecipeCardInfo;

//     procedure GetOnLineCardByStdPrescription(StdPrescrip_NO, OperationCode: String);
    {* 获取指定配方在指定工序的卡号}
    protected
      procedure UpdateActions; override;
  public
    { Public declarations }
  end;

var
  CreateRecipeForm: TCreateRecipeForm;
  
procedure CreateANewRecipe;

implementation

uses Math, StrUtils, uDictionary, uFNMArtInfo, ServerDllPub, UFNMResource, UAppOption, uLogin;

{$R *.dfm}

procedure TCreateRecipeForm.UpdateActions;
begin
  btn_Query.Enabled := (cbbOperationSupply.Text <> '') and (cbbMachineIDSupply.Text <> '') and
                       (edtBeginTimeSupply.Text <> '') and (edtEndTimeSupply.Text <> '');
  if pgcType.ActivePageIndex = 0  then
  begin
    btn_OK.Enabled := (cbbOperationNew.Text <> '') and (cbbStdPrescriptionNew.Text <> '') and
                      (cbbMachineIDnew.Text <> '');
    rbCard.Enabled := btn_Ok.Enabled;
  end;  
  if pgcType.ActivePageIndex = 1  then
     btn_OK.Enabled := (cbbOperationSupply.Text <> '') and (cbbStdPrescriptionSupply.Text <> '') and
                      (cbbMachineIDSupply.Text <> '');
end;

procedure TCreateRecipeForm.GetRecipeCardInfo;
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
begin
  Screen.Cursor := crHourGlass;
  try
    if pgcType.ActivePageIndex = 0 then
      sCondition := QuotedStr(LeftStr(cbbOperationNew.Text,3)) + ','+ QuotedStr(cbbStdPrescriptionNew.Text) + ','+
                    QuotedStr(LeftStr(cbbMachineIDNew.Text, 4)) + ','+  QuotedStr('') + ','+
                    QuotedStr('') + ','+ QuotedStr(Login.CurrentDepartment) + ',0'
    else
      sCondition := QuotedStr(LeftStr(cbbOperationSupply.Text,3)) + ','+ QuotedStr(cbbStdPrescriptionSupply.Text) + ','+
                    QuotedStr(LeftStr(cbbMachineIDSupply.Text, 4)) + ','+  QuotedStr(edtBeginTimeSupply.Text) + ','+
                    QuotedStr(edtEndTimeSupply.Text) + ','+ QuotedStr(Login.CurrentDepartment) + ',1';
    FNMServerObj.GetQueryData(vData,'RCPGetRecipeCardInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
       raise ExceptionEx.CreateResFmt(@ERR_GetOnlineStdPrescripNO, [sErrorMsg]);

    TempClientDataSet.Data:=vData;
    if TempClientDataSet.IsEmpty then
      raise Exception.CreateRes(@EMP_OnLineCard);
    if pgcType.ActivePageIndex = 0 then
      FillListItemsFromDataSet(TempClientDataSet, 'FN_Card', '', ['GF_NO', 'Quantity','HOLD','White_Type','CAR_NO'], lvCardNew.Items);
    if pgcType.ActivePageIndex = 1 then
      FillListItemsFromDataSet(TempClientDataSet, 'Iden', '', ['FN_Card','Quantity', 'Begin_Time','HOLD'], lvCardSupply.Items);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TCreateRecipeForm.FormCreate(Sender: TObject);
begin
  btn_Query.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  edtBeginTimeSupply.Text:=DateTimeToStr(Now - 1);
  edtEndTimeSupply.Text:=DateTimeToStr(Now);
  SetWindowLong(edtBaseVolumeNew.Handle, GWL_STYLE, GetWindowLong(edtBaseVolumeSupply.Handle, GWL_STYLE) or ES_NUMBER);
  edtBaseVolumeNew.Text:='0';
  SetWindowLong(edtBaseVolumeSupply.Handle, GWL_STYLE, GetWindowLong(edtBaseVolumeSupply.Handle, GWL_STYLE) or ES_NUMBER);
  edtBaseVolumeSupply.Text:='0';
end;

procedure TCreateRecipeForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrOk then
    CreateRecipeInfo;

  Action:=caHide;
  
  edtBaseVolumeNew.Text:='0';
  cbbOperationNew.ItemIndex:=-1;
  cbbStdPrescriptionNew.ItemIndex:=-1;
  cbbMachineIDNew.ItemIndex:=-1;
  lvCardNew.Items.Clear;

  edtBaseVolumeSupply.Text:='0';
  cbbOperationSupply.ItemIndex:=-1;
  cbbStdPrescriptionSupply.ItemIndex:=-1;
  cbbMachineIDSupply.ItemIndex:=-1;
  lvCardSupply.Items.Clear;
end;

procedure TCreateRecipeForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  OnActivate:=nil;
  with Dictionary.cds_OperationDtlList do
  try
    Filter:='Item_Name Like ''%配方%'' or Item_Name = ''配方''';  //+' AND Use_Department LIKE ''%'+Login.CurrentDepartment + '%''';
    Filtered:=True;
    FillItemsFromDataSet(Dictionary.cds_OperationDtlList, 'Operation_Code', 'Operation_CHN', '', '->', cbbOperationNew.Items);
    cbbOperationSupply.Items := cbbOperationNew.Items;
  finally
    Filtered:=false;
  end;
end;

procedure TCreateRecipeForm.cbbOperationNewChange(Sender: TObject);
begin
  cbbStdPrescriptionNew.Items.Clear;
  cbbMachineIDNew.Items.Clear;
  lvCardNew.Items.Clear;
end;
{
procedure TCreateRecipeForm.cbb_EnterAControl(Sender: TObject);
var
  vData: OleVariant;
  sErrorMsg: WideString;
  OperationCode: string;
begin
  OperationCode := LeftStr(cbb_Operation.Text, 3);
  if OperationCode = '' then exit;
  //所有配方
  if pgcType.ActivePageIndex = 2 then
  begin
    if cbb_StdPrescription.Items.Count = 0 then
    with Dictionary.cds_StdPrescriptionHdrList do
    try
      Filter:=Format('Operation_Code = ''%s''', [OperationCode]);
      Filtered:=True;
      FillItemsFromDataSet(Dictionary.cds_StdPrescriptionHdrList, 'Prescrip_NO', '', '', '', cbb_StdPrescription.Items);
    finally
      Filtered:=False;
    end;
  end else  //  取选定工序的标准配方
  begin
   if cbb_StdPrescription.Items.Count = 0 then
    begin
      FNMServerArtObj.GetOnlineStdPrescripNO(OperationCode, Login.CurrentDepartment, vData, sErrorMsg);
      if sErrorMsg <> '' then
        raise ExceptionEx.CreateResFmt(@ERR_GetOnlineStdPrescripNO, [sErrorMsg]);
      cbb_StdPrescription.Items.Text:=StringReplace(vData, '/', #13, [rfReplaceAll]);
    end;
  end;
  //加载机台
  if cbb_MachineID.Items.Count = 0 then
    FillMachineListByOperationCode(Login.CurrentDepartment, OperationCode, cbb_MachineID.Items);
end;
}
procedure CreateANewRecipe;
begin
  if CreateRecipeForm = nil then
    CreateRecipeForm:=TCreateRecipeForm.Create(Application);
  CreateRecipeForm.ShowModal;
end;

function TCreateRecipeForm.GetCheckedCard(lv:TListView; iHold: Integer) : string;
var
  i: Integer;
begin
  result:='';
  with lv.Items do
  for i := 0 to Count - 1 do
  begin
    if Item[i].Checked and (Item[i].SubItems[iHold] = '0') then
      result := result + Item[i].Caption + ',';
  end;
end;

procedure TCreateRecipeForm.CheckedLV(lv:TListView; iHold: Integer; bCheck: Boolean);
var
  i: Integer;
begin
  with lv.Items do
    for i := 0 to Count - 1 do
      if Item[i].SubItems[iHold] = '1' then
        Item[i].Checked := False
      else
        Item[i].Checked := bCheck;
end;

function TCreateRecipeForm.CreateRecipeInfo: Boolean;
var
  iType : Integer;
  sCondition,sErrorMsg: WideString;
  OperationCode,StdPrescription,MachineID, KeywordStr, BaseVolume: string;
begin
  Result := False;
  iType := 0;
  if pgcType.ActivePageIndex = 0 then
  begin
    OperationCode := LeftStr(cbbOperationNew.Text, 3);
    StdPrescription:= cbbStdPrescriptionNew.Text;
    MachineID := LeftStr(cbbMachineIDNew.Text, 4);
    BaseVolume := ifthen(edtBaseVolumeNew.Text = '', '0', edtBaseVolumeNew.Text);
    KeywordStr := '';
    if rbCard.Checked then
    begin
      iType := 1;
      KeywordStr := GetCheckedCard(lvCardNew,2);
      if KeywordStr = '' then Exit;
    end;
  end;
  if pgcType.ActivePageIndex = 1 then
  begin
    OperationCode := LeftStr(cbbOperationSupply.Text, 3);
    StdPrescription:= cbbStdPrescriptionSupply.Text;
    MachineID := LeftStr(cbbMachineIDSupply.Text, 4);
    BaseVolume := ifthen(edtBaseVolumeSupply.Text = '', '0', edtBaseVolumeSupply.Text);

    iType := 2;
    KeywordStr := GetCheckedCard(lvCardSupply,3);
    if KeywordStr = '' then Exit;
  end;
  if (OperationCode = '') or (MachineID = '') then Exit;
  sCondition := QuotedStr(StdPrescription) + ','+ QuotedStr(KeywordStr) + ','+
                QuotedStr(OperationCode) + ','+ QuotedStr(MachineID) + ','+
                QuotedStr(BaseVolume) + ','+ QuotedStr(Login.CurrentDepartment) +','+
                QuotedStr(Login.LoginName) +',' + IntToStr(iType);

  FNMServerObj.SaveDataBySQL('RCPCreateRecipeInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveRecipe, [sErrorMsg]);

  result := True;
end;

procedure TCreateRecipeForm.cbbStdPrescriptionNewChange(Sender: TObject);
begin
  lvCardNew.Items.Clear;
end;

procedure TCreateRecipeForm.cbbStdPrescriptionNewEnter(Sender: TObject);
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  if (cbbOperationNew.Text) = '' then exit;
  if cbbStdPrescriptionNew.Items.Count = 0 then
  begin
    FNMServerArtObj.GetOnlineStdPrescripNO(LeftStr(cbbOperationNew.Text, 3), Login.CurrentDepartment, vData, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_GetOnlineStdPrescripNO, [sErrorMsg]);
    cbbStdPrescriptionNew.Items.Text:=StringReplace(vData, '/', #13, [rfReplaceAll]);
  end;
end;

procedure TCreateRecipeForm.cbbMachineIDNewChange(Sender: TObject);
begin
  lvCardNew.Items.Clear;
end;

procedure TCreateRecipeForm.cbbMachineIDNewEnter(Sender: TObject);
begin
  if cbbOperationNew.Text = '' then exit;
  if cbbMachineIDNew.Items.Count = 0 then
    FillMachineListByOperationCode(Login.CurrentDepartment, LeftStr(cbbOperationNew.Text, 3), cbbMachineIDNew.Items);
end;

procedure TCreateRecipeForm.btn_QueryClick(Sender: TObject);
begin
  GetRecipeCardInfo;
end;

procedure TCreateRecipeForm.rbBaseClick(Sender: TObject);
begin
  Memo1.BringToFront;
end;

procedure TCreateRecipeForm.rbCardClick(Sender: TObject);
begin
  Memo1.SendToBack;
  GetRecipeCardInfo;
end;     

procedure TCreateRecipeForm.cbbOperationSupplyChange(Sender: TObject);
begin
  cbbStdPrescriptionSupply.Items.Clear;
  cbbMachineIDSupply.Items.Clear;
  lvCardSupply.Items.Clear;
end;

procedure TCreateRecipeForm.cbbStdPrescriptionSupplyChange(Sender: TObject);
begin
  lvCardSupply.Items.Clear;
end;

procedure TCreateRecipeForm.cbbStdPrescriptionSupplyEnter(Sender: TObject);
begin
  if cbbStdPrescriptionSupply.Items.Count = 0 then
  with Dictionary.cds_StdPrescriptionHdrList do
  try
    Filter:=Format('Operation_Code = ''%s''', [LeftStr(cbbOperationSupply.Text, 3)]);
    Filtered:=True;
    FillItemsFromDataSet(Dictionary.cds_StdPrescriptionHdrList, 'Prescrip_NO', '', '', '', cbbStdPrescriptionSupply.Items);
  finally
    Filtered:=False;
  end;
end;

procedure TCreateRecipeForm.cbbMachineIDSupplyChange(Sender: TObject);
begin
  lvCardSupply.Items.Clear;
end;

procedure TCreateRecipeForm.cbbMachineIDSupplyEnter(Sender: TObject);
begin
 if cbbOperationSupply.Text = '' then exit;
  if cbbMachineIDSupply.Items.Count = 0 then
    FillMachineListByOperationCode(Login.CurrentDepartment, LeftStr(cbbOperationSupply.Text, 3), cbbMachineIDSupply.Items);
end;

procedure TCreateRecipeForm.chkAllNewClick(Sender: TObject);
begin
  CheckedLV(lvCardNew,2,chkAllNew.Checked);
end;

procedure TCreateRecipeForm.chkAllSupplyClick(Sender: TObject);
begin
  CheckedLV(lvCardSupply,3,chkAllSupply.Checked);
end;

procedure TCreateRecipeForm.pgcTypeChange(Sender: TObject);
begin
  edtBaseVolumeNew.Text:='0';
  cbbOperationNew.ItemIndex:=-1;
  cbbStdPrescriptionNew.ItemIndex:=-1;
  cbbMachineIDNew.ItemIndex:=-1;
  lvCardNew.Items.Clear;

  edtBaseVolumeSupply.Text:='0';
  cbbOperationSupply.ItemIndex:=-1;
  cbbStdPrescriptionSupply.ItemIndex:=-1;
  cbbMachineIDSupply.ItemIndex:=-1;
  lvCardSupply.Items.Clear;
end;

procedure TCreateRecipeForm.lvCardNewCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  if Item.SubItems[2] = '1' then
    lvCardNew.Canvas.Font.Color := clRed;
end;

procedure TCreateRecipeForm.lvCardSupplyCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  if Item.SubItems[3] = '1' then
    lvCardSupply.Canvas.Font.Color := clRed;
end;

end.
