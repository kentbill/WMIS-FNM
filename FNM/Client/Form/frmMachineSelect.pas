unit frmMachineSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TMachineSelectForm = class(TForm)
    lblPrompt: TLabel;
    cbbMachineList: TComboBox;
    btn1: TButton;
    btn2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetSelectMachine(OrgMachine, CurDepartment: String): String;

var
  MachineSelectForm: TMachineSelectForm;

implementation

uses
  StrUtils, DB,
  ServerDllPub, uShowMessage, uLogin, uDictionary, uGlobal;

{$R *.dfm}

function GetSelectMachine(OrgMachine, CurDepartment: String): String;
var
  ADataSet: TDataSet;
begin
  MachineSelectForm:=TMachineSelectForm.Create(Application);

  ADataSet:=Dictionary.cds_FinishMachineList;
  try
    ADataSet.Filter:=Format('Machine_ID LIKE ''%s%%'' AND Department = ''%s''', [LeftStr(OrgMachine, 2), CurDepartment]);
    ADataSet.Filtered:=True;
    TGlobal.FillItemsFromDataSet(Dictionary.cds_FinishMachineList, 'Machine_ID', 'Machine_Model_CHN', '->', MachineSelectForm.cbbMachineList.Items);
    TGlobal.SetComboBoxValue(MachineSelectForm.cbbMachineList, OrgMachine);
    MachineSelectForm.ShowModal;

    if MachineSelectForm.ModalResult = mrCancel then
      Result:=''
    else
    begin
      Result:=MachineSelectForm.cbbMachineList.Text;
      Result:=LeftStr(Result, Pos('->', Result) - 1);
    end;
  finally
    ADataSet.Filtered:=False;
    FreeAndNil(MachineSelectForm);
  end;
end;        

end.
