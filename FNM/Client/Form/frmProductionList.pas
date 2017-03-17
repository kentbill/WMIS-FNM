{******************************************************************************
       ������� WMIS ����FNM
       �ļ����� frmProductionList
       ��Ȩ���� (C) 2013 ESQUEL GROUP GET/IT
       �������� 2013-11-18
       ������Ա APJ zhaogang  ���վ������Ը�
       �޸���Ա
       �޸�����
       �޸�ԭ��
       ��Ӧ����
       ���ݿ�
            ��
              FNMDB.dbo.fnProductionList
            ��ر�
              FNMDB.dbo.fnProductionParameter
       ������Ҫ����/SQL����˵��
            �洢����
              FNMDB.dbo.usp_fnProductionListData
******************************************************************************}

unit frmProductionList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxSplitter, Grids, ExtCtrls, StdCtrls, CheckLst,
  frmBase, DB, DBClient, frmMain, DBGrids, Buttons;

const
  rsTable = 'fnProductionList'; //�����
  division = '-';//�ָ���

type
  TStateType = (isInit, isBrowse, isAdd, isUpdate, isDel, isSave, isCancel); //��ʼ�������, �������޸ģ�ɾ�������棬ȡ��

  TProductionListForm = class(TBaseForm)
    pnl2: TPanel;
    pnlBottom: TPanel;
    pnlEdit: TPanel;
    cxSplitter1: TcxSplitter;
    lbl1: TLabel;
    lbl2: TLabel;
    edtProName: TEdit;
    edtProCT: TEdit;
    pnlButton: TPanel;
    cdsProPar: TClientDataSet;
    cdsfnProductionList: TClientDataSet;
    lbl3: TLabel;
    edtProCode: TEdit;
    lbl4: TLabel;
    dsfnProductionList: TDataSource;
    dbgrdPL: TDBGrid;
    btnAdd: TSpeedButton;
    btnDelete: TSpeedButton;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    pnl1: TPanel;
    grp1: TGroupBox;
    chklstOperationHdr: TCheckListBox;
    btnUpdate: TSpeedButton;
    btnCancel: TSpeedButton;
    cdsCheckUnique: TClientDataSet;
    procedure btnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure chklstOperationHdrClickCheck(Sender: TObject);
    procedure edtProCTKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cdsfnProductionListAfterScroll(DataSet: TDataSet);
    procedure dbgrdPLCellClick(Column: TColumn);
  private
    { Private declarations }
    //���ݲ���
    GIden : string;                                                             //��¼��ѡ����Idenֵ������ȡ��ʱʹ��
    GDelIden : String;                                                          //��¼ɾ������Idenֵ
    GIndex : TStringList;                                                       //��¼��ѡ��������ֵ
    GOldProCode : string;                                                       //����ɵĹ������(Production_Code)ֵ�������޸�ʱ���Ψһ��
    //���ݿ�
    procedure QueryData(sourceCDS: TClientDataSet;const aType : String; aSQL: WideString); //ͨ�ò�ѯ���ݷ���
    //procedure QueryFnOperationHdrListData;                                    //��ѯfnOperationHdrList����
    procedure GetFnProductionParameterData;                                     //��ѯfnProductionParameter����
    procedure GetFnProductionListData;                                          //��ȡfnProductionList����
    procedure GetGetCheckUniqueData;                                            //���Production_CodeΨһ��
    function SaveToDB(aData : OleVariant) : Boolean;                            //�������ݵ� fnProductionList ��
    function DeleteFnProductionListData(Idens : String) : Boolean;              //ɾ��ָ��Iden������
      //����
    procedure SetProNameAndProCode(aValue : String);                            //����ѡ�������edtProName��edtProCode
    procedure Add;                                                              //��������
    procedure Edit;                                                             //�޸ķ���
    procedure Delete;                                                           //ɾ������
    procedure Save;                                                             //���淽��
    procedure Cancel;                                                           //ȡ������
    procedure SaveToCDS;                                                        //�����ݱ��浽����ClientDataSet
    function CheckUnique(aValue : String; expect : Integer) : Boolean;          //���ؼ��Production_CodeΨһ��, TrueΪȷ��ΪΨһֵ

    //�������
    procedure initialise;                                                       //��ʼ����������
    procedure CleanText;                                                        //���Edit��StringGrid
    procedure CleanCheckLB;                                                     //���CheckListBoxt
    function CheckNull : Boolean;                                               //����ֵ�����ڱ���ǰ
    procedure FullFnOperationHdrData;                                           //���FnOperationHdr���ݵ�CheckBoxList
    procedure OperationSelection(index : Integer);                              //����ѡ�񷽷�������ѡ��˳��ӵ��ı�����
    procedure ControlEnabled(aEnabled : Boolean);                               //�ؼ����Ʒ���
    procedure ShowDataToEdit;                                                   //��������ʾ���༭����
    procedure CentraleControl(aState : TStateType);                             //���п��Ʒ�������Ҫ���Ʋ�ͬ�༭״̬�µİ�ť״̬
  public
    { Public declarations }
  end;

var
  ProductionListForm: TProductionListForm;

implementation

uses uShowMessage, ServerDllPub, uGlobal, uFNMResource;

{$R *.dfm}

{ TProductionListForm }


procedure TProductionListForm.FormCreate(Sender: TObject);
begin
  inherited;
  initialise;
end;

procedure TProductionListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if cdsfnProductionList.ChangeCount > 0 then
     if MessageDlg('��ʾ: �������޸�, ��δ����, �Ƿ�����˳�����?', mtConfirmation, [mbYes, mbNo],0) = mrNo then
     begin
       Action := caNone;
       Exit;
     end;//if
  Action := caFree;
end;

procedure TProductionListForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ProductionListForm := nil;
end;

procedure TProductionListForm.btnExitClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TProductionListForm.initialise;
begin
  GOldProCode := '';

  btnCancel.Glyph.LoadFromResourceName(HInstance, RES_UNDO);

  GIndex := TStringList.Create;

  edtProName.MaxLength := 200;

  edtProCode.ReadOnly := True;
  dbgrdPL.ReadOnly := True;

  //ControlEnabled(True);

  CentraleControl(isInit);

  CleanText;
  CleanCheckLB;
  
  GetFnProductionListData;
  //QueryFnOperationHdrListData;
  GetFnProductionParameterData;
  GetGetCheckUniqueData;
  FullFnOperationHdrData;
end;

procedure TProductionListForm.QueryData(sourceCDS: TClientDataSet;const aType : String; aSQL: WideString);
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

{
procedure TProductionListForm.QueryFnOperationHdrListData;
var
  sSQL : WideString;
begin
  sSQL := QuotedStr('QueryfnPerationHdrList') + ','+ QuotedStr('');
  QueryData(cdsOperationHdr, 'fnProductionParameter', sSQL);
end;
}

procedure TProductionListForm.GetFnProductionListData;
var
  sSQL : WideString;
begin
  sSQL := QuotedStr('GetfnProductionList') + ','+ QuotedStr('');
  QueryData(cdsfnProductionList, rsTable, sSQL);
end;

procedure TProductionListForm.GetGetCheckUniqueData;
var
  sSQL : WideString;
begin
  sSQL := QuotedStr('GetCheckUniqueData') + ','+ QuotedStr('');
  QueryData(cdsCheckUnique, rsTable, sSQL);
end;

procedure TProductionListForm.FullFnOperationHdrData;
begin
  {
  chklstOperationHdr.Items.Clear;
  if(cdsOperationHdr.Active) and (cdsOperationHdr.RecordCount > 0) then
  begin
    cdsOperationHdr.First;
    while not cdsOperationHdr.Eof do
    begin
      chklstOperationHdr.Items.Add(cdsOperationHdr.FieldByName('Operation_code').AsString + division + division + cdsOperationHdr.FieldByName('Operation_CHN').AsString);
      cdsOperationHdr.Next;
    end;//while
  end;//if
  }

  chklstOperationHdr.Items.Clear;
  if(cdsProPar.Active) and (cdsProPar.RecordCount > 0) then
  begin
    cdsProPar.First;
    while not cdsProPar.Eof do
    begin
      chklstOperationHdr.Items.Add(cdsProPar.FieldByName('Operation_Code').AsString + division + division + cdsProPar.FieldByName('Operation_Name').AsString);
      cdsProPar.Next;
    end;//while
  end;//if
end;

procedure TProductionListForm.SetProNameAndProCode(aValue : String);
begin
  if aValue = '' then
    Exit;

  if edtProName.Text <> '' then
  begin
    edtProName.Text := edtProName.Text  + division + Copy(aValue, Pos((division + division), aValue) + 2, Length(aValue));
    edtProCode.Text := edtProCode.Text  + division + Copy(aValue, 0, Pos((division + division), aValue)-1);
  end else
  begin
    edtProName.Text := Copy(aValue, Pos((division + division), aValue) + 2, Length(aValue));
    edtProCode.Text := Copy(aValue, 0, Pos((division + division), aValue)-1);
  end;//else
end;

procedure TProductionListForm.chklstOperationHdrClickCheck(Sender: TObject);
begin
  inherited;
  OperationSelection(chklstOperationHdr.ItemIndex);
end;

procedure TProductionListForm.edtProCTKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

function TProductionListForm.CheckNull: Boolean;
begin
  Result := True;
  if(edtProName.Text = '')or(edtProCT.Text = '') then
  begin
    MessageDlg('���������п�ֵ������д�������ݺ��ٱ���', mtWarning, [mbOK], 0);
    Result := False;
  end;
end;

procedure TProductionListForm.SaveToCDS;
begin
  if (cdsfnProductionList.State in [dsEdit, dsInsert]) then
  begin
    cdsfnProductionList.FieldByName('Production_Code').AsString := edtProCode.Text;
    cdsfnProductionList.FieldByName('Production_Name').AsString := edtProName.Text;
    cdsfnProductionList.FieldByName('CT').AsString := edtProCT.Text;
    cdsfnProductionList.Post;
  end;//if
end;

function TProductionListForm.SaveToDB(aData : OleVariant) : Boolean;
var
  sErrMsg : WideString;
begin
  Result := False;
  try
    uShowMessage.ShowStatusMessage('���ڱ�������...', crHourGlass);

    FNMServerObj.SaveBaseTableInfo(aData, rsTable,'',sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;//if
    Result := true;
  finally
    uShowMessage.ShowStatusMessage('', crDefault);
  end;//finally
end;

procedure TProductionListForm.Add;
begin
  //ControlEnabled(False);
  CentraleControl(isAdd);
  GIden := cdsfnProductionList.FieldByName('Iden').AsString;
  cdsfnProductionList.Append;//����״̬
  CleanText;
  CleanCheckLB;
end;

procedure TProductionListForm.Edit;
begin
  if cdsfnProductionList.RecordCount > 0 then
  begin
    GIden := cdsfnProductionList.FieldByName('Iden').AsString;
    GOldProCode := cdsfnProductionList.FieldByName('Production_Code').AsString;
    //ControlEnabled(False);
    CentraleControl(isUpdate);

    cdsfnProductionList.Edit;
    CleanCheckLB;
  end;//if
end;

procedure TProductionListForm.Cancel;
begin
  cdsfnProductionList.Cancel;
  CleanText;
  CleanCheckLB;

  //ControlEnabled(True);
  CentraleControl(isCancel);
  cdsfnProductionList.Locate('Iden', GIden, []);
end;

procedure TProductionListForm.Delete;
begin
  if (cdsfnProductionList.RecordCount > 0) then
  begin
    if (cdsfnProductionList.FieldByName('Iden').AsString <> '') then
    begin
      if  GDelIden <> '' then
        GDelIden := GDelIden + ',' + cdsfnProductionList.FieldByName('Iden').AsString
      else
        GDelIden := cdsfnProductionList.FieldByName('Iden').AsString;
    end;//if
    cdsfnProductionList.Delete;

   // btnSave.Enabled := True;
   CentraleControl(isDel);
  end;//if
end;

procedure TProductionListForm.btnAddClick(Sender: TObject);
begin
  inherited;
  Add;
end;

procedure TProductionListForm.btnDeleteClick(Sender: TObject);
begin
  inherited;
  Delete;
end;

procedure TProductionListForm.Save;
var
  expect : Integer; //����ֵ����������ʱ��ֹ¼���ظ�����������޸��Ѵ���ֵ
begin
  //�ж�CDS״̬�����ڱ༭״̬���鹤����Ƿ��ظ�
  if cdsfnProductionList.State in [dsEdit, dsInsert] then
  begin

    if not CheckNull then
      Exit;

    expect := 0; //������������Ӧ��δ�У���������ֵΪ0
    if cdsfnProductionList.State in [dsEdit] then
    begin
      if GOldProCode = edtProCode.Text then //�Ƚ��޸�ǰ����ֵ����ֹ�޸��ƻ�Ψһ��
        expect := 1; //�޸ģ����������У���������ֵΪ1
    end;//if

    if not CheckUnique(edtProCode.Text, expect) then
    begin
      MessageDlg('�������[' + edtProCode.Text + ']�Ѵ��ڣ���������֯����', mtInformation, [mbOK], 0);
      Exit;
    end;//if
  end;

  SaveToCDS;
  if cdsfnProductionList.ChangeCount > 0 then
  begin
    if not SaveToDB(cdsfnProductionList.Delta) then
    begin
      if MessageDlg('���ݱ���ʧ�ܣ��Ƿ�������Ա�������', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        Exit;
    end;//if
    GetFnProductionListData; //���»�ȡ����
  end;//if

  //ɾ������
  if Length(Trim(GDelIden)) > 0 then
  begin
    if DeleteFnProductionListData(GDelIden) then
    begin
      cdsfnProductionList.MergeChangeLog;
      GDelIden := '';
    end;//if
  end;//if

  GetGetCheckUniqueData;//���»�ȡΨһ�Լ������
  //ControlEnabled(True);
  CentraleControl(isInit);
  Cancel;
end;

function TProductionListForm.DeleteFnProductionListData(Idens: String): Boolean;
var
  sSQL : WideString;
  vData : OleVariant;
  sErrMsg : WideString;
begin
  Result := False;
  try
    sSQL := QuotedStr('RemovefnProductionList') + ','+ QuotedStr(Idens);
    uShowMessage.ShowStatusMessage('����ɾ���Ե�...', crHourGlass);
    FNMServerObj.GetQueryData(vData,rsTable, sSQL, sErrMsg);
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

procedure TProductionListForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  Save;
end;

{
function TProductionListForm.CheckfnProductionCode(aCode : String) : Integer;
var
  sSQL : WideString;
  cds : TClientDataSet;
begin
  Result := 0;
  sSQL := QuotedStr('CheckfnProductionCode') + ','+ QuotedStr(aCode);

  cds := TClientDataSet.Create(nil);
  try
    QueryData(cds, 'fnProductionList', sSQL);
    if cds.Active then
      Result := cds.RecordCount;
  finally
    if Assigned(cds) then
    begin
      cds.Close;
      FreeAndNil(cds);
    end;//if
  end;//finally
end;
}

function TProductionListForm.CheckUnique(aValue: String; expect : Integer): Boolean;
begin
  //expect ������������������������ӦΪ 0 ���޸�ӦΪ 1
  //TrueΪȷ��ΪΨһֵ
  Result := True;
  cdsCheckUnique.Filter := 'Production_Code = ' + QuotedStr(aValue);
  cdsCheckUnique.Filtered := true;
  Result := (cdsCheckUnique.RecordCount = expect);
  cdsCheckUnique.Filtered := false;
end;

procedure TProductionListForm.OperationSelection(index: Integer);
var
  i : Integer;
begin
  if not pnlEdit.Enabled then
    Exit;
    
  edtProName.Text := '';
  edtProCode.Text := '';
  
  if chklstOperationHdr.Checked[index] then //�����ѡ�ϣ�������ֵ�ӵ��б��У����û��ȥ��������ֵ
  begin
    GIndex.Add(IntToStr(index));
  end else
  begin
    for i := GIndex.Count - 1 downto 0 do
    begin
      if GIndex.Strings[i] = IntToStr(index) then
        GIndex.Delete(i);
    end;//for
  end;//if

  for i := 0 to GIndex.Count - 1 do //ѭ���б��ٸ��������������ֵ�ӵ��ı�����
  begin
    if chklstOperationHdr.Checked[StrToInt(GIndex.Strings[i])] then
      SetProNameAndProCode(chklstOperationHdr.Items.Strings[StrToInt(GIndex.Strings[i])])
    else
      GIndex.Delete(i);
  end;//for
end;

procedure TProductionListForm.btnUpdateClick(Sender: TObject);
begin
  inherited;
  Edit;
end;

procedure TProductionListForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  Cancel;
end;

procedure TProductionListForm.ControlEnabled(aEnabled : Boolean);
var
  i : Integer;
begin
  btnAdd.Enabled := aEnabled;
  btnUpdate.Enabled := aEnabled;
  btnDelete.Enabled := aEnabled;

  btnSave.Enabled := not aEnabled;
  btnCancel.Enabled := not aEnabled;
  pnlEdit.Enabled := not aEnabled;

  dbgrdPL.Enabled := aEnabled;
end;

procedure TProductionListForm.GetFnProductionParameterData;
var
  sSQL : WideString;
begin
  sSQL := QuotedStr('GetfnProductionParameter') + ','+ QuotedStr('');
  QueryData(cdsProPar, 'fnProductionParameter', sSQL);
end;

procedure TProductionListForm.CleanCheckLB;
var
  i : Integer;
begin
  for i := 0 to chklstOperationHdr.Count -1 do
    chklstOperationHdr.Checked[i] := False;
  GIndex.Clear;
end;

procedure TProductionListForm.CleanText;
begin
  edtProName.Text := '';
  edtProCT.Text := '';
  edtProCode.Text := '';
end;

procedure TProductionListForm.CentraleControl(aState: TStateType);
begin
  case aState of
    isInit:
    begin
      btnAdd.Enabled := True;         //������ť
      btnUpdate.Enabled := True;      //�޸İ�ť
      btnDelete.Enabled := True;      //ɾ����ť
      btnSave.Enabled := False;       //���水ť
      btnCancel.Enabled := False;     //ȡ����ť
      btnClose.Enabled := True;       //�˳���ť
      pnlEdit.Enabled := False;       //��Ϣά����
      dbgrdPL.Enabled := True;        //����
    end;
    isBrowse:
    begin

    end;
    isAdd..isUpdate:
    begin
      btnAdd.Enabled := False;
      btnUpdate.Enabled := False;
      btnDelete.Enabled := False;
      btnSave.Enabled := True;
      btnCancel.Enabled := True;
      btnClose.Enabled := False;
      pnlEdit.Enabled := True;
      dbgrdPL.Enabled := False;
    end;
    isDel:
    begin
      btnAdd.Enabled := False;
      btnUpdate.Enabled := False;
      btnSave.Enabled := True;
      btnCancel.Enabled := False;
      btnClose.Enabled := True;
      pnlEdit.Enabled := False;
    end;
    isSave:
    begin
    end;
    isCancel:
    begin
      btnAdd.Enabled := True;
      btnUpdate.Enabled := True;
      btnDelete.Enabled := True;
      btnSave.Enabled := False;
      btnCancel.Enabled := False;
      btnClose.Enabled := True;
      pnlEdit.Enabled := False;
      dbgrdPL.Enabled := True;
    end;
  end;//case
end;

procedure TProductionListForm.ShowDataToEdit;
begin
  edtProCode.Text := cdsfnProductionList.FieldByName('Production_Code').AsString;
  edtProName.Text := cdsfnProductionList.FieldByName('Production_Name').AsString;
  edtProCT.Text := cdsfnProductionList.FieldByName('CT').AsString;  
end;

procedure TProductionListForm.cdsfnProductionListAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  ShowDataToEdit;
end;

procedure TProductionListForm.dbgrdPLCellClick(Column: TColumn);
begin
  inherited;
  ShowDataToEdit;
end;

end.
