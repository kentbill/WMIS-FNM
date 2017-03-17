unit frmBaseData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxContainer, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, StdCtrls, Buttons, ExtCtrls, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBClient;

type
  TBaseDataForm = class(TBaseForm)
    cdsTable: TClientDataSet;
    dsTable: TDataSource;
    cxgtvTable: TcxGridDBTableView;
    cxglvTable: TcxGridLevel;
    cxg1: TcxGrid;
    pnl_Only: TPanel;
    btnQuery: TSpeedButton;
    btnSave: TSpeedButton;
    btn_Exit: TSpeedButton;
    btnDelete: TSpeedButton;
    btnAdd: TSpeedButton;
    btnCancel: TSpeedButton;
    cbbTableName: TcxComboBox;
    cdsTableName: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure cxgtvTableFocusedItemChanged(Sender: TcxCustomGridTableView;
      APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    sTableName, sKey:WideString;
    procedure DataSave;
    procedure DataCancel;
    procedure DataQuery;
    procedure GetTableList;
    function CloseQuery:Boolean;
    procedure SetBtnState;
    procedure UpdateActions; override;
  public
    { Public declarations }

  end;

var
  BaseDataForm: TBaseDataForm;

implementation

uses ServerDllPub, uFNMArtInfo, uGlobal, uDictionary, uShowMessage, uLogin, uGridDecorator;

{$R *.dfm}

{ TBaseDataForm }

function TBaseDataForm.CloseQuery: Boolean;
begin
  if not TGlobal.DeltaIsNull(cdsTable) then
  begin
    if TMsgDialog.ShowMsgDialog('数据未保存，是否保存！', mtConfirmation, [mebYes, mebNo], mebYes)= mrYes then
      Result := False;
  end
  else
    Result := True;
end;

procedure TBaseDataForm.DataCancel;
begin
  if cdsTable.Active then
  begin
    cdsTable.CancelUpdates;  
    SetBtnState;
  end;
end;

procedure TBaseDataForm.DataQuery;
var
  vData: OleVariant;
  sErrMsg: WideString;
begin
  try
    if not CloseQuery then Exit;

    if cdsTableName.locate('Table_CHN', cbbTableName.Text,[]) then
    begin
      sTableName := QuotedStr(cdsTableName.FieldByName('Table_Name').AsString);
      sKey := cdsTableName.FieldByName('Key_Fields').AsString;
    end;
    if sTableName= '' then Exit;

    FNMServerObj.GetBaseTableInfo(vData, sTableName, sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;

    cdsTable.Data := vData;

    BaseForm.Caption := '字典维护 【'+  cbbTableName.Text+ '】';
    cxg1.SetFocus;
    GridDecorator.BindCxViewWithDataSource(cxgtvTable, dsTable, true);
    //GridDecorator.SetcxTableView(cxgtvTable, ['Operator','Operate_Time','Dept'],[], False);
  finally
    SetBtnState;
  end;
end;

procedure TBaseDataForm.DataSave;
var
  vData: OleVariant;
  sErrMsg: WideString;
begin
  try
    ShowMsg('正在保存。。。', crHourGlass);
    if TGlobal.DeltaIsNull(cdsTable) then Exit;

    //保存数据
    vData := cdsTable.Delta;

    FNMServerObj.SaveBaseTableInfo(vData, sTableName, sKey, sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsTable.MergeChangeLog;

  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TBaseDataForm.GetTableList;
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
begin
  try
    sSQL := QuotedStr(login.CurrentDepartment);
    FNMServerObj.GetQueryData(vData, 'fnGetBaseTableName', sSQL, sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsTableName.Data := vData;
    FillItemsFromDataSet(cdsTableName,'Table_CHN','','','',cbbTableName.Properties.Items);
  finally
    SetBtnState;
  end;
end;

procedure TBaseDataForm.SetBtnState;
begin
  btnQuery.Enabled := cbbTableName.Text<>'';
  btnSave.Enabled := not TGlobal.DeltaIsNull(cdsTable);
  btnDelete.Enabled := not cdsTable.IsEmpty;
  btnAdd.Enabled := cdsTable.Active;
  btnCancel.Enabled := btnSave.Enabled;
end;

procedure TBaseDataForm.UpdateActions;
begin
  inherited;

end;

procedure TBaseDataForm.FormCreate(Sender: TObject);
begin
  inherited;
  GetTableList;
end;

procedure TBaseDataForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  DataQuery;
end;

procedure TBaseDataForm.btnAddClick(Sender: TObject);
begin
  inherited;
  cdsTable.Append;
end;

procedure TBaseDataForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  DataSave;
end;

procedure TBaseDataForm.btnDeleteClick(Sender: TObject);
begin
  inherited;
  cdsTable.Delete;
end;

procedure TBaseDataForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  DataCancel;
end;

procedure TBaseDataForm.btn_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TBaseDataForm.cxgtvTableFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  SetBtnState;
end;

procedure TBaseDataForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TBaseDataForm.FormDestroy(Sender: TObject);
begin
  inherited;
  BaseDataForm := nil;
end;

procedure TBaseDataForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := CloseQuery;
end;

end.


