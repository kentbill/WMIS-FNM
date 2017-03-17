{*******************************************************}
{                                                       }
{       软件名称 W.MIS CLIENT MODEL                     }
{       版权所有 (C) 2003, 2004 Esquel.IT               }
{       单元名称 UGridDecorator.pas                     }
{       创建日期 2004-8-3 11:01:45                      }
{       创建人员 wuwj                                   }
{                                                       }
{*******************************************************}

unit uGridDecorator;
{* TDxDBGrid、TDBGrid标题列英汉转换类单元 }

interface

{$I Terminal.inc}

uses
  uShowMessage, SysUtils, Windows, Messages, Classes, Graphics, Controls,StrUtils,
  Forms, Dialogs, DBClient, DBGrids, Variants, DB, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxGridPopupMenu, cxGridDBCardView,
  cxGridBandedTableView, cxGridDBBandedTableView, uGlobal, uAppOption, Math, cxLookAndFeelPainters;

type
  TGridDecorator = class
  private
    FFieldsDataSet: TClientDataSet;
    function GetFormatStr(Kind: TcxSummaryKind): string;
  public
    constructor Create;

    destructor Destroy; override;

    procedure CustomDrawIndicatorCell(Sender: TcxGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxCustomGridIndicatorItemViewInfo;  var ADone: Boolean);

    procedure SetGridColumnCaptionToChinese(grid:TDBGrid);
    {* }
    procedure LoadFieldInfoFromFile(fileName:string); 
    {* }
    procedure SetDataSetColumnToChinese(ds:TDataSet);
    {*设置cxGrid中列是否要编辑，隐藏列出的字段}
    procedure SetcxTableView(cxTableView:TcxGridDBTableView; HideFieldNames: array of String; EditFieldNames: array of String; IsReadOnly:Boolean = True);
    {* }
    procedure BindcxTableView(ATableView: TcxGridTableView; ADataSet: TDataSet; FieldNames: array of String);
    {* }
    procedure BindCxCardViewWithDataSource(cxView: TcxGridDBCardView; ds:TDataSource; ClearMode: Boolean = false);
    {* }
    procedure BindCxViewWithDataSource(cxView: TcxGridDBBandedTableView; ds:TDataSource; ClearMode: Boolean = false); overload;
    {* }
    procedure BindCxViewWithDataSource(cxView: TcxGridDBTableView; ds:TDataSource; ClearMode: Boolean = false); overload;
    {* }
    procedure AddSummary(cxView: TcxGridDBTableView);
    {* }
    procedure HideFields(cxView: TcxGridDBBandedTableView; FieldNames: array of String); overload;
    {* }
    procedure HideFields(cxView: TcxGridDBTableView; FieldNames: array of String); overload;
    {* }
    procedure AddFooter(cxView: TcxGridDBBandedTableView; FieldNames: array of String; SumKinds: array of TcxSummaryKind); overload;
    {* }
    procedure AddFooter(cxView: TcxGridDBTableView; FieldNames: array of String; SumKinds: array of TcxSummaryKind); overload;
    {* }
    procedure AddGroupFooter(cxView: TcxGridDBBandedTableView; iLevel: Integer; FieldNames: array of String; SumKinds: array of TcxSummaryKind; SummaryPosition: TcxSummaryPosition = spGroup); overload;
    {* }
    procedure AddGroupFooter(cxView: TcxGridDBTableView; iLevel: Integer; FieldNames: array of String; SumKinds: array of TcxSummaryKind; SummaryPosition: TcxSummaryPosition = spGroup); overload;
    {* }
    procedure CustomerDraw(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; bFactBeginDate: Boolean=True);
    {* }
    property FieldsDataSet: TClientDataSet read FFieldsDataSet;
    {* }
  end;

function GridDecorator: TGridDecorator;
function cxGridPM: TcxGridPopupMenu;

implementation

var
  FGridDecorator: TGridDecorator;
  FcxGridPMList: TList;

constructor TGridDecorator.Create;
begin
  inherited Create;

  FFieldsDataSet:=TClientDataSet.Create(nil);
end;

destructor TGridDecorator.Destroy;
begin
  FFieldsDataSet.Destroy;

  inherited Destroy;
end;

procedure TGridDecorator.CustomDrawIndicatorCell(Sender: TcxGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxCustomGridIndicatorItemViewInfo;
  var ADone: Boolean);
var
  TempRec: TRect;
  X, Y: Integer;
begin
  ADone := False;
  if not (AViewInfo is TcxGridIndicatorRowItemViewInfo) then
    Exit
  else
  with AViewInfo as TcxGridIndicatorRowItemViewInfo do
  begin
    ADone := True;

    TempRec:=Bounds;

    //画出列头
    LookAndFeelPainter.DrawHeader(ACanvas, Bounds, Bounds, [],
      LookAndFeelPainter.HeaderBorders([nTop, nBottom]), cxbsNormal,
      taLeftJustify, cxClasses.vaTop, False, False, '', nil, clNone, Params.Color, nil);

    //画出状态指示图标
    X := TempRec.Left + Ceil((TempRec.Right - TempRec.Left) / 2);

    Y := (TempRec.Top + TempRec.Bottom - cxIndicatorImages.Height) div 2;
    cxIndicatorImages.Draw(ACanvas.Canvas, X, Y, Ord(IndicatorKind) - 1);
    //画出行记录状态
    TempRec.Top := TempRec.Top + 3;
    TempRec.Left := TempRec.Left;
    TempRec.Right := TempRec.Right-3;

    ACanvas.Brush.Style := bsClear;
    ACanvas.Font.Color := clBlack;
//    ACanvas.DrawText(IntToStr(GridRecord.Index + 1), TempRec, 0);
    ACanvas.DrawText(IntToStr(GridRecord.Index + 1), TempRec, cxAlignRight);

  end;
end;

function TGridDecorator.GetFormatStr(Kind: TcxSummaryKind): string;
begin
  case kind of
    skAverage:   Result := 'AVG = 0.0';
    skCount:     Result := 'Count =0';
    skMax:       Result := 'MAX =0.00';
    skMin:       Result := 'MIN =0.00';
    skSum:       Result := 'SUM =0.00';
    skNone:      Result := '';
    else         Result := '';
  end;
end;

procedure TGridDecorator.LoadFieldInfoFromFile(fileName:string);
var
  LocalPath:string;
begin
  try
    if not FileExists(fileName) then
    begin
 //     Raise Exception.Create('系统找不到配置文件：'+fileName+'，请联系程序员！');
//      Exit;
      fileName:=StringReplace(Application.ExeName,'.exe','.xml',[rfIgnoreCase]);
    end;
    self.FieldsDataSet.LoadFromFile(fileName);
  except
    raise;
  end;
end;

procedure TGridDecorator.SetGridColumnCaptionToChinese(grid:TDBGrid);
var
  i:integer;
begin
  with FieldsDataSet do
  begin
    if IsEmpty then
      raise Exception.CreateFmt('还没调用类 %s 的LoadFieldInfoFromFile方法从配置文件读入字段的信息！', [ClassName]);

    for i:=0 to (grid.Columns.Count-1) do
    if Locate('Field_Name', VarArrayOf([grid.Columns[i].FieldName]), [])=True then
       grid.Columns[i].Title.Caption:=FieldByName('Field_Description').AsString;
  end;
end;

procedure TGridDecorator.SetDataSetColumnToChinese(ds:TDataSet);
var
  i:integer;
begin
  with FieldsDataSet do
  begin
    if IsEmpty then
      raise Exception.CreateFmt('还没调用类 %s 的LoadFieldInfoFromFile方法从配置文件读入字段的信息！', [ClassName]);
      
    ds.DisableControls;
    try
      for i:=0 to ds.FieldCount-1 do
      if Locate('Field_Name', VarArrayOf([ds.Fields[i].FieldName]), [loPartialKey])=True then
       begin
         ds.Fields[i].DisplayLabel:=FieldByName('Field_Description').AsString;
         ds.Fields[i].DisplayWidth:=Length(ds.Fields[i].DisplayLabel)+2;
       end;
    finally
     ds.EnableControls;
    end;
  end;
end;

procedure BindGridPopupMenu(AcxGrid: TcxGrid);
var
  i: Integer;
begin
  for i := 0 to FcxGridPMList.Count - 1 do
    if TcxGridPopupMenu(FcxGridPMList.Items[i]).Grid = AcxGrid then exit;

  cxGridPM.Grid:=AcxGrid;
end;

function GetcxValueType(FieldType: TFieldType): TcxValueTypeClass;
begin
  case FieldType of
    ftBCD, ftCurrency:           result:=TcxFloatValueType;
    ftBoolean:                   result:=TcxBooleanValueType;
    ftDate, ftTime, ftDateTime:  result:=TcxDateTimeValueType;
    ftFloat:                     result:=TcxFloatValueType;
    ftFMTBcd:	                 result:=TcxFMTBcdValueType;
    ftInteger:	                 result:=TcxIntegerValueType;
    ftLargeint:                  result:=TcxLargeIntValueType;
    ftString:	                 result:=TcxStringValueType;
    ftWideString:	         result:=TcxWideStringValueType;
    ftWord:	                 result:=TcxWordValueType;
  else
    result:= TcxVariantValueType;
  end;
end;

procedure TGridDecorator.BindcxTableView(ATableView: TcxGridTableView; ADataSet: TDataSet; FieldNames: array of String);
var
  i, j, RecordIndex: Integer;
  DataField: TField;
begin
  if Low(FieldNames) = High(FieldNames) then exit;//没有传入字段

  //该语句不能放到后面免得造成表格刷新
{$IFDEF TERMINAL}
    SetDataSetColumnToChinese(ADataSet);
{$ELSE}
  if AppOption.IfQueryShowCHN then
    SetDataSetColumnToChinese(ADataSet);
{$ENDIF}

    //添加列
  with ATableView do
  try
    BeginUpdate;
    while DataController.RecordCount <> 0 do
      DataController.DeleteRecord(0);
    ClearItems;

    for j:= Low(FieldNames) to High(FieldNames) do
    begin
      DataField:=ADataSet.FieldByName(FieldNames[j]);
      with CreateColumn do
      begin
        Name:=DataField.FieldName;
        Caption:=DataField.DisplayLabel;
        DataBinding.ValueTypeClass:=GetcxValueType(DataField.DataType);
      end;
    end;
    //添加记录
    ADataSet.First;
    for i := 0 to ADataSet.RecordCount - 1 do
    begin
      RecordIndex:=DataController.AppendRecord;
      for j:= Low(FieldNames) to High(FieldNames) do
        DataController.Values[RecordIndex, j]:=ADataSet[FieldNames[j]];
      ADataSet.Next;
    end;
  finally
    EndUpdate;
    ApplyBestFit;
  end;
  
  with ATableView do
  try
    BeginUpdate;
    ApplyBestFit;
    //邦定右键菜单。
    BindGridPopupMenu(TcxGrid(GetParentComponent));
  finally
    EndUpdate;
  end;
end;

procedure TGridDecorator.BindCxCardViewWithDataSource(cxView: TcxGridDBCardView; ds: TDataSource; ClearMode: Boolean = false);
begin
  if ds.DataSet=nil then
    raise Exception.Create('请先给DataSource指定DataSet!');

  if ds.DataSet.Active=False then
    raise Exception.Create('数据源还没有打开，没有数据');

  with cxView do
  try
    BeginUpdate;
    //清除旧列
    if ClearMode then
    begin
      ClearItems;
      DataController.Summary.FooterSummaryItems.Clear;
    end;
    //该语句不能放到后面免得造成表格刷新
{$IFDEF TERMINAL}
    SetDataSetColumnToChinese(ds.DataSet);
{$ELSE}
  if AppOption.IfQueryShowCHN then
    SetDataSetColumnToChinese(ds.DataSet);
{$ENDIF}
    //设置数据源
    if DataController.DataSource <> ds then
      DataController.DataSource:=ds;
    //构造列;加入统计
    if ItemCount = 0 then
      DataController.CreateAllItems;
    ds.DataSet.First;
  finally
    EndUpdate;
  end;
  
  with cxView do
  try
    BeginUpdate;
    ApplyBestFit;
    //邦定右键菜单。
    BindGridPopupMenu(TcxGrid(GetParentComponent));
  finally
    EndUpdate;
  end;
end;

procedure TGridDecorator.BindCxViewWithDataSource(cxView: TcxGridDBBandedTableView; ds: TDataSource; ClearMode: Boolean);
begin
  if ds.DataSet=nil then
    raise Exception.Create('请先给DataSource指定DataSet!');

  if ds.DataSet.Active=False then
    raise Exception.Create('数据源还没有打开，没有数据');

  with cxView do
  try
    BeginUpdate;
    //清除旧列
    if ClearMode then
    begin
      ClearItems;
      DataController.Summary.FooterSummaryItems.Clear;
    end;
    //该语句不能放到后面免得造成表格刷新
{$IFDEF TERMINAL}
    SetDataSetColumnToChinese(ds.DataSet);
{$ELSE}
  if AppOption.IfQueryShowCHN then
    SetDataSetColumnToChinese(ds.DataSet);
{$ENDIF}
    //设置数据源
    if DataController.DataSource <> ds then
      DataController.DataSource:=ds;
    //构造列;加入统计
    if ItemCount = 0 then
      DataController.CreateAllItems;
    ds.DataSet.First;
  finally
    EndUpdate;
  end;
  
  with cxView do
  try
    BeginUpdate;
    ApplyBestFit;
    //邦定右键菜单。
    BindGridPopupMenu(TcxGrid(GetParentComponent));
  finally
    EndUpdate;
  end;
end;

procedure TGridDecorator.BindCxViewWithDataSource(cxView: TcxGridDBTableView; ds: TDataSource; ClearMode: Boolean = false);
var
  bGrid: Boolean;
begin
  if ds.DataSet=nil then
    raise Exception.Create('请先给DataSource指定DataSet!');

  if ds.DataSet.Active=False then
    raise Exception.Create('数据源还没有打开，没有数据');

  with cxView do
  try
    BeginUpdate;
    //清除旧列
    if ClearMode then
    begin
      ClearItems;
      DataController.Summary.FooterSummaryItems.Clear;
    end;

    bGrid := False;
    //该语句不能放到后面免得造成表格刷新
{$IFDEF TERMINAL}
    SetDataSetColumnToChinese(ds.DataSet);
    bGrid := True;
{$ELSE}
    if AppOption.IfQueryShowCHN then
      SetDataSetColumnToChinese(ds.DataSet);
{$ENDIF}

  //  DataController.DataModeController.GridMode := bGrid;
    //设置数据源
    if DataController.DataSource <> ds then
      DataController.DataSource:=ds;
    //设置显示选项
    OptionsView.Footer := True;
    OptionsView.Indicator := True;
    //构造列;加入统计
    if ColumnCount = 0 then
    begin
      DataController.CreateAllItems;
      AddSummary(cxView);
    end;
    ds.DataSet.First;
  finally
    EndUpdate;
  end;
  with cxView do
  try
    BeginUpdate;
    if DataController.DataSet.RecordCount < 1000 then
      ApplyBestFit;
    //邦定右键菜单。
    BindGridPopupMenu(TcxGrid(GetParentComponent));
    cxView.OptionsView.Indicator := True;
    cxView.OptionsView.IndicatorWidth:=cxView.ViewInfo.Canvas.TextWidth(IntToStr(DataController.DataSet.RecordCount + 1)) + 15;

    if not Assigned(cxView.OnCustomDrawIndicatorCell) then
      cxView.OnCustomDrawIndicatorCell:=CustomDrawIndicatorCell;
  finally
    EndUpdate;
  end;
end;

procedure TGridDecorator.AddSummary(cxView: TcxGridDBTableView);
const
  SUMFILDLIST = 'quantity;qty';
var
  i, Count: Integer;
begin
  Count:=0;
  with cxView  do
  for I := 0 to ColumnCount - 1 do
  with Columns[i].DataBinding.Field do
    if (Pos(LowerCase(FieldName), SUMFILDLIST) <> 0) and
        ((DataType = ftSmallint) or (DataType = ftBCD) or (DataType = ftInteger) or (DataType = ftWord) or
        (DataType = ftFloat) or (DataType = ftCurrency)) then
    begin
      //Sum统计
      with DataController.Summary.FooterSummaryItems.Add as TcxGridDBTableSummaryItem do
      begin
        Column:=Columns[i];
        Kind:=skSum;
      end;
    end;
 {
    else if Count = 0 then
    begin
      //加入Count统计
      with DataController.Summary.FooterSummaryItems.Add as TcxGridDBTableSummaryItem do
      begin
        Column:=Columns[i];
        Kind:=skCount;
        inc(Count);
      end
    end;
 }
end;

procedure TGridDecorator.AddFooter(cxView: TcxGridDBBandedTableView;
  FieldNames: array of String; SumKinds: array of TcxSummaryKind);
var i: Integer;
begin
  with cxView do
  try
    BeginUpdate;
    if ViewData.RowCount = 0 then Exit;
    OptionsView.Footer := True;
    OptionsView.Indicator := True;
    if ColumnCount > 0 then
    begin
      DataController.Summary.FooterSummaryItems.Clear;
      for i:= 0 to High(FieldNames) do
      begin
        if GetColumnByFieldName(FieldNames[i]) <> nil then
          with DataController.Summary.FooterSummaryItems.Add as TcxGridDBBandedTableSummaryItem do
          begin
            Column:=Columns[GetColumnByFieldName(FieldNames[i]).Index];
      //      Format := GetFormatStr(SumKinds[i]);
            Kind:=SumKinds[i];
          end;
      end;
    end;
  finally
    EndUpdate;
    ApplyBestFit;
  end;
end;

procedure TGridDecorator.AddFooter(cxView: TcxGridDBTableView;
  FieldNames: array of String; SumKinds: array of TcxSummaryKind);
var i: Integer;
begin
  with cxView do
  try
    BeginUpdate;
    if ViewData.RowCount = 0 then Exit;
    OptionsView.Footer := True;
    OptionsView.Indicator := True;
    if ColumnCount > 0 then
    begin
      DataController.Summary.FooterSummaryItems.Clear;
      for i:= 0 to High(FieldNames) do
      begin
        if GetColumnByFieldName(FieldNames[i]) <> nil then
          with DataController.Summary.FooterSummaryItems.Add as TcxGridDBTableSummaryItem do
          begin
            Column:=Columns[GetColumnByFieldName(FieldNames[i]).Index];
      //      Format := GetFormatStr(SumKinds[i]);
            Kind:=SumKinds[i];
          end;
      end;
    end;
  finally
    EndUpdate;
    ApplyBestFit;
  end;
end;

procedure TGridDecorator.AddGroupFooter(cxView: TcxGridDBBandedTableView; iLevel: Integer;
  FieldNames: array of String; SumKinds: array of TcxSummaryKind; SummaryPosition: TcxSummaryPosition);
var i: Integer;
begin
  with cxView do
  try
    BeginUpdate;
    if ViewData.RowCount = 0 then Exit;
    OptionsView.GroupFooters := gfInvisible;
    OptionsView.Indicator := True;
    if ColumnCount > 0 then
    begin
      DataController.Summary.GroupSummaryItems[iLevel].Clear;
      for i:= 0 to High(FieldNames) do
      begin
        if GetColumnByFieldName(FieldNames[i]) <> nil then
          with DataController.Summary.GroupSummaryItems[iLevel].Add as TcxGridDBBandedTableSummaryItem do
          begin
            Column:=Columns[GetColumnByFieldName(FieldNames[i]).Index];
      //      Format := GetFormatStr(SumKinds[i]);
            Kind:=SumKinds[i];
            Position := SummaryPosition;
          end;
      end;
    end;
  finally
    EndUpdate;
    ApplyBestFit;
  end;
end;

procedure TGridDecorator.AddGroupFooter(cxView: TcxGridDBTableView; iLevel: Integer;
  FieldNames: array of String; SumKinds: array of TcxSummaryKind; SummaryPosition: TcxSummaryPosition);
var i: Integer;
begin
  with cxView do
  try
    BeginUpdate;
    if ViewData.RowCount = 0 then Exit;
    OptionsView.GroupFooters := gfInvisible;
    OptionsView.Indicator := True;
    if ColumnCount > 0 then
    begin
      DataController.Summary.GroupSummaryItems[iLevel].Clear;
      for i:= 0 to High(FieldNames) do
      begin
        if GetColumnByFieldName(FieldNames[i]) <> nil then
          with DataController.Summary.GroupSummaryItems[iLevel].Add as TcxGridDBTableSummaryItem do
          begin
            Column:=Columns[GetColumnByFieldName(FieldNames[i]).Index];
      //      Format := GetFormatStr(SumKinds[i]);
            Kind:=SumKinds[i];
            Position := SummaryPosition;
          end;
      end;
    end;
  finally
    EndUpdate;
    ApplyBestFit;
  end;
end;

procedure TGridDecorator.HideFields(cxView: TcxGridDBBandedTableView; FieldNames: array of String);
var i: Integer;
begin
  with cxView do
  try
    BeginUpdate;
    OptionsView.Indicator := True;
    if ColumnCount > 0 then
      for i := 0 to High(FieldNames) do
        if GetColumnByFieldName(FieldNames[i]) <> nil then
          Columns[GetColumnByFieldName(FieldNames[i]).Index].Visible := False;
  finally
    EndUpdate;
    ApplyBestFit(nil);
  end;
end;

procedure TGridDecorator.HideFields(cxView: TcxGridDBTableView; FieldNames: array of String);
var i: Integer;
begin
  with cxView do
  try
    BeginUpdate;
    OptionsView.Indicator := True;
    if ColumnCount > 0 then
      for i := 0 to High(FieldNames) do
        if GetColumnByFieldName(FieldNames[i]) <> nil then
          Columns[GetColumnByFieldName(FieldNames[i]).Index].Visible := False;
  finally
    EndUpdate;
    ApplyBestFit(nil);
  end;
end;

procedure TGridDecorator.CustomerDraw(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; bFactBeginDate: Boolean);
var
  col,iColor: Integer;
  sUrgent_Type, sWV_IsFinished: string;
  bIs_Cut_Cloth: Boolean;
  iIs_Hold,iIs_HoldByAffirm: Integer;
begin
  // 根据某一列的值设置某一行的背景字体的颜色
  col := TcxGridDBTableView(Sender).GetColumnByFieldName('FN_Card').Index;
  if LeftStr(AViewInfo.GridRecord.Values[col],1) <> 'N' then
  begin
  col := TcxGridDBTableView(Sender).GetColumnByFieldName('Urgent_Type').Index;
  sUrgent_Type := AViewInfo.GridRecord.Values[col];
  col := TcxGridDBTableView(Sender).GetColumnByFieldName('WV_IsFinished').Index;
  sWV_IsFinished := AViewInfo.GridRecord.Values[col];
  col := TcxGridDBTableView(Sender).GetColumnByFieldName('Is_Cut_Cloth').Index;
  bIs_Cut_Cloth := AViewInfo.GridRecord.Values[col];
  col := TcxGridDBTableView(Sender).GetColumnByFieldName('Is_Hold').Index;
  iIs_Hold := AViewInfo.GridRecord.Values[col];
  col := TcxGridDBTableView(Sender).GetColumnByFieldName('Is_HoldByAffirm').Index;
  iIs_HoldByAffirm := AViewInfo.GridRecord.Values[col];
  iColor := TGlobal.GetColorByID(sWV_IsFinished, sUrgent_Type, bIs_Cut_Cloth, iIs_Hold,iIs_HoldByAffirm);

  if $000000 <> iColor then
    ACanvas.Font.Color := iColor;
  end;
  if bFactBeginDate then
  begin
    col := TcxGridDBTableView(Sender).GetColumnByFieldName('Fact_Begin_Time').Index;
    if not VarIsNull(AViewInfo.GridRecord.Values[col]) then
    begin
      //ACanvas.Brush.Color:= clInfoBk;
     //Luoty:改变背影色
      ACanvas.Font.Size := 10;
      ACanvas.Font.Style := ACanvas.Font.Style + [fsBold, fsItalic];
   end;
  end;
end;

function GridDecorator:TGridDecorator;
begin
  if FGridDecorator=nil then
     FGridDecorator:=TGridDecorator.Create;
  Result:=FGridDecorator;
end;

function cxGridPM: TcxGridPopupMenu;
var
  i: Integer;
  lcxGridPM: TcxGridPopupMenu;
begin
  lcxGridPM:=nil;
  for i := 0 to FcxGridPMList.Count - 1 do
  begin
    if TcxGridPopupMenu(FcxGridPMList.Items[i]).Grid = nil then
    begin
      lcxGridPM:= FcxGridPMList.Items[i];
      Break;
    end;
  end;

  if lcxGridPM = nil then
  begin
    lcxGridPM:=TcxGridPopupMenu.Create(nil);
    FcxGridPMList.Add(lcxGridPM);
  end;
  
  Result:=lcxGridPM;
end;

procedure DestroyFcxGridPMList;
var
  i: Integer;
  lcxGridPM: TcxGridPopupMenu;
begin
  for i := 0 to FcxGridPMList.Count - 1 do
  begin
    lcxGridPM:=FcxGridPMList.Items[0];
    FcxGridPMList.Delete(0);
    
    lcxGridPM.Free;
  end;
  FcxGridPMList.Free;
end;


procedure TGridDecorator.SetcxTableView(cxTableView: TcxGridDBTableView;
  HideFieldNames, EditFieldNames: array of String; IsReadOnly: Boolean);
var
  i: Integer;
begin
  with cxTableView do
  begin
    if ColumnCount = 0 then Exit;

    with DataController.DataSet do
    begin
      //数据集
      if not Active then Exit;

      //设置为只读
      for i:=0 to FieldCount - 1 do
        Fields[i].ReadOnly := IsReadOnly;

      //如果是只读，可设置可以编辑的字段
      if IsReadOnly then
      begin
        for i:= Low(EditFieldNames) to High(EditFieldNames) do
          FieldByName(EditFieldNames[i]).ReadOnly := False;
      end;
    end;

    //隐藏列
    for i:= Low(HideFieldNames) to High(HideFieldNames) do
      GetColumnByFieldName(HideFieldNames[i]).Visible := False;
  end;
end;

initialization
  FGridDecorator:=nil;
  FcxGridPMList:=TList.Create;

finalization
  FGridDecorator.Free;
  DestroyFcxGridPMList;

end.


