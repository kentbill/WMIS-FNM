unit frmAlertInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, StdCtrls;

type
  TAlertInfoForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    cxgridAlertInfo: TcxGrid;
    cxgridtvAlertInfo: TcxGridDBTableView;
    cxGridlAlertInfo: TcxGridLevel;
    cdsAlertInfo: TClientDataSet;
    dsAlertInfo: TDataSource;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure QueryData();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AlertInfoForm: TAlertInfoForm;

implementation

uses
  Math, StrUtils, ServerDllPub, uFNMArtInfo,uFNMResource ,
    uDictionary, uShowMessage, uLogin, UAppOption, uGlobal, UGridDecorator;

{$R *.dfm}

procedure TAlertInfoForm.FormDestroy(Sender: TObject);
begin
  AlertInfoForm := nil;
end;

procedure TAlertInfoForm.FormCreate(Sender: TObject);
begin
  QueryData;
end;

procedure TAlertInfoForm.QueryData();
var
  sErrMsg:WideString;
  sSQL:string;
  vData:OleVariant;
begin
  sSQL := QuotedStr('MC02') + ',1';
  FNMServerObj.GetQueryData(vData, 'GetAlertInfo', sSQL, sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  cdsAlertInfo.Data := vData;
  GridDecorator.BindCxViewWithDataSource(cxgridtvAlertInfo, dsAlertInfo,True);
end;

end.
