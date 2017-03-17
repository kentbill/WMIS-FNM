{******************************************************************************

       软件名称 WMIS ——FNM
       文件名称 frmReturnGreyCloth
       版权所有 (C) 2013 ESQUEL GROUP GET/IT
       创建日期 2013-12-06
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
            QCMDB.dbo.qiEmailItemList
          存储过程：
            QCMDB.dbo.usp_fnGreyClothData

******************************************************************************}          
unit frmReturnGreyCloth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxSplitter, ExtCtrls, StdCtrls, Buttons, Grids,
  DBGrids, DB, DBClient, frmBase;

const
  rsTable = 'fnGreyCloth';      //所查表
  rsStatus = '加工中';          //需查询状态值
  rsSaveStatus = '加工完成';    //新状态值
  rsFormat = 'yyyy-MM-dd HH:mm';//日期格式
  division = '|';               //分隔符

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
    GSrcList : TStringList;                                                     //记录源数据Iden组  格式：1，2，3，4
    GDestList : TStringList;                                                    //记录目标数据Iden组  格式：1，2，3，4
    //数据操作
      //数据库
    function QueryData(aCDS: TClientDataSet; const aType : String; aSQL: WideString) : Boolean;//通用查询数据方法
    procedure QueryFnGreyClothData(aValue : String);                            //根据来源查询fnGreyCloth表待送布数据
    procedure GetFnGreyClothNullData(aCDS: TClientDataSet);                     //获取fnGreyCloth表空数据集
    procedure ExecSendEmail(Idens: String);                                     //发送邮件方法
    function SavaToDB(aData : OleVariant) : Boolean;                            //更新数据库指定数据
      //本地
    procedure SaveToCDS(Idens : String);                                        //保存到本地cdsFnGreyCloth
    procedure DeleteFromCDS(Idens : String);                                    //删除本地cdsFnGreyCloth中的指定数据
    procedure Save;                                                             //保存方法
    procedure Refresh;                                                            //查询方法
      //窗体控制
    procedure Initialise;                                                       //初始化方法
    procedure CleanText;                                                        //清空文本框(ComboBox, ListBox)
    procedure CleanList;                                                        //清空TStringList
    procedure FullListBox(aCDS : TClientDataSet; aField : String; aLst : TListBox);//填充ListBox方法

    procedure TransferValueForListBox(src, dest : TListBox; srcList, destList : TStringList; index : Integer);//移动源ListBox中的值到指定ListBox中
    procedure MoveDown(srcLs, destLs : TListBox; srcList, destList : TStringList); //下移方法
    procedure MoveDownAll(srcLs, destLs : TListBox; srcList, destList : TStringList);//全下移方法
    procedure MoveUp(srcLs, destLs : TListBox; srcList, destList : TStringList);   //上移方法
    procedure MoveUpAll(srcLs, destLs : TListBox; srcList, destList : TStringList);//全上移方法
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
   if MessageDlg('提示: 数据已修改, 尚未保存, 是否继续退出操作?', mtConfirmation, [mbYes, mbNo],0) = mrNo then
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

procedure TReturnGreyClothForm.QueryFnGreyClothData(aValue: String);
var
  sSQL : String;
begin
  //sSQL := QuotedStr('QueryFnGreyClothByStatus') + ','+ QuotedStr(aValue);
  //sSQL := QuotedStr('QueryFnGreyClothByStatusAndProcessAdd')+ ','+ QuotedStr(aValue); //2014-01-07 APJ zhaogang注销
  sSQL := QuotedStr('QueryFnGreyClothByStatusAndProcessAddOfStepNO')+ ','+ QuotedStr(aValue);  //2014-01-07 APJ zhaogang
  if QueryData(cdsQuery, rsTable, sSQL) then
  begin
    cdsQuery.IndexFieldNames := 'FN_CARD'; //本地排序
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

  QueryFnGreyClothData(rsStatus + division + Login.CurrentDepartment); //获取查询数据
  GetFnGreyClothNullData(cdsFnGreyCloth);                              //获取空的数据集
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
  idens : string;  //累加Iden值
  fnCard : string; //记录前一位的卡号值，用于比较与条件成立时赋值
begin
  if (aCDS.Active) and (aCDS.RecordCount > 0) and (aField <> '')then
  begin
    GSrcList.Clear;//清空TStringList

    aLst.Items.Clear;
    aCDS.First;
    fnCard := aCDS.FieldByName('FN_CARD').AsString;
    while not aCDS.Eof do
    begin
      idens := idens + aCDS.FieldByName('Iden').AsString + ',';
      aCDS.Next;

      if(fnCard <> aCDS.FieldByName('FN_CARD').AsString)then //如果前一个卡号与当前不一致，则将前一位卡号与Iden累加值保存
      begin
        Delete(idens, Length(idens), 1);  //删除最后的逗号
        //GSrcList.Add(fnCard + division + idens);//SrcList保存的是 卡号和Iden组，即：（Q20131200001|1，2，3，4）
        GSrcList.Add(idens);
        aLst.Items.Add(fnCard);
        idens := '';
        fnCard := aCDS.FieldByName('FN_CARD').AsString;
      end;//if
    end;//while

    Delete(idens, Length(idens), 1);
    //GSrcList.Add(fnCard + division + idens);//SrcList保存的是 卡号和Iden组，即：（Q20131200001|1，2，3，4
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
    //SaveToCDS(Decompose(destList.Strings[destList.Count - 1], division));//根据目标StringList最后的数据来查
    SaveToCDS(destList.Strings[destList.Count - 1]);
  end;//if
end;

procedure TReturnGreyClothForm.MoveDownAll(srcLs, destLs: TListBox;
  srcList, destList: TStringList);
begin
  while(srcLs.Count > 0) do
  begin
    TransferValueForListBox(srcLs, destLs, srcList, destList, 0);
    //SaveToCDS(Decompose(destList.Strings[destList.Count - 1], division));//根据目标StringList最后的数据来查
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
      if MessageDlg('保存数据获取失败，是否继续尝试', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
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
      if MessageDlg('数据保存失败，是否继续尝试保存数据', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
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
