unit frmPriceQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, StdCtrls, ComCtrls, DBClient;

type
  TPriceQueryForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    cxgridPrice: TcxGrid;
    cxgridtvPrice: TcxGridDBTableView;
    cxgridlPrice: TcxGridLevel;
    Label1: TLabel;
    edtWorkID: TEdit;
    Label2: TLabel;
    btnQuery: TButton;
    btnExit: TButton;
    dtpDate: TDateTimePicker;
    dsPrice: TDataSource;
    cdsPrice: TClientDataSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure QueryData;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PriceQueryForm: TPriceQueryForm;

implementation

uses StrUtils, uDictionary, UAppOption,
    uFNMArtInfo, uGlobal, ServerDllPub, uFNMResource,
    uLogin, uShowMessage,uGridDecorator;

{$R *.dfm}

procedure TPriceQueryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //Action := caFree;
end;

procedure TPriceQueryForm.FormDestroy(Sender: TObject);
begin
  PriceQueryForm := nil;
end;

procedure TPriceQueryForm.btnQueryClick(Sender: TObject);
begin
  QueryData;
end;

procedure TPriceQueryForm.QueryData;
var
  sSQL,sErrMsg:WideString;
  vData:OleVariant;
begin
   //Ë¢ÐÂÁÐ±í
  sSQL := '4,' + QuotedStr(edtWorkID.Text) + ',' + QuotedStr(DateToStr(dtpDate.DateTime));
  FNMServerObj.GetQueryData(vData,'SaveWorkerPrice',sSQL,sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  cdsprice.Data := vData;
  GridDecorator.BindCxViewWithDataSource(cxgridtvPrice,dsprice,True);
end;

procedure TPriceQueryForm.FormCreate(Sender: TObject);
begin
  dtpDate.DateTime := Now;
end;

end.
