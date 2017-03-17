unit frmSOPDefect;
{******************************************************************************

       ������� FNM
       ��Ȩ���� (C) 2004-2012 ESQUEL GROUP GET/IT
       �������� 2010-10-14 10:54:40
       ������Ա cuijf
       �޸���Ա
       �޸�����
       �޸�ԭ��
       ��Ӧ����
       �ֶ�����
       ������ݿ��
       ������Ҫ����/SQL����˵��
       ��������

******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxDropDownEdit,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView, StrUtils,
  cxGridTableView, cxGridDBTableView, cxGrid, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, cxContainer, cxTextEdit;

type
  TSOPDefectForm = class(TForm)
    cdsSOPDefect: TClientDataSet;
    grp1: TGroupBox;
    pnl_Only: TPanel;
    btnQuery: TSpeedButton;
    btnSave: TSpeedButton;
    btn_Exit: TSpeedButton;
    btnDelete: TSpeedButton;
    txt_Only: TStaticText;
    dtpDate: TDateTimePicker;
    cxgrdSOPDefect: TcxGrid;
    cxgridtvSOPDefect: TcxGridDBTableView;
    cxgrdlvlGridlSOPDefect: TcxGridLevel;
    dsSOPDefect: TDataSource;
    btnAdd: TSpeedButton;
    btnCancel: TSpeedButton;
    cdsFillItems: TClientDataSet;
    dtpEnd: TDateTimePicker;
    cxtWorkerID: TcxTextEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btn_ExitClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgridtvSOPDefectFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
  private
    { Private declarations }
    procedure DataSave;
    procedure DataCancel;
    procedure DataQuery;
    function CloseQuery:Boolean;
    procedure SetGridProperty;
    procedure SetFieldValue(Sender: TField; const Text: String);
    procedure GetMachineWorker(Sender: TObject);
    procedure UpdateActions; override;
  public
    { Public declarations }
    sModel:String;  //I¼�룬Q��������̨�ն˲�ѯ������
    procedure SetBtnState;
  end;

var
  SOPDefectForm: TSOPDefectForm;

implementation

uses ServerDllPub, uFNMArtInfo, uGlobal, uDictionary, uShowMessage, uLogin, uGridDecorator;

{$R *.dfm}


{ TSOPDefectForm }

function TSOPDefectForm.CloseQuery: Boolean;
begin
  if not TGlobal.DeltaIsNull(cdsSOPDefect) then
  begin
    if TMsgDialog.ShowMsgDialog('����δ���棬�Ƿ񱣴棡', mtConfirmation, [mebYes, mebNo], mebYes)= mrNo then
      Result := false;
  end
  else
    Result := False;
end;

procedure TSOPDefectForm.DataCancel;
begin
  if cdsSOPDefect.Active then
  begin
    cdsSOPDefect.CancelUpdates;  
    SetBtnState;
  end;
end;

procedure TSOPDefectForm.DataQuery;
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
begin
  try

    sSQL := QuotedStr(login.CurrentDepartment)+','+ QuotedStr(DateToStr(dtpDate.Date))
          + ','+ QuotedStr(sModel);
    if sModel= 'Q' then
    begin
      //ʱ�䷶Χ
      sSQL := sSQL+ ','+ QuotedStr(DateToStr(dtpEnd.Date));
      if cxtWorkerID.Text<>'' then
        sSQL := sSQL+ ','+ QuotedStr(cxtWorkerID.Text);
    end;
    
    FNMServerObj.GetQueryData(vData, 'fnGetSOPDefect', sSQL, sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;

    cdsSOPDefect.Data := vData;

    GridDecorator.BindCxViewWithDataSource(cxgridtvSOPDefect, dsSOPDefect);
    GridDecorator.SetcxTableView(cxgridtvSOPDefect, ['Operator','Operate_Time','Dept'],[], False);
    cxgridtvSOPDefect.GetColumnByFieldName('Checker').Caption := '�����';
    cxgridtvSOPDefect.GetColumnByFieldName('Remark').Caption := 'ԭ��';
    SetGridProperty;
  finally
    SetBtnState;
  end;
end;

procedure TSOPDefectForm.DataSave;
var
  vData: OleVariant;
  sErrMsg: WideString;
begin
  try
    //ShowMsg('', crHourGlass);
    if TGlobal.DeltaIsNull(cdsSOPDefect) then Exit;

    //��������
    vData := cdsSOPDefect.Delta;

    FNMServerObj.SaveBaseTableInfo(vData, 'fnSOPDefect', 'Date_Time,Shift,Machine_ID,Check_Remark,Worker_Name', sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsSOPDefect.MergeChangeLog;

  finally
    SetBtnState;
    //ShowMsg('', crDefault);
  end;
end;


procedure TSOPDefectForm.SetBtnState;
begin
  btnSave.Enabled := not TGlobal.DeltaIsNull(cdsSOPDefect);
  btnCancel.Enabled := btnSave.Enabled;
  btnDelete.Enabled := (not cdsSOPDefect.IsEmpty) and (sModel='I');
  btnAdd.Visible := sModel='I';
  btnDelete.Visible := btnAdd.Visible;
  dtpEnd.Visible := sModel='Q';
  cxtWorkerID.Visible := dtpEnd.Visible;
end;

procedure TSOPDefectForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TSOPDefectForm.FormDestroy(Sender: TObject);
begin
  inherited;
  SOPDefectForm := nil;
end;

procedure TSOPDefectForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := not CloseQuery;
end;

procedure TSOPDefectForm.btn_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TSOPDefectForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  DataQuery;
end;

procedure TSOPDefectForm.btnAddClick(Sender: TObject);
begin
  inherited;
  if cdsSOPDefect.Active then
  begin
    cdsSOPDefect.Append;
  end;
end;

procedure TSOPDefectForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  DataCancel;
end;

procedure TSOPDefectForm.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if cdsSOPDefect.Active and not cdsSOPDefect.IsEmpty then
  begin
    cdsSOPDefect.Delete; 
    SetBtnState;
  end;
end;

procedure TSOPDefectForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  DataSave;
end;

procedure TSOPDefectForm.SetGridProperty;
var
  i:Integer;
begin
  cdsSOPDefect.FieldByName('Worker_ID').OnSetText:= SetFieldValue;
  cdsSOPDefect.FieldByName('Machine_ID').OnSetText:= SetFieldValue;
  cxgridtvSOPDefect.GetColumnByFieldName('Worker_Name').Options.Editing:=False;

  //������ֻ������һ���ֶ�
  if sModel= 'Q' then
  begin
    for i := 0 to cxgridtvSOPDefect.ColumnCount - 1 do
      cxgridtvSOPDefect.Columns[i].Options.Editing:=false;

    cxgridtvSOPDefect.GetColumnByFieldName('Worker_Remark').Options.Editing:=True;
  end
  else
  begin
    with cxgridtvSOPDefect do
    begin
      //���
      with GetColumnByFieldName('Shift') do
      begin
        Options.Editing:=true;
        PropertiesClassName:='TcxComboBoxProperties';
        with Properties as TcxComboBoxProperties do
        begin
          Items.Clear;
          Items.Add('��');
          Items.Add('��');
          Items.Add('��');
        end;
      end;

      //ԭ��
      with GetColumnByFieldName('Remark') do
      begin
        Options.Editing:=true;
        PropertiesClassName:='TcxComboBoxProperties';
        (Properties as TcxComboBoxProperties).Items.Text := Dictionary.GetItemList('SOPԭ��',Login.CurrentDepartment,'');
        //FillItemsFromDataSet(cdsFillItems, 'Reason_Code', 'Reason_Info, '', '->', (Properties as TcxComboBoxProperties).Items);      FillItemsFromDataSet(Properties as TcxComboBoxProperties).OnInitPopup :=GetOperationList;
      end;

      //�ؼ���
      with GetColumnByFieldName('Sticking_Point') do
      begin
        Options.Editing:=true;
        PropertiesClassName:='TcxComboBoxProperties';
        (Properties as TcxComboBoxProperties).Items.Text := Dictionary.GetItemList('SOP�ؼ���',Login.CurrentDepartment,'');
        //FillItemsFromDataSet(cdsFillItems, 'Reason_Code', 'Reason_Info, '', '->', (Properties as TcxComboBoxProperties).Items);      FillItemsFromDataSet(Properties as TcxComboBoxProperties).OnInitPopup :=GetOperationList;
      end;

      //��̨
      with GetColumnByFieldName('Machine_ID') do
      begin
        Options.Editing:=true;
        PropertiesClassName:='TcxComboBoxProperties';
        with (Properties as TcxComboBoxProperties) do
        begin
          Items.Text := Dictionary.GetItemList('SOPMachine',Login.CurrentDepartment,'');
          with Dictionary.cds_OperationHdrList do
          begin
            Filtered := False;
            Filter := 'Operation_Type =''Hand_Dip''';
            Filtered := True;
            First;
            while not Eof do
            begin
              Items.add(FieldByName('Operation_Code').AsString+'->'+FieldByName('Operation_CHN').AsString);
              Next;
            end;
          end;
          Items.Add(Login.CurrentDepartment+'G1->һ����ֲ�');
          Items.Add(Login.CurrentDepartment+'G3->������ֲ�');

          //���Ϸ�
          with Dictionary.cds_VatList do
          try
            Filter := Format('Vat_Studio LIKE ''%s''', [Login.CurrentDepartment + '%']);
            Filtered := True;
            while not Eof do
            begin
              if Items.IndexOf(FieldByName('Vat_Studio').AsString + '->' + '���Ϸ�') = -1 then
                Items.add(FieldByName('Vat_Studio').AsString + '->' + '���Ϸ�');
              Next;
            end;
          finally
            Filtered := False;
          end;
        end;
      end;

      //��̨������
      with GetColumnByFieldName('Worker_ID') do
      begin
        Options.Editing:=true;
        PropertiesClassName:='TcxComboBoxProperties';
        (Properties as TcxComboBoxProperties).OnInitPopup := GetMachineWorker;
      end;
    end;
  end;
end;

procedure TSOPDefectForm.SetFieldValue(Sender: TField; const Text: String);
var
  sStrL, sStrR: string;
  Iden, OperationTimes: Integer;
begin
  with Sender.DataSet do
  begin
    if Text <> '' then
    begin
      if Sender.Value = LeftStr(Text, Pos('->', Text) - 1) then Exit;

      sStrL := LeftStr(Text, Pos('->', Text) - 1);
      sStrR :=MidStr(Text, Pos('->', Text) + 2, MaxInt);

      if Sender.FieldName= 'Machine_ID' then
        Sender.Value:= sStrL;

      if Sender.FieldName= 'Worker_ID' then
      begin
        Sender.Value:= sStrL;
        FieldByName('Worker_Name').Value := sStrR;
      end;
    end
    else
    begin  
      if Sender.FieldName= 'Worker_ID' then
      begin
        Sender.Clear;
        FieldByName('Worker_Name').Clear;
      end;
    end;
  end;

  //¼��
  if sModel= 'I' then
  begin
    Sender.DataSet.FieldByName('Operator').AsString:= login.LoginName;
    Sender.DataSet.FieldByName('Dept').AsString:= login.CurrentDepartment;
    Sender.DataSet.FieldByName('Operate_Time').AsDateTime:= TGlobal.GetServerTime;
  end;
  SetBtnState;
end;

procedure TSOPDefectForm.GetMachineWorker;
var
  sSQL, sErrMsg:WideString;
  sDate, sShift, sMachine, sDept:String;
  iRow :Integer;
  vData:Olevariant;
begin
  if sModel= 'Q' then Exit;

  with cxgridtvSOPDefect do
  begin
    iRow := DataController.FocusedRowIndex;
    sDate := VarToStr(DataController.Values[iRow,GetColumnByFieldName('Date_Time').Index]);
    sShift := VarToStr(DataController.Values[iRow,GetColumnByFieldName('Shift').Index]);
    sMachine := VarToStr(DataController.Values[iRow,GetColumnByFieldName('Machine_ID').Index]);
    sDept := login.CurrentDepartment;
    if sDate= '' then sErrMsg := '��ѡ������';
    if sShift= '' then sErrMsg := '��ѡ����';
    if sMachine= '' then sErrMsg := '��ѡ���̨';
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
      Exit;
    end;
  end;
  sSQL := 'EXEC usp_fnGetSOPWoker '
        + QuotedStr(sDate)+ ','
        + QuotedStr(sShift)+ ','
        + QuotedStr(sMachine)+ ','
        + QuotedStr(sDept);

  FNMServerObj.GetQueryBySQL(vData, sSQL, sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
    Exit;
  end;
  cdsFillItems.Data := vData;
{
  cdsFillItems.Filter := ' Worker_Group like ''%�೤%''';
  cdsFillItems.Filtered := True;
}
  FillItemsFromDataSet(cdsFillItems, 'Worker_ID','Worker_Name', '','->',(Sender as TcxComboBox).Properties.Items,False);
end;

procedure TSOPDefectForm.FormShow(Sender: TObject);
begin
  inherited;
  SetBtnState;
  if sModel<> 'Q' then
    dtpDate.Date := Date()
  else
  begin
    dtpDate.Date := Date()-7;
    dtpEnd.Date := Date();
  end;
end;

procedure TSOPDefectForm.UpdateActions;
begin
  inherited;

end;

procedure TSOPDefectForm.cxgridtvSOPDefectFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  SetBtnState;
end;

end.







