unit frmModifyCarNO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TModifyCarNOForm = class(TForm)
    txt1: TStaticText;
    txt2: TStaticText;
    txt3: TStaticText;
    btn1: TButton;
    btn2: TButton;
    edt_Card: TEdit;
    edt_CarNO: TEdit;
    cbb_Operator: TComboBox;
    StaticText1: TStaticText;
    edt_RollNO: TEdit;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ModifyCarNO(Operators: String);
implementation

uses
  StrUtils, uShowMessage, uLogin, ServerDllPub;

{$R *.dfm}

procedure ModifyCarNO(Operators: String);
begin
  if Operators = '' then
    raise Exception.Create('WAR_��ǰ��̨û�а�����Ա');

  with TModifyCarNOForm.Create(Application) do
  try
    cbb_Operator.Items.Text:=Operators;
    ShowModal;
  finally 
    Free
  end;
end;

procedure TModifyCarNOForm.btn1Click(Sender: TObject);
var
  sSQL, sErrorMsg: WideString;
begin
  if edt_Card.Text = '' then
    raise Exception.Create('WAR_�����뿨��');

  if edt_CarNO.Text = '' then
    raise Exception.Create('WAR_�������³���');

  if LeftStr(cbb_Operator.Text, 7) = '' then
    raise Exception.Create('WAR_��ѡ���޸���');

  if edt_RollNO.Text = '' then
    raise Exception.Create('WAR_�������λ��');

  //FNMServerObj.SaveCarInfo(edt_Card.Text, edt_CarNO.Text, LeftStr(cbb_Operator.Text, 7), ExtractFileName(Application.ExeName), Login.WorkStation, sErrorMsg);
  sSQL := QuotedStr(edt_Card.Text)+ ','
        + QuotedStr(edt_CarNO.Text)+ ','
        + QuotedStr(edt_RollNO.Text)+ ','
        + QuotedStr(LeftStr(cbb_Operator.Text, 7))+ ','
        + QuotedStr(ExtractFileName(Application.ExeName))+ ','
        + QuotedStr(Login.WorkStation);
  FNMServerObj.SaveDataBySQL('fnSaveCarInfo',sSQL, sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;
  TMsgDialog.ShowMsgDialog('�������ݳɹ�', mtInformation);
end;

end.
