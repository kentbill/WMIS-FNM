unit frmReceiveInfo;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmReceiveInfo.pas                                            }
{       创建日期 2004-8-11 11:03:22                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{                0 usp_GetRecieveInfo  获取未接收的坯布信息                    }
{                1 usp_SaveReceiveInfo 保存坯布信心                            }
{       功能描述 0 从坯布车间接收坯布                                          }
{                1 从成品车间接收回修布                                        }
{                2 从对方后整车间或外发厂家接收半成品布                        }
{******************************************************************************}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, ExtCtrls, ComCtrls, Buttons, DB, DBClient,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, StrUtils,
  CheckLst, cxDropDownEdit, Grids, DBGrids, Math, OleCtrls, GFCADLib_TLB,
  cxSplitter, FileCtrl;

type
  TReceiveInfoForm = class(TBaseForm)
    dsReceiveInfo: TDataSource;
    cdsReceiveInfo: TClientDataSet;
    pnlClient: TPanel;
    pnl1: TPanel;
    btnSave: TButton;
    btnCancel: TButton;
    btnClose: TButton;
    cdsPublic: TClientDataSet;
    lbl2: TLabel;
    lblNote_NO: TLabel;
    cbbNormal: TComboBox;
    cbbNoteNO: TComboBox;
    cxgridReceiveInfo: TcxGrid;
    cxgridtvReceiveInfo: TcxGridDBTableView;
    cxGridl2: TcxGridLevel;
    btnQuery: TButton;
    btnLoadFromFile: TButton;
    btnCancelIFI: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cbbNormalChange(Sender: TObject);
    procedure cbbNoteNOChange(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnLoadFromFileClick(Sender: TObject);
    function ReadFabricsFromFile:String;
    function GetTxtFromPDA:String;
    function GetNoteNoByBarcodeNo(const barcodeNo:string):string;
    function GetFabricNoByBarcodeNo(const barcodeNo:string):string;
    function SplitString(const Source,ch:String):TStringList;
    procedure btnCancelIFIClick(Sender: TObject);
  private
    { Private declarations }
{* -----------------------------------------------------------------------------
   过程名称 Initialize
   创建人员 zhangjy
   创建日期 2004-8-11 18:13:40
   参数列表 None
   返回值   None
   功能描述 窗体初始化
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure ClearScreen;
    procedure Initialize;
{* -----------------------------------------------------------------------------
   过程名称 GetData
   创建人员 zhangjy
   创建日期 2004-8-12 14:42:09
   参数列表 None
   返回值   None
   功能描述
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure GetReceiveInfo();
    procedure GetData;
{* -----------------------------------------------------------------------------
   过程名称 SaveData
   创建人员 zhangjy
   创建日期 2004-8-12 14:42:16
   参数列表 None
   返回值   None
   功能描述
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure SaveReceiveInfo();
    procedure SaveData;
{* -----------------------------------------------------------------------------
   过程名称 CancelData
   创建人员 zhangjy
   创建日期 2004-8-11 18:14:15
   参数列表 None
   返回值   None
   功能描述 取消收坯信心
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure CancelReceiveInfo;
    procedure CancelData;

  public
    { Public declarations }
{* -----------------------------------------------------------------------------
   过程名称 PublicQuery ;PublicExport; PublicSave
   创建人员 zhangjy
   创建日期 2004-8-31 15:41:59
   参数列表 None
   返回值   None
   功能描述 响应TOOLBAR相应的事件
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}

    procedure PublicQuery; override;
    procedure PublicExport; override;
    procedure PublicSave; override;
  end;

var
  ReceiveInfoForm: TReceiveInfoForm;

implementation

uses ServerDllPub, uGlobal, frmMain, UShowMessage, uLogin, uGridDecorator,
  uAppOption, uDictionary, ComDllPub, frmModifyCarNoAndLocationNo;


{$R *.dfm}

procedure TReceiveInfoForm.PublicQuery;
begin
  GetData;
end;

procedure TReceiveInfoForm.PublicExport;
begin
  TGlobal.SaveDataToFile(cdsReceiveInfo, sftXLS)
end;

procedure TReceiveInfoForm.PublicSave;
begin
  SaveData;
end;

procedure TReceiveInfoForm.Initialize;
begin

// 坯布来源
  Dictionary.cds_MaterialFlowList.Filtered := False;
  Dictionary.cds_MaterialFlowList.Filter := 'Current_Department=' + QuotedStr(Login.CurrentDepartment) + ' AND Flow_Description=' + QuotedStr('坯布来源');
  Dictionary.cds_MaterialFlowList.Filtered := True;
  TGlobal.FillItemsFromDataSet(Dictionary.cds_MaterialFlowList, 'Relation_Department', 'Relation_Department_CHN', '->',cbbNormal.Items);
//
  ClearScreen();
end;

procedure TReceiveInfoForm.GetReceiveInfo();
var vData: OleVariant;
    sCondition,sNote_NO, sType, sErrorMsg: WideString;
begin
  try
    ShowMsg('正在查询数据稍等！', crHourGlass);
     if not TGlobal.CheckValueLength(cbbNoteNO.Text, 12) then
    begin
      TMsgDialog.ShowMsgDialog('请检查你所输入的' + lblNote_NO.Caption + '的长度是否为12位',mtWarning);
      Exit;
    end;
    sNote_NO := Trim(cbbNoteNO.Text);
    sType := LeftStr(cbbNormal.Text,2);
    sCondition :=QuotedStr(sNote_NO)+','+QuotedStr(Login.CurrentDepartment)+','+QuotedStr(sType);
    FNMServerObj.GetQueryData(vData,'GetReciveInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsReceiveInfo.Data := vData;
    if cdsReceiveInfo.RecordCount = 0 then
    begin
      TMsgDialog.ShowMsgDialog('请检查你所输入的' + lblNote_NO.Caption,mtWarning);
      Exit;
    end;
      //填充cxGrid
    GridDecorator.BindCxViewWithDataSource(cxgridtvReceiveInfo, dsReceiveInfo,True);
    GridDecorator.AddFooter(cxgridtvReceiveInfo,['Quantity','Fabric_No'],[skSum,skCount]);
    btnSave.Enabled := not cdsReceiveInfo.IsEmpty;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TReceiveInfoForm.GetData;
begin
  GetReceiveInfo;
end;

procedure TReceiveInfoForm.SaveReceiveInfo;
var
  sCondition,sType, sNote_NO: WideString;
  sErrorMsg: WideString;
  sCarNo,sLocaionNo:string;
begin
  try
    if (Pos('FG',cbbNormal.Text) > 0) OR (Pos('FA',cbbNormal.Text) > 0) then
    begin
      // Modified by WuDev 2016/9/6 16:40:52 增加地位号输入
      //sCarNo := InputBox('修改车号','新车号:','');
      if not Assigned(frmModifyCarNoAndLocationNo.ModifyCarNoAndLocationNoForm) then
        frmModifyCarNoAndLocationNo.ModifyCarNoAndLocationNoForm:= TModifyCarNoAndLocationNoForm.Create(Self);
      ModifyCarNoAndLocationNoForm.Init(cdsReceiveInfo.fieldByName('Car_No').AsString);
      if  ModifyCarNoAndLocationNoForm.ShowModal = MrOK then
      begin
        sCarNo:= ModifyCarNoAndLocationNoForm.CarNo;
        sLocaionNo:= ModifyCarNoAndLocationNoForm.LocationNo;
        ModifyCarNoAndLocationNoForm.Clear;
      end;
      frmModifyCarNoAndLocationNo.ModifyCarNoAndLocationNoForm.Free;
      frmModifyCarNoAndLocationNo.ModifyCarNoAndLocationNoForm:= nil;
    end;

    ShowMsg('正在保存数据稍等！', crHourGlass);
    sNote_NO := Trim(cbbNoteNO.Text);
    sType := LeftStr(cbbNormal.Text, 2);
    sCondition := QuotedStr(sNote_NO)+','+ QuotedStr(Login.CurrentDepartment)+','+QuotedStr(Login.LoginName)+
                  ','+ QuotedStr(sType) + ',' + QuotedStr(sCarNo) + ',' + QuotedStr(sLocaionNo);
    FNMServerObj.SaveDataBySQL('SaveReciveInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
    cbbNoteNO.DeleteSelected;
    cbbNoteNO.Text := '';
    cdsReceiveInfo.EmptyDataSet;
    btnSave.Enabled := False;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TReceiveInfoForm.SaveData;
begin
  SaveReceiveInfo;
end;

procedure TReceiveInfoForm.CancelReceiveInfo;
var
  sCondition,sNote_NO: WideString;
  sErrorMsg: WideString;
begin
  try
    ShowMsg('正在取消数据稍等！', crHourGlass);
    sNote_NO := InputBox('取消收布', '请输入要取消的对方的送布单号:', '');
    if Trim(sNote_NO) = '' then Exit;
    sCondition := QuotedStr(sNote_NO)+ ','+ QuotedStr(Login.LoginName)+','+QuotedStr('R');
    FNMServerObj.SaveDataBySQL('CancelFabricInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('取消数据成功', 2);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TReceiveInfoForm.CancelData;
begin
  CancelReceiveInfo;
end;

procedure TReceiveInfoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TReceiveInfoForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ReceiveInfoForm := nil;
end;

procedure TReceiveInfoForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize;
end;

procedure TReceiveInfoForm.btnSaveClick(Sender: TObject);
begin
  SaveData;
end;

procedure TReceiveInfoForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  CancelData;
end;

procedure TReceiveInfoForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;


procedure TReceiveInfoForm.cbbNormalChange(Sender: TObject);
var sType,sCode: string;
begin
  inherited;
  ClearScreen();
  sType := LeftStr(cbbNormal.Text,2);
  Dictionary.cds_MaterialFlowList.Filtered := False;
  // David add for w14008 回修布使用扫描枪扫描条形码 begin
  if sType = 'IN' then
  begin
     btnLoadFromFile.Visible := True;
     btnCancelIFI.Visible := True;
  end
  else
  begin
     btnLoadFromFile.Visible := False;
     btnCancelIFI.Visible := False;
  end;
  // David add for w14008 回修布使用扫描枪扫描条形码 end
  if Dictionary.cds_MaterialFlowList.Locate('Relation_Department',sType,[]) then
     sCode := Dictionary.cds_MaterialFlowList.FieldValues['Parent_Operation'];
  if sCode = 'GI' then
     sCode := '坯布车间';
  if sCode = 'FI' then
     sCode := '成品车间';
  if sCode = 'FN' then
     sCode := '后整车间';
  if sCode = 'FS' then
     sCode := '坯布仓';
  if sCode = 'OT' then
  begin
    cbbNoteNO.Style := csSimple;
    cbbNoteNO.OnChange := nil;
  end else
  begin
    cbbNoteNO.Items.Text := Dictionary.GetItemList(sCode,Login.CurrentDepartment,sType);
    //cbbNoteNO.Style := csDropDownList;
    cbbNoteNO.Style := csDropDown; 
    cbbNoteNO.OnChange := cbbNoteNOChange;
  end;
end;

procedure TReceiveInfoForm.ClearScreen();
begin
  cbbNoteNO.Clear;
  btnSave.Enabled := False;
  if cdsReceiveInfo.Active then
    cdsReceiveInfo.EmptyDataSet;
end;

procedure TReceiveInfoForm.cbbNoteNOChange(Sender: TObject);
begin
  inherited;
  //GetData;
end;

procedure TReceiveInfoForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  GetData;
end;
// David add for w14008 回修布使用扫描枪扫描条形码 begin
procedure TReceiveInfoForm.btnLoadFromFileClick(Sender: TObject);
var
  strCont:TStringList;
  i:Integer;
  SearchRec:TSearchRec;
  found:integer;
  dict:string;
  strFabricNOs, strNotAllInNoteNOs, strAllInNoteNOs:string;
  vData: OleVariant;
  sErrorMsg: WideString;
  cds: TClientDataSet;
  sNote_NO: string;
  sCondition, sType: string;
begin

  // 将strFabricNO传到存储过程, 存储过程返回数据集 Note_NO(单号), bAll_Fabrics_IN(0,没有全部；1，全部都扫入)
  try
    strFabricNOs := ReadFabricsFromFile;
    sCondition := QuotedStr(strFabricNOs)+','+ QuotedStr(Login.CurrentDepartment);
    FNMServerObj.GetQueryData(vData,'GetNoteNosStatusByFabricNOs', sCondition, sErrorMsg);
    cds := TClientDataSet.Create(nil);
    cds.Data := vData;
    strNotAllInNoteNOs := '';
    strAllInNoteNOs := '';
    with cds do
    begin
        while not eof do
        begin
          if FieldByName('bAll_Fabrics_IN').AsInteger = 0 then
             strNotAllInNoteNOs := strNotAllInNoteNOs + FieldByName('Note_NO').AsString+' '
          else
          begin
              ShowMsg('正在保存数据稍等！', crHourGlass);
              sNote_NO := FieldByName('Note_NO').AsString;
              sType := LeftStr(cbbNormal.Text, 2);
              sCondition := QuotedStr(sNote_NO)+','+ QuotedStr(Login.CurrentDepartment)+','+QuotedStr(Login.LoginName)+
                            ','+ QuotedStr(sType);
              FNMServerObj.SaveDataBySQL('SaveReciveInfo',sCondition,sErrorMsg);
              if sErrorMsg <> '' then
              begin
                TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
                Exit;
              end;
              strAllInNoteNOs := strAllInNoteNOs + FieldByName('Note_NO').AsString+' ';
              //TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
          end;
          Next;
        end;
    end;
    ShowMsg('', crDefault);
    if strNotAllInNoteNOs <> '' then
      TMsgDialog.ShowMsgDialog('单号：'+strNotAllInNoteNOs+'存在布号没有扫描，请检查',mtWarning);
    if strAllInNoteNOs <> '' then
      TMsgDialog.ShowMsgDialog('单号：'+strAllInNoteNOs+'已经保存',mtInformation);
    //cbbNormal.ItemIndex:=cbbNormal.ItemIndex;  //刷新数据
    //cdsReceiveInfo.EmptyDataSet; //清空列表的数据
  finally

  end


end;

function TReceiveInfoForm.GetTxtFromPDA:String;
var
  sPath:string;
begin
  sPath:='';
  Result:=sPath;
end;

function TReceiveInfoForm.ReadFabricsFromFile:String;
var
  strCont:TStringList;
  i:Integer;
  SearchRec:TSearchRec;
  found:integer;
  dict:string;
  FilePath: string;
  strFabricNOs, strNotAllInNoteNOs, strAllInNoteNOs:string;
  vData: OleVariant;
  sErrorMsg: WideString;
  cds: TClientDataSet;
  sNote_NO: string;
  sCondition, sType: string;
begin
  WinExec(PChar('LoadDataForm.exe ra'), SW_HIDE);
  TMsgDialog.ShowMsgDialog('系统正在导入数据，请稍后',mtWarning);
  WinExec('taskkill /F /IM LoadDataForm.exe',SW_HIDE);
  FilePath := ExtractFilePath(Application.ExeName)+'\';

  strFabricNOs := '';
  found:=FindFirst(FilePath+'\*.txt',faAnyFile,SearchRec);
  while found=0 do
  begin
    if (SearchRec.Name<>'.') and (SearchRec.Name<>'..')
         and    (SearchRec.Attr<>faDirectory)    then
    strCont := TStringList.Create;
    try
      strCont.LoadFromFile(FilePath + '\' + SearchRec.Name);
      for i := 0 to strCont.Count - 1 do
      begin
        strFabricNOs := strFabricNOs + LeftStr(strCont[i],12) + ',';
      end;
      DeleteFile(FilePath + '\' + SearchRec.Name);  // 删除所有txt文件
    finally

    end;
    found:=FindNext(SearchRec);
  end;
  FindClose(SearchRec);
  // 处理strCont，将读到的布号串起来： 'J4121531001,J4121531002'  , 并保存到strFabricNOs中

  Result := LeftStr(strFabricNOs, Length(strFabricNOs)-1); // 去掉最后一个逗号
end;

procedure TReceiveInfoForm.btnCancelIFIClick(Sender: TObject);
var
  strFabricNOs, sErrorMsg, sCondition,sNote_NO,strFabricNO,sBarcodeNO:WideString;
  fabricNOList:TStringList;
  i,cancelCount:Integer;
begin
  inherited;
    ShowMsg('正在取消数据稍等！', crHourGlass);
    strFabricNOs:=ReadFabricsFromFile;
    fabricNOList:=SplitString(strFabricNOs,',');
    //TMsgDialog.ShowMsgDialog('扫描文件共有'+IntToStr(fabricNOList.Count)+'条数据', 2);
    for i:=0 to fabricNOList.Count-1 do
      begin
        sNote_NO := GetNoteNoByBarcodeNo(fabricNOList[i]);
        strFabricNO:=GetFabricNoByBarcodeNo(fabricNOList[i]);
        if Trim(sNote_NO) = '' then continue;
//        sCondition := QuotedStr(sNote_NO)+ ','+ QuotedStr(Login.LoginName)+','+QuotedStr('R');
//        FNMServerObj.SaveDataBySQL('CancelFabricInfo',sCondition,sErrorMsg);
          sCondition := QuotedStr(sNote_NO)+ ','+ QuotedStr(strFabricNO)+','+QuotedStr(Login.LoginName);
          FNMServerObj.SaveDataBySQL('CancelFIInfo',sCondition,sErrorMsg);
        if sErrorMsg <> '' then
        begin
          TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
          Exit;
        end
        else
          Inc(cancelCount);
      end;
    if fabricNOList.Count>0 then
      TMsgDialog.ShowMsgDialog(IntToStr(cancelCount)+'条数据取消数据成功', 2)
    else
      TMsgDialog.ShowMsgDialog('没有数据被取消，请检查扫描数据上传是否正确！', 2);
end;

function TReceiveInfoForm.SplitString(const Source,ch:String):TStringList;
var
  temp:String;
  i:Integer;
begin
  Result:=TStringList.Create;
  //如果是空自符串则返回空列表
  if Source=''
  then exit;
  temp:=Source;
  i:=pos(ch,Source);
  while i<>0 do
  begin
  Result.add(copy(temp,0,i-1));
  Delete(temp,1,i);
  i:=pos(ch,temp);
  end;
  Result.add(temp);
end;

function TReceiveInfoForm.GetNoteNoByBarcodeNo(const barcodeNo:string):string;
var
  sql,sFabricNo,sNoteNo,sErrorMsg,sCondition,Condition:WideString;
  vData: OleVariant;
  cds1,cds2: TClientDataSet;
begin
  cds1:=TClientDataSet.Create(nil);
  cds2:=TClientDataSet.Create(nil);
  sql:='Exec QCMDb.Dbo.Usp_fiGetUnionFindInfoDtl_ByFNM ''1'',''1'',''D.Bar_code='''''+barcodeNo+''''''',''ALL''';
  FNMServerObj.GetQueryBySQL(vData,sql,sErrorMsg);
  if  sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
  cds1.Data:=vData ;
  if cds1.RecordCount>0 then
    begin
      cds1.First ;
      sFabricNo:=cds1.fieldbyname('Fabric_NO').AsString;
    end
  else
    sFabricNo:='';

  if sFabricNo<>'' then
    begin
      Condition:='Fabric_NO='''+sFabricNo+''' ';
      sCondition := QuotedStr(Login.CurrentDepartment)+','+ QuotedStr(Condition)+','+IntToStr(1);
      FNMServerObj.GetQueryData(vData,'GetPrintFNCardInfo',sCondition,sErrorMsg);
      if  sErrorMsg<>'' then
        begin
          TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
          Exit;
        end;
      cds2.Data:=vData ;

      if cds2.RecordCount>0 then
        begin
          cds2.first;
          sNoteNo:=cds2.fieldbyname('Note_NO').AsString;
        end
      else
        sNoteNo:='';
    end
  else
    sNoteNo:='';

  Result:=sNoteNo;
end;

function TReceiveInfoForm.GetFabricNoByBarcodeNo(const barcodeNo:string):string;
var
  sql,sFabricNo,sNoteNo,sErrorMsg,sCondition,Condition:WideString;
  vData: OleVariant;
  cds1: TClientDataSet;
begin
  cds1:=TClientDataSet.Create(nil);
  sql:='Exec QCMDb.Dbo.Usp_fiGetUnionFindInfoDtl_ByFNM ''1'',''1'',''D.Bar_code='''''+barcodeNo+''''''',''ALL''';
  FNMServerObj.GetQueryBySQL(vData,sql,sErrorMsg);
  if  sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
  cds1.Data:=vData ;
  if cds1.RecordCount>0 then
    begin
      cds1.First ;
      sFabricNo:=cds1.fieldbyname('Fabric_NO').AsString;
    end
  else
    sFabricNo:='';

  Result:=sFabricNo;
end;

// David add for w14008 回修布使用扫描枪扫描条形码 end
end.
