{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmWorker.pas                                                 }
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
{******************************************************************************}
unit frmWorker;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ComCtrls, ExtCtrls, Buttons,StdCtrls, cxMemo, cxDBEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxCheckBox, cxSplitter,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxDBData, DBCtrls, Mask, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  DB, DBClient, cxDBLookupComboBox, ADODB;

type
  TWorkerForm = class(TBaseForm)
    pgcDic: TPageControl;
    pnlTool: TPanel;
    tsCommon: TTabSheet;
    tsLocation: TTabSheet;
    grpWorker: TGroupBox;
    grpWorkerInfo: TGroupBox;
    pnlTools: TPanel;
    cxspl1: TcxSplitter;
    btnAdd: TSpeedButton;
    btnModify: TSpeedButton;
    btnDelete: TSpeedButton;
    btnUndo: TSpeedButton;
    btnExport: TSpeedButton;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    btnRefresh: TSpeedButton;
    grpWorkerGroup: TGroupBox;
    grpWorkerGroupInfo: TGroupBox;
    lbl3: TLabel;
    cxgridWorker: TcxGrid;
    cxgridtvWorker: TcxGridDBTableView;
    cxgdbcWorkerWorker_ID1: TcxGridDBColumn;
    cxgdbcWorkerWorker_Name1: TcxGridDBColumn;
    cxgdbcWorkerWorker_Group1: TcxGridDBColumn;
    cxgdbcWorkerDepartment1: TcxGridDBColumn;
    cxgdbcWorkerIs_Active1: TcxGridDBColumn;
    cxGridlWorker: TcxGridLevel;
    cxgridworkerGroup: TcxGrid;
    cxgridtvWorkerGroup: TcxGridDBTableView;
    cxgdbcWorkerGroupIden1: TcxGridDBColumn;
    cxgdbcWorkerGroupWorker_Group1: TcxGridDBColumn;
    cxgdbcWorkerGroupDBColumn1: TcxGridDBColumn;
    cxgdbcWorkerGroupDescription1: TcxGridDBColumn;
    cxgdbcWorkerGroupIs_Active1: TcxGridDBColumn;
    cxGridlWorkerGroup: TcxGridLevel;
    lbl8: TLabel;
    dbedtWorkerGroup: TDBEdit;
    dbmmoDescription: TDBMemo;
    lbl5: TLabel;
    dblkcbb1: TDBLookupComboBox;
    dbchkIsActive: TDBCheckBox;
    cxspl2: TcxSplitter;
    dsWorker: TDataSource;
    dsWorkerGroup: TDataSource;
    dsDepartment: TDataSource;
    lbl1: TLabel;
    dbedtWorker_ID: TDBEdit;
    lbl2: TLabel;
    dbedtWorker_Name: TDBEdit;
    lbl4: TLabel;
    lbl6: TLabel;
    dblkcbbDepartment: TDBLookupComboBox;
    dbchk1: TDBCheckBox;
    dblkcbbWorkerGroup: TDBLookupComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnModifyClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnUndoClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure grpWorkerGroupInfoExit(Sender: TObject);
    procedure grpWorkerInfoExit(Sender: TObject);
    procedure pnlToolsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private

    //查询数据
    procedure GetData;
    //新增数据
    procedure AddNew;
    //设置输入框状态
    procedure SetPanelStatus(Enable:Boolean);
    //设置button状态
    procedure SetButtonStatus;
    //进入修改状态
    procedure Modify;
    //保存数据
    procedure SaveData;
    //删除记录
    procedure DeleteData;
    //导出记录
    procedure ExportData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WorkerForm: TWorkerForm;

implementation

uses ServerDllPub, UShowMessage,uLogin,
  UAppOption, UGridDecorator,uGlobal,uDictionary;

{$R *.dfm}
 
procedure TWorkerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TWorkerForm.FormDestroy(Sender: TObject);
begin
  WorkerForm:=nil;
end;


procedure TWorkerForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TWorkerForm.btnModifyClick(Sender: TObject);
begin
  Modify;
end;

procedure TWorkerForm.btnSaveClick(Sender: TObject);
begin
  SaveData;
end;

procedure TWorkerForm.GetData;
//var FilterStr: string;
begin
 // FilterStr := 'Department='+QuotedStr(Login.CurrentDepartment);
 // TGlobal.FilterData(Dictionary.cds_WorkerList,FilterStr);
  dsWorker.DataSet:=Dictionary.cds_WorkerList;
 // TGlobal.FilterData(Dictionary.cds_WorkerGroupList,FilterStr);
  dsWorkerGroup.DataSet:= Dictionary.cds_WorkerGroupList;
  dsDepartment.DataSet := Dictionary.cds_DepartmentList;
  //设置BUTTON的状态
  SetPanelStatus(False);
  SetButtonStatus;
end;

procedure TWorkerForm.AddNew;
begin
  case pgcDic.ActivePageIndex of
    0:
    begin
      with Dictionary.cds_WorkerList do
      begin
        if not Active then Exit;
        Append;
        FieldByName('Password').AsString := '0';
        FieldByName('Class').AsString := 'A';
        FieldByName('Department').AsString := Login.CurrentDepartment;
      end;
    end;
    1:
    begin
      with Dictionary.cds_WorkerGroupList do
      begin
        if not Active then Exit;
        Append;
        FieldByName('Department').AsString := Login.CurrentDepartment;
      end;
    end;
  end;
  SetPanelStatus(True);
  SetButtonStatus;
end;

procedure TWorkerForm.btnAddClick(Sender: TObject);
begin
  inherited;
  AddNew;
end;

procedure TWorkerForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  {case pgcDic.ActivePageIndex of
    0: canClose:=TShare.CloseQuery(handle,cdsCommon);
    1: canClose:=TShare.CloseQuery(handle,cdsLocation);
  end;
  }
end;

procedure TWorkerForm.btnUndoClick(Sender: TObject);
begin
  inherited;
  if pgcDic.ActivePageIndex=0 then
    Dictionary.cds_WorkerList.CancelUpdates
  else if pgcDic.ActivePageIndex=1 then
    Dictionary.cds_WorkerGroupList.CancelUpdates;
  SetButtonStatus;
end;

procedure TWorkerForm.SetPanelStatus(Enable:Boolean);
var i:integer;
begin
  case pgcDic.ActivePageIndex of
    0:
      begin
        for i:=0 to grpWorkerInfo.ControlCount-1 do
          grpWorkerInfo.Controls[i].Enabled:=Enable;
      end;
    1:
      begin
        for i:=0 to grpWorkerGroupInfo.ControlCount-1 do
          grpWorkerGroupInfo.Controls[i].Enabled:=Enable;
      end;
  end;
end;

procedure TWorkerForm.Modify;
begin
  case pgcDic.ActivePageIndex of
    0:
      begin
        if not Dictionary.cds_WorkerList.Active then exit;
         Dictionary.cds_WorkerList.Edit;
      end;
    1:
      begin
        if not Dictionary.cds_WorkerGroupList.Active then exit;
        Dictionary.cds_WorkerGroupList.Edit;
      end;
  end;
  SetPanelStatus(True);
end;

procedure TWorkerForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetData();
end;

procedure TWorkerForm.SaveData;
var
  vData:OleVariant;
  sErrorMsg:WideString;
begin
  try
    ShowMsg('正在保存数据！请稍候...',crHourGlass) ;
    case pgcDic.ActivePageIndex of
    0:
      begin
        if Dictionary.cds_WorkerList.ChangeCount =0 then Exit;
        vData:=Dictionary.cds_WorkerList.Delta;
        FNMServerObj.SaveBaseTableInfo(vData, 'PUBDB.dbo.pbWorkerList', 'Iden', sErrorMsg);
        Dictionary.cds_WorkerList.MergeChangeLog;
      end;
    1:
      begin
        if Dictionary.cds_WorkerGroupList.ChangeCount =0 then Exit;
        vData:=Dictionary.cds_WorkerGroupList.Delta;
        FNMServerObj.SaveBaseTableInfo(vData, 'PUBDB.dbo.pbWorkerGroupList', 'Worker_Group', sErrorMsg);
        Dictionary.cds_WorkerGroupList.MergeChangeLog;
      end;
    end;
    if sErrorMsg<>'' then
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError)
    else
    begin
      TMsgDialog.ShowMsgDialog('数据保存成功！',mtInformation);
      GetData();
      setpanelstatus(false);
    end;
  finally
    SetButtonStatus;
    ShowMsg('') ;
  end;
end;

procedure TWorkerForm.btnDeleteClick(Sender: TObject);
begin
  inherited;
  DeleteData; 
end;

procedure TWorkerForm.DeleteData;
begin
  case pgcDic.ActivePageIndex of
    0:
      begin
        if (not Dictionary.cds_WorkerList.Active) or (Dictionary.cds_WorkerList.IsEmpty) then Exit;
        if TMsgDialog.ShowMsgDialog('你确认要删除该记录吗？',mtConfirmation,[mebYes,mebNo],mebYes)=mrYes then
          Dictionary.cds_WorkerList.Delete;
      end;
    1:
      begin
        if (not Dictionary.cds_WorkerGroupList.Active) or (Dictionary.cds_WorkerGroupList.IsEmpty) then Exit;
        if TMsgDialog.ShowMsgDialog('你确认要删除该记录吗？',mtConfirmation,[mebYes,mebNo],mebYes)=mrYes then
          Dictionary.cds_WorkerGroupList.Delete;
      end;
  end;
  SetButtonStatus;
end;

procedure TWorkerForm.SetButtonStatus;
var acds:TClientDataSet;
begin
  if pgcDic.ActivePageIndex=0 then
     acds:=Dictionary.cds_WorkerList
  else
     acds:=Dictionary.cds_WorkerGroupList;

  btnAdd.Enabled:=acds.Active;
  btnModify.Enabled:=acds.Active;
  btnDelete.Enabled:=acds.Active;
  btnUnDo.Enabled:= not TGlobal.DeltaIsNull(acds);
  btnExport.Enabled:=acds.Active;
  btnSave.Enabled:= not TGlobal.DeltaIsNull(acds);
end;

procedure TWorkerForm.btnExportClick(Sender: TObject);
begin
  inherited;
  ExportData;
end;

procedure TWorkerForm.ExportData;
begin
  case pgcDic.ActivePageIndex of
    0: TGlobal.SaveDataToFile(Dictionary.cds_WorkerList, sftXLS);
    1: TGlobal.SaveDataToFile(Dictionary.cds_WorkerGroupList, sftXLS);
  else;
  end;
end;

procedure TWorkerForm.grpWorkerGroupInfoExit(Sender: TObject);
begin
  inherited;
  SetButtonStatus;
end;

procedure TWorkerForm.grpWorkerInfoExit(Sender: TObject);
begin
  inherited;
  SetButtonStatus;
end;

procedure TWorkerForm.pnlToolsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if dbedtWorker_ID.Enabled then SetButtonStatus;
  if dbedtWorkerGroup.Enabled then SetButtonStatus;
end;

end.


