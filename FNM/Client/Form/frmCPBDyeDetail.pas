{*******************************************************}
{                                                       }
{       CPBȾɫ��ϸ                                     }
{                                                       }
{       ��Ȩ���� (C) 2015 Danny                         }
{                                                       }
{       ʱ��:   2015.03.06 00:30:18}
{                                                       }
{       ����:   Danny                                                 }
{                                                       }
{                                                       }
{       ��������:  �������
Ⱦɫ��ϸ
Ⱦɫʱ��	Ʒ��	ɫ��	�볤	����	�Ϲ���ʱ��	�ͻ�	����	�ղ�ʱ��	DIPʱ��	����	��ɫʦ	������
2011-5-11 13:00	PDDC00160-100579	0078RD02	12102	���	2011-5-10 4:59	KOHL'S	2011-5-20	2011-5-8 13:00	2011-5-11 11:59	1	��	��
												
												
����												
1����Ⱦɫʱ����Ϊ��ѯ����							
2����ϸ������Ҫ����ÿ�δ��DIP����������ʾΪ�볤							
3�����ӽ��ո��岼ʱ��,���ɽ������Ľ��ո��岼�����ȡ�ղ�ʱ������							
4���Ϲ���ʱ����ʾΪ���ո��岼ʱͬ��������Ⱦɫ����״̬��һ�����ŵ�ʱ��							
5��DIPʱ��Ҫ����ʾͬ���������DIPʱ����DIP��ȥ�Ŀ��ŵ�ʱ��			 				
6������=��DIPʱ��-�ղ�ʱ�䣩/24���˴���ʱ���辫ȷ��Сʱ���㣬������λС��							
7�����ͣ�������ȷ�������������������ɫ							
                                              }
{                                                       }
{                                                       }
{                                                       }
{                                                       }
{                                                       }
{*******************************************************}

unit frmCPBDyeDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, Buttons, ExtCtrls,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DBClient, ComCtrls;

type
  TCPBDyeDetailForm = class(TBaseForm)
    PanelHeader: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dpBeginDate: TDateTimePicker;
    dpEndDate: TDateTimePicker;
    cxgridCPBDye: TcxGrid;
    cxgridtvCPBDye: TcxGridDBTableView;
    cxGridlCPBDye: TcxGridLevel;
    dsCPBDye: TDataSource;
    cdsCPBDye: TClientDataSet;
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
  CPBDyeDetailForm: TCPBDyeDetailForm;

implementation
uses  ServerDllPub, uGlobal, uShowMessage, uFNMResource, uGridDecorator, uAppOption, uLogin,
  frmMain,uDictionary;
{$R *.dfm}


procedure TCPBDyeDetailForm.FormCreate(Sender: TObject);
begin
  inherited;
  dpEndDate.DateTime:=Now-1;
  dpBeginDate.DateTime:=dpEndDate.DateTime-7;
end;

procedure TCPBDyeDetailForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  Query;
end;

procedure TCPBDyeDetailForm.Query;
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
    FNMServerObj.GetQueryData(vData, 'CPBDyeDetail', sCondition, sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsCPBDye.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxgridtvCPBDye, dsCPBDye);
  finally
    Screen.Cursor :=  crDefault;
    ShowMsg('',crDefault);
  end;
end;

procedure TCPBDyeDetailForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
