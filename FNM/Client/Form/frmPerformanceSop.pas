unit frmPerformanceSop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Buttons, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DBClient;

type
  TPerformanceSopForm = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    btnQuery: TSpeedButton;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    edtWorkID: TEdit;
    cxgrdbtblvwPerformanceSopTV: TcxGridDBTableView;
    cxgrdPerformanceSopLV: TcxGridLevel;
    cxgrdPerformanceSop: TcxGrid;
    cdsPerformanceSop: TClientDataSet;
    dsPerformanceSop: TDataSource;
    lbl4: TLabel;
    edtBeginTime: TEdit;
    edtEndTime: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PerformanceSopForm: TPerformanceSopForm;

implementation
uses ULogin,StrUtils, uDictionary, UAppOption,
    uFNMArtInfo, uGlobal, ServerDllPub, uFNMResource,
    uShowMessage,uGridDecorator;

{$R *.dfm}

procedure TPerformanceSopForm.FormCreate(Sender: TObject);
begin
       //dtpBeginTime.DateTime:=Now;
      // dtpEndTime.DateTime:=Now;
       edtBeginTime.text:=FormatDateTime(DateTimeFmtStr, Now-1);
       edtEndTime.Text:=FormatDateTime(DateTimeFmtStr, Now-1);
end;

procedure TPerformanceSopForm.btnQueryClick(Sender: TObject);
var
  sSQL,sErrMsg:WideString;
  vData:OleVariant;
begin
   //Ë¢ÐÂÁÐ±í
  sSQL :=QuotedStr(edtBeginTime.text)+','+QuotedStr(edtEndTime.Text) + ','+QuotedStr(Login.CurrentDepartment)+','+QuotedStr(edtWorkID.Text) ;
  //ShowMessage(sSQL);
  FNMServerObj.GetQueryData(vData,'GetPerformanceSop',sSQL,sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  cdsPerformanceSop.Data:=vData;
  GridDecorator.BindCxViewWithDataSource(cxgrdbtblvwPerformanceSopTV,dsPerformanceSop,True);
end;

procedure TPerformanceSopForm.FormDestroy(Sender: TObject);
begin
       PerformanceSopForm:=nil;
end;

procedure TPerformanceSopForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        action:=caFree;
end;

end.
