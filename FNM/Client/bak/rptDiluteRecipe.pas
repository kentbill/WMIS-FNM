unit rptDiluteRecipe;

interface

uses
  DB,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, jpeg, DBClient;

type
  TDiluteRecipeReport = class(TForm)
    qr1: TQuickRep;
    TitleBand1: TQRBand;
    qrl1: TQRLabel;
    QRSysData1: TQRSysData;
    qrs21: TQRShape;
    qrl17: TQRLabel;
    qrl19: TQRLabel;
    qrl16: TQRLabel;
    qrlCompany: TQRSysData;
    QRImage1: TQRImage;
    qrdbt_RecipeNO: TQRDBText;
    qrdbt_BarCode: TQRDBText;
    QRLabel1: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel2: TQRLabel;
    QRDBText2: TQRDBText;
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
    QRSubDetail6: TQRSubDetail;
    QRLabel3: TQRLabel;
    QRDBText3: TQRDBText;
    cds_RecipeHdr: TClientDataSet;
    cds_RecipeDtl: TClientDataSet;
    QRLabel4: TQRLabel;
    QRDBText4: TQRDBText;
    qrdbt_Machine: TQRDBText;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DiluteRecipeReport: TDiluteRecipeReport;

procedure PreViewDiluteRecipeReport(batchNO: String);

implementation

uses
  ServerDllPub, uDictionary,ULogin;
{$R *.dfm}

procedure PreViewDiluteRecipeReport(BatchNO: String);
var
  sErrorMsg: WideString;
  ChemicalIndex: Integer;
  vData0, vData1, vData2: Olevariant;
begin
  if DiluteRecipeReport = nil then
    DiluteRecipeReport:=TDiluteRecipeReport.Create(Application);

  FNMServerObj.GetReportInfo(BatchNO, 4, Login.CurrentDepartment,'', vData0, vData1, vData2, sErrorMsg);
  with DiluteRecipeReport do
  begin
    cds_RecipeHdr.Data:=vData0;
    if cds_RecipeDtl.Active then
      cds_RecipeDtl.EmptyDataSet;
    TempClientDataSet.Data:=vData1;

    ChemicalIndex:=0;
    TempClientDataSet.First;
    while not TempClientDataSet.Eof do
    begin
      cds_RecipeDtl.Append;

      ChemicalIndex:= ChemicalIndex + 1;
      cds_RecipeDtl['Iden1']:=ChemicalIndex;
      cds_RecipeDtl['Chemical_Name1']:=TempClientDataSet['Chemical_Name'];
      cds_RecipeDtl['Unit_QTY1']:=TempClientDataSet['Unit_QTY'];
      cds_RecipeDtl['Dosage1']:=TempClientDataSet['Dosage'];

      TempClientDataSet.Next;
      if TempClientDataSet.Eof then Continue;

      ChemicalIndex:= ChemicalIndex + 1;
      cds_RecipeDtl['Iden2']:=ChemicalIndex;
      cds_RecipeDtl['Chemical_Name2']:=TempClientDataSet['Chemical_Name'];
      cds_RecipeDtl['Unit_QTY2']:=TempClientDataSet['Unit_QTY'];
      cds_RecipeDtl['Dosage2']:=TempClientDataSet['Dosage'];
      TempClientDataSet.Next;
    end;
    qr1.Preview;
  end;
end;

procedure TDiluteRecipeReport.FormCreate(Sender: TObject);
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
  
  with qrdbt_BarCode.Font do
  begin
    Name:='C39HrP24DhTt';
    Size:=28;
  end;
end;

end.
