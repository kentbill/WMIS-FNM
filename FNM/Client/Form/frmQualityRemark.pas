unit frmQualityRemark;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmQualityRemark.pas                                          }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 Lvzd                                                          }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述 质量备注记录                                                  }
{                                                                              }
{******************************************************************************}

interface

uses
  uFNMArtInfo, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Grids, ValEdit, Buttons,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TQualityRemarkForm = class(TForm)
    vle_Operation_Parlist: TValueListEditor;
    pnl_Only: TPanel;
    bvl2: TBevel;
    btn3: TButton;
    btn_SaveArt: TButton;
    btn_OK: TButton;
    txt1: TStaticText;
    cxbe_GFKeyValue: TcxButtonEdit;
    procedure cxbe_GFKeyValuePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure vle_Operation_ParlistKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vle_Operation_ParlistValidate(Sender: TObject; ACol,
      ARow: Integer; const KeyName, KeyValue: String);
    procedure cxbe_GFKeyValueKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
    procedure btn_SaveArtClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    StdArtData: TSTDArtDtlInfo;
    {* 标准工艺类对象}

    procedure ArtAfterEdit(Sender: TObject);
    {* 当工艺被编辑后,见FormCreate事件中:StdArtData.OnAfterEdit:=ArtAfterEdit;}
    procedure ArtAfterSave(Sender: TObject);
    {* 当工艺保存成功后,见FormCreate事件中:StdArtData.OnAfterSave:=ArtAfterSave;}
  end;

var
  QualityRemarkForm: TQualityRemarkForm;

implementation

uses uLogin, uFNMResource;

{$R *.dfm}

procedure TQualityRemarkForm.cxbe_GFKeyValuePropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  iGF_ID, iSTD_Art_ID: Integer;
begin
  //取品名ID或Std_Art_ID
  GetStdArtIDbyGFNO(cxbe_GFKeyValue.Text, Login.CurrentDepartment, iSTD_Art_ID, iGF_ID);
  if iSTD_Art_ID = -1 then
    raise Exception.CreateRes(@MSG_TheGFKeyValueNoStdArt);

  if StdArtData.OrgArt_ID = iSTD_Art_ID then exit;
  StdArtData.OrgArt_ID:=iSTD_Art_ID;
  StdArtData.OpenFNSTDArt;           
  StdArtData.FillAItemToAListControls('质量备注', Vle_Operation_Parlist);
end;

procedure TQualityRemarkForm.ArtAfterEdit(Sender: TObject);
begin
  btn_SaveArt.Enabled:=(Sender as TSTDArtDtlInfo).Modify;
end;

procedure TQualityRemarkForm.ArtAfterSave(Sender: TObject);
begin
  btn_SaveArt.Enabled:=false;
end;

procedure TQualityRemarkForm.vle_Operation_ParlistKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Sender = Vle_Operation_Parlist then
  with Sender as TValueListEditor do
  case Key of
    VK_RETURN:
      SendMessage(Vle_Operation_Parlist.Handle, WM_KEYDOWN, VK_DOWN, 0);
  end;
end;

procedure TQualityRemarkForm.vle_Operation_ParlistValidate(Sender: TObject;
  ACol, ARow: Integer; const KeyName, KeyValue: String);
begin
  //当用户修改了值
  with StdArtData, Vle_Operation_Parlist.Strings do
  if Active then
    SetAOperateParameterValue(integer(Objects[IndexOfName(KeyName)]), Trim(KeyName), Trim(KeyValue));
end;

procedure TQualityRemarkForm.cxbe_GFKeyValueKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Sender = cxbe_GFKeyValue then
  case Key of
    VK_RETURN: cxbe_GFKeyValue.Properties.OnButtonClick(cxbe_GFKeyValue, 0);
  end;
end;

procedure TQualityRemarkForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TQualityRemarkForm.FormCreate(Sender: TObject);
begin
  btn_SaveArt.Enabled:=false;

  cxbe_GFKeyValue.Properties.Buttons.Items[0].Glyph.LoadFromResourceName(HInstance, RES_QUERYSMALL);
  //构造标准工艺类
  StdArtData:=TSTDArtDtlInfo.Create(Self);
  StdArtData.OrgDepartment:=Login.CurrentDepartment;
  StdArtData.OnAfterEdit:=ArtAfterEdit;
  StdArtData.OnAfterSave:=ArtAfterSave;
end;

procedure TQualityRemarkForm.btn_SaveArtClick(Sender: TObject);
begin
  StdArtData.SaveArtToDataBase;
end;

procedure TQualityRemarkForm.btn_OKClick(Sender: TObject);
begin
  Close
end;

end.
