unit frmShrinkageAnalysis;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmShrinkageAnalysis.pas                                      }
{       创建日期 2006-1-10 10:50:57                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{           读：QCMDB..fiShrinkDtl表中所有的字段                               }
{           写：QCNMDB..fiShrinkDtl表中的字段FN_Card和Layer                    }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  缩水率异常分析                                               }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBClient,  StdCtrls, Buttons, ExtCtrls,
  ComCtrls;

type
  TShrinkageAnalysiForm = class(TBaseForm)
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    lbl2: TLabel;
    cdsShrinkage: TClientDataSet;
    dsShrinkage: TDataSource;
    cxgdShrinkage: TcxGrid;
    cxdbgtvShrinkage: TcxGridDBTableView;
    cxGridlShrinkage: TcxGridLevel;
    btnBatch: TSpeedButton;
    pnlBottom: TPanel;
    pnltop: TPanel;
    btnQuery: TSpeedButton;
    lbl3: TLabel;
    dtpBegin_Date: TDateTimePicker;
    lbl4: TLabel;
    dtpEnd_Date: TDateTimePicker;
    edtReason: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnQueryClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnBatchClick(Sender: TObject);
    procedure cxdbgtvShrinkageCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
    procedure Initialize();
    procedure GetData();
    procedure GetShrinkageInfo;
    procedure SaveData();
    procedure UpdateData(sReason :string);
    procedure SaveShrinkageInfo();
  public
    { Public declarations }
    procedure PublicQuery; override;
    procedure PublicSave; override;
    procedure PublicExport; override;
  end;

var
  ShrinkageAnalysiForm: TShrinkageAnalysiForm;

implementation

uses ServerDllPub, uGlobal, frmMain, uShowMessage, uLogin, uGridDecorator,
    uAppOption, uCADInfo, uFNMResource,uDictionary;
{$R *.dfm}

procedure TShrinkageAnalysiForm.PublicQuery;
begin
  GetData();
end;

procedure TShrinkageAnalysiForm.PublicSave;
begin
  SaveData();
end;

procedure TShrinkageAnalysiForm.PublicExport;
begin
  TGlobal.SaveDataToFile(cdsShrinkage, sftXLS)
end;

procedure TShrinkageAnalysiForm.Initialize;
begin
 //加载图标
  dtpBegin_Date.Date := Date()-1;
  dtpEnd_Date.Date := Date();
  btnQuery.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btnBatch.Glyph.LoadFromResourceName(HInstance, RES_EDIT);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
end;

procedure TShrinkageAnalysiForm.GetData();
begin
  GetShrinkageInfo();
end;

procedure TShrinkageAnalysiForm.UpdateData(sReason :string);
var
  i,iCol,Inspect_Times: Integer;
  Fabric_NO: string;
begin
  cdsShrinkage.ReadOnly :=false;
  cdsShrinkage.DisableControls ;
  for i:=0 to cxdbgtvShrinkage.Controller.SelectedRowCount -1 do
  begin
    iCol:=cxdbgtvShrinkage.GetColumnByFieldName('FabrIc_NO').Index ;
    Fabric_NO:=cxdbgtvShrinkage.Controller.SelectedRows[i].Values[iCol];
    iCol:=cxdbgtvShrinkage.GetColumnByFieldName('Inspect_Times').Index ;
    Inspect_Times:=cxdbgtvShrinkage.Controller.SelectedRows[i].Values[iCol];
    if cdsShrinkage.Locate('Fabric_NO;Inspect_Times',VarArrayOf([Fabric_NO,Inspect_Times]),[loCaseInsensitive]) then
    begin
     cdsShrinkage.Edit ;
     cdsShrinkage.FieldByName('Reason').Value :=sReason;
     cdsShrinkage.FieldByName('Operator').Value :=Login.LoginID;
     cdsShrinkage.Post;
    end;
  end;
  cdsShrinkage.ReadOnly := True;
  cdsShrinkage.EnableControls ;
end;

procedure TShrinkageAnalysiForm.GetShrinkageInfo;
var vData: OleVariant;
    sBegin_Date,sEnd_Date,sErrorMsg: WideString;
begin
  try
    ShowMsg( '正在获取数据稍等！', crHourGlass);
    sBegin_Date := DateToStr(dtpBegin_Date.Date);
    sEnd_Date := DateToStr(dtpEnd_Date.Date);
    FNMServerObj.GetShrinkageAnalysisInfo(vData,sBegin_Date,sEnd_Date,Login.CurrentDepartment,sErrorMsg);
    cdsShrinkage.Data := vData;
    if cdsShrinkage.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有异常数据', 2);
      Exit;
    end;
  finally
    ShowMsg('', crDefault);
  end;
  GridDecorator.BindCxViewWithDataSource(cxdbgtvShrinkage, dsShrinkage);
end;

procedure TShrinkageAnalysiForm.SaveShrinkageInfo();
var i: Integer;
    vData,vDelta: OleVariant;
    sErrorMsg: WideString;
begin
  try
    ShowMsg('正在保存数据稍等！', crHourGlass);
    if not cdsShrinkage.Active then  Exit;
    if TGlobal.DeltaIsNull(cdsShrinkage) then  Exit;
    vDelta := cdsShrinkage.Delta;
    TempClientDataSet.Data := cdsShrinkage.Delta;
    vData := VarArrayCreate([0, cdsShrinkage.ChangeCount - 1], VarVariant);
    i := 0;
    while not TempClientDataSet.Eof do
    begin
      if cdsShrinkage.Locate('Iden',TempClientDataSet.Fieldbyname('Iden').AsInteger,[]) then
        begin
          vData[i] := varArrayOf([cdsShrinkage.FieldByName('Reason').AsString,
                                  cdsShrinkage.FieldByName('Iden').AsInteger]);
        end;
        TempClientDataSet.Next;
        TempClientDataSet.Next;
        Inc(i);
    end;
    FNMServerObj.SaveShrinkageAnalysisInfo(vData,Login.LoginID,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    cdsShrinkage.MergeChangeLog;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TShrinkageAnalysiForm.SaveData();
begin
  SaveShrinkageInfo;
end;

procedure TShrinkageAnalysiForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize;
end;

procedure TShrinkageAnalysiForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ShrinkageAnalysiForm := nil;
end;

procedure TShrinkageAnalysiForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TShrinkageAnalysiForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  GetData();
end;

procedure TShrinkageAnalysiForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData();
end;

procedure TShrinkageAnalysiForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TShrinkageAnalysiForm.btnBatchClick(Sender: TObject);
begin
  inherited;
  if edtReason.Text <>'' then
    UpdateData(edtReason.Text);
end;

procedure TShrinkageAnalysiForm.cxdbgtvShrinkageCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var col:Integer;
begin
  inherited;
  col := TcxGridDBTableView(Sender).GetColumnByFieldName('Reason').Index;
  if (AViewInfo.GridRecord.Values[col] <> cdsShrinkage.FieldByName('Reason').OldValue) then
    ACanvas.Font.color := clred;
end;

end.
