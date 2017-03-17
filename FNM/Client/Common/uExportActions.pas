unit uExportActions;

interface

{$DEFINE cxGrid}
{$IFDEF cxGrid}
  {$MESSAGE Warn '如果你的工程中没有使用cxGrid控件，请注释掉上面的行，以减少Exe文件的大小!'}
{$ENDIF}

{$DEFINE DBGrid}
{$IFDEF DBGrid}
  {$MESSAGE Warn '如果你的工程中没有使用DBGrid控件，请注释掉上面的行，以减少Exe文件的大小!'}
{$ENDIF}

{$DEFINE StringGrid}
{$IFDEF StringGrid}
  {$MESSAGE Warn '如果你的工程中没有使用StringGrid控件，请注释掉上面的行，以减少Exe文件的大小!'}
{$ENDIF}

{$DEFINE ListView}
{$IFDEF ListView}
  {$MESSAGE Warn '如果你的工程中没有使用ListView控件，请注释掉上面的行，以减少Exe文件的大小!'}
{$ENDIF}

{$IFNDEF cxGrid} {$IFNDEF StringGrid} {$IFNDEF DBGrid} {$IFNDEF ListView}
  {$MESSAGE Error '你不能注释上面的所有行！如果你工程中没有使用任何表格或者不打算使用导出Action，请不要引用这个单元！'}
{$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF}

uses ActnList, Controls, Classes, Dialogs, SysUtils, Forms, StdCtrls, uCADInfo,Windows,ShellAPI
    {$IFDEF cxGrid}
    , cxGrid, cxExportGrid4Link, cxGridCustomView, cxGridTableView, cxGridCustomTableView,
    cxGridDBDataDefinitions
    {$ENDIF}
    {$IFDEF StringGrid}
    , Grids
    {$ENDIF}
    {$IFDEF DBGrid}
    , DBGrids, DB
    {$ENDIF}
    {$IFDEF ListView}
    , ComCtrls
    {$ENDIF}
    ;
const
  ExportToText   = 0;
  ExportToXml    = 1;
  ExportToExcel  = 2;
  ExportToHtml   = 3;


type
  TExportAction = class(TAction)
  private
    EnableClass: String;
    FControl: TWinControl;
    procedure SetControl(Value: TWinControl);
  protected
    function GetControl(Target: TObject): TWinControl;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
    property GridControl: TWinControl read FControl write SetControl;
  end;

  {$IFDEF cxGrid}
  TShowcxGridGroupByBox = class(TAction)
  private
    FControl: TWinControl;
    procedure SetControl(Value: TWinControl);
  protected
    function GetControl(Target: TObject): TWinControl;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
    property cxGridControl: TWinControl read FControl write SetControl;
  end;
  {$ENDIF}

implementation

function GetSaveFileName(FilterStr: string): string;
var
  SaveDialog: TSaveDialog;
label
  ReAnswer;
begin
  SaveDialog:=nil;
  try
    SaveDialog:=TSaveDialog.Create(nil);
    SaveDialog.Filter:=FilterStr;
    SaveDialog.DefaultExt:='*.xls';
    ReAnswer:
      result:='';
      if SaveDialog.Execute then
      begin
        result:= SaveDialog.FileName;
        if FileExists(result) and (mrNo =
            MessageDlg(Format('The file %s already exists.Do you want to replace the existing file?', [result]), mtWarning, [mbYes, mbNo], 0)) then
          goto ReAnswer;
      end;
  finally
    FreeAndNil(SaveDialog);
  end;
end;

{$IFDEF cxGrid}
procedure ExportAcxGrid(AGrid: TcxGrid; AFileName: string; FileType: integer);
begin
  case FileType of
    ExportToExcel: cxExportGrid4Link.ExportGrid4ToExcel(AFileName, AGrid);
    ExportToHtml:  cxExportGrid4Link.ExportGrid4ToHTML(AFileName,AGrid);
    ExportToText:  cxExportGrid4Link.ExportGrid4ToText(AFileName, AGrid);
    ExportToXml:   cxExportGrid4Link.ExportGrid4ToXML(AFileName,AGrid);
  end;
end;
{$ENDIF}

{$IFDEF DBGrid}
procedure ExportDBGridToHTML(const AFileName: string; AGrid: TDBGrid);
begin
  raise Exception.CreateFmt('%s Save To %s', [AGrid.ClassName, AFileName]);
end;

procedure ExportDBGridToXML(const AFileName: string; AGrid: TDBGrid);
begin
  raise Exception.CreateFmt('%s Save To %s', [AGrid.ClassName, AFileName]);
end;

procedure ExportDBGridToExcel(const AFileName: string; AGrid: TDBGrid);
begin
  raise Exception.CreateFmt('%s Save To %s', [AGrid.ClassName, AFileName]);
end;

procedure ExportDBGridToText(const AFileName: string; AGrid: TDBGrid; const ASeparator: string = '');
var
  i, j: Integer;
  ValueStr: string;
label
  EndTry;
begin
  with AGrid do
  if (DataSource = nil) or (DataSource.DataSet = nil) or (not DataSource.DataSet.Active) then
  begin
    for i := 0 to Columns.Count - 1 do
      ValueStr:= ValueStr + Columns.Items[i].Title.Caption;
    ValueStr:=ValueStr + #13#10;
    goto EndTry;
  end;

  with AGrid do
  try
    for i := 0 to Columns.Count - 1 do
      ValueStr:= ValueStr + AGrid.Columns.Items[i].Field.DisplayLabel;
    ValueStr:=ValueStr + #13#10;

    DataSource.DataSet.DisableControls;
    DataSource.DataSet.First;
    for i := 0 to DataSource.DataSet.RecordCount - 1 do
    begin
      for j := 0 to Columns.Count - 1 do
        ValueStr:=ValueStr + DataSource.DataSet[Columns.Items[j].Field.FieldName] + #9' ';
      ValueStr:=ValueStr + #13#10;
      DataSource.DataSet.Next;
    end;

  finally
    DataSource.DataSet.EnableControls;
  end;
  EndTry:
  raise Exception.CreateFmt('%s Save To %s', [ValueStr, AFileName]);
end;

procedure ExportADBGrid(AGrid: TDBGrid; AFileName: string; FileType: integer);
begin
  case FileType of
    ExportToHtml:  ExportDBGridToHTML(AFileName,AGrid);
    ExportToXml:   ExportDBGridToXML(AFileName,AGrid);
    ExportToText:  ExportDBGridToText(AFileName, AGrid);
    ExportToExcel: ExportDBGridToExcel(AFileName, AGrid);
  end;
end;
{$ENDIF}

{$IFDEF StringGrid}
procedure ExportStringGridToHTML(const AFileName: string; AGrid: TStringGrid);
begin
  raise Exception.CreateFmt('%s Save To %s', [AGrid.ClassName, AFileName]);
end;

procedure ExportStringGridToXML(const AFileName: string; AGrid: TStringGrid);
begin
  raise Exception.CreateFmt('%s Save To %s', [AGrid.ClassName, AFileName]);
end;

procedure ExportStringGridToExcel(const AFileName: string; AGrid: TStringGrid);
begin
  raise Exception.CreateFmt('%s Save To %s', [AGrid.ClassName, AFileName]);
end;

procedure ExportStringGridToText(const AFileName: string; AGrid: TStringGrid; const ASeparator: string = '');
var
  i, j: Integer;
  ValueStr: string;
begin
  with AGrid do
  for i := 0 to RowCount - 1 do
  begin
    for j := 0 to ColCount - 1 do
      ValueStr:= ValueStr + Cells[j, i] + #9' ';
    ValueStr:= ValueStr + #13#10;
  end;
  raise Exception.CreateFmt('%s Save To %s', [ValueStr, AFileName]);
end;

procedure ExportAStringGird(AGrid: TStringGrid; AFileName: string; FileType: integer);
begin
  case FileType of
    ExportToExcel: ExportStringGridToExcel(AFileName, AGrid);
    ExportToHtml:  ExportStringGridToHTML(AFileName,AGrid);
    ExportToText:  ExportStringGridToText(AFileName, AGrid);
    ExportToXml:   ExportStringGridToXML(AFileName,AGrid);
  end;
end;
{$ENDIF}

{$IFDEF ListView}
procedure ExportListViewToHTML(const AFileName: string; AGrid: TListView);
begin
  raise Exception.CreateFmt('%s Save To %s', [AGrid.ClassName, AFileName]);
end;

procedure ExportListViewToXML(const AFileName: string; AGrid: TListView);
begin
  raise Exception.CreateFmt('%s Save To %s', [AGrid.ClassName, AFileName]);
end;

procedure ExportListViewToExcel(const AFileName: string; AGrid: TListView);
begin
  raise Exception.CreateFmt('%s Save To %s', [AGrid.ClassName, AFileName]);
end;

procedure ExportListViewToText(AFileName: string; AGrid: TListView; const ASeparator: string = '');
var
  i, j: Integer;
  ValueStr: string;
begin
  with AGrid do
  begin
    for i := 0 to AGrid.Columns.Count - 1 do
      ValueStr:= ValueStr + AGrid.Columns.Items[i].Caption + #9' ';
    ValueStr:= ValueStr + #13#10;
    for i := 0 to Items.Count - 1 do
    begin
      with Items.Item[i] do
      begin
        ValueStr:= ValueStr + Caption;
        for j := 0 to SubItems.Count - 1 do
          ValueStr:= ValueStr + SubItems.Strings[j] + #9' ';
      end;
      ValueStr:= ValueStr + #13#10;
    end;
  end;
  raise Exception.CreateFmt('%s Save To %s', [ValueStr, AFileName]);
end;

procedure ExportAListView(AGrid: TListView; AFileName: string; FileType: integer);
begin
  case FileType of
    ExportToExcel: ExportListViewToExcel(AFileName, AGrid);
    ExportToHtml:  ExportListViewToHTML(AFileName,AGrid);
    ExportToText:  ExportListViewToText(AFileName, AGrid);
    ExportToXml:   ExportListViewToXML(AFileName,AGrid);
  end;
end;
{$ENDIF}

procedure ExportAGrid(AGrid: TObject);
const
  FilterStr = 'Microsoft Office Excel Workbook(*.xls)|*.xls|XML Data(*.xml)|*.xml|Web Page(*.htm;*.html)|*.htm;*.html|Text(Tab Delimited)(*.txt)|*.txt';
  SportFileCount = 4;
  SportFileExt:  array[0..SportFileCount] of String =('.txt', '.xml', '.xls', '.htm', '.html');

  function CaseString (const ValueStr: string; const Strings: array of string): Integer;
  var
    i: Integer;
  begin
    Result:= -1;
    for i:= Low(SportFileExt) to High (SportFileExt) do
      if ValueStr = Strings[i] then
      begin
        Result:= i;
        Exit;
      end;
  end;

var
  FileTypeIndex: Integer;
  SaveFileName: String;
begin
  SaveFileName:=GetSaveFileName(FilterStr);
  if SaveFileName = '' then exit;
  FileTypeIndex:= CaseString(LowerCase(ExtractFileExt(SaveFileName)), SportFileExt);
  if (FileTypeIndex < 0) or (FileTypeIndex > SportFileCount) then
    raise Exception.Create('Can''t support File Type!');

  {$IFDEF cxGrid}
  //编辑状态下的cxGrid
  if AGrid.ClassNameIs('TcxCustomInnerTextEdit') or AGrid.ClassParent.ClassNameIs('TcxCustomInnerTextEdit') then
    ExportAcxGrid((AGrid as TWinControl).Parent.Parent.Parent as TcxGrid, SaveFileName, FileTypeIndex);

  //普通状态下的cxGrid
  if AGrid.ClassNameIs('TcxGridSite') then
    ExportAcxGrid((AGrid as TcxGridSite).Container as TcxGrid, SaveFileName, FileTypeIndex);
  {$ENDIF}

  {$IFDEF StringGrid}
  if AGrid.ClassName = 'TStringGrid' then
    ExportAStringGird(AGrid as TStringGrid, SaveFileName, FileTypeIndex);
  {$ENDIF}

  {$IFDEF DBGrid}
  if AGrid.ClassNameIs('TDBGrid') then
    ExportADBGrid(AGrid as TDBGrid, SaveFileName, FileTypeIndex);
  {$ENDIF}
  
  {$IFDEF ListView}
  if AGrid.ClassName = 'TListView' then
    ExportAListView(AGrid as TListView, SaveFileName, FileTypeIndex);
  {$ENDIF}
  if Application.MessageBox('文件保存成功，是否打开？', '提示', MB_ICONINFORMATION + MB_YESNO) = IDYES then
    ShellExecute(GetDesktopWindow, 'open', PChar(SaveFileName), nil, PChar(ExtractFileDir(SaveFileName)), SW_SHOWMAXIMIZED);
end;

{ TExportAction }

constructor TExportAction.Create(AOwner: TComponent);
begin
  inherited;
  EnableClass:='';
  {$IFDEF cxGrid}
  EnableClass    := EnableClass + 'TcxGridSite,TcxCustomInnerTextEdit,';
  {$ENDIF}
  {$IFDEF StringGrid}
  EnableClass    := EnableClass + 'TStringGrid,';
  {$ENDIF}
  {$IFDEF DBGrid}
  EnableClass    := EnableClass + 'TDBGrid,';
  {$ENDIF}
  {$IFDEF ListView}
  EnableClass    := EnableClass + 'TListView,';
  {$ENDIF}

  Category:= 'Export';
  Caption:= 'Exp&ort';
  Hint:= 'Export|Export a grid to File';
end;

procedure TExportAction.ExecuteTarget(Target: TObject);
begin
  inherited;
  ExportAGrid(Target);
end;

function TExportAction.GetControl(Target: TObject): TWinControl;
begin
  Result := Target as TWinControl;
end;

function TExportAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result :=((GridControl <> nil) and (Target = GridControl)) or
           ((GridControl = nil)  and (Target <> nil) and ((Pos(Target.ClassName, EnableClass) <> 0) or
                                      (Pos(Target.ClassParent.ClassName, EnableClass) <> 0)));
end;

procedure TExportAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = GridControl) then GridControl := nil;
end;

procedure TExportAction.SetControl(Value: TWinControl);
begin
  if Value <> FControl then
  begin
    FControl := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

procedure TExportAction.UpdateTarget(Target: TObject);
begin
  Enabled:=GetControl(Target).Focused and
           ((Pos(Target.ClassName, EnableClass) <> 0) or (Pos(Target.ClassParent.ClassName, EnableClass) <> 0));
end;

{$IFDEF cxGrid}
{ TShowCxGroupByBox }

constructor TShowcxGridGroupByBox.Create(AOwner: TComponent);
begin
  inherited;
  Category:= 'GroupByBox';
  Caption:= '&GroupByBox';
  Hint:= 'GroupByBox|Show GroupByBox of cxGrid';
end;

procedure TShowcxGridGroupByBox.ExecuteTarget(Target: TObject);
var
  AGridView: TcxCustomGridView;
begin
  inherited;
  //编辑状态下的cxGrid
  AGridView:=nil;
  with Target as TWinControl do
  if (ClassNameIs('TcxCustomInnerTextEdit') or ClassParent.ClassNameIs('TcxCustomInnerTextEdit')) and
      ((Parent <> nil) and (Parent.Parent <> nil) and Parent.Parent.ClassNameIs('TcxGridSite')) then
    AGridView:=(((Target as TWinControl).Parent.Parent) as TcxGridSite).GridView;

  //普通状态下的cxGrid
  if Target.ClassNameIs('TcxGridSite') then
    AGridView:=(Target as TcxGridSite).GridView;

  if AGridView = nil then exit;

  if AGridView.ClassNameIs('TcxGridTableView') or AGridView.ClassNameIs('TcxGridDBTableView') or
     AGridView.ClassNameIs('TcxGridBandedTableView') or AGridView.ClassNameIs('TcxGridDBBandedTableView') then
     with (AGridView as TcxGridTableView).OptionsView do
      GroupByBox:=not GroupByBox;
end;

function TShowcxGridGroupByBox.GetControl(Target: TObject): TWinControl;
begin
  Result := Target as TWinControl;
end;

function TShowcxGridGroupByBox.HandlesTarget(Target: TObject): Boolean;
begin
  Result :=((cxGridControl <> nil) and (Target = cxGridControl)) or
           ((cxGridControl = nil)  and (Target.ClassNameIs('TcxGridSite') or
                                        Target.ClassNameIs('TcxCustomInnerTextEdit') or
                                        Target.ClassParent.ClassNameIs('TcxCustomInnerTextEdit')));
  
end;

procedure TShowcxGridGroupByBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = cxGridControl) then cxGridControl := nil;
end;

procedure TShowcxGridGroupByBox.SetControl(Value: TWinControl);
begin
  if Value <> FControl then
  begin
    FControl := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

procedure TShowcxGridGroupByBox.UpdateTarget(Target: TObject);
var
  AGridView: TcxCustomGridView;
begin
  AGridView:=nil;
  //编辑状态下的cxGrid
  with Target as TWinControl do
  if (ClassNameIs('TcxCustomInnerTextEdit') or ClassParent.ClassNameIs('TcxCustomInnerTextEdit')) and
      ((Parent <> nil) and (Parent.Parent <> nil) and Parent.Parent.ClassNameIs('TcxGridSite')) then
    AGridView:=((Parent.Parent) as TcxGridSite).GridView;

  //普通状态下的cxGrid
  if Target.ClassNameIs('TcxGridSite') then
    AGridView:=(Target as TcxGridSite).GridView;

  if AGridView = nil then exit;

  if AGridView.ClassNameIs('TcxGridTableView') or AGridView.ClassNameIs('TcxGridDBTableView') or
     AGridView.ClassNameIs('TcxGridBandedTableView') or AGridView.ClassNameIs('TcxGridDBBandedTableView') then
     with (AGridView as TcxGridTableView).OptionsView do
  begin
    Checked:=GroupByBox;
    Enabled:=GetControl(Target).Focused;
  end
end;
{$ENDIF}

end.
