unit frmScrapInfo;

interface

uses
  Windows, Messages, Classes, Controls, Graphics, ComCtrls, Forms,
  StdCtrls, Buttons, ExtCtrls, cxSpinEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, DB, Grids, ValEdit, DBClient, Menus,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid;

type
  TScrapInfoForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    cxgridScrapInfo: TcxGrid;
    cxgridtvScrapInfo: TcxGridDBTableView;
    cxGridlScrapInfo: TcxGridLevel;
    cdsScrapInfo: TClientDataSet;
    dsScrapInfo: TDataSource;
    lblBeginDate: TLabel;
    lblEndDate: TLabel;
    btnQuery: TButton;
    dtpEnd: TDateTimePicker;
    dtpBegin: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure RefreshData();
    procedure btnQueryClick(Sender: TObject);
    procedure SetControl();
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgridtvScrapInfoEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ScrapInfoForm: TScrapInfoForm;

implementation

uses SysUtils, Variants, StrUtils, uDictionary, UAppOption,
    uFNMArtInfo, Dialogs, uGlobal, ServerDllPub, uFNMResource,
    uLogin, uShowMessage,uGridDecorator;

{$R *.dfm}

procedure TScrapInfoForm.FormCreate(Sender: TObject);
begin

  SetControl;
  RefreshData;
end;

procedure TScrapInfoForm.RefreshData();
var
  sSQL,sErrMsg:WideString;
  vData:OleVariant;
begin
  sSQL := QuotedStr(Login.CurrentDepartment) + ',' + QuotedStr(DateTimeToStr(dtpBegin.Date)) + ',' + QuotedStr(DateTimeToStr(dtpEnd.Date));
  FNMServerObj.GetQueryData(vData, 'GetScrapInfo',sSQL ,sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  cdsScrapInfo.Data := vData;
  GridDecorator.BindCxViewWithDataSource(cxgridtvScrapInfo, dsScrapInfo);
  //cxgridtvScrapInfo.Columns[4].Options.Editing := True;
  cxgridtvScrapInfo.GetColumnByFieldName('Quantity').Options.Editing:=true;
  cxgridtvScrapInfo.GetColumnByFieldName('Margin').Options.Editing:=true;
end;

procedure tscrapinfoform.SetControl();
begin
  dtpBegin.Width := 109;
  dtpEnd.Width := 109;
  dtpBegin.DateTime := Now - 7;
  dtpEnd.DateTime := Now;
end;

procedure TScrapInfoForm.btnQueryClick(Sender: TObject);
begin
  RefreshData;
end;

procedure TScrapInfoForm.FormActivate(Sender: TObject);
begin
  SetControl;
end;

procedure TScrapInfoForm.FormDestroy(Sender: TObject);
begin
  ScrapInfoForm := nil;
end;

procedure TScrapInfoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TScrapInfoForm.cxgridtvScrapInfoEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  if (AItem.Index = 5) or (AItem.Index = 6) then
    AAllow := True
  else
    AAllow := False;
end;

end.
