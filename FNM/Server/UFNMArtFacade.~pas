unit UFNMArtFacade;
{*|<PRE>*****************************************************************************
                                                                             
       软件名称 FNM CLIENT MODEL                                               
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT
       单元名称 UFNMArtFacade.pas                                              
       创建日期 2004-8-31 下午 12:02:37
       创建人员 lvzd
       修改人员                                                                
       修改日期
       修改原因                                                                
       对应用例                                                                
       字段描述                                                                
       相关数据库表
       调用重要函数/SQL对象说明                                                
       功能描述 与工艺相关的接口类的实现.
                                                                              
******************************************************************************}
{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ActiveX, Mtsobj, Mtx, ComObj, FNMFacade_TLB, StdVcl, ComDllPub, SysUtils,
  DBClient, StrUtils, Math, Classes, Controls, DateUtils, DB, Variants, XMLDoc;

const
  DateTimeFmtStr = 'yyyy-mm-dd 07:00:00';

type
  TFNMArtFacadeLib = class(TMtsAutoObject, IFNMArtFacadeLib)
  {* 工艺接口实现类}
  protected
    procedure GetCADInfo(out vData: OleVariant; const sGF_KeyValue: WideString; iType: Integer; out sErrorMsg: WideString); safecall;
    procedure GetNoCheckGFNO(const sDept: WideString; out vData: OleVariant;
      out sErrorMsg: WideString); safecall;
    procedure SaveStdArt(vDataHdr: OleVariant; var vDataDtl: OleVariant;
      vDataParam: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetArtDtl(iArtID: Integer; const sArtType: WideString;
      out vData1, vData2: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetNoArtRepairCard(const sDepartment: WideString;
      var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetPrescriptionInfo(iPrescripType: Integer;
      const sPrescrip_NO: WideString; out vDataHdr, vDataDtl,
      vDataCard: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetAssiPrescriptionNO(const sGF_KeyValue: WideString; out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetNoFinishPrescriptionNOList(var vData: OleVariant;
      var sErrorMsg: WideString); safecall;
    procedure GetNoFinishFactPrescrip_NO(out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetChemicalByPrescrip_NO(const sPrescrip_NO: WideString; bIsStdPrescrip_NO: WordBool; var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveFactArt(vDataHdr, vDataDtl, vDataParam: OleVariant;
      var sErrorMsg: WideString); safecall;
    procedure SaveRepairArt(var vData: OleVariant; vDataHdr,
      vDataDtl: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveAssiPrescription(const sCardList: WideString;
      vDataHdr: OleVariant; var vDataDtl: OleVariant;
      var sErrorMsg: WideString); safecall;
    procedure GetNoCheckAssiPrescription(const sDeparement: WideString; out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetSendCardByDate(sDate: TDateTime; var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveCardArtReview(const sCard, sOperator: WideString; vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveDipCardList(const sOperationCode, sCardList, sGFIDList,
      sOperator: WideString; var sErrorMsg: WideString); safecall;
    procedure SaveFactAssiPrescription(iUpdateMode: Integer;
      const sPrescrip_NO: WideString; vDataHdr: OleVariant;
      var vDataDtl: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetAccidentInfo(const sAccident_NO: WideString; var vDataHdr,
      vDataDtl, vDataCard: OleVariant; var sErrorMsg: WideString);
      safecall;
    procedure SaveAccidentInfo(const sCardList: WideString;
      var vDataHdr: OleVariant; vDataDtl: OleVariant; const sDeparement,
      sOperator: WideString; var sErrorMsg: WideString); safecall;
    procedure GetAccidentNOList(const sDataClass, sDepartment: WideString;
      var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetAccidentCardList(const sAccident_NO: WideString; out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetAccidentDisposeInfo(const sAccident_NO: WideString; out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure SaveDisposeInfo(const sAccident_NO, sQualityOperation,
      sDisposeInfo, sReasonCode, sRepairCardList, sRepairOperation,
      sUnHoldCardList, sOperator: WideString; var sErrorMsg: WideString);
      safecall;
    procedure GetNoFinishRecipe(const sDepartment: WideString;
      var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveRecipe(iUpdateMode: Integer; const sRecipe_NO: WideString;
      sBase_Volume: Integer; const sMachine_ID, sOperator,
      sCardList: WideString; var sErrorMsg: WideString); safecall;
    procedure GetOnLineCard(const sCLassName, sParam1, sParam2: WideString;
      out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetSampleInfo(out vData: OleVariant; const sFN_Card: WideString;
      out sErrorMsg: WideString); safecall;
    procedure GetOperationListByFN_Card(const sFN_Card: WideString;
      out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetDefectAnalysisWorker(iStepNO, iOperationTimes: Integer;
      const sFnCard, sMachine_ID, sOperate_Time,
      sCurrent_Department: WideString; out vData: OleVariant;
      out sErrorMsg: WideString); safecall;
    procedure SaveCheckStdArt(const sSTD_Art_ID, sVersion, sCurrent_department,
      sChecker: WideString; iType: Integer; out sErrorMsg: WideString);
      safecall;
    procedure SaveCheckAssistantPrescription(const sChecker,
      sAssistant_Prescrip_NO: WideString; out sErrorMsg: WideString);
      safecall;
    procedure GetUsedPrescripNOCard(const sGF_KeyValue, sOperation_Code,
      sPrescrip_NO, sDepartment: WideString; out vData1,
      vData2: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetCheckGFIDAndSTDArt(const sGF_KeyValue,
      sDepartment: WideString; out iGF_ID, iSTD_Art_ID: Integer;
      out sErrorMsg: WideString); safecall;
    procedure SaveRecipeTraceInfo(const sOperateClass, sVatCode,
      sRecipe_NO: WideString; sScrapVolume: Single;
      const sOperator: WideString; out sErrorMsg: WideString); safecall;
    procedure GetFNCardsByRecipeNO(const sRecipeNO: WideString;
      out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure SaveReceiveSample(const sIdenList, sOperator: WideString;
      out sErrorMsg: WideString); safecall;
    procedure SaveAnalysisQualtityData(vDataHdr, vDataDtl: OleVariant;
      sDate: TDateTime; const sDepartment: WideString;
      out sErrorMsg: WideString); safecall;
    procedure GetFNNOList(iGetType: Integer; out vData: OleVariant;
      out sErrorMsg: WideString); safecall;
    procedure GetCheckSpecialArt(iGF_ID, iIsNormal: Integer;
      const sOperationStr, sCurrentDepartment: WideString;
      out sErrorMsg: WideString); safecall;
    procedure GetCardByFabricList(const sFabricList: WideString;
      out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure SaveUserDefindSample(const sTestItem, sOperator: WideString;
      out sFactSampleNO, sErrorMsg: WideString); safecall;
    procedure SaveHLReceiveSendInfo(const sType, sFN_NOs,
      sOperator: WideString; out sErrorMsg: WideString); safecall;
    procedure GetFNNOInfo(const sFN_NO: WideString; out vData: OleVariant;
      out sErrorMsg: WideString); safecall;
    procedure SaveHLArtInfo(const Department: WideString; vDataHdr: OleVariant;
      var vDataDtl: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetHLBasicInfo(const sFN_NO: WideString; var vData: OleVariant;
      var sErrorMsg: WideString); safecall;
    procedure GetArtItemInfo(iGF_ID: Integer; out vData: OleVariant;
      out sErrorMsg: WideString); safecall;
    procedure SaveNewRecipe(const sPrescripNO, sFNCards, sOperationCode,
      sMachineID, sBaseVolume, sDepartment, sOperator: WideString;
      out sErrorMsg: WideString); safecall;
    procedure GetNoPrescripCard(const sGFKey_Value, sDepartment,
      sOperation_Code: WideString; out vData: OleVariant;
      out sErrorMsg: WideString); safecall;
    procedure GetUnFinishJobTraceDtl(const sFNCards: WideString;
      iStepNO: Integer; out vData: OleVariant; out sErrorMsg: WideString);
      safecall;
    procedure GetStdPrescriptionDtl(const sPrescrip_NO: WideString;
      out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure SaveStdPrescription(var vDataParam: OleVariant;
      var sPrescriptionNO: WideString; out sErrorMsg: WideString);
      safecall;
    procedure GetArtReview(const sFN_Card: WideString; out vData: OleVariant;
      out sErrorMsg: WideString); safecall;
    procedure GetConStr(out sConStr: WideString); safecall;
    procedure GetOnlineStdPrescripNO(const sOperationCode,
      sDepartment: WideString; out sStdPrescripNOs: OleVariant;
      out sErrorMsg: WideString); safecall;
    procedure GetFactArtDtl(iFactArtID: Integer; out vData: OleVariant;
      out sErrorMsg: WideString); safecall;
    procedure GetAccidentInfoByFNCard(const sFN_Card: WideString;
      var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveCheckRepairArt(iFactArtID: Integer;
      const sOperator: WideString; out sErrorMsg: WideString); safecall;
    procedure GetRecipeInfo(const sRecipeNO: WideString; out vDataHdr,
      vDataDtl, vDataCard: OleVariant; out sErrorMsg: WideString);
      safecall;
    procedure SaveHandRecipe(const sCardList: WideString; vDataHdr,
      vDataDtl: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetNoCheckRecipe(const sDeparement: WideString;
      out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure SaveCheckRecipe(const sChecker, sRecipeNO: WideString;
      out sErrorMsg: WideString); safecall;
    procedure SaveBatchTraceInfo(const sOperateType, sBatchNO: WideString;
      sScrapVolume: Integer; const sOperator: WideString;
      var sErrorMsg: WideString); safecall;
    procedure GetNoRecipeCards(const sGFKeyValue,
      sCurrentDepartment: WideString; out vData: OleVariant;
      out sErrorMsg: WideString); safecall;
    procedure GetNoFinishRecipeBatch(const sVatStudio: WideString;
      out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure SaveSplitRecipe(const sRecipeNO, sVatCode, sUserVol,
      sOperator: WideString; out vData: OleVariant;
      out sErrorMsg: WideString); safecall;
    procedure SaveDelABatch(const sBatchNO: WideString;
      out sErrorMsg: WideString); safecall;
    procedure GetBatchDtlInfo(const sBatchNO: WideString;
      out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure SaveNewRecipeVol(const sRecipeNO, sOffsetVol: WideString;
      out sErrorMsg: WideString); safecall;
    procedure SaveDelRecipe(const sRecipeNO, sUserType: WideString;
      out sErrorMsg: WideString); safecall;
    procedure GetMachineRecipeBatch(const sDepartment, sMachineID: WideString;
      out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetNoRecipeSteps(const sOperationCode, sDepartment, sMachineID,
      sBeginTime, sEndTime: WideString; out vData: OleVariant;
      out sErrorMsg: WideString); safecall;
    procedure SaveSupplyRecipe(const sTracIdens, sOperationCode, sPrescripNO,
      sMachineID, sDepartment, sOperator: WideString;
      out sErrorMsg: WideString); safecall;
    procedure GetDiluteRecipeInfo(var vData0, vData1, vData2: OleVariant;
      const sBatch_NO: WideString; var sErrorMsg: WideString); safecall;
    procedure SaveDiluteRecipeInfo(IsNew: Integer; var vData0,
      vData1: OleVariant; var sErrorMsg: WideString); safecall;
    procedure DeleteInnerRepairInfo(iAnalysisIden: Integer;
      const sOperator: WideString; var sErrorMsg: WideString); safecall;
    procedure CheckNeedRoll(const sGFIDList: WideString; var NeedRoll,
      sErrorMsg: WideString); safecall;
    procedure ModifyProductWidth(const sGF_Key: WideString; iWidth: Single;
      const sReason, sOperator: WideString; var sErrorMsg: WideString);
      safecall;
    procedure CreateRepairArtInfo(Iden, GF_ID: Integer; const sCardList,
      sCurrent_Department, sOperator: WideString; var vData0,
      vData1: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetEditCardLists(const sGF_NO, sCurrent_Department: WideString;
      var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure ChangeVatCode(const sBatchNO, sNewVatCode: WideString;
      var sErrorMsg: WideString); safecall;
    procedure AutoCreateStdArtDtl(const sGFNO, sCurrentDepartment: WideString;
      var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveModifiedArtLog(const sStr: WideString;
      var sErrorMsg: WideString); safecall;
    procedure GetFeedbackInfo(var vData: OleVariant; iGF_ID: Integer;
      const sCurrent_Department: WideString; var sErrorMsg: WideString);
      safecall;
    procedure SaveFeedbackInfo(var vDataParam: OleVariant;
      var sErrorMsg: WideString); safecall;
  end;
implementation

uses ComServ;

procedure TFNMArtFacadeLib.GetNoCheckGFNO(const sDept: WideString;
  out vData: OleVariant; out sErrorMsg: WideString);
safecall;
var
  SqlText:WideString;
begin
  try
    SqlText := 'exec usp_GetNOCheckGFNO '+ QuotedStr(sDept);

    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetCADInfo(out vData: OleVariant; const sGF_KeyValue: WideString;
  iType: Integer; out sErrorMsg: WideString); safecall;
var
  SqlText:WideString;
begin
  try
    if iType = 0 then
      SqlText:= Format('SELECT GF_ID, GF_NO, Info FROM PDMDB.dbo.tdPatternControlInfo WHERE GF_ID = dbo.udf_GetGFID(''%s'') ', [sGF_KeyValue])
    else
      SqlText:=Format('EXEC dbo.usp_GetCADInfo ''%s''', [sGF_KeyValue]);
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise
  end;
end;

procedure TFNMArtFacadeLib.GetArtDtl(iArtID: Integer; const sArtType: WideString;
  out vData1, vData2: OleVariant;  out sErrorMsg: WideString);
var
  SqlText:WideString;
  vDataTemp: OleVariant;
begin
  try
    SqlText:= Format('EXEC dbo.usp_GetArtInfo ''%d'', ''%s''', [iArtID, sArtType]);
    FNMDAOInfo.GetMultiDataSet(SqlText, vData1, vData2, vDataTemp, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveStdArt(vDataHdr: OleVariant;
  var vDataDtl: OleVariant; vDataParam: OleVariant;
  var sErrorMsg: WideString);
var
  i: Integer;
  SqlText: String;
  cds_Art: TClientDataSet;
begin
  cds_Art:=nil;
  try
    cds_Art:=TClientDataSet.Create(nil);
    try
      cds_Art.Data:=vDataHdr;
      SqlText :='DECLARE @STD_Art_ID Int '+ #13;
      with cds_Art do
      begin
        //如果 Art_ID为空表明是新建立的工艺,则插入数据库,否则更新数据库
        if cds_Art.FieldByName('Art_ID').IsNull then
        begin
          //标准工艺主表插入新工艺
          SqlText := SqlText +
                     Format('IF EXISTS (SELECT TOP 1 * FROM  fnArtItem WHERE GF_ID = ''%S'') '#13#10, [FieldByName('GF_ID').AsString]) +
                     Format('UPDATE fnArtItem SET FN_Art_NO= ''%s'', FN_Color_Code = ''%s'', Shrinkage = ''%s'', HandFeel = ''%s'', Product_Width = ''%s'' ' +
                            '  WHERE GF_ID = ''%s'' AND Art_Type = ''B'' '#13#10, [
                              FieldByName('FN_Art_NO').AsString,      FieldByName('FN_Color_Code').AsString,
                              FieldByName('Shrinkage').AsString,      FieldByName('HandFeel').AsString,
                              FieldByName('Product_Width').AsString,   FieldByName('GF_ID').AsString]) +
                            'ELSE '#13#10 +
                            'INSERT INTO fnArtItem (GF_ID, Art_Type, FN_Art_NO, FN_Color_Code, Shrinkage, HandFeel, Product_Width)  ' +
                     Format('VALUES(''%s'', ''B'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'') '#13#10, [
                              FieldByName('GF_ID').AsString,           FieldByName('FN_Art_NO').AsString,
                              FieldByName('FN_Color_Code').AsString,   FieldByName('Shrinkage').AsString,
                              FieldByName('HandFeel').AsString,        FieldByName('Product_Width').AsString]) +
                            'INSERT INTO fnStdArtHdr (GF_ID, Current_Department, Operator, Remark) ' +
                     Format('VALUES(''%s'', ''%s'', ''%s'', ''%s'') '#13#10, [
                              FieldByName('GF_ID').AsString,     FieldByName('Current_Department').AsString,
                              FieldByName('Operator').AsString,  FieldByName('Remark').AsString]) +
                            'SET @STD_Art_ID =IDENT_CURRENT(''fnStdArtHdr'') '#13#10;
        end else
        begin
          SqlText := SqlText +
                     Format('UPDATE fnArtItem SET FN_Art_NO= ''%s'', FN_Color_Code = ''%s'', Shrinkage = ''%s'', HandFeel = ''%s'', Product_Width = ''%s'' ' +
                            'WHERE GF_ID = ''%s'' AND Art_Type = ''B'' '#13#10, [
                              FieldByName('FN_Art_NO').AsString,      FieldByName('FN_Color_Code').AsString,
                              FieldByName('Shrinkage').AsString,      FieldByName('HandFeel').AsString,
                              FieldByName('Product_Width').AsString,   FieldByName('GF_ID').AsString]) +
                     Format('UPDATE fnStdArtHdr SET Version=''%s'', Operator=''%s'', Operate_Time=GETDATE(), Remark=''%s'', ' +
                            'Is_Active=''%s'' WHERE STD_Art_ID= ''%s'''#13#10, [
                            FieldByName('Version').AsString,          FieldByName('Operator').AsString,
                            FieldByName('Remark').AsString,           ifthen(FieldByName('Is_Active').AsBoolean, '1', '0'),
                            FieldByName('Art_ID').AsString]) +
                     Format('SET @STD_Art_ID = ''%s'''#13#10, [FieldByName('Art_ID').AsString]) +
                            'DELETE fnStdArtDtl WHERE STD_Art_ID= @STD_Art_ID '+ #13;
        end;

        cds_Art.Close;
        SqlText:=SqlText + 'INSERT INTO dbo.fnStdArtDtl (STD_Art_ID, Operation_Code, Step_NO, Item_Name, Item_Value, Operator, Operate_Time) '#13;

        cds_Art.Data:=vDataDtl;
        cds_Art.First;
        for i := 0 to RecordCount - 1 do
        begin
        SqlText:=SqlText + Format('SELECT  @STD_Art_ID, ''%s'', ''%s'', ''%s'', UPPER(''%s''), ''%s'', ''%s''  UNION ALL'#13#10,
                                    [FieldByName('Operation_Code').AsString,
                                     FieldByName('Step_NO').AsString,
                                     FieldByName('Item_Name').AsString,
                                     FieldByName('Item_Value').AsString,
                                     FieldByName('Operator').AsString,
                                     FieldByName('Operate_Time').AsString]);
          Next;
        end;
      end;
      DELETE(sqlText,length(sqlText)-10,9);   //删除掉最后的 UNION ALL
      SqlText:=SqlText + 'SELECT @STD_Art_ID AS STD_Art_ID';

    //5  扩展标准工艺
     SqlText := SqlText + #13 + 'EXEC dbo.usp_SaveStdArtEx ' +
                           QuotedStr(vDataParam[0]) + ','+
                           QuotedStr(vDataParam[1]) + ','+
                           QuotedStr(vDataParam[2]) + ','+
                           QuotedStr(vDataParam[3]) + ','+
                           QuotedStr(vDataParam[4]);
      FNMDAOUpt.ExeCommonSqlWithResultData(SqlText, vDataDtl, sErrorMsg);
//      sErrorMsg:=SqlText;
      SetComplete;
    except
      SetAbort;
      raise;
    end;
  finally
    FreeAndNil(cds_Art);
  end;
end;

procedure TFNMArtFacadeLib.GetNoArtRepairCard(
  const sDepartment: WideString; var vData: OleVariant;
  var sErrorMsg: WideString);
var
  SqlText: String;
begin
  try
    SqlText:='SELECT a.FN_Card, a.GF_ID, b.GF_NO, dbo.udf_GetRepairReasonByFNCard(a.FN_Card) AS Repair_Reason, a.Quantity,0 AS RepairIden ' +
             'FROM dbo.fnJobTraceHdr a WITH(NOLOCK) ' +
             '  INNER JOIN PDMDB.dbo.tdGFID b WITH(NOLOCK) ON b.GF_ID = a.GF_ID '+
             'WHERE Fact_Art_ID = -1 AND FN_Card NOT IN (SELECT FN_Card FROM fnRepairCardAutoFactArtID) AND Current_Department = '+ QuotedStr(sDepartment) +#13#10+
             // 不用再显示一次
             // David 2014-10-10 add begin, 获取工艺疵点类型且自动生成了工序，参数的
             //'UNION ALL'#13#10+
             //'SELECT a.FN_Card, a.GF_ID, b.GF_NO, dbo.udf_GetRepairReasonByFNCard(a.FN_Card) AS Repair_Reason, a.Quantity,d.Iden AS RepairIden ' +
             //'FROM dbo.fnJobTraceHdr a WITH(NOLOCK) ' +
             //'  INNER JOIN PDMDB.dbo.tdGFID b WITH(NOLOCK) ON b.GF_ID = a.GF_ID '+
             //'  INNER JOIN fnRepairCardAutoFactArtID c WITH(NOLOCK) ON a.FN_Card=c.FN_Card ' +
             //'  INNER JOIN fnStock e  WITH(NOLOCK) ON e.FN_Card=c.FN_Card' +
             //'  INNER JOIN fnRepairReasonHdrList d WITH(NOLOCK) ON d.Reason_Code = e.Reason_Code ' +
             //'  WHERE e.Current_Department = '+ QuotedStr(sDepartment) +#13#10+
             // David 2014-10-10 add end, 获取工艺疵点类型且自动生成了工序，参数的
             'UNION ALL'#13#10+
             'SELECT a.FN_Card, a.GF_ID, b.GF_NO, c.Reason_Info + ''|'' + Quality_Type AS Repair_Reason, a.Quantity,a.Iden AS RepairIden '+
             'FROM dbo.fnRepairOperation a WITH(NOLOCK) ' +
             '  INNER JOIN PDMDB.dbo.tdGFID b WITH(NOLOCK) ON b.GF_ID = a.GF_ID ' +
             '  INNER JOIN dbo.fnRepairReasonHdrList c WITH(NOLOCK) ON c.Reason_Code = a.Reason_Code ' +
             'WHERE Check_Time IS NULL AND FN_Card NOT IN (SELECT FN_Card FROM fnRepairCardAutoFactArtID) AND Internal_External = 1 AND Current_Department = '+ QuotedStr(sDepartment);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetPrescriptionInfo(iPrescripType: Integer;
  const sPrescrip_NO: WideString; out vDataHdr, vDataDtl,
  vDataCard: OleVariant; out sErrorMsg: WideString);
var
  SqlText: String;
begin
  try
    SqlText:= Format('EXEC dbo.usp_GetPrescriptionInfo ''%d'', ''%s'' '#13#10, [iPrescripType, sPrescrip_NO]);
    FNMDAOInfo.GetMultiDataSet(SqlText, vDataHdr, vDataDtl, vDataCard, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetAssiPrescriptionNO(const sGF_KeyValue: WideString;
  out vData: OleVariant; out sErrorMsg: WideString);
var
  SqlText: String;
begin
  try
    SqlText:='SELECT Assistant_Prescrip_NO, dbo.udf_GetOperationName(Operation_Code, 0) AS Operation_CHN '+#13#10+
             'FROM dbo.fnAssistantPrescriptionHdr WITH(NOLOCK) '#13#10 +
             'WHERE GF_ID = dbo.udf_GetGFID('+QuotedStr(sGF_KeyValue)+') ';
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetNoFinishPrescriptionNOList(
  var vData: OleVariant; var sErrorMsg: WideString);
var
  SqlText: String;
begin
  try
    SqlText:= 'EXEC dbo.usp_GetNOFinishPrescriptionNOList';
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetNoFinishFactPrescrip_NO(out vData: OleVariant;
  out sErrorMsg: WideString);
var
  SqlText: String;
begin
  try
    SqlText:='SELECT Prescrip_NO, '#13#10 +
             '        Operation_Code, dbo.udf_GetOperationName(Operation_Code, 0) AS Operation_Name, '#13#10+
             '        GF_ID, PDMDB.dbo.udf_GetGF_NOByGF_ID(GF_ID) AS GF_NO, '#13#10 +
             '       CASE Type WHEN 0 THEN ''试2y'' ELSE ''大货'' END AS Type '#13#10 +
             '  FROM dbo.fnFactAssistantPrescriptionHdr '#13#10 +
             '   WHERE Recipe_Count = 0 '#13#10 +
             'ORDER BY 1';

    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetChemicalByPrescrip_NO(const sPrescrip_NO: WideString;
  bIsStdPrescrip_NO: WordBool; var vData: OleVariant; var sErrorMsg: WideString);
var
  SqlText: String;
begin
  try
    SqlText:= 'SELECT a.Iden, a.Chemical_ID, b.Chemical_Name, 0.0 as Dosage, b.Chemical_Type, b.Chemical_Type FROM '+
              Ifthen(bIsStdPrescrip_NO, ' dbo.fnStdPrescriptionDtl a WITH(NOLOCK) ', ' dbo.fnFactAssistantPrescriptionDtl a WITH(NOLOCK) ') +
              'LEFT JOIN PUBD.dbo.pbChemicalList b WITH(NOLOCK) ON a.Chemical_ID = b.Chemical_ID ' +
              'WHERE Prescrip_NO = '+QuotedStr(sPrescrip_NO);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveFactArt(vDataHdr, vDataDtl,
  vDataParam: OleVariant; var sErrorMsg: WideString);
const
  {
  INSERTARTHDRSQL=
    'DECLARE @Fact_Art_ID Int '#13#10 +
    'INSERT INTO fnFactArtHdr(GF_ID, Fact_Art_Version, STD_Art_ID, STD_Art_Version, Art_Type, Material_Quality, Operator, Remark)'#13#10 +
    '  VALUES(''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'')'#13#10 +
    'SET @Fact_Art_ID =IDENT_CURRENT(''fnFactArtHdr'')'#13#10;
  INSERTARTDTLSQL=
    'INSERT INTO dbo.fnFactArtDtl(FACT_Art_ID, Operation_Code, Step_NO, Item_Name, Item_Value, Operator, Operate_Time) '+
    'VALUES(@Fact_Art_ID, ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'')'#13#10;
  }
  INSERTARTHDRSQL=
    'DECLARE @Fact_Art_ID Int '#13#10 +
    'INSERT INTO fnFactArtHdr(GF_ID, Fact_Art_Version, STD_Art_ID, STD_Art_Version, Art_Type, Material_Quality, Operator, Remark)'#13#10 +
    '  VALUES(''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'')'#13#10 +
    'SET @Fact_Art_ID =IDENT_CURRENT(''fnFactArtHdr'')'#13#10 +
    'INSERT INTO dbo.fnFactArtDtl(FACT_Art_ID, Operation_Code, Step_NO, Item_Name, Item_Value, Operator, Operate_Time) '#13#10 ;
  SELECTARTDTLSQL= 'SELECT @Fact_Art_ID, ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s''  UNION ALL'#13#10;

 var
  cds_Art: TClientDataSet;
  SqlText: String;
begin
  cds_Art:=TClientDataSet.Create(nil);
  try
    try
      //检测是否有卡号已经被确认
      //2016-4-12 在坯布仓的也可以修改
      SqlText := 'IF EXISTS(SELECT TOP 1 1 FROM FNMDB.dbo.fnJobTraceHdr a WITH(NOLOCK) '+
                 '            LEFT JOIN FNMDB.dbo.fnStock b ON a.FN_Card = b.FN_Card  '+
                 '          LEFT JOIN QCMDB..gistockdtl c on c.fn_card = a.fn_card  ' +
                 '          WHERE a.FN_Card NOT LIKE ''N%''  AND b.FN_Card IS NULL   and c.Fn_Card is null '+
                 '            AND a.FN_Card IN (SELECT NO FROM PUBDB.dbo.udf_ConvertStrToTable('''+vDataParam[1]+''', '','')))' +#13#10 +
                 'BEGIN'#13#10 +
                 '  RAISERROR(''有卡号已经送布,请取消送布后再修改工艺.'', 16, 1)'#13#10 +
                 '  RETURN'#13#10 +
                 'END'#13#10;

     //2 插入实际工艺主表
      cds_Art.Data:=vDataHdr;
      with cds_Art do
      begin
        SqlText := SqlText + Format(INSERTARTHDRSQL,[FieldByName('GF_ID').AsString,
                                                     IntToStr(FieldByName('Fact_Art_Version').AsInteger + 1),
                                                     FieldByName('STD_Art_ID').AsString,
                                                     FieldByName('STD_Art_Version').AsString,
                                                     FieldByName('Art_Type').AsString,
                                                     FieldByName('Material_Quality').AsString,
                                                     FieldByName('Operator').AsString,
                                                     FieldByName('Remark').AsString]);
     end;
     //3 实际工艺明细表
     cds_Art.Data:=vDataDtl;
     with cds_Art do
     begin
       First;
       while not Eof do
       begin
         SqlText := SqlText + Format(SELECTARTDTLSQL,[FieldByName('Operation_Code').AsString,
                                                      FieldByName('Step_NO').AsString,
                                                      FieldByName('Item_Name').AsString,
                                                      FieldByName('Item_Value').AsString,
                                                      FieldByName('Operator').AsString,
                                                      FieldByName('Operate_Time').AsString]);
         Next;
       end;
     end;

     DELETE(SqlText,length(SqlText)-10,9);  //删除掉最后的 UNION ALL
     //5  扩展实际工艺
     SqlText := SqlText + 'EXEC dbo.usp_SaveFactArtEx @Fact_Art_ID,' +
                           QuotedStr(vDataParam[0]) + ','+
                           QuotedStr(vDataParam[1]) + ','+
                           QuotedStr(vDataParam[2]) + ','+
                           QuotedStr(vDataParam[3]) + ','+
                           QuotedStr(vDataParam[4]) + ','+
                           QuotedStr(vDataParam[5]) + ','+
                           QuotedStr(vDataParam[6]) + ','+
                           QuotedStr(vDataParam[7]);

      FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
//      sErrorMsg:=SqlText;
      SetComplete;
    except
      SetAbort;
      raise;
    end;
  finally 
    FreeAndNil(cds_Art);
  end;
end;

procedure TFNMArtFacadeLib.SaveRepairArt(var vData: OleVariant; vDataHdr,
  vDataDtl: OleVariant; var sErrorMsg: WideString);
const
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
          SqlText := SqlText + Format(INSERT_REPAIR_HDR_SQL,[FieldByName('GF_ID').AsString,
                                                             FieldByName('Art_Type').AsString,
                                                             FieldByName('Material_Quality').AsString,
                                                             FieldByName('Operator').AsString,
                                                             FieldByName('Remark').AsString]);

          SqlText := SqlText + 'SET @Fact_Art_ID =IDENT_CURRENT(''fnFactArtHdr'') '+ #13#10;

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
 //更新进度跟踪记录
  FNCardList:= vData[0][4];
  while FNCardList[Length(FNCardList)] = ',' do
    System.Delete(FNCardList, Length(FNCardList), 1);
  FNCardList:='(''' + StringReplace(FNCardList, ',', ''',''', [rfReplaceAll]) + ''')';

  if vData[0][0] = 1 then //IsQualityOperator    //便于操作班长输入工序时数据提取
    SqlText := SqlText + 'UPDATE dbo.fnJobTraceHdr SET Fact_Art_ID = -999 ' +
                          Format('WHERE FN_Card IN %s '#13#10, [FNCardList])
  else
    SqlText := SqlText + 'UPDATE fnJobTraceHdr SET FACT_Art_ID = @Fact_Art_ID, Step_NO = 1, Operation_Code = dbo.udf_GetOperationCode(@Fact_Art_ID, 1) '+
                          Format('WHERE FN_Card IN %s '#13#10, [FNCardList]);

  //增加扩展保存回修工艺
  if vData[0][0] <> 1 then
    SqlText := SqlText + ' EXEC dbo.usp_SaveRepairArtEx @Fact_Art_ID ';

  try
    //sErrorMsg:=SqlText;
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveAssiPrescription(
  const sCardList: WideString; vDataHdr: OleVariant;
  var vDataDtl: OleVariant; var sErrorMsg: WideString);
function GetUpdateJobTraceDtlSQLText(sCardList: String): String;
  var
    StringLen: Integer;
    FN_Card, Step_NO: String;
  begin
    while Length(sCardList) > 0 do
    begin
      StringLen:=Pos(',', sCardList);
      FN_Card:=LeftStr(sCardList, StringLen -1);
      System.Delete(sCardList, 1, StringLen);

      StringLen:=Pos(',', sCardList);
      Step_NO:=LeftStr(sCardList, StringLen -1);
      System.Delete(sCardList, 1, StringLen);

      result := result +
               Format('EXEC dbo.usp_SaveOperationInfoToJobTraceDtl ''%s'', ''%s'' '#13#10, [FN_Card, Step_NO]) +
               Format('UPDATE dbo.fnJobTraceDtl SET Assistant_Prescrip_NO = @Prescrip_NO WHERE FN_Card = ''%s'' AND Step_NO = ''%s'' '#13#10, [FN_Card, Step_NO]);
    end;
  end;
var
  SqlText: String;
  cds_Prescription: TClientDataSet;
begin
  cds_Prescription:=nil;
  try
    cds_Prescription:=TClientDataSet.Create(nil);
    try
      with cds_Prescription do
      begin
        Data:=vDataHdr;
        SqlText :='DECLARE @Prescrip_NO CHAR(12)'+ #13;
        //如果 Assistant_Prescrip_NO为空表明是新建立的配方,则插入数据库,否则更新数据库
        if FieldByName('Assistant_Prescrip_NO').IsNull then
          SqlText := SqlText +
            'EXEC usp_CreateNoteNO 1,'''', @Prescrip_NO OUTPUT '#13#10 +
            'INSERT INTO fnAssistantPrescriptionHdr (Assistant_Prescrip_NO, GF_ID, Operation_Code, Machine_ID, Speed, Pre_Dry_Temperature, '+
              'Dry_Temperature, Flood_Percent_Class, Flood_Percent, Dilute_Percent, Is_Need_Trace, Remark, Current_Department, Operator, Operate_Time, Version, Is_Active) '+
            Format('VALUES(@Prescrip_NO, %d, ''%s'', ''%s'', %d, %d, %d, ''%s'', ''%s'', %d, %s, ''%s'', ''%s'', ''%s'', GETDATE(), 0, %s) '#13#10, [
                    FieldByName('GF_ID').AsInteger,
                    FieldByName('Operation_Code').AsString,
                    FieldByName('Machine_ID').AsString,
                    FieldByName('Speed').AsInteger,
                    FieldByName('Pre_Dry_Temperature').AsInteger,
                    FieldByName('Dry_Temperature').AsInteger,
                    FieldByName('Flood_Percent_Class').AsString,
                    FieldByName('Flood_Percent').AsString,
                    FieldByName('Dilute_Percent').AsInteger,
                    ifthen(FieldByName('Is_Need_Trace').AsBoolean, '1', '0'),
                    FieldByName('Remark').AsString,
                    FieldByName('Current_Department').AsString,
                    FieldByName('Operator').AsString,
                    IfThen(FieldByName('Is_Active').AsBoolean, '1', '0')
                 ])
        else
        begin
          SqlText := SqlText +
            'SET @Prescrip_NO = '''+FieldByName('Assistant_Prescrip_NO').AsString+''' '#13#10 +
            'UPDATE fnAssistantPrescriptionHdr SET '+
            Format('Machine_ID = ''%s'', Speed= %d, Pre_Dry_Temperature= %d, Dry_Temperature= %d, ' +
                   'Flood_Percent_Class = ''%s'', Flood_Percent= ''%s'', Dilute_Percent = %d, ' +
                   'Is_Need_Trace= %s, Remark= ''%s'', Operator= ''%s'', Operate_Time= GETDATE(), '+
                   'Version= (CASE WHEN Checker = '''' THEN Version ELSE Version + 1 END), Is_Active= ''%s'' ',[
                    FieldByName('Machine_ID').AsString,
                    FieldByName('Speed').AsInteger,
                    FieldByName('Pre_Dry_Temperature').AsInteger,
                    FieldByName('Dry_Temperature').AsInteger,
                    FieldByName('Flood_Percent_Class').AsString,
                    FieldByName('Flood_Percent').AsString,
                    FieldByName('Dilute_Percent').AsInteger,
                    ifthen(FieldByName('Is_Need_Trace').AsBoolean, '1', '0'),
                    FieldByName('Remark').AsString,
                    FieldByName('Operator').AsString,
                    IfThen(FieldByName('Is_Active').AsBoolean, '1', '0')
            ])+'WHERE Assistant_Prescrip_NO= @Prescrip_NO '#13#10 +
            'DELETE fnAssistantPrescriptionDtl WHERE Assistant_Prescrip_NO = @Prescrip_NO '#13#10 +
            'UPDATE dbo.fnJobTraceDtl SET Assistant_Prescrip_NO = '''' WHERE Assistant_Prescrip_NO = @Prescrip_NO '#13#10;
        end;
        Close;
        Data:=vDataDtl;
        First;
        while not Eof do
        begin
          SqlText:=SqlText + 'INSERT INTO fnAssistantPrescriptionDtl (Assistant_Prescrip_NO, Chemical_ID, Unit_QTY) '+
                   Format('VALUES(@Prescrip_NO, %s, %g) '#13#10, [FieldByName('Chemical_ID').AsString, FieldByName('Unit_QTY').AsFloat]);
          Next;
        end;
      end;
      SqlText:=SqlText + GetUpdateJobTraceDtlSQLText(sCardList) + 
                        'SELECT @Prescrip_NO AS Prescrip_NO';
      FNMDAOUpt.ExeCommonSqlWithResultData(SqlText, vDataDtl, sErrorMsg);
      //sErrorMsg:=SqlText;
      SetComplete;
    except
      SetAbort;
      raise;
    end;
  finally
    FreeAndNil(cds_Prescription);
  end;
end;

procedure TFNMArtFacadeLib.GetNoCheckAssiPrescription(const sDeparement: WideString;
  out vData: OleVariant; out sErrorMsg: WideString);
var
  SqlText:WideString;
begin
  try
    SqlText:='SELECT Assistant_Prescrip_NO, PDMDB.dbo.udf_GetGF_NOByGF_ID(GF_ID) AS GF_NO, dbo.udf_GetOperationName(Operation_Code,0) AS Operation_CHN '#13#10 +
             'FROM dbo.fnAssistantPrescriptionHdr WITH(NOLOCK) '#13#10+
             'WHERE ISNULL(Checker, '''') ='''' AND Current_Department = '+QuotedStr(sDeparement);
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetSendCardByDate(sDate: TDateTime;
  var vData: OleVariant; var sErrorMsg: WideString);
var
  SqlText:WideString;
begin
  SqlText:='SELECT DISTINCT a.FN_Card, SUM(a.Quantity) AS Quantity, a.GF_NO '+#13#10+
           'FROM dbo.uvw_fnPay a WITH(NOLOCK)  '+#13#10+
           'WHERE Send_Time BETWEEN  '''+ FormatDateTime(DateTimeFmtStr, sDate) + ''' AND ''' + FormatDateTime(DateTimeFmtStr, IncDay(sDate)) + '''' +
           'AND a.FN_Card <> ''N/A'' AND NOT EXISTS(SELECT 1 FROM fnArtReview  WITH(NOLOCK) WHERE FN_Card = a.FN_Card) '#13#10 +
           'GROUP BY a.FN_Card, a.GF_NO';
  try
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveCardArtReview(const sCard,
  sOperator: WideString; vData: OleVariant; var sErrorMsg: WideString);
var
  SqlText: String;
  cds_ArtReview: TClientDataSet;
  const INSERTFNARTREVIEWSQL='INSERT INTO dbo.fnArtReview (FN_Card, Step_NO, Operation_Code, Item_Name, Item_Value, Operator) '+
                             'VALUES(''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'') '#13#10;
begin
  cds_ArtReview:=nil;
  SqlText :='';
  try
    cds_ArtReview:=TClientDataSet.Create(nil);
    try
      SqlText:=SqlText + Format('DELETE dbo.fnArtReview WHERE FN_Card = ''%s'' '#13#10, [sCard]);
      with cds_ArtReview do
      begin
        Data:=vData;
        while not Eof do
        begin
          SqlText:=SqlText + Format(INSERTFNARTREVIEWSQL,[sCard, cds_ArtReview['Step_NO'],
                                    cds_ArtReview['Operation_Code'], cds_ArtReview['Item_Name'],
                                    cds_ArtReview['Item_Value'], sOperator]);
          Next;
        end;
      end;
      //sErrorMsg:=SqlText;
      FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
      SetComplete;
    except
      SetAbort;
      raise;
    end;
  finally
    FreeAndNil(cds_ArtReview);
  end;
end;

procedure TFNMArtFacadeLib.SaveDipCardList(const sOperationCode, sCardList,
  sGFIDList, sOperator: WideString; var sErrorMsg: WideString);
var
  SqlText: String;
begin
  try
    SqlText:= Format('EXEC dbo.usp_SetDipOperation ''%s'', ''%s'', ''%s'',''Y'', '''',  ''%s''', [sOperationCode, sCardList,sGFIDList, sOperator]);
    FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
    //sErrorMsg:=SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveFactAssiPrescription(iUpdateMode: Integer;
  const sPrescrip_NO: WideString; vDataHdr: OleVariant;
  var vDataDtl: OleVariant; var sErrorMsg: WideString);
function GetDeleteFactAssiPrescriptionSQLText(Prescrip_NO: WideString): String;
  begin
    result:='DECLARE @Prescrip_NO char(12), @Assistant_Prescrip_NO char(12), @Parent_Prescrip_NO char(12), @Recipe_Count tinyint, @Type char(1) '#13#10 +
            'SET @Prescrip_NO = ''' + Prescrip_NO + ''''#13#10 +
            'SELECT @Recipe_Count = Recipe_Count, @Assistant_Prescrip_NO =Assistant_Prescrip_NO,  @Parent_Prescrip_NO = Parent_Prescrip_NO, @Type = Type '#13#10 +
            '  FROM dbo.fnFactAssistantPrescriptionHdr '#13#10 +
            '  WHERE Prescrip_NO = @Prescrip_NO '#13#10 +
            'IF (@Recipe_Count IS NULL) OR (@Parent_Prescrip_NO IS NULL) OR (@Type IS NULL) '#13#10 +
            'BEGIN '#13#10 +
            '  RAISERROR (''未找到指定的处方单号的处方单'', 16, 1) '#13#10 +
            '  RETURN '#13#10 +
            'END '#13#10 +
            //检测实际处方单是否已经完成
            'IF @Recipe_Count <> 0 '#13#10 +
            'BEGIN '#13#10 +
            '  RAISERROR (''处方单已经完成,不能删除'', 16, 1) '#13#10 +
            '  RETURN '#13#10 +
            'END '#13#10 +
            'IF @Type <> ''0'' '#13#10 +
            //更新进度跟踪从表实际处方单字段,type <> 0 表示该处方单为大货处方单
            '  UPDATE fnJobTraceDtl SET Prescrip_NO = '''' WHERE Prescrip_NO=@Prescrip_NO '#13#10 +
            //更新本处方单的子配方为本配方的父配方
            'UPDATE dbo.fnFactAssistantPrescriptionHdr SET Parent_Prescrip_NO = @Parent_Prescrip_NO WHERE Parent_Prescrip_NO = @Prescrip_NO '#13#10 +
            'UPDATE dbo.fnAssistantPrescriptionHdr SET Prescrip_Count = Prescrip_Count - 1 WHERE Assistant_Prescrip_NO = @Assistant_Prescrip_NO '#13#10 +
            //删除本配方
            'DELETE dbo.fnFactAssistantPrescriptionDtl WHERE Prescrip_NO = @Prescrip_NO '#13#10 +
            'DELETE dbo.fnFactAssistantPrescriptionHdr WHERE Prescrip_NO = @Prescrip_NO '#13#10;
  end;

  function GetInsterFactAssiPrescriptionSQLText(vDataHdr, vDataDtl: OleVariant): String;
  var
    i: Integer;
    cds_FactPrescription: TClientDataSet;
  begin
    cds_FactPrescription:=nil;
    try
      cds_FactPrescription:=TClientDataSet.Create(nil);
      with cds_FactPrescription do
      begin
        //构造插入主表的SQL
        Data:=vDataHdr;
        result :=
           'DECLARE @Prescrip_NO CHAR(12) '#13#10 +
           'EXEC usp_CreateNoteNO 2, '''', @Prescrip_NO OUTPUT '#13#10 +
           'INSERT INTO fnFactAssistantPrescriptionHdr (Prescrip_NO, Assistant_Prescrip_NO, ' +
           'GF_ID, Operation_Code, Machine_ID, Speed, Pre_Dry_Temperature, Dry_Temperature, ' +
           'Flood_Percent_Class, Flood_Percent, Is_Need_Trace, Dilute_Percent, Type, Current_Department, Remark, ' +
           'Operator, Parent_Prescrip_NO) '#13#10 +
    Format('VALUES(@Prescrip_NO, ''%s'', %d, ''%s'', ''%s'', %d, %d, %d, ''%s'', ''%s'', %d, ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'') '#13#10, [
              FieldByName('Assistant_Prescrip_NO').AsString,
              FieldByName('GF_ID').AsInteger,
              FieldByName('Operation_Code').AsString,
              FieldByName('Machine_ID').AsString,
              FieldByName('Speed').AsInteger,
              FieldByName('Pre_Dry_Temperature').AsInteger,
              FieldByName('Dry_Temperature').AsInteger,
              FieldByName('Flood_Percent_Class').AsString,
              FieldByName('Flood_Percent').AsString,
              ifthen(FieldByName('Is_Need_Trace').AsBoolean, 1, 0),
              FieldByName('Dilute_Percent').AsString,
              FieldByName('Type').AsString,
              FieldByName('Current_Department').AsString,
              FieldByName('Remark').AsString,
              FieldByName('Operator').AsString,
              FieldByName('Parent_Prescrip_NO').AsString]) +
        //标示标准配方单已有开出的配方
        Format('UPDATE dbo.fnAssistantPrescriptionHdr SET Prescrip_Count = Prescrip_Count + 1 WHERE Assistant_Prescrip_NO = ''%s'' '#13#10, [FieldByName('Assistant_Prescrip_NO').AsString]);
        if FieldByName('Type').AsString <> '0' then
        begin
          result := result +
            //非试2y的处方单写入进度跟踪明细数据表
            Format('UPDATE dbo.fnJobTraceDtl SET Prescrip_NO = @Prescrip_NO WHERE Assistant_Prescrip_NO = ''%s'' '#13#10, [FieldByName('Assistant_Prescrip_NO').AsString]) +
            //将其他的实际处方单标示为试2y的
            Format('UPDATE dbo.fnFactAssistantPrescriptionHdr SET Type = 0 WHERE Assistant_Prescrip_NO = ''%s'' AND Prescrip_NO <> @Prescrip_NO '#13#10, [FieldByName('Assistant_Prescrip_NO').AsString]);
        end;
        //构造插入从表的SQL
        Data:=vDataDtl;
        for i := 0 to RecordCount - 1 do
        begin
          result := result +
                   'INSERT INTO fnFactAssistantPrescriptionDtl (Prescrip_NO, Chemical_ID, Unit_QTY) '+
                   Format('VALUES(@Prescrip_NO, %s, %g) '#13#10, [FieldByName('Chemical_ID').AsString, FieldByName('Unit_QTY').AsFloat]);
          Next;
        end;
      end;
    finally
      FreeAndNil(cds_FactPrescription);
    end;
  end;

  function GetUpdateFactAssiPrescriptionSQLText(vDataHdr, vDataDtl: OleVariant): String;
  var
    i: Integer;
    FactPrescriptionType: String;
    cds_FactPrescription: TClientDataSet;
  begin
    cds_FactPrescription:=nil;
    try
      cds_FactPrescription:=TClientDataSet.Create(nil);
      with cds_FactPrescription do
      begin
        //构造插入主表的SQL
        Data:=vDataHdr;
        FactPrescriptionType:=FieldByName('Type').AsString;
        result:=
          'DECLARE @Prescrip_NO char(12), @Recipe_Count tinyint, @Type char(1) '#13#10 +
          'SET @Prescrip_NO = ''' + FieldByName('Prescrip_NO').AsString + ''''#13#10 +
          //判断该处方单是否已完成
          'SELECT @Recipe_Count = Recipe_Count, @Type = Type FROM fnFactAssistantPrescriptionHdr WHERE Prescrip_NO = @Prescrip_NO '#13#10 +
          'IF (@Recipe_Count IS NULL) OR (@Type IS NULL) '#13#10 +
          'BEGIN '#13#10 +
          '  RAISERROR (''未找到指定的处方单号的处方单'', 16, 1) '#13#10 +
          '  RETURN '#13#10 +
          'END '#13#10 +
          'IF @Recipe_Count <> 0 '#13#10 +
          'BEGIN '#13#10 +
          '  RAISERROR (''处方单已经完成,不能修改'', 16, 1) '#13#10 +
          '  RETURN '#13#10 +
          'END '#13#10 +

          //更新主表
          'UPDATE fnFactAssistantPrescriptionHdr '#13#10 +
   Format('SET Machine_ID = ''%s'', Speed = %d, Pre_Dry_Temperature = %d, Dry_Temperature = %d, '#13#10 +
          '    Flood_Percent_Class = ''%s'', Flood_Percent = ''%s'', Is_Need_Trace = %d, Dilute_Percent = ''%s'', Type = ''%s'', '#13#10 +
          '    Remark = ''%s'', Operator = ''%s'', Operate_Time = GETDATE() '#13#10, [
            FieldByName('Machine_ID').AsString,
            FieldByName('Speed').AsInteger,
            FieldByName('Pre_Dry_Temperature').AsInteger,
            FieldByName('Dry_Temperature').AsInteger,
            FieldByName('Flood_Percent_Class').AsString,
            FieldByName('Flood_Percent').AsString,
            ifthen(FieldByName('Is_Need_Trace').AsBoolean, 1, 0),
            FieldByName('Dilute_Percent').AsString,
            FieldByName('Type').AsString,
            FieldByName('Remark').AsString,
            FieldByName('Operator').AsString]) +
          'WHERE Prescrip_NO = @Prescrip_NO '#13#10 +
           //删除从表原来的记录
          'DELETE fnFactAssistantPrescriptionDtl WHERE Prescrip_NO = @Prescrip_NO '#13#10 +
          //防止非试2y的处方单变改为试2y的处方单
          'UPDATE dbo.fnJobTraceDtl SET Prescrip_NO = '''' WHERE Prescrip_NO = @Prescrip_NO '#13#10;
        if FieldByName('Type').AsString <> '0' then
        begin
          result := result +
            //非试2y的处方单写入进度跟踪明细数据表
            Format('UPDATE dbo.fnJobTraceDtl SET Prescrip_NO = @Prescrip_NO WHERE Assistant_Prescrip_NO = ''%s'' '#13#10, [FieldByName('Assistant_Prescrip_NO').AsString]) +
            //将其他的实际处方单标示为试2y的
            Format('UPDATE dbo.fnFactAssistantPrescriptionHdr SET Type = 0 WHERE Assistant_Prescrip_NO = ''%s'' AND Prescrip_NO <> @Prescrip_NO '#13#10, [FieldByName('Assistant_Prescrip_NO').AsString]);
        end;
        //构造插入从表的SQL
        Data:=vDataDtl;
        for i := 0 to RecordCount - 1 do
        begin
          if FieldByName('Iden').IsNull then
            result := result +
                     'SET IDENTITY_INSERT fnFactAssistantPrescriptionDtl OFF '#13#10 +
                     'INSERT INTO dbo.fnFactAssistantPrescriptionDtl (Prescrip_NO, Chemical_ID, Unit_QTY) '+
                      Format('VALUES(@Prescrip_NO, ''%s'', ''%s'') '#13#10, [
                             ifthen(FieldByName('Chemical_ID').AsString = '', '0',FieldByName('Chemical_ID').AsString),
                             ifthen(FieldByName('Unit_QTY').AsString = '', '0', FieldByName('Unit_QTY').AsString)])
          else
            result := result +
                     'SET IDENTITY_INSERT fnFactAssistantPrescriptionDtl ON '#13#10 +
                     'INSERT INTO fnFactAssistantPrescriptionDtl (Iden, Prescrip_NO, Chemical_ID, Unit_QTY) '+
                      Format('VALUES(''%s'', @Prescrip_NO, ''%s'', ''%s'') '#13#10, [
                             FieldByName('Iden').AsString,
                             ifthen(FieldByName('Chemical_ID').AsString = '', '0', FieldByName('Chemical_ID').AsString),
                             ifthen(FieldByName('Unit_QTY').AsString = '', '0', FieldByName('Unit_QTY').AsString)]);
          Next;
        end;
        result := result + 'SET IDENTITY_INSERT fnFactAssistantPrescriptionDtl OFF '#13#10;
      end;
    finally
      FreeAndNil(cds_FactPrescription);
    end;
  end;
var
  SqlText: String;
begin
  try
    case TUpdateStatus(iUpdateMode)  of
      usModified: SqlText:=GetUpdateFactAssiPrescriptionSQLText(vDataHdr, vDataDtl); //此模式下,vDataHdr, vDataDtl传递的是MergeChangeLog后的Data数据
      usInserted: SqlText:=GetInsterFactAssiPrescriptionSQLText(vDataHdr, vDataDtl); //此模式下,vDataHdr, vDataDtl传递的是MergeChangeLog后的Data数据
      usDeleted:  SqlText:=GetDeleteFactAssiPrescriptionSQLText(sPrescrip_NO);                     //此模式下,sCardList传递的是实际处方单号
    end;
    SqlText:=SqlText + 'SELECT @Prescrip_NO AS Prescrip_NO';
    FNMDAOUpt.ExeCommonSqlWithResultData(SqlText, vDataDtl, sErrorMsg);
    //sErrorMsg:=SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetAccidentInfo(const sAccident_NO: WideString;
  var vDataHdr, vDataDtl, vDataCard: OleVariant;
  var sErrorMsg: WideString);
var
  SqlText:WideString;
begin
  try
    SqlText:=Format('EXEC dbo.usp_GetAccidentInfo ''%s''', [sAccident_NO]);
    FNMDAOInfo.GetMultiDataSet(SqlText, vDataHdr, vDataDtl, vDataCard, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveAccidentInfo(const sCardList: WideString;
  var vDataHdr: OleVariant; vDataDtl: OleVariant; const sDeparement,
  sOperator: WideString; var sErrorMsg: WideString);
  function GetInsterAccidentSQLText(vData: OleVariant; sCardList, sDeparement, sOperator: String): String;
  var
    i: Integer;
    Cards, Card: string;
    cds_AccidentInfo: TClientDataSet;
    ReasonCode:string;
    Quantity:Integer;
  begin
    //如果 Accident_NO为空表明是新建立的处理单,则插入数据库,否则更新数据库
    try
      ReasonCode:= vData[8];
      Quantity := 0 ;
      cds_AccidentInfo:= TClientDataSet.Create(nil);
      result :='DECLARE @Accident_NO CHAR(12),@Grade INT '+ #13 +
      'EXEC dbo.usp_CreateNoteNO 3, '''', @Accident_NO OUTPUT '#13#10 +
      //处理单主表
    'INSERT dbo.fnAccidentHdr(Accident_NO, GF_ID, Operation_Code, Quantity, Before_After, Defect_Name, Quality_Type, Machine_ID, Current_Department, Operator,Reason_Code,Fabric_List,Operate_Time)'#13#10 +
      Format('VALUES(@Accident_NO, ' + DupeString('''%s'', ', 11) + 'GETDATE()) '#13#10, [
              vData[1], vData[2], vData[3], vData[7], vData[4], vData[5], vData[6], sDeparement, sOperator,vData[8],vData[9]]);
      //处理单明细
      with cds_AccidentInfo do
      begin
        result := result +
                 'INSERT INTO dbo.fnAccidentDtl(Accident_NO, Item_Name, Item_Value)'#13#10;
        cds_AccidentInfo.Data:=vDataDtl;
        for i := 0 to cds_AccidentInfo.RecordCount - 1 do
        begin
          if i <> 0 then
            result := result + 'UNION '#13#10;
          result := result +
            Format('SELECT @Accident_NO, ''%s'', ''%s'''#13#10, [cds_AccidentInfo['Item_Name'], cds_AccidentInfo['Item_Value']]);
            if cds_AccidentInfo['Item_Name'] = '码长' then
               Quantity := StrToInt(cds_AccidentInfo['Item_Value']);
          cds_AccidentInfo.Next;
        end;
      end;
      Cards:=sCardList;
      while length(Cards) > 0 do
      begin
        Card:=LeftStr(Cards, Pos(',', Cards) -1);
        result := result +
                 'INSERT dbo.fnHold (GF_ID, Operation_Code, FN_Card, Hold_Reason, Holder, Hold_Time) ' +
                 Format('VALUES(''%s'', ''%s'', ''%s'', @Accident_NO, ''%s'', GETDATE()) '#13#10,
                               [vData[1], vData[2], Card, sOperator]);
        system.Delete(Cards, 1, Pos(',', Cards));
      end;
      //根据reason_code 和 码长 更新grade
      result := result +
                 'SET @Grade = 0'#13#10 +
                 'SELECT @Grade = Grade From dbo.fnRepairReasonGradeList '#13#10 +
                 'WHERE Reason_Code = '+ '''' + ReasonCode + '''' +' AND ' + IntToStr(Quantity) + ' BETWEEN Min_value AND Max_Value '#13#10 +
                 'UPDATE dbo.fnAccidentHdr SET Grade = @Grade + 1 WHERE Accident_No = @Accident_NO'#13#10;

      //发邮件通知ＱＣＭ 2011-2-21
      result := result+ ' exec usp_fnAlertQCM @Accident_NO'#13#10;//,[vData[1],vData[4]]);
      result := result + 'SELECT @Accident_NO AS Accident_NO';
    finally
      FreeAndNil(cds_AccidentInfo);
    end;
  end;

  function GetUpdateAccidentSQLText(vData: OleVariant; sDeparement, sOperator: String): String;
  var
    i: Integer;
    cds_AccidentInfo: TClientDataSet;
  begin
    //如果 Accident_NO为空表明是新建立的处理单,则插入数据库,否则更新数据库
    try
      cds_AccidentInfo:= TClientDataSet.Create(nil);
      result :='DECLARE @Accident_NO CHAR(12) '+ #13 +
      Format('SET @Accident_NO = ''%s'' '#13#10, [vData[0]]) +
      //处理单主表          
      Format('UPDATE dbo.fnAccidentHdr SET Before_After = ''%s'', Defect_Name = ''%s'', Quality_Type = ''%s'', ' +
             'Operator = ''%s'', Operate_Time = GETDATE() WHERE Accident_NO = ''%s'' '#13#10 ,
             [vData[7], vData[4], vData[5], sOperator, vData[0]]) ;//+

      //处理单明细
      with cds_AccidentInfo do
      begin
        result := result +
                 'INSERT INTO dbo.fnAccidentDtl(Accident_NO, Item_Name, Item_Value)'#13#10;
        cds_AccidentInfo.Data:=vDataDtl;
        for i := 0 to cds_AccidentInfo.RecordCount - 1 do
        begin
          if i <> 0 then
            result := result + 'UNION '#13#10;
          result := result +
            Format('SELECT @Accident_NO, ''%s'', ''%s'''#13#10, [cds_AccidentInfo['Item_Name'], cds_AccidentInfo['Item_Value']]);
          cds_AccidentInfo.Next;
        end;
      end;
      result := result +
               'SELECT @Accident_NO AS Accident_NO';
    finally
      FreeAndNil(cds_AccidentInfo);
    end;
  end;

var
  SqlText: String;
begin
  try
    if vDataHdr[0] = '' then
      SqlText:=GetInsterAccidentSQLText(vDataHdr, sCardList, sDeparement, sOperator)
    else
      SqlText:=GetUpdateAccidentSQLText(vDataHdr, sDeparement, sOperator);
    FNMDAOUpt.ExeCommonSqlWithResultData(SqlText, vDataHdr, sErrorMsg);
    if sErrorMsg<> '' then
      sErrorMsg:= sErrorMsg + '   ' + SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetAccidentNOList(const sDataClass,
  sDepartment: WideString; var vData: OleVariant;
  var sErrorMsg: WideString);
var
  SqlText:WideString;
begin
  try
    {
    if sDataClass = 'NoDisposeAccident' then
      SqlText:='SELECT Accident_NO, dbo.udf_GetGFNO(GF_ID) AS GF_NO, Quantity, Quality_Type, Grade FROM dbo.fnAccidentHdr WITH(NOLOCK)'#13#10 +
        Format('WHERE Dispose_ID IS NULL AND Current_Department = ''%s''', [sDepartment])
    else
      SqlText:='SELECT Accident_NO, dbo.udf_GetGFNO(GF_ID) AS GF_NO, Quality_Type, Grade FROM dbo.fnAccidentHdr WITH(NOLOCK) WHERE Accident_NO NOT IN (SELECT Accident_NO FROM dbo.fnAccidentDispose (nolock)) '#13#10 +
        Format('AND Current_Department = ''%s''', [sDepartment]);
    }
    if sDataClass = 'NoDisposeAccident' then
        SqlText := 'exec FNMDB.dbo.usp_fnGetDisposeAccidentInfo 0,'''+ sDepartment+ ''''
    else
        SqlText := 'exec FNMDB.dbo.usp_fnGetDisposeAccidentInfo 1,'''+ sDepartment+ '''';
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetAccidentCardList( const sAccident_NO: WideString;
   out vData: OleVariant; out sErrorMsg: WideString);
var
  SqlText:WideString;
begin
  try
    SqlText:='SELECT FN_Card, dbo.udf_GetGFNO(GF_ID) AS GF_NO, Releaser FROM dbo.fnHold WITH(NOLOCK) WHERE Hold_Reason = '+QuotedStr(sAccident_NO);
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetAccidentDisposeInfo(const sAccident_NO: WideString;
  out vData: OleVariant;  out sErrorMsg: WideString);
var
  SqlText:WideString;
begin
  try
    SqlText:='SELECT * FROM dbo.fnAccidentDispose WITH(NOLOCK) WHERE Accident_no= '+QuotedStr(sAccident_NO);
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveDisposeInfo(const sAccident_NO,
  sQualityOperation, sDisposeInfo, sReasonCode, sRepairCardList,
  sRepairOperation, sUnHoldCardList, sOperator: WideString;
  var sErrorMsg: WideString);
var
  SqlText: String; 
begin
  try
    SqlText:= Format('EXEC dbo.usp_SaveDisposeInfo ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s''',
                      [sAccident_NO, sQualityOperation, sDisposeInfo, sReasonCode,sRepairCardList,sRepairOperation,sUnHoldCardList, sOperator]);
    FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetNoFinishRecipe(const sDepartment: WideString;
  var vData: OleVariant; var sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:='EXEC dbo.usp_GetUnFinishedRecipeInfo ' + QuotedStr(sDepartment);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveRecipe(iUpdateMode: Integer;
  const sRecipe_NO: WideString; sBase_Volume: Integer; const sMachine_ID,
  sOperator, sCardList: WideString; var sErrorMsg: WideString);
  function GetDeleteRecipeSQLText(Recipe_NO: String): String;
  begin
    result := result +
              'DECLARE @Recipe_NO char(12), @Recipe_Status char(1), @Prescrip_Type bit, @Prescrip_NO char(12)'#13#10 +
              'SET @Recipe_NO = ''' + Recipe_NO + ''''#13#10 +
              'SELECT @Recipe_Status = Recipe_Status, @Prescrip_Type = Prescrip_Type, @Prescrip_NO = Prescrip_NO FROM fnRecipeHdr WHERE Recipe_NO = @Recipe_NO '#13#10 +
              'IF (@Recipe_Status IS NULL) OR (@Prescrip_Type IS NULL) OR (@Prescrip_NO IS NULL) '#13#10 +
              'BEGIN '#13#10 +
              '  RAISERROR (''未找到指定的化料单号的化料单'', 16, 1) '#13#10 +
              '  RETURN '#13#10 +
              'END '#13#10 +
              'IF @Recipe_Status <> 0 '#13#10 +
              'BEGIN '#13#10 +
              '  RAISERROR (''化料单已经开始化料,不能删除'', 16, 1) '#13#10 +
              '  RETURN '#13#10 +
              'END '#13#10 +
              'UPDATE fnJobTraceDtl SET Recipe_NO = '''' WHERE Recipe_NO = @Recipe_NO '#13#10 +
              'DELETE fnRecipeDtl WHERE Recipe_NO = @Recipe_NO '#13#10 +
              'DELETE fnRecipeHdr WHERE Recipe_NO = @Recipe_NO '#13#10 +
              //将实际处方单标识为未完成
              'IF @Prescrip_Type = 0 '#13#10 +
              'BEGIN '#13#10 +
              '  UPDATE fnFactAssistantPrescriptionHdr SET Recipe_Count = Recipe_Count - 1 WHERE Prescrip_NO = @Prescrip_NO '#13#10 +
              //标示当前处方单未完成
              '  UPDATE dbo.fnAssistantPrescriptionHdr SET Prescrip_Count = ABS(Prescrip_Count) '#13#10 +
              '    WHERE Assistant_Prescrip_NO = (SELECT Assistant_Prescrip_NO FROM dbo.fnFactAssistantPrescriptionHdr WHERE Prescrip_NO =@Prescrip_NO) '#13#10 +
              'END ';
  end;

  function GetUpdateRecipeSQLText(Recipe_NO: String; Base_Volume: Integer; Machine_ID, sOperator, CardList: String): String;
  begin
    result :='DECLARE @SumVolume numeric(9,2), @Recipe_NO char(12) '#13#10 +
      Format('SET @Recipe_NO = ''%s'' '#13#10, [Recipe_NO]) +
      Format('UPDATE dbo.fnRecipeHdr SET Base_Volume = ''%d'', Machine_ID = ''%s'', Operator = ''%s'', Operate_Time = GETDATE(), @SumVolume = Theory_Volume + Base_Volume WHERE Recipe_NO = @Recipe_NO '#13#10,
               [Base_Volume, Machine_ID, sOperator]) +
             'UPDATE dbo.fnRecipeDtl SET Dosage = (Unit_Qty * @SumVolume)/1000.0 WHERE Recipe_NO = @Recipe_NO '#13#10;
    if CardList <> '' then
      result := result +
             'UPDATE dbo.fnJobTraceDtl SET Recipe_NO = '''' where Recipe_NO = @Recipe_NO and FN_Card not in (SELECT [NO] FROM PUBDB.dbo.UDF_ConvertStrToTable(''' + CardList + ''', '',''))';
  end;
var
  SqlText: String;    
begin
  try
    case TUpdateStatus(iUpdateMode) of
      usModified: SqlText:=GetUpdateRecipeSQLText(sRecipe_NO, sBase_Volume, sMachine_ID, sOperator, sCardList);
      usDeleted:  SqlText:=GetDeleteRecipeSQLText(sRecipe_NO);
    end;
    FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
    //sErrorMsg:=SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetOnLineCard(const sCLassName, sParam1,
  sParam2: WideString; out vData: OleVariant; out sErrorMsg: WideString);
var
  SqlText: String;
begin
  try
    SqlText := 'EXEC dbo.usp_GetOnLineCard ' + QuotedStr(sCLassName) + ',' +
                QuotedStr(sParam1 )+ ', ' + QuotedStr(sParam2);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;  //sErrorMsg:= SqlText;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetSampleInfo(out vData: OleVariant;
  const sFN_Card: WideString; out sErrorMsg: WideString);
var
  SqlText: String;
begin
  try
    if sFN_Card ='' then
      SqlText := 'EXEC dbo.usp_GetBaseTableInfo '+QuotedStr('fnSampleInfo')
    else
      SqlText := 'EXEC dbo.usp_GetSampleInfo '+QuotedStr(sFN_Card);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetOperationListByFN_Card(const sFN_Card: WideString;
  out vData: OleVariant; out sErrorMsg: WideString);
var
  SqlText: String;
begin
  try
    SqlText :='SELECT FN_Card, Step_NO, Operation_Code, Operation_Times, '#13#10 +
              'dbo.udf_GetOperationName(Operation_Code,0) + ''('' +Current_Department+''-''+ Machine_ID + ''-'' + CONVERT(char(19), End_time, 120) + '')''  AS Operation_CHN '#13#10 +
              'FROM dbo.fnJobTraceDtl '#13#10 +
       Format('WHERE FN_Card = ''%s'' '#13#10, [sFN_Card])+
              '  AND ISNULL(Machine_ID, '''') <> '''' '#13#10 +
              '  AND Operation_Code NOT IN (''000'', ''999'') '#13#10 +
              'ORDER BY Step_NO';
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetDefectAnalysisWorker(iStepNO,
  iOperationTimes: Integer; const sFnCard, sMachine_ID, sOperate_Time,
  sCurrent_Department: WideString; out vData: OleVariant;
  out sErrorMsg: WideString);
var
  SqlText: String;
begin
  try
    SqlText := 'EXEC dbo.usp_GetDefectAnalysisWorker ' +
               QuotedStr(sFNCard)       + ',' +
               IntToStr(iStepNO)        + ',' +
               IntToStr(iOperationTimes)+ ',' +
               QuotedStr(sMachine_ID)   + ',' +
               QuotedStr(sCurrent_Department) +','+
               QuotedStr(sOperate_Time);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    //sErrorMsg:=SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveCheckStdArt(const sSTD_Art_ID, sVersion,
  sCurrent_department, sChecker: WideString; iType: Integer; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText := 'EXEC dbo.usp_CheckSTDArt '+ QuotedStr(sSTD_Art_ID)+','+QuotedStr(sVersion)+','+QuotedStr(sChecker)+','+
               QuotedStr(sCurrent_department)+','+ IntToStr(iType);
    FNMDAOUpt.ExeCommonSql(sqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveCheckAssistantPrescription(const sChecker,
  sAssistant_Prescrip_NO: WideString; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:=Format('UPDATE dbo.fnAssistantPrescriptionHdr SET Checker = ''%s'', Check_Time=GETDATE() WHERE Assistant_Prescrip_NO = ''%s''',
                     [sChecker, sAssistant_Prescrip_NO]);
    FNMDAOUpt.ExeCommonSql(sqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetUsedPrescripNOCard(const sGF_KeyValue,
  sOperation_Code, sPrescrip_NO, sDepartment: WideString; out vData1,
  vData2: OleVariant; out sErrorMsg: WideString);
var
  SqlText:WideString;                      
  vData3: OleVariant;
begin
  try
    SqlText:=Format('EXEC dbo.usp_GetUsedPrescripNOCard ''%s'', ''%s'', ''%s'', ''%s''', [sGF_KeyValue, sOperation_Code, sPrescrip_NO, sDepartment]);
    FNMDAOInfo.GetMultiDataSet(SqlText, vData1, vData2, vData3, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetCheckGFIDAndSTDArt(const sGF_KeyValue,
  sDepartment: WideString; out iGF_ID, iSTD_Art_ID: Integer; out sErrorMsg: WideString);
var
  SqlText: WideString;
  SeparatorPos: Integer;
  vFieldValue: OleVariant;
begin
  try
    SqlText:='SELECT ' +
            'ISNULL(CONVERT(varchar, (SELECT GF_ID FROM pdmdb..tdGFID where GF_ID = dbo.udf_GetGFID(''' + sGF_KeyValue + '''))), ''-1'') + '','' + '#13#10 +
            'ISNULL(CONVERT(varchar, (SELECT STD_Art_ID FROM fnStdArtHdr WHERE GF_ID = dbo.udf_GetGFID(''' + sGF_KeyValue + ''') AND  Current_Department = ''' + sDepartment + ''')), ''-1'')';
    FNMDAOInfo.GetCommonFieldValue(vFieldValue, SqlText, sErrorMsg);
    if vFieldValue <> '' then
    begin
      SeparatorPos:=pos(',', vFieldValue);
      iGF_ID := StrToInt(LeftStr(vFieldValue, SeparatorPos - 1));
      iSTD_Art_ID := StrToInt(MidStr(vFieldValue, SeparatorPos + 1, Length(vFieldValue) - SeparatorPos));
    end;
    SetComplete;
  except
    SetAbort;
    raise;
  end
end;

procedure TFNMArtFacadeLib.SaveRecipeTraceInfo(const sOperateClass,
  sVatCode, sRecipe_NO: WideString; sScrapVolume: Single;
  const sOperator: WideString; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:=Format('EXEC dbo.usp_SaveRecipeTraceInfo ''%S'', ''%S'', ''%S'', ''%s'', ''%S'' ' ,
                     [sOperateClass, sVatCode, sRecipe_NO, FloatToStr(sScrapVolume), sOperator]);
    FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetFNCardsByRecipeNO(const sRecipeNO: WideString;
  out vData: OleVariant; out sErrorMsg: WideString);
var
   SqlText: String;
begin
  try
    SqlText:= 'EXEC dbo.usp_GetFNCardsByRecipeNO '+QuotedStr(sRecipeNO);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveReceiveSample(const sIdenList,
  sOperator: WideString; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:=Format('UPDATE dbo.fnSampleInfo SET Operator = ''%s'', Operate_Time= GETDATE() WHERE Iden IN %s', [sOperator, sIdenList]);
    FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveAnalysisQualtityData(vDataHdr,
  vDataDtl: OleVariant; sDate: TDateTime; const sDepartment: WideString;
  out sErrorMsg: WideString);
var
  i, j: Integer;
  SqlText: WideString;
  cds_AnalysisHdr, cds_AnalysisDtl: TClientDataSet;
begin
  try
    try
      cds_AnalysisHdr:=TClientDataSet.Create(nil);
      cds_AnalysisDtl:=TClientDataSet.Create(nil);
      cds_AnalysisHdr.Data:=vDataHdr;
      cds_AnalysisDtl.Data:=vDataDtl;
      SqlText:='DECLARE @AnalysisID int '#13#10;
      for i := 0 to cds_AnalysisHdr.RecordCount - 1 do
      begin
        if cds_AnalysisHdr.FieldByName('Defect_Analysis_ID').IsNull then
        begin
          SqlText:=SqlText +
                  'INSERT INTO dbo.fnDefectAnalysisHdr(GF_ID, Fabric_NO, Quantity, FN_Card, Grade, Reason_Code, Reason_Name, Quality_Type, Step_NO, Org_Time, Current_Department, Operator, Operate_Time) '#13#10 +
           Format('VALUES(' + DupeString('''%s'', ', 8) + 'CASE WHEN ''%s'' = '''' THEN NULL ELSE ''%s'' END, ' + DupeString('''%s'', ', 3) + '''%s'')'#13#10, [
                  cds_AnalysisHdr['GF_ID'],
                  cds_AnalysisHdr['Fabric_NO'],  cds_AnalysisHdr['Quantity'],
                  cds_AnalysisHdr['FN_Card'],    cds_AnalysisHdr['Grade'],
                  cds_AnalysisHdr['Defect_Code'],cds_AnalysisHdr['Defect_Name'],
                  cds_AnalysisHdr['Quality_Type'],
                  cds_AnalysisHdr['Step_NO'],    cds_AnalysisHdr['Step_NO'],
                  cds_AnalysisHdr['Org_Time'],   sDepartment,
                  cds_AnalysisHdr['Operator'],   cds_AnalysisHdr['Operate_Time']]) +
                  'SET @AnalysisID = IDENT_CURRENT(''fnDefectAnalysisHdr'') '#13#10
        end
        else
        begin
          SqlText:=SqlText +
           format('UPDATE dbo.fnDefectAnalysisHdr SET FN_Card = ''%s'', Reason_Code = ''%s'', Reason_Name = ''%s'', Quality_Type = ''%s'', Step_NO = CASE WHEN ''%s'' = '''' THEN NULL ELSE ''%s'' END, Operator = ''%s'', Operate_Time = ''%s'' WHERE Iden = %s '#13#10, [
                   cds_AnalysisHdr['FN_Card'],      cds_AnalysisHdr['Defect_Code'],
                   cds_AnalysisHdr['Defect_Name'],  cds_AnalysisHdr['Quality_Type'],
                   cds_AnalysisHdr['Step_NO'],
                   cds_AnalysisHdr['Step_NO'],      cds_AnalysisHdr['Operator'],
                   cds_AnalysisHdr['Operate_Time'], cds_AnalysisHdr['Defect_Analysis_ID']]) +
           format('SET @AnalysisID = %s '#13#10, [cds_AnalysisHdr['Defect_Analysis_ID']]) +
                  'DELETE dbo.fnDefectAnalysisDtl WHERE Defect_Analysis_ID = @AnalysisID '#13#10;
        end;

        cds_AnalysisDtl.Filter:=Format('Iden = %d', [cds_AnalysisHdr.FieldByName('Iden').AsInteger]);
        cds_AnalysisDtl.Filtered:=True;
        for j := 0 to cds_AnalysisDtl.RecordCount - 1 do
        begin
          SqlText:=SqlText +
                  'INSERT INTO FNMDB.dbo.fnDefectAnalysisDtl(Defect_Analysis_ID, Worker_ID, Operate_Type, Monitor_ID, Quantity) '#13#10 +
           Format('VALUES(@AnalysisID, ''%s'', ''%s'', ''%s'', ''%s'') '#13#10, [
                   cds_AnalysisDtl['Worker_ID'], cds_AnalysisDtl['Operate_Type'], cds_AnalysisDtl['Monitor_ID'], cds_AnalysisDtl['Quantity']]);
          cds_AnalysisDtl.Next;
        end;
        cds_AnalysisHdr.Next;
      end;
      FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
      //sErrorMsg:= SqlText;                   
      SetComplete;
    except
      SetAbort;
      raise;
    end;
  finally
    FreeAndNil(cds_AnalysisHdr);
    FreeAndNil(cds_AnalysisDtl);
  end;
end;
procedure TFNMArtFacadeLib.GetFNNOList(iGetType: Integer;
  out vData: OleVariant; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:= 'EXEC dbo.usp_GetFNNOList '+IntToStr(iGetType);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetCheckSpecialArt(iGF_ID, iIsNormal: Integer;
  const sOperationStr, sCurrentDepartment: WideString;
  out sErrorMsg: WideString);
const
  CheckSpecialArtSQL = 
    'SELECT FNMDB.dbo.udf_CheckSpecialArt(%d, %d, ''%s'', ''%s'') AS IsValid';
var
  SqlText: WideString;
  FieldValue: OleVariant;
begin
  try
    SqlText:=Format(CheckSpecialArtSQL, [iGF_ID, iIsNormal, sOperationStr, sCurrentDepartment]);
    FNMDAOInfo.GetCommonFieldValue(FieldValue, SqlText, sErrorMsg);
    if FieldValue <> 'Y' then
      sErrorMsg :=sErrorMsg + #13#10 +  '当前工艺的工序顺序检测失败,请注意特殊整理前的水洗工序';
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetCardByFabricList(const sFabricList: WideString;
  out vData: OleVariant; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:='SELECT Fabric_NO, FN_Card FROM dbo.fnStock WITH(NOLOCK)'#13#10 +
             'WHERE Fabric_NO IN (SELECT NO FROM PUBDB.dbo.udf_ConvertStrToTable('+QuotedStr(sFabricList)+','',''))';
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveUserDefindSample(const sTestItem,
  sOperator: WideString; out sFactSampleNO, sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:=Format('EXEC dbo.usp_SaveUserDefindSample ''%s'', ''%s'', :@FactSampleNO OUTPUT', [sTestItem, sOperator]);
    FNMDAOUpt.ExeCommonSqlWithResult(SqlText, '@FactSampleNO', sFactSampleNO, sErrorMsg);
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveHLReceiveSendInfo(const sType, sFN_NOs,
  sOperator: WideString; out sErrorMsg: WideString);
var
  FN_NOs: String;
  SqlText: WideString;
begin
  try
    FN_NOs:=sFN_NOs;
    FN_NOs[Length(FN_NOs)]:='''';
    FN_NOs:='''' + StringReplace(FN_NOs, ',', ''',''', [rfReplaceAll]);
    if sType = 'Receive' then
    begin
      SqlText:='UPDATE PDMDB.dbo.hlFNTechnicsHdr SET Status= ''1'', FN_Receiver = ''%s'', FN_Receive_Time = GETDATE() WHERE FN_NO IN (%s)';
      SqlText:=Format(SqlText, [sOperator, FN_NOs]);
    end
    else //if sType = 'Send'
    begin
      SqlText:='UPDATE PDMDB.dbo.hlFNTechnicsHdr SET Status= ''2'', FN_Sender = ''%s'', FN_Send_Time = GETDATE() WHERE FN_NO IN (%s) '#13#10 +
               'UPDATE dbo.fnJobTraceHdr SET Art_Checker = ''%s'', Art_Check_Time = GETDATE() WHERE FN_Card IN (%s) '#13#10;
      SqlText:=Format(SqlText, [sOperator, FN_NOs, sOperator, FN_NOs]);
    end;
    FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
    //sErrorMsg:=SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetFNNOInfo(const sFN_NO: WideString;
  out vData: OleVariant; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try                                        
    SqlText:='SELECT TOP 1 a.FN_NO, ISNULL(a.Fluorescence, '''') AS Fluorescence, ISNULL(c.HL_Type, '''') AS HL_Type, '#13#10 +
             'ISNULL(c.Mercerizing, '''') AS Mercerizing, ISNULL(c.Is_Blue_R, '''') AS Is_Blue_R '#13#10 +
             'FROM PDMDB.dbo.hlFNTechnicsHdr a '#13#10 +
             '     LEFT JOIN PDMDB.dbo.hlFNTechnicsDtl b ON a.FN_NO = b.FN_NO '#13#10 +
             '     LEFT JOIN PDMDB.dbo.hlBasicInfo c ON b.HL_NO = c.HL_NO '#13#10 +
             'WHERE a.FN_NO = '+QuotedStr(sFN_NO);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveHLArtInfo(const Department: WideString;
  vDataHdr: OleVariant; var vDataDtl: OleVariant;
  var sErrorMsg: WideString);
var
  SqlText: String;
  isNewHLArt: Boolean;
  cds_Art: TClientDataSet;
begin
  cds_Art:=nil;
  try
    cds_Art:=TClientDataSet.Create(nil);
    try
      cds_Art.Data:=vDataHdr;
      SqlText :='DECLARE @HL_Art_ID Int, @FN_NO char(9), @FN_ID int'#13#10 +
         Format('SET @FN_ID = -%s'#13#10, [cds_Art['FN_ID']]);
      with cds_Art do
      begin
        isNewHLArt:=FieldByName('Art_ID').IsNull;
        //如果 Art_ID为空表明是新建立的工艺,则插入数据库,否则更新数据库
        if isNewHLArt then
        begin
          SqlText := SqlText +
                    'IF EXISTS (SELECT * FROM fnArtItem WHERE GF_ID = @FN_ID AND Art_Type = ''H'') '#13#10 +
                    '  RAISERROR(''工艺已经存在,请不要重复制定工艺'', 16, 1) '#13#10 +
                    'INSERT INTO fnArtItem (GF_ID, Art_Type, FN_Art_NO, FN_Color_Code, Shrinkage, HandFeel, Operator)  ' +
                     Format('VALUES(@FN_ID, ''H'', ''%s'', '''', '''', '''', ''%s'') '#13#10, [
                              FieldByName('FN_Art_NO').AsString, FieldByName('Operator').AsString]) +
                     //插入HL工艺到实际工艺表
                    'INSERT INTO fnFactArtHdr (GF_ID, STD_Art_ID, STD_Art_Version, Art_Type, Material_Quality, Operator, Operate_Time, Remark) '+
             Format('VALUES(@FN_ID, ''-1'', ''0'', ''%s'', ''%s'', ''%s'', GETDATE(), ''%s'') '#13#10, [
                     FieldByName('Art_Type').AsString, FieldByName('Material_Quality').AsString,
                     FieldByName('Operator').AsString, FieldByName('Remark').AsString]) +
                    'SET @HL_Art_ID =IDENT_CURRENT(''fnFactArtHdr'') '#13#10 +
             Format('SET @FN_NO = ''%S'''#13#10, [FieldByName('FN_NO').AsString]);
        end
        else
        begin
          SqlText := SqlText +
             Format('UPDATE fnArtItem SET FN_Art_NO= ''%s'', Operator = ''%s'', Operate_Time = GETDATE() ' +
                    '        WHERE GF_ID = @FN_ID AND Art_Type = ''H'' '#13#10, [
                      FieldByName('FN_Art_NO').AsString, FieldByName('Operator').AsString]) +
                    //更新HL工艺到实际工艺表
             Format('SET @HL_Art_ID = ''%s'' '#13#10, [FieldByName('Art_ID').AsString]) +
                    'UPDATE fnFactArtHdr SET '+
             Format('Operator=''%s'',Operate_Time=GETDATE(), Remark= ''%s'' WHERE Fact_Art_ID= @HL_Art_ID'#13#10, [
                     FieldByName('Operator').AsString,        FieldByName('Remark').AsString]) +
                    //删除明细表中的相关数据(删除插入模式)
                    'DELETE fnFactArtDtl WHERE Fact_Art_ID= @HL_Art_ID '#13#10;
        end;
         //更新HL工艺明细到实际工艺明细表中
        cds_Art.Data:=vDataDtl;
        while not Eof do
        begin
          SqlText:=SqlText +
                  'INSERT INTO dbo.fnFactArtDtl (Fact_Art_ID, Step_NO, Operation_Code, Item_Name, Item_Value, Operator, Operate_Time) '+
           Format('VALUES(@HL_Art_ID, ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'') '#13#10, [
                   FieldByName('Step_NO').AsString,
                   FieldByName('Operation_Code').AsString,
                   FieldByName('Item_Name').AsString,
                   FieldByName('Item_Value').AsString,
                   FieldByName('Operator').AsString,
                   FieldByName('Operate_Time').AsString]);
          Next;
        end;
        //加入头(000)尾(999)工序 
        SqlText:=SqlText +
                'EXEC dbo.usp_InsertHeadOperate @HL_Art_ID '#13#10;
        if isNewHLArt then
        begin
          //在进度跟踪表中插入FN_NO
          SqlText:=SqlText +
                   'INSERT fnJobTraceHdr (FN_Card, GF_ID, Fact_Art_ID, Step_NO, Operation_Code, Quantity, Current_Department) ' +
            Format('VALUES(@FN_NO, @FN_ID, @HL_Art_ID, ''1'', dbo.udf_GetOperationCode(@HL_Art_ID, 1), ''2'', ''%s'') '#13#10, [Department]);
        end
        else
        begin
          //跟新进度跟踪表的当前工序
          SqlText:=SqlText +
                 'UPDATE dbo.fnJobTraceHdr SET Operation_Code = dbo.udf_GetOperationCode(Fact_Art_ID, Step_NO) WHERE Fact_Art_ID = @HL_Art_ID '#13#10;
        end;
      end;
      SqlText:=SqlText + 'SELECT @HL_Art_ID AS Fact_Art_ID';
      FNMDAOUpt.ExeCommonSqlWithResultData(SqlText, vDataDtl, sErrorMsg);
      //sErrorMsg:=SqlText;
      SetComplete;
    except
      SetAbort;
      raise;
    end;
  finally
    FreeAndNil(cds_Art);
  end;
end;

procedure TFNMArtFacadeLib.GetHLBasicInfo(const sFN_NO: WideString;
  var vData: OleVariant; var sErrorMsg: WideString);
begin
end;

procedure TFNMArtFacadeLib.GetArtItemInfo(iGF_ID: Integer;
  out vData: OleVariant; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:=Format('SELECT FN_Art_NO, FN_Color_Code, Shrinkage, HandFeel, Product_Width FROM dbo.fnArtItem WITH(NOLOCK) WHERE GF_ID = ''%d'' AND Art_Type = ''B''', [iGF_ID]);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveNewRecipe(const sPrescripNO, sFNCards,
  sOperationCode, sMachineID, sBaseVolume, sDepartment,
  sOperator: WideString; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:=Format('EXEC dbo.usp_CreateNewRecipe ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s''',
             [sPrescripNO, sFNCards, sOperationCode, sMachineID, sBaseVolume, sDepartment, sOperator]);

    //sErrorMsg:=SqlText;
    FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetNoPrescripCard(const sGFKey_Value,
  sDepartment, sOperation_Code: WideString; out vData: OleVariant;
  out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try //取指定品名，所有在线的卡中，还未加工的所有工序中，在指定工序没有制定处方单和化料单的卡号
    SqlText:='DECLARE @GFID int, @GFNO varchar(20), @OperationCode char(3) '#13#10 +
      Format('SELECT @GFID = dbo.udf_GetGFID(''%s''), @GFNO = PDMDB.dbo.udf_GetGF_NOByGF_ID(@GFID) '#13#10, [sGFKey_Value]) +
             'SELECT @GFID AS GF_ID, @GFNO AS GF_NO, a.FN_Card, a.Job_NO, a.Fact_Art_ID, a.Step_NO, a.Operation_Code, ' +
             'dbo.udf_GetOperationName(a.Operation_Code, 0) AS Operation_CHN, a.Quantity, a.Status, a.Is_Cut_Cloth ' +
             'FROM fnJobTraceHdr a WITH(NOLOCK)'#13#10 +
             '  LEFT JOIN fnJobTraceDtl b WITH(NOLOCK) ON a.FN_Card = b.FN_Card AND a.Operation_Code = b.Operation_Code AND a.Step_NO = b.Step_NO '#13#10 +
      Format('  WHERE a.GF_ID = @GFID AND a.Operation_Code = ''%s'' AND a.Current_Department = ''%s'' '#13#10, [sOperation_Code, sDepartment]) +
             '        AND RTRIM(ISNULL(b.Assistant_Prescrip_NO + b.Prescrip_NO + b.Recipe_NO, '''')) = ''''';
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    //sErrorMsg:=SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetUnFinishJobTraceDtl(
  const sFNCards: WideString; iStepNO: Integer; out vData: OleVariant;
  out sErrorMsg: WideString);
var
  Cards: String;
  SqlText: WideString;
begin
  try
    Cards:=sFNCards;
    Cards[Length(Cards)]:='''';
    Cards:='(''' + StringReplace(Cards, ',', ''',''', [rfReplaceAll]) + ')';

    SqlText:='SELECT Iden, Step_NO FROM dbo.fnJobTraceDtl '#1310 +
	     Format('WHERE FN_Card IN %s and Step_NO > = %d', [Cards, iStepNO]);

    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    //sErrorMsg:= SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetStdPrescriptionDtl(
  const sPrescrip_NO: WideString; out vData: OleVariant;
  out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:='SELECT a.Prescrip_NO, a.Chemical_ID, b.Chemical_Name, a.Unit_QTY, b.Unit '#13#10 +
             'FROM dbo.fnStdPrescriptionDtl a WITH(NOLOCK) '#13#10 +
             '      LEFT JOIN PUBDB.dbo.pbChemicalList b WITH(NOLOCK) ON a.Chemical_ID = b.Chemical_ID '#13#10 +
      Format('WHERE Prescrip_NO = ''%s'''#13#10, [sPrescrip_NO]) +
             'ORDER BY 1 ';
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    //sErrorMsg:= SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveStdPrescription(var vDataParam: OleVariant;
  var sPrescriptionNO: WideString; out sErrorMsg: WideString);
const
  SavePrescripInfoSQL =
    'EXEC FNMDB..usp_SavePrescripInfo ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', :NewPrescripNO Output';
var
  SqlText: WideString;
begin
  try
    SqlText:= Format(SavePrescripInfoSQL, [vDataParam[0], vDataParam[1], vDataParam[2], vDataParam[3], vDataParam[4],vDataParam[5]]);
    FNMDAOUpt.ExeCommonSqlWithResult(SqlText, 'NewPrescripNO', sPrescriptionNO, sErrorMsg);
  //  sErrorMsg:=SqlText;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetArtReview(const sFN_Card: WideString;
  out vData: OleVariant; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:=Format('EXEC dbo.usp_GetArtReview ''%s''', [sFN_Card]);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetConStr(out sConStr: WideString);
begin
  sConStr:=GetConnectionString('FNMFacade.dll', 'FNM');
end;

procedure TFNMArtFacadeLib.GetOnlineStdPrescripNO(const sOperationCode,
  sDepartment: WideString; out sStdPrescripNOs: OleVariant;
  out sErrorMsg: WideString);
var
  SQLText: WideString;
begin
  try
{   cuijf 2010-6-4
    SqlText:='DECLARE @Prescrip_NOS varchar(5000), @OperationCode char(3), @CurrentDepartment char(2)'#13#10 +
      Format('SELECT @OperationCode = ''%s'', @CurrentDepartment = ''%s'', @Prescrip_NOS = '''''#13#10,[sOperationCode, sDepartment]) +
             'SELECT @Prescrip_NOS = @Prescrip_NOS + RTRIM(Item_Value) + ''/'' FROM ('#13#10 +
             '  SELECT DISTINCT RTRIM(Item_Value) AS Item_Value FROM dbo.fnFactArtDtl'#13#10 +
             '    WHERE Fact_Art_ID IN (SELECT DISTINCT Fact_Art_ID FROM dbo.uvw_fnOnLineCard WITH(NOLOCK) WHERE Operation_Code = @OperationCode AND Current_Department= @CurrentDepartment)'#13#10 +
             '     AND Operation_Code = @OperationCode'#13#10 +
             '     AND Item_Name LIKE ''%配方%'''#13#10 +
             '     AND Item_Value IN (SELECT Prescrip_NO FROM dbo.fnStdPrescriptionHdr))tempa'#13#10 +
             'SELECT @Prescrip_NOS';
}
    SQLText := 'exec usp_fnGetOnlineStdPrescripNO '+ QuotedStr(sOperationCode)+','+ QuotedStr(sDepartment);
    FNMDAOInfo.GetCommonFieldValue(sStdPrescripNOs, SqlText, sErrorMsg);
    //sErrorMsg:=SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetFactArtDtl(iFactArtID: Integer;
  out vData: OleVariant; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:=
       'DECLARE @Fact_Art_ID int '#13#10 +
Format('SET @Fact_Art_ID = %d', [iFactArtID]) +
       'DECLARE @ArtTable table(Fact_Art_ID int,  Step_NO int, Operation_Code char(3)) '#13#10 +
       'INSERT @ArtTable '#13#10 +
       ' SELECT DISTINCT @Fact_Art_ID, Step_NO, Operation_Code '#13#10 +
       '   FROM dbo.fnFactArtDtl WITH(NOLOCK) '#13#10 +
       ' WHERE Fact_Art_ID = @Fact_Art_ID AND Operation_Code NOT IN (''000'', ''999'') '#13#10 +
       ' ORDER BY Step_NO '#13#10 +
       'SELECT Fact_Art_ID, Step_NO, dbo.udf_GetOperationName(Operation_Code, 0) AS Operation_CHN, '#13#10 +
       '     dbo.udf_GetFactArtStepParam(Fact_Art_ID, Step_NO, '''')  AS Param '#13#10 +
       'FROM @ArtTable ';
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetAccidentInfoByFNCard(
  const sFN_Card: WideString; var vData: OleVariant;
  var sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:= Format('SELECT * FROM dbo.udf_GetAccidentInfoByFNCard(''%s'')',[sFN_Card]);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveCheckRepairArt(iFactArtID: Integer;
  const sOperator: WideString; out sErrorMsg: WideString);
//var
//  SqlText: WideString;
begin
//  try
//    SqlText:= Format('SELECT * FROM dbo.udf_GetAccidentInfoByFNCard(''%s'')',[sFN_Card]);
//    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
//    SetComplete;
//  except
//    SetAbort;
//    raise;
//  end;
end;

procedure TFNMArtFacadeLib.GetRecipeInfo(const sRecipeNO: WideString;
  out vDataHdr, vDataDtl, vDataCard: OleVariant;
  out sErrorMsg: WideString);
var
  SqlText: String;
begin
  try
    SqlText:= Format('EXEC dbo.usp_GetRecipeInfo ''%s'' '#13#10, [sRecipeNO]);
    FNMDAOInfo.GetMultiDataSet(SqlText, vDataHdr, vDataDtl, vDataCard, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveHandRecipe(const sCardList: WideString;
  vDataHdr, vDataDtl: OleVariant; out sErrorMsg: WideString);
  function GetUpdateJobTraceDtlSQLText(sCardList: String): String;
  var
    FN_Card: String;
    StringLen: Integer;
  begin
    while Length(sCardList) > 0 do
    begin
      StringLen:=Pos(',', sCardList);
      FN_Card:=LeftStr(sCardList, StringLen -1);
      System.Delete(sCardList, 1, StringLen);

      result := result +
        Format('EXEC dbo.usp_InsertJobTraceDtlInfo ''%s'', @Recipe_NO '#13#10, [FN_Card]);
    end;
  end;
var
  SqlText: String;
  cds_Prescription: TClientDataSet;
begin
  cds_Prescription:=nil;
  try
    cds_Prescription:=TClientDataSet.Create(nil);
    try
      with cds_Prescription do
      begin
        Data:=vDataHdr;
        SqlText :='DECLARE @Recipe_NO CHAR(12)'+ #13;
        //如果 Prescrip_NO为空表明是新建立的配方,则插入数据库,否则更新数据库
        if FieldByName('Recipe_NO').IsNull then
          SqlText := SqlText +
            'EXEC usp_CreateNoteNO 4, '''', @Recipe_NO OUTPUT '#13#10 +
            'INSERT INTO FNMDB..fnOperationRecipeHdr(Recipe_NO, Operation_Code, Machine_ID, Pre_DryTemperature, Dry_Temperature, '+
            'Flood_Class, Flood_Percent, Sample_Type, Need_Trace, Remark, Current_Department, Operator, Operate_Time) '+
            Format('VALUES(@Recipe_NO, ''%s'', ''%s'', %d, %d, ''%s'', ''%s'', %d, %d, ''%s'', ''%s'', ''%s'', GETDATE()) '#13#10, [
                    FieldByName('Operation_Code').AsString,          FieldByName('Machine_ID').AsString,
                    FieldByName('Pre_DryTemperature').AsInteger,     FieldByName('Dry_Temperature').AsInteger,
                    FieldByName('Flood_Class').AsString,             FieldByName('Flood_Percent').AsString,
                    FieldByName('Sample_Type').AsInteger,            FieldByName('Need_Trace').AsInteger,
                    FieldByName('Remark').AsString,                  FieldByName('Current_Department').AsString,
                    FieldByName('Operator').AsString])
        else
        begin
          SqlText := SqlText +
            'SET @Recipe_NO = ''' + FieldByName('Recipe_NO').AsString+''' '#13#10 +
            'UPDATE FNMDB..fnOperationRecipeHdr SET '+
            Format('Machine_ID = ''%s'', Pre_DryTemperature = %d, Dry_Temperature = %d, Flood_Class = ''%s'', ' +
                   'Flood_Percent= ''%s'', Sample_Type = %d, Need_Trace = %d, Remark = ''%s'', ' +
                   'Operator = ''%s'',     Operate_Time = GETDATE() '#10#13, [
                    FieldByName('Machine_ID').AsString,           FieldByName('Pre_DryTemperature').AsInteger,
                    FieldByName('Dry_Temperature').AsInteger,     FieldByName('Flood_Class').AsString,
                    FieldByName('Flood_Percent').AsString,        FieldByName('Sample_Type').AsInteger,
                    FieldByName('Need_Trace').AsInteger,          FieldByName('Remark').AsString,
                    FieldByName('Operator').AsString])+
            'WHERE Recipe_NO= @Recipe_NO '#13#10 +
            'DELETE FROM fnOperationRecipeDtl WHERE Recipe_NO = @Recipe_NO '#13#10 +
            'UPDATE dbo.fnJobTraceDtl SET Recipe_NO = '''' WHERE Recipe_NO = @Recipe_NO '#13#10;
        end;
        Close;
        Data:=vDataDtl;
        First;
        while not Eof do
        begin
          SqlText:=SqlText
            + Format('EXEC dbo.usp_fnCheckHandRecipe %s,%g'#13#10, [FieldByName('Chemical_ID').AsString, FieldByName('Unit_QTY').AsFloat])
            + 'INSERT INTO FNMDB..fnOperationRecipeDtl(Recipe_NO, Chemical_ID, Unit_QTY) '
            + Format('VALUES(@Recipe_NO, %s, %g) '#13#10, [FieldByName('Chemical_ID').AsString, FieldByName('Unit_QTY').AsFloat]);
          Next;
        end;
      end;
      
      SqlText:=SqlText + GetUpdateJobTraceDtlSQLText(sCardList);
      FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
      //sErrorMsg:=SqlText;
      SetComplete;
    except
      SetAbort;
      raise;
    end;
  finally
    FreeAndNil(cds_Prescription);
  end;
end;

procedure TFNMArtFacadeLib.GetNoCheckRecipe(const sDeparement: WideString;
  out vData: OleVariant; out sErrorMsg: WideString);
var
  SqlText:WideString;
begin
  try
    SqlText:='SELECT Recipe_NO '#13#10 +
             'FROM FNMDB..fnOperationRecipeHdr WITH(NOLOCK) '#13#10 +
             'WHERE Check_Time IS NULL AND Current_Department = '+QuotedStr(sDeparement) +
             ' ORDER BY Recipe_NO';
    FNMDAOInfo.GetCommonDataSet(vData,SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveCheckRecipe(const sChecker,
  sRecipeNO: WideString; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:=Format('UPDATE FNMDB..fnOperationRecipeHdr SET Checker = ''%s'', Check_Time = GETDATE() WHERE Recipe_NO =''%s'''#13#10, [sChecker, sRecipeNO]) +
             Format('EXEC dbo.usp_CalculateRecipeVolume ''%s''', [sRecipeNO]);
    FNMDAOUpt.ExeCommonSql(sqlText,sErrorMsg);
    //sErrorMsg:=SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveBatchTraceInfo(const sOperateType,
  sBatchNO: WideString; sScrapVolume: Integer; const sOperator: WideString;
  var sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:=Format('EXEC dbo.usp_SaveBatchTraceInfo ''%s'', ''%s'', %d, ''%s'' ' ,
                     [sOperateType, sBatchNO, sScrapVolume, sOperator]);
    FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetNoRecipeCards(const sGFKeyValue,
  sCurrentDepartment: WideString; out vData: OleVariant;
  out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:=Format('EXEC dbo.usp_GetNoRecipeCards ''%s'', ''%s''', [sGFKeyValue, sCurrentDepartment]);

    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    //sErrorMsg:= SqlText;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetNoFinishRecipeBatch(
  const sVatStudio: WideString; out vData: OleVariant;
  out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
  {    2007-9-17
    SqlText:='SELECT a.Recipe_NO, a.Batch_NO, b.Machine_ID, a.Volume, b.Remark, b.Flood_Class,'#13#10 +
             '       b.Flood_Percent, c.Vat_NO, a.Vat_Code, a.Reciper, a.Recipe_Time, a.Begin_Time, a.Begin_Operator,'#13#10 +
             '       a.Status, b.Pre_DryTemperature, b.Dry_Temperature'#13#10 +
             'FROM dbo.fnOperationRecipeBatch a WITH(NOLOCK)'#13#10 +
             '  LEFT JOIN dbo.fnOperationRecipeHdr b WITH(NOLOCK) ON a.Recipe_NO = b.Recipe_NO'#13#10 +
             '  LEFT JOIN dbo.fnVatList c WITH(NOLOCK) ON c.Vat_Code = a.Vat_Code'#13#10 +
             'WHERE a.Status < 3'#13#10 +
      Format('  AND (a.Vat_Code IN (SELECT Vat_Code FROM dbo.fnVatList WHERE Vat_Studio = ''%s'') '#13#10, [sVatStudio]) +
      Format('         OR b.Current_Department = ''%s'') ', [sVatStudio]);
   }
    SqlText := 'Exec FNMDB.dbo.usp_fnGetNoFinishRecipeBatch '+ QuotedStr(sVatStudio);
    //sErrorMsg:=SqlText;
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveSplitRecipe(const sRecipeNO, sVatCode,
  sUserVol, sOperator: WideString; out vData: OleVariant;
  out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:=Format('EXEC dbo.usp_SaveSplitRecipe ''%s'', ''%s'', ''%s'', ''%s''', [sRecipeNO, sVatCode, sUserVol, sOperator]);
    FNMDaoUpt.ExeCommonSqlWithResultData(SqlText, vData, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveDelABatch(const sBatchNO: WideString;
  out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:='SET NOCOUNT ON'#13#10 +
             'DECLARE @Batch_NO char(12), @RecipeNO char(12), @Volume numeric(9,0)'#13#10 +
      Format('SET @Batch_NO = ''%s'''#13#10, [sBatchNO])  +
             'SELECT @RecipeNO = Recipe_NO, @Volume = Volume FROM dbo.fnOperationRecipeBatch WHERE Batch_NO = @Batch_NO AND Status = 0'#13#10 +
             'IF @RecipeNO IS NULL'#13#10 +
             'BEGIN'#13#10 +
             '  RAISERROR(''指定的缸号不存在或已经开始化料'', 16, 1)'#13#10 +
             '  RETURN'#13#10 +
             'END'#13#10 +
             'UPDATE dbo.fnOperationRecipeHdr SET Batch_Volume = Batch_Volume - @Volume WHERE Recipe_NO = @RecipeNO'#13#10 +
             'DELETE dbo.fnOperationRecipeBatch WHERE Batch_NO = @Batch_NO'#13#10 +
             'DELETE dbo.fnOperationRecipeBatchHdr WHERE Batch_NO = @Batch_NO'#13#10 +
             'DELETE dbo.fnOperationRecipeBatchDtl WHERE Batch_NO = @Batch_NO'#13#10 +
             'SET NOCOUNT OFF';

    //sErrorMsg:=SqlText;
    FNMDaoUpt.ExeCommonSql(SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetBatchDtlInfo(const sBatchNO: WideString;
  out vData: OleVariant; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:='SELECT b.Step_ID, b.Chemical_ID, c.Chemical_Name, b.Unit_QTY, (b.Unit_QTY * a.Volume) /1000 AS Dosage'#13#10 +
             '  FROM dbo.fnOperationRecipeBatch a WITH(NOLOCK)'#13#10 +
             '    LEFT JOIN dbo.fnOperationRecipeDtl b WITH(NOLOCK) ON b.Recipe_NO = a.Recipe_NO'#13#10 +
             '    LEFT JOIN PUBDB.dbo.pbChemicalList c WITH(NOLOCK) ON c.Chemical_ID = b.Chemical_ID'#13#10 +
      Format('WHERE a.Batch_NO = ''%s''', [sBatchNO]);
    //sErrorMsg:=SqlText;
    FNMDAOInfo.GetCommonDataSet(VData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveNewRecipeVol(const sRecipeNO,
  sOffsetVol: WideString; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:=Format('UPDATE dbo.fnOperationRecipeHdr SET Base_Volume = Base_Volume + %s WHERE Recipe_NO = ''%s''', [sOffsetVol, sRecipeNO]);

    //sErrorMsg:=SqlText;
    FNMDaoUpt.ExeCommonSql(SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveDelRecipe(const sRecipeNO,
  sUserType: WideString; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:='EXEC dbo.usp_DeleteRecipeInfo ' + QuotedStr(sRecipeNO) + ',' + sUserType;
    FNMDaoUpt.ExeCommonSql(SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetMachineRecipeBatch(const sDepartment,
  sMachineID: WideString; out vData: OleVariant;
  out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:='SELECT a.Recipe_NO, a.Batch_NO,'#13#10 +
             '  CASE WHEN EXISTS(SELECT 1 FROM dbo.fnOperationRecipeDtl WHERE Recipe_NO = a.Recipe_NO AND  Chemical_ID  in (402, 401, 419)) THEN ''荧光'''#13#10 +
             '       ELSE ''非荧光'' END AS 荧光,'#13#10 +
             'b.Machine_ID, b.Pre_DryTemperature, b.Dry_Temperature, b.Flood_Class,'#13#10 +
             '       b.Flood_Percent, a.Vat_Code, a.Volume, a.Reciper, a.Recipe_Time, a.Begin_Time, a.Begin_Operator, a.Status, b.Remark'#13#10 +
             'FROM dbo.fnOperationRecipeBatch a WITH(NOLOCK)'#13#10 +
             '  LEFT JOIN dbo.fnOperationRecipeHdr b WITH(NOLOCK) ON a.Recipe_NO = b.Recipe_NO'#13#10 +
      Format('WHERE b.Current_Department = ''%s'' AND Machine_ID = ''%s'' AND Status < 3'#13#10, [sDepartment, sMachineID]) +
             'ORDER BY a.Recipe_NO';
    //sErrorMsg:=SqlText;
    FNMDAOInfo.GetCommonDataSet(VData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetNoRecipeSteps(const sOperationCode,
  sDepartment, sMachineID, sBeginTime, sEndTime: WideString;
  out vData: OleVariant; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:='SELECT Iden, FN_Card, Quantity, Begin_Time'#13#10 +
             '  FROM dbo.fnJobTraceDtl WITH(NOLOCK)'#13#10 +
             'WHERE Recipe_NO = '''' AND FN_Card NOT LIKE ''N%'''#13#10 +
      Format('  AND Operation_Code = ''%s'' AND Current_Department = ''%s'' AND Machine_ID = ''%s'''#13#10, [sOperationCode, sDepartment, sMachineID]) +
      Format('  AND Begin_Time BETWEEN ''%s'' AND ''%s''', [sBeginTime, sEndTime]);

    //sErrorMsg:=SqlText;
    FNMDAOInfo.GetCommonDataSet(VData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveSupplyRecipe(const sTracIdens,
  sOperationCode, sPrescripNO, sMachineID, sDepartment,
  sOperator: WideString; out sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:=Format('EXEC dbo.usp_SaveSupplyRecipe ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s''',
                     [sPrescripNO, sTracIdens, sOperationCode, sMachineID, sDepartment, sOperator]);
    //sErrorMsg:=SqlText;
    FNMDaoUpt.ExeCommonSql(SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetDiluteRecipeInfo(var vData0, vData1,
  vData2: OleVariant; const sBatch_NO: WideString;
  var sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:='EXEC dbo.usp_GetDiluteRecipeInfo '+QuotedStr(sBatch_NO);
    FNMDAOInfo.GetMultiDataSet(SqlText,vData0,vData1,vData2,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveDiluteRecipeInfo(IsNew: Integer; var vData0,
  vData1: OleVariant; var sErrorMsg: WideString);
const
  UPDATEOPERATIONRECIPEBATCHSQL = 'UPDATE dbo.fnOperationRecipeBatch SET Step_ID = %s WHERE Batch_NO = ''%s'' '#13#10;
  INSERTOPERATIONRECIPEBATCHHDRSQL = 'INSERT INTO  dbo.fnOperationRecipeBatchHdr(Batch_NO,Step_ID,Ori_Volume,Dec_Volume,Inc_Volume,Remark,Operator,Operate_Time) VALUES(''%s'',%s,%s,%s,%s,''%s'',''%s'',GETDATE())';
  UPDATEOPERATIONRECIPEBATCHHDRSQL = 'UPDATE dbo.fnOperationRecipeBatchHdr SET Ori_Volume = %s,Dec_Volume = %s,Inc_Volume = %s,Remark = ''%s'',Operator = ''%s'',Operate_Time = GETDATE() WHERE Batch_NO = ''%s'' AND Step_ID = %s ';
var
  SqlText: WideString;
  cdsTemp: TClientDataSet;
begin
  try
    if IsNew = 1 then
       SqlText := Format(INSERTOPERATIONRECIPEBATCHHDRSQL,[vData0[0][0],vData0[0][1],vData0[0][2],vData0[0][3],vData0[0][4],vData0[0][5],vData0[0][6]])
    else
    begin
      SqlText := Format(UPDATEOPERATIONRECIPEBATCHSQL,[vData0[0][1],vData0[0][0]]);
      SqlText := SqlText + Format(UPDATEOPERATIONRECIPEBATCHHDRSQL,[vData0[0][2],vData0[0][3],vData0[0][4],vData0[0][5],vData0[0][6],vData0[0][0],vData0[0][1]]);
    end;
    try
      cdsTemp:=TClientDataSet.Create(nil);
      with cdsTemp do
      begin
        Data:=vData1;
        First;
        SqlText:=SqlText +#13#10+  Format('DELETE FROM dbo.fnOperationRecipeBatchDtl WHERE Batch_NO=''%s'' AND Step_ID = %s'+#13#10,[vData0[0][0],vData0[0][1]]);
        while not Eof do
        begin
          SqlText:=SqlText +
            'INSERT INTO dbo.fnOperationRecipeBatchDtl(Batch_NO,Step_ID,Chemical_ID, Unit_QTY) '+
            Format('VALUES(''%s'',%d,''%s'', %g) '#13#10, [FieldByName('Batch_NO').AsString, FieldByName('Step_ID').AsInteger,FieldByName('Chemical_ID').AsString, FieldByName('Unit_QTY').AsFloat]);
          Next;
        end;
      end;
    finally
      FreeAndNil(cdsTemp);
    end;
    FNMDAOUpt.ExeCommonSql(SqlText,sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.DeleteInnerRepairInfo(iAnalysisIden: Integer;
  const sOperator: WideString; var sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:='EXEC dbo.usp_DeleteInnerRepair ' +IntToStr(iAnalysisIden) + ','+QuotedStr(sOperator);
    FNMDaoUpt.ExeCommonSql(SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.CheckNeedRoll(const sGFIDList: WideString;
  var NeedRoll, sErrorMsg: WideString);
var
  SqlText: WideString;
  vFieldValue: OleVariant;
begin
  try
    SqlText:='SELECT TOP 1 Material_Quality FROM dbo.fnStdArtHdr a WITH(NOLOCK)  '+
             '  INNER JOIN dbo.fnStdArtDtl b WITH(NOLOCK) ON b.Std_Art_ID = a.Std_Art_ID '+
             'WHERE Operation_Code=''008'' AND b.Item_Name=''卷装'' AND b.Item_Value = '''''+
             ' AND GF_ID IN (SELECT NO FROM PUBDB.dbo.udf_ConvertStrToTable('''+sGFIDList+''', '',''))';
    FNMDAOInfo.GetCommonFieldValue(vFieldValue, SqlText, sErrorMsg);
    if vFieldValue <> '' then
      NeedRoll := 'Y'
    else
      NeedRoll := 'N';
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.ModifyProductWidth(const sGF_Key: WideString;
  iWidth: Single; const sReason, sOperator: WideString;
  var sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:=' EXEC dbo.usp_ChangeWidth ' + FloatToStr(iWidth) + ','+ QuotedStr(sGF_Key) + ','+ QuotedStr(sOperator) + ',' + QuotedStr(sReason);
    FNMDaoUpt.ExeCommonSql(SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.CreateRepairArtInfo(Iden, GF_ID: Integer;
  const sCardList, sCurrent_Department, sOperator: WideString; var vData0,
  vData1: OleVariant; var sErrorMsg: WideString);
var
  SqlText:WideString;
  vDataTemp: OleVariant;
begin
  try
    SqlText:= Format('EXEC dbo.usp_CreateRepairArtInfo %d, %d,''%s'',''%s'',''%s''', [Iden, GF_ID,sCardList,sCurrent_Department, sOperator]);
    FNMDAOInfo.GetMultiDataSet(SqlText, vData0, vData1, vDataTemp, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetEditCardLists(const sGF_NO,
  sCurrent_Department: WideString; var vData: OleVariant;
  var sErrorMsg: WideString);
var
  SqlText:WideString;
begin
  try
    SqlText:= Format('EXEC dbo.usp_GetEditCardLists ''%s'',''%s''', [sGF_NO, sCurrent_Department]);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.ChangeVatCode(const sBatchNO,
  sNewVatCode: WideString; var sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:=Format('UPDATE FNMDB.dbo.fnOperationRecipeBatch SET Vat_Code = ''%s'' WHERE Batch_NO = ''%s''', [sNewVatCode, sBatchNO]);
    //sErrorMsg:=SqlText;
    FNMDaoUpt.ExeCommonSql(SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.AutoCreateStdArtDtl(const sGFNO,
  sCurrentDepartment: WideString; var vData: OleVariant;
  var sErrorMsg: WideString);
var
  SqlText:WideString;
begin
  try
    SqlText:= Format('EXEC dbo.usp_AutoCreateStdArt ''%s'',''%s''', [sGFNO, sCurrentDepartment]);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveModifiedArtLog(const sStr: WideString;
  var sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
    SqlText:='exec usp_fnSaveModifiedArtLog '+ sStr;
    FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.GetFeedbackInfo(var vData: OleVariant;
  iGF_ID: Integer; const sCurrent_Department: WideString;
  var sErrorMsg: WideString);
var
  SqlText:WideString;
begin
  try
    SqlText:= 'SELECT Item_Name, Aspect, Item_Value, Unit, Min_RQMT, Max_RQMT, '+
              'Is_OK FROM dbo.fnstdartfeedback WITH(NOLOCK)  '+
              'WHERE GF_ID = ' + IntToStr(iGF_ID) + ' AND Current_Department = '+QuotedStr(sCurrent_Department);
    FNMDAOInfo.GetCommonDataSet(vData, SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TFNMArtFacadeLib.SaveFeedbackInfo(var vDataParam: OleVariant;
  var sErrorMsg: WideString);
var
  SqlText: WideString;
begin
  try
     SqlText := 'EXEC dbo.usp_SaveStdArtEx ' +
                     QuotedStr(vDataParam[0]) + ','+
                     QuotedStr(vDataParam[1]) + ','+
                     QuotedStr(vDataParam[2]) + ','+
                     QuotedStr(vDataParam[3]) + ','+
                     QuotedStr(vDataParam[4]);
    FNMDAOUpt.ExeCommonSql(SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;  
end;

initialization
  TAutoObjectFactory.Create(ComServer, TFNMArtFacadeLib, Class_FNMArtFacadeLib,
    ciMultiInstance, tmNeutral);
end.
