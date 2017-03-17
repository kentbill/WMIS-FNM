unit frmFNCardProperty;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmFNCardProperty.pas                                         }
{       �������� 2004-10-11 11:47:53                                           }
{       ������Ա zhangjy                                                       }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       �������� ���Ļ�������                                                              }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, StrUtils, OleCtrls, GFCADLib_TLB, Grids,
  ValEdit, DB, DBClient,uFNMArtInfo;

type
  TFNCardRec = Record
    FN_Card: string;
    Machine_ID: string;
    Machine_Name: string;
    Step_NO: Integer;
    Operation_Code: string;
    Operation_CHN: string;
    Operation_ENG: string;
    GF_ID: Integer;
    GF_NO: string;
    Job_NO: string;
    Ppo_NO: string;
    Customer: string;
    Delivery_Date: TDateTime;
    Quantity: Double;
    White_Type: string;
    Urgent_Type: string;
    Is_Cut_Cloth: Boolean;
    Is_Hold: Integer;
    Fact_Art_ID: Integer;
    Status: string;
    Plan_Begin_Time: TDateTime;
    Plan_End_Time: TDateTime;
    Fact_Begin_Time: TDateTime;
  end;
  TFNCardPropertyForm = class(TForm)
    pgcFNCardProperty: TPageControl;
    tsFNCardProperty: TTabSheet;
    btnOK: TButton;
    grpBaseInfo: TGroupBox;
    lblFN_Card: TLabel;
    edtFN_Card: TEdit;
    lblMachine_Name: TLabel;
    edtMachine_Name: TEdit;
    lblGF_ID: TLabel;
    edtGF_ID: TEdit;
    lblGF_NO: TLabel;
    edtGF_NO: TEdit;
    lblJob_NO: TLabel;
    edtJob_NO: TEdit;
    lblPpo_NO: TLabel;
    edtPpo_NO: TEdit;
    lblStep_NO: TLabel;
    edtStep_NO: TEdit;
    lblOperation_CHN: TLabel;
    edtOperation_CHN: TEdit;
    lblQuantity: TLabel;
    edtQuantity: TEdit;
    lblStatus: TLabel;
    edtStatus: TEdit;
    lblFact_Art_ID: TLabel;
    edtWhiteType: TEdit;
    lblCustomer: TLabel;
    edtCustomer: TEdit;
    lblDelivery_Date: TLabel;
    edtDelivery_Date: TEdit;
    lblUrgent_Type: TLabel;
    edtUrgent_Type: TEdit;
    lblCut_Cloth: TLabel;
    edtCut_Cloth: TEdit;
    lblHold: TLabel;
    edtHold: TEdit;
    lblPlan_Begin_Time: TLabel;
    edtPlan_Begin_Time: TEdit;
    lblPlan_End_Time: TLabel;
    edtPlan_End_Time: TEdit;
    lblFact_Begin_Time: TLabel;
    edtFact_Begin_Time: TEdit;
    lblArt_Remark: TLabel;
    mmoArt_Remark: TMemo;
    grp1: TGroupBox;
    grp2: TGroupBox;
    vleArtParam: TValueListEditor;
    gfcadPattern: TGFCAD;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FactArtInfo: TFactArtDtlInfo;
 {* -----------------------------------------------------------------------------
   �������� ShowFNCardBaseInfo
   ������Ա zhangjy
   �������� 2004-10-11 11:48:28
   �����б� None
   ����ֵ   None
   �������� ��ʾ���Ļ�������
   ��������
   �ο��ĵ�

   ����˵��
-------------------------------------------------------------------------------}
    procedure ShowFNCardBaseInfo;
  public
    { Public declarations }
    FNCardRec: TFNCardRec;
  end;

var
  FNCardPropertyForm: TFNCardPropertyForm;
implementation

uses uGlobal,uDictionary,uCADInfo;

{$R *.dfm}

procedure TFNCardPropertyForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFNCardPropertyForm.FormDestroy(Sender: TObject);
begin
  FNCardPropertyForm := nil;
end;

procedure TFNCardPropertyForm.btnOKClick(Sender: TObject);
begin
  Self.ModalResult := mrOK;
end;

procedure TFNCardPropertyForm.ShowFNCardBaseInfo;
begin
  edtFN_Card.Text := FNCardRec.FN_Card;
  edtMachine_Name.Text := FNCardRec.Machine_Name;
  edtGF_ID.Text := IntToStr(FNCardRec.GF_ID);
  edtGF_NO.Text := FNCardRec.GF_NO;
  edtJob_NO.Text := FNCardRec.Job_NO;
  edtPpo_NO.Text := FNCardRec.Ppo_NO;
  edtStep_NO.Text := IntToStr(FNCardRec.Step_NO);
  edtOperation_CHN.Text := FNCardRec.Operation_CHN;
  edtQuantity.Text := FloatToStr(FNCardRec.Quantity);
  edtStatus.Text := FNCardRec.Status;
  edtWhiteType.Text := FNCardRec.White_Type;
  edtCustomer.Text := FNCardRec.Customer ;
  edtDelivery_Date.Text := IfThen(FNCardRec.Delivery_Date = NULL,'',DateTimeToStr(FNCardRec.Delivery_Date));
  edtUrgent_Type.Text := FNCardRec.Urgent_Type;
  edtCut_Cloth.Text := Ifthen(FNCardRec.Is_Cut_Cloth,'��','��');
  edtHold.Text := Ifthen(FNCardRec.Is_Hold>0,'��','��');
  edtPlan_Begin_Time.Text := DateTimeToStr(FNCardRec.Plan_Begin_Time);
  edtPlan_End_Time.Text := DateTimeToStr(FNCardRec.Plan_End_Time);
  edtFact_Begin_Time.Text := IfThen(FNCardRec.Fact_Begin_Time= StrToDateTime('1899-12-30'),'', DateTimeToStr(FNCardRec.Fact_Begin_Time));
  CADInfo.OrgGFKeyValue := IntToStr(FNCardRec.GF_ID);
  gfcadPattern.Info := CADInfo.Info;
  FactArtInfo.FACT_Art_ID := FNCardRec.Fact_Art_ID;
  FactArtInfo.OpenFNArt;
  mmoArt_Remark.Lines.Add(FactArtInfo.Remark);
  FactArtInfo.FillAStepToAListControls(FNCardRec.Step_NO,vleArtParam);
end;

procedure TFNCardPropertyForm.FormCreate(Sender: TObject);
begin
  FactArtInfo := TFactArtDtlInfo.Create(Self);
end;

procedure TFNCardPropertyForm.FormShow(Sender: TObject);
begin
  ShowFNCardBaseInfo;
end;

end.
