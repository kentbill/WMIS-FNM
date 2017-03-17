unit frmCreateStdPrescription;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmCreateStdPrescription.pas                                  }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 Lvzd                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  生成标准配方                                                 }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, ValEdit, ComCtrls;

type
  TCreateStdPrescriptionForm = class(TForm)
    txt1: TStaticText;
    cbb_StdPrescription: TComboBox;
    pnl1: TPanel;
    tv_Chemical_Name: TTreeView;
    pnl2: TPanel;
    txt3: TStaticText;
    vle_Chemicallist: TValueListEditor;
    btn_Add_Chemical: TSpeedButton;
    btn_Del_Chemical: TSpeedButton;
    pnl_Only: TPanel;
    btn3: TButton;
    btn2: TButton;
    btn_OK: TButton;
    btn_Query: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure KeyDownAControl(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ClickAButton(Sender: TObject);
    procedure vle_ChemicallistValidate(Sender: TObject; ACol,
      ARow: Integer; const KeyName, KeyValue: String);
  private
    { Private declarations }
  public
    { Public declarations }
    Operaction_Code: String;
    Art_Type: string; //S 标准 F 实际 R 回修 H 手织版
    OrgStdPrescriptionNO: String;

    function SaveNewPrescription: String;
  end;

function GetStdPrescriptionNo(Operaction_Code,Art_Type, OldStdPrescriptionNO: string): String;

implementation

uses uFNMArtInfo, uDictionary, uFNMResource, uGlobal, ServerDllPub, uLogin;

var
  StdPrescriptionNO: string;
  CreateStdPrescriptionForm: TCreateStdPrescriptionForm;
{$R *.dfm}

function GetStdPrescriptionNo(Operaction_Code,Art_Type,OldStdPrescriptionNO: string): String;
begin
  StdPrescriptionNO:=OldStdPrescriptionNO;

  if CreateStdPrescriptionForm = nil then
    CreateStdPrescriptionForm:= TCreateStdPrescriptionForm.Create(nil);

  CreateStdPrescriptionForm.Operaction_Code:=Operaction_Code;
  CreateStdPrescriptionForm.Operaction_Code := Art_Type;

  if not CreateStdPrescriptionForm.Showing then
    CreateStdPrescriptionForm.ShowModal;
  result:=StdPrescriptionNO;
end;

procedure FillStdPrescriptionDtl(Prescrip_NO: String; AItems: TStrings);
var
  i, j: Integer;
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  if Prescrip_NO = '' then exit;
    
  with Dictionary.cds_StdPrescriptionDtlList do
  if not Locate('Prescrip_NO', Prescrip_NO, []) then
  begin
    FNMServerArtObj.GetStdPrescriptionDtl(Prescrip_NO, vData, sErrorMsg);
    if sErrorMsg <> '' then
      raise Exception.CreateResFmt(@ERR_GetStdPrescriptionDtl, [sErrorMsg]);
    TempClientDataSet.Data:=vData;

    for i := 0 to TempClientDataSet.RecordCount - 1 do
    begin
      Append;
      for j := 0 to TempClientDataSet.FieldCount - 1 do
        Fields.Fields[j].Value:=TempClientDataSet.Fields.Fields[j].Value;
      TempClientDataSet.Next;
    end;    
  end;

  with Dictionary, Dictionary.cds_StdPrescriptionDtlList do
  try
    Filter:=Format('Prescrip_NO = ''%s''', [Prescrip_NO]);
    Filtered:=true;
    FillItemsFromDataSet(cds_StdPrescriptionDtlList, 'Chemical_Name', 'Unit_QTY', 'Chemical_ID', '=', AItems);
  finally
    Filtered:=False;
  end;
end;

procedure TCreateStdPrescriptionForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  //刷新界面数据
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
  //填充可选化工料
  FillTreeItemsFromDataSetByClassField(Dictionary.cds_ChemicalList, 'Chemical_Name', 'Chemical_Type', 'Chemical_ID', '', tv_Chemical_Name.Items);
  OnActivate:=nil;
end;

procedure TCreateStdPrescriptionForm.FormShow(Sender: TObject);
begin
  //填充存在的配方
  with Dictionary, Dictionary.cds_StdPrescriptionHdrList do
  try
    if Pos(Operaction_Code, '045,047,051,054,001,002,025,056,059,019,020') <> 0 then
      Filter:=Format('Operation_Code = ''%s''', ['025']) + ' AND Serial_NO <> 0 AND NOT(Prescrip_NO LIKE ''%-%'')'
    else
      Filter:=Format('Operation_Code = ''%s''', [Operaction_Code]) + ' AND Serial_NO <> 0 AND NOT(Prescrip_NO LIKE ''%-%'')';

    Filtered:=true;
    FillItemsFromDataSet(cds_StdPrescriptionHdrList, 'Prescrip_NO', '', '', '', cbb_StdPrescription.Items);
  finally
    Filtered:=false;
  end;

  vle_Chemicallist.Strings.Clear;
  cbb_StdPrescription.Text:='';
  cbb_StdPrescription.ItemIndex:=-1;
  OrgStdPrescriptionNO:='';
  btn_Add_Chemical.Enabled:=false;
  btn_Del_Chemical.Enabled:=false;
end;

function TCreateStdPrescriptionForm.SaveNewPrescription: String;
var
  i: Integer;
  NewPrescriptionNO, sChemicalStr, sUnitQtyStr, sErrorMsg: WideString;
  vDataParam: OleVariant;
begin
  if vle_Chemicallist.Strings.Count = 0 then
    raise Exception.Create('配方单必须包含化工料');

  if OrgStdPrescriptionNO = '' then
    raise Exception.Create('请先选择配方');
    
  sUnitQtyStr:='';
  sChemicalStr:='';
  with vle_Chemicallist.Strings do
  begin
    for i := 0 to Count - 1 do
    begin
      sChemicalStr:=sChemicalStr + IntToStr(Integer(Objects[i])) + ',';
      sUnitQtyStr:=sUnitQtyStr + Values[Names[i]] + ',';
    end;
  end;
  vDataParam := VarArrayOf([Operaction_Code,
                            sChemicalStr,
                            sUnitQtyStr,
                            Login.LoginName,
                            Art_Type]);

  NewPrescriptionNO:=OrgStdPrescriptionNO;
  FNMServerArtObj.SaveStdPrescription(vDataParam, NewPrescriptionNO, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveStdPrescription, [sErrorMsg]);

  result:=NewPrescriptionNO;
end;

procedure TCreateStdPrescriptionForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrOK then
  begin
    with cbb_StdPrescription do
    if Text = '未保存' then
      cbb_StdPrescription.Text:=SaveNewPrescription;

    StdPrescriptionNO:=cbb_StdPrescription.Text;
  end;
end;

procedure TCreateStdPrescriptionForm.FormCreate(Sender: TObject);
begin
  btn_Query.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btn_Add_Chemical.Glyph.LoadFromResourceName(HInstance, RES_LEFT);
  btn_Del_Chemical.Glyph.LoadFromResourceName(HInstance, RES_DELETE);

  tv_Chemical_Name.OnDblClick:=TGlobal.DblClickATreeview;
end;

procedure TCreateStdPrescriptionForm.KeyDownAControl(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Sender = cbb_StdPrescription then
  case Key of
    VK_RETURN: btn_Query.Click;
  end;

  if Sender = tv_Chemical_Name then
  case Key of    
    VK_RETURN: btn_Add_Chemical.Click;
  end;
end;

procedure TCreateStdPrescriptionForm.ClickAButton(Sender: TObject);
begin
  if not (Sender as TControl).Enabled then Exit;
  
  if Sender = btn_Query then
  begin
    with cbb_StdPrescription do
      if (Text = '') or (Items.IndexOf(Text) = -1) then Exit;

    OrgStdPrescriptionNO:=cbb_StdPrescription.Text;
    FillStdPrescriptionDtl(OrgStdPrescriptionNO, vle_Chemicallist.Strings);
    btn_Add_Chemical.Enabled:=True;
    btn_Del_Chemical.Enabled:=True;
  end;

  if Sender = btn_Add_Chemical then
  with tv_Chemical_Name, vle_Chemicallist do
  begin
    if (Selected = nil) or (Selected.Level = 0) then exit;
    if Strings.IndexOfName(Selected.Text) <> -1 then exit;

    Strings.AddObject(Selected.Text + '=0.0', TObject(Selected.Data));
    cbb_StdPrescription.Text:='未保存';
  end;

  if Sender = btn_Del_Chemical then
  begin
    vle_Chemicallist.DeleteRow(vle_Chemicallist.Row);
    cbb_StdPrescription.Text:='未保存';
  end;
end;

procedure TCreateStdPrescriptionForm.vle_ChemicallistValidate(
  Sender: TObject; ACol, ARow: Integer; const KeyName, KeyValue: String);
begin
  cbb_StdPrescription.Text:='未保存';
end;

initialization
  CreateStdPrescriptionForm:=nil;

finalization
  if CreateStdPrescriptionForm <> nil then
    CreateStdPrescriptionForm.Destroy;
end.
