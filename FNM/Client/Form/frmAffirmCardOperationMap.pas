unit frmAffirmCardOperationMap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxTextEdit, cxCheckBox, cxDBEdit,
  cxContainer, cxMaskEdit, cxDropDownEdit, Buttons, StdCtrls, ExtCtrls,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxControls, cxGridCustomView, cxGrid, DBClient, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox;

type
  TAffirmCardOperationMapForm = class(TBaseForm)
    pnl_Only: TPanel;
    lbl1: TLabel;
    btn_Query: TSpeedButton;
    btnSave: TSpeedButton;
    btn_Exit: TSpeedButton;
    btnCancel: TSpeedButton;
    cxdbcbIsActive: TcxDBCheckBox;
    cdsMap: TClientDataSet;
    dsMap: TDataSource;
    Label1: TLabel;
    cxdblcmWorker: TcxDBLookupComboBox;
    cdsWorker: TClientDataSet;
    dsWorker: TDataSource;
    cdsOperation: TClientDataSet;
    dsOperation: TDataSource;
    cxdblcmOperation: TcxDBLookupComboBox;
    cxgrdMap: TcxGrid;
    cxgrdlvlGridlMap: TcxGridLevel;
    cxgridtvMap: TcxGridDBTableView;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_QueryClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure cdsMapAfterPost(DataSet: TDataSet);
  private
    { Private declarations }      
    procedure SetBtnState;
    procedure DataRefresh;
    procedure DataSave;
    procedure DataCancel;
    procedure DataQuery;
    function CloseQuery:Boolean;
  public
    { Public declarations }
  end;

var
  AffirmCardOperationMapForm: TAffirmCardOperationMapForm;

implementation
                
uses ServerDllPub, uGlobal, uShowMessage, uLogin, uGridDecorator, uFNMArtInfo,
  uDictionary;
{$R *.dfm}

function TAffirmCardOperationMapForm.CloseQuery: Boolean;
begin
  if not TGlobal.DeltaIsNull(cdsMap) then
  begin
    if TMsgDialog.ShowMsgDialog('数据未保存，是否保存！', mtConfirmation, [mebYes, mebNo], mebYes)= mrNo then
      Result := false;
  end
  else
    Result := False;
end;

procedure TAffirmCardOperationMapForm.DataCancel;
begin
  cdsMap.CancelUpdates;
end;

procedure TAffirmCardOperationMapForm.DataQuery;
begin

end;

procedure TAffirmCardOperationMapForm.DataRefresh;
var
  vData:OleVariant;
  sErrMsg:WideString;
begin
  try
    ShowMsg('正在查询稍等！', crHourGlass);

    FNMServerObj.GetBaseTableInfo(vData, 'fnAffirmCardOperationMapList', sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;

    cdsWorker.Data := Dictionary.cds_WorkerList.Data;
    if cdsWorker.IsEmpty then Exit;
                                   
    cdsOperation.Data := Dictionary.cds_OperationHdrList.Data;
    if cdsOperation.IsEmpty then Exit;

    cxdblcmWorker.Properties.ListSource := dsWorker;
    cxdblcmWorker.Properties.KeyFieldNames := 'Worker_ID';
    cxdblcmWorker.Properties.ListFieldNames := 'Worker_Name';

    FNMServerObj.GetBaseTableInfo(vData,'fnAffirmCardOperationMapList',sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
      Exit;
    end;
    cdsMap.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxgridtvMap, dsMap);
  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TAffirmCardOperationMapForm.DataSave;
var
  vData: OleVariant;
  sErrMsg: WideString;
begin
  try
    ShowMsg('', crHourGlass);
    if TGlobal.DeltaIsNull(cdsMap) then Exit;

    //保存数据
    vData := cdsMap.Delta;
    FNMServerObj.SaveBaseTableInfo(vData, 'uvw_fnAffirmCardOperationMapList', 'Dept,Operation_Code', sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsMap.MergeChangeLog;
    TMsgDialog.ShowMsgDialog('保存成功!',mtInformation);
  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TAffirmCardOperationMapForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;

procedure TAffirmCardOperationMapForm.FormCreate(Sender: TObject);
begin
  inherited;
  DataRefresh;
end;

procedure TAffirmCardOperationMapForm.FormDestroy(Sender: TObject);
begin
  inherited;
  AffirmCardOperationMapForm := nil;
end;

procedure TAffirmCardOperationMapForm.SetBtnState;
begin      
  btnCancel.Enabled := not TGlobal.DeltaIsNull(cdsMap);
  btnSave.Enabled := btnCancel.Enabled;
  cxdblcmWorker.Enabled := not cdsMap.IsEmpty;
  //cxdblcmOperation.Enabled := cxdblcmWorker.Enabled;
end;

procedure TAffirmCardOperationMapForm.btn_QueryClick(Sender: TObject);
begin
  inherited;
  DataRefresh;
end;

procedure TAffirmCardOperationMapForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  cdsMap.CancelUpdates;
end;

procedure TAffirmCardOperationMapForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  DataSave;
end;

procedure TAffirmCardOperationMapForm.btn_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TAffirmCardOperationMapForm.cdsMapAfterPost(DataSet: TDataSet);
begin
  inherited;
  SetBtnState;
end;

end.


