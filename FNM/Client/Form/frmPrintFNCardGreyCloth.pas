{******************************************************************************
       ������� WMIS ����FNM
       �ļ����� frmPrintFNCardGreyCloth
       ��Ȩ���� (C) 2013 ESQUEL GROUP GET/IT
       �������� 2013-12-04
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
unit frmPrintFNCardGreyCloth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxSplitter, ExtCtrls, StdCtrls, frmBase, Grids,
  DBGrids, DB, DBClient, Buttons, MakeSQL;

const
  rsTable = 'fnGreyCloth';      //�����
  rsStatus = '����';          //���ѯ״ֵ̬
  rsSaveStatus = '�ӹ���';      //��״ֵ̬
  rsFormat = 'yyyy-MM-dd HH:mm';//���ڸ�ʽ
  division = '|';               //�ָ���


type
  TPrintFNCardGreyClothForm = class(TBaseForm)
    grpTop: TGroupBox;
    pnlTop: TPanel;
    grpClient: TGroupBox;
    pnlBottom: TPanel;
    cxSplitter1: TcxSplitter;
    dbgrdWait: TDBGrid;
    pnlRight: TPanel;
    cdsQuery: TClientDataSet;
    dsWait: TDataSource;
    cdsPrint: TClientDataSet;
    dsPrint: TDataSource;
    dbgrdPrint: TDBGrid;
    btnMoveDown: TBitBtn;
    btnMoveDownAll: TBitBtn;
    btnMoveUp: TBitBtn;
    btnMoveUpAll: TBitBtn;
    btnRefresh: TBitBtn;
    btnQuery: TBitBtn;
    btnPrint: TBitBtn;
    btnExit: TBitBtn;
    cdsSource: TClientDataSet;
    cdsPrintID: TStringField;
    cdsPrintJob_NO: TStringField;
    cdsPrintGF_NO: TStringField;
    cdsPrintFabric_NO: TStringField;
    cdsPrintProduction_Code: TStringField;
    cdsPrintProduction_Name: TStringField;
    cdsPrintStatus: TStringField;
    msGreyCloth: TMakeSQL;
    cdsPrintGF_ID: TIntegerField;
    cdsWait: TClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField1: TIntegerField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    cdsPrintPPData: TClientDataSet;
    cdsSave: TClientDataSet;
    chkIsPreview: TCheckBox;
    cdsWaitMachine_ID: TStringField;
    cdsPrintMachine_ID: TStringField;
    cdsWaitWidth: TBCDField;
    cdsPrintWidth: TBCDField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
    procedure btnMoveDownAllClick(Sender: TObject);
    procedure btnMoveUpClick(Sender: TObject);
    procedure btnMoveUpAllClick(Sender: TObject);
    procedure dbgrdWaitDblClick(Sender: TObject);
    procedure dbgrdPrintDblClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
  private
    { Private declarations }
    //���ݲ���
      //���ݿ�
    function QueryData(aCDS: TClientDataSet; const aType : String; aSQL: WideString) : Boolean;//ͨ�ò�ѯ���ݷ���
    procedure QueryFnGreyClothData(aValue : String);                            //������Դ��ѯfnGreyCloth����Ͳ�����
    function QueryProductionParameterData(aValue : String) : Boolean;           //��ѯ���ղ����������ڴ�ӡ
    procedure GetFnGreyClothNullData(aCDS : TClientDataSet);                    //��ȡfnGreyCloth������ݼ�
    function GetNewFNCard : String;                                             //��ȡ�µĿ���
    function SaveToDB(aData : OleVariant) : Boolean;                            //�������ݿ�ָ������
      //����
    procedure AddToLocalCDS(srcCDS, localCDS : TDataSet);                       //����Ϣ��ӵ�����ClientDataSet
    procedure TransferValueForCDS(srcCDS, destCDS : TDataSet);                  //�ƶ�ԴListBox�е�ֵ��ָ��ListBox��
    function CheckIsAlike(aCDS : TDataSet; aField : String; aValue : String) : Boolean;//��鹤���Ƿ�һ��
    function Save(Idens : String) : Boolean;                                    //���淽��
    //�������
    procedure Initialise;                                                       //��ʼ������
    procedure CleanText;                                                        //�����ԴComboBox�복�ƺ�Edit
    procedure CleanCDS;                                                         //��� cdsWait �� cdsPrint
    procedure ReadOnlyKeyPress(Sender: TObject; var Key: Char);                 //ComboBox ֻ�� KeyPress �¼�
    procedure FullCommboBox(aCDS : TClientDataSet; aField : String; aCBB : TComboBox);//���CommboBox

    procedure MoveDown(srcCDS, destCDS : TClientDataSet);                       //���Ʒ���
    procedure MoveDownAll(srcCDS, destCDS : TClientDataSet);                    //ȫ���Ʒ���
    procedure MoveUp(srcCDS, destCDS : TClientDataSet);                         //���Ʒ���
    procedure MoveUpAll(srcCDS, destCDS : TClientDataSet);                      //ȫ���Ʒ���
    procedure Refresh;                                                          //ˢ�·���
    procedure Query;                                                            //��ѯ����
    procedure GetMessageDlg;                                                    //������Ϣ��ʾ�򷽷�
    procedure Print;                                                            //��ӡ����
  public
    { Public declarations }
  end;

var
  PrintFNCardGreyClothForm: TPrintFNCardGreyClothForm;

implementation

uses uShowMessage, ServerDllPub, uGlobal, uFNMResource, rptFNCardGreyCloth,
  uLogin;

{$R *.dfm}

{ TPrintFNCardGreyClothForm }

procedure TPrintFNCardGreyClothForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialise;
end;

function TPrintFNCardGreyClothForm.QueryData(aCDS: TClientDataSet;
  const aType: String; aSQL: WideString): Boolean;
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

procedure TPrintFNCardGreyClothForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if cdsPrint.ChangeCount > 0 then
   if MessageDlg('��ʾ: �������޸�, ��δ����, �Ƿ�����˳�����?', mtConfirmation, [mbYes, mbNo],0) = mrNo then
   begin
     Action := caNone;
     Exit;
   end;//if
  Action := caFree;
end;

procedure TPrintFNCardGreyClothForm.FormDestroy(Sender: TObject);
begin
  inherited;
  PrintFNCardGreyClothForm := nil;
end;

procedure TPrintFNCardGreyClothForm.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TPrintFNCardGreyClothForm.Initialise;
begin
  CleanText;

  dbgrdWait.ReadOnly := True;
  dbgrdPrint.ReadOnly := True;

  GetFnGreyClothNullData(cdsWait);
  GetFnGreyClothNullData(cdsPrint);
  QueryFnGreyClothData(rsStatus + division + Login.CurrentDepartment);// //����[����]״̬�뵱ǰ����

  cdsWait.IndexFieldNames := 'Machine_ID';
  cdsPrint.IndexFieldNames := 'Machine_ID';
end;

procedure TPrintFNCardGreyClothForm.QueryFnGreyClothData(aValue: String);
var
  sSQL : String;
begin
  //sSQL := QuotedStr('QueryFnGreyClothByStatusAndSource') + ','+ QuotedStr(aValue); //�ڶ�������ʽ('״̬|��Դ')
  sSQL := QuotedStr('QueryFnGreyClothByStatusAndProcessAdd') + ','+ QuotedStr(aValue); //�ڶ�������ʽ('״̬|�ӹ��ص�')
  if QueryData(cdsQuery, rsTable, sSQL) then
    AddToLocalCDS(cdsQuery,cdsWait); //����ȡ�������뵽���صĴ���CDS��
end;

procedure TPrintFNCardGreyClothForm.GetFnGreyClothNullData(aCDS : TClientDataSet);
var
  sSQL : String;
begin
  sSQL := QuotedStr('GetFnGreyClothNull') + ','+ QuotedStr('');
  QueryData(aCDS, rsTable, sSQL);
end;

procedure TPrintFNCardGreyClothForm.AddToLocalCDS(srcCDS, localCDS: TDataSet);
begin
  srcCDS.DisableControls;
  try
    srcCDS.First;
    while not srcCDS.Eof do
    begin
      localCDS.Append;
      localCDS.FieldByName('ID').AsString := srcCDS.FieldByName('Iden').AsString;//���
      localCDS.FieldByName('Job_NO').AsString := srcCDS.FieldByName('Job_NO').AsString;//�ŵ���
      localCDS.FieldByName('Machine_ID').AsString := srcCDS.FieldByName('Machine_ID').AsString;//Ʒ����
      localCDS.FieldByName('GF_ID').AsString := srcCDS.FieldByName('GF_ID').AsString;//Ʒ����
      localCDS.FieldByName('GF_NO').AsString := srcCDS.FieldByName('GF_NO').AsString;//Ʒ��
      localCDS.FieldByName('Fabric_No').AsString := srcCDS.FieldByName('Fabric_No').AsString;//����
      localCDS.FieldByName('Production_Code').AsString := srcCDS.FieldByName('Production_Code').AsString;
      localCDS.FieldByName('Production_Name').AsString := srcCDS.FieldByName('Production_Name').AsString;
      localCDS.FieldByName('Status').AsString := srcCDS.FieldByName('Status').AsString;
      localCDS.FieldByName('Width').AsString := srcCDS.FieldByName('Width').AsString; //�ŷ�
      localCDS.Post;
      srcCDS.Next;
    end;//while
  finally
    srcCDS.EnableControls;
  end;
end;

procedure TPrintFNCardGreyClothForm.CleanText;
begin
  //cbbSource.Text := '';
  //edtCarNO.Text := '';
end;

procedure TPrintFNCardGreyClothForm.CleanCDS;
begin
  cdsWait.MergeChangeLog;
  cdsWait.EmptyDataSet;
  
  cdsPrint.MergeChangeLog;
  cdsPrint.EmptyDataSet;
end;

procedure TPrintFNCardGreyClothForm.ReadOnlyKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := #0;
end;

procedure TPrintFNCardGreyClothForm.FullCommboBox(aCDS: TClientDataSet; aField: String; aCBB: TComboBox);
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

procedure TPrintFNCardGreyClothForm.TransferValueForCDS(srcCDS, destCDS : TDataSet);
begin
  srcCDS.DisableControls;
  try
    if srcCDS.RecordCount > 0 then
    begin
      destCDS.Append;
      destCDS.FieldByName('ID').AsString := srcCDS.FieldByName('ID').AsString;//���
      destCDS.FieldByName('Job_NO').AsString := srcCDS.FieldByName('Job_NO').AsString;//�ŵ���
      destCDS.FieldByName('Machine_ID').AsString := srcCDS.FieldByName('Machine_ID').AsString;//�ŵ���
      destCDS.FieldByName('GF_ID').AsString := srcCDS.FieldByName('GF_ID').AsString;//Ʒ����
      destCDS.FieldByName('GF_NO').AsString := srcCDS.FieldByName('GF_NO').AsString;//Ʒ��
      destCDS.FieldByName('Fabric_No').AsString := srcCDS.FieldByName('Fabric_No').AsString;//����
      destCDS.FieldByName('Production_Code').AsString := srcCDS.FieldByName('Production_Code').AsString;
      destCDS.FieldByName('Production_Name').AsString := srcCDS.FieldByName('Production_Name').AsString;
      destCDS.FieldByName('Status').AsString := srcCDS.FieldByName('Status').AsString;
      destCDS.FieldByName('Width').AsString := srcCDS.FieldByName('Width').AsString; //�ŷ�
      destCDS.Post;
    end;//if
  finally
    srcCDS.EnableControls;
  end;//finally
end;

procedure TPrintFNCardGreyClothForm.MoveDown(srcCDS, destCDS : TClientDataSet);
begin
  if(not srcCDS.Active) or (srcCDS.RecordCount = 0) then
    Exit;

  if CheckIsAlike(destCDS, 'Production_Code', srcCDS.FieldByName('Production_Code').AsString) then
  begin
    TransferValueForCDS(srcCDS, destCDS);
    srcCDS.Delete;
  end else
    GetMessageDlg;

end;

procedure TPrintFNCardGreyClothForm.MoveDownAll(srcCDS, destCDS : TClientDataSet);
var
  JodNO : string;
begin
  if(not srcCDS.Active) or (srcCDS.RecordCount = 0) then
    Exit;

  srcCDS.First;
  while not srcCDS.Eof do
  begin
    if CheckIsAlike(destCDS, 'Production_Code', srcCDS.FieldByName('Production_Code').AsString) then
    begin
      TransferValueForCDS(srcCDS, destCDS);
      srcCDS.Delete;
    end else
      srcCDS.Next;
  end;//while

  if srcCDS.RecordCount > 0 then
    GetMessageDlg;
end;

procedure TPrintFNCardGreyClothForm.MoveUp(srcCDS, destCDS: TClientDataSet);
begin
  if (srcCDS.Active) and (srcCDS.RecordCount > 0) then
  begin
    TransferValueForCDS(srcCDS, destCDS);
    srcCDS.Delete;
  end;//if
end;

procedure TPrintFNCardGreyClothForm.MoveUpAll(srcCDS, destCDS: TClientDataSet);
begin
  if (srcCDS.Active) and (srcCDS.RecordCount > 0) then
  begin
    srcCDS.First;
    while not srcCDS.Eof do
    begin
      TransferValueForCDS(srcCDS, destCDS);
      srcCDS.Delete;
    end;//while
  end;//if
end;


function TPrintFNCardGreyClothForm.CheckIsAlike(aCDS : TDataSet; aField : String; aValue : String): Boolean;
begin
  Result := False;
  if (aField <> '')then
  begin
    if aCDS.RecordCount = 0 then
    begin
      Result := True;
      Exit;
    end;//if
    aCDS.Filter := aField + '=' + QuotedStr(aValue);
    aCDS.Filtered := True;
    Result := (aCDS.RecordCount > 0);
    aCDS.Filtered := False;
  end;//if
end;

procedure TPrintFNCardGreyClothForm.Refresh;
begin
  CleanCDS;
  QueryFnGreyClothData(rsStatus + division + Login.CurrentDepartment);
end;

procedure TPrintFNCardGreyClothForm.Query;
var
  aWhere : string;
begin
  if cdsWait.RecordCount > 0 then
  begin
    aWhere := msGreyCloth.GetSql;
    if Trim(aWhere) <> '' then
    begin
      cdsWait.Filter := aWhere;
      cdsWait.Filtered := True;
    end;//if
  end;//if
end;

procedure TPrintFNCardGreyClothForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  Refresh;
end;

procedure TPrintFNCardGreyClothForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  Query;
end;

procedure TPrintFNCardGreyClothForm.btnMoveDownClick(Sender: TObject);
begin
  inherited;
  MoveDown(cdsWait, cdsPrint);
end;

procedure TPrintFNCardGreyClothForm.btnMoveDownAllClick(Sender: TObject);
begin
  inherited;
  MoveDownAll(cdsWait, cdsPrint);
end;

procedure TPrintFNCardGreyClothForm.btnMoveUpClick(Sender: TObject);
begin
  inherited;
  MoveUp(cdsPrint, cdsWait);
end;

procedure TPrintFNCardGreyClothForm.btnMoveUpAllClick(Sender: TObject);
begin
  inherited;
  MoveUpAll(cdsPrint, cdsWait);
end;

procedure TPrintFNCardGreyClothForm.dbgrdWaitDblClick(Sender: TObject);
begin
  inherited;
  MoveDown(cdsWait, cdsPrint);
end;

procedure TPrintFNCardGreyClothForm.dbgrdPrintDblClick(Sender: TObject);
begin
  inherited;
  MoveUp(cdsPrint, cdsWait);
end;

procedure TPrintFNCardGreyClothForm.GetMessageDlg;
begin
  //TMsgDialog.ShowMsgDialog('��ͬ������������ܴ򿨣���ȷ��' ,mtConfirmation);
  MessageDlg('��ͬ������������ܴ򿨣���ȷ��', mtInformation, [mbOK], 0);
end;

procedure TPrintFNCardGreyClothForm.Print;
var
  iden : string;
  cardPrint : TFNCardGreyClothReport;
begin
  if (cdsPrint.RecordCount = 0) then
    Exit;

  {if Trim(edtCarNO.Text) = '' then
  begin
    MessageDlg('����д���ƺ�', mtInformation, [mbOK], 0);
    edtCarNO.SetFocus;
    Exit;
  end;}

  iden := '';
  cdsPrint.First;
  while not cdsPrint.Eof do
  begin
    iden := iden + cdsPrint.FieldByName('ID').AsString + ',';
    cdsPrint.Next;
  end;//while
  //Delete(iden, Length(iden), 1); //ɾ�����Ķ���

  if Save(iden + division + Login.LoginName + division + Login.CurrentDepartment) then
  begin
    if QueryProductionParameterData(iden) then
    begin
      cardPrint := TFNCardGreyClothReport.Create(nil);
      try
        cardPrint.cdsGC.Data := cdsSave.Data;
        cardPrint.cdsPP.Data := cdsPrintPPData.Data;
        cardPrint.QRLabFNCard.Caption := cdsSave.FieldByName('FN_Card').AsString;
        cardPrint.QRLabCount.Caption := IntToStr(cdsSave.RecordCount);
        //�Ƿ�Ԥ����ӡ
        if chkIsPreview.Checked then
          cardPrint.QuickRep1.Preview
        else
          cardPrint.QuickRep1.Print;
      finally
        if Assigned(cardPrint) then
          FreeAndNil(cardPrint);
        cdsSave.Close;
      end;//finally
    end;//if
  end;//if

end;

function TPrintFNCardGreyClothForm.QueryProductionParameterData(aValue: String) : Boolean;
var
  sSQL : string;
begin
  sSQL := QuotedStr('QueryProductionParameterData') + ','+ QuotedStr(aValue);
  Result := QueryData(cdsPrintPPData, rsTable, sSQL);
end;

function TPrintFNCardGreyClothForm.GetNewFNCard: String;
var
  sSQL : string;
  cds : TClientDataSet;
begin
  Result := '';
  cds := TClientDataSet.Create(nil);
  try
    sSQL := QuotedStr('GetNewFNCard') + ','+ QuotedStr('');
    if QueryData(cds, rsTable, sSQL) then
    begin
      if(cds.Active)and(cds.RecordCount = 1)then
        Result := cds.FieldByName('NewFNCard').AsString;
    end;//if
  finally
    if Assigned(cds) then
      FreeAndNil(cds);
  end;//finally
end;

procedure TPrintFNCardGreyClothForm.btnPrintClick(Sender: TObject);
begin
  inherited;
  Print;
end;

function TPrintFNCardGreyClothForm.SaveToDB(aData: OleVariant): Boolean;
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

function TPrintFNCardGreyClothForm.Save(Idens : String) : Boolean;
var
  sSQL : string;
begin
  Result := False;
  if cdsPrint.RecordCount > 0 then
  begin
    sSQL := QuotedStr('SavaPrintCardData') + ','+ QuotedStr(Idens);
    if not QueryData(cdsSave, rsTable, sSQL) then
    begin
      if MessageDlg('�������ݻ�ȡʧ�ܣ��Ƿ��������', mtConfirmation, [mbYes, mbNo], 0) = mrNO then
        MoveUpAll(cdsPrint, cdsWait);
      Exit;
    end;//if
    cdsPrint.EmptyDataSet;
    Result := True;
  end;//if

  {if cdsPrint.RecordCount > 0 then
  begin
    sSQL := QuotedStr('QueryFnGreyClothByStatus') + ','+ QuotedStr(rsStatus);
    if not QueryData(cdsSave, rsTable, sSQL) then
      if MessageDlg('�������ݻ�ȡʧ�ܣ��Ƿ��������', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        Exit;

    cdsPrint.First;
    while not cdsPrint.Eof do
    begin
      cdsSave.Locate('Iden', cdsPrint.FieldByName('ID').AsString, []);
      cdsSave.Edit;
      cdsSave.FieldByName('FN_Card').AsString := newFNCard;
      cdsSave.FieldByName('Status').AsString := rsSaveStatus;
      cdsSave.Post;

      cdsPrint.Next;
    end;//while

    if not SaveToDB(cdsSave.Delta) then
    begin
      if MessageDlg('���ݱ���ʧ�ܣ��Ƿ�������Ա�������', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        Exit;
    end;//if
    Result := True;
    cdsSave.Close;
    cdsPrint.EmptyDataSet;
    //edtCarNO.Text := '';
  end;//if}
end;

end.
