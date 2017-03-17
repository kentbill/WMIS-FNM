unit uTerminal;

interface

uses
  uFNMResource, Forms, ComCtrls, Controls, SysUtils;

procedure CreateComControl(AForm: TForm);

var
  MachineName, RecipeVatStudio, DistributeSource: String;

implementation

procedure CreateComControl(AForm: TForm);
begin
  with TStatusBar.Create(AForm) do
  begin
    Name := 'StatusBar';
    Parent := AForm;
    Top := AForm.Height;
    Align := alBottom;
    AutoHint := True;
    ParentFont:=true;

    with Panels.Add do
    begin
      Text:=GetResourceString(@STA_Ready);
      Width := 250;
    end;
    with Panels.Add do
    begin
      Text := GetResourceString(@STA_LoginTime) + DateTimeToStr(Now);
      Width := 180;
    end;
  end;
end;

end.
