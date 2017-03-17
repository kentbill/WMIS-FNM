{******************************************************************************

       ������� WMIS ����FNM
       �ļ����� frmAddTask
       ��Ȩ���� (C) 2013 ESQUEL GROUP GET/IT
       �������� 2013-11-08 
       ������Ա APJ zhaogang  ���վ������Ը�
       �޸���Ա
       �޸�����
       �޸�ԭ��
       ��Ӧ����
       �ֶ�����
       ������ݿ��
       ������Ҫ����/SQL����˵��
       ��������  �������ϸ�Ʒ�¹�������Ϣ
       �ֶ�������
            private
                cdsRA : TClientDataSet;                                                                   //����fnRejectHdr���ѯ
                cdsJAC : TClientDataSet;                                                                  //����Ʒ����ѯ
                cdsDefect : TClientDataSet;                                                               //���ڴõ��ѯ
                GGfid : String;                                                                           //����Ʒ��ID
                GNoteNO : string;                                                                         //����Note_NO
        ����������
           private
                procedure Initialise;                                                                     //��ʼ������ؼ����������
                procedure FreeCDS;                                                                        //�ͷ�ClientDataSet
                //ҵ���������
                procedure QueryRejectAccidentData;                                                        //��ѯ fnRejectHdr �����ݷ���
                procedure QueryData(sourceCDS : TClientDataSet;const aType : String; aSQL : WideString);  //ͨ�ò�ѯ���ݷ���
                procedure QueryJobNoAndCustomerInfo(GF_NO : String);                                      //ͨ��Ʒ�������ŵ����б�Ϳͻ�
                procedure QueryReason;                                                                    //��ѯ�õ��б�
                function getNewNoteNO : String;                                                           //�����µ�Note_NOֵ
                procedure SaveRejectAccidentData;                                                          //��������д�����ݵ�ClientDataSet
                procedure SaveData(aData : OleVariant);                                                    //�������ݵ� fnRejectHdr ��
                procedure Cancel;
                //������Ʒ���
                procedure controlWinControl(isEnabled : Boolean);                                           //���ƿ��ӿռ��Enabledֵ��Colorֵ
                procedure FillJobNoToComboBox;                                                              //����ŵ����ݵ�ComboBox
                procedure FillCustomerToEdit;                                                               //���ͻ����ݵ�Edit
                procedure FillReasonToComboBox;                                                             //���õ����ݵ��õ�ComboBox
                function checkNull : Boolean;                                                               //����ֵ
           public
                function getNoteNO : String;                                                                //����Note_NO

******************************************************************************}

unit frmAddTask;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBClient, Buttons, Grids, DBGrids, ADODB;

type
  {
  TTaskData = class(TObject)
  private
    GFG_ID : String;
    GFG_NO : String;
    GJod_NO : String;
    GCustomer : String;
    GType : string;
    GRejectQTY : string;
    GDefect : string;
    GFN_Cards : string;
  published
    property FG_ID : String read GFG_ID;
    property FG_NO : String read GFG_NO;
    property Jod_NO : String read GJod_NO;
    property Customer : String read GCustomer;
    property TaskType : string read GType;
    property RejectQTY : string read GRejectQTY;
    property Defect : string read GDefect;
    property FN_Cards : string read GFN_Cards;
  end;
  }

  TAddTaskForm = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    edtGFNO: TEdit;
    cbbJobNoList: TComboBox;
    cbbTypeList: TComboBox;
    edtRejectQTY: TEdit;
    cbbDefectList: TComboBox;
    edtFNCards: TEdit;
    btnSave: TButton;
    btnCancel: TButton;
    btnFind: TSpeedButton;
    edtCustomer: TEdit;
    ds1: TClientDataSet;
    cbbDept: TComboBox;
    lbl8: TLabel;
    qry1: TADOQuery;
    btn1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbbJobNoListChange(Sender: TObject);
    procedure cbbJobNoListKeyPress(Sender: TObject; var Key: Char);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    cdsRA : TClientDataSet;                                                                   //����fnRejectHdr���ѯ
    cdsJAC : TClientDataSet;                                                                  //����Ʒ����ѯ
    cdsDefect : TClientDataSet;                                                               //���ڴõ��ѯ
    //GTaskData : TTaskData;
    GGfid : String;                                                                           //����Ʒ��ID
    GNoteNO : string;                                                                         //����Note_NO
    procedure Initialise;                                                                     //��ʼ������ؼ����������
    procedure FreeCDS;                                                                        //�ͷ�ClientDataSet
    {ҵ��}
    procedure QueryRejectAccidentData;                                                        //��ѯ fnRejectHdr �����ݷ���
    procedure QueryData(sourceCDS : TClientDataSet;const aType : String; aSQL : WideString);  //ͨ�ò�ѯ���ݷ���
    procedure QueryJobNoAndCustomerInfo(GF_NO : String);                                      //ͨ��Ʒ�������ŵ����б�Ϳͻ�
    procedure QueryReason;                                                                    //��ѯ�õ��б�
    function getNewNoteNO : String;                                                           //�����µ�Note_NOֵ
    //procedure UpdateData;
    procedure SaveRejectAccidentData;                                                          //��������д�����ݵ�ClientDataSet
    //procedure SavaToTaskObject;
    procedure SaveData(aData : OleVariant);                                                    //�������ݵ� fnRejectHdr ��
    procedure Cancel;
    {�������}
    procedure controlWinControl(isEnabled : Boolean);                                           //���ƿ��ӿռ��Enabledֵ��Colorֵ
    procedure FillJobNoToComboBox;                                                              //����ŵ����ݵ�ComboBox
    procedure FillCustomerToEdit;                                                               //���ͻ����ݵ�Edit
    procedure FillReasonToComboBox;                                                             //���õ����ݵ��õ�ComboBox
    function checkNull : Boolean;                                                               //����ֵ
    procedure clean;
  public
    function getNoteNO : String;                                                                //����Note_NO
  end;

var
  AddTaskForm: TAddTaskForm;

implementation

uses uShowMessage, ServerDllPub, uGlobal;

{$R *.dfm}

procedure TAddTaskForm.FreeCDS;
begin
  if Assigned(cdsJAC) then
  begin
    cdsJAC.Close;
    FreeAndNil(cdsJAC);
  end;

  if Assigned(cdsDefect) then
  begin
    cdsDefect.Close;
    FreeAndNil(cdsDefect);
  end;

  if Assigned(cdsRA) then
  begin
    cdsRA.Close;
    FreeAndNil(cdsRA);
  end;//if
end;

procedure TAddTaskForm.Initialise;
begin
  self.BorderIcons := [];
  self.Position := poScreenCenter;

  cdsJAC := TClientDataSet.Create(nil);
  cdsDefect := TClientDataSet.Create(nil);
  cdsRA :=  TClientDataSet.Create(nil);

  cbbTypeList.Items.Add('�ڻ���');
  cbbTypeList.Items.Add('�����');
  cbbTypeList.Items.Add('����');

  cbbDept.Items.Add('FA');
  cbbDept.Items.Add('FG');

  //btnSave.ModalResult := mrOk;
  //btnCancel.ModalResult := mrCancel;
  edtCustomer.ReadOnly := true;
  controlWinControl(false);
  QueryRejectAccidentData;
end;

procedure TAddTaskForm.FormCreate(Sender: TObject);
begin
  Initialise;
end;

procedure TAddTaskForm.QueryJobNoAndCustomerInfo(GF_NO : String);
var
  sSQL : WideString;
begin
  sSQL := QuotedStr('GetJobNoAndCustomerList') + ','+ QuotedStr(GF_NO);
  QueryData(cdsJAC, 'QueryAccidentRecordRelevantInfo', sSQL);
end;

procedure TAddTaskForm.QueryReason;
var
  sSQL: WideString;
begin
  sSQL := QuotedStr('GetReasonList') + ',' + QuotedStr('');
  QueryData(cdsDefect, 'QueryAccidentRecordRelevantInfo', sSQL);
end;

function TAddTaskForm.getNewNoteNO: String;
var
  cds : TClientdataSet;
  sSQL : string;
begin
  cds := TClientdataSet.Create(nil);
  try
  sSQL := QuotedStr('GetRejectHdrNewNote_NO') + ',' + QuotedStr(cbbDept.Text);
  QueryData(cds, 'QueryAccidentRecordRelevantInfo', sSQL);
  Result := cds.FieldByName('New_Note_NO').AsString;
  finally
    cds.Close;
    FreeAndNil(cds);
  end;
end;

procedure TAddTaskForm.QueryRejectAccidentData;
var
  vData : OleVariant;
  sSQL, sErrMsg: WideString;
begin
  ShowStatusMessage('���ڲ�ѯ�Եȣ�', crHourGlass);
  try
    sSQL := '2,' + QuotedStr('1=2');
    cdsRA.Close;
    FNMServerObj.GetQueryData(vData,'fnGetRejectAccidentRecord', sSQL, sErrMsg);  // 'QueryAccidentRecordRelevantInfo'
    if sErrMsg = '' then
    begin
      cdsRA.Data := vData[0];
    end else
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;//else
  finally
    ShowStatusMessage('', crDefault);
  end;//finally
end;


procedure TAddTaskForm.controlWinControl(isEnabled: Boolean);
var
  color : TColor;
begin
  if isEnabled then
    color := clWindow
  else
    color := clBtnFace;

  cbbJobNoList.Enabled := isEnabled;
  edtCustomer.Enabled := isEnabled;
  cbbTypeList.Enabled := isEnabled;
  edtRejectQTY.Enabled := isEnabled;
  cbbDefectList.Enabled := isEnabled;
  cbbDept.Enabled := isEnabled;
  edtFNCards.Enabled := isEnabled;

  cbbJobNoList.Color := color;
  edtCustomer.Color := color;
  cbbTypeList.Color := color;
  edtRejectQTY.Color := color;
  cbbDefectList.Color := color;
  cbbDept.Color := color;
  edtFNCards.Color := color;

  btnSave.Enabled := isEnabled;
end;

procedure TAddTaskForm.FillJobNoToComboBox;
begin
  if cdsJAC.RecordCount > 0 then
  begin
    cbbJobNoList.Clear;
    cdsJAC.First;
    GGfid := cdsJAC.FieldByName('GF_ID').AsString;
    while not cdsJAC.Eof do
    begin
      cbbJobNoList.Items.Add(cdsJAC.FieldByName('Job_NO').AsString);
      cdsJAC.Next;
    end;//while
    cbbJobNoList.Enabled := True;
    cbbJobNoList.Color := clWindow;
  end;//if
end;

procedure TAddTaskForm.FillCustomerToEdit;
begin
  if cdsJAC.Active  then
  begin
    cdsJAC.Filter := 'Job_NO = ' + QuotedStr(cbbJobNoList.Text);
    cdsJAC.Filtered := true;
    cdsJAC.First;
    edtCustomer.Text := cdsJAC.FieldByName('Customer').AsString;
    cdsJAC.Filtered := false;
    cdsJAC.Filter := '';
    controlWinControl(True);
  end;//if
end;

procedure TAddTaskForm.FillReasonToComboBox;
begin
  if cdsDefect.RecordCount > 0 then
  begin
    cbbDefectList.Clear;
    cdsDefect.First;
    while not cdsDefect.Eof do
    begin
      cbbDefectList.Items.Add(cdsDefect.FieldByName('Reason_Info').AsString);
      cdsDefect.Next;
    end;//while
  end;//if
end;


procedure TAddTaskForm.btnFindClick(Sender: TObject);
begin        
  if edtGFNO.Text <> '' then
  begin
    QueryJobNoAndCustomerInfo(edtGFNO.Text);
    if cdsJAC.RecordCount > 0 then
    begin
      QueryReason;

      FillJobNoToComboBox;
      FillReasonToComboBox;
    end else
    begin
      controlWinControl(false);
      clean;
    end;
  end;//if
end;

procedure TAddTaskForm.btnCancelClick(Sender: TObject);
begin
  Cancel;
  self.Close;
end;

procedure TAddTaskForm.QueryData(sourceCDS: TClientDataSet;const aType : String; aSQL: WideString);
var
  vData : OleVariant;
  sErrMsg : WideString;
begin
  try
    ShowStatusMessage('���ڲ�ѯ�Եȣ�', crHourGlass);

    sourceCDS.Close;
    FNMServerObj.GetQueryData(vData,aType, aSQL, sErrMsg);  // 'QueryAccidentRecordRelevantInfo'
    if sErrMsg = '' then
    begin
      sourceCDS.Data := vData;
    end else
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;//else
  finally
    ShowStatusMessage('', crDefault);
  end;//finally
end;

procedure TAddTaskForm.SaveRejectAccidentData;
var
  vData : OleVariant;
begin
   //GF_ID, GF_NO, Job_NO, GF_NO, Type, Customer, FN_Cards,Dept, Defects ,Reject_QTY,Operate_Time
  cdsRA.Append;
  GNoteNO := getNewNoteNO;
  cdsRA.FieldByName('Note_NO').AsString := GNoteNO;                 //Note_NO
  cdsRA.FieldByName('GF_ID').AsString := GGfid;                    //Ʒ��ID
  cdsRA.FieldByName('GF_ID').AsString := GGfid;                    //Ʒ��ID
  cdsRA.FieldByName('GF_NO').AsString := edtGFNO.Text;             //Ʒ��
  cdsRA.FieldByName('Job_NO').AsString := cbbJobNoList.Text;       //�ŵ�
  cdsRA.FieldByName('Customer').AsString := edtCustomer.Text;       //�ͻ�
  cdsRA.FieldByName('Type').AsString := cbbTypeList.Text;          //����
  cdsRA.FieldByName('Reject_QTY').AsString := edtRejectQTY.Text;    //���ϸ���
  cdsRA.FieldByName('Dept').AsString := cbbDept.Text;               //����
  cdsRA.FieldByName('Defects').AsString := cbbDefectList.Text;     //�õ�����
  cdsRA.FieldByName('FN_Cards').AsString := edtFNCards.Text;       //����
  cdsRA.FieldByName('Operate_Time').AsString := FormatDateTime('YYYY-MM-DD HH:00:00',now);
  cdsRA.Post;
  if TGlobal.DeltaIsNull(cdsRA) then
    Exit;
  SaveData(cdsRA.Delta);
end;

{
procedure TAddTaskForm.SavaToTaskObject;
begin
  GTaskData.GFG_ID := GGfid;
  GTaskData.GFG_NO := edtGFNO.Text;
  GTaskData.GJod_NO := cbbJobNoList.Text;
  GTaskData.GCustomer := edtCustomer.Text;
  GTaskData.GType := cbbTypeList.Text;
  GTaskData.GRejectQTY := edtRejectQTY.Text;
  GTaskData.GDefect := cbbDefectList.Text;
  GTaskData.GFN_Cards := edtFNCards.Text;
end;
}

procedure TAddTaskForm.SaveData(aData: OleVariant);
var
  sErrMsg : WideString;
begin
  try
    ShowStatusMessage('���ڱ�������...', crHourGlass);

    FNMServerObj.SaveBaseTableInfo(aData, 'fnRejectHdr','',sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;//if
  finally
    ShowStatusMessage('', crDefault);
  end;//finally
end;

procedure TAddTaskForm.btnSaveClick(Sender: TObject);
begin
  if checkNull then
  begin
    SaveRejectAccidentData;
    self.Close;
  end;
end;

procedure TAddTaskForm.Cancel;
begin
  if (cdsRA.State = dsInsert) or (cdsRA.State = dsEdit)  then
    cdsRA.Cancel;
end;

procedure TAddTaskForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeCDS;
  Action := caFree;
end;

{
procedure TAddTaskForm.UpdateData;
begin
  GGfid := cdsRA.FieldByName('GF_ID').AsString;                    //Ʒ��ID
  edtGFNO.Text := cdsRA.FieldByName('GF_NO').AsString;             //Ʒ��
  cbbJobNoList.Text := cdsRA.FieldByName('Job_NO').AsString;       //�ŵ�
  edtCustomer.Text := cdsRA.FieldByName('Customer').AsString;       //�ͻ�
  cbbTypeList.Text := cdsRA.FieldByName('Type').AsString;          //����
  edtRejectQTY.Text := cdsRA.FieldByName('Reject_QTY').AsString;    //���ϸ���
  cbbDefectList.Text := cdsRA.FieldByName('Defects').AsString;     //�õ�����
  edtFNCards.Text := cdsRA.FieldByName('FN_Cards').AsString;       //����

  QueryJobNoAndCustomerInfo(edtGFNO.Text);
  QueryReason;
  getCustomerToEdit;
end;
}

procedure TAddTaskForm.cbbJobNoListChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> '' then
    FillCustomerToEdit;
end;

function TAddTaskForm.checkNull: Boolean;
var
  i : Integer;
begin
  Result := true;
  for i := 0 to ControlCount - 1 do
  begin
    if (self.Controls[i] is TComboBox) then
    begin
      if TComboBox(self.Controls[i]).Text = '' then
      begin
        TComboBox(self.Controls[i]).SetFocus;
        Result := False;
      end;//if
    end else if (self.Controls[i] is TEdit) then
    begin
      if TEdit(self.Controls[i]).Text = '' then
      begin
        TEdit(self.Controls[i]).SetFocus;
        Result := False;
      end;//if
    end;//else
  end;//for
end;

procedure TAddTaskForm.clean;
var
  i : Integer;
begin
  for i := 0 to ControlCount - 1 do
  begin
    if (self.Controls[i] is TComboBox) then
      TComboBox(self.Controls[i]).Text := ''
    else if (self.Controls[i] is TEdit) then
      TEdit(self.Controls[i]).Text := '';
  end;//for
end;

function TAddTaskForm.getNoteNO: String;
begin
  Result := '';
  if GNoteNO <> '' then
    Result := GNoteNO;
end;

procedure TAddTaskForm.cbbJobNoListKeyPress(Sender: TObject;
  var Key: Char);
begin
  key := #0;//����Ϊֻ��
end;

procedure TAddTaskForm.btn1Click(Sender: TObject);
begin
  Self.Caption := getNewNoteNO;
end;

end.
