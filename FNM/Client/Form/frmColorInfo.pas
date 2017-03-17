unit frmColorInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ComCtrls, Buttons, Grids, ValEdit, StdCtrls, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, DBClient, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, CheckLst, cxSplitter;

type
  TColorInfoForm = class(TBaseForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    edtGFNO: TEdit;
    btnQuery: TSpeedButton;
    cxgridYarnInfo: TcxGrid;
    cxGridYarnColorInfo: TcxGridDBTableView;
    cxGridlYarnInfo: TcxGridLevel;
    dsYarnColor: TDataSource;
    cdsYarnColor: TClientDataSet;
    dsHdr: TDataSource;
    cdsHdr: TClientDataSet;
    dsDtl: TDataSource;
    cdsDtl: TClientDataSet;
    cdsPDA: TClientDataSet;
    GroupBox4: TGroupBox;
    GroupBox3: TGroupBox;
    cxgrid_OnLineCard: TcxGrid;
    cxgridtv_OnLineCard: TcxGridDBTableView;
    cxgridtv_FactArtDtl: TcxGridDBTableView;
    cxGridl_OnLineCard: TcxGridLevel;
    cxGridl_FactArtDtl: TcxGridLevel;
    mmoHint: TMemo;
    GroupBox5: TGroupBox;
    cxgridHold: TcxGrid;
    cxgridtvHold: TcxGridDBTableView;
    cxgridlHold: TcxGridLevel;
    cxgridShade: TcxGrid;
    cxgridtvShade: TcxGridDBTableView;
    cxgridlShade: TcxGridLevel;
    dsShade: TDataSource;
    cdsShade: TClientDataSet;
    dsHold: TDataSource;
    cdsHold: TClientDataSet;
    cxspl1: TcxSplitter;
    cxSplitter1: TcxSplitter;
    cxSplitter2: TcxSplitter;
    cxgridPDA: TcxGrid;
    cxgridtvPDA: TcxGridDBTableView;
    cxgridlPDA: TcxGridLevel;
    dsPDA: TDataSource;
    cdsPDAs: TClientDataSet;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnQueryClick(Sender: TObject);
    procedure QueryData();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ColorInfoForm: TColorInfoForm;

implementation

uses Math, StrUtils, ServerDllPub, uFNMArtInfo,uFNMResource ,
    uDictionary, uShowMessage, uLogin, UAppOption, uGlobal, UGridDecorator;
{$R *.dfm}

procedure TColorInfoForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ColorInfoForm := nil;
end;

procedure TColorInfoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TColorInfoForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  QueryData;
end;

procedure TColorInfoForm.QueryData();
var
  sCondition,sErrorMsg:WideString;
  vData,vDataInfo,vDataPDA,vDataIN:OleVariant;
begin
  sCondition := '';
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    if Trim(edtGFNO.Text) = '' then Exit;
    //获取纱信息
    sCondition := QuotedStr(Trim(edtGFNO.Text)) + ',1';
    FNMServerObj.GetQueryData(vData,'GetColorInfo',sCondition,sErrorMsg);
    //获取后整信息
    sCondition := QuotedStr(Trim(edtGFNO.Text)) + ',3';
    FNMServerObj.GetQueryData(vDataInfo,'GetColorInfo',sCondition,sErrorMsg);
    //获取PDA信息
    sCondition := QuotedStr(Trim(edtGFNO.Text)) + ',2';
    FNMServerObj.GetQueryData(vDataPDA,'GetColorInfo',sCondition,sErrorMsg);
    //获取成品信息
    sCondition := QuotedStr(Trim(edtGFNO.Text)) + ',4';
    FNMServerObj.GetQueryData(vDataIN,'GetColorInfo',sCondition,sErrorMsg);

    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsYarnColor.Data := vData;
    cdsHdr.Data := vDataInfo[0];
    cdsDtl.Data := vDataInfo[1];
    cdsPDAs.Data := vDataPDA;
    cdsShade.Data := vDataIN[0];
    cdsHold.Data := vDataIN[1];

//    if cdsYarnColor.IsEmpty then
//    begin
//      TMsgDialog.ShowMsgDialog('没有相关信息,请检查你的查询条件!',mtInformation);
//      Exit;
//    end;
    GridDecorator.BindCxViewWithDataSource(cxGridYarnColorInfo, dsYarnColor,True);
    //GridDecorator.HideFields(cxGridTVCPBDtl,['Chemical_ID', 'Chemical_Type']);
    GridDecorator.BindCxViewWithDataSource(cxgridtv_OnLineCard,dsHdr,True);
    GridDecorator.BindCxViewWithDataSource(cxgridtv_FactArtDtl, dsDtl,True);
//    mmoHint.Lines.Text := '单号 ：' + char(13) + cdsPDA.FieldByName('Bill_NO').AsString + char(13) + char(13) +
//                      '翻单备注：' + char(13) + cdsPDA.FieldByName('Launch_Reason').AsString + char(13) + char(13) +
//                      '最终意见：' + char(13) + cdsPDA.FieldByName('Final_Result').AsString + char(13);
    GridDecorator.BindCxViewWithDataSource(cxgridtvPDA, dsPDA,True);
    GridDecorator.BindCxViewWithDataSource(cxgridtvShade, dsShade,True);
    GridDecorator.BindCxViewWithDataSource(cxgridtvHold, dsHold,True);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

end.
