unit rptHLCard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBClient, QRCtrls, QuickRpt, jpeg, ExtCtrls;

type
  THLCardReport = class(TForm)
    qrFNCard: TQuickRep;
    QRBand1: TQRBand;
    QRSysData1: TQRSysData;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrdbtNoteNo: TQRDBText;
    QRImage1: TQRImage;
    qrdbt_BarCode: TQRDBText;
    qrgNoteNo: TQRGroup;
    QRSubDetail1: TQRSubDetail;
    qrdbt14: TQRDBText;
    qrs1: TQRShape;
    qrdbt9: TQRDBText;
    qrdbt12: TQRDBText;
    qrdbt13: TQRDBText;
    QRSubDetail2: TQRSubDetail;
    qrl4: TQRLabel;
    qrl8: TQRLabel;
    qrs8: TQRShape;
    QRSubDetail3: TQRSubDetail;
    qrs10: TQRShape;
    qtqrdbt8: TQRDBText;
    qtqrdbt10: TQRDBText;
    qtqrdbt11: TQRDBText;
    PageFooterBand1: TQRBand;
    qrl12: TQRLabel;
    qrl16: TQRLabel;
    qrl17: TQRLabel;
    qrl18: TQRLabel;
    qrlOperator: TQRLabel;
    QRSysData2: TQRSysData;
    QRBand2: TQRBand;
    qrdbt5: TQRDBText;
    qrdbtGFNo: TQRDBText;
    qrdbt2: TQRDBText;
    qrdbtRemark: TQRDBText;
    qrdbtWidth: TQRDBText;
    qrdbt3: TQRDBText;
    qrdbtGrade: TQRDBText;
    qrdbtQuantity: TQRDBText;
    qrdbt6: TQRDBText;
    qrdbtDeliveryDate: TQRDBText;
    qrdbt7: TQRDBText;
    qrdbt4: TQRDBText;
    QRLabel2: TQRLabel;
    qt_Remark: TQRDBText;
    cdsHLInfo: TClientDataSet;
    cdsArtDetail: TClientDataSet;
    cdsMaster: TClientDataSet;
    //预览报表
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure PreviewReport(var sCard_NO:string;sCar_NO: string;Preview:Boolean);
  end;

var
  HLCardReport: THLCardReport;

implementation

uses StrUtils, uShowMessage, ServerDllPub, uLogin, UAppOption, uGlobal;

{$R *.dfm}

procedure THLCardReport.PreviewReport(var sCard_NO: string;sCar_NO:string ;Preview:Boolean);
var
  vData:Olevariant;
  sCondition,sErrorMsg: WideString;
  ColorStr: String;
begin
  if Preview then
    sCondition := QuotedStr(sCard_NO)+',2,'+ QuotedStr(Login.CurrentDepartment)+','+ QuotedStr('')
  else
    sCondition := QuotedStr(sCard_NO)+',2,'+ QuotedStr(Login.CurrentDepartment)+','+ QuotedStr(Login.LoginID);
  FNMServerObj.GetQueryData(vData,'GetReport',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  cdsMaster.Data := vData[0];
  cdsHLInfo.Data := vData[1];
  cdsArtDetail.Data := vData[2];
  self.qrlOperator.Caption:=Login.LoginName;
  qrFNCard.Prepare;
  ColorStr:='白色';
  if cdsMaster['Fluorescence'] = 'FF' then
    ColorStr:='红色';
  if cdsMaster['Fluorescence'] = 'FP' then
    ColorStr:='灰色';

  ShowMessage(Format('请放入%s手织板卡!', [ColorStr]));
  if Preview then
    qrFNCard.Preview
  else
    qrFNCard.Print;
end;

procedure THLCardReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure THLCardReport.FormDestroy(Sender: TObject);
begin
  HLCardReport:=nil;
end;

procedure THLCardReport.FormCreate(Sender: TObject);
begin
  with qrdbt_BarCode.Font do
  begin
    Name:='C39HrP24DhTt';
    Size:=30;
  end;
end;

end.

