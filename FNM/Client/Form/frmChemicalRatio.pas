unit frmChemicalRatio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxMaskEdit, cxSpinEdit, cxDBEdit, cxTextEdit,
  cxContainer, cxLabel, ADODB, ExtCtrls, StdCtrls, Buttons, cxCheckBox;

type
  TChemicalRatioForm = class(TBaseForm)
    cxgridtvRatio: TcxGridDBTableView;
    cxGridlRatio: TcxGridLevel;
    cxgridRatio: TcxGrid;
    dsRatio: TDataSource;
    cdsRatio: TClientDataSet;
    pnl1: TPanel;
    cxl1: TcxLabel;
    cxdbteName: TcxDBTextEdit;
    cxdbseRatio: TcxDBSpinEdit;
    cxl2: TcxLabel;
    cxl3: TcxLabel;
    cxl4: TcxLabel;
    cxdbteSTDName: TcxDBTextEdit;
    cxdbteShortName: TcxDBTextEdit;
    cxl5: TcxLabel;
    cxdbteOracleName: TcxDBTextEdit;
    cxl6: TcxLabel;
    cxl7: TcxLabel;
    cxdbteOperator: TcxDBTextEdit;
    cxdbteOperateTime: TcxDBTextEdit;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Refresh: TBitBtn;
    btnCancel: TBitBtn;
    cxdbteID: TcxDBTextEdit;
    cxcbAll: TcxCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure cxdbseRatioExit(Sender: TObject);
    procedure pnl1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cxcbAllPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    sID: String;
    procedure SetBtnState;
    procedure DataRefresh;
    procedure DataSave;
    procedure DataCancel;
    procedure DataModify;
    function CloseQuery:Boolean;
  public
    { Public declarations }
  end;

var
  ChemicalRatioForm: TChemicalRatioForm;

implementation

uses ServerDllPub, uLogin, uShowMessage, uGlobal, uGridDecorator;

{$R *.dfm}

procedure TChemicalRatioForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TChemicalRatioForm.FormCreate(Sender: TObject);
begin
  inherited;
  DataRefresh;
end;

procedure TChemicalRatioForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ChemicalRatioForm := nil;
end;

procedure TChemicalRatioForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := not CloseQuery;
end;

function TChemicalRatioForm.CloseQuery: Boolean;
begin
  if not TGlobal.DeltaIsNull(cdsRatio) then
  begin
    if TMsgDialog.ShowMsgDialog('数据未保存，是否保存！', mtConfirmation, [mebYes, mebNo], mebYes)= mrNo then
      Result := false;
  end
  else
    Result := False;
end;

procedure TChemicalRatioForm.DataCancel;
begin
  cdsRatio.CancelUpdates;
  SetBtnState;
end;

procedure TChemicalRatioForm.DataRefresh;
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
begin
  try
    ShowMsg('', crHourGlass);
    cdsRatio.DisableControls;

    if CloseQuery then Exit;

    sSQL := QuotedStr('fnGetChemicalRatio');
    FNMServerObj.GetQueryData(vData, 'CommonSQL', sSQL, sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsRatio.Data := vData;

    if cdsRatio.IsEmpty then Exit;

    if cxgridtvRatio.ColumnCount<2 then
    begin
      GridDecorator.BindCxViewWithDataSource(cxgridtvRatio, dsRatio);
      GridDecorator.SetcxTableView(cxgridtvRatio, [], ['Ratio']);
    end;
  finally
    cdsRatio.EnableControls;
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TChemicalRatioForm.DataSave;
var
  vData: OleVariant;
  sErrMsg:WideString;
  i: Integer;
begin
  try
    ShowMsg('', crHourGlass);
    if TGlobal.DeltaIsNull(cdsRatio) then Exit;
    
    //如果修改了增加修改人、修改时间
    cdsRatio.DisableControls;

    DataModify;
    //保存数据
    vData := cdsRatio.Delta;
    FNMServerObj.SaveBaseTableInfo(vData, 'fnChemicalRatio', 'Chemical_ID', sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsRatio.MergeChangeLog;
  finally
    cdsRatio.EnableControls;
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TChemicalRatioForm.SetBtnState;
begin
  btnCancel.Enabled := not TGlobal.DeltaIsNull(cdsRatio);
  btn_Save.Enabled := btnCancel.Enabled;
end;

procedure TChemicalRatioForm.DataModify;
begin
  //如果修改了增加修改人、修改时间

  with cdsRatio do
  begin
    First;
    FieldByName('Operator').ReadOnly := False;
    FieldByName('Operate_Time').ReadOnly := False;

    while not EOF do
    begin
      if FieldByName('Ratio').OldValue<> FieldByName('Ratio').NewValue then
      begin

        Edit;
        FieldByName('Operator').Value := login.LoginName;
        FieldByName('Operate_Time').Value := TGlobal.GetServerTime;
        Post;
      end;

      Next;
    end;
    FieldByName('Operator').ReadOnly := True;
    FieldByName('Operate_Time').ReadOnly := True;
  end;
end;

procedure TChemicalRatioForm.btn_RefreshClick(Sender: TObject);
begin
  inherited;
  DataRefresh;
end;

procedure TChemicalRatioForm.btn_SaveClick(Sender: TObject);
begin
  inherited;
  DataSave;
end;

procedure TChemicalRatioForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  DataCancel;
end;

procedure TChemicalRatioForm.btn_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TChemicalRatioForm.cxdbseRatioExit(Sender: TObject);
begin
  inherited;
  SetBtnState;
end;

procedure TChemicalRatioForm.pnl1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  SetBtnState;
end;

procedure TChemicalRatioForm.cxcbAllPropertiesChange(Sender: TObject);
var
  dRatio: Double;
begin
  inherited;
  dRatio := cxdbseRatio.Value;
  with cdsRatio do
  begin
    DisableControls;
    First;
    while not EOF do
    begin
      Edit;
      FieldByName('Ratio').Value := dRatio;
      Post;

      Next;
    end;
    
    EnableControls;
  end;
end;

end.

