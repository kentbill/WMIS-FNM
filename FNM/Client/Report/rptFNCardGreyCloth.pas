{******************************************************************************

       ������� WMIS ����FNM
       �ļ����� rptFNCardGreyCloth
       ��Ȩ���� (C) 2013 ESQUEL GROUP GET/IT
       �������� 2013-12-04
       ������Ա APJ zhaogang  ���վ������Ը�
       �޸���Ա
       �޸�����
       �޸�ԭ��
       ��Ӧ����
       ���ݿ�
            	��
                QCMDB.dbo.fnGreyCloth	
		          ��ر�
                FNMDB.DBO.fnProductionList
                PDMDB.DBO.TDGFID
              �洢���̣�
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
    GIsPrint : Boolean;                                                         //�Ƿ��ӡ��ʶ Ĭ��ΪFalse
    procedure PrintGFNOAndFabricNo;                                             //��ӡƷ���벼��
    procedure DynamicCreateQRShape(aCol, aRow: Integer);                        //��̬����QRShape
    procedure DynamicCreateQRLabel(aCol, aRow: Integer; aValue : String);       //��̬����QRLabel
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
  line : integer;     //��¼��Ҫ��̬���ɿؼ����������
  row, col : integer;//������ֵ���Ǵ�0��ʼ
begin
  { Col, Row �ĸ������
    ���ڸñ�����������ϸ��ɣ�1��Ʒ�������ţ� 2���ӹ���������ֻ��ѡ������һ�����ݼ��������ʵ��ѡ����2���ӹ�����
    
    1��Ʒ�������ŵĽ���
    Ʒ�������ű����ʽΪ˫����ʾ��QReport�޷�ʵ�֣�ֻ��ͨ����̬���ɿؼ���
  }

  if cdsGC.Active then
  begin
    //1������Ҫ��������
    line := cdsGC.RecordCount div 2;
    if (cdsGC.RecordCount mod 2) > 0 then
      Inc(line);
    //2����������������ڶ�̬QRShape�ؼ����߶ȡ������ QRShape5 һ�£�
    PageHeaderBand1.Height := PageHeaderBand1.Height + (QRShape5.Height * line);
    //3Ԥ�������ұ��������QRShape���������������Ϊ�����¼��Ϊ���������ӡҳ����ȱ���ӵ������
    DynamicCreateQRShape(2, line - 1); //���ڵ�����
    DynamicCreateQRShape(3, line - 1); //���ڵ�����

    //4ͨ���������ݶ�̬���ɴ�ӡ�ؼ��ͽ���ͬλ�õ��������
    {
              col��
        -----------------------------------------------------------
        |      Ʒ��   |      ����    |    Ʒ��     |      ����    |
        |---------------------------------------------------------|
  RoW�� |  R0    C0   |    R0    C1   |   R0    C2  |  R0    C3   |
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
        DynamicCreateQRLabel(col, row, cdsGC.FieldByName('Fabric_No').AsString);  //���������ţ�����CDS����ָ����һ��
        cdsGC.Next;
      end;

      Inc(col);
      if col > 3 then //�д���3������Ҫ����
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
