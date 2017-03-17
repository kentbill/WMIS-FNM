unit frmCutCloth;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmCutCloth.pas                                                 }
{       创建日期 2004-11-17 19:53:03                                           }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述                                                               }
{                                                                              }                                                                                
{       修改人员: APJ zhaogang                                                 }
{       修改日期: 2015-01-05                                                   }
{       修改原因: 首落布表(FNMDB.dbo.fnCutCloth)增加排单号字段                 }
{                                                                              }                                                                                
{       修改人员: APJ zhaogang                                                 }
{       修改日期: 2015-03-02                                                   }
{       修改原因: 首落布表(FNMDB.dbo.fnCutCloth)增加码长字段                   }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ComCtrls, ExtCtrls, Buttons, StdCtrls, cxMemo, cxDBEdit,
  cxControls, cxContainer,    
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxDBData, DBCtrls, Mask, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  DB, DBClient, cxEdit, Grids, DBGrids, Math;

type
  TCutClothForm = class(TForm)
    dsCutCloth: TDataSource;
    cdsCutCloth: TClientDataSet;
    grpCutCloth: TGroupBox;
    cxgridCutCloth: TcxGrid;
    cxgridtvCutCloth: TcxGridDBTableView;
    cxGridlCutCloth: TcxGridLevel;
    pnlTools: TPanel;
    btnAdd: TSpeedButton;
    btnDelete: TSpeedButton;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    btnRefresh: TSpeedButton;
    cdsPublic: TClientDataSet;
    cdsCutClothBak: TClientDataSet;
    edtGFKey: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtRemark: TEdit;
    Label3: TLabel;
    EdtJobNo: TEdit;
    cdsJobNo: TClientDataSet;
    Label4: TLabel;
    EdtQuantity: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure EdtQuantityKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    //查询数据
    procedure GetData;
    //新增数据
    procedure AddNew;
    //设置button状态
    procedure SetButtonStatus;
    //保存数据
    procedure SaveData;
    //删除记录
    procedure DeleteData;
    //检查品名或品名ID和排单号是否重复  //2015-01-18 APJ zhaogang ADD
    function CheckRepeat(aCDS : TClientDataSet; aGFKey, JobNo : string) : Boolean;
  public
    { Public declarations }
  end;

var
  CutClothForm: TCutClothForm;

implementation

uses ServerDllPub, UShowMessage, uLogin,
  UAppOption, UGridDecorator, uGlobal, uDictionary;

{$R *.dfm}

procedure TCutClothForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCutClothForm.FormDestroy(Sender: TObject);
begin
  CutClothForm := nil;
end;

procedure TCutClothForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCutClothForm.btnAddClick(Sender: TObject);
begin
  inherited;
  AddNew;
end;

procedure TCutClothForm.btnDeleteClick(Sender: TObject);
begin
  inherited;
  DeleteData;
end;

procedure TCutClothForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if not TGlobal.DeltaIsNull(cdsCutCloth) then
    if TMsgDialog.ShowMsgDialog('系统检测到您有数据被改动，您需要保存数据后再退出吗？', mtConfirmation, [mebYes, mebNo], mebYes)= mrYes then
      SaveData();
  CanClose := True;
end;

procedure TCutClothForm.btnSaveClick(Sender: TObject);
begin
  SaveData;
end;

procedure TCutClothForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetData();
end;

procedure TCutClothForm.GetData;
var vData: OleVariant;
  sErrorMsg: WideString;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据！请稍候...',crHourGlass) ;
    FNMServerObj.GetBaseTableInfo(vData, 'fnCutCloth', sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    cdsCutCloth.Data := vData;
    cdsCutCloth.Filtered := False;
    cdsCutCloth.Filter := 'Current_Department = '+QuotedStr(login.CurrentDepartment);
    cdsCutCloth.Filtered := True;
    cdsCutClothBak.Close;
    cdsCutClothBak.FieldDefs := cdsCutCloth.FieldDefs;
    cdsCutClothBak.FieldDefs[1].Free;
    cdsCutClothBak.CreateDataSet;
    cdsCutCloth.First;
    while not cdsCutCloth.Eof do
    begin
      cdsCutClothBak.Append;
      cdsCutClothBak['GF_ID']:= cdsCutCloth['GF_ID'];
      cdsCutClothBak['Operator'] := cdsCutCloth['Operator'];
      cdsCutClothBak['Operate_Time'] := cdsCutCloth['Operate_Time'];
      cdsCutClothBak['Current_Department'] := cdsCutCloth['Current_Department'];
      cdsCutClothBak['Is_Active'] := cdsCutCloth['Is_Active'];

      cdsCutClothBak['Job_No']:= cdsCutCloth['Job_No']; //2015-01-05 APJ zhaogang add
      cdsCutClothBak['Quantity'] := cdsCutCloth['Quantity']; //2015-03-02 APJ zhaogang add
      cdsCutCloth.Next;
    end;
    cdsCutClothBak.MergeChangeLog;
    GridDecorator.BindCxViewWithDataSource(cxgridtvCutCloth,dsCutCloth);
    SetButtonStatus;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;
end;

procedure TCutClothForm.AddNew;
var sGFKey  : string;
    sErrorMsg: WideString;
    vData: OleVariant;
    Exists: Boolean;
    //2015-01-05 APJ zhaogang add
    sJobNo : string;
    sql : WideString;
begin
  //if not InputQuery('输入','请输入品名或品名ID:',sGFKey) then Exit;
  {
  sGFKey := Trim(edtGFKey.Text);

  if TGlobal.CheckValueIsNull(sGFKey,'品名或品名ID为空，请重新输入!') then Exit;
  if TGlobal.CheckValueIsNumeric(sGFKey) then
    Exists := cdsCutCloth.Locate('GF_ID',sGFKey,[])
  else
    Exists := cdsCutCloth.Locate('GF_NO',sGFKey,[]);
  if Exists then
  begin
    TMsgDialog.ShowMsgDialog('此品名或品名ID已经存在,请重新输入!',mtWarning);
    Exit;
  end;

  FNMServerArtObj.GetCADInfo(vData,sGFKey,0,sErrorMsg);
  cdsPublic.Data := vData;
  if cdsPublic.IsEmpty() then
  begin
    TMsgDialog.ShowMsgDialog('没有找到此品名或品名ID相关信息,请重新输入!',mtWarning);
    Exit;
  end;

  //2015-01-05 APJ zhaogang add
  sJobNo := Trim(EdtJobNo.Text);
  if TGlobal.CheckValueIsNull(sJobNo, '排单号为空，请重新输入!') then
    Exit;

  if cdsCutCloth.Locate('Job_No', sJobNo, []) then
  begin
    TMsgDialog.ShowMsgDialog('此排单号已经存在,请重新输入!',mtWarning);
    Exit;
  end;//if

  sql := 'SELECT Job_No FROM PPODB.dbo.arJobMaster WHERE Job_No = ' + QuotedStr(sJobNo) + ' AND GF_ID = ' + VarToStr(cdsPublic['GF_ID']);
  FNMServerObj.GetQueryBySQL(vData, sql, sErrorMsg);
  cdsJobNo.Data := vData;
  if cdsJobNo.IsEmpty then
  begin
    TMsgDialog.ShowMsgDialog('没有找到此排单号相关信息,请重新输入!',mtWarning);
    Exit;
  end;//if
  //2015-01-05 APJ zhaogang add
  }
  //2015-01-18 APJ zhaogang Edit
  sGFKey := Trim(edtGFKey.Text);
  sJobNo := Trim(EdtJobNo.Text);
  if TGlobal.CheckValueIsNull(sGFKey,'品名或品名ID为空，请重新输入!') then
    Exit;

  if TGlobal.CheckValueIsNull(sJobNo, '排单号为空，请重新输入!') then
    Exit;

  if CheckRepeat(cdsCutCloth, sGFKey, sJobNo) then
  begin
    TMsgDialog.ShowMsgDialog('此品名/品名ID 或 排单号已经存在,请重新输入!',mtWarning);
    Exit;
  end;//if

  FNMServerArtObj.GetCADInfo(vData,sGFKey,0,sErrorMsg);
  cdsPublic.Data := vData;
  if cdsPublic.IsEmpty() then
  begin
    TMsgDialog.ShowMsgDialog('没有找到此品名或品名ID相关信息,请重新输入!',mtWarning);
    Exit;
  end;

  sql := 'SELECT Job_No FROM PPODB.dbo.arJobMaster WHERE Job_No = ' + QuotedStr(sJobNo) + ' AND GF_ID = ' + VarToStr(cdsPublic['GF_ID']);
  FNMServerObj.GetQueryBySQL(vData, sql, sErrorMsg);
  cdsJobNo.Data := vData;
  if cdsJobNo.IsEmpty then
  begin
    TMsgDialog.ShowMsgDialog('没有找到此排单号相关信息,请重新输入!',mtWarning);
    Exit;
  end;//if
  //2015-01-18 APJ zhaogang Edit


  if not cdsCutCloth.Active then Exit;
  cdsCutCloth.Append;
  cdsCutCloth['GF_ID']:= cdsPublic['GF_ID'];
  cdsCutCloth['GF_NO']:= cdsPublic['GF_NO'];
  cdsCutCloth['Remark']:= edtRemark.Text;
  cdsCutCloth['Current_Department']:= Login.CurrentDepartment;
  cdsCutCloth['Operator'] := Login.LoginName;
  cdsCutCloth['Operate_Time'] := Now;
  cdsCutCloth['Is_Active'] := True;
  cdsCutCloth['Job_NO'] := cdsJobNo['Job_No']; //2015-01-05 APJ zhaogang add
  if Trim(EdtQuantity.Text) = '' then          //2015-03-02 APJ zhaogang add
    cdsCutCloth.FieldByName('Quantity').AsFloat := 0
  else
    cdsCutCloth.FieldByName('Quantity').AsFloat := StrToFloat(EdtQuantity.Text);

  cdsCutClothBak.Append;
  cdsCutClothBak['GF_ID']:= cdsPublic['GF_ID'];
  cdsCutClothBak['Remark']:= edtRemark.Text;
  cdsCutClothBak['Current_Department']:= Login.CurrentDepartment;
  cdsCutClothBak['Operator'] := Login.LoginName;
  cdsCutClothBak['Operate_Time'] := Now;
  cdsCutClothBak['Is_Active'] := True;
  cdsCutClothBak['Job_NO'] := cdsJobNo['Job_No']; //2015-01-05 APJ zhaogang add
  cdsCutClothBak['Quantity'] := cdsCutCloth['Quantity'];//2015-03-02 APJ zhaogang add

  SetButtonStatus;
end;

procedure TCutClothForm.SaveData;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在保存数据！请稍候...', crHourGlass);
    if TGlobal.DeltaIsNull(cdsCutClothBak) then Exit;
    vData := cdsCutClothBak.Delta;
    FNMServerObj.SaveBaseTableInfo(vData, 'dbo.fnCutCloth', 'GF_ID,Current_Department', sErrorMsg);
    if sErrorMsg <> '' then
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError)
    else
    begin
      cdsCutClothBak.MergeChangeLog;
      cdsCutCloth.MergeChangeLog;
      TMsgDialog.ShowMsgDialog('数据保存成功！', mtInformation);
      GetData();
    end;
  finally
    SetButtonStatus;
    TStatusBarMessage.ShowMessageOnMainStatsusBar('');
  end;
end;

procedure TCutClothForm.DeleteData;
begin
  if (not cdsCutCloth.Active) or (cdsCutCloth.IsEmpty) then Exit;
  if TMsgDialog.ShowMsgDialog('你确认要删除该记录吗？', mtConfirmation, [mebYes, mebNo], mebYes) = mrYes then
  begin
    if cdsCutClothBak.Locate('GF_ID;Job_NO',
        VarArrayOf([cdsCutCloth.FieldByName('GF_ID').AsVariant, cdsCutCloth.FieldByName('Job_No').AsVariant]), [])then
    begin
      cdsCutCloth.Delete;
      cdsCutClothBak.Delete;
    end else
    begin
      TMsgDialog.ShowMsgDialog('无法定位指定数据，删除操作失败', mtWarning); //2015-05-25 Add
      Exit;
    end;//else
  end;//if
  SetButtonStatus;
end;

procedure TCutClothForm.SetButtonStatus;
begin
  with cdsCutCloth do
  begin
    btnAdd.Enabled := Active;
    btnDelete.Enabled := not IsEmpty();
    btnSave.Enabled := not TGlobal.DeltaIsNull(cdsCutCloth);
  end
end;

function TCutClothForm.CheckRepeat(aCDS : TClientDataSet; aGFKey, JobNo: string): Boolean;
var
  oldFilterStr, filterStr : string;
  gfid : Integer;
begin
  Result := False;
  try
    aCDS.DisableControls;
    oldFilterStr := aCDS.Filter;

    if TryStrToInt(aGFKey, gfid) then
      filterStr := 'GF_ID = ' + aGFKey + ' and Job_No = '  + QuotedStr(JobNo)
    else
      filterStr := 'GF_NO = ' + QuotedStr(aGFKey) + ' and Job_No = '  + QuotedStr(JobNo);

    if filterStr <> '' then
      aCDS.Filter := oldFilterStr + ' and ' + filterStr
    else
      aCDS.Filter := filterStr;
    aCDS.Filtered := True;

    Result := (aCDS.RecordCount > 0);
  finally
    aCDS.Filtered := False;
    aCDS.Filter := oldFilterStr;
    aCDS.Filtered := True;
    aCDS.EnableControls;
  end;//finally
end;

procedure TCutClothForm.EdtQuantityKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

end.

