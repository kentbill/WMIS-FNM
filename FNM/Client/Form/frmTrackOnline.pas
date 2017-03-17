unit frmTrackOnline;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBClient, ComCtrls;

type
  TTrackOnlineForm = class(TForm)
    cdsTrack: TClientDataSet;
    dsTrack: TDataSource;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    cxgrdTrack: TcxGrid;
    cxgdtvTrack: TcxGridDBTableView;
    cxgrdlvlTrack: TcxGridLevel;
    btnSave: TButton;
    btnClose: TButton;
    btnResult: TButton;
    Label1: TLabel;
    edtGF_NO: TEdit;
    dtpBegin: TDateTimePicker;
    Label2: TLabel;
    dtpEND: TDateTimePicker;
    Label3: TLabel;
    Button1: TButton;
    cdsReslut: TClientDataSet;
    dsResult: TDataSource;
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure DataQuery();
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnResultClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure QueryDate();
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TrackOnlineForm: TTrackOnlineForm;

implementation

uses  ServerDllPub, uGlobal, uShowMessage, uLogin, uGridDecorator, uFNMArtInfo,
  uDictionary;

{$R *.dfm}

procedure TTrackOnlineForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TTrackOnlineForm.btnSaveClick(Sender: TObject);
begin
  DataQuery;
end;

procedure TTrackOnlineForm.DataQuery();
var
  vData:OleVariant;
  sSql,sErrMsg:WideString ;
begin
  sSql := QuotedStr(login.CurrentDepartment);
  FNMServerObj.GetQueryData(vData, 'GetOnlineTrackInfo', sSQL, sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  cxgdtvTrack.ClearItems;
  cdsTrack.Data := vData;
  GridDecorator.BindCxViewWithDataSource(cxgdtvTrack, dsTrack);
  cxgdtvTrack.ApplyBestFit(nil);
end;

procedure TTrackOnlineForm.FormDestroy(Sender: TObject);
begin
  TrackOnlineForm := nil;
end;

procedure TTrackOnlineForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TTrackOnlineForm.btnResultClick(Sender: TObject);
var
  vData:OleVariant;
  sSql,sErrMsg,sCondition:WideString ;
  sFncard,sContent,step_no,operation_code :string;
begin
  with cxgdtvTrack do
  begin
    if Controller.SelectedRowCount < 1 then
    begin
      TMsgDialog.ShowMsgDialog('请选择记录！', mtError);
      Exit;
    end;

    sFncard := Controller.SelectedRows[0].Values[GetColumnByFieldName('Fn_card').Index];
    sContent := InputBox('处理结果','处理结果:','');
    if sContent = '' then
      Exit;
    step_no := Controller.SelectedRows[0].Values[GetColumnByFieldName('step_no_1').Index];
    operation_code := Controller.SelectedRows[0].Values[GetColumnByFieldName('Operation_code_1').Index];

    sCondition := QuotedStr(sFncard) + ',' + QuotedStr(sContent) + ',' +
                  QuotedStr(login.LoginName) + ',' + step_no + ',' + QuotedStr(operation_code);
    FNMServerObj.SaveDataBySQL('SaveAffirmResult',sCondition,sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('增加成功！',mtInformation);
  end;
end;

procedure TTrackOnlineForm.Button1Click(Sender: TObject);
begin
  QueryDate();
end;

procedure TTrackOnlineForm.QueryDate();
var
  vData:OleVariant;
  sSql,sErrMsg,sCondition:WideString ;
  sFncard,sContent :string;
begin
  sSql := QuotedStr(edtGF_NO.Text) + ',' +
          QuotedStr(DateTimeToStr(dtpBegin.Date))+ ',' +
          QuotedStr(DateTimeToStr(dtpEND.Date));
  FNMServerObj.GetQueryData(vData, 'GetAffirmResult', sSQL, sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  cdsReslut.Data := vData;
  cxgdtvTrack.ClearItems;
  GridDecorator.BindCxViewWithDataSource(cxgdtvTrack, dsResult);
  cxgdtvTrack.ApplyBestFit(nil);
end;

procedure TTrackOnlineForm.FormCreate(Sender: TObject);
begin
  dtpEND.DateTime := Now;
end;

end.
