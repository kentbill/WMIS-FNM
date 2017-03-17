unit frmWorkerPrize;
{******************************************************************************}
{                                                                              }
{       ������� WMS                                                           }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmYSDictionary.pas                                           }
{       �������� 2004-8-12 11:03:49                                            }
{       ������Ա cuijf                                                         }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��   STSYSTEMDICTIONARY; STLOCATIONLIST                                                        }
{       ������Ҫ����/SQL����˵��                                               }
{       �������� ά��ɴ�ֵ�ͨ���ֵ估��λ�б�                                                              }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ComCtrls, ExtCtrls, DB, DBClient, Buttons, cxSplitter,
  StdCtrls, DBCtrls, Mask, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, cxDBData;

type
  TWorkerPrizeForm = class(TBaseForm)
    pgcPrize: TPageControl;
    pnlTool: TPanel;
    tsCommon: TTabSheet;
    tsLocation: TTabSheet;
    grpWorkerPrize: TGroupBox;
    grpWorkerPrizeEdit: TGroupBox;
    lblMonitor: TLabel;
    lblReason: TLabel;
    lblWorkerID: TLabel;
    pnlTools: TPanel;
    cxspl1: TcxSplitter;
    btnAdd: TSpeedButton;
    btnModify: TSpeedButton;
    btnDelete: TSpeedButton;
    btnUndo: TSpeedButton;
    btnExport: TSpeedButton;
    btnSave: TSpeedButton;
    btnExit: TSpeedButton;
    btnRefresh: TSpeedButton;
    cdsWorkerPrize: TClientDataSet;
    grpWorkerError: TGroupBox;
    grpWorkerErrorEdit: TGroupBox;
    dsWorkerPrize: TDataSource;
    cxgridtvWorkerPrize: TcxGridDBTableView;
    cxGridlWorkerPrize: TcxGridLevel;
    cxgridWorkerPrize: TcxGrid;
    cdsWorkerError: TClientDataSet;
    cxgridWorkerError: TcxGrid;
    cxgridtvWorkerError: TcxGridDBTableView;
    cxGridlWorkerError: TcxGridLevel;
    dsWorkerError: TDataSource;
    dtpQueryDate: TDateTimePicker;
    lblQueryDate: TLabel;
    dblkcbbWorkerID: TDBLookupComboBox;
    dblkcbbMonitor: TDBLookupComboBox;
    dbedtPrize: TDBEdit;
    lblPrize: TLabel;
    dbmmoPrizeReson: TDBMemo;
    lbl1: TLabel;
    dblkcbbWorker_ID: TDBLookupComboBox;
    lbl2: TLabel;
    dblkcbbFinder: TDBLookupComboBox;
    lbl3: TLabel;
    dbedtErrorField: TDBEdit;
    lbl4: TLabel;
    dbmmoErrorReason: TDBMemo;
    cxspl2: TcxSplitter;
    dsWorkerList: TDataSource;
    dsMonitorList: TDataSource;
    cdsMonitorList: TClientDataSet;
    //ȡͨ���ֵ�
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnModifyClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnUndoClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure grpWorkerPrizeEditExit(Sender: TObject);
    procedure grpWorkerErrorEditExit(Sender: TObject);
    procedure pnlToolsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
    //��ʼ��
    procedure Initialize;
    //��ѯ����
    procedure GetWorkerPrizeOrErrorInfo;
    procedure GetData;
    //��������
    procedure AddNew;
    //���������״̬
    procedure SetPanelStatus(Enable:Boolean);
    //����button״̬
    procedure SetButtonStatus;
    //�����޸�״̬
    procedure Modify;
    //��������
    procedure SaveData;
    //ɾ����¼
    procedure DeleteData;
    //������¼
    procedure ExportData;    
  public
    { Public declarations }
  end;

var
  WorkerPrizeForm: TWorkerPrizeForm;

implementation

uses ServerDllPub, UShowMessage,uLogin,
  UAppOption, UGridDecorator,uGlobal,uDictionary;

{$R *.dfm}
 
procedure TWorkerPrizeForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TWorkerPrizeForm.FormDestroy(Sender: TObject);
begin
  WorkerPrizeForm:=nil;
end;

procedure TWorkerPrizeForm.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TWorkerPrizeForm.btnModifyClick(Sender: TObject);
begin
  Modify;
end;

procedure TWorkerPrizeForm.btnSaveClick(Sender: TObject);
begin
  SaveData;
end;

procedure TWorkerPrizeForm.Initialize;
begin
  GetData();
end;

procedure TWorkerPrizeForm.FormCreate(Sender: TObject);
begin
  inherited;
  dtpQueryDate.Date := Date;
  Initialize;
end;

procedure TWorkerPrizeForm.GetWorkerPrizeOrErrorInfo;
var vData: OleVariant;
    sQuery_Date,sErrorMsg: WideString;
    iType: Integer;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('���ڻ�ȡ�����Եȣ�', crHourGlass);
    sQuery_Date := DateToStr(dtpQueryDate.Date);
    iType := pgcPrize.ActivePageIndex;
    FNMServerObj.GetWorkerPrizeOrErrorInfo(vData,sQuery_Date,Login.CurrentDepartment,iType, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    if pgcPrize.ActivePageIndex =0 then
    begin
      cdsWorkerPrize.Data := vData;
      GridDecorator.BindCxViewWithDataSource(cxgridtvWorkerPrize,dsWorkerPrize);
    end else
    begin
      cdsWorkerError.Data := vData;
      GridDecorator.BindCxViewWithDataSource(cxgridtvWorkerError,dsWorkerError);
    end;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;
end;

procedure TWorkerPrizeForm.GetData;
var FilterStr: string;
begin
  //Monitor List
  FilterStr:='';
  TGlobal.FilterData(Dictionary.cds_WorkerList,FilterStr);
  cdsMonitorList.Data := Dictionary.cds_WorkerList.Data;
  //WorkerList
  FilterStr:='';
  TGlobal.FilterData(Dictionary.cds_WorkerList,FilterStr);
  dsWorkerList.DataSet := Dictionary.cds_WorkerList;
   //����BUTTON��״̬
  GetWorkerPrizeOrErrorInfo;
  SetButtonStatus;
  SetPanelstatus(false);
end;

procedure TWorkerPrizeForm.AddNew;
begin
  case pgcPrize.ActivePageIndex of
    0:
    begin
      with cdsWorkerPrize do
      begin
        if not Active then exit;
        try
          DisableControls;
          Append;
          FieldByName('Prize_Date').AsString := DateToStr(dtpQueryDate.Date);
          FieldByName('Current_Department').AsString := Login.CurrentDepartment;
          FieldByName('Operator').AsString := Login.LoginName;
          FieldByName('Operate_Time').AsDateTime := Now;
        finally
          EnableControls;
        end;
      end;
    end;
    1:
    begin
      with cdsWorkerError do
      begin
        if not Active then exit;
        try
          DisableControls;
          Append;
          FieldByName('Error_Date').AsString := DateToStr(dtpQueryDate.Date);
          FieldByName('Current_Department').AsString := Login.CurrentDepartment;
          FieldByName('Operator').AsString := Login.LoginName;
          FieldByName('Operate_Time').AsDateTime := Now;
        finally
          EnableControls;
        end
      end;;
    end;
  end;
  SetPanelStatus(True);
  SetButtonStatus;
end;

procedure TWorkerPrizeForm.btnAddClick(Sender: TObject);
begin
  inherited;
  AddNew;
end;

procedure TWorkerPrizeForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  case pgcPrize.ActivePageIndex of
    0: ;
    1: ;
  end;
end;

procedure TWorkerPrizeForm.btnUndoClick(Sender: TObject);
begin
  inherited;
  if pgcPrize.ActivePageIndex=0 then
    cdsWorkerPrize.CancelUpdates
  else if pgcPrize.ActivePageIndex=1 then
    cdsWorkerError.CancelUpdates;
  //��fuΪֻ��״̬
  SetButtonStatus;
  SetPanelStatus(False);
end;

procedure TWorkerPrizeForm.SetPanelStatus(enable:Boolean);
var i:integer;
begin
  case pgcPrize.ActivePageIndex of
    0:
      begin
        for i:=0 to grpWorkerPrizeEdit.ControlCount-1 do
          grpWorkerPrizeEdit.Controls[i].Enabled:=Enable;
      end;
    1:
      begin
        for i:=0 to grpWorkerErrorEdit.ControlCount-1 do
          grpWorkerErrorEdit.Controls[i].Enabled:=Enable;
      end;
  end;
end;

procedure TWorkerPrizeForm.Modify;
begin
  case pgcPrize.ActivePageIndex of
    0:
      begin
        if not cdsWorkerPrize.Active then exit;
        if cdsWorkerPrize.IsEmpty then exit;
         cdsWorkerPrize.Edit;
      end;
    1:
      begin
        if not cdsWorkerError.Active then exit;
        if cdsWorkerError.IsEmpty then exit;
        cdsWorkerError.Edit;
      end;
  end;
  SetPanelStatus(true);
end;

procedure TWorkerPrizeForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetData();
end;

procedure TWorkerPrizeForm.SaveData;
var
  vData:OleVariant;
  sErrorMsg:WideString;
begin
  try
    ShowMsg('���ڱ������ݣ����Ժ�...',crHourGlass) ;
    case pgcPrize.ActivePageIndex of
    0:
      begin
        if cdsWorkerPrize.ChangeCount =0 then exit;
        vData:=cdsWorkerPrize.Delta;
        FNMServerObj.SaveBaseTableInfo(vData,'dbo.fnWorkerPrize','Iden',sErrorMsg);
        cdsWorkerPrize.MergeChangeLog;
      end;
    1:
      begin
        if cdsWorkerError.ChangeCount =0 then exit;
        vData:=cdsWorkerError.Delta;
        FNMServerObj.SaveBaseTableInfo(vData,'dbo.fnWorkerError','Iden',sErrorMsg);
        cdsWorkerError.MergeChangeLog;
      end;
    end;
    if sErrorMsg<>'' then
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError)
    else
    begin
      TMsgDialog.ShowMsgDialog('���ݱ���ɹ���',mtInformation);
      GetData();
      SetPanelStatus(False);
    end;
  finally
    SetButtonStatus;
    ShowMsg('') ;
  end;
end;

procedure TWorkerPrizeForm.btnDeleteClick(Sender: TObject);
begin
  inherited;
  DeleteData;

end;

procedure TWorkerPrizeForm.DeleteData;
begin
  case pgcPrize.ActivePageIndex of
    0:
      begin
        if (not cdsWorkerPrize.Active) or (cdsWorkerPrize.IsEmpty) then exit;
        if TMsgDialog.ShowMsgDialog('��ȷ��Ҫɾ���ü�¼��',mtConfirmation,[mebYes,mebNo],mebYes)=mrYes then
          cdsWorkerPrize.Delete;
      end;
    1:
      begin
        if (not cdsWorkerError.Active) or (cdsWorkerError.IsEmpty) then exit;
        if TMsgDialog.ShowMsgDialog('��ȷ��Ҫɾ���ü�¼��',mtConfirmation,[mebYes,mebNo],mebYes)=mrYes then
          cdsWorkerError.Delete;
      end;
  end;
  SetButtonStatus;
end;

procedure TWorkerPrizeForm.SetButtonStatus;
var acds:TClientDataSet;
begin
  if pgcPrize.ActivePageIndex = 0 then
     acds:=cdsWorkerPrize
  else
     acds:=cdsWorkerError;

  btnAdd.Enabled:=acds.Active;
  btnModify.Enabled:=acds.Active;
  btnDelete.Enabled:=acds.Active;
  btnUnDo.Enabled:= not TGlobal.DeltaIsNull(acds);
  btnExport.Enabled:=acds.Active;
  btnSave.Enabled:= not TGlobal.DeltaIsNull(acds);
end;

procedure TWorkerPrizeForm.btnExportClick(Sender: TObject);
begin
  inherited;
  ExportData;
end;

procedure TWorkerPrizeForm.ExportData;
begin
  case pgcPrize.ActivePageIndex of
    0: TGlobal.SaveDataToFile(cdsWorkerPrize, sftXLS);
    1: TGlobal.SaveDataToFile(cdsWorkerError, sftXLS);
  end;
end;

procedure TWorkerPrizeForm.grpWorkerPrizeEditExit(Sender: TObject);
begin
  inherited;
  SetButtonStatus;
end;

procedure TWorkerPrizeForm.grpWorkerErrorEditExit(Sender: TObject);
begin
  inherited;
  SetButtonStatus;
end;

procedure TWorkerPrizeForm.pnlToolsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  SetButtonStatus;
end;

end.


