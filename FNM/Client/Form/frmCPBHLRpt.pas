{*******************************************************}
{                                                       }
{       CPBHL����                                       }
{                                                       }
{       ��Ȩ���� (C) 2015 Danny                         }
{                                                       }
{       ʱ��:   2015.03.06 00:30:51}
{                                                       }
{       ����:   Danny                                                 }
{                                                       }
{                                                       }
{       ��������:  H/L������Ϣ��ϸ��ʽ
���	�������	ɫ��	��������	�������	��������	��������	����	REJECT	����ʽ	�ͻ�	Ʒ��
1	LB12-597	0126KK01	4-1	4-4	6	20	3	REJECT	royal	EBO	PDKC00206


����
1���������ڣ�ɫ�ű��Ʊ���ʱ��
2��������ڣ���������ʱ��
3����������������¼���䷽����¼�������ǰһ��¼���䷽�ı���ʱ�䵽��һ��¼���䷽�ı���ʱ����� 0.5H ������һ�Ρ�
4���������������OK������ ��������и���
5�����ڣ�����������ʱ��-ɫ�ű���ʱ�䣩/24��ʱ�侫ȷ��Сʱ��������λС����
6��REJECT �����������ش�����Ĵ���
                                              }
{                                                       }
{                                                       }
{                                                       }
{                                                       }
{                                                       }
{*******************************************************}

unit frmCPBHLRpt;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, Buttons, ExtCtrls,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DBClient, ComCtrls;

type
  TCPBHLRptForm = class(TBaseForm)
    PanelHeader: TPanel;
    Label1: TLabel;
    dpBeginDate: TDateTimePicker;
    Label2: TLabel;
    dpEndDate: TDateTimePicker;
    cxgridHLRpt: TcxGrid;
    cxgridtvCPBHLRpt: TcxGridDBTableView;
    cxGridlHLRpt: TcxGridLevel;
    dsCPBHLRpt: TDataSource;
    cdsCPBHLRpt: TClientDataSet;
    btnRefresh: TSpeedButton;
    btnClose: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Query();
  end;

var
  CPBHLRptForm: TCPBHLRptForm;

implementation
uses  ServerDllPub, uGlobal, uShowMessage, uFNMResource, uGridDecorator, uAppOption, uLogin,
  frmMain,uDictionary;
{$R *.dfm}


procedure TCPBHLRptForm.FormCreate(Sender: TObject);
begin
  inherited;
  dpEndDate.DateTime:=Now-1;
  dpBeginDate.DateTime:=dpEndDate.DateTime-7;
end;

procedure TCPBHLRptForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  Query;
end;

procedure TCPBHLRptForm.Query;
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
    sBeginDate, sEndDate:string;
begin
  try
    sBeginDate:='';
    sEndDate:='';

    if dpBeginDate.Checked then
      sBeginDate:=FormatDateTime('yyyy-MM-dd',dpBeginDate.DateTime);
    if dpEndDate.Checked then
      sEndDate:=FormatDateTime('yyyy-MM-dd',dpEndDate.DateTime);

    Screen.Cursor :=  crHourGlass;
    ShowMsg('���ڻ�ȡ�����Եȣ�',crHourGlass);
    sCondition := QuotedStr(sBeginDate)+','+QuotedStr(sEndDate);
    FNMServerObj.GetQueryData(vData, 'CPBHLRpt', sCondition, sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsCPBHLRpt.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxgridtvCPBHLRpt, dsCPBHLRpt);
  finally
    Screen.Cursor :=  crDefault;
    ShowMsg('',crDefault);
  end;
end;

procedure TCPBHLRptForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
