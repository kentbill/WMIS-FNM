unit uCADInfo;
{*|<PRE>*****************************************************************************
                                                                             
       ������� FNM CLIENT MODEL                                               
       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                              
       ��Ԫ���� uCADInfo.pas                                                   
       �������� 2004-11-30 17:54:29                                            
       ������Ա lvzd                                                           
       �޸���Ա                                                                
       �޸�����                                                                
       �޸�ԭ��                                                                
       ��Ӧ����                                                                
       �ֶ�����
       ������ݿ��
       ������Ҫ����/SQL����˵��
       �������� 
                                                                              
******************************************************************************}

interface

uses
  StdCtrls, Classes, Controls, DBClient;

type
{TCADInfo}
  TCADInfo=Class
  {* CAD������}
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

    property Info                  :String read GetWebInfo;//Ʒ��ID
    //�����indexֵͬPDMDB.dbo.tdBasicInfo���ֶ�˳��һ��.
    property GF_ID                 :Variant index 1  read GetFieldValue;
    {* Ʒ��ID}
    property GF_NO                 :Variant index 2  read GetFieldValue;
    {* Ʒ��}
    property Width                 :Variant index 3  read GetFieldValue;
    {* ��Ʒ����}
    property Shrinkage             :Variant index 4  read GetFieldValue;
    {* ��������}
    property Handfeel              :Variant index 5  read GetFieldValue;
    {* �ָ�}
    property BRUnitUsage           :Variant index 6  read GetFieldValue;
    {* ����Ⱦ��}
    property Customer_Code         :Variant index 7  read GetFieldValue;
    {* �ͻ�����}
    property FluorescencePercent   :Variant index 8  read GetFieldValue;
    {* ӫ�⺬��}
    property GreyDensity           :Variant index 9  read GetFieldValue;
    {* �����ܶ�}
    property Density               :Variant index 10  read GetFieldValue;
    {* ��Ʒ�ܶ�}
    property GreyWidth             :Variant index 11  read GetFieldValue;
    {* ��������}
    property Reed_Width            :Variant index 12  read GetFieldValue;
    {* �ط�}
    property Mercerizing           :Variant index 13  read GetFieldValue;
    {* ˿���Ũ}
    //cuijf 2010-6-10 ��������ɴ����
    property SpecialYarnRate       :Variant index 14  read GetFieldValue;
    //hejialin 2016-5-19 ���� DY_Comments,WV_Comments,FN_Comments,Comments �⼸����ע��Ϣ
    property DY_Comments           :Variant index 15  read GetFieldValue;
    property WV_Comments           :Variant index 16  read GetFieldValue;
    property FN_Comments           :Variant index 17  read GetFieldValue;
    property Comments              :Variant index 18  read GetFieldValue;
    //hejialin 2016-5-24 ����Color_Code ɫ����Ϣ��ʾ
    property Color_Code             :Variant index 19 read GetFieldValue;
  published
    property OrgGFKeyValue :String read FOrgGFKeyValue write FOrgGFKeyValue;
  end;

function CADInfo: TCADInfo;
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-10-25 14:27:59
   �����б�: ��
   ��������:
   ���ü���: ����CAD������ʵ��
-------------------------------------------------------------------------------}
procedure ShowCADPicture(GF_KeyValue: Variant);
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-11-30 17:53:50
   �����б�: GF_KeyValue: String
   ��������: ��ʾָ��Ʒ����Ʒ��ID�Ļ���
   ���ü���:
-------------------------------------------------------------------------------}
procedure ShowCADPictureByAControl(Sender: TObject; AControl: TWinControl);
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-11-30 17:53:50
   �����б�: GF_KeyValue: String
   ��������: ��ָ���Ŀؼ��ϻ�ȡƷ������ʾͼƬ
   ���ü���:
-------------------------------------------------------------------------------}
procedure AutoShowCADPicture(GF_KeyValue: Variant);
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-12-14 12:12:49
   �����б�: GF_KeyValue: String
   ��������: �����Ϳؼ�����ʾ����ʾָ��Ʒ����Ʒ��ID�Ļ���
   ���ü���:
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
      //ʹ��¼���ά����200��,�Ƚ��ȳ�.
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
  //���ݼ�δ����,��ֱ��ȡ��
  if (not Fcds_CADInfo.Active) or Fcds_CADInfo.IsEmpty then
    goto lGetCADInfo;

  //�����ǰ��¼ƥ��
  if (OrgGFKeyValue = Trim(Fcds_CADInfo['GF_ID'])) or (OrgGFKeyValue = Trim(Fcds_CADInfo['GF_NO'])) then
    goto lEndResult;

  //�����¼�ڱ��ر���λ
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
  //�ڻ������ݱ�����GF_ID��GF_NO
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
  //�ӷ�������ȡ
  if GetCADInfoFromServer then
    goto lEndResult;

  //û�в��ҵ�
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
      0: result:='ӫ��';
      1: result:='����';
      2: result:='��ӫ';
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
      //ʹ��¼���ά����200��,�Ƚ��ȳ�.
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
  //���ݼ�δ����,��ֱ��ȡ��
  if (not Fcds_WebInfo.Active) or Fcds_WebInfo.IsEmpty then
    goto lGetWebInfo;

  //�����ǰ��¼ƥ��
  if (OrgGFKeyValue = Trim(Fcds_WebInfo['GF_ID'])) or (OrgGFKeyValue = Trim(Fcds_WebInfo['GF_NO'])) then
    goto lEndResult;

  //�����¼�ڱ��ر���λ
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
  //�ӷ�������ȡ
  if GetWebInfoFromServer then
    goto lEndResult;

  //û�в��ҵ�
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
  {* GFCADPicture������ʾ��}
  private
    FGFCADPIC: TGFCAD;
    FPanel: TPanel;
    FColorBox: TColorBox;
    FTimer: TTimer;
    FLabel:TLabel;//�����ǩ
    FMemo:TMemo;
    FLabelColor:TLabel; //������ʾɫ�ŵı�ǩ
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
    //�ٴ���һ��Panel ����������ǩ��ʾ��ɫ�ź�Remarks��ע��Ϣ��
    FPanel := TPanel.Create(Result);
    with FPanel do
    begin
      Name := 'FPane2';
      Parent := result;
      Align := alBottom; // ��ʾ�ڵײ�
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
      Caption:='ɫ�ţ�';
      Top:=5;
    end;}
    FLabelColor:=TLabel.Create(Result);
    with FLabelColor do
    begin
      Name:='FLabel3';
      Parent:=FPanel;
      left:=10;
      Caption:='ɫ�ţ�';
      top:=5;
    end;

    FLabel:=TLabel.Create(Result);
    with Flabel do
    begin
      Name:='FLabel2';
      Parent:= FPanel;
      Left:=10;
      Caption:='Remarks��';
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
  GFCADPictureForm.Caption:=Format('Ʒ��:%s; Ʒ��ID:%s', [Trim(CADInfo.GF_NO), Trim(CADInfo.GF_ID)]);
  GFCADPictureForm.FLabelColor.Caption:=Format('ɫ�ţ�%s',[CADInfo.Color_Code]);//ɫ���ö��������
  GFCADPictureForm.FMemo.Text:=Format('%s ֯��:%s ����:%s ����:%s',[trim(CADInfo.DY_Comments)+#13#10,trim(cadinfo.WV_Comments)+#13#10,trim(cadinfo.FN_Comments)+#13#10,trim(cadinfo.Comments)]);

  if not GFCADPictureForm.Showing then
    GFCADPictureForm.Show;
end;

procedure ShowCADPictureByAControl(Sender: TObject; AControl: TWinControl);
const
  KeyStrs = 'GF_ID,GF_NO,Ʒ��,Ʒ������';
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
      if not InputQuery('�鿴����', '������Ʒ����Ʒ��ID:', Result) then
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
              GridTableItem:=(DataController as TcxGridDBDataController).GetItemByFieldName('Ʒ��');
          end else
          if DataController.ClassName = 'TcxGridDataController' then
          begin
            with (AControl as TcxGridSite).GridView as TcxGridTableView do
            begin
              GridTableItem:=FindItemByName('GF_ID');
              if GridTableItem = nil then
                GridTableItem:=FindItemByName('GF_NO');
              if GridTableItem = nil then
                GridTableItem:=FindItemByName('Ʒ��');
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

