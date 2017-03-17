unit UThirdDAOUpt;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComServ, ComObj, VCLCom, StdVcl, bdemts, DataBkr, DBClient,
  MtsRdm, Mtx, FNMDAO_TLB, DB, ADODB;

type
  TThirdDAOUpt = class(TMtsDataModule, IThirdDAOUpt)
    ADOConn_CSServer: TADOConnection;
    ADOConn_OTServer: TADOConnection;
    ADOConn_MONFonts: TADOConnection;
    procedure MtsDataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    procedure ExeCommonSql(const sServerTag, sSqlText: WideString;
      var sErrorMsg: WideString); safecall;
  public
    { Public declarations }
  end;

var
  ThirdDAOUpt: TThirdDAOUpt;

implementation

uses
  Provider, ADOInt,
  DA, ComDllPub;

{$R *.DFM}

class procedure TThirdDAOUpt.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
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

procedure TThirdDAOUpt.MtsDataModuleCreate(Sender: TObject);
begin
  ADOConn_MONFonts.ConnectionString:='Provider=MSDASQL.1;Persist Security Info=False;Data Source=MONFonts';
  ADOConn_OTServer.ConnectionString:='Provider=SQLOLEDB.1;Password=123;Persist Security Info=True;User ID=SA;Initial Catalog=Orgatex2;Data Source=OT-SERVER';
  ADOConn_CSServer.ConnectionString:='Provider=SQLOLEDB.1;Password=cswrite2008;Persist Security Info=True;User ID=cswrite;Initial Catalog=csdlvsdb;Data Source=192.168.7.233\gew';
end;

procedure TThirdDAOUpt.ExeCommonSql(const sServerTag, sSqlText: WideString;
  var sErrorMsg: WideString);
var
  da:TDA;
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

  sErrorMsg:='';
  AdoConn.Connected:=True;
  AdoConn.BeginTrans;
  da:=TDA.Create(sSqlText, cmdText, AdoConn);
  try
    try
      da.ExecuteNonQuery(sErrorMsg);
      if sErrorMsg='' then setcomplete else SetAbort;
      AdoConn.CommitTrans;
    except
      on e:Exception do
      begin
        AdoConn.RollbackTrans;
        sErrorMsg:=e.Message;
        setabort;
      end;
    end;
  finally
    da.Free;
  end;
end;

initialization
  TComponentFactory.Create(ComServer, TThirdDAOUpt,
    Class_ThirdDAOUpt, ciMultiInstance, tmNeutral);
end.