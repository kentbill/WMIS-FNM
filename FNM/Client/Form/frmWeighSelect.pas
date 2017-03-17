unit frmWeighSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TWeighSelectForm = class(TForm)
    rgSel: TRadioGroup;
    Panel1: TPanel;
    edtPassword: TEdit;
    Button1: TButton;
    Label1: TLabel;
    procedure rgSelClick(Sender: TObject);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  function GetSel:extended;

var
  WeighSelectForm: TWeighSelectForm;

implementation

{$R *.dfm}
function GetSel:Extended;
begin
  Result := 0.0;
  WeighSelectForm:=TWeighSelectForm.Create(Application);
  try
    WeighSelectForm.ShowModal;
    WeighSelectForm.Panel1.SendToBack;
    if WeighSelectForm.ModalResult = mrOK then
      Result:= StrToFloat(WeighSelectForm.Hint);
  finally
    FreeAndNil(WeighSelectForm);
  end;
end;

procedure TWeighSelectForm.rgSelClick(Sender: TObject);
begin
  case rgSel.ItemIndex of
    0: begin self.Hint := '20'; self.ModalResult := mrOK; end;
    1: begin self.Hint := '25'; self.ModalResult := mrOK; end;
    2: begin self.Hint := '30'; self.ModalResult := mrOK; end;
    3: begin
         self.Hint := '0.0';
         Panel1.BringToFront;
         if edtPassword.CanFocus then edtPassword.SetFocus;
       end;
  end;
end;

procedure TWeighSelectForm.edtPasswordKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
  begin
    if UpperCase(edtPassword.Text) = 'POWER' then
    begin
       self.Hint := InputBox('手工称重','请输入称重量','0.0');
       self.ModalResult := mrOK;
    end else
      Showmessage('密码错误');
  end;
end;

end.
