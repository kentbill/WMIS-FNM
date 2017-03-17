{******************************************************************************
       软件名称 WMIS ——FNM
       文件名称 frmProductionList
       版权所有 (C) 2013 ESQUEL GROUP GET/IT
       创建日期 2013-11-18
       创建人员 APJ zhaogang  爱普京——赵港
       修改人员
       修改日期
       修改原因
       对应用例
       数据库
            表：
              FNMDB.dbo.fnProductionList
            相关表：
              FNMDB.dbo.fnProductionParameter
       调用重要函数/SQL对象说明
            存储过程
              FNMDB.dbo.usp_fnProductionListData
******************************************************************************}

unit frmProductionList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxSplitter, Grids, ExtCtrls, StdCtrls, CheckLst,
  frmBase, DB, DBClient, frmMain, DBGrids, Buttons;

const
  rsTable = 'fnProductionList'; //所查表
  division = '-';//分隔符

type
  TStateType = (isInit, isBrowse, isAdd, isUpdate, isDel, isSave, isCancel); //初始化，浏览, 新增，修改，删除，保存，取消

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
    //数据操作
    GIden : string;                                                             //记录所选数据Iden值，用于取消时使用
    GDelIden : String;                                                          //记录删除数据Iden值
    GIndex : TStringList;                                                       //记录勾选工序索引值
    GOldProCode : string;                                                       //保存旧的工序代号(Production_Code)值，用于修改时检查唯一性
    //数据库
    procedure QueryData(sourceCDS: TClientDataSet;const aType : String; aSQL: WideString); //通用查询数据方法
    //procedure QueryFnOperationHdrListData;                                    //查询fnOperationHdrList数据
    procedure GetFnProductionParameterData;                                     //查询fnProductionParameter数据
    procedure GetFnProductionListData;                                          //获取fnProductionList数据
    procedure GetGetCheckUniqueData;                                            //检查Production_Code唯一性
    function SaveToDB(aData : OleVariant) : Boolean;                            //保存数据到 fnProductionList 表
    function DeleteFnProductionListData(Idens : String) : Boolean;              //删除指定Iden的数据
      //本地
    procedure SetProNameAndProCode(aValue : String);                            //将勾选数据添加edtProName和edtProCode
    procedure Add;                                                              //新增方法
    procedure Edit;                                                             //修改方法
    procedure Delete;                                                           //删除方法
    procedure Save;                                                             //保存方法
    procedure Cancel;                                                           //取消方法
    procedure SaveToCDS;                                                        //将数据保存到本地ClientDataSet
    function CheckUnique(aValue : String; expect : Integer) : Boolean;          //本地检查Production_Code唯一性, True为确认为唯一值

    //窗体控制
    procedure initialise;                                                       //初始化窗体设置
    procedure CleanText;                                                        //清空Edit、StringGrid
    procedure CleanCheckLB;                                                     //清空CheckListBoxt
    function CheckNull : Boolean;                                               //检查空值，用于保存前
    procedure FullFnOperationHdrData;                                           //填充FnOperationHdr数据到CheckBoxList
    procedure OperationSelection(index : Integer);                              //工序选择方法，按勾选的顺序加到文本框中
    procedure ControlEnabled(aEnabled : Boolean);                               //控件控制方法
    procedure ShowDataToEdit;                                                   //将数据显示到编辑框中
    procedure CentraleControl(aState : TStateType);                             //集中控制方法，主要控制不同编辑状态下的按钮状态
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
     if MessageDlg('提示: 数据已修改, 尚未保存, 是否继续退出操作?', mtConfirmation, [mbYes, mbNo],0) = mrNo then
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
    uShowMessage.ShowStatusMessage('正在查询稍等！', crHourGlass);

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
    MessageDlg('工序数据有空值，请填写完整数据后再保存', mtWarning, [mbOK], 0);
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
    uShowMessage.ShowStatusMessage('正在保存数据...', crHourGlass);

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
  cdsfnProductionList.Append;//新增状态
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
  expect : Integer; //期望值，用于新增时防止录入重复工序和允许修改已存在值
begin
  //判断CDS状态，如在编辑状态则检查工序号是否重复
  if cdsfnProductionList.State in [dsEdit, dsInsert] then
  begin

    if not CheckNull then
      Exit;

    expect := 0; //新增，该数据应还未有，所以期望值为0
    if cdsfnProductionList.State in [dsEdit] then
    begin
      if GOldProCode = edtProCode.Text then //比较修改前、后值，防止修改破坏唯一性
        expect := 1; //修改，该数据已有，所以期望值为1
    end;//if

    if not CheckUnique(edtProCode.Text, expect) then
    begin
      MessageDlg('工序代号[' + edtProCode.Text + ']已存在，请重新组织工序', mtInformation, [mbOK], 0);
      Exit;
    end;//if
  end;

  SaveToCDS;
  if cdsfnProductionList.ChangeCount > 0 then
  begin
    if not SaveToDB(cdsfnProductionList.Delta) then
    begin
      if MessageDlg('数据保存失败，是否继续尝试保存数据', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        Exit;
    end;//if
    GetFnProductionListData; //重新获取数据
  end;//if

  //删除数据
  if Length(Trim(GDelIden)) > 0 then
  begin
    if DeleteFnProductionListData(GDelIden) then
    begin
      cdsfnProductionList.MergeChangeLog;
      GDelIden := '';
    end;//if
  end;//if

  GetGetCheckUniqueData;//重新获取唯一性检查数据
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
    uShowMessage.ShowStatusMessage('正在删除稍等...', crHourGlass);
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
  //expect 数据期望数量，新增数据量应为 0 ，修改应为 1
  //True为确认为唯一值
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
  
  if chklstOperationHdr.Checked[index] then //如果勾选上，则将索引值加到列表中，如果没有去掉该索引值
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

  for i := 0 to GIndex.Count - 1 do //循环列表，再根据新索引将相关值加到文本框中
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
      btnAdd.Enabled := True;         //新增按钮
      btnUpdate.Enabled := True;      //修改按钮
      btnDelete.Enabled := True;      //删除按钮
      btnSave.Enabled := False;       //保存按钮
      btnCancel.Enabled := False;     //取消按钮
      btnClose.Enabled := True;       //退出按钮
      pnlEdit.Enabled := False;       //信息维护栏
      dbgrdPL.Enabled := True;        //网格
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
