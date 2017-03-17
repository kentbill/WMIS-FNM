{******************************************************************************
       ������� WMIS ����FNM
       �ļ����� frmReceiveGreyCloth
       ��Ȩ���� (C) 2013 ESQUEL GROUP GET/IT
       �������� 2013-12-03
       ������Ա APJ zhaogang  ���վ������Ը�
       �޸���Ա
       �޸�����
       �޸�ԭ��
       ��Ӧ����
       ���ݿ�
          ��
            QCMDB.dbo.fnGreyCloth
          ��ر�
            FNMDB.DBO.fnProductionList
            PDMDB.DBO.TDGFID
          �洢���̣�
            QCMDB.dbo.usp_fnGreyClothData
******************************************************************************}
unit frmReceiveGreyCloth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, cxControls, cxSplitter, ExtCtrls, DB,
  DBClient, Grids, DBGrids, frmBase;

const
  rsTable = 'fnGreyCloth';      //�����
  rsStatus = '���Ͳ�';          //���ѯ״ֵ̬
  rsSaveStatus = '����';      //��״ֵ̬
  rsFormat = 'yyyy-MM-dd HH:mm';//���ڸ�ʽ
  division = '|';               //�ָ���
  
type
  TReceiveGreyClothForm = class(TBaseForm)
    pnl1: TPanel;
    grp1: TGroupBox;
    cxSplitter1: TcxSplitter;
    cxSplitter2: TcxSplitter;
    grpTop: TGroupBox;
    grp3: TGroupBox;
    pnlTop2: TPanel;
    btnMoveDown: TBitBtn;
    btnMoveDownAll: TBitBtn;
    btnMoveUp: TBitBtn;
    btnMoveUpAll: TBitBtn;
    lstFabricNo: TListBox;
    lstWaitFabricNo: TListBox;
    pnlBottom: TPanel;
    pnlBottomRight: TPanel;
    btnSend: TBitBtn;
    btnClose: TBitBtn;
    cdsSource: TClientDataSet;
    cdsQuery: TClientDataSet;
    dsFnGreyCloth: TDataSource;
    cdsFnGreyCloth: TClientDataSet;
    cdsFnGreyClothID: TIntegerField;
    cdsFnGreyClothFabric_No: TStringField;
    cdsFnGreyClothJob_NO: TStringField;
    cdsFnGreyClothMachine_ID: TStringField;
    cdsFnGreyClothDepartment: TStringField;
    cdsFnGreyClothDefect_Name: TStringField;
    cdsFnGreyClothDefect_Remark: TStringField;
    cdsFnGreyClothSource: TStringField;
    cdsFnGreyClothGF_ID: TIntegerField;
    dbgrdFGCl: TDBGrid;
    cdsFnGreyClothGF_NO: TStringField;
    btnRefresh: TBitBtn;
    cdsFnGreyClothWidth: TBCDField;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lstFabricNoDblClick(Sender: TObject);
    procedure lstWaitFabricNoDblClick(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
    procedure btnMoveDownAllClick(Sender: TObject);
    procedure btnMoveUpClick(Sender: TObject);
    procedure btnMoveUpAllClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
  private
    { Private declarations }
    GSrcList : TStringList;                                                     //��¼Դ����Iden   ����TransferValueForListBox���� ����ID�Ӳ��� ��ʽ: 1|I00001
    GDestList : TStringList;                                                    //��¼Ŀ������Iden ����TransferValueForListBox���� ����ID�Ӳ��� ��ʽ: 1|I000
    //���ݲ���
      //���ݿ�
    function QueryData(aCDS: TClientDataSet; const aType : String; aSQL: WideString) : Boolean;//ͨ�ò�ѯ���ݷ���
    procedure QueryFnGreyClothData(aValue : String);                            //������Դ��ѯfnGreyCloth����Ͳ�����
    procedure GetFnGreyClothNullData(aCDS: TClientDataSet);                     //��ȡfnGreyCloth������ݼ�
    function UpdateToDB(aValue : String) : Boolean;                             //�������ݿ�ָ������
    function SaveToDB(aData : OleVariant) : Boolean;                            //�������ݵ� fnGreyCloth ��
      //����
    procedure SaveToCDS(aIden : String);                                        //���浽����cdsFnGreyCloth
    procedure DeleteFromCDS(aIden : String);//(aFabricNo : String);             //ɾ������cdsFnGreyCloth�е�ָ������
    procedure Save;                                                             //���淽��

      //�������
    procedure Initialise;                                                       //��ʼ������
    procedure CleanText;                                                        //����ı���(ComboBox, ListBox)
    procedure CleanList;                                                        //���TStringList
    procedure ReadOnlyKeyPress(Sender: TObject; var Key: Char);                 //ComboBox ֻ�� KeyPress �¼�
    procedure FullCommboBox(aCDS : TClientDataSet; aField : String; aCBB : TComboBox);//���CommboBox
    procedure FullListBox(aCDS : TClientDataSet; aField1, aField2, aField3 : String; aLst : TListBox);//���ListBox����
    procedure TransferValueForListBox(src, dest : TListBox; srcList, destList : TStringList; index : Integer);//�ƶ�ԴListBox�е�ֵ��ָ��ListBox��
    procedure MoveDown(srcLs, destLs : TListBox; srcList, destList : TStringList); //���Ʒ���
    procedure MoveDownAll(srcLs, destLs : TListBox; srcList, destList : TStringList);//ȫ���Ʒ���
    procedure MoveUp(srcLs, destLs : TListBox; srcList, destList : TStringList);   //���Ʒ���
    procedure MoveUpAll(srcLs, destLs : TListBox; srcList, destList : TStringList);//ȫ���Ʒ���
    procedure Refresh;                                                          //ˢ��
    function Decompose(aValue : String; aDiv : string) : String;                //�����ض��ָ����ָ��ֶΣ���ȡǰ����
  public
    { Public declarations }
  end;

var
  ReceiveGreyClothForm: TReceiveGreyClothForm;

implementation

uses uShowMessage, ServerDllPub, uGlobal, uFNMResource, uLogin;

{$R *.dfm}

{ TReceiveGreyClothForm }

function TReceiveGreyClothForm.QueryData(aCDS: TClientDataSet; const aType : String; aSQL: WideString): Boolean;
var
  vData : OleVariant;
  sErrMsg : WideString;
begin
  Result := False;
  try
    ShowMsg('���ڲ�ѯ�Եȣ�', crHourGlass);
    aCDS.Close;
    //ServerDllPub.QCMServerObj.qiGetDataBySql(aSQL,vData,sErrMsg);
    FNMServerObj.GetQueryData(vData,aType, aSQL, sErrMsg);
    if sErrMsg = '' then
    begin
      aCDS.Data := vData;
      Result := true;
    end else
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Result := False;
      Exit;
    end;//else
  finally
    ShowMsg('', crDefault);
  end;//finally
end;

procedure TReceiveGreyClothForm.QueryFnGreyClothData(aValue: String);
var
  sSQL : String;
begin
  //sSQL := QuotedStr('QueryFnGreyClothByStatusAndSource') + ','+ QuotedStr(aValue); //�ڶ�������ʽ('״̬|��Դ')
  sSQL := QuotedStr('QueryFnGreyClothByStatusAndProcessAdd') + ','+ QuotedStr(aValue); //�ڶ�������ʽ('״̬|�ӹ��ص�')
  if QueryData(cdsQuery, rsTable, sSQL) then
    FullListBox(cdsQuery,'Fabric_No','Machine_ID','GF_NO',lstFabricNo);
end;

procedure TReceiveGreyClothForm.GetFnGreyClothNullData(aCDS: TClientDataSet);
var
  sSQL : String;
begin
  sSQL := QuotedStr('GetFnGreyClothNull') + ','+ QuotedStr('');
  QueryData(aCDS, rsTable, sSQL);
end;

function TReceiveGreyClothForm.UpdateToDB(aValue: String): Boolean;
var
  sSQL : String;
begin
  sSQL := QuotedStr('ModifyFnGreyCloth') + ','+ QuotedStr(aValue);
  Result := QueryData(cdsFnGreyCloth, rsTable, sSQL);
end;

procedure TReceiveGreyClothForm.DeleteFromCDS(aIden : String);
begin
  cdsFnGreyCloth.Filter := 'ID = ' + aIden;
  cdsFnGreyCloth.Filtered := True;
  if(cdsFnGreyCloth.RecordCount > 0)then
    cdsFnGreyCloth.Delete;
  cdsFnGreyCloth.Filtered := False;
end;

procedure TReceiveGreyClothForm.SaveToCDS(aIden : String);
begin
  cdsQuery.Locate('Iden', aIden, []);
  if cdsQuery.RecordCount > 0 then
  begin
    cdsFnGreyCloth.Append;
    cdsFnGreyCloth.FieldByName('ID').AsString := cdsQuery.FieldByName('Iden').AsString;
    cdsFnGreyCloth.FieldByName('Fabric_No').AsString := cdsQuery.FieldByName('Fabric_No').AsString;
    cdsFnGreyCloth.FieldByName('Machine_ID').AsString := cdsQuery.FieldByName('Machine_ID').AsString;
    cdsFnGreyCloth.FieldByName('Department').AsString := cdsQuery.FieldByName('Department').AsString;
    cdsFnGreyCloth.FieldByName('Source').AsString := cdsQuery.FieldByName('Source').AsString;
    cdsFnGreyCloth.FieldByName('GF_ID').AsString := cdsQuery.FieldByName('GF_ID').AsString;
    cdsFnGreyCloth.FieldByName('GF_NO').AsString := cdsQuery.FieldByName('GF_NO').AsString;
    cdsFnGreyCloth.FieldByName('Job_NO').AsString := cdsQuery.FieldByName('Job_NO').AsString;
    cdsFnGreyCloth.FieldByName('Defect_Name').AsString := cdsQuery.FieldByName('Defect_Name').AsString;
    cdsFnGreyCloth.FieldByName('Defect_Remark').AsString := cdsQuery.FieldByName('Defect_Remark').AsString;
    cdsFnGreyCloth.FieldByName('Width').AsString := cdsQuery.FieldByName('Width').AsString;//�ŷ�
    cdsFnGreyCloth.Post;
  end;//if
  cdsQuery.Filtered := False;
end;

procedure TReceiveGreyClothForm.Save;
var
  sSQL : string;
begin
  if cdsFnGreyCloth.RecordCount > 0 then
  begin
    sSQL := QuotedStr('QueryFnGreyClothByStatus') + ','+ QuotedStr(rsStatus);
    if not QueryData(cdsSource, rsTable, sSQL) then      //�������õ�cdsSource
      if MessageDlg('�������ݻ�ȡʧ�ܣ��Ƿ��������', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        Exit;

    cdsFnGreyCloth.First;
    while not cdsFnGreyCloth.Eof do
    begin
      cdsSource.Locate('Iden', cdsFnGreyCloth.FieldByName('ID').AsString, []);
      cdsSource.Edit;
      cdsSource.FieldByName('Status').AsString := rsSaveStatus;
      cdsSource.FieldByName('Receiver_Time').AsString := FormatDateTime(rsFormat, now);
      cdsSource.Post;

      cdsFnGreyCloth.Next;
    end;//while

    if not SaveToDB(cdsSource.Delta) then
    begin
      if MessageDlg('���ݱ���ʧ�ܣ��Ƿ�������Ա�������', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        Exit;
    end;//if

    cdsSource.Close;
    cdsFnGreyCloth.EmptyDataSet; //����޸ļ�¼
    GDestList.Clear;
    lstWaitFabricNo.Items.Clear;
  end;//if
  {
  if GDestList.Count > 0 then
  begin
    for i := 0 to GDestList.Count - 1 do
    begin
      if Idens <> '' then
        Idens := Idens + ',' + Decompose(GDestList.Strings[i], division)
      else
        Idens := Decompose(GDestList.Strings[i], division);
    end;//for

    Idens := rsSaveStatus + division + Idens;

    if UpdateToDB(Idens) then
    begin
      cdsFnGreyCloth.EmptyDataSet; //����޸ļ�¼
      cdsQuery.MergeChangeLog;
      lstWaitFabricNo.Items.Clear;
      GDestList.Clear;
    end
    else
    begin
      if MessageDlg('���ݱ���ʧ�ܣ��Ƿ�������Ա�������', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        Exit;
    end;//if
  end;//if}
end;

function TReceiveGreyClothForm.Decompose(aValue, aDiv: string): String;
begin
  Result := Copy(aValue,0, Pos(aDiv, aValue)- 1);
end;

procedure TReceiveGreyClothForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TReceiveGreyClothForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if cdsFnGreyCloth.ChangeCount > 0 then
   if MessageDlg('��ʾ: �������޸�, ��δ����, �Ƿ�����˳�����?', mtConfirmation, [mbYes, mbNo],0) = mrNo then
   begin
     Action := caNone;
     Exit;
   end;//if
  Action := caFree;
end;

procedure TReceiveGreyClothForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ReceiveGreyClothForm := nil;
end;

procedure TReceiveGreyClothForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialise;
end;

procedure TReceiveGreyClothForm.CleanList;
begin
  GSrcList.Clear;
  GDestList.Clear;
end;

procedure TReceiveGreyClothForm.CleanText;
begin
  lstFabricNo.Items.Clear;
  lstWaitFabricNo.Items.Clear;
end;

procedure TReceiveGreyClothForm.Initialise;
begin
  GSrcList := TStringList.Create;
  GDestList := TStringList.Create;

  dbgrdFGCl.ReadOnly := True;

  CleanText;
  CleanList;
  QueryFnGreyClothData(rsStatus + division + Login.CurrentDepartment);//����[���Ͳ�]״̬���û���ǰ���Ż�ȡ����
  GetFnGreyClothNullData(cdsFnGreyCloth);     //��ȡ�����ݼ�
  cdsFnGreyCloth.IndexFieldNames := 'Machine_ID';

end;

procedure TReceiveGreyClothForm.FullCommboBox(aCDS: TClientDataSet;
  aField: String; aCBB: TComboBox);
begin
  if (aCDS.Active) and (aCDS.RecordCount > 0) and (Trim(aField) <> '')then
  begin
    aCBB.Text := '';
    aCBB.Items.Clear;
    aCDS.First;
    while not aCDS.Eof do
    begin
      aCBB.Items.Add(aCDS.FieldByName(aField).AsString);
      aCDS.Next;
    end;//while
  end;//if
end;

procedure TReceiveGreyClothForm.FullListBox(aCDS: TClientDataSet; aField1,
  aField2, aField3: String; aLst: TListBox);
begin
  if (aCDS.Active) and (aCDS.RecordCount > 0) and (Trim(aField1) <> '') and (Trim(aField2) <> '')then
  begin
    GSrcList.Clear;//���TStringList

    aLst.Items.Clear;
    aCDS.First;
    while not aCDS.Eof do
    begin
      GSrcList.Add(aCDS.FieldByName('Iden').AsString);// + division + aCDS.FieldByName('Fabric_No').AsString);//��Iden����TStringList

      aLst.Items.Add(aCDS.FieldByName(aField1).AsString  + ' ' + division  + ' ' + aCDS.FieldByName(aField2).AsString
                      + ' ' + division  + ' ' + aCDS.FieldByName(aField3).AsString);
      aCDS.Next;
    end;//while
  end;//if
end;

procedure TReceiveGreyClothForm.ReadOnlyKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := #0;
end;

procedure TReceiveGreyClothForm.MoveDown(srcLs, destLs : TListBox; srcList, destList : TStringList);
begin
  if srcLs.ItemIndex > -1 then
  begin
    TransferValueForListBox(srcLs, destLs, srcList, destList, srcLs.ItemIndex);
    //SaveToCDS(Decompose(destList.Strings[destList.Count - 1], division));//����Ŀ��StringList������������
    SaveToCDS(destList.Strings[destList.Count - 1]);
  end;//if
end;

procedure TReceiveGreyClothForm.MoveDownAll(srcLs, destLs : TListBox; srcList, destList : TStringList);
begin

  while(srcLs.Count > 0) do
  begin
    TransferValueForListBox(srcLs, destLs, srcList, destList, 0);
    //SaveToCDS(Decompose(destList.Strings[destList.Count - 1], division));//����Ŀ��StringList������������
    SaveToCDS(destList.Strings[destList.Count - 1]);
  end;//while
end;

procedure TReceiveGreyClothForm.MoveUp(srcLs, destLs : TListBox; srcList, destList : TStringList);
begin
  {if lstWaitFabricNo.ItemIndex > -1 then
  begin
    TransferValueForListBox(lstWaitFabricNo, lstFabricNo, GDestList, GSrcList, lstWaitFabricNo.ItemIndex);
    DeleteFromCDS(Decompose(GSrcList.Strings[GSrcList.count - 1], division));//����ԴStringList������������
  end;//if}

  if srcLs.ItemIndex > -1 then
  begin
    TransferValueForListBox(srcLs, destLs, srcList, destList, srcLs.ItemIndex);
    //DeleteFromCDS(Decompose(destList.Strings[destList.count - 1], division));
    DeleteFromCDS(destList.Strings[destList.count - 1]);
  end;//if
end;

procedure TReceiveGreyClothForm.MoveUpAll(srcLs, destLs : TListBox; srcList, destList : TStringList);
begin
  {while(lstWaitFabricNo.Count > 0) do
  begin
    TransferValueForListBox(lstWaitFabricNo, lstFabricNo, GDestList, GSrcList, 0);
    DeleteFromCDS(Decompose(GSrcList.Strings[GSrcList.count - 1], division));//����ԴStringList������������
  end;//while }

  while(srcLs.Count > 0) do
  begin
    TransferValueForListBox(srcLs, destLs, srcList, destList, 0);
    //DeleteFromCDS(Decompose(destList.Strings[destList.count - 1], division));
    DeleteFromCDS(destList.Strings[destList.count - 1]);
  end;//while
end;

procedure TReceiveGreyClothForm.TransferValueForListBox(src, dest: TListBox; srcList, destList: TStringList; index: Integer);
begin
  if(src.Count > 0) and (index > -1) then
  begin
    dest.Items.Add(src.Items.Strings[index]);
    destList.Add(srcList.Strings[index]);

    src.Items.Delete(index);//src.DeleteSelected;
    srcList.Delete(index);
  end;//if
end;

procedure TReceiveGreyClothForm.Refresh;
begin
  CleanText;
  CleanList;
  if cdsFnGreyCloth.Active then
    cdsFnGreyCloth.EmptyDataSet;
  QueryFnGreyClothData(rsStatus + division + Login.CurrentDepartment);
end;

procedure TReceiveGreyClothForm.lstFabricNoDblClick(Sender: TObject);
begin
  inherited;
  MoveDown(lstFabricNo, lstWaitFabricNo, GSrcList, GDestList);
end;

procedure TReceiveGreyClothForm.lstWaitFabricNoDblClick(Sender: TObject);
begin
  inherited;
  MoveUp(lstWaitFabricNo, lstFabricNo, GDestList, GSrcList);
end;

procedure TReceiveGreyClothForm.btnMoveDownClick(Sender: TObject);
begin
  inherited;
  MoveDown(lstFabricNo, lstWaitFabricNo, GSrcList, GDestList);
end;

procedure TReceiveGreyClothForm.btnMoveDownAllClick(Sender: TObject);
begin
  inherited;
  MoveDownAll(lstFabricNo, lstWaitFabricNo, GSrcList, GDestList);
end;

procedure TReceiveGreyClothForm.btnMoveUpClick(Sender: TObject);
begin
  inherited;
  MoveUp(lstWaitFabricNo, lstFabricNo, GDestList, GSrcList);
end;

procedure TReceiveGreyClothForm.btnMoveUpAllClick(Sender: TObject);
begin
  inherited;
  MoveUpAll(lstWaitFabricNo, lstFabricNo, GDestList, GSrcList);
end;

procedure TReceiveGreyClothForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  Refresh;
end;

procedure TReceiveGreyClothForm.btnSendClick(Sender: TObject);
begin
  inherited;
  Save;
end;

function TReceiveGreyClothForm.SaveToDB(aData: OleVariant): Boolean;
var
  sErrMsg : WideString;
begin
  Result := False;
  try
    uShowMessage.ShowStatusMessage('���ڱ�������...', crHourGlass);

    FNMServerObj.SaveBaseTableInfo(aData, 'QCMDB.DBO.' + rsTable, '', sErrMsg);
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

end.
