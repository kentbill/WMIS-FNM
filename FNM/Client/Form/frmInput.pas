unit frmInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TInputForm = class(TForm)
    lblPrompt: TLabel;
    cbbWorkerList: TComboBox;
    btn1: TButton;
    btn2: TButton;
    lblMonitor: TLabel;
    cbbMonitorList: TComboBox;
    moRemark: TMemo;
    lbRemark: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ModifyProductWidth(const GF_NO: string): Boolean;
function InputBoxEx(const AWorkerList, AMonitorList: string; var AWorkerID, AMonitorID: string): Boolean;
function GetNewVatNo(BatchNO, MachineID, VatStudio, CurVatCode: String; Volume: Single): String;
var
  InputForm: TInputForm;

implementation

uses
  ServerDllPub, uShowMessage, uLogin, uDictionary, uGlobal, StrUtils;

{$R *.dfm}
function GetNewVatNo(BatchNO, MachineID, VatStudio, CurVatCode: String; Volume: Single): String;
var
  AForm: TInputForm;
  sErrorMsg: WideString;
begin
  Result := '';
  AForm := TInputForm.Create(nil);
  try
    AForm.Caption := 'ѡ���¸׺�';
    AForm.lblPrompt.Caption := '��ѡ���¸׺�:';
    AForm.cbbWorkerList.Style := csDropDownList;
    AForm.cbbMonitorList.Visible:=False;
    AForm.lblMonitor.Visible:=False;
    AForm.lbRemark.Visible := False;
    AForm.moRemark.Visible := False;
    AForm.Height := 115;

    Dictionary.cds_VatList.Filter:=Format('Machine_ID = ''%s'' AND Vat_Studio = ''%s'' AND Vat_Cubage >= %8.0f', [MachineID, VatStudio, Volume]);
    Dictionary.cds_VatList.Filter:=Format('Machine_ID = ''%s'' AND Vat_Studio = ''%s'' ', [MachineID, VatStudio]);
    Dictionary.cds_VatList.Filtered:=True;
    try
      TGlobal.FillComboBoxFromDataSet(Dictionary.cds_VatList, 'Vat_Code', 'Vat_NO', '->', AForm.cbbWorkerList);
    finally
      Dictionary.cds_VatList.Filtered:=False;
    end;

    TGlobal.SetComboBoxValue(AForm.cbbWorkerList, CurVatCode);
    if AForm.ShowModal = mrOK then
    begin
      Result := AForm.cbbWorkerList.Text;

      //���浽���ݿ�
      FNMServerArtObj.ChangeVatCode(BatchNO, LeftStr(Result, 8), sErrorMsg);
      if sErrorMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
        Exit;
      end;
    end;
  finally
    FreeAndNil(AForm);
  end;
end;

function InputBoxEx(const AWorkerList, AMonitorList: string; var AWorkerID, AMonitorID: string): Boolean;
var
  AForm: TInputForm;
begin
  Result := False;
  AForm := TInputForm.Create(nil);
  try
    AForm.Caption := 'ѡ��������';
    AForm.lblPrompt.Caption := '��ѡ��������:';
    AForm.lblMonitor.Caption := '��ѡ��೤:';
    AForm.cbbWorkerList.Style := csDropDownList;
    AForm.cbbMonitorList.Style := csDropDownList;
    AForm.cbbWorkerList.Items.Text := AWorkerList;
    AForm.cbbMonitorList.Items.Text := AMonitorList;
    AForm.lbRemark.Visible := False;
    AForm.moRemark.Visible := False;
    AForm.Height := 158;
    Result := AForm.ShowModal = mrOK;
    if Result then
    begin
      AWorkerID := AForm.cbbWorkerList.Text;
      AMonitorID := AForm.cbbMonitorList.Text;
    end;
  finally
    FreeAndNil(AForm);
  end;
end;        

function ModifyProductWidth(const GF_NO: string): Boolean;
var
  AForm: TInputForm;
  sReason, sGF_Key,sErrorMsg: WideString;
  iWidth: Double;
begin
  Result := False;
  AForm := TInputForm.Create(nil);
  try
    AForm.Caption := '�޸��ŷ�';
    AForm.lblPrompt.Caption := '������Ʒ��:';
    AForm.lblMonitor.Caption := '�������ŷ�:';
    AForm.cbbWorkerList.Style := csSimple;
    AForm.cbbWorkerList.Text := GF_NO;
    AForm.cbbMonitorList.Style := csSimple;
    AForm.lbRemark.Visible := True;
    AForm.moRemark.Visible := True;
    AForm.Height := 224;
    Result := AForm.ShowModal = mrOK;
    if Result then
    begin
      sReason := Trim(AForm.moRemark.Text);
      if sReason = '' then
      begin
        TMsgDialog.ShowMsgDialog('�������޸ķ����ԭ��', mtError);
        Exit;
      end;
      sGF_Key := AForm.cbbWorkerList.Text;
      iWidth := StrToFloat(AForm.cbbMonitorList.Text);
      FNMServerArtObj.ModifyProductWidth(sGF_Key, iWidth, sReason, Login.LoginName, sErrorMsg);
      if sErrorMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
        Exit;
      end;
    end;
  finally
    FreeAndNil(AForm);
  end;
end;

end.
