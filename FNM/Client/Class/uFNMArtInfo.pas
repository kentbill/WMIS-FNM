unit uFNMArtInfo;
{*|<PRE>*****************************************************************************

       软件名称 FNM CLIENT MODEL
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT
       单元名称 uFNMArtInfo.pas
       创建日期 2004-8-30 下午 04:30:20
       创建人员 lvzd
       修改人员
       修改日期
       修改原因
       对应用例
       字段描述
       相关数据库表
       调用重要函数/SQL对象说明
        1: 后整理工艺基类
        2: 标准工艺类
        读:    PDMDB.dbo.tdGFID; uvw_fnOperationList
        读,写: fnStdArtHdr; fnStdArtDtl
        3: 实际工艺类
        读:
        4: 回修工艺类
        读:
        5: 手织版工艺类

       功能描述: CAD工艺类,后整理工艺基类, 标准工艺, 实际工艺, 外回修工艺类,
       获取工艺相关字典函数.

******************************************************************************}

interface

{$I Terminal.inc}

uses
     DB, DBClient, Classes, SysUtils, StrUtils, Valedit, Grids, Menus, Windows, Forms,
     ComCtrls, ServerDllPub, uFNMResource, uGlobal, uShowMessage, uDictionary, Dialogs,
     Variants, StdCtrls, Controls, uLogin, uCADInfo;

Type

{TOperateOffset}
  TOperateOffset=(ooMoveDown= -1, ooDelete = 0, ooMoveUP=1);
  {* 单道工序移动:MoveDown:下移; Delete: 删除; MoveUP: 上移}
{TArtDtlInfo}
  TArtDtlInfo=Class
  {* 标准工艺,实际工艺,回修工艺的基类}
  Private
    Fcds_ArtHdr: TClientDataSet;
    {* 工艺主表数据集合}
    Fcds_ArtDtl: TClientDataSet;
    {* 工艺明细表数据集合}

    Org_Fcds_ArtDtl: TClientDataSet;
    {* 修改前工艺明细表数据集合}

    FModify: Boolean;
    {* 工艺是否被修改}

    FOnAfterEdit: TNotifyEvent;
    {* 工艺编辑事件}
    FOnBeforeSave: TNotifyEvent;
    {* 工艺开始保存事件}
    FOnAfterSave: TNotifyEvent;
    {* 工艺保存完毕事件}
    FOnAfterOpen: TNotifyEvent;
    {* 工艺打开事件}
    FOnAfterClose: TNotifyEvent;
    {* 工艺关闭事件}

    procedure SetModify(ModifyValue: Boolean);
    {* 标识工艺否被修改}
    function  GetActive: Boolean;
    {* 判断数据集合是否已打开}
    procedure MergeStepNOValue;
    {* 使某Step_no和EditStep_no两个字段的值相等, 在MoveAOperateStep过程中调用}
    procedure SetAOperateEditStep_NOValue(OldKeyValue, NewKeyValue: Integer);
    {* 根据Step_no设置EditStep_no的值, 在MoveAOperateStep过程中调用}
    procedure FillParameterListControls(FillModle: String; AValueListEditor: TValueListEditor);
    {* 填充参数到列表中}
  protected
    function  GetFieldValue(Index: integer): Variant;
    {* 获取主表Index字段的值}
    procedure SetFieldValue(Index: integer; FieldValue: Variant);
    {* 设置主表某各字段的值}
    function RepairItemValue(OperationCode, ItemName, ItemValue: String): string; virtual;
    {* 修正用户输入的参数值}
    procedure TestItemValue(OperationCode, ItemName, ItemValue: String); virtual;
    {* 测试参数值是否合法}
  public
    constructor Create(AOwner: TComponent);
    {* Create}
    destructor Destroy; override;
    {* Destroy}

    function CloseArt: Boolean;
    {* 关闭工艺}
    function  SaveArtToDataBase: Boolean; virtual;
    {* 保存工艺到数据库中}
    function  IsEmpty: Boolean;
    {* 判断标准工艺主表是否为空}
    function GetStepOperateCode(Step_NO: Integer): String;
    {* 根据工序步骤取工序的Code}
    function GetStepOperateName(Step_NO: Integer): String;
    {* 根据工序步骤取工序的Name}
    function  AddAOperateStep(Operate_ID: Integer; Operation_Code: string = ''): Integer;
    {* 追加一个工序步骤}
    procedure MoveAOperateStep(Step_NO: Integer; OperateOffset: TOperateOffset);
    {* 删除一个工序步骤或使某个工序的步骤加1减1}
    procedure ClearAllOperateStep;
    {* 清除所有工序}
    function SetAOperateParameterValue(Step_NO :Integer; Item_Name, Item_Value: String): String; virtual;
    {* 设置某道工序的某个参数的值}
    procedure FillOperationToAListControls(AItem: TStrings);
    {* 填充工序名到列表中}
    procedure FillAStepToAListControls(Step_NO: Integer; AValueListEditor: TValueListEditor);
    {* 填充指定工序参数到列表中}
    procedure FillAItemToAListControls(ItemName: String; AValueListEditor: TValueListEditor);
    {* 填充所有工序的指定参数到列表中}
    function  GetOperateStepCount: Integer;
    {* 获取当前工序的步骤数}
    function  GetOperations: String;
    {* 获取当前工序步骤代号列表(逗号分割)}
    procedure ViewArtDtlInNewForm;
    {* 在新窗口中查看工艺}
  published
    property Modify: Boolean read FModify write SetModify;
    {* 工艺是否被修改}
    property Active: Boolean read GetActive;
    {* 工艺是否打开}

    property OnAfterEdit:  TNotifyEvent read FOnAfterEdit  write FOnAfterEdit;
    {* 工艺被编辑}
    property OnBeforeSave: TNotifyEvent read FOnBeforeSave write FOnBeforeSave;
    {* 工艺开始保存}
    property OnAfterSave:  TNotifyEvent read FOnAfterSave  write FOnAfterSave;
    {* 工艺保存成功}
    property OnAfterOpen:  TNotifyEvent read FOnAfterOpen  write FOnAfterOpen;
    {* 工艺打开成功}
    property OnAfterClose: TNotifyEvent read FOnAfterClose write FOnAfterClose;
    {* 工艺关闭成功}
  end;

{TSTDArtDtlInfo}
  TSTDArtDtlInfo=Class(TArtDtlInfo)
  {* 标准工艺类}
  Private
    FOrgArt_ID: Integer;
    {* 标准工艺编号, 该变量仅仅用于打开工艺}
    FOrgDepartment: String;
    {* 标准工艺所属部门, 该变量仅仅用于打开工艺}
    procedure SetOrgArt_ID(OrgArt_IDValue: Integer);
    {* 设置工艺ID}
    procedure SetOrgDepartment(OrgDepartmentValue: String);
    {* 设置标注工艺部门}
  public

    constructor Create(AOwner: TComponent);
    {* 构造标准工艺类}
    destructor Destroy; override;
    {* 释放标准工艺类}

    procedure OpenFNSTDArt;
    {* 通过GF_ID或GF_NO打开工艺}
    procedure CheckStdArt(iType:Integer);
    {* 确认标准工艺}
    function  SaveArtToDataBase: Boolean; override;
    procedure SaveFeedbackInfo;
    {* 保存工艺到数据库}
    procedure CreateStdArt(OrgGF_ID: Integer; Department, Creator: String);
    {* 建立标准工艺}
    procedure CopyAExistSTDArt(StdArtID: Integer);
    {* 拷贝标准工艺}
    procedure InitializeDepartmentMenuItem(MenuItem: TMenuItem; ClickEvent: TNotifyEvent);
    {* 初使化工艺拷贝部门选择菜单}
    function GetFeedbackInfo: OleVariant;

    function ViewArtDtl(Index: integer): string;
  published
    property OrgArt_ID: Integer read FOrgArt_ID write SetOrgArt_ID;
    {* 工艺编号}
    property OrgDepartment: String read FOrgDepartment write SetOrgDepartment;
    {* 标准工艺部门}
    property Art_ID             :Variant index 1  read GetFieldValue;
    {* 工艺编号}
    property GF_ID              :Variant index 2  read GetFieldValue;
    property GF_NO              :Variant index 3  read GetFieldValue;
    property FN_Art_NO          :Variant index 4  read GetFieldValue write SetFieldValue;     
    {* 后整理工艺代号}
    property FN_Color_Code      :Variant index 5  read GetFieldValue write SetFieldValue;
    {* 后整理颜色代号}
    property Shrinkage          :Variant index 6  read GetFieldValue write SetFieldValue;
    {* 后整理缩水要求}
    property HandFeel           :Variant index 7  read GetFieldValue write SetFieldValue;
    {* 后整理手感要求}
    property Product_Width       :Variant index 8  read GetFieldValue write SetFieldValue;
    {* 后整理门幅}
    property Material_Quality   :Variant index 9 read GetFieldValue;
    {* 当前工艺的适用类型}
    property Version            :Variant index 10 read GetFieldValue;
    {* 工艺版本}
    property Current_Department :Variant index 11 read GetFieldValue;
    {* 工艺建立的部门}
    property Operator           :Variant index 12 read GetFieldValue write SetFieldValue;
    {* 工艺建立人}
    property Operate_Time       :Variant index 13 read GetFieldValue;
    {* 工艺建立时间}
    property Checker            :Variant index 14 read GetFieldValue;
    {* 工艺确认人}
    property Check_Time         :Variant index 15 read GetFieldValue;
    {* 工艺确认时间}
    property Remark             :Variant index 16 read GetFieldValue write SetFieldValue;
    {* 工艺备注}
    property Is_Active          :Variant index 17 read GetFieldValue write SetFieldValue;
    {* 工艺是否有效}
    property Feedback           :Variant index 18 read GetFieldValue;

    property Feedback_Time      :Variant index 19 read GetFieldValue;

    property PDARemark          :Variant index 20 read GetFieldValue write SetFieldValue;

    property PDMRemark          :Variant index 21 read GetFieldValue write SetFieldValue;

  end;

{TFactArtDtlInfo}
  TFactArtDtlInfo=Class(TArtDtlInfo)
  {* 实际工艺类}
  Private
    Fcds_JobTraceDtl: TClientDataSet;
    {* 进度跟踪明细数据集合}
    FFACT_Art_ID: Integer;
    {* 实际工艺编号}
    FCardList: string;
    {* 使用当前实际工艺的卡号列表, 逗号分割}
    FInternal_Repair: Boolean;
    {内回修}
    FAsSTDArt: Boolean;
    {是否做为此品种的标准工艺}
    FRepairReason: string;

    procedure SetFACT_Art_ID(FACT_Art_IDValue: Integer);
    {* 设置实际工艺编号}
    function GetRepairSteps: String;
    {* 取新添加的工序列表}
  public
    constructor Create(AOwner: TComponent);
    {* Create}
    destructor Destroy; override;
    {* Destroy}


    procedure OpenFNArt;
    {* 打开实际工艺}
    function GetJobTraceDtlInfo(SelectCardList: String; SelectStepNO: Integer): Boolean;
    {* 取进度跟踪明细数}
    procedure UpdateAStepNO(OldStepNO: Integer; OperateOffset: TOperateOffset);
    {* 更新进度跟踪明细记录}
    function  SaveArtToDataBase: Boolean; override;
    {* 保存实际工艺到数据库}
  published
    property FACT_Art_ID: Integer read FFACT_Art_ID write SetFACT_Art_ID;
    {* 实际工艺代号}
    property CardList: String read FCardList write FCardList;
    {* 使用当前实际工艺的卡号列表}
    property RepairSteps: String read GetRepairSteps;
    {* 当前工艺的回修步骤}
    property Internal_Repair: Boolean read FInternal_Repair write FInternal_Repair;
    {* }
    property AsSTDArt: Boolean read FAsSTDArt write FAsSTDArt;
    {* }
    property RepairReason: String read FRepairReason write FRepairReason;
    {* }

    property Art_ID             :Variant index 1  read GetFieldValue;
    {* 实际工艺ID}
    property Fact_Art_Version   :Variant index 2  read GetFieldValue;
    {* 实际工艺版本}
    property GF_ID              :Variant index 3  read GetFieldValue;
    property GF_NO              :Variant index 4  read GetFieldValue;
    property FN_Art_NO          :Variant index 5  read GetFieldValue write SetFieldValue;
    {* 后整理工艺代号}
    property STD_Art_ID         :Variant index 6  read GetFieldValue;
    {* 当前工艺的根工艺的标准工艺}
    property STD_Art_Version    :Variant index 7  read GetFieldValue;
    {* 当前工艺的根工艺的标准工艺的版本}
    property FN_Color_Code      :Variant index 8  read GetFieldValue write SetFieldValue;
    {* 当前工艺的颜色代号}
    property Shrinkage          :Variant index 9  read GetFieldValue write SetFieldValue;
    {* 后整理缩水要求}
    property HandFeel           :Variant index 10  read GetFieldValue write SetFieldValue;
    {* 后整理手感要求}
    property Product_Width       :Variant index 11  read GetFieldValue write SetFieldValue;
    {* 后整理门幅}
    property Art_Type           :Variant index 12  read GetFieldValue;
    {* 当前工艺的类型}
    property Material_Quality   :Variant index 13 read GetFieldValue;
    {* 当前工艺的适用类型}
    property Operator           :Variant index 14 read GetFieldValue write SetFieldValue;
    {* 当前工艺的建立人}
    property Operate_Time       :Variant index 15 read GetFieldValue;
    {* 当前工艺的建立时间}
    property Remark             :Variant index 16 read GetFieldValue write SetFieldValue;
    {* 工艺备注}
    property fact_art_dtl: TClientDataSet read Fcds_ArtDtl;
    {* 实际工艺}
    property Org_fact_art_dtl: TClientDataSet read Org_Fcds_ArtDtl;
    {* 修改前实际工艺}
  end;

{TRepairArtDtlInfo}
  TRepairArtDtlInfo=Class(TArtDtlInfo)
  {* 回修工艺类}
  Private
    FCardList: string;
    {* 使用当前实际工艺的卡号列表, 逗号分割}
  public
    procedure SaveRepairArt(var vData: OleVariant; vDataHdr,
  vDataDtl: OleVariant; var sErrorMsg: WideString);
    procedure CreateRepairArt(RepairIden, GF_ID: Integer; SelectCard: string; CurrentDeparment, Operator: String);
    {* 建立回修工艺}
    function SaveArtToDataBase(IsQualityOperator:Boolean;RepairIden :Integer;GF_ID:Integer; Quantity:Double ;Repair_Code,Current_Department,Operator :string) : Boolean;
    {* 保存回修工艺到数据库}
  published
    property CardList: String read FCardList write FCardList;
    {* 使用当前实际工艺的卡号列表}
    property Art_ID              :Variant index 1  read GetFieldValue;
    {* 实际工艺ID}
    property GF_ID               :Variant index 2  read GetFieldValue;
    {* 工艺的品名代号}
    property FN_Art_NO           :Variant index 3  read GetFieldValue write SetFieldValue;
    {* 后整理工艺代号}
    property FN_Color_Code       :Variant index 4  read GetFieldValue write SetFieldValue;
    {* 当前工艺的颜色代号}
    property Shrinkage           :Variant index 5  read GetFieldValue write SetFieldValue;
    {* 后整理缩水要求}
    property HandFeel            :Variant index 6  read GetFieldValue write SetFieldValue;
    {* 后整理手感要求}
    property Product_Width        :Variant index 7  read GetFieldValue write SetFieldValue;
    {* 后整理门幅}
    property Art_Type            :Variant index 8  read GetFieldValue;
    {* 当前工艺的类型,返工还是正常工艺}
    property Material_Quality    :Variant index 9  read GetFieldValue;
    {* 当前工艺的适用类型,是正常布工艺还是处理布工艺}
    property Operator            :Variant index 10  read GetFieldValue write SetFieldValue;
    {* 当前工艺的建立人}
    property Operate_Time        :Variant index 11  read GetFieldValue;
    {* 当前工艺的建立时间}
    property Remark              :Variant index 12 read GetFieldValue write SetFieldValue;
    {* 工艺备注}
    property Reason_Type         :Variant index 13 read GetFieldValue write SetFieldValue;
    {* 回修类型}
    property Reason_Info         :Variant index 14 read GetFieldValue write SetFieldValue;
    {* 回修原因}

  end;

{THLArtDtlInfo}
  THLArtDtlInfo=Class(TArtDtlInfo)
  {* HL工艺类}
  public
    procedure CreateHLArt(FN_ID, FN_NO, Creator: String);
    {* 建立HL工艺}
    function  SaveArtToDataBase: Boolean; override;
    {* 保存HL工艺到数据库}
  published
    property FN_ID               :Variant index 1  read GetFieldValue;
    {* HL工艺ID}
    property FN_NO               :Variant index 2  read GetFieldValue;
    {* HL工艺ID}
    property Art_ID              :Variant index 3  read GetFieldValue;
    {* HL工艺ID}
    property FN_Art_NO           :Variant index 4  read GetFieldValue write SetFieldValue;
    {* 后整工艺代号}
    property Art_Type            :Variant index 5  read GetFieldValue;
    {* 当前工艺的类型,返工还是正常工艺}
    property Material_Quality    :Variant index 6  read GetFieldValue;
    {* 当前工艺的适用类型}
    property Operator            :Variant index 7  read GetFieldValue write SetFieldValue;
    {* 当前工艺的建立人}
    property Operate_Time        :Variant index 8  read GetFieldValue;
    {* 当前工艺的建立时间}
    property Remark              :Variant index 9  read GetFieldValue write SetFieldValue;
    {* 工艺备注}
  end;

procedure GetStdArtIDbyGFNO(GF_KeyValue, Department: String; var Art_ID, GF_ID: Integer);
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-12-24 14:40:38
   参数列表: GF_KeyValue, Department: String; var Art_ID, GF_ID: Integer
   功能描述: 通过品名或品名ID取出Art_ID和GF_ID
   引用计数:
-------------------------------------------------------------------------------}
procedure GetOnLineCardByGFKeyValue(GFKeyValue, Department: String; CDS: TClientDataSet);
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-8-30 下午 05:57:45
   参数列表:
   功能描述: 取指定品名某部门的在线卡号
   引用计数:
-------------------------------------------------------------------------------}
procedure GetOnLineCardByOperation(Operation_Code: String; Department: String; CDS: TClientDataSet);
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-8-30 下午 05:57:45
   参数列表:
   功能描述: 取指定工序某部门的在线卡号
   引用计数:
-------------------------------------------------------------------------------}
procedure FillItemsFromDataSet(cds: TDataSet; FirstField, SecondField, KeyField, LinkSymbol: string; TheItems: TStrings;
          InsertAll: Boolean=false; TrimSpace: Boolean = true; ClearMode: Boolean = true);
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-8-30 下午 05:45:09
   参数列表: cds: 数据集; FirstField: 第一字段; SecondField: 第二字段; KeyField: 关键字字段,该字段必须为整型字段
             LinkSymbol: 第一字段和第二字段之间的连接符号; TheItems: 添加的目标字符串列表;
             InsertAll: 是否插入所有的记录,为True是则插入所有记录,默认为Fase,相同的记录不插入.
   功能描述: 填充数据集合到指定的Items中
-------------------------------------------------------------------------------}
procedure FillTreeItemsFromDataSet(cds: TClientDataSet; DisplayField,
          ParentField, SubField, KeyField, RootValue: string; TheNodes: TTreeNodes; RootNode: TTreeNode = nil);
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-8-30 下午 05:41:54
   参数列表: cds: 数据集; DisplayField: 显示字段; ParentField: 父字段; SubField: 子字段;
             KeyField: 关键字字段,该字段必须为整型字段; RootValue: 作为根节点的字段值标志;
             TheNodes: 添加的目标TreeNodes;
     表结构: DisplayField | ParentField | SubField |KeyField
   功能描述: 填充数据集合到指定的TreeItems中
-------------------------------------------------------------------------------}
procedure FillTreeItemsFromDataSetByClassField(cds: TClientDataSet;
          ValueField, ClassField, KeyField, DescriptionField: string; TheNodes: TTreeNodes);
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-10-20 12:18:28
   参数列表: cds: 数据集; ValueField: 值字段; ClassField: 分类字段; KeyField: 关键字字段; TheNodes: 添加的目标TreeNodes;
   功能描述: 按ClassField,将keyField填充到TreeNodes中
-------------------------------------------------------------------------------}
procedure FillListItemsFromDataSet(cds: TDataSet; FirstField, KeyField: string;
          FieldStrings: array of String; TheItems: TListItems);
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-9-1 9:32:44
   参数列表: cds: 数据集; FirstField: ListItem的Caption, 且不能为空;
   KeyField: 关键字字段,该字段必须为整型字段, 如果需要访问该该值, FieldStrings参数必须传入一个字段名
   FieldStrings: 需要加入到SubItems中的字段数组;
   TheItems: 不言自明;
   返回值  : 无
   功能描述: 填充数据集合到指定的TListItems中
-------------------------------------------------------------------------------}
procedure AddItemToListItems(KeyValue: String; ItemStrings: array of String; TheItems: TListItems);
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-11-20 14:37:21
   参数列表: KeyValue: String; ItemStrings: array of String; TheItems: TListItems
   功能描述: 向ListItem中添加Item,有重复的KeyValue不添加
   引用计数:
-------------------------------------------------------------------------------}
procedure FillFN_Art_NOListToAComboBox(Code_Class: String; AComboBox: TComboBox);
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-12-14 14:28:13
   参数列表: Code_Class: String; AComboBox: TComboBox
   功能描述: 填充FN_Art_NO字典到ComboBox中
   引用计数:
-------------------------------------------------------------------------------}
procedure FillArt_NOListToAComboBox(ArtType: String; AComboBox: TComboBox);
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-12-22 10:55:39
   参数列表: ArtType: String; AComboBox: TComboBox
   功能描述: 填充Art_NO字典到ComboBox中
   引用计数:
-------------------------------------------------------------------------------}
procedure FillOnLineCardList(GFKeyValue, Department: String; TreeNodes: TTreeNodes);
{*|<PRE> -----------------------------------------------------------------------------
   创建人员 lvzd
   创建日期 2005-3-9 17:01:43
   参数列表 GFKeyValue, Department: String; TreeNodes: TTreeNodes
   功能描述 填充在线卡号到树型列表中
   引用计数:
-------------------------------------------------------------------------------}
procedure FillMachineListByOperationCode(Department, Operation_Code: String; AItems: TStrings);
{*|<PRE> -----------------------------------------------------------------------------
   过程名称 FillMachineListByOperationCode
   创建人员 lvzd
   创建日期 2005-4-13 12:02:25
   参数列表 Operation_Code: String; AItems: TStrings
   返回值   无
   功能描述 
   附加说明         
-------------------------------------------------------------------------------}

implementation

{$IFNDEF TERMINAL}
uses frmViewArtDtl;
{$ENDIF}

procedure GetStdArtIDbyGFNO(GF_KeyValue, Department: String; var Art_ID, GF_ID: Integer);
var
  sErrorMsg: WideString;
begin
  if GF_KeyValue = '' then exit;

  FNMServerArtObj.GetCheckGFIDAndSTDArt(GF_KeyValue, Department, GF_ID, Art_ID, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetCheckGFIDAndSTDArt, [sErrorMsg]);

  //品名不存在
  if GF_ID = -1 then
    raise ExceptionEx.CreateResFmt(@INV_GFIDorGF_NO, [GF_KeyValue]);
end;

procedure GetOnLineCardByGFKeyValue(GFKeyValue, Department: String; CDS: TClientDataSet);
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  //刷新卡号列表。
  if GFKeyValue = '' then
    exit;

  FNMServerArtObj.GetOnLineCard('ByGFKeyValue', GFKeyValue, Department, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetOnLineCard, [sErrorMsg]);

  CDS.Data:=vData;
  if CDS.IsEmpty then
    raise Exception.CreateRes(@EMP_OnLineCard);
end;

procedure GetOnLineCardByOperation(Operation_Code: String; Department: String; CDS: TClientDataSet);
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  if CDS = nil then exit;

  FNMServerArtObj.GetOnLineCard('ByOperation', Operation_Code, Department, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetOnLineCard, [sErrorMsg]);

  CDS.Data:=vData;
  if CDS.IsEmpty then
    raise Exception.CreateRes(@EMP_OnLineCard);
end;

procedure FillItemsFromDataSet(cds: TDataSet; FirstField, SecondField, KeyField, LinkSymbol: string; TheItems: TStrings;
  InsertAll: Boolean=false; TrimSpace: Boolean = true; ClearMode: Boolean = true);
var
  ItemValue: String;
  i, KeyValue: Integer;
begin
  if (cds = nil) or (not cds.Active) then Exit;

  try
    TheItems.BeginUpdate;
    if ClearMode then
      TheItems.Clear;
    cds.DisableControls;
    cds.First;
    for i := 0 to cds.RecordCount - 1 do
    begin
      ItemValue:=cds.FieldByName(FirstField).AsString;
      if TrimSpace then
        ItemValue:=Trim(ItemValue);
      //去掉中文机台
      if (SecondField <> '') and (SecondField <> 'Machine_Model_CHN') then
      begin
        ItemValue:=ItemValue+LinkSymbol+cds.FieldByName(SecondField).AsString;
      end;

      if KeyField <> '' then
      begin
        KeyValue:=cds.FieldByName(KeyField).Asinteger;
        if TheItems.IndexOfObject(TObject(KeyValue)) = -1 then
          TheItems.AddObject(ItemValue, TObject(KeyValue))
        else if InsertAll then
          TheItems.AddObject(ItemValue, TObject(KeyValue));
      end
      else
        if TheItems.IndexOf(ItemValue) = -1 then
          TheItems.Add(ItemValue)
        else if InsertAll then
          TheItems.Add(ItemValue);

      cds.Next;
    end;
  finally
    cds.EnableControls;
    TheItems.EndUpdate;
  end;
end;

procedure FillTreeItemsFromDataSet(cds: TClientDataSet; DisplayField, ParentField, SubField, KeyField, RootValue: string;
    TheNodes: TTreeNodes; RootNode: TTreeNode = nil);
var
  i: Integer;
  NewNode: TTreeNode;
  TempCds: TClientDataSet;
  procedure FillChildNodes(ParentValue: string; TheNode: TTreeNode);
  {*|<PRE>------------------------------------------------------------------------------
     创建人员: lvzd
     创建日期: 2004-8-30 下午 06:13:45
     参数列表: ParentValue: 父节点的ParentField的值; TheNode: 在该节点下插入节点
     返回值  : 无
     功能描述: 递归插入所有子节点
     附加说明: 该函数为递归函数
  -------------------------------------------------------------------------------}
  var
    i: Integer;
    OldFilter: String;
  begin
    OldFilter:=TempCds.Filter;
    //过滤子节点
    TempCds.Filter:=SubField +' = '''+ParentValue+'''';
    for i := 0 to TempCds.RecordCount - 1 do
    begin
      //添加子节点
      if KeyField = '' then
        NewNode:=TheNodes.AddChild(TheNode, TempCds.FieldByName(DisplayField).AsString)
      else
        NewNode:=TheNodes.AddChildObject(TheNode, TempCds.FieldByName(DisplayField).AsString, Pointer(TempCds.FieldByName(KeyField).Asinteger));

      //添加子节点的子节点
      FillChildNodes(TempCds.FieldByName(ParentField).AsString, NewNode);
      TempCds.Delete;
    end;
    //返回过滤条件
    TempCds.Filter:=OldFilter;
  end;
begin
  if (Cds = nil) or Cds.IsEmpty then exit;

  TempCds:=nil;
  try
    //先克隆数据集合
    TempCds:=TClientDataSet.Create(Cds.Owner);
    TempCds.Data:=Cds.Data;
    //过滤根节点.
    TempCds.Filter:=SubField +ifthen(RootValue = '', '= ''''', ' = '''+RootValue+'''') ;
    TempCds.Filtered:=true;
    //开始插入节点
    TheNodes.BeginUpdate;
    //删除旧的节点
    TheNodes.Clear;
    for i := 0 to TempCds.RecordCount - 1 do
    begin
      //添加根节点
      if KeyField = '' then
        NewNode:=TheNodes.Add(RootNode, TempCds.FieldByName(DisplayField).AsString)
      else
        NewNode:=TheNodes.AddObject(RootNode, TempCds.FieldByName(DisplayField).AsString, Pointer(TempCds.FieldByName(KeyField).Asinteger));

      //添加子节点
      FillChildNodes(TempCds.FieldByName(ParentField).AsString, NewNode);
      TempCds.Delete;
    end;
  finally
    TempCds.Destroy;
    TheNodes.EndUpdate;
  end;
end;

procedure FillTreeItemsFromDataSetByClassField(cds: TClientDataSet; ValueField, ClassField, KeyField, DescriptionField: string; TheNodes: TTreeNodes);
var
  i: Integer;
  NewNode: TTreeNode;
  ChildNodeStrings, NodeText: String;
  TempCds: TClientDataSet;
begin
  if (Cds = nil) or Cds.IsEmpty then exit;

  TempCds:=nil;
  try
    //先克隆数据集合
    TempCds:=TClientDataSet.Create(Cds.Owner);
    TempCds.Data:=Cds.Data;

    TheNodes.BeginUpdate;
    while TempCds.RecordCount <> 0 do
    begin
      NodeText:=TempCds.FieldByName(ClassField).AsString;
//      if DescriptionField <> '' then
//        NodeText:=TempCds.FieldByName(DescriptionField).AsString;//NodeText +

      NewNode:=TheNodes.AddChild(nil, NodeText);
      TempCds.Filter:=Format('%s = ''%s''', [ClassField, TempCds[ClassField]]);
      TempCds.Filtered:=true;

      ChildNodeStrings:='/\';
      for i := 0 to TempCds.RecordCount - 1 do
      begin
        NodeText:=TempCds.FieldByName(ValueField).AsString;
        if DescriptionField <> '' then
          NodeText:=NodeText + TempCds.FieldByName(DescriptionField).AsString;

        if Pos('/\'+NodeText+'/\', ChildNodeStrings) = 0 then
        with TheNodes.AddChild(NewNode, NodeText) do
        begin
          if KeyField <> '' then
            Data:=TObject(TempCds.FieldByName(KeyField).AsInteger);
          ChildNodeStrings:=ChildNodeStrings + Text + '/\';
        end;
        
        TempCds.Delete;
      end;
      TempCds.Filtered:=false;
    end;
  finally
    TempCds.Destroy;
    TheNodes.EndUpdate;
  end;
end;

procedure FillListItemsFromDataSet(cds: TDataSet; FirstField, KeyField: string; FieldStrings: array of String; TheItems: TListItems);
var
  i, j: Integer;
  NewListItem: TListItem;
begin
  if (cds = nil) or (not cds.Active) then Exit;

  try
    TheItems.BeginUpdate;
    TheItems.Clear;
    with cds do
    begin
      DisableControls;
      First;
      for i := 0 to RecordCount - 1 do
      begin
        NewListItem:=TheItems.Add;
        NewListItem.Caption:=Trim(FieldByName(FirstField).AsString);
        for j := 0 to High(FieldStrings) do
          NewListItem.SubItems.Add(Trim(FieldByName(FieldStrings[j]).AsString));

        if (NewListItem.SubItems.Count <> 0) and (KeyField <> '') then
          NewListItem.SubItems.Objects[0]:=TObject(FieldByName(KeyField).AsInteger);

        next;
      end;
    end;
  finally
    cds.EnableControls;
    TheItems.EndUpdate;
  end;
end;

procedure AddItemToListItems(KeyValue: String; ItemStrings: array of String; TheItems: TListItems);
var
  i, j: Integer;
begin
  for i := 0 to TheItems.Count - 1 do
    if TheItems.Item[i].Caption = KeyValue then exit;

  with TheItems.Add do
  begin
    Caption:=KeyValue;
    for j := 0 to High(ItemStrings) do
      SubItems.Add(ItemStrings[j]);
  end
end;

procedure FillFN_Art_NOListToAComboBox(Code_Class: String; AComboBox: TComboBox);
begin
  Dictionary.cds_ArtDescriptionList.Filter:='Code_Class = ''' + Code_Class + '''';
  Dictionary.cds_ArtDescriptionList.Filtered:=true;
  FillItemsFromDataSet(Dictionary.cds_ArtDescriptionList, 'FN_Art_Code', 'Description', 'Iden', ' ', AComboBox.Items, false, false);
  AComboBox.DropDownCount:=AComboBox.Items.Count;
end;

procedure FillArt_NOListToAComboBox(ArtType: String; AComboBox: TComboBox);
begin
  Dictionary.cds_StdArtDtlList.Filter:='Type = ''' + ArtType + '''';
  Dictionary.cds_StdArtDtlList.Filtered:=true;
  FillItemsFromDataSet(Dictionary.cds_StdArtDtlList, 'Art_NO', 'Description', '', ' ', AComboBox.Items, false, false);
  AComboBox.DropDownCount:=AComboBox.Items.Count;
end;

procedure FillOnLineCardList(GFKeyValue, Department: String; TreeNodes: TTreeNodes);
var
  i: Integer;
begin
  //刷新卡号列表。
  if GFKeyValue = '' then exit;

  GetOnLineCardByGFKeyValue(GFKeyValue, Department, TempClientDataSet);
  if TempClientDataSet.IsEmpty then exit;

  TreeNodes.Clear;
  FillTreeItemsFromDataSetByClassField(TempClientDataSet, 'FN_Card', 'Fact_Art_Step_NO', '', '', TreeNodes);
  with TreeNodes, TreeNodes.Owner do
  if Count > 0 then
  begin
    for i := 0 to Count - 1 do
    begin
      if Item[i].Level = 0 then
        Item[i].StateIndex := 0;
    end;

    FullExpand;
    Selected:=TreeNodes.Item[0];
    Selected.MakeVisible;
    Enabled:=true;
  end;
end;

procedure FillMachineListByOperationCode(Department, Operation_Code: String; AItems: TStrings);
var
  i: Integer;
begin
  AItems.Clear;
  with Dictionary do
  try
    cds_OperationMapMachineModel.Filter:=Format('Operation_Code = ''%s''', [Operation_Code]);
    cds_OperationMapMachineModel.Filtered:=true;
    for i := 0 to cds_OperationMapMachineModel.RecordCount - 1 do
    begin
      cds_FinishMachineList.Filter:=Format('Machine_ID LIKE ''%s%%'' AND Department = ''%s''', [Trim(cds_OperationMapMachineModel['Machine_Model']), Department]);
      cds_FinishMachineList.Filtered:=true;
      FillItemsFromDataSet(cds_FinishMachineList, 'Machine_ID', 'Machine_Model_CHN', '', '-', AItems, False, True, False);
      cds_OperationMapMachineModel.Next;
    end;
  finally
    cds_FinishMachineList.Filtered:=false;
    cds_OperationMapMachineModel.Filtered:=false;
  end;    
end;

{TArtDtlInfo}
constructor TArtDtlInfo.Create(AOwner: TComponent);
begin
  inherited Create;

  Fcds_ArtHdr:=TClientDataSet.Create(AOwner);
  Fcds_ArtDtl:=TClientDataSet.Create(AOwner);
  Org_Fcds_ArtDtl:=TClientDataSet.Create(AOwner);
end;

destructor TArtDtlInfo.Destroy;
begin
  if not CloseArt then exit;

  Fcds_ArtHdr.Destroy;
  Fcds_ArtDtl.Destroy;
  //Org_Fcds_ArtDtl.Destroy;
  inherited Destroy;
end;

function TArtDtlInfo.IsEmpty: Boolean;
begin
  result:=Fcds_ArtHdr.IsEmpty;
end;

procedure TArtDtlInfo.SetModify(ModifyValue: Boolean);
begin
  if FModify = ModifyValue then exit;

  FModify := Active and ModifyValue;
  if Active and Assigned(FOnAfterEdit) then FOnAfterEdit(Self);
end;

function TArtDtlInfo.GetActive: Boolean;
begin
  result:=Fcds_ArtHdr.Active and Fcds_ArtDtl.Active
end;

function TArtDtlInfo.GetOperateStepCount: Integer;
var
  i: Integer;
begin
  result:=0;
  if Fcds_ArtDtl.IsEmpty then exit;
    
  Fcds_ArtDtl.First;
  result:=Fcds_ArtDtl['Step_NO'];
  for i := 0 to Fcds_ArtDtl.RecordCount - 1 do
  begin
    if Fcds_ArtDtl['Step_NO'] > result then
      result:=Fcds_ArtDtl['Step_NO'];
    Fcds_ArtDtl.Next;
  end;    
end;

procedure TArtDtlInfo.ViewArtDtlInNewForm;
begin
{$IFNDEF TERMINAL}
  if Active then
    ViewArtDtl(Fcds_ArtDtl);
{$ENDIF}
end;

function TArtDtlInfo.CloseArt: Boolean;
var
  MessResult: Integer;
begin
  result := True;
  if not Active then
  begin
    Modify:=False;
    exit;
  end;
    
  result := False;
  //判断用户是否保存了修改数据，没有保存询问用户。
  if Modify then
  begin
    MessResult:=MessageBox(Application.Handle, Pchar(GetResourceString(@AskSaveDataStr)),Pchar(Application.Title), MB_YESNOCANCEL+MB_ICONQUESTION);
    if (MessResult = IDYES) and (not SaveArtToDataBase) then
        Raise Exception.Create(GetResourceString(@SaveDataFail));

    if MessResult = IDNO then
    begin
      Fcds_ArtHdr.CancelUpdates;
      Fcds_ArtDtl.CancelUpdates;
      Modify:=false;
    end;

    if MessResult = IDCANCEL then
      exit;
  end;

  Fcds_ArtHdr.Close;
  Fcds_ArtDtl.Close;
  Org_Fcds_ArtDtl.Close;
  if Assigned(OnAfterClose) then OnAfterClose(self);
    
  result := True;
end;

function TArtDtlInfo.SaveArtToDataBase: Boolean;
Begin
  result := True;
end;

function TArtDtlInfo.GetStepOperateCode(Step_NO: Integer): String;
begin
  result:='';
  if not Active then exit;

  if Fcds_ArtDtl.Locate('EditStep_no', IntToStr(Step_NO), []) then
    result:=Fcds_ArtDtl.FieldByName('Operation_Code').AsString;
end;

function TArtDtlInfo.GetStepOperateName(Step_NO: Integer): String;
begin
  result:='';
  if not Active then exit;

  if Fcds_ArtDtl.Locate('EditStep_no', IntToStr(Step_NO), []) then
    result:=Fcds_ArtDtl.FieldByName('Operation_CHN').AsString;
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
      //等于-1删除一个工序
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

procedure TArtDtlInfo.MergeStepNOValue;
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

function TArtDtlInfo.AddAOperateStep(Operate_ID: Integer; Operation_Code: string = ''): Integer;
var
  iType,iGFID: Integer;
  vData: Olevariant;
  sCondition,sErrorMsg: widestring;
begin
  if ClassName = 'TSTDArtDtlInfo' then
  begin
    iType := 0;
    iGFID := TSTDArtDtlInfo(Self).GF_ID;
  end;
  if ClassName = 'TFactArtDtlInfo' then
  begin
    iType := 1;
    iGFID := TFactArtDtlInfo(Self).GF_ID;
  end;
  if ClassName = 'THLArtDtlInfo' then
  begin
    iType := 2;
    iGFID := THLArtDtlInfo(Self).FN_ID;
  end;
  if ClassName = 'TRepairArtDtlInfo' then
  begin
    iType := 3;
    iGFID := TRepairArtDtlInfo(Self).GF_ID;
  end;
  //取出最大的一个Step_no值加1后作为新插入的Step_NO的值
  result:=GetOperateStepCount + 1;

  sCondition := IntToStr(iGFID)+','+IntToStr(Operate_ID)+','+ QuotedStr(Operation_Code)+','+ IntToStr(iType)+','+ QuotedStr(Login.CurrentDepartment);

  FNMServerObj.GetQueryData(vData,'ARTGetOperation',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TempClientDataSet.Data:=vData;
  with TempClientDataSet do
  begin
    First;
    while not Eof  do
    begin
      Fcds_ArtDtl.AppendRecord([result, result,
          FieldByName('Operation_Code').AsString,
          FieldByName('Operation_CHN').AsString,
          FieldByName('Item_Name').AsString,
          FieldByName('Item_Value').AsString,'', nil]);
      Next;
    end;
  end;
  Modify:=true;
end;

procedure TArtDtlInfo.MoveAOperateStep(Step_NO: Integer; OperateOffset: TOperateOffset);
begin
  case OperateOffset of
    ooMoveUP:
    begin
      SetAOperateEditStep_NOValue(Step_NO, Step_NO-1); //当前工序的Step_NO的值减1
      SetAOperateEditStep_NOValue(Step_NO-1, Step_NO); //上个工序的Step_NO调整为当前的工序的Step_NO
    end;
    ooMoveDown:
    begin
      SetAOperateEditStep_NOValue(Step_NO, Step_NO+1); //当前工序的Step_NO的值加1
      SetAOperateEditStep_NOValue(Step_NO+1, Step_NO); //下个工序的Step_NO调整为当前的工序的Step_NO
    end;
    ooDelete:
      SetAOperateEditStep_NOValue(Step_NO, -1);
  end;
  MergeStepNOValue;                                    //使Step_NO和EditStep_NO的值相同,使修改生效.
  Modify:=true;
end;

procedure TArtDtlInfo.ClearAllOperateStep;
begin
  if Active then
    Fcds_ArtDtl.EmptyDataSet;
end;

function TArtDtlInfo.RepairItemValue(OperationCode, ItemName,
  ItemValue: String): string;
begin
  Result:=ItemValue;
  if ItemName = '次序' then
  begin
    Result:=StringReplace(Result, 'Z', '正', [rfReplaceAll, rfIgnoreCase]);
    Result:=StringReplace(Result, 'F', '反', [rfReplaceAll, rfIgnoreCase]);
  end;
end;

procedure TArtDtlInfo.TestItemValue(OperationCode, ItemName, ItemValue: String);
var
  tempe: Extended;
  tempi: Integer;
  ValueType: String;
begin
  with Dictionary.cds_OperationDtlList do
  begin
    if ItemName = '次序' then
    begin
      ItemValue:=StringReplace(ItemValue, '正', '',  [rfReplaceAll]);
      ItemValue:=StringReplace(ItemValue, '反', '',  [rfReplaceAll]);
      if ItemValue <> '' then
        raise Exception.CreateResFmt(@INV_NOItemValue, ['正 Or 反', '正 Or 反']);
    end;

    if Locate('Operation_Code;Item_Name', VarArrayOf([OperationCode, ItemName]), []) then
    begin
      ValueType:=Dictionary.cds_OperationDtlList['Data_Type'];
      if ValueType = 'Boolean' then
      begin
        if (LowerCase(ItemValue) <> 'true') and (LowerCase(ItemValue) <>  'false') then
          raise Exception.CreateResFmt(@INV_NOItemValue, ['True Or False', 'True Or False']);
      end;
      if ValueType = 'int' then
      begin
        if not TryStrToInt(ItemValue, tempi) then
          raise Exception.CreateResFmt(@INV_NOItemValue, ['整数', '整数']);
      end;
      if ValueType = 'Numeric' then
      begin
        if not TryStrToFloat(ItemValue, tempe) then
          raise Exception.CreateResFmt(@INV_NOItemValue, ['数字', '数字']);
      end;
    end;
  end;
end;
// DAVID ADD FOR TEST BEGIN {
procedure TRepairArtDtlInfo.SaveRepairArt(var vData: OleVariant; vDataHdr,
  vDataDtl: OleVariant; var sErrorMsg: WideString);
const
 // David Add 2014-10-09 begin, 自动生成回修工艺
 UPDATE_REPAIR_HDR_SQL = 'UPDATE dbo.fnFactArtHdr SET Operator=''%s'' ' +
        'WHERE FN_Card=''%s'''+#13#10;
 DELETE_REPAIR_DTL_SQL = 'DELETE dbo.fnFactArtDtl WHERE Fact_Art_ID=''%s''' +#13#10;
 // David Add 2014-10-09 end, 自动生成回修工艺
 INSERT_REPAIR_HDR_SQL = 'INSERT INTO dbo.fnFactArtHdr (GF_ID, STD_Art_ID, STD_Art_Version, Art_Type, Material_Quality, Operator, Remark) '+
                         'VALUES(''%s'', -1, 0, ''%s'', ''%s'', ''%s'', ''%s'')' +#13#10;
 INSERT_REPAIR_DTL_SQL = 'INSERT INTO dbo.fnFactArtDtl (Fact_Art_ID, Step_NO, Operation_Code, Item_Name, Item_Value, Operator, Operate_Time) '+
                         'VALUES(@Fact_Art_ID, ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'') ' +#13#10;
 INSERT_REPAIROPERATION_SQL0 = 'INSERT INTO dbo.fnRepairOperation (GF_ID,Quantity,FN_Card, Reason_Code, Internal_External, Repair_Operation, Current_Department, Operator, Operate_Time) '+
                              'VALUES(''%s'',''%s'',''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', GETDATE())' +#13#10;
 INSERT_REPAIROPERATION_SQL1 = 'INSERT INTO dbo.fnRepairOperation (GF_ID,Quantity,FN_Card, Reason_Code, Internal_External, Repair_Operation, Current_Department, Operator, Operate_Time, Checker, Check_Time) '+
                              'VALUES(''%s'',''%s'',''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', GETDATE(), ''%s'',GETDATE())' +#13#10;
 UPDATE_REPAIROPERATION_SQL0 = 'UPDATE dbo.fnRepairOperation  SET GF_ID = ''%s'', Quantity = ''%s'',FN_Card = ''%s'', Reason_Code = ''%s'', Internal_External= ''%s'', Repair_Operation= ''%s'', Current_Department= ''%s'','+
                              ' Operator = ''%s'', Operate_Time = GETDATE() '+
                              ' WHERE Check_Time IS NULL AND Iden = ''%s'''+#13#10;
 UPDATE_REPAIROPERATION_SQL1 = 'UPDATE dbo.fnRepairOperation  SET Checker = ''%s'', Check_Time = GETDATE() '+
                              ' WHERE Check_Time IS NULL AND Iden = ''%s'''+#13#10;
var
  i: Integer;
  SqlText, FNCardList: String;
  cds_Art: TClientDataSet;
begin
  SqlText := '';
  //更新进度跟踪记录
  FNCardList:= vData[0][4];
  while FNCardList[Length(FNCardList)] = ',' do
    System.Delete(FNCardList, Length(FNCardList), 1);
  FNCardList:='(''' + StringReplace(FNCardList, ',', ''',''', [rfReplaceAll]) + ''')';
  
  if vData[0][0] = 1 then //IsQualityOperator
  begin
    if vData[0][1] = 0 then  //new
      SqlText :=  SqlText + Format(INSERT_REPAIROPERATION_SQL0,[vData[0][2],vData[0][3],vData[0][4],vData[0][5],vData[0][6],vData[0][7],vData[0][8],vData[0][9]])
     else  //edit
      SqlText :=  SqlText + Format(UPDATE_REPAIROPERATION_SQL0,[vData[0][2],vData[0][3],vData[0][4],vData[0][5],vData[0][6],vData[0][7],vData[0][8],vData[0][9],vData[0][1]]);
  end else
  begin
    if vData[0][1] = 0 then  //new
      SqlText :=  SqlText + Format(INSERT_REPAIROPERATION_SQL1,[vData[0][2],vData[0][3],vData[0][4],vData[0][5],vData[0][6],vData[0][7],vData[0][8],vData[0][9],vData[0][9]])
     else  //edit
      SqlText :=  SqlText + Format(UPDATE_REPAIROPERATION_SQL1,[vData[0][9],vData[0][1]]);
  end;
  if  vData[0][0] <> 1 then
  begin
    cds_Art:=nil;
    try
      cds_Art:=TClientDataSet.Create(nil);
        cds_Art.Data:=vDataHdr;
        SqlText := SqlText + 'DECLARE @Fact_Art_ID Int '#13#10;
        with cds_Art do
        begin
        // David 2014-10-09 修改，某些工艺类型疵点会在打卡时生成工艺，需要进行判断是否已经生成工艺
        // 需求42677 制定回修工艺，参考 usp_fnAutoGenerateRepairParas
        SqlText :=  SqlText + 'SET @Fact_Art_ID=-1' + #13#10;
        SqlText :=  SqlText + FORMAT('SELECT TOP 1 @Fact_Art_ID=Fact_Art_ID FROM dbo.fnRepairCardAutoFactArtID WHERE FN_Card=''%s''', [FNCardList]);
        SqlText :=  SqlText + 'IF @Fact_Art_ID>0' + #13#10;
        SqlText :=  SqlText + 'BEGIN'+ #13#10;
          // 如果已经生成工艺开始 David
          SqlText :=  SqlText + Format(UPDATE_REPAIR_HDR_SQL, [FieldByName('Operator').AsString, FNCardList]) + #13#10;
          SqlText :=  SqlText + Format(DELETE_REPAIR_DTL_SQL, ['@Fact_Art_ID'])+ #13#10;
          // 如果已经生成工艺结束 David
        SqlText :=  SqlText + 'END'+ #13#10;
        
        SqlText :=  SqlText + 'ELSE'+ #13#10;
        SqlText :=  SqlText + 'BEGIN'+ #13#10;
          // 如果没有生成工艺 begin, David
          SqlText := SqlText + Format(INSERT_REPAIR_HDR_SQL,[FieldByName('GF_ID').AsString,
                                                             FieldByName('Art_Type').AsString,
                                                             FieldByName('Material_Quality').AsString,
                                                             FieldByName('Operator').AsString,
                                                             FieldByName('Remark').AsString]);

          SqlText := SqlText + 'SET @Fact_Art_ID =IDENT_CURRENT(''fnFactArtHdr'') '+ #13#10;
          // 如果没有生成工艺 end, David
        SqlText :=  SqlText + 'END'+ #13#10;
          

          cds_Art.Data:=vDataDtl;
          for i := 0 to RecordCount - 1 do
          begin
            SqlText:=SqlText + Format(INSERT_REPAIR_DTL_SQL,[FieldByName('Step_NO').AsString,
                                                             FieldByName('Operation_Code').AsString,
                                                             FieldByName('Item_Name').AsString,
                                                             FieldByName('Item_Value').AsString,
                                                             FieldByName('Operator').AsString,
                                                             FieldByName('Operate_Time').AsString]);
            Next;
          end;
          //加入头(000)尾(999)工序
          SqlText:=SqlText + 'EXEC dbo.usp_InsertHeadOperate @Fact_Art_ID ' + #13#10;
        end;
    finally
      FreeAndNil(cds_Art);
    end;
  end;
 

  if vData[0][0] = 1 then //IsQualityOperator    //便于操作班长输入工序时数据提取
    SqlText := SqlText + 'UPDATE dbo.fnJobTraceHdr SET Fact_Art_ID = -999 ' +
                          Format('WHERE FN_Card IN %s '#13#10, [FNCardList])
  else
    SqlText := SqlText + 'UPDATE fnJobTraceHdr SET FACT_Art_ID = @Fact_Art_ID, Step_NO = 1, Operation_Code = dbo.udf_GetOperationCode(@Fact_Art_ID, 1) '+
                          Format('WHERE FN_Card IN %s '#13#10, [FNCardList]);

  //增加扩展保存回修工艺
  if vData[0][0] <> 1 then
    SqlText := SqlText + ' EXEC dbo.usp_SaveRepairArtEx @Fact_Art_ID ';

end;
// DAVID CAO ADD FOR TEST END!!}
function TArtDtlInfo.SetAOperateParameterValue(Step_NO :Integer; Item_Name, Item_Value: String): String;
var
  sStr, sRemark, sErrorMsg: WideString;
begin
  try
    if Pos('(', Item_Name) >0 then
       Item_Name:=Trim(LeftStr(Item_Name, Pos('(', Item_Name) - 1));

    Fcds_ArtDtl.DisableControls;
    if Fcds_ArtDtl.Locate('Step_NO;Item_Name', VarArrayOf([Step_NO, Item_Name]), []) then
    begin
      if Item_Value <> '' then
      begin
        Item_Value:=RepairItemValue(Fcds_ArtDtl['Operation_Code'], Item_Name, Item_Value);
        TestItemValue(Fcds_ArtDtl['Operation_Code'], Item_Name, Item_Value);
      end;

      //丝光工序，修改碱浓时提醒是否提醒PDM
      if pos('碱浓', Item_Name)> 0 then
      begin
        if MessageDlg('是否提醒技术部', mtWarning, mbYesNoCancel,0)= mrYes then
        begin
          sRemark := InputBox('修改原因', '请输入原因:','');
          sStr := QuotedStr(Fcds_ArtHdr['Art_ID'])+ ','
                + VarToStr(Fcds_ArtDtl['Step_NO'])+ ','
                + VarToStr(Fcds_ArtHdr['GF_ID'])+ ','
                + QuotedStr(Fcds_ArtHdr['GF_NO'])+ ','
                + QuotedStr(Fcds_ArtDtl['Operation_Code'])+ ','
                + QuotedStr(VarToStr(Fcds_ArtDtl['Item_Value']))+ ','
                + QuotedStr(VarToStr(Item_Value))+ ','
                + QuotedStr(Login.LoginID)+ ','
                + QuotedStr(sRemark);
          FNMServerArtObj.SaveModifiedArtLog(QuotedStr(sStr), sErrorMsg);
          if sErrorMsg<> '' then
            raise Exception.CreateRes(@DataError);
        end;
      end;

      Fcds_ArtDtl.Edit;
      Fcds_ArtDtl['Item_Value']:=Item_Value;
      Fcds_ArtDtl['Operator']:=Login.LoginID;
      Fcds_ArtDtl['Operate_Time']:= TGlobal.GetServerTime; //Now; cuijf 2008-6-12
    end
    else
    begin
      //cuijf 2008-6-12
      sStr := '请检查实际工艺'+ VarToStr(Fcds_ArtHdr['Art_ID'])+ '中该工序"'+Fcds_ArtDtl['Operation_CHN']+'"是否有"内回修"参数';
      raise Exception.Create(sStr);
      //raise Exception.CreateRes(@DataError);
    end;

    Result:=Item_Value;
    Modify:=true;
  finally
    Fcds_ArtDtl.EnableControls;
  end;
end;

procedure TArtDtlInfo.FillOperationToAListControls(AItem: TStrings);
  function GetAOperateDispText(Step_NO: Integer; OldText: String): String;
  begin
    //Format:=Step_NO+)+Operate_CHN
    result:=IntToStr(Step_NO);
    result := result + StringOfChar(' ', MAX_OPERATE_STEP_NO_LENGTH - Length(result)) + ')' + OldText;

  end;
var
  ItemValue, Operation_Name, Operation_Addr: String;
  i, RecNO, KeyValue: Integer;
begin
  if not Active then exit;
  try
    AItem.BeginUpdate;
    AItem.Clear;
    Fcds_ArtDtl.DisableControls;
    KeyValue:=-1;
    Fcds_ArtDtl.IndexFieldNames:='Step_NO';
    Fcds_ArtDtl.First;
    for i := 0 to Fcds_ArtDtl.RecordCount - 1 do
    begin
      if KeyValue = Fcds_ArtDtl.FieldByName('Step_NO').Asinteger then
      begin
        Fcds_ArtDtl.Next;
        continue;
      end;

      RecNO:=Fcds_ArtDtl.RecNo;
      Operation_Addr:='';
      KeyValue:=Fcds_ArtDtl.FieldByName('Step_NO').Asinteger;
      if Fcds_ArtDtl.Locate('Step_NO;Item_Name', VarArrayOf([KeyValue, '加工地点']), []) then
        Operation_Addr:=Format('(%s)', [Fcds_ArtDtl.FieldByName('Item_Value').AsString]);
      Fcds_ArtDtl.RecNo := RecNO;

      Operation_Name:=Fcds_ArtDtl.FieldByName('Operation_CHN').AsString;
      Operation_Name:=Operation_Name + StringOfChar(' ', 10 - Length(Operation_Name));

      ItemValue:=GetAOperateDispText(KeyValue, Operation_Name + Operation_Addr);
      if Fcds_ArtDtl.FieldByName('OrgStep_NO').IsNull then
        ItemValue:=ItemValue + ' *';
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

procedure TArtDtlInfo.FillParameterListControls(FillModle: String; AValueListEditor: TValueListEditor);
var
  i, StepNO: Integer;
  Key, Value,Enum_Value,Data_Unit: String;
begin
  AValueListEditor.Strings.Clear;
  with Dictionary.cds_OperationDtlList do
  begin
    Filtered := False;
    i:=0; Fcds_ArtDtl.First;
    while not Fcds_ArtDtl.Eof do
    begin
      //取字典等信息
      if Locate('Operation_Code;Item_Name',
              VarArrayOf([Fcds_ArtDtl.FieldByName('Operation_Code').AsString, Fcds_ArtDtl.FieldByName('Item_Name').AsString]), []) then
      begin
        Key:=Trim(Fcds_ArtDtl.FieldByName('Item_Name').AsString);
        if FillModle = 'Step' then
        begin
          Key:=Key + {补齐空格}StringOfChar(' ' , (10 - Length(Key)));
          {数据单位}
          Data_Unit := FieldByName('Data_Unit').AsString;
          if Data_Unit<>'' then
             Key:=Key + '(' + Data_Unit + ')';
        end;
        if FillModle = 'ItemName' then
          Key:=Key + {补齐空格}StringOfChar(' ' , (10 - Length(Key))) + '(' +
            {工序名}FieldByName('Operation_CHN').AsString + ')';

        Value:=Fcds_ArtDtl['Item_Value'];{参数取值}
        StepNO:=Fcds_ArtDtl['Step_NO'];  {工序}

        AValueListEditor.Strings.AddObject(Format('%s=%s', [Key, Value]), TObject(StepNO));

        Enum_Value := FieldByName(Login.CurrentDepartment+'_Enum_Value').AsString;
        //设置编辑样式
        with AValueListEditor.ItemProps[i] do //此处不能使用Key, 如果Key相同，会造成错误。
        if Enum_Value = 'By Function' then
          EditStyle:=esEllipsis
        else
        begin
          if Trim(Fcds_ArtDtl.FieldByName('Item_Name').AsString) = '机台' then
          begin
            EditStyle:=esPickList;
            FillMachineListByOperationCode(Login.CurrentDepartment, Fcds_ArtDtl.FieldByName('Operation_Code').AsString, PickList);
          end
          else if Length(Enum_Value) <> 0 then
          begin
            EditStyle:=esPickList;
            PickList.Text:=StringReplace(Enum_Value, ',', #13, [rfReplaceAll]);
          end;
        end;
        inc(i);
      end;
      Fcds_ArtDtl.Next;
    end;
  end;
end;

procedure TArtDtlInfo.FillAStepToAListControls(Step_NO: Integer; AValueListEditor: TValueListEditor);
begin
  try
    Fcds_ArtDtl.DisableControls;
    Fcds_ArtDtl.Filter:='Step_NO = '''+ IntToStr(Step_NO)+'''';
    Fcds_ArtDtl.Filtered:=true;

    FillParameterListControls('Step', AValueListEditor);
  finally
    Fcds_ArtDtl.Filtered:=false;
    Fcds_ArtDtl.EnableControls;
  end;
end;

procedure TArtDtlInfo.FillAItemToAListControls(ItemName: String; AValueListEditor: TValueListEditor);
begin
  try
    Fcds_ArtDtl.DisableControls;
    Fcds_ArtDtl.Filter:=Format('Item_Name = ''%s''', [ItemName]);
    Fcds_ArtDtl.Filtered:=true;

    FillParameterListControls('ItemName', AValueListEditor);
  finally
    Fcds_ArtDtl.Filtered:=false;
    Fcds_ArtDtl.EnableControls;
  end;
end;

function TArtDtlInfo.GetFieldValue(Index: integer): Variant;
begin
  result:='';
  if (not Active) or IsEmpty then exit;

  result:=Fcds_ArtHdr.Fields.Fields[Index - 1].Value;
  if Fcds_ArtHdr.Fields.Fields[Index - 1].IsNull then
  begin
    result:='';
  end
end;

procedure TArtDtlInfo.SetFieldValue(Index: integer; FieldValue: Variant);
begin
  if (not Active) or IsEmpty then exit;

  if VarCompareValue(Fcds_ArtHdr.Fields.Fields[Index - 1].Value, FieldValue) <> vrEqual then
  begin
    Fcds_ArtHdr.Edit;
    Fcds_ArtHdr.Fields.Fields[Index - 1].Value := FieldValue;
  end;
  Modify:=true;
end;

function TArtDtlInfo.GetOperations: String;
var
  CurStep, i: Integer;
begin
  result:='';
  if Fcds_ArtDtl.IsEmpty then exit;
    
  Fcds_ArtDtl.First;
  CurStep:=Fcds_ArtDtl['Step_NO'];
  result:=Fcds_ArtDtl['Operation_Code'] + ',';
  for i := 0 to Fcds_ArtDtl.RecordCount - 1 do
  begin
    if Fcds_ArtDtl['Step_NO'] > CurStep then
    begin
      CurStep:=Fcds_ArtDtl['Step_NO'];
      result:=result + Fcds_ArtDtl['Operation_Code'] + ',';
    end;

    Fcds_ArtDtl.Next;
  end;    
end;

{TSTDArtDtlInfo}
procedure TSTDArtDtlInfo.SetOrgDepartment(OrgDepartmentValue: String);
begin
  if FOrgDepartment = OrgDepartmentValue then exit;
    
  if not CloseArt then exit;
  FOrgDepartment:=OrgDepartmentValue;
end;

procedure TSTDArtDtlInfo.SetOrgArt_ID(OrgArt_IDValue: Integer);
begin
  if FOrgArt_ID = OrgArt_IDValue then exit;
    
  FOrgArt_ID:=OrgArt_IDValue;
end;

constructor TSTDArtDtlInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FOrgArt_ID:=-1
end;

destructor TSTDArtDtlInfo.Destroy;
begin
  inherited Destroy;
end;

procedure TSTDArtDtlInfo.OpenFNSTDArt;
var
  sCondition,sErrorMsg: WideString;
  vData: OleVariant;
begin
  if not CloseArt then exit;
  if OrgArt_ID = -1 then
    raise Exception.CreateRes(@MSG_InfoDeficiency);
  sCondition := IntToStr(OrgArt_ID)+','+QuotedStr('S');
  FNMServerObj.GetQueryData(vData,'ARTGetArtInfo',sCondition,sErrorMsg);
//  FNMServerArtObj.GetArtDtl(FOrgArt_ID, 'S', vDataHdr, vDataDtl, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetStdArtDtl, [sErrorMsg]);

  Fcds_ArtHdr.Data:=vData[0];
  Fcds_ArtDtl.Data:=vData[1];

  if IsEmpty then
  begin
    CloseArt;
    raise Exception.CreateRes(@EMP_STDArt);
  end;

  if Assigned(FOnAfterOpen) then FOnAfterOpen(Self);

  Modify:=false;
end;

procedure TSTDArtDtlInfo.SaveFeedbackInfo;
var
  sCondition,sErrorMsg: WideString;
begin
  sCondition := IntToStr(GF_ID)+ ','+ QuotedStr(PDARemark) + ','+
                QuotedStr(PDMRemark) + ','+ QuotedStr(Login.LoginName) + ','+
                QuotedStr(Login.CurrentDepartment);
  FNMServerObj.SaveDataBySQL('ARTSaveFeedbackInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveStdArtData, [sErrorMsg]);
  ShowMsgDialog(@MSG_SaveStdArtInfoSuccess, mtInformation);
end;

function TSTDArtDtlInfo.SaveArtToDataBase: Boolean;
var
  sErrorMsg: WideString;
  vDataDtl,vDataParam: OleVariant;
  sOperation_code,sItem_value:string;
  i:Integer;
  sCondition:string;
begin
  result := True;

  //保存工艺时，未check 那么记录修改了多少次参数 版本为1 表示未check过
  if not Fcds_ArtHdr.FieldByName('Art_ID').IsNull then
  begin
      sOperation_code := '';
      sItem_value := '';
      with Fcds_ArtDtl do
      begin
        for i := 0 to RecordCount - 1 do
        begin
          sCondition :=Fcds_ArtHdr.FieldByName('Art_ID').AsString + ',' +
                       QuotedStr(FieldByName('operation_code').AsString) + ',' +
                       QuotedStr(FieldByName('Item_name').AsString) + ',' +
                       QuotedStr(FieldByName('Item_value').AsString) + ',0';
          if (sOperation_code <> QuotedStr(FieldByName('operation_code').AsString))
             and (sItem_value <> QuotedStr(FieldByName('Item_value').AsString)) then
          begin
            FNMServerObj.SaveDataBySQL('SaveParaChange',sCondition,sErrorMsg);

            sOperation_code := QuotedStr(FieldByName('operation_code').AsString);
            sItem_value := QuotedStr(FieldByName('Item_value').AsString);

            if sErrorMsg <> '' then
            begin
              TMsgDialog.ShowMsgDialog('记录修改出错!',mtError);
              Exit;
            end;
          end;
          Next;
        end;
      end;
  end;

  if (not Active) or (not Modify) or IsEmpty then exit;
  if Assigned(FOnBeforeSave) then FOnBeforeSave(Self);

  Fcds_ArtHdr.MergeChangeLog;
  Fcds_ArtDtl.MergeChangeLog;
  //保存数据
  vDataDtl:=Fcds_ArtDtl.Data;
  vDataParam := VarArrayOf([GF_ID,
                            PDARemark,
                            PDMRemark,
                            Login.LoginName,
                            Login.CurrentDepartment]);

  FNMServerArtObj.SaveStdArt(Fcds_ArtHdr.Data, vDataDtl,vDataParam,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveStdArtData, [sErrorMsg]);

  TempClientDataSet.Data:=vDataDtl;
  if Fcds_ArtHdr.FieldByName('Art_ID').IsNull then
  begin
    Fcds_ArtHdr.Edit;
    Fcds_ArtHdr.FieldByName('Art_ID').Value:=TempClientDataSet.Fields.Fields[0].Value;
    Fcds_ArtHdr.FieldByName('Version').Value:=0;
  end;

  result:=true;
  Modify:=false;
  if Assigned(FOnAfterSave) then FOnAfterSave(Self);
  ShowMsgDialog(@MSG_SaveStdArtInfoSuccess, mtInformation);
end;

procedure TSTDArtDtlInfo.CheckStdArt(iType:Integer);
var
  sCondition,sErrorMsg: WideString;
  vData:OleVariant;
  cdsR:TClientDataSet;
begin
  //先保存!
  if Modify then
    SaveArtToDataBase;

  if (not Active) or IsEmpty then
    raise Exception.CreateRes(@EMP_STDArt);
                           
  //保存数据
   sCondition :=  QuotedStr(Art_ID)+','+QuotedStr(Version)+','+QuotedStr(Login.LoginName)+','+
                  QuotedStr(Login.CurrentDepartment)+','+ IntToStr(iType);
   FNMServerObj.GetQueryData(vData,'ARTCheckStdArt',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
      raise ExceptionEx.CreateResFmt(@SaveCheckArtDataError, [sErrorMsg]);
  end;
  cdsR := TClientDataSet.Create(nil);
  cdsR.Data := vData;
  if cdsR.FieldByName('result').AsString = '不做预拉斜客户' then
  begin
    TMsgDialog.ShowMsgDialog('不做预拉斜客户!', mtWarning);
  end;

  Fcds_ArtHdr.Edit;
  Fcds_ArtHdr.FieldByName('Checker').AsString:=Checker;
  Fcds_ArtHdr.FieldByName('Check_Time').AsDateTime:= TGlobal.GetServerTime; //Now; cuijf 2008-6-12

  Modify:=false;
  if Assigned(FOnAfterSave) then FOnAfterSave(Self);
  ShowMsgDialog(@MSG_SaveStdArtCheckInfoSuccess, mtInformation);
end;

procedure TSTDArtDtlInfo.CreateStdArt(OrgGF_ID: Integer; Department, Creator: String);
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  if not CloseArt then exit;
  try
    //构造主表字段
    with Fcds_ArtHdr do
    begin
      FieldDefs.Clear;
      FieldDefs.Add('Art_ID',             ftInteger);
      FieldDefs.Add('GF_ID',              ftInteger);
      FieldDefs.Add('GF_NO',              ftString, 20);
      FieldDefs.Add('FN_Art_NO',          ftString, 10);
      FieldDefs.Add('FN_Color_Code',      ftString, 2);
      FieldDefs.Add('Shrinkage',          ftString, 20);
      FieldDefs.Add('HandFeel',           ftString, 100);
      FieldDefs.Add('Product_Width',       ftString, 20);
      FieldDefs.Add('Material_Quality',   ftString, 10);
      FieldDefs.Add('Version',            ftSmallint);
      FieldDefs.Add('Current_Department', ftString, 2);
      FieldDefs.Add('Operator',           ftString, 20);
      FieldDefs.Add('Operate_Time',       ftDateTime);
      FieldDefs.Add('Checker',            ftString, 20);
      FieldDefs.Add('Check_Time',         ftDateTime); 
      FieldDefs.Add('Feedback',           ftString, 20);
      FieldDefs.Add('Feedback_Time',      ftDateTime);
      FieldDefs.Add('PDARemark',          ftString, 300);
      FieldDefs.Add('PDMRemark',          ftString, 300);
      FieldDefs.Add('Remark',             ftString, 150);
      FieldDefs.Add('Is_Active',          ftBoolean);
      CreateDataSet;
      Fcds_ArtHdr.Append;
      Fcds_ArtHdr['GF_ID']:=OrgGF_ID;
      Fcds_ArtHdr['Version']:=-1;
      Fcds_ArtHdr['Current_Department']:=Department;
      Fcds_ArtHdr['Operator']:=Creator;
      Fcds_ArtHdr['Operate_Time']:= TGlobal.GetServerTime; //Now; cuijf 2008-6-12
      Fcds_ArtHdr['Is_Active']:=true;

      //取已经存在的通用的工艺要求
      FNMServerArtObj.GetArtItemInfo(OrgGF_ID, vData, sErrorMsg);
      if sErrorMsg <> '' then
        raise ExceptionEx.CreateResFmt(@ERR_GetArtItemInfo, [sErrorMsg]);

      TempClientDataSet.Data:=vData;
      if not TempClientDataSet.IsEmpty then
      begin
        Fcds_ArtHdr['FN_Art_NO']:=TempClientDataSet['FN_Art_NO'];
        Fcds_ArtHdr['FN_Color_Code']:=TempClientDataSet['FN_Color_Code'];
        Fcds_ArtHdr['Shrinkage']:=TempClientDataSet['Shrinkage'];
        Fcds_ArtHdr['HandFeel']:=TempClientDataSet['HandFeel'];
        Fcds_ArtHdr['Product_Width']:=TempClientDataSet['Product_Width'];
      end
    end;

    //自动创建工艺步骤和参数
    FNMServerArtObj.AutoCreateStdArtDtl(IntToStr(OrgGF_ID), Department, vData, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_AutoCreateStdArtDtl, [sErrorMsg]);

    Fcds_ArtDtl.Data:=vData;
  except
    on e: Exception do
    begin
      Fcds_ArtHdr.Close;
      Fcds_ArtDtl.Close;
      ShowMessage(sErrorMsg);
    end;
  end;
  if Assigned(FOnAfterOpen) then FOnAfterOpen(Self);
  Modify:=false;
end;

procedure TSTDArtDtlInfo.CopyAExistSTDArt(StdArtID: Integer);
var
  MessResult: Integer;
  sCondition, sErrorMsg: WideString;
  vData:OleVariant;
begin
  //工艺没打开不能拷贝
  if not Active then
    exit;

  if not Fcds_ArtDtl.IsEmpty then
  begin
    MessResult:= ShowMsgDialog(@MSG_ClearCurOperate, mtConfirmation);
    if MessResult <> mrOk then exit;
  end;
  sCondition := IntToStr(StdArtID)+','+QuotedStr('S');
  FNMServerObj.GetQueryData(vData,'ARTGetArtInfo',sCondition,sErrorMsg);
//  FNMServerArtObj.GetArtDtl(StdArtID, 'S', vDataHdr, vDataDtl, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetStdArtDtl, [sErrorMsg]);

  TempClientDataSet.Data:=vData[0];
  if TempClientDataSet.IsEmpty then
    raise Exception.CreateRes(@EMP_StdArtInfoDtlCantCopy);

  Fcds_ArtHdr.Edit;                                               
  //只拷贝工艺号

{
  Fcds_ArtHdr['FN_Art_NO']:=LeftStr(TempClientDataSet['FN_Art_NO'], 1);
  Fcds_ArtHdr['FN_Color_Code']:=TempClientDataSet['FN_Color_Code'];
  Fcds_ArtHdr['Shrinkage']:=TempClientDataSet['Shrinkage'];
  Fcds_ArtHdr['HandFeel']:=TempClientDataSet['HandFeel'];
  Fcds_ArtHdr['Product_Width']:=TempClientDataSet['Product_Width'];
  Fcds_ArtHdr['Material_Quality']:=TempClientDataSet['Material_Quality'];
}
  Fcds_ArtHdr['Remark']:=TempClientDataSet['Remark'];

  Fcds_ArtDtl.Data:=vData[1];

  if Assigned(FOnAfterOpen) then FOnAfterOpen(Self);
  Modify:=True;
end;

procedure TSTDArtDtlInfo.InitializeDepartmentMenuItem(MenuItem: TMenuItem; ClickEvent: TNotifyEvent);
var
  i: Integer;
  NewMenuItem: TMenuItem;
begin
  with Dictionary.cds_DepartmentList do
  try
    Filter:='Parent_Department = ' + '''FN''';
    Filtered:=true;
    for i := 0 to RecordCount - 1 do
    begin
      NewMenuItem:=TMenuItem.Create(MenuItem.Owner);
      NewMenuItem.Caption:=Trim(FieldByName('Description').AsString)+'工艺(&'+
                           RightStr(Trim(FieldByName('Department').AsString),1)+')';
      NewMenuItem.Tag:=FieldByName('Iden').AsInteger;
      NewMenuItem.OnClick:=ClickEvent;
      MenuItem.Add(NewMenuItem);
      Next;
    end;
  finally
    Filtered:=false;
  end;
end;

function TSTDArtDtlInfo.GetFeedbackInfo: OleVariant;
var
  sErrorMsg: WideString;
begin
  FNMServerArtObj.GetFeedbackInfo(Result, GF_ID,Current_Department, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetStdArtDtl, [sErrorMsg]);
end;

function TSTDArtDtlInfo.ViewArtDtl(Index: integer): string;
var
  Step_NO,ParamStr: String;
begin
  Step_NO := '';
  ParamStr := '';
  with Fcds_ArtDtl do
  begin
    Filtered := False;
    First;
    while not Eof do
    begin
      if Step_NO <> FieldByName('Step_NO').AsString then
      begin
        if  ParamStr<>'' then
          Result := Result + ParamStr;
        if (Result <> '')  then
          Result := Result + #10#13;
        Step_NO := FieldByName('Step_NO').AsString;
        ParamStr := '';
      end;
      if Trim(FieldByName('Item_Name').AsString) = '加工地点' then
      begin
        if StrToInt(Step_NO) < 9 then
          Step_NO := '0' + Step_NO;
         Result := Result + Step_NO + '【'+ FieldByName('Item_Value').AsString+'】'+ FieldByName('Operation_CHN').AsString + ': '
      end else
      begin
        if Index = 0 then
        begin
          if (Trim(FieldByName('Item_Value').AsString)<>'') then
            ParamStr := ParamStr + FieldByName('Item_Name').AsString +':' +FieldByName('Item_Value').AsString +'  ';
        end
        else if Index = 1 then
        begin
          if (Trim(FieldByName('Item_Value').AsString)='') then
            ParamStr := ParamStr + FieldByName('Item_Name').AsString +'  ';
        end
        else
          ParamStr := ParamStr + FieldByName('Item_Name').AsString +':' +FieldByName('Item_Value').AsString +'  ';
      end;
      Next;
    end;
    if  ParamStr<>'' then
      Result := Result + ParamStr;
  end;
end;

{TFactArtDtlInfo}
procedure TFactArtDtlInfo.SetFACT_Art_ID(FACT_Art_IDValue: Integer);
begin
  if FFACT_Art_ID = FACT_Art_IDValue then exit;
    
  if not CloseArt then exit;
  FFACT_Art_ID:=FACT_Art_IDValue;
end;

constructor TFactArtDtlInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  
  FInternal_Repair := False;
  FAsSTDArt := False;
  Fcds_JobTraceDtl:=TClientDataSet.Create(AOwner);
end;

destructor TFactArtDtlInfo.Destroy;
begin
  Fcds_JobTraceDtl.Destroy;
  inherited Destroy;
end;

procedure TFactArtDtlInfo.OpenFNArt;
var
  sCondition,sErrorMsg: WideString;
  vData: OleVariant;
begin
  if not CloseArt then exit;
  if FACT_Art_ID = -1 then
    raise Exception.CreateRes(@InvalidFACT_Art_ID);

  FCardList:='';

  sCondition := IntToStr(FACT_Art_ID)+','+QuotedStr('F');
  FNMServerObj.GetQueryData(vData,'ARTGetArtInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetFactArtDtl, [sErrorMsg]);

  Fcds_ArtHdr.Data:=vData[0];
  Fcds_ArtDtl.Data:=vData[1];
  //luwel
  org_Fcds_ArtDtl := Fcds_ArtDtl;

  if Fcds_ArtHdr.IsEmpty then
  begin
    CloseArt;
    raise Exception.CreateRes(@FactArtEmpty);
  end;

  if Assigned(FOnAfterOpen) then FOnAfterOpen(Self);

  Modify:=false;
end;

function TFactArtDtlInfo.SaveArtToDataBase: Boolean;
var
  sJobIden,sJobStepNO, sErrorMsg: WideString;
  vDataParam: Variant;
  i: Integer;
  CurStepNO:Integer;
  OperationListt: string;
begin
  result := True;
  if (not Active) or (not Modify) or IsEmpty then exit;
  if Assigned(FOnBeforeSave) then FOnBeforeSave(Self);
  if FCardList = '' then
    raise Exception.Create('WAR_工艺卡号数据出错,请联系程序员');

  if (not Internal_Repair) and (RepairSteps <> '') and (RepairReason = '') then
    raise Exception.Create('WAR_工艺自定回修工序时,请选择回修原因');

  OperationListt:='';
  CurStepNO:=1;
  while Fcds_ArtDtl.Locate('Step_NO', CurStepNO, []) do
  begin
    OperationListt:=OperationListt + Fcds_ArtDtl.FieldByName('Operation_Code').AsString + ',';
    Inc(CurStepNO)
  end;

  //判断工序步骤是否违反禁忌
  FNMServerArtObj.GetCheckSpecialArt(GF_ID, Pos('F', FCardList), OperationListt, Login.CurrentDepartment, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetCheckSpecialArt, [sErrorMsg]);

  //参数
  sJobIden :='';
  sJobStepNO := '';
  with Fcds_JobTraceDtl do
  for I := 0 to RecordCount - 1 do
  begin
    sJobIden := sJobIden + Fcds_JobTraceDtl.FieldByName('Iden').AsString + ',';
    sJobStepNO := sJobStepNO + Fcds_JobTraceDtl.FieldByName('Step_NO').AsString + ',';
    next;
  end;
  vDataParam := VarArrayOf([Login.LoginName,
                            CardList,
                            RepairSteps,
                            IfThen(Internal_Repair,'1','0'),
                            RepairReason,
                            sJobIden,
                            sJobStepNO,
                            IfThen(AsStdArt,'1','0')]);
  //保存工艺
   FNMServerArtObj.SaveFactArt(Fcds_ArtHdr.Data, Fcds_ArtDtl.Data, vDataParam, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveFactArtData, [sErrorMsg]);

  //合并数据集合
  Fcds_ArtHdr.MergeChangeLog;
  Fcds_ArtDtl.MergeChangeLog;

  result:=true;
  FRepairReason:='';
  FInternal_Repair:=False;
  FAsSTDArt := False;
  if Assigned(FOnAfterSave) then FOnAfterSave(Self);
  Modify:=false;
  ShowMsgDialog(@MSG_SaveFactArtDtlInfoSuccess, mtInformation);
end;

function TFactArtDtlInfo.GetJobTraceDtlInfo(SelectCardList: String;
  SelectStepNO: Integer): Boolean;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  FNMServerArtObj.GetUnFinishJobTraceDtl(SelectCardList, SelectStepNO, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetUnFinishJobTraceDtl, [sErrorMsg]);

  Fcds_JobTraceDtl.Data:= vData;
  result := True;
end;

procedure TFactArtDtlInfo.UpdateAStepNO(OldStepNO: Integer;
  OperateOffset: TOperateOffset);
var
  i: Integer;
begin
  with Fcds_JobTraceDtl do
    if (not Active) or (IsEmpty) then exit;

  with Fcds_JobTraceDtl do
  case OperateOffset of
    ooMoveUP:
    begin
      First;
      for I := 0 to RecordCount - 1 do
      begin
        Edit;
        if Fcds_JobTraceDtl['Step_NO'] = OldStepNO then
        begin
          Edit;
          Fcds_JobTraceDtl['Step_NO'] := OldStepNO - 1;
        end
        else if Fcds_JobTraceDtl['Step_NO'] = OldStepNO - 1 then
        begin
          Edit;
          Fcds_JobTraceDtl['Step_NO'] := OldStepNO;
        end;
        Next;
      end;
    end;

    ooMoveDown:
    begin
      First;
      for I := 0 to RecordCount - 1 do
      begin
        if Fcds_JobTraceDtl['Step_NO'] = OldStepNO then
        begin
          Edit;
          Fcds_JobTraceDtl['Step_NO'] := OldStepNO + 1
        end
        else if Fcds_JobTraceDtl['Step_NO'] = OldStepNO + 1 then
        begin
          Edit;
          Fcds_JobTraceDtl['Step_NO'] := OldStepNO;
        end;
        Next;
      end;
    end;
    
    ooDelete:
    begin
      Last;
      for I := RecordCount - 1 downto 0 do
      begin
        if Fcds_JobTraceDtl['Step_NO'] = OldStepNO then
        begin
          Edit;
          Fcds_JobTraceDtl['Step_NO'] :=  -1;
        end
        else if Fcds_JobTraceDtl['Step_NO'] > OldStepNO then
        begin
          Edit;
          Fcds_JobTraceDtl['Step_NO'] := Fcds_JobTraceDtl['Step_NO'] - 1;
        end;
        Next;
      end
    end;
  end;
  
  Fcds_JobTraceDtl.MergeChangeLog;
end;

function TFactArtDtlInfo.GetRepairSteps: String;
begin
  Result:='';
  Fcds_ArtDtl.Filter:='OrgStep_NO IS NULL AND NOT(Operation_CHN LIKE ''%复版'')';
  Fcds_ArtDtl.Filtered:=True;
  try

    if Fcds_ArtDtl.RecordCount <> 0 then
    begin
      Fcds_ArtDtl.Filter:='OrgStep_NO IS NULL';
      Result:=GetOperations;
    end;
  finally
    Fcds_ArtDtl.Filter:='';
    Fcds_ArtDtl.Filtered:=False;
  end;
end;

{TRepairArtDtlInfo}
procedure TRepairArtDtlInfo.CreateRepairArt(RepairIden, GF_ID: Integer; SelectCard: string; CurrentDeparment, Operator: String);
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  if not CloseArt then exit;

  sCondition := IntToStr(RepairIden)+','+IntToStr(GF_ID)+','+ QuotedStr(SelectCard)+','+ QuotedStr(CurrentDeparment)+','+ QuotedStr(Operator);
  FNMServerObj.GetQueryData(vData,'ARTCreateRepairArtInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetStdArtDtl, [sErrorMsg]);

  Fcds_ArtHdr.Data:=vData[0];
  Fcds_ArtDtl.Data:=vData[1];

  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetUnFinishJobTraceDtl, [sErrorMsg]);

  if IsEmpty then
  begin
    CloseArt;
    raise Exception.CreateRes(@EMP_STDArt);
  end;

  CardList:='';
  if Assigned(FOnAfterOpen) then FOnAfterOpen(Self);
  Modify:=false;
end;

function TRepairArtDtlInfo.SaveArtToDataBase(IsQualityOperator:Boolean; RepairIden :Integer; GF_ID:Integer; Quantity: Double; Repair_Code,Current_Department,Operator :string) : Boolean;
var
  vData: OleVariant;
  QualityOperator,CurStepNO: Integer;
  OperationListt,sErrorMsg: WideString;
begin
  result := True;
  if (not Active) or (not Modify) or IsEmpty then exit;
  if Assigned(FOnBeforeSave) then FOnBeforeSave(Self);
  if CardList = '' then exit;
  if Pos(',', CardList) > 0 then
    CardList := Copy(CardList,1,Length(CardList)-1);

  OperationListt:='';
  CurStepNO:=1;
  while Fcds_ArtDtl.Locate('Step_NO', CurStepNO, []) do
  begin
    OperationListt:=OperationListt + Fcds_ArtDtl.FieldByName('Operation_Code').AsString + '/';
    Inc(CurStepNO)
  end;

  //判断工序步骤是否违反禁忌
  FNMServerArtObj.GetCheckSpecialArt(GF_ID, 1, OperationListt, Login.CurrentDepartment, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetCheckSpecialArt, [sErrorMsg]);

  if OperationListt = '' then exit;
  QualityOperator := 0;
  if IsQualityOperator then
    QualityOperator := 1;
  vData := VarArrayCreate([0, 1], VarVariant);
  vData[0] := varArrayOf([QualityOperator,
                          RepairIden,
                          GF_ID,
                          Quantity,
                          CardList,
                          Repair_Code,
                          1,
                          OperationListt,
                          Current_Department,
                          Operator]); 
  Fcds_ArtHdr.MergeChangeLog;
  Fcds_ArtDtl.MergeChangeLog;

  //保存数据
  FNMServerArtObj.SaveRepairArt(vData,Fcds_ArtHdr.Data, Fcds_ArtDtl.Data, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveRepairArtData, [sErrorMsg]);
  // David Cao add for 42677 制定回修工艺 IsQualityOperator 质量员给定工序后自动生成工艺
  if IsQualityOperator then
    FNMServerObj.SaveDataBySQL('AutoGeneRepairParas',QuotedStr(CardList), sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveRepairArtData, [sErrorMsg]);
  if Assigned(FOnAfterSave) then FOnAfterSave(Self);
  result:=true;
  Modify:=false;
  ShowMsgDialog(@MSG_SaveRepairArtDtlSuccess, mtInformation);
end;

{ THLArtDtlInfo }

procedure THLArtDtlInfo.CreateHLArt(FN_ID, FN_NO, Creator: String);
begin
  if not CloseArt then exit;

  //构造主表字段
  with Fcds_ArtHdr do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('FN_ID',              ftString, 9);
    FieldDefs.Add('FN_NO',              ftString, 9);
    FieldDefs.Add('Art_ID',             ftInteger);
    FieldDefs.Add('FN_Art_NO',          ftString, 10);
    FieldDefs.Add('Art_Type',           ftString, 1);
    FieldDefs.Add('Material_Quality',   ftString, 10);
    FieldDefs.Add('Operator',           ftString, 20);
    FieldDefs.Add('Operate_Time',       ftDateTime);
    FieldDefs.Add('Remark',             ftString, 150);
    CreateDataSet;
    Fcds_ArtHdr.AppendRecord([FN_ID, FN_NO, nil, nil, 'H', '手织版', Creator, TGlobal.GetServerTime, nil]);
  end;

  //构造从表字段
  with Fcds_ArtDtl do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('Step_NO',        ftSmallint);
    FieldDefs.Add('EditStep_NO',    ftSmallint);
    FieldDefs.Add('Operation_Code', ftString, 3);
    FieldDefs.Add('Operation_CHN',  ftString, 20);
    FieldDefs.Add('Item_Name',      ftString, 10);
    FieldDefs.Add('Item_Value',     ftString, 50);
    FieldDefs.Add('Operator',       ftString, 20);
    FieldDefs.Add('Operate_Time',   ftDateTime);
    FieldDefs.Add('OrgStep_NO',     ftSmallint);
    CreateDataSet;
  end;

  if Assigned(FOnAfterOpen) then FOnAfterOpen(Self);
  Modify:=true;
end;

function THLArtDtlInfo.SaveArtToDataBase: Boolean;
var
  vDataDtl: OleVariant;
  sErrorMsg: WideString;
begin
  result := True;
  if (not Active) or (not Modify) or IsEmpty then exit;
  if Assigned(FOnBeforeSave) then FOnBeforeSave(Self);

  Fcds_ArtHdr.MergeChangeLog;
  Fcds_ArtDtl.MergeChangeLog;

  //保存数据
  vDataDtl:=Fcds_ArtDtl.Data;
  FNMServerArtObj.SaveHLArtInfo(Login.CurrentDepartment, Fcds_ArtHdr.Data, vDataDtl, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveHLArtInfo, [sErrorMsg]);

  TempClientDataSet.Data:=vDataDtl;
  Fcds_ArtHdr.Edit;
  Fcds_ArtHdr['Art_ID']:=TempClientDataSet['Fact_Art_ID'];
  
  result:=true;
  Modify:=false;
  if Assigned(FOnAfterSave) then FOnAfterSave(Self);
  ShowMsgDialog(@MSG_SaveHLArtInfoSuccess, mtInformation);
end;

end.

