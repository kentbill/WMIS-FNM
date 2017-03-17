unit frmColorProperty;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmColorProperty.pas                                          }
{       创建日期 2004-10-9 10:54:46                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述                                                               }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, DBClient;

type
  TColorPropertyForm = class(TForm)
    lstUrgentType: TListBox;
    pbUrgentColor: TPaintBox;
    btnSet: TButton;
    btnOK: TButton;
    btnClose: TButton;
    lblUrgentType: TLabel;
    dlgColor: TColorDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnSetClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lstUrgentTypeClick(Sender: TObject);
    procedure pbUrgentColorPaint(Sender: TObject);
  private
    { Private declarations }
{* -----------------------------------------------------------------------------
   过程名称 FillUrgentTypeList
   创建人员 zhangjy
   创建日期 2004-10-11 11:49:45
   参数列表 cds:TClientDataSet; AUrgentType:array of TUrgentType
   返回值   None
   功能描述 填充急单类型
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure FillUrgentTypeList(cds: TClientDataSet);
{* -----------------------------------------------------------------------------
   过程名称 Initialize
   创建人员 zhangjy
   创建日期 2004-10-11 11:50:02
   参数列表 None
   返回值   None
   功能描述 初始化窗体
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure Initialize;
    procedure PaintBox(Index: Integer);
{* -----------------------------------------------------------------------------
   过程名称 SaveUrgentTypeListInfo
   创建人员 zhangjy
   创建日期 2004-10-11 11:50:06
   参数列表 None
   返回值   None
   功能描述 保存急单类型
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure SaveUrgentTypeListInfo;
    procedure SaveData;
  public
    { Public declarations }
  end;

var
  ColorPropertyForm: TColorPropertyForm;
implementation

uses frmPlan, uGlobal, uShowMessage, ServerDllPub,uDictionary;

{$R *.dfm}

procedure TColorPropertyForm.Initialize;
begin
  FillUrgentTypeList(Dictionary.cds_UrgentTypeList);
  if lstUrgentType.Items.Count>0 then
   lstUrgentType.ItemIndex := 0;
  btnOK.Enabled := False;
end;

procedure TColorPropertyForm.SaveUrgentTypeListInfo;
var vData: OleVariant;
  sErrorMsg: Widestring;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在保存数据稍等！', crHourGlass);
    if Dictionary.cds_UrgentTypeList.ChangeCount <= 0 then Exit;
    vData := Dictionary.cds_UrgentTypeList.Delta;
    FNMServerObj.SaveBaseTableInfo(vData, 'fnUrgentTypeList','', sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    Dictionary.cds_UrgentTypeList.MergeChangeLog;
    PlanForm.IsColorChanged := True;
    Close;
 //   TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;
end;

procedure TColorPropertyForm.SaveData;
begin
  SaveUrgentTypeListInfo;
end;

procedure TColorPropertyForm.FillUrgentTypeList(cds: TClientDataSet);
begin
  with cds do
  begin
    if IsEmpty then Exit;
    First;
    lstUrgentType.Items.Clear;
    while not Eof do
    begin
      lstUrgentType.Items.Add(FieldByName('Urgent_Name').AsString);
      Next;
    end;
  end;
  lstUrgentType.ItemIndex := 0;
  if cds.Locate('Urgent_Name', lstUrgentType.Items[0], []) then
  begin
    with pbUrgentColor do
    begin
      Canvas.Brush.Color := cds.FieldValues['Urgent_Color'];
      Canvas.FillRect(ClientRect);
    end;
  end;
end;

procedure TColorPropertyForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TColorPropertyForm.FormDestroy(Sender: TObject);
begin
  ColorPropertyForm := nil;
end;

procedure TColorPropertyForm.btnSetClick(Sender: TObject);
begin
  if lstUrgentType.ItemIndex = -1 then Exit;
  with pbUrgentColor, Dictionary.cds_UrgentTypeList do
  begin
   dlgColor.Color := Canvas.Brush.Color;
   if dlgColor.Execute then
   begin
      Canvas.Brush.Color := dlgColor.Color;
      Edit;
      FieldValues['Urgent_Color'] := dlgColor.Color;
      Post;
      btnOK.Enabled := True;
   end;
  end;
  Invalidate;
end;

procedure TColorPropertyForm.btnOKClick(Sender: TObject);
begin
  SaveData;
end;

procedure TColorPropertyForm.btnCloseClick(Sender: TObject);
begin
  if Dictionary.cds_UrgentTypeList.ChangeCount>0 then
  begin
    Dictionary.cds_UrgentTypeList.CancelUpdates;
    Dictionary.cds_UrgentTypeList.MergeChangeLog;
  end;
  Close;
end;

procedure TColorPropertyForm.FormCreate(Sender: TObject);
begin
  Initialize;
end;

procedure TColorPropertyForm.lstUrgentTypeClick(Sender: TObject);
begin
  Invalidate;
end;

procedure TColorPropertyForm.PaintBox(Index: Integer);
begin
   if (lstUrgentType.Items.Count < 0) or
    (lstUrgentType.ItemIndex = -1) then Exit;
  with pbUrgentColor, Dictionary.cds_UrgentTypeList do
  begin
   if Locate('Urgent_Name', lstUrgentType.Items[Index], []) then
      Canvas.Brush.Color := FieldValues['Urgent_Color'];
    Canvas.FillRect(ClientRect);
  end;
end;

procedure TColorPropertyForm.pbUrgentColorPaint(Sender: TObject);
begin
  PaintBox(lstUrgentType.ItemIndex); 
end;

end.

