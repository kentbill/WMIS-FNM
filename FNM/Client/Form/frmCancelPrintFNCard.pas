unit frmCancelPrintFNCard;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmCancelPrintFNCard.pas                                            }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  取消打卡记录                                                 }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, StdCtrls, Buttons, ExtCtrls, DBClient;

type
  TCancePrintFNCardForm = class(TBaseForm)
    cdsFNCard: TClientDataSet;
    dsFNCard: TDataSource;
    cxgridFNCard: TcxGrid;
    cxgridtvFNCard: TcxGridDBTableView;
    cxGridlFNCard: TcxGridLevel;
    pnl1: TPanel;
    lblFNCard: TLabel;
    edtFNCard: TEdit;
    btnClose: TSpeedButton;
    btnCancel: TSpeedButton;
    btnQuery: TSpeedButton;
    procedure btnQueryClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure GetPrintFNCardInfo;
    procedure CancelPrintFNCardInfo;
  public
    { Public declarations }
  end;

var
  CancePrintFNCardForm: TCancePrintFNCardForm;

implementation

uses ServerDllPub, uGlobal, frmMain, uShowMessage, uLogin, UGridDecorator,
  uAppOption, uFNMResource;
{$R *.dfm}
procedure TCancePrintFNCardForm.CancelPrintFNCardInfo;
var sCondition,sFN_Card, sErrorMsg: WideString;
begin
  inherited;
  try
    ShowMsg('正在保存数据稍等！', crHourGlass);
    if TGlobal.CheckValueIsNull(edtFNCard.Text,'请输入要取消的卡号') then Exit;
    sFN_Card := Trim(edtFNCard.Text);
    if sFN_Card ='' then Exit;
    sCondition := QuotedStr(sFN_Card)+','+QuotedStr(Login.CurrentDepartment)+','+QuotedStr(Login.LoginName);
    FNMServerObj.SaveDataBySQL('CancelPrintFNCard',sCondition,sErrorMsg);
//    FNMServerObj.CancelPrintFNCardInfo(sFN_Card,Login.CurrentDepartment,Login.LoginName,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('取消卡号成功,请重新打卡', mtInformation);
    btnCancel.Enabled := False;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCancePrintFNCardForm.GetPrintFNCardInfo;
var sFNCard: string;
    sCondition,sErrorMsg: WideString;
    vData: OleVariant;
begin
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    if TGlobal.CheckValueIsNull(edtFNCard.Text,'请输入要取消的卡号') then Exit;
    sFNCard := Trim(edtFNCard.Text);
    if sFNCard ='' then Exit;
    if cdsFNCard.Active then cdsFNCard.EmptyDataSet;

    sCondition := QuotedStr(sFNCard)+','+QuotedStr(Login.CurrentDepartment)+','+IntToStr(2);
    FNMServerObj.GetQueryData(vData,'GetUnionFNCard',sCondition,sErrorMsg);
//    FNMServerObj.GetUnionFNCardInfo(vData, sFN_Card, Login.CurrentDepartment, 2, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsFNCard.Data := vData;
    if cdsFNCard.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有可取消的数据,请检查你所输入的卡号',2);
      Exit;
    end;
    //填充cxGrid
    GridDecorator.BindCxViewWithDataSource(cxgridtvFNCard, dsFNCard);
    btnCancel.Enabled := not cdsFNCard.IsEmpty;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCancePrintFNCardForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  GetPrintFNCardInfo;
end;

procedure TCancePrintFNCardForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  CancelPrintFNCardInfo;
end;

procedure TCancePrintFNCardForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCancePrintFNCardForm.FormDestroy(Sender: TObject);
begin
  inherited;
  CancePrintFNCardForm := nil;
end;

procedure TCancePrintFNCardForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCancePrintFNCardForm.FormCreate(Sender: TObject);
begin
  inherited;
  btnQuery.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnCancel.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
end;

end.
