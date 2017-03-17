unit rptAccidentRecord;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, DB, DBClient;

type
  TAccidentRecordReport = class(TForm)
    qrAccidentRecord: TQuickRep;
    qrbPageHeaderBand1: TQRBand;
    qrbTitleBand1: TQRBand;
    cdsAccidentRecord: TClientDataSet;
    cdsDtl: TClientDataSet;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrbDetailBand1: TQRBand;
    qrbSummaryBand1: TQRBand;
    qrdbtGF_NO: TQRDBText;
    qrs1: TQRShape;
    QRLabel1: TQRLabel;
    qrdbtType: TQRDBText;
    QRShape1: TQRShape;
    QRLabel2: TQRLabel;
    qrdbtCustomer: TQRDBText;
    QRShape2: TQRShape;
    QRLabel3: TQRLabel;
    qrdbtDefects: TQRDBText;
    QRShape3: TQRShape;
    QRLabel4: TQRLabel;
    qrdbtReject_QTY: TQRDBText;
    QRShape4: TQRShape;
    QRLabel5: TQRLabel;
    qrdbtType1: TQRDBText;
    QRShape5: TQRShape;
    QRLabel6: TQRLabel;
    qrdbtNote_NO: TQRDBText;
    QRShape6: TQRShape;
    QRLabel7: TQRLabel;
    qrdbtFN_Cards: TQRDBText;
    QRShape7: TQRShape;
    qrdbtDept: TQRDBText;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    qrdbtOperator1: TQRDBText;
    QRShape8: TQRShape;
    QRLabel11: TQRLabel;
    qrdbtOperate_Time1: TQRDBText;
    QRShape9: TQRShape;
    QRLabel12: TQRLabel;
    QRShape10: TQRShape;
    QRLabel13: TQRLabel;
    qrdbtOperator2: TQRDBText;
    QRShape11: TQRShape;
    QRLabel15: TQRLabel;
    QRShape13: TQRShape;
    QRLabel16: TQRLabel;
    qrdbtOperator3: TQRDBText;
    QRShape14: TQRShape;
    QRLabel18: TQRLabel;
    QRShape16: TQRShape;
    QRLabel19: TQRLabel;
    qrdbtOperator5: TQRDBText;
    QRShape17: TQRShape;
    QRLabel21: TQRLabel;
    QRShape19: TQRShape;
    QRLabel14: TQRLabel;
    qrdbtOperate_Time2: TQRDBText;
    QRShape12: TQRShape;
    QRLabel17: TQRLabel;
    qrdbtOperate_Time3: TQRDBText;
    QRShape15: TQRShape;
    QRLabel20: TQRLabel;
    qrdbtOperate_Time5: TQRDBText;
    QRShape18: TQRShape;
    QRLabel22: TQRLabel;
    QRShape20: TQRShape;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    qrs2: TQRShape;
    QRShape23: TQRShape;
    qrdbtWhat: TQRDBText;
    qrdbtWHO: TQRDBText;
    qrdbtOperate_Time: TQRDBText;
    QRLabel23: TQRLabel;
    QRDBText7: TQRDBText;
    QRShape24: TQRShape;
    QRLabel27: TQRLabel;
    QRDBText8: TQRDBText;
    QRShape25: TQRShape;
    QRLabel28: TQRLabel;
    qrdbtOperator4: TQRDBText;
    QRShape26: TQRShape;
    QRLabel29: TQRLabel;
    qrdbtOperate_Time4: TQRDBText;
    QRShape27: TQRShape;
    qrdbtReject_Desc: TQRDBText;
    qrdbtReject_Reason: TQRDBText;
    qrdbtReject_Method: TQRDBText;
    qrdbtReject_Result: TQRDBText;
    QRLabel30: TQRLabel;
    QRShape28: TQRShape;
    QRLabel31: TQRLabel;
    QRShape29: TQRShape;
    qrlHas_Sample: TQRLabel;
    qrlHas_Card: TQRLabel;
    QRLabel32: TQRLabel;
    QRShape30: TQRShape;
    QRLabel33: TQRLabel;
    QRShape31: TQRShape;
    QRDBText1: TQRDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure qrbTitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AccidentRecordReport: TAccidentRecordReport;

procedure PrintAccidentRecord(Note_NO: string; Preview: Boolean);

implementation

uses uShowMessage,ServerDllPub, uLogin, UAppOption, uGlobal;

{$R *.dfm}

procedure PrintAccidentRecord(Note_NO: string; Preview: Boolean);
var
  sSQL, sErrMsg: WideString;
  vData: Olevariant;
begin
  if AccidentRecordReport = nil then
    AccidentRecordReport:=TAccidentRecordReport.Create(Application);

  sSQL := QuotedStr(Note_NO) + ',' + QuotedStr(login.LoginName);
  FNMServerObj.GetQueryData(vData,'rptGetAccidentRecordReport',sSQL,sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;

  AccidentRecordReport.cdsAccidentRecord.Data := vData[0];
  AccidentRecordReport.cdsDtl.Data := vData[1];

  if Preview then
    AccidentRecordReport.qrAccidentRecord.Preview
  else
  begin
    AccidentRecordReport.qrAccidentRecord.Print;
  end;
end;

procedure TAccidentRecordReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TAccidentRecordReport.FormDestroy(Sender: TObject);
begin
  AccidentRecordReport := nil;
end;

procedure TAccidentRecordReport.qrbTitleBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if cdsAccidentRecord.FieldByName('Has_Sample').IsNull then
    qrlHas_Sample.Caption := ''
  else if cdsAccidentRecord.FieldByName('Has_Sample').AsBoolean then
    qrlHas_Sample.Caption := '有'
  else
    qrlHas_Sample.Caption := '无';

  if cdsAccidentRecord.FieldByName('Has_Card').IsNull then
    qrlHas_Card.Caption := ''
  else if cdsAccidentRecord.FieldByName('Has_Card').AsBoolean then
    qrlHas_Card.Caption := '有'
  else
    qrlHas_Card.Caption := '无';
end;

end.
