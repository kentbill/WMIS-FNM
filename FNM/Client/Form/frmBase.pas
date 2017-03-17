{*******************************************************}
{                                                       }
{       ������� W.MIS CLIENT MODEL                     }
{       ��Ȩ���� (C) 2003, 2004 Esquel.IT               }
{       ��Ԫ���� frmBase.pas                            }
{       �������� 2004-8-3 9:36:30                       }
{       ������Ա wuwj                                   }
{                                                       }
{*******************************************************}

unit frmBase;
{* ����MDIChild����Ļ����嵥Ԫ��}

interface

uses
  UShowMessage,
  Windows, Messages, SysUtils, Variants, Classes, Controls, Forms;

type

  TActionTypeList=(atQuery,atPrint,atPrintPreview,atExportData,atSave);
  TActionTypeChangedEvent = procedure (Sender: TObject;
          actionType:TActionTypeList) of object;

  TBaseForm = class (TForm)
  {* ������}
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);

  private
    FActionType: TActionTypeList;
    FOnActionTypeChanged:TActionTypeChangedEvent;
    function GetActionType: TActionTypeList;
    procedure SetActionType(Value: TActionTypeList);
  protected
    procedure DoOnActionChanged(Sender:TObject;actionType:TActionTypeList);
    procedure ShowMsg(sMsg: string; cursor:TCursor=crDefault);
    procedure ActionChanged(Sender: TObject;actionType:TActionTypeList);
  Public
    Procedure PublicQuery;Virtual;
    Procedure PublicExport;Virtual;
    Procedure PublicSave;Virtual;
    Procedure PublicPrintPreview;Virtual;
    Procedure PublicPrint;Virtual;
  published
    property ActionType: TActionTypeList read GetActionType write SetActionType;
    property OnActionTypeChanged: TActionTypeChangedEvent read FOnActionTypeChanged write FOnActionTypeChanged ;
  end;

var
  BaseForm: TBaseForm;

implementation

{$R *.dfm}
procedure TBaseForm.DoOnActionChanged(Sender: TObject;
  actionType: TActionTypeList);
begin
 if Assigned(FOnActionTypeChanged) then
       FOnActionTypeChanged(Sender,actionType);
end;

procedure TBaseForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;


procedure TBaseForm.FormDestroy(Sender: TObject);
begin
  BaseForm:=nil;
end;

procedure TBaseForm.FormKeyPress(Sender: TObject; var Key: Char);
var
  s:string;
begin
  if key=#27 then//����û�������ESC����������ƶ����㣻
  begin
    Key:=#0;
    PerForm(WM_NEXTDLGCTL,1,0);
  end;

  if key=#13 then//����û�������Enter��������ǰ�ƶ����㣻
  begin
    if not ((ActiveControl.ClassNameIs('TDBGrid'))      or
       (ActiveControl.ClassNameIs('TMemo'))             or
       (ActiveControl.ClassNameIs('TdxTreeList'))       or
       (ActiveControl.ClassNameIs('TdxDBGrid'))         or
       (ActiveControl.ClassNameIs('TcxGridSite'))       or
       (ActiveControl.ClassNameIs('TDBMemo'))           or
       (ActiveControl.ClassNameIs('TcxCustomInnerMemo'))or
       (ActiveControl.ClassNameIs('TListBox'))          or
       (ActiveControl.ClassNameIs('TValueListEditor'))  or
       (ActiveControl.ClassNameIs('TListView')))  then
    begin
      Key:=#0;
      PerForm(WM_NEXTDLGCTL,0,0);
    end;
  end;
end;

function TBaseForm.GetActionType: TActionTypeList;
begin
  Result := FActionType;
end;

procedure TBaseForm.SetActionType(Value: TActionTypeList);
begin
  FActionType := Value;
  DoOnActionChanged(self,value);
end;

procedure TBaseForm.FormCreate(Sender: TObject);
begin
  BaseForm:=self;
  Self.Position :=poDefault;
  self.OnActionTypeChanged :=ActionChanged;
end;

procedure TBaseForm.ActionChanged(Sender: TObject;actionType:TActionTypeList);
begin
  case actionType of
    atQuery:        PublicQuery ;
    atExportData:   PublicExport;
    atSave:         PublicSave;
    atPrintPreview: PublicPrintPreview;
    atPrint:        PublicPrint;
  end;
end;

Procedure TBaseForm.PublicQuery;
begin
end;
Procedure TBaseForm.PublicExport;
begin
end;
Procedure TBaseForm.PublicSave;
begin
end;
Procedure TBaseForm.PublicPrintPreview;
begin
end;
Procedure TBaseForm.PublicPrint;
begin
end;
procedure TBaseForm.ShowMsg(sMsg: string; cursor: TCursor);
begin
  ShowStatusMessage(sMsg,cursor);
  //TStatusBarMessage.ShowMessageOnMainStatsusBar(sMsg,cursor);
end;

end.


