unit frmSample;
{*|<PRE>*****************************************************************************
                                                                             
       软件名称 FNM CLIENT MODEL                                               
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT
       单元名称 frmSample.pas                                                  
       创建日期 2004-9-18 11:17:08                                             
       创建人员 lvzd
       修改人员                                                                
       修改日期
       修改原因                                                                
       对应用例                                                                
       字段描述
       相关数据库表                                                            
       调用重要函数/SQL对象说明                                                
       功能描述 取样测试窗体单元                                                               
                                                                              
******************************************************************************}

interface

uses
  Windows, Messages, Classes, Controls, Forms, Buttons, ComCtrls,
  StdCtrls, ExtCtrls, Grids, ValEdit, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DB, DBClient, cxSplitter, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  cxDBData;

type
  TSampleForm = class(TForm)
    pnl_Only: TPanel;
    cxspl1: TcxSplitter;
    cds_SampleInfo: TClientDataSet;
    ds_SampleInfo: TDataSource;
    cds_Samplist: TClientDataSet;
    btn_Add: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn3: TSpeedButton;
    btn_Save: TSpeedButton;
    btn_Exit: TSpeedButton;
    lv_ReceivSample: TListView;
    cxgrid_SampleInfo: TcxGrid;
    cxgridtv_SampleInfo: TcxGridDBTableView;
    cxGridl_SampleInfo: TcxGridLevel;
    spl_Only: TSplitter;
    Vle_SampleList: TValueListEditor;
    grp_Only: TGroupBox;
    btn_Refresh: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure cds_SampleInfoAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure ClickAButton(Sender: TObject);
    procedure btn_ShowArtClick(Sender: TObject);
    procedure lv_ReceivSampleSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure KeyDownAControl(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetSamplelist(Sample_Code: String);
    procedure RefreshSample;
    {* 刷新取样数据}
    procedure GetSampleItemInfo(Sample_Code: String);
    procedure SaveReceiveSample;
  end;

var
  SampleForm: TSampleForm;

implementation

uses SysUtils, uShowMessage, ServerDllPub, uFNMResource, uDictionary, uFNMArtInfo,
     uLogin, UGridDecorator;

{$R *.dfm}

procedure TSampleForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TSampleForm.FormDestroy(Sender: TObject);
begin
  SampleForm:=nil;
end;

procedure TSampleForm.FormCreate(Sender: TObject);
begin
  btn_Add.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btn_Save.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Delete.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btn_Refresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);

  btn_Add.Enabled:=false;
  btn_Delete.Enabled:=false;
  btn_Save.Enabled:=false;
end;

procedure TSampleForm.RefreshSample;
var
  sErrorMsg: WideString;
  vData: OleVariant;
begin
  //保存数据
  //查询指定日期已经取样的数据
  try
    cds_SampleInfo.DisableControls;
    FNMServerArtObj.GetSampleInfo(vData,'',sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_GetSampleInfo, [sErrorMsg]);

    cds_SampleInfo.Data:=vData;
    if cds_SampleInfo.IsEmpty then
      raise Exception.CreateRes(@EMP_SampleInfo);

    GridDecorator.BindCxViewWithDataSource(cxgridtv_SampleInfo, ds_SampleInfo);
    btn_Add.Enabled:=cxgridtv_SampleInfo.DataController.DataSet.RecordCount > 0;
  finally
    cds_SampleInfo.EnableControls
  end;    
end;

procedure TSampleForm.cds_SampleInfoAfterScroll(DataSet: TDataSet);
begin
  if DataSet.ControlsDisabled then exit;
  
  GetSampleItemInfo(DataSet.FieldByName('Sample_Code').AsString);
end;

procedure TSampleForm.lv_ReceivSampleSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if (Item = nil) or (not Selected) then exit;

  GetSampleItemInfo(Item.SubItems.Strings[5]);
end;

procedure TSampleForm.GetSampleItemInfo(Sample_Code: String);
begin
  //取取样信息
  with Dictionary.cds_SampleItemList do
  begin
    try
      Filter:= Format('Sample_Code = ''%s''', [Sample_Code]);
      Filtered:=true;

      if RecordCount > 0 then
        FillItemsFromDataSet(Dictionary.cds_SampleItemList, 'Sample_Name', 'Sample_QTY', '', '=', Vle_SampleList.Strings)//直接从字典中取
      else
        GetSamplelist(Sample_Code);//从数据库中取
    finally
      Filtered:=false;
    end;
  end
end;

procedure TSampleForm.GetSamplelist(Sample_Code: String);
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  FNMServerObj.GetSamplelist('', Sample_Code, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@GetDictionaryListError, [DictionaryName[13] + sErrorMsg]);

  cds_Samplist.Data:=vData;
  if cds_Samplist.IsEmpty then
    raise ExceptionEx.CreateResFmt(@GetDictionaryListError, [DictionaryName[13] + sErrorMsg]);

  FillItemsFromDataSet(cds_Samplist, 'Sample_Name', 'Sample_QTY', '', '=', Vle_SampleList.Strings);
end;

procedure TSampleForm.ClickAButton(Sender: TObject);
var
  i: Integer;
begin
  if Sender = btn_Delete then
    lv_ReceivSample.DeleteSelected;

  if Sender = btn_Add then
  with cxgridtv_SampleInfo do
  for i := 0 to Controller.SelectedRowCount - 1 do
  begin
    AddItemToListItems(Controller.SelectedRows[i].Values[GetColumnByFieldName('Iden').Index], [
                       Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_ID').Index],
                       Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_NO').Index],
                       Controller.SelectedRows[i].Values[GetColumnByFieldName('FNCard').Index],
                       Controller.SelectedRows[i].Values[GetColumnByFieldName('Fabric_no').Index],
                       Controller.SelectedRows[i].Values[GetColumnByFieldName('Operation_Code').Index],
                       Controller.SelectedRows[i].Values[GetColumnByFieldName('Sample_Code').Index],
                       Controller.SelectedRows[i].Values[GetColumnByFieldName('Actual_Sample_QTY').Index]], lv_ReceivSample.Items);
  end;

  if Sender = btn_Refresh then
    RefreshSample;

  if Sender = btn_Save then
    SaveReceiveSample;
    
  btn_Save.Enabled:=lv_ReceivSample.Items.Count > 0;
  btn_Delete.Enabled:=lv_ReceivSample.Items.Count > 0;
end;

procedure TSampleForm.SaveReceiveSample;
var
  i: Integer;
  IdenList: string;
  sErrorMsg: WideString;
begin
  if lv_ReceivSample.Items.Count = 0 then exit;

  IdenList:='(';
  for i := 0 to lv_ReceivSample.Items.Count - 1 do
    IdenList:= IdenList + Format('''%s'', ', [lv_ReceivSample.Items.Item[i].Caption]);
  IdenList[length(IdenList) - 1]:=')';

  FNMServerArtObj.SaveReceiveSample(IdenList, Login.LoginName, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveReceiveSample, [sErrorMsg]);

  lv_ReceivSample.Items.Clear;
end;

procedure TSampleForm.btn_ShowArtClick(Sender: TObject);
begin
  btn_Save.Enabled:=true;
end;

procedure TSampleForm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TSampleForm.KeyDownAControl(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Sender = Self then
  case Key of
    VK_F5: btn_Refresh.Click;
  end;
end;

procedure TSampleForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  //刷新界面数据
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
  OnActivate:=nil;
end;

end.
