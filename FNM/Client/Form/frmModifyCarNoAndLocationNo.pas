unit frmModifyCarNoAndLocationNo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TModifyCarNoAndLocationNoForm = class(TForm)
    lbl1: TLabel;
    edt1: TEdit;
    lbl2: TLabel;
    edt2: TEdit;
    btn1: TBitBtn;
    btn2: TBitBtn;
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
     FCarNo: string;
     FLocationNo: String;
  public
    { Public declarations }
    procedure Init(CarNo: String);
    procedure Clear();
    property CarNo :String  read FCarNo write FCarNo;
    property LocationNo :String  read FLocationNo write FLocationNo;
  end;

var
  ModifyCarNoAndLocationNoForm: TModifyCarNoAndLocationNoForm;

implementation

{$R *.dfm}

procedure TModifyCarNoAndLocationNoForm.btn2Click(Sender: TObject);
begin
  Close;
end;


procedure TModifyCarNoAndLocationNoForm.btn1Click(Sender: TObject);
begin
  FCarNo:= Trim(edt1.Text);
  FLocationNo:= Trim(edt2.Text);
  ModalResult:= mrOk;
end;
procedure TModifyCarNoAndLocationNoForm.Init(CarNo: String);
begin
  edt1.Text:= CarNo;
end;
procedure TModifyCarNoAndLocationNoForm.Clear;
begin
  edt1.Text:= '';
  edt2.Text:= '';
end;


end.
