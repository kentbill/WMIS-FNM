unit frmColorProperty;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmColorProperty.pas                                          }
{       �������� 2004-10-9 10:54:46                                            }
{       ������Ա zhangjy                                                       }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       ��������                                                               }
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
   �������� FillUrgentTypeList
   ������Ա zhangjy
   �������� 2004-10-11 11:49:45
   �����б� cds:TClientDataSet; AUrgentType:array of TUrgentType
   ����ֵ   None
   �������� ��伱������
   ��������
   �ο��ĵ�

   ����˵��
-------------------------------------------------------------------------------}
    procedure FillUrgentTypeList(cds: TClientDataSet);
{* -----------------------------------------------------------------------------
   �������� Initialize
   ������Ա zhangjy
   �������� 2004-10-11 11:50:02
   �����б� None
   ����ֵ   None
   �������� ��ʼ������
   ��������
   �ο��ĵ�

   ����˵��
-------------------------------------------------------------------------------}
    procedure Initialize;
    procedure PaintBox(Index: Integer);
{* -----------------------------------------------------------------------------
   �������� SaveUrgentTypeListInfo
   ������Ա zhangjy
   �������� 2004-10-11 11:50:06
   �����б� None
   ����ֵ   None
   �������� ���漱������
   ��������
   �ο��ĵ�

   ����˵��
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
    TStatusBarMessage.ShowMessageOnMainStatsusBar('���ڱ��������Եȣ�', crHourGlass);
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
 //   TMsgDialog.ShowMsgDialog('�������ݳɹ�', mtInformation);
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

