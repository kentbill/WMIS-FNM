unit frmArtReview;
{*|<PRE>*****************************************************************************
                                                                             
       软件名称 FNM CLIENT MODEL                                               
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT
       单元名称 frmArtReview.pas                                               
       创建日期 2004-9-6 10:17:31                                              
       创建人员 lvzd
       修改人员
       修改日期                                                                
       修改原因
       对应用例                                                                
       字段描述
       相关数据库表
       调用重要函数/SQL对象说明                                                
       功能描述 工艺回顾数据录入单元
                                                                              
******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, cxDBData;

type
  TArtReviewForm = class(TForm)
    btn_Exit: TSpeedButton;
    btn_GetSendCardList: TSpeedButton;
    btn_Help: TSpeedButton;
    btn_InputArtReview: TSpeedButton;
    btn_SaveArtReview: TSpeedButton;
    cds_FactArtDtl: TClientDataSet;
    ds_FactArtDtl: TDataSource;
    dtp_SelectDate: TDateTimePicker;
    edt_SelectCard: TEdit;
    lv_CardList: TListView;
    pnl_Only: TPanel;
    spl1: TSplitter;
    txt_Only: TStaticText;
    cxgrid_FactArtDtl: TcxGrid;
    cxgridtv_FactArtDtl: TcxGridDBTableView;
    cxGridl_FactArtDtl: TcxGridLevel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn_GetSendCardListClick(Sender: TObject);
    procedure btn_SaveArtReviewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cds_ArtReviewListAfterEdit(DataSet: TDataSet);
    procedure lv_CardListChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lv_CardListDblClick(Sender: TObject);
    procedure btn_InputArtReviewClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure cds_FactArtDtlAfterEdit(DataSet: TDataSet);
    procedure cxgridtv_FactArtDtlKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_SelectCardKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure GetArtReview(FN_Card:string);
    procedure SaveArtReview;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ArtReviewForm: TArtReviewForm;

implementation

uses ServerDllPub, UFNMResource, uFNMArtInfo, uLogin, DateUtils, uShowMessage,
     uDictionary, uGridDecorator;

{$R *.dfm}

procedure TArtReviewForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  MessResult: Integer;
begin
  Action:=caNone;

  if cds_FactArtDtl.Active and cds_FactArtDtl.LogChanges and btn_SaveArtReview.Enabled then
  begin
    MessResult:=MessageBox(Application.Handle, Pchar(GetResourceString(@AskSaveDataStr)),Pchar(Application.Title), MB_YESNOCANCEL+MB_ICONQUESTION);
    if MessResult = IDYES then
    begin
      btn_SaveArtReview.Click;
      if btn_SaveArtReview.Enabled then
        exit;
    end;

    if MessResult = IDCANCEL then
      exit;
  end;

  Action:=caFree;
end;

procedure TArtReviewForm.FormDestroy(Sender: TObject);
begin
  ArtReviewForm:=nil;
end;

procedure TArtReviewForm.btn_GetSendCardListClick(Sender: TObject);
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  FNMServerArtObj.GetSendCardByDate(dtp_SelectDate.Date, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetSendCardByDate, [sErrorMsg]);

  TempClientDataSet.Data:=vData;
  if TempClientDataSet.IsEmpty then
    raise Exception.CreateRes(@EMP_SendCardByDateEmpty);
    
  FillListItemsFromDataSet(TempClientDataSet, 'FN_Card', '', ['Quantity', 'GF_NO'], lv_CardList.Items);
end;

procedure TArtReviewForm.btn_SaveArtReviewClick(Sender: TObject);
begin
  SaveArtReview;
end;

procedure TArtReviewForm.SaveArtReview;
var
  i: Integer;
  sCondition,sErrorMsg: WideString;
  StepNOStr,OperationCodeStr,ItemNameStr,ItemValueStr :String;
begin
  if edt_SelectCard.Text = '' then exit;

  cds_FactArtDtl.MergeChangeLog;
  //保存数据
  with cds_FactArtDtl do
  begin
    First;
    while not Eof do
    begin
      StepNOStr := StepNOStr + Trim(FieldByName('Step_NO').AsString) + '@';
      OperationCodeStr := OperationCodeStr + Trim(FieldByName('Operation_Code').AsString) + '@';
      ItemNameStr := ItemNameStr + Trim(FieldByName('Item_Name').AsString) + '@';
      ItemValueStr := ItemValueStr + Trim(FieldByName('Item_Value').AsString) + '@';
      Next;
    end;
  end;
  sCondition := QuotedStr(edt_SelectCard.Text)+ ','+ QuotedStr(StepNOStr)+','+
                QuotedStr(OperationCodeStr)  + ','+ QuotedStr(ItemNameStr)+ ','+
                QuotedStr(ItemValueStr) +','+ QuotedStr(Login.LoginName);
  FNMServerObj.SaveDataBySQL('SaveArtReview',sCondition,sErrorMsg);
//  FNMServerArtObj.SaveCardArtReview(edt_SelectCard.Text, Login.LoginName, cds_FactArtDtl.Data, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveArtReview, [sErrorMsg]);

  //删除输入过的卡号
  with lv_CardList.Items do
  for i := 0 to Count - 1 do
  begin
    if Item[i].Caption = edt_SelectCard.Text then
    begin
      Item[i].Delete;
      Break;
    end;
  end;

  btn_SaveArtReview.Enabled:=false;
  ShowMsgDialog(@MSG_SaveStdArtInfoSuccess, mtInformation);
end;

procedure TArtReviewForm.FormCreate(Sender: TObject);
begin
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btn_SaveArtReview.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Help.Glyph.LoadFromResourceName(HInstance, RES_HELPABOUT);
  btn_GetSendCardList.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btn_InputArtReview.Glyph.LoadFromResourceName(HInstance, RES_QUERY);

  // cds_ArtReviewList.Data:=Dictionary.cds_ArtReviewList.Data;
  dtp_SelectDate.Date:=IncDay(Now, -1);
  btn_SaveArtReview.Enabled:=false;
end;

procedure TArtReviewForm.cds_ArtReviewListAfterEdit(DataSet: TDataSet);
begin
  btn_SaveArtReview.Enabled:=true;
end;

procedure TArtReviewForm.lv_CardListChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if Item <>  nil then
  begin
    edt_SelectCard.Text:=Item.Caption;
    if cds_FactArtDtl.Active then cds_FactArtDtl.EmptyDataSet;
  end;
end;

procedure TArtReviewForm.lv_CardListDblClick(Sender: TObject);
var
  MousePoint: TPoint;
  DbClickItem: TListItem;
begin
  MousePoint:=(Sender as TListView).ScreenToClient(Mouse.CursorPos);
  DbClickItem:=(Sender as TListView).GetItemAt(MousePoint.X, MousePoint.Y);
  if DbClickItem = nil then exit;
  (Sender as TListView).Selected:=DbClickItem;
  edt_SelectCard.Text:= DbClickItem.Caption;


  GetArtReview(edt_SelectCard.Text);
end;

procedure TArtReviewForm.btn_InputArtReviewClick(Sender: TObject);
begin
  GetArtReview(edt_SelectCard.Text);
end;

procedure TArtReviewForm.GetArtReview(FN_Card:string);
var
  i: Integer;
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  if FN_Card = '' then exit;
   sCondition := QuotedStr(FN_Card);
  FNMServerObj.GetQueryData(vData,'GetArtReview',sCondition,sErrorMsg);
//  FNMServerArtObj.GetArtReview(edt_SelectCard.Text, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise Exception.CreateResFmt(@ERR_GetArtReview, [sErrorMsg]);

  cds_FactArtDtl.Data:= vData;
  if cds_FactArtDtl.IsEmpty then
    raise Exception.CreateResFmt(@EMP_ArtReview, [edt_SelectCard.Text]);

  GridDecorator.BindCxViewWithDataSource(cxgridtv_FactArtDtl, ds_FactArtDtl);
  // cxgridtv_FactArtDtl.GetColumnByFieldName('Step_NO').GroupIndex:=0;
  // cxgridtv_FactArtDtl.GetColumnByFieldName('Step_NO').Visible:=false;
  cxgridtv_FactArtDtl.DataController.Groups.FullExpand;
  for i := 0 to cxgridtv_FactArtDtl.ColumnCount - 1 do
    cxgridtv_FactArtDtl.Columns[i].Options.Editing:=false;
  cxgridtv_FactArtDtl.GetColumnByFieldName('Item_Value').Options.Editing:=true;
  btn_SaveArtReview.Enabled:=false;
end;

procedure TArtReviewForm.btn_ExitClick(Sender: TObject);
begin
  close;
end;

procedure TArtReviewForm.cds_FactArtDtlAfterEdit(DataSet: TDataSet);
begin
  btn_SaveArtReview.Enabled:=True;
end;

procedure TArtReviewForm.cxgridtv_FactArtDtlKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    with cxgridtv_FactArtDtl.DataController.DataSource.DataSet do
    if Active then
    begin
      if Eof then
        First
      else
        Next;
    end;
end;

procedure TArtReviewForm.edt_SelectCardKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btn_InputArtReview.Click;
end;

end.

