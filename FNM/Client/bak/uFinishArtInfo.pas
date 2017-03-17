{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 uFinishArtInfo.pas                                            }
{       创建日期 2004-8-23 上午 10:18:23                                       }
{       创建人员 lvzd, zhangjy                                                 }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述 后整理工艺基类,标准工艺类,实际工艺类,返工工艺类,CAD信息类,    }
{                 获取工艺相关字典函数.                                        }
{******************************************************************************}
unit uFinishArtInfo;

interface
uses
     DB, DBClient, Classes, SysUtils, StrUtils, Valedit, Grids, Menus, Windows, Forms,
     ServerDllPub, frmMsgDialog, UFinishStr, uGlobal;

const
  Max_Operate_Step_NO_Length=2;

Type
{TCADDtlInfo}
  TCADDtlInfo=Class
  Private
    FGF_ID: Integer;
    FGF_NO: String;
    FWebInfo: WideString;
    Fcds_CADInfo: TClientDataSet;

    procedure SetGF_ID(GF_IDValue: Integer);
    procedure SetGF_NO(GF_NOValue: String);
    function  GetCADInfo: TClientDataSet;                                       //取
    function  GetWebInfo: WideString;                                           //取图像信息

    procedure OpenCADInfo;
    procedure CloseCADInfo;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    Property WebInfo: WideString read GetWebInfo;                               //花型字符串
  published
    property GF_ID: Integer read FGF_ID write SetGF_ID;                         //品名代号
    property GF_NO: String read FGF_NO write SetGF_NO;                          //品名
    Property CADInfoSet: TClientDataSet read GetCADInfo;                        //Cad
  end;

  TOperateOffset=(MoveDown= -1, Delete = 0, MoveUP=1);
{TArtDtlInfo}
  TArtDtlInfo=Class
  Private
    FGF_ID: Integer;
    FGF_NO: String;

    Fcds_ArtHdr: TClientDataSet;
    Fcds_ArtDtl: TClientDataSet;
    
    FAfterEdit: TDataSetNotifyEvent;
    FBeforeSave: TNotifyEvent;
    FAfterSave: TNotifyEvent;
    FAfterOpen: TNotifyEvent;
    
    procedure SetGF_ID(GF_IDValue: Integer);
    procedure SetGF_NO(GF_NOValue: String);
    procedure SetActive(ActiveValue: Boolean);
    procedure SetAfterEdit(AfterEditEvent: TDataSetNotifyEvent);
    function  GetArtHdr: TClientDataSet;
    function  GetDataChange: Boolean;                                                         //判断工艺是否被修改
    function  GetActive: Boolean;                                                             //判断数据集合是否已打开

    procedure SetAOperateEditStep_NOValue(OldKeyValue, NewKeyValue: Integer);                 //根据Step_no设置EditStep_no的值.
    procedure MergeStep_NOValue;                                                              //使某两个字段的值相等
    function  GetAOperateDispText(Step_NO :Integer; OldText: String): String;                 //获取工序显示字符串
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    procedure OpenFNArt; virtual;                                                              //打开工艺
    procedure CloseFNArt;                                                                      //关闭工艺
    function  SaveArtToDataBase: Boolean; virtual;                                             //保存工艺
    function  SaveArtToLocal: Boolean;                                                         //保存工艺到本地
    function  IsEmpty: Boolean;                                                                //判断标准工艺主表是否为空
    procedure InitializeDepartmentMenuItem(MenuItem: TMenuItem; ClickEvent: TNotifyEvent);     //初使化工艺拷贝部门选择菜单
    function  AddAOperateStep(Operate_ID: Integer): Integer;                                   //追加一个工序步骤
    procedure MoveAOperateStep(Step_NO: Integer; OperateOffset: TOperateOffset);               //删除一个工序步骤或使某个工序的步骤加1减1
    procedure SetAOperateParameterValue(Step_NO :Integer; Item_Name, Item_Value: String);      //设置某个工序的某个参数的值
    procedure FillOperationToAListControls(AItem: TStrings);                                   //填充工序名到列表中
    procedure FillParameterToAListControls(Step_NO: Integer; AItem: TStrings);                 //填充参数到列表中
    procedure SetEditStyle(AValueListEditor: TValueListEditor);                                //设置工艺参数编辑器的编辑样式
    procedure GetPickListString(Const KeyName: String; Values: TStrings);                      //获取下拉列表的列表选项
  published
    property AfterEdit: TDataSetNotifyEvent read FAfterEdit write SetAfterEdit;
    property BeforeSave: TNotifyEvent read FBeforeSave write FBeforeSave;
    property AfterSave: TNotifyEvent read FAfterSave write FAfterSave;
    property AfterOpen: TNotifyEvent read FAfterOpen write FAfterOpen;

    property DataChange: Boolean read GetDataChange;                                           //工艺是否被修改
    property GF_ID: Integer read FGF_ID write SetGF_ID;                                        //品名代号
    property GF_NO: String read FGF_NO write SetGF_NO;                                         //品名
    property Active: Boolean read GetActive write SetActive;                                   //工艺是否打开
    Property ArtHdr: TClientDataSet read GetArtHdr;                                            //ArtHdr
  end;

{TSTDArtDtlInfo}
  TSTDArtDtlInfo=Class(TArtDtlInfo)
  Private
    FSTDArt_ID: Integer;
    FDepartment: String;

    function  CanOpenArt: Boolean;
    procedure SetDepartment(DepartmentValue: String);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    procedure OpenFNArt; override;                                                             //打开工艺
    function  SaveArtToDataBase: Boolean; override;                                            //保存工艺到数据库
    procedure CreateStdArt(Department, Creator: String);                                       //建立标准工艺
    procedure CopyAExistSTDArt(GF_ID: Integer; GF_NO: String; DepartmentTag: Integer);         //拷贝标准工艺
  published
    property AfterEdit;
    property BeforeSave;
    property AfterSave;
    property AfterOpen;

    property GF_ID;                                                                             //品名代号
    property GF_NO;                                                                             //品名
    property STDArt_ID: Integer read FSTDArt_ID;                                                //工艺编号
    property Department: String read FDepartment write SetDepartment;                           //标准工艺部门
  end;

{TFactArtDtlInfo}
  TFactArtDtlInfo=Class(TArtDtlInfo)
  Private
    FFACT_Art_ID: Integer;

    procedure SetFACT_Art_ID(FACT_Art_IDValue: Integer);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    procedure OpenFNArt; override;                                                             //打开工艺
    function  SaveArtToDataBase: Boolean; override;                                            //保存工艺到数据库
  published
    property AfterEdit;
    property BeforeSave;
    property AfterSave;
    property AfterOpen;

    property GF_ID;                                                                            //品名代号
    property GF_NO;                                                                            //品名
    property FACT_Art_ID: Integer read FFACT_Art_ID write SetFACT_Art_ID;                      //品名代号
  end;

{TRepairArtDtlInfo}
  TRepairArtDtlInfo=Class(TArtDtlInfo)
  Private
    FRepair_Art_ID: Integer;

    procedure SetRepair_Art_ID(Repair_Art_IDValue: Integer);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    procedure OpenFNArt; override;                                                             //打开工艺
    function  SaveArtToDataBase: Boolean; override;                                            //保存工艺到数据库
  published
    property AfterEdit;
    property BeforeSave;
    property AfterSave;
    property AfterOpen;

    property GF_ID;                                                                            //品名代号
    property GF_NO;                                                                            //品名
    property Repair_Art_ID: Integer read FRepair_Art_ID write SetRepair_Art_ID;                //品名代号
  end;

function Getcds_ColorList: TClientDataSet;                                                     //获取颜色字典表数据集
function Getcds_OperationList: TClientDataSet;                                                 //获取工序字典表数据集
function Getcds_DepartmentList: TClientDataSet;                                                //获取后整分部字典表数据集
function Getcds_ArtDescriptionList: TClientDataSet;                                            //获取后整工艺代号字典表数据集
procedure FillItemsFromDataSet(cds: TClientDataSet; FirstField, SecondField, KeyField, LinkSymbol: string; TheItems: TStrings);
implementation

var
  cds_ColorList: TClientDataSet;
  cds_OperationList: TClientDataSet;
  cds_DepartmentList: TClientDataSet;
  cds_ArtDescriptionList: TClientDataSet;

function Getcds_OperationList: TClientDataSet;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  //取工序字典
  result := nil;
  try
    if cds_OperationList = nil then
    begin
      FNMServerArtObj.GetOperationList(vData, sErrorMsg);
      if sErrorMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog('工序参数字典获取失败！'+sErrorMsg,2500);
        exit;
      end;
      
      cds_OperationList:=TClientDataSet.Create(nil);
      cds_OperationList.Data:=vData;
    end;

    result:= cds_OperationList
  except
    TMsgDialog.ShowMsgDialog('工序参数字典获取失败！',2500);
  end;
end;

function Getcds_DepartmentList: TClientDataSet;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  //取部门字典
  result := nil;
  try
    if cds_DepartmentList = nil then
    begin
      FNMServerArtObj.GetSubsectionList(vData, sErrorMsg);
      if sErrorMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog('后整理分厂字典获取失败！'+sErrorMsg,2500);
        exit;
      end;

      cds_DepartmentList:=TClientDataSet.Create(nil);
      cds_DepartmentList.Data:=vData;
    end;

    result:=cds_DepartmentList;
  except
    TMsgDialog.ShowMsgDialog('后整理分厂字典获取失败！',2500);
  end;
end;

function Getcds_ColorList: TClientDataSet;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  //取后整理颜色字典
  result := nil;
  try
    if cds_ColorList = nil then
    begin
      FNMServerArtObj.GetColorList(vData, sErrorMsg);
      if sErrorMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog('颜色字典获取失败！'+sErrorMsg,2500);
        exit;
      end;

      cds_ColorList:=TClientDataSet.Create(nil);
      cds_ColorList.Data:=vData;
    end;

    result:=cds_ColorList;
  except
    TMsgDialog.ShowMsgDialog('工序参数字典获取失败！',2500);
  end;
end;

function Getcds_ArtDescriptionList: TClientDataSet;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  //取后整理工艺代号字典
  result := nil;
  try
    if cds_ArtDescriptionList = nil then
    begin
      FNMServerArtObj.GetArtDescriptionList(vData, sErrorMsg);
      if sErrorMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog('颜色字典获取失败！'+sErrorMsg,2500);
        exit;
      end;

      cds_ArtDescriptionList:=TClientDataSet.Create(nil);
      cds_ArtDescriptionList.Data:=vData;
    end;

    result:=cds_ArtDescriptionList
  except
    TMsgDialog.ShowMsgDialog('工序参数字典获取失败！',2500);
  end;
end;

procedure FillItemsFromDataSet(cds: TClientDataSet; FirstField, SecondField, KeyField, LinkSymbol: string; TheItems: TStrings);
var
  ItemValue: String;
  i, KeyValue: Integer;
begin
//参数描述
//cds: 数据源
//FirstField, SecondField: 需要加入Items的字符型字段
//KeyField: 必须为整型字段,加入到Objects列表中.
  if (cds = nil) or (not cds.Active) then Exit;

  try
    TheItems.BeginUpdate;
    TheItems.Clear;
    cds.DisableControls;
    cds.First;
    for i := 0 to cds.RecordCount - 1 do
    begin
      ItemValue:=cds.FieldByName(FirstField).AsString;
      ItemValue:=ItemValue + StringOfChar(' ', cds.FieldByName(FirstField).DisplayWidth - Length(ItemValue));
      if SecondField <> '' then
        ItemValue:=ItemValue+LinkSymbol+cds.FieldByName(SecondField).AsString;

      if KeyField <> '' then
      begin
        KeyValue:=cds.FieldByName(KeyField).Asinteger;
        if TheItems.IndexOfObject(TObject(KeyValue)) = -1 then
          TheItems.AddObject(ItemValue, TObject(KeyValue));
      end
      else
        if TheItems.IndexOfName(ItemValue) = -1 then
          TheItems.Add(ItemValue);

      cds.Next;
    end;
  finally
    cds.EnableControls;
    TheItems.EndUpdate;
  end;
end;

{TCADDtlInfo}
constructor TCADDtlInfo.Create(AOwner: TComponent);
begin
  inherited Create;

  Fcds_CADInfo:=TClientDataSet.Create(AOwner);
  FWebInfo:='';
end;

destructor TCADDtlInfo.Destroy;
begin
  Fcds_CADInfo.Destroy;
end;

procedure TCADDtlInfo.SetGF_ID(GF_IDValue: Integer);
begin
  if FGF_ID = GF_IDValue then exit;

  CloseCADInfo;
  FGF_ID:=GF_IDValue;
end;

procedure TCADDtlInfo.SetGF_NO(GF_NOValue: String);
begin
  if FGF_NO = GF_NOValue then exit;

  CloseCADInfo;
  FGF_NO:=GF_NOValue;
end;

procedure TCADDtlInfo.OpenCADInfo;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  if Fcds_CADInfo.Active then exit;

  try
    FNMServerArtObj.GetCADInfo(FGF_ID, FGF_NO, vData, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,2500);
      exit;
    end;

    Fcds_CADInfo.Data:=vData;
  except
    TMsgDialog.ShowMsgDialog('取CAD信息数据出错,请联系程序员。',2500);
  end;
end;

procedure TCADDtlInfo.CloseCADInfo;
begin
  Fcds_CADInfo.Close;
  FWebInfo:='';
end;

function TCADDtlInfo.GetCADInfo: TClientDataSet;
begin
  if not Fcds_CADInfo.Active then OpenCADInfo;

  result := Fcds_CADInfo;
end;

function TCADDtlInfo.GetWebInfo: WideString;
var
  sErrorMsg: WideString;
begin
  result:='';
  if FWebInfo = '' then
  begin
    try
      FNMServerArtObj.GetWebInfo(FGF_ID, FGF_NO, FWebInfo, sErrorMsg);
      if sErrorMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog(sErrorMsg,2500);
        exit;
      end;
    except
      TMsgDialog.ShowMsgDialog('取CAD信息数据出错,请联系程序员。',2500);
    end;
  end;

  result:=FWebInfo
end;

{TArtDtlInfo}
constructor TArtDtlInfo.Create(AOwner: TComponent);
begin
  inherited Create;

  Fcds_ArtHdr:=TClientDataSet.Create(AOwner);
  Fcds_ArtDtl:=TClientDataSet.Create(AOwner);
  // Fcds_CADInfo:=TClientDataSet.Create(AOwner);
  // Fcds_CADInfo.ReadOnly:=True;
end;

destructor TArtDtlInfo.Destroy;
begin
  CloseFNArt;

  Fcds_ArtHdr.Destroy;
  Fcds_ArtDtl.Destroy;
  // Fcds_CADInfo.Destroy;
  inherited Destroy;
end;

procedure TArtDtlInfo.OpenFNArt;
begin

end;

function TArtDtlInfo.IsEmpty: Boolean;
begin
  result:=Fcds_ArtHdr.IsEmpty;
end;

function TArtDtlInfo.GetDataChange: Boolean;
begin
   result:=not (TGlobal.DeltaIsNull(Fcds_ArtHdr) and TGlobal.DeltaIsNull(Fcds_ArtDtl))
   // result:=TGlobal.DeltaIsNull(Fcds_ArtHdr) and TGlobal.DeltaIsNull(Fcds_ArtDtl)
end;

function TArtDtlInfo.GetActive: Boolean;
begin
  result:=Fcds_ArtHdr.Active and Fcds_ArtDtl.Active
end;

procedure TArtDtlInfo.CloseFNArt;
begin
  //判断用户是否保存了工艺，没有保存询问用户。
  if Active then
  begin
    if DataChange and
      (MessageBox(Application.Handle,Pchar(GetResourceString(@AskSaveDataStr)),Pchar(Application.Title), MB_YESNO) = IDYES) then
    begin
      if not SaveArtToDataBase then
      begin
        Raise Exception.Create(GetResourceString(@SaveDataFail));
      end;
    end
    else
    begin
      Fcds_ArtHdr.CancelUpdates;
      Fcds_ArtDtl.CancelUpdates;
    end;
  end;

  Fcds_ArtHdr.Close;
  Fcds_ArtDtl.Close;
end;

function TArtDtlInfo.SaveArtToDataBase: Boolean;
Begin
  result := True;
end;

function TArtDtlInfo.SaveArtToLocal: Boolean;
var
  FileName: String;
begin
  result := False;
  Fcds_ArtHdr.MergeChangeLog;//*.hdr
  Fcds_ArtDtl.MergeChangeLog;//*.dtl
//  Fcds_ArtHdr.SaveToFile(FileName, dfXML);
{$MESSAGE 'SaveArtToLocal:工作没完成'}
end;

procedure TArtDtlInfo.InitializeDepartmentMenuItem(MenuItem: TMenuItem; ClickEvent: TNotifyEvent);
var
  i: Integer;
  NewMenuItem: TMenuItem;
  Temp_cds: TClientDataSet;
begin
  Temp_cds:=Getcds_DepartmentList;
  if (Temp_cds = nil) or (not Temp_cds.Active) then
    exit;

  for i := 0 to Temp_cds.RecordCount - 1 do
  begin
    NewMenuItem:=TMenuItem.Create(MenuItem.Owner);
    NewMenuItem.Caption:=Trim(Temp_cds.FieldByName('Description').AsString)+'工艺(&'+
                         RightStr(Trim(Temp_cds.FieldByName('Department').AsString),1)+')';
    NewMenuItem.Tag:=Temp_cds.FieldByName('Iden').AsInteger;
    NewMenuItem.OnClick:=ClickEvent;
    MenuItem.Add(NewMenuItem);
    cds_DepartmentList.Next;
  end;
end;

procedure TArtDtlInfo.SetGF_ID(GF_IDValue: Integer);
begin
  CloseFNArt;
  FGF_ID:=GF_IDValue;
end;

procedure TArtDtlInfo.SetGF_NO(GF_NOValue: String);
begin
  CloseFNArt;
  FGF_NO:=GF_NOValue;
end;

procedure TArtDtlInfo.SetActive(ActiveValue: Boolean);
begin
  if ActiveValue then
    OpenFNArt
  else
    CloseFNArt;
end;

procedure TArtDtlInfo.SetAfterEdit(AfterEditEvent: TDataSetNotifyEvent);
begin
  Fcds_ArtHdr.AfterEdit:=AfterEditEvent;
  Fcds_ArtHdr.AfterInsert:=AfterEditEvent;

  Fcds_ArtDtl.AfterEdit:=AfterEditEvent;
  Fcds_ArtDtl.AfterInsert:=AfterEditEvent;
  // Fcds_ArtDtl.AfterDelete:=AfterEditEvent;
end;

procedure TArtDtlInfo.SetAOperateEditStep_NOValue(OldKeyValue, NewKeyValue: Integer);
var
  i: Integer;
begin
  try
    Fcds_ArtDtl.DisableControls;
    Fcds_ArtDtl.First;
    for i := 0 to Fcds_ArtDtl.RecordCount - 1 do
    begin
      Fcds_ArtDtl.Edit;
      if NewKeyValue = -1 then
      begin
        if Fcds_ArtDtl.FieldByName('Step_no').AsInteger > OldKeyValue then
          Fcds_ArtDtl.FieldByName('EditStep_no').AsInteger:=Fcds_ArtDtl.FieldByName('Step_no').AsInteger -1;
        if Fcds_ArtDtl.FieldByName('Step_no').AsInteger = OldKeyValue then
        begin
          Fcds_ArtDtl.Delete;
          Continue;
        end
      end
      else
      begin
        if Fcds_ArtDtl.FieldByName('Step_no').AsInteger = OldKeyValue then
          Fcds_ArtDtl.FieldByName('EditStep_no').AsInteger:=NewKeyValue;
      end;

      Fcds_ArtDtl.Next;
    end
  finally
    Fcds_ArtDtl.EnableControls
  end;
end;

function TArtDtlInfo.GetArtHdr: TClientDataSet;
begin
  if Active then
    result:=Fcds_ArtHdr
  else
    result := nil;
end;

procedure TArtDtlInfo.MergeStep_NOValue;
var
  i: Integer;
begin
  try
    Fcds_ArtDtl.DisableControls;
    Fcds_ArtDtl.First;
    for i := 0 to Fcds_ArtDtl.RecordCount - 1 do
    begin
      Fcds_ArtDtl.Edit;
      Fcds_ArtDtl.FieldByName('Step_no').AsInteger:=Fcds_ArtDtl.FieldByName('EditStep_no').AsInteger;
      Fcds_ArtDtl.Next;
    end;
  finally
    Fcds_ArtDtl.EnableControls
  end;
end;

function TArtDtlInfo.GetAOperateDispText(Step_NO :Integer; OldText: String): String;
begin
  result:=IntToStr(Step_NO);
  result:=result+StringOfChar(' ',Max_Operate_Step_NO_Length-Length(result))+')';
  result:=result+MidStr(OldText, Pos(')', OldText)+1, length(OldText));
end;

function TArtDtlInfo.AddAOperateStep(Operate_ID: Integer): Integer;
var
  i: Integer;
  Tmep_cds: TClientDataSet;
begin
  result := -1;
  Tmep_cds:=Getcds_OperationList;
  if (Tmep_cds = nil) or (not Tmep_cds.Active) then
    exit;
    
  try
    Fcds_ArtDtl.DisableControls;
    Fcds_ArtDtl.IndexFieldNames:='Step_NO';
    Fcds_ArtDtl.Last;
    result:=Fcds_ArtDtl.FieldByName('Step_no').AsInteger + 1;

    Tmep_cds.Filtered:=false;
    Tmep_cds.Filter:='Iden = '''+IntToStr(Operate_ID)+'''';
    Tmep_cds.Filtered:=true;
    if Tmep_cds.RecordCount = 0 then
      TMsgDialog.ShowMsgDialog('工序编号出错.请联系程序员。',2500);

    //追加具体参数.
    for i := 0 to Tmep_cds.RecordCount - 1 do
    begin
      Fcds_ArtDtl.AppendRecord([result, result,
          Tmep_cds.FieldByName('Operation_Code').AsString,
          Tmep_cds.FieldByName('Operation_CHN').AsString,
          Tmep_cds.FieldByName('Item_Name').AsString,
          nil,{Item_Value}
          Tmep_cds.FieldByName('Data_Unit').AsString,
          Tmep_cds.FieldByName('Data_Type').AsString
          ]);
      Tmep_cds.Next;
    end;
  finally
    Tmep_cds.Filtered:=false;
    Fcds_ArtDtl.IndexFieldNames:='';
    Fcds_ArtDtl.EnableControls;
  end;
end;

procedure TArtDtlInfo.MoveAOperateStep(Step_NO: Integer; OperateOffset: TOperateOffset);
begin
  case OperateOffset of
    MoveUP:
    begin
      SetAOperateEditStep_NOValue(Step_NO, Step_NO-1);
      SetAOperateEditStep_NOValue(Step_NO-1, Step_NO);
    end;
    MoveDown:
    begin
      SetAOperateEditStep_NOValue(Step_NO, Step_NO+1);
      SetAOperateEditStep_NOValue(Step_NO+1, Step_NO);
    end;
    Delete:
      SetAOperateEditStep_NOValue(Step_NO, -1);
  end;
  MergeStep_NOValue;
end;

procedure TArtDtlInfo.SetAOperateParameterValue(Step_NO :Integer; Item_Name, Item_Value: String);
begin
  try
    Fcds_ArtDtl.DisableControls;
    Fcds_ArtDtl.Filtered:=false;
    Fcds_ArtDtl.Filter:='Step_NO = '''+ IntToStr(Step_NO) + ''' and Item_Name = ''' + Item_Name +'''';
    Fcds_ArtDtl.Filtered:=true;
    Fcds_ArtDtl.First;
    if Fcds_ArtDtl.RecordCount = 1 then
    begin
      Fcds_ArtDtl.Edit;
      Fcds_ArtDtl.FieldByName('Item_Value').AsString:=Item_Value;
    end
  finally
    Fcds_ArtDtl.Filtered:=false;
    Fcds_ArtDtl.EnableControls;
  end;
end;

procedure TArtDtlInfo.FillOperationToAListControls(AItem: TStrings);
var
  ItemValue: String;
  i, KeyValue: Integer;
begin
  if not Active then
    exit;

  try
    AItem.BeginUpdate;
    AItem.Clear;
    Fcds_ArtDtl.DisableControls;
    Fcds_ArtDtl.First;
    Fcds_ArtDtl.IndexFieldNames:='Step_NO';
    for i := 0 to Fcds_ArtDtl.RecordCount - 1 do
    begin
      KeyValue:=Fcds_ArtDtl.FieldByName('Step_NO').Asinteger;
      ItemValue:=GetAOperateDispText(KeyValue, Fcds_ArtDtl.FieldByName('Operation_CHN').AsString);
      if AItem.IndexOfObject(TObject(KeyValue)) = -1 then
        AItem.AddObject(ItemValue, TObject(KeyValue));

      Fcds_ArtDtl.Next;
    end;
  finally
    Fcds_ArtDtl.IndexFieldNames:='';
    Fcds_ArtDtl.EnableControls;
    AItem.EndUpdate;
  end;
end;

procedure TArtDtlInfo.FillParameterToAListControls(Step_NO: Integer; AItem: TStrings);
begin
  try
    Fcds_ArtDtl.DisableControls;
    Fcds_ArtDtl.Filtered:=false;
    Fcds_ArtDtl.Filter:='Step_NO = '''+ IntToStr(Step_NO)+'''';
    Fcds_ArtDtl.Filtered:=true;
    Fcds_ArtDtl.First;
    FillItemsFromDataSet(Fcds_ArtDtl, 'Item_Name', 'Item_Value', '' , '=', AItem)
  finally
    Fcds_ArtDtl.Filtered:=false;
    Fcds_ArtDtl.EnableControls;
  end;
end;

procedure TArtDtlInfo.SetEditStyle(AValueListEditor: TValueListEditor);
var
  i: Integer;
begin
  for i := 0 to AValueListEditor.RowCount - 1 do
  begin
    if Trim(AValueListEditor.Cells[0,i]) = '车速' then
      AValueListEditor.ItemProps[i-1].EditStyle:=esPickList;
//    if Trim(AValueListEditor.Cells[0,i]) = '车速' then
//      AValueListEditor.ItemProps[i-1].EditStyle:=esPickList;
  end;
end;

procedure TArtDtlInfo.GetPickListString(Const KeyName: String; Values: TStrings);
begin
  if Trim(KeyName) = '车速' then
  begin
    Values.Add('90');
    Values.Add('80');
    Values.Add('70');
  end
end;

{TSTDArtDtlInfo}
function TSTDArtDtlInfo.CanOpenArt: Boolean;
begin
  result:=(FDepartment <> '') and ((FGF_ID <> 0) or (FGF_NO <> ''))
end;

procedure TSTDArtDtlInfo.SetDepartment(DepartmentValue: String);
begin
  CloseFNArt;
  FDepartment:=DepartmentValue;
end;

constructor TSTDArtDtlInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FGF_ID:=0;
  FGF_NO:='';
  FSTDArt_ID:=-1;
end;

destructor TSTDArtDtlInfo.Destroy;
begin
  inherited Destroy;
end;

procedure TSTDArtDtlInfo.OpenFNArt;
var
  sErrorMsg: WideString;
  vDataHdr, vDataDtl, vDataTemp: OleVariant;
begin
  CloseFNArt;
  try
    if not CanOpenArt then
    begin
      TMsgDialog.ShowMsgDialog('取后整理工艺信息,缺少部门信息。'+#13+sErrorMsg,2500);
      exit;
    end;

    FNMServerArtObj.GetStdArtDtl(FGF_ID, FGF_NO, Department, vDataHdr, vDataDtl, vDataTemp, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog('取后整理工艺信息出错,请联系程序员。'+#13+sErrorMsg,2500);
      exit;
    end;
    Fcds_ArtHdr.Data:=vDataHdr;
    Fcds_ArtDtl.Data:=vDataDtl;

    if not Fcds_ArtHdr.IsEmpty then
    begin
      FGF_ID:=Fcds_ArtHdr.FieldByName('GF_ID').AsInteger;
      FGF_NO:=Fcds_ArtHdr.FieldByName('GF_NO').AsString;
    end;
    
    if Assigned(FAfterOpen) then FAfterOpen(Self);
  except
    TMsgDialog.ShowMsgDialog('标准工艺获取出错,请联系程序员。',2500);
  end;
end;

function TSTDArtDtlInfo.SaveArtToDataBase: Boolean;
var
  iSTD_Art_ID: Integer;
  sErrorMsg: WideString;
begin
  result := True;
  if (not Active) or (not DataChange) then exit;
  if Assigned(FBeforeSave) then FBeforeSave(Self);

  result:= False;
  Fcds_ArtHdr.MergeChangeLog;
  Fcds_ArtDtl.MergeChangeLog;
  FNMServerArtObj.SaveStdArtHdrData(Fcds_ArtHdr.Data, iSTD_Art_ID, sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(GetResourceString(@SaveArtHdrDataError)+sErrorMsg,2500);
    exit;
  end;

  FNMServerArtObj.SaveStdArtDtlData(Fcds_ArtDtl.Data, iSTD_Art_ID, sErrorMsg);
  if sErrorMsg <> '' then
  begin
    MessageBox(Application.Handle, Pchar(GetResourceString(@SaveArtDtlDataError)), Pchar(Application.Title), MB_OK);

    TMsgDialog.ShowMsgDialog(GetResourceString(@SaveArtDtlDataError)+sErrorMsg,2500);
    exit;
  end;

  TMsgDialog.ShowMsgDialog(GetResourceString(@SaveDataSuccess),2500);
  result := True;
  
  if Assigned(FAfterSave) then FAfterSave(Self);
end;

procedure TSTDArtDtlInfo.CreateStdArt(Department, Creator: String);
begin
  if not Fcds_ArtHdr.IsEmpty then  exit;
  if FGF_ID = 0 then
    TMsgDialog.ShowMsgDialog(GetResourceString(@InvalidGF_NO),2500);

  Fcds_ArtHdr.AppendRecord([nil, FGF_ID, FGF_NO, nil, nil, -1, Department, Creator, Now(), nil, nil, '', true]);
end;

procedure TSTDArtDtlInfo.CopyAExistSTDArt(GF_ID: Integer; GF_NO: String; DepartmentTag: Integer);
var
  Department: String;
begin
  //工艺没打开不能拷贝或参数数据不为空不能拷贝
  if (not Active) or (not Fcds_ArtDtl.IsEmpty)then
    exit;

  //取拷贝工艺对象的所属部门
  if cds_DepartmentList.Locate('Iden', DepartmentTag, []) then
    Department:=cds_DepartmentList.FieldByName('Department').AsString;

  //开始拷贝
{$MESSAGE 'CopyAExistSTDArt:工作没完成'}
end;

{TFactArtDtlInfo}
procedure TFactArtDtlInfo.SetFACT_Art_ID(FACT_Art_IDValue: Integer);
begin
  if FFACT_Art_ID = FACT_Art_IDValue then exit;
    
  CloseFNArt;
  FFACT_Art_ID:=FACT_Art_IDValue;
end;

constructor TFactArtDtlInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FGF_ID:=0;
  FGF_NO:='';
end;

destructor TFactArtDtlInfo.Destroy;
begin
  inherited Destroy;
end;

procedure TFactArtDtlInfo.OpenFNArt;
var
  sErrorMsg: WideString;
  vDataHdr, vDataDtl, vDataTemp: OleVariant;
begin
  CloseFNArt;
  try
    if FFACT_Art_ID = 0 then
    begin
      TMsgDialog.ShowMsgDialog('实际工艺编号为空'+#13+sErrorMsg,2500);
      exit;
    end;

    FNMServerArtObj.GetFactArtDtl(FFACT_Art_ID, vDataHdr, vDataDtl, vDataTemp, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog('取后整理工艺信息出错,请联系程序员。'+#13+sErrorMsg,2500);
      exit;
    end;
    Fcds_ArtHdr.Data:=vDataHdr;
    Fcds_ArtDtl.Data:=vDataDtl;

    if not Fcds_ArtHdr.IsEmpty then
    begin
      FGF_ID:=Fcds_ArtHdr.FieldByName('GF_ID').AsInteger;
      FGF_NO:=Fcds_ArtHdr.FieldByName('GF_NO').AsString;
    end;
    if Assigned(FAfterOpen) then FAfterOpen(Self);
  except
    TMsgDialog.ShowMsgDialog('实际工艺获取出错,请联系程序员。',2500);
  end;
end;

function TFactArtDtlInfo.SaveArtToDataBase: Boolean;
begin
  //
end;

{TRepairArtDtlInfo}
procedure TRepairArtDtlInfo.SetRepair_Art_ID(Repair_Art_IDValue: Integer);
begin
  if FRepair_Art_ID = Repair_Art_IDValue then exit;

  CloseFNArt;
  FRepair_Art_ID:= Repair_Art_IDValue;
end;

constructor TRepairArtDtlInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FGF_ID:=0;
  FGF_NO:='';
end;

destructor TRepairArtDtlInfo.Destroy;
begin
  inherited Destroy;
end;

procedure TRepairArtDtlInfo.OpenFNArt;
var
  sErrorMsg: WideString;
  vDataHdr, vDataDtl, vDataTemp: OleVariant;
begin
  CloseFNArt;
  try
    if FRepair_Art_ID = -1 then
    begin
      TMsgDialog.ShowMsgDialog('实际工艺编号为空'+#13+sErrorMsg,2500);
      exit;
    end;

    FNMServerArtObj.GetFactArtDtl(FRepair_Art_ID, vDataHdr, vDataDtl, vDataTemp, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog('取后整理工艺信息出错,请联系程序员。'+#13+sErrorMsg,2500);
      exit;
    end;
    Fcds_ArtHdr.Data:=vDataHdr;
    Fcds_ArtDtl.Data:=vDataDtl;

    if not Fcds_ArtHdr.IsEmpty then
    begin
      FGF_ID:=Fcds_ArtHdr.FieldByName('GF_ID').AsInteger;
      FGF_NO:=Fcds_ArtHdr.FieldByName('GF_NO').AsString;
    end;
    if Assigned(FAfterOpen) then FAfterOpen(Self);
  except
    TMsgDialog.ShowMsgDialog('实际工艺获取出错,请联系程序员。',2500);
  end;
end;

function  TRepairArtDtlInfo.SaveArtToDataBase: Boolean;
begin
  //
end;

initialization
  cds_OperationList:= nil;
  cds_DepartmentList:= nil;
  cds_ColorList:= nil;
  cds_ArtDescriptionList:= nil;

finalization
  if cds_OperationList <> nil then
    cds_OperationList.Destroy;

  if cds_DepartmentList <> nil then
    cds_DepartmentList.Destroy;

  if cds_ColorList <> nil then
    cds_ColorList.Destroy;

  if cds_ArtDescriptionList <> nil then
    cds_ArtDescriptionList.Destroy

end.
