unit frmAffirmBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TAffirmBoxForm = class(TForm)
    cboClass: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    mRemark: TMemo;
    btnSave: TButton;
    groupbox1: TGroupBox;

    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure CreateNewRemark(GF_ID:string;step_no:string;operation_code:string);

implementation

uses  StrUtils, uDictionary, UAppOption,
    uFNMArtInfo, uGlobal, ServerDllPub, uFNMResource,
    uLogin, uShowMessage;

{$R *.dfm}
var
  AffirmBoxForm: TAffirmBoxForm;
  mGF_ID:string;
  mStep_NO :string;
  mOperation_Code:string;

procedure CreateNewRemark(GF_ID:string;step_no:string;operation_code:string);
begin
   if AffirmBoxForm = nil then
     AffirmBoxForm:=TAffirmBoxForm.Create(Application);
   with AffirmBoxForm do
   begin
     mGF_ID := GF_ID;
     mStep_NO := step_no;
     mOperation_Code := operation_code;
   end;
   AffirmBoxForm.ShowModal;
end;

procedure TAffirmBoxForm.btnSaveClick(Sender: TObject);
var
  sCondition,sErrorMsg: WideString;
  i:Integer;
begin
    sCondition := QuotedStr(mGF_ID)+ ','
                + mStep_NO+ ','
                + QuotedStr(mOperation_Code) + ','
                + QuotedStr(login.CurrentDepartment) + ','
                + QuotedStr(cboClass.Text) + ','
                + QuotedStr(mRemark.Lines.Text);
    FNMServerObj.SaveDataBySQL('SaveAffirmRmark',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog('ÐÞ¸ÄÊ§°Ü!',mtError);
      Exit;
    end;
    AffirmBoxForm.Close;
    AffirmBoxForm := nil;
end;

end.
