unit frmSectionFabric;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ComCtrls, DBClient;

type
  TSectionFabricForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    lblWeight: TLabel;
    edtWeight: TEdit;
    btnSave: TButton;
    Panel2: TPanel;
    cxgridFabricInfo: TcxGrid;
    cxgridtvFabricInfo: TcxGridDBTableView;
    cxGridlFabricInfo: TcxGridLevel;
    cxgridtvFabricInfoDBColumn2: TcxGridDBColumn;
    cxgridtvFabricInfoDBColumn3: TcxGridDBColumn;
    cxgridtvFabricInfoDBColumn4: TcxGridDBColumn;
    Panel3: TPanel;
    Panel4: TPanel;
    cxGrid1: TcxGrid;
    cxGridDBtvSend: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    Button2: TButton;
    btnSend: TButton;
    btnDel: TButton;
    btnAdd: TButton;
    cdsSectionFabric: TClientDataSet;
    dsSectionFabric: TDataSource;
    cxgridtvFabricInfoDBColumn1: TcxGridDBColumn;
    cxGridDBtvSendDBColumn1: TcxGridDBColumn;
    dsSendFabric: TDataSource;
    cdsSendFabric: TClientDataSet;
    btnRefresh: TButton;
    Button1: TButton;
    cxgridtvFabricInfoDBColumn5: TcxGridDBColumn;
    cxGridDBtvSendDBColumn2: TcxGridDBColumn;
    Button3: TButton;
    cxGridDBtvSendDBColumn3: TcxGridDBColumn;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LoadData();
    procedure LoadSendData();
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SectionFabricForm: TSectionFabricForm;

implementation

uses
   Math, StrUtils, ServerDllPub, uFNMArtInfo,uFNMResource ,
    uDictionary, uShowMessage, uLogin, UAppOption, uGlobal, UGridDecorator
    ,rptSectionFabricLabel;

{$R *.dfm}

procedure TSectionFabricForm.FormDestroy(Sender: TObject);
begin
   SectionFabricForm := nil;
end;

procedure TSectionFabricForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TSectionFabricForm.FormCreate(Sender: TObject);
begin
  LoadData;
  LoadSendData;
end;

procedure TSectionFabricForm.LoadData;
var
  sErrMsg:WideString;
  sSQL:string;
  vData:OleVariant;
begin
  sSQL := '0,' + QuotedStr(login.CurrentDepartment);
  FNMServerObj.GetQueryData(vData, 'SectionFabricOperate', sSQL, sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  cdsSectionFabric.Data := vData;
end;

procedure TSectionFabricForm.LoadSendData;
var
  sErrMsg:WideString;
  sSQL:string;
  vData:OleVariant;
begin
  sSQL := '2,' + QuotedStr(login.CurrentDepartment);;
  FNMServerObj.GetQueryData(vData, 'SectionFabricOperate', sSQL, sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  cdsSendFabric.Data := vData;
end;

procedure TSectionFabricForm.btnAddClick(Sender: TObject);
var
  i: LongInt;
begin
  if edtWeight.Text = '' then Exit;

  if not TryStrToInt(edtWeight.Text,i) then
  begin
    TMsgDialog.ShowMsgDialog('请输入整数！', mtError);
    Exit;
  end;

  cdsSectionFabric.Edit;
  cdsSectionFabric.Append;
  cdsSectionFabric.FieldByName('fabric_weight').AsString :=  edtWeight.Text;
  cdsSectionFabric.FieldByName('Current_department').AsString := login.CurrentDepartment;
  cdsSectionFabric.FieldByName('Operate_Time').AsString :=  DateTimeToStr(Now);
  cdsSectionFabric.FieldByName('Operator').AsString :=  login.LoginID;
  cdsSectionFabric.Post;
end;

procedure TSectionFabricForm.btnDelClick(Sender: TObject);
begin
  if cdsSectionFabric.RecordCount <=0 then Exit;

   cdsSectionFabric.Delete;
end;

procedure TSectionFabricForm.btnSaveClick(Sender: TObject);
var
  sCondition,sErrMsg,sErrorMsg : WideString;
  vData:OleVariant;
begin
  try
    ShowStatusMessage('正在保存数据...', crHourGlass);
    vData := cdsSectionFabric.Delta;
    FNMServerObj.SaveBaseTableInfo(vData, 'fnSectionFabricList','',sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    
    //生成布号
    sCondition := '4,' + QuotedStr(login.CurrentDepartment);
    FNMServerObj.GetQueryData(vData,'SectionFabricOperate',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;

    TMsgDialog.ShowMsgDialog('保存成功！', mtInformation);
    LoadSendData;
    LoadData;
  finally
    ShowStatusMessage('', crDefault);
  end;
end;

procedure TSectionFabricForm.btnSendClick(Sender: TObject);
var
  sCondition,sErrorMsg : WideString;
  vData:OleVariant;
  i:Integer;
  sIdens:string;
begin
  if cxgridtvFabricInfo.Controller.SelectedRowCount <= 0 then Exit ;

  with cxgridtvFabricInfo do
  begin
    for i := 0 to Controller.SelectedRowCount - 1 do
    begin
       sIdens := sIdens + IntToStr(Controller.SelectedRows[i].Values[GetColumnByFieldName('iden').Index]) + ','
    end;
  end;
  sCondition := '1,' + QuotedStr(login.CurrentDepartment) + ',' + QuotedStr(sIdens);
  FNMServerObj.GetQueryData(vData,'SectionFabricOperate',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TMsgDialog.ShowMsgDialog('送布成功！',mtInformation);
  LoadData;

  //打印标签
  if not Assigned(SectionFabricReportForm) then
     SectionFabricReportForm :=TSectionFabricReportForm.Create(self);
  with SectionFabricReportForm do
  begin
     CDS_Report.Data :=vData;
     CDS_Report.First;
    // TGlobal.ShowMsg('',crDefault);
     qrSectFabric.Prepare;
     qrSectFabric.Preview;
  end;
end;

procedure TSectionFabricForm.Button2Click(Sender: TObject);
var
  sCondition,sErrorMsg : WideString;
  vData:OleVariant;
  i:Integer;
  sIdens:string;
begin

  if cxGridDBtvSend.Controller.SelectedRowCount <= 0 then Exit ;

  with cxGridDBtvSend do
  begin
    for i := 0 to Controller.SelectedRowCount - 1 do
    begin
       sIdens := sIdens + IntToStr(Controller.SelectedRows[i].Values[GetColumnByFieldName('iden').Index]) + ','
    end;
  end;
  sCondition := '3,' + QuotedStr(login.CurrentDepartment) + ',' + QuotedStr(sIdens);
  FNMServerObj.GetQueryData(vData,'SectionFabricOperate',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TMsgDialog.ShowMsgDialog('取消送布成功！',mtInformation);

  LoadSendData;
end;

procedure TSectionFabricForm.PageControl1Change(Sender: TObject);
begin
  LoadSendData;
  LoadData;
end;

procedure TSectionFabricForm.btnRefreshClick(Sender: TObject);
begin
  LoadSendData;
  LoadData;
end;

procedure TSectionFabricForm.Button3Click(Sender: TObject);
var
  sCondition,sErrorMsg : WideString;
  vData:OleVariant;
  i:Integer;
  sIdens:string;
begin
   if cxGridDBtvSend.Controller.SelectedRowCount <= 0 then Exit ;

  with cxGridDBtvSend do
  begin
    for i := 0 to Controller.SelectedRowCount - 1 do
    begin
       sIdens := sIdens + IntToStr(Controller.SelectedRows[i].Values[GetColumnByFieldName('iden').Index]) + ','
    end;
  end;
  sCondition := '5,' + QuotedStr(login.CurrentDepartment) + ',' + QuotedStr(sIdens);
  FNMServerObj.GetQueryData(vData,'SectionFabricOperate',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;

  //打印标签
  if not Assigned(SectionFabricReportForm) then
     SectionFabricReportForm :=TSectionFabricReportForm.Create(self);
  with SectionFabricReportForm do
  begin
     CDS_Report.Data :=vData;
     CDS_Report.First;
    // TGlobal.ShowMsg('',crDefault);
     qrSectFabric.Prepare;
     qrSectFabric.Preview;
  end;
end;

end.
