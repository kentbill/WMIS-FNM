unit rptSendInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, QRCTRLS, QUICKRPT, ExtCtrls, DBClient, jpeg, Provider,
  ADODB;

type
  TSendInfoReport = class(TForm)
    qrSendInfo: TQuickRep;
    QRBand2: TQRBand;
    qrl4: TQRLabel;
    qrs1: TQRShape;
    qrl5: TQRLabel;
    qrl13: TQRLabel;
    qrs9: TQRShape;
    qrl10: TQRLabel;
    qrs11: TQRShape;
    qrl9: TQRLabel;
    qrs2: TQRShape;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    QRLabel2: TQRLabel;
    QRShape6: TQRShape;
    QRBand3: TQRBand;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    qrdbtFabric_NO: TQRDBText;
    qrdbtGFNo: TQRDBText;
    qrdbtQuantity: TQRDBText;
    qrdbtRemark: TQRDBText;
    qrs7: TQRShape;
    qrdbtFN_Card: TQRDBText;
    qrs12: TQRShape;
    QRShape4: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRShape5: TQRShape;
    QRBand1: TQRBand;
    qrlCompany: TQRSysData;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrdbtDestination: TQRDBText;
    qrdbtNoteNo: TQRDBText;
    qrl14: TQRLabel;
    QRImage1: TQRImage;
    qrdbt_BarCode: TQRDBText;
    qrDateTime: TQRLabel;
    qrgNoteNo: TQRGroup;
    QRBand5: TQRBand;
    qrl15: TQRLabel;
    qrexTTLQuantity: TQRExpr;
    qrl18: TQRLabel;
    qrl17: TQRLabel;
    qrlOperator: TQRLabel;
    qrl16: TQRLabel;
    cdsReport: TClientDataSet;
    QRShape7: TQRShape;
    QRLabel3: TQRLabel;
    QRShape8: TQRShape;
    QRDBText3: TQRDBText;
    QRShape9: TQRShape;
    QRLabel4: TQRLabel;
    qrdbtStatus: TQRDBText;
    QRShape10: TQRShape;
    QRLabel5: TQRLabel;
    cdsAlert: TClientDataSet;
    QRLabel6: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     //预览报表
    procedure PreviewReport(sNote_No: string;Preview:Boolean);
  end;

var
  SendInfoReport: TSendInfoReport;

implementation

uses uShowMessage,ServerDllPub, uLogin,
  UAppOption, uGlobal;

{$R *.dfm}

procedure TSendInfoReport.PreviewReport(sNote_No: string;Preview:Boolean);
var
  vData:Olevariant;
  sCondition,sErrorMsg:WideString;
  info:string;
begin
  //提取送布单记录
  if Trim(sNote_NO)= '' then Exit;
  sCondition := QuotedStr(sNote_NO)+',1,'+ QuotedStr(Login.CurrentDepartment)+','+ QuotedStr(Login.LoginID);
  FNMServerObj.GetQueryData(vData,'GetReport',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  cdsReport.Data:=vData[0];
  cdsAlert.Data:=vData[1];
  QRLabel5.Caption :=  cdsAlert.FieldByName('contents').AsString;

  qrl16.Top := 64 + 12 * cdsAlert.FieldByName('iCount').AsInteger;
  qrlOperator.Top := 64 + 12 * cdsAlert.FieldByName('iCount').AsInteger;
  qrl17.Top := 64 + 12 * cdsAlert.FieldByName('iCount').AsInteger;
  qrl18.Top := 64 + 12 * cdsAlert.FieldByName('iCount').AsInteger;
  QRBand5.Height := QRBand5.Height + 10 * cdsAlert.FieldByName('iCount').AsInteger;

  self.qrDateTime.Caption := cdsReport.FieldByName('Send_Time').AsString;
  self.qrlOperator.Caption:=Login.LoginName;

  info:= '';
  info := cdsAlert.FieldByName('info').AsString;
  if info<> '' then
    QRLabel6.Caption := info;

  qrSendInfo.Prepare;
  if Preview then
    qrSendInfo.Preview
  else
    qrSendInfo.Print;
end;

procedure TSendInfoReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TSendInfoReport.FormDestroy(Sender: TObject);
begin
  SendInfoReport:=nil;
end;

procedure TSendInfoReport.FormCreate(Sender: TObject);
begin
  with qrdbt_BarCode.Font do
  begin
    Name:='C39HrP24DhTt';
    Size:=30;
  end;
end;

end.

