unit frmSuspendApproval;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGrid, DB, DBClient, cxDBData, cxGridDBTableView, Buttons;

type
  TSuspendApprovalForm = class(TForm)
    GroupBox1: TGroupBox;
    tbcApproval: TTabControl;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    dsApproval: TDataSource;
    cdsApproval: TClientDataSet;
    cxgrid_SuspendApproval: TcxGrid;
    cxgridtv_SuspendApproval: TcxGridDBTableView;
    cxGridl_SuspendApproval: TcxGridLevel;
    btn_Exit: TBitBtn;
    btn_Approve: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure LoadData();
    procedure tbcApprovalChange(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_ApproveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SuspendApprovalForm: TSuspendApprovalForm;

implementation

uses
    StrUtils, Math, frmMachineSample, uAppOption, uGlobal, uShowMessage, 
     ServerDllPub, uCADInfo, uDictionary, uLogin, uGridDecorator;
{$R *.dfm}

procedure TSuspendApprovalForm.FormCreate(Sender: TObject);
begin
  LoadData;
end;

procedure TSuspendApprovalForm.LoadData();
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
  iType:Integer;
begin
  iType := tbcApproval.TabIndex;

  sCondition := QuotedStr('') + ',' + QuotedStr('') + ',' + QuotedStr(Login.CurrentDepartment) + ',2,' + IntToStr(iType);
  FNMServerObj.GetQueryData(vData,'GetSuspendInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog('查询出错。',mtError);
    Exit;
  end;
  cdsApproval.Data := vData;
  GridDecorator.BindCxViewWithDataSource(cxgridtv_SuspendApproval,dsApproval);
end;

procedure TSuspendApprovalForm.tbcApprovalChange(Sender: TObject);
begin
  LoadData;
end;

procedure TSuspendApprovalForm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TSuspendApprovalForm.btn_ApproveClick(Sender: TObject);
var
   i:Integer;
   idens:string;
   sCondition,sErrorMsg: WideString;
begin
  with cxgridtv_SuspendApproval do
  begin
    for i:=0 to Controller.SelectedRowCount-1 do
    begin
      idens := idens + IntToStr(Controller.SelectedRows[i].Values[GetColumnByFieldName('iden').Index]) + ',';
    end;
  end;
  if idens = '' then
  begin
    TMsgDialog.ShowMsgDialog('请先选择要审批的数据!', mtInformation);
    Exit;
  end;
  
  sCondition := QuotedStr('')+','+QuotedStr('')+','+
                QuotedStr('')+','+ QuotedStr('')+','+
                QuotedStr('')+','+QuotedStr('') + ',' +
                QuotedStr(idens)+','+ QuotedStr(Login.LoginID) + ',1';
  FNMServerObj.SaveDataBySQL('SaveSuspendInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;
  TMsgDialog.ShowMsgDialog('审批通过！', mtInformation);
  LoadData;
end;

procedure TSuspendApprovalForm.FormDestroy(Sender: TObject);
begin
  SuspendApprovalForm := nil;
end;

procedure TSuspendApprovalForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
