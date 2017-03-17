unit frmSelectFNColorCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBClient, ExtCtrls;

type
  TSelectFNColorCodeForm = class(TForm)
    cbbFNColorCode: TComboBox;
    Label1: TLabel;
    btn1: TButton;
    btn2: TButton;
    plShowColor: TPanel;
    edtRGB: TEdit;
    Label6: TLabel;
    cbSimpleColor: TComboBox;
    cbbDegree: TComboBox;
    dsFNColor: TClientDataSet;
    procedure cbbFNColorCodeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function SelectFNColorCode(cds:TClientDataSet): String;

var
  SelectFNColorCodeForm: TSelectFNColorCodeForm;

implementation

uses uGlobal;

{$R *.dfm}

function SelectFNColorCode(cds:TClientDataSet): String;
begin
  SelectFNColorCodeForm:=TSelectFNColorCodeForm.Create(Application);

  try
    TGlobal.FillItemsFromDataSet(cds, 'FN_Color_Code','','', SelectFNColorCodeForm.cbbFNColorCode.Items);
    TGlobal.FillItemsFromDataSet(cds, 'Simple_Color_Name','','', SelectFNColorCodeForm.cbSimpleColor.Items);
    TGlobal.FillItemsFromDataSet(cds, 'Degree','','', SelectFNColorCodeForm.cbbDegree.Items);
{
    SelectFNColorCodeForm.cbbFNColorCode.ItemIndex := 1;
    SelectFNColorCodeForm.cbSimpleColor.ItemIndex := SelectFNColorCodeForm.cbbFNColorCode.ItemIndex;
    SelectFNColorCodeForm.cbbDegree.ItemIndex := SelectFNColorCodeForm.cbbFNColorCode.ItemIndex;
}
    SelectFNColorCodeForm.dsFNColor.Data := cds.Data;
    SelectFNColorCodeForm.ShowModal;

    if SelectFNColorCodeForm.ModalResult = mrCancel then
      Result:=''
    else
    begin
      Result:=SelectFNColorCodeForm.cbbFNColorCode.Text;
    end;
  finally
    FreeAndNil(SelectFNColorCodeForm);
  end;
end;

procedure TSelectFNColorCodeForm.cbbFNColorCodeChange(Sender: TObject);
begin
  if cbbFNColorCode.ItemIndex>=0 then
  begin
    if dsFNColor.Active then
    begin
      if dsFNColor.Locate('FN_Color_Code', cbbFNColorCode.Text, []) then
      begin
        TGlobal.SetComboBoxValue(cbSimpleColor, dsFNColor.FieldByName('Simple_Color_Name').AsString);
        TGlobal.SetComboBoxValue(cbbDegree, dsFNColor.FieldByName('Degree').AsString);

        //cbSimpleColor.Text := dsFNColor.FieldByName('Simple_Color_Name').AsString;
        //cbbDegree.Text := dsFNColor.FieldByName('Degree').AsString;
        edtRGB.Text := dsFNColor.FieldByName('RGB').AsString;
        plShowColor.Color := dsFNColor.FieldByName('RGB').AsInteger;
      end
    end
  end
end;

end.
