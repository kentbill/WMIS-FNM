unit frmqiFabricList;

{*****************************************************************************
  �� �� ����frmqiFabricList



  ��Ȩ���У�(c) 2004-2005      ESQUEL GROUP GET/IT
  �� �� �ˣ�̷����
  �������ڣ�2004-08-09
  �޸��ˣ�
  �޸�ԭ��
  �޸����ڣ�
  �������������鲼�����б�
  ��Ӧ������
  �ֶ�����:
  ������ݿ��
  ������Ҫ����/SQL����˵����
    ������
    SQL�洢����:
*****************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, DBClient, Grids, DBGrids,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, ADODB,
  cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TqiFabricListForm = class(TForm)
    pnl1: TPanel;
    CDS_FabricList: TClientDataSet;
    DS_FabricList: TDataSource;
    pnl2: TPanel;
    cxGridFabric: TcxGrid;
    cxViewFabric: TcxGridDBTableView;
    cxLevelFabric: TcxGridLevel;
    btnClose: TBitBtn;
    cxGridPopupMenu1: TcxGridPopupMenu;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);

  private
    { Private declarations }
  public
       { Public declarations }
      {-------------------------------------------------------------------------------
      ������:    GetFabricInfoList
      ����:      ���м���ȡ������Ϣ�б�
      ����:      ̷����
      ����:      2004.08.12
      ����:      ��
      ����ֵ:    ��
      -------------------------------------------------------------------------------}
      procedure GetFabricInfoList(FN_Card:String);
  end;

var
  qiFabricListForm: TqiFabricListForm;

implementation

uses frmMain, UShowMessage, uGlobal, ServerDllPub, uGridDecorator;

{$R *.dfm}

procedure TqiFabricListForm.FormDestroy(Sender: TObject);
begin
  inherited;
  qiFabricListForm := nil;
end;

procedure TqiFabricListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;


procedure TqiFabricListForm.GetFabricInfoList(FN_Card:String);
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('���ڻ�ȡ�����Եȣ�', crHourGlass);
   //��ȡ��Ʒ��
    sCondition:='a.FN_Card in ('+QuotedStr(FN_Card) + ')';
    sCondition:=StringReplace(sCondition, '''''','''',[rfReplaceAll]);
    FNMServerObj.GetQueryData(vData,'GetFIInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    CDS_FabricList.Data := vData;
    if CDS_FabricList.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('û�в鵽��Ʒ����',2);
      Exit;
    end;
     //���cxGrid
    GridDecorator.BindCxViewWithDataSource(cxViewFabric, DS_FabricList);
    GridDecorator.AddFooter(cxViewFabric,['Quantity','Fabric_No'],[skSum,skCount]);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;

end;


procedure TqiFabricListForm.btnCloseClick(Sender: TObject);
begin
   close;
end;


end.
