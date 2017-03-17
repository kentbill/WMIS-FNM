unit frmMachineSample;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmMachineSample.pas                                          }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  机台取样                                                     }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, ExtCtrls, ComCtrls;

type
  TMachineSampleForm = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    Label1: TLabel;
    edtOperation: TEdit;
    edtSampleName: TEdit;
    edtPlanQuantity: TEdit;
    edtFactQuantity: TEdit;
    cbbWorkerList: TComboBox;
    cbbFabricNOList: TComboBox;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MachineSampleForm: TMachineSampleForm;

implementation

{$R *.dfm}

procedure TMachineSampleForm.FormDestroy(Sender: TObject);
begin
  MachineSampleForm := nil;
end;

procedure TMachineSampleForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMachineSampleForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 32 then  //空格键
  begin
    cbbFabricNOList.DroppedDown := self.ActiveControl = cbbFabricNOList;
    cbbWorkerList.DroppedDown := self.ActiveControl = cbbWorkerList;
  end;
end;

end.
