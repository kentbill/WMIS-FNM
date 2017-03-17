unit rptRecipe;

interface

uses
  DB,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, jpeg, DBClient;

type
  TRecipeReport = class(TForm)
    qr1: TQuickRep;
    TitleBand1: TQRBand;
    qrl1: TQRLabel;
    QRSysData1: TQRSysData;
    qrs21: TQRShape;
    qrl17: TQRLabel;
    qrl18: TQRLabel;
    qrl19: TQRLabel;
    qrl21: TQRLabel;
    qrl20: TQRLabel;
    qrl16: TQRLabel;
    qrlCompany: TQRSysData;
    QRImage1: TQRImage;
    qrdbt_RecipeNO: TQRDBText;
    qrdbt_Quantity: TQRDBText;
    qrdbt_PrescriptionNO: TQRDBText;
    qrdbt_VolumeQTY: TQRDBText;
    qrdbt_Machine: TQRDBText;
    qrl24: TQRLabel;
    qrdbt1: TQRDBText;
    qrdbt_BarCode: TQRDBText;
    QRLabel1: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel2: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel4: TQRLabel;
    QRDBText4: TQRDBText;
    QRLabel5: TQRLabel;
    QRDBText5: TQRDBText;
    QRLabel6: TQRLabel;
    QRDBText6: TQRDBText;
    QRLabel7: TQRLabel;
    QRDBText7: TQRDBText;
    QRLabel8: TQRLabel;
    QRDBText8: TQRDBText;
    QRLabel9: TQRLabel;
    QRDBText9: TQRDBText;
    PageFooterBand1: TQRBand;
    qrl22: TQRLabel;
    qrl23: TQRLabel;
    qrl25: TQRLabel;
    QRSysData2: TQRSysData;
    qrdbt_Operator: TQRDBText;
    qrdbt_Check: TQRDBText;
    QRSubDetail1: TQRSubDetail;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    qrl8: TQRLabel;
    qrl9: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRSubDetail2: TQRSubDetail;
    qrdbt_Iden1: TQRDBText;
    qrdbt_Chemical1: TQRDBText;
    qrdbt_QTY1: TQRDBText;
    qrdbt_Weigh1: TQRDBText;
    qrdbt_Iden2: TQRDBText;
    qrdbt_Chemical2: TQRDBText;
    qrdbt_QTY2: TQRDBText;
    qrdbt_Weigh2: TQRDBText;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRSubDetail5: TQRSubDetail;
    QRSubDetail3: TQRSubDetail;
    qrs16: TQRShape;
    qrl10: TQRLabel;
    qrl11: TQRLabel;
    qrl13: TQRLabel;
    QRSubDetail4: TQRSubDetail;
    qrs19: TQRShape;
    qrdbt_GFNO1: TQRDBText;
    qrdbt_FNCard1: TQRDBText;
    qrdbt_FNCardQTY1: TQRDBText;
    QRSubDetail6: TQRSubDetail;
    QRLabel3: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    cds_RecipeHdr: TClientDataSet;
    cds_RecipeDtl: TClientDataSet;
    cds_IncludeCard: TClientDataSet;
    QRLabel10: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRShape17: TQRShape;
    QRDBText10: TQRDBText;
    QRShape18: TQRShape;
    QRLabel17: TQRLabel;
    QRDBText11: TQRDBText;
    QRShape19: TQRShape;
    QRDBText12: TQRDBText;
    procedure FormCreate(Sender: TObject);
    procedure QRSubDetail2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RecipeReport: TRecipeReport;

procedure PreViewRecipeReport(RecipeNO: String; Preview:Boolean);

implementation

uses
  ServerDllPub, uDictionary, uShowMessage, uLogin;
{$R *.dfm}

procedure PreViewRecipeReport(RecipeNO: String; Preview:Boolean);
var
  sCondition,sErrorMsg: WideString;
  BatchIndex, ChemicalIndex: Integer;
  vData: Olevariant;
begin
  sCondition := QuotedStr(RecipeNO)+',3,'+ QuotedStr(Login.CurrentDepartment)+','+ QuotedStr(Login.LoginID);
  FNMServerObj.GetQueryData(vData,'GetReport',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
  end;
  if RecipeReport = nil then
    RecipeReport:=TRecipeReport.Create(Application);

  with RecipeReport do
  begin
    cds_RecipeHdr.Data:=vData[0];
    if cds_RecipeDtl.Active then
      cds_RecipeDtl.EmptyDataSet;
    TempClientDataSet.Data:=vData[1];
    cds_IncludeCard.Data:=vData[2];

    BatchIndex:=0; ChemicalIndex:=0;
    TempClientDataSet.First;
    while not TempClientDataSet.Eof do
    begin
      cds_RecipeDtl.Append;
      if TempClientDataSet['RecType'] = 'B' then
      begin
        BatchIndex:=BatchIndex + 1;
        ChemicalIndex:=0;
        cds_RecipeDtl['Iden1']:=BatchIndex;
      end
      else
      begin
        ChemicalIndex:= ChemicalIndex + 1;
        cds_RecipeDtl['Iden1']:=ChemicalIndex;
      end;
      cds_RecipeDtl['Chemical_Name1']:=TempClientDataSet['Chemical_Name'];
      cds_RecipeDtl['Unit_QTY1']:=TempClientDataSet['Unit_QTY'];
      cds_RecipeDtl['Dosage1']:=TempClientDataSet['Dosage'];
      if TempClientDataSet['RecType'] = 'B' then
      begin
        TempClientDataSet.Next;
        ChemicalIndex:=0;
        Continue;
      end;
      TempClientDataSet.Next;

      if TempClientDataSet['RecType'] = 'B' then Continue;
      if TempClientDataSet.Eof then Continue;

      ChemicalIndex:= ChemicalIndex + 1;
      cds_RecipeDtl['Iden2']:=ChemicalIndex;
      cds_RecipeDtl['Chemical_Name2']:=TempClientDataSet['Chemical_Name'];
      cds_RecipeDtl['Unit_QTY2']:=TempClientDataSet['Unit_QTY'];
      cds_RecipeDtl['Dosage2']:=TempClientDataSet['Dosage'];
      TempClientDataSet.Next;
    end;
    if Preview then
      qr1.Preview
    else
      qr1.Print;
  end;
end;

procedure TRecipeReport.FormCreate(Sender: TObject);
begin
  with cds_RecipeDtl do
  begin
    FieldDefs.Add('Iden1', ftInteger);
    FieldDefs.Add('Chemical_Name1', ftString, 100);
    FieldDefs.Add('Unit_QTY1', ftBCD, 4);
    FieldDefs.Add('Dosage1', ftString, 100);
    FieldDefs.Add('Iden2', ftInteger);
    FieldDefs.Add('Chemical_Name2', ftString, 100);
    FieldDefs.Add('Unit_QTY2', ftBCD, 4);
    FieldDefs.Add('Dosage2', ftString, 100);
    CreateDataSet;
  end;
  with cds_IncludeCard do
  begin
    FieldDefs.Add('GF_NO', ftString, 20);
    FieldDefs.Add('FN_Card', ftString, 9);
    FieldDefs.Add('Quantity', ftBCD, 2);
    CreateDataSet;
  end;
  
  with qrdbt_BarCode.Font do
  begin
    Name:='C39HrP24DhTt';
    Size:=28;
  end;
end;

procedure TRecipeReport.QRSubDetail2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  QRShapeEnable: Boolean;
begin
  QRShapeEnable:=not ((Pos('RB',  cds_RecipeDtl['Chemical_Name1']) = 1) and VarIsNull(cds_RecipeDtl['Chemical_Name2']));
  qrdbt_Iden1.Enabled:=QRShapeEnable;
  QRShape9.Enabled:=QRShapeEnable;
  QRShape10.Enabled:=QRShapeEnable;
  QRShape11.Enabled:=QRShapeEnable;
  QRShape12.Enabled:=QRShapeEnable;
  QRShape13.Enabled:=QRShapeEnable;
  QRShape14.Enabled:=QRShapeEnable;
  QRShape15.Enabled:=QRShapeEnable;
  QRShape16.Enabled:=QRShapeEnable;

  with qrdbt_Chemical1.Font do
  begin
    if QRShapeEnable then
    begin
      Size:=11;
      Style:=Style - [fsBold]
    end else
    begin
      Size:=13;
      Style:=Style + [fsBold];
    end;
  end;
end;

end.
