unit frmManageSample;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmManageSample.pas                                           }
{       创建日期 2005-12-14 11:10:57                                           }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述 更该品名                                                      }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls,cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxControls, cxContainer, cxTextEdit,
  cxMaskEdit, cxButtonEdit, Buttons, ExtCtrls, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBClient, ComCtrls ,StrUtils, CheckLst,
  cxSplitter;

type
  TManageSampleForm = class(TBaseForm)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet1: TTabSheet;
    pnl1: TPanel;
    btnQuery: TSpeedButton;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    lblFabricNO: TLabel;
    btnAdd: TSpeedButton;
    lblOperationCode: TLabel;
    lblActSampleQty: TLabel;
    lblSampleCode: TLabel;
    lblFNCard: TLabel;
    cbbFabricNOList: TComboBox;
    cbbOperationCodeList: TComboBox;
    edtActSampleQty: TEdit;
    edtFNCard: TEdit;
    cxbeSampleCode: TcxButtonEdit;
    lvSampleInfo: TListView;
    grp4: TGroupBox;
    lvSrc: TListView;
    pnl2: TPanel;
    btnSelect: TSpeedButton;
    btnDelete: TSpeedButton;
    grp3: TGroupBox;
    clbItemList: TCheckListBox;
    btn_Save: TSpeedButton;
    btn_Exit: TSpeedButton;
    btnRefresh: TSpeedButton;
    lvDes: TListView;
    gbRight: TGroupBox;
    cxSpResult: TcxSplitter;
    lvResult: TListView;
    cxSplitter1: TcxSplitter;
    cbRemark: TComboBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure cxbeSampleCodePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxbeSampleCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure lvSrcClick(Sender: TObject);
    procedure lvSrcCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
  private
    { Private declarations }
    FNCard:string;
    GF_ID: string;
    Job_NO: string;
    procedure Add();
    procedure SaveSampleInfo();
  protected
    procedure UpdateActions;override;
  public
    { Public declarations }
  end;

var
  ManageSampleForm: TManageSampleForm;

implementation

uses ServerDllPub, uGlobal, frmMain, uShowMessage, uLogin, uGridDecorator,
  uAppOption, uDictionary,frmCreateSample, uFNMResource;
{$R *.dfm}

procedure TManageSampleForm.FormCreate(Sender: TObject);
begin
  inherited;
  cxbeSampleCode.Properties.Buttons.Items[0].Glyph.LoadFromResourceName(HInstance, RES_QUERYSMALL);
  btnQuery.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnAdd.Glyph.LoadFromResourceName(HInstance, RES_NEW);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Save.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btnSelect.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnDelete.Glyph.LoadFromResourceName(HInstance, RES_DELETE);

  cxSpResult.CloseSplitter;
end;

procedure TManageSampleForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TManageSampleForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ManageSampleForm := nil;
end;

procedure TManageSampleForm.Add;
var i,j: Integer;
    sFabricNO,sStepNO,sOperationCode,sMachineID,sSampleCode,sActSampleQty: string;
begin
  sFabricNO := Trim(cbbFabricNOList.Text);
  j := Pos('->', cbbOperationCodeList.Text);
  sStepNO := LeftStr(cbbOperationCodeList.Text,j-1);
  sOperationCode := Trim(MidStr(cbbOperationCodeList.Text,j+2,3));
  sMachineID := MidStr(cbbOperationCodeList.Text,Pos(')', cbbOperationCodeList.Text)+1,4);
  sSampleCode :=Trim(cxbeSampleCode.Text);
  sActSampleQty := Trim(edtActSampleQty.Text);
  if sSampleCode ='' then
  begin
    TMsgDialog.ShowMsgDialog('取样代码不能为空!',mtWarning);
    cxbeSampleCode.SetFocus;
    Exit;
  end;
  if StrToFloat(sActSampleQty) <= 0.0 then
  begin
    TMsgDialog.ShowMsgDialog('取样码长不能为0!',mtWarning);
    Exit;
  end;
  
  for i := 0 to lvSampleInfo.Items.Count - 1 do
  begin
    if (sFabricNO = lvSampleInfo.Items[i].SubItems[0])
      and (sStepNO = lvSampleInfo.Items[i].SubItems[1])
      and (sSampleCode = lvSampleInfo.Items[i].SubItems[3]) then
    begin
      TMsgDialog.ShowMsgDialog('不能重复取样!',mtWarning);
      Exit;
    end;
  end;

  with lvSampleInfo.Items.Add do
  begin
    Caption:=FNCard;
    SubItems.Add(sFabricNO);
    SubItems.Add(sStepNO);
    SubItems.Add(sOperationCode);
    SubItems.Add(sMachineID);
    SubItems.Add(sSampleCode);
    SubItems.Add(sActSampleQty);
    SubItems.Add(GF_ID);
    SubItems.Add(Job_NO);
  end;
end;

procedure TManageSampleForm.SaveSampleInfo;
var
  vData : OleVariant;
  sFabricNO,sStepNO,sOperationCode,sMachineID,sGFID,sJobNO,sSampleCode,sActSampleQty: WideString;
  sErrorMsg: WideString;
  i: Integer;
begin
  try
    if lvSampleInfo.Items.Count = 0 then Exit;
    vData := VarArrayCreate([0,lvSampleInfo.Items.Count - 1], VarVariant);
    for i := 0 to lvSampleInfo.Items.Count - 1 do
    begin
      sFabricNO := lvSampleInfo.Items[i].SubItems[0];
      sStepNO := lvSampleInfo.Items[i].SubItems[1];
      sOperationCode := LeftStr(lvSampleInfo.Items[i].SubItems[2],3);
      sMachineID := lvSampleInfo.Items[i].SubItems[3];
      sSampleCode := lvSampleInfo.Items[i].SubItems[4];
      sActSampleQty := lvSampleInfo.Items[i].SubItems[5];
      sGFID := lvSampleInfo.Items[i].SubItems[6];
      sJobNO := lvSampleInfo.Items[i].SubItems[7];
      vData[i]:=VarArrayOf([sGFID,sJobNO,sFabricNO,sStepNO,sOperationCode,sMachineID,sSampleCode,
                            sActSampleQty,Login.LoginID,Login.CurrentDepartment]);
      end;
    FNMServerObj.SaveSampleInfo(vData,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    lvSampleInfo.Items.Clear;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TManageSampleForm.btnAddClick(Sender: TObject);
begin
  inherited;
  Add;
end;

procedure TManageSampleForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveSampleInfo;
end;

procedure TManageSampleForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TManageSampleForm.btnQueryClick(Sender: TObject);
var
  vData : OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  FNCard:=edtFNCard.Text;
  if FNCard='' then Exit;
  if FNCard[1] = 'N' then Exit;//raise Exception.Create('WAR_手织板不能取样!');
  sCondition := QuotedStr(FNCard)+','+QuotedStr(Login.CurrentDepartment)+',1';
  FNMServerObj.GetQueryData(vData,'GetSampleInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;
  TempClientDataSet.Data := vData;
  GF_ID := TempClientDataSet.FieldByName('GF_ID').AsString;
  Job_NO := TempClientDataSet.FieldByName('Job_NO').AsString;
  cbbFabricNOList.Items.Text := TempClientDataSet.FieldByName('FabricNOList').AsString;
  cbbOperationCodeList.Items.Text := TempClientDataSet.FieldByName('OperationList').AsString;
  if cbbFabricNOList.Items.Count > 0 then
   cbbFabricNOList.ItemIndex := 0;
  if cbbOperationCodeList.Items.Count > 0 then
   cbbOperationCodeList.ItemIndex := 0
end;

procedure TManageSampleForm.cxbeSampleCodePropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
   cxbeSampleCode.Text := GetSampleNo(cxbeSampleCode.Text);
end;

procedure TManageSampleForm.cxbeSampleCodeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
    cxbeSampleCode.Properties.OnButtonClick(cxbeSampleCode,0);
end;

procedure TManageSampleForm.UpdateActions;
var i: Integer;
   Sel: Boolean;
begin
  Sel := False;
  for i:= 0 to clbItemList.Items.Count -1 do
    if  clbItemList.Checked[i] then
    begin
      Sel := True;
      break;
    end;
  btnSelect.Enabled := (lvSrc.Selected <> nil) and (lvSrc.Selected.SubItems[5] <> '0') and Sel;
  btnDelete.Enabled := lvDes.Selected <> nil;
  btn_Save.Enabled := lvDes.Items.Count > 0;
end;

procedure TManageSampleForm.btnRefreshClick(Sender: TObject);
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  inherited;
  sCondition := QuotedStr('')+','+ QuotedStr(Login.CurrentDepartment)+',2';
  FNMServerObj.GetQueryData(vData,'GetSampleInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TempClientDataSet.Data := vData;
  TGlobal.FillItemsFromDataSet(TempClientDataSet,['Fabric_NO','Operation_CHN','Customer','GF_NO','Sample_Code','Sample_Name','PTM_ID','Con_ID'],lvSrc.Items);
  clbItemList.Clear;
  lvResult.Items.Clear;
  cxSpResult.CloseSplitter;
end;

procedure TManageSampleForm.btnSelectClick(Sender: TObject);
var
  SampleItem: string;
  i: Integer;
begin
  inherited;
  SampleItem := '';
  for i := 0 to clbItemList.Items.Count - 1 do
    if clbItemList.Checked[i] then
      SampleItem:=SampleItem + clbItemList.Items[i] + ',';

  with lvDes.Items.Add do
  begin
    Caption:= lvSrc.Selected.Caption;
    SubItems.Add(lvSrc.Selected.SubItems[0]);
    SubItems.Add(lvSrc.Selected.SubItems[1]);
    SubItems.Add(lvSrc.Selected.SubItems[2]);
    SubItems.Add(SampleItem);
    SubItems.Add(cbRemark.Text);
    SubItems.Add(lvSrc.Selected.SubItems[5]);
    SubItems.Add(lvSrc.Selected.SubItems[6]);
  end;
end;

procedure TManageSampleForm.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if lvDes.Selected <> nil then
   lvDes.Selected.Delete;
end;

procedure TManageSampleForm.btn_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TManageSampleForm.btn_SaveClick(Sender: TObject);
var
  vData: OleVariant;
  sPTMIDList,sConIDList,sFabricNOList,sSampleItemList,sRemarkList,sCondition,sErrorMsg: WideString;
  i: Integer;
begin
  inherited;
  if lvDes.Items.Count = 0 then Exit;
  sPTMIDList := '';
  sConIDList := '';
  sFabricNOList := '';
  sSampleItemList := '';
  sRemarkList := '';
  for i :=0 to lvDes.Items.Count -1 do
  begin
    sFabricNOList := sFabricNOList + lvDes.Items[i].Caption+'+';
    sSampleItemList := sSampleItemList + lvDes.Items[i].SubItems[3]+'+';
    sRemarkList := sRemarkList + lvDes.Items[i].SubItems[4]+'+';
    sPTMIDList := sPTMIDList + lvDes.Items[i].SubItems[5]+'+';
    sConIDList := sConIDList + lvDes.Items[i].SubItems[6]+'+';
  end;
  sCondition := QuotedStr(sPTMIDList)+','+QuotedStr(sConIDList)+','+QuotedStr(sFabricNOList)+','+
                QuotedStr(sSampleItemList)+','+ QuotedStr(sRemarkList)+','+
                QuotedStr(Login.CurrentDepartment)+','+QuotedStr(Login.LoginName);
  FNMServerObj.SaveDataBySQL('SaveSampleToPTM',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  sCondition := QuotedStr(sFabricNOList)+','+ QuotedStr(Login.CurrentDepartment)+',3';
  FNMServerObj.GetQueryData(vData,'GetSampleInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TempClientDataSet.Data := vData;
  TGlobal.FillItemsFromDataSet(TempClientDataSet,['Fabric_NO','Test_NO'],lvResult.Items);
  cxSpResult.OpenSplitter;
end;

procedure TManageSampleForm.lvSrcClick(Sender: TObject);
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  inherited;
  clbItemList.Clear;
  if lvSrc.Selected = nil then Exit;
  sCondition := QuotedStr(lvSrc.Selected.SubItems[3]+','+lvSrc.Selected.SubItems[5])+','+ QuotedStr(Login.CurrentDepartment)+',4';
  FNMServerObj.GetQueryData(vData,'GetSampleInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TempClientDataSet.Data := vData;
  with TempClientDataSet do
  begin
    First;
    while not Eof do
    begin
      clbItemList.Items.Add(FieldByName('Sample_Item').AsString);
      clbItemList.Checked[clbItemList.Items.Count-1] := FieldByName('Is_Checked').AsString = '1';
      Next;
    end;
  end;
  cbRemark.Text:= lvSrc.Selected.SubItems[0];
end;

procedure TManageSampleForm.lvSrcCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  inherited;
  if Item.SubItems[0] = '0' then
    Sender.Canvas.Brush.Color := clSilver;
end;

end.
