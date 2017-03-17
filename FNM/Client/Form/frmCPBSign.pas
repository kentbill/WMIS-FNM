unit frmCPBSign;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmCPBManage.pas                                          }
{       创建日期 2004-8-26 16:20:05                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述 送布前工艺CHECK                                               }
{                                                                              }
{******************************************************************************}


interface

uses
  uFNMResource, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,Dialogs, frmBase, StdCtrls, ExtCtrls, OleCtrls, Buttons,
  DB, DBClient, ComCtrls, StrUtils, GFCADLib_TLB, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter, CheckLst, Math;

type
  TCPBSignForm = class(TBaseForm)
    pnlLeft: TPanel;
    pnlCard: TPanel;
    pnl2: TPanel;
    btnAdd: TSpeedButton;
    btnUp: TSpeedButton;
    btnCancel: TSpeedButton;
    btnDown: TSpeedButton;
    cxSplitter1: TcxSplitter;
    cxdbgUnSelect: TcxGrid;
    cxdbgtvUnSelect: TcxGridDBTableView;
    cxGridlUnSelect: TcxGridLevel;
    cdsUnSelect: TClientDataSet;
    dsUnSelect: TDataSource;
    cdsSelect: TClientDataSet;
    dsSelect: TDataSource;
    cxdbgSelect: TcxGrid;
    cxdbgtvSelect: TcxGridDBTableView;
    cxGridlSelect: TcxGridLevel;
    pnlTop: TPanel;
    btnRefresh: TSpeedButton;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    Label13: TLabel;
    edtRCP: TEdit;
    btnExport: TSpeedButton;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cdsUnSelectFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure cxdbgtvUnSelectKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxdbgtvSelectKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsSelectFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure cxdbgtvUnSelectCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxdbgtvSelectCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnExportClick(Sender: TObject);
  private
    { Private declarations }
    sKeyName: string;
    sQueryType: string;
    sQueryCon: string;
    sSaveType: string;
    sSaveCon: string;
    ItemList: TStringList;
    procedure Initialize;
    procedure Add;
    procedure Cancel;
    procedure GetData;
    procedure SaveData;
  protected
    procedure UpdateActions; override;
  public
    { Public declarations }
    procedure PublicQuery; override;
    procedure PublicExport; override;
    procedure PublicSave; override;
  end;
var
  CPBSignForm: TCPBSignForm;

implementation

uses ServerDllPub, uGlobal, uShowMessage, uLogin, uGridDecorator,
  uAppOption,uDictionary,uCADInfo;

{$R *.dfm}

procedure TCPBSignForm.UpdateActions;
var sItemStr: string;
begin
  inherited;
  sKeyName := 'Recipe_NO';
  sQueryType := 'CPBGetTask';
  //打板签收   sQueryCon := QuotedStr(login.CurrentDepartment)+','+ IntTostr(7);
  //导出到吸料机
  sQueryCon := QuotedStr(login.CurrentDepartment)+','+ IntTostr(12);
  sSaveType := 'CPBCheckRecipe';
  sItemStr := StringReplace(ItemList.Text,#13#10,',',[rfReplaceAll]);
  //打板签收   sSaveCon:= QuotedStr(sItemStr)+',0,'''','''','''','''','''''+',2,'+ QuotedStr(Login.CurrentDepartment) + ',' + QuotedStr(Login.LoginID)+',0';
  //导出到吸料机
  sSaveCon:= QuotedStr(sItemStr)+',0,'''','''','''','''','''''+',2,' +
             QuotedStr(Login.CurrentDepartment) + ',' + QuotedStr(Login.LoginID)+',4';
  btnSave.Enabled := ItemList.Count > 0;
  btnAdd.Enabled := cxdbgtvUnSelect.Controller.SelectedRowCount > 0;
  btnDown.Enabled := btnAdd.Enabled;
  btnCancel.Enabled := cxdbgtvSelect.Controller.SelectedRowCount > 0;
  btnUp.Enabled := btnCancel.Enabled;
end;

procedure TCPBSignForm.PublicQuery;
begin
  GetData;
end;

procedure TCPBSignForm.PublicExport;
begin
end;

procedure TCPBSignForm.PublicSave;
begin
  SaveData;
end;

procedure TCPBSignForm.Initialize;
begin
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnAdd.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnDown.Glyph.LoadFromResourceName(HInstance, RES_DOWNALL);
  btnCancel.Glyph.LoadFromResourceName(HInstance, RES_UP);
  btnUp.Glyph.LoadFromResourceName(HInstance, RES_UPALL);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_EXOPRTFILE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  ItemList := TStringList.Create;
  ItemList.Clear;
  cxdbgtvSelect.OnDblClick := TGlobal.DblClickAWinControl;
  cxdbgtvUnSelect.OnDblClick := TGlobal.DblClickAWinControl;
end;    

procedure TCPBSignForm.GetData;
var vData: OleVariant;
    sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    FNMServerObj.GetQueryData(vData,sQueryType,sQueryCon,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsUnSelect.Data := vData;
    if cdsUnSelect.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有待签收的色号信息!',mtInformation);
      Exit;
    end;
    ItemList.Clear;
    cdsSelect.Data := vData;
    cdsUnSelect.Filtered := True;
    cdsSelect.Filtered := True;
    GridDecorator.BindCxViewWithDataSource(cxdbgtvSelect, dsSelect,True);
    GridDecorator.BindCxViewWithDataSource(cxdbgtvUnSelect, dsUnSelect);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBSignForm.SaveData;
var
  sErrorMsg: WideString;
  i: integer;
begin
  if FileExists('\\GEW195399\Transfer\CPB.rcp') then
  begin
    ShowMessage('滴料系统正在转档,请【10秒】后再操作,谢谢！');
    Exit;
  end;

  try
    ShowMsg('正在保存数据稍等！', crHourGlass);
    if ItemList.Count = 0 then Exit;
    FNMServerObj.SaveDataBySQL(sSaveType,sSaveCon,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    for i := 0 to ItemList.Count -1 do
    begin
      cxdbgtvSelect.DataController.BeginUpdate;
      cdsUnSelect.Filtered := False;
      while cdsUnSelect.Locate(sKeyName,ItemList.Strings[i],[]) do
        cdsUnSelect.Delete;
      cdsUnSelect.Filtered := True;
      cdsSelect.Filtered := False;
      while cdsSelect.Locate(sKeyName,ItemList.Strings[i],[]) do
        cdsSelect.Delete;
      cdsSelect.Filtered := True;
      cxdbgtvSelect.DataController.EndUpdate;
    end;
    //
    TGlobal.GenerateRCPFile(StringReplace(ItemList.Text,#13#10,',',[rfReplaceAll]));
    //
    ItemList.Clear;
    TMsgDialog.ShowMsgDialog('保存/导出数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBSignForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCPBSignForm.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ItemList);
  CPBSignForm := nil;
end;

procedure TCPBSignForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetData;
end;

procedure TCPBSignForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData;
end;

procedure TCPBSignForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize;
end;

procedure TCPBSignForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCPBSignForm.Add;
var i: Integer;
    sItemNO: string;
begin
  if (not cdsUnSelect.Active) or (cdsUnSelect.IsEmpty) then Exit;
  for i :=cxdbgtvUnSelect.Controller.SelectedRowCount - 1 downto 0 do
  begin
    with cxdbgtvUnSelect do
      sItemNO := Controller.SelectedRows[i].Values[GetColumnByFieldName(sKeyName).Index];
    ItemList.Add(sItemNO);
  end;
  cdsUnSelect.Filtered := False;
  cdsUnSelect.Filtered := True;
  cdsSelect.Filtered := False;
  cdsSelect.Filtered := True;
end;

procedure TCPBSignForm.Cancel;
var i,Index: Integer;
    sItemNO: string;
begin
  if (not cdsSelect.Active) or (cdsSelect.IsEmpty) then Exit;
  for i :=cxdbgtvSelect.Controller.SelectedRowCount - 1 downto 0 do
  begin
    with cxdbgtvSelect do
      sItemNO := Controller.SelectedRows[i].Values[GetColumnByFieldName(sKeyName).Index];
    Index := ItemList.IndexOf(sItemNO);
    if Index <> -1 then
      ItemList.Delete(Index);
  end;
  cdsUnSelect.Filtered := False;
  cdsUnSelect.Filtered := True;
  cdsSelect.Filtered := False;
  cdsSelect.Filtered := True;
end;

procedure TCPBSignForm.cdsUnSelectFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept := Pos(DataSet.FieldByName(sKeyName).AsString,ItemList.Text) = 0;
end;

procedure TCPBSignForm.cdsSelectFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept := Pos(DataSet.FieldByName(sKeyName).AsString,ItemList.Text) > 0;
end;

procedure TCPBSignForm.btnAddClick(Sender: TObject);
begin
  inherited;
  Add;
end;

procedure TCPBSignForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  Cancel;
end;

procedure TCPBSignForm.btnDownClick(Sender: TObject);
begin
  inherited;
  cxdbgtvUnSelect.DataController.SelectAll;
  Add;
end;

procedure TCPBSignForm.btnUpClick(Sender: TObject);
begin
  inherited;
  cxdbgtvSelect.DataController.SelectAll;
  Cancel;
end;

procedure TCPBSignForm.cxdbgtvUnSelectKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
   if key = vk_Return then
    Add;
end;

procedure TCPBSignForm.cxdbgtvSelectKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = vk_Return then
    Cancel;
end;

procedure TCPBSignForm.cxdbgtvUnSelectCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var col :Integer;
begin
  inherited;
  col := TcxGridDBTableView(Sender).GetColumnByFieldName('RGB').Index;
  if AViewInfo.Item.Caption = 'RGB' then
  begin
    ACanvas.Brush.Color := AViewInfo.GridRecord.Values[col];
    ACanvas.Font.Color := AViewInfo.GridRecord.Values[col];
  end;
end;

procedure TCPBSignForm.cxdbgtvSelectCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var col: Integer;
begin
  inherited;
  col := TcxGridDBTableView(Sender).GetColumnByFieldName('RGB').Index;
  if AViewInfo.Item.Caption = 'RGB' then
  begin
    ACanvas.Brush.Color := AViewInfo.GridRecord.Values[col];
    ACanvas.Font.Color := AViewInfo.GridRecord.Values[col];
  end;
end;

procedure TCPBSignForm.btnExportClick(Sender: TObject);
begin
  inherited;
  if Trim(edtRCP.Text) <> '' then
  begin
    TGlobal.GenerateRCPFile(edtRCP.Text);
    edtRCP.Clear;
    TMsgDialog.ShowMsgDialog('导入吸料机成功',mtInformation);
  end;  
end;

end.
