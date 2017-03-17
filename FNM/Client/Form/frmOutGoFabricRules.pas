unit frmOutGoFabricRules;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, ExtCtrls, Grids, DBGrids, Buttons, frmBase,
  StdCtrls, Mask, DBCtrls, ComCtrls
  ;

type
  TOutGoFabricRulesForm = class(TBaseForm)
    Panel1: TPanel;
    CDSRules: TClientDataSet;
    DSRules: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBEdtName: TDBEdit;
    DBEdtValue1: TDBEdit;
    DBEdtValue2: TDBEdit;
    DBEdtValue3: TDBEdit;
    DBEdtValue4: TDBEdit;
    DBEdtType: TDBEdit;
    Label7: TLabel;
    DBEdtRules: TDBEdit;
    Label8: TLabel;
    DBEdtPriority: TDBEdit;
    GroupBox1: TGroupBox;
    DBGrdTerms: TDBGrid;
    CDSTerms: TClientDataSet;
    DSTerms: TDataSource;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Panel3: TPanel;
    SBtnAdd: TSpeedButton;
    SBtnRemove: TSpeedButton;
    SBtnSave: TSpeedButton;
    SBtnExit: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure SBtnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SBtnSaveClick(Sender: TObject);
    procedure SBtnAddClick(Sender: TObject);
    procedure SBtnRemoveClick(Sender: TObject);
  private
    { Private declarations }
    procedure init;
    procedure GetOutGoFabricRulesData;
    procedure GetOutGoFabricTermsData;
    procedure Save;
  public
    { Public declarations }
  end;

var
  OutGoFabricRulesForm: TOutGoFabricRulesForm;

implementation

uses uFNMResource, ServerDllPub, uShowMessage, uGridDecorator, uLogin,
  uGlobal;

{$R *.dfm}

procedure TOutGoFabricRulesForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if CDSRules.ChangeCount > 0 then
    if MessageDlg('提示: 数据已修改, 尚未保存, 是否继续退出操作?', mtConfirmation, [mbYes, mbNo],0) = mrNo then
    begin
      Action := caNone;
      Exit;
    end;//if
  Action := caFree;
end;

procedure TOutGoFabricRulesForm.FormDestroy(Sender: TObject);
begin
  OutGoFabricRulesForm := nil;
end;

procedure TOutGoFabricRulesForm.SBtnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TOutGoFabricRulesForm.init;
begin
  SBtnAdd.Glyph.LoadFromResourceName(HInstance, RES_NEW);
  SBtnRemove.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  SBtnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  SBtnExit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);

  GetOutGoFabricRulesData;
  GetOutGoFabricTermsData;
end;

procedure TOutGoFabricRulesForm.GetOutGoFabricRulesData;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  try
    ShowMsg('正在获取数据稍等!', crHourGlass);

    sql := QuotedStr('GetOutGoFabricRulesData') + ',' + QuotedStr('');
    FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);
    if Trim(sErrorMsg) <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;//if

    CDSRules.Data := vData;
  finally
    ShowMsg('', crDefault);
  end;//finally
end;

procedure TOutGoFabricRulesForm.GetOutGoFabricTermsData;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  try
    ShowMsg('正在获取数据稍等!', crHourGlass);

    sql := QuotedStr('GetOutGoFabricTermsData') + ',' + QuotedStr('');
    FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);
    if Trim(sErrorMsg) <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;//if

    CDSTerms.Data := vData;
  finally
    ShowMsg('', crDefault);
  end;//finally
end;

procedure TOutGoFabricRulesForm.FormShow(Sender: TObject);
begin
  init;
end;

procedure TOutGoFabricRulesForm.Save;
var
  sErrMsg : WideString;
  vData : OleVariant;
begin
  try
    uShowMessage.ShowStatusMessage('正在保存数据...', crHourGlass);
    if CDSRules.State in [dsEdit, dsInsert] then
      CDSRules.Post;

    if CDSRules.ChangeCount > 0 then
    begin
      vData := CDSRules.Delta;
      FNMServerObj.SaveBaseTableInfo(vData, 'OutGoFabricRules', '', sErrMsg);
      if sErrMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
        Exit;
      end;//if
      CDSRules.MergeChangeLog;
      TMsgDialog.ShowMsgDialog('数据保存成功！', mtInformation);
    end;//if
  finally
    uShowMessage.ShowStatusMessage('', crDefault);
  end;//finally
end;

procedure TOutGoFabricRulesForm.SBtnSaveClick(Sender: TObject);
begin
  Save;
end;

procedure TOutGoFabricRulesForm.SBtnAddClick(Sender: TObject);
begin
  CDSRules.Append;
end;

procedure TOutGoFabricRulesForm.SBtnRemoveClick(Sender: TObject);
begin
  CDSRules.Delete;
end;



end.
