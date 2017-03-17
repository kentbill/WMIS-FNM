{******************************************************************************

       ������� WMIS ����FNM
       �ļ����� frmReturnGreyCloth
       ��Ȩ���� (C) 2013 ESQUEL GROUP GET/IT
       �������� 2013-12-06
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
            QCMDB.dbo.qiEmailItemList
          �洢���̣�
            QCMDB.dbo.usp_fnGreyClothData

******************************************************************************}          
unit frmReturnGreyCloth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxSplitter, ExtCtrls, StdCtrls, Buttons, Grids,
  DBGrids, DB, DBClient, frmBase;

const
  rsTable = 'fnGreyCloth';      //�����
  rsStatus = '�ӹ���';          //���ѯ״ֵ̬
  rsSaveStatus = '�ӹ����';    //��״ֵ̬
  rsFormat = 'yyyy-MM-dd HH:mm';//���ڸ�ʽ
  division = '|';               //�ָ���

type
  TReturnGreyClothForm = class(TBaseForm)
    pnlLeft: TPanel;
    cxSplitter1: TcxSplitter;
    pnlClient: TPanel;
    pnlClientBottom: TPanel;
    grpTop: TGroupBox;
    lstSrc: TListBox;
    cxSplitter2: TcxSplitter;
    pnlTop2: TPanel;
    btnMoveDown: TBitBtn;
    btnMoveDownAll: TBitBtn;
    btnMoveUp: TBitBtn;
    btnMoveUpAll: TBitBtn;
    grp3: TGroupBox;
    lstDest: TListBox;
    grp1: TGroupBox;
    pnlBottomRight: TPanel;
    dbgrdFGCl: TDBGrid;
    btnSend: TBitBtn;
    btnClose: TBitBtn;
    cdsQuery: TClientDataSet;
    cdsFnGreyCloth: TClientDataSet;
    cdsFnGreyClothID: TIntegerField;
    cdsFnGreyClothFabric_No: TStringField;
    cdsFnGreyClothJob_NO: TStringField;
    cdsFnGreyClothSource: TStringField;
    cdsFnGreyClothGF_ID: TIntegerField;
    dsFnGreyCloth: TDataSource;
    cdsFnGreyClothFN_CARD: TStringField;
    cdsFnGreyClothProcess_Add: TStringField;
    cdsEMail: TClientDataSet;
    cdsSave: TClientDataSet;
    cdsFnGreyClothGF_NO: TStringField;
    cdsFnGreyClothQuantity: TFloatField;
    btnRefresh: TBitBtn;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
    procedure btnMoveDownAllClick(Sender: TObject);
    procedure btnMoveUpClick(Sender: TObject);
    procedure btnMoveUpAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lstSrcDblClick(Sender: TObject);
    procedure lstDestDblClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
  private
    { Private declarations }
    GSrcList : TStringList;                                                     //��¼Դ����Iden��  ��ʽ��1��2��3��4
    GDestList : TStringList;                                                    //��¼Ŀ������Iden��  ��ʽ��1��2��3��4
    //���ݲ���
      //���ݿ�
    function QueryData(aCDS: TClientDataSet; const aType : String; aSQL: WideString) : Boolean;//ͨ�ò�ѯ���ݷ���
    procedure QueryFnGreyClothData(aValue : String);                            //������Դ��ѯfnGreyCloth����Ͳ�����
    procedure GetFnGreyClothNullData(aCDS: TClientDataSet);                     //��ȡfnGreyCloth������ݼ�
    procedure ExecSendEmail(Idens: String);                                     //�����ʼ�����
    function SavaToDB(aData : OleVariant) : Boolean;                            //�������ݿ�ָ������
      //����
    procedure SaveToCDS(Idens : String);                                        //���浽����cdsFnGreyCloth
    procedure DeleteFromCDS(Idens : String);                                    //ɾ������cdsFnGreyCloth�е�ָ������
    procedure Save;                                                             //���淽��
    procedure Refresh;                                                            //��ѯ����
      //�������
    procedure Initialise;                                                       //��ʼ������
    procedure CleanText;                                                        //����ı���(ComboBox, ListBox)
    procedure CleanList;                                                        //���TStringList
    procedure FullListBox(aCDS : TClientDataSet; aField : String; aLst : TListBox);//���ListBox����

    procedure TransferValueForListBox(src, dest : TListBox; srcList, destList : TStringList; index : Integer);//�ƶ�ԴListBox�е�ֵ��ָ��ListBox��
    procedure MoveDown(srcLs, destLs : TListBox; srcList, destList : TStringList); //���Ʒ���
    procedure MoveDownAll(srcLs, destLs : TListBox; srcList, destList : TStringList);//ȫ���Ʒ���
    procedure MoveUp(srcLs, destLs : TListBox; srcList, destList : TStringList);   //���Ʒ���
    procedure MoveUpAll(srcLs, destLs : TListBox; srcList, destList : TStringList);//ȫ���Ʒ���
    function Decompose(aValue : String; aDiv : string) : String;
  public
    { Public declarations }
  end;

var
  ReturnGreyClothForm: TReturnGreyClothForm;

implementation

uses uShowMessage, ServerDllPub, uGlobal, uFNMResource, uLogin;

{$R *.dfm}

procedure TReturnGreyClothForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TReturnGreyClothForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if cdsFnGreyCloth.ChangeCount > 0 then
   if MessageDlg('��ʾ: �������޸�, ��δ����, �Ƿ�����˳�����?', mtConfirmation, [mbYes, mbNo],0) = mrNo then
   begin
     Action := caNone;
     Exit;
   end;//if
  Action := caFree;
end;

procedure TReturnGreyClothForm.FormDestroy(Sender: TObject);
begin
  ReturnGreyClothForm := nil;
end;

function TReturnGreyClothForm.QueryData(aCDS: TClientDataSet; const aType: String; aSQL: WideString): Boolean;
var
  vData : OleVariant;
  sErrMsg : WideString;
begin
  Result := False;
  try
    ShowMsg('���ڲ�ѯ�Եȣ�', crHourGlass);
    aCDS.Close;
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

procedure TReturnGreyClothForm.QueryFnGreyClothData(aValue: String);
var
  sSQL : String;
begin
  //sSQL := QuotedStr('QueryFnGreyClothByStatus') + ','+ QuotedStr(aValue);
  //sSQL := QuotedStr('QueryFnGreyClothByStatusAndProcessAdd')+ ','+ QuotedStr(aValue); //2014-01-07 APJ zhaogangע��
  sSQL := QuotedStr('QueryFnGreyClothByStatusAndProcessAddOfStepNO')+ ','+ QuotedStr(aValue);  //2014-01-07 APJ zhaogang
  if QueryData(cdsQuery, rsTable, sSQL) then
  begin
    cdsQuery.IndexFieldNames := 'FN_CARD'; //��������
    FullListBox(cdsQuery,'FN_CARD',lstSrc);
  end;
end;

procedure TReturnGreyClothForm.GetFnGreyClothNullData(aCDS: TClientDataSet);
var
  sSQL : String;
begin
  sSQL := QuotedStr('GetFnGreyClothNull') + ','+ QuotedStr('');
  QueryData(aCDS, rsTable, sSQL);
end;

procedure TReturnGreyClothForm.Initialise;
begin
  GSrcList := TStringList.Create;
  GDestList := TStringList.Create;

  dbgrdFGCl.ReadOnly := True;

  CleanText;

  QueryFnGreyClothData(rsStatus + division + Login.CurrentDepartment); //��ȡ��ѯ����
  GetFnGreyClothNullData(cdsFnGreyCloth);                              //��ȡ�յ����ݼ�
end;

procedure TReturnGreyClothForm.CleanText;
begin
  lstSrc.Items.Clear;
  lstDest.Items.Clear;
end;

procedure TReturnGreyClothForm.CleanList;
begin
  GSrcList.Clear;
  GDestList.Clear;
end;

procedure TReturnGreyClothForm.FullListBox(aCDS: TClientDataSet; aField : String; aLst: TListBox);
var
  idens : string;  //�ۼ�Idenֵ
  fnCard : string; //��¼ǰһλ�Ŀ���ֵ�����ڱȽ�����������ʱ��ֵ
begin
  if (aCDS.Active) and (aCDS.RecordCount > 0) and (aField <> '')then
  begin
    GSrcList.Clear;//���TStringList

    aLst.Items.Clear;
    aCDS.First;
    fnCard := aCDS.FieldByName('FN_CARD').AsString;
    while not aCDS.Eof do
    begin
      idens := idens + aCDS.FieldByName('Iden').AsString + ',';
      aCDS.Next;

      if(fnCard <> aCDS.FieldByName('FN_CARD').AsString)then //���ǰһ�������뵱ǰ��һ�£���ǰһλ������Iden�ۼ�ֵ����
      begin
        Delete(idens, Length(idens), 1);  //ɾ�����Ķ���
        //GSrcList.Add(fnCard + division + idens);//SrcList������� ���ź�Iden�飬������Q20131200001|1��2��3��4��
        GSrcList.Add(idens);
        aLst.Items.Add(fnCard);
        idens := '';
        fnCard := aCDS.FieldByName('FN_CARD').AsString;
      end;//if
    end;//while

    Delete(idens, Length(idens), 1);
    //GSrcList.Add(fnCard + division + idens);//SrcList������� ���ź�Iden�飬������Q20131200001|1��2��3��4
    GSrcList.Add(idens);
    aLst.Items.Add(fnCard);
  end;//if
end;

procedure TReturnGreyClothForm.TransferValueForListBox(src, dest: TListBox;
  srcList, destList: TStringList; index: Integer);
begin
  if(src.Count > 0) and (index > -1) then
  begin
    dest.Items.Add(src.Items.Strings[index]);
    destList.Add(srcList.Strings[index]);

    src.Items.Delete(index);//src.DeleteSelected;
    srcList.Delete(index);
  end;//if
end;

procedure TReturnGreyClothForm.MoveDown(srcLs, destLs: TListBox; srcList,
  destList: TStringList);
begin
  if srcLs.ItemIndex > -1 then
  begin
    TransferValueForListBox(srcLs, destLs, srcList, destList, srcLs.ItemIndex);
    //SaveToCDS(Decompose(destList.Strings[destList.Count - 1], division));//����Ŀ��StringList������������
    SaveToCDS(destList.Strings[destList.Count - 1]);
  end;//if
end;

procedure TReturnGreyClothForm.MoveDownAll(srcLs, destLs: TListBox;
  srcList, destList: TStringList);
begin
  while(srcLs.Count > 0) do
  begin
    TransferValueForListBox(srcLs, destLs, srcList, destList, 0);
    //SaveToCDS(Decompose(destList.Strings[destList.Count - 1], division));//����Ŀ��StringList������������
    SaveToCDS(destList.Strings[destList.Count - 1]);
  end;//while

end;

procedure TReturnGreyClothForm.MoveUp(srcLs, destLs: TListBox; srcList,
  destList: TStringList);
begin
  if srcLs.ItemIndex > -1 then
  begin
    TransferValueForListBox(srcLs, destLs, srcList, destList, srcLs.ItemIndex);
    //DeleteFromCDS(Decompose(destList.Strings[destList.Count - 1], division));
    DeleteFromCDS(destList.Strings[destList.Count - 1]);
  end;//if

end;

procedure TReturnGreyClothForm.MoveUpAll(srcLs, destLs: TListBox; srcList,
  destList: TStringList);
begin
  while(srcLs.Count > 0) do
  begin
    TransferValueForListBox(srcLs, destLs, srcList, destList, 0);
    //DeleteFromCDS(Decompose(destList.Strings[destList.Count - 1], division));
    DeleteFromCDS(destList.Strings[destList.Count - 1]);
  end;//while

end;

procedure TReturnGreyClothForm.btnMoveDownClick(Sender: TObject);
begin
  MoveDown(lstSrc, lstDest, GSrcList, GDestList);
end;

procedure TReturnGreyClothForm.btnMoveDownAllClick(Sender: TObject);
begin
  MoveDownAll(lstSrc, lstDest, GSrcList, GDestList);
end;

procedure TReturnGreyClothForm.btnMoveUpClick(Sender: TObject);
begin
  MoveUp(lstDest, lstSrc, GDestList, GSrcList);
end;

procedure TReturnGreyClothForm.btnMoveUpAllClick(Sender: TObject);
begin
  MoveUpAll(lstDest, lstSrc, GDestList, GSrcList);
end;

procedure TReturnGreyClothForm.SaveToCDS(Idens: String);
begin
  if Idens <> '' then
  begin
    cdsQuery.Filter := 'Iden in (' + Idens + ')';
    cdsQuery.Filtered := True;
    cdsQuery.First;
    while not cdsQuery.Eof do
    begin
      cdsFnGreyCloth.Append;
      cdsFnGreyCloth.FieldByName('ID').AsString := cdsQuery.FieldByName('Iden').AsString;
      cdsFnGreyCloth.FieldByName('FN_CARD').AsString := cdsQuery.FieldByName('FN_CARD').AsString;
      cdsFnGreyCloth.FieldByName('Fabric_No').AsString := cdsQuery.FieldByName('Fabric_No').AsString;
      cdsFnGreyCloth.FieldByName('GF_ID').AsString := cdsQuery.FieldByName('GF_ID').AsString;
      cdsFnGreyCloth.FieldByName('GF_NO').AsString := cdsQuery.FieldByName('GF_NO').AsString;
      cdsFnGreyCloth.FieldByName('Job_NO').AsString := cdsQuery.FieldByName('Job_NO').AsString;
      cdsFnGreyCloth.FieldByName('Quantity').AsFloat := cdsQuery.FieldByName('Quantity').AsFloat;
      cdsFnGreyCloth.FieldByName('Source').AsString := cdsQuery.FieldByName('Source').AsString;
      cdsFnGreyCloth.FieldByName('Process_Add').AsString := cdsQuery.FieldByName('Process_Add').AsString;
      cdsFnGreyCloth.Post;

      cdsQuery.Next;
    end;//while
    cdsQuery.Filtered := False;
  end;//if
end;

procedure TReturnGreyClothForm.DeleteFromCDS(Idens: String);
begin
  if Idens <> '' then
  begin
    cdsFnGreyCloth.Filter := 'ID in (' + Idens + ')';
    cdsFnGreyCloth.Filtered := True;
    while cdsFnGreyCloth.RecordCount > 0 do
      cdsFnGreyCloth.Delete;
    cdsFnGreyCloth.Filtered := False;
  end;//if
end;

function TReturnGreyClothForm.Decompose(aValue, aDiv: string): String;
begin
  Result := Copy(aValue,Pos(aDiv, aValue) + 1, Length(aValue));
end;


procedure TReturnGreyClothForm.FormCreate(Sender: TObject);
begin
  Initialise;
end;

procedure TReturnGreyClothForm.lstSrcDblClick(Sender: TObject);
begin
  MoveDown(lstSrc, lstDest, GSrcList, GDestList);
end;

procedure TReturnGreyClothForm.lstDestDblClick(Sender: TObject);
begin
  MoveUp(lstDest, lstSrc, GDestList, GSrcList);
end;

function TReturnGreyClothForm.SavaToDB(aData: OleVariant): Boolean;
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

procedure TReturnGreyClothForm.Save;
var
  iden : string;
  status : String;
  sSQL : String;
begin
  if cdsFnGreyCloth.RecordCount > 0 then
  begin
    sSQL := QuotedStr('QueryFnGreyClothByStatus') + ','+ QuotedStr(rsStatus);
    if not QueryData(cdsSave, rsTable, sSQL) then
      if MessageDlg('�������ݻ�ȡʧ�ܣ��Ƿ��������', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        Exit;

    cdsFnGreyCloth.First;
    while not cdsFnGreyCloth.Eof do
    begin
      cdsSave.Locate('Iden', cdsFnGreyCloth.FieldByName('ID').AsString, []);
      cdsSave.Edit;
      cdsSave.FieldByName('Status').AsString := rsSaveStatus;
      cdsSave.FieldByName('Back_Time').AsString := FormatDateTime(rsFormat, now);
      cdsSave.Post;

      iden := iden + cdsSave.FieldByName('Iden').AsString + ',';
      cdsFnGreyCloth.Next;
    end;//while

    if not SavaToDB(cdsSave.Delta) then
    begin
      if MessageDlg('���ݱ���ʧ�ܣ��Ƿ�������Ա�������', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        Exit;
    end else
    begin
      Delete(iden, Length(iden), 1);
      ExecSendEmail(iden);
    end;//else
    cdsSave.Close;
    cdsFnGreyCloth.IndexFieldNames := '';
    cdsFnGreyCloth.EmptyDataSet;
    GDestList.Clear;
    lstDest.Items.Clear;
  end;//if
end;

procedure TReturnGreyClothForm.btnSendClick(Sender: TObject);
begin
  Save;
end;

procedure TReturnGreyClothForm.Refresh;
begin
  CleanText;
  CleanList;

  QueryFnGreyClothData(rsStatus + division + Login.CurrentDepartment);
  GetFnGreyClothNullData(cdsFnGreyCloth);
end;

procedure TReturnGreyClothForm.ExecSendEmail(Idens: String);
var
  sSQL : WideString;
begin
  //sSQL := 'EXEC QCMDB.dbo.usp_fnGreyClothMail ' + QuotedStr('') + ',' + QuotedStr(rsSaveStatus) + ',' + QuotedStr(Idens);
  sSQL := QuotedStr('') + ',' + QuotedStr(rsSaveStatus) + ',' + QuotedStr(Idens);
  QueryData(cdsEMail, 'GreyClothMail', sSQL);
  cdsEMail.Close;
end;

procedure TReturnGreyClothForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  Refresh;
end;

end.
