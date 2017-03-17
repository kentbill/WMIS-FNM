unit rptSectionFabricLabel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, DBClient;

type
  TSectionFabricReportForm = class(TForm)
    CDS_Report: TClientDataSet;
    qrSectFabric: TQuickRep;
    QRBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel8: TQRLabel;
    QRExpr3: TQRExpr;
    QRLabel11: TQRLabel;
    QRShape20: TQRShape;
    QRLabel16: TQRLabel;
    QRExpr11: TQRExpr;
    QRDBText1: TQRDBText;
    QRShape28: TQRShape;
    QRLabel19: TQRLabel;
    QRShape31: TQRShape;
    QRExpr16: TQRExpr;
    QRDBText2: TQRDBText;
    QRLabel21: TQRLabel;
    QRShape32: TQRShape;
    QRShape35: TQRShape;
    QRLabel27: TQRLabel;
    QRShape44: TQRShape;
    QRShape45: TQRShape;
    QRExpr1: TQRExpr;
    QRShape7: TQRShape;
    QRShape24: TQRShape;
    QRDBText3: TQRDBText;
    cdsEANCode: TClientDataSet;
    procedure QRDBText3Print(sender: TObject; var Value: String);
  private
    function GetBarCodeStr(Barcode: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SectionFabricReportForm: TSectionFabricReportForm;

implementation

{$R *.dfm}


function TSectionFabricReportForm.GetBarCodeStr(Barcode: string): string;
{
Left Hand A	Left Hand B	Right Hand	First flaq	Second flag	Check
0	@	P	!	`	p	Left Guard
1	A	Q	"	a	q	Center Guard
2	B	R	#	b	r	Right Guard
3	C	S	$	c	s
4	D	T	%	d	t
5	E	U	&	e	u
6	F	V		f	v
7	G	W	(	g	w
8	H	X	)	h	x
9	I	Y	*	i	y

}
  function CheckSumModulo10(const data:string):string;
    var i,fak,sum : Integer;
  begin
    sum := 0;
    fak := Length(data);
    for i:=1 to Length(data) do
    begin
      if (fak mod 2) = 0 then
        sum := sum + (StrToInt(data[i])*1)
      else
        sum := sum + (StrToInt(data[i])*3);
      dec(fak);
    end;
    if (sum mod 10) = 0 then
      result := data+'0'
    else
      result := data+IntToStr(10-(sum mod 10));
  end;

  function vFirst_Flag_Sequence(i:Integer):Integer;
  var
    y:Integer;
  begin
    case i of
      0: y:=0;
      1: y:=11;
      2: y:=13;
      3: y:=14;
      4: y:=19;
      5: y:=25;
      6: y:=28;
      7: y:=21;
      8: y:=22;
      9: y:=26;
    end;
    Result:=y;
  end;
var
  tempstr,newstr,tmpchar:string;
  i,y:Integer;
begin
  tempstr:=CheckSumModulo10(Barcode);
  i:=1;
  while i<=13 do
  begin
    tmpchar:=Copy(tempstr,i,1);
    cdsEANCode.Locate('char_Data',tmpchar,[]);
    if i=1 then
      newstr:=cdsEANCode.fieldbyname('First_Flag').AsString;
    if i=2 then
      newstr:=newstr+cdsEANCode.fieldbyname('Second_Flag').AsString;
    if (i>=3) and (i<=7) then
    begin
      case i of
      //      (Exp(Ln(2)*(7-i)))
        3:y:=16;
        4:y:=8;
        5:y:=4;
        6:y:=2;
        7:y:=1;
      end;
      //Î»ÔËËã  
      if ((vFirst_Flag_Sequence(StrToInt(copy(tempstr,1,1))) and y)<>0)  then
         newstr:=newstr+cdsEANCode.fieldbyname('Left_Hand_B').AsString
       else
         newstr:=newstr+cdsEANCode.fieldbyname('Left_Hand_A').AsString;
       if i=7 then
         newstr:=newstr+'|';
    end;
    if (i>=8) and (i<=12) then
      newstr:=newstr+cdsEANCode.fieldbyname('Right_Hand').AsString;
    if i=13 then
      newstr:=newstr+cdsEANCode.fieldbyname('Check').AsString;
    Inc(i);
  end;
  result:=newstr;

end;

procedure TSectionFabricReportForm.QRDBText3Print(sender: TObject;
  var Value: String);
var
  BarCode:string;
begin
  if not cdsEANCode.Active then
      cdsEANCode.LoadFromFile('barcode.xml');
   BarCode:= CDS_Report.FieldByName('Bar_Code').Value;
   Value:=GetBarCodeStr(BarCode);
end;

end.
