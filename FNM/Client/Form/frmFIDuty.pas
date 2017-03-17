unit frmFIDuty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, cxContainer, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, StdCtrls, Buttons, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ExtCtrls;

type
  TFIDutyForm = class(TBaseForm)
    pnlTools: TPanel;
    grpWorkerPrize: TGroupBox;
    cxgridFIDuty: TcxGrid;
    cxgridtvFIDuty: TcxGridDBTableView;
    cxGridlFIDuty: TcxGridLevel;
    grp1: TGroupBox;
    cxgridfnFIDuty: TcxGrid;
    cxgridtvfnFIDuty: TcxGridDBTableView;
    cxGridlfnFIDuty: TcxGridLevel;
    pnl1: TPanel;
    btnAdd: TSpeedButton;
    btnDelete: TSpeedButton;
    btnUndo: TSpeedButton;
    btnSave: TSpeedButton;
    btnExit: TSpeedButton;
    btnFilter: TSpeedButton;
    cxdeBeginTime: TcxDateEdit;
    lbl1: TLabel;
    cxdeEndTime: TcxDateEdit;
    btnAuto: TSpeedButton;
    btnQuery: TSpeedButton;
    cdsFIDuty: TClientDataSet;
    dsFIDuty: TDataSource;
    dsfnFIDuty: TDataSource;
    lbl2: TLabel;
    cdsfnFIDuty: TClientDataSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure InitForm;
    procedure DataAdd;
    procedure DataCancel;
    procedure DataDelete;
    procedure DataQuery(sQueryType:String);
    procedure DataSave;
    procedure AutoDistribute;
    procedure SetBtnState;
    function CloseQuery:Boolean;
    procedure btnQueryClick(Sender: TObject);
    procedure btnAutoClick(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnUndoClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cdsFIDutyAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FIDutyForm: TFIDutyForm;

implementation

uses ServerDllPub, UShowMessage, uLogin, UAppOption, UGridDecorator, uGlobal;
{$R *.dfm}

procedure TFIDutyForm.DataAdd;
begin
  cdsfnFIDuty.FieldByName('Fabric_NO').ReadOnly := false;
  cdsfnFIDuty.Append;
  cdsfnFIDuty.FieldByName('Fabric_NO').AsString := cdsFIDuty.FieldByName('Fabric_NO').AsString;
  cdsfnFIDuty.Post;
  cdsfnFIDuty.FieldByName('Fabric_NO').ReadOnly := True;
  SetBtnState;
end;

procedure TFIDutyForm.DataDelete;
begin
  if cdsfnFIDuty.IsEmpty then Exit;
  cdsfnFIDuty.Delete;
  SetBtnState;
end;

procedure TFIDutyForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFIDutyForm.FormCreate(Sender: TObject);
begin
  inherited;
  InitForm;
end;

procedure TFIDutyForm.FormDestroy(Sender: TObject);
begin
  inherited;
  FIDutyForm := nil;
end;

procedure TFIDutyForm.InitForm;
begin
  cxdeEndTime.Date := Date;
  cxdeBeginTime.Date := Date-1;
  SetBtnState;
end;

procedure TFIDutyForm.DataQuery(sQueryType: String);
var
  vData: Olevariant;
  sType, sErrorMsg: WideString;
  sCondition: string;
begin
  try
    //保存数据
    if CloseQuery then
      DataSave;

    ShowMsg('正在获取数据稍等...', crHourGlass);

    cdsfnFIDuty.DisableControls;
    cdsFIDuty.DisableControls;

    if sQueryType= 'All' then      //返回两个数据集
    begin
      sType := 'D';
    end
    else if sQueryType= 'Filter' then //返回未成功分配的
    begin
      sType := 'Fail';
    end
    else if sQueryType= 'FI' then   //成品错项
    begin
      sType := 'FI';
    end
    else if sQueryType= 'FN' then   //后整错项
    begin
      sType := 'FN';
    end;

    sCondition := QuotedStr(sType)+','+ QuotedStr(cxdeBeginTime.Text)+ ','
                  + QuotedStr(cxdeEndTime.Text);

    FNMServerObj.GetQueryData(vData, 'FIDutyPointsQuery', sCondition, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    cdsFIDuty.AfterScroll := nil;
    cdsFIDuty.Data := vData[0];
    cdsfnFIDuty.Data:=vData[1];

    GridDecorator.BindCxViewWithDataSource(cxgridtvFIDuty,dsFIDuty);
    GridDecorator.BindCxViewWithDataSource(cxgridtvfnFIDuty,dsfnFIDuty);
    cdsfnFIDuty.FieldByName('Fabric_NO').ReadOnly := True;
  finally
    cdsfnFIDuty.EnableControls;
    cdsFIDuty.EnableControls;
    cdsFIDuty.AfterScroll := cdsFIDutyAfterScroll;
    cdsFIDuty.First;
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TFIDutyForm.DataSave;
var
  vData: Olevariant;
  sErrorMsg: WideString;
begin
  if cdsfnFIDuty.State in [dsEdit] then
    cdsfnFIDuty.Post;

  if TGlobal.DeltaIsNull(cdsfnFIDuty) then exit;

  try
    cdsfnFIDuty.DisableControls;
    ShowMsg('正在保存...', crHourGlass);

    vData := cdsfnFIDuty.Delta;

    FNMServerObj.SaveData('FIDutyPoints', vData, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    cdsfnFIDuty.MergeChangeLog;
  finally
    cdsfnFIDuty.EnableControls;
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TFIDutyForm.SetBtnState;
begin
  btnAdd.Enabled := not cdsFIDuty.IsEmpty;
  btnDelete.Enabled := not cdsfnFIDuty.IsEmpty;
  btnSave.Enabled := not TGlobal.DeltaIsNull(cdsfnFIDuty);
  btnUndo.Enabled := btnSave.Enabled;
end;

procedure TFIDutyForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  DataQuery('All');
end;

procedure TFIDutyForm.btnAutoClick(Sender: TObject);
begin
  inherited;
  AutoDistribute;
end;

procedure TFIDutyForm.btnFilterClick(Sender: TObject);
begin
  inherited;
  DataQuery('Filter');
end;

procedure TFIDutyForm.btnAddClick(Sender: TObject);
begin
  inherited;
  DataAdd;
end;

procedure TFIDutyForm.btnDeleteClick(Sender: TObject);
begin
  inherited;
  DataDelete;
end;

procedure TFIDutyForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  DataSave;
end;

procedure TFIDutyForm.btnUndoClick(Sender: TObject);
begin
  inherited;
  DataCancel;
end;

procedure TFIDutyForm.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFIDutyForm.AutoDistribute;
var
  vData: Olevariant;
  sCondition, sErrorMsg: WideString;
begin
  try
    //保存数据
    if CloseQuery then
      DataSave;
      
    ShowMsg('正在自动分配稍等...', crHourGlass);

    sCondition := QuotedStr(cxdeBeginTime.Text)+ ',' + QuotedStr(cxdeEndTime.Text);
    //自动分配
    FNMServerObj.GetQueryData(vData, 'FIDutyPointsAutoDistribute', sCondition, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    //返回结果
    DataQuery('All');
  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TFIDutyForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := not CloseQuery;
end;

function TFIDutyForm.CloseQuery:Boolean;
begin
  if not TGlobal.DeltaIsNull(cdsfnFIDuty) then
  begin
    if TMsgDialog.ShowMsgDialog('数据未保存，是否保存！', mtConfirmation, [mebYes, mebNo], mebYes)= mrNo then
      Result := false;
  end
  else
    Result := False;
end;

procedure TFIDutyForm.cdsFIDutyAfterScroll(DataSet: TDataSet);
begin
  inherited;
  cdsfnFIDuty.Filtered := False;
  cdsfnFIDuty.Filter := 'Fabric_NO='+QuotedStr(DataSet.FieldByName('Fabric_NO').AsString);
  cdsfnFIDuty.Filtered := True;
end;

procedure TFIDutyForm.DataCancel;
begin
  if TGlobal.DeltaIsNull(cdsfnFIDuty) then Exit;
  cdsfnFIDuty.CancelUpdates;
  SetBtnState;
end;

end.
