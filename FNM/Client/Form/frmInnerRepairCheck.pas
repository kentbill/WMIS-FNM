unit frmInnerRepairCheck;
{*|<PRE>*****************************************************************************

       软件名称 FNM CLIENT MODEL                                               
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                              
       单元名称 frmAnalysisQuality.pas
       创建日期 2004-10-13 15:47:43
       创建人员 lvzd                                                           
       修改人员                                                                
       修改日期                                                                
       修改原因
       对应用例                                                                
       字段描述                                                                
       相关数据库表                                                            
       调用重要函数/SQL对象说明                                                
       功能描述 分析返工,C级,降等质量事故的工序.
                                                                              
******************************************************************************}

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs, DB,
  DBClient, cxSplitter, StdCtrls, ComCtrls, Buttons, ExtCtrls, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, Grids,
  DBGrids;

type
  TInnerRepairCheckForm = class(TForm)
    cds_FabricData: TClientDataSet;
    ds_FabricData: TDataSource;
    btn_Help: TSpeedButton;
    btn_Query: TSpeedButton;
    btn_Save: TSpeedButton;
    btn_Exit: TSpeedButton;
    txt_Only: TStaticText;
    pnl_Only: TPanel;
    dtp_OperateTime: TDateTimePicker;
    Panel1: TPanel;
    btn_Ignore: TSpeedButton;
    edt_Remark: TEdit;
    Label1: TLabel;
    cxgrid_FabricData: TcxGrid;
    cxgridtv_FabricData: TcxGridDBTableView;
    cxGridl_FabricData: TcxGridLevel;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_QueryClick(Sender: TObject);
    procedure btn_IgnoreClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure dtp_OperateTimeChange(Sender: TObject);
    procedure cds_FabricDataAfterScroll(DataSet: TDataSet);
  private
    { private declarations }
    procedure GetInnerRepairData;

  public
    { Public declarations }
  end;

var
  InnerRepairCheckForm: TInnerRepairCheckForm;

implementation

uses SysUtils, Variants, cxDropDownEdit, uDictionary, uFNMArtInfo, UAppOption,
    ServerDllPub, uFNMResource, StrUtils, uLogin, UGridDecorator,
  uShowMessage, frmInput;

{$R *.dfm}

procedure TInnerRepairCheckForm.FormDestroy(Sender: TObject);
begin
  InnerRepairCheckForm:=nil;
end;

procedure TInnerRepairCheckForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TInnerRepairCheckForm.FormCreate(Sender: TObject);
begin
  btn_Query.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btn_Help.Glyph.LoadFromResourceName(HInstance, RES_HELPABOUT);
  btn_Save.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  dtp_OperateTime.Date := Now-1;
  btn_Save.Enabled:=False;
end;

procedure TInnerRepairCheckForm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TInnerRepairCheckForm.GetInnerRepairData;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  try
    cds_FabricData.DisableControls;
    FNMServerObj.GetInnerRepairInfo(Login.CurrentDepartment, DateToStr(dtp_OperateTime.Date), vData, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_GetAnalysisData, [sErrorMsg]);

    cds_FabricData.Data:=vData;
    cds_FabricData.FieldByName('Iden').Visible:=False;
    cds_FabricData.FieldByName('Changed').Visible:=False;
    GridDecorator.BindCxViewWithDataSource(cxgridtv_FabricData, ds_FabricData);
    cds_FabricData.AfterScroll(cds_FabricData);
    btn_Save.Enabled:=False;
  finally
    cds_FabricData.EnableControls;
  end;
end;

procedure TInnerRepairCheckForm.btn_QueryClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  GetInnerRepairData;
  Screen.Cursor :=  crDefault
end;

procedure TInnerRepairCheckForm.btn_IgnoreClick(Sender: TObject);
begin
  if (not cds_FabricData.Active) or (cds_FabricData.IsEmpty) then Exit;
  
  if MessageDlg('你确认要忽略或取消忽略选中的内回修记录吗?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;

  with cds_FabricData do
  begin
    Edit;
    FieldByName('Is_Ignore').AsBoolean:=not FieldByName('Is_Ignore').AsBoolean;
    FieldByName('Ignore_Remark').AsString:=edt_Remark.Text;
    FieldByName('Ignorer').AsString:=Login.LoginName;
    FieldByName('Ignore_Time').AsDateTime:=Now;
    FieldByName('Changed').AsBoolean:=True;

    AfterScroll(cds_FabricData);
    btn_Save.Enabled:=True;
  end;
end;

procedure TInnerRepairCheckForm.btn_SaveClick(Sender: TObject);
var
  i: Integer;
  sErrorMsg: WideString;
begin
  cds_FabricData.DisableControls;
  try
    cds_FabricData.First;
    for i := 0  to cds_FabricData.RecordCount - 1 do
    begin
      if cds_FabricData.FieldByName('Changed').AsBoolean then
        cds_FabricData.Next
      else
        cds_FabricData.Delete;
    end;
  finally
    cds_FabricData.EnableControls;
  end;
  
  cds_FabricData.MergeChangeLog;
  FNMServerObj.SaveIgnoredInnerRepairInfo(cds_FabricData.Data, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveAnalysisQualtityData, [sErrorMsg]);
    
  cds_FabricData.EmptyDataSet;
  btn_Save.Enabled:=False;
end;

procedure TInnerRepairCheckForm.dtp_OperateTimeChange(Sender: TObject);
begin
  if cds_FabricData.Active then
    cds_FabricData.EmptyDataSet;
end;

procedure TInnerRepairCheckForm.cds_FabricDataAfterScroll(
  DataSet: TDataSet);
begin
  btn_Ignore.Caption:=IfThen(DataSet.FieldByName('Is_Ignore').AsBoolean, '取消忽略(&U)', '忽略(&I)');
end;

end.



