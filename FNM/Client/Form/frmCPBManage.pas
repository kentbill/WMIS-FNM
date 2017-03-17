unit frmCPBManage;
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
  TCPBManageForm = class(TBaseForm)
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
    rgType: TRadioGroup;
    lbSigner: TLabel;
    edtSigner: TEdit;
    pnlSend: TPanel;
    lbSendCount: TLabel;
    edtSendCount: TEdit;
    Label1: TLabel;
    edtPrintTimes: TEdit;
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
    procedure rgTypeClick(Sender: TObject);
  private
    { Private declarations }
    sKeyName: string;
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
    procedure PublicSave; override;
  end;
var
  CPBManageForm: TCPBManageForm;

implementation

uses ServerDllPub, uGlobal, uShowMessage, uLogin, uGridDecorator,
  uAppOption,uDictionary,uCADInfo;

{$R *.dfm}

procedure TCPBManageForm.UpdateActions;
begin
  inherited;
  sKeyName := 'Pattern_ID';
  btnSave.Enabled := ItemList.Count > 0;
  btnAdd.Enabled := cxdbgtvUnSelect.Controller.SelectedRowCount > 0;
  btnDown.Enabled := not cdsUnSelect.IsEmpty;
  btnCancel.Enabled := cxdbgtvSelect.Controller.SelectedRowCount > 0;
  btnUp.Enabled := not cdsSelect.IsEmpty;
  lbSigner.Visible := rgType.ItemIndex = 1;
  edtSigner.Visible := rgType.ItemIndex = 1;
  pnlSend.Visible := rgType.ItemIndex = 1;
end;

procedure TCPBManageForm.PublicQuery;
begin
  GetData;
end;

procedure TCPBManageForm.PublicSave;
begin
  SaveData;
end;

procedure TCPBManageForm.Initialize;
begin
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnAdd.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnDown.Glyph.LoadFromResourceName(HInstance, RES_DOWNALL);
  btnCancel.Glyph.LoadFromResourceName(HInstance, RES_UP);
  btnUp.Glyph.LoadFromResourceName(HInstance, RES_UPALL);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  ItemList := TStringList.Create;
  ItemList.Clear;
  cxdbgtvSelect.OnDblClick := TGlobal.DblClickAWinControl;
  cxdbgtvUnSelect.OnDblClick := TGlobal.DblClickAWinControl;
  SetWindowLong(edtPrintTimes.Handle, GWL_STYLE, GetWindowLong(edtPrintTimes.Handle, GWL_STYLE) or ES_NUMBER);
  SetWindowLong(edtSendCount.Handle, GWL_STYLE, GetWindowLong(edtSendCount.Handle, GWL_STYLE) or ES_NUMBER);  
end;    

procedure TCPBManageForm.GetData;
var i: Integer;
    vData: OleVariant;
    sQueryCon,sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    if rgType.ItemIndex = 0  then
      sQueryCon := QuotedStr(login.CurrentDepartment)+','+ IntTostr(8)
    else
      sQueryCon := QuotedStr(login.CurrentDepartment)+','+ IntTostr(9);
    FNMServerObj.GetQueryData(vData,'CPBGetTask',sQueryCon,sErrorMsg);
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
    GridDecorator.HideFields(cxdbgtvSelect,['Pattern_ID']);
    GridDecorator.BindCxViewWithDataSource(cxdbgtvUnSelect, dsUnSelect,True);
    GridDecorator.HideFields(cxdbgtvUnSelect,['Pattern_ID']);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBManageForm.SaveData;
var
  sItemStr, sSaveCon, sErrorMsg: WideString;
  i: integer;
begin
  try
    ShowMsg('正在保存数据稍等！', crHourGlass);
    if ItemList.Count = 0 then Exit;
    if rgType.ItemIndex = 0 then
    begin
      sItemStr := StringReplace(ItemList.Text,#13#10,',',[rfReplaceAll]);
      sSaveCon:= QuotedStr(sItemStr)+','+QuotedStr('')+','+ QuotedStr(Login.CurrentDepartment) + ',' + QuotedStr(Login.LoginID)+',1';
    end else
    begin
      if edtSigner.Text = '' then
      begin
        TMsgDialog.ShowMsgDialog('请填写签收人', mtWarning);
        edtSigner.SetFocus;
        Exit;
      end;
      sItemStr := '';
      with cdsSelect do
      begin
        First;
        while not Eof do
        begin
          sItemStr := sItemStr + FieldByName('Pattern_ID').AsString + '@'+FieldByName('Print_Times').AsString+ '#'+FieldByName('Send_Count').AsString;
          Next;
        end;
      end;
      sSaveCon:= QuotedStr(sItemStr)+','+QuotedStr(edtSigner.Text)+','+ QuotedStr(Login.CurrentDepartment) + ',' + QuotedStr(Login.LoginID)+',2';
    end;
    FNMServerObj.SaveDataBySQL('CPBManageInfo',sSaveCon,sErrorMsg);
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
    ItemList.Clear;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBManageForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCPBManageForm.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ItemList);
  CPBManageForm := nil;
end;

procedure TCPBManageForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetData;
end;

procedure TCPBManageForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData;
end;

procedure TCPBManageForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize;
end;

procedure TCPBManageForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCPBManageForm.Add;
var i: Integer;
    sItemNO: string;
begin
  if (not cdsUnSelect.Active) or (cdsUnSelect.IsEmpty) then Exit;
  for i :=cxdbgtvUnSelect.Controller.SelectedRowCount - 1 downto 0 do
  begin
    with cxdbgtvUnSelect do
      sItemNO := Controller.SelectedRows[i].Values[GetColumnByFieldName(sKeyName).Index];
    ItemList.Add(sItemNO);
    cdsUnSelect.Filtered := False;
    cdsUnSelect.Filtered := True;
    cdsSelect.Filtered := False;
    cdsSelect.Filtered := True;
    if (rgType.ItemIndex = 1) and (cdsSelect.FieldList.Find('Send_Count') <> nil) then
    begin
      if cdsSelect.Locate(sKeyName,sItemNO,[]) then
      begin
        cdsSelect.Edit;
        cdsSelect.FieldByName('Send_Count').AsInteger := StrToInt(edtSendCount.Text);
        cdsSelect.FieldByName('Print_Times').AsInteger := StrToInt(edtPrintTimes.Text);
      end;
    end;
  end;
end;

procedure TCPBManageForm.Cancel;
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

procedure TCPBManageForm.cdsUnSelectFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept := Pos(DataSet.FieldByName(sKeyName).AsString,ItemList.Text) = 0;
end;

procedure TCPBManageForm.cdsSelectFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept := Pos(DataSet.FieldByName(sKeyName).AsString,ItemList.Text) > 0;
end;

procedure TCPBManageForm.btnAddClick(Sender: TObject);
begin
  inherited;
  Add;
end;

procedure TCPBManageForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  Cancel;
end;

procedure TCPBManageForm.btnDownClick(Sender: TObject);
begin
  inherited;
  cxdbgtvUnSelect.DataController.SelectAll;
  Add;
end;

procedure TCPBManageForm.btnUpClick(Sender: TObject);
begin
  inherited;
  cxdbgtvSelect.DataController.SelectAll;
  Cancel;
end;

procedure TCPBManageForm.cxdbgtvUnSelectKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
   if key = vk_Return then
    Add;
end;

procedure TCPBManageForm.cxdbgtvSelectKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = vk_Return then
    Cancel;
end;

procedure TCPBManageForm.cxdbgtvUnSelectCustomDrawCell(
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

procedure TCPBManageForm.cxdbgtvSelectCustomDrawCell(
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

procedure TCPBManageForm.rgTypeClick(Sender: TObject);
begin
  inherited;
 if cdsSelect.Active then
    cdsSelect.EmptyDataSet;
 if cdsUnSelect.Active then
    cdsUnSelect.EmptyDataSet;
end;

end.
