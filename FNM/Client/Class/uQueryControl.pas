unit uQueryControl;

interface

uses
  uFNMResource, uQueryDictionary, 
  Windows, SysUtils, StrUtils, Classes, Controls, StdCtrls, ExtCtrls, DB,
  DBClient, Variants, ActiveX, Graphics, Messages, Buttons,
  cxGrid, cxGridLevel, cxGridDBTableView, cxGridCustomView, cxGridCustomTableView,
  cxCustomData, cxGridDBCardView, cxGridTableView, cxGridDBBandedTableView,
  cxGridBandedTableView, cxGridDBDataDefinitions, cxGridPopupMenu, cxSplitter,
  cxFilter, cxGridCustomPopupMenu, cxGridDetailsSite, cxDBData;

type
  TMDLevel = record
    MasterLevel: TcxGridLevel;
    DetailLevel: TcxGridLevel;
  end;
  TOpenDetailEvent = procedure(QueryIden: Integer; vCondition: Variant; var QueryData: OleVariant) of object;
  TReQueryEvent = procedure(QueryIden: Integer; PreDeclareVarString, ConditionString: String; var QueryData: OleVariant) of object;

  TMDGridViewPanel = class(TCustomPanel)
  private
    { Private declarations }
    FConditionEdit: TEdit;
    FMastercxGrid: TcxGrid;
    FcxSplitter: TcxSplitter;
    FDetailcxGrid: TcxGrid;
    FMastercxGridPopupMenu: TcxGridPopupMenu;
    FDetailcxGridPopupMenu: TcxGridPopupMenu;
    FLeftButton: TSpeedButton;
    FRightButton: TSpeedButton;

    FConditionTextList: TStringList;
    FMDRelation: TList;

    FTempDataSet: TDataSet;
    FCloseGraphic: TGraphic;
    FOldcxGridWndMethod: TWndMethod;

    FOnOpenDetailEvent: TOpenDetailEvent;
    FOnAfterOpenDataSet: TDataSetNotifyEvent;
    FOnReQueryEvent: TReQueryEvent;
    FOnGridViewKeyDown: TKeyEvent;
    FOnGridViewDbClick: TNotifyEvent;

    procedure CreateFieldColumn(QueryIden: Integer; ADataController: TcxGridDBDataController);
    function CreateRootGridLevel(AcxGrid: TcxGrid; LevelCaption: String): TcxGridLevel;
    function CreateGridView(AcxGrid: TcxGrid; ViewClass: String): TcxCustomGridView;
    procedure ActiveTabChanged(Sender: TcxCustomGrid; ALevel: TcxGridLevel);
    procedure ShowDetailLevel(AGirdSite: TcxGridSite);
    procedure DetailExpanding(ADataController: TcxCustomDataController; ARecordIndex: Integer; var AAllow: Boolean);
    procedure DataControllerDataChanged(Sender: TObject);
    procedure ViewDbClick(Sender: TObject);
    procedure ViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CreateDetailQuery(ALevel: TcxGridLevel; DetailQueryIdens: String);
    procedure GetDetailData(MasterLevel, DetailLevel: TcxGridLevel);
    procedure MergeSameDataSet(FirstDataSet, SendDataSet: TDataSet);
    procedure PaintCloseButton(AcxGrid: TcxGrid);
    procedure FreeGridView(AGridLevel: TcxGridLevel);
    procedure MastercxGridClick(Sender: TObject);
    procedure MastercxGridWindowProc(var Message: TMessage);
    procedure NavigationClick(Sender: TObject);
    procedure ReQueryData(Sender: TObject);
  public
    { public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure CreateMasterQuery(QueryIden: Integer; ConditionString: String; QueryData: OleVariant);
  published
    { published declarations }
    property OnOpenDetail: TOpenDetailEvent read FOnOpenDetailEvent write FOnOpenDetailEvent;
    property OnGridViewKeyDown: TKeyEvent read FOnGridViewKeyDown write FOnGridViewKeyDown;
    property OnGridViewDbClick: TNotifyEvent read FOnGridViewDbClick write FOnGridViewDbClick;
    property OnAfterOpenDataSet: TDataSetNotifyEvent read FOnAfterOpenDataSet write FOnAfterOpenDataSet;
    property ReQueryEvent: TReQueryEvent read FOnReQueryEvent write FOnReQueryEvent;
  end;

implementation

{ TGridViewController }

procedure TMDGridViewPanel.CreateFieldColumn(QueryIden: Integer; ADataController: TcxGridDBDataController);
var
  i: Integer;
  AFieldName, FieldNames: String;
  AItem: TcxCustomGridTableItem;
  ABand: TcxGridBand;
begin
  if not QyDictionary.cds_QueryProperty.Locate('Query_Iden', QueryIden, []) then exit;

  with ADataController, ADataController.DataSet do
  try
    GridView.BeginUpdate;
    //处理隐藏字段
    FieldNames:=LowerCase(QyDictionary.cds_QueryProperty.FieldByName('Hiden_Fields').AsString);
    if FieldNames <> '' then
    begin
      for i := 0 to FieldCount - 1 do
        Fields.Fields[i].Visible:=Pos(LowerCase(Fields.Fields[i].FieldName), FieldNames) = 0;
    end;

    //建立字段
    FieldNames:=LowerCase(QyDictionary.cds_QueryProperty.FieldByName('NonVisual_Fields').AsString);
    for i := 0 to FieldCount - 1 do
    begin
      //跳过不可视字段
      if Pos(LowerCase(Fields.Fields[i].FieldName), FieldNames) <> 0 then Continue;

      AItem := GridView.CreateItem;
      (AItem.DataBinding as TcxGridItemDBDataBinding).FieldName:=Fields[I].FieldName;
      AItem.Visible:=Fields[I].Visible;
    end;

    if not GridView.ClassNameIs('TcxGridDBCardView') then
    begin
      //建立预览字段
      FieldNames:=QyDictionary.cds_QueryProperty.FieldByName('Preview_Field').AsString;
      if FieldNames <> '' then
      with GridView as TcxGridTableView do
      begin
        Preview.Column:=TcxGridColumn(GetItemByFieldName(FieldNames));
        Preview.Visible:=Preview.Column <> nil;
      end;
      //建立分组字段
      FieldNames:=QyDictionary.cds_QueryProperty.FieldByName('Group_Fields').AsString;
      if FieldNames <> '' then
      while Length(FieldNames) > 0 do
      begin
        AFieldName:=LeftStr(FieldNames, Pos(',', FieldNames) - 1);
        TcxGridColumn(GetItemByFieldName(AFieldName)).GroupIndex:=Groups.GroupingItemCount;
        TcxGridColumn(GetItemByFieldName(AFieldName)).Visible:=false;
        System.Delete(FieldNames, 1, Pos(',', FieldNames));
      end;
      //加入统计--skCount
      FieldNames:=QyDictionary.cds_QueryProperty.FieldByName('SumCnt_Fields').AsString;
      if FieldNames <> '' then
      while Length(FieldNames) > 0 do
      begin
        AFieldName:=LeftStr(FieldNames, Pos(',', FieldNames) - 1);
        with Summary.FooterSummaryItems.Add as TcxDBDataSummaryItem do
        begin
          ItemLink:=GetItemByFieldName(AFieldName);
          Kind:=skCount;
        end;
        System.Delete(FieldNames, 1, Pos(',', FieldNames));
      end;
      //加入统计--skSum
      FieldNames:=QyDictionary.cds_QueryProperty.FieldByName('SumSum_Fields').AsString;
      if FieldNames <> '' then
      while Length(FieldNames) > 0 do
      begin
        AFieldName:=LeftStr(FieldNames, Pos(',', FieldNames) - 1);
        with Summary.FooterSummaryItems.Add as TcxDBDataSummaryItem do
        begin
          ItemLink:=GetItemByFieldName(AFieldName);
          Kind:=skSum;
        end;
        System.Delete(FieldNames, 1, Pos(',', FieldNames));
      end;
      //加入统计--skAverage
      FieldNames:=QyDictionary.cds_QueryProperty.FieldByName('SumAvg_Fields').AsString;
      if FieldNames <> '' then
      while Length(FieldNames) > 0 do
      begin
        AFieldName:=LeftStr(FieldNames, Pos(',', FieldNames) - 1);
        with Summary.FooterSummaryItems.Add as TcxDBDataSummaryItem do
        begin
          ItemLink:=GetItemByFieldName(AFieldName);
          Kind:=skAverage;
        end;
        System.Delete(FieldNames, 1, Pos(',', FieldNames));
      end;
      //加入统计--skMax
      FieldNames:=QyDictionary.cds_QueryProperty.FieldByName('SumMax_Fields').AsString;
      if FieldNames <> '' then
      while Length(FieldNames) > 0 do
      begin
        AFieldName:=LeftStr(FieldNames, Pos(',', FieldNames) - 1);
        with Summary.FooterSummaryItems.Add as TcxDBDataSummaryItem do
        begin
          ItemLink:=GetItemByFieldName(AFieldName);
          Kind:=skMax;
        end;
        System.Delete(FieldNames, 1, Pos(',', FieldNames));
      end;
      //加入统计--skMin
      FieldNames:=QyDictionary.cds_QueryProperty.FieldByName('SumMin_Fields').AsString;
      if FieldNames <> '' then
      while Length(FieldNames) > 0 do
      begin
        AFieldName:=LeftStr(FieldNames, Pos(',', FieldNames) - 1);
        with Summary.FooterSummaryItems.Add as TcxDBDataSummaryItem do
        begin
          ItemLink:=GetItemByFieldName(AFieldName);
          Kind:=skMin;
        end;
        System.Delete(FieldNames, 1, Pos(',', FieldNames));
      end;

      (GridView as TcxGridTableView).OptionsView.Footer:=ADataController.Summary.FooterSummaryItems.Count <> 0;
    end;

    if GridView.ClassNameIs('TcxGridDBBandedTableView') then
    begin
      //加入邦定分组
      FieldNames:=QyDictionary.cds_QueryProperty.FieldByName('Bands_Captions').AsString;
      with GridView as TcxGridDBBandedTableView do
        if FieldNames <> '' then
        begin
          OptionsView.BandHeaders:=QyDictionary.cds_QueryProperty.FieldByName('Band_Headers').AsBoolean;
          while Length(FieldNames) > 0 do
          begin
            ABand:=Bands.Add;
            ABand.Caption:=LeftStr(FieldNames, Pos(',', FieldNames) - 1);
            System.Delete(FieldNames, 1, Pos(',', FieldNames));
          end;
          //邦定第一列在右边
          Bands.Items[0].FixedKind:=fkLeft;
          //分配邦定分组
          i:=0;
          FieldNames:=QyDictionary.cds_QueryProperty.FieldByName('Bands_Fields').AsString;
          while Length(FieldNames) > 0 do
          begin
            AFieldName:=MidStr(FieldNames, 2, Pos(')', FieldNames) - 1);
            while Length(AFieldName) > 1 do
            begin
              (GetItemByFieldName(LeftStr(AFieldName, Pos(',', AFieldName) - 1)) as TcxGridDBBandedColumn).
                Position.BandIndex:=i;
              System.Delete(AFieldName, 1, Pos(',', AFieldName));
            end;
            System.Delete(FieldNames, 1, Pos(')', FieldNames));
            Inc(i);
          end;
        end;
    end;
  finally
    GridView.EndUpdate;
  end;
end;

function TMDGridViewPanel.CreateRootGridLevel(AcxGrid: TcxGrid; LevelCaption: String): TcxGridLevel;
begin
  FLeftButton.Enabled:=true;
  FRightButton.Enabled:=true;
  result:=AcxGrid.Levels.Add;
  result.Caption:=LevelCaption+'  ';
  // result.MaxDetailHeight:=300;
  result.Options.DetailTabsPosition:=dtpTop;
end;

procedure TMDGridViewPanel.CreateDetailQuery(ALevel: TcxGridLevel; DetailQueryIdens: String);
var
  PMDLevel: ^TMDLevel;
  i, QueryIden: Integer;
  NewLevel: TcxGridLevel;
  NewView: TcxCustomGridView;
  QueryCaption, ViewClass: String;
begin
  if DetailQueryIdens = '' then exit;
  try
    QyDictionary.cds_QueryList.Filter:='Query_Iden = ' + StringReplace(DetailQueryIdens, ',', ' OR Query_Iden = ', [rfReplaceAll]);
    QyDictionary.cds_QueryList.Filtered:=true;
    for i := 0 to QyDictionary.cds_QueryList.RecordCount - 1 do
    begin
      QueryIden:=QyDictionary.cds_QueryList.FieldByName('Query_Iden').AsInteger;
      if not QyDictionary.cds_QueryDetail.Locate('Query_Iden', QueryIden, []) then
        raise Exception.CreateRes(@ERR_LocateDataSet);
      if not QyDictionary.cds_QueryProperty.Locate('Query_Iden', QueryIden, []) then
        raise Exception.CreateRes(@ERR_LocateDataSet);

      QueryCaption:=QyDictionary.cds_QueryList.FieldByName('Query_Title_CHN').AsString;
      ViewClass:=QyDictionary.cds_QueryProperty.FieldByName('View_Class').AsString;

      if (ALevel.Control = FMastercxGrid) and (QyDictionary.cds_QueryDetail.FieldByName('Detail_Model').AsString = 'External') then
      begin
        NewLevel:=CreateRootGridLevel(FDetailcxGrid, QueryCaption);
        New(PMDLevel);
        PMDLevel.MasterLevel:=ALevel;
        PMDLevel.DetailLevel:=NewLevel;
        FMDRelation.Add(PMDLevel);
        NewLevel.Tag:=QueryIden;
        NewView:=CreateGridView(FDetailcxGrid, ViewClass);
      end
      else //QyDictionary.cds_QueryDetail.FieldByName('Detail_Model').AsString = 'Inner'
      begin
        NewLevel:=ALevel.Add;
        NewLevel.Caption:=QueryCaption;
        NewLevel.Tag:=QueryIden;
        NewView:=CreateGridView(FMastercxGrid, ViewClass)
      end;

      NewLevel.GridView:=NewView;
      // NewLevel.MaxDetailHeight:=300;
      NewLevel.Options.DetailTabsPosition:=dtpTop;
      // if NewLevel.Parent = ALevel then
      with NewView.DataController as TcxGridDBDataController do
      begin
        MasterKeyFieldNames:=QyDictionary.cds_QueryDetail.FieldByName('Master_Fields').AsString;
        DetailKeyFieldNames:=QyDictionary.cds_QueryDetail.FieldByName('Detail_Fields').AsString;
      end;

      QyDictionary.cds_QueryList.Next;
    end;
  finally
    QyDictionary.cds_QueryDetail.Filtered:=false;
    QyDictionary.cds_QueryList.Filtered:=false;
  end;
end;

procedure TMDGridViewPanel.MergeSameDataSet(FirstDataSet, SendDataSet: TDataSet);
var
  i, j: Integer;
begin
  if FirstDataSet.FieldCount <> SendDataSet.FieldCount then
    raise Exception.Create('数据不能匹配!');

  for i := 0 to FirstDataSet.FieldCount - 1 do    
    FirstDataSet.Fields.Fields[i].ReadOnly:=false;

  SendDataSet.First;
  for i := 0 to SendDataSet.RecordCount - 1 do
  begin
    FirstDataSet.Append;
    for j := 0 to SendDataSet.FieldCount - 1 do
    begin
      FirstDataSet.Edit;
      FirstDataSet.Fields.Fields[j].Value:=SendDataSet.Fields.Fields[j].Value;
    end;
    SendDataSet.Next;
  end;    
end;

procedure TMDGridViewPanel.PaintCloseButton(AcxGrid: TcxGrid);
var
  i: Integer;
begin
  with AcxGrid.ViewInfo.DetailsSiteViewInfo as TcxGridTopDetailsSiteViewInfo do
  begin
    for i := 0 to TabsViewInfo.Count - 1 do
    begin
      if TabsViewInfo.Items[i].Visible and TabsViewInfo.Items[i].Active then
        AcxGrid.Canvas.Canvas.Draw(TabsViewInfo.Items[i].Bounds.Right - 20,
                                   TabsViewInfo.Items[i].Bounds.Top + 2, FCloseGraphic);
    end;
  end;
end;

procedure TMDGridViewPanel.FreeGridView(AGridLevel: TcxGridLevel);
var
  i: Integer;
begin
  if AGridLevel.GridView <> nil then
  begin
    with AGridLevel.GridView.DataController as TcxGridDBDataController do
    begin
      DataSource.DataSet.Free;
      DataSource.DataSet:=nil;
      DataSource.Free;
      DataSource:=nil
    end;
    AGridLevel.GridView.Destroy;
    AGridLevel.GridView:=nil;
  end;

  for i := 0 to AGridLevel.Count - 1 do
    FreeGridView(AGridLevel.Items[i]);
end;

procedure TMDGridViewPanel.MastercxGridClick(Sender: TObject);
var
  i: Integer;
  PMDLevel: ^TMDLevel;
  MousePoint: TPoint;
  RootLevelBound, CloseBound: TRect;
  ARootLevel: TcxGridLevel;
  AGridHitTest: TcxCustomGridHitTest;
  AHitType: TcxGridViewHitType;
begin
  with Sender as TcxGrid do
  begin
    MousePoint:=ScreenToClient(Mouse.CursorPos);
    AGridHitTest:=ViewInfo.GetHitTest(MousePoint.X, MousePoint.Y);
    AHitType:=GetHitTypeByHitCode(AGridHitTest.HitTestCode);
    if AHitType = gvhtTab then
    begin
      ARootLevel:=(AGridHitTest.ViewInfo as TcxGridDetailsSiteTopTabViewInfo).Level;
      RootLevelBound:=(AGridHitTest.ViewInfo as TcxGridDetailsSiteTopTabViewInfo).Bounds;
      CloseBound.Left:=RootLevelBound.Right - 20;
      CloseBound.Top:=RootLevelBound.Top + 2;
      CloseBound.Right:=RootLevelBound.Right - 2;
      CloseBound.Bottom:=RootLevelBound.Top + 20;

      if (ARootLevel.Level = 0) and (PtInRect(CloseBound, MousePoint)) then
      begin
        self.Cursor := crhandPoint;
        //释放从表格Level
        for i := FMDRelation.Count - 1 downto 0  do
        begin
          PMDLevel:=FMDRelation.Items[i];
          if PMDLevel^.MasterLevel = ARootLevel then
          begin
            FreeGridView(PMDLevel^.DetailLevel);
            PMDLevel^.DetailLevel.Free;
            FMDRelation.Delete(i);
          end;
        end;
        //释放主表格Level
        FreeGridView(ARootLevel);
        ARootLevel.Destroy;
      end;

      if Levels.Count = 0 then
      begin
        FcxSplitter.CloseSplitter;
        FcxSplitter.Visible:=false;
        FConditionEdit.Text:='';
        FConditionEdit.ReadOnly:=true;
      end
    end;
  end;
  FLeftButton.Enabled:=FMastercxGrid.Levels.Count <> 0;
  FRightButton.Enabled:=FMastercxGrid.Levels.Count <> 0;
end;

procedure TMDGridViewPanel.MastercxGridWindowProc(var Message: TMessage);
begin
  FOldcxGridWndMethod(Message);

  if Message.Msg = WM_PAINT then
    PaintCloseButton(FMastercxGrid);
end;

procedure TMDGridViewPanel.NavigationClick(Sender: TObject);
var
  AIndex: Integer;
  function GetLastVisibleTab: TcxGridLevel;
  var
    APoint: TPoint;
    I: Integer;
    AFlag: Boolean;
  begin
    Result := nil;
    with TcxGridTopDetailsSiteViewInfo(FMastercxGrid.ViewInfo.DetailsSiteViewInfo).TabsViewInfo do
      for I := 0  to Count - 1 do
      begin
        APoint := Items[I].Bounds.TopLeft;
        if PtInRect(FMastercxGrid.Bounds, APoint) and not AFlag then
          AFlag := True;
        if AFlag and not PtInRect(FMastercxGrid.Bounds, APoint) then
        begin
          Result := TcxGridDetailsSiteTopTabViewInfo(Items[I - 1 ]).Level;
          Break;
        end;
      end;
  end;

  function IfTabVisible(ALevel: TcxGridLevel): Boolean;
  var
    i: Integer;
    APoint: TPoint;
  begin
    Result := False;
    with TcxGridTopDetailsSiteViewInfo(FMastercxGrid.ViewInfo.DetailsSiteViewInfo).TabsViewInfo do
      for i := 0 to Count - 1 do
      if TcxGridDetailsSiteTopTabViewInfo(Items[i]).Level = ALevel then
      begin
        APoint:=Items[I].Bounds.TopLeft;
        Result:=PtInRect(FMastercxGrid.Bounds, APoint);
        Break;
      end;
  end;

  function FindIndex: Integer;
  var
    Diff: Integer;
  begin
    Result := AIndex;
    Diff := FMastercxGrid.Levels[AIndex].VisibleIndex - Result;
    while (FMastercxGrid.Levels[Result].VisibleIndex - Result) = Diff do
      Inc(Result);
  end;
begin
  with FMastercxGrid, FMastercxGrid.Levels do
  begin
    if Sender = FLeftButton then
    begin
      if (ActiveLevel.Index - 1 >= 0) and IfTabVisible(Levels[ActiveLevel.Index - 1]) then
        ActiveLevel:=Levels[ActiveLevel.Index - 1]
      else
      begin
        AIndex := VisibleItems[0].Index;
        if (VisibleItems[0].Active) and (VisibleCount < Count - VisibleItems[0].Index )then
          AIndex := FindIndex
        else
          Dec(AIndex);

        if (AIndex <> -1) and (AIndex < Count) then
        begin
          Items[AIndex].Visible := True;
          ActiveLevel := Items[AIndex];
        end;
      end;
    end;

    if Sender = FRightButton then
    begin
      if (ActiveLevel.Index + 1 < Levels.Count) and IfTabVisible(Levels[ActiveLevel.Index + 1]) then
        ActiveLevel := Levels[ActiveLevel.Index + 1]
      else
      begin
        if VisibleCount > 1 then
          if not VisibleItems[0].Active then
            VisibleItems[0].Visible := False
          else
            if VisibleCount >= 2 then
              VisibleItems[1].Visible := False;

        if ActiveLevel.Index < Levels.Count - 2 then
          ActiveLevel := GetLastVisibleTab;
      end;
    end;
  end;
end;

procedure TMDGridViewPanel.GetDetailData(MasterLevel, DetailLevel: TcxGridLevel);
var
  i: Integer;
  vCondition, QueryData: OleVariant;
  MasterDataController, DetailDataController: TcxGridDBDataController;
  FilterString, MasterKeyName, DetailKeyName, MasterKeyNames, DetailKeyNames, DetailQueryIdens: String;
begin
  MasterDataController:=MasterLevel.GridView.DataController as TcxGridDBDataController;
  DetailDataController:=DetailLevel.GridView.DataController as TcxGridDBDataController;
  MasterKeyNames:=DetailDataController.MasterKeyFieldNames + ';';
  DetailKeyNames:=DetailDataController.DetailKeyFieldNames + ';';

  vCondition:=VarArrayOf(['', '', '', '']);
  for i := 0 to 3 do
  begin
    MasterKeyName:=LeftStr(MasterKeyNames, Pos(';', MasterKeyNames) - 1);
    //构造主表关键字段值
    if MasterDataController.DataSource.DataSet.FindField(MasterKeyName) = nil then exit;
    vCondition[i]:=MasterDataController.DataSource.DataSet.FieldByName(MasterKeyName).AsString;
    System.Delete(MasterKeyNames, 1, Pos(';', MasterKeyNames));
    if MasterKeyNames = '' then break;
  end;

  //判断数据是否已经取回
  with DetailDataController do
  try
    DataSet.DisableControls;
    if DataSet.Filtered then
      DataSet.Filtered:=False;

    //取数
    BeginUpdate;
    if (not DataSet.Active) or (not DataSet.Locate(DetailKeyNames, vCondition, [])) then
    begin
      OnOpenDetail(DetailLevel.Tag, vCondition, QueryData);

      //建立数据
      if DataSet.Active then
      begin
        (FTempDataSet as TClientDataSet).Data:=QueryData;
        MergeSameDataSet(DataSet, FTempDataSet);
        (DataSet as TClientDataSet).MergeChangeLog;
      end
      else
      begin
        (DataSet as TClientDataSet).Data:=QueryData;
        
        if Assigned(OnAfterOpenDataSet) then
          OnAfterOpenDataSet(DataSource.DataSet);
        CreateFieldColumn(DetailLevel.Tag, DetailDataController);
        //建立子数据
        if QyDictionary.cds_QueryList.Locate('Query_Iden', DetailLevel.Tag, []) then
        begin
          DetailQueryIdens:=QyDictionary.cds_QueryList.FieldByName('Detail_Query').AsString;
          CreateDetailQuery(DetailDataController.GridView.Level as TcxGridLevel, DetailQueryIdens);
        end;
      end;
    end;

    //分立表格加入过滤条件
    if DetailLevel.Control = FDetailcxGrid then
    begin
      if not QyDictionary.cds_QueryDetail.Locate('Query_Iden', DetailLevel.Tag, []) then
        raise Exception.CreateRes(@ERR_LocateDataSet);
      if QyDictionary.cds_QueryDetail.FieldByName('Filter_Model').AsString = 'Grid' then
      with DetailDataController.Filter do
      try
        BeginUpdate;
        Root.Clear;
        for i := 0 to 3 do
        begin
          DetailKeyName:=LeftStr(DetailKeyNames, Pos(';', DetailKeyNames) - 1);
          //构造主表关键字段值
          Root.AddItem(GetItemByFieldName(DetailKeyName), foEqual, vCondition[i], vCondition[i]);
          System.Delete(DetailKeyNames, 1, Pos(';', DetailKeyNames));
          if DetailKeyNames = '' then break;
        end;

        if not Active then
          Active:=true;
        DataSet.Filtered:=false;
      finally
        EndUpdate;
      end;

      if QyDictionary.cds_QueryDetail.FieldByName('Filter_Model').AsString = 'Dataset' then
      begin
        FilterString:='';
        for i := 0 to 3 do
        begin
          DetailKeyName:=LeftStr(DetailKeyNames, Pos(';', DetailKeyNames) - 1);
          //构造主表关键字段值
          FilterString:=FilterString + Format('%s = ''%s'' AND ', [DetailKeyName, vCondition[i]]);
          System.Delete(DetailKeyNames, 1, Pos(';', DetailKeyNames));
          if DetailKeyNames = '' then break;
        end;
        SetLength(FilterString, Length(FilterString) - 4);
        DataSet.Filter:=FilterString;
      end;
    end;
  finally
    DataSet.Filtered:=True;
    DataSet.EnableControls;
    //下面2句不能前后颠倒,否则会出错????
    EndUpdate;
    DetailLevel.Active:=true;

    if not GridView.ClassNameIs('TcxGridDBCardView') then
    with GridView as TcxGridTableView do
    begin
      DataController.Groups.FullExpand;
      OptionsView.Header:=False;
      ApplyBestFit;
      OptionsView.Header:=True;
    end;
  end;
end;

procedure TMDGridViewPanel.DetailExpanding(
  ADataController: TcxCustomDataController; ARecordIndex: Integer; var AAllow: Boolean);
var
  i: Integer;
  MasterGridLevel: TcxGridLevel;
begin
  //如果该事件没有被赋值，则无法取数
  if not Assigned(OnOpenDetail) then exit;

  MasterGridLevel:=(ADataController as TcxGridDBDataController).GridView.Level as TcxGridLevel;
  ADataController.FocusedRecordIndex:=ARecordIndex;
  //同级别数据一次Load
  for i := 0 to MasterGridLevel.Count - 1 do
    GetDetailData(MasterGridLevel, MasterGridLevel.Items[i]);

  ShowDetailLevel((ADataController as TcxGridDBDataController).GridView.Site);
end;

function TMDGridViewPanel.CreateGridView(AcxGrid: TcxGrid; ViewClass: String): TcxCustomGridView;
  function GetViewClass(ViewClass: String): TcxCustomGridViewClass;
  begin
    result := TcxGridDBTableView;
    if ViewClass = 'TcxGridDBTableView' then
      result:=TcxGridDBTableView;

    if ViewClass = 'TcxGridDBBandedTableView' then
      result:=TcxGridDBBandedTableView;

    if ViewClass = 'TcxGridDBCardView' then
      result:=TcxGridDBCardView;
  end;
var
  NewView: TcxCustomGridView;
begin
  NewView:=AcxGrid.CreateView(GetViewClass(ViewClass));
  with NewView as TcxCustomGridTableView do
  begin
    OptionsData.Deleting:=false;
    OptionsData.Editing:=false;
    OptionsData.Inserting:=false;
  end;

  if ViewClass <> 'TcxGridDBCardView' then
    (NewView as TcxGridTableView).OptionsView.GroupByBox:=false;

  with NewView.DataController as TcxGridDBDataController do
  begin
    DataSource:=TDataSource.Create(FMastercxGrid);
    DataSource.DataSet:=TClientDataSet.Create(FMastercxGrid);

    NewView.OnDblClick:=ViewDbClick;
    NewView.OnKeyDown:=ViewKeyDown;
    OnDetailExpanding:=DetailExpanding;
    OnDataChanged:=DataControllerDataChanged;
  end;
  result:=NewView;
end;

procedure TMDGridViewPanel.CreateMasterQuery(QueryIden: Integer; ConditionString: String; QueryData: OleVariant);
var
  NewLevel: TcxGridLevel;
  NewView: TcxCustomGridView;
  QueryCaption, ViewClass, DetailQueryIdens: String;
begin
  //定位查询信息
  if not QyDictionary.cds_QueryList.Locate('Query_Iden', QueryIden, []) then
    raise Exception.CreateRes(@ERR_LocateDataSet);
  if not QyDictionary.cds_QueryProperty.Locate('Query_Iden', QueryIden, []) then
    raise Exception.CreateRes(@ERR_LocateDataSet);
  QueryCaption:=QyDictionary.cds_QueryList.FieldByName('Query_Title_CHN').AsString;
  DetailQueryIdens:=QyDictionary.cds_QueryList.FieldByName('Detail_Query').AsString;
  ViewClass:=QyDictionary.cds_QueryProperty.FieldByName('View_Class').AsString;

  //判断数据集合是否为空
  (FTempDataSet as TClientDataSet).Data:=QueryData;
  if FTempDataSet.IsEmpty then
    raise Exception.CreateResFmt(@EMP_GQQueryInfo, [QueryCaption, ConditionString]);
  (FTempDataSet as TClientDataSet).EmptyDataSet;
  //Create Level & View
  NewLevel:=CreateRootGridLevel(FMastercxGrid, QueryCaption);
  NewLevel.Tag:=QueryIden;
  NewView:=CreateGridView(FMastercxGrid, ViewClass);
  NewLevel.GridView:=NewView;
  FConditionTextList.AddObject(ConditionString, NewLevel);
  with NewView.DataController as TcxGridDBDataController do
  try
    NewView.BeginUpdate;
    DataSource.DataSet.DisableControls;
    (DataSource.DataSet as TClientDataSet).Data:=QueryData;
    if Assigned(OnAfterOpenDataSet) then
      OnAfterOpenDataSet(DataSource.DataSet);
    CreateFieldColumn(QueryIden, NewView.DataController as TcxGridDBDataController);
  finally
    DataSource.DataSet.EnableControls;
    NewView.EndUpdate;
  end;

  //Create Detail Query
  CreateDetailQuery(NewLevel, DetailQueryIdens);
  //等于1是不能触发Changed事件
  //Show Level & View
  NewLevel.Active:=true;
  if FMastercxGrid.Levels.Count = 1 then
    ActiveTabChanged(FMastercxGrid, NewLevel);
    
  if not NewView.ClassNameIs('TcxGridDBCardView') then
  with NewView as TcxGridTableView do
  begin
    DataController.Groups.FullExpand;
  //  OptionsView.Header:=False;
    ApplyBestFit(nil);
  //  OptionsView.Header:=True;
  end;
end;

procedure TMDGridViewPanel.DataControllerDataChanged(Sender: TObject);
begin
  if not Sender.ClassNameIs('TcxGridDBDataController') then exit;
  if not (Sender as TcxGridDBDataController).GridView.ClassNameIs('TcxGridDBTableView') then exit;

  with (Sender as TcxGridDBDataController).GridView as TcxGridDBTableView do
  begin
    if ViewInfo.HeaderViewInfo.Count = 0 then
    begin
      ViewInfo.Recalculate;
      DataController.Groups.FullExpand;
      OptionsView.Header:=False;
      ApplyBestFit;
      OptionsView.Header:=True;
    end
  end;
end;

procedure TMDGridViewPanel.ShowDetailLevel(AGirdSite: TcxGridSite);
var
  i: Integer;
  MasterLevel,TheActiveLevel: TcxGridLevel;
begin
  //如果包含子表格，则显示子表格
  MasterLevel:=AGirdSite.GridView.Level as TcxGridLevel;
  if MasterLevel.Control <> FDetailcxGrid then
  begin
    TheActiveLevel:=FDetailcxGrid.ActiveLevel;
    for i := 0 to FDetailcxGrid.Levels.VisibleCount - 1 do
      GetDetailData(MasterLevel, FDetailcxGrid.Levels.VisibleItems[i]);
    if TheActiveLevel <> nil then TheActiveLevel.Active:=true;
  end;

  //如果包含子节点
  with AGirdSite.GridView.DataController as TcxGridDBDataController do
    ChangeDetailExpanding(FocusedRecordIndex, not GetDetailExpanding(FocusedRecordIndex));
end;

procedure TMDGridViewPanel.ViewDbClick(Sender: TObject);
begin
  if Assigned(OnGridViewDbClick) then
    OnGridViewDbClick(Sender);

  if Sender.ClassName = 'TcxGridSite' then
    ShowDetailLevel(Sender as TcxGridSite);
end;

procedure TMDGridViewPanel.ViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Assigned(OnGridViewKeyDown) then
    OnGridViewKeyDown(Sender, Key, Shift);

  if (Key = VK_RETURN) and Sender.ClassNameIs('TcxGridSite') then
    ShowDetailLevel(Sender as TcxGridSite);
end;

procedure TMDGridViewPanel.ActiveTabChanged(Sender: TcxCustomGrid; ALevel: TcxGridLevel);
var
  i: Integer;
  LevelIndex: Integer;
  PMDLevel: ^TMDLevel;
begin
  //如果不是根Level Exit
  if ALevel.Level <> 0 then exit;
  FConditionEdit.Text:='';
  FConditionEdit.ReadOnly:=True;
  LevelIndex:=FConditionTextList.IndexOfObject(ALevel);
  if LevelIndex = -1 then exit;

  FConditionEdit.Text:=FConditionTextList.Strings[LevelIndex] + ' ';
  FConditionEdit.ReadOnly:=False;
  FConditionEdit.Tag:=ALevel.Tag;

  for i := 0 to FDetailcxGrid.Levels.Count - 1 do
    FDetailcxGrid.Levels.Items[i].Visible:=false;

  for i := 0 to FMDRelation.Count - 1 do
  begin
    PMDLevel:=FMDRelation.Items[i];
    PMDLevel^.DetailLevel.Visible:= PMDLevel^.MasterLevel = ALevel;
  end;

  FcxSplitter.Visible:=FDetailcxGrid.Levels.VisibleCount <> 0;
  if FcxSplitter.Visible then
    FcxSplitter.OpenSplitter
  else
    FcxSplitter.CloseSplitter;
end;

procedure TMDGridViewPanel.ReQueryData(Sender: TObject);
var
  i: Integer;
  SplitterPos: Integer;
  ConditionString, PreDeclareVarString: String;
  QueryData: OleVariant;
begin
  if not Assigned(ReQueryEvent) then Exit;
  if FConditionEdit.Text = '' then Exit;

  SplitterPos:=Pos('|', FConditionEdit.Text);
  if SplitterPos = 0 then
    raise Exception.Create('无法识别的条件!');

  ConditionString:=LeftStr(FConditionEdit.Text, SplitterPos - 1);
  PreDeclareVarString:=MidStr(FConditionEdit.Text, SplitterPos + 1, MAXINT);

  ReQueryEvent(FConditionEdit.Tag, PreDeclareVarString, ConditionString, QueryData);

  //清主表数据
  with (FMastercxGrid.ActiveLevel.GridView.DataController as TcxGridDBDataController).DataSource do
  begin
    (DataSet as TClientDataSet).Data:=QueryData;
    if Assigned(OnAfterOpenDataSet) then
      OnAfterOpenDataSet(DataSet);
  end;
  //清从表数据
  for i := 0 to FDetailcxGrid.Levels.VisibleCount - 1 do
  begin
    with (FDetailcxGrid.Levels.VisibleItems[i].GridView.DataController as TcxGridDBDataController).DataSource.DataSet as TClientDataSet do
    if Active then
      EmptyDataSet;
  end;

  FConditionTextList.Strings[FConditionTextList.IndexOfObject(FMastercxGrid.ActiveLevel)]:=
    ConditionString + ' | ' + PreDeclareVarString;
end;

constructor TMDGridViewPanel.Create(AOwner: TComponent);
var
  ConditionPanel: TPanel;
begin
  inherited;
  BevelInner:=bvRaised;
  BevelOuter:=bvLowered;

  FMDRelation:=TList.Create;
  FCloseGraphic:=TBitMap.Create;
  (FCloseGraphic as TBitMap).LoadFromResourceName(HInstance, RES_CLOSETABLE);

  ConditionPanel:=TPanel.Create(Self);
  with ConditionPanel do
  begin
    Parent:=Self;
    Name:='ConditionPanel';
    Align:=alTop;
    Caption:=' ';
    SetSubComponent(True);
  end;

  FConditionEdit:=TEdit.Create(Self);
  with FConditionEdit do
  begin
    Parent:=ConditionPanel;
    Text:='';
    ReadOnly:=True;
    CharCase := ecUpperCase;
    OnKeyDown:=EditKeyDown;
    SetSubComponent(True);

    ConditionPanel.AutoSize:=True;
    ConditionPanel.Height:=Height;
  end;

  with TPanel.Create(Self) do
  begin
    Parent:=ConditionPanel;
    Caption:='条件:';
    BevelOuter := bvNone;
    Width:=45;
    Align:=alLeft;
    SetSubComponent(True);
  end;

  with TSpeedButton.Create(Self) do
  begin
    Parent:=ConditionPanel;
    Flat:=true;
    Caption:='查询(&Q)';
    Width:=60;
    Align:=alRight;
    OnClick:=ReQueryData;
    SetSubComponent(True);

    FConditionEdit.Align:=alClient;
  end;

  FDetailcxGrid:= TcxGrid.Create(Self);
  with FDetailcxGrid do
  begin
    Name:='DetailcxGrid';
    Parent:=Self;
    Height:=132;
    Align:=alBottom;
    LookAndFeel.NativeStyle:=true;
    RootLevelOptions.DetailTabsPosition:=dtpTop;
    SetSubComponent(True);
  end;
  FDetailcxGridPopupMenu:=TcxGridPopupMenu.Create(Self);
  FDetailcxGridPopupMenu.Grid:=FDetailcxGrid;

  FcxSplitter:= TcxSplitter.Create(Self);
  with FcxSplitter do
  begin
    Name:='cxSplitter';
    Parent:=Self;
    AlignSplitter := salBottom;
    HotZoneClassName:='TcxXPTaskBarStyle';
    Control:=FDetailcxGrid;
    SetSubComponent(True);
  end;

  FMastercxGrid:= TcxGrid.Create(Self);
  with FMastercxGrid do
  begin
    Name:='MastercxGrid';
    Parent:=Self;
    Align:=alClient;
    LookAndFeel.NativeStyle:=true;
    RootLevelOptions.DetailTabsPosition:=dtpTop;
    OnClick:=MastercxGridClick;
    OnActiveTabChanged:=ActiveTabChanged;
    SetSubComponent(True);
  end;
  FMastercxGridPopupMenu:=TcxGridPopupMenu.Create(Self);
  FMastercxGridPopupMenu.Grid:=FMastercxGrid;

  FRightButton:=TSpeedButton.Create(Self);
  with FRightButton do
  begin
    Name:='RighButton';
    Parent:=FMastercxGrid;
    Left:=FMastercxGrid.Left + FMastercxGrid.Width - Width - 2;
    Top:=2;
    Height:=18;
    Anchors:=[akTop, akRight];
    Flat:=true;
    Enabled:=false;
    Glyph.LoadFromResourceName(HInstance, RES_RIGHT);
    OnClick:=NavigationClick;
    SetSubComponent(True);
  end;

  FLeftButton:=TSpeedButton.Create(Self);
  with FLeftButton do
  begin
    Name:='LeftButton';
    Parent:=FMastercxGrid;
    Left:=FRightButton.Left - Width - 2;
    Top:=2;
    Height:=18;
    Anchors:=[akTop, akRight];
    Flat:=true;
    Enabled:=false;
    Glyph.LoadFromResourceName(HInstance, RES_LEFT);
    OnClick:=NavigationClick;
    SetSubComponent(True);
  end;
  
  FOldcxGridWndMethod:=FMastercxGrid.WindowProc;
  FMastercxGrid.WindowProc:=MastercxGridWindowProc;

  FcxSplitter.CloseSplitter;
  FcxSplitter.Visible:=false;
  FTempDataSet:=TClientDataSet.Create(self);
  FConditionTextList:=TStringList.Create;
end;

destructor TMDGridViewPanel.Destroy;
var
  i: Integer;
  PMDLevel: ^TMDLevel;
begin
  //释放主从关系列表
  for i := FMDRelation.Count - 1 downto 0 do
  begin
    PMDLevel:=FMDRelation.Items[i];
    Dispose(PMDLevel);
    FMDRelation.Delete(i);
  end;

  FreeAndNil(FTempDataSet);
  FreeAndNil(FConditionTextList);
  FreeAndNil(FCloseGraphic);
  inherited;
end;

procedure TMDGridViewPanel.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then ReQueryData(Sender);
end;

end.
