unit uConditionEditor;

interface

uses
  Windows, Messages, Classes, ExtCtrls, Controls, Dialogs, Variants, Forms, StdCtrls,
  ComCtrls, SysUtils, StrUtils, Contnrs, IdGlobal;

resourcestring
  WAR_InputDataType=                  'WAR_对于%s必须输入%s或格式不正确.';

type
  TConditionType = (ctString, ctNumber, ctDate, ctDateTime, ctBoolean);

  {TItemName}
  TConditionItem = class(TCollectionItem)
  private
    { Private declarations }
    FConditionName: string;
    FConditionCaption: string;
    FConditionType: TConditionType;
    FConditionHint: string;
    FDefaultValue: string;
    FEmunItem: string;
    function GetCompareOperates: string;
    function GetDefaultValue: string;
  protected
    { Protected declarations }
    function GetDisplayName: string; override;
  public
    { Public declarations }
    constructor Create(Collection: TCollection); override;
  published
    { Published declarations }
    property ConditionName: string read FConditionName write FConditionName;
    property ConditionCaption: string read FConditionCaption write FConditionCaption;
    property CompareOperates: string read GetCompareOperates;
    property ConditionType: TConditionType read FConditionType write FConditionType default ctString;
    property ConditionHint: string read FConditionHint write FConditionHint;
    property DefaultValue: string read GetDefaultValue write FDefaultValue;
    property EmunItem: string read FEmunItem write FEmunItem;
  end;

  TConditionItems = class(TCollection);

  TValueEdit = class(TComboBox)
  private
    { Private declarations }
    FKind: TConditionType;
    procedure SetKind(const Value: TConditionType);
  public
    { public declarations }
  published
    { published declarations }
    property Kind: TConditionType read FKind write SetKind;
  end;

  TMakeConditionController = class(TComponent)
  private
    { Private declarations }
    FTitle: string;
    FConditionItems: TConditionItems;
    FConditionString: string;
    FPreDeclareString: string;
    
    FComponentList: TComponentList;
    FCpationComboBox: TComboBox;
    FCompareComboBox: TComboBox;
    FConditionValueControl: TValueEdit;
    FConditionListBox: TListBox;

    procedure CpationComboBoxChange(Sender: TObject);
    procedure ControlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AddCondition(Sender: TObject);
    procedure ClearConditionList(Sender: TObject);
    procedure CloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CreateControls(ParentControl: TWinControl);
    procedure SetValueEidtControlStyle(AEditControl: TWinControl);
    function GetExpression(IsDispLay: Boolean; CompareOperate: String; AEditControl: TComponent): String;
    function GetPreDeclares: String;
    function GetConditions: String;
  protected
    { protected declarations }
    function DoExecute: Boolean;
  public
    { public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function Execute: Boolean;
  published
    { published declarations }
    property ConditionItems: TConditionItems read FConditionItems write FConditionItems;
    property ConditionString: string read FConditionString;
    property PreDeclareString: string read FPreDeclareString;
    property Title: string read FTitle write FTitle;
  end;

procedure Register;

implementation

{ TConditionItem }

procedure Register;
begin
  RegisterComponents('Dialogs', [TMakeConditionController]);
end;

function TConditionItem.GetDisplayName: string;
begin
  if FConditionCaption = '' then
    Result := inherited GetDisplayName
  else
    Result := FConditionCaption;
end;

constructor TConditionItem.Create(Collection: TCollection);
begin
  inherited;
  ConditionType:=ctString;
end;

function TConditionItem.GetCompareOperates: string;
begin
  result:='=/<>/';
  if FConditionType = ctString then
    result := result + '>/</>=/<=/Like';
  if FConditionType in [ctNumber, ctDateTime] then
    result := result + '>/</>=/<=';
end;

function TConditionItem.GetDefaultValue: string;
begin
  Result := FDefaultValue;
  if Result <> '' then exit;

  if ConditionType = ctDateTime then
    result:=DateTimeToStr(Now);

  if ConditionType = ctDate then
    result:=DateToStr(Now);

  if ConditionType = ctNumber then
    result:='0';
end;

function CreateNewConditionDialog: TForm;
var
  FormWith: Integer;
begin
  FormWith:=395;
  result:=TForm.CreateNew(Application);
  with result do
  begin
    Canvas.Font := Font;
    KeyPreview := True;
    BorderStyle := bsDialog;
    Font.Name:='宋体';
    Font.Size:=9;
    Position := poScreenCenter;
    BiDiMode := Application.BiDiMode;
    Width:=FormWith;
  end;
end;

{ TValueEdit }

procedure TValueEdit.SetKind(const Value: TConditionType);
var
  EditStyle: Longint;
  pcbi: TComboBoxInfo;
begin
  if FKind = Value then exit;

  FKind := Value;
  //ctString, ctNumber, ctDate, ctDateTime, ctBoolean
  Text:=''; ItemIndex:= -1;
  pcbi.cbSize:=SizeOf(TComboBoxInfo);
  if GetComboBoxInfo(Handle, pcbi) then
  begin
    EditStyle:=GetWindowLong(pcbi.hwndItem, GWL_STYLE);
    if FKind = ctNumber then
      SetWindowLong(pcbi.hwndItem, GWL_STYLE, EditStyle or ES_NUMBER)
    else
      SetWindowLong(pcbi.hwndItem, GWL_STYLE, EditStyle and not ES_NUMBER);
  end;

  if FKind = ctDate then
    Text:=DateToStr(Now);

  if FKind = ctDateTime then
    Text:=DateTimeToStr(Now);
end;

{ TMakeConditionDialog }

constructor TMakeConditionController.Create(AOwner: TComponent);
begin
  inherited;
  Title:='条件编辑器';
  FConditionString:='';
  FPreDeclareString:='';
  FComponentList:=TComponentList.Create;
  FConditionItems:=TConditionItems.Create(TConditionItem);
end;

destructor TMakeConditionController.Destroy;
begin
  FConditionItems.Free;
  FComponentList.Free;

  inherited;
end;

procedure TMakeConditionController.CloseQuery(Sender: TObject; var CanClose: Boolean);
var
  ConditionStr, PreDeclareStr: String;
begin
  CanClose := True;
  if (Sender as TForm).ModalResult <> mrOK then
    exit;

  ConditionStr:=GetConditions;
  PreDeclareStr:=GetPreDeclares;
  if (FConditionListBox <> nil) and (ConditionStr = '') then
  begin
    //请输入自定义条件
    CanClose := False;
  end;

  if CanClose then
  begin
    //请输入指定条件
    if (FComponentList.Count <> 0) and (PreDeclareStr = '')then
      CanClose := False;
  end;
end;

function TMakeConditionController.DoExecute: Boolean;
var
  ConditionDialog: TForm;
begin
  try
    FConditionString:='';
    FPreDeclareString:='';
    if true then
    begin
      ConditionDialog:=nil;
      ConditionDialog:=CreateNewConditionDialog;
      ConditionDialog.Caption:=Title;
      CreateControls(ConditionDialog);
      if FCpationComboBox <> nil then
        CpationComboBoxChange(FCpationComboBox);
      ConditionDialog.ShowModal;
      result:=ConditionDialog.ModalResult = mrok;
      if result then
      begin
        FConditionString:=GetConditions;
        FPreDeclareString:=GetPreDeclares;
      end;
    end;
    FComponentList.Clear;
    FCpationComboBox:=nil;
    FCompareComboBox:=nil;
    FConditionValueControl:=nil;
    FConditionListBox:=nil;
  finally
    FreeAndNil(ConditionDialog);
  end;
end;

procedure TMakeConditionController.CpationComboBoxChange(Sender: TObject);
var
  ConditionItem: TConditionItem;
begin
  if Sender = nil then exit;
    
  with Sender as TComboBox do
  begin
    if ItemIndex = -1 then exit;

    ConditionItem:=ConditionItems.Items[Integer(Items.Objects[ItemIndex])] as TConditionItem;
  end;   
  
  FCompareComboBox.Items.Text:=StringReplace(ConditionItem.CompareOperates, '/', #13, [rfReplaceAll]);
  FCompareComboBox.ItemIndex:=0;
  FConditionValueControl.Tag:=ConditionItem.Index;
  SetValueEidtControlStyle(FConditionValueControl);
end;

procedure TMakeConditionController.ControlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  AForm: TCustomForm;
begin
  if key <> VK_RETURN then exit;
  AForm:=GetParentForm(Sender as TWinControl);

  if AForm <> nil then
  begin
    if AForm.ActiveControl = FConditionValueControl then
    begin
      AddCondition(nil);
      FCpationComboBox.SetFocus;
    end
    else
      AForm.PerForm(WM_NEXTDLGCTL, 0, 0);
  end
end;

procedure TMakeConditionController.AddCondition(Sender: TObject);
var
  CompareOperate, Expression: string;
begin
  if (Sender = nil) or ((Sender as TWinControl).Name = 'Button_And') then
    CompareOperate:='AND';

  if (Sender <> nil) and ((Sender as TWinControl).Name = 'Button_Or') then
    CompareOperate:='OR';

  Expression:=GetExpression(True, FCompareComboBox.Text, FConditionValueControl);
  if FConditionListBox.Items.Count <> 0 then
    FConditionListBox.Items.AddObject(CompareOperate, TObject(9999));
  FConditionListBox.Items.AddObject(Expression, TObject(FConditionValueControl.Tag));
end;

procedure TMakeConditionController.ClearConditionList(Sender: TObject);
begin
  if FConditionListBox <> nil then
    FConditionListBox.Items.Clear;
end;

procedure TMakeConditionController.CreateControls(ParentControl: TWinControl);
var
  i, ctop, cLeft, FormWith,
    ValueControlWith, PreDecConditionCount: Integer;
  NewControl: TWinControl;
begin
  ctop:=5; cLeft:=5; FormWith:=395; ValueControlWith:=140;
  PreDecConditionCount:=0;

  if ParentControl.ClassNameIs('TForm') then
  begin
    (ParentControl as TForm).OnKeyDown:=ControlKeyDown;
    (ParentControl as TForm).OnCloseQuery:=CloseQuery;
  end;
  //预定义条件
  for i := 0 to ConditionItems.Count - 1 do
  with (ConditionItems.Items[i] as TConditionItem) do
  begin
    if (ConditionName = '') or (ConditionName[1] <> '@') then
      Continue;

    //Create Edit Control
    if (not (ConditionType in [ctBoolean])) or (EmunItem <> '') then
    with TStaticText.Create(ParentControl) do
    begin
      Parent:=ParentControl;
      Caption:=ConditionCaption + ':';
      SetBounds(FormWith div 3 - cLeft - Width, ctop + 6, Width, Height);
    end;

    NewControl:=nil;
    if (ConditionType in [ctDateTime, ctDate, ctString, ctNumber]) or (EmunItem <> '')then
      NewControl:=TValueEdit.Create(ParentControl)
    else if ConditionType in [ctBoolean] then
      NewControl:=TCheckBox.Create(ParentControl);

    if NewControl <> nil then
    with NewControl do
    begin
      Parent:=ParentControl;
      Tag:=Index;
      SetBounds(FormWith div 3, ctop, ValueControlWith, Height);
      SetValueEidtControlStyle(NewControl);
    end;

    FComponentList.Add(NewControl);
    cTop:= cTop + NewControl.Height + 2;
    inc(PreDecConditionCount);
  end;

  //用户定义条件
  //Create Edit Control
  cTop:= cTop + 4;
  if PreDecConditionCount < ConditionItems.Count then
  begin
    FCpationComboBox:=TComboBox.Create(ParentControl);
    with FCpationComboBox do
    begin
      Parent:=ParentControl;
      FCpationComboBox.Style:=csDropDownList;
      SetBounds(cLeft, ctop, 140, Height);
      FCpationComboBox.OnChange:=CpationComboBoxChange;

      //加入可选条件
      for i := 0 to ConditionItems.Count - 1 do
      with ConditionItems.Items[i] as TConditionItem do
      begin
        if (ConditionName = '') or (ConditionName[1] = '@') then
          Continue;
        AddItem(ConditionCaption, TObject(Index));
      end;
      FCpationComboBox.ItemIndex:=0;
    end;

    FCompareComboBox:= TComboBox.Create(ParentControl);
    with FCompareComboBox do
    begin
      Parent:=ParentControl;
      SetBounds(cLeft + 140 + 5, ctop, 90, Height);
    end;

    FConditionValueControl:=TValueEdit.Create(ParentControl);
    with FConditionValueControl do
    begin
      Parent:=ParentControl;
      SetBounds(cLeft + 140 + 90 + 10, ctop, 140, Height);
      cTop:= cTop + Height + 2;
    end;

    FConditionListBox:=TListBox.Create(ParentControl);
    with FConditionListBox do
    begin
      Parent:=ParentControl;
      TabStop:=false;
      SetBounds(cLeft, ctop, 235, Height);
    end;

    cLeft:=245;
    cTop:= cTop + 6;
    with TButton.Create(ParentControl) do
    begin
      Parent:=ParentControl;
      Name:='Button_And';
      Caption:='&AND';
      TabStop:=false;
      SetBounds(cLeft, ctop, 68, Height);
      OnClick:=AddCondition
    end;

    with TButton.Create(ParentControl) do
    begin
      Parent:=ParentControl;
      Name:='Button_Or';
      TabStop:=false;
      Caption:='&OR';
      SetBounds(cLeft + 68 + 5, ctop, 68, Height);
      OnClick:=AddCondition;
      cTop:= cTop + Height + 6;
    end;

    with TButton.Create(ParentControl) do
    begin
      Parent:=ParentControl;
      SetBounds(cLeft, ctop, 140, Height);
      TabStop:=false;
      Caption:='清除(&L)';
      cTop:= cTop + Height + 6;
      OnClick:=ClearConditionList;
    end;
  end;
    
  cLeft:=245;
  with TButton.Create(ParentControl) do
  begin
    Parent:=ParentControl;
    ModalResult:=mrOK;
    TabStop:=false;
    Caption:='运行(&R)';
    SetBounds(cLeft, ctop, 68, Height);
  end;

  with TButton.Create(ParentControl) do
  begin
    Parent:=ParentControl;
    Cancel:=true;
    ModalResult:=mrCancel;
    Caption:='取消(&C)';
    TabStop:=false;
    SetBounds(cLeft + 68 + 5, ctop, 68, Height);
    cTop:= cTop + Height + 6;
  end;
  //设置窗体客户区
  ParentControl.ClientHeight:= cTop + 4;
end;

procedure TMakeConditionController.SetValueEidtControlStyle(AEditControl: TWinControl);
var
  i: Integer;
  DefaultBoolean: Boolean;
begin
  if ConditionItems = nil then exit;
  with ConditionItems.Items[AEditControl.Tag] as TConditionItem do
  begin
    if AEditControl.ClassNameIs('TValueEdit') then
    with AEditControl as TValueEdit do
    begin
      CharCase := ecUpperCase;
      Kind:=FConditionType;

      Items.Text:=StringReplace(EmunItem, '/', #13, [rfReplaceAll]);
      if EmunItem = '' then
        Style:=csSimple
      else
        if EmunItem[Length(EmunItem)] = '/' then Style:=csDropDown else Style:=csDropDownList;

      if DefaultValue <> '' then
      begin
        Text:=DefaultValue;
        if Style = csDropDownList then
        for i := 0 to Items.Count - 1 do
        if Pos(DefaultValue, Items.Strings[i]) > 0 then
        begin
          ItemIndex:=i;
          Break;
        end;
      end;
    end;

    if AEditControl.ClassNameIs('TCheckBox') then
    with AEditControl as TCheckBox do
    begin
      Caption:=ConditionCaption;
      if (DefaultValue <> '') and TryStrToBool(DefaultValue, DefaultBoolean) then
        Checked:=DefaultBoolean;
    end;

    AEditControl.Visible:=True;
  end;
end;

function TMakeConditionController.GetExpression(IsDispLay: Boolean; CompareOperate: String; AEditControl: TComponent): String;
var
  TempInt: Integer;
  TempBool: Boolean;
  TempDateTime: TDateTime;
  AConditionItem: TConditionItem;
  FactConditionValue, ConditionValue, TempExpression: String;
begin
  if AEditControl.ClassNameIs('TListBox') then
    with AEditControl as TListBox do
      AConditionItem:=FConditionItems.Items[Integer(Items.Objects[ItemIndex])] as TConditionItem
  else
    AConditionItem:=FConditionItems.Items[AEditControl.Tag] as TConditionItem;
    
  if AEditControl.ClassNameIs('TValueEdit') then
    ConditionValue:=(AEditControl as TComboBox).Text;

  if AEditControl.ClassNameIs('TCheckBox') then
    ConditionValue:= Ifthen((AEditControl as TCheckBox).Checked, '1', '0');

  if AEditControl.ClassNameIs('TListBox') then
  with AEditControl as TListBox do
  begin
    TempExpression:=Items.Strings[ItemIndex];
    System.Delete(TempExpression, 1, Pos(' ', TempExpression));
    CompareOperate:=LeftStr(TempExpression,  Pos(' ', TempExpression) - 1);
    ConditionValue:=MidStr(TempExpression, Pos(' ', TempExpression) + 1, MAXINT);
    System.Delete(ConditionValue, 1, 1);
    SetLength(ConditionValue, Length(ConditionValue) - 1);
  end;

  FactConditionValue:=ConditionValue;
  if Pos('->', FactConditionValue) > 0 then
    FactConditionValue:=LeftStr(FactConditionValue, Pos('->', FactConditionValue) - 1);
  if not IsDispLay then
    ConditionValue:=FactConditionValue;

  case AConditionItem.ConditionType of
    ctNumber:           if not TryStrToInt(FactConditionValue, TempInt) then raise Exception.CreateResFmt(@WAR_InputDataType, [AConditionItem.FConditionCaption, '整数']);
    ctBoolean:          if not TryStrToBool(FactConditionValue, TempBool) then raise Exception.CreateResFmt(@WAR_InputDataType, [AConditionItem.FConditionCaption, '0/1']);
    ctDate, ctDateTime: if not TryStrToDateTime(FactConditionValue, TempDateTime) then raise Exception.CreateResFmt(@WAR_InputDataType, [AConditionItem.FConditionCaption, '日期']);
  end;
    
  result:=Format('%s %s ''%s''',
    [Ifthen(IsDispLay, AConditionItem.ConditionCaption, AConditionItem.ConditionName), CompareOperate, ConditionValue]);
end;

function TMakeConditionController.GetPreDeclares: String;
var
  i: Integer;
  Component: TComponent;
  ConditionName: String;
begin
  result:='';
  for i := 0 to FComponentList.Count - 1 do
  begin
    Component:=FComponentList.Items[i];
    ConditionName:=(FConditionItems.Items[Component.Tag] as TConditionItem).ConditionName;

    if (ConditionName = '') or (ConditionName[1] <> '@') then
      Continue;

    result := result + GetExpression(false, '=', Component) + ', ';
  end;
  
  if result <> '' then result[Length(result) - 1]:=' ';
end;

function TMakeConditionController.GetConditions: String;
var
  i: Integer;
begin
  result:='';
  if FConditionListBox = nil then exit;
  for i := 0 to FConditionListBox.Count - 1 do
  begin
    FConditionListBox.ItemIndex:=i;
    if Integer(FConditionListBox.Items.Objects[i]) = 9999 then
      result := result + ' ' + FConditionListBox.Items.Strings[i] + ' ' 
    else
      result := result + GetExpression(false, ' ', FConditionListBox);
  end;
end;

function TMakeConditionController.Execute: Boolean;
begin
  result:=DoExecute
end;

end.

