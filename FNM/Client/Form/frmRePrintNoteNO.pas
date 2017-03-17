unit frmRePrintNoteNO;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmRePrintNoteNO.pas                                          }
{       创建日期 2004-8-31 15:35:04                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述 重打单据(后整分箱卡,送布单)                                         }
{                                                                              }
{******************************************************************************}


interface

uses
  UAppOption,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, Math, StrUtils, DB,
  DBClient;

type
  TRePrintNoteNOForm = class(TForm)
    btnCancel: TBitBtn;
    btnPrint: TBitBtn;
    lblCarNO: TLabel;
    lblNoteNO: TLabel;
    edtCarNO: TEdit;
    cbbNoteNO: TComboBox;
    bvl2: TBevel;
    btnPreview: TBitBtn;
    cbbType: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtNoteNOChange(Sender: TObject);
    procedure cbbType0Select(Sender: TObject);
    procedure cbbNoteNOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCarNOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPreviewClick(Sender: TObject);
    procedure cbbTypeClick(Sender: TObject);
  private
    { Private declarations }
{* -----------------------------------------------------------------------------
   过程名称 SetConstraint
   创建人员 zhangjy
   创建日期 2004-8-31 15:36:24
   参数列表
   返回值   None
   功能描述 设置Edit的约束
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure SetConstraint;
{* -----------------------------------------------------------------------------
   过程名称 CheckEditText
   创建人员 zhangjy
   创建日期 2004-8-31 15:37:04
   参数列表
   返回值   None
   功能描述 Edit的数据检测
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    function CheckEditText:Boolean;
{* -----------------------------------------------------------------------------
   过程名称 PrintNoteNO
   创建人员 zhangjy
   创建日期 2004-8-31 15:37:35
   参数列表 Index: Integer
   返回值   None
   功能描述 打印单据(PrintFNCard--后整卡,PrintSendNO--送布单号)
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure PrintFNCard(Preview:Boolean);
    procedure PrintHLCard(Preview:Boolean);
    procedure PrintSendNO(Preview:Boolean);
    procedure PrintRecipeNO(Preview:Boolean);
    procedure PrintCPBRecipe(Preview:Boolean);
    procedure PrintNoteNO(Index: Integer; Preview:Boolean);
  public
    { Public declarations }
  end;

var
  RePrintNoteNOForm: TRePrintNoteNOForm;

implementation

uses ServerDllPub, uGlobal,UShowMessage, uLogin, rptSendInfo,rptFNCard, uDictionary,
  rptHLCard, rptRecipe, rptCPB ;

{$R *.dfm}

procedure TRePrintNoteNOForm.SetConstraint;
begin
  Screen.Cursor := crHourGlass;
  lblNoteNO.Caption := cbbType.Items[cbbType.ItemIndex] + ':';
  cbbNoteNO.Clear;
  cbbNoteNO.MaxLength := IfThen(cbbType.ItemIndex = 0, 9, 12);
  if (cbbType.ItemIndex = 1) or (cbbType.ItemIndex = 2)  then
    cbbNoteNO.Items.Text := Dictionary.GetItemList(cbbType.Items[cbbType.ItemIndex],Login.CurrentDepartment,'');
  edtCarNO.Enabled := cbbType.ItemIndex < 3;
  edtCarNO.Color := clWindow;
  edtCarNO.ParentColor := cbbType.ItemIndex > 2;
  lblCarNO.Enabled := edtCarNO.Enabled ;
  cbbNoteNO.SetFocus;
  Screen.Cursor := crDefault;
end;

function TRePrintNoteNOForm.CheckEditText():Boolean;
begin
  result := False;
  if cbbNoteNO.Text ='' then
  begin
    TMsgDialog.ShowMsgDialog('请输入' + cbbType.Items[cbbType.ItemIndex],2);
    Exit;
  end;
  result := True;
end;

procedure TRePrintNoteNOForm.PrintNoteNO(Index: Integer; Preview:Boolean);
begin
  case Index of
    0,1: PrintFNCard(Preview);
    2: PrintHLCard(Preview);
    3: PrintSendNO(Preview);
    4: PrintRecipeNO(Preview);
    5,6,7: PrintCPBRecipe(Preview);
  end;
end;

procedure TRePrintNoteNOForm.PrintFNCard(Preview:Boolean);
var
  sFN_Card,sCar_NO: string;
begin //打卡
  sFN_Card := Ifthen(cbbType.ItemIndex=0, LeftStr(Trim(cbbNoteNO.Text), 9), cbbNoteNO.Text);
  sCar_NO := Trim(edtCarNO.Text);
  rptFNCard.PrintFNCard(sFN_Card, sCar_NO, 1, Preview)
end;

procedure TRePrintNoteNOForm.PrintHLCard(Preview:Boolean);
var
  sHL_Card, sCar_NO: string;
begin //打手织板
  if not assigned(HLCardReport) then
    HLCardReport := THLCardReport.Create(self);
  sHL_Card := Ifthen(cbbType.ItemIndex=0, LeftStr(Trim(cbbNoteNO.Text), 9), cbbNoteNO.Text);
  sCar_NO := Trim(edtCarNO.Text);

  HLCardReport.PreviewReport(sHL_Card, sCar_NO,Preview);
end;

procedure TRePrintNoteNOForm.PrintSendNO(Preview:Boolean);
begin
  //打印送布单
  if not Assigned(SendInfoReport) then
  SendInfoReport := TSendInfoReport.Create(nil);
  SendInfoReport.PreviewReport(Trim(cbbNoteNO.Text),Preview);
end;

procedure TRePrintNoteNOForm.PrintRecipeNO(Preview: Boolean);
begin
  //打印配方单号
  PreViewRecipeReport(Trim(cbbNoteNO.Text),Preview);
end;
procedure TRePrintNoteNOForm.PrintCPBRecipe(Preview: Boolean);
begin
  if not Assigned(CPBReport) then
    CPBReport := TCPBReport.Create(nil);

  case cbbType.ItemIndex of
    5:CPBReport.PreviewReport(Trim(cbbNoteNO.Text),Preview);
    6:begin
        CPBReport.sOKType := '内部OK';
        CPBReport.PreivewCPBOKRecipeReport(cbbNoteNO.Text,Preview);
        CPBReport.Close;
      end;
    7:begin                                                       
        CPBReport.sOKType := '客户OK';
        CPBReport.PreivewCPBOKRecipeReport(cbbNoteNO.Text,Preview);
        CPBReport.Close;
      end;
  end;    
end;

procedure TRePrintNoteNOForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TRePrintNoteNOForm.FormDestroy(Sender: TObject);
begin
  RePrintNoteNOForm := nil;
end;

procedure TRePrintNoteNOForm.btnPreviewClick(Sender: TObject);
begin
  if not CheckEditText then Exit;
  PrintNoteNO(cbbType.ItemIndex,True);
end;

procedure TRePrintNoteNOForm.btnPrintClick(Sender: TObject);
begin
  if not CheckEditText then Exit;
  PrintNoteNO(cbbType.ItemIndex,False);
end;

procedure TRePrintNoteNOForm.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TRePrintNoteNOForm.edtNoteNOChange(Sender: TObject);
begin
  btnPrint.Enabled := cbbNoteNO.Text<>'';
end;

procedure TRePrintNoteNOForm.cbbType0Select(Sender: TObject);
begin
  SetConstraint;
end;

procedure TRePrintNoteNOForm.cbbNoteNOKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if (Key=13) then
   if edtCarNO.Enabled then
     edtCarNO.SetFocus
   else
     btnPrint.SetFocus;
end;

procedure TRePrintNoteNOForm.edtCarNOKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=13) then
    btnPrint.SetFocus;
end;

procedure TRePrintNoteNOForm.cbbTypeClick(Sender: TObject);
begin
  SetConstraint;
end;

end.
