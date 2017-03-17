unit frmColorInfoEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, DBClient;

type
  TColorInfoEditFrom = class(TForm)
    pnlTop: TPanel;
    pnlClient: TPanel;
    edtGF_NO: TEdit;
    btnQuery: TButton;
    lbl1: TLabel;
    cxgrdOnline: TcxGrid;
    cxgrdtvGridOnLine: TcxGridDBTableView;
    cxgrdlvlOnLine: TcxGridLevel;
    grp1: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    cbbColor: TComboBox;
    cbbGrade: TComboBox;
    edtWhite: TEdit;
    btnSave: TButton;
    cdsOnline: TClientDataSet;
    dsOnline: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure QueryData;
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ColorInfoEditFrom: TColorInfoEditFrom;

implementation

uses Math, StrUtils, ServerDllPub, uFNMArtInfo,uFNMResource ,
    uDictionary, uShowMessage, uLogin, UAppOption, uGlobal, UGridDecorator;

{$R *.dfm}

procedure TColorInfoEditFrom.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TColorInfoEditFrom.FormDestroy(Sender: TObject);
begin
  ColorInfoEditFrom := nil;
end;

procedure TColorInfoEditFrom.btnQueryClick(Sender: TObject);
begin
  QueryData;
end;

procedure TColorInfoEditFrom.QueryData();
var
  sCondition,sErrorMsg:WideString;
  vData:OleVariant;
begin
  sCondition := '';
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    if Trim(edtGF_NO.Text) = '' then Exit;
    //
    sCondition := QuotedStr(Trim(edtGF_NO.Text)) ;
    FNMServerObj.GetQueryData(vData,'GetOnlineCardForColor',sCondition,sErrorMsg);

    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsOnline.Data := vData;

    GridDecorator.BindCxViewWithDataSource(cxgrdtvGridOnLine,dsOnline,True);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TColorInfoEditFrom.btnSaveClick(Sender: TObject);
var
  sCondition,sGFID,sJobNo,sFncard,sErrorMsg:WideString;
  i:Integer;
  vData:OleVariant;
begin

  if cxgrdtvGridOnLine.Controller.SelectedRowCount <=0 then
    Exit;

  with  cxgrdtvGridOnLine do
  begin
    for i:=0 to Controller.SelectedRowCount - 1 do
    begin
      sGFID := sGFID + IntToStr(Controller.SelectedRows[i].Values[GetColumnByFieldName('gf_id').Index])  + ',';
      sJobNo := sJobNo +  Controller.SelectedRows[i].Values[GetColumnByFieldName('Job_NO').Index] + ',';
      sFncard := sFncard +  Controller.SelectedRows[i].Values[GetColumnByFieldName('FN_card').Index] + ',';
    end;
  end;

  sCondition := QuotedStr(sGFID) + ',' +
                QuotedStr(sJobNo) + ',' +
                QuotedStr(sFncard) + ','+
                QuotedStr(edtWhite.Text) + ',' +
                QuotedStr(cbbGrade.Text) + ',' +
                QuotedStr(cbbColor.Text) + ',' +
                QuotedStr(login.LoginID)  ;
  FNMServerObj.GetQueryData(vData,'SaveColorInfo',sCondition,sErrorMsg);

  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TMsgDialog.ShowMsgDialog('保存成功！',mtInformation);
  QueryData;
end;

end.
