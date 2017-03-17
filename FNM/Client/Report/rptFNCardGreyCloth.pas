{******************************************************************************

       软件名称 WMIS ——FNM
       文件名称 rptFNCardGreyCloth
       版权所有 (C) 2013 ESQUEL GROUP GET/IT
       创建日期 2013-12-04
       创建人员 APJ zhaogang  爱普京——赵港
       修改人员
       修改日期
       修改原因
       对应用例
       数据库
            	表：
                QCMDB.dbo.fnGreyCloth	
		          相关表：
                FNMDB.DBO.fnProductionList
                PDMDB.DBO.TDGFID
              存储过程：
                QCMDB.dbo.usp_fnGreyClothData
******************************************************************************}       
unit rptFNCardGreyCloth;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBClient, QuickRpt, jpeg, QRCtrls, ExtCtrls,StrUtils;

type
  TFNCardGreyClothReport = class(TForm)
    QuickRep1: TQuickRep;
    PageHeaderBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabFNCard: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabCount: TQRLabel;
    QRLabel6: TQRLabel;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel14: TQRLabel;
    QRSD_ID: TQRSysData;
    QRBand1: TQRBand;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRDBText2: TQRDBText;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRImage1: TQRImage;
    cdsPP: TClientDataSet;
    cdsGC: TClientDataSet;
    procedure QuickRep1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRep1AfterPrint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    GIsPrint : Boolean;                                                         //是否打印标识 默认为False
    procedure PrintGFNOAndFabricNo;                                             //打印品名与布号
    procedure DynamicCreateQRShape(aCol, aRow: Integer);                        //动态生成QRShape
    procedure DynamicCreateQRLabel(aCol, aRow: Integer; aValue : String);       //动态生成QRLabel
  public
    { Public declarations }
  published
    property IsPrint : Boolean read GIsPrint;
  end;

var
  FNCardGreyClothReport: TFNCardGreyClothReport;

implementation

{$R *.dfm}

{ TFNCardGreyClothReport }

procedure TFNCardGreyClothReport.DynamicCreateQRShape(aCol, aRow: Integer);
var
  shape : TQRShape;
begin
  shape := TQRShape.Create(nil);
  shape.Parent := PageHeaderBand1;
  shape.Height := QRShape5.Height;
  shape.Width := QRShape5.Width;
  shape.Left := aCol * (shape.Width - 1);
  shape.Top := QRShape5.Top + QRShape5.Height + (aRow * shape.Height);
  shape.Visible := True;
end;

procedure TFNCardGreyClothReport.DynamicCreateQRLabel(aCol, aRow: Integer; aValue : String);
var
  qLabel : TQRLabel;
begin
  qLabel := TQRLabel.Create(nil);
  qLabel.Parent := PageHeaderBand1;
  qLabel.Height := 13;
  qLabel.Left := 16 + aCol * (QRShape5.Width - 1);
  qLabel.Top := QRShape5.Top + QRShape5.Height + (aRow * QRShape5.Height - 5) + 10;
  qLabel.Caption := aValue;
  qLabel.Visible := True;
end;

procedure TFNCardGreyClothReport.PrintGFNOAndFabricNo;
var
  line : integer;     //记录需要动态生成控件的输出行数
  row, col : integer;//行与列值都是从0开始
begin
  { Col, Row 的概念介绍
    由于该报表由两个明细组成：1、品名、布号； 2、加工工序，所以只能选择其中一个数据集，这里的实现选择了2、加工工序
    
    1、品名、布号的介绍
    品名、布号报表格式为双列显示，QReport无法实现，只能通过动态生成控件。
  }

  if cdsGC.Active then
  begin
    //1计算需要出的行数
    line := cdsGC.RecordCount div 2;
    if (cdsGC.RecordCount mod 2) > 0 then
      Inc(line);
    //2控制输出行数（由于动态QRShape控件，高度、宽度于 QRShape5 一致）
    PageHeaderBand1.Height := PageHeaderBand1.Height + (QRShape5.Height * line);
    //3预先生成右边最后两个QRShape，用于填充网格，因为如果记录数为奇数，则打印页会有缺格子的情况。
    DynamicCreateQRShape(2, line - 1); //等于第三列
    DynamicCreateQRShape(3, line - 1); //等于第四列

    //4通过遍历数据动态生成打印控件和将不同位置的数据输出
    {
              col列
        -----------------------------------------------------------
        |      品名   |      布号    |    品名     |      布号    |
        |---------------------------------------------------------|
  RoW行 |  R0    C0   |    R0    C1   |   R0    C2  |  R0    C3   |
        |---------------------------------------------------------|
        |  R1    C0   |    R1    C1   |   R1    C2  |  R1    C3   |
        |---------------------------------------------------------|
    }
    row := 0;
    col := 0;
    cdsGC.First;
    while not cdsGC.Eof do
    begin
      DynamicCreateQRShape(col, row);
      if(col mod 2) = 0 then
        DynamicCreateQRLabel(col, row, cdsGC.FieldByName('GF_NO').AsString)
      else
      begin
        DynamicCreateQRLabel(col, row, cdsGC.FieldByName('Fabric_No').AsString);  //如果输出布号，代表CDS数据指向下一条
        cdsGC.Next;
      end;

      Inc(col);
      if col > 3 then //列大于3代表需要换行
      begin
        Inc(row);
        col := 0;
      end;//if
    end;//while
  end;//if
end;

procedure TFNCardGreyClothReport.QuickRep1BeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  PrintGFNOAndFabricNo;
end;

procedure TFNCardGreyClothReport.QuickRep1AfterPrint(Sender: TObject);
begin
  GIsPrint := True;
end;

procedure TFNCardGreyClothReport.FormCreate(Sender: TObject);
begin
  GIsPrint := False;
end;

end.
