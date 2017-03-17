{******************************************************************************
       软件名称 WMIS ——FNM
       文件名称 frmProductionParameter
       版权所有 (C) 2013 ESQUEL GROUP GET/IT
       创建日期 2013-11-18
       创建人员 APJ zhaogang  爱普京——赵港
       修改人员
       修改日期
       修改原因
       对应用例
       数据库
            表：
              FNMDB.dbo.fnProductionParameter
            相关表:
              FNMDB.dbo.fnoperationHdrlist
       调用重要函数/SQL对象说明
            存储过程
              FNMDB.dbo.usp_fnProductionParameterData
******************************************************************************}
{
界面操流程
新增
  新增按钮 ——网格、修改，删除失效, 保存、取消有效 ——维护信息栏可填 ——(如需继续新增则重复以上步骤） ——保存按钮 ——保存到数据库

修改
  选择数据 ——修改按钮 ——网格、新增，删除失效, 保存、取消有效 ——维护信息栏可填 ——保存按钮 ——保存到数据库

删除
  选择数据 —— 删除按钮 —— 保存、取消有效 ——保存按钮 ——保存到数据库
}

unit frmProductionParameter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxSplitter, StdCtrls, ExtCtrls, Grids, DBGrids, DB,
  DBClient, DBCtrls, frmBase, Buttons;

const
  rsTable = 'fnProductionParameter'; //所查表

type
  TStateType = (isInit, isBrowse, isAdd, isUpdate, isDel, isSave, isCancel); //初始化，浏览, 新增，修改，删除，保存，取消 

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
    //数据操作
    GIden : string;                                                             //记录所选数据Iden值，用于取消时使用
    GDelIden : String;                                                          //记录删除数据Iden值
      //数据库
    procedure QueryData(sourceCDS: TClientDataSet;const aType : String; aSQL: WideString); //通用查询数据方法
    procedure GetFnProductionParameterData;                                     //获取fnProductionParameter表的所有数据
    procedure QueryFnOperationHdrListData;                                      //查询FnProductionList数据
    procedure QueryFnProductionParameterData(aCode : String);                   //根据工序编号查询数据
    function SaveToDB(aData : OleVariant) : Boolean;                            //保存到数据库
    function DeleteFnProductionParameterData(Idens : String) : Boolean;         //删除指定Iden的数据

      //本地
    function FilterForFnOperationHdrList(aField, aWhere : String) : String;     //本地fnOperationHdrList数据过滤方法
    procedure Add;                                                              //新增方法
    procedure Edit;                                                             //编辑方法
    procedure Delete;                                                           //删除方法
    procedure Cancel;                                                           //取消方法
    procedure Save;                                                             //保存方法
    procedure SavaToCDS;                                                        //保存到本地ClientDataSet

    //窗体控制
    procedure Initialise;                                                       //初始化窗体设置
    procedure Clean;                                                            //清空ComboBox、Memo、Edit
    procedure CleanText;                                                        //清空各编辑框Text中的内容
    procedure FullCommboBox;                                                    //填充CommboBox ——cbbOpeCode 和 cbbOpeName
    procedure ControlEnabled;                                                   //控制控件Enabled值
    procedure MyComboBoxKeyPress(Sender: TObject;var Key: Char);                //公共ComboBox的KeyPress事件，用于设置ComboBox为只读
    function CheckNull : Boolean;                                               //非空检查
    procedure ShowDataToEdit;                                                   //将数据显示到编辑框中
    procedure CentraleControl(aState : TStateType);                             //集中控制方法，主要控制不同编辑状态下的按钮状态
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
     if MessageDlg('提示: 数据已修改, 尚未保存, 是否继续退出操作?', mtConfirmation, [mbYes, mbNo],0) = mrNo then
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
  cbbOpeCode.Enabled := False;//工序编号不允许修改
  cbbOpeName.Enabled := False;//工序名称不允许修改

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
    uShowMessage.ShowStatusMessage('正在保存数据...', crHourGlass);
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
  if cdsFnProductionParameter.State in [dsEdit, dsInsert] then //只有grpTop在可编辑状态才会执行过滤
    cbbOpeCode.Text := FilterForFnOperationHdrList('Operation_code','Operation_CHN = ' + QuotedStr(TComboBox(Sender).Text));
end;

procedure TProductionParameterForm.cbbOpeCodeChange(Sender: TObject);
begin
  inherited;
  if cdsFnProductionParameter.State in [dsEdit, dsInsert] then //只有grpTop在可编辑状态才会执行过滤
    cbbOpeName.Text := FilterForFnOperationHdrList('Operation_CHN','Operation_code = ' + QuotedStr(TComboBox(Sender).Text));
end;

procedure TProductionParameterForm.MyComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  //Key := #0;
end;

procedure TProductionParameterForm.Add;
begin
    {btnAdd.Enabled := false; //修改按钮
    btnUpdate.Enabled := false; //修改按钮
    btnDel.Enabled := false;   //删除按钮
    dbgrdPP.Enabled := false;  //网格

    grpTop.Enabled := True;    //信息维护框
    cbbOpeCode.Enabled := True;//工序编号
    cbbOpeName.Enabled := True;//工序名称

    btnSave.Enabled := true;   //保存按钮
    btnCancel.Enabled := true;  //取消按钮
    pnlTop.Enabled := False; //查询栏
    }
    CentraleControl(isAdd);

    {if CheckNull then
    begin
      SavaToCDS;}
      GIden := cdsFnProductionParameter.FieldByName('Iden').AsString; //记录当前位置
      
      cdsFnProductionParameter.Append;//设置CDS状态为新增
      CleanText;
      cbbOpeCode.SetFocus;
    //end;//if
end;

procedure TProductionParameterForm.Edit;
begin
  {btnAdd.Enabled := false;    //新增按钮
  btnUpdate.Enabled := false; //修改按钮
  btnDel.Enabled := false;   //删除按钮
  dbgrdPP.Enabled := false;  //网格

  grpTop.Enabled := True;    //信息维护框
  cbbOpeCode.Enabled := False;//工序编号不允许修改
  cbbOpeName.Enabled := False;//工序名称不允许修改

  btnSave.Enabled := true;   //保存按钮
  btnCancel.Enabled := true;  //取消按钮
  pnlTop.Enabled := False; //查询栏
  }
  CentraleControl(isUpdate);

  GIden := cdsFnProductionParameter.FieldByName('Iden').AsString; //记录当前位置
  cdsFnProductionParameter.Edit;//设置CDS状态为修改
  mmoOpeDes.SetFocus;

  {if CheckNull then
  begin
    SavaToCDS;
    cdsFnProductionParameter.Edit;//设置CDS状态为修改
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

      //btnSave.Enabled := true;   //保存按钮
      //btnCancel.Enabled := False;  //取消按钮
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
    uShowMessage.ShowStatusMessage('正在删除稍等...', crHourGlass);
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
      MessageDlg('工序数据有空值，请填写完整数据后再保存', mtWarning, [mbOK], 0);
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
      if MessageDlg('数据保存失败，是否继续尝试保存数据', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        Exit;
    end;//if
    
    GetFnProductionParameterData; //重新获取数据
    //cdsFnProductionParameter.Last;
    {
    grpTop.Enabled := False; //编辑栏
    dbgrdPP.Enabled := True; //网格
    pnlTop.Enabled := True; //查询栏

    for i := 0 to pnlRight.ControlCount - 1 do
      TButton(pnlRight.Controls[i]).Enabled := true;}
      
    
  end;//if

  //删除数据
  if Length(Trim(GDelIden)) > 0 then
  begin
    if DeleteFnProductionParameterData(GDelIden) then
    begin
      cdsFnProductionParameter.MergeChangeLog;
      GDelIden := '';
    end;//if
  end;//if

  //btnSave.Enabled := False;   //保存按钮
  //btnCancel.Enabled := False;  //取消按钮

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
 { btnAdd.Enabled := True;    //新增按钮
  btnUpdate.Enabled := True; //修改按钮
  btnDel.Enabled := True;   //删除按钮
  dbgrdPP.Enabled := True;  //网格
  grpTop.Enabled := False;    //信息维护框
  btnSave.Enabled := False;   //保存按钮
  btnCancel.Enabled := False;  //取消按钮 }

  GDelIden := ''; //清空删除ID记录

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
      cbbOpeCode.Enabled := False;//工序编号
      cbbOpeName.Enabled := False;//工序名称

      btnAdd.Enabled := True;     //新增按钮
      btnUpdate.Enabled := True;  //修改按钮
      btnDel.Enabled := True;     //删除按钮
      btnSave.Enabled := False;   //保存按钮
      btnCancel.Enabled := False; //取消按钮
      btnClose.Enabled := True;   //退出按钮

      grpTop.Enabled := False;    //信息维护栏
      pnlTop.Enabled := True;     //查询栏
      dbgrdPP.Enabled := True;    //网格
    end;
    isBrowse:
    begin

    end;
    isAdd:
    begin
      cbbOpeCode.Enabled := True;//工序编号
      cbbOpeName.Enabled := True;//工序名称

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
      cbbOpeCode.Enabled := False;//工序编号
      cbbOpeName.Enabled := False;//工序名称

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
      cbbOpeCode.Enabled := False;//工序编号
      cbbOpeName.Enabled := False;//工序名称
      
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
