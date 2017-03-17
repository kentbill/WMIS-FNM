unit frmSupplyRecipe;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmCreateRecipe.pas                                           }
{       �������� 2004-8-26 13:50:57                                            }
{       ������Ա Lvzd                                                          }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       ��������  ���ɻ��ϵ�                                                   }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons;

type
  TSupplyRecipeForm = class(TForm)
    cbb_Operation: TComboBox;
    cbb_StdPrescription: TComboBox;
    cbb_MachineID: TComboBox;
    lv_OnlineCard: TListView;
    btn_OK: TButton;
    btn_Help: TButton;
    txt_Only: TStaticText;
    btn_Query: TSpeedButton;
    btn1: TButton;
    edt_BeginTime: TEdit;
    edt_EndTime: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbb_EnterAControl(Sender: TObject);
    procedure cbb_OperationChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btn_QueryClick(Sender: TObject);
    procedure cbb_ChangeAComboBox(Sender: TObject);
  private
    { Private declarations }
    function SaveNewRecipe: Boolean;
    {* ���滯�ϵ�}
    function  GetCheckedCard: String;
    {* ȡѡ��Ŀ���}
  public
    { Public declarations }
  end;

var
  SupplyRecipeForm: TSupplyRecipeForm;

implementation

uses Math, StrUtils, uDictionary, uFNMArtInfo, ServerDllPub, UFNMResource, UAppOption, uLogin;

{$R *.dfm}

procedure TSupplyRecipeForm.FormCreate(Sender: TObject);
begin
  btn_Query.Glyph.LoadFromResourceName(HInstance, RES_QUERY);

  edt_BeginTime.Text:=DateTimeToStr(Now - 1);
  edt_EndTime.Text:=DateTimeToStr(Now);
end;

procedure TSupplyRecipeForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrOk then
    SaveNewRecipe;

  Action:=caFree;
  SupplyRecipeForm:=nil;
end;

procedure TSupplyRecipeForm.FormActivate(Sender: TObject);
begin
  OnActivate:=nil;
  Application.ProcessMessages;
  with Dictionary, Dictionary.cds_OperationDtlList do
  try
    Filter:='Item_Name Like ''%�䷽%'' OR Item_Name = ''�䷽''';
    Filtered:=True;
    FillItemsFromDataSet(cds_OperationDtlList, 'Operation_Code', 'Operation_CHN', '', '->', cbb_Operation.Items);
  finally
    Filtered:=False;
  end;
end;

procedure TSupplyRecipeForm.cbb_OperationChange(Sender: TObject);
begin
  cbb_StdPrescription.Items.Clear;
  cbb_MachineID.Items.Clear;
  lv_OnlineCard.Items.Clear;
end;

procedure TSupplyRecipeForm.cbb_EnterAControl(Sender: TObject);
var
  OperationCode: string;
begin
  //���ػ�̨
  OperationCode:=LeftStr(cbb_Operation.Text, 3);
  if OperationCode = '' then exit;

  if cbb_StdPrescription.Items.Count = 0 then
  with Dictionary, Dictionary.cds_StdPrescriptionHdrList do
  try
    Filter:=Format('Operation_Code = ''%s''', [OperationCode]);
    Filtered:=True;
    FillItemsFromDataSet(cds_StdPrescriptionHdrList, 'Prescrip_NO', '', '', '', cbb_StdPrescription.Items);
  finally
    Filtered:=False;
  end;

  if cbb_MachineID.Items.Count = 0 then
    FillMachineListByOperationCode(Login.CurrentDepartment, OperationCode, cbb_MachineID.Items);
end;

procedure TSupplyRecipeForm.btn_QueryClick(Sender: TObject);
var
  vData: OleVariant;
  sErrorMsg: WideString;
  OperationCode, MachineID: string;
begin
  MachineID:=LeftStr(cbb_MachineID.Text, 4);
  OperationCode:=LeftStr(cbb_Operation.Text, 3);
  if (OperationCode = '') or (MachineID = '') or
     (edt_BeginTime.Text = '') or (edt_EndTime.Text = '') then exit;

  FNMServerArtObj.GetNoRecipeSteps(OperationCode, Login.CurrentDepartment, MachineID, edt_BeginTime.Text, edt_EndTime.Text, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetNoRecipeSteps, [sErrorMsg]);

  TempClientDataSet.Data:=vData;
  if TempClientDataSet.IsEmpty then
    raise Exception.CreateRes(@EMP_GetNoRecipeSteps);

  FillListItemsFromDataSet(TempClientDataSet, 'FN_Card', '', ['Quantity', 'Begin_Time', 'Iden'], lv_OnlineCard.Items);
end;

function TSupplyRecipeForm.GetCheckedCard: String;
var
  i: Integer;
begin
  result:='';
  with lv_OnlineCard.Items do
  for i := 0 to Count - 1 do
  begin
    if Item[i].Checked then
      result := result + Item[i].SubItems.Strings[2] + ',';
  end;
end;

function TSupplyRecipeForm.SaveNewRecipe: Boolean;
var
  sErrorMsg: WideString;
  OperationCode, Machine_ID, FN_Cards, BaseVolume: string;
begin
  OperationCode:=LeftStr(cbb_Operation.Text, 3);
  Machine_ID:=LeftStr(cbb_MachineID.Text, 4);
  FN_Cards:=GetCheckedCard;
  
  if (OperationCode = '') or (Machine_ID = '') or (FN_Cards =  '') then exit;

  FNMServerArtObj.SaveSupplyRecipe(FN_Cards, OperationCode, cbb_StdPrescription.Text, Machine_ID,
                                Login.CurrentDepartment, Login.LoginName, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveRecipe, [sErrorMsg]);

  result := True;
end;

procedure TSupplyRecipeForm.cbb_ChangeAComboBox(Sender: TObject);
begin
  lv_OnlineCard.Items.Clear;
end;

end.
