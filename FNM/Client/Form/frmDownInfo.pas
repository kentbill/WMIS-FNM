unit frmDownInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TDownInfoForm = class(TForm)
    edtWidth: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtCar_NO: TEdit;
    edtRoll: TEdit;
    Label3: TLabel;
    btnClose: TBitBtn;
    btnOK: TBitBtn;
    procedure btnOKClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sWith,sCarNo,sRoll:string;
  end;

var
  DownInfoForm: TDownInfoForm;

implementation

{$R *.dfm}

procedure TDownInfoForm.btnOKClick(Sender: TObject);
begin
  sWith := edtWidth.Text;
  sCarNo := edtCar_NO.Text;
  sRoll := edtRoll.Text;
  //Close;
end;

procedure TDownInfoForm.btnCloseClick(Sender: TObject);
begin
  sWith := '';
  sCarNo := '';
  sRoll := '';
  Close;
end;

end.
