unit UFNMDAOInfo;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  SysUtils, Classes, ComServ, ComObj, VCLCom, StdVcl, bdemts,
  DataBkr, DBClient, MtsRdm, Mtx, FNMDAO_TLB, Provider, DB, ADODB, ADOInt;

type
  TFNMDAOInfo = class(TMtsDataModule, IFNMDAOInfo)
    adoConnection: TADOConnection;
    dataSetProvider: TDataSetProvider;
    procedure MtsDataModuleCreate(Sender: TObject);
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;

    procedure GetCommonDataSet(var vData: OleVariant; const sqlText: WideString; var sErrorMsg: WideString); safecall;
    {* 该方法实现一些通用的获取数据集的方法，最常见的是提供一个sql语句，返回数据集。}
    procedure GetCommonFieldValue(var vFieldValue: OleVariant; const sSqlText: WideString; var sErrorMsg: WideString); safecall;
    {* 通过SQL语句返回第一条记录第一个字段的值}
    procedure GetMultiDataSet(const sSqlText: WideString; var vData0, vData1, vData2: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetCommonData(var vData: OleVariant; const sqlText: WideString;
      var sErrorMsg: WideString); safecall;
    procedure ExeCommonSql(const sSqlText: WideString;
      var sErrorMsg: WideString); safecall;
    {* 通过单SQL语句返回多数据集合}
  end;

var
  FNMDAOInfo: TFNMDAOInfo;

implementation

uses DA, ComDllPub;

{$R *.DFM}

class procedure TFNMDAOInfo.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
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

procedure TFNMDAOInfo.MtsDataModuleCreate(Sender: TObject);
begin
  adoConnection.ConnectionString :=GetConnectionString('FNMDAO.dll','FNM');
end;

procedure TFNMDAOInfo.GetCommonDataSet(var vData: OleVariant;
  const sqlText: WideString; var sErrorMsg: WideString);
var
  da:TDA;
begin
  try
    try
      da:=TDA.Create(sqlText,cmdText,adoConnection);
      dataSetProvider.DataSet :=da.DataSet(sErrorMsg);
      if sErrorMsg='' then
      begin
        vData:=dataSetProvider.Data;
        setcomplete;
      end
      else
        setAbort;
    except
      on e: Exception do
      begin
        sErrorMsg:=e.Message;
        setabort;
      end
    end;
  finally
    FreeAndNil(da);
  end;
end;

procedure TFNMDAOInfo.GetCommonFieldValue(var vFieldValue: OleVariant;
  const sSqlText: WideString; var sErrorMsg: WideString);
var
  da:TDA;
begin
  try
    try
      da:=TDA.Create(sSqlText,cmdText,adoConnection);
      vFieldValue:=da.ExecuteScalar(sErrorMsg);
      if sErrorMsg='' then   setcomplete else setAbort;
    except
      on e: Exception do
      begin
        sErrorMsg:=e.Message;
        setabort;
      end
    end;
  finally
    FreeAndNil(da);
  end;
end;

procedure TFNMDAOInfo.GetMultiDataSet(const sSqlText: WideString;
  var vData0, vData1, vData2: OleVariant; var sErrorMsg: WideString);
const
  ResultParamCount= 3;//vData参数的个数.
var
  da: TDA;
  i, RowCount: Integer;
  Recordset: _Recordset;
  mADODataset: TADODataset;
  VariantData: Array[1..ResultParamCount] of OleVariant;
begin
  FillChar(VariantData, Sizeof(VariantData), #0);
  try
    try
      da:=TDA.Create(sSqlText, cmdText, adoConnection);
      mADODataset:=da.DataSet(sErrorMsg);
      if sErrorMsg <> '' then
        exit;

      DataSetProvider.DataSet:= mADODataset;
      Recordset:=mADODataset.Recordset;
      i:=0;

      while (Recordset <> nil) and (i <= ResultParamCount) do
      begin
        if (Recordset.State and adStateOpen) <> 0 then
        begin
          Inc(i);
          mADODataset.Recordset:=Recordset;
          VariantData[i]:=DataSetProvider.Data;
        end;

        Recordset:= mADODataset.NextRecordset(RowCount);
      end;

      if sErrorMsg='' then   setcomplete else setAbort;
    except
      on e: Exception do
      begin
        sErrorMsg:=e.Message;
        setabort;
      end
    end;
  finally
    FreeAndNil(da);
  end;

  vData0:=VariantData[1];
  vData1:=VariantData[2];
  vData2:=VariantData[3];
end;

procedure TFNMDAOInfo.GetCommonData(var vData: OleVariant;
  const sqlText: WideString; var sErrorMsg: WideString);
var
  da: TDA;
  i, RowCount: Integer;
  Recordset: _Recordset;
  VariantData: array of OleVariant;
  mADODataset: TADODataset;
begin
  try
    try
      da:=TDA.Create(sqlText, cmdText, adoConnection);
      mADODataset:=da.DataSet(sErrorMsg);
      if sErrorMsg <> '' then exit;

      DataSetProvider.DataSet:= mADODataset;
      Recordset:=mADODataset.Recordset;
      i:=0;
      while (Recordset <> nil) do
      begin
        if (Recordset.State and adStateOpen) <> 0 then
        begin
          Inc(i);
          SetLength(VariantData, i);
          mADODataset.Recordset:=Recordset;
          VariantData[i-1]:=DataSetProvider.Data;
        end;
        Recordset:= mADODataset.NextRecordset(RowCount);
      end;
      if i = 1 then
        vData := VariantData[0]
      else
        vData := VariantData;
      if sErrorMsg='' then setcomplete else setAbort;
    except
      on e: Exception do
      begin
        sErrorMsg:=e.Message;
        setabort;
      end
    end;
  finally
    FreeAndNil(da);
    SetLength(VariantData, 0);
  end;
end;

procedure TFNMDAOInfo.ExeCommonSql(const sSqlText: WideString;
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

initialization
  TComponentFactory.Create(ComServer, TFNMDAOInfo,
    Class_FNMDAOInfo, ciMultiInstance, tmNeutral);
end.


