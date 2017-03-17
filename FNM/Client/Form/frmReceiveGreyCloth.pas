{******************************************************************************
       软件名称 WMIS ——FNM
       文件名称 frmReceiveGreyCloth
       版权所有 (C) 2013 ESQUEL GROUP GET/IT
       创建日期 2013-12-03
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
unit frmReceiveGreyCloth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, cxControls, cxSplitter, ExtCtrls, DB,
  DBClient, Grids, DBGrids, frmBase;

const
  rsTable = 'fnGreyCloth';      //所查表
  rsStatus = '已送布';          //需查询状态值
  rsSaveStatus = '待打卡';      //新状态值
  rsFormat = 'yyyy-MM-dd HH:mm';//日期格式
  division = '|';               //分隔符
  
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
    GSrcList : TStringList;                                                     //记录源数据Iden   用于TransferValueForListBox方法 保存ID加布号 格式: 1|I00001
    GDestList : TStringList;                                                    //记录目标数据Iden 用于TransferValueForListBox方法 保存ID加布号 格式: 1|I000
    //数据操作
      //数据库
    function QueryData(aCDS: TClientDataSet; const aType : String; aSQL: WideString) : Boolean;//通用查询数据方法
    procedure QueryFnGreyClothData(aValue : String);                            //根据来源查询fnGreyCloth表待送布数据
    procedure GetFnGreyClothNullData(aCDS: TClientDataSet);                     //获取fnGreyCloth表空数据集
    function UpdateToDB(aValue : String) : Boolean;                             //更新数据库指定数据
    function SaveToDB(aData : OleVariant) : Boolean;                            //保存数据到 fnGreyCloth 表
      //本地
    procedure SaveToCDS(aIden : String);                                        //保存到本地cdsFnGreyCloth
    procedure DeleteFromCDS(aIden : String);//(aFabricNo : String);             //删除本地cdsFnGreyCloth中的指定数据
    procedure Save;                                                             //保存方法

      //窗体控制
    procedure Initialise;                                                       //初始化方法
    procedure CleanText;                                                        //清空文本框(ComboBox, ListBox)
    procedure CleanList;                                                        //清空TStringList
    procedure ReadOnlyKeyPress(Sender: TObject; var Key: Char);                 //ComboBox 只读 KeyPress 事件
    procedure FullCommboBox(aCDS : TClientDataSet; aField : String; aCBB : TComboBox);//填充CommboBox
    procedure FullListBox(aCDS : TClientDataSet; aField1, aField2, aField3 : String; aLst : TListBox);//填充ListBox方法
    procedure TransferValueForListBox(src, dest : TListBox; srcList, destList : TStringList; index : Integer);//移动源ListBox中的值到指定ListBox中
    procedure MoveDown(srcLs, destLs : TListBox; srcList, destList : TStringList); //下移方法
    procedure MoveDownAll(srcLs, destLs : TListBox; srcList, destList : TStringList);//全下移方法
    procedure MoveUp(srcLs, destLs : TListBox; srcList, destList : TStringList);   //上移方法
    procedure MoveUpAll(srcLs, destLs : TListBox; srcList, destList : TStringList);//全上移方法
    procedure Refresh;                                                          //刷新
    function Decompose(aValue : String; aDiv : string) : String;                //根据特定分隔符分隔字段，获取前部分
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
    ShowMsg('正在查询稍等！', crHourGlass);
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
  //sSQL := QuotedStr('QueryFnGreyClothByStatusAndSource') + ','+ QuotedStr(aValue); //第二参数格式('状态|来源')
  sSQL := QuotedStr('QueryFnGreyClothByStatusAndProcessAdd') + ','+ QuotedStr(aValue); //第二参数格式('状态|加工地点')
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
    cdsFnGreyCloth.FieldByName('Width').AsString := cdsQuery.FieldByName('Width').AsString;//门幅
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
    if not QueryData(cdsSource, rsTable, sSQL) then      //借用闲置的cdsSource
      if MessageDlg('保存数据获取失败，是否继续尝试', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
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
      if MessageDlg('数据保存失败，是否继续尝试保存数据', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        Exit;
    end;//if

    cdsSource.Close;
    cdsFnGreyCloth.EmptyDataSet; //清除修改记录
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
      cdsFnGreyCloth.EmptyDataSet; //清除修改记录
      cdsQuery.MergeChangeLog;
      lstWaitFabricNo.Items.Clear;
      GDestList.Clear;
    end
    else
    begin
      if MessageDlg('数据保存失败，是否继续尝试保存数据', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
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
   if MessageDlg('提示: 数据已修改, 尚未保存, 是否继续退出操作?', mtConfirmation, [mbYes, mbNo],0) = mrNo then
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
  QueryFnGreyClothData(rsStatus + division + Login.CurrentDepartment);//根据[待送布]状态与用户当前部门获取数据
  GetFnGreyClothNullData(cdsFnGreyCloth);     //获取空数据集
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
    GSrcList.Clear;//清空TStringList

    aLst.Items.Clear;
    aCDS.First;
    while not aCDS.Eof do
    begin
      GSrcList.Add(aCDS.FieldByName('Iden').AsString);// + division + aCDS.FieldByName('Fabric_No').AsString);//将Iden加入TStringList

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
    //SaveToCDS(Decompose(destList.Strings[destList.Count - 1], division));//根据目标StringList最后的数据来查
    SaveToCDS(destList.Strings[destList.Count - 1]);
  end;//if
end;

procedure TReceiveGreyClothForm.MoveDownAll(srcLs, destLs : TListBox; srcList, destList : TStringList);
begin

  while(srcLs.Count > 0) do
  begin
    TransferValueForListBox(srcLs, destLs, srcList, destList, 0);
    //SaveToCDS(Decompose(destList.Strings[destList.Count - 1], division));//根据目标StringList最后的数据来查
    SaveToCDS(destList.Strings[destList.Count - 1]);
  end;//while
end;

procedure TReceiveGreyClothForm.MoveUp(srcLs, destLs : TListBox; srcList, destList : TStringList);
begin
  {if lstWaitFabricNo.ItemIndex > -1 then
  begin
    TransferValueForListBox(lstWaitFabricNo, lstFabricNo, GDestList, GSrcList, lstWaitFabricNo.ItemIndex);
    DeleteFromCDS(Decompose(GSrcList.Strings[GSrcList.count - 1], division));//根据源StringList最后的数据来查
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
    DeleteFromCDS(Decompose(GSrcList.Strings[GSrcList.count - 1], division));//根据源StringList最后的数据来查
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

end.
