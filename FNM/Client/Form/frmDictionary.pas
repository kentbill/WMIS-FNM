{*******************************************************}
{                                                       }
{       软件名称 W.MIS CLIENT MODEL                     }
{       版权所有 (C) 2003, 2004 Esquel.IT               }
{       单元名称 frmDictionary.pas                      }
{       创建日期 2004-8-3 10:54:06                      }
{       创建人员 luoty                                  }
{                                                       }
{*******************************************************}


unit frmDictionary;
{* 网页查询模块 }

interface

uses
  uShowMessage, Windows, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, ComCtrls, Buttons, ExtCtrls;

type
  TWebQueryForm = class(TForm)
    pnl1: TPanel;
    lblAddress: TLabel;
    cbbAddress: TComboBoxEx;
    btnQuery: TSpeedButton;
    btnStop: TSpeedButton;
    pnl2: TPanel;
    WebBrowser1: TWebBrowser;
    btnClose: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbAddressKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebQueryForm: TWebQueryForm;

implementation

uses ULogin;


{$R *.dfm}

procedure TWebQueryForm.FormActivate(Sender: TObject);
begin
  if CbbAddress.ItemIndex>1 then
  begin
    try
      WebBrowser1.Navigate(CbbAddress.Items[1] );
      CbbAddress.ItemIndex:=1 ;
    except
      on E:Exception do TMsgDialog.ShowMsgDialog(e.Message, mtError);
    end;
  end;
end;

procedure TWebQueryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;

end;

procedure TWebQueryForm.FormDestroy(Sender: TObject);
begin
  WebQueryForm:=nil;
end;

procedure TWebQueryForm.btnQueryClick(Sender: TObject);
begin
  try
    WebBrowser1.Navigate(CbbAddress.Text+'?UserID='+Login.LoginID );
  except
    on E:Exception do TMsgDialog.ShowMsgDialog(e.Message, mtError);
  end;

end;

procedure TWebQueryForm.btnStopClick(Sender: TObject);
begin
  self.Close ;
end;

procedure TWebQueryForm.FormCreate(Sender: TObject);
begin
       CbbAddress.Items.Add('http://192.168.7.70/wmis/datamaintenance/default.asp');
end;

procedure TWebQueryForm.cbbAddressKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then
    btnQuery.Click;
end;

procedure TWebQueryForm.btn2Click(Sender: TObject);
begin
  close;
end;

end.
