unit frmOTD;

{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmOTD.pas                                                    }
{       创建日期 2004-11-12 10:14:51                                           }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述                                                               }
{                                                                              }
{******************************************************************************}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, DB, DBClient, DBCtrls,
  Mask,StrUtils, frmBase, Grids, DBGrids;

type
  TOTDForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnClose: TBitBtn;
    btnQuery: TBitBtn;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    dtpBegin_Date: TDateTimePicker;
    lbl4: TLabel;
    dtpEnd_Date: TDateTimePicker;
    chkStatus: TCheckBox;
    bvl1: TBevel;
    cdsOTDStat: TClientDataSet;
    dsOTDStat: TDataSource;
    dbedtDelayed: TDBEdit;
    dbedtWhite: TDBEdit;
    dbedtBleach: TDBEdit;
    dbedtTotal: TDBEdit;
    dbmmoRemark: TDBMemo;
    dbedtUnFinished: TDBEdit;
    lbl5: TLabel;
    cbbCurrentDept: TComboBox;
    DBText1: TDBText;
    lbType: TLabel;
    cbbType: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure cbbTypeChange(Sender: TObject);
  private
    { Private declarations }
     procedure GetOTDStatInfo();
     procedure GetData();
  public
    { Public declarations }
  end;

var
  OTDForm: TOTDForm;

implementation

uses ServerDllPub, uGlobal, uShowMessage,uLogin,uAppOption, frmMain, uDictionary;
{$R *.dfm}
procedure TOTDForm.GetData();
begin
  GetOTDStatInfo();
end;

procedure TOTDForm.GetOTDStatInfo();
var vData: OleVariant;
    sBegin_Date,sEnd_Date: string;
    sErrorMsg: WideString;
    sCondition, sCurrentDepartment,sQuery_Type: string;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
     //获取OTD的统计信息
    sBegin_Date := DateToStr(dtpBegin_Date.Date);
    sEnd_Date := DateToStr(dtpEnd_Date.Date);
    sQuery_Type := Ifthen(chkStatus.Checked,'1','0');
    sCurrentDepartment := copy(cbbCurrentDept.Text,1,pos('->',cbbCurrentDept.Text)-1);

    sCondition := QuotedStr(sBegin_Date)+','+ QuotedStr(sEnd_Date)+','+
                  QuotedStr(sCurrentDepartment)+','+ QuotedStr(sQuery_Type)+',2';
    FNMServerObj.GetQueryData(vData,'GetOTDStat',sCondition,sErrorMsg);
//    FNMServerObj.GetOTDInfo(vData,sBegin_Date,sEnd_Date,sQuery_Type,sCurrentDepartment,2,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsOTDStat.Data := vData;
    if cdsOTDStat.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有相应的数据,请重新查询',1);
      Exit;
    end;
    cbbTypeChange(Self);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TOTDForm.FormCreate(Sender: TObject);
begin
  dtpBegin_Date.Date := Date()-1;
  dtpEnd_Date.Date := Date();
  TGlobal.FillComboBoxFromDataSet(Dictionary.cds_DepartmentList,'Department','Description','->',cbbCurrentDept);
  cbbCurrentDept.Text := FNMMainForm.cbbCurrentDept.Text;
end;

procedure TOTDForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TOTDForm.FormDestroy(Sender: TObject);
begin
  OTDForm := nil;
end;

procedure TOTDForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TOTDForm.btnQueryClick(Sender: TObject);
begin
  GetData();
end;

procedure TOTDForm.cbbTypeChange(Sender: TObject);
begin
  cdsOTDStat.Filtered := False;
  cdsOTDStat.Filter := 'Ppo_Type = ' + QuotedStr(cbbType.Text);
  cdsOTDStat.Filtered := True;
end;

end.

