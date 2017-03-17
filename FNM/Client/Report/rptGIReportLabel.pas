unit rptGIReportLabel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, QRCtrls, QuickRpt, ExtCtrls;

type
  TGIReportLabelForm = class(TForm)
    CDS_Report: TClientDataSet;
    qkrpLabel: TQuickRep;
    ColumnHeaderBand1: TQRBand;
    QRDBText1: TQRDBText;
    qrdbt6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText18: TQRDBText;
    QRDBText19: TQRDBText;
    QRDBText20: TQRDBText;
    qrdbt8: TQRDBText;
    qrdbt9: TQRDBText;
    qrdbt7: TQRDBText;
    qrdbt10: TQRDBText;
    qrdbt11: TQRDBText;
    qrdbt1: TQRDBText;
    QRDBTFab_Color_Code: TQRDBText;
    ColumnHeaderBand2: TQRBand;
    QRDBText23: TQRDBText;
    qrdbt2: TQRDBText;
    qrex1: TQRExpr;
    procedure FormDestroy(Sender: TObject);
    procedure qkrpLabelBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrdbt7Print(sender: TObject; var Value: String);
    procedure qrdbt9Print(sender: TObject; var Value: String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Material_Quality, Organic_Flag :String;
  public
    { Public declarations }
  end;

var
  GIReportLabelForm: TGIReportLabelForm;

implementation

{$R *.dfm}

procedure TGIReportLabelForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := cafree;
end;

procedure TGIReportLabelForm.FormDestroy(Sender: TObject);
begin
  GIReportLabelForm := nil;
end;

procedure TGIReportLabelForm.qkrpLabelBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  if CDS_Report.FieldByName('Shade').Value='' then
     qrex1.Visible:=false;
end;

procedure TGIReportLabelForm.qrdbt7Print(sender: TObject; var Value: String);
begin
   if Material_Quality='正常布' then
     begin
       if Organic_Flag='Y' then
         begin
           Value:='有机';
         end
       else
         Value :=''
     end
   else
     begin
       if Organic_Flag='Y' then
         begin
           Value:=Value+''+'有机';
         end;
     end;
end;

procedure TGIReportLabelForm.qrdbt9Print(sender: TObject; var Value: String);
begin
   Material_Quality := CDS_Report.FieldByName('Material_Quality').Value;
   Organic_Flag := CDS_Report.FieldByName('Organic_Flag').Value;
end;

end.
