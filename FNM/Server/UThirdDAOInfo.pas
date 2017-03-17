unit UThirdDAOInfo;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComServ, ComObj, VCLCom, StdVcl, bdemts, DataBkr, DBClient,
  MtsRdm, Mtx, FNMDAO_TLB, Provider, DB, ADODB;

type
  TThirdDAOInfo = class(TMtsDataModule, IThirdDAOInfo)
    DataSetProvider: TDataSetProvider;
    ADOConn_MONFonts: TADOConnection;
    ADOConn_OTServer: TADOConnection;
    ADOConn_CSServer: TADOConnection;
    procedure MtsDataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    procedure GetCommonDataSet(const sServerTag, sSqlText: WideString;
      var vData: OleVariant; var sErrorMsg: WideString); safecall;
    {* 该方法实现一些通用的获取数据集的方法，最常见的是提供一个sql语句，返回数据集。}
  public
    { Public declarations }
  end;

var
  ThirdDAOInfo: TThirdDAOInfo;

implementation

uses
  DA;

{$R *.DFM}

class procedure TThirdDAOInfo.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
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

procedure TThirdDAOInfo.MtsDataModuleCreate(Sender: TObject);
begin
  ADOConn_MONFonts.ConnectionString:='Provider=MSDASQL.1;Persist Security Info=False;Data Source=MONFonts';
  ADOConn_OTServer.ConnectionString:='Provider=SQLOLEDB.1;Password=123;Persist Security Info=True;User ID=SA;Initial Catalog=Orgatex2;Data Source=OT-SERVER';
  ADOConn_CSServer.ConnectionString:='Provider=SQLOLEDB.1;Password=cswrite2008;Persist Security Info=True;User ID=cswrite;Initial Catalog=csdlvsdb;Data Source=CS-DLVS';
end;

procedure TThirdDAOInfo.GetCommonDataSet(const sServerTag,
  sSqlText: WideString; var vData: OleVariant; var sErrorMsg: WideString);
var
  da: TDA;
  AdoConn: TADOConnection;
begin
  if sServerTag = 'OT-Server' then
    AdoConn:=ADOConn_OTServer
  else if sServerTag = 'Monforts' then
    AdoConn:=ADOConn_MONFonts
  else if sServerTag = 'CSServer' then
    AdoConn:=ADOConn_CSServer
  else
  begin
    sErrorMsg:='无效的数据库连接';
    Exit;
  end;

  da:=TDA.Create(sSqlText, cmdText, AdoConn);
  try
    try
      DataSetProvider.DataSet := da.DataSet(sErrorMsg);
      if sErrorMsg = '' then
      begin
        vData:=DataSetProvider.Data;
        Setcomplete;
      end
      else
        Setabort;
    except
      on e: Exception do
      begin
        sErrorMsg:=e.Message;
        Setabort;
      end
    end;
  finally
    FreeAndNil(da);
  end;
end;

initialization
  TComponentFactory.Create(ComServer, TThirdDAOInfo,
    Class_ThirdDAOInfo, ciMultiInstance, tmNeutral);
end.