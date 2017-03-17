unit frmOTDTrace;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, StdCtrls, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid;

type
  TOTDTraceForm = class(TForm)
    gbBottom: TGroupBox;
    gbClient: TGroupBox;
    cxgrid_OTDTrace: TcxGrid;
    cxgridtv_OTDTrace: TcxGridDBTableView;
    cxGridl_OTDTrace: TcxGridLevel;
    btnQuery: TButton;
    dsOTDInfo: TDataSource;
    cdsOTDInfo: TClientDataSet;
    btnSaveRemerk: TButton;
    Button1: TButton;
    procedure btnQueryClick(Sender: TObject);
    procedure RefreshData();
    procedure btnSaveRemerkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OTDTraceForm: TOTDTraceForm;

implementation

uses  uDictionary, UAppOption,
    uFNMArtInfo, uGlobal, ServerDllPub, uFNMResource,
    uLogin, uShowMessage,uGridDecorator;


{$R *.dfm}

procedure TOTDTraceForm.btnQueryClick(Sender: TObject);
begin
  RefreshData;
end;

procedure TOTDTraceForm.RefreshData();
var
  sSQL,sErrMsg:WideString;
  vData,vTemp:OleVariant;
  i:Integer;
begin
  sSQL := QuotedStr(Login.CurrentDepartment);
  FNMServerObj.GetQueryData(vData, 'OTDTrace',sSQL ,sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  cdsOTDInfo.Data := vData;

  GridDecorator.BindCxViewWithDataSource(cxgridtv_OTDTrace, dsOTDInfo);
  GridDecorator.HideFields(cxgridtv_OTDTrace,['iden']);
  i:=0;
  while i < cxgridtv_OTDTrace.ColumnCount do
  begin
    cxgridtv_OTDTrace.Columns[i].Options.Editing := False;
    i:= i + 1;
  end;
  //cxgridtv_OTDTrace.GetColumnByFieldName('Remark').Options.Editing := True;
  //cxgridtv_OTDTrace.GetColumnByFieldName('Processing_Group').Options.Editing := True;
  //cxgridtvScrapInfo.Columns[4].Options.Editing := True;

  //cxgridtvScrapInfo.GetColumnByFieldName('Quantity').Options.Editing:=true;
  //cxgridtvScrapInfo.GetColumnByFieldName('Margin').Options.Editing:=true;
end;

procedure TOTDTraceForm.btnSaveRemerkClick(Sender: TObject);
var
  sRemark,sGFNO,sJobNO:string;
  sGF_NOs,sJob_NOs:WideString;
  i:Integer;
  sSQL,sErrMsg:WideString;
  vData,vTemp:OleVariant;
begin
  sRemark := InputBox('OTD备注','备注:','');
  if sRemark = '' then Exit;
  with cxgridtv_OTDTrace do
  begin
    for i:=0 to Controller.SelectedRowCount -1 do
    begin
      sGF_NOs := sGF_NOs + Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_NO').Index] + ',';
      sJob_NOs := sJob_NOs + Controller.SelectedRows[i].Values[GetColumnByFieldName('Job_NO').Index]+ ',';
    end;
  end;
  if (sGF_NOs <> '') and (sJob_NOs <> '') then
  begin
    sSQL := QuotedStr(Login.CurrentDepartment) + ',' +
            QuotedStr(sGF_NOs) + ',' +
            QuotedStr(sJob_NOs) + ',' +
            QuotedStr(sRemark) + ',1';
    FNMServerObj.GetQueryData(vData, 'OTDTrace',sSQL ,sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    //更新前台备注
    with cxgridtv_OTDTrace do
    begin
      for i:=0 to Controller.SelectedRowCount -1 do
      begin
        sGFNO := Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_NO').Index];
        sJobNO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Job_NO').Index];

        cdsOTDInfo.Locate('GF_NO;Job_NO',VarArrayOf([sGFNO,sJobNO]),[]);
        cdsOTDInfo.Edit;
        cdsOTDInfo.FieldByName('Remark').AsString := sRemark;
        cdsOTDInfo.Post;

      end;
    end;

    TMsgDialog.ShowMsgDialog('保存备注成功！',mtInformation );
  end;
end;

procedure TOTDTraceForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TOTDTraceForm.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TOTDTraceForm.FormDestroy(Sender: TObject);
begin
   OTDTraceForm := nil;
end;

end.
