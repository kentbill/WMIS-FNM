unit DA;
{*******************************************************************************
          Copyright (C) 2004-2005 ESQUEL GROUP IT DEPARTMENT
�ļ���: TDA
������: WLX
�� ��:  2004-5-31
�޸���:
�޸�����������
�޸�����:
�� ��: �����װ�˷���sqlserver���ݿ�ĳ�����ʽ�����Է������ݼ������Է���һ��
       ���ֶ�ֵ��Ҳ����ִ�г��õ�insert,delete ,update���� .ͬʱ�ṩ���ģʽ
       �� DatasetProvider.ApplyUpdate ͨ�÷�����
�� ��:  V 1.00
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

    procedure ExecuteNonQuery(var sErrorMsg: widestring); overload; //ִ��insert,delete,updaate�Ȳ���Ҫ��¼����sql���
    procedure ExecuteNonQuery(); overload;

    function ExecuteScalar(var sErrorMsg: widestring): variant; overload; //���ص�һ����¼��һ���ֶ�ֵ��һ��������ȡ�����ֶ�ֵ���������id�û�ȡ����
    function ExecuteScalar: variant; overload;

    function Execute(var sErrorMsg: widestring): _Recordset; overload; //���ؼ�¼��
    function Execute: _Recordset; overload;

    function DataSet(var sErrorMsg: widestring; bNextRecordSet: boolean = false): TADODataSet; overload;
    function DataSet(bNextRecordSet: boolean = false): TADODataSet; overload;

    procedure AddParameter(parameterName: string; parameterType: TFieldType; parameterValue: Variant; parameterDirection: TParameterDirection); //���ӻ��趨����ֵ�����͵�

    procedure ApplyUpdate(datasetProvider: TDataSetProvider; delta: OleVariant; var sErrorMsg: widestring); overload;
    procedure ApplyUpdate(datasetProvider: TDataSetProvider; delta: OleVariant; sql: Widestring; connection: TADOConnection; var sErrorMsg: widestring); overload;
    //��ָ�����ֶ���ΪUpdate KEY�������ݼ�
    procedure ApplyUpdate(datasetProvider: TDataSetProvider;delta: OleVariant; sql,sKeyField: Widestring;   connection: TADOConnection; var sErrorMsg: widestring); overload;

    function CheckParaByName(parameterName: string): boolean; //���һ�������Ƿ����
    function GetParameterValue(parameterName: string): variant; //���ز���ֵ
    procedure SetParameterValue(parameterName: string; parameterValue: variant); //�趨����ֵ
    function GetParameterType(parameterName: string): TFieldType; //���ز�������
    procedure SetParameterType(parameterName: string; parameterType: TFieldType); //�趨���ز�������
    function GetParameterDirection(parameterName: string): TParameterDirection; //���ز������ݷ���
    procedure SetParameterDirection(parameterName: string; parameterDirection: TParameterDirection); //���ز������ݷ���
    property CommandText: string read GetCommandText write SetCommandText; //��ȡ���趨ִ�е�sql���
    property CommandType: TCommandType read GetCommandType write SetCommandType; //��ȡ���趨sql������ͣ�cmdText,cmdStoredProc ...
    property Command: TADOCommand read GetCommand; //��ȡִ��sql����TADOCommand����
    property Connection: TADOConnection read GetConnection write SetConnection; //��ȡTADOCommand�����Ӷ���
    property Parameters: TParameters read GetParameters; //��ȡTADOCommand��Parameters����
    property TimeOut: Integer read GetTimeOut write SetTimeOut; //��ȡ���趨TADOCommand��CommandTimeOutʱ��
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

//���һ�������Ƿ����
function TDA.CheckParaByName(parameterName: string): boolean;
begin
  if mADOCommand.Parameters.FindParam(parameterName) = nil then
    result := false
  else
    result := true;
end;

// ��������Ѿ���������Ӳ��������ǻ��滻�����������
procedure TDA.AddParameter(parameterName: string;
  parameterType: TFieldType; parameterValue: Variant;
  parameterDirection: TParameterDirection);
var mParameter: TParameter;
begin
  mParameter := mADOCommand.Parameters.FindParam(parameterName);
  if mParameter = nil then //���ָ���Ĳ����������ڣ���Ӳ���
  begin
    mParameter := mADOCommand.Parameters.AddParameter;
    mParameter.Name := parameterName; //��һ�䲻�ܷŵ� begin ..end ����
  end;
  mParameter.dataType := parameterType;
  mParameter.direction := parameterDirection;
  mParameter.value := parameterValue;
end;

//ִ��sql��䷵�����ݼ�
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

//ִ��sql��䷵�����ݼ���һ����¼�ĵ�һ���ֶ�ֵ
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

//ִ��insert,delete,update�Ȳ���Ҫ���ؼ�¼����sql���
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
    //sKeyFieldΪ�ֶ��б��ֶ�֮����','�ָ�����'PPO_NO,GF_NO'
    KeyFieldLst:=TStringList.create;
    sKeyField:=stringreplace(sKeyField,',',#13,[rfReplaceAll]);
    KeyFieldLst.Text:=sKeyField;

   //������Ϊ���¼�¼��KEY�ֶ�
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

//***********************������������������******************************//
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

//��ȡ����ֵ
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
ʹ�÷���������
1�����ؼ�¼�� �� ���ݼ�

procedure TForm1.Button1Click(Sender: TObject);
var cdb :TDA;
    sqlText:string;
    mAdoQuery:TADOQuery;
begin
        mAdoQuery:=TADOQuery.create(nil);
        sqlText:='usp_StroProcName';

        cdb:=TDA.Create(sqlText,cmdStoredProc,adoConnection1);

        //Ҳ������������
        // cdb:=TDA.Create();
        // cdb.CommandText:=sqlTest;
        // cdb.CommandType:=cmdStoredProc;
        // cdb.Connection:=adoConnection1;


        cdb.AddParameter('@parameter1',ftString,edit1.text,pdInput);
        cdb.AddParameter('@parameter2',ftInteger,4,pdInput);
        cdb.AddParameter('@parameter3',ftString,'',pdOutput);

        mAdoQuery.recordset:=cdb.Execute; //��ȡ��¼��

        datasoruce1.dataset:=cdb.DataSet; //�������ݼ�

        datasetProvider.dataset:=cdb.DataSet; //DatasetProvider.dataset

        //��ȡ����ֵֵ
        edit2.text:=cdb.GetParameterValue('@parameter3');

end;


2�������ֶ�ֵ

procedure TForm1.Button1Click(Sender: TObject);
var cdb :DA;
    sqlText:string;
begin

   sqlText:='select fname from employee where emp_id=:emp_id';  //�����Ǵ洢����
   cdb:=TDA.Create(sqlText,cmdText,adoConnection1);
   cdb.AddParameter('emp_id',ftString,edit1.text,pdInput);
   edit1.text:=cdb.executescalar;

   cdb.CommandText:='select currtime=Getdate()';
   edit2.text:=cdb.executescalar;
end;

3) ִ��sql���

procedure TForm1.Button1Click(Sender: TObject);
var cdb :TDA;
    sqlText:string;
begin

        sqlText:='delete from employee where emp_id=:emp_id';  //�����Ǵ洢����
        cdb:=TDA.Create(sqlText,cmdText,adoConnection1);
        cdb.AddParameter('emp_id',ftString,edit1.text,pdInput);
        cdb.executenonquery;

//����ͨ���滻����ֵ��ִ��sql���ķ�����������ѭ�����и��ݲ���ֵ��ε���ִ�� ���£�

        cdb.SetParameterValue('emp_id','A'); //�滻����ֵ
        cdb.executenonquery;

end;


4) �м��datasetProvider applyupdate ����

//�������Ƶ�ʱ��DataSetProvider �Ѿ����һ��dataset ,����û�иı���ô������
//����һ��ֱ�ӵ��ø÷���
procedure TDataAccess.SaveData(vData: OleVariant;
  var sErrorMsg: WideString);
var
     sqlText:string;
     cdb:TDA;
begin
       //datasetProvider �Ѿ��ṩdataset
        cdb:=TDA.Create();
        try
          cdb.ApplyUpdate(datasetProvider,vData,sErrorMsg);
        except
          raise;
        end;
end;

//��������ʱ��datasetprovider�аdataset ����̬������datasetprovider �ȿ�����
//���淽������
procedure TDataAccess.SaveData(vData: OleVariant;
  var sErrorMsg: WideString);
var
     sqlText:string;
     cdb:TDA;
begin
            //datasetProvider ��û���ṩdataset
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

