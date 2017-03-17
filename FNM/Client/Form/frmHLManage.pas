unit frmHLManage;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmHLManage.pas                                               }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 Lvzd                                                          }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  手织板收付                                                   }
{                                                                              }
{******************************************************************************}

interface

uses
  uFNMArtInfo, Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms, Dialogs, ComCtrls, DB, DBClient,
  Buttons, ExtCtrls, StdCtrls;

type
  THLManageForm = class(TForm)
    pgc_HLList: TPageControl;
    btn_Help: TBitBtn;
    btn_Receive_SendHL: TBitBtn;
    btn_Exit: TBitBtn;
    pnl_Only: TPanel;
    ts_Only: TTabSheet;
    tv_NOReceiveHLList: TTreeView;
    tv_NoSendHLList: TTreeView;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_Receive_SendHLClick(Sender: TObject);
    procedure pgc_HLListChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure GetNOReceiveSendHLList;
  public
    { Public declarations }
  end;

var
  HLManageForm: THLManageForm;

implementation

uses ServerDllPub, uFNMResource, uDictionary, uAppOption, CommCtrl, uLogin,
     StrUtils;

{$R *.dfm}

const
  {$EXTERNALSYM TVM_GETITEMSTATE}
  TVM_GETITEMSTATE = TV_FIRST + 39;

function TreeView_GetCheckState(hwndTV: HWND; hitem: HTreeItem): Integer;
begin//Checked 1 Unchecked 0 No Check Box Image -1
  Result := (SendMessage(hwndTV, TVM_GETITEMSTATE, Longint(hitem), TVIS_STATEIMAGEMASK) shr 12) - 1 ;
end;

procedure THLManageForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure THLManageForm.FormDestroy(Sender: TObject);
begin
  HLManageForm:=nil;
end;

procedure THLManageForm.FormCreate(Sender: TObject);
var
  Style: Integer;
begin
  btn_Help.Glyph.LoadFromResourceName(HInstance, RES_HELPABOUT);

  pgc_HLList.ActivePageIndex:=0;
  btn_Receive_SendHL.Enabled:=false;

  Style := GetWindowLong(tv_NOReceiveHLList.Handle, GWL_STYLE);
  Style := Style or TVS_CHECKBOXES;
  SetWindowLong(tv_NOReceiveHLList.Handle, GWL_STYLE, Style);

  Style := GetWindowLong(tv_NoSendHLList.Handle, GWL_STYLE);
  Style := Style or TVS_CHECKBOXES;
  SetWindowLong(tv_NoSendHLList.Handle, GWL_STYLE, Style);
end;

procedure THLManageForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
  OnActivate:=nil;
end;

procedure THLManageForm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure THLManageForm.btn_Receive_SendHLClick(Sender: TObject);
var
  i, CheckCount,SaveType: Integer;
  sFN_NO: String;
  CurTreeView: TTreeView;
  sCondition,sErrorMsg: WideString;
begin
  case pgc_HLList.ActivePageIndex of
    0: begin CurTreeView:=tv_NOReceiveHLList; SaveType:= 0; end;//接收;
    1: begin CurTreeView:=tv_NoSendHLList; SaveType:= 1 ; end;//送出;
  else Exit;
  end;

  sFN_NO := '';
  CheckCount:=0;
  with CurTreeView do
  for i := 0 to Items.Count - 1 do
  begin
    if (Items.Item[i].Level = 0) and (TreeView_GetCheckState(CurTreeView.Handle, Items.Item[i].ItemId) = 1)then
    begin
      sFN_NO:=sFN_NO + Items.Item[i].Text + ',';
      inc(CheckCount);
    end;
  end;
  if sFN_NO = '' then Exit;
  sCondition := IntToStr(SaveType) + ','+QuotedStr(sFN_NO)+','+ QuotedStr(Login.LoginName);
  FNMServerObj.SaveDataBySQL('SaveFNNOInfo',sCondition,sErrorMsg);
//  FNMServerArtObj.SaveHLReceiveSendInfo(SaveType, sFN_NO, Login.LoginName, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveHLReceiveSendInfo, [LeftStr(btn_Receive_SendHL.Caption, 4), sErrorMsg]);

  with CurTreeView do
  try
    Items.BeginUpdate;
    i:=0;
    begin
      while CheckCount <> 0 do
      begin
        if i >= Items.Count then
          Break;

        if (Items.Item[i].Level = 0) and (TreeView_GetCheckState(Handle, Items.Item[i].ItemId) = 1) then
          Items.Item[i].Delete
        else
          Inc(i);
      end;
    end;
  finally
    Items.EndUpdate;
  end;
  ShowCustomMsgDialog(@MSG_SaveReceiveSendSuccess, [LeftStr(btn_Receive_SendHL.Caption, 4)], mtInformation);
end;

procedure THLManageForm.pgc_HLListChange(Sender: TObject);
begin
  btn_Receive_SendHL.Caption:= IfThen(pgc_HLList.ActivePageIndex=0,'接收(&R)','送出(&S)');
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
end;

procedure THLManageForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F5: GetNOReceiveSendHLList;
  end;
end;

procedure THLManageForm.GetNOReceiveSendHLList;
var
  i: Integer;
  GetType: Integer;
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
  CurTreeView: TTreeView;
begin
  case pgc_HLList.ActivePageIndex of
    0: begin CurTreeView:=tv_NOReceiveHLList; GetType:=0; end;//接收;
    1: begin CurTreeView:=tv_NoSendHLList; GetType:=1; end;//送出;
  else Exit;
  end;
  if CurTreeView.Items.Count <> 0 then Exit;
  sCondition := IntToStr(GetType);
  FNMServerObj.GetQueryData(vData,'GetFNNOInfo',sCondition,sErrorMsg);
  //FNMServerArtObj.GetFNNOList(GetType, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetNOReceiveSendHLList, [LeftStr(btn_Receive_SendHL.Caption, 4), sErrorMsg]);

  TempClientDataSet.Data:=vData;
  if TempClientDataSet.IsEmpty then
    raise Exception.CreateResFmt(@EMP_NOReceiveSendHLList, [LeftStr(btn_Receive_SendHL.Caption, 4)]);

  FillTreeItemsFromDataSetByClassField(TempClientDataSet, 'HL_NO', 'FN_NO', '', '', CurTreeView.Items);
  with CurTreeView.Items do
  begin
    for i := 0 to Count - 1 do
      if Item[i].Level <> 0 then
        Item[i].StateIndex :=0;
  end;
  btn_Receive_SendHL.Enabled:=True;
end;

end.
