unit frmCancelSendInfo;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmCancelSendInfo.pas                                         }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  取消送布                                                     }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, Buttons, ComCtrls, StdCtrls,
  DBClient, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter, ExtCtrls;

type
  TCancelSendInfoForm = class(TBaseForm)
    cxsplLeft: TcxSplitter;
    dsSendInfo: TDataSource;
    cdsSendInfo: TClientDataSet;
    lvFNCard: TListView;
    cxgridSendInfo: TcxGrid;
    cxgridtvSendInfo: TcxGridDBTableView;
    cxGridlSendInfo: TcxGridLevel;
    pnlBottom: TPanel;
    lblNoteNO: TLabel;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    cbbNoteNO: TComboBox;
    btnRefresh: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbNoteNOSelect(Sender: TObject);
  private
    procedure GetSendInfo;
    procedure GetData();
    procedure CancelSendInfo;
    procedure SaveData();

    { Private declarations }
  public
    { Public declarations }
  end;

var
  CancelSendInfoForm: TCancelSendInfoForm;

implementation

uses ServerDllPub, uGlobal, frmMain, uShowMessage, uLogin,
  UGridDecorator, uAppOption, uDictionary, uFNMResource;

{$R *.dfm}

procedure TCancelSendInfoForm.GetSendInfo;
var vData: OleVariant;
  sCondition,sNote_NO,sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    lvFNCard.Items.Clear;
    if TGlobal.CheckValueIsNull(cbbNoteNO.Text,'请输入要取消的送布单号') then Exit;
    sNote_NO := Trim(cbbNoteNO.Text);
    if sNote_NO ='' then Exit;
    if cdsSendInfo.Active then cdsSendInfo.EmptyDataSet;
    sCondition := QuotedStr(sNote_NO)+',' + QuotedStr(Login.CurrentDepartment)+','+IntToStr(-1);
    FNMServerObj.GetQueryData(vData,'GetSendInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TempClientDataSet.Filter := '';
    cdsSendInfo.Filter := '';
    TempClientDataSet.Data := vData[0];
    cdsSendInfo.Data := vData[1];
    if TempClientDataSet.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有可取消的数据,请检查你所输入的单号',2);
      Exit;
    end;
    //填充待确认的卡的ListView
    TGlobal.FillItemsFromDataSet(TempClientDataSet, ['FN_Card','Quantity','GF_ID','GF_NO'],lvFNCard.Items);
    //填充cxGrid
    GridDecorator.BindCxViewWithDataSource(cxgridtvSendInfo, dsSendInfo);
    GridDecorator.AddFooter(cxgridtvSendInfo,['FN_Card','Quantity'],[skCount,skSum]);
    btnSave.Enabled := not TempClientDataSet.IsEmpty;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCancelSendInfoForm.GetData;
begin
  GetSendInfo;
end;

procedure TCancelSendInfoForm.CancelSendInfo;
var
  sCondition,sNote_NO, sErrorMsg: WideString;
begin
  inherited;
  try
    ShowMsg('正在保存数据稍等！', crHourGlass);
    if TGlobal.CheckValueIsNull(cbbNoteNO.Text,'请输入要取消的送布单号') then Exit;
    sNote_NO := Trim(cbbNoteNO.Text);
    if sNote_NO ='' then Exit;
    sCondition := QuotedStr(sNote_NO)+ ','+ QuotedStr(Login.LoginName)+','+QuotedStr('S');
    FNMServerObj.SaveDataBySQL('CancelFabricInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
    btnSave.Enabled := False;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCancelSendInfoForm.SaveData;
begin
  CancelSendInfo;
end;

procedure TCancelSendInfoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCancelSendInfoForm.FormDestroy(Sender: TObject);
begin
  inherited;
  CancelSendInfoForm := nil;
end;

procedure TCancelSendInfoForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  cbbNoteNO.Items.Text := Dictionary.GetItemList('取消送布',Login.CurrentDepartment,Login.CurrentDepartment);
end;

procedure TCancelSendInfoForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData();
end;

procedure TCancelSendInfoForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCancelSendInfoForm.FormCreate(Sender: TObject);
begin
  inherited;
  cbbNoteNO.Items.Text := Dictionary.GetItemList('取消送布',Login.CurrentDepartment,Login.CurrentDepartment);
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
end;

procedure TCancelSendInfoForm.cbbNoteNOSelect(Sender: TObject);
begin
  inherited;
  GetData;
end;

end.

