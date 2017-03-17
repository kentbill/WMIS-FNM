unit rptCPB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, QRCTRLS, QUICKRPT, ExtCtrls, DBClient, jpeg, Provider,
  ADODB, StdCtrls;

type
  TCPBReport = class(TForm)
    cdsMaster: TClientDataSet;
    qrCPBInfo: TQuickRep;
    qrgNoteNo: TQRGroup;
    QRBand1: TQRBand;
    qrlCompany: TQRSysData;
    qrl2: TQRLabel;
    qrl14: TQRLabel;
    QRImage1: TQRImage;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape33: TQRShape;
    cdsChemical: TClientDataSet;
    QRSysData1: TQRSysData;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel10: TQRLabel;
    qrdbt8: TQRDBText;
    QRShape1: TQRShape;
    QRShape22: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel9: TQRLabel;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRLabel11: TQRLabel;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRLabel12: TQRLabel;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    QRShape13: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape2: TQRShape;
    qrs1: TQRShape;
    qrl4: TQRLabel;
    qrl10: TQRLabel;
    qrl5: TQRLabel;
    qrl9: TQRLabel;
    QRLabel1: TQRLabel;
    qrl13: TQRLabel;
    qrdbtFN_Card: TQRDBText;
    qrdbtGFNo: TQRDBText;
    qrdbtQuantity: TQRDBText;
    QRDBText2: TQRDBText;
    qrdbtRemark: TQRDBText;
    QRLabel7: TQRLabel;
    QRDBText4: TQRDBText;
    QRLabel2: TQRLabel;
    QRShape10: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape9: TQRShape;
    QRLabel19: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel16: TQRLabel;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRLabel18: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel26: TQRLabel;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRShape27: TQRShape;
    QRShape28: TQRShape;
    qrl22: TQRLabel;
    qrl23: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRDBText17: TQRDBText;
    QRDBText18: TQRDBText;
    QRDBText19: TQRDBText;
    QRLabel73: TQRLabel;
    QRLabel74: TQRLabel;
    QRDBText42: TQRDBText;
    QRLabel75: TQRLabel;
    QRDBText10: TQRDBText;
    QRShape53: TQRShape;
    QRShape54: TQRShape;
    QRShape48: TQRShape;
    QRShape45: TQRShape;
    QRShape46: TQRShape;
    QRLabel23: TQRLabel;
    QRShape26: TQRShape;
    QRShape29: TQRShape;
    QRLabel25: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRShape30: TQRShape;
    QRShape31: TQRShape;
    QRShape32: TQRShape;
    QRShape34: TQRShape;
    QRShape35: TQRShape;
    QRLabel38: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRShape36: TQRShape;
    QRLabel41: TQRLabel;
    QRShape37: TQRShape;
    QRShape38: TQRShape;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    QRLabel45: TQRLabel;
    QRLabel46: TQRLabel;
    QRLabel47: TQRLabel;
    QRShape39: TQRShape;
    QRShape40: TQRShape;
    QRShape41: TQRShape;
    QRShape42: TQRShape;
    QRShape43: TQRShape;
    QRLabel48: TQRLabel;
    QRLabel50: TQRLabel;
    QRShape44: TQRShape;
    QRLabel49: TQRLabel;
    QRLabel51: TQRLabel;
    QRLabel52: TQRLabel;
    QRLabel53: TQRLabel;
    QRLabel54: TQRLabel;
    QRLabel55: TQRLabel;
    QRShape47: TQRShape;
    QRShape50: TQRShape;
    QRLabel56: TQRLabel;
    QRLabel57: TQRLabel;
    QRShape52: TQRShape;
    QRLabel58: TQRLabel;
    QRLabel59: TQRLabel;
    QRShape49: TQRShape;
    QRShape51: TQRShape;
    QRLabel60: TQRLabel;
    QRLabel61: TQRLabel;
    QRLabel62: TQRLabel;
    QRLabel63: TQRLabel;
    QRLabel64: TQRLabel;
    QRLabel65: TQRLabel;
    QRLabel66: TQRLabel;
    QRLabel67: TQRLabel;
    QRLabel68: TQRLabel;
    QRLabel69: TQRLabel;
    QRDBText20: TQRDBText;
    QRDBText21: TQRDBText;
    QRDBText22: TQRDBText;
    QRDBText23: TQRDBText;
    QRDBText24: TQRDBText;
    QRDBText25: TQRDBText;
    QRDBText26: TQRDBText;
    QRDBText27: TQRDBText;
    QRDBText28: TQRDBText;
    QRDBText29: TQRDBText;
    QRDBText30: TQRDBText;
    QRDBText31: TQRDBText;
    QRDBText32: TQRDBText;
    QRDBText33: TQRDBText;
    QRDBText34: TQRDBText;
    QRDBText35: TQRDBText;
    QRDBText36: TQRDBText;
    QRDBText37: TQRDBText;
    QRDBText38: TQRDBText;
    QRDBText39: TQRDBText;
    QRLabel70: TQRLabel;
    QRLabel71: TQRLabel;
    QRLabel72: TQRLabel;
    QRDBText40: TQRDBText;
    QRDBText41: TQRDBText;
    QRShape55: TQRShape;
    QRShape56: TQRShape;
    QRLabel32: TQRLabel;
    QRLabel76: TQRLabel;
    QRLabel77: TQRLabel;
    QRLabel78: TQRLabel;
    QRDBText43: TQRDBText;
    QRDBText44: TQRDBText;
    QRDBText45: TQRDBText;
    QRDBText46: TQRDBText;
    QRDBText47: TQRDBText;
    qrOKRecipe: TQuickRep;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    qrl1: TQRLabel;
    qrs2: TQRShape;
    qrs3: TQRShape;
    qrs4: TQRShape;
    qrs5: TQRShape;
    qrs6: TQRShape;
    qrs7: TQRShape;
    qrs8: TQRShape;
    qrs9: TQRShape;
    qrl6: TQRLabel;
    qrs10: TQRShape;
    qrs11: TQRShape;
    qrs12: TQRShape;
    qrs13: TQRShape;
    qrs14: TQRShape;
    qrs15: TQRShape;
    qrs16: TQRShape;
    qrs17: TQRShape;
    qrl7: TQRLabel;
    qrl8: TQRLabel;
    qrl11: TQRLabel;
    qrs18: TQRShape;
    qrs19: TQRShape;
    qrl12: TQRLabel;
    qrl15: TQRLabel;
    qrl16: TQRLabel;
    qrl17: TQRLabel;
    qrl18: TQRLabel;
    qrl19: TQRLabel;
    qrl20: TQRLabel;
    qrl21: TQRLabel;
    qrl24: TQRLabel;
    qrl25: TQRLabel;
    qrl26: TQRLabel;
    qrl27: TQRLabel;
    qrl28: TQRLabel;
    qrl29: TQRLabel;
    qrl30: TQRLabel;
    qrl31: TQRLabel;
    qrl32: TQRLabel;
    qrl33: TQRLabel;
    qrl34: TQRLabel;
    qrsRiShai: TQRShape;
    qrsMoCa: TQRShape;
    qrsWeiBo: TQRShape;
    qrsShuiXi: TQRShape;
    qrsDuiZhi: TQRShape;
    qrsInnerOK: TQRShape;
    qrsCustomerOK: TQRShape;
    qrl35: TQRLabel;
    qrl36: TQRLabel;
    qrdbt1: TQRDBText;
    qrdbt2: TQRDBText;
    qrdbt3: TQRDBText;
    qrdbt4: TQRDBText;
    qrdbt5: TQRDBText;
    qrdbt6: TQRDBText;
    qrdbt7: TQRDBText;
    qrdbt9: TQRDBText;
    qrdbt10: TQRDBText;
    qrdbt11: TQRDBText;
    qrdbt12: TQRDBText;
    qrdbt13: TQRDBText;
    QRLabel79: TQRLabel;
    QRShape57: TQRShape;
    QRLabel80: TQRLabel;
    QRDBText48: TQRDBText;
    QRLabel81: TQRLabel;
    qrdbtNoteNo: TQRDBText;
    QRShape58: TQRShape;
    QRLabel82: TQRLabel;
    QRDBText49: TQRDBText;
    QRLabel83: TQRLabel;
    QRDBText50: TQRDBText;
    QRLabel84: TQRLabel;
    QRDBText51: TQRDBText;
    QRShape59: TQRShape;
    QRShape60: TQRShape;
    QRShape3: TQRShape;
    QRDBText52: TQRDBText;
    QRDBText53: TQRDBText;
    QRDBText54: TQRDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure cdsMasterAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    sOKType:String;
    procedure PreviewReport(Recipe_NO: string;Preview:Boolean);
    //cuijf 2009-11-22 OK处方存档卡
    procedure PreivewCPBOKRecipeReport(Recipe_NO: string;Preview:Boolean);
  end;

var
  CPBReport: TCPBReport;

implementation

uses uShowMessage,ServerDllPub, uLogin, UAppOption, uGlobal;

{$R *.dfm}

procedure TCPBReport.PreviewReport(Recipe_NO: string;Preview:Boolean);
var
  vData:Olevariant;
  sCondition,sErrorMsg:WideString;
begin
  //提取配方记录
  if Trim(Recipe_NO)= '' then Exit;
  sCondition := QuotedStr(Recipe_NO)+',4,'+ QuotedStr(Login.CurrentDepartment)+','+ QuotedStr(Login.LoginID);
  FNMServerObj.GetQueryData(vData,'GetReport',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  cdsMaster.Data := vData[0];
  cdsChemical.Data := vData[1];
  qrCPBInfo.Prepare;
  if Preview then
    qrCPBInfo.Preview
  else
    qrCPBInfo.Print;
end;

procedure TCPBReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TCPBReport.FormDestroy(Sender: TObject);
begin
  CPBReport:=nil;
end;

procedure TCPBReport.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if cdsChemical.FieldByName('Chemical_Type').AsString = 'CPB染料' then
  begin
    QRDBText1.Font.Style := [fsBold];
    QRDBText5.Font.Style := [fsBold];
    QRDBText6.Font.Style := [fsBold];
    QRDBText7.Font.Style := [fsBold];
    QRDBText8.Font.Style := [fsBold];
    QRDBText9.Font.Style := [fsBold];
  end else
  begin
    QRDBText1.Font.Style := [];
    QRDBText5.Font.Style := [];
    QRDBText6.Font.Style := [];
    QRDBText7.Font.Style := [];
    QRDBText8.Font.Style := [];
    QRDBText9.Font.Style := [];
  end;
  if cdsChemical.FieldByName('Unit').AsString = 'ml/l' then
  begin
    QRDBText8.Color := clSilver;
    QRShape54.Brush.Color := clSilver;
  end else
  begin
    QRDBText8.Color := clWhite;
    QRShape54.Brush.Color := clWhite;
  end;
end;

procedure TCPBReport.PreivewCPBOKRecipeReport(Recipe_NO: string;
  Preview: Boolean);
var
  vData:Olevariant;
  sCondition,sErrorMsg:WideString;
begin
  //提取配方记录
  if Trim(Recipe_NO)= '' then Exit;
  sCondition := QuotedStr(Recipe_NO)+','+ QuotedStr(Login.CurrentDepartment);
  FNMServerObj.GetQueryData(vData,'cpbGetOKRecipeInfo',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  cdsMaster.Data := vData[0];
  cdsChemical.Data := vData[1];
  qrOKRecipe.Prepare;
  if Preview then
    qrOKRecipe.Preview
  else
    qrOKRecipe.Print;
end;

procedure TCPBReport.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  sLaoDu:String;
begin
  if sOKType= '客户OK' then
      qrsCustomerOK.Brush.Color := clBlack
  else //内部OK
      qrsInnerOK.Brush.Color := clBlack;

  sLaoDu := cdsMaster.FieldByName('LaoDu').AsString;

  if pos('日晒牢度',sLaoDu)>0 then
    qrsRiShai.Brush.Color := clBlack;
  if pos('摩擦牢度',sLaoDu)>0 then
    qrsMoCa.Brush.Color := clBlack;
  if pos('水洗牢度',sLaoDu)>0 then
    qrsShuiXi.Brush.Color := clBlack;

  if pos('微波', cdsMaster.FieldByName('Dye_Type').AsString)>0 then
    qrsWeiBo.Brush.Color := clBlack;
  if pos('堆置', cdsMaster.FieldByName('Dye_Type').AsString)>0 then
    qrsDuiZhi.Brush.Color := clBlack; 
end;

procedure TCPBReport.cdsMasterAfterOpen(DataSet: TDataSet);
var
  sFNCardStr,sCardNo,sNewCardStr: String;
  i,iPos,iCount: integer;
begin
  with Dataset do
  begin
    sFNCardStr:=  FieldByName('FNCardStr').Asstring + ',';
    sCardNo:= '';
    iCount:= 0;
    sNewCardStr:= '';
    if sFNCardStr <> '' then
    begin
      while (Pos(',',sFNCardStr) > 0) do
      begin
        iPos:= Pos(',',sFNCardStr);
        if iPos > 0 then
        begin
          inc(iCount);
          sCardNo:= Copy(sFNCardStr,1,iPos);
          if (iCount mod 10)  = 0 then    //卡号，10个卡号一行
            sNewCardStr:= sNewCardStr + sCardNo + #13
          else
            sNewCardStr:= sNewCardStr + sCardNo;
          sFNCardStr:= Copy(sFNCardStr,iPos+1 ,Length(sFNCardStr)-iPos);
        end;
      end;
    end;
    Edit;
    FieldByName('FNCardStr').Asstring:= sNewCardStr;
  end;
end;

end.

