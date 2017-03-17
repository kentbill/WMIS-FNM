unit frmAccidentRecord;
{******************************************************************************

       ������� FNM
       ��Ȩ���� (C) 2004-2012 ESQUEL GROUP GET/IT
       �������� 2011-04-15 15:54:40
       ������Ա cuijf
       �޸���Ա
       �޸�����
       �޸�ԭ��
       ��Ӧ����
       �ֶ�����
       ������ݿ��
       ������Ҫ����/SQL����˵��
       ��������

******************************************************************************
******************************************************************************

       �޸���Ա  APJ zhaogang
       �޸�����  2013-11-11
       �޸�ԭ��  �����¹���
       �޸���
                1������frmAddTask��Ԫ��������д������Task����
                   ���� btnAddTask��ť�����ڴ�AddTaskForm����
                2������ btnUpdate ��ť�������޸Ĳ��������뿨��
                   �滻 lblQuantity ��ǩΪ edtQuantity �ı��������޸Ĳ�������
                3�����ӷ���
                  procedure SetEditsReadOnly(isReadOnly : Boolean); //���ò��������뿨�� Edit ��ֻ������
                  procedure SetButtonEnabled(aStart : Boolean);     //�����޸İ�ť��Enabled����
                  procedure SaveAccidentRecordData;                 //�����������뿨�ű��浽����ClientDataSet��
                  procedure addTaskData(aNoteNO : String);          //��addTaskData���岢��Note_NOֵ���浽������cdsTask��}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, DBClient, cxSplitter, Buttons,
  cxCheckBox, cxDBEdit, cxContainer, cxTextEdit, cxMemo, ComCtrls;

type
  TAccidentRecordForm = class(TBaseForm)
    pnl1: TPanel;
    pnl2: TPanel;
    pnlReject_Result: TPanel;
    pnlReject_Reason: TPanel;
    pnlReject_Method: TPanel;
    pnlReject_Desc: TPanel;
    Label8: TLabel;
    pnl9: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    lblOperator1: TLabel;
    lblOperate_Time1: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    lblOperator2: TLabel;
    lblOperate_Time2: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    lblOperator3: TLabel;
    lblOperate_Time3: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    lblOperator5: TLabel;
    lblOperate_Time5: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    lblOperator4: TLabel;
    lblOperate_Time4: TLabel;
    pnl4: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label36: TLabel;
    cdsAccidentRecord: TClientDataSet;
    dsAccidentRecord: TDataSource;
    lblGF_NO: TLabel;
    lblDefects: TLabel;
    lblJob_NO: TLabel;
    lblFN_Cards: TLabel;
    lblCustomer: TLabel;
    lblQuantity: TLabel;
    lblNote_NO: TLabel;
    lblType: TLabel;
    lblOperate_Time: TLabel;
    pnl11: TPanel;
    grp2: TGroupBox;
    cxGrid2: TcxGrid;
    cxgdTVTask: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cdsTask: TClientDataSet;
    dsTask: TDataSource;
    cxsplTask: TcxSplitter;
    btnSave: TBitBtn;
    btn_Exit: TBitBtn;
    cdsDtl: TClientDataSet;
    dsDtl: TDataSource;
    btn_Refresh: TBitBtn;
    btnCancel: TBitBtn;
    cxdbmReject_Desc: TcxDBMemo;
    cxdbmReject_Reason: TcxDBMemo;
    cxdbmReject_Method: TcxDBMemo;
    cxdbmReject_Result: TcxDBMemo;
    cxdbcbHasSample: TcxDBCheckBox;
    cxdbcbHasCard: TcxDBCheckBox;
    cxdbtOperator5: TcxDBTextEdit;
    btnPrint: TBitBtn;
    cxDBTextEdit1: TcxDBTextEdit;
    cxDBTextEdit2: TcxDBTextEdit;
    cxDBTextEdit3: TcxDBTextEdit;
    cxDBTextEdit4: TcxDBTextEdit;
    btnDelete: TBitBtn;
    edt_GFNO: TEdit;
    edt_CardList: TEdit;
    pnl3: TPanel;
    grp1: TGroupBox;
    cxgrdDtl: TcxGrid;
    cxgtvDtl: TcxGridDBTableView;
    cxglvDtl: TcxGridLevel;
    pnl10: TPanel;
    Label32: TLabel;
    lblOperator6: TLabel;
    Label34: TLabel;
    lblOperate_Time6: TLabel;
    cxdbtOperator6: TcxDBTextEdit;
    pnl12: TPanel;
    btnAdd: TBitBtn;
    cbbMachine_ID: TComboBox;
    dtpEnd: TDateTimePicker;
    dtpBegin: TDateTimePicker;
    btnRefreshAll: TBitBtn;
    edt_Note_NO: TEdit;
    edtQuantity: TEdit;
    btnAddTask: TBitBtn;
    btnUpdate: TBitBtn;
    procedure cxgdTVTaskDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure cxdbmReject_DescExit(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cbbMachine_IDChange(Sender: TObject);
    procedure btnRefreshAllClick(Sender: TObject);
    procedure btnAddTaskClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
  private
    { Private declarations }
    sNote_NO:String;
    iType :Integer;
    procedure SetBtnState;
    procedure DataRefresh;
    procedure DataAdd;
    procedure DataSave;
    procedure DataDelete;
    procedure DataCancel;
    procedure DataQuery;
    function CloseQuery:Boolean;
    procedure GetHdr;
    procedure SaveHdr;
    procedure SaveDtl;
    procedure SetFieldValue(Sender: TField; const Text: String);

    //2013-11-08 APJ 
    procedure SetEditsReadOnly(isReadOnly : Boolean); //2013-11-08 APJ zhaogang ���  //���ò��������뿨�� Edit ��ֻ������
    procedure SetButtonEnabled(aStart : Boolean);     //2013-11-08 APJ zhaogang ���  //�����޸İ�ť��Enabled����
    procedure SaveAccidentRecordData;                 //2013-11-11 APJ zhaogang ���  //�����������뿨�ű��浽����ClientDataSet��
    procedure addTaskData(aNoteNO : String);          //2013-11-08 APJ zhaogang ���  //��addTaskData���岢��Note_NOֵ���浽������cdsTask��

  public
    { Public declarations }
  end;

var
  AccidentRecordForm: TAccidentRecordForm;

implementation

uses  ServerDllPub, uGlobal, uShowMessage, uLogin, uGridDecorator, uFNMArtInfo,
  uDictionary, rptAccidentRecord, frmAddTask;

{$R *.dfm}

{ TAccidentRecordForm }

function TAccidentRecordForm.CloseQuery: Boolean;
begin
  if not TGlobal.DeltaIsNull(cdsAccidentRecord)
    or not TGlobal.DeltaIsNull(cdsDtl) then
  begin
    if TMsgDialog.ShowMsgDialog('����δ���棬�Ƿ񱣴棡', mtConfirmation, [mebYes, mebNo], mebYes)= mrYes then
      Result := false;
  end
  else
    Result := True;
end;

procedure TAccidentRecordForm.DataAdd;
begin
  cdsDtl.Append;
  cdsDtl.Edit;
  cdsDtl.FieldByName('Note_NO').AsString := sNote_NO;
  cdsDtl.Post;
  //SetBtnState
end;

procedure TAccidentRecordForm.DataCancel;
begin
  cdsDtl.CancelUpdates;
end;

procedure TAccidentRecordForm.DataQuery;
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
begin
  try
    ShowMsg('���ڲ�ѯ�Եȣ�', crHourGlass);

    if not CloseQuery then Exit;

    if cdsTask.IsEmpty then Exit;

    sNote_NO := cdsTask.FieldByName('Note_NO').AsString;
    sSQL := '2,'+QuotedStr(sNote_NO);
    FNMServerObj.GetQueryData(vData, 'fnGetRejectAccidentRecord',sSQL, sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsAccidentRecord.Data := vData[0];
    cdsDtl.Data := vData[1];

    if cxgtvDtl.ColumnCount<2 then
    begin
      GridDecorator.BindCxViewWithDataSource(cxgtvDtl, dsDtl);
      GridDecorator.SetcxTableView(cxgtvDtl, ['Note_NO'],['Note_NO','WHO','WHAT','Operate_Time']);
    end;
    //cxgtvDtl.GetColumnByFieldName('').Caption := '';

    cdsAccidentRecord.FieldByName('Reject_Desc').OnSetText:= SetFieldValue;
    cdsAccidentRecord.FieldByName('Reject_Reason').OnSetText:= SetFieldValue;
    cdsAccidentRecord.FieldByName('Reject_Method').OnSetText:= SetFieldValue;
    cdsAccidentRecord.FieldByName('Reject_Result').OnSetText:= SetFieldValue;
    cdsAccidentRecord.FieldByName('Operator5').OnSetText:= SetFieldValue;
    cdsAccidentRecord.FieldByName('Operator6').OnSetText:= SetFieldValue;
    cdsDtl.FieldByName('What').OnSetText:= SetFieldValue;
    GetHdr;
  finally
    SetBtnState;
    SetButtonEnabled(True); //2013-11-08 APJ zhaogang
    SetEditsReadOnly(true); //2013-11-08 APJ zhaogang
    ShowMsg('', crDefault);
  end;
end;

procedure TAccidentRecordForm.DataRefresh;
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
begin
  try
    with Dictionary do
    begin
      cds_FinishMachineList.Filter := 'Department ='+ QuotedStr(login.CurrentDepartment);
      cds_FinishMachineList.Filtered := True;
      TGlobal.FillItemsFromDataSet(Dictionary.cds_FinishMachineList, 'Machine_ID', 'Machine_Model_CHN', '->', cbbMachine_ID.items);
    end;

    ShowMsg('���ڲ�ѯ�Եȣ�', crHourGlass);
    sNote_NO := '';
    GetHdr;
    if iType = 0 then
      sSQL := '1,'+QuotedStr(login.CurrentDepartment)
    else
      sSQL := '3,'+QuotedStr(login.CurrentDepartment) +',' + QuotedStr(DateTimeToStr(dtpBegin.Date)) + ',' + QuotedStr(DateTimeToStr(dtpEnd.Date)) ;
    FNMServerObj.GetQueryData(vData, 'fnGetRejectAccidentRecord',sSQL, sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;

    cdsTask.Data := vData;
    if cxgdTVTask.ColumnCount<2 then
    begin
      GridDecorator.BindCxViewWithDataSource(cxgdTVTask, dsTask);
      //GridDecorator.SetcxTableView(cxgdTVTask, ['Operator','Operate_Time'], ['Ignore','Remark','Operator','Operate_Time','Is_Active']);
    end;
    cxgdTVTask.ApplyBestFit(nil);
  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TAccidentRecordForm.DataSave;
var
  vData: OleVariant;
  sErrMsg: WideString;
begin
  try
    ShowMsg('���ڱ�������...', crHourGlass);

    SaveAccidentRecordData;     //2013-11-11 APJ zhaogang
    SaveHdr;
    SaveDtl;
  finally
    SetBtnState;

    SetButtonEnabled(false); //2013-11-08 APJ zhaogang
    SetEditsReadOnly(True);  //2013-11-08 APJ zhaogang

    ShowMsg('', crDefault);
  end;
end;

procedure TAccidentRecordForm.GetHdr;
begin
  if sNote_NO= '' then
  begin
    lblGF_NO.Caption := '';
    lblJob_NO.Caption := '';
    lblCustomer.Caption := '';
    lblNote_NO.Caption := '';
    lblDefects.Caption := '';
    lblFN_Cards.Caption := '';
    lblQuantity.Caption := '';
    lblType.Caption := '';
    lblOperate_Time.Caption := '';
  end;

  if cdsAccidentRecord.IsEmpty then Exit;

  with cdsAccidentRecord do
  begin
    lblGF_NO.Caption := FieldByName('GF_NO').AsString;
    edt_GFNO.Text := FieldByName('GF_NO').AsString;
    lblJob_NO.Caption := FieldByName('Job_NO').AsString;
    lblCustomer.Caption := FieldByName('Customer').AsString;
    lblNote_NO.Caption := FieldByName('Note_NO').AsString;
    edt_Note_NO.Text := FieldByName('Note_NO').AsString;
    lblDefects.Caption := FieldByName('Defects').AsString;
    lblFN_Cards.Caption := FieldByName('FN_Cards').AsString;
    edt_CardList.Text := FieldByName('FN_Cards').AsString;
    lblQuantity.Caption := FieldByName('Reject_QTY').AsString;
    edtQuantity.Text :=  FieldByName('Reject_QTY').AsString;
    lblType.Caption := FieldByName('Type').AsString;
    lblOperate_Time.Caption := FieldByName('Operate_Time').AsString;
    //mmoReject_Desc.Text := FieldByName('Reject_Desc').AsString;
    //chkHasSample.Caption := FieldByName('Has_Sample').AsString;
    //chkHasCard.Caption := FieldByName('Has_Card').AsString;
    lblOperator1.Caption := FieldByName('Operator1').AsString;
    lblOperate_Time1.Caption := FieldByName('Operate_Time1').AsString;
    //mmoReject_Reason.Text := FieldByName('Reject_Reason').AsString;
    lblOperator2.Caption := FieldByName('Operator2').AsString;
    lblOperate_Time2.Caption := FieldByName('Operate_Time2').AsString;
    //mmoReject_Method.Text := FieldByName('Reject_Method').AsString;
    lblOperator3.Caption := FieldByName('Operator3').AsString;
    lblOperate_Time3.Caption := FieldByName('Operate_Time3').AsString;
    //mmoReject_Result.Text := FieldByName('Reject_Result').AsString;
    lblOperator4.Caption := FieldByName('Operator4').AsString;
    lblOperate_Time4.Caption := FieldByName('Operate_Time4').AsString;
    lblOperator5.Caption := FieldByName('Operator5').AsString;
    lblOperate_Time5.Caption := FieldByName('Operate_Time5').AsString;
    lblOperator6.Caption := FieldByName('Operator6').AsString;
    lblOperate_Time6.Caption := FieldByName('Operate_Time6').AsString;
   
    cbbMachine_ID.ItemIndex := cbbMachine_ID.Items.IndexOf(FieldByName('machine').AsString);
  end;
end;

procedure TAccidentRecordForm.SaveHdr;
var
  vData: OleVariant;
  sErrMsg: WideString;
begin
  try
    ShowMsg('���ڱ�������...', crHourGlass);
    if TGlobal.DeltaIsNull(cdsAccidentRecord) then Exit;

    vData := cdsAccidentRecord.Delta;
    FNMServerObj.SaveBaseTableInfo(vData, 'fnRejectHdr','',sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;

    cdsAccidentRecord.MergeChangeLog;
  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TAccidentRecordForm.SaveDtl;
var
  vData: OleVariant;
  sErrMsg: WideString;
begin
  try
    ShowMsg('���ڱ�������...', crHourGlass);
    if TGlobal.DeltaIsNull(cdsDtl) then Exit;

    vData := cdsDtl.Delta;
    FNMServerObj.SaveBaseTableInfo(vData, 'fnRejectDtl','',sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;

    cdsDtl.MergeChangeLog;
  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TAccidentRecordForm.SetBtnState;
begin
  btnSave.Enabled := (not TGlobal.DeltaIsNull(cdsAccidentRecord)) or (not TGlobal.DeltaIsNull(cdsDtl));
  btnCancel.Enabled := btnSave.Enabled;
  btnAdd.Enabled := not cdsAccidentRecord.IsEmpty;
  //pnlReject_Desc.Enabled := btnAdd.Enabled;
  pnlReject_Reason.Enabled := pnlReject_Desc.Enabled;
  pnlReject_Method.Enabled := pnlReject_Desc.Enabled;
  pnlReject_Result.Enabled := pnlReject_Desc.Enabled;
  btnPrint.Enabled := lblNote_NO.Caption<>'';
  btnDelete.Enabled := btnPrint.Enabled;
end;

procedure TAccidentRecordForm.cxgdTVTaskDblClick(Sender: TObject);
begin
  inherited;
  DataQuery;
end;

procedure TAccidentRecordForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TAccidentRecordForm.FormCreate(Sender: TObject);
begin
  inherited;
  iType := 0;
  DataRefresh;
end;

procedure TAccidentRecordForm.FormDestroy(Sender: TObject);
begin
  inherited;
  AccidentRecordForm := nil;
end;

procedure TAccidentRecordForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := CloseQuery;
end;

procedure TAccidentRecordForm.SetFieldValue(Sender: TField;
  const Text: String);
var
  Operator:String;
  Operate_Time:TDateTime;
begin
  with Sender.DataSet do
  begin
    if Text <> '' then
        FieldByName(Sender.FieldName).AsString := Text;

    Operator := login.LoginName;
    Operate_Time := TGlobal.GetServerTime;

    if Sender.DataSet.Name = 'cdsAccidentRecord' then
    begin
      if Sender.FieldName= 'Reject_Desc' then
      begin
        Sender.DataSet.FieldByName('Operator1').AsString:= Operator;
        Sender.DataSet.FieldByName('Operate_Time1').AsDateTime:= Operate_Time;
      end;
      if Sender.FieldName= 'Reject_Reason' then
      begin
        Sender.DataSet.FieldByName('Operator2').AsString:= Operator;
        Sender.DataSet.FieldByName('Operate_Time2').AsDateTime:= Operate_Time;
      end;
      if Sender.FieldName= 'Reject_Method' then
      begin
        Sender.DataSet.FieldByName('Operator3').AsString:= Operator;
        Sender.DataSet.FieldByName('Operate_Time3').AsDateTime:= Operate_Time;
      end;
      if Sender.FieldName= 'Reject_Result' then
      begin
        Sender.DataSet.FieldByName('Operator4').AsString:= Operator;
        Sender.DataSet.FieldByName('Operate_Time4').AsDateTime:= Operate_Time;
      end;
      if Sender.FieldName= 'Operator5' then
      begin
        Sender.DataSet.FieldByName('Operate_Time5').AsDateTime:= Operate_Time;
      end;  
      if Sender.FieldName= 'Operator6' then
      begin
        Sender.DataSet.FieldByName('Operate_Time6').AsDateTime:= Operate_Time;
      end;
    end;

    if Sender.DataSet.Name = 'cdsDtl' then
    begin
      Sender.DataSet.FieldByName('WHO').AsString:= Operator;
      Sender.DataSet.FieldByName('Operate_Time').AsDateTime:= Operate_Time;
      SetBtnState;
    end;
  end;
end;

procedure TAccidentRecordForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  DataSave;
end;

procedure TAccidentRecordForm.btn_RefreshClick(Sender: TObject);
begin
  inherited;
  iType:=0;
  DataRefresh;
end;

procedure TAccidentRecordForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  DataCancel;
end;

procedure TAccidentRecordForm.btn_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TAccidentRecordForm.btnAddClick(Sender: TObject);
begin
  inherited;
  DataAdd;
end;

procedure TAccidentRecordForm.cxdbmReject_DescExit(Sender: TObject);
begin
  inherited;
  //cdsAccidentRecord.Post;
  SetBtnState;
end;

procedure TAccidentRecordForm.btnPrintClick(Sender: TObject);
begin
  inherited;
  rptAccidentRecord.PrintAccidentRecord(lblNote_NO.Caption, True);
end;

procedure TAccidentRecordForm.DataDelete;
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
begin
  try
    ShowMsg('���ڱ�������...', crHourGlass);

    sSQL := lblNote_NO.Caption;
    if sSQL= '' then
        Exit;

    FNMServerObj.SaveDataBySQL('fnDeleteRejectAccidentRecord',QuotedStr(sSQL),sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    sSQL := 'ɾ�� '+sSQL+ ' �ɹ�!';
    TMsgDialog.ShowMsgDialog(sSQL,mtInformation);

    DataRefresh;
  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TAccidentRecordForm.btnDeleteClick(Sender: TObject);
var
  loginid:string;
begin
  inherited;
  loginid :=   Login.LoginID;
  if loginid <> 'licm' then
  begin
    TMsgDialog.ShowMsgDialog('������ɾ����', mtError);
    Exit;
  end;

  DataDelete;
end;
procedure TAccidentRecordForm.cbbMachine_IDChange(Sender: TObject);
begin
  inherited;
  cdsAccidentRecord.Edit;
  cdsAccidentRecord.FieldByName('machine').AsString := cbbMachine_ID.Text;
  SetBtnState
end;

procedure TAccidentRecordForm.btnRefreshAllClick(Sender: TObject);
begin
  inherited;
  iType:=1;
  DataRefresh;
end;

{
  2013-11-08 APJ zhaogang
  SetEditsReadOnly ����
  ���ò��������뿨�� Edit ��ֻ������
}
procedure TAccidentRecordForm.SetEditsReadOnly(isReadOnly : Boolean);
var
  color : TColor;
begin
  if isReadOnly = False then
    color := clWindow
  else
    color := clBtnFace;

  edtQuantity.Color := color;
  edt_CardList.Color := color;

  edtQuantity.ReadOnly := isReadOnly;
  edt_CardList.ReadOnly := isReadOnly;
end;

{
  2013-11-08 APJ zhaogang
  SetButtonEnabled ����
  �����޸İ�ť��Enabled����
}
procedure TAccidentRecordForm.SetButtonEnabled(aStart : Boolean);
begin
  btnUpdate.Enabled := aStart;
  if aStart then
    btnSave.Enabled := False
  else
    btnSave.Enabled := true;
end;

{
  2013-11-08 APJ zhaogang
  addTaskData ����
  ��addTaskData���岢��Note_NOֵ���浽������cdsTask��
}
procedure TAccidentRecordForm.addTaskData(aNoteNO: String);
begin
  if aNoteNO <> '' then
  begin
    cdsTask.Append;
    cdsTask.FieldByName('Note_NO').AsString := aNoteNO;
  end;
end;

{
   2013-11-11 APJ zhaogang
   SaveAccidentRecordData ����
   �����������뿨�ű��浽����ClientDataSet��
}
procedure TAccidentRecordForm.SaveAccidentRecordData;
begin
  cdsAccidentRecord.Edit;
  cdsAccidentRecord.FieldByName('Reject_QTY').AsString :=  edtQuantity.Text;
  cdsAccidentRecord.FieldByName('FN_Cards').AsString := edt_CardList.Text;
  cdsAccidentRecord.Post;
end;

procedure TAccidentRecordForm.btnAddTaskClick(Sender: TObject);
begin
  inherited;
  AddTaskForm := TAddTaskForm.Create(nil); //2013-11-08 APJ zhaogang
  AddTaskForm.ShowModal;
  addTaskData(AddTaskForm.getNoteNO);
end;

procedure TAccidentRecordForm.btnUpdateClick(Sender: TObject);
begin
  inherited;
  SetEditsReadOnly(false); //2013-11-08 APJ zhaogang
  SetButtonEnabled(false); //2013-11-08 APJ zhaogang
end;

end.
