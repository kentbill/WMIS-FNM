unit frmDisposeAccident;
{*|<PRE>*****************************************************************************
                                                                             
       ������� FNM CLIENT MODEL
       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                              
       ��Ԫ���� frmDisposeAccident.pas
       �������� 2004-9-8 16:03:06                                              
       ������Ա lvzd                                                           
       �޸���Ա                                                                
       �޸�����
       �޸�ԭ��                                                                
       ��Ӧ����
       �ֶ�����
       ������ݿ��                                                            
       ������Ҫ����/SQL����˵��                                                
       �������� ������
                                                                              
******************************************************************************}

interface

uses
  Windows, Messages,  Classes, Controls, Forms, Dialogs, Buttons,
  ExtCtrls, ComCtrls, Grids, ValEdit, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGrid, cxSplitter,uFNMResource, StdCtrls, CheckLst, DB, DBClient,
  cxDBData, cxGridDBTableView;

type
  TDisposeAccidentForm = class(TForm)
    pnl1: TPanel;
    cxSplitter1: TcxSplitter;
    pnlRight: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edt_BeforeAfter: TEdit;
    edt_DefectName: TEdit;
    edt_Quantity: TEdit;
    edt_Operation_Name: TEdit;
    edt_AccidentNO: TEdit;
    cbb_QualityOperation: TComboBox;
    vle_RepairReasonList: TValueListEditor;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    GroupBox1: TGroupBox;
    lv_Card: TListView;
    cbb_ReasonType: TComboBox;
    cbb_ReasonName: TComboBox;
    cbb_Idea: TComboBox;
    gbOperation: TGroupBox;
    lbOperation: TListBox;
    btnMoveUpOperation: TSpeedButton;
    btnMoveDownOperation: TSpeedButton;
    btnDelOperation: TSpeedButton;
    btnAddOperation: TSpeedButton;
    cbbOperation: TComboBox;
    clbCardList: TCheckListBox;
    Label5: TLabel;
    Label11: TLabel;
    cbHold: TCheckBox;
    btn_Refresh: TBitBtn;
    Label12: TLabel;
    edtRemark: TEdit;
    btnSubmit: TBitBtn;
    tbcAccident: TTabControl;
    cdsAccident: TClientDataSet;
    dsAccident: TDataSource;
    btnSaveRemark: TBitBtn;
    btQueryRemark: TBitBtn;
    gbLeft: TGroupBox;
    cxgrid_AccidentList: TcxGrid;
    cxgtv_AccidentList: TcxGridTableView;
    cxGridl_AccidentList: TcxGridLevel;
    cbb_Class: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure KeyDownAControl(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_SaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lv_CardCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure cbbOperationKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbOperationDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cbb_ReasonTypeSelect(Sender: TObject);
    procedure btnAddOperationClick(Sender: TObject);
    procedure btnDelOperationClick(Sender: TObject);
    procedure btnMoveUpOperationClick(Sender: TObject);
    procedure btnMoveDownOperationClick(Sender: TObject);
    procedure cbb_IdeaSelect(Sender: TObject);
    procedure cbHoldClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
    procedure tbcAccidentChange(Sender: TObject);
    procedure btnSaveRemarkClick(Sender: TObject);
    procedure btQueryRemarkClick(Sender: TObject);
  private
    { Private declarations }
    procedure RefreshAccidentList;
    procedure GetAccidentInfo(AccidentNO: String);
    procedure SaveDisposeAccident;
    procedure SubmitAccident;
    procedure FilterAccident;
    procedure SetBtnState;
    procedure ResetValue;
    procedure SaveDisposeAccidentTrace;
    procedure QueryRemark;
  public
    { Public declarations }
  end;

var
  DisposeAccidentForm: TDisposeAccidentForm;

implementation

uses SysUtils, Graphics, Variants, StrUtils, ServerDllPub, uFNMArtInfo,
    uLogin, uShowMessage, uDictionary, uGlobal, uGridDecorator;

{$R *.dfm}

procedure TDisposeAccidentForm.GetAccidentInfo(AccidentNO: String);
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  sCondition := QuotedStr(AccidentNO);
  FNMServerObj.GetQueryData(vData,'GetAccidentInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetAccidentInfo, [sErrorMsg]);

  TempClientDataSet.Data:=vData[0];
  if TempClientDataSet.IsEmpty then
    raise Exception.CreateRes(@EMP_AccidentInfo);

  with TempClientDataSet do
  begin
    edt_AccidentNO.Text:=FieldByName('Accident_NO').AsString;
    edt_Operation_Name.Text:=FieldByName('Operation_Code').AsString + '->' + FieldByName('Operation_CHN').AsString;
    edt_DefectName.Text:=FieldByName('Defect_Name').AsString;
    edt_Quantity.Text:=FieldByName('Quantity').AsString;
    // ����ID : 292767 ʵ�����Ϳؼ��޸ģ��ҿ��޸ı���	tracy tan add 2017-1-10
    if FieldByName('Quality_Type').AsString='����' then
        begin
         cbb_Class.ItemIndex:=0;
        end
    else   if FieldByName('Quality_Type').AsString='����' then
         begin
          cbb_Class.ItemIndex:=1;
         end
    else   if FieldByName('Quality_Type').AsString='�豸' then
         begin
          cbb_Class.ItemIndex:=2;
          end
    else   if FieldByName('Quality_Type').AsString='����' then
         begin
         cbb_Class.ItemIndex:=3;
         end
    else   if FieldByName('Quality_Type').AsString='����' then
         begin
          cbb_Class.ItemIndex:=4;
         end
    else   if FieldByName('Quality_Type').AsString='' then
         begin
          cbb_Class.ItemIndex:=-1;
         end;
   // cbb_Class.Text:=FieldByName('Quality_Type').AsString;
    edt_BeforeAfter.Text:=FieldByName('Before_After').AsString;
    edtRemark.Text := FieldByName('Remark').AsString;
  end;
  TempClientDataSet.Data:=vData[1];
  FillItemsFromDataSet(TempClientDataSet, 'Item_Name', 'Item_Value', '', '=', vle_RepairReasonList.Strings);

  TempClientDataSet.Data:=vData[2];
  FillListItemsFromDataSet(TempClientDataSet, 'FN_Card', '', ['GF_NO', 'Releaser'], lv_Card.Items);
  clbCardList.Clear;
  with TempClientDataSet do
  begin
    First;
    while not Eof do
    begin
      clbCardList.Items.Add(FieldByName('FN_Card').AsString);
      Next;
    end;
  end;
end;

procedure TDisposeAccidentForm.SaveDisposeAccident;
var
  i, j: Integer;
  Accident_NO, QualityOperation, DisposeInfo, ReasonCode: string;
  RepairCardList,RepairOperation,UnHoldCardList: String;
  sCondition,sErrorMsg: WideString;
  IsTrace:Integer;
begin
  if edt_AccidentNO.Text = '' then exit;
  //���޿���
  RepairCardList := '';
  for i := 0 to clbCardList.Items.Count - 1 do
  begin
    if clbCardList.Checked[i] then
      RepairCardList := RepairCardList + clbCardList.Items[i] + ',';
  end;
  if RepairCardList<>'' then
    RepairCardList := Copy(RepairCardList, 1, Length(RepairCardList)-1);
  //���޹���
  RepairOperation := '';
  for i := 0 to lbOperation.Items.Count - 1 do
  begin
    j := Pos('->', lbOperation.Items[i]);
    RepairOperation := RepairOperation +  Copy(lbOperation.Items[i],j-3,3) + '/' ;
  end;
  if RepairOperation<>'' then
    RepairOperation := Copy(RepairOperation, 1, Length(RepairOperation)-1);
  //ȡ��HOLD����
  UnHoldCardList:='';
  for i := 0 to lv_Card.Items.Count - 1 do
  begin
    if (lv_Card.Items.Item[i].Checked) and (lv_Card.Items.Item[i].SubItems.Strings[1] = '') then
      UnHoldCardList:=UnHoldCardList + lv_Card.Items.Item[i].Caption + ',';
  end;
  if UnHoldCardList<>'' then
    UnHoldCardList := Copy(UnHoldCardList, 1, Length(UnHoldCardList)-1);

  Accident_NO := edt_AccidentNO.Text;
  QualityOperation := Copy(cbb_QualityOperation.Text,1,3);
  DisposeInfo := cbb_Idea.Text;
  ReasonCode := Copy(cbb_ReasonName.Text,1,5);
  if Pos('����',DisposeInfo) > 0 then
  begin
    if ReasonCode = '' then
    begin
      TMsgDialog.ShowMsgDialog('��ѡ�����ԭ��',mtError);
      cbb_ReasonName.SetFocus;
      Exit;
    end;
    if (RepairCardList = '') or (RepairOperation = '') then
    begin
      TMsgDialog.ShowMsgDialog('��ѡ����޿��źͻ��޹���',mtError);
      Exit;
    end;
    if (QualityOperation = '') then
    begin
      TMsgDialog.ShowMsgDialog('��ѡ�����ι���',mtError);
      Exit;
    end;
  end;
  if edtRemark.Text = '' then
  begin
    TMsgDialog.ShowMsgDialog('�����봦��ע��',mtError);
    edtRemark.SetFocus;
    Exit;
  end;
  //  istrace = 0 ����Ҫ���� =1 ����Ҫ����
  IsTrace:= 0;
  if TMsgDialog.ShowMsgDialog('�Ƿ���ٴ�����', mtConfirmation, [mebYes, mebNo], mebYes)= mrYes then
  begin
    IsTrace:= 0;
  end
  else 
  begin
    IsTrace:= 1;
  end; 
  if IsTrace < 0 then
    IsTrace:= 0;

  sCondition := QuotedStr(Accident_NO)+','+ QuotedStr(QualityOperation)+','+
                QuotedStr(DisposeInfo)+','+ QuotedStr(ReasonCode)+','+
                QuotedStr(RepairCardList)+','+ QuotedStr(RepairOperation)+','+
                QuotedStr( UnHoldCardList)+','+ QuotedStr( Login.LoginName)+ ',' +
                QuotedStr(edtRemark.Text) + ',' + IntToStr(IsTrace)+ ',' +
                QuotedStr(cbb_Class.Text);  // ����ID : 292767 ʵ�����Ϳؼ��޸ģ��ҿ��޸ı���	tracy tan add 2017-1-10
  FNMServerObj.SaveDataBySQL('SaveDisposeInfo',sCondition,sErrorMsg);
//  FNMServerArtObj.SaveDisposeInfo(Accident_NO,QualityOperation, DisposeInfo, ReasonCode, RepairCardList,
  //          RepairOperation, UnHoldCardList, Login.LoginName,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveDisposeAccident, [sErrorMsg]);

  btn_Save.Enabled := False;
end;

procedure TDisposeAccidentForm.RefreshAccidentList;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  FNMServerArtObj.GetAccidentNOList('NoDisposeAccident', Login.CurrentDepartment, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetNoDisposeAccident, [sErrorMsg]);

  cdsAccident.Data:=vData;
  if cdsAccident.IsEmpty then
    raise Exception.CreateRes(@EMP_NoDisposeAccident);

  FilterAccident;
end;

procedure TDisposeAccidentForm.FormCreate(Sender: TObject);
begin
  btn_Save.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  cxgtv_AccidentList.OnDblClick:=TGlobal.DblClickAWinControl;
  cbbOperation.Align := alClient;
  //btn_Save.Enabled:=false;
  SetBtnState;
end;

procedure TDisposeAccidentForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  RefreshAccidentList;
  //��乤��ѡ���б�
  FillItemsFromDataSet(Dictionary.cds_OperationHdrList, 'Operation_Code', 'Operation_CHN', 'Operation_Code','->', cbb_QualityOperation.Items);
  cbbOperation.Items := cbb_QualityOperation.Items;
  cbbOperation.OnDblClick := TGlobal.DblClickAWinControl;
  //�������
  cbb_Idea.Items.Text := Dictionary.GetItemList('�������','','');

  //����õ����
  with Dictionary,Dictionary.cds_RepairReasonList do
  try
    if Pos('1',Login.UserLevelList)>0  then
       Filter:='Quality_Type = '+QuotedStr('����')
    else if Pos('2',Login.UserLevelList)>0 then
      Filter:='Quality_Type = '+QuotedStr('����')
    else
      Filter:='';

    Filtered:=true;
    FillItemsFromDataSet(Dictionary.cds_RepairReasonList, 'Reason_Type', '', '','', cbb_ReasonType.Items);
  finally
     Filtered:=False;
  end;
  OnActivate := nil;
end;

procedure TDisposeAccidentForm.FormDestroy(Sender: TObject);
begin
  DisposeAccidentForm := nil;
end;

procedure TDisposeAccidentForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TDisposeAccidentForm.KeyDownAControl(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  AccidentNO: String;
begin
  if Sender = cxgtv_AccidentList.Site then
  case Key of
    VK_RETURN:
    begin
      if cxgtv_AccidentList.Controller.SelectedRowCount = 0 then exit;
      AccidentNO:=cxgtv_AccidentList.Controller.SelectedRows[0].Values[cxgtv_AccidentList.FindItemByName('Accident_NO').Index];
      if Copy(AccidentNO,1,2)<>'AN' then Exit;
      //������ϸ��Ϣ
      GetAccidentInfo(AccidentNO);
      //FilterAccident;
      SetBtnState;
    end;
  end;
end;

procedure TDisposeAccidentForm.btn_SaveClick(Sender: TObject);
begin
  SaveDisposeAccident;
end;

procedure TDisposeAccidentForm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TDisposeAccidentForm.lv_CardCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  if Item = nil then Exit;

  if Item.SubItems.Strings[1] <> '' then
  begin
    Sender.Canvas.Font.Color:= clGrayText;
    Item.Checked := True;
  end;
end;

procedure TDisposeAccidentForm.cbbOperationKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: btnAddOperation.Click;
  end;
end;

procedure TDisposeAccidentForm.lbOperationDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  lbOperation.Canvas.TextOut(Rect.Left,Rect.Top,IntToStr(Index) + ') ' + lbOperation.Items[Index]);
end;

procedure TDisposeAccidentForm.cbb_ReasonTypeSelect(Sender: TObject);
begin
  cbb_ReasonName.ItemIndex:= -1;
  if cbb_ReasonType.ItemIndex = -1 then exit;
  with Dictionary, Dictionary.cds_RepairReasonList do
  try
    if Pos('1',Login.UserLevelList)>0 then
      Filter:='Quality_Type = '+QuotedStr('����') + ' AND Reason_Type = ' +QuotedStr(cbb_ReasonType.Text)
    else if Pos('2',Login.UserLevelList)>0 then
      Filter:='Quality_Type = '+QuotedStr('����') + ' AND Reason_Type = ' +QuotedStr(cbb_ReasonType.Text)
    else
      Filter:= 'Reason_Type = ' +QuotedStr(cbb_ReasonType.Text);
    Filtered:=true;
    FillItemsFromDataSet(cds_RepairReasonList, 'Reason_Code', 'Reason_Info', '', '->', cbb_ReasonName.Items);
  finally
    Filtered:=False;
  end;
end;

procedure TDisposeAccidentForm.btnAddOperationClick(Sender: TObject);
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

procedure TDisposeAccidentForm.btnDelOperationClick(Sender: TObject);
begin
 with lbOperation do
   if ItemIndex <> -1 then
     DeleteSelected;
end;

procedure TDisposeAccidentForm.btnMoveUpOperationClick(Sender: TObject);
begin
  with lbOperation do
  begin
    if ItemIndex = 0 then Exit;
    if ItemIndex <> -1 then
      Items.Exchange(ItemIndex,ItemIndex -1);
  end;
end;

procedure TDisposeAccidentForm.btnMoveDownOperationClick(Sender: TObject);
begin
  with lbOperation do
  begin
    if ItemIndex = Items.Count - 1 then Exit;
    if ItemIndex <> -1 then
      Items.Exchange(ItemIndex,ItemIndex +1);
  end;
end;

procedure TDisposeAccidentForm.cbb_IdeaSelect(Sender: TObject);
var
 i: Integer;
begin
  if cbb_Idea.ItemIndex = -1 then exit;
  if cbb_Idea.Text = 'OK' then
  begin
    for i := 0 to clbCardList.Items.Count - 1 do
      clbCardList.Checked[i] := False;
    for i := 0 to lv_Card.Items.Count - 1 do
      lv_Card.Items[i].Checked := True;
  end;
   if cbb_Idea.Text = 'ȫ������' then
  begin
    for i := 0 to clbCardList.Items.Count - 1 do
      clbCardList.Checked[i] := True;
    for i := 0 to lv_Card.Items.Count - 1 do
      lv_Card.Items[i].Checked := False;
  end;
end;

procedure TDisposeAccidentForm.cbHoldClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to lv_Card.Items.Count - 1 do
    lv_Card.Items[i].Checked := cbHold.Checked;
end;

procedure TDisposeAccidentForm.btn_RefreshClick(Sender: TObject);
begin
  RefreshAccidentList;
end;

procedure TDisposeAccidentForm.btnSubmitClick(Sender: TObject);
begin
  SubmitAccident;
end;

procedure TDisposeAccidentForm.SubmitAccident;
var
  sSQL, sErrMsg:WideString;
  Grade:Integer;
  AccidentNO:String;
begin
  AccidentNO :=edt_AccidentNO.Text;
  if AccidentNO= '' then
  begin
    TMsgDialog.ShowMsgDialog('��ѡ��Ҫ�ύ�ĵ�',mtInformation);
    Exit;
  end;

  if edtRemark.Text = '' then
  begin
    TMsgDialog.ShowMsgDialog('�����봦��ע��',mtError);
    edtRemark.SetFocus;
    Exit;
  end;

  cdsAccident.DisableControls;
  if cdsAccident.Locate('Accident_NO', AccidentNO,[]) then
  begin
    Grade := cdsAccident.FieldByName('Grade').AsInteger;
    if Grade= 4 then
    begin  
      TMsgDialog.ShowMsgDialog('�Ѿ��ύ����߼����޷��ύ',mtWarning);
      Exit;
    end;

    cdsAccident.Edit;
    cdsAccident.FieldByName('Grade').AsInteger := Grade+1;
    cdsAccident.Post;

    //�ύʱ����עҲ���½�ȥ
    sSQL := QuotedStr(AccidentNO)+ ','+ QuotedStr(Trim(edtRemark.Text)) + ',' + IntToStr(Grade)+ ','+ QuotedStr(Login.LoginName);
    FNMServerObj.SaveDataBySQL('fnDisposeAccident',sSQL,sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
      Exit;
    end;
  end;
  FilterAccident;
  TMsgDialog.ShowMsgDialog('�ύ�ɹ���',mtInformation);
  cdsAccident.EnableControls;
end;

procedure TDisposeAccidentForm.tbcAccidentChange(Sender: TObject);
begin
  FilterAccident;
  ResetValue;
end;

procedure TDisposeAccidentForm.FilterAccident;
var
  iGrade:Integer;
begin
  if not cdsAccident.Active then Exit;

  iGrade := tbcAccident.TabIndex+1;

  cdsAccident.Filtered := False;
  cdsAccident.Filter := 'Grade= '+ IntToStr(iGrade);
  cdsAccident.Filtered := True;


  GridDecorator.BindcxTableView(cxgtv_AccidentList, cdsAccident, ['Accident_NO', 'GF_NO', 'Quantity', 'Quality_Type', 'Grade', 'Machine_ID', 'Operate_Time']);
  cxgtv_AccidentList.Columns[cxgtv_AccidentList.FindItemByName('Grade').Index].Visible := False;

  with cxgtv_AccidentList.Columns[cxgtv_AccidentList.FindItemByName('Quality_Type').Index] do
  begin
    GroupIndex := 0;
    Visible := False;
  end;

  SetBtnState;
end;

procedure TDisposeAccidentForm.SetBtnState;
begin
  btn_Save.Enabled:= edt_AccidentNO.Text<>'';
  btnSubmit.Enabled := (edt_AccidentNO.Text<>'') and (tbcAccident.TabIndex<3);
  btnSaveRemark.Enabled:= edt_AccidentNO.Text<>'';

  cbb_QualityOperation.Enabled := btn_Save.Enabled;
  cbb_ReasonType.Enabled := btn_Save.Enabled;
  edtRemark.Enabled := btn_Save.Enabled;
  cbb_Idea.Enabled := btn_Save.Enabled;
  cbb_ReasonName.Enabled := btn_Save.Enabled;
end;

procedure TDisposeAccidentForm.ResetValue;
begin
  edt_AccidentNO.Text:= '';
  edt_Operation_Name.Text:= '';
  edt_DefectName.Text:= '';
  edt_Quantity.Text:= '';
  cbb_Class.ItemIndex:=-1;  // ����ID : 292767 ʵ�����Ϳؼ��޸ģ��ҿ��޸ı���	tracy tan add 2017-1-10
  //edt_Class.Text:= '';
  edt_BeforeAfter.Text:= '';
  edtRemark.Text := '';
  SetBtnState;
end;

procedure TDisposeAccidentForm.btnSaveRemarkClick(Sender: TObject);
begin
  SaveDisposeAccidentTrace;
end;

procedure TDisposeAccidentForm.SaveDisposeAccidentTrace;
var
  sRemark, sCondition, sErrMsg:WideString;
begin
  if edt_AccidentNO.Text = '' then Exit;

  sRemark := InputBox('��������������','�´�����:','');

  if sRemark= '' then Exit;

  sCondition := QuotedStr(edt_AccidentNO.Text)+ ','
              + QuotedStr(sRemark)+ ','
              + QuotedStr(Login.LoginName);
  FNMServerObj.SaveDataBySQL('SaveDisposeTraceInfo',sCondition,sErrMsg);
  if sErrMsg <> '' then
  begin
    raise ExceptionEx.CreateResFmt(@ERR_SaveDisposeAccident, [sErrMsg]);
    Exit;
  end;

  TMsgDialog.ShowMsgDialog('���ӳɹ���',mtInformation);
end;

procedure TDisposeAccidentForm.btQueryRemarkClick(Sender: TObject);
begin
  QueryRemark;
end;

procedure TDisposeAccidentForm.QueryRemark;
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
  AccidentNO:string;
begin
  AccidentNO := cxgtv_AccidentList.Controller.SelectedRows[0].Values[cxgtv_AccidentList.FindItemByName('Accident_NO').Index];
  sCondition := '3,' + QuotedStr(Login.CurrentDepartment) + ',' + QuotedStr(AccidentNO);
  FNMServerObj.GetQueryData(vData,'GetDisposeAccidentInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TempClientDataSet.Data:=vData;
  if TempClientDataSet.FieldByName('Remarks').AsString = '����������£�' + Char(13)+ Char(10) then
  begin
    TMsgDialog.ShowMsgDialog('û�д������',mtInformation);
    Exit;
  end;
  TMsgDialog.ShowMsgDialog(TempClientDataSet.FieldByName('Remarks').AsString,mtConfirmation);
end;

end.
