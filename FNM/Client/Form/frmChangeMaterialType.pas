unit frmChangeMaterialType;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmChangeMaterialType.pas                                             }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述 改处理布                                                      }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, StdCtrls, ExtCtrls, Buttons, DBClient,
  cxContainer, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TChangeMaterialTypeForm = class(TBaseForm)
    pnlTop: TPanel;
    rgType: TRadioGroup;
    lbledtCode: TLabeledEdit;
    pnlClient: TPanel;
    cxGridtvFabric: TcxGridDBTableView;
    cxGridlFabric: TcxGridLevel;
    cxGridFabric: TcxGrid;
    pnlBottom: TPanel;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    btnQuery: TSpeedButton;
    dsFabric: TDataSource;
    cdsFabric: TClientDataSet;
    mmoReason: TMemo;
    lbReason: TLabel;
    Label2: TLabel;
    cbbDutyDepartment: TComboBox;
    Label1: TLabel;
    cbMaterialType: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure rgTypeClick(Sender: TObject);
    procedure lbledtCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure GetFabricInfo;
    procedure GetData();
    procedure SaveChangeMaterialType();
    procedure SaveData();
  public
    { Public declarations }
    procedure PublicQuery; override;
    procedure PublicSave; override;
  end;

var
  ChangeMaterialTypeForm: TChangeMaterialTypeForm;

implementation

uses ServerDllPub, uGlobal, frmMain, uShowMessage, uLogin, uGridDecorator,
  uAppOption, uCADInfo, uFNMResource,uDictionary;

{$R *.dfm}

procedure TChangeMaterialTypeForm.PublicQuery;
begin
  GetData();
end;

procedure TChangeMaterialTypeForm.PublicSave;
begin
  SaveData();
end;

procedure TChangeMaterialTypeForm.GetFabricInfo();
var
  sCode,sType : string;
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    sCode := lbledtCode.Text;
    sType := IntToStr(rgType.ItemIndex);
    if TGlobal.CheckValueIsNull(sCode,'请输入布号/卡号!') then Exit;
    sCondition :=QuotedStr(sCode)+','+QuotedStr(Login.CurrentDepartment)+','+QuotedStr(sType);
    FNMServerObj.GetQueryData(vData,'GetReciveInfo',sCondition,sErrorMsg);
//    FNMServerObj.GetReceiveInfo(vData,sCode,Login.CurrentDepartment,sType,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsFabric.Data := vData;
  finally
    ShowMsg('', crDefault);
  end;
  GridDecorator.BindCxViewWithDataSource(cxGridtvFabric, dsFabric);
end;

procedure TChangeMaterialTypeForm.GetData();
begin
  GetFabricInfo();
end;

procedure TChangeMaterialTypeForm.SaveChangeMaterialType();
var
  iType : Integer;
  sCode,sMaterialType,sDuty_Department,sReason: String;
  sCondition,sErrorMsg: WideString;
begin
  try
    ShowMsg('正在保存数据稍等！', crHourGlass);

    rgType.Enabled := False;
    sMaterialType := cbMaterialType.Text;
    if sMaterialType = '' then Exit;
    sDuty_Department := Copy(cbbDutyDepartment.Text,1,2);
    iType := rgType.ItemIndex;
    sCode := lbledtCode.Text;
    sReason := mmoReason.Lines.Text;

    sCondition := QuotedStr(sCode)+','+QuotedStr(sMaterialType)+','+
                  QuotedStr(sDuty_Department)+','+ QuotedStr(sReason)+','+QuotedStr(Login.LoginName)+','+
                  QuotedStr(Login.CurrentDepartment)+','+IntToStr(iType);
    FNMServerObj.SaveDataBySQL('ChangeMaterialType',sCondition,sErrorMsg);
//   FNMServerObj.ChangeMaterialType(sCode,sMaterialType,sDuty_Department,sReason,Login.LoginName,Login.CurrentDepartment,iType, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    rgType.Enabled := True;
    ShowMsg('', crDefault);
  end;
end;

procedure TChangeMaterialTypeForm.SaveData();
begin
  SaveChangeMaterialType();
end;

procedure TChangeMaterialTypeForm.FormCreate(Sender: TObject);
begin
  inherited;
  btnQuery.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);

  Dictionary.cds_MaterialFlowList.Filtered:=False;
  Dictionary.cds_MaterialFlowList.Filter:='Current_Department=''FN'' AND Flow_Description = ''改处理布责任部门''';
  Dictionary.cds_MaterialFlowList.Filtered:=True;
  TGlobal.FillItemsFromDataSet(Dictionary.cds_MaterialFlowList, 'Relation_Department', 'Relation_Department_CHN', '->',cbbDutyDepartment.Items);
end;

procedure TChangeMaterialTypeForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ChangeMaterialTypeForm := nil;
end;

procedure TChangeMaterialTypeForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TChangeMaterialTypeForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TChangeMaterialTypeForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  GetData();
end;

procedure TChangeMaterialTypeForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData();
end;

procedure TChangeMaterialTypeForm.rgTypeClick(Sender: TObject);
begin
  inherited;
  if rgType.ItemIndex = 0 then
    lbledtCode.EditLabel.Caption := '布号:'
  else
    lbledtCode.EditLabel.Caption := '卡号:' ;
  lbledtCode.Clear;
  if cdsFabric.Active then cdsFabric.EmptyDataSet;
end;

procedure TChangeMaterialTypeForm.lbledtCodeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
    GetData;
end;

end.
