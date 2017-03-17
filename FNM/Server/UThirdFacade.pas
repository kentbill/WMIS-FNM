unit UThirdFacade;
{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ActiveX, Mtsobj, Mtx, ComObj, FNMFacade_TLB, StdVcl;

type
  TThirdFacade = class(TMtsAutoObject, IThirdFacade)
  protected
    { Protected declarations }
    procedure GetMONMachineEfficiency(const Machine, sBeginTime,
      sEndTime: WideString; var vData: OleVariant;
      var sErrorMsg: WideString); safecall;
    procedure GetMONMachineParamterList(var vData: OleVariant;
      var sErrorMsg: WideString); safecall;
    procedure ExportRecipeToCS(const sBatchNO: WideString;
      var sErrorMsg: WideString); safecall;
  end;

implementation

uses
  ComServ, ComDllPub, SysUtils, DBClient;

const
  //mon机器参数
  MONMachineParSQL =
'select a.LogType_ID, a.TypeConfID, a.LogValueIdx, b.Machine, d.Name ' +
'	from logTypeDef a ' +
'	  left join logType b on a.LogType_ID = b.ID ' +
'	  left join Machines c on b.Machine = c.MachineNO ' +
'	  left join MachGrpParameter d on a.TypeConfID = d.TypeConfID and c.MGroupNO = d.MachGrp_MgroupNO ' +
//'where Machine = ''MON3''' + //*MON2, MON3, MON4,MON5,MON6*/
'order by LogType_ID, LogValueIdx';

  //mon2效率(新厂定型机1#)
  MON2EfficiencySQL =
'select ''MON2'' as Machine, ' +
'  la.LogTimeStamp, la.Value07 as Act_machine_speed, lb.Value09 as MeterCounter ' +
'from LogValueFloat la ' +
'  INNER JOIN LogValueFloat lb on la.LogTimeStamp = lb.LogTimeStamp ' +
'where la.LogType_ID = 6 ' +
'  AND lb.LogType_ID = 8 ' +
'  AND la.LogTimeStamp between ''%BeginTime%'' and ''%EndTime%''';

  //mon3效率(新厂定型机2#)
  MON3EfficiencySQL =
'select ''MON3'' as Machine, ' +
'  la.LogTimeStamp, la.Value07 as Act_machine_speed, lb.Value09 as MeterCounter ' +
'from LogValueFloat la ' +
'  INNER JOIN LogValueFloat lb on la.LogTimeStamp = lb.LogTimeStamp ' +
'where la.LogType_ID = 11 ' +
'  AND lb.LogType_ID = 13 ' +
'  AND la.LogTimeStamp between ''%BeginTime%'' and ''%EndTime%''';

  //mon4效率(新厂定型机3#)
  MON4EfficiencySQL =
'select ''MON4'' as Machine, ' +
'  la.LogTimeStamp, la.Value07 as Act_machine_speed, lb.Value09 as MeterCounter ' +
'from LogValueFloat la ' +
'  INNER JOIN LogValueFloat lb on la.LogTimeStamp = lb.LogTimeStamp ' +
'where la.LogType_ID = 16 ' +
'  AND lb.LogType_ID = 18 ' +
'  AND la.LogTimeStamp between ''%BeginTime%'' and ''%EndTime%''';

  //mon5效率(新厂预缩机1#)
  MON5EfficiencySQL =
'select ''MON5'' as Machine, ' +
'  la.LogTimeStamp, la.Value03 as Act_machine_speed, la.Value19 as MeterCounter ' +
'from LogValueFloat la ' +
'where la.LogType_ID = 21 ' +
'  AND la.LogTimeStamp between ''%BeginTime%'' and ''%EndTime%''';
    
  //mon6效率(新厂预缩机2#)
  MON6EfficiencySQL =
'select ''MON6'' as Machine, ' +
'  la.LogTimeStamp, la.Value03 as Act_machine_speed, la.Value19 as MeterCounter ' +
'from LogValueFloat la ' +
'where la.LogType_ID = 23 ' +
'  AND la.LogTimeStamp between ''%BeginTime%'' and ''%EndTime%''';

  //倒入化工料到CS系统
  ExportRecipeSQL =
'DECLARE @BatchNO varchar(12)'#13#10 +
'SET @BatchNO = ''%s'''#13#10 +
'SELECT a.Batch_NO, a.Batch_NO AS Recipe_NO, a.Volume, b.CS_MachineID, b.CS_TankNumber, 20 AS State'#13#10 +
'  FROM FNMDB.dbo.fnOperationRecipeBatch a WITH(NOLOCK)'#13#10 +
'   INNER JOIN FNMDB.dbo.fnVatList b WITH(NOLOCK) ON a.Vat_Code = b.Vat_Code'#13#10 +
'WHERE Batch_NO = @BatchNO'#13#10 +
'SELECT @BatchNO AS Recipe_NO, ''CM'' + CONVERT(varchar(10), a.Chemical_ID) AS Chemical_ID, a.Unit_Qty, 0 AS [Sequence], 0 AS Diluition_Percent, 0 AS Mixing_Time, 3 AS Kind_Water'#13#10 +
'  FROM FNMDB.dbo.fnOperationRecipeDtl a WITH(NOLOCK)'#13#10 +
'WHERE Recipe_NO = (SELECT Recipe_NO FROM FNMDB.dbo.fnOperationRecipeBatch WHERE Batch_NO = @BatchNO)';

procedure TThirdFacade.GetMONMachineEfficiency(const Machine, sBeginTime,
  sEndTime: WideString; var vData: OleVariant; var sErrorMsg: WideString);
var
  sSqlTex, sServerTag: String;
begin
  if Machine = 'MON2' then
    sSqlTex:=MON2EfficiencySQL;
  if Machine = 'MON3' then
    sSqlTex:=MON3EfficiencySQL;
  if Machine = 'MON4' then
    sSqlTex:=MON4EfficiencySQL;
  if Machine = 'MON5' then
    sSqlTex:=MON5EfficiencySQL;
  if Machine = 'MON6' then
    sSqlTex:=MON6EfficiencySQL;
    
//  if (Machine = 'MON2') or (Machine = 'MON3') then
//    sServerTag:='OT-Server'
//  else
    sServerTag:='Monforts';

  sSqlTex:=StringReplace(sSqlTex, '%BeginTime%', sBeginTime, [rfReplaceAll]);
  sSqlTex:=StringReplace(sSqlTex, '%EndTime%',   sEndTime,   [rfReplaceAll]);
  try
    ThirdDAOInfo.GetCommonDataSet(sServerTag, sSqlTex, vData, sErrorMsg);
    if sErrorMsg <> '' then sErrorMsg := sErrorMsg + sSqlTex;
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TThirdFacade.GetMONMachineParamterList(var vData: OleVariant;
  var sErrorMsg: WideString);
var
  sSqlTex, sServerTag: String;
begin
  sSqlTex:=MONMachineParSQL;
  sServerTag:='Monforts';
  try
    ThirdDAOInfo.GetCommonDataSet(sServerTag, sSqlTex, vData, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

procedure TThirdFacade.ExportRecipeToCS(const sBatchNO: WideString;
  var sErrorMsg: WideString);
const
  InsertBatch =
    'INSERT INTO csdlvsdb.dbo.Batchs(Batch_Code, Recipe_Code, Volume, Machine, Tank_Number, State)'#13#10 +
    '  VALUES(''%s'', ''%s'', %s, ''%s'', %d, 10)'#13#10;
  InsertRecipe =
    'INSERT INTO csdlvsdb.dbo.Recipes(Recipe_Code, Product_Code, Quantity, [Sequence], Diluition_Percent, Mixing_Time, Kind_Water)'#13#10 +
    '  VALUES(''%s'', ''%s'', %s, 0, 0, 0, 3)'#13#10;
var
  i: Integer;
  SqlText: WideString;
  TmpClientDataSet: TClientDataSet;
  vData1, vData2, vDataTemp: OleVariant;
begin
  try
    SqlText:= Format(ExportRecipeSQL, [sBatchNO]);
    FNMDAOInfo.GetMultiDataSet(SqlText, vData1, vData2, vDataTemp, sErrorMsg);

    if sErrorMsg <> '' then
      raise Exception.Create('查询缸号信息出错!');

    SqlText:='';
    TmpClientDataSet:=TClientDataSet.Create(nil);
    try
      TmpClientDataSet.Data:=vData1;
      SqlText:='DELETE FROM Batchs WHERE Batch_Code = ''' + TmpClientDataSet.FieldByName('Batch_NO').AsString + ''''#13#10 +
               'DELETE FROM Recipes WHERE Recipe_Code = ''' + TmpClientDataSet.FieldByName('Recipe_NO').AsString + ''''#13#10;
      SqlText:=SqlText +
        Format(InsertBatch, [TmpClientDataSet.FieldByName('Batch_NO').AsString,
                             TmpClientDataSet.FieldByName('Recipe_NO').AsString,
                             TmpClientDataSet.FieldByName('Volume').AsString,
                             TmpClientDataSet.FieldByName('CS_MachineID').AsString,
                             TmpClientDataSet.FieldByName('CS_TankNumber').AsInteger]);

      TmpClientDataSet.Data:=vData2;
      for i := 0 to TmpClientDataSet.RecordCount - 1 do
      begin
        SqlText:=SqlText +
          Format(InsertRecipe, [TmpClientDataSet.FieldByName('Recipe_NO').AsString,
                                TmpClientDataSet.FieldByName('Chemical_ID').AsString,
                                TmpClientDataSet.FieldByName('Unit_Qty').AsString]);
        TmpClientDataSet.Next;
      end;
    finally
      TmpClientDataSet.Free;
    end;

    //sErrorMsg:=SqlText;
    ThirdDAOUpt.ExeCommonSql('CSServer', SqlText, sErrorMsg);
    SetComplete;
  except
    SetAbort;
    raise;
  end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TThirdFacade, Class_ThirdFacade,
    ciMultiInstance, tmNeutral);
end.
