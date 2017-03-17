unit frmQualityRemark;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmQualityRemark.pas                                          }
{       �������� 2004-8-26 13:50:57                                            }
{       ������Ա Lvzd                                                          }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       �������� ������ע��¼                                                  }
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
    {* ��׼���������}

    procedure ArtAfterEdit(Sender: TObject);
    {* �����ձ��༭��,��FormCreate�¼���:StdArtData.OnAfterEdit:=ArtAfterEdit;}
    procedure ArtAfterSave(Sender: TObject);
    {* �����ձ���ɹ���,��FormCreate�¼���:StdArtData.OnAfterSave:=ArtAfterSave;}
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
  //ȡƷ��ID��Std_Art_ID
  GetStdArtIDbyGFNO(cxbe_GFKeyValue.Text, Login.CurrentDepartment, iSTD_Art_ID, iGF_ID);
  if iSTD_Art_ID = -1 then
    raise Exception.CreateRes(@MSG_TheGFKeyValueNoStdArt);

  if StdArtData.OrgArt_ID = iSTD_Art_ID then exit;
  StdArtData.OrgArt_ID:=iSTD_Art_ID;
  StdArtData.OpenFNSTDArt;           
  StdArtData.FillAItemToAListControls('������ע', Vle_Operation_Parlist);
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
  //���û��޸���ֵ
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
  //�����׼������
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
