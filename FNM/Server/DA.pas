unit DA;
{*******************************************************************************
          Copyright (C) 2004-2005 ESQUEL GROUP IT DEPARTMENT
文件名: TDA
创建人: WLX
日 期:  2004-5-31
修改人:
修改内容描述：
修改日期:
描 述: 该类封装了访问sqlserver数据库的常见方式。可以返回数据集，可以返回一个
       单字段值，也可以执行常用的insert,delete ,update语句等 .同时提供多层模式
       的 DatasetProvider.ApplyUpdate 通用方法。
版 本:  V 1.00
*******************************************************************************}
interface

uses Classes, DBClient, StdVcl, DB, ADODB, SysUtils,IdGlobal, Variants, Provider;

type
  TDA = class(TObject)
  protected
    mADOCommand: TADOCommand;
    mADODataset: TADODataset;
  private
    mErrorMessage: string;
    function GetCommandText: string;
    procedure SetCommandText(const Value: string);
    function GetCommand: TADOCommand;
    function GetConnection: TADOConnection;
    procedure SetConnection(Value: TADOConnection);
    function GetParameters: TParameters;
    function GetTimeOut: Integer;
    procedure SetTimeOut(Value: Integer);
    function GetCommandType: TCommandType;
    procedure SetCommandType(const Value: TCommandType);
    function GetDefaultDatabase(sqlText :String):String;
    function GetOldDefaultDatabase(connectionString:string):String;
    procedure DatasetProviderUpdateError(Sender: TObject; DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind; var Response: TResolverResponse);
    function GetConnectionError(adoConnection:TADOConnection):string;
  public
    constructor Create(); overload;
    constructor Create(commandText: string; commandType: TCommandType; conn: TADOConnection); overload;
    destructor Destroy; override;

    procedure ExecuteNonQuery(var sErrorMsg: widestring); overload; //执行insert,delete,updaate等不需要记录集的sql语句
    procedure ExecuteNonQuery(); overload;

    function ExecuteScalar(var sErrorMsg: widestring): variant; overload; //返回第一条记录第一个字段值，一般用来获取单个字段值，如果根据id好获取名称
    function ExecuteScalar: variant; overload;

    function Execute(var sErrorMsg: widestring): _Recordset; overload; //返回记录集
    function Execute: _Recordset; overload;

    function DataSet(var sErrorMsg: widestring; bNextRecordSet: boolean = false): TADODataSet; overload;
    function DataSet(bNextRecordSet: boolean = false): TADODataSet; overload;

    procedure AddParameter(parameterName: string; parameterType: TFieldType; parameterValue: Variant; parameterDirection: TParameterDirection); //增加或设定参数值、类型等

    procedure ApplyUpdate(datasetProvider: TDataSetProvider; delta: OleVariant; var sErrorMsg: widestring); overload;
    procedure ApplyUpdate(datasetProvider: TDataSetProvider; delta: OleVariant; sql: Widestring; connection: TADOConnection; var sErrorMsg: widestring); overload;
    //按指定的字段作为Update KEY更新数据集
    procedure ApplyUpdate(datasetProvider: TDataSetProvider;delta: OleVariant; sql,sKeyField: Widestring;   connection: TADOConnection; var sErrorMsg: widestring); overload;

    function CheckParaByName(parameterName: string): boolean; //检查一个参数是否存在
    function GetParameterValue(parameterName: string): variant; //返回参数值
    procedure SetParameterValue(parameterName: string; parameterValue: variant); //设定参数值
    function GetParameterType(parameterName: string): TFieldType; //返回参数类型
    procedure SetParameterType(parameterName: string; parameterType: TFieldType); //设定返回参数类型
    function GetParameterDirection(parameterName: string): TParameterDirection; //返回参数传递方向
    procedure SetParameterDirection(parameterName: string; parameterDirection: TParameterDirection); //返回参数传递方向
    property CommandText: string read GetCommandText write SetCommandText; //获取或设定执行的sql语句
    property CommandType: TCommandType read GetCommandType write SetCommandType; //获取或设定sql语句类型，cmdText,cmdStoredProc ...
    property Command: TADOCommand read GetCommand; //获取执行sql语句的TADOCommand对象
    property Connection: TADOConnection read GetConnection write SetConnection; //获取TADOCommand的连接对象
    property Parameters: TParameters read GetParameters; //获取TADOCommand的Parameters对象
    property TimeOut: Integer read GetTimeOut write SetTimeOut; //获取或设定TADOCommand的CommandTimeOut时间
  end;

implementation

{ TDA }

constructor TDA.Create;
begin
  mADOCommand := TADOCommand.Create(nil);
end;

constructor TDA.Create(commandText: string; commandType: TCommandType; conn: TADOConnection);
begin
  mADOCommand := TADOCommand.Create(nil);
  mADOCommand.Connection := conn;
  mADOCommand.CommandText := commandText;
  mADOCommand.CommandType := commandType;
  mADOCommand.CommandTimeout :=conn.ConnectionTimeout; 
end;

destructor TDA.Destroy;
begin
  mADOCommand.Free;
  if mADODataset <> nil then
    mADODataset.Free;
  inherited;
end;

//检查一个参数是否存在
function TDA.CheckParaByName(parameterName: string): boolean;
begin
  if mADOCommand.Parameters.FindParam(parameterName) = nil then
    result := false
  else
    result := true;
end;

// 如果参数已经存在则不添加参数，但是会替换其余参数属性
procedure TDA.AddParameter(parameterName: string;
  parameterType: TFieldType; parameterValue: Variant;
  parameterDirection: TParameterDirection);
var mParameter: TParameter;
begin
  mParameter := mADOCommand.Parameters.FindParam(parameterName);
  if mParameter = nil then //如果指定的参数名不存在，添加参数
  begin
    mParameter := mADOCommand.Parameters.AddParameter;
    mParameter.Name := parameterName; //这一句不能放到 begin ..end 后面
  end;
  mParameter.dataType := parameterType;
  mParameter.direction := parameterDirection;
  mParameter.value := parameterValue;
end;

//执行sql语句返回数据集
function TDA.Execute(var sErrorMsg: widestring): _Recordset;
begin
  try
    result := mADOCommand.Execute;
    sErrorMsg:=GetConnectionError(mADOCommand.Connection);
  except on e: Exception do
      sErrorMsg := e.Message;
  end;
end;

function TDA.Execute: _Recordset;
var  sErrorMsg:widestring;
begin
  try
    result := mADOCommand.Execute;
    sErrorMsg:=GetConnectionError(mADOCommand.Connection);
    if sErrorMsg<>'' then   raise Exception.Create(sErrorMsg);
  except on e: Exception do
      raise Exception.Create(e.Message);
  end;
end;

//执行sql语句返回数据集第一条记录的第一个字段值
function TDA.ExecuteScalar(var sErrorMsg: widestring): variant;
var
  mRecordSet: _RecordSet;
  returnValue: Variant;
begin
  try
    mRecordSet := mADOCommand.Execute;
    sErrorMsg:=GetConnectionError(mADOCommand.Connection);
    if sErrorMsg<>'' then
      raise exception.Create(sErrorMsg);

    if mRecordSet.RecordCount > 0 then
    begin
      mRecordSet.MoveFirst;
      result := mRecordSet.Fields[0].Value;
    end
    else
      result := returnValue;
  except on e: Exception do
      sErrorMsg := e.Message;
  end;
end;

function TDA.ExecuteScalar: variant;
var
  mRecordSet: _RecordSet;
  returnValue: Variant;
  sErrorMsg:widestring;
begin
  try
    mRecordSet := mADOCommand.Execute;
    sErrorMsg:=GetConnectionError(mADOCommand.Connection);
    if sErrorMsg<>'' then   raise Exception.Create(sErrorMsg);
    if mRecordSet.RecordCount > 0 then
    begin
      mRecordSet.MoveFirst;
      result := mRecordSet.Fields[0].Value;
    end
    else
      result := returnValue;
  except on e: Exception do
      raise Exception.Create(e.Message);
  end;
end;

//执行insert,delete,update等不需要返回记录集的sql语句
procedure TDA.ExecuteNonQuery(var sErrorMsg: widestring);
begin
  try
    mADOCommand.Execute;
    sErrorMsg:=GetConnectionError(mADOCommand.Connection);
  except on e: Exception do
      sErrorMsg := e.Message;
  end;
end;

procedure TDA.ExecuteNonQuery;
var
  sErrorMsg:widestring;
begin
  try
    mADOCommand.Execute;
    sErrorMsg:=GetConnectionError(mADOCommand.Connection);
    if sErrorMsg<>'' then   raise Exception.Create(sErrorMsg);
  except on e: Exception do
      raise Exception.Create(e.Message);
  end;
end;

function TDA.DataSet(var sErrorMsg: widestring; bNextRecordSet: boolean = false): TADODataSet;
var
  i: integer;
begin
  try
    if mADODataset = nil then
      mADODataset := TADODataset.create(nil);

    if not mAdoDataSet.Active then
    begin
      mADODataSet.Connection := mADOCommand.Connection;
      mADODataSet.CommandTimeout := mADOCommand.CommandTimeout;
      mADODataSet.CommandText := mADOCommand.CommandText;
      mADODataSet.CommandType := mADOCommand.CommandType;
      mADODataSet.Parameters := mADOCommand.Parameters;
      mADODataSet.Open;
    end;

    if mADODataSet.Connection.Errors.Count > 0 then
      raise Exception.Create(GetConnectionError(mADODataSet.Connection));

    if bNextRecordSet then
      mAdoDataSet.Recordset := mAdoDataSet.NextRecordset(i);

    result := mADODataSet;
  except
    on e: Exception do
    begin
      result := nil;
      sErrorMsg := e.Message;
    end;
  end;
end;

function TDA.DataSet(bNextRecordSet: boolean = false): TADODataSet;
var
  i: integer;
begin
  if mADODataset = nil then
    mADODataset := TADODataset.create(nil);
  try
    if not mAdoDataSet.Active then
    begin
      mADODataSet.Connection := mADOCommand.Connection;
      mADODataSet.CommandTimeout := mADOCommand.CommandTimeout;
      mADODataSet.CommandText := mADOCommand.CommandText;
      mADODataSet.CommandType := mADOCommand.CommandType;
      mADODataSet.Parameters := mADOCommand.Parameters;
      mADODataSet.Open;
    end;
    if bNextRecordSet then
      mAdoDataSet.Recordset := mAdoDataSet.NextRecordset(i);
    result := mADODataSet;
  except on e: Exception do
      raise Exception.Create(e.Message);
  end;

end;

procedure TDA.ApplyUpdate(datasetProvider: TDataSetProvider;
  delta: OleVariant; var sErrorMsg: widestring);
var
  iErrorCount: integer;
begin
  datasetProvider.OnUpdateError := DatasetProviderUpdateError;
  try
    datasetProvider.ApplyUpdates(delta, 0, iErrorCount);
  finally
    sErrorMsg := mErrorMessage
  end;
end;

procedure TDA.ApplyUpdate(datasetProvider: TDataSetProvider;
  delta: OleVariant; sql: Widestring; connection: TADOConnection;
  var sErrorMsg: widestring);
var
  tempAdoQuery: TAdoQuery;
begin
  tempAdoQuery := TADOQuery.Create(nil);
  tempAdoQuery.SQL.Add(sql);
  tempAdoQuery.Connection := connection;
  connection.DefaultDatabase :=GetDefaultDatabase(sql);
  datasetProvider.DataSet := tempAdoQuery;
  ApplyUpdate(datasetProvider, delta, sErrorMsg);
  connection.DefaultDatabase :=GetoldDefaultDatabase(connection.ConnectionString);

end;

procedure TDA.ApplyUpdate(datasetProvider: TDataSetProvider;
  delta: OleVariant; sql,sKeyField: Widestring;
  connection: TADOConnection; var sErrorMsg: widestring);
var
  i:integer;
  tempAdoQuery: TAdoQuery;
  KeyFieldLst:TStringList;
begin
  try
    tempAdoQuery := TADOQuery.Create(nil);
    datasetprovider.UpdateMode:=upWhereKeyOnly; //upWhereChanged;
    tempAdoQuery.SQL.Add(sql);
    tempAdoQuery.Connection := connection;
    connection.DefaultDatabase :=GetDefaultDatabase(sql);
    datasetProvider.DataSet := tempAdoQuery;
    //sKeyField为字段列表，字段之间以','分隔，如'PPO_NO,GF_NO'
    KeyFieldLst:=TStringList.create;
    sKeyField:=stringreplace(sKeyField,',',#13,[rfReplaceAll]);
    KeyFieldLst.Text:=sKeyField;

   //设置作为更新记录的KEY字段
    tempAdoQuery.Open;
    For i:=0 to KeyFieldLst.Count-1 do
      tempAdoQuery.FieldByName(KeyFieldLst.Strings[i]).ProviderFlags := [pfInUpdate, pfInWhere, pfInKey];

    ApplyUpdate(datasetProvider, delta, sErrorMsg);
    connection.DefaultDatabase :=GetoldDefaultDatabase(connection.ConnectionString);
  finally
    datasetprovider.UpdateMode:=upWhereAll;
    FreeAndNil(tempAdoQuery);
    FreeAndNil(KeyFieldLst);
  end;
end;

function TDA.GetDefaultDatabase(sqlText: String): String;
var
  i:integer;
  tempChar,dbname,tmpSql:string;
begin
  sqlText:=Uppercase(sqlText);
  i:=pos('..',sqlText);
  if i=0  then
    i:=pos('.DBO.',sqlText);
  if i=0 then
    dbname:='';
  if i>0 then
  begin
    tmpSql:=copy(sqlText,0,i-1);
    dbname:='';
    i:=length(tmpSql);
    while (i>=1) do
    begin
       tempChar:=copy(tmpSql,i,1);
       i:=i-1;
       if tempChar<>' ' then
         dbname:=tempChar+dbname
       else
         break;
    end;
  end;
  result:=dbname;
end;

function TDA.GetOldDefaultDatabase(connectionString: string): String;
var i,j:integer;
begin
  i:=pos('Initial Catalog=',connectionString);
  j:=pos(';Data Source=',connectionString);
  result:=copy(connectionString,i+16,j-i-16);
end;

procedure TDA.DatasetProviderUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
  mErrorMessage := '';
  if e.ErrorCode <> 0 then
  begin
    mErrorMessage := 'Error Code: ' + inttostr(e.ErrorCode) + #10 + #13 + 'Description: ' + e.Message;
  end
end;

//***********************下面是所有属性设置******************************//
function TDA.GetCommandText: string;
begin
  // TODO -cMM: TDA.GetName default body inserted
  Result := mADOCommand.CommandText;
end;
  
procedure TDA.SetCommandText(const Value: string);
begin
  // TODO -cMM: TDA.SetName default body inserted
  mADOCommand.CommandText := Value;
end;

function TDA.GetCommand: TADOCommand;
begin
  // TODO -cMM: TDA.GetCommand default body inserted
  Result := mADOCommand;
end;

function TDA.GetConnection: TADOConnection;
begin
  // TODO -cMM: TDA.GetConnection default body inserted
  Result := mADOCommand.Connection;
end;

procedure TDA.SetConnection(Value: TADOConnection);
begin
  // TODO -cMM: TDA.SetConnection default body inserted
  mADOCommand.Connection := value;
end;

function TDA.GetParameters: TParameters;
begin
  // TODO -cMM: TDA.GetParameters default body inserted
  Result := mADOCommand.Parameters;
end;

function TDA.GetTimeOut: Integer;
begin
  // TODO -cMM: TDA.GetTimeOut default body inserted
  Result := mADOCommand.CommandTimeout;
end;

procedure TDA.SetTimeOut(Value: Integer);
begin
  // TODO -cMM: TDA.SetTimeOut default body inserted
  mADOCommand.CommandTimeout := Value;
end;

function TDA.GetCommandType: TCommandType;
begin
  result := mADOCommand.CommandType;
end;

procedure TDA.SetCommandType(const Value: TCommandType);
begin
  mADOCommand.CommandType := value;
end;

//获取参数值
function TDA.GetParameterValue(parameterName: string): variant;
var mParameter: TParameter;
begin
  mParameter := mADOCommand.Parameters.FindParam(parameterName);
  if mParameter = nil then
    raise Exception.Create('Parameter:' + parameterName + ' not found!')
  else
    result := mParameter.Value;
end;

procedure TDA.SetParameterValue(parameterName: string;
  parameterValue: variant);
var mParameter: TParameter;
begin
  mParameter := mADOCommand.Parameters.FindParam(parameterName);
  if mParameter = nil then
    raise Exception.Create('Parameter:' + parameterName + ' not found!')
  else
    mParameter.Value := parameterValue;
end;

function TDA.GetParameterDirection(
  parameterName: string): TParameterDirection;
var mParameter: TParameter;
begin
  mParameter := mADOCommand.Parameters.FindParam(parameterName);
  if mParameter = nil then
    raise Exception.Create('Parameter:' + parameterName + ' not found!')
  else
    result := mParameter.Direction;
end;

procedure TDA.SetParameterDirection(parameterName: string;
  parameterDirection: TParameterDirection);
var mParameter: TParameter;
begin
  mParameter := mADOCommand.Parameters.FindParam(parameterName);
  if mParameter = nil then
    raise Exception.Create('Parameter:' + parameterName + ' not found!')
  else
    mParameter.Direction := parameterDirection;
end;

function TDA.GetParameterType(
  parameterName: string): TFieldType;
var mParameter: TParameter;
begin
  mParameter := mADOCommand.Parameters.FindParam(parameterName);
  if mParameter = nil then
    raise Exception.Create('Parameter:' + parameterName + ' not found!')
  else
    result := mParameter.DataType;
end;

procedure TDA.SetParameterType(parameterName: string;
  parameterType: TFieldType);
var mParameter: TParameter;
begin
  mParameter := mADOCommand.Parameters.FindParam(parameterName);
  if mParameter = nil then
    raise Exception.Create('Parameter:' + parameterName + ' not found!')
  else
    mParameter.DataType := parameterType;
end;

function TDA.GetConnectionError(adoConnection: TADOConnection): string;
var
  sErrorMsg:widestring;
  i:integer;
begin
  sErrorMsg:='';
  if adoConnection.Errors.Count >0 then
  begin
    for i:=0 to adoConnection.Errors.Count-1 Do
      sErrorMsg:=sErrorMsg+adoConnection.Errors[i].Description +#13;
  end;
  result:=sErrorMsg;
end;

{
--------------------------------------------------------------------------------
使用方法举例：
1）返回记录集 或 数据集

procedure TForm1.Button1Click(Sender: TObject);
var cdb :TDA;
    sqlText:string;
    mAdoQuery:TADOQuery;
begin
        mAdoQuery:=TADOQuery.create(nil);
        sqlText:='usp_StroProcName';

        cdb:=TDA.Create(sqlText,cmdStoredProc,adoConnection1);

        //也可以这样创建
        // cdb:=TDA.Create();
        // cdb.CommandText:=sqlTest;
        // cdb.CommandType:=cmdStoredProc;
        // cdb.Connection:=adoConnection1;


        cdb.AddParameter('@parameter1',ftString,edit1.text,pdInput);
        cdb.AddParameter('@parameter2',ftInteger,4,pdInput);
        cdb.AddParameter('@parameter3',ftString,'',pdOutput);

        mAdoQuery.recordset:=cdb.Execute; //获取记录集

        datasoruce1.dataset:=cdb.DataSet; //返回数据集

        datasetProvider.dataset:=cdb.DataSet; //DatasetProvider.dataset

        //获取参数值值
        edit2.text:=cdb.GetParameterValue('@parameter3');

end;


2）返回字段值

procedure TForm1.Button1Click(Sender: TObject);
var cdb :DA;
    sqlText:string;
begin

   sqlText:='select fname from employee where emp_id=:emp_id';  //可以是存储过程
   cdb:=TDA.Create(sqlText,cmdText,adoConnection1);
   cdb.AddParameter('emp_id',ftString,edit1.text,pdInput);
   edit1.text:=cdb.executescalar;

   cdb.CommandText:='select currtime=Getdate()';
   edit2.text:=cdb.executescalar;
end;

3) 执行sql语句

procedure TForm1.Button1Click(Sender: TObject);
var cdb :TDA;
    sqlText:string;
begin

        sqlText:='delete from employee where emp_id=:emp_id';  //可以是存储过程
        cdb:=TDA.Create(sqlText,cmdText,adoConnection1);
        cdb.AddParameter('emp_id',ftString,edit1.text,pdInput);
        cdb.executenonquery;

//下面通过替换参数值，执行sql语句的方法，可以在循环当中根据参数值多次调用执行 如下：

        cdb.SetParameterValue('emp_id','A'); //替换参数值
        cdb.executenonquery;

end;


4) 中间层datasetProvider applyupdate 方法

//如果在设计的时候DataSetProvider 已经邦定了一个dataset ,并且没有改变那么可以如
//下面一样直接调用该方法
procedure TDataAccess.SaveData(vData: OleVariant;
  var sErrorMsg: WideString);
var
     sqlText:string;
     cdb:TDA;
begin
       //datasetProvider 已经提供dataset
        cdb:=TDA.Create();
        try
          cdb.ApplyUpdate(datasetProvider,vData,sErrorMsg);
        except
          raise;
        end;
end;

//如果在设计时候datasetprovider有邦定dataset ，或动态创建的datasetprovider 等可以用
//下面方法调用
procedure TDataAccess.SaveData(vData: OleVariant;
  var sErrorMsg: WideString);
var
     sqlText:string;
     cdb:TDA;
begin
            //datasetProvider 还没有提供dataset
        sqlText:='SELECT * from employee where 1=2';
        cdb:=TDA.Create();
        try
          cdb.ApplyUpdate(datasetProvider,vData,sqlText,adoConnection,sErrorMsg);
        except
          raise;
        end;
end;
}
end.              

