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
    AForm.Caption := '选择新缸号';
    AForm.lblPrompt.Caption := '请选择新缸号:';
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

      //保存到数据库
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
    AForm.Caption := '选择责任人';
    AForm.lblPrompt.Caption := '请选择责任人:';
    AForm.lblMonitor.Caption := '请选择班长:';
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
    AForm.Caption := '修改门幅';
    AForm.lblPrompt.Caption := '请输入品名:';
    AForm.lblMonitor.Caption := '请输入门幅:';
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
        TMsgDialog.ShowMsgDialog('请输入修改幅宽的原因', mtError);
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
