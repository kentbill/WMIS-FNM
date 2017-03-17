unit rptFNCard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBClient, QuickRpt, jpeg, QRCtrls, ExtCtrls,StrUtils;

type
  TFNCardReport = class(TForm)
    qrFNCard: TQuickRep;
    QRBand1: TQRBand;
    qrlUrgentType: TQRLabel;
    qrCutCloth: TQRLabel;
    qrWVIsFinished: TQRLabel;
    qrl3: TQRLabel;
    qrdbtNoteNo: TQRDBText;
    QRImage1: TQRImage;
    qrdbt_CardBar: TQRDBText;
    qrMaterial_Quality: TQRLabel;
    qrDateTime: TQRLabel;
    QRBand2: TQRBand;
    qrdbtCombo: TQRDBText;
    qrdbt5: TQRDBText;
    qrdbtGFNo: TQRDBText;
    qrdbt2: TQRDBText;
    qrdbtWidth: TQRDBText;
    qrdbt3: TQRDBText;
    qrdbtGrade: TQRDBText;
    qrdbtQuantity: TQRDBText;
    qrdbt6: TQRDBText;
    qrdbtDeliveryDate: TQRDBText;
    qrdbt7: TQRDBText;
    qrWhiteType: TQRLabel;
    qrgNoteNo: TQRGroup;
    QRSubDetail1: TQRSubDetail;
    qrdbtFabric_NO: TQRDBText;
    QRSubDetail3: TQRSubDetail;
    qrdbt8: TQRDBText;
    qrdbt10: TQRDBText;
    qrdbt11: TQRDBText;
    qrs10: TQRShape;
    GroupHeaderBand1: TQRBand;
    qrl4: TQRLabel;
    qrl8: TQRLabel;
    qrs8: TQRShape;
    cdsMaster: TClientDataSet;
    cdsDetail: TClientDataSet;
    cdsArtDetail: TClientDataSet;
    QRLabel2: TQRLabel;
    qt_Remark: TQRDBText;
    QRDBText1: TQRDBText;
    qrlOrganic: TQRLabel;
    cdsCheck: TClientDataSet;
    qrWT: TQRLabel;
    qrTQOR: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabCarNo: TQRLabel;
    cdstemp: TClientDataSet;
    //预览报表
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNCardReport: TFNCardReport;

procedure PrintFNCard(sCard_NO: string; sCar_NO: string; Count: Integer; Preview: Boolean);

implementation

uses uShowMessage, ServerDllPub, uLogin, UAppOption, uGlobal;

{$R *.dfm}

procedure PrintFNCard(sCard_NO: string; sCar_NO: string; Count: Integer; Preview: Boolean);
var
  Customer,ColorStr,Tips: String;
  sCondition,FN_Art_NO, sErrorMsg: WideString;
  vData,vData1: Olevariant;
  bExists:Boolean;
  msql,mErrorMsg:  WideString;      //Added By Devin Wu 2016/8/24
  mData:  Olevariant;         //Added By Devin Wu 2016/8/24
begin
  bExists := False;
  if FNCardReport = nil then
    FNCardReport:=TFNCardReport.Create(Application);

  if Preview then
    sCondition := QuotedStr(sCard_NO)+',0,'+ QuotedStr(Login.CurrentDepartment)+','+ QuotedStr('')
  else
    sCondition := QuotedStr(sCard_NO)+',0,'+ QuotedStr(Login.CurrentDepartment)+','+ QuotedStr(Login.LoginID);

  FNMServerObj.GetQueryData(vData,'GetReport',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;

  with FNCardReport do
  begin
    cdsMaster.Data := vData[0];
    cdsDetail.Data := vData[1];
    cdsArtDetail.Data := vData[2];

    qrCutCloth.Enabled:=false;
    qrWVIsFinished.Enabled:=false;
    qrlUrgentType.Enabled:=false;
    //qrlOrganic.Enabled := false;
    qrMaterial_Quality.Enabled := sCard_NO[1]='S';
    //Added By Devin Wu 2016/8/24   如果不是处理布,则判断是否是精品单,是精品单,则需打印'精品'字样
    if qrMaterial_Quality.Enabled = False then
    begin
       msql:= 'Declare @GF_ID int  '
              +'  select @GF_ID=GF_ID from PDMDB..tdGFID  where GF_NO = '+quotedStr(cdsMaster.fieldByname('GF_NO').AsString)   //cdsMaster.fieldByname('GF_NO').AsString
              +'  select QCMDB.DBO.UDF_GETCOMPETITIVEPRODUCTS (@GF_ID,'+quotedStr(cdsMaster.fieldByname('Job_No').AsString)+')';
       FNMServerObj.GetQueryBySQL(mData,msql,mErrorMsg);
       if mErrorMsg = '' then
       begin
         cdstemp.Data:= mData;
         if cdstemp.Fields[0].AsString <> '' then
         begin
           qrMaterial_Quality.Enabled:= True;
           qrMaterial_Quality.Caption:= '精品';
         end;
       end;
    end;
    //End
    //打印日期
    qrDateTime.Caption := DateTimeToStr(now);
    if not cdsMaster.FieldByName('Print_Time').IsNull then
      qrDateTime.Caption := cdsMaster.FieldByName('Print_Time').AsString;

    qrCutCloth.Enabled:=cdsMaster.FieldByName('Is_Cut_Cloth').AsBoolean;

    if not qrCutCloth.Enabled then
      qrWVIsFinished.Enabled:=cdsMaster.FieldByName('WV_IsFinished').AsString = 'Y';

    if not qrWVIsFinished.Enabled then
    begin
      qrlUrgentType.Enabled:=cdsMaster.FieldByName('Urgent_Type').AsString <> '';
      if qrlUrgentType.Enabled then
      begin
        qrlUrgentType.Caption := cdsMaster.FieldByName('Urgent_Type').AsString;
        qrlUrgentType.BringToFront;
      end;
    end;

    //qrlOrganic.Enabled := cdsMaster.FieldByName('Is_Organic').AsInteger=1;
    qrlOrganic.Caption :=cdsMaster.FieldByName('Organic').AsString;

    //2014-12-22 APJ Zhaogang Add 车号 
    QRLabCarNo.Caption := '车号: ' + sCar_NO;

    FN_Art_NO := Trim(cdsMaster.FieldByName('FN_Art_NO').AsString);
    qrWhiteType.Caption := FN_Art_NO + cdsMaster.FieldByName('White_Type').AsString;
    qrWT.Caption := cdsMaster.FieldByName('White_Type').AsString;
    if Pos('TQ',cdsMaster.FieldByName('TQOR').AsString) > 0 then
      qrTQOR.Caption := 'TQ色'
    else if Pos('OR',cdsMaster.FieldByName('TQOR').AsString) > 0 then
      qrTQOR.Caption := 'OR色'
    else if Pos('RD',cdsMaster.FieldByName('TQOR').AsString) > 0 then
      qrTQOR.Caption := 'RD色'
    else if Pos('GN',cdsMaster.FieldByName('TQOR').AsString) > 0 then
      qrTQOR.Caption := 'GN色'
    else
      qrTQOR.Caption := '';

    //qrlOperator.Caption := Login.LoginName;

    ColorStr:='【白色】';
    if Pos('FF', FN_Art_NO) > 0 then
      ColorStr:='【红色】';
    if (Pos('FP', FN_Art_NO) > 0) and (Pos('FF', FN_Art_NO) = 0) then
      ColorStr:='【灰色】';
    if cdsMaster.FieldByName('White_Type').AsString = '加白' then
      ColorStr:='【特白】';
    //起毛卡专用
    if cdsMaster.FieldByName('Process_Method').AsInteger = 3 then
      ColorStr:='起毛布专用' +ColorStr;

//    不是找当前卡，是找对应布号之前的卡      
//    //如果是返工卡，工序里面有 定型加白 工序的 提示放 特白卡
//    cdsArtDetail.Filter := 'Operation_CHN like ''%定型加白%'' OR Operation_CHN like ''%过酸%''';
//    cdsArtDetail.Filtered := True;
//    if AnsiStartsStr('F', sCard_NO) and (cdsArtDetail.RecordCount > 0) then
//      ColorStr:='【特白】';
//    cdsArtDetail.Filter := '';
//    cdsArtDetail.Filtered := False;
    sCondition := QuotedStr(sCard_NO);
    FNMServerObj.GetQueryData(vData1,'CheckColor',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    cdsCheck.Data := vData1;
    if cdsCheck.RecordCount > 0 then
    begin
      //ColorStr:='【特白】';
      cdsMaster.Edit;
      if cdsMaster.FieldByName('Art_Remark').AsString <> '' then
          cdsMaster.FieldByName('Art_Remark').AsString := cdsMaster.FieldByName('Art_Remark').AsString + Char(13) + Char(10) + '后整加荧光品种'
      else
          cdsMaster.FieldByName('Art_Remark').AsString := cdsMaster.FieldByName('Art_Remark').AsString + '后整加荧光品种';
      cdsMaster.UpdateRecord;
    end;

    Tips := '';
    Customer := cdsMaster.FieldByName('Customer').AsString;
    if ((pos('Express',Customer)>0) or (pos('MUJI',Customer)>0))
       and (Pos('BP', FN_Art_NO) > 0) then
      Tips := Customer + '防荧光,请盖防荧光章';
    //QRSysData1.BringToFront;
    if Preview then
      qrFNCard.Preview
    else
    begin
      //qrFNCard.Preview;
      if (Tips <>'') then
        ShowMessage(Tips);
      ShowMessage(Format('请放入 %s 后整理卡!', [ColorStr]));
      qrFNCard.Print;

      if Count = 1 then Exit;

      // 2014-11-17  取消第二次打卡  fangy  --BEGIN ---
      //if (Tips <>'') then
      //  ShowMessage(Tips);
      //ShowMessage(Format('请放入 %s 后整理卡!', [ColorStr]));
      //qrFNCard.Print;
      // 2014-11-17  取消第二次打卡  fangy  --END ---

    end;
  end;
end;

procedure TFNCardReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFNCardReport.FormDestroy(Sender: TObject);
begin
  FNCardReport := nil;
end;

procedure TFNCardReport.FormCreate(Sender: TObject);
begin
//  with qrdbt_CardBar.Font do
//  begin
//    Name:='C39HrP24DhTt';
//    Size:=30;
//  end;
  qrCutCloth.Font.Size:=36;
  qrWVIsFinished.Font.Size:=36;
  qrlUrgentType.Font.Size:=36;
  qrlOrganic.Font.Size := 36;
  qrCutCloth.Top:=qrlUrgentType.Top;
  qrWVIsFinished.Top:=qrlUrgentType.Top;

  qrWT.Font.Size :=30;
  qrWT.Top := qrlUrgentType.Top;

  qrTQOR.Font.Size :=26;
  qrTQOR.Top := qrlUrgentType.Top;
end;

end.

