unit frmCancelFI;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmCancelFI.pas                                               }
{       创建日期 2004-8-26 16:22:52                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  取消成品回修                                                             }
{                                                                              }
{******************************************************************************}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, CheckLst, DBClient,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ExtCtrls;

type
  TCancelFIForm = class(TBaseForm)
    pnl1: TPanel;
    lblNote_NO: TLabel;
    btnSave: TButton;
    btnClose: TButton;
    btnQuery: TButton;
    cxgdReceiveInfo1: TcxGrid;
    cxgridtvReceiveInfo: TcxGridDBTableView;
    cxGridl2: TcxGridLevel;
    dsReceiveInfo: TDataSource;
    cdsReceiveInfo: TClientDataSet;
    grp1: TGroupBox;
    chklstFabricNOList: TCheckListBox;
    chkAll: TCheckBox;
    edtNoteNO: TEdit;
    procedure chkAllClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetReceiveInfo();
    procedure GetData;
    procedure CancelFIInfo();
    procedure SaveData;
  public
    { Public declarations }
  end;

var
  CancelFIForm: TCancelFIForm;

implementation

uses uGlobal, uGridDecorator, uShowMessage, ServerDllPub, uLogin;

{$R *.dfm}

procedure TCancelFIForm.GetReceiveInfo();
var vData: OleVariant;
    sCondition,sNote_NO, sErrorMsg: WideString;
begin
  try
    ShowMsg('正在查询数据稍等！', crHourGlass);
     if not TGlobal.CheckValueLength(edtNoteNO.Text, 12) then
    begin
      TMsgDialog.ShowMsgDialog('请检查你所输入的' + lblNote_NO.Caption + '的长度是否为12位',mtWarning);
      Exit;
    end;
    sNote_NO := Trim(edtNoteNO.Text);
    sCondition :=QuotedStr(sNote_NO)+','+QuotedStr(Login.CurrentDepartment)+','+QuotedStr('3');
    FNMServerObj.GetQueryData(vData,'GetReciveInfo',sCondition,sErrorMsg);
//    FNMServerObj.GetReceiveInfo(vData, sNote_NO, Login.CurrentDepartment, '3', sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsReceiveInfo.Data := vData;
     //填充cxGrid
    GridDecorator.BindCxViewWithDataSource(cxgridtvReceiveInfo, dsReceiveInfo,True);
    GridDecorator.AddFooter(cxgridtvReceiveInfo,['Quantity','Fabric_No'],[skSum,skCount]);
    with cdsReceiveInfo do
    begin
      if IsEmpty then
      begin
        TMsgDialog.ShowMsgDialog('请检查你所输入的' + lblNote_NO.Caption,mtWarning);
        Exit;
      end;
      chklstFabricNOList.Items.Clear;
      First;
      while not Eof do
      begin
        chklstFabricNOList.Items.Add(FieldByName('Fabric_NO').AsString);
        Next;
      end;
    end;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCancelFIForm.GetData;
begin
  GetReceiveInfo;
end;

procedure TCancelFIForm.CancelFIInfo();
var
  i: Integer;
  sCondition,sNote_NO,sFabricNOList,sErrorMsg: WideString;
begin
  sFabricNOList := '';
  for i := 0 to chklstFabricNOList.Count -1 do
    if chklstFabricNOList.Checked[i] then
      sFabricNOList := sFabricNOList+','+chklstFabricNOList.Items[i];
  if sFabricNOList = '' then
  begin
    TMsgDialog.ShowMsgDialog('请选择要取消的布号',mtWarning);
    Exit;
  end;
  sNote_NO := edtNoteNO.Text;
  if Trim(sNote_NO) = '' then Exit;
  try
    ShowMsg('正在取消数据稍等！', crHourGlass);
    sFabricNOList := StringReplace(sFabricNOList, '`', '#96#', [rfReplaceAll]);
    sCondition := QuotedStr(sNote_NO)+ ','+ QuotedStr(sFabricNOList)+','+QuotedStr(Login.LoginName);
    FNMServerObj.SaveDataBySQL('CancelFIInfo',sCondition,sErrorMsg);
//    FNMServerObj.CancelFIInfo(sNote_NO,sFabricNOList,Login.LoginName,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('取消数据成功', 2);
    cdsReceiveInfo.EmptyDataSet;
    chklstFabricNOList.Clear;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCancelFIForm.SaveData;
begin
 CancelFIInfo;
end;

procedure TCancelFIForm.chkAllClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i := 0 to chklstFabricNOList.Items.Count -1 do
    chklstFabricNOList.Checked[i] := chkAll.Checked;
end;

procedure TCancelFIForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCancelFIForm.FormDestroy(Sender: TObject);
begin
  inherited;
  CancelFIForm := nil;
end;

procedure TCancelFIForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  GetData;
end;

procedure TCancelFIForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData;
end;

procedure TCancelFIForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
