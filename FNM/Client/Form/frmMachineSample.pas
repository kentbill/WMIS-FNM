unit frmMachineSample;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmMachineSample.pas                                          }
{       �������� 2004-8-26 13:50:57                                            }
{       ������Ա zhangjy                                                       }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       ��������  ��̨ȡ��                                                     }
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
  if key = 32 then  //�ո��
  begin
    cbbFabricNOList.DroppedDown := self.ActiveControl = cbbFabricNOList;
    cbbWorkerList.DroppedDown := self.ActiveControl = cbbWorkerList;
  end;
end;

end.
