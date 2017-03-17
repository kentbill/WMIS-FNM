unit frmSubRecipe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ValEdit, CheckLst;

type
  TSubRecipeForm = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    gbAdd: TGroupBox;
    SubChemicallist: TValueListEditor;
    gbDilute: TGroupBox;
    clbChemicalList: TCheckListBox;
    Label1: TLabel;
    cbRatioList: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    CheckData: Boolean;
  protected
    procedure UpdateActions; override;   
  public
    { Public declarations }
    ChemicalStr,UnitQtyStr: string;
    sType: string;
  end;

var
  SubRecipeForm: TSubRecipeForm;

implementation

uses uShowMessage;
{$R *.dfm}
procedure TSubRecipeForm.UpdateActions;
begin
  inherited;
  if sType = '冲稀' then
     btnOK.Enabled := cbRatioList.Text<>'';
end;

procedure TSubRecipeForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
 i: Integer;
 Value: string;
begin
  ChemicalStr := '';
  UnitQtyStr := '';
  //化料冲稀
  if CheckData and (sType = '冲稀') then
  begin
    if StrToFloat(cbRatioList.Text) > 100 then
    begin
       TMsgDialog.ShowMsgDialog('化料冲稀比例不能大于100!',mtInformation);
       Action := caNone;
       Exit;
    end;
    for i:=0 to clbChemicalList.Items.Count -1 do
    begin
      if clbChemicalList.Checked[i] then
      begin
        ChemicalStr := ChemicalStr + IntTostr(Integer(clbChemicalList.Items.Objects[i])) +'+';
        UnitQtyStr := UnitQtyStr + cbRatioList.Text + '+';
      end;
    end;
  end;

  //化料加料
  if CheckData and (sType = '加料') and (subChemicallist.Strings.Text <> '') then
  begin
    for i := 1 to SubChemicallist.RowCount - 1 do
    begin
      Value := Trim(SubChemicallist.Values[SubChemicallist.Keys[i]]);
      if (Value <> '') then
      begin
        ChemicalStr := ChemicalStr + IntTostr(Integer(SubChemicallist.Strings.Objects[i-1])) +'+';
        UnitQtyStr := UnitQtyStr + Value + '+';
      end;
    end;
  end;
  Action := caFree;
end;

procedure TSubRecipeForm.FormDestroy(Sender: TObject);
begin
  SubRecipeForm :=nil;
end;

procedure TSubRecipeForm.btnCancelClick(Sender: TObject);
begin
  CheckData := False;
  Close;
end;

procedure TSubRecipeForm.btnOKClick(Sender: TObject);
begin
  CheckData := True;
end;

end.
