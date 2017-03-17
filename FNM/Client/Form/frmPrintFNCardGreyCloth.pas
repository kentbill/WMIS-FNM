{******************************************************************************
       软件名称 WMIS ——FNM
       文件名称 frmPrintFNCardGreyCloth
       版权所有 (C) 2013 ESQUEL GROUP GET/IT
       创建日期 2013-12-04
       创建人员 APJ zhaogang  爱普京——赵港
       修改人员
       修改日期
       修改原因
       对应用例
       数据库
          表：
            QCMDB.dbo.fnGreyCloth	
          相关表：
            FNMDB.DBO.fnProductionList
            PDMDB.DBO.TDGFID
          存储过程：
            QCMDB.dbo.usp_fnGreyClothData
******************************************************************************}
unit frmPrintFNCardGreyCloth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxSplitter, ExtCtrls, StdCtrls, frmBase, Grids,
  DBGrids, DB, DBClient, Buttons, MakeSQL;

const
  rsTable = 'fnGreyCloth';      //所查表
  rsStatus = '待打卡';          //需查询状态值
  rsSaveStatus = '加工中';      //新状态值
  rsFormat = 'yyyy-MM-dd HH:mm';//日期格式
  division = '|';               //分隔符


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
    //数据操作
      //数据库
    function QueryData(aCDS: TClientDataSet; const aType : String; aSQL: WideString) : Boolean;//通用查询数据方法
    procedure QueryFnGreyClothData(aValue : String);                            //根据来源查询fnGreyCloth表待送布数据
    function QueryProductionParameterData(aValue : String) : Boolean;           //查询工艺参数——用于打印
    procedure GetFnGreyClothNullData(aCDS : TClientDataSet);                    //获取fnGreyCloth表空数据集
    function GetNewFNCard : String;                                             //获取新的卡号
    function SaveToDB(aData : OleVariant) : Boolean;                            //更新数据库指定数据
      //本地
    procedure AddToLocalCDS(srcCDS, localCDS : TDataSet);                       //将信息添加到本地ClientDataSet
    procedure TransferValueForCDS(srcCDS, destCDS : TDataSet);                  //移动源ListBox中的值到指定ListBox中
    function CheckIsAlike(aCDS : TDataSet; aField : String; aValue : String) : Boolean;//检查工序是否一致
    function Save(Idens : String) : Boolean;                                    //保存方法
    //窗体控制
    procedure Initialise;                                                       //初始化方法
    procedure CleanText;                                                        //清空来源ComboBox与车牌号Edit
    procedure CleanCDS;                                                         //清空 cdsWait 与 cdsPrint
    procedure ReadOnlyKeyPress(Sender: TObject; var Key: Char);                 //ComboBox 只读 KeyPress 事件
    procedure FullCommboBox(aCDS : TClientDataSet; aField : String; aCBB : TComboBox);//填充CommboBox

    procedure MoveDown(srcCDS, destCDS : TClientDataSet);                       //下移方法
    procedure MoveDownAll(srcCDS, destCDS : TClientDataSet);                    //全下移方法
    procedure MoveUp(srcCDS, destCDS : TClientDataSet);                         //上移方法
    procedure MoveUpAll(srcCDS, destCDS : TClientDataSet);                      //全上移方法
    procedure Refresh;                                                          //刷新方法
    procedure Query;                                                            //查询方法
    procedure GetMessageDlg;                                                    //给出信息提示框方法
    procedure Print;                                                            //打印方法
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
    ShowMsg('正在查询稍等！', crHourGlass);
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
   if MessageDlg('提示: 数据已修改, 尚未保存, 是否继续退出操作?', mtConfirmation, [mbYes, mbNo],0) = mrNo then
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
  QueryFnGreyClothData(rsStatus + division + Login.CurrentDepartment);// //根据[待打卡]状态与当前部门

  cdsWait.IndexFieldNames := 'Machine_ID';
  cdsPrint.IndexFieldNames := 'Machine_ID';
end;

procedure TPrintFNCardGreyClothForm.QueryFnGreyClothData(aValue: String);
var
  sSQL : String;
begin
  //sSQL := QuotedStr('QueryFnGreyClothByStatusAndSource') + ','+ QuotedStr(aValue); //第二参数格式('状态|来源')
  sSQL := QuotedStr('QueryFnGreyClothByStatusAndProcessAdd') + ','+ QuotedStr(aValue); //第二参数格式('状态|加工地点')
  if QueryData(cdsQuery, rsTable, sSQL) then
    AddToLocalCDS(cdsQuery,cdsWait); //将获取的数加入到本地的待打卡CDS中
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
      localCDS.FieldByName('ID').AsString := srcCDS.FieldByName('Iden').AsString;//序号
      localCDS.FieldByName('Job_NO').AsString := srcCDS.FieldByName('Job_NO').AsString;//排单号
      localCDS.FieldByName('Machine_ID').AsString := srcCDS.FieldByName('Machine_ID').AsString;//品名号
      localCDS.FieldByName('GF_ID').AsString := srcCDS.FieldByName('GF_ID').AsString;//品名号
      localCDS.FieldByName('GF_NO').AsString := srcCDS.FieldByName('GF_NO').AsString;//品名
      localCDS.FieldByName('Fabric_No').AsString := srcCDS.FieldByName('Fabric_No').AsString;//布号
      localCDS.FieldByName('Production_Code').AsString := srcCDS.FieldByName('Production_Code').AsString;
      localCDS.FieldByName('Production_Name').AsString := srcCDS.FieldByName('Production_Name').AsString;
      localCDS.FieldByName('Status').AsString := srcCDS.FieldByName('Status').AsString;
      localCDS.FieldByName('Width').AsString := srcCDS.FieldByName('Width').AsString; //门幅
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
      destCDS.FieldByName('ID').AsString := srcCDS.FieldByName('ID').AsString;//序号
      destCDS.FieldByName('Job_NO').AsString := srcCDS.FieldByName('Job_NO').AsString;//排单号
      destCDS.FieldByName('Machine_ID').AsString := srcCDS.FieldByName('Machine_ID').AsString;//排单号
      destCDS.FieldByName('GF_ID').AsString := srcCDS.FieldByName('GF_ID').AsString;//品名号
      destCDS.FieldByName('GF_NO').AsString := srcCDS.FieldByName('GF_NO').AsString;//品名
      destCDS.FieldByName('Fabric_No').AsString := srcCDS.FieldByName('Fabric_No').AsString;//布号
      destCDS.FieldByName('Production_Code').AsString := srcCDS.FieldByName('Production_Code').AsString;
      destCDS.FieldByName('Production_Name').AsString := srcCDS.FieldByName('Production_Name').AsString;
      destCDS.FieldByName('Status').AsString := srcCDS.FieldByName('Status').AsString;
      destCDS.FieldByName('Width').AsString := srcCDS.FieldByName('Width').AsString; //门幅
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
  //TMsgDialog.ShowMsgDialog('不同工序的坯布不能打卡，请确认' ,mtConfirmation);
  MessageDlg('不同工序的坯布不能打卡，请确认', mtInformation, [mbOK], 0);
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
    MessageDlg('请填写车牌号', mtInformation, [mbOK], 0);
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
  //Delete(iden, Length(iden), 1); //删除最后的逗号

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
        //是否预览打印
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
    uShowMessage.ShowStatusMessage('正在保存数据...', crHourGlass);

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
      if MessageDlg('保存数据获取失败，是否继续尝试', mtConfirmation, [mbYes, mbNo], 0) = mrNO then
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
      if MessageDlg('保存数据获取失败，是否继续尝试', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
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
      if MessageDlg('数据保存失败，是否继续尝试保存数据', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        Exit;
    end;//if
    Result := True;
    cdsSave.Close;
    cdsPrint.EmptyDataSet;
    //edtCarNO.Text := '';
  end;//if}
end;

end.
