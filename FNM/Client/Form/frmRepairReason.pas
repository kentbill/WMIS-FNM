unit frmRepairReason;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, ComCtrls, Buttons,
  DBClient, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ExtCtrls;

type
  TRepairReasonFrm = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    btnAdd: TSpeedButton;
    btnEdit: TSpeedButton;
    btnDelete: TSpeedButton;
    btnSave: TSpeedButton;
    edtReasonCode: TEdit;
    cbReasonType: TComboBox;
    edtReasonInfo: TEdit;
    cbOperationCode: TComboBox;
    cbQualityType: TComboBox;
    moRemark: TMemo;
    chbIsActive: TCheckBox;
    GroupBox2: TGroupBox;
    lvDetail: TListView;
    sbAdd: TSpeedButton;
    sbEdit: TSpeedButton;
    sbDelete: TSpeedButton;
    sbSave: TSpeedButton;
    edtItemName: TEdit;
    edtItemValue: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    gbOperation: TGroupBox;
    lbOperation: TListBox;
    btnMoveUpOperation: TSpeedButton;
    btnMoveDownOperation: TSpeedButton;
    btnDelOperation: TSpeedButton;
    btnAddOperation: TSpeedButton;
    cbbOperation: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    sbPreview: TSpeedButton;
    lvMaster: TListView;
    edtDepartment: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddOperationClick(Sender: TObject);
    procedure btnDelOperationClick(Sender: TObject);
    procedure btnMoveUpOperationClick(Sender: TObject);
    procedure btnMoveDownOperationClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure sbAddClick(Sender: TObject);
    procedure sbEditClick(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
    procedure lbOperationDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure sbPreviewClick(Sender: TObject);
    procedure cbbOperationKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvMasterChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvDetailChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  private
    AddNew: string;
    DumbList: TStringList;
    Max_Reason_Code: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RepairReasonFrm: TRepairReasonFrm;

implementation

uses cxDropDownEdit, uDictionary, ServerDllPub, uGlobal, uLogin, UGridDecorator, uShowMessage, uFNMArtInfo, StrUtils;

{$R *.dfm}

procedure TRepairReasonFrm.FormCreate(Sender: TObject);
begin
  cbbOperation.Align := alClient;
  DumbList := TStringList.Create;
  Max_Reason_Code := '';
  FillItemsFromDataSet(Dictionary.cds_RepairReasonList, 'Reason_Type', '', '','', cbReasonType.Items);
  FillItemsFromDataSet(Dictionary.cds_RepairReasonList, 'Quality_Type', '', '','', cbQualityType.Items);
  FillItemsFromDataSet(Dictionary.cds_OperationHdrList, 'Operation_Code', 'Operation_CHN', 'Operation_Code','->', cbOperationCode.Items);
  cbbOperation.Items := cbOperationCode.Items;
  cbbOperation.OnDblClick := TGlobal.DblClickAWinControl;
  with Dictionary.cds_RepairReasonList do
  begin
    Filtered := False;
    First;
    while not Eof do
    begin
      if DumbList.IndexOf(FieldByName('Reason_Code').AsString) > -1 then
      begin
        Next;
        Continue;
      end;
      DumbList.Add(FieldByName('Reason_Code').AsString);
      with lvMaster.Items.Add do
      begin
        if Max_Reason_Code < FieldByName('Reason_Code').AsString then
           Max_Reason_Code := FieldByName('Reason_Code').AsString;
        Caption := FieldByName('Reason_Code').AsString;
        SubItems.Add(FieldByName('Reason_Type').AsString);
        SubItems.Add(FieldByName('Reason_Info').AsString);
        SubItems.Add(FieldByName('Quality_Type').AsString);
        SubItems.Add(FieldByName('Department').AsString);
        SubItems.Add(FieldByName('Quality_Operation').AsString);
        SubItems.Add(FieldByName('Remark').AsString);
        SubItems.Add(FieldByName('Is_Active').AsString);
        SubItems.Add(FieldByName('Repair_Operation').AsString);
      end;
      Next;
    end;
  end;
  edtReasonCode.Enabled := False;
  cbReasonType.Enabled := False;
  edtReasonInfo.Enabled :=  False;
  cbQualityType.Enabled := False;
  edtDepartment.Enabled := False;
  cbOperationCode.Enabled := False;
  moRemark.Enabled := False;
  chbIsActive.Enabled := False;
  gbOperation.Enabled := False;
  btnSave.Enabled := False;
  edtItemName.Enabled := False;
  edtItemValue.Enabled := False;
  sbSave.Enabled := False;
end;

procedure TRepairReasonFrm.FormDestroy(Sender: TObject);
begin
  DumbList.Free;
  RepairReasonFrm := nil;
end;

procedure TRepairReasonFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TRepairReasonFrm.btnAddOperationClick(Sender: TObject);
begin
  if cbbOperation.Text = '' then Exit;
  with lbOperation do
  begin
    if ItemIndex <> -1 then
      Items.Insert(ItemIndex+1,cbbOperation.Text)
    else
      Items.Add(cbbOperation.Text);

    cbbOperation.ItemIndex := -1;
  end;
end;

procedure TRepairReasonFrm.btnDelOperationClick(Sender: TObject);
begin
 with lbOperation do
   if ItemIndex <> -1 then
     DeleteSelected;
end;

procedure TRepairReasonFrm.btnMoveUpOperationClick(Sender: TObject);
begin
  with lbOperation do
  begin
    if ItemIndex = 0 then Exit;
    if ItemIndex <> -1 then
      Items.Exchange(ItemIndex,ItemIndex -1);
  end;
end;

procedure TRepairReasonFrm.btnMoveDownOperationClick(Sender: TObject);
begin
  with lbOperation do
  begin
    if ItemIndex = Items.Count - 1 then Exit;
    if ItemIndex <> -1 then
      Items.Exchange(ItemIndex,ItemIndex +1);
  end;
end;

procedure TRepairReasonFrm.btnAddClick(Sender: TObject);
begin
  lbOperation.Items.Clear;
  edtReasonCode.Text := '';
  cbReasonType.Text := '';
  edtReasonInfo.Text :=  '';
  cbQualityType.Text := '';
  edtDepartment.Text := '';
  cbOperationCode.Text := '';
  moRemark.Text := '';
  chbIsActive.Checked := True;
  
  gbOperation.Enabled := btnAdd.Caption = '新增';
  edtReasonCode.Enabled := btnAdd.Caption = '新增';
  cbReasonType.Enabled := btnAdd.Caption = '新增';
  edtReasonInfo.Enabled :=  btnAdd.Caption = '新增';
  cbQualityType.Enabled := btnAdd.Caption = '新增';
  edtDepartment.Enabled := btnAdd.Caption = '新增';
  cbOperationCode.Enabled := btnAdd.Caption = '新增';
  moRemark.Enabled := btnAdd.Caption = '新增';
  chbIsActive.Enabled := btnAdd.Caption = '新增';

  lvMaster.Enabled := btnAdd.Caption = '放弃';
  btnEdit.Enabled := btnAdd.Caption = '放弃';
  btnDelete.Enabled := btnAdd.Caption = '放弃';
  btnSave.Enabled :=  btnAdd.Caption = '新增';;
  if btnAdd.Caption = '放弃' then
    btnAdd.Caption := '新增'
  else
    btnAdd.Caption := '放弃';
end;

procedure TRepairReasonFrm.btnEditClick(Sender: TObject);
begin
  edtReasonCode.Enabled := False;
  cbReasonType.Enabled := btnEdit.Caption = '编辑';
  edtReasonInfo.Enabled := btnEdit.Caption = '编辑';
  cbQualityType.Enabled := btnEdit.Caption = '编辑';
  edtDepartment.Enabled := btnEdit.Caption = '编辑';
  cbOperationCode.Enabled := btnEdit.Caption = '编辑';
  moRemark.Enabled := btnEdit.Caption = '编辑';
  chbIsActive.Enabled := btnEdit.Caption = '编辑';
  gbOperation.Enabled := btnEdit.Caption = '编辑';

  lvMaster.Enabled := btnEdit.Caption = '放弃';
  btnAdd.Enabled := btnEdit.Caption = '放弃';
  btnDelete.Enabled := btnEdit.Caption = '放弃';
  btnSave.Enabled := btnEdit.Caption = '编辑';
  if btnEdit.Caption = '放弃' then
    btnEdit.Caption := '编辑'
  else
    btnEdit.Caption := '放弃';
end;

procedure TRepairReasonFrm.btnDeleteClick(Sender: TObject);
var
  sErrorMsg: WideString;
begin
  if edtReasonCode.Text = '' then exit;
  if MessageDlg('你确认要删除内回修记录吗?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在删除数据稍等！', crHourGlass);
    FNMServerObj.DeleteRepairReason(edtReasonCode.text,'',0,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    lvMaster.DeleteSelected;
    TMsgDialog.ShowMsgDialog('删除数据成功',mtInformation);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;
end;

procedure TRepairReasonFrm.btnSaveClick(Sender: TObject);
var
  vData: OleVariant;
  sErrorMsg: WideString;
  OperationList,IsActive: string;
  i, j: Integer;
begin
  //Check Data
  if (cbReasonType.Text = '') or (edtReasonInfo.Text = '') or (cbQualityType.Text = '') or (cbQualityType.Text = '') then
  begin
    TMsgDialog.ShowMsgDialog('请输入回修类型,回修原因,类型,责任部门',mtError);
    Exit;
  end;
  if chbIsActive.Checked then
    IsActive := '1'
  else
    IsActive := '0';
    
  OperationList := '';
  for i := 0 to lbOperation.Items.Count - 1 do
  begin
    j := Pos('->', lbOperation.Items[i]);
    OperationList := OperationList +  Copy(lbOperation.Items[i],j-3,3) + '/' ;
  end;
  if OperationList<>'' then
    OperationList := Copy(OperationList, 1, Length(OperationList)-1);
    
  vData := VarArrayCreate([0, 1], VarVariant);
  vData[0]:=varArrayOf([edtReasonCode.Text,
                        cbReasonType.Text,
                        edtReasonInfo.Text,
                        Copy(cbOperationCode.Text,1,3),
                        cbQualityType.Text,
                        edtDepartment.Text,
                        moRemark.Text,
                        OperationList,
                        IsActive,
                        Login.LoginName]);
  FNMServerObj.SaveRepairReason(vData,0,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;

 if edtReasonCode.Text = '' then
  begin
    with lvMaster.Items.Add do
    begin
      Caption := 'FR' + RightStr('000'+IntToStr(StrToInt(Copy(Max_Reason_Code,3,3))+1),3);
      SubItems.Add(cbReasonType.Text);
      SubItems.Add(edtReasonInfo.Text);
      SubItems.Add(cbQualityType.Text);
      SubItems.Add(edtDepartment.Text);
      SubItems.Add(cbOperationCode.Text);
      SubItems.Add(moRemark.Text);
      if chbIsActive.Checked then
        SubItems.Add('True')
      else
        SubItems.Add('False');
      SubItems.Add(OperationList);
    end;
  end else
  begin
    with lvMaster.Selected do
    begin
      SubItems[0] := cbReasonType.Text;
      SubItems[1] := edtReasonInfo.Text;
      SubItems[2] := cbQualityType.Text;
      SubItems[3] := edtDepartment.Text;
      SubItems[4] := cbOperationCode.Text;
      SubItems[5] := moRemark.Text;
      if chbIsActive.Checked then
        SubItems[6] := 'True'
      else
        SubItems[6] := 'False';
      SubItems[7] := OperationList;
    end;
  end;

  edtReasonCode.Text := 'FR' + RightStr('000'+IntToStr(StrToInt(Copy(Max_Reason_Code,3,3))+1),3);
  edtReasonCode.Enabled := False;
  cbReasonType.Enabled := False;
  edtReasonInfo.Enabled := False;
  cbQualityType.Enabled := False;
  edtDepartment.Enabled := False;
  cbOperationCode.Enabled := False;
  moRemark.Enabled := False;
  chbIsActive.Enabled := False;
  gbOperation.Enabled := False ;
  lvMaster.Enabled := True;
  btnAdd.Caption := '新增';
  btnAdd.Enabled := True;
  btnEdit.Caption := '编辑';
  btnEdit.Enabled := True;
  btnDelete.Enabled := True;
  btnSave.Enabled := False;
  TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);  
end;

procedure TRepairReasonFrm.sbAddClick(Sender: TObject);
begin
  AddNew  := '1';
  edtItemName.Enabled := sbAdd.Caption = '新增';
  edtItemValue.Enabled := sbAdd.Caption = '新增';
  edtItemName.Clear;
  edtItemValue.Clear;

  lvDetail.Enabled := sbAdd.Caption = '放弃';
  sbEdit.Enabled := sbAdd.Caption = '放弃';
  sbDelete.Enabled := sbAdd.Caption = '放弃';
  sbSave.Enabled :=  sbAdd.Caption = '新增';
  if sbAdd.Caption = '放弃' then
    sbAdd.Caption := '新增'
  else
    sbAdd.Caption := '放弃';
end;

procedure TRepairReasonFrm.sbEditClick(Sender: TObject);
begin
  AddNew  := '0';
  edtItemName.Enabled := sbEdit.Caption = '编辑';
  edtItemValue.Enabled := sbEdit.Caption = '编辑';
  lvDetail.Enabled := sbEdit.Caption = '放弃';
  sbAdd.Enabled := sbEdit.Caption = '放弃';
  sbDelete.Enabled := sbEdit.Caption = '放弃';
  sbSave.Enabled := sbEdit.Caption = '编辑';
  if sbEdit.Caption = '放弃' then
    sbEdit.Caption := '编辑'
  else
    sbEdit.Caption := '放弃';
end;

procedure TRepairReasonFrm.sbDeleteClick(Sender: TObject);
var
  sErrorMsg: WideString;
begin
  if lvDetail.SelCount = 0  then Exit;
  if MessageDlg('你确认要删除此条回修原因明细记录吗?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在删除数据稍等！', crHourGlass);
    FNMServerObj.DeleteRepairReason(edtItemName.Hint,edtItemName.Text,1,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    lvDetail.DeleteSelected;
    TMsgDialog.ShowMsgDialog('删除数据成功',mtInformation);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;
end;

procedure TRepairReasonFrm.sbSaveClick(Sender: TObject);
var
  vData: OleVariant;
  sErrorMsg: WideString;
  i: Integer;
begin
  if edtItemName.Text = '' then Exit;
  //Check Data
  if (AddNew = '1') and (lvDetail.Items.Count > 0) then
    for i := 0 to lvDetail.Items.Count -1 do
      if lvDetail.Items[i].SubItems[0] = edtItemName.Text then Exit;

  vData := VarArrayCreate([0, 1], VarVariant);
  vData[0] := varArrayOf([AddNew,
                          edtItemName.Hint,
                          edtItemName.Text,
                          edtItemValue.Text]);
  FNMServerObj.SaveRepairReason(vData,1,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  if AddNew = '1' then
  begin
    with lvDetail.Items.Add do
    begin
      Caption := lvMaster.Selected.Caption;
      SubItems.Add(edtItemName.Text);
      SubItems.Add(edtItemValue.Text);
    end;
  end else
  begin
    with lvDetail.Selected do
    begin
      SubItems[0] := edtItemName.Text;
      SubItems[1] := edtItemValue.Text;
    end;
  end;
  edtItemName.Enabled := False;
  edtItemValue.Enabled := False;
  lvDetail.Enabled := True;
  sbAdd.Caption := '新增';
  sbAdd.Enabled := True;
  sbEdit.Caption := '编辑';
  sbEdit.Enabled := True;
  sbDelete.Enabled := True;
  sbSave.Enabled := False;
  TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);  
end;

procedure TRepairReasonFrm.lbOperationDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  lbOperation.Canvas.TextOut(Rect.Left,Rect.Top,IntToStr(Index) + ') ' + lbOperation.Items[Index]);
end;

procedure TRepairReasonFrm.sbPreviewClick(Sender: TObject);
begin
  ShowMessage(edtItemName.Text + ':' + #13+ '------------' + #13 + StringReplace(edtItemValue.Text,'/',#13,[rfReplaceAll]));
end;

procedure TRepairReasonFrm.cbbOperationKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: btnAddOperation.Click;
  end;
end;

procedure TRepairReasonFrm.lvMasterChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  i: Integer;
begin
  edtReasonCode.Enabled := False;
  cbReasonType.Enabled := False;
  edtReasonInfo.Enabled :=  False;
  cbQualityType.Enabled := False;
  edtDepartment.Enabled := False;
  cbOperationCode.Enabled := False;
  moRemark.Enabled := False;
  chbIsActive.Enabled := False;
  gbOperation.Enabled := False;
  btnSave.Enabled := False;
  if lvMaster.ItemIndex = -1 then Exit;
  edtReasonCode.Text  := lvMaster.Selected.Caption;
  cbReasonType.Text := lvMaster.Selected.SubItems[0];
  edtReasonInfo.Text := lvMaster.Selected.SubItems[1];
  cbQualityType.Text := lvMaster.Selected.SubItems[2];
  edtDepartment.Text := lvMaster.Selected.SubItems[3];
  cbOperationCode.Text := lvMaster.Selected.SubItems[4];
  moRemark.Text := lvMaster.Selected.SubItems[5];
  chbIsActive.Checked := lvMaster.Selected.SubItems[6] = 'True';
  DumbList.Delimiter :='/';
  DumbList.DelimitedText := lvMaster.Selected.SubItems[7];

  lbOperation.Items.Clear;
  Dictionary.cds_OperationHdrList.Filtered := False;
  for i := 0 to DumbList.Count - 1 do
  begin
    if Dictionary.cds_OperationHdrList.Locate('Operation_Code',DumbList[i],[]) then
      lbOperation.Items.Add(Dictionary.cds_OperationHdrList.FieldByName('Operation_Code').AsString + '->' +
                            Dictionary.cds_OperationHdrList.FieldByName('Operation_CHN').AsString);
  end;

  lvDetail.Clear;
  with Dictionary.cds_RepairReasonList do
  begin
    Filtered := False;
    Filter := 'Reason_Code = ' + QuotedStr(lvMaster.Selected.Caption);
    Filtered := True;
    First;
    while not Eof do
    begin
      with lvDetail.Items.Add do
      begin
        Caption := lvMaster.Selected.Caption;
        SubItems.Add(FieldByName('Item_Name').AsString);
        SubItems.Add(FieldByName('Enum_Value').AsString);
      end;
      Next;
    end;
  end;
end;

procedure TRepairReasonFrm.lvDetailChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  AddNew :='';
  edtItemName.Enabled := False;
  edtItemValue.Enabled := False;
  sbAdd.Enabled := True;
  sbEdit.Enabled := True;
  sbDelete.Enabled := True;
  sbSave.Enabled := False;

  if lvDetail.ItemIndex = -1 then Exit;
  edtItemName.Hint := lvDetail.Selected.Caption;
  edtItemName.Text := lvDetail.Selected.SubItems[0];
  edtItemValue.Text := lvDetail.Selected.SubItems[1];
end;

end.
