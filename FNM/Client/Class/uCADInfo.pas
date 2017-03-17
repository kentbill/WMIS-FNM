unit uCADInfo;
{*|<PRE>*****************************************************************************
                                                                             
       软件名称 FNM CLIENT MODEL                                               
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                              
       单元名称 uCADInfo.pas                                                   
       创建日期 2004-11-30 17:54:29                                            
       创建人员 lvzd                                                           
       修改人员                                                                
       修改日期                                                                
       修改原因                                                                
       对应用例                                                                
       字段描述
       相关数据库表
       调用重要函数/SQL对象说明
       功能描述 
                                                                              
******************************************************************************}

interface

uses
  StdCtrls, Classes, Controls, DBClient;

type
{TCADInfo}
  TCADInfo=Class
  {* CAD工艺类}
  private
    FBlackGFNOList: TStringList;
    FOrgGFKeyValue: String;
    Fcds_CADInfo: TClientDataSet;
    Fcds_WebInfo: TClientDataSet;

    function GetFieldValue(Index: Integer): Variant;
    function GetWebInfo: String;
    
    function GetWebInfoFromServer: Boolean;
    function GetCADInfoFromServer: Boolean;

  public
    constructor Create(AOwner: TComponent); overload;
    destructor Destroy; override;

    property Info                  :String read GetWebInfo;//品名ID
    //下面的index值同PDMDB.dbo.tdBasicInfo表字段顺序一致.
    property GF_ID                 :Variant index 1  read GetFieldValue;
    {* 品名ID}
    property GF_NO                 :Variant index 2  read GetFieldValue;
    {* 品名}
    property Width                 :Variant index 3  read GetFieldValue;
    {* 成品幅宽}
    property Shrinkage             :Variant index 4  read GetFieldValue;
    {* 后整缩率}
    property Handfeel              :Variant index 5  read GetFieldValue;
    {* 手感}
    property BRUnitUsage           :Variant index 6  read GetFieldValue;
    {* 特殊染料}
    property Customer_Code         :Variant index 7  read GetFieldValue;
    {* 客户代号}
    property FluorescencePercent   :Variant index 8  read GetFieldValue;
    {* 荧光含量}
    property GreyDensity           :Variant index 9  read GetFieldValue;
    {* 坯布密度}
    property Density               :Variant index 10  read GetFieldValue;
    {* 成品密度}
    property GreyWidth             :Variant index 11  read GetFieldValue;
    {* 坯布幅宽}
    property Reed_Width            :Variant index 12  read GetFieldValue;
    {* 筘幅}
    property Mercerizing           :Variant index 13  read GetFieldValue;
    {* 丝光碱浓}
    //cuijf 2010-6-10 增加特殊纱比例
    property SpecialYarnRate       :Variant index 14  read GetFieldValue;
    //hejialin 2016-5-19 增加 DY_Comments,WV_Comments,FN_Comments,Comments 这几个备注信息
    property DY_Comments           :Variant index 15  read GetFieldValue;
    property WV_Comments           :Variant index 16  read GetFieldValue;
    property FN_Comments           :Variant index 17  read GetFieldValue;
    property Comments              :Variant index 18  read GetFieldValue;
    //hejialin 2016-5-24 增加Color_Code 色号信息显示
    property Color_Code             :Variant index 19 read GetFieldValue;
  published
    property OrgGFKeyValue :String read FOrgGFKeyValue write FOrgGFKeyValue;
  end;

function CADInfo: TCADInfo;
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-10-25 14:27:59
   参数列表: 无
   功能描述:
   引用计数: 返回CAD工艺类实例
-------------------------------------------------------------------------------}
procedure ShowCADPicture(GF_KeyValue: Variant);
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-11-30 17:53:50
   参数列表: GF_KeyValue: String
   功能描述: 显示指定品名或品名ID的花型
   引用计数:
-------------------------------------------------------------------------------}
procedure ShowCADPictureByAControl(Sender: TObject; AControl: TWinControl);
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-11-30 17:53:50
   参数列表: GF_KeyValue: String
   功能描述: 从指定的控件上获取品名并显示图片
   引用计数:
-------------------------------------------------------------------------------}
procedure AutoShowCADPicture(GF_KeyValue: Variant);
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-12-14 12:12:49
   参数列表: GF_KeyValue: String
   功能描述: 当花型控件在显示则显示指定品名或品名ID的花型
   引用计数:
-------------------------------------------------------------------------------}

implementation

{$DEFINE cxGrid}
{$DEFINE DBGrid}
{$DEFINE StringGrid}
{$DEFINE ListView}

uses uShowMessage, uFNMResource, ServerDllPub, uDictionary,
    Forms, GFCADLib_TLB, DB, Variants, Windows, Clipbrd, IdGlobal,
    SysUtils, Dialogs, ExtCtrls
    {$IFDEF cxGrid}
    , cxGrid, cxExportGrid4Link, cxGridCustomView, cxGridTableView, cxGridCustomTableView,
    cxGridDBDataDefinitions
    {$ENDIF}
    {$IFDEF StringGrid}
    , Grids
    {$ENDIF}
    {$IFDEF DBGrid}
    , DBGrids
    {$ENDIF}
    {$IFDEF ListView}
    , ComCtrls
    {$ENDIF}
    ;

var
  ACADInfo: TCADInfo;
{ TCADInfo }

constructor TCADInfo.Create(AOwner: TComponent);
begin
  inherited Create;

  FBlackGFNOList:=TStringList.Create;
  Fcds_CADInfo:=TClientDataSet.Create(AOwner);
  Fcds_WebInfo:=TClientDataSet.Create(AOwner);
end;

destructor TCADInfo.Destroy;
begin
  FBlackGFNOList.Free;
  FreeAndNil(Fcds_CADInfo);
  FreeAndNil(Fcds_WebInfo);
  
  inherited;
end;

function TCADInfo.GetCADInfoFromServer: Boolean;
var
  i: Integer;
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  result := False;
  try
    uFNMResource.ShowStatusMessage(@STA_GetMessage, [STA_CADInfo]);
    FNMServerArtObj.GetCADInfo(vData, OrgGFKeyValue, 1, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@GetCADInfoError, [sErrorMsg]);

    TempClientDataSet.Data:=vData;
    if TempClientDataSet.IsEmpty then
      raise ExceptionEx.CreateResFmt(@EMP_CADInfo, [OrgGFKeyValue]);

    if not Fcds_CADInfo.Active then
      Fcds_CADInfo.Data:=vData
    else
    begin
      //使记录最多维持在200个,先进先出.
      if Fcds_CADInfo.RecordCount > 200 then
      begin
        Fcds_CADInfo.First;
        Fcds_CADInfo.Delete;
        Fcds_CADInfo.MergeChangeLog;
      end;

      Fcds_CADInfo.Append;
      for i := 0 to Fcds_CADInfo.FieldCount - 1 do   
        Fcds_CADInfo.Fields.Fields[i].Value:=TempClientDataSet.Fields.Fields[i].Value;
    end;

    result := True;
  finally
    uFNMResource.ShowStatusMessage(@STA_Ready, []);
  end;
end;

function TCADInfo.GetFieldValue(Index: Integer): Variant;
label
  lEndResult, lGetCADInfo;
var
  I, Code: Integer;
  TheCds: TClientDataSet;
begin
  result:='';
  Val(OrgGFKeyValue, I, Code);
  TheCds:=Fcds_CADInfo;
  //数据集未激活,则直接取数
  if (not Fcds_CADInfo.Active) or Fcds_CADInfo.IsEmpty then
    goto lGetCADInfo;

  //如果当前记录匹配
  if (OrgGFKeyValue = Trim(Fcds_CADInfo['GF_ID'])) or (OrgGFKeyValue = Trim(Fcds_CADInfo['GF_NO'])) then
    goto lEndResult;

  //如果记录在本地被定位
  if Code = 0 then
  begin
    if Fcds_CADInfo.Locate('GF_ID', I, []) then
      goto lEndResult;
  end
  else
  begin
    if Fcds_CADInfo.Locate('GF_NO', OrgGFKeyValue, []) then
      goto lEndResult;
  end;

  lGetCADInfo:
  //在花型数据表中找GF_ID或GF_NO
  if (Index <= 2) and Fcds_WebInfo.Active then
  begin
    if Code = 0 then
    begin
      if Fcds_WebInfo.Locate('GF_ID', I, []) then
      begin
        TheCds:=Fcds_WebInfo;
        goto lEndResult;
      end;
    end
    else
    begin
      if Fcds_WebInfo.Locate('GF_NO', OrgGFKeyValue, []) then
      begin
        TheCds:=Fcds_WebInfo;
        goto lEndResult;
      end;
    end;
  end;
  //从服务器获取
  if GetCADInfoFromServer then
    goto lEndResult;

  //没有查找到
  exit;

  lEndResult:
    result:=TheCds.Fields.Fields[Index - 1].Value;

  if VarIsNull(result) then
  begin
    result:='';
    Exit;
  end;
    
  if Index = 69 then
  begin
    case result of
      0: result:='荧光';
      1: result:='不防';
      2: result:='防荧';
    end;
  end
end;

function TCADInfo.GetWebInfoFromServer: Boolean;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  result := False;
  if FBlackGFNOList.IndexOf(OrgGFKeyValue) <> -1 then
    Exit;
  try
    uFNMResource.ShowStatusMessage(@STA_GetMessage, [STA_WebInfo]);

    FNMServerArtObj.GetCADInfo(vData, OrgGFKeyValue, 0, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@GetWebInfoError, [sErrorMsg]);

    TempClientDataSet.Data:=vData;

    if TempClientDataSet.IsEmpty then
    begin
      FBlackGFNOList.Add(OrgGFKeyValue);
      raise Exception.CreateResFmt(@EMP_WebInfo, [OrgGFKeyValue]);
    end;

    if not Fcds_WebInfo.Active then
      Fcds_WebInfo.Data:=vData
    else
    begin
      //使记录最多维持在200个,先进先出.
      if Fcds_WebInfo.RecordCount > 200 then
      begin
        Fcds_WebInfo.First;
        Fcds_WebInfo.Delete;
        Fcds_WebInfo.MergeChangeLog;
      end;

      with TempClientDataSet do
      begin
        Fcds_WebInfo.AppendRecord([FieldByName('GF_ID').AsString,
                              Trim(FieldByName('GF_NO').AsString),
                                   FieldByName('Info').AsString]);
      end;
    end;

    result := True;
  finally
    uFNMResource.ShowStatusMessage(@STA_Ready, []);
  end;
end;

function TCADInfo.GetWebInfo: String;
label
  lEndResult, lGetWebInfo;
var
  I, Code: Integer;
begin
  result:='';
  //数据集未激活,则直接取数
  if (not Fcds_WebInfo.Active) or Fcds_WebInfo.IsEmpty then
    goto lGetWebInfo;

  //如果当前记录匹配
  if (OrgGFKeyValue = Trim(Fcds_WebInfo['GF_ID'])) or (OrgGFKeyValue = Trim(Fcds_WebInfo['GF_NO'])) then
    goto lEndResult;

  //如果记录在本地被定位
  Val(OrgGFKeyValue, I, Code);
  if Code = 0 then
  begin
    if Fcds_WebInfo.Locate('GF_ID', I, []) then
      goto lEndResult;
  end
  else
  begin
    if Fcds_WebInfo.Locate('GF_NO', OrgGFKeyValue, []) then
      goto lEndResult;
  end;

  lGetWebInfo:
  //从服务器获取
  if GetWebInfoFromServer then
    goto lEndResult;

  //没有查找到
  exit;

  lEndResult:
    result:=Fcds_WebInfo.FieldByName('Info').AsString;
end;

function CADInfo: TCADInfo;
begin
  if ACADInfo = nil then
    ACADInfo:=TCADInfo.Create(nil);

  result:=ACADInfo;
end;

{ TGFCADPictureForm }
type
  TGFCADPictureForm=class(TForm)
  {* GFCADPicture花型显示类}
  private
    FGFCADPIC: TGFCAD;
    FPanel: TPanel;
    FColorBox: TColorBox;
    FTimer: TTimer;
    FLabel:TLabel;//定义标签
    FMemo:TMemo;
    FLabelColor:TLabel; //定义显示色号的标签
  protected
    procedure ColorBoxChange(Sender: TObject);
    procedure CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimerOnTime(Sender: TObject);
  public
    constructor CreateNew(AOwner: TComponent); reintroduce;
    destructor Destroy; override;
  end;

procedure TGFCADPictureForm.ColorBoxChange(Sender: TObject);
begin
  FPanel.Color := TColorBox(Sender).Selected;
end;

procedure TGFCADPictureForm.CustomKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  GFKeyValue: string;
begin
  case key of
    Word('C'): if Shift = [ssCtrl] then Clipboard.asText:=Caption;
    VK_ESCAPE: Close;
  end;
end;

constructor TGFCADPictureForm.CreateNew(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
end;

destructor TGFCADPictureForm.Destroy;
begin
  FColorBox.Free;
  FGFCADPIC.Free;
  FPanel.Free;
  FTimer.Free;
  FLabel.Free;
  FMemo.Free;
  inherited Destroy;
end;

procedure TGFCADPictureForm.TimerOnTime(Sender: TObject);
begin
  try
    (Sender as TTimer).Enabled:=False;
    if Showing then
      ShowCADPictureByAControl(Sender, Screen.ActiveControl);
  finally
    (Sender as TTimer).Enabled:=True;
  end;
end;

function CreateGFCADPictureForm: TGFCADPictureForm;
begin
  result:=TGFCADPictureForm.CreateNew(nil);
  with result do
  begin
    Height:=382;
    Width:=400;
    BorderWidth := 5;
    KeyPreview := True;
    Canvas.Font := Font;
    FormStyle:=fsStayOnTop;
    Position:=poMainFormCenter;
    BorderIcons:=[biSystemMenu, biMaximize];
    BorderStyle := bsSizeable;
    BiDiMode := Application.BiDiMode;
    OnKeyDown:=CustomKeyDown;
    FColorBox := TColorBox.Create(Result);
    with FColorBox do
    begin
      Name := 'FColorBox';
      Parent := result;
      Align := alTop;
      OnChange := ColorBoxChange;
      ItemIndex := 24;
    end;
    FPanel := TPanel.Create(Result);
    with FPanel do
    begin
      Name := 'FPanel';
      Parent := result;
      Align := alClient; // alClient
      BevelOuter := bvNone;
      BorderWidth := 10;
    end;
    FGFCADPIC:=TGFCAD.Create(result);
    with FGFCADPIC do
    begin
      FGFCADPIC.Name := 'FGFCADPIC';
      Parent := FPanel;
      Align := alClient;
    end;

    FTimer:=TTimer.Create(result);
    with FTimer do
    begin
      Interval:=1000;
      OnTimer:=TimerOnTime;
    end;
    //再创建一个Panel 放置两个标签显示（色号和Remarks备注信息）
    FPanel := TPanel.Create(Result);
    with FPanel do
    begin
      Name := 'FPane2';
      Parent := result;
      Align := alBottom; // 显示于底部
      BevelOuter := bvNone;
      BorderWidth := 10;
      Caption:='';
      Height:=100;
    end;
    {FLabel:=TLabel.Create(Result);
    with Flabel do
    begin
      Name:='FLabel1';
      Parent:= FPanel;
      Left:=10;
      Caption:='色号：';
      Top:=5;
    end;}
    FLabelColor:=TLabel.Create(Result);
    with FLabelColor do
    begin
      Name:='FLabel3';
      Parent:=FPanel;
      left:=10;
      Caption:='色号：';
      top:=5;
    end;

    FLabel:=TLabel.Create(Result);
    with Flabel do
    begin
      Name:='FLabel2';
      Parent:= FPanel;
      Left:=10;
      Caption:='Remarks：';
      Top:=30;
    end;
    FMemo:=TMemo.Create(Result);
    with FMemo do
    begin
      Name:='FMemo1';
      Parent:= FPanel;
      Left:=60;
      Text:='';
      Top:=25;
      Width:=320;
      Height:=80;
      ReadOnly:=True;
      ScrollBars:=ssVertical;
      WantReturns:=True;
      WordWrap:=True;
    end;
  end;
end;

var
  lGFCADPictureForm: TGFCADPictureForm;

function GFCADPictureForm: TGFCADPictureForm;
begin
  if lGFCADPictureForm = nil then
    lGFCADPictureForm:= CreateGFCADPictureForm;

  result:=lGFCADPictureForm;
end;

procedure ShowCADPicture(GF_KeyValue: Variant);
begin
  if GFCADPictureForm.Showing and (Pos(GF_KeyValue, GFCADPictureForm.Caption) <> 0) then Exit;
  if (Trim(GF_KeyValue) = '') or  VarIsNull(GF_KeyValue) then exit;

  CADInfo.OrgGFKeyValue:=GF_KeyValue;

  GFCADPictureForm.FGFCADPIC.Info:=CADInfo.Info;
  GFCADPictureForm.Caption:=Format('品名:%s; 品名ID:%s', [Trim(CADInfo.GF_NO), Trim(CADInfo.GF_ID)]);
  GFCADPictureForm.FLabelColor.Caption:=Format('色号：%s',[CADInfo.Color_Code]);//色号用逗号相隔开
  GFCADPictureForm.FMemo.Text:=Format('%s 织造:%s 后整:%s 其它:%s',[trim(CADInfo.DY_Comments)+#13#10,trim(cadinfo.WV_Comments)+#13#10,trim(cadinfo.FN_Comments)+#13#10,trim(cadinfo.Comments)]);

  if not GFCADPictureForm.Showing then
    GFCADPictureForm.Show;
end;

procedure ShowCADPictureByAControl(Sender: TObject; AControl: TWinControl);
const
  KeyStrs = 'GF_ID,GF_NO,品名,品名代号';
var
  EnableClass: String;
  function GetGFIden: string;
  var
    i: Integer;
    {$IFDEF cxGrid}
      GridTableItem: TcxCustomGridTableItem;
    {$ENDIF}
  begin
    if AControl = nil then Exit;

    if AControl is TCustomEdit then
    begin
      with AControl as TCustomEdit do
      begin
        Result:=SelText;
        if Result = '' then
          Result:=Text;

        if (Result = '') or ((pos('-', Result) = 0) and (Result[1] <> 'W') or (pos('-', Result) > 10)) then
          Result:='';
      end;
    end;

    if (not (Sender is TTimer)) and (Result = '') and (Screen.ActiveForm is TGFCADPictureForm) then
    begin
      if not InputQuery('查看花型', '请输入品名或品名ID:', Result) then
         Result:= ''
    end;

    if Pos(AControl.ClassName, EnableClass) = 0 then Exit;
    if AControl.ClassName = 'TStringGrid' then
    begin
      with AControl as TStringGrid do
      begin
        for i := 0 to ColCount - 1 do
          if Pos(Cells[i, 0], KeyStrs) <> 0 then
            Result:=Cells[i, Row];
      end;
    end;

    if AControl.ClassName = 'TListView' then
    begin
      with AControl as TListView do
      begin
        if Selected = nil then Exit;
        for i := 0 to Columns.Count - 1 do
        begin
          if Pos(Columns.Items[i].Caption, KeyStrs) <> 0 then
          begin
            if i = 0 then
              Result:=Selected.Caption
            else
              Result:=Selected.SubItems.Strings[i - 1];
          end;
        end;
      end;
    end;

    if (AControl.ClassName = 'TDBGrid') then
    begin
      with AControl as TDBGrid do
      begin
        for i := 0 to Columns.Count - 1 do
        begin
          if Pos(Columns[i].Title.Caption, KeyStrs) <> 0 then
            Result:=DataSource.DataSet[Columns[i].Field.FieldName]
        end;
      end;
    end;
    
    {$IFDEF cxGrid}
//      if AControl.ClassParent.ClassName = 'TcxCustomInnerTextEdit' then
//      begin
//        with AControl as TcxCustomInnerTextEdit do
//        begin
//          (AControl as TcxCustomInnerTextEdit).
//        end;
//      end;

      if AControl.ClassName = 'TcxGridSite' then
      begin
        with (AControl as TcxGridSite).GridView as TcxCustomGridView do
        begin
          if DataController.FocusedRecordIndex = -1 then Exit;

          if DataController.ClassName = 'TcxGridDBDataController' then
          begin
            GridTableItem:=(DataController as TcxGridDBDataController).GetItemByFieldName('GF_ID');
            if GridTableItem = nil then
              GridTableItem:=(DataController as TcxGridDBDataController).GetItemByFieldName('GF_NO');
            if GridTableItem = nil then
              GridTableItem:=(DataController as TcxGridDBDataController).GetItemByFieldName('品名');
          end else
          if DataController.ClassName = 'TcxGridDataController' then
          begin
            with (AControl as TcxGridSite).GridView as TcxGridTableView do
            begin
              GridTableItem:=FindItemByName('GF_ID');
              if GridTableItem = nil then
                GridTableItem:=FindItemByName('GF_NO');
              if GridTableItem = nil then
                GridTableItem:=FindItemByName('品名');
            end;
          end;

          if GridTableItem = nil then exit;
          Result:=DataController.Values[DataController.FocusedRecordIndex, GridTableItem.Index];
        end;
      end;
    {$ENDIF}
  end;
begin
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

  ShowCADPicture(GetGFIden);
end;

procedure AutoShowCADPicture(GF_KeyValue: Variant);
begin
  if GFCADPictureForm.Showing then
    ShowCADPicture(GF_KeyValue);
end;

initialization
  ACADInfo:=nil;
  lGFCADPictureForm:=nil;

finalization
  FreeAndNil(ACADInfo);
  FreeAndNil(lGFCADPictureForm);

end.

