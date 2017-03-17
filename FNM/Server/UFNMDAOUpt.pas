unit UFNMDAOUpt;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom,
  bdemts, DataBkr, DBClient, MtsRdm, Mtx, FNMDAO_TLB, variants,
  Provider, DB, ADODB, StdVcl, ADOInt;

type
  TFNMDAOUpt = class(TMtsDataModule, IFNMDAOUpt)
    adoConnection: TADOConnection;
    dataSetProvider: TDataSetProvider;
    procedure MtsDataModuleCreate(Sender: TObject);
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;

    procedure SaveDataset(vData: OleVariant; const sSqlText: WideString; var sErrorMsg: WideString; bResolveToDataSet: WordBool); safecall;
    {* }
    procedure SaveCommonDataSet(vData: OleVariant; const sqlForDelphi, sqlForADO: WideString; var sErrorMsg: WideString); safecall;
    {* }
    procedure ExeCommonSql(const sSqlText: WideString; var sErrorMsg: WideString); safecall;
    {* }
    procedure ExeCommonSqlWithResult(const sSqlText, sFieldName: WideString; var sResult, sErrorMsg: WideString); safecall;
    {* }
    procedure SaveMultiDataSet(var vData: OleVariant; const sSqlText,
      sKeyField, sUpdateSqlText: WideString; var sErrorMsg: WideString;
      bResolveToDataSet: WordBool); safecall;
    procedure ExeCommonSqlWithResultData(const sSqlText: WideString;
      out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure SaveMultiData(vData1, vData2: OleVariant; const sSQLText1,
      sSQLText2, sSQLText_Before, sSQLText_After, sKey1, sKey2: WideString;
      var sErrorMsg: WideString); safecall;
    procedure SaveDatasetByKey(vData: OleVariant; const sSqlText,
      sKeyField: WideString; bResolveToDataSet: WordBool;
      var sErrorMsg: WideString); safecall;
  end;

var
  FNMDAOUpt: TFNMDAOUpt;

implementation

uses DA, ComDllPub;

{$R *.DFM}

class procedure TFNMDAOUpt.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
begin
  if Register then
  begin
    inherited UpdateRegistry(Register, ClassID, ProgID);
    EnableSocketTransport(ClassID);
    EnableWebTransport(ClassID);
  end else
  begin
    DisableSocketTransport(ClassID);
    DisableWebTransport(ClassID);
    inherited UpdateRegistry(Register, ClassID, ProgID);
  end;
end;

procedure TFNMDAOUpt.MtsDataModuleCreate(Sender: TObject);
begin
  adoCOnnection.ConnectionString :=GetConnectionString('FNMDAO.dll','FNM');
end;

procedure TFNMDAOUpt.SaveDataset(vData: OleVariant;
  const sSqlText: WideString; var sErrorMsg: WideString;
  bResolveToDataSet: WordBool);
var
  da:TDA;
begin
  try
    try
      da:=tda.create();
      datasetprovider.resolvetodataset :=bresolvetodataset;
      da.applyupdate(datasetprovider,vdata,ssqltext,adoconnection,serrormsg);
      if sErrorMsg='' then   setcomplete else setAbort;
    except
      on e:Exception do
      begin
        sErrorMsg:=e.Message;
        setabort;
      end;
    end;
  finally
    FreeAndNil(da);;
  end;
end;

procedure TFNMDAOUpt.SaveCommonDataSet(vData: OleVariant;
  const sqlForDelphi, sqlForADO: WideString; var sErrorMsg: WideString);
begin
  try
    SaveDataSet(vData,sqlForDelphi,sErrorMsg,false);
    if sErrorMsg='' then   setcomplete else setAbort;
  finally
    if sErrormsg<>'' then
    begin
      if Copy(sErrorMsg,1,23)='Error Code: -2147217900' then
      begin
        try
          begin
            SaveDataSet(vData,sqlForADO,sErrorMsg,true);
            if sErrorMsg='' then   setcomplete else setAbort;
          end;
        except
          setabort;
        end;
      end
      else
        setabort;
    end;
  end;
end;

procedure TFNMDAOUpt.ExeCommonSql(const sSqlText: WideString;
  var sErrorMsg: WideString);
var
  da:TDA;
begin
  sErrorMsg:='';
  da:=TDA.Create(sSqlText,cmdText,adoConnection);
  try
    try
      da.ExecuteNonQuery(sErrorMsg);
      if sErrorMsg='' then
        setcomplete
      else
        raise exception.Create(sErrorMsg);
    except
      on e:Exception do
      begin
        sErrorMsg:=e.Message;
        setabort;
      end;
    end;
  finally
    da.Free;
  end;
end;

procedure TFNMDAOUpt.ExeCommonSqlWithResult(const sSqlText,
  sFieldName: WideString; var sResult, sErrorMsg: WideString);
var
  da:TDA;
begin
  try
    try
      da:=TDA.Create(sSqlText,cmdText,adoConnection);
      da.SetParameterValue(sFieldName,'');
      da.ExecuteNonQuery(sErrorMsg);
      sResult := da.GetParameterValue(sFieldName);
      if sErrorMsg='' then setcomplete else raise exception.Create(sErrorMsg);
    except
      on e:Exception do
      begin
        sErrorMsg:=e.Message;
        setabort;
      end;
    end;
  finally
    FreeAndNil(da);;
  end;
end;

procedure TFNMDAOUpt.SaveMultiDataSet(var vData: OleVariant;
  const sSqlText, sKeyField, sUpdateSqlText: WideString;
  var sErrorMsg: WideString; bResolveToDataSet: WordBool);
var da:TDA;
begin
  try
    try
      da:=tda.Create();
      datasetprovider.resolvetodataset :=bresolvetodataset;
      da.applyupdate(datasetprovider,vdata,ssqltext,sKeyField,adoconnection,serrormsg);
      if (Trim(sErrorMsg) <> '') then
      begin
        setabort;
        Exit;
      end;

        //执行保存数据后的语句
      if trim(sUpdateSqlText)<>'' then
      begin
        ExeCommonSql(sUpdateSqlText,sErrorMsg);
        if Trim(sErrorMsg)<>'' then
        begin
          raise exception.Create(sErrorMsg);
          setabort;
          Exit;
        end
      end;
      setcomplete;
    except
      on e:Exception do
      begin
        sErrorMsg:=e.Message;
        setabort;
      end;
    end;
  finally
    FreeAndNil(da);;
  end;
end;

procedure TFNMDAOUpt.ExeCommonSqlWithResultData(const sSqlText: WideString;
  out vData: OleVariant; out sErrorMsg: WideString);
var
  da:TDA;
  ResultDataSet: TDataSet;
begin
  try
    try
      da:=TDA.Create(sSqlText, cmdText, adoConnection);

      ResultDataSet:=da.DataSet(sErrorMsg);
      if sErrorMsg='' then
      begin
        DataSetProvider.DataSet:=ResultDataSet;
        vData:=DataSetProvider.Data;
        setcomplete;
      end
      else
        setAbort;
    except
      on e:Exception do
      begin
        sErrorMsg:=e.Message;
        setabort;
      end;
    end;
  finally
    FreeAndNil(da);
  end;
end;

procedure TFNMDAOUpt.SaveMultiData(vData1, vData2: OleVariant;
  const sSQLText1, sSQLText2, sSQLText_Before, sSQLText_After, sKey1,
  sKey2: WideString; var sErrorMsg: WideString);
begin
  try
    //执行保存数据前的语句
    if trim(sSQLText_Before) <> '' then
    begin
      ExeCommonSql(sSQLText_Before, sErrorMsg);
      if trim(sErrorMsg) <> '' then
        raise Exception.Create(sErrorMsg);
    end;
    //保存第一个数据集
    if (trim(sSQLText1) <> '') and (vData1 <> Null) then
    begin
      if trim(sKey1) = '' then
        SaveDataSet(vData1, sSQLText1, sErrorMsg, false)
      else
        SaveDataSetByKey(vData1, sSQLText1, sKey1, false, sErrorMsg);
      if trim(sErrorMsg) <> '' then
        raise Exception.Create(sErrorMsg);
    end;

    //保存第二个数据集
    //当sSQLText2为空时，只保存第一个数据集的数据
    if (trim(sSQLText2) <> '') and (vData2 <> Null) then
    begin
      if trim(sKey2) = '' then
        SaveDataSet(vData2, sSQLText2, sErrorMsg, false)
      else
        SaveDataSetByKey(vData2, sSQLText2, sKey2, false, sErrorMsg);
      if trim(sErrorMsg) <> '' then
        raise Exception.Create(sErrorMsg);
    end;

    //执行保存数据后的语句
    if trim(sSQLText_After) <> '' then
    begin
      ExeCommonSql(sSQLText_After, sErrorMsg);
      if trim(sErrorMsg) <> '' then
        raise Exception.Create(sErrorMsg);
    end;
    setcomplete;
  except
    on e: Exception do
    begin
      sErrorMsg := e.Message;
      setabort;
    end;
  end;
end;

procedure TFNMDAOUpt.SaveDatasetByKey(vData: OleVariant; const sSqlText,
  sKeyField: WideString; bResolveToDataSet: WordBool;
  var sErrorMsg: WideString);
var da: TDA;
begin
  try
    try
      da := tda.Create();
      datasetprovider.resolvetodataset := bresolvetodataset;
      da.applyupdate(datasetprovider, vdata, ssqltext, sKeyField, adoconnection, serrormsg);
      if sErrorMsg <> '' then
        raise exception.Create(sErrorMsg);
      setcomplete;
    except
      on e: Exception do
      begin
        sErrorMsg := e.Message;
        setabort;
      end;
    end;
  finally
    da.free;
  end;
end;

initialization
  TComponentFactory.Create(ComServer, TFNMDAOUpt,
    Class_FNMDAOUpt, ciMultiInstance, tmNeutral);
end.


