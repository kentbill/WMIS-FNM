unit frmqiFabricList;

{*****************************************************************************
  文 件 名：frmqiFabricList



  版权所有：(c) 2004-2005      ESQUEL GROUP GET/IT
  创 建 人：谭兆蛮
  创建日期：2004-08-09
  修改人：
  修改原因：
  修改日期：
  功能描述：待验布布号列表
  对应用例：
  字段描述:
  相关数据库表：
  调用重要函数/SQL对象说明：
    函数：
    SQL存储过程:
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
      过程名:    GetFabricInfoList
      功能:      从中间层获取布号信息列表
      作者:      谭兆蛮
      日期:      2004.08.12
      参数:      无
      返回值:    无
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
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！', crHourGlass);
   //获取成品侂
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
      TMsgDialog.ShowMsgDialog('没有查到成品数据',2);
      Exit;
    end;
     //填充cxGrid
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
