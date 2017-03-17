unit frmEditSpecialOTD;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmEditSpecialOTD.pas                                         }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  OTD编辑                                                      }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Buttons,  StdCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridCustomPopupMenu, cxGridPopupMenu,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter, ComCtrls, DBClient, Provider, Menus, ExtCtrls, frmBase,
  cxSpinEdit, cxDropDownEdit, StrUtils, ADODB;

type
  TEditSpecialOTDForm = class(TBaseForm)
    cxgpmOTD: TcxGridPopupMenu;
    pnlValue: TPanel;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    dsDelayOTD: TDataSource;
    cdsDelayOTD: TClientDataSet;
    pnl1: TPanel;
    lbl3: TLabel;
    lbl4: TLabel;
    btnBitQueryDelayOTD1: TBitBtn;
    dtpBegin_Date: TDateTimePicker;
    dtpEnd_Date: TDateTimePicker;
    chkStatus: TCheckBox;
    cxgdDelayOTD1: TcxGrid;
    cxGridDBtvDelayOTD: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    btnUpdateOTD: TBitBtn;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure cxGridDBtvDelayOTDCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnUpdateOTDClick(Sender: TObject);
    procedure btnBitQueryDelayOTD1Click(Sender: TObject);
  private
    { Private declarations }
    procedure Initialize();
    procedure GetOTDInfo();
    procedure GetData();
    procedure SaveOTDInfo();
    procedure SaveData();
  public
    { Public declarations }
  end;

var
  EditSpecialOTDForm: TEditSpecialOTDForm;

implementation

uses ServerDllPub, UShowMessage, uAppOption,uLogin,uGlobal, uDictionary,
  uGridDecorator;

{$R *.dfm}
procedure TEditSpecialOTDForm.Initialize();
begin
  dtpBegin_Date.Date := Date()-1;
  dtpEnd_Date.Date := Date();
end;

procedure TEditSpecialOTDForm.GetOTDInfo();
var vData: OleVariant;
    sBegin_Date,sEnd_Date,sQuery_Type: string;
    sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！',crHourGlass);
    //获取OTD的统计信息
    sBegin_Date := DateToStr(dtpBegin_Date.Date);
    sEnd_Date := DateToStr(dtpEnd_Date.Date);
    sQuery_Type := Ifthen(chkStatus.Checked,'1','0');
    FNMServerObj.GetOTDInfo(vData,sBegin_Date,sEnd_Date,sQuery_Type,Login.CurrentDepartment,3,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsDelayOTD.Data := vData;
    if cdsDelayOTD.RecordCount = 0 then
    begin
      TMsgDialog.ShowMsgDialog('没有相应的数据,请重新查询',1);
      Exit;
    end;
    GridDecorator.BindCxViewWithDataSource(cxGridDBtvDelayOTD,dsDelayOTD);
  finally
    ShowMsg('',crDefault);
  end;
end;

procedure TEditSpecialOTDForm.GetData();
begin
  GetOTDInfo();
end;

procedure TEditSpecialOTDForm.SaveOTDInfo();
var
  vData: OleVariant;
  sErrorMsg: WideString;
  i,iIs_Active :Integer;
begin
  try
    ShowMsg('正在保存数据稍等！', crHourGlass);
    if TGlobal.DeltaIsNull(cdsDelayOTD) then Exit;
    TempClientDataSet.Data := cdsDelayOTD.Delta;
    vData := VarArrayCreate([0, cdsDelayOTD.ChangeCount - 1], VarVariant);
    i := 0;
    while not TempClientDataSet.Eof do
    begin
      if cdsDelayOTD.Locate('GF_ID;Job_NO',VarArrayOf([TempClientDataSet.Fieldbyname('GF_ID').AsInteger,
                                                       TempClientDataSet.Fieldbyname('Job_NO').AsString]),[]) then
      begin
        if cdsDelayOTD.FieldByName('Is_Active').AsBoolean then
           iIs_Active := 1
        else
           iIs_Active := 0;
        vData[i] := varArrayOf([cdsDelayOTD.FieldByName('Remark').AsString,
                                Login.LoginName,
                                iIs_Active,
                                cdsDelayOTD.FieldByName('GF_ID').AsInteger,
                                cdsDelayOTD.FieldByName('Job_NO').AsString,
                                cdsDelayOTD.FieldByName('Special_Type').AsString,
                                Login.CurrentDepartment]);
      end;
      TempClientDataSet.Next;
      TempClientDataSet.Next;
      Inc(i);
    end;
    FNMServerObj.SaveOTDInfo(vData,2, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    btnSave.Enabled := cdsDelayOTD.ChangeCount<>0;
    cdsDelayOTD.MergeChangeLog;
    btnSave.Enabled := False;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TEditSpecialOTDForm.SaveData();
begin
  SaveOTDInfo();
end;

procedure TEditSpecialOTDForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize();
end;

procedure TEditSpecialOTDForm.FormDestroy(Sender: TObject);
begin
  inherited;
  EditSpecialOTDForm := nil;
end;

procedure TEditSpecialOTDForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TEditSpecialOTDForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;
procedure TEditSpecialOTDForm.btnSaveClick(Sender: TObject);
begin
  SaveData();
end;

procedure TEditSpecialOTDForm.cxGridDBtvDelayOTDCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  btnSave.Enabled := cdsDelayOTD.ChangeCount<>0;
end;

procedure TEditSpecialOTDForm.btnUpdateOTDClick(Sender: TObject);
var
  sErrorMsg: WideString;
begin
  inherited;
  try
    ShowMsg('正在更新OTD数据稍等！', crHourGlass);
    FNMServerObj.CreateOTDInfo(1,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TEditSpecialOTDForm.btnBitQueryDelayOTD1Click(Sender: TObject);
begin
  inherited;
  GetData();
end;

end.

