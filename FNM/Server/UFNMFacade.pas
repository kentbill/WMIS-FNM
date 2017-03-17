unit UFNMFacade;
{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ActiveX, Mtsobj, Mtx, ComObj, FNMFacade_TLB, StdVcl, ComDllPub, SysUtils,
  StrUtils, DBClient, DateUtils,Classes, Variants;

const
  DateTimeFmtStr = 'yyyy-mm-dd 07:00:00';

type
  TFNMFacadeLib = class(TMtsAutoObject, IFNMFacadeLib)
  protected
    function GetSql(sQueryType, sCondition: Widestring): Widestring;
    procedure GetQueryData(var vData: OleVariant; const sType,
      sCondition: WideString; var sErrorMsg: WideString); safecall;
    procedure GetMultiData(var vData0, vData1, vData2: OleVariant; const sType,
      sSQLText: WideString; var sErrorMsg: WideString); safecall;
    procedure SaveDataBySQL(const sType, sCondition: WideString;
      var sErrorMsg: WideString); safecall;
    procedure SaveDataBySQLEx(const sType, sCondition: WideString; var Result,
      sErrorMsg: WideString); safecall;

    procedure GetReceiveInfo(var vData: OleVariant; const sNote_NO,
      sCurrent_Department, sType: WideString; var sErrorMsg: WideString);
      safecall;
    procedure SaveReceiveInfo(const sNote_NO, sCurrent_Department, sOperator,
      sType: WideString; var sErrorMsg: WideString); safecall;
    procedure CancelFabricInfo(const sNote_NO, sOperator, sType: WideString;
      var sErrorMsg: WideString); safecall;
    procedure ServerTime(var currTime: OleVariant); safecall;
    procedure GetStockInfo(var vData: OleVariant; const sCondition: WideString;
      var sErrorMsg: WideString); safecall;
    procedure GetSendInfo(var vData0, vData1, vData2: OleVariant;
      const sNote_NO, sCurrent_Department: WideString; iType: Integer;
      var sErrorMsg: WideString); safecall;
    procedure SaveSendInfo(const sFNCardList, sDestination,
      sCurrent_Department, sOperator: WideString; iType: Integer;
      var sNote_NO, sErrorMsg: WideString); safecall;
    procedure GetPrintFNCardInfo(const sCurrent_Department,
      sCondition: WideString; iType: Integer; var vData: OleVariant;
      var sErrorMsg: WideString); safecall;
    procedure SavePrintFNCardInfo(const sFabric_NO_List, sCar_NO: WideString;
      bIs_CutCloth, bIs_RepairCard: Integer; const sOperator: WideString;
      var sFN_Card, sErrorMsg: WideString); safecall;
    procedure SaveSplitFabricInfo(const sFabric_NO: WideString;
      dSplit_Quantity: Double; const sCurrent_Department,
      sOperator: WideString; var sNew_Fabric_NO, sErrorMsg: WideString);
      safecall;
    procedure GetSplitFabricInfo(var vData: OleVariant; const sFabric_NO,
      sCurrent_Department: WideString; var sErrorMsg: WideString);
      safecall;
    procedure GetReportInfo(const sNote_NO: WideString; iType: Integer;
      const sCurrent_Department, sPrinter: WideString; var vData0, vData1,
      vData2: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveUnionFNCardInfo(const sFabric_NO_List, sFN_Card,
      sCar_NO: WideString; iType: Integer; const sReason,
      sCurrent_Department, sOperator: WideString; var sNew_FN_Card,
      sErrorMsg: WideString); safecall;
    procedure GetUnionFNCardInfo(var vData: OleVariant; const sFN_Card,
      sCurrent_Department: WideString; iType: Integer;
      var sErrorMsg: WideString); safecall;
    procedure GetBaseTableInfo(var vData: OleVariant;
      const sTableName: WideString; var sErrorMsg: WideString); safecall;
    procedure SaveBaseTableInfo(var vData: OleVariant; const sTableName,
      sKeyField: WideString; var sErrorMsg: WideString); safecall;
   procedure SaveWorkerStationInfo(const sWorkerList, sMachine_ID,
      sCurrent_Department, sOperator: WideString;
      var sErrorMsg: WideString); safecall;
    procedure SaveHoldInfo(bIs_Hold, iUnHoldiden: Integer; const iGFKeyValue,
      sOperationCode, sFnCard: WideString; bIseffectReair: Integer;
      const sReason, sOperator: WideString; var sErrorMsg: WideString);
      safecall;
    procedure SaveGIRepairInfo(const sFabric_NO_List,
      sCurrent_Department: WideString; var sErrorMsg: WideString);
      safecall;
    procedure GetGIRepairInfo(var vData: OleVariant;
      const sCurrent_Department: WideString; var sErrorMsg: WideString);
      safecall;
    procedure GetMachineTaskInfo(var vData: OleVariant; const sMachine_ID,
      sCurrent_Department: WideString; var sErrorMsg: WideString);
      safecall;
    procedure SetMachineOperation(const sFN_Card: WideString;
      iStep_NO: Integer; const sMachine_ID, sCar_NO: WideString; dSpeed,
      dWidth: Double; const sOperate_Time, sWorkerList,
      sCurrent_Department: WideString; iType: Integer;
      var sErrorMsg: WideString); safecall;
    procedure GetJobTraceInfo(var vData: OleVariant; const sFN_Card,
      sCurrent_Department: WideString; iType: Integer;
      var sErrorMsg: WideString); safecall;
    procedure GetWIPInfo(var vData0, vData1, vData2: OleVariant;
      const sCurrent_Department: WideString; var sErrorMsg: WideString);
      safecall;
    procedure GetPlanInfo(var vData0, vData1, vData2: OleVariant;
      const sMachine_Model, sCurrent_Department: WideString;
      iType: Integer; var sErrorMsg: WideString); safecall;
    procedure GetChemicalIn_OutDtl(const sDataClass: WideString;
      dDate: TDateTime; const sCurrent_Department: WideString;
      var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetTheMatterFabric(const sCurrent_Department: WideString;
      dDate: TDateTime; out vData0, vData1: OleVariant;
      out sErrorMsg: WideString); safecall;
    procedure GetSampleList(const sFN_Card, sSample_Code: WideString;
      out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure SaveChemicalInDtl(vData: OleVariant; out sErrorMsg: WideString);
      safecall;
    procedure SaveChemicalOutDtl(vData: OleVariant; out sErrorMsg: WideString);
      safecall;
    procedure GetOTDInfo(var vData: OleVariant; const sBegin_Time, sEnd_Time,
      sQuery_Type, sCurrent_Department: WideString; iType: Integer;
      var sErrorMsg: WideString); safecall;
    procedure GetWorkerPrizeOrErrorInfo(var vData: OleVariant;
      const sQuery_Date, sCurrent_Department: WideString; iType: Integer;
      var sErrorMsg: WideString); safecall;
    procedure GetSCInfo(var vData0, vData1, vData2: OleVariant;
      const sContract_NO, sCurrent_Department: WideString;
      var sErrorMsg: WideString); safecall;
    procedure SaveSCInfo(const sContract_NO, sFNCardList, sCurrent_Department,
      sOperator: WideString; var sErrorMsg: WideString); safecall;
    procedure GetFabricReportInfo(var vData: OleVariant; const sBegin_Time,
      sEnd_Time, sCurrent_Department: WideString; iType: Integer;
      var sErrorMsg: WideString); safecall;
    procedure AutoArrangePlan(const sOperation_Code,
      sCurrent_Department: WideString; var sErrorMsg: WideString);
      safecall;
    procedure SaveChemicalStockEdit(const sDataType: WideString;
      vData: OleVariant; const sOperator: WideString;
      out sErrorMsg: WideString); safecall;
    procedure CancelPrintFNCardInfo(const sFN_Card, sCurrent_Department,
      sOperator: WideString; var sErrorMsg: WideString); safecall;
    procedure GetGIInfo(const sSource, sCurrent_Department: WideString;
      iType: Integer; var vData: OleVariant; var sErrorMsg: WideString);
      safecall;
    procedure SaveGIInfo(const sFabricNOList, sSource, sCurrent_Department,
      sOperator: WideString; var sErrorMsg: WideString); safecall;
    procedure GetItemList(var sNoteNOList: OleVariant; const sCode,
      sCurrent_Department, sType: WideString; var sErrorMsg: WideString);
      safecall;
    procedure ChangeGFNO(const sCode, sGFKey, sJob_NO, sReason, sChanger,
      sCurrent_Department: WideString; iType: Integer;
      var sErrorMsg: WideString); safecall;
    procedure SaveDistributeInfo(vData: OleVariant; const sFabricNOStr,
      sMachine_ID, sCurrent_Department: WideString;
      var sErrorMsg: WideString); safecall;
    procedure SaveSuspendInfo(const sMachine_ID, sSuspend_Code, sBegin_Time,
      sEnd_Time, sCurrent_Department, sRemark: WideString;
      var sErrorMsg: WideString); safecall;
    procedure GetQyDetail(iQueryIden: Integer; vCondition: OleVariant;
      out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetQyMaster(iQueryIden: Integer; const sPreDeclareVars,
      sCondition: WideString; out vData: OleVariant;
      out sErrorMsg: WideString); safecall;
    procedure GetQyDictionary(const sQyDicName: WideString;
      out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure AdjustJobTraceDtlInfo(vData: OleVariant; const sIdenList,
      sOperator, sCurrent_Department: WideString;
      var sErrorMsg: WideString); safecall;
    procedure GetJobTraceDtlInfo(var vData: OleVariant; const sParam,
      sBegin_Time, sEnd_Time, sCurrent_Department: WideString;
      iType: Integer; var sErrorMsg: WideString); safecall;
    procedure TerminalQuery(var vData: OleVariant; const sParam, sBegin_Time,
      sEnd_Time, sCurrent_Department: WideString; iType: Integer;
      var sErrorMsg: WideString); safecall;
    procedure SaveOTDInfo(var vData: OleVariant; iType: Integer;
      var sErrorMsg: WideString); safecall;
    procedure SaveCarInfo(const sFNCard, sNewCarNO, sOperator, sAppName,
      sComputerName: WideString; out sErrorMsg: WideString); safecall;
    procedure GetShrinkageAnalysisInfo(var vData: OleVariant;
      const sBegin_Date, sEnd_Date, sCurrent_Department: WideString;
      var sErrorMsg: WideString); safecall;
    procedure SaveShrinkageAnalysisInfo(var vData: OleVariant;
      const sOperator: WideString; var sErrorMsg: WideString); safecall;
    procedure ChangeMaterialType(const sCode, sMaterial_Type, sDuty_Department,
      sReason, sChanger, sCurrent_Department: WideString; iType: Integer;
      var sErrorMsg: WideString); safecall;
    procedure CreateOTDInfo(IType: Integer; var sErrorMsg: WideString);
      safecall;
    procedure CancelFIInfo(const sNote_NO, sFabric_NO_List,
      sOperator: WideString; var sErrorMsg: WideString); safecall;
    procedure GetChemicalData(iType: Integer;
      const sCurrent_Department: WideString; dQueryDate: TDateTime;
      var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveChemicalData(iType: Integer; var vData: OleVariant;
      var sErrorMsg: WideString); safecall;
    procedure GetArtAnalysisData(var vData: OleVariant; dQueryDate: TDateTime;
      const sCurrent_Department: WideString; iType: Integer;
      var sErrorMsg: WideString); safecall;
    procedure SaveArtAnalysisData(var vData: OleVariant;
      var sErrorMsg: WideString); safecall;
    procedure GetUrgentPpoInfo(var vData: OleVariant; const sGF_NO: WideString;
      var sErrorMsg: WideString); safecall;
    procedure SaveUrgentPpoInfo(var vData: OleVariant;
      var sErrorMsg: WideString); safecall;
    procedure SaveRepairReason(var vData: OleVariant; iType: Integer;
      var sErrorMsg: WideString); safecall;
    procedure DeleteRepairReason(const sReason_Code, sItem_Name: WideString;
      iType: Integer; var sErrorMsg: WideString); safecall;
    procedure SaveOTDReason(var vData: OleVariant; iType: Integer;
      var sErrorMsg: WideString); safecall;
    procedure SaveReceiveBenchMark(var vData: OleVariant; iCount: Integer;
      var sErrorMsg: WideString); safecall;
    procedure SaveMutexChemical(var vData: OleVariant; iCount: Integer;
      var sErrorMsg: WideString); safecall;
    procedure GetInnerRepairInfo(const sCurrent_Department,
      sDatetime: WideString; var vData: OleVariant;
      var sErrorMsg: WideString); safecall;
    procedure SaveIgnoredInnerRepairInfo(vData: OleVariant;
      var sErrorMsg: WideString); safecall;
    procedure GetRecipeChemical(const sBatchNO: WideString;
      var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveData(const sType: WideString; vData: OleVariant;
      var sErrorMsg: WideString); safecall;
    procedure SaveSDTraceInfo(var vData: OleVariant; iType: Integer;
      var sErrorMsg: WideString); safecall;
    procedure SaveRSTraceInfo(var vData: OleVariant;
      var sErrorMsg: WideString); safecall;
    procedure SaveSampleInfo(var vParam: OleVariant;
      var sErrorMsg: WideString); safecall;
    procedure SaveMultiData(const sTable1, sTable2: WideString; var vData1,
      vData2: OleVariant; const sSQLText_Before, sSQLText_After, sKey1,
      sKey2: WideString; var sErrorMsg: WideString); safecall;
    procedure GetQueryBySQL(var vData: OleVariant; const sSQL: WideString;
      var sErrMsg: WideString); safecall;
    procedure SaveSQLData(const sSQL: WideString; var sErrMsg: WideString);
      safecall;
     { Protected declarations }
  end;

implementation

uses ComServ, DB, Math;

function TFNMFacadeLib.GetSql(sQueryType, sCondition: Widestring): Widestring;
var
  fullsql: OleVariant;
  sqlText,sErrorMsg: WideString;
begin
  try
    Result := '';
    sqlText:='SELECT Query_Text FROM dbo.fnSQLList WITH(NOLOCK) WHERE Query_Type = ' + QuotedStr(Trim(sQueryType));
    FNMDAOInfo.GetCommonFieldValue(fullsql,sqlText,sErrorMsg);

    if VarIsStr(fullsql) and (fullsql <> '') then
      Result := fullsql + '  ' + sCondition;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.GetQueryData(var vData: OleVariant; const sType,
  sCondition: WideString; var sErrorMsg: WideString);
var
  sSQL: WideString;
begin
  try
    sSQL := GetSql(sType, sCondition);
    FNMDAOInfo.GetCommonData(vData, sSQL, sErrorMsg);
    SetComplete;
  except
    on e: Exception do
    begin
      sErrorMsg := e.Message;
      SetAbort;
    end;
  end;
end;

procedure TFNMFacadeLib.GetMultiData(var vData0, vData1,
  vData2: OleVariant; const sType, sSQLText: WideString;
  var sErrorMsg: WideString);
var
  sSQL: WideString;
begin
{  try
    sSQL := GetSql(sType, sSQLText);
    FNMDAOInfo.GetMultiDataSet(sSQL, vData0, vData1, vData2, sErrorMsg);
    SetComplete;
  except
    on e: Exception do
    begin
      sErrorMsg := e.Message;
      SetAbort;
    end;
  end;  }
end;

procedure TFNMFacadeLib.SaveDataBySQL(const sType, sCondition: WideString;
  var sErrorMsg: WideString);
var
  sSQLText: WideString;
begin
  try
    sSQLText := GetSql(sType, sCondition);
    FNMDAOUpt.ExeCommonSql(sSQLText, sErrorMsg);
    if sErrorMsg='' then SetComplete;
  except
    on e: Exception do
    begin
      sErrorMsg := e.Message;
      SetAbort;
    end;
  end;
end;

procedure TFNMFacadeLib.SaveDataBySQLEx(const sType,
  sCondition: WideString; var Result, sErrorMsg: WideString);
var
  sSQLText: WideString;
begin
  try
    sSQLText := GetSql(sType, sCondition);
    sSQLText := sSQLText +',:@Result OUTPUT';
    FNMDAOUpt.ExeCommonSqlWithResult(sSQLText, '@Result', Result, sErrorMsg);
    if Result <>'' then
      SetComplete
    else
      SetAbort;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.GetReceiveInfo(var vData: OleVariant; const sNote_NO,
  sCurrent_Department, sType: WideString; var sErrorMsg: WideString);
var sqlText:WideString;
begin
{  try
    sqlText:='EXEC dbo.usp_GetReceiveInfo '+QuotedStr(sNote_NO)+','+
              QuotedStr(sCurrent_Department)+','+QuotedStr(sType);
    FNMDAOInfo.GetCommonDataSet(vData,sqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;  }
end;

procedure TFNMFacadeLib.SaveReceiveInfo(const sNote_NO,sCurrent_Department,
  sOperator, sType: WideString; var sErrorMsg: WideString);
var sqlText: WideString;
begin
{  try
    sqlText:='EXEC dbo.usp_SaveReceiveInfo '+QuotedStr(sNote_NO)+','+
              QuotedStr(sCurrent_Department)+','+QuotedStr(sOperator)+ ','+ QuotedStr(sType);
    FNMDAOUpt.ExeCommonSql(sqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end; }
end;

procedure TFNMFacadeLib.CancelFabricInfo(const sNote_NO, sOperator,
  sType: WideString; var sErrorMsg: WideString);
var sqlText: WideString;
begin
{  try
    sqlText:='EXEC dbo.usp_CancelFabricInfo '+QuotedStr(sNote_NO)+ ','+
             QuotedStr(sOperator)+','+QuotedStr(sType);
    FNMDAOUpt.ExeCommonSql(sqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end; }
end;

procedure TFNMFacadeLib.ServerTime(var currTime: OleVariant);
var sqlText,sErrorMsg:WideString;
begin
  try
    sqlText:='SELECT GETDATE()';
    FNMDAOInfo.GetCommonFieldValue(currTime,sqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.GetStockInfo(var vData: OleVariant;
  const sCondition: WideString; var sErrorMsg: WideString);
var sqlText:WideString;
begin  //获取未分布信息
{  try
    sqlText:='SELECT * FROM dbo.uvw_fnStock '+
             'WHERE '+sCondition;
    FNMDAOInfo.GetCommonDataSet(vData,sqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end; }
end;

procedure TFNMFacadeLib.GetSendInfo(var vData0, vData1, vData2: OleVariant;
  const sNote_NO, sCurrent_Department: WideString; iType: Integer; var sErrorMsg: WideString);
var sqlText:WideString;
begin   //获取送布前质量CHECK信息或送布信息
{  try
    sqlText := 'EXEC dbo.usp_GetSendInfo '+QuotedStr(sNote_NO)+',' +
                QuotedStr(sCurrent_Department)+','+IntToStr(iType);
    FNMDAOInfo.GetMultiDataSet(sqlText,vData0,vData1,vData2,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end; }
end;

procedure TFNMFacadeLib.SaveSendInfo(const sFNCardList, sDestination,
  sCurrent_Department, sOperator: WideString; iType: Integer; var sNote_NO,
  sErrorMsg: WideString);
var
  sqlText: WideString;
begin
{  try
    if iType = 0 then
      sqlText:=Format('EXEC dbo.usp_SaveSendInfo ''%s'', ''%s'', ''%s'', ''%s'',:@Note_NO OUTPUT',
                    [sFNCardList, sDestination, sCurrent_Department, sOperator])
    else
      sqlText:=Format('EXEC dbo.usp_ChangeStockDepartmentInfo ''%s'', ''%s'', ''%s'', ''%s'',:@Note_NO OUTPUT',
                    [sFNCardList, sDestination, sCurrent_Department, sOperator]);
    FNMDAOUpt.ExeCommonSqlWithResult(sqlText, '@Note_NO', sNote_NO, sErrorMsg);
    if sNote_NO <>'' then SetComplete else SetAbort;
  except
    SetAbort;
    raise;
  end;  }
end;

procedure TFNMFacadeLib.GetPrintFNCardInfo(const sCurrent_Department,
  sCondition: WideString; iType: Integer; var vData: OleVariant;
  var sErrorMsg: WideString);
var
  sqlText:WideString;
begin
{  try
    sqlText:='EXEC dbo.usp_GetPrintFNCardInfo '+ QuotedStr(sCurrent_Department)+','+ QuotedStr(sCondition)+','+IntToStr(iType);
    FNMDAOInfo.GetCommonDataSet(vData, sqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;}
end;

procedure TFNMFacadeLib.SavePrintFNCardInfo(const sFabric_NO_List,
  sCar_NO: WideString; bIs_CutCloth, bIs_RepairCard: Integer;
  const sOperator: WideString; var sFN_Card, sErrorMsg: WideString);
var
  sFabricNOList: String;
  sqlText:WideString;
begin
 { try
    sFabricNOList := StringReplace(sFabric_NO_List, '`', '#96#', [rfReplaceAll]);
    SqlText:=Format('EXEC dbo.usp_SavePrintFNCardInfo ''%s'', ''%s'', %d, %d, ''%s'', :@FN_Card OUTPUT', [
                            sFabricNOList, sCar_NO, bIs_CutCloth, bIs_RepairCard, sOperator]);

    FNMDAOUpt.ExeCommonSqlWithResult(sqlText, '@FN_Card', sFN_Card, sErrorMsg);
    if sFN_Card <>'' then SetComplete else SetAbort;
  except
    SetAbort;
    raise;
  end; }
end;

procedure TFNMFacadeLib.SaveSplitFabricInfo(const sFabric_NO: WideString;
  dSplit_Quantity: Double; const sCurrent_Department,
  sOperator: WideString; var sNew_Fabric_NO, sErrorMsg: WideString);
var sqlText:WideString;
begin
{  sqlText:='EXEC dbo.usp_SaveSplitFabricInfo '+QuotedStr(sFabric_NO)+','+
            FloatToStr(dSplit_Quantity)+','+QuotedStr(sCurrent_Department)+','+
            QuotedStr(sOperator)+',:@New_Fabric_NO OUTPUT';
  try
    FNMDAOUpt.ExeCommonSqlWithResult(sqlText,'@New_Fabric_NO',sNew_Fabric_NO,sErrorMsg);
    if sNew_Fabric_NO <>'' then
      SetComplete
    else
      SetAbort;
  except
    SetAbort;
    raise;
  end;  }
end;

procedure TFNMFacadeLib.GetSplitFabricInfo(var vData: OleVariant;
  const sFabric_NO, sCurrent_Department: WideString; var sErrorMsg: WideString);
var sqlText:WideString;
begin   
{  sqlText:='SELECT a.FN_Card,a.Fabric_NO,' + #13#10 +
           '       a.Car_NO,a.Quantity,' + #13#10 +
           '       a.GF_ID,c.GF_NO,a.Job_NO,b.PPO_NO,b.Customer,b.Delivery_Date,' + #13#10 +
           '       RTRIM(c.Warp_Count)+''X''+RTRIM(c.Weft_Count) AS WarpWeft_Count,' + #13#10 +
           '       RTRIM(CONVERT(varchar(20),c.Warp_Density))+''X''+RTRIM(CONVERT(varchar(20),c.Warp_Density))AS WarpWeft_Density,' + #13#10 +
           '      (SELECT Operate_Time FROM FNMDB.dbo.fnReceiveHdr WITH(NOLOCK) WHERE' + #13#10 +
           '       Note_NO = a.Note_NO) AS Receive_Date,a.Source,a.Remark' + #13#10 +
           'FROM FNMDB.dbo.fnStock a WITH(NOLOCK)' + #13#10 +
           '            LEFT JOIN PPODB.dbo.arJobMaster b WITH(NOLOCK)   ON  a.GF_ID = b.GF_ID AND a.Job_NO = b.Job_NO' + #13#10 +
           '            LEFT JOIN PDMDB.dbo.tdBasicInfo c WITH(NOLOCK)  ON c.GF_ID= a.GF_ID' + #13#10 +
           'WHERE a.Fabric_NO = '+QuotedStr(sFabric_NO)+' AND a.Current_Department='+ QuotedStr(sCurrent_Department);
  try
    FNMDAOInfo.GetCommonDataSet(vData,sqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;  }
end;

procedure TFNMFacadeLib.GetReportInfo(const sNote_NO: WideString;
  iType: Integer; const sCurrent_Department, sPrinter: WideString;
  var vData0, vData1, vData2: OleVariant; var sErrorMsg: WideString);
var sqlText:WideString;
begin
{  try
    sqlText:=Format('EXEC dbo.usp_GetReportInfo ''%s'', %d, ''%s'', ''%s''', [sNote_NO, iType, sCurrent_Department,sPrinter]);
    FNMDAOInfo.GetMultiDataSet(sqlText,vData0,vData1,vData2,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;    }
end;

procedure TFNMFacadeLib.SaveUnionFNCardInfo(const sFabric_NO_List,
  sFN_Card, sCar_NO: WideString; iType: Integer; const sReason,
  sCurrent_Department, sOperator: WideString; var sNew_FN_Card,
  sErrorMsg: WideString);
var sqlText:WideString;
begin
{  try
    sqlText:=Format('EXEC dbo.usp_SaveUnionFNCardInfo ''%s'', ''%s'', ''%s'', %d, ''%s'', ''%s'', ''%s'', :@New_FN_Card OUTPUT', [
      sFabric_NO_List, sFN_Card, sCar_NO, iType, sReason, sCurrent_Department, sOperator]);
    FNMDAOUpt.ExeCommonSqlWithResult(sqlText,'@New_FN_Card',sNew_FN_Card,sErrorMsg);
    if sNew_FN_Card <>'' then
      SetComplete
    else
      SetAbort;
  except
    SetAbort;
    raise;
  end; }
end;

procedure TFNMFacadeLib.GetUnionFNCardInfo(var vData: OleVariant; const sFN_Card,
  sCurrent_Department: WideString; iType: Integer; var sErrorMsg: WideString);
var sqlText:WideString;
begin
{  try
    sqlText := 'EXEC dbo.usp_GetUnionFNCardInfo '+QuotedStr(sFN_Card)+','+QuotedStr(sCurrent_Department)+','+IntToStr(iType);
    FNMDAOInfo.GetCommonDataSet(vData,sqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
}  
end;

procedure TFNMFacadeLib.GetBaseTableInfo(var vData: OleVariant;
  const sTableName: WideString; var sErrorMsg: WideString);
var sqlText:WideString;
begin
  try
    sqlText:='EXEC dbo.usp_GetBaseTableInfo '+sTablename;
    FNMDAOInfo.GetCommonDataSet(vData,sqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.SaveBaseTableInfo(var vData: OleVariant;
  const sTableName, sKeyField: WideString; var sErrorMsg: WideString);
var sqlText:WideString;
begin
  try
    sqlText := 'SELECT * FROM '+sTablename+' WHERE 1=2';
    if Trim(sKeyField)='' then  //将所有字段作为更新条件
      FNMDAOUpt.SaveDataset(vData,sqlText,sErrorMsg,False)
    else  //将所有KEY+修改过的字段作为更新条件
      FNMDAOUpt.SaveMultiDataset(vData,sqlText,sKeyField,'',sErrorMsg,False);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.SaveWorkerStationInfo(const sWorkerList,sMachine_ID,
  sCurrent_Department, sOperator: WideString; var sErrorMsg: WideString);
var sqlText:WideString;
begin
{  try
    sqlText:='EXEC dbo.usp_SaveWorkerStationInfo '+QuotedStr(sWorkerList)+','+
            QuotedStr(sMachine_ID)+','+QuotedStr(sCurrent_Department)+','+QuotedStr(sOperator);
    FNMDAOUpt.ExeCommonSql(sqlText, sErrorMsg);
    //sErrorMsg:=sqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end; }
end;

procedure TFNMFacadeLib.SaveHoldInfo(bIs_Hold, iUnHoldiden: Integer;
  const iGFKeyValue, sOperationCode, sFnCard: WideString;
  bIseffectReair: Integer; const sReason, sOperator: WideString;
  var sErrorMsg: WideString);
var
  SqlText: WideString;
begin
{  try
    SqlText:=Format('EXEC dbo.usp_SaveHoldInfo %d, %d, ''%s'', ''%s'', ''%s'', %d, ''%s'', ''%s''', [
      bIs_Hold, iUnHoldiden, iGFKeyValue, sOperationCode, sFnCard, bIseffectReair, sReason, sOperator]);
    FNMDAOInfo.ExeCommonSql(SqlText,sErrorMsg);
    //sErrorMsg:=SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;   }
end;

procedure TFNMFacadeLib.SaveGIRepairInfo(const sFabric_NO_List,
  sCurrent_Department: WideString; var sErrorMsg: WideString);
var SqlText:WideString;
begin
{  try
    SqlText:='EXEC dbo.usp_SaveGIRepairInfo '+QuotedStr(sFabric_NO_List)+','+
            QuotedStr(sCurrent_Department);
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;  }
end;

procedure TFNMFacadeLib.GetGIRepairInfo(var vData: OleVariant;
  const sCurrent_Department: WideString; var sErrorMsg: WideString);
var SqlText:WideString;
begin
{  try
    SqlText := 'SELECT  a.Fabric_NO,a.Quantity,a.GF_ID,a.GF_NO'+#13#10+
               'FROM    dbo.uvw_fnGIRepair a WITH(NOLOCK)'+#13#10+
               'WHERE   a.Current_Department ='+QuotedStr(sCurrent_Department);
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;  }
end;

procedure TFNMFacadeLib.GetMachineTaskInfo(var vData: OleVariant;
  const sMachine_ID, sCurrent_Department: WideString; var sErrorMsg: WideString);
var SqlText:WideString;
begin
  try
    SqlText := 'EXEC dbo.usp_GetMachineTaskInfo '+QuotedStr(sMachine_ID)+','+QuotedStr(sCurrent_Department);
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.SetMachineOperation(const sFN_Card: WideString;
  iStep_NO: Integer; const sMachine_ID, sCar_NO: WideString; dSpeed,
  dWidth: Double; const sOperate_Time, sWorkerList,
  sCurrent_Department: WideString; iType: Integer;
  var sErrorMsg: WideString);
var SqlText:WideString;
begin
  SqlText:='EXEC dbo.usp_SetMachineOperation '+QuotedStr(sFN_Card)+','+IntToStr(iStep_NO)+','+
            QuotedStr(sMachine_ID)+','+ QuotedStr(sCar_NO)+','+FloatToStr(dSpeed)+','+
            FloatToStr(dWidth)+','+QuotedStr(sOperate_Time)+','+QuotedStr(sWorkerList)+','+
            QuotedStr(sCurrent_Department)+','+ IntToStr(iType);
  try
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    //sErrorMsg:=SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.GetJobTraceInfo(var vData: OleVariant;
  const sFN_Card, sCurrent_Department: WideString; iType: Integer;
  var sErrorMsg: WideString);
var SqlText:WideString;
begin
  try
    SqlText := 'EXEC dbo.usp_GetJobTraceInfo '+QuotedStr(sFN_Card)+','+QuotedStr(sCurrent_Department)+','+IntToStr(iType);
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.GetWIPInfo(var vData0, vData1, vData2: OleVariant;
  const sCurrent_Department: WideString; var sErrorMsg: WideString);
var SqlText: String;
begin
{  try
    SqlText := 'EXEC dbo.usp_GetWIPInfo '+QuotedStr(sCurrent_Department);
    FNMDAOInfo.GetMultiDataSet(SqlText,vData0,vData1,vData2, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;}
end;

procedure TFNMFacadeLib.GetPlanInfo(var vData0, vData1, vData2: OleVariant;
  const sMachine_Model, sCurrent_Department: WideString; iType: Integer;
  var sErrorMsg: WideString);
var SqlText: WideString;
    const SELECTSQL: string = 'SELECT Iden,GF_ID,Job_NO,FN_Card,Quantity,Step_NO,Operation_Code,Machine_ID,'+#13#10+
                              '       White_Type,Seconds,Prepare_Type,Prepare_Minute,Current_Department,Plan_Begin_Time,'+#13#10+
                              '       Plan_End_Time,Fact_Begin_Time,Fact_End_Time,Planner,Plan_Time'+#13#10+
                              'FROM dbo.fnPlan WITH(NOLOCK) WHERE Fact_End_Time IS NULL';
begin
  try
    if iType = 0 then
      SqlText := 'EXEC dbo.usp_GetPlanTaskInfo '+QuotedStr(sMachine_Model)+','+ QuotedStr(sCurrent_Department)
    else
      SqlText := 'EXEC dbo.usp_GetPlanListInfo '+QuotedStr(sCurrent_Department)+#13#10+SELECTSQL;
    FNMDAOInfo.GetMultiDataSet(SqlText, vData0, vData1, vData2, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.GetChemicalIn_OutDtl(const sDataClass: WideString;
  dDate: TDateTime; const sCurrent_Department: WideString;
  var vData: OleVariant; var sErrorMsg: WideString);
var SqlText: WideString;
begin
 { try
    if sDataClass = 'INDATA' then
      SqlText := 'SELECT a.Iden, a.In_Date, a.Note_NO, a.Price, a.Chemical_ID, b.Chemical_Name, b.Chemical_Type, a.Source, ' +
                 'a.In_Quantity, a.Enable_Quantity, b.Unit, a.Current_Department, a.Operator, a.Operate_Time ' +
                 'FROM dbo.fnChemicalIn a WITH(NOLOCK) LEFT JOIN PUBDB..pbChemicalList b ON a.Chemical_ID=b.Chemical_ID ' +
                 'WHERE a.In_Date BETWEEN '''+ FormatDateTime(DateTimeFmtStr, dDate) +''' AND ''' + FormatDateTime(DateTimeFmtStr, IncDay(dDate)) + ''' ' +
                 'AND a.Current_Department = ''' + sCurrent_Department+ '''';
    if sDataClass = 'OUTDATA' then
      SqlText :='SELECT a.Iden, a.In_Iden, a.Chemical_ID, b.Chemical_Name, b.Chemical_Type, a.Out_Date, ' +
                'a.Used_QTY, b.Unit, a.Use_Department, a.Operator, a.Operate_Time, a.Current_Department ' +
                'FROM dbo.fnChemicalOut a WITH(NOLOCK) LEFT JOIN PUBDB..pbChemicalList b WITH(NOLOCK) ON a.Chemical_ID=b.Chemical_ID ' +
                'WHERE a.Out_Date BETWEEN '''+ FormatDateTime(DateTimeFmtStr, dDate) +''' AND ''' + FormatDateTime(DateTimeFmtStr, IncDay(dDate)) + ''' ' +
                'AND a.Current_Department = ''' + sCurrent_Department+ '''';
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;   }
end;

procedure TFNMFacadeLib.GetTheMatterFabric( const sCurrent_Department: WideString;
  dDate: TDateTime; out vData0, vData1: OleVariant; out sErrorMsg: WideString);
var SqlText: WideString;
    vData2: OleVariant;
begin
  try
    SqlText := 'EXEC dbo.usp_GetDefectAnalysisData '+QuotedStr(DateToStr(dDate))+','+QuotedStr(sCurrent_Department);
    FNMDAOInfo.GetMultiDataSet(SqlText, vData0, vData1, vData2, sErrorMsg);
    //sErrorMsg:=SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.GetSampleList(const sFN_Card,sSample_Code: WideString;
  out vData: OleVariant;  out sErrorMsg: WideString);
var SqlText: WideString;
begin
  try
    if sFN_Card = '' then
    begin
       SqlText := 'SELECT * FROM dbo.fnSampleItemList WITH(NOLOCK) WHERE Sample_code  = ''' + sSample_Code + ''''
    end else
    begin
       SqlText := 'DECLARE  @Fabric_NO varchar(200), @Samplelist varchar(300) ' +
                  'SELECT @Fabric_NO='''', @Samplelist='''' '+
                  'SELECT @Fabric_NO =@Fabric_NO+ Fabric_NO+''(''+STR(Internal_Repair_Times,1)+'')''+''(''+STR(External_Repair_Times,1)+'')''+char(13) ' +
                  'FROM dbo.fnStock WITH(NOLOCK) WHERE  FN_Card = ''' + sFN_Card +'''' +
                  'SELECT @Samplelist = @Samplelist + RTRIM(Sample_Name) + ''='' + RTRIM(cast(Sample_QTY as char(5))) + char(13) ' +
                  'FROM dbo.fnSampleItemList WITH(NOLOCK) WHERE Sample_Code = '''+ sSample_Code + '''' +
                  'SELECT @Fabric_NO AS Fabric_NO, ''' + sSample_Code + ''', @Samplelist AS Samplelist ';
    end;
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.SaveChemicalInDtl(vData: OleVariant; out sErrorMsg: WideString);
const
  INSERTFNCHEMICALINSQL =
    'INSERT INTO dbo.fnChemicalIn (In_Date, Note_NO, Price, Chemical_ID, Source, In_Quantity, Enable_Quantity, Current_Department, Operator) '#13#10 +
    'VALUES(''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'')'#13#10;
var
  SqlText: String;
  cds_ChemicalInDtl: TClientDataSet;
begin
{  SqlText:='';
  try
    try
      cds_ChemicalInDtl:=TClientDataSet.Create(nil);
      cds_ChemicalInDtl.Data:=vData;
      with cds_ChemicalInDtl do
      begin
        First;
        while not Eof do
        begin
          SqlText:=SqlText +
                   Format(INSERTFNCHEMICALINSQL,[
                          FieldByName('In_Date').AsString,
                          FieldByName('Note_NO').AsString,
                          FieldByName('Price').AsString,
                          FieldByName('Chemical_ID').AsString,
                          FieldByName('Source').AsString,
                          FieldByName('In_Quantity').AsString,
                          FieldByName('In_Quantity').AsString,
                          FieldByName('Current_Department').AsString,
                          FieldByName('Operator').AsString]);
          Next;
        end;
      end;
      if SqlText <> '' then
        FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
        //sErrorMsg:=SqlText;
      SetComplete;
    except
      SetAbort;
      raise;
    end
  finally
    FreeAndNil(cds_ChemicalInDtl);
  end;  }
end;

procedure TFNMFacadeLib.SaveChemicalOutDtl(vData: OleVariant;out sErrorMsg: WideString);
var SqlText: String;
    ExecResult: WideString;
begin
{  try
    ExecResult:= '';
    SqlText:=Format('EXEC dbo.usp_SaveChemicalOut ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', :@ExecReslut OUTPUT',
                    [vData[0], vData[1], vData[2], vData[3], vData[4], vData[5], vData[6]]);
    FNMDAOUpt.ExeCommonSqlWithResult(SqlText, '@ExecReslut', ExecResult, sErrorMsg);
    if ExecResult <> '' then
      sErrorMsg:=sErrorMsg + ExecResult;
    SetComplete;
  except
    SetAbort;
    raise;
  end;}
end;

procedure TFNMFacadeLib.GetOTDInfo(var vData: OleVariant;const sBegin_Time,
  sEnd_Time, sQuery_Type, sCurrent_Department: WideString; iType: Integer;
  var sErrorMsg: WideString);
var SqlText: string;
begin
{  try
    case iType of
      0: SqlText := 'SELECT * FROM dbo.uvw_fnOTD WHERE Last_Received_Date= '+QuotedStr(sBegin_Time)+
                 ' AND Current_Department= '+QuotedStr(sCurrent_Department);
      1,2: SqlText := 'EXEC dbo.usp_GetOTDInfo '+ QuotedStr(sBegin_Time)+','+
                  QuotedStr(sEnd_Time)+ ','+QuotedStr(sCurrent_Department)+','+QuotedStr(sQuery_Type)+','+ IntToStr(iType);
      3: SqlText := 'EXEC dbo.usp_GetSpecialOTDInfo '+ QuotedStr(sBegin_Time)+','+
                  QuotedStr(sEnd_Time)+ ','+QuotedStr(sCurrent_Department)+','+QuotedStr(sQuery_Type)+',0';
    end;

    if iType = 0 then
      SqlText := 'SELECT * FROM dbo.uvw_fnOTD WHERE Last_Received_Date= '+QuotedStr(sBegin_Time)+
                 ' AND Current_Department= '+QuotedStr(sCurrent_Department)
    else
      SqlText := 'EXEC dbo.usp_GetOTDInfo '+ QuotedStr(sBegin_Time)+','+
                  QuotedStr(sEnd_Time)+ ','+QuotedStr(sCurrent_Department)+','+QuotedStr(sQuery_Type)+','+IntToStr(iType);

    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end; }
end;

procedure TFNMFacadeLib.GetWorkerPrizeOrErrorInfo(var vData: OleVariant;
  const sQuery_Date, sCurrent_Department: WideString; iType: Integer; var sErrorMsg: WideString);
var SqlText: string;
begin
  try
    if iType = 0 then
      SqlText := 'SELECT * FROM dbo.fnWorkerPrize WHERE Prize_Date= '+QuotedStr(sQuery_Date)+
                 ' AND Current_Department= '+QuotedStr(sCurrent_Department)
    else
      SqlText := 'SELECT * FROM dbo.fnWorkerError WHERE Error_Date= '+ QuotedStr(sQuery_Date)+
                  ' AND Current_Department= '+QuotedStr(sCurrent_Department);
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;
//获取外发回来信息
procedure TFNMFacadeLib.GetSCInfo(var vData0, vData1, vData2: OleVariant;
  const sContract_NO, sCurrent_Department: WideString;
  var sErrorMsg: WideString);
var SqlText: string;
begin
{  try
    SqlText := 'EXEC dbo.usp_GetSCInfo '+QuotedStr(sContract_NO)+','+
                QuotedStr(sCurrent_Department);
    FNMDAOInfo.GetMultiDataSet(SqlText,vData0,vData1,vData2,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;  }
end;
//保存回收外发信息
procedure TFNMFacadeLib.SaveSCInfo(const sContract_NO, sFNCardList,
  sCurrent_Department, sOperator: WideString; var sErrorMsg: WideString);
var SqlText: string;
begin
{  try
    SqlText:='EXEC dbo.usp_SaveSCInfo '+QuotedStr(sContract_NO)+','+QuotedStr(sFNCardList)+','+
              QuotedStr(sCurrent_Department)+','+QuotedStr(sOperator);
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end; }
end;
//获取布的入库/库存/出库信息
procedure TFNMFacadeLib.GetFabricReportInfo(var vData: OleVariant;
  const sBegin_Time, sEnd_Time, sCurrent_Department: WideString;
  iType: Integer; var sErrorMsg: WideString);
var SqlText: string;
begin
{  try
    SqlText := 'EXEC dbo.usp_GetFabricReportInfo '+QuotedStr(sBegin_Time)+ ','+
                QuotedStr(sEnd_Time)+','+ QuotedStr(sCurrent_Department)+','+IntToStr(iType);
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;  }
end;
//自动排机
procedure TFNMFacadeLib.AutoArrangePlan(const sOperation_Code,
  sCurrent_Department: WideString; var sErrorMsg: WideString);
var SqlText: string;
begin
  try
    SqlText := 'EXEC dbo.usp_AutoArrangePlan '+QuotedStr(sOperation_Code)+','+
                QuotedStr(sCurrent_Department);
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;
//修改化工料信息
procedure TFNMFacadeLib.SaveChemicalStockEdit(const sDataType: WideString;
  vData: OleVariant; const sOperator: WideString;
  out sErrorMsg: WideString);
var
  SqlText: String;
begin  //不用做虚拟出库和虚拟入库，客户端已控制
{  try
    if sDataType = 'ChemicalInData' then
    begin
      SqlText:=
        Format('UPDATE dbo.fnChemicalIn SET Note_NO = ''%s'', Price = ''%s'', Chemical_ID = ''%s'', Source = ''%s'', ' +
               'In_Quantity = ''%s'',Enable_Quantity = ''%s'', Operator = ''%s'', Operate_Time = GETDATE() ' +
               'where Iden = ''%s'' ', [vData[0], vData[1], vData[2], vData[3], vData[4], vData[5], sOperator, vData[6]]);
    end;

    if sDataType = 'ChemicalOutData' then
    begin
      SqlText:=
        format('UPDATE dbo.fnChemicalOut SET Used_QTY = ''%s'', Use_Department = ''%s'', Operator = ''%s'', Operate_Time = GETDATE() ' +
               'where Iden = ''%s'' ', [vData[0], vData[1], sOperator, vData[2]]);
               
      if vData[3] <> 0 then
        SqlText:=SqlText +
          format('UPDATE dbo.fnChemicalIn SET Enable_Quantity = Enable_Quantity + %s where Iden = ''%s'' ',
                  [vData[3], vData[4]]);
    end;
    
    if SqlText <> '' then
      FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end; }
end;
//取消打卡
procedure TFNMFacadeLib.CancelPrintFNCardInfo(const sFN_Card,
  sCurrent_Department, sOperator: WideString; var sErrorMsg: WideString);
var SqlText: string;
begin
{ try
    SqlText := 'EXEC dbo.usp_CancelPrintCard '+QuotedStr(sFN_Card)+','+QuotedStr(sCurrent_Department)+','+QuotedStr(sOperator);
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;  }
end;
//获取收坯信息
procedure TFNMFacadeLib.GetGIInfo(const sSource,
  sCurrent_Department: WideString; iType: Integer; var vData: OleVariant;
  var sErrorMsg: WideString);
var SqlText: string;
begin
{  try
    SqlText:='EXEC dbo.usp_GetGIStockInfo '+QuotedStr(sSource)+','+QuotedStr(sCurrent_Department) +',' + IntToStr(iType);
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;}
end;

//保存收坯信息
procedure TFNMFacadeLib.SaveGIInfo(const sFabricNOList, sSource,
  sCurrent_Department, sOperator: WideString; var sErrorMsg: WideString);
var
  sqlText: string;
begin
  try
    sqlText :='DECLARE @Result varchar(100)'+#13+
       Format('EXEC QCMDB.DBO.usp_giSavePayFNInfo 1, ''%s'', ''%s'', ''%s'', ''%s'', @Result OUTPUT'#13#10,
                [sFabricNOList, sSource, sCurrent_Department, sOperator]) +
              'SET @Result = SUBSTRING(@Result,CHARINDEX(''--'',@Result)+2,20) '+#13+
       Format('EXEC FNMDB.dbo.usp_SaveReceiveInfo @Result, ''%s'', ''%s'', ''%s'''#13#10,
               [sCurrent_Department, sOperator, sSource]);
    FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
    //sErrorMsg:=sqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

//获取单据列表
procedure TFNMFacadeLib.GetItemList(var sNoteNOList: OleVariant;
  const sCode, sCurrent_Department, sType: WideString;
  var sErrorMsg: WideString);
var SqlText: string;
begin
  try
    SqlText:='EXEC dbo.usp_GetItemList '+ QuotedStr(sCode)+','+
             QuotedStr(sCurrent_Department)+','+QuotedStr(sType);
    FNMDAOInfo.GetCommonFieldValue(sNoteNOList,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;

end;
//修改品名
procedure TFNMFacadeLib.ChangeGFNO(const sCode, sGFKey, sJob_NO, sReason,
  sChanger, sCurrent_Department: WideString; iType: Integer;
  var sErrorMsg: WideString);
var SqlText: string;
begin
{  try
    SqlText := 'EXEC dbo.usp_ChangeGFNO '+QuotedStr(sCode)+','+QuotedStr(sGFKey)+','+
                QuotedStr(sJob_NO)+','+QuotedStr(sReason)+','+QuotedStr(sChanger)+','+
                QuotedStr(sCurrent_Department)+','+IntToStr(iType);
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;  }
end;
//保存分布信息
procedure TFNMFacadeLib.SaveDistributeInfo(vData: OleVariant;
  const sFabricNOStr, sMachine_ID, sCurrent_Department: WideString;
  var sErrorMsg: WideString);
var sqlText,sqlUpdateText:WideString;
begin
  try
    sqlText := 'SELECT * FROM dbo.uvw_fnStock  WHERE 1=2';
    sqlUpdateText := 'EXEC dbo.usp_SaveDistributeYield '+QuotedStr(sMachine_ID)+','+
                     QuotedStr(sFabricNOStr)+','+QuotedStr(sCurrent_Department);
    FNMDAOUpt.SaveMultiDataset(vData,sqlText,'Fabric_NO',sqlUpdateText,sErrorMsg,False);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;
//记录机台停机信息
procedure TFNMFacadeLib.SaveSuspendInfo(const sMachine_ID, sSuspend_Code,
  sBegin_Time, sEnd_Time, sCurrent_Department, sRemark: WideString;
  var sErrorMsg: WideString);
var SqlText: String;
begin  
  try
    sqlText := Format('EXEC dbo.usp_SaveSuspendInfo ''%s'', ''%s'', ''%s'', ''%s'',''%s'', ''%s''',
                       [sMachine_ID,sSuspend_Code,sBegin_Time,sEnd_Time,sCurrent_Department,sRemark]);
    FNMDAOUpt.ExeCommonSql(sqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.GetQyDetail(iQueryIden: Integer;
  vCondition: OleVariant; out vData: OleVariant;
  out sErrorMsg: WideString);
var
  SqlText:WideString;
begin
  try
    SqlText:=Format('EXEC dbo.usp_GetQyDetail %d, ''%s'', ''%s'', ''%s'', ''%s''',
                    [iQueryIden, vCondition[0], vCondition[1], vCondition[2], vCondition[3]]);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    //sErrorMsg:=SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.GetQyMaster(iQueryIden: Integer;
  const sPreDeclareVars, sCondition: WideString; out vData: OleVariant;
  out sErrorMsg: WideString);
var
  SqlText:WideString;
begin
  try
    SqlText:=Format('EXEC dbo.usp_GetqyMaster %d, ''%s'', ''%s''', [iQueryIden,
      StringReplace(sPreDeclareVars, '''', '''''', [rfReplaceAll]),
      StringReplace(sCondition, '''', '''''', [rfReplaceAll])]);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    //sErrorMsg:=SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.GetQyDictionary(const sQyDicName: WideString;
  out vData: OleVariant; out sErrorMsg: WideString);
var
  SqlText:WideString;
begin
  try
    SqlText:=Format('EXEC dbo.usp_GetQyDictionary ''%s''', [sQyDicName]);
    FNMDAOInfo.GetCommonDataSet(vData, sqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.AdjustJobTraceDtlInfo(vData: OleVariant;
  const sIdenList, sOperator, sCurrent_Department: WideString;
  var sErrorMsg: WideString);
var
  SqlText: String;
  cdsJobTraceDtl: TClientDataSet;
  sList:TStringList;
  i: Integer;
begin
  cdsJobTraceDtl:=nil;
  sList := nil;
  try
    cdsJobTraceDtl:=TClientDataSet.Create(nil);
    sList :=TStringList.Create;
    try
      cdsJobTraceDtl.Data:=vData;
      sList.Text := sIdenList;
      sqlText := '';
      for i := 0 to sList.Count-1 do
        with  cdsJobTraceDtl do
        begin
          if Locate('Iden',sList[i],[]) then
            sqlText := sqlText+#13+Format('EXEC dbo.usp_AdjustJobTraceDtlInfo %d,''%s'',%5.2f,''%s'',''%s'',''%s'',''%s'',''%s''',
              [FieldByName('Iden').AsInteger,FieldByName('Machine_ID').AsString,FieldByName('Speed').AsFloat,FieldByName('Befor_Operator').AsString,
              FieldByName('Middle_Operator').AsString,FieldByName('After_Operator').AsString,sCurrent_Department,sOperator]);
        end;
      cdsJobTraceDtl.Close;
      FNMDAOUpt.ExeCommonSql(sqlText,sErrorMsg);
      SetComplete;
     except
      SetAbort;
      raise;
    end;
  finally
    FreeAndNil(cdsJobTraceDtl);
    FreeAndNil(sList);
  end;
end;

procedure TFNMFacadeLib.GetJobTraceDtlInfo(var vData: OleVariant;
  const sParam, sBegin_Time, sEnd_Time, sCurrent_Department: WideString;
  iType: Integer; var sErrorMsg: WideString);
var SqlText:WideString;
begin
  try
    SqlText := 'SELECT a.Iden,dbo.udf_GetGFNO(c.GF_ID) AS GF_NO,a.FN_Card,a.Quantity,a.Step_NO,b.Operation_CHN,a.Machine_ID,a.Speed, '+
               ' a.Begin_Time,a.End_Time,a.Befor_Operator,a.Middle_Operator,a.After_Operator,a.Operator,a.Operate_Time,c.GF_ID,c.Job_NO,a.Operation_Code  '+
               'FROM dbo.fnJobTraceDtl a '+
               '   JOIN dbo.fnOperationHdrList b ON a.Operation_Code = b.Operation_Code '+
               '   JOIN dbo.fnJobTraceHdr c ON c.FN_Card = a.FN_Card  '+
               'WHERE a.Current_Department='+QuotedStr(sCurrent_Department)+' AND a.Operation_Code<>''999''';
   if iType = 0 then
     SqlText := SqlText+' AND a.Machine_ID = '+QuotedStr(sParam)+ ' AND a.Begin_Time BETWEEN  '+QuotedStr(sBegin_Time) + 'AND '+QuotedStr(sEnd_Time)+
                        ' ORDER BY a.FN_Card,a.Begin_Time '
   else
     SqlText := SqlText+' AND a.FN_Card = '+QuotedStr(sParam) +
                        ' ORDER BY a.FN_Card,a.Step_NO ';
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.TerminalQuery(var vData: OleVariant; const sParam,
  sBegin_Time, sEnd_Time, sCurrent_Department: WideString; iType: Integer;
  var sErrorMsg: WideString);
var SqlText:WideString;
begin
  try
    SqlText := 'EXEC dbo.usp_TerminalQuery '+QuotedStr(sBegin_Time)+','
                +QuotedStr(sEnd_Time)+','+QuotedStr(sCurrent_Department)+','+QuotedStr(sParam)+','+IntToStr(iType);
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.SaveOTDInfo(var vData: OleVariant; iType: Integer;
  var sErrorMsg: WideString);
const   //更新fnJobTraceHdr表，以免坯布更新不及时导致后整状态出错
  UPDATEOTDSQL = 'UPDATE dbo.fnOTD SET Quality_Type = ''%s'',Second_Reason = ''%s'',Third_Reason = ''%s'',Four_Reason = ''%s'',Remark = ''%s'', Updater =  ''%s'', Update_Time = GETDATE(),Is_Active = ''%s'' '+#13+
                 'WHERE GF_ID = ''%s'' AND Job_NO = ''%s'' AND Current_Department = ''%s''' + #13#10 +
                 'UPDATE dbo.fnJobTraceHdr SET GF_ID = GF_ID WHERE GF_ID = ''%s'' AND Job_NO = ''%s'' AND Current_Department = ''%s''' + #13#10 ;
const
  UPDATESPECIALOTDSQL = 'UPDATE dbo.fnSpecialOTD SET Remark = ''%s'', Updater =  ''%s'', Update_Time = GETDATE(),Is_Active = ''%s'' '+#13+
                 'WHERE GF_ID = ''%s'' AND Job_NO = ''%s'' AND Special_Type = ''%s'' AND Current_Department = ''%s'''+#13#10;

var SqlText: WideString;
    i: Integer;
begin
  try
    case iType of
      0: SaveBaseTableInfo(vData, 'dbo.uvw_fnOTD', 'Job_NO,GF_ID,Current_Department', sErrorMsg);
      1: begin
          for i := 0 to VarArrayHighBound(vData, 1) do
            SqlText := SqlText+Format(UPDATEOTDSQL,[vData[i][0],vData[i][1],vData[i][2],vData[i][3],vData[i][4],vData[i][5],vData[i][6],vData[i][7],vData[i][8],vData[i][9],vData[i][7],vData[i][8],vData[i][9]]);
          FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
         end;
      2: begin
          for i := 0 to VarArrayHighBound(vData, 1) do
            SqlText := SqlText+Format(UPDATESPECIALOTDSQL,[vData[i][0],vData[i][1],vData[i][2],vData[i][3],vData[i][4],vData[i][5],vData[i][6]]);
          FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
         end;
    end;
{
    if iType = 0 then
      SaveBaseTableInfo(vData, 'dbo.uvw_fnOTD', 'Job_NO,GF_ID,Current_Department', sErrorMsg)
    else
    begin
      for i := 0 to VarArrayHighBound(vData, 1) do
        SqlText := SqlText+Format(UPDATEOTDSQL,[vData[i][0],vData[i][1],vData[i][2],vData[i][3],vData[i][4],vData[i][5],vData[i][6]]);
      FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    end;
}
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.SaveCarInfo(const sFNCard, sNewCarNO, sOperator,
  sAppName, sComputerName: WideString; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  {
  SqlText:='DECLARE @OldCarNO varchar(10), @NewCarNO varchar(10), @FNCard char(9)'#13#10 +
    Format('SELECT @OldCarNO = Car_NO, @NewCarNO = ''%s'', @FNCard = ''%s'' FROM dbo.fnJobTraceHdr WHERE FN_Card = ''%s'' '#13#10, [sNewCarNO, sFNCard, sFNCard]) +
           'IF @OldCarNO IS NULL '#13#10 +
           'BEGIN '#13#10 +
           '  RAISERROR (''卡号不存在'', 16, 1) '#13#10 +
           '  RETURN '#13#10 +
           'END '#13#10 +
           'INSERT INTO dbo.fnModifyDataLog(Operator, Operate_Time, Operate_Type, Application_Name, Host_Name, Table_Name, Remark) '#13#10 +
    Format('  VALUES(''%s'', GETDATE(), ''更改车牌号'', ''%s'', ''%s'', ''CarNO'', @FNCard + '':'' + @OldCarNO + ''->'' + ''%s'') '#13#10, [sOperator, sAppName, sComputerName, sNewCarNO]) +
           'UPDATE dbo.fnJobTraceHdr SET Car_NO = @NewCarNO WHERE FN_Card = @FNCard '#13#10 +
           'UPDATE dbo.fnStock SET Car_NO = @NewCarNO WHERE FN_Card = @FNCard ';
   // sErrorMsg:=SqlText;
  try
    FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
  }
end;

procedure TFNMFacadeLib.GetShrinkageAnalysisInfo(var vData: OleVariant;
  const sBegin_Date, sEnd_Date, sCurrent_Department: WideString;
  var sErrorMsg: WideString);
var SqlText:WideString;
begin
  try
    SqlText := 'SELECT * FROM dbo.uvw_fnShrinkageAnalysis WITH(NOLOCK) '+
               'WHERE Inspect_Time BETWEEN '+QuotedStr(sBegin_Date)+' AND '+
                QuotedStr(sEnd_Date)+' AND Receive_Note_NO like '+QuotedStr(sCurrent_Department+'%');
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.SaveShrinkageAnalysisInfo(var vData: OleVariant;
  const sOperator: WideString; var sErrorMsg: WideString);
const
  UPDATEShrinkSQL = 'UPDATE QCMDB.dbo.fiShrinkDtl SET Reason = ''%s'' '+
                    ',Operator = ''%s'',Operate_Time = GETDATE() '+
                    ' WHERE Iden = %s'#13#10;
var SqlText: WideString;
    i: Integer;
begin
  try
    for i := 0 to VarArrayHighBound(vData, 1) do
      SqlText := SqlText + Format(UPDATEShrinkSQL, [vData[i][0],sOperator,vData[i][1]]);
    FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);                               
    //sErrorMsg:=SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.ChangeMaterialType(const sCode, sMaterial_Type,
  sDuty_Department, sReason, sChanger, sCurrent_Department: WideString;
  iType: Integer; var sErrorMsg: WideString);
var SqlText: string;
begin
{  try
    SqlText := 'EXEC dbo.usp_ChangeMaterialType '+QuotedStr(sCode)+','+QuotedStr(sMaterial_Type)+','+
                QuotedStr(sDuty_Department)+','+ QuotedStr(sReason)+','+QuotedStr(sChanger)+','+
                QuotedStr(sCurrent_Department)+','+IntToStr(iType);
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end; }
end;

procedure TFNMFacadeLib.CreateOTDInfo(IType: Integer; var sErrorMsg: WideString);
var SqlText: string;
begin
  try
    case IType of
      0: SqlText := 'EXEC dbo.usp_AutoCreateOTDInfo '+QuotedStr(DateToStr(Now));
      1: SqlText := 'EXEC dbo.usp_AutoCreateSpecialOTDInfo ';
    end;
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.CancelFIInfo(const sNote_NO, sFabric_NO_List,
  sOperator: WideString; var sErrorMsg: WideString);
var sqlText: WideString;
   sFabricNOList: String;
begin
{  try
    sFabricNOList := StringReplace(sFabric_NO_List, '`', '#96#', [rfReplaceAll]);
    sqlText:='EXEC dbo.usp_CancelFIInfo '+QuotedStr(sNote_NO)+ ','+
             QuotedStr(sFabricNOList)+','+QuotedStr(sOperator);
    FNMDAOUpt.ExeCommonSql(sqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;  }
end;

procedure TFNMFacadeLib.GetChemicalData(iType: Integer;
  const sCurrent_Department: WideString; dQueryDate: TDateTime;
  var vData: OleVariant; var sErrorMsg: WideString);
var SqlText:WideString;
begin
{  try
    case iType of
      0:  SqlText := 'SELECT Chemical_Type,Chemical_ID, '+QuotedStr(DateToStr(dQueryDate)) + ' AS Create_Date,Chemical_Name, Remain AS Last_Remain, '+
                  'In_Qty-In_Qty AS In_Qty, Out_Qty-Out_Qty AS Out_Qty, Remain-Remain AS Remain,Price ' +
                  'INTO #Temp01  '+
                  'FROM dbo.fnChemicalCheck a WITH(NOLOCK) '+
                  'WHERE Remain > 0 AND Current_Department = ' + QuotedStr(sCurrent_Department) +
                  ' AND Create_Date = (SELECT MAX(Create_Date) FROM dbo.fnChemicalCheck WITH(NOLOCK) '+
                  ' WHERE Current_Department = a.Current_Department AND Create_Date < '+ QuotedStr(DateToStr(dQueryDate)) +')'+
                  ' SELECT * FROM #Temp01  DROP TABLE #Temp01';
      1:  SqlText := 'EXEC dbo.usp_GetChemicalReport ' + QuotedStr(DateToStr(dQueryDate)) + ',' + QuotedStr(sCurrent_Department);
      2:  SqlText := 'SELECT a.Method_ENG, a.Chemical_Name, a.Chemical_Ratio, a.Job_NO, b.GF_NO, a.Product_QTY, '+
                     'a.Need_Quantity, a.Stock_Quantity, a.Apply_Quantity, a.Is_Apply,a.Iden, a.GF_ID  '+
                     'FROM dbo.fnApplySpecialChemical a WITH(NOLOCK)  '+
                     '  INNER JOIN PDMDB.dbo.tdGFID b WITH(NOLOCK) ON b.GF_ID = a.GF_ID  '+
                     'WHERE a.Is_Apply = 0 AND a.Current_Department = '+ QuotedStr(sCurrent_Department);
    end;
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end; }
end;

procedure TFNMFacadeLib.SaveChemicalData(iType: Integer;
  var vData: OleVariant; var sErrorMsg: WideString);
const
  INSERTCHEMICALCHECKSQL = 'INSERT INTO dbo.fnChemicalCheck(Create_Date, Chemical_ID, '+
                           'Chemical_Name, Chemical_Type, In_QTY, Out_QTY, Remain, Price, '+
                           'Current_Department, Operator, Operate_Time) '+
                           'VALUES (''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',GETDATE())' +#13#10;
const
  UPDATEAPPLYSPECIALCHEMICALSQL = 'UPDATE dbo.fnApplySpecialChemical SET Stock_Quantity = ''%s'',Apply_Quantity = ''%s'',Is_Apply = ''%s'', Appler =  ''%s'', Apply_Time = GETDATE() '+#13+
                 'WHERE Iden = ''%s'' AND Current_Department = ''%s'''+#13#10;


var SqlText: WideString;
    i: Integer;
begin
  try
    case iType of
      0:  begin
          SqlText := 'DELETE FROM dbo.fnChemicalCheck WHERE Create_Date >= ' + QuotedStr(vData[0][0]) + ' AND Current_Department = '+ QuotedStr(vData[0][8]) + #13#10;
          for i := 0 to VarArrayHighBound(vData, 1) do
            SqlText := SqlText+Format(INSERTCHEMICALCHECKSQL,[vData[i][0],vData[i][1],vData[i][2],vData[i][3],vData[i][4],vData[i][5],vData[i][6],vData[i][7],vData[i][8],vData[i][9]]);
         end;
      1: SqlText :=Format('EXEC dbo.usp_AdjustChemicalData ''%s'',''%s'',''%s'',''%s'',''%s''',[vData[0][0], vData[0][1], vData[0][2], vData[0][3], vData[0][4]]);
      2:  begin
          SqlText := '';
          for i := 0 to VarArrayHighBound(vData, 1) do
            SqlText := SqlText+Format(UPDATEAPPLYSPECIALCHEMICALSQL,[vData[i][0],vData[i][1],vData[i][2],vData[i][3],vData[i][4],vData[i][5]]);
         end;
    end;
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.GetArtAnalysisData(var vData: OleVariant;
  dQueryDate: TDateTime; const sCurrent_Department: WideString;
  iType: Integer; var sErrorMsg: WideString);
var sCondition, SqlText:WideString;
begin
  try
// 2011-11-2  
//    SqlText := 'SELECT a.Create_Date, a.FN_Card, a.Type, a.Job_NO, b.GF_NO, a.Quantity, ' +
//               'c.Reason_Info, a.Checker, a.Worker0, a.Qty0, a.Worker1, a.Qty1,Remark '+
//               'FROM dbo.fnArtAnalysis a WITH(NOLOCK) '+
//               '  INNER JOIN PDMDB.dbo.tdGFID b WITH(NOLOCK) ON b.GF_ID = a.GF_ID '+
//               '  INNER JOIN dbo.fnRepairReasonHdrList c WITH(NOLOCK) ON c.Reason_Code = a.Reason_Code '+
//               'WHERE a.Create_Date = ' + QuotedStr(DateToStr(dQueryDate)) +' AND a.Current_Department = '+
//                QuotedStr(sCurrent_Department) + ' AND a.Type = ' +  IntToStr(iType);

    sCondition := QuotedStr(DateToStr(dQueryDate))+','
                + QuotedStr(sCurrent_Department)+','
                + IntToStr(iType);
    SqlText := GetSql('GetArtAnalysisData', sCondition);
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.SaveArtAnalysisData(var vData: OleVariant;
  var sErrorMsg: WideString);
const
  INSERTCHEMICALCHECKSQL = 'UPDATE dbo.fnArtAnalysis SET Worker0 =''%s'',Qty0 = ''%s'', Worker1 =''%s'',Qty1 = ''%s'', '+
                           '  Remark = ''%s'',Operator =''%s'', Operate_Time = GETDATE()  '+
                           'WHERE Create_Date = ''%s'' AND FN_Card = ''%s'' AND Type = ''%s'' AND Current_Department = ''%s'' ' + #13#10;
var SqlText: WideString;
    i: Integer;
begin
  try
    for i := 0 to VarArrayHighBound(vData, 1) do
      SqlText := SqlText+Format(INSERTCHEMICALCHECKSQL,[vData[i][3],vData[i][4],vData[i][5],vData[i][6],vData[i][7],vData[i][8],vData[i][0],vData[i][1],vData[i][2],vData[i][9]]);
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.GetUrgentPpoInfo(var vData: OleVariant;
  const sGF_NO: WideString; var sErrorMsg: WideString);
var SqlText:WideString;
begin
{  try
    SqlText := 'EXEC dbo.usp_GetUrgentPpoInfo ' + QuotedStr(sGF_NO);
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;  }
end;

procedure TFNMFacadeLib.SaveUrgentPpoInfo(var vData: OleVariant;
  var sErrorMsg: WideString);
const
  UPDATEPBPRODUCTTRACEFNQCSQL = 'UPDATE PUBDB.dbo.pbProductTraceFNQC SET FN_Special_Status =''%s'' '+
                                'WHERE Job_NO = ''%s'' AND GF_ID = ''%s'' ' + #13#10;
var SqlText: WideString;
    i: Integer;
begin
  try
    for i := 0 to VarArrayHighBound(vData, 1) do
      SqlText := SqlText+Format(UPDATEPBPRODUCTTRACEFNQCSQL,[vData[i][0],vData[i][1],vData[i][2]]);
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.SaveRepairReason(var vData: OleVariant;
  iType: Integer; var sErrorMsg: WideString);
const
  INSERT_HDR_SQL = 'DECLARE @Reason_Code char(5) '+ #13 +
                   ' SELECT @Reason_Code = (SELECT ''FR''+RIGHT(''000''+CONVERT(varchar,MAX(RIGHT(Reason_Code,3)) + 1),3) FROM dbo.fnRepairReasonHdrList WITH(NOLOCK)) ' +#13+
                   ' INSERT INTO dbo.fnRepairReasonHdrList(Reason_Code, Reason_Type,' +
                   'Reason_Info, Quality_Operation, Quality_Type, Department, Remark, '+
                   'Repair_Operation, Is_Active,Operator, Operate_Time)'+#13+
                   'VALUES(@Reason_Code, ''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',GETDATE())';
  UPDATE_HDR_SQL = 'UPDATE dbo.fnRepairReasonHdrList SET  Reason_Type = ''%s'',' +
                   'Reason_Info = ''%s'', Quality_Operation = ''%s'', Quality_Type = ''%s'', Department = ''%s'', Remark = ''%s'', '+
                   'Repair_Operation = ''%s'', Is_Active = ''%s'',Operator = ''%s'', Operate_Time = GETDATE() ' + #13 +
                   'WHERE Reason_Code = ''%s''';

  INSERT_DTL_SQL = 'INSERT INTO dbo.fnRepairReasonDtlList(Reason_Code,Item_Name,Enum_Value) '+ #13 +
                   'VALUES(''%s'', ''%s'',''%s'')';
  UPDATE_DTL_SQL = 'UPDATE dbo.fnRepairReasonDtlList SET Item_Name = ''%s'',Enum_Value = ''%s'' '+#13+
                   'WHERE Reason_Code = ''%s''';
var SqlText: WideString;
begin
  try
    if iType = 0 then
      if vData[0][0] = '' then //new
        SqlText := Format(INSERT_HDR_SQL,[vData[0][1],vData[0][2],vData[0][3],vData[0][4],vData[0][5],vData[0][6],vData[0][7],vData[0][8],vData[0][9]])
      else                     //edit
        SqlText := Format(UPDATE_HDR_SQL,[vData[0][1],vData[0][2],vData[0][3],vData[0][4],vData[0][5],vData[0][6],vData[0][7],vData[0][8],vData[0][9],vData[0][0]])
    else
      if vData[0][0] = '1' then  //new
        SqlText := Format(INSERT_DTL_SQL,[vData[0][1],vData[0][2],vData[0][3]])
      else                       //edit
        SqlText := Format(UPDATE_DTL_SQL,[vData[0][2],vData[0][3],vData[0][1]]);
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.DeleteRepairReason(const sReason_Code,
  sItem_Name: WideString; iType: Integer; var sErrorMsg: WideString);
var SqlText: WideString;
begin
  try
    if iType = 0 then
      SqlText := 'UPDATE dbo.fnRepairReasonHdrList SET Is_Active = 0 WHERE Reason_Code = ' + QuotedStr(sReason_Code)
    else
      SqlText := 'DELETE dbo.fnRepairReasonDtlList WHERE Reason_Code = ' + QuotedStr(sReason_Code) + '  AND Item_Name = ' + QuotedStr(sItem_Name);

    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.SaveOTDReason(var vData: OleVariant;
  iType: Integer; var sErrorMsg: WideString);
const
  INSERT_OTDREASON_SQL = ' INSERT INTO dbo.fnOTDReasonList(First_Reason,Second_Reason,Third_Reason,Four_Reason, Remark, Operator, Operate_Time)'+#13+
                   'VALUES(''%s'', ''%s'',''%s'',''%s'',''%s'',''%s'',GETDATE())';
  UPDATE_OTDREASON_SQL = 'UPDATE dbo.fnOTDReasonList SET  First_Reason = ''%s'',' +
                   'Second_Reason = ''%s'', Third_Reason = ''%s'', Four_Reason = ''%s'',Remark = ''%s'', '+
                   'Operator = ''%s'', Operate_Time = GETDATE() ' + #13 +
                   'WHERE Iden = ''%s''';
  DELETE_OTDREASON_SQL = 'DELETE  dbo.fnOTDReasonList WHERE Iden = ''%s''';
var SqlText: WideString;
begin
  try
    if iType = 0 then
        SqlText := Format(INSERT_OTDREASON_SQL,[vData[0][1],vData[0][2],vData[0][3],vData[0][4],vData[0][5],vData[0][6]])
    else  if iType = 1 then                 //edit
        SqlText := Format(UPDATE_OTDREASON_SQL,[vData[0][1],vData[0][2],vData[0][3],vData[0][4],vData[0][5],vData[0][6],vData[0][0]])
    else   //DELETE
        SqlText := Format(DELETE_OTDREASON_SQL,[vData[0][0]]);
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end; 
end;

procedure TFNMFacadeLib.SaveReceiveBenchMark(var vData: OleVariant;
  iCount: Integer; var sErrorMsg: WideString);
const
  UPDATE_RECEIVEBENCHMARK_SQL = 'UPDATE dbo.fnReceiveBenchmarkList SET  Quantity= ''%s'',Operator = ''%s'', Operate_Time = GETDATE()  WHERE GF_Type = ''%s'' AND Quantity <> ''%s'''+#13;
var SqlText: WideString;
 i: Integer;
begin
  try
  SqlText := '';
    for i := 0 to iCount - 1 do
    SqlText := SqlText + Format(UPDATE_RECEIVEBENCHMARK_SQL,[Copy(vData[i][0],Pos('=',vData[i][0])+1,10),vData[i][1],Copy(vData[i][0],1,Pos('=',vData[i][0])-1),Copy(vData[i][0],Pos('=',vData[i][0])+1,10)]);
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.SaveMutexChemical(var vData: OleVariant;
  iCount: Integer; var sErrorMsg: WideString);
const
  INSERT_MUTEXCHEMICAL_SQL = 'INSERT INTO dbo.fnMutexChemicalList(Chemical_ID,Mutex_ID,Operator,Operate_Time) VALUES(''%s'',''%s'', ''%s'',GETDATE())'+#13;
var
  i: Integer;
  SqlText: WideString;
begin
  try
  SqlText := 'DELETE  dbo.fnMutexChemicalList'+#13;
    for i := 0 to iCount - 1 do
      SqlText := SqlText + Format(INSERT_MUTEXCHEMICAL_SQL,[vData[i][0],vData[i][1],vData[i][2]]);
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.GetInnerRepairInfo(const sCurrent_Department,
  sDatetime: WideString; var vData: OleVariant; var sErrorMsg: WideString);
{ cuijf 2008-6-16 改用Check_Time时间查询
const
  QuerySQLTEXT = 
    'DECLARE @BeginTime datetime, @EndTime datetime'#13#10 +
    'SET @BeginTime = ''%s'''#13#10 +
    'SET @BeginTime = CONVERT(varchar(10), @BeginTime, 120) + '' 07:00:00'''#13#10 +
    'SET @EndTime = CONVERT(varchar(10), @BeginTime + 1, 120) + '' 07:00:00'''#13#10 +
    'SELECT a.Iden, dbo.udf_GetGFNO(GF_ID) AS GF_NO, Quantity, FN_Card,'#13#10 +
    '  b.Reason_Info, b.Quality_Type,'#13#10 +
    '  dbo.udf_GetInnerRepairOperations(-1, a.Iden) AS Repair_Operations,'#13#10 +
    '  a.Remark AS Org_Remark, a.Operator, a.Operate_Time, Is_Ignore, Ignore_Remark, Ignorer, Ignore_Time,'#13#10 +
    '  CONVERT(bit, 0) AS Changed'#13#10 +
    '  INTO #TmpTable'#13#10 +
    '  FROM dbo.fnRepairOperation a WITH(NOLOCK)'#13#10 +
    '  INNER JOIN dbo.fnRepairReasonHdrList b WITH(NOLOCK) ON a.Reason_Code = b.Reason_Code'#13#10 +
    'WHERE a.Operate_Time BETWEEN @BeginTime AND @EndTime'#13#10 +
    '  AND Internal_External = 0'#13#10 +
    '  AND Current_Department = ''%s'''#13#10 +
    'ORDER BY a.Operate_Time'#13#10 +
    'SELECT * FROM #TmpTable'#13#10 +
    'DROP TABLE #TmpTable';
    }
var
  SqlText: WideString;
begin
  try
    //SqlText:=Format(QuerySQLTEXT, [sDatetime, sCurrent_Department]);
    SqlText := 'EXEC FNMDB..usp_fnGetInnerRepairInfo '+ QuotedStr(sDatetime)+','''','+ QuotedStr(sCurrent_Department);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;


procedure TFNMFacadeLib.SaveIgnoredInnerRepairInfo(vData: OleVariant;
  var sErrorMsg: WideString);
const
  UpdateRepairReasonHdr = 'UPDATE FNMDB.dbo.fnRepairOperation SET Is_Ignore = %d, Ignore_Remark = ''%s'', Ignorer = ''%s'', Ignore_Time = GETDATE() WHERE Iden = %d'#13#10;
var
  i: Integer;
  SqlText: WideString;
  TempDataSet: TClientDataSet;
begin
  try
    TempDataSet:=TClientDataSet.Create(nil);
    try
      TempDataSet.Data:=vData;

      SqlText:='';
      for i := 0 to TempDataSet.RecordCount - 1 do
      begin
        SqlText:=SqlText +
          Format(UpdateRepairReasonHdr, [
            IfThen(TempDataSet.FieldByName('Is_Ignore').AsBoolean, 1, 0),
            TempDataSet.FieldByName('Ignore_Remark').AsString,
            TempDataSet.FieldByName('Ignorer').AsString,
            TempDataSet.FieldByName('Iden').AsInteger
            ]);

        TempDataSet.Next;
      end;
    finally
      TempDataSet.Free
    end;
    
    FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
    //sErrorMsg:=SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.GetRecipeChemical(const sBatchNO: WideString;
  var vData: OleVariant; var sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  SqlText := ' select d.* from dbo.fnOperationRecipeBatch a (NOLOCK) '
            +' join dbo.fnOperationRecipeDtl d (NOLOCK) ON d.Recipe_NO = a.Recipe_NO where a.Batch_NO= '+ QuotedStr(sBatchNO);
  try
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.SaveData(const sType: WideString;
  vData: OleVariant; var sErrorMsg: WideString);
var
  sKey, sSQL, sSQLAfter: WideString;
begin
  if sType= 'RecipeChemical' then
  begin
    sSQL := ' select * from dbo.fnOperationRecipeDtl where 1=2';
    //用sErrorMsg传缸号过来用
    sSQLAfter := 'Exec usp_fnExportRecipeToCS '+ sErrorMsg;
    sKey := 'Recipe_NO,Chemical_ID';
  end
  else if sType= 'FIDutyPoints' then
  begin
    sSQL := 'select * from fnFIDuty where 1=2';
    sKey := 'Fabric_NO,Worker_ID';
  end;

  try
    FNMDAOUpt.SaveMultiDataSet(vData, sSQL, sKey, sSQLAfter, sErrorMsg, false);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.SaveSDTraceInfo(var vData: OleVariant;
  iType: Integer; var sErrorMsg: WideString);
const
   INSERTSDTRACESQL = 'INSERT INTO dbo.fnSDTrace(GF_ID, Job_NO, Trace_Text, FN_Delivery_Date, Operation_Code, Recipients, Is_Email, Current_Department, Operator, Operate_Time) ' +
                      'VALUES(''%s'',''%s'' ,''%s'' ,''%s'' ,''%s'' ,''%s'' ,''%s'' ,''%s'' ,''%s'' ,GETDATE())'+#13#10;
   UPDATESDTRACESQL = 'UPDATE dbo.fnSDTrace SET Trace_Text = ''%s'', FN_Delivery_Date = ''%s'', Operation_Code = ''%s'', Recipients = ''%s'', Is_Email = ''%s'', Operator = ''%s'', Operate_Time = GETDATE() ' +
                      'WHERE GF_ID= ''%s'' AND Job_NO = ''%s'' AND Current_Department = ''%s'''+#13#10;
   RELEASESDTRACESQL = 'UPDATE dbo.fnSDTrace SET Releaser = ''%s'', Release_Time = GETDATE() ' +
                      'WHERE GF_ID= ''%s'' AND Job_NO = ''%s'' AND Current_Department = ''%s'''+#13#10;
   HOLDSQL = 'INSERT dbo.fnHold(GF_ID, Operation_Code, Hold_Reason, Holder, Is_EffectRepair) '+
             ' VALUES(''%s'',''%s'',''重要试样跟踪'', ''%s'', 0) '+#13#10;
   RELEASEHOLDSQ = 'UPDATE dbo.fnHold SET Release_Reason =''解除重要试样跟踪'', Releaser = ''%s'', Release_Time = GETDATE() '+
                    'WHERE GF_ID = ''%s'' AND Operation_Code = ''%s'' AND Hold_Reason = ''重要试样跟踪'''+#13#10;

var SqlText: WideString;
    i: Integer;
begin
  try
    case iType of
      0: begin
           for i := 0 to VarArrayHighBound(vData, 1) do
             SqlText := SqlText+Format(INSERTSDTRACESQL,[vData[i][0],vData[i][1],vData[i][2],vData[i][3],vData[i][4],vData[i][5],vData[i][6],vData[i][7],vData[i][8]])
                               +Format(HOLDSQL,[vData[i][0],vData[i][4],vData[i][8]]);
         end;

      1: begin
          for i := 0 to VarArrayHighBound(vData, 1) do
            SqlText := SqlText+Format(UPDATESDTRACESQL,[vData[i][2],vData[i][3],vData[i][4],vData[i][5],vData[i][6],vData[i][8],vData[i][0],vData[i][1],vData[i][7]]);
         end;
      2: begin
           for i := 0 to VarArrayHighBound(vData, 1) do
            SqlText := SqlText+Format(RELEASESDTRACESQL,[vData[i][3],vData[i][0],vData[i][1],vData[i][2]])
                              +Format(RELEASEHOLDSQ,[vData[i][3],vData[i][0],vData[i][4]]);
         end;
    end;
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.SaveRSTraceInfo(var vData: OleVariant;
  var sErrorMsg: WideString);
const
   UPDATERSTRACESQL = 'UPDATE dbo.fnRSTrace SET Times_1 = ''%s'', Times_2 = ''%s'', Times_3 = ''%s'', Operator = ''%s'', Operate_Time = GETDATE() ' +
                      'WHERE GF_ID= ''%s'' AND Job_NO = ''%s'''+#13#10;
var SqlText: WideString;
  i:Integer;
begin
  try
    for i := 0 to VarArrayHighBound(vData, 1) do
      SqlText := SqlText+Format(UPDATERSTRACESQL,[vData[i][0],vData[i][1],vData[i][2],vData[i][3],vData[i][4],vData[i][5]]);
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.SaveSampleInfo(var vParam: OleVariant;
  var sErrorMsg: WideString);
var i:Integer;
  SqlText: String;
const INSERTSAMPLEINFOSQL ='INSERT INTO dbo.fnSampleInfo(GF_ID,Job_NO,Fabric_NO, Internal_Repair_Times, External_Repair_Times, Step_NO,Operation_Code, Machine_ID,Sample_Code,Actual_Sample_QTY,Sampler,Sample_Time,Current_Department) '+#13+
                              'VALUES(''%s'', ''%s'', ''%s'',''%s'', ''%s'',''%s'',''%s'', ''%s'', ''%s'',''%s'', ''%s'', GETDATE(), ''%s'')'+#13#10;
begin
  try
    for i := 0 to VarArrayHighBound(vParam, 1) do
       SqlText := SqlText+Format(INSERTSAMPLEINFOSQL,[vParam[i][0], vParam[i][1],LeftStr(vParam[i][2],12),MidStr(vParam[i][2],14,1),MidStr(vParam[i][2],17,1),
                                                      vParam[i][3],vParam[i][4],vParam[i][5],vParam[i][6],vParam[i][7],vParam[i][8],vParam[i][9]]);
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMFacadeLib.SaveMultiData(const sTable1, sTable2: WideString;
  var vData1, vData2: OleVariant; const sSQLText_Before, sSQLText_After,
  sKey1, sKey2: WideString; var sErrorMsg: WideString);
var
  sSQL1, sSQL2: widestring;
begin
  try
    if sTable1 <> '' then
      sSQL1 := 'select * from ' + sTable1 + ' where 1=2'
    else
      sSQL1 := '';
    //sSQL1:='exec Wmsdb.dbo.usp_stTableInfo '+QuotedStr(sTable1);
    if sTable2 <> '' then
      sSQL2 := 'select * from ' + sTable2 + ' where 1=2'
    else
      sSQL2 := '';
    //SaveMultiData为一个保存多表的通用函数
    //vData1为第一个表数据集，vData2为第二个表的数据集，sSQLText1为取第一个表
    //表结构的SQL语句，sSQLText2为取第二个表表结构的SQL语句，
    //sSQLText_After为保存完两个表后要执行的SQL语句
    //sSQLText_Before为保存两个表之前要执行的SQL语句
    //一般两个表为主表和明细表，sSQLText_After和sSQLText_Before为保存明细表时需要
    //更新回状态的SQL语句
    FNMDAOUpt.SaveMultiData(vData1, vData2, sSQL1, sSQL2, sSQLText_Before,
      sSQLText_After, sKey1, sKey2, sErrorMsg);
    SetComplete;
  except
    on e: Exception do
    begin
      sErrorMsg := e.Message;
      setabort;
    end;
  end;
end;

procedure TFNMFacadeLib.GetQueryBySQL(var vData: OleVariant;
  const sSQL: WideString; var sErrMsg: WideString);
begin    
  try
    FNMDAOInfo.GetCommonData(vData, sSQL, sErrMsg);
    SetComplete;
  except
    on e: Exception do
    begin
      sErrMsg := e.Message;
      SetAbort;
    end;
  end;
end;

procedure TFNMFacadeLib.SaveSQLData(const sSQL: WideString;
  var sErrMsg: WideString);
begin
  try
    FNMDAOUpt.ExeCommonSql(sSQL, sErrMsg);
    if sErrMsg='' then SetComplete;
  except
    on e: Exception do
    begin
      sErrMsg := e.Message;
      SetAbort;
    end;
  end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TFNMFacadeLib, Class_FNMFacadeLib,
    ciMultiInstance, tmNeutral);
end.

