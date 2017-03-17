{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� uFinishArtInfo.pas                                            }
{       �������� 2004-8-23 ���� 10:18:23                                       }
{       ������Ա lvzd, zhangjy                                                 }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       �������� �������ջ���,��׼������,ʵ�ʹ�����,����������,CAD��Ϣ��,    }
{                 ��ȡ��������ֵ亯��.                                        }
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
    function  GetCADInfo: TClientDataSet;                                       //ȡ
    function  GetWebInfo: WideString;                                           //ȡͼ����Ϣ

    procedure OpenCADInfo;
    procedure CloseCADInfo;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    Property WebInfo: WideString read GetWebInfo;                               //�����ַ���
  published
    property GF_ID: Integer read FGF_ID write SetGF_ID;                         //Ʒ������
    property GF_NO: String read FGF_NO write SetGF_NO;                          //Ʒ��
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
    function  GetDataChange: Boolean;                                                         //�жϹ����Ƿ��޸�
    function  GetActive: Boolean;                                                             //�ж����ݼ����Ƿ��Ѵ�

    procedure SetAOperateEditStep_NOValue(OldKeyValue, NewKeyValue: Integer);                 //����Step_no����EditStep_no��ֵ.
    procedure MergeStep_NOValue;                                                              //ʹĳ�����ֶε�ֵ���
    function  GetAOperateDispText(Step_NO :Integer; OldText: String): String;                 //��ȡ������ʾ�ַ���
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    procedure OpenFNArt; virtual;                                                              //�򿪹���
    procedure CloseFNArt;                                                                      //�رչ���
    function  SaveArtToDataBase: Boolean; virtual;                                             //���湤��
    function  SaveArtToLocal: Boolean;                                                         //���湤�յ�����
    function  IsEmpty: Boolean;                                                                //�жϱ�׼���������Ƿ�Ϊ��
    procedure InitializeDepartmentMenuItem(MenuItem: TMenuItem; ClickEvent: TNotifyEvent);     //��ʹ�����տ�������ѡ��˵�
    function  AddAOperateStep(Operate_ID: Integer): Integer;                                   //׷��һ��������
    procedure MoveAOperateStep(Step_NO: Integer; OperateOffset: TOperateOffset);               //ɾ��һ���������ʹĳ������Ĳ����1��1
    procedure SetAOperateParameterValue(Step_NO :Integer; Item_Name, Item_Value: String);      //����ĳ�������ĳ��������ֵ
    procedure FillOperationToAListControls(AItem: TStrings);                                   //��乤�������б���
    procedure FillParameterToAListControls(Step_NO: Integer; AItem: TStrings);                 //���������б���
    procedure SetEditStyle(AValueListEditor: TValueListEditor);                                //���ù��ղ����༭���ı༭��ʽ
    procedure GetPickListString(Const KeyName: String; Values: TStrings);                      //��ȡ�����б���б�ѡ��
  published
    property AfterEdit: TDataSetNotifyEvent read FAfterEdit write SetAfterEdit;
    property BeforeSave: TNotifyEvent read FBeforeSave write FBeforeSave;
    property AfterSave: TNotifyEvent read FAfterSave write FAfterSave;
    property AfterOpen: TNotifyEvent read FAfterOpen write FAfterOpen;

    property DataChange: Boolean read GetDataChange;                                           //�����Ƿ��޸�
    property GF_ID: Integer read FGF_ID write SetGF_ID;                                        //Ʒ������
    property GF_NO: String read FGF_NO write SetGF_NO;                                         //Ʒ��
    property Active: Boolean read GetActive write SetActive;                                   //�����Ƿ��
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

    procedure OpenFNArt; override;                                                             //�򿪹���
    function  SaveArtToDataBase: Boolean; override;                                            //���湤�յ����ݿ�
    procedure CreateStdArt(Department, Creator: String);                                       //������׼����
    procedure CopyAExistSTDArt(GF_ID: Integer; GF_NO: String; DepartmentTag: Integer);         //������׼����
  published
    property AfterEdit;
    property BeforeSave;
    property AfterSave;
    property AfterOpen;

    property GF_ID;                                                                             //Ʒ������
    property GF_NO;                                                                             //Ʒ��
    property STDArt_ID: Integer read FSTDArt_ID;                                                //���ձ��
    property Department: String read FDepartment write SetDepartment;                           //��׼���ղ���
  end;

{TFactArtDtlInfo}
  TFactArtDtlInfo=Class(TArtDtlInfo)
  Private
    FFACT_Art_ID: Integer;

    procedure SetFACT_Art_ID(FACT_Art_IDValue: Integer);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    procedure OpenFNArt; override;                                                             //�򿪹���
    function  SaveArtToDataBase: Boolean; override;                                            //���湤�յ����ݿ�
  published
    property AfterEdit;
    property BeforeSave;
    property AfterSave;
    property AfterOpen;

    property GF_ID;                                                                            //Ʒ������
    property GF_NO;                                                                            //Ʒ��
    property FACT_Art_ID: Integer read FFACT_Art_ID write SetFACT_Art_ID;                      //Ʒ������
  end;

{TRepairArtDtlInfo}
  TRepairArtDtlInfo=Class(TArtDtlInfo)
  Private
    FRepair_Art_ID: Integer;

    procedure SetRepair_Art_ID(Repair_Art_IDValue: Integer);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    procedure OpenFNArt; override;                                                             //�򿪹���
    function  SaveArtToDataBase: Boolean; override;                                            //���湤�յ����ݿ�
  published
    property AfterEdit;
    property BeforeSave;
    property AfterSave;
    property AfterOpen;

    property GF_ID;                                                                            //Ʒ������
    property GF_NO;                                                                            //Ʒ��
    property Repair_Art_ID: Integer read FRepair_Art_ID write SetRepair_Art_ID;                //Ʒ������
  end;

function Getcds_ColorList: TClientDataSet;                                                     //��ȡ��ɫ�ֵ�����ݼ�
function Getcds_OperationList: TClientDataSet;                                                 //��ȡ�����ֵ�����ݼ�
function Getcds_DepartmentList: TClientDataSet;                                                //��ȡ�����ֲ��ֵ�����ݼ�
function Getcds_ArtDescriptionList: TClientDataSet;                                            //��ȡ�������մ����ֵ�����ݼ�
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
  //ȡ�����ֵ�
  result := nil;
  try
    if cds_OperationList = nil then
    begin
      FNMServerArtObj.GetOperationList(vData, sErrorMsg);
      if sErrorMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog('��������ֵ��ȡʧ�ܣ�'+sErrorMsg,2500);
        exit;
      end;
      
      cds_OperationList:=TClientDataSet.Create(nil);
      cds_OperationList.Data:=vData;
    end;

    result:= cds_OperationList
  except
    TMsgDialog.ShowMsgDialog('��������ֵ��ȡʧ�ܣ�',2500);
  end;
end;

function Getcds_DepartmentList: TClientDataSet;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  //ȡ�����ֵ�
  result := nil;
  try
    if cds_DepartmentList = nil then
    begin
      FNMServerArtObj.GetSubsectionList(vData, sErrorMsg);
      if sErrorMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog('������ֳ��ֵ��ȡʧ�ܣ�'+sErrorMsg,2500);
        exit;
      end;

      cds_DepartmentList:=TClientDataSet.Create(nil);
      cds_DepartmentList.Data:=vData;
    end;

    result:=cds_DepartmentList;
  except
    TMsgDialog.ShowMsgDialog('������ֳ��ֵ��ȡʧ�ܣ�',2500);
  end;
end;

function Getcds_ColorList: TClientDataSet;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  //ȡ��������ɫ�ֵ�
  result := nil;
  try
    if cds_ColorList = nil then
    begin
      FNMServerArtObj.GetColorList(vData, sErrorMsg);
      if sErrorMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog('��ɫ�ֵ��ȡʧ�ܣ�'+sErrorMsg,2500);
        exit;
      end;

      cds_ColorList:=TClientDataSet.Create(nil);
      cds_ColorList.Data:=vData;
    end;

    result:=cds_ColorList;
  except
    TMsgDialog.ShowMsgDialog('��������ֵ��ȡʧ�ܣ�',2500);
  end;
end;

function Getcds_ArtDescriptionList: TClientDataSet;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  //ȡ�������մ����ֵ�
  result := nil;
  try
    if cds_ArtDescriptionList = nil then
    begin
      FNMServerArtObj.GetArtDescriptionList(vData, sErrorMsg);
      if sErrorMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog('��ɫ�ֵ��ȡʧ�ܣ�'+sErrorMsg,2500);
        exit;
      end;

      cds_ArtDescriptionList:=TClientDataSet.Create(nil);
      cds_ArtDescriptionList.Data:=vData;
    end;

    result:=cds_ArtDescriptionList
  except
    TMsgDialog.ShowMsgDialog('��������ֵ��ȡʧ�ܣ�',2500);
  end;
end;

procedure FillItemsFromDataSet(cds: TClientDataSet; FirstField, SecondField, KeyField, LinkSymbol: string; TheItems: TStrings);
var
  ItemValue: String;
  i, KeyValue: Integer;
begin
//��������
//cds: ����Դ
//FirstField, SecondField: ��Ҫ����Items���ַ����ֶ�
//KeyField: ����Ϊ�����ֶ�,���뵽Objects�б���.
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
    TMsgDialog.ShowMsgDialog('ȡCAD��Ϣ���ݳ���,����ϵ����Ա��',2500);
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
      TMsgDialog.ShowMsgDialog('ȡCAD��Ϣ���ݳ���,����ϵ����Ա��',2500);
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
  //�ж��û��Ƿ񱣴��˹��գ�û�б���ѯ���û���
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
{$MESSAGE 'SaveArtToLocal:����û���'}
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
    NewMenuItem.Caption:=Trim(Temp_cds.FieldByName('Description').AsString)+'����(&'+
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
      TMsgDialog.ShowMsgDialog('�����ų���.����ϵ����Ա��',2500);

    //׷�Ӿ������.
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
    if Trim(AValueListEditor.Cells[0,i]) = '����' then
      AValueListEditor.ItemProps[i-1].EditStyle:=esPickList;
//    if Trim(AValueListEditor.Cells[0,i]) = '����' then
//      AValueListEditor.ItemProps[i-1].EditStyle:=esPickList;
  end;
end;

procedure TArtDtlInfo.GetPickListString(Const KeyName: String; Values: TStrings);
begin
  if Trim(KeyName) = '����' then
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
      TMsgDialog.ShowMsgDialog('ȡ����������Ϣ,ȱ�ٲ�����Ϣ��'+#13+sErrorMsg,2500);
      exit;
    end;

    FNMServerArtObj.GetStdArtDtl(FGF_ID, FGF_NO, Department, vDataHdr, vDataDtl, vDataTemp, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog('ȡ����������Ϣ����,����ϵ����Ա��'+#13+sErrorMsg,2500);
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
    TMsgDialog.ShowMsgDialog('��׼���ջ�ȡ����,����ϵ����Ա��',2500);
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
  //����û�򿪲��ܿ�����������ݲ�Ϊ�ղ��ܿ���
  if (not Active) or (not Fcds_ArtDtl.IsEmpty)then
    exit;

  //ȡ�������ն������������
  if cds_DepartmentList.Locate('Iden', DepartmentTag, []) then
    Department:=cds_DepartmentList.FieldByName('Department').AsString;

  //��ʼ����
{$MESSAGE 'CopyAExistSTDArt:����û���'}
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
      TMsgDialog.ShowMsgDialog('ʵ�ʹ��ձ��Ϊ��'+#13+sErrorMsg,2500);
      exit;
    end;

    FNMServerArtObj.GetFactArtDtl(FFACT_Art_ID, vDataHdr, vDataDtl, vDataTemp, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog('ȡ����������Ϣ����,����ϵ����Ա��'+#13+sErrorMsg,2500);
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
    TMsgDialog.ShowMsgDialog('ʵ�ʹ��ջ�ȡ����,����ϵ����Ա��',2500);
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
      TMsgDialog.ShowMsgDialog('ʵ�ʹ��ձ��Ϊ��'+#13+sErrorMsg,2500);
      exit;
    end;

    FNMServerArtObj.GetFactArtDtl(FRepair_Art_ID, vDataHdr, vDataDtl, vDataTemp, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog('ȡ����������Ϣ����,����ϵ����Ա��'+#13+sErrorMsg,2500);
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
    TMsgDialog.ShowMsgDialog('ʵ�ʹ��ջ�ȡ����,����ϵ����Ա��',2500);
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
