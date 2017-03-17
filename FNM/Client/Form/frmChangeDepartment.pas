unit frmChangeDepartment;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmChangeDepartment.pas                                            }
{       创建日期 2005-6-7 13:50:57                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{           读：FNMDB..fnStock表中所有的字段                                   }
{           写：FNMDB..fnStock表中的字段FN_Card和Layer                         }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  接收坯布                                             }
{                                                                              }
{******************************************************************************}


interface

uses
  uFNMResource, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,Dialogs, frmBase, ExtCtrls, OleCtrls, StdCtrls, Buttons,
  DB, DBClient, StrUtils, ComCtrls, GFCADLib_TLB, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter, MakeSQL;

type
  TChangeDepartmentForm = class(TBaseForm)
    cdsUnSelect: TClientDataSet;
    dsUnSelect: TDataSource;
    dsSelect: TDataSource;
    cdsSelect: TClientDataSet;
    pnlCard: TPanel;
    pnl2: TPanel;
    btnAdd: TSpeedButton;
    btnUp: TSpeedButton;
    btnCancel: TSpeedButton;
    btnDown: TSpeedButton;
    cxdbgSelect: TcxGrid;
    cxdbgtvSelect: TcxGridDBTableView;
    cxGridlSelect: TcxGridLevel;
    cxSplitter1: TcxSplitter;
    cxdbgUnSelect: TcxGrid;
    cxdbgtvUnSelect: TcxGridDBTableView;
    cxGridlUnSelect: TcxGridLevel;
    pnlClient: TPanel;
    lstFabricNO: TListBox;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    btnRefresh: TSpeedButton;
    lbl2: TLabel;
    cbbCurrentDept: TComboBox;
    btnQuery: TSpeedButton;
    msPublic: TMakeSQL;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure cxdbgtvUnSelectKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxdbgtvSelectKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsUnSelectFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure cdsSelectFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure btnQueryClick(Sender: TObject);
  private
    { Private declarations }
    procedure Add;
    procedure Cancel;
    procedure Initialize();
    procedure GetData(Index: Integer);
    procedure GetStockInfo(Index: Integer);
    procedure SaveData();
    procedure ChageStockDepartmentInfo();
  public
    { Public declarations }
    procedure PublicQuery; override;
    procedure PublicSave; override;
    procedure PublicExport; override;
  end;

var
  ChangeDepartmentForm: TChangeDepartmentForm;
implementation

uses ServerDllPub, uGlobal, frmMain, uShowMessage, uLogin, uGridDecorator,
  uAppOption, uCADInfo, uDictionary;

{$R *.dfm}

procedure TChangeDepartmentForm.PublicQuery;
begin
  GetData(0);
end;

procedure TChangeDepartmentForm.PublicSave;
begin
  SaveData();
end;

procedure TChangeDepartmentForm.PublicExport;
begin
  TGlobal.SaveDataToFile(cdsUnSelect, sftXLS)
end;

procedure TChangeDepartmentForm.Initialize;
begin
 //加载图标
  btnAdd.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnCancel.Glyph.LoadFromResourceName(HInstance, RES_UP);
  btnUp.Glyph.LoadFromResourceName(HInstance, RES_UPALL);
  btnDown.Glyph.LoadFromResourceName(HInstance, RES_DOWNALL);
  btnQuery.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  //
  Dictionary.cds_DepartmentList.Filter := 'Department <> '+QuotedStr(Login.CurrentDepartment);
  Dictionary.cds_DepartmentList.Filtered := True;
  TGlobal.FillComboBoxFromDataSet(Dictionary.cds_DepartmentList,'Department','Description','->',cbbCurrentDept);
  lstFabricNO.Items.Clear;
  cxdbgtvUnSelect.OnDblClick := TGlobal.DblClickAWinControl;
  cxdbgtvSelect.OnDblClick := TGlobal.DblClickAWinControl;
end;

procedure TChangeDepartmentForm.GetData(Index: Integer);
begin
  GetStockInfo(Index);
end;

procedure TChangeDepartmentForm.GetStockInfo(Index: Integer);
var vData: OleVariant;
    sCondition,sSql,sErrorMsg: WideString;
begin
  try
    ShowMsg( '正在获取数据稍等！', crHourGlass);
    lstFabricNO.Items.Clear;
   //获取待转加工部门信息
    sCondition:='Current_Department = '+QuotedStr(Login.CurrentDepartment)+' AND FN_Card = ''N/A''';
    if Index = 1  then
    begin
      sSql := msPublic.GetSql();
      if msPublic.Execute and (sSql <> '') then
        sCondition := sSql + ' AND ' +sCondition
       else sCondition :='';
    end;
    if sCondition = '' then Exit;
    FNMServerObj.GetQueryData(vData,'GetStockInfo',sCondition,sErrorMsg);
//    FNMServerObj.GetStockInfo(vData,sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsUnSelect.Data := vData;
    cdsSelect.Data := vData;
    if cdsUnSelect.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有待转部门的坯布数据', 2);
      Exit;
    end;
    cdsUnSelect.Filtered := True;
    cdsSelect.Filtered := True;
  finally
    ShowMsg('', crDefault);
  end;
  GridDecorator.BindCxViewWithDataSource(cxdbgtvUnSelect, dsUnSelect);
  GridDecorator.BindCxViewWithDataSource(cxdbgtvSelect, dsSelect);
end;

procedure TChangeDepartmentForm.Add;
var i: Integer;
    sFabric_NO: string;
begin
  if (not cdsUnSelect.Active) or (cdsUnSelect.IsEmpty) then Exit;
  for i :=cxdbgtvUnSelect.Controller.SelectedRowCount - 1 downto 0 do
  begin
    with cxdbgtvUnSelect do
      sFabric_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Fabric_NO').Index];
    lstFabricNO.Items.Add(sFabric_NO);
  end;
  cdsUnSelect.Filtered := False;
  cdsUnSelect.Filtered := True;
  cdsSelect.Filtered := False;
  cdsSelect.Filtered := True;
end;

procedure TChangeDepartmentForm.Cancel;
var i,Index: Integer;
    sFabric_NO: string;
begin
  if (not cdsSelect.Active) or (cdsSelect.IsEmpty) then Exit;
  for i :=cxdbgtvSelect.Controller.SelectedRowCount - 1 downto 0 do
  begin
    with cxdbgtvSelect do
      sFabric_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Fabric_NO').Index];
    Index := lstFabricNO.Items.IndexOf(sFabric_NO);
    if Index <> -1 then
      lstFabricNO.Items.Delete(Index);
  end;
  cdsUnSelect.Filtered := False;
  cdsUnSelect.Filtered := True;
  cdsSelect.Filtered := False;
  cdsSelect.Filtered := True;
end;

procedure TChangeDepartmentForm.ChageStockDepartmentInfo();
var i: Integer;
   sCondition,sFabricNOList, sTransfer_Department,sNote_NO, sErrorMsg: WideString;
begin
  try
    ShowMsg('正在保存数据稍等！', crHourGlass);
    if cbbCurrentDept.Items.Count = 0 then Exit;
    if Trim(cbbCurrentDept.Text) = '' then
    begin
      TMsgDialog.ShowMsgDialog('请选择转向部门', 2);
      cbbCurrentDept.SetFocus;
      Exit;
    end;
    sTransfer_Department := LeftStr(cbbCurrentDept.Text, 2);
    if lstFabricNO.Items.Count = 0 then Exit;
   //变量赋值及保存卡号记录
    sFabricNOList := StringReplace(lstFabricNO.Items.Text,#13#10,',',[rfReplaceAll]);
    sCondition := QuotedStr(sFabricNOList)+',' + QuotedStr(sTransfer_Department)+','+ QuotedStr(Login.CurrentDepartment)+',' +
                 QuotedStr(Login.LoginName);
    FNMServerObj.SaveDataBySQLEx('ChangeStockDepartment',sCondition,sNote_NO,sErrorMsg);
  //  FNMServerObj.SaveSendInfo(sFabricNOList, sTransfer_Department, Login.CurrentDepartment, Login.LoginName,1,sNote_NO, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    for i := 0 to lstFabricNO.Items.Count -1 do
    begin
      cdsUnSelect.Filtered := False;
      while cdsUnSelect.Locate('Fabric_NO',lstFabricNO.Items[i],[]) do
        cdsUnSelect.Delete;
      cdsUnSelect.Filtered := True;
      cdsSelect.Filtered := False;
      while cdsSelect.Locate('Fabric_NO',lstFabricNO.Items[i],[]) do
        cdsSelect.Delete;
      cdsSelect.Filtered := True;
    end;
    lstFabricNO.Items.Clear;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
{      //打印送布单
  if not Assigned(SendInfoReport) then
    SendInfoReport :=  TSendInfoReport.Create(nil);
  SendInfoReport.PreviewReport(sNote_No);
}
end;


procedure TChangeDepartmentForm.SaveData();
begin
  ChageStockDepartmentInfo;
end;

procedure TChangeDepartmentForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize;
end;

procedure TChangeDepartmentForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TChangeDepartmentForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ChangeDepartmentForm := nil;
end;

procedure TChangeDepartmentForm.btnSaveClick(Sender: TObject);
begin
  SaveData();
end;

procedure TChangeDepartmentForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TChangeDepartmentForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetData(0);
end;

procedure TChangeDepartmentForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  GetData(1);
end;

procedure TChangeDepartmentForm.btnAddClick(Sender: TObject);
begin
  inherited;
  Add;
end;

procedure TChangeDepartmentForm.btnDownClick(Sender: TObject);
begin
  inherited;
  cxdbgtvUnSelect.DataController.SelectAll;
  Add;
end;

procedure TChangeDepartmentForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  Cancel;
end;

procedure TChangeDepartmentForm.btnUpClick(Sender: TObject);
begin
  inherited;
  cxdbgtvSelect.DataController.SelectAll;
  Cancel;
end;

procedure TChangeDepartmentForm.cxdbgtvUnSelectKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = vk_Return then
    Add;
end;

procedure TChangeDepartmentForm.cxdbgtvSelectKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = vk_Return then
    Cancel;
end;

procedure TChangeDepartmentForm.cdsUnSelectFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept := Pos(DataSet.FieldByName('Fabric_NO').AsString,lstFabricNO.Items.Text) = 0;
end;

procedure TChangeDepartmentForm.cdsSelectFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept := Pos(DataSet.FieldByName('Fabric_NO').AsString,lstFabricNO.Items.Text) > 0;
end;

end.

