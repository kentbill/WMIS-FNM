unit frmCreateSample;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmCreateSample.pas                                           }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 Lvzd                                                          }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  生成取样单号                                                 }
{                                                                              }
{******************************************************************************}

interface

uses
  StrUtils, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TCreateSampleForm = class(TForm)
    rb_UseStdSampleNO: TRadioButton;
    rb_UserDefindSample: TRadioButton;
    pnl_Only: TPanel;
    txt_Only: TStaticText;
    bvl_Only: TBevel;
    lv_TestItems: TListView;
    tv_StdSampleNO: TTreeView;
    btn_Help: TButton;
    btn_Cancel: TButton;
    btn_OK: TButton;
    procedure rb_UseStdSampleNOClick(Sender: TObject);
    procedure tv_StdSampleNOEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function SaveUserDefindSample: Boolean;
  end;

function GetSampleNo(OldSampleNO: string): String;

implementation

uses uFNMArtInfo, uDictionary, uFNMResource, ulogin, ServerDllPub;

var
  SampleNO: String;
  CreateSampleForm: TCreateSampleForm;
{$R *.dfm}

function GetSampleNo(OldSampleNO: string): String;
begin
  SampleNO:=OldSampleNO;

  if CreateSampleForm = nil then
    CreateSampleForm:= TCreateSampleForm.Create(nil);

  if not CreateSampleForm.Showing then
    CreateSampleForm.ShowModal;
  result:=SampleNO;
end;

procedure TCreateSampleForm.rb_UseStdSampleNOClick(Sender: TObject);
begin
  if Sender =  rb_UseStdSampleNO then
    tv_StdSampleNO.SetFocus;

  if Sender =  rb_UserDefindSample then
    lv_TestItems.SetFocus;
end;

procedure TCreateSampleForm.tv_StdSampleNOEnter(Sender: TObject);
begin
  if Sender =  tv_StdSampleNO then
    rb_UseStdSampleNO.Checked:=true;
    
  if Sender =  lv_TestItems then
    rb_UserDefindSample.Checked:=true;
end;

procedure TCreateSampleForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOK then
  begin
    if rb_UseStdSampleNO.Checked then
    begin
      if tv_StdSampleNO.Selected = nil then
      begin
        ShowMsgDialog(@INV_NOSelectSTDSampleNO, mtWarning);
        Action:=caNone;
        exit;
      end;

      if tv_StdSampleNO.Selected.Level = 0 then
        SampleNO:=tv_StdSampleNO.Selected.Text
      else
        SampleNO:=tv_StdSampleNO.Selected.Parent.Text;
    end;

    if rb_UserDefindSample.Checked then
    begin
      if not SaveUserDefindSample then
      begin
        Action:=caNone;
        exit;
      end;
    end;
  end;
end;

procedure TCreateSampleForm.FormActivate(Sender: TObject);
begin
  //Load Std Sample NO List
  FillTreeItemsFromDataSetByClassField(Dictionary.cds_SampleItemList, 'Sample_Name', 'Sample_Code', '', '', tv_StdSampleNO.Items);
  tv_StdSampleNO.FullExpand;
  if tv_StdSampleNO.Items.Count > 0 then
  begin
    tv_StdSampleNO.Selected:=tv_StdSampleNO.Items.Item[0];
    tv_StdSampleNO.Selected.MakeVisible;
  end;

  //Load Test Item
  FillListItemsFromDataSet(Dictionary.cds_TestItems, 'Item', 'Item_ID', ['Description'], lv_TestItems.Items);
  OnActivate:=nil;
end;

procedure TCreateSampleForm.FormShow(Sender: TObject);
var
  i: Integer;
  vData: OleVariant;
  NewNode: TTreeNode;
  sErrorMsg: WideString;
begin
  //重置选择状态
  for i := 0 to lv_TestItems.Items.Count - 1 do
    lv_TestItems.Items.Item[i].Checked:=false;

  if SampleNO <> '' then
  with CreateSampleForm.tv_StdSampleNO.Items do
  begin
    for i := 0 to Count - 1 do
    begin
      if SampleNO = Item[i].Text then
      begin
        Owner.Selected:=Item[i];
        Owner.Selected.Expand(false);
        break;
      end;
    end;

    if (Owner.Selected = nil) or (SampleNO <> Owner.Selected.Text) then
    begin
      FNMServerObj.GetSamplelist('', SampleNO, vData, sErrorMsg);
      if sErrorMsg <> '' then
        raise ExceptionEx.CreateResFmt(@GetDictionaryListError, [DictionaryName[13] + sErrorMsg]);

      TempClientDataSet.Data:=vData;
      if TempClientDataSet.IsEmpty then
        raise ExceptionEx.CreateResFmt(@GetDictionaryListError, [DictionaryName[13] + sErrorMsg]);

      NewNode:=Insert(nil, SampleNO);
      for i := 0 to TempClientDataSet.RecordCount - 1 do
      begin
        AddChild(NewNode, TempClientDataSet['Sample_Name']);
        TempClientDataSet.Next;
      end;
    end;
  end;
  tv_StdSampleNO.SetFocus;
end;

function TCreateSampleForm.SaveUserDefindSample: Boolean;
var
  i: Integer;
  TestItems: String;
  sErrorMsg, NewSampleNO: WideString;
begin
  result := False;
  with lv_TestItems.Items do
  for i := 0 to Count - 1 do
  begin
    if Item[i].Checked then
      TestItems:=TestItems + Item[i].SubItems.Strings[0] + ',';
  end;

  if TestItems = '' then
  begin
    ShowMsgDialog(@INV_NOSelectTestItem, mtWarning);
    exit;
  end;
    
  //保存数据
  FNMServerArtObj.SaveUserDefindSample(TestItems, login.LoginName, NewSampleNO, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveUserDefindSample, [sErrorMsg]);
  SampleNO:=NewSampleNO;
  
  result:=true;
end;

initialization
  CreateSampleForm:=nil;

finalization
  if CreateSampleForm <> nil then
    CreateSampleForm.Destroy;
    
end.
