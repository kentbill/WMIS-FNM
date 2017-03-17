unit frmPlanControl;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmPlanControl.pas                                            }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 Lvzd                                                          }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  计划控制                                                     }
{                                                                              }
{******************************************************************************}

interface

uses
  uFNMArtInfo,
  Windows, Messages, Classes, ComCtrls, Forms, DB, DBClient, StdCtrls,
  Grids, ValEdit, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Controls, ExtCtrls, Buttons, cxStyles, cxCustomData, cxGraphics,Dialogs,
  cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxSplitter;

type
  TPlanControlForm = class(TForm)
    cds_OnLineCardList: TClientDataSet;
    ds_OnLineCardList: TDataSource;
    btn3: TSpeedButton;
    btn_Exit: TSpeedButton;
    cxgrid_OnLineCard: TcxGrid;
    cxgridtv_OnLineCard: TcxGridDBTableView;
    cxGridl_OnLineCard: TcxGridLevel;
    btn_Save: TSpeedButton;
    grp_Only: TGroupBox;
    lv_DipCard: TListView;
    btn_AddCard: TSpeedButton;
    btn_RemoveCard: TSpeedButton;
    btn_RefreshCard: TSpeedButton;
    cbb_DipPoint: TComboBox;
    cxspl1: TcxSplitter;
    pnl_Only: TPanel;
    txt_Only: TStaticText;
    cxSplitter1: TcxSplitter;
    pnlBottom: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Add_ReMove_RefreshCard(Sender: TObject);
    procedure btn_SaveDipClick(Sender: TObject);
    procedure KeyDownAControl(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_ShowArtClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbb_DipPointSelect(Sender: TObject);
    procedure cxgridtv_OnLineCardCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgridtv_OnLineCardDblClick(Sender: TObject);

  private
    { Private declarations }
    procedure RefreshFNCardList;
    {* 刷新卡号列表}
    procedure SaveDipCard;
    {* DIP Card}
    procedure CheckInterval; //检查是否大于16小时
  public
    { Public declarations }
  end;

var
  PlanControlForm: TPlanControlForm;

implementation

uses SysUtils, StrUtils, Variants, uDictionary, cxGridDBDataDefinitions, UAppOption,
    uFNMResource, ServerDllPub, uShowMessage, uLogin, uGlobal,
    UGridDecorator, uCADInfo;

{$R *.dfm}

procedure TPlanControlForm.RefreshFNCardList;
var
  Operation_Code: String;
begin
  if cbb_DipPoint.ItemIndex = -1 then exit;

  Operation_Code:=LeftStr(cbb_DipPoint.text, Pos('-', cbb_DipPoint.text) -1);
  GetOnLineCardByOperation(Operation_Code, Login.CurrentDepartment, cds_OnLineCardList);

  cds_OnLineCardList.Filter:='NOT FN_Card LIKE ''N%''';
  cds_OnLineCardList.Filtered:=Operation_Code = '999';
  if cds_OnLineCardList.RecordCount = 0 then exit;
  GridDecorator.BindCxViewWithDataSource(cxgridtv_OnLineCard, ds_OnLineCardList);
  btn_AddCard.Enabled:=cxgridtv_OnLineCard.DataController.DataSet.RecordCount <> 0;
end;

procedure TPlanControlForm.SaveDipCard;
var
  i: Integer;
  sCondition,sErrorMsg: WideString;
  SelectCardList: String;
begin
  //构造选中卡的列表,注意不要去掉字符窜最后的一个逗号
  SelectCardList:='';
  for i := 0 to lv_DipCard.Items.Count - 1 do
    SelectCardList:=SelectCardList + lv_DipCard.Items[i].Caption + ',';
  System.Delete(SelectCardList,Length(SelectCardList),1);
  //DIP Card
  sCondition := QuotedStr(LeftStr(cbb_DipPoint.Text, 3))+ ','+ QuotedStr(SelectCardList)+','+
                QuotedStr('')+','+QuotedStr('')+','+ QuotedStr('')+','+QuotedStr(Login.LoginName);
  FNMServerObj.SaveDataBySQL('SetDipOperation',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveDipInfo, [sErrorMsg]);

  with cds_OnLineCardList do
  try
    DisableControls;
    First;
    for I := RecordCount - 1 downto 0 do
    begin
      if pos(cds_OnLineCardList['FN_Card'], SelectCardList) <> 0 then
        Delete;
      Next;
    end;
  finally
    MergeChangeLog;
    EnableControls;
    CheckBrowseMode;
  end;
  lv_DipCard.Items.Clear;
end;

procedure TPlanControlForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TPlanControlForm.FormDestroy(Sender: TObject);
begin
  PlanControlForm:=nil;
end;

procedure TPlanControlForm.FormCreate(Sender: TObject);
begin
  //加载图标
  btn_Save.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btn_AddCard.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btn_RemoveCard.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btn_RefreshCard.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  //TreeView的双击事件
  lv_DipCard.OnDblClick:=TGlobal.DblClickAListview;
  //AGridView的双击事件
  //cxgridtv_OnLineCard.OnDblClick:=TGlobal.DblClickAWinControl;
  //布置界面
  btn_Save.Enabled:=false;
  btn_AddCard.Enabled:=false;
  btn_RemoveCard.Enabled:=false;
end;

procedure TPlanControlForm.Add_ReMove_RefreshCard(Sender: TObject);
var
  i: Integer;
begin
  if sender = btn_AddCard then
  with cxgridtv_OnLineCard do
  begin
    for i := 0 to Controller.SelectedRowCount - 1 do
    begin
      AddItemToListItems(Controller.SelectedRows[i].Values[GetColumnByFieldName('FN_Card').Index], [
                         Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_ID').Index],
                         Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_NO').Index],
                         Controller.SelectedRows[i].Values[GetColumnByFieldName('FACT_Art_ID').Index],
                         Controller.SelectedRows[i].Values[GetColumnByFieldName('Step_NO').Index],
                         Controller.SelectedRows[i].Values[GetColumnByFieldName('Quantity').Index]], lv_DipCard.Items);
    end;
    DataController.ClearSelection;
    //DataController.DataSet.Next;
  end;

  if sender = btn_RemoveCard then
    lv_DipCard.DeleteSelected;

  if sender = btn_RefreshCard then
    RefreshFNCardList;

  btn_Save.Enabled:=lv_DipCard.Items.Count <> 0;
  btn_RemoveCard.Enabled:=lv_DipCard.Items.Count <> 0;
end;

procedure TPlanControlForm.btn_SaveDipClick(Sender: TObject);
begin
  if lv_DipCard.Items.Count = 0 then exit;

  SaveDipCard;
  raise Exception.CreateRes(@MSG_SaveArtControlSuccess);
end;

procedure TPlanControlForm.KeyDownAControl(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Sender = Self then
  case Key of
    VK_F5: btn_RefreshCard.Click;
  end;

  if Sender = cbb_DipPoint then
  case Key of
    VK_RETURN: btn_RefreshCard.Click;
  end;
end;

procedure TPlanControlForm.btn_ShowArtClick(Sender: TObject);
begin
  btn_Save.Enabled:=true;
end;

procedure TPlanControlForm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TPlanControlForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  //刷新界面数据
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
  //加载DIP工序
  with Dictionary.cds_OperationHdrList do
  try
    Filter:='Operation_Type = ''Plan_Dip''';
    Filtered:=true;
    FillItemsFromDataSet(Dictionary.cds_OperationHdrList, 'Operation_Code', 'Operation_CHN', '','-', cbb_DipPoint.Items);
  finally
    Filtered:=false;
  end;
  OnActivate:=nil;
end;

procedure TPlanControlForm.cbb_DipPointSelect(Sender: TObject);
begin
  if cds_OnLineCardList.Active then
    cds_OnLineCardList.Close;
  lv_DipCard.Items.Clear;
end;

procedure TPlanControlForm.cxgridtv_OnLineCardCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.Focused then Exit;
  GridDecorator.CustomerDraw(Sender, ACanvas, AViewInfo, False);
end;


//检查时间间隔是否大于16小时
procedure TPlanControlForm.CheckInterval;
var
  span,sRemark:string;
begin
   with cxgridtv_OnLineCard do
   begin
     span := Controller.SelectedRows[0].Values[GetColumnByFieldName('间隔').Index];
   end;
   if span = '' then span := '0';
   if StrToInt(span) >= 16 then
      sRemark := InputBox('未安排原因','原因:','');

end;

procedure TPlanControlForm.cxgridtv_OnLineCardDblClick(Sender: TObject);
begin
  CheckInterval;
end;

end.
