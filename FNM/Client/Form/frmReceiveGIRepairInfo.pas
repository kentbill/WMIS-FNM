unit frmReceiveGIRepairInfo;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmSendInfoCheck.pas                                          }
{       创建日期 2004-8-26 16:20:05                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{            读:                                                               }
{            写:                                                               }
{       调用重要函数/SQL对象说明                                               }
{       功能描述 送布前工艺CHECK                                               }
{                                                                              }
{******************************************************************************}


interface

uses
  uFNMResource, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, frmBase, StdCtrls, ExtCtrls, OleCtrls, Buttons,
  DB, DBClient, ComCtrls, StrUtils, GFCADLib_TLB, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter;

type
  TReceiveGIRepairInfoForm = class(TBaseForm)
    cdsGIRepairInfo: TClientDataSet;
    grpSource: TGroupBox;
    lvSource: TListView;
    btnRefresh: TSpeedButton;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    pnl_Only: TPanel;
    btnRight: TSpeedButton;
    btnRightAll: TSpeedButton;
    btnLeft: TSpeedButton;
    btnLeftAll: TSpeedButton;
    grp4: TGroupBox;
    lvDestinate: TListView;
    spl1: TSplitter;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
    procedure btnRightAllClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
    procedure btnLeftAllClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure lvSourceClick(Sender: TObject);
    procedure lvSourceDblClick(Sender: TObject);
    procedure lvDestinateClick(Sender: TObject);
    procedure lvDestinateDblClick(Sender: TObject);
    procedure lvSourceColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvDestinateColumnClick(Sender: TObject; Column: TListColumn);
    procedure FormCreate(Sender: TObject);
    procedure lvSourceKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvDestinateKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvDestinateCustomDraw(Sender: TCustomListView;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
{* -----------------------------------------------------------------------------
   过程名称 Initialize
   创建人员 zhangjy
   创建日期 2004-8-26 14:24:10
   参数列表 None
   返回值   None
   功能描述 初始化窗体参数
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure Initialize;
{* -----------------------------------------------------------------------------
   过程名称 GetData ,GetGIRepairInfo
   创建人员 zhangjy
   创建日期 2004-8-26 14:24:39
   参数列表 None
   返回值   None
   功能描述 获取挑修完的布的信息
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure GetGIRepairInfo;
    procedure GetData;
{* -----------------------------------------------------------------------------
   过程名称 SaveData,SaveGIRepairInfo
   创建人员 zhangjy
   创建日期 2004-8-26 16:19:22
   参数列表 None
   返回值   None
   功能描述 送布前质量CHECK
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure SaveGIRepairInfo;
    procedure SaveData;
  public
    { Public declarations }
{* -----------------------------------------------------------------------------
   过程名称 PublicQuery ;PublicExport; PublicSave
   创建人员 zhangjy
   创建日期 2004-8-31 15:41:59
   参数列表 None
   返回值   None
   功能描述 响应TOOLBAR相应的事件
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure PublicQuery; override;
    procedure PublicExport; override;
    procedure PublicSave; override;
  end;
var
  ReceiveGIRepairInfoForm: TReceiveGIRepairInfoForm;

implementation

uses ServerDllPub, uGlobal, uShowMessage, uLogin,
  uAppOption;

{$R *.dfm}

procedure TReceiveGIRepairInfoForm.PublicQuery;
begin
  GetData;
end;

procedure TReceiveGIRepairInfoForm.PublicExport;
begin
  TGlobal.SaveDataToFile(cdsGIRepairInfo, sftXLS)
end;

procedure TReceiveGIRepairInfoForm.PublicSave;
begin
  SaveData;
end;

procedure TReceiveGIRepairInfoForm.Initialize;
begin
  //设置BUTTON图片
  btnRight.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnRightAll.Glyph.LoadFromResourceName(HInstance, RES_DOWNALL);
  btnLeft.Glyph.LoadFromResourceName(HInstance, RES_UP);
  btnLeftAll.Glyph.LoadFromResourceName(HInstance, RES_UPALL);
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
end;

procedure TReceiveGIRepairInfoForm.GetGIRepairInfo;
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
begin
  if lvDestinate.Items.Count > 0 then Exit;
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    //获取待确认的布号信息
    sCondition := 'a.Current_Department ='+QuotedStr(Login.CurrentDepartment);
    FNMServerObj.GetQueryData(vData,'GetGIRepairInfo',sCondition,sErrorMsg);
     if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsGIRepairInfo.Data := vData;
    if cdsGIRepairInfo.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有待接收的已挑修完的布号',2);
      Exit;
    end;
    //填充待确认的卡的ListView
    TGlobal.FillItemsFromDataSet(cdsGIRepairInfo,'',['Fabric_NO','Quantity','GF_ID','GF_NO'],nil,nil,lvSource.Items);
    TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TReceiveGIRepairInfoForm.GetData;
begin
  GetGIRepairInfo;
end;

procedure TReceiveGIRepairInfoForm.SaveGIRepairInfo;
var i: Integer;
  sCondition,sFabric_NO_List, sErrorMsg: WideString;
begin
  inherited;
  try
    ShowMsg('正在保存数据稍等！', crHourGlass);
    if lvDestinate.Items.Count = 0 then Exit;

    sFabric_NO_List := '';
    for i := 0 to lvDestinate.Items.Count - 1 do
      sFabric_NO_List := sFabric_NO_List + lvDestinate.Items[i].Caption + ',';
    sFabric_NO_List := LeftStr(sFabric_NO_List, Length(sFabric_NO_List) - 1);
    sCondition := QuotedStr(sFabric_NO_List)+','+ QuotedStr(Login.CurrentDepartment);
    FNMServerObj.SaveDataBySQL('SaveGIRepairInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    lvDestinate.Items.Clear;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TReceiveGIRepairInfoForm.SaveData;
begin
  SaveGIRepairInfo;
end;

procedure TReceiveGIRepairInfoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TReceiveGIRepairInfoForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ReceiveGIRepairInfoForm := nil;
end;

procedure TReceiveGIRepairInfoForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetData;
end;

procedure TReceiveGIRepairInfoForm.btnRightClick(Sender: TObject);
begin
  TGlobal.MoveData(lvSource, lvDestinate);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TReceiveGIRepairInfoForm.btnRightAllClick(Sender: TObject);
begin
  TGlobal.MoveData(lvSource, lvDestinate, True);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TReceiveGIRepairInfoForm.btnLeftClick(Sender: TObject);
begin
  TGlobal.MoveData(lvDestinate, lvSource);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TReceiveGIRepairInfoForm.btnLeftAllClick(Sender: TObject);
begin
  TGlobal.MoveData(lvDestinate, lvSource, True);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TReceiveGIRepairInfoForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData;
end;

procedure TReceiveGIRepairInfoForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TReceiveGIRepairInfoForm.lvSourceClick(Sender: TObject);
begin
  if lvSource.ItemIndex < 0 then Exit;
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TReceiveGIRepairInfoForm.lvSourceDblClick(Sender: TObject);
begin
  TGlobal.MoveData(lvSource, lvDestinate);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TReceiveGIRepairInfoForm.lvDestinateClick(Sender: TObject);
begin
  if lvDestinate.ItemIndex < 0 then Exit;
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TReceiveGIRepairInfoForm.lvDestinateDblClick(Sender: TObject);
begin
  TGlobal.MoveData(lvDestinate, lvSource);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;


procedure TReceiveGIRepairInfoForm.lvSourceColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  inherited;
  TGlobal.SortListView(lvSource, Column);
end;

procedure TReceiveGIRepairInfoForm.lvDestinateColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  inherited;
  TGlobal.SortListView(lvDestinate, Column);
end;

procedure TReceiveGIRepairInfoForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize;
end;

procedure TReceiveGIRepairInfoForm.lvSourceKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    TGlobal.MoveData(lvSource, lvDestinate);
    TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
  end;
end;

procedure TReceiveGIRepairInfoForm.lvDestinateKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    TGlobal.MoveData(lvDestinate, lvSource);
    TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
  end;
end;

procedure TReceiveGIRepairInfoForm.lvDestinateCustomDraw(
  Sender: TCustomListView; const ARect: TRect; var DefaultDraw: Boolean);
begin
  inherited;
  btnSave.Enabled := lvDestinate.Items.Count>0;
end;

procedure TReceiveGIRepairInfoForm.FormActivate(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
  GetData;
  OnActivate:=nil;
end;

end.
