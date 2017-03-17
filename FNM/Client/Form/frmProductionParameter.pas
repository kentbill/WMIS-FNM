{******************************************************************************
       ������� WMIS ����FNM
       �ļ����� frmProductionParameter
       ��Ȩ���� (C) 2013 ESQUEL GROUP GET/IT
       �������� 2013-11-18
       ������Ա APJ zhaogang  ���վ������Ը�
       �޸���Ա
       �޸�����
       �޸�ԭ��
       ��Ӧ����
       ���ݿ�
            ��
              FNMDB.dbo.fnProductionParameter
            ��ر�:
              FNMDB.dbo.fnoperationHdrlist
       ������Ҫ����/SQL����˵��
            �洢����
              FNMDB.dbo.usp_fnProductionParameterData
******************************************************************************}
{
���������
����
  ������ť ���������޸ģ�ɾ��ʧЧ, ���桢ȡ����Ч ����ά����Ϣ������ ����(��������������ظ����ϲ��裩 �������水ť �������浽���ݿ�

�޸�
  ѡ������ �����޸İ�ť ��������������ɾ��ʧЧ, ���桢ȡ����Ч ����ά����Ϣ������ �������水ť �������浽���ݿ�

ɾ��
  ѡ������ ���� ɾ����ť ���� ���桢ȡ����Ч �������水ť �������浽���ݿ�
}

unit frmProductionParameter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxSplitter, StdCtrls, ExtCtrls, Grids, DBGrids, DB,
  DBClient, DBCtrls, frmBase, Buttons;

const
  rsTable = 'fnProductionParameter'; //�����

type
  TStateType = (isInit, isBrowse, isAdd, isUpdate, isDel, isSave, isCancel); //��ʼ�������, �������޸ģ�ɾ�������棬ȡ�� 

  TProductionParameterForm = class(TBaseForm)
    grpTop: TGroupBox;
    cxSplitter1: TcxSplitter;
    grpClient: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    dbgrdPP: TDBGrid;
    pnlTop: TPanel;
    lbl4: TLabel;
    edtQueryCode: TEdit;
    btnQuery: TButton;
    pnlBottom: TPanel;
    pnlRight: TPanel;
    cdsFnOperationHdrList: TClientDataSet;
    cdsFnProductionParameter: TClientDataSet;
    dsFnProductionParameter: TDataSource;
    cbbOpeCode: TComboBox;
    cbbOpeName: TComboBox;
    mmoOpeDes: TMemo;
    btnUpdate: TSpeedButton;
    btnAdd: TSpeedButton;
    btnDel: TSpeedButton;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    btnCancel: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbOpeNameChange(Sender: TObject);
    procedure cbbOpeCodeChange(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure dbgrdPPCellClick(Column: TColumn);
    procedure cdsFnProductionParameterAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    //���ݲ���
    GIden : string;                                                             //��¼��ѡ����Idenֵ������ȡ��ʱʹ��
    GDelIden : String;                                                          //��¼ɾ������Idenֵ
      //���ݿ�
    procedure QueryData(sourceCDS: TClientDataSet;const aType : String; aSQL: WideString); //ͨ�ò�ѯ���ݷ���
    procedure GetFnProductionParameterData;                                     //��ȡfnProductionParameter�����������
    procedure QueryFnOperationHdrListData;                                      //��ѯFnProductionList����
    procedure QueryFnProductionParameterData(aCode : String);                   //���ݹ����Ų�ѯ����
    function SaveToDB(aData : OleVariant) : Boolean;                            //���浽���ݿ�
    function DeleteFnProductionParameterData(Idens : String) : Boolean;         //ɾ��ָ��Iden������

      //����
    function FilterForFnOperationHdrList(aField, aWhere : String) : String;     //����fnOperationHdrList���ݹ��˷���
    procedure Add;                                                              //��������
    procedure Edit;                                                             //�༭����
    procedure Delete;                                                           //ɾ������
    procedure Cancel;                                                           //ȡ������
    procedure Save;                                                             //���淽��
    procedure SavaToCDS;                                                        //���浽����ClientDataSet

    //�������
    procedure Initialise;                                                       //��ʼ����������
    procedure Clean;                                                            //���ComboBox��Memo��Edit
    procedure CleanText;                                                        //��ո��༭��Text�е�����
    procedure FullCommboBox;                                                    //���CommboBox ����cbbOpeCode �� cbbOpeName
    procedure ControlEnabled;                                                   //���ƿؼ�Enabledֵ
    procedure MyComboBoxKeyPress(Sender: TObject;var Key: Char);                //����ComboBox��KeyPress�¼�����������ComboBoxΪֻ��
    function CheckNull : Boolean;                                               //�ǿռ��
    procedure ShowDataToEdit;                                                   //��������ʾ���༭����
    procedure CentraleControl(aState : TStateType);                             //���п��Ʒ�������Ҫ���Ʋ�ͬ�༭״̬�µİ�ť״̬
  public
    { Public declarations }
  end;

var
  ProductionParameterForm: TProductionParameterForm;

implementation

uses uShowMessage, ServerDllPub, uGlobal, uFNMResource;

{$R *.dfm}

procedure TProductionParameterForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if cdsFnProductionParameter.ChangeCount > 0 then
     if MessageDlg('��ʾ: �������޸�, ��δ����, �Ƿ�����˳�����?', mtConfirmation, [mbYes, mbNo],0) = mrNo then
     begin
       Action := caNone;
       Exit;
     end;//if
  Action := caFree;
end;

procedure TProductionParameterForm.FormDestroy(Sender: TObject);
begin
  ProductionParameterForm := nil;
end;

procedure TProductionParameterForm.clean;
begin
  cbbOpeCode.Text := '';
  cbbOpeName.Text := '';
  mmoOpeDes.Lines.Text := '';
end;

procedure TProductionParameterForm.initialise;
begin
  btnCancel.Glyph.LoadFromResourceName(HInstance, RES_UNDO);
  

  clean;
  cbbOpeCode.Items.Clear;
  cbbOpeCode.OnKeyPress := MyComboBoxKeyPress;
  cbbOpeName.Items.Clear;
  cbbOpeName.OnKeyPress := MyComboBoxKeyPress;
  
  edtQueryCode.Text := '';

  dbgrdPP.ReadOnly := True;

  grpTop.Enabled := False;
  cbbOpeCode.Enabled := False;//�����Ų������޸�
  cbbOpeName.Enabled := False;//�������Ʋ������޸�

  btnSave.Enabled := False;
  btnCancel.Enabled := False;

  GetFnProductionParameterData;
  QueryFnOperationHdrListData;

  mmoOpeDes.MaxLength := 200;
end;

procedure TProductionParameterForm.QueryData(sourceCDS: TClientDataSet;
  const aType: String; aSQL: WideString);
var
  vData : OleVariant;
  sErrMsg : WideString;
begin
  try
    uShowMessage.ShowStatusMessage('���ڲ�ѯ�Եȣ�', crHourGlass);
    
    sourceCDS.Close;
    FNMServerObj.GetQueryData(vData,aType, aSQL, sErrMsg);
    if sErrMsg = '' then
    begin
      sourceCDS.Data := vData;
    end else
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;//else
  finally
    uShowMessage.ShowStatusMessage('', crDefault);
  end;//finally
end;

procedure TProductionParameterForm.GetFnProductionParameterData;
var
  sSQL : WideString;
begin
  sSQL := QuotedStr('GetfnProductionParameter') + ','+ QuotedStr('');
  QueryData(cdsFnProductionParameter, rsTable, sSQL);
end;

procedure TProductionParameterForm.QueryFnOperationHdrListData;
var
  sSQL : WideString;
begin
  sSQL := QuotedStr('QueryfnPerationHdrList') + ','+ QuotedStr('');
  QueryData(cdsFnOperationHdrList, rsTable, sSQL);
  FullCommboBox;
end;

procedure TProductionParameterForm.QueryFnProductionParameterData(aCode: String);
var
  sSQL : WideString;
begin
  if Trim(aCode) <> '' then
  begin
    sSQL := QuotedStr('QueryfnProductionParameter') + ','+ QuotedStr(aCode);
    QueryData(cdsFnProductionParameter, rsTable, sSQL);
  end;//if
end;

procedure TProductionParameterForm.FullCommboBox;
begin
  if cdsFnOperationHdrList.Active then
  begin
    cdsFnOperationHdrList.First;
    while not cdsFnOperationHdrList.Eof do
    begin
      cbbOpeCode.Items.Add(cdsFnOperationHdrList.FieldByName('Operation_code').AsString);
      cbbOpeName.Items.Add(cdsFnOperationHdrList.FieldByName('Operation_CHN').AsString);
      cdsFnOperationHdrList.Next;
    end;//while
  end;//if
end;

function TProductionParameterForm.FilterForFnOperationHdrList(aField, aWhere: String) : String;
begin
  Result := '';
  if(cdsFnOperationHdrList.Active) and (aField <> '') and (aWhere <> '') then
  begin
    cdsFnOperationHdrList.Filter := aWhere;
    cdsFnOperationHdrList.Filtered := true;
    Result := cdsFnOperationHdrList.FieldByName(aField).AsString;
    cdsFnOperationHdrList.Filtered := False;
  end;//if
end;

procedure TProductionParameterForm.ControlEnabled;
var
  i : Integer;
begin
  grpTop.Enabled := not grpTop.Enabled;
  dbgrdPP.Enabled := not dbgrdPP.Enabled;
  pnlTop.Enabled := not pnlTop.Enabled;

  for i := 0 to pnlRight.ControlCount - 1 do
    TButton(pnlRight.Controls[i]).Enabled := not TButton(pnlRight.Controls[i]).Enabled;
end;

function TProductionParameterForm.SaveToDB(aData : OleVariant) : Boolean;
var
  sErrMsg : WideString;
begin
  Result := False;
  try
    uShowMessage.ShowStatusMessage('���ڱ�������...', crHourGlass);
    FNMServerObj.SaveBaseTableInfo(aData, 'fnProductionParameter','',sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;//if
    Result := True;
  finally
    uShowMessage.ShowStatusMessage('', crDefault);
  end;//finally
end;

procedure TProductionParameterForm.SavaToCDS;
begin
  if (cdsFnProductionParameter.State in [dsEdit, dsInsert]) then
  begin
    cdsFnProductionParameter.FieldByName('Operation_Code').AsString := cbbOpeCode.Text;
    cdsFnProductionParameter.FieldByName('Operation_Name').AsString := cbbOpeName.Text;
    cdsFnProductionParameter.FieldByName('Operation_Description').AsString := mmoOpeDes.Lines.Text;
    cdsFnProductionParameter.Post;
  end;//if
end;

procedure TProductionParameterForm.FormCreate(Sender: TObject);
begin
  inherited;
  initialise;
end;

procedure TProductionParameterForm.cbbOpeNameChange(Sender: TObject);
begin
  inherited;
  if cdsFnProductionParameter.State in [dsEdit, dsInsert] then //ֻ��grpTop�ڿɱ༭״̬�Ż�ִ�й���
    cbbOpeCode.Text := FilterForFnOperationHdrList('Operation_code','Operation_CHN = ' + QuotedStr(TComboBox(Sender).Text));
end;

procedure TProductionParameterForm.cbbOpeCodeChange(Sender: TObject);
begin
  inherited;
  if cdsFnProductionParameter.State in [dsEdit, dsInsert] then //ֻ��grpTop�ڿɱ༭״̬�Ż�ִ�й���
    cbbOpeName.Text := FilterForFnOperationHdrList('Operation_CHN','Operation_code = ' + QuotedStr(TComboBox(Sender).Text));
end;

procedure TProductionParameterForm.MyComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  //Key := #0;
end;

procedure TProductionParameterForm.Add;
begin
    {btnAdd.Enabled := false; //�޸İ�ť
    btnUpdate.Enabled := false; //�޸İ�ť
    btnDel.Enabled := false;   //ɾ����ť
    dbgrdPP.Enabled := false;  //����

    grpTop.Enabled := True;    //��Ϣά����
    cbbOpeCode.Enabled := True;//������
    cbbOpeName.Enabled := True;//��������

    btnSave.Enabled := true;   //���水ť
    btnCancel.Enabled := true;  //ȡ����ť
    pnlTop.Enabled := False; //��ѯ��
    }
    CentraleControl(isAdd);

    {if CheckNull then
    begin
      SavaToCDS;}
      GIden := cdsFnProductionParameter.FieldByName('Iden').AsString; //��¼��ǰλ��
      
      cdsFnProductionParameter.Append;//����CDS״̬Ϊ����
      CleanText;
      cbbOpeCode.SetFocus;
    //end;//if
end;

procedure TProductionParameterForm.Edit;
begin
  {btnAdd.Enabled := false;    //������ť
  btnUpdate.Enabled := false; //�޸İ�ť
  btnDel.Enabled := false;   //ɾ����ť
  dbgrdPP.Enabled := false;  //����

  grpTop.Enabled := True;    //��Ϣά����
  cbbOpeCode.Enabled := False;//�����Ų������޸�
  cbbOpeName.Enabled := False;//�������Ʋ������޸�

  btnSave.Enabled := true;   //���水ť
  btnCancel.Enabled := true;  //ȡ����ť
  pnlTop.Enabled := False; //��ѯ��
  }
  CentraleControl(isUpdate);

  GIden := cdsFnProductionParameter.FieldByName('Iden').AsString; //��¼��ǰλ��
  cdsFnProductionParameter.Edit;//����CDS״̬Ϊ�޸�
  mmoOpeDes.SetFocus;

  {if CheckNull then
  begin
    SavaToCDS;
    cdsFnProductionParameter.Edit;//����CDS״̬Ϊ�޸�
    cbbOpeCode.SetFocus;
  end;//if}
end;

procedure TProductionParameterForm.Delete;
begin
  if (cdsFnProductionParameter.RecordCount > 0) then
  begin
    if (cdsFnProductionParameter.FieldByName('Iden').AsString <> '') then
    begin
      if GDelIden <> '' then
        GDelIden := GDelIden + ',' + cdsFnProductionParameter.FieldByName('Iden').AsString
      else
        GDelIden := cdsFnProductionParameter.FieldByName('Iden').AsString;

      CentraleControl(isDel);

      //btnSave.Enabled := true;   //���水ť
      //btnCancel.Enabled := False;  //ȡ����ť
    end;//if
    cdsFnProductionParameter.Delete;
  end;//if
end;

procedure TProductionParameterForm.CleanText;
begin
  cbbOpeCode.Text := '';
  cbbOpeName.Text := '';
  mmoOpeDes.Lines.Text := '';
end;

procedure TProductionParameterForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  if edtQueryCode.Text <> '' then
    QueryFnProductionParameterData(edtQueryCode.Text)
  else
    GetFnProductionParameterData;
end;

function TProductionParameterForm.DeleteFnProductionParameterData(Idens : String) : Boolean;
var
  sSQL : WideString;
  vData : OleVariant;
  sErrMsg : WideString;
begin
  Result := False;
  try
    sSQL := QuotedStr('RemovefnProductionParameter') + ','+ QuotedStr(Idens);
    uShowMessage.ShowStatusMessage('����ɾ���Ե�...', crHourGlass);
    FNMServerObj.GetQueryData(vData,'fnProductionParameter', sSQL, sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;//if
    Result := True;
  finally
    uShowMessage.ShowStatusMessage('', crDefault);
  end;//finally
end;

function TProductionParameterForm.CheckNull : Boolean;
begin
  Result := True;
  if cdsFnProductionParameter.State in [dsEdit, dsInsert] then
  begin
    if(cbbOpeCode.Text = '') or (cbbOpeName.Text = '') or (mmoOpeDes.Lines.Text = '') then
    begin
      MessageDlg('���������п�ֵ������д�������ݺ��ٱ���', mtWarning, [mbOK], 0);
      Result := False;
    end;//if
  end;//if
end;

procedure TProductionParameterForm.Save;
var
  i : Integer;
begin
  if (cdsFnProductionParameter.State in [dsEdit, dsInsert]) then
  begin
    if not CheckNull then
      Exit;

    SavaToCDS;
    if not SaveToDB(cdsFnProductionParameter.Delta) then
    begin
      if MessageDlg('���ݱ���ʧ�ܣ��Ƿ�������Ա�������', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        Exit;
    end;//if
    
    GetFnProductionParameterData; //���»�ȡ����
    //cdsFnProductionParameter.Last;
    {
    grpTop.Enabled := False; //�༭��
    dbgrdPP.Enabled := True; //����
    pnlTop.Enabled := True; //��ѯ��

    for i := 0 to pnlRight.ControlCount - 1 do
      TButton(pnlRight.Controls[i]).Enabled := true;}
      
    
  end;//if

  //ɾ������
  if Length(Trim(GDelIden)) > 0 then
  begin
    if DeleteFnProductionParameterData(GDelIden) then
    begin
      cdsFnProductionParameter.MergeChangeLog;
      GDelIden := '';
    end;//if
  end;//if

  //btnSave.Enabled := False;   //���水ť
  //btnCancel.Enabled := False;  //ȡ����ť

  CentraleControl(isInit);
  clean;
end;

procedure TProductionParameterForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TProductionParameterForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  Save;
end;

procedure TProductionParameterForm.btnDelClick(Sender: TObject);
begin
  inherited;
  Delete;
end;

procedure TProductionParameterForm.btnUpdateClick(Sender: TObject);
begin
  inherited;
  Edit;
end;

procedure TProductionParameterForm.btnAddClick(Sender: TObject);
begin
  inherited;
  Add;
end;

procedure TProductionParameterForm.Cancel;
begin
 { btnAdd.Enabled := True;    //������ť
  btnUpdate.Enabled := True; //�޸İ�ť
  btnDel.Enabled := True;   //ɾ����ť
  dbgrdPP.Enabled := True;  //����
  grpTop.Enabled := False;    //��Ϣά����
  btnSave.Enabled := False;   //���水ť
  btnCancel.Enabled := False;  //ȡ����ť }

  GDelIden := ''; //���ɾ��ID��¼

  cdsFnProductionParameter.Cancel;
  CentraleControl(isCancel);
  CleanText;

  cdsFnProductionParameter.Locate('Iden', GIden, []);
end;

procedure TProductionParameterForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  Cancel;
end;

procedure TProductionParameterForm.CentraleControl(aState: TStateType);
begin
  case aState of
    isInit:
    begin
      cbbOpeCode.Enabled := False;//������
      cbbOpeName.Enabled := False;//��������

      btnAdd.Enabled := True;     //������ť
      btnUpdate.Enabled := True;  //�޸İ�ť
      btnDel.Enabled := True;     //ɾ����ť
      btnSave.Enabled := False;   //���水ť
      btnCancel.Enabled := False; //ȡ����ť
      btnClose.Enabled := True;   //�˳���ť

      grpTop.Enabled := False;    //��Ϣά����
      pnlTop.Enabled := True;     //��ѯ��
      dbgrdPP.Enabled := True;    //����
    end;
    isBrowse:
    begin

    end;
    isAdd:
    begin
      cbbOpeCode.Enabled := True;//������
      cbbOpeName.Enabled := True;//��������

      btnAdd.Enabled := False;
      btnUpdate.Enabled := False;
      btnDel.Enabled := False;
      btnSave.Enabled := True;
      btnCancel.Enabled := True;
      btnClose.Enabled := False;

      grpTop.Enabled := True;
      pnlTop.Enabled := False;
      dbgrdPP.Enabled := False;
    end;
    isUpdate:
    begin
      cbbOpeCode.Enabled := False;//������
      cbbOpeName.Enabled := False;//��������

      btnAdd.Enabled := False;
      btnUpdate.Enabled := False;
      btnDel.Enabled := False;
      btnSave.Enabled := True;
      btnCancel.Enabled := True;
      btnClose.Enabled := False;

      grpTop.Enabled := True;
      pnlTop.Enabled := False;
      dbgrdPP.Enabled := False;
    end;
    isDel:
    begin
      btnAdd.Enabled := False;
      btnUpdate.Enabled := False;
      btnDel.Enabled := False;
      btnSave.Enabled := True;
      btnCancel.Enabled := False;
      btnClose.Enabled := True;
    end;
    isSave:
    begin

    end;
    isCancel:
    begin
      cbbOpeCode.Enabled := False;//������
      cbbOpeName.Enabled := False;//��������
      
      btnAdd.Enabled := True;
      btnUpdate.Enabled := True;
      btnDel.Enabled := True;
      btnSave.Enabled := False;
      btnCancel.Enabled := False;
      btnClose.Enabled := True;

      grpTop.Enabled := False;
      pnlTop.Enabled := True;
      dbgrdPP.Enabled := True;
    end;
  end;//case  
end;

procedure TProductionParameterForm.ShowDataToEdit;
begin
  cbbOpeCode.Text := cdsFnProductionParameter.FieldByName('Operation_Code').AsString;
  cbbOpeName.Text := cdsFnProductionParameter.FieldByName('Operation_Name').AsString;
  mmoOpeDes.Lines.Text := cdsFnProductionParameter.FieldByName('Operation_Description').AsString;
end;

procedure TProductionParameterForm.dbgrdPPCellClick(Column: TColumn);
begin
  inherited;
  ShowDataToEdit;
end;

procedure TProductionParameterForm.cdsFnProductionParameterAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  ShowDataToEdit;
end;

end.
